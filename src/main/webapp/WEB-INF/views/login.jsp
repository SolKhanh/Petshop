<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="layout/header.jsp" %>
<html>
<head>
    <title>Đăng nhập</title>
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
        async function login(event) {
            event.preventDefault();

            // Xóa lỗi cũ
            document.querySelectorAll(".error-message").forEach(span => span.textContent = "");

            const username = document.getElementById("username").value.trim();
            const password = document.getElementById("password").value.trim();

            try {
                const response = await fetch("/api/auth/login", {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/json"
                    },
                    body: JSON.stringify({ username, password })
                });

                if (response.ok) {
                    const data = await response.json();
                    localStorage.setItem("jwtToken", data.token);
                    window.location.href = "/shop"; // Chuyển đến trang chính
                } else {
                    const contentType = response.headers.get("Content-Type");
                    if (contentType && contentType.includes("application/json")) {
                        const errorData = await response.json();
                        if (errorData.errors) {
                            for (const field in errorData.errors) {
                                const span = document.getElementById(field + "-error");
                                if (span) {
                                    span.textContent = errorData.errors[field];
                                }
                            }
                        } else if (errorData.message) {
                            // Thông báo chung nếu không rõ field
                            alert("❌ " + errorData.message);
                        } else {
                            alert("❌ Đăng nhập thất bại.");
                        }
                    } else {
                        const errorText = await response.text();
                        alert("❌ " + errorText);
                    }
                }
            } catch (error) {
                alert("❌ Lỗi kết nối máy chủ: " + error.message);
                console.error("Login error:", error);
            }
        }
    </script>
</head>
<body>
<div class="user-form-container">
    <h2>Đăng nhập</h2>
    <form onsubmit="login(event)" class="user-form">
        <label for="username">Tên đăng nhập:</label>
        <input type="text" id="username" name="username" required>
        <span class="error-message" id="username-error"></span>

        <label for="password">Mật khẩu:</label>
        <input type="password" id="password" name="password" required>
        <span class="error-message" id="password-error"></span>

        <button type="submit">Đăng nhập</button>

        <p>Bạn chưa có tài khoản? <a href="/register">Đăng ký ngay</a></p>
    </form>
</div>
<%@ include file="layout/footer.jsp" %>
</body>
</html>
