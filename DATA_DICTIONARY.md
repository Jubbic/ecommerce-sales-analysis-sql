# Data Dictionary
## E-Commerce Sales Analysis Project

This document describes the tables used in the e-commerce sales database.

---

## Customers Table

Stores customer information.

| Column | Description |
|---|---|
| customer_id | Unique identifier for each customer |
| customer_name | Customer's full name |
| city | Customer location |
| email | Customer email address |

---

## Products Table

Stores product information.

| Column | Description |
|---|---|
| product_id | Unique identifier for each product |
| product_name | Name of the product |
| category_id | Links product to its category |
| price | Product selling price |

---

## Categories Table

Stores product category information.

| Column | Description |
|---|---|
| category_id | Unique identifier for each category |
| category_name | Name of the product category |

---

## Orders Table

Stores customer order information.

| Column | Description |
|---|---|
| order_id | Unique identifier for each order |
| customer_id | Links order to customer |
| order_date | Date the order was placed |

---

## Order_Items Table

Stores individual products included in each order.

| Column | Description |
|---|---|
| order_item_id | Unique identifier for each order item |
| order_id | Links item to an order |
| product_id | Links item to a product |
| quantity | Number of units purchased |

---

## Relationships Between Tables

- Customers → Orders  
  One customer can place many orders.

- Orders → Order_Items  
  One order can contain multiple products.

- Products → Order_Items  
  One product can appear in many orders.

- Categories → Products  
  One category can contain many products.
