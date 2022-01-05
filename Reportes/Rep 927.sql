------------------------------------------------------------------------------------------------------------------------------
declare @fch_inicio datetime = '2016-17-11 00:00:00' 
declare @fch_fin    datetime = '2016-17-11 23:59:59' 
------------------------------------------------------------------------------------------------------------------------------
select csol.CSCCONSEC consecutivo, csol.CSCFECDOC fecha
, case(csol.CSCESTADO) when 0 then 'Registrado' when 1 then 'Confirmado' when 2 then 'Anulado' else 'Rechazado' end estado
, case(csol.CSCTIPSOL) when 0 then 'Dependencia' when 1 then 'Almacen' when 2 then 'Area' else 'otro' end tipo
, coalesce(dep.gdpnombre, alms.ialnombre) solicita, almd.ialnombre despacha
, pro.IPRCODIGO cod_pro, pro.IPRDESCOR producto, dsol.CSDCANTID cantidad
from dgempres21..CPNSOLICIC csol inner join dgempres21..CPNSOLICID dsol on dsol.CPNSOLICIC=csol.OID
inner join dgempres21..INNPRODUC pro on dsol.INNPRODUC=pro.OID
inner join dgempres21..INNALMACE almd on csol.INNALMACE=almd.OID
left join dgempres21..GENDEPEND dep on csol.GENDEPEND=dep.OID
left join dgempres21..INNALMACE alms on csol.INNALMACE1=alms.OID
where csol.CSCFECDOC >= @fch_inicio
and   csol.CSCFECDOC <= @fch_fin
------------------------------------------------------------------------------------------------------------------------------
select top 5 * from CPNSOLICIC
select top 5 * from CPNSOLICID
------------------------------------------------------------------------------------------------------------------------------