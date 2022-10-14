-- Vu Thanh Van

DROP DATABASE IF EXISTS Testing_System_Assignment_1;
CREATE DATABASE Testing_System_Assignment_1;
USE Testing_System_Assignment_1;

-- Question 1:Tạo View có chứa danh sách nhân viên thuộc phòng ban SALE
DROP VIEW IF EXISTS v_department_sale;
CREATE VIEW v_department_sale AS
	SELECT a.*,d.departmentname
	FROM `Account` a
	INNER JOIN Department d ON a.departmentid = d.departmentid
	WHERE d.departmentname = 'Sale';

SELECT *
FROM v_department_sale;

-- Tạo CTE
WITH CTE_Q1 AS (
	SELECT a.*,d.departmentname
	FROM `Account` a
	INNER JOIN Department d ON a.departmentid = d.departmentid
	WHERE d.departmentname = 'Sale')
SELECT * FROM CTE_Q1;


-- Q2: Tạo view có chứa thông tin các account tham gia vào nhiều group nhất
DROP VIEW IF EXISTS v_group_max_account;
CREATE VIEW v_group_max_account AS
	SELECT a.*, count(a.accountid)
    FROM `Account` a
    INNER JOIN GroupAccount ga ON a.accountid = ga.accountid
    GROUP BY Groupid
    HAVING count(a.accountid) = (SELECT count(*)
								 FROM GroupAccount
                                 GROUP BY Groupid
                                 ORDER BY count(*) DESC 
                                 LIMIT 1);
                                 
SELECT *
FROM v_group_max_account;

-- Tạo CTE Q2

WITH CTE_Q2 AS (
	SELECT a.*, count(a.accountid)
    FROM `Account` a
    INNER JOIN GroupAccount ga ON a.accountid = ga.accountid
    GROUP BY Groupid
    HAVING count(a.accountid) = (SELECT count(*)
								 FROM GroupAccount
                                 GROUP BY Groupid
                                 ORDER BY count(*) DESC 
                                 LIMIT 1)
						)
SELECT *
FROM CTE_Q2;

-- Question 3: Tạo view có chứa câu hỏi có những content quá dài (content quá 300 từ
-- được coi là quá dài) và xóa nó đi

DROP VIEW IF EXISTS v_long_content;
CREATE VIEW v_long_content AS
	SELECT q.Content
    FROM question q
    WHERE LENGTH(q.Content) > 300;

SELECT *
FROM v_long_content;

DELETE FROM v_long_content;

-- Tạo CTE Q3
WITH CTE_Q3 AS (
	SELECT q.Content
    FROM question q
    WHERE LENGTH(q.Content) > 300)
SELECT * FROM CTE_Q3;

-- Question 4: Tạo view có chứa danh sách các phòng ban có nhiều nhân viên nhất

DROP VIEW IF EXISTS v_department_max_employee;
CREATE VIEW v_department_max_employee AS 
	SELECT a.DepartmentID, d.departmentname, COUNT(a.AccountID)
    FROM `account` a 
    JOIN department d ON a.DepartmentID = d.DepartmentID
    GROUP BY a.DepartmentID
    HAVING COUNT(a.AccountID) = 
		(SELECT COUNT(AccountID)
        FROM `account`
        GROUP BY DepartmentID
		ORDER BY COUNT(AccountID) DESC
        LIMIT 1)
    ;

SELECT *
FROM v_department_max_employee;

-- Tạo CTE Q4
WITH CTE_Q4 AS (
	SELECT a.DepartmentID, d.departmentname, COUNT(a.AccountID)
    FROM `account` a 
    JOIN department d ON a.DepartmentID = d.DepartmentID
    GROUP BY a.DepartmentID
    HAVING COUNT(a.AccountID) = 
		(SELECT COUNT(AccountID)
        FROM `account`
        GROUP BY DepartmentID
		ORDER BY COUNT(AccountID) DESC
        LIMIT 1))
SELECT * FROM CTE_Q4;

-- Question 5: Tạo view có chứa tất các các câu hỏi do user họ Nguyễn tạo

DROP VIEW IF EXISTS v_Nguyen_user_question;
CREATE VIEW v_Nguyen_user_question AS
	SELECT a.FullName, q.creatorID, q.Content
    FROM `account` a
    JOIN question q ON a.accountID = q.creatorID
    WHERE SUBSTRING_INDEX(a.FullName, ' ', 1) = 'Nguyen';

SELECT *
FROM v_Nguyen_user_question;

-- Tạo CTE Q5
WITH CTE_Q5 AS (
	SELECT a.FullName, q.creatorID, q.Content
    FROM `account` a
    JOIN question q ON a.accountID = q.creatorID
    WHERE SUBSTRING_INDEX(a.FullName, ' ', 1) = 'Nguyen'
)
SELECT *
FROM CTE_Q5;

