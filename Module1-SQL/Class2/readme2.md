
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

### 5. Working with Constraints

- **Adding a Unique Constraint**
  ```sql
  ALTER TABLE employee ADD CONSTRAINT id_unique UNIQUE(id);
  ```

- **Dropping a Unique Constraint**
  ```sql
  ALTER TABLE employee DROP CONSTRAINT id_unique;
  ```

## DML (Data Manipulation Language) Commands

### 6. Inserting Data
```sql
INSERT INTO employee VALUES(1, 'Shashank', 'Lucknow', '2012-02-02');
```

### 7. Deleting Data

- **Deleting a Specific Row**
  ```sql
  DELETE FROM employee WHERE id=1;
  ```

- **Truncating a Table**
  ```sql
  TRUNCATE TABLE employee;
  ```

- **Dropping a Table**
  ```sql
  DROP TABLE employee;
  ```

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
  ```

- **Handling Foreign Key Violations**
  ```sql
  INSERT INTO orders VALUES(1004, 35, 5);
  -- Error: Cannot add or update a child row: a foreign key constraint fails
  ```

## Differences Between `DROP`, `TRUNCATE`, and `DELETE`

| Feature               | DROP                                                   | TRUNCATE                                                | DELETE                                               |
|-----------------------|--------------------------------------------------------|---------------------------------------------------------|------------------------------------------------------|
| **Purpose**           | Removes the table and its structure from the database. | Removes all rows from the table but retains the structure.| Removes specific rows based on a condition.          |
| **Transaction Control** | Cannot be rolled back (except in some DBMS).          | Cannot be rolled back.                                   | Can be rolled back if used within a transaction.     |
| **Space Reclaiming**  | Releases space used by the table and its data.         | Reclaims the space occupied by the data.                 | Typically does not reclaim space unless specified.   |
| **Speed**             | Fastest, as it deletes the table structure.            | Faster than DELETE, as it does not generate row delete statements. | Slower, especially with large tables. |
| **Referential Integrity** | Fails if there are dependent foreign keys.          | Fails if there are dependent foreign keys.               | Maintains referential integrity.                     |
| **WHERE Clause**      | Not applicable.                                        | Not applicable.                                          | Applicable; allows selective deletion of rows.       |
| **Command Type**      | DDL                                                    | DDL                                                     | DML                                                  |

