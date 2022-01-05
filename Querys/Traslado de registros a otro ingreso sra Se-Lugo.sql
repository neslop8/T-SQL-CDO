--------------------------------------------------------------------------------------------------------------------
USE DGEMPRES21
--pasar de 2178097 al 2178241
--pasar de 2576950 al 2577171
select top 5 AINESTADO, AINFECFAC, ADFECANULA, ainfecing, * from DGEMPRES21..ADNINGRESO where AINCONSEC in (2178097,2178241)
select AINESTADO, AINFECHOS, * from DGEMPRES21..ADNINGRESO where GENPACIEN in (858949)

--select top 5 * from DGEMPRES21..ctncom2020 where comdetalle like '%Suministro a Pacientes No: 00000005003129%'
select * from DGEMPRES21..SLNORDSER where ADNINGRES1 in (2552651) and SOSFECORD > '20200819'--14 Jun al 18 Jun
select * from DGEMPRES21..SLNCONHOJ where ADNINGRES1 in (2535194,2539438,2539465)
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

select * from DGEMPRES21..HCNFOLIO where ADNINGRESO in (2539465) and HCFECFOL > '20200614'
select * from DGEMPRES21..HCNREGENF where ADNINGRESO in (2539465) and HCFECREG > '20200614'
select GENMEDICO, GENMEDICO1, * from DGEMPRES21..HCNEPICRI where ADNINGRESO in (2519147, 2509471)
select * from HCNEPIEVO where HCNEPICRI in (322929,323893)
update DGEMPRES21..HCNEPICRI set GENMEDICO=60, GENMEDICO1=3180 where ADNINGRESO in (2491422)
update DGEMPRES21..HCNEPICRI set GENMEDICO=21, GENMEDICO1=21 where ADNINGRESO in (2513550)

--pasar de 2576950 al 2577171
--------------------------------------------------------------------------------------------------------------------
begin tran xxx
update DGEMPRES21..HCNFOLIO set ADNINGRESO=2577171 where ADNINGRESO in (2576950) and HCNUMFOL in (96,97)
/*update HCNDEVMED set HCNREGENF=8951092 where HCNREGENF in (8951351)
update HCNSIGVIT set HCNREGENF=8951092 where HCNREGENF in (8951351)
update HCNCONING set HCNREGENF=8951092 where HCNREGENF in (8951351)
update HCNVALNEURO set HCNREGENF=8951092 where HCNREGENF in (8951351)
update HCNLIQADM set HCNREGENF=8951092 where HCNREGENF in (8951351)
update HCNACTENF set HCNREGENF=8951092 where HCNREGENF in (8951351)
update HCNNOTENF set HCNREGENF=8951092 where HCNREGENF in (8951351)
update HCNGLUCOM set HCNREGENF=8951092 where HCNREGENF in (8951351)
delete HCNREGENF where OID=8951351--8951092*/
--update DGEMPRES21..HCNEPICRI set HCEULTFOL=NULL, HCEESTDOC=0 where ADNINGRESO in (2513550, 2491422)
--delete HCNEPIEVO where HCNEPICRI in (322929, 323893)
update DGEMPRES21..HCNREGENF set ADNINGRESO=2571588 where ADNINGRESO in (2552651) and HCFECREG > '20200819'
update DGEMPRES21..HCNFOLIO set ADNINGRESO=2571588 where ADNINGRESO in (2552651) and HCFECFOL > '20200819'
update DGEMPRES21..SLNORDSER set ADNINGRES1=2571588 where ADNINGRES1 in (2552651) and SOSFECORD > '20200819'
update DGEMPRES21..SLNSERPRO set ADNINGRES1=2571588 where SLNORDSER1 in (select OID from DGEMPRES21..SLNORDSER where ADNINGRES1 in (2552651) and SOSFECORD > '20200819')
update DGEMPRES21..INNCSUMPA set ADNINGRESO=2571588 where SLNORDSER in (select OID from DGEMPRES21..SLNORDSER where ADNINGRES1 in (2552651) and SOSFECORD > '20200819')
update DGEMPRES21..INNCDESUM set ADNINGRESO=2571588 where OID in 
(select INNCDESUM from DGEMPRES21..INNMDESUM where INNMSUMPA in (select OID from DGEMPRES21..INNMSUMPA where INNCSUMPA in (select OID from DGEMPRES21..INNCSUMPA where SLNORDSER in (select OID from DGEMPRES21..SLNORDSER where ADNINGRES1 in (2552651) and SOSFECORD > '20200819'))))
commit tran xxx
rollback tran xxx
--------------------------------------------------------------------------------------------------------------------
select * from  CDO02_21..asi_suministro_solicitud where ingreso in (2297979)
select top 5 * from  CDO02_21..asi_tratamiento_solicitud where ingreso in (2297979)
select top 5 * from  CDO02_21..asi_control_urgencia where ingreso in (2319930)
--------------------------------------------------------------------------------------------------------------------
begin tran xxx
update CDO02_21..asi_suministro_solicitud set ingreso=2509471  where ingreso in (2519147)-- and fch_creacion > '20190626'
update CDO02_21..asi_tratamiento_solicitud set ingreso=2509471 where ingreso in (2519147)
update CDO02_21..asi_control_urgencia set ingreso=2509471 where ingreso in (2519147)
rollback tran xxx
commit tran xxx
--------------------------------------------------------------------------------------------------------------------
begin tran xxx
update adningreso set ainestado=3 where oid=2449559
update adningreso set ainestado=0 where oid=2446758
commit tran xxx
--------------------------------------------------------------------------------------------------------------------
