use dgempres21
select top 5 AINESTADO, * from ADNINGRESO where AINCONSEC in (1564096)

update ADNINGRESO set AINESTADO=1 where AINCONSEC in (1376375)

select top 5 * from ADNINGRESO where AINCONSEC in (1279135)-----1602406
select GENMEDICO1 from SLNSERPRO where ADNINGRES1=1473810 group by GENMEDICO1
select * from SLNSERPRO where ADNINGRES1=1473810

select * from GENMEDICO where OID in (select GENMEDICO1 from SLNSERPRO where ADNINGRES1=1912959 group by GENMEDICO1) and GMEESTADO=1

select * from GENMEDICO where OID in (
select GENMEDICO1 from SLNPAQHOJ where SLNSERHOJ1 in (select OID from SLNSERPRO where ADNINGRES1=1912959))  and GMEESTADO=1

select top 5 * from GENUSUARIO where USUNOMBRE in ('999','NFLOPEZ')
select * from GENUSUARIO where OID in (4001,2431,2266,2267,2268,2269,2270,1071,4042,4043,4044,4045,4046,4048,4049,4050,4051)
select * from GENUSUARIO where USUULTAUT < '20200331' and USUFECCAMC < '20200331' and USUESTADO=1
select * from GENUSUARIO where USUULTAUT IS NULL and USUFECCAMC < '20200331' and USUESTADO=1 order by USUNOMBRE

begin tran xxx
update GENUSUARIO set USUULTAUT=NULL where USUNOMBRE='TECRXCDO'
update GENUSUARIO set USUESTADO=4 where USUULTAUT IS NULL and USUFECCAMC < '20200331' and USUESTADO=1
--update GENUSUARIO set USUFECCAMC='20210131' where OID in (4001,2431,2266,2267,2268,2269,2270,1071,4042,4043,4044,4045,4046,4048,4049,4050,4051)
--update GENUSUARIO set USUESTADO=4 where USUULTAUT < '20200331' and USUFECCAMC < '20200331' and USUESTADO=1
update GENUSUARIO set USUESTADO=4 where USUULTAUT IS NULL and USUFECCAMC < '20200331' and USUESTADO=1
rollback tran xxx
commit tran xxx

select top 5 * from GENUSUARIO
select top 5 * from GENMEDICO
select top 5 * from GENESPMED--Especialidades por Medico
select top 5 * from GENMEDACT--Especialidades por Medico
select top 5 * from GENMEDEST order by OID desc
---------------------------------------------------------------------------------------
select med.* 
from DGEMPRES21..GENMEDICO med inner join DGEMPRES21..GENUSUARIO usu ON med.GENUSUARIO=usu.OID
where med.GMEESTADO=0 and usu.USUESTADO=4
---------------------------------------------------------------------------------------
begin tran xxx
update DGEMPRES21..GENMEDICO set GMEESTADO=1 where OID in (
select med.OID
from DGEMPRES21..GENMEDICO med inner join DGEMPRES21..GENUSUARIO usu ON med.GENUSUARIO=usu.OID
where med.GMEESTADO=0 and usu.USUESTADO=4)
commit tran xxx
---------------------------------------------------------------------------------------Consulta de Usaurios
select * from genusuario where oid in (
select genusuario from INNAUTUSA where GENUSUARIO in (select OID from GENUSUARIO where USUESTADO in (0, 4)))
---------------------------------------------------------------------------------------Consulta de Usaurios por Almacen
select * from INNAUTUSA where GENUSUARIO in (select OID from GENUSUARIO where USUESTADO in (0, 4))
---------------------------------------------------------------------------------------
begin tran xxx-----Permisos a almacenes de inventarios
delete INNAUTUSA where GENUSUARIO in (select OID from GENUSUARIO where USUESTADO IN (0))-----INACTIVO
delete INNAUTUSA where GENUSUARIO in (select OID from GENUSUARIO where USUESTADO IN (4))-----RETIRADO
--rollback tran xxx
commit tran xxx
---------------------------------------------------------------------------------------------------------------------------
select * from GENUSUARIO where OID in (
select GENUSUARIO1 from GENAUTARE where GENUSUARIO1 in (select OID from GENUSUARIO where USUESTADO IN (0,4)) group by GENUSUARIO1)
---------------
select GENUSUARIO1 from GENAUTARE where GENUSUARIO1 in (select OID from GENUSUARIO where USUESTADO IN (0,4)) group by GENUSUARIO1
---------------
select * from GENAUTARE where GENUSUARIO1 in (select OID from GENUSUARIO where USUESTADO IN (0,4))
---------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------FA
begin tran xxx-----Permisos a areas de servicios de facturacion
delete GENAUTARE where GENUSUARIO1 in (select OID from GENUSUARIO where USUESTADO IN (0,4))
commit tran xxx
---------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------TS
begin tran xxx-----Permisos a cajas de tesoreria
delete DGEMPRES21..TSNCAJAUT where GENUSUARIO in (select OID from GENUSUARIO where USUESTADO IN (0,4))
rollback tran xxx
commit tran xxx
---------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------HC
begin tran xxx-----Permisos a Historia Clínica
delete DGEMPRES21..HCNTHAUTOR where GENUSUARIO in (select OID from GENUSUARIO where USUESTADO IN (0,4))
rollback tran xxx
commit tran xxx
---------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------Reportes
begin tran xxx-----Permisos a reportes de la Intranet
delete CDO02_21..rep_consulta_usuario where usuario in (select OID from GENUSUARIO where USUESTADO IN (0,4))
commit tran xxx
---------------------------------------------------------------------------------------------------------------------------