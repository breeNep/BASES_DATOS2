use colegio2807;

DELIMITER $$
drop procedure if exists listarPersonas $$
create procedure listarPersonas(in tabla varchar(30))
begin
case lower (tabla)
when 'alumnos' then
select clave_alu clave, concat_ws(' ',ap_paterno,ap_materno, nombre)
persona,sexo,curp, 'alumno' tipo from alumnos order by 2;
when 'profesores'then
select clave_prof clave, concat_ws(' ',apellido_p,apellido_m, nombres)
persona,sexo,curp, 'profesor' tipo from profesores order by 2;
when 'todos' then
select clave_alu clave, concat_ws(' ',ap_paterno,ap_materno, nombre)
persona,sexo,curp, 'alumno' tipo from alumnos
union
select clave_prof clave, concat_ws(' ',apellido_p,apellido_m, nombres)
persona,sexo,curp, 'profesor' tipo from profesores order by 2;
else 
select concat('SIN DATOS PARA ',UPPER(tabla)) tipo;


END case;
end $$
delimiter ;

call listarPersonas ('alumnos');
call listarPersonas ('profesores');
call listarPersonas ('todos');
call listarPersonas ('clientes');