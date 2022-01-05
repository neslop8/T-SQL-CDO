------------------------------------------------------------------------------------------------------
declare @factura char(15) = 'FV000003781306'
------------------------------------------------------------------------------------------------------
declare @tipo int 
select @tipo=SFAVALPAC from DGEMPRES21..SLNFACTUR where SFANUMFAC=@factura
------------------------------------------------------------------------------------------------------
if (@tipo <= 0)
	begin
------------------------------------------------------------------------------------------------------Sin copago
select SUBSTRING(cxc.CXCDOCUME, 1, 4) PREF_FACT, CONVERT(char, SUBSTRING(cxc.CXCDOCUME, 5, 15)) NUME_FACT, 'NI' TIPO_DOC_IPS
, '860090566' NUME_DOC_IPS, CONVERT(char, '110010966601') COD_HAB_IPS, con.GECCODIGO COD_EPS
, case GDEPAQUET when 1 then 2 when 2 then 1 else 3 end COD_CUENTA, '' COD_CONTRATO
, convert(NVARCHAR, cxc.CXCDOCFECHA, 103) FECHA_FACT, convert(NVARCHAR,(fac.SFATOTFAC + fac.SFAVALPAC)) VALOR_BRUTO
, convert(int, facop.SFAVALPAC) VALOR_COPAGO, '0' VALOR_COPAGO_COMPARTIDO
, '0' VALOR_IVA, '0' VALOR_ICO
, VALOR_MODERADORA = CASE WHEN (facta.SFAVALPAC IS not null) THEN convert(int, facta.SFAVALPAC) ELSE 0 END 
, '0' VALOR_DESCUENTO
, convert(int, fac.SFAVALDES) CON_DES, convert(NVARCHAR, fac.SFATOTFAC) VALOR_NETO
, '' PERIODO, '5' COD_REGIONAL
, case ing.AINCAUING when 3 then 1 when 4 then 1 when 10 then 2 when 1 then 3 when 6 then 4 when 7 then 5 else '1' end CLASIFICACION_ORIGEN
, '' TIPO_SERVICIO, '' TIPO_PAQUETE, '' FIN_CONSULTA, '' DIAS_TRAT
, CASE pac.pactipdoc   WHEN '1' THEN 'CC'    WHEN '2' THEN 'CE'    WHEN '3' THEN 'TI'    WHEN '4' THEN 'RC'    
            WHEN '5' THEN 'PA'    WHEN '6' THEN 'AS'    WHEN '7' THEN 'MS'    WHEN '8' THEN 'NU' END TDOC_PACIENTE
