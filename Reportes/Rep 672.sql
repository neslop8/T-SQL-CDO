--------------------------------------------------------------------------------------------------------------------------------
declare @fch_inicio datetime = '20211124'
declare @fch_fin datetime = '20211126'
--------------------------------------------------------------------------------------------------------------------------------
select cam.hcacodigo cama, pac.PACNUMDOC identificacion, pac.GPANOMCOM paciente
, DATEDIFF(year,pac.gpafecnac,fol.hcfecfol) Años, ing.ainconsec ingreso, tip.HCCODIGO tipo
, fol.hcnumfol folio, fol.hcfecfol fecha, med.gmecodigo cod_med, med.GMENOMCOM medico
, coalesce (c1.hccm08N32, c2.hccm08n32, c3.hccm08n18, cua1.hccm08n41, p2.hccm08n58, cn1.hccm08n29, cn2.hccm08n16, cua2.hccm08n32) Dieta
, coalesce (c1.hccm03n33, c2.hccm03n33, c3.hccm03n19, cua1.hccm03n40, p2.hccm03n59, cn1.hccm03n30, cn2.hccm03n17, cua2.hccm03n33) Observaciones
from DGEMPRES01..HCNFOLIO fol  inner join DGEMPRES01..HCNTIPHIS tip on tip.OID=fol.HCNTIPHIS
inner join DGEMPRES01..GENPACIEN pac on fol.GENPACIEN=pac.OID
inner join DGEMPRES01..ADNINGRESO ing on fol.GENPACIEN=ing.GENPACIEN and fol.ADNINGRESO=ing.OID and ing.aintiping=2
inner join DGEMPRES01..GENMEDICO med on fol.GENMEDICO=med.OID
left join DGEMPRES01..hCMC00001 c1 on fol.OID=c1.HCNFOLIO
left join DGEMPRES01..hCMC00002 c2 on fol.OID=C2.HCNFOLIO
left join DGEMPRES01..hCMC00003 c3 on fol.OID=c3.HCNFOLIO
left join DGEMPRES01..hCMC00UA1 cua1 on fol.OID=cua1.HCNFOLIO
left join DGEMPRES01..HCMP00002 p2 on fol.OID=p2.HCNFOLIO
left join DGEMPRES01..hCMC000N1 cn1 on fol.OID=cn1.HCNFOLIO
left join DGEMPRES01..hCMC000N2 cn2 on fol.OID=cn2.HCNFOLIO
left join DGEMPRES01..HCMP00UA2 cua2 on fol.OID=cua2.HCNFOLIO
left join DGEMPRES01..HPNDEFCAM cam on cam.OID=ing.HPNDEFCAM
where tip.OID in  (3, 19, 20, 21, 33, 37, 38, 42, 43, 66)
AND fol.hcfecfol>= @fch_inicio
and fol.hcfecfol<= @fch_fin 
order by fol.hcfecfol, cam.HPNDEFCAM
--------------------------------------------------------------------------------------------------------------------------------
--where m.HCCODIGO in  ('C00001','C00002','C00003','C000P1','C00UA1','P00002','C000N1','C000N2','C00UA2','P00UA2')
--select * from HCNCAMTHC where HCDESCRIP like '%dieta%'
select * from HCNTIPHIS where HCCODIGO in ('C00001','C00002','C00003','C000P1','C00UA1','P00002','C000N1','C000N2','C00UA2','P00UA2')
--------------------------------------------------------------------------------------------------------------------------------