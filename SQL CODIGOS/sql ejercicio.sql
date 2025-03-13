/*crear base de datos*/
use viajeur;
/*crear tabla cliente*/
create table cliente(
idCliente INT PRIMARY KEY AUTO_INCREMENT,
nombreCliente varchar(60) NOT NULL,
telefonoCliente varchar(60) NOT NULL,
dirrecionCliente text,
fechaRegistro timestamp DEFAULT current_timestamp
);
/*crear tabla pedido*/
create table pedido(
idPedido INT PRIMARY KEY AUTO_INCREMENT,
idClienteFK INT,
fechaPedido date NOT NULL,
totalPedido decimal(10,2) NOT NULL,
estado enum("pendiente","enviado","entregado","cancelado") default "pendiente",
fechaRegistro timestamp DEFAULT current_timestamp
);
/*crear tabla pedido*/
create table producto(
idproducto INT PRIMARY KEY AUTO_INCREMENT,
codigoProducto varchar(60) NOT NULL,
nombreProducto varchar(60) NOT NULL,
precioProducto decimal(10,2) NOT NULL,
stock int default 0,
fechaCreacion timestamp DEFAULT current_timestamp,
foreign key (idProducto) references producto(idProducto) on delete cascade 
);
describe producto;
/* modificar */ 
alter table producto add column descripcionProducto varchar(60) NOT NULL;
alter table producto modify column precioProducto decimal(12,2);
alter table producto rename to Producto;
/* eliminar registros de la tabla*/
truncate table producto;
/*Crear relacion */
alter table pedido
add constraint FKclientePed Foreign key (idClienteFK) references cliente (idCliente);