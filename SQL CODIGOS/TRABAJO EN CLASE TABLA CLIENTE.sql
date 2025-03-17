-- consultas de bases de datos
-- 0000/00/00 Formato de fecha (ejemplo)

CREATE DATABASE ejericio_en_clase;
USE ejericio_en_clase;

CREATE TABLE cliente(
codigo INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
nombre VARCHAR(20) NOT NULL,
domicilio VARCHAR(40) NOT NULL,
ciudad VARCHAR(20),
provincia VARCHAR(30),
telefono VARCHAR(10)
);

INSERT INTO cliente VALUES (null,"Juan David","Calle 20 #2-15","Pasto","Nariño","3204567890"),
(null,"Valentina","Calle 56 #32-15","Bogotá","Cundinamarca","3125948790"),
(null,"Sara","Carrera 230 #1-45","Bogotá","Cundinamarca","3148679230"),
(null,"Julian Fernando","Calle 18 #3-18","Cali","Valle Del Cauca","3104047722"),
(null,"William Alejandro","Calle 35 #7-10","Pasto","Nariño","3204567890");

DESCRIBE cliente;

-- consulta general

select * from cliente;

-- consulta especifica
-- <> significa diferente
select codigo_cliente, nombre_cliente from cliente;
select nombre from cliente where nombre = "Julian Fernando" and codigo = 4;
select telefono from cliente where telefono <> "3148679230" or nombre = "Sara";
select codigo from cliente where codigo >= 1;
select codigo from cliente where codigo <= 5;
select nombre from cliente where not nombre = "Valentina";

-- Alias/ Se escribe lo siguiente(select campo1 as "nombre del alias que se deasea mostrar", campo2 as "....", ...  from nombreTabla;
-- le da a cada campo que se desee el nombre que se desee, puede ignorar las reglas del lenguaje, se pueden incluir mayusculas, tildes etc.
select nombre as "Nombre Cliente", domicilio as "Dirección Cliente", ciudad, provincia as "Departamento", telefono as "Telefono" from cliente;

-- Ordenar de manera ascendente o descendente (selecto camposAConsultar from nombreTabla order by campoOrdenar tipo orden;
select * from cliente order by telefono asc;
select * from cliente order by telefono desc;

-- Consulta aplicando todo lo aprendido
select nombre as "Nombre Cliente", domicilio, ciudad, telefono from cliente where nombre <> "Valentina" order by telefono asc;

-- Consultas agrupando group by select camposConsultar form nombreTabla condicion group by campoAgrupar orden;
select nombre as "Nombre Cliente", domicilio, ciudad, telefono from cliente where nombre = "Valentina" group by telefono asc;

-- like not like
-- select camposAConsultar from nombreTabla condicion like valorConsultar;
select * from cliente where nombre like "%a%" -- contiene a
select * from cliente where nombre like "a%" -- empieza por a
select * from cliente where nombre like "a%" -- finaliza en a

-- Eliminadores
truncate table cliente;
drop database ejercicio_en_clase;
drop table cliente; 