CREATE TABLE [dbo].[GENMEDICO2](
	[OID] [int] NOT NULL,
	[GMECODIGO] [nvarchar](20) NULL,
	[GMETARPRO] [nvarchar](30) NULL,
	[GMETIPMED] [int] NULL,
	[GMETIPVIN] [int] NULL,
	[GMEESTADO] [int] NULL,
	[GMEFIRMA] [varbinary](max) NULL,
	[GENTERCER] [int] NULL,
	[GENUSUARIO] [int] NULL,
	[GMENOMCOM] [nvarchar](100) NULL,
	[GMEEMAIL] [nvarchar](100) NULL,
	[GMEMOVIL] [nvarchar](10) NULL,
	[GMEFOTOIMA] [varbinary](max) NULL,
	[GENPROVEE] [int] NULL,
	[ADNCENATE] [int] NULL,
	[GMECONTRATI] [bit] NULL,
	[GMEPLANTA] [bit] NULL,
	[GMELIQHON] [bit] NULL,
	[GMEHEMOST] [bit] NULL,
	[OptimisticLockField] [int] NULL,
	[GMERECFIS] [bit] NULL,
	SysStartTime datetime2(7) NOT NULL,
	SysEndTime datetime2(7) NOT NULL
)


ALTER TABLE GENMEDICO
ADD
    SysStartTime datetime2(7) GENERATED ALWAYS AS ROW START HIDDEN
        constraint DF_ValidFrom DEFAULT SYSUTCDATETIME()
    , SysEndTime datetime2(7) GENERATED ALWAYS AS ROW END HIDDEN
        constraint DF_ValidTo DEFAULT '9999-12-31 23:59:59.9999999'
    , PERIOD FOR SYSTEM_TIME (SysStartTime, SysEndTime);

ALTER TABLE GENMEDICO
    SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.GENMEDICO2));

/*
ALTER TABLE [dbo].[GENMEDICO2] SET ( SYSTEM_VERSIONING = OFF  )
GO
DROP TABLE [dbo].[GENMEDICO2_History]
GO
*/
/*
select top 5 * from GENMEDICO
select top 5 * from GENMEDICO2_History

begin tran xxx
update DGEMPRES02..GENMEDICO set GMEESTADO=1 where OID=1
commit tran xxx
*/

select top 5 * from dgempres02..GENMEDICO
select top 5 * from dgempres02..GENMEDICO2