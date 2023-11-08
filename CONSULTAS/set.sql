use colegio2807;

DELIMITER $$
drop procedure if exists obtenerNivelAlumno $$
create procedure obtenerNivelAlumno(in p_clave_alu varchar(25),
out p_nivel_alumno varchar(10),out tpago decimal(15, 2))
begin
select ifnull (SUM(pago),0) into tpago from pagos where clave_alu = p_clave_alu;
CASE 
when  tpago > 30000 then 
set p_nivel_alumno = 'PLATINO';
when  (tpago <= 30000 and tpago >= 20000) then
set p_nivel_alumno = 'ORO';
when  (tpago > 0 and tpago < 20000) then 
set p_nivel_alumno = 'PLATA';
else
set p_nivel_alumno = 'SIN NIVEL';
END case;
end $$
delimiter ;

set @cve_alu = '11070167';
call obtenerNivelAlumno(@cve_alu, @nivel_alu, @pagos_sum);

select nombre, ap_paterno, ap_materno, @pagos_sum
from alumnos where clave_alu = @cve_alu