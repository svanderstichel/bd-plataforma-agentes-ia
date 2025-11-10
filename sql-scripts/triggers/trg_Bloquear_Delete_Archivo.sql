USE SistemaIA;
GO

CREATE TRIGGER trg_Bloquear_Delete_Archivo
ON Archivo
INSTEAD OF DELETE
AS
BEGIN
    
    IF EXISTS (SELECT 1 
               FROM AgenteArchivo AS AA
               INNER JOIN deleted AS d ON AA.IdArchivo = d.IdArchivo)
    BEGIN
        
        RAISERROR('Error: No se pueden eliminar archivos que están asociados a un Agente. La operación ha sido cancelada.', 16, 1);

    END
    ELSE
    BEGIN
        
        DELETE A
        FROM Archivo AS A
        INNER JOIN deleted AS d ON A.IdArchivo = d.IdArchivo;
    END
END;
GO


-- TESTEOS
USE SistemaIA;
GO

-- test 1: borrar archivo NO asociado (tieen que funcionar)
BEGIN TRANSACTION;
DELETE FROM Archivo
WHERE IdArchivo = 10;
ROLLBACK TRANSACTION;
GO

-- TEST 2: borrar archivo ASOCIADO (NO tiene que funcionar)
BEGIN TRY
    DELETE FROM Archivo
    WHERE IdArchivo = 1;
END TRY
BEGIN CATCH
    PRINT ERROR_MESSAGE();
END CATCH
GO

-- test 3: borrar lote mixto (no tiene que funcionar)
BEGIN TRY
    DELETE FROM Archivo
    WHERE IdArchivo IN (2, 7);
END TRY
BEGIN CATCH
    PRINT ERROR_MESSAGE();
END CATCH
GO

-- verificación final
SELECT IdArchivo, Nombre 
FROM Archivo 
WHERE IdArchivo IN (1, 2, 7, 10);
GO