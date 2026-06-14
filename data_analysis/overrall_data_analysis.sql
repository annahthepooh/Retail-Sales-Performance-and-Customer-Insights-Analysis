-- An overview of everything in the customers table 

SELECT * FROM global_electronics_retail_shop.customers;

-- The number of customers by gender 
-- There are 5480 female customers and 5556 male customers. The male customers are more than the female customers 

SELECT Gender, COUNT(Gender) AS NUM
FROM customers
GROUP BY Gender;

-- Finds the percentage of customers by gender
-- 49.66% ARE female while 50.34% are male

WITH Gender_Count AS 
	(SELECT Gender, 
		COUNT(*) AS Total_Count
	FROM customers
	GROUP BY Gender)

SELECT Gender,
	Total_Count,
	ROUND((Total_count*100/ (SELECT SUM(Total_count) FROM Gender_Count)),2) AS Percentage
FROM Gender_Count;

-- Returns the number of customers per state, sectioned into total, female and male

SELECT * FROM customers;

SELECT State,
	COUNT(*) AS total_customers,
    SUM(CASE WHEN gender = 'Male' THEN 1 ELSE 0 END) AS male_customers,
    SUM(CASE WHEN gender = 'Female' THEN 1 ELSE 0 END) AS female_customers
FROM customers
GROUP BY state
ORDER BY COUNT(*) DESC;

-- Returns the distinct countries the customers are from and the number of customers in each country

SELECT DISTINCT Country 
FROM customers;

SELECT country, COUNT(Customer_Key) AS customer_number
FROM customers
GROUP BY country
ORDER BY COUNT(Customer_key) DESC;

-- Used the CTE function to find the percentage of customers per country
-- The leading country is the United States (61.87%) followed by  Germany (13.35%), Australia(12.87%), France(6.07%) then Italy(5.84%)
-- Most customers are from the United while Italy has the least number of customers

WITH customer_per_country AS (
SELECT country, 
	COUNT(Customer_Key) AS customer_number
FROM customers
GROUP BY country
ORDER BY COUNT(Customer_key) DESC)

SELECT country,
	customer_number,
    ROUND(((customer_number*100)/(SELECT SUM(customer_number) FROM customer_per_country)),2) AS percentage
FROM customer_per_country;

-- Returns the number of customers per continent
-- North America is the leading (6828), followed by Europe(2788) then Australia (1420)

SELECT * FROM customers;

SELECT DISTINCT continent 
FROM customers;

SELECT Continent,
	COUNT(Customer_Key) AS customer_number
FROM customers
GROUP BY Continent
ORDER BY COUNT(Customer_Key) DESC;

-- Returns the percentage of customers per continent
-- North America has 61.87%, followed by Europe 25.26% then 12.87% 

WITH customer_per_continent AS(
	SELECT continent,
		COUNT(customer_key) AS customer_number
	FROM customers
	GROUP BY continent
    ORDER BY COUNT(Customer_Key))
    
SELECT continent,
	customer_number,
    ROUND(((customer_number*100)/(SELECT SUM(customer_number) FROM customer_per_continent)),2) AS percentage
FROM customer_per_continent
ORDER BY customer_number DESC;

-- Returns the earliest and the latest birthdays among the customers

SELECT * FROM customers;

SELECT MAX(birthday) AS earliest_birthday,
	MIN(birthday) AS latest_birthday
FROM customers;

-- Segments the customers according to generations using the birthday dates
-- counts the number of customers per generation 
-- The customers are categorized into 6 generations: Greatest generation, Silent generation, Baby boomers, Generation X, Millenials and Generation Z
-- Baby boomers ordered the most (3160), followed by Gen_x (2643), then millenials (2635), then Silent gen(1765), then Gen_z (833)
-- The greatest generation has no customers

SELECT * FROM customers;

SELECT COUNT(customer_key) AS total,
	SUM(CASE WHEN birthday > '1934-12-31' AND birthday <= '1927-12-31' THEN 1 ELSE 0 END) AS Greatest_Gen,
	SUM(CASE WHEN birthday > '1927-12-31' AND birthday <= '1945-12-31' THEN 1 ELSE 0 END) AS Silent_Gen,
	SUM(CASE WHEN birthday > '1945-12-31' AND birthday <= ' 1964-12-31' THEN 1 ELSE 0 END) AS Baby_Boomers,
	SUM(CASE WHEN birthday > '1964-12-31' AND birthday <= '1980-12-31' THEN 1 ELSE 0 END) AS Gen_x,
	SUM(CASE WHEN birthday > '1980-12-31' AND birthday <= '1996-12-31' THEN 1 ELSE 0 END) AS millenials,
	SUM(CASE WHEN birthday > '1996-12-31' AND birthday <= '2012-12-31' THEN 1 ELSE 0 END) AS Gen_Z
