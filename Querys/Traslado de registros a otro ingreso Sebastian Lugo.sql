--------------------------------------------------------------------------------------------------------------------
USE DGEMPRES01
--pasar de 36759 al 35325
--pasar de 42943 al 41281
select top 5 AINESTADO, AINFECHOS, * from DGEMPRES01..ADNINGRESO where AINCONSEC in (36759,35325)

select * from DgEmpres01..SLNORDSER where ADNINGRES1 in (2552216) and SOSFECORD > '20200819'
select * from DgEmpres01..SLNSERPRO where SLNORDSER1 in (9212230, 9212968, 9213314)
select * from INNCSUMPA where SLNORDSER in (2458933)
select * from INNCDESUM where OID in 
(select INNCDESUM from INNMDESUM where INNMSUMPA in (select OID from INNMSUMPA where INNCSUMPA in (select OID from INNCSUMPA where SLNORDSER in (9212230, 9212968, 9213314))))

select top 5 * from DgEmpres01..SLNORDSER where OID IN (9348874)
select * from DgEmpres01..SLNSERPRO where SLNORDSER1=9348874
select top 5 * from DgEmpres01..SLNSERPRO where OID=24305846
select * from DgEmpres01..SLNPROHOJ where INNCSUMPA1=7215703  and INNPRODUC1=2126 
select top 5 * from DgEmpres01..INNPRODUC where iprcodigo='11121059'

select * from DgEmpres01..HCNFOLIO where ADNINGRESO in (35491)
select * from DgEmpres01..HCNREGENF where ADNINGRESO in (42943, 41281) order by 5, 4
select * from DgEmpres01..SLNORDSER where ADNINGRES1 in (35491)
select * from DgEmpres01..SLNSERPRO where ADNINGRES1 in (35491)

update DGEMPRES01..SLNORDSER set ADNINGRES1=36926 where OID=163815
update DGEMPRES01..SLNSERPRO set ADNINGRES1=36926 where OID=469034
--pasar de 42943 al 41281
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
begin tran xxx
/*delete HCNREGENF where OID=51762--51480
update HCNSIGVIT set HCNREGENF=51480 where HCNREGENF in (51762)
update HCNSOLMED set HCNREGENF=51480 where HCNREGENF in (51762)
update HCNCONMED set HCNREGENF=51480 where HCNREGENF in (51762)
update HCNCONSUM set HCNREGENF=51480 where HCNREGENF in (51762)
update HCNACTENF set HCNREGENF=51480 where HCNREGENF in (51762)
update HCPROAPLI set HCPREGENF=51480 where HCPREGENF in (51762)
update HCNNOTENF set HCNREGENF=51480 where HCNREGENF in (51762)*/
update DGEMPRES01..HCNREGENF set ADNINGRESO=41281 where ADNINGRESO in (42943)-- and HCFECREG >= '20200819'
/*update DGEMPRES01..HCNFOLIO set ADNINGRESO=41281 where ADNINGRESO in (42943)-- and HCFECFOL >= '20200819'
update DGEMPRES01..SLNORDSER set ADNINGRES1=41281 where ADNINGRES1 in (42943)-- and SOSFECORD > '20200819'
update DGEMPRES01..SLNSERPRO set ADNINGRES1=41281 where SLNORDSER1 in (select OID from DGEMPRES01..SLNORDSER where ADNINGRES1 in (42943)/* and SOSFECORD > '20200819'*/)
update DGEMPRES01..INNCSUMPA set ADNINGRESO=41281 where SLNORDSER in (select OID from DGEMPRES01..SLNORDSER where ADNINGRES1 in (42943)/* and SOSFECORD > '20200819'*/)
update DGEMPRES01..INNCDESUM set ADNINGRESO=41281 where OID in 
(select INNCDESUM from DgEmpres01..INNMDESUM where INNMSUMPA in (select OID from DGEMPRES01..INNMSUMPA where INNCSUMPA in (select OID from DGEMPRES01..INNCSUMPA where SLNORDSER in (select OID from DGEMPRES01..SLNORDSER where ADNINGRES1 in (42943)/* and SOSFECORD > '20200819'*/))))*/
commit tran xxx
rollback tran xxx
--------------------------------------------------------------------------------------------------------------------
select * from  CDO02_21..asi_suministro_solicitud where ingreso in (2519492) and fch_creacion > '20200418'
select * from  CDO02_21..asi_tratamiento_solicitud where ingreso in (2509471) and fch_creacion > '20200418'
select top 5 * from  CDO02_21..asi_control_urgencia where ingreso in (2319930)
--------------------------------------------------------------------------------------------------------------------
begin tran xxx
update CDO02_21..asi_suministro_solicitud set ingreso=2519492  where ingreso in (2519469)-- and fch_creacion > '20200418'
update CDO02_21..asi_tratamiento_solicitud set ingreso=2519492 where ingreso in (2519469)
--update CDO02_21..asi_control_urgencia set ingreso=2519147 where ingreso in (2193855)
rollback tran xxx
commit tran xxx
--------------------------------------------------------------------------------------------------------------------
begin tran xxx
update adningreso set ainestado=3 where oid=2449559
update adningreso set ainestado=0 where oid=2446758
commit tran xxx
--------------------------------------------------------------------------------------------------------------------
