USE SistemaIA;
GO

INSERT INTO Usuario
    (Nombre, Email, Contrasena, FechaCreacion, FechaUltimaConexion, Activo)
VALUES
    ('Julian Mondillo', 'juli.mondi@hotmail.com', 'Julian01-55', '2024-06-10 10:00:00', '2025-10-20 14:30:00', 1),
    ('Sofia Gomez', 'sofiagomez@hotmail.com', 'sOfiGomez33_', '2024-11-20 15:30:00', '2025-10-15 09:15:00', 1),
    ('Juan Lopez', 'juancito_lopez@gmail.com', 'BocaYoTeAmo123', '2025-05-01 18:00:00', '2025-05-01 18:00:00', 0),
    ('Florencia Perez', 'flor_perez@hotmail.com', 'Florperez11-', '2025-01-05 08:30:00', '2025-02-10 11:00:00', 1),
    ('Ricardo Castro', 'ricardo.castro@gmail.com', 'Richard112895215', '2023-12-01 20:00:00', '2024-06-15 12:00:00', 1),
    ('Valeria Torres', 'vale_torres@hotmail.com', 'Maipu2255', '2025-03-10 14:00:00', '2025-09-01 17:00:00', 1);

INSERT INTO TipoArchivo
    (Nombre, Descripcion)
VALUES
    ('PDF', 'Documento portatil.'),
    ('CSV', 'Datos tabulares.'),
    ('JPG', 'Archivo de imagen.'),
    ('DOCX', 'Documento Word.'),
    ('XLSX', 'Hoja de calculo Excel.');

-- P = Predeterminadas (nativas del sistema) / E = Especializadas (para propósitos concretos)
INSERT INTO Tool
    (Nombre, Descripcion, Tipo)
VALUES
    ('Python', 'Permite el análisis de Excel, cálculos complejos y automatizaciones con scripts.', 'P'),
    ('Image Vision', 'Procesa y analiza imágenes, permitiendo leer texto o detectar elementos visuales.', 'P'),
    ('Audio to Text', 'Convierte audios en texto mediante reconocimiento de voz.', 'P'),
    ('Video to Audio/Text', 'Extrae audio o genera transcripciones a partir de videos.', 'P'),
    ('Scrapping y Búsqueda Web', 'Automatiza búsquedas y extracción de información desde la web.', 'P'),
    ('Code Generator', 'Genera fragmentos de código o scripts a partir de descripciones naturales.', 'E'),
    ('CV Analyzer', 'Analiza currículums y detecta coincidencias con perfiles buscados.', 'E'),
    ('Sentiment Classifier', 'Evalúa el tono emocional o la intención de textos y respuestas.', 'E'),
    ('Financial Forecaster', 'Realiza proyecciones financieras usando modelos entrenados.', 'E'),
    ('Medical Data Extractor', 'Extrae información estructurada desde informes o registros médicos.', 'E');

INSERT INTO Agente
    (IdUsuarioDueno, Nombre, Descripcion, Instruccion, Tipo, FechaCreacion, FechaUltimaModificacion, Activo)
VALUES
    (1, 'Asistente Contable', 'Prepara balances e informes.', 'Sigue la normativa contable.', 'A', '2025-05-15 11:30:00', '2025-10-15 10:00:00', 1),
    (1, 'Generador de Titulos', 'Redacta asuntos de email.', 'Usa un tono atractivo.', 'S', '2025-06-25 09:00:00', '2025-10-20 14:00:00', 1),
    (2, 'Bot de Soporte Nivel 1', 'Responde FAQs.', 'Se siempre formal.', 'S', '2024-12-01 17:00:00', '2025-05-01 12:00:00', 1),
    (2, 'Agente de Automatizacion CRM', 'Actualiza contactos automaticamente.', 'Procesa datos solo si estan completos.', 'S', '2025-01-10 08:00:00', '2025-10-22 09:00:00', 1),
    (4, 'Asistente de Presentaciones', 'Crea borradores de slides.', 'Manten la estructura limpia.', 'A', '2025-03-20 14:00:00', '2025-09-01 16:00:00', 1),
    (5, 'Agente Legal', 'Revisa contratos.', 'Identifica clausulas de riesgo.', 'S', '2024-08-01 10:00:00', '2025-10-10 08:00:00', 0),
    (6, 'Bot de Soporte Nivel 2', 'Escala tickets dificiles.', 'Proporciona contexto completo.', 'A', '2025-07-01 11:00:00', '2025-10-21 11:00:00', 1),
    (6, 'Agente de Integracion API', 'Mueve datos entre sistemas.', 'Asegura la trazabilidad.', 'S', '2025-07-05 13:00:00', '2025-10-22 13:00:00', 1),
    (1, 'Agente Financiero', 'Calcula proyecciones.', 'Usa tasa de descuento del 10%.', 'A', '2025-08-20 15:00:00', '2025-10-22 14:00:00', 1),
    (2, 'Agente de Archivo', 'Clasifica documentos viejos.', 'Usa el tipo de archivo como tag.', 'S', '2025-09-01 16:00:00', '2025-10-22 15:00:00', 1);

INSERT INTO Archivo
    (IdUsuarioDueno, IdTipoArchivo, Nombre, FechaSubida, Peso, Ruta)
