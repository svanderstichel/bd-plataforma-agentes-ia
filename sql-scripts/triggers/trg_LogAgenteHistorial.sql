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

