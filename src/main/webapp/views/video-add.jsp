<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng Video Mới</title>
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

    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card shadow">
                    <div class="card-header bg-success text-white">
                        <h4 class="mb-0">Đăng Video Review Mới</h4>
                    </div>
                    <div class="card-body">
                        <!-- YÊU CẦU 4.5: FORM MULTIPART -->
                        <form action="${pageContext.request.contextPath}/video/insert" method="post" enctype="multipart/form-data">
                            
                            <!-- Tiêu đề -->
                            <div class="mb-3">
                                <label class="form-label">Tiêu đề Video</label>
                                <input type="text" class="form-control" name="title" required placeholder="Nhập tiêu đề video...">
                            </div>

                            <!-- Ảnh bìa (Poster) -->
                            <div class="mb-3">
                                <label class="form-label">Ảnh bìa (Poster)</label>
                                <input type="file" class="form-control" name="poster" accept="image/*" required>
                                <small class="text-muted">Chọn ảnh định dạng JPG, PNG...</small>
                            </div>

                            <!-- File Video -->
                            <div class="mb-3">
                                <label class="form-label">File Video (.mp4)</label>
                                <input type="file" class="form-control" name="videoUrl" accept="video/mp4" required>
                                <small class="text-danger">Lưu ý: Dung lượng video tối đa 50MB.</small>
                            </div>

                            <!-- Mô tả -->
                            <div class="mb-3">
                                <label class="form-label">Nội dung mô tả</label>
                                <textarea class="form-control" name="description" rows="4" placeholder="Nhập mô tả cho set đồ của bạn..."></textarea>
                            </div>

                            <!-- Trạng thái -->
                            <div class="mb-3 form-check">
                                <input type="checkbox" class="form-check-input" name="active" id="activeCheck" checked>
                                <label class="form-check-label" for="activeCheck">Công khai video này</label>
                            </div>

                            <!-- Nút Submit -->
                            <div class="text-end">
                                <a href="${pageContext.request.contextPath}/video" class="btn btn-secondary">Hủy bỏ</a>
                                <button type="submit" class="btn btn-success">Tải Video Lên</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

</body>
</html>