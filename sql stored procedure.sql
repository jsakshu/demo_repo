


DELIMITER //

CREATE PROCEDURE get_student_info1()
BEGIN
    SELECT * FROM Student;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE get_department_info()
BEGIN
    SELECT * FROM Department;
END //

DELIMITER ;


DELIMITER //

CREATE PROCEDURE get_students(IN depid int)
BEGIN
	Select s.name,d.dept_name
    from Student as s 
    join Department as d
    on s.dept_id=d.dept_id
    where s.dept_id=depid;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE AddStudent (
    IN p_Roll VARCHAR(10),
    IN p_Name VARCHAR(100),
    IN p_Email VARCHAR(100),
    IN p_DeptId INT
)
BEGIN
    INSERT INTO Student (student_roll, name, email, dept_id)
    VALUES (p_Roll, p_Name, p_Email, p_DeptId);
END //

DELIMITER ;


DELIMITER //

CREATE PROCEDURE GetStudentEmail (
    IN roll VARCHAR(10),
    OUT student_email VARCHAR(100)
)
BEGIN
    SELECT email INTO student_email
    FROM Student
    WHERE student_roll = roll;
END //

DELIMITER ;






