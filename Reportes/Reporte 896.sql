----------------------------------------------------------------------------------------------------------------------
select emp.oid, emp.empcodigo cedula
,emp.empnombre1 nombre1,emp.empnombre2 nombre2,emp.empapelli1 apellido1,empapelli2 apellido2
, e.grucodigo grupo, e.grunombre nombre_grupo, sub.subcodigo subgrupo,sub.subnombre nombre_subgrupo
, c.iltiempleo tipo,c.ilfecingre fecha_ingreso,c.iltipestem estado,c.ilfecretir fecha_retiro
, d.cccodigo centro_costo,d.ccnombre nombre_centro, car.CANOMBRE, ncar.ILCFECHINI inicio, ncar.ILCFECHTER fin
, CONVERT(char, tel.telefono) telefono
, CONVERT(char, dir.direccion) direccion
from dgempres21..nomempleado emp inner join DGEMPRES21..NOMINFOLAB c		on c.NOMEMPLEA=emp.OID
left join dgempres21..nomsubgru sub on  emp.nomsubgru=sub.oid
left join DGEMPRES21..NOMINLACAR ncar	on ncar.NOMINFOLAB=c.OID
left join DGEMPRES21..NOMCARGO   car	on ncar.NOMCARGO=car.OID
inner join DGEMPRES21..CTNCENCOS d		on sub.CTNCENCOS=d.OID
inner join DGEMPRES21..NOMGRUPO e		on emp.nomgrupo=e.oid
inner join DGEMPRES21..COMTERCERO ter	on emp.OID=ter.OID
OUTER APPLY DGEMPRES21.dbo.f_tel_emp_01(ter.OID) tel
OUTER APPLY DGEMPRES21.dbo.f_dir_emp_01(ter.OID) dir
--where emp.EMPCODIGO='52098608'
order by emp.OID
----------------------------------------------------------------------------------------------------------------------
