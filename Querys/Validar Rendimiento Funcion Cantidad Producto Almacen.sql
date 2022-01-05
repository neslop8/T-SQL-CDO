---------------------------------------------------------------------------------------------
SET STATISTICS TIME ON
SET STATISTICS IO ON
GO
---------------------------------------------------------------------------------------------
declare @producto char(20) = '' 
declare @almacen char(5) = '002' 
---------------------------------------------------------------------------------------------
Select  ISNULL(Sum(fis.IFICANTID), 0) Existencia
From DgEmpres01..INNFISICO fis Inner join DgEmpres01..INNPRODUC pro On fis.INNPRODUC=pro.OID		
Inner join DgEmpres01..INNALMACE alm On fis.INNALMACE=alm.OID
Where (pro.IPRCODIGO=@producto or @producto='')
and (alm.IALCODIGO=@almacen or @almacen='')
and fis.IFICANTID > 0				
---------------------------------------------------------------------------------------------
Select Sum(fis.IFICANTID)
From DgEmpres01..INNFISICO fis Inner join DgEmpres01..INNPRODUC pro On fis.INNPRODUC=pro.OID		
Inner join DgEmpres01..INNALMACE alm On fis.INNALMACE=alm.OID
Where (pro.IPRCODIGO=@producto or @producto='')
and (alm.IALCODIGO=@almacen or @almacen='')
---------------------------------------------------------------------------------------------