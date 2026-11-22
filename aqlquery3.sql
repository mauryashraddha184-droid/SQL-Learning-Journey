CREATE DATABASE SHOPPING;
USE SHOPPING;
CREATE TABLE Customers(customer_id int primary key,name varchar(50),email varchar(50) unique,city varchar(50),join_date date);

create table Products(product_id int primary key,product_name varchar(50),category varchar(50),price decimal(10,2),stock int);

create table Orders
(order_id int primary key,customer_id int,order_date date,total_amount decimal(10,2),
foreign key (customer_id)references Customers(customer_id));

create table Order_details(order_details_id int primary key,
order_id int,product_id int,quantity int,
foreign key (product_id) references Products (product_id),
foreign key (order_id) references Orders(order_id)); 

create table Payments(payment_id int primary key,order_id int,payment_mode varchar(50),payment_status varchar(50),
foreign key (order_id) references Orders(order_id));

--find the total number of order by each customer
select c.name ,count(o.order_id)as total_orders
from Customers c join Orders o on c.customer_id=o.order_id group by c.name;