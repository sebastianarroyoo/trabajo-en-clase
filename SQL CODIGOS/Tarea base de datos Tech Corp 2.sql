create database techCorp;
use techCorp;

-- se crea la base de datos y la tabla
create table empleados(
id int primary key auto_increment,
nombreEmp varchar(20) not null,
edad int not null,
salario double(8,2) not null,
fechaContratacion timestamp default current_timestamp,
departamentoEmp varchar(20) not null
);

-- se insertan los datos en la tabla
insert into empleados(nombreEMp,edad,salario,fechaContratacion,departamentoEmp)
values("Valentina",19,5000,"2019-06-14","IT");
insert into empleados(nombreEMp,edad,salario,fechaContratacion,departamentoEmp)
values("Sara",40,4500,"2010-10-14","ventas"),("Milo Rojas",70,8000,"2000-04-18","administracion");
insert into empleados(nombreEMp,edad,salario,departamentoEmp)
values("Alejandra",25,1200,"IT"),("Andres",56,2000,"seguridad"),("Maria",18,7000,"recursos humanos");

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
select * from empleados where departamentoEmp in ("IT", "administracion");

-- si un campo es nulo is null
select * from empleados where nombreEmp is null;

-- salarios de mayor a menor
select salario from empleados order by salario desc;

----------------------------------

select *, (current_timestamp-fechaContratacion) as "anios contratados" from empleados;
select * from empleados order by salario desc limit 3;
select nombreEmp, salario, timestampdiff(year, fechaContratacion, curdate()) as "años trabajados", salario*0.1 as "bono" from empleados where (timestampdiff(year, fechaContratacion, curdate())) > 5;
select count(*), avg(salario) from empleados where salario > (select avg(salario) from empleados);

select departamentoEmp,count(*) from empleados group by departamentoEmp order by count(*) desc;

---------------------------------------

-- having requiere un group by
select *, count(*)from empleados group by departamentoEmp having count(*) >=3;

-- modificacion

	-- sintaxis / update nombreTabla set campo1="valorReemplazo" , campo2="valorReemplazo" where llavePrimaria="valor"
    
    update empleados set nombreEmp = "Valentina" where id = 1;
select * from empleados;

-- eliminar
-- sintaxis delete from nombreTabla where condition
delete from empleados where nombre = "Valentina";





