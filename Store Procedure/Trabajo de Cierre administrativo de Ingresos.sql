USE [CDO02_21]
GO
/****** Object:  StoredProcedure [dbo].[p_ingresos_no_facturables]    Script Date: 04/02/2021 15:53:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[p_ingresos_no_facturables]
AS BEGIN
	SET NOCOUNT ON

	declare @consecutivo bigint, @consec bigint---Variables para el consecutivo
	------------------------------------------------------------------------------------Consecutivo actual
	set @consec = (select gconumero from DgEmpres01..GENCONSEC where GCOCODIGO='ADM0014')
	------------------------------------------------------------------------------------Consecutivo final
	set @consecutivo = (select count(*) 
	from DgEmpres01..adningreso ing inner join DgEmpres01..gendetcon det on ing.gendetcon=det.oid
	where det.gdecodigo like '%26' and (ing.ainestado=0 or ing.AINESTADO=3) --and ing.AINFECING <= '2013-31-12')
	and ing.OID not in (select adningres1 from DgEmpres01..slnordser where SOSESTADO in (0, 1) group by ADNINGRES1))
	------------------------------------------------------------------------------------Cursor para Insert detalle	
	declare @ingres bigint
	-- Declaración del cursor
	DECLARE ingresos_cerrar CURSOR FOR
		select ing.OID
		from DgEmpres01..adningreso ing inner join DgEmpres01..gendetcon det on ing.gendetcon=det.oid
		where det.gdecodigo like '%26' and (ing.ainestado=0 or ing.AINESTADO=3) --and ing.AINFECING <= '2013-31-12')
		and ing.OID not in (select adningres1 from DgEmpres01..slnordser where SOSESTADO in (0, 1) group by ADNINGRES1)
	-- Apertura del cursor
	OPEN ingresos_cerrar
	-- Lectura de la primera fila del cursor
		FETCH NEXT from ingresos_cerrar INTO @ingres
		WHILE(@@FETCH_STATUS= 0) 
		BEGIN 
		Set @consec=@consec+1
		-------------------------------------------Ingresar datos a ADNCIADMIN
		insert into DgEmpres01..ADNCIADMIN (ACICONSEC, ADNINGRESO, ACIFECING, ACIMOTIVO, GEENUSUARIO, ADNESTADO, ADNMOTANU, ADNFECANUL,ADNUSUANUL)
		                 values(@consec, @ingres, GETDATE(), 'Control Post Quirurgico - Plan 26', 822, 1, NULL, NULL, NULL)
		-------------------------------------------Ingresar datos a ADNINGHIS
		insert into DgEmpres01..ADNINGHIS (ADNINGRESO, HISNOVEDAD, HISFECHA, GENUSUARIO, HISDOCUME, OptimisticLockField)
		values (@ingres, 11, GETDATE(), 822, 'Cierre de Ingreso por tramite administrativo', 69)	
		-----------------------------------------------------------------------------------------------------------------
		FETCH NEXT from ingresos_cerrar INTO @ingres
	---Fin del bucle WHILE
	END
	---Cierra el cursor
	CLOSE ingresos_cerrar
	---Libera los recursos del cursor
	DEALLOCATE ingresos_cerrar
	-------------------------------------------Ingresos a Estado 4
	--update ADNINGRESO set AINMOTANU='INGRESOS DE CONTROL NO FACTURABLES', ADFECANULA=GETDATE(), ADUSUANULA=822,	AINESTADO=1 --Anterior al cierre administrativo de ingresos
	update DgEmpres01..ADNINGRESO set AINESTADO=4 
	where oid in
	(select ing.OID
	from DgEmpres01..adningreso ing inner join DgEmpres01..gendetcon det on ing.gendetcon=det.oid
	where det.gdecodigo like '%26' and (ing.ainestado=0 or ing.AINESTADO=3) --and ing.AINFECING <= '2013-31-12')
	and ing.OID not in (select adningres1 from DgEmpres01..slnordser where SOSESTADO in (0, 1) group by ADNINGRES1))

	update DgEmpres01..GENCONSEC set gconumero=@consec where GCOCODIGO='ADM0014'
END