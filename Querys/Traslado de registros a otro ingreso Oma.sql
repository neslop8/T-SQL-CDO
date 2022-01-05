--------------------------------------------------------------------------------------------------------------------
USE DGEMPRES01
--pasar de 246312 al 255833
--pasar de 301958 al 313906
select * from DGEMPRES01..ADNINGRESO where AINCONSEC in (246312, 255833)
select top 5 * from DGEMPRES01..SLNCONHOJ where ADNINGRES1 in (301958, 313906)

--agregar cabecera de Ingreso
begin tran xxx
insert into DGEMPRES01..SLNCONHOJ(ADNINGRES1, SCOVALFRA, SCOPORDES, SCOVALDES, SCOTIPDES, SCOLIQHOJ, SCOVALANT, SCOVALREC, SCOEVEPAQ, SCOCARCUE, GENMEDICO1, GENPRESAL1, SCOVALPAG, GENARESER1, GENUSUARIO2, SCOPORCTA, SCOPORCOP, SCONETPAC, SCONETENT, SCODESPAC, SCODESENT, SCOIVAPAC, SCOIVAENT, SCOCARPAC, SCOAJU100, SCOTOTPAC, SCOTOTENT, TSNCAJA, SLNUNIFUN, GENTERCER, SCOLISFAC, GENSERIPS, CMNCITMED, GENUSUARIO3, IFNTIPCOM1, IFMNUMCOM1, HCNODOPRES, SCORESPAG, SCODERSAL, SCOESTAUT, OptimisticLockField)
select 313906, SCOVALFRA, SCOPORDES, SCOVALDES, SCOTIPDES, SCOLIQHOJ, SCOVALANT, SCOVALREC, SCOEVEPAQ, SCOCARCUE, GENMEDICO1, GENPRESAL1, SCOVALPAG, GENARESER1, GENUSUARIO2, SCOPORCTA, SCOPORCOP, SCONETPAC, SCONETENT, SCODESPAC, SCODESENT, SCOIVAPAC, SCOIVAENT, SCOCARPAC, SCOAJU100, SCOTOTPAC, SCOTOTENT, TSNCAJA, SLNUNIFUN, GENTERCER, SCOLISFAC, GENSERIPS, CMNCITMED, GENUSUARIO3, IFNTIPCOM1, IFMNUMCOM1, HCNODOPRES, SCORESPAG, SCODERSAL, SCOESTAUT, OptimisticLockField
from DGEMPRES01..SLNCONHOJ where ADNINGRES1 in (301958)
commit tran xxx

select * from DGEMPRES01..SLNORDSER where OID=1295869
select * from DGEMPRES01..SLNSERPRO where SLNORDSER1 in (1295869)
select * from DGEMPRES01..SLNPROHOJ where OID in (3664787)
select * from DGEMPRES01..INNCSUMPA where OID in (1310474)
select * from DGEMPRES01..INNMSUMPA where INNCSUMPA in (1310474)

select * from DGEMPRES01..SLNORDSER where ADNINGRES1=313906
select * from DGEMPRES01..SLNSERPRO where SLNORDSER1 in (select OID from DGEMPRES01..SLNORDSER where ADNINGRES1=313906)
select * from DGEMPRES01..SLNPROHOJ where OID in (select OID from DGEMPRES01..SLNSERPRO where SLNORDSER1 in (select OID from DGEMPRES01..SLNORDSER where ADNINGRES1=313906))


select * from DGEMPRES01..SLNSERPRO where SLNORDSER1 in (select OID from DGEMPRES01..SLNORDSER where ADNINGRES1 in (307116))
select * from DGEMPRES01..SLNPROHOJ where OID in (select OID from DGEMPRES01..SLNSERPRO where SLNORDSER1 in (select OID from DGEMPRES01..SLNORDSER where ADNINGRES1 in (307116)))
select * from DGEMPRES01..SLNSERHOJ where OID in (select OID from DGEMPRES01..SLNSERPRO where SLNORDSER1 in (select OID from DGEMPRES01..SLNORDSER where ADNINGRES1 in (307116)))

select * from DGEMPRES01..SLNSERPRO where OID in (3726527, 3726528, 3729493, 3730338)
select * from DGEMPRES01..SLNPROHOJ where OID in (3726527, 3726528, 3729493, 3730338)


select * from DGEMPRES01..HCNFOLIO where ADNINGRESO in (122867) and HCFECFOL > '20210501'
select * from DGEMPRES01..HCNREGENF where ADNINGRESO in (122867, 153268) and HCFECREG > '20210501' order by 5, 4

select * from DGEMPRES01..HCNFOLIO where ADNINGRESO in (153268) and HCFECFOL between '20200803' and '20200805'
select * from DGEMPRES01..HCNREGENF where ADNINGRESO in (153268) and HCFECREG between '20200803' and '20200805'

select * from DGEMPRES01..HCNFOLIO where ADNINGRESO in (2554881) and HCFECFOL between '20200803' and '20200805'
select * from DGEMPRES01..HCNREGENF where ADNINGRESO in (2554881,2562537,2564179) and HCFECREG between '20200803' and '20200805'

select GENMEDICO, GENMEDICO1, HCEULTFOL, * from DGEMPRES01..HCNEPICRI where ADNINGRESO in (2562537,2564179)
select * from HCNEPIEVO where HCNEPICRI in (322929, 323893)

--pasar de 301958 al 313906
--------------------------------------------------------------------------------------------------------------------2554881
--------------------------------------------------------------------------------------------------------------------
begin tran xxx
update DGEMPRES01..SLNORDSER set ADNINGRES1=313906 where OID=1295869 --and SOSFECORD > '20210901'
update DGEMPRES01..SLNSERPRO set ADNINGRES1=313906 where SLNORDSER1=1295869
update DGEMPRES01..INNCSUMPA set ADNINGRESO=313906 where SLNORDSER in (1295869)
update DGEMPRES01..INNCDESUM set ADNINGRESO=313906 where OID in 
(select INNCDESUM from DGEMPRES01..INNMDESUM where INNMSUMPA in (select OID from DGEMPRES01..INNMSUMPA where INNCSUMPA in (select OID from DGEMPRES01..INNCSUMPA where SLNORDSER in (1295869))))
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
