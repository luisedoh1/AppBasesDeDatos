--CREATE DATABASE Base_Proyecto;
--USE Base_Proyecto;

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

CREATE TABLE Persona.CLIENTE
(
	ClienteID SMALLINT IDENTITY (1,1),
	PersonaID SMALLINT NOT NULL, --Llave Primaria
	Numero_Empleados INT,
	CONSTRAINT PK_Cliente PRIMARY KEY(ClienteID),
	CONSTRAINT FK_Cliente_Personas_ID FOREIGN KEY (PersonaID) REFERENCES Persona.PERSONA(PersonaID)
);

--INSERT INTO CLIENTE (Numero_Empleados) Cambiar Insert
--VALUES
--    (5),
--    (0),
--    (100),
--    (30),
--    (35),
--    (15),
--    (200),
--    (10),
--    (0),
--    (2);

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
	Valor SMALLINT NOT NULL,
	Fecha_Emision DATE NOT NULL,
	Fecha_Expiracion DATE NOT NULL,
	PaisID SMALLINT
	CONSTRAINT FK_Persona_Documento_ID FOREIGN KEY (PersonaID) REFERENCES Persona.PERSONA(PersonaID),
	CONSTRAINT FK_Tipo_Documento FOREIGN KEY (Tipo_DocumentoID) REFERENCES Tipo.TIPO_DOCUMENTO(Tipo_DocumentoID),
	CONSTRAINT FK_Pais_Documento FOREIGN KEY (PaisID) REFERENCES GEO.PAIS(PaisID)
);


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
	Valor TINYINT NOT NULL,
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


CREATE TABLE Contacto.SITIO_WEB
(
    SitioWebID SMALLINT IDENTITY(1,1) PRIMARY KEY,
    [URL] VARCHAR(200) NOT NULL,
    Nombre VARCHAR(100) NOT NULL,
    FechaCreacion DATE NOT NULL,
    PersonaID SMALLINT NOT NULL,
    CONSTRAINT FK_TipoPersonaID_Documento FOREIGN KEY (PersonaID) REFERENCES Persona.PERSONA(PersonaID)
);


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

/*INSERT INTO Persona.INGRESOS(MonedaID, Monto, Descripcion, TipoIngresoID, PersonaID) --Error--
VALUES   (2, 5000, 'Salario mensual', 1, 1)
		,(2, 800, 'Honorarios por consultoría', 2, 2)
		,(2, 12000, 'Ingresos por inversiones', 3, 3)
		,(2, 1500, 'Ventas de productos', 4, 4)
		,(2, 1000, 'Alquiler de propiedad', 5, 5)
		,(4, 2000, 'Préstamo recibido', 6, 6)
		,(2, 300, 'Regalías por propiedad intelectual', 7, 7)
		,(2, 500, 'Subsidio gubernamental', 8, 8)
		,(2, 400, 'Otros ingresos varios', 9, 9)
		,(2, 100, 'Premio ganado', 10, 10);*/

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
	Sub_GeoID SMALLINT,
	Tipo_GeoID SMALLINT NOT NULL,
	PaisID SMALLINT NOT NULL
	CONSTRAINT PK_Geo PRIMARY KEY(GeoID),
	CONSTRAINT FK_Geo FOREIGN KEY(Sub_GeoID)REFERENCES GEO.GEO(GeoID),
	CONSTRAINT FK_Div_Geo FOREIGN KEY(Tipo_GeoID)REFERENCES GEO.DIVISION_GEO(Tipo_GeoID),
	CONSTRAINT FK_Pais_Geo FOREIGN KEY (PaisID) REFERENCES GEO.PAIS(PaisID)
);

CREATE TABLE Persona.DIRECCION
(
	DireccionID SMALLINT IDENTITY(1,1) NOT NULL, --Llave primaria
	Tipo_DireccionID SMALLINT NOT NULL,
	LineaDireccion1 VARCHAR(500) NOT NULL,
	LineaDireccion2 VARCHAR(500),
	CodigoPostal SMALLINT NOT NULL,
	CodigoRegion SMALLINT NOT NULL,
	ZIP SMALLINT NOT NULL, --Revisar si el dato esta bien definido--
	Solicitado BIT NOT NULL,
	Intrsucciones VARCHAR(500) NOT NULL,
	Prioridad SMALLINT NOT NULL,
	PersonaID SMALLINT NOT NULL,
	GeoID SMALLINT NOT NULL
	CONSTRAINT PK_Direccion PRIMARY KEY(DireccionID),
	CONSTRAINT FK_Geo_Direccion FOREIGN KEY(GeoID)REFERENCES GEO.GEO(GeoID),
	CONSTRAINT FK_Persona_Direccion FOREIGN KEY(PersonaID) REFERENCES Persona.PERSONA(PersonaID),
	CONSTRAINT FK_Tipo_Direccion FOREIGN KEY(Tipo_DireccionID) REFERENCES Tipo.TIPO_DIRECCION(Tipo_DireccionID)
);

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

/*
## insert, update y delete ##  
-Genero_listo
-profesion_listo
-estado_civil_listo
-actividad_economica_
*/

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




EXEC insertarPersona N'Alex', N'José', N'Quesada', N'Jiménez','2001-11-19', N'Grecia', 0, 2, 1, NULL, 1, 1, NULL;

/*########### procedures de Genero##############*/
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

EXEC insertarGenero N'pruebaGenero'

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

EXEC deleteGenero 4;

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

EXEC updateGenero
	4,N'Tarantulino';

SELECT*
FROM Persona.GENERO;

/*########### procedures de Profesion ##############*/

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

--DROP PROCEDURE IF EXISTS insertarProfesion; --ODIO A LUIS

EXEC insertarProfesion 'Estudiante'

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

EXEC deleteProfesion 11;

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

EXEC updateProfesion 12,N'EstudiantePrueba'

SELECT*
FROM Persona.PROFESION

/*############### Pocedures de Estado Civil ###############*/

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

EXEC insertarEstadoCivil N'nunca tan soltero';



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

EXEC deleteEstadoCivil 10;

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

EXEC updateEstadoCivil 11,N'nunca tan soltero prueba';

SELECT*
FROM Persona.ESTADO_CIVIL

/*################## Procedures de #####################*/ 
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

EXEC insertActividadEconomica N'Narcotrafico'
	
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

EXEC deleteActividadEconomica 11;

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

EXEC updateActividadEconomica 12,N'NarcoTrafico prueba'

SELECT*
FROM Persona.ACTIVIDAD_ECONOMICA

