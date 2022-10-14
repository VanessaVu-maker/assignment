/* NGUYỄN HOÀNG */

DROP DATABASE IF EXISTS FinalExam3;
CREATE DATABASE FinalExam3;
USE FinalExam3;

-- Questions
-- 1. Tạo table với các ràng buộc và kiểu dữ liệu
-- Thêm ít nhất 3 bản ghi vào table
DROP TABLE IF EXISTS country;
CREATE TABLE	country (
	country_id		SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    country_name	NVARCHAR(30) UNIQUE KEY NOT NULL
    );
    
DROP TABLE IF EXISTS location;
CREATE TABLE	location (
	location_id		SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    street_address	NVARCHAR(50) NOT NULL,
    postal_code		INT UNSIGNED NOT NULL,
    country_id		SMALLINT UNSIGNED NOT NULL,
    FOREIGN KEY (country_id) REFERENCES country(country_id) ON DELETE CASCADE
    );
    
DROP TABLE IF EXISTS employee;
CREATE TABLE	employee (
	employee_id		SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    full_name		NVARCHAR(50) NOT NULL,
    email			NVARCHAR(50) UNIQUE KEY NOT NULL,
    location_id		SMALLINT UNSIGNED,
    FOREIGN KEY (location_id) REFERENCES location(location_id) ON DELETE CASCADE
    );
    
INSERT INTO country (country_name) VALUES ('Argentina');
INSERT INTO country (country_name) VALUES ('Germany');
INSERT INTO country (country_name) VALUES ('Viet Nam');
INSERT INTO country (country_name) VALUES ('England');
INSERT INTO country (country_name) VALUES ('Japan');
INSERT INTO country (country_name) VALUES ('Korea');
INSERT INTO country (country_name) VALUES ('China');
INSERT INTO country (country_name) VALUES ('France');

INSERT INTO location (street_address, postal_code, country_id) VALUES ('24957 Fisk Street', 	'4129', 5);
INSERT INTO location (street_address, postal_code, country_id) VALUES ('04 Merrick Avenue', 	'3065', 2);
INSERT INTO location (street_address, postal_code, country_id) VALUES ('15 Cầu Giấy Hà Nội', 	'6806', 3);
INSERT INTO location (street_address, postal_code, country_id) VALUES ('709 Evergreen Park', 	'3331', 6);
INSERT INTO location (street_address, postal_code, country_id) VALUES ('582 Tennyson Drive', 	'1560', 1);
INSERT INTO location (street_address, postal_code, country_id) VALUES ('479 Anderson Plaza', 	'8510', 7);
INSERT INTO location (street_address, postal_code, country_id) VALUES ('8 Tennessee Avenue', 	'4501', 8);
INSERT INTO location (street_address, postal_code, country_id) VALUES ('30 Hai chau, da nang', 	'9000', 3);

INSERT INTO employee (full_name, email, location_id) VALUES ('Rancell Chorley', 	'rchorley0@gov.uk', 		7);
INSERT INTO employee (full_name, email, location_id) VALUES ('Roana Dewire', 		'rdewire1@cmu.edu', 		1);
INSERT INTO employee (full_name, email, location_id) VALUES ('Nguyen Hoang', 		'abcxyz@gmail.com', 		3);
INSERT INTO employee (full_name, email, location_id) VALUES ('Clementina Bussen', 	'nn03@gmail.com', 			5);
INSERT INTO employee (full_name, email, location_id) VALUES ('Alleen Jarry', 		'ajarry4@artisteer.com', 	2);
INSERT INTO employee (full_name, email, location_id) VALUES ('La verne Brawn', 		'lverne5@yandex.ru', 		4);
INSERT INTO employee (full_name, email, location_id) VALUES ('Sayres Cahalan', 		'scahalan6@csmonitor.com', 	6);
INSERT INTO employee (full_name, email, location_id) VALUES ('Aggie Sealand', 		'asealand7@naver.com', 		8);

