drop table if exists temporal cascade;
create table temporal (
	rank int, 
	name varchar(250),
	platform varchar(100),
	year varchar,
	genre varchar(100),
	publisher varchar(100),
	NA_Sales decimal,
	EU_Sales decimal,
	JP_Sales decimal,
	Other_Sales decimal,
	GLOBAL_Sales decimal
);

copy temporal from 'C:\Users\lport\OneDrive\Escritorio\Proyecto BBDD\vgsales.csv'
	CSV delimiter ',' header encoding 'Latin1';
	
insert into genres(genre) select distinct genre from temporal;
insert into platform(platform) select distinct platform from temporal;
insert into publishers(publisher) select distinct publisher from temporal;

insert into games(name, id_genre)
select distinct  name, id_genre from temporal
inner join genres on temporal.genre = genres.genre;

insert into game_publisher(game, publisher)
select distinct games.id_game, publishers.id_publisher from temporal
inner join games on games.name = temporal.name
inner join publishers on publishers.publisher = temporal.publisher;

insert into game_platform(platform, game_publisher, year)
select distinct id_platform, game_publisher.id, year from temporal
inner join platform on platform.platform = temporal.platform
inner join games on games.name = temporal.name
inner join publishers on publishers.publisher = temporal.publisher
inner join game_publisher on id_game = game_publisher.game and id_publisher = game_publisher.publisher;

insert into areas(area) values('NORTH AMERICA');
insert into areas(area) values('EUROPE');
insert into areas(area) values('JAPAN');
insert into areas(area) values('OTHER');

insert into sales(game_platform, num_sales, area)
select distinct game_platform.id, NA_SALES, id_area from temporal
inner join platform on platform.platform = temporal.platform
inner join games on games.name = temporal.name
inner join publishers on publishers.publisher = temporal.publisher
inner join game_publisher on game_publisher.publisher = id_publisher and game_publisher.game = games.id_game
inner join game_platform on game_platform.platform = platform.id_platform and game_publisher = game_publisher.id
inner join areas on areas.area = 'NORTH AMERICA';

insert into sales(game_platform, num_sales, area)
select distinct game_platform.id, EU_SALES, id_area from temporal
inner join platform on platform.platform = temporal.platform
inner join games on games.name = temporal.name
inner join publishers on publishers.publisher = temporal.publisher
inner join game_publisher on game_publisher.publisher = id_publisher and game_publisher.game = games.id_game
inner join game_platform on game_platform.platform = platform.id_platform and game_publisher = game_publisher.id
inner join areas on areas.area = 'EUROPE';

insert into sales(game_platform, num_sales, area)
select distinct game_platform.id, JP_SALES, id_area from temporal
inner join platform on platform.platform = temporal.platform
inner join games on games.name = temporal.name
inner join publishers on publishers.publisher = temporal.publisher
inner join game_publisher on game_publisher.publisher = id_publisher and game_publisher.game = games.id_game
inner join game_platform on game_platform.platform = platform.id_platform and game_publisher = game_publisher.id
inner join areas on areas.area = 'JAPAN';

insert into sales(game_platform, num_sales, area)
select distinct game_platform.id, other_SALES, id_area from temporal
inner join platform on platform.platform = temporal.platform
inner join games on games.name = temporal.name
inner join publishers on publishers.publisher = temporal.publisher
inner join game_publisher on game_publisher.publisher = id_publisher and game_publisher.game = games.id_game
inner join game_platform on game_platform.platform = platform.id_platform and game_publisher = game_publisher.id
inner join areas on areas.area = 'OTHER';



