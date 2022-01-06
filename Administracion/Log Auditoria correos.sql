--------------------------------------------------------------------------
----SENT MESSAGES LOG
SELECT TOP 20 *
FROM [msdb].[dbo].[sysmail_sentitems]
ORDER BY [send_request_date] DESC
----FAILED MESSAGES LOG
SELECT TOP 40 *
FROM [msdb].[dbo].[sysmail_faileditems]
ORDER BY [send_request_date] DESC
----ALL MESSAGES – REGARDLESS OF STATUS
SELECT TOP 20 *
FROM [msdb].[dbo].[sysmail_allitems]
ORDER BY [send_request_date] DESC
--------------------------------------------------------------------------