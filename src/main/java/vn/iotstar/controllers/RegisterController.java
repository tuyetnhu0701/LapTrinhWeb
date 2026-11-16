package vn.iotstar.controllers;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.service.UserService;
import vn.iotstar.service.impl.UserServiceImpl;
import vn.iotstar.util.EmailUtil;

@WebServlet(urlPatterns = "/register")
public class RegisterController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setCharacterEncoding("UTF-8");
        req.setCharacterEncoding("UTF-8");

        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String email = req.getParameter("email");
        String fullname = req.getParameter("fullname");
        String phone = req.getParameter("phone");

        UserService service = new UserServiceImpl();

        if (service.checkExistEmail(email)) {
            req.setAttribute("alert", "Email đã tồn tại!");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }
        if (service.checkExistUsername(username)) {
            req.setAttribute("alert", "Tài khoản đã tồn tại!");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }

        // Đăng ký tài khoản (lưu vào DB với mật khẩu đã băm và status = 0)
        boolean isSuccess = service.register(email, password, username, fullname, phone);
        if (isSuccess) {
            // Sinh mã OTP 6 số và thiết lập thời gian hiệu lực 5 phút
            String otp = EmailUtil.getRandomOTP();
            long expiryTime = System.currentTimeMillis() + (5 * 60 * 1000); // 5 phút

            HttpSession session = req.getSession();
            session.setAttribute("otp_code", otp);
            session.setAttribute("otp_expiry", expiryTime);
            session.setAttribute("otp_email", email);
            session.setAttribute("otp_type", "REGISTER"); // Phân biệt OTP đăng ký vs Quên MK

            // Gửi Email
            String subject = "Mã OTP kích hoạt tài khoản - ShoppingMVC";
            String body = "<h3>Xin chào " + fullname + ",</h3>"
                        + "<p>Cảm ơn bạn đã đăng ký tài khoản. Mã xác thực OTP của bạn là: "
                        + "<b style='color:red; font-size:20px;'>" + otp + "</b></p>"
                        + "<p><i>Lưu ý: Mã này chỉ có hiệu lực trong vòng 5 phút!</i></p>";
            EmailUtil.sendEmail(email, subject, body);

            // Chuyển sang trang nhập OTP
            resp.sendRedirect(req.getContextPath() + "/verify-otp");
        } else {
            req.setAttribute("alert", "Lỗi hệ thống, vui lòng thử lại!");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
        }
    }
}