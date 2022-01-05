--------------------------------------------------------------------------------------------------------------------
declare @fch_inicio   datetime = '2018-02-01 00:00:00'
declare @fch_fin      datetime = '2018-03-01 23:59:59'
--------------------------------------------------------------------------------------------------------------------
select coalesce (c.IPRCODIGO, g.aprcodigo) codigo, coalesce (c.IPRDESCOR, g.aprnombre, b.imodetalle) nombre
,  convert(VARCHAR, e.IDFECDOC, 103) fecha_orden_1, convert(bigint, coalesce (b.IDDCANTID, f.iddcantid)) cantidad
, convert(bigint, coalesce (b.IMOVALUNP, f.imovaluni)) Val_Unit, d.GPRNOMBRE Proveedor
, convert(bigint, coalesce (b.IMOPORIVA, f.imoporiva)) Iva_Prod
, e.idconsec consecutivo, case e.idestado when 0 then 'REGISTRADA' when 1 then 'CONFIRMADA' when 2 then 'ANULADA' end estado
, a.ICODETALL Detalle, convert(bigint, a.ICOVALDEP) Tot_Desc, case a.icocladoc when 0 then 'O_Com' when 2 then 'O_Ser' else 'OTRO' end tipo
, case a.ICOESTPRO when 0 then 'SIN_MOV' when 1 then 'PARCIAL' else 'TOTAL' end movimiento
, coalesce (c.IPRCODALT, g.aprcodigo) alterno, convert(bigint, coalesce (b.IMOPORDES, f.imopordes)) Desc_Prod, d.GPRCODIGO Nit
, d.GPRDIRECC Direc_Prov, d.GPRTELEFO1 Tel_Prov, alm.IALCODIGO Cod_Alm, alm.IALNOMBRE Almacen
, convert(bigint, a.ICOVALTOP) Neto, convert(bigint, a.ICOVALIMP) Tot_Imp
from DGEMPRES21..INNCORDEN a left join DGEMPRES21..INNMORDEN b on a.OID=b.INNCORDEN
inner join DGEMPRES21..GENTERCERP d   on d.OID=a.genprovee
inner join DGEMPRES21..INNDOCUME e    on e.OID=a.OID
inner join DGEMPRES21..INNALMACE alm  on a.INNALMACE=alm.OID
left join DGEMPRES21..INNPRODUC c     on c.OID=b.INNPRODUC
left join DGEMPRES21..INNMORDACTNET f on a.OID=f.INNCORDEN
left join DGEMPRES21..AFNPRODUC g     on f.AFNPRODUC=g.OID
where e.IDFECDOC >= @fch_inicio and e.IDFECDOC<= @fch_fin
order by 1 desc
--------------------------------------------------------------------------------------------------------------------
/*select top 5 * from CDO02_21..rep_consulta where id=82

update CDO02_21..rep_consulta set query='
select coalesce (c.IPRCODIGO, g.aprcodigo) codigo, coalesce (c.IPRDESCOR, g.aprnombre, b.imodetalle) nombre
,  substring(convert(VARCHAR, e.IDFECDOC), 1, 12) fecha_orden, convert(bigint, coalesce (b.IDDCANTID, f.iddcantid)) cantidad
, convert(bigint, coalesce (b.IMOVALUNP, f.imovaluni)) Val_Unit, d.GPRNOMBRE Proveedor
, convert(bigint, coalesce (b.IMOPORIVA, f.imoporiva)) Iva_Prod
, e.idconsec consecutivo, case e.idestado when 0 then ''REGISTRADA'' when 1 then ''CONFIRMADA'' when 2 then ''ANULADA'' end estado
, a.ICODETALL Detalle, convert(bigint, a.ICOVALDEP) Tot_Desc, case a.icocladoc when 0 then ''O_Com'' when 2 then ''O_Ser'' else ''OTRO'' end tipo
, case a.ICOESTPRO when 0 then ''SIN_MOV'' when 1 then ''PARCIAL'' else ''TOTAL'' end movimiento
, coalesce (c.IPRCODALT, g.aprcodigo) alterno, convert(bigint, coalesce (b.IMOPORDES, f.imopordes)) Desc_Prod, d.GPRCODIGO Nit
, d.GPRDIRECC Direc_Prov, d.GPRTELEFO1 Tel_Prov, alm.IALCODIGO Cod_Alm, alm.IALNOMBRE Almacen
, convert(bigint, a.ICOVALTOP) Neto, convert(bigint, a.ICOVALIMP) Tot_Imp
from DGEMPRES21..INNCORDEN a left join DGEMPRES21..INNMORDEN b on a.OID=b.INNCORDEN
inner join DGEMPRES21..GENTERCERP d   on d.OID=a.genprovee
inner join DGEMPRES21..INNDOCUME e    on e.OID=a.OID
inner join DGEMPRES21..INNALMACE alm  on a.INNALMACE=alm.OID
left join DGEMPRES21..INNPRODUC c     on c.OID=b.INNPRODUC
left join DGEMPRES21..INNMORDACTNET f on a.OID=f.INNCORDEN
left join DGEMPRES21..AFNPRODUC g     on f.AFNPRODUC=g.OID
where e.IDFECDOC >= @fch_inicio and e.IDFECDOC<= @fch_fin
order by 1 desc' where id=82*/
--------------------------------------------------------------------------------------------------------------------
