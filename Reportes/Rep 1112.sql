------------------------------------------------------------------------------------------------------------------------
declare @fch_inicio datetime = '2020-01-07 00:00:00'
declare @fch_fin    datetime = '2020-30-07 23:59:59'
declare @tipo            int = 0
------------------------------------------------------------------------------------------------------------------------
IF(@tipo)=0
	------------------------------------------------------------------------------------------------------------------------
	begin
		select pac.PACNUMDOC Identificacion, ing.AINCONSEC Ingreso, pac.GPANOMCOM Nombres_y_Apellidos, ing.AINFECING Fecha_Ingreso
		, det.GDECODIGO + ' - ' + det.GDENOMBRE Plan_Beneficio 
		, case(ing.AINTIPING) when 1 then 'Ambulatorio' when 2 then 'Hospitalario' else 'otro' end TIPO
		, case(ing.ainestado) when 0 then 'Registrado' when 1 then 'Facturado' when 2 then 'Anulado' when 3 then 'Bloqueado' ELSE 'Otro' end estado
		, case ing.AINURGCON when 0 then 'URGENCIAS'when 1 then 'CONSULTA_EXTERNA' when 2 then 'NACIDO_HOSPITAL'
				when 3 then 'REMITIDO' when 4 then 'HOSP_URGENCIAS' when 5 then 'HOSPITALIZACION' when 10 then 'CIRUGIA' ELSE 'Otro' end AS CLASE  
		, usu.USUNOMBRE + ' - ' + usu.USUDESCRI Usuario, rel.AINCONSEC Relacionado
		from DGEMPRES21..ADNINGRESO ing inner join DGEMPRES21..GENDETCON det ON ing.GENDETCON=det.OID
		inner join DGEMPRES21..GENPACIEN pac  ON ing.GENPACIEN=pac.OID
		inner join DGEMPRES21..GENUSUARIO usu ON ing.GEENUSUARIO=usu.OID
		left join DGEMPRES21..ADNINGRESO rel ON ing.ADNINGRESO=rel.OID
		where ing.OID > 2546661 and ing.AINTIPRIE=1 and det.GENPLANTI1=2 and ing.OID not in (
		select req.ADNINGRESO 
		from DGEMPRES21..ADNINGREQ req inner join DGEMPRES21..ADNINGREQDOC doc ON doc.ADNINGREQ=req.OID)
		and ing.AINFECING >= @fch_inicio
		and ing.AINFECING <= @fch_fin
	end
------------------------------------------------------------------------------------------------------------------------
	else
	begin
		select pac.PACNUMDOC Identificacion, ing.AINCONSEC Ingreso, pac.GPANOMCOM Nombres_y_Apellidos, ing.AINFECING Fecha_Ingreso
		, det.GDECODIGO + ' - ' + det.GDENOMBRE Plan_Beneficio 
		, case(ing.AINTIPING) when 1 then 'Ambulatorio' when 2 then 'Hospitalario' else 'otro' end TIPO
		, case(ing.ainestado) when 0 then 'Registrado' when 1 then 'Facturado' when 2 then 'Anulado' when 3 then 'Bloqueado' ELSE 'Otro' end estado
		, case ing.AINURGCON when 0 then 'URGENCIAS'when 1 then 'CONSULTA_EXTERNA' when 2 then 'NACIDO_HOSPITAL'
				when 3 then 'REMITIDO' when 4 then 'HOSP_URGENCIAS' when 5 then 'HOSPITALIZACION' when 10 then 'CIRUGIA' ELSE 'Otro' end AS CLASE  
		, usu.USUNOMBRE + ' - ' + usu.USUDESCRI Usuario, count(*) Cantidad
		from DGEMPRES21..ADNINGRESO ing inner join DGEMPRES21..GENDETCON det ON ing.GENDETCON=det.OID
		inner join DGEMPRES21..GENPACIEN pac  ON ing.GENPACIEN=pac.OID
		inner join DGEMPRES21..GENUSUARIO usu ON ing.GEENUSUARIO=usu.OID
		inner join DGEMPRES21..ADNINGREQ req  ON req.ADNINGRESO=ing.OID
		inner join DGEMPRES21..ADNINGREQDOC doc ON doc.ADNINGREQ=req.OID
		where ing.OID > 2546661 and ing.AINTIPRIE=1 and det.GENPLANTI1=2 --and ing.OID in 
		and ing.AINFECING >= @fch_inicio
		and ing.AINFECING <= @fch_fin
		group by pac.PACNUMDOC, ing.AINCONSEC, pac.GPANOMCOM, ing.AINFECING, det.GDECODIGO, det.GDENOMBRE, ing.AINTIPING, ing.ainestado, ing.AINURGCON
		, usu.USUNOMBRE, usu.USUDESCRI
		order by ing.AINCONSEC
	end
------------------------------------------------------------------------------------------------------------------------