--------------------------------------------------------------------------------------------------------------------
USE DGEMPRES21
--pasar de 2174787 al 2174694
--pasar de 2572933 al 2572749
select top 5 AINESTADO, AINFECHOS, * from DGEMPRES21..ADNINGRESO where AINCONSEC in (2174787,2174694)
select * from DGEMPRES21..GENPACIEN where OID=1020953

select * from DGEMPRES21..SLNORDSER where ADNINGRES1 in (2152383) and SOSMODULO=2
select * from DGEMPRES21..SLNORDSER where ADNINGRES1 in (2519881) and SOSMODULO=2
select * from DGEMPRES21..SLNSERPRO where ADNINGRES1 in (2446758)

begin tran xxx
update SLNORDSER set ADNINGRES1=2449559 where OID in (select SLNORDSER1 from DGEMPRES21..SLNSERPRO where ADNINGRES1 in (2449559))
commit tran xxx

select SLNORDSER1, COUNT(*) from DGEMPRES21..SLNSERPRO where ADNINGRES1 in (2446758) group by SLNORDSER1
select SLNORDSER1, COUNT(*) from DGEMPRES21..SLNSERPRO where ADNINGRES1 in (2449559) group by SLNORDSER1
select 86 + 52

select * from DGEMPRES21..SLNORDSER where ADNINGRES1 in (2446758) and SOSFECORD > '20191225'
select * from DGEMPRES21..SLNSERPRO where SLNORDSER1 in (9212230, 9212968, 9213314)
select * from INNCSUMPA where SLNORDSER in (2458933)
select * from INNCDESUM where OID in 
(select INNCDESUM from INNMDESUM where INNMSUMPA in (select OID from INNMSUMPA where INNCSUMPA in (select OID from INNCSUMPA where SLNORDSER in (9212230, 9212968, 9213314))))

select top 5 * from DGEMPRES21..SLNORDSER where OID IN (9348874)
select * from DGEMPRES21..SLNSERPRO where SLNORDSER1=9348874
select top 5 * from DGEMPRES21..SLNSERPRO where OID=24305846
select * from DGEMPRES21..SLNPROHOJ where INNCSUMPA1=7215703  and INNPRODUC1=2126 
select top 5 * from DGEMPRES21..INNPRODUC where iprcodigo='11121059'

select * from DGEMPRES21..INNCSUMPA where SLNORDSER in (9348874,9602366)
select * from DGEMPRES21..INNMSUMPA where INNCSUMPA in (7215703, 7398226) and INNPRODUC=2126
select top 5 * from DGEMPRES21..SLNPROHOJ where OID=24305846
select top 5 * from DGEMPRES21..SLNSERPRO where OID=24305846

begin tran xxx
update INNMSUMPA set INNCSUMPA=7398226 where OID=17652950--7215703
update SLNPROHOJ set INNCSUMPA1=7398226 where OID=24305846--7215703
update SLNSERPRO set SLNORDSER1=9602366, ADNINGRES1=2446758 where OID=24305846--9348874;2449559
commit tran xxx


select * from DGEMPRES21..HCNFOLIO where ADNINGRESO in (2546082) and HCFECFOL > '20200705'
select * from DGEMPRES21..HCNFOLIO where ADNINGRESO in (2548332) and HCFECFOL > '20200705'
select * from DGEMPRES21..HCNREGENF where ADNINGRESO in (2572933, 2572749)--and HCFECREG > '20200705'
select GENMEDICO, GENMEDICO1, * from DGEMPRES21..HCNEPICRI where ADNINGRESO in (2446758, 2449559)
select * from HCNEPIEVO where HCNEPICRI in (317999)
update DGEMPRES21..HCNEPICRI set GENMEDICO=2809, GENMEDICO1=2809 where ADNINGRESO in (2431232)
--pasar de 2572933 al 2572749
--------------------------------------------------------------------------------------------------------------------
begin tran xxx
/*update DGEMPRES21..HCNSIGVIT set HCNREGENF=9022375 where HCNREGENF=9022140
update DGEMPRES21..HCNCONING set HCNREGENF=9022375 where HCNREGENF=9022140
update DGEMPRES21..HCNLIQELM set HCNREGENF=9022375 where HCNREGENF=9022140
update DGEMPRES21..HCNLIQADM set HCNREGENF=9022375 where HCNREGENF=9022140
update DGEMPRES21..HCNNOTENF set HCNREGENF=9022375 where HCNREGENF=9022140
delete DGEMPRES21..HCNREGENF where OID=9022140--9022375*/
update DGEMPRES21..HCNREGENF set ADNINGRESO=2572749 where ADNINGRESO=2572933--and HCFECREG > '20200705'
update DGEMPRES21..HCNFOLIO set ADNINGRESO=2572749 where ADNINGRESO in (2572933)--and HCFECFOL > '20200705'
update DGEMPRES21..SLNORDSER set ADNINGRES1=2572749 where ADNINGRES1 in (2572933)
update DGEMPRES21..SLNSERPRO set ADNINGRES1=2572749 where SLNORDSER1 in (select OID from DGEMPRES21..SLNORDSER where ADNINGRES1 in (2572933))
update DGEMPRES21..INNCSUMPA set ADNINGRESO=2572749 where SLNORDSER in (select OID from DGEMPRES21..SLNORDSER where ADNINGRES1 in (2572933))
update DGEMPRES21..INNCDESUM set ADNINGRESO=2572749 where OID in 
(select INNCDESUM from DGEMPRES21..INNMDESUM where INNMSUMPA in (select OID from DGEMPRES21..INNMSUMPA where INNCSUMPA in (select OID from DGEMPRES21..INNCSUMPA where SLNORDSER in (select OID from DGEMPRES21..SLNORDSER where ADNINGRES1 in (2572933)))))
commit tran xxx
rollback tran xxx
--------------------------------------------------------------------------------------------------------------------
select * from  CDO02_21..asi_suministro_solicitud where ingreso in (2519401)
select top 5 * from  CDO02_21..asi_tratamiento_solicitud where ingreso in (2297979)
select top 5 * from  CDO02_21..asi_control_urgencia where ingreso in (2319930)
--------------------------------------------------------------------------------------------------------------------
begin tran xxx
update CDO02_21..asi_suministro_solicitud set ingreso=2539465  where ingreso in (2535194) 
update CDO02_21..asi_tratamiento_solicitud set ingreso=2539465 where ingreso in (2535194)
update CDO02_21..asi_control_urgencia set ingreso=2539465 where ingreso in (2535194)
rollback tran xxx
commit tran xxx
--------------------------------------------------------------------------------------------------------------------
begin tran xxx
update adningreso set ainestado=3 where oid=2449559
update adningreso set ainestado=0 where oid=2446758
commit tran xxx
--------------------------------------------------------------------------------------------------------------------
SP_WHO3 LOCK