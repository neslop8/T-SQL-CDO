Select top 50 id_solicitud, * from OCCIDENTEUBQO..ubq_occi order by 1 desc

Select * from OCCIDENTEUBQO..ubq_occi where identificacion='39649704'

Select * from OCCIDENTECOMMPACS.Ubiquo.Logs
Select * from OCCIDENTEGENERALPACS.Ubiquo.Logs

delete OCCIDENTECOMMPACS.Ubiquo.Logs where DATEDIFF(DD, CreationDate, getdate())  > 2

delete OCCIDENTEGENERALPACS.Ubiquo.Logs where DATEDIFF(DD, CreationDate, getdate())  > 2

begin tran xxx
delete OCCIDENTECOMMPACS.Ubiquo.Logs
delete OCCIDENTEGENERALPACS.Ubiquo.Logs
commit tran xxx