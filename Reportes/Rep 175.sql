----------------------------------------------------------------------------------------------------------------------
declare @fch_inicio datetime = '2016-05-09 00:00:00'
declare @fch_fin    datetime = '2016-05-09 23:59:59'
declare @contrato   char(20) = ''
----------------------------------------------------------------------------------------------------------------------
SELECT pac.pacnumdoc documento, ing.ainconsec ingreso, convert(date,ing.AINFECING,107) fecha
	,RTRIM(pac.pacprinom) + ' ' + RTRIM(pac.pacsegnom) + ' ' + RTRIM(pac.pacpriape) + ' ' + RTRIM(pac.pacsegape) paciente
	,con.GECCODIGO contrato, con.GECNOMENT entida, inc.HCICONSEC incapacidad, inc.HCIDIASINC Dia
	,substring(convert(VARCHAR, HCIFECINI), 1, 11) Inicio, med.GMECODIGO Cod_Med, med.GMENOMCOM Medico
	,com.gcmcodigo cod_emp, com.gcmnombre empresa, fac.SFANUMFAC Num_factura, convert(float, fac.SFATOTFAC) Total_Facturado
	, dx_e.dg dx_Prin, dx.DIANOMBRE
FROM dgempres21..ADNINGRESO ing INNER JOIN dgempres21..GENPACIEN pac on ing.GENPACIEN=pac.OID
	INNER JOIN dgempres21..GENDETCON det	on ing.GENDETCON=det.OID
	INNER JOIN dgempres21..GENCONTRA con	on det.GENCONTRA1=con.OID
	INNER JOIN DgEmpres21..GENCOMPANIA com	on pac.GENEMPRESA=com.OID
	INNER JOIN dgempres21..ADNEGRESO egre	on egre.ADNINGRESO=ing.OID
	OUTER APPLY CDO02_21..f_dx_egr_01(egre.OID) dx_e
	LEFT JOIN dgempres21..HCNINCAPA inc		on inc.ADNINGRESO=ing.OID and inc.GENPACIEN=pac.OID
	LEFT JOIN dgempres21..GENMEDICO med		on inc.GENMEDICO=med.OID
	INNER JOIN DGEMPRES21..SLNFACTUR fac    on fac.ADNINGRESO=ing.OID
	LEFT JOIN  DGEMPRES21..GENDIAGNO dx     on dx_e.dg=dx.DIACODIGO
WHERE ing.ainfecing >= @fch_inicio
	AND ing.ainfecing <= @fch_fin
	AND (det.gdecodigo like '%02' or det.gdecodigo like '%021')
	AND (det.GDECODIGO=@contrato or @contrato='')
	--AND  pac.PACNUMDOC='1015396260'
