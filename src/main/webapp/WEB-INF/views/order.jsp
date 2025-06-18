<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="layout/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Thanh toán</title>
    <link rel="stylesheet" href="<c:url value='/css/order.css'/>" />
    <style>
        .container {
            /*max-width: 600px;*/
            margin: 0 auto;
            display: flex;
            justify-content: center;
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        form label {
            display: block;
            margin-top: 10px;
        }
        input, textarea {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
        }
        .submit-btn {
            background-color: #28a745;
            color: white;
            padding: 12px 20px;
            border: none;
            margin-top: 20px;
            cursor: pointer;
            width: 100%;
        }
        .order {
            margin-top: 100px;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="order">
    <h2>📦 Thông tin thanh toán</h2>
    <form id="order-form">
        <label>Họ và tên:</label>
        <input type="text" name="customerName" required />

        <label>Địa chỉ giao hàng:</label>
        <input type="text" name="shippingAddress" required />

        <label>Số điện thoại:</label>
        <input type="text" name="phone" required />

        <label>Email:</label>
        <input type="email" name="email" required />

        <label>Ghi chú:</label>
        <textarea name="note" rows="3"></textarea>

        <button type="submit" class="submit-btn">Đặt hàng</button>
    </form>
</div>
</div>

<script>
    document.getElementById("order-form").addEventListener("submit", async function(e) {
        e.preventDefault();

        const token = localStorage.getItem("jwtToken");
        const formData = new FormData(this);
        const requestData = {};
        formData.forEach((value, key) => requestData[key] = value);

        const res = await fetch("/api/orders", {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
                "Authorization": "Bearer " + token
            },
            body: JSON.stringify(requestData)
        });

        if (res.status === 401) {
            alert("Vui lòng đăng nhập trước khi đặt hàng.");
            window.location.href = "/login";
            return;
        }

        if (!res.ok) {
            const error = await res.text();
            alert("Lỗi khi đặt hàng: " + error);
            return;
        }

        alert("Đặt hàng thành công!");
        window.location.href = "/cart";
    });
</script>
</body>
</html>
<%@ include file="layout/footer.jsp" %>