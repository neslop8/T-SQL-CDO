---------------------------------------------------------------------------------------------------------------------------------------
declare @fch_inicio datetime = '2016-01-08 00:00:00'
declare @fch_fin    datetime = '2016-31-08 00:00:00'
declare @plan       char(10) = ''
---------------------------------------------------------------------------------------------------------------------------------------
select pac.pacnumdoc documento, ing.ainconsec ingreso, ing.ainfecing fecha_ingreso, are.GASCODIGO codigo, are.GASNOMBRE area
, RTRIM(pac.pacprinom) + ' ' + RTRIM(pac.pacsegnom) + ' ' + RTRIM(pac.pacpriape) + ' ' + RTRIM(pac.pacsegape) paciente
, ROUND((CONVERT (INT, GETDATE()) - CONVERT(INT, pac.gpafecnac)) / 365, 0) edad
, case(ing.ainestado) when 0 then 'Reg' when 1 then 'Fac' when 2 then 'Anu' when 3 then 'Bloq' end estado
, det.gdecodigo cod_contra, det.gdenombre plan_beneficio, usu.USUNOMBRE usu_crea
, CASE pac.gpasexpac WHEN '1' THEN 'masculino' ELSE 'femenino' END sexo 
, tri.HCTNUMERO consec_tri, tri.HCNCLAURGTR clasificacion, tel.PACTELEFONO
/*, esp.cant1, esp.nom_esp1, esp.cant2, esp.nom_esp2, esp.cant3, esp.nom_esp3, esp.cant4, esp.nom_esp4
, esp.cant5, esp.nom_esp5, esp.cant6, esp.nom_esp6, esp.cant7, esp.nom_esp7, esp.cant8, esp.nom_esp8
, esp.cant9, esp.nom_esp9, esp.cant10, esp.nom_esp10*/
, esp.*, di.*
from dgempres21..ADNINGRESO ing inner join dgempres21..GENPACIEN pac on ing.genpacien=pac.oid
inner join dgempres21..GENDETCON  det on ing.gendetcon=det.oid
inner join dgempres21..GENUSUARIO usu on ing.GEENUSUARIO=usu.OID
left join dgempres21..GENARESER   are on ing.GENARESER=are.OID
left join dgempres21..HCNTRIAGE   tri on ing.HCENTRIAGE=tri.OID
left join dgempres21..GENPACIENT  tel on tel.GENPACIEN=pac.OID
CROSS APPLY CDO02_21.dbo.f_esp_hc_10(ING.oid) esp
CROSS APPLY CDO02_21.dbo.f_dx_hc_10(ing.oid) di
where ing.AINFECING >= @fch_inicio
and   ing.AINFECING <= @fch_fin
and   (det.gdecodigo = @plan or @plan = '')
order by ing.ainfecing asc
---------------------------------------------------------------------------------------------------------------------------------------