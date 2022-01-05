-----------------------------------------------------------------------------------------------------------------------
declare @fch_inicio datetime = '2020-13-04 00:00:00'
declare @fch_fin    datetime = '2020-14-04 23:59:59'
declare @area       char(10) = ''
declare @centro     char(20) = '02'--28
-----------------------------------------------------------------------------------------------------------------------
select pac.pacnumdoc documento, ing.AINCONSEC ingreso
, RTRIM(pac.pacprinom)+' '+RTRIM(pac.pacsegnom)+' '+RTRIM(pac.pacpriape)+' '+RTRIM(pac.pacsegape) paciente
, ROUND((CONVERT (INT, GETDATE()) - CONVERT(INT, pac.gpafecnac)) / 365, 0) edad
, CASE pac.gpasexpac WHEN '1' THEN 'masculino' ELSE 'femenino' END sexo
, CASE ing.AINTIPING WHEN 1 THEN 'amb' ELSE 'hos' END tipo
, ips.SIPCODIGO codigo, ips.SIPNOMBRE servicio, sol.HCSOBSERV observacion
, sol.HCSFECSOL Fecha_Solicitud, res.HCRFECRES Fecha_Resultado
, CASE(res.HCRCONFIR) WHEN 0 THEN 'Registrado' ELSE 'Confirmado' END Estado, LEN(res.HCRDESCRIP) Tamaño
, are.GASCODIGO cod_are , DATEDIFF(MINUTE,sol.HCSFECSOL,res.HCRFECRES) espera, cen.ACACODIGO centro
, med.GMECODIGO medico, usu1.USUNOMBRE usuario_crea, usu2.USUNOMBRE usuario_confirma
from dgempres21..HCNSOLEXA sol inner join dgempres21..HCNRESEXA res on sol.HCNRESEXA=res.OID and sol.OID=res.HCNSOLEXA
inner join DGEMPRES21..ADNINGRESO ing on sol.ADNINGRESO=ing.OID
inner join DGEMPRES21..ADNCENATE cen  on ing.ADNCENATE=cen.OID
inner join DGEMPRES21..GENPACIEN pac  on ing.GENPACIEN=pac.OID
inner join DGEMPRES21..GENSERIPS ips  on sol.GENSERIPS=ips.OID
inner join DGEMPRES21..GENARESER are  on sol.GENARESER=are.OID
inner join DGEMPRES21..GENMEDICO med  on res.GENMEDICO=med.OID
inner join DGEMPRES21..GENUSUARIO usu1 on res.GENUSUARIO1=usu1.OID
inner join DGEMPRES21..GENUSUARIO usu2 on res.GENUSUARIO2=usu2.OID
where sol.HCSFECSOL >= @fch_inicio and sol.HCSFECSOL <= @fch_fin 
and  (are.GASCODIGO = @area or @area='')
and (cen.ACACODIGO = @centro or @centro='')
-----------------------------------------------------------------------------------------------------------------------



