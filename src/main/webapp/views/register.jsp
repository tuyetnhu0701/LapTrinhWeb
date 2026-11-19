<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng ký tài khoản</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5 mb-5">
        <div class="row justify-content-center">
            <div class="col-md-5">
                <div class="card shadow-sm border-0">
                    <div class="card-header bg-primary text-white text-center py-3">
                        <h4 class="mb-0 fw-bold">ĐĂNG KÝ TÀI KHOẢN</h4>
                    </div>
                    <div class="card-body p-4">
                        <c:if test="${alert != null}">
                            <div class="alert alert-danger">${alert}</div>
                        </c:if>

                        <form action="${pageContext.request.contextPath}/register" method="post" class="needs-validation" novalidate>
                            <div class="mb-3">
                                <label class="form-label fw-semibold">Tài khoản (Username)</label>
                                <input type="text" name="username" class="form-control" required minlength="3">
                                <div class="invalid-feedback">Tài khoản phải có ít nhất 3 ký tự.</div>
                            </div>
                            <div class="mb-3">
                                <label class="form-label fw-semibold">Họ và tên</label>
                                <input type="text" name="fullname" class="form-control" required minlength="2">
                                <div class="invalid-feedback">Vui lòng nhập họ và tên hợp lệ.</div>
                            </div>
                            <div class="mb-3">
                                <label class="form-label fw-semibold">Email (Nhận mã OTP)</label>
                                <input type="email" name="email" class="form-control" required>
                                <div class="invalid-feedback">Vui lòng nhập đúng định dạng email (vd: abc@gmail.com).</div>
                            </div>
                            <div class="mb-3">
                                <label class="form-label fw-semibold">Số điện thoại</label>
                                <input type="tel" name="phone" class="form-control" pattern="0[0-9]{9}" required>
                                <div class="invalid-feedback">Số điện thoại phải gồm 10 chữ số và bắt đầu bằng số 0.</div>
                            </div>
                            <div class="mb-3">
                                <label class="form-label fw-semibold">Mật khẩu</label>
                                <div class="input-group has-validation">
                                    <input type="password" name="password" id="regPassword" class="form-control" required minlength="6">
                                    <button class="btn btn-outline-secondary" type="button" onclick="togglePassword('regPassword', this)">
                                        <i class="bi bi-eye"></i>
                                    </button>
                                    <div class="invalid-feedback">Mật khẩu phải có ít nhất 6 ký tự.</div>
                                </div>
                            </div>
                            <button type="submit" class="btn btn-primary w-100 fw-bold py-2">Đăng ký</button>
                        </form>
                        <div class="text-center mt-3">
                            Đã có tài khoản? <a href="${pageContext.request.contextPath}/login" class="text-decoration-none fw-semibold">Đăng nhập</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        function togglePassword(inputId, btn) {
            const input = document.getElementById(inputId);
            const icon = btn.querySelector('i');
            if (input.type === "password") {
                input.type = "text";
                icon.classList.replace("bi-eye", "bi-eye-slash");
            } else {
                input.type = "password";
                icon.classList.replace("bi-eye-slash", "bi-eye");
            }
        }
        (() => {
            'use strict';
            const forms = document.querySelectorAll('.needs-validation');
            Array.from(forms).forEach(form => {
                form.addEventListener('submit', event => {
                    if (!form.checkValidity()) {
                        event.preventDefault();
                        event.stopPropagation();
                    }
                    form.classList.add('was-validated');
                }, false);
            });
        })();
    </script>
</body>
</html>