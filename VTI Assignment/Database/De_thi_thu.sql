-- Vu Thanh Van

DROP DATABASE IF EXISTS mock_exam_database;
CREATE DATABASE mock_exam_database;
USE mock_exam_database;

DROP TABLE IF EXISTS Customer;
CREATE TABLE Customer (
	CustomerID TINYINT UNSIGNED AUTO_INCREMENT,
    `Name` NVARCHAR(50) NOT NULL,
    Phone VARCHAR(12)  NOT NULL UNIQUE,
    Email VARCHAR(25) NOT NULL UNIQUE,
    Address VARCHAR(50) NOT NULL,
    Note  VARCHAR(100) NOT NULL,
	PRIMARY KEY (CustomerID)
);

-- Add Data Customer--
INSERT INTO Customer (`Name`, Phone, Email, Address, Note)
VALUES
	('Nguyen Thuy Duong', '0908159233', 'abc@gmail.com', 'Ha Noi', 'Middle age woman'), 
	('Nguyen Huy Hoang', '090815332233', 'vnf@gmail.com', 'Ha Noi', 'Middle age man'), 
	('Nguyen Thuy Duong', '098493233', 'fbddc@gmail.com', 'Ha Tinh', 'Teenager'), 
	('Nguyen Thuy Duong', '0908049213', 's1D20@gmail.com', 'Ha Giang', 'Student'), 
	('Vu Thuy Hang', '09074829155', 'abssc@gmail.com', 'Ha Noi', 'College student');
    
DROP TABLE IF EXISTS Car;
CREATE TABLE Car (
	CarID VARCHAR(15) NOT NULL,
    Maker ENUM('HONDA', 'TOYOTA', 'NISSAN') NOT NULL,
    Model NVARCHAR(50) NOT NULL,
    `Year` SMALLINT NOT NULL,
    Color VARCHAR(10) NOT NULL,
    Note VARCHAR(100),
    PRIMARY KEY (CarID)
);

-- Add Data Car--
INSERT INTO Car (CarID, Maker, Model, `Year`, Color, Note)
VALUES
	('1D10181013', 'HONDA', 'Accord', 1999, 'Blue', 'Good'), 
	('1D10181015', 'HONDA', 'Fit', 2008, 'Green', 'Good condition'), 
	('1D10181016', 'TOYOTA', 'Corolla', 2000, 'Rainbow', 'Slow speed'), 
    ('1D10181018', 'TOYOTA', 'Supra', 1995, 'Red', 'High speed'), 
	('1D10181017', 'NISSAN', 'Cabstar', 2010, 'Gray', 'Actually it is a truck');
    

DROP TABLE IF EXISTS Car_Order;
CREATE TABLE Car_Order (
	OrderID TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
    CustomerID TINYINT UNSIGNED,
	CarID VARCHAR(15) NOT NULL,  
    Amount SMALLINT NOT NULL DEFAULT 1,
    SalePrice VARCHAR(10) NOT NUll,
    OrderDate DATETIME NOT NULL,
    DeliveryDate DATETIME NOT NULL,
    DeliveryAddress VARCHAR(30) NOT NUll,
    `Status` ENUM('0', '1', '2') DEFAULT '0',
	Note VARCHAR(100) NOT NULL,
    PRIMARY KEY (OrderID),
	FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (CarID) REFERENCES Car(CarID)
);

-- Add Data Car_Order--
INSERT INTO Car_Order (OrderID, CustomerID, CarID, Amount, SalePrice, OrderDate, DeliveryDate, 
DeliveryAddress, `Status`, Note)
VALUES
	(1, 3, '1D10181013', 1, 450000, '2022-02-03', '2022-02-03', 'Tokyo', '2', 'N/A'),
	(2, 1, '1D10181015', 3, 350000, '2022-02-02', '2022-02-03', 'Tokyo', '2', 'N/A'),
	(3, 5, '1D10181017', 2, 300000, '2022-03-13', '2022-02-03', 'Tokyo', '0', 'N/A'),
	(4, 2, '1D10181013', 4, 380000, '2022-02-23', '2022-02-03', 'Tokyo', '1', 'N/A'),
	(5, 1, '1D10181015', 1, 500000, '2022-02-03', '2022-02-03', 'Tokyo', '1', 'N/A');

