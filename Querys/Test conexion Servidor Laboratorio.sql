DECLARE @ServerName sysname
DECLARE @a int
SET @ServerName = '192.168.74.210'
	EXEC @a = sys.sp_testlinkedserver @servername = @ServerName
	IF @a = 0
		BEGIN
			print 'LINKED SERVER ''' + ISNULL(@ServerName,'') + ''' IS CONNECTED.'
 	    END
	ELSE
			print 'LINKED SERVER ''' + ISNULL(@ServerName,'') + ''' IS NOT CONNECTED!'