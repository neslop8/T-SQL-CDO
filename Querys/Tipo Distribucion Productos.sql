use dgempres21
select top 5 * from innproduc where iprcodigo='DM-23212023'
select IPRTIPODIST, count(*) from innproduc group by IPRTIPODIST

select * from innproduc where IPRTIPODIST=3

update dgempres21..innproduc set IPRTIPODIST=1 where IPRTIPODIST in (2, 3)

