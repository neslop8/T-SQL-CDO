select pac.PACNUMDOC identificacion, ing.AINCONSEC ingreso, fac.SFANUMFAC factura, convert(bigint, SFATOTFAC) val_fac
, RTRIM(pac.pacprinom)+' '+RTRIM(pac.pacsegnom)+' '+RTRIM(pac.pacpriape)+' '+RTRIM(pac.pacsegape) paciente
, ing.AINFECING fecha_ingres, ord.SOSORDSER orden, ord.SOSDESORD obser_orden, ord. SOSFECORD fecha_orden
, com.TCCODIGO cod_com, com.TCNOMBRE nom_com, cniif.COMFCONSEC comprobante
, cta.CUCCODIGO cod_cta, cta.CUCNOMBRE cuenta, CONVERT(char, dniif.CFDVALCRE) valor
from DGEMPRES21..SLNORDSER ord inner join DGEMPRES21..IFNCFC2016 cniif on ord.IFNTIPCOM1=cniif.IFNTIPCOM and ord.IFMNUMCOM1=cniif.COMFCONSEC
inner join DGEMPRES21..ADNINGRESO ing on ord.ADNINGRES1=ing.OID
inner join DGEMPRES21..GENPACIEN pac on ing.GENPACIEN=pac.OID
inner join DGEMPRES21..IFNTIPCOM com on ord.IFNTIPCOM1=com.OID and cniif.IFNTIPCOM=com.OID
inner join DGEMPRES21..IFNCFD2016 dniif on dniif.IFNCOMFIN=cniif.OID
inner join DGEMPRES21..IFNCUENTA cta on dniif.IFNCUENTA=cta.OID and CFDVALCRE > 0
left join DGEMPRES21..SLNFACTUR fac on fac.ADNINGRESO=ing.OID and fac.SFADOCANU=0
where --ord.SOSORDSER=@orden and ing.OID in (1471308) 
ord.SOSFECORD >= '2016-01-12 00:00:00'
and ord.SOSFECORD <= '2016-31-12 23:59:59'
and SOSESTADO <> 2