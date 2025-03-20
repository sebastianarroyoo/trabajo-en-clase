create database techCorp;
use techCorp;

drop database techCorp;
drop table empleados;
drop table departamento;
drop table cargo;

-- se crea la base de datos y la tabla
create table empleados(
idEmpleado int primary key auto_increment,
nombreEmp varchar(20) not null,
edad int not null,
salario double(8,2) not null,
fechaContratacion timestamp default current_timestamp
);
create table departamento(
idDepto int primary key auto_increment,
nombreDepto varchar(20) not null
);
create table cargo(
idCargo varchar(30) primary key ,
nombreCargo varchar(30),
rangoCargo int,
descripcionCargo varchar(60)
);

select * from empleados;
select * from departamento;
select * from cargo;

-------------------------------------------------------------------------------------------------------------------------------

-- relacion entre empleado y departamento
ALTER TABLE empleados
ADD COLUMN idDepto INT,
ADD CONSTRAINT FKEmpleadoDepto
FOREIGN KEY (idDepto)
REFERENCES departamento(idDepto);

-- relacion entre empleado y cargo
ALTER TABLE empleados
ADD COLUMN idCargo VARCHAR(30),
ADD CONSTRAINT FKEmpleadoCargo
FOREIGN KEY (idCargo)
REFERENCES cargo(idCargo);

-------------------------------------------------------------------------------------------------------------------------------
-- inserciones en la tabla
INSERT INTO departamento (nombreDepto) 
VALUES ('Recursos Humanos'),('Tecnología'),('Finanzas'),('Marketing'),('Ventas');

INSERT INTO cargo (idCargo, nombreCargo, rangoCargo, descripcionCargo) VALUES
('C001', 'Gerente', 1, 'Responsable de supervisar las operaciones de la empresa'),
('C002', 'Desarrollador', 2, 'Desarrolla y mantiene aplicaciones de software'),
('C003', 'Analista Financiero', 3, 'Encargado de analizar los estados financieros de la empresa'),
('C004', 'Especialista en Marketing', 2, 'Desarrolla estrategias de marketing y comunicación'),
('C005', 'Vendedor', 3, 'Encargado de realizar ventas y atención al cliente');

INSERT INTO empleados (nombreEmp, edad, salario, idDepto, idCargo, fechaContratacion) 
VALUES ('Juan Pérez', 35, 2500.00, 1, 'C001', '2022-05-15'), ('Ana González', 28, 1800.00, 2, 'C002', '2018-08-10'), 
('Luis Rodríguez', 40, 2200.00, 3, 'C003', '2015-03-22'), ('Carla Sánchez', 32, 2000.00, 4, 'C004', '2016-07-01'),
('Pedro Díaz', 25, 1500.00, 5, 'C005', '2021-01-18');


-------------------------------------------------------------------------------------------------------------------------------
-- mostrar en pantalla los empleados que tengan un cargo especifico
	-- para desarrollador
SELECT e.nombreEmp, e.salario, c.nombreCargo
FROM empleados e
JOIN cargo c ON e.idCargo = c.idCargo
WHERE c.nombreCargo = 'Desarrollador';
	-- para gerente
SELECT e.nombreEmp, e.salario, c.nombreCargo
FROM empleados e
JOIN cargo c ON e.idCargo = c.idCargo
WHERE c.nombreCargo = 'Gerente';
	-- para analista financiero
SELECT e.nombreEmp, e.salario, c.nombreCargo
FROM empleados e
JOIN cargo c ON e.idCargo = c.idCargo
WHERE c.nombreCargo = 'Analista Financiero';
	-- para especialista en marketing
SELECT e.nombreEmp, e.salario, c.nombreCargo
FROM empleados e
JOIN cargo c ON e.idCargo = c.idCargo
WHERE c.nombreCargo = 'Especialista en Marketing';
	-- para vendedor
SELECT e.nombreEmp, e.salario, c.nombreCargo
FROM empleados e
JOIN cargo c ON e.idCargo = c.idCargo
WHERE c.nombreCargo = 'Vendedor';

-- todos los empleados que tengan mas de 3 años en la empresa, que departamento pertencen que cargo tienen y cuanto ganan
SELECT e.nombreEmp, e.salario, d.nombreDepto, c.nombreCargo, 
TIMESTAMPDIFF(YEAR, e.fechaContratacion, CURDATE()) AS antiguedad
FROM empleados e 
JOIN departamento d ON e.idDepto = d.idDepto
JOIN cargo c ON e.idCargo = c.idCargo
WHERE TIMESTAMPDIFF(YEAR, e.fechaContratacion, CURDATE()) > 3;

-- mostrar toda la informacion de un empleado, nombre del empleado, fecha en la que se contrato, 
-- departamento en el que esta contratado
-- años de antiguedad en la empresa, cargo que tiene actualmente, rango del cargo que tiene
SELECT e.nombreEmp, e.fechaContratacion, d.nombreDepto, c.nombreCargo, c.rangoCargo, 
TIMESTAMPDIFF(YEAR, e.fechaContratacion, CURDATE()) AS antiguedad
FROM empleados e
JOIN departamento d ON e.idDepto = d.idDepto
JOIN cargo c ON e.idCargo = c.idCargo
WHERE e.idEmpleado = (1); -- aqui se cambia este numero por el id que se quiere consultar

