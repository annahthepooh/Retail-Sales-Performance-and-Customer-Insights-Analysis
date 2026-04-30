-- Exchange_rates table

-- Checks for any blank spaces, if any, fill them with the NULL value
-- Modify the column titles to be more readable
-- Check for the data types and change to more suitable ones for this context 

SELECT * FROM global_electronics_retail_shop.exchange_rates;

DESCRIBE exchange_rates `Date`;

SELECT `Date`
FROM exchange_rates
WHERE `Date`= '' OR `Date` IS NULL;

UPDATE exchange_rates
SET `Date` = STR_TO_DATE(`Date`, '%c/%e/%Y');

ALTER TABLE exchange_rates
MODIFY `Date` date;

DESCRIBE exchange_rates currency;

SELECT Currency 
FROM exchange_rates
WHERE currency = '' OR currency IS NULL;

ALTER TABLE exchange_rates
CHANGE COLUMN Currency Currency VARCHAR (14) DEFAULT NULL;

DESCRIBE exchange_rates Exchange;

SELECT Exchange 
FROM exchange_rates
WHERE Exchange = '' OR Exchange IS NULL;
