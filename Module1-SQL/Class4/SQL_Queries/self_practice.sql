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

