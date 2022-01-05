select * from GENWIDACCE
select top 5 * from COMACCEDIR order by OID desc
select * from COMACCEDIR where comusuario=748
select * from COMACCEDIR where ACCMODULO='HC'

select top 5 * from GENROL where ROLNOMBRE like '%admin%'
select top 5 * from GENROL where OID=36

select * from COMACCEDIR where ACCMODULO='HC' and COMUSUARIO in (
select OID from GENUSUARIO where GENROL =72 and USUESTADO=1)

select * from COMACCEDIR where ACCMODULO='HC' and COMUSUARIO in (
select OID from GENUSUARIO where GENROL =36 and USUESTADO=1)

select * from COMACCEDIR where ACCMODULO='HC' and COMUSUARIO in (
select OID from GENUSUARIO where GENROL =3 and USUESTADO=1)

select * from COMACCEDIR where ACCMODULO='HC' and COMUSUARIO in (
select OID from GENUSUARIO where GENROL =78 and USUESTADO=1)

select COUNT(*) from GENUSUARIO where GENROL =78 and USUESTADO=1
select * from GENUSUARIO where GENROL =72 and USUESTADO=1
select * from GENUSUARIO where GENROL in (36, 71, 78) and USUESTADO=1 order by OID asc

begin tran xxx
delete COMACCEDIR where OID in (4480, 4481)
commit tran xxx

select top 5 * from GENROL where ROLNOMBRE like '%lider%'
select * from GENUSUARIO where GENROL in (16, 26, 27, 101) and USUESTADO=1 order by OID desc

insert into COMACCEDIR 
select * from COMACCEDIR where comusuario=10

select * from GENDOCUME 
select * from INNSUPACTING
select * from ADNINGRESO WHERE AINCONSEC=134153

select * from HCNREGENF where OID=242273

begin tran xxx
update ADNINGRESO set AIBLOINMED=0, AIOIDREG=0 WHERE AINCONSEC=134153
commit tran xxx