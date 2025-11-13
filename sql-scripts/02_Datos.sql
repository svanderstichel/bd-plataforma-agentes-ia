USE SistemaIA;
GO

INSERT INTO Usuario (Nombre, Email, Contrasena, FechaCreacion, FechaUltimaConexion, Activo)
VALUES
    ('Julian Mondillo', 'julian.mondillo@example.com', 'Julian01-55', '2024-06-10', '2025-11-01', 1),
    ('Sofia Gomez', 'sofia.gomez@example.com', 'SofiGomez33_', '2024-11-20', '2025-11-01', 1),
    ('Valeria Torres', 'valeria.torres@example.com', 'ValeT22-', '2025-02-10', '2025-11-01', 1);

GO

INSERT INTO TipoArchivo (Nombre, Descripcion)
VALUES
    ('PDF', 'Documento portátil'),
    ('CSV', 'Archivo de datos tabulares'),
    ('XLSX', 'Hoja de cálculo Excel'),
    ('JPG', 'Archivo de imagen');

GO

-- P = Predeterminadas (nativas del sistema) / E = Especializadas (para propósitos concretos)
INSERT INTO Tool (Nombre, Descripcion, Tipo)
VALUES
    ('Python', 'Herramienta predeterminada para scripts y análisis de datos.', 'P'),
    ('Web Scraper', 'Extrae información de sitios web.', 'P'),
    ('CV Analyzer', 'Analiza currículums y genera perfiles.', 'E'),
    ('Sentiment Analyzer', 'Evalúa tono y sentimiento de textos.', 'E');
GO

INSERT INTO Agente (IdUsuarioDueno, Nombre, Descripcion, Instruccion, Tipo, FechaCreacion, FechaUltimaModificacion, Activo)
VALUES
    (1, 'Asistente Contable', 'Prepara balances y reportes.', 'Analiza archivos financieros CSV y XLSX.', 'A', '2025-09-01', '2025-11-01', 1),
    (1, 'Bot de Ventas', 'Responde consultas de ventas.', 'Accede a reportes internos.', 'S', '2025-09-05', '2025-11-01', 1),
    (1, 'Generador de Contratos', 'Crea modelos de contrato base.', 'Usa plantillas PDF.', 'A', '2025-09-10', '2025-11-01', 1),
    (2, 'Asistente de Soporte', 'Resuelve tickets simples.', 'Ayuda con preguntas frecuentes.', 'S', '2025-09-02', '2025-11-01', 1),
    (2, 'Analista de Documentos', 'Lee y resume PDFs.', 'Procesa archivos PDF y DOCX.', 'A', '2025-09-12', '2025-11-01', 1),
    (2, 'Bot de Entrenamiento', 'Da feedback a nuevos empleados.', 'Usa mensajes predefinidos.', 'S', '2025-09-20', '2025-11-01', 1),
    (3, 'Agente Legal', 'Revisa cláusulas contractuales.', 'Analiza texto legal.', 'A', '2025-09-03', '2025-11-01', 1),
    (3, 'Asistente de Imagen', 'Gestiona archivos visuales.', 'Clasifica imágenes JPG.', 'S', '2025-09-08', '2025-11-01', 1),
    (3, 'Gestor de Comunicaciones', 'Supervisa correos y reportes.', 'Evalúa tono de respuesta.', 'A', '2025-09-15', '2025-11-01', 1);

GO

INSERT INTO Archivo (IdUsuarioDueno, IdTipoArchivo, Nombre, FechaSubida, Peso, Ruta)
VALUES
    (1, 2, 'Ventas_Q3_2025.csv', '2025-10-15', 120000, 'C:/Empresa/Ventas/Ventas_Q3_2025.csv'),
    (1, 3, 'Balance_Anual_2024.xlsx', '2025-10-10', 180000, 'C:/Empresa/Finanzas/Balance_Anual_2024.xlsx'),
    (2, 1, 'Manual_Usuario.pdf', '2025-10-12', 500000, 'C:/Docs/Manual_Usuario.pdf'),
    (3, 4, 'Logo_Proyecto.jpg', '2025-10-18', 95000, 'C:/Imagenes/Logo_Proyecto.jpg'),
    (3, 1, 'Politica_Privacidad.pdf', '2025-10-20', 300000, 'C:/Legal/Politica_Privacidad.pdf');

