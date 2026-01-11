# Zomato-Sales-Analysis

📌 Project Overview

This project simulates a real-world food delivery analytics system inspired by Zomato.
It goes beyond basic SQL queries and focuses on business-driven insights, scalable schema design, and decision-oriented analysis.

The goal is simple:
Answer real business questions using clean data modeling and advanced SQL.

🧠 Key Objectives
Design a production-grade relational schema
Perform advanced SQL analysis (window functions, CTEs, trends)
Analyze customer behavior, restaurant performance, and revenue drivers
Identify growth, churn, and optimization opportunities

🗂️ Dataset & Schema Design
The project uses a star-schema-inspired design with fact and dimension tables.
Core Tables
users – customer demographics
restaurants – restaurant metadata
food_items – veg / non-veg classification
menu – pricing and cuisine mapping
orders – transactional order data
order_items – item-level order details
ratings – time-based restaurant ratings

This structure enables:
Time-series analysis
Customer Lifetime Value (LTV)
Revenue attribution
Rating vs sales correlation

📊 Business Questions Answered
Customer Analytics
Repeat order rate per user
Customer churn (inactive users)
Lifetime value (LTV)
Spending behavior by gender, age, and marital status
Restaurant Performance
High-rated but low-performing restaurants
Restaurants dependent on a single cuisine
Restaurants with rising ratings but falling sales
Menu price comparison vs city averages
Revenue & Growth
Average order value (AOV)
Monthly revenue trends (MoM growth)
Revenue contribution by cuisine and food items
High-revenue but low-frequency items

Demand & Trends
Veg vs non-veg ordering trends over time
Peak ordering periods
Cuisine popularity by user segment
City-wise order contribution %

🧮 SQL Techniques Used
JOIN (inner, left)
CTE (WITH clause)
Window Functions (LAG, RANK, AVG OVER)
Conditional logic (CASE WHEN)
Time-based aggregation
Subqueries for behavioral segmentation

📁 Project Structure
Zomato-Analytics/
│
├── data/
│   ├── users.csv
│   ├── restaurants.csv
│   ├── food_items.csv
│   ├── menu.csv
│   ├── orders.csv
│   ├── order_items.csv
│   └── ratings.csv
│
├── sql/
│   ├── schema.sql
│   ├── kpi_queries.sql
│   └── advanced_analysis.sql
│
├── README.md
└── analysis.md

🧠 Key Insights (Sample)

A small percentage of users contribute a disproportionate share of revenue
Several restaurants show high ratings but weak order volume, indicating visibility or pricing issues
Certain food items generate high revenue despite low order frequency
Veg vs non-veg demand shows clear temporal patterns
Some cities are over-saturated with restaurants but underperform in ratings

🛠️ Tools & Technologies
SQL (MySQL compatible)
Relational Database Design

🎯 Why This Project Matters
Most portfolio projects stop at:
“SELECT * FROM table;”
This one doesn’t.
It demonstrates:
Business thinking
Data modeling skills
Analytical depth


👤 Author
Himanshu Tiwari
Aspiring Data Analyst | SQL | Analytics | BI
