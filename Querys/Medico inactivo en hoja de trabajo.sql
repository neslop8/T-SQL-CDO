use DGEMPRES01
select top 5 * from genmedico where GMECODIGO='AACOSTA'
select top 5 * from GENMEDICO where GMEESTADO=0

select GENMEDICO1, * from SLNSERPRO where ADNINGRES1 IN (select OID from ADNINGRESO where AINESTADO in (0,3)) and 
GENMEDICO1 in (select OID from GENMEDICO where GMEESTADO <> 0)

select GENMEDICO1, COUNT(*) from SLNSERPRO where ADNINGRES1 IN (select OID from ADNINGRESO where AINESTADO in (0,3)) and 
GENMEDICO1 in (select OID from GENMEDICO where GMEESTADO <> 0) group by GENMEDICO1
select AINESTADO, * from ADNINGRESO where AINCONSEC=261848
---------------------------------------------------------------------------------------------
select * from GENMEDICO where OID in (1178)
-----------------------------------Hoja de Trabajo
select GENMEDICO1, * from SLNSERPRO where ADNINGRES1 IN (select OID from ADNINGRESO where AINCONSEC in (261848))
and GENMEDICO1 in (select OID from GENMEDICO where GMEESTADO <> 0)
-----------------------------------Cirugias
select GENMEDICO1, * from SLNPAQHOJ where SLNSERHOJ1 in (select OID from SLNSERPRO where ADNINGRES1 IN (select OID from ADNINGRESO where AINCONSEC in (261848)))
and GENMEDICO1 in (select OID from GENMEDICO where GMEESTADO <> 0)
---------------------------------------------------------------------------------------------
select * from GENMEDICO where OID in (
select GENMEDICO1 from SLNPAQHOJ where SLNSERHOJ1 in (select OID from SLNSERPRO where ADNINGRES1 IN (select OID from ADNINGRESO where AINCONSEC in (261848)))
group by GENMEDICO1)
---------------------------------------------------------------------------------------------