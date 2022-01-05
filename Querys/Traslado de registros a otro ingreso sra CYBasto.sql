--------------------------------------------------------------------------------------------------------------------
USE DGEMPRES21
--pasar de 2095078 al 2095105
--pasar de 2482746 al 2482773
select top 5 AINESTADO, AINFECHOS, * from DGEMPRES21..ADNINGRESO where AINCONSEC in (2095078, 2095105)
--------------------------------------------------------------------------------------------------------------------
select * from DGEMPRES21..SLNORDSER where ADNINGRES1 in (2376885, 2476422) and SOSMODULO=3
select * from DGEMPRES21..HCNFOLIO where ADNINGRESO in (2376885) and HCFECFOL between '20191001' and '20191019'
select * from DGEMPRES21..HCNFOLIO where ADNINGRESO in (2376885)
select * from HCNREGENF where ADNINGRESO in (2480965, 2482087)
select GENMEDICO, GENMEDICO1, * from HCNEPICRI where ADNINGRESO in (2480965, 2482087)
select top 5 * from HCNINCAPA where ADNINGRESO in (2480965, 2482087)

update HCNEPICRI set GENMEDICO=613, GENMEDICO1=21 where OID=312083
update HCNEPICRI set HCEULTFOL=NULL where OID=312083
delete HCNEPIEVO where HCNEPICRI=312083
--------------------------------------------------------------------------------------------------------------------
--pasar de 2480965 al 2482087
--------------------------------------------------------------------------------------------------------------------
begin tran xxx
update HCNSIGVIT set HCNREGENF=8905239 where HCNREGENF=8904688
update HCNCONING set HCNREGENF=8905239 where HCNREGENF=8904688
update HCNLIQADM set HCNREGENF=8905239 where HCNREGENF=8904688
update HCNNOTENF set HCNREGENF=8905239 where HCNREGENF=8904688
delete HCNREGENF where OID=8904688
--update HCNEPICRI set HCEULTFOL=NULL where OID=312083
--delete HCNEPIEVO where HCNEPICRI=312083
--update HCNINCAPA set ADNINGRESO=2476872 where ADNINGRESO=2446215
update HCNREGENF set ADNINGRESO=2482087 where ADNINGRESO in (2480965) 
--update DGEMPRES21..HCNFOLIO set ADNINGRESO=2482087 where ADNINGRESO in (2480965) 
--update DGEMPRES21..SLNORDSER set ADNINGRES1=2482087 where ADNINGRES1 in (2480965)
--update DGEMPRES21..SLNSERPRO set ADNINGRES1=2482087 where SLNORDSER1 in (select OID from DGEMPRES21..SLNORDSER where ADNINGRES1 in (2480965))
--update DGEMPRES21..INNCSUMPA set ADNINGRESO=2482087 where SLNORDSER in (select OID from DGEMPRES21..SLNORDSER where ADNINGRES1 in (2480965))
--update DGEMPRES21..INNCDESUM set ADNINGRESO=2482087 where oid in 
(select INNCDESUM from DGEMPRES21..INNMDESUM where INNMSUMPA in (select OID from DGEMPRES21..INNMSUMPA where inncsumpa in (select OID from DGEMPRES21..INNCSUMPA where SLNORDSER in (select OID from DGEMPRES21..SLNORDSER where ADNINGRES1 in (2480965)))))
commit tran xxx
rollback tran xxx
--------------------------------------------------------------------------------------------------------------------
select top 5 * from GENDETCON where GDECODIGO='ARL00506'

begin tran xxx
update GENDETCON set GDECODIGO='SES506' where OID=610
commit tran xxx
--------------------------------------------------------------------------------------------------------------------
select top 15 ADNEGRESER, OptimisticLockField, * from ADNEGRESO order by OID desc