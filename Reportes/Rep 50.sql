------------------------------------------------------------------------------------------------------
declare @fch_inicio datetime = '20211101'
declare @fch_fin datetime = '20211130'
------------------------------------------------------------------------------------------------------
SELECT ROW_NUMBER() OVER(Order by esp.GEECODIGO, E.Frecuencia desc) #_Total
, ROW_NUMBER() OVER(Partition by esp.GEECODIGO Order by E.Frecuencia desc) #_Especialidad
, esp.GEECODIGO Codigo, esp.GEEDESCRI Especialidad, E.DX, E.Diagnostico, E.Frecuencia
FROM DGEMPRES01..GENESPECI esp
CROSS APPLY
(
	select top 9 dxi.diacodigo DX, dxi.dianombre Diagnostico, COUNT(*) Frecuencia
	FROM 
	DgEmpres01..hcnfolio fol INNER JOIN DgEmpres01..HCNDIAPAC di ON di.HCNFOLIO = fol.oid
	INNER JOIN DGEMPRES01..GENDIAGNO dxi ON di.GENDIAGNO = dxi.oid
	WHERE fol.GENESPECI=esp.OID AND
	fol.HCFECFOL >= @fch_inicio AND
	fol.HCFECFOL <= @fch_fin
	GROUP BY
	dxi.diacodigo, dxi.dianombre
	ORDER BY COUNT(*) desc
) as E 
Order by esp.GEECODIGO, E.Frecuencia desc
------------------------------------------------------------------------------------------------------