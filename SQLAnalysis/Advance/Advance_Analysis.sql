-- Advance Analysis

-- 1).What percentage of total orders does each city contribute?
-- Tables: orders, restaurants
SELECT r.city,
       COUNT(o.order_id) * 100.0 / SUM(COUNT(o.order_id)) OVER () AS order_percentage
FROM orders o
JOIN restaurant r ON o.r_id = r.id
GROUP BY r.city
order by order_percentage desc
LIMIT 15;

-- 2). Which restaurants have declining order volume month-over-month?
-- Tables: orders, restaurants
WITH monthly_orders AS (
  SELECT r.id,
         DATE_FORMAT(o.order_date, '%Y-%m') AS ym,
         COUNT(*) AS orders_cnt
  FROM orders o
  JOIN restaurant r ON o.r_id = r.id
  GROUP BY r.id, ym
),
trend AS (
  SELECT *,
         LAG(orders_cnt) OVER (PARTITION BY id ORDER BY ym) AS prev_cnt
  FROM monthly_orders
)
SELECT DISTINCT id
FROM trend
WHERE orders_cnt < prev_cnt;


-- 3). Identify restaurants with high ratings but low order volume
-- Tables: restaurants, orders
SELECT r.id, r.name, r.rating, COUNT(o.order_id) AS total_orders
FROM restaurant r
LEFT JOIN orders o ON r.id = o.r_id
GROUP BY r.id, r.name, r.rating
HAVING r.rating >= 4 AND total_orders < 50
ORDER BY rating DESC
LIMIT 20;


-- 4). Which cuisines generate the highest revenue per order?
-- Tables: orders, menu
SELECT m.cuisine,
       AVG(m.price * o.sales_qty) AS avg_revenue_per_order
FROM orders o
JOIN menu m ON o.r_id = m.r_id
GROUP BY m.cuisine
ORDER BY avg_revenue_per_order DESC
LIMIT 20;


-- 5). What is the repeat order rate per user?
-- Tables: orders, users
SELECT user_id,
       COUNT(order_id) AS total_orders,
       CASE WHEN COUNT(order_id) > 1 THEN 1 ELSE 0 END AS is_repeat
FROM orders
GROUP BY user_id
ORDER BY total_orders DESC
LIMIT 20;

-- 6).Which age group places the highest number of orders?
-- Tables: users, orders
SELECT
  CASE
    WHEN age < 25 THEN '18-24'
    WHEN age BETWEEN 25 AND 35 THEN '25-35'
    ELSE '36+'
  END AS age_group,
  COUNT(o.order_id) AS total_orders
FROM users u
JOIN orders o ON u.user_id = o.user_id
GROUP BY age_group
ORDER BY total_orders DESC;

-- 7).What is the average order value by city?
-- Tables: orders, restaurants
SELECT r.city,
       AVG(o.sales_qty) AS avg_order_value
FROM orders o
JOIN restaurant r ON o.r_id = r.id
GROUP BY r.city
ORDER BY avg_order_value DESC
LIMIT 20;


-- 8). Which restaurants depend heavily on a single cuisine?
-- Tables: menu, restaurants
SELECT r.name,
       COUNT(DISTINCT m.cuisine) AS cuisine_count
FROM restaurant r
JOIN menu m ON r.id = m.r_id
GROUP BY r.name
HAVING cuisine_count = 1
ORDER BY cuisine_count DESC
limit 20;


-- 9). Find users who stopped ordering in the last 6 months
-- Tables: users, orders
SELECT u.user_id, u.name
FROM users u
LEFT JOIN orders o
  ON u.user_id = o.user_id
 AND o.order_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
WHERE o.order_id IS NULL
limit 20;


-- 10).food items are ordered across the maximum number of restaurants?
-- Tables: food_items, menu, orders
SELECT f.item,
       COUNT(DISTINCT m.r_id) AS restaurant_count
FROM food_items f
JOIN menu m ON f.f_id = m.f_id
JOIN orders o ON m.r_id = o.r_id
GROUP BY f.item
ORDER BY restaurant_count DESC
LIMIT 20;

-- 10). Compare average spend between married and unmarried userss
-- Tables: users, orders
SELECT u.marital_status,
       AVG(o.sales_qty) AS avg_spend
FROM users u
JOIN orders o ON u.user_id = o.user_id
GROUP BY u.marital_status;

-- 11). What is the average number of items per order?
-- Tables: orders, menu
SELECT AVG(sales_qty) AS avg_items_per_order
FROM orders;

-- 12). Which cuisines are popular among female users only?
-- Tables: users, orders, menu
SELECT DISTINCT m.cuisine
FROM orders o
JOIN users u ON o.user_id = u.user_id
JOIN menu m ON o.r_id = m.r_id
WHERE u.gender = 'Female'
AND m.cuisine NOT IN (
    SELECT m2.cuisine
    FROM orders o2
    JOIN users u2 ON o2.user_id = u2.user_id
    JOIN menu m2 ON o2.r_id = m2.r_id
    WHERE u2.gender <> 'Female'
)
LIMIT 20;

-- 13). What time-based trend exists in veg vs non-veg ordering?
-- Tables: orders, menu, food_items
SELECT DATE(o.order_date) AS order_day,
       f.veg_or_non_veg,
       COUNT(*) AS orders
FROM orders o
JOIN menu m ON o.r_id = m.r_id
JOIN food_items f ON m.f_id = f.f_id
GROUP BY order_day, f.veg_or_non_veg
ORDER BY orders DESC
LIMIT 20;

-- 14). Which restaurants have menu prices significantly above city average?
-- Tables: menu, restaurants
WITH city_avg AS (
  SELECT r.city, AVG(m.price) AS city_avg_price
  FROM restaurant r
  JOIN menu m ON r.id = m.r_id
  GROUP BY r.city
)
SELECT r.name, m.price
FROM restaurant r
JOIN menu m ON r.id = m.r_id
JOIN city_avg c ON r.city = c.city
WHERE m.price > c.city_avg_price
ORDER BY price DESC
LIMIT 20;

-- 15). Which cities have high restaurant count but low average ratings?
-- Tables: restaurants
SELECT city,
       COUNT(id) AS restaurant_count,
       AVG(rating) AS avg_rating
FROM restaurant
GROUP BY city
HAVING restaurant_count > 20 AND avg_rating < 3.5
ORDER BY restaurant_count DESC
LIMIT 20;

