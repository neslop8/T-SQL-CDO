use DGEMPRES01
select * from ADNINGRESO where AINCONSEC=1971257

select top 5 * from GENPACIEN where PACNUMDOC='1022393328'-----11162
select top 5 * from GENPACIEN where OID=181326
select * from GENSERIPS where SIPCODIGO in ('901236','901236')
select AINESTADO, * from ADNINGRESO where GENPACIEN=56378
select AINESTADO, * from ADNINGRESO where AINCONSEC=201264
select * from GENSERIPS where SIPCODIGO in ('906317','906317')
select * from GENSERIPS where OID in (4518)
select * from GENSERIPS where OID in (4356, 3785, 4491, 4512, 4494, 4543, 4538, 4497, 4518, 4520)
select * from HCNFOLIO where GENPACIEN in (181326) AND OID=1192839
select HCNRESEXA, * from HCNSOLEXA where HCNFOLIO in (select OID from HCNFOLIO where GENPACIEN in (56378)) and GENSERIPS in (4293)
select HCNRESEXA, * from HCNSOLEXA where HCNFOLIO in (1225471)

select * from HCNSOLEXA where ADNINGRESO in (348892) and GENSERIPS in (4518)
select HCNSOLEXA, * from HCNRESEXA where HCNSOLEXA in (1533979)

select HCNSOLEXA, COUNT(*) from HCNRESEXA where HCNSOLEXA in (select OID from HCNSOLEXA where ADNINGRESO in (select OID from ADNINGRESO where GENPACIEN=78237))
group by HCNSOLEXA  having COUNT(*) > 1
select * from HCNRESEXA where HCNSOLEXA in (select OID from HCNSOLEXA where ADNINGRESO in (select OID from ADNINGRESO where GENPACIEN=78237))
select HCSREGSUS, HCNRESEXA, * from HCNSOLEXA where ADNINGRESO in (select OID from ADNINGRESO where GENPACIEN=78237) and HCSREGSUS=1
select HCNSOLEXA, * from HCNRESEXA where HCNSOLEXA in (select OID from HCNSOLEXA where ADNINGRESO in (select OID from ADNINGRESO where GENPACIEN=25256))

select HCNSOLEXA, COUNT(*) from HCNRESEXA where HCNSOLEXA in (select OID from HCNSOLEXA where ADNINGRESO in (select OID from ADNINGRESO where GENPACIEN=11162)) group by HCNSOLEXA
having COUNT(*) > 1

select HCNRESEXA, * from HCNSOLEXA where adningreso in (2575985)
select * from GENSERIPS where oid in (4243, 4475)


begin tran xxx
--update HCNSOLEXA set GENSERIPS=3821 where OID=1065328
update HCNRESEXA set HCRCONFIR=0 where OID in (840153)
delete HCNRESEXA where OID in (332082)
update HCNSOLEXA set HCSREGSUS=0 where OID=764396
delete HCNRESIMG where OID in (1860, 1859)
delete HCNRESEXIMG where Examenes in (188085, 188078)
delete HCNRESEXA where OID in (188085, 188078)
update HCNSOLEXA set HCNRESEXA=NULL where OID in (454177, 454178)
update HCNRESEXA set HCRCONFIR=0, HCNSOLEXA=NULL where OID in (188085, 188078)
--update HCNSOLEXA set HCSREGSUS=0 where OID in (176945) 
update HCNSOLEXA set HCSESTADO=1 where OID in (188655) 
update HCNRESEXA set HCRCONFIR=0 where OID=80481
commit tran xxx

select top 50 * from HCNRESINTERP
select top 50 * from HCNRESINTERP where HCNOIDRES=4041874
select top 50 * from HCNRESIMG where OID in (1860, 1859)
select * from HCNRESEXIMG where Examenes in (188085, 188078) order by Examenes desc

--------------------------------------------------------------Examenes con anexo multimedia
select * from GENPACIEN where OID in (1031339)
select * from ADNINGRESO where OID in (2565353)
select top 10 * from HCNSOLEXA where ADNINGRESO in (2565353)
select top 10 * from HCNRESEXA where oid in (select HCNRESEXA from HCNSOLEXA where ADNINGRESO in (2565353))
select top 10 * from HCNSOLEXA where HCNRESEXA in (
select OID from hcnresexa where oid in (select Examenes from HCNRESEXIMG)) order by OID desc
select top 10 * from HCNRESEXIMG order by OID desc
--------------------------------------------------------------Examenes con anexo multimedia
select * from GENSERIPS where oid in (3936)
select * from HCNFOLIO where oid in (7569391)
select * from HCNRESEXA where oid in (4142164)
select * from HCNSOLEXA where HCNRESEXA in (4142164)
select * from GENPACIEN where OID in (1030537)
select * from ADNINGRESO where OID in (2564064)

select * from HCNRESEXIMG where OID in (select HCNRESEXA from HCNSOLEXA where ADNINGRESO in (2565353))
select * from HCNRESEXA where oid in (select HCNRESEXA from HCNSOLEXA where ADNINGRESO in (2565353))

begin tran xxx
update HCNSOLEXA set HCNRESEXA=NULL where OID in (6369171)
--delete HCNRESINTERP where HCNOIDRES=4041874
delete HCNRESEXA where OID in (4067362)

update HCNRESEXA set HCRCONFIR=0 where OID=4172417
update HCNSOLEXA set HCNRESEXA=NULL where OID in (6069538)
delete HCNRESEXA where OID in (4010232)
delete HCNRESINTERP where HCNOIDRES=3917590
delete HCNRESIMG where OID=36499
delete HCNRESEXIMG where Examenes=3917590
rollback tran  xxx
commit tran xxx

select top 5 * from GENUSUARIO where USUNOMBRE='nflopez'




select top 5 * from GENPACIEN where PACNUMDOC='46354261'-----778345
select AINFECING, AINFECFAC, * from ADNINGRESO where GENPACIEN=78237-----2012272
select HCNRESPAT, * from HCNSOLPAT where ADNINGRESO in (select OID from ADNINGRESO where GENPACIEN=86620)
select HCNSOLPAT, * from HCNRESPAT where OID in (210625)

begin tran xxx
--update HCNRESPAT set HCRCONFIR=0, HCRINTERP=0, HCRINTERST=NULL where OID in (37122)
update HCNRESPAT set HCRCONFIR=0 where OID in (323897)
update HCNSOLPAT set HCNRESPAT=NULL where OID=7693
delete HCNRESPAT where OID=26508
rollback tran  xxx
commit tran xxx