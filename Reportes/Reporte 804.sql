------------------------------------------------------------------------------------------------------------------------------
declare @fch_inicio datetime = '2016-01-12 00:00:00'
declare @fch_fin    datetime = '2016-01-12 23:59:59'
declare @area       char(20) = 'DX-506'
declare @centro     char(20) = ''
------------------------------------------------------------------------------------------------------------------------------
select pac.pacnumdoc documento, ing.AINCONSEC ingreso, cen.ACACODIGO cod_cen
, RTRIM(pac.pacpriape)+' '+RTRIM(pac.pacsegape)+' '+RTRIM(pac.pacprinom)+' '+RTRIM(pac.pacsegnom) paciente
, fac.SFANUMFAC factura, fac.SFAFECFAC fecha, are.GASCODIGO area, are.GASNOMBRE Nom_area  , con.GECCODIGO contrato
, con.GECNOMENT entidad  , ips.SIPCODIGO Codigo_Mayor, ips.SIPNOMBRE Servicio_Mayor, ips1.SIPCODIGO Codigo_menor
, ips1.SIPNOMBRE Servicio_Menor, convert(bigint, pro.SERCANTID) cantidad
, convert(bigint, pro.SERVALENT)Val_ent, convert(bigint, pro.SERVALPAC)Val_pac
, convert(bigint, pro.SERVALENT + pro.SERVALPAC) Valor_Mayor, convert(bigint, paq.SPHVALSER) Valor_Menor
, CONVERT(bigint, pro.SERVALPRO) Val_H_T, case(pro.SERAPLPRO) when 0 then 'NO' when 1 then 'SI' end aplica
, case fac.sfadocanu when 0 then 'ACTIVA' when 1 then 'ANULADA' end Estado
, med.GMECODIGO Cod_Med, med.GMENOMCOM Medico, esp.GEEDESCRI Especialidad ,det.gdecodigo as plan_beneficios
from dgempres21..SLNFACTUR fac inner join dgempres21..ADNINGRESO ing on fac.ADNINGRESO=ing.OID  
inner join dgempres21..ADNCENATE cen on ing.ADNCENATE=cen.OID
inner join dgempres21..SLNSERPRO pro on pro.ADNINGRES1=ing.OID  
inner join dgempres21..GENPACIEN pac on ing.GENPACIEN=pac.OID  
inner join dgempres21..GENDETCON det on ing.GENDETCON=det.OID  
inner join dgempres21..GENCONTRA con on det.GENCONTRA1=con.OID  
inner join dgempres21..SLNSERHOJ ser on ser.OID=pro.OID  
inner join dgempres21..GENSERIPS ips on ser.GENSERIPS1=ips.OID  
inner join dgempres21..GENARESER are on ips.GENARESER1=are.OID  
inner join dgempres21..GENMEDICO med on pro.GENMEDICO1=med.OID
inner join dgempres21..GENESPECI esp on pro.DGNESPECI1=esp.OID
left join dgempres21..SLNPAQHOJ paq on paq.slnserhoj1=ser.OID and paq.GENARESER1=are.OID  
left join dgempres21..GENPAQUET paq1 on paq.GENPAQUET1=paq1.OID  
left join dgempres21..genserips ips1 on paq1.GENSERIPS2=ips1.OID  
where fac.SFAFECFAC >= @fch_inicio
and fac.SFAFECFAC <= @fch_fin
and (are.GASCODIGO = @area or @area = '')
and (cen.ACACODIGO = @centro or @centro='')
order by cen.ACACODIGO, fac.SFANUMFAC
------------------------------------------------------------------------------------------------------------------------------