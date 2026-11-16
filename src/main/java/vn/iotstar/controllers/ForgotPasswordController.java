package vn.iotstar.controllers;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.model.User;
import vn.iotstar.service.UserService;
import vn.iotstar.service.impl.UserServiceImpl;
import vn.iotstar.util.EmailUtil;
import vn.iotstar.util.PasswordUtil;

@WebServlet(urlPatterns = {"/forgot-password", "/reset-password"})
public class ForgotPasswordController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        if ("/forgot-password".equals(path)) {
            req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
        } else if ("/reset-password".equals(path)) {
            HttpSession session = req.getSession();
            Boolean verified = (Boolean) session.getAttribute("otp_verified");
            if (verified == null || !verified) {
                resp.sendRedirect(req.getContextPath() + "/forgot-password");
                return;
            }
            req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String path = req.getServletPath();

        if ("/forgot-password".equals(path)) {
            String email = req.getParameter("email");
            User user = userService.findByEmail(email);

            if (user == null) {
                req.setAttribute("alert", "Email này không tồn tại trong hệ thống!");
                req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
                return;
            }

            // Tạo OTP và gửi mail
            String otp = EmailUtil.getRandomOTP();
            long expiryTime = System.currentTimeMillis() + (5 * 60 * 1000); // 5 phút

            HttpSession session = req.getSession();
            session.setAttribute("otp_code", otp);
            session.setAttribute("otp_expiry", expiryTime);
            session.setAttribute("otp_email", email);
            session.setAttribute("otp_type", "FORGOT_PASSWORD");

            String subject = "Mã OTP khôi phục mật khẩu - ShoppingMVC";
            String body = "<h3>Xin chào " + user.getFullName() + ",</h3>"
                        + "<p>Bạn vừa yêu cầu đặt lại mật khẩu. Mã xác nhận OTP của bạn là: "
                        + "<b style='color:blue; font-size:20px;'>" + otp + "</b></p>"
                        + "<p><i>Lưu ý: Mã này có hiệu lực trong vòng 5 phút!</i></p>";
            EmailUtil.sendEmail(email, subject, body);

            resp.sendRedirect(req.getContextPath() + "/verify-otp");

        } else if ("/reset-password".equals(path)) {
            String newPassword = req.getParameter("newPassword");
            String confirmPassword = req.getParameter("confirmPassword");

            if (newPassword == null || !newPassword.equals(confirmPassword)) {
                req.setAttribute("alert", "Mật khẩu xác nhận không khớp!");
                req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
                return;
            }

            HttpSession session = req.getSession();
            String email = (String) session.getAttribute("otp_email");
            User user = userService.findByEmail(email);

            if (user != null) {
                // Mã hóa mật khẩu mới bằng BCrypt và lưu vào DB
                user.setPassWord(PasswordUtil.hashPassword(newPassword));
                userService.update(user);
            }

            // Dọn dẹp session
            session.removeAttribute("otp_email");
            session.removeAttribute("otp_verified");
            session.removeAttribute("otp_type");

            req.setAttribute("message", "Đổi mật khẩu thành công! Hãy đăng nhập với mật khẩu mới.");
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
        }
    }
}