----------------------------------------------------------------------------------------------------------
declare @fch_inicio datetime ='2016-01-05 00:00:00'
declare @fch_fin    datetime ='2016-31-05 23:59:59'
----------------------------------------------------------------------------------------------------------
SELECT tc.tcnombre comprobante, cc.comcodigo numero, cta.cuecodigo cuenta
, t.ternumdoc tercero_nit, t.terprinom tercero_nombre, cc.comfeccom fecha
, cd.cmmvalcre credito, cd.cmmvaldeb debito, cd.comdetalle detalle
, fac.SFANUMFAC factura, ing.ADNCENATE centro
--, case(ing.AINTIPING) when 1 then ''amb'' when 2 then ''hos'' else ''otro'' end
FROM DgEmpres21..CTNCOM2016 AS cc INNER JOIN DgEmpres21..CTNCOMD2016 AS cd ON cd.ctncomconc = cc.oid
INNER JOIN DgEmpres21..gentercer AS t ON cd.gentercer = t.oid
INNER JOIN DgEmpres21..ctntipcom tc ON cc.ctntipcom = tc.oid
INNER JOIN DgEmpres21..ctncuenta cta ON cd.ctncuenta = cta.oid
LEFT JOIN DgEmpres21..SLNCONHOJ con  ON cc.COMOIDDOCU = con.OID
LEFT JOIN DgEmpres21..SLNFACTUR fac  ON con.ADNINGRES1 = fac.ADNINGRESO
LEFT JOIN DgEmpres21..ADNINGRESO ing ON fac.ADNINGRESO = ing.OID
	WHERE cta.cuecodigo BETWEEN '41' AND '42'
	AND cc.comfeccom BETWEEN @fch_inicio AND @fch_fin
	AND cc.comestado <> 2
	ORDER BY cc.oid
---------------------------------------------------------------------------------------------------------