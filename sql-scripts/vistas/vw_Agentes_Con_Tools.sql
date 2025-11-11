-- La vista vw_Agentes_Con_Tools consolida la información de las tablas `Agente`, `AgenteTool` y `Tool` para presentar un listado claro de los agentes y sus respectivas herramientas. Adicionalmente, solo se incluye en el resultado aquellos agentes cuyo campo es `Activo` en la tabla `Agente`.
USE SistemaIA;
GO

CREATE VIEW vw_Agentes_Con_Tools
AS
    SELECT A.Nombre AS NombreAgente, A.Tipo AS TipoAgente, T.Nombre AS NombreHerramienta
    FROM Agente A
        INNER JOIN AgenteTool AT ON A.IdAgente = AT.IdAgente
        INNER JOIN Tool T ON T.IdTool = AT.IdTool
    WHERE A.Activo = 1;

    GO
SELECT *
FROM vw_Agentes_Con_Tools;

-- Modificacion en vw_Agentes_Con_Tools
-- Propósito:
-- Mostrar cada agente junto con las herramientas asignadas, tanto predeterminadas como adicionales.
-- Reglas de negocio:
-- Mostrar solo agentes con Activo = 1.
-- Si un agente no tiene herramientas asignadas, no debe aparecer en la vista (solo los que tienen registros en AgenteTool).
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

--TEST para un agente desactivado
SELECT *
FROM AgenteTool;

-- test con usuario
SELECT * 
FROM vw_Agentes_Con_Tools 
WHERE IdUsuarioDueno = 1;

--La cantidad de agentes =! cantidad cantidad de agentes con Tools
GO
SELECT *
FROM vw_Agentes_Con_Tools;
--Debido a que hay agentes desactivados
SELECT *
FROM Agente
WHERE Activo = 0;

