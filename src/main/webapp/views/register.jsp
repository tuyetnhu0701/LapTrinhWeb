<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng Ký - ShoppingMVC</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body { background-color: #f4f6f9; display: flex; align-items: center; justify-content: center; height: 100vh; }
        .register-card { width: 100%; max-width: 550px; padding: 40px 30px; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); background: white; }
    </style>
</head>
<body>
    <div class="register-card">
        <h3 class="text-center text-success mb-4"><i class="fas fa-user-plus"></i> Đăng Ký Tài Khoản</h3>
        
        <c:if test="${not empty alert}">
            <div class="alert alert-warning p-2 text-center" role="alert">${alert}</div>
        </c:if>
        
        <form action="${pageContext.request.contextPath}/register" method="post">
            <div class="mb-3">
                <label class="form-label text-muted fw-bold">Email</label>
                <input type="email" name="email" class="form-control" required placeholder="example@gmail.com">
            </div>
            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label text-muted fw-bold">Tài khoản</label>
                    <input type="text" name="username" class="form-control" required placeholder="Tên đăng nhập">
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label text-muted fw-bold">Mật khẩu</label>
                    <input type="password" name="password" class="form-control" required placeholder="Mật khẩu">
                </div>
            </div>
            <div class="mb-3">
                <label class="form-label text-muted fw-bold">Họ tên</label>
                <input type="text" name="fullname" class="form-control" required placeholder="Nhập đầy đủ họ tên">
            </div>
            <div class="mb-4">
                <label class="form-label text-muted fw-bold">Số điện thoại</label>
                <input type="text" name="phone" class="form-control" required placeholder="09xx.xxx.xxx">
            </div>
            <button type="submit" class="btn btn-success w-100 fw-bold mb-3">Đăng ký thành viên</button>
        </form>
        
        <div class="text-center mt-3">
            <span class="text-muted">Đã có tài khoản?</span> 
            <a href="${pageContext.request.contextPath}/login" class="text-decoration-none fw-bold text-success">Đăng nhập</a>
        </div>
    </div>
</body>
</html>