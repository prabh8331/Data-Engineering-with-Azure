--- Command to see the list of databases
Show databases;

--- Command Create database
create database noob_db;

--- Command to delete database
drop database first_demo;

--- Command to get inside a database
use noob_db;

--- Command to create a table
CREATE TABLE if not EXISTS employee
(
	id INT,
    emp_name VARCHAR(20)
);

--- Command to see the list of tables
show tables;

--- Command to see the table definition
show create table employee;

--- Create employee table with few more columns
CREATE TABLE if not EXISTS employee_v1
(
	id INT,
    name VARCHAR(50),
    salary DOUBLE, 
    hiring_date DATE 
);

--- Syntax 1 to insert data into a table
insert into employee_v1 values(1,'Shashank',1000,'2021-09-15');

--- This statement will fail
insert into employee_v1 values(1,'Shashank','2021-09-15');

--- Syntax 2 to insert data into a table
insert into employee_v1(salary,name,id) 
values(2000,'Rahul',2);

--- Command to insert multiple records into a table
insert into employee_v1 values(3,'Amit',5000,'2021-10-28'),
(4,'Nitin',3500,'2021-09-16'),
(5,'Kajal',4000,'2021-09-20');
    
--- How to query or fetch the data from a table
select * from employee_v1;

--- Example table for integrity constraints
CREATE TABLE if not EXISTS employee_with_constraints
(
	id INT,
    name VARCHAR(50) NOT NULL,
    salary DOUBLE, 
    hiring_date DATE DEFAULT '2021-01-01',
    UNIQUE (id),
    CHECK (salary > 1000)
);

--- Example 1 for IC failure
--- Exception - Column 'name' cannot be null
insert into employee_with_constraints values(1,null,3000,'2021-11-20');

--- Correct record
insert into employee_with_constraints values(1,'Shashank',3000,'2021-11-20');

--- Example 2 for IC failure
--- Exception - Duplicate entry '1' for key 'employee_with_constraints.id'
insert into employee_with_constraints values(1,'Rahul',5000,'2021-10-23');

--- Another correct record because Unique can accept NULL as well
insert into employee_with_constraints 
values(null,'Rahul',5000,'2021-10-23');

--- Example 3 for IC failure
--- Exception - Duplicate entry NULL for key 'employee_with_constraints.id'
insert into employee_with_constraints 
values(null,'Rajat',2000,'2020-09-20');


--- Example 4 for IC failure
--- Exception - Check constraint 'employee_with_constraints_chk_1' is violated
insert into employee_with_constraints 
values(5,'Amit',500,'2023-10-24');

--- Test IC for default date
insert into employee_with_constraints(id,name,salary)
values(7,'Neeraj',3000);

select * from employee_with_constraints;

--- Example table for integrity constraints
CREATE TABLE if not EXISTS employee_with_constraints_tmp
(
	id INT,
    name VARCHAR(50) NOT NULL,
    salary DOUBLE, 
    hiring_date DATE DEFAULT '2021-01-01',
    Constraint unique_emp_id UNIQUE (id),
    Constraint salary_check CHECK (salary > 1000)
);

--- Check the name of constraint when it fails
--- Exception - Check constraint 'salary_check' is violated
insert into employee_with_constraints_tmp 
values(5,'Amit',500,'2023-10-24');