select * 
from raw_3000;

-- Total Sales
select
sum(sales)
from raw_3000;

-- Total Profit
select
sum(Profit)
from raw_3000;

-- Total Orders
select
count(distinct ï»¿Order_ID)
from raw_3000;

-- Total Customers
select
count(distinct Customer_ID)
from raw_3000;

-- Average Order Value
select
sum(Sales) as total_sales,
count(distinct ï»¿Order_ID) as total_orders,
round(
sum(Sales)/nullif(count(distinct ï»¿Order_ID),0),
2) as avg_ordervalue
from raw_3000;

-- Total Quantity Sold
select 
count(Quantity)
from raw_3000;

-- Overall Profit margin
select 
sum(Sales) as total_sales,
Sum(Profit) as total_profit,
concat(
round(
sum(profit)/nullif(sum(sales),0) * 100,
2),
'%') as profit_margin
from raw_3000;


-- CATEGORY ANALYSIS

-- Sales by category
select
Category,
sum(Sales) as Total_sales
from raw_3000
group by Category
order by Total_sales;

-- Profit by category
select
Category,
sum(Profit) as Total_profit
from raw_3000
group by Category
order by Total_profit;

-- Profit Margin by category
select 
Category,
sum(Sales) as total_sales,
sum(Profit) as total_profit,
concat(
round(
sum(Profit)/nullif(sum(Sales),0)*100,
2),
'%') as profit_margin
from raw_3000
group by Category
order by profit_margin;

-- Orders by category
select 
Category,
count(ï»¿Order_ID) as total_orders
from raw_3000
group by Category
order by total_orders;

-- Top category by sales
select
Category,
sum(Sales) as total_sales
from raw_3000
group by Category
order by total_sales desc
limit 1;

-- Top category by profit
select
Category,
sum(Profit) as total_profit
from raw_3000
group by Category
order by total_profit desc
limit 1;

-- PRODUCT ANALYSIS

-- Top 10 products by sales
select
Product_ID,Product,
sum(Sales)as total_sales
from raw_3000
group by Product_ID,Product
order by total_sales desc
limit 10;

-- Top 10 products by profit
select 
Product_ID,Product,
sum(Profit) as total_profit
from raw_3000
group by Product_ID,Product
order by total_profit desc
limit 10;

-- Bottom 10 Products by profit
select 
Product_ID, Product,
sum(Profit) as total_profit
from raw_3000
group by Product_ID,Product
order by total_profit asc
limit 10;

-- Highest selling Product
select 
Product_ID,Product,
sum(sales) as total_sales
from raw_3000
group by Product_ID,Product
order by total_sales desc
limit 1;

-- Product with high sales but low profit
select 
Product_ID,Product,
sum(sales) as total_sales,
sum(Profit) as total_profit
from raw_3000
group by Product_ID,Product
having total_sales > 800000 and total_profit < 150000 ;

-- REGIONAL ANALYSIS

-- Sales by region
select
Region,
sum(sales) as total_sales
from raw_3000
group by Region
order by total_sales;

-- Profit by region
select 
Region,
sum(Profit) as total_profit
from raw_3000
group by Region
order by total_profit;

-- Orders by region
select 
Region,
count(distinct ï»¿Order_ID) as total_orders
from raw_3000
group by Region
order by total_orders;

-- Average order value by region
select
Region,
sum(sales)as total_sales,
count(distinct ï»¿Order_ID) as total_orders,
round(
sum(Sales) /  nullif(count(distinct ï»¿Order_ID) , 0),
2) as avg_order_value
from raw_3000
group by region
order by avg_order_value;

-- Profit Margin by Region
select
Region,
sum(Sales) as total_sales,
sum(Profit) as total_profit,
concat(
round(
sum(Profit)/nullif(sum(Sales),0)*100,
2),
'%') as Profit_margin
from raw_3000
group by Region
order by Profit_margin;

-- CUSTOMER ANALYSIS

-- Top 10 customners by sales
select 
Customer_ID, Customer_Name,
sum(Sales) as total_sales
from raw_3000
group by Customer_ID, Customer_Name
order by total_sales desc
limit 10;

