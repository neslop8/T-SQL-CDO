select top 5 * from HCNCTRLIMP where HCCOIDDOC=5796374
select top 5 * from HCNMEDPAC where HCNFOLIO=5796374
select top 5 * from HCNCONMED order by OID desc
select top 5 * from HCNCONMED where HCNMEDPAC=12224356
select top 5 * from GENPACIEN where PACNUMDOC='52969615'-----810821
select top 5 * from HCNFOLIO where GENPACIEN=810821 and HCNUMFOL=25

select top 5 * from HCNSOLMED where HCNFOLIO=5796374
select top 5 * from HCNSOLMEDD

select top 5 * from HCNSOLMEDD

select top 5 * from HCNCTRLIMP where HCCOIDDOC=5796374

begin tran xxx
update HCNCTRLIMP set HCCCANTIMP=6 where HCCOIDDOC=5796374
commit tran xxx