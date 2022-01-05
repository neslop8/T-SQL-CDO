USE REPORTES
GO

CREATE OR ALTER PROCEDURE MerceUsuarioTarget
    @Codigo integer,
    @Nombre varchar(100),
    @Puntos integer
AS
BEGIN
    MERGE UsuarioTarget AS T
        USING (SELECT @Codigo, @Nombre, @Puntos) AS S 
					   (Codigo, Nombre, Puntos)
		ON (T.Codigo = S.Codigo)
    WHEN MATCHED THEN
        UPDATE SET T.Nombre = S.Nombre,
				   T.Puntos = S.Puntos
    WHEN NOT MATCHED THEN
        INSERT (Codigo, Nombre, Puntos)
        VALUES (S.Codigo, S.Nombre, S.Puntos) ;
END

GO 

select * from UsuarioTarget
exec MerceUsuarioTarget 3,'Roy Rojas R', 9
select * from UsuarioTarget


-----------------------