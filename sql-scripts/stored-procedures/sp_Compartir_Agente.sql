-- Procedimiento para compartir Agentes entre usuarios

USE SistemaIA;
GO

CREATE PROCEDURE sp_Compartir_Agente
	(
	@IdAgente INT,
	@IdUsuarioCompartido INT,
	@IdPermiso INT
	)
AS
BEGIN
	
	DECLARE @IdAgenteEncontrado INT;
	DECLARE @ExisteUsuarioCompartido INT;
	DECLARE @IdUsuarioDueno INT;
	DECLARE @ExistePermiso INT;

	-- verificar que tanto el usuario como el agente existan
	SELECT @IdAgenteEncontrado = IdAgente, 
		   @IdUsuarioDueno = IdUsuarioDueno
		FROM Agente 
	WHERE IdAgente = @IdAgente;

	SELECT @ExisteUsuarioCompartido = COUNT(*) 
		FROM Usuario 
	WHERE IdUsuario = @IdUsuarioCompartido;

	SELECT @ExistePermiso = COUNT(*)
		FROM Permiso
	WHERE IdPermiso = @IdPermiso;

	IF @IdAgenteEncontrado IS NULL
		BEGIN
			RAISERROR('Validación fallida: No existe un registro para el ID de Agente indicado.', 16, 1);
			RETURN;
		END

	IF @ExistePermiso = 0
		BEGIN
			RAISERROR('Validación fallida: No existe un registro para el ID de Permiso indicado.', 16, 1);
			RETURN;
		END
	
	IF @ExisteUsuarioCompartido = 0
		BEGIN
			RAISERROR('Validación fallida: No existe un registro para el ID de Usuario indicado.', 16, 1);
			RETURN;
		END

	-- si ambos existen: verificar que no se autocomparta su propio agente
	IF @IdUsuarioCompartido = @IdUsuarioDueno
		BEGIN
			RAISERROR('Validación fallida: No es posible auto-compartirse un agente.', 16, 1);
			RETURN;
		END
	
	DECLARE @ExisteRegistroCompartido INT;
	
	SELECT @ExisteRegistroCompartido = COUNT(*)
		FROM CompartirAgente
	WHERE IdAgente = @IdAgente
		  AND IdUsuarioCompartido = @IdUsuarioCompartido;

	IF @ExisteRegistroCompartido > 0
		BEGIN
			RAISERROR('Validación fallida: El agente ya ha sido compartido al usuario indicado.', 16, 1);
			RETURN;
		END

	BEGIN TRY
		BEGIN TRANSACTION
			
			INSERT INTO CompartirAgente (IdAgente, IdUsuarioCompartido, IdPermiso)
				VALUES (@IdAgente, @IdUsuarioCompartido,@IdPermiso);
		
		COMMIT TRANSACTION;
	
	END TRY
	BEGIN CATCH
		
		ROLLBACK TRANSACTION;
		DECLARE @mensaje NVARCHAR(4000), @severidad INT, @estado INT;
        SELECT @mensaje = ERROR_MESSAGE(),
            @severidad = ERROR_SEVERITY(),
            @estado = ERROR_STATE();
        RAISERROR(@mensaje, @severidad, @estado);

	END CATCH

END;

GO

SELECT * FROM Usuario;
SELECT * FROM Agente;
SELECT * FROM CompartirAgente ORDER BY FechaAsignacion DESC;
SELECT * FROM Permiso;

-- test 1. Compartir agente válido con permiso válido
EXEC sp_Compartir_Agente 
    @IdAgente = 6, 
    @IdUsuarioCompartido = 1,
	@IdPermiso = 1;

-- test 2. Compartir con su propio dueño con permiso válido
EXEC sp_Compartir_Agente 
    @IdAgente = 1, 
    @IdUsuarioCompartido = 1,
	@IdPermiso = 1;

-- test 3. Compartir agente ya compartido con permiso válido
EXEC sp_Compartir_Agente 
    @IdAgente = 1, 
    @IdUsuarioCompartido = 6,
	@IdPermiso = 2;

-- test 4. Compartir con usuario inexistente con permiso válido
EXEC sp_Compartir_Agente 
    @IdAgente = 1, 
    @IdUsuarioCompartido = 9999,
	@IdPermiso = 2;

-- test 5. Compartir agente inexistente con permiso válido
EXEC sp_Compartir_Agente 
    @IdAgente = 8888, 
    @IdUsuarioCompartido = 2,
	@IdPermiso = 2;


-- test 6. Compartir agente con permiso inexistente
EXEC sp_Compartir_Agente 
    @IdAgente = 1, 
    @IdUsuarioCompartido = 6,
	@IdPermiso = 9999;



SELECT * FROM Agente


select * from Usuario


SELECT * From CompartirAgente

SELECT IdAgente, Nombre, Descripcion, Tipo
    FROM Agente
    WHERE IdUsuarioDueno = 1 
	AND Activo = 1
    ORDER BY Nombre ASC;


SELECT *
    FROM Agente
    LEFT JOIN CompartirAgente ON Agente.IdAgente = CompartirAgente.IdAgente
    WHERE Agente.IdUsuarioDueno = 1 
	AND CompartirAgente.IdUsuarioCompartido = 1
	AND Activo = 1
ORDER BY Nombre ASC;