declare @paciente varchar(15) = '3082296'
-----------------------------------------------------
select pac.PACNUMDOC Identificacion, ing.AINCONSEC Ingreso, ing.adningreso Relacionado
		,CASE ing.AINTIPRIE WHEN 0 THEN 'NINGUNA' WHEN 1 THEN 'ACCIDENTE DE TRANSITO' WHEN 2 THEN 'CATASTROFE' 
		WHEN 3 THEN 'ENFERMEDAD GENERAL Y MATERNIDAD' WHEN 4 THEN 'ACCIDENTE DE TRABAJO' WHEN 5 THEN 'ENFERMEDAD PROFESIONAL' 
		WHEN 6 THEN 'ATENCIÓN INICIAL DE URGENCIAS' WHEN 7 THEN 'OTRO TIPO DE ACCIDENTE' WHEN 8 THEN 'LESIÓN POR AGRESIÓN' 
		WHEN 9 THEN 'LESIÓN AUTOINFLIGIDA' WHEN 10 THEN 'MALTRATO FISICO' WHEN 11 THEN 'PROMOCIÓN Y PREVENCIÓN' 
		WHEN 12 THEN 'OTRO' WHEN 13 THEN 'ACCIDENTE RABICO' WHEN 14 THEN 'ACCIDENTE OFIDICO' WHEN 15 THEN 'SOSPECHA DE ABUSO SEXUAL' 
		WHEN 16 THEN 'SOSPECHA DE VIOLENCIA SEXUAL'	WHEN 17 THEN 'SOSPECHA DE MALTRATO EMOCIONAL' END AS TIPO_RIESGO
		, pac.GPANOMCOM Nombres_y_Apellidos
		, ing.AINFECING Fecha_Ingreso, det.GDECODIGO + ' - ' + det.GDENOMBRE Plan_Beneficio 
		, case(ing.AINTIPING) when 1 then 'Ambulatorio' when 2 then 'Hospitalario' else 'otro' end TIPO
		, case(ing.ainestado) when 0 then 'Registrado' when 1 then 'Facturado' when 2 then 'Anulado' when 3 then 'Bloqueado' ELSE 'Otro' end estado
		, case ing.AINURGCON when 0 then 'URGENCIAS'when 1 then 'CONSULTA_EXTERNA' when 2 then 'NACIDO_HOSPITAL'
				when 3 then 'REMITIDO' when 4 then 'HOSP_URGENCIAS' when 5 then 'HOSPITALIZACION' when 10 then 'CIRUGIA' ELSE 'Otro' end AS CLASE  
		, usu.USUNOMBRE + ' - ' + usu.USUDESCRI Usuario_Ingreso, fac.SFANUMFAC Num_FAc, convert(bigint, fac.SFATOTFAC) Valor_Fac INTO #TMP
		from DGEMPRES21..GENPACIEN pac inner join DGEMPRES21..ADNINGRESO ing ON ing.GENPACIEN=pac.OID
		inner join DGEMPRES21..GENDETCON det  ON ing.GENDETCON=det.OID
		inner join DGEMPRES21..GENUSUARIO usu ON ing.GEENUSUARIO=usu.OID
		inner join DGEMPRES21..SLNFACTUR  fac ON fac.adningreso=ing.oid
		where fac.SFADOCANU=0 and ing.AINTIPRIE=1 and pac.PACNUMDOC=@paciente
		order by ing.oid
-----------------------------------------------------Cursor para actualizar el ingreso relacionado
	declare @ingreso bigint, @rel bigint
	-- Declaración del cursor
	DECLARE ingresos CURSOR FOR
		select Ingreso, Relacionado
		from #TMP
	-- Apertura del cursor
	OPEN ingresos
	-- Lectura de la primera fila del cursor
	FETCH NEXT FROM ingresos INTO @ingreso, @rel
	WHILE(@@FETCH_STATUS= 0) 
		BEGIN 
			--IF(#TMP.Relacionado)
				--BEGIN
				update #TMP set #TMP.Relacionado=(select ainconsec from DGEMPRES21..ADNINGRESO ing where ing.oid=@rel) 
				where #TMP.Ingreso=@ingreso
				--END
			
		FETCH NEXT FROM ingresos INTO @ingreso, @rel
		-- Fin del bucle WHILE
		END
	-- Cierra el cursor
	CLOSE ingresos
	-- Libera los recursos del cursor
	DEALLOCATE ingresos
Select * from #tmp
DROP TABLE #tmp
-----------------------------------------------------------------------------------------------------------------