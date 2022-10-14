-- *********************** Tạo một Cơ sở dữ liệu là Quản lý sinh viên và thực hiện truy vấn ************************************


-- kiểm tra nếu đã tồn tại Database quan_ly_sinh_vien thì xóa đi
DROP DATABASE IF EXISTS quan_ly_sinh_vien;

-- Kiểm tra nếu chưa tồn tại Database quan_ly_sinh_vien thì tạo mới 
CREATE DATABASE IF NOT EXISTS quan_ly_sinh_vien;

-- Sử dụng quan_ly_sinh_vien
USE quan_ly_sinh_vien;

-- Thiết lập hỗ trợ gõ tiếng việt cho Database quan_ly_sinh_vien
ALTER DATABASE quan_ly_sinh_vien CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Kiểm tra nếu đã tồn tại bảng sinh_vien thì xóa đi
DROP TABLE IF EXISTS sinh_vien;

-- Kiểm tra nếu đã tồn tại bảng khoa thì xóa đi
DROP TABLE IF EXISTS khoa;

-- Kiểm tra nếu chưa tồn tại bảng khoa thì tạo mới bảng khoa
CREATE TABLE IF NOT EXISTS khoa(
	ma_khoa SMALLINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    ten_khoa VARCHAR(30) CHARACTER SET utf8mb4 NOT NULL UNIQUE
);
-- Thiết lập lại AUTO_INCREMENT cho bảng khoa
ALTER TABLE khoa AUTO_INCREMENT = 1;

-- Thêm mới dữ liệu cho bảng khoa
INSERT INTO khoa(ten_khoa) 
VALUES 
	('Công Nghệ Thông Tin'), 
	('Tiếng Nhật'),
	('Điện');
    
 -- Xem dữ liệu của bảng khoa   
SELECT * FROM khoa;

-- -- Kiểm tra nếu đã tồn tại bảng sinh_vien thì xóa đi
DROP TABLE IF EXISTS sinh_vien;

-- Kiểm tra nếu chưa tồn tại bảng sinh_vien thì tạo mới bảng sinh_vien
CREATE TABLE IF NOT EXISTS sinh_vien(
	ma_sv SMALLINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    ma_khoa SMALLINT,
    ho_ten  VARCHAR(30) CHARACTER SET utf8mb4,
    ngay_sinh DATE,
	que_quan VARCHAR(50) CHARACTER SET utf8mb4,
	so_mon SMALLINT
);

-- Thiết lập lại AUTO_INCREMENT cho bảng sinh_vien
ALTER TABLE sinh_vien AUTO_INCREMENT = 1;

-- Thêm mới dữ liệu cho bảng sinh_vien
INSERT INTO sinh_vien(ma_khoa,ho_ten,ngay_sinh,que_quan, so_mon) 
VALUES 
	(1,'Nguyễn Văn Vinh','1993-01-01','Hà Nội',2),
	(1,'Pha Hà Giang','1992-01-02','HCM',2),
	(1,'Nguyễn Văn Nam','1995-01-03','Cao Bằng',2),
	(1,'Phan Linh','1997-01-04','Lạng Sơn',2), 
	(2,'Nguyễn Duy Tuấn','1999-01-01','Bắc Giang',2),
	(2,'Trình Thanh Bình','1998-01-02','Thái Nguyên',2),
	(2,'Hoàng Văn Thế','1993-01-03','Ninh Bình',2),
	(3,'Đặng Thị Hà','1993-01-04','Hà Nội',2);

SELECT ho_ten
FROM sinh_vien
WHERE ma_khoa IN (2, 3);

SELECT ho_ten
FROM sinh_vien
WHERE ma_khoa NOT IN (2, 3);

-- Toán tử ANY
-- Lấy ra sinh viên lớn hơn ít nhất 1 sinh viên ở Bắc Giang

SELECT *
FROM sinh_vien
WHERE que_quan = 'Bắc Giang'

SELECT *
FROM sinh_vien 
WHERE DATE(ngay_sinh)


-- Toán tử ALL
-- Lấy ra sinh viên có ngày sinh lớn hơn tất cả sinh viên ở Bắc Giang

-- Toán tử EXISTS
-- Lấy ra thông tin khoa có sinh viên ở Bắc Giang-- demo toán tử trong subquery
