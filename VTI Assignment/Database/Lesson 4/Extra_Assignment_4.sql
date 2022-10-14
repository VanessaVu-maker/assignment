-- Question 1: Tạo table với các ràng buộc và kiểu dữ liệu
DROP DATABASE IF EXISTS extra_4;
CREATE DATABASE extra_4;
USE extra_4;

DROP TABLE IF EXISTS Department;
CREATE TABLE Department (
	Department_Number TINYINT AUTO_INCREMENT,
	Department_Name varchar(50) NOT NULL UNIQUE,
    PRIMARY KEY (Department_Number)
);

DROP TABLE IF EXISTS Employee_Table;
CREATE TABLE Employee_Table (
	Employee_Number TINYINT AUTO_INCREMENT,
	Employee_Name varchar(50) NOT NULL,
    Department_Number TINYINT NOT NULL,
	PRIMARY KEY (Employee_Number),
    FOREIGN KEY (Department_Number) REFERENCES Department (Department_Number)
);

DROP TABLE IF EXISTS Employee_Skill_Table;
CREATE TABLE Employee_Skill_Table (
	Employee_Number INT,
	Skill_Code varchar(50) NOT NULL,
    Date_Registered DATETIME DEFAULT now(),
	FOREIGN KEY (Employee_Number) REFERENCES Employee_Table (Employee_Number)
    );
 
-- Question 2: Thêm ít nhất 10 bản ghi vào table
INSERT INTO Department (Department_Number,  Department_Name)
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
    
INSERT INTO Employee_Table (Employee_Number, Employee_Name, Department_Number)
VALUES
	(1,'Nguyen Hoang', 4),
	(2,'Nguyen Ly', 7),
	(3, 'Tra My', 3),
	(4, 'Tra Long', 3),
	(5, 'Ha Phong', 2),
    (6, 'Nguyen Ha Phuong', 1),
	(7, 'Phong Long', 1),
	(8, 'Nguyen Ngoc Ngan', 8),
	(9, 'Vu Minh Ha', 9),
	(10, 'Hoang Ngoc Lan', 7);
    
INSERT INTO Employee_Skill_Table (Employee_Number,  Skill_Code, Date_Registered)
VALUES
	(1, 'Java', '2022-02-22'),
	(1, 'Ruby', '2022-02-21'),
	(2, 'SQL', '2022-02-24'),
	(4, 'Java', '2022-02-26'),
    (4, 'PHP', '2022-01-23'),
    (6, 'Java', '2022-12-23'),
	(7, 'Python', '2022-02-23'),
	(8, 'SQL', '2021-07-23'),
	(9, 'HTML', '2022-01-23'),
    (10, 'HTML', '2022-02-23');
    
-- Question 3: Viết lệnh để lấy ra danh sách nhân viên (name) có skill Java
SELECT employee_table.employee_name, employee_skill_table.skill_code
FROM employee_table
JOIN employee_skill_table
ON employee_table.employee_number = employee_skill_table.employee_number
WHERE employee_skill_table.skill_code = 'Java';

-- Question 4: Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên
SELECT department.department_name, COUNT(employee_table.department_number) AS 'No. of employee'
FROM department
JOIN employee_table ON department.department_number = employee_table.department_number
GROUP BY department.department_name
HAVING COUNT(employee_table.department_number) > 3;

-- Question 5: Viết lệnh để lấy ra danh sách nhân viên của mỗi văn phòng ban.
SELECT department.department_name, GROUP_CONCAT(employee_table.employee_name) AS 'Employee List'
FROM department
JOIN employee_table ON department.department_number = employee_table.department_number
GROUP BY department.department_name;

-- Question 6: Viết lệnh để lấy ra danh sách nhân viên có > 1 skills.

SELECT employee_table.employee_name, COUNT(employee_skill_table.skill_code) AS 'No. of skills'
FROM employee_table
JOIN employee_skill_table
ON employee_table.employee_number = employee_skill_table.employee_number
GROUP BY employee_table.employee_name
HAVING COUNT(employee_skill_table.skill_code) > 1;