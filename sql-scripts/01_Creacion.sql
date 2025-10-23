CREATE DATABASE SistemaIA
GO

USE SistemaIA;
GO

---------------------------------------------------
--  TABLAS Y RESTRICCIONES
---------------------------------------------------

CREATE TABLE Usuario
(
    IdUsuario INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(100) NOT NULL,
    Email NVARCHAR(250) UNIQUE NOT NULL,
    Contraseña NVARCHAR(256) NOT NULL,
    FechaCreacion DATETIME NOT NULL,
    FechaUltimaConexion DATETIME NOT NULL,
    Activo BIT NOT NULL,

    CONSTRAINT CHK_Usuario_Activo CHECK
    (Activo IN
    (0, 1))
);


CREATE TABLE TipoArchivo
(
    IdTipoArchivo INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(50) NOT NULL UNIQUE,
    Descripcion NVARCHAR(250)
);


CREATE TABLE Tool
(
    IdTool INT PRIMARY KEY IDENTITY (1, 1),
    Nombre NVARCHAR(100) NOT NULL UNIQUE,
    Descripcion NVARCHAR(250),
    Tipo CHAR(1) NOT NULL,

    CONSTRAINT CHK_Tool_Tipo CHECK (Tipo IN ('W', 'M', 'R', 'I', 'S'))
    -- Web, Matem�tica, Reporte, Integraci�n, Soporte
);


CREATE TABLE Agente
(
    IdAgente INT PRIMARY KEY IDENTITY (1,1),
    IdUsuarioDueño INT NOT NULL,
    Nombre NVARCHAR
        (100) NOT NULL,
    Descripcion NVARCHAR
        (250) NOT NULL,
    Instruccion NVARCHAR
        (2000) NOT NULL,
    Tipo CHAR
        (1) NOT NULL,
    FechaCreacion DATETIME NOT NULL,
    FechaUltimaModificacion DATETIME NOT NULL,
    Activo BIT NOT NULL,
    FOREIGN KEY
        (IdUsuarioDueño) REFERENCES Usuario
        (IdUsuario),
    CONSTRAINT CHK_Agente_Tipo CHECK
        (Tipo IN
        ('S', 'A', 'R', 'M')),
    -- Soporte, Automatizacion, Reporte, Marketing
    CONSTRAINT CHK_Agente_Activo CHECK
        (Activo IN
        (0, 1))
);

CREATE TABLE Archivo
(
    IdArchivo INT PRIMARY KEY IDENTITY (1, 1),
    IdUsuarioDueño INT NOT NULL,
    IdTipoArchivo INT NOT NULL,
    Nombre VARCHAR
            (150) NOT NULL,
    FechaSubida DATETIME NOT NULL,
    Peso INT NOT NULL,

    FOREIGN KEY
            (IdUsuarioDueño) REFERENCES Usuario
            (IdUsuario),
    FOREIGN KEY
            (IdTipoArchivo) REFERENCES TipoArchivo
            (IdTipoArchivo),
    CONSTRAINT CHK_Archivo_Peso CHECK
            (Peso > 0)
);


CREATE TABLE Chat
(
    IdChat INT PRIMARY KEY IDENTITY (1, 1),
    IdAgente INT NOT NULL,
    IdUsuario INT NOT NULL,
    FechaCreacion DATETIME NOT NULL,

    FOREIGN KEY (IdAgente) REFERENCES Agente(IdAgente),
    FOREIGN KEY (IdUsuario) REFERENCES Usuario(IdUsuario)
);

CREATE TABLE CompartirAgente
(
    IdAgente INT NOT NULL,
    IdUsuarioCompartido INT NOT NULL,
    FechaAsignacion DATETIME NOT NULL,

    PRIMARY KEY (IdAgente, IdUsuarioCompartido),
    FOREIGN KEY (IdAgente) REFERENCES Agente(IdAgente),
    FOREIGN KEY (IdUsuarioCompartido) REFERENCES Usuario(IdUsuario)
);

CREATE TABLE AgenteArchivo
(
    IdAgente INT NOT NULL,
    IdArchivo INT NOT NULL,
    FechaAsignacion DATETIME NOT NULL,

    PRIMARY KEY (IdAgente, IdArchivo),
    FOREIGN KEY (IdAgente) REFERENCES Agente(IdAgente),
    FOREIGN KEY (IdArchivo) REFERENCES Archivo(IdArchivo)
);

CREATE TABLE AgenteTool
(
    IdAgente INT NOT NULL,
    IdTool INT NOT NULL,
    FechaAsignacion DATETIME NOT NULL,

    PRIMARY KEY (IdAgente, IdTool),
    FOREIGN KEY (IdAgente) REFERENCES Agente(IdAgente),
    FOREIGN KEY (IdTool) REFERENCES Tool(IdTool)
);
GO