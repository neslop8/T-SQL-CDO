use CDO02_21
-----------------------------------------------------------------------------------------------------------------------------------
declare @fch_inicio datetime = '20171001'
declare @fch_fin    datetime = '20171101'
-----------------------------------------------------------------------------------------------------------------------------------
select altc.fch_creacion fecha, pac.PACNUMDOC doc_nuevo
, RTRIM(pac.pacprinom)+' '+RTRIM(pac.pacsegnom)+' '+RTRIM(pac.pacpriape)+' '+RTRIM(pac.pacsegape) paciente
, ROUND((CONVERT (INT, GETDATE()) - CONVERT(INT, pac.gpafecnac)) / 365, 0) edad, altc.doc_viejo
, sol.id solicitud, usu.nombre solicita, mto.observacion
from CDO02_21..asi_log_traslado_codigo altc inner join DGEMPRES21..GENPACIEN pac on altc.doc_nuevo=pac.PACNUMDOC
inner join CDO02_21..sis_mto mto on altc.mto=mto.id
inner join CDO02_21..sis_solicitud sol on sol.mto=mto.id
inner join CDO02_21..sis_solicitud_evento sole on sol.id=sole.solicitud and sole.evento=1
--inner join CDO02_21..gen_persona per on sole.persona=per.id
inner join CDO02_21..cfg_usuario usu on sole.persona=usu.id
WHERE altc.fch_creacion >= @fch_inicio
     AND altc.fch_creacion <= @fch_fin  
-----------------------------------------------------------------------------------------------------------------------------------
select top 5 * from sis_mto where id = 212904
select top 5 * from sis_solicitud where mto = 212904
select top 5 * from sis_solicitud_evento
select top 5 * from gen_persona
select top 5 * from cfg_usuario
-----------------------------------------------------------------------------------------------------------------------------------

select * from asi_log_traslado_codigo

Existen los dos documentos
@oid_viejo:104575
@oid_nuevo:195324
ADNINGRESO:1
HCNFOLIO:2
HCNREGENF:1
HCNINCAPA:1
HCNEPICRI:0

asi_ingreso:1
asi_suministro_solicitud:0

