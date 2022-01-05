--------------------------------------------------------------------------------------------------------------------
USE DGEMPRES21
--pasar de 2148948 al 2161728
--pasar de 2542122 al 2557438
select top 5 AINESTADO, AINFECHOS, * from DGEMPRES21..ADNINGRESO where AINCONSEC in (2148948,2161728)
select * from DGEMPRES21..GENDETCON where OID in (9, 90)

select * from DGEMPRES21..SLNORDSER where ADNINGRES1 in (2542122) and SOSFECORD > '20200723'
select * from DGEMPRES21..SLNORDSER where SOSORDSER in (9622426)
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


select * from DGEMPRES21..HCNFOLIO where ADNINGRESO in (2542122) and HCFECFOL > '20200723'
select * from DGEMPRES21..HCNREGENF where ADNINGRESO in (2542122) and HCFECREG > '20200723'
select GENMEDICO, GENMEDICO1, * from DGEMPRES21..HCNEPICRI where ADNINGRESO in (2446758, 2449559)
select * from HCNEPIEVO where HCNEPICRI in (317999)
update DGEMPRES21..HCNEPICRI set GENMEDICO=2809, GENMEDICO1=2809 where ADNINGRESO in (2431232)
--pasar de 2542122 al 2557438
--------------------------------------------------------------------------------------------------------------------
begin tran xxx
update DGEMPRES21..HCNREGENF set ADNINGRESO=2557438 where ADNINGRESO in (2542122) and HCFECREG > '20200723'
update DGEMPRES21..HCNFOLIO set ADNINGRESO=2557438 where ADNINGRESO in (2542122) and HCFECFOL > '20200723'
--update DGEMPRES21..SLNORDSER set ADNINGRES1=2557438 where OID in (9914462, 9914603, 9914731)
/*update DGEMPRES21..SLNSERPRO set ADNINGRES1=2557438 where SLNORDSER1 in (9914462, 9914603, 9914731)
update DGEMPRES21..INNCSUMPA set ADNINGRESO=2557438 where SLNORDSER in (9914462, 9914603, 9914731)
update DGEMPRES21..INNCDESUM set ADNINGRESO=2557438 where OID in 
(select INNCDESUM from DGEMPRES21..INNMDESUM where INNMSUMPA in (select OID from DGEMPRES21..INNMSUMPA where INNCSUMPA in (select OID from DGEMPRES21..INNCSUMPA where SLNORDSER in (9914462, 9914603, 9914731))))*/
commit tran xxx
rollback tran xxx
--------------------------------------------------------------------------------------------------------------------
select * from  CDO02_21..asi_suministro_solicitud where ingreso in (2297979)
select top 5 * from  CDO02_21..asi_tratamiento_solicitud where ingreso in (2297979)
select top 5 * from  CDO02_21..asi_control_urgencia where ingreso in (2319930)
--------------------------------------------------------------------------------------------------------------------
begin tran xxx
update CDO02_21..asi_suministro_solicitud set ingreso=2548291  where ingreso in (2548275)
update CDO02_21..asi_tratamiento_solicitud set ingreso=2548291 where ingreso in (2548275)
update CDO02_21..asi_control_urgencia set ingreso=2548291 where ingreso in (2548275)
rollback tran xxx
commit tran xxx
--------------------------------------------------------------------------------------------------------------------
begin tran xxx
update adningreso set ainestado=3 where oid=2449559
update adningreso set ainestado=0 where oid=2446758
commit tran xxx
--------------------------------------------------------------------------------------------------------------------
