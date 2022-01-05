DECLARE @year CHAR(11)
if month(getdate()) > 9
	begin
          SELECT @year  = 'GELOG' + CONVERT(VARCHAR, year(getdate())) +  CONVERT(VARCHAR, month(getdate()))
	end
else
	begin		
		SELECT @year  = 'GELOG' + CONVERT(VARCHAR, year(getdate())) + '0' +  CONVERT(VARCHAR, month(getdate()))
	end
print @year

DECLARE @query NVARCHAR(1000)
	SELECT @query = '
WITH AUDITORIA(GENUSUARIO, OID)
AS
(
select GENUSUARIO, MAX(OID) 
from dgempres01..'+@year+'
GROUP BY GENUSUARIO
)
-----------
Select DATEDIFF(minute, doc.Fecha, GETDATE()) Minutos, doc.Fecha Fecha_Bloqueo, doc.Equipo Equipo_Bloqueo, USU.USUNOMBRE as CODIGO
, USU.USUDESCRI as _________USUARIO_________, OBJ.TypeName as MODULO, doc.BDOIDDOCU as DOCUMENTO, logaud.audcomputa as ___PC_o_IP___
, pac.PACNUMDOC Identificacion, pac.GPANOMCOM ____Paciente____, ing.AINCONSEC Ingreso
from dgempres01..GENDOCUME doc inner join dgempres01..GENUSUARIO usu on doc.GENUSUARIO=usu.OID
inner join dgempres01..XPObjectType obj on doc.BDOIDTYPE=obj.OID
inner join AUDITORIA aud on aud.GENUSUARIO=usu.OID
inner join dgempres01..'+@year+' logaud on logaud.OID=aud.OID
left join dgempres01..HCNREGENF  enf  ON doc.BDOIDDOCU=enf.oid and obj.OID=1315
left join dgempres01..GENPACIEN  pac  ON enf.GENPACIEN=pac.OID
left join dgempres01..ADNINGRESO ing  ON enf.ADNINGRESO=ing.OID
order by 1 desc
' EXECUTE sp_executesql @query