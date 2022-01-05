-----------------------------------------------------------------------------------------------------------------------------
declare @fch_inicio datetime = '2018-31-07 00:00:00'
declare @fch_fin    datetime = '2018-31-07 23:59:59'
-----------------------------------------------------------------------------------------------------------------------------
SELECT '6' AS TIPO_REGISTRO, ROW_NUMBER() OVER( ORDER BY ing.ainfecing) AS NUMERO_REGISTRO, ing.AINCONSEC ingreso
, CASE pac.PACTIPDOC when 1 then 'CC' when 2 then 'CE' when 3 then 'TI' when 4 then 'RC' when 5 then 'PA' 
		             when 6 then 'AS' when 7 then 'MS' when 8 then 'NU' when 9 then 'NI' when 10 then 'CD'  END AS TIPO_DOCUMENTO
,pac.PACNUMDOC NO_DOCUMENTO, pac.GPAFECNAC FECHA_NACIMIENTO
,CASE pac.GPASEXPAC when 1 then 'H' when 2 then 'M' when 3 then 'I' END AS GENERO, pac.pacpriape PRIMER_APELLIDO
, pac.pacsegape SEGUNDO_APELLIDO, pac.pacprinom PRIMER_NOMBRE, pac.pacsegnom SEGUNDO_NOMBRE, pla.GECCODIGO EAPB
--------------------------------------------------------------------------------------Triage
	,CASE WHEN  ISNULL(tri.hctfectri, ing.ainfecing) < COALESCE(p01.HCCM05N36, p09.HCCM05N08, pp1.HCCM05N22, pg1.HCCM05N46, pst.HCCM05N45)
		THEN ing.ainfecing--THEN asi_control_urgencia.fch_triage
		ELSE COALESCE(tri.hctfectri, p01.HCCM05N36, p09.HCCM05N08, pp1.HCCM05N22, pg1.HCCM05N46, pst.HCCM05N45)
		END AS FECHA_TRIAGE
	
	,CASE WHEN ISNULL(tri.hctfectri, ing.ainfecing) < COALESCE(p01.HCCM05N36, p09.HCCM05N08, pp1.HCCM05N22, pg1.HCCM05N46, pst.HCCM05N45)
		THEN SUBSTRING(CONVERT(VARCHAR(16), ISNULL(tri.hctfectri, ing.ainfecing),120),12,5)
		ELSE SUBSTRING(CONVERT(VARCHAR(16), COALESCE(tri.hctfectri, p01.HCCM05N36, p09.HCCM05N08, pp1.HCCM05N22, pg1.HCCM05N46, pst.HCCM05N45),120),12,5)
		END AS HORA_TRIAGE
--------------------------------------------------------------------------------------Atencion	
	,CASE WHEN ing.ainfecing > COALESCE(p01.HCCM05N36, HCCM05N08, HCCM05N22, pg1.HCCM05N46, pst.HCCM05N45)
		THEN ing.ainfecing--THEN asi_control_urgencia.fch_triage
		ELSE COALESCE(p01.HCCM05N36, p09.HCCM05N08, pp1.HCCM05N22, pg1.HCCM05N46, pst.HCCM05N45)
		END AS FECHA_ATENCION
	
	,CASE WHEN ing.ainfecing > COALESCE(p01.HCCM05N36, HCCM05N08, HCCM05N22, pg1.HCCM05N46, pst.HCCM05N45)
		THEN SUBSTRING(CONVERT(VARCHAR(16), ing.ainfecing,120),12,5)
		ELSE SUBSTRING(CONVERT(VARCHAR(16), COALESCE(p01.HCCM05N36, p09.HCCM05N08, pp1.HCCM05N22, pg1.HCCM05N46, pst.HCCM05N45),120),12,5)
		END AS HORA_ATENCION
