USE [DGEMPRES21]
GO
/****** Object:  Trigger [dbo].[trg_hcnsolexa_ubq]    Script Date: 09/09/2016 15:48:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TRIGGER [dbo].[trg_hcnsolexa_ubq]
	ON [dbo].[HCNSOLEXA]
	FOR INSERT--, UPDATE
AS BEGIN
	
	/*INSERT INTO CDO02_21..asi_examen_solicitud 
		(id, folio, ingreso, servicio, 
		cantidad, estado, prioridad, fch_creacion, 
		fch_modificacion, vs)	
	SELECT x.oid, x.hcnfolio, f.adningreso, x.genserips, 
		x.hcscanti, CASE WHEN RIGHT(cd.gdecodigo, 2) = '26' THEN 9 ELSE 1 END, 4, GETDATE(), 
		GETDATE(), 0
	FROM inserted x
	INNER JOIN DgEmpres21..hcnfolio f ON x.hcnfolio = f.oid
	INNER JOIN DgEmpres21..adningreso i ON f.adningreso = i.oid
	INNER JOIN DgEmpres21..gendetcon cd ON i.gendetcon = cd.oid*/
---------------------a partir de aqui ubq	,id_ingreso = ing.OID, ingreso = ing.AINCONSEC
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
, SUBSTRING(dir.PACDIRECCION, 1, 100), case when (tel.PACTELEFONO is null) then 'Sin Dato' else SUBSTRING(tel.PACTELEFONO, 1, 20) end
, SUBSTRING(med.gmecodigo, 1, 15), SUBSTRING(med.gmenomcom, 1, 30)
, ISNULL(cam.hcacodigo, ''), ing.AINCONSEC, fol.OID, spat.OID, spat.HCSFECSOL
, ser.SIPCODIGO, SUBSTRING(ser.SIPNOMBRE, 1, 50), SUBSTRING(spat.HCSOBSERV, 1, 100), 0, fol.HCNUMFOL
, ing.OID, dx.DIACODIGO, dx.DIANOMBRE, are.GASCODIGO, are.GASNOMBRE, det.GDECODIGO, det.GDENOMBRE
--from inserted x inner join DGEMPRES21..HCNSOLEXA spat on spat.OID=x.OID
from DGEMPRES21..HCNSOLEXA spat inner join DGEMPRES21..ADNINGRESO ing on spat.ADNINGRESO=ing.OID
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
where ser.SIPRISPACKS=1 and pac.PACNUMDOC='51907390'
---------------------aqui termina ubq
END

