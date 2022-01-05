-----------------------------------------------------------------------------------------------------------------------
declare @fch_inicio datetime = '20210101'
declare @fch_fin datetime = '20211231'
-----------------------------------------------------------------------------------------------------------------------
SELECT ing.ainconsec Ingreso, pac.pacnumdoc Identificación, fol.HCNUMFOL Folio, RTRIM(LTRIM(pac.GPANOMCOM)) Paciente
, ROUND((CONVERT(INT, GETDATE()) - CONVERT(INT, pac.gpafecnac))/365, 0) Edad
, fol.hcfecfol Fecha_Consulta, d.diacodigo dx_cod, d.dianombre Diagnostico
, p1.hccm03n01 Motivo_Consulta
FROM dgempres01..hcnfolio fol INNER JOIN dgempres01..hcmp00001 p1 ON p1.hcnfolio = fol.oid
INNER JOIN dgempres01..adningreso ing ON fol.adningreso = ing.oid
INNER JOIN dgempres01..genpacien pac ON ing.genpacien = pac.oid
INNER JOIN dgempres01..hcndiapac dp ON dp.hcnfolio = fol.oid
INNER JOIN dgempres01..gendiagno d ON dp.gendiagno = d.oid
WHERE p1.HCCM09N42='SI'
AND fol.hcfecfol >= @fch_inicio 
AND fol.hcfecfol <= @fch_fin
-----------------------------------------------------------------------------------------------------------------------