----------------------------------------------------------------------------------------------------------------------------------
FROM    CDO02_21..asi_control_urgencia acu INNER JOIN DGEMPRES21..ADNINGRESO ing ON acu.ingreso = ing.OID --and acu.usuario_crea=0
		INNER JOIN DGEMPRES21..GENPACIEN pac	 ON acu.paciente = pac.OID
		INNER JOIN DGEMPRES21..HCNFOLIO          ON HCNFOLIO.ADNINGRESO = ing.OID
		INNER JOIN dgempres21..GENDETCON con	 ON con.OID = ing.GENDETCON
		INNER JOIN dgempres21..GENCONTRA pla	 ON pla.OID = con.GENCONTRA1
		left join dgempres21..hcntriage tri		 ON tri.adningreso=HCNFOLIO.ADNINGRESO 
		left join dgempres21..HCNCLAURGTR cla    ON tri.HCNCLAURGTR=cla.OID 
		left join DGEMPRES21..HCMP00001 p01      ON p01.HCNFOLIO=HCNFOLIO.OID and p01.HCCM05N36 is not null
		left join DGEMPRES21..HCMP00009 p09      ON p09.HCNFOLIO=HCNFOLIO.OID and p09.HCCM05N08 is not null
		left join DGEMPRES21..HCMP000P1 pp1      ON pp1.HCNFOLIO=HCNFOLIO.OID and pp1.HCCM05N22 is not null
		left join DGEMPRES21..HCMP0GIN1 pg1      ON pg1.HCNFOLIO=HCNFOLIO.OID and pg1.HCCM05N46 is not null
		left join DGEMPRES21..HCMP0SOAT pst      ON pst.HCNFOLIO=HCNFOLIO.OID and pst.HCCM05N45 is not null
WHERE   ing.ainfecing >= @fch_inicio
	AND ing.ainfecing <= @fch_fin
	AND acu.clasificacion = 2 
	AND ing.ainurgcon = 0 
	AND ing.ADNCENATE=1 
	AND HCNFOLIO.HCNTIPHIS not in (27)
	AND HCNFOLIO.HCNUMFOL = 1 
