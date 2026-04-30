-- This shows which generation the customers belong to and who are the most and least
-- Most customers are baby boomers while the least number is from Generation Z. The greatest generation has 0(zero) customers


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

SELECT Segment,
	SUM(CASE WHEN birthday > '1934-12-31' AND birthday <= '1927-12-31' THEN 1 ELSE 0 END) AS Greatest_Gen,
	SUM(CASE WHEN birthday > '1927-12-31' AND birthday <= '1945-12-31' THEN 1 ELSE 0 END) AS Silent_Gen,
	SUM(CASE WHEN birthday > '1945-12-31' AND birthday <= ' 1964-12-31' THEN 1 ELSE 0 END) AS Baby_Boomers,
	SUM(CASE WHEN birthday > '1964-12-31' AND birthday <= '1980-12-31' THEN 1 ELSE 0 END) AS Gen_x,
	SUM(CASE WHEN birthday > '1980-12-31' AND birthday <= '1996-12-31' THEN 1 ELSE 0 END) AS millenials,
	SUM(CASE WHEN birthday > '1996-12-31' AND birthday <= '2012-12-31' THEN 1 ELSE 0 END) AS Gen_Z
FROM Segmentation seg
JOIN customers c ON seg.customer_key = c.customer_key
GROUP BY segment;
