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

@WebServlet(urlPatterns = "/verify-otp")
public class VerifyOtpController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String inputOtp = req.getParameter("otp");

        HttpSession session = req.getSession();
        String sessionOtp = (String) session.getAttribute("otp_code");
        Long expiryTime = (Long) session.getAttribute("otp_expiry");
        String email = (String) session.getAttribute("otp_email");
        String type = (String) session.getAttribute("otp_type");

        if (sessionOtp == null || expiryTime == null || email == null) {
            req.setAttribute("alert", "Phiên giao dịch đã hết hạn, vui lòng thực hiện lại!");
            req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
            return;
        }

        // 1. Kiểm tra thời gian hiệu lực 5 phút
        if (System.currentTimeMillis() > expiryTime) {
            req.setAttribute("alert", "Mã OTP đã hết hạn (quá 5 phút)! Vui lòng thực hiện lại.");
            req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
            return;
        }

        // 2. Kiểm tra mã OTP có khớp không
        if (!sessionOtp.equals(inputOtp != null ? inputOtp.trim() : "")) {
            req.setAttribute("alert", "Mã OTP không chính xác! Vui lòng kiểm tra lại email.");
            req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
            return;
        }

        // 3. Nếu OTP đúng và còn hạn
        if ("REGISTER".equals(type)) {
            User user = userService.findByEmail(email);
            if (user != null) {
                user.setStatus(1); // Kích hoạt tài khoản
                userService.update(user);
            }
            // Xóa OTP khỏi session
            session.removeAttribute("otp_code");
            session.removeAttribute("otp_expiry");
            
            req.setAttribute("message", "Kích hoạt tài khoản thành công! Mời bạn đăng nhập.");
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
        } else if ("FORGOT_PASSWORD".equals(type)) {
            // Đánh dấu đã xác thực OTP thành công để cho phép đổi mật khẩu
            session.setAttribute("otp_verified", true);
            session.removeAttribute("otp_code");
            resp.sendRedirect(req.getContextPath() + "/reset-password");
        }
    }
}