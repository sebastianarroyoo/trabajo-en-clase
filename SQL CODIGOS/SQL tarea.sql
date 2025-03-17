-- Juan Sebastian Arroyo
CREATE DATABASE Logistica;
USE Logistica;

-- Tabla Camionero
CREATE TABLE Camionero (
    identificacion INT PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    direccion TEXT
);

-- Tabla Camion
CREATE TABLE Camion (
    placa VARCHAR(6) PRIMARY KEY NOT NULL,
    modelo VARCHAR(20) NOT NULL,
    potencia INT NOT NULL,
    tipo VARCHAR(20) NOT NULL
);

-- Tabla Paquete
CREATE TABLE Paquete (
    codigo INT PRIMARY KEY NOT NULL,
    descripcion TEXT NOT NULL,
    destinatario VARCHAR(20) NOT NULL,
    direccion TEXT NOT NULL
);

-- Tabla Ciudad
CREATE TABLE Ciudad (
    codigo INT PRIMARY KEY NOT NULL,
    nombre VARCHAR(15) NOT NULL
);

-- Tabla intermedia Conduce (relación N:M entre Camionero y Camion)
CREATE TABLE Conduce (
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    camionero_id INT NOT NULL,
    camion_placa VARCHAR(6) NOT NULL,
    FOREIGN KEY (camionero_id) REFERENCES Camionero(identificacion),
    FOREIGN KEY (camion_placa) REFERENCES Camion(placa)
);

-- Tabla Distribuye (relación 1:N entre Camionero y Paquete)
CREATE TABLE Distribuye (
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    camionero_id INT NOT NULL,
    paquete_codigo INT NOT NULL,
    FOREIGN KEY (camionero_id) REFERENCES Camionero(identificacion),
    FOREIGN KEY (paquete_codigo) REFERENCES Paquete(codigo)
);

-- Tabla Destinado (relación 1:M entre Paquete y Ciudad)
CREATE TABLE Destinado (
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    paquete_codigo INT NOT NULL,
    ciudad_codigo INT NOT NULL,
    FOREIGN KEY (paquete_codigo) REFERENCES Paquete(codigo),
    FOREIGN KEY (ciudad_codigo) REFERENCES Ciudad(codigo)
);

-----------------------------------------------------------------------------------------------

-- Insertar un camionero
INSERT INTO Camionero (identificacion, nombre, telefono, direccion)
VALUES (101, 'Juan Pérez', '555-1234', 'Calle Principal #45'), (101, 'David Ramirez', '443-5423', 'Calle #23'),(103, 'Sebastiana Arroyo', '654-9642', 'Carrera #5'), (104, 'Simon Burbano', '654-7431', 'Diagonal #2'),(105, 'Sergio Calderon', '634-7678', 'Carrera #13');

-- Insertar un camión
INSERT INTO Camion (placa, modelo, potencia, tipo)
VALUES ('ABC123', 'Volvo FH', 450, 'Carga Pesada'), ('ERV354', 'Volvo FD', 500, 'Carga Media'), ('GDP512', 'Volvo 2', 550, 'Carga Pesada'), ('AVF948', 'Volvo X', 250, 'Carga Ligera'), ('GGD432', 'Volvo AA', 320, 'Carga Media');

-- Insertar un paquete
INSERT INTO Paquete (codigo, descripcion, destinatario, direccion)
VALUES (501, 'Electrodoméstico', 'Carlos López', 'Av. Central #78'),(502, 'Electrodoméstico', 'Carlos López', 'Av. Central #78'),(503, 'Electrodoméstico', 'Carlos López', 'Av. Central #78'),(501, 'Electrodoméstico', 'Carlos López', 'Av. Central #78');

-- Insertar una ciudad
INSERT INTO Ciudad (codigo, nombre)
VALUES (301, 'Bogotá'),(302, 'Bogotá'),(303, 'Bogotá'),(304, 'Bogotá'),(305, 'Bogotá');

-- Insertar una relación en la tabla Conduce
INSERT INTO Conduce (camionero_id, camion_placa)
VALUES (101, 'ABC123');

-- Insertar una relación en la tabla Distribuye
INSERT INTO Distribuye (camionero_id, paquete_codigo)
VALUES (101, 501),(101, 501),(101, 501),(101, 501),(101, 501);

-- Insertar una relación en la tabla Destinado
INSERT INTO Destinado (paquete_codigo, ciudad_codigo)
VALUES (501, 301),(501, 301),(501, 301),(501, 301),(501, 301);