-- XÓA DỮ LIỆU CŨ (THEO THỨ TỰ ĐẢO NGƯỢC KHÓA NGOẠI)

-- Xóa các bảng nối trước
DELETE FROM user_role;
DELETE FROM cart_items;
DELETE FROM order_details;
#
# -- Xóa các bảng chính có khóa ngoại trỏ tới (hoặc được trỏ tới bởi bảng khác)
DELETE FROM carts;
DELETE FROM orders;
DELETE FROM products;
DELETE FROM categories;
DELETE FROM user_role WHERE user_id IN (SELECT id FROM user_account WHERE user_name IN ('testuser', 'adminuser', 'khanh'));
DELETE FROM infor_user WHERE id_user IN (SELECT id FROM user_account WHERE user_name IN ('testuser', 'adminuser', 'khanh'));
DELETE FROM user_account WHERE user_name IN ('testuser', 'adminuser', 'khanh');
DELETE FROM role WHERE id IN ('USER', 'ADMIN');


-- ĐẶT LẠI AUTO_INCREMENT (CHO CÁC BẢNG CÓ ID TỰ TĂNG)
-- Chỉ chạy nếu bảng trống hoặc bạn muốn ID bắt đầu lại từ 1.
ALTER TABLE categories AUTO_INCREMENT = 1;
ALTER TABLE products AUTO_INCREMENT = 1;
ALTER TABLE user_account AUTO_INCREMENT = 1;
ALTER TABLE user_role AUTO_INCREMENT = 1;
ALTER TABLE carts AUTO_INCREMENT = 1;
ALTER TABLE cart_items AUTO_INCREMENT = 1;
ALTER TABLE orders AUTO_INCREMENT = 1;
ALTER TABLE order_details AUTO_INCREMENT = 1;

-- CHÈN DỮ LIỆU VÀO BẢNG CATEGORIES
INSERT INTO categories (name, description) VALUES
                                               ('Chó Cảnh', 'Các giống chó cảnh đẹp và thông minh.'),
                                               ('Mèo Cảnh', 'Các giống mèo cảnh đáng yêu, tinh nghịch.'),
                                               ('Phụ Kiện Thú Cưng', 'Đồ dùng, thức ăn, vật phẩm cho chó và mèo.');

-- CHÈN DỮ LIỆU VÀO BẢNG PRODUCTS
-- Lưu ý: category_id phải khớp với id trong bảng categories (1: Chó, 2: Mèo, 3: Phụ Kiện)
-- createdAt và updatedAt sẽ được Entity tự quản lý qua @PrePersist/@PreUpdate nếu bạn đã định nghĩa
-- status và viewCount cũng có thể được quản lý tương tự hoặc gán giá trị mặc định
-- PromotionalPrice (ví dụ 10) được hiểu là % giảm giá. sale_price = price * (1 - promotional_price_percentage / 100.0)

-- Sản phẩm Chó (category_id = 1)
INSERT INTO products (name, price, description, detail, quantity, image, category_id, sale_price, giong, mausac, cannang, size, warranty, status, view_count, created_at, updated_at) VALUES
                                                                                                                                                                                          ('ALASKA Hồng Phấn', 20000000.00, 'Chó Alaska Malamute, tổ tiên chó sói tuyết, màu hồng phấn.', 'Chó Alaska hay còn gọi là chó Alaska Malamute là tổ tiên giống chó sói tuyết hoang dã, được thuần hoá bởi tộc Malamute để trở thành vật nuôi. Trước khi trở thành thú nuôi phổ biến, chó Alaska đã trải qua một quá trình đầy gian nan để thích nghi với cuộc sống con người.', 3, 'img/products/dog/sp1.jpg', 1, 18000000.00, 'ALASKA', 'Hồng Phấn', '2kg-3kg', 'Lớn', 12, 'ACTIVE', 150, NOW(), NOW()),
                                                                                                                                                                                          ('ALASKA Nâu Đực Đẹp Trai', 22000000.00, 'Giống Alaska Malamute khỏe mạnh, lông màu nâu.', 'Bộ lông dày thô, mềm, bóng và có sắc biến thiên dần từ màu trắng toát ở phần bụng tới màu nâu đậm trên sống lưng, tạo vẻ oai vệ và thu hút.', 5, 'img/products/dog/sp2.jpg', 1, NULL, 'ALASKA', 'Nâu', '3kg-4kg', 'Lớn', 12, 'ACTIVE', 120, NOW(), NOW()),
                                                                                                                                                                                          ('Chó Corgi Pembroke', 18000000.00, 'Pembroke Welsh Corgi cụt đuôi, chân ngắn, mông trái tim.', 'Đặc điểm của giống chó này là thân hình dài, đuôi ngắn (hoặc cộc tự nhiên), tai vểnh nhọn. Rất năng động và thông minh, được Nữ hoàng Elizabeth II yêu thích.', 5, 'img/products/dog/sp3.png', 1, 16200000.00, 'Corgi', 'Trắng Vàng', '1.5kg-2.5kg', 'Nhỏ', 6, 'ACTIVE', 250, NOW(), NOW());

