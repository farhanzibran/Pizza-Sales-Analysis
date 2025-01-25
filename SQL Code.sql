SELECT *  FROM pizza_sales

/*
KPI's
*/

--Total revenue
SELECT SUM(total_price) AS Total_Revenue 
FROM pizza_sales 

--Avarage Order Value
SELECT (SUM(total_price) / COUNT (DISTINCT order_id))  AS Avg_order_Value
FROM pizza_sales

--Total Pizza Sold
SELECT SUM(quantity) AS Total_Pizza_Sold 
FROM pizza_sales

--Total Order
SELECT COUNT(DISTINCT order_id) AS Total_Orders 
FROM pizza_sales

--Avarage Pizza Per Order
SELECT CAST (CAST(SUM(quantity) AS DECIMAL (10,2)) /
CAST (COUNT(DISTINCT order_id) AS DECIMAL (10,2)) AS DECIMAL (10,2))
AS Avg_Pizzas_Per_Order
FROM pizza_sales

/*
Daily Trend For Total Orders
*/

SELECT DATENAME (DW, order_date) AS order_day, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DATENAME(DW, order_date)

/*
Hourly Trend For Orders
*/

SELECT DATEPART (HOUR, order_time) AS order_hours, COUNT (DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY DATEPART (HOUR, order_time)
ORDER BY DATEPART (HOUR, order_time)

/*
% of sales by pizza Category
*/

SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_category/*
% of sales by pizza Size
*/SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_salesGROUP BY pizza_size
ORDER BY pizza_size/*
Total Pizzas Sold by pizza category
*/SELECT pizza_category, SUM(quantity) as Total_Quantity_sold FROM pizza_salesWHERE MONTH(order_date) = 2GROUP BY pizza_categoryORDER BY Total_Quantity_sold DESC/*
Top 5 Best Sellers By Total Pizzas Sold
*/SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Pizza_SoldFROM pizza_salesGROUP BY pizza_nameORDER BY Total_Pizza_Sold DESC/*
Bottom 5 Best Sellers By Total Pizzas Sold
*/SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold ASC--NOTESELECT DATENAME(DW, order_date) AS order_day, COUNT(DISTINCT order_id) AS
total_orders
FROM pizza_sales
WHERE MONTH(order_date) = 1
GROUP BY DATENAME(DW, order_date)SELECT DATENAME(DW, order_date) AS order_day, COUNT(DISTINCT order_id) AS
total_orders
FROM pizza_sales
WHERE DATEPART(QUARTER, order_date) = 1
GROUP BY DATENAME(DW, order_date)