---------------------------------------------------------------------------------------------------------------------------------
--select top 5 * from DGEMPRES01..GENPACIEN order by OID desc
--select top 5 * from DGEMPRES01..adnegreso order by OID desc
---------------------------------------------------------------------------------------------------------------------------------
declare @fch_inicio datetime = '20210210'
declare @fch_fin  datetime = '20210212'
---------------------------------------------------------------------------------------------------------------------------------
SELECT s.id
	, COALESCE(p.pacnumdoc COLLATE SQL_Latin1_General_CP1_CI_AS
	, p2.pacnumdoc COLLATE SQL_Latin1_General_CP1_CI_AS) AS documento
	, COALESCE(i.ainconsec, i2.ainconsec) AS ingreso
	, COALESCE(RTRIM(p.gpanomcom) COLLATE SQL_Latin1_General_CP1_CI_AS
	, RTRIM(p2.gpanomcom) COLLATE SQL_Latin1_General_CP1_CI_AS) AS paciente
	, COALESCE(c.gdecodigo COLLATE SQL_Latin1_General_CP1_CI_AS
	, c2.gdecodigo COLLATE SQL_Latin1_General_CP1_CI_AS) AS gdecodigo
	, COALESCE(c.gdenombre COLLATE SQL_Latin1_General_CP1_CI_AS	, c2.gdenombre COLLATE SQL_Latin1_General_CP1_CI_AS) AS gdenombre
	, t.nombre tipo, e.nombre estado
	, COALESCE(ec.hcacodigo COLLATE SQL_Latin1_General_CP1_CI_AS, ec2.hcacodigo COLLATE SQL_Latin1_General_CP1_CI_AS) AS cama_cod
	, u_r.nombre usu_responsable, u.nombre usu_solicita, s.fch_reactivacion, s.fch_creacion, e.color color, ext_det.secuencia
	, RTRIM(ser.codigo) codigo, ser.nombre, ext_det.cantidad
	, COALESCE(i.AINFECING, i2.AINFECING) Fecha_Ingreso, egr.ADEFECSAL Fecha_Egreso
	, COALESCE(dx_e.dg COLLATE Modern_Spanish_CI_AS, di.dx_cod_hc1) Cod_Diagnostico
	, COALESCE(dx.DIANOMBRE COLLATE Modern_Spanish_CI_AS, di.dx_nom_hc1) Diagnostico
FROM CDO02_21..asi_autorizacion_solicitud_interna s INNER JOIN CDO02_21..cfg_usuario u ON s.usuario_solicita = u.id 
	INNER JOIN CDO02_21..cfg_usuario u_r ON s.usuario_actual = u_r.id 
	INNER JOIN CDO02_21..asi_autorizacion_solicitud_interna_tipo t ON s.tipo = t.id 
	INNER JOIN CDO02_21..asi_autorizacion_solicitud_interna_estado e ON s.estado = e.id 
	LEFT JOIN CDO02_21..asi_autorizacion_solicitud_interna_ingreso ai ON ai.autorizacion_solicitud_interna = s.id 
	LEFT JOIN CDO02_21..asi_autorizacion_solicitud_interna_externa int_ext ON int_ext.autorizacion_solicitud_interna = s.id
	LEFT JOIN CDO02_21..asi_autorizacion_solicitud_externa ext ON ext.id = int_ext.autorizacion_solicitud_externa 
	LEFT JOIN CDO02_21..asi_autorizacion_solicitud_externa_detalle ext_det ON ext_det.autorizacion_solicitud_externa = ext.id 
	LEFT JOIN CDO02_21..gen_servicio ser ON ser.id = ext_det.servicio
	LEFT JOIN DgEmpres01..adningreso i ON ai.ingreso = i.oid 
	LEFT JOIN DGEMPRES21..adningreso i2 ON ai.ingreso = i2.oid 
	LEFT JOIN DgEmpres01..gendetcon c ON i.gendetcon = c.oid 
	LEFT JOIN DGEMPRES21..gendetcon c2 ON i2.gendetcon = c2.oid 
	LEFT JOIN DgEmpres01..hpnestanc ee ON ee.adningres = i.oid AND ee.hesfecsal IS NULL 
	LEFT JOIN DGEMPRES21..hpnestanc ee2 ON ee2.adningres = i2.oid AND ee2.hesfecsal IS NULL 
	LEFT JOIN DgEmpres01..hpndefcam ec ON ee.hpndefcam = ec.oid 
	LEFT JOIN DGEMPRES21..hpndefcam ec2 ON ee2.hpndefcam = ec2.oid 
	LEFT JOIN DgEmpres01..genpacien p ON p.oid = s.paciente 
	LEFT JOIN DGEMPRES21..genpacien p2 ON p2.oid = s.paciente 
	LEFT JOIN DgEmpres01..ADNEGRESO egr ON egr.adningreso=i.oid and i.adnegreso=egr.oid
	OUTER APPLY CDO02_21..f_dx_egr_0101(egr.OID) dx_e
	LEFT JOIN  DGEMPRES01..GENDIAGNO dx on dx_e.dg Collate Modern_Spanish_CI_AS = dx.DIACODIGO
	OUTER APPLY CDO02_21.dbo.f_dx_hc_1(i.oid) di
WHERE 
	s.estado = 4 
	AND s.fch_creacion >= @fch_inicio 
	AND s.fch_creacion <= @fch_fin 
	AND s.fch_reactivacion < GETDATE() 
ORDER BY 
	s.fch_creacion DESC
	, s.fch_reactivacion DESC;
---------------------------------------------------------------------------------------------------------------------------------