use DGEMPRES21
alter table SLNSERHOJ DISABLE trigger trg_cant_hoja_trabajo_21
alter table SLNSERPRO DISABLE trigger trg_SLNSERPRO_REDONDEO
alter table ADNINGRESO DISABLE trigger trg_adningreso_solicitud
alter table ADNINGRESO DISABLE trigger trg_adningreso_particular
alter table ADNINGRESO DISABLE trigger trg_adningreso_eventos
alter table ADNINGRESO DISABLE trigger trg_adningreso_control

alter table SLNSERHOJ ENABLE trigger trg_cant_hoja_trabajo_21
alter table SLNSERPRO ENABLE trigger trg_SLNSERPRO_REDONDEO
alter table ADNINGRESO ENABLE trigger trg_adningreso_solicitud
alter table ADNINGRESO ENABLE trigger trg_adningreso_particular
alter table ADNINGRESO ENABLE trigger trg_adningreso_eventos
alter table ADNINGRESO ENABLE trigger trg_adningreso_control