GO

INSERT INTO Chat (IdAgente, IdUsuario, FechaCreacion)
VALUES
    (1, 1, '2025-10-25 10:00:00'),
    (1, 1, '2025-10-26 11:00:00'),
    (2, 1, '2025-10-27 09:00:00'),
    (3, 1, '2025-10-28 15:00:00'),
    (3, 1, '2025-10-29 16:30:00'),
    (4, 2, '2025-10-25 09:30:00'),
    (5, 2, '2025-10-26 14:00:00'),
    (5, 2, '2025-10-27 14:30:00'),
    (6, 2, '2025-10-28 10:00:00'),
    (7, 3, '2025-10-25 13:00:00'),
    (8, 3, '2025-10-26 09:00:00'),
    (9, 3, '2025-10-27 11:00:00'),
    (9, 3, '2025-10-28 12:15:00');

GO

INSERT INTO MongoDB_ChatHistorial (IdChat, External_id)
VALUES
    (1, '654a12f8b32c7f9d2a4b9f00'),
    (2, '654a12f8b32c7f9d2a4b9f01'),
    (3, '654a12f8b32c7f9d2a4b9f02'),
    (4, '654a12f8b32c7f9d2a4b9f03'),
    (5, '654a12f8b32c7f9d2a4b9f04'),
    (6, '654a12f8b32c7f9d2a4b9f05'),
    (7, '654a12f8b32c7f9d2a4b9f06'),
    (8, '654a12f8b32c7f9d2a4b9f07'),
    (9, '654a12f8b32c7f9d2a4b9f08'),
    (10, '654a12f8b32c7f9d2a4b9f09'),
    (11, '654a12f8b32c7f9d2a4b9f10'),
    (12, '654a12f8b32c7f9d2a4b9f11'),
    (13, '654a12f8b32c7f9d2a4b9f12');

GO

-- El adminitrador de la base de datos define los tipos de permisos posibles para compartir agentes
INSERT INTO Permiso (IdPermiso, Nombre, Descripcion)
VALUES
    (1, 'Propietario', 'Permite control total sobre el agente.'),
    (2, 'Lectura', 'Permite interactuar con el agente sin modificarlo.');

GO

INSERT INTO CompartirAgente
    (IdAgente, IdUsuarioCompartido, IdPermiso, FechaAsignacion)
VALUES
    (1, 2, 2, '2025-10-30'),
    (3, 3, 2, '2025-10-30'),
    (5, 1, 2, '2025-10-31'),
    (7, 1, 2, '2025-10-31'),
    (9, 2, 2, '2025-10-31');

GO

INSERT INTO AgenteArchivo
    (IdAgente, IdArchivo, FechaAsignacion)
VALUES
    (1, 1, '2025-10-01 10:30:00'),
    (1, 2, '2025-10-15 10:15:00'),
    (3, 2, '2025-08-05 14:00:00'),
    (5, 3, '2025-08-01 11:00:00'),
    (7, 5, GETDATE()),
    (9, 4, GETDATE());

GO

INSERT INTO AgenteTool (IdAgente, IdTool)
VALUES
    (1, 1), (1, 2),
    (2, 1),
    (3, 1), (3, 3),
    (4, 1),
    (5, 1), (5, 4),
    (6, 1),
    (7, 1), (7, 3),
    (8, 1),
    (9, 1), (9, 4);

GO

INSERT INTO AgenteHistorial
    (IdAgente, InstruccionAnterior, FechaModificacion)
