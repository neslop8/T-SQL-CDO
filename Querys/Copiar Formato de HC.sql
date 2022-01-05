use DGEMPRES22

DBCC CHECKIDENT (HCNTIPHIS, RESEED, 49);
DBCC CHECKIDENT (HCNDISHIS, RESEED, 49);

select top 5 * from DGEMPRES21..HCNTIPHIS order by OID desc
select top 5 * from DGEMPRES23..HCNTIPHIS order by OID desc

select * from DGEMPRES22..HCNTIPHIS where OID > 50
select * from DGEMPRES22..HCNTIPHIS where HCCODIGO in ('CONCO2','CONCO3')--19, 51

select * from DGEMPRES22..HCNTIPHIS where OID=53
select * from DGEMPRES22..HCNDISHIS where OID=53
select * from DGEMPRES22..HCNCAMTHC where HCNTIPHIS=53

select * from DGEMPRES21..HCNTIPHIS where OID in (50)
select * from DGEMPRES21..HCNDISHIS where OID in (50)
select * from DGEMPRES21..HCNCAMTHC where HCNTIPHIS=50

select * from DGEMPRES22..HCNTIPHIS where OID in (49)
select * from DGEMPRES22..HCNDISHIS where OID in (49)
select * from DGEMPRES22..HCNCAMTHC where HCNTIPHIS=49

select * from DGEMPRES22..HCNCAMTHC where HCNTIPHIS=49

update DGEMPRES21..HCNTIPHIS set HCNDISHIS=49 where OID=50
update DGEMPRES21..HCNDISHIS set HCNTIPHIS=49 where OID=50

begin tran xxx
delete DGEMPRES21..HCNTIPHIS where OID in (50)
delete DGEMPRES21..HCNDISHIS where OID in (50)
delete DGEMPRES21..HCNCAMTHC where HCNTIPHIS=50
commit tran xxx


select COUNT(*) from DGEMPRES21..HCNCAMTHC where HCNTIPHIS=50
select COUNT(*) from DGEMPRES22..HCNCAMTHC where HCNTIPHIS=50

select * from DGEMPRES21..HCNCAMTHC where HCNTIPHIS=49
select * from DGEMPRES23..HCNCAMTHC where HCNTIPHIS=49

select top 5 * from HCNTIPHIS where OID=49
select HCCM03N52, HCCM09N48, * from hcmP00HQ2 
select HCCM03N52, HCCM09N48, * from hcmP00HQ1

begin tran xxx
delete DGEMPRES21..HCNCAMTHC where HCNTIPHIS=49 and OID > 1080
commit tran xxx


select top 5 * from DGEMPRES21..HCMP00HQ1 order by OID desc
select * from DGEMPRES21..HCMP00HQ2 order by OID desc
select * from DGEMPRES23..HCMP00HQ2 order by OID desc

select * from DGEMPRES21..HCNFOLIO where HCNTIPHIS in (49) order by OID desc
select top 5 * from DGEMPRES21..HCNFOLIO where HCNTIPHIS in (10) order by OID desc


select * from DGEMPRES21..HCNFOLIO where HCNTIPHIS in (49) order by OID desc
select top 5 * from GENPACIEN where OID in (691071, 778847)

select top 5 * from GENSERIPS where SIPCODIGO='901212'

begin tran xxx
--update DGEMPRES21..HCNCAMTHC set HCEXPCON=REPLACE(HCEXPCON, 'HCMP00HQ1', 'HCMP00HQ2') where HCNTIPHIS=49
--update DGEMPRES21..HCNCAMTHC set HCEXPFOR=REPLACE(HCEXPFOR, 'HCMP00HQ1', 'HCMP00HQ2') where HCNTIPHIS=49
update DGEMPRES21..HCNCAMTHC set HCPROPER=REPLACE(HCPROPER, 'HCMP00HQ1', 'HCMP00HQ2') where HCNTIPHIS=49
commit tran xxx

select * from dgempres21..HCNDISHIS where HCNTIPHIS=10
select * from dgempres22..HCNDISHIS where HCNTIPHIS=10

select * from dgempres21..HCNAYULINEA where HCNTIPHIS=10
select * from dgempres21..HCNCAMTHC where HCNTIPHIS=10

select HCDLYTDIS from dgempres22..HCNDISHIS where OID=10

begin tran xxx
update DGEMPRES21..HCNDISHIS set HCDLYTDIS=(select HCDLYTDIS from DGEMPRES23..HCNDISHIS where OID=51) where OID=52
update DGEMPRES21..HCNDISHIS set GEPREPMOD=(select GEPREPMOD from DGEMPRES23..HCNDISHIS where OID=51) where OID=52
commit tran xxx

select * from dgempres21..HCNCAMTHC where HCNTIPHIS=10
select * from dgempres22..HCNCAMTHC where HCNTIPHIS=49
select * from dgempres21..HCNCAMTHC where HCNTIPHIS=49

select HCNOMBRE, COUNT(*) from dgempres21..HCNCAMTHC where HCNTIPHIS=49 group by HCNOMBRE

select * from DGEMPRES23..HCNCAMTHC where HCNTIPHIS=19
select * from dgempres23..HCNTHAUTOR where HCNTIPHIS=19

begin tran xxx
INSERT INTO DGEMPRES21..HCNCAMTHC 
    SELECT 51, HCTIPCON, HCNOMBRE, HCDESCRIP, HCOBLIGA, HCRELEPIC, HCTITEPIC, HCRELREF, HCTITREF, HCRELCREF, HCTITCREF, HCEXPCON
	, HCEXPFOR, HCTDEXPR, HCEVAEXP, HCOBTHIS, HCMODFOLA, HCPROPER, 0, HCRELENFER, HCRELSIGVIT
	, HCNOGENSL, HCRELCERTIF, HCTITFOLIOSIUS, HCRELFOLIOSIUS, HCEPICSAL, HCRELGESRIES, HCRELAUTSER, HCTITAUTSER, HCRELRES2175, HCRELINDMED
	, HCRELEGRENAC, HCRELATIUR, HCRELAFURI, HCOBTHISE, HCOBTHISEC, HCRELCDASO, HCRELCDAMN
    FROM DGEMPRES24..HCNCAMTHC WHERE HCNTIPHIS=82
commit tran xxx
rollback tran xxx

begin tran xxx
--delete DGEMPRES21..HCNCAMTHC where HCNTIPHIS=52
INSERT INTO DGEMPRES21..HCNCAMTHC SELECT * FROM DGEMPRES23..HCNCAMTHC WHERE HCNTIPHIS=51
commit tran xxx
rollback tran xxx

select * from HCNTHAUTOR where HCNTIPHIS=82
select * from HCNCAMTHC where HCNTIPHIS=51

begin tran xxx
INSERT INTO DGEMPRES21..HCNTHAUTOR 
		SELECT 51, GENUSUARIO, HCANUESEL, HCANUEUTL, 0, HCBLOQCCP from DGEMPRES22..HCNTHAUTOR where HCNTIPHIS=82
commit tran xxx

