DECLARE @TableName varchar(255)
DECLARE TableCursor CURSOR FOR
SELECT table_name FROM information_schema.tables WHERE table_type = 'BASE TABLE' and table_schema='dbo' AND TABLE_NAME='CHNDISACTI'
OPEN TableCursor
FETCH NEXT FROM TableCursor INTO @TableName
WHILE @@FETCH_STATUS = 0
	BEGIN
	EXEC ('ALTER INDEX ALL ON [' + @TableName + '] REORGANIZE')
	FETCH NEXT FROM TableCursor INTO @TableName
	END
CLOSE TableCursor
DEALLOCATE TableCursor

DECLARE @TableName varchar(255)
DECLARE TableCursor CURSOR FOR
SELECT table_name FROM information_schema.tables WHERE table_type = 'BASE TABLE' and table_schema='dbo'-- AND TABLE_NAME='INNPRODUC'
OPEN TableCursor
FETCH NEXT FROM TableCursor INTO @TableName
WHILE @@FETCH_STATUS = 0
	BEGIN
	EXEC ('ALTER INDEX ALL ON [' + @TableName + '] REBUILD WITH (FILLFACTOR = 80, SORT_IN_TEMPDB = ON, STATISTICS_NORECOMPUTE = ON)')
	FETCH NEXT FROM TableCursor INTO @TableName
	END
CLOSE TableCursor
DEALLOCATE TableCursor