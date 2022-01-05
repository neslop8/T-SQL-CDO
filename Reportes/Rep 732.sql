-------------------------------------------------------------------------------------------------------------------
declare @ingreso char(10) = ''
declare @centro  char(10) = '02'
-------------------------------------------------------------------------------------------------------------------
select pac.pacnumdoc identificacion, ing.AINCONSEC ingreso, ing.AINFECING fec_ingreso
, cen.ACACODIGO cod, cen.ACANOMBRE centro
, case (ing.AINTIPING) when 1 then 'Amb' when 2 then 'Hos' else 'Otro' end Tipo
, RTRIM(pac.pacprinom)+' '+RTRIM(pac.pacsegnom)+' '+RTRIM(pac.pacpriape)+' '+RTRIM(pac.pacsegape) paciente
, ord.SOSORDSER orden, coalesce(ips.sipcodigo, prod.iprcodigo) codigo
, hoj.SERDESSER servicio, convert(bigint, hoj.SERCANTID) cantidad
, case(hoj.SERLIQREC) when 0 then 'NO' when 1 then 'SI' else 'otro' end recargo
, coalesce(cons.GCFCODIGO, conp.GCFCODIGO) cod_fac, coalesce(cons.GCFNOMBRE, conp.GCFNOMBRE) concepto_fac
, CONVERT(bigint, hoj.SERVALPRO) Valor_Manual, CONVERT(bigint, (hoj.SERVALENT + hoj.SERVALPAC)) Valor_Cobrado
from dgempres21..GENPACIEN pac  inner join dgempres21..ADNINGRESO ing on ing.GENPACIEN=pac.OID
inner join dgempres21..SLNORDSER ord on ord.ADNINGRES1=ing.OID
INNER JOIN dgempres21..ADNCENATE cen ON ing.ADNCENATE=cen.OID
inner join dgempres21..SLNSERPRO hoj on hoj.SLNORDSER1=ord.OID
left join dgempres21..SLNSERHOJ ser  on hoj.OID=ser.OID
left join dgempres21..SLNPROHOJ pro  on hoj.OID=pro.OID
left join dgempres21..GENSERIPS ips  on ser.GENSERIPS1=ips.OID
left join dgempres21..INNPRODUC prod on pro.INNPRODUC1=prod.OID
left join dgempres21..GENCONFAC cons on ips.GENCONFAC1=cons.OID
left join dgempres21..GENCONFAC conp on pro.GENCONFAC=conp.OID
where ing.AINESTADO in (0,3) and (ing.AINCONSEC=@ingreso or @ingreso='')
AND (cen.ACACODIGO = @centro or @centro='')
order by 3 asc
-------------------------------------------------------------------------------------------------------------------