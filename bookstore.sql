create database  bookstore;
use bookstore;

create table book_language(
language_id int auto_increment primary key,
language_name varchar(100) not null
);

create table publisher(
publisher_id int auto_increment primary key,
publisher_name varchar(100) not null
);

create table author(
author_id int auto_increment primary key,
first_name varchar(100),
last_name varchar(100)
);

create table country(
country_id int auto_increment primary key,
country_name varchar(100)
);

create table address_status(
status_id int auto_increment primary key,
status_name varchar(50)
);

create table shipping_method (
shipping_method_id int auto_increment primary key,
method_name varchar(100)
);

create table order_status(
order_status_id int auto_increment primary key,
status_name varchar(100)
);

create table book(
book_id int auto_increment primary key,
title varchar(255) not null,
language_id int,
publisher_id int,
foreign key (language_id)references book_language(language_id),
foreign key (publisher_id) references publisher(publisher_id)
);

create  table book_author(
book_id int,
author_id int,
primary key (book_id, author_id),
foreign key (book_id) references book(book_id),
foreign key (author_id) references author(author_id)
);

create table customer(
customer_id int auto_increment primary key,
first_name  varchar(100),
last_name varchar(100),
email varchar(150)
);

create table address(
address_id int auto_increment primary key,
street varchar(255),
city varchar(100),
postal_code varchar(20),
country_id int,
foreign key (country_id) references country(country_id)
);

create table customer_address(
customer_id int,
address_id int,
status_id int,
primary key (customer_id, address_id),
foreign key (customer_id) references customer(customer_id),
foreign key (address_id) references address(address_id),
foreign key (status_id) references address_status(status_id)
);

create table cust_order (
    order_id int auto_increment primary key,
    customer_id int,
    order_date DATE,
    shipping_method_id int,
    order_status_id int,
    FOREIGN KEY (customer_id) references customer(customer_id),
    FOREIGN KEY (shipping_method_id) references shipping_method(shipping_method_id),
    FOREIGN KEY (order_status_id) references order_status(order_status_id)
);

create table order_line(
order_line_id int auto_increment primary key,
order_id int,
book_id int,
quantity int,
price decimal(10,2),
foreign key (order_id) references cust_order(order_id),
foreign key (book_id) references book(book_id)
);

create table order_history(
history_id int auto_increment primary key,
order_id int,
status_id int,
update_date datetime,
foreign key (order_id) references cust_order(order_id),
foreign key (status_id) references order_status(order_status_id)
);


CREATE ROLE 'read_only';
CREATE ROLE 'data_entry';
CREATE ROLE 'admin';

GRANT SELECT ON bookstore.* TO 'read_only';
GRANT SELECT, INSERT, UPDATE ON bookstore.* TO 'data_entry';
GRANT ALL PRIVILEGES ON bookstore.* TO 'admin';

-- Viewer user
CREATE USER 'moses_kimotho'@'localhost' IDENTIFIED BY 'mose@kim123';
GRANT 'read_only' TO 'moses_kimotho'@'%';

-- Entry user
CREATE USER 'kelvin_kariuki'@'localhost' IDENTIFIED BY 'kelvin@kar123';
GRANT 'data_entry' TO 'kelvin_kariuki'@'%';

-- Admin user
CREATE USER 'meshack_mwima'@'localhost' IDENTIFIED BY 'mesh@123';
GRANT 'admin' TO 'meshack_mwima'@'%';

SET DEFAULT ROLE 'read_only' TO 'moses_kimotho'@'localhost';
SET DEFAULT ROLE 'data_entry' TO 'kelvin_kariuki'@'localhost';
SET DEFAULT ROLE 'admin' TO 'meshack_mwima'@'localhost';
SELECT * FROM information_schema.role_table_grants;
SELECT * FROM information_schema.enabled_roles;






