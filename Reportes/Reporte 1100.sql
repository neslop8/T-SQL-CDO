WITH dxpac (oid, ingreso, fol_oid)
	AS
	(
		select ing.oid, ing.AINCONSEC, min(fol.oid)
		from dgempres21..hcnfolio fol inner join dgempres21..HCNDIAPAC dxp on dxp.HCNFOLIO=fol.OID
		inner join dgempres21..GENDIAGNO dx on dxp.GENDIAGNO=dx.OID
		inner join dgempres21..ADNINGRESO ing on fol.ADNINGRESO=ing.OID
		where dxp.HCPDIAPRIN=1 and ing.AINESTADO in (0,3)
		group by ing.oid, ing.AINCONSEC
	)
	,
	priest (ingreso, estancia)
	AS
	(
		select est.adningres, min(est.oid)
		from dgempres21..adningreso ing inner join dgempres21..hpnestanc est on  est.adningres=ing.oid
		where ing.AINESTADO in (0,3)
		group by est.adningres
	)
	
SELECT 
	RTRIM(CONVERT(char(6),ct.GECCODIGO)) Cod_Con
	--,cd.gdenombre
	,SUBSTRING(cd.gdenombre,1,CASE WHEN LEN(RTRIM(cd.gdenombre)) < 12 THEN LEN(RTRIM(cd.gdenombre)) ELSE LEN(RTRIM(cd.gdenombre)) -12 END) Contrato_nom
	,p.pacnumdoc documento
	,RTRIM(p.pacpriape) apellido1
	,RTRIM(p.pacsegape) apellido2
	,RTRIM(p.pacprinom) nombre1
	,RTRIM(p.pacsegnom) nombre2
	,i.AINCONSEC as ingreso
	,i.AINFEChos as fec_ing_cama
	,c.hcacodigo cama_cod
	,dig.DIACODIGO as cod_dx
	,dig.DIANOMBRE as nom_dx
	,ROUND(CONVERT(INT, GETDATE()) - CONVERT(INT, i.ainfechos), 1) AS dias_U_C
	,ROUND(CONVERT(INT, GETDATE()) - CONVERT(INT, e1.hesfecing), 1) AS dias_T
	,ROUND((CONVERT (INT, GETDATE()) - CONVERT(INT, p.gpafecnac)) / 365, 0) as edad
	,CASE i.aincauing
		WHEN '0' THEN 'NINGUNA' 
		WHEN '1' THEN 'ENFERMEDAD PROFESIONAL' 
		WHEN '2' THEN 'HERIDO EN COMBATE' 
		WHEN '3' THEN 'ENFERMEDAD GENERAL ADULTO' 
		WHEN '4' THEN 'ENFERMEDAD GENERAL PEDIATRIA' 
		WHEN '5' THEN 'ODONTOLOGIA' 
		WHEN '6' THEN 'ACCIDENTE DE TRANSITO' 
		WHEN '7' THEN 'FISALUD' 
		WHEN '8' THEN 'QUEMADOS' 
		WHEN '9' THEN 'MATERNIDAD' 
		WHEN '10' THEN 'ACCIDENTE LABORAL' 
		WHEN '11' THEN 'CIRUGIA PROGRAMADA' END AS CAUSA_INGRESO
	,CASE p.pactipdoc
		WHEN '1' THEN 'CC' 
		WHEN '2' THEN 'CE' 
		WHEN '3' THEN 'TI' 
		WHEN '4' THEN 'RC' 
		WHEN '5' THEN 'PAS' 
		WHEN '6' THEN 'ASI' 
		WHEN '7' THEN 'MSI' 
		WHEN '8' THEN 'NUIP' END AS TIPO_DOCUMENTO
	,CASE WHEN month(p.gpafecnac) = month(getdate()) and year(p.gpafecnac) < year(getdate()) THEN 
		CASE datediff(day, day(getdate()),day(p.gpafecnac))
			WHEN -1 THEN 'Ayer'
			WHEN 0 THEN 'Hoy'
			WHEN 1 THEN 'Mañana'
			WHEN 2 THEN 'Pasado Mañana'
			ELSE NULL
		END
	ELSE NULL END AS CUMPLEAÑOS
	,ROUND((CONVERT (INT, GETDATE()) - CONVERT(INT, p.gpafecnac)) / 365, 0) as edad
	,i.AINFECING fec_ing
	,e1.HESFECING fec_pri_est
	, CONVERT(bigint, cab.SCOTOTPAC) Neto_Paciente, CONVERT(bigint,cab.SCOTOTENT) Neto_Entidad---Cabecera de la Hoja de Trabajo, diferencia 
	, convert(bigint, valor.valor)valor_calculado
FROM 
	DGEMPRES21..hpnestanc e 
	INNER JOIN DGEMPRES21..adningreso i ON e.adningres = i.oid
	INNER JOIN DGEMPRES21..genpacien p ON i.genpacien = p.oid
	INNER JOIN DGEMPRES21..hpndefcam c ON e.hpndefcam = c.oid 
	INNER JOIN DGEMPRES21..gendetcon cd ON i.gendetcon = cd.oid
	INNER JOIN DGEMPRES21..GENCONTRA ct ON cd.GENCONTRA1=ct.OID
	INNER JOIN dxpac dx ON dx.oid=e.ADNINGRES
	INNER JOIN dgempres21..HCNDIAPAC dxp ON dxp.HCNFOLIO=dx.fol_oid
	INNER JOIN dgempres21..GENDIAGNO dig ON dxp.GENDIAGNO=dig.OID
	LEFT JOIN DGEMPRES21..SLNCONHOJ cab ON cab.ADNINGRES1 = i.OID---Cabecera de la Hoja de Trabajo, diferencia 
	LEFT JOIN priest pri ON pri.ingreso=i.oid
	INNER JOIN dgempres21..hpnestanc e1 on pri.estancia=e1.oid
	CROSS APPLY DGEMPRES21..f_censo_valorizado_ingreso (i.OID) valor
WHERE 
	(e.hesfecsal IS NULL) 
	AND dxp.HCPDIAPRIN=1
	--AND (e.hestipoes = 1)
	AND c.HCAESTADO=2
	--and i.AINCONSEC=2019761
	/*and month(p.gpafecnac) = month(getdate())
	and abs(datediff(day, day(p.gpafecnac), day(getdate()))) <= 3
	and year(p.gpafecnac) < year(getdate())*/
ORDER BY 1


