use DGEMPRES01
select top 5 AINESTADO, AINTIPING, AINURGCON, * from ADNINGRESO where AINCONSEC in (DMORTIZ)
select top 5 AINESTADO, AINTIPING, ADNEGRESO, * from ADNINGRESO where AINCONSEC in (1452364)
select top 5 * from ADNEGRESO where ADNINGRESO=1788667
select top 5 * from CDO02_21..cfg_parametro_general WHERE parametro = 411

select * from CDO02_21..rep_consulta WHERE query like '%GENCONTRA%'
select * from CDO02_21..rep_consulta WHERE query like '%GENDETCON%'

select * from DGEMPRES01..GENUSUARIO where OID='748'-----567
select * from DGEMPRES01..GENUSUARIO where usunombre in ('yacarpio','MBUSTOS')-----567
select * from DGEMPRES21..GENUSUARIO where usunombre in ('MBUSTOZ','MBUSTOS')-----567
select * from DGEMPRES01..GENUSUARIO where USUDESCRI like '%valentina%'-----567
select * from DGEMPRES01..GELOG202201 where GENUSUARIO=457 order by OID desc
select * from DGEMPRES01..GELOG202106 where GENUSUARIO=10 order by OID desc
select * from DGEMPRES01..XPObjectType where OID in (1530)

declare @usuario varchar(20) = 'CAPLOZANO'

select aud.AUDFECHA Fecha_Login, aud.AUDDETALLE Detalle
, SUBSTRING(aud.AUDCOMPUTA, 0, 12) Equipo, SUBSTRING(aud.AUDCOMPUTA, LEN(aud.AUDCOMPUTA) - 15, 15) Dir_IP
from DGEMPRES01..GELOG202106 aud inner join DGEMPRES01..GENUSUARIO usu ON aud.GENUSUARIO=usu.OID
where AUDOIDTIP=1530 and usu.USUNOMBRE=@usuario


select top 5 * from CDO02_21..rep_consulta_parametro where descripcion like '%usuario%'

select 500, * from GELOG202105 where GENUSUARIO=373 order by OID desc
select top 5 * from GENSERIPS where SIPCODIGO='882201'

select * from gelog201605 where AUDOIDTIP=557 and AUDOIDENT=4521
select * from XPObjectType where OID in (557)
select * from GENUSUARIO where OID in (1161)

sp_who3 lock
sp_who3 84
KILL 275

select * from GENTERCER where oid in (662445, 662020)
select * from GENTERCERC where oid in (46265, 46266)

select * from GENPACIEN where OID in (
select GENPACIEN from HCNFOLIO where OID in (select HCNFOLIO from HCNMEDPAC where oid in (9631545, 9631500, 9631499, 9631419, 9631310)))

select * from HCNFOLIO where OID in (select HCNFOLIO from HCNMEDPAC where oid in (9631545, 9631500, 9631499, 9631419, 9631310))
select * from HCNMEDPAC where oid in (9631545, 9631500, 9631499, 9631419, 9631310)
select top 5 * from HCNJMNPOS order by oid desc

select top 5 AINESTADO, * from ADNINGRESO where AINCONSEC in (1444422, 1449044)
select top 5 SFADOCANU, * from SLNFACTUR where ADNINGRESO in (1779778, 1785162)

select top 5 * from GENUSUARIO where OID in (2684)

sp_who3 lock

select * from GENCONSEC where GCONOMBRE like '%compra%'

select top 5 * from GENSERIPS where OID=3196
select top 5 * from GENMANSER where OID=127531
select top 5 * from GENPLACUB where GENMANSER1=127531
select top 5 * from SLNSERHOJ where OID=20439718

select * from GENMANSER where GENSERIPS1 in (35016)


select * from GENUSUPER where PERNOMBRE like '%DESBLO%'
select * from GENUSUPER where PERNOMBRE like '%DESBLO%' AND GENUSUARIO=770

select * from GENUSUPER where PEROPCION='GE6'
select * from GENROLPER where PEROPCION='GE6' and GENROL not in (1, 2, 37, 66, 98)

select * from GENROLPER where PEROPCION='GE6' and PERACCION8=1 and PERACCION9=1
select * from GENROL where OID in (1, 2, 37, 66, 98)

select * from DGEMPRES01..GENDOCUME
select * from dgempres22..GENDOCUME

begin tran xxx
delete GENUSUPER where PEROPCION='GE6'
delete GENROLPER where PEROPCION='GE6' and GENROL not in (1, 2, 37, 66, 98)

update GENUSUPER set PERACCION1=0, PERACCION2=0, PERACCION3=0, PERACCION4=0, PERACCION5=0, PERACCION6=0, PERACCION7=0, PERACCION8=0,
PERACCION9=0, PERACCION10=0, PERACCION11=0 where PEROPCION='GE6'
/*update GENROLPER set PERACCION1=0, PERACCION2=0, PERACCION3=0, PERACCION4=0, PERACCION5=0, PERACCION6=0, PERACCION7=0, PERACCION8=0,
PERACCION9=0, PERACCION10=0, PERACCION11=0 where GENROL in (1, 2, 37, 66, 98)*/
update GENROLPER set PERACCION8=1, PERACCION9=1 where PEROPCION='GE6' and GENROL in (1, 2, 37, 66, 98)
rollback tran xxx
commit tran xxx

select * from dgempres22..GENROLPER

select top 5 * from GENMANTAR where OID=2172984
select top 5 * from GENMANTAR where GENMANSER1=703610
select top 5 * from GENMANSER where OID=703862
select top 5 * from GENSERIPS where OID=167
select top 5 * from GENMANUAL where OID=116

update GENMANTAR set SMTFECFIN='2013-12-11 23:59:59' where OID=1085129

select top 5 * from GEENENTADM where ENTCODIGO in ('CON003','RES001','RES003')

update GEENENTADM set ENTCODIGO='RES005' where OID=98
update GEENENTADM set ENTCODIGO='RES001' where OID=11

select * from DGEMPRES01..GELOG202105 where AUDFECHA>'20210527' AND GENUSUARIO=748 order by OID desc