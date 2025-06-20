<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Về Chúng Tôi - Depetz</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>" type="text/css">
    <style>
        .about-section {
            padding: 60px 0;
            background-color: #e8b9b9;
        }
        .about-content {
            background-color: #ffffff;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
        }
        .about-content h2 {
            font-size: 2.5rem;
            font-weight: 700;
            color: #333;
            margin-bottom: 20px;
            text-align: center;
        }
        .about-content h3 {
            font-size: 1.8rem;
            font-weight: 600;
            color: #28a745;
            margin-top: 30px;
            margin-bottom: 15px;
            border-left: 4px solid #28a745;
            padding-left: 15px;
        }
        .about-content p {
            font-size: 16px;
            line-height: 1.8;
            color: #666;
            margin-bottom: 15px;
        }
        .team-section {
            display: flex;
            gap: 30px;
            margin-top: 20px;
        }
        .team-member {
            text-align: center;
        }
        .team-member img {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            object-fit: cover;
            border: 5px solid #fff;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            margin-bottom: 15px;
        }
        .team-member h5 {
            font-weight: 600;
            margin-bottom: 5px;
        }
        .team-member span {
            color: #888;
            font-style: italic;
        }
    </style>
</head>
<body>
<jsp:include page="layout/header.jsp"></jsp:include>

<section class="breadcrumb-section set-bg" data-setbg="<c:url value='/img/breadcrumb.jpg'/>">
    <div class="container">
        <div class="row">
            <div class="col-lg-12 text-center">
                <div class="breadcrumb__text">
                    <h2>Về Chúng Tôi</h2>
                    <div class="breadcrumb__option">
                        <a href="<c:url value='/'/>">Trang chủ</a>
                        <span>Về chúng tôi</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="about-section">
    <div class="container">
        <div class="row">
            <div class="col-lg-10 offset-lg-1">
                <div class="about-content">
                    <h2>Về Depetz - Ngôi Nhà Yêu Thương Cho Thú Cưng</h2>
                    <p>
                        Depetz được thành lập từ tình yêu thương vô bờ bến dành cho các bạn thú cưng. Chúng tôi hiểu rằng, mỗi "boss" không chỉ là một vật nuôi, mà còn là một thành viên quan trọng, một người bạn đồng hành không thể thiếu trong mỗi gia đình. Chính vì vậy, sứ mệnh của Depetz là mang đến những sản phẩm và dịch vụ chất lượng nhất, giúp bạn chăm sóc cho người bạn nhỏ của mình một cách toàn diện.
                    </p>
                    <p>
                        Từ những ngày đầu tiên, chúng tôi đã không ngừng nỗ lực để xây dựng một không gian mua sắm đáng tin cậy, nơi bạn có thể tìm thấy mọi thứ cần thiết cho thú cưng của mình, từ những hạt thức ăn dinh dưỡng, những món đồ chơi vui nhộn, cho đến các sản phẩm chăm sóc sức khỏe cao cấp.
                    </p>

                    <h3>Sứ Mệnh Của Chúng Tôi</h3>
                    <p>Chúng tôi cam kết đồng hành cùng bạn trên hành trình chăm sóc và yêu thương thú cưng qua ba giá trị cốt lõi:</p>
                    <ul>
                        <li><strong>Sản phẩm chất lượng:</strong> Mọi sản phẩm tại Depetz đều được lựa chọn kỹ lưỡng từ các thương hiệu uy tín trong và ngoài nước, đảm bảo an toàn và phù hợp nhất cho sức khỏe của các bé.</li>
                        <li><strong>Tư vấn tận tâm:</strong> Đội ngũ nhân viên của chúng tôi không chỉ là những người bán hàng, mà còn là những người yêu thú cưng thực thụ, luôn sẵn sàng lắng nghe và chia sẻ kinh nghiệm để giúp bạn tìm ra giải pháp tốt nhất.</li>
                        <li><strong>Tạo dựng cộng đồng:</strong> Depetz mong muốn trở thành một cầu nối, tạo ra một cộng đồng những người yêu thú cưng để cùng nhau chia sẻ kiến thức, kinh nghiệm và những khoảnh khắc đáng yêu.</li>
                    </ul>

                    <h3>Đội Ngũ Của Chúng Tôi</h3>
                    <p>Đằng sau Depetz là một đội ngũ trẻ trung, năng động và có chung một tình yêu lớn dành cho động vật. Chúng tôi luôn cập nhật những kiến thức mới nhất về chăm sóc thú cưng để có thể mang lại những lời khuyên hữu ích và đáng tin cậy nhất cho khách hàng. Với chúng tôi, niềm vui của bạn và sức khỏe của thú cưng chính là nguồn động lực lớn nhất.</p>

                    <div class="row team-section justify-content-center">
                        <div class="col-lg-4 col-md-6">
                            <div class="team-member">
                                <img src="<c:url value='/img/user/avatar.png'/>" alt="Thành viên 1">
                                <h5>Nguyễn Quốc Khánh</h5>
                                <span>Backend Developer</span>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6">
                            <div class="team-member">
                                <img src="<c:url value='/img/user/laptop.jpg'/>" alt="Thành viên 2">
                                <h5>Nguyễn Thanh Huy</h5>
                                <span>Frontend Developer</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<jsp:include page="layout/footer.jsp"></jsp:include>
</body>
</html>
