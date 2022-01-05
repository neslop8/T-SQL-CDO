--------------------------------------------------------------------------------------------------------------------
USE DGEMPRES01
--pasar de 192252 al 192237
--pasar de 231677 al 231662
select AINESTADO, AINFECHOS, * from DGEMPRES01..ADNINGRESO where AINCONSEC in (192252,192237)
select * from DGEMPRES01..SLNCONHOJ where ADNINGRES1 in (2571006, 2570075)


select * from DGEMPRES01..SLNORDSER where oid in (1036297)
select * from DGEMPRES01..SLNSERPRO where SLNORDSER1 in (1036297)
select * from DGEMPRES01..SLNPROHOJ where OID in (2945271, 2945272, 2945273, 2945274, 2945275)
select * from DGEMPRES01..SLNSERHOJ where OID in (select OID from DGEMPRES01..SLNSERPRO where SLNORDSER1 in (select OID from DGEMPRES01..SLNORDSER where ADNINGRES1 in (2571006))


select * from DGEMPRES01..HCNFOLIO where ADNINGRESO in (122867) and HCFECFOL > '20210501'
select * from DGEMPRES01..HCNREGENF where ADNINGRESO in (122867, 153268) and HCFECREG > '20210501' order by 5, 4

select * from DGEMPRES01..HCNFOLIO where ADNINGRESO in (153268) and HCFECFOL between '20200803' and '20200805'
select * from DGEMPRES01..HCNREGENF where ADNINGRESO in (153268) and HCFECREG between '20200803' and '20200805'

select * from DGEMPRES01..HCNFOLIO where ADNINGRESO in (2554881) and HCFECFOL between '20200803' and '20200805'
select * from DGEMPRES01..HCNREGENF where ADNINGRESO in (2554881,2562537,2564179) and HCFECREG between '20200803' and '20200805'

select GENMEDICO, GENMEDICO1, HCEULTFOL, * from DGEMPRES01..HCNEPICRI where ADNINGRESO in (2562537,2564179)
select * from HCNEPIEVO where HCNEPICRI in (322929, 323893)

--pasar de 231677 al 231662
--------------------------------------------------------------------------------------------------------------------2554881
--------------------------------------------------------------------------------------------------------------------
begin tran xxx
update DGEMPRES01..SLNORDSER set ADNINGRES1=231662 where OID=1036297
update DGEMPRES01..SLNSERPRO set ADNINGRES1=231662 where SLNORDSER1 in (1036297)
update DGEMPRES01..INNCSUMPA set ADNINGRESO=231662 where SLNORDSER in (1036297)
update DGEMPRES01..INNCDESUM set ADNINGRESO=231662 where OID in 
(select INNCDESUM from DGEMPRES01..INNMDESUM where INNMSUMPA in (select OID from DGEMPRES01..INNMSUMPA where INNCSUMPA in (select OID from DGEMPRES01..INNCSUMPA where SLNORDSER in (select OID from DGEMPRES01..SLNORDSER where oid in (1036297)))))
commit tran xxx
rollback tran xxx
--------------------------------------------------------------------------------------------------------------------
select * from  CDO02_21..asi_suministro_solicitud where ingreso in (2297979)
select top 5 * from  CDO02_21..asi_tratamiento_solicitud where ingreso in (2536281)
select top 5 * from  CDO02_21..asi_control_urgencia where ingreso in (2319930)
--------------------------------------------------------------------------------------------------------------------
begin tran xxx
update CDO02_21..asi_suministro_solicitud set ingreso=2539500  where ingreso in (2536281) and fch_creacion > '20200611'
update CDO02_21..asi_control_urgencia set ingreso=2539500 where ingreso in (2536281)
rollback tran xxx
commit tran xxx
--------------------------------------------------------------------------------------------------------------------
begin tran xxx
update adningreso set ainestado=3 where oid=2449559
update adningreso set ainestado=0 where oid=2446758
commit tran xxx
--------------------------------------------------------------------------------------------------------------------
