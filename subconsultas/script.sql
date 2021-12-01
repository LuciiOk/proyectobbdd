SELECT * FROM
(SELECT g.name, pl.platform, gp.year, pub.publisher, sales.num_sales, r.area FROM sales 
	INNER JOIN areas r ON sales.area = r.id_area
	INNER JOIN game_platform gp ON sales.game_platform = gp.id
	INNER JOIN game_publisher gpub ON gp.game_publisher = gpub.id
	INNER JOIN games g ON gpub.game = g.id_game
	INNER JOIN platform pl ON gp.platform = pl.id_platform
	INNER JOIN publishers pub ON gpub.publisher = pub.id_publisher
	where  pub.publisher in ('Namco Bandai Games', 'Sega') or r.area = 'NORTH AMERICA') as gg
UNION 
(SELECT g.name, pl.platform, gp.year, pub.publisher, sales.num_sales, r.area FROM sales 
	INNER JOIN areas r ON sales.area = r.id_area
	INNER JOIN game_platform gp ON sales.game_platform = gp.id
	INNER JOIN game_publisher gpub ON gp.game_publisher = gpub.id
	INNER JOIN games g ON gpub.game = g.id_game
	INNER JOIN platform pl ON gp.platform = pl.id_platform
	INNER JOIN publishers pub ON gpub.publisher = pub.id_publisher
	where  pub.publisher in ('Namco Bandai Games', 'Sega') or r.area = 'NORTH AMERICA');



SELECT g.name, pl.platform, gp.year, pub.publisher, sales.num_sales, r.area FROM sales 
	INNER JOIN areas r ON sales.area = r.id_area
	INNER JOIN game_platform gp ON sales.game_platform = gp.id
	INNER JOIN game_publisher gpub ON gp.game_publisher = gpub.id
	INNER JOIN games g ON gpub.game = g.id_game
	INNER JOIN platform pl ON gp.platform = pl.id_platform
	INNER JOIN publishers pub ON gpub.publisher = pub.id_publisher
	where ( pub.publisher in ('Namco Bandai Games', 'Sega')) or (r.area = 'NORTH AMERICA');