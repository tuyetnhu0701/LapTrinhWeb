<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đặt lại mật khẩu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-5">
                <div class="card shadow-sm border-0">
                    <div class="card-header bg-primary text-white text-center py-3">
                        <h4 class="mb-0 fw-bold">ĐẶT LẠI MẬT KHẨU MỚI</h4>
                    </div>
                    <div class="card-body p-4">
                        <c:if test="${alert != null}">
                            <div class="alert alert-danger">${alert}</div>
                        </c:if>

                        <form action="${pageContext.request.contextPath}/reset-password" method="post">
                            <div class="mb-3">
                                <label class="form-label fw-semibold">Mật khẩu mới</label>
                                <div class="input-group">
                                    <input type="password" name="newPassword" id="newPassword" class="form-control" placeholder="Nhập mật khẩu mới" required>
                                    <button class="btn btn-outline-secondary" type="button" onclick="togglePassword('newPassword', this)">
                                        <i class="bi bi-eye"></i>
                                    </button>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label class="form-label fw-semibold">Nhập lại mật khẩu mới</label>
                                <div class="input-group">
                                    <input type="password" name="confirmPassword" id="confirmPassword" class="form-control" placeholder="Xác nhận mật khẩu mới" required>
                                    <button class="btn btn-outline-secondary" type="button" onclick="togglePassword('confirmPassword', this)">
                                        <i class="bi bi-eye"></i>
                                    </button>
                                </div>
                            </div>
                            <button type="submit" class="btn btn-primary w-100 fw-bold py-2">Cập nhật mật khẩu</button>
                        </form>
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
    </script>
</body>
</html>