
-- ecommerce_analysis.sql
-- DDL for tables and a set of analysis queries (compatible with SQLite; adjust types/keywords for MySQL/Postgres if needed).

-- TABLES
CREATE TABLE customers (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, email TEXT UNIQUE, city TEXT);
CREATE TABLE categories (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL);
CREATE TABLE products (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, category_id INTEGER, price REAL NOT NULL, stock INTEGER DEFAULT 0);
CREATE TABLE orders (id INTEGER PRIMARY KEY AUTOINCREMENT, customer_id INTEGER, order_date DATE, status TEXT);
CREATE TABLE order_items (id INTEGER PRIMARY KEY AUTOINCREMENT, order_id INTEGER, product_id INTEGER, quantity INTEGER);

-- SAMPLE QUERIES
-- 1. Simple SELECT
SELECT * FROM customers;

-- 2. WHERE + ORDER BY
SELECT id, name, price, stock FROM products WHERE price > 50 ORDER BY price DESC;

-- 3. JOINs + GROUP BY + aggregate (order totals)
SELECT o.id AS order_id, o.order_date, c.name AS customer, SUM(oi.quantity * p.price) AS order_total
FROM orders o
JOIN customers c ON o.customer_id = c.id
JOIN order_items oi ON oi.order_id = o.id
JOIN products p ON p.id = oi.product_id
GROUP BY o.id
ORDER BY order_total DESC;

-- 4. LEFT JOIN (customers with order counts including zero)
SELECT c.id, c.name, COUNT(o.id) AS order_count
FROM customers c
LEFT JOIN orders o ON o.customer_id = c.id
GROUP BY c.id
ORDER BY order_count DESC;

-- 5. Subquery: products never ordered
SELECT p.id, p.name FROM products p WHERE NOT EXISTS (SELECT 1 FROM order_items oi WHERE oi.product_id = p.id);

-- 6. GROUP BY with HAVING (customers above average lifetime value)
SELECT c.id, c.name, SUM(oi.quantity * p.price) AS lifetime_value
FROM customers c
JOIN orders o ON o.customer_id = c.id
JOIN order_items oi ON oi.order_id = o.id
JOIN products p ON p.id = oi.product_id
GROUP BY c.id
HAVING SUM(oi.quantity * p.price) > (
    SELECT AVG(customer_total) FROM (
        SELECT SUM(oi2.quantity * p2.price) AS customer_total
        FROM customers c2
        JOIN orders o2 ON o2.customer_id = c2.id
        JOIN order_items oi2 ON oi2.order_id = o2.id
        JOIN products p2 ON p2.id = oi2.product_id
        GROUP BY c2.id
    )
)
ORDER BY lifetime_value DESC;

-- 7. Create view for repeated analysis
CREATE VIEW customer_ltv AS
SELECT c.id AS customer_id, c.name AS customer_name, SUM(oi.quantity * p.price) AS lifetime_value
FROM customers c
JOIN orders o ON o.customer_id = c.id
JOIN order_items oi ON oi.order_id = o.id
JOIN products p ON p.id = oi.product_id
GROUP BY c.id;

-- 8. Indexes for optimization
CREATE INDEX idx_orders_customer ON orders(customer_id);
CREATE INDEX idx_order_items_order ON order_items(order_id);
CREATE INDEX idx_order_items_product ON order_items(product_id);

-- 9. Example of an EXPLAIN (query plan)
EXPLAIN QUERY PLAN SELECT o.id AS order_id, SUM(oi.quantity * p.price) AS order_total FROM orders o JOIN order_items oi ON oi.order_id=o.id JOIN products p ON p.id=oi.product_id GROUP BY o.id;

