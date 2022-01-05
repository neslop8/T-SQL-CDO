----------------------------------------------------------------------------------------------------------------------------
declare @fch_inicio datetime = '20170501'
declare @fch_fin    datetime = '20170502'    
----------------------------------------------------------------------------------------------------------------------------
SELECT ing.ainfecing fch_ingreso, pac.pacnumdoc documento, ing.ainconsec ingreso
, case ing.ainestado when 0 then 'Registrado' when 1 Then 'Facturado' when 2 Then 'Anulado' when 3 Then 'Bloqueado' end Est_ING
, RTRIM(pac.pacprinom) + ' ' + RTRIM(pac.pacsegnom) + ' ' + RTRIM(pac.pacpriape) + ' ' + RTRIM(pac.pacsegape) paciente 
, doc.IDCONSEC suministro, doc.IDFECDOC fec_sum, usu.USUNOMBRE usuario_sum, are.GASCODIGO cod_area, are.GASNOMBRE area
, case doc.IDESTADO when 0 then 'Registrado' when 1 Then 'Confirmado' when 2 Then 'Anulado' when 3 Then 'Otro' end Est_SUM
, SUBSTRING(cd.gdecodigo, 1, 6) contrato_cod  , SUBSTRING(cd.gdenombre, 1, 20) contrato_nom, tri.HCNCLAURGTR clasf 
, prod.IPRCODIGO cod_prod, prod.IPRDESCOR producto, msum.IDDCANTID Cant_sum, dsum.IDDCANTID Cant_dev
FROM DgEmpres21..adningreso ing inner join DgEmpres21..genpacien pac ON ing.genpacien = pac.oid
INNER JOIN DgEmpres21..HCNTRIAGE tri  ON ing.HCENTRIAGE=tri.OID and tri.ADNINGRESO=ing.OID
INNER JOIN DgEmpres21..GENDETCON cd   ON ing.GENDETCON = cd.OID
INNER JOIN DgEmpres21..INNCSUMPA csum ON csum.ADNINGRESO = ing.OID and csum.INNALMACE=2
INNER JOIN DgEmpres21..INNDOCUME doc  ON csum.OID = doc.OID
INNER JOIN DgEmpres21..INNMSUMPA msum ON msum.INNCSUMPA  = csum.OID
INNER JOIN DgEmpres21..INNPRODUC prod ON msum.INNPRODUC  = prod.OID
INNER JOIN DgEmpres21..GENUSUARIO usu ON doc.GENUSUARIO2 = usu.OID
left JOIN DgEmpres21..GENARESER are  ON ing.GENARESER=are.OID
left JOIN DgEmpres21..INNMDESUM  dsum ON dsum.INNMSUMPA  = msum.OID
left JOIN DgEmpres21..INNDOCUME  doc1 ON dsum.INNCDESUM  = doc1.OID and doc1.IDESTADO=1
WHERE ing.AINFECING >= @fch_inicio         
AND ing.AINFECING <= @fch_fin         
order by ing.AINCONSEC, doc.IDFECDOC, prod.IPRCODIGO
----------------------------------------------------------------------------------------------------------------------------
select top 5 * from ADNINGRESO order by OID desc
select top 5 * from INNDOCUME
select top 5 * from GENUSUARIO
select top 5 * from INNCSUMPA order by OID desc
select top 5 * from INNMSUMPA order by OID desc
select top 5 * from INNMDESUM order by OID desc
select top 5 * from INNPRODUC
select top 5 * from INNALMACE
select top 5 * from HCNTRIAGE order by OID desc
----------------------------------------------------------------------------------------------------------------------------
