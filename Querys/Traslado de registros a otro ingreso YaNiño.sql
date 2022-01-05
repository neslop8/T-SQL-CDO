--------------------------------------------------------------------------------------------------------------------
USE DGEMPRES21
--pasar de 2173139 al 2172501
--pasar de 2571006 al 2570075
select AINESTADO, AINFECHOS, * from DGEMPRES21..ADNINGRESO where AINCONSEC in (2173139,2172501)
select * from DGEMPRES21..SLNCONHOJ where ADNINGRES1 in (2571006, 2570075)


select * from DGEMPRES21..SLNORDSER where ADNINGRES1 in (2570075) 
select * from DGEMPRES21..SLNORDSER where ADNINGRES1 in (2571006) 
select * from DGEMPRES21..SLNSERPRO where SLNORDSER1 in (select OID from DGEMPRES21..SLNORDSER where ADNINGRES1 in (2571006))
select * from DGEMPRES21..SLNSERHOJ where OID in (select OID from DGEMPRES21..SLNSERPRO where SLNORDSER1 in (select OID from DGEMPRES21..SLNORDSER where ADNINGRES1 in (2571006))


select * from DGEMPRES21..HCNFOLIO where ADNINGRESO in (2562537) and HCFECFOL between '20200803' and '20200805'
select * from DGEMPRES21..HCNREGENF where ADNINGRESO in (2562537) and HCFECREG between '20200803' and '20200805'

select * from DGEMPRES21..HCNFOLIO where ADNINGRESO in (2554881) and HCFECFOL between '20200803' and '20200805'
select * from DGEMPRES21..HCNREGENF where ADNINGRESO in (2554881,2562537,2564179) and HCFECREG between '20200803' and '20200805'

select GENMEDICO, GENMEDICO1, HCEULTFOL, * from DGEMPRES21..HCNEPICRI where ADNINGRESO in (2562537,2564179)
select * from HCNEPIEVO where HCNEPICRI in (322929, 323893)

--pasar de 2571006 al 2570075
--------------------------------------------------------------------------------------------------------------------2554881
--------------------------------------------------------------------------------------------------------------------
begin tran xxx
--delete HCNREGENF where OID=9010604--9010173
/*update HCNSIGVIT set HCNREGENF=8999902 where HCNREGENF=8999697
update HCNEPICRI set GENMEDICO=60, GENMEDICO1=3180 where OID=322929
update HCNEPICRI set HCEULTFOL=NULL where ADNINGRESO in (2513550, 2491422)
delete HCNEPIEVO where HCNEPICRI in (322929, 323893)*/
update DGEMPRES21..HCNREGENF set ADNINGRESO=2570075 where ADNINGRESO in (2571006,2570075) 
update DGEMPRES21..HCNFOLIO set ADNINGRESO=2570075 where ADNINGRESO in (2571006,2570075) 
update DGEMPRES21..SLNORDSER set ADNINGRES1=2570075 where ADNINGRES1 in (2571006,2570075)
update DGEMPRES21..SLNSERPRO set ADNINGRES1=2570075 where SLNORDSER1 in (select OID from DGEMPRES21..SLNORDSER where ADNINGRES1 in (2571006,2570075))
update DGEMPRES21..INNCSUMPA set ADNINGRESO=2570075 where SLNORDSER in (select OID from DGEMPRES21..SLNORDSER where ADNINGRES1 in (2571006,2570075))
update DGEMPRES21..INNCDESUM set ADNINGRESO=2570075 where OID in 
(select INNCDESUM from DGEMPRES21..INNMDESUM where INNMSUMPA in (select OID from DGEMPRES21..INNMSUMPA where INNCSUMPA in (select OID from DGEMPRES21..INNCSUMPA where SLNORDSER in (select OID from DGEMPRES21..SLNORDSER where ADNINGRES1 in (2571006,2570075)))))
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
