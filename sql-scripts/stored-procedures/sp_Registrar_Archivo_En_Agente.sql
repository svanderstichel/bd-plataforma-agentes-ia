--sp_Registrar_Archivo_En_Agente



--6)Insertar un nuevo registro en AgenteArchivo con la fecha actual (GETDATE()).

--7)Confirmar la inserción mostrando un mensaje que indique el éxito de la operación y, opcionalmente, el número de filas afectadas.

--8)Probar el procedimiento con tres casos: agente válido de tipo 'A', agente inválido de tipo 'S', y combinación duplicada.

--9)Verificar que los mensajes de error sean claros y que la integridad de los datos se mantenga.
USE SistemaIA;
GO
CREATE OR ALTER PROCEDURE sp_Registrar_Archivo_En_Agente(
    @IdAgente INT,
    @IdArchivo INT)
AS
BEGIN
    --Definicion de los parámetros de entrada: @‌IdAgente y @‌IdArchivo.
    DECLARE @IdAgenteVerificacion INT;
    DECLARE @AgenteTipo CHAR;
    DECLARE @IdArchivoVerificacion INT;
    DECLARE @AgenteDuplicado INT;
    DECLARE @ArchivoDuplicado INT

    SELECT @IdAgenteVerificacion = IdAgente, @AgenteTipo = Tipo
    FROM Agente
    WHERE IdAgente = @IdAgente;

    SET @IdArchivoVerificacion = (SELECT IdArchivo
    FROM Archivo
    WHERE IdArchivo = @IdArchivo);


    SELECT @AgenteDuplicado = IdAgente, @ArchivoDuplicado = IdArchivo
    FROM AgenteArchivo
    WHERE IdAgente = @IdAgente AND IdArchivo = @IdArchivo;

    --Validacion de existencia de agente en la tabla Agente.
    IF (@IdAgenteVerificacion IS NULL )
    BEGIN
        RAISERROR('ERROR, No existe el Agente ingresado.',16,1);
        RETURN;
    END

    --Validacion de tipo de agente 'A'. Si es 'S', abortar la ejecución y mostrar un mensaje de error indicando que los agentes simples no pueden tener archivos asociados.

    IF ( @AgenteTipo NOT LIKE 'A' )
    BEGIN
        RAISERROR('ERROR. Los agentes simples no pueden tener archivos asociados.',16,1);
        RETURN;
    END

    --Validacion de existencia de archivo en la tabla Archivo.
    IF( @IdArchivoVerificacion IS NULL )
    BEGIN
        RAISERROR('Error.No existe registro del archivo ingresado.',16,1);
        RETURN;
    END

    --Verificar que no exista un registro duplicado en AgenteArchivo para la misma combinación de IdAgente e IdArchivo.
    IF( @AgenteDuplicado IS NOT NULL OR @ArchivoDuplicado IS NOT NULL)
    BEGIN
        RAISERROR('Error.Combinacion IdAgente-IdArchivo duplicada.',16,1);
        RETURN;
    END

    BEGIN TRY
        BEGIN TRANSACTION    
            INSERT INTO AgenteArchivo
        (IdAgente,IdArchivo,FechaAsignacion)
    VALUES
        (@IdAgente, @IdArchivo, GETDATE());
            PRINT ('Operacion exitosa.');
        COMMIT TRANSACTION
    END TRY      
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
        ROLLBACK TRANSACTION;
        PRINT ('Operacion anulada.');
    END    
    END CATCH
END;

--Test 1: Validacion de existencia de agente en la tabla Agente.
SELECT *
FROM Agente
WHERE IdAgente = 50;
EXEC sp_Registrar_Archivo_En_Agente 50,5;

--Test 2: Validacion de tipo de agente 'A'.
SELECT *
FROM Agente
WHERE IdAgente = 6;
EXEC sp_Registrar_Archivo_En_Agente 6,5;

--Test 3: Validacion de existencia de archivo en la tabla Archivo.
SELECT *
FROM Archivo
WHERE IdArchivo = 50;
EXEC sp_Registrar_Archivo_En_Agente 5,50;

--Test 4: Verificar que no exista un registro duplicado en AgenteArchivo para la misma combinación de IdAgente e IdArchivo.
SELECT *
FROM AgenteArchivo
WHERE IdAgente = 15 AND IdArchivo = 4;
EXEC sp_Registrar_Archivo_En_Agente 15,4;

--Test 5: Ingreso de nuevo registro en tabla AgenteArchivo
SELECT *
FROM AgenteArchivo
WHERE IdAgente = 5 AND IdArchivo = 5;

EXEC sp_Registrar_Archivo_En_Agente 5,5;

SELECT *
FROM AgenteArchivo
WHERE IdAgente = 5 AND IdArchivo = 5;

DELETE FROM AgenteArchivo WHERE IdAgente = 5 AND IdArchivo = 5;



