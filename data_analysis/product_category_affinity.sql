-- This shows which product categories are most bought in which segments 
-- Computers is the most ordered category while TV and Video category is the least ordered category in all the 5 segments

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


SELECT Category,
    SUM(CASE WHEN segment = 'champion' THEN 1 ELSE 0 END) AS champion_count,
    SUM(CASE WHEN segment = 'at risk' THEN 1 ELSE 0 END) AS at_risk_cocunt,
    SUM(CASE WHEN segment = 'Loyalist' THEN 1 ELSE 0 END) AS loyalist_count,
    SUM(CASE WHEN segment = 'hibernating/lost' THEN 1 ELSE 0 END) AS hibernating_count,
    COUNT(*) AS Total_Customers
FROM Segmentation seg
JOIN sales s
ON seg.customer_key = s.customer_key
JOIN products p
ON s.product_key = p.product_key
GROUP BY category
ORDER BY Total_Customers DESC;
