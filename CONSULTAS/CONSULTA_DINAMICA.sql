use colegio2807;

PREPARE stmt from 'select * from alumnos where sexo = ? and id_estado = ?;';

set @sexo = 'F';
set @id_estado = 22;

execute stmt using @sexo, @id_estado;

set @col = 'ciudad';
set @tabla = 'profesores';
set @sexo = 'M';
set @statement = concat('select ', @col, ' from ', @tabla, ' where sexo = ?');

prepare stmt from @statement;
execute stmt using @sexo;

select @statement;

DELIMITER $$
DROP PROCEDURE IF EXISTS consultaDinamica $$
CREATE PROCEDURE consultaDinamica(
    IN tabla  varchar(20), 
    IN sexo varchar(1), 
    IN sortby INT)
BEGIN
    SET @query = CONCAT(
        'SELECT ',
        'CONCAT_WS(\' \', ',
        IF(tabla='alumnos', 'ap_paterno, ap_materno, nombre', 'apellido_p, apellido_m, nombres') , ') nombre, curp, sexo, email',
        ' FROM ', IF(tabla='alumnos', 'alumnos', 'profesores'),    
        IF(sexo in('F', 'M'), CONCAT(' WHERE sexo = \'', sexo, '\''), ''),
       ' ORDER BY nombre ', IF(sortby=0, 'ASC', 'DESC'));
    PREPARE stmt FROM @query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END$$
DELIMITER ; 

call consultaDinamica('profesores', 'M', 1); 
select @query;