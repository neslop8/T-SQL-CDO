select top 20 * from INNDOCUME order by OID desc
select * from DGEMPRES22..GENCONSEC where OID in (167, 273)
-----------------------------------------------------------------------------------------------------------------
select top 15 * from INNDOCUME where IDCONSEC like 'S%' order by OID desc
select top 15 * from INNDOCUME where IDCONSEC like 'E%' order by OID desc
-----------------------------------------------------------------------------------------------------------------
update DGEMPRES22..GENCONSEC set GCONUMERO=1045 where OID=167
update DGEMPRES22..GENCONSEC set GCONUMERO=5251 where OID=273
delete DGEMPRES22..INNDOCUME where OID >5488256
delete DGEMPRES22..INNLOTSER where OID >= 55533
delete DGEMPRES22..INNFISICO where OID >= 76584
delete DGEMPRES22..INNAJUINVEC where OID > 5488241
delete DGEMPRES22..INNAJUINVED where OID > 63006
--delete DGEMPRES22..INNDOCUME where OID between 5488256 and 5488269
--select * from DGEMPRES21..GENCONSEC where OID in (167, 273)
--select * from DGEMPRES22..GENCONSEC where OID in (167, 273)
-----------------------------------------------------------------------------------------------------------------
select top 15 * from DGEMPRES22..INNDOCUME order by OID desc
select top 2 * from DGEMPRES22..INNLOTSER order by OID desc
select top 15 * from DGEMPRES22..INNFISICO order by OID desc
select top 10 * from DGEMPRES22..INNAJUINVEC order by OID desc
select top 10 * from DGEMPRES22..INNAJUINVED order by OID desc

select top 2 * from DGEMPRES22..INNLOTSER where INNPRODUC=307
update DGEMPRES22..INNAJUINVED set INNLOTSER=55539 where INNPRODUC=8388
update DGEMPRES22..INNLOTSER set INNPRODUC=8388 where INNPRODUC=307
-----------------------------------------------------------------------------------------------------------------