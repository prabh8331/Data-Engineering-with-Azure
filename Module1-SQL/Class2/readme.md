
# SQL: Class 2

## DDL (Data Definition Language) Commands

DDL commands are used to define or alter the structure of database objects such as tables.

### 1. Creating and Using a Database
```sql
CREATE DATABASE class2_db;
USE class2_db;
```

### 2. Creating a Table
```sql
CREATE TABLE IF NOT EXISTS employee (
    id INT,
    name VARCHAR(50),
    address VARCHAR(50),
    city VARCHAR(50)
);
```

### 3. Inserting Data into the Table
```sql
INSERT INTO employee VALUES(1, 'Shashank', 'RJPM', 'Lucknow');
SELECT * FROM employee;
```

### 4. Modifying the Table Structure

- **Adding a New Column**
  ```sql
  ALTER TABLE employee ADD DOB DATE;
  ```

- **Modifying an Existing Column**
  ```sql
  ALTER TABLE employee MODIFY COLUMN address VARCHAR(100);
  ```

- **Deleting a Column**
  ```sql
  ALTER TABLE employee DROP COLUMN city;
  ```

- **Renaming a Column**
  ```sql
  ALTER TABLE employee RENAME COLUMN name TO full_name;
  ```

- **Invistagate Table**
```sql

SELECT * FROM employee;
SHOW CREATE TABLE employee;

```


### 5. Working with Constraints

- **Adding a Unique Constraint**
  ```sql
  ALTER TABLE employee ADD CONSTRAINT id_unique UNIQUE(id);

  -- this follwoing will not run as id =1 is there
  insert into employee values(1,'Rahul','RJPM' , 'Gurgaon');

  ```

- **Dropping a Unique Constraint**
  ```sql
  ALTER TABLE employee DROP CONSTRAINT id_unique;

  -- now this will run as constraint is removed
  insert into employee values(1,'Rahul','RJPM' , 'Gurgaon');
  ```

## DML (Data Manipulation Language) Commands

### 6. Inserting Data
```sql
INSERT INTO employee VALUES(1, 'Shashank', 'Lucknow', '2012-02-02');
```

### 7. Deleting Data

- **Deleting a Specific Row**

To delete a specific row where `id = 1`:
  ```sql
  DELETE FROM employee WHERE id=1;
  ```

- **Truncating a Table**
 
To remove all data from the `employee` table but retain the structure:
  ```sql
  TRUNCATE TABLE employee;
  ```

- **Dropping a Table**

To completely remove the `employee` table from the database:
  ```sql
  DROP TABLE employee;
  ```


### Differences Between `DROP`, `TRUNCATE`, and `DELETE`

| Feature | DROP | TRUNCATE | DELETE |
| --- | --- | --- | --- |
| **Purpose** | Removes the table and its structure from the database entirely. | Removes all rows from the table but retains the structure for future use. | Removes specific rows based on a condition (can remove all rows if no condition is given). |
| **Transaction Control** | Cannot be rolled back (except in some DBMS with special settings). | Cannot be rolled back. | Can be rolled back if used within a transaction. |
| **Space Reclaiming** | Releases space used by the table and its data. | Reclaims the space occupied by the data but not the table structure. | Typically does not reclaim space unless explicitly specified. |
| **Speed** | Fastest, as it simply deletes the table structure. | Faster than DELETE, as it does not generate individual row delete statements. | Slower, especially with large tables, as it generates individual row delete statements. |
| **Referential Integrity** | Fails if there are dependent foreign keys unless CASCADE is used. | Fails if there are dependent foreign keys. | Maintains referential integrity, respects foreign keys. |
| **WHERE Clause** | Not applicable. | Not applicable. | Applicable; allows selective deletion of rows. |
| **Command Type** | DDL | DDL | DML (Data Manipulation Language) |



## Primary Key and Foreign Key

### Primary Key

A primary key is a unique identifier for a record in a table, ensuring that each record can be uniquely identified.

