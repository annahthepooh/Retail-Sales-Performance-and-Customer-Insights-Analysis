-- Sales table

-- Checks for any blank spaces, if any, fill them with the NULL value
-- Modify the column titles to be more readable
-- Check for the data types and change to more suitable ones for this context 

SELECT * FROM global_electronics_retail_shop.sales;

SELECT * FROM global_electronics_retail_shop.sales;

DESCRIBE sales `Order Number`;

SELECT `Order Number`
FROM sales
WHERE `Order Number` = '' OR `Order Number` IS NULL;

ALTER TABLE sales
CHANGE COLUMN `Order Number` `Order_Number` INT NULL DEFAULT NULL;

DESCRIBE sales `Line Item`; 

SELECT `Line Item`
FROM sales
WHERE `Line Item` = '' OR `Line Item` IS NULL;

ALTER TABLE sales
CHANGE COLUMN `Line Item` `Line_Item` INT NULL DEFAULT NULL;

DESCRIBE sales `Order Date`;

SELECT `Order Date`
FROM sales
WHERE `Order Date` = '' OR `Order Date` IS NULL;

-- Uses '%c/%e/%Y' instead of '%m/%d/%Y' because some of the day and month values are not 2 digits, like in the format, they are 1 digit

UPDATE sales
SET `Order Date` = STR_TO_DATE(`Order Date` ,'%c/%e/%Y');

ALTER TABLE sales
CHANGE COLUMN `Order Date` `Order_Date` DATE;

DESCRIBE sales `Delivery Date`;

SELECT `Delivery Date`
FROM sales
WHERE `Delivery Date` = '' ;

UPDATE sales
SET `Delivery Date` = NULL 
WHERE `Delivery Date` = '';

UPDATE sales
SET `Delivery Date` = STR_TO_DATE(`Delivery Date`,'%c/%e/%Y');

ALTER TABLE sales
CHANGE COLUMN `Delivery Date` `Delivery_Date` DATE;

DESCRIBE sales CustomerKey;

SELECT CustomerKey
FROM sales
WHERE CustomerKey = '' OR CustomerKey IS NULL;

ALTER TABLE sales
CHANGE COLUMN CustomerKey Customer_Key INT NULL DEFAULT NULL; 

DESCRIBE sales StoreKey;

SELECT StoreKey 
FROM sales
WHERE StoreKey = '' OR StoreKey IS NULL;

ALTER TABLE sales 
CHANGE COLUMN StoreKey Store_Key INT NULL DEFAULT NULL;

DESCRIBE sales ProductKey;

SELECT ProductKey
FROM sales 
WHERE ProductKey = '' OR ProductKey IS NULL;

ALTER TABLE sales
CHANGE COLUMN ProductKey Product_Key INT NULL DEFAULT NULL;

DESCRIBE sales Quantity;

SELECT Quantity
FROM sales
WHERE Quantity = '' OR Quantity IS NULL;

DESCRIBE sales `Currency Code`;

SELECT `Currency Code`
FROM sales
WHERE `Currency Code` = '' OR `Currency Code` IS NULL;

ALTER TABLE sales
CHANGE COLUMN `Currency Code` `Currency_Code` TEXT NULL DEFAULT NULL;

SELECT * FROM sales;

SELECT MAX(order_date), MIN(order_date),MAX(delivery_date)
FROM sales
LIMIT 1;

