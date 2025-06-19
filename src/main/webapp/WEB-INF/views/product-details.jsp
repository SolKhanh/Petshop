<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="layout/header.jsp" %>

<html>
<head>
    <title>${pageTitle}</title>
    <link rel="stylesheet" href="<c:url value='/css/product-detail.css'/>">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
<div class="container">
    <div class="product-detail-page">
        <!-- Breadcrumb -->
        <nav class="breadcrumb">
            <a href="<c:url value='/'/>">Trang chủ</a>
            <i class="fas fa-chevron-right"></i>
            <a href="<c:url value='/shop'/>">Sản phẩm</a>
            <i class="fas fa-chevron-right"></i>
            <span>${product.name}</span>
        </nav>

        <!-- Main Product Section -->
        <div class="product-main">
            <!-- Product Images -->
            <div class="product-images">
                <div class="main-image">
                    <img src="<c:url value='/${product.image}'/>" alt="${product.name}" id="mainImage">
                    <div class="image-zoom-overlay">
                        <i class="fas fa-search-plus"></i>
                    </div>
                </div>
            </div>

            <!-- Product Info -->
            <div class="product-info">
                <h1 class="product-title">${product.name}</h1>

                <!-- Product Rating & Views -->
                <div class="product-meta">
                    <div class="rating">
                        <div class="stars">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                        </div>
                        <span class="rating-text">(5.0)</span>
                    </div>
                    <div class="views">
                        <i class="fas fa-eye"></i>
                        <span>${product.viewCount} lượt xem</span>
                    </div>
                </div>

                <!-- Price Section -->
                <div class="price-section">
                    <c:choose>
                        <c:when test="${product.salePrice != null && product.salePrice < product.price}">
                            <div class="price-wrapper">
                                <span class="sale-price">
                                    <fmt:formatNumber value="${product.salePrice}" type="currency" currencySymbol="₫" minFractionDigits="0" maxFractionDigits="0"/>
                                </span>
                                <span class="original-price">
                                    <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="₫" minFractionDigits="0" maxFractionDigits="0"/>
                                </span>
                                <span class="discount-badge">
                                    -<fmt:formatNumber value="${(product.price - product.salePrice) / product.price * 100}" maxFractionDigits="0"/>%
                                </span>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <span class="current-price">
                                <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="₫" minFractionDigits="0" maxFractionDigits="0"/>
                            </span>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Product Description -->
                <div class="product-description">
                    <h3>Mô tả sản phẩm</h3>
                    <p>${product.description}</p>
                </div>

                <!-- Product Specifications -->
                <div class="product-specs">
                    <h3>Thông số kỹ thuật</h3>
                    <div class="specs-grid">
                        <div class="spec-item">
                            <span class="spec-label">Danh mục:</span>
                            <span class="spec-value">${product.categoryName}</span>
                        </div>
                        <div class="spec-item">
                            <span class="spec-label">Giống:</span>
                            <span class="spec-value">${product.giong}</span>
                        </div>
                        <div class="spec-item">
                            <span class="spec-label">Màu sắc:</span>
                            <span class="spec-value">${product.mausac}</span>
                        </div>
                        <div class="spec-item">
                            <span class="spec-label">Cân nặng:</span>
                            <span class="spec-value">${product.cannang}</span>
                        </div>
                        <div class="spec-item">
                            <span class="spec-label">Size:</span>
                            <span class="spec-value">${product.size}</span>
                        </div>
                        <div class="spec-item">
                            <span class="spec-label">Bảo hành:</span>
                            <span class="spec-value">${product.warranty}</span>
                        </div>
                    </div>
                </div>

                <!-- Quantity & Status -->
                <div class="quantity-status">
                    <div class="status-info">
                        <span class="status-label">Trạng thái:</span>
                        <span class="status-value ${product.status == 'Còn hàng' ? 'in-stock' : 'out-of-stock'}">
                            ${product.status}
                        </span>
                    </div>
                    <div class="quantity-info">
                        <span class="quantity-label">Còn lại:</span>
                        <span class="quantity-value">${product.quantity} sản phẩm</span>
                    </div>
                </div>

                <!-- Add to Cart Section -->
                <div class="add-to-cart-section">
                    <div class="quantity-selector">
                        <label>Số lượng:</label>
                        <div class="quantity-controls">
                            <button type="button" class="qty-btn minus">-</button>
                            <input type="number" value="1" min="1" max="${product.quantity}" class="qty-input">
                            <button type="button" class="qty-btn plus">+</button>
                        </div>
                    </div>
                    <button class="btn-add-to-cart add-to-cart-btn" data-product-id="${product.id}">
                        <i class="fas fa-shopping-cart"></i>
                        Thêm vào giỏ hàng
                    </button>
                </div>

                <!-- Additional Actions -->
                <div class="product-actions">
                    <button class="btn-secondary btn-wishlist">
                        <i class="far fa-heart"></i>
                        Yêu thích
                    </button>
                    <button class="btn-secondary btn-compare">
                        <i class="fas fa-balance-scale"></i>
                        So sánh
                    </button>
                    <button class="btn-secondary btn-share">
                        <i class="fas fa-share-alt"></i>
                        Chia sẻ
                    </button>
                </div>
            </div>
        </div>

        <!-- Related Products -->
        <div class="related-products-section">
            <h2 class="section-title">Sản phẩm liên quan</h2>
            <div class="related-products-grid">
                <c:forEach var="relatedProduct" items="${relatedProducts}">
                    <div class="related-product-card">
                        <a href="<c:url value='/products/${relatedProduct.id}'/>">
                            <div class="product-image-wrapper">
                                <img src="<c:url value='/${relatedProduct.image}'/>" alt="${relatedProduct.name}">
                                <div class="product-overlay">
                                    <i class="fas fa-eye"></i>
                                </div>
                            </div>
                            <div class="product-card-info">
                                <h4 class="product-name">${relatedProduct.name}</h4>
                                <div class="product-price">
                                    <fmt:formatNumber value="${relatedProduct.price}" type="currency" currencySymbol="₫" minFractionDigits="0" maxFractionDigits="0"/>
                                </div>
                            </div>
                        </a>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>
