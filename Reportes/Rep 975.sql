-------------------------------------------------------------------------------------------------------------------------------
use OCCUBQOCOMMPACS
-------------------------------------------------------------------------------------------------------------------------------
declare @fch_inicio datetime = '2016-01-10 00:00:00'
declare @fch_fin    datetime = '2016-03-10 23:59:59'
-------------------------------------------------------------------------------------------------------------------------------
SELECT PatientIdentificationsNumber,PatientFirstName,PatientLastName,DateLastAttempt,
CreationDate, AETitle,Modality 
FROM  OCCUBQOCOMMPACS.Ubiquo.StudiesReceiveds 
where Modality='CT' 
and CreationDate >=  @fch_inicio
and CreationDate <=  @fch_fin
order by DateLastAttempt desc
-------------------------------------------------------------------------------------------------------------------------------
sp_who3 lock