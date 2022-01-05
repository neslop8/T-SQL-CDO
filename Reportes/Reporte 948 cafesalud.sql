------------------------------------------------------------------------------------------------------
--declare @radicado int = 15159
-----------------------------convert(NVARCHAR, fac.SFATOTFAC) VALOR_BRUTO
select
SUBSTRING(cxc.CXCDOCUME, 1, 4) PREF_FACT, SUBSTRING(cxc.CXCDOCUME, 5, 15) NUME_FACT, 'NI' TIPO_DOC_IPS
, '860090566' NUME_DOC_IPS, '110010966601' COD_HAB_IPS, con.GECCODIGO COD_EPS
, case GDEPAQUET when 1 then 2 when 2 then 1 else 3 end COD_CUENTA, '' COD_CONTRATO
, convert(NVARCHAR, cxc.CXCDOCFECHA, 103) FECHA_FACT, convert(NVARCHAR,(fac.SFATOTFAC + fac.SFAVALPAC)) VALOR_BRUTO
, convert(NVARCHAR, facop.SFAVALPAC) VALOR_COPAGO, '0' VALOR_COPAGO_COMPARTIDO
, '0' VALOR_IVA, '0' VALOR_ICO, convert(int, facta.SFAVALPAC) VALOR_MODERADORA, '0' VALOR_DESCUENTO
, convert(NVARCHAR, fac.SFAVALDES) CON_DES, convert(NVARCHAR, fac.SFATOTFAC) VALOR_NETO
, '' PERIODO, '5' COD_REGIONAL
, case ing.AINCAUING when 3 then 1 when 4 then 1 when 10 then 2 when 1 then 3 when 6 then 4 when 7 then 5 else '1' end CLASIFICACION_ORIGEN
, '' TIPO_SERVICIO, '' TIPO_PAQUETE, '' FIN_CONSULTA, '' DIAS_TRAT
, CASE pac.pactipdoc   WHEN '1' THEN 'CC'    WHEN '2' THEN 'CE'    WHEN '3' THEN 'TI'    WHEN '4' THEN 'RC'    
            WHEN '5' THEN 'PA'    WHEN '6' THEN 'AS'    WHEN '7' THEN 'MS'    WHEN '8' THEN 'NU' END TDOC_PACIENTE