VALUES
    (1, 'Analizaba archivos XLSX y devolvía promedios antes de la modificación.', '2025-10-20'),
    (3, 'Versión previa sin cláusula de confidencialidad.', '2025-10-22'),
    (5, 'Extraía solo metadatos del PDF, sin resumen textual.', '2025-10-24'),
    (7, 'Instrucción original antes de incluir revisión de párrafos legales.', '2025-10-25'),
    (9, 'Analizaba tono general antes de incluir clasificación de sentimiento.', '2025-10-26');

GO



SELECT *
FROM Usuario;
SELECT *
FROM TipoArchivo;
SELECT *
FROM Tool;
SELECT *
FROM Agente
WHERE Activo = 0;
SELECT *
FROM Archivo;
SELECT *
FROM Chat;
SELECT *
FROM Permiso;
SELECT *
FROM CompartirAgente;
SELECT *
FROM AgenteArchivo;
SELECT *
FROM AgenteTool;
SELECT *
FROM MongoDB_ChatHistorial;
SELECT *
FROM AgenteHistorial;

GO
---------------------------------------------------
--  INSERTS  PARA PRUEBAS.

-- Dato para probar duplicado en sp_Crear_Agente
INSERT INTO Agente
    (IdUsuarioDueno, Nombre, Descripcion, Instruccion, Tipo, FechaCreacion, FechaUltimaModificacion, Activo)
VALUES
    (2, 'Bot de Marketing', 'Analiza campañas de marketing', 'bot que analiza KPIs', 'A', '2025-10-25 10:00:00', '2025-10-25 10:00:00', 1);
GO

-- Dato para probar exclusión de Agente Inactivo (ID 12) en vistas
INSERT INTO Agente
    (IdUsuarioDueno, Nombre, Descripcion, Instruccion, Tipo, FechaCreacion, FechaUltimaModificacion, Activo)
VALUES
    (4, 'Agente Inactivo (Prueba Vistas)', 'Agente para testear filtros Activo=0', 'Instruccion', 'S', '2025-10-25 11:00:00', '2025-10-25 11:00:00', 0);
GO

-- Datos para probar shares múltiples en vw_Agentes_Compartidos
INSERT INTO CompartirAgente
    (IdAgente, IdUsuarioCompartido, IdPermiso, FechaAsignacion)
VALUES
    (4, 1, 2, '2025-10-25 13:00:00'),
    -- Agente 4 (de Sofia) compartido con Julian
    (4, 6, 2, '2025-10-25 13:01:00'); -- Agente 4 (de Sofia) compartido con Valeria
GO

-- Dato para probar Agente Activo sin Tools en vw_Agentes_Con_Tools
INSERT INTO Agente
    (IdUsuarioDueno, Nombre, Descripcion, Instruccion, Tipo, FechaCreacion, FechaUltimaModificacion, Activo)
VALUES
    (5, 'Agente Sin Herramientas', 'Agente para probar INNER JOIN', 'Instruccion', 'S', '2025-10-25 14:00:00', '2025-10-25 14:00:00', 1);
GO

-- Dato para probar fallo de Trigger en Agente Simple
INSERT INTO Agente
    (IdUsuarioDueno, Nombre, Descripcion, Instruccion, Tipo, FechaCreacion, FechaUltimaModificacion, Activo)
VALUES
    (6, 'Agente Simple (Prueba Trigger)', 'Agente tipo S para validar trigger', 'Instruccion', 'S', '2025-10-25 15:00:00', '2025-10-25 15:00:00', 1);
GO

-- Dato para probar éxito de Trigger en Agente Avanzado
INSERT INTO Agente
    (IdUsuarioDueno, Nombre, Descripcion, Instruccion, Tipo, FechaCreacion, FechaUltimaModificacion, Activo)
VALUES
    (1, 'Agente Avanzado (Prueba Trigger)', 'Agente tipo A para validar trigger', 'Instruccion', 'A', '2025-10-25 16:00:00', '2025-10-25 16:00:00', 1);
GO

-- Dato para probar éxito de Trigger (asignación a ID 15)
INSERT INTO AgenteArchivo
    (IdAgente, IdArchivo, FechaAsignacion)
VALUES
    (15, 4, '2025-10-25 16:01:00');
GO