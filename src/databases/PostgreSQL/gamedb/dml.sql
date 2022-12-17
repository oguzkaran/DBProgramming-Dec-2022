-- Insert a game
insert into games (name, publisher, release_date, is_available) values ('Fifa 2022', 'Electronic Arts', '2022-03-23', true);

-- Misc Queries

-- Select all games with all fields
select * from games;

-- Select all games with name, release_date and is_available fields 
select name, release_date, is_available from games;

-- Select available games with name, release_date and publisher fields
select name, release_date, publisher from games where is_available = true;

-- Select games with name, release_date and publisher fields where are available and the publisher is Yabox
select name, release_date, publisher from games where is_available = true and publisher = 'Yabox';


-- Update is_available to the inverse field of all games where the publisher is 'Yabox'
update games set is_available = not is_available where publisher='Yabox';

select * from games where publisher = 'Yabox';

-- Delete games where are not available and the publisher is 'Yabox'

delete from games where is_available = false and publisher = 'Yabox';



 