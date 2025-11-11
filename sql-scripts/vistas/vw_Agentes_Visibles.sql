-- Vista para listar los agentes de un usuario y aquellos que le han sido compartidos
USE SistemaIA;
GO

CREATE OR ALTER VIEW vw_Agentes_Visibles
AS
SELECT 
    A.IdAgente,
    A.Nombre AS NombreAgente,
    A.Descripcion,
    A.Tipo,
    A.FechaCreacion,
    A.IdUsuarioDueno,
    U.Nombre AS UsuarioDueno,
    CA.IdUsuarioCompartido,
    UC.Nombre AS UsuarioCompartido,
    CA.FechaAsignacion AS FechaComparticion,
    P.Nombre AS Permiso,
    CASE 
        WHEN CA.IdUsuarioCompartido IS NULL THEN 'Propietario'
        ELSE 'Compartido'
    END AS Rol
FROM Agente A
    INNER JOIN Usuario U ON A.IdUsuarioDueno = U.IdUsuario
    LEFT JOIN CompartirAgente CA ON CA.IdAgente = A.IdAgente
    LEFT JOIN Usuario UC ON UC.IdUsuario = CA.IdUsuarioCompartido
    LEFT JOIN Permiso P ON P.IdPermiso = CA.IdPermiso
WHERE A.Activo = 1;

GO


-- Test
SELECT *
    FROM vw_Agentes_Visibles
WHERE IdUsuarioDueno = 1
   OR IdUsuarioCompartido = 1
ORDER BY FechaCreacion, NombreAgente ASC;

 SELECT 
    IdAgente,
    NombreAgente,
    Descripcion,
    Tipo,
    FechaCreacion,
    UsuarioDueno,
    UsuarioCompartido,
    Permiso,
    FechaComparticion,
    Rol
FROM vw_Agentes_Visibles
WHERE IdUsuarioDueno = 1
        OR IdUsuarioCompartido = 1
ORDER BY FechaCreacion, NombreAgente ASC