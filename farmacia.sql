CREATE TABLE pais(
    id int AUTO_INCREMENT,
    nombre VARCHAR(50),
    CONSTRAINT Pk_idpais PRIMARY KEY(id)
);
CREATE TABLE departamento(
    id int AUTO_INCREMENT,
    nombre VARCHAR(50),
    idpaisFk int(11),
    CONSTRAINT Pk_iddepartamento PRIMARY KEY(id),
    CONSTRAINT FK_idpais FOREIGN KEY(idpaisFk) REFERENCES pais(id)
);
CREATE TABLE ciudad(
    id int AUTO_INCREMENT,
    nombre VARCHAR(50),   
    iddepartamentoFk int(11),
    CONSTRAINT Pk_idciudad PRIMARY KEY(id),
    CONSTRAINT FK_iddepartamento FOREIGN KEY(iddepartamentoFk) REFERENCES departamento(id)
);

CREATE TABLE tipoPersona(
    id int AUTO_INCREMENT,
    CONSTRAINT Pk_idtipoPersona PRIMARY KEY(id)
);
CREATE TABLE presentacion(
    id int AUTO_INCREMENT,
    CONSTRAINT Pk_idpresentacion PRIMARY KEY(id)
);
CREATE TABLE rolPersona(
    id int AUTO_INCREMENT,
    CONSTRAINT Pk_idrolPersona PRIMARY KEY(id)
);
CREATE TABLE formaPago(
    id int AUTO_INCREMENT,
    CONSTRAINT Pk_idformaPago PRIMARY KEY(id)
);

CREATE TABLE tipoMovInventario(
    id int AUTO_INCREMENT,
    CONSTRAINT Pk_tipoMovInventario PRIMARY KEY(id) 
);
CREATE TABLE tipoContacto(
    id int AUTO_INCREMENT,
    CONSTRAINT Pk_tipoContacto PRIMARY KEY(id)
);
CREATE TABLE marca(
    id int AUTO_INCREMENT,
    nombre VARCHAR(50),
    CONSTRAINT Pk_marca PRIMARY KEY(id)
);
CREATE TABLE producto(
    cod VARCHAR(10),
    nombreProd VARCHAR(100),
    idmarca int(11),
    CONSTRAINT Pk_producto PRIMARY KEY(cod),
    CONSTRAINT Fk_marca FOREIGN KEY(idmarca) REFERENCES marca(id)
);
CREATE TABLE tipoDocumento(
    id int AUTO_INCREMENT,
    nombre VARCHAR(30),
    CONSTRAINT Pk_idtipoDocumento PRIMARY KEY(id)
);
CREATE TABLE persona(
    id VARCHAR(20),
    nombre VARCHAR(50),
    fechaRegistro DATE,
    idDocumento int(11),
    idRolPersona int(11),
    idTipoPersona int(11),
    CONSTRAINT Pk_persona PRIMARY KEY(id),
    CONSTRAINT Fk_tipoDocumento FOREIGN KEY(idDocumento) REFERENCES tipoDocumento(id),
    CONSTRAINT Fk_rolPersona FOREIGN KEY(idRolPersona) REFERENCES rolPersona(id),
    CONSTRAINT Fk_tipoPersona FOREIGN KEY(idTipoPersona) REFERENCES tipoPersona(id)
);
CREATE TABLE ubicacionPersona(
    id int AUTO_INCREMENT,
    tipoDeVia VARCHAR(20),
    numerPri smallint,
    letra CHAR(2),
    bis CHAR(10),
    letraSec CHAR(10),
    numeroSec smallint,
    letraTer CHAR(2),
    numeroTer CHAR(2),
    cardinalSec CHAR(10),
    complemento VARCHAR(50),
    idCiudad int(11),
    idPersona VARCHAR(20),
    CONSTRAINT Pk_ubicacionPersona PRIMARY KEY(id),
    CONSTRAINT Fk_idpersona FOREIGN KEY(idPersona) REFERENCES persona(id),
    CONSTRAINT Fk_idciudad FOREIGN KEY(idCiudad) REFERENCES ciudad(id)
);
CREATE TABLE contactoPersona(
    id int AUTO_INCREMENT,
    idPersona VARCHAR(20),
    idTipoContacto int(11),
    CONSTRAINT Pk_idcontactoPersona PRIMARY KEY(id),
    CONSTRAINT Fk_idPersonaContacto FOREIGN KEY(idPersona) REFERENCES persona(id),
    CONSTRAINT Fk_idTipoContacto FOREIGN KEY(idTipoContacto) REFERENCES tipoContacto(id)
);
CREATE TABLE inventario(
    id VARCHAR(10),
    nombre VARCHAR(50),
    precio DOUBLE(11,2),
    stock smallint,
    stockMin smallint,
    stockMax smallint,
    codProducto VARCHAR(10),
    idPresentacion int(11),
    CONSTRAINT Pk_inventario PRIMARY KEY(id),
    CONSTRAINT Fk_codProducto FOREIGN KEY (codProducto) REFERENCES producto(cod),
    CONSTRAINT Fk_idpresentacion FOREIGN KEY (idPresentacion) REFERENCES presentacion(id)
);
CREATE TABLE factura(
    id int AUTO_INCREMENT,
    facturaInicial int,
    facturaFinal int,
    facturaActual int,
    nroResolucion VARCHAR(10),
    CONSTRAINT Pk_idfactura PRIMARY KEY(id)
);
CREATE TABLE movimientoInventario(
    id VARCHAR(10),
    idResponsable VARCHAR(20),
    idResector VARCHAR(20),
    fechaMovimiento DATE,
    fechaVencimiento DATE,
    idTipoMovInv int(11),
    CONSTRAINT Pk_movInv PRIMARY KEY(id),
    CONSTRAINT Fk_idResectorMov FOREIGN KEY(idResponsable) REFERENCES persona(id),
    CONSTRAINT Fk_idResponsableMov FOREIGN KEY(idResponsable) REFERENCES persona(id),
    CONSTRAINT Fk_idTipoMovInv FOREIGN KEY(idTipoMovInv) REFERENCES tipoMovInventario(id)
);
CREATE TABLE detalleMovInventario(
    idInventario VARCHAR(10),
    idMovInv VARCHAR(10),
    cantidad TINYINT,
    precio DOUBLE(11,2),
    CONSTRAINT Fk_idInventario FOREIGN KEY(idInventario) REFERENCES inventario(id),
    CONSTRAINT Fk_idMovInv FOREIGN KEY(idMovInv) REFERENCES movimientoInventario(id),
    CONSTRAINT Pk_idInventario PRIMARY KEY(idInventario, idMovInv)
);
ALTER TABLE movimientoInventario
ADD idFormaPago int(11);
ALTER TABLE movimientoInventario
ADD FOREIGN KEY(idFormaPago) REFERENCES formaPago(id);

