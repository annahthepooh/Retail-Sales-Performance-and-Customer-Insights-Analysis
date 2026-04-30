-- Stores table

-- Checks for any blank spaces, if any, fill them with the NULL value
-- Modify the column titles to be more readable
-- Check for the data types and change to more suitable ones for this context 

SELECT * FROM global_electronics_retail_shop.stores;

DESCRIBE stores StoreKey;

SELECT StoreKey
FROM stores
WHERE StoreKey = '' OR StoreKey IS NULL;

SELECT COUNT(StoreKey)
FROM stores
GROUP BY StoreKey
HAVING COUNT(StoreKey)>1;

ALTER TABLE stores
CHANGE COLUMN StoreKey Store_Key INT NULL DEFAULT NULL;

DESCRIBE stores country;

SELECT Country
FROM stores
WHERE Country = '' OR Country IS NULL;

DESCRIBE stores state;

SELECT State
FROM stores
WHERE State = '' OR State IS NULL;

DESCRIBE stores `Square Meters`;

SELECT `Square Meters`
FROM stores
WHERE `Square Meters` = '' OR `Square Meters` IS NULL;

ALTER TABLE stores
CHANGE COLUMN `Square Meters` `Square_Meters` INT NULL DEFAULT NULL;

DESCRIBE stores `Open Date`;

SELECT  `Open Date`
FROM stores
WHERE `Open Date` = '' OR `Open Date` IS NULL;

UPDATE stores
SET `Open Date` = STR_TO_DATE(`Open Date`, '%c/%e/%Y');

ALTER TABLE stores
CHANGE COLUMN `Open Date` `Open_Date` DATE;