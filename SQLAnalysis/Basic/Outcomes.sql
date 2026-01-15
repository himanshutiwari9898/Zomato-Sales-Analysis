
-- What are the top 10 restaurants by total sales amount? Tables(orders, restaursnt)
SELECT r.id AS restaurant_id, r.name AS restaurant_name,
    SUM(o.sales_qty) AS total_sales
FROM orders o
JOIN restaurant r ON o.r_id = r.id
GROUP BY r.id, r.name
ORDER BY total_sales DESC
LIMIT 10;

-- What is the average rating and total rating count for restaurants in the top 20 cities? Tables(restaurants)

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

-- What are the monthly order trends based on order volume over time? Tables(orders)
select * from orders limit 10;
SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS order_month,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY order_month;

-- What are the top 5 most popular cuisines by order volume? Tables(orders, menu)
-- What is the distribution of vegetarian vs non-vegetarian items ordered? Tables(orders, menu,food_item)
-- What are the top 20 cities by the number of restaurants?(restaurants)
-- How do different user demographics correlate with average order value? Tables(orders, users)
-- Who are the top 15 highest-spending users? Tables(orders, users)
-- What are the top 15 cuisines with the highest average menu prices? Tables(menu)
-- Which restaurants offer the most diverse menu, based on the number of unique cuisines and dishes available? Tables(menu, food_item, restaurants)
-- What are the most ordered food items across all restaurants? Tables(ordes, menu, food_item)
-- How does spending behavior differ between genders? Tables(orders, users)
-- On which days of the week do restaurants experience peak order volumes? Tbales(orders)
-- How does order frequency vary across different income groups? Tables(orders, users)

-- QUESTIONS BY ME

-- What percentage of total orders does each city contribute?
-- Tables: orders, restaurants

-- Which restaurants have declining order volume month-over-month?
-- Tables: orders, restaurants

-- Identify restaurants with high ratings but low order volume
-- Tables: restaurants, orders

-- Which cuisines generate the highest revenue per order?
-- Tables: orders, menu

-- What is the repeat order rate per user?
-- Tables: orders, users

-- Which age group places the highest number of orders?
-- Tables: users, orders

-- What is the average order value by city?
-- Tables: orders, restaurants

-- Which restaurants depend heavily on a single cuisine?
-- Tables: menu, restaurants

-- Find users who stopped ordering in the last 6 months
-- Tables: users, orders

-- Which food items are ordered across the maximum number of restaurants?
-- Tables: food_items, menu, orders

-- Compare average spend between married and unmarried users
-- Tables: users, orders

-- Which income group contributes the highest total revenue?
-- Tables: users, orders

-- What is the average number of items per order?
-- Tables: orders, menu

-- Identify restaurants with rising ratings but falling sales
-- Tables: restaurants, orders

-- Which cuisines are popular among female users only?
-- Tables: users, orders, menu

-- What time-based trend exists in veg vs non-veg ordering?
-- Tables: orders, menu, food_items

-- Which restaurants have menu prices significantly above city average?
-- Tables: menu, restaurants

-- Find users who order frequently but spend below average
-- Tables: users, orders

-- Which cities have high restaurant count but low average ratings?
-- Tables: restaurants

-- Which food items contribute most to revenue but are ordered infrequently?
-- Tables: food_items, menu, orders