-- Top 10 customers by profit
select 
Customer_ID,Customer_Name,
sum(profit) as total_profit
from raw_3000
group by Customer_ID,Customer_Name
order by total_profit desc
limit 10;

-- Customers with more than 5 orders
select
Customer_ID,Customer_Name,
count(distinct ï»¿Order_ID) as total_orders
from raw_3000
group by Customer_ID,Customer_Name
having total_orders > 5;

-- Average customer sales
select
avg(total_sales) as avg_sales
from(
select
Customer_ID,
sum(Sales) as total_sales
from raw_3000
group by Customer_ID) as cutomer_totals;

-- Sales by customer segment
select
Customer_Segment,
sum(Sales) as total_sales
from raw_3000
group by Customer_Segment
order by total_sales;

-- Top 10 customer contribution
with customersales as(
select 
Customer_ID,Customer_Name,
sum(Sales) as total_sales
from raw_3000
group by Customer_ID,Customer_Name
)
select
Customer_ID,Customer_Name,
total_sales,
round(
total_sales * 100.0 / sum(total_sales) over(),2) as contribution
from customersales
order by total_sales desc
limit 10;

-- TIME SERIES DATA ANALYSIS

select Order_Date
from raw_3000; -- To see the date order

-- Monthly Sales
select
year(str_to_date(Order_Date, '%d-%m-%Y')) as yearly,
monthname(str_to_date(Order_Date, '%d-%m-%Y')) as monthly,
sum(sales) as total_Sales
from raw_3000
group by yearly, monthly
order by yearly, monthly;

-- Monthly Profit
select 
year(str_to_date(Order_Date, '%d-%m-%Y')) as yearly,
monthname(str_to_date(Order_Date, '%d-%m-%Y')) as monthly,
sum(profit) as total_profit
from raw_3000
group by yearly, monthly
order by yearly, monthly;

-- Quaterly sales
select
year(str_to_date(Order_Date, '%d-%m-%Y')) as yearly,
concat('Q', quarter(str_to_date(Order_Date,'%d-%m-%Y'))) as quarterly,
sum(Sales) as total_sales
from raw_3000
group by yearly, quarterly
order by yearly, quarterly;

-- Quaterly profit
select
year(str_to_date(Order_Date, '%d-%m-%Y')) as yearly,
concat('Q', quarter(str_to_date(Order_Date,'%d-%m-%Y'))) as quarterly,
sum(Profit) as total_profit
from raw_3000
group by yearly, quarterly
order by yearly, quarterly;

-- Year-over-year sales
with yearlysales as(
select
year(str_to_date(Order_Date, '%d-%m-%Y')) as yearly,
sum(Sales) as total_sales
from raw_3000
group by yearly
),
sales_comparision as (
select
yearly,
total_sales,
lag(total_sales) over (order by yearly) as previous_year_sale
from yearlysales
)
select
yearly,
total_sales,
previous_year_sale,
round(
(total_sales - previous_year_sale) *100.0
/ nullif(previous_year_sale,0),
2) as yoy_growth_percentage
from sales_comparision
order by yearly;

-- Best month 
select
monthname(str_to_date(Order_Date, '%d-%m-%Y')) as monthly,
year(str_to_date(Order_Date, '%d-%m-%Y')) as yearly,
sum(Sales) as total_sales,
sum(Profit) as total_profit
from raw_3000
group by monthly , yearly
order by monthly, yearly;


-- Worst month
select
monthname(str_to_date(Order_Date, '%d-%m-%Y')) as monthly,
year(str_to_date(Order_Date, '%d-%m-%Y')) as yearly,
sum(Sales) as total_sales
from raw_3000
group by monthly, yearly
order by total_sales asc
limit 1;

-- DISCOUNT ANALYSIS
select
Discount,
sum(Sales) as total_sales,
sum(Profit) as total_profit,
concat(round(
sum(Profit) * 100.0 / nullif (sum(Sales),0),
2),
'%') as profit_margin
from raw_3000
group by discount
order by total_sales;

-- ADVANCED SQL

-- Rank products within each category
select
Category,
Product,
sum(Sales) as total_sales,
rank() over(
partition by Category
order by sum(Sales) desc) as product_rank
from raw_3000
group by Category, Product;

