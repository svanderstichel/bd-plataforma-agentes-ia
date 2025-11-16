--vw_Agentes_Compartidos
-- Propósito:
-- Generar un reporte de los agentes que han sido compartidos, mostrando con qué usuario se compartió y qué permiso posee.
USE SistemaIA;

GO

CREATE OR ALTER VIEW vw_Agentes_Compartidos
AS
    SELECT
        Ag.IdAgente,
        Ag.IdUsuarioDueno,
        Dueno.Nombre AS UsuarioDueno,
        Compartido.IdUsuarioCompartido,
        CompartidoU.Nombre AS UsuarioCompartido,
        P.Nombre AS Permiso,
        Compartido.FechaAsignacion AS FechaCompartido,
        Ag.Nombre AS NombreAgente,
        Ag.Tipo,
        Ag.Descripcion
    FROM CompartirAgente Compartido
        INNER JOIN Agente Ag ON Ag.IdAgente = Compartido.IdAgente
        INNER JOIN Usuario Dueno ON Ag.IdUsuarioDueno = Dueno.IdUsuario
        INNER JOIN Usuario CompartidoU ON Compartido.IdUsuarioCompartido = CompartidoU.IdUsuario
        INNER JOIN Permiso P ON Compartido.IdPermiso = P.IdPermiso
    WHERE Ag.Activo = 1;
GO

-- test
SELECT *
FROM vw_Agentes_Compartidos;

-- test ver agentes que se compartío como dueño (propietario)
SELECT *
FROM vw_Agentes_Compartidos
WHERE IdUsuarioDueno = 2;

-- test del mismo usuario pero esta vez recibe un agente compartido (lectura)
SELECT *
FROM vw_Agentes_Compartidos
WHERE IdUsuarioCompartido = 2;
