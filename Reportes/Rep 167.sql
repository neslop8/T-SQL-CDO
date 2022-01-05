------------------------------------------------------------------------------------------------------------------------------------
declare @fch_inicio   datetime = '2019-01-01 00:00:00'
declare @fch_fin      datetime = '2020-31-03 23:59:59'
declare @INGRESO      int = 2111089
------------------------------------------------------------------------------------------------------------------------------------
select ing.AINCONSEC ingreso, d.PACNUMDOC identificacion, f.GASCODIGO area, nota.HCNSUBOBJ nota,
e.GMECODIGO cod_med, e.gmenomcom medico,
RTRIM(LTRIM(d.PACPRIAPE)) +' '+ RTRIM(LTRIM(d.PACSEGAPE)) +' '+ RTRIM(LTRIM(d.PACPRINOM)) +' '+ RTRIM(LTRIM(d.PACSEGNOM))
, nota.HCRHORREG as Hora_Registro
from DGEMPRES21..ADNINGRESO ing inner join DGEMPRES21..HCNREGENF reg on ing.OID=reg.ADNINGRESO
inner join DGEMPRES21..HCNNOTENF nota on nota.HCNREGENF=reg.OID
inner join DGEMPRES21..GENPACIEN d on d.OID=ing.GENPACIEN
inner join DGEMPRES21..GENMEDICO e on e.OID=nota.GENMEDICO
inner join DGEMPRES21..GENARESER f on f.OID=reg.GENARESER
where (ing.AINCONSEC=@INGRESO or @INGRESO='') AND 
	  nota.HCRHORREG >= @fch_inicio AND
      nota.HCRHORREG <= @fch_fin 
Order By d.PACNUMDOC, nota.HCRHORREG	
------------------------------------------------------------------------------------------------------------------------------------