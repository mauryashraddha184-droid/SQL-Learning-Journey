use salesdb;
select * from [dbo].[CUSTOMER DATA];
select* from order_data;
--total customers
SELECT count(*) as total_customers from [dbo].[CUSTOMER DATA];
--total orders
select count(*) as total_orders from Order_data;
--total sales
select sum(Purchase_amount_USD)AS total_sales from [dbo].[CUSTOMER DATA];
--average purcahse amount
select avg(purchase_amount_usd) as average_amount from [dbo].[CUSTOMER DATA];
--sales by payment method
select payment_method,sum(purchase_amount_usd)as total_sales from [dbo].[CUSTOMER DATA]group by payment_method;
--inner join
select
c.customer_id,
c.gender,
s.order_id,
s.category,
s.quantity
from [dbo].[CUSTOMER DATA] c
inner join order_data s on c.customer_id=s.customer_id;
--customer with purchase greater thyan 80 usd
select 
customer_id,
purchase_amount_usd from[dbo].[CUSTOMER DATA]
where purchase_amount_usd>80;
--orders placed by each gender
select 
c.gender,
count(s.order_id)as total_quantity
from [dbo].[CUSTOMER DATA] c
inner join order_data s
on c.customer_id=s.customer_id group by s.category;
--profit by category
select
s.category,
sum((s.list_price - s.cost_price)*s.quantity)as 
total_profit
from [dbo].[CUSTOMER DATA] c 
inner join order_data s
on c.customer_id=s.customer_id
group by s.category;
--top 5 customer
select top 5
c.customer_id,
sum(c.purchase_amount_usd)as total_purchase from [dbo].[CUSTOMER DATA] c
inner join order_data s
on c.customer_id=s.customer_id
group by c.customer_id 
order by total_purchase desc;
--profit by margin
select category,
sum(cast((list_price-cost_Price)as bigint )*quantity)as
total_profit,
sum(cast(list_price as bigint)*quantity)as total_revenue,
round(
(sum(cast((list_price-cost_price) as float )*quantity)*100.0)/
sum(cast(list_price as float)*quantity),
2
)
as profit_margin_percentage
from order_data
group by category
order by profit_margin_percentage desc;
