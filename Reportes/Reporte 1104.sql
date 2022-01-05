WITH dxpac (oid, ingreso, fol_oid)
	AS
	(
		select ing.oid, ing.AINCONSEC, min(fol.oid)
		from DGEMPRES01..hcnfolio fol inner join DGEMPRES01..HCNDIAPAC dxp on dxp.HCNFOLIO=fol.OID
		inner join DGEMPRES01..GENDIAGNO dx on dxp.GENDIAGNO=dx.OID
		inner join DGEMPRES01..ADNINGRESO ing on fol.ADNINGRESO=ing.OID
		where dxp.HCPDIAPRIN=1 and ing.AINESTADO in (0,3)
		group by ing.oid, ing.AINCONSEC
	)
	,
	priest (ingreso, estancia)
	AS
	(
		select est.adningres, min(est.oid)
		from DGEMPRES01..adningreso ing inner join DGEMPRES01..hpnestanc est on  est.adningres=ing.oid
		where ing.AINESTADO in (0,3)
		group by est.adningres
	)
	,
	anul (ingreso, factura, usuario)
	AS
	(
		select ing.OID, fac.SFANUMFAC, usu.USUNOMBRE
		from DGEMPRES01..adningreso ing inner join DGEMPRES01..SLNFACTUR fac on fac.adningreso=ing.oid
		inner join DGEMPRES01..GENUSUARIO usu ON fac.GENUSUARIO1=usu.OID
		where ing.AINESTADO in (0,3) and fac.SFADOCANU=1		
	)
	
		SELECT RTRIM(CONVERT(char(6),ct.GECCODIGO)) Cod_Con
			,SUBSTRING(cd.gdenombre,1,CASE WHEN LEN(RTRIM(cd.gdenombre)) < 12 THEN LEN(RTRIM(cd.gdenombre)) ELSE LEN(RTRIM(cd.gdenombre)) -12 END) Contrato_nom
			,p.pacnumdoc documento, p.GPANOMCOM Nombre, ing.AINCONSEC as ingreso, usu.USUNOMBRE Usu_Ingreso, ing.AINFECHOS as fec_ing_cama
			, c.hcacodigo cama_cod, ROUND(CONVERT(INT, GETDATE()) - CONVERT(INT, ing.ainfechos), 1) AS dias_U_C
			,ROUND(CONVERT(INT, GETDATE()) - CONVERT(INT, e1.hesfecing), 1) AS dias_T
			,ROUND((CONVERT (INT, GETDATE()) - CONVERT(INT, p.gpafecnac)) / 365, 0) as edad
			,CASE ing.ADNCENATE WHEN '1' THEN 'CDO' ELSE 'CIMO' END AS Centro
			,CASE ing.aincauing
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
			,ROUND((CONVERT (INT, GETDATE()) - CONVERT(INT, p.gpafecnac)) / 365, 0) as edad
			,ing.AINFECING fec_ing, e1.HESFECING fec_pri_est
			, CONVERT(bigint, cab.SCOTOTPAC) Neto_Paciente, CONVERT(bigint,cab.SCOTOTENT) Neto_Entidad---Cabecera de la Hoja de Trabajo, diferencia 
			, convert(bigint, valor.valor)valor_calculado
			, sal.SRAFECSAL Fecha_Salida, usu1.USUNOMBRE Usu_Salida
			, egr.ADEFECSAL Fecha_Egreso, usu2.USUNOMBRE Usu_Egreso
			, anul.factura Anulada, anul.usuario
			, ser.GASCODIGO Cod_Area, ser.GASNOMBRE Area_Servicio
		FROM DGEMPRES01..ADNINGRESO ing INNER JOIN DGEMPRES01..GENPACIEN p ON ing.genpacien = p.oid
			INNER JOIN DGEMPRES01..GENDETCON cd   ON ing.gendetcon = cd.oid
			INNER JOIN DGEMPRES01..GENCONTRA ct   ON cd.GENCONTRA1=ct.OID
			INNER JOIN DGEMPRES01..ADNCENATE cen  ON ing.ADNCENATE=cen.OID
			INNER JOIN DGEMPRES01..GENUSUARIO usu ON ing.GEENUSUARIO=usu.OID
			LEFT JOIN dgempres01..GENARESER   ser ON ing.GENARESER=ser.OID
			LEFT JOIN priest pri ON pri.ingreso=ing.oid
			LEFT JOIN DGEMPRES01..hpnestanc e1 on pri.estancia=e1.oid
			LEFT JOIN DGEMPRES01..hpnestanc e ON e.adningres = ing.oid AND e.OID=e1.OID
			LEFT JOIN DGEMPRES01..hpndefcam c ON e.hpndefcam = c.oid 
			LEFT JOIN dxpac dx ON dx.oid=e.ADNINGRES
			LEFT JOIN DGEMPRES01..SLNCONHOJ cab ON cab.ADNINGRES1 = ing.OID---Cabecera de la Hoja de Trabajo, diferencia
			LEFT JOIN DGEMPRES01..SLNORDSAL sal ON sal.ADNINGRES1=ing.oid
			LEFT JOIN DGEMPRES01..GENUSUARIO usu1 ON sal.GENUSUARIO1=usu1.OID
			LEFT JOIN DGEMPRES01..ADNEGRESO egr ON egr.ADNINGRESO=ing.OID
			LEFT JOIN DGEMPRES01..GENUSUARIO usu2 ON egr.GEENUSUARIO=usu2.OID
			OUTER APPLY DGEMPRES01..f_censo_valorizado_ingreso (ing.OID) valor
			LEFT JOIN anul ON anul.ingreso=ing.oid
		WHERE ing.AINESTADO in (0,3) AND (cen.ACACODIGO = @centro OR @centro='')
		ORDER BY 1