```sql
-- Create a table named 'destinations'
CREATE TABLE destinations (
    id INTEGER PRIMARY KEY,
    name VARCHAR,
    category VARCHAR
);

-- Insert data into 'destinations'
INSERT INTO destinations (id, name, category) VALUES
(1, 'Eiffel Tower', 'Attraction'),
(2, 'The Ritz', 'Hotels'),
(3, 'Joe’s Diner', 'Restaurants'),
(4, 'Central Park', 'Parks'),
(5, 'Grand Hotel', 'Hotels');

-- Run a query using the CASE statement
-- This will categorize destinations based on their type
SELECT
    name,
    CASE category
        WHEN 'Restaurants' THEN 'food'
        WHEN 'Hotels' THEN 'travel'
        WHEN 'Attraction' THEN 'sightseeing'
        WHEN 'Parks' THEN 'recreation'
        ELSE 'other'
    END AS category_type
FROM
    destinations;
```

This code block first creates a destinations table with columns id, name, and category. Then, it populates the table with various destinations, each belonging to a category like 'Restaurants', 'Hotels', etc. Finally, it demonstrates the use of the CASE statement to categorize these destinations into broader types such as 'food', 'travel', 'sightseeing', and 'recreation'. This example shows how CASE can be used to transform and categorize data based on specific conditions.