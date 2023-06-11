create database Algaj22_SensorsDB

go

use Algaj22_SensorsDB


create table Sensor (
    Id int identity(1, 1) primary key,
    Name nvarchar(256) not null,
    Host char(15) not null,
)

go

create table Port (
    Id bigint identity(1, 1) primary key,
    SensorId int foreign key references Sensor(Id) not null,
    Number int not null
)
