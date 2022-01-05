CREATE TABLE #sp_who2 (SPID INT,Status VARCHAR(255),
      Login  VARCHAR(255),HostName  VARCHAR(255), 
      BlkBy  VARCHAR(255),DBName  VARCHAR(255), 
      Command VARCHAR(255),CPUTime INT, 
      DiskIO INT,LastBatch VARCHAR(255), 
      ProgramName VARCHAR(255),SPID2 INT, 
      REQUESTID INT) 
INSERT INTO #sp_who2 EXEC sp_who2
SELECT * FROM #sp_who2
-- A�adimos los filtros aqui :
WHERE       HostName like '%ADM-SIS-009%'
-- A�adimos el order  by aqui :
ORDER BY DBName ASC
--Importante borrar la table temporal :
DROP TABLE #sp_who2