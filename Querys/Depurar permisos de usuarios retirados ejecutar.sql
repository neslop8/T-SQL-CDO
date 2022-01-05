----------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------
begin tran xxx-----Permisos a cajas de tesoreria
delete DgEmpres01..TSNCAJAUT where GENUSUARIO in (select OID from DgEmpres01..GENUSUARIO where USUESTADO IN (0,3,4))
rollback tran xxx
commit tran xxx
---------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------
begin tran xxx-----Permisos a Historia Clínica
delete DgEmpres01..HCNTHAUTOR where GENUSUARIO in (select OID from DgEmpres01..GENUSUARIO where USUESTADO IN (0,3,4))
rollback tran xxx
commit tran xxx
---------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------
begin tran xxx-----Permisos a reportes de la Intranet
delete CDO02_21..rep_consulta_usuario where usuario in (
select id from CDO02_21..cfg_usuario where OID in(
select OID from DgEmpres01..GENUSUARIO where USUESTADO IN (0,3,4)))
rollback tran xxx
commit tran xxx
---------------------------------------------------------------------------------------------------------------------------
begin tran xxx-----Permisos a areas de servicios de facturacion
delete DgEmpres01..GENAUTARE where GENUSUARIO1 in (select OID from DgEmpres01..GENUSUARIO where USUESTADO IN (0,3,4))
rollback tran xxx
commit tran xxx
---------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------
begin tran xxx-----Permisos a almacenes de inventarios
delete DgEmpres01..INNAUTUSA where GENUSUARIO in (select OID from DgEmpres01..GENUSUARIO where USUESTADO IN (0))-----INACTIVO
delete DgEmpres01..INNAUTUSA where GENUSUARIO in (select OID from DgEmpres01..GENUSUARIO where USUESTADO IN (3))-----INACTIVO
delete DgEmpres01..INNAUTUSA where GENUSUARIO in (select OID from DgEmpres01..GENUSUARIO where USUESTADO IN (4))-----RETIRADO
rollback tran xxx
commit tran xxx
---------------------------------------------------------------------------------------------------------------------------
begin tran xxx-----Permisos a Modificación de Ingresos
delete DgEmpres01..ADNAUSNOING WHERE GENUSUARIO in (select OID from DgEmpres01..GENUSUARIO where USUESTADO IN (0))-----INACTIVO
delete DgEmpres01..ADNAUSNOING WHERE GENUSUARIO in (select OID from DgEmpres01..GENUSUARIO where USUESTADO IN (3))-----INACTIVO
delete DgEmpres01..ADNAUSNOING WHERE GENUSUARIO in (select OID from DgEmpres01..GENUSUARIO where USUESTADO IN (4))-----INACTIVO
rollback tran xxx
commit tran xxx
---------------------------------------------------------------------------------------------------------------------------
select * from CDO02_21..cfg_usuario where OID in(select OID from DgEmpres01..GENUSUARIO where USUESTADO IN (0,3,4))
select * from CDO02_21..cfg_usuario where id in(select OID from DgEmpres01..GENUSUARIO where USUESTADO IN (0,3,4))
---------------------------------------------------------------------------------------------------------------------------
select * from CDO02_21..cfg_usuario where OID is not null---1440
select * from DGEMPRES01..GENUSUARIO order by OID desc---1421
select * from CDO02_21..cfg_usuario where codigo in ('ANSUTA')
---------------------------------------------------------------------------------------------------------------------------
select * from CDO02_21..cfg_usuario where codigo collate Modern_Spanish_CI_AS in (
select USUNOMBRE from DGEMPRES01..GENUSUARIO where USUESTADO IN (0,3,4))

select * from CDO02_21..cfg_usuario where OID in (
select OID from DGEMPRES01..GENUSUARIO where USUESTADO IN (0,3,4))
---------------------------------------------------------------------------------------------------------------------------
begin tran xxx
Update CDO02_21..cfg_usuario set OID =usu.OID
from DGEMPRES01..GENUSUARIO usu inner join CDO02_21..cfg_usuario cdo ON usu.USUNOMBRE collate Modern_Spanish_CI_AS = cdo.codigo
commit tran xxx
---------------------------------------------------------------------------------------------------------------------------
select * from CDO02_21..rep_consulta_usuario---5534
select * from CDO02_23..rep_consulta_usuario---5534

select c23.usuario 
from CDO02_23..rep_consulta_usuario c23 inner join CDO02_21..rep_consulta_usuario c21 ON c23.usuario=c21.usuario and c23.consulta=c21.consulta
group by c23.usuario

select c23.usuario
from CDO02_23..rep_consulta_usuario c23 left join CDO02_21..rep_consulta_usuario c21 ON c23.usuario=c21.usuario and c23.consulta=c21.consulta
group by c23.usuario

select c23.* 
from CDO02_23..rep_consulta_usuario c23 right join CDO02_21..rep_consulta_usuario c21 ON c23.usuario=c21.usuario and c23.consulta=c21.consulta

delete cdo02_21..rep_consulta_usuario where usuario=542

select * from cdo02_21..rep_consulta_usuario where usuario in (36,48,63,189,208,466,480,483,522,532,558,609,646,653,666,696,702,745,763,825,911,
1051,1137,1140,1150,1182,1209,1266,1327,1364,1460,2035,2469,2790,3318,3478,3539,3577,3613,3704,3736,3960,3962,4023,4070,4097,4110,4120,4127,4128,
4161,4170,4189,4193,4202,4236)

select usuario from CDO02_21..rep_consulta_usuario group by usuario
select usuario from CDO02_23..rep_consulta_usuario group by usuario

begin tran xxx
insert into cdo02_21..rep_consulta_usuario
select * from CDO02_23..rep_consulta_usuario where usuario in (542)
commit tran xxx

select * from cdo02_21..rep_consulta_usuario where usuario in (542)
select * from cdo02_22..rep_consulta_usuario where usuario in (542)
select * from cdo02_23..rep_consulta_usuario where usuario in (542)
