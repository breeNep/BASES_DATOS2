/*Ejercicio 3 Seguridad
/*Brenda Areli Lopez Nepomuceno // Jesus Alberto Baltazar Ramirez */
show databases;
use credito;
show tables from credito;
select * from mysql.user;
drop user 'admin'@'localhost';

create user 'admin'@'localhost' identified by 'admin1';
/* */
/*create user 'operador2'@'localhost' identified by 'ope2';*/

show grants for 'admin'@'localhost';





