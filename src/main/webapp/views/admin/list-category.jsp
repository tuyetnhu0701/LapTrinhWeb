<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard Admin</title>
    <!-- Nhúng thư viện Bootstrap 5 qua CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body { background-color: #f4f6f9; }
        .sidebar { background-color: #0d6efd; color: white; min-height: 100vh; padding-top: 20px; }
        .sidebar a { color: white; text-decoration: none; padding: 15px 20px; display: block; font-weight: bold; }
        .sidebar a:hover, .sidebar a.active { background-color: #0b5ed7; }
        .topbar { background-color: #0d6efd; color: white; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; }
        .card-table { background: white; border-radius: 8px; padding: 20px; box-shadow: 0 0 15px rgba(0,0,0,0.1); }
        .btn-action { margin-right: 5px; }
    </style>
</head>
<body>

<div class="container-fluid p-0">
    <!-- Thanh Topbar -->
    <div class="topbar">
        <h3 class="m-0">Dashboard</h3>
        <div>
            <span>Xin chào Quản trị viên</span> | 
            <a href="${pageContext.request.contextPath}/logout" class="text-white text-decoration-none bg-danger px-2 py-1 rounded">Đăng xuất</a>
        </div>
    </div>

    <div class="row g-0">
        <!-- Cột Menu Sidebar (Bên trái) -->
        <div class="col-md-2 sidebar">
            <div class="text-center mb-4">
                <img src="https://cdn-icons-png.flaticon.com/512/3135/3135715.png" class="rounded-circle bg-light p-1" width="80" alt="Admin">
                <p class="mt-2 mb-0">Bạn là Admin</p>
            </div>
            <a href="#"><i class="fas fa-tachometer-alt me-2"></i> Dashboard</a>
            <a href="${pageContext.request.contextPath}/admin/category/list" class="active"><i class="fas fa-folder me-2"></i> Quản lý Danh mục</a>
            <a href="#"><i class="fas fa-box me-2"></i> Quản lý Sản phẩm</a>
            <a href="#"><i class="fas fa-users me-2"></i> Quản lý Tài khoản</a>
        </div>

        <!-- Cột Nội dung chính (Bên phải) -->
        <div class="col-md-10 p-4">
            <div class="card-table">
                <h4 class="mb-1 text-primary">Quản lý danh mục</h4>
                <p class="text-muted mb-4">Nơi bạn có thể quản lý danh mục của mình</p>
                
                <div class="d-flex justify-content-between mb-3">
                    <a href="${pageContext.request.contextPath}/admin/category/add" class="btn btn-success"><i class="fas fa-plus me-1"></i> Thêm danh mục mới</a>
                    <input type="text" class="form-control w-25" placeholder="Search...">
                </div>

                <table class="table table-bordered table-hover align-middle text-center">
                    <thead class="table-light">
                        <tr>
                            <th>STT</th>
                            <th>Hình ảnh</th>
                            <th>Tên danh mục</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${cateList}" var="cate" varStatus="STT">
                            <tr>
                                <td>${STT.index + 1}</td>
                                <td>
                                    <c:url value="/image?fname=${cate.icon}" var="imgUrl"/>
                                    <img src="${imgUrl}" class="rounded" height="80" width="80" style="object-fit: cover;" alt="Ảnh lỗi"/>
                                </td>
                                <td class="fw-bold">${cate.name}</td>
                                <td>
                                    <a href="<c:url value='/admin/category/edit?id=${cate.id}'/>" class="btn btn-sm btn-outline-primary btn-action"><i class="fas fa-edit"></i> Sửa</a>
                                    <a href="<c:url value='/admin/category/delete?id=${cate.id}'/>" class="btn btn-sm btn-outline-danger btn-action" onclick="return confirm('Bạn có chắc chắn muốn xóa danh mục này?');"><i class="fas fa-trash"></i> Xóa</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

</body>
</html>