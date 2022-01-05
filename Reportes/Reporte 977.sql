-----------------------------------------------------------------------------------------------------------------------------------
declare @fch_inicio datetime = '2016-01-10 00:00:00'
declare @fch_fin    datetime = '2016-22-10 08:00:00'
-----------------------------------------------------------------------------------------------------------------------------------
select soli.id, pac.pacnumdoc as documento, ing.ainconsec as ingreso
, RTRIM(pac.pacprinom)+' '+RTRIM(pac.pacsegnom)+' '+RTRIM(pac.pacpriape)+' '+RTRIM(pac.pacsegape) as paciente
, estado.nombre as estado, u.codigo as responsable, us.codigo as usuario
, nota.secuencia as secuencia, nota.texto as texto, soli.fch_creacion as fecha_creación, cam.HCACODIGO cama
from CDO02_21..asi_autorizacion_solicitud_interna_ingreso sol INNER JOIN
CDO02_21..asi_autorizacion_solicitud_interna_nota nota on  nota.autorizacion_solicitud_interna=sol.autorizacion_solicitud_interna
INNER JOIN DgEmpres21..adningreso ing ON sol.ingreso   = ing.oid
INNER JOIN DgEmpres21..GENPACIEN pac ON ing.GENPACIEN=pac.OID
INNER JOIN CDO02_21..asi_autorizacion_solicitud_interna soli on soli.id=sol.autorizacion_solicitud_interna
           and soli.id=nota.autorizacion_solicitud_interna
INNER JOIN CDO02_21..cfg_usuario u ON soli.usuario_solicita = u.id 
INNER JOIN CDO02_21..cfg_usuario us ON nota.usuario = us.id 
INNER JOIN CDO02_21..asi_autorizacion_solicitud_interna_estado estado on soli.estado=estado.id
LEFT JOIN DgEmpres21..HPNDEFCAM  cam ON ing.HPNDEFCAM = cam.OID
where nota.fch_creacion >= @fch_inicio
and nota.fch_creacion <= @fch_fin
--and nota.texto like '%trazadora%'
order by soli.id, nota.secuencia
-----------------------------------------------------------------------------------------------------------------------------------
select top 5 * from HPNDEFCAM