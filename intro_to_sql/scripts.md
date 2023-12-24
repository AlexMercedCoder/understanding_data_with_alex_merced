# Intro to SQL Code

### WHERE

```sql
-- Create a table named 'students' with at least 5 columns
CREATE TABLE students (
    student_id INTEGER PRIMARY KEY,
    first_name TEXT,
    last_name TEXT,
    age INTEGER,
    gender TEXT,
    grade FLOAT
);

-- Insert 5 records into the 'students' table
INSERT INTO students (first_name, last_name, age, gender, grade)
VALUES
    ('John', 'Doe', 18, 'Male', 90.5),
    ('Jane', 'Smith', 20, 'Female', 85.0),
    ('Alice', 'Johnson', 19, 'Female', 92.5),
    ('Bob', 'Williams', 21, 'Male', 78.5),
    ('Eva', 'Brown', 22, 'Female', 88.0);

-- Example 1: Using WHERE with greater than
SELECT * FROM students WHERE age > 20;

-- Example 2: Using WHERE with BETWEEN
SELECT * FROM students WHERE grade BETWEEN 85.0 AND 90.0;

-- Example 3: Using WHERE with multiple conditions (AND)
SELECT * FROM students WHERE age >= 18 AND gender = 'Female';

-- Example 4: Using WHERE with OR
SELECT * FROM students WHERE age < 20 OR grade >= 90.0;
```

### Aggregations

```sql
-- Create a table named 'sales' with relevant columns
CREATE TABLE sales (
    id INTEGER PRIMARY KEY,
    salesperson TEXT,
    region TEXT,
    amount INTEGER,
    sale_date DATE
);

-- Insert 5 records into the 'sales' table
INSERT INTO sales (salesperson, region, amount, sale_date)
VALUES
    ('Alice', 'North', 500, '2023-01-10'),
    ('Bob', 'South', 700, '2023-02-15'),
    ('Alice', 'East', 600, '2023-03-20'),
    ('Charlie', 'West', 300, '2023-04-25'),
    ('Alice', 'North', 800, '2023-05-30');

-- Aggregate Query Example 1: COUNT
-- Count the total number of sales records
SELECT COUNT(*) FROM sales;

-- Aggregate Query Example 2: SUM
-- Calculate the total sales amount
SELECT SUM(amount) FROM sales;

-- Aggregate Query Example 3: AVG (Average)
-- Calculate the average sales amount
SELECT AVG(amount) FROM sales;

-- Aggregate Query Example 4: MAX
-- Find the maximum sales amount
SELECT MAX(amount) FROM sales;

-- Aggregate Query Example 5: MIN
-- Find the minimum sales amount
SELECT MIN(amount) FROM sales;

-- Aggregate Query Example 6: GROUP BY with COUNT
-- Count the number of sales per salesperson
SELECT salesperson, COUNT(*) AS num_sales FROM sales GROUP BY salesperson;

-- Aggregate Query Example 7: GROUP BY with SUM
-- Calculate the total sales amount per region
SELECT region, SUM(amount) AS total_sales FROM sales GROUP BY region;

-- Aggregate Query Example 8: GROUP BY with AVG
-- Calculate the average sales amount per salesperson
SELECT salesperson, AVG(amount) AS average_sales FROM sales GROUP BY salesperson;

-- Aggregate Query Example 9: HAVING
-- Find regions with a total sales amount greater than a certain value
SELECT region, SUM(amount) AS total_sales FROM sales GROUP BY region HAVING SUM(amount) > 1000;
```

### JOINS

```sql
-- Create a table named 'employees'
CREATE TABLE employees (
    employee_id INTEGER PRIMARY KEY,
    employee_name TEXT,
    department_id INTEGER
);

-- Create a table named 'departments'
CREATE TABLE departments (
    department_id INTEGER PRIMARY KEY,
    department_name TEXT
);

-- Insert data into 'employees'
INSERT INTO employees (employee_name, department_id) VALUES
('John Doe', 1),
('Jane Smith', 2),
('Alice Johnson', 3),
('Bob Williams', NULL),  -- Bob's department is unknown
('Eva Brown', 2);

-- Insert data into 'departments'
INSERT INTO departments (department_id, department_name) VALUES
(1, 'Human Resources'),
(2, 'Marketing'),
(3, 'Finance'),
(4, 'IT');

-- Join Example 1: INNER JOIN
-- Get the list of employees with their department names
SELECT employees.employee_name, departments.department_name
FROM employees
INNER JOIN departments ON employees.department_id = departments.department_id;

-- Join Example 2: LEFT JOIN (or LEFT OUTER JOIN)
-- Get all employees and their department names, including those without a department
SELECT employees.employee_name, departments.department_name
FROM employees
LEFT JOIN departments ON employees.department_id = departments.department_id;

-- Join Example 3: RIGHT JOIN (or RIGHT OUTER JOIN) - Not supported in SQLite
-- This would get all departments and their employees, including departments without employees
-- (Right Joins are not supported in SQLite, but this can be achieved with a LEFT JOIN and switching the tables)

-- Join Example 4: FULL OUTER JOIN - Not supported in SQLite
-- This would get all employees and all departments, regardless of whether they match
-- (Full Outer Joins are not supported in SQLite, but can be simulated with a UNION of LEFT JOIN and RIGHT JOIN)

-- Join Example 5: CROSS JOIN
-- Get a Cartesian product of employees and departments
SELECT employees.employee_name, departments.department_name
FROM employees
CROSS JOIN departments;

-- Join Example 6: SELF JOIN
-- Join employees table to itself to find colleagues (employees in the same department)
SELECT A.employee_name AS Employee1, B.employee_name AS Employee2
FROM employees A, employees B
WHERE A.department_id = B.department_id AND A.employee_id != B.employee_id;
```

