-- Vista para visualizar los agentes y sus archivos.

USE SistemaIA;

GO

CREATE OR ALTER VIEW vw_Agentes_Con_Archivos
AS
SELECT
    A.IdAgente,
    A.IdUsuarioDueno,
    U.Nombre AS UsuarioDueno,
    A.Nombre AS NombreAgente,
    A.Tipo AS TipoAgente,
    F.IdArchivo,
    F.Nombre AS NombreArchivo,
    AA.FechaAsignacion
FROM Agente AS A
    INNER JOIN Usuario U ON A.IdUsuarioDueno = U.IdUsuario
    INNER JOIN AgenteArchivo AS AA ON A.IdAgente = AA.IdAgente
    INNER JOIN Archivo AS F ON AA.IdArchivo = F.IdArchivo
WHERE A.Tipo = 'A' AND A.Activo = 1;

GO


/*
-- PRUEBAS:

-- Prueba vista
SELECT *
FROM vw_Agentes_Con_Archivos
ORDER BY NombreAgente, FechaAsignacion;

-- Validación de datos de prueba:

SELECT *
FROM vw_Agentes_Con_Archivos
WHERE NombreAgente LIKE '%Prueba Trigger%';

--  Validación de exclusión: El Agente 14 No debe aparecer.

SELECT *
FROM vw_Agentes_Con_Archivos
WHERE NombreAgente LIKE '%Agente Simple%';
*/


SELECT * 
FROM vw_Agentes_Con_Archivos
WHERE IdUsuarioDueno = 1;

GO