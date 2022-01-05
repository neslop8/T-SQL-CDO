------------------------------------------------------------------------------------------------------------------------------------
declare @fch_inicio datetime = '2016-01-06'
declare @fch_fin    datetime = '2016-12-06' 
------------------------------------------------------------------------------------------------------------------------------------
SELECT p.pacnumdoc documento, i.ainconsec ingreso
, RTRIM(p.pacprinom) + ' ' + RTRIM(p.pacsegnom) + ' ' + RTRIM(p.pacpriape) + ' ' + RTRIM(p.pacsegape) paciente
, ROUND((CONVERT (INT, GETDATE()) - CONVERT(INT, p.gpafecnac)) / 365, 0) edad
, CASE p.gpasexpac WHEN '1' THEN 'masculino' ELSE 'femenino' END sexo
, CASE e.ADEINSASE WHEN '1' THEN 'iss' WHEN '2' THEN 'cajas' WHEN '3' THEN 'otras' ELSE 'ninguna' END aseguradora
, CASE e.ADETIPDIA WHEN '1' THEN 'impresion_diagnostica' WHEN '2' THEN 'confirmado_nuevo' ELSE 'confirmado_repetido' END tipo_diag
, CASE e.adeestpac     WHEN '1' THEN 'vivo'     WHEN '2' THEN 'vivo'     WHEN '3' THEN 'muerto antes 48 h'
     WHEN '4' THEN 'muerto despues 48 h'     ELSE 'otro' END estado, 
     case(i.ainurgcon) when 0 then 'URGENCIA' when 1 then 'CON-EXT' when 2 then 'NACIDO' when 3 then 'REMITIDO' 
                         when 4 then 'HOSPITALIZACION U' when 5 then 'HOSPITALIZACION' end as Ingreso_Por
, con.geccodigo contrato_cod, con.gecnoment contrato_nom, cd.gdecodigo plan_beneficios, i.ainfecing fch_ingreso
, e.adefecsal fch_egreso, DATEDIFF(DAY, i.ainfecing, e.adefecsal) dif_egreso_ingreso, MONTH(e.adefecsal) mes_egreso
, CASE e.adeegrser    WHEN '1' THEN 'medicina interna'     WHEN '2' THEN 'pediatria'     WHEN '3' THEN 'obstetricia'     
     WHEN '4' THEN 'cirugia'     ELSE 'otro' END as egreso_del_servicio
, e.adesemges semanas_de_gestacion, med.GMECODIGO cod_med
, med.GMENOMCOM medico, esp.geecodigo cod_esp, esp.geedescri especialidad, e.adetipint tip_interv
, CASE i.ainurgcon     WHEN 0 THEN 'urgencias'     WHEN 1 THEN 'con_ext'     WHEN 2 THEN 'nacido'     WHEN 3 THEN 'remitido'      
     WHEN 4 THEN 'urgencias hp'     WHEN 5 THEN 'hospitalizacion'     WHEN 6 THEN 'imagenes'     WHEN 7 THEN 'laboratorio'    
     ELSE 'otro' END as tipo_ingreso
, bar.gebnombre barrio  , stt.getnomest estrato  , CASE p.gpatippac     WHEN '1' THEN 'contributivo'     
     WHEN '2' THEN 'subsidiado'     WHEN '3' THEN 'vinculado'     WHEN '4' THEN 'particular'     ELSE 'otro' END regimen
, ocp.dgonombre ocupacion, usu.USUNOMBRE usuario_egreso
, di.dx_cod1, di.dx_nom1, di.dx_cod2, di.dx_nom2, di.dx_cod3, di.dx_nom3
     FROM DgEmpres21..adnegreso e INNER JOIN DgEmpres21..adningreso i ON e.adningreso = i.oid and i.AINTIPING=2
     INNER JOIN DgEmpres21..genpacien p				ON i.genpacien = p.oid  
     INNER JOIN DgEmpres21..gendetcon cd			ON i.gendetcon = cd.oid  
     INNER JOIN DgEmpres21..gencontra con			ON cd.gencontra1 = con.oid  
     INNER JOIN DgEmpres21..genbarrio bar			ON p.genbarrio = bar.oid  
     INNER JOIN DgEmpres21..genestrato stt			ON p.genestrato = stt.oid  
     INNER JOIN DgEmpres21..genocupacion ocp		ON p.genocupacion = ocp.oid  
     INNER JOIN DgEmpres21..GENUSUARIO usu			ON e.GEENUSUARIO=usu.OID
     INNER JOIN DgEmpres21..GENMEDICO  med          ON e.GMECODIGO=med.OID
     INNER JOIN DgEmpres21..GENESPMED  medesp       ON medesp.MEDICOS=med.OID
     INNER JOIN DgEmpres21..GENESPECI  esp          ON medesp.ESPECIALIDADES=esp.OID
	 CROSS APPLY CDO02_21.dbo.f_dx_egreso_3(e.oid) di
     WHERE e.adefecsal >= @fch_inicio
     AND e.adefecsal <= @fch_fin  
------------------------------------------------------------------------------------------------------------------------------------
--select top 5 * from DGEMPRES22..ADNEGRESO order by OID desc --1124464
------------------------------------------------------------------------------------------------------------------------------------