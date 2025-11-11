-- Procedimiento que permite asociar una herramienta a un agente (NO aplica a la herramienta pro defecto Python)
USE SistemaIA;
GO

CREATE PROCEDURE sp_Asignar_Tool_A_Agente
    (
    @IdAgente INT,
    @IdTool INT
    )
AS
BEGIN

    DECLARE @ExisteAgente INT;
    DECLARE @ExisteTool INT;
    DECLARE @ExisteAsignacion INT;

    SELECT @ExisteAgente = COUNT(*)
    FROM Agente
    WHERE IdAgente = @IdAgente;

    IF @ExisteAgente = 0
    BEGIN
        RAISERROR('Error: El Agente con Id %d no existe.', 16, 1, @IdAgente);
        RETURN;
    END

    SELECT @ExisteTool = COUNT(*)
    FROM Tool
    WHERE IdTool = @IdTool;

    IF @ExisteTool = 0
    BEGIN
        RAISERROR('Error: La Herramienta (Tool) con Id %d no existe.', 16, 1, @IdTool);
        RETURN;
    END

    SELECT @ExisteAsignacion = COUNT(*)
    FROM AgenteTool
    WHERE IdAgente = @IdAgente AND IdTool = @IdTool;

    IF @ExisteAsignacion > 0
    BEGIN
        RAISERROR('Error: El agente ya tiene asignada esta herramienta.', 16, 1);
        RETURN;
    END

    BEGIN TRY
        BEGIN TRANSACTION;
            
            INSERT INTO AgenteTool
                (IdAgente, IdTool)
            VALUES
                (@IdAgente, @IdTool);
        
        COMMIT TRANSACTION;
        
        PRINT 'Herramienta asignada correctamente al agente.';

        SELECT A.Nombre AS NombreAgente, T.Nombre AS NombreHerramienta, AT.FechaAsignacion
        FROM AgenteTool AT
            JOIN Agente A ON AT.IdAgente = A.IdAgente
            JOIN Tool T ON AT.IdTool = T.IdTool
        WHERE AT.IdAgente = @IdAgente AND AT.IdTool = @IdTool;

    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        
        DECLARE @mensaje NVARCHAR(4000), @severidad INT, @estado INT;
        SELECT @mensaje = ERROR_MESSAGE(),
               @severidad = ERROR_SEVERITY(),
               @estado = ERROR_STATE();
        RAISERROR(@mensaje, @severidad, @estado);
    END CATCH

END;
GO


USE SistemaIA;
GO


--- Pruebas 

-- : Válido
EXEC sp_Asignar_Tool_A_Agente @IdAgente = 4, @IdTool = 1;
GO

-- Duplicado
EXEC sp_Asignar_Tool_A_Agente @IdAgente = 1, @IdTool = 2;
GO

-- Agente inexistente
EXEC sp_Asignar_Tool_A_Agente @IdAgente = 9999, @IdTool = 1;
GO

-- Tool inexistente
EXEC sp_Asignar_Tool_A_Agente @IdAgente = 1, @IdTool = 9999;
GO

-- Verificación
SELECT *
FROM AgenteTool
WHERE IdAgente IN (1, 4)
ORDER BY IdAgente, IdTool;
GO

-- Limpieza
DELETE FROM AgenteTool
WHERE IdAgente = 4 AND IdTool = 1;
GO

-- Verificación post-limpieza
SELECT *
FROM AgenteTool
WHERE IdAgente IN (1, 4)
ORDER BY IdAgente, IdTool;
GO