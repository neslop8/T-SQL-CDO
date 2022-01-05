use DGEMPRES21
select top 5 * from GENSERIPS where SIPCODIGO='911003'-----4027
select top 5 * from GENSERIPS where SIPCODIGO='911019'-----4028
select top 5 * from GENSERIPS where SIPCODIGO='911009'-----4008
select top 5 * from GENSERIPS where SIPCODIGO='911022'-----4023
select top 5 * from GENSERIPS where SIPCODIGO='911022'-----4009

select top 5 * from CDO02_21..lab_homologa_datalab where cod_homologa in ('911003','911019','911009','911022')
select top 5 * from CDO02_21..lab_homologa_datalab_inactivo where cod_datalab='4009'
select top 5 * from CDO02_21..lab_homologa_datalab_tipo

select * from CDO02_21..lab_homologa_datalab where cod_homologa in ('911003','911019','911009','911022')