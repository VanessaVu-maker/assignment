-- Vu Thanh Van

DROP DATABASE IF EXISTS Testing_System_Assignment_1;
CREATE DATABASE Testing_System_Assignment_1;
USE Testing_System_Assignment_1;

DROP TABLE IF EXISTS Department;
CREATE TABLE Department (
	DepartmentID TINYINT UNSIGNED AUTO_INCREMENT,
    DepartmentName NVARCHAR(25) NOT NULL UNIQUE,
    PRIMARY KEY (DepartmentID)
);

-- Add Data Department--
INSERT INTO Department (DepartmentID,  DepartmentName)
VALUES
	(1, N'Marketing'),
	(2, N'Sale'),
	(3, N'Security'),
	(4, N'Human Resources'),
	(5, N'Affairs Office'),
    (6, N'Education'),
	(7, N'Executive'),
	(8, N'Designs'),
	(9, N'Logistics'),
	(10, N'Applications');
    
DROP TABLE IF EXISTS Position;
CREATE TABLE Position (
	PositionID TINYINT UNSIGNED AUTO_INCREMENT,
    PositionName ENUM('Dev', 'Test', 'Scrum Master', 'PM') NOT NULL UNIQUE,
    PRIMARY KEY (PositionID)
);

-- Add Data Position--
INSERT INTO Position (PositionID,  PositionName)
VALUES
	(1, N'Dev'),
	(2, N'Test'),
	(3, N'Scrum Master'),
	(4, N'PM');

DROP TABLE IF EXISTS `Account`;
CREATE TABLE `Account` (
	AccountID TINYINT UNSIGNED AUTO_INCREMENT,
    Email VARCHAR(25) NOT NULL UNIQUE,
    Username VARCHAR(25) NOT NULL UNIQUE,
    FullName NVARCHAR(50) NOT NULL,
    DepartmentID TINYINT UNSIGNED NOT NULL,
    PositionID TINYINT UNSIGNED NOT NULL,
    CreateDate DATETIME DEFAULT now(),
	PRIMARY KEY (AccountID),
    FOREIGN KEY (DepartmentID) REFERENCES Department (DepartmentID),
	FOREIGN KEY (PositionID) REFERENCES Position (PositionID),
    CHECK (CreateDate < sysdate())
);

-- Add Data Account--
INSERT INTO `Account` (AccountID,  Email, Username, FullName, DepartmentID, PositionID, CreateDate)
VALUES
	(1, 'abc@gmail.com', 'Duong','Nguyen Thuy Duong', '1', '4', '2022-02-26'),
	(2, 'vnf@gmail.com', 'Hang', 'Vu Thuy Hang', '2', '4', '2022-02-26'),
	(3, 's1D20@gmail.com', 'Hoang', 'Nguyen Huy Hoang', '1', '3', '2022-02-03'),
	(4, 'fbc@gmail.com', 'Lan', 'Nguyen Thanh Lan', '3', '1', '2022-02-06'),
    (5, 'fbddc@gmail.com', 'Hang2', 'Nguyen Thi Hang', '3', '1', '2022-01-06'),
	(6, 'abc22@gmail.com', 'Duong2', 'Nguyen Thuy Duong', '6', '4', '2022-02-26'),
	(7, 'vnf22@gmail.com', 'Hang3', 'Vu Thuy Hang', '7', '1', '2022-02-26'),
	(8, 's1D2022@gmail.com', 'Hoang2', 'Nguyen Huy Hoang', '4', '2', '2022-02-03'),
	(9, 'fbc45@gmail.com', 'Lan2', 'Nguyen Thanh Lan', '9', '1', '2022-02-06'),
    (10, 'fbc66@gmail.com', 'Hang4', 'Nguyen Thi Hang', '2', '2', '2022-01-06');
    
DROP TABLE IF EXISTS `Group`;
CREATE TABLE `Group` (
	GroupID TINYINT UNSIGNED AUTO_INCREMENT,
    GroupName NVARCHAR(50) NOT NULL UNIQUE,
    CreatorID TINYINT UNSIGNED NOT NULL UNIQUE,
    CreateDate DATETIME DEFAULT now(),
    PRIMARY KEY (GroupID),
	FOREIGN KEY (CreatorID) REFERENCES `Account`(AccountID)
);

