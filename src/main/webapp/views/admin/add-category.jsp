<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Thêm Danh Mục - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body { background-color: #f4f6f9; }
        .sidebar { background-color: #0d6efd; color: white; min-height: 100vh; padding-top: 20px; }
        .sidebar a { color: white; text-decoration: none; padding: 15px 20px; display: block; font-weight: bold; }
        .sidebar a:hover, .sidebar a.active { background-color: #0b5ed7; }
        .topbar { background-color: #0d6efd; color: white; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; }
        .card-form { background: white; border-radius: 8px; padding: 30px; box-shadow: 0 0 15px rgba(0,0,0,0.1); max-width: 600px; }
    </style>
</head>
<body>
<div class="container-fluid p-0">
    <div class="topbar">
        <h3 class="m-0">Dashboard</h3>
        <div>
            <span>Xin chào Quản trị viên</span> | 
            <a href="${pageContext.request.contextPath}/logout" class="text-white text-decoration-none bg-danger px-2 py-1 rounded">Đăng xuất</a>
        </div>
    </div>
    <div class="row g-0">
        <!-- Sidebar -->
        <div class="col-md-2 sidebar">
            <div class="text-center mb-4">
                <img src="https://cdn-icons-png.flaticon.com/512/3135/3135715.png" class="rounded-circle bg-light p-1" width="80" alt="Admin">
                <p class="mt-2 mb-0">Bạn là Admin</p>
            </div>
            <a href="#"><i class="fas fa-tachometer-alt me-2"></i> Dashboard</a>
            <a href="${pageContext.request.contextPath}/admin/category/list" class="active"><i class="fas fa-folder me-2"></i> Quản lý Danh mục</a>
        </div>
        
        <!-- Main Form -->
        <div class="col-md-10 p-4">
            <div class="card-form mx-auto mt-4">
                <h4 class="mb-4 text-success"><i class="fas fa-plus-circle"></i> Thêm Danh Mục Mới</h4>
                <form action="${pageContext.request.contextPath}/admin/category/add" method="post" enctype="multipart/form-data">
                    <div class="mb-3">
                        <label class="form-label fw-bold">Tên danh mục</label>
                        <input type="text" name="catename" class="form-control" required placeholder="Nhập tên (VD: Giày thể thao)">
                    </div>
                    <div class="mb-4">
                        <label class="form-label fw-bold">Ảnh đại diện</label>
                        <input type="file" name="icon" class="form-control" accept="image/*">
                    </div>
                    <button type="submit" class="btn btn-success fw-bold"><i class="fas fa-save"></i> Lưu thông tin</button>
                    <a href="${pageContext.request.contextPath}/admin/category/list" class="btn btn-secondary ms-2 fw-bold"><i class="fas fa-arrow-left"></i> Quay lại</a>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>