/*GROUP BY pac.pacnumdoc, ing.ainconsec, convert(date,ing.AINFECING,107)
	,RTRIM(pac.pacprinom) + ' ' + RTRIM(pac.pacsegnom) + ' ' + RTRIM(pac.pacpriape) + ' ' + RTRIM(pac.pacsegape)
	,con.GECCODIGO, con.GECNOMENT, inc.HCIDIASINC, substring(convert(VARCHAR, HCIFECINI),1,11) 
	,med.GMECODIGO, med.GMENOMCOM, com.gcmcodigo, com.gcmnombre, fac.SFANUMFAC, fac.SFATOTFAC
ORDER BY convert(date,ing.AINFECING,107),pac.PACNUMDOC,ing.ainconsec*/
----------------------------------------------------------------------------------------------------------------------
/*WITH dx_ingreso (egreso_oid, dx_ing_cod, dx_ing_nombre)
AS
(
	SELECT di.adnegreso, dxi.diacodigo, dxi.dianombre
	FROM 
	(
		SELECT di.adnegreso, MIN(di.diacodigo) dx_oid
		FROM DgEmpres21..adndiaegr di
		WHERE di.tipo = 1
		GROUP BY di.adnegreso
	) di
	JOIN DgEmpres21..gendiagno dxi ON di.dx_oid = dxi.oid
), 
dx_egreso (egreso_oid, dx_egr_cod, dx_egr_nombre)
AS
(
	SELECT di.adnegreso, dxi.diacodigo, dxi.dianombre
	FROM 
	(
		SELECT di.adnegreso, MIN(di.diacodigo) dx_oid
		FROM DgEmpres21..adndiaegr di
		WHERE di.tipo = 5
		GROUP BY di.adnegreso
	) di
	JOIN DgEmpres21..gendiagno dxi ON di.dx_oid = dxi.oid
)*/
----------------------------------------------------------------------------------------------------------------------
/*SELECT 
	pac.pacnumdoc documento
	,ing.ainconsec ingreso
	,convert(date,ing.AINFECING,107) fecha
	,RTRIM(pac.pacprinom) + ' ' + RTRIM(pac.pacsegnom) + ' ' + RTRIM(pac.pacpriape) + ' ' + RTRIM(pac.pacsegape) paciente
	,con.GECCODIGO contrato
	,con.GECNOMENT entidad
	,dxi.dx_ing_cod dx_ing
	,dxi.dx_ing_nombre nom_dx_ing
	,dxe.dx_egr_cod dx_egre
	,dxe.dx_egr_nombre nom_dx_egre
	,inc.HCIDIASINC Dia
	,substring(convert(VARCHAR, HCIFECINI),1,11) Inicio
	,med.GMECODIGO Cod_Med
	,med.GMENOMCOM Medico
	,com.gcmcodigo cod_emp
	,com.gcmnombre empresa
	,fac.SFANUMFAC as Num_factura
	,fac.SFATOTFAC as Total_Facturado
FROM dgempres21..ADNINGRESO ing 
	INNER JOIN dgempres21..GENPACIEN pac on ing.GENPACIEN=pac.OID
	INNER JOIN dgempres21..GENDETCON det	on ing.GENDETCON=det.OID
	INNER JOIN dgempres21..GENCONTRA con	on det.GENCONTRA1=con.OID
	INNER JOIN DgEmpres21..GENCOMPANIA com	on pac.GENEMPRESA=com.OID
	LEFT JOIN dgempres21..ADNEGRESO egre	on egre.ADNINGRESO=ing.OID
	LEFT JOIN dx_ingreso dxi				on dxi.egreso_oid=egre.OID
	LEFT JOIN dx_egreso dxe					on dxe.egreso_oid =egre.OID
	LEFT JOIN dgempres21..HCNINCAPA inc		on inc.ADNINGRESO=ing.OID and inc.GENPACIEN=pac.OID
	LEFT JOIN dgempres21..GENMEDICO med		on inc.GENMEDICO=med.OID
	INNER JOIN DGEMPRES21..SLNFACTUR fac on fac.ADNINGRESO=ing.OID
WHERE 
	ing.ainfecing >= @fch_inicio
	AND ing.ainfecing <= @fch_fin
	AND (det.gdecodigo like '%02' or det.gdecodigo like '%021')
	AND (det.GDECODIGO=@contrato or @contrato='')
GROUP BY 
	pac.pacnumdoc 
	,ing.ainconsec
	,convert(date,ing.AINFECING,107)
	,RTRIM(pac.pacprinom) + ' ' + RTRIM(pac.pacsegnom) + ' ' + RTRIM(pac.pacpriape) + ' ' + RTRIM(pac.pacsegape)
	,con.GECCODIGO
	,con.GECNOMENT
	,dxi.dx_ing_cod
	,dxi.dx_ing_nombre
	,dxe.dx_egr_cod
	,dxe.dx_egr_nombre
	,inc.HCIDIASINC
	,substring(convert(VARCHAR, HCIFECINI),1,11) 
	,med.GMECODIGO 
	,med.GMENOMCOM 
	,com.gcmcodigo 
	,com.gcmnombre 
	,fac.SFANUMFAC
	,fac.SFATOTFAC
ORDER BY convert(date,ing.AINFECING,107),pac.PACNUMDOC,ing.ainconsec*/
----------------------------------------------------------------------------------------------------------------------
