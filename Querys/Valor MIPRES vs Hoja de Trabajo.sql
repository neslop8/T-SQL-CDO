use CDO02_21
select top 5 * from CDO02_21..asi_ingreso_prescripcion
select ValorEntregado, * from CDO02_21..asi_precripcion_reporte_entrega order by ID

select pac.PACNUMDOC, aip.identificacion, aip.prescripcion
from DGEMPRES01..ADNINGRESO ing inner join DGEMPRES01..GENPACIEN pac ON ing.GENPACIEN=pac.OID
inner join CDO02_21..asi_ingreso_prescripcion aip ON aip.ingreso=ing.OID
where ing.AINESTADO=0 and ing.AINTIPING=2 order by 3

select pac.PACNUMDOC, ing.AINCONSEC, aip.identificacion, apre.ValorEntregado, pro.IPRCODIGO
from DGEMPRES01..ADNINGRESO ing inner join DGEMPRES01..GENPACIEN pac ON ing.GENPACIEN=pac.OID
inner join CDO02_21..asi_ingreso_prescripcion aip ON aip.ingreso=ing.OID
inner join CDO02_21..asi_precripcion_reporte_entrega apre ON aip.prescripcion=apre.NoPrescripcion
inner join dgempres01..INNPRODUC pro ON apre.CodTecEntregado collate Modern_Spanish_CI_AS = pro.IPRCUM
where ing.AINESTADO=0 and ing.AINTIPING=2

select top 5 iprcum, * from dgempres01..INNPRODUC

select ValorEntregado, CodTecEntregado, * from CDO02_21..asi_precripcion_reporte_entrega where NoPrescripcion in (
select aip.prescripcion
from DGEMPRES01..ADNINGRESO ing inner join DGEMPRES01..GENPACIEN pac ON ing.GENPACIEN=pac.OID
inner join CDO02_21..asi_ingreso_prescripcion aip ON aip.ingreso=ing.OID
where ing.AINESTADO=0 and ing.AINTIPING=2)

select pac.PACNUMDOC, ing.AINCONSEC, aip.identificacion, (apre.ValorEntregado / apre.CantTotentregada)
, ser.SERVALPRO, pro.IPRCODIGO, aip.prescripcion
from DGEMPRES01..ADNINGRESO ing inner join DGEMPRES01..GENPACIEN pac ON ing.GENPACIEN=pac.OID
inner join CDO02_21..asi_ingreso_prescripcion aip ON aip.ingreso=ing.OID
inner join CDO02_21..asi_precripcion_reporte_entrega apre ON aip.prescripcion=apre.NoPrescripcion
inner join dgempres01..INNPRODUC pro ON apre.CodTecEntregado collate Modern_Spanish_CI_AS = pro.IPRCUM
inner join dgempres01..SLNSERPRO ser ON ser.adningres1=ing.oid
inner join dgempres01..SLNPROHOJ hoj ON ser.OID=hoj.OID and hoj.INNPRODUC1=pro.OID
where ing.AINESTADO=0 and ing.AINTIPING=2 
and (apre.ValorEntregado / apre.CantTotentregada) <> ser.SERVALPRO

select pac.PACNUMDOC Identificacion, ing.AINCONSEC Ingreso, (apre.ValorEntregado / apre.CantTotentregada) ValorEntregado
, ser.SERVALPRO Hoja_Trabajo, pro.IPRCODIGO Codigo, pro.IPRDESCOR Producto, aip.prescripcion
from DGEMPRES01..ADNINGRESO ing inner join DGEMPRES01..GENPACIEN pac ON ing.GENPACIEN=pac.OID
inner join CDO02_21..asi_ingreso_prescripcion aip ON aip.ingreso=ing.OID
inner join CDO02_21..asi_precripcion_reporte_entrega apre ON aip.prescripcion=apre.NoPrescripcion
inner join dgempres01..INNPRODUC pro ON apre.CodTecEntregado collate Modern_Spanish_CI_AS = pro.IPRCUM
inner join dgempres01..SLNSERPRO ser ON ser.adningres1=ing.oid
inner join dgempres01..SLNPROHOJ hoj ON ser.OID=hoj.OID and hoj.INNPRODUC1=pro.OID
where ing.AINFECING>= '20210701'
and (apre.ValorEntregado / apre.CantTotentregada) <> ser.SERVALPRO