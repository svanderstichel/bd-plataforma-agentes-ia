-- Se debe desarrollar un trigger (TRIGGER) para la tabla Agente que se active después de una actualización (UPDATE). El trigger deberá registrar el valor anterior de la instrucción en la tabla AgenteHistorial.

USE SistemaIA;
GO
CREATE TRIGGER trg_LogAgenteHistorial ON Agente AFTER UPDATE
AS 

BEGIN

    IF UPDATE(Instruccion) 
    BEGIN
        INSERT INTO AgenteHistorial
            (IdAgente,InstruccionAnterior,FechaModificacion)
        SELECT IdAgente, Instruccion, GETDATE()
        FROM deleted;
    END
END;

--Test 1: Verificacion de la actualizacion del campo InstruccionAnterior en la tabla AgenteHistorial

--Seleccion de Instruccion actual del Agente con Id = 1. 
SELECT IdAgente, Instruccion
FROM Agente
WHERE IdAgente = 1;
--Se crea una actualizacion de la Instruccion.
UPDATE Agente SET Instruccion = 'Leer el archivo "Compras_2023.csv" y calcular el promedio de compras en ese año.' 
WHERE IdAgente = 1; 
--Se verifica que se creó un nuevo registro en tabla AgenteHistorial con la Instruccion previa a la actualizacion.
SELECT IdAgente, InstruccionAnterior
FROM AgenteHistorial
WHERE IdAgente = 1;

--Test 2: Al ejecutar la accion UPDATE en la cual no contenga al campo Instruccion como campo a actualizar, no se deberá ejecutar dicha accion.Por lo tanto, no se creara un registro nuevo en la tabla AgenteHistorial.   

--Conteo de registros en la tabla AgenteHistorial
SELECT COUNT(*) AS CantRegistrosAgenteHistorial
FROM AgenteHistorial;
--Modificacion de valores en registro de un Agente
SELECT *
FROM Agente
WHERE IdAgente = 2;

UPDATE Agente SET Nombre = 'Bot de soporte legal', Descripcion = 'Descripcion prueba', Tipo = 'A'
WHERE IdAgente = 2;

SELECT *
FROM Agente
WHERE IdAgente = 2;
--Conteo de registros en la tabla AgenteHistorial postrerior a la modificacion.
SELECT COUNT(*) AS CantRegistrosAgenteHistorial
FROM AgenteHistorial;
