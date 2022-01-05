-----------------------------------------------------------------------------------------------------------------------------------
declare @paciente       char(20) = '20368285'
-----------------------------------------------------------------------------------------------------------------------------------
select cit.CCMPACDOC documento, cit.CCMPACNOM _____paciente_____, esp.GEECODIGO cod_esp ,esp.GEEDESCRI _____especialidad_____
, act.CMANOMBRE _____actividad_____, act.CMACODIGO cod_act, med.GMECODIGO cod_med, med.GMENOMCOM ________medico________
, convert(char, cit.CCMFECCIT, 106) _____fec_cita_____, SUBSTRING(convert(char, cit.CCMFECCIT),12,16) hora
, convert(char, cit.CCMFECASI, 106) fec_asignacion, SUBSTRING(convert(char, CMADURACT),16,2) + ' Min' tiempo
from dgempres21..CMNCITMED cit inner join DGEMPRES21..GENESPECI esp on cit.GENESPECI=esp.OID
inner join DGEMPRES21..CMNTIPACT act on cit.CMNTIPACT=act.OID
inner join DGEMPRES21..GENMEDICO med on cit.GENMEDICO1=med.OID
where cit.CCMPACDOC = @paciente
order by cit.CCMFECCIT desc
-----------------------------------------------------------------------------------------------------------------------------------
select top 5 * from GENMEDICO where GMECODIGO='JARUBIANO'
select * from CMNCITMED where GENMEDICO1=2907
select top 5 * from GENESPECI order by OID desc
select top 5 SUBSTRING(convert(char, CMADURACT),16,2), * from CMNTIPACT order by OID desc
-----------------------------------------------------------------------------------------------------------------------
update CMNCITMED set CCMOBSERV='ALBERTO COLMENARES' where OID=401296
-----------------------------------------------------------------------------------------------------------------------