- **Example of Creating a Table with a Primary Key**
  ```sql
  CREATE TABLE persons (
      id INT,
      name VARCHAR(50),
      age INT,
      CONSTRAINT pk PRIMARY KEY (id)
  );
  ```

- **Inserting Data into the Table**
  ```sql
  INSERT INTO persons VALUES(1, 'Shashank', 29);
  ```

- **Handling Errors with Primary Keys**
  - **Duplicate Entry Error**
    ```sql
    INSERT INTO persons VALUES(1, 'Rahul', 28);
    -- Error: Duplicate entry '1' for key 'persons.PRIMARY'
    ```
  - **Null Value Error**
    ```sql
    INSERT INTO persons VALUES(NULL, 'Rahul', 28);
    -- Error: Column 'id' cannot be null
    ```

### Unique Constraint

A unique constraint ensures that all values in a column are distinct.

- **Adding a Unique Constraint**
  ```sql
  ALTER TABLE persons ADD CONSTRAINT age_unq UNIQUE(age);
  ```

- **Testing the Unique Constraint**
  ```sql
  INSERT INTO persons VALUES(2, 'Rahul', 28);
  INSERT INTO persons VALUES(3, 'Amit', 28);  -- Error: Duplicate entry
  INSERT INTO persons VALUES(3, 'Amit', NULL);  -- Allows NULL values
  ```

### Foreign Key

A foreign key is a column in one table that references the primary key in another table, maintaining referential integrity.

- **Creating Tables with a Foreign Key**
  ```sql
  CREATE TABLE customer (
      cust_id INT,
      name VARCHAR(50),
      age INT,
      CONSTRAINT pk PRIMARY KEY (cust_id)
  );

  CREATE TABLE orders (
      order_id INT,
      order_num INT,
      customer_id INT,
      CONSTRAINT pk PRIMARY KEY (order_id),
      CONSTRAINT fk FOREIGN KEY (customer_id) REFERENCES customer(cust_id)
  );
  ```

- **Inserting Data with Referential Integrity**
  ```sql
  INSERT INTO customer VALUES(1, 'Shashank', 29);
  INSERT INTO customer VALUES(2, 'Rahul', 30);

  INSERT INTO orders VALUES(1001, 20, 1);
  INSERT INTO orders VALUES(1002, 30, 2);
  insert into orders values(1003, 30, 2);
  ```

- **Handling Foreign Key Violations**
  ```sql
  INSERT INTO orders VALUES(1004, 35, 5);
  -- Error: Cannot add or update a child row: a foreign key constraint fails
  -- It will not allow to insert because referncial integrity will violate

  drop table customer;
  -- this will not work as customer table is reference used in order table, 
  -- so first remove the reference using alter command then drop table 

  -- if try to delete some values from customer then that value should not be preseint in order to get deleted

  ```


## Primary key and Foreign key

### Primary Key

A primary key is a unique identifier for a record in a table. It ensures that each record can be uniquely identified.

- **Uniqueness:** Each primary key value must be unique for each row in the table.
- **Immutable:** Primary keys should not change once they are set.
- **Simplicity:** Ideally, primary keys should be as simple as possible, often a single column.
- **Non-Intelligent:** Primary keys should not contain meaningful information.
- **Indexed:** Primary keys are automatically indexed, making data retrieval faster.
- **Referential Integrity:** Primary keys are used in other tables as foreign keys to maintain referential integrity.
- **Data Type:** Common data types for primary keys are integers (`INT`) or strings (`VARCHAR`), though integers are preferred for efficiency.

### Foreign Key

A foreign key is a column (or set of columns) in one table that refers to the primary key in another table. It establishes and enforces a link between the data in the two tables.

- **Referential Integrity:** Foreign keys ensure that the values in one table correspond to valid entries in another table, maintaining data consistency.
- **Nullable:** Foreign keys can be set to `NULL` unless the database design restricts them.
- **Match Primary Keys:** Every value in a foreign key column must match a value in the primary key column of the referenced table or be `NULL`.
- **Ensure Relationships:** Foreign keys define the relationships between tables, making sure that related data stays consistent.
- **No Uniqueness:** Unlike primary keys, foreign keys do not need to be unique within their table.

