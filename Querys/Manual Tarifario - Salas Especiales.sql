select top 5 * from GENMANUAL where GENMANUAL in ('514','ONC')
select * from GENSALUVR where GENMANUAL1=7

begin tran xxx
Insert Into GENSALUVR (GENMANUAL1, GUSTIPSAL, GENRANUVR1, GENSERIPS1, OptimisticLockField)
select 169, GUSTIPSAL, GENRANUVR1, GENSERIPS1, OptimisticLockField from GENSALUVR where GENMANUAL1=7
commit tran xxx