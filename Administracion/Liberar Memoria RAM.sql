-----------------------------------------------------------------------------------------------------------------------------------------------
--Para configurar 'max server memory' ejecutaremos:
sp_configure 'show advanced options', 1;
GO
RECONFIGURE;
GO
sp_configure 'max server memory', 34000;
GO
RECONFIGURE;
GO
-----------------------------------------------------------------------------------------------------------------------------------------------
sp_configure 'show advanced options', 1;
GO
RECONFIGURE;
GO
sp_configure 'max server memory', 20000;
GO
RECONFIGURE;
GO
-----------------------------------------------------------------------------------------------------------------------------------------------
sp_configure 'show advanced options', 1;
GO
RECONFIGURE;
GO
sp_configure 'max server memory', 59000;
GO
RECONFIGURE;
GO
-----------------------------------------------------------------------------------------------------------------------------------------------
sp_who3 lock
-----------------------------------------------------------------------------------------------------------------------------------------------