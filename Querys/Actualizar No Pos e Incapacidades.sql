use DGEMPRES21
select * from SLNFACTUR where SFAFECFAC > ('2016-12-07 00:25:00')
------------------------------------------------------------------------------------------------------------------No Pos
select fol.ADNINGRESO, *
from DGEMPRES21..HCNMEDPAC med inner join DGEMPRES21..HCNJMNPOS jus on med.HCNJMNPOS=jus.OID
inner join DGEMPRES21..HCNFOLIO fol on med.HCNFOLIO=fol.oid
inner join DGEMPRES21..ADNINGRESO ing on fol.adningreso=ing.oid
where ing.aintiping=2 and fol.ADNINGRESO in (select ADNINGRESO from SLNFACTUR where SFAFECFAC > ('2016-12-07 00:00:00'))
------------------------------------------------------------------------------------------------------------------Incapacidad
select fol.ADNINGRESO, *
from DGEMPRES21..HCNINCAPA inc inner join DGEMPRES21..HCNFOLIO fol on inc.HCNFOLIO=fol.oid
inner join DGEMPRES21..ADNINGRESO ing on fol.adningreso=ing.oid
where ing.aintiping=2 and fol.ADNINGRESO in (select ADNINGRESO from SLNFACTUR where SFAFECFAC > ('2016-12-07 00:00:00'))
------------------------------------------------------------------------------------------------------------------}
select * from SLNFACTUR where ADNINGRESO in (1593401)
select * from ADNINGRESO where oid in (1594567)
select genpacien, adningreso, HCEJUSTIF, HCEACTDEF, * from HCNEPICRI where ADNINGRESO in (1593510,1595602,1596088,1596119)
select genpacien, adningreso, * from HCNINCAPA where ADNINGRESO in (1593401)
------------------------------------------------------------------------------------------------------------------
update SLNFACTUR set SFATIPDOC=1 where ADNINGRESO in (1593401)
------------------------------------------------------------------------------------------------------------------