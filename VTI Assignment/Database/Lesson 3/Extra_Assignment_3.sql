-- Vu Thanh Van

DROP DATABASE IF EXISTS trainee;
CREATE DATABASE trainee;
USE trainee;

DROP TABLE IF EXISTS trainee;
CREATE TABLE trainee (
	TraineeID TINYINT AUTO_INCREMENT,
	Full_Name NVARCHAR(30) NOT NULL,
	Birth_Date DATE NOT NULL,
	Gender ENUM ('male', 'female', 'unknown') NOT NULL,
	ET_IQ TINYINT NOT NULL,
	ET_Gmath TINYINT NOT NULL,
	ET_English TINYINT NOT NULL,
	Training_Class VARCHAR(10) NOT NULL ,
	Evaluation_Notes NVARCHAR(250) NOT NULL,
    VTI_Account INT NOT NULL UNIQUE,
    PRIMARY KEY (TraineeID),
    CHECK (ET_IQ BETWEEN 0 AND 20),
    CHECK (ET_Gmath BETWEEN 0 AND 20),
    CHECK (ET_English BETWEEN 0 AND 50)
);

-- Add Date trainee

INSERT INTO trainee (TraineeID, Full_Name, Birth_Date, Gender, ET_IQ, ET_Gmath, ET_English, Training_Class, 
Evaluation_Notes, VTI_Account)
VALUES 
	(1, 'Vu Thanh Van', '2000-07-27', 'female', 18, 18, 49, 2, 'Good', 15),
	(2, 'Nguyen Thanh Van', '2000-01-22', 'female', 17, 12, 40, 1, 'Excellent', 14),
	(3, 'Tran Thanh Van', '2000-08-26', 'unknown', 12, 12, 20, 7, 'Moderate', 22),
	(4, 'Pham Thanh Van', '2000-02-29', 'female', 8, 18, 46, 2, 'Good', 23),
	(5, 'Luong Thanh Van', '2000-09-07', 'male', 19, 19, 47, 5, 'Good', 12),
	(6, 'Vu Thanh Vinh', '2000-07-27', 'female', 18, 19, 39, 2, 'Good', 42),
	(7, 'Nguyen Thanh Nam', '2000-07-22', 'female', 17, 12, 40, 1, 'Excellent', 74),
	(8, 'Tran Thanh Loc', '2000-10-26', 'unknown', 12, 12, 20, 7, 'Moderate', 27),
	(9, 'Pham Thi Van', '2000-07-29', 'female', 8, 8, 49, 2, 'Good', 33),
	(10, 'Luong Thuy Van', '2000-11-07', 'male', 19, 19, 47, 5, 'Good', 72),
    (11, 'Vu Thuy An', '2000-07-27', 'female', 18, 18, 49, 2, 'Good', 25),
	(12, 'Nguyen Anh Van', '2000-07-22', 'female', 17, 12, 40, 1, 'Excellent', 19),
	(13, 'Tran Truc Van', '2000-12-26', 'unknown', 12, 12, 20, 7, 'Moderate', 2),
	(14, 'Pham Vu Van', '2000-07-29', 'female', 8, 18, 46, 2, 'Good', 3),
	(15, 'Luong Thanh Vu', '2000-06-07', 'female', 19, 9, 40, 5, 'Good', 8);
    
-- Exercise 2
CREATE TABLE Exercise2 (
	ID INT AUTO_INCREMENT, 
    `Name` VARCHAR(30) NOT NULL,
    `Code` VARCHAR(5) NOT NULL,
    ModifiedDate DATETIME DEFAULt now(),
    PRIMARY KEY (ID)
);

-- Exercise 3

CREATE TABLE Exercise3 (
	ID INT AUTO_INCREMENt,
    `Name` VARCHAR(50) NOT NULL,
    BirthDate DATE NOT NULL,
    Gender ENUM('0', '1', 'NULL') NOT NULL,
    IsDeletedFlag ENUM('0', '1'),
    PRIMARY KEY (ID)
);

-- Question2 
SELECT COUNT(*) AS 'Số lượng TTS', MONTH(Birth_Date) AS 'Tháng sinh'
FROM trainee
GROUP BY MONTH(Birth_Date)
ORDER BY MONTH(Birth_Date);

-- Question3 
SELECT *
FROM trainee
WHERE LENGTH(Full_Name) = (SELECT MAX(LENGTH(Full_Name)) FROM trainee);

-- Question4 
SELECT * 
FROM trainee
WHERE ET_IQ + ET_Gmath >= 20
AND ET_IQ >= 8
AND ET_Gmath >= 8
AND ET_English >= 18;

-- Question5 
DELETE
FROM trainee
WHERE TraineeID = 3;

-- Question6 
UPDATE trainee
SET Training_Class = '2'
WHERE TraineeID = 5