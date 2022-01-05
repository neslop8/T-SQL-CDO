use CDO02_21
select * from cfg_pendiente_usuario where activo=1
select * from cfg_pendiente_usuario where pendiente=104

begin tran xxx
update cfg_pendiente set desactivar_en_0=0
update cfg_pendiente_usuario set activo=1 where pendiente=106
commit tran xxx

select * from DGEMPRES21..GENUSUARIO where USUESTADO=1

begin tran xxx
insert into CDO02_21..cfg_pendiente_usuario select '106', OID, '1'  from DGEMPRES21..GENUSUARIO where USUESTADO=1
commit tran xxx
rollback tran xxx

sp_who3 lock