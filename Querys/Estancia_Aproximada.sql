-------------------------------------------------------------------------------------------------------------------------
--declare @fch_inicio  datetime = '2021-01-02 00:00:00'
--declare @fch_fin     datetime = '2021-28-02 23:59:59'
-------------------------------------------------------------------------------------------------------------------------
WITH ultest (ingreso, estancia)	AS
	(
		select est.adningres, max(est.oid)
		from dgempres01..adningreso ing inner join dgempres01..hpnestanc est on  est.adningres=ing.oid
		where ing.AINFECING >= '2021-01-03 00:00:00' and
			  ing.AINFECING <= '2021-31-03 23:59:59'
	    /*where ing.AINFECING >= @fch_inicio and
			  ing.AINFECING <= @fch_fin*/
		group by est.adningres
	)
-------------------------------------------------------------------------------------------------------------------------
SELECT pac.pacnumdoc documento, RTRIM(pac.GPANOMCOM) paciente, RTRIM(CONVERT(char(6),ct.GECCODIGO)) Cod_Con
	, SUBSTRING(cd.gdenombre,1,CASE WHEN LEN(RTRIM(cd.gdenombre)) < 12 THEN LEN(RTRIM(cd.gdenombre)) ELSE LEN(RTRIM(cd.gdenombre)) -12 END) Contrato_nom
	, ing.AINCONSEC ingreso, ing.AINFECING fecha_ingreso, ing.AINFEChos as fecha_hospitalizacion
	, case(ing.ainestado) when 0 then 'Registrado' when 1 then 'Facturado' when 2 then 'Anulado' when 3 then 'Bloqueado' 
	                                                      else 'Cerrado' end estado_ingreso	
	, ROUND(CONVERT(INT, est.HESFECSAL) - CONVERT(INT, ing.ainfechos), 1) AS Dias_Estancia
	, ROUND((CONVERT (INT, GETDATE()) - CONVERT(INT, pac.gpafecnac)) / 365, 0) as edad
	, ROUND((CONVERT (INT, GETDATE()) - CONVERT(INT, pac.gpafecnac)) / 365, 0) as edad
	, ats.estancia Estancia_Aproximada, atse.nombre Estado_Solicitud, atst.nombre Tipo_Solicitud
	, fol.HCNUMFOL Folio, tip.HCCODIGO Tipo, tip.HCNOMBRE Historia, med.GMECODIGO Medico
	--, cam.hcacodigo cama_cod, est.HESFECING Ingreso_Cama, est.HESFECSAL Salida_Cama
FROM DGEMPRES01..ADNINGRESO ing INNER JOIN DGEMPRES01..GENPACIEN pac ON ing.genpacien = pac.oid
	INNER JOIN DGEMPRES01..GENDETCON cd ON ing.gendetcon = cd.oid
	INNER JOIN DGEMPRES01..GENCONTRA ct ON cd.GENCONTRA1=ct.OID
	INNER JOIN ultest ult ON ult.ingreso=ing.oid
	INNER JOIN DGEMPRES01..HPNESTANC est ON ult.estancia=est.oid
	--INNER JOIN DGEMPRES01..hpndefcam cam ON est.hpndefcam = cam.oid 
	INNER JOIN CDO02_21..asi_tratamiento_solicitud ats ON ats.ingreso=ing.oid and ats.paciente=pac.OID-- and ats.folio=fol.OID
	INNER JOIN CDO02_21..asi_tratamiento_solicitud_estado atse ON ats.estado=atse.id
	INNER JOIN CDO02_21..asi_tratamiento_solicitud_tipo atst ON ats.tipo=atst.id
	INNER JOIN DGEMPRES01..HCNFOLIO fol ON ats.folio=fol.OID
	INNER JOIN DGEMPRES01..GENMEDICO med ON fol.GENMEDICO=med.OID
	INNER JOIN DGEMPRES01..HCNTIPHIS tip ON fol.HCNTIPHIS=tip.OID
/*WHERE ing.AINFECING >= @fch_inicio and
      ing.AINFECING <= @fch_fin*/
WHERE ing.AINFECING >= '2021-01-03 00:00:00' and
      ing.AINFECING <= '2021-31-03 23:59:59'
	  --and ing.AINCONSEC in (92121, 92125)
ORDER BY ing.AINCONSEC
-------------------------------------------------------------------------------------------------------------------------
