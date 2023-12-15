CREATE DATABASE Base_Proyecto;
USE Base_Proyecto;

GO
CREATE SCHEMA GEO;
GO
CREATE SCHEMA Historial;
GO
CREATE SCHEMA Persona;
GO
CREATE SCHEMA Contacto;
GO
CREATE SCHEMA Respuesta;
GO
CREATE SCHEMA Tipo;
GO
CREATE SCHEMA Moneda;
GO


CREATE TABLE Tipo.TIPO_PERSONA --Tipo PERSONA (JURIDICA)(FISICA)(PYME)
(
	Tipo_PersonaID TINYINT IDENTITY (1,1), --Llave primaria
	Nombre_Tipo_Persona NVARCHAR(20) NOT NULL,
	CONSTRAINT PK_Tipo_Persona PRIMARY KEY(Tipo_PersonaID),
);


INSERT INTO Tipo.TIPO_PERSONA(Nombre_Tipo_Persona)
VALUES (N'Jurídica'),
	   (N'Física'),
	   (N'PYME');

CREATE TABLE Persona.GENERO
(
	GeneroID TINYINT IDENTITY (1,1), --Llave Primaria
	Descripcion VARCHAR(500) NOT NULL,
	CONSTRAINT PK_Genero PRIMARY KEY(GeneroID),
);

INSERT INTO Persona.GENERO(Descripcion)
VALUES ('Masculino'),
	   ('Femenino'),
	   ('Otro');


CREATE TABLE Persona.PROFESION
(
    Profesion_ID SMALLINT IDENTITY (1,1) NOT NULL, --Llave Primaria
    Descripcion VARCHAR(500) NOT NULL,
    CONSTRAINT PK_Profesion PRIMARY KEY(Profesion_ID)
);

INSERT INTO Persona.PROFESION (Descripcion)
VALUES
    ('Ingeniero de Software'),
    ('Médico'),
    ('Abogado'),
    ('Diseñador Gráfico'),
    ('Contador'),
    ('Profesor'),
    ('Arquitecto'),
    ('Chef'),
    ('Periodista'),
    ('Ingeniero Civil');

CREATE TABLE Persona.NIVEL_PROFESIONAL
(
    Nivel_ProfesionID SMALLINT IDENTITY(1,1), --Llave primaria
    Descripcion VARCHAR(500) NOT NULL,
    Profesion_ID SMALLINT NOT NULL,
    CONSTRAINT PK_NivelProfesion PRIMARY KEY(Nivel_ProfesionID),
    CONSTRAINT FK_Profesion_ID FOREIGN KEY (Profesion_ID) REFERENCES Persona.PROFESION(Profesion_ID)
);

INSERT INTO Persona.NIVEL_PROFESIONAL (Descripcion,Profesion_ID)
VALUES
		('Junior', 1)
	   ,('Middle', 1)
	   ,('Senior', 1)
	   ,('Interno', 2)
	   ,('Residente', 2)
	   ,('Jefe', 2)
	   ,('Interno', 3)
	   ,('Residente', 3)
	   ,('Jefe', 3)
	   ,('Asociado ', 4)
	   ,('Asociado Senior', 4)
	   ,('Socio Gerente', 4)
	   ,('Principiante ', 4)
	   ,('Senior', 4)
	   ,('Director', 4);

CREATE TABLE Persona.NIVEL_ACADEMICO_MAX
(
    NivelMax_ID SMALLINT IDENTITY(1,1), --Llave Primaria
    Nivel_ProfesionID SMALLINT,
    Descripcion VARCHAR(500),
    CONSTRAINT PK_NivelMax PRIMARY KEY(NivelMax_ID),
    CONSTRAINT FK_NIVEL_PROFESIONAL FOREIGN KEY (Nivel_ProfesionID) REFERENCES Persona.NIVEL_PROFESIONAL (Nivel_ProfesionID)
);

-- Insertar datos en la tabla Persona.NIVEL_ACADEMICO_MAX
INSERT INTO Persona.NIVEL_ACADEMICO_MAX (Nivel_ProfesionID, Descripcion) VALUES
(1, 'Licenciatura en Ingeniería Civil - Junior'),
(1, 'Licenciatura en Ingeniería Civil - Middle'),
(1, 'Licenciatura en Ingeniería Civil - Senior'),
(2, 'Maestría en Ciencias de la Computación - Interno'),
(2, 'Maestría en Ciencias de la Computación - Residente'),
(2, 'Maestría en Ciencias de la Computación - Jefe'),
(3, 'Doctorado en Medicina - Interno'),
(3, 'Doctorado en Medicina - Residente'),
(3, 'Doctorado en Medicina - Jefe'),
(4, 'Licenciatura en Administración de Empresas - Asociado'),
(4, 'Licenciatura en Administración de Empresas - Asociado Senior'),
(4, 'Licenciatura en Administración de Empresas - Socio Gerente'),
(4, 'Licenciatura en Administración de Empresas - Principiante'),
(4, 'Licenciatura en Administración de Empresas - Senior'),
(4, 'Licenciatura en Administración de Empresas - Director');

CREATE TABLE Persona.ACTIVIDAD_ECONOMICA
(
    ActividadEconomica_ID TINYINT IDENTITY (1,1),
    Descripcion NVARCHAR(200),
    CONSTRAINT PK_ActividadEconomica_ID PRIMARY KEY (ActividadEconomica_ID) 
);

INSERT INTO Persona.ACTIVIDAD_ECONOMICA (Descripcion)
VALUES
    ('Desarrollo de software y servicios informáticos'),
    ('Consultoría empresarial'),
    ('Restaurante o cafetería'),
    ('Venta al por menor de productos electrónicos'),
    ('Servicios de contabilidad y asesoría fiscal'),
    ('Construcción y obras civiles'),
    ('Servicios de diseño gráfico y publicidad'),
    ('Consultoría en recursos humanos'),
    ('Venta al por mayor de alimentos y bebidas'),
    ('Servicios de transporte y logística');

