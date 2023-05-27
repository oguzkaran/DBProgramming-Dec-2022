create database COMMUNICATIONDB;

create table PARTNER_SETUP (
    PARTNER_ID varchar(64) primary key,
    USED boolean default(false) not null,
    NODE_NAME varchar(254) not null,
    DB_TYPE varchar(254) not null,
    USER_NAME varchar(64) not null,
    PASSWORD varchar(64) not null,
    DRIVER varchar(64) not null,
    PORT int,
    SCHEMA varchar(64),
    CONNECT_NAME varchar(64),
    DESCRIPTON varchar(254)
);


create table TABLE_SETUP (
    MSG_TABLE_NAME varchar(64) primary key,
    MSG_TABLE_PARENT varchar(64),
    MSG_TABLE_KEY varchar(254),
    DESCRIPTON varchar(254)
);

create table MSG_SETUP (
    MSG_ID serial primary key,
    MSG_NAME varchar(254) not null,
    SOURCE varchar(64) references PARTNER_SETUP(PARTNER_ID) not null,
    DESTINATION varchar(64) references PARTNER_SETUP(PARTNER_ID) not null,
    LIFE_TIME int,
    SINGLE_INSTANCE boolean default(false) not null,
    USED boolean default(false) not null,
    KEEP_HISTORY int not null,
    MSG_TABLE_NAME varchar(64) references TABLE_SETUP(MSG_TABLE_NAME),
    DESCRIPTION varchar(254),
    unique (MSG_NAME, SOURCE, DESTINATION)
);

create table SEND (
    ID serial primary key,
    MSG_ID int references MSG_SETUP(MSG_ID) not null,
    SEND_TIME timestamp not null,
    CONFIRM_TIME timestamp,
    STATUS int check (0 <= STATUS and STATUS <= 2) not null,
    STATUS_TEXT varchar(254),
    MSG_KEY varchar(254),
    READ_COUNT boolean default(false) not null,
    SIMULATION boolean default(false) not null
);

create table POTA (
    ID int primary key references SEND(ID) not null,
    ACTION varchar(1) not null,
    POTA_NUMBER varchar(2),
    HEAT_COUNTER int,
    TIME_SINCE_LAST_USE int,
    POTA_IN_CYCLE boolean,
    REFACTORY_SIDE varchar(40),
    REFACTORY_BOTTOM varchar(40),
    REFACTORY_SLAG_AREA varchar(40)
);

create table KOVA (
    ID int primary key references SEND(ID) not null,
    ACTION varchar(1) not null,
    KOVA_NUMBER varchar(2) not null,
    ORDER_NUMBER varchar(20),
    SPLIT_INDICATION varchar(1)
);

create table KOVA_DET (
    ID int references SEND(ID) not null,
    CNT int not null,
    MATERIAL varchar(32) not null,
    WEIGHT int not null,
    primary key (ID, CNT, MATERIAL)
);

create or replace procedure sp_insert_send_message_kova_info
		(int, boolean, varchar(1), varchar(2), varchar(20), varchar(1), int, varchar(32), int)
language plpgsql
as $$
    declare
        send_id int;
    begin
        insert into SEND (MSG_ID, SEND_TIME, STATUS) values ($1, current_timestamp, $2);
        
        send_id = currval('SEND_ID_seq');

        insert into KOVA (ID, ACTION, KOVA_NUMBER, ORDER_NUMBER, SPLIT_INDICATION) values (send_id, $3, $4, $5, $6);

        insert into KOVA_DET (ID, CNT, MATERIAL, WEIGHT) values (send_id, $7, $8, $9);
    commit;
    end
$$;

create or replace procedure sp_insert_send_message_pota_info
		(int, bit, varchar(1), varchar(2), int, int, boolean, varchar(40), varchar(40), varchar(40))
language plpgsql
as $$
    declare
        send_id int;
    begin
        insert into SEND (MSG_ID, SEND_TIME, STATUS) values ($1, current_timestamp, $2);
        
        send_id = currval('SEND_ID_seq');

        insert into POTA (ID, ACTION, POTA_NUMBER, HEAT_COUNTER, TIME_SINCE_LAST_USE, POTA_IN_CYCLE, REFACTORY_SIDE,
                            REFACTORY_BOTTOM, REFACTORY_SLAG_AREA)
        values (send_id, $3, $4, $5, $6, $7, $8, $9, $10);
    commit;
    end
$$;