, pac.PACNUMDOC NDOC_PACIENTE, REPLACE(REPLACE(RTRIM(LTRIM(pac.PACPRINOM)),'/',' '),'-',' ') NOMB1_PACIENTE
, REPLACE(REPLACE(RTRIM(LTRIM(pac.PACSEGNOM)),'/',' '),'-',' ') NOMB2_PACIENTE
, RTRIM(LTRIM(pac.PACPRIAPE)) APELLIDO1_PACIENTE, RTRIM(LTRIM(pac.PACSEGAPE)) APELLIDO2_PACIENTE
, ROUND((CONVERT (INT, GETDATE()) - CONVERT(INT, pac.gpafecnac)) / 365, 0) EDAD_PACIENTE
, CASE pac.gpasexpac WHEN '1' THEN 'M' ELSE 'F' END SEXO_PACIENTE 
, CASE pac.gpaestado WHEN '2' THEN '0' ELSE '1' END ESTADO_PACIENTE  
, 'N' DISCAPACIDAD, case SERMEDICA when 0 then 'P' else 'M' END TIPO_PRESTACION
, coalesce (ips.SIPCODIGO, prod.IPRCODIGO) CODIGO_DE_FACTURACION_PRINCIPAL
, CODIGO_PROCEDIMIENTO_DETALLE = CASE WHEN (ips1.SIPCODIGO IS NOT NULL) THEN ips1.SIPCODIGO ELSE '' END
, REPLACE(REPLACE(REPLACE(REPLACE(coalesce (ips1.SIPNOMBRE, ips.SIPNOMBRE, prod.IPRDESCOR),'*','"'),'&','"'),'#','Num'),';',',') DESC_PROCEDIMIENTO
, convert(CHAR, ser.SERFECSER, 103) FECHA_PROCEDIMIENTO
, SUBSTRING(convert(CHAR, ser.SERFECSER, 108), 1, 5) HORA_PROCEDIMIENTO, ser.SERCANTID CANTIDAD_PROCEDIMIENTO
, coalesce (paq.SPHVALSER, paq.SPHtotent,  ser.SERVALent + ser.SERVALPAC) VALOR_UNITARIO-----sin copago
, '0' VALOR_COMPARTIDO_PACIENTE
, '0' VALOR_MODERADORA_PACIENTE
, coalesce(paq.sphtotpac, ser.SERVALPAC) * ser.SERCANTID VALOR_COPAGO_PACIENTE
, round(ser.SERCANTID * coalesce (paq.sphtotent+paq.sphtotpac, (ser.SERVALent + ser.SERVALPAC)), 0) VALOR_TOTAL_SERVICIO
, ing.AINNUMAUT COD_AUTORIZACION, RTRIM(LTRIM(substring(dx_e.dg, 1, 4))) DIAGNOSTICO_PRINCIPAL, '' TIPO_DIAG
, '' DIAGNOSTICO_SECUNDARIO_1, '' DIAGNOSTICO_SECUNDARIO_2
, convert(CHAR, ing.AINFECING, 103) FECHA_ENTRADA
, SUBSTRING(convert(CHAR, ing.AINFECING, 108), 1, 5) HORA_ENTRADA
, convert(CHAR, egr.ADEFECSAL, 103) FECHA_SALIDA
, SUBSTRING(convert(CHAR, egr.ADEFECSAL, 108), 1, 5) HORA_SALIDA
from DGEMPRES21..CRNDOCUME doc inner join DGEMPRES21..CRNRADFACD drad on drad.CRNRADFACC=doc.OID
inner join DGEMPRES21..CRNCXC     cxc on drad.CRNCXC=cxc.OID
inner join DGEMPRES21..SLNFACTUR  fac on fac.CRNCXC1=cxc.OID
inner join DGEMPRES21..ADNINGRESO ing on fac.ADNINGRESO=ing.OID
left join DGEMPRES21..ADNEGRESO  egr on egr.ADNINGRESO=ing.OID
inner join DGEMPRES21..GENPACIEN  pac on ing.GENPACIEN=pac.OID
inner join DGEMPRES21..GENDETCON  det on cxc.GENDETCON=det.OID 
inner join DGEMPRES21..GENCONTRA  con on det.GENCONTRA1=con.OID
inner join DGEMPRES21..SLNSERPRO  ser on ser.ADNINGRES1=ing.OID and ser.SERAPLPRO=0 and ser.GENDETCON1=det.OID
inner join DGEMPRES21..SLNORDSER  ord on ser.SLNORDSER1=ord.OID and ord.SOSESTADO=1
left join DGEMPRES21..SLNSERHOJ   hoj on ser.OID=hoj.OID
left join DGEMPRES21..SLNPROHOJ   pro on ser.OID=pro.OID
left join DGEMPRES21..INNPRODUC  prod on pro.INNPRODUC1=prod.OID
left join DGEMPRES21..GENSERIPS   ips on hoj.GENSERIPS1=ips.OID
left join DGEMPRES21..SLNPAQHOJ paq	  on paq.SLNSERHOJ1=hoj.OID and paq.SLNSERPRO1=ser.OID
left join DGEMPRES21..GENPAQUET pdet  on paq.GENPAQUET1=pdet.OID
left join DGEMPRES21..GENSERIPS ips1  on pdet.GENSERIPS2=ips1.OID
left join DGEMPRES21..SLNFACTUR facop on fac.OID=facop.OID
       and facop.SFAVALPAC not in (select GETTPCMEV from dgempres21..GENESTRATO/* where GETTPCMEV > 0*/)
left join DGEMPRES21..SLNFACTUR facta on fac.oid=facta.oid
       and facta.SFAVALPAC in (select GETTPCMEV from dgempres21..GENESTRATO/* where GETTPCMEV > 0*/)
OUTER APPLY CDO02_21..f_dx_egr_01(egr.OID) dx_e
where doc.CDTIPDOC = 0 and cxc.CRNSALDO > 0 
AND fac.SFAVALPAC <= 0 and fac.SFANUMFAC = @factura
order by cxc.CXCDOCUME
end
else 
	begin
