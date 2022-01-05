----porcentaje de fragmentación------------------------------------------------------------------
SELECT  OBJECT_NAME(IDX.OBJECT_ID) AS Table_Name, 
IDX.name AS Index_Name, 
IDXPS.index_type_desc AS Index_Type, 
IDXPS.avg_fragmentation_in_percent  Fragmentation_Percentage
FROM sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, NULL) IDXPS 
INNER JOIN sys.indexes IDX  ON IDX.object_id = IDXPS.object_id 
AND IDX.index_id = IDXPS.index_id  --and OBJECT_NAME(IDX.OBJECT_ID)='CMNSOLHISE'
AND OBJECT_NAME(IDX.OBJECT_ID) NOT LIKE 'INKD%' AND IDXPS.avg_fragmentation_in_percent > 30
ORDER BY Fragmentation_Percentage DESC
---------------------------------------------------------------------------------------------------
USE DgEmpres01;
GO
ALTER INDEX ALL ON CHNFACPRO REORGANIZE;---HCNINTERDX, NOMGRUPOAUT, HCNESCDOL, CRNCXCTR
GO

USE DgEmpres01;
GO
ALTER INDEX ALL ON GENCONSEC REBUILD;---AFNMSALDO, CRNRADFACD, AFNCALDEPNI, CHNCOSGAS, CHNSUMCOS
GO
---------------------------------------------------------------------------------------------------
USE DGEMPRES01;   
GO  
-- The following example updates the statistics for all tables in the database.   
EXEC sp_updatestats;  
---------------------------------------------------------------------------------------------------