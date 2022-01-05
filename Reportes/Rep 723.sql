-------------------------------------------------------------------------------------------------------------------------
declare @fch_inicio  datetime = '2021-28-01 00:00:00'
declare @fch_fin     datetime = '2021-28-01 23:59:59'
declare @contrato   char(10)= 'EPS01701'
declare @facturacion char(10)= 'FE0001084680'
declare @area        char(10)= ''
-------------------------------------------------------------------------------------------------------------------------
select ord.SOSORDSER orden, convert(date, ord.SOSFECORD, 107) fec_orden, pac.PACNUMDOC documento, ing.AINCONSEC Ingreso
, RTRIM(LTRIM(pac.gpanomcom)) paciente
, fac.SFANUMFAC Factura, convert(date, fac.sfafecfac, 107) fecha_factura
, case(ser.SERAPLPRO) when 0 then 'NO' when 1 then 'SI' end aplica
, CONVERT(int, ser.SERCANTID) Cantidad, CONVERT(int, ser.SERVALPRO) Valor
, det.GDECODIGO Cod_Plan, det.GDENOMBRE as Plan_Beneficios
, ares.GASCODIGO Area_Solicita, arep.GASCODIGO Area_Presta, convert(date, ser.SERFECSER, 107) fec_Servicio
, coalesce (cons.gcfcodigo, conp.gcfcodigo) cod_concepto1, coalesce (cons.gcfnombre, conp.gcfnombre) concepto
, case(prod.IPRTIPPRO) when 1 then 'Suministro' when 2 then 'Medicamento' else 'Servicio' end Tipo
, coalesce (ips.SIPCODIGO, prod.IPRCODIGO) codigo , coalesce (ips.SIPNOMBRE, prod.IPRDESCOR) nombre
, gru.IGRCODIGO as cod_gru, gru.IGRNOMBRE as grupo, sub.ISGCODIGO as cod_sub, sub.ISGNOMBRE as subgrupo
, case(fac.SFADOCANU) when 0 then 'Activa' when 1 then 'Anulada' else 'otro' end estado, usu.USUNOMBRE Usu_fac
, cona.gcfcodigo cod_concepto2, cona.gcfnombre concepto_al_que_aplica
, ips2.SIPCODIGO Cod_Ser_Apl, ips2.SIPNOMBRE Servicio_Aplica
from DGEMPRES01..SLNSERPRO ser inner join DGEMPRES01..ADNINGRESO ing on ser.ADNINGRES1=ing.OID and ser.SERAPLPRO=1
inner join DGEMPRES01..GENPACIEN pac  on ing.GENPACIEN=pac.OID
inner join DGEMPRES01..SLNORDSER ord  on ser.SLNORDSER1=ord.OID and ord.sosestado<>2
inner join DGEMPRES01..GENARESER ares on ord.GENARESER1=ares.OID
inner join DGEMPRES01..GENARESER arep on ser.GENARESER1=arep.OID
inner join DGEMPRES01..GENDETCON det  on ser.GENDETCON1=det.OID 
left join DGEMPRES01..SLNFACTUR fac   on fac.ADNINGRESO=ing.OID 
left join DGEMPRES01..GENUSUARIO usu  on fac.GENUSUARIO1=usu.OID
left join DGEMPRES01..SLNSERHOJ hoj   on ser.OID=hoj.OID
left join DGEMPRES01..SLNPROHOJ pro   on ser.OID=pro.OID
left join DGEMPRES01..INNPRODUC prod  on pro.INNPRODUC1=prod.OID
left join DGEMPRES01..GENSERIPS ips   on hoj.GENSERIPS1=ips.OID
left join DGEMPRES01..GENCONFAC cons  on ips.genconfac1=cons.OID
left join DGEMPRES01..GENCONFAC conp  on prod.genconfac=conp.OID
left join DGEMPRES01..SLNSERHOJ apl   on ser.GENSERIPS2=apl.OID
left join DGEMPRES01..GENSERIPS ips2  on apl.GENSERIPS1=ips2.OID
left join DGEMPRES01..GENCONFAC cona  on ips2.genconfac1=cona.OID
left join dgempres01..INNGRUPO gru    on prod.IGRCODIGO=gru.OID
left join dgempres01..INNSUBGRU sub   on prod.ISGCODIGO=sub.OID
where ser.SERFECSER >= @fch_inicio and
      ser.SERFECSER <= @fch_fin and
      (det.GDECODIGO = @contrato or @contrato='') and
      (arep.GASCODIGO = @area or @area='') 
	  --and fac.adningreso in (81375)
order by ing.AINCONSEC
-------------------------------------------------------------------------------------------------------------------------