-- question 2:
-- a) Lấy tất cả các nhân viên thuộc Việt nam
SELECT	E.*
FROM	location L
JOIN	country C ON C.country_id = L.country_id
JOIN	employee E ON E.location_id = L.location_id
WHERE	C.country_name = 'Viet Nam';

-- b) Lấy ra tên quốc gia của employee có email là "nn03@gmail.com"
SELECT	C.country_name
FROM	location L
JOIN	country C ON C.country_id = L.country_id
JOIN	employee E ON E.location_id = L.location_id
WHERE	E.email = 'nn03@gmail.com';

-- c) Thống kê mỗi country, mỗi location có bao nhiêu employee đang làm việc.
SELECT	C.country_name, count(L.country_id) AS 'so nguoi lam viec tai nuoc nay'
FROM	location L
RIGHT JOIN	country C ON C.country_id = L.country_id
GROUP BY	C.country_id;

SELECT	L.street_address, count(E.location_id) AS 'so nguoi dang lam viec tai location nay'
FROM	location L
LEFT JOIN	employee E ON E.location_id = L.location_id
GROUP BY	 L.street_address;

-- question 3: 3. Tạo trigger cho table Employee chỉ cho phép insert mỗi quốc gia có tối đa 10 employee
DROP TRIGGER IF EXISTS	trigger_q3;
DELIMITER $$
CREATE TRIGGER	trigger_q3
BEFORE INSERT ON	employee
FOR EACH ROW
BEGIN
	DECLARE	MaxEmployee TINYINT UNSIGNED;
    SELECT	count(e.employee_id) INTO MaxEmployee
	FROM	employee E
	JOIN	location L ON E.location_id = L.location_id
    WHERE	e.location_id = NEW.location_id
    GROUP BY	L.country_id;
    IF	MaxEmployee >= 10 THEN
		SIGNAL SQLSTATE '12345'
        SET MESSAGE_TEXT = 'Vượt quá 10 employee cho mỗi quốc gia rồi!!!';
	END IF;
END$$
DELIMITER ;

INSERT INTO employee (full_name, email, locationid) VALUES ('Christie Glancye', 	'cglacncy0@gmail.com', 			3);
INSERT INTO employee (full_name, email, locationid) VALUES ('Caren Whapples', 		'cwhapples1@sfgate.com', 		3);
INSERT INTO employee (full_name, email, locationid) VALUES ('Huberto Jedras', 		'hjedras2@bluehost.com', 		3);
INSERT INTO employee (full_name, email, locationid) VALUES ('Phip Varnals', 		'pvarnals3@newyorker.com', 		3);
INSERT INTO employee (full_name, email, locationid) VALUES ('Noble Kenset', 		'nkenset4@mysql.com', 			3);
INSERT INTO employee (full_name, email, locationid) VALUES ('Ivett Stubs', 		'istubs5@nbcnews.com', 			3);
INSERT INTO employee (full_name, email, locationid) VALUES ('Ailee Kiera', 		'akiera6@eepurl.com', 			3);
INSERT INTO employee (full_name, email, locationid) VALUES ('Bern Farny', 			'bfarny7@blogs.com', 			3);
INSERT INTO employee (full_name, email, locationid) VALUES ('Christos Clissett', 	'cclissett8@163.com', 			3);
INSERT INTO employee (full_name, email, locationid) VALUES ('Allison Hearons', 	'ahearons9@amazon.com', 		3);

-- question 4: Hãy cấu hình table sao cho khi xóa 1 location nào đó thì tất cả employee ở location đó sẽ có location_id = null
-- ở khóa ngoại foreign key ta chỉnh điều kiện thành ON DELETE SET NULL và giá trị E.employee sẽ KHÔNG được đặt là NOT NULL
ALTER TABLE 		Employee
DROP CONSTRAINT 	`employee_ibfk_1`,
ADD FOREIGN KEY 	(location_id) REFERENCES location(location_id) ON DELETE SET NULL;
DELETE
FROM	location
WHERE	location_id = 1;