-- Sản phẩm Mèo (category_id = 2)
INSERT INTO products (name, price, description, detail, quantity, image, category_id, sale_price, giong, mausac, cannang, size, warranty, status, view_count, created_at, updated_at) VALUES
                                                                                                                                                                                          ('Mèo Anh Lông Ngắn Bicolor Lilac', 7000000.00, 'Mèo ALN màu Lilac (xám kem pha hồng) độc đáo, mắt tròn.', 'Sự kết hợp hoàn hảo giữa xám, hồng, xanh và điểm xuyết một chút màu silver tạo nên bộ lông cực kỳ đẹp mắt và cuốn hút. Tính cách hiền lành, thích sự yên tĩnh.', 5, 'img/products/cat/sp01.jpg', 2, NULL, 'Mèo Anh Lông Ngắn', 'Bicolor Lilac', '2kg-2.5kg', 'Trung bình', 6, 'ACTIVE', 180, NOW(), NOW()),
                                                                                                                                                                                          ('Mèo Anh Lông Ngắn Nâu Trắng', 8000000.00, 'Mèo ALN thuần chủng, màu nâu trắng, thân thiện, dễ gần.', 'Tính cách khá dễ chịu, không thích nơi ồn ào nhưng rất quấn người, thích được ôm ấp và vuốt ve. Bộ lông mềm mại, dễ chăm sóc.', 3, 'img/products/cat/sp02.jpg', 2, 7500000.00, 'Mèo Anh Lông Ngắn', 'Nâu Trắng', '1.8kg-2.8kg', 'Trung bình', 6, 'ACTIVE', 90, NOW(), NOW()),
                                                                                                                                                                                          ('Mèo Anh Lông Ngắn Nâu Xám', 7500000.00, 'Mèo ALN màu nâu xám, mắt tròn to, đáng yêu.', 'Đầu to tròn, mắt long lanh, con ngươi biết thể hiện cảm xúc. Rất thích hợp cho những gia đình tìm kiếm một người bạn đồng hành trầm tính.', 5, 'img/products/cat/sp03.jpg', 2, NULL, 'Mèo Anh Lông Ngắn', 'Nâu Xám', '2kg-3kg', 'Trung bình', 6, 'ACTIVE', 70, NOW(), NOW());

-- Sản phẩm Phụ Kiện (category_id = 3)
INSERT INTO products (name, price, description, detail, quantity, image, category_id, sale_price, giong, mausac, cannang, size, warranty, status, view_count, created_at, updated_at) VALUES
                                                                                                                                                                                          ('Đồ Chơi Cho Chó – Banh Có Dây', 90000.00, 'Bóng bện cùng dây thừng, đồ chơi và huấn luyện lý tưởng.', 'Giúp chó vận động, giảm stress, tăng cường sức khỏe và khả năng phản xạ. Chất liệu an toàn, bền chắc.', 50, 'img/products/phukien/sp1.jpg', 3, NULL, NULL, 'Nhiều màu', '0.5kg', NULL, 0, 'ACTIVE', 200, NOW(), NOW()),
                                                                                                                                                                                          ('Đồ Chơi Cho Chó – Dạng Dây Thừng', 50000.00, 'Đồ chơi cho chó thiết kế có tay cầm, dễ điều khiển khi chơi cùng.', 'Giúp tăng cường trí nhớ, khả năng quan sát. Chất liệu cotton tự nhiên, an toàn cho răng chó.', 40, 'img/products/phukien/sp2.jpg', 3, NULL, NULL, 'Nhiều màu', '0.5kg', NULL, 0, 'ACTIVE', 150, NOW(), NOW()),
                                                                                                                                                                                          ('Bàn Chải & Kem Vệ Sinh Răng Cho Chó Mèo', 100000.00, 'Bộ vệ sinh răng miệng, loại bỏ mảng bám, hơi thở thơm tho.', 'Làm từ chất liệu cao cấp, an toàn cho răng và nướu của chó mèo. Kem đánh răng có hương vị hấp dẫn.', 30, 'img/products/phukien/sp3.jpg', 3, 90000.00, NULL, NULL, '0.1kg', NULL, 0, 'ACTIVE', 100, NOW(), NOW());


-- CHÈN DỮ LIỆU VÀO BẢNG ROLE
INSERT INTO role (id, name) VALUES
                                ('USER', 'User'),
                                ('ADMIN', 'Admin')
ON DUPLICATE KEY UPDATE name = VALUES(name); -- Nếu ID (USER, ADMIN) đã tồn tại, cập nhật tên

-- CHÈN DỮ LIỆU VÀO BẢNG USER_ACCOUNT
-- Mật khẩu '123456' được mã hóa bằng BCrypt.
INSERT INTO user_account (user_name, password, status) VALUES
                                                           ('testuser', '$2a$10$8fh0F5v5dTwHdHqnVpXZpejx4DXKC.5l6mbsCx4PFyDIiNzKt8cjC', 'ACTIVE'),
                                                           ('adminuser', '$2a$10$8fh0F5v5dTwHdHqnVpXZpejx4DXKC.5l6mbsCx4PFyDIiNzKt8cjC', 'ACTIVE')
ON DUPLICATE KEY UPDATE password = VALUES(password), status = VALUES(status);


-- GÁN VAI TRÒ CHO USER MẪU

-- Xóa các gán vai trò cũ cho những user này trước khi gán lại để tránh trùng lặp
DELETE FROM user_role
WHERE user_id IN (
                  (SELECT id FROM user_account WHERE user_name = 'testuser'),
                  (SELECT id FROM user_account WHERE user_name = 'adminuser')
    );

-- Gán lại vai trò
INSERT INTO user_role (user_id, role_id)
SELECT ua.id, 'USER'
FROM user_account ua
WHERE ua.user_name = 'testuser';

INSERT INTO user_role (user_id, role_id)
SELECT ua.id, 'ADMIN'
FROM user_account ua
WHERE ua.user_name = 'adminuser';

INSERT INTO user_role (user_id, role_id)
SELECT ua.id, 'USER'
FROM user_account ua
WHERE ua.user_name = 'adminuser';
