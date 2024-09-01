-- Any Operation 


CREATE TABLE Students (
    StudentID INT,
    StudentName VARCHAR(50)
);

INSERT INTO Students VALUES 
(1, 'John'),
(2, 'Alice'),
(3, 'Bob');

CREATE TABLE Courses (
    CourseID INT,
    CourseName VARCHAR(50)
);

INSERT INTO Courses VALUES 
(100, 'Math'),
(101, 'English'),
(102, 'Science');

CREATE TABLE Enrollments (
    StudentID INT,
    CourseID INT
);

INSERT INTO Enrollments VALUES 
(1, 100),
(1, 101),
(2, 101),
(2, 102),
(3, 100),
(3, 102);


--Example: Lets find the students who are enrolled in any course taken by 'John':

Select Distinct s.StudentName
From Students s
INNER JOIN Enrollments e ON s.StudentID = e.StudentID
WHERE s.StudentName <> 'John' and e.CourseID = ANY (SELECT e2.CourseID
    FROM Enrollments e2
    INNER JOIN Students s2 ON e2.StudentID = s2.StudentID
    WHERE s2.StudentName = 'John');

--------------------------------------

-- All

CREATE TABLE Products (
    ProductID INT,
    ProductName VARCHAR(50),
    Price DECIMAL(5,2)
);

INSERT INTO Products VALUES 
(1, 'Apple', 1.20),
(2, 'Banana', 0.50),
(3, 'Cherry', 2.00),
(4, 'Date', 1.50),
(5, 'Elderberry', 3.00);


CREATE TABLE Orders (
    OrderID INT,
    ProductID INT,
    Quantity INT
);

INSERT INTO Orders VALUES 
(1001, 1, 10),
(1002, 2, 20),
(1003, 3, 30),
(1004, 1, 5),
(1005, 4, 25),
(1006, 5, 15);

--Now, suppose we want to find the products that have a price less than the price of all products ordered in order 1001:

SELECT p.ProductName
FROM Products p
WHERE p.Price < ALL (
    SELECT pr.Price
    FROM Products pr
    INNER JOIN Orders o ON pr.ProductID = o.ProductID
    WHERE o.OrderID = 1001
);


-------------------------

-- EXISTS Operation

CREATE TABLE Customers (
    CustomerID INT,
    CustomerName VARCHAR(50)
);

INSERT INTO Customers VALUES 
(1, 'John Doe'),
(2, 'Alice Smith'),
(3, 'Bob Johnson'),
(4, 'Charlie Brown'),
(5, 'David Williams');

CREATE TABLE Orders (
    OrderID INT,
    CustomerID INT,
    OrderDate DATE
);

INSERT INTO Orders VALUES 
(1001, 1, '2023-01-01'),
(1002, 2, '2023-02-01'),
(1003, 1, '2023-03-01'),
(1004, 3, '2023-04-01'),
(1005, 5, '2023-05-01');

Example: Lets find the customers who have placed at least one order.

SELECT c.CustomerName
FROM Customers c
WHERE EXISTS (
    SELECT 1
    FROM Orders o
    WHERE o.CustomerID = c.CustomerID
);

------------------------


-- NOT EXISTS Operation

Example: Lets find the customers who have not placed any orders.

SELECT c.CustomerName
FROM Customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM Orders o
    WHERE o.CustomerID = c.CustomerID
);

---------------------------



-- Window Functions
create table shop_sales_data
(
sales_date date,
shop_id varchar(5),
sales_amount int
);

insert into shop_sales_data values('2022-02-14','S1',200);
insert into shop_sales_data values('2022-02-15','S1',300);
insert into shop_sales_data values('2022-02-14','S2',600);
insert into shop_sales_data values('2022-02-15','S3',500);
insert into shop_sales_data values('2022-02-18','S1',400);
insert into shop_sales_data values('2022-02-17','S2',250);
insert into shop_sales_data values('2022-02-20','S3',300);

