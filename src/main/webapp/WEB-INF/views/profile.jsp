<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="layout/header.jsp"></jsp:include>

<html>
<head>
    <title>Thông tin cá nhân</title>
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>" type="text/css">
    <link rel="stylesheet" href="<c:url value='/css/profile.css'/>" type="text/css">
</head>
<body>
<div class="profile-container">
    <div class="profile-header">
        <img id="avatar" class="profile-avatar" src="#" alt="Avatar" style="display: none;">
        <h2>Thông tin cá nhân</h2>
    </div>
    <div class="profile-row">
        <span class="profile-label">Tên đăng nhập: </span><span id="username"></span>
    </div>
    <div class="profile-row">
        <span class="profile-label">Email: </span><span id="email"></span>
    </div>
    <div class="profile-row">
        <span class="profile-label">Số điện thoại: </span><span id="phone"></span>
    </div>
    <div class="profile-row">
        <span class="profile-label">Địa chỉ: </span><span id="address"></span>
    </div>

    <div class="profile-actions">
        <button class="btn btn-update" onclick="goToUpdate()">Cập nhật thông tin</button>
        <button class="btn btn-logout" onclick="logout()">Đăng xuất</button>
    </div>
</div>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        const token = localStorage.getItem("jwtToken");
        if (!token) {
            window.location.href = "/login";
            return;
        }

        fetch("/api/users/me/profile", {
            headers: {
                "Authorization": "Bearer " + token
            }
        })
            .then(response => {
                if (!response.ok) throw new Error("Không thể tải thông tin.");
                return response.json();
            })
            .then(data => {
                document.getElementById("username").textContent = data.username;
                document.getElementById("email").textContent = data.email;
                document.getElementById("phone").textContent = data.phone;
                document.getElementById("address").textContent = data.address;

                // Avatar
                if (data.avatar || data.avt) {
                    const avatarUrl = data.avatar || data.avt;
                    const avatarImg = document.getElementById("avatar");
                    avatarImg.src = avatarUrl;
                    avatarImg.style.display = "block";
                }
            })
            .catch(error => {
                console.error(error);
                alert("Lỗi khi tải thông tin người dùng.");
            });
    });

    function goToUpdate() {
        window.location.href = "/update-profile";
    }

    function logout() {
        localStorage.removeItem("jwtToken");
        window.location.href = "/login";
    }
</script>
<jsp:include page="layout/footer.jsp"></jsp:include>
</body>
</html>
