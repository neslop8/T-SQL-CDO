-------------------------------------------------------------------------------------------------------------------------------------
Select ips.SIPCODIGO Codigo, ips.SIPNOMBRE Servicio, ips.OID id, CASE ips.SIPESTADO When 0 Then 'Inactivo' else 'Activo' end Estado
, CASE ips.SIPPOS When 0 Then 'No' else 'Si' end Pos, CASE ips.siptipser When 1 Then 'No_Qx' When 2 then 'Qx' else 'Paquete' end Tipo
, gru.GGRCODIGO Cod_Gru, gru.GGRNOMBRE Grupo, sub.GSUCODIGO Cod_Sub, sub.GSUNOMBRE Subgrupo
, con.GCFCODIGO Cod_Con, con.GCFNOMBRE Concepto, CASE man.GENTIPREG When 1 Then 'ISS_2001' When 2 Then 'SOAT' else 'ISS_2004' end Manual
, ser.SMSPUNSER UVR
from DgEmpres21..Genserips ips inner join DgEmpres21..Gengrupos gru on ips.GENGRUPOS1=gru.oid
inner join DgEmpres21..GENSUBGRU sub on ips.GENSUBGRU1=sub.OID
inner join DgEmpres21..GENCONFAC con on ips.GENCONFAC1=con.OID
left join DgEmpres21..GENMANSER ser on ser.GENSERIPS1=ips.OID
left join DgEmpres21..GENMANUAL man on ser.genmanual1=man.oid
where GENSUBGRU1 <> 175 and ips.SIPCODIGO='540013'
group by 
ips.SIPCODIGO, ips.SIPNOMBRE, ips.OID, ips.SIPESTADO, ips.SIPPOS, ips.siptipser, gru.GGRCODIGO, gru.GGRNOMBRE
, sub.GSUCODIGO, sub.GSUNOMBRE, con.GCFCODIGO, con.GCFNOMBRE,man.GENTIPREG, ser.SMSPUNSER
order by ips.SIPCODIGO
-------------------------------------------------------------------------------------------------------------------------16013;482669
--select * from DGEMPRES21..GENSERIPS where sipcodigo in ('T549002','549002')
--select * from DGEMPRES21..GENMANSER where GENSERIPS1 in (1315, 36142)
--select * from dgempres22..genmanual where GENSERIPS1=36142
-------------------------------------------------------------------------------------------------------------------------------------
select * from DGEMPRES21..GENSERIPS where GENGRUPOS1=14
select * from DGEMPRES21..GENSERIPS where SIPCODIGO='360101'
select * from DGEMPRES21..GENSERIPS where SIPCODIGO like '%H'
select * from DGEMPRES21..GENMANSER where GENSERIPS1=4732
select * from DGEMPRES21..GENMANSER where GENSERIPS1 in (select OID from DGEMPRES21..GENSERIPS where GENGRUPOS1=14) and SMSPUNSER > 0

begin tran xxx
update DGEMPRES21..GENMANSER set SMSPUNSER=0 where GENSERIPS1 in (select OID from DGEMPRES21..GENSERIPS where SIPCODIGO like '%H') and SMSPUNSER > 0
commit tran xxx
rollback tran xxx
-------------------------------------------------------------------------------------------------------------------------------------
