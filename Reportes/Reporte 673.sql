--------------------------------------------------------------------------------------------------------------------------------
declare @fch_inicio datetime = '20190101'
declare @fch_fin datetime = '20190717'
declare @proveedor char(20) = ''
--------------------------------------------------------------------------------------------------------------------------------
select doc.IDCONSEC consecutivo, convert(varchar, doc.IDFECCRE, 107) fecha, usu.USUNOMBRE usu_Crea, alm.IALCODIGO almacen
, prov.GPRCODIGO nit, prov.GPRNOMBRE, prod.IPRCODIGO cod_prod, prod.IPRDESCOR producto, convert(bigint, mren.IMRVALUNI) Valor
, mren.IDDCANTID Cant, mren.IMRCANPEN Cant_pend, lot.ILSCODIGO lote, convert(varchar, lot.ILSFECVEN, 107) Vencimiento
from DGEMPRES21..INNDOCUME doc inner join DGEMPRES21..INNCREMEN cren on doc.OID=cren.OID
inner join DGEMPRES21..GENUSUARIO usu  on doc.GENUSUARIO2=usu.OID
inner join DGEMPRES21..INNMREMEN mren  on mren.INNCREMEN=cren.OID
inner join DGEMPRES21..INNPRODUC prod  on mren.INNPRODUC=prod.OID
inner join DGEMPRES21..GENTERCERP prov on cren.GENPROVEE=prov.OID
inner join DGEMPRES21..INNALMACE alm   on cren.INNALMACE=alm.OID
left join DGEMPRES21..INNLOTSER lot    on mren.INNLOTSER=lot.OID
where doc.IDTIPDOC=1 and doc.IDESTADO=1 and mren.IMRCANPEN > 0
and doc.IDFECCRE >= @fch_inicio
and doc.IDFECCRE <= @fch_fin
and (prov.GPRCODIGO = @proveedor or @proveedor='')
order by 6 desc
--------------------------------------------------------------------------------------------------------------------------------