-----------------------------------------------------------------------------------------------------------------------------------
declare @fch_inicio  datetime = '2018-01-08 00:00:00'
declare @fch_fin     datetime = '2018-02-08 23:59:59'
declare @contrato    char(20) = ''
-----------------------------------------------------------------------------------------------------------------------------------
select pac.pacnumdoc as documento, ing.ainconsec as ingreso, fol.HCNUMFOL as folio
, RTRIM(pac.pacprinom)+' '+RTRIM(pac.pacsegnom)+' '+RTRIM(pac.pacpriape)+' '+RTRIM(pac.pacsegape) as ___________paciente__________
,sol.HCSFECSOL as ____fecha____, ips.SIPCODIGO as codigo, ips.SIPNOMBRE as __________servicio__________
, sol.HCSCANTI as cantidad, sol.HCSOBSERV as observacion
, det.gdecodigo codigo, det.gdenombre plan_beneficios, fol.OID folio, cam.hcacodigo cama
from dgempres21..hcnsolexa sol inner join dgempres21..genserips ips on sol.GENSERIPS=ips.OID
inner join dgempres21..ADNINGRESO ing on sol.ADNINGRESO=ing.OID 
inner join dgempres21..GENPACIEN  pac on ing.GENPACIEN=pac.OID
inner join dgempres21..HCNFOLIO   fol on sol.HCNFOLIO=fol.OID and fol.ADNINGRESO=ing.oid
inner join dgempres21..GENDETCON  det on ing.gendetcon = det.oid
left join dgempres21..HPNDEFCAM   cam on ing.HPNDEFCAM=cam.OID
where sol.GENARESER=154 and sol.HCNRESEXA is null
AND sol.hcsfecsol >= @fch_inicio
AND sol.hcsfecsol <= @fch_fin
AND (det.gdecodigo = @contrato or @contrato='')
order by sol.hcsfecsol
-----------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------