/*----------------------------------------------------------------------------------------------------------------------
	bankappdb 1.0.0
-----------------------------------------------------------------------------------------------------------------------*/

create table marital_status (
	marital_status_id serial primary key,
	description varchar(100) not null
);

insert into marital_status (description) values ('Single'), ('Married'), ('Divorced');

create table customers (
	customer_number bigint primary key,
	citizen_number char(36) unique not null,
	first_name varchar(100) not null,
	middle_name varchar(100),
	last_name varchar(100) not null,
	birth_date date not null,
	marital_status_id int references marital_status(marital_status_id) not null
);

create table customer_to_addresses (
	address_id serial primary key,
	customer_number bigint references customers(customer_number) not null,
	description varchar(512) not null
);

create table phone_types (
	phone_type_id serial primary key, 
	description varchar(50) not null
);

insert into phone_types (description) values ('GSM'), ('WORK'), ('HOME');

create table customer_to_phones (
	phone_id serial primary key,
	customer_number bigint references customers(customer_number) not null,
	phone_type_id int references phone_types(phone_type_id) not null,
	number char(14) not null
);

create table card_types (
	card_type_id serial primary key,
	description varchar(30) not null
);

insert into card_types (description) values ('Visa'), ('Master'), ('Amex'); 


create table cards (
	card_number char(16) primary key,
	card_type_id int references card_types(card_type_id) not null,
	customer_number bigint references customers(customer_number) not null,
	expiry_month int check(1 <= expiry_month and expiry_month <= 12) not null,
	expiry_year int not null, 
	security_code char(4) not null	
);