-- Total count of sales for each shop using window function
-- Working functions - SUM(), MIN(), MAX(), COUNT(), AVG()

-- If we only use Order by In Over Clause
select *,
       sum(sales_amount) over(order by sales_amount desc) as running_sum_of_sales
from shop_sales_data;

-- If we only use Partition By
select *,
       sum(sales_amount) over(partition by shop_id) as total_sum_of_sales
from shop_sales_data;

-- If we only use Partition By & Order By together
select *,
       sum(sales_amount) over(partition by shop_id order by sales_amount desc) as running_sum_of_sales
from shop_sales_data;

select *,
       sum(sales_amount) over(partition by shop_id order by sales_date desc) 
       as running_sum_of_sales,
       avg(sales_amount) over(partition by shop_id order by sales_date desc) 
       as running_avg_of_sales,
       max(sales_amount) over(partition by shop_id order by sales_date desc) 
       as running_max_of_sales,
       min(sales_amount) over(partition by shop_id order by sales_date desc) 
       as running_min_of_sales
from shop_sales_data;

create table amazon_sales_data
(
    sales_date date,
    sales_amount int
);

insert into amazon_sales_data values('2022-08-21',500);
insert into amazon_sales_data values('2022-08-22',600);
insert into amazon_sales_data values('2022-08-19',300);

insert into amazon_sales_data values('2022-08-18',200);

insert into amazon_sales_data values('2022-08-25',800);


-- Query - Calculate the date wise rolling average of amazon sales
select * from amazon_sales_data;

select *,
       avg(sales_amount) over(order by sales_date) as rolling_avg
from amazon_sales_data;

select *,
       avg(sales_amount) over(order by sales_date) as rolling_avg,
       sum(sales_amount) over(order by sales_date) as rolling_sum
from amazon_sales_data;

-- Rank(), Row_Number(), Dense_Rank() window functions

insert into shop_sales_data values('2022-02-19','S1',400);
insert into shop_sales_data values('2022-02-20','S1',400);
insert into shop_sales_data values('2022-02-22','S1',300);
insert into shop_sales_data values('2022-02-25','S1',200);
insert into shop_sales_data values('2022-02-15','S2',600);
insert into shop_sales_data values('2022-02-16','S2',600);
insert into shop_sales_data values('2022-02-16','S3',500);
insert into shop_sales_data values('2022-02-18','S3',500);
insert into shop_sales_data values('2022-02-19','S3',300);

select *,
       row_number() over(partition by shop_id order by sales_amount desc) as row_num,
       rank() over(partition by shop_id order by sales_amount desc) as rank_val,
       dense_rank() over(partition by shop_id order by sales_amount desc) as dense_rank_val
from shop_sales_data;


create table employees
(
    emp_id int,
    salary int,
    dept_name VARCHAR(30)

);

insert into employees values(1,10000,'Software');
insert into employees values(2,11000,'Software');
insert into employees values(3,11000,'Software');
insert into employees values(4,11000,'Software');
insert into employees values(5,15000,'Finance');
insert into employees values(6,15000,'Finance');
insert into employees values(7,15000,'IT');
insert into employees values(8,12000,'HR');
insert into employees values(9,12000,'HR');
insert into employees values(10,11000,'HR');


-- Query - get one employee from each department who is getting maximum salary (employee can be random if salary is same)

select 
    tmp.*
from (select *,
        row_number() over(partition by dept_name order by salary desc) as row_num
    from employees) tmp
where tmp.row_num = 1;

-- Query - get one employee from each department who is getting maximum salary (employee can be random if salary is same)

select 
    tmp.*
from (select *,
        row_number() over(partition by dept_name order by salary desc) as row_num
    from employees) tmp
where tmp.row_num = 1;

-- Query - get all employees from each department who are getting maximum salary
select 
    tmp.*
from (select *,
        rank() over(partition by dept_name order by salary desc) as rank_num
    from employees) tmp
