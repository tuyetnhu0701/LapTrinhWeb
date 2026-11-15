<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng Nhập - ShoppingMVC</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body { background-color: #f4f6f9; display: flex; align-items: center; justify-content: center; height: 100vh; }
        .login-card { width: 100%; max-width: 400px; padding: 40px 30px; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); background: white; }
    </style>
</head>
<body>
    <div class="login-card">
        <h3 class="text-center text-primary mb-4"><i class="fas fa-user-circle"></i> Đăng Nhập</h3>
        
        <c:if test="${not empty alert}">
            <div class="alert alert-danger p-2 text-center" role="alert">${alert}</div>
        </c:if>
        
        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="mb-3">
                <label class="form-label text-muted fw-bold">Tài khoản</label>
                <div class="input-group">
                    <span class="input-group-text bg-white"><i class="fas fa-user text-primary"></i></span>
                    <input type="text" name="username" class="form-control" required placeholder="Nhập admin hoặc user">
                </div>
            </div>
            <div class="mb-3">
                <label class="form-label text-muted fw-bold">Mật khẩu</label>
                <div class="input-group">
                    <span class="input-group-text bg-white"><i class="fas fa-lock text-primary"></i></span>
                    <input type="password" name="password" class="form-control" required placeholder="Nhập mật khẩu">
                </div>
            </div>
            <div class="mb-4 form-check">
                <input type="checkbox" name="remember" class="form-check-input" id="rememberMe">
                <label class="form-check-label text-muted" for="rememberMe">Nhớ phiên đăng nhập</label>
            </div>
            <button type="submit" class="btn btn-primary w-100 fw-bold mb-3">Đăng nhập</button>
        </form>
        
        <div class="text-center mt-3">
            <span class="text-muted">Chưa có tài khoản?</span> 
            <a href="${pageContext.request.contextPath}/register" class="text-decoration-none fw-bold">Đăng ký ngay</a>
        </div>
    </div>
</body>
</html>