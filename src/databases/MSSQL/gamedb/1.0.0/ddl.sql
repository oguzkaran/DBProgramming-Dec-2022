/*----------------------------------------------------------------------------------------------------------------------
	dbpd22_gamesdb veritabanı Version: 1.0.0
-----------------------------------------------------------------------------------------------------------------------*/
-- DDL commands

create database dbpd22_gamesdb

go

use dbpd22_gamesdb


go


-- CREATE TABLE COMMANDS

create table players (       
	player_id int primary key identity(1, 1),
	nick_name nvarchar(50) unique not null,
	password nvarchar(50) check(len(password) >= 5) not null,
	first_name nvarchar(100) not null,
	middle_name nvarchar(100),
	last_name nvarchar(100) not null,
	email nvarchar(100) not null,
	register_date date default(getdate()) not null,
	birth_date date not null
)

go

create table games (
	game_id int primary key identity(1, 1),
	name nvarchar(255) not null,
	publisher nvarchar(255) not null,
	release_date date not null,
	is_available bit default(1) not null
);


-- One player play many games, One game is played by many players

create table players_to_games (
	player_to_game_id bigint primary key identity(1, 1),
	player_id int foreign key references players(player_id) not null,
	game_id int foreign key references games(game_id) not null,
	start_date date default(getdate()) not null
);

create table players_to_games_play_data (
	player_to_game_data_id bigint primary key identity(1, 1),
	player_to_game_id bigint foreign key references players_to_games(player_to_game_id) not null,
	begin_time datetime default(sysdatetime()) not null,
	end_time datetime,
	score bigint default(0) not null
);


