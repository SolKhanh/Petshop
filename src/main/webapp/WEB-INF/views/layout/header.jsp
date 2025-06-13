<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Header -->
<header class="main-header">
    <div class="navbar">
        <div class="logo">
            <a href="/shop">🐾 PetShop</a>
        </div>

        <div class="search-bar">
            <input type="text" placeholder="Tìm kiếm sản phẩm..." />
            <button>Tìm</button>
        </div>

        <div class="right-menu">
            <a href="/cart">🛒 Giỏ hàng</a>
            <a href="/notifications">🔔 Thông báo</a>

            <c:choose>
                <c:when test="${sessionScope.user == null}">
                    <a href="/login">🔐 Đăng nhập</a>
                </c:when>
                <c:otherwise>
                    <a href="/api/users/me">
                        <img src="<c:url value='/${sessionScope.user.inforUser.avt}'/>" alt="avatar" class="avatar-img">
                    </a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</header>

<link rel="stylesheet" href="/css/header.css">
