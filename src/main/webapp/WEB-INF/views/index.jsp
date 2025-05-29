<%--<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>--%>
<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<%--<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>--%>
<%--<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>--%>

<%--<!DOCTYPE html>--%>
<%--<html lang="vi">--%>
<%--<head>--%>
<%--    <meta charset="UTF-8">--%>
<%--    <meta name="description" content="Pet Shop - Nơi tốt nhất cho thú cưng của bạn">--%>
<%--    <meta name="keywords" content="PetShop, thú cưng, chó, mèo, phụ kiện">--%>
<%--    <meta name="viewport" content="width=device-width, initial-scale=1.0">--%>
<%--    <meta http-equiv="X-UA-Compatible" content="ie=edge">--%>
<%--    <title>Pet Shop - Trang Chủ</title>--%>

<%--    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A==" crossorigin="anonymous" referrerpolicy="no-referrer" />--%>
<%--&lt;%&ndash;    <link rel="icon" type="image/png" sizes="16x16"  href="<c:url value='/img/favicons/favicon-16x16.png'/>">&ndash;%&gt;--%>

<%--&lt;%&ndash;    <link rel="stylesheet" href="<c:url value='/css/bootstrap.min.css'/>" type="text/css">&ndash;%&gt;--%>
<%--&lt;%&ndash;    <link rel="stylesheet" href="<c:url value='/css/font-awesome.min.css'/>" type="text/css">&ndash;%&gt;--%>
<%--&lt;%&ndash;    <link rel="stylesheet" href="<c:url value='/css/elegant-icons.css'/>" type="text/css">&ndash;%&gt;--%>
<%--&lt;%&ndash;    <link rel="stylesheet" href="<c:url value='/css/nice-select.css'/>" type="text/css">&ndash;%&gt;--%>
<%--&lt;%&ndash;    <link rel="stylesheet" href="<c:url value='/css/jquery-ui.min.css'/>" type="text/css">&ndash;%&gt;--%>
<%--&lt;%&ndash;    <link rel="stylesheet" href="<c:url value='/css/owl.carousel.min.css'/>" type="text/css">&ndash;%&gt;--%>
<%--&lt;%&ndash;    <link rel="stylesheet" href="<c:url value='/css/slicknav.min.css'/>" type="text/css">&ndash;%&gt;--%>
<%--&lt;%&ndash;    <link rel="stylesheet" href="<c:url value='/css/style.css'/>" type="text/css">&ndash;%&gt;--%>
<%--&lt;%&ndash;    <link rel="stylesheet" href="<c:url value='/css/custom-styles.css'/>" type="text/css"> &lt;%&ndash; File CSS tùy chỉnh của bạn nếu có &ndash;%&gt;&ndash;%&gt;--%>

<%--</head>--%>
<%--<body>--%>
<%--<fmt:setLocale value="vi_VN"/>--%>

<%--<div id="preloder">--%>
<%--    <div class="loader"></div>--%>
<%--</div>--%>