CREATE TABLE Persona.PERSONA 
(
	PersonaID SMALLINT IDENTITY (1,1), --Llave primaria
	Primer_Nombre VARCHAR(100) NOT NULL,
	Segundo_Nombre VARCHAR(100),
	Primer_Apellido VARCHAR(100) NOT NULL,
	Segundo_Apellido VARCHAR(100),
	Fecha_Nacimiento DATE NOT NULL,
	Lugar_Nacimiento VARCHAR(100) NOT NULL,
	Numero_Dependientes TINYINT,
	Tipo_PersonaID TINYINT NOT NULL,
	GeneroID TINYINT,
	ActividadEconomica_ID TINYINT,
	Profesion_ID SMALLINT,
	Estado_Vivo BIT NOT NULL,
	Fecha_Defuncion DATE,
	CONSTRAINT PK_Persona PRIMARY KEY(PersonaID),
	CONSTRAINT FK_Tipo_Persona FOREIGN KEY(Tipo_PersonaID) REFERENCES Tipo.TIPO_PERSONA(Tipo_PersonaID),
	CONSTRAINT FK_Genero FOREIGN KEY(GeneroID) REFERENCES Persona.GENERO(GeneroID),
	CONSTRAINT FK_Actividad_Economica FOREIGN KEY (ActividadEconomica_ID) REFERENCES Persona.ACTIVIDAD_ECONOMICA(ActividadEconomica_ID),
	CONSTRAINT FK_Profesion FOREIGN KEY (Profesion_ID) REFERENCES Persona.PROFESION(Profesion_ID)
);

-- Insertar datos en la tabla Persona.PERSONA
INSERT INTO Persona.PERSONA (
    Primer_Nombre,
    Segundo_Nombre,
    Primer_Apellido,
    Segundo_Apellido,
    Fecha_Nacimiento,
    Lugar_Nacimiento,
    Numero_Dependientes,
    Tipo_PersonaID,
    GeneroID,
    ActividadEconomica_ID,
    Profesion_ID,
    Estado_Vivo,
    Fecha_Defuncion
) VALUES
('Juan', 'Carlos', 'Gómez', 'Pérez', '1990-05-15', 'Ciudad de México', 2, 1, 1, 3, 5, 1, NULL),
('María', 'Isabel', 'Martínez', 'López', '1985-08-22', 'Guadalajara', 1, 2, 2, 2, 8, 1, NULL),
('Pedro', NULL, 'Ramírez', 'Hernández', '1978-12-10', 'Monterrey', 3, 1, 1, 4, 7, 1, NULL),
('Ana', 'Luisa', 'Díaz', 'Gutiérrez', '1995-04-03', 'Puebla', 0, 2, 2, 1, 10, 1, NULL),
('Luis', 'Alberto', 'Hernández', 'Rodríguez', '1982-06-18', 'Tijuana', 1, 1, 1, 6, 2, 1, NULL),
('Elena', 'Beatriz', 'Torres', 'Sánchez', '1998-09-27', 'Veracruz', 2, 2, 2, 5, 9, 1, NULL),
('Ricardo', NULL, 'García', 'Martínez', '1975-03-14', 'Cancún', 4, 1, 1, 2, 4, 1, NULL),
('Laura', 'Patricia', 'Flores', 'Ortega', '1991-11-08', 'Oaxaca', 1, 2, 2, 3, 6, 1, NULL),
('Javier', NULL, 'Ruíz', 'Soto', '1987-07-02', 'Mérida', 2, 1, 1, 4, 8, 1, NULL),
('Isabel', 'Cristina', 'Guzmán', 'Vargas', '1980-02-20', 'Acapulco', 3, 2, 2, 1, 5, 1, NULL);


CREATE TABLE Persona.CLIENTE
(
	ClienteID SMALLINT IDENTITY (1,1),
	PersonaID SMALLINT NOT NULL, --Llave Primaria
	Numero_Empleados INT,
	CONSTRAINT PK_Cliente PRIMARY KEY(ClienteID),
	CONSTRAINT FK_Cliente_Personas_ID FOREIGN KEY (PersonaID) REFERENCES Persona.PERSONA(PersonaID)
);

-- Insertar datos en la tabla Persona.CLIENTE
INSERT INTO Persona.CLIENTE (PersonaID, Numero_Empleados) VALUES
(1, 50),
(2, 120),
(3, 300),
(4, 10),
(5, 75),
(6, 200),
(7, 15),
(8, 80),
(9, 50),
(10, 150);


CREATE TABLE GEO.PAIS
(
	PaisID SMALLINT IDENTITY(1,1), --Llave Primaria
	Nombre VARCHAR(100) NOT NULL,
	CONSTRAINT PK_Pais PRIMARY KEY(PaisID)
);

INSERT INTO GEO.PAIS (Nombre)
VALUES
    ('Costa Rica')
	,('Estados Unidos')
	,('Canadá')
	,('México')
	,('Brasil')
	,('Argentina')
	,('España')
	,('Francia')
	,('Alemania')
	,('Italia')
	,('China')
	,('Japón')
	,('India')
	,('Australia')
	,('Sudáfrica')
	,('Egipto')
	,('Rusia')
	,('Turquía')
	,('Reino Unido')
	,('Corea del Sur');

CREATE TABLE Tipo.TIPO_DOCUMENTO
(
	Tipo_DocumentoID TINYINT IDENTITY (1,1), --Llave primaria
	Nombre_TipoDocumento VARCHAR(20) NOT NULL
	CONSTRAINT PK_Tipo_Documento PRIMARY KEY(Tipo_DocumentoID)
);

INSERT INTO Tipo.TIPO_DOCUMENTO(Nombre_TipoDocumento)
VALUES (N'Pasaporte'),
	   (N'Cédula'),
	   (N'DIMEX')
;

CREATE TABLE Persona.DOCUMENTO_IDENTIDAD
(
	DocumentoID TINYINT IDENTITY (1,1), --Llave Primaria
	PersonaID SMALLINT,
	Tipo_DocumentoID TINYINT NOT NULL,
	Valor NVARCHAR(50) NOT NULL,
	Fecha_Emision DATE NOT NULL,
	Fecha_Expiracion DATE NOT NULL,
	PaisID SMALLINT
	CONSTRAINT FK_Persona_Documento_ID FOREIGN KEY (PersonaID) REFERENCES Persona.PERSONA(PersonaID),
	CONSTRAINT FK_Tipo_Documento FOREIGN KEY (Tipo_DocumentoID) REFERENCES Tipo.TIPO_DOCUMENTO(Tipo_DocumentoID),
	CONSTRAINT FK_Pais_Documento FOREIGN KEY (PaisID) REFERENCES GEO.PAIS(PaisID)
);