### INSERT INTO SELECT & CTAS

```sql
-- Create an example table named 'products'
CREATE TABLE products (
    product_id INTEGER PRIMARY KEY,
    product_name TEXT,
    price DECIMAL(10, 2),
    category TEXT
);

-- Insert data into 'products'
INSERT INTO products (product_name, price, category) VALUES
('Laptop', 1200.00, 'Electronics'),
('Smartphone', 800.00, 'Electronics'),
('Desk Chair', 150.00, 'Furniture'),
('Table Lamp', 45.00, 'Furniture'),
('Bluetooth Headphones', 130.00, 'Electronics');

-- Create a new table 'electronics' with products from the 'Electronics' category
CREATE TABLE electronics AS 
SELECT * 
FROM products 
WHERE category = 'Electronics';

-- Now, insert additional 'Electronics' products into the 'electronics' table
-- by selecting from 'products'
INSERT INTO electronics (product_id, product_name, price, category)
SELECT product_id, product_name, price, category
FROM products
WHERE category = 'Electronics' AND price > 500;

-- Select from the new 'electronics' table to verify
SELECT * FROM electronics;
```

### Common Table Expressions

```sql
-- Create a table named 'employees'
CREATE TABLE employees (
    id INTEGER PRIMARY KEY,
    name TEXT,
    manager_id INTEGER
);

-- Insert data into 'employees'
INSERT INTO employees (id, name, manager_id) VALUES
(1, 'Alice', NULL),  -- Alice is the CEO
(2, 'Bob', 1),       -- Bob reports to Alice
(3, 'Charlie', 1),   -- Charlie also reports to Alice
(4, 'David', 2),     -- David reports to Bob
(5, 'Eva', 3);       -- Eva reports to Charlie

-- Using a Common Table Expression (CTE) to find direct reports
WITH DirectReports AS (
    SELECT
        e1.name AS Employee,
        e2.name AS Manager
    FROM
        employees e1
    INNER JOIN
        employees e2 ON e1.manager_id = e2.id
)
SELECT
    *
FROM
    DirectReports;

-- Another CTE example: Aggregating data
-- Counting the number of direct reports each manager has
WITH ReportCounts AS (
    SELECT
        manager_id,
        COUNT(*) AS NumberOfReports
    FROM
        employees
    WHERE
        manager_id IS NOT NULL
    GROUP BY
        manager_id
)
SELECT
    e.name AS Manager,
    rc.NumberOfReports
FROM
    employees e
INNER JOIN
    ReportCounts rc ON e.id = rc.manager_id;
```

### Window Functions

```sql
-- Create a table named 'sales'
CREATE TABLE sales (
    sale_id INTEGER PRIMARY KEY,
    salesperson TEXT,
    region TEXT,
    amount INTEGER,
    sale_date DATE
);

-- Insert data into 'sales'
INSERT INTO sales (salesperson, region, amount, sale_date) VALUES
('Alice', 'North', 300, '2023-01-10'),
('Bob', 'South', 500, '2023-01-15'),
('Alice', 'East', 450, '2023-01-20'),
('Charlie', 'North', 700, '2023-02-10'),
('Alice', 'South', 600, '2023-02-20'),
('Bob', 'East', 350, '2023-03-15'),
('Charlie', 'South', 500, '2023-04-10'),
('Alice', 'North', 400, '2023-05-15');

-- Window Function Example 1: ROW_NUMBER()
-- Assigns a unique number to each row within the partition of a result set
SELECT salesperson, region, amount,
       ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount DESC) AS row_num
FROM sales;

-- Window Function Example 2: RANK()
-- Assigns a rank to each row within a partition of a result set, with gaps in rank values
SELECT salesperson, region, amount,
       RANK() OVER (PARTITION BY region ORDER BY amount DESC) AS rank
FROM sales;

-- Window Function Example 3: DENSE_RANK()
-- Similar to RANK(), but without gaps in the rank values
SELECT salesperson, region, amount,
       DENSE_RANK() OVER (PARTITION BY region ORDER BY amount DESC) AS dense_rank
FROM sales;

-- Window Function Example 4: SUM() as a Window Function
-- Provides a running total within a partition
SELECT salesperson, region, amount,
       SUM(amount) OVER (PARTITION BY region ORDER BY sale_date) AS running_total
FROM sales;

-- Window Function Example 5: AVG() as a Window Function
-- Calculates the average within a partition
SELECT salesperson, region, amount,
       AVG(amount) OVER (PARTITION BY region ORDER BY sale_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS avg_to_date
FROM sales;

-- Window Function Example 6: LEAD() and LAG()
-- LEAD() provides access to a row at a given physical offset that follows the current row
-- LAG() provides access to a row at a given physical offset that precedes the current row
SELECT salesperson, region, amount,
       LAG(amount, 1) OVER (ORDER BY sale_date) AS prev_amount,
       LEAD(amount, 1) OVER (ORDER BY sale_date) AS next_amount
FROM sales;
```