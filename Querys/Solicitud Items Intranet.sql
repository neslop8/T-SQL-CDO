use CDO02_21
select * from CDO02_21..sis_programable where nombre='ADM-AMC-001'

select * from CDO02_21..sis_equipo
select * from CDO02_21..sis_programable_tipo
select * from CDO02_21..sis_programable_tipo_atributo
select * from CDO02_21..sis_programable_tipo_solicitud
select * from CDO02_21..sis_programable_imagen
select * from CDO02_21..sis_programable_responsable_tipo
select * from CDO02_21..sis_programable_dato
select * from CDO02_21..sis_programable_dato_cambio



select * from CDO02_21..sis_programable_atributo
select * from CDO02_21..sis_programable_dato
select * from CDO02_21..sis_mto_accion_programable_tipo where programable_tipo=2
select * from CDO02_21..sis_mto_accion where tipo=2
select * from CDO02_21..sis_mto_accion where tipo=1
select * from CDO02_21..sis_mto_accion where nombre like 'DGH%'

SELECT * FROM CDO02_21..sis_programable where nombre = 'BM-PBB-001'
SELECT * FROM CDO02_21..sis_programable_tipo where id = 568
SELECT * FROM CDO02_21..sis_mto_accion_programable_tipo where programable_tipo = 568


INSERT INTO CDO02_21..sis_mto_accion_programable_tipo (accion, programable_tipo) VALUES(8361,568)
INSERT INTO CDO02_21..sis_mto_accion_programable_tipo (accion, programable_tipo) VALUES(8362,568)
INSERT INTO CDO02_21..sis_mto_accion_programable_tipo (accion, programable_tipo) VALUES(8363,568)
INSERT INTO CDO02_21..sis_mto_accion_programable_tipo (accion, programable_tipo) VALUES(8364,568)

-------------------------------------------------------------------------------------------------

SELECT * FROM CDO02_21..sis_solicitud_item where id=414
SELECT * FROM CDO02_21..sis_solicitud_item where nombre like '%reporte%'
SELECT * FROM CDO02_21..sis_programable_tipo_solicitud where tipo = 2


INSERT INTO CDO02_21..sis_programable_tipo_solicitud VALUES(422, 2)