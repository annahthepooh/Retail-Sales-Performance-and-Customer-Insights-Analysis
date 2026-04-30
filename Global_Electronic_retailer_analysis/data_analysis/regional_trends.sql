-- This shows which countries are most concentrated in which segments
-- Most customers order from North America, followed by Europe then Australia
-- California state has the most number of customer count followed by Texas 
-- The United States has the most customer count followed by Germany, Australia then Italy. France comes last 


SELECT * FROM customers;

WITH customer_metrics AS(
SELECT c.customer_key,
    DATEDIFF('2021-12-31', MAX(order_date)) AS Recency_value,
    COUNT(DISTINCT order_number) AS Frequency_value,
    ROUND(SUM(unit_price_USD),2) AS Monetary_value
FROM customers c
JOIN sales s
ON c.Customer_Key = s.Customer_Key
JOIN products p
ON s.Product_Key = p.Product_Key
GROUP BY customer_key),
   
RFM_scores AS(
SELECT Customer_key,
	Recency_value,
    Frequency_value,
    Monetary_value,
    NTILE(5) OVER(ORDER BY Recency_value DESC) AS R_score,
    NTILE(5) OVER(ORDER BY Frequency_value ASC) AS F_score,
    NTILE(5) OVER(ORDER BY Monetary_value ASC) AS M_score,
    CONCAT((NTILE(5) OVER(ORDER BY Recency_value DESC)),
		(NTILE(5) OVER(ORDER BY Frequency_value ASC)),
		(NTILE(5) OVER(ORDER BY Monetary_value ASC))) AS RFM_code
FROM customer_metrics),
    
Segmentation AS (
SELECT customer_key,
    Frequency_value,
    Monetary_value,
    R_score,
    F_score,
    M_score,
    RFM_code,
	CASE WHEN R_score >= 4 AND F_score >= 4 THEN 'Champion'
		WHEN R_score >= 3 AND F_score >= 3 THEN 'Loyalist'
		WHEN R_score <= 2 AND F_score >= 3 THEN 'At Risk' ELSE 'Hibernating/Lost' END AS Segment
FROM RFM_scores)


SELECT c.country,
    SUM(CASE WHEN segment = 'champion' THEN 1 ELSE 0 END) AS champion_count,
    SUM(CASE WHEN segment = 'at risk' THEN 1 ELSE 0 END) AS at_risk_cocunt,
    SUM(CASE WHEN segment = 'Loyalist' THEN 1 ELSE 0 END) AS loyalist_count,
    SUM(CASE WHEN segment = 'hibernating/lost' THEN 1 ELSE 0 END) AS hibernating_count,
    COUNT(*) AS Total_Customers
FROM Segmentation seg
JOIN customers c
ON seg.customer_key = c.customer_key
GROUP BY country
ORDER BY Total_Customers DESC;


WITH customer_metrics AS(
SELECT c.customer_key,
    DATEDIFF('2021-12-31', MAX(order_date)) AS Recency_value,
    COUNT(DISTINCT order_number) AS Frequency_value,
    ROUND(SUM(unit_price_USD),2) AS Monetary_value
FROM customers c
JOIN sales s
ON c.Customer_Key = s.Customer_Key
JOIN products p
ON s.Product_Key = p.Product_Key
GROUP BY customer_key),
   
RFM_scores AS(
SELECT Customer_key,
	Recency_value,
    Frequency_value,
    Monetary_value,
    NTILE(5) OVER(ORDER BY Recency_value DESC) AS R_score,
    NTILE(5) OVER(ORDER BY Frequency_value ASC) AS F_score,
    NTILE(5) OVER(ORDER BY Monetary_value ASC) AS M_score,
    CONCAT((NTILE(5) OVER(ORDER BY Recency_value DESC)),
		(NTILE(5) OVER(ORDER BY Frequency_value ASC)),
		(NTILE(5) OVER(ORDER BY Monetary_value ASC))) AS RFM_code
FROM customer_metrics),
    
Segmentation AS (
SELECT customer_key,
    Frequency_value,
    Monetary_value,
    R_score,
    F_score,
    M_score,
    RFM_code,
	CASE WHEN R_score >= 4 AND F_score >= 4 THEN 'Champion'
		WHEN R_score >= 3 AND F_score >= 3 THEN 'Loyalist'
		WHEN R_score <= 2 AND F_score >= 3 THEN 'At Risk' ELSE 'Hibernating/Lost' END AS Segment
FROM RFM_scores)


SELECT c.State,
    SUM(CASE WHEN segment = 'champion' THEN 1 ELSE 0 END) AS champion_count,
    SUM(CASE WHEN segment = 'at risk' THEN 1 ELSE 0 END) AS at_risk_cocunt,
    SUM(CASE WHEN segment = 'Loyalist' THEN 1 ELSE 0 END) AS loyalist_count,
    SUM(CASE WHEN segment = 'hibernating/lost' THEN 1 ELSE 0 END) AS hibernating_count,
    COUNT(*) AS Total_Customers
FROM Segmentation seg
JOIN customers c
ON seg.customer_key = c.customer_key
GROUP BY State
ORDER BY Total_Customers DESC;

WITH customer_metrics AS(
SELECT c.customer_key,
    DATEDIFF('2021-12-31', MAX(order_date)) AS Recency_value,
    COUNT(DISTINCT order_number) AS Frequency_value,
    ROUND(SUM(unit_price_USD),2) AS Monetary_value
FROM customers c
JOIN sales s
ON c.Customer_Key = s.Customer_Key
JOIN products p
ON s.Product_Key = p.Product_Key
GROUP BY customer_key),
   
RFM_scores AS(
SELECT Customer_key,
	Recency_value,
    Frequency_value,
    Monetary_value,
    NTILE(5) OVER(ORDER BY Recency_value DESC) AS R_score,
    NTILE(5) OVER(ORDER BY Frequency_value ASC) AS F_score,
    NTILE(5) OVER(ORDER BY Monetary_value ASC) AS M_score,
    CONCAT((NTILE(5) OVER(ORDER BY Recency_value DESC)),
		(NTILE(5) OVER(ORDER BY Frequency_value ASC)),
		(NTILE(5) OVER(ORDER BY Monetary_value ASC))) AS RFM_code
FROM customer_metrics),
    
Segmentation AS (
SELECT customer_key,
    Frequency_value,
    Monetary_value,
    R_score,
    F_score,
    M_score,
    RFM_code,
	CASE WHEN R_score >= 4 AND F_score >= 4 THEN 'Champion'
		WHEN R_score >= 3 AND F_score >= 3 THEN 'Loyalist'
		WHEN R_score <= 2 AND F_score >= 3 THEN 'At Risk' ELSE 'Hibernating/Lost' END AS Segment
FROM RFM_scores)


SELECT c.continent,
    SUM(CASE WHEN segment = 'champion' THEN 1 ELSE 0 END) AS champion_count,
    SUM(CASE WHEN segment = 'at risk' THEN 1 ELSE 0 END) AS at_risk_cocunt,
    SUM(CASE WHEN segment = 'Loyalist' THEN 1 ELSE 0 END) AS loyalist_count,
    SUM(CASE WHEN segment = 'hibernating/lost' THEN 1 ELSE 0 END) AS hibernating_count,
    COUNT(*) AS Total_Customers
FROM Segmentation seg
JOIN customers c
ON seg.customer_key = c.customer_key
GROUP BY continent
ORDER BY Total_Customers DESC;

