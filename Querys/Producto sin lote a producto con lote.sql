use DGEMPRES22
--select top 5 * from INNFISICO
--select top 5 * from INNPRODUC where IPRCODIGO='22912046'
-----------------------------------------------------------------------------------------------------------------
-------------------------------------------Ingresar datos a mano
declare @producto_old char(20) = '22912047', @producto_new char(20) = 'DM-22912047'
declare @lote_new     char(20) = 'Lote_22912047'
declare @fec_lote_new datetime = '20190131'
-------------------------------------------
declare @salida   char(10) = 'S000000000'
declare @entrada  char(10) = 'E000000000'
declare @salida1   int, @entrada1  int, @ciclo int, @oid_old int, @oid_new int, @oid_lote_new int, @costo_prom int
declare @salida2   char(14), @entrada2  char(14)
-----------------------------------------------------------------------------------------------------------------
BEGIN
	DECLARE @lote INT = (select max(fis.INNLOTSER)
						 from DGEMPRES22..INNPRODUC pro inner join DGEMPRES22..INNFISICO fis on fis.INNPRODUC=pro.OID
						 inner join DGEMPRES22..INNLOTSER lot on fis.INNLOTSER=lot.OID
						 where pro.IPRCODIGO=@producto_old);
	
	IF @lote IS NOT NULL
	BEGIN
		RAISERROR ('El producto ya tiene lotes registrados en INNFISICO', 11,1);
		RETURN ;
	END

	DECLARE @cantidad INT = (select max(fis.IFICANTID)
						 from DGEMPRES22..INNPRODUC pro inner join DGEMPRES22..INNFISICO fis on fis.INNPRODUC=pro.OID
						 inner join DGEMPRES22..INNLOTSER lot on fis.INNLOTSER=lot.OID
						 where pro.IPRCODIGO=@producto_old and fis.IFICANTID > 0);
	
	IF @lote IS NOT NULL
	BEGIN
		RAISERROR ('El producto no tiene cantidades registradas en INNFISICO', 11,1);
		RETURN ;
	END
------------------------------------------------------------------------------Inserto las cantidades en la tabla
	DECLARE @t TABLE (produc char(20), oid_prod INT, cantidad INT, almacen INT)
-----------------------------------------------------------------------------------------------------------------
	INSERT INTO @t (produc, oid_prod, cantidad, almacen)
	--------------------------------------------------------------------------------------------Inventario_producto_sin_lote
    select pro.IPRCODIGO codigo, pro.OID Oid_prod, fis.IFICANTID Cantidad, fis.INNALMACE almacen
	from DGEMPRES22..INNPRODUC pro inner join DGEMPRES22..INNFISICO fis on fis.INNPRODUC=pro.OID
	where pro.IPRCODIGO=@producto_old and fis.IFICANTID > 0 order by 4
-----------------------------------------------------------------------------------------------------------------
	select @salida1 = GCONUMERO from DGEMPRES22..GENCONSEC where OID=167
	select @entrada1 = GCONUMERO from DGEMPRES22..GENCONSEC where OID=273
