-- Customer Spending Report --

select
c.customer_name,
c.city,
sum(oi.quantity * p.price) as total_spending,
count(distinct o.order_id) as total_order,
rank() over(order by sum(oi.quantity * p.price) desc) as spending_rank
from customers c
join orders o
on c.customer_id = o.customer_id
join order_items oi
on o.order_id = oi.order_id
join products p
on oi.product_id = p.product_id
group by c.customer_name, c.city;

-- Top Customer in Each City --

with customer_city_rank as (
select
c.city,
c.customer_name,
sum(oi.quantity * p.price) as total_spending,
rank() over(partition by city order by sum(oi.quantity * p.price) desc) as city_rank
from customers c
join orders o
on c.customer_id = o.customer_id
join order_items oi
on o.order_id = oi.order_id
join products p
on oi.product_id = p.product_id
group by c.city, c.customer_name
)
select *
from customer_city_rank
where city_rank = 1;

-- Monthly Sales Trend Analysis --

with order_revenue as (
select
o.order_id,
o.order_date,
sum(oi.quantity * p.price) as revenue
from orders o
join order_items oi
on o.order_id = oi.order_id
join products p
on oi.product_id = p.product_id
group by o.order_id,o.order_date
)
select
order_id,
order_date,
revenue,
lag(revenue) over(order by order_date) as previous_revenue,
revenue - lag(revenue) over(order by order_date) as difference
from order_revenue;
