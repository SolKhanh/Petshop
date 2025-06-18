<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src="<c:url value='/js/auth-navigation.js'/>"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
<link rel="stylesheet" href="<c:url value='/css/style.css'/>" type="text/css">
<link rel="stylesheet" href="<c:url value='/css/header.css'/>" type="text/css">


<!-- Header -->
<header class="main-header">
    <div class="container">
        <div class="header-content">
            <!-- Logo -->
            <div class="logo-section">
                <a class="logo" href="<c:url value='/shop'/>">
                    <img src="<c:url value='/img/petshoplogo.jpg'/>" alt="PetShop Logo">
                    <span class="logo-text">PetShop</span>
                </a>
            </div>

            <!-- Search Bar -->
            <div class="search-section">
                <form class="search-form" action="<c:url value='/products'/>" method="get">
                    <div class="search-input-group">
                        <i class="fas fa-search search-icon"></i>
                        <input type="text" name="search" placeholder="Tìm kiếm sản phẩm, thương hiệu..." class="search-input" />
                        <button type="submit" class="search-btn">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
                </form>
            </div>

            <!-- Right Menu -->
            <div class="right-menu">
                <!-- Cart -->
                <div class="menu-item cart-item">
                    <a class="menu-link" onclick="navigateWithAuth('/cart')">
                        <div class="icon-wrapper">
                            <i class="fas fa-shopping-cart"></i>
                        </div>
                        <span class="menu-text">Giỏ hàng</span>
                    </a>
                </div>

                <!-- Notifications -->
                <div class="menu-item notification-item">
                    <a href="<c:url value='/notifications'/>" class="menu-link">
                        <div class="icon-wrapper">
                            <i class="fas fa-bell"></i>
                            <span class="badge notification-count" style="display: none;">0</span>
                        </div>
                        <span class="menu-text">Thông báo</span>
                    </a>
                </div>

                <!-- User Menu -->
                <div class="menu-item user-menu">
                    <!-- Login Button (shown when not logged in) -->
                    <a href="<c:url value='/login'/>" id="loginBtn" class="menu-link login-btn">
                        <div class="icon-wrapper">
                            <i class="fas fa-user"></i>
                        </div>
                        <span class="menu-text">Đăng nhập</span>
                    </a>

                    <!-- User Dropdown (shown when logged in) -->
                    <div class="user-dropdown" id="userDropdown" style="display: none;">
                        <div class="user-trigger" id="userTrigger">
                            <img src="<c:url value='/img/user/avatar.png'/>" alt="avatar" id="avatarImg" class="avatar-img">
                            <span class="user-name" id="userName"></span>
                            <i class="fas fa-chevron-down dropdown-icon"></i>
                        </div>

                        <div class="dropdown-menu" id="dropdownMenu">
                            <div class="dropdown-header">
                                <img src="<c:url value='/img/user/avatar.png'/>" alt="avatar" class="dropdown-avatar">
                                <div class="user-info">
                                    <span class="user-name-full" id="userNameFull">Tên người dùng</span>
                                    <span class="user-email" id="userEmail">email@example.com</span>
                                </div>
                            </div>
                            <div class="dropdown-divider"></div>
                            <a href="<c:url value='/profile'/>" class="dropdown-item">
                                <i class="fas fa-user-circle"></i>
                                <span>Thông tin cá nhân</span>
                            </a>
                            <a href="<c:url value='/order-history'/>" class="dropdown-item">
                                <i class="fas fa-box"></i>
                                <span>Đơn hàng của tôi</span>
                            </a>
                            <a href="<c:url value='/wishlist'/>" class="dropdown-item">
                                <i class="fas fa-heart"></i>
                                <span>Danh sách yêu thích</span>
                            </a>
                            <a href="<c:url value='/settings'/>" class="dropdown-item">
                                <i class="fas fa-cog"></i>
                                <span>Cài đặt</span>
                            </a>
                            <div class="dropdown-divider"></div>
                            <a href="javascript:void(0)" onclick="logout()" class="dropdown-item logout-item">
                                <i class="fas fa-sign-out-alt"></i>
                                <span>Đăng xuất</span>
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Mobile Menu Toggle -->
                <div class="mobile-menu-toggle" id="mobileMenuToggle">
                    <span></span>
                    <span></span>
                    <span></span>
                </div>
            </div>
        </div>
    </div>

    <!-- Mobile Menu -->
    <div class="mobile-menu" id="mobileMenu">
        <div class="mobile-menu-content">
            <div class="mobile-search">
                <form action="<c:url value='/products'/>" method="get">
                    <div class="mobile-search-input">
                        <i class="fas fa-search"></i>
                        <input type="text" name="search" placeholder="Tìm kiếm sản phẩm...">
                    </div>
                </form>
            </div>

            <nav class="mobile-nav">
                <a href="<c:url value='/'/>" class="mobile-nav-item">
                    <i class="fas fa-home"></i>
                    <span>Trang chủ</span>
                </a>
                <a href="<c:url value='/products'/>" class="mobile-nav-item">
                    <i class="fas fa-box"></i>
                    <span>Sản phẩm</span>
                </a>
                <a href="<c:url value='/cart'/>" class="mobile-nav-item">
                    <i class="fas fa-shopping-cart"></i>
                    <span>Giỏ hàng</span>
                    <span class="mobile-cart-count">0</span>
                </a>
                <a href="<c:url value='/contact'/>" class="mobile-nav-item">
                    <i class="fas fa-phone"></i>
                    <span>Liên hệ</span>
                </a>
            </nav>

            <div class="mobile-user-section" id="mobileUserSection">
                <!-- Will be populated by JavaScript -->
            </div>
        </div>
    </div>
