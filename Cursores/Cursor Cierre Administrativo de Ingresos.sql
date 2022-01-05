use DGEMPRES21
-----------------------------------------------------------------------------------------------------------------
/*select * from Temp_Homologa_Res
delete Temp_Homologa_Res
update Temp_Homologa_Res set valor=1
update Temp_Homologa_Res set valor=0 where oid_new in (35400, 35401)
update Temp_Homologa_Res set valor=0 where oid_new in (35402, 35403, 35404)*/

-----------------------------------------------------Cursor para INSERTAR GENMANSER, GENMANTAR, GENPLACUB
declare @ingres bigint
-- Declaración del cursor
DECLARE ingresos_cerrar CURSOR FOR
	select ing.OID
	from DGEMPRES01..adningreso ing inner join DGEMPRES01..gendetcon det on ing.gendetcon=det.oid
	where det.gdecodigo like '%26' and (ing.ainestado=0 or ing.AINESTADO=3) --and ing.AINFECING <= '2013-31-12')
	and ing.OID not in (select adningres1 from DGEMPRES01..slnordser where SOSESTADO in (0, 1) group by ADNINGRES1)
-- Apertura del cursor
OPEN ingresos_cerrar
-- Lectura de la primera fila del cursor
-- Lectura de la primera fila del cursor
FETCH NEXT FROM servicios INTO @ingres
WHILE(@@FETCH_STATUS= 0) 
BEGIN 
-------------------------------------------Ingresar datos a mano
	insert into DGEMPRES01..ADNCIADMIN (ACICONSEC, ADNINGRESO, ACIFECING, ACIMOTIVO, GEENUSUARIO, ADNESTADO, ADNMOTANU, ADNFECANUL,ADNUSUANUL)
	values(@consec, @ingres, GETDATE(), 'Control Post Quirurgico - Plan 26', 822, 1)	

	insert into DGEMPRES01..ADNINGHIS (ADNINGRESO, HISNOVEDAD, HISFECHA, GENUSUARIO, HISDOCUME, OptimisticLockField)
	values (@ingres, 11, GETDATE(), 822, 'Cierre de Ingreso por tramite administrativo', 69)
-----------------------------------------------------------------------------------------------------------------
		FETCH NEXT FROM ingresos_cerrar INTO @ingres
	-- Fin del bucle WHILE
END
-- Cierra el cursor
CLOSE ingresos_cerrar
-- Libera los recursos del cursor
DEALLOCATE ingresos_cerrar
-----------------------------------------------------------------------------------------------------------------
--END
--select * from dgempres02..ADNCIADMIN
select top 5 * from DGEMPRES02..ADNINGHIS order by oid desc
-----------------------------------------------------------------------------------------------------------------