------------------------------------------------------------------------------------------------------Con copago
select SUBSTRING(cxc.CXCDOCUME, 1, 4) PREF_FACT, SUBSTRING(cxc.CXCDOCUME, 5, 15) NUME_FACT, 'NI' TIPO_DOC_IPS
, '860090566' NUME_DOC_IPS, '110010966601' COD_HAB_IPS, con.GECCODIGO COD_EPS
, case GDEPAQUET when 1 then 2 when 2 then 1 else 3 end COD_CUENTA, '' COD_CONTRATO
, convert(NVARCHAR, cxc.CXCDOCFECHA, 103) FECHA_FACT, convert(NVARCHAR,(fac.SFATOTFAC + fac.SFAVALPAC)) VALOR_BRUTO
, convert(int, facop.SFAVALPAC) VALOR_COPAGO, '0' VALOR_COPAGO_COMPARTIDO
, '0' VALOR_IVA, '0' VALOR_ICO
, VALOR_MODERADORA = CASE WHEN (facta.SFAVALPAC IS not null) THEN convert(int, facta.SFAVALPAC) ELSE 0 END 
, '0' VALOR_DESCUENTO
, convert(int, fac.SFAVALDES) CON_DES, convert(NVARCHAR, fac.SFATOTFAC) VALOR_NETO
, '' PERIODO, '5' COD_REGIONAL
, case ing.AINCAUING when 3 then 1 when 4 then 1 when 10 then 2 when 1 then 3 when 6 then 4 when 7 then 5 else '1' end CLASIFICACION_ORIGEN
, '' TIPO_SERVICIO, '' TIPO_PAQUETE, '' FIN_CONSULTA, '' DIAS_TRAT
, CASE pac.pactipdoc   WHEN '1' THEN 'CC'    WHEN '2' THEN 'CE'    WHEN '3' THEN 'TI'    WHEN '4' THEN 'RC'    
            WHEN '5' THEN 'PA'    WHEN '6' THEN 'AS'    WHEN '7' THEN 'MS'    WHEN '8' THEN 'NU' END TDOC_PACIENTE
