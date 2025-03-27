create database TiendaMascota;

drop database TiendaMascota;
/*Habilitar la base de datos*/
use TiendaMascota;
/*Creacion de tablas*/
create table Mascota(
idMascota int primary key,
nombreMascota varchar (15),
generoMascota varchar (15),
razaMascota varchar (15),
cantidad int (10)
);
create table Cliente(
cedulaCliente int primary key,
nombreCliente varchar (15),
apellidoCliente varchar (15),
direccionCliente varchar (10),
telefono int (10),
idMascotaFK int
);
create table Producto(
codigoProducto int primary key,
nombreProducto varchar (15),
marca varchar (15),
precio float,
cedulaClienteFK int
);
create table Vacuna(
codigoVacuna int primary key,
nombreVacuna varchar (15),
dosisVacuna int (10),
enfermedad varchar (15)
);
create table Mascota_Vacuna(
codigoVacunaFK int,
idMascotaFK int,
enfermedad varchar (15)
);
/*crear las relaciones*/
alter table Cliente
add constraint FClienteMascota
foreign key (idMascotaFK)
references Mascota(idMascota);

alter table Producto
add constraint FKProductoCliente
foreign key (cedulaClienteFK)
references Cliente(cedulaCliente);

alter table Mascota_Vacuna
add constraint FKMV
foreign key (idMascotaFK)
references Mascota(idMascota);

alter table Mascota_Vacuna
add constraint FKVM
foreign key (codigoVacunaFK)
references Vacuna(codigoVacuna);

---------------------------------------------------------------------------------------------

INSERT INTO Mascota VALUES (1, 'Firulais', 'Macho', 'Labrador', 1),(3, 'Luna', 'Hembra', 'Golden Retriever', 2),(4, 'Rocky', 'Macho', 'Pastor Alemán', 1),(5, 'Bella', 'Hembra', 'Poodle', 1);

-- Insertar un cliente
INSERT INTO Cliente VALUES (101, 'Carlos', 'Perez', 'Calle 123', 987654321, 1);

-- Insertar un producto
INSERT INTO Producto VALUES (201, 'Croquetas', 'Pedigree', 25.99, 101);

-- Insertar una vacuna
INSERT INTO Vacuna VALUES (301, 'RabiaPlus', 1, 'Rabia');

-- Insertar una relación entre mascota y vacuna
INSERT INTO Mascota_Vacuna VALUES (301, 1, 'Rabia');

----------------------------------------------------------------------------------------------------------------------
select m.*, nombreCliente from Mascota m left join cliente c on m.idMascota = c.idMascotaFK;
select m.*, nombreCliente from Mascota m right join cliente c on m.idMascota = c.idMascotaFK;

select m.*, c.nombreCliente, p.nombreProducto from Mascota m join cliente c on m.idMascota = idMascotaFK join producto p on p.cedulaClienteFK = c.cedulaCliente;

-- Eliminacion
delete from producto where codigoProducto = 11;
describe producto;
delete from producto

-- Procedimiento almacenado

DELIMITER //
CREATE PROCEDURE InsertarMascota(in idMascota int,  nombreMascota varchar(15),
 generoMascota varchar(15), cantidad int)
begin 
	insert into mascota (idMascota,nombreMascota,generoMascota,cantidad)
    VALUES (idMascota,nombreMascota,generoMascota,cantidad);
    END  //
    DELIMITER ;
    
    call InsertarMascota ("6","Temu","Macho","200");
    
    DELIMITER //
CREATE PROCEDURE ConsultarPrecio(out PRECIO float)
BEGIN 
select count(*) into precio from producto;
    END  //
    DELIMITER ;
    
CALL ConsultarPrecio(@resultado);
select @resultado;
-- crear un procedimiento para insertar registros en tabla débil
-- otro procedimiento para consultar las vacunas que se le ha aplicado a una mascota y que enfermedad está atacando

-- 1 
DELIMITER //

