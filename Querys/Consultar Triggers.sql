use DGEMPRES25
----------------------------------------------------------------------------------------Triggers
SELECT   ServerName   = @@servername,   DatabaseName = db_name(),   SchemaName   = isnull( s.name, '' ),
   TableName    = isnull( o.name, 'DDL Trigger' ),   TriggerName  = t.name,    Defininion   = object_definition( t.object_id )
   FROM sys.triggers t LEFT JOIN sys.all_objects o ON t.parent_id = o.object_id
   LEFT JOIN sys.schemas s ON s.schema_id = o.schema_id
ORDER BY SchemaName, TableName, TriggerName
----------------------------------------------------------------------------------------
SELECT * FROM sys.sql_modules 

use CDO02_21
EXEC SP_HELPTEXT @objname = 'pe_invocar_url'

drop proc sp_desconfirma_hepicrisis
----------------------------------------------------------------------------------------Procedimientos
SELECT ROUTINE_NAME FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE ROUTINE_TYPE = 'PROCEDURE'
   ORDER BY ROUTINE_NAME 
----------------------------------------------------------------------------------------
SELECT ROUTINE_NAME FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE ROUTINE_TYPE = 'FUNCTION'
   ORDER BY ROUTINE_NAME 
----------------------------------------------------------------------------------------