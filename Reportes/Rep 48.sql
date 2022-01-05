----------------------------------------------------------------------------------------------------------------------------
declare @fch_inicio datetime = '2018-01-08 00:00:00'
declare @fch_fin    datetime = '2018-31-08 23:59:59'
declare @almacen    char(20) = ''
declare @producto   char(20) = ''
----------------------------------------------------------------------------------------------------------------------------
select prod.iprcodigo codigo, prod.IPRDESCOR producto, doc.IDCONSEC comprobante, convert(date, doc.IDFECDOC) fec_doc
, case(iprclapro) when 0 then 'Producto' when 1 then 'Servicio' else 'Otro' end clase 
, case(iprtippro) when 1 then 'Suministro' when 2 then 'Medicamento' else 'Otro' end tipo
, convert(int, ment.IDDCANTID) cantidad, lot.ILSCODIGO lote, convert(date, lot.ILSFECVEN) fec_ven
, convert(bigint, ment.IMCVALUNI) val_unit, alm.IALCODIGO cod_alm, alm.IALNOMBRE almacen
, prov.GPRCODIGO nit, prov.GPRNOMBRE proveedor, cent.ICCFACPRO factura, convert(date, cent.ICCFECFAC) fecha_fac
, prod.IPRCUM cum, prod.IPRCODSICE SICE, prod.IPRREGSAN Reg_San, cent.ICCDETALL detalle
, convert(bigint,cent.ICCVALNEP) val_neto, docord.IDCONSEC orden_compra
, usuc.USUNOMBRE usu_crea, usuc.USUDESCRI usuario_crea, usuf.USUNOMBRE usu_confir, usuf.USUDESCRI usu_confirma
, case(prod.IPRCLSRIEPRO) when 1 then 'Clase I' when 2 then 'Clase IIa' when 3 then 'Clase IIb' 
                         when 4 then 'Clase III' else 'Otro' end Clasificacion
, prod.IPRFECVENR fecha_ven_reg, prod.IPRFECVENR fecha_ven_reg, uni.IUNCODIGO, uni.IUNUNICOM
from dgempres21..INNCCOMPR cent inner join dgempres21..INNMCOMPR ment on ment.INNCCOMPR=cent.OID
inner join dgempres21..INNPRODUC prod  on ment.INNPRODUC=prod.OID
inner join dgempres21..INNALMACE alm   on cent.INNALMACE=alm.OID
inner join dgempres21..GENTERCERP prov on cent.GENTERCERP=prov.OID
inner join dgempres21..INNDOCUME doc   on cent.OID=doc.OID and doc.IDESTADO = 1
inner join dgempres21..GENUSUARIO usuc on doc.GENUSUARIO2=usuc.OID
inner join dgempres21..GENUSUARIO usuf on doc.GENUSUARIO3=usuf.OID
left join dgempres21..INNLOTSER lot    on ment.INNLOTSER=lot.OID
left join dgempres21..INNMORDEN mord   on ment.INNMORDEN=mord.OID
left join dgempres21..INNCORDEN cord   on mord.INNCORDEN=cord.OID
left join dgempres21..INNDOCUME docord on docord.OID=cord.OID
left join dgempres21..INNUNIDAD uni    on prod.IUNCODIGO=uni.OID
where --prod.IPRFECVENR < GETDATE () and
cent.ICCFECFAC >= @fch_inicio
and cent.ICCFECFAC <= @fch_fin
and (alm.IALCODIGO = @almacen or @almacen='')
and (prod.iprcodigo = @producto or @producto='')
order by doc.OID, prod.OID
----------------------------------------------------------------------------------------------------------------------------