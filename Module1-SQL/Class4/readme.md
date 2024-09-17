

subqueries in SQL
- IN: The IN operator allows you to specify multiple values in a WHERE clause. It returns true if a value matches any value in a list.
SELECT * FROM Orders WHERE ProductName IN ('Apple', 'Banana');
- NOT IN: The NOT IN operator excludes the values in the list. It returns true if a value does not match any value in the list.
SELECT * FROM Orders WHERE ProductName NOT IN ('Apple', 'Banana');
- ANY: The ANY operator returns true if any subquery value meets the condition.
- ALL: The ALL operator returns true if all subquery value meets the condition.
- EXISTS: The EXISTS operator returns true if the subquery returns one or more records.
- NOT EXISTS: The NOT EXISTS operator returns true if the subquery returns no records.


