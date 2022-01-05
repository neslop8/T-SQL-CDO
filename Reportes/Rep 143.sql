-------------------------------------------------------------------------------------------------------------------------
WITH ultest (ingreso, estancia)	AS
	(
		SELECT est.adningres, max(est.oid)
		FROM DGEMPRES01..adningreso ing inner join dgempres01..hpnestanc est on  est.adningres=ing.oid
	    WHERE ing.AINESTADO in (0,3)
		GROUP BY  est.adningres
	)
,
	priest (ingreso, estancia) AS
	(
		SELECT est.adningres, min(est.oid)
		FROM DGEMPRES01..adningreso ing INNER JOIN dgempres01..hpnestanc est ON  est.adningres=ing.oid
		WHERE ing.AINESTADO IN (0,3)
		GROUP BY est.adningres
	)
,
	estancia_total (ingreso, estancia_total) AS
	(
		SELECT ing.OID, sum(ats.estancia)
		FROM DGEMPRES01..ADNINGRESO ing 
		INNER JOIN CDO02_21..asi_tratamiento_solicitud ats ON ats.ingreso=ing.oid and ats.paciente=ing.GENPACIEN
		WHERE ing.AINESTADO IN (0,3)-- and ing.AINCONSEC in (243397)
		GROUP BY ing.OID
	)
-------------------------------------------------------------------------------------------------------------------------
SELECT pac.pacnumdoc documento, RTRIM(pac.GPANOMCOM) paciente, RTRIM(CONVERT(char(6),ct.GECCODIGO)) Cod_Con
	, SUBSTRING(cd.gdenombre,1,CASE WHEN LEN(RTRIM(cd.gdenombre)) < 12 THEN LEN(RTRIM(cd.gdenombre)) ELSE LEN(RTRIM(cd.gdenombre)) -12 END) Contrato_nom
	, ing.AINCONSEC ingreso, ing.AINFECING fecha_ingreso, ing.AINFEChos as fecha_hospitalizacion
	, case(ing.ainestado) when 0 then 'Registrado' when 1 then 'Facturado' when 2 then 'Anulado' when 3 then 'Bloqueado' 
	                                                      else 'Cerrado' end estado_ingreso
	, CASE WHEN estS.hesfecsal IS NULL THEN ROUND(CONVERT(INT, GETDATE()) - CONVERT(INT, estE.HESFECING), 1)
									ELSE ROUND(CONVERT(INT, estE.HESFECING) - CONVERT(INT, estE.HESFECSAL), 1) END Estancia_Real
	, ROUND((CONVERT (INT, GETDATE()) - CONVERT(INT, pac.GPAFECNAC)) / 365, 0) as edad
	, ROUND((CONVERT (INT, GETDATE()) - CONVERT(INT, pac.GPAFECNAC)) / 365, 0) as edad
	, ats.estancia Estancia_Solicitada, et.estancia_total Estancia_Total_Aproximada
	, CASE WHEN ((CASE WHEN estS.hesfecsal IS NULL THEN ROUND(CONVERT(INT, GETDATE()) - CONVERT(INT, estE.HESFECING), 1)
				ELSE ROUND(CONVERT(INT, estE.HESFECING) - CONVERT(INT, estE.HESFECSAL), 1) END)-et.estancia_total) > 0 THEN 'Si' ELSE 'No' END Alerta
	, atse.nombre Estado_Solicitud, atst.nombre Tipo_Solicitud
	, fol.HCNUMFOL Folio, tip.HCCODIGO Tipo, tip.HCNOMBRE Historia, med.GMECODIGO Medico, di.*
FROM DGEMPRES01..ADNINGRESO ing INNER JOIN DGEMPRES01..GENPACIEN pac ON ing.genpacien = pac.oid
	INNER JOIN DGEMPRES01..GENDETCON cd ON ing.gendetcon = cd.oid
	INNER JOIN DGEMPRES01..GENCONTRA ct ON cd.GENCONTRA1=ct.OID
	INNER JOIN ultest ult ON ult.ingreso=ing.oid
	INNER JOIN priest pri ON pri.ingreso=ing.oid
	INNER JOIN DGEMPRES01..HPNESTANC estE ON pri.estancia=estE.oid
	INNER JOIN DGEMPRES01..HPNESTANC estS ON ult.estancia=estS.oid
	INNER JOIN estancia_total et ON et.ingreso=ing.OID
	INNER JOIN CDO02_21..asi_tratamiento_solicitud ats ON ats.ingreso=ing.oid and ats.paciente=pac.OID-- and ats.folio=fol.OID
	INNER JOIN CDO02_21..asi_tratamiento_solicitud_estado atse ON ats.estado=atse.id
	INNER JOIN CDO02_21..asi_tratamiento_solicitud_tipo atst ON ats.tipo=atst.id
	INNER JOIN DGEMPRES01..HCNFOLIO fol ON ats.folio=fol.OID
	INNER JOIN DGEMPRES01..GENMEDICO med ON fol.GENMEDICO=med.OID
	INNER JOIN DGEMPRES01..HCNTIPHIS tip ON fol.HCNTIPHIS=tip.OID
		outer APPLY CDO02_21.dbo.f_dx_hc_3(ing.oid) di
WHERE ing.AINESTADO in (0,3) and ing.AINTIPING=2 and ing.adnegreso IS NULL
ORDER BY ing.AINCONSEC, fol.HCNUMFOL
-------------------------------------------------------------------------------------------------------------------------