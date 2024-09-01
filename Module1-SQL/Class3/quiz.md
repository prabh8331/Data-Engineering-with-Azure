1. **Which of the following queries will return rows where the salary column is not NULL?**
   - **SELECT * FROM employees WHERE salary IS NOT NULL;**
   - This correctly returns rows where the `salary` column is not `NULL`.

2. **What will be the result of the following query?**
   - `SELECT COUNT(*) FROM employees WHERE salary IS NULL;`
   - **It counts the number of rows where salary is NULL.**
   - This query counts the rows with `NULL` in the `salary` column.

3. **Which of the following queries correctly uses the GROUP BY and HAVING clauses?**
   - `SELECT department_id, AVG(salary) FROM employees GROUP BY department_id HAVING AVG(salary) > 50000;`
   - **Correct usage of GROUP BY and HAVING**
   - The query correctly uses the `GROUP BY` and `HAVING` clauses.

4. **What does the following SQL statement do?**
   - `SELECT department_id, COUNT(*) FROM employees GROUP BY department_id HAVING COUNT(*) > 5;`
   - **It selects departments having more than 5 employees.**
   - The query groups employees by department and returns those with more than 5 employees.

5. **What is the purpose of the GROUP_CONCAT function in MySQL?**
   - **To concatenate column values into a single string.**
   - `GROUP_CONCAT` combines values from a group into a single string.

6. **Which of the following SQL statements correctly uses the ROLLUP operator?**
   - `SELECT department_id, year, SUM(salary) FROM employees GROUP BY department_id, year WITH ROLLUP;`
   - **Correct usage of ROLLUP**
   - The query correctly applies the `ROLLUP` operator for subtotals.

7. **Which of the following is a correct example of a subquery using IN?**
   - `SELECT employee_id, employee_name FROM employees WHERE department_id IN (SELECT department_id FROM departments WHERE department_name = 'HR');`
   - **Correct usage of IN**
   - This query correctly uses a subquery with `IN` to filter by department.

8. **Which of the following queries returns all employees who are not in departments with the name 'HR'?**
   - `SELECT employee_id, employee_name FROM employees WHERE department_id NOT IN (SELECT department_id FROM departments WHERE department_name = 'HR');`
   - **Correct usage of NOT IN**
   - This query correctly filters out employees in departments named 'HR'.

9. **Which of the following SQL statements correctly uses the CASE statement?**
   - `SELECT employee_id, salary, CASE WHEN salary > 70000 THEN 'High' WHEN salary BETWEEN 50000 AND 70000 THEN 'Medium' ELSE 'Low' END AS salary_range FROM employees;`
   - **Correct usage of CASE**
   - The query correctly uses the `CASE` statement to categorize salary ranges.

10. **What does the following CASE statement do in the query?**
    - `SELECT employee_id, CASE department_id WHEN 1 THEN 'HR' WHEN 2 THEN 'IT' ELSE 'Other' END AS department_name FROM employees;`
    - **It replaces the department ID with department names.**
    - The `CASE` statement substitutes department IDs with names.

11. **Which type of join returns all rows from the left table and the matched rows from the right table?**
    - **LEFT JOIN**
    - A `LEFT JOIN` returns all rows from the left table and matched rows from the right table.

12. **What does the following SQL statement do?**
    - `SELECT e.employee_id, e.employee_name, d.department_name FROM employees e JOIN departments d ON e.department_id = d.department_id;`
    - **It performs an INNER JOIN between employees and departments.**
    - This query correctly uses an `INNER JOIN`.

13. **Which SQL join type would you use to get all employees, including those who do not belong to any department?**
    - **LEFT JOIN**
    - A `LEFT JOIN` is needed to include all employees, even those without a department.

14. **What is the result of the following SQL statement if there are no matching rows in the departments table?**
    - `SELECT e.employee_id, e.employee_name, d.department_name FROM employees e LEFT JOIN departments d ON e.department_id = d.department_id;`
    - **All employees are returned, with NULL for department_name where there is no match.**
    - A `LEFT JOIN` returns all employees, with `NULL` for unmatched department names.

15. **Which join type combines rows from two tables and returns rows when there is a match in one of the tables?**
    - **FULL JOIN**
    - A `FULL JOIN` returns rows when there is a match in one of the tables (not the best wording in the quiz context, but FULL JOIN is the intended answer).