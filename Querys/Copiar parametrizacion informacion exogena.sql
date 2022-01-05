use dgempres15
select * from dgempres15..CTNINFEXCO
select * from dgempres15..CTNINEXCOC

select COUNT(*) from DGEMPRES21..CTNINFEXCO
select COUNT(*) from dgempres16..CTNINFEXCO

select COUNT(*) from dgempres21..CTNINFOEXO
select COUNT(*) from dgempres16..CTNINFOEXO

select COUNT(*) from dgempres21..CTNINFEXVA
select COUNT(*) from dgempres16..CTNINFEXVA

select COUNT(*) from DGEMPRES21..CTNINEXCOC
select COUNT(*) from dgempres16..CTNINEXCOC



select * from dgempres16..CTNINEXCOC
select * from dgempres21..CTNINEXCOC

begin tran xxx
insert into DGEMPRES21..CTNINEXCOC select * from dgempres16..CTNINEXCOC where OID > 3
commit tran xxx

select * from sys.servers
select * from sp_addlinkedserver 

select COUNT(*) from GEAUDITI