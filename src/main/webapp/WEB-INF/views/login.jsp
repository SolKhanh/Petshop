<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="layout/header.jsp" %>
<html>
<head>
    <title>Đăng nhập</title>
    <link rel="stylesheet" href="<c:url value='/css/user.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>" type="text/css">
    <script>
        async function login(event) {
            event.preventDefault();

            const username = document.getElementById("username").value;
            const password = document.getElementById("password").value;

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
                    localStorage.setItem("jwtToken", data.token); // Lưu token
                    alert("Đăng nhập thành công");
                    window.location.href = "/shop"; // Chuyển đến trang chính
                } else {
                    const errorText = await response.text();
                    alert("Tài khoản hoặc mât khẩu không đúng");
                }
            } catch (error) {
                alert("Lỗi kết nối máy chủ: " + error.message);
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

        <label for="password">Mật khẩu:</label>
        <input type="password" id="password" name="password" required>

        <button type="submit">Đăng nhập</button>

        <p>Bạn chưa có tài khoản? <a href="/register">Đăng ký ngay</a></p>
    </form>
</div>
<%@ include file="layout/footer.jsp" %>
</body>
</html>
