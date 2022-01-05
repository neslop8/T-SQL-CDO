use DGEMPRES21
select top 5 AINESTADO, * from ADNINGRESO where GENPACIEN=599480
select top 5 SFADOCANU, * from SLNFACTUR where ADNINGRESO in (1529529,1556627)

select top 5 GENTERCER, * from GENPACIEN where PACNUMDOC='27274720'
select top 5 * from GENTERCER where OID=655901

select top 5 * from TSNDOCUME where OID in (select OID from TSNCRECIB where GENTERCER=655901)
select top 5 * from TSNCRECIB where GENTERCER=655901
select top 5 * from TSNMRECIB where TSNCRECIB in (365380, 365412)
--select top 5 * from GENUSUARIO where OID in (424, 493)
select top 5 * from CRNANTICI where OID in (275033, 275048)
select top 5 * from CRNANTICI where GENTERCER in (655901)
select * from CRNDETANT where CRNANTICI in (select OID from CRNANTICI where GENTERCER in (655901))
select top 5 * from CRNNOTA where GENTERCER in (655901)
select top 5 * from CRNNOTAANT


select * from TSNCRECIB where GENTERCER=655901
select * from TSNMRECIB where TSNCRECIB in (365380, 365412)

select AINESTADO, * from ADNINGRESO where GENPACIEN=599480
select SFADOCANU, * from SLNFACTUR where ADNINGRESO in (1529529,1556627)
select * from CRNCTRASL where CRNANTICI in (272439, 275033, 275048, 275073)
select * from CRNANTICI where GENTERCER in (655901)
select * from CRNDETANT where CRNANTICI in (select OID from CRNANTICI where GENTERCER in (655901))