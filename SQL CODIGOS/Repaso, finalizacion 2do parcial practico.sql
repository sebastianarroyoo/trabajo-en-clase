SET SQL_SAFE_UPDATES = 0;
create database BDDataVerse;
use BDDataVerse;

create table sensores(
id_sensor int auto_increment primary key,
tipo varchar(40) not null,
ubicacion varchar(40) not null,
fecha_instalacion date not null
);

create table Registros_Sensores(
id_registro int auto_increment primary key,
id_sensorFK int not null,
valor int not null,
fecha_registro timestamp default current_timestamp,
foreign key (id_sensorFK) references sensores (id_sensor)
);

create table Transporte(
id_transporte int auto_increment primary key,
tipo varchar(40) not null,
capacidad int not null
);

create table Usuarios(
id_usuario int auto_increment primary key,
nombre varchar(40) not null,
email varchar(40) not null,
id_transporteFK int not null,
foreign key (id_transporteFK) references transporte (id_transporte)
);


create table Consumo_Energetico(
id_registro_energetico int auto_increment primary key,
zona varchar(40) not null,
consumo_kw int not null,
fecha date not null
);

create table Seguridad(
id_evento int auto_increment primary key,
tipo_evento varchar(40) not null,
descripcion varchar(40) not null,
fecha_hora datetime not null,
ubicacion varchar(40) not null
);

insert into usuarios (nombre,email,id_transporteFK)
values  ("juan","juan@correo.com",1),
		("david","david@correo.com",2),
        ("simon","simon@correo.com",3),
        ("nicolas","nicolas@correo.com",3);
        
insert into transporte (tipo,capacidad)
values  ("Carro",7),
		("Carro",5),
        ("Moto",2),
        ("Moto",2);
        
insert into sensores (tipo,ubicacion,fecha_instalacion) 
values (1,"Colombia","2022-03-01"),
		(2,"Colombia","2023-05-06"),
        (1,"Colombia","2021-04-05"),
        (3,"Colombia","2022-12-02");
        
insert into seguridad (tipo_evento,descripcion,fecha_hora,ubicacion)
values ("sobrecalentamiento","calor exesivo","2024-01-04","colombia"),
		("toxicidad en el aire","niveles altos de Co2","2024-06-05","colombia"),
        ("sobrecalentamiento","niveles letales de calor en el espacio","2022-12-02","colombia"),
        ("lluvia acida","azufre alto en la lluvia","2023-04-06","colombia");

insert into registros_sensores (id_sensorFK,valor,fecha_registro)
values (1,1000,"2023-04-03"),
		(2,2000,"2024-05-06"),
        (1,2500,"2023-04-20"),
        (3,4000,"2023-06-07");

insert into consumo_energetico (zona,consumo_kw,fecha)
values  ("colombia",200,"2023-04-22"),
		("colombia",300,"2022-04-02"),
		("colombia",1000,"2023-06-01"),
		("colombia",500,"2024-12-14");
        
select * from consumo_energetico;
------------------------------------------------------------------- 

alter table usuarios
add telefono varchar(20);

update usuarios
set telefono = "000000000";

update consumo_energetico
set consumo_kw = consumo_kw + consumo_kw * 0.1
where zona = "colombia";
select * from consumo_energetico;

delete from seguridad
where fecha_hora < "2024-01-01";
select * from seguridad;

select * from registros_sensores inner join sensores where valor > 50 and tipo = 1 and id_sensor is not null;

select id_registro_energetico, avg(consumo_kw) as "promedio_consumo" from consumo_energetico
group by id_registro_energetico;

select tipo_evento, count(tipo_evento) as "cantidad_eventos" from seguridad
group by tipo_evento
having count(*) > 2;

select * from seguridad;

SELECT tipo_evento, COUNT(*) AS cantidad_eventos
FROM Seguridad
GROUP BY tipo_evento
HAVING COUNT(*) > 0;

alter table seguridad
add column id_sensorFk int,
add constraint id_sensorFk foreign key (id_sensorFK) references sensores(id_sensor);

create view vista_alertas as
select id_evento, tipo_evento, descripcion, id_sensor, tipo from seguridad
left join sensores on id_sensorFK = id_sensor
where fecha_hora > "2021-01-01";

drop view vista_alertas;
select * from vista_alertas;
describe vista_alertas;

create view Vista_Consumo_Promedio as 
select zona, avg(consumo_kw) from consumo_energetico
group by zona;

select * from Vista_Consumo_Promedio;


DELIMITER $$ 
CREATE PROCEDURE Insertar_Registro_Sensor( in id_sensor int, in valor int, in fecha_registro timestamp)
BEGIN
	INSERT INTO registros_sensores (id_sensorFK,valor,fecha_registro)values (id_sensor,valor,fecha_registro);
END $$
DELIMITER ;

CALL Insertar_Registro_Sensor(3, 1800, '2025-04-09 18:45:00');

SELECT * FROM registros_sensores; 

DELIMITER $$
CREATE PROCEDURE Obtener_Consumo_Zona (IN kkzona VARCHAR(40))
BEGIN
SELECT zona ,AVG(consumo_kw) from consumo_energetico group by zona having kkzona = zona;
END $$ 
DELIMITER ;

CALL Obtener_Consumo_Zona ("colombia");
SELECT * FROM consumo_energetico;
drop procedure Obtener_Consumo_Zona;

DELIMITER // 
CREATE TRIGGER Verificar_Consumo_Maximo
BEFORE INSERT ON Consumo_Energetico FOR EACH ROW
BEGIN
	IF NEW.consumo_kw > 10000 THEN
	SIGNAL SQLSTATE "45000"
    SET message_text = "ERROR, EL VALOR DE KW SUPERA LOS 10.000";
    END IF;
END //
DELIMITER ; 

insert into consumo_energetico (consumo_kw) 
values (15000);


DELIMITER // 
CREATE TRIGGER Actualizar_Timestamp_Sensores
BEFORE UPDATE ON sensores 
FOR EACH ROW
BEGIN
	IF NEW.tipo <> OLD.tipo THEN
	SET new.fecha_instalacion = CURRENT_DATE();
    END IF;
END //
DELIMITER ;

