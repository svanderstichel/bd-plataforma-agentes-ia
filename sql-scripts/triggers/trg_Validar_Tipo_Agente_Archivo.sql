USE SistemaIA;
GO

-- Limpieza previa de datos de prueba

DELETE FROM AgenteArchivo WHERE IdAgente = 14 AND IdArchivo = 3;
DELETE FROM AgenteArchivo WHERE IdAgente = 15 AND IdArchivo = 3;
GO

-- Actualizar el Trigger

GO
CREATE OR ALTER TRIGGER trg_Validar_Tipo_Agente_Archivo
ON AgenteArchivo
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (
        SELECT 1
        FROM Agente AS A
        JOIN inserted AS i ON A.IdAgente = i.IdAgente
        WHERE RTRIM(A.Tipo) = 'S' 
    )
    BEGIN
        -- Si es 'S', lanza error y cancela
        RAISERROR('Error: Solo Agentes Tipo "A" pueden tener archivos.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO

-- Prueba de Fallo (Agente Simple)

-- este insert tiene que fallar
INSERT INTO AgenteArchivo (IdAgente, IdArchivo, FechaAsignacion)
VALUES (14, 3, GETDATE()); -- Agente Simple (ID 14)
GO

-- Prueba de Éxito (Agente Avanzado)

-- Este insert tiene que funcionar
INSERT INTO AgenteArchivo (IdAgente, IdArchivo, FechaAsignacion)
VALUES (15, 3, GETDATE()); -- Agente Avanzado (ID 15)
GO

-- Verificación y Limpieza

PRINT 'Verificando tabla (Agente 14 no debe estar, Agente 15 debe estar):';
SELECT * FROM AgenteArchivo WHERE IdAgente IN (14, 15);

DELETE FROM AgenteArchivo
WHERE IdAgente = 15 AND IdArchivo = 3;

GO