### Example Relationship Between `Employee` and `Department` Tables

| **Table Name** | **Column Name** | **Data Type** | **Key Type**           | **Description**                                   |
|----------------|-----------------|---------------|------------------------|---------------------------------------------------|
| `Department`   | `id`            | `INT`         | Primary Key            | Unique identifier for each department.            |
|                | `name`          | `VARCHAR(50)` | -                      | Name of the department.                           |
| `Employee`     | `id`            | `INT`         | Primary Key            | Unique identifier for each employee.              |
|                | `name`          | `VARCHAR(50)` | -                      | Name of the employee.                             |
|                | `dep_id`        | `INT`         | Foreign Key (`Department.id`) | References the `id` column in the `Department` table. |

- In this example, the `id` column in the `Department` table is the **Primary Key**.
- The `id` column in the `Employee` table is also a **Primary Key** for the `Employee` table.
- The `dep_id` column in the `Employee` table is a **Foreign Key** that references the `id` column in the `Department` table, ensuring that each employee is linked to a valid department.


### Sample Data for `Department` Table

| **id** | **name**           |
|--------|--------------------|
| 1      | Human Resources    |
| 2      | IT                 |
| 3      | Marketing          |
| 4      | Finance            |

### Sample Data for `Employee` Table

| **id** | **name**    | **dep_id** | **DOB**       |
|--------|-------------|------------|---------------|
| 101    | Alice       | 1          | 1985-07-23    |
| 102    | Bob         | 2          | 1990-01-15    |
| 103    | Charlie     | 2          | 1988-03-12    |
| 104    | David       | 3          | 1992-11-30    |
| 105    | Eva         | 4          | 1986-05-09    |

### Explanation

- **Department Table**: Contains information about different departments within an organization.
  - Example: The `IT` department has an `id` of `2`.
  
- **Employee Table**: Contains information about employees, including which department they belong to.
  - Example: The employee named `Bob` has an `id` of `102` and works in the `IT` department, which corresponds to `dep_id` `2`.

- **Relationship**:
  - The `dep_id` in the `Employee` table is a **Foreign Key** that references the `id` in the `Department` table.
  - This relationship ensures that every `dep_id` in the `Employee` table matches an existing `id` in the `Department` table, maintaining referential integrity.

### Combined View

| **Employee ID** | **Employee Name** | **Department**     | **DOB**       |
|-----------------|-------------------|--------------------|---------------|
| 101             | Alice             | Human Resources    | 1985-07-23    |
| 102             | Bob               | IT                 | 1990-01-15    |
| 103             | Charlie           | IT                 | 1988-03-12    |
| 104             | David             | Marketing          | 1992-11-30    |
| 105             | Eva               | Finance            | 1986-05-09    |

In this combined view, the relationship between employees and their respective departments is clearly shown through the use of the foreign key `dep_id`.



## DQL (Data Query Language)

### Operations with `SELECT` Command

1. **Select Database and Table:**
   ```sql
   USE class2_db;
   SELECT * FROM employee;
   ```

2. **Drop and Create Table:**
   ```sql
   DROP TABLE IF EXISTS employee;

   CREATE TABLE employee (
       id INT,
       name VARCHAR(50),
       age INT,
       hiring_date DATE,
       salary INT,
       city VARCHAR(50)
   );
   ```

3. **Insert Data:**
   ```sql
   INSERT INTO employee VALUES
   (1, 'Shashank', 24, '2021-08-10', 10000, 'Lucknow'),
   (2, 'Rahul', 25, '2021-08-10', 20000, 'Khajuraho'),
   (3, 'Sunny', 22, '2021-08-11', 11000, 'Bangalore'),
   (5, 'Amit', 25, '2021-08-11', 12000, 'Noida'),
   (1, 'Puneet', 26, '2021-08-12', 50000, 'Gurgaon');
   ```