-- Insertar datos en la tabla Persona.DOCUMENTO_IDENTIDAD
INSERT INTO Persona.DOCUMENTO_IDENTIDAD (PersonaID, Tipo_DocumentoID, Valor, Fecha_Emision, Fecha_Expiracion, PaisID) VALUES
(1, 1, 123456789, '2020-01-01', '2030-01-01', 1),
(2, 2, 987654321, '2019-05-15', '2029-05-15', 2),
(3, 1, 555111333, '2022-03-10', '2032-03-10', 3),
(4, 3, 777888999, '2021-08-20', '2031-08-20', 1),
(5, 2, 111222333, '2023-02-28', '2033-02-28', 4),
(6, 1, 999888777, '2020-11-05', '2030-11-05', 2),
(7, 3, 444555666, '2018-06-12', '2028-06-12', 5),
(8, 2, 666777888, '2017-09-30', '2027-09-30', 3),
(9, 1, 222333444, '2019-04-15', '2029-04-15', 4),
(10, 3, 888999000, '2022-07-25', '2032-07-25', 5);

CREATE TABLE Tipo.TIPO_CONTACTO
(
	Tipo_ContactoID SMALLINT IDENTITY(1,1),
	Tipo_Contacto VARCHAR(50) NOT NULL,
	CONSTRAINT PK_Contacto PRIMARY KEY(Tipo_ContactoID)
);

INSERT INTO Tipo.TIPO_CONTACTO(Tipo_Contacto)
VALUES ('Celular'),
	   ('Telefono Casa'),
	   ('Telefono Trabajo'),
	   ('Correo Personal')
;

CREATE TABLE Contacto.MECANISMO_DE_CONTACTO
(
	Mec_ContactoID SMALLINT IDENTITY(1,1) NOT NULL, --Llave Primaria
	Valor NVARCHAR(50) NOT NULL,
	Instruccion VARCHAR(500),
	Prioridad TINYINT NOT NULL,
	Codigo_Pais TINYINT NOT NULL,
	Codigo_Area TINYINT NOT NULL,
	Solicitado BIT NOT NULL,
	PersonaID SMALLINT NOT NULL,
	Tipo_ContactoID SMALLINT NOT NULL,
	CONSTRAINT PK_Mec_Contacto PRIMARY KEY(Mec_ContactoID),
	CONSTRAINT FK_Mecanismo_Contacto_Personas_ID FOREIGN KEY (PersonaID) REFERENCES Persona.PERSONA(PersonaID),
	CONSTRAINT FK_Tipo_MecContacto FOREIGN KEY(Tipo_ContactoID) REFERENCES Tipo.TIPO_CONTACTO(Tipo_ContactoID)
);

-- Insertar datos en la tabla Contacto.MECANISMO_DE_CONTACTO
INSERT INTO Contacto.MECANISMO_DE_CONTACTO (
    Valor,
    Instruccion,
    Prioridad,
    Codigo_Pais,
    Codigo_Area,
    Solicitado,
    PersonaID,
    Tipo_ContactoID
) VALUES
(123456789, 'Llamar después de las 5 PM', 1, 1, 2, 1, 1, 1),
(987654321, 'Enviar un correo electrónico', 2, 2, 3, 0, 2, 2),
(555111333, 'SMS preferido', 3, 3, 4, 1, 3, 3),
(777888999, 'Contactar solo en emergencias', 1, 1, 2, 0, 4, 1),
(111222333, 'Disponible para videollamadas', 2, 2, 3, 1, 5, 2),
(999888777, 'Llamar en horario laboral', 3, 3, 4, 0, 6, 3),
(444555666, 'Correo electrónico secundario', 1, 1, 2, 1, 7, 1),
(666777888, 'Llamada urgente', 2, 2, 3, 0, 8, 2),
(222333444, 'SMS preferido', 3, 3, 4, 1, 9, 3),
(888999000, 'Contacto preferido por videollamada', 1, 1, 2, 1, 10, 1);

CREATE TABLE Contacto.ESTADO_MECANISMO 
(
	Estado_ID SMALLINT IDENTITY(1,1), --Llave primaria
	Desc_Estado VARCHAR(500) NOT NULL,
	CONSTRAINT PK_Estado PRIMARY KEY(Estado_ID),
);

INSERT INTO Contacto.ESTADO_MECANISMO (Desc_Estado)
VALUES
    ('Activo'),
    ('Inactivo');

CREATE TABLE Contacto.MECANISMO_POR_ESTADO
(
	Mecanismo_EstadoID SMALLINT IDENTITY(1,1) NOT NULL,
	Fecha_Inicio DATE NOT NULL,
	Fecha_Final DATE NOT NULL,
	Estado_ID SMALLINT NOT NULL,
	Mec_ContactoID SMALLINT NOT NULL,
	CONSTRAINT PK_Estado_Mec PRIMARY KEY(Mecanismo_EstadoID),
	CONSTRAINT FK_Mecanismo_EstadoID FOREIGN KEY (Estado_ID) REFERENCES Contacto.ESTADO_MECANISMO(Estado_ID),
	CONSTRAINT FK_MEC_DE_CONTACTO_ID FOREIGN KEY (Mec_ContactoID) REFERENCES Contacto.MECANISMO_DE_CONTACTO(Mec_ContactoID)

);

-- Insertar datos en la tabla Contacto.MECANISMO_POR_ESTADO
INSERT INTO Contacto.MECANISMO_POR_ESTADO (Fecha_Inicio, Fecha_Final, Estado_ID, Mec_ContactoID) VALUES
('2022-01-01', '2024-12-31', 1, 1),
('2022-01-01', '2024-12-31', 2, 2),
('2022-01-01', '2024-12-31', 3, 3),
('2022-01-01', '2024-12-31', 1, 4),
('2022-01-01', '2024-12-31', 2, 5),
('2022-01-01', '2024-12-31', 3, 6),
('2022-01-01', '2024-12-31', 1, 7),
('2022-01-01', '2024-12-31', 2, 8),
('2022-01-01', '2024-12-31', 3, 9),
('2022-01-01', '2024-12-31', 1, 10);


