use DGEMPRES02
select top 5 * from INNFISICO
select top 5 * from INNLOTSER
select top 5 * from INNPRODUC
select top 5 * from INNALMACE

select pro.IPRCODIGO Codigo, pro.IPRDESCOR Producto, lot.ilscodigo Lote, fis.IFICANTID Cantidad, alm.IALCODIGO
from DGEMPRES01..INNFISICO fis inner join INNLOTSER lot on fis.INNLOTSER=lot.OID and fis.INNPRODUC=lot.INNPRODUC
inner join INNPRODUC pro on fis.INNPRODUC=pro.OID and lot.INNPRODUC=pro.OID
inner join INNALMACE alm on fis.INNALMACE=alm.OID
where fis.IFICANTID > 0 and lot.ILSFECVEN < GETDATE()
order by fis.IFICANTID desc


select pro.IPRCODIGO Codigo, pro.IPRDESCOR Producto, lot.ilscodigo Lote, fis.IFICANTID Cantidad, alm.IALCODIGO
from DGEMPRES01..INNFISICO fis inner join INNLOTSER lot on fis.INNLOTSER=lot.OID and fis.INNPRODUC=lot.INNPRODUC
inner join INNPRODUC pro on fis.INNPRODUC=pro.OID and lot.INNPRODUC=pro.OID
inner join INNALMACE alm on fis.INNALMACE=alm.OID
where fis.IFICANTID = 0 and lot.ILSFECVEN > GETDATE()
order by fis.IFICANTID desc