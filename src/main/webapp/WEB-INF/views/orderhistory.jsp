<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Lịch Sử Đơn Hàng</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">
    <h2 class="mb-4">Lịch Sử Đơn Hàng</h2>

    <div id="order-list"></div>

    <div class="alert alert-info mt-3" id="no-orders" style="display: none;">
        Bạn chưa có đơn hàng nào.
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const token = localStorage.getItem("jwtToken");

        fetch("/api/orders/my-orders", {
            method: "GET",
            headers: {
                "Content-Type": "application/json",
                "Authorization": "Bearer " + token
            }
        })
            .then(response => {
                if (!response.ok) {
                    throw new Error("Không thể lấy lịch sử đơn hàng.");
                }
                return response.json();
            })
            .then(data => {
                const orderList = document.getElementById("order-list");

                if (data.content && data.content.length > 0) {
                    data.content.forEach(order => {
                        const card = document.createElement("div");
                        card.className = "card mb-4";

                        const cardBody = document.createElement("div");
                        cardBody.className = "card-body";

                        const orderHeader = document.createElement("h5");
                        orderHeader.className = "card-title";
                        orderHeader.textContent = `Đơn hàng #${order.id} - Trạng thái: ${order.status}`;

                        const orderInfo = document.createElement("p");
                        orderInfo.innerHTML = `
                        <strong>Ngày đặt:</strong> ${new Date(order.orderDate).toLocaleString()}<br>
                        <strong>Khách hàng:</strong> ${order.customerName} - ${order.phone}<br>
                        <strong>Địa chỉ:</strong> ${order.shippingAddress}<br>
                        <strong>Email:</strong> ${order.email}<br>
                        <strong>Ghi chú:</strong> ${order.note || "Không"}<br>
                        <strong>Tổng tiền:</strong> ${order.totalAmount.toLocaleString()} VND
                    `;

                        // Bảng sản phẩm trong đơn hàng
                        const table = document.createElement("table");
                        table.className = "table table-striped mt-3";
                        const thead = document.createElement("thead");
                        thead.innerHTML = `
                        <tr>
                            <th>Sản phẩm</th>
                            <th>Số lượng</th>
                            <th>Giá</th>
                            <th>Tạm tính</th>
                        </tr>
                    `;
                        table.appendChild(thead);

                        const tbody = document.createElement("tbody");
                        order.items.forEach(item => {
                            const row = document.createElement("tr");

                            const name = document.createElement("td");
                            name.textContent = item.productName;

                            const qty = document.createElement("td");
                            qty.textContent = item.quantity;

                            const price = document.createElement("td");
                            price.textContent = item.price.toLocaleString() + " VND";

                            const subtotal = document.createElement("td");
                            subtotal.textContent = item.subTotal.toLocaleString() + " VND";

                            row.appendChild(name);
                            row.appendChild(qty);
                            row.appendChild(price);
                            row.appendChild(subtotal);

                            tbody.appendChild(row);
                        });

                        table.appendChild(tbody);

                        // Gắn vào card
                        cardBody.appendChild(orderHeader);
                        cardBody.appendChild(orderInfo);
                        cardBody.appendChild(table);
                        card.appendChild(cardBody);
                        orderList.appendChild(card);
                    });
                } else {
                    document.getElementById("no-orders").style.display = "block";
                }
            })
            .catch(error => {
                console.error(error);
                document.getElementById("no-orders").textContent = "Lỗi khi tải đơn hàng.";
                document.getElementById("no-orders").style.display = "block";
            });
    });
</script>
</body>
</html>