where tmp.rank_num = 1;
  
-- Query - get all top 2 ranked employees from each department who are getting maximum salary
select 
    tmp.*
from (select *,
        dense_rank() over(partition by dept_name order by salary desc) as dense_rank_num
    from employees) tmp
where tmp.dense_rank_num <= 2;

-- Example for lag and lead
create table daily_sales
(
sales_date date,
sales_amount int
);


insert into daily_sales values('2022-03-11',400);
insert into daily_sales values('2022-03-12',500);
insert into daily_sales values('2022-03-13',300);
insert into daily_sales values('2022-03-14',600);
insert into daily_sales values('2022-03-15',500);
insert into daily_sales values('2022-03-16',200);

select * from daily_sales;

select *,
      lag(sales_amount, 1) over(order by sales_date) as pre_day_sales
from daily_sales;

-- we can use this to replace null with defualt value like 0
select *,
  coalesce(lag(sales_amount,1) over(order by sales_date), 0) as prev_sales
from daily_sales;

-- Query - Calculate the differnce of sales with previous day sales
-- Here null will be derived
select sales_date,
       sales_amount as curr_day_sales,
       lag(sales_amount, 1) over(order by sales_date) as prev_day_sales,
       sales_amount - lag(sales_amount, 1) over(order by sales_date) as sales_diff
from daily_sales;

-- Here we can replace null with 0
select sales_date,
       sales_amount as curr_day_sales,
       lag(sales_amount, 1, 0) over(order by sales_date) as prev_day_sales,
       sales_amount - lag(sales_amount, 1, 0) over(order by sales_date) as sales_diff
from daily_sales;

-- Diff between lead and lag
select *,
      lag(sales_amount, 1) over(order by sales_date) as pre_day_sales
from daily_sales;

select *,
      lead(sales_amount, 1) over(order by sales_date) as next_day_sales
from daily_sales;

create table employees(
  emp_id int,
  emp_name varchar(50),
  mobile BIGINT,
  dept_name varchar(50),
  salary int 
);

insert into employees values(1,'Shashank',778768768,'Software',1000);
insert into employees values(2,'Rahul',876778877,'IT',2000);
insert into employees values(3,'Amit',098798998,'HR',5000);

insert into employees values(4,'Nikhil',67766767,'IT',3000);

select * from employees;


-- How to use Frame Clause - Rows BETWEEN
select * from daily_sales;

select *,
      sum(sales_amount) over(order by sales_date rows between 1 preceding and 1 following) as prev_plus_next_sales_sum
from daily_sales;

select *,
      sum(sales_amount) over(order by sales_date rows between 1 preceding and current row) as prev_plus_next_sales_sum
from daily_sales;

select *,
      sum(sales_amount) over(order by sales_date rows between current row and 1 following) as prev_plus_next_sales_sum
from daily_sales;

select *,
      sum(sales_amount) over(order by sales_date rows between 2 preceding and 1 following) as prev_plus_next_sales_sum
from daily_sales;

select *,
      sum(sales_amount) over(order by sales_date rows between unbounded preceding and current row) as prev_plus_next_sales_sum
from daily_sales;

select *,
      sum(sales_amount) over(order by sales_date rows between current row and unbounded following) as prev_plus_next_sales_sum
from daily_sales;

select *,
      sum(sales_amount) over(order by sales_date rows between unbounded preceding and unbounded following) as prev_plus_next_sales_sum
from daily_sales;

-- Alternate way to esclude computation of current row
select *,
      sum(sales_amount) over(order by sales_date rows between unbounded preceding and unbounded following) - sales_amount as prev_plus_next_sales_sum
from daily_sales;

-- How to work with Range Between

select *,
      sum(sales_amount) over(order by sales_amount range between 100 preceding and 200 following) as prev_plus_next_sales_sum
from daily_sales;

