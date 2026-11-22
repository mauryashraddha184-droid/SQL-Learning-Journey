CREATE DATABASE SHOPPING;
USE SHOPPING;
CREATE TABLE Customers(customer_id int primary key,name varchar(50),email varchar(50) unique,
city varchar(50),join_date date);
insert into Customers values(1,'rahul','rahul@gmail.com','Delhi','2023-01-10'),

create table Products(product_id int primary key,product_name varchar(50),category varchar(50),price decimal(10,2),stock int);
insert insert into Products values(101,'laptop','electronics',55000,10),
(102,'mobile phone','electronics',25000,20),
(103,'headphones','Accessories',2000,50),
(104,'office chair','furniture',7000,15),
(105,'water bottle','Accessories',500,100);
create table Orders(order_id int primary key,customer_id int,order_date date,total_nt decimal(10,2),
foreign key (customer_id)references Customers(customer_id));
insert into Orders values(1001,1,'2023-06-01',80000),
(1002,2,'2023-06-03',25000),
(1003,1,'2023-06-10',2000),
(1004,3,'2023-06-15',7000),
(1005,4,'2023-06-20',500);
exec sp_rename 'Orders.total_nt','total_amount', 'column';
create table Orderdetails(order_details_id int primary key,
order_id int,product_id int,quantity int,
foreign key (product_id) references Products (product_id),
foreign key (order_id) references Orders(order_id)); 
insert into Orderdetails values(1,1001,101,1),
(2,1001,102,1),
(3,1002,102,1),
(4,1003,103,1),
(5,1004,104,1),
(6,1005,105,1);

create table Payments(payment_id int primary key,order_id int,payment_mode varchar(50),payment_status varchar(50),
foreign key (order_id) references Orders(order_id));
insert into Payments values(201,1001,'credit card','completed'),
(202,1002,'UPI','completed'),
(203,1003,'Debit card','Pending'),
(204,1004,'Net banking','complited'),
(205,1005,'cash on delivery','pending');
--find the total number of order by each customer
select c.name,count(o.order_id)as total_orders
from Customers c join Orders o on c.customer_id=o.order_id 
group by c.name;
--total sales amount per cataegory 
select p.category,sum(od.quantity*p.price) as total_sales from Orderdetails od 
join Products p on od.product_id=p.product_id group by p.category;
--list customer who had never placed orders
select name from Customers where customer_id not in (select customer_id from Orders);
--find the top most selling products
select top 3 p.product_name,sum(od.quantity)as total_solds from Orderdetails od 
join Products p on od.product_id=order_id
group by p.product_name
order by total_solds desc;
--find oder with pending payments
select c.name ,p.payment_status from Orders od join
Customers c on od.customer_id=c.customer_id
join Payments p 
 on od.order_id=p.order_id where
 p.payment_status='pending';s