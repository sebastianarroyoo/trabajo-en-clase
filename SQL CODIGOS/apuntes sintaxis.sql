-- para crear la hojita de trabajo
CREATE DATABASE "nombre"

-- crear la tabla
CREATE TABLA "nombre" (
);
 -- dentro del paréntesis escribo las columnas, por ejemplo
(
	Nombre tipo()
)

-- renombrar
RENAME TABLE "Nombre_viejo" TO "Nombrenuevo"

-- SIEMPRE que vaya a alterar una tabla uso:
ALTER TABLE users 
ADD salary decimal(7) -- en este caso estoy alterándola para añadir otra columna

-- renombrar columna
ALTER … 
rename columna "viejo" to "nuevo"

-- cambiar tipo o tamaño
modify "antiguo nombre" nuevo tipo

-- cambiar ubicación
ALTER TABLE USERS
MODIFY "nombre" "tipo y tamaño"
AFTER "después de que columna lo quiero" si la quiero de primeras pongo first y ya

-- borrar algo
MODIFY 
DEROP COLUMN … 

-- insertar algo
INSERT INTO "nombre de la tabla"
VALUES(información de la fila en orden);

--inserto into "tabla"() en el paréntesis el orden por si lo quiero cambiar

--CONDICIONALES
select * from "tabla"
where "condición " (la condición puede ser que no sea nulo o una igualdad por ej: id=1)

--UPDATE Y DELETE
UPDATE CUESTA  	(nombe de la tabla)
SET apellido="gonzalez"  (set parametro=”valor”)
where id=2
-------
DELETE FROM CUESTA
WHERE ID=2 (condicional que quiera, sino lo uso borro todo ) 

-- AÑADIR PROPIEDADES A LA COLUMNA
ALTER TABLE practicasql
add constraint
unique(user_lastname)

-- VOLVER UNA COLUMNA NO NULA
ALTER TABLE practicasql
modify column user_name varchar(20) not null

-- VERIFICAR COSAS ANTESDE INSERTAR
create table trabajadores(
id_trabajador int primary key auto_increment,
nombre_trabajador varchar(40) not null,
pago_trabajador decimal(10,3),
constraint salario_minimo check  (pago_trabajador>1000000)
)

-- AÑADIR UN DEFAULT
alter table users
alter last_name set default "N/A"

-- AÑADIR CLAVE FORANEA
foreign key(columna) references tabla2(columna)
foreign key(idComprador) references users(id)

-- volver una columna una llave foranea
alter table users 
add constraint
fk foreign key(nombre_usuario) references compras(valorCompra)

-- CONTAR EL NUMERO DE COSAS
select count(nombre) from trabajadores 
aca estoy contando cuantos trabajadores tienen nombre

-- SELECCIONAR ELEMENTOS DE UNA LISTA
select * from trabajadores where nombre in ("juan")

-- SELECCIONAR NUMEROS EN UN RANGO
select * from trabajadores where id_trabajador between 1 and 10

-- SELECT GENERALIZADO
select * from trabajadores where nombre like "jua%"
si la cadena tiene “jua” sin importar que vaya despues, entrara al select 

-- LIMITAR SALIDA DEL SELECT
select * from trabajadores order by id_trabajador desc limit 2

-- MOSTRAR EL MAX DE ALGO
select max(id_trabajador) from trabajadores;

-- AGRUPAR SELECTS
select max(amount) as transaccion_mas_cara ,order_date  from transactions 
group by order_date 
aca muestro la transaccion mayor pero por grupos, es decir se muestra la transaccion mas grande de cada fecha

-- USAR COUNT DE MANERA UTIL
SELECT count(*) as num_transacciones,order_date as fecha_transaccion FROM transactions
group by order_date order by order_date asc
muestro el num de transacciones de determinada fecha al agrupar los counts

-- HAVING (WHERE PERO PARA GROUP BY)

-- SUBQUERY
select * from transactions where 
order_date=(select order_date from transactions where transaction_id=1000)

-- JOINS
select * from transactions inner join customers
on transactions.customer_id=customers.customer_id


-- select * from tabla_izquierda tipoJoin tabla_derecha on tabla.claveForanea=tabla2.clavePK
-- cuando hago un join los campos que deba traer pero no tengan informacion, por ejemplo voy a traer el valor de las transacciones que ha hecho un cliente, pero en la columna valor si un cliente no ha realizado transacciones mostrara null, al usar where clave2 is null solo muestro lso clientes SIN transacciones (puedo verlo como que hago un left join, y todos los clientes que tengan transacciones los descarto con el where)

-- PROCEDURES 
son como funciones
CREATE PROCEDURE insertarLenguaje(in CountryCode char(3), languaje char(30),
isOfficial enum("T","F"),Percentage decimal(4,1))
BEGIN 
	insert into countrylanguage values(CountryCode,languaje,isOfficial,Percentage);
END $$
DELIMITER ;

aca creo un procedimiento almacenado para insetrar en la tabla countrylenguaje

-- TRIGGERS , DISPARADORES
DELIMITER //
CREATE TRIGGER registrarConsolidado
AFTER INSERT ON mascota
FOR EACH ROW 
BEGIN 
	INSERT INTO CONSOLIDADO values("insert",new.idMascota);
END //
DELIMITER ;

-- SE USA AQUI AFTER INSERT O AFTER DELETE PARA CREAR UN DISPARADOR QUE REALICE UNA ACCION DEPUES DE ELIMINAR O DESPUES DE INSERTAR
-- ALGO EN X TABLA, SE PONE NEW CON UN AFTER INSERT O UN OLD CON UN AFTER DELETE

-- Lanzar un error personalizado 
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'El consumo no puede superar los 10,000 kW';

-- condicionales if, normalmente dentro de un trigger o procedimiento almacenado
BEGIN
IF NEW.consumo_kw > 10000 THEN
	SIGNAL SQLSTATE "45000"
    SET message_text = "ERROR, EL VALOR DE KW SUPERA LOS 10.000";
    END IF;
END ;