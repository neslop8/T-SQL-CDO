use DGEMPRES01
select * from CRNDOCUME where CDCONSEC=83874
select * from CRNRADFACC where OID=193725
select * from CRNRADFACD where CRNRADFACC=193725
select * from CRNCXC where OID in (select CRNCXC from CRNRADFACD where CRNRADFACC=112527)
select * from CRNCXCC where CRNCXC in (select CRNCXC from CRNRADFACD where CRNRADFACC=112527)

select * from CRNDOCUME where CDCONSEC=83874
select * from CRNCXCEST where CRNCXC in (select CRNCXC from CRNRADFACD where CRNRADFACC=193725)

begin tran xxx
update CRNDOCUME set CDFECDOC=GETDATE(), CDFECCON=GETDATE() where CDCONSEC=83874
update CRNCXCEST set CCEFECHA=GETDATE() where CRNCXC in (select CRNCXC from CRNRADFACD where CRNRADFACC=193725)

update CRNDOCUME set CDFECDOC='2021-02-02 16:00:28.837', CDFECCON='2021-02-02 16:00:28.837' where CDCONSEC=81202
update CRNCXCEST set CCEFECHA='2021-02-02 16:00:28.837' where CRNCXC in (select CRNCXC from CRNRADFACD where CRNRADFACC=193725)
commit tran xxx
