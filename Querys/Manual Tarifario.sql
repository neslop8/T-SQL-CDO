use DGEMPRES01
select genplapro1, * from DGEMPRES01..GENDETCON where GDECODIGO='EPS00501'
select * from DGEMPRES01..GENPLAPRO where oid IN (4)
select * from DGEMPRES01..GENMANUAL where GENMANUAL IN ('640')
select * from DGEMPRES01..GENPLAPRO where GPPCODIGO IN ('640')
select * from DGEMPRES01..GENDETCON where GENPLAPRO1 in (21, 60)
select * from DGEMPRES01..GENPORCIR where GENMANUAL=49
select * from DGEMPRES01..GENSERIPS where SIPCODIGO IN ('906340')
select * from DGEMPRES01..GENMANSER where GENMANUAL1=187
select * from DGEMPRES03..GENMANTAR where GENMANSER1 in (32421, 32438)
select top 5 * from DGEMPRES03..GENMANTAR order by OID desc
select * from DGEMPRES01..GENPLACUB where GENMANSER1 in (33004)

select * from GENSERIPS where OID in (9207, 5500, 5554, 5555, 5569)
select * from GENPAQUET where GENSERIPS1=9207
select * from DGEMPRES01..SLNSERHOJ where GENSERIPS1=9207
select * from DGEMPRES01..SLNPAQHOJ where SLNSERHOJ1 in (select OID from DGEMPRES01..SLNSERHOJ where GENSERIPS1=9207)

begin tran xxx
update DGEMPRES01..GENMANSER set GENSERIPS1=9762 where OID=259261
delete DGEMPRES01..GENMANSER where OID in (259262, 259273, 259280)
delete DGEMPRES01..GENMANTAR where OID in (548438, 548449, 548456)
--delete DGEMPRES01..GENPLACUB where OID > 509452

DBCC CHECKIDENT ('DGEMPRES01..GENMANSER', RESEED, 261911);
DBCC CHECKIDENT ('DGEMPRES03..GENMANTAR', RESEED, 556757);
--DBCC CHECKIDENT ('DGEMPRES01..GENPLACUB', RESEED, 267272);
--rollback tran xxx
--commit tran xxx

update DGEMPRES01..GENMANSER set GENGRUQUI1=  where OID=

