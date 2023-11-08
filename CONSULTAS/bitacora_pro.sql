drop table if exists bitacora;
create table bitacora(
    id int not null auto_increment primary key,
    fecha datetime not null,
    usuario varchar(50) not null,
    tabla varchar(50) not null,
    accion text null
);

SELECT * FROM bitacora;