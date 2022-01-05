--------------------------------------------------------------------------------------------------------------------
USE DGEMPRES21
-----pasar de 1926727 al 1946959
-----pasar de 2297979 al 2319930
select top 5 AINESTADO, * from DGEMPRES21..ADNINGRESO where AINCONSEC in (1926727 , 1946959)
select GENMEDICO, GENMEDICO1, * from DGEMPRES21..HCNEPICRI where ADNINGRESO in (2158588, 2164306) 



select * from DGEMPRES21..SLNORDSER where ADNINGRES1 in (2297979) and SOSFECORD >= '20190626'
select * from DGEMPRES21..SLNSERPRO where SLNORDSER1 in (select OID from DGEMPRES21..SLNORDSER where ADNINGRES1 in (2284973) and SOSMODULO=2 and SOSFECORD > '20190610')
select * from INNCSUMPA where SLNORDSER in (select OID from DGEMPRES21..SLNORDSER where ADNINGRES1 in (2284973) and SOSMODULO=2 and SOSFECORD > '20190610')
select * from INNCDESUM where OID in 
(select INNCDESUM from INNMDESUM where INNMSUMPA in (select OID from INNMSUMPA where INNCSUMPA in (select OID from INNCSUMPA where SLNORDSER in (select OID from DGEMPRES21..SLNORDSER where ADNINGRES1 in (2284973) and SOSMODULO=2 and SOSFECORD > '20190610'))))

select * from DGEMPRES21..HCNFOLIO where ADNINGRESO in (2158139, 2162651)
select * from HCNREGENF where ADNINGRESO in (2158139, 2162651) order by 5, 4

select top 5 GENMEDICO, GENMEDICO1, * from HCNEPICRI where ADNINGRESO in (2172886, 2168949)
delete HCNEPIEVO where HCNEPICRI in (286200, 286333)

select * from DGEMPRES21..HCNFOLIO where ADNINGRESO in (2297979)
select * from DGEMPRES21..HCNREGENF where ADNINGRESO in (2297979, 2319930) order by 3
select GENMEDICO, GENMEDICO1, * from DGEMPRES21..HCNEPICRI where ADNINGRESO in (2319930, 2297979)
select * from HCNEPIEVO where HCNEPICRI=303187

delete HCNEPIEVO where HCNEPICRI=303187
update HCNEPICRI set GENMEDICO=2498, GENMEDICO1=2498, HCEULTFOL=NULL where OID=303187

update HCNEPICRI set GENMEDICO=21, GENMEDICO1=21 where OID=286200
update HCNEPICRI set HCEESTDOC=0 where OID=286200
update HCNEPICRI set HCEULTFOL=NULL where OID=286200
-----pasar de 1926727 al 1946959
-----pasar de 2297979 al 2319930
select top 5 AINESTADO, * from DGEMPRES21..ADNINGRESO where AINCONSEC in (1926727 , 1946959)
--------------------------------------------------------------------------------------------------------------------
begin tran xxx
--update ADNINGRESO set AINFECING='2019-26-06 07:00:00' where OID=2319930
--update HCNEPICRI set ADNINGRESO=2319930 where ADNINGRESO=2297979
--delete HCNEPIEVO where HCNEPICRI=303187
update HCNEPICRI set GENMEDICO=2498, GENMEDICO1=2498 where OID=303187
--update HCNNOTENF set HCNREGENF=8688600 where HCNREGENF=8715638
--update HCNLIQADM set HCNREGENF=8688600 where HCNREGENF=8715638
--update HCNLIQELM set HCNREGENF=8688600 where HCNREGENF=8715638
--update HCNSIGVIT set HCNREGENF=8688600 where HCNREGENF=8715638
--update HCNCONING set HCNREGENF=8690320 where HCNREGENF=8717191
--delete HCNREGENF where OID=8717191--8690320
update HCNREGENF set ADNINGRESO=2319930 where ADNINGRESO=2297979 and HCFECREG >= '20190626'
update HCNFOLIO set ADNINGRESO=2319930 where ADNINGRESO in (2297979) and HCFECFOL >= '20190626'

update DGEMPRES21..SLNORDSER set ADNINGRES1=2319930 where ADNINGRES1 in (2297979) and SOSFECORD >= '20190626'
/*update DGEMPRES21..SLNSERPRO set ADNINGRES1=2319930 where SLNORDSER1 in (select OID from DGEMPRES21..SLNORDSER where ADNINGRES1 in (2297979) and SOSFECORD >= '20190626')
update DGEMPRES21..INNCSUMPA set ADNINGRESO=2319930 where SLNORDSER in (select OID from DGEMPRES21..SLNORDSER where ADNINGRES1 in (2297979) and SOSFECORD >= '20190626')
update DGEMPRES21..INNCDESUM set ADNINGRESO=2319930 where OID in 
(select INNCDESUM from INNMDESUM where INNMSUMPA in (select OID from INNMSUMPA where INNCSUMPA in (select OID from INNCSUMPA where SLNORDSER in (select OID from DGEMPRES21..SLNORDSER where ADNINGRES1 in (2297979) and SOSFECORD >= '20190626'))))*/
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