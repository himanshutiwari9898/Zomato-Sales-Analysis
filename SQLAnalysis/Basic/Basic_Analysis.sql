
-- 1). What are the top 10 restaurants by total sales amount? Tables(orders, restaursnt)
SELECT r.id AS restaurant_id, r.name AS restaurant_name,
    SUM(o.sales_qty) AS total_sales
FROM orders o
JOIN restaurant r ON o.r_id = r.id
GROUP BY r.id, r.name
ORDER BY total_sales DESC
LIMIT 10;

-- 2). What is the average rating and total rating count for restaurants in the top 20 cities? 
-- Tables(restaurants)
SELECT r.city, ROUND(AVG(r.rating), 2) AS average_rating,
    SUM(r.rating_count) AS total_rating_count
FROM restaurant r
JOIN (
    SELECT city
    FROM restaurant
    GROUP BY city
    ORDER BY COUNT(*) DESC
    LIMIT 20
) top_cities ON r.city = top_cities.city
GROUP BY r.city
ORDER BY total_rating_count DESC;

-- 3). What are the monthly order trends based on order volume over time? 
-- Tables(orders)
select * from orders limit 10;
SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS order_month,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY order_month;

-- 4). What are the top 5 most popular cuisines by order volume? 
-- Tables(orders, menu)
SELECT m.cuisine,
       COUNT(o.order_id) AS total_orders
FROM orders o
JOIN menu m ON o.r_id = m.r_id
GROUP BY m.cuisine
ORDER BY total_orders DESC
LIMIT 5;

-- 5). What is the distribution of vegetarian vs non-vegetarian items ordered? 
-- Tables(orders, menu,food_item)
SELECT f.veg_or_non_veg,
       COUNT(o.order_id) AS total_orders
FROM orders o
JOIN menu m ON o.r_id = m.r_id
JOIN food_items f ON m.f_id = f.f_id
GROUP BY f.veg_or_non_veg;

-- 6). What are the top 20 cities by the number of restaurants?
-- Table(restaurants)
SELECT city,
       COUNT(id) AS restaurant_count
FROM restaurant
GROUP BY city
ORDER BY restaurant_count DESC
LIMIT 20;
-- 7). How do different user demographics correlate with average order value? 
-- Tables(orders, users)
SELECT u.age,
       u.gender,
       u.educational_qualifications,
       AVG(o.sales_qty) AS avg_order_value
FROM orders o
JOIN users u ON o.user_id = u.user_id
GROUP BY u.age, u.gender, u.educational_qualifications
LIMIT 10;

-- 8).Who are the top 15 highest-spending users? 
-- Tables(orders, users)
SELECT u.user_id,
       u.name,
       SUM(o.sales_qty) AS total_spent
FROM orders o
JOIN users u ON o.user_id = u.user_id
GROUP BY u.user_id, u.name
ORDER BY total_spent DESC
LIMIT 15;

-- 9).What are the top 15 cuisines with the highest average menu prices? 
-- Tables(menu)
SELECT cuisine,
       AVG(price) AS avg_price
FROM menu
GROUP BY cuisine
ORDER BY avg_price DESC
LIMIT 15;

-- 10).Which restaurants offer the most diverse menu, based on the number of unique cuisines and dishes available? 
-- Tables(menu, food_item, restaurants)
SELECT r.name,
       COUNT(DISTINCT m.cuisine) AS unique_cuisines,
       COUNT(DISTINCT f.f_id) AS unique_dishes
FROM restaurant r
JOIN menu m ON r.id = m.r_id
JOIN food_items f ON m.f_id = f.f_id
GROUP BY r.name
ORDER BY unique_cuisines DESC, unique_dishes DESC
LIMIT 20;

-- 11). What are the most ordered food items across all restaurants? 
-- Tables(ordes, menu, food_item)
SELECT f.item,
       COUNT(o.order_id) AS total_orders
FROM orders o
JOIN menu m ON o.r_id = m.r_id
JOIN food_items f ON m.f_id = f.f_id
GROUP BY f.item
ORDER BY total_orders DESC
LIMIT 20;

-- 12). How does spending behavior differ between genders? 
-- Tables(orders, users)
SELECT u.gender,
       AVG(o.sales_qty) AS avg_spend,
       SUM(o.sales_qty) AS total_spend
FROM orders o
JOIN users u ON o.user_id = u.user_id
GROUP BY u.gender;

-- 13). On which days of the week do restaurants experience peak order volumes? 
-- Tbales(orders)
SELECT DAYNAME(order_date) AS day_name,
       COUNT(order_id) AS total_orders
FROM orders
GROUP BY day_name
ORDER BY total_orders DESC;

-- 14). How does order frequency vary across different income groups? 
-- Tables(orders, users)
WITH user_spending AS (
    SELECT user_id,
           SUM(sales_qty) AS total_spent
    FROM orders
    GROUP BY user_id
)
SELECT 
    CASE
        WHEN total_spent < 5000 THEN 'Low'
        WHEN total_spent BETWEEN 5000 AND 20000 THEN 'Medium'
        ELSE 'High'
    END AS income_group_proxy,
    COUNT(*) AS total_users
FROM user_spending
GROUP BY income_group_proxy;

