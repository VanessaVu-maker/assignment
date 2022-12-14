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
    DepartmentID TINYINT UNSIGNED,
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

-- Exercise 1: Join
-- Question 1: Vi???t l???nh ????? l???y ra danh s??ch nh??n vi??n v?? th??ng tin ph??ng ban c???a h???

SELECT `account`.FullName, `account`.DepartmentID, department.DepartmentName
FROM `account`
JOIN department
ON `account`.DepartmentID = department.DepartmentID;

-- y bo sung: th???ng k?? s??? l?????ng nh??n vi??n trong m???i ph??ng ban
SELECT  department.DepartmentName, COUNT(`account`.AccountID) AS 'SL Nhan vien'
FROM `account`
JOIN department ON `account`.DepartmentID = department.DepartmentID
GROUP BY department.DepartmentName;

-- Question 2: Vi???t l???nh ????? l???y ra th??ng tin c??c account ???????c t???o sau ng??y 20/12/2010
SELECT *
FROM `account`
WHERE CreateDate > 2010-12-20;

-- Question 3: Vi???t l???nh ????? l???y ra t???t c??? c??c developer
SELECT Position.PositionName, Position.PositionID, `account`.FullName
FROM Position
JOIN `account`
ON Position.PositionID = `account`.PositionID
WHERE Position.PositionName = 'Dev';

-- Question 4: Vi???t l???nh ????? l???y ra danh s??ch c??c ph??ng ban c?? >3 nh??n vi??n
SELECT Department.DepartmentID, COUNT(`account`.DepartmentID) AS 'No. of employee'
FROM Department
JOIN `account`
ON Department.DepartmentID = `account`.DepartmentID
GROUP BY Department.DepartmentID
HAVING COUNT(`account`.DepartmentID) > 3;

-- Question 5: Vi???t l???nh ????? l???y ra danh s??ch c??u h???i ???????c s??? d???ng trong ????? thi nhi???u nh???t

SELECT ExamQuestion.QuestionID, Question.Content, COUNT(*) AS So_luong_cau_hoi
FROM ExamQuestion
JOIN Question
ON ExamQuestion.QuestionID = Question.QuestionID
GROUP BY Question.QuestionID
HAVING COUNT(*) = (
				SELECT COUNT(*) 
                FROM ExamQuestion
                GROUP BY QuestionID
                ORDER BY COUNT(*) DESC
                LIMIT 1
                );

-- cach 2
SELECT eq.QuestionID, q.Content, COUNT(eq.questionID) AS So_luong_cau_hoi
FROM ExamQuestion eq
JOIN Question q ON eq.QuestionID = q.QuestionID
GROUP BY eq.QuestionID
HAVING COUNT(eq.questionID) = 
	(SELECT max(count_question) AS 'max_count_question'
	FROM 
		(SELECT COUNT(eq.questionID) AS count_question
		FROM ExamQuestion eq 
		GROUP BY eq.QuestionID) AS COUNT123
	);


-- Question 6: Th??ng k?? m???i category Question ???????c s??? d???ng trong bao nhi??u Question
SELECT categoryquestion.CategoryName, COUNT(question.QuestionID) AS 'No. of question', GROUP_CONCAT(question.questionid) AS 'Question List'
FROM categoryquestion
LEFT JOIN question
ON question.CategoryID = categoryquestion.CategoryID
GROUP BY categoryquestion.CategoryID;
-- ch?? ?? group by categoryid c???a b???ng n??o. count theo c???t null.
 
-- Question 7: Th??ng k?? m???i Question ???????c s??? d???ng trong bao nhi??u Exam

SELECT question.Content, COUNT(examquestion.QuestionID) AS 'No. of Question'
FROM examquestion
RIGHT JOIN question ON examquestion.QuestionID = question.QuestionID
GROUP BY question.QuestionID;

-- Question 8: L???y ra Question c?? nhi???u c??u tr??? l???i nh???t

SELECT question.QuestionID, question.content, COUNT(answer.AnswerID) AS 'No. of answers'
FROM answer
JOIN question ON question.questionID = answer.questionID
GROUP BY (question.QuestionID)
HAVING COUNT(answer.AnswerID) = (
	SELECT COUNT(AnswerID)
    FROM answer
    GROUP BY QuestionID
    ORDER BY COUNT(AnswerID) DESC
    LIMIT 1);

-- cach 2
SELECT question.QuestionID, question.content, COUNT(answer.AnswerID) AS 'No. of answers'
FROM answer
JOIN question ON question.questionID = answer.questionID
GROUP BY (question.QuestionID)
HAVING COUNT(answer.AnswerID) = 
	(SELECT max(So_luong_cau_hoi) AS max_number_of_question
	FROM (SELECT COUNT(AnswerID) AS So_luong_cau_hoi
		FROM answer
		GROUP BY QuestionID) AS QuestionID_1
	);

-- Question 9: Th???ng k?? s??? l?????ng account trong m???i group
SELECT `group`.GroupID, COUNT(groupaccount.AccountID) AS 's??? l?????ng account'
FROM `group`
LEFT JOIN groupaccount ON `group`.GroupID = groupaccount.GroupID
GROUP BY `group`.GroupID;

-- Question 10: T??m ch???c v??? c?? ??t ng?????i nh???t

