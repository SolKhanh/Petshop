<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="description" content="Pet Shop - Nơi tốt nhất cho thú cưng của bạn">
    <meta name="keywords" content="PetShop, thú cưng, chó, mèo, phụ kiện">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Pet Shop - Trang Chủ</title>

    <!-- Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">

    <!-- Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <!-- Bootstrap -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">

    <!-- AOS Animation -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.css" rel="stylesheet">

    <style>
        :root {
            --primary-color: #ff6b6b;
            --secondary-color: #4ecdc4;
            --accent-color: #45b7d1;
            --dark-color: #2c3e50;
            --light-color: #f8f9fa;
            --gradient-primary: linear-gradient(135deg, #ff6b6b 0%, #ee5a24 100%);
            --gradient-secondary: linear-gradient(135deg, #4ecdc4 0%, #44a08d 100%);
            --shadow-soft: 0 10px 30px rgba(0,0,0,0.1);
            --shadow-hover: 0 15px 40px rgba(0,0,0,0.15);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Nunito', sans-serif;
            line-height: 1.6;
            color: var(--dark-color);
            overflow-x: hidden;
        }

        /* Header Styles */
        .navbar {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            box-shadow: var(--shadow-soft);
            transition: all 0.3s ease;
            position: fixed;
            top: 0;
            width: 100%;
            z-index: 1000;
        }

        .navbar-brand img {
            height: 50px;
            transition: transform 0.3s ease;
        }

        .navbar-brand:hover img {
            transform: scale(1.05);
        }

        .navbar-nav .nav-link {
            font-weight: 600;
            color: var(--dark-color) !important;
            margin: 0 10px;
            position: relative;
            transition: all 0.3s ease;
        }

        .navbar-nav .nav-link::after {
            content: '';
            position: absolute;
            width: 0;
            height: 2px;
            bottom: -5px;
            left: 50%;
            background: var(--gradient-primary);
            transition: all 0.3s ease;
            transform: translateX(-50%);
        }

        .navbar-nav .nav-link:hover::after,
        .navbar-nav .nav-link.active::after {
            width: 100%;
        }

        /* Hero Section */
        .hero {
            height: 100vh;
            background: linear-gradient(rgba(0,0,0,0.4), rgba(0,0,0,0.4)), url('<c:url value="/img/hero/banner.jpg"/>');
            background-size: cover;
            background-position: center;
            display: flex;
            align-items: center;
            position: relative;
            overflow: hidden;
        }

        .hero::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: var(--gradient-primary);
            opacity: 0.8;
            z-index: 1;
        }

        .hero-content {
            position: relative;
            z-index: 2;
            text-align: center;
            color: white;
        }

        .hero-badge {
            background: rgba(255, 255, 255, 0.2);
            backdrop-filter: blur(10px);
            padding: 10px 25px;
            border-radius: 50px;
            display: inline-block;
            margin-bottom: 20px;
            font-weight: 600;
            letter-spacing: 1px;
            text-transform: uppercase;
            font-size: 0.9rem;
        }

        .hero-title {
            font-size: 4rem;
            font-weight: 800;
            margin-bottom: 20px;
            line-height: 1.2;
        }

        .hero-subtitle {
            font-size: 1.3rem;
            margin-bottom: 30px;
            opacity: 0.9;
        }

        .btn-hero {
            background: var(--gradient-secondary);
            border: none;
            padding: 15px 40px;
            border-radius: 50px;
            color: white;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: all 0.3s ease;
            box-shadow: var(--shadow-soft);
        }

        .btn-hero:hover {
            transform: translateY(-3px);
            box-shadow: var(--shadow-hover);
            color: white;
        }

        /* Categories Section */
        .categories {
            padding: 100px 0;
            background: var(--light-color);
        }

        .section-title {
            text-align: center;
            margin-bottom: 60px;
        }

        .section-title h2 {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--dark-color);
            position: relative;
            display: inline-block;
        }

        .section-title h2::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 60px;
            height: 4px;
            background: var(--gradient-primary);
            border-radius: 2px;
        }

        .category-card {
            background: white;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: var(--shadow-soft);
            transition: all 0.3s ease;
            position: relative;
            height: 250px;
        }

        .category-card:hover {
            transform: translateY(-10px);
            box-shadow: var(--shadow-hover);
        }

        .category-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: var(--gradient-primary);
            opacity: 0;
            transition: opacity 0.3s ease;
            z-index: 1;
        }

        .category-card:hover::before {
            opacity: 0.8;
        }

        .category-card .card-content {
            position: absolute;
            bottom: 20px;
            left: 20px;
            right: 20px;
            z-index: 2;
            color: white;
        }

        .category-card h5 {
            font-size: 1.3rem;
            font-weight: 700;
            margin: 0;
        }

        .category-card a {
            text-decoration: none;
            color: inherit;
        }

        /* Featured Products */
        .featured {
            padding: 100px 0;
        }

        .product-card {
            background: white;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: var(--shadow-soft);
            transition: all 0.3s ease;
            margin-bottom: 30px;
        }

        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-hover);
        }

        .product-image {
            position: relative;
            height: 250px;
            overflow: hidden;
        }

        .product-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s ease;
        }

        .product-card:hover .product-image img {
            transform: scale(1.1);
        }

        .discount-badge {
            position: absolute;
            top: 15px;
            left: 15px;
            background: var(--gradient-primary);
            color: white;
            padding: 5px 15px;
            border-radius: 20px;
            font-weight: 700;
            font-size: 0.8rem;
            z-index: 2;
        }

        .product-actions {
            position: absolute;
            top: 15px;
            right: 15px;
            display: flex;
            flex-direction: column;
            gap: 10px;
            opacity: 0;
            transform: translateX(20px);
            transition: all 0.3s ease;
        }

        .product-card:hover .product-actions {
            opacity: 1;
            transform: translateX(0);
        }

        .action-btn {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            border: none;
            background: rgba(255, 255, 255, 0.9);
            color: var(--dark-color);
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s ease;
            box-shadow: var(--shadow-soft);
        }

        .action-btn:hover {
            background: var(--primary-color);
            color: white;
            transform: scale(1.1);
        }

        .product-info {
            padding: 25px;
        }

        .product-title {
            font-size: 1.1rem;
            font-weight: 700;
            margin-bottom: 10px;
            color: var(--dark-color);
        }

        .product-title a {
            text-decoration: none;
            color: inherit;
            transition: color 0.3s ease;
        }

        .product-title a:hover {
            color: var(--primary-color);
        }

        .product-price {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .current-price {
            font-size: 1.3rem;
            font-weight: 700;
            color: var(--primary-color);
        }

        .original-price {
            font-size: 1rem;
            color: #999;
            text-decoration: line-through;
        }

        /* Banner Section */
        .banner-section {
            padding: 80px 0;
            background: var(--light-color);
        }

        .banner-item {
            border-radius: 20px;
            overflow: hidden;
            box-shadow: var(--shadow-soft);
            transition: all 0.3s ease;
        }

        .banner-item:hover {
            transform: scale(1.02);
            box-shadow: var(--shadow-hover);
        }

        .banner-item img {
            width: 100%;
            height: 300px;
            object-fit: cover;
        }



        /* Mobile Menu */
        .mobile-menu-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.8);
            z-index: 9998;
            opacity: 0;
            visibility: hidden;
            transition: all 0.3s ease;
        }

        .mobile-menu-overlay.active {
            opacity: 1;
            visibility: visible;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .hero-title {
                font-size: 2.5rem;
            }

            .hero-subtitle {
                font-size: 1.1rem;
            }

            .section-title h2 {
                font-size: 2rem;
            }

            .product-info {
                padding: 20px;
            }
        }

        /* Loading Animation */
        .preloader {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: white;
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 9999;
            transition: opacity 0.5s ease;
        }

        .loader {
            width: 50px;
            height: 50px;
            border: 5px solid #f3f3f3;
            border-top: 5px solid var(--primary-color);
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>
</head>
<body>
<fmt:setLocale value="vi_VN"/>

<!-- Preloader -->
<div class="preloader" id="preloader">
    <div class="loader"></div>
</div>

<!-- Header -->
<nav class="navbar navbar-expand-lg">
    <div class="container">
        <a class="navbar-brand" href="<c:url value='/'/>">
            <img src="<c:url value='/img/petshoplogo.jpg'/>" alt="PetShop Logo">
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link active" href="<c:url value='/'/>">Trang chủ</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<c:url value='/shop'/>">Sản phẩm</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<c:url value='/contact'/>">Liên Hệ</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<section class="hero">
    <div class="container">
        <div class="hero-content" data-aos="fade-up">
            <div class="hero-badge">PETSHOP YÊU THƯƠNG</div>
            <h1 class="hero-title">Thú Cưng<br>100% Khỏe Mạnh</h1>
            <p class="hero-subtitle">Miễn phí vận chuyển &amp; Bảo hành chất lượng</p>
            <a href="<c:url value='/login'/>" class="btn btn-hero">Mua Ngay</a>
        </div>
    </div>
</section>

<!-- Categories Section -->
<c:if test="${not empty categoriesForSlider}">
    <section class="categories">
        <div class="container">
            <div class="section-title" data-aos="fade-up">
                <h2>Danh Mục Sản Phẩm</h2>
            </div>
            <div class="row">
                <c:forEach var="category" items="${categoriesForSlider}" varStatus="status">
                    <div class="col-lg-3 col-md-6 mb-4" data-aos="fade-up" data-aos-delay="${status.index * 100}">
                        <div class="category-card" style="background-image: url('<c:url value='${not empty category.imagePath ? category.imagePath : "/img/categories/default-cat.jpg"}'/>');">
                            <div class="card-content">
                                <h5><a href="<c:url value='/products?categoryId=${category.id}'/>">${category.name}</a></h5>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </section>
</c:if>

<!-- Featured Products -->
<c:if test="${not empty featuredProducts}">
    <section class="featured">
        <div class="container">
            <div class="section-title" data-aos="fade-up">
                <h2>Sản Phẩm Nổi Bật</h2>
            </div>
            <div class="row">
                <c:forEach var="p" items="${featuredProducts}" varStatus="status">
                    <div class="col-lg-3 col-md-6" data-aos="fade-up" data-aos-delay="${status.index * 100}">
                        <div class="product-card">
                            <div class="product-image">
                                <img src="<c:url value='${p.image}'/>" alt="${p.name}">

                                <c:if test="${p.salePrice != null && p.price > p.salePrice}">
                                    <fmt:parseNumber var="originalPrice" type="number" value="${p.price}" />
                                    <fmt:parseNumber var="discountedPrice" type="number" value="${p.salePrice}" />
                                    <c:if test="${originalPrice > 0}">
                                        <c:set var="discountPercent" value="${(originalPrice - discountedPrice) * 100 / originalPrice}" />
                                        <div class="discount-badge">-<fmt:formatNumber value="${discountPercent}" maxFractionDigits="0"/>%</div>
                                    </c:if>
                                </c:if>

                                <div class="product-actions">
                                    <button class="action-btn add-wishlist-link" data-product-id="${p.id}">
                                        <i class="fa fa-heart"></i>
                                    </button>
                                    <button class="action-btn add-to-cart-link" data-product-id="${p.id}">
                                        <i class="fa fa-shopping-cart"></i>
                                    </button>
                                </div>
                            </div>

                            <div class="product-info">
                                <div class="product-title">
                                    <a href="<c:url value='/products/${p.id}'/>">${p.name}</a>
                                </div>
                                <div class="product-price">
                                    <c:choose>
                                        <c:when test="${p.salePrice != null && p.salePrice < p.price}">
                                                <span class="current-price">
                                                    <fmt:formatNumber value="${p.salePrice}" type="currency" currencySymbol="" minFractionDigits="0" maxFractionDigits="0"/>đ
                                                </span>
                                            <span class="original-price">
                                                    <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="" minFractionDigits="0" maxFractionDigits="0"/>đ
                                                </span>
                                        </c:when>
                                        <c:otherwise>
                                                <span class="current-price">
                                                    <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="" minFractionDigits="0" maxFractionDigits="0"/>đ
                                                </span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </section>
</c:if>

<!-- Banner Section -->
<section class="banner-section">
    <div class="container">
        <div class="row">
            <div class="col-lg-6 mb-4" data-aos="fade-right">
                <div class="banner-item">
                    <img src="<c:url value='/img/banner/banner-1.jpg'/>" alt="Banner 1">
                </div>
            </div>
            <div class="col-lg-6 mb-4" data-aos="fade-left">
                <div class="banner-item">
                    <img src="<c:url value='/img/banner/banner-2.jpg'/>" alt="Banner 2">
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Footer -->
<%@ include file="layout/footer.jsp" %>

<!-- Scripts -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.js"></script>
<script src="<c:url value='/js/jquery-3.3.1.min.js'/>"></script>
<script src="<c:url value='/js/custom-script.js'/>"></script>

<script>
    // Initialize AOS
    AOS.init({
        duration: 800,
        once: true,
        offset: 100
    });

    // Hide preloader
    window.addEventListener('load', function() {
        const preloader = document.getElementById('preloader');
        preloader.style.opacity = '0';
        setTimeout(() => {
            preloader.style.display = 'none';
        }, 500);
    });

    // Navbar scroll effect
    window.addEventListener('scroll', function() {
        const navbar = document.querySelector('.navbar');
        if (window.scrollY > 100) {
            navbar.style.background = 'rgba(255, 255, 255, 0.98)';
        } else {
            navbar.style.background = 'rgba(255, 255, 255, 0.95)';
        }
    });

    // Add to cart functionality
    document.querySelectorAll('.add-to-cart-link').forEach(button => {
        button.addEventListener('click', function(e) {
            e.preventDefault();
            const productId = this.getAttribute('data-product-id');
            // Add your cart logic here
            console.log('Add to cart:', productId);
        });
    });

    // Add to wishlist functionality
    document.querySelectorAll('.add-wishlist-link').forEach(button => {
        button.addEventListener('click', function(e) {
            e.preventDefault();
            const productId = this.getAttribute('data-product-id');
            // Add your wishlist logic here
            console.log('Add to wishlist:', productId);
        });
    });
</script>
</body>
</html>