<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<%@ include file="layout/header.jsp" %>
<html>
<head>
    <title>Giỏ Hàng</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5" style="
    margin-top: 5rem !important;">
    <h2 class="mb-4">Giỏ Hàng Của Bạn</h2>
    <div id="cart-container">
        <div id="cart-items" class="table-responsive">
            <table class="table table-bordered" id="cart-table" style="display: none;">
                <thead class="table-dark">
                <tr>
                    <th>Hình ảnh</th>
                    <th>Sản phẩm</th>
                    <th>Số lượng</th>
                    <th>Giá</th>
                    <th>Tạm tính</th>
                </tr>
                </thead>
                <tbody id="cart-body"></tbody>
            </table>
        </div>
        <div id="cart-summary" class="mt-3" style="display: none;">
            <h5>Tổng số lượng: <span id="total-items-count"></span></h5>
            <h5>Tổng tiền: <span id="total-amount"></span> VND</h5>
        </div>
        <div id="cart-empty" class="alert alert-info" style="display: none;">
            Giỏ hàng của bạn đang trống.
        </div>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const token = localStorage.getItem("jwtToken");

        fetch("/api/cart", {
            method: "GET",
            headers: {
                "Content-Type": "application/json",
                "Authorization": "Bearer " + token
            }
        })
            .then(response => {
                if (!response.ok) {
                    throw new Error("Không thể lấy giỏ hàng.");
                }
                return response.json();
            })
            .then(data => {
                if (data.items && data.items.length > 0) {
                    document.getElementById("cart-table").style.display = "table";
                    document.getElementById("cart-summary").style.display = "block";

                    const tbody = document.getElementById("cart-body");
                    tbody.innerHTML = "";

                    data.items.forEach(item => {
                        const row = document.createElement("tr");

                        // Hình ảnh
                        const imgCell = document.createElement("td");
                        const img = document.createElement("img");
                        img.src = "/" + item.productImage;
                        img.width = 80;
                        img.height = 80;
                        img.alt = "product image";
                        img.onerror = function () {
                            this.src = "https://via.placeholder.com/80x80?text=No+Image";
                        };
                        imgCell.appendChild(img);
                        row.appendChild(imgCell);

                        // Tên sản phẩm
                        const nameCell = document.createElement("td");
                        nameCell.textContent = item.productName;
                        row.appendChild(nameCell);

                        // Số lượng
                        const qtyCell = document.createElement("td");
                        qtyCell.textContent = item.quantity + " cái";
                        row.appendChild(qtyCell);

                        // Giá
                        const priceCell = document.createElement("td");
                        priceCell.textContent = item.priceAtAddition.toLocaleString() + " VND";
                        row.appendChild(priceCell);

                        // Tạm tính
                        const subtotalCell = document.createElement("td");
                        subtotalCell.textContent = item.subTotal.toLocaleString() + " VND";
                        row.appendChild(subtotalCell);

                        tbody.appendChild(row);
                    });

                    document.getElementById("total-items-count").textContent = data.totalItemsCount.toLocaleString();
                    document.getElementById("total-amount").textContent = data.totalAmount.toLocaleString();
                } else {
                    document.getElementById("cart-empty").style.display = "block";
                }
            })
            .catch(error => {
                console.error(error);
                document.getElementById("cart-empty").textContent = "Lỗi khi tải giỏ hàng.";
                document.getElementById("cart-empty").style.display = "block";
            });
    });
</script>
</body>
</html>
<%@ include file="layout/footer.jsp" %>