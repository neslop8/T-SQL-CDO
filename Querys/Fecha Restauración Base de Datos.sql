------------------------------------------------------------------------------------------------------------
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
------------------------------------------------------------------------------------------------------------
declare @DB sysname = 'DgEmpres05';
select * from msdb.dbo.restorehistory where destination_database_name = @DB order by 1 desc
------------------------------------------------------------------------------------------------------------
declare @DB sysname = 'DgEmpres02';
select top 1 * from msdb.dbo.restorehistory 
where destination_database_name=@DB
order by restore_history_id desc 
------------------------------------------------------------------------------------------------------------
declare @DB sysname = 'DgEmpres02';
SELECT  top 5 [rs].[destination_database_name] ,
        [rs].[restore_date] ,
        [bs].[backup_start_date] ,
        [bs].[backup_finish_date] ,
        [bs].[database_name] AS [source_database_name] ,
        [bmf].[physical_device_name] AS [backup_file_used_for_restore]
FROM    msdb..restorehistory rs
        INNER JOIN msdb..backupset bs ON [rs].[backup_set_id] = [bs].[backup_set_id]
        INNER JOIN msdb..backupmediafamily bmf ON [bs].[media_set_id] = [bmf].[media_set_id]
where destination_database_name=@DB
ORDER BY [rs].[restore_date] DESC
------------------------------------------------------------------------------------------------------------