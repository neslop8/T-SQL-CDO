--------------------------------------------------------------------------------------------------------------------------------
declare @fch_inicio  datetime = '2020-15-12 00:00:00'
declare @fch_fin     datetime = '2020-15-12 23:59:59'
declare @contrato   char(10)= ''
declare @area       char(10)= ''
declare @servicio   char(10)= ''
--------------------------------------------------------------------------------------------------------------------------------
SELECT p.pacnumdoc AS paciente_doc, RTRIM(LTRIM(p.GPANOMCOM)) paciente, i.ainconsec ingreso
	,case(i.AINTIPING) when 1 then 'amb' when 2 then 'hos' else 'otro' end tipo
	,case i.AINURGCON when 0 then 'URGENCIAS'when 1 then 'CONS EXTERNA 'when 2 then 'NACIDO HOSPI '
		when 3 then ' REMITIDO'when 4 then 'HOSP URGENCIAS 'when 5 then 'HOSPITALIZADO ' end AS CLASE  
	,cam.HCACODIGO cama, f.hcnumfol folio, si.sipcodigo examen_cod, si.sipnombre examen_nom, s.HCSCANTI cantidad
	,s.hcsfecsol fch_solicitud, r.hcrfecres fch_resultado, DATEDIFF(MINUTE, s.hcsfecsol, r.hcrfecres) tiempo
	,r.hcrdescrip descripcion, r.hcranalis analisis, r.hcrfecint fch_interpreta, m.gmecodigo medico_cod
	,m.gmenomcom medico_nom_solicita, esp.GEEDESCRI, det.gdecodigo codigo, det.gdenombre plan_beneficios
	,are.gascodigo cod_area, are.gasnombre area_servicio, aese.nombre estado_actual
	, aesc3.fec_lis_y_esp, aesc4.fec_visto_bueno, aesc5.fec_realizado, aesc9.fec_descartado 
FROM DGEMPRES01..hcnresexa r INNER JOIN DGEMPRES01..hcnsolexa s ON r.hcnsolexa = s.oid and s.HCNRESEXA=r.OID
	INNER JOIN DGEMPRES01..genserips si		ON s.genserips = si.oid --and si.sipcodigo='891509'
	INNER JOIN DGEMPRES01..hcnfolio f		ON s.hcnfolio = f.oid
	INNER JOIN DGEMPRES01..adningreso i		ON f.adningreso = i.oid and s.ADNINGRESO=i.OID and f.ADNINGRESO=s.ADNINGRESO
	INNER JOIN DGEMPRES01..genpacien p		ON i.genpacien = p.oid and f.GENPACIEN=p.OID --and p.pacnumdoc='1192891115'
	INNER JOIN DGEMPRES01..genmedico m		ON f.genmedico = m.oid 
	INNER JOIN DGEMPRES01..GENESPMED espm   ON espm.MEDICOS = m.OID and espm.GEMPRINCIPAL = 1
	INNER JOIN DGEMPRES01..GENESPECI esp    ON espm.ESPECIALIDADES = esp.OID
	INNER JOIN DGEMPRES01..gendetcon det	ON i.gendetcon = det.oid
	INNER JOIN DGEMPRES01..genareser are	ON s.GENARESER=are.oid
	INNER JOIN CDO02_21..asi_examen_solicitud aes	ON s.OID=aes.HCNSOLEXA and fch_creacion > '20200830'
	INNER JOIN CDO02_21..asi_examen_solicitud_estado aese	ON aes.estado=aese.id
	left JOIN DGEMPRES01..HPNDEFCAM cam ON i.HPNDEFCAM=cam.OID
	
	OUTER APPLY ( SELECT TOP 1
			fch_evento fec_lis_y_esp
		FROM 
			CDO02_21..asi_examen_solicitud_cambio
		WHERE 
			examen_solicitud=aes.id and estado_destino=3 and fch_evento > '20200830'
		ORDER BY 
			asi_examen_solicitud_cambio.fch_evento DESC
	) AS aesc3
	
	OUTER APPLY ( SELECT TOP 1
			fch_evento fec_visto_bueno
		FROM 
			CDO02_21..asi_examen_solicitud_cambio
		WHERE 
			examen_solicitud=aes.id and estado_destino=4 and fch_evento > '20200830'
		ORDER BY 
			asi_examen_solicitud_cambio.fch_evento DESC
	) AS aesc4
	
	OUTER APPLY ( SELECT TOP 1
			fch_evento fec_realizado
		FROM 
			CDO02_21..asi_examen_solicitud_cambio
		WHERE 
			examen_solicitud=aes.id and estado_destino=5 and fch_evento > '20200830'
		ORDER BY 
			asi_examen_solicitud_cambio.fch_evento DESC
	) AS aesc5
	
	OUTER APPLY ( SELECT TOP 1
			fch_evento fec_descartado
		FROM 
			CDO02_21..asi_examen_solicitud_cambio
		WHERE 
			examen_solicitud=aes.id and estado_destino=9 and fch_evento > '20200830'
		ORDER BY 
			asi_examen_solicitud_cambio.fch_evento DESC
	) AS aesc9
WHERE --aes.id > 6509940 --and aes.HCNSOLEXA < 6504248 AND 
        r.HCRCONFIR=1
	AND r.hcrfecres >= @fch_inicio 
	AND r.hcrfecres <= @fch_fin
	AND (det.gdecodigo = @contrato or @contrato='')
	AND (are.gascodigo = @area or @area='')
	--AND are.gascodigo not in ('P07')
	and (si.SIPCODIGO = @servicio or @servicio='')
ORDER BY 
	r.hcrfecres DESC