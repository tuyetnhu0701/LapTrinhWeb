<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sửa Video Review</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm mb-4">
        <div class="container">
            <a class="navbar-brand fw-bold text-warning" href="${pageContext.request.contextPath}/home">🛍️ SHOPPING MVC</a>
            <div class="d-flex align-items-center">
                <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-light btn-sm me-2">🏠 Trang Chủ</a>
                <a href="${pageContext.request.contextPath}/video" class="btn btn-warning btn-sm fw-bold me-3">🎬 Kênh Video Của Tôi</a>
                <span class="text-white small me-3">Xin chào, <b>${sessionScope.account.fullName}</b></span>
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger btn-sm">Đăng xuất</a>
            </div>
        </div>
    </nav>

    <div class="container mt-5 mb-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card shadow">
                    <div class="card-header bg-warning text-dark fw-bold">
                        <h4 class="mb-0">Chỉnh Sửa Video</h4>
                    </div>
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/video/update" method="post" enctype="multipart/form-data" class="needs-validation" novalidate>
                            <input type="hidden" name="videoId" value="${vid.videoId}">

                            <div class="mb-3">
                                <label class="form-label">Tiêu đề Video</label>
                                <input type="text" class="form-control" name="title" value="${vid.title}" required minlength="5" maxlength="200">
                                <div class="invalid-feedback">Vui lòng nhập tiêu đề video (từ 5 đến 200 ký tự).</div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Ảnh bìa (Poster) mới</label>
                                <input type="file" class="form-control" name="poster" accept="image/*">
                                <small class="text-muted">Bỏ trống nếu muốn giữ nguyên ảnh cũ.</small>
                                <div class="mt-2">
                                    <img src="${pageContext.request.contextPath}/media?fname=${vid.poster}" width="150" class="img-thumbnail" alt="Ảnh hiện tại">
                                </div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">File Video (.mp4) mới</label>
                                <input type="file" class="form-control" name="videoUrl" accept="video/mp4">
                                <small class="text-muted">Bỏ trống nếu muốn giữ nguyên video cũ (Tối đa 50MB).</small>
                                <div class="mt-2 text-primary">Video hiện tại: <b>${vid.videoUrl}</b></div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Nội dung mô tả</label>
                                <textarea class="form-control" name="description" rows="4" required minlength="10">${vid.description}</textarea>
                                <div class="invalid-feedback">Vui lòng nhập nội dung mô tả (ít nhất 10 ký tự).</div>
                            </div>

                            <div class="mb-3 form-check">
                                <input type="checkbox" class="form-check-input" name="active" id="activeCheck" ${vid.active ? 'checked' : ''}>
                                <label class="form-check-label" for="activeCheck">Công khai video này</label>
                            </div>

                            <div class="text-end">
                                <a href="${pageContext.request.contextPath}/video" class="btn btn-secondary">Hủy bỏ</a>
                                <button type="submit" class="btn btn-warning fw-bold">Lưu Thay Đổi</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

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