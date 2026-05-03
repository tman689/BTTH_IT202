-- =========================================
-- CINE-MAGIC - TRUY VẤN DỮ LIỆU
-- =========================================

-- Giả định bảng:
-- movies(id, name, duration, age_rating)
-- showtimes(id, movie_id, show_date, price)
-- tickets(id, showtime_id, customer_id, booking_date)
-- customers(id, full_name)

-- =========================================
-- 1. Phim có thời lượng từ 90 đến 120 phút
-- =========================================
SELECT *
FROM movies
WHERE duration BETWEEN 90 AND 120;

-- =========================================
-- 2. Danh sách khách đặt vé của lịch chiếu id = 2
-- Sắp xếp theo ngày đặt mới nhất lên đầu
-- =========================================
SELECT 
    t.id AS ticket_id,
    c.full_name,
    t.booking_date
FROM tickets t
JOIN customers c ON t.customer_id = c.id
WHERE t.showtime_id = 2
ORDER BY t.booking_date DESC;

-- =========================================
-- 3. Phim giới hạn độ tuổi 18 HOẶC thời lượng > 150 phút
-- =========================================
SELECT *
FROM movies
WHERE age_rating = 18
   OR duration > 150;

-- =========================================
-- 4. Lịch chiếu có giá > 100000 và trong tháng hiện tại
-- =========================================
SELECT *
FROM showtimes
WHERE price > 100000
  AND MONTH(show_date) = MONTH(CURRENT_DATE)
  AND YEAR(show_date) = YEAR(CURRENT_DATE);