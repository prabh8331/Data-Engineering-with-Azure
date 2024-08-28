# SQL: Class 2

## DDL (Data Definition Language) Commands

DDL commands are used to define or alter the structure of the database objects such as tables.

### 1. Creating and Using a Database
```sql
CREATE DATABASE class2_db;

USE class2_db;
```

### 2. Creating a Table
```sql
CREATE TABLE IF NOT EXISTS employee(
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

### 4. Adding a New Column to the Table
To add a new column named `DOB` to the `employee` table:
```sql
ALTER TABLE employee ADD DOB DATE;

SELECT * FROM employee;
```

### 5. Modifying an Existing Column
To modify the existing column `address` by changing its datatype or increasing the length:
```sql
ALTER TABLE employee MODIFY COLUMN address VARCHAR(100);

SHOW CREATE TABLE employee;
```

### 6. Deleting a Column from the Table
To remove the `city` column from the `employee` table:
```sql
ALTER TABLE employee DROP COLUMN city;

SELECT * FROM employee;
```

### 7. Renaming a Column
To rename the column `name` to `full_name`:
```sql
ALTER TABLE employee RENAME COLUMN name TO full_name;
```

## DDL Commands Impacting Table Structure

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



### 8. Truncating the Table
To remove all data from the `employee` table but retain the structure:
```sql
TRUNCATE TABLE employee;

SELECT * FROM employee;

SHOW CREATE TABLE employee;
```

### 9. Re-inserting Data into the Table
```sql
INSERT INTO employee VALUES(1, 'Shashank', 'Lucknow', '2012-02-02');

SELECT * FROM employee;
```

### 10. Deleting a Specific Row from the Table
To delete a specific row where `id = 1`:
```sql
DELETE FROM employee WHERE id=1;
```

### 11. Dropping the Table
To completely remove the `employee` table from the database:
```sql
DROP TABLE employee;

SELECT * FROM employee;
-- Error: Table 'class2_db.employee' doesn't exist
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







create table if not exists employee(
    id int,
    name VARCHAR(50),
    age int,
    hiring_date date,
    salary int,
    city varchar(50)
);

insert into employee values(1,'Shashank', 24, '2021-08-10', 10000, 'Lucknow');

insert into employee values(2,'Rahul', 25, '2021-08-10', 20000, 'Khajuraho');

insert into employee values(3,'Sunny', 22, '2021-08-11', 11000, 'Banaglore');

insert into employee values(5,'Amit', 25, '2021-08-11', 12000, 'Noida');

insert into employee values(6,'Puneet', 26, '2021-08-12', 50000, 'Gurgaon');

SELECT * from employee;

--- add unique integrity constraint on id COLUMN
alter table employee add constraint id_unique UNIQUE(id);

-- will not run
insert into employee values(1,'XYZ', 25, '2021-08-10', 50000, 'Gurgaon');

--- drop constraint from existing TABLE
alter table employee drop constraint id_unique;

-- now will run
insert into employee values(1,'XYZ', 25, '2021-08-10', 50000, 'Gurgaon');





--- create table with Primary_Key

Create table persons
(
    id int, 
    name varchar(50), 
    age int,
    -- Primary Key (id) 
    constraint pk Primary Key (id) 
);

insert into persons values(1,'Shashank',29);

--- Try to insert duplicate value for primary key COLUMN
insert into persons values(1,'Rahul',28);
-- Error: Duplicate entry '1' for key 'persons.PRIMARY'


--- Try to insert null value for primary key COLUMN
insert into persons values(null,'Rahul',28);
-- Error: Column 'id' cannot be null


--- To check difference between Primary Key and Unique
alter table persons add constraint age_unq UNIQUE(age); 

select * from persons;


insert into persons values(2,'Rahul',28);


insert into persons values(3,'Amit',28);

insert into persons values(3,'Amit',null);

select * from persons;

insert into persons values(4,'Charan',null);

insert into persons values(5,'Deepak',null);




--- create tables for Foreign Key demo
create table customer
(
    cust_id int,
    name VARCHAR(50), 
    age int,
    constraint pk Primary Key (cust_id) 
);

create table orders
(
    order_id int,
    order_num int,
    customer_id int,
    constraint pk Primary Key (order_id),
    constraint fk Foreign Key (customer_id) REFERENCES customer(cust_id)
);
-- this referential integrity will ensure the data consistiency 

insert into customer values(1,"Shashank",29);
insert into customer values(2,"Rahul",30);

select * from customer;

insert into orders values(1001, 20, 1);
insert into orders values(1002, 30, 2);
insert into orders values(1003, 30, 2);

select * from orders;

--- It will not allow to insert because referncial integrity will violate
insert into orders values(1004, 35, 5);
-- Error: Cannot add or update a child row: a foreign key constraint fails (class2_db.orders, CONSTRAINT fk FOREIGN KEY (customer_id) REFERENCES customer (cust_id))

--- Differen between Drop & Truncate Command

select * from persons;
truncate table persons;

select * from persons;
drop table persons;




