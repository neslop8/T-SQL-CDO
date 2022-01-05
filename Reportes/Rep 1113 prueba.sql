------------------------------------------------------------------------------------------------------------------------
declare @paciente varchar(15) = '30388341'
declare @tipo            int = 0
------------------------------------------------------------------------------------------------------------------------
IF(@tipo)=0
	------------------------------------------------------------------------------------------------------------------------
	begin
		select pac.PACNUMDOC Identificacion, ing.oid, ing.AINCONSEC Ingreso, ing.adningreso Relacionado, ing.AINVALSOA Valor_Remitido
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
		, usu.USUNOMBRE + ' - ' + usu.USUDESCRI Usuario, fac.SFANUMFAC Num_FAc, convert(bigint, fac.SFATOTFAC) Valor_Fac
		from DGEMPRES21..GENPACIEN pac inner join DGEMPRES21..ADNINGRESO ing ON ing.GENPACIEN=pac.OID
		inner join DGEMPRES21..GENDETCON det ON ing.GENDETCON=det.OID
		inner join DGEMPRES21..GENUSUARIO usu ON ing.GEENUSUARIO=usu.OID
		inner join DGEMPRES21..SLNFACTUR  fac ON fac.adningreso=ing.oid
		where ing.AINTIPRIE=1 and pac.PACNUMDOC=@paciente
		order by ing.oid
	end
------------------------------------------------------------------------------------------------------------------------
--select top 5 * from slnfactur order by oid desc
------------------------------------------------------------------------------------------------------------------------