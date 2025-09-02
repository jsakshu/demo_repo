-- create employee database

create database employee;

 -- How to see all the available databases
 show databases;
 
 
-- How to select database/ switch to employee database
 use employee;
 
 -- create employee_data table with emp_id,emp_name, emp_age,emp_salary,join_date,emp_job
 create table employee_data
 (emp_id int,
 emp_name varchar(20),
 emp_age int,
 emp_salary int,
 join_date date,
 emp_job varchar(25));
 
 -- see all the available tables in employee
 show tables;
 
 -- how to see structure of table
 desc employee_data;
 
 -- How to view table
 select * from employee_data;
 
 -- How to delete a table;
  -- How to delete a table;
drop table employee_data;
show databases;
show tables;

-- delete database
drop database employee;

drop database datamites_emp;
-- Create a new table with the constraints
create database datamites_emp;

use datamites_emp;

-- create employee_information table
 create table employee_information
(emp_id varchar(10) primary key,
emp_name varchar(20) not null,
emp_job varchar(25) not null,
emp_salary int default 20000,
join_date date,
emp_age int check (emp_age>20));

desc employee_information;

-- insert single record into a table
insert into employee_information values
("ES0001","Pooja","HR",40000,"2023-02-24",30);
select * from employee_information;

insert into employee_information values
("ES0002","Mary","Manager",50000,"2022-04-23",40),
("ES0003","John","Analyst",70000,"2022-06-20",27),
("ES0004","Ridaa","Engineer",65000,"2021-12-11",30);

select * from employee_information;

insert into employee_information(emp_id,emp_name,emp_job,emp_salary) values
("ES0009","Jeevitha","DataScientist",80000);

select * from employee_information;

insert into employee_information(emp_id,emp_name,emp_job) values
("ES0008","Smitha","Professor");

insert into employee_information values
("ES0010","Paul","HR",50000,"2023-02-24",22);
select * from employee_information;

-- error for age<20
insert into employee_information values
("ES0011","amit","admin",50000,"2023-02-24",17);

-- ===================================================
--           update the table
-- ===================================================
-- change employee salary and employee age to 80000 and 35 of first record.

select * from employee_information;
update employee_information set emp_salary =80000, emp_age=35 where emp_id="ES0001";
select * from employee_information;
-- change job of Ridaa to to SalesManager.
update employee_information set emp_job="SalesManager" where emp_id="ES0004";
select * from employee_information;
-- update age of Smitha and Jeevitha to 30
update employee_information set emp_age=40 where emp_id="ES0008" or emp_id="ES0009";
-- NOTE;for updating mutliple we use OR condition.
select * from employee_information;
-- DELETE
-- delete information related to Jeevitha
SET SQL_SAFE_UPDATES = 0; 
delete from employee_information where emp_name="Jeevitha";
 

-- delete record related to Smitha.
delete from employee_information where emp_name="Smitha"; 

select * from employee_information;
-- delete record related to Mary and John
delete from employee_information where emp_name="Mary" or emp_name="John";

-- ===================================================
--           alter the table
-- ===================================================
show databases;
use datamites_emp;
select * from employee_information;
-- alter and add is used to create new column

-- add new field emp_expeience
alter table employee_information add emp_experience int unique;
select * from employee_information;

-- create new fields like Class1 and Class2
alter table employee_information add Class1 Varchar(10), add class2 date;
select * from employee_information;


-- updating values
update employee_information set Class1="Python",Class2="2023-03-23";
select * from employee_information;
SET SQL_SAFE_UPDATES = 0;
update employee_information set emp_experience=4 where emp_id="ES0001";
select * from employee_information;

-- DROP
-- delete emp_experience
alter table employee_information drop column emp_experience; 
select * from employee_information;

-- Delete Class1 and Class2 fields
alter table employee_information drop column Class1, drop class2;
select * from employee_information;

-- ===================================================
--           modify the table
-- ===================================================

-- How to see structure of table.
desc employee_information;
select * from employee_information;

-- change data type of emp_name to varchar(100)
alter table employee_information modify emp_name varchar(100);
desc employee_information;
-- change data type of salary int(whole numbers) to numeric(including decimal points)
alter table employee_information modify emp_salary numeric;
desc employee_information;
select * from employee_information;
-- change emp_name to name_of_employee
alter table employee_information change column emp_name  name_of_employee varchar(120);
select * from employee_information;

-- change employee_information name employee_data1
alter table employee_information rename to employee_detail;

select * from employee_detail;

-- Renaming to original name
alter table employee_detail rename to employee_information;


-- ===================================================
--           joins the table
-- ===================================================


-- Create database joins

create database joins;