CREATE TABLE Contacto.SITIO_WEB
(
    SitioWebID SMALLINT IDENTITY(1,1) PRIMARY KEY,
    [URL] VARCHAR(200) NOT NULL,
    Nombre VARCHAR(100) NOT NULL,
    FechaCreacion DATE NOT NULL,
    PersonaID SMALLINT NOT NULL,
    CONSTRAINT FK_TipoPersonaID_Documento FOREIGN KEY (PersonaID) REFERENCES Persona.PERSONA(PersonaID)
);

-- Insertar datos en la tabla Contacto.SITIO_WEB
INSERT INTO Contacto.SITIO_WEB ([URL], Nombre, FechaCreacion, PersonaID) VALUES
('http://www.ejemplo1.com', 'Ejemplo 1', '2022-01-01', 1),
('http://www.ejemplo2.com', 'Ejemplo 2', '2022-02-15', 2);


CREATE TABLE Moneda.MONEDA
(
	MonedaID SMALLINT IDENTITY(1,1), --Llave primaria
	Nombre VARCHAR(100) NOT NULL,
	ISO_Alpha_2 CHAR(2)NOT NULL,
    ISO_Alpha_3 CHAR(3)NOT NULL,
	CONSTRAINT PK_Moneda PRIMARY KEY(MonedaID)
);


INSERT INTO Moneda.MONEDA(Nombre,ISO_Alpha_2,ISO_Alpha_3)
VALUES ('Colon','CR','CRC')
      ,('Dolar','US','USD')
	  ,('Dolar canadiense','CA','CAD')
	  ,('Euro','EU','EUR')
	  ,('Peso chileno','CL','CLP')
	  ,('Renminbi','CN','CNY')
	  ,('Won','KR','KRW')
	  ,('Yen','JP','JPY')
	  ,('Rublo ruso','RU','RUB')
	  ,('Franco suizo','CH','CHF')
;


CREATE TABLE Tipo.TIPO_DE_CAMBIO
(
	Tipos_CambioID TINYINT IDENTITY(1,1),
	Valor DECIMAL(7,2) NOT NULL, 
	Fecha DATE NOT NULL,
	Tipo_Cambio VARCHAR(20)NOT NULL,
	MonedaID SMALLINT NOT NULL,
	MonedaID_a_Cambiar SMALLINT NOT NULL
	CONSTRAINT PK_Tipo_Cambio PRIMARY KEY(Tipos_CambioID),
	CONSTRAINT FK_Moneda FOREIGN KEY (MonedaID) REFERENCES Moneda.MONEDA(MonedaID),
	CONSTRAINT FK_Moneda_Cambio FOREIGN KEY (MonedaID_a_Cambiar) REFERENCES Moneda.MONEDA(MonedaID)
);

INSERT INTO Tipo.TIPO_DE_CAMBIO(Valor, Fecha, Tipo_Cambio, MonedaID, MonedaID_a_Cambiar)
VALUES (522.00, '2023-12-01', 'Compra', 1, 2),
       (532.01, '2023-12-02', 'Venta', 1, 2),
       (1.35, '2023-12-03', 'Compra', 3, 2),
       (1.36, '2023-12-04', 'Venta', 3, 2),
       (145.36, '2023-12-05', 'Compra', 8, 2),
       (145.37, '2023-12-06', 'Venta', 8, 2),
       (1.07, '2023-12-07', 'Compra', 2, 4),
       (1.07, '2023-12-08', 'Venta', 2, 4),
       (0.60, '2023-12-09', 'Compra', 5, 1),
       (0.62, '2023-12-10', 'Venta', 5, 1)
;

CREATE TABLE Tipo.TIPO_DE_INGRESO
(
	TipoIngresoID SMALLINT IDENTITY(1,1) NOT NULL,
	Descripcion VARCHAR(500)NOT NULL,
	CONSTRAINT PK_FormasIngreso PRIMARY KEY(TipoIngresoID)
);

INSERT INTO Tipo.TIPO_DE_INGRESO(Descripcion)
VALUES   ('Salario')
		,('Honorarios')
		,('Inversiones')
		,('Ventas')
		,('Alquiler')
		,('Prestamos')
		,('Regalías')
		,('Subsidios')
		,('Premios')
		,('Otros Ingresos')
;

CREATE TABLE Persona.INGRESOS
(
	IngresosID SMALLINT IDENTITY(1,1), --Llave Primaria
	MonedaID SMALLINT NOT NULL,
	Monto MONEY NOT NULL,
	Descripcion VARCHAR(500) NOT NULL,
	TipoIngresoID SMALLINT NOT NULL,
	PersonaID SMALLINT NOT NULL
	CONSTRAINT PK_Ingresos PRIMARY KEY(IngresosID),
	CONSTRAINT FK_Tipo_Ingreso FOREIGN KEY (TipoIngresoID) REFERENCES Tipo.TIPO_DE_INGRESO(TipoIngresoID),
	CONSTRAINT FK_MonedaID FOREIGN KEY(MonedaID) REFERENCES Moneda.MONEDA(MonedaID),
	CONSTRAINT FK_Persona_Ingreso FOREIGN KEY(PersonaID) REFERENCES Persona.PERSONA(PersonaID)
);

-- Insertar datos en la tabla Persona.INGRESOS
INSERT INTO Persona.INGRESOS (MonedaID, Monto, Descripcion, TipoIngresoID, PersonaID) VALUES
(1, 5000.00, 'Salario mensual', 1, 1),
(2, 800.50, 'Ingresos por alquiler', 2, 2),
(1, 12000.75, 'Bonificación anual', 3, 3),
(2, 3000.00, 'Ingresos por servicios profesionales', 1, 4),
(1, 600.25, 'Ingresos por ventas', 2, 5),
(2, 7000.50, 'Honorarios por consultoría', 3, 6),
(1, 4500.75, 'Ingresos por freelance', 1, 7),
(2, 900.00, 'Ingresos por alquiler de propiedad', 2, 8),
(1, 5500.25, 'Salario mensual', 3, 9),
(2, 1500.50, 'Ingresos por servicios técnicos', 1, 10);


