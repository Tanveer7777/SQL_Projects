-- SQL Retail Sales Analysis
CREATE DATABASE sql_project_p1;

-- create table
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
     (
     transactions_id INT PRIMARY KEY,
	 sale_date DATE,
	 sale_time TIME,
	 customer_id INT,
	 gender VARCHAR(15),
	 age INT,
	 category VARCHAR(15),
	 quantiy INT,
	 price_per_unit FLOAT,
	 cogs FLOAT,
	 total_sale FLOAT
	 );

SELECT * FROM retail_sales

select count(*) from retail_sales

-- Cleaning data

--checking null values
SELECT * FROM retail_sales 
WHERE 
     transactions_id IS NULL
	 OR
	 sale_date IS NULL
	 OR
	 sale_time IS NULL
	 OR
	 customer_id IS NULL
	 OR
     age IS NULL
	 OR
	 category IS NULL
	 OR
	 quantiy IS NULL
	 OR
	 price_per_unit IS NULL
	 OR
	 cogs IS NULL
	 OR
	 total_sale IS NULL;

-- deleting null values
DELETE FROM retail_sales 
WHERE 
     transactions_id IS NULL
	 OR
	 sale_date IS NULL
	 OR
	 sale_time IS NULL
	 OR
	 customer_id IS NULL
	 OR
     age IS NULL
	 OR
	 category IS NULL
	 OR
	 quantiy IS NULL
	 OR
	 price_per_unit IS NULL
	 OR
	 cogs IS NULL
	 OR
	 total_sale IS NULL;

--data exploration

--how many sales we have ?
SELECT COUNT(*) as total_sales FROM retail_sales

--how many unique customer we have?
SELECT COUNT(DISTINCT customer_id) as Total_Customer FROM retail_sales

--how many categories we have?
SELECT DISTINCT category as total_categories FROM retail_sales


--Data Analysis and Business problems

--1.Write a SQL query to retrieve all columns for sales made on '2022-11-05:
select * from retail_sales where sale_date='2022-11-05'


--2.Write a SQL query to retrieve all transactions where the category is
--'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
SELECT * FROM retail_sales 
WHERE category='Clothing' AND quantiy>=4 AND sale_date between '2022-11-01' AND '2022-11-30'


--3.Write a SQL query to calculate the total sales (total_sale) for each category:
SELECT category,SUM(total_sale) AS net_sales, COUNT(total_sale) AS Total_orders from retail_sales GROUP BY 1
SELECT 
    category,
    SUM(total_sale) as net_sale,
    COUNT(*) as total_orders
FROM retail_sales
GROUP BY 1


--4.Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category:
SELECT AVG(age) from retail_sales WHERE category='Beauty'


--5.Write a SQL query to find all transactions where the total_sale is greater than 1000.:
SELECT * FROM retail_sales WHERE total_sale>1000


--6.Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
SELECT category,gender,COUNT(transactions_id) FROM retail_sales GROUP BY category,gender ORDER BY 1


--7.Write a SQL query to find the top 5 customers based on the highest total sales:
SELECT customer_id , SUM(total_sale) AS total_sales FROM retail_sales 
GROUP BY 1 ORDER BY 2 DESC LIMIT 5


--8.Write a SQL query to find the number of unique customers who purchased items from each category.:
SELECT category,COUNT(DISTINCT customer_id) FROM retail_sales GROUP BY category


