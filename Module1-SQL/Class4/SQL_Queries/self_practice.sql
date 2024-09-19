--Example: Lets find the students who are enrolled in any course taken by 'John':

-- Part 1: identify courses taken by John (subquery part)
select distinct courseid 
from Enrollments e
LEFT join Students s
on e.studentid = s.studentid
where studentname = "John"
;

-- Part2: writing the outer part
select DISTINCT studentname
from Enrollments e
Left join Students s
on e.studentid = s.studentid
where courseid in
 (select distinct courseid 
from Enrollments e
LEFT join Students s
on e.studentid = s.studentid
where studentname = "John") 
and studentname <> "John"
;

-- acheivng same using any
select DISTINCT studentname
from Enrollments e
Left join Students s
on e.studentid = s.studentid
where courseid = any
 (select distinct courseid 
from Enrollments e
LEFT join Students s
on e.studentid = s.studentid
where studentname = "John") 
and studentname <> "John"
;


--Now, suppose we want to find the products that have a price less than the price of all products ordered in order 1001:

select Productname from Products
where 
price < ALL (select p.price 
from Orders o
left join Products p
on o.productid = p.productid
where orderid=1001);


-- ALL is like the and conditons and ANY is like or condition



-- drop table Orders;



-- Example: Lets find the customers who have placed at least one order. 

select customername from Customers
where customerid in (select DISTINCT customerid from Orders)
;

-- using exist, when wver problem talk about only existance like at least 1 etc. then Exists is very optimized query
select c.customername 
from Customers c   -- from this table 
where 
EXISTS (  -- any record in above outer query exist in bellow subquery 
    select 1 
    from Orders o 
    where o.customerid = c.customerid  -- which satisfiy this condition
    )

;


-- Example: Lets find the customers who have not placed any orders. 

select c.customername 
from Customers c   -- from this table 
where 
NOT EXISTS (  -- any record in above outer query exist in bellow subquery 
    select 1 
    from Orders o 
    where o.customerid = c.customerid  -- which satisfiy this condition
    )

;

select * from shop_sales_data;

-- Windows funciton

-- If we only use Order by In Over Clause

-- find running sum of sales
select *, sum(sales_amount) over (
        order by sales_amount desc
    ) as running_sum_of_sales
from shop_sales_data;


select *, sum(sales_amount) over (
        order by shop_id desc
    ) as running_sum_of_sales
from shop_sales_data;


select *, max(sales_amount) over (
        order by shop_id desc
    ) as running_sum_of_sales
from shop_sales_data;

-- when partation is not mentioned then according to order by column it will start from first window and give the output as per this window only then it will go in second window but now first and second both windows will be considered and out put will be as per the whole 2 window data
-- so in if we take min() it will give min() of first window only, then it will give min() of first and second window togeter


--  if we only use partition by


select *, sum(sales_amount) over (
        partition by
            shop_id
    ) as total_sum_of_sales
from shop_sales_data;

-- when only partition by is used then it will poputalte the individual windows this the aggregated value and it will be repating of each value in that window


-- If we only use Partition By & Order By together
select *, sum(sales_amount) over (
        partition by
            shop_id
        order by sales_amount desc
    ) as running_sum_of_sales
from shop_sales_data;

-- inside each window (partition by) the runing sum will happen as per the order by column



-- Query - Calculate the date wise rolling average of amazon sales
select * 
, avg(sales_amount) over(ORDER BY sales_date) running_sales
from amazon_sales_data;


-- row_number, rank, dense_rank
-- row_number - assigns a unique row number to each row, ranking start from 1 and keep increasing till the end
-- rank - assign a rank to each row, rows with equal values receive the same rank, with the new row receinge a rank wiht skips the duplicate rankings
-- dense_rank() - simiral to rank but does not skip the ranking

select * from employees;
drop table employees;


-- Query - get one employee from each department who is getting maximum salary (employee can be random if salary is same)

select * from (select * 
, ROW_NUMBER() OVER(PARTITION BY dept_name ORDER BY salary DESC) rownum_sal
from employees) a
where rownum_sal=1
;

select * from (SELECT *
,DENSE_RANK() OVER(PARTITION BY dept_name ORDER BY salary desc) drank_sal
from employees) temp
where drank_sal=1

;




-- Lead and  lag