CREATE TABLE Tipo.TIPO_DIRECCION
(
	Tipo_DireccionID SMALLINT IDENTITY(1,1), --Llave primaria
	Descripcion VARCHAR(500) NOT NULL,
	CONSTRAINT PK_TipoDireccion PRIMARY KEY(Tipo_DireccionID)
);

INSERT INTO Tipo.TIPO_DIRECCION (Descripcion)
VALUES
    ('Hogar'),
    ('Trabajo'),
    ('Dirección Temporal'), 
    ('Otro');

CREATE TABLE GEO.DIVISION_GEO
(
	Tipo_GeoID SMALLINT IDENTITY(1,1), --Llave Primaria 
	Descripcion VARCHAR (250)
	CONSTRAINT PK_Tipo_Geo PRIMARY KEY(Tipo_GeoID)
);

INSERT INTO GEO.DIVISION_GEO (Descripcion)
VALUES
    ('Provincia'),
    ('Cantón'),
    ('Ciudad'),
    ('Distrito');

CREATE TABLE GEO.GEO 
(
	GeoID SMALLINT IDENTITY(1,1), --Llave Primaria
	Nombre VARCHAR (250),
	DireccionID SMALLINT NOT NULL,
	Sup_GeoID SMALLINT,
	Tipo_GeoID SMALLINT NOT NULL,
	PaisID SMALLINT NOT NULL
	CONSTRAINT PK_Geo PRIMARY KEY(GeoID),
	CONSTRAINT FK_Geo FOREIGN KEY(Sup_GeoID)REFERENCES GEO.GEO(GeoID),
	CONSTRAINT FK_Div_Geo FOREIGN KEY(Tipo_GeoID)REFERENCES GEO.DIVISION_GEO(Tipo_GeoID),
	CONSTRAINT FK_Pais_Geo FOREIGN KEY (PaisID) REFERENCES GEO.PAIS(PaisID)
);

-- Insertar datos en la tabla GEO.GEO
INSERT INTO GEO.GEO (Nombre, DireccionID, Sup_GeoID, Tipo_GeoID, PaisID) VALUES
('San José', 21, NULL, 1, 8), -- Provincia
('Heredia', 22, NULL, 1, 8), -- Provincia
('Guanacaste', 23, NULL, 1, 8);

INSERT INTO GEO.GEO (Nombre, DireccionID, Sup_GeoID, Tipo_GeoID, PaisID) VALUES
('San José', 24, 21, 2, 8), -- Cantón (pertenece a San José)
('Heredia', 25, 22, 2, 8), -- Cantón (pertenece a Heredia)
('Liberia', 26, 23, 2, 8), -- Cantón (pertenece a Guanacaste)
('San Pedro', 27, 24, 3, 8);-- Ciudad (pertenece a San José)



CREATE TABLE Persona.DIRECCION
(
	DireccionID SMALLINT IDENTITY(1,1) NOT NULL, --Llave primaria
	Tipo_DireccionID SMALLINT NOT NULL,
	LineaDireccion1 VARCHAR(500) NOT NULL,
	LineaDireccion2 VARCHAR(500),
	CodigoPostal SMALLINT NOT NULL,
	CodigoRegion SMALLINT NOT NULL,
	ZIP NVARCHAR(50) NOT NULL, --Revisar si el dato esta bien definido--
	Solicitado BIT NOT NULL,
	Instrucciones VARCHAR(500) NOT NULL,
	Prioridad SMALLINT NOT NULL,
	PersonaID SMALLINT NOT NULL,
	GeoID SMALLINT NOT NULL
	CONSTRAINT PK_Direccion PRIMARY KEY(DireccionID),
	CONSTRAINT FK_Geo_Direccion FOREIGN KEY(GeoID)REFERENCES GEO.GEO(GeoID),
	CONSTRAINT FK_Persona_Direccion FOREIGN KEY(PersonaID) REFERENCES Persona.PERSONA(PersonaID),
	CONSTRAINT FK_Tipo_Direccion FOREIGN KEY(Tipo_DireccionID) REFERENCES Tipo.TIPO_DIRECCION(Tipo_DireccionID)
);

-- Insertar datos en la tabla Persona.DIRECCION
INSERT INTO Persona.DIRECCION (
    Tipo_DireccionID,
    LineaDireccion1,
    LineaDireccion2,
    CodigoPostal,
    CodigoRegion,
    ZIP,
    Solicitado,
    Instrucciones,
    Prioridad,
    PersonaID,
    GeoID
) VALUES
(1, 'Calle Principal 123', 'Apartamento 4B', 12345, 1, 54321, 1, 'Frente al parque', 1, 1, 1), -- Dirección 1
(2, 'Avenida Central 456', NULL, 54321, 2, 98765, 0, 'Edificio Azul, Piso 8', 2, 2, 2), -- Dirección 2
(3, 'Calle Sur 789', 'Casa 10', 67890, 3, 12345, 1, 'Esquina de la iglesia', 1, 3, 3), -- Dirección 3
(1, 'Calle Este 321', 'Apartamento 5A', 54321, 1, 87654, 0, 'Frente al supermercado', 2, 4, 4), -- Dirección 4
(2, 'Avenida Oeste 654', NULL, 98765, 2, 23456, 1, 'Edificio Rojo, Piso 12', 1, 5, 5), -- Dirección 5
(3, 'Calle Norte 987', 'Casa 20', 23456, 3, 76543, 0, 'Al lado del parque', 2, 6, 6), -- Dirección 6
(1, 'Avenida Principal 111', 'Apartamento 6C', 87654, 1, 34567, 1, 'Frente al cine', 1, 7, 7), -- Dirección 7
(2, 'Calle Secundaria 222', NULL, 23456, 2, 45678, 0, 'Edificio Amarillo, Piso 5', 2, 8, 8), -- Dirección 8
(3, 'Avenida Trasera 333', 'Casa 30', 76543, 3, 56789, 1, 'Detrás del mercado', 1, 9, 9), -- Dirección 9
(1, 'Calle Escondida 444', 'Apartamento 7D', 34567, 1, 67890, 0, 'Frente a la escuela', 2, 10, 10); -- Dirección 10


