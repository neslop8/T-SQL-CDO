---------------------Consultar Identity
SELECT IDENT_CURRENT ('ADNCENATE') AS Current_Identity;  
GO
---------------------Asignar Maximo Identity a la variable
declare @max_oid int
set @max_oid = (select max(oid) from @max_oid)
DBCC CHECKIDENT ('@max_oid', RESEED, @max_oid);
GO
---------------------Resetear el Identity
DBCC CHECKIDENT ('TABLA', RESEED, @max_oid);
GO
---------------------Consultar Identity
SELECT IDENT_CURRENT ('ADNCENATE') AS Current_Identity;  
GO
---------------------------------------------------------------------