VALUES
    (1, 1, 'Estatuto_Social_SRL.pdf', '2025-09-05 16:35:00', 5200000, 'C:/Archivos/Legales/Estatuto_Social_SRL.pdf'),
    (1, 2, 'Datos_Ventas_2024.csv', '2025-10-15 10:10:00', 120000, 'https://s3.amazonaws.com/empresa-datos/ventas/Datos_Ventas_2024.csv'),
    (2, 3, 'Recibo_Sueldo_Sept.jpg', '2024-12-25 14:50:00', 85000, 'C:/Usuarios/Sofia/Recibos/Recibo_Sueldo_Sept.jpg'),
    (4, 1, 'Certificado_Vigencia.pdf', '2025-01-30 08:05:00', 3100000, 'https://s3.amazonaws.com/legales/documentos/Certificado_Vigencia.pdf'),
    (5, 4, 'Borrador_Contrato.docx', '2024-03-01 11:00:00', 45000, 'C:/Contratos/Borradores/Borrador_Contrato.docx'),
    (5, 5, 'Proyeccion_2025.xlsx', '2024-07-20 09:00:00', 800000, 'https://s3.amazonaws.com/finanzas/Proyeccion_2025.xlsx'),
    (6, 1, 'Manual_Cliente.pdf', '2025-05-10 13:00:00', 6500000, 'C:/Clientes/Documentacion/Manual_Cliente.pdf'),
    (1, 2, 'Leads_Agosto.csv', '2025-08-01 10:00:00', 250000, 'https://s3.amazonaws.com/marketing/leads/Leads_Agosto.csv'),
    (2, 3, 'Logo_Empresa.jpg', '2025-09-01 15:00:00', 150000, 'C:/Imagenes/Logo_Empresa.jpg'),
    (4, 4, 'Informe_Tecnico.docx', '2025-10-20 11:00:00', 78000, 'https://s3.amazonaws.com/tecnica/informes/Informe_Tecnico.docx');

INSERT INTO Chat
    (IdAgente, IdUsuario, FechaCreacion)
VALUES
    (1, 1, '2025-10-20 14:40:00'),
    (3, 2, '2025-10-21 09:20:00'),
    (7, 6, '2025-10-22 11:00:00'),
    (9, 1, '2025-10-22 14:05:00'),
    (4, 4, '2025-10-20 10:10:00');

INSERT INTO MongoDB_ChatHistorial
    (IdChat, External_id)
VALUES
    (1, '654a12f8b32c7f9d2a4b9f00'),
    (2, '655b7a8c1d3e4f5a6b7c8d90'),
    (3, '656c8b9d2e4f6a7b8c9d0e11'),
    (4, '657d9c0e3f5a7b8c9d0e1f22'),
    (5, '657d9c0e3f5a7b8te23f4f22');

-- El adminitrador de la base de datos define los tipos de permisos posibles para compartir agentes
INSERT INTO Permiso
    (IdPermiso, Nombre, Descripcion)
VALUES
    (1, 'Propietario', 'Este permiso otorga control total sobre el agente, pudiendo modificar sus instrucciones, tools y archivos.'),
    (2, 'Lectura', 'Este permiso otorga permiso solo de lectura con el agente, lo que permite establecer nuevas sesiones de chat');
GO

INSERT INTO CompartirAgente
    (IdAgente, IdUsuarioCompartido, IdPermiso, FechaAsignacion)
VALUES
    (1, 2, 2, '2025-09-01 10:00:00'),
    (1, 3, 2, '2025-09-10 11:30:00'),
    (2, 4, 2, '2025-10-01 15:45:00'),
    (6, 1, 2, '2025-08-05 09:00:00'),
    (7, 5, 2, '2025-07-05 13:00:00');

INSERT INTO AgenteArchivo
    (IdAgente, IdArchivo, FechaAsignacion)
VALUES
    (1, 1, '2025-10-01 10:30:00'),
    (1, 2, '2025-10-15 10:15:00'),
    (4, 8, '2025-08-05 14:00:00'),
    (6, 5, '2025-08-01 11:00:00'),
    (9, 6, '2025-08-20 15:05:00');

INSERT INTO AgenteTool
    (IdAgente, IdTool, FechaAsignacion)
VALUES
    (1, 2, '2025-09-01 09:30:00'),
    (3, 1, '2025-08-15 14:00:00'),
    (8, 3, '2025-09-05 10:00:00'),
    (9, 5, '2025-09-10 13:00:00'),
    (6, 4, '2025-08-01 12:00:00');

INSERT INTO AgenteHistorial
    (IdAgente, InstruccionAnterior, FechaModificacion)
VALUES
    (1, 'Leer el archivo "Ventas_2025.csv" y calcular el total de ventas por mes.', '2025-11-02T09:00:00'),
    (2, 'Resumir el documento PDF "Informe_Clientes.pdf" extrayendo los puntos clave.', '2025-11-02T10:15:00'),
    (3, 'Combinar los archivos Excel "Stock_Producto.xlsx" y "Pedidos_Clientes.xlsx" para generar reporte consolidado.', '2025-11-02T11:30:00'),
    (4, 'Extraer los correos electrónicos del archivo de texto "Contactos.txt" y guardarlos en una lista filtrada.', '2025-11-02T12:45:00'),
    (5, 'Analizar el archivo JSON "Transacciones.json" para calcular estadísticas de ventas por categoría.', '2025-11-02T14:00:00');



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

