/*----------------------------------------------------------------------------------------------------------------------
	dbpd22_gamesdb veritabanı Version: 1.0.0
-----------------------------------------------------------------------------------------------------------------------*/
-- DDL commands

-- CREATE TABLE COMMANDS

create table players (       
	player_id serial primary key,
	nick_name character varying(50) unique not null,
	password character varying(50) check(length(password) >= 5)  not null,
	first_name character varying(100) not null,
	middle_name character varying(100),
	last_name character varying(100) not null,
	email character varying(100) not null,
	register_date date default(current_date) not null,
	birth_date date not null
);

create table games (
	game_id serial primary key,
	name varchar(255) not null,
	publisher varchar(255) not null,
	release_date date not null,
	is_available bool default(true) not null
);


-- One player play many games, One game is played by many players

create table players_to_games (
	player_to_game_id bigserial primary key,
	player_id int references players(player_id) not null,
	game_id int references games(game_id) not null,
	start_date date default(current_date) not null
);

create table players_to_games_play_data (
	player_to_game_data_id bigserial primary key,
	player_to_game_id bigint references players_to_games(player_to_game_id) not null,
	begin_time timestamp default(current_timestamp) not null,
	end_time timestamp,
	score bigint default(0) not null
);


