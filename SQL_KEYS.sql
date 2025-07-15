create database college_db;
use college_db;


CREATE TABLE Department (
    dept_id INT PRIMARY KEY,                -- Primary Key 
    dept_name VARCHAR(50) UNIQUE ,           -- Unique Key 
	dept_head VARCHAR(120)
);

CREATE TABLE Student (
    student_id INT AUTO_INCREMENT PRIMARY KEY,   -- Surrogate + Primary Key
    student_roll VARCHAR(20) UNIQUE,             -- Unique Key (Candidate Key)
    name VARCHAR(50),
    email VARCHAR(100) UNIQUE,                   -- Alternate Key (Candidate Key)
    dept_id INT,                                 -- Foreign Key
    FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);


SELECT * FROM Department;
INSERT INTO Department (dept_id, dept_name,dept_head) VALUES
(1, 'Computer Science','Ashok Kumar'),
(2, 'Electronics','Balchandra'),
(3, 'Mathematics','charan reddy'),
(4,'Data Science','Dharshan');

INSERT INTO Student (student_roll, name, email, dept_id) VALUES
('CS01', 'Alice', 'alice@example.com', 1),
('CS02', 'Bob', 'bob@example.com', 1),
('EL01', 'Charlie', 'charlie@example.com', 2),
('MA01', 'David', 'david@example.com', 3);



SELECT * FROM Student;

SELECT 
    s.student_id, s.student_roll, s.name, s.email,
    d.dept_name
FROM 
    Student s
JOIN 
    Department d ON s.dept_id = d.dept_id;
    
    -- find the dept head for the student name "David"
    select s.name,d.dept_head
    from Student as s 
    join Department as d
    on s.dept_id=d.dept_id
    where s.name="David";
    
    
    -- Retrieve all the students of computer science students
    
    Select s.name,d.dept_name
    from Student as s 
    join Department as d
    on s.dept_id=d.dept_id
    where s.dept_id=1;
    
    
    
    -- Retrieve all the students of computer science students
    
    Select s.*,d.dept_name
    from Student as s 
    join Department as d
    on s.dept_id=d.dept_id;
    
    
    -- count total students
    
    select count(*) from Student;
    
    -- count students per department
    select dept_id,count(*) as stud_couunt
    from Student
    group by dept_id;
    
       -- count students per department
    select d.dept_name,count(*) as stud_couunt
    from Student as s
    join Department as d
    on s.dept_id=d.dept_id
    group by s.dept_id;
    
    select * from Student  order by name ASC;
    
    select * from Student;
    
    
    -- ======================================================================================
						-- STORED PROCEDURE
	-- ======================================================================================
    
    CALL get_student_info();
    
 DELIMITER //


CREATE PROCEDURE get_student_cs_head()
BEGIN
    SELECT dept_head FROM Department where dept_name="computer science";
END;
//


CREATE PROCEDURE get_dept_name()
BEGIN
    SELECT DISTINCT dept_name FROM Department;
END;
//

DELIMITER ;
call get_student_cs_head(); 

call get_student_info1();

call get_department_info();

call get_students(1);


call AddStudent("CS003","ADVIK","aaa@gmail.com",1);


CALL GetStudentEmail('CS003', @email);
SELECT @email;



SET @roll = 'CS003';
CALL UpdateDept(@roll, 4);


-- Declare a variable to hold the OUT value
SET @total = 0;

-- Call the procedure
CALL GetTotalStudents(@total);

-- View the result
SELECT @total;

-- Declare a variable to hold the OUT value
SET @count = 0;

-- Call the procedure
CALL GetStudentCountByDept('Computer Science', @count);

-- Check the result
SELECT @count;

-- INOUT Example
SET @start = 10;
CALL count_students_inout(@start);
SELECT @start;  -- Will be 10 + number of students

-- ====================================================================================
--									Triggers
-- ====================================================================================

-- Convert dept_name to uppercase before insert

DELIMITER $$

CREATE TRIGGER before_department_insert
BEFORE INSERT ON Department
FOR EACH ROW
BEGIN
    SET NEW.dept_name = UPPER(NEW.dept_name);
END $$

DELIMITER ;

INSERT INTO Department (dept_id, dept_name,dept_head) VALUES
(6, 'electrical Engg','Santhosh Kumar');

INSERT INTO Department (dept_id, dept_name, dept_head)
VALUES (7, 'civil engineering', 'Dr. Ravi');

select * from department;

DELIMITER $$
CREATE TRIGGER before_student_insert
BEFORE INSERT ON Student
FOR EACH ROW
BEGIN
    IF NEW.email NOT LIKE '%@%.%' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid email format.';
    END IF;
END;
$$
DELIMITER ;
-- call AddStudent("CV001","chitra","chita",7);

CREATE TABLE StudentLog (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    student_roll VARCHAR(20),
    action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    action_type VARCHAR(10)
);

DELIMITER $$
CREATE TRIGGER after_student_insert
AFTER INSERT ON Student
FOR EACH ROW
BEGIN
    INSERT INTO StudentLog (student_roll, action_type)
    VALUES (NEW.student_roll, 'INSERT');
END;
$$ 

DELIMITER ;

call AddStudent("EV001","SMITHA","smitha@gmail.com",6);
select * from StudentLog;