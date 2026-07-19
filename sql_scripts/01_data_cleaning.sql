/*
=========================================
DATA CLEANING PROJECT
E-COMMERCE SALES ANALYSIS

Author: Adeleke Jubril

Purpose:
Prepare and improve data quality before analysis.

Cleaning Tasks:
- Data Inspection
- Missing Value Checks
- Duplicate Detection
- Data Quality Validation
=========================================
*/


/*
=========================================
1. DATA INSPECTION
=========================================
*/

-- Inspect Order Items Table
SELECT *
FROM order_items;


/*
=========================================
2. MISSING VALUE CHECKS
=========================================
*/

-- Check for missing customer names
SELECT *
FROM customers
WHERE customer_name IS NULL;


-- Check for missing customer cities
SELECT *
FROM customers
WHERE city IS NULL;


-- Check for missing product names
SELECT *
FROM products
WHERE product_name IS NULL;


-- Check for missing customer IDs in orders
SELECT *
FROM orders
WHERE customer_id IS NULL;



/*
=========================================
3. DUPLICATE RECORD CHECKS
=========================================
*/

-- Check for duplicate customer names
SELECT
    customer_name,
    COUNT(*) AS duplicate_count
FROM customers
GROUP BY customer_name
HAVING COUNT(*) > 1;


-- Check for duplicate product names
SELECT
    product_name,
    COUNT(*) AS duplicate_count
FROM products
GROUP BY product_name
HAVING COUNT(*) > 1;


-- Check for duplicate order IDs
SELECT
    order_id,
    COUNT(*) AS duplicate_count
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;
