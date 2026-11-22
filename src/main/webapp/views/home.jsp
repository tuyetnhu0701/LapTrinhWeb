<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang chủ</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body class="bg-light">
    <!--thêm nút Kênh Video -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm">
        <div class="container">
            <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/home">ShoppingMVC</a>
            <div class="d-flex align-items-center text-white">
                <!-- Nút Kênh Video Mới Thêm -->
                <a href="${pageContext.request.contextPath}/video" class="btn btn-warning btn-sm fw-bold me-3 text-dark">
                    🎬 Kênh Video Của Tôi
                </a>
                
                <span class="me-3">Xin chào, <b>${sessionScope.account.fullName}</b> (${sessionScope.account.userName})</span>
                <!-- Nút Hồ sơ cá nhân  -->
                <a href="${pageContext.request.contextPath}/profile"
                   class="btn btn-light btn-sm fw-semibold text-primary me-2 d-inline-flex align-items-center rounded-pill px-3 shadow-sm">
                    <c:choose>
                        <c:when test="${not empty sessionScope.account.avatar}">
                            <img src="${sessionScope.account.avatar}" alt="Avatar"
                                 class="rounded-circle me-2 border border-primary"
                                 style="width: 22px; height: 22px; object-fit: cover;">
                        </c:when>
                        <c:otherwise>
                            <i class="bi bi-person-circle me-1"></i>
                        </c:otherwise>
                    </c:choose>
                    Hồ sơ
                </a>

                <a href="${pageContext.request.contextPath}/logout" 
                   class="btn btn-danger btn-sm fw-semibold"
                   onclick="return confirm('Bạn có chắc chắn muốn đăng xuất khỏi hệ thống không?');">
                    <i class="bi bi-box-arrow-right me-1"></i> Đăng xuất
                </a>
            </div>
        </div>
    </nav>

    <div class="container mt-5">
        <!-- Bảng Welcome của bạn -->
        <div class="card shadow-sm border-0 p-4 text-center mb-5">
            <h3 class="text-primary fw-bold">CHÀO MỪNG BẠN ĐẾN VỚI HỆ THỐNG SHOPPING MVC</h3>
            <p class="text-muted">Bạn đã đăng nhập thành công với tài khoản đã xác thực.</p>
            <c:if test="${sessionScope.account.roleid == 1}">
                <div class="mt-3">
                    <a href="${pageContext.request.contextPath}/admin/categories" class="btn btn-outline-primary fw-semibold">
                        Quản lý Danh mục (Category)
                    </a>
                </div>
            </c:if>
        </div>

        <!--(TOP 10 MỚI NHẤT) -->
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h4 class="fw-bold text-danger"><i class="bi bi-play-circle-fill"></i> GÓC REVIEW MỚI NHẤT</h4>
        </div>
        <hr>
        <div class="row row-cols-1 row-cols-md-5 g-4 mb-5">
            <c:forEach items="${top10Videos}" var="vid">
                <div class="col">
                    <div class="card h-100 shadow-sm border-0">
                        <a href="${pageContext.request.contextPath}/video/detail?id=${vid.videoId}">
                            <img src="${pageContext.request.contextPath}/media?fname=${vid.poster}" class="card-img-top rounded" alt="Poster" style="height: 150px; object-fit: cover;">
                        </a>
                        <div class="card-body p-2">
                            <h6 class="card-title text-truncate mb-1" title="${vid.title}">
                                <a href="${pageContext.request.contextPath}/video/detail?id=${vid.videoId}" class="text-decoration-none text-dark">${vid.title}</a>
                            </h6>
                            <p class="card-text text-muted small mb-0"><i class="bi bi-eye"></i> ${vid.views} lượt xem</p>
                            <p class="card-text text-muted small mb-0">📅 Đăng ngày: <fmt:formatDate value="${vid.postDate}" pattern="dd/MM/yyyy" /></p>
                            <p class="card-text text-muted small">Bởi: ${vid.user.fullName}</p>
                        </div>
                    </div>
                </div>
            </c:forEach>
            
            <c:if test="${empty top10Videos}">
                <div class="col-12">
                    <div class="alert alert-warning text-center">Chưa có video review nào được đăng trên hệ thống.</div>
                </div>
            </c:if>
        </div>
    </div>
</body>
</html>