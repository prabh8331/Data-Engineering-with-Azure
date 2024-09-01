
# SQL: Structured Query Language

## Importance of SQL in Data Engineering

As a data engineer, SQL is a core skill for working with various types of databases. Understanding how to choose and work with different databases, as well as their scalability aspects, is crucial.

### What is a Database?

A database is a collection of data stored in a structured form. It allows for efficient storage, retrieval, and manipulation of data.

### Types of Databases

1. **Transactional Databases** (RDBMS - Relational Database Management Systems)
    - **Examples**: MySQL, PostgreSQL, Oracle, MSSQL
    - **Characteristics**:
        - Vertically scalable (increasing the capacity of a single machine)
        - ACID properties (Atomicity, Consistency, Isolation, Durability)
        - Best for use cases where data consistency is critical, such as banking systems
        - Optimized for fast read/write operations
        - Typically not suited for complex analytical queries due to row-based storage format

2. **NoSQL Databases** (Non-Relational Database Management Systems)
    - **Examples**: MongoDB, Cassandra, ElasticSearch, ScyllaDB, Neo4j
    - **Characteristics**:
        - Horizontally scalable (adding more machines to increase capacity)
        - Distributed systems with parallel computing capabilities
        - Used for handling large clusters and big data workloads
        - Best for scenarios where flexibility and scalability are prioritized over strict consistency

### CAP Theorem

The CAP Theorem helps in deciding which type of database is suitable for a given architecture (choosing a database often involves trade-offs based). It states that a distributed database can only guarantee two out of three properties:
- **Consistency**: Every read receives the most recent write or an error.
- **Availability**: Every request receives a response (without a guarantee that it contains the most recent data).
- **Partition Tolerance**: The system continues to operate despite network partitions.

### Understanding Transactional Databases

#### ACID Properties

1. **Atomicity**:
    - Each transaction is treated as a single unit, which either completely succeeds or fails.
    - Example: Transferring money between two bank accounts involves multiple steps (e.g., deducting from one account and adding to another). If any step fails, all changes are rolled back, ensuring consistency.

2. **Consistency**:
    - Ensures that a transaction brings the database from one valid state to another, maintaining the integrity of the data.
    - Example: In the bank transfer scenario, if a failure occurs after deducting money but before adding it to the other account, the transaction is rolled back to the original state.

3. **Isolation**:
    - Transactions are executed in isolation from one another, ensuring that concurrent transactions do not interfere.
    - Example: If two transactions are modifying the same account balance simultaneously, one will lock the data until it completes, preventing inconsistent results.

Locking Mechanisms and Concurrent Operations
Locking ensures that multiple transactions can safely access or modify the same data without conflicts.

Types of Locks:

Shared Lock (Read Lock): Allows multiple transactions to read the same data simultaneously.
Exclusive Lock (Write Lock): Only one transaction can modify the data, blocking others from reading or writing until the lock is released.
Concurrent Operations: If two transactions (T1 and T2) need the same data, T2 must wait if T1 holds an exclusive lock. Once T1 commits and releases the lock, T2 can proceed.

Deadlocks: Occur when two transactions each hold a lock the other needs, causing both to wait indefinitely. Databases detect and resolve deadlocks by rolling back one of the transactions.

Lock Granularity:

Row-Level Locking: Locks individual rows, allowing more concurrent operations.
Table-Level Locking: Locks the entire table, preventing access by other transactions, which is less flexible.


TODO: see how concurancy control happens

4. **Durability**:
    - Once a transaction is committed, the changes are permanent, even in the event of a system crash.
    - Changes are often stored in a Write-Ahead Log (WAL), ensuring recovery in case of a failure before final changes are written.
    
    - **WAL (Write-Ahead Log)**: WAL is a fundamental concept in ensuring durability and consistency in databases by logging changes before they are committed.

WAL (Write-Ahead Logging) and Its Role in Temporary Changes and Volatile Memory
Write-Ahead Logging (WAL) is a method used by databases to maintain data integrity. Before making any changes to the database, these changes are first logged in a separate file (the WAL). This ensures that even if a system crashes during a transaction, the changes can be recovered.

Temporary Changes: Changes are logged first in the WAL, ensuring they aren't lost if a crash occurs mid-transaction.
Volatile Memory: WAL resides in RAM for speed but is periodically saved to disk to protect against data loss during power outages.
Final Commit: Once a transaction is successful, changes in the WAL are applied to the database. If the transaction fails, the log is discarded.
Durability: WAL allows the database to recover and apply pending changes after a crash, maintaining consistency.



