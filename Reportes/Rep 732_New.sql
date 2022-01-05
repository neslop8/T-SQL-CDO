declare @ingreso char(10)= 152807
select coalesce(cons.GCFCODIGO, conp.GCFCODIGO) cod_fac, coalesce(cons.GCFNOMBRE, conp.GCFNOMBRE) concepto_fac
, ord.SOSORDSER orden, ord.SOSFECORD fecha_orden
, pac.pacnumdoc identificacion, ing.AINCONSEC ingreso, ing.AINFECING fec_ingreso
, cen.ACACODIGO cod, cen.ACANOMBRE centro
, case (ing.AINTIPING) when 1 then 'Amb' when 2 then 'Hos' else 'Otro' end Tipo
, RTRIM(pac.pacprinom)+' '+RTRIM(pac.pacsegnom)+' '+RTRIM(pac.pacpriape)+' '+RTRIM(pac.pacsegape) paciente
, coalesce(ips.sipcodigo, prod.iprcodigo) codigo
, hoj.SERDESSER servicio, prod.IPRCUM CUM
, convert(bigint, hoj.SERCANTID) cantidad
, CONVERT(bigint, hoj.SERVALPRO) Valor_Manual, CONVERT(bigint, (hoj.SERVALENT + hoj.SERVALPAC)) Valor_Cobrado
from dgempres01..GENPACIEN pac  INNER JOIN dgempres01..ADNINGRESO ing on ing.GENPACIEN=pac.OID
INNER JOIN dgempres01..SLNORDSER ord on ord.ADNINGRES1=ing.OID
INNER JOIN dgempres01..ADNCENATE cen ON ing.ADNCENATE=cen.OID
INNER JOIN dgempres01..SLNSERPRO hoj on hoj.SLNORDSER1=ord.OID
left join dgempres01..SLNSERHOJ ser  on hoj.OID=ser.OID
left join dgempres01..SLNPROHOJ pro  on hoj.OID=pro.OID and pro.GENCONFAC in (36)
left join dgempres01..GENSERIPS ips  on ser.GENSERIPS1=ips.OID and ips.GENCONFAC1 in (41, 42, 43)
left join dgempres01..INNPRODUC prod on pro.INNPRODUC1=prod.OID
left join dgempres01..GENCONFAC cons on ips.GENCONFAC1=cons.OID 
left join dgempres01..GENCONFAC conp on pro.GENCONFAC=conp.OID
where --ing.AINESTADO in (0,3) and 
(ing.AINCONSEC=@ingreso)
order by 1 desc, 4 asc