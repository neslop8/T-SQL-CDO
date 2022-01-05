------------------------------------------------------------------------------------------------------------------------------
declare @fch_inicio datetime = '2014-01-01 00:00:00'
declare @fch_fin    datetime = '2015-31-12 23:59:59'
declare @MEDICO     char(20) = 'CEJIMENEZ'
------------------------------------------------------------------------------------------------------------------------------
select pac.pacnumdoc as documento, ing.AINCONSEC as ingreso
, RTRIM(pac.pacpriape)+' '+RTRIM(pac.pacsegape)+' '+RTRIM(pac.pacprinom)+' '+RTRIM(pac.pacsegnom) as paciente
, fac.SFANUMFAC as factura, fac.SFAFECFAC as fecha, are.GASCODIGO as area, are.GASNOMBRE as Nom_area
, con.GECCODIGO as contrato, con.GECNOMENT as entidad
, ips.SIPCODIGO sub_codigo, CONVERT(bigint, paq.SPHVALSER) val_sub
, case(ips1.SIPCLASER) when 1 then 'NINGUNO' when 2 then 'CIRUJANO' when 3 then 'ANESTESIOLOGO' when 4 then 'AYUDANTE' 
                       when 5 then 'SALA' when 6 then 'MATERIAL' when 7 then 'INSTRUMENTACION' else 'OTRO' END CLASE
, med.GMECODIGO as Cod_Medico, med.GMENOMCOM as Nom_Medico 
, ips.SIPCODIGO as codigo, ips.SIPNOMBRE as servicio
, convert(int, pro.SERCANTID) as cantidad, convert(int, pro.SERVALPRO) as valor_hon
from dgempres21..SLNFACTUR fac inner join dgempres21..ADNINGRESO ing on fac.ADNINGRESO=ing.OID
inner join dgempres21..SLNSERPRO pro on pro.ADNINGRES1=ing.OID
inner join dgempres21..GENPACIEN pac on ing.GENPACIEN=pac.OID
inner join dgempres21..GENDETCON det on ing.GENDETCON=det.OID
inner join dgempres21..GENCONTRA con on det.GENCONTRA1=con.OID
inner join dgempres21..SLNSERHOJ ser on ser.OID=pro.OID
left join DGEMPRES21..SLNPAQHOJ paq	on  paq.SLNSERPRO1=ser.OID 
inner join dgempres21..GENSERIPS ips on ser.GENSERIPS1=ips.OID
inner join dgempres21..GENARESER are on pro.GENARESER1=are.OID
inner join DGEMPRES21..GENMEDICO med on pro.GENMEDICO1=med.OID
left join DGEMPRES21..SLNPAQHOJ hojq on hojq.SLNSERPRO1=pro.OID
left join DGEMPRES21..GENPAQUET pdet	on paq.GENPAQUET1=pdet.OID
left join DGEMPRES21..GENSERIPS ips1	on pdet.GENSERIPS2=ips1.OID
where fac.SFAFECFAC >= @fch_inicio --and fac.SFANUMFAC='FV000003215866'
and fac.SFAFECFAC <= @fch_fin
and (med.GMECODIGO= @MEDICO or @MEDICO ='')
------------------------------------------------------------------------------------------------------------------------------