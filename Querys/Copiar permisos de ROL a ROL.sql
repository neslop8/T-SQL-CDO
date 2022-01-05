use DGEMPRES21
select top 5 * from GENUSUARIO where USUNOMBRE in ('YBGARCIA','LSCANIZALEZ','XBELTRAN')-----1964
select top 5 * from GENROL where OID=52
select top 5 * from GENROL where ROLNOMBRE like '%cajero%'

select * from DGEMPRES21..GENUSUPER where GENUSUARIO=2371
select * from DGEMPRES22..GENUSUPER where GENUSUARIO=2371

select * from DGEMPRES21..GENROLPER where GENROL=99
select * from DGEMPRES21..GENROLPER where GENROL=52
select * from DGEMPRES21..GENROLPER where GENROL=4

select * from DGEMPRES21..GENROLPER where GENROL=4 AND 
(PERACCION1 <> 0 OR PERACCION2 <> 0 OR PERACCION3 <> 0 OR PERACCION4 <> 0 OR PERACCION5 <> 0 OR
PERACCION6 <> 0 OR PERACCION7 <> 0 OR PERACCION8 <> 0 OR PERACCION9 <> 0 OR PERACCION10 <> 0 OR PERACCION11 <> 0)


select PEROPCION, COUNT(*) from DGEMPRES21..GENROLPER where GENROL=99 group by PEROPCION order by 2 desc

select PEROPCION, MAX(OID) from DGEMPRES21..GENROLPER where GENROL=99 and PEROPCION in (
'AD3','AD31','AD311','AD32','CM3','AD2','CM','CM1','CM2','AD','AD1','FA','FA1','GE','GE0','GE01',
'FA2','HC','IN2','IN21','IN216','HC2','FA3','HC24','HC29','HC3','HC31','HC32','HP','HP1','HP3','HP31','HP33','HP2','IN')
group by PEROPCION

begin tran xxx
delete GENROLPER where GENROL=99 and OID in (
228312,228313,228314,228315,228317,228319,228318,228349,228350,228351,228352,228402,228403,228404,228405,228408,
228409,228410,228416,228418,228421,228424,228419,228428,228425,228434,228435,228436,228437,228439,228440,228442,
228444,228445,228449)
commit tran xxx

select * from DGEMPRES21..GENROLPER where GENROL in (4, 34)
select * from DGEMPRES21..GENROLPER where GENROL=4

begin tran xxx
insert into DGEMPRES21..GENROLPER select 101, PEROPCION, PERNOMBRE, PERPADRE, PERACCION1, PERACCION2, PERACCION3, PERACCION4, PERACCION5
, PERACCION6, PERACCION7, PERACCION8, PERACCION9, PERACCION10, PERFORMULA, PERVISIBLE, PERINDICE, PERICONO, OptimisticLockField, PERACCION11
from DGEMPRES21..GENROLPER where GENROL IN (4, 34)
rollback tran xxx
commit tran xxx

select * from DGEMPRES21..GENROL where ROLNOMBRE like '%citas%'
select * from DGEMPRES21..GENUSUARIO where GENROL=4 and USUESTADO=1

select * from DGEMPRES21..GENROL where OID in (4, 95)
select * from DGEMPRES21..GENROL order by OID desc

select * from GENUSUPER where GENUSUARIO=1964 and PEROPCION='CR16'
select * from GENROLPER where GENROL=34 and PEROPCION='CR16'
select PEROPCION, COUNT(*) from GENROLPER where GENROL=34 group by PEROPCION having COUNT(*) > 1

update GENUSUARIO set USUCLAVE='KwpQMRdugfur3TkLmRqs1w==' where USUNOMBRE in ('yacardenas')
update GENUSUARIO set USUCLAVE='eJF3LBkJOQmXR26EoI1l7w==' where USUNOMBRE in ('yacardenas')