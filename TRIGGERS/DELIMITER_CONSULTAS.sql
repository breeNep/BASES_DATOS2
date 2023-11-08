use colegio2807;
/*CONSULTA ANIDADA*/
DELIMITER $$
DROP PROCEDURE IF EXISTS obtenerAlumnosPorEstado $$
CREATE PROCEDURE obtenerAlumnosPorEstado(IN nombre_estado VARCHAR(255))
BEGIN
    SELECT * 
    FROM alumnos a
    JOIN (SELECT * FROM estados 
    WHERE (estado = nombre_estado or abreviatura = nombre_estado)) e 
    ON(a.id_estado = e.id_estado);
END$$
DELIMITER ;

call obtenerAlumnosPorEstado('QRO');
select * from estados;

/*PARAMETRO DE SALIDA (SOLO ME REGRESE UN VALOR)*/

DELIMITER $$
DROP PROCEDURE IF EXISTS contarAlumnosPorEstado $$
CREATE PROCEDURE contarAlumnosPorEstado(
    IN nombre_estado VARCHAR(25),
    OUT numero INT)
BEGIN
    SET numero = (SELECT count(clave_alu) FROM alumnos a
    JOIN (SELECT * FROM estados WHERE estado = nombre_estado) e ON(a.id_estado = e.id_estado));
    select count(clave_alu)
    into numero
    from alumnos a
    join (select * from estados 
    where (estado = nombre_estado or abreviatura = nombre_estado)) e 
    on(a.id_estado = e.id_estado);
END$$
DELIMITER ;

call contarAlumnosPorEstado('CDMX', @numero);
select @numero; /*lo guarda en una variable para despues usarla aunque este el delimiter*/

SET @niveles = (select nombre from niveles where id_nivel = 2); /*no puedo asignar un valor que no sea un cursor*/
select @niveles; /*resultado de una consulta, mientras sea para un campo*/

select * from estados;*/

DELIMITER $$
DROP PROCEDURE IF EXISTS evaluacionAlumnoMaxMinProm $$
CREATE PROCEDURE evaluacionAlumnoMaxMinProm(
IN vclave_alu VARCHAR(20),
out maximo decimal(10,2),
out minimo decimal(10,2),
out promedio decimal(10,2))
begin
SELECT max(calificacion), min(calificacion),avg(calificacion)
from evaluaciones where clave_alu = vclave_alu
into maximo, minimo, promedio;

end $$
DELIMITER ;

select * from evaluaciones order by clave_alu;
set @cve_alu = '11050190';
call evaluacionAlumnoMaxMinProm(@cve_alu, @max, @min, @prom);

select nombre, ap_paterno, ap_materno, @max, @min, @prom
from alumnos where clave_alu = @cve_alu;


/*tomar directamente de una consulta (id_curso)*/
delimiter $$
DROP PROCEDURE IF EXISTS pagos_alumnos $$
CREATE PROCEDURE pagos_alumnos(
IN vclave_alu VARCHAR(20), 
OUT pagos_count INT, OUT pagos_sum DECIMAL(10,2))
    READS SQL DATA
BEGIN
     SELECT distinct id_curso
     FROM pagos
     WHERE clave_alu = vclave_alu;
 
     SELECT COUNT(*), SUM(pago)
     FROM pagos
     WHERE clave_alu = vclave_alu
     AND id_curso = id_curso
     INTO pagos_count, pagos_sum;
     
	set pagos_sum_tot = pagos_sum;
END $$
delimiter ;

set @pst = 0;
set @cve_alu = '11050190';
call pagos_alumnos(@cve_alu, @pagos_count, @pagos_sum, @pst);

select nombre, ap_paterno, ap_materno, @pagos_count, @pagos_sum, @pst
from alumnos where clave_alu = @cve_alu;

select * from pagos limit 10;
