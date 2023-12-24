```sql
-- Step 1: Create and load the 'products' table
CREATE TABLE products (
    product_id INTEGER,
    name VARCHAR,
    price DECIMAL,
    category VARCHAR
);

INSERT INTO products (product_id, name, price, category) VALUES
    (1, 'Widget A', 19.99, 'Widgets'),
    (2, 'Widget B', 29.99, 'Widgets'),
    (3, 'Gadget A', 14.99, 'Gadgets');

-- Step 2: Create and load the 'product_updates' table
CREATE TABLE product_updates (
    product_id INTEGER,
    name VARCHAR,
    price DECIMAL,
    category VARCHAR
);

INSERT INTO product_updates (product_id, name, price, category) VALUES
    (2, 'Widget B Plus', 34.99, 'Widgets'),  -- Updated product
    (3, 'Gadget A', 14.99, 'Gadgets'),       -- Unchanged product
    (4, 'Gadget B', 24.99, 'Gadgets');       -- New product

-- Step 3: Run the MERGE statement
MERGE INTO products AS p
USING product_updates AS u
ON (p.product_id = u.product_id)
    WHEN MATCHED THEN
        UPDATE SET name = u.name, price = u.price, category = u.category
    WHEN NOT MATCHED THEN
        INSERT (product_id, name, price, category) VALUES (u.product_id, u.name, u.price, u.category);
```

Two tables are created: products and product_updates.
products is populated with initial product data.
product_updates is populated with a mix of updated, unchanged, and new product data.
The MERGE INTO statement then checks for matches based on product_id.
If a match is found (indicating an update), it updates the corresponding record in products with the data from product_updates.
If no match is found (indicating a new product), it inserts a new record into products with the data from product_updates.
