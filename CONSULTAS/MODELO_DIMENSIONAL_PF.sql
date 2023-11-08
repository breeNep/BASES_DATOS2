use credito;

DROP TABLE IF EXISTS dim_fecha;
CREATE TABLE dim_fecha (
  fecha_id INT PRIMARY KEY,
  fecha DATE,
  dia_semana VARCHAR(20),
  mes INT,
  anio INT
);

DROP TABLE IF EXISTS dim_empleado;
CREATE TABLE dim_empleado (
  empno INT PRIMARY KEY,
  enombre VARCHAR(100),
  deptono VARCHAR(50)
);

DROP TABLE IF EXISTS dim_tienda;
CREATE TABLE dim_tienda (
  tiendano INT PRIMARY KEY,
  tnombre VARCHAR(50),
  tipo VARCHAR(100)
);

  DROP TABLE IF EXISTS dim_consumo;
  CREATE TABLE dim_consumo (
   cuentano INT PRIMARY KEY,
   tiendano INT,
   movimiento CHAR(1),
   importe DECIMAL(10, 2)
   );

ALTER TABLE dim_consumo ADD FOREIGN KEY (tiendano) REFERENCES dim_tienda (tiendano);

DROP TABLE IF EXISTS fact_ventas;
CREATE TABLE fact_ventas (
  venta_id INT PRIMARY KEY,
  fecha_id INT,
  empno INT,
  tiendano INT,
  cuentano INT,
  monto DECIMAL(10, 2),
  FOREIGN KEY (fecha_id) REFERENCES dim_fecha (fecha_id),
  FOREIGN KEY (empno) REFERENCES dim_empleado (empno),
  FOREIGN KEY (tiendano) REFERENCES dim_tienda (tiendano),
  FOREIGN KEY (cuentano) REFERENCES dim_consumo (cuentano)
);

show tables;
