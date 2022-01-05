use DGEMPRES01
------------------------------------------------------------------------------------------------------------------------------
select * from DGEMPRES01..GENMANUAL where GENMANUAL='FM'-----298
select * from DGEMPRES01..GENPLAPRO where GPPCODIGO='FM'-----263
select top 2 * from DGEMPRES01..INNPRODUC where IPRCODIGO='DM-202050'-----263
select * from DGEMPRES01..INNPROEPS where GENMANUAL=102 and INNPRODUC=9959
select top 5 * from DGEMPRES01..INNMANTAR order by OID desc

select GENMANUAL, INNPRODUC, COUNT(*) from DGEMPRES01..INNPROEPS group by GENMANUAL, INNPRODUC having COUNT(*) > 1
select * from DGEMPRES01..INNPROEPS where GENMANUAL=66
select * from DGEMPRES01..INNMANTAR where INNPROEPS in (select OID from DGEMPRES01..INNPROEPS where GENMANUAL=66)

select top 5 * from DGEMPRES01..INNPRODUC where IPRCODIGO in ('3030441')
select top 5 * from DGEMPRES01..GENMANUAL order by OID desc
select top 5 * from DGEMPRES01..GENPLAPRO where GPPCODIGO='CCE'
select top 5 * from DGEMPRES01..INNPROEPS order by OID desc
select top 5 * from DGEMPRES01..INNMANTAR order by OID desc
select top 5 * from DGEMPRES01..INNPLACUB order by OID desc
--------------------------------------------------------------------------------------------------------------DM-22912014
select pro.iprcodigo, tar.*
/*pro.OID PRODUC, eps.oid PROEPS, tar.OID MANTAR, pro.IPRCODIGO CODIGO, pro.IPRDESCOR PRODUCTO, tar.IMTVALPRO, pro.IPRCOSTPE, man.GENMANUAL
, pro.IPRULCOPE, tar.IMTFECINI, tar.IMTFECFIN, tar.gensalmin, pro.IPRBLOQUEO, man.GENMANUAL
, case(pro.IPRTIPPRO) when 1 then 'I' when 2 then 'P' else 'Otro' end Tipo, pla.IPCACTIVO*/
FROM INNPROEPS eps inner join INNMANTAR tar on tar.INNPROEPS=eps.OID
inner join GENMANUAL man on eps.GENMANUAL=man.OID
inner join INNPRODUC pro on eps.INNPRODUC=pro.OID
--inner join INNPLACUB pla on pla.INNPROEPS=eps.OID
--where --pro.IPRONCOLOG=1 And pro.IPRBLOQUEO=0 and--man.GENMANUAL='FM' And  
where --man.GENMANUAL='FM' --And pro.IPRBLOQUEO=0 And*/ tar.IMTFECFIN >= '2020-30-03 00:00:00' and  tar.IMTFECFIN <= '2020-31-03 23:59:59'
--where pro.IPRBLOQUEO=0 and eps.IPEINACTIVO=0 And pro.IPRCODIGO in ('11103136') and GENSALMIN=1
--where pro.IPRBLOQUEO=0 and eps.IPEINACTIVO=0 and tar.IMTFECFIN > GETDATE() --and tar.IMTVALPRO=0
--and 
tar.IMTFECFIN >= '20211231' and tar.GENSALMIN=2 and tar.IMTFECFIN < GETDATE()
order by 4
/*'DM-22512013','DM-22512014','DM-22512014','DM-22512015','DM-22512015','DM-22512016','DM-22712010','DM-22412006','DM-23512003','DM-23512004',
'DM-23512007','DM-22812021','DM-22812022','DM-22812023','DM-22812024','DM-22812027','DM-22812001','DM-22812002','DM-22812003','11110013',
'11110014','11108004','11110014','11121049','DM-22712007','DM-23112008','DM-23112010','DM-23112029','DM-23412001')*/
--tar.GENSALMIN=13
--and pro.IPRCODIGO in ()
--tar.IMTFECFIN >= '2018-30-01 23:59:59'
--order by 3
group by eps.oid
having COUNT(*) > 1
-------------------------------------------------------------------------------------------------------------------------66119
begin tran xxx
update INNMANTAR set IMTFECFIN='2021-31-12 23:59:59' where OID in (
select tar.OID
FROM INNPROEPS eps inner join INNMANTAR tar on tar.INNPROEPS=eps.OID
inner join GENMANUAL man on eps.GENMANUAL=man.OID
inner join INNPRODUC pro on eps.INNPRODUC=pro.OID
--inner join INNPLACUB pla on pla.INNPROEPS=eps.OID
where tar.IMTFECFIN >= '20211231' and tar.GENSALMIN=2 and tar.IMTFECFIN < GETDATE()
)
commit tran xxx 
rollback tran xxx
------------------------------------------------------------------------------------------------------------------------------
begin tran xxx
update INNPLACUB set IPCACTIVO=1 where OID in (
select pla.OID
FROM INNPROEPS eps inner join INNMANTAR tar on tar.INNPROEPS=eps.OID
inner join GENMANUAL man on eps.GENMANUAL=man.OID
inner join INNPRODUC pro on eps.INNPRODUC=pro.OID
inner join INNPLACUB pla on pla.INNPROEPS=eps.OID
where pro.IPRBLOQUEO=0 and eps.IPEINACTIVO=0 and pro.IPRCODIGO in ('11121063','11121078')
and tar.IMTFECFIN > GETDATE())
commit tran xxx
rollback tran xxx
------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------
begin tran xxx
delete DGEMPRES01..INNMANTAR where OID > 67700
DBCC CHECKIDENT ('DGEMPRES01..INNMANTAR', RESEED, 99392);
commit tran xxx
------------------------------------------------------------------------------------------------------------------------------
DBCC CHECKIDENT ('DGEMPRES01..INNMANTAR', RESEED, 99392);

select * from DGEMPRES01..GENESTRATO
select * from DGEMPRES02..GENESTRATO
