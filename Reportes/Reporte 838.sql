--------------------------------------------------------------------------------------------------------------------------------
select top 5 * from CDO02_21..rep_consulta where id = 838
--------------------------------------------------------------------------------------------------------------------------------
update CDO02_21..rep_consulta set query=
--------------------------------------------------------------------------------------------------------------------------------
'WITH Ult_Comp(producto, oid)
	AS
	(
		select INNPRODUC, max(oid) from dgempres21..INNMCOMPR group by INNPRODUC
	)

select pro.iprcodigo as codigo, pro.iprcodalt as alterno, pro.iprdescor as producto
, case(pro.IPRPROPOS) when 0 then ''No'' when 1 then ''Si'' else ''Otro'' end POS
, case(IPRTIPPRO) when 1 then ''Sum'' when 2 then ''Med'' else ''Otro'' end Tipo, pro.iprconcen as concentracion
, pro.iprregsan reg_san, pro.IPRFECVENR fec_reg_san, pro.iprcum as cum, convert(int,pro.iprcostpe) as cos_prom, convert(int,pro.iprulcope) as cos_ult
, convert(int,pro.IPRPREVPE) as pre_ven, ter.GPRCODIGO as nit, ter.GPRNOMBRE as proveedor, ccom.ICCFECFAC as Fec_Ult_Com
, convert(int,mcom.IMCVALUNI) as Val_Uni, convert(int,mcom.IMCPORIVA) as Iva, convert(int,mcom.IMCPORRET) as Ret
, gru.IGRCODIGO as cod_gru, gru.IGRNOMBRE as grupo, sub.ISGCODIGO as cod_sub, sub.ISGNOMBRE as subgrupo
, con.gcfcodigo as concepto, con.gcfnombre nombre_concepto
from dgempres21..innproduc pro left join Ult_Comp UC on pro.OID=UC.producto
left join dgempres21..INNMCOMPR mcom on UC.oid=mcom.OID
left join dgempres21..INNCCOMPR ccom on mcom.INNCCOMPR=ccom.OID
left join dgempres21..GENTERCERP ter on ccom.GENTERCERP=ter.OID
left join dgempres21..INNGRUPO gru on pro.IGRCODIGO=gru.OID
left join dgempres21..INNSUBGRU sub on pro.ISGCODIGO=sub.OID
left join dgempres21..GENCONFAC con on pro.genconfac=con.oid
order by 1'
where id = 838
--------------------------------------------------------------------------------------------------------------------------------