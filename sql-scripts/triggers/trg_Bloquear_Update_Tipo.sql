USE SistemaIA;

GO

-- Trigger para bloquear el cambio de tipo de un agente Avanzado a Simple si es que el agente tiene archivos asociados.
CREATE TRIGGER trg_Bloquear_Update_Tipo
ON Agente
INSTEAD OF UPDATE
AS
BEGIN
	DECLARE @IdAgente INT;
	DECLARE @TipoAnterior CHAR(1);
	DECLARE @TipoNuevo CHAR(1);
	DECLARE @TieneArchivos INT;

	SELECT 
		@IdAgente = i.IdAgente,
		@TipoAnterior = d.Tipo,
		@TipoNuevo = i.Tipo
	FROM inserted i
		INNER JOIN deleted d ON i.IdAgente = d.IdAgente;

	-- validar si hay archivos relacionados
	SELECT @TieneArchivos = COUNT(*)
	FROM AgenteArchivo AA
	WHERE AA.IdAgente = @IdAgente;

	-- si tiene archivos no permitir el cambio
	IF (@TipoAnterior = 'A' AND @TipoNuevo = 'S' AND @TieneArchivos > 0)
		BEGIN
			RAISERROR('No se puede cambiar el tipo de Agente de Avanzado a Simple mientras tenga archivos asociados.', 16, 1);
			ROLLBACK TRANSACTION;
			RETURN;
		END
	ELSE
		BEGIN
			 -- Si no hay problema, entonces realizar la actualización.
			UPDATE Agente
				SET IdUsuarioDueno = i.IdUsuarioDueno,
					Nombre = i.Nombre,
					Descripcion = i.Descripcion,
					Instruccion = i.Instruccion,
					Tipo = i.Tipo,
					FechaUltimaModificacion = GETDATE(),
					Activo = i.Activo
			FROM inserted i
			WHERE Agente.IdAgente = i.IdAgente;
		END
END;



-- Tests
SELECT 
    A.IdAgente,
    A.Nombre AS NombreAgente,
	A.Descripcion,
    A.Tipo,
    COUNT(AA.IdArchivo) AS TotalArchivos
FROM Agente A
LEFT JOIN AgenteArchivo AA ON A.IdAgente = AA.IdAgente
GROUP BY A.IdAgente, A.Nombre, A.Tipo, A.Descripcion
ORDER BY A.Tipo ASC;


-- Test 1. Intentar cabiar Agente Avanzado con archivos a simple: debe fallar
 UPDATE Agente
    SET Tipo = 'S'
WHERE IdAgente = 1;


-- Test 2. Cambiar avanzado sin archivos a simple: Debe permitir
UPDATE Agente
    SET Tipo = 'S'
WHERE IdAgente = 9;

-- Test 3. Cambio simple a avanzado: permitido
UPDATE Agente
    SET Tipo = 'A'
WHERE IdAgente = 9;


-- Test 4. Actualizar otros campos para validar que se pueda correctamente
 UPDATE Agente
    SET Descripcion = 'Prepara balances, informes y proyecciones anuales.'
WHERE IdAgente = 1;