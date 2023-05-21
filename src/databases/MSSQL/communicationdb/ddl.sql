create database COMMUNICATIONDB

use COMMUNICATIONDB

create table PARTNER_SETUP (
    PARTNER_ID varchar(64) primary key,
    USED bit default(0) not null,
    NODE_NAME varchar(254) not null,
    DB_TYPE varchar(254) not null,
    USER_NAME varchar(64) not null,
    PASSWORD varchar(64) not null,
    DRIVER varchar(64) not null,
    PORT int,
    [SCHEMA] varchar(64),
    CONNECT_NAME varchar(64),
    DESCRIPTON varchar(254)
)


create table TABLE_SETUP (
    MSG_TABLE_NAME varchar(64) primary key,
    MSG_TABLE_PARENT varchar(64),
    MSG_TABLE_KEY varchar(254),
    DESCRIPTON varchar(254),
)

create table MSG_SETUP (
    MSG_ID int primary key identity(1, 1),
    MSG_NAME varchar(254) not null,
    SOURCE varchar(64) foreign key references PARTNER_SETUP(PARTNER_ID) not null,
    DESTINATION varchar(64) foreign key references PARTNER_SETUP(PARTNER_ID) not null,
    LIFE_TIME int,
    SINGLE_INSTANCE bit default(0) not null,
    USED bit default(0) not null,
    KEEP_HISTORY int not null,
    MSG_TABLE_NAME varchar(64) foreign key references TABLE_SETUP(MSG_TABLE_NAME),
    DESCRIPTION varchar(254),
    unique (MSG_NAME, SOURCE, DESTINATION)
)

create table SEND (
    ID int primary key identity(1, 1),
    MSG_ID int foreign key references MSG_SETUP(MSG_ID) not null,
    SEND_TIME datetime not null,
    CONFIRM_TIME datetime,
    STATUS int check (0 <= STATUS and STATUS <= 2) not null,
    STATUS_TEXT varchar(254),
    MSG_KEY varchar(254),
    READ_COUNT bit default(0) not null,
    SIMULATION bit default(0) not null
)

create table POTA (
    ID int primary key foreign key references SEND(ID) not null,
    ACTION varchar(1) not null,
    POTA_NUMBER varchar(2),
    HEAT_COUNTER int,
    TIME_SINCE_LAST_USE int,
    POTA_IN_CYCLE bit,
    REFACTORY_SIDE varchar(40),
    REFACTORY_BOTTOM varchar(40),
    REFACTORY_SLAG_AREA varchar(40),
)

create table KOVA (
    ID int primary key foreign key references SEND(ID) not null,
    ACTION varchar(1) not null,
    KOVA_NUMBER varchar(2) not null,
    ORDER_NUMBER varchar(20),
    SPLIT_INDICATION varchar(1),
)

create table KOVA_DET (
    ID int foreign key references SEND(ID) not null,
    CNT int not null,
    MATERIAL varchar(32) not null,
    WEIGHT int not null,
    primary key(ID, CNT, MATERIAL)
)

go

create procedure sp_insert_send_message_kova_info(@MSG_ID int, @STATUS bit, 
        @ACTION varchar(1), @KOVA_NUMBER varchar(2), @ORDER_NUMBER varchar(20), @SPLIT_INDICATION varchar(1),
        @CNT int, @MATERIAL varchar(32), @WEIGHT int)
as
begin
    declare @tran_status int
    declare @send_id int

    begin tran
        insert into SEND (MSG_ID, SEND_TIME, STATUS) values (@MSG_ID, SYSDATETIME(), @STATUS)

        set @tran_status = @@ERROR

        if @tran_status <> 0
            goto ROLLBACK_TRANSACTION

        set @send_id = @@IDENTITY

        insert into KOVA (ID, ACTION, KOVA_NUMBER, ORDER_NUMBER, SPLIT_INDICATION) 
        values (@send_id, @ACTION, @KOVA_NUMBER, @ORDER_NUMBER, @SPLIT_INDICATION)

        set @tran_status = @@ERROR

        if @tran_status <> 0
            goto ROLLBACK_TRANSACTION

        insert into KOVA_DET (ID, CNT, MATERIAL, WEIGHT) values (@send_id, @CNT, @MATERIAL, @WEIGHT)

        set @tran_status = @@ERROR

        if @tran_status <> 0
            goto ROLLBACK_TRANSACTION

        commit tran

        ROLLBACK_TRANSACTION:
            if @tran_status <> 0
                rollback tran 
end

go

create procedure sp_insert_send_message_pota_info(@MSG_ID int, @STATUS bit, 
        @ACTION varchar(1), @POTA_NUMBER varchar(2), @HEAT_COUNTER int, 
        @TIME_SINCE_LAST_USE int, @POTA_IN_CYCLE bit, @REFACTORY_SIDE varchar(40), 
        @REFACTORY_BOTTOM varchar(40), @REFACTORY_SLAG_AREA varchar(40))
as
begin
    declare @tran_status int
    declare @send_id int

    begin tran
        insert into SEND (MSG_ID, SEND_TIME, STATUS) values (@MSG_ID, SYSDATETIME(), @STATUS)

        set @tran_status = @@ERROR

        if @tran_status <> 0
            goto ROLLBACK_TRANSACTION

        set @send_id = @@IDENTITY

        insert into POTA (ID, ACTION, POTA_NUMBER, HEAT_COUNTER, TIME_SINCE_LAST_USE, POTA_IN_CYCLE, REFACTORY_SIDE, REFACTORY_BOTTOM, REFACTORY_SLAG_AREA) 
        values (@send_id, @ACTION, @POTA_NUMBER, @HEAT_COUNTER, @TIME_SINCE_LAST_USE, @POTA_IN_CYCLE, @REFACTORY_SIDE, @REFACTORY_BOTTOM, @REFACTORY_SLAG_AREA)

        set @tran_status = @@ERROR

        if @tran_status <> 0
            goto ROLLBACK_TRANSACTION


        commit tran

        ROLLBACK_TRANSACTION:
            if @tran_status <> 0
                rollback tran 
end


