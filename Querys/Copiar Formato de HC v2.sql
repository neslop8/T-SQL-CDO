select * from DGEMPRES01..HCNTIPHIS where HCCODIGO='C0GIN1'
select * from DGEMPRES02..HCNTIPHIS where HCCODIGO='C0GIN1'

select * from DGEMPRES01..HCNDISHIS where HCNTIPHIS=35
select * from DGEMPRES02..HCNDISHIS where HCNTIPHIS=35

select TOP 5 * from DGEMPRES01..HCMC0GIN1 ORDER BY OID DESC
select TOP 5 * from DGEMPRES02..HCMC0GIN1 ORDER BY OID DESC

select * from DGEMPRES01..HCNCAMTHC where HCNTIPHIS=35
select HCEXPCON, * from DGEMPRES02..HCNCAMTHC where HCNTIPHIS=35 order by 1 desc

select HCEXPCON, * from DGEMPRES01..HCNCAMTHC where OID in (3922, 741, 742, 743, 744)
select HCEXPCON, * from DGEMPRES02..HCNCAMTHC where OID in (3922, 741, 742, 743, 744)

begin tran xxx
/*INSERT INTO DGEMPRES03..HCNTIPHIS --VALUES(HCCODIGO, HCNOMBRE, HCNDISHIS, GENESPECI, GENARESER, HCCAUEXT, HCFINCON, HCPERFOL, HCPERFOLAM, HCEXIDIA, HCEXINAM, HCEXINHO, HCODONTOHC, HCOBLIGA, HCBLOQUEA, HCEXCIMED, HCMAFOABR, HCPRVRFLAB, HCEXIPAQ, HCEXIPQE, HCEXISOC, HCEXIOBGR, HCEXIRVANTE, HCEXIDIETPAC, HCEXITRIAGE, HCCOPDIAGFO, HCCOPPLINFO, HCCOPPLEXFO, HCTHPYP, HCTHRESTVA, HCTHINASIS, HCTHEXHDINI, HCTHEXHDGRB, HCTHABESTPAC, HCTHFLDGURG, HCPRFOINCR, HCPRFOINFAC, HCFILING, HCFILINGPQ, HCTIPMODHC, HCENCRIP, HCNOTACLA, HCFOLRESINTER, HCFOLCONTREF, HCEXIANTE, HCTIPOSANTE, HCFLINAMBFAC, HCFLINHSPFAC, HCDIAFLAMBFA, HCDIAFLHSPFA, HCNMODWEB, HCOPCINI, HCEXIGES, HCEXIFECALTA, HCHCPREANEST, HCTIPCDASSD, HCEXGDAGING, HCEXGDAGIGR, HCHABDIEAMB, HCEXIVRACANTE, OptimisticLockField)
    SELECT HCCODIGO, HCNOMBRE, 67, GENESPECI, GENARESER, HCCAUEXT, HCFINCON, HCPERFOL, HCPERFOLAM, HCEXIDIA, HCEXINAM, HCEXINHO, HCODONTOHC, HCOBLIGA, HCBLOQUEA, HCEXCIMED, HCMAFOABR, HCPRVRFLAB, HCEXIPAQ, HCEXIPQE, HCEXISOC, HCEXIOBGR, HCEXIRVANTE, HCEXIDIETPAC, HCEXITRIAGE, HCCOPDIAGFO, HCCOPPLINFO, HCCOPPLEXFO, HCTHPYP, HCTHRESTVA, HCTHINASIS, HCTHEXHDINI, HCTHEXHDGRB, HCTHABESTPAC, HCTHFLDGURG, HCPRFOINCR, HCPRFOINFAC, HCFILING, HCFILINGPQ, HCTIPMODHC, HCENCRIP, HCNOTACLA, HCFOLRESINTER, HCFOLCONTREF, HCEXIANTE, HCTIPOSANTE, HCFLINAMBFAC, HCFLINHSPFAC, HCDIAFLAMBFA, HCDIAFLHSPFA, HCNMODWEB, HCOPCINI, HCEXIGES, HCEXIFECALTA, HCHCPREANEST, HCTIPCDASSD, HCEXGDAGING, HCEXGDAGIGR, HCHABDIEAMB, HCEXIVRACANTE, OptimisticLockField
    FROM DGEMPRES01..HCNTIPHIS WHERE OID = 68*/

