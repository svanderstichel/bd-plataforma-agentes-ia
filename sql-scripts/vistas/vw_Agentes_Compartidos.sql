--vw_Agentes_Compartidos
-- Propósito:
-- Generar un reporte de los agentes que han sido compartidos, mostrando con qué usuario se compartió y qué permiso posee.
USE SistemaIA;
GO
CREATE OR ALTER VIEW vw_Agentes_Compartidos
AS
    SELECT Agente.Nombre AS NombreAgente,
        Dueño.Nombre AS UsuarioDueñoNombre,
        Compartido.Nombre AS UsuarioCompartidoNombre,
        Permiso.Nombre AS Permiso,
        CompartirAgente.FechaAsignacion AS FechaComparticion
    FROM CompartirAgente
        INNER JOIN Agente Agente ON Agente.IdAgente = CompartirAgente.IdAgente
        INNER JOIN Usuario Dueño ON Agente.IdUsuarioDueno = Dueño.IdUsuario
        INNER JOIN Usuario Compartido ON CompartirAgente.IdUsuarioCompartido = Compartido.IdUsuario
        INNER JOIN Permiso ON CompartirAgente.IdPermiso = Permiso.IdPermiso
    WHERE Agente.Activo = 1;
GO
SELECT *
FROM vw_Agentes_Compartidos;