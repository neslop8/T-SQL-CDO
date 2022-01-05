--------------------------------------------------------------------------------------------------------------------
USE DGEMPRES21
-----pasar del 2064076 al 2084021
------pasar de 2449253 al 2470576
select top 5 AINESTADO, * from DGEMPRES21..ADNINGRESO where AINCONSEC in (2064076, 2084021)
select top 5 * from DGEMPRES21..SLNCONHOJ where ADNINGRES1 in (2289445, 2308157)

update SLNCONHOJ set ADNINGRES1=2308157 where OID=1867681


select * from DGEMPRES21..SLNORDSER where ADNINGRES1 in (2449253) 
select * from DGEMPRES21..SLNSERPRO where SLNORDSER1 in (select OID from DGEMPRES21..SLNORDSER where ADNINGRES1 in (2289445, 2308157))
--select * from DGEMPRES21..SLNSERHOJ where OID in (22747401, 22747402, 22747403) 
select * from INNCSUMPA where SLNORDSER in (select OID from DGEMPRES21..SLNORDSER where ADNINGRES1 in (2289445, 2308157))
select * from DGEMPRES21..INNMSUMPA where INNCSUMPA in (select OID from INNCSUMPA where SLNORDSER in (select OID from DGEMPRES21..SLNORDSER where ADNINGRES1 in (2289445, 2308157))) 
select * from INNCDESUM where OID in 
(select INNCDESUM from INNMDESUM where INNMSUMPA in (select OID from INNMSUMPA where INNCSUMPA in (select OID from INNCSUMPA where SLNORDSER in (select OID from DGEMPRES21..SLNORDSER where ADNINGRES1 in (2289445, 2308157)))))



-----pasar de 1918719 al 1936406
-----pasar de 2289445 al 2308157
--------------------------------------------------------------------------------------------------------------------
begin tran xxx
--update ADNINGRESO set AINFECING='2019-26-06 07:00:00' where OID=2319930
--update HCNEPICRI set ADNINGRESO=2319930 where ADNINGRESO=2297979
--delete HCNEPIEVO where HCNEPICRI=303187
--update HCNEPICRI set GENMEDICO=2498, GENMEDICO1=2498 where OID=303187
--update HCNCONING set HCNREGENF=8690320 where HCNREGENF=8717191
--delete HCNREGENF where OID=8717191--8690320
--update HCNREGENF set ADNINGRESO=2308157 where ADNINGRESO in (2289445,2308157)
--update HCNFOLIO set ADNINGRESO=2308157 where ADNINGRESO in (2289445,2308157)

update DGEMPRES21..SLNORDSER set ADNINGRES1=2308157 where ADNINGRES1 in (2289445, 2308157)
update DGEMPRES21..SLNSERPRO set ADNINGRES1=2308157 where SLNORDSER1 in (select OID from DGEMPRES21..SLNORDSER where ADNINGRES1 in (2289445, 2308157))
update DGEMPRES21..INNCSUMPA set ADNINGRESO=2308157 where SLNORDSER in (select OID from DGEMPRES21..SLNORDSER where ADNINGRES1 in (2289445, 2308157))
update DGEMPRES21..INNCDESUM set ADNINGRESO=2308157 where OID in 
(select INNCDESUM from INNMDESUM where INNMSUMPA in (select OID from INNMSUMPA where INNCSUMPA in (select OID from INNCSUMPA where SLNORDSER in (select OID from DGEMPRES21..SLNORDSER where ADNINGRES1 in (2289445, 2308157)))))
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