-- mostrar todos los departamentos que no tengan empleados
SELECT d.nombreDepto
FROM departamento d
LEFT JOIN empleados e ON d.idDepto = e.idDepto
WHERE e.idEmpleado IS NULL; -- No muestra nada por que no hay departamentos sin asignar en mi caso

-- mostrar todos los cargos que no tengan un empleado asignado
SELECT c.nombreCargo
FROM cargo c
LEFT JOIN empleados e ON c.idCargo = e.idCargo
WHERE e.idEmpleado IS NULL; -- No muestra nada tampoco por que no hay cargo sin empleado


-------------------------------------------------------------------------------------------------------------------------------
-- EJERCICIO REALIZADO EN CLASE

-- se confirma que las insercion se hayan realizado correctamente
select * from empleados;

-- funcion para borrar la bd
drop database techCorp;
drop table empleados;
-- se obtienen los nombres, edades y salarios de todos los empleados
select nombreEmp as nombre,edad,salario from empleados;

-- se obtiene el nombre de los empleados que ganan mas de 4000
select nombreEmp as nombre, salario from empleados
where salario>4000;

-- se obtienen los empleados que pertenecen al departamento de ventas
select nombreEmp as nombre, departamentoEmp as departamento from empleados
where departamentoEmp="ventas";

-- se obtienen los empleados entre los 30 y 40 años
select nombreEmp as nombre, edad from empleados
where edad between 30 and 40;

-- se obtienen los empleados que hayan sido contratados despues de 2020
select nombreEmp as nombre, fechaContratacion from empleados
where fechaContratacion>="2021-01-01";

-- se obtienen cuantos empleados hay por departamento
select departamentoEmp, count(*) from empleados
group by departamentoEmp;

-- salario promedio de la empresa
select avg(salario) as salarioPromedio from empleados;

-- empleados cuyo nombre comienza por a o c
select nombreEmp as nombre from empleados
where nombreEmp like "a%" or nombreEmp like "c%";

-- empleados que no pertecenen a IT
select nombreEmp as nombre, departamentoEmp as departamento from empleados
where departamentoEmp<>"IT";

-- mayor salario
select nombre, salario from empleados where salario = max(salario);

-------------------------------------------------------------------------------------------------------------------------------

-- Funciones Agregadas
select nombreEmp, salario from empleados where salario = (select max(salario) from empleados);

-- Consultar rangos
select * from empleados where id between 1 and 4;

-- consultar un valor dentro de una lista de valores
select * from empleados where id in(2,5);

-- si un campo es nulo is null
select * from empleados where nombreEmp is null;

-- salarios de mayor a menor
select salario from empleados order by salario desc;

-------------------------------------------------------------------------------------------------------------------------------

select *, (current_timestamp-fechaContratacion) as "anios contratados" from empleados;
select * from empleados order by salario desc limit 3;
select nombreEmp, salario, timestampdiff(year, fechaContratacion, curdate()) as "años trabajados", salario*0.1 as "bono" from empleados where (timestampdiff(year, fechaContratacion, curdate())) > 5;
select count(*), avg(salario) from empleados where salario > (select avg(salario) from empleados);

select departamentoEmp,count(*) from empleados group by departamentoEmp order by count(*) desc;

-------------------------------------------------------------------------------------------------------------------------------

-- having requiere un group by
select *, count(*)from empleados group by departamentoEmp having count(*) >=3;

-- modificacion

	-- sintaxis / update nombreTabla set campo1="valorReemplazo" , campo2="valorReemplazo" where llavePrimaria="valor"
    
    update empleados set nombreEmp = "Valentina" where id = 1;
select * from empleados;

-- eliminar
-- sintaxis delete from nombreTabla where condition
delete from empleados where nombre = "Valentina";

-------------------------------------------------------------------------------------------------------------------------------

-- consultas multitabla 
-- join
-- tipos de join
-- inner join : es la interseccion
-- left join : devuelve las filas de la izquierda en la tabla izquierda y todas las filas que coinciden con la derecha
-- right join : devuelve las filas de la izquierda en la tabla izquierda y todas las filas que coinciden con la derecha
-- full join : devuelve todas las filas

-- muestre los nombres de los empleados y los departamentos a los que pertenecen

-- select nombreCampoTabla1, nombreCampoTabla2 from tabla 1 inner join tabla2 
-- on tabla.1nombreCampoColumna=tabla2.nombreColumnaTabla2 

select nombreEmp, nombreDepto from empleados inner join empleados on empleados.idDepartamentoFK = departamento.idDepto;

select nombreEmp, nombreDepto from empleados left join empleados on empleados.idDepartamentoFK = departamento.idDepto;

select nombreEmp, nombreDepto from empleados right join empleados on empleados.idDepartamentoFK = departamento.idDepto;

-- hacer una consulta de todos los cargos que tengan un rango especifico


 