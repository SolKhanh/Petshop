<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>${pageTitle} - PetShop</title>
<%--    <link rel="stylesheet" href="<c:url value='/css/bootstrap.min.css'/>" type="text/css">--%>
<%--    <link rel="stylesheet" href="<c:url value='/css/style.css'/>" type="text/css"> &lt;%&ndash; Hoặc CSS chính của bạn &ndash;%&gt;--%>
    <style>
        .product-item { border: 1px solid #eee; margin-bottom: 15px; padding: 10px; }
        .product-item img { max-width: 100%; height: 200px; object-fit: cover; margin-bottom: 10px;}
        .product-item h5 { font-size: 1.1em; margin-bottom: 5px; }
        .product-item .price { font-weight: bold; color: #e53637; }
    </style>
</head>
<body>
<fmt:setLocale value="vi_VN"/>

<%-- Header đơn giản (có thể include từ file layout sau) --%>
<header>
    <div class="container">
        <h1><a href="<c:url value='/'/>">PetShop</a></h1>
        <nav>
            <a href="<c:url value='/'/>">Trang chủ</a> |
            <a href="<c:url value='/shop'/>">Cửa hàng</a>
        </nav>
    </div>
</header>

<div class="container" style="margin-top: 20px;">
    <h2>${pageTitle}</h2>

    <div class="row" id="product-list-container">
        <c:if test="${not empty productPage.content}">
            <c:forEach var="p" items="${productPage.content}">
                <div class="col-lg-4 col-md-6">
                    <div class="product-item">
                        <img src="<c:url value='/${fn:escapeXml(p.image)}'/>" alt="${fn:escapeXml(p.name)}">
                        <h5><a href="<c:url value='/products/${p.id}'/>">${fn:escapeXml(p.name)}</a></h5>
                        <div class="price">
                            <c:choose>
                                <c:when test="${p.salePrice != null && p.salePrice < p.price}">
                                    <fmt:formatNumber value="${p.salePrice}" type="currency" currencySymbol="" minFractionDigits="0" maxFractionDigits="0"/>đ
                                    <span><fmt:formatNumber value="${p.price}" type="currency" currencySymbol="" minFractionDigits="0" maxFractionDigits="0"/>đ</span>
                                </c:when>
                                <c:otherwise>
                                    <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="" minFractionDigits="0" maxFractionDigits="0"/>đ
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <p>Số lượng: ${p.quantity}</p>
                        <button class="btn btn-primary btn-sm add-to-cart-btn" data-product-id="${p.id}">Thêm vào giỏ</button>
                    </div>
                </div>
            </c:forEach>
        </c:if>
        <c:if test="${empty productPage.content}">
            <p>Không có sản phẩm nào phù hợp.</p>
        </c:if>
    </div>

    <%-- Hiển thị thông tin phân trang --%>
    <div class="product__pagination">
        <c:if test="${productPage.totalPages > 0}">
            <%-- Nút trang trước --%>
            <c:choose>
                <c:when test="${productPage.hasPrevious()}">
                    <a href="<c:url value='/shop?page=${productPage.number - 1}&size=${productPage.size}&categoryId=${selectedCategoryId}'/>"><i class="fa fa-long-arrow-left"></i></a>
                </c:when>
                <c:otherwise>
                    <a href="#" class="disabled"><i class="fa fa-long-arrow-left"></i></a>
                </c:otherwise>
            </c:choose>

            <%-- Các trang số --%>
            <c:forEach begin="0" end="${productPage.totalPages - 1}" varStatus="loop">
                <c:choose>
                    <c:when test="${productPage.number == loop.index}">
                        <a href="#" class="active">${loop.index + 1}</a>
                    </c:when>
                    <c:otherwise>
                        <a href="<c:url value='/shop?page=${loop.index}&size=${productPage.size}&categoryId=${selectedCategoryId}'/>">${loop.index + 1}</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>

            <%-- Nút trang sau --%>
            <c:choose>
                <c:when test="${productPage.hasNext()}">
                    <a href="<c:url value='/shop?page=${productPage.number + 1}&size=${productPage.size}&categoryId=${selectedCategoryId}'/>"><i class="fa fa-long-arrow-right"></i></a>
                </c:when>
                <c:otherwise>
                    <a href="#" class="disabled"><i class="fa fa-long-arrow-right"></i></a>
                </c:otherwise>
            </c:choose>
        </c:if>
    </div>

    <div id="pagination-controls" style="margin-top: 20px; text-align: center;">
        <button onclick="loadProducts(0)">Trang 1</button>
        <button onclick="loadProducts(1)">Trang 2</button>
        <button onclick="loadProducts(2)">Trang 3</button>
    </div>
</div>

<%-- Footer đơn giản --%>
<footer style="text-align: center; margin-top: 30px; padding: 20px; background-color: #f8f9fa;">
    <p>&copy; 2025 PetShop</p>
</footer>

<%--<script src="<c:url value='/js/jquery-3.3.1.min.js'/>"></script>--%>
<script>
    function formatCurrency(number) {
        return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(number);
    }

    function loadProducts(pageNumber) {
        const pageSize = 6; // Số sản phẩm mỗi trang
        const apiUrl = `<c:url value='/api/products'/>?page=<span class="math-inline">\{pageNumber\}&size\=</span>{pageSize}&sort=name,asc`;

        $("#product-list-container").html("<p>Đang tải sản phẩm...</p>"); // Xóa nội dung cũ và hiển thị loading

        $.ajax({
            url: apiUrl,
            type: "GET",
            success: function(response) {
                // response là một Page<ProductDTO>
                const products = response.content;
                let productHtml = "";
                if (products && products.length > 0) {
                    products.forEach(function(p) {
                        productHtml += `
                                <div class="col-lg-4 col-md-6">
                                    <div class="product-item">
                                        <%--<img src="<c:url value='/<span class="math-inline">\{fn\:escapeXml\(p\.image\)\}'/\>" alt\="</span>{fn:escapeXml(p.name)}">--%>
                                        <%--<h5><a href="<c:url value='/products/<span class="math-inline">\{p\.id\}'/\>"\></span>{fn:escapeXml(p.name)}</a></h5>--%>
                                        <div class="price">`;
                        if (p.salePrice && p.salePrice < p.price) {
                            productHtml += `<!--<span class="math-inline">\{formatCurrency\(p\.salePrice\)\} <del style\='color\: \#b2b2b2;'\></span>{formatCurrency(p.price)}</del>-->`;
                        } else {
                            productHtml += formatCurrency(p.price);
                        }
                        productHtml += `    </div>
                                        <p>Số lượng: <span class="math-inline">\{p\.quantity\}</p\>
<button class\="btn btn\-primary btn\-sm add\-to\-cart\-btn" data\-product\-id\="</span>{p.id}">Thêm vào giỏ</button>
                                    </div>
                                </div>
                            `;
                    });
                } else {
                    productHtml = "<p>Không có sản phẩm nào.</p>";
                }
                $("#product-list-container").html(productHtml);

                // Cập nhật thông tin phân trang (ví dụ)
                // Đây là phần đơn giản, bạn có thể làm phức tạp hơn sau
                let paginationInfo = `Trang ${response.number + 1} / ${response.totalPages}. Tổng số: ${response.totalElements} sản phẩm.`;
                // $("#pagination-controls").append("<p>" + paginationInfo + "</p>"); // Có thể hiển thị ở đâu đó

            },
            error: function(xhr) {
                $("#product-list-container").html("<p>Lỗi khi tải sản phẩm. Vui lòng thử lại.</p>");
                console.error("Error loading products: ", xhr.responseText);petshop_db
            }
        });
    }

    $(document).ready(function() {
        loadProducts(0); // Tải trang đầu tiên khi trang được load

        // Xử lý sự kiện click cho nút "Thêm vào giỏ" (chỉ alert)
        // Dùng event delegation vì các nút được thêm vào DOM sau
        $("#product-list-container").on("click", ".add-to-cart-btn", function() {
            const productId = $(this).data("product-id");
            alert("Bạn đã chọn thêm sản phẩm ID: " + productId + " vào giỏ. (Logic AJAX sẽ được xử lý sau)");
            // Sau này bạn sẽ gọi API /api/cart/items ở đây
        });
    });
</script>
</body>
</html>