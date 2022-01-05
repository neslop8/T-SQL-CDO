-------------------------------------------------------------------------------------------------------------------------------------------
declare @fch_inicio   datetime = '2018-01-11 00:00:00'
declare @fch_fin      datetime = '2018-30-11 23:59:59'
declare @estado_n   char(20) = ''
-------------------------------------------------------------------------------------------------------------------------------------------
SELECT con.id, ges.secuencia ,p.pacnumdoc paciente, i.ainconsec ingreso, i.AINFECING fch_ingreso
	,RTRIM(p.pacprinom) + ' ' + RTRIM(p.pacsegnom) + ' ' + RTRIM(p.pacpriape) + ' ' + RTRIM(p.pacsegape) _____Nombre_de_Paciente_____
	,ges.fch_gestion, YEAR(ges.fch_gestion) año_gestion, MONTH(ges.fch_gestion) mes_gestion, DATENAME(MM,ges.fch_gestion) nommes_gestion
	,ges.funcionario_atiende, ges.ips, con.resumen_hc, cau.nombre causa, ges.respuesta ________Respuesta________
	,hce.nombre Estado, usu.USUNOMBRE Usuario, usu.USUDESCRI
FROM CDO02_21..his_contrarreferencia con inner join CDO02_21..his_contrarreferencia_gestion ges on ges.contrarreferencia=con.id
	INNER JOIN CDO02_21..his_contrarreferencia_causa cau on cau.id=con.causa
	INNER JOIN DgEmpres21..adningreso i ON con.ingreso = i.oid 
	INNER JOIN DgEmpres21..genpacien p ON con.paciente = p.oid 
	INNER JOIN CDO02_21..his_contrarreferencia_estado hce on con.estado=hce.id
	INNER JOIN DgEmpres21..GENUSUARIO usu on ges.usuario=usu.OID
WHERE (hce.nombre=@estado_n or @estado_n='')
	AND ges.fch_gestion >= @fch_inicio
	AND ges.fch_gestion <= @fch_fin
ORDER BY usu.usunombre
-------------------------------------------------------------------------------------------------------------------------------------------



select id, nombre from CDO02_21..his_contrarreferencia_estado