

subqueries in SQL
- IN: The IN operator allows you to specify multiple values in a WHERE clause. It returns true if a value matches any value in a list.
SELECT * FROM Orders WHERE ProductName IN ('Apple', 'Banana');
- NOT IN: The NOT IN operator excludes the values in the list. It returns true if a value does not match any value in the list.
SELECT * FROM Orders WHERE ProductName NOT IN ('Apple', 'Banana');
- ANY: The ANY operator returns true if any subquery value meets the condition.
- ALL: The ALL operator returns true if all subquery value meets the condition.
- EXISTS: The EXISTS operator returns true if the subquery returns one or more records.
- NOT EXISTS: The NOT EXISTS operator returns true if the subquery returns no records.


Windows funciotn


Window Functions In SQL
● Window functions: These are special SQL functions that perform a calculation across a set of related rows.
● How it works: Instead of operating on individual rows, a window function operates on a group or 'window' of rows that are 
somehow related to the current row. This allows for complex calculations based on these related rows.
● Window definition: The 'window' in window functions refers to a set of rows. The window can be defined using different 
criteria depending on the requirements of your operation.
● Partitions: By using the PARTITION BY clause, you can divide your data into smaller sets or 'partitions'. The window 
function will then be applied individually to each partition.
● Order of rows: You can specify the order of rows in each partition using the ORDER BY clause. This order influences how 
some window functions calculate their result.
● Frames: The ROWS/RANGE clause lets you further narrow down the window by defining a 'frame' or subset of rows within 
each partition.
● Comparison with Aggregate Functions: Unlike aggregate functions that return a single result per group, window 
functions return a single result for each row of the table based on the group of rows defined in the window.
● Advantage: Window functions allow for more complex operations that need to take into account not just the current row, 
but also its 'neighbours' in some way.






### Windows Functions in SQL

- **When using only `ORDER BY` in the `OVER` clause:**
    - The window function operates on the entire result set, and results are calculated progressively based on the order specified.

#### Example 1: Running Sum of Sales (ordered by sales amount descending)

```sql
SELECT *, 
       SUM(sales_amount) OVER (
           ORDER BY sales_amount DESC
       ) AS running_sum_of_sales
FROM shop_sales_data;
```

- **Explanation**: This query calculates the running sum of `sales_amount`, ordered by `sales_amount` in descending order. The sum at each row includes all previous rows based on this order.

#### Example 2: Running Sum of Sales (ordered by shop ID descending)

```sql
SELECT *, 
       SUM(sales_amount) OVER (
           ORDER BY shop_id DESC
       ) AS running_sum_of_sales
FROM shop_sales_data;
```

- **Explanation**: Here, the running sum is calculated based on the order of `shop_id` in descending order. Each row's sum includes all previous rows as per this ordering.

#### Example 3: Maximum Sales Amount (ordered by shop ID descending)

```sql
SELECT *, 
       MAX(sales_amount) OVER (
           ORDER BY shop_id DESC
       ) AS running_max_of_sales
FROM shop_sales_data;
```

- **Explanation**: This query calculates the running maximum of `sales_amount`, ordered by `shop_id` in descending order. It gives the maximum value seen so far in the ordered rows.

---

### Behavior Without `PARTITION BY`

- When the `PARTITION BY` clause is not used, the window function works on the entire result set based on the order specified in `ORDER BY`. 
- The window starts with the first row and progressively includes more rows as per the `ORDER BY` clause.

#### Key Point:
- For functions like `MIN()` or `MAX()`, at each step, the result is derived from all the rows processed up to that point.
    - **Example with `MIN()`**: 
        - In the first row, `MIN()` returns the minimum value of the first window (i.e., the first row).
        - In the second row, it returns the minimum value from the combined data of the first and second rows, and so on.

