USE SistemaIA;
GO
CREATE OR ALTER TRIGGER trg_LogAgenteHistorial ON Agente AFTER UPDATE
AS 
BEGIN

    --Verificamos si la columna Instruccion no esta dentro del SET
    IF NOT UPDATE(Instruccion)
    BEGIN
        RETURN;
    END

    --Se hace el INSERT solo si las Instrucciones de las tablas
    --deleted e inserted son distintas.
    INSERT INTO AgenteHistorial
        (IdAgente, InstruccionAnterior, FechaModificacion)
    SELECT
        d.IdAgente,
        d.Instruccion,
        GETDATE()
    FROM
        deleted d
        INNER JOIN
        inserted i ON d.IdAgente = i.IdAgente
    WHERE d.Instruccion <> i.Instruccion;

END;
--Test 1: Verificacion de la actualizacion del campo InstruccionAnterior en la tabla AgenteHistorial

--Seleccion de Instruccion actual del Agente con Id = 1. 
SELECT IdAgente, Instruccion
FROM Agente
WHERE IdAgente = 8;

--Se crea una actualizacion de la Instruccion.
UPDATE Agente SET Instruccion = 'Prueba trigger.' 
WHERE IdAgente = 8; 

--Se verifica que se creó un nuevo registro en tabla AgenteHistorial con la Instruccion previa a la actualizacion.
SELECT IdAgente, InstruccionAnterior
FROM AgenteHistorial
WHERE IdAgente = 8;

--Actualizacion de instruccion
SELECT IdAgente, Instruccion
FROM Agente
WHERE IdAgente = 8;

--Test 2: Al ejecutar la accion UPDATE en la cual no contenga al campo Instruccion como campo a actualizar, no se deberá ejecutar dicha accion.Por lo tanto, no se creara un registro nuevo en la tabla AgenteHistorial.   

--Conteo de registros en la tabla AgenteHistorial
SELECT COUNT(*) AS CantRegistrosAgenteHistorial
FROM AgenteHistorial;
--Modificacion de valores en registro de un Agente
SELECT IdAgente, Instruccion
FROM Agente
WHERE IdAgente = 2;

UPDATE Agente SET Nombre = 'Bot de soporte legal', Descripcion = 'Descripcion prueba'
WHERE IdAgente = 2;

SELECT IdAgente, Instruccion
FROM Agente
WHERE IdAgente = 2;
--Conteo de registros en la tabla AgenteHistorial postrerior a la modificacion.
SELECT COUNT(*) AS CantRegistrosAgenteHistorial
FROM AgenteHistorial;
