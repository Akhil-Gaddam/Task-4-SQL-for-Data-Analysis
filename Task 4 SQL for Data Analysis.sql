-- Create and use the database
CREATE DATABASE northwind;
USE northwind;

-- Basic SELECT with LIMIT
SELECT id, company, mobile_phone, city
FROM customers
LIMIT 10;


-- WHERE filtering
SELECT id, customer_id, order_date, ship_country_region
FROM orders
WHERE ship_country_region = 'USA';


-- GROUP BY and ORDER BY with COUNT aggregation
SELECT ship_country_region, COUNT(*) AS Total_orders
FROM orders
GROUP BY ship_country_region
ORDER BY Total_orders DESC;



-- using JOIN 
SELECT c.company, o.id, o.order_date, od.product_id, p.Product_name, od.quantity
FROM customers c
JOIN orders o ON c.id = o.customer_id
JOIN order_details od ON o.id = od.id
JOIN products p ON od.product_id = p.id
WHERE o.order_date BETWEEN '1997-01-01' AND '1997-12-31';


-- Subquery: 
SELECT id, company
FROM customers
WHERE id IN (
SELECT customer_id 
FROM orders 
GROUP BY customer_id 
HAVING COUNT(id) > 5
);

 -- Create a VIEW for analysis 
CREATE VIEW CustomerOrderSummary AS
SELECT c.id, c.company, COUNT(o.id) AS Total_orders, SUM(od.quantity * od.unit_price) AS TotalAmount
FROM customers c
JOIN orders o ON c.id = o.customer_id
JOIN order_details od ON o.id = od.order_id
GROUP BY c.id, c.company;



-- View the created summary
SELECT * FROM CustomerOrderSummary ORDER BY TotalAmount DESC;


-- Indexing
CREATE INDEX idx_ship_country ON orders(ship_country_region);
