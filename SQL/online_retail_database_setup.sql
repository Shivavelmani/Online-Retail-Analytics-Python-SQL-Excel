-- Step 1. Database Setup for Online_Retail Analysis

CREATE DATABASE IF NOT EXISTS retail_online;
USE retail_online;

DROP TABLE IF EXISTS delivered_products;
CREATE TABLE delivered_products
(
invoice VARCHAR(255),
stockcode VARCHAR(255),
product_description VARCHAR(255),
quantity DOUBLE,
unit_price DOUBLE,
total_revenue DOUBLE,
country VARCHAR(255),
customer_id VARCHAR(255),
invoice_date DATE
);

-- Step 2: Load Data

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/delivered_products.csv'
INTO TABLE delivered_products
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

-- Disable safe mode 
SET SQL_SAFE_UPDATES = 0;

-- After loading CSV, convert empty strings to NULL
UPDATE delivered_products
SET customer_id = NULL
WHERE customer_id = '' OR TRIM(customer_id) = '';

-- Re-enable safe mode
SET SQL_SAFE_UPDATES = 1;

-- Verify for 1,025,251 total rows
SELECT COUNT(*) as total_rows FROM delivered_products;