, pac.PACNUMDOC NDOC_PACIENTE, RTRIM(LTRIM(pac.PACPRINOM)) NOMB1_PACIENTE, RTRIM(LTRIM(pac.PACSEGNOM)) NOMB2_PACIENTE
, RTRIM(LTRIM(pac.PACPRIAPE)) APELLIDO1_PACIENTE, RTRIM(LTRIM(pac.PACSEGAPE)) APELLIDO2_PACIENTE
, ROUND((CONVERT (INT, GETDATE()) - CONVERT(INT, pac.gpafecnac)) / 365, 0) EDAD_PACIENTE
, CASE pac.gpasexpac WHEN '1' THEN 'M' ELSE 'F' END SEXO_PACIENTE 
, CASE pac.gpaestado WHEN '2' THEN '0' ELSE '1' END ESTADO_PACIENTE  
, 'N' DISCAPACIDAD, case SERMEDICA when 0 then 'P' else 'M' END TIPO_PRESTACION
, coalesce (ips.SIPCODIGO, prod.IPRCODIGO) CODIGO_DE_FACTURACION_PRINCIPAL
, ips1.SIPCODIGO CODIGO_PROCEDIMIENTO_DETALLE
, coalesce (ips1.SIPNOMBRE, ips.SIPNOMBRE, prod.IPRDESCOR) DESC_PROCEDIMIENTO
, convert(CHAR, ser.SERFECSER, 103) FECHA_PROCEDIMIENTO
, SUBSTRING(convert(CHAR, ser.SERFECSER, 108), 1, 5) HORA_PROCEDIMIENTO, ser.SERCANTID CANTIDAD_PROCEDIMIENTO
--, coalesce (CONVERT(bigint, paq.SPHVALSER),CONVERT(bigint, ser.servalpro)) comparar
, coalesce (CONVERT(bigint, paq.sphtotent + paq.sphtotpac), CONVERT(bigint, ser.SERVALent + ser.SERVALPAC)) VALOR_UNITARIO
, '0' VALOR_COMPARTIDO_PACIENTE
, '0' VALOR_MODERADORA_PACIENTE,  coalesce (paq.sphtotpac, ser.SERVALPAC) VALOR_COPAGO_PACIENTE
--, (ser.SERCANTID * (coalesce (CONVERT(bigint, paq.SPHVALSER),CONVERT(bigint, ser.servalpro)))) comparar2
, (ser.SERCANTID * (coalesce (CONVERT(bigint, paq.sphtotent + paq.sphtotpac), CONVERT(bigint, ser.SERVALent + ser.SERVALPAC)))) VALOR_TOTAL_SERVICIO
, '0' COD_AUTORIZACION, RTRIM(LTRIM(dx_e.dg)) DIAGNOSTICO_PRINCIPAL, '' TIPO_DIAG
--, ser.SERNUMAUT COD_AUTORIZACION, dx_e.dg DIAGNOSTICO_PRINCIPAL, '' TIPO_DIAG
, '' DIAGNOSTICO_SECUNDARIO_1, '' DIAGNOSTICO_SECUNDARIO_2
, convert(CHAR, ing.AINFECING, 103) FECHA_ENTRADA
, SUBSTRING(convert(CHAR, ing.AINFECING, 108), 1, 5) HORA_ENTRADA
, convert(CHAR, egr.ADEFECSAL, 103) FECHA_SALIDA
, SUBSTRING(convert(CHAR, egr.ADEFECSAL, 108), 1, 5) HORA_SALIDA
from DGEMPRES21..CRNDOCUME doc inner join DGEMPRES21..CRNRADFACD drad on drad.CRNRADFACC=doc.OID
inner join DGEMPRES21..CRNCXC     cxc on drad.CRNCXC=cxc.OID
inner join DGEMPRES21..SLNFACTUR  fac on fac.CRNCXC1=cxc.OID
inner join DGEMPRES21..ADNINGRESO ing on fac.ADNINGRESO=ing.OID
inner join DGEMPRES21..ADNEGRESO  egr on egr.ADNINGRESO=ing.OID
inner join DGEMPRES21..GENPACIEN  pac on ing.GENPACIEN=pac.OID
inner join DGEMPRES21..GENDETCON  det on cxc.GENDETCON=det.OID
inner join DGEMPRES21..GENCONTRA  con on det.GENCONTRA1=con.OID
inner join DGEMPRES21..SLNSERPRO  ser on ser.ADNINGRES1=ing.OID and ser.SERAPLPRO=0
inner join DGEMPRES21..SLNORDSER  ord on ser.SLNORDSER1=ord.OID and ord.SOSESTADO=1
left join DGEMPRES21..SLNSERHOJ   hoj on ser.OID=hoj.OID
left join DGEMPRES21..SLNPROHOJ   pro on ser.OID=pro.OID
left join DGEMPRES21..INNPRODUC  prod on pro.INNPRODUC1=prod.OID
left join DGEMPRES21..GENSERIPS   ips on hoj.GENSERIPS1=ips.OID
left join DGEMPRES21..SLNPAQHOJ paq		on paq.SLNSERHOJ1=hoj.OID and paq.SLNSERPRO1=ser.OID
left join DGEMPRES21..GENPAQUET pdet	on paq.GENPAQUET1=pdet.OID
left join DGEMPRES21..GENSERIPS ips1	on pdet.GENSERIPS2=ips1.OID
left join DGEMPRES21..SLNFACTUR facop on fac.OID=facop.OID
       and facop.SFAVALPAC not in (select GETTPCMEV from dgempres21..GENESTRATO/* where GETTPCMEV > 0*/)
left join DGEMPRES21..SLNFACTUR facta on fac.oid=facta.oid
       and facta.SFAVALPAC in (select GETTPCMEV from dgempres21..GENESTRATO/* where GETTPCMEV > 0*/)
OUTER APPLY CDO02_21..f_dx_egr_01(egr.OID) dx_e
where doc.CDTIPDOC = 0 and fac.SFANUMFAC in ('FV000002476930')
--and cxc.GENTERCER=70 
--and cxc.CRNSALDO > 0 and det.OID=441 and fac.SFAFECFAC > '2016-15-06 23:59:59' 
and coalesce (CONVERT(bigint, paq.SPHVALSER), CONVERT(bigint, ser.SERVALent + ser.SERVALPAC)) > 0
and facop.SFAVALPAC > 0
--and pac.PACPRINOM not like '% %' and pac.PACSEGNOM not like '% %' and pac.PACPRIAPE not like '% %' and pac.PACSEGAPE not like '% %'
--and doc.CDCONSEC = @radicado
order by facop.SFAVALPAC, fac.SFANUMFAC
--group by cxc.CXCDOCUME
------------------------------------------------------------------------------------------------------0003653558
--compute sum ((ser.SERCANTID * (coalesce (CONVERT(bigint, paq.sphtotent + paq.sphtotpac), CONVERT(bigint, ser.SERVALent + ser.SERVALPAC)))))
--compute sum (ser.SERCANTID * (coalesce (CONVERT(bigint, paq.sphtotent + paq.sphtotpac), CONVERT(bigint, ser.SERVALent + ser.SERVALPAC))))
------------------------------------------------------------------------------------------------------0003656320
--select top 5 * from SLNSERPRO order by OID desc
--select top 5 * from SLNORDSER order by OID desc