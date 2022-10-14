-- Question 1: Tạo store để người dùng nhập vào tên phòng ban và in ra tất cả các account thuộc phòng ban đó
DROP PROCEDURE IF EXISTS	pro_q1
DELIMITER $$
CREATE PROCEDURE pro_q1 (IN in_departmentName NVARCHAR(50))
BEGIN
	SELECT	a.*
    FROM	`account` a
    JOIN	department D ON D.departmentID = a.departmentID
    WHERE	d.departmentName = in_departmentName;
END$$
DELIMITER ;

SET @a = 'sale';
SELECT @a;
CALL pro_q1 (@a);

-- Question 2: Tạo store để in ra số lượng account trong mỗi group
DROP PROCEDURE IF EXISTS PRO_Q2;
DELIMITER $$
CREATE PROCEDURE PRO_Q2 (IN in_GroupID TINYINT UNSIGNED)
	BEGIN
		SELECT g.groupID, g.GroupName, COUNT(ga.Accountid)
        FROM GROUPACCOUNT ga
        JOIN `group` g ON ga.GroupID = g.GroupID
        WHERE g.groupID = in_groupID;
	END $$
DELIMITER ;

CALL pro_q2(1);


-- Question 3: Tạo store để thống kê mỗi type question có bao nhiêu question được tạo
-- trong tháng hiện tại

DROP PROCEDURE IF EXISTS pro_q3;
DELIMITER $$
CREATE PROCEDURE pro_q3()
BEGIN
	SELECT tq.TypeName, count(q.TypeID) 
    FROM question q
	RIGHT JOIN typequestion tq ON q.TypeID = tq.TypeID
	WHERE month(q.CreateDate) = month(now()) AND year(q.CreateDate) = year(now())
	GROUP BY q.TypeID;
END$$
DELIMITER ;
Call pro_q3();

-- question 4: Tạo store để trả ra id của type question có nhiều câu hỏi nhất

DROP PROCEDURE IF EXISTS pro_q4;
DELIMITER $$
CREATE PROCEDURE pro_q4()
BEGIN
	WITH CTE_MaxTypeID AS(
	SELECT count(q.TypeID) AS So_cau_tra_loi FROM question q
	GROUP BY q.TypeID
	)
	SELECT tq.TypeName, count(q.TypeID) AS So_cau_tra_loi FROM question q
	INNER JOIN typequestion tq ON tq.TypeID = q.TypeID
	GROUP BY q.TypeID
	HAVING count(q.TypeID) = (SELECT MAX(So_cau_tra_loi) FROM CTE_MaxTypeID);
END$$
DELIMITER ;

CALL pro_q4();

-- Question 5: Sử dụng store ở question 4 để tìm ra tên của type question
DROP PROCEDURE IF EXISTS pro_q4;
DELIMITER $$
CREATE PROCEDURE pro_q4()
BEGIN
	WITH CTE_MaxTypeID AS(
	SELECT count(q.TypeID) AS ten_type_question FROM question q
	GROUP BY q.TypeID
	)
	SELECT tq.TypeName, count(q.TypeID) AS SL FROM question q
	INNER JOIN typequestion tq ON tq.TypeID = q.TypeID
	GROUP BY q.TypeID
	HAVING count(q.TypeID) = (SELECT MAX(ten_type_question) FROM CTE_MaxTypeID);
END$$
DELIMITER ;

Call pro_q4();

-- Question 6: Viết 1 store cho phép người dùng nhập vào 1 chuỗi và trả về group có tên
-- chứa chuỗi của người dùng nhập vào hoặc trả về user có username chứa
-- chuỗi của người dùng nhập vào

DROP PROCEDURE IF EXISTS pro_q6;
DELIMITER $$

CREATE PROCEDURE pro_q6
( IN var_String VARCHAR(50))
BEGIN
	SELECT g.GroupName FROM `group` g WHERE g.GroupName LIKE
	CONCAT("%",var_String,"%")
	UNION
	SELECT a.Username FROM `account` a WHERE a.Username LIKE
	CONCAT("%",var_String,"%");
END$$
DELIMITER ;

Call pro_q6('ale');

-- Question 7: Viết 1 store cho phép người dùng nhập vào thông tin fullName, email và
-- trong store sẽ tự động gán:
-- username sẽ giống email nhưng bỏ phần @..mail đi
-- positionID: sẽ có default là developer
-- departmentID: sẽ được cho vào 1 phòng chờ

-- Sau đó in ra kết quả tạo thành công

DROP PROCEDURE IF EXISTS pro_q7;
DELIMITER $$
CREATE PROCEDURE  pro_q7
( IN var_Email VARCHAR(25),
IN var_Fullname VARCHAR(50))
BEGIN
	DECLARE v_Username VARCHAR(50) DEFAULT SUBSTRING_INDEX(var_Email, '@', 1);
	DECLARE v_PositionID TINYINT UNSIGNED DEFAULT 1;
	DECLARE v_DepartmentID TINYINT UNSIGNED DEFAULT 11;
	DECLARE v_CreateDate DATETIME DEFAULT now();
	INSERT INTO `account` (`Email`, `Username`, `FullName`,
	`DepartmentID`, `PositionID`, `CreateDate`)
	VALUES (var_Email, v_Username, var_Fullname,
	v_DepartmentID, v_PositionID, v_CreateDate);
END$$
DELIMITER ;

Call pro_q7('vthanhvan2000@gmail.com','Vu Thanh Van');

-- Question 8: Viết 1 store cho phép người dùng nhập vào Essay hoặc Multiple-Choice
-- để thống kê câu hỏi essay hoặc multiple-choice nào có content dài nhất

-- Question 9: Viết 1 store cho phép người dùng xóa exam dựa vào ID

DROP PROCEDURE IF EXISTS pro_q9;
DELIMITER $$
CREATE PROCEDURE pro_q9 (IN in_ExamID TINYINT UNSIGNED)
	BEGIN
	DELETE FROM examquestion WHERE ExamID = in_ExamID;
	DELETE FROM Exam WHERE ExamID = in_ExamID;
	END$$
DELIMITER ;
CALL pro_q9(4);

-- Question 10: Tìm ra các exam được tạo từ 3 năm trước và xóa các exam đó đi (sử
-- dụng store ở câu 9 để xóa)


-- Sau đó in số lượng record đã remove từ các table liên quan trong khi
-- removing
-- Question 11: Viết store cho phép người dùng xóa phòng ban bằng cách người dùng
-- nhập vào tên phòng ban và các account thuộc phòng ban đó sẽ được
-- chuyển về phòng ban default là phòng ban chờ việc
-- Question 12: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong năm
-- nay

-- Question 13: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong 6
-- tháng gần đây nhất
-- (Nếu tháng nào không có thì sẽ in ra là "không có câu hỏi nào trong
-- tháng")