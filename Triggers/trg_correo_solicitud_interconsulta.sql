USE [DGEMPRES01]
GO
/****** Object:  Trigger [dbo].[trg_correo_solicitud_interconsulta]    Script Date: 05/01/2022 8:20:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TRIGGER [dbo].[trg_correo_solicitud_interconsulta] ON [dbo].[HCNINTERC]
	FOR INSERT--, UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    
	DECLARE @correo varchar(400)='', @correos varchar(400)='', @asunto varchar(400)='', @num varchar(8)='', @especi varchar(400)=''
	DECLARE @body NVARCHAR(MAX) = N'', @xml NVARCHAR(MAX) = N'';
		---------------------------------------------------------------Cursor para generar los correos a enviar en @recipients
	DECLARE mails CURSOR FOR 
		Select med.GMEEMAIL as correo
		from inserted xxx inner join HCNINTERC sol on xxx.oid=xxx.oid
		inner join GENESPECI esp on xxx.GENESPECI=esp.OID
		inner join GENESPMED espm on esp.OID=espm.ESPECIALIDADES
		inner join GENMEDICO  med on espm.MEDICOS=med.OID
		inner join GENUSUARIO usu on med.GENUSUARIO=usu.OID
		where med.GMEESTADO=0 and usu.USUESTADO=1 and (med.GMEEMAIL <> '' or med.GMEEMAIL <> NULL) 
		and med.OID not in (21,2597,2594) --JAGAITAN, CWMOSQUERA, EASANABRIA - Solicita no ser tenido en cuenta para notificaciones
		group by med.GMEEMAIL
	
	OPEN mails
	FETCH NEXT FROM mails INTO @correo
	WHILE @@fetch_status = 0
		BEGIN
			Set @correos = @correos + @correo + ';'
			FETCH NEXT FROM mails INTO @correo
		END		
		Set @correos = SUBSTRING(@correos, 0, LEN(@correos))
	CLOSE mails
	DEALLOCATE mails
	--------------------------------------------------------------------------------------Fin del cursor de los correos
	----------------------------------------------------------------------------------------------------------------------------------        
		Set @num = convert(varchar, (SELECT HCICONSEC FROM inserted))
		--Set @asunto = @asunto + @num
	-----------------------------Si no hay correos para enviar salir del procedimiento
	IF LEN(@correos) <= 1
	BEGIN
		
		Set @especi = (	Select esp.GEEDESCRI 
		from inserted xxx inner join GENESPECI esp on xxx.GENESPECI=esp.OID)

	    Set @asunto = 'Sin correo para - ' + @num + ' de ' + @especi
		Set @body = 'No existe correo para el envio de la Interconsulta - ' + @num + ' de ' + @especi
				
	    EXEC msdb.dbo.sp_send_dbmail @profile_name = 'Interconsulta',
          @recipients = 'nflopez@clinicadeloccidente.com;sistemas@clinicadeloccidente.com', 
		  @subject = @asunto,
		  @importance='High',
		  @sensitivity='Confidential',
		  @Body=@body,
		  @Body_format='HTML';
		RETURN;
	END	
	-----------------------------------------------------------------------------------Cabecera del Correo
	SET @body = '<html><body><H1 align="center"><p style="color:rgb(36, 113, 163); 
	             border:dashed rgb(36, 113, 163) 1px;  background-color:rgb(232, 248, 245);";"><a href="http://www.clinicadeloccidente.com">CLINICA DEL OCCIDENTE</a></ p></ h1>
				 <H2><p style="color:rgb(36, 113, 163);";">Solicitud de Interconsulta para la'
    -----------------------------------------------------------------------------------Fin de la Cabecera del Correo
	--------------------------------------------------------------------------------------Detalle del correo
    --SELECT @xml += '</ p></ h2>'+ ' Especialidad     : ' + esp.GEEDESCRI + '</ H3>' + '</ p>' + '<br>' + '<br>'
SELECT @xml += '</ p></ h2>'+ ' Especialidad     : ' + esp.GEEDESCRI + '</ p><br><br>'
    + 'Prioridad : ' + case (xxx.HCPRIINTER) WHEN 1 THEN ' Urgente' WHEN 2 THEN ' Prioritario' WHEN 3 THEN ' Regular' ELSE ' Ninguno' END + '<br><br>'
	+ '<H4><p style="color:rgb(36, 113, 163); border:dotted rgb(36, 113, 163) 1px; background-color:rgb(232, 248, 245);";">' 
	+ 'Fecha de Solicitud	: ' + convert(varchar, fol.HCFECFOL, 100) + '<br>' 
	+ 'Fecha de Ingreso	    : ' + convert(varchar, ing.AINFECING, 100) + ' - ' + 'Fecha de Hospitalización	: ' + CASE WHEN ing.AINFECHOS IS NULL THEN ' Ambulatorio ' ELSE convert(varchar, ing.AINFECHOS, 100) END +'<br>'
	+ 'Responder con el consecutivo: <strong>' + CONVERT(varchar, xxx.HCICONSEC) + '</ strong><br>'
	+ 'Identificación		: ' + pac.pacnumdoc + ' - ' + CASE WHEN pac.GPANOMCOM  IS NULL THEN '' ELSE RTRIM(LTRIM(pac.GPANOMCOM)) END + '<br>'
	+ 'Ingreso				: ' + convert(varchar, ing.AINCONSEC) + ' - Cama : ' + CASE WHEN cam.HCACODIGO IS NULL THEN ' Ambulatorio ' ELSE convert(varchar, cam.HCACODIGO) END + ' Edad :' + CONVERT(varchar, ROUND((CONVERT (INT, GETDATE()) - CONVERT(INT, pac.gpafecnac)) / 365, 0)) + ' Sexo :' + CASE pac.GPASEXPAC WHEN 1 THEN ' Masculino ' WHEN 2 THEN ' Femenino ' else ' Indeterminado ' end + '<br>'
	--+ 'Diagnostico			: ' + CASE WHEN dx.DIACODIGO IS NULL THEN '' ELSE dx.DIACODIGO END + ' - ' + CASE WHEN dx.DIANOMBRE IS NULL THEN '' ELSE dx.DIANOMBRE END + '<br>'
	+ 'Area de Servicio		: ' + CASE WHEN are.GASCODIGO IS NULL THEN '' ELSE are.GASCODIGO END + ' - ' + CASE WHEN are.GASNOMBRE IS NULL THEN '' ELSE convert(varchar, are.GASNOMBRE) END +'<br>'
	+ 'Solicitada por    	: ' + CASE WHEN med.GMENOMCOM IS NULL THEN '' ELSE RTRIM(LTRIM(med.GMENOMCOM)) END + ' - Especialidad : ' + CASE WHEN esp_m.GEEDESCRI IS NULL THEN '' ELSE RTRIM(LTRIM(esp_m.GEEDESCRI)) END +'<br>'
	+ 'Desde el Folio    	: ' + CASE WHEN fol.HCNUMFOL IS NULL THEN '' ELSE RTRIM(LTRIM(fol.HCNUMFOL)) END + ' - Historia : ' + CASE WHEN tip.HCCODIGO IS NULL THEN '' ELSE RTRIM(LTRIM(tip.HCCODIGO)) END +' - '+ CASE WHEN tip.HCNOMBRE IS NULL THEN '' ELSE RTRIM(LTRIM(tip.HCNOMBRE)) END +'<br><br>'
	+ 'Motivo				: ' + CASE WHEN xxx.HCIMOTIVO IS NULL THEN '' ELSE RTRIM(LTRIM(xxx.HCIMOTIVO)) END +'<br>'
	from inserted xxx inner join GENESPECI esp  on xxx.GENESPECI=esp.OID
	inner join hcnfolio  fol  on xxx.hcnfolio=fol.oid 
	inner join HCNTIPHIS tip  on fol.HCNTIPHIS=tip.OID
	inner join GENMEDICO med  on fol.GENMEDICO=med.OID
	inner join GENESPECI esp_m  on fol.GENESPECI=esp_m.OID
	inner join adningreso ing on fol.ADNINGRESO=ing.OID
	inner join genpacien pac  on ing.genpacien=pac.OID
	--inner join GENDIAGNO dx   on xxx.GENDIAGNO=dx.OID
	inner join GENARESER are  on xxx.GENARESER=are.OID
	left join HPNDEFCAM   cam on ing.HPNDEFCAM=cam.OID
----------------------------------------------------------------------------------------------------------------------------------
	Set @body = @body + @xml + '</ h4></ p></ body></ html>'
----------------------------------------------------------------------------------------------------------------------------------        
	--EXECUTE msdb.dbo.sysmail_start_sp
	--WAITFOR DELAY '000:00:04'
	Set @asunto='Solicitud de Interconsulta - '+ @num
----------------------------------------------------------------------------------------------------------------------------------        
        EXEC msdb.dbo.sp_send_dbmail @profile_name = 'Interconsulta',
          @recipients = @correos, 
		  --@recipients = 'neslop8@hotmail.com;nflopez@clinicadeloccidente.com',--Activar correos para pruebas
		  --@subject = 'Solicitud de Interconsulta DgEmpres21',
		  @subject = @asunto,
		  @importance='High',
		  @sensitivity='Confidential',
		  @Body=@body,
		  @Body_format='HTML';
END