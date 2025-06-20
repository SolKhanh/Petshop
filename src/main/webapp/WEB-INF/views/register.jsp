<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="layout/header.jsp" %>
<html>
<head>
    <title>Đăng ký</title>
    <link rel="stylesheet" href="<c:url value='/css/user.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>" type="text/css">
    <style>
        .error-message {
            color: red;
            font-size: 0.9em;
            margin-top: 4px;
            display: block;
        }
    </style>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const form = document.querySelector(".user-form");

            form.addEventListener("submit", async function (event) {
                event.preventDefault();

                // Xóa thông báo lỗi cũ
                document.querySelectorAll(".error-message").forEach(span => span.textContent = "");

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
                    } else {
                        const errorData = await response.json();
                        if (errorData.errors) {
                            for (const field in errorData.errors) {
                                const span = document.getElementById(field + '-error');
                                if (span) {
                                    span.textContent = errorData.errors[field];
                                }
                            }
                        } else {
                            alert("❌ Đăng ký thất bại.");
                        }
                    }
                } catch (error) {
                    alert("❌ Lỗi kết nối hoặc không phản hồi từ server.");
                    console.error("Lỗi đăng ký:", error);
                }
            });
        });
    </script>
</head>
<body>
<div class="user-form-container">
    <h2>Đăng ký</h2>
    <form class="user-form">
        <label for="username">Tên đăng nhập:</label>
        <input type="text" id="username" name="username" required>
        <span class="error-message" id="username-error"></span>

        <label for="password">Mật khẩu:</label>
        <input type="password" id="password" name="password" required>
        <span class="error-message" id="password-error"></span>

        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required>
        <span class="error-message" id="email-error"></span>

        <label for="name">Họ và tên:</label>
        <input type="text" id="name" name="name" required>
        <span class="error-message" id="name-error"></span>

        <label for="phone">Số điện thoại:</label>
        <input type="text" id="phone" name="phone" required>
        <span class="error-message" id="phone-error"></span>

        <label for="address">Địa chỉ:</label>
        <input type="text" id="address" name="address" required>
        <span class="error-message" id="address-error"></span>

        <button type="submit">Đăng ký</button>
        <p>Bạn đã có tài khoản? <a href="/login">Đăng nhập</a></p>
    </form>
</div>
<%@ include file="layout/footer.jsp" %>
</body>
</html>
