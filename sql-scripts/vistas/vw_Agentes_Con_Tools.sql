-- Se debe desarrollar una vista (`VIEW`) en la base de datos con el nombre `vw_Agentes_Con_Tools`. La vista debe consolidar la información de las tablas `Agente`, `AgenteTool` y `Tool` para presentar un listado claro de los agentes y sus respectivas herramientas. Adicionalmente, Se deben incluir en el resultado únicamente aquellos agentes cuyo campo `Activo` en la tabla `Agente`.
USE SistemaIA;
GO

CREATE VIEW vw_Agentes_Con_Tools
AS
    SELECT A.Nombre AS NombreAgente, A.Tipo AS TipoAgente, T.Nombre AS NombreHerramienta
    FROM Agente A
        INNER JOIN AgenteTool AT ON A.IdAgente = AT.IdAgente
        INNER JOIN Tool T ON T.IdTool = AT.IdTool
    WHERE A.Activo = 1;

