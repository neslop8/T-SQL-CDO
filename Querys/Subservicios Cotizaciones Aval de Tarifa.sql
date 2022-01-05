select top 5 * from GENSERIPS order by OID desc
select * from GENSERIPS where SIPCODIGO like 'FS411%'---HONORARIOS CIRUJANO
select * from GENSERIPS where SIPCODIGO like 'FS412%'---HONORARIOS ANESTESIA
select * from GENSERIPS where SIPCODIGO like 'FS413%'---HONORARIOS AYUDANTE
select * from GENSERIPS where SIPCODIGO like 'FS2310X%'---DERECHO DE SALA
select * from GENSERIPS where SIPCODIGO like 'FS55%'---Materiales

begin tran xxx
update GENSERIPS set SIPCODIGO='FS2310X' where OID=12490
update GENSERIPS set SIPTIPLIQ=0, SIPLIQHOS=0, SIPSUBATE=15, SIPEXAPRO=0, SIPSTSOL=0, SIPSTSOLPER=0 where SIPCODIGO like 'S23%'
commit tran xxx

select top 5 * from GENSERIPS order by OID desc
select top 5 * from GENMANSER order by OID desc

begin tran xxx
update genmanser set GENSERIPS1=12493 where OID=222828
commit tran xxx