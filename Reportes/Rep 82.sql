--------------------------------------------------------------------------------------------------------------------
declare @fch_inicio   datetime = '2018-02-01 00:00:00'
declare @fch_fin      datetime = '2018-03-01 23:59:59'
--------------------------------------------------------------------------------------------------------------------
select e.idconsec,  substring(convert(VARCHAR, e.IDFECDOC), 1, 12) fecha_orden 
, case a.icocladoc when 0 then 'O_Com' when 2 then 'O_Ser' else 'OTRO' end tipo
, case a.ICOESTPRO when 0 then 'SIN_MOV' when 1 then 'PARCIAL' else 'TOTAL' end movimiento
, coalesce (c.IPRCODIGO, g.aprcodigo)as codigo, coalesce (c.IPRCODALT, g.aprcodigo)
, coalesce (c.IPRDESCOR, g.aprnombre, b.imodetalle) as nombre
, convert(bigint, coalesce (b.IDDCANTID, f.iddcantid)) as cantidad
, convert(bigint, coalesce (b.IMOVALUNP, f.imovaluni)) as Val_Unit
, convert(bigint, coalesce (b.IMOPORDES, f.imopordes)) as Desc_Prod
, convert(bigint, coalesce (b.IMOPORIVA, f.imoporiva)) as Iva_Prod
, d.GPRCODIGO as Nit, d.GPRNOMBRE as Proveedor, d.GPRDIRECC as Direc_Prov, d.GPRTELEFO1 as Tel_Prov
, case e.idestado when 0 then 'REGISTRADA' when 1 then 'CONFIRMADA' when 2 then 'ANULADA' end
, a.ICODETALL as Detalle, alm.IALCODIGO Cod_Alm, alm.IALNOMBRE Almacen
, convert(bigint, a.ICOVALTOP) as Neto, convert(bigint, a.ICOVALDEP) as Tot_Desc
, convert(bigint, a.ICOVALIMP) as Tot_Imp
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