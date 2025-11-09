-- USE DATABASE
USE SistemaIA;
GO

-- CREATE TRIGGER AFTER DELETE
CREATE OR ALTER TRIGGER trg_Bloquear_Delete_Agente
ON Agente
INSTEAD OF DELETE
AS
BEGIN
	DECLARE @FlagCompartido INT;
	SELECT @FlagCompartido = COUNT(*) FROM CompartirAgente WHERE IdAgente IN (SELECT IdAgente FROM deleted);

-- VALIDAR SI LOS AGENTES A ELIMINAR FUERON COMPARTIDOS CON OTROS USUARIOS
	IF @FlagCompartido > 0
		BEGIN
			RAISERROR('No es posible eliminar un agente que ha sido compartido con otros usuarios.',16,1);
		END
-- CASO CONTRARIO, SE REALIZA BORRADO LÓGICO DE REGISTROS
	ELSE
		BEGIN		
			UPDATE Agente SET Activo = 0 WHERE IdAgente IN (SELECT IdAgente FROM deleted);
		END
END;


-- TEST

-- test1 eliminación de agente válida
DELETE FROM Agente WHERE IdAgente = 9;
SELECT IdAgente, Activo FROM Agente WHERE IdAgente = 9;

-- test2 eliminación de agentes por lote válida 
DELETE FROM Agente WHERE IdAgente IN (10,11,12);
SELECT IdAgente, Activo FROM Agente WHERE IdAgente IN (10,11,12);

-- test3 eliminación de agente inválida
DELETE FROM Agente WHERE IdAgente = 1;
SELECT IdAgente, Activo FROM Agente WHERE IdAgente = 1;

-- test4 eliminación de agentes por lote válida 
DELETE FROM Agente WHERE IdAgente IN (1,13,14);
SELECT IdAgente, Activo FROM Agente WHERE IdAgente IN (1,13,14);