CREATE PROCEDURE InsertarVacunaMascota(
    IN p_codigoVacuna INT,
    IN p_idMascota INT,
    IN p_enfermedad VARCHAR(15)
)
BEGIN
    -- Insertar un registro en la tabla Mascota_Vacuna
    INSERT INTO Mascota_Vacuna (codigoVacunaFK, idMascotaFK, enfermedad)
    VALUES (p_codigoVacuna, p_idMascota, p_enfermedad);
END //

DELIMITER ;

CALL InsertarVacunaMascota(301, 1, 'Rabia');

-- 2 
DELIMITER //
drop procedure ConsultarVacunaMascota;

CREATE PROCEDURE ConsultarVacunasMascota(
    IN p_idMascota INT
)
BEGIN
    -- Consultar las vacunas y las enfermedades para una mascota específica
    SELECT 
        m.nombreMascota,
        v.nombreVacuna,
        mv.enfermedad
    FROM
        Mascota_Vacuna mv
    JOIN 
        Vacuna v ON mv.codigoVacunaFK = v.codigoVacuna
    JOIN 
        Mascota m ON mv.idMascotaFK = m.idMascota
    WHERE 
        mv.idMascotaFK = p_idMascota;
END //

DELIMITER ;

CALL ConsultarVacunasMascota(1);

------------------------------------------------------------------------------------------------------------------------------

-- Vistas o views
-- es una consulta alacenada en la base de datosque genera una tabla virtual

-- sintaxis: create view nombreVista as select valoresaConsultar from nombreTabla where condiciones 

create view vistaCliente as
select * from cliente where cedulaCliente = " ";

select * from cliente;

-- EJERCICIO 
create view vistaTelefonoCliente as select * from cliente where telefonoCliente like "%3%" and telefonoCliente like "%4%" 
and telefonoCliente like "%6%";

-- modificar una vista

-- alter view vistaTelefonoCliente as; -- sintaxis que quiero usar

-------------------------------------------------------

-- Disparadores o triggers
-- tipos
-- before insert, before update, before delete ----- Se ejecutan despues de la operacion
-- after .... 
-- SINTAXIS
/*
DELIMITER //
CREATE TRIGGER nombreTrigger
AFTER INSERT ON nombreTabla
FOR EACH ROW
BIGIN
-- instrucciones sql;

END //
DELIMITER;
*/
 
 /* CREAR UN TRIGGER PARA REGISTRAR EN UNA TABLA CONSOLIDADO CADA VEZ QUE SE INSERTE UNA MASCOTA*/
 
CREATE TABLE consolidado(
idMascota int primary key,
nombreMascota varchar (15),
generoMascota varchar (15),
razaMascota varchar (15),
cantidad int (10)
);

DELIMITER //
CREATE TRIGGER registrarConsolidadoMascota
AFTER INSERT ON  mascota
FOR EACH ROW
BEGIN
	INSERT INTO consolidado VALUES (NEW.nombreMascota,NEW.nombreMascota,new.generoMascota,new.razamascota,new.cantidad); 
END //

DELIMITER ;
insert into mascota values(5555,"arroyo","F","bobo",1);
select * from consolidado;

create table clientesEliminados (
cedulaCliente int primary key,
nombreCliente varchar (15),
apellidoCliente varchar (15),
direccionCliente varchar (10),
telefono int (10),
idMascotaFK int
);

DELIMITER //
CREATE TRIGGER registrarClientesEliminados
AFTER DELETE ON  cliente
FOR EACH ROW
BEGIN
	INSERT INTO clientesEliminados VALUES 
    (old.cedulaCliente,old.nombreCliente,old.apellidoCliente,old.direccionCliente,old.telefono); 
END //

DELIMITER ;

delete from cliente where nombreCliente= "Carlos";
delete from mascota where idMascota = 1;

select * from clientesEliminados;
select * from cliente;
describe cliente;

SET SQL_SAFE_UPDATES = 0;


