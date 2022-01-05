------------------------------------------------------------------------------------------------------------------
SELECT f.numero, det.GDECODIGO, det.gdenombre, f.fecha, ing.ainconsec ingreso, pac.PACNUMDOC paciente, f.vr_total
, u.nombre, f.estado estado_cdo_id, e.nombre estado_cdo_nom, cxc.cxcestcar estado_DGH
FROM fac_factura f INNER JOIN fac_factura_estado e ON f.estado = e.id
INNER JOIN cfg_usuario u ON f.usuario_actual = u.id
INNER JOIN DgEmpres21..crncxc cxc     on cxc.cxcdocume = f.numero
INNER JOIN DgEmpres21..GENDETCON  det on cxc.GENDETCON=det.OID
INNER JOIN DgEmpres21..ADNINGRESO ing on f.ingreso=ing.oid
INNER JOIN DgEmpres21..GENPACIEN  pac on ing.GENPACIEN=pac.OID
WHERE cxc.cxcestcar in (1, 0) and cxc.CRNSALDO > 0 --and cxc.GENDETCON not in (169,270)
--and f.numero='FV000003623199'
ORDER BY f.estado
------------------------------------------------------------------------------------------------------------------
select top 5 * from DGEMPRES21..crncxc where CXCDOCUME='FV000003623199'
------------------------------------------------------------------------------------------------------------------
select top 5 * from DGEMPRES21..crncxc where OID=1128613
select top 5 * from DGEMPRES21..crncxcc where crncxc=1128613

select top 5 * from dgempres21..GENDETCON where oid in (169,270)
------------------------------------------------------------------------------------------------------------------