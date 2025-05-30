<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="layout/header.jsp" %>
<html>
<head>
    <title>Đăng ký</title>
    <link rel="stylesheet" href="<c:url value='/css/user.css'/>">
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const form = document.querySelector(".user-form");
            form.addEventListener("submit", async function (event) {
                event.preventDefault();

                const dto = {
                    username: document.getElementById("username").value,
                    password: document.getElementById("password").value,
                    email: document.getElementById("email").value,
                    name: document.getElementById("name").value,
                    phone: document.getElementById("phone").value,
                    address: document.getElementById("address").value
                };

                try {
                    const response = await fetch("/api/auth/register", {
                        method: "POST",
                        headers: { "Content-Type": "application/json" },
                        body: JSON.stringify(dto)
                    });

                    if (response.ok) {
                        const contentType = response.headers.get("content-type");
                        if (contentType && contentType.includes("application/json")) {
                            const data = await response.json();
                            alert("✅ Đăng ký thành công: " + data.username);
                            window.location.href = "/login";
                        } else {
                            alert("✅ Đăng ký thành công (không có dữ liệu JSON trả về)");
                            window.location.href = "/login";
                        }
                    }
                } catch (error) {
                    alert("❌ Lỗi kết nối hoặc không phản hồi từ server.");
                    console.error("Lỗi đăng ký:", error);
                }
            });
        });
    </script>z
</head>
<body>
<div class="user-form-container">
    <h2>Đăng ký</h2>
    <form onsubmit="register(event)" class="user-form">
        <label for="username">Tên đăng nhập:</label>
        <input type="text" id="username" name="username" required>

        <label for="password">Mật khẩu:</label>
        <input type="password" id="password" name="password" required>

        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required>

        <label for="name">Họ và tên:</label>
        <input type="text" id="name" name="name" required>

        <label for="phone">Số điện thoại:</label>
        <input type="text" id="phone" name="phone" required>

        <label for="address">Địa chỉ:</label>
        <input type="text" id="address" name="address" required>

        <button type="submit">Đăng ký</button>

        <p>Bạn đã có tài khoản? <a href="/login">Đăng nhập</a></p>
    </form>
</div>
</body>
</html>
