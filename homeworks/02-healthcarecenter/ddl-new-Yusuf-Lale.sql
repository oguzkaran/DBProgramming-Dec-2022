create database healthcenterdb

use healthcenterdb

create table common_info (
     common_info_id int primary key identity(1, 1),
     first_name nvarchar(50) not null,
     middle_name nvarchar(50),
     last_name nvarchar(50) not null,
     birthdate date not null,
     gender char(1) check(gender = 'M' or gender = 'F') not null
 )

 create table patients (
     patient_id int primary key identity(1, 1),
     common_info_id int foreign key references common_info(common_info_id) not null,
     address nvarchar(500) not null
 )

 create table staff (
     staff_id int primary key identity(1, 1),
     common_info_id int foreign key references common_info(common_info_id) not null,
     qualifications nvarchar(max),
     details nvarchar(max)
 )

create table appointments (
    appointment_id int primary key identity(1, 1),
    patient_id int foreign key references patients(patient_id) not null,
    staff_id int foreign key references staff(staff_id) not null,
    date_time_of_appointment datetime,
    details nvarchar(max)
)

create table medication_types (
    medication_type_code nvarchar(15) primary key,
    name nvarchar(75),
    description nvarchar(max)
)

create table medications (
    medication_id int primary key identity(1, 1),
    medication_type_code nvarchar(15) foreign key references medication_types(medication_type_code) not null,
    unit_cost money not null,
    name nvarchar(50) not null,
    description nvarchar(max),
    details nvarchar(max)
)

create table patients_to_medications (
    patients_to_medications_id int primary key identity(1, 1),
    medication_id int foreign key references medications(medication_id) not null,
    patient_id int foreign key references patients(patient_id) not null,
    date_time_administered datetime,
    dosage nvarchar(15),
    comments nvarchar(max)
)


select * from patients_to_medications