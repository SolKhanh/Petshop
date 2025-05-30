<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="layout/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Giỏ hàng của bạn</title>
    <link rel="stylesheet" href="<c:url value='/css/cart.css'/>" />
</head>
<body>
<div class="container">
    <h2 class="title">🛒 Giỏ hàng của bạn</h2>

    <!-- Hiển thị thông báo lỗi nếu có -->
    <c:if test="${not empty errorMessage}">
        <p class="error">${errorMessage}</p>
    </c:if>

    <!-- Nếu giỏ hàng có sản phẩm -->
    <c:if test="${not empty cart}">
        <table class="cart-table">
            <thead>
            <tr>
                <th>Sản phẩm</th>
                <th>Hình ảnh</th>
                <th>Giá</th>
                <th>Số lượng</th>
                <th>Tổng</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="item" items="${cart.items}">
                <tr>
                    <td>${item.productName}</td>
                    <td>
                        <a href="<c:url value='/products/${item.productId}' />">
                            <img src="${item.productImage}" alt="${item.productName}" class="product-image" />
                        </a>
                    </td>
                    <td><fmt:formatNumber value="${item.priceAtAddition}" type="currency" currencySymbol="đ" minFractionDigits="0" maxFractionDigits="0"/></td>
                    <td>${item.quantity}</td>
                    <td><fmt:formatNumber value="${item.subTotal}" type="currency" currencySymbol="đ" minFractionDigits="0" maxFractionDigits="0"/></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

        <h3 class="total">Tổng tiền:
            <fmt:formatNumber value="${cart.totalAmount}" type="currency" currencySymbol="đ" minFractionDigits="0" maxFractionDigits="0"/>
        </h3>

        <a href="/checkout" class="checkout-btn">Thanh toán</a>
    </c:if>

    <!-- Nếu giỏ hàng trống -->
    <c:if test="${empty cart}">
        <p class="empty">Giỏ hàng của bạn hiện đang trống.</p>
    </c:if>
</div>
</body>
</html>
