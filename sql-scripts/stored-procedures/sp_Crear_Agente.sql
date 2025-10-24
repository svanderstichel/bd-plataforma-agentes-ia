-- Procedimiento para crear nuevos Agentes

USE SistemaIA;
GO

CREATE PROCEDURE sp_Crear_Agente
	(@IdUsuarioDueno INT,
	@Nombre NVARCHAR(100),
	@Descripcion NVARCHAR(250),
	@Instruccion NVARCHAR(MAX),
	@Tipo CHAR(1))
AS
BEGIN

    DECLARE @AgenteExistente INT;
   
    -- Validar nombre único del agente para el usuario (ignorar mayúsculas/minúsculas)
    SELECT @AgenteExistente = COUNT(*) 
        FROM Agente A 
    WHERE A.IdUsuarioDueno = @IdUsuarioDueno 
        AND TRIM(LOWER(A.Nombre)) = TRIM(LOWER(@Nombre));

    -- Si todo sale bien, insertar el nuevo agente dentro de una transacción
    BEGIN TRY
        BEGIN TRANSACTION CrearAgente

            IF @AgenteExistente = 0
                BEGIN
                    DECLARE @IdAgente INT;
                    INSERT INTO Agente (IdUsuarioDueno, Nombre, Descripcion, Instruccion, Tipo)
                        VALUES (@IdUsuarioDueno, @Nombre, @Descripcion, @Instruccion, @Tipo);
                    
                    SET @IdAgente = SCOPE_IDENTITY();

                    INSERT INTO AgenteTool (IdAgente, IdTool)
                        VALUES(@IdAgente, 1);

                    SELECT @IdAgente AS IdAgenteCreado;
                END
                ELSE
                    BEGIN
                        RAISERROR('Ya existe un agente con ese nombre para este usuario.', 16, 1);
                    END

        COMMIT TRANSACTION CrearAgente;

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION CrearAgente;
        DECLARE @mensaje NVARCHAR(4000), @severidad INT, @estado INT;
        SELECT @mensaje = ERROR_MESSAGE(),
            @severidad = ERROR_SEVERITY(),
            @estado = ERROR_STATE();
        RAISERROR(@mensaje, @severidad, @estado);
    END CATCH

END;


GO

-- Test 1: Crear agente con un nombre duplicado
EXEC sp_Crear_Agente @IdUsuarioDueno = 1, 
@Nombre = 'Asistente Contable', 
@Descripcion = 'Un asistente contable',
@Instruccion = 'Eres un asistente contable experto en contabilidad.',
@Tipo = 'S';


-- Test 2: Crear agente con datos válidos - Tipo simple
EXEC sp_Crear_Agente @IdUsuarioDueno = 1, 
@Nombre = 'Tutor .NET', 
@Descripcion = 'Tutor experto en el ecosistema .NET',
@Instruccion = 'Eres un asistente experto en el ecosistema .NET. Tu tarea es enseñar.',
@Tipo = 'S';


-- Test 3: Crear agente con datos válidos - Tipo Avanzado
EXEC sp_Crear_Agente @IdUsuarioDueno = 1, 
@Nombre = 'Agente Nomenclatura Médica', 
@Descripcion = 'Experto en nomenclatura médica',
@Instruccion = 'Eres un asistente experto en nomenclatura médica.',
@Tipo = 'A';

