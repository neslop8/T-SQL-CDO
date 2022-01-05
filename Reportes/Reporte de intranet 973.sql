use DGEMPRES21
select top 5 GENMEDICO, GENMEDICO1, * from HCNEPICRI where HCECONSEC=186912

update HCNEPICRI set HCEESTDOC=0 where HCECONSEC=186912

update HCNEPICRI set GENMEDICO=540, GENMEDICO1=540 where HCECONSEC=186912

select top 5 * from innproduc where iprcodigo='HRPC35260'

select top 5 * from INNLOTSER where innproduc=4630
select top 5 * from INNFISICO where innproduc=4630 and IFICANTID>0
---------------------------------------------------------------------------------
select top 2 * from INNCODBAR
select top 2 * from INNPRODUC
select top 2 * from INNGRUPO
select top 2 * from INNSUBGRU
---------------------------------------------------------------------------------
declare @producto char(10)= ''
---------------------------------------------------------------------------------Productos con mas de un codigo de barra
select prod.IPRCODIGO cod_prod
from DGEMPRES21..INNCODBAR barr inner join DGEMPRES21..INNPRODUC prod on barr.INNPRODUC=prod.OID
inner join dgempres21..INNGRUPO gru on prod.IGRCODIGO=gru.OID
inner join dgempres21..INNSUBGRU sub on prod.ISGCODIGO=sub.OID
where (prod.IPRCODIGO = @producto or @producto='')
group by prod.IPRCODIGO
having (count(*) > 1)
---------------------------------------------------------------------------------Todos los Productos
select prod.IPRCODIGO cod_prod, prod.IPRDESCOR producto, barr.ICBCODIGO barra, convert(char, barr.ICBCANTIDAD) cantidad
, gru.IGRCODIGO cod_gru, gru.IGRNOMBRE grupo, sub.ISGCODIGO cod_sub, sub.ISGNOMBRE subgru
from DGEMPRES21..INNCODBAR barr inner join DGEMPRES21..INNPRODUC prod on barr.INNPRODUC=prod.OID
inner join dgempres21..INNGRUPO gru on prod.IGRCODIGO=gru.OID
inner join dgempres21..INNSUBGRU sub on prod.ISGCODIGO=sub.OID
where (prod.IPRCODIGO = @producto or @producto='')
order by 1
---------------------------------------------------------------------------------
begin tran xxx
update INNCODBAR set ICBCANTIDAD=1
commit tran xxx

select top 5 * from TSNDOCUME order by OID desc
select top 5 * from TSNDOCUME where IDCONSEC='000000000052337'
select top 5 * from TSNCEGRES where OID=377012

update TSNCEGRES set TEGNROCHE='18964' where OID=377012


select top 5 * from adningreso where ainconsec in (1289470)-----1614495
select top 5 * from adningreso where AINCAUING=6
select top 5 * from ADNFURIPS where AINCONSEC in (select top 5 * from adningreso where AINCAUING=6)

select * from adningreso where AINFECING > '2016-01-6' and AINCAUING=6 and OID not in (select AINCONSEC from ADNFURIPS)