CREATE TABLE Persona.ESTADO_CIVIL
(
	EstadoCivil_ID SMALLINT IDENTITY(1,1) NOT NULL,
	Descripcion_Estado_Civil VARCHAR(50) NOT NULL
	CONSTRAINT PK_Estado_Civil PRIMARY KEY(EstadoCivil_ID)
);

INSERT INTO Persona.ESTADO_CIVIL (Descripcion_Estado_Civil)
VALUES
     ('Soltero/a')
	,('Casado/a')
	,('Divorciado/a')
	,('Viudo/a')
	,('Separado/a')
	,('Comprometido/a')
	,('Unión libre')
	,('No especificado')
	,('Otro');

CREATE TABLE Historial.HISTORIAL_ESTADO_CIVIL
(
	HistorialEstadoCivilID SMALLINT IDENTITY(1,1) NOT NULL,
	EstadoCivil_ID SMALLINT NOT NULL,
	Fecha_Inicio DATE NOT NULL,
	Fecha_Final DATE,
	PersonaID SMALLINT NOT NULL
	CONSTRAINT PK_HistorialEstadoCivil PRIMARY KEY(HistorialEstadoCivilID),
	CONSTRAINT FK_Estado_Civil FOREIGN KEY(EstadoCivil_ID) REFERENCES Persona.ESTADO_CIVIL(EstadoCivil_ID),
	CONSTRAINT FK_Historial_Persona FOREIGN KEY(PersonaID) REFERENCES Persona.PERSONA(PersonaID)
);

-- Insertar datos en la tabla Historial.HISTORIAL_ESTADO_CIVIL
INSERT INTO Historial.HISTORIAL_ESTADO_CIVIL (EstadoCivil_ID, Fecha_Inicio, Fecha_Final, PersonaID) VALUES
(1, '2020-01-01', '2022-03-15', 1), -- Persona 1
(2, '2019-05-15', '2021-11-30', 2), -- Persona 2
(3, '2022-03-10', NULL, 3), -- Persona 3
(1, '2021-08-20', NULL, 4), -- Persona 4
(2, '2023-02-28', NULL, 5), -- Persona 5
(3, '2020-11-05', NULL, 6), -- Persona 6
(1, '2018-06-12', '2022-02-01', 7), -- Persona 7
(2, '2017-09-30', '2020-12-31', 8), -- Persona 8
(3, '2019-04-15', NULL, 9), -- Persona 9
(1, '2022-07-25', NULL, 10); -- Persona 10

CREATE TABLE Respuesta.PREGUNTA
(
	PreguntaID SMALLINT IDENTITY (1,1), --Llave Primaria
	Descripcion VARCHAR(500) NOT NULL,
	CONSTRAINT PK_Pregunta PRIMARY KEY(PreguntaID)
);

INSERT INTO Respuesta.PREGUNTA (Descripcion)
VALUES
    ('¿Posee vehículos?'),
    ('¿Posee propiedades?');

CREATE TABLE Respuesta.RESPUESTA
(
	RespuestaID SMALLINT IDENTITY (1,1), --Llave Primaria
	Respuesta VARCHAR(250),
	PersonaID SMALLINT NOT NULL,
	PreguntaID SMALLINT NOT NULL
	CONSTRAINT PK_Respuesta PRIMARY KEY(RespuestaID),
	CONSTRAINT FK_Respuesta_Persona FOREIGN KEY(PersonaID) REFERENCES Persona.PERSONA(PersonaID),
	CONSTRAINT FK_Respuesta_Pregunta FOREIGN KEY(PreguntaID) REFERENCES Respuesta.PREGUNTA(PreguntaID)
);

-- Insertar datos en la tabla Respuesta.RESPUESTA
INSERT INTO Respuesta.RESPUESTA (Respuesta, PersonaID, PreguntaID) VALUES
('Sí', 1, 1), -- ¿Posee vehículos? - Persona 1
('No', 1, 2), -- ¿Posee propiedades? - Persona 1

('Sí', 2, 1), -- ¿Posee vehículos? - Persona 2
('Sí', 2, 2), -- ¿Posee propiedades? - Persona 2

('No', 3, 1), -- ¿Posee vehículos? - Persona 3
('Sí', 3, 2), -- ¿Posee propiedades? - Persona 3

('Sí', 4, 1), -- ¿Posee vehículos? - Persona 4
('No', 4, 2), -- ¿Posee propiedades? - Persona 4

('No', 5, 1), -- ¿Posee vehículos? - Persona 5
('No', 5, 2), -- ¿Posee propiedades? - Persona 5

('Sí', 6, 1), -- ¿Posee vehículos? - Persona 6
('Sí', 6, 2), -- ¿Posee propiedades? - Persona 6

('No', 7, 1), -- ¿Posee vehículos? - Persona 7
('Sí', 7, 2), -- ¿Posee propiedades? - Persona 7

('Sí', 8, 1), -- ¿Posee vehículos? - Persona 8
('No', 8, 2), -- ¿Posee propiedades? - Persona 8

('No', 9, 1), -- ¿Posee vehículos? - Persona 9
('Sí', 9, 2), -- ¿Posee propiedades? - Persona 9

('Sí', 10, 1), -- ¿Posee vehículos? - Persona 10
('Sí', 10, 2); -- ¿Posee propiedades? - Persona 10


-- Esquema Homologacion --
GO
CREATE SCHEMA Homologacion AUTHORIZATION dbo;
GO

-- Tablas OLTP
CREATE TABLE Homologacion.GENERO_OLTP (
    ID_Gen_String SMALLINT IDENTITY(1,1) NOT NULL,
    String VARCHAR(500),
    CONSTRAINT PK_GENERO_OLTP PRIMARY KEY (ID_Gen_String)
);

CREATE TABLE Homologacion.PROFESION_OLTP (
    ID_Prof_String SMALLINT IDENTITY(1,1) NOT NULL,
    String VARCHAR(500),
    CONSTRAINT PK_PROFESION_OLTP PRIMARY KEY (ID_Prof_String)
);

