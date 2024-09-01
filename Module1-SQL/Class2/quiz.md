### 1. What does the SQL `UPDATE` command do?
**Answer:** Changes existing records in a table.

### 2. Which command removes all rows from a table without deleting the table?
**Answer:** `TRUNCATE`

### 3. What is the role of the `WHERE` clause in an SQL statement?
**Answer:** Filters the results.

### 4. Which SQL keyword is used with the `WHERE` clause to include conditions?
**Answer:** `AND/OR`

### 5. What does the `GROUP BY` statement do in SQL?
**Answer:** Groups rows with the same values in specified columns.

### 6. Which SQL command is used to combine rows from two or more tables?
**Answer:** `JOIN`

### 7. What does the `CASE` statement do in SQL?
**Answer:** Adds a condition to a query.

### 8. What does the `DROP` command do in SQL?
**Answer:** Drops a table or a database.

### 9. What is the purpose of the `TRUNCATE` command in SQL?
**Answer:** Removes all records from a table and resets spaces allocated for the records.

### 10. What does the `DELETE` command do in SQL?
**Answer:** Deletes specific rows in a table.

### 11. Which SQL command is used to modify an existing column in a table?
**Answer:** `ALTER`

### 12. The SQL `JOIN` clause is used to combine records from two or more tables in a database. A `FULL JOIN` returns only the set of all records in both tables which do not have matching values.
**Answer:** False

### 13. What is the difference between the SQL commands `DROP`, `DELETE`, and `TRUNCATE`?
**Answer:** `DROP` and `TRUNCATE` are DDL commands, whereas `DELETE` is a DML command.

### 14. What will be the output of the SQL statement: `"SELECT COUNT(*) FROM Employees WHERE Salary > 50000"`?
**Answer:** It will return the number of employees who earn more than 50000.

### 15. Which type of SQL `JOIN` returns all the rows from the left table and the matched rows from the right table? If no match is found, the result is NULL on the right side.
**Answer:** `LEFT JOIN`

### 16. How can you change the `"EmployeeName"` column datatype to `VARCHAR(50)` in an `"Employees"` table?
**Answer:** `ALTER TABLE Employees MODIFY EmployeeName VARCHAR(50);`

### 17. Which statement would you use to remove the `"EmployeeName"` column from the `"Employees"` table?
**Answer:** `ALTER TABLE Employees DROP COLUMN EmployeeName;`

### 18. Which of the following SQL statements is correct to update `"EmployeeName"` to `'John'` where `"EmployeeID"` is 3 in the `"Employees"` table?
**Answer:** `UPDATE Employees SET EmployeeName='John' WHERE EmployeeID=3;`

### 19. Which SQL function can be used to count the number of rows in a `GROUP BY` clause?
**Answer:** `COUNT()`

### 20. What will the SQL query `"DELETE FROM Employees WHERE EmployeeID=3"` do?
**Answer:** Deletes the row where `"EmployeeID"` is 3 in the `"Employees"` table.

### 21. The `UPDATE` command can be used with a `JOIN`.
**Answer:** True

### 22. A `CASE` statement within a `SELECT` statement can change the display of data depending on certain conditions.
**Answer:** True

### 23. What will the SQL query `"SELECT COUNT(*) FROM Employees GROUP BY Salary"` do?
**Answer:** Returns the number of employees for each distinct salary.

### 24. What is the correct syntax for a `LEFT JOIN` in SQL?
**Answer:** `SELECT * FROM table1 LEFT JOIN table2 ON table1.match = table2.match;`

### 25. If you want to display the salaries of employees who earn more than 50000, which `WHERE` clause would you use?
**Answer:** `WHERE Salary > 50000`

### 26. What is the use of the SQL `GROUP BY` statement?
**Answer:** Groups records with the same values in columns.

### 27. The `DROP` command permanently removes a table from the database along with all the data stored in it.
**Answer:** True

### 28. What does the SQL `TRUNCATE` command do?
**Answer:** Deletes all records in a table and resets the table's auto-increment value to zero.

### 29. If you have two tables, `"Orders"` and `"Customers"`, where `"Orders"` has a foreign key to `"Customers"`, which SQL join will give you only the orders that have a corresponding customer?
**Answer:** `INNER JOIN`

### 30. In SQL, the `CASE` statement is used for:
**Answer:** Implementing if-then-else logic.