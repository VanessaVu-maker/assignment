-- Vu Thanh Van

DROP DATABASE IF EXISTS ThucTap;
CREATE DATABASE ThucTap;
USE ThucTap;

DROP TABLE IF EXISTS Country;
CREATE TABLE Country (
	CountryID TINYINT UNSIGNED AUTO_INCREMENT,
	CountryName NVARCHAR(50) NOT NULL,
	PRIMARY KEY (CountryID)
);

-- Add Data Country--
INSERT INTO Country (CountryName)
VALUES
	('Vietnam'),
	('Japan'),
	('China');

DROP TABLE IF EXISTS Location;
CREATE TABLE Location (
	LocationID TINYINT UNSIGNED AUTO_INCREMENT,
	Street NVARCHAR(50) NOT NULL,
    Address NVARCHAR(50) NOT NULL,
    Postal_Code NVARCHAR(50) NOT NULL,
    CountryID TINYINT UNSIGNED,
	PRIMARY KEY (LocationID),
    FOREIGN KEY (CountryID) REFERENCES Country(CountryID)
);

-- Add Data Location--
INSERT INTO Location (Street, Address, Postal_Code, CountryID)
VALUES
	('Street1', 'Address1', 'D1231', 3),
	('Street2', 'Address2', 'D4231', 1),
	('Street3', 'Address3', 'D1949', 1);
    
DROP TABLE IF EXISTS Employee;
CREATE TABLE Employee (
	EmployeeID TINYINT UNSIGNED AUTO_INCREMENT,
	Full_Name NVARCHAR(50) NOT NULL,
    Email VARCHAR(50) NOT NULL UNIQUE,
    LocationID TINYINT UNSIGNED,
	PRIMARY KEY (EmployeeID),
    FOREIGN KEY (LocationID) REFERENCES Location(LocationID)
);

-- Add Data Employee--
INSERT INTO Employee (Full_Name, Email, LocationID)
VALUES
	('Vu Thanh Van', 'vthanhvan@gmail.com', 3),
	('Vu Hoang Viet', 'vhv@gmail.com', 1),
	('Vu Dinh Lan', 'nn03@gmail.com', 2);
    
-- a) Lấy tất cả các nhân viên thuộc Việt nam
SELECT *
FROM location
JOIN employee ON location.locationID = employee.locationID
JOIN country ON location.countryID = country.countryID
WHERE country.countryName = 'Vietnam';


-- b) Lấy ra tên quốc gia của employee có email là "nn03@gmail.com"
SELECT country.countryName
FROM location
JOIN employee ON location.locationID = employee.locationID
JOIN country ON location.countryID = country.countryID
WHERE employee.email = 'nn03@gmail.com';

-- c) Thống kê mỗi country, mỗi location có bao nhiêu employee đang
-- làm việc.

SELECT location.locationID, country.countryName, COUNT(employee.employeeID)
FROM location
RIGHT JOIN employee ON location.locationID = employee.locationID
RIGHT JOIN country ON location.countryID = country.countryID
GROUP BY location.locationID;


-- 3. Tạo trigger cho table Employee chỉ cho phép insert mỗi quốc gia có tối đa
-- 10 employee

DROP TRIGGER IF EXISTS tg_q3;
DELIMITER $$
CREATE TRIGGER tg_q3
BEFORE INSERT ON employee
FOR EACH ROW
BEGIN
DECLARE v_count_employeeID VARCHAR(50);
SELECT COUNT(employee.employeeID) INTO v_count_employeeID
FROM location
JOIN employee ON location.locationID = employee.locationID
WHERE	employee.locationid = NEW.locationid
GROUP BY	location.countryid;
	IF v_count_employeeID > 3 THEN
				SIGNAL SQLSTATE '12345'
				SET MESSAGE_TEXT = 'Maximum 10 employees per country';
			END IF;
END $$
DELIMITER ;


-- 4. Hãy cấu hình table sao cho khi xóa 1 location nào đó thì tất cả employee ở
-- location đó sẽ có location_id = null

ALTER TABLE 		Employee
DROP CONSTRAINT 	`employee_ibfk_1`,
ADD FOREIGN KEY 	(location_id) REFERENCES location(location_id) ON DELETE SET NULL;
DELETE
FROM	location
WHERE	location_id = 1;