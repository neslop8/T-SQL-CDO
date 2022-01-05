use dgempres21
--------------------------------------------------------------------------------------------------------------------------------------------
declare @fch_inicio datetime = '2016-15-07 00:00:00'
declare @fch_fin    datetime = '2016-31-07 23:59:59'
--------------------------------------------------------------------------------------------------------------------------------------------
SELECT p2.OID ,i.ainconsec ingreso, p.pacnumdoc documento, i.ainfecing fch_ingreso, f.hcfecfol fch_folio, f.hcnumfol folio
, RTRIM(p.pacprinom) + ' ' + RTRIM(p.pacsegnom) + ' ' + RTRIM(p.pacpriape) + ' ' + RTRIM(p.pacsegape) paciente 
, p2.HCCM09N31 ha_perdido, HCCM09N32 Cuanto, HCCM09N33 Falta_apetito, convert(tinyint, HCCM01N34) Riesgo
, SUBSTRING(cd.gdecodigo, 1, 6) contrato_cod  , SUBSTRING(cd.gdenombre, 1, 20) contrato_nom  
, SUBSTRING(m.gmenomcom, 1, 50) medico, esp.GEEDESCRI, cam.HCACODIGO cama, cam.HCANOMBRE nom_cama
, tel.pactelefono telefono  , SUBSTRING(m.gmenomcom, 1, 20) medico, dx.diacodigo codigo, dx.dianombre diagnostico
, ROUND((CONVERT (INT, GETDATE()) - CONVERT(INT, p.gpafecnac)) / 365, 0) as edad
FROM DgEmpres21..HCMP00002 p2 inner join DgEmpres21..hcnfolio f  on p2.HCNFOLIO=f.OID
inner JOIN DgEmpres21..genareser a   ON f.genareser  = a.oid  
inner JOIN DgEmpres21..adningreso i  ON f.adningreso = i.oid  
inner JOIN DgEmpres21..genpacien p   ON i.genpacien  = p.oid  
inner JOIN DgEmpres21..gendetcon cd  ON i.gendetcon  = cd.oid  
inner JOIN DgEmpres21..genmedico m   ON f.genmedico  = m.oid   
inner JOIN DgEmpres21..GENESPECI esp ON f.GENESPECI  = esp.OID
LEFT JOIN DgEmpres21..HPNDEFCAM cam  ON f.HPNDEFCAM  = cam.OID
LEFT JOIN dgempres21..genpacient tel ON tel.oid      = p.genpacient
left JOIN DgEmpres21..hcndiapac dp   ON f.oid        = dp.hcnfolio  and dp.HCPDIAPRIN=1
left JOIN DgEmpres21..gendiagno dx   ON dp.gendiagno = dx.oid
WHERE f.hcfecfol >= @fch_inicio         
AND f.hcfecfol <= @fch_fin         
ORDER BY 11 desc
--ORDER BY f.hcfecfol
--------------------------------------------------------------------------------------------------------------------------------------------
select * from HCNFOLIO where OID in (4337023, 4337080, 4337085, 4342394, 4346856)
select hccm09n31, hccm09n32, hccm09n33, hccm01n34, * from HCMP00002 where OID in (23673, 23674, 23671, 23715, 23756)
update HCMP00002 set OptimisticLockField=0 where OID in (23673)
update HCMP00002 set OptimisticLockField=0 where OID in (23674)
update HCMP00002 set OptimisticLockField=0 where OID in (23671)
update HCMP00002 set OptimisticLockField=0 where OID in (23715)
update HCMP00002 set OptimisticLockField=0 where OID in (23756)
--------------------------------------------------------------------------------------------------------------------------------------------