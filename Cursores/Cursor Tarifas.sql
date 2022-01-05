-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------Cursor para GENMANTAR por cambio de SMLV
declare @Manual char(3)
declare @Mantar bigint
-- Declaración del cursor de Manuales
DECLARE Cod_Manuales CURSOR FOR
	
	select pla.GPPCODIGO
	from DGEMPRES01..GENMANUAL man inner join DGEMPRES01..GENPLAPRO pla on man.GENMANUAL=pla.GPPCODIGO
	inner join DGEMPRES01..GENDETCON det on det.GENPLAPRO1=pla.OID
	inner join DGEMPRES01..SLNFACTUR fac on fac.GENDETCON=det.OID
	inner join DGEMPRES01..SLNPLACEN cen on cen.GENDETCON=det.OID
	where fac.sfafecfac > '20210101' and cen.ADNCENATE=1 and fac.SFADOCANU=0 and man.GENTIPREG=1
	and man.GENMANUAL in ('508')
	group by pla.GPPCODIGO Order by 1

-- Apertura del cursor
OPEN Cod_Manuales
-- Lectura de la primera fila del cursor
FETCH NEXT FROM Cod_Manuales INTO @Manual
WHILE(@@FETCH_STATUS= 0) 
BEGIN 

		-- Declaración del cursor de Tarifas
		DECLARE Id_Tarifas CURSOR FOR
	
			select tar.OID
			from DGEMPRES01..GENMANSER ser inner join DGEMPRES01..GENMANTAR tar on tar.GENMANSER1=ser.OID
			inner join DGEMPRES01..GENMANUAL man on ser.GENMANUAL1=man.OID
			inner join DGEMPRES01..GENSERIPS ips on ser.GENSERIPS1=ips.OID 
			where tar.SMTFECFIN >= GETDATE() and man.genmanual=@Manual
			order by tar.OID

		-- Apertura del cursor
		OPEN Id_Tarifas
		-- Lectura de la primera fila del cursor
		FETCH NEXT FROM Id_Tarifas INTO @Mantar
		WHILE(@@FETCH_STATUS= 0) 
		BEGIN 
		-------------------------------------------Ingresar datos a mano
			--update DGEMPRES03..GENMANTAR set SMTFECFIN='2021-31-12 23:59:59' where OID=@Mantar and SMTFECFIN > '20220101'

			insert into DGEMPRES03..GENMANTAR1
			(GENMANUAL, OID, GENMANSER1, SMTFECINI, SMTFECFIN, 	SMTVALSER, SMTVALREC, GENSALMIN1,	OptimisticLockField)
			select 
			@Manual, OID, GENMANSER1, '20220101'  , '20230131',	SMTVALSER, SMTVALREC, 3,			71
			from DGEMPRES01..GENMANTAR where OID=@Mantar
		-----------------------------------------------------------------------------------------------------------------
				FETCH NEXT FROM Id_Tarifas INTO @Mantar
			-- Fin del bucle WHILE
		END
		-- Cierra el cursor
		CLOSE Id_Tarifas
		-- Libera los recursos del cursor
		DEALLOCATE Id_Tarifas
-----------------------------------------------------------------------------------------------------------------
FETCH NEXT FROM Cod_Manuales INTO @Manual
-- Fin del bucle WHILE
END
-- Cierra el cursor
CLOSE Cod_Manuales
-- Libera los recursos del cursor
DEALLOCATE Cod_Manuales
-----------------------------------------------------------------------------------------------------------------