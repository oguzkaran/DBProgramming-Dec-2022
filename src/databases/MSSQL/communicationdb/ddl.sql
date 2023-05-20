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
    DESCRIPTION varchar(254)
)

create table SEND (
    ID int primary key identity(1, 1),
    MSG_ID int foreign key references MSG_SETUP(MSG_ID) not null,
    SEND_TIME datetime not null,
    CONFIRM_TIME datetime not null,
    STATUS int check (0 <= STATUS and STATUS <= 2) not null,
    STATUS_TEXT varchar(254),
    MSG_KEY varchar(254),
    READ_COUNT bit not null,
    SIMULATION bit not null
)

create table POTA (
    ID int foreign key references SEND(ID) not null,
    ACTION varchar(1) not null,
    POTA_NUMBER varchar(2),
    HEAT_COUNT int,
    TIME_SINCE_LAST_USE int,
    POTA_IN_CYCLE bit,
    REFACTORY_SIDE varchar(40),
    REFACTORY_BOTTOM varchar(40),
    REFACTORY_SLAG_AREA varchar(40),
)

create table KOVA (
    ID int foreign key references SEND(ID) not null,
    ACTION varchar(1) not null,
    KOVA_NUMBER varchar(2) not null,
    ORDER_NUMBER varchar(20),
    SPLI_INDICATION varchar(1),
)

create table KOVA_DET (
    ID int foreign key references SEND(ID) not null,
    CNT int not null,
    MATERIAL varchar(32) not null,
    WEIGHT int not null
)

