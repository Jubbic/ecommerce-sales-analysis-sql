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
