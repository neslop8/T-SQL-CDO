use DGEMPRES21
select top 5 * from INNCFACTU order by OID desc
select top 5 * from CRNCXC order by OID desc
select top 5 * from GENFACELE order by OID desc
select top 5 * from INNCPEDID order by OID desc
select top 5 * from GENTERCERC order by OID desc
select top 5 * from INNMPEDID order by OID desc
select top 5 * from INNDOCUME order by OID desc
select top 5 * from GENUSUARIO order by OID desc
---------------------------------------------------------------------------------------------------------------------------
declare @fch_inicio datetime = '2018-01-11 23:00:00'
declare @fch_fin    datetime = '2018-30-11 23:59:59'
declare @usuario    char(20) = 'NECASTRO'
---------------------------------------------------------------------------------------------------------------------------
select doc.IDCONSEC pedido, convert(varchar, doc.IDFECDOC,106) fec_doc, elec.GEFNUMFAC factura, fac.IFAFACELE Fac_Elec
, cli.CLICODIGO identificación, cli.CLINOMBRE cliente, usu.USUNOMBRE usuario
, case(elec.GEFESTADO) when 0 then 'Registrada' when 1 then 'Aceptada' when 2 then 'Rechazada' when 3 then 'Pendiente'
                       when 4 then 'Valida'     when 5 then 'Invalida' else 'Otro' end Estado_DIAN
from DGEMPRES21..INNCFACTU fac inner join DGEMPRES21..INNCPEDID ped on fac.INNCPEDID=ped.OID
inner join DGEMPRES21..GENTERCERC cli  on ped.GENTERCERC=cli.OID
inner join DGEMPRES21..GENFACELE  elec on elec.INNCPEDID=ped.OID
inner join DGEMPRES21..INNDOCUME  doc  on ped.OID=doc.OID
inner join DGEMPRES21..GENUSUARIO usu  on doc.GENUSUARIO2=usu.OID
where doc.IDFECDOC >= @fch_inicio
and doc.IDFECDOC <= @fch_fin
and (usu.USUNOMBRE=@usuario or @usuario='')
---------------------------------------------------------------------------------------------------------------------------