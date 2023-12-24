```sql
-- Step 1: Create a table and populate it with sample data
CREATE TABLE sample_data (
    id INTEGER,
    val INTEGER
);

-- Insert sample data into the table
INSERT INTO sample_data (id, val) VALUES
    (1, 1),
    (2, 20),
    (3, 30),
    (4, 40),
    (5, 200);

-- Step 2: Use the MEDIAN function to compute the median
SELECT MEDIAN(val) AS median_value, AVG(val) as avg_value FROM sample_data;
```