create database BDmental; 
use BDmental;

create table usuarios (
id_usuario int auto_increment primary key,
nombre varchar(40) not null,
email varchar(40) not null,
contraseña varchar(40) not null,
fecha_nacimiento date not null,
genero varchar(20) not null,
carrera_universitaria varchar(30) not null,
fecha_registro date not null
);

create table sesiones (
id_sesion int auto_increment primary key,
titulo varchar(40) not null,
duracion varchar(40) not null,
nivel_facultad varchar(40) not null,
descripcion varchar(20) not null
);

create table bitacoras (
id_bitacoras int auto_increment primary key,
estado_animo varchar(40) not null,
fecha date not null,
nota_personal varchar(40) not null,
recomendaciones_automaticas varchar(20) not null
);

create table recordatorios (
id_recordatorio int auto_increment primary key,
nombre_recordatorio varchar(40) not null,
fecha_recordatorio date not null,
descripcion varchar(40) not null
);

create table tareas_academicas (
id_tarea int auto_increment primary key,
nombre_tarea varchar(40) not null,
fecha_tarea date not null,
descripcion_tarea varchar(40) not null,
prioridad_tarea int not null,
estado_tarea varchar(20) not null
);

create table comunidad (
id_comunidad int auto_increment primary key,
nombre_comunidad varchar(40) not null,
tema_comunidad varchar(40) not null
);

create table usuario_comunidad (
id_usuario_comunidad int auto_increment primary key,
id_usuarioFK int not null,
id_comunidadFk int not null, 
foreign key (id_usuarioFK) references usuarios(id_usuario),
foreign key (id_comunidadFk) references comunidad (id_comunidad)
);

-- reto 2

alter table usuarios
add column id_bitacoraFK int not null;

alter table usuarios
add constraint id_bitacoraFK
foreign key (id_bitacoraFK) references bitacoras(id_bitacoras);

alter table usuarios
add column id_tareaFK int not null;

alter table usuarios
add constraint id_tareaFK
foreign key (id_tareaFK) references tareas_academicas(id_tarea);

alter table usuarios
add column id_sesionFK int not null;

alter table usuarios
add constraint id_sesionFK
foreign key (id_sesionFK) references sesiones(id_sesion);

alter table usuarios
add column id_recordatorioFK int not null;

alter table usuarios
add constraint id_recordatorioFK
foreign key (id_recordatorioFK) references recordatorios(id_recordatorio);

alter table sesiones 
add column estado_sesion varchar(30) not null;

-- reto 3

insert into usuarios values (1,"juan","juan@email.com", "123445","2006-12-02","masculino","ing electronica", "2022-02-02",1,1,1,1),
(2,"david","david@email.com", "1315533","2004-12-02","masculino","ing sistemas", "2021-02-02",2,2,2,1),
(3,"simon","simon@email.com", "676433","2008-12-02","masculino","ing industrial", "2023-02-02",1,2,3,4);

insert into sesiones (titulo,duracion,nivel_facultad,descripcion,estado_sesion) values 
("ayuda mental", "2 horas", "1", "problemas mentales","activa"),
("ayuda academica", "4 horas", "2", "problemas academicos","inactiva");

insert into bitacoras (estado_animo,fecha,nota_personal,recomendaciones_automaticas) values 
("triste","2022-05-02","estoy triste","hacer algo"),
("feliz","2024-05-02","estoy feliz","exelente sigue asi");

insert into recordatorios (nombre_recordatorio,fecha_recordatorio,descripcion)values ("parcial","2022-01-03","estudiar mucho"),
("tristeza","2023-01-03","hacer algo que me guste");

insert into tareas_academicas (nombre_tarea,fecha_tarea,descripcion_tarea,prioridad_tarea,estado_tarea) values
("matematicas","2022-04-03","hacer trabajo",1,"activa"),
("ciencias","2021-04-04","terminar quizz",2,"inactiva");

insert into comunidad (nombre_comunidad,tema_comunidad)
values ("curso1","matematicas"),("curso2","ciencias");
insert into usuario_comunidad values ('',1,2),('',2,1);

select * from usuario_comunidad;

select * from usuarios inner join bitacoras where id_bitacoras=id_bitacoraFK;

select * from recordatorios inner join usuarios where estado= "activo";

alter table recordatorios
add column estado varchar (20) not null; 

-- 5

select * from usuario_comunidad inner join usuarios where id_usuarioFK= id_usuario;

select * from usuarios inner join sesiones where id_sesionFK = id_sesion and estado_sesion = "activa";

select * from comunidad;

create view vista_actividades_usuario as
select nombre,email,nombre_tarea,fecha_tarea from usuario inner join tareas_academicas where estado_tarea = "activa";

select * from sesiones;

select c.nombre_comunidad, count(uc.id_usuarioFK) as cantidad_usuarios
from comunidad c
inner join usuario_comunidad uc ON c.id_comunidad = uc.id_comunidadFk
group by c.id_comunidad
order by cantidad_usuarios desc
limit 1;

select id_usuario, nombre, id_sesion, estado_sesion
from usuarios inner join sesiones where estado_sesion = "activa";

DELIMITER // 
CREATE TRIGGER agregar_bitacora (in id_usuario, in estado_animo, in nota_personal)
after insert on usuario for each row
begin
insert into bitacora (new.id_usuario,new.estado_animo,new.nota_personal);
end // 
DELIMITER ;

DELIMITER //
create trigger marcar-tarea_completada (in id_tarea)
after 
DELIMITER ;
