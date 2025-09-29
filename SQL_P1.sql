SELECT current_database();

SELECT table_schema, table_name 
FROM information_schema.tables 
WHERE table_schema='public';

SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name='retail_sales'
ORDER BY ordinal_position;

SELECT COUNT(*) FROM public.retail_sales;

SELECT * FROM public.retail_sales LIMIT 10;

---data cleaning--

SELECT* FROM retail_saleS
WHERE 
transactions_id is NULL
OR
 sale_date is NULL
 OR
 sale_time is NULL
 OR
 customer_id is NULL
 OR
 gender is NULL
 OR
 age is NULL
 OR
 category is NULL
 OR
 quantiy is NULL
 OR
 price_per_unit is NULL
 OR
cogs is NULL
OR
 total_sale is NULL
 
delete from retail_sales
WHERE 
transactions_id is NULL
OR
 sale_date is NULL
 OR
 sale_time is NULL
 OR
 customer_id is NULL
 OR
 gender is NULL
 OR
 age is NULL
 OR
 category is NULL
 OR
 quantiy is NULL
 OR
 price_per_unit is NULL
 OR
cogs is NULL
OR
 total_sale is NULL
 --Data Exploration--
 --how many sales we have?--
 
 SELECT COUNT (*) AS total_sale FROM  retail_sales

 --how many customerswe have?--
  SELECT COUNT (DISTINCT customer_id) AS  total_sale  FROM  retail_sales

  --data analysis and bisuness key problems and answers--
  
  --QUE:Write a sql query to retrieve all columns for sales on 2022-11-05--

  SELECT*
  FROM retail_sales
  WHERE sale_date='2022-11-05';

  --QUE: Write a sql query to retrieve all transactions where the category is'Clothing'and the quality sold is more than 10 in the month of Nov-2022--
 
  SELECT*
  FROM retail_sales
	WHERE category = 'Clothing'
	AND
	   TO_CHAR(sale_date,'YYYY-MM')='2022-11'
	GROUP BY 1

--QUE:Write the sql query to calculate a total sales(total_sale)for each category--
   SELECT  
   category,
   SUM(total_sale)AS net_sale
   FROM  retail_sales
   GROUP BY 1

--QUE:Write the sql query to find average age of cutomers who purchased item from the 'Beauty'category
	SELECT
	ROUND(AVG(age),2)AS avg_age
	 FROM retail_sales
     WHERE category = 'Beauty'
	 
--QUE:Write the sql query to find all transactions where the total_sale is greater than 1000--
  SELECT*
  FROM retail_sales
  WHERE total_sale > 1000
  
 --QUE:Write the sql query to find total number oftransactions(transaction_id)made by each gender in each category--
 SELECT  
   category,
   gender,
   COUNT(*)AS total_trans
   FROM retail_sales
   GROUP BY
   category,
   gender
   
--QUE:Write the sql query to calculate the Average sale for each month.find out besrt selling month in each year
 SELECT*FROM
(
 SELECT
  EXTRACT(YEAR FROM sale_date) AS YEAR,
   EXTRACT(MONTH FROM sale_date) AS MONTH,
   AVG(total_sale)as avg_sale,
   RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date)ORDER BY AVG(total_sale)DESC)AS RANK
   FROM retail_sales
   GROUP BY 1,2
 )AS t1
 WHERE RANK=1
  -- ORDER BY 1,2,3 DESC
   
 