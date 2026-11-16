<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Xác thực OTP</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-5">
                <div class="card shadow-sm border-0">
                    <div class="card-header bg-primary text-white text-center py-3">
                        <h4 class="mb-0 fw-bold">XÁC THỰC MÃ OTP</h4>
                    </div>
                    <div class="card-body p-4">
                        <p class="text-muted text-center mb-2">
                            Mã OTP gồm 6 chữ số đã được gửi tới email:<br>
                            <b class="text-dark">${sessionScope.otp_email}</b>
                        </p>

                        <!-- Đồng hồ đếm ngược trực quan -->
                        <div class="text-center mb-3">
                            <span class="badge bg-danger bg-opacity-10 text-danger border border-danger px-3 py-2 fs-6">
                                <i class="bi bi-clock-history me-1"></i> Thời gian còn lại: <strong id="countdown">05:00</strong>
                            </span>
                        </div>

                        <c:if test="${alert != null}">
                            <div class="alert alert-danger">${alert}</div>
                        </c:if>

                        <form action="${pageContext.request.contextPath}/verify-otp" method="post">
                            <div class="mb-3">
                                <label class="form-label fw-semibold">Nhập mã OTP (6 chữ số)</label>
                                <input type="text" name="otp" id="otpInput" class="form-control text-center fs-4 fw-bold tracking-widest" maxlength="6" placeholder="------" required>
                            </div>
                            <button type="submit" id="submitBtn" class="btn btn-primary w-100 fw-bold py-2">Xác nhận OTP</button>
                        </form>
                        <div class="text-center mt-3">
                            <a href="${pageContext.request.contextPath}/login" class="text-decoration-none">Quay lại Đăng nhập</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Lấy thời gian hết hạn từ Session của Server (nếu không có thì mặc định 5 phút từ lúc mở trang)
        const expiryTime = Number("${sessionScope.otp_expiry}") || 0;
        const countdownEl = document.getElementById('countdown');
        const submitBtn = document.getElementById('submitBtn');
        const otpInput = document.getElementById('otpInput');

        if (expiryTime > 0) {
            const timer = setInterval(function() {
                const now = new Date().getTime();
                const distance = expiryTime - now;

                if (distance <= 0) {
                    clearInterval(timer);
                    countdownEl.innerHTML = "Đã hết hạn!";
                    submitBtn.disabled = true;
                    otpInput.disabled = true;
                } else {
                    const minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
                    const seconds = Math.floor((distance % (1000 * 60)) / 1000);
                    countdownEl.innerHTML = 
                        (minutes < 10 ? "0" + minutes : minutes) + ":" + 
                        (seconds < 10 ? "0" + seconds : seconds);
                }
            }, 1000);
        }
    </script>
</body>
</html>