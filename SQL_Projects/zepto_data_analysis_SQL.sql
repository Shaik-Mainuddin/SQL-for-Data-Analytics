USE zepto_db;

SELECT *
FROM zepto
LIMIT 10;

-- Check NULL values

SELECT *
FROM zepto 
WHERE Category IS NULL 
OR name IS NULL
OR mrp IS NULL
OR discountPercent IS NULL
OR availableQuantity IS NULL
OR discountedSellingPrice IS NULL
OR weightInGms IS NULL
OR outOfStock IS NULL
OR quantity IS NULL;

-- NO NULL values in data

-- Data Exploration

SELECT DISTINCT Category
FROM zepto
ORDER BY 1;

SELECT outOfStock , COUNT(outOfStock)
FROM zepto 
GROUP BY outOfStock;

-- DATA CLEANING

-- Lets adjust 'mrp' and 'discountedSellingPrice' where it is in paise

SELECT *
FROM zepto;

UPDATE zepto 
SET mrp = mrp/100.0;

UPDATE zepto 
SET discountedSellingPrice = discountedSellingPrice/100.0;

-- Lets see where 'mrp' or 'discountedSellingPrice' is '0.0'

SELECT *
FROM zepto 
WHERE mrp = 0 
OR discountedSellingPrice = 0;

DELETE
FROM zepto 
WHERE mrp = 0;

SELECT *
FROM zepto;

-- data analysis

-- Q1. Find the top 10 best-value products based on the discount percentage.

SELECT DISTINCT name,mrp,discountPercent
FROM zepto 
ORDER BY discountPercent DESC
LIMIT 10;

-- Q2.What are the Products with High MRP but Out of Stock

SELECT name,mrp
FROM zepto 
WHERE mrp >= 300 AND outOfStock = 'True'
LIMIT 10;

-- Q3.Calculate Estimated Revenue for each category

SELECT Category,
SUM(discountedSellingPrice * availableQuantity) AS total_revenue
FROM zepto
GROUP BY Category
ORDER BY total_revenue DESC ;

-- Q4. Find all products where MRP is greater than ₹500 and discount is less than 10%.

SELECT DISTINCT name,mrp,discountPercent
FROM zepto 
WHERE mrp >= 500 AND discountPercent <= 10
ORDER BY mrp DESC;

-- Q5. Identify the top 5 categories offering the highest average discount percentage.

SELECT Category,
ROUND(AVG(discountPercent),2) AS avg_discount
FROM zepto 
GROUP BY Category
ORDER BY avg_discount DESC
LIMIT 5;

-- Q6. Find the price per gram for products above 100g and sort by best value.

SELECT DISTINCT name,weightInGms,discountedSellingPrice,
ROUND(discountedSellingPrice/weightInGms) AS price_per_gram
FROM zepto 
WHERE weightInGms >= 100
ORDER BY price_per_gram DESC;

-- Q7.Group the products into categories like Low, Medium, Bulk.

SELECT MAX(quantity),MIN(quantity)
FROM zepto;

SELECT DISTINCT name,quantity,
CASE
	WHEN quantity <= 100 THEN 'LOW'
	WHEN quantity > 100 AND quantity <= 500 THEN 'MEDIUM'
    WHEN quantity > 500 THEN 'BULK'
END AS quantityStatus
FROM zepto 
ORDER BY quantity DESC;

-- Q8.What is the Total Inventory Weight Per Category 

SELECT Category,
SUM(weightInGms * availableQuantity) AS Total_Weight
FROM zepto 
GROUP BY Category
ORDER BY Total_Weight DESC;