### Operations on Transactional Databases

- **Insert**: Adding new data to the database
- **Update**: Modifying existing data
- **Delete**: Removing data from the database
- **Commit**: Finalizing a transaction, making changes permanent
- **Rollback**: Reverting a transaction to its previous state in case of failure

### Use Cases for Transactional Databases

Transactional databases are ideal for applications that require strict consistency and integrity, such as:
- **Banking Systems**
- **Live Ticket Booking Systems**
- **E-commerce platforms where transactions must be reliable**


### Database Management Systems (DBMS)

A **DBMS** (Database Management System) is software that enables the storage, retrieval, and manipulation of data in a database. It provides a systematic way to manage data, allowing for easy access, modification, and management of data across various applications.

### Relational Database Management Systems (RDBMS)

An **RDBMS** is a type of DBMS that organizes data into structured tables with defined relationships between them. These tables use a row-column format where each table represents a different entity. The data can be accessed and manipulated using Structured Query Language (SQL).

**Data Formats:**

- **Structured Data:** Organized in a strict row-column format, such as CSV files or SQL tables.
- **Semi-structured Data:** Flexible schema, typically stored in formats like JSON or XML.
- **Unstructured Data:** No specific format, including data types like audio, video, and PDFs.

### MySQL

MySQL is an open-source RDBMS that uses SQL for database management. It allows data to be stored in tables within databases, which are managed by MySQL on a server. MySQL can be installed on a physical server or accessed through a cloud instance.

**System Layers in MySQL:**

1. **Layer 1:** Server
2. **Layer 2:** MySQL (RDBMS)
3. **Layer 3:** Database
    - **Database 1**
        - **Layer 4:** Tables (e.g., `table1`, `table2`)
    - **Database 2**
        - **Layer 4:** Tables (e.g., `table1`, `table2`)

**Interacting with MySQL:**

- **Programmatically:** Using programming languages like Python or Java, along with appropriate libraries, to connect and interact with MySQL.
- **IDE/Workbench:** Using tools like MySQL Workbench, which provides a UI for running SQL queries and managing databases.

### SQL (Structured Query Language)

SQL is the standard language for interacting with RDBMS like MySQL. It consists of various types of commands, each serving a specific purpose:

#### Types of SQL Commands

1. **DDL (Data Definition Language):** Commands that define or alter the structure of the database.
    - **Create:** Creates a new database, table, index, or view.
    - **Alter:** Modifies an existing database object, like adding a column to a table.
    - **Drop:** Deletes a database object, such as a table or database.
    - **Truncate:** Removes all records from a table, but does not delete the table itself.
    - **Rename:** Renames a database object.

2. **DML (Data Manipulation Language):** Commands that manipulate the data within the database.
    - **Insert:** Adds new records to a table.
    - **Update:** Modifies existing records in a table.
    - **Delete:** Removes records from a table.

3. **DQL (Data Query Language):** Commands that query and retrieve data from a database.
    - **Select:** Retrieves data from one or more tables.

4. **DCL (Data Control Language):** Commands that manage user permissions.
    - **Grant:** Provides access rights to users.
    - **Revoke:** Removes access rights from users.

### Data Types in MySQL

**1. String Data Types:**

| Data Type | Description | Length |
|-----------|-------------|--------|
| char(n)   | Fixed-length string | n characters |
| nchar(n)  | Fixed-length Unicode string | n characters |
| varchar(n)| Variable-length string | Up to n characters |
| varchar(max)| Variable-length string | Maximum possible length |
| nvarchar(n)| Variable-length Unicode string | Up to n characters |
| nvarchar(max)| Variable-length Unicode string | Maximum possible length |

**2. Date Data Types:**

| Data Type   | Description         |
|-------------|---------------------|
| DATE        | Date value (YYYY-MM-DD) |
| DATETIME(fsp)| Date and time value |
| TIMESTAMP(fsp)| Timestamp value   |
| TIME(fsp)   | Time value          |
| YEAR        | Year value (YYYY)   |

**3. Numeric Data Types:**

| Data Type | Description                      |
|-----------|----------------------------------|
| BIT(size) | Bit field (0 or 1)               |
| TINYINT(size)| Small integer                |
| BOOL      | Boolean value (TRUE or FALSE)    |
| SMALLINT(size)| Small integer               |
| MEDIUMINT(size)| Medium integer             |
| INT(size) | Standard integer                 |
| INTEGER(size)| Standard integer             |
| BIGINT(size)| Large integer                 |
| FLOAT(size, d)| Floating-point number       |
| FLOAT(p)  | Floating-point number with precision |
| DOUBLE(size, d)| Double precision floating-point number |
| DOUBLE PRECISION(size, d)| Double precision floating-point number |
| DECIMAL(size, d)| Fixed-point number         |

