--------------------------------------------------------------------------------------------------------------------
USE DGEMPRES01
-----pasar del 270633 al 270754
-----pasar del 333499 al 333676
select top 5 AINESTADO, * from DGEMPRES01..ADNINGRESO where AINCONSEC in (270633, 270754)
select top 5 * from DGEMPRES21..SLNCONHOJ where ADNINGRES1 in (333499, 333676)

update SLNCONHOJ set ADNINGRES1=2308157 where OID=1867681


select * from DGEMPRES01..SLNORDSER where ADNINGRES1 in (333499) 
select * from DGEMPRES01..SLNSERPRO where SLNORDSER1 in (select OID from DGEMPRES21..SLNORDSER where ADNINGRES1 in (333499))
--select * from DGEMPRES21..SLNSERHOJ where OID in (22747401, 22747402, 22747403) 
select * from INNCSUMPA where SLNORDSER in (select OID from DGEMPRES21..SLNORDSER where ADNINGRES1 in (2289445, 2308157))
select * from DGEMPRES21..INNMSUMPA where INNCSUMPA in (select OID from INNCSUMPA where SLNORDSER in (select OID from DGEMPRES21..SLNORDSER where ADNINGRES1 in (2289445, 2308157))) 
select * from INNCDESUM where OID in 
(select INNCDESUM from INNMDESUM where INNMSUMPA in (select OID from INNMSUMPA where INNCSUMPA in (select OID from INNCSUMPA where SLNORDSER in (select OID from DGEMPRES21..SLNORDSER where ADNINGRES1 in (2289445, 2308157)))))

select * from DGEMPRES01..HCNREGENF where ADNINGRESO in (347645, 319386) 
select * from DGEMPRES01..HCNFOLIO where ADNINGRESO in (347645) 

------pasar de 333499 al 333676
--------------------------------------------------------------------------------------------------------------------
begin tran xxx
--update ADNINGRESO set AINFECING='2019-26-06 07:00:00' where OID=2319930
--update HCNEPICRI set ADNINGRESO=2319930 where ADNINGRESO=2297979
--delete HCNEPIEVO where HCNEPICRI=303187
--update HCNEPICRI set GENMEDICO=2498, GENMEDICO1=2498 where OID=303187
--update HCNCONING set HCNREGENF=8690320 where HCNREGENF=8717191
/*delete HCNREGENF where OID=396081--394997
update HCNREGENF set ADNINGRESO=319386 where ADNINGRESO in (347645)
update HCNFOLIO set ADNINGRESO=319386 where ADNINGRESO in (347645)*/

update DGEMPRES01..SLNORDSER set ADNINGRES1=333676 where ADNINGRES1 in (333499)
update DGEMPRES01..SLNSERPRO set ADNINGRES1=333676 where SLNORDSER1 in (select OID from DGEMPRES01..SLNORDSER where ADNINGRES1 in (333499))
update DGEMPRES01..INNCSUMPA set ADNINGRESO=333676 where SLNORDSER in (select OID from DGEMPRES01..SLNORDSER where ADNINGRES1 in (333499))
update DGEMPRES01..INNCDESUM set ADNINGRESO=333676 where OID in 
(select INNCDESUM from INNMDESUM where INNMSUMPA in (select OID from INNMSUMPA where INNCSUMPA in (select OID from INNCSUMPA where SLNORDSER in (select OID from DGEMPRES01..SLNORDSER where ADNINGRES1 in (333499)))))
commit tran xxx
rollback tran xxx
--------------------------------------------------------------------------------------------------------------------
select * from  CDO02_21..asi_suministro_solicitud where ingreso in (2297979)
select top 5 * from  CDO02_21..asi_tratamiento_solicitud where ingreso in (2297979)
select top 5 * from  CDO02_21..asi_control_urgencia where ingreso in (2319930)
--------------------------------------------------------------------------------------------------------------------
begin tran xxx
update CDO02_21..asi_suministro_solicitud set ingreso=2308157  where ingreso in (2289445, 2308157)
update CDO02_21..asi_tratamiento_solicitud set ingreso=2308157 where ingreso in (2289445, 2308157)
update CDO02_21..asi_control_urgencia set ingreso=2308157 where ingreso in (2289445, 2308157)
rollback tran xxx
commit tran xxx
--------------------------------------------------------------------------------------------------------------------
select * from DGEMPRES03..SLNSERPRO where SLNORDSER1 in (select OID from DGEMPRES21..SLNORDSER where ADNINGRES1 in (347645))
select * from DGEMPRES03..INNCSUMPA where SLNORDSER in (select OID from DGEMPRES21..SLNORDSER where ADNINGRES1 in (347645))

update DGEMPRES01..SLNSERPRO set ADNINGRES1= where OID=
update DGEMPRES01..INNCSUMPA set ADNINGRES1= where OID=