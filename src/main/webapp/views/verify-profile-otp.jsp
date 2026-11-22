<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác thực OTP đổi Email</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-6 col-lg-5">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-primary text-white text-center py-3">
                    <h5 class="mb-0 fw-bold"><i class="bi bi-shield-lock me-2"></i>XÁC THỰC EMAIL MỚI</h5>
                </div>
                <div class="card-body p-4">
                    <p class="text-muted text-center mb-3">
                        Mã OTP 6 chữ số đã được gửi tới email mới:<br>
                        <b class="text-primary">${sessionScope.pendingProfileUser.email}</b>
                    </p>

                    <div class="text-center mb-3">
                        <span class="badge bg-warning text-dark fs-6 px-3 py-2" id="otpTimer">
                            Mã hết hạn sau: 02:00
                        </span>
                    </div>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">${error}</div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/profile/verify-otp" method="post"
                          class="needs-validation" novalidate>
                        <div class="mb-3">
                            <label for="otp" class="form-label fw-semibold">Nhập mã OTP</label>
                            <input type="text" id="otp" name="otp" class="form-control text-center fs-5 fw-bold"
                                   placeholder="Nhập 6 chữ số" required pattern="^[0-9]{6}$" maxlength="6">
                            <div class="invalid-feedback">Vui lòng nhập đúng mã OTP gồm 6 chữ số.</div>
                        </div>

                        <div class="d-grid gap-2">
                            <button type="submit" id="btnVerify" class="btn btn-primary fw-semibold">
                                Xác nhận cập nhật
                            </button>
                            <a href="${pageContext.request.contextPath}/profile" class="btn btn-outline-secondary">
                                Hủy và quay lại Hồ sơ
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    (() => {
        'use strict';
        const forms = document.querySelectorAll('.needs-validation');
        Array.from(forms).forEach(form => {
            form.addEventListener('submit', event => {
                if (!form.checkValidity()) {
                    event.preventDefault();
                    event.stopPropagation();
                }
                form.classList.add('was-validated');
            }, false);
        });
    })();

    const expireAt = Number("${sessionScope.profileOtpExpire}");
    const timerEl = document.getElementById("otpTimer");
    const btnVerify = document.getElementById("btnVerify");

    function updateTimer() {
        const remaining = Math.floor((expireAt - Date.now()) / 1000);
        if (remaining <= 0) {
            timerEl.className = "badge bg-danger fs-6 px-3 py-2";
            timerEl.textContent = "Mã OTP đã hết hạn!";
            if (btnVerify) btnVerify.disabled = true;
            return;
        }
        const mins = String(Math.floor(remaining / 60)).padStart(2, '0');
        const secs = String(remaining % 60).padStart(2, '0');
        timerEl.textContent = "Mã hết hạn sau: " + mins + ":" + secs;
        setTimeout(updateTimer, 1000);
    }

    if (expireAt) {
        updateTimer();
    }
</script>
</body>
</html>