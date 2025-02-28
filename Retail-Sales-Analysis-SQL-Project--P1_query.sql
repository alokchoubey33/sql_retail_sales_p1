--SQL Retail sales Analysis -P1---
CREATE DATABASE final_retail_project_1
USE final_retail_project_1;
--Create Tabe ---
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE  retail_sales 
(
transactions_id	INT PRIMARY KEY,
sale_date DATE,
sale_time TIME,	
customer_id INT,
gender	VARCHAR(15),
age	INT,
category VARCHAR(15),
quantiy INT,
price_per_unit FLOAT,	
cogs FLOAT,
total_sale FLOAT
);

-- --Checking Totalnumber --

SELECT 
COUNT(*) 
FROM retail_sales;

-- CHECKING NULL VALUES --

SELECT 
    *
FROM
    retail_sales
WHERE
    transactions_id IS NULL;

SELECT 
    *
FROM
    retail_sales
WHERE
    transactions_id IS NULL
        OR sale_date IS NULL
        OR sale_time IS NULL
        OR customer_id IS NULL
        OR gender IS NULL
        OR age IS NULL
        OR category IS NULL
        OR quantiy IS NULL
        OR price_per_unit IS NULL
        OR cogs IS NULL
        OR total_sale IS NULL;
        
--  DELETING NULL RECORDS (DATA CLEANING)
DELETE FROM retail_sales 
WHERE
    transactions_id IS NULL
    OR sale_date IS NULL
    OR sale_time IS NULL
    OR customer_id IS NULL
    OR gender IS NULL
    OR age IS NULL
    OR category IS NULL
    OR quantiy IS NULL
    OR price_per_unit IS NULL
    OR cogs IS NULL
    OR total_sale IS NULL;

-- DATA EXPLORATION 

-- How many Sales we have 
SELECT 
    COUNT(*) AS sales_count
FROM
    retail_sales;
    
-- How many unique Coustomers We have 
SELECT 
    COUNT(DISTINCT customer_id) AS unique_coistomers
FROM
    retail_sales;
    
-- Data Analys and Busines Probems 
-- My Analysis and solving  

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'
SELECT 
    *
FROM
    retail_sales
WHERE
    sale_date = '2022-11-05';
-- Q.2 Write a SQL query to retrieve all transactions where the category is 
-- 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022-- 

SELECT 
    *
FROM
    retail_sales
WHERE
    category = 'Clothing'
        AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
        AND quantiy >= 4;

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT category,
SUM(total_sale) AS net_sales,
COUNT(*) AS total_orders 
FROM retail_sales 
GROUP BY category;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT 
    ROUND(AVG(age), 2)
FROM
    retail_sales
WHERE
    category = 'beauty';
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT 
  *
FROM
    retail_sales
WHERE
    total_sale > 1000;
-- Q.6 Write a SQL query to find the total number of transactions
 -- (transaction_id) made by each gender in each category.-- 
SELECT category ,
       gender,
       COUNT(*) AS total_trans
FROM retail_sales
GROUP BY category,
         gender;
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

SELECT 
sale_year,
sale_month,
avg_sale

 FROM 
(
SELECT 
 YEAR(sale_date) AS sale_year,
 MONTH(sale_date) AS sale_month,
 AVG(total_sale) AS avg_sale,
 RANK() OVER(PARTITION BY year(sale_date) ORDER BY avg(total_sale) DESC) AS ranking
 FROM retail_sales
 GROUP BY sale_year , sale_month
--  ORDER BY 1 ,3 DESC
) AS t1
WHERE ranking =1;
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT 
    customer_id, SUM(total_sale) AS total_sales
FROM
    retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT 
    category, COUNT(DISTINCT customer_id)
FROM
    retail_sales
GROUP BY category;

-- Q.10 Write a SQL query to create each 
-- shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

WITH hourly_sale
AS
(
SELECT * ,
CASE WHEN HOUR(sale_time) <=12 THEN 'morning'
     WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'afternoon'
     ELSE 'evening'
     
     END AS shift
FROM retail_sales
) SELECT 
shift, COUNT(*) AS total_orders
 FROM hourly_sale
 GROUP BY shift
 
--  --- end of the projecct ______

 







