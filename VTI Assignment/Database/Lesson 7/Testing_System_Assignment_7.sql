-- BUỔI 11
-- Chèn 1 nhân viên, kiểm tra ngày tạo không lớn hơn ngày hiện trước khi chèn
INSERT INTO `account` VALUES (15,'Test@gmail.com','Test','Tester',10,1,'2022-3-12');

-- dùng trigger để kiểm tra
DROP TRIGGER IF EXISTS tg_create_time;
DELIMITER $$
CREATE TRIGGER tg_create_time
BEFORE INSERT ON `account`
FOR EACH ROW
BEGIN
		IF NEW.createdate > NOW() THEN
			SIGNAL SQLSTATE '12345'
            SET MESSAGE_TEXT = 'Hông cho nhập đâu';
		END IF;
END $$
DELIMITER ;

-- Viết trigger để kiểm tra trước khi chèn trong bảng account,
-- email có độ dài không quá 20 kí tự
DROP TRIGGER IF EXISTS tg_email;
DELIMITER $$
CREATE TRIGGER tg_email
BEFORE INSERT ON `Account`
FOR EACH ROW
BEGIN
	IF length(NEW.Email) > 20 THEN
        SIGNAL SQLSTATE '12345'
        SET MESSAGE_TEXT = 'Dài quá';
	END IF;
END $$
DELIMITER ;
INSERT INTO `account` VALUES (15,'Test@gmail.com','Test','Tester',10,1,'2022-3-10');


-- Question 1: Tạo trigger không cho phép người dùng nhập vào Group có ngày tạo
-- trước 1 năm trước

DROP TRIGGER IF EXISTS tg_q1;
DELIMITER $$
CREATE TRIGGER tg_q1
BEFORE INSERT ON `Group`
FOR EACH ROW
BEGIN
		IF Year(Now()) - Year(NEW.CreateDate) > 1 THEN
			SIGNAL SQLSTATE '12345'
            SET MESSAGE_TEXT = 'Ngày tạo k hợp lệ';
		END IF;
END $$
DELIMITER ;

-- Question 2: Tạo trigger Không cho phép người dùng thêm bất kỳ user nào vào
-- department "Sale" nữa, khi thêm thì hiện ra thông báo "Department
-- "Sale" cannot add more user"

DROP TRIGGER IF EXISTS tg_q2;
DELIMITER $$
CREATE TRIGGER tg_q2
BEFORE INSERT ON `account`
FOR EACH ROW
BEGIN
DECLARE v_departmentid TINYINT;
SELECT d.DepartmentID INTO v_departmentid FROM Department d WHERE d.DepartmentName LIKE 'Sale';
		IF  new.DepartmentID = v_departmentid THEN
			SIGNAL SQLSTATE '12345'
            SET MESSAGE_TEXT = 'Department Sale cannot add more user';
		END IF;
END $$
DELIMITER ;

-- Question 3: Cấu hình 1 group có nhiều nhất là 5 user

DROP TRIGGER IF EXISTS tg_q3;
DELIMITER $$
CREATE TRIGGER tg_q3
BEFORE INSERT ON groupaccount
FOR EACH ROW
BEGIN
DECLARE v_count_accountid TINYINT;
SELECT COUNT(ga.accountID) INTO v_count_accountid
FROM groupaccount ga
WHERE ga.GroupID = NEW.GroupID;
	IF v_count_accountid > 5 THEN
			SIGNAL SQLSTATE '12345'
            SET MESSAGE_TEXT = 'Maximum 5 users per group';
		END IF;
END $$
DELIMITER ;

INSERT INTO groupaccount (GroupID, AccountID, JoinDate)
VALUES
	(3, 2, '2022-02-02 00:00:00'),
    (3, 5, '2022-02-02 00:00:00'),
    (3, 1, '2022-02-02 00:00:00'),
    (3, 6, '2022-02-02 00:00:00'),
    (3, 8, '2022-02-02 00:00:00');

-- Question 4: Cấu hình 1 bài thi có nhiều nhất là 10 Question

DROP TRIGGER IF EXISTS tg_q4;
DELIMITER $$
CREATE TRIGGER tg_q4
BEFORE INSERT ON examquestion
FOR EACH ROW
BEGIN
DECLARE v_count_questionid TINYINT;
SELECT COUNT(eq.questionID) INTO v_count_questionid
FROM examquestion eq
WHERE eq.ExamID = NEW.ExamID;
	IF v_count_questionid > 10 THEN
			SIGNAL SQLSTATE '12345'
            SET MESSAGE_TEXT = 'Maximum 10 questions per exam';
		END IF;
END $$
DELIMITER ;

    
-- Question 5: Tạo trigger không cho phép người dùng xóa tài khoản có email là
-- admin@gmail.com (đây là tài khoản admin, không cho phép user xóa),
-- còn lại các tài khoản khác thì sẽ cho phép xóa và sẽ xóa tất cả các thông
-- tin liên quan tới user đó

DROP TRIGGER IF EXISTS tg_q5;
DELIMITER $$
CREATE TRIGGER tg_q5
BEFORE DELETE ON `account`
FOR EACH ROW
BEGIN
DECLARE v_email VARCHAR(50);
SET v_email = 'admin@gmail.com';
	IF OLD.Email = v_email THEN
			SIGNAL SQLSTATE '12345'
            SET MESSAGE_TEXT = 'Cannot delete admin email';
		END IF;
END $$
DELIMITER ;

DELETE
FROM `account`
WHERE Email = 'admin@gmail.com';

-- Question 6: Không sử dụng cấu hình default cho field DepartmentID của table
-- Account, hãy tạo trigger cho phép người dùng khi tạo account không điền
-- vào departmentID thì sẽ được phân vào phòng ban "waiting Department"

DROP TRIGGER IF EXISTS tg_q6;
DELIMITER $$
CREATE TRIGGER tg_q6
BEFORE INSERT ON `account`
FOR EACH ROW
BEGIN
DECLARE v_departmdepartmententID VARCHAR(50);
SELECT DepartmentID INTO v_departmentID
FROM department
WHERE DepartmentName = 'Waiting Room';
	IF NEW.departmentID IS NULL THEN
			SET NEW.departmentID  = v_departmentID;
		END IF;
END $$
DELIMITER ;

INSERT INTO `account` (Email, Username, FullName, PositionID, CreateDate)
VALUES ('Test2@gmail.com','Test2','Tester2', 1,'2022-3-10');

-- Question 7: Cấu hình 1 bài thi chỉ cho phép user tạo tối đa 4 answers cho mỗi
-- question, trong đó có tối đa 2 đáp án đúng.

-- DROP TRIGGER IF EXISTS tg_q7;
-- DELIMITER $$
-- CREATE TRIGGER tg_q7
-- BEFORE INSERT ON answer
-- FOR EACH ROW BEGIN
-- DECLARE v_count_questionid TINYINT;
-- DECLARE v_count_iscorrect TINYINT;
-- SELECT COUNT(a.quetionID) INTO v_count_questionid
-- FROM answer a
-- WHERE a.quetionID = NEW.quetionID;
-- SELECT COUNT(a.isCorrect) INTO v_count_iscorrect
-- FROM answer a
-- WHERE a.quetionID = NEW.quetionID
-- AND a.isCorrect = NEW.isCorrect;
-- 	IF v_count_questionid > 4 
--     OR v_count_iscorrect > 2  THEN
-- 			SIGNAL SQLSTATE '12345'
--             SET MESSAGE_TEXT = 'Maximum 4 answers per question, maximum 2 true answers';
-- 		END IF;
-- END $$
-- DELIMITER ;

-- INSERT INTO answer (QuestionID, isCorrect)
-- VALUES (4, True)

-- Question 8: Viết trigger sửa lại dữ liệu cho đúng:
-- Nếu người dùng nhập vào gender của account là nam, nữ, chưa xác định
-- Thì sẽ đổi lại thành M, F, U cho giống với cấu hình ở database

-- Question 9: Viết trigger không cho phép người dùng xóa bài thi mới tạo được 2 ngày
-- Question 10: Viết trigger chỉ cho phép người dùng chỉ được update, delete các
-- question khi question đó chưa nằm trong exam nào
-- Question 12: Lấy ra thông tin exam trong đó:

-- Duration <= 30 thì sẽ đổi thành giá trị "Short time"
-- 30 < Duration <= 60 thì sẽ đổi thành giá trị "Medium time"
-- Duration > 60 thì sẽ đổi thành giá trị "Long time"

-- Question 13: Thống kê số account trong mỗi group và in ra thêm 1 column nữa có tên
-- là the_number_user_amount và mang giá trị được quy định như sau:
-- Nếu số lượng user trong group =< 5 thì sẽ có giá trị là few
-- Nếu số lượng user trong group <= 20 và > 5 thì sẽ có giá trị là normal
-- Nếu số lượng user trong group > 20 thì sẽ có giá trị là higher
-- Question 14: Thống kê số mỗi phòng ban có bao nhiêu user, nếu phòng ban nào
-- không có user thì sẽ thay đổi giá trị 0 thành "Không có User"

