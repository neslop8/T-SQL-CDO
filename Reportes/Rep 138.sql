--------------------------------------------------------------------------------------------------------------------------------------------
declare @fch_inicio datetime ='20210201'
declare @fch_fin    datetime ='20210228'
--------------------------------------------------------------------------------------------------------------------------------------------
select cie.aciconsec cierre, CASE(cie.adnestado) WHEN 0 THEN 'Registrado' WHEN 1 THEN 'Confirmado' ELSE 'Anulado' END AS Estado_Cierre
, CONVERT(varchar, cie.acifecing, 7) fecha_cierre
,  pac.PACNUMDOC documento, RTRIM(pac.GPANOMCOM) paciente, ing.AINCONSEC ingreso, CONVERT(varchar, ing.AINFECING, 7) fec_ing
, ROUND((CONVERT (INT, GETDATE()) - CONVERT(INT, pac.gpafecnac)) / 365, 0) edad
, CASE (pac.PACTIPDOC) WHEN 0 THEN 'Ninguno' WHEN 1 THEN 'CC' WHEN 2 THEN 'CE' WHEN 3 THEN 'TI' WHEN 4 THEN 'RC' WHEN 5 THEN 'PA' 
                       WHEN 6 THEN 'AS' WHEN 7 THEN 'MS' WHEN 8 THEN 'NUIP' WHEN 9 THEN 'SC' WHEN 10 THEN 'NV' WHEN 11 THEN 'CD' WHEN 12 THEN 'PE' 
					   ELSE 'Otro' END AS Tipo
, CASE pac.gpasexpac WHEN '1' THEN 'Mas' ELSE 'Fem' END Sexo
, det.GDECODIGO codigo, det.GDENOMBRE contrato, CASE (cen.ACACODIGO) WHEN 1 THEN 'CDO' ELSE 'CIMO' end centro
, case(ing.AINTIPING) when 1 then 'Amb' when 2 then 'Hos' else 'otro' end TIPO
, case(ing.ainestado) when 0 then 'Registrado' when 1 then 'Facturado' when 2 then 'Anulado' when 3 then 'Bloqueado' else 'Cerrado' end estado_INGRESO
, usui.USUNOMBRE + '-' + usui.USUDESCRI usuario_Ingreso
, usuc.USUNOMBRE + '-' + usuc.USUDESCRI usuario_Cierre
from DGEMPRES01..ADNCIADMIN cie inner join DGEMPRES01..ADNINGRESO ing ON cie.ADNINGRESO=ing.OID
inner join DGEMPRES01..GENPACIEN   pac ON ing.GENPACIEN=pac.OID
inner join DGEMPRES01..ADNCENATE   cen ON ing.ADNCENATE=cen.OID
inner join DGEMPRES01..GENDETCON   det ON ing.GENDETCON=det.OID 
inner join DGEMPRES01..GENUSUARIO  usui ON ing.GEENUSUARIO=usui.oid
inner join DGEMPRES01..GENUSUARIO  usuc ON cie.GEENUSUARIO=usuc.oid
where ing.AINFECING >= @fch_inicio
  and ing.AINFECING <= @fch_fin
order by cie.aciconsec
--------------------------------------------------------------------------------------------------------------------------------------------
		select 'Clasificacion'= CASE 
			WHEN GROUPING(cla.HCDESCRIP)=1 THEN 'Totales'
			ELSE ISNULL(cla.HCDESCRIP, 'N/D') END
		, count(cla.HCDESCRIP) Cantidad
		, AVG(DATEDIFF(MINUTE, turno.HCCFECTUR, fol.HCFECFOLI)) Tiempo_Promedio
		from DGEMPRES01..HCNCONTRDT turno inner join DGEMPRES01..HCNTRIAGE triage ON triage.HCNCONTRDT=turno.OID
		inner join DGEMPRES01..HCNCLAURGTR cla ON triage.HCNCLAURGTR=cla.OID
		left join DGEMPRES01..ADNINGRESO ing ON triage.ADNINGRESO=ing.OID and ing.HCENTRIAGE=triage.OID
		left join DGEMPRES01..GENPACIEN pac ON ing.GENPACIEN=pac.OID
		left join primer_folio pf ON pf.ingreso=ing.OID
		left join DGEMPRES01..hcnfolio fol on pf.oid=fol.OID
		where ing.AINFECING >= @fch_inicio and ing.AINFECING <= @fch_fin and (cla.HCDESCRIP = @triage or @triage='')
		--where ing.AINFECING >= '20210114' and ing.AINFECING <= '20210115'
		group by cla.HCDESCRIP
		WITH CUBE
		order by 1 desc
--------------------------------------------------------------------------------------------------------------------------------------------