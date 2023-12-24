```sql
-- Step 1: Create the employees table
CREATE TABLE employees (
    employee_id INTEGER,
    name VARCHAR,
    role VARCHAR,
    salary DECIMAL,
    status VARCHAR
);

-- Step 2: Insert data into the employees table
INSERT INTO employees (employee_id, name, role, salary, status) VALUES
(1, 'Alice', 'Engineer', 70000, 'Active'),
(2, 'Bob', 'Analyst', 50000, 'Active'),
(3, 'Charlie', 'Manager', 80000, 'Active');

-- Step 3: Create the may_emp_updates table
CREATE TABLE may_emp_updates (
    employee_id INTEGER,
    name VARCHAR,
    role VARCHAR,
    salary DECIMAL,
    status VARCHAR,
    action VARCHAR
);

-- Step 4: Insert data into the may_emp_updates table
INSERT INTO may_emp_updates (employee_id, name, role, salary, status, action) VALUES
(4, 'Diana', 'Engineer', 75000, 'Active', 'hired'),
(2, 'Bob', 'Analyst', 55000, 'Active', 'pay change'),
(3, 'Charlie', 'Manager', 80000, 'Inactive', 'terminated'),
(5, 'Eve', 'Consultant', 65000, 'Active', 'contracted');

-- Step 5: Run the MERGE statement with CASE statements
MERGE INTO employees AS e
USING may_emp_updates AS u
ON (e.employee_id = u.employee_id)
    WHEN MATCHED THEN
        UPDATE SET 
            e.salary = CASE WHEN u.action = 'pay change' THEN u.salary ELSE e.salary END,
            e.status = CASE WHEN u.action IN ('terminated', 'resigned') THEN 'Inactive' ELSE e.status END
    WHEN NOT MATCHED THEN
        INSERT (employee_id, name, role, salary, status)
        SELECT employee_id, name, role, salary, status
        FROM (
            SELECT u.employee_id, u.name, u.role, u.salary, u.status,
                   CASE WHEN u.action IN ('hired', 'contracted') THEN 1 ELSE 0 END AS should_insert
            FROM may_emp_updates u
        ) sub
        WHERE sub.should_insert = 1;
```

The employees table is created to store employee records.
Sample data is inserted into employees.
The may_emp_updates table is created, representing updates for May, including new hires, salary changes, and terminations.
Sample updates are inserted into may_emp_updates.
The MERGE INTO statement is used to process these updates:
If there's a salary change (pay change action), the employee's salary is updated.
If an employee is terminated or resigned, their record is deleted from the employees table.
If the action is for a new hire (hired or contracted), and the employee does not exist in the employees table, a new record is inserted.