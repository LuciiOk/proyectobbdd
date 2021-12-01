DROP TABLE IF EXISTS transacciones; 
create table transacciones(
	tabla varchar not null,
	accion varchar not null,
	fechaHora timestamp not null,
	usuario varchar not null,
	camposInsertados varchar,
	camposModificados varchar
);

-- funcion trigger --
create or replace function auditoria() returns trigger as 
$$
	declare 
		camposInsertados varchar;
		camposMod varchar;
	begin
		camposMod := concat(old.*);
		camposInsertados := concat(new.*);
		if TG_OP = 'DELETE' then
			INSERT INTO transacciones values (TG_TABLE_NAME, TG_OP, now(), user, null, camposMod);
			return old;
		end if;
		if TG_OP = 'INSERT' then
			INSERT INTO transacciones values (TG_TABLE_NAME, TG_OP, now(), user, camposInsertados, null);
			return new;
		end if;
		if TG_OP = 'UPDATE' then
			INSERT INTO transacciones values (TG_TABLE_NAME, TG_OP, now(), user, camposInsertados, camposMod);
			return new;
		end if;
		return null;
	end;
$$ language plpgsql;

DROP TRIGGER IF EXISTS tr_games ON games;
create trigger tr_games after update or insert or delete
	on sales
	for each row
	execute procedure auditoria();
	
DROP TRIGGER IF EXISTS tr_game_platform ON releases;
create trigger tr_releases after update or insert or delete
	on game_platform
	for each row
	execute procedure auditoria();
	
	
--TRIGGER VALIDACIÓN JUEGO
CREATE OR REPLACE FUNCTION validar_juego() RETURNS TRIGGER AS
$$

BEGIN
	
	IF NEW.num_sales < 0 then
		 	 
	END if;
	raise exception 'tiene que ser un numero mayor a cero.'
	using hint ='inserta un numero mayor a cero';
END;
$$ language plpgsql;

create trigger trigger_validacion before insert on 
	sales
	execute procedure validar_juego();

insert into sales (num_sales) values (-1)


