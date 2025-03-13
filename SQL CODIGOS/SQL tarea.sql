-- Juan Sebastian Arroyo
CREATE DATABASE Logistica;
USE Logistica;

-- Tabla Camionero
CREATE TABLE Camionero (
    identificacion INT PRIMARY KEY,
    nombre VARCHAR(20),
    telefono VARCHAR(15),
    direccion TEXT
);

-- Tabla Camion
CREATE TABLE Camion (
    placa VARCHAR(6) PRIMARY KEY,
    modelo VARCHAR(20),
    potencia INT,
    tipo VARCHAR(20)
);

-- Tabla Paquete
CREATE TABLE Paquete (
    codigo INT PRIMARY KEY,
    descripcion TEXT,
    destinatario VARCHAR(20),
    direccion TEXT
);

-- Tabla Ciudad
CREATE TABLE Ciudad (
    codigo INT PRIMARY KEY,
    nombre VARCHAR(15)
);

-- Tabla intermedia Conduce (relación N:M entre Camionero y Camion)
CREATE TABLE Conduce (
    id INT AUTO_INCREMENT PRIMARY KEY,
    camionero_id INT,
    camion_placa VARCHAR(6),
    FOREIGN KEY (camionero_id) REFERENCES Camionero(identificacion),
    FOREIGN KEY (camion_placa) REFERENCES Camion(placa)
);

-- Tabla Distribuye (relación 1:N entre Camionero y Paquete)
CREATE TABLE Distribuye (
    id INT AUTO_INCREMENT PRIMARY KEY,
    camionero_id INT,
    paquete_codigo INT,
    FOREIGN KEY (camionero_id) REFERENCES Camionero(identificacion),
    FOREIGN KEY (paquete_codigo) REFERENCES Paquete(codigo)
);

-- Tabla Destinado (relación 1:M entre Paquete y Ciudad)
CREATE TABLE Destinado (
    id INT AUTO_INCREMENT PRIMARY KEY,
    paquete_codigo INT,
    ciudad_codigo INT,
    FOREIGN KEY (paquete_codigo) REFERENCES Paquete(codigo),
    FOREIGN KEY (ciudad_codigo) REFERENCES Ciudad(codigo)
);