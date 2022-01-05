use DGEMPRES21
---------------------------------------------------------------------------------------------------------------------
select top 5 * from dgempres21..SLNFACTUR where SFANUMFAC='FV000003856909'
select top 5 * from CDO02_21..fac_factura where id=1280523

select AINESTADO, * from DGEMPRES21..temp_ADNINGRESO where AINCONSEC in (1332304, 1332308) ORDER BY OID
select top 5 AINESTADO, * from DGEMPRES21..ADNINGRESO where AINCONSEC in (1332304, 1332308)
select top 5 * from dgempres21..SLNFACTUR where SFANUMFAC='FV000003856909'
select top 5 * from CDO02_21..fac_factura where id=1280523
---------------------------------------------------------------------------------------------------------------------
select top 5 * from CDO02_21..fac_factura where id not in (select OID from dgempres21..SLNFACTUR)
--select top 5 * from dgempres21..SLNFACTUR where OID not in (select id from CDO02_21..fac_factura)
---------------------------------------------------------------------------------------------------------------------
begin tran xxx
delete CDO02_21..fac_factura where id not in (select OID from dgempres21..SLNFACTUR)
commit tran xxx
---------------------------------------------------------------------------------------------------------------------
