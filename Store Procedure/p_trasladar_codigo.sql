USE [CDO02_21]
GO
/****** Object:  StoredProcedure [dbo].[p_trasladar_codigo]    Script Date: 05/01/2022 8:25:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[p_trasladar_codigo]
	  @usuario INT
	, @mto INT
	, @doc_viejo VARCHAR(20)
	, @doc_nuevo VARCHAR(20)
AS BEGIN
	
	-- Registrar log
	DECLARE @id_reg INT
	INSERT INTO asi_log_traslado_codigo
	(usuario, mto, doc_viejo, doc_nuevo, detalle)
	VALUES
	(@usuario, @mto, @doc_viejo, @doc_nuevo, '')
	SET @id_reg = @@IDENTITY
	
	DECLARE @evidencia VARCHAR(MAX) = ''
	DECLARE @oid_viejo INT = (SELECT oid FROM dgempres01..genpacien WHERE pacnumdoc IN (@doc_viejo))
	DECLARE @oid_nuevo INT = (SELECT oid FROM dgempres01..genpacien WHERE pacnumdoc IN (@doc_nuevo))

	IF @oid_viejo IS NOT NULL AND @oid_nuevo IS NOT NULL BEGIN

		SET @evidencia += 'Existen los dos documentos' + CHAR(13) + CHAR(10)
		SET @evidencia += '@oid_viejo:' + CONVERT(VARCHAR, @oid_viejo) + CHAR(13) + CHAR(10)
		SET @evidencia += '@oid_nuevo:' + CONVERT(VARCHAR, @oid_nuevo) + CHAR(13) + CHAR(10)
		--------------EN DGH
		UPDATE dgempres01..ADNINGRESO SET GENPACIEN = @oid_nuevo WHERE GENPACIEN = @oid_viejo
		SET @evidencia += 'ADNINGRESO:' + CONVERT(VARCHAR, @@ROWCOUNT) + CHAR(13) + CHAR(10)
		
		--declare @ciclo int =(select max(HCNUMFOL) from dgempres01..hcnfolio WHERE GENPACIEN=@oid_viejo)
		DECLARE @sumar_nuevo INT =(SELECT MAX(HCNUMFOL) FROM dgempres01..hcnfolio WHERE GENPACIEN = @oid_nuevo)
		DECLARE @sumar_viejo INT =(SELECT MAX(HCNUMFOL) FROM dgempres01..hcnfolio WHERE GENPACIEN = @oid_viejo)

		IF @sumar_nuevo IS NOT NULL
			BEGIN----Sumar Folios, ya que el paciente nuevo tiene folios registrados
				UPDATE dgempres01..HCNFOLIO SET HCNUMFOL = HCNUMFOL + @sumar_nuevo, GENPACIEN = @oid_nuevo WHERE GENPACIEN = @oid_viejo
				SET @evidencia += 'HCNFOLIO:' + CONVERT(VARCHAR, @@ROWCOUNT) + CHAR(13) + CHAR(10)
			END
		ELSE 
			BEGIN----No sumar Folios, porque el paciente nuevo no tiene
				UPDATE dgempres01..HCNFOLIO SET GENPACIEN = @oid_nuevo WHERE GENPACIEN = @oid_viejo
				SET @evidencia += 'HCNFOLIO:' + CONVERT(VARCHAR, @@ROWCOUNT) + CHAR(13) + CHAR(10)
			END	
			
		UPDATE dgempres01..HCNREGENF SET GENPACIEN = @oid_nuevo WHERE GENPACIEN = @oid_viejo
		SET @evidencia += 'HCNREGENF:' + CONVERT(VARCHAR, @@ROWCOUNT) + CHAR(13) + CHAR(10)

		UPDATE dgempres01..HCNINCAPA SET GENPACIEN = @oid_nuevo WHERE GENPACIEN = @oid_viejo
		SET @evidencia += 'HCNINCAPA:' + CONVERT(VARCHAR, @@ROWCOUNT) + CHAR(13) + CHAR(10)

		UPDATE dgempres01..HCNEPICRI SET GENPACIEN = @oid_nuevo WHERE GENPACIEN = @oid_viejo
		SET @evidencia += 'HCNEPICRI:' + CONVERT(VARCHAR, @@ROWCOUNT) + CHAR(13) + CHAR(10)
		
		UPDATE dgempres01..HCNCONSTAN SET GENPACIEN = @oid_nuevo WHERE GENPACIEN = @oid_viejo
		SET @evidencia += 'HCNCONSTAN:' + CONVERT(VARCHAR, @@ROWCOUNT) + CHAR(13) + CHAR(10)
		
		--------------EN CDO
		/*UPDATE CDO02_21..asi_ingreso SET paciente = @oid_nuevo WHERE paciente = @oid_viejo
		SET @evidencia += 'asi_ingreso:' + CONVERT(VARCHAR, @@ROWCOUNT) + CHAR(13) + CHAR(10)

		UPDATE CDO02_21..asi_suministro_solicitud SET paciente = @oid_nuevo WHERE paciente = @oid_viejo
		SET @evidencia += 'asi_suministro_solicitud:' + CONVERT(VARCHAR, @@ROWCOUNT) + CHAR(13) + CHAR(10)
		
		UPDATE CDO02_21..asi_control_urgencia SET paciente = @oid_nuevo WHERE paciente = @oid_viejo
		SET @evidencia += 'asi_control_urgencia:' + CONVERT(VARCHAR, @@ROWCOUNT) + CHAR(13) + CHAR(10)
		
		UPDATE CDO02_21..asi_atencion_urgencia SET paciente = @oid_nuevo WHERE paciente = @oid_viejo
		SET @evidencia += 'asi_atencion_urgencia:' + CONVERT(VARCHAR, @@ROWCOUNT) + CHAR(13) + CHAR(10)
		
		UPDATE CDO02_21..asi_tratamiento_solicitud SET paciente = @oid_nuevo WHERE paciente = @oid_viejo
		SET @evidencia += 'asi_tratamiento_solicitud:' + CONVERT(VARCHAR, @@ROWCOUNT) + CHAR(13) + CHAR(10)
		
		UPDATE CDO02_21..asi_autorizacion_solicitud_interna SET paciente = @oid_nuevo WHERE paciente = @oid_viejo
		SET @evidencia += 'asi_autorizacion_solicitud_interna:' + CONVERT(VARCHAR, @@ROWCOUNT) + CHAR(13) + CHAR(10)*/

		--------------EN DATALAB
		/*UPDATE Servidor01.Datalab2005.dbo.datalab_occi SET cedula = @doc_nuevo WHERE cedula = @doc_viejo
		SET @evidencia += 'datalab_occi:' + CONVERT(VARCHAR, @@ROWCOUNT) + CHAR(13) + CHAR(10)*/
		
	END ELSE BEGIN
		SET @evidencia += 'No existen los documentos a fusionar' + CHAR(13) + CHAR(10)
	END
	
	UPDATE asi_log_traslado_codigo SET detalle = @evidencia WHERE id = @id_reg
	
	SELECT * FROM asi_log_traslado_codigo WHERE id = @id_reg

END