-- Case when
select
case
when Discount = 0 then 'No Discount'
when Discount <=0.05 then 'Low'
when Discount <=0.10 then 'Medium'
when Discount <=0.15 then 'High'
else 'Very high'
end as discount_level,
count(Customer_ID) as total_rows,
sum(Sales) as total_sales,
sum(Profit)as total_profit
from raw_3000
group by discount_level
order by min(Discount);

-- Having
select
Category,
sum(Sales) as total_sales,
sum(Profit) as total_profit
from raw_3000
group by Category
having total_sales > 100000 
and total_profit > 10000
order by total_sales desc;

-- Subqueries
select 
Product_ID,Product,
sum(Sales) as total_sales
from raw_3000
group by Product_ID,Product
having 
sum(sales) > (
select avg(product_sales)
from(
select sum(Sales) as product_sales
from raw_3000
group by Product_ID) as Product_totals
)
order by total_sales desc;

-- CTE
with category_summary as( 
select
Category,
Sum(Sales) as total_sales,
sum(Profit) as total_profit
from raw_3000
group by Category
)
select
Category,
total_sales,
total_profit,
round(total_profit/nullif(total_sales,0)*100,
2) as profit_margin
from category_summary
where total_profit/nullif(total_sales,0) >0.15
order by profit_margin desc;

-- Rank
with product_Sales as(
select
Category,
Product,
sum(sales) as total_sales
from raw_3000
group by Category, Product
)
select 
Category,
Product,
total_sales,
rank() over(
	partition by Category
    order by total_sales desc) as sales_rank
from product_Sales
order by Category, sales_rank;

-- Row Number
with product_sales as(
select
Product,
Category,
sum(sales) as total_sales
from raw_3000
group by Category, Product
),
ranked_products as (
select *,
row_number() over(
	partition by Category
    order by total_sales desc, Product) as row_num
    from product_sales
    )
    select
    Category,
    Product,
    total_sales,
    row_num
    from ranked_products
    where row_num >=2
    order by Category, row_num;
    
    -- Lag
    
    with monthly_sales as(
    select
    month(str_to_date(Order_Date, '%d-%m-%Y')) as sales_month,
    year(str_to_date(Order_Date, '%d-%m-%Y')) as sales_year,
    sum(Sales) as total_sales
    from raw_3000
    group by sales_month, sales_year
    ),
    sales_comparision as (
    select
    sales_month,
    sales_year,
    total_sales,
    lag(total_sales) over(
    order by sales_month, sales_year) as previous_month_sales
    from monthly_sales
    )
    select
    sales_month,
    sales_year,
    total_sales,
    previous_month_sales,
    total_sales - previous_month_sales as sale_difference,
    round(
    (total_sales - previous_month_sales) / nullif(previous_month_sales,0)*100,
    2) as growth_pct
    from sales_comparision
    order by sales_month;
    
    -- Sum() over()
    with monthly_sales as(
    select
    month(str_to_date(Order_Date, '%d-%m-%Y')) as sales_month,
    year(str_to_date(Order_Date, '%d-%m-%Y')) as sales_year,
    sum(sales) as total_sales 
    from raw_3000
    group by sales_month,sales_year
    )
    select
    sales_month,
    sales_year,
    total_sales,
    sum(total_sales) over(
		order by sales_month
        rows between unbounded preceding
        and current row) as running_total_sales
        from monthly_sales
        order by sales_month;
        
        -- multiple advance concepts
        
        with product_summary as(
        select
        Product_ID,
        Product,
        Category,
        sum(sales) as total_sales,
        sum(Profit) as total_profit
        from raw_3000
        group by Product_ID, Product, Category
        having sum(sales) > 50000
        ),
        profit_margin as (
        select
        round(
        total_profit / nullif(total_sales,0)*100,
        2) as profit_margin_pct
        from product_summary
        ),
        ranked_products as(
        select *, 
        rank() over(
			partition by Category
            order by profit_margin_pct desc) as product_rank
            from profit_margin)
            select*
            from ranked_products
            where product_rank <=3
            order by Category, product_rank;
        