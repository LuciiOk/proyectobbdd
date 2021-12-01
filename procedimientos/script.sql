
-- INSERTAR JUEGO, CON PLATAFORMA, GENERO, LANZAMIENTO Y PUBLICADOR
CREATE OR REPLACE FUNCTION insertarJuegoPublicador(nameGame varchar, publisherI varchar, genreI varchar, platformI varchar, year varchar) 
	RETURNS  varchar AS $$
DECLARE
		idGenre int;
		idPublisher int;
		idPlatform int;
		idgame games.id_game%TYPE;
		idGamePublisher int;
		idGameplatform int;
BEGIN 
		idGenre := id_genre from genres where genres.genre = genreI;
		insert into games(name, id_genre) values (nameGame, idGenre) returning id_game into idgame;
		
		idPublisher := id_publisher from publishers where publishers.publisher = publisherI; -- se obtiene el id del publicador
		idPlatform := id_Platform from Platform where Platform.platform = platformI; -- se obtiene el id de la plataforma / consola
		
		-- valida que el publicador exista, si no existe lo inserta
		if (idPublisher = 0) then
			insert into publishers(publisher) values (publisher) returning id_publisher into idPublisher;
		end if;
		-- valida que la plataforma exista, si no existe la inserta
		if (idPlatform = 0) then
			insert into Platform(platform) values (platform) returning id_Platform into idPlatform;
		end if;
		
		insert into game_publisher(game, publisher) values (idgame, idPublisher) returning id into idGamePublisher;
		
		insert into game_platform(game_publisher, platform, year) values (idGamePublisher, idPlatform, year) returning id into idGameplatform;
		
		return 'El juego ha sido insertado exitosamente';
	END;
$$ LANGUAGE plpgsql;

drop table if exists ventasglobal cascade;
create table ventasglobal (
	juego varchar,
	platform varchar,
	publisher varchar,
	year varchar,
	ventasGlobal decimal
);

CREATE OR REPLACE FUNCTION getGlobalSales(platform varchar, publisher varchar, years varchar) 
RETURNS setof ventasGlobal 
AS $$
DECLARE
	micursor  cursor for (
		SELECT g.name, pl.platform, pub.publisher, gp.year, SUM(sales.num_sales) AS global_sales FROM sales 
		INNER JOIN areas r ON sales.area = r.id_area
		INNER JOIN game_platform gp ON sales.game_platform = gp.id
		INNER JOIN game_publisher gpub ON gp.game_publisher = gpub.id
		INNER JOIN games g ON gpub.game = g.id_game
		INNER JOIN platform pl ON gp.platform = pl.id_platform
		INNER JOIN publishers pub ON gpub.publisher = pub.id_publisher  
		GROUP BY g.name, pl.platform, gp.year, pub.publisher
		ORDER BY SUM(sales.num_sales) DESC);
	ventas ventasGlobal;
BEGIN
	open micursor;
		loop
			fetch next from micursor into ventas;
			exit when not found;
			
			if (publisher = ventas.publisher and platform = ventas.platform and years = ventas.year) then
				return next ventas;
				continue;
			end if;
			
			if (publisher = ventas.publisher and platform = ventas.platform) then
				return next ventas;
				continue;
			end if;

			if (publisher is null and platform is null and years is null) then 
				return next ventas;
			end if;	
		end loop;
	close micursor;
END;
$$ LANGUAGE plpgsql;


select * from getGlobalSales('PS3', 'Capcom', '2006');

CREATE OR REPLACE FUNCTION Eliminar_juego(NameGame varchar) returns varchar as
$$
declare
	id_juego bigint;
begin
	delete FROM games where name  = NameGame;
	return 'EL juego se ha eliminado con exito';
end;
$$ language plpgsql;
			

--PROCEDIMIENTO ALMACENADO ELIMINACIÓN JUEGO
CREATE OR REPLACE FUNCTION Eliminar_juego( NameGame varchar) returns varchar as
$$
declare
	Nombre varchar;
begin
	Nombre := name from games where games.name = NameGame; 
	delete FROM games where name = Nombre;
	return 'EL juego se ha eliminado con exito';
end;
$$ language plpgsql;





--PROCEDIMIENTO ALMACENADO ELIMINACIÓN PLATAFORMA
CREATE OR REPLACE FUNCTION Eliminar_plataforma( NamePlatform varchar) returns varchar as
$$
declare
	Nombre varchar;
begin
	Nombre := platform from platform where platform.platform = NamePlatform; 
	delete FROM platform where platform = Nombre;
	return 'La plataforma se ha eliminado con exito';
end;
$$ language plpgsql;




--PROCEDIMIENTO ALMACENADO ELIMINACIÓN PUBLICADOR
CREATE OR REPLACE FUNCTION Eliminar_publicador( NamePublisher varchar) returns varchar as
$$
declare
	Nombre varchar;
begin
	Nombre := publisher from publishers where publishers.publisher = NamePublisher; 
	delete FROM publishers where publisher = Nombre;
	return 'La plataforma se ha eliminado con exito';
end;
$$ language plpgsql;

--PROCEDIMIENTO ALMACENADO ACTUALIZAR JUEGO
CREATE OR REPLACE FUNCTION Actualizar_juego( id_juego int,NameGame varchar) returns varchar as
$$

begin	
	update games set name = NameGame where games.id_game = id_juego;
	return 'EL juego se ha actualizado con exito';
end;
$$ language plpgsql;


--PROCEDIMIENTO ALMACENADO ACTUALIZAR PLATAFORMA
CREATE OR REPLACE FUNCTION Actualizar_plataforma( id_plataforma int,NamePlatform varchar) returns varchar as
$$

begin	
	update platform set platform = NamePlatform where platform.id_platform = id_plataforma;
	return 'La plataforma se ha actualizado con exito';
end;
$$ language plpgsql;


--PROCEDIMIENTO ALMACENADO ACTUALIZAR PUBLICADOR
CREATE OR REPLACE FUNCTION Actualizar_publicador( id_publicador int,NamePublisher varchar) returns varchar as
$$

begin	
	update publishers set publisher = NamePublisher where publishers.id_publisher = id_publicador;
	return 'El publicador se ha actualizado con exito';
end;
$$ language plpgsql;