-- Add Data Group--
INSERT INTO `Group` (GroupID,  GroupName, CreatorID, CreateDate)
VALUES
	(1, 'SalesTeam', '3', '2018-02-02'),
	(2, 'Executive_Marketer', '2', '2022-02-04'),
	(3, 'Intern_Sales', '1', '2017-02-03'),
	(4, 'Intern_Dev', '9', '2017-02-06'),
    (5, 'Supervisors', '4', '2022-01-06'),
    (6, 'SalesForce2', '7', '2016-02-02'),
	(7, 'Security', '8', '2022-02-04'),
	(8, 'Intern_Sales_1', '6', '2022-02-03'),
	(9, 'Intern_Dev_1', '5', '2022-02-06'),
    (10, 'Supervisors_2', '10', '2022-01-06');
    
DROP TABLE IF EXISTS `GroupAccount`;
CREATE TABLE `GroupAccount` (
	GroupID TINYINT UNSIGNED NOT NULL,
    AccountID TINYINT UNSIGNED NOT NULL,
    JoinDate DATETIME DEFAULT now(),
    PRIMARY KEY (GroupID, AccountID),
    FOREIGN KEY (GroupID) REFERENCES `Group`(GroupID),
    FOREIGN KEY (AccountID) REFERENCES `Account`(AccountID)
);

-- Add Data Group Account--
INSERT INTO `GroupAccount` (GroupID,  AccountID, JoinDate)
VALUES
	('1', '3', '2022-02-02'),
	('2', '2', '2022-02-04'),
	('3', '4', '2022-02-03'),
	('4', '2', '2022-02-06'),
    ('5', '8', '2022-01-06'),
    ('6', '5', '2022-02-02'),
	('7', '7', '2022-02-04'),
	('8', '4', '2022-02-03'),
	('9', '1', '2022-02-06'),
    ('10', '9', '2022-01-06');

DROP TABLE IF EXISTS `TypeQuestion`;
CREATE TABLE `TypeQuestion` (
	TypeID TINYINT UNSIGNED AUTO_INCREMENT,
    TypeName ENUM('Essay', 'Multiple-Choice') NOT NULL UNIQUE,
    PRIMARY KEY (TypeID)
);

-- Add Data TypeQuestion--
INSERT INTO `TypeQuestion` (TypeID,  TypeName)
VALUES
	(1, 'Multiple-Choice'),
	(2, 'Essay');
    
DROP TABLE IF EXISTS `CategoryQuestion`;
CREATE TABLE `CategoryQuestion` (
	CategoryID TINYINT UNSIGNED AUTO_INCREMENT,
    CategoryName VARCHAR(25) NOT NULL UNIQUE,
    PRIMARY KEY (CategoryID)
);

-- Add Data CategoryQuestion--
INSERT INTO `CategoryQuestion` (CategoryID,  CategoryName)
VALUES
	(1, 'Java'),
	(2, 'Ruby'),
	(3, 'SQL'),
	(4, 'Python'),
    (5, 'PHP'),
    (6, 'C'),
	(7, 'C++'),
	(8, 'MySQL'),
	(9, 'MongoDB'),
    (10, 'HTML');
    
DROP TABLE IF EXISTS `Question`;
CREATE TABLE `Question` (
	QuestionID TINYINT UNSIGNED AUTO_INCREMENT,
    Content NVARCHAR(150) NOT NULL,
    CategoryID TINYINT UNSIGNED NOT NULL,
    TypeID TINYINT UNSIGNED NOT NULL,
    CreatorID TINYINT UNSIGNED NOT NULL,
    CreateDate DATETIME DEFAULT now(),
    PRIMARY KEY (QuestionID),
    FOREIGN KEY (CategoryID) REFERENCES CategoryQuestion(CategoryID),
	FOREIGN KEY (TypeID) REFERENCES TypeQuestion(TypeID),
	FOREIGN KEY (CreatorID) REFERENCES `Account`(AccountID)
);

