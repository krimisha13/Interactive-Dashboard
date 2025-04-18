create Database Pizza_Database

use Pizza_database

select * from pizza_sales

--1. Total Revenue
select sum(total_price) as 'Total Revenue' from pizza_sales

--2. Average Order Value
select sum(total_price)/count(distinct order_id) as 'Average Order Value' from pizza_sales

--3. Total Pizza Sold
select sum(quantity) as 'Total Pizza Sold' from pizza_sales

--4. Total Order Placed
select count(distinct order_id) as 'Total Order Placed' from pizza_sales

--5. Average Pizzas Per Order
select cast(cast(sum(quantity) as decimal(10,2))/cast(count(distinct order_id)as decimal(10,2)) as decimal(10,2))
as 'Average Pizzas Per Order' from pizza_sales

--6. Daily trend for Total Orders
select DATENAME(weekday, order_date) as 'Order Day', count(Distinct order_id) 'Total Orders' from pizza_sales
group by DATENAME(weekday, order_date)

--7. Hourly Trend
select DATEPART(hour, order_time) as 'Order Hours', count(Distinct order_id) 'Total Orders' from pizza_sales
group by DATEPART(hour, order_time)
order by DATEPART(hour, order_time)

--8. Percentage of Sales by Pizza Category
select pizza_category,sum(total_price) as Total_sales,
sum(total_price)*100 /(select sum(total_price) from pizza_sales where month(order_date)=1)
as 'Total Sales by Pizza Category' from pizza_sales
where month(order_date)=1
group by pizza_category

--9. Percentage of Sales by Pizza Size
select pizza_size,sum(total_price) as Total_sales,
sum(total_price)*100 /(select sum(total_price) from pizza_sales where datepart(quarter,order_date)=1)
as 'Total Sales by Pizza Category' from pizza_sales
where datepart(quarter,order_date)=1
group by pizza_size
order by pizza_size

--10. Total Pizza Sold by Pizza Category
select pizza_category, sum(quantity) as 'Total Pizza Sold' from pizza_sales
group by pizza_category

--11.Top 5 best Seller by Total Pizza Sold
select top 5 pizza_name, sum(quantity) as 'Total Pizza Sold' from pizza_sales
where month(order_date)=1
group by pizza_name
order by sum(quantity) desc

--12. Bottom 5 Worst Sellers by Total Pizza Sold
select top 5 pizza_name, sum(quantity) as 'Total Pizza Sold' from pizza_sales
where month(order_date)=1
group by pizza_name
order by sum(quantity) asc