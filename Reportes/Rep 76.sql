-----------------------------------------------------------------------------------------------------------------------------
declare @fch_inicio   datetime = '2019-13-11 00:00:00'
declare @fch_fin      datetime = '2019-14-11 23:59:59'
declare @medico       char(20) = ''
declare @especialidad char(20) = '008'
-----------------------------------------------------------------------------------------------------------------------------
SELECT i.ainconsec ingreso, i.ainfecing fch_ingreso, fs.hcnumfol fol_sol, fs.hcfecfol fch_folio
, th.hccodigo tipo_folio, p.pacnumdoc documento, cam.HCACODIGO cama
, RTRIM(p.pacprinom) + ' ' + RTRIM(p.pacsegnom) + ' ' + RTRIM(p.pacpriape) + ' ' + RTRIM(p.pacsegape) paciente
--, d.diacodigo dx_cod
, SUBSTRING(ic.hcimotivo, 1, 35) motivo, m.gmenomcom medico_nom, e.geedescri especialidad_nombre
, det.GDECODIGO contrato, det.GDENOMBRE entidad, fr.HCFECFOL fec_res, fr.hcnumfol fol_res
FROM DgEmpres21..hcninterc ic INNER JOIN DgEmpres21..hcnfolio fs ON ic.hcnfolio = fs.oid
INNER JOIN DgEmpres21..hcntiphis th  ON fs.hcntiphis = th.oid
INNER JOIN DgEmpres21..adningreso i  ON fs.adningreso = i.oid and i.GENPACIEN=fs.GENPACIEN
INNER JOIN DgEmpres21..genpacien p   ON i.genpacien = p.oid and fs.GENPACIEN=p.OID
--INNER JOIN DgEmpres21..gendiagno d	 ON ic.gendiagno = d.oid
INNER JOIN DgEmpres21..genmedico m   ON fs.genmedico = m.oid
INNER JOIN DgEmpres21..genareser a   ON ic.genareser = a.oid
INNER JOIN DgEmpres21..genespeci e   ON ic.genespeci = e.oid
INNER JOIN DgEmpres21..GENDETCON det ON i.GENDETCON=det.OID
LEFT JOIN DgEmpres21..HCNINTERR ric  on ic.OID=ric.HCNINTERC
LEFT JOIN DgEmpres21..hcnfolio fr    on ric.HCNFOLIO=fr.oid
LEFT JOIN DgEmpres21..HPNDEFCAM cam  on fr.HPNDEFCAM=cam.OID
WHERE fs.hcfecfol >= @fch_inicio
AND fs.hcfecfol <= @fch_fin
AND (m.gmecodigo = @medico OR @medico = '') 
AND (e.GEECODIGO = @especialidad OR @especialidad = '')
ORDER BY fs.hcfecfol
-----------------------------------------------------------------------------------------------------------------------------
--select top 5 HPNDEFCAM, * from HCNFOLIO order by OID desc
--select top 5 * from HCNINTERC order by OID desc
--select top 5 * from HCNINTERR order by OID desc
/*select * from GENPACIEN where PACNUMDOC='51630609'
select * from HCNFOLIO where GENPACIEN=938972 and OID=6969521
select * from GENESPECI where GEEDESCRI like '%nutri%'
select * from HCNINTERC where HCNFOLIO in (select OID from HCNFOLIO where GENPACIEN=938972) and GENESPECI=48*/
-----------------------------------------------------------------------------------------------------------------------------