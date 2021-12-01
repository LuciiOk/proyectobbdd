create role usuario1 with encrypted password 'usuario1';
create role usuario2 with encrypted password 'usuario2';


--privilegios USUARIO
grant select on areas to usuario1;
grant select on game_platform to usuario1;
grant select on game_publisher to usuario1;
grant select on games to usuario1;
grant select on genres to usuario1;
grant select on platform to usuario1;
grant select on publishers to usuario1;
grant select on sales to usuario1;
grant select on temporal to usuario1;

-- vista ventas globales
CREATE VIEW globalView as 
SELECT g.name, pl.platform, gp.year, pub.publisher, sum(sales.num_sales) as global FROM sales 
	INNER JOIN areas r ON sales.area = r.id_area
	INNER JOIN game_platform gp ON sales.game_platform = gp.id
	INNER JOIN game_publisher gpub ON gp.game_publisher = gpub.id
	INNER JOIN games g ON gpub.game = g.id_game
	INNER JOIN platform pl ON gp.platform = pl.id_platform
	INNER JOIN publishers pub ON gpub.publisher = pub.id_publisher
	group by g.name, pl.platform, gp.year, pub.publisher
	order by sum(sales.num_sales) desc;

--- vista con todos los valores de las tablas
CREATE VIEW generalView as 
SELECT g.name, pl.platform, gp.year, pub.publisher, sales.num_sales, r.area FROM sales 
	INNER JOIN areas r ON sales.area = r.id_area
	INNER JOIN game_platform gp ON sales.game_platform = gp.id
	INNER JOIN game_publisher gpub ON gp.game_publisher = gpub.id
	INNER JOIN games g ON gpub.game = g.id_game
	INNER JOIN platform pl ON gp.platform = pl.id_platform
	INNER JOIN publishers pub ON gpub.publisher = pub.id_publisher order by sales.num_sales desc;


----create view de cada tabla
CREATE VIEW vistasArea as 
	select * from areas;
	
CREATE VIEW vistasgame_platform as
	select * from game_platform;
	
CREATE VIEW vistasgame_publisher as
	select * from game_publisher;
	
CREATE VIEW vistasgames as
	select * from games;
	
CREATE VIEW vistasgenres as
	select * from genres;
	
CREATE VIEW vistasplatform as
	select * from platform;
	
CREATE VIEW vistaspublishers as
	select * from publishers;
	
CREATE VIEW vistassales as
	select * from sales;
	
CREATE VIEW vistastemporal as
	select * from temporal;