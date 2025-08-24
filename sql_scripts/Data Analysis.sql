--Data Analysis

--1. What are the top 5 most selling products by quantity?
Select  top 5 product_name, sum(quantity) as total_quantity_sold from store
where status='delivered'
group by product_name
order by sum(quantity) desc;

--Business Problem: We don't know which products are most in demand.
--Business Impact: Helps prioritize stock and boost sales through targeted promotions.


--2. Which products are most frequently cancelled?
select top 5 product_name,count(*) as total_cancelled from store
where status = 'cancelled'
group by product_name
order by total_cancelled desc;

--Business Problem: Frequent cancellations affect revenue and customer trust.
--Business Impact: Identify poor-performing products to improve quality or remove from catalog.


--3. What time of the day has the highest number of purchases?
   SELECT 
		CASE 
			WHEN DATEPART(HOUR,time_of_purchase) BETWEEN 0 AND 5 THEN 'NIGHT'
			WHEN DATEPART(HOUR,time_of_purchase) BETWEEN 6 AND 11 THEN 'MORNING'
			WHEN DATEPART(HOUR,time_of_purchase) BETWEEN 12 AND 17 THEN 'AFTERNOON'
			WHEN DATEPART(HOUR,time_of_purchase) BETWEEN 18 AND 23 THEN 'EVENING'
		END AS time_of_day,
		COUNT(*) AS total_orders
	FROM store
	GROUP BY 
		CASE 
			WHEN DATEPART(HOUR,time_of_purchase) BETWEEN 0 AND 5 THEN 'NIGHT'
			WHEN DATEPART(HOUR,time_of_purchase) BETWEEN 6 AND 11 THEN 'MORNING'
			WHEN DATEPART(HOUR,time_of_purchase) BETWEEN 12 AND 17 THEN 'AFTERNOON'
			WHEN DATEPART(HOUR,time_of_purchase) BETWEEN 18 AND 23 THEN 'EVENING'
		END
ORDER BY total_orders DESC

--Business Problem Solved: Find peak sales times.
--Business Impact: Optimize staffing, promotions, and server loads.


--4. Who are the top 5 highest spending customers?
Select top 5 customer_name, FORMAT(SUM(price*quantity),'C0','en-IN') AS Total_spend 
from store
where status = 'delivered'
group by customer_name
order by SUM(price*quantity) desc;

--Business Problem Solved: Identify VIP customers.
--Business Impact: Personalized offers, loyalty rewards, and retention.


--5. Which product categories generate the highest revenue?
SELECT 
	product_category,
	FORMAT(SUM(price*quantity),'C0','en-IN') AS Revenue
FROM store 
GROUP BY product_category
ORDER BY SUM(price*quantity) DESC

--Business Problem Solved: Identify top-performing product categories.
--Business Impact: Refine product strategy, supply chain, and promotions, Allowing the business to invest more in high-margin or high-demand categories.


--6. What is the return/cancellation rate per product category?
--cancellation
SELECT product_category,
	FORMAT(COUNT(CASE WHEN status='cancelled' THEN 1 END)*100.0/COUNT(*),'N3')+' %' AS cancelled_percent
FROM store
GROUP BY product_category
ORDER BY cancelled_percent DESC
--Return
SELECT product_category,
	FORMAT(COUNT(CASE WHEN status='returned' THEN 1 END)*100.0/COUNT(*),'N3')+' %' AS returned_percent
FROM store 
GROUP BY product_category
ORDER BY returned_percent DESC

--Business Problem Solved: Monitor dissatisfaction trends per category.
--Business Impact: Reduce returns, improve product descriptions/expectations, Helps identify and fix product or logistics issues.


--7. What is the most preferred payment mode?
Select payment_mode, count(*) as Transections from store
group by payment_mode
order by Transections desc;

--Business Problem Solved: Know which payment options customers prefer.
--Business Impact: Streamline payment processing, prioritize popular modes.


--8. How does age group affect purchasing behavior?
SELECT 
	CASE	
		WHEN customer_age BETWEEN 18 AND 30 THEN '18-30'
		WHEN customer_age BETWEEN 30 AND 40 THEN '30-40'
		WHEN customer_age BETWEEN 40 AND 50 THEN '40-50'
		ELSE '51+'
	END AS customer_age,
	FORMAT(SUM(price*quantity),'C0','en-IN') AS total_purchase
FROM store 
GROUP BY CASE	
		WHEN customer_age BETWEEN 18 AND 30 THEN '18-30'
		WHEN customer_age BETWEEN 30 AND 40 THEN '30-40'
		WHEN customer_age BETWEEN 40 AND 50 THEN '40-50'
		ELSE '51+'
	END 
ORDER BY SUM(price*quantity) DESC

--Business Problem Solved: Understand customer demographics.
--Business Impact: Targeted marketing and product recommendations by age group.


--9. What’s the monthly sales trend?
SELECT 
	FORMAT(purchase_date,'yyyy-MM') AS Month_Year,
	FORMAT(SUM(price*quantity),'C0','en-IN') AS total_sales,
	SUM(quantity) AS total_quantity
FROM store
GROUP BY FORMAT(purchase_date,'yyyy-MM')

--Business Problem: Sales fluctuations go unnoticed.
--Business Impact: Plan inventory and marketing according to seasonal trends.


--10. Are certain genders buying more specific product categories?
SELECT gender,product_category,COUNT(product_category) AS total_purchase
FROM store
GROUP BY gender,product_category
ORDER BY gender

--Business Problem Solved: Gender-based product preferences.
--Business Impact: Personalized ads, gender-focused campaigns.

