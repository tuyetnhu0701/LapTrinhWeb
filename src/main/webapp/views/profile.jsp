<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông tin cá nhân</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-7 col-lg-6">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-primary text-white text-center py-3">
                    <h4 class="mb-0 fw-bold"><i class="bi bi-person-badge me-2"></i>HỒ SƠ CÁ NHÂN</h4>
                </div>
                <div class="card-body p-4">

                    <c:if test="${not empty message}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            ${message}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            ${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/profile" method="post"
                          enctype="multipart/form-data" class="needs-validation" novalidate>

                        <!-- Ảnh đại diện -->
                        <div class="text-center mb-4">
                            <c:choose>
                                <c:when test="${not empty sessionScope.account.avatar}">
                                    <img src="${sessionScope.account.avatar}" alt="Avatar"
                                         class="rounded-circle border shadow-sm object-fit-cover"
                                         style="width: 120px; height: 120px;">
                                </c:when>
                                <c:otherwise>
                                    <img src="https://via.placeholder.com/120?text=Avatar" alt="Avatar"
                                         class="rounded-circle border shadow-sm"
                                         style="width: 120px; height: 120px;">
                                </c:otherwise>
                            </c:choose>
                            <div class="mt-3">
                                <label for="avatar" class="form-label fw-semibold">Đổi ảnh đại diện</label>
                                <input type="file" id="avatar" name="avatar" class="form-control" accept="image/*">
                            </div>
                        </div>

                        <!-- Username -->
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Tên đăng nhập</label>
                            <input type="text" class="form-control bg-light" value="${sessionScope.account.userName}" readonly>
                        </div>

                        <!-- Fullname -->
                        <div class="mb-3">
                            <label for="fullName" class="form-label fw-semibold">Họ và tên</label>
                            <input type="text" id="fullName" name="fullName" class="form-control"
                                   value="${sessionScope.account.fullName}" required minlength="2">
                            <div class="invalid-feedback">Họ và tên phải có ít nhất 2 ký tự.</div>
                        </div>

                        <!-- Phone -->
                        <div class="mb-3">
                            <label for="phone" class="form-label fw-semibold">Số điện thoại</label>
                            <input type="tel" id="phone" name="phone" class="form-control"
                                   value="${sessionScope.account.phone}" required pattern="^0[0-9]{9}$">
                            <div class="invalid-feedback">Số điện thoại phải gồm 10 chữ số và bắt đầu bằng số 0.</div>
                        </div>

                        <!-- Email -->
                        <div class="mb-4">
                            <label for="email" class="form-label fw-semibold">Email</label>
                            <input type="email" id="email" name="email" class="form-control"
                                   value="${sessionScope.account.email}" required>
                            <div class="form-text">Nếu đổi sang email mới, hệ thống sẽ gửi mã OTP xác nhận.</div>
                            <div class="invalid-feedback">Vui lòng nhập địa chỉ email hợp lệ.</div>
                        </div>

                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-primary fw-semibold">
                                <i class="bi bi-save me-1"></i> Lưu thay đổi
                            </button>
                            <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary">
                                Quay lại trang chủ
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
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