<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src="<c:url value='/js/auth-navigation.js'/>"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
<link rel="stylesheet" href="<c:url value='/css/style.css'/>" type="text/css">
<link rel="stylesheet" href="<c:url value='/css/footer.css'/>" type="text/css">

<!-- Footer -->
<footer class="footer">
    <div class="container">
        <div class="footer-content">
            <div class="footer-section">
                <h5>Về DePetz</h5>
                <p>Chúng tôi là cửa hàng thú cưng uy tín, cung cấp những sản phẩm chất lượng cao cho người bạn bốn chân của bạn.</p>
                <div class="social-links">
                    <a href="#"><i class="fab fa-facebook-f"></i></a>
                    <a href="#"><i class="fab fa-twitter"></i></a>
                    <a href="#"><i class="fab fa-instagram"></i></a>
                    <a href="#"><i class="fab fa-youtube"></i></a>
                </div>
            </div>

            <div class="footer-section">
                <h5>Liên Kết</h5>
                <ul>
                    <li><a href="<c:url value='/'/>">Trang chủ</a></li>
                    <li><a href="<c:url value='/shop'/>">Sản phẩm</a></li>
                    <li><a href="<c:url value='/about'/>">About</a></li>
                    <li><a href="#">Chính sách</a></li>
                </ul>
            </div>

            <div class="footer-section">
                <h5>Liên Hệ</h5>
                <ul>
                    <li><i class="fa fa-envelope"></i> contact@depetz.com</li>
                    <li><i class="fa fa-phone"></i> (84) 123 456 789</li>
                    <li><i class="fa fa-map-marker-alt"></i> Hồ Chí Minh, Việt Nam</li>
                </ul>
            </div>

            <div class="footer-section">
                <h5>Chính Sách</h5>
                <p>Miễn phí vận chuyển cho đơn hàng từ 500.000đ</p>
                <p>Bảo hành chất lượng 100%</p>
                <p>Hỗ trợ 24/7</p>
            </div>
        </div>

        <div class="footer-bottom">
            <p>&copy; 2025 DePetz. Tất cả quyền được bảo lưu.</p>
        </div>
    </div>
</footer>