CREATE TABLE Homologacion.Estado_Civil_OLTP (
    ID_Civil_String SMALLINT IDENTITY(1,1) NOT NULL,
    String VARCHAR(500),
   CONSTRAINT PK_ESTADO_CIVIL_OLTP PRIMARY KEY (ID_Civil_String)
);

CREATE TABLE Homologacion.Estado_ECON_OLTP (
    ID_Econ_String SMALLINT IDENTITY(1,1) NOT NULL,
    String VARCHAR(500),
    CONSTRAINT PK_ESTADO_ECON_OLTP PRIMARY KEY (ID_Econ_String)
);

-- Tablas en el esquema Homologacion
CREATE TABLE Homologacion.TABLA_HL_GENERO (
    Homologacion_ID SMALLINT IDENTITY(1,1) NOT NULL,
    String VARCHAR(500),
	Genero_OLTP_ID SMALLINT NOT NULL,
	Genero_ID TINYINT NOT NULL,
    CONSTRAINT PK_TABLA_HL_GENERO PRIMARY KEY (Homologacion_ID),
	CONSTRAINT FK_OLTP_GENERO FOREIGN KEY (Genero_OLTP_ID) REFERENCES Homologacion.GENERO_OLTP(ID_Gen_String),
	CONSTRAINT FK_Genero_HL FOREIGN KEY (Genero_ID) REFERENCES Persona.GENERO(GeneroID)
);

CREATE TABLE Homologacion.TABLA_HL_PROFESION (
    Homologacion_ID SMALLINT IDENTITY(1,1) NOT NULL,
    String VARCHAR(500),
	Profesion_OLTP_ID SMALLINT NOT NULL,
	ProfesionID SMALLINT NOT NULL,
    CONSTRAINT PK_TABLA_HL_PROFESION PRIMARY KEY (Homologacion_ID),
	CONSTRAINT FK_OLTP_PROFESION FOREIGN KEY (Profesion_OLTP_ID) REFERENCES Homologacion.PROFESION_OLTP(ID_Prof_String),
	CONSTRAINT FK_Profesion_HL FOREIGN KEY (ProfesionID) REFERENCES Persona.PROFESION(Profesion_ID)
);

CREATE TABLE Homologacion.TABLA_HL_ESTADO_CIVIL (
    Homologacion_ID SMALLINT IDENTITY(1,1) NOT NULL,
    String VARCHAR(500),
	Civil_OLTP_ID SMALLINT NOT NULL,
	Estado_CivilID SMALLINT NOT NULL,
    CONSTRAINT PK_TABLA_HL_ESTADO_CIVIL PRIMARY KEY (Homologacion_ID),
	CONSTRAINT FK_OLTP_ESTADO_CIVIL FOREIGN KEY (Civil_OLTP_ID) REFERENCES Homologacion.Estado_Civil_OLTP(ID_Civil_String),
	CONSTRAINT FK_Estado_Civil_HL FOREIGN KEY (Estado_CivilID) REFERENCES Persona.ESTADO_CIVIL(EstadoCivil_ID)
);

CREATE TABLE Homologacion.TABLA_HL_ACTIVIDAD_ECONOMICA (
    Homologacion_ID SMALLINT IDENTITY(1,1) NOT NULL,
    String VARCHAR(500),
	Actividad_OLTP_ID SMALLINT NOT NULL,
	Actividad_ID TINYINT NOT NULL,
    CONSTRAINT PK_TABLA_HL_ACTIVIDAD_ECONOMICA PRIMARY KEY (Homologacion_ID),
	CONSTRAINT FK_OLTP_ACTIVIDAD_ECON FOREIGN KEY (Actividad_OLTP_ID) REFERENCES Homologacion.Estado_ECON_OLTP(ID_Econ_String),
	CONSTRAINT FK_Actividad_HL FOREIGN KEY (Actividad_ID) REFERENCES Persona.ACTIVIDAD_ECONOMICA(ActividadEconomica_ID)
);


GO
CREATE PROCEDURE insertarPersona
(
	@primerNombre NVARCHAR(255)
	,@segundoNombre NVARCHAR(255)
	,@primerApellido NVARCHAR(255)
	,@segundoApellido NVARCHAR(255)
	,@Fecha_Nacimiento DATE 
	,@Lugar_Nacimiento NVARCHAR (255)
	,@Numero_Dependientes TINYINT
	,@Tipo_PersonaID TINYINT 
	,@GeneroID TINYINT
	,@ActividadEconomica_ID TINYINT
	,@Profesion_ID SMALLINT
	,@Estado_Vivo BIT 
	,@Fecha_Defuncion DATE
)
AS
BEGIN
     INSERT INTO Persona.PERSONA(Primer_Nombre,
	Segundo_Nombre,
	Primer_Apellido,
	Segundo_Apellido,
	Fecha_Nacimiento,
	Lugar_Nacimiento,
	Numero_Dependientes,
	Tipo_PersonaID,
	GeneroID,
	ActividadEconomica_ID,
	Profesion_ID,
	Estado_Vivo,
	Fecha_Defuncion)
	VALUES
    (@primerNombre 
	,@segundoNombre 
	,@primerApellido 
	,@segundoApellido 
	,@Fecha_Nacimiento  
	,@Lugar_Nacimiento  
	,@Numero_Dependientes 
	,@Tipo_PersonaID  
	,@GeneroID 
	,@ActividadEconomica_ID 
	,@Profesion_ID 
	,@Estado_Vivo  
	,@Fecha_Defuncion);
END;


GO
CREATE PROCEDURE insertarGenero --
(
	@descripcion VARCHAR(255)
)
AS
BEGIN
    INSERT INTO Persona.GENERO(Descripcion)
	VALUES
    (@descripcion);
END;


GO
CREATE PROCEDURE deleteGenero
(
	@GeneroID TINYINT
)
AS
BEGIN
    DELETE FROM Persona.GENERO
	WHERE GENERO.GeneroID = @GeneroID;
END;


GO
CREATE PROCEDURE updateGenero
(
	@GeneroID TINYINT,
	@NuevaDescripcion VARCHAR(500)
)
AS
BEGIN
    UPDATE Persona.GENERO
    SET
        Descripcion = @NuevaDescripcion
    WHERE
        GeneroID = @GeneroID;