/*INSERT INTO DGEMPRES03..HCNDISHIS --VALUES(HCNTIPHIS, HCNANCPER, HCNANCDIS, HCNALTPER, HCNALTDIS, HCDLYTDIS, GEPREPMOD, HCNMODHTM, OptimisticLockField, GEPREPMODXML, HCNEXPJS, HCNFORMCS, HCNFORMJS)
    SELECT HCNTIPHIS, HCNANCPER, HCNANCDIS, HCNALTPER, HCNALTDIS, HCDLYTDIS, GEPREPMOD, HCNMODHTM, OptimisticLockField, GEPREPMODXML, HCNEXPJS, HCNFORMCS, HCNFORMJS
    FROM DGEMPRES01..HCNDISHIS WHERE HCNTIPHIS = 68*/
/*
UPDATE DGEMPRES01..HCNDISHIS SET HCDLYTDIS=(SELECT HCDLYTDIS FROM DGEMPRES02..HCNDISHIS WHERE OID=35)WHERE OID=35
UPDATE DGEMPRES01..HCNDISHIS SET GEPREPMOD=(SELECT GEPREPMOD FROM DGEMPRES02..HCNDISHIS WHERE OID=35)WHERE OID=35
UPDATE DGEMPRES01..HCNDISHIS SET GEPREPMODXML=(SELECT GEPREPMODXML FROM DGEMPRES02..HCNDISHIS WHERE OID=35)WHERE OID=35
*/
INSERT INTO DGEMPRES01..HCNCAMTHC --VALUES(HCNTIPHIS, HCTIPCON, HCNOMBRE, HCDESCRIP, HCOBLIGA, HCRELEPIC, HCRELATIUR, HCRELAFURI, HCTITEPIC, HCRELCREF, HCTITCREF, HCEXPCON, HCEXPFOR, HCTDEXPR, HCEVAEXP, HCOBTHIS, HCOBTHISE, HCOBTHISEC, HCMODFOLA, HCNOGENSL, HCRELENFER, HCRELSIGVIT, HCRELCERTIF, HCPROPER, HCTITFOLIOSIUS, HCRELFOLIOSIUS, HCEPICSAL, HCRELGESRIES, HCRELAUTSER, HCTITAUTSER, HCRELRES2175, HCRELINDMED, HCRELEGRENAC, HCRELCDASO, HCRELCDAMN, HCRELINTCON, HCRELINTRES, OptimisticLockField, HCEXPFORWEB)
    SELECT HCNTIPHIS, HCTIPCON, HCNOMBRE, HCDESCRIP, HCOBLIGA, HCRELEPIC, HCRELATIUR, HCRELAFURI, HCTITEPIC, HCRELCREF, HCTITCREF, HCEXPCON, HCEXPFOR, HCTDEXPR, HCEVAEXP, HCOBTHIS, HCOBTHISE, HCOBTHISEC, HCMODFOLA, HCNOGENSL, HCRELENFER, HCRELSIGVIT, HCRELCERTIF, HCPROPER, HCTITFOLIOSIUS, HCRELFOLIOSIUS, HCEPICSAL, HCRELGESRIES, HCRELAUTSER, HCTITAUTSER, HCRELRES2175, HCRELINDMED, HCRELEGRENAC, HCRELCDASO, HCRELCDAMN, HCRELINTCON, HCRELINTRES, OptimisticLockField, HCEXPFORWEB
    FROM DGEMPRES02..HCNCAMTHC WHERE HCNTIPHIS=35 and OID=3922
