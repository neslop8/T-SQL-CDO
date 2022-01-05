-------------------------------------------------------------------------------------------------------------------
declare @ORDEN_INICIAL int = 5330000
declare @ORDEN_FINAL   int = 5425000
-------------------------------------------------------------------------------------------------------------------
SELECT DET.GDENOMBRE NOMBRE_EMPRESA, PAC.PACNUMDOC PACIENTE, CONT.GECCODIGO CONTRATO, DET.GDECODIGO PLANB
, ING.AINCONSEC INGRESO, ING.AINFECING FEC_ING, ORD.SOSORDSER ORDEN,
HOJ.SERFECSER FEC_SER, coalesce(IPS.SIPCODIGO, PROD.IPRCODIGO) Cod_Ser
, HOJ.SERDESSER NOMBRE, CONVERT(bigint,HOJ.SERCANTID) CANTIDAD, CON.GCFNOMBRE CONCEPTO
, CONVERT(bigint, HOJ.SERVALPRO) VALOR, case(hoj.SERVALMOD) when 1 then 'Si' else 'No' end Modifi
, coalesce(CONVERT(bigint,subser.sphvalser) ,CONVERT(bigint, HOJ.SERVALENT + HOJ.SERVALPAC)) val_Modifi
, CONVERT(bigint, coalesce(subser.SPHTOTPAC, HOJ.SERVALPAC)) val_pac
, CONVERT(bigint, (coalesce(subser.SPHTOTPAC, HOJ.SERVALPAC)*HOJ.SERCANTID)) tot_pac
, CONVERT(bigint, coalesce(subser.SPHTOTENT, HOJ.SERVALENT)) val_ent
, CONVERT(bigint, (coalesce(subser.SPHTOTENT, HOJ.SERVALENT)*HOJ.SERCANTID)) tot_ent
--, convert(int, subser.SPHTOTENT) + convert(int, subser.SPHTOTPAC)
, CASE HOJ.SERAPLPRO WHEN 1 THEN 'SI'  ELSE 'NO' END AS APLICA
, USU.USUNOMBRE AS COD_USU, USU.USUDESCRI AS USUARIO
, coalesce(aresp.GASCODIGO, areso.GASCODIGO) as Area_Solicita, arep.GASCODIGO as Area_Presta
, ord.oid, hoj.oid, case(ing.ainestado) when 0 then 'registrado' when 1 then 'facturado'
when 2 then 'anulado' when 3 then 'bloqueado' else 'otro' end as estado
, case(ips1.SIPCLASER) when 1 then 'NINGUNO' when 2 then 'CIRUJANO' when 3 then 'ANESTESIOLOGO' when 4 then 'AYUDANTE' 
                       when 5 then 'SALA' when 6 then 'MATERIAL' when 7 then 'INSTRUMENTACION' else 'OTRO' END CLASE
, coalesce (med1.gmecodigo, med.gmecodigo) cod_med, coalesce (med1.gmenomcom, med.gmenomcom) medico
FROM DgEmpres21..SLNSERPRO HOJ INNER JOIN DgEmpres21..SLNORDSER ORD on HOJ.SLNORDSER1=ORD.OID AND HOJ.ADNINGRES1=ORD.ADNINGRES1
INNER JOIN DgEmpres21..GENDETCON DET	ON DET.OID=HOJ.GENDETCON1
INNER JOIN DgEmpres21..ADNINGRESO ING	ON ING.OID=HOJ.ADNINGRES1 AND ING.OID=ORD.ADNINGRES1
INNER JOIN DgEmpres21..GENPACIEN PAC	ON PAC.OID=ING.GENPACIEN
INNER JOIN DgEmpres21..GENCONTRA CONT	ON CONT.OID=DET.GENCONTRA1
INNER JOIN DgEmpres21..GENTERCER TER	ON TER.OID=CONT.GENTERCER1
inner join dgempres21..GENMEDICO med	on HOJ.GENMEDICO1=med.OID
LEFT JOIN DgEmpres21..SLNSERHOJ SER		ON SER.OID=HOJ.OID
LEFT JOIN DgEmpres21..GENSERIPS IPS		ON IPS.OID=SER.GENSERIPS1
LEFT JOIN DgEmpres21..SLNPROHOJ PRO		ON PRO.OID=HOJ.OID
LEFT JOIN DgEmpres21..INNPRODUC PROD	ON PROD.OID=PRO.INNPRODUC1
LEFT JOIN DgEmpres21..GENCONFAC CON		ON (CON.OID=IPS.GENCONFAC1 OR CON.OID=PROD.GENCONFAC)
LEFT JOIN DgEmpres21..GENUSUARIO USU	ON ORD.GENUSUARIO1=USU.OID
LEFT JOIN DgEmpres21..GENARESER areso	on ord.GENARESER1=areso.OID
LEFT JOIN DgEmpres21..GENARESER arep	on hoj.GENARESER1=arep.OID
LEFT JOIN DgEmpres21..INNCSUMPA csum	on csum.slnordser=ord.oid
LEFT JOIN DgEmpres21..GENARESER aresp	on csum.GENARESER1=aresp.OID
left join dgempres21..SLNPAQHOJ subser	on subser.SLNSERHOJ1=hoj.OID
left join DGEMPRES21..GENPAQUET pdet	on subser.GENPAQUET1=pdet.OID
left join DGEMPRES21..GENSERIPS ips1	on pdet.GENSERIPS2=ips1.OID
left join dgempres21..GENMEDICO med1	on subser.GENMEDICO1=med1.OID
WHERE ORD.SOSESTADO <> 2 --and ord.SOSORDSER in (3575276,3575312,3579259) 
and ord.SOSFECORD >= '2016-01-07 00:00:00'
and ord.SOSFECORD <= '2016-31-07 23:59:59'
--and arep.OID in (146, 156)
--AND ORD.SOSORDSER >= @ORDEN_INICIAL
--AND ORD.SOSORDSER <= @ORDEN_FINAL
ORDER BY ORD.SOSORDSER desc
-------------------------------------------------------------------------------------------------------------------
--select top 5 * from SLNORDSER
-------------------------------------------------------------------------------------------------------------------