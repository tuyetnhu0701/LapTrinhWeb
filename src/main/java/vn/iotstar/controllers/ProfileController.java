package vn.iotstar.controllers;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import vn.iotstar.model.User;
import vn.iotstar.service.UserService;
import vn.iotstar.service.impl.UserServiceImpl;
import vn.iotstar.util.CloudinaryUtil;
import vn.iotstar.util.EmailUtil;

@WebServlet(urlPatterns = { "/profile", "/profile/verify-otp" })
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024 * 1024 * 10,       // 10MB
    maxRequestSize = 1024 * 1024 * 50     // 50MB
)
public class ProfileController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String path = req.getServletPath();
        if ("/profile/verify-otp".equals(path)) {
            if (session.getAttribute("pendingProfileUser") == null) {
                resp.sendRedirect(req.getContextPath() + "/profile");
                return;
            }
            req.getRequestDispatcher("/views/verify-profile-otp.jsp").forward(req, resp);
            return;
        }

        req.getRequestDispatcher("/views/profile.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String path = req.getServletPath();
        if ("/profile/verify-otp".equals(path)) {
            handleVerifyOtp(req, resp, session);
        } else {
            handleUpdateProfile(req, resp, session);
        }
    }

    private void handleUpdateProfile(HttpServletRequest req, HttpServletResponse resp, HttpSession session)
            throws ServletException, IOException {
        User currentUser = (User) session.getAttribute("account");

        String fullName = req.getParameter("fullName");
        String phone = req.getParameter("phone");
        String newEmail = req.getParameter("email") != null ? req.getParameter("email").trim() : "";

        try {
            // 1. Upload ảnh đại diện lên Cloudinary nếu có chọn file mới
            String updatedAvatar = currentUser.getAvatar();
            Part avatarPart = req.getPart("avatar");
            if (avatarPart != null && avatarPart.getSize() > 0) {
                String imageUrl = CloudinaryUtil.uploadImage(avatarPart);
                if (imageUrl != null) {
                    updatedAvatar = imageUrl;
                }
            }

            // 2. Kiểm tra xem người dùng có đổi sang email mới hay không
            boolean isEmailChanged = !newEmail.equalsIgnoreCase(currentUser.getEmail());

            if (!isEmailChanged) {
                // Không đổi email 
                currentUser.setFullName(fullName);
                currentUser.setPhone(phone);
                currentUser.setAvatar(updatedAvatar);

                userService.update(currentUser);
                session.setAttribute("account", currentUser);

                req.setAttribute("message", "Cập nhật thông tin cá nhân thành công!");
                req.getRequestDispatcher("/views/profile.jsp").forward(req, resp);
            } else {
                // Đổi sang email mới -> Kiểm tra email mới đã tồn tại chưa
                if (userService.checkExistEmail(newEmail)) {
                    req.setAttribute("error", "Email mới này đã được tài khoản khác sử dụng!");
                    req.getRequestDispatcher("/views/profile.jsp").forward(req, resp);
                    return;
                }

                // Tạo bản sao tạm để chờ xác thực OTP 
                User pendingUser = new User();
                pendingUser.setId(currentUser.getId());
                pendingUser.setUserName(currentUser.getUserName());
                pendingUser.setPassWord(currentUser.getPassWord());
                pendingUser.setRoleid(currentUser.getRoleid());
                pendingUser.setCreatedDate(currentUser.getCreatedDate());
                pendingUser.setStatus(currentUser.getStatus());
                pendingUser.setFullName(fullName);
                pendingUser.setPhone(phone);
                pendingUser.setEmail(newEmail);
                pendingUser.setAvatar(updatedAvatar);

                // Sinh mã OTP và gửi tới EMAIL MỚI
                String otp = EmailUtil.getRandomOTP();
                String subject = "Mã OTP xác nhận đổi Email - ShoppingMVC";
                String body = "<h3>Xin chào " + fullName + ",</h3>"
                        + "<p>Bạn vừa yêu cầu cập nhật email mới cho tài khoản trên hệ thống <b>ShoppingMVC</b>.</p>"
                        + "<p>Mã OTP xác nhận của bạn là: <b style='font-size:20px; color:#0d6efd;'>" + otp + "</b></p>"
                        + "<p>Vui lòng nhập mã này để hoàn tất việc cập nhật hồ sơ.</p>";

                boolean isSent = EmailUtil.sendEmail(newEmail, subject, body);
                if (isSent) {
                    session.setAttribute("pendingProfileUser", pendingUser);
                    session.setAttribute("profileOtp", otp);
                    session.setAttribute("profileOtpExpire", System.currentTimeMillis() + 120 * 1000);
                    resp.sendRedirect(req.getContextPath() + "/profile/verify-otp");
                } else {
                    req.setAttribute("error", "Không thể gửi mã OTP tới email mới. Vui lòng thử lại!");
                    req.getRequestDispatcher("/views/profile.jsp").forward(req, resp);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Có lỗi xảy ra khi cập nhật: " + e.getMessage());
            req.getRequestDispatcher("/views/profile.jsp").forward(req, resp);
        }
    }

    private void handleVerifyOtp(HttpServletRequest req, HttpServletResponse resp, HttpSession session)
            throws ServletException, IOException {
        String inputOtp = req.getParameter("otp") != null ? req.getParameter("otp").trim() : "";
        String sessionOtp = (String) session.getAttribute("profileOtp");
        Long expireTime = (Long) session.getAttribute("profileOtpExpire");
        User pendingUser = (User) session.getAttribute("pendingProfileUser");

        if (pendingUser == null || sessionOtp == null) {
            resp.sendRedirect(req.getContextPath() + "/profile");
            return;
        }

        // Kiểm tra mã OTP đã hết hạn chưa
        if (expireTime == null || System.currentTimeMillis() > expireTime) {
            session.removeAttribute("profileOtp");
            session.removeAttribute("profileOtpExpire");
            req.setAttribute("error", "Mã OTP đã hết hạn! Vui lòng quay lại Hồ sơ để gửi lại mã mới.");
            req.getRequestDispatcher("/views/verify-profile-otp.jsp").forward(req, resp);
            return;
        }

        if (inputOtp.equals(sessionOtp)) {
            // Nhập đúng OTP -> Lưu chính thức vào DB và cập nhật Session
            userService.update(pendingUser);
            session.setAttribute("account", pendingUser);

            // Xóa dữ liệu tạm
            session.removeAttribute("pendingProfileUser");
            session.removeAttribute("profileOtp");
            session.removeAttribute("profileOtpExpire");

            req.setAttribute("message", "Xác thực OTP thành công! Hồ sơ và email mới đã được cập nhật.");
            req.getRequestDispatcher("/views/profile.jsp").forward(req, resp);
        } else {
            req.setAttribute("error", "Mã OTP không chính xác. Vui lòng kiểm tra lại email mới!");
            req.getRequestDispatcher("/views/verify-profile-otp.jsp").forward(req, resp);
        }
    }
}