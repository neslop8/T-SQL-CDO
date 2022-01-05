IF OBJECT_ID('tempdb..#ordenes') IS NOT NULL
BEGIN
	DROP TABLE #ordenes
END 
	
-- tabla de ordenes de servicio
CREATE TABLE #ordenes (
	 GENMANSER INT
	,GENMANTAR INT
	,SMTFECINI DATETIME
	,SMTFECFIN DATETIME
	,SMTVALSER MONEY
);

DECLARE @GENMANSER INT;

DECLARE CABECERA CURSOR STATIC FOR
SELECT 
	GENMANSER1
FROM
	DGEMPRES01..GENMANTAR tar INNER JOIN DGEMPRES01..GENMANSER ser ON tar.GENMANSER1=ser.OID
    WHERE ser.GENMANUAL1=7 --and tar.GENMANSER1=30363
GROUP BY
	GENMANSER1
HAVING COUNT(GENMANSER1) > 1

OPEN CABECERA
FETCH NEXT FROM CABECERA INTO @GENMANSER

WHILE @@FETCH_STATUS = 0
BEGIN
		DECLARE @GENMANTAR INT, @SMTFECINI DATETIME, @SMTFECFIN DATETIME, @SMTVALSER MONEY
		
		DECLARE DETALLE CURSOR STATIC FOR 
		SELECT OID AS GENMANTAR, SMTFECINI, SMTFECFIN, SMTVALSER
		FROM
			DGEMPRES01..GENMANTAR
		WHERE
			GENMANSER1 = @GENMANSER
		ORDER BY
			SMTFECINI ASC

		OPEN DETALLE
		FETCH NEXT FROM DETALLE INTO @GENMANTAR, @SMTFECINI, @SMTFECFIN, @SMTVALSER
		IF @@CURSOR_ROWS > 1
			BEGIN
				WHILE @@FETCH_STATUS = 0
				BEGIN
				
					IF NOT EXISTS(SELECT GENMANTAR FROM #ordenes WHERE GENMANTAR = @GENMANTAR)
					BEGIN
						IF EXISTS(SELECT OID FROM GENMANTAR WHERE GENMANSER1=@GENMANSER and OID>@GENMANTAR and ((SMTFECINI between @SMTFECINI and @SMTFECFIN) or (SMTFECFIN between @SMTFECINI and @SMTFECFIN)))
						BEGIN
							INSERT INTO #ordenes(GENMANSER, GENMANTAR, SMTFECINI, SMTFECFIN, SMTVALSER) VALUES(@GENMANSER, @GENMANTAR, @SMTFECINI, @SMTFECFIN, @SMTVALSER)
						END
					END

					FETCH NEXT FROM DETALLE INTO @GENMANTAR, @SMTFECINI, @SMTFECFIN, @SMTVALSER
				END
			END
		CLOSE DETALLE
		DEALLOCATE DETALLE
		
	FETCH NEXT FROM CABECERA INTO @GENMANSER
END 

CLOSE CABECERA
DEALLOCATE CABECERA

SELECT 
	#ordenes.GENMANSER
	,#ordenes.GENMANTAR
	,GENMANUAL.GENMANUAL
	,GENSERIPS.SIPCODIGO
	,GENSERIPS.SIPNOMBRE
	,#ordenes.SMTFECINI
	,#ordenes.SMTFECFIN
FROM 
	#ordenes 
	INNER JOIN DGEMPRES01..GENMANSER ON GENMANSER.OID = #ordenes.GENMANSER
	INNER JOIN DGEMPRES01..GENSERIPS ON GENSERIPS.OID = GENMANSER.GENSERIPS1
	INNER JOIN DGEMPRES01..GENMANUAL ON GENMANUAL.OID = GENMANSER.GENMANUAL1
ORDER BY 
	GENMANSER
	,SMTFECINI desc