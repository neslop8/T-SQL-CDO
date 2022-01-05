USE DGEMPRES21
select * from CMNTIPACT where CMANOMBRE like '%cimo%'
select * from CMNCONSUL where CCNNOMBRE like '%cimo%'
select * from GENMEDICO where GMECODIGO like '%cimo%'

select * from CMNHORMED where CMNTIPACT in (36)
select * from CMNHORMED where CMNTIPACT in (35)
select * from CMNHORMED where CMNTIPACT in (36)
select * from CMNHORMED where GENMEDICO in (1772)
select * from CMNHORMED where GENMEDICO in (1773)

select * from CMNCITMED where CMNHORMED in (23445,23446,23447,23448,23449)

update CMNHORMED set GENMEDICO=1772 where oid in (23445,23446,23447,23448,23449)