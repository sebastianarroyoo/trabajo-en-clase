create database TiendaMascota;
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
references Mascota(idMascota );

alter table Mascota_Vacuna
add constraint FKVM
foreign key (codigoVacunaFK)
references Vacuna(codigoVacuna);

---------------------------------------------------------------------------------------------

INSERT INTO Mascota VALUES (1, 'Firulais', 'Macho', 'Labrador', 1),(3, 'Luna', 'Hembra', 'Golden Retriever', 2),(4, 'Rocky', 'Macho', 'Pastor Alemán', 1),(5, 'Bella', 'Hembra', 'Poodle', 1);

-- Insertar un cliente
INSERT INTO Cliente VALUES (101, 'Carlos', 'Perez', 'Calle 123', 987654321, 1), ;

-- Insertar un producto
INSERT INTO Producto VALUES (201, 'Croquetas', 'Pedigree', 25.99, 101);

-- Insertar una vacuna
INSERT INTO Vacuna VALUES (301, 'RabiaPlus', 1, 'Rabia');

-- Insertar una relación entre mascota y vacuna
INSERT INTO Mascota_Vacuna VALUES (301, 1, 'Rabia');

