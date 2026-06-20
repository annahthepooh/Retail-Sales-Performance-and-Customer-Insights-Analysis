# Retail Sales Performance and Customer Insights Analysis

## Problem Statement
An online retail store is seeking to better understand it's sales performance, customer behavior and product profitability in order to optimize revenue and improve decision making. This project analyzes transactional data to identify key revenue drivers and customer segments.

## Executive Summary
This project analyzes online electronic retail shop sales data to evaluate overal business performance, product trends and customer behavior. The analysis focuses on customer segmentation patterns, revenue distribution and product category performaance. The findings reveal certain regions and customer groups contribute more to total sales while others show lower engagement and profitability. This aims to  provide specific insights and provide actionable recommendations aimed at increasing sales and order volume by **20%**.

## markdown 
<details>
 ## *Tools & Skills Demonstrated

### SQL
- Data Cleaning
- Data Transformation
- Aggregate Functions
- GROUP BY Analysis
- CASE Statements
- Chaining CTEs
  
<summary><b>Click here to expand the section</b></summary>

### Retail Analytics
- Sales Performance Analysis
- Product Performance Evaluation
- Customer Segmentation
- Revenue Analysis

### Business Skills
- Inventory Optimization
- Market Analysis
- Strategic Recommendations
- Data Storytelling
</details>

## The Workflow 
### Data Cleaning & Preparation (SQL)
* **Data Quality-** Standardized columns for binary analysis using `UPDATE` and handled missing values using `ALTER`.
* **RFM Modelling-** Built a segmentation Model to group the customers into **Champions, Loyalist, At Risk** and **Hibernating/Lost**.
* **Metric Calculation-** Utilized **Chaining CTEs, JOINS** and **Aggregations** to calculate **Average Order Value, Total Segment Revenue, Customer Count** and **Contribution Percentage**.
* **Generational Analysis-** Incorporate **CASE Statements** to investigate the relationship between Sales Performance and Age Demographics.
* **SQL scripts used for data cleaning and preparation are available in the *data cleaning* folder**


## Key Insights 
* **The Age Influence:** Older generations are more likely to order than younger ones. **Baby Boomers** represent the largest customer base (**28.65%**) while **Generation Z** is the smallest (**7.55%**) 
* **Locational Analysis:** **North America** dominates with (**61.87%**) of total orders, followed by **Europe** (**25.26%**) while **Australia** represents the smallest market(**12.87%**)
* **Product Category Performance** **Computers** are the top selling category with a total of **10577** orders overall, followed by **Cell Phones** (**6715**) followed by **Music,Movies & Audio Books** (**6800**)


## Final Recommendations
 1.	Implement **Generational Marketing Strategy** by tailoring messaging, content and marketing channels to the preference of **Generation Z** and **Generation X** in order to improve customer engagememnt and increase order frequency
* 2. Optimize inventory allocation by **increasing stock levels by 50% for high demand categories** such as **Computers**,**Cell Phones** and **Music, Movies and Audio Books** to prevent stockouts and maximize sales opportunities
* 3. **Reduce inventory allocation by 50% for bottom 5 least ordered categories** to minimize holding costs and improve capital efficiency
* 4. **Conduct Targeted Market Research** in **Australia** and **Europe** to identify regional customer preference, demand gaps and barriers to purchase to inform localized marketing and sales strategies.


