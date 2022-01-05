--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
declare @fch_inicio datetime = '2020-10-01 00:00:00'
declare @fch_fin    datetime = '2020-15-01 23:59:59'
declare @contrato   char(20) = ''
declare @centro   char(20) = ''
--------------------------------------------------------------------------------------------------------------------------------
SELECT ing.ainconsec ingreso, ing.ainfecing fch_ingreso, p.pacnumdoc documento
	,RTRIM(p.pacpriape) + ' ' + RTRIM(p.pacsegape) + ' ' + RTRIM(p.pacprinom) + ' ' + RTRIM(p.pacsegnom) AS nombre
	,p.gpafecnac fch_nacimiento, case(p.gpasexpac) when 1 then 'Mas' when 2 then 'Fem' else 'Otro' end sexo
	,pd.pacdireccion dir, pt.pactelefono tel, cd.gdecodigo contrato_cod, cd.gdenombre contrato_nombre, ing.ainacudie acudiente
	,u.usunombre usuario, cen.ACACODIGO cod, cen.ACANOMBRE centro
	,case(ing.ainestado) when 0 then 'REGISTRADO' when 1 then 'FACTURADO' when 2 then 'ANULADO' 
		when 3 then 'BLOQUEADO' end as ESTADO
	,case(ing.aintiping) when 1 then 'AMBULATORIO' when 2 then 'HOSPITALARIO' end as TIPO
	,case(ing.ainurgcon) when 0 then 'URGENCIA' when 1 then 'CON-EXT' when 2 then 'NACIDO' when 3 then 'REMITIDO'
		when 4 then 'HOSPITALIZACION U' when 5 then 'HOSPITALIZACION' end as Ingreso_Por
	, ing.AINOBSERV Observacion
FROM DgEmpres21..adningreso ing INNER JOIN DgEmpres21..gendetcon cd  ON ing.gendetcon = cd.oid
	INNER JOIN DgEmpres21..genusuario u  ON ing.geenusuario = u.oid
	INNER JOIN DgEmpres21..genpacien p   ON ing.genpacien = p.oid
	INNER JOIN DgEmpres21..genpaciend pd ON p.genpaciend = pd.oid
	INNER JOIN DgEmpres21..genpacient pt ON p.genpacient = pt.oid
	INNER JOIN DgEmpres21..ADNCENATE cen ON ing.ADNCENATE = cen.OID
WHERE ing.AINESTADO <> 2 
	AND ing.ainfecing >= @fch_inicio 
	AND ing.ainfecing <= @fch_fin
	AND (cd.GDECODIGO = @contrato or @contrato='')
	and (cen.ACACODIGO = @centro or @centro='')
ORDER BY ing.AINCONSEC
--------------------------------------------------------------------------------------------------------------------------------