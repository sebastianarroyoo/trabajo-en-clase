-- 1
create database onlineBD;
use onlineBD;

-- 2 

create table clientes(
idCliente int auto_increment primary key,
nombreCliente varchar(20) not null,
telefonoCliente varchar(14) not null,
direccionCliente varchar(30) not null,
fechaRegistro datetime not null
);

create table libros(
idLibro int auto_increment primary key,
tituloLibro varchar(30) not null,
autorLibro varchar (20) not null,
precioLibro int not null
);

create table pedidos (
idPedido int auto_increment primary key, 
cantidadPedido int not null,
idClienteFK int not null,
idLibroFK int not null,
foreign key (idClienteFK) references clientes(idCliente) on delete cascade,
foreign key (idlibroFK) references libros(idLibro) on delete cascade
);

create table libros_ pedidos (

);

describe clientes;
describe libros; 
describe pedidos;
select * from clientes;
select * from libros;
select * from pedidos;

-- 3 ya realizado
-- 4

insert into clientes (nombreCliente, telefonoCliente, direccionCliente, fechaRegistro) values
('Juan Pérez', '1234567890', 'Calle Falsa 123', '2023-01-15 10:00:00'),
('María Gómez', '0987654321', 'Avenida Siempre Viva 742', '2023-02-20 11:30:00'),
('Carlos López', '1122334455', 'Boulevard de los Sueños', '2023-03-05 09:15:00'),
('Ana Martínez', '2233445566', 'Calle de la Amistad 456', '2023-04-10 14:45:00'),
('Luis Fernández', '3344556677', 'Plaza Mayor 789', '2023-05-25 16:00:00');

insert into libros (tituloLibro, autorLibro, precioLibro) values
('El Quijote', 'Miguel de Cervantes', 19),
('Cien años de soledad', 'Gabriel García Márquez', 15),
('1984', 'George Orwell', 12),
('La sombra del viento', 'Carlos Ruiz Zafón', 20),
('El amor en los tiempos del cólera', 'Gabriel García Márquez', 18);

insert into pedidos (cantidadPedido, idClienteFK, idLibroFK) values
(2, 1, 1),  -- Juan Pérez pide 2 copias de "El Quijote"
(1, 2, 2),  -- María Gómez pide 1 copia de "Cien años de soledad"
(3, 3, 3),  -- Carlos López pide 3 copias de "1984"
(1, 4, 4),  -- Ana Martínez pide 1 copia de "La sombra del viento"
(2, 5, 5);  -- Luis Fernández pide 2 copias de "El amor en los tiempos del cólera"

-- 5

DELIMITER //

create trigger ActualizarStock
after insert on pedidos
for each row
begin
    update libros
    set stock = stock - NEW.cantidadPedido
    where idLibro = NEW.idLibroFK;
end;

//

DELIMITER ;

-- 6

select * tabla