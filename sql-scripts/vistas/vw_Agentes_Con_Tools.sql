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