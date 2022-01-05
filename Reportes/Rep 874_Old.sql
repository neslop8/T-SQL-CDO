WITH primer_folio(ingreso, oid) AS (  select fol.adningreso, min(fol.oid)  
	from dgempres21..hcnfolio fol inner join dgempres21..adningreso ing on fol.adningreso=ing.oid  
	where ing.AINFECING >= @fch_inicio and ing.AINFECING <= @fch_fin and ing.ainurgcon = 0  group by fol.adningreso)  
------------------------------------------------------------------------------------  
	SELECT pac.pacnumdoc documento_paciente  
	, RTRIM(tri.gpanombre) + ' ' + RTRIM(tri.gpasegnom) + ' ' + RTRIM(tri.gpaapelli) + ' ' + RTRIM(tri.gpasegape) paciente   
	, tri.gpadocume documento_triage, are.gascodigo cod_area, are.gasnombre area_servicio  , tri.hctnumero triage
	, tri.hctfectri fecha_tri, ing.ainconsec ingreso, ing.ainfecing fecha_ing 
	, acuc.fch_evento llamado , fol.hcfecfol fecha_p_folio
	, usu.usunombre codigo_usuario_ingreso, med.gmecodigo codigo_medico_triage , cla.HCCODIGO triage
	, (datediff(minute, tri.hctfectri, ing.ainfecing)) triage_a_ingreso  
	, (datediff(minute, ing.ainfecing, acuc.fch_evento)) ingreso_a_llamado
	, (datediff(minute, acuc.fch_evento, fol.hcfecfol)) llamado_a_folio
	, ((datediff(minute, tri.hctfectri, ing.ainfecing)) + (datediff(minute, ing.ainfecing, fol.hcfecfol))) total	
	from primer_folio pf inner join dgempres21..adningreso ing on pf.ingreso=ing.oid  
	inner join dgempres21..genpacien pac on ing.genpacien=pac.oid  
	inner join dgempres21..hcnfolio fol on pf.oid=fol.oid  
	inner join dgempres21..hcntriage tri on tri.adningreso=ing.oid and ing.hcentriage=tri.oid  
	inner join dgempres21..genusuario usu on ing.geenusuario=usu.oid  
	inner join dgempres21..genmedico med on tri.genmedico=med.oid  
	inner join dgempres21..genareser are on ing.genareser=are.oid 
	inner join dgempres21..HCNCLAURGTR cla on tri.HCNCLAURGTR=cla.OID 
	inner join dgempres21..GENDETCON det on ing.GENDETCON=det.OID
	left join CDO02_21..asi_control_urgencia acu on acu.ingreso=ing.OID
	left join CDO02_21..asi_control_urgencia_cambio acuc on acuc.control_urgencia=acu.id and acuc.evento=52
	where (are.gascodigo = @area OR @area='') 
	and (cla.HCCODIGO = @triage OR @triage='')  
	and (det.GDECODIGO=@contrato or @contrato='')
	--and ing.AINCONSEC = 954242
	order by tri.hctnumero