<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- Khai báo thư viện JSTL để dùng vòng lặp và điều kiện -->
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý Video Review của tôi</title>
    <!-- Nhúng Bootstrap để giao diện đẹp sẵn -->
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
    <div class="container mt-4 mb-5">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>Kênh Video Review Của Tôi</h2>
            <!-- Nút chuyển sang trang Thêm Video -->
            <a href="${pageContext.request.contextPath}/video/add" class="btn btn-success">+ Đăng Video Mới</a>
        </div>

        <!-- Lưới hiển thị danh sách video -->
        <div class="row">
            <c:forEach items="${videoList}" var="vid">
                <div class="col-md-4 mb-4">
                    <div class="card h-100 shadow-sm">
                        <!-- ĐÃ SỬA THÀNH /media ĐỂ LOAD ẢNH TỪ THƯ MỤC VIDEO -->
                        <img src="${pageContext.request.contextPath}/media?fname=${vid.poster}" class="card-img-top" alt="Poster" style="height: 200px; object-fit: cover; background: #eee;">
                        
                        <div class="card-body">
                            <h5 class="card-title text-truncate" title="${vid.title}">${vid.title}</h5>
                            <p class="card-text text-muted small mb-2">👁 Lượt xem: ${vid.views}</p>
                            <p class="card-text text-truncate" style="max-height: 4.5em; overflow: hidden;">${vid.description}</p>
                        </div>
                        <div class="card-footer bg-white text-center border-top-0">
                            <!-- Nút Xem, Sửa, Xóa -->
                            <a href="${pageContext.request.contextPath}/video/detail?id=${vid.videoId}" class="btn btn-sm btn-info text-white">Xem</a>
                            <a href="${pageContext.request.contextPath}/video/edit?id=${vid.videoId}" class="btn btn-sm btn-warning text-dark">Sửa</a>
                            <a href="${pageContext.request.contextPath}/video/delete?id=${vid.videoId}" 
                               class="btn btn-sm btn-danger" 
                               onclick="return confirm('Bạn có chắc chắn muốn xóa video này?');">Xóa</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
            
            <!-- Thông báo nếu chưa có video nào -->
            <c:if test="${empty videoList}">
                <div class="col-12">
                    <div class="alert alert-warning text-center">Bạn chưa đăng video review nào. Hãy tải lên set đồ mới nhất của bạn nhé!</div>
                </div>
            </c:if>
        </div>

        <!-- YÊU CẦU 4.3: Thanh Phân Trang (Pagination) -->
        <c:if test="${totalPages > 1}">
            <nav aria-label="Page navigation">
                <ul class="pagination justify-content-center mt-4">
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                            <a class="page-link" href="${pageContext.request.contextPath}/video?page=${i}">${i}</a>
                        </li>
                    </c:forEach>
                </ul>
            </nav>
        </c:if>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>