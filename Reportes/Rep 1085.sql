sp_who3 lock
sp_who 

select top 5 * from GENUSUARIO where USUNOMBRE='MaVelasquez'-----194
select top 5 * from GENDOCUME where GENUSUARIO=194
select top 5 * from XPObjectType
select * from GENDOCUME where BDOIDTYPE=658 and BDOIDDOCU=8629860
-------------------------------------------------------------------------------------------------------------------
declare @usuario      char(20) = ''----User 67
-------------------------------------------------------------------------------------------------------------------
select usu.USUNOMBRE usuario, xpo.TypeName tipo, doc.BDOIDDOCU oid 
from DGEMPRES21..GENDOCUME doc inner join DGEMPRES21..GENUSUARIO usu on doc.GENUSUARIO=usu.OID
inner join DGEMPRES21..XPObjectType xpo on doc.BDOIDTYPE=xpo.OID
WHERE (usu.USUNOMBRE = @usuario or @usuario = '')
order by usu.USUNOMBRE
-------------------------------------------------------------------------------------------------------------------

select top 5 * from CDO02_21..rep_consulta where query like '%USUNOMBRE%'