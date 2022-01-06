USE [DGEMPRES01]
GO

/****** Object:  Table [dbo].[HCNPARAME]    Script Date: 6/01/2022 1:45:04 p.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[HCNPARAME2](
	[OID] [int] NOT NULL,
	[GENCONSEC1] [int] NULL,
	[GENCONSEC2] [int] NULL,
	[GENCONSEC3] [int] NULL,
	[GENCONSEC4] [int] NULL,
	[GENCONSEC5] [int] NULL,
	[GENCONSEC6] [int] NULL,
	[GENCONSEC7] [int] NULL,
	[GENCONSEC8] [int] NULL,
	[GENCONSEC9] [int] NULL,
	[GENCONSEC10] [int] NULL,
	[GENCONSEC11] [int] NULL,
	[GENCONSEC12] [int] NULL,
	[GENCONSEC13] [int] NULL,
	[GENCONSEC14] [int] NULL,
	[GENCONSEC15] [int] NULL,
	[GENCONSEC16] [int] NULL,
	[GENCONSEC17] [int] NULL,
	[GENCONSEC18] [int] NULL,
	[HCPORDSEHC] [bit] NULL,
	[HCPORDSEHCQX] [bit] NULL,
	[HCPHORMIL] [bit] NULL,
	[HCPCIEEGR] [bit] NULL,
	[HCPCIEINS] [bit] NULL,
	[HCPCIEFAC] [bit] NULL,
	[HCPCIEEPI] [bit] NULL,
	[HCPDIAAUT] [int] NULL,
	[HCPVERINGFAC] [bit] NULL,
	[HCPCIEEGR2] [bit] NULL,
	[HCPCIEINS2] [bit] NULL,
	[HCPCIEFAC2] [bit] NULL,
	[HCPCIEEPI2] [bit] NULL,
	[HCPDIAAUT2] [int] NULL,
	[HCPVERINGFAC2] [bit] NULL,
	[HCPCIEEGR3] [bit] NULL,
	[HCPCIEINS3] [bit] NULL,
	[HCPCIEFAC3] [bit] NULL,
	[HCPCIEEPI3] [bit] NULL,
	[HCPDIAAUT3] [int] NULL,
	[HCPVERINGFAC3] [bit] NULL,
	[HCPCIEEGR4] [bit] NULL,
	[HCPCIEINS4] [bit] NULL,
	[HCPCIEFAC4] [bit] NULL,
	[HCPCIEEPI4] [bit] NULL,
	[HCPDIAAUT4] [int] NULL,
	[HCPVERINGFAC4] [bit] NULL,
	[HCPFOLSING] [bit] NULL,
	[HCPPRODPB] [bit] NULL,
	[HCPSERVPB] [bit] NULL,
	[HCPFACODPR] [bit] NULL,
	[HCPTRANSBS] [bit] NULL,
	[HCPEXNOTDX] [bit] NULL,
	[HCPEXCSANT] [bit] NULL,
	[HCPINTERHQ] [bit] NULL,
	[HCPPEJEOPMED] [bit] NULL,
	[HCPCNTIMPEPI] [bit] NULL,
	[GENDETCON] [int] NULL,
	[HCPMANIMG] [int] NULL,
	[HCPUNCIMG] [nvarchar](1000) NULL,
	[HCPAUTINTV] [nvarchar](max) NULL,
	[HCPINFTRANSAN] [nvarchar](max) NULL,
	[HCINTHCCP] [bit] NULL,
	[HCURLIHCC] [nvarchar](100) NULL,
	[HCURLIHCCIN] [nvarchar](100) NULL,
	[HCPUNCFOL] [nvarchar](1000) NULL,
	[HCURLISIS] [nvarchar](100) NULL,
	[HCPMSJAUT] [int] NULL,
	[GENUSUARIO] [int] NULL,
	[HCURLRESROC] [nvarchar](100) NULL,
	[HCNPLANTIR] [int] NULL,
	[HCNPLANTIT] [int] NULL,
	[HCNMHRCRENF] [int] NULL,
	[HCINTHCUNF] [bit] NULL,
	[HCURLIHCUNIF] [nvarchar](100) NULL,
	[HCTIHICL] [int] NULL,
	[HCDOCCTRLMD] [int] NULL,
	[HCIRISHL7V2] [bit] NULL,
	[HCIIPRISHL7V2] [nvarchar](100) NULL,
	[HCIPTRISHL7V2] [int] NULL,
	[ADNCENATE] [int] NULL,
	[HCNHSOLMED] [int] NULL,
	[HCNHSOLINSM] [int] NULL,
	[HCNHSOLPLMEX] [int] NULL,
	[HCNHVALPLMEX] [int] NULL,
	[HCNHAPLMED] [int] NULL,
	[HCPPRODPBIACE] [bit] NULL,
	[HCPSERVPBIACE] [bit] NULL,
	[GENCONFAC1] [int] NULL,
	[GENCONFAC2] [int] NULL,
	[HCINTSWENTER] [bit] NULL,
	[HCURLSWENTER] [nvarchar](100) NULL,
	[HCINTSIUS] [bit] NULL,
	[HCURLINTSIUS] [nvarchar](100) NULL,
	[HCMETPACSIUS] [nvarchar](100) NULL,
	[HCMETFOLSIUS] [nvarchar](100) NULL,
	[HCCODAPLISIUS] [nvarchar](30) NULL,
	[HCNOMAPLISIUS] [nvarchar](100) NULL,
	[HCURLHCSIUS] [nvarchar](100) NULL,
	[HCUSUSIUS] [nvarchar](100) NULL,
	[HCPASSSIUS] [nvarchar](100) NULL,
	[HCUSUSWENTER] [nvarchar](100) NULL,
	[HCCONSWENTER] [nvarchar](100) NULL,
	[HCINTDROSV] [bit] NULL,
	[HCURLINTDROSV] [nvarchar](100) NULL,
	[HCXMLSWL] [bit] NULL,
	[HRESIN2463] [bit] NULL,
	[HRESIN1393] [bit] NULL,
	[HCINTLABCL] [bit] NULL,
	[HCFLABRPAC] [int] NULL,
	[HCCTLTRGDIG] [bit] NULL,
	[HCCTLDTSUMRE] [bit] NULL,
	[HCREQHLLCF] [bit] NULL,
	[HCHORACF] [int] NULL,
	[HCURLCONRES] [nvarchar](100) NULL,
	[HCPATHVDTRG] [nvarchar](512) NULL,
	[HCPHABLLTRG] [bit] NULL,
	[HCINTSLSISAN3] [bit] NULL,
	[HCURLSLSISAN3] [nvarchar](255) NULL,
	[HCUSUSLSISAN3] [nvarchar](100) NULL,
	[HCMINDGT] [int] NULL,
	[HCPBLOQCOPE] [bit] NULL,
	[HCPAPMCOBA] [bit] NULL,
	[HCINTAJORS] [bit] NULL,
	[HCURLAJORS] [nvarchar](255) NULL,
	[HCURLAJORSI] [nvarchar](255) NULL,
	[HCAJTAUTRES] [bit] NULL,
	[HCFECREENSWL] [datetime] NULL,
	[HCCTRMRESDIS] [bit] NULL,
	[GENSERIPSISS] [int] NULL,
	[GENSERIPSSOAT] [int] NULL,
	[HCPORDSERE] [bit] NULL,
	[HCINTCDASSD] [bit] NULL,
	[HCURLINTCDASSD] [nvarchar](100) NULL,
	[HCURLINTGFMSSD] [nvarchar](100) NULL,
	[HCCANLIQAUTHC] [bit] NULL,
	[HCINTOIV] [bit] NULL,
	[HCPUNCIMGOIV] [nvarchar](512) NULL,
	[HCURLINTOIV] [nvarchar](128) NULL,
	[HCAETITLEPACS] [nvarchar](64) NULL,
	[HCHOSTIPPACS] [nvarchar](32) NULL,
	[HCPUERTOPACS] [int] NULL,
	[HCAECLIEPACS] [nvarchar](64) NULL,
	[HCPUCLIEPACS] [int] NULL,
	[HCTEMINTCON] [int] NULL,
	[HCINTMCMEDEX] [bit] NULL,
	[HCINTMCMEDEXPSD] [bit] NULL,
	[HCINTMCMEDEXH] [nvarchar](255) NULL,
	[HCINTMCMEDEXP] [nvarchar](10) NULL,
	[HCINTMCMEDEXS] [bit] NULL,
	[HCMSTAGRMED] [bit] NULL,
	[OptimisticLockField] [int] NULL,
	[HCMDWEBANG] [bit] NULL,
	[HCURLAPIOIV] [nvarchar](128) NULL,
	[HCINTMIPRES] [bit] NULL,
	[HCURLAMIPRES] [nvarchar](255) NULL,
	[HCURLCOMIPRES] [nvarchar](255) NULL,
	[HCFECTOKMI] [datetime] NULL,
	[HCTOKENMIPRES] [nvarchar](4000) NULL,
	[HCINTUNIHTH] [bit] NULL,
	[HCURLINTHTH] [nvarchar](255) NULL,
	[HCINTHTHDOM] [nvarchar](100) NULL,
	[HCINTHTHUSU] [nvarchar](100) NULL,
	[HCINTHTHPWD] [nvarchar](100) NULL,
	[GENCONSEC19] [int] NULL,
	[HCNHADCONHC] [int] NULL,
	[HCURLAMMIPRES] [nvarchar](255) NULL,
	[HCFECTOKMIT] [datetime] NULL,
	[HCTOKENMIPREST] [nvarchar](4000) NULL,
	[HCDIFORMINA] [int] NULL,
	[HCURLCNSCDA] [nvarchar](255) NULL,
	[HCURLCNSGFM] [nvarchar](255) NULL,
	[HCSSDPRIVATEK] [nvarchar](max) NULL,
	[HCSSDPUBLICK] [nvarchar](max) NULL,
	[HCSSDIDROL] [nvarchar](255) NULL,
	[HCSSDKID] [nvarchar](255) NULL,
	[HCINTSWEBIMG] [bit] NULL,
	[HCURLSWEBIMG] [nvarchar](128) NULL,
	[HCXMLSWEBIMG] [bit] NULL,
	[HCGENQRDIG] [bit] NULL,
	[HCGENQRDURL] [nvarchar](100) NULL,
	[HCFECTOKMIAP] [datetime] NULL,
	[HCTOKENAPMIPRES] [nvarchar](4000) NULL,
	[HCNANDAPLAVALINI] [varbinary](max) NULL,
	[HCCONIMPHCEST] [bit] NULL,
	[HCNOEDITRE] [bit] NULL,
	[HCNOEDITFECHORRE] [bit] NULL,
	SysStartTime datetime2(7) NOT NULL,
	SysEndTime datetime2(7) NOT NULL
	)

ALTER TABLE HCNPARAME
ADD
    SysStartTime datetime2(7) GENERATED ALWAYS AS ROW START HIDDEN
        constraint DF_ValidFrom_HCNPARAME DEFAULT SYSUTCDATETIME()
    , SysEndTime datetime2(7) GENERATED ALWAYS AS ROW END HIDDEN
        constraint DF_ValidTo_HCNPARAME DEFAULT '9999-12-31 23:59:59.9999999'
    , PERIOD FOR SYSTEM_TIME (SysStartTime, SysEndTime);

ALTER TABLE HCNPARAME
    SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.HCNPARAME2));

select HCPDIAAUT, * from DGEMPRES01..HCNPARAME
select HCPDIAAUT, * from DGEMPRES01..HCNPARAME2