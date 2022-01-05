WITH suma(ter, valor) AS (
--select cant.gentercer, cant.oid, sum(dant.ANTVALOR) as Valor
select cant.gentercer, sum(dant.ANTVALOR) as Valor
from dgempres21..CRNANTICI cant inner join dgempres21..CRNDETANT dant on dant.CRNANTICI=cant.OID
where dant.ANTORIGEN in (1,4,5) and cant.CTNCUENTA in (1442,1441)-- and cant.GENTERCER=607086
group by cant.gentercer),
----------------------------------------------------------------------------------------------------------------
resta(ter, valor) AS (
--select cant.oid, sum(dant.ANTVALOR) as Valor
select cant.gentercer, sum(dant.ANTVALOR) as Valor
from dgempres21..CRNANTICI cant inner join dgempres21..CRNDETANT dant on dant.CRNANTICI=cant.OID
where dant.ANTORIGEN in (2,3,6,7) and cant.CTNCUENTA in (1442,1441)-- and cant.GENTERCER=607086
group by cant.gentercer)
----------------------------------------------------------------------------------------------------------------
SELECT p.pacnumdoc documento, i.ainconsec ingreso
, case(i.ainestado) when 0 then 'Reg' when 1 then 'Fac' when 2 then 'Anu' when 3 then 'Bloq' else 'Otro' end est_ing
, RTRIM(p.pacprinom) + ' ' + RTRIM(p.pacsegnom) + ' ' + RTRIM(p.pacpriape) + ' ' + RTRIM(p.pacsegape) paciente
, i.ainfecing fch_ingreso , /*cab.SCOTOTPAC,*/ CONVERT(BIGINT, SUM(s.servalpro * s.sercantid)) vr
, case when resta.valor > 0  then ((-1) * convert(bigint, (suma.valor - resta.valor))) 
                           else ((-1) * convert(bigint, suma.valor)) end as anticipo
, l.SRACONSEC salida, u.USUNOMBRE usuario
FROM DgEmpres21..adningreso i INNER JOIN DgEmpres21..genpacien p ON i.genpacien = p.oid
INNER JOIN DgEmpres21..gendetcon cd   ON i.gendetcon = cd.oid
--INNER JOIN DgEmpres21..SLNCONHOJ cab  ON cab.ADNINGRES1=i.OID
INNER JOIN DgEmpres21..slnserpro s ON s.adningres1 = i.oid
INNER JOIN DgEmpres21..slnordser o ON s.SLNORDSER1 = o.OID and o.SOSESTADO <> 2
LEFT JOIN DgEmpres21..slnordsal l ON l.ADNINGRES1 = i.OID
LEFT JOIN DgEmpres21..GENUSUARIO u ON l.GENUSUARIO1 = u.OID
LEFT JOIN suma suma             ON p.gentercer = suma.ter
LEFT JOIN resta resta           ON suma.ter=resta.ter
WHERE i.ainestado in (0,3)
AND cd.OID in (169, 267, 270, 277, 286)-- and p.GENTERCER=607086
--AND l.SRAORDANU=0
group by p.PACNUMDOC, i.AINCONSEC, i.AINESTADO
, RTRIM(p.PACPRINOM) + ' ' + RTRIM(p.PACSEGNOM) + ' ' + RTRIM(p.PACPRIAPE) + ' ' + RTRIM(p.PACSEGAPE)
, i.AINFECING, suma.valor, resta.valor, l.SRACONSEC, u.USUNOMBRE
ORDER BY i.ainconsec
----------------------------------------------------------------------------------------------------------------
--select top 5 * from SLNORDSAL order by OID desc
--select top 5 * from GENUSUARIO order by OID desc
----------------------------------------------------------------------------------------------------------------