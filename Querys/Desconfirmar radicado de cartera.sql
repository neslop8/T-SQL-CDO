use DGEMPRES21
select top 5 * from CRNDOCUME where CDTIPDOC=0 and CDCONSEC= 24371-----321294
select * from CRNRADFACC where OID=396912
select * from CRNRADFACD where CRNRADFACC=396912
select * from CRNCXC where OID in (select CRNCXC from CRNRADFACD where CRNRADFACC=396912)
select * from CRNCXCC where CRNCXC in (select CRNCXC from CRNRADFACD where CRNRADFACC=396912)
select * from CRNCXCEST where CRNCXC in (select CRNCXC from CRNRADFACD where CRNRADFACC=407937)
select top 5 CXCESTCAR, CXCESTCACT, CRNRADFACD, * from CRNCXC order by OID desc

select CXCESTCAR, COUNT(*) from CRNCXC where OID in (select CRNCXC from CRNRADFACD where CRNRADFACC=408129) group by CXCESTCAR

select * from CRNCXC where OID in (select CRNCXC from CRNRADFACD where CRNRADFACC=376312)
select * from CRNCXCEST where CRNCXC in (select CRNCXC from CRNRADFACD where CRNRADFACC=376312)

select * from CRNCXCEST where CRNCXC in (select CRNCXC from CRNRADFACD where CRNRADFACC=376312) group by CRNCXC
select CRNCXC, max(OID) from CRNCXCEST where CRNCXC in (select CRNCXC from CRNRADFACD where CRNRADFACC=376312) group by CRNCXC
select * from CRNCXCEST where OID in (3262167,3262168,3262169,3262170,3469459,3262173)

select * from  CDO02_21..asi_log_traslado_codigo



select CXCESTCAR from CRNCXC where OID in (select CRNCXC from CRNRADFACD where CRNRADFACC=408129) and CXCESTCAR > 2

select * from CRNCXCEST where CRNCXC in (1513565, 1527136, 1529678, 1530346, 1569167)

select * from CRNCXC where CXCDOCUME='00000000425045'
select * from CRNCXCC where OID=1474267
select * from CRNRADFACD where CRNCXC=1474267
select * from CRNCXCEST where CRNCXC=1474267

SELECT top 5 * FROM DGEMPRES21..CRNDOCUME order by OID desc


begin tran xxx
update DGEMPRES21..CRNRADFACC set CRFESTADO=0 where OID = 407577
update CRNCXC set CXCESTCAR=0, CXCESTCACT=NULL, CRNRADFACD=NULL where OID in (select CRNCXC from CRNRADFACD where CRNRADFACC=407577)
delete CRNCXCEST where CRNCXC in (select CRNCXC from CRNRADFACD where CRNRADFACC=407577)
commit tran xxx

select CRFESTADO, * from DGEMPRES21..CRNRADFACC where OID = 321294
select CXCESTCAR, CXCESTCACT, CRNRADFACD, * from DGEMPRES21..CRNCXC where OID in (select CRNCXC from DGEMPRES21..CRNRADFACD where CRNRADFACC=321294) order by 1
select * from DGEMPRES21..CRNCXCEST where CRNCXC in (select CRNCXC from DGEMPRES21..CRNRADFACD where CRNRADFACC=321294) order by CRNCXC

select * from DGEMPRES21..CRNCXCEST where CRNCXC in (select CRNCXC from CRNRADFACD where CRNRADFACC=321294)

select * from DGEMPRES21..CRNCXC where OID IN (
select CRNCXC, max(OID) from DGEMPRES21..CRNCXCEST where CRNCXC in (select CRNCXC from DGEMPRES21..CRNRADFACD where CRNRADFACC=321294)
group by CRNCXC)



select top 5 * from CRNCXC where OID=1477948
select top 5 * from CRNCXCC where CRNCXC=1477948
select top 5 * from CRNRECOBJC where CRNCXC=1477948

select top 5 * from CRNDOCUME where OID=376312
select top 5 * from CRNRADFACC where OID=376312
select * from CRNRADFACD where CRNRADFACC=376312
select top 5 * from CRNRADFACD where CRNCXC=1484746

begin tran xxx
update CRNCXC set CXCESTADO=2, CRNRADFACD=1321367 where OID=1477948
commit tran xxx