-- DML

INSERT --Crear nuevos registros
INSERT INTO name_tabla(c1,c2,t1....) VALUES ();
-- Datos de tipo VARCHAR se envian con ""
-- Datos de tipo FECHA se envian con ""
-- Datos de tipo NUMERICOS se envian con 1538
INSERT INTO pais(nombre) VALUES ("Colombia");
-- Insertar varios datos 
INSERT INTO pais(nombre) VALUES ("Peru"),("Ecuador"),("Panama");

DELETE --Borrar registro de la tabla
DELETE FROM pais WHERE nombre = "SEBASTIAN";

DELETE --Borrar todos los registros de la tabla
DELETE FROM pais;

UPDATE --Actualizar Registro en la tabla
UPDATE pais
SET nombre = "España"
WHERE id = 1;

-- DQL
SELECT --Seleccionar Registros de la tabla
SELECT id,nombre FROM pais;

-- Convertir unico el campo nombre de la tabla
ALTER TABLE pais
ADD CONSTRAINT UC_nombreP UNIQUE (nombre);


-- Convertir unico el campo nombre de la tabla
ALTER TABLE departamento
ADD CONSTRAINT UC_nombreD UNIQUE (nombre);

-- Añadir departamentos a la tabla DEPARTAMENTO
INSERT INTO departamento(nombre,idpaisFk) VALUES 
("Amazonas",2),("Antioquia",2),("Arauca",2),("Atlantico",2),("Bogota",2),
("Bolivar",2),("Boyaca",2),("Caldas",2),("Caqueta",2),("Casanare",2),
("Cauca",2),("Cesar",2),("Cordoba",2),("Choco",2),("Cundinamarca",2),("Guainia",2),
("Guaviare",2),("Huila",2),("La Guajira",2),("Magdalena",2),("Meta",2),
("Nariño",2),("Norte de Santander",2),("Putumayo",2),("Quindio",2),("Risaralda",2),
("Santander",2),("San Andres y Providencia",2),("Sucre",2),("Tolima",2),("Valle del Cauca",2),
("Vaupes",2),("Vichada",2);

-- Resetear auto_increment de la tabla
ALTER TABLE tu_tabla_va_aqui AUTO_INCREMENT = 1;

-- Insertar Datos en tabla ciudad
INSERT INTO ciudad(nombre,iddepartamentoFk) VALUES 
("Bucaramanga",27),("Giron",27),("Piedecuesta",27),
("Medellin",2),("Itagui",2),("Envigado",2),
("Barranquilla",4),("Soledad",4),("Malambo",4);

-- Seleccionar elementos de diferentes tablas
SELECT p.id,p.nombre AS nombrePais,d.nombre AS nombreDepartamento ,c.nombre AS nombreCiudad
FROM pais p
JOIN departamento d ON p.id = d.idpaisFk
JOIN ciudad c ON d.id = c.iddepartamentoFk
ORDER BY c.nombre DESC;
-- CONDICION DE CONSULTA -> WHERE
-- OPERADORES COMPARACION -> =,<,>,>=,<=,<>
-- OPERADORES DE PATRON -> like '%xxx%' contenga esa palabra xxx ,'%xxx' contenga esa palabra xxx al final,'xxx%' contenga esa palabra xxx al principio
-- OPERADORES LOGICOS -> AND, OR, NOT
-- ORDER BY ASC , DESC Ordenar de forma ascendente y descendente
