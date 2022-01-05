
select ing.AINCONSEC Ingreso, pac.pacnumdoc Identificacion, cam.HCACODIGO
, RTRIM(pac.pacpriape)+' '+RTRIM(pac.pacsegape)+' '+RTRIM(pac.pacprinom)+' '+RTRIM(pac.pacsegnom) as Paciente
, det.GDECODIGO "Cod Plan Ben", det.GDENOMBRE "Plan de Beneficio", ing.AINFECING "Fecha de Ingreso"
, case ing.ainestado when 0 then 'Registrado' when 1 Then 'Facturado' when 2 Then 'Anulado' 
                     when 3 Then 'Bloqueado' end Estado
, rel.ainconsec Relacionado, usu.USUNOMBRE usuario, usu.USUDESCRI usuario_crea
, esp.cant1, esp.nom_esp1, esp.cant2, esp.nom_esp2, esp.cant3, esp.nom_esp3, esp.cant4, esp.nom_esp4
, esp.cant5, esp.nom_esp5, esp.cant6, esp.nom_esp6, esp.cant7, esp.nom_esp7, esp.cant8, esp.nom_esp8
, esp.cant9, esp.nom_esp9, esp.cant10, esp.nom_esp10
FROM DGEMPRES21..ADNINGRESO ING inner join DGEMPRES21..GENPACIEN PAC on ing.GENPACIEN=pac.OID
inner join DGEMPRES21..GENDETCON DET  on ing.GENDETCON=det.OID
inner join dgempres21..GENUSUARIO usu on ing.GEENUSUARIO=usu.OID
inner join dgempres21..HPNDEFCAM cam  on ing.HPNDEFCAM=cam.OID
CROSS APPLY CDO02_21.dbo.f_esp_hc_10(ING.oid) esp
left join DGEMPRES21..ADNINGRESO REL ON ing.adningreso=rel.oid
WHERE ing.AINTIPING=2 and ing.AINESTADO in (0, 3)
order by ing.AINCONSEC

