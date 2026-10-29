use sql7challenge;

-- 1. Count the total number of orders in the database
select count(*) as total_orders
from orders;


-- 2. count how many ordrs exist for each status
select status, count(*) as total_orders
from orders
group by status;


-- 3. Retrieve the 10 latest orders by order date
select *
from orders
order by order_date desc
limit 10;


-- 4. Find the 10 ordrs with the highest total amount
SELECT orders.order_id, orders.customer_id, orders.order_date, SUM(order_items.quantity * order_items.unit_price) AS total_amount
FROM orders 
JOIN order_items ON order_items.order_id = orders.order_id
GROUP BY orders.order_id, orders.customer_id, orders.order_date
ORDER BY total_amount DESC
LIMIT 10;


-- 5. count orders placed per day in chronological order
SELECT DATE(order_date) AS order_day, COUNT(*) AS orders_placed
FROM orders
GROUP BY DATE(order_date)
ORDER BY order_day ASC;


-- 6. group orders by month using data functin identify peak and low volume months
select month(order_date), count(*) AS total_orders
from orders
group by month(order_date)
order by month(order_date) asc;


-- 7. calculate te average order amount across all orders round result for clean reporting
select round(avg(order_amount),2)
from
(select order_id, sum(quantity*unit_price) as order_amount
from order_items
group by order_id) as orders_total;


-- insights
-- 1. Delivered orders are highest at 1,796, while 280 orders were returned and 236 were cancelled.
-- 2. Daily order volume fluctuates, with some days recording higher orders than others, indicating variations in customer activity.
-- 3. Monthly orders peak in August (300 orders), while November has only 130 orders so far