-------------------------------------------------------------------------------------------------------------
declare @FACTURA_INICIAL varchar(15) = '000000000000'
declare @FACTURA_FINAL   varchar(15) = 'P99999999999'
declare @ENTIDAD_INICIAL varchar(10)= '800251440'
declare @ENTIDAD_FINAL	 varchar(10)= '800251440'
declare @AUDITOR_INICIAL varchar(10)= 'BARAUJO'
declare @AUDITOR_FINAL   varchar(10)= 'BARAUJO'
declare @FECHA_RESPUESTA_INICIAL datetime = '2021-01-10 00:00:00'
declare @FECHA_RESPUESTA_FINAL	 datetime = '2021-15-10 23:59:59'
-------------------------------------------------------------------------------------------------------------
SELECT CXC.CXCDOCUME FACTURA, CXC.CXCDOCFECHA FECHA_FACTURA, MONTH(CXC.CXCDOCFECHA) MES_FACTURA, YEAR(CXC.CXCDOCFECHA) A?O_FACTURA
, CXC.CRNVALOR VALOR_FACTURA, TER.TERNUMDOC NIT, TER.TERNOMCOM ENTIDAD, DOC1.CDCONSEC N?_GLOSA, CONVERT(varchar,DOC1.CDFECDOC, 111) FECHA_GLOSA
, CON.CCOCODIGO COD_GLOSA, CON.CCONOMBRE NOM_GLOSA, DOBJ.CROVALOBJ VALOR_GLOSA, DOBJ.CRDOBSERV OBSERVACION_GLOSA
, (SELECT CT.CCOCODIGO FROM CRNCONOBJ CT, CRNTRAOBJD TD WHERE TD.CRNCONOBJ = CT.OID AND TD.CRNRECOBJD = DOBJ.OID) CON_RESP
, (SELECT CT.CCONOMBRE FROM CRNCONOBJ CT, CRNTRAOBJD TD WHERE TD.CRNCONOBJ = CT.OID AND TD.CRNRECOBJD = DOBJ.OID) NOM_RESP
, CONVERT(varchar,DOC2.CDFECDOC, 111) FECHA_RTA, DOC2.CDCONSEC N?_RESPUESTA
, (SELECT TD.CTDVALOBJ FROM CRNTRAOBJD TD WHERE TD.CRNRECOBJD = DOBJ.OID) VALOR_ACEPTADO
, (SELECT TD.CTDOBSERV FROM CRNTRAOBJD TD WHERE TD.CRNRECOBJD = DOBJ.OID) RESPUESTA, USU.USUNOMBRE COD_USUARIO_CONFIRMA
, USU.USUDESCRI DESCRIPCION_USUARIO_CONFIRMA 
FROM CRNCXC CXC INNER JOIN GENTERCER TER ON CXC.GENTERCER = TER.OID 
INNER JOIN CRNRECOBJC COBJ ON COBJ.CRNCXC = CXC.OID 
INNER JOIN CRNRECOBJD DOBJ ON DOBJ.CRNRECOBJC = COBJ.OID 
INNER JOIN CRNDOCUME DOC1 ON DOC1.OID = COBJ.OID 
INNER JOIN CRNCONOBJ CON ON CON.OID = DOBJ.CRNCONOBJ 
INNER JOIN CRNTRAOBJC CTRA ON CTRA.CRNRECOBJC = COBJ.OID 
INNER JOIN CRNDOCUME DOC2 ON DOC2.OID = CTRA.OID 
INNER JOIN CRNTRAOBJD DTRA ON DTRA.CRNRECOBJD = DOBJ.OID AND DTRA.CRNTRAOBJC = CTRA.OID INNER JOIN GENUSUARIO USU ON DOC2.GENUSUARIO2 = USU.OID 
WHERE 
CXC.CXCDOCUME >= @FACTURA_INICIAL AND 
CXC.CXCDOCUME <= @FACTURA_FINAL AND 
TER.TERNUMDOC >= @ENTIDAD_INICIAL AND 
TER.TERNUMDOC <= @ENTIDAD_FINAL AND 
USU.USUNOMBRE >= @AUDITOR_INICIAL AND 
USU.USUNOMBRE <= @AUDITOR_FINAL AND 
DOC2.CDFECCON >= @FECHA_RESPUESTA_INICIAL AND 
DOC2.CDFECCON <= @FECHA_RESPUESTA_FINAL AND 
CTRA.CROESTADO IN (1) AND COBJ.CROESTADO = 1
-------------------------------------------------------------------------------------------------------------