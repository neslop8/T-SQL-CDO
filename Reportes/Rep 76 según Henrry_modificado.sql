--------------------------------------------------------------------------------------------------------------------------
declare @fch_inicio   datetime = '2020-01-03 00:00:00'
declare @fch_fin      datetime = '2020-10-03 23:59:59'
declare @medico       char(20) = ''
declare @especialidad char(20) = '047'
--------------------------------------------------------------------------------------------------------------------------
SELECT i.ainconsec ingreso, i.ainfecing fch_ingreso
	,CASE i.ainurgcon WHEN 0 THEN 'URGENCIAS' WHEN 1 THEN 'CONSULTA EXTERNA' WHEN 2 THEN 'NACIDO' WHEN 3 THEN 'REMITIDO' WHEN 4 THEN 'HOSPITALIZACION URGENCIAS' 
		WHEN 5 THEN 'HOSPITALIZACION' WHEN 6 THEN 'IMAGENES' WHEN 7 THEN 'LABORATORIO' ELSE 'OTRO' END AS Ingreso_Por
	,CASE i.AINTIPING WHEN 1 THEN 'AMBULATORIO' WHEN 2 THEN 'HOSPITALARIO' END AS Tipo_Ingreso
	,CASE i.AINTIPRIE 
		WHEN 0 THEN 'NINGUNA'
		WHEN 1 THEN 'ACCIDENTE DE TRANSITO'
		WHEN 2 THEN 'CATASTROFE'
		WHEN 3 THEN 'ENFERMEDAD GENERAL Y MATERNIDAD'
		WHEN 4 THEN 'ACCIDENTE DE TRABAJO'
		WHEN 5 THEN 'ENFERMEDAD PROFESIONAL'
		WHEN 6 THEN 'ATENCIÓN INICIAL DE URGENCIAS'
		WHEN 7 THEN 'OTRO TIPO DE ACCIDENTE'
		WHEN 8 THEN 'LESIÓN POR AGRESIÓN'
		WHEN 9 THEN 'LESIÓN AUTOINFLIGIDA'
		WHEN 10 THEN 'MALTRATO FISICO'
		WHEN 11 THEN 'PROMOCIÓN Y PREVENCIÓN'
		WHEN 12 THEN 'OTRO'
		WHEN 13 THEN 'ACCIDENTE RABICO'
		WHEN 14 THEN 'ACCIDENTE OFIDICO'
		WHEN 15 THEN 'SOSPECHA DE ABUSO SEXUAL'
		WHEN 16 THEN 'SOSPECHA DE VIOLENCIA SEXUAL'
		WHEN 17 THEN 'SOSPECHA DE MALTRATO EMOCIONAL'
		END AS TIPO_RIESGO
	, fs.hcnumfol fol_sol, fs.hcfecfol fch_folio, YEAR(fs.hcfecfol) año_sol, MONTH(fs.hcfecfol) mes_sol
	, th.hccodigo tipo_folio, p.pacnumdoc documento
	, REPLACE(REPLACE(REPLACE(RTRIM(p.pacprinom) + ' ' + RTRIM(p.pacsegnom) + ' ' + RTRIM(p.pacpriape) + ' ' + RTRIM(p.pacsegape),CHAR(9),' '),CHAR(10),' '),CHAR(13),' ') paciente
	,CONVERT(VARCHAR(10),p.GPAFECNAC,120) AS FECHA_NACIMIENTO, DATEDIFF(YY,p.GPAFECNAC,GETDATE()) AS EDAD
	,CASE p.GPASEXPAC
		WHEN 1 THEN 'H'
		WHEN 2 THEN 'M'
		WHEN 3 THEN 'I' END AS SEXO
	,REPLACE(REPLACE(REPLACE(GENOCUPACION.DGONOMBRE,CHAR(9),' '),CHAR(10),' '),CHAR(13),' ') AS OCUPACION
	,CASE p.GPATIPPAC
		WHEN 0 THEN 'NINGUNO'
		WHEN 1 THEN 'CONTRIBUTIVO'
		WHEN 2 THEN 'SUBSIDIADO'
		WHEN 3 THEN 'VINCULADO'
		WHEN 4 THEN 'PARTICULAR'
		WHEN 5 THEN 'OTRO'
		WHEN 6 THEN 'DESPLAZADO REGIMEN CONTRIBUTIVO'
		WHEN 7 THEN 'DESPLAZADO REGIMEN SUBSIDIADO'
		WHEN 8 THEN 'DESPLAZADO NO ASEGURADO' END AS REGIMEN
	, case ic.HCPRIINTER WHEN 1 THEN 'Urgente' WHEN 2 THEN 'Prioritario' WHEN 3 THEN 'Regular' ELSE 'Ninguno' END Prioridad
	, REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(ic.hcimotivo,CHAR(9),' '),CHAR(10),' '),CHAR(13),' '),'"',' '),'''',' ') motivo
	, REPLACE(REPLACE(REPLACE(m.gmenomcom,CHAR(9),' '),CHAR(10),' '),CHAR(13),' ') medico_nom
	, REPLACE(REPLACE(REPLACE(e.geedescri,CHAR(9),' '),CHAR(10),' '),CHAR(13),' ') especialidad_nombre
	, det.GDECODIGO contrato
	, REPLACE(REPLACE(REPLACE(det.GDENOMBRE,CHAR(9),' '),CHAR(10),' '),CHAR(13),' ') entidad
	, Rpta.HCFECFOL fec_res
	, DATENAME(dw,Rpta.HCFECFOL) dia_res
	, CONVERT(VARCHAR,CONVERT(NUMERIC(15,2),(DATEDIFF(MINUTE, fs.hcfecfol, Rpta.HCFECFOL) / 60.00))) Oport_horas
	, CONVERT(VARCHAR,CONVERT(NUMERIC(15,2),(DATEDIFF(SECOND, fs.hcfecfol, Rpta.HCFECFOL) / 60.00))) Oport_minutos
	, Rpta.hcnumfol fol_res
        , Rpta.Tip_His_Rpta
	, CASE WHEN Rpta.hcnumfol IS NULL THEN 'NO' ELSE 'SI' END Rpta
	, REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Rpta.HCCM03N01,CHAR(9),' '),CHAR(10),' '),CHAR(13),' '),'"',' '),'''',' ') Diagnostico_y_Analisis_Subjetivo
	, REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Rpta.HCCM03N02,CHAR(9),' '),CHAR(10),' '),CHAR(13),' '),'"',' '),'''',' ') Analisis_Objetivo
	, REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Rpta.HCCM03N15,CHAR(9),' '),CHAR(10),' '),CHAR(13),' '),'"',' '),'''',' ') Paraclinicos
	, REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Rpta.HCCM03N16,CHAR(9),' '),CHAR(10),' '),CHAR(13),' '),'"',' '),'''',' ') Dieta
	, REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(Rpta.HCCM03N29,CHAR(9),' '),CHAR(10),' '),CHAR(13),' '),'"',' '),'''',' ') Justificacion_Hospitalizacion
