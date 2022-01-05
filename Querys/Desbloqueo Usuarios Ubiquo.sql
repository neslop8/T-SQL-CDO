USE UbiquoPlatform

UPDATE Ubiquo.Users SET ChangePasswordRequired=0,NumberAttemptsPassword=0 WHERE  UserName IN('456')

UPDATE Ubiquo.Users SET Password='250cf8b51c773f3f8dc8b4be867a9a02' WHERE  UserName IN ('456')

UPDATE Ubiquo.Users SET ChangePasswordRequired=0,NumberAttemptsPassword=0 
WHERE  UserName IN('sistemasCDO')

select top 5  ChangePasswordRequired, NumberAttemptsPassword, * 
from Ubiquo.Users where UserName IN('456')

select top 5 * from Ubiquo.Users where FirstName like '%ana yolima%'
select top 5 ChangePasswordRequired, NumberAttemptsPassword, * from Ubiquo.Users where UserName='52431101'

select ChangePasswordRequired, NumberAttemptsPassword, Password, * from Ubiquo.Users 
WHERE  UserName IN('123','456','123456','51864840','52431101')
	
UPDATE Ubiquo.Users SET Password='cb79464743458d947cd891d5b7e698d3' WHERE  UserName IN ('sistemasCDO')

UPDATE Ubiquo.Users SET ChangePasswordRequired=0,NumberAttemptsPassword=0 WHERE  UserName IN('sistemasCDO')

UPDATE Ubiquo.Users SET Password='202cb962ac59075b964b07152d234b70' WHERE  UserName IN ('123')
UPDATE Ubiquo.Users SET Password='e2a9bb584e9addc159d9eb47f9cb266c' WHERE  UserName IN ('46458164')
--456---250cf8b51c773f3f8dc8b4be867a9a02
--123---202cb962ac59075b964b07152d234b70
--123456---e10adc3949ba59abbe56e057f20f883e

update Ubiquo.Users SET FirstName='Consulta', LastName='Consulta' WHERE  UserName IN ('123')