-- 2. Vi???t l???nh l???y ra th??ng tin c???a kh??ch h??ng: t??n, s??? l?????ng oto kh??ch h??ng ????
-- mua v?? s???p s???p t??ng d???n theo s??? l?????ng oto ???? mua.

SELECT customer.`Name`, COUNT(car_order.Amount)
FROM customer
JOIN car_order ON customer.customerID = car_order.customerID
GROUP BY car_order.customerID
ORDER BY COUNT(car_order.Amount);

-- 3. Vi???t h??m (kh??ng c?? parameter) tr??? v??? t??n h??ng s???n xu???t ???? b??n ???????c nhi???u
-- oto nh???t trong n??m nay.
SET GLOBAL log_bin_trust_function_creators = 1;

DROP FUNCTION IF EXISTS fun_3;
DELIMITER $$
CREATE FUNCTION	fun_3 () RETURNS VARCHAR(10)
BEGIN
	DECLARE	out_maker VARCHAR(10);
    SELECT car.Maker INTO out_maker
    FROM	car_order
    JOIN car ON car_order.carID = car.carID
    GROUP BY car_order.carID
    HAVING COUNT(car_order.Amount) = (
		SELECT COUNT(Amount)
		FROM car_order
		GROUP BY carID
		ORDER BY COUNT(Amount) DESC
		LIMIT 2);
   
    RETURN out_maker;
END$$
DELIMITER ;


-- 4. Vi???t 1 th??? t???c (kh??ng c?? parameter) ????? x??a c??c ????n h??ng ???? b??? h???y c???a
-- nh???ng n??m tr?????c. In ra s??? l?????ng b???n ghi ???? b??? x??a.

DROP PROCEDURE IF EXISTS pro_q4;
DELIMITER $$
CREATE PROCEDURE pro_q4 ()
	BEGIN
	DELETE FROM car_order WHERE `Status` = '2' 
    AND YEAR(OrderDate) < Year(NOW());
	END$$
DELIMITER ;


-- 5. Vi???t 1 th??? t???c (c?? CustomerID parameter) ????? in ra th??ng tin c???a c??c ????n
-- h??ng ???? ?????t h??ng bao g???m: t??n c???a kh??ch h??ng, m?? ????n h??ng, s??? l?????ng oto
-- v?? t??n h??ng s???n xu???t.

DROP PROCEDURE IF EXISTS pro_q5
DELIMITER $$
CREATE PROCEDURE pro_q5 (IN in_CustomerID TINYINT UNSIGNED)
BEGIN
	SELECT	customer.`Name`, car_order.OrderID, car_order.Amount, car.Maker
    FROM car_order
    JOIN customer ON customer.customerID = car_order.customerID
	JOIN car ON car_order.carID = car.carID  
    WHERE customer.customerID = in_CustomerID;
END$$
DELIMITER ;

-- 6. Vi???t trigger ????? tr??nh tr?????ng h???p ng?????i d???ng nh???p th??ng tin kh??ng h???p l???
-- v??o database (DeliveryDate < OrderDate + 15).

DROP TRIGGER IF EXISTS tg_q6;
DELIMITER $$
CREATE TRIGGER tg_q6
BEFORE INSERT ON car_order
FOR EACH ROW
BEGIN
		IF NEW.DeliveryDate < NEW.OrderDate + 15 THEN
			SIGNAL SQLSTATE '12345'
            SET MESSAGE_TEXT = 'Ng??y t???o k hop le';
		END IF;
END $$
DELIMITER ;

INSERT INTO Car_Order (OrderID, CustomerID, CarID, Amount, SalePrice, OrderDate, DeliveryDate, 
DeliveryAddress, `Status`, Note)
VALUES
	(6, 3, '1D10181015', 1, 450000, '2022-02-03', '2018-02-03', 'Tokyo', '2', 'N/A');