CREATE TABLE [dbo].[EE_NOM_R_VF_CD_CF](
	[MESAJ_EROARE] [varchar](255) NULL,
	[TIPMARIME] [char](50) NULL,
	[AN] [decimal](4, 0) NULL,
	[LUNA] [decimal](2, 0) NULL,
	[INVOICINGPARTY] [char](10) NULL,
	[CODCOMPANIE] [char](4) NULL,
	[REGIUNE_LC] [char](4) NULL,
	[PARTENERDEAFACERI] [char](10) NULL,
	[DENUMIREPARTENER] [varchar](255) NULL,
	[INSTALATIE] [char](10) NULL,
	[PUNCTDECONSUM] [char](10) NULL,
	[DELADATA] [char](10) NULL,
	[PANALADATA] [char](10) NULL,
	[CATEGORIETARIF] [char](50) NULL,
	[NIVELDETENSIUNE] [char](2) NULL,
	[DENUMIREDISTRIBUITOR] [varchar](255) NULL,
	[SEGMENTCLIENT] [char](3) NULL,
	[STARECLIENT] [char](20) NULL,
	[DIVIZIE] [char](2) NULL,
	[TIPCLIENT] [char](6) NULL,
	[VOLUMTOTAL] [decimal](38, 5) NULL,
	[VALOAREFARACV] [decimal](38, 5) NULL
) ON [PRIMARY]
GO
/
CREATE TABLE [dbo].[EE_NOM_R_VF_COST_ACH_TRANS](
	[AN] [smallint] NULL,
	[LUNA] [smallint] NULL,
	[MESAJ_EROARE] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/
CREATE TABLE [dbo].[EE_NOM_R_VF_DELTA_CUT_OFF](
	[MESAJ_EROARE] [varchar](255) NULL,
	[TIPMARIME] [char](50) NULL,
	[AN] [decimal](4, 0) NULL,
	[LUNA] [decimal](2, 0) NULL,
	[INVOICINGPARTY] [char](10) NULL,
	[CODCOMPANIE] [char](4) NULL,
	[REGIUNE_LC] [char](4) NULL,
	[PARTENERDEAFACERI] [char](10) NULL,
	[DENUMIREPARTENER] [varchar](255) NULL,
	[INSTALATIE] [char](10) NULL,
	[PUNCTDECONSUM] [char](10) NULL,
	[LOCALITATE] [varchar](255) NULL,
	[DELADATA] [char](10) NULL,
	[PANALADATA] [char](10) NULL,
	[CATEGORIETARIF] [char](50) NULL,
	[NIVELDETENSIUNE] [char](2) NULL,
	[DENUMIREDISTRIBUITOR] [varchar](255) NULL,
	[SEGMENTCLIENT] [char](3) NULL,
	[STARECLIENT] [char](20) NULL,
	[DIVIZIE] [char](2) NULL,
	[TIPCLIENT] [char](6) NULL,
	[VOLUMTOTAL] [decimal](38, 5) NULL,
	[VALOAREFARACV] [decimal](38, 5) NULL,
	[COSTDISTRIBUTIE] [decimal](38, 5) NULL
) ON [PRIMARY]
GO
/
CREATE TABLE [dbo].[EE_NOM_R_VF_DIF](
	[MESAJ_EROARE] [varchar](255) NULL,
	[TIPMARIME] [char](50) NULL,
	[AN] [decimal](4, 0) NULL,
	[LUNA] [decimal](2, 0) NULL,
	[INVOICINGPARTY] [char](10) NULL,
	[CODCOMPANIE] [char](4) NULL,
	[REGIUNE_LC] [char](4) NULL,
	[PARTENERDEAFACERI] [char](10) NULL,
	[DENUMIREPARTENER] [varchar](255) NULL,
	[INSTALATIE] [char](10) NULL,
	[PUNCTDECONSUM] [char](10) NULL,
	[LOCALITATE] [varchar](255) NULL,
	[DELADATA] [char](10) NULL,
	[PANALADATA] [char](10) NULL,
	[CATEGORIETARIF] [char](50) NULL,
	[NIVELDETENSIUNE] [char](2) NULL,
	[DENUMIREDISTRIBUITOR] [varchar](255) NULL,
	[SEGMENTCLIENT] [char](3) NULL,
	[STARECLIENT] [char](20) NULL,
	[DIVIZIE] [char](2) NULL,
	[TIPCLIENT] [char](6) NULL,
	[VOLUMTOTAL] [decimal](38, 5) NULL,
	[VALOAREFARACV] [decimal](38, 5) NULL
) ON [PRIMARY]
GO
/
CREATE TABLE [dbo].[EE_NOM_R_VF_FACT](
	[MESAJ_EROARE] [varchar](255) NULL,
	[TIPMARIME] [char](50) NULL,
	[AN] [decimal](4, 0) NULL,
	[LUNA] [decimal](2, 0) NULL,
	[INVOICINGPARTY] [char](10) NULL,
	[CODCOMPANIE] [char](4) NULL,
	[REGIUNE_LC] [char](4) NULL,
	[REGIUNE_PORTOFOLIU] [char](10) NULL,
	[PARTENERDEAFACERI] [char](10) NULL,
	[DENUMIREPARTENER] [varchar](255) NULL,
	[IDMANAGER] [varchar](50) NULL,
	[DENUMIREMANAGER] [varchar](50) NULL,
	[CUI] [char](20) NULL,
	[INSTALATIE] [char](10) NULL,
	[PUNCTDECONSUM] [char](10) NULL,
	[CODINDUSTRIE] [char](4) NULL,
	[DESCRIERECODINDUSTRIE] [varchar](255) NULL,
	[LOCALITATE] [varchar](255) NULL,
	[DELADATA] [char](10) NULL,
	[PANALADATA] [char](10) NULL,
	[CATEGORIETARIF] [char](50) NULL,
	[NIVELDETENSIUNE] [char](2) NULL,
	[DENUMIREDISTRIBUITOR] [varchar](255) NULL,
	[SEGMENTCLIENT] [char](3) NULL,
	[SUBSEGMENT] [char](10) NULL,
	[STARECLIENT] [char](20) NULL,
	[DIVIZIE] [char](2) NULL,
	[TIPCLIENT] [char](6) NULL,
	[VOLUMTOTAL] [decimal](38, 5) NULL,
	[VALOAREFARACV] [decimal](38, 5) NULL,
	[ABATERE] [decimal](38, 5) NULL,
	[VALOAREBONIFICATIE] [decimal](38, 5) NULL
) ON [PRIMARY]
GO
/
CREATE TABLE [dbo].[EE_NOM_R_VF_ID_SUBPOR](
	[MESAJ_EROARE] [varchar](255) NULL,
	[PARTENERDEAFACERI] [char](10) NULL,
	[COD] [char](2) NULL,
	[MOD_DE] [varchar](20) NULL,
	[MOD_TIMP] [datetime] NULL
) ON [PRIMARY]
GO
/
CREATE TABLE [dbo].[EE_NOM_R_VF_MAPARE_CURBA](
	[MESAJ_EROARE] [varchar](255) NULL,
	[INSTALATIE] [char](10) NULL,
	[COD] [char](50) NULL,
	[MOD_DE] [varchar](20) NULL,
	[MOD_TIMP] [datetime] NULL
) ON [PRIMARY]
GO
/
CREATE TABLE [dbo].[EE_NOM_R_VF_MAPARE_SUBPOR](
	[MESAJ_EROARE] [varchar](255) NULL,
	[PARTENERDEAFACERI] [char](10) NULL,
	[COD] [varchar](50) NULL,
	[MOD_DE] [varchar](20) NULL,
	[MOD_TIMP] [datetime] NULL
) ON [PRIMARY]
GO
/
CREATE TABLE [dbo].[EE_NOM_R_VF_TARIF_DISTR](
	[MESAJ_EROARE] [varchar](255) NOT NULL,
	[DENUMIREDISTRIBUITOR] [varchar](255) NULL,
	[NIVELDETENSIUNE] [char](2) NULL,
	[DELAANLUNA] [char](6) NULL,
	[PANALAANLUNA] [char](6) NULL,
	[TARIF_DISTR] [decimal](38, 5) NULL,
	[MOD_DE] [varchar](20) NULL,
	[MOD_TIMP] [datetime] NULL
) ON [PRIMARY]
GO