-- Add Data Question--
INSERT INTO `Question` (QuestionID, Content, CategoryID, TypeID, CreatorID, CreateDate)
VALUES
	(1, 'Java Question', '4', '2', '4', '2022-02-06'),
	(2, 'Python Question', '9', '1', '4', '2022-02-06'),
	(3, 'C++ Question',  '3', '1', '1', '2022-02-06'),
	(4, 'PHP Question',  '8', '2', '4', '2022-02-06'),
    (5, 'Ruby Question',  '1', '2', '8', '2022-02-06'),
    (6, 'Java Question', '4', '2', '4', '2022-02-06'),
	(7, 'Python Question', '7', '1', '8', '2022-02-06'),
	(8, 'C++ Question',  '3', '1', '1', '2022-02-06'),
	(9, 'PHP Question',  '2', '2', '4', '2022-02-06'),
    (10, 'Ruby Question',  '1', '2', '5', '2022-02-06');
    

DROP TABLE IF EXISTS `Answer`;
CREATE TABLE `Answer` (
	AnswerID TINYINT UNSIGNED AUTO_INCREMENT,
    Content NVARCHAR(150) NOT NULL,
    QuestionID TINYINT UNSIGNED NOT NULL,
    isCorrect ENUM('True', 'False') NOT NULL,
    PRIMARY KEY (AnswerID),
    FOREIGN KEY (QuestionID) REFERENCES Question(QuestionID)
);

-- Add Data Answer--
INSERT INTO `Answer` (AnswerID, Content, QuestionID, isCorrect)
VALUES
	(1, 'Answer1', '4', 'True'),
	(2, 'Answer2', '2', 'False'),
	(3, 'Answer3', '5', 'True'),
	(4, 'Answer4', '4', 'True'),
    (5, 'Answer5', '3', 'True'),
    (6, 'Answer6', '4', 'True'),
	(7, 'Answer7', '2', 'False'),
	(8, 'Answer8', '4', 'False'),
	(9, 'Answer9', '8', 'True'),
    (10, 'Answe', '3', 'True');

DROP TABLE IF EXISTS `Exam`;
CREATE TABLE `Exam` (
	ExamID TINYINT UNSIGNED AUTO_INCREMENT,
    `Code` VARCHAR(15) NOT NULL,
    Title VARCHAR(50) NOT NULL,
    CategoryID TINYINT UNSIGNED NOT NULL,
    Duration TINYINT UNSIGNED NOT NULL,
    CreatorID TINYINT UNSIGNED NOT NULL,
    CreateDate DATETIME DEFAULT now(),
    PRIMARY KEY (ExamID),
    FOREIGN KEY (CategoryID) REFERENCES CategoryQuestion(CategoryID),
	FOREIGN KEY (CreatorID) REFERENCES `Account`(AccountID)
);

-- Add Data Exam--
INSERT INTO `Exam` (ExamID, `Code`, Title, CategoryID, Duration, CreatorID, CreateDate)
VALUES
	(1, 'A23BDU', 'Java Test', 2, 120, 2, '2022-02-05'),
	(2, 'B22BCU', 'Python Test', 1, 120, 1, '2022-02-02'),
	(3, 'B23BWU', 'C++Test', 5, 60, 5, '2022-02-02'),
	(4, 'A03BBU', 'PHP Test', 4, 180, 3, '2022-01-02'),
    (5, 'A212DU', 'Ruby Test', 2, 45, 2, '2022-02-02'),
    (6, 'A23BDU', 'Java Test', 2, 120, 2, '2022-02-05'),
	(7, 'B22BCU', 'Python Test', 1, 120, 9, '2022-02-02'),
	(8, 'B23BWU', 'C++Test', 5, 60, 7, '2022-02-02'),
	(9, 'A03BBU', 'PHP Test', 4, 180, 8, '2022-01-02'),
    (10, 'A212DU', 'Ruby Test', 2, 45, 2, '2022-02-02');

DROP TABLE IF EXISTS `ExamQuestion`;
CREATE TABLE `ExamQuestion` (
	ExamID TINYINT UNSIGNED NOT NULL,
    QuestionID TINYINT UNSIGNED NOT NULL,
    PRIMARY KEY (ExamID, QuestionID),
    FOREIGN KEY (ExamID) REFERENCES `Exam`(ExamID),
	FOREIGN KEY (QuestionID) REFERENCES Question(QuestionID)
);

-- Add Data Examquestion--
INSERT INTO `ExamQuestion` (ExamID, QuestionID)
VALUES
	(1, 5),
	(2, 3),
	(3, 4),
	(4, 2),
    (5, 1),
    (6, 3),
	(7, 7),
	(8, 8),
	(9, 9),
    (10, 10);


