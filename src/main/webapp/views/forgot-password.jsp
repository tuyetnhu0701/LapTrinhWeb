<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quên mật khẩu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-5">
                <div class="card shadow-sm border-0">
                    <div class="card-header bg-primary text-white text-center py-3">
                        <h4 class="mb-0 fw-bold">KHÔI PHỤC MẬT KHẨU</h4>
                    </div>
                    <div class="card-body p-4">
                        <p class="text-muted text-center">Nhập địa chỉ email đã đăng ký tài khoản của bạn để nhận mã xác thực OTP.</p>

                        <c:if test="${alert != null}">
                            <div class="alert alert-danger">${alert}</div>
                        </c:if>

                        <form action="${pageContext.request.contextPath}/forgot-password" method="post">
                            <div class="mb-3">
                                <label class="form-label fw-semibold">Email của bạn</label>
                                <input type="email" name="email" class="form-control" placeholder="example@gmail.com" required>
                            </div>
                            <button type="submit" class="btn btn-primary w-100 fw-bold py-2">Gửi mã OTP</button>
                        </form>
                        <div class="text-center mt-3">
                            <a href="${pageContext.request.contextPath}/login" class="text-decoration-none">Quay lại Đăng nhập</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>