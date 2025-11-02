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
    Contrasena NVARCHAR(256) NOT NULL,
    FechaCreacion DATETIME NOT NULL DEFAULT GETDATE(),
    FechaUltimaConexion DATETIME NOT NULL DEFAULT GETDATE(),
    Activo BIT NOT NULL DEFAULT 1,

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

CREATE TABLE Permiso
(
	IdPermiso INT PRIMARY KEY NOT NULL,
	Nombre NVARCHAR(50) NOT NULL UNIQUE,
	Descripcion NVARCHAR(250) NOT NULL
);

CREATE TABLE Tool
(
    IdTool INT PRIMARY KEY IDENTITY (1, 1),
    Nombre NVARCHAR(100) NOT NULL UNIQUE,
    Descripcion NVARCHAR(250),
    Tipo CHAR(1) NOT NULL,

    CONSTRAINT CHK_Tool_Tipo CHECK (Tipo IN ('P', 'E'))
    -- P = Predeterminada (se asigna por default al crear un agente), 
    -- E = Especializada (el usuario las asigna como tools extra a sus agentes)
);


CREATE TABLE Agente
(
    IdAgente INT PRIMARY KEY IDENTITY (1,1),
    IdUsuarioDueno INT NOT NULL,
    Nombre NVARCHAR(100) NOT NULL,
    Descripcion NVARCHAR(250) NOT NULL,
    Instruccion NVARCHAR(MAX) NOT NULL,
    Tipo CHAR (1) NOT NULL,
    FechaCreacion DATETIME NOT NULL DEFAULT GETDATE(),
    FechaUltimaModificacion DATETIME NOT NULL DEFAULT GETDATE(),
    Activo BIT NOT NULL DEFAULT 1,
    FOREIGN KEY
        (IdUsuarioDueno) REFERENCES Usuario
        (IdUsuario),
    CONSTRAINT CHK_Agente_Tipo CHECK
        (Tipo IN
        ('S', 'A')),
    -- S = Simple (sin archivos asociados), A = Avanzado (con archivos - RAG)
    CONSTRAINT CHK_Agente_Activo CHECK
        (Activo IN
        (0, 1))
);

CREATE TABLE Archivo
(
    IdArchivo INT PRIMARY KEY IDENTITY (1, 1),
    IdUsuarioDueno INT NOT NULL,
    IdTipoArchivo INT NOT NULL,
    Nombre NVARCHAR(150) NOT NULL,
    FechaSubida DATETIME NOT NULL DEFAULT GETDATE(),
    Peso INT NOT NULL,
    -- en bytes
    Ruta NVARCHAR(MAX) NOT NULL,
    FOREIGN KEY
            (IdUsuarioDueno) REFERENCES Usuario
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
    FechaCreacion DATETIME NOT NULL DEFAULT GETDATE(),

    FOREIGN KEY (IdAgente) REFERENCES Agente(IdAgente),
    FOREIGN KEY (IdUsuario) REFERENCES Usuario(IdUsuario)
);

CREATE TABLE CompartirAgente
(
    IdAgente INT NOT NULL,
    IdUsuarioCompartido INT NOT NULL,
    IdPermiso INT NOT NULL,
    FechaAsignacion DATETIME NOT NULL default GETDATE(),

    PRIMARY KEY (IdAgente, IdUsuarioCompartido),
    FOREIGN KEY (IdAgente) REFERENCES Agente(IdAgente),
    FOREIGN KEY (IdPermiso) REFERENCES Permiso(IdPermiso),
    FOREIGN KEY (IdUsuarioCompartido) REFERENCES Usuario(IdUsuario)
);

CREATE TABLE AgenteArchivo
(
    IdAgente INT NOT NULL,
    IdArchivo INT NOT NULL,
    FechaAsignacion DATETIME NOT NULL DEFAULT GETDATE(),

    PRIMARY KEY (IdAgente, IdArchivo),
    FOREIGN KEY (IdAgente) REFERENCES Agente(IdAgente),
    FOREIGN KEY (IdArchivo) REFERENCES Archivo(IdArchivo)
);

CREATE TABLE AgenteTool
(
    IdAgente INT NOT NULL,
    IdTool INT NOT NULL,
    FechaAsignacion DATETIME NOT NULL DEFAULT GETDATE(),

    PRIMARY KEY (IdAgente, IdTool),
    FOREIGN KEY (IdAgente) REFERENCES Agente(IdAgente),
    FOREIGN KEY (IdTool) REFERENCES Tool(IdTool)
);

CREATE TABLE AgenteHistorial
(
    IdHistorial INT PRIMARY KEY IDENTITY(1,1),
    IdAgente INT NOT NULL,
    InstruccionAnterior NVARCHAR(MAX),
    FechaModificacion DATETIME DEFAULT GETDATE(),

    FOREIGN KEY (IdAgente) REFERENCES Agente(IdAgente)
);

CREATE TABLE MongoDB_ChatHistorial
(
    IdChat INT NOT NULL,
    External_id NVARCHAR(24) NOT NULL,
    BaseDatos NVARCHAR(20) DEFAULT 'SistemaIA',
    Coleccion NVARCHAR(20) DEFAULT 'ChatHistorial',
    UltimaSincronizacion DATETIME DEFAULT GETDATE(),

    PRIMARY KEY (IdChat, External_id),
    FOREIGN KEY (IdChat) REFERENCES Chat(IdChat)
);

GO