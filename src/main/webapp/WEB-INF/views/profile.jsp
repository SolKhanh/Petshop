<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="layout/header.jsp"></jsp:include>

<html>
<head>
    <title>Thông tin cá nhân</title>
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>" type="text/css">
    <style>
        .profile-container {
            max-width: 600px;
            margin: 40px auto;
            padding: 30px;
            border: 1px solid #ddd;
            border-radius: 10px;
            background-color: #f9f9f9;
        }
        .profile-header {
            text-align: center;
            margin-bottom: 25px;
        }
        .profile-row {
            margin-bottom: 15px;
        }
        .profile-label {
            font-weight: bold;
        }
        .profile-actions {
            text-align: center;
            margin-top: 30px;
        }
        .btn {
            padding: 10px 20px;
            margin: 5px;
            border: none;
            border-radius: 5px;
            font-weight: bold;
            cursor: pointer;
        }
        .btn-update {
            background-color: #4CAF50;
            color: white;
        }
        .btn-logout {
            background-color: #f44336;
            color: white;
        }
    </style>
</head>
<body>
<div class="profile-container">
    <div class="profile-header">
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
                console.log(response);
                return response.json();
            })
            .then(data => {
                console.log("user data: " + data);
                document.getElementById("username").textContent = data.username;
                document.getElementById("email").textContent = data.email;
                document.getElementById("phone").textContent = data.phone;
                document.getElementById("address").textContent = data.address;
            })
            .catch(error => {
                console.error(error);
                alert("Lỗi khi tải thông tin người dùng.");
            });
    });

    function goToUpdate() {
        window.location.href = "/update-profile.jsp";
    }

    function logout() {
        localStorage.removeItem("jwtToken");
        window.location.href = "/login";
    }
</script>
<jsp:include page="layout/footer.jsp"></jsp:include>
</body>
</html>