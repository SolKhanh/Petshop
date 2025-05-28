# DELETE FROM products;
# DELETE FROM categories;

-- Đặt lại auto_increment (MySQL)
ALTER TABLE categories AUTO_INCREMENT = 1;
ALTER TABLE products AUTO_INCREMENT = 1;

-- Chèn dữ liệu vào bảng categories
INSERT INTO categories (id, name, description) VALUES
                                                   (1, 'Chó Cảnh', 'Các giống chó cảnh đẹp và thông minh.'),
                                                   (2, 'Mèo Cảnh', 'Các giống mèo cảnh đáng yêu, tinh nghịch.'),
                                                   (3, 'Phụ Kiện Thú Cưng', 'Đồ dùng, thức ăn, vật phẩm cho chó và mèo.');

-- Chèn dữ liệu vào bảng products
-- dog
INSERT INTO products (name, price, description, detail, quantity, image, category_id, sale_price, giong, mausac, cannang, size, warranty, status, view_count, created_at, updated_at) VALUES
                                                                                                                                                                                          ('ALASKA Hồng Phấn', 20000000, 'Chó Alaska Malamute, tổ tiên chó sói tuyết, màu hồng phấn.', 'Chó Alaska hay còn gọi là chó Alaska Malamute là tổ tiên giống chó sói tuyết hoang... (chi tiết từ SQL)', 3, 'img/products/dog/sp01.jpg', 1, (20000000 * (1 - 10/100.0)), 'ALASKA', 'Hồng Phấn', '2kg-3kg', 'Lớn', 1, 'active', 0, NOW(), NOW()), -- PromotionalPrice=10, Promotional=TRUE
                                                                                                                                                                                          ('ALASKA Nâu Đực Đẹp Trai', 20000000, 'Giống Alaska Malamute khỏe mạnh, lông màu nâu.', 'Bộ lông dày thô, mềm, bóng và có sắc biến thiên dần từ màu trắng toát ở phần bụng...', 5, 'img/products/dog/sp02.jpg', 1, NULL, 'ALASKA', 'Nâu', '3kg-4kg', 'Lớn', 1, 'active', 0, NOW(), NOW()), -- Không có PromotionalPrice
                                                                                                                                                                                          ('Chó Corgi Pembroke', 18000000, 'Pembroke Welsh Corgi cụt đuôi, chân ngắn.', 'Đặc điểm của giống chó này là thân hình dài, đuôi ngắn, tai vểnh nhọn...', 5, 'img/products/dog/sp03.png', 1, (18000000 * (1 - 10/100.0)), 'Corgi', 'Trắng Vàng', '1.5kg-2.5kg', 'Nhỏ', 1, 'active', 0, NOW(), NOW()); -- PromotionalPrice=10, Promotional=TRUE

-- cat
INSERT INTO products (name, price, description, detail, quantity, image, category_id, sale_price, giong, mausac, cannang, size, warranty, status, view_count, created_at, updated_at) VALUES
                                                                                                                                                                                          ('Mèo Anh Lông Ngắn Bicolor Lilac', 7000000, 'Mèo ALN màu Lilac (xám kem pha hồng) độc đáo.', 'Sự kết hợp hoàn hảo giữa xám, hồng, xanh và điểm xuyết một chút màu silver...', 5, 'img/products/cat/sp01.jpg', 2, NULL, 'Mèo Anh Lông Ngắn', 'Bicolor Lilac', '2kg-2.5kg', 'Trung bình', 1, 'active', 0, NOW(), NOW()),
                                                                                                                                                                                          ('Mèo Anh Lông Ngắn Nâu Trắng', 8000000, 'Mèo ALN thuần chủng, màu nâu trắng, thân thiện.', 'Tính cách khá dễ chịu, không thích nơi ồn ào mà chỉ ưa những chỗ yên tĩnh...', 3, 'img/products/cat/sp02.jpg', 2, NULL, 'Mèo Anh Lông Ngắn', 'Nâu Trắng', '1.8kg-2.8kg', 'Trung bình', 1, 'active', 0, NOW(), NOW()),
                                                                                                                                                                                          ('Mèo Anh Lông Ngắn Nâu Xám', 7500000, 'Mèo ALN màu nâu xám, mắt tròn, đáng yêu.', 'Đầu to tròn, mắt long lanh, con ngươi biết thể hiện cảm xúc...', 5, 'img/products/cat/sp03.jpg', 2, NULL, 'Mèo Anh Lông Ngắn', 'Nâu Xám', '2kg-3kg', 'Trung bình', 1, 'active', 0, NOW(), NOW());

-- toy
INSERT INTO products (name, price, description, detail, quantity, image, category_id, sale_price, giong, mausac, cannang, size, warranty, status, view_count, created_at, updated_at) VALUES
                                                                                                                                                                                          ('Đồ Chơi Cho Chó – Banh Có Dây', 90000, 'Bóng được bện cùng dây thừng là đồ chơi đồng thời là đồ huấn luyện lý tưởng.', 'Đồ chơi giúp mèo vận động tốt hơn, giảm stress, tăng cường sức khỏe...', 50, 'img/products/phukien/sp1.jpg', 3, NULL, NULL, 'Nhiều màu', '0.5kg', NULL, 1, 'active', 0, NOW(), NOW()),
                                                                                                                                                                                          ('Đồ Chơi Cho Chó – Dạng Dây Thừng', 50000, 'Đồ chơi cho chó được thiết kế có tay cầm, dễ điều khiển.', 'Giúp tăng cường trí nhớ, quan sát tốt hơn, biết nguyên tắc vận hành...', 40, 'img/products/phukien/sp2.jpg', 3, NULL, NULL, 'Nhiều màu', '0.5kg', NULL, 1, 'active', 0, NOW(), NOW()),
                                                                                                                                                                                          ('Bàn Chải & Kem Vệ Sinh Răng Cho Chó Mèo', 100000, 'Vệ sinh mảng bám cho chó và mèo, an toàn.', 'Làm từ chất liệu cao cấp, an toàn cho răng chó và mèo...', 30, 'img/products/phukien/sp3.jpg', 3, NULL, NULL, 'Nhiều màu', '0.1kg', NULL, 1, 'active', 0, NOW(), NOW());