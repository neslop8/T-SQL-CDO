USE [DGEMPRES01]
GO
/****** Object:  Trigger [dbo].[trg_correo_solicitud_interconsulta]    Script Date: 03/01/2022 11:39:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER TRIGGER [dbo].[trg_cierre_inventarios] ON [dbo].[INNCIEINV]
	FOR INSERT--, UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    
	DECLARE @body NVARCHAR(MAX) = N'', @xml NVARCHAR(MAX) = N'', @asunto varchar(400)=''
	DECLARE @equipo char(30) , @direccion char(30), @cmd char(30),  @periodo char(30), @usuario char(300)
	SELECT @equipo = hostname FROM sys.sysprocesses WHERE spid = @@SPID
    SELECT @cmd = cmd FROM sys.sysprocesses WHERE spid = @@SPID
    SELECT @direccion = client_net_address FROM sys.dm_exec_connections WHERE Session_id = @@SPID;

	SELECT @usuario = GENUSUARIO.USUDESCRI
	from inserted inner join DGEMPRES01..GENUSUARIO ON inserted.ICIUSUARIO=GENUSUARIO.USUNOMBRE	

	SELECT @periodo = CONVERT(VARCHAR, DATENAME(MM, ICIPERIODO)) from inserted 
	----------------------------------------------------------------------------------------------------------------------------------        
	-----------------------------------------------------------------------------------Cabecera del Correo
	SET @body = '<html><body><H1 align="center"><p style="color:rgb(36, 113, 163); 
	             border:dashed rgb(36, 113, 163) 1px;  background-color:rgb(232, 248, 245);";"><a href="http://www.clinicadeloccidente.com">CLINICA DEL OCCIDENTE</a></ p></ h1>
				 <H2><p style="color:rgb(36, 113, 163);";">Cierre de Mes Modulo Inventarios<br>'
    -----------------------------------------------------------------------------------Fin de la Cabecera del Correo
	--------------------------------------------------------------------------------------Detalle del correo
    --SELECT @xml += '</ p></ h2>'+ ' Especialidad     : ' + esp.GEEDESCRI + '</ H3>' + '</ p>' + '<br>' + '<br>'
SELECT @xml += '</ p></ h2>'+ 'Realizado por el Usuario     : ' + xxx.ICIUSUARIO + '<br>' + @usuario +'</ p><br><br>'
	+ '<H4><p style="color:rgb(36, 113, 163); border:dotted rgb(36, 113, 163) 1px; background-color:rgb(232, 248, 245);";">' 
    + 'Cierre del Mes de : ' + @periodo + ' del Año : ' + CONVERT(VARCHAR, DATEPART(YY, ICIPERIODO)) + '<br><br>'
	+ 'Generado desde el equipo : ' + @equipo + 'Dirección IP : ' + @direccion + '<br><br>'
	+ 'En la Fecha : ' + CONVERT(VARCHAR, xxx.ICIFECPRO) + '<br><br>'
	from inserted xxx 
----------------------------------------------------------------------------------------------------------------------------------
	Set @body = @body + @xml + '</ h4></ p></ body></ html>'
----------------------------------------------------------------------------------------------------------------------------------        
	--EXECUTE msdb.dbo.sysmail_start_sp
	--WAITFOR DELAY '000:00:04'
	Set @asunto= 'Cierre de Inventarios del mes : ' + @periodo
----------------------------------------------------------------------------------------------------------------------------------        
        EXEC msdb.dbo.sp_send_dbmail @profile_name = 'NFLopez',
          --@recipients = 'neslop8@hotmail.com;nflopez@clinicadeloccidente.com',--Activar correos para pruebas
		  @recipients = 'neslop8@hotmail.com;nflopez@clinicadeloccidente.com;almacen@clinicadeloccidente.com;farmacia@clinicadeloccidente.com;mfuentes@clinicadeloccidente.com;sistemas@clinicadeloccidente.com;gerenteadministrativo@clinicadeloccidente.com',--Activar correos para pruebas		  
		  @subject = @asunto,
		  @importance='High',
		  @sensitivity='Confidential',
		  @Body=@body,
		  @Body_format='HTML';
END