FROM customers;

-- Returns the percentage of customers per generation
-- Baby boomers (28.63%), Gen_x (23.95%), Millenials (23.88%), Silent Generation (15.99%), Generation_Z (7.55%), Greatest_generation (0%)

WITH CTE1 AS(
	SELECT COUNT(customer_key) AS total,
	SUM(CASE WHEN birthday > '1934-12-31' AND birthday <= '1927-12-31' THEN 1 ELSE 0 END) AS Greatest_Gen,
	SUM(CASE WHEN birthday > '1927-12-31' AND birthday <= '1945-12-31' THEN 1 ELSE 0 END) AS Silent_Gen,
	SUM(CASE WHEN birthday > '1945-12-31' AND birthday <= ' 1964-12-31' THEN 1 ELSE 0 END) AS Baby_Boomers,
	SUM(CASE WHEN birthday > '1964-12-31' AND birthday <= '1980-12-31' THEN 1 ELSE 0 END) AS Gen_x,
	SUM(CASE WHEN birthday > '1980-12-31' AND birthday <= '1996-12-31' THEN 1 ELSE 0 END) AS millenials,
	SUM(CASE WHEN birthday > '1996-12-31' AND birthday <= '2012-12-31' THEN 1 ELSE 0 END) AS Gen_Z
FROM customers)

SELECT total,
	ROUND(((Greatest_Gen/total)*100),2) AS Greatest_Gen,
    ROUND(((Silent_Gen/total)*100),2) AS Silent_Gen,
    ROUND(((Baby_Boomers/total)*100),2) AS Baby_Boomers,
    ROUND(((Gen_x/total)*100),2) AS Gen_X,
    ROUND(((millenials/total)*100),2) AS Millenials,
    ROUND(((Gen_Z/total)*100),2) AS Gen_Z
FROM CTE1;


-- Returns first order date, last order date and the total number of orders per customer over the years
-- The most number of orders is 36 while the least number of orders is 1

SELECT * FROM customers;

WITH order_num AS (
SELECT c.Customer_Key,
	c.name,
	c.gender,
	s.Order_Date,
    s.Product_Key,
    p.Product_Name,
    s.quantity,
    c.state,
    p.category,
    p.sub_category,
    c.Country,
    c.continent,
    p.Unit_Cost_USD,
    p.Unit_Price_USD,
    p.brand
FROM customers c
JOIN sales s
ON c.customer_key = s.customer_key
JOIN products p
ON p.Product_Key = s.Product_Key)

SELECT customer_key,
	`name`,
    gender,
    MIN(order_date) AS first_order_date,
	MAX(order_date) AS last_order_date,
    SUM(CASE WHEN order_date IS NOT NULL OR order_date != 0 THEN 1 ELSE 0 END) AS total_orders
FROM order_num 
GROUP BY customer_key, `name`, gender
ORDER BY total_orders desc;

-- Returns the total number of orders per year for each customer

WITH order_per_year AS (
SELECT c.Customer_Key,
	c.Name,
	c.gender,
	s.Order_Date,
    s.Product_Key,
    p.Product_Name,
    s.quantity,
    c.state,
    p.category,
    p.sub_category,
    c.Country,
    c.continent,
    p.Unit_Cost_USD,
    p.Unit_Price_USD,
    p.brand,
    YEAR(order_date)order_year,
    MONTH(order_date) AS order_month,
    CONCAT('Q', QUARTER(order_date)) AS formatted_quarter
FROM customers c
JOIN sales s
ON c.customer_key = s.customer_key
JOIN products p
ON p.Product_Key = s.Product_Key)

SELECT customer_key,
	Name,
    gender,
    order_date,
    SUM(CASE WHEN order_date IS NOT NULL AND (order_year = 2016) THEN 1 ELSE 0 END) AS total_orders_2016,
    SUM(CASE WHEN order_date IS NOT NULL AND (order_year = 2017) THEN 1 ELSE 0 END) AS total_orders_2017,
    SUM(CASE WHEN order_date IS NOT NULL AND (order_year = 2018) THEN 1 ELSE 0 END) AS total_orders_2018,
    SUM(CASE WHEN order_date IS NOT NULL AND (order_year = 2019) THEN 1 ELSE 0 END) AS total_orders_2019,
    SUM(CASE WHEN order_date IS NOT NULL AND (order_year = 2020) THEN 1 ELSE 0 END) AS total_orders_2020,
    SUM(CASE WHEN order_date IS NOT NULL AND (order_year = 2021) THEN 1 ELSE 0 END) AS total_orders_2021
FROM order_per_year
GROUP BY customer_key, Name, gender,order_date
ORDER BY order_date,customer_key;

