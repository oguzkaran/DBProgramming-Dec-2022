/*----------------------------------------------------------------------------------------------------------------------
	bankappdb 1.0.0
-----------------------------------------------------------------------------------------------------------------------*/

create database dbpd22_bankappdb

use dbpd22_bankappdb


create table marital_status (
	marital_status_id int primary key identity(1, 1),
	description nvarchar(100) not null
);

insert into marital_status (description) values ('Single'), ('Married'), ('Divorced');

create table customers (
	customer_number bigint primary key,
	citizen_number char(36) unique not null,
	first_name nvarchar(100) not null,
	middle_name nvarchar(100),
	last_name nvarchar(100) not null,
	birth_date date not null,
	marital_status_id int foreign key references marital_status(marital_status_id) not null,
	is_alive bit default(1) not null,	
	is_active bit default(1) not null,	
	is_personnel bit not null,	
	is_local bit not null,	
);

create table customer_to_addresses (
	address_id int primary key identity(1, 1),
	customer_number bigint foreign key references customers(customer_number) not null,
	description nvarchar(512) not null
);

create table phone_types (
	phone_type_id int primary key identity(1, 1), 
	description nvarchar(50) not null
);

insert into phone_types (description) values ('GSM'), ('WORK'), ('HOME');

create table customer_to_phones (
	phone_id int primary key identity(1, 1),
	customer_number bigint foreign key references customers(customer_number) not null,
	phone_type_id int foreign key references phone_types(phone_type_id) not null,
	number char(14) not null
);

create table card_types (
	card_type_id int primary key identity(1, 1),
	description nvarchar(30) not null
);

insert into card_types (description) values ('Visa'), ('Master'), ('Amex'); 


create table cards (
	card_number char(16) primary key,
	card_type_id int foreign key references card_types(card_type_id) not null,
	customer_number bigint foreign key references customers(customer_number) not null,
	expiry_month int check(1 <= expiry_month and expiry_month <= 12) not null,
	expiry_year int not null, 
	security_code char(4) not null	
);


create function hide_text_right(@text nvarchar(max), @ch char(1), @n int)
returns nvarchar(max)
as
begin
    return left(@text, @n) + replicate(@ch, len(@text) - @n)
end;


create function get_full_name(@first_name nvarchar(100), @middle_name nvarchar(100), @last_name nvarchar(100))
returns nvarchar(max)
as
begin   
    return case 
            when @middle_name is not null then @first_name + ' ' + @middle_name
            else @first_name
            end + ' ' + upper(@last_name)
end;

create function get_status_text(@predicate bit, @true_str nvarchar(100),  @false_str nvarchar(100))
returns nvarchar(100)
as
begin
    return case @predicate
        when 1 then @true_str
        else @false_str
        end
end;

