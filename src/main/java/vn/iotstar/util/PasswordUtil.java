package vn.iotstar.util;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordUtil {

    // Băm mật khẩu trước khi lưu vào Database
    public static String hashPassword(String plainTextPassword) {
        return BCrypt.hashpw(plainTextPassword, BCrypt.gensalt(12));
    }

    // Kiểm tra mật khẩu người dùng nhập vào có khớp với chuỗi băm trong DB không
    public static boolean checkPassword(String plainTextPassword, String hashedPassword) {
        if (hashedPassword == null || !hashedPassword.startsWith("$2a$")) {
            // Hỗ trợ tài khoản cũ trong DB chưa được mã hóa (ví dụ '123') để không bị lỗi
            return plainTextPassword.equals(hashedPassword);
        }
        return BCrypt.checkpw(plainTextPassword, hashedPassword);
    }
}