use CDO02_21
select * from cfg_usuario_area_servicio where usuario=770

select top 5 * from DGEMPRES21..GENUSUARIO where USUNOMBRE in ('CPPACHECO', 'CDOMINGUEZ')
select top 5 * from DGEMPRES21..GENUSUARIO where USUDESCRI like '%Akemy%'
-------------------------------------------------------------------------------------------------------------------------
select * from CDO02_21..rep_consulta_usuario where usuario in (2420, 3295)
select * from CDO02_22..rep_consulta_usuario where usuario in (517, 2831)
-------------------------------------------------------------------------------------------------------------------------
begin tran xxx
declare @old int, @new int
select @old = id from CDO02_21..cfg_usuario where codigo in ('CPPACHECO')
select @new = id from CDO02_21..cfg_usuario where codigo in ('CDOMINGUEZ')
-------------------------------------------------------------------------------------------------------------------------
--delete rep_consulta_usuario where usuario in (@old)
-------------------------------------------------------------------------------------------------------------------------
insert into CDO02_21..rep_consulta_usuario select consulta, @new, consulta, editable from CDO02_22..rep_consulta_usuario where usuario=@old
commit tran xxx
-------------------------------------------------------------------------------------------------------------------------