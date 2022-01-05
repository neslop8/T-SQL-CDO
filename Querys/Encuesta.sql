use CDO02_21
select * from rep_encuesta
select * from rep_encuesta_formato
select * from rep_encuesta_formato_pregunta_opcion
select * from rep_encuesta_formato_pregunta_texto
select * from rep_encuesta_muestra

select COUNT(*) from rep_encuesta_respuesta where encuesta=10
select * from rep_encuesta_respuesta_opcion where respuesta >= 17027
select * from rep_encuesta_respuesta_texto where respuesta >= 17027

select * from cfg_parametro_equipo
select * from cfg_parametro_general
select * from cfg_parametro_persona_juridica
select * from cfg_parametro_usuario
select * from cfg_pendiente_link
select * from cfg_parametro where nombre like '%encuesta%'
select * from cfg_pendiente_tarea
select * from cfg_pendiente_usuario where pendiente=132
select * from cfg_usuario where codigo='NFLOPEZ'
select * from cfg_usuario where estado=1 and id > 0


UPDATE cfg_pendiente_usuario set activo=0 where pendiente = 138
select * from cfg_pendiente_usuario

select pendiente, COUNT(*) from cfg_pendiente_usuario group by pendiente

begin tran xxx
insert into CDO02_21..cfg_pendiente_usuario  select 140, id, 1 from cfg_usuario where estado=1 and id > 0
rollback tran xxx
commit tran xxx

select top 5 * from CDO02_21..cfg_pendiente_tarea

sp_who3 lock

SELECT pendiente, RTRIM(texto) nom FROM CDO02_21..cfg_pendiente_tarea

select * from DGEMPRES21..XPObjectType