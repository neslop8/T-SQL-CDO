use DGEMPRES03
-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------Cursor para GENMANTAR por cambio de SMLV
declare @Manual char(3)
declare @Mantar bigint
--CREATE TABLE #DBRecovery (OID_Old INT NOT NULL, OID_New INT NOT NULL)
-- Declaración del cursor de Manuales
DECLARE Cod_Manuales CURSOR FOR
	
	select pla.GPPCODIGO
	from DGEMPRES03..GENMANUAL man inner join DGEMPRES03..GENPLAPRO pla on man.GENMANUAL=pla.GPPCODIGO
	inner join DGEMPRES03..GENDETCON det on det.GENPLAPRO2=pla.OID
	inner join DGEMPRES03..SLNFACTUR fac on fac.gendetcon=det.OID
	inner join DGEMPRES03..SLNPLACEN cen on cen.GENDETCON=det.OID
	where fac.sfafecfac > '20210101' and cen.ADNCENATE=1 --and man.GENMANUAL='FM'
	group by pla.GPPCODIGO

-- Apertura del cursor
OPEN Cod_Manuales
-- Lectura de la primera fila del cursor
FETCH NEXT FROM Cod_Manuales INTO @Manual
WHILE(@@FETCH_STATUS= 0) 
BEGIN 

		-- Declaración del cursor de Tarifas
		DECLARE Id_Tarifas CURSOR FOR
	
			select tar.oid
			FROM DGEMPRES03..INNPROEPS eps inner join DGEMPRES03..INNMANTAR tar on tar.INNPROEPS=eps.OID
			inner join DGEMPRES03..GENMANUAL man on eps.GENMANUAL=man.OID
			inner join DGEMPRES03..INNPRODUC pro on eps.INNPRODUC=pro.OID
			--where man.GENMANUAL='FM'
			where man.GENMANUAL=@Manual --and man.GENMANUAL='FM'
			and tar.IMTFECFIN >= GETDATE()			

		-- Apertura del cursor
		OPEN Id_Tarifas
		-- Lectura de la primera fila del cursor
		FETCH NEXT FROM Id_Tarifas INTO @Mantar
		WHILE(@@FETCH_STATUS= 0) 
		BEGIN 	
		-------------------------------------------Ingresar datos a mano
			--update DGEMPRES03..INNMANTAR set IMTFECFIN='2021-31-12 23:59:59' where OID=@Mantar and IMTFECFIN > '20220101'

			---Crear tabla temporal para no perder OID, motivo por el que se pierden = Desconocido
			insert into DGEMPRES03..INNMANTAR1
			(OID, INNPROEPS, IMTFECINI, IMTFECFIN, IMTVALPRO, IMTVALREC, SERPODEPA, GENSALMIN, IPEINACTIVO, IPECONSEC, OptimisticLockField, _Consecutivo)
			
			select 
			OID, INNPROEPS, '20220101', '20230131', IMTVALPRO, IMTVALREC, SERPODEPA, 3		 , IPEINACTIVO, 71		 , 71					,71			
			from DGEMPRES03..INNMANTAR where OID=@Mantar

			/*INSERT INTO #DBRecovery (OID_Old, OID_New)
			select @@IDENTITY, @Mantar*/
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
/*select * from #DBRecovery
DROP TABLE #DBRecovery*/
-- Cierra el cursor
CLOSE Cod_Manuales
-- Libera los recursos del cursor
DEALLOCATE Cod_Manuales
-----------------------------------------------------------------------------------------------------------------