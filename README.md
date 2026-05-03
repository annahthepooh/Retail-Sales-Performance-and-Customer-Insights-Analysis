# Global_Electronic_retailer_analysis

## Executive Summary
This project analyzes online electronic retail shop dataset by grouping customers into 4 segments using **Recency, Frequency & Monetary Analysis**. By investigating how **age, location and product categories** influence performance, I identified specific insights and provided actionable recommendations aimed at increasing sales and order volume by **20%**.


## The Workflow 
### Data Cleaning & Preparation (SQL)
* **Data Quality-** Standardized columns for binary analysis using `UPDATE` and handled missing values using `ALTER`.
* **RFM Modelling-** Built a segmentation Model to group the customers into **Champions, Loyalist, At Risk** and **Hibernating/Lost**.
* **Metric Calculation-** Utilized **Chaining CTEs, JOINS** and **Aggregations** to calculate **AOV, Total Segment Revenue, Customer Count** and **Contribution Percentage**.
* **Generational Analysis-** Incorporate **CASE Statements** to investigate the relationship between Sales Performance and Age Demographics.

## 2. Business Questions
* **Age Based Segmentation:** Does Age significantly affect sales performance?
* **Regional Trends:** Which continents are most concentrated in specific segments?
* **Category Analysis:** Which product categories are ordered most frequently within each segment? 


## Key Insights 
* **The Age Influence:** Older generations are more likely to order than younger ones. **Baby Boomers** represent the largest customer base (**28.65%**) while **Generation Z** is the smallest (**7.55%**) 
* **Locational Analysis:** **North America** dominates with (**61.87%**) of total orders, followed by **Europe** (**25.26%**) while **Australia** represents the smallest market(**12.87%**)
* **Product Category Performance** **Computers** are the top selling category with a total of **10577** orders overall, followed by **Cell Phones** (**6715**) followed by **Music,Movies & Audio Books** (**6800**)


## Final Recommendations
 1.	**Generational marketing:** Tailor messaging and marketing channels to resonate with specific values and behaviors of Generation Z and Generation X to raise order count hence increase sales performance 
* 2. **Inventory Optimization:** 
* Increase restock by 50% for high demand categories:**Computers,Cell Phones** and **Music, Movies and Audio Books**
* Reduce and restock by 50% for bottom 5 least ordered categories to free up capital
* 3. **Market Research:** Deploy targeted Surveys in **Australia and Europe** to identify local loopholes and gain insights into boosting sales performance in those regions.


