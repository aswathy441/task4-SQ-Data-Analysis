README - SQL for Data Analysis Assignment
Project Overview
This project demonstrates SQL data analysis using an e-commerce dataset. The objective is to learn how to manipulate and query structured data to gain insights such as total sales, top customers, product performance, and trends.
Dataset
Dataset Name: Ecommerce_SQL_Database
Tables:
- customers: customer details (id, name, email, city)
- categories: product categories (id, name)
- products: product details (id, name, category_id, price, stock)
- orders: order records (id, customer_id, order_date, status)
- order_items: order details (id, order_id, product_id, quantity)

Tools Used
- Database: SQLite (can also run on MySQL or PostgreSQL)
- Client: DB Browser for SQLite / MySQL Workbench / pgAdmin
- Optional: Python (pandas) for exports
Setup Instructions
1. Install SQLite or MySQL/PostgreSQL.
2. Create a new database (e.g., ecommerce).
3. Execute the provided SQL script (ecommerce_analysis.sql) to create tables and insert sample data.
4. Run the queries in the SQL file to generate analysis results.
5. Export screenshots and CSV outputs as required.
Key SQL Features Demonstrated
- SELECT, WHERE, ORDER BY
- Aggregations: SUM, AVG, COUNT
- GROUP BY and HAVING
- INNER JOIN, LEFT JOIN
- Subqueries (correlated and non-correlated)
- Views for reusable analysis
- Index creation and query optimization
Deliverables
- ecommerce_analysis.sql: SQL script with table creation, sample data, and analysis queries
- Screenshots of output for each query
- README (this file) describing setup and project overview
- Optional: CSV exports of query results
Insights (Examples)
- Identify top customers by lifetime value.
- Find products with no orders.
- Calculate monthly revenue trends.
Author
Name:ASWATHY SADANAPPAN
