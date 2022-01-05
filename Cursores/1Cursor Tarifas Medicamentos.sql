use DGEMPRES03
-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------Cursor para GENMANTAR por cambio de SMLV
declare @Manual char(3)='FM'
declare @Mantar bigint, @Contador bigint = 0

--CREATE TABLE #DBRecovery (OID_Old INT NOT NULL, OID_New INT NOT NULL)

-- Declaración del cursor de Manuales
		-- Declaración del cursor de Tarifas
		DECLARE Id_Tarifas CURSOR FOR
	
			select tar.OID
			FROM DGEMPRES03..INNPROEPS eps inner join DGEMPRES03..INNMANTAR tar on tar.INNPROEPS=eps.OID
			inner join DGEMPRES03..GENMANUAL man on eps.GENMANUAL=man.OID
			inner join DGEMPRES03..INNPRODUC pro on eps.INNPRODUC=pro.OID
			--where man.GENMANUAL='FM'
			where man.GENMANUAL=@Manual --and tar.OID in (3393, 3867)
			and tar.IMTFECFIN >= GETDATE()
			order by tar.OID	

		-- Apertura del cursor
		OPEN Id_Tarifas
		-- Lectura de la primera fila del cursor
		FETCH NEXT FROM Id_Tarifas INTO @Mantar
		WHILE(@@FETCH_STATUS= 0) 
		BEGIN 	
		-------------------------------------------Ingresar datos a mano
			--update DGEMPRES03..INNMANTAR set IMTFECFIN='2021-31-12 23:59:59' where OID=@Mantar and IMTFECFIN > '20220101'

			insert into DGEMPRES03..INNMANTAR1
			(OID, INNPROEPS, IMTFECINI, IMTFECFIN, IMTVALPRO, IMTVALREC, SERPODEPA, GENSALMIN, IPEINACTIVO, IPECONSEC, OptimisticLockField, _Consecutivo)
			
			select 
			OID, INNPROEPS, '20220101', '20230131', IMTVALPRO, IMTVALREC, SERPODEPA, 3		, IPEINACTIVO, IPECONSEC, 71					,71			
			from DGEMPRES03..INNMANTAR where OID=@Mantar

			/*INSERT INTO #DBRecovery (OID_Old, OID_New)
			select @@IDENTITY, @Mantar*/
			
		-----------------------------------------------------------------------------------------------------------------
				FETCH NEXT FROM Id_Tarifas INTO @Mantar
			-- Fin del bucle WHILE
		END
		/*select * from #DBRecovery
		DROP TABLE #DBRecovery*/
		-- Cierra el cursor
		CLOSE Id_Tarifas
		-- Libera los recursos del cursor
		DEALLOCATE Id_Tarifas
-----------------------------------------------------------------------------------------------------------------
---DROP TABLE #DBRecovery