use DGEMPRES21
select * from HCNTIPHIS

------------------------------------------------------------------------------------------------------
declare @search varchar(50)
SET @search = 'HCNTHAUTOR'
-------------------------
SELECT *
FROM 
INFORMATION_SCHEMA.ROUTINES
WHERE 
ROUTINE_DEFINITION LIKE '%' + @search + '%'
AND ROUTINE_TYPE ='PROCEDURE'
ORDER BY
ROUTINE_NAME
------------------------------------------------------------------------------------------------------
--select HCOBLIGA, * from HCNTIPHIS where OID >= 45
------------------------------------------------------------------------------------------------------
select * from HCNTHAUTOR