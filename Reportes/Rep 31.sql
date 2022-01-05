--------------------------------------------------------------------------------------------------------------------------------
declare @fch_inicio datetime = '2019-01-08 00:00:00'
declare @fch_fin    datetime = '2019-31-08 23:59:59'
declare @medico   char(20) = ''
--------------------------------------------------------------------------------------------------------------------------------
SELECT SUBSTRING(convert(varchar,i.ainfecing,120),1,19) fch_ingreso, SUBSTRING(convert(varchar,f.hcfecfol,120),1,19) fch_folio
    ,th.hccodigo tipo_folio, f.hcnumfol folio,i.ainconsec ingreso, p.pacnumdoc documento
	,RTRIM(p.pacprinom) + ' ' + RTRIM(p.pacsegnom) + ' ' + RTRIM(p.pacpriape) + ' ' + RTRIM(p.pacsegape) paciente
	,SUBSTRING(cd.gdecodigo, 1, 6) contrato_cod, SUBSTRING(cd.gdenombre, 1, 14) contrato_nom
	,SUBSTRING(m.gmenomcom, 1, 20) medico, a.gascodigo, a.gasnombre area
--	,Servicios.*
FROM DgEmpres21..hcnfolio f INNER JOIN DgEmpres21..adningreso i ON f.adningreso = i.oid
	INNER JOIN DgEmpres21..genpacien p ON i.genpacien = p.oid
	INNER JOIN DgEmpres21..gendetcon cd ON i.gendetcon = cd.oid
	INNER JOIN DgEmpres21..hcntiphis th ON f.hcntiphis = th.oid
	INNER JOIN DgEmpres21..genmedico m ON f.genmedico = m.oid 
	INNER JOIN DgEmpres21..genareser a ON f.genareser = a.oid
	/*OUTER APPLY (
		SELECT 
			COALESCE(GENSERIPS.SIPCODIGO,INNPRODUC.IPRCODIGO) AS COD_SERVICIO
			,SLNSERPRO.SERDESSER AS SERVICIO
		FROM
			DGEMPRES21..SLNSERPRO
				LEFT JOIN DGEMPRES21..SLNSERHOJ ON SLNSERPRO.OID = SLNSERHOJ.OID 
				LEFT JOIN DGEMPRES21..SLNPAQHOJ ON SLNSERPRO.OID = SLNPAQHOJ.SLNSERPRO1 AND SLNSERHOJ.OID = SLNPAQHOJ.SLNSERHOJ1
				LEFT JOIN DgEmpres21..SLNPROHOJ ON SLNSERPRO.OID = SLNPROHOJ.OID 
				LEFT JOIN DgEmpres21..GENSERIPS ON SLNSERHOJ.GENSERIPS1 = GENSERIPS.OID 
				LEFT JOIN DgEmpres21..GENPAQUET ON SLNPAQHOJ.GENPAQUET1 = GENPAQUET.OID 
				LEFT JOIN DgEmpres21..INNPRODUC ON SLNPROHOJ.INNPRODUC1 = INNPRODUC.OID 
		WHERE
			SLNSERPRO.ADNINGRES1 = f.adningreso
			AND SLNSERPRO.SERAPLPRO = 0 -- Los que no aplican a procedimiento osea los que factura
		) AS Servicios */
WHERE 
	f.hcfecfol >=@fch_inicio 
	AND f.hcfecfol <=@fch_fin 
	AND th.hccodigo NOT IN ('P00001', 'P0SOAT', 'P0GIN1', 'P0ORT1', 'P000P1') 
	AND (m.gmecodigo = @medico or @medico = '')
ORDER BY f.hcfecfol
--------------------------------------------------------------------------------------------------------------------------------