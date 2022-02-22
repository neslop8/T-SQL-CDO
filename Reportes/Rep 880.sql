-----------------------------------------------------------------------------------------------------------------------
declare @empresa char(2) = '31'
declare @sipcodigo char(10) = '901236'
declare @fch_inicio datetime = '20220125'
declare @fch_fin datetime = '20220126'
-----------------------------------------------------------------------------------------------------------------------
	IF @empresa = '21'
	BEGIN
		SELECT 
			i.ainfecing fch_ingreso
			, f.hcfecfol fch_folio
			, th.hccodigo tipo_folio
			, f.hcnumfol folio  
			, i.ainconsec ingreso
			, p.pacnumdoc documento  
			, RTRIM(p.pacprinom) + ' ' + RTRIM(p.pacsegnom) + ' ' + RTRIM(p.pacpriape) + ' ' + RTRIM(p.pacsegape) paciente 
			, SUBSTRING(cd.gdecodigo, 1, 6) contrato_cod  
			, SUBSTRING(cd.gdenombre, 1, 20) contrato_nom  
			, SUBSTRING(m.gmenomcom, 1, 20) medico
			, cam.HCACODIGO as cama  
			, tel.pactelefono as telefono
			, ips.sipcodigo as cod_servicio
			, ips.sipnombre as servicio
			, sol.hcscanti as cant_serv
			/*, pro.iprcodigo cod_producto, pro.iprdescor as producto, med.hcscanti as cant_prod*/
		FROM 
			DgEmpres21..hcnfolio f INNER JOIN DgEmpres21..hcntiphis th ON f.hcntiphis = th.oid  
			JOIN DgEmpres21..genareser a ON f.genareser = a.oid  
			JOIN DgEmpres21..adningreso i ON f.adningreso = i.oid  
			JOIN DgEmpres21..genpacien p ON i.genpacien = p.oid  
			JOIN DgEmpres21..gendetcon cd ON i.gendetcon = cd.oid  
			JOIN DgEmpres21..genmedico m ON f.genmedico = m.oid   
			LEFT JOIN DgEmpres21..HPNDEFCAM cam on i.HPNDEFCAM=cam.OID
			LEFT JOIN dgempres21..genpacient tel on tel.oid=p.genpacient
			LEFT JOIN dgempres21..hcnsolexa sol on sol.adningreso=i.oid
			LEFT JOIN dgempres21..genserips ips on sol.genserips=ips.oid
			/*LEFT JOIN dgempres21..hcnmedpac med on med.hcnfolio=f.oid
			LEFT JOIN dgempres21..innproduc pro on med.innproduc=pro.oid*/
		WHERE          
			/*f.hcfecfol >= @fch_inicio         
			AND f.hcfecfol <= @fch_fin         
			AND (m.OID = @medico or @medico='') AND */
			--(th.hccodigo= @historia or @historia='') AND 
			(ips.sipcodigo= @sipcodigo or @sipcodigo='')

	END 
-----------------------------------------------------------------------------------------------------------------------
	ELSE
	BEGIN
		SELECT 
			i.ainfecing fch_ingreso
			, f.hcfecfol fch_folio
			, th.hccodigo tipo_folio
			, f.hcnumfol folio  
			, i.ainconsec ingreso
			, p.pacnumdoc documento  
			, RTRIM(p.pacprinom) + ' ' + RTRIM(p.pacsegnom) + ' ' + RTRIM(p.pacpriape) + ' ' + RTRIM(p.pacsegape) paciente 
			, SUBSTRING(cd.gdecodigo, 1, 6) contrato_cod  , SUBSTRING(cd.gdenombre, 1, 20) contrato_nom  
			, SUBSTRING(m.gmenomcom, 1, 20) medico
			, ips.sipcodigo as cod_servicio
			, ips.sipnombre as servicio
			/*, cam.HCACODIGO as cama  
			, tel.pactelefono as telefono			
			, sol.hcscanti as cant_serv*/
			/*, pro.iprcodigo cod_producto, pro.iprdescor as producto, med.hcscanti as cant_prod*/
		FROM 
			DGEMPRES01..hcnfolio f  
			JOIN DGEMPRES01..hcntiphis th ON f.hcntiphis = th.oid  
			JOIN DGEMPRES01..genareser a ON f.genareser = a.oid  
			JOIN DGEMPRES01..adningreso i ON f.adningreso = i.oid  
			JOIN DGEMPRES01..genpacien p ON i.genpacien = p.oid  
			JOIN DGEMPRES01..gendetcon cd ON i.gendetcon = cd.oid  
			JOIN DGEMPRES01..genmedico m ON f.genmedico = m.oid   
			LEFT JOIN DGEMPRES01..hcnsolexa sol on sol.adningreso=i.oid and sol.HCNFOLIO=f.OID
			LEFT JOIN DGEMPRES01..genserips ips on sol.genserips=ips.oid
			/*LEFT JOIN DGEMPRES01..genpacient tel on tel.oid=p.genpacient
			LEFT JOIN DGEMPRES01..HPNDEFCAM cam on i.HPNDEFCAM=cam.OID*/
			/*LEFT JOIN DGEMPRES01..hcnmedpac med on med.hcnfolio=f.oid
			LEFT JOIN DGEMPRES01..innproduc pro on med.innproduc=pro.oid*/
		WHERE          
			/*f.hcfecfol >= @fch_inicio         
			AND f.hcfecfol <= @fch_fin         
			AND (m.OID = @medico or @medico='') AND*/
			--(th.hccodigo= @historia or @historia='') AND 
			--(ips.sipcodigo= @sipcodigo or @sipcodigo='') and 
			p.PACNUMDOC='19186586' AND f.HCNUMFOL='34'
	END 
-----------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------