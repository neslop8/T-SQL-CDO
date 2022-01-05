----------------------------------------------------------------------------------------------------------------------------------
declare @fch_inicio   datetime = '2020-01-08 00:00:00'
declare @fch_fin      datetime = '2020-30-09 23:59:59'
declare @area         char(20) = 'DX-506'
--------------------------------------------------------------------------------------------------------------------------------
SELECT ser.oid, ing.AINCONSEC Ingreso, pac.PACNUMDOC Identificacion, ing.AINFECING fecha_ingreso, ing.AINFECFAC fecha_factura
    , pac.gpanomcom paciente, det.GDECODIGO contrato, det.GDENOMBRE plan_de_beneficio
	, ord.SOSORDSER Orden, ips.SIPCODIGO codigo, ips.SIPNOMBRE servicio
	, CONVERT(bigint, ser.SERCANTID) Cantidad, convert(bigint, ser.SERVALPRO) Val_ent
	, convert(bigint, (CONVERT(bigint, ser.SERCANTID) * convert(bigint, ser.SERVALPRO))) total
	, usu.USUNOMBRE usu_crea_orden
	, CASE(ing.AINTIPING) when 1 THEN 'AMBULATORIO' ELSE 'HOSPITALARIO'END TIPO
FROM DGEMPRES01..ADNINGRESO ing inner join DGEMPRES01..GENPACIEN  pac  on ing.GENPACIEN=pac.OID
	inner join DGEMPRES01..GENDETCON  det  on ing.GENDETCON=det.OID
	inner join DGEMPRES01..SLNORDSER  ord  on ord.ADNINGRES1=ing.OID
    inner join DGEMPRES01..SLNSERPRO  ser  on ser.ADNINGRES1=ing.OID AND ser.SLNORDSER1=ord.OID 
	inner join DGEMPRES01..GENMEDICO  med  on ser.GENMEDICO1=med.OID
	inner join DGEMPRES01..GENUSUARIO usu  on ord.GENUSUARIO1=usu.OID
	inner join DGEMPRES01..SLNSERHOJ  hoj  on ser.OID=hoj.OID
	inner join DGEMPRES01..GENSERIPS  ips  on hoj.GENSERIPS1=ips.OID
	inner join DGEMPRES01..GENARESER  arep on ips.GENARESER1=arep.OID 
WHERE ing.AINFECING >= @fch_inicio 
	and ing.AINFECING <= @fch_fin 
	--and ing.AINESTADO <> 2
	and ing.AINESTADO = 1
	and ord.sosestado<>2
	--and arep.GASCODIGO = 'DX-506'
	and arep.GASCODIGO = 'P07'
ORDER BY ing.AINFECING, ser.OID
--------------------------------------------------------------------------------------------------------------------------------
--sp_who3 lock
--------------------------------------------------------------------------------------------------------------------------------