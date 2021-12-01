drop table if exists genres cascade;
create table genres(
	id_genre serial primary key,
	genre varchar(20)
);
drop table if exists games cascade;
create table games (
	id_game serial primary key,
	name varchar(300),
	id_genre int
);
drop table if exists publishers cascade;
create table publishers (
	id_publisher serial primary key,
	publisher varchar(200)
);
drop table if exists platform cascade;
create table platform (
	id_platform serial primary key,
	platform varchar
);
drop table if exists game_publisher cascade;
create table game_publisher (
	id serial primary key,
	game int,
	publisher int
);

drop table if exists game_platform cascade;
create table game_platform (
	id serial primary key,
	year varchar,
	game_publisher int,
	platform int
);
drop table if exists sales cascade;
create table sales (
	game_platform int,
	area int,
	num_sales decimal
);
drop table if exists areas cascade;
create table areas (
	id_area serial primary key,
	area varchar
);

alter table games add constraint fk_genres foreign key (id_genre) references genres(id_genre) on update cascade on delete set null;

alter table game_publisher add constraint fk_game foreign key (game) references games(id_game) on update cascade on delete cascade;
alter table game_publisher add constraint fk_publisher foreign key (publisher) references publishers(id_publisher) on update cascade on delete cascade;

alter table game_platform add constraint fk_game_publisher foreign key (game_publisher) references game_publisher(id) on update cascade on delete cascade;
alter table game_platform add constraint fk_platform foreign key (platform) references platform(id_platform) on update cascade on delete cascade;


alter table sales add constraint fk_game_platform foreign key (game_platform) references game_platform(id) on update cascade on delete cascade;
alter table sales add constraint fk_area foreign key (area) references areas(id_area) on update cascade on delete cascade;
