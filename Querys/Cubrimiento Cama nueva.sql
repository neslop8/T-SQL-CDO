use dgempres01
select top 5 * from HPNDEFCAM where HCACODIGO IN ('441a','441b')
select * from HPNMANUALCAM where HPNDEFCAM IN (100, 471)

begin tran xxx
insert into HPNMANUALCAM (GENPLAPRO, HPNDEFCAM, GENSERIPS, GENSERIPS2, OptimisticLockField)
select GENPLAPRO, 471, GENSERIPS, GENSERIPS2, OptimisticLockField
from DGEMPRES01..HPNMANUALCAM where HPNDEFCAM=100 and GENPLAPRO not in (7, 22)
commit tran xxx