</header>



<script>
    document.addEventListener("DOMContentLoaded", async function () {
        const token = localStorage.getItem("jwtToken");

        const loginBtn = document.getElementById("loginBtn");
        const userDropdown = document.getElementById("userDropdown");
        const userTrigger = document.getElementById("userTrigger");
        const dropdownMenu = document.getElementById("dropdownMenu");
        const avatarImg = document.getElementById("avatarImg");
        const userName = document.getElementById("userName");
        const userNameFull = document.getElementById("userNameFull");
        const userEmail = document.getElementById("userEmail");
        const mobileMenuToggle = document.getElementById("mobileMenuToggle");
        const mobileMenu = document.getElementById("mobileMenu");
        const mobileUserSection = document.getElementById("mobileUserSection");

        // Handle mobile menu toggle
        mobileMenuToggle.addEventListener('click', function() {
            this.classList.toggle('active');
            mobileMenu.classList.toggle('active');
        });

        // Handle header scroll effect
        window.addEventListener('scroll', function() {
            const header = document.querySelector('.main-header');
            if (window.scrollY > 50) {
                header.classList.add('scrolled');
            } else {
                header.classList.remove('scrolled');
            }
        });

        // Handle user dropdown
        if (userTrigger) {
            userTrigger.addEventListener('click', function(e) {
                e.stopPropagation();
                userDropdown.classList.toggle('active');
            });
        }

        // Close dropdown when clicking outside
        document.addEventListener('click', function(e) {
            if (userDropdown && !userDropdown.contains(e.target)) {
                userDropdown.classList.remove('active');
            }
        });

        // Check authentication status
        if (token) {
            try {
                const res = await fetch("/api/users/me/profile", {
                    headers: {
                        "Authorization": "Bearer " + token
                    }
                });

                if (res.ok) {
                    const user = await res.json();
                    console.log(user);

                    // Hide login button, show user dropdown
                    loginBtn.style.display = "none";
                    userDropdown.style.display = "block";

                    // Update user info
                    if (user.username) {
                        userName.textContent = user.username; // First name only
                        userNameFull.textContent = user.name;
                    }
                    if (user.email) {
                        userEmail.textContent = user.email;
                    }
                    if (user.avatar) {
                        avatarImg.src = user.avatar;
                        document.querySelector('.dropdown-avatar').src = user.avatar;
                    }

                    // Update mobile user section
                    updateMobileUserSection(user);

                    console.log("User authenticated:", user);
                } else {
                    console.log("Authentication failed:", res.status);
                    handleUnauthenticated();
                }
            } catch (error) {
                console.error("Error checking authentication:", error);
                handleUnauthenticated();
            }
        } else {
            handleUnauthenticated();
        }

        function handleUnauthenticated() {
            loginBtn.style.display = "flex";
            userDropdown.style.display = "none";
            updateMobileUserSection(null);
        }

        function updateMobileUserSection(user) {
            if (user) {
                mobileUserSection.innerHTML = `
                <div class="mobile-user-info">
                    <img src="${user.avatar || '/img/user/avatar.png'}" alt="avatar" class="mobile-avatar">
                    <div class="mobile-user-details">
                        <span class="mobile-user-name">${user.name || 'User'}</span>
                        <span class="mobile-user-email">${user.email || ''}</span>
                    </div>
                </div>
                <div class="mobile-user-menu">
                    <a href="/profile" class="mobile-nav-item">
                        <i class="fas fa-user-circle"></i>
                        <span>Thông tin cá nhân</span>
                    </a>
                    <a href="/orders" class="mobile-nav-item">
                        <i class="fas fa-box"></i>
                        <span>Đơn hàng của tôi</span>
                    </a>
                    <a href="javascript:void(0)" onclick="logout()" class="mobile-nav-item logout-item">
                        <i class="fas fa-sign-out-alt"></i>
                        <span>Đăng xuất</span>
                    </a>
                </div>
            `;
            } else {
                mobileUserSection.innerHTML = `
                <div class="mobile-auth">
                    <a href="/login" class="mobile-nav-item">
                        <i class="fas fa-sign-in-alt"></i>
                        <span>Đăng nhập</span>
                    </a>
                    <a href="/register" class="mobile-nav-item">
                        <i class="fas fa-user-plus"></i>
                        <span>Đăng ký</span>
                    </a>
                </div>
            `;
            }
        }

        // Update cart count (you can call this function when cart changes)
        function updateCartCount(count) {
            const cartCounts = document.querySelectorAll('.cart-count, .mobile-cart-count');
            cartCounts.forEach(el => {
                el.textContent = count;
                el.style.display = count > 0 ? 'block' : 'none';
            });
        }

        // Update notification count
        function updateNotificationCount(count) {
            const notificationCount = document.querySelector('.notification-count');
            if (notificationCount) {
                notificationCount.textContent = count;
                notificationCount.style.display = count > 0 ? 'block' : 'none';
            }
        }

        // Example: Update counts (you can call these based on your data)
        // updateCartCount(3);
        // updateNotificationCount(5);
    });

    function logout() {
        fetch('/api/auth/logout', {
            method: 'POST'
        }).then(() => {
            localStorage.removeItem("jwtToken"); // Nếu dùng thêm ở localStorage
            window.location.href = "/login"; // Hoặc trang chủ
        });
    }
</script>