<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Trang Chủ - Khách Hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body { background-color: #f4f6f9; }
        .navbar-custom { background-color: #198754; }
    </style>
</head>
<body>
    <!-- Thanh điều hướng -->
    <nav class="navbar navbar-expand-lg navbar-dark navbar-custom shadow-sm">
        <div class="container">
            <a class="navbar-brand fw-bold" href="#"><i class="fas fa-shopping-cart"></i> ShoppingMVC</a>
            <div class="d-flex align-items-center">
                <span class="text-white me-4">Xin chào, <strong>${username}</strong>!</span>
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-light btn-sm fw-bold"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a>
            </div>
        </div>
    </nav>

    <!-- Nội dung chính -->
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-8 text-center">
                <div class="card p-5 border-0 shadow-sm rounded-4">
                    <i class="fas fa-check-circle text-success" style="font-size: 80px;"></i>
                    <h2 class="text-success mt-4 fw-bold">Đăng nhập thành công!</h2>
                    <p class="lead mt-3 text-secondary">Bạn đang truy cập hệ thống với tư cách <strong>Khách Hàng (Role = 2)</strong>.</p>
                    <hr class="w-50 mx-auto my-4 text-muted">
                    <p class="text-muted">Giao diện mua sắm và hiển thị sản phẩm sẽ được phát triển trong giai đoạn tiếp theo của đồ án.</p>
                </div>
            </div>
        </div>
    </div>
</body>
</html>