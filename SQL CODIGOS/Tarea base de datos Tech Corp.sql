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
values("Sara",40,4500,"2010-10-14","ventas"),
("",70,8000,"2000-04-18","administracion");
insert into empleados(nombreEMp,edad,salario,departamentoEmp)
values("Alejandra",25,1200,"IT"),("Andres",56,2000,"seguridad"),("maria paz cuesta montenegro",18,40000000,"recursos humanos");

-- se confirma que las insercion se hayan realizado correctamente
select * from empleados;

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
select max(salario) from empleados