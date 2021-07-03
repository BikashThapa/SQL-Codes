-- create the following tables is mYSQL
-- products

-- primary key
-- name
-- category
-- sell by date
-- sold or not
-- moment of sale
-- quantity
-- weight in kg

select now();
drop table products;
create table products ( id int primary key auto_increment, name varchar(50), category enum ('baked', 'non-baked' ) default 'non-baked', sell_by_date  date default (date(now())),sold_status bool default false,moment_of_sale timestamp default now(), quantity smallint, weight_in_kg float(6));

desc products;

insert into products( name, category,sell_by_date,sold_status,moment_of_sale,quantity,weight_in_kg) values (' bread', 'baked',default,1,default,4,1.79);


select * from products;
-- ---------------------------------------------------------
-- Personnel

-- primary key
-- given name(first nanme)
-- family name (last name)
-- gender
-- telephone number
-- marital status
-- age
-- salary
-- position
-- date started
drop table personnel;
create table personnel( id int primary key auto_increment, first_name varchar(15),last_name varchar(15), gender enum ('male','female', 'no data') default 'no data' ,telephone_number bigint,marital_status enum('married', 'unmarried') default 'unmarried', age tinyint,salary float(15),position varchar(20), date_started date default (date(now())));

desc personnel;
insert into personnel (first_name, last_name,gender,telephone_number,marital_status,age,salary,position,date_started) values ('Sam','curran','male',99221118899,'married',37,991199.00,'HR-head','2016-04-28');

select * from personnel;
-- ---------------------------------------------------------
-- Address

-- first line
-- second line
-- city
-- Region
-- zip/postal code
-- two letter country code
drop table address;
create table address( id int primary key auto_increment,first_line varchar(20),second_line varchar(20), city varchar(20),region varchar(20),postal_code varchar(10),country_code int);

desc address;
insert into address(first_line,second_line,city,region,postal_code,country_code) values ('Southern Block 21','west street 15','Rockhampton','Sydney','2266','21' );
select * from address;