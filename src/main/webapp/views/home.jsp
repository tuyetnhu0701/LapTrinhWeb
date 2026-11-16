<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang chủ</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body class="bg-light">
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm">
        <div class="container">
            <a class="navbar-brand fw-bold" href="#">ShoppingMVC</a>
            <div class="d-flex align-items-center text-white">
                <span class="me-3">Xin chào, <b>${sessionScope.account.fullName}</b> (${sessionScope.account.userName})</span>
                <a href="${pageContext.request.contextPath}/logout" 
                   class="btn btn-danger btn-sm fw-semibold"
                   onclick="return confirm('Bạn có chắc chắn muốn đăng xuất khỏi hệ thống không?');">
                    <i class="bi bi-box-arrow-right me-1"></i> Đăng xuất
                </a>
            </div>
        </div>
    </nav>

    <div class="container mt-5">
        <div class="card shadow-sm border-0 p-4 text-center">
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
    </div>
</body>
</html>