<%--<div class="humberger__menu__overlay"></div>--%>
<%--<div class="humberger__menu__wrapper">--%>
<%--    <div class="humberger__menu__logo">--%>
<%--        <a href="<c:url value='/'/>"><img src="<c:url value='/img/petshoplogo.jpg'/>" alt="PetShop Logo"></a>--%>
<%--    </div>--%>
<%--    &lt;%&ndash; Tạm ẩn phần giỏ hàng và đăng nhập trên humberger &ndash;%&gt;--%>
<%--    &lt;%&ndash;--%>
<%--    <div class="humberger__menu__cart">--%>
<%--        <ul>--%>
<%--            <li><a href="#"><i class="fa fa-heart"></i> <span>0</span></a></li>--%>
<%--            <li><a href="#"><i class="fa fa-shopping-bag"></i> <span>0</span></a></li>--%>
<%--        </ul>--%>
<%--        <div class="header__cart__price">Tổng: <span><fmt:formatNumber value="0" type="currency" currencySymbol="đ"/></span></div>--%>
<%--    </div>--%>
<%--    <div class="humberger__menu__widget">--%>
<%--        <div class="header__top__right__auth">--%>
<%--            <a href="<c:url value='/login'/>"><i class="fa fa-user"></i> Đăng Nhập</a>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--     &ndash;%&gt;--%>
<%--    <nav class="humberger__menu__nav mobile-menu">--%>
<%--        <ul>--%>
<%--            <li class="active"><a href="<c:url value='/'/>">Trang chủ</a></li>--%>
<%--            <li><a href="<c:url value='/products'/>">Sản phẩm</a></li>--%>
<%--            <li><a href="<c:url value='/contact'/>">Liên Hệ</a></li>--%>
<%--        </ul>--%>
<%--    </nav>--%>
<%--    <div id="mobile-menu-wrap"></div>--%>
<%--    <div class="header__top__right__social">--%>
<%--        <a href="#"><i class="fa fa-facebook"></i></a>--%>
<%--        <a href="#"><i class="fa fa-twitter"></i></a>--%>
<%--    </div>--%>
<%--    <div class="humberger__menu__contact">--%>
<%--        <ul>--%>
<%--            <li><i class="fa fa-envelope"></i> contact@petshop.com</li>--%>
<%--            <li>Miễn phí vận chuyển cho đơn hàng từ 500.000đ</li>--%>
<%--        </ul>--%>
<%--    </div>--%>
<%--</div>--%>
<%--<jsp:include page="layout/header.jsp"></jsp:include>--%>
<%--<section class="hero">--%>
<%--    <div class="container">--%>
<%--        <div class="row">--%>
<%--            <div class="col-lg-12">--%>
<%--                <div class="hero__item set-bg" data-setbg="<c:url value='/img/hero/banner.jpg'/>">--%>
<%--                    <div class="hero__text">--%>
<%--                        <span>PETSHOP YÊU THƯƠNG</span>--%>
<%--                        <h2>Thú Cưng <br />100% Khỏe Mạnh</h2>--%>
<%--                        <p>Miễn phí vận chuyển &amp; Bảo hành</p>--%>
<%--                        <a href="<c:url value='/products'/>" class="primary-btn">MUA NGAY</a>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</section>--%>
<%--<c:if test="${not empty categoriesForSlider}">--%>
<%--    <section class="categories">--%>
<%--        <div class="container">--%>
<%--            <div class="row">--%>
<%--                <div class="categories__slider owl-carousel">--%>
<%--                    <c:forEach var="category" items="${categoriesForSlider}">--%>
<%--                        <div class="col-lg-3">--%>
<%--                                &lt;%&ndash; Giả sử mỗi CategoryDTO có một trường 'imagePath' hoặc dùng ảnh mặc định &ndash;%&gt;--%>
<%--                            <div class="categories__item set-bg" data-setbg="<c:url value='${not empty category.imagePath ? category.imagePath : "/img/categories/default-cat.jpg"}'/>">--%>
<%--                                <h5><a href="<c:url value='/products?categoryId=${category.id}'/>">${category.name}</a></h5>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </c:forEach>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </section>--%>
<%--</c:if>--%>
<%--<c:if test="${not empty featuredProducts}">--%>
<%--    <section class="featured spad">--%>
<%--        <div class="container">--%>
<%--            <div class="row">--%>
<%--                <div class="col-lg-12">--%>
<%--                    <div class="section-title">--%>
<%--                        <h2>Sản Phẩm Nổi Bật</h2>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--            <div class="row featured__filter">--%>
<%--                <c:forEach var="p" items="${featuredProducts}">--%>
<%--                    <div class="col-lg-3 col-md-4 col-sm-6">--%>
<%--                        <div class="featured__item">--%>
<%--                            <div class="featured__item__pic set-bg" data-setbg="<c:url value='${p.image}'/>">--%>
<%--                                <c:if test="${p.salePrice != null && p.price > p.salePrice}">--%>
<%--                                    <fmt:parseNumber var="originalPrice" type="number" value="${p.price}" />--%>
<%--                                    <fmt:parseNumber var="discountedPrice" type="number" value="${p.salePrice}" />--%>
<%--                                    <c:if test="${originalPrice > 0}"> &lt;%&ndash; Tránh chia cho 0 &ndash;%&gt;--%>
<%--                                        <c:set var="discountPercent" value="${(originalPrice - discountedPrice) * 100 / originalPrice}" />--%>
<%--                                        <div class="product__discount__percent">-<fmt:formatNumber value="${discountPercent}" maxFractionDigits="0"/>%</div>--%>
<%--                                    </c:if>--%>
<%--                                </c:if>--%>
<%--                                <ul class="featured__item__pic__hover">--%>
<%--                                    <li><a href="#" class="add-wishlist-link" data-product-id="${p.id}"><i class="fa fa-heart"></i></a></li>--%>
<%--                                    <li><a href="#" class="add-to-cart-link" data-product-id="${p.id}"><i class="fa fa-shopping-cart"></i></a></li>--%>
<%--                                </ul>--%>
<%--                            </div>--%>
<%--                            <div class="featured__item__text">--%>
<%--                                <h6><a href="<c:url value='/products/${p.id}'/>">${p.name}</a></h6>--%>
<%--                                <div class="product__item__price">--%>
<%--                                    <c:choose>--%>
<%--                                        <c:when test="${p.salePrice != null && p.salePrice < p.price}">--%>
<%--                                            <fmt:formatNumber value="${p.salePrice}" type="currency" currencySymbol="" minFractionDigits="0" maxFractionDigits="0"/>đ--%>
<%--                                            <span><fmt:formatNumber value="${p.price}" type="currency" currencySymbol="" minFractionDigits="0" maxFractionDigits="0"/>đ</span>--%>
<%--                                        </c:when>--%>
<%--                                        <c:otherwise>--%>
<%--                                            <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="" minFractionDigits="0" maxFractionDigits="0"/>đ--%>
<%--                                        </c:otherwise>--%>
<%--                                    </c:choose>--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </c:forEach>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </section>--%>
<%--</c:if>--%>
<%--<div class="banner">--%>
<%--    <div class="container">--%>
<%--        <div class="row">--%>
<%--            <div class="col-lg-6 col-md-6 col-sm-6">--%>
<%--                <div class="banner__pic">--%>
<%--                    <img src="<c:url value='/img/banner/banner-1.jpg'/>" alt="Banner 1">--%>
<%--                </div>--%>
<%--            </div>--%>
<%--            <div class="col-lg-6 col-md-6 col-sm-6">--%>
<%--                <div class="banner__pic">--%>
<%--                    <img src="<c:url value='/img/banner/banner-2.jpg'/>" alt="Banner 2">--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</div>--%>
<%--&lt;%&ndash;--%>
<%--<section class="from-blog spad">--%>
<%--    ...--%>
<%--</section>--%>
<%--&ndash;%&gt;--%>
<%--<jsp:include page="layout/footer.jsp"></jsp:include>--%>
<%--<script src="<c:url value='/js/jquery-3.3.1.min.js'/>"></script>--%>
<%--<script src="<c:url value='/js/bootstrap.min.js'/>"></script>--%>
<%--<script src="<c:url value='/js/jquery.nice-select.min.js'/>"></script>--%>
<%--<script src="<c:url value='/js/jquery-ui.min.js'/>"></script>--%>
<%--<script src="<c:url value='/js/jquery.slicknav.js'/>"></script>--%>
<%--<script src="<c:url value='/js/mixitup.min.js'/>"></script>--%>
<%--<script src="<c:url value='/js/owl.carousel.min.js'/>"></script>--%>
<%--<script src="<c:url value='/js/main.js'/>"></script>--%>
<%--<script src="<c:url value='/js/custom-script.js'/>"></script> &lt;%&ndash; File JS tùy chỉnh của bạn &ndash;%&gt;--%>

<%--</body>--%>
<%--</html>--%>