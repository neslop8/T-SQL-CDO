--------------------
declare @fch_inicio datetime = '20210331'
declare @fch_fin datetime = '20210401'
declare @tipo bit = 1
--------------------
if (@tipo = 1)
	begin
		select med.GMECODIGO Cod_Medico, med.GMENOMCOM Medico
		, turno.OID turno, con.hcdescrip Digiturno
		, CASE turno.HCCESTADO when 0 then 'Pendiente' when 1 then 'Atendido' else 'Ausente' end Estado_Turno
		, triage.HCTNUMERO triage, triage.HCNCLAURGTR Clasificacion, ing.AINCONSEC ingreso
		, turno.hccdocpac documento_triage, pac.PACNUMDOC documento_paciente, turno.HCCNOMPAC paciente_triage, pac.GPANOMCOM paciente
		, det.GDECODIGO Con_Plan, det.GDENOMBRE Plan_de_Beneficio, are.GASCODIGO Cod_Area, are.GASNOMBRE Area_Servicio
		, turno.HCCFECTUR fecha_turno, triage.HCTFECTRI fecha_triage
		, ing.AINFECING Fecha_Ingreso, fol.HCFECFOLI Fecha_Llamado
		, case(triage.folio) when NULL then 'Llamado Correcto' else 'Llamado Incorrecto' end Llamado		
		from DGEMPRES01..HCNCONTRDT turno inner join DGEMPRES01..HCNTRIAGE triage ON triage.HCNCONTRDT=turno.OID
		inner join DGEMPRES01..HCNCLAURGTR cla  ON triage.HCNCLAURGTR=cla.OID
		inner join DGEMPRES01..ADNINGRESO   ing ON triage.ADNINGRESO=ing.OID and ing.HCENTRIAGE=triage.OID
		inner join DGEMPRES01..GENDETCON   det  ON ing.GENDETCON=det.OID
		inner join DGEMPRES01..GENPACIEN    pac ON ing.GENPACIEN=pac.OID
		inner join DGEMPRES01..hcnfolio fol     ON triage.Folio=fol.OID and fol.ADNINGRESO=ing.OID and fol.GENPACIEN=ing.GENPACIEN
		inner join DGEMPRES01..GENMEDICO med    ON fol.GENMEDICO=med.OID
		inner join DGEMPRES01..GENARESER are    ON fol.genareser=are.OID
		inner join DGEMPRES01..HCNCONCOTRI con  ON  turno.HCNCONCOTRI=con.OID
		where ing.AINFECING >= @fch_inicio and ing.AINFECING <= @fch_fin
		order by con.hcdescrip desc
--------------------
	end
--------------------
else 
	begin
	select 'Clasificacion'= CASE 
			WHEN GROUPING(con.HCDESCRIP)=1 THEN 'Totales'
			ELSE ISNULL(con.HCDESCRIP, 'N/D') END
		, count(con.HCDESCRIP) Cantidad	
	from DGEMPRES01..HCNCONTRDT turno inner join DGEMPRES01..HCNTRIAGE triage ON triage.HCNCONTRDT=turno.OID
	inner join DGEMPRES01..HCNCLAURGTR cla  ON triage.HCNCLAURGTR=cla.OID
	inner join DGEMPRES01..ADNINGRESO   ing ON triage.ADNINGRESO=ing.OID and ing.HCENTRIAGE=triage.OID
	inner join DGEMPRES01..GENDETCON   det  ON ing.GENDETCON=det.OID
	inner join DGEMPRES01..GENPACIEN    pac ON ing.GENPACIEN=pac.OID
	inner join DGEMPRES01..hcnfolio fol     ON triage.Folio=fol.OID and fol.ADNINGRESO=ing.OID and fol.GENPACIEN=ing.GENPACIEN
	inner join DGEMPRES01..GENMEDICO med    ON fol.GENMEDICO=med.OID
	inner join DGEMPRES01..GENARESER are    ON fol.genareser=are.OID
	inner join DGEMPRES01..HCNCONCOTRI con  ON  turno.HCNCONCOTRI=con.OID
	where ing.AINFECING >= @fch_inicio and ing.AINFECING <= @fch_fin
	group by con.HCDESCRIP
	WITH CUBE
	order by 2
end
--------------------

