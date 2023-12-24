```sql
-- Step 1: Create a table for students
CREATE TABLE student_records (
    name VARCHAR(50),
    age INT,
    current_score DECIMAL(4, 2),
    favorite_class VARCHAR(50),
    homeroom_teacher VARCHAR(50)
);

-- Step 2: Insert 50 random student records
INSERT INTO student_records (name, age, current_score, favorite_class, homeroom_teacher)
VALUES
    ('Alice', 18, 95.75, 'Math', 'Mr. Johnson'),
    ('Bob', 17, 88.50, 'Science', 'Mrs. Smith'),
    ('Charlie', 16, 92.25, 'History', 'Mr. Davis'),
    ('David', 17, 89.75, 'English', 'Ms. Wilson'),
    ('Emily', 18, 96.00, 'Math', 'Mr. Johnson'),
    ('Frank', 16, 91.25, 'Science', 'Mrs. Smith'),
    ('Grace', 17, 87.75, 'History', 'Mr. Davis'),
    ('Hannah', 18, 94.50, 'English', 'Ms. Wilson'),
    ('Isaac', 16, 90.25, 'Math', 'Mr. Johnson'),
    ('Jacob', 17, 88.00, 'Science', 'Mrs. Smith'),
    ('Katherine', 18, 93.00, 'History', 'Mr. Davis'),
    ('Liam', 16, 91.75, 'English', 'Ms. Wilson'),
    ('Mia', 17, 89.50, 'Math', 'Mr. Johnson'),
    ('Noah', 18, 95.25, 'Science', 'Mrs. Smith'),
    ('Olivia', 16, 92.00, 'History', 'Mr. Davis'),
    ('Sophia', 17, 87.25, 'English', 'Ms. Wilson'),
    ('William', 18, 94.00, 'Math', 'Mr. Johnson'),
    ('Zoe', 16, 90.75, 'Science', 'Mrs. Smith'),
    -- Add more students here...
    ('Student50', 17, 88.75, 'History', 'Mr. Davis');
```
