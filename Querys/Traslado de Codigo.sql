--------------------------------------------------------------------------------------------------------------------
USE DGEMPRES21
--------------------------------------------------------------------------------------------------------------------
select top 5 gentercer, genpaciend, genpacient, * from DGEMPRES01..GENPACIEN where PACNUMDOC in ('952866912111992','95286691211199')-----333053
select * from DGEMPRES01..genterc
--select GENPACIEN, ADNINGRESO, * from DGEMPRES02..HCNFOLIO where GENPACIEN in (18555, 14357)
select * from DGEMPRES02..HCNREGENF where GENPACIEN in (18555, 14357)

select SIPPROPRE, * from DGEMPRES01..GENSERIPS

begin tran xxx
UPDATE DGEMPRES01..GENPACIEN set PACNUMDOC='VEN95286691211199' where OID=34015
commit tran xxx
rollback tran xxx
---------------------------------------------------------------------------------------------------------
select * from ADNINGRESO where GENPACIEN in (637724)
select * from GENTERCER where OID in (693984)

select gentercer, * from GENPACIEN where PACPRIAPE='ORDOÑEZ' AND PACSEGAPE='ORDOÑEZ'  ORDER BY OID DESC
select top 5 gentercer, * from GENPACIEN where PACNUMDOC in ('22202698','VEN22202698')
select top 5 * from GENTERCER where TERNUMDOC in ('22202698','VEN22202698')-----34883, 622622
select * from TSNCRECIB where GENTERCER IN (679474, 678956)
select * from ADNINGRESO where GENPACIEN in (638119, 638077)
select top 5 * from hcnsolexa where adningreso in (1593596)
select top 5 * from HCNRESEXA where HCNSOLEXA in (3621908, 3621909)
select * from HCNFOLIO where GENPACIEN in (638434, 638450)
select GENPACIEN, * from HCNEPICRI where ADNINGRESO in (1593596)
select top 5 * from CDO02_21..asi_ingreso where id in (1586336, 1587085)
select * from CDO02_21..asi_suministro_solicitud where ingreso in (1586336, 1587085)
select * from HCNFOLIO where GENPACIEN in (619972)
select * from HCNREGENF where GENPACIEN in (619972)

select * from ADNINGRESO where AINCONSEC in (1269774)
select * from HCNFOLIO where ADNINGRESO in (1593596)

begin tran xxx
update HCNEPICRI SET GENPACIEN=711084 where GENPACIEN=711095
update CDO02_21..asi_ingreso set paciente=711084 where paciente=711095
update ADNINGRESO SET GENPACIEN=711084 where GENPACIEN=711095
update HCNFOLIO SET GENPACIEN=711084 where GENPACIEN=711095
update HCNREGENF SET GENPACIEN=711084 where GENPACIEN=711095
commit tran xxx
--------------------------------------------------------------------------------------------------------------------
begin tran xxx
--------------------------------------------------------------------------------------------------------------------
DECLARE @oid_viejo INT = (select OID from GENPACIEN where PACNUMDOC in ('1023302092'))
DECLARE @oid_nuevo INT = (select OID from GENPACIEN where PACNUMDOC in ('1023362092'))
UPDATE dgempres21..HCNFOLIO SET GENPACIEN = @oid_nuevo WHERE GENPACIEN = @oid_viejo
--------------EN DGH
UPDATE dgempres21..ADNINGRESO SET GENPACIEN = @oid_nuevo WHERE GENPACIEN = @oid_viejo
	
--declare @ciclo int =(select max(HCNUMFOL) from DGEMPRES21..hcnfolio WHERE GENPACIEN=@oid_viejo)
--DECLARE @sumar INT =(SELECT MAX(HCNUMFOL) FROM DGEMPRES21..hcnfolio WHERE GENPACIEN = @oid_nuevo)
--UPDATE dgempres21..HCNFOLIO SET HCNUMFOL = HCNUMFOL + @sumar, GENPACIEN = @oid_nuevo WHERE GENPACIEN = @oid_viejo

UPDATE dgempres21..HCNREGENF SET GENPACIEN = @oid_nuevo WHERE GENPACIEN = @oid_viejo
UPDATE dgempres21..HCNINCAPA SET GENPACIEN = @oid_nuevo WHERE GENPACIEN = @oid_viejo
UPDATE dgempres21..HCNEPICRI SET GENPACIEN = @oid_nuevo WHERE GENPACIEN = @oid_viejo
-------------EN CDO
UPDATE CDO02_21..asi_ingreso SET paciente = @oid_nuevo WHERE paciente = @oid_viejo
UPDATE CDO02_21..asi_suministro_solicitud SET paciente = @oid_nuevo WHERE paciente = @oid_viejo
UPDATE CDO02_21..asi_control_urgencia SET paciente = @oid_nuevo WHERE paciente = @oid_viejo
UPDATE CDO02_21..asi_atencion_urgencia SET paciente = @oid_nuevo WHERE paciente = @oid_viejo
UPDATE CDO02_21..asi_tratamiento_solicitud SET paciente = @oid_nuevo WHERE paciente = @oid_viejo
UPDATE CDO02_21..asi_autorizacion_solicitud_interna SET paciente = @oid_nuevo WHERE paciente = @oid_viejo
--------------------------------------------------------------------------------------------------------------------
select * from dgempres22..ADNINGRESO where OID=1617036
begin tran xxx
update ADNINGRESO set GENPACIEN=772185 where OID=1967405
update HCNFOLIO set GENPACIEN=772185 where ADNINGRESO=1967405
update HCNREGENF set GENPACIEN=772185 where ADNINGRESO=1967405
update CDO02_21..asi_ingreso set paciente=772185 where id in (1967405)
update CDO02_21..asi_suministro_solicitud set paciente=772185 where ingreso in (1967405)
update CDO02_21..asi_tratamiento_solicitud set paciente=772185 where paciente IN (1967405)
update CDO02_21..asi_autorizacion_solicitud_interna set paciente=772185 where id IN (779436, 780479, 780537, 782920)
commit tran xxx

select top 5 GENMEDICO, GENMEDICO1, * from HCNEPICRI where GENPACIEN in (394119, 772185)

update HCNEPICRI set GENMEDICO=2509, GENMEDICO1=2509, HCEESTDOC=0, HCEULTFOL=0 where OID=262595
update HCNEPICRI set GENMEDICO=2509, GENMEDICO1=2509, HCEESTDOC=1 where OID=262595

select top 5 * from HCNEPIEVO where HCNEPICRI=262595

begin tran xxx
delete HCNEPIEVO where HCNEPICRI=262595
commit tran xxx


select top 5 * from CDO02_21..asi_tratamiento_solicitud where paciente IN (680063, 690255)
select top 5 * from CDO02_21..asi_autorizacion_
select * from CDO02_21..asi_autorizacion_solicitud_interna where paciente IN (772185)
select * from CDO02_21..asi_autorizacion_solicitud_interna where id IN (779436, 780479, 780537, 782920)
select * from CDO02_21..asi_autorizacion_solicitud_interna_ingreso where ingreso in (1967405)
--------------------------------------------------------------------------------------------------------------------
