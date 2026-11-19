<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-5">
                <div class="card shadow-sm border-0">
                    <div class="card-header bg-primary text-white text-center py-3">
                        <h4 class="mb-0 fw-bold">ĐĂNG NHẬP HỆ THỐNG</h4>
                    </div>
                    <div class="card-body p-4">
                        <c:if test="${alert != null}">
                            <div class="alert alert-danger">${alert}</div>
                        </c:if>
                        <c:if test="${message != null}">
                            <div class="alert alert-success">${message}</div>
                        </c:if>

                        <form action="${pageContext.request.contextPath}/login" method="post" class="needs-validation" novalidate>
                            <div class="mb-3">
                                <label class="form-label fw-semibold">Tài khoản (Username)</label>
                                <input type="text" name="username" class="form-control" placeholder="Nhập tài khoản" required minlength="3">
                                <div class="invalid-feedback">Vui lòng nhập tài khoản (ít nhất 3 ký tự).</div>
                            </div>
                            <div class="mb-3">
                                <label class="form-label fw-semibold">Mật khẩu</label>
                                <div class="input-group has-validation">
                                    <input type="password" name="password" id="loginPassword" class="form-control" placeholder="Nhập mật khẩu" required minlength="3">
                                    <button class="btn btn-outline-secondary" type="button" onclick="togglePassword('loginPassword', this)">
                                        <i class="bi bi-eye"></i>
                                    </button>
                                    <div class="invalid-feedback">Vui lòng nhập mật khẩu (ít nhất 3 ký tự).</div>
                                </div>
                            </div>
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <div class="form-check">
                                    <input type="checkbox" name="remember" class="form-check-input" id="remember">
                                    <label class="form-check-label" for="remember">Nhớ mật khẩu</label>
                                </div>
                                <a href="${pageContext.request.contextPath}/forgot-password" class="text-decoration-none">Quên mật khẩu?</a>
                            </div>
                            <button type="submit" class="btn btn-primary w-100 fw-bold py-2">Đăng nhập</button>
                        </form>
                        <div class="text-center mt-3">
                            Chưa có tài khoản? <a href="${pageContext.request.contextPath}/register" class="text-decoration-none fw-semibold">Đăng ký ngay</a>
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