GROUP BY ing.AINCONSEC, pac.PACTIPDOC, pac.PACNUMDOC, pac.GPAFECNAC, pac.GPASEXPAC, pac.pacpriape, pac.pacsegape, pac.pacprinom
, pac.pacsegnom, pla.GECCODIGO, tri.hctfectri, ing.ainfecing, p01.HCCM05N36, p09.HCCM05N08, pp1.HCCM05N22, pg1.HCCM05N46, pst.HCCM05N45
-----------------------------------------------------------------------------------------------------------------------------old
-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
/*SELECT 
	'6' AS TIPO_REGISTRO
	,ROW_NUMBER() OVER( ORDER BY ADNINGRESO.ainfecing) AS NUMERO_REGISTRO 
	,CASE pac.PACTIPDOC
		when 1 then 'CC' 
		when 2 then 'CE' 
		when 3 then 'TI' 
		when 4 then 'RC' 
		when 5 then 'PA' 
		when 6 then 'AS' 
		when 7 then 'MS' 
		when 8 then 'NU' 
		when 9 then 'NI' 
		when 10 then 'CD'  END AS TIPO_DOCUMENTO
	,pac.PACNUMDOC NO_DOCUMENTO
	,pac.GPAFECNAC FECHA_NACIMIENTO
	,CASE pac.GPASEXPAC
		when 1 then 'H'
		when 2 then 'M'
		when 3 then 'I' END AS GENERO
	,pac.pacpriape PRIMER_APELLIDO
	,pac.pacsegape SEGUNDO_APELLIDO
	,pac.pacprinom PRIMER_NOMBRE
	,pac.pacsegnom SEGUNDO_NOMBRE
	,pla.GECCODIGO EAPB
	,CASE WHEN asi_control_urgencia.fch_triage < COALESCE(p01.HCCM05N36, HCCM05N08, HCCM05N22, pg1.HCCM05N46, pst.HCCM05N45)
		THEN asi_control_urgencia.fch_triage
		ELSE COALESCE(p01.HCCM05N36, HCCM05N08, HCCM05N22, pg1.HCCM05N46, pst.HCCM05N45)
		END AS FECHA_TRIAGE
	
	,CASE WHEN asi_control_urgencia.fch_triage < COALESCE(p01.HCCM05N36, HCCM05N08, HCCM05N22, pg1.HCCM05N46, pst.HCCM05N45)
		THEN SUBSTRING(CONVERT(VARCHAR(16),asi_control_urgencia.fch_triage,120),12,5)
		ELSE SUBSTRING(CONVERT(VARCHAR(16),COALESCE(p01.HCCM05N36, HCCM05N08, HCCM05N22, pg1.HCCM05N46, pst.HCCM05N45),120),12,5)
		END AS HORA_TRIAGE
	
	,CASE WHEN asi_control_urgencia.fch_triage > COALESCE(p01.HCCM05N36, HCCM05N08, HCCM05N22, pg1.HCCM05N46, pst.HCCM05N45)
		THEN asi_control_urgencia.fch_triage
		ELSE COALESCE(p01.HCCM05N36, HCCM05N08, HCCM05N22, pg1.HCCM05N46, pst.HCCM05N45)
		END AS FECHA_ATENCION
	
	,CASE WHEN asi_control_urgencia.fch_triage > COALESCE(p01.HCCM05N36, HCCM05N08, HCCM05N22, pg1.HCCM05N46, pst.HCCM05N45)
		THEN SUBSTRING(CONVERT(VARCHAR(16),asi_control_urgencia.fch_triage,120),12,5)
		ELSE SUBSTRING(CONVERT(VARCHAR(16),COALESCE(p01.HCCM05N36, HCCM05N08, HCCM05N22, pg1.HCCM05N46, pst.HCCM05N45),120),12,5)
		END AS HORA_ATENCION
FROM 
	CDO02_21..asi_control_urgencia 
		INNER JOIN DGEMPRES21..ADNINGRESO ON asi_control_urgencia.ingreso = ADNINGRESO.OID
		INNER JOIN DGEMPRES21..GENPACIEN pac ON asi_control_urgencia.paciente = pac.OID
		LEFT JOIN dgempres21..GENDETCON con on con.OID = ADNINGRESO.GENDETCON
		LEFT JOIN dgempres21..GENCONTRA pla on pla.OID = con.GENCONTRA1
		INNER JOIN DGEMPRES21..HCNFOLIO ON HCNFOLIO.ADNINGRESO = ADNINGRESO.OID
		left join dgempres21..hcntriage tri on tri.adningreso=HCNFOLIO.ADNINGRESO 
		left join dgempres21..HCNCLAURGTR cla on tri.HCNCLAURGTR=cla.OID 
		left join DGEMPRES21..HCMP00001 p01 on p01.HCNFOLIO=HCNFOLIO.OID and p01.HCCM05N36 is not null
		left join DGEMPRES21..HCMP00009 p09 on p09.HCNFOLIO=HCNFOLIO.OID and p09.HCCM05N08 is not null
		left join DGEMPRES21..HCMP000P1 pp1 on pp1.HCNFOLIO=HCNFOLIO.OID and pp1.HCCM05N22 is not null
		left join DGEMPRES21..HCMP0GIN1 pg1 on pg1.HCNFOLIO=HCNFOLIO.OID and pg1.HCCM05N46 is not null
		left join DGEMPRES21..HCMP0SOAT pst on pst.HCNFOLIO=HCNFOLIO.OID and pst.HCCM05N45 is not null
WHERE 
	ADNINGRESO.ainfecing >= @fch_inicio
	AND ADNINGRESO.ainfecing <= @fch_fin
	AND asi_control_urgencia.clasificacion = 2 
	AND ADNINGRESO.ainurgcon = 0 
	AND ADNINGRESO.ADNCENATE=1 
	AND HCNFOLIO.HCNTIPHIS not in (27)
	AND HCNFOLIO.HCNUMFOL = 1 
	AND coalesce(p01.HCCM05N36, HCCM05N08, HCCM05N22, pg1.HCCM05N46, pst.HCCM05N45) IS NOT NULL
GROUP BY 
	pac.PACTIPDOC
	,pac.PACNUMDOC
	,pac.GPAFECNAC
	,pac.GPASEXPAC
	,pac.pacpriape
	,pac.pacsegape
	,pac.pacprinom
	,pac.pacsegnom
	,pla.GECCODIGO
	,ADNINGRESO.ainfecing
	,asi_control_urgencia.fch_triage
	,HCNFOLIO.HCNUMFOL
	,coalesce(p01.HCCM05N36, HCCM05N08, HCCM05N22, pg1.HCCM05N46, pst.HCCM05N45)*/
-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------