4. **Count Total Records:**
   ```sql
   SELECT COUNT(*) FROM employee;
   SELECT COUNT(1) FROM employee;  -- * or 1 is just a marker
   ```

5. **Alias Declaration:**
   ```sql
   SELECT COUNT(*) AS total_row_count FROM employee;
   ```

6. **Display Specific Columns:**
   ```sql
   SELECT name, salary FROM employee;
   ```

7. **Column Aliases:**
   ```sql
   SELECT name AS employee_name, salary AS employee_salary FROM employee;
   ```

8. **Unique Hiring Dates:**
   ```sql
   SELECT DISTINCT(hiring_date) AS distinct_hiring_dates FROM employee;
   ```

9. **Count Unique Age Values:**
   ```sql
   SELECT COUNT(DISTINCT(age)) AS total_unique_ages FROM employee;
   ```

10. **Increment Salary by 20%:**
    ```sql
    SELECT id, name, salary AS old_salary, (salary + salary * 0.2) AS new_salary FROM employee;
    ```

### Update Command

1. **Update All Rows:**
   ```sql
   UPDATE employee SET age = 20;
   ```

2. **Update Salary by 20%:**
   ```sql
   UPDATE employee SET salary = salary + salary * 0.2;
   ```

3. **Update Multiple Columns:**
   ```sql
   UPDATE employee SET salary = salary + salary * 0.2, age = 25;
   ```

### Filter Data Using `WHERE` Clauses

1. **Filter by Hiring Date:**
   ```sql
   SELECT * FROM employee WHERE hiring_date = '2021-08-10';
   ```

2. **Filter by Salary:**
   ```sql
   SELECT * FROM employee WHERE salary > 20000;
   ```

3. **Update Salary for Specific Date:**
   ```sql
   UPDATE employee SET salary = 80000 WHERE hiring_date = '2021-08-10';
   ```

### Delete Specific Records

1. **Delete by Hiring Date:**
   ```sql
   DELETE FROM employee WHERE hiring_date = '2021-08-10';
   ```

### Auto Increment

1. **Create Table with Auto Increment:**
   ```sql
   CREATE TABLE auto_inc_exmp (
       id INT AUTO_INCREMENT,
       name VARCHAR(20),
       PRIMARY KEY (id)
   );

   INSERT INTO auto_inc_exmp(name) VALUES('Shashank'), ('Rahul'), ('Nikhil');
   insert into auto_inc_exmp(id,name) values(5,'Amit');
   insert into auto_inc_exmp(name) values('Nihal');
   ```

### Use of `LIMIT`

1. **Limit Results:**
   ```sql
   SELECT * FROM employee LIMIT 2;
   ```

### Sorting Data with `ORDER BY`

1. **Ascending Order:**
   ```sql
   SELECT * FROM employee ORDER BY name;
   ```

2. **Descending Order:**
   ```sql
   SELECT * FROM employee ORDER BY name DESC;
   ```

3. **Multi-Level Sorting:**
   ```sql
   SELECT * FROM employee ORDER BY salary DESC, name ASC;
   ```

4. **Find Employee with Max/Min Salary:**
   ```sql
   SELECT * FROM employee ORDER BY salary DESC LIMIT 1;  -- Max salary
   SELECT * FROM employee ORDER BY salary ASC LIMIT 1;   -- Min salary
   ```

### Conditional and Logical Operators

1. **Filter by Salary Range:**
   ```sql
   SELECT * FROM employee WHERE salary > 20000;
   SELECT * FROM employee WHERE salary >= 20000;
   SELECT * FROM employee WHERE salary < 20000;
   SELECT * FROM employee WHERE salary <= 20000;
   ```

2. **Filter by Age:**
   ```sql
   SELECT * FROM employee WHERE age = 20;
   SELECT * FROM employee WHERE age != 20;  -- or use <>
   ```

