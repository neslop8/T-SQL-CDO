use DGEMPRES01
-----------------------------------------------------------------------------------------------------------------
--select * from DGEMPRES21..Temp_Homologa where estado=1 order by codigo
--select * from DGEMPRES21..Temp_Homologa where item=1 order by codigo
--update DGEMPRES21..temp_homologa set estado = 1 where codigo in ('549','551','592','615','514')
--update DGEMPRES21..Temp_Homologa set ESTADO=2 where CODIGO in (542,545,602,603,604,606)--Manuales de Planes no utilizados
--update DGEMPRES21..Temp_Homologa set ESTADO=4 where CODIGO in (101,102,107,109,116)
--update DGEMPRES21..temp_homologa set estado = 1 where estado = 0
--update DGEMPRES21..Temp_Homologa set item = 1 where codigo='500'
--update DGEMPRES21..Temp_Homologa set item = NULL where consec=7
--update DGEMPRES21..Temp_Homologa set item = 1 where estado=1
-------------------------------------------Ingresar datos a mano
declare @servicio_old char(20) = '380702'
declare @servicio_new char(20) = '380702H'
declare @estado  int = 1--Or Item
declare @puntaje bigint = 0
declare @base    bigint = 378485
declare @tipo    bigint = 0---0= Valor Fijo y 1=Valor Base + Porcentaje
declare @id_old bigint, @id_new bigint, @precio bigint, @nombre nvarchar(MAX), @id_genmanser bigint
Select @id_old = OID from DGEMPRES01..GENSERIPS where SIPCODIGO=@servicio_old
Select @id_new = OID from DGEMPRES01..GENSERIPS where SIPCODIGO=@servicio_new
Select @nombre = SIPNOMBRE from DGEMPRES01..GENSERIPS where SIPCODIGO=@servicio_new

IF @tipo=0
	update DGEMPRES21..temp_homologa set val=@base
IF @tipo=1
	--update DGEMPRES21..temp_homologa set val=round((@base * valor),-2)--SOAT
	update DGEMPRES21..temp_homologa set val=round((@base * valor),0)--ISS
-----------------------------------------------------------------------------------------------------------------
BEGIN
	IF @id_new IS NULL
	BEGIN
		RAISERROR ('No existe el servicio Nuevo en la Tabla GENSERIPS', 11,1);
		RETURN ;
	END
	-------------------------------------------------------------------
	DECLARE @tarifas INT = (select max(tar.oid)
						 from DGEMPRES01..GENMANTAR tar inner join DGEMPRES01..GENMANSER ser on tar.genmanser1=ser.OID
			  /*Linea63*/where ser.GENSERIPS1=@id_new and ser.GENMANUAL1 in (select MAN from DGEMPRES21..Temp_Homologa where ITEM=1));--Item
				--where ser.GENSERIPS1=@id_new and ser.GENMANUAL1 in (select MAN from DGEMPRES21..Temp_Homologa where ESTADO=@estado));
	
	IF @tarifas IS NOT NULL
	BEGIN
		RAISERROR ('El servicio ya tiene registros en GENMANTAR', 11,1);
		RETURN ;
	END
	-----------------------------------------------------------------------------------------------------------------------------
	IF @puntaje > 0
		BEGIN
			insert into DGEMPRES01..GENPAQUET select @id_new, GENSERIPS2, SPACANSER, SPATIPSER, 0 from GENPAQUET where GENSERIPS1=@id_old
			update DGEMPRES01..GENSERIPS set SIPCODCUP=SIPCODIGO, SIPDESCUP=SIPNOMBRE where OID=@id_new
		END
	ELSE
		BEGIN
			update DGEMPRES01..GENSERIPS set SIPCODCUP=SIPCODIGO, SIPDESCUP=SIPNOMBRE where OID=@id_new
		END
	-----------------------------------------------------Cursor para INSERTAR GENMANSER, GENMANTAR, GENPLACUB
	declare @consec int, @codigo char(5), @valor BIGINT, @manual INT, @plantilla INT, @venta BIGINT
	-- Declaración del cursor
	DECLARE cantidades CURSOR FOR
		select th.CONSEC, th.CODIGO, th.VALOR, th.MAN, th.PLANT, th.VAL
		/*Linea 40*/from DGEMPRES21..temp_homologa th where th.ITEM = 1--Item
		--from DGEMPRES21..temp_homologa th where th.ESTADO = @estado
	-- Apertura del cursor
	OPEN cantidades
	-- Lectura de la primera fila del cursor
	FETCH NEXT FROM cantidades INTO @consec, @codigo, @valor, @manual, @plantilla, @venta
	WHILE(@@FETCH_STATUS= 0) 
		BEGIN 

		IF @codigo <> '615'
			BEGIN	
				insert into DGEMPRES01..GENMANSER(GENMANUAL1, GENSERIPS1, SMSCODSEE,     SMSNOMSEE, SMSPUNSER, SMSTIPLIQ, SMSLIQCOP, SMSINGAMB, SMSINGHOS, GENGRUQUI1, SMSPORDES, OptimisticLockField, SMSCANTV, SMSLIQCIR, SMSGECGREF)
										   values(@manual,    @id_new,    @servicio_new, @nombre,   @puntaje,  1,         1,         2,         1,         NULL,       0,         0,                   0,        0,         0)
			END
		ELSE
			BEGIN
				insert into DGEMPRES01..GENMANSER(GENMANUAL1, GENSERIPS1, SMSCODSEE,     SMSNOMSEE, SMSPUNSER, SMSTIPLIQ, SMSLIQCOP, SMSINGAMB, SMSINGHOS, GENGRUQUI1, SMSPORDES, OptimisticLockField, SMSCANTV, SMSLIQCIR, SMSGECGREF)
										   values(@manual,    @id_new,    @servicio_new, @nombre,   @puntaje,  2,         1,         2,         1,         NULL,       0,         0,                   0,        0,         0)
			END
        
		select @id_genmanser=OID from DGEMPRES01..GENMANSER WHERE GENMANUAL1=@manual and GENSERIPS1=@id_new
		
		IF @puntaje = 0
			BEGIN				
			insert into DGEMPRES01..GENMANTAR(GENMANSER1,    SMTFECINI,  SMTFECFIN,  SMTVALSER,                SMTVALREC,                GENSALMIN1, OptimisticLockField)
								       values(@id_genmanser, '20200901', '20210131', @venta, @venta, 1,         0)
			END
		ELSE
			BEGIN
			insert into DGEMPRES01..GENMANTAR(GENMANSER1,    SMTFECINI,  SMTFECFIN,  SMTVALSER, SMTVALREC, GENSALMIN1, OptimisticLockField)
                                       values(@id_genmanser, '20200901', '20210131', 0,         0,         1,         0)									   
			END
		
			insert into DGEMPRES01..GENPLACUB(GENPLAPRO1,    GENMANSER1,    GPCACTIVO,  OptimisticLockField, GPCATEADI, GPCPOS, GPCAUTORI)
		                           values(@plantilla,    @id_genmanser, 1,          0,                   0,         0,      0)

		FETCH NEXT FROM cantidades INTO @consec, @codigo, @valor, @manual, @plantilla, @venta
		-- Fin del bucle WHILE
		END
	-- Cierra el cursor
	CLOSE cantidades
	-- Libera los recursos del cursor
	DEALLOCATE cantidades
-----------------------------------------------------------------------------------------------------------------
END
-----------------------------------------------------------------------------------------------------------------