Declare @usuario char(20) = 'HSARIZA'

if month(getdate()) = 6
	begin
          select aud.AUDFECHA Fecha_Login, aud.AUDDETALLE Detalle
		, SUBSTRING(aud.AUDCOMPUTA, 0, 12) ___Equipo___, SUBSTRING(aud.AUDCOMPUTA, LEN(aud.AUDCOMPUTA) - 15, 15) Dir_IP
		from DGEMPRES01..GELOG202106 aud inner join DGEMPRES01..GENUSUARIO usu ON aud.GENUSUARIO=usu.OID
		where AUDOIDTIP=1530 and usu.USUNOMBRE=@usuario order by aud.OID desc
	end
if month(getdate()) = 7
	begin
          select aud.AUDFECHA Fecha_Login, aud.AUDDETALLE Detalle
		, SUBSTRING(aud.AUDCOMPUTA, 0, 12) ___Equipo___, SUBSTRING(aud.AUDCOMPUTA, LEN(aud.AUDCOMPUTA) - 15, 15) Dir_IP
		from DGEMPRES01..GELOG202107 aud inner join DGEMPRES01..GENUSUARIO usu ON aud.GENUSUARIO=usu.OID
		where AUDOIDTIP=1530 and usu.USUNOMBRE=@usuario order by aud.OID desc
	end
if month(getdate()) = 8
	begin
          select aud.AUDFECHA Fecha_Login, aud.AUDDETALLE Detalle
		, SUBSTRING(aud.AUDCOMPUTA, 0, 12) ___Equipo___, SUBSTRING(aud.AUDCOMPUTA, LEN(aud.AUDCOMPUTA) - 15, 15) Dir_IP
		from DGEMPRES01..GELOG202108 aud inner join DGEMPRES01..GENUSUARIO usu ON aud.GENUSUARIO=usu.OID
		where AUDOIDTIP=1530 and usu.USUNOMBRE=@usuario order by aud.OID desc
	end
if month(getdate()) = 9
	begin
          select aud.AUDFECHA Fecha_Login, aud.AUDDETALLE Detalle
		, SUBSTRING(aud.AUDCOMPUTA, 0, 12) ___Equipo___, SUBSTRING(aud.AUDCOMPUTA, LEN(aud.AUDCOMPUTA) - 15, 15) Dir_IP
		from DGEMPRES01..GELOG202109 aud inner join DGEMPRES01..GENUSUARIO usu ON aud.GENUSUARIO=usu.OID
		where AUDOIDTIP=1530 and usu.USUNOMBRE=@usuario order by aud.OID desc
	end
if month(getdate()) = 10
	begin
          select aud.AUDFECHA Fecha_Login, aud.AUDDETALLE Detalle
		, SUBSTRING(aud.AUDCOMPUTA, 0, 12) ___Equipo___, SUBSTRING(aud.AUDCOMPUTA, LEN(aud.AUDCOMPUTA) - 15, 15) Dir_IP
		from DGEMPRES01..GELOG202110 aud inner join DGEMPRES01..GENUSUARIO usu ON aud.GENUSUARIO=usu.OID
		where AUDOIDTIP=1530 and usu.USUNOMBRE=@usuario order by aud.OID desc
	end
if month(getdate()) = 11
	begin
          select aud.AUDFECHA Fecha_Login, aud.AUDDETALLE Detalle
		, SUBSTRING(aud.AUDCOMPUTA, 0, 12) ___Equipo___, SUBSTRING(aud.AUDCOMPUTA, LEN(aud.AUDCOMPUTA) - 15, 15) Dir_IP
		from DGEMPRES01..GELOG202111 aud inner join DGEMPRES01..GENUSUARIO usu ON aud.GENUSUARIO=usu.OID
		where AUDOIDTIP=1530 and usu.USUNOMBRE=@usuario order by aud.OID desc
	end
if month(getdate()) = 12
	begin
          select aud.AUDFECHA Fecha_Login, aud.AUDDETALLE Detalle
		, SUBSTRING(aud.AUDCOMPUTA, 0, 12) ___Equipo___, SUBSTRING(aud.AUDCOMPUTA, LEN(aud.AUDCOMPUTA) - 15, 15) Dir_IP
		from DGEMPRES01..GELOG202112 aud inner join DGEMPRES01..GENUSUARIO usu ON aud.GENUSUARIO=usu.OID
		where AUDOIDTIP=1530 and usu.USUNOMBRE=@usuario order by aud.OID desc
	end
else
	begin		
		print N'Definir tabla de LOG para la fecha actual'  
	end