<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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
                    <a href="<c:url value='/cart'/>" class="menu-link">
                        <div class="icon-wrapper">
                            <i class="fas fa-shopping-cart"></i>
<%--                            <span class="badge cart-count">0</span>--%>
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

<style>
    :root {
        --primary-color: #ff6b6b;
        --secondary-color: #4ecdc4;
        --accent-color: #45b7d1;
        --dark-color: #2c3e50;
        --light-color: #f8f9fa;
        --gradient-primary: linear-gradient(135deg, #ff6b6b 0%, #ee5a24 100%);
        --gradient-secondary: linear-gradient(135deg, #4ecdc4 0%, #44a08d 100%);
        --shadow-soft: 0 4px 20px rgba(0,0,0,0.08);
        --shadow-hover: 0 8px 30px rgba(0,0,0,0.12);
        --border-radius: 12px;
        --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    }

    .main-header {
        background: rgba(255, 255, 255, 0.95);
        backdrop-filter: blur(20px);
        box-shadow: var(--shadow-soft);
        position: fixed;
        top: 0;
        left: 0;
        right: 0;
        z-index: 1000;
        transition: var(--transition);
    }

    .main-header.scrolled {
        background: rgba(255, 255, 255, 0.98);
        box-shadow: var(--shadow-hover);
    }

    .header-content {
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 1rem 0;
        gap: 2rem;
    }

    /* Logo Section */
    .logo-section .logo {
        display: flex;
        align-items: center;
        text-decoration: none;
        gap: 0.75rem;
        transition: var(--transition);
    }

    .logo img {
        height: 45px;
        width: 45px;
        object-fit: contain;
        border-radius: 8px;
    }

    .logo-text {
        font-size: 1.5rem;
        font-weight: 800;
        background: var(--gradient-primary);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
    }

    .logo:hover {
        transform: scale(1.05);
    }

    /* Search Section */
    .search-section {
        flex: 1;
        max-width: 500px;
        margin: 0 2rem;
    }

    .search-input-group {
        position: relative;
        display: flex;
        align-items: center;
        background: white;
        border: 2px solid #e9ecef;
        border-radius: var(--border-radius);
        padding: 0.5rem 1rem;
        transition: var(--transition);
    }

    .search-input-group:focus-within {
        border-color: var(--primary-color);
        box-shadow: 0 0 0 3px rgba(255, 107, 107, 0.1);
    }

    .search-icon {
        color: #6c757d;
        margin-right: 0.75rem;
    }

    .search-input {
        flex: 1;
        border: none;
        outline: none;
        font-size: 0.95rem;
        background: transparent;
    }

    .search-input::placeholder {
        color: #adb5bd;
    }

    .search-btn {
        background: var(--gradient-primary);
        border: none;
        color: white;
        padding: 0.5rem 1rem;
        border-radius: 8px;
        margin-left: 0.5rem;
        cursor: pointer;
        transition: var(--transition);
    }

    .search-btn:hover {
        transform: translateY(-1px);
        box-shadow: var(--shadow-hover);
    }

    /* Right Menu */
    .right-menu {
        display: flex;
        align-items: center;
        gap: 1.5rem;
    }

    .menu-item {
        position: relative;
    }

    .menu-link {
        display: flex;
        flex-direction: column;
        align-items: center;
        text-decoration: none;
        color: var(--dark-color);
        transition: var(--transition);
        padding: 0.5rem;
        border-radius: 8px;
    }

    .menu-link:hover {
        color: var(--primary-color);
        background: rgba(255, 107, 107, 0.05);
    }

    .icon-wrapper {
        position: relative;
        margin-bottom: 0.25rem;
    }

    .icon-wrapper i {
        font-size: 1.25rem;
    }

    .badge {
        position: absolute;
        top: -8px;
        right: -8px;
        background: var(--gradient-primary);
        color: white;
        font-size: 0.7rem;
        font-weight: 700;
        padding: 0.15rem 0.4rem;
        border-radius: 10px;
        min-width: 18px;
        text-align: center;
    }

    .menu-text {
        font-size: 0.8rem;
        font-weight: 600;
    }

    /* User Dropdown */
    .user-dropdown {
        position: relative;
    }

    .user-trigger {
        display: flex;
        align-items: center;
        gap: 0.5rem;
        padding: 0.5rem 1rem;
        border-radius: var(--border-radius);
        cursor: pointer;
        transition: var(--transition);
    }

    .user-trigger:hover {
        background: rgba(255, 107, 107, 0.05);
    }

    .avatar-img {
        width: 35px;
        height: 35px;
        border-radius: 50%;
        object-fit: cover;
        border: 2px solid #e9ecef;
    }

    .user-name {
        font-weight: 600;
        color: var(--dark-color);
    }

    .dropdown-icon {
        font-size: 0.8rem;
        color: #6c757d;
        transition: var(--transition);
    }

    .user-dropdown.active .dropdown-icon {
        transform: rotate(180deg);
    }

    .dropdown-menu {
        position: absolute;
        top: 100%;
        right: 0;
        background: white;
        border-radius: var(--border-radius);
        box-shadow: 0 10px 40px rgba(0,0,0,0.15);
        min-width: 280px;
        padding: 0.5rem 0;
        opacity: 0;
        visibility: hidden;
        transform: translateY(-10px);
        transition: var(--transition);
        z-index: 1000;
    }

    .user-dropdown.active .dropdown-menu {
        opacity: 1;
        visibility: visible;
        transform: translateY(0);
    }

    .dropdown-header {
        display: flex;
        align-items: center;
        gap: 0.75rem;
        padding: 1rem 1.25rem;
    }

    .dropdown-avatar {
        width: 45px;
        height: 45px;
        border-radius: 50%;
        object-fit: cover;
    }

    .user-info {
        flex: 1;
    }

    .user-name-full {
        display: block;
        font-weight: 700;
        color: var(--dark-color);
        margin-bottom: 0.25rem;
    }

    .user-email {
        font-size: 0.85rem;
        color: #6c757d;
    }

    .dropdown-divider {
        height: 1px;
        background: #e9ecef;
        margin: 0.5rem 0;
    }

    .dropdown-item {
        display: flex;
        align-items: center;
        gap: 0.75rem;
        padding: 0.75rem 1.25rem;
        text-decoration: none;
        color: var(--dark-color);
        transition: var(--transition);
    }

    .dropdown-item:hover {
        background: rgba(255, 107, 107, 0.05);
        color: var(--primary-color);
    }

    .dropdown-item i {
        width: 18px;
        text-align: center;
    }

    .logout-item {
        color: #dc3545;
    }

    .logout-item:hover {
        background: rgba(220, 53, 69, 0.05);
        color: #dc3545;
    }

    /* Mobile Menu Toggle */
    .mobile-menu-toggle {
        display: none;
        flex-direction: column;
        gap: 4px;
        cursor: pointer;
        padding: 0.5rem;
    }

    .mobile-menu-toggle span {
        width: 25px;
        height: 3px;
        background: var(--dark-color);
        border-radius: 2px;
        transition: var(--transition);
    }

    .mobile-menu-toggle.active span:nth-child(1) {
        transform: rotate(45deg) translate(6px, 6px);
    }

    .mobile-menu-toggle.active span:nth-child(2) {
        opacity: 0;
    }

    .mobile-menu-toggle.active span:nth-child(3) {
        transform: rotate(-45deg) translate(6px, -6px);
    }

    /* Mobile Menu */
    .mobile-menu {
        position: fixed;
        top: 100%;
        left: 0;
        right: 0;
        background: white;
        box-shadow: var(--shadow-hover);
        transform: translateY(-100%);
        opacity: 0;
        visibility: hidden;
        transition: var(--transition);
        z-index: 999;
    }

    .mobile-menu.active {
        transform: translateY(0);
        opacity: 1;
        visibility: visible;
    }

    .mobile-menu-content {
        padding: 1.5rem;
    }

    .mobile-search {
        margin-bottom: 1.5rem;
    }

    .mobile-search-input {
        display: flex;
        align-items: center;
        background: #f8f9fa;
        border-radius: var(--border-radius);
        padding: 0.75rem 1rem;
        gap: 0.75rem;
    }

    .mobile-search-input i {
        color: #6c757d;
    }

    .mobile-search-input input {
        flex: 1;
        border: none;
        background: transparent;
        outline: none;
    }

    .mobile-nav {
        display: flex;
        flex-direction: column;
        gap: 0.5rem;
    }

    .mobile-nav-item {
        display: flex;
        align-items: center;
        gap: 1rem;
        padding: 1rem;
        text-decoration: none;
        color: var(--dark-color);
        border-radius: var(--border-radius);
        transition: var(--transition);
        position: relative;
    }

    .mobile-nav-item:hover {
        background: rgba(255, 107, 107, 0.05);
        color: var(--primary-color);
    }

    .mobile-cart-count {
        position: absolute;
        right: 1rem;
        background: var(--gradient-primary);
        color: white;
        font-size: 0.7rem;
        padding: 0.25rem 0.5rem;
        border-radius: 10px;
        min-width: 20px;
        text-align: center;
    }

    /* Responsive */
    @media (max-width: 768px) {
        .search-section {
            display: none;
        }

        .right-menu .menu-text {
            display: none;
        }

        .right-menu {
            gap: 1rem;
        }

        .mobile-menu-toggle {
            display: flex;
        }

        .user-dropdown .dropdown-menu {
            right: -50px;
            min-width: 250px;
        }
    }

    @media (max-width: 480px) {
        .header-content {
            padding: 0.75rem 0;
        }

        .logo-text {
            display: none;
        }

        .right-menu {
            gap: 0.5rem;
        }

        .menu-link {
            padding: 0.25rem;
        }
    }
</style>

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

                    // Hide login button, show user dropdown
                    loginBtn.style.display = "none";
                    userDropdown.style.display = "block";

                    // Update user info
                    if (user.username) {
                        userName.textContent = user.username; // First name only
                        userNameFull.textContent = user.username;
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
        localStorage.removeItem("jwtToken");
        window.location.href = "/login";
    }
</script>