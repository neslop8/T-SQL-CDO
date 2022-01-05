use DGEMPRES21

select top 5 * from CRNRECOBJC
select top 5 * from CRNRECOBJD
select top 5 * from CRNDOCUME

select * from CRNRECOBJC where OID in (

begin tran xxx
--UPDATE CRNRECOBJC set CROFECOBJ='2016-01-07 08:00:00' where OID in (
UPDATE CRNDOCUME set CDFECDOC='2016-01-07 08:00:00', CDFECCRE='2016-01-07 08:00:00', CDFECCON='2016-01-07 08:00:00' where OID in (
select doc.OID
from DGEMPRES21..CRNDOCUME doc inner join DGEMPRES21..CRNRECOBJC crec on doc.OID=crec.OID
inner join dgempres21..CRNCXC cxc on crec.CRNCXC=cxc.OID
inner join dgempres21..GENTERCERC cli on cxc.GENTERCERC=cli.OID
where crec.CROESTADO = 0 and cli.OID in (17, 20, 101) and doc.CDFECDOC > '2016-01-01')
commit tran xxx

select top 5 * from gentercerc where CLICODIGO='800251440'-----17 
select top 5 * from gentercerc where CLICODIGO='860002400'-----20
select top 5 * from gentercerc where CLICODIGO='860078828'-----101

