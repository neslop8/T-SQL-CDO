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
,ter.TERPRIAPE as Apellido1, ter.TERSEGAPE as Apellido2, ter.TERPRINOM as Nombre1, ter.TERSEGNOM as Nombre2
, ltrim(rtrim(terd.TERDIRECCION)) as Dirección, ltrim(rtrim(tert.TERTELEFONO)) as Telefono
, mun.MUNNOMMUN as Municipio, ltrim(rtrim(web.TERDIRECCW))
from dgempres21..GENTERCER ter inner join dgempres21..GENTERCERD terd on ter.GENTERCERD=terd.OID
left join dgempres21..GENTERCERT tert on ter.GENTERCERT=tert.OID
left join dgempres21..GENMUNICI mun on ter.DGNMUNICIPIO=mun.oid
left join dgempres21..GENTERCERW web on web.GENTERCER=ter.OID
where ter.TERTIPDOC = @TIPO and ter.ternumdoc in ('52744079')
order by ter.tertipdoc
--------------------------------------------------------------------------------------------------------------------