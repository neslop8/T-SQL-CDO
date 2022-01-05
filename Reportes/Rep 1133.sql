use DGEMPRES02
select top 5 * from PCNPROSAL order by OID desc
select top 5 * from PCNPSDPRO
select top 5 * from HCNPROCIRENF
select top 5 * from PCNPSDHAL
select top 5 * from GENPACIEN where oid=68387

select top 5 * from PCNPROSAL order by OID desc
select top 5 * from PCNPROCIRNOT order by OID desc
select top 5 * from HCNPROCIRENF order by OID desc
-------------------------------------------------------------------------------------------------------------------------------------
declare @fch_inicio datetime = '20180101'
declare @fch_fin datetime = '20211231'
-------------------------------------------------------------------------------------------------------------------------------------
select ing.AINCONSEC Ingreso, pac.PACNUMDOC Identificacion, RTRIM(LTRIM(pac.GPANOMCOM)) Paciente, pro.PSFECINP Fecha_Cirugia
, esp.GEEDESCRI Especialidad, usu.USUNOMBRE Usuario_Programa
, pro.PSOBSERV Observación, case(pro.PSESTADO) when 0 then 'Programada' when 1 then 'Cumplida' when 2 then 'Cancelada'
               when 3 then 'Reprogramada' when 4 then 'Incumplida' when 5 then 'Anulada' else 'Otro' End Estado
, med.GMENOMCOM Usuario_Cumple, enf.HCRHORREG Hora_Cumplida
from dgempres01..PCNPROSAL pro inner join dgempres01..ADNINGRESO ing on ing.OID=pro.ADNINGRESO and pro.GENPACIEN=ing.GENPACIEN
inner join dgempres01..GENPACIEN pac on ing.GENPACIEN=pac.OID and pro.GENPACIEN=pac.OID
inner join dgempres01..PCNPROCIRNOT nota ON nota.PCNPROSAL=pro.OID
inner join dgempres01..HCNPROCIRENF enf  ON nota.HCNPROCIRENF=enf.OID and enf.PCNPROSAL=pro.OID
inner join DGEMPRES01..GENESPECI esp     ON pro.GENESPECI=esp.OID
inner join DGEMPRES01..GENUSUARIO usu    ON pro.GENUSUARIO1=usu.OID
inner join DGEMPRES01..GENMEDICO med     ON enf.GENMEDICO=med.OID
where pro.PSFECINP >= @fch_inicio AND
      pro.PSFECINP <= @fch_fin       
Order By pro.OID
-------------------------------------------------------------------------------------------------------------------------------------