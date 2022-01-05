use DGEMPRES21
-----------------------------------------------------------------------------------------------------------------
/*select * from Temp_Homologa_Res
update Temp_Homologa_Res set valor=1
update Temp_Homologa_Res set valor=0 where oid_new in (35400, 35401)
update Temp_Homologa_Res set valor=0 where oid_new in (35402, 35403, 35404)*/
-----------------------------------------------------Cursor para INSERTAR GENMANSER, GENMANTAR, GENPLACUB
declare @cod_old char(8), @cod_new char(8), @val INT
-- Declaración del cursor
DECLARE servicios CURSOR FOR
select thr.cod_old, thr.cod_new, thr.valor
from DGEMPRES21..temp_homologa_res thr where valor>0
-- Apertura del cursor
OPEN servicios
-- Lectura de la primera fila del cursor
-- Lectura de la primera fila del cursor
FETCH NEXT FROM servicios INTO @cod_old, @cod_new, @val
WHILE(@@FETCH_STATUS= 0) 
BEGIN 
-------------------------------------------Ingresar datos a mano
		declare @servicio_old char(20) = @cod_old
		declare @servicio_new char(20) = @cod_new
		declare @puntaje bigint = 0
		declare @base   bigint =  @val
		update DGEMPRES21..temp_homologa set val=round((@base * valor),0)
		declare @id_old bigint, @id_new bigint, @precio bigint, @nombre nvarchar(MAX), @id_genmanser bigint
		Select @id_old = OID from DGEMPRES21..GENSERIPS where SIPCODIGO=@servicio_old
		Select @id_new = OID from DGEMPRES21..GENSERIPS where SIPCODIGO=@servicio_new
		Select @nombre = SIPNOMBRE from DGEMPRES21..GENSERIPS where SIPCODIGO=@servicio_new
		-----------------------------------------------------------------------------------------------------------------
		BEGIN
			IF @id_new IS NULL
			BEGIN
				RAISERROR ('No existe el servicio Nuevo en la Tabla GENSERIPS', 11,1);
				RETURN ;
			END
			-------------------------------------------------------------------
			DECLARE @tarifas INT = (select max(tar.oid)
								 from DGEMPRES21..GENMANTAR tar inner join DGEMPRES21..GENMANSER ser on tar.genmanser1=ser.OID
								 where ser.GENSERIPS1=@id_new);
	
			IF @tarifas IS NOT NULL
			BEGIN
				RAISERROR ('El servicio ya tiene registros en GENMANTAR', 11,1);
				RETURN ;
			END
			-----------------------------------------------------------------------------------------------------------------------------
			IF @puntaje > 0
				BEGIN
					insert into DGEMPRES21..GENPAQUET select @id_new, GENSERIPS2, SPACANSER, SPATIPSER, 0 from GENPAQUET where GENSERIPS1=@id_old
					update DGEMPRES21..GENSERIPS set SIPCODCUP=SIPCODIGO, SIPDESCUP=SIPNOMBRE where OID=@id_new
				END
			ELSE
				BEGIN
					update DGEMPRES21..GENSERIPS set SIPCODCUP=SIPCODIGO, SIPDESCUP=SIPNOMBRE where OID=@id_new
				END
			-----------------------------------------------------Cursor para INSERTAR GENMANSER, GENMANTAR, GENPLACUB
			declare @consec int, @codigo INT, @valor BIGINT, @manual INT, @plantilla INT, @venta BIGINT
			-- Declaración del cursor
			DECLARE cantidades CURSOR FOR
				select th.CONSEC, th.CODIGO, th.VALOR, th.MAN, th.PLANT, th.VAL
				from DGEMPRES21..temp_homologa th where th.estado = 1
			-- Apertura del cursor
			OPEN cantidades
			-- Lectura de la primera fila del cursor
			FETCH NEXT FROM cantidades INTO @consec, @codigo, @valor, @manual, @plantilla, @venta
			WHILE(@@FETCH_STATUS= 0) 
				BEGIN 

				insert into DGEMPRES21..GENMANSER(GENMANUAL1, GENSERIPS1, SMSCODSEE,     SMSNOMSEE, SMSPUNSER, SMSTIPLIQ, SMSLIQCOP, SMSINGAMB, SMSINGHOS, GENGRUQUI1, SMSPORDES, OptimisticLockField, SMSCANTV, SMSLIQCIR, SMSGECGREF)
										   values(@manual,    @id_new,    @servicio_new, @nombre,   @puntaje,  1,         1,         2,         1,         NULL,       0,         0,                   0,        0,         0)

				select @id_genmanser=OID from DGEMPRES21..GENMANSER WHERE GENMANUAL1=@manual and GENSERIPS1=@id_new
				--select top 5 * from temp_homologa
				--select top 5 * from DGEMPRES21..genmanser order by OID desc
				--select top 5 * from DGEMPRES21..genmantar order by OID desc
				--select top 5 * from DGEMPRES21..genplacub order by OID desc
				--select * from DGEMPRES21..temp_homologa

				IF @puntaje = 0
					BEGIN				
					insert into DGEMPRES21..GENMANTAR(GENMANSER1,    SMTFECINI,  SMTFECFIN,  SMTVALSER,                SMTVALREC,                GENSALMIN1, OptimisticLockField)
											   values(@id_genmanser, '20191101', '20200131', @venta, @venta, 12,         0)
					END
				ELSE
					BEGIN
					insert into DGEMPRES21..GENMANTAR(GENMANSER1,    SMTFECINI,  SMTFECFIN,  SMTVALSER, SMTVALREC, GENSALMIN1, OptimisticLockField)
											   values(@id_genmanser, '20191101', '20200131', 0,         0,         12,         0)									   
					END
		
				insert into DGEMPRES21..GENPLACUB(GENPLAPRO1,    GENMANSER1,    GPCACTIVO,  OptimisticLockField, GPCATEADI, GPCPOS, GPCAUTORI)
										   values(@plantilla,    @id_genmanser, 1,          0,                   0,         0,      0)

				FETCH NEXT FROM cantidades INTO @consec, @codigo, @valor, @manual, @plantilla, @venta
				-- Fin del bucle WHILE
				END
			-- Cierra el cursor
			CLOSE cantidades
			-- Libera los recursos del cursor
			DEALLOCATE cantidades
		END
	-----------------------------------------------------------------------------------------------------------------
		FETCH NEXT FROM servicios INTO @cod_old, @cod_new, @val
	-- Fin del bucle WHILE
END
-- Cierra el cursor
CLOSE servicios
-- Libera los recursos del cursor
DEALLOCATE servicios
-----------------------------------------------------------------------------------------------------------------
--END
-----------------------------------------------------------------------------------------------------------------
