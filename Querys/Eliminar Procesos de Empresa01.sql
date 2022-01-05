USE DGEMPRES01
--Eliminar Procesos a todos los Roles
select * from GENROL
select * from GENROLPER where GENROL=38 and PERNOMBRE='Procesos'

select * from DGEMPRES01..GENROLPER where PERPADRE in ('AD2','AF2','CH2','CM2','CO2','CP2','CR2','CT2','FA2','HC2'
,'HP2','IN2','MA2','NO2','PC2','PG2','TS2') and PEROPCION<>PERPADRE and GENROL > 2

begin tran xxx--Eliminar permisos de procesos a Roles diferentes de 
update DGEMPRES01..GENROLPER set PERACCION1=0, PERACCION2=0, PERACCION3=0, PERACCION4=0, PERACCION5=0, PERACCION6=0,
PERACCION7=0, PERACCION8=0, PERACCION9=0, PERACCION10=0, PERACCION11=0 where PERPADRE in (
'AD2','AF2','CH2','CM2','CO2','CP2','CR2','CT2','FA2','HC2','HP2','IN2','MA2','NO2','PC2','PG2','TS2') and PEROPCION<>PERPADRE and GENROL > 2
commit tran xxx


