-- Returns the day since last order(Recency), total number of orders per customer(Frequency) and the total sales per customer(Monetary)
-- Returns the R, F and M scores 
-- Join the scores to get the RFM codes used in segmentation
-- Creates a temporary table to join the customers, products and sales tables then use a CTE that is dependent on the temporary table to return the RFM codes and scores 

CREATE TEMPORARY TABLE RFM_table AS(
SELECT c.Customer_Key,
	c.Name,
	c.gender,
	s.Order_Date,
    s.delivery_date,
    s.order_number,
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
ON p.Product_Key = s.Product_Key);

WITH RFM_Scoring AS (
SELECT customer_key,
	Name,
    order_number,
    product_name,
    product_key,
    quantity,
    unit_cost_USD,
    unit_price_USD,
    order_date,
    delivery_date,
    brand,
    DATEDIFF('2021-03-31', MAX(order_date)) AS Recency_value,
    COUNT(order_number) OVER(PARTITION BY customer_key ORDER BY order_number) AS Frequency_value,
    ROUND(SUM(unit_price_USD*quantity) OVER(PARTITION BY customer_key ORDER BY order_number),2) AS Monetary_value
FROM RFM_table
GROUP BY customer_key,
	Name,
    order_number,
    product_name,
    product_key,
    quantity,
    unit_cost_USD,
    unit_price_USD,
    order_date,
    delivery_date,
    brand)
    
SELECT customer_key,
	Name,
	Order_Date,
    delivery_date,
    order_number,
    Product_Key,
    quantity,
    Unit_Cost_USD,
    Unit_Price_USD,
    Recency_value,
    Frequency_value,
    Monetary_value,
	NTILE(5) OVER(PARTITION BY Recency_value ORDER BY Recency_value DESC) AS R_score,
    NTILE(5) OVER(PARTITION BY Frequency_value ORDER BY Frequency_value) AS F_score,
    Ntile(5) OVER(PARTITION BY Monetary_value ORDER BY Monetary_value) AS M_score,
    
    CONCAT((NTILE(5) OVER(PARTITION BY Recency_value ORDER BY Recency_value DESC)),
		(NTILE(5) OVER(PARTITION BY Frequency_value ORDER BY Frequency_value)),
        (NTILE(5) OVER(PARTITION BY Monetary_value ORDER BY Monetary_value))) AS RFM_Code
FROM RFM_scoring
GROUP BY customer_key,
	Name,
	Order_Date,
    delivery_date,
    order_number,
    Product_Key,
    quantity,
    Unit_Cost_USD,
    Unit_Price_USD,
    Recency_value,
    Frequency_value,
    Monetary_value
ORDER BY R_score DESC,
    F_Score,
    M_score;