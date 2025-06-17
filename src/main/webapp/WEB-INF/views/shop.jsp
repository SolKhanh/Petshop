<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="layout/header.jsp" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>${pageTitle} - PetShop</title>
    <link rel="stylesheet" href="<c:url value='/css/shop.css'/>" type="text/css">
</head>
<body>
<fmt:setLocale value="vi_VN"/>

<div class="shop-container">
    <h2 class="shop-title">Khám phá các sản phẩm mới nhất của chúng tôi</h2>

    <div class="product-list">
        <c:if test="${not empty productPage.content}">
            <c:forEach var="p" items="${productPage.content}">
                <div class="product-card">
                    <a href="<c:url value='/products/${p.id}'/>">
                        <img class="product-image" src="<c:url value='/${fn:escapeXml(p.image)}'/>" alt="${fn:escapeXml(p.name)}">
                    </a>
                    <div class="product-info">
                        <h3><a href="<c:url value='/products/${p.id}'/>">${fn:escapeXml(p.name)}</a></h3>
                        <div class="product-price">
                            <c:choose>
                                <c:when test="${p.salePrice != null && p.salePrice < p.price}">
                                    <span class="sale">
                                        <fmt:formatNumber value="${p.salePrice}" type="currency" currencySymbol="" />đ
                                    </span>
                                    <span class="original">
                                        <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="" />đ
                                    </span>
                                </c:when>
                                <c:otherwise>
                                    <span class="normal">
                                        <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="" />đ
                                    </span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <p class="product-quantity">Còn lại: ${p.quantity}</p>
                        <button class="add-to-cart-btn" data-product-id="${p.id}">Thêm vào giỏ</button>
                    </div>
                </div>
            </c:forEach>
        </c:if>
        <c:if test="${empty productPage.content}">
            <p>Không có sản phẩm nào phù hợp.</p>
        </c:if>
    </div>

    <!-- Phân trang -->
    <div class="pagination">
        <c:if test="${productPage.totalPages > 0}">
            <c:if test="${productPage.hasPrevious()}">
                <a href="<c:url value='/shop?page=${productPage.number - 1}&size=${productPage.size}&categoryId=${selectedCategoryId}'/>">&laquo;</a>
            </c:if>
            <c:forEach begin="0" end="${productPage.totalPages - 1}" varStatus="loop">
                <a class="${productPage.number == loop.index ? 'active' : ''}"
                   href="<c:url value='/shop?page=${loop.index}&size=${productPage.size}&categoryId=${selectedCategoryId}'/>">${loop.index + 1}</a>
            </c:forEach>
            <c:if test="${productPage.hasNext()}">
                <a href="<c:url value='/shop?page=${productPage.number + 1}&size=${productPage.size}&categoryId=${selectedCategoryId}'/>">&raquo;</a>
            </c:if>
        </c:if>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $('.add-to-cart-btn').on('click', function () {
        var productId = $(this).data('product-id');
        var jwtToken = localStorage.getItem('jwtToken'); // lấy token từ localStorage

        $.ajax({
            url: '/api/cart/items',
            type: 'POST',
            contentType: 'application/json',
            headers: {
                'Authorization': 'Bearer ' + jwtToken // thêm token vào header
            },
            data: JSON.stringify({ productId: productId, quantity: 1 }),
            success: function () {
                alert("Đã thêm sản phẩm vào giỏ hàng.");
            },
            error: function (xhr) {
                if (xhr.status === 401 || xhr.status === 403) {
                    alert("Bạn cần đăng nhập để thêm sản phẩm vào giỏ hàng.");
                } else {
                    alert("Có lỗi khi thêm vào giỏ.");
                }
            }
        });
    });
</script>

</body>
</html>
