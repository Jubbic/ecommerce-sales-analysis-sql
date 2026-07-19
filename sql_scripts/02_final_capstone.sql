/*
=========================================
FINAL CAPSTONE PROJECT
E-COMMERCE SALES ANALYSIS

Author: Adeleke Jubril

Skills Demonstrated:
- Joins
- Aggregate Functions
- GROUP BY
- HAVING
- Subqueries
- CASE WHEN
- Window Functions
- Views
- Business Reporting
=========================================
*/


USE ecommerce_sales_analysis;


/*
=========================================
1. PRODUCT REVENUE ANALYSIS

Business Question:
Which products generate the highest revenue?
=========================================
*/

SELECT 
    p.product_name,
    SUM(oi.quantity * p.price) AS total_revenue
FROM products p
JOIN order_items oi
ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_revenue DESC;



/*
=========================================
2. TOP 5 CUSTOMERS BY SPENDING

Business Question:
Who are the highest-value customers?
=========================================
*/

SELECT 
    c.customer_name,
    SUM(oi.quantity * p.price) AS total_amount_spent
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN order_items oi
ON o.order_id = oi.order_id
JOIN products p
ON oi.product_id = p.product_id
GROUP BY c.customer_name, c.customer_id
ORDER BY total_amount_spent DESC
LIMIT 5;



/*
=========================================
3. ORDERS BY CITY

Business Question:
Which cities generate the most orders?
=========================================
*/

SELECT 
    c.city,
    COUNT(o.order_id) AS number_of_orders
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.city
ORDER BY number_of_orders DESC;



/*
=========================================
4. BEST SELLING PRODUCTS

Business Question:
Which products sell the highest quantity?
=========================================
*/

SELECT
    p.product_name,
    SUM(oi.quantity) AS total_quantity_sold
FROM products p
JOIN order_items oi
ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_quantity_sold DESC
LIMIT 5;



/*
=========================================
5. AVERAGE CUSTOMER ORDER VALUE

Business Question:
What is the average spending value per customer?
=========================================
*/

SELECT 
    c.customer_name,
    AVG(oi.quantity * p.price) AS average_order_value
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN order_items oi
ON o.order_id = oi.order_id
JOIN products p
ON oi.product_id = p.product_id
GROUP BY c.customer_name
ORDER BY average_order_value DESC;



/*
=========================================
6. CATEGORY REVENUE ANALYSIS

Business Question:
Which categories drive the most revenue?
=========================================
*/

SELECT 
    c.category_name,
    SUM(oi.quantity * p.price) AS total_revenue
FROM categories c
JOIN products p
ON c.category_id = p.category_id
JOIN order_items oi
ON oi.product_id = p.product_id
GROUP BY c.category_name
ORDER BY total_revenue DESC;



/*
=========================================
7. HIGH FREQUENCY CUSTOMERS

Business Question:
Which customers placed more than 5 orders?
=========================================
*/

SELECT 
    c.customer_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name, c.customer_id
HAVING total_orders > 5
ORDER BY total_orders DESC;



/*
=========================================
8. PRODUCTS WITH NO SALES

Business Question:
Which products have never been purchased?
=========================================
*/

SELECT 
    p.product_name,
    p.product_id
FROM products p
LEFT JOIN order_items oi
ON oi.product_id = p.product_id
WHERE oi.product_id IS NULL;



/*
=========================================
9. CUSTOMERS ABOVE AVERAGE SPENDING

Business Question:
Which customers spend more than the average customer?
=========================================
*/

SELECT
    c.customer_name,
    SUM(oi.quantity * p.price) AS customer_spending
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN order_items oi
ON o.order_id = oi.order_id
JOIN products p
ON oi.product_id = p.product_id
GROUP BY c.
customer_id, c.customer_name
HAVING SUM(oi.quantity * p.price) >
(
    SELECT AVG(total_spending)
    FROM
    (
        SELECT 
            SUM(oi.quantity * p.price) AS total_spending
        FROM customers c
        JOIN orders o
        ON c.customer_id = o.customer_id
        JOIN order_items oi
        ON o.order_id = oi.order_id
        JOIN products p
        ON oi.product_id = p.product_id
        GROUP BY c.customer_id
    ) AS customer_totals
)
ORDER BY customer_spending DESC;



/*
=========================================
10. CUSTOMER SPENDING VIEW

Business Question:
Create reusable customer spending analysis table.
=========================================
*/

CREATE VIEW customer_spending_summary AS
SELECT 
    c.customer_name,
    c.customer_id,
    SUM(oi.quantity * p.price) AS total_spending
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN order_items oi
ON o.order_id = oi.order_id
JOIN products p
ON oi.product_id = p.product_id
GROUP BY c.customer_id, c.customer_name;


SELECT *
FROM customer_spending_summary
ORDER BY total_spending DESC;



/*
=========================================
11. SALES PERFORMANCE DASHBOARD QUERY

Business Question:
Rank products by revenue performance.
=========================================
*/

SELECT 
    p.product_name,
    c.category_name,
    SUM(oi.quantity * p.price) AS total_revenue,
    SUM(oi.quantity) AS total_quantity_sold,
    RANK() OVER(
        ORDER BY SUM(oi.quantity * p.price) DESC
    ) AS revenue_rank
FROM products p
JOIN order_items oi
ON oi.product_id = p.product_id
JOIN categories c
ON p.category_id = c.category_id
GROUP BY p.product_name, c.category_name;
