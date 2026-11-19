<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Lấy thẻ title từ trang con, nếu không có thì hiện mặc định -->
    <title><sitemesh:write property="title"/> | ShoppingMVC</title>

    <!-- Bootstrap 5 CSS & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">

    <!-- Nhúng thêm CSS/Script riêng của từng trang con (nếu có) -->
    <sitemesh:write property="head"/>
</head>
<body class="d-flex flex-column min-vh-100 bg-light">

    <!-- HEADER / NAVBAR CHUNG -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
        <div class="container">
            <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/home">
                <i class="bi bi-play-btn-fill text-danger me-1"></i> ShoppingMVC
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mainNavbar">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="mainNavbar">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/home">Trang chủ</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/video">Kênh Video Của Tôi</a>
                    </li>
                </ul>

                <div class="d-flex align-items-center gap-2">
                    <c:choose>
                        <c:when test="${not empty sessionScope.account}">
                            <span class="text-light small me-2">
                                <i class="bi bi-person-circle"></i> Xin chào, <strong>${sessionScope.account.username}</strong>
                            </span>
                            <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-light btn-sm">Đăng xuất</a>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-light btn-sm">Đăng nhập</a>
                            <a href="${pageContext.request.contextPath}/register" class="btn btn-primary btn-sm">Đăng ký</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </nav>

    <!-- NỘI DUNG CHÍNH CỦA TỪNG TRANG CON SẼ ĐƯỢC BƠM VÀO ĐÂY -->
    <main class="container my-4 flex-grow-1">
        <sitemesh:write property="body"/>
    </main>

    <!-- FOOTER CHUNG -->
    <footer class="bg-dark text-white text-center py-3 mt-auto">
        <div class="container">
            <small>&copy; ShoppingMVC </small>
        </div>
    </footer>

    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>