-- Calculate the running sum for a week
insert into daily_sales values('2022-03-20',900);
insert into daily_sales values('2022-03-23',200);
insert into daily_sales values('2022-03-25',300);
insert into daily_sales values('2022-03-29',250);


select * from daily_sales;

select *,
       sum(sales_amount) over(order by sales_date range between interval '6' day preceding and current row) as running_weekly_sum
from daily_sales;


--- Common table expression

create table amazon_employees(
    emp_id int,
    emp_name varchar(20),
    dept_id int,
    salary int

 );

 insert into amazon_employees values(1,'Shashank', 100, 10000);
 insert into amazon_employees values(2,'Rahul', 100, 20000);
 insert into amazon_employees values(3,'Amit', 101, 15000);
 insert into amazon_employees values(4,'Mohit', 101, 17000);
 insert into amazon_employees values(5,'Nikhil', 102, 30000);

 create table department
 (
    dept_id int,
    dept_name varchar(20) 
  );

  insert into department values(100, 'Software');
    insert into department values(101, 'HR');
      insert into department values(102, 'IT');
        insert into department values(103, 'Finance');

--- Write a query to print the name of department along with the total salary paid in each department
--- Normal approach
select d.dept_name, tmp.total_salary
from (select dept_id , sum(salary) as total_salary from amazon_employees group by dept_id) tmp
inner join department d on tmp.dept_id = d.dept_id;

--- how to do it using with clause??
with dept_wise_salary as (select dept_id , sum(salary) as total_salary from amazon_employees group by dept_id)

select d.dept_name, tmp.total_salary
from dept_wise_salary tmp
inner join department d on tmp.dept_id = d.dept_id;

with dept_wise_salary as (select dept_id , sum(salary) as total_salary from amazon_employees group by dept_id), 
dept_wise_max_salary as (select dept_id , max(salary) as max_salary from amazon_employees group by dept_id)

select * from dept_wise_max_salary;

select * from dept_wise_salary;


--- Write a Query to generate numbers from 1 to 10 in SQL

with recursive generate_numbers as   
(
  select 1 as n
  union 
  select n+1 from generate_numbers where n<10
) 

select * from generate_numbers;


create table emp_mgr
(
id int,
name varchar(50),
manager_id int,
designation varchar(50),
primary key (id)
);


insert into emp_mgr values(1,'Shripath',null,'CEO');
insert into emp_mgr values(2,'Satya',5,'SDE');
insert into emp_mgr values(3,'Jia',5,'DA');
insert into emp_mgr values(4,'David',5,'DS');
insert into emp_mgr values(5,'Michael',7,'Manager');
insert into emp_mgr values(6,'Arvind',7,'Architect');
insert into emp_mgr values(7,'Asha',1,'CTO');
insert into emp_mgr values(8,'Maryam',1,'Manager');


select * from emp_mgr;

--- for our CTO 'Asha', present her org chart

with recursive emp_hir as  
(
   select id, name, manager_id, designation from emp_mgr where name='Asha'
   UNION
   select em.id, em.name, em.manager_id, em.designation from emp_hir eh inner join emp_mgr em on eh.id = em.manager_id
)

select * from emp_hir;

--- Print level of employees as well
with recursive emp_hir as  
(
   select id, name, manager_id, designation, 1 as lvl from emp_mgr where name='Asha'
   UNION
   select em.id, em.name, em.manager_id, em.designation, eh.lvl + 1 as lvl from emp_hir eh inner join emp_mgr em on eh.id = em.manager_id
)

select * from emp_hir;

--- Create views in SQL
create view employee_data_for_finance as select emp_id, emp_name,salary from employees;

select * from employee_data_for_finance;

--- Create logic for department wise salary sum
create view department_wise_salary as select dept_name, sum(salary) from employees group by dept_name;

drop view department_wise_salary;

create view department_wise_salary as select dept_name, sum(salary) as total_salary from employees group by dept_name;

--- Creat indexing
CREATE INDEX idx_order_id ON orders(order_id);

