--------------------------------------------------------------------------------------------------------------------
declare @TIPO int = 1
--------------------------------------------------------------------------------------------------------------------
select ter.TERNUMDOC as identidad, ter.TERDIGITO
, case ter.TERTIPDOC when 1 then 'CC' when 2 then 'CE' when 3 then 'TI' when 4 then 'RC' when 5 then 'PA'
                     when 6 then 'AS' when 7 then 'MS' when 8 then 'RU' when 9 then 'NIT' END as Tip_Doc
, case ter.TERTIPRET when 0 then 'Ninguna' when 1 then 'Excento' 
                     when 2 then 'Hacer' when 3 then 'AutoRetenedor' END as Tip_Ret
, case ter.TERTIPCON when 0 then 'Simplificado' when 1 then 'Comun' 
                     when 2 then 'Gran_Contribuyente' when 3 then 'Empresa_Estatal' END as Tip_Con
,ter.TERPRIAPE as Apellido1,  isnull(ter.TERSEGAPE,'') as Apellido2, ter.TERPRINOM as Nombre1, isnull(ter.TERSEGNOM,'') as Nombre2
, isnull(ltrim(rtrim(terd.TERDIRECCION)),'Sin_Dato') as Dirección, isnull(ltrim(rtrim(tert.TERTELEFONO)), 'SIN_DATO') as Telefono
, mun.MUNNOMMUN as Municipio, isnull(ltrim(rtrim(web.TERDIRECCW)), 'SIN_DATO'), ter.TERCODCIU CIU
from dgempres21..GENTERCER ter inner join dgempres21..GENTERCERD terd on ter.GENTERCERD=terd.OID
left join dgempres21..GENTERCERT tert on ter.GENTERCERT=tert.OID
left join dgempres21..GENMUNICI mun on ter.DGNMUNICIPIO=mun.oid
left join dgempres21..GENTERCERW web on web.GENTERCER=ter.OID
where ter.TERTIPDOC = @TIPO-- and ter.ternumdoc in ('52744079')
order by ter.tertipdoc
--------------------------------------------------------------------------------------------------------------------
select ter.TERNUMDOC as identidad, ter.TERDIGITO
, case ter.TERTIPDOC when 1 then 'CC' when 2 then 'CE' when 3 then 'TI' when 4 then 'RC' when 5 then 'PA'
                     when 6 then 'AS' when 7 then 'MS' when 8 then 'RU' when 9 then 'NIT' END as Tip_Doc
, case ter.TERTIPRET when 0 then 'Ninguna' when 1 then 'Excento' 
                     when 2 then 'Hacer' when 3 then 'AutoRetenedor' END as Tip_Ret
, case ter.TERTIPCON when 0 then 'Simplificado' when 1 then 'Comun' 
                     when 2 then 'Gran_Contribuyente' when 3 then 'Empresa_Estatal' END as Tip_Con
,ter.TERPRIAPE as Apellido1, ter.TERSEGAPE as Apellido2, ter.TERPRINOM as Nombre1, ter.TERSEGNOM as Nombre2
, terd.TERDIRECCION as Dirección, ISNULL(tert.TERTELEFONO, 'Sin Dato') as Telefono, mun.MUNNOMMUN as Municipio
, web.TERDIRECCW, ter.TERCODCIU CIU
from dgempres21..GENTERCER ter inner join dgempres21..GENTERCERD terd on ter.GENTERCERD=terd.OID
left join dgempres21..GENTERCERT tert on ter.GENTERCERT=tert.OID
left join dgempres21..GENMUNICI mun on ter.DGNMUNICIPIO=mun.oid
left join dgempres21..GENTERCERW web on web.GENTERCER=ter.OID
where ter.TERTIPDOC = @TIPO --and ter.TERNUMDOC='52744079'
order by ter.tertipdoc
--------------------------------------------------------------------------------------------------------------------
select top 5 * from gentercer
select top 5 * from gentercert
select top 5 * from gentercerd

update GENTERCERT set TERTELEFONO=LTRIM(RTRIM(TERTELEFONO))

update GENTERCER set TERNUMDOC=replace(TERNUMDOC, char(13),'')---char(9,10,13,39)
update GENTERCER set TERPRINOM=replace(TERPRINOM, char(13),'')
update GENTERCER set TERSEGNOM=replace(TERSEGNOM, char(13),'')
update GENTERCER set TERPRIAPE=replace(TERPRIAPE, char(13),'')
update GENTERCER set TERSEGAPE=replace(TERSEGAPE, char(13),'')

update GENTERCERT set TERTELEFONO=replace(TERTELEFONO, char(9),'')
update GENTERCERT set TERTELEFONO=replace(TERTELEFONO, char(10),'')
update GENTERCERT set TERTELEFONO=replace(TERTELEFONO, char(13),'')
update GENTERCERT set TERTELEFONO=replace(TERTELEFONO, char(39),'')

update GENTERCERD set TERDIRECCION=replace(TERDIRECCION, char(9),'')
update GENTERCERD set TERDIRECCION=replace(TERDIRECCION, char(10),'')
update GENTERCERD set TERDIRECCION=replace(TERDIRECCION, char(13),'')
update GENTERCERD set TERDIRECCION=replace(TERDIRECCION, char(39),'')

sp_who3 lock
sp_who3 128