, pac.PACNUMDOC NDOC_PACIENTE, REPLACE(REPLACE(RTRIM(LTRIM(pac.PACPRINOM)),'/',' '),'-',' ') NOMB1_PACIENTE
, REPLACE(REPLACE(RTRIM(LTRIM(pac.PACSEGNOM)),'/',' '),'-',' ') NOMB2_PACIENTE
, RTRIM(LTRIM(pac.PACPRIAPE)) APELLIDO1_PACIENTE, RTRIM(LTRIM(pac.PACSEGAPE)) APELLIDO2_PACIENTE
, ROUND((CONVERT (INT, GETDATE()) - CONVERT(INT, pac.gpafecnac)) / 365, 0) EDAD_PACIENTE
, CASE pac.gpasexpac WHEN '1' THEN 'M' ELSE 'F' END SEXO_PACIENTE 
, CASE pac.gpaestado WHEN '2' THEN '0' ELSE '1' END ESTADO_PACIENTE  
, 'N' DISCAPACIDAD, case SERMEDICA when 0 then 'P' else 'M' END TIPO_PRESTACION
, coalesce (ips.SIPCODIGO, prod.IPRCODIGO) CODIGO_DE_FACTURACION_PRINCIPAL
, CODIGO_PROCEDIMIENTO_DETALLE = CASE WHEN (ips1.SIPCODIGO IS NOT NULL) THEN ips1.SIPCODIGO ELSE '' END
, REPLACE(REPLACE(REPLACE(REPLACE(coalesce (ips1.SIPNOMBRE, ips.SIPNOMBRE, prod.IPRDESCOR),'*','"'),'&','"'),'#','Num'),';',',') DESC_PROCEDIMIENTO
, convert(CHAR, ser.SERFECSER, 103) FECHA_PROCEDIMIENTO
, SUBSTRING(convert(CHAR, ser.SERFECSER, 108), 1, 5) HORA_PROCEDIMIENTO, ser.SERCANTID CANTIDAD_PROCEDIMIENTO
, coalesce ((paq.sphtotent+paq.sphtotpac), (ser.SERVALent + ser.SERVALPAC))-----con copago
, '0' VALOR_COMPARTIDO_PACIENTE
, '0' VALOR_MODERADORA_PACIENTE
, coalesce(paq.sphtotpac, ser.SERVALPAC) * ser.SERCANTID VALOR_COPAGO_PACIENTE
, round(ser.SERCANTID * coalesce (paq.sphtotent+paq.sphtotpac, (ser.SERVALent + ser.SERVALPAC)), 0) VALOR_TOTAL_SERVICIO
, ing.AINNUMAUT COD_AUTORIZACION, RTRIM(LTRIM(substring(dx_e.dg,1 , 4))) DIAGNOSTICO_PRINCIPAL, '' TIPO_DIAG
, '' DIAGNOSTICO_SECUNDARIO_1, '' DIAGNOSTICO_SECUNDARIO_2
, convert(CHAR, ing.AINFECING, 103) FECHA_ENTRADA
, SUBSTRING(convert(CHAR, ing.AINFECING, 108), 1, 5) HORA_ENTRADA
, convert(CHAR, egr.ADEFECSAL, 103) FECHA_SALIDA
, SUBSTRING(convert(CHAR, egr.ADEFECSAL, 108), 1, 5) HORA_SALIDA
from DGEMPRES21..CRNDOCUME doc inner join DGEMPRES21..CRNRADFACD drad on drad.CRNRADFACC=doc.OID
inner join DGEMPRES21..CRNCXC     cxc on drad.CRNCXC=cxc.OID
inner join DGEMPRES21..SLNFACTUR  fac on fac.CRNCXC1=cxc.OID
inner join DGEMPRES21..ADNINGRESO ing on fac.ADNINGRESO=ing.OID
left join DGEMPRES21..ADNEGRESO  egr on egr.ADNINGRESO=ing.OID
inner join DGEMPRES21..GENPACIEN  pac on ing.GENPACIEN=pac.OID
inner join DGEMPRES21..GENDETCON  det on cxc.GENDETCON=det.OID 
inner join DGEMPRES21..GENCONTRA  con on det.GENCONTRA1=con.OID
inner join DGEMPRES21..SLNSERPRO  ser on ser.ADNINGRES1=ing.OID and ser.SERAPLPRO=0 and ser.GENDETCON1=det.OID
inner join DGEMPRES21..SLNORDSER  ord on ser.SLNORDSER1=ord.OID and ord.SOSESTADO=1
left join DGEMPRES21..SLNSERHOJ   hoj on ser.OID=hoj.OID
left join DGEMPRES21..SLNPROHOJ   pro on ser.OID=pro.OID
left join DGEMPRES21..INNPRODUC  prod on pro.INNPRODUC1=prod.OID
left join DGEMPRES21..GENSERIPS   ips on hoj.GENSERIPS1=ips.OID
left join DGEMPRES21..SLNPAQHOJ paq	  on paq.SLNSERHOJ1=hoj.OID and paq.SLNSERPRO1=ser.OID
left join DGEMPRES21..GENPAQUET pdet  on paq.GENPAQUET1=pdet.OID
left join DGEMPRES21..GENSERIPS ips1  on pdet.GENSERIPS2=ips1.OID
left join DGEMPRES21..SLNFACTUR facop on fac.OID=facop.OID
       and facop.SFAVALPAC not in (select GETTPCMEV from dgempres21..GENESTRATO/* where GETTPCMEV > 0*/)
left join DGEMPRES21..SLNFACTUR facta on fac.oid=facta.oid
       and facta.SFAVALPAC in (select GETTPCMEV from dgempres21..GENESTRATO/* where GETTPCMEV > 0*/)
OUTER APPLY CDO02_21..f_dx_egr_01(egr.OID) dx_e
where doc.CDTIPDOC = 0 and cxc.CRNSALDO > 0 
AND fac.SFAVALPAC > 0 and fac.SFANUMFAC = @factura
order by cxc.CXCDOCUME
end
------------------------------------------------------------------------------------------------------0003653558
--compute sum (round(ser.SERCANTID * coalesce (paq.SPHVALSER, (ser.SERVALent + ser.SERVALPAC)), 0))
------------------------------------------------------------------------------------------------------0003656320
--select top 5 * from SLNSERPRO order by OID desc
--select top 5 * from SLNORDSER order by OID desc
--select * from gendetcon where GDENOMBRE like '%cafe%'