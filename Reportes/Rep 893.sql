----------------------------------------------------------------------------------------------------------
declare @fch_inicio datetime = '20190701'
declare @fch_fin datetime = '20190715'
declare @producto varchar(20) = ''
declare @orden varchar(20) = ''
----------------------------------------------------------------------------------------------------------
SELECT case(cdes.IODTIPOORDEN) when 0 then 'GENERAL' when 1 then 'CONSUMO' else 'OTRO' end TIPO
	, convert( date, doc.IDFECCRE) fecha_creacion, doc.IDCONSEC Despacho, usu.USUNOMBRE Usuario_Despacha
	, almo.IALCODIGO Cod_Origen, almo.IALNOMBRE Origen
	, coalesce(almd.ialcodigo, are.gascodigo, dep.gdpcodigo) Cod_Destino
	, coalesce(almd.ialnombre, are.gasnombre, dep.gdpnombre) Destino
	, cdes.IODDESCRIP Detalle_Despacho, convert(bigint, mdes.IDDCANTID) cant_desp
	, pro.IPRCODIGO producto, pro.IPRDESCOR nombre_producto, convert(bigint, dsol.CSDCANTID) cant_solc
	, csol.CSCOBSERV Detalle_Solicitud, csol.CSCCONSEC Solicitud
	, convert(bigint, pro.IPRCOSTPE) costo_promediom, convert(bigint, pro.IPRULCOPE) costo_ultimo
FROM DGEMPRES21..INNORDDESC cdes INNER JOIN DGEMPRES21..INNORDDESD mdes ON mdes.INNORDDESC=cdes.OID
	INNER JOIN DGEMPRES21..INNDOCUME  doc  ON cdes.OID=doc.OID AND doc.IDTIPDOC = 17
	INNER JOIN DGEMPRES21..INNALMACE  almo ON cdes.INNALMACE=almo.OID
	INNER JOIN DGEMPRES21..INNPRODUC  pro  ON mdes.INNPRODUC=pro.OID
	INNER JOIN DGEMPRES21..GENUSUARIO usu  ON doc.GENUSUARIO2=usu.OID
	LEFT JOIN DGEMPRES21..INNALMACE  almd  ON cdes.INNALMdes=almd.OID
	LEFT JOIN DGEMPRES21..GENARESER  are   ON cdes.INNAREADES=are.OID
	LEFT JOIN DGEMPRES21..GENDEPEND  dep   ON cdes.GENDEPEND=dep.OID
	LEFT JOIN DGEMPRES21..CPNSOLICID dsol  ON mdes.CPNSOLICID=dsol.OID
	LEFT JOIN DGEMPRES21..CPNSOLICIC csol  ON dsol.CPNSOLICIC=csol.OID
WHERE doc.IDFECCRE >= @fch_inicio 
	and doc.IDFECCRE <= @fch_fin
	and (pro.IPRCODIGO = @producto or @producto='')
	and (doc.IDCONSEC = @orden or @orden='')
	and doc.IDESTADO=1
ORDER BY
	doc.IDFECCRE
----------------------------------------------------------------------------------------------------------