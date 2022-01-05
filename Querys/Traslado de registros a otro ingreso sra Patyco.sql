--------------------------------------------------------------------------------------------------------------------
USE DGEMPRES21
-----pasar del 2061152 al 2089774
------pasar de 2446215 al 2476872
select top 5 AINESTADO, * from DGEMPRES21..ADNINGRESO where AINCONSEC in (2061152, 2089774)
select top 5 AINESTADO, * from DGEMPRES21..ADNINGRESO where OID in (2441720, 2446215, 2470576, 2476872)
select * from DGEMPRES21..SLNFACTUR where ADNINGRESO in (2437780, 2438902)

select top 5 GENPLAPRO1, * from DGEMPRES21..GENDETCON where OID in (270, 476)
select top 5 * from DGEMPRES21..GENPLAPRO where OID in (8, 208)

select * from DGEMPRES21..HCNFOLIO where GENPACIEN in (972860)
select * from DGEMPRES21..HCNFOLIO where GENPACIEN in (975519)
select ADNINGRESO, COUNT(*) from DGEMPRES21..HCNFOLIO where GENPACIEN in (972860) group by ADNINGRESO

update HCNFOLIO set HCNUMFOL= where OID=

select top 5 AINESTADO, * from DGEMPRES21..ADNINGRESO where OID in (2441720, 2446215, 2470576, 2476872)

AINCONSEC	GENPACIEN	(Sin nombre de columna)
2061152	972860	36
2089774	972860	8
2084021	975519	18


select * from DGEMPRES21..HCNFOLIO where ADNINGRESO in (2446215) and HCFECFOL > '20200203'
select * from DGEMPRES21..HCNREGENF where ADNINGRESO in (2446215) and HCFECREG > '20200203'

select * from temp_ADNINGRESO where AINCONSEC in (2056892, 2061152, 2084021, 2089774)
select AINCONSEC, GENPACIEN, COUNT(*) from temp_ADNINGRESO where AINCONSEC in (2056892, 2061152, 2084021, 2089774) group by AINCONSEC, GENPACIEN

select * from DGEMPRES21..SLNORDSER where ADNINGRES1 in (2446215) and SOSFECORD > '20200203'
select * from DGEMPRES21..SLNSERPRO where SLNORDSER1 in (select OID from DGEMPRES21..SLNORDSER where ADNINGRES1 in (2446215) and SOSFECORD > '20200203')
select * from INNCSUMPA where SLNORDSER in (select OID from DGEMPRES21..SLNORDSER where ADNINGRES1 in (2421497, 2419160))
select * from INNMSUMPA where inncsumpa in (select OID from INNCSUMPA where SLNORDSER in (select OID from DGEMPRES21..SLNORDSER where ADNINGRES1 in (2421497, 2419160)))
select * from INNMDESUM where INNMSUMPA in (select OID from INNMSUMPA where inncsumpa in (select OID from INNCSUMPA where SLNORDSER in (select OID from DGEMPRES21..SLNORDSER where ADNINGRES1 in (2154828)  and SOSMODULO in (2))))
select * from INNCDESUM where oid in 
(select INNCDESUM from INNMDESUM where INNMSUMPA in (select OID from INNMSUMPA where inncsumpa in (select OID from INNCSUMPA where SLNORDSER in (select OID from DGEMPRES21..SLNORDSER where ADNINGRES1 in (2421497)))))

select * from DGEMPRES21..HCNFOLIO where ADNINGRESO in (2470576) and HCFECFOL > '20191227'
select * from HCNREGENF where ADNINGRESO in (2449253) and HCFECREG > '20191227' order by GENARESER, HCFECREG

select top 5 * from HCNINCAPA where ADNINGRESO in (2449253, 2470576)
select top 5 GENMEDICO, GENMEDICO1, * from HCNEPICRI where ADNINGRESO in (2449253, 2470576)
delete HCNEPIEVO where HCNEPICRI in (317726)

update HCNEPICRI set GENMEDICO=279, GENMEDICO1=279 where OID=317726
update HCNEPICRI set HCEULTFOL=NULL where OID=317726

------pasar de 2446215 al 2476872
--------------------------------------------------------------------------------------------------------------------
begin tran xxx
update DGEMPRES21..HCNFOLIO set GENPACIEN=975519 where ADNINGRESO in (2470576)
--update HCNINCAPA set ADNINGRESO=2476872 where ADNINGRESO=2446215
update HCNREGENF set ADNINGRESO=2476872 where ADNINGRESO in (2446215) and HCFECREG > '20200203'
update DGEMPRES21..HCNFOLIO set ADNINGRESO=2470576 where ADNINGRESO in (2446215) and HCFECFOL > '20200203'
update DGEMPRES21..SLNORDSER set ADNINGRES1=2476872 where OID in (9470173,9471451,9473808,9474144,9474291,9475299,9477872,9477880,9479101,9479493)
update DGEMPRES21..SLNSERPRO set ADNINGRES1=2476872 where SLNORDSER1 in (9470173,9471451,9473808,9474144,9474291,9475299,9477872,9477880,9479101,9479493)
update DGEMPRES21..INNCSUMPA set ADNINGRESO=2476872 where SLNORDSER in (9470173,9471451,9473808,9474144,9474291,9475299,9477872,9477880,9479101,9479493)
update DGEMPRES21..INNCDESUM set ADNINGRESO=2476872 where oid in 
(select INNCDESUM from DGEMPRES21..INNMDESUM where INNMSUMPA in (select OID from DGEMPRES21..INNMSUMPA where inncsumpa in (select OID from DGEMPRES21..INNCSUMPA where SLNORDSER in (9470173,9471451,9473808,9474144,9474291,9475299,9477872,9477880,9479101,9479493))))
commit tran xxx
rollback tran xxx
--------------------------------------------------------------------------------------------------------------------
begin tran xxx
update CDO02_21..asi_suministro_solicitud set ingreso=2446758  where ingreso in (2449559)
update CDO02_21..asi_tratamiento_solicitud set ingreso=2446758 where ingreso in (2449559)
update CDO02_21..asi_control_urgencia set ingreso=2446758 where ingreso in (2449559)
rollback tran xxx
commit tran xxx
--------------------------------------------------------------------------------------------------------------------