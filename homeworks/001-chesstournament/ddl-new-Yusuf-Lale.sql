create database chesstournamentdb

use chesstournamentdb

create table ranking (
    ranking_code int primary key identity(1, 1),
    description nvarchar(250)
)

create table result (
    result_code int primary key identity(1, 1),
    description nvarchar(250)
)

create table sponsors (
    sponsor_id int primary key identity(1, 1),
    name nvarchar(75) not null,
    phone char(11),
    details nvarchar(max)
)

create table clubs (
    club_id int primary key identity(1, 1),
    name nvarchar(100) not null,
    address nvarchar(500),
    details nvarchar(max)
)

create table organizers (
    organizer_id int primary key identity(1, 1),
    club_id int foreign key references clubs(club_id) not null,
    name nvarchar(100) not null,
    details nvarchar(max)
)

create table players (
    player_id int primary key identity(1, 1),
    club_id int foreign key references clubs(club_id) not null,
    ranking_code int foreign key references ranking(ranking_code) not null,
    name nvarchar(50) not null,
    surname nvarchar(50),
    address nvarchar(500),
    phone char(11),
    email nvarchar(100),
    details nvarchar(max)
)

create table tournaments (
    tournament_id int primary key identity(1, 1),
    organizer_id int foreign key references organizers(organizer_id) not null,
    start_date date,
    end_date date,
    name nvarchar(100) not null,
    details nvarchar(max)
)

create table tournaments_to_sponsors (
    tournaments_to_sponsors_id int primary key identity(1, 1),
    tournament_id int foreign key references tournaments(tournament_id) not null,
    sponsor_id int foreign key references sponsors(sponsor_id) not null
)

create table matches (
    match_id int primary key identity(1, 1),
    tournament_id int foreign key references tournaments(tournament_id) not null,
    player1_id int foreign key references players(player_id) not null,
    player2_id int foreign key references players(player_id) not null,
    match_start_datetime datetime,
    result_code int foreign key references result(result_code) not null,
    match_end_datetime datetime
)

create table player_partisipation (
    player_partisipation int primary key identity(1, 1),
    player_id int foreign key references players(player_id) not null,
    tournament_id int foreign key references tournaments(tournament_id) not null,
    final_result int
)