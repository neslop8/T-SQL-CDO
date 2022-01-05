use DGEMPRES01
select * from GENUSUARIO
select * from GENVERDLL
select * from GENVERDLLLOG where HOSTNAME='aume19'
select * from GENUSUARIO where OID=3733
select * from GELOG202005 where GENUSUARIO=3733 and AUDFECHA > '20200513'
----------------------------------------------------------------------------------------------------------------------------------
select dll.HOSTNAME Equipo, dll.DIRIPV4 DIR_IP, dll.FECHORDLOC Parche_Equipo, dll.FECHORDACT Parche_Servidor, usu.USUNOMBRE Cod_USU, usu.USUDESCRI ___________Usuario___________
from DGEMPRES21..GENVERDLLLOG dll inner join DGEMPRES21..GENUSUARIO usu ON dll.GENUSUARIO=usu.OID
group by dll.HOSTNAME, dll.DIRIPV4, dll.FECHORDLOC, dll.FECHORDACT, usu.USUNOMBRE, usu.USUDESCRI
----------------------------------------------------------------------------------------------------------------------------------

select * from DGEMPRES01..GENVERDLLLOG where FECHORDLOC = '2021-25-01 08:42:00.000'
select * from DGEMPRES21..GENVERDLLLOG 
select * from DGEMPRES01..GENVERDLLLOG order by FECHORDLOC

begin tran xxx
delete DGEMPRES01..GENVERDLLLOG --where FECHORDLOC > '20210621'
delete DGEMPRES02..GENVERDLLLOG
delete DGEMPRES19..GENVERDLLLOG 
delete DGEMPRES20..GENVERDLLLOG 
delete DGEMPRES21..GENVERDLLLOG 
commit tran xxx
rollback tran xxx

sp_Who3 lock


begin tran xxx
delete DGEMPRES01..GENVERDLLLOG where HOSTNAME='ADM-mer-007'
commit tran xxx


sp_who3 lock