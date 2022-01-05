-----------------------------------------------------------------------------------------------------------------------
declare @fch_inicio datetime = '2021-01-04 00:00:00'
declare @fch_fin    datetime = '2021-08-04 23:59:59'
declare @contrato varchar(20) = ''
declare @centro varchar(20) = ''  
declare @tipoingreso varchar(20) = '' 
-----------------------------------------------------------------------------------------------------------------------561
select pac.PACNUMDOC documento, ing.AINCONSEC ingreso, ing.AINFECING fec_ing
, CASE ing.ainurgcon WHEN 0 THEN 'URGENCIAS' WHEN 1 THEN 'CONSULTA EXTERNA' WHEN 2 THEN 'NACIDO' WHEN 3 THEN 'REMITIDO' WHEN 4 THEN 'HOSPITALIZACION URGENCIAS' 
		WHEN 5 THEN 'HOSPITALIZACION' WHEN 6 THEN 'IMAGENES' WHEN 7 THEN 'LABORATORIO' ELSE 'OTRO' END AS Ingreso_Por
, CASE ing.AINAMBTRA WHEN 1 THEN 'Con_Tratamiento' else 'Sin_Tratamiento' end Tratamiento
, ing.AINNUMAUT Autorización, egr.ADEFECSAL fec_egreso, RTRIM(pac.GPANOMCOM) paciente 
, ROUND((CONVERT (INT, GETDATE()) - CONVERT(INT, pac.gpafecnac)) / 365, 0) edad
, CASE (pac.PACTIPDOC) WHEN 0 THEN '' WHEN 1 THEN 'CC' WHEN 2 THEN 'CE' WHEN 3 THEN 'TI' WHEN 4 THEN 'RC' WHEN 5 THEN 'PA' WHEN 6 THEN 'AS' 
                       WHEN 7 THEN 'MS' WHEN 8 THEN '' WHEN 9 THEN 'SC' WHEN 10 THEN 'NV' WHEN 11 THEN 'CD' WHEN 12 THEN 'PE' ELSE 'Otro' END AS Tipo_Doc
, CASE pac.gpasexpac WHEN '1' THEN 'Mas' ELSE 'Fem' END Sexo
, det.GDECODIGO plan_beneficio, det.GDENOMBRE pagador, ter.TERNUMDOC nit, CASE (cen.ACACODIGO) WHEN 1 THEN 'CDO' ELSE 'CIMO' end centro
, case(ing.AINTIPING) when 1 then 'Ambulatorio' when 2 then 'Hospitalario' else 'otro' end Tipo_ingreso
, case(ing.ainestado) when 0 then 'Registrado' when 1 then 'Facturado' when 2 then 'Anulado' when 3 then 'Bloqueado' else 'Cerrado' end estado
, fac.SFANUMFAC factura, fac.SFAFECFAC fec_fac
, case(fac.SFADOCANU) when 0 then 'Activa' when 1 then 'Anulada' else 'Sin_Facturar' end Estado_Factura
, convert(bigint, fac.SFAVALPAC) Valor_Paciente, convert(bigint, fac.SFAVALCAR) Valor_Cartera
, usuI.USUNOMBRE Usuario_Ingreso, usuF.USUNOMBRE Usuario_Factura
, ser.GASCODIGO Cod_Area, ser.GASNOMBRE Area_Servicio
, ing.AINMOTANU Motivo_Anulación, cie.ACIMOTIVO Motivo_Cierre
from dgempres01..ADNINGRESO ing inner join dgempres01..GENPACIEN  pac on ing.GENPACIEN=pac.OID
inner join dgempres01..ADNCENATE  cen  on ing.ADNCENATE=cen.OID
inner join DGEMPRES01..GENUSUARIO usuI on ing.GEENUSUARIO=usuI.OID
inner join dgempres01..GENDETCON   det on ing.GENDETCON=det.OID 
inner join dgempres01..GENTERCER   ter on det.GENTERCER1=ter.OID
left join dgempres01..ADNEGRESO  egr   on egr.ADNINGRESO=ing.OID and ing.ADNEGRESO=egr.OID
left join dgempres01..SLNFACTUR   fac  on fac.ADNINGRESO=ing.OID
left join dgempres01..GENUSUARIO  usuF on fac.GENUSUARIO1=usuF.OID
left join dgempres01..GENARESER   ser  on ing.GENARESER=ser.OID
left join DGEMPRES01..ADNCIADMIN  cie  on cie.ADNINGRESO=ing.OID
where ing.AINFECING >= @fch_inicio
  and ing.AINFECING <= @fch_fin
  and (det.GDECODIGO =  @contrato or @contrato='')
  and (cen.ACACODIGO = @centro or @centro='')
  and (CONVERT(VARCHAR(1),ing.AINTIPING) = SUBSTRING(@tipoingreso,1,1) OR @tipoingreso='')
order by cen.ACACODIGO, det.GDECODIGO
-----------------------------------------------------------------------------------------------------------------------
select AINESTADO, * from DGEMPRES01..ADNINGRESO where AINCONSEC in (111373, 111409)--Anulados
select AINESTADO, * from DGEMPRES01..ADNINGRESO where AINCONSEC in (111457, 114058, 113226, 113213)--Cerrados
select top 5 * from DGEMPRES01..ADNCIADMIN order by OID desc
-----------------------------------------------------------------------------------------------------------------------