SELECT position.PositionName, `Account`.PositionID, COUNT(`Account`.AccountID), GROUP_CONCAT(`Account`.username)
FROM `Account`
RIGHT JOIN position ON `Account`.PositionID = position.PositionID
GROUP BY `Account`.PositionID
HAVING COUNT(`Account`.AccountID) = (
	SELECT COUNT(AccountID)
	FROM `Account`
	GROUP BY PositionID
	ORDER BY COUNT(AccountID)
	LIMIT 1);

-- cach 2
SELECT position.PositionName, `Account`.PositionID, COUNT(`Account`.AccountID), GROUP_CONCAT(`Account`.username)
FROM `Account`
RIGHT JOIN position ON `Account`.PositionID = position.PositionID
GROUP BY `Account`.PositionID
HAVING COUNT(`Account`.AccountID) = (
	SELECT min(chuc_vu_it_nguoi) AS position_min_employee
    FROM (SELECT COUNT(`Account`.AccountID) AS chuc_vu_it_nguoi
		FROM `Account`
        GROUP BY `Account`.PositionID) AS  position_1_2
        );

-- Question 11: Th???ng k?? m???i ph??ng ban c?? bao nhi??u dev, test, scrum master, PM

-- Query 1
SELECT  department.DepartmentName, COUNT(`account`.DepartmentID) AS 'No. of position', 
GROUP_CONCAT(position.PositionName)
FROM `account`
JOIN position ON `account`.PositionID =  position.PositionID
JOIN department ON `account`.DepartmentID = department.departmentID
GROUP BY `account`.DepartmentID;

-- Query 2
SELECT department.DepartmentID, department.DepartmentName, position.PositionName, count(position.PositionName) 
FROM `account`
JOIN department ON `account`.DepartmentID = department.DepartmentID
JOIN position ON `account`.PositionID = position.PositionID
GROUP BY department.DepartmentID, position.PositionID;

-- UNION c??? hai b???ng v???i nhau (left v???i right)
-- Question 12: L???y th??ng tin chi ti???t c???a c??u h???i bao g???m: th??ng tin c?? b???n c???a question, lo???i c??u h???i, ai l?? ng?????i t???o ra c??u h???i, c??u tr??? l???i l?? g??, ...
SELECT question.QuestionID, question.Content AS 'Question Content', question.CreatorID, categoryquestion.categoryName, 
typequestion.TypeName, answer.content AS 'Answer Content'
FROM question
JOIN categoryquestion ON question.categoryID = categoryquestion.categoryID
JOIN typequestion ON question.TypeID = typequestion.TypeID
JOIN answer ON question.QuestionID = answer.QuestionID;

-- Question 13: L???y ra s??? l?????ng c??u h???i c???a m???i lo???i t??? lu???n hay tr???c nghi???m
SELECT typequestion.typeName, COUNT(QuestionID), GROUP_CONCAT(question.QuestionID)
FROM question
JOIN typequestion ON question.typeID = typequestion.typeID
GROUP BY typeName;
-- d??ng left join v???i question

-- Question 14:L???y ra group kh??ng c?? account n??o
-- Question 15: L???y ra group kh??ng c?? account n??o
SELECT `group`.GroupID, groupaccount.AccountID
FROM `group`
LEFT JOIN groupaccount ON `group`.GroupID = groupaccount.GroupID
WHERE groupaccount.AccountID IS NULL;

-- Question 16: L???y ra question kh??ng c?? answer n??o
SELECT question.QuestionID, answer.AnswerID
FROM question
LEFT JOIN answer ON question.QuestionID = answer.QuestionID
WHERE answer.AnswerID IS NULL;

-- Exercise 2: Union
-- Question 17:
-- a) L???y c??c account thu???c nh??m th??? 1
SELECT AccountID, GroupID
FROM groupaccount
WHERE GroupID = 1;

-- Ph???i d??ng join 

-- b) L???y c??c account thu???c nh??m th??? 2
SELECT AccountID, GroupID
FROM groupaccount
WHERE GroupID = 2;

-- Ph???i d??ng join 

-- c) Gh??p 2 k???t qu??? t??? c??u a) v?? c??u b) sao cho kh??ng c?? record n??o tr??ng nhau
SELECT AccountID, GroupID
FROM groupaccount
WHERE GroupID = 1
UNION
SELECT AccountID, GroupID
FROM groupaccount
WHERE GroupID = 2;

-- Question 18:
-- a) L???y c??c group c?? l???n h??n 5 th??nh vi??n
SELECT AccountID, GroupID, COUNT(AccountID) AS 'No. of member'
FROM groupaccount
GROUP BY GroupID
HAVING COUNT(AccountID) > 5;

-- b) L???y c??c group c?? nh??? h??n 7 th??nh vi??n
SELECT AccountID, GroupID, COUNT(AccountID) AS 'No. of member'
FROM groupaccount
GROUP BY GroupID
HAVING COUNT(AccountID) <7;

-- c) Gh??p 2 k???t qu??? t??? c??u a) v?? c??u b)
SELECT AccountID, GroupID, COUNT(AccountID) AS 'No. of member'
FROM groupaccount
GROUP BY GroupID
HAVING COUNT(AccountID) > 5
UNION
SELECT AccountID, GroupID, COUNT(AccountID) AS 'No. of member'
FROM groupaccount
GROUP BY GroupID
HAVING COUNT(AccountID) <7;