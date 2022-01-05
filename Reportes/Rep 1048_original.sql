SELECT 
			CMNCITMED.OID AS OID_CITA
			,CMNCITMED.CCMFECCIT AS FECHA_CITA
			,YEAR(CMNCITMED.CCMFECCIT) AS A�O_CITA
			,MONTH(CMNCITMED.CCMFECCIT) AS MES_CITA
			,DATENAME(MM, CMNCITMED.CCMFECCIT) AS NOM_MES_CITA
			,CASE WHEN COALESCE(Primer_Folio.AINCONSEC, Ingreso.AINCONSEC) IS NULL THEN 
				CASE CMNCITMED.CCMESTADO 
					WHEN 0 THEN 'ASIGNADA'
					WHEN 1 THEN 'CANCELADA'
					WHEN 2 THEN 'CUMPLIDA'
					WHEN 3 THEN 'INCUMPLIDA'
					WHEN 4 THEN 'FACTURADA'
					ELSE '' END 
				ELSE
					CASE CMNCITMED.CCMESTADO 
						WHEN 0 THEN 'ASIGNADA'
						WHEN 1 THEN 'CANCELADA'
						WHEN 2 THEN 'CUMPLIDA'
						WHEN 3 THEN 'INCUMPLIDA'
						WHEN 4 THEN 'FACTURADA'
						ELSE '' END 
			END AS ESTADO_CITA
			,CMNTIPACT.CMACODIGO COD_ACTIVIDAD
			,CMNTIPACT.CMANOMBRE ACTIVIDAD
	
			,GENESPECI.GEECODIGO COD_ESPECIALIDAD
			,GENESPECI.GEEDESCRI ESPECIALIDAD
	
			,CASE(ADNCENATE.ACACODIGO) WHEN 1 THEN 'CDO' ELSE 'CIMO' END CENTRO			
	
			,CMNCITMED.CCMPACDOC IDENTIFICACION
			,GENPACIEN.GPANOMCOM AS PACIENTE
	
			,GENMEDICO.GMECODIGO COD_MEDICO
			,GENMEDICO.GMENOMCOM MEDICO
	
			,COALESCE(Primer_Folio.AINCONSEC, Ingreso.AINCONSEC) NO_INGRESO
			,COALESCE(Primer_Folio.HCNUMFOL, Ingreso.HCNUMFOL) NO_FOLIO
			,COALESCE(Primer_Folio.AINFECING, Ingreso.AINFECING) FECHA_INGRESO
			,COALESCE(YEAR(Primer_Folio.AINFECING), YEAR(Ingreso.AINFECING)) AS A�O_INGRESO
			,COALESCE(MONTH(Primer_Folio.AINFECING), MONTH(Ingreso.AINFECING)) AS MES_INGRESO
			,COALESCE(DATENAME(MM, Primer_Folio.AINFECING), DATENAME(MM, Ingreso.AINFECING)) AS NOM_MES_INGRESO
			,COALESCE(Primer_Folio.Ingreso_Por, Ingreso.Ingreso_Por) VIA_INGRESO
			,COALESCE(Primer_Folio.TIPO_RIESGO, Ingreso.TIPO_RIESGO) TIPO_RIESGO
			,COALESCE(Primer_Folio.Tipo_Ingreso, Ingreso.Tipo_Ingreso) TIPO_INGRESO
			,CASE WHEN COALESCE(Primer_Folio.AINCONSEC, Ingreso.AINCONSEC) IS NULL THEN 'NO' ELSE 'SI' END CUMPLIDO_AUTOMATICO 

			,CMNCONSUL.CCNNOMBRE CONSULTORIO
		FROM DGEMPRES01..CMNCITMED LEFT JOIN DGEMPRES01..CMNTIPACT ON CMNTIPACT.OID = CMNCITMED.CMNTIPACT
			LEFT JOIN DGEMPRES01..GENESPECI ON GENESPECI.OID = CMNCITMED.GENESPECI
			LEFT JOIN DGEMPRES01..CMNHORMED ON CMNHORMED.OID = CMNCITMED.CMNHORMED
			LEFT JOIN DGEMPRES01..GENPACIEN ON GENPACIEN.PACNUMDOC = CMNCITMED.CCMPACDOC
			LEFT JOIN DGEMPRES01..GENMEDICO ON GENMEDICO.OID = CMNCITMED.GENMEDICO1 
			LEFT JOIN DGEMPRES01..CMNCONSUL ON CMNCONSUL.OID = CMNHORMED.CMNCONSUL
			LEFT JOIN DGEMPRES01..ADNCENATE ON ADNCENATE.OID = CMNCONSUL.ADNCENATE
			OUTER APPLY DGEMPRES01..f_Cita_Primer_Folio(CMNCITMED.OID) Primer_Folio
            OUTER APPLY DGEMPRES01..f_Cita_Ingreso(LTRIM(RTRIM(CMNCITMED.CCMPACDOC)), CMNCITMED.OID) Ingreso	
		WHERE 
			CMNCITMED.CCMFECCIT >= @fch_inicio
			AND CMNCITMED.CCMFECCIT <= @fch_fin
			AND ('0'+RTRIM(ADNCENATE.ACACODIGO) = @centro OR @centro='')
		ORDER BY 
			CMNTIPACT.CMACODIGO, CMNCITMED.CCMFECCIT