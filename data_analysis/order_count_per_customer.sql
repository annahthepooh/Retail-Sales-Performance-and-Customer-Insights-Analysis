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