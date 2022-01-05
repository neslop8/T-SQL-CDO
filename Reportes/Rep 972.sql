select fac.SFANUMFAC Factura, pac.PACNUMDOC Identificacion, ing.AINCONSEC Ingreso
, RTRIM(pac.pacprinom)+' '+RTRIM(pac.pacsegnom)+' '+RTRIM(pac.pacpriape)+' '+RTRIM(pac.pacsegape) as paciente
, ord.SOSORDSER Orden, fac.sfafecfac fecha_fac,  coalesce (cons.gcfcodigo, conp.gcfcodigo) cod_concepto
, coalesce (cons.gcfnombre, conp.gcfnombre) concepto
, case(ser.SERAPLPRO) when 0 then 'NO' when 1 then 'SI' end aplica
, CONVERT(bigint, ser.SERCANTID) as Cantidad, convert(bigint, ser.SERVALENT)Val_ent, convert(bigint, ser.SERVALPAC)Val_pac
, coalesce (CONVERT(bigint, paq.SPHVALSER), CONVERT(bigint, ser.SERVALPRO)) Valor_Manual
, CONVERT(bigint, (ser.SERVALENT + ser.SERVALPAC)) Valor_Cobrado
, CONVERT(bigint, (ser.SERCANTID * coalesce (paq.SPHVALSER, (ser.SERVALENT + ser.SERVALPAC)))) Total
, cxcc.CCVALOR tot_fac, cxcc.CCVALDEB debitos, cxcc.CCVALCRE creditos, cxcc.CCSALDO saldo
, det.GDECODIGO Cod_Con, det.GDENOMBRE Plan_Beneficios
, coalesce (aresp.gascodigo, ares.gascodigo) Area_Solicita, arep.GASCODIGO Area_Presta
, coalesce (ips.SIPCODIGO, prod.IPRCODIGO) codigo_principal
, coalesce (ips.SIPNOMBRE, prod.IPRDESCOR) nombre
, ips1.SIPCODIGO sub_codigo, CONVERT(bigint, paq.SPHVALSER) val_sub
, case(ips1.SIPCLASER) when 1 then 'NINGUNO' when 2 then 'CIRUJANO' when 3 then 'ANESTESIOLOGO' when 4 then 'AYUDANTE' 
                       when 5 then 'SALA' when 6 then 'MATERIAL' when 7 then 'INSTRUMENTACION' else 'OTRO' END CLASE
, coalesce (med1.gmecodigo, med.gmecodigo) cod_med, coalesce (med1.gmenomcom, med.gmenomcom) medico
, case fac.sfadocanu when 0 then 'ACTIVA' when 1 then 'ANULADA' end Estado, usu.USUNOMBRE usu_crea_orden
, esp2.GEEDESCRI especialidad
, Cod_Cama_Presta_Servicio = CASE WHEN (cam1.HCACODIGO IS NULL) THEN '' ELSE cam1.HCACODIGO END
, Cama_Presta_Servicio = CASE WHEN (cam1.HCANOMBRE IS NULL) THEN '' ELSE cam1.HCANOMBRE END 
, Clase_Ingreso = CASE WHEN (ing.AINTIPING=1) THEN 'AMBULATORIO' ELSE CASE WHEN (ing.AINTIPING=2) THEN 'HOSPITALARIO' ELSE '' END END 
, Area_Serv_Cama = case when (arec.GASNOMBRE IS NULL) THEN '' ELSE arec.GASNOMBRE END 
--, coalesce (aresp.gascodigo, ares.GASNOMBRE) Area_Serv_Solicita, arep.GASNOMBRE Area_Serv_Presta
from DGEMPRES21..SLNSERPRO ser inner join dgempres21..ADNINGRESO ing on ser.ADNINGRES1=ing.OID
inner join DGEMPRES21..SLNFACTUR fac	on fac.ADNINGRESO=ing.OID
inner join DGEMPRES21..CRNCXC cxc	    on fac.CRNCXC1=cxc.OID
inner join DGEMPRES21..CRNCXCC cxcc	    on cxcc.CRNCXC=cxc.OID
inner join DGEMPRES21..GENPACIEN pac	on ing.GENPACIEN=pac.OID
inner join DGEMPRES21..SLNORDSER ord	on ser.SLNORDSER1=ord.OID and ord.sosestado<>2
inner join dgempres21..GENARESER arep	on ser.GENARESER1=arep.OID
inner join dgempres21..GENMEDICO med	on ser.GENMEDICO1=med.OID
inner join dgempres21..GENUSUARIO usu	on ord.GENUSUARIO1=usu.OID
inner join dgempres21..GENARESER ares	on ord.GENARESER1=ares.OID
left join DGEMPRES21..SLNSERHOJ hoj		on ser.OID=hoj.OID
left join DGEMPRES21..SLNPROHOJ pro		on ser.OID=pro.OID
left join DGEMPRES21..INNPRODUC prod	on pro.INNPRODUC1=prod.OID
left join DGEMPRES21..GENSERIPS ips		on hoj.GENSERIPS1=ips.OID
left join DGEMPRES21..GENCONFAC cons	on ips.genconfac1=cons.OID
left join DGEMPRES21..GENCONFAC conp	on prod.genconfac=conp.OID
left join dgempres21..INNCSUMPA csum    on pro.INNCSUMPA1 = csum.OID
left join dgempres21..GENARESER aresp   on csum.GENARESER1 = aresp.OID
left join DGEMPRES21..GENDETCON det		on ser.GENDETCON1=det.OID 
left join DGEMPRES21..SLNPAQHOJ paq		on paq.SLNSERHOJ1=hoj.OID and paq.SLNSERPRO1=ser.OID
left join DGEMPRES21..GENPAQUET pdet	on paq.GENPAQUET1=pdet.OID
left join DGEMPRES21..GENSERIPS ips1	on pdet.GENSERIPS2=ips1.OID
left join dgempres21..GENMEDICO med1	on paq.GENMEDICO1=med1.OID
left join dgempres21..GENESPMED esp1	on esp1.MEDICOS=med.OID and GEMPRINCIPAL=1
left join dgempres21..GENESPECI esp2	on esp1.ESPECIALIDADES=esp2.OID
left join dgempres21..HPNESTANC est     on hoj.HPNESTANC1 = est.OID
left join dgempres21..HPNDEFCAM cam1    on est.HPNDEFCAM = cam1.OID
left join dgempres21..HPNSUBGRU subg    on cam1.HPNSUBGRU = subg.OID
left join dgempres21..GENARESER arec    on arec.OID = subg.GENARESER
where fac.SFANUMFAC='FV000003812124'
order by fac.SFANUMFAC, ser.OID