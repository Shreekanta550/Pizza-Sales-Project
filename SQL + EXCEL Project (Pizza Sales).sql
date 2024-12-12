use [Pizza DB]
select * from pizza_sales;

--KPIs requirements

select sum(total_price) as Total_Revenue from pizza_sales;

select sum(total_price)/count(distinct order_id) as Avg_Order_value from pizza_sales;

select sum(quantity) as Total_Pizza_Sold from pizza_sales;

select count(distinct order_id) as Total_orders from pizza_sales;

Select cast(cast(sum(quantity) as decimal(10,2))/
cast(count(distinct order_id) as decimal(10,2)) as decimal(10,2) )as Avg_Pizza_Per_Orders from pizza_sales;

--Daily trend

Select DATENAME(DW,order_date) As order_day, count(distinct order_id) as Total_orders
from pizza_sales
group by DATENAME(DW,order_date);

--Hourly trend
Select DATEPART(Hour,order_time) as order_hours, count(distinct order_id) as Total_orders
from pizza_sales
Group by Datepart(Hour,order_time)
Order By Datepart(Hour,order_time);

--Percentage of sales by pizza category

Select pizza_category, sum(total_price) as Total_sales,sum(total_price)*100 /
(Select sum(total_price) from pizza_sales where MONTH(order_date)=1) as PCT
from pizza_sales
where MONTH(order_date)=1
group by pizza_category;

-- Percentage of sales by pizza size
Select pizza_size, cast(sum(total_price) as decimal(10,2)) as Total_sales,cast (sum(total_price)*100 /
(Select sum(total_price) from pizza_sales where DATEPART(quarter, order_date)=1 )as decimal(10,2)) as PCT
from pizza_sales
where DATEPART(quarter, order_date)=1
group by pizza_size
order by PCT desc;

--Total_pizzas sold by pizza category

Select pizza_category, sum(quantity) as Total_pizza_sold 
from pizza_sales
group by pizza_category;

--Top 5 Best Sellers by total pizzas sold

Select top 5 pizza_name,sum(quantity) as Total_pizzas_sold
from pizza_sales
where month(order_date) = 8
group by pizza_name
order by Total_pizzas_sold desc;

--Bottom 5 worst sellers by total pizzas sold
use [Pizza DB]
Select top 5 pizza_name,sum(quantity) as Total_pizzas_sold
from pizza_sales
--where month(order_date) = 1
group by pizza_name
order by Total_pizzas_sold asc;