### Hands-On MySQL Example

```sql
-- Command to see the list of databases
show databases;

-- Command to create a new database
create database noob_db;

-- Command to switch to a specific database
use noob_db;

-- DDL command to create a table
CREATE TABLE if not EXISTS employee
(
    id INT,
    emp_name VARCHAR(20)
);

-- Command to see the list of tables
show tables;

-- Command to see the table definition
show create table employee;

-- DDL command to create a more complex table
CREATE TABLE if not EXISTS employee_v1
(
    id INT,
    name VARCHAR(50),
    salary DOUBLE, 
    hiring_date DATE 
);

-- DML command to insert a record into a table
insert into employee_v1 values(1,'Shashank',1000,'2021-09-15');

-- This statement will fail due to incorrect data types
insert into employee_v1 values(1,1000,'Shashank','2021-09-15');

-- Alternative syntax for inserting data into a table
insert into employee_v1(salary, name, id) 
values(2000, 'Rahul', 2);

-- DML command to insert multiple records
insert into employee_v1 values(3, 'Amit', 5000, '2021-10-28'),
(4, 'Nitin', 3500, '2021-09-16'),
(5, 'Kajal', 4000, '2021-09-20');

-- DQL command to query the data from the table
select * from employee_v1;

-- Commit changes (in cases where autocommit is off)
COMMIT;

SHOW VARIABLES LIKE 'autocommit';
+---------------+-------+
| Variable_name | Value |
+---------------+-------+
| autocommit    | ON    |
+---------------+-------+
1 row in set (0.01 sec)

```


### Integrity Constraints

Integrity constraints are rules applied to database columns to ensure the accuracy and consistency of the data. These constraints enforce data integrity and help in maintaining the reliability of the database. Below are common integrity constraints used in relational databases:

1. **NOT NULL**: Ensures that a column cannot have a NULL value. This constraint is used when a field must always contain a value.

2. **CHECK**: Ensures that the value in a column satisfies a specific condition. For example, a `CHECK` constraint can be used to ensure that the value of the `salary` column is always greater than 1000.

3. **DEFAULT**: Provides a default value for a column when no value is specified during insertion. For instance, if a `hiring_date` is not provided, the `DEFAULT` constraint can insert a default date like '2021-01-01'.

4. **UNIQUE**: Ensures that all the values in a column are different. It allows only one NULL value unless otherwise specified. While `UNIQUE` allows a single NULL, `PRIMARY KEY` (which also enforces uniqueness) does not allow NULL values.

5. **PRIMARY KEY**: Uniquely identifies each row in a table. A column with a `PRIMARY KEY` constraint cannot have NULL values and must contain unique values. Typically, it combines `UNIQUE` and `NOT NULL`.

6. **FOREIGN KEY**: Ensures referential integrity by enforcing a link between the data in two tables. A `FOREIGN KEY` in one table points to a `PRIMARY KEY` in another table, ensuring that the relationship between the tables is maintained.

### Practical Examples of Integrity Constraints

```sql

use noob_db;

drop table noob_db.employee_with_constraints;

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
-- This should fail according to the SQL standard, but MySQL allows multiple NULLs in UNIQUE constraints.
-- This behavior is specific to MySQL and should be noted during debugging.
insert into employee_with_constraints 
values(null,'Rajat',2000,'2020-09-20');

select * from employee_with_constraints;

--- Example 4 for IC failure
--- Exception - Check constraint 'employee_with_constraints_chk_1' is violated
-- in above error message it is difficult to debug, so when defining the schema give names to the IC
-- Note: The error message might not be descriptive, making it difficult to debug. 
insert into employee_with_constraints 
values(5,'Amit',500,'2023-10-24');


--- Test IC for default date
insert into employee_with_constraints(id,name,salary)
values(7,'Neeraj',3000);


select * from employee_with_constraints;


--- Example table for integrity constraints
-- Naming constraints helps in identifying and debugging errors more easily when a constraint is violated.
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
-- here it is better to debug
-- Naming the constraint makes this error message more informative and easier to debug.
insert into employee_with_constraints_tmp 
values(5,'Amit',500,'2023-10-24');

```

