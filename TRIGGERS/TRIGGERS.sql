use colegio2807;

show triggers; 

DELIMITER // 
DROP TRIGGER IF EXISTS bi_nivel//
CREATE TRIGGER bi_nivel 
BEFORE INSERT ON niveles  
FOR EACH ROW 
BEGIN    
	-- SET NEW.nombre = UPPER(NEW.nombre);   
    -- SET NEW.id_nivel = NEW.id_nivel + 1000 ; 
	INSERT INTO grados 	
	SET id_grado = NEW.id_nivel,    
	nombre = concat ('grado ',NEW.nombre);
END //
 
delimiter ;

select * from niveles;
select * from grados;

insert into niveles values(100, 'DOC');
insert into niveles values(200, 'ICO');
insert into niveles values(300, 'ING');

insert into niveles values(500, 'MTI'), (600, 'MCC'), (700, 'MI');