use joins;
create table employee
(empid varchar(10) unique , empname varchar(20) , salary int , deptid varchar(10) primary key );
insert into employee values
('E1' ,'John' , 450000 , 'D1') ,
('E2' ,'Mary',73000,'D2'),
('E3' ,'Steve',86000,'D3'),
('E4' ,'Helen',60000,'D4'),
('E5','Joe',35000,'D7');


select * from employee;

-- Create department table
create table department 
(deptid varchar(10) primary key , deptname varchar(10),dept_head varchar(50) );
insert into department values
('D1','HR',"joyal"),
('D2','Admin',"jayant"),
('D3','Sales',"radha"),
('D4','IT',"roshan"),
('D5','HR',"samule");
select * from department;
select * from employee;

-- INNER JOIN: Returns records that have matching values in both tables
-- LEFT JOIN: Returns all records from the left table, and the matched records from the right table
-- RIGHT JOIN: Returns all records from the right table, and the matched records from the left table
-- CROSS JOIN: Returns all records from both tables



select * from employee;
select * from department;
-- inner join 
-- only matching rows
select e.empid,e.empname,e.salary,d.deptid,d.deptname 
from employee as e 
inner join department as d
on e.deptid=d.deptid;


-- left join
select e.empid,e.empname,e.salary,e.deptid,d.deptid,deptname 
from employee as e
left join 
department as d 
on e.deptid=d.deptid;


-- right join
select e.empid,e.empname,e.salary,e.deptid,d.deptname,d.dept_head from employee as e right join department as d on e.deptid=d.deptid;



-- full outer join
select e.empid,e.empname,e.salary,e.deptid,d.deptname 
from employee as e 
left join department as d 
on e.deptid=d.deptid
union
select e.empid,e.empname,e.salary,e.deptid,d.deptname
from employee as e 
right join department as d 
on e.deptid=d.deptid;


-- if where clause in cross join it is same as inner join
select e.empid,e.empname,e.salary,e.deptid,d.deptname,d.dept_head 
from employee as e 
cross join department 
as d on e.deptid=d.deptid;

-- cross join
select e.empid,e.empname,e.salary,e.deptid,d.deptname,d.dept_head 
from employee as e cross join department as d ;

-- =====================================================================
create database employee_query;
use employee_query;

create table employee 
(emp_id int primary key ,emp_name varchar(30) , dept_name varchar(20) , emp_salary int );
insert into employee values
(101 , 'John', 'HR' , 10000),
(201,'Mary','Finance',20000),
(301,'Zara','IT',30000),
(401,'Rida','Sales',50000),
(501, 'Ram','HR',40000),
(601,'Varun','IT',70000),
(701,'Araav','HR',60000),
(801,'Joy','IT',90000),
(302,'Arun','Sales',40000),
(403,'Joe','Finance',35000),
(704,"Dia","Finance",26000);


select * from employee;

select distinct(dept_name) from employee;

-- agreegate function-max(),min(),avg(),count(),sum()
select max(emp_salary) from employee;
select max(emp_salary),min(emp_salary),avg(emp_salary),count(dept_name),sum(emp_salary) from employee;

select emp_name,emp_salary from employee where emp_salary<40000;

select emp_name,dept_name,emp_salary
from employee 
where emp_salary=40000 and dept_name="Sales";


-- Find the details of an employee who's getting maximum salary.
select * 
from employee
where emp_salary=(select max(emp_salary) from employee);

-- Find details of employee who's getting minimum salary
select * from employee where emp_salary=(select min(emp_salary) from employee);

-- Write a SQL query to display details of an employee who's salary greater than avg_salary
select * 
from employee
where emp_salary>(select avg(emp_salary) from employee);





-- Write a SQL query to display details of an employee who's salary greater than avg_salary
select * 
from employee where emp_salary>(select avg(emp_salary) from employee) order by emp_salary desc;


-- Write a sql query to display the details of an employee who's taking salary greater than employee with an ID 701.
select emp_salary from employee where emp_id=701;

select * 
from employee 
where emp_salary > (select emp_salary from employee where emp_id=701);

select * from employee;
select count(emp_name),dept_name 
from employee 
group by 
dept_name;
-- write a sql query to find the details of an employee who's getting highest salary in each department

select  max(emp_salary),dept_name from employee group by dept_name;
select * from employee where emp_salary in (select max(emp_salary) from employee group by dept_name);

-- Find departments which has number of employees greater than 2

select dept_name
from employee 
group by dept_name having count(*)=2;

select * from employee;




-- Find the second highest salary from the employee table
select max(emp_salary) from employee where emp_salary < (select max(emp_salary) from employee);
select emp_salary from employee where emp_salary < (select max(emp_salary) from employee) 
order by emp_salary 
desc limit 1;