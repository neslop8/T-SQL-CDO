--------------------------------------------------------------------------------------------------------------------------
declare @fch_inicio   datetime = '2021-07-10 00:00:00'
declare @fch_fin      datetime = '2021-11-10 23:59:59'
--------------------------------------------------------------------------------------------------------------------------
select esp.GEEDESCRI Especialidad, usu.USUNOMBRE Cod_Usu, usu.USUDESCRI Usuario
, cit.CCMFECASI Fecha_Asigna, cit.CCMFECCIT Fecha_Cita
, cit.CCMPACDOC Identificacion, cit.CCMPACNOM Paciente, cit.CCMPACTEL Telefono
from DgEmpres01..CMNCITMED cit inner join DgEmpres01..GENMENSAJE men ON cit.CCMPACTEL=men.GMSDESTINO
inner join DgEmpres01..GENUSUARIO usu ON cit.GENUSUARIO1=usu.OID
inner join DgEmpres01..GENESPECI esp ON cit.GENESPECI=esp.OID
where men.GMSTIPMSJ=1 and men.GMSENVIADO=0 and cit.GENPACIEN IS NULL
and cit.CCMFECCIT >= @fch_inicio
and cit.CCMFECCIT <= @fch_fin
--------------------------------------------------------------------------------------------------------------------------
SELECT * FROM HCNTCENTURE WHERE HCEESTADO = 1 and USUCLAVE <> '123'
SELECT * FROM HCNTCENTURE WHERE HCEESTADO = 1 and GEENMedico is NULL
UPDATE dgempres01..HCNTCENTURE SET HCEESTADO =1 FROM HCNTCENTURE WHERE HPNGRUPOS =11
UPDATE dgempres01..HCNTCENTURE SET GEENMedico= , USUCLAVE= WHERE OID=
--------------------------------------------------------------------------------------------------------------------------
SELECT tur.OID, usu.OID OID_Usu, usu.USUNOMBRE, med.GMECODIGO, usu.USUDESCRI, med.OID OID_Med
FROM HCNTCENTURE tur inner join GENUSUARIO usu ON tur.GENUSUARIO=usu.OID
inner join GENMEDICO med ON med.GENUSUARIO=usu.OID
WHERE HCEESTADO = 1 and GEENMedico is NULL
--------------------------------------------------------------------------------------------------------------------------
SELECT * FROM GENUSUARIO WHERE USUNOMBRE='NFLopez'
SELECT * FROM GENMEDICO WHERE GMECODIGO='NFLopez'
--------------------------------------------------------------------------------------------------------------------------