rollback tran xxx
commit tran xxx

--1 Validar los cambios en el formato de la HC
ALTER TABLE DGEMPRES01..HCMP00001 ADD HCCM03N48 VARCHAR(20) NULL
--2 Actualizar los campos cifrados
--update DGEMPRES01..HCNDISHIS set HCNALTDIS=1020 where OID=1
update DGEMPRES03..HCNDISHIS set HCDLYTDIS=(select HCDLYTDIS from DGEMPRES01..HCNDISHIS where OID=68) where OID=68
update DGEMPRES03..HCNDISHIS set GEPREPMOD=(select GEPREPMOD from DGEMPRES01..HCNDISHIS where OID=68) where OID=68
update DGEMPRES03..HCNDISHIS set GEPREPMODXML=(select GEPREPMODXML from DGEMPRES01..HCNDISHIS where OID=68) where OID=68
--3 Actualizar los campos nuevos
INSERT INTO DGEMPRES01..HCNCAMTHC VALUES( HCNTIPHIS, HCTIPCON, HCNOMBRE, HCDESCRIP, HCOBLIGA, HCRELEPIC, HCRELATIUR, HCRELAFURI, HCTITEPIC, HCRELCREF, HCTITCREF, HCEXPCON, HCEXPFOR, HCTDEXPR, HCEVAEXP, HCOBTHIS, HCOBTHISE, HCOBTHISEC, HCMODFOLA, HCNOGENSL, HCRELENFER, HCRELSIGVIT, HCRELCERTIF, HCPROPER, HCTITFOLIOSIUS, HCRELFOLIOSIUS, HCEPICSAL, HCRELGESRIES, HCRELAUTSER, HCTITAUTSER, HCRELRES2175, HCRELINDMED, HCRELEGRENAC, HCRELCDASO, HCRELCDAMN, HCRELINTCON, HCRELINTRES, OptimisticLockField, HCEXPFORWEB)
    SELECT HCNTIPHIS, HCTIPCON, HCNOMBRE, HCDESCRIP, HCOBLIGA, HCRELEPIC, HCRELATIUR, HCRELAFURI, HCTITEPIC, HCRELCREF, HCTITCREF, HCEXPCON, HCEXPFOR, HCTDEXPR, HCEVAEXP, HCOBTHIS, HCOBTHISE, HCOBTHISEC, HCMODFOLA, HCNOGENSL, HCRELENFER, HCRELSIGVIT, HCRELCERTIF, HCPROPER, HCTITFOLIOSIUS, HCRELFOLIOSIUS, HCEPICSAL, HCRELGESRIES, HCRELAUTSER, HCTITAUTSER, HCRELRES2175, HCRELINDMED, HCRELEGRENAC, HCRELCDASO, HCRELCDAMN, HCRELINTCON, HCRELINTRES, OptimisticLockField, HCEXPFORWEB
    FROM DGEMPRES02..HCNCAMTHC WHERE HCNTIPHIS=1 and OID > 3894
commit tran xxx
rollback tran xxx

select top 1 * from DGEMPRES03..HCNTIPHIS order by OID desc
select top 1 * from DGEMPRES03..HCNDISHIS order by OID desc
select top 1 * from DGEMPRES03..HCNCAMTHC order by OID desc


begin tran xxx
DBCC CHECKIDENT ('DGEMPRES03..HCNTIPHIS', RESEED, 67);
DBCC CHECKIDENT ('DGEMPRES03..HCNDISHIS', RESEED, 67);
DBCC CHECKIDENT ('DGEMPRES03..HCNCAMTHC', RESEED, 3910);

delete DGEMPRES03..HCNTIPHIS where OID=68
delete DGEMPRES03..HCNDISHIS where HCNTIPHIS=68
delete DGEMPRES03..HCNCAMTHC where HCNTIPHIS=68
commit tran xxx