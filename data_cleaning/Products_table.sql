-- Products table

-- Checks for any blank spaces, if any, fill them with the NULL value
-- Modify the column titles to be more readable
-- Check for the data types and change to more suitable ones for this context 
-- Removes any special letters 

SELECT * FROM global_electronics_retail_shop.products;

DESCRIBE products ProductKey;

SELECT ProductKey
FROM products
WHERE ProductKey = '' OR ProductKey IS NULL;

SELECT ProductKey, COUNT(ProductKey) AS num
FROM products
GROUP BY ProductKey
HAVING COUNT(ProductKey) >1;

DESCRIBE products `Product Name`;

SELECT `Product Name`
FROM products
WHERE `Product Name` = '' OR `Product Name` IS NULL;

ALTER TABLE products
CHANGE COLUMN `Product Name` `Product_Name` TEXT NULL DEFAULT NULL;

DESCRIBE products Brand;

SELECT Brand
FROM products
WHERE Brand = ''  OR Brand IS NULL;

DESCRIBE products Color;

DESCRIBE products `Unit Cost USD`;

SELECT `Unit Cost USD`
FROM products
WHERE `Unit Cost USD` = '' OR `Unit Cost USD` IS NULL;

-- Removes any special letters like '$' and ',' 

UPDATE products 
SET `Unit Cost USD` = REPLACE (`Unit Cost USD` , '$', '');

UPDATE products 
SET `Unit Cost USD` = REPLACE (`Unit Cost USD` , ',', '');

ALTER TABLE products
CHANGE COLUMN `Unit Cost USD` `Unit_Cost_USD` DOUBLE NULL DEFAULT NULL;

DESCRIBE products `Unit Price USD`;

UPDATE products
SET `Unit Price USD`  = REPLACE ( `Unit Price USD`, '$', '');

UPDATE products
SET `Unit Price USD` = REPLACE (`Unit Price USD`, ',','');

ALTER  TABLE products
CHANGE COLUMN `Unit Price USD` `Unit_Price_USD` DOUBLE NULL DEFAULT NULL;

DESCRIBE products SubCategoryKey;

SELECT SubCategoryKey 
FROM products
WHERE SubcategoryKey = 0 OR SubcategoryKey IS NULL;

ALTER TABLE products
CHANGE SubCategoryKey Sub_Category_Key INT NULL DEFAULT NULL;

DESCRIBE products SubCategory;

SELECT SubCategory
FROM products
WHERE SubCategory = '' OR Subcategory IS NULL;

ALTER TABLE products
CHANGE COLUMN SubCategory Sub_Category TEXT NULL DEFAULT NULL;

DESCRIBE products CategoryKey ;

SELECT CategoryKey 
FROM products
WHERE CategoryKey = '' OR CategoryKey IS NULL;

ALTER TABLE products
CHANGE COLUMN CategoryKey Category_Key INT NULL DEFAULT NULL;

SELECT DISTINCT Category
FROM products;

SELECT Category  
FROM products 
WHERE Category = '' OR Category IS NULL;

SELECT Category
FROM products;

SELECT * FROM products;