<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="layout/header.jsp" />

<html>
<head>
    <title>Cập nhật thông tin cá nhân</title>
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>" type="text/css">
    <link rel="stylesheet" href="<c:url value='/css/profile.css'/>" type="text/css">
</head>
<body>
<div class="update-container">
    <div class="update-header">
        <h2>Cập nhật thông tin cá nhân</h2>
    </div>
    <form id="updateProfileForm">
        <div class="form-group">
            <label for="name">Họ và tên:</label>
            <input type="text" id="name" maxlength="100" required>
            <span class="error-message" id="name-error"></span>
        </div>
        <div class="form-group">
            <label for="email">Email:</label>
            <input type="email" id="email" maxlength="100" required>
            <span class="error-message" id="email-error"></span>
        </div>
        <div class="form-group">
            <label for="phone">Số điện thoại:</label>
            <input type="tel" id="phone" required>
            <span class="error-message" id="phone-error"></span>
        </div>
        <div class="form-group">
            <label for="address">Địa chỉ:</label>
            <input type="text" id="address" maxlength="255">
            <span class="error-message" id="address-error"></span>
        </div>
        <div class="form-group">
            <label for="avatar">Profile Picture URL:</label>
            <input type="text" id="avatar" placeholder="https://example.com/avatar.jpg">
            <span class="error-message" id="avatar-error"></span>
            <img id="avatarPreview" class="avatar-preview" src="#" alt="Avatar Preview" style="display: none;">
        </div>
        <div class="form-actions">
            <button type="submit" class="btn btn-save">Lưu thay đổi</button>
            <button type="button" class="btn btn-cancel" onclick="cancelUpdate()">Hủy</button>
        </div>
    </form>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const token = localStorage.getItem("jwtToken");
        if (!token) {
            window.location.href = "/login";
            return;
        }

        const form = document.getElementById("updateProfileForm");

        // Load thông tin hiện tại
        fetch("/api/users/me/profile", {
            headers: {
                "Authorization": "Bearer " + token
            }
        })
            .then(res => {
                if (!res.ok) throw new Error("Không thể tải thông tin.");
                return res.json();
            })
            .then(data => {
                document.getElementById("name").value = data.name || "";
                document.getElementById("email").value = data.email || "";
                document.getElementById("phone").value = data.phone || "";
                document.getElementById("address").value = data.address || "";
                document.getElementById("avatar").value = data.avatar || "";

                if (data.avatar) {
                    document.getElementById("avatarPreview").src = data.avatar;
                    document.getElementById("avatarPreview").style.display = "block";
                }
            })
            .catch(err => {
                alert("Lỗi khi tải thông tin người dùng.");
                console.error(err);
            });

        // Avatar preview
        document.getElementById("avatar").addEventListener("input", function () {
            const url = this.value.trim();
            const preview = document.getElementById("avatarPreview");
            if (url) {
                preview.src = url;
                preview.style.display = "block";
            } else {
                preview.style.display = "none";
            }
        });

        // Xử lý form
        form.addEventListener("submit", function (e) {
            e.preventDefault();

            // Xóa lỗi cũ
            document.querySelectorAll(".error-message").forEach(el => el.textContent = "");

            const payload = {
                name: document.getElementById("name").value.trim(),
                email: document.getElementById("email").value.trim(),
                phone: document.getElementById("phone").value.trim(),
                address: document.getElementById("address").value.trim(),
                avt: document.getElementById("avatar").value.trim()
            };

            fetch("/api/users/me/profile", {
                method: "PUT",
                headers: {
                    "Content-Type": "application/json",
                    "Authorization": "Bearer " + token
                },
                body: JSON.stringify(payload)
            })
                .then(async response => {
                    if (response.ok) {
                        const data = await response.json();
                        alert("✅ Cập nhật thành công!");
                        window.location.href = "/profile";
                    } else {
                        const errorData = await response.json();
                        if (errorData.errors) {
                            for (const field in errorData.errors) {
                                const span = document.getElementById(field + "-error");
                                if (span) span.textContent = errorData.errors[field];
                            }
                        } else {
                            alert("❌ Cập nhật thất bại.");
                        }
                    }
                })
                .catch(err => {
                    alert("❌ Lỗi khi kết nối đến máy chủ.");
                    console.error(err);
                });
        });
    });

    function cancelUpdate() {
        window.location.href = "/profile";
    }
</script>

<jsp:include page="layout/footer.jsp" />
</body>
</html>