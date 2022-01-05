USE DGEMPRES21;
DECLARE @activa BIT = 0;

DECLARE @object_id INT
DECLARE @triguer VARCHAR(100)
DECLARE @tabla VARCHAR(100)
DECLARE @base VARCHAR(100)
	
IF @activa = 0 --Apagar los triggers
BEGIN
	-- borramos la tabla para agregar los triggers a apagar
	DELETE FROM CDO02_21..sis_Triggers_Apagados;
	
	INSERT INTO CDO02_21..sis_Triggers_Apagados (object_id,triguer,tabla,base)
	SELECT 
		triggers.object_id
		,triggers.name AS triguer
		,tables.name AS tabla
		,'DGEMPRES21'
	FROM 
		sys.triggers AS triggers
		INNER JOIN sys.tables AS tables ON tables.object_id = triggers.parent_id
	WHERE 
		is_disabled = 0
	ORDER BY 
		tabla
	
	DECLARE CRTRIGUERS CURSOR FOR
	SELECT 
		object_id
		,triguer
		,tabla
		,base
	FROM 
		CDO02_21..sis_Triggers_Apagados 
	ORDER BY 
		tabla
		
	OPEN CRTRIGUERS
	FETCH NEXT FROM CRTRIGUERS INTO @object_id, @triguer, @tabla, @base
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
		
		EXEC ('ALTER TABLE '+@tabla+' DISABLE TRIGGER '+@triguer) ;  
		
		FETCH NEXT FROM CRTRIGUERS INTO @object_id, @triguer, @tabla, @base
	END 
	
	CLOSE CRTRIGUERS;
	DEALLOCATE CRTRIGUERS;
	
END
    
IF @activa = 1 --Prender los triggers
BEGIN
    DECLARE CRTRIGUERS CURSOR FOR
	SELECT 
		object_id
		,triguer
		,tabla
		,base
	FROM 
		CDO02_21..sis_Triggers_Apagados 
	ORDER BY 
		tabla
		
	OPEN CRTRIGUERS
	FETCH NEXT FROM CRTRIGUERS INTO @object_id, @triguer, @tabla, @base
	
	DECLARE @i INT = 1 
	WHILE @@FETCH_STATUS = 0
	BEGIN
		
		PRINT @i;
		PRINT @tabla;
		EXEC ('ENABLE TRIGGER '+@triguer+' ON '+@tabla) ;  
		
		FETCH NEXT FROM CRTRIGUERS INTO @object_id, @triguer, @tabla, @base
		
		SET @i = @i + 1;
	END 
	
	CLOSE CRTRIGUERS;
	DEALLOCATE CRTRIGUERS;
   
END