-----------------------------------------------------WHILE Insertar en INNDOCUME
	select @ciclo = COUNT(*) from @t

	DECLARE @contador int, @oid_salida int, @oid_entrada int
	-----------------------------------------------------------------------------------------------------------------
	select @oid_old = OID from DGEMPRES22..INNPRODUC where IPRCODIGO=@producto_old
	select @costo_prom = IPRCOSTPE from DGEMPRES22..INNPRODUC where IPRCODIGO=@producto_old
	select @oid_new = OID from DGEMPRES22..INNPRODUC where IPRCODIGO=@producto_new
	-----------------------------------------------------Inserto el LOTE
	insert into DGEMPRES22..INNLOTSER (INNPRODUC, ILSTIPO, ILSCODIGO, ILSFECVEN,     OptimisticLockField) 
	                           values (@oid_new,  0,       @lote_new, @fec_lote_new, 0)
    select @oid_lote_new = OID from DGEMPRES22..INNLOTSER where ILSCODIGO=@lote_new
	-----------------------------------------------------Cursor para INSERTAR INNFISICO
	declare @produc_cur_cant char(20), @oid_prod_cur_cant INT, @cantidad_cur_cant INT, @almacen_cur_cant INT
	-- Declaración del cursor
	DECLARE cantidades CURSOR FOR
		select pro.IPRCODIGO codigo, pro.OID Oid_prod, fis.IFICANTID Cantidad, fis.INNALMACE almacen
		from DGEMPRES22..INNPRODUC pro inner join DGEMPRES22..INNFISICO fis on fis.INNPRODUC=pro.OID
		where pro.IPRCODIGO=@producto_old and fis.IFICANTID > 0 order by 4
		--where pro.IPRCODIGO=@producto_old and fis.IFICANTID > 0 order by 4

	-- Apertura del cursor
	OPEN cantidades
	-- Lectura de la primera fila del cursor
	FETCH cantidades INTO @produc_cur_cant, @oid_prod_cur_cant, @cantidad_cur_cant, @almacen_cur_cant
	WHILE(@@FETCH_STATUS= 0) 
		BEGIN 
		SET @salida1  = @salida1  + 1
	    SET @entrada1 = @entrada1 + 1

		insert into DGEMPRES22..INNFISICO (INNALMACE,         INNPRODUC, INNLOTSER,     IFICANTID, IFICANCOMP, OptimisticLockField)
		                           values (@almacen_cur_cant, @oid_new,  @oid_lote_new, 0 ,       0,          0)
		-----------------------------------------------------------------------------------Salidas
		-----------------------------------------------Inndocume
		insert into DGEMPRES22..INNDOCUME (IDCONSEC, IDFECDOC, IDTIPDOC, IDESTADO, GENUSUARIO2, IDFECCRE, OptimisticLockField, ObjectType)
		values (@salida + CONVERT(CHAR(4), @salida1), GETDATE(), 11, 0, 770, GETDATE(), 0, 844)

		select @oid_salida = @@IDENTITY
		-----------------------------------------------INNAJUINVEC-----Cabecera
		insert into DGEMPRES22..INNAJUINVEC (OID,           IAITIPO, INNCONAJU, INNALMACE,         GENTERCER, IAIDETALLE,                                                                      IAITIPMOVENT)
		                             values (@oid_salida ,  1,       14,        @almacen_cur_cant, 1,         'Ajuste de Salida para cambio de codificación de productos sin lote a productos con lote', 1 )
		-----------------------------------------------INNAJUINVED-----Detalle
		insert into DGEMPRES22..INNAJUINVED(INNNUMITE, INNPRODUC,          IDDCANTID          , INNAJUINVEC, IAICOSTOUNIT, OptimisticLockField)
		                            values (1,         @oid_prod_cur_cant, @cantidad_cur_cant,  @oid_salida, @costo_prom,       0)
		-----------------------------------------------------------------------------------Entradas
		-----------------------------------------------Inndocume
        insert into DGEMPRES22..INNDOCUME (IDCONSEC, IDFECDOC, IDTIPDOC, IDESTADO, GENUSUARIO2, IDFECCRE, OptimisticLockField, ObjectType)
		values (@entrada + CONVERT(CHAR(4), @entrada1), GETDATE(), 11, 0, 770, GETDATE(), 0, 844)
		select @oid_entrada = @@IDENTITY
		-----------------------------------------------INNAJUINVEC-----Cabecera
		insert into DGEMPRES22..INNAJUINVEC (OID,           IAITIPO, INNCONAJU, INNALMACE,         GENTERCER, IAIDETALLE,                                                                      IAITIPMOVENT)
		                             values (@oid_entrada,  0,       161,        @almacen_cur_cant, 1,         'Ajuste de Entrada para cambio de codificación de productos sin lote a productos con lote', 1 )
		-----------------------------------------------INNAJUINVED-----Detalle
		insert into DGEMPRES22..INNAJUINVED(INNNUMITE, INNPRODUC, IDDCANTID         , INNAJUINVEC, INNLOTSER,      IAICOSTOUNIT, OptimisticLockField)
		                            values (1,         @oid_new , @cantidad_cur_cant, @oid_entrada, @oid_lote_new, @costo_prom,       0)
		-- Lectura de la siguiente fila de un cursor
		FETCH cantidades INTO @produc_cur_cant, @oid_prod_cur_cant, @cantidad_cur_cant, @almacen_cur_cant
		-- Fin del bucle WHILE
		END
	-- Cierra el cursor
	CLOSE cantidades
	-- Libera los recursos del cursor
	DEALLOCATE cantidades
-----------------------------------------------------------------------------------------------------------------
	update DGEMPRES22..GENCONSEC set GCONUMERO=GCONUMERO + @ciclo where OID in (167, 273)
	
END
-----------------------------------------------------------------------------------------------------------------
