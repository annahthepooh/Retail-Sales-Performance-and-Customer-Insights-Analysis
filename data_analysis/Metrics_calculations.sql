-- Returns the segments, number of customers, segment_revenue, Average Order Value(AOV) and the contribution percent per segment
-- Used correlated CTEs for calculation
-- The  highest AOV is from 'At Risk' segment, (717.06) while the lowest is from 'Champions' segment (634.64)
-- Champions segment has the highest contribution percentage(38.25%) followed by Loyalist segment(24.7%) while At Risk segment has the lowest (18.5%), followed closely by Hibernating/Lost segment(18.55%)
-- Most customers are categorized under the hibernating segment(3442), followed by champions(1988), then loyalists(1811) then At risk segment comes last((1363)


SELECT * FROM customers;

SELECT DISTINCT COUNT(*) FROM customers;


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
	COUNT(customer_key) AS customer_count,
    ROUND(SUM(monetary_value),2) AS total_segment_revenue,
    ROUND(AVG(monetary_value/frequency_value),2) AS Average_Order_Value,
    ROUND((SUM(monetary_value))/SUM(SUM(monetary_value)) OVER()*100,2) AS contribution_percent
FROM Segmentation
GROUP BY segment
ORDER BY total_segment_revenue DESC;