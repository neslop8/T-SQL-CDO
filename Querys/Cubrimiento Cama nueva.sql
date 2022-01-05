use dgempres01
select top 5 * from HPNDEFCAM where HCACODIGO IN ('340a','340B')
select * from HPNMANUALCAM where HPNDEFCAM IN (86, 470)

begin tran xxx
insert into HPNMANUALCAM (GENPLAPRO, HPNDEFCAM, GENSERIPS, GENSERIPS2, OptimisticLockField)
select GENPLAPRO, 470, GENSERIPS, GENSERIPS2, OptimisticLockField
from DGEMPRES01..HPNMANUALCAM where HPNDEFCAM=86 and GENPLAPRO <> 7
commit tran xxx

