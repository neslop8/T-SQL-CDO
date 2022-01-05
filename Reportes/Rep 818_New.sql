declare @usuario varchar(20) = 'AXRUBIO'
if month(getdate()) = 7
	begin
          select aud.AUDFECHA Fecha_Login, aud.AUDDETALLE Detalle
		, SUBSTRING(aud.AUDCOMPUTA, 0, 12) ___Equipo___, SUBSTRING(aud.AUDCOMPUTA, LEN(aud.AUDCOMPUTA) - 15, 15) Dir_IP
		from DGEMPRES01..GELOG202107 aud inner join DGEMPRES01..GENUSUARIO usu ON aud.GENUSUARIO=usu.OID
		where AUDOIDTIP=1530 and usu.USUNOMBRE=@usuario
	end
if month(getdate()) = 8
	begin
          select aud.AUDFECHA Fecha_Login, aud.AUDDETALLE Detalle
		, SUBSTRING(aud.AUDCOMPUTA, 0, 12) ___Equipo___, SUBSTRING(aud.AUDCOMPUTA, LEN(aud.AUDCOMPUTA) - 15, 15) Dir_IP
		from DGEMPRES01..GELOG202108 aud inner join DGEMPRES01..GENUSUARIO usu ON aud.GENUSUARIO=usu.OID
		where AUDOIDTIP=1530 and usu.USUNOMBRE=@usuario
	end
if month(getdate()) = 9
	begin
          select aud.AUDFECHA Fecha_Login, aud.AUDDETALLE Detalle
		, SUBSTRING(aud.AUDCOMPUTA, 0, 12) ___Equipo___, SUBSTRING(aud.AUDCOMPUTA, LEN(aud.AUDCOMPUTA) - 15, 15) Dir_IP
		from DGEMPRES01..GELOG202109 aud inner join DGEMPRES01..GENUSUARIO usu ON aud.GENUSUARIO=usu.OID
		where AUDOIDTIP=1530 and usu.USUNOMBRE=@usuario
	end
if month(getdate()) = 10
	begin
          select aud.AUDFECHA Fecha_Login, aud.AUDDETALLE Detalle
		, SUBSTRING(aud.AUDCOMPUTA, 0, 12) ___Equipo___, SUBSTRING(aud.AUDCOMPUTA, LEN(aud.AUDCOMPUTA) - 15, 15) Dir_IP
		from DGEMPRES01..GELOG202110 aud inner join DGEMPRES01..GENUSUARIO usu ON aud.GENUSUARIO=usu.OID
		where AUDOIDTIP=1530 and usu.USUNOMBRE=@usuario
	end
if month(getdate()) = 11
	begin
          select aud.AUDFECHA Fecha_Login, aud.AUDDETALLE Detalle
		, SUBSTRING(aud.AUDCOMPUTA, 0, 12) ___Equipo___, SUBSTRING(aud.AUDCOMPUTA, LEN(aud.AUDCOMPUTA) - 15, 15) Dir_IP
		from DGEMPRES01..GELOG202111 aud inner join DGEMPRES01..GENUSUARIO usu ON aud.GENUSUARIO=usu.OID
		where AUDOIDTIP=1530 and usu.USUNOMBRE=@usuario
	end
if month(getdate()) = 12
	begin
          select aud.AUDFECHA Fecha_Login, aud.AUDDETALLE Detalle
		, SUBSTRING(aud.AUDCOMPUTA, 0, 12) ___Equipo___, SUBSTRING(aud.AUDCOMPUTA, LEN(aud.AUDCOMPUTA) - 15, 15) Dir_IP
		from DGEMPRES01..GELOG202112 aud inner join DGEMPRES01..GENUSUARIO usu ON aud.GENUSUARIO=usu.OID
		where AUDOIDTIP=1530 and usu.USUNOMBRE=@usuario
	end
else
	begin		
		print N'Definir tabla de LOG para la fecha actual'  
	end

/*
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
*/