package vn.iotstar.util;

import java.util.Properties;
import java.util.Random;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class EmailUtil {

    // Tài khoản Gmail và Mật khẩu ứng dụng của bạn
    private static final String FROM_EMAIL = "tuyetnhu0701@gmail.com";
    private static final String APP_PASSWORD = "tuii uklj tppp ibym";

    // Hàm tạo ngẫu nhiên mã OTP 6 chữ số
    public static String getRandomOTP() {
        Random rnd = new Random();
        int number = rnd.nextInt(999999);
        return String.format("%06d", number);
    }

    // Hàm gửi email chứa mã OTP
    public static boolean sendEmail(String toEmail, String subject, String body) {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Authenticator auth = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                // Xóa khoảng trắng trong App Password để tránh lỗi xác thực
                return new PasswordAuthentication(FROM_EMAIL, APP_PASSWORD.replace(" ", ""));
            }
        };

        Session session = Session.getInstance(props, auth);

        try {
            MimeMessage msg = new MimeMessage(session);
            msg.addHeader("Content-type", "text/HTML; charset=UTF-8");
            msg.setFrom(new InternetAddress(FROM_EMAIL, "ShoppingMVC System"));
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail, false));
            msg.setSubject(subject, "UTF-8");
            msg.setContent(body, "text/html; charset=UTF-8");

            Transport.send(msg);
            return true;
        } catch (Exception e) {
            System.out.println("Loi gui email: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}