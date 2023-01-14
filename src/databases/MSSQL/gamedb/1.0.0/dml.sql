-- INSERT

-- Insert a game
insert into games (name, publisher, release_date, is_available) values ('Fifa 2022', 'Electronic Arts', '2022-03-23', 1)

-- MISC QUERIES

-- Select all games with all fields
select * from games

-- Select all games with name, release_date and is_available fields 
select name, release_date, is_available from games

-- Select available games with name, release_date and publisher fields
select name, release_date, publisher from games where is_available = 1

-- Select games with name, release_date and publisher fields where are available and the publisher is Yabox
select name, release_date, publisher from games where is_available = 1 and publisher = 'Yabox'

-- Select games with name, release_date and publisher fields where are available and the publisher is Yabox
select g.name as game_name, 
g.release_date, 
g.publisher
from games g
where g.is_available = 1 and g.publisher = 'Yabox';


select first_name, last_name, email from players where nick_name = 'zmacmeekingt';


-- start_date'i bilinen silinmemiş, oyunların bilgilerini getiren sorgu

select g.name, g.release_date
from players_to_games ptg inner join games g on ptg.game_id = g.game_id 
where start_date = '2022-11-19' and g.is_available = 1;

-- self join, cartesian query
select g.name, g.release_date 
from players_to_games ptg, games g 
where ptg.game_id = g.game_id and start_date = '2022-11-19' and g.is_available = 1;


-- Skoru 1000'den büyük olan silinmemiş oyunların bilgilerini getiren sorgu

select g.game_id, g.name, ptgpd.score
from 
players_to_games_play_data ptgpd inner join players_to_games ptg on ptgpd.player_to_game_id = ptg.player_to_game_id 
inner join games g on g.game_id = ptg.game_id 
where g.is_available = 1 and ptgpd .score  > 20000

select g.game_id, g.name, ptgpd.score
from players_to_games_play_data ptgpd, games g, players_to_games ptg 
where 
ptgpd.player_to_game_id = ptg.player_to_game_id and g.game_id = ptg.game_id 
and g.is_available = 1 and ptgpd .score  > 20000

-- Skoru 1000'den büyük olan silinmemiş oyunları oynayan oyuncular ile birlikte getiren sorgu

-- UPDATE 

-- Update is_available to the inverse field of all games where the publisher is 'Yabox'
update games set is_available = 1 - is_available where publisher='Yabox';

select * from games where publisher = 'Yabox';


-- DELETE 

-- Delete games where are not available and the publisher is 'Yabox'

delete from games where is_available = 0 and publisher = 'Yabox';



 