3. **Filter by Date and Salary:**
   ```sql
   SELECT * FROM employee WHERE hiring_date = '2021-08-11' AND salary < 11500;
   SELECT * FROM employee WHERE hiring_date > '2021-08-11' OR salary < 20000;
   --  Short-circuiting in SQL occurs when the evaluation of logical conditions (`AND`, `OR`) stops as soon as the result is determined. In an `AND` operation, if any condition is `FALSE`, the rest are ignored since the entire expression will be `FALSE`. Similarly, in an `OR` operation, if any condition is `TRUE`, the remaining conditions are skipped as the whole expression will already be `TRUE`. This improves query efficiency by avoiding unnecessary condition checks.
   ```

### `BETWEEN` and `LIKE` Operations

1. **Filter by Date Range:**
   ```sql
   SELECT * FROM employee WHERE hiring_date BETWEEN '2021-08-05' AND '2021-08-11';
   ```

2. **Filter by Salary Range:**
   ```sql
   SELECT * FROM employee WHERE salary BETWEEN 10000 AND 28000;
   ```

3. **Using `LIKE` for Pattern Matching:**
   ```sql
   SELECT * FROM employee WHERE name LIKE 'S%';     -- Starts with 'S'
   SELECT * FROM employee WHERE name LIKE 'Sh%';    -- Starts with 'Sh'
   SELECT * FROM employee WHERE name LIKE '%l';     -- Ends with 'l'
   SELECT * FROM employee WHERE name LIKE 'S%k';    -- Starts with 'S' and ends with 'k'
   SELECT * FROM employee WHERE name LIKE '_____';  -- Exactly 5 characters
   SELECT * FROM employee WHERE name LIKE '%_____'; -- At least 5 characters can also use '_____%' or '%_____%'
   ```

### MySQL Functions

1. **Create a Table for Sales Data:**
   ```sql
   CREATE TABLE sales (
       sale_id INT AUTO_INCREMENT PRIMARY KEY,
       salesperson VARCHAR(100),
       product VARCHAR(100),
       quantity INT,
       price_per_unit DECIMAL(10, 2),
       sale_date DATE
   );

   INSERT INTO sales (salesperson, product, quantity, price_per_unit, sale_date) VALUES
   ('Alice', 'Laptop', 5, 1000.00, '2024-05-01'),
   ('Bob', 'Smartphone', 10, 600.00, '2024-05-02'),
   ('Alice', 'Tablet', 7, 300.00, '2024-05-03'),
   ('Charlie', 'Smartwatch', 6, 200.00, '2024-05-04'),
   ('Bob', 'Laptop', 3, 1000.00, '2024-05-05'),
   ('Alice', 'Smartphone', 8, 600.00, '2024-05-06');
   ```

2. **Create and Use a Function:**
   ```sql
   DELIMITER $$

   CREATE FUNCTION calculate_total_revenue(salesperson_name VARCHAR(100)) 
   RETURNS DECIMAL(10, 2)
   DETERMINISTIC
   BEGIN
       DECLARE total_revenue DECIMAL(10, 2);
       
       SELECT SUM(quantity * price_per_unit) INTO total_revenue
       FROM sales
       WHERE salesperson = salesperson_name;
       
       RETURN total_revenue;
   END $$

   DELIMITER ;

    -- The function `calculate_total_revenue` takes a `salesperson_name` parameter of type `VARCHAR(100)` and returns a `DECIMAL(10,2)`. 
    -- Inside the function, a `DECIMAL(10,2)` variable is created and assigned a value using the `INTO` keyword. 
    -- The function then returns this `total_revenue` value.

   
   SELECT DISTINCT salesperson, calculate_total_revenue(salesperson) AS total_revenue FROM sales;
   ```

  In SQL, DETERMINISTIC means the function always returns the same result for the same input, allowing the database to optimize performance by caching the result.

  **`NOT DETERMINISTIC`** means the function might return different results for the same input due to factors like random values or changing data. There is no explicit syntax to declare a function as `NOT DETERMINISTIC`; it is the default behavior if you don't specify `DETERMINISTIC`.