-- customers table 

SELECT * FROM global_electronics_retail_shop.customers;

-- Checks for any blank spaces, if any, fill them with the NULL value
-- Modify the column titles to be more readable
-- Check for the data types and change to more suitable ones for this context 

DESCRIBE customers `CustomerKey`;

SELECT CustomerKey
FROM customers
WHERE CustomerKey = '' OR CustomerKey IS NULL;

SELECT COUNT(*) FROM customers;

ALTER TABLE customers
CHANGE COLUMN CustomerKey `Customer_Key`INT NULL DEFAULT NULL;

DESCRIBE customers Gender;

SELECT Gender
FROM customers
WHERE Gender = '' OR Gender IS NULL;

ALTER TABLE customers
CHANGE COLUMN Gender Gender VARCHAR (14) NULL DEFAULT NULL;


SELECT Customer_Key,Gender, ROW_NUMBER() OVER(PARTITION BY Customer_Key ORDER BY Customer_Key) as Num
FROM customers
GROUP BY Customer_Key, Gender;

DESCRIBE customers Name;

SELECT Name 
FROM Customers
WHERE Name = '' OR Name IS NULL;

DESCRIBE customers City;

SELECT City
FROM Customers
WHERE City = '' OR City IS NULL;

SELECT DISTINCT City
FROM Customers
ORDER BY City;

DESCRIBE customers `State Code`;

SELECT `State Code`
FROM customers
WHERE `State Code` = '' OR `State Code` IS NULL;

ALTER TABLE customers
CHANGE COLUMN `State Code` `State_Code` VARCHAR (14) NULL DEFAULT NULL;

DESCRIBE customers State_Code;

DESCRIBE customers State;

SELECT State
FROM customers
WHERE State = '' OR State IS NULL;

SELECT State, ROW_NUMBER() OVER(PARTITION BY State ORDER  BY State) AS Index_number
FROM customers
GROUP BY State
HAVING State > 2;

DESCRIBE customers `Zip Code`;

SELECT `Zip Code`
FROM customers
WHERE `Zip Code` = 0 OR `Zip Code` IS NULL;

ALTER TABLE customers
CHANGE COLUMN `Zip Code` `Zip_Code` INT NULL DEFAULT NULL;

SELECT * FROM customers;

DESCRIBE customers Country;

SELECT Country 
FROM customers
WHERE Country = '' OR Country IS NULL;

SELECT DISTINCT Country
FROM customers;

SELECT DISTINCT Continent
FROM customers;

SELECT Continent
FROM customers
WHERE Continent = '' OR Continent IS NULL;

DESCRIBE customers Continent;

DESCRIBE customers Birthday;

UPDATE customers
SET Birthday = STR_TO_DATE (Birthday,'%c/%e/%Y');

ALTER TABLE customers
MODIFY Birthday DATE ;

DESCRIBE customers Birthday;

