-- Data_dictionary table

-- Checks for any blank spaces, if any, fill them with the NULL value
-- Modify the column titles to be more readable
-- Check for the data types and change to more suitable ones for this context 

SELECT * FROM global_electronics_retail_shop.data_dictionary;

SELECT DISTINCT `Table`
FROM Data_Dictionary ;

DESCRIBE data_dictionary `Table`;

SELECT `Table`
FROM data_dictionary
WHERE `Table` = '' OR `Table` IS NULL;

DESCRIBE data_dictionary Field;

SELECT Field 
FROM data_dictionary
WHERE Field = '' OR Field IS NULL;

DESCRIBE data_dictionary Description;

SELECT Description
FROM data_dictionary
WHERE Description = '' OR Description IS NULL;


