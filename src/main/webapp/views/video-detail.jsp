<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${video.title}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
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

    <div class="container mt-4 mb-5">
        <div class="row justify-content-center">
            <div class="col-md-9">
                <!-- KHUNG PHÁT VIDEO CHUẨN HTML5 -->
                <div class="card shadow-sm">
                    <!-- Gọi MediaController để load file mp4 -->
                    <video controls autoplay width="100%" class="rounded-top" style="max-height: 500px; background: #000;">
                        <source src="${pageContext.request.contextPath}/media?fname=${video.videoUrl}" type="video/mp4">
                        Trình duyệt của bạn không hỗ trợ thẻ video.
                    </video>
                    
                    <div class="card-body">
                        <h3 class="card-title fw-bold">${video.title}</h3>
                        <div class="text-muted mb-3">
                            <span class="badge bg-danger">👁 ${video.views} lượt xem</span>
                            <span class="badge bg-info ms-2 text-dark">📅 <fmt:formatDate value="${video.postDate}" pattern="dd/MM/yyyy" /></span>
                            <span class="ms-2 badge bg-success">Tác giả: ${video.user.fullName}</span>
                        </div>
                        <hr>
                        <h5>Mô tả:</h5>
                        <p class="card-text" style="white-space: pre-wrap;">${video.description}</p>
                    </div>
                </div>
                
                <div class="mt-3">
                    <a href="javascript:history.back();" class="btn btn-outline-secondary">⬅ Quay lại trang trước</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>