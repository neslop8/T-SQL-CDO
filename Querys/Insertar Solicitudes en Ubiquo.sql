INSERT INTO UBQ..ubq_occi
		(identificacion, tipo_doc, apellido1, apellido2, nombre1, nombre2, sexo, fecha_nac
         , direccion, telefono, medico, nombre_medico, cama, id_ingreso, id_folio, id_solicitud
         , fecha_solicitud, servicio, nom_ser, observacion, estado, folio_num, ingreso
         , diacodigo, dianombre, arecodigo, arenombre, concodigo, connombre)	


Select pac.PACNUMDOC
, CASE pac.pactipdoc   WHEN '1' THEN 'CC'  WHEN '2' THEN 'CE'  WHEN '3' THEN 'TI'  WHEN '4' THEN 'RC' 
                       WHEN '5' THEN 'PAS' WHEN '6' THEN 'ASI' WHEN '7' THEN 'MSI' WHEN '8' THEN 'NUIP' ELSE 'Otro' END
, RTRIM(pac.pacpriape), RTRIM(pac.pacsegape), RTRIM(pac.pacprinom), RTRIM(pac.pacsegnom)
, case pac.GPASEXPAC   WHEN '1' THEN 'Mas' WHEN '2' THEN 'Fem' ELSE 'Otro' END, pac.GPAFECNAC
, SUBSTRING(dir.PACDIRECCION, 1, 100), SUBSTRING(tel.PACTELEFONO, 1, 20)
, SUBSTRING(med.gmecodigo, 1, 15), SUBSTRING(med.gmenomcom, 1, 30)
, ISNULL(cam.hcacodigo, ''), ing.AINCONSEC, fol.OID, spat.OID, spat.HCSFECSOL
, ser.SIPCODIGO, SUBSTRING(ser.SIPNOMBRE, 1, 50), SUBSTRING(spat.HCSOBSERV, 1, 100), 0, fol.HCNUMFOL
, ing.OID, dx.DIACODIGO, dx.DIANOMBRE, are.GASCODIGO, are.GASNOMBRE, det.GDECODIGO, det.GDENOMBRE
from inserted x inner join DGEMPRES21..HCNSOLEXA spat on spat.OID=x.OID
--from DGEMPRES21..HCNSOLEXA spat inner join DGEMPRES21..ADNINGRESO ing on spat.ADNINGRESO=ing.OID
inner join DGEMPRES21..ADNINGRESO ing on spat.ADNINGRESO=ing.OID
inner join DGEMPRES21..GENDETCON det ON ing.GENDETCON  = det.OID
inner join DGEMPRES21..GENPACIEN pac ON ing.GENPACIEN  = pac.OID
inner JOIN DgEmpres21..genserips ser ON spat.GENSERIPS = ser.OID
/*inner JOIN DgEmpres21..hcnfolio  fol ON spat.HCNFOLIO  = fol.oid
inner join DGEMPRES21..GENARESER are ON fol.GENARESER  = are.OID
inner JOIN DgEmpres21..genmedico med ON fol.GENMEDICO  = med.oid*/
LEFT JOIN DgEmpres21..hcnfolio  fol ON spat.HCNFOLIO  = fol.oid
LEFT join DGEMPRES21..GENARESER are ON fol.GENARESER  = are.OID
LEFT JOIN DgEmpres21..genmedico med ON fol.GENMEDICO  = med.oid
LEFT JOIN DgEmpres21..genpaciend dir ON pac.GENPACIEND = dir.oid
LEFT JOIN DgEmpres21..genpacient tel ON pac.GENPACIENT = tel.oid	
LEFT JOIN DgEmpres21..hpndefcam  cam ON ing.hpndefcam  = cam.oid	
LEFT JOIN DgEmpres21..HCNDIAPAC dxp  ON dxp.HCNFOLIO   = fol.OID AND dxp.HCPDIAPRIN=1
LEFT JOIN DgEmpres21..GENDIAGNO dx   ON dxp.GENDIAGNO  = dx.OID
where ser.SIPRISPACKS=1 --and spat.OID in (3688769, 3688770, 3688868)
---------------------aqui termina ubq


