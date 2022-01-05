----------------------------Progreso de Restore y Backup
SELECT
    dm_er.session_id id_Sesion,
    dm_er.command Comando,
    CONVERT(NUMERIC(6, 2), dm_er.percent_complete) AS [Porcentaje Completedo],
    CONVERT(VARCHAR(20), Dateadd(ms, dm_er.estimated_completion_time, Getdate()),20) AS [Tiempo Estimado Finalizacion],
    CONVERT(NUMERIC(6, 2), dm_er.estimated_completion_time / 1000.0 / 60.0) AS [Minutos pendientes]
FROM
    sys.dm_exec_requests dm_er
WHERE  
    dm_er.command IN ( 'RESTORE VERIFYON', 'RESTORE DATABASE','BACKUP DATABASE','RESTORE LOG','BACKUP LOG', 'RESTORE HEADERON' )
--------------------------------------------------------------------------------------------------------------------------------
/*ALTER DATABASE DgEmpres25 SET SINGLE_USER;
GO
DBCC CHECKDB (DgEmpres25, REPAIR_ALLOW_DATA_LOSS) WITH NO_INFOMSGS;
GO

ALTER DATABASE DgEmpres25 SET MULTI_USER;
GO
--------------------------------------------------------------------------------------------------------------------------------
USE master
GO
EXEC SP_CONFIGURE 'Allow updates',1
GO
RECONFIGURE WITH OVERRIDE
GO
EXEC sp_resetstatus 'DgEmpres25'
GO
DBCC DBRECOVER('DgEmpres25')
GO
USE master
GO
EXEC SP_CONFIGURE 'Allow updates',0
GO
RECONFIGURE WITH OVERRIDE
GO
--------------------------------------------------------------------------------------------------------------------------------*/
--Fecha de Restauracion
WITH LastRestores AS
(
SELECT
    DatabaseName = [d].[name] ,
    [d].[create_date] ,
    [d].[compatibility_level] ,
    [d].[collation_name] ,
    r.*,
    RowNum = ROW_NUMBER() OVER (PARTITION BY d.Name ORDER BY r.[restore_date] DESC)
FROM master.sys.databases d
LEFT OUTER JOIN msdb.dbo.[restorehistory] r ON r.[destination_database_name] = d.Name
)
SELECT *
FROM [LastRestores]
WHERE [RowNum] = 1
--------------------------------------------------------------------------------------------------------------------------------