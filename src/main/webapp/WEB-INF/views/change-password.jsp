<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="layout/header.jsp" />

<html>
<head>
    <title>Đổi mật khẩu</title>
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>" type="text/css">
    <style>
        .change-password-container {
            max-width: 500px;
            margin: 40px auto;
            padding: 30px;
            border: 1px solid #ddd;
            border-radius: 10px;
            background-color: #f9f9f9;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            font-weight: bold;
            margin-bottom: 6px;
        }
        input[type="password"] {
            width: 100%;
            padding: 10px;
            box-sizing: border-box;
        }
        .error-message {
            color: red;
            font-size: 0.9em;
            margin-top: 4px;
            display: block;
        }
        .form-actions {
            text-align: center;
            margin-top: 25px;
        }
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            font-weight: bold;
            cursor: pointer;
        }
        .btn-submit {
            background-color: #4CAF50;
            color: white;
        }
        .btn-cancel {
            background-color: #ccc;
            color: black;
            margin-left: 10px;
        }
    </style>
</head>
<body>

<div class="change-password-container">
    <h2>Đổi mật khẩu</h2>
    <form id="changePasswordForm">
        <div class="form-group">
            <label for="oldPassword">Mật khẩu hiện tại:</label>
            <input type="password" id="oldPassword" required>
            <span class="error-message" id="oldPassword-error"></span>
        </div>
        <div class="form-group">
            <label for="newPassword">Mật khẩu mới:</label>
            <input type="password" id="newPassword" required>
            <span class="error-message" id="newPassword-error"></span>
        </div>
        <div class="form-group">
            <label for="confirmNewPassword">Nhập lại mật khẩu mới:</label>
            <input type="password" id="confirmNewPassword" required>
            <span class="error-message" id="confirmNewPassword-error"></span>
        </div>
        <div class="form-actions">
            <button type="submit" class="btn btn-submit">Đổi mật khẩu</button>
            <button type="button" class="btn btn-cancel" onclick="cancel()">Hủy</button>
        </div>
    </form>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const form = document.getElementById("changePasswordForm");

        form.addEventListener("submit", async function (e) {
            e.preventDefault();

            // Xóa lỗi cũ
            document.querySelectorAll(".error-message").forEach(span => span.textContent = "");

            const dto = {
                oldPassword: document.getElementById("oldPassword").value.trim(),
                newPassword: document.getElementById("newPassword").value.trim(),
                confirmNewPassword: document.getElementById("confirmNewPassword").value.trim()
            };

            const token = localStorage.getItem("jwtToken");
            if (!token) {
                alert("Phiên đăng nhập đã hết. Vui lòng đăng nhập lại.");
                window.location.href = "/login";
                return;
            }

            try {
                const response = await fetch("/api/users/me/change-password", {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/json",
                        "Authorization": "Bearer " + token
                    },
                    body: JSON.stringify(dto)
                });

                if (response.ok) {
                    alert("✅ Đổi mật khẩu thành công!");
                    window.location.href = "/profile";
                } else {
                    const data = await response.json();
                    console.log(data);
                    if (data.errors) {
                        // Xử lý lỗi validation từ backend
                        for (const field in data.errors) {
                            const span = document.getElementById(field + "-error");
                            if (span) {
                                span.textContent = data.errors[field];
                            }
                        }
                    } else if (data.message) {
                        // Lỗi logic ví dụ mật khẩu không khớp
                        alert("1❌ " + data.message);
                    } else {
                        alert("2❌ Có lỗi xảy ra khi đổi mật khẩu.");
                    }
                }
            } catch (err) {
                console.error("Lỗi đổi mật khẩu:", err);
                alert("❌ Lỗi kết nối đến server.");
            }
        });
    });

    function cancel() {
        window.location.href = "/profile";
    }
</script>

<jsp:include page="layout/footer.jsp" />
</body>
</html>
