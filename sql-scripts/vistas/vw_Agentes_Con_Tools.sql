-- La vista vw_Agentes_Con_Tools consolida la información de las tablas `Agente`, `AgenteTool` y `Tool` para presentar un listado claro de los agentes y sus respectivas herramientas. Adicionalmente, solo se incluye en el resultado aquellos agentes cuyo campo es `Activo` en la tabla `Agente`.
USE SistemaIA;
GO
CREATE OR ALTER VIEW vw_Agentes_Con_Tools
AS
    SELECT
        Ag.IdAgente,
        Ag.IdUsuarioDueno,
        U.Nombre AS UsuarioDueno,
        Ag.Nombre AS NombreAgente,
        Ag.Tipo AS TipoAgente,
        T.Nombre AS NombreTool,
        T.Tipo AS TipoTool,
        AgenteTool.FechaAsignacion AS FechaAsignacion
    FROM Agente Ag
        INNER JOIN Usuario U ON Ag.IdUsuarioDueno = U.IdUsuario
        INNER JOIN AgenteTool ON AgenteTool.IdAgente = Ag.IdAgente
        INNER JOIN Tool T ON AgenteTool.IdTool = T.IdTool
    WHERE Ag.Activo = 1;
GO

SELECT *
From vw_Agentes_Con_Tools;

--TEST para un agente desactivado
SELECT IdAgente, Activo
FROM Agente
WHERE Activo = 0;

SELECT IdAgente
From vw_Agentes_Con_Tools;

-- Test para traer solo agentes que tienen herramientas asignadas.

SELECT IdAgente
FROM AgenteTool;
-- Agente sin herrramienta IdAgente = 4
SELECT IdAgente
From vw_Agentes_Con_Tools
WHERE IdAgente = 4;

