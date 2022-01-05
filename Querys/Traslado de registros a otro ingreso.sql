--------------------------------------------------------------------------------------------------------------------
USE DGEMPRES21
-----pasar de 2128872 al 2130450
-----pasar de 1770979 al 1772454
select top 5 * from DGEMPRES21..ADNINGRESO where AINCONSEC in (1770979, 1772454)

select * from DGEMPRES21..SLNORDSER where ADNINGRES1 in (2128872, 2130450)  and SOSMODULO in (2)
select * from DGEMPRES21..SLNSERPRO where ADNINGRES1 in (2128872, 2130450) and SLNORDSER1 in (select OID from DGEMPRES21..SLNORDSER where ADNINGRES1 in (2128872, 2130450)  and SOSMODULO in (2))
select * from INNCSUMPA where SLNORDSER in (select OID from DGEMPRES21..SLNORDSER where ADNINGRES1 in (2128872, 2130450)  and SOSMODULO in (2))
select * from INNMSUMPA where inncsumpa in (select OID from INNCSUMPA where SLNORDSER in (select OID from DGEMPRES21..SLNORDSER where ADNINGRES1 in (2128872, 2130450)  and SOSMODULO in (2)))
select top 5 * from INNMDESUM where INNMSUMPA in (select OID from INNMSUMPA where inncsumpa in (select OID from INNCSUMPA where SLNORDSER in (select OID from DGEMPRES21..SLNORDSER where ADNINGRES1 in (2128872, 2130450)  and SOSMODULO in (2))))

-----pasar de 2128872 al 2130450
-----pasar de 1770979 al 1772454
select top 5 * from DGEMPRES21..ADNINGRESO where AINCONSEC in (1770979, 1772454)
--------------------------------------------------------------------------------------------------------------------
begin tran xxx
update DGEMPRES21..SLNORDSER set ADNINGRES1=2130450 where ADNINGRES1 in (2128872, 2130450)  and SOSMODULO in (2)
update DGEMPRES21..SLNSERPRO set ADNINGRES1=2130450 where ADNINGRES1 in (2128872, 2130450) and SLNORDSER1 in (select OID from DGEMPRES21..SLNORDSER where ADNINGRES1 in (2128872, 2130450)  and SOSMODULO in (2))
update DGEMPRES21..INNCSUMPA set ADNINGRESO=2130450 where SLNORDSER in (select OID from DGEMPRES21..SLNORDSER where ADNINGRES1 in (2128872, 2130450)  and SOSMODULO in (2))
update DGEMPRES21..INNCDESUM set ADNINGRESO=2130450 where OID in (6194164)
commit tran xxx
rollback tran xxx
--------------------------------------------------------------------------------------------------------------------