select TOP 5 * from DGEMPRES01..GENSALMIN order by OID desc--229321
select TOP 5 * from DGEMPRES01..GENMANSER order by OID desc--229321
select top 5 * from DGEMPRES01..GENMANTAR order by OID desc--238916
select TOP 5 * from DGEMPRES01..GENPLACUB order by OID desc--241930
select TOP 5 * from DGEMPRES01..GENUSUARIO where USUNOMBRE='NFLOPEZ'
select TOP 5 * from DGEMPRES01..GENSERIPS where SIPCODIGO in ('550202H','550202S')
------------------------------------------------------------------------------------------------------------------------------4024
select ips.oid GENSERIPS, ips.SIPCODIGO, ips.SIPTIPSER, tar.*--, cub.GPCACTIVO
/*man.GENMANUAL, tar.OID, ips.sipcodigo, ser.OID, ips.SIPTIPSER, ips.OID, ips.sipcodigo, man.GENNOMBRE, tar.SMTVALSER
, ips.SIPNOMBRE, ser.SMSCODSEE, ser.SMSNOMSEE, ser.SMSPUNSER, ser.GENGRUQUI1, tar.SMTFECINI, tar.SMTFECFIN, tar.SMTVALSER, tar.SMTVALREC
, tar.GENSALMIN1, ips.sipestado--, cub.GPCACTIVO*/
from GENMANSER ser inner join GENMANTAR tar on tar.GENMANSER1=ser.OID
inner join GENMANUAL man on ser.GENMANUAL1=man.OID
inner join GENSERIPS ips on ser.GENSERIPS1=ips.OID --and ips.GENARESER1 in (189, 206)
--inner join GENARESER are on ips.GENARESER1=are.OID 
--inner join GENPLACUB cub  on cub.GENMANSER1=ser.OID
where man.GENMANUAL='C62' AND tar.SMTFECFIN >= GETDATE()
--and ips.OID in (7251, 9762)
--group by ser.SMSTIPLIQ
--order by 4
------------------------------------------------------------------------------------------------------------------------------2019-03-14 23:59:59.000
select * from GENMANUAL where OID in (3,23,4,5,6,7,8,9,24,10,11,12,13,14,15,16,17,18,19,20,21,22,25,26,27,28,29,
30,31,32,33,34,35,36,37,38,39,40,41,42,43,168,169) order by 2
------------------------------------------------------------------------------------------------------------------------------
begin tran xxx
--update GENMANTAR set SMTVALSER=(SMTVALSER * 1.9797), SMTVALREC=(SMTVALREC * 1.9797) where OID in (
update GENMANTAR set SMTVALSER=round(SMTVALSER, -2), SMTVALREC=round(SMTVALREC, -2) where OID in (--SOAT
--update GENMANTAR set SMTVALSER=round(SMTVALSER, 0), SMTVALREC=round(SMTVALREC, 0) where OID in (--ISS
--update DGEMPRES01..GENMANTAR set SMTVALSER=round((SMTVALSER * 0.6), 0), SMTVALREC=round((SMTVALREC * 0.6), 0) where OID in (--ISS
--update GENMANTAR set SMTVALREC=(SMTVALREC * 1.1007), SMTVALSER=(SMTVALSER * 1.1007) where OID in (--ISS
--update GENMANTAR set SMTFECINI='2021-01-03 00:00:02' where OID in (
---update GENMANTAR set SMTFECFIN='2021-01-03 00:00:01' where OID in (
--update GENMANTAR set GENSALMIN1=11 where OID in (
--update GENMANTAR set GENSALMIN1=1 where OID in (
--update GENMANSER set SMSTIPLIQ=2 where OID in (
select tar.OID
from DGEMPRES01..GENMANSER ser inner join DGEMPRES01..GENMANTAR tar on tar.GENMANSER1=ser.OID
inner join DGEMPRES01..GENMANUAL man on ser.GENMANUAL1=man.OID
inner join DGEMPRES01..GENSERIPS ips on ser.GENSERIPS1=ips.OID --and ips.GENARESER1 in (146, 215)
--where man.GENMANUAL='514' AND tar.SMTFECFIN = '2021-09-04 23:59:59'
where man.GENMANUAL='637' AND tar.SMTFECFIN >= GETDATE() and tar.GENSALMIN1=3
)
commit tran xxx
rollback tran xxx
------------------------------------------------------------------------------------------------------------------------------
--select 4209 - 7 = 4291
begin tran xxx
update GENPLACUB set GPCACTIVO=0 where OID in (
select cub.OID
from GENMANSER ser inner join GENMANTAR tar on tar.GENMANSER1=ser.OID
inner join GENMANUAL man on ser.GENMANUAL1=man.OID
inner join GENSERIPS ips on ser.GENSERIPS1=ips.OID
inner join GENPLACUB cub  on cub.GENMANSER1=ser.OID
where ips.SIPCODIGO='890402')
commit tran xxx
rollback tran xxx
------------------------------------------------------------------------------------------------------------------------------
begin tran xxx
update GENPLACUB set GPCACTIVO=1 where OID in (
select cub.OID
from GENMANSER ser inner join GENMANTAR tar on tar.GENMANSER1=ser.OID
inner join GENMANUAL man on ser.GENMANUAL1=man.OID
inner join GENSERIPS ips on ser.GENSERIPS1=ips.OID
inner join GENPLACUB cub  on cub.GENMANSER1=ser.OID
where tar.SMTFECFIN > GETDATE() and man.GENMANUAL='551')
commit tran xxx
rollback tran xxx
------------------------------------------------------------------------------------------------------------------------------
begin tran xxx
delete DGEMPRES01..GENMANTAR where OID>505877
commit tran xxx

DBCC CHECKIDENT ('GENMANSER', RESEED, 261911)
DBCC CHECKIDENT ('dgempres03..GENMANTAR', RESEED, 576498)
------------------------------------------------------------------------------------------------------------------------------
select sipestado, * from GENSERIPS where SIPCODIGO in ('S11301','S11302','S11303','S11304','S12720','S12101','S12102','S12103','S12201','S12202','S12203','S12402')
select * from GENMANUAL where GENMANUAL='551'
select * from GENMANSER where GENMANUAL1=78 and GENSERIPS1 in (select OID from GENSERIPS where SIPCODIGO in ('350100','350200','350300','350400','354200','358303','360401','360500','372200','373401','373402'))
select * from GENPLACUB where GENMANSER1 in (select OID from GENMANSER where GENMANUAL1=78 and GENSERIPS1 in (select OID from GENSERIPS where SIPCODIGO in ('350100','350200','350300','350400','354200','358303','360401','360500','372200','373401','373402')))
select * from GENPLACUB where GENPLAPRO1=51 and GPCACTIVO=0
begin tran xxx
update DGEMPRES21..GENSERIPS set SIPESTADO=1 where SIPCODIGO in ('S11301','S11302','S11303','S11304','S12720','S12101','S12102','S12103','S12201','S12202','S12203','S12402')
--delete GENPLACUB where GENPLAPRO1=51 and GPCACTIVO=0
--delete GENPLACUB where GENMANSER1 in (select OID from GENMANSER where GENMANUAL1=78 and GENSERIPS1 in (select OID from GENSERIPS where SIPCODIGO in ('350100','350200','350300','350400','354200','358303','360401','360500','372200','373401','373402')))
commit tran xxx
rollback tran xxx
DBCC CHECKIDENT ('dgempres01..GENMANSER', RESEED, 228251);
------------------------------------------------------------------------------------------------------------------------------
select * from GENPLAPRO where GPPCODIGO in ('500','505','506','508','509','513','514','523','524','525','530','540','541','544','549','550','551','560','561','566'
,'567','568','570','581','583','585','586','589','590','592','593','598','599','608','609','610','611','615','616','617','619','620')
------------------------------------------------------------------------------------------------------------------------------
exec sp_executesql N'select top 1 count(*) from "dbo"."SLNPAQHOJ" N0
where @p0 in (N0."GENPAQUET1")',N'@p0 int',@p0=14883

exec sp_executesql N'select top 1 count(*) from "dbo"."SLNANPAHO" N0
where @p0 in (N0."GENPAQUET1")',N'@p0 int',@p0=14883

exec sp_executesql N'select top 1 count(*) from "dbo"."SLNPQSECI" N0
where @p0 in (N0."GENPAQUET")',N'@p0 int',@p0=14883

begin tran xxx
DBCC CHECKIDENT ('DgEmpres01..GenManTar', RESEED, 248665);
delete dgempres01..genmantar where oid >= 484373
DBCC CHECKIDENT ('DgEmpres01..GenManser', RESEED, 248665);
commit tran xxx

sp_who3 lock

update GENMANTAR set SMTFECFIN='2021-10-04 00:00:01' where OID=	521257

select TOP 5 * from DGEMPRES01..GENMANUAL where GENMANUAL IN ('640','514')
select * from DGEMPRES01..GENPORCIR where GENMANUAL IN (192)

begin tran xxx
delete DGEMPRES01..GENPORCIR where GENMANUAL IN (192)
commit tran xxx

select * from DGEMPRES01..GENPORCIR where GENMANUAL IN (7)

begin tran xxx
insert into DGEMPRES01..GENPORCIR(GENMANUAL, GPCTIPINT, GPCPORCIR, GPCPORANE, GPCPORAYU, GPCPORSAL, GPCPORMAT, GPCPORPAQ, GPCPRI100, GPCADICIR, GPCADIANE, GPCADIAYU, GPCADISAL, GPCADIMAT, GPCADIPAQ, GPCESPCIR, GPCESPANE, GPCESPAYU, GPCESPSAL, GPCESPMAT, OptimisticLockField)
select 192, GPCTIPINT, GPCPORCIR, GPCPORANE, GPCPORAYU, GPCPORSAL, GPCPORMAT, GPCPORPAQ, GPCPRI100, GPCADICIR, GPCADIANE, GPCADIAYU, GPCADISAL, GPCADIMAT, GPCADIPAQ, GPCESPCIR, GPCESPANE, GPCESPAYU, GPCESPSAL, GPCESPMAT, 69
from DGEMPRES01..GENPORCIR where GENMANUAL IN (7)
commit tran xxx