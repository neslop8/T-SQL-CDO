--------------------------------------------------------------------------------------------------------------------
USE DGEMPRES21
--pasar de 2068652 al 2068516
--pasar de 2453997 al 2453861
select top 5 AINESTADO, AINFECHOS, * from DGEMPRES21..ADNINGRESO where AINCONSEC in (2068652, 2068516)
--------------------------------------------------------------------------------------------------------------------
select * from DGEMPRES21..SLNORDSER where ADNINGRES1 in (2477612) order by OID
select * from DGEMPRES21..HCNFOLIO where ADNINGRESO in (2477612) and HCFECFOL between '20200206' and '20200207'
select * from HCNREGENF where ADNINGRESO in (2477612, 2443072) and HCFECREG between '20200206' and '20200207'
select GENMEDICO, GENMEDICO1, * from HCNEPICRI where ADNINGRESO in (2477612, 2443072)
select * from HCNINCAPA where ADNINGRESO in (2477612, 2443072)

update HCNEPICRI set GENMEDICO=60, GENMEDICO1=613 where OID=317262
update HCNEPICRI set GENMEDICO=613, GENMEDICO1=613 where OID=320563
update HCNEPICRI set HCEULTFOL=NULL where OID=312083
delete HCNEPIEVO where HCNEPICRI in (317262, 320563)
--------------------------------------------------------------------------------------------------------------------
--pasar de 2453997 al 2453861
--------------------------------------------------------------------------------------------------------------------
begin tran xxx
/*update HCNSIGVIT set HCNREGENF=8900652 where HCNREGENF=8901168
update HCNLIQELM set HCNREGENF=8900652 where HCNREGENF=8901168
update HCNLIQADM set HCNREGENF=8900652 where HCNREGENF=8901168
update HCNNOTENF set HCNREGENF=8900652 where HCNREGENF=8901168
update HCNSIGVIT set HCNREGENF=8900122 where HCNREGENF=8899556
update HCNCONING set HCNREGENF=8900122 where HCNREGENF=8899556
update HCNLIQELM set HCNREGENF=8900122 where HCNREGENF=8899556
update HCNLIQADM set HCNREGENF=8900122 where HCNREGENF=8899556
update HCNNOTENF set HCNREGENF=8900122 where HCNREGENF=8899556
--update HCNGLUCOM set HCNREGENF=8900122 where HCNREGENF=8899556
delete HCNREGENF where OID=8899556--8900122
delete HCNREGENF where OID=8901168--8900652*/
--update HCNEPICRI set HCEULTFOL=NULL where OID=312083
--delete HCNEPIEVO where HCNEPICRI in (317262, 320563)
--update HCNINCAPA set ADNINGRESO=2476872 where ADNINGRESO=2446215
update HCNREGENF set ADNINGRESO=2453861 where ADNINGRESO in (2453997)
update DGEMPRES21..HCNFOLIO set ADNINGRESO=2453861 where ADNINGRESO in (2453997)
update DGEMPRES21..SLNORDSER set ADNINGRES1=2453861 where ADNINGRES1=2453997
update DGEMPRES21..SLNSERPRO set ADNINGRES1=2453861 where ADNINGRES1 in (2453997)
update DGEMPRES21..INNCSUMPA set ADNINGRESO=2453861 where ADNINGRESO in (2453997)
update DGEMPRES21..INNCDESUM set ADNINGRESO=2453861 where oid in 
(select INNCDESUM from DGEMPRES21..INNMDESUM where INNMSUMPA in (select OID from DGEMPRES21..INNMSUMPA where inncsumpa in (select OID from DGEMPRES21..INNCSUMPA where SLNORDSER in (select OID from DGEMPRES21..SLNORDSER where ADNINGRESO in (2453997)))))
commit tran xxx
rollback tran xxx
--------------------------------------------------------------------------------------------------------------------
begin tran xxx
update CDO02_21..asi_suministro_solicitud set ingreso=2453861  where ingreso in (2453997)
update CDO02_21..asi_tratamiento_solicitud set ingreso=2453861 where ingreso in (2453997)
update CDO02_21..asi_control_urgencia set ingreso=2453861 where ingreso in (2453997)
rollback tran xxx
commit tran xxx
--------------------------------------------------------------------------------------------------------------------