<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="<c:url value='/css/orderhistory.css'/>" type="text/css">
<!DOCTYPE html>
<html>
<head>
    <title>Lịch Sử Đơn Hàng</title>
    <meta charset="UTF-8">
</head>

<jsp:include page="layout/header.jsp"></jsp:include>
<body>
<div class="container mt-5">
    <h2 class="mb-4">Lịch Sử Đơn Hàng</h2>

    <div id="order-list"></div>

    <div class="alert alert-info mt-3" id="no-orders" style="display: none;">
        Bạn chưa có đơn hàng nào.
    </div>
</div>
<jsp:include page="layout/footer.jsp"></jsp:include>
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
                        console.log(order);
                        const card = document.createElement("div");
                        card.className = "card mb-4";

                        const cardBody = document.createElement("div");
                        cardBody.className = "card-body";

                        const orderHeader = document.createElement("h5");
                        orderHeader.className = "card-title";

// Gộp chuỗi thành phần tử con thay vì textContent dài
                        const strong1 = document.createElement("strong");
                        strong1.textContent = "Đơn hàng #";

                        const orderIdSpan = document.createElement("span");
                        orderIdSpan.textContent = order.id;

                        const strong2 = document.createElement("strong");
                        strong2.textContent = " - Trạng thái: ";

                        const statusSpan = document.createElement("span");
                        statusSpan.textContent = order.status;

// Gắn lần lượt vào orderHeader
                        orderHeader.appendChild(strong1);
                        orderHeader.appendChild(orderIdSpan);
                        orderHeader.appendChild(strong2);
                        orderHeader.appendChild(statusSpan);

                        const orderDate = new Date(order.orderDate);
                        const formattedDate = orderDate.toLocaleString("vi-VN", {
                            year: "numeric",
                            month: "2-digit",
                            day: "2-digit",
                            hour: "2-digit",
                            minute: "2-digit",
                            second: "2-digit"
                        });
                        const orderInfo = document.createElement("div"); // Đổi từ <p> sang <div> để chứa nhiều phần tử con

                        const fields = [
                            { label: "Ngày đặt", value: formattedDate },
                            { label: "Khách hàng", value: order.customerName + ' - Số điện thoại: ' + order.phone },
                            { label: "Địa chỉ", value: order.shippingAddress },
                            { label: "Email", value: order.email },
                            { label: "Ghi chú", value: order.note || "Không" },
                            { label: "Tổng tiền", value: order.totalAmount.toLocaleString() + 'VND' }
                        ];

                        fields.forEach(f => {
                            const line = document.createElement("p");
                            const strong = document.createElement("strong");
                            strong.textContent = f.label + ": ";
                            line.appendChild(strong);
                            line.appendChild(document.createTextNode(f.value));
                            orderInfo.appendChild(line);
                        });

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