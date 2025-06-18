<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="layout/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Giỏ Hàng</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>" type="text/css">
    <style>
        /* Custom styles thay thế Bootstrap */
        .cart-container {
            max-width: 1200px;
            margin: 5rem auto 0;
            padding: 0 20px;
        }

        .cart-title {
            font-size: 2rem;
            font-weight: bold;
            margin-bottom: 2rem;
            color: #333;
        }

        .table-responsive {
            overflow-x: auto;
        }

        .cart-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 2rem;
            background: white;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            border-radius: 8px;
            overflow: hidden;
        }

        .cart-table thead {
            background-color: #343a40;
            color: white;
        }

        .cart-table th,
        .cart-table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        .cart-table th {
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.9rem;
        }

        .cart-table tbody tr:hover {
            background-color: #f8f9fa;
        }

        .cart-table img {
            border-radius: 4px;
            object-fit: cover;
        }

        .quantity-controls {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .btn {
            padding: 6px 12px;
            border: 1px solid #ddd;
            background: white;
            cursor: pointer;
            border-radius: 4px;
            font-size: 14px;
            transition: all 0.2s;
        }

        .btn:hover {
            background: #f8f9fa;
        }

        .btn-outline-secondary {
            border-color: #6c757d;
            color: #6c757d;
        }

        .btn-outline-secondary:hover {
            background: #6c757d;
            color: white;
        }

        .btn-danger {
            background: #dc3545;
            color: white;
            border-color: #dc3545;
        }

        .btn-danger:hover {
            background: #c82333;
            border-color: #bd2130;
        }

        .btn-success {
            background: #28a745;
            color: white;
            border-color: #28a745;
            padding: 12px 24px;
            font-size: 16px;
            font-weight: 600;
        }

        .btn-success:hover {
            background: #218838;
            border-color: #1e7e34;
        }

        .cart-summary {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-top: 2rem;
        }

        .cart-summary h5 {
            margin: 0 0 15px 0;
            font-size: 1.2rem;
            color: #333;
        }

        .cart-summary h5:last-of-type {
            font-weight: bold;
            font-size: 1.4rem;
            color: #28a745;
            border-top: 2px solid #eee;
            padding-top: 15px;
        }

        .checkout-section {
            margin-top: 20px;
            text-align: right;
        }

        .alert {
            padding: 15px 20px;
            border-radius: 8px;
            margin-bottom: 20px;
        }

        .alert-info {
            background-color: #d1ecf1;
            border: 1px solid #bee5eb;
            color: #0c5460;
        }

        .quantity-display {
            min-width: 30px;
            text-align: center;
            font-weight: 600;
        }

        @media (max-width: 768px) {
            .cart-container {
                margin-top: 3rem;
                padding: 0 10px;
            }

            .cart-table {
                font-size: 14px;
            }

            .cart-table th,
            .cart-table td {
                padding: 8px 6px;
            }

            .quantity-controls {
                flex-direction: column;
                gap: 4px;
            }

            .btn {
                padding: 4px 8px;
                font-size: 12px;
            }
        }
    </style>
</head>
<body>
<div class="cart-container">
    <h2 class="cart-title">Giỏ Hàng Của Bạn</h2>
    <div id="cart-container">
        <div id="cart-items" class="table-responsive">
            <table class="cart-table" id="cart-table" style="display: none;">
                <thead>
                <tr>
                    <th>Hình ảnh</th>
                    <th>Sản phẩm</th>
                    <th>Số lượng</th>
                    <th>Giá</th>
                    <th>Tạm tính</th>
                    <th>Hành động</th>
                </tr>
                </thead>
                <tbody id="cart-body"></tbody>
            </table>
        </div>
        <div id="cart-summary" class="cart-summary" style="display: none;">
            <h5>Tổng số lượng: <span id="total-items-count"></span></h5>
            <h5>Tổng tiền: <span id="total-amount"></span> VND</h5>
            <div id="checkout-button" class="checkout-section" style="display: none;">
                <button class="btn btn-success" onclick="redirectToCheckout()">🛒 Thanh toán</button>
            </div>
        </div>
        <div id="cart-empty" class="alert alert-info" style="display: none;">
            Giỏ hàng của bạn đang trống.
        </div>
    </div>
</div>
<%@ include file="layout/footer.jsp" %>
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
                    console.log("bruhhh");
                    // window.location.href = "/login";
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

                        // Số lượng (thêm nút + -)
                        const qtyCell = document.createElement("td");
                        const qtyContainer = document.createElement("div");
                        qtyContainer.className = "quantity-controls";

                        const minusBtn = document.createElement("button");
                        minusBtn.textContent = "−";
                        minusBtn.className = "btn btn-outline-secondary";
                        minusBtn.onclick = () => updateQuantity(item.productId, item.quantity - 1);

                        const qtySpan = document.createElement("span");
                        qtySpan.className = "quantity-display";
                        qtySpan.textContent = item.quantity;

                        const plusBtn = document.createElement("button");
                        plusBtn.textContent = "+";
                        plusBtn.className = "btn btn-outline-secondary";
                        plusBtn.onclick = () => updateQuantity(item.productId, item.quantity + 1);

                        qtyContainer.appendChild(minusBtn);
                        qtyContainer.appendChild(qtySpan);
                        qtyContainer.appendChild(plusBtn);
                        qtyCell.appendChild(qtyContainer);
                        row.appendChild(qtyCell);

                        // Giá
                        const priceCell = document.createElement("td");
                        priceCell.textContent = item.priceAtAddition.toLocaleString() + " VND";
                        row.appendChild(priceCell);

                        // Tạm tính
                        const subtotalCell = document.createElement("td");
                        subtotalCell.textContent = item.subTotal.toLocaleString() + " VND";
                        row.appendChild(subtotalCell);

                        // Cột xóa
                        const deleteCell = document.createElement("td");
                        const deleteBtn = document.createElement("button");
                        deleteBtn.textContent = "Xóa";
                        deleteBtn.className = "btn btn-danger";
                        console.log("Item to delete:", item.productId);
                        deleteBtn.onclick = () => deleteItem(item.productId);
                        deleteCell.appendChild(deleteBtn);
                        row.appendChild(deleteCell);

                        tbody.appendChild(row);
                    });

                    document.getElementById("total-items-count").textContent = data.totalItemsCount.toLocaleString();
                    document.getElementById("total-amount").textContent = data.totalAmount.toLocaleString();
                    document.getElementById("checkout-button").style.display = "block";
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

    function redirectToCheckout() {
        window.location.href = "/order";
    }

    function updateQuantity(productId, newQuantity) {
        if (newQuantity < 1) {
            deleteItem(productId);
            return;
        }

        const token = localStorage.getItem("jwtToken");
        fetch(`/api/cart/items/`+productId, {
            method: "PUT",
            headers: {
                "Content-Type": "application/json",
                "Authorization": "Bearer " + token
            },
            body: JSON.stringify({ quantity: newQuantity })
        })
            .then(res => {
                if (res.ok) {
                    location.reload();
                } else {
                    alert("Đã hết số lượng sản phẩm.");
                }
            })
            .catch(error => {
                console.error(error);
                alert("Lỗi khi cập nhật.");
            });
    }

    function deleteItem(productId) {
        const token = localStorage.getItem("jwtToken");
        fetch(`/api/cart/items/`+productId, {
            method: "DELETE",
            headers: {
                "Authorization": "Bearer " + token
            }
        })
            .then(res => {
                if (res.ok) {
                    location.reload();
                } else {
                    console.log(res)
                    console.log(productId)
                    alert("Không thể xóa sản phẩm.");
                }
            })
            .catch(error => {
                console.error(error);
                alert("Lỗi khi xóa sản phẩm.");
            });
    }
</script>
</body>
</html>
<%@ include file="layout/footer.jsp" %>