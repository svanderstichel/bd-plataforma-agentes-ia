USE SistemaIA;

GO

-- Procedimiento almacenado para generar un reporte de actividad de agentes activos
-- se puede pasar como parámetros o no las fechas que se quieren consultar
-- solo es obligatorio el id del dueño.
CREATE PROCEDURE sp_Reporte_Actividad_Agentes
    (@IdUsuarioDueno INT,
     @FechaDesde DATETIME = NULL,
     @FechaHasta DATETIME = NULL)
AS
BEGIN
    SELECT A.IdAgente,
           A.Nombre AS NombreAgente,
           U.Nombre AS NombreUsuarioDueno,
           COUNT(DISTINCT C.IdChat) AS TotalChats,
           MIN(C.FechaCreacion) AS PrimeraActividad,
           MAX(C.FechaCreacion) AS UltimaActividad,
           COUNT(DISTINCT CA.IdUsuarioCompartido) AS TotalUsuariosCompartidos
        FROM Agente A
    INNER JOIN Usuario U 
        ON A.IdUsuarioDueno = U.IdUsuario
    LEFT JOIN Chat C 
        ON A.IdAgente = C.IdAgente
        AND ((@FechaDesde IS NULL OR C.FechaCreacion >= @FechaDesde)
        AND (@FechaHasta IS NULL OR C.FechaCreacion <= @FechaHasta))
    LEFT JOIN CompartirAgente CA 
        ON A.IdAgente = CA.IdAgente
    WHERE A.Activo = 1 
        AND (A.IdUsuarioDueno = @IdUsuarioDueno OR CA.IdUsuarioCompartido = @IdUsuarioDueno)
    GROUP BY 
        A.IdAgente, 
        A.Nombre, 
        U.Nombre
    ORDER BY 
        TotalChats DESC;
END;


SELECT * FROM Agente A 
    INNER JOIN Usuario U ON A.IdUsuarioDueno = U.IdUsuario 
    LEFT JOIN Chat C ON A.IdAgente = C.IdAgente 
    LEFT JOIN CompartirAgente CA ON A.IdAgente = CA.IdAgente

-- Tests
EXEC sp_Reporte_Actividad_Agentes @IdUsuarioDueno = 1;

EXEC sp_Reporte_Actividad_Agentes 
    @IdUsuarioDueno = 1,
    @FechaDesde = '2025-10-01',
    @FechaHasta = '2025-10-31';