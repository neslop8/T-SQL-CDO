select top 5 * from CDO02_21..rep_consulta where id=838
---------------------------------------------------------------------------------------------------------------------------------------
begin tran xxx
update CDO02_21..rep_consulta set query='
WITH Ult_Comp(producto, oid)
		AS
		(select INNPRODUC, max(oid) from dgempres01..INNMCOMPR group by INNPRODUC)

	select pro.iprcodigo as codigo, pro.iprcodalt as alterno, pro.iprdescor as producto
	, case(pro.IPRPROPOS) when 0 then ''No'' when 1 then ''Si'' else ''Otro'' end POS
	, case(pro.IPRBLOQUEO) when 0 then ''No'' when 1 then ''Si'' else ''Otro'' end Bloqueo
	, case(pro.IPCONTROL) when 0 then ''No'' when 1 then ''Si'' else ''Otro'' end Coontrol
	, case(IPRTIPPRO) when 1 then ''Suministro'' when 2 then ''Medicamento'' else ''Otro'' end Tipo, pro.iprconcen as concentracion
	, pro.iprregsan as reg_san, pro.iprcum as cum, convert(int,pro.iprcostpe) as cos_prom, convert(bigint, pro.iprulcope) as cos_ult
	, convert(bigint, pro.IPRPREVPE) as pre_ven, ter.GPRCODIGO as nit, ter.GPRNOMBRE as proveedor, ccom.ICCFECFAC as Fec_Ult_Com
	, convert(bigint, mcom.IMCVALUNI) as Val_Uni, convert(bigint, mcom.IMCPORIVA) as Iva, convert(bigint, mcom.IMCPORRET) as Ret
	, gru.IGRCODIGO as cod_gru, gru.IGRNOMBRE as grupo, sub.ISGCODIGO as cod_sub, sub.ISGNOMBRE as subgrupo
	, con.gcfcodigo as concepto, con.gcfnombre nombre_concepto
	, convert(bigint, ISNULL(cant.cant, 0)) cantidad
	, case(pro.IPRCLSRIEPRO) when 1 then ''Clase I'' when 2 then ''Clase IIa'' when 3 then ''Clase IIb'' 
							 when 4 then ''Clase III'' else ''Otro'' end Clasificacion
	, pro.IPRFECVENR fecha_ven_reg, uni.IUNCODIGO Cod_Unidad, uni.IUNUNICOM Unidad
	, case(pro.IPRMULTDOS)  when 0 then ''No'' when 1 then ''Si'' else ''Otro'' end Multidosis
	, convert(bigint, pro.IPRCANTDOS) Cantidad_Dosis 
	, unid.IUNCODIGO Cod_Uni_Multid, unid.IUNUNICOM Uni_Multid
	from dgempres01..innproduc pro inner join dgempres01..INNGRUPO gru on pro.IGRCODIGO=gru.OID
	inner join dgempres01..INNSUBGRU sub  on pro.ISGCODIGO=sub.OID
	inner join dgempres01..GENCONFAC con  on pro.genconfac=con.oid
	inner join dgempres01..INNUNIDAD uni  on pro.IUNCODIGO=uni.OID
	left join dgempres01..INNUNIDAD unid on pro.INNUNIDADD=unid.OID
	left join Ult_Comp UC on pro.OID=UC.producto
	left join dgempres01..INNMCOMPR mcom on UC.oid=mcom.OID
	left join dgempres01..INNCCOMPR ccom on mcom.INNCCOMPR=ccom.OID
	left join dgempres01..GENTERCERP ter on ccom.GENTERCERP=ter.OID
	CROSS APPLY CDO02_21..f_cant_existencia_producto_01(pro.oid) cant
	order by 1
' where id=838
commit tran xxx
---------------------------------------------------------------------------------------------------------------------------------------
--select top 5 * from INNPRODUC
---------------------------------------------------------------------------------------------------------------------------------------