-- HOÀNG THANH HẢI
DROP DATABASE IF EXISTS ThucTap;
CREATE DATABASE 		ThucTap;
USE 					ThucTap;
-- Q1:
    CREATE TABLE 		Country (
		country_id 		TINYINT AUTO_INCREMENT PRIMARY KEY,
        country_name 	VARCHAR (100) NOT NULL
    );
    
	CREATE TABLE 		Location (
		location_id 	TINYINT AUTO_INCREMENT PRIMARY KEY,
        street_address 	VARCHAR (100) NOT NULL,
        postal_code		VARCHAR (20) NOT NULL,
        country_id 		TINYINT,
        FOREIGN KEY		(country_id) REFERENCES Country (country_id) ON DELETE CASCADE ON UPDATE CASCADE
    );

	CREATE TABLE 		Employee (
		employee_id		TINYINT AUTO_INCREMENT PRIMARY KEY,
        full_name		VARCHAR (100) NOT NULL,
        email			VARCHAR (30) UNIQUE KEY NOT NULL,
        location_id 	TINYINT,
        FOREIGN KEY		(location_id) REFERENCES Location (location_id) ON DELETE CASCADE ON UPDATE CASCADE
	);
    

-- Insert dữ liệu
-- Country
insert into Country (country_id, country_name) values (1, 'United State ');
insert into Country (country_id, country_name) values (2, 'China');
insert into Country (country_id, country_name) values (3, 'Vietnam');
insert into Country (country_id, country_name) values (4, 'Singapore');

-- Location
insert into Location (location_id , street_address, postal_code, country_id 	) values (1, '6 Hazelcrest Junction', '+1', 1);
insert into Location (location_id , street_address, postal_code, country_id 	) values (2, '23 Transport Court', '+86', 2);
insert into Location (location_id , street_address, postal_code, country_id 	) values (3, '519 Truong Chinh', '+84', 3);
insert into Location (location_id , street_address, postal_code, country_id 	) values (4, '69 White Place', '+65', 4);
-- Employee

insert into Employee (employee_id, full_name, email, location_id ) values (1, 'Eberto Manhare', 'emanhare0@disqus.com', 3);
insert into Employee (employee_id, full_name, email, location_id ) values (2, 'Vern Jori', 'nn03@gmail.com', 1);
insert into Employee (employee_id, full_name, email, location_id ) values (3, 'Prudence Chitson', 'pchitson2@wordpress.org', 1);
insert into Employee (employee_id, full_name, email, location_id ) values (4, 'Wittie Speers', 'wspeers3@illinois.edu', 2);
insert into Employee (employee_id, full_name, email, location_id ) values (5, 'Leola Kantor', 'lkantor4@timesonline.co.uk', 3);
insert into Employee (employee_id, full_name, email, location_id ) values (6, 'Demetris Liell', 'dliell5@sciencedaily.com', 4);
insert into Employee (employee_id, full_name, email, location_id ) values (7, 'Melina Adhams', 'madhams6@goodreads.com', 4);
insert into Employee (employee_id, full_name, email, location_id ) values (8, 'Ilario Zannetti', 'izannetti7@huffingtonpost.com', 1);
insert into Employee (employee_id, full_name, email, location_id ) values (9, 'Von Denyukhin', 'vdenyukhin8@diigo.com', 2);
insert into Employee (employee_id, full_name, email, location_id ) values (10, 'Simonette Jorin', 'sjorin9@nydailynews.com', 1);

-- Q2:
-- a/ Lay tat ca cac nv thuoc viet nam
SELECT 		e.*, c.country_name
FROM 		employee e
INNER JOIN 	location l 	ON e.location_id = l.location_id
INNER JOIN 	country c	ON 	l.country_id = c.country_id
WHERE 		c.country_name = 'Vietnam';

-- b/ Lay ra ten quoc gia cua employee co email la nn03@gmail.com 
SELECT 		c.*
FROM 		country c
INNER JOIN 	location l	ON c.country_id = l.country_id
INNER JOIN 	employee e	ON e.location_id = l.location_id
WHERE		e.email = 'nn03@gmail.com';

-- c/ Thong ke moi coutry , moi location co bao nhieu employee dang lam viec
SELECT		c.country_id, l.location_id, count(e.employee_id)
FROM 		employee e
RIGHT JOIN 	location l 	ON e.location_id = l.location_id
RIGHT JOIN 	country c	ON 	l.country_id = c.country_id
GROUP BY 	e.location_id , c.country_id;

-- Q3 tao trigger cho table Employee chi cho phep insert moi quoc gia co toi da 10 employee
DROP TRIGGER IF EXISTS tg_employee_max;
DELIMITER $$
CREATE TRIGGER tg_employee_max
AFTER INSERT ON Employee
FOR EACH ROW
BEGIN
	DECLARE 	v_count TINYINT; 
	SELECT		count(e.employee_id) INTO v_count
        FROM 		employee e
		INNER JOIN 	location l 	ON 	e.location_id = l.location_id
		INNER JOIN 	country c	ON 	l.country_id = c.country_id
		WHERE 		e.location_id = NEW.location_id;
    IF (v_count > 10) THEN 
				SIGNAL SQLSTATE '12345'
				SET MESSAGE_TEXT = 'SLNV khong duoc qua 10 nguoi';
    END IF;
END $$
DELIMITER ;

-- Q4 Hay cau hinh sao cho khi xoa 1 location nao do thi tat ca employee o location do se co location_id = null
DROP PROCEDURE IF EXISTS procedure_delete_location;
DELIMITER $$
CREATE PROCEDURE procedure_delete_location ( IN in_location_id TINYINT) 
	BEGIN
		DECLARE 	v_location_id TINYINT;
        SELECT  	l.location_id INTO v_location_id FROM Location l WHERE l.location_id = in_location_id;
        UPDATE 		Employee e SET e.location_id = NULL WHERE e.location_id = v_location_id;
        DELETE FROM Location l1 WHERE l1.location_id = in_location_id;
    END $$
DELIMITER ;

CALL procedure_delete_location (1);
