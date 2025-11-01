USE SistemaIA;
GO

CREATE VIEW vw_Agentes_Con_Archivos
AS
SELECT
    A.Nombre AS NombreAgente,
    F.Nombre AS NombreArchivo,
    AA.FechaAsignacion
FROM Agente AS A
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

GO