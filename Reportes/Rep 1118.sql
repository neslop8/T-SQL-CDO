------------------------------------------------------------------------------------------------------------------------------
declare @INGRESO char(20) = '46181'
------------------------------------------------------------------------------------------------------------------------------
select ing.AINCONSEC ingreso, pac.PACNUMDOC identidad, RTRIM(LTRIM(GPANOMCOM)) Nombre_Paciente
, med.GMECODIGO usuario, dact.HCRHORREG fecha_Actividad
, CASE(act.HCTIPACT) when 38 then 'Canula_Nasal' when 39 then 'Ventury' when 40 then 'Hood' when 41 then 'Traqueostomia'
					 when 42 then 'Aspiracion_Secrecion' when 43 then 'Tubo_Orotraqueal' when 44 then 'Ventilación_Mecanica' 
					 when 45 then 'Otro' when 67 then 'CPAP' end Oxigeno_Terapia
, dact.HCAOBSERV __________observacion___________
from DGEMPRES02..HCNACTENF act inner join DGEMPRES02..HCNACTENFD dact ON dact.HCNACTENF=act.OID
inner join dgempres02..HCNREGENF reg on act.HCNREGENF=reg.OID
inner join dgempres02..GENPACIEN pac on reg.GENPACIEN=pac.OID
inner join dgempres02..ADNINGRESO ing on reg.ADNINGRESO=ing.OID and ing.genpacien=pac.oid
inner join dgempres02..GENMEDICO med on dact.GENMEDICO=med.OID
where ing.ainconsec = @INGRESO and act.HCTIPACT in (38, 39, 40, 41, 42, 43, 44, 45, 67)
order by 6, 5 
------------------------------------------------------------------------------------------------------------------------------