END;


GO
CREATE PROCEDURE insertarProfesion
(
	@descripcion VARCHAR(255)
)
AS
BEGIN
    INSERT INTO Persona.PROFESION(Descripcion)
	VALUES
    (@descripcion);
END;


GO
CREATE PROCEDURE deleteProfesion
(
	@GeneroID TINYINT
)
AS
BEGIN
    DELETE FROM Persona.PROFESION
	WHERE Persona.PROFESION.Profesion_ID = @GeneroID;
END;

GO
CREATE PROCEDURE updateProfesion
(
	@profesionID TINYINT
	,@descripcion NVARCHAR(255)
)
AS
BEGIN
    UPDATE Persona.PROFESION
	SET profesion.Descripcion=@descripcion
	WHERE Persona.PROFESION.Profesion_ID = @profesionID;
END;



GO
CREATE PROCEDURE insertarEstadoCivil
(
	@descripcion VARCHAR(255)
)
AS
BEGIN
    INSERT INTO Persona.ESTADO_CIVIL(Descripcion_Estado_Civil)
	VALUES
    (@descripcion)
END;


GO
CREATE PROCEDURE deleteEstadoCivil
(
	@estadoID SMALLINT
)
AS
BEGIN
	DELETE FROM persona.ESTADO_CIVIL
	WHERE Persona.ESTADO_CIVIL.EstadoCivil_ID=@estadoID
END;


GO
CREATE PROCEDURE updateEstadoCivil
(
	@estadoID SMALLINT
	,@descripcion NVARCHAR(255)
)
AS
BEGIN
	UPDATE persona.ESTADO_CIVIL
	SET Descripcion_Estado_Civil=@descripcion
	WHERE Persona.ESTADO_CIVIL.EstadoCivil_ID=@estadoID
END;

GO
CREATE PROCEDURE insertActividadEconomica
(
	@descripcion NVARCHAR(255)
)
AS
BEGIN
	INSERT INTO persona.ACTIVIDAD_ECONOMICA(Persona.ACTIVIDAD_ECONOMICA.Descripcion)
VALUES
(@descripcion)
END;


	
GO
CREATE PROCEDURE deleteActividadEconomica
(
	@actividadID TINYINT
)
AS
BEGIN
	DELETE FROM persona.ACTIVIDAD_ECONOMICA
	WHERE persona.ACTIVIDAD_ECONOMICA.ActividadEconomica_ID=@actividadID
END;



GO
CREATE PROCEDURE updateActividadEconomica
(
	@ActividadID SMALLINT
	,@descripcion NVARCHAR(255)
)
AS
BEGIN
	UPDATE persona.ACTIVIDAD_ECONOMICA
	SET Descripcion=@descripcion
	WHERE ActividadEconomica_ID=@ActividadID
END;


GO
CREATE PROCEDURE deleteMecanismoPorEstado
(
    @personaID SMALLINT
)
AS
BEGIN
    DELETE EPM
    FROM Contacto.MECANISMO_POR_ESTADO AS EPM
	INNER JOIN Contacto.MECANISMO_DE_CONTACTO AS MC
	ON (EPM.Mec_ContactoID=MC.Mec_ContactoID)
    WHERE MC.PersonaID = @personaID;
END;

GO
CREATE PROCEDURE deleteCliente
(
    @personaID SMALLINT
)
AS
BEGIN
    DELETE FROM persona.CLIENTE
    WHERE Persona.CLIENTE.PersonaID=@personaID
END;

GO
CREATE PROCEDURE deleteDocumento_Identidad
(
    @personaID SMALLINT
)
AS
BEGIN
    DELETE FROM persona.DOCUMENTO_IDENTIDAD
    WHERE Persona.DOCUMENTO_IDENTIDAD.PersonaID=@personaID
END;

GO
CREATE PROCEDURE deleteMecanismo_Contacto
(
    @personaID SMALLINT
)
AS
BEGIN
    DELETE FROM contacto.MECANISMO_DE_CONTACTO
    WHERE Contacto.MECANISMO_DE_CONTACTO.PersonaID=@personaID
END;

GO
CREATE PROCEDURE deleteSitio_web
(
    @personaID SMALLINT
)
AS
BEGIN
    DELETE FROM Contacto.SITIO_WEB
    WHERE Contacto.SITIO_WEB.PersonaID=@personaID
END;


GO
CREATE PROCEDURE deleteIngresos
(
    @personaID SMALLINT
)
AS
BEGIN
    DELETE FROM persona.INGRESOS
    WHERE Persona.INGRESOS.PersonaID=@personaID
END;

GO
CREATE PROCEDURE deleteDireccion
(
    @personaID SMALLINT
)
AS
BEGIN
    DELETE FROM persona.DIRECCION
    WHERE Persona.DIRECCION.PersonaID=@personaID
END;

GO
CREATE PROCEDURE deleteHistorial_Estado_Civil
(
    @personaID SMALLINT
)
AS
BEGIN
    DELETE FROM Historial.HISTORIAL_ESTADO_CIVIL
    WHERE Historial.HISTORIAL_ESTADO_CIVIL.PersonaID=@personaID
END;

GO
CREATE PROCEDURE deleteRespuesta
(
    @personaID SMALLINT
)
AS
BEGIN
    DELETE FROM Respuesta.RESPUESTA
    WHERE Respuesta.RESPUESTA.PersonaID=@personaID
END;


GO
CREATE PROCEDURE deletePersona
(
	@personaID SMALLINT
)
AS
BEGIN
	EXEC deleteRespuesta @personaID;
	EXEC deleteHistorial_Estado_Civil @personaID;
	EXEC deleteDireccion @personaID;
	EXEC deleteDocumento_Identidad @personaID;
	EXEC deleteIngresos @personaID;
	EXEC deletecliente @personaID;
	EXEC deleteSitio_web @personaID;
	EXEC deleteMecanismoPorEstado @personaID;
	EXEC deleteMecanismo_Contacto @personaID;

	DELETE FROM Persona.PERSONA
	WHERE Persona.PersonaID=@personaID
END;
