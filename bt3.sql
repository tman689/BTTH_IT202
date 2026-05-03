-- =========================================
-- 1. Phòng 1 -> chuyển sang "bảo trì"
-- =========================================
UPDATE rooms
SET status = 'maintenance'
WHERE id = 1;


-- =========================================
-- 2. Chuyển toàn bộ lịch chiếu từ phòng 1 sang phòng 2
-- (tránh xung đột FK vì room_id vẫn hợp lệ)
-- =========================================
UPDATE showtimes
SET room_id = 2
WHERE room_id = 1;


-- =========================================
-- 3. Hủy toàn bộ vé của khách có SĐT 0987654321
-- Cách an toàn: dùng subquery tìm customer_id
-- =========================================
DELETE FROM tickets
WHERE customer_id = (
    SELECT id FROM customers
    WHERE phone = '0987654321'
);


-- =========================================
-- 4. Gỡ bỏ phim có id = 3 KHÔNG bị lỗi khóa ngoại
-- Phải xóa theo thứ tự: tickets -> showtimes -> movies
-- =========================================

-- 4.1 Xóa vé liên quan tới các lịch chiếu của phim
DELETE FROM tickets
WHERE showtime_id IN (
    SELECT id FROM showtimes
    WHERE movie_id = 3
);

-- 4.2 Xóa lịch chiếu của phim
DELETE FROM showtimes
WHERE movie_id = 3;

-- 4.3 Cuối cùng mới xóa phim
DELETE FROM movies
WHERE id = 3;