<%@ include file="layout/footer.jsp" %>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function() {
        // Quantity controls
        $('.qty-btn.plus').on('click', function() {
            var input = $(this).siblings('.qty-input');
            var max = parseInt(input.attr('max'));
            var current = parseInt(input.val());
            if (current < max) {
                input.val(current + 1);
            }
        });

        $('.qty-btn.minus').on('click', function() {
            var input = $(this).siblings('.qty-input');
            var min = parseInt(input.attr('min'));
            var current = parseInt(input.val());
            if (current > min) {
                input.val(current - 1);
            }
        });

        // Add to cart functionality (giữ nguyên script gốc)
        var jwtToken = localStorage.getItem('jwtToken'); // lấy token từ localStorage
        $('.add-to-cart-btn').on('click', function() {
            var productId = $(this).data('product-id');
            var quantity = parseInt($('.qty-input').val()) || 1;

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
                    if (xhr.status === 500) {
                        window.location.href = "/login";
                    }
                    else if (xhr.status === 401 || xhr.status === 403) {
                        alert("Bạn cần đăng nhập để thêm sản phẩm vào giỏ hàng.");
                    } else {
                        alert("Có lỗi khi thêm vào giỏ.");
                    }
                }
            });
        });

        // Image zoom effect
        $('.main-image').on('mouseenter', function() {
            $(this).addClass('zoom-active');
        }).on('mouseleave', function() {
            $(this).removeClass('zoom-active');
        });

        // Wishlist, compare, share buttons
        $('.btn-wishlist, .btn-compare, .btn-share').on('click', function() {
            alert('Tính năng đang được phát triển!');
        });
    });
</script>
</body>
</html>