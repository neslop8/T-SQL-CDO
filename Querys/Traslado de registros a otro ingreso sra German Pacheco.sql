--------------------------------------------------------------------------------------------------------------------
USE DGEMPRES21
--pasar de 2061675 al 2064382
--pasar de 2446758 al 2449559
select top 5 AINESTADO, AINFECHOS, * from DGEMPRES21..ADNINGRESO where AINCONSEC in (2064382,2061675)

select * from DGEMPRES21..SLNORDSER where ADNINGRES1 in (2446758)
select * from DGEMPRES21..SLNORDSER where ADNINGRES1 in (2449559)
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


select * from DGEMPRES21..HCNFOLIO where ADNINGRESO in (2446758) and HCFECFOL > '20191225'
select * from DGEMPRES21..HCNREGENF where ADNINGRESO in (2446758) and HCFECREG > '20191225'
select GENMEDICO, GENMEDICO1, * from DGEMPRES21..HCNEPICRI where ADNINGRESO in (2446758, 2449559)
select * from HCNEPIEVO where HCNEPICRI in (317999)
update DGEMPRES21..HCNEPICRI set GENMEDICO=2809, GENMEDICO1=2809 where ADNINGRESO in (2431232)
--pasar de 2446758 al 2449559
--------------------------------------------------------------------------------------------------------------------
begin tran xxx
--update DGEMPRES21..HCNREGENF set ADNINGRESO=2449559 where ADNINGRESO=2446758 and HCFECREG > '20191225'
--update DGEMPRES21..HCNFOLIO set ADNINGRESO=2449559 where ADNINGRESO in (2446758) and HCFECFOL > '20191225'
update DGEMPRES21..SLNORDSER set ADNINGRES1=2446758 where ADNINGRES1 in (2446758) and SOSFECORD > '20191225'
/*update DGEMPRES21..SLNSERPRO set ADNINGRES1=2449559 where SLNORDSER1 in (select OID from DGEMPRES21..SLNORDSER where ADNINGRES1 in (2446758) and SOSFECORD > '20191225')
update DGEMPRES21..INNCSUMPA set ADNINGRESO=2449559 where SLNORDSER in (select OID from DGEMPRES21..SLNORDSER where ADNINGRES1 in (2446758) and SOSFECORD > '20191225')
update DGEMPRES21..INNCDESUM set ADNINGRESO=2449559 where OID in 
(select INNCDESUM from DGEMPRES21..INNMDESUM where INNMSUMPA in (select OID from DGEMPRES21..INNMSUMPA where INNCSUMPA in (select OID from DGEMPRES21..INNCSUMPA where SLNORDSER in (select OID from DGEMPRES21..SLNORDSER where ADNINGRES1 in (2446758) and SOSFECORD > '20191225'))))*/
commit tran xxx
rollback tran xxx
--------------------------------------------------------------------------------------------------------------------
select * from  CDO02_21..asi_suministro_solicitud where ingreso in (2297979)
select top 5 * from  CDO02_21..asi_tratamiento_solicitud where ingreso in (2297979)
select top 5 * from  CDO02_21..asi_control_urgencia where ingreso in (2319930)
--------------------------------------------------------------------------------------------------------------------
begin tran xxx
update CDO02_21..asi_suministro_solicitud set ingreso=2319930  where ingreso in (2297979) and fch_creacion > '20190626'
update CDO02_21..asi_tratamiento_solicitud set ingreso=2197731 where ingreso in (2193855)
update CDO02_21..asi_control_urgencia set ingreso=2197731 where ingreso in (2193855)
rollback tran xxx
commit tran xxx
--------------------------------------------------------------------------------------------------------------------
begin tran xxx
update adningreso set ainestado=3 where oid=2449559
update adningreso set ainestado=0 where oid=2446758
commit tran xxx
--------------------------------------------------------------------------------------------------------------------
