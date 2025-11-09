USE SistemaIA;
GO
CREATE OR ALTER PROCEDURE sp_Desactivar_Agente
    (@IdAgente INT)
AS
BEGIN

    DECLARE @IdAgenteExistente INT;
    DECLARE @IdAgenteActivo BIT;

    SELECT @IdAgenteExistente = IdAgente, @IdAgenteActivo = Activo
    FROM Agente
    WHERE @IdAgente = IdAgente;

    --Verificacion de existencia de Agente en tabla Agente.
    IF ( @IdAgenteExistente IS NULL )
    BEGIN
        RAISERROR('Error. No hay registros para el Agente solicitado.',16,1);
        RETURN;
    END;

    --Verificacion de estado del Agente.
    IF (@IdAgenteActivo = 0)
    BEGIN
        RAISERROR('Error.El Agente ya se encuentra inactivo.',16,1);
        RETURN;
    END;

    UPDATE Agente SET Activo = 0, FechaUltimaModificacion = GETDATE() WHERE IdAgente = @IdAgente;
    PRINT ('El Agente ha sido desactivado correctamente.');

END;

GO

EXEC sp_Crear_Agente 1,'Prueba','Descripcion Prueba','Instruccion Prueba','A'

--Test 1:Agente activo válido. Debe desactivarse correctamente.
SELECT IdAgente, Activo
FROM Agente
WHERE Activo = 1;

EXEC sp_Desactivar_Agente 18;

--Test 2: Agente ya inactivo.Mostrar mensaje de error.
SELECT IdAgente, Activo
FROM Agente
WHERE Activo = 0;

EXEC sp_Desactivar_Agente 18;

--Test 3: IdAgente inexistente. Mostrar mensaje de error.
SELECT IdAgente
FROM Agente;

EXEC sp_Desactivar_Agente 19;
