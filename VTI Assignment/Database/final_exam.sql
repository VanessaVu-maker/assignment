-- Vu Thanh Van

-- Questions
-- 1. Tạo table với các ràng buộc và kiểu dữ liệu
-- Thêm ít nhất 3 bản ghi vào table
DROP DATABASE IF EXISTS Final_Exam;
CREATE DATABASE Final_Exam;
USE Final_Exam;

DROP TABLE IF EXISTS Student;
CREATE TABLE Student (
	StudentID TINYINT UNSIGNED AUTO_INCREMENT,
	StudentName NVARCHAR(50) NOT NULL,
    Age TINYINT UNSIGNED NOT NULL,
    Gender ENUM ('0', '1'),
	PRIMARY KEY (StudentID)
);

-- Add Data Student--
INSERT INTO Student (StudentID, StudentName, Age, Gender)
VALUES
	(1, 'Nguyen Van A', 12, '0'),
	(2, 'Nguyen Van B', 17, '1'),
	(3, 'Vu Thi C', 16, NULL);

DROP TABLE IF EXISTS `Subject`;
CREATE TABLE `Subject` (
	SubjectID TINYINT UNSIGNED AUTO_INCREMENT,
	`Name` NVARCHAR(50) NOT NULL,
	PRIMARY KEY (SubjectID)
);

-- Add Data Subject--
INSERT INTO `Subject` (Name)
VALUES
	('Geography'),
	('Python'),
	('History');

DROP TABLE IF EXISTS StudentSubject;
CREATE TABLE StudentSubject (
	StudentID TINYINT UNSIGNED NOT NULL,
    SubjectID TINYINT UNSIGNED NOT NULL,
    Mark VARCHAR(5) NOT NULL,
    `Date` DATETIME NOT NULL,
	PRIMARY KEY (StudentID, SubjectID),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
	FOREIGN KEY (SubjectID) REFERENCES `Subject`(SubjectID)
);

-- Add Data StudentSubject--
INSERT INTO StudentSubject (StudentID, SubjectID, Mark, `Date`)
VALUES
	(1, 3, 'C', '2022/02/06'),
	(2, 3, 'B', '2022/02/06'),
    (2, 2, 'A', '2022/02/06'),
    (1, 1, 'C', '2022/02/06');
    
-- 2. Viết lệnh để
-- a) Lấy tất cả các môn học không có bất kì điểm nào
SELECT SubjectID, COUNT(Mark) AS 'So diem cua mot mon hoc'
FROM studentsubject
GROUP BY SubjectID
HAVING COUNT(Mark) = 0;

-- b) Lấy danh sách các môn học có ít nhất 2 điểm
SELECT SubjectID, COUNT(Mark)
FROM studentsubject
GROUP BY SubjectID
HAVING COUNT(Mark) >= 2;

-- 3. Tạo view có tên là "StudentInfo" lấy các thông tin về học sinh bao gồm:
-- Student ID,Subject ID, Student Name, Student Age, Student Gender,
-- Subject Name, Mark, Date


DROP VIEW IF EXISTS v_StudentInfo;
CREATE VIEW v_StudentInfo AS
	SELECT student.*, susu.mark,susu.`date`, `subject`.`name`
	FROM studentsubject susu
	JOIN student ON susu.studentID = student.studentID
	JOIN `subject` ON susu.subjectID = `subject`.subjectID;
END $$
DELIMITER ;

SELECT *
FROM v_StudentInfo;

-- 4. Không sử dụng On Update Cascade & On Delete Cascade
-- a) Tạo trigger cho table Subject có tên là SubjectUpdateID:
-- Khi thay đổi data của cột ID của table Subject, thì giá trị tương
-- ứng với cột SubjectID của table StudentSubject cũng thay đổi
-- theo
DROP TRIGGER IF EXISTS SubjectUpdateID;
DELIMITER $$
CREATE TRIGGER SubjectUpdateID
AFTER UPDATE ON `subject`
FOR EACH ROW
BEGIN
DECLARE v_subjectID TINYINT UNSIGNED;
SELECT `subject`.subjectID INTO v_subjectID;
	UPDATE studentsubject
	SET v_subjectID = studentsubject.v_subjectID;
END $$
DELIMITER ;  
 
UPDATE `subject`
SET SubjectID = 3
WHERE SubjectID = 2;

-- b) Tạo trigger cho table StudentSubject có tên là StudentDeleteID:
-- Khi xóa data của cột ID của table Student, thì giá trị tương ứng với
-- cột StudentID của table StudentSubject cũng bị xóa theo
DROP TRIGGER IF EXISTS StudentDeleteID;
DELIMITER $$
CREATE TRIGGER StudentDeleteID
AFTER DELETE ON student
FOR EACH ROW
BEGIN
DECLARE v_studentID TINYINT UNSIGNED;
SELECT student.studentID INTO v_studentID;
	DELETE FROM studentsubject
	WHERE v_studentID = studentsubject.studentID;
END $$
DELIMITER ;  
        
DELETE FROM final_exam.student
WHERE StudentID = 2;

-- 5. Viết 1 store procedure (có 2 parameters: student name) sẽ xóa tất cả các
-- thông tin liên quan tới học sinh có cùng tên như parameter
-- Trong trường hợp nhập vào student name = "*" thì procedure sẽ xóa tất cả
-- các học sinh

DROP PROCEDURE IF EXISTS procedure_delete_student;
DELIMITER $$
CREATE PROCEDURE procedure_delete_student ( IN in_studentname NVARCHAR(50)) 
	BEGIN
		DECLARE 	v_studentname NVARCHAR(50);
		SELECT  	studentname INTO v_studentname FROM student WHERE studentname = in_studentname;
		DELETE FROM student WHERE studentname = in_studentname;
			IF in_studentname = "*" THEN
            DELETE  FROM student;
				END IF;
	END $$
DELIMITER ;

call final_exam.procedure_delete_student('Vu Thi C');