FROM 
	DgEmpres21..hcninterc ic INNER JOIN DgEmpres21..hcnfolio fs ON ic.hcnfolio = fs.oid
	INNER JOIN DgEmpres21..hcntiphis th  ON fs.hcntiphis = th.oid
	INNER JOIN DgEmpres21..adningreso i  ON fs.adningreso = i.oid
	INNER JOIN DgEmpres21..genpacien p   ON i.genpacien = p.oid
	--INNER JOIN DgEmpres21..gendiagno d	 ON ic.gendiagno = d.oid
	INNER JOIN DgEmpres21..genmedico m   ON fs.genmedico = m.oid
	INNER JOIN DgEmpres21..genareser a   ON ic.genareser = a.oid
	INNER JOIN DgEmpres21..genespeci e   ON ic.genespeci = e.oid
	INNER JOIN DgEmpres21..GENDETCON det ON i.GENDETCON=det.OID
	LEFT JOIN DGEMPRES21..GENOCUPACION ON GENOCUPACION.OID = p.GENOCUPACION
OUTER APPLY (
	SELECT TOP 1
		cam.HCACODIGO 
		,fr.HCFECFOL
		,fr.hcnumfol
		,c2.HCCM03N01
		,c2.HCCM03N02
		,c2.HCCM03N15
		,c2.HCCM03N16
		,c2.HCCM03N29
                ,tiphis.hccodigo Tip_His_Rpta
	FROM 
		DgEmpres21..HCNINTERR ric  
			LEFT JOIN DgEmpres21..hcnfolio fr    on ric.HCNFOLIO=fr.oid
			LEFT JOIN DgEmpres21..HPNDEFCAM cam  on fr.HPNDEFCAM=cam.OID
			LEFT JOIN DgEmpres21..hcmc00002 c2		ON c2.hcnfolio = fr.oid
                        LEFT JOIN DgEmpres21..hcntiphis tiphis ON tiphis.OID = fr.hcntiphis
	WHERE ic.OID=ric.HCNINTERC 
	ORDER BY ric.OID DESC) AS Rpta
WHERE 
	fs.hcfecfol >= @fch_inicio
	AND fs.hcfecfol <= @fch_fin
--	AND e.GEECODIGO = '048'
	AND (m.gmecodigo = @medico OR @medico = '') 
	AND (e.GEECODIGO = @especialidad OR @especialidad = '')
ORDER BY fs.hcfecfol
--------------------------------------------------------------------------------------------------------------------------
