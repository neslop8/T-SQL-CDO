---------------------------------------------------------------------------------------------
SET STATISTICS IO ON
SET STATISTICS TIME ON
GO
---------------------------------------------------------------------------------------------
declare @producto char(20) = '' 
declare @almacen char(5) = '002' 
---------------------------------------------------------------------------------------------
IF (@almacen = '001')
	BEGIN
		Select ROW_NUMBER() OVER(Order by cpa.Existencia - stock.IPRPTOREP) #_Fila
		, pro.IPRCODIGO Codigo, pro.IPRDESCOR Producto, CONVERT(int, cpa.Existencia) Existencia
		, CONVERT(int, stock.IPRSTKMIN) Minimo, CONVERT(int, stock.IPRSTKMAX) Maximo
		, CONVERT(int, stock.IPRPTOREP) Reposicion
		, CONVERT(int, (stock.IPRPTOREP - cpa.Existencia)) Diferencia
		From DgEmpres01..INNPRODUC pro Inner Join DgEmpres01..INNSTOALM stock On stock.iprproduc=pro.oid
		Inner Join DgEmpres01..INNALMACE alm On stock.ipralmace=alm.OID 
		Outer Apply DGEMPRES01..f_cantidad_producto_almacen(pro.IPRCODIGO, alm.IALCODIGO) cpa
		Where cpa.Existencia < stock.IPRPTOREP and 
		alm.IALCODIGO=@almacen
		and (pro.IPRCODIGO = @producto or @producto='')
		Order by (cpa.Existencia - stock.IPRPTOREP)
	END
ELSE
	BEGIN
		Select ROW_NUMBER() OVER(Order by (((stock.IPRSTKMAX /30)*13) - cpa.Existencia) desc) #_Fila
		, pro.IPRCODIGO Codigo, pro.IPRDESCOR Producto, CONVERT(int, cpa.Existencia) Existencia
		, CONVERT(int, stock.IPRSTKMIN) Minimo, CONVERT(int, stock.IPRSTKMAX) Maximo 
		, CONVERT(int, stock.IPRPTOREP) Reposicion
		, CONVERT(int, (((stock.IPRSTKMAX /30)*13) - cpa.Existencia)) Pedido
		From DgEmpres01..INNPRODUC pro Inner Join DgEmpres01..INNSTOALM stock On stock.iprproduc=pro.oid
		Inner Join DgEmpres01..INNALMACE alm On stock.ipralmace=alm.OID 
		Outer Apply DGEMPRES01..f_cantidad_producto_almacen(pro.IPRCODIGO, alm.IALCODIGO) cpa
		Where --cpa.Existencia < stock.IPRPTOREP and 
		alm.IALCODIGO=@almacen
		and (pro.IPRCODIGO = @producto or @producto='')
		Order by (((stock.IPRSTKMAX /30)*13) - cpa.Existencia) desc
	END
---------------------------------------------------------------------------------------------
/*
select * from DGEMPRES01..INNALMACE
select * from DGEMPRES01..INNPRODUC where IPRCODIGO='11121108'
select * from DGEMPRES01..INNFISICO where INNPRODUC=392 and IFICANTID > 0
---------------------------------------------------------------------------------------------
declare @producto char(20) = '11121108' 
declare @almacen char(5) = '002' 
---------------------------------------------------------------------------------------------
select Existencia from DGEMPRES01..f_cantidad_producto_almacen(@producto, @almacen)
---------------------------------------------------------------------------------------------
Select --Sum(fis.IFICANTID) Existencia
fis.IFICANTID Existencia
From DgEmpres01..INNFISICO fis Inner join DgEmpres01..INNPRODUC pro On fis.INNPRODUC=pro.OID		
Inner join DgEmpres01..INNALMACE alm On fis.INNALMACE=alm.OID
Where pro.IPRCODIGO=@producto /*and alm.IALCODIGO=@almacen*/ and fis.IFICANTID > 0
*/
---------------------------------------------------------------------------------------------