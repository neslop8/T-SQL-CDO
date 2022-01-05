Select usuI.USUNOMBRE Usuario_crea_Ingreso, usuB.USUNOMBRE Usuario_bloquea_Ingreso
, pac.PACNUMDOC documento, ing.AINCONSEC ingreso, ing.AINFECING fec_ing
, CASE ing.ainurgcon WHEN 0 THEN 'URGENCIAS' WHEN 1 THEN 'CONSULTA EXTERNA' WHEN 2 THEN 'NACIDO' WHEN 3 THEN 'REMITIDO' WHEN 4 THEN 'HOSPITALIZACION URGENCIAS' 
		WHEN 5 THEN 'HOSPITALIZACION' WHEN 6 THEN 'IMAGENES' WHEN 7 THEN 'LABORATORIO' ELSE 'OTRO' END AS Ingreso_Por
, ing.AINNUMAUT Autorización, RTRIM(pac.GPANOMCOM) paciente 
, ROUND((CONVERT (INT, GETDATE()) - CONVERT(INT, pac.gpafecnac)) / 365, 0) edad
, CASE (pac.PACTIPDOC) WHEN 0 THEN '' WHEN 1 THEN 'CC' WHEN 2 THEN 'CE' WHEN 3 THEN 'TI' WHEN 4 THEN 'RC' WHEN 5 THEN 'PA' WHEN 6 THEN 'AS' 
                       WHEN 7 THEN 'MS' WHEN 8 THEN '' WHEN 9 THEN 'SC' WHEN 10 THEN 'NV' WHEN 11 THEN 'CD' WHEN 12 THEN 'PE' ELSE 'Otro' END AS Tipo_Doc
, CASE pac.gpasexpac WHEN '1' THEN 'Mas' ELSE 'Fem' END Sexo
, det.GDECODIGO plan_beneficio, det.GDENOMBRE pagador, ter.TERNUMDOC nit, CASE (cen.ACACODIGO) WHEN 1 THEN 'CDO' ELSE 'CIMO' end centro
, case(ing.AINTIPING) when 1 then 'Ambulatorio' when 2 then 'Hospitalario' else 'otro' end Tipo_ingreso
, case(ing.ainestado) when 0 then 'Registrado' when 1 then 'Facturado' when 2 then 'Anulado' when 3 then 'Bloqueado' else 'Cerrado' end estado
, CASE WHEN ing.HPNDEFCAM IS NULL THEN ('Ambulatorio') ELSE cam.HCACODIGO END AS Cama
from dgempres01..ADNINGRESO ing inner join dgempres01..GENPACIEN  pac on ing.GENPACIEN=pac.OID
inner join dgempres01..ADNCENATE  cen  on ing.ADNCENATE=cen.OID
inner join DGEMPRES01..GENUSUARIO usuI on ing.GEENUSUARIO=usuI.OID
inner join dgempres01..GENDETCON   det on ing.GENDETCON=det.OID 
inner join dgempres01..GENTERCER   ter on det.GENTERCER1=ter.OID
left join DGEMPRES01..GENUSUARIO usuB on ing.AIUSUBINMED=usuB.OID
left join DgEmpres01..hpndefcam   cam  on ing.hpndefcam=cam.oid
where ing.AIBLOINMED=1
order by cen.ACACODIGO, det.GDECODIGO

begin tran xxx
update DGEMPRES01..ADNINGRESO set AIBLOINMED=0 where AINCONSEC in (162278)
commit tran xxx

select * from DGEMPRES01..ADNINGRESO where AINCONSEC in (162278)