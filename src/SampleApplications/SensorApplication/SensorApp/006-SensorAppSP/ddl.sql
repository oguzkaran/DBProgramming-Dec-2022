create database DBProgSensorsDB

go

use DBProgSensorsDB


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

go

create procedure sp_insert_sensor(@name nvarchar(100), @host char(15))
as
begin
    insert into Sensor  (name, host) values (@name, @host)
end

go