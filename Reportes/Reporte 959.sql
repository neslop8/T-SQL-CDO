------------------------------------------------------------------------------------------------------------------
declare @fch_inicio datetime ='20170901'
declare @fch_fin    datetime ='20170930'
declare @ev_inicio int = 2
declare @ev_fin    int = 4
declare @clas_inicio int = 2
declare @clas_fin    int = 2
------------------------------------------------------------------------------------------------------------------
SELECT CDO02_21..f_tiempos_urgencias_216.*, pac.PACPRIAPE, pac.PACSEGAPE, pac.PACPRINOM, pac.PACSEGNOM
, ROUND((CONVERT (INT, GETDATE()) - CONVERT(INT, pac.gpafecnac)) / 365, 0) edad
FROM   CDO02_21..f_tiempos_urgencias_216(@fch_inicio, @fch_fin, @ev_inicio, @ev_fin , @clas_inicio, @clas_fin)
	INNER JOIN DGEMPRES21..ADNINGRESO ON f_tiempos_urgencias_216.ingreso=ADNINGRESO.OID
	INNER JOIN DGEMPRES21..GENPACIEN pac ON ADNINGRESO.GENPACIEN = pac.OID
------------------------------------------------------------------------------------------------------------------
