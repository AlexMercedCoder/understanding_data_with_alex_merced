[Details on Setup](https://github.com/developer-advocacy-dremio/quick-guides-from-dremio/blob/main/guides/superset-dremio.md)

```sql
CREATE TABLE orders (
  order_id INT,
  order_date DATE,
  customer_id INT,
  customer_name VARCHAR,
  product_id INT,
  product_name VARCHAR,
  quantity INT,
  unit_price DECIMAL(10,2),
  total_price DECIMAL(10, 2),
  order_status VARCHAR,
  payment_method VARCHAR,
  shipping_country VARCHAR,
  shipping_cost DECIMAL(10,2)
);
```

```sql
INSERT INTO orders
(order_id, order_date, customer_id, customer_name, product_id, product_name, quantity, unit_price, total_price, order_status, payment_method, shipping_country, shipping_cost)
VALUES
(1, '2023-11-20', 123, 'Alice Smith', 543, 'Wireless Headphones', 1, 79.99, 79.99, 'Delivered', 'Credit Card', 'USA', 5.99),
(2, '2023-12-05', 456, 'Bob Johnson', 129, 'Running Shoes', 2, 89.99, 179.98, 'Shipped', 'PayPal', 'Germany', 9.99),
(3, '2023-12-12', 789, 'Charlie Lee', 875, 'Smart Watch', 1, 199.99, 199.99, 'Pending', 'Debit Card', 'China', 12.99),
(4, '2023-12-18', 123, 'Alice Smith', 231, 'Coffee Maker', 1, 49.99, 49.99, 'Processed', 'Credit Card', 'USA', 4.99),
(5, '2023-12-21', 951, 'David Brown', 654, 'Bluetooth Speaker', 3, 39.99, 119.97, 'Delivered', 'Cash on Delivery', 'UK', 7.99),
(6, '2024-01-03', 456, 'Bob Johnson', 369, 'Fitness Tracker', 2, 59.99, 119.98, 'Shipped', 'PayPal', 'Germany', 9.99),
(7, '2024-01-08', 258, 'Emily Clark', 987, 'Laptop Bag', 1, 29.99, 29.99, 'Pending', 'Debit Card', 'Canada', 8.99),
(8, '2024-01-10', 789, 'Charlie Lee', 543, 'Wireless Headphones', 2, 79.99, 159.98, 'Processed', 'Credit Card', 'China', 12.99),
(9, '2024-01-15', 123, 'Alice Smith', 102, 'Book: The Martian', 1, 15.99, 15.99, 'Delivered', 'Credit Card', 'USA', 3.99),
(10, '2024-01-16', 951, 'David Brown', 459, 'Wireless Keyboard', 1, 34.99, 34.99, 'Shipped', 'PayPal', 'UK', 6.99);
```
