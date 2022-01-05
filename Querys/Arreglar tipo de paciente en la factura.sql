use dgempres21
select top 5 * from ADNINGRESO where AINCONSEC in (1663665)
select top 5 gpatippac, GENESTRATO, * from slnfactur where ADNINGRESO in (2015688)
select top 5 gpatippac, * from slnfactur where sfanumfac in ('FV000004206404')
select top 5 gpatippac, * from slnfactur where sfanumfac in ('00000000462352')
select top 5 * from GENESTRATO 

select top 5 gpatippac, * from slnfactur where sfanumfac like '%439398'
select top 5 * from cdo02_21..fac_factura where numero = 'FV000004010341'
select * from cdo02_21..fac_factura_estado
select top 5 gpatippac, * from slnfactur where oid in (1361017)
select top 5 gpatippac, * from slnfactur where oid in (1356097, 1356062)

select top 5 gpatippac, SFADOCANU, * from slnfactur where OID in (1366953, 1364081)

select top 5 gpatippac, * from slnfactur where oid in (1463070)
----------------------------------------------------------------------------------------------
update slnfactur set gpatippac=1 where oid in (1655243)
update slnfactur set GENESTRATO=1 where oid in (1573496)
----------------------------------------------------------------------------------------------
begin tran xxx
declare @factura int select oid from DGEMPRES21..SLNFACTUR where SFANUMFAC='00000000452582'
declare @tipo int = 1
update DGEMPRES21..SLNFACTUR set gpatippac=@tipo where OID=@factura
commit tran xxx
----------------------------------------------------------------------------------------------
--gpatippac-----1=contributivo
--gpatippac-----2=subsidiado
--gpatippac-----3=vinculado
--gpatippac-----4=particular
--gpatippac-----5=otro
----------------------------------------------------------------------------------------------
update DGEMPRES21..SLNFACTUR set gpatippac=1 where SFANUMFAC='FV000004206404'
----------------------------------------------------------------------------------------------