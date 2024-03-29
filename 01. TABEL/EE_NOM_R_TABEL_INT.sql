CREATE TABLE [dbo].[EE_NOM_R_INT_ACH_CANT_OFERTA](
	[AN_RAPORT] [smallint] NOT NULL,
	[LUNA_RAPORT] [smallint] NOT NULL,
	[PARTENERDEAFACERI] [char](10) NOT NULL,
	[CURBA] [varchar](50) NOT NULL,
	[L_01] [float] NULL,
	[L_02] [float] NULL,
	[L_03] [float] NULL,
	[L_04] [float] NULL,
	[L_05] [float] NULL,
	[L_06] [float] NULL,
	[L_07] [float] NULL,
	[L_08] [float] NULL,
	[L_09] [float] NULL,
	[L_10] [float] NULL,
	[L_11] [float] NULL,
	[L_12] [float] NULL,
	[MOD_DE] [varchar](20) NOT NULL,
	[MOD_TIMP] [datetime] NOT NULL,
 CONSTRAINT [PK_EE_NOM_R_INT_ACH_CANT_OFERTA_1] PRIMARY KEY CLUSTERED 
(
	[AN_RAPORT] ASC,
	[LUNA_RAPORT] ASC,
	[PARTENERDEAFACERI] ASC,
	[CURBA] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/
CREATE TABLE [dbo].[EE_NOM_R_INT_ACH_MEDIE](
	[AN] [decimal](4, 0) NOT NULL,
	[LUNA] [decimal](2, 0) NOT NULL,
	[STARECLIENT] [char](20) NOT NULL,
	[TARIF_ACH_MEDIE] [decimal](38, 5) NOT NULL,
	[MOD_DE] [varchar](20) NOT NULL,
	[MOD_TIMP] [datetime] NOT NULL,
 CONSTRAINT [PK_EE_NOM_R_INT_ACH_MEDIE] PRIMARY KEY CLUSTERED 
(
	[AN] ASC,
	[LUNA] ASC,
	[STARECLIENT] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/
CREATE TABLE [dbo].[EE_NOM_R_INT_ACH_P3](
	[AN] [decimal](4, 0) NOT NULL,
	[LUNA] [decimal](2, 0) NOT NULL,
	[PARTENERDEAFACERI] [char](10) NOT NULL,
	[SUBPOR] [char](2) NOT NULL,
	[TARIF_ACH_MEDIE] [decimal](38, 5) NOT NULL,
	[MOD_DE] [varchar](20) NOT NULL,
	[MOD_TIMP] [datetime] NOT NULL,
 CONSTRAINT [EE_NOM_R_INT_ACH_P3_v1] PRIMARY KEY CLUSTERED 
(
	[AN] ASC,
	[LUNA] ASC,
	[PARTENERDEAFACERI] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/
CREATE TABLE [dbo].[EE_NOM_R_INT_ACH_POR](
	[AN] [smallint] NOT NULL,
	[LUNA] [smallint] NOT NULL,
	[DATA_REF] [date] NOT NULL,
	[ORA_CONS] [float] NOT NULL,
	[CANT_ACH_CONTR] [float] NULL,
	[COST_ACH_CONTR] [float] NULL,
	[CANT_ACH_PZU] [float] NULL,
	[COST_ACH_PZU] [float] NULL,
	[COST_MED_ACH_ECH] [float] NULL,
	[MOD_DE] [varchar](20) NOT NULL,
	[MOD_TIMP] [datetime] NOT NULL,
 CONSTRAINT [PK_EE_NOM_R_INT_ACH_POR] PRIMARY KEY CLUSTERED 
(
	[AN] ASC,
	[LUNA] ASC,
	[DATA_REF] ASC,
	[ORA_CONS] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/
CREATE TABLE [dbo].[EE_NOM_R_INT_ACH_PROF](
	[AN] [decimal](4, 0) NOT NULL,
	[LUNA] [decimal](2, 0) NOT NULL,
	[PARTENERDEAFACERI] [char](10) NOT NULL,
	[INSTALATIE] [char](10) NOT NULL,
	[SEGMENTCLIENT] [char](3) NOT NULL,
	[TARIF_ACH_PROFILAT_INITIAL] [decimal](38, 5) NULL,
 CONSTRAINT [PK_EE_NOM_R_INT_ACH_PROF] PRIMARY KEY CLUSTERED 
(
	[AN] ASC,
	[LUNA] ASC,
	[PARTENERDEAFACERI] ASC,
	[INSTALATIE] ASC,
	[SEGMENTCLIENT] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/
CREATE TABLE [dbo].[EE_NOM_R_INT_ACH_SUBPOR_BANDA](
	[AN] [smallint] NOT NULL,
	[LUNA] [smallint] NOT NULL,
	[PARTENERDEAFACERI] [char](10) NOT NULL,
	[DATA_OFERTA] [date] NOT NULL,
	[VALABIL_DELA] [date] NOT NULL,
	[VALABIL_PANALA] [date] NOT NULL,
	[CANT_BANDA_ORA] [float] NOT NULL,
	[PRET_BANDA_ORA] [float] NOT NULL,
	[MOD_DE] [varchar](20) NOT NULL,
	[MOD_TIMP] [datetime] NOT NULL,
 CONSTRAINT [PK_EE_NOM_R_INT_ACH_SUBPOR_BANDA] PRIMARY KEY CLUSTERED 
(
	[AN] ASC,
	[LUNA] ASC,
	[PARTENERDEAFACERI] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/
CREATE TABLE [dbo].[EE_NOM_R_INT_ACH_SUBPOR_PZU](
	[AN_RAPORT] [smallint] NOT NULL,
	[LUNA_RAPORT] [smallint] NOT NULL,
	[DATA_REF] [date] NOT NULL,
	[ORA_CONS] [float] NOT NULL,
	[DATA_OFERTA] [date] NOT NULL,
	[PRET_PZU] [float] NOT NULL,
	[ID] [decimal](18, 0) NOT NULL,
	[MOD_DE] [varchar](20) NOT NULL,
	[MOD_TIMP] [datetime] NOT NULL,
 CONSTRAINT [PK_EE_NOM_R_INT_ACH_SUBPOR_PZU_1] PRIMARY KEY CLUSTERED 
(
	[AN_RAPORT] ASC,
	[LUNA_RAPORT] ASC,
	[DATA_REF] ASC,
	[ORA_CONS] ASC,
	[DATA_OFERTA] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/
CREATE TABLE [dbo].[EE_NOM_R_INT_CODCOMPANIE](
	[COD] [varchar](4) NOT NULL,
	[NUME] [nvarchar](100) NOT NULL,
	[MOD_DE] [varchar](20) NOT NULL,
	[MOD_TIMP] [datetime] NULL,
 CONSTRAINT [PK_EE_NOM_R_INT_CODCOMPANIE] PRIMARY KEY CLUSTERED 
(
	[COD] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/
CREATE TABLE [dbo].[EE_NOM_R_INT_COEF_CURBA](
	[DATA_CONS] [nvarchar](255) NULL,
	[ORA_CONS] [float] NULL,
	[INTERVAL_CONS] [nvarchar](255) NULL,
	[COD] [nvarchar](50) NULL,
	[COEF] [float] NULL,
	[MOD_DE] [varchar](20) NOT NULL,
	[MOD_TIMP] [datetime] NULL,
	[ID] [decimal](18, 0) NOT NULL,
 CONSTRAINT [PK_EE_NOM_R_COEF_CURBA] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/
CREATE TABLE [dbo].[EE_NOM_R_INT_DELTA_CUT_OFF](
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
CREATE TABLE [dbo].[EE_NOM_R_INT_DIF](
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
CREATE TABLE [dbo].[EE_NOM_R_INT_DIF_CD_CF](
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
	[DELADATA] [date] NULL,
	[PANALADATA] [date] NULL,
	[CATEGORIETARIF] [char](50) NULL,
	[NIVELDETENSIUNE] [char](2) NULL,
	[DENUMIREDISTRIBUITOR] [varchar](255) NULL,
	[SEGMENTCLIENT] [char](3) NULL,
	[SUBSEGMENT] [char](10) NULL,
	[STARECLIENT] [char](10) NULL,
	[DIVIZIE] [char](2) NULL,
	[TIPCLIENT] [char](6) NULL,
	[VOLUMTOTAL] [decimal](38, 5) NULL,
	[VALOAREFARACV] [decimal](38, 5) NULL
) ON [PRIMARY]
GO
/
CREATE TABLE [dbo].[EE_NOM_R_INT_DIVIZIE](
	[COD] [char](2) NOT NULL,
	[NUME] [nvarchar](20) NOT NULL,
	[MOD_DE] [varchar](20) NOT NULL,
	[MOD_TIMP] [datetime] NULL,
	[BLOC] [bit] NOT NULL,
 CONSTRAINT [PK_EE_NOM_R_INT_DIVIZIE] PRIMARY KEY CLUSTERED 
(
	[COD] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/
CREATE TABLE [dbo].[EE_NOM_R_INT_ENERGOINTENSIV](
	[PARTENERDEAFACERI] [char](10) NOT NULL,
	[DELADATA] [date] NOT NULL,
	[PANALADATA] [date] NOT NULL,
	[MOD_DE] [varchar](20) NOT NULL,
	[MOD_TIMP] [datetime] NOT NULL,
 CONSTRAINT [PK_EE_NOM_R_INT_ENERGOINTENSIV] PRIMARY KEY CLUSTERED 
(
	[PARTENERDEAFACERI] ASC,
	[DELADATA] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/
CREATE TABLE [dbo].[EE_NOM_R_INT_EXCL_ACH](
	[DIVIZIE] [char](2) NULL,
	[PARTENERDEAFACERI] [char](10) NOT NULL,
	[DENUMIREPARTENER] [varchar](255) NULL,
	[INSTALATIE] [char](10) NOT NULL,
	[DELAANLUNA] [char](6) NOT NULL,
	[PANALAANLUNA] [char](6) NOT NULL,
	[MOD_DE] [varchar](20) NOT NULL,
	[MOD_TIMP] [datetime] NOT NULL,
 CONSTRAINT [PK_EE_NOM_R_INT_EXCL_ACH] PRIMARY KEY CLUSTERED 
(
	[PARTENERDEAFACERI] ASC,
	[INSTALATIE] ASC,
	[DELAANLUNA] ASC,
	[PANALAANLUNA] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/
CREATE TABLE [dbo].[EE_NOM_R_INT_EXCL_DISTR](
	[DIVIZIE] [char](2) NULL,
	[PARTENERDEAFACERI] [char](10) NOT NULL,
	[DENUMIREPARTENER] [varchar](255) NULL,
	[INSTALATIE] [char](10) NOT NULL,
	[DELAANLUNA] [char](6) NOT NULL,
	[PANALAANLUNA] [char](6) NOT NULL,
	[MOD_DE] [varchar](20) NOT NULL,
	[MOD_TIMP] [datetime] NOT NULL,
 CONSTRAINT [PK_EE_NOM_R_INT_EXCL_DISTR] PRIMARY KEY CLUSTERED 
(
	[PARTENERDEAFACERI] ASC,
	[INSTALATIE] ASC,
	[DELAANLUNA] ASC,
	[PANALAANLUNA] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/
CREATE TABLE [dbo].[EE_NOM_R_INT_EXCL_TRANS](
	[DIVIZIE] [char](2) NULL,
	[PARTENERDEAFACERI] [char](10) NOT NULL,
	[DENUMIREPARTENER] [varchar](255) NULL,
	[INSTALATIE] [char](10) NOT NULL,
	[DELAANLUNA] [char](6) NOT NULL,
	[PANALAANLUNA] [char](6) NOT NULL,
	[MOD_DE] [varchar](20) NOT NULL,
	[MOD_TIMP] [datetime] NOT NULL,
 CONSTRAINT [PK_EE_NOM_R_INT_EXCL_TRANS] PRIMARY KEY CLUSTERED 
(
	[PARTENERDEAFACERI] ASC,
	[INSTALATIE] ASC,
	[DELAANLUNA] ASC,
	[PANALAANLUNA] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/
CREATE TABLE [dbo].[EE_NOM_R_INT_FACT](
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
CREATE TABLE [dbo].[EE_NOM_R_INT_FACT_CD_CF](
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
CREATE TABLE [dbo].[EE_NOM_R_INT_INVOICINGPARTY](
	[COD] [varchar](15) NOT NULL,
	[NUME] [nvarchar](100) NOT NULL,
	[MOD_DE] [varchar](20) NOT NULL,
	[MOD_TIMP] [datetime] NULL,
 CONSTRAINT [PK_EE_NOM_R_INT_INVOICINGPARTY] PRIMARY KEY CLUSTERED 
(
	[COD] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/
CREATE TABLE [dbo].[EE_NOM_R_INT_MANAGER](
	[IDMANAGER] [varchar](50) NOT NULL,
	[DENUMIREMANAGER] [varchar](50) NOT NULL,
	[MOD_DE] [varchar](20) NOT NULL,
	[MOD_TIMP] [datetime] NULL,
 CONSTRAINT [PK_EE_NOM_R_INT_MANAGER] PRIMARY KEY CLUSTERED 
(
	[IDMANAGER] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/
CREATE TABLE [dbo].[EE_NOM_R_INT_MAPARE_CURBA](
	[INSTALATIE] [char](10) NOT NULL,
	[COD] [char](50) NOT NULL,
	[MOD_DE] [varchar](20) NOT NULL,
	[MOD_TIMP] [datetime] NULL,
 CONSTRAINT [PK_EE_NOM_R_INT_MAPARE_CURBA] PRIMARY KEY CLUSTERED 
(
	[INSTALATIE] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/
CREATE TABLE [dbo].[EE_NOM_R_INT_MAPARE_SUBPOR](
	[PARTENERDEAFACERI] [char](10) NOT NULL,
	[COD] [char](2) NOT NULL,
	[MOD_DE] [varchar](20) NOT NULL,
	[MOD_TIMP] [datetime] NULL,
 CONSTRAINT [PK_EE_NOM_R_INT_MAPARE_SUBPOR] PRIMARY KEY CLUSTERED 
(
	[PARTENERDEAFACERI] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/
CREATE TABLE [dbo].[EE_NOM_R_INT_MM_CANT](
	[AN] [smallint] NOT NULL,
	[LUNA] [smallint] NOT NULL,
	[DIVIZIE] [char](2) NOT NULL,
	[SUBPORTOFOLIU] [char](2) NOT NULL,
	[CURBA] [varchar](3) NOT NULL,
	[STARECLIENT] [varchar](50) NOT NULL,
	[SEGMENTCLIENT] [char](3) NOT NULL,
	[CANT_FARA_CD_CF] [float] NULL,
	[MOD_DE] [varchar](20) NOT NULL,
	[ID_INST] [char](10) NOT NULL,
	[MOD_TIMP] [datetime] NULL
) ON [PRIMARY]
GO
/
CREATE TABLE [dbo].[EE_NOM_R_INT_NT](
	[COD] [varchar](2) NOT NULL,
	[DESCRIERE] [varchar](50) NOT NULL,
	[MOD_DE] [varchar](20) NOT NULL,
	[MOD_TIMP] [datetime] NOT NULL,
 CONSTRAINT [PK_EE_NOM_R_INT_NT] PRIMARY KEY CLUSTERED 
(
	[COD] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/
CREATE TABLE [dbo].[EE_NOM_R_INT_PER_CALC](
	[AN] [decimal](4, 0) NOT NULL,
	[LUNA] [decimal](2, 0) NOT NULL,
	[DEN_CALC] [char](20) NOT NULL,
 CONSTRAINT [PK_EE_NOM_R_INT_PER_CALC] PRIMARY KEY CLUSTERED 
(
	[AN] ASC,
	[LUNA] ASC,
	[DEN_CALC] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/
CREATE TABLE [dbo].[EE_NOM_R_INT_REG_LC](
	[COD] [varchar](10) NOT NULL,
	[MOD_DE] [varchar](20) NOT NULL,
	[MOD_TIMP] [datetime] NULL,
 CONSTRAINT [PK_EE_NOM_R_INT_REG_LC] PRIMARY KEY CLUSTERED 
(
	[COD] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/
CREATE TABLE [dbo].[EE_NOM_R_INT_REG_PORTOF](
	[COD] [varchar](10) NOT NULL,
	[MOD_DE] [varchar](20) NOT NULL,
	[MOD_TIMP] [datetime] NULL,
 CONSTRAINT [PK_EE_NOM_R_INT_REG_PORTOF] PRIMARY KEY CLUSTERED 
(
	[COD] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/
CREATE TABLE [dbo].[EE_NOM_R_INT_SEGMENT](
	[COD] [varchar](3) NOT NULL,
	[NUME] [nvarchar](100) NOT NULL,
	[MOD_DE] [varchar](20) NOT NULL,
	[MOD_TIMP] [datetime] NULL,
	[GROUP_SEGM] [varchar](10) NOT NULL,
 CONSTRAINT [PK_EE_NOM_R_INT_SEGMENT] PRIMARY KEY CLUSTERED 
(
	[COD] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/
CREATE TABLE [dbo].[EE_NOM_R_INT_STARE](
	[COD] [varchar](50) NOT NULL,
	[NUME] [varchar](20) NULL,
	[DIVIZIE] [varchar](2) NOT NULL,
	[MOD_DE] [varchar](20) NOT NULL,
	[MOD_TIMP] [datetime] NULL,
 CONSTRAINT [PK_EE_NOM_R_INT_STARE] PRIMARY KEY CLUSTERED 
(
	[COD] ASC,
	[DIVIZIE] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/
CREATE TABLE [dbo].[EE_NOM_R_INT_SUBPOR](
	[COD] [varchar](2) NOT NULL,
	[DESCRIERE] [varchar](100) NOT NULL,
	[DIVIZIE] [varchar](2) NOT NULL,
	[MOD_DE] [varchar](20) NOT NULL,
	[MOD_TIMP] [datetime] NULL,
 CONSTRAINT [PK_EE_NOM_R_INT_SUBPOR] PRIMARY KEY CLUSTERED 
(
	[COD] ASC,
	[DIVIZIE] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/
CREATE TABLE [dbo].[EE_NOM_R_INT_SUBSEGMENT](
	[COD] [varchar](10) NOT NULL,
	[MOD_DE] [varchar](20) NOT NULL,
	[MOD_TIMP] [datetime] NULL,
 CONSTRAINT [PK_EE_NOM_R_INT_SUBSEGMENT] PRIMARY KEY CLUSTERED 
(
	[COD] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/
CREATE TABLE [dbo].[EE_NOM_R_INT_TARIF_CD_CF](
	[NIVELDETENSIUNE] [char](2) NOT NULL,
	[DELAANLUNAZI] [char](8) NOT NULL,
	[PANALAANLUNAZI] [char](8) NOT NULL,
	[TARIF_CD_CF] [decimal](38, 5) NOT NULL,
	[MOD_DE] [varchar](20) NOT NULL,
	[MOD_TIMP] [datetime] NOT NULL,
 CONSTRAINT [PK_EE_NOM_R_INT_TARIF_CD_CF_1] PRIMARY KEY CLUSTERED 
(
	[NIVELDETENSIUNE] ASC,
	[DELAANLUNAZI] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/
CREATE TABLE [dbo].[EE_NOM_R_INT_TARIF_DISTR](
	[DENUMIREDISTRIBUITOR] [varchar](255) NOT NULL,
	[NIVELDETENSIUNE] [char](2) NOT NULL,
	[DELAANLUNAZI] [char](8) NOT NULL,
	[PANALAANLUNAZI] [char](8) NOT NULL,
	[TARIF_DISTR] [decimal](38, 5) NOT NULL,
	[MOD_DE] [varchar](20) NOT NULL,
	[MOD_TIMP] [datetime] NOT NULL,
 CONSTRAINT [PK_EE_NOM_R_INT_TARIF_DISTR] PRIMARY KEY CLUSTERED 
(
	[DENUMIREDISTRIBUITOR] ASC,
	[NIVELDETENSIUNE] ASC,
	[DELAANLUNAZI] ASC,
	[PANALAANLUNAZI] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/
CREATE TABLE [dbo].[EE_NOM_R_INT_TARIF_TRANS](
	[AN] [decimal](4, 0) NOT NULL,
	[LUNA] [decimal](2, 0) NOT NULL,
	[STARECLIENT] [char](20) NOT NULL,
	[TARIF_TRANS] [decimal](38, 5) NOT NULL,
	[MOD_DE] [varchar](20) NOT NULL,
	[MOD_TIMP] [datetime] NOT NULL,
 CONSTRAINT [PK_EE_NOM_R_INT_TARIF_TRANS] PRIMARY KEY CLUSTERED 
(
	[AN] ASC,
	[LUNA] ASC,
	[STARECLIENT] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/
CREATE TABLE [dbo].[EE_NOM_R_INT_TIP](
	[COD] [varchar](255) NOT NULL,
	[NUME] [varchar](255) NULL,
	[TIP] [varchar](6) NULL,
	[MOD_DE] [varchar](20) NOT NULL,
	[MOD_TIMP] [datetime] NULL,
 CONSTRAINT [PK_EE_NOM_R_INT_TIP] PRIMARY KEY CLUSTERED 
(
	[COD] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/
CREATE UNIQUE NONCLUSTERED INDEX [EE_NOM_R_INT_ACH_MEDIE_AU1] ON [dbo].[EE_NOM_R_INT_ACH_MEDIE]
(
	[AN] ASC,
	[LUNA] ASC,
	[STARECLIENT] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
GO
/
CREATE UNIQUE NONCLUSTERED INDEX [EE_NOM_R_INT_ACH_PROF_AU1] ON [dbo].[EE_NOM_R_INT_ACH_PROF]
(
	[AN] ASC,
	[INSTALATIE] ASC,
	[LUNA] ASC,
	[PARTENERDEAFACERI] ASC,
	[SEGMENTCLIENT] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
GO
/
CREATE UNIQUE NONCLUSTERED INDEX [EE_NOM_R_INT_EXCL_ACH_AU1] ON [dbo].[EE_NOM_R_INT_EXCL_ACH]
(
	[DELAANLUNA] ASC,
	[INSTALATIE] ASC,
	[PANALAANLUNA] ASC,
	[PARTENERDEAFACERI] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
GO
/
CREATE UNIQUE NONCLUSTERED INDEX [EE_NOM_R_INT_EXCL_DISTR_AU1] ON [dbo].[EE_NOM_R_INT_EXCL_DISTR]
(
	[DELAANLUNA] ASC,
	[INSTALATIE] ASC,
	[PANALAANLUNA] ASC,
	[PARTENERDEAFACERI] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
GO
/
CREATE UNIQUE NONCLUSTERED INDEX [EE_NOM_R_INT_EXCL_TRANS_AU1] ON [dbo].[EE_NOM_R_INT_EXCL_TRANS]
(
	[DELAANLUNA] ASC,
	[INSTALATIE] ASC,
	[PANALAANLUNA] ASC,
	[PARTENERDEAFACERI] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
GO
/
CREATE UNIQUE NONCLUSTERED INDEX [EE_NOM_R_INT_RATING_AU1] ON [dbo].[EE_NOM_R_INT_RATING]
(
	[AN] ASC,
	[PARTENERDEAFACERI] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
GO
/
CREATE UNIQUE NONCLUSTERED INDEX [EE_NOM_R_INT_TARIF_DISTR_AU1] ON [dbo].[EE_NOM_R_INT_TARIF_DISTR]
(
	[DELAANLUNAZI] ASC,
	[DENUMIREDISTRIBUITOR] ASC,
	[NIVELDETENSIUNE] ASC,
	[PANALAANLUNAZI] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
GO
/
CREATE UNIQUE NONCLUSTERED INDEX [EE_NOM_R_INT_TARIF_TRANS_AU1] ON [dbo].[EE_NOM_R_INT_TARIF_TRANS]
(
	[AN] ASC,
	[LUNA] ASC,
	[STARECLIENT] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EE_NOM_R_INT_ACH_CANT_OFERTA] ADD  CONSTRAINT [DF_EE_NOM_R_INT_ACH_CANT_OFERTA_MOD_TIMP]  DEFAULT (switchoffset(getdate(),'+03:00')) FOR [MOD_TIMP]
GO
ALTER TABLE [dbo].[EE_NOM_R_INT_ACH_MEDIE] ADD  CONSTRAINT [DF_EE_NOM_R_INT_ACH_MEDIE_MOD_TIMP]  DEFAULT (switchoffset(getdate(),'+03:00')) FOR [MOD_TIMP]
GO
ALTER TABLE [dbo].[EE_NOM_R_INT_ACH_P3] ADD  CONSTRAINT [DF_EE_NOM_R_INT_ACH_P3]  DEFAULT (switchoffset(getdate(),'+03:00')) FOR [MOD_TIMP]
GO
ALTER TABLE [dbo].[EE_NOM_R_INT_ACH_POR] ADD  CONSTRAINT [DF_EE_NOM_R_INT_ACH_POR_MOD_TIMP]  DEFAULT (switchoffset(getdate(),'+03:00')) FOR [MOD_TIMP]
GO
ALTER TABLE [dbo].[EE_NOM_R_INT_ACH_SUBPOR_BANDA] ADD  CONSTRAINT [DF_EE_NOM_R_INT_ACH_POR_P2_MOD_TIMP]  DEFAULT (switchoffset(getdate(),'+03:00')) FOR [MOD_TIMP]
GO
ALTER TABLE [dbo].[EE_NOM_R_INT_ACH_SUBPOR_PZU] ADD  CONSTRAINT [DF_EE_NOM_R_INT_ACH_SUBPOR_PZU_ID]  DEFAULT (NEXT VALUE FOR [dbo].[EE_NOM_R_INT_ACH_SUBPOR_PZU_SQ1]) FOR [ID]
GO
ALTER TABLE [dbo].[EE_NOM_R_INT_ACH_SUBPOR_PZU] ADD  CONSTRAINT [DF_EE_NOM_R_INT_ACH_SUBPOR_PZU_MOD_TIMP]  DEFAULT (switchoffset(getdate(),'+03:00')) FOR [MOD_TIMP]
GO
ALTER TABLE [dbo].[EE_NOM_R_INT_CODCOMPANIE] ADD  CONSTRAINT [DF_EE_NOM_R_INT_C__MOD_T__15E52B55]  DEFAULT (switchoffset(getdate(),'+03:00')) FOR [MOD_TIMP]
GO
ALTER TABLE [dbo].[EE_NOM_R_INT_COEF_CURBA] ADD  CONSTRAINT [DF_EE_NOM_R_INT_COEF_CURBA_MOD_TIMP_1]  DEFAULT (switchoffset(getdate(),'+03:00')) FOR [MOD_TIMP]
GO
ALTER TABLE [dbo].[EE_NOM_R_INT_COEF_CURBA] ADD  CONSTRAINT [DF_EE_NOM_R_INT_COEF_CURBA_ID]  DEFAULT (NEXT VALUE FOR [dbo].[EE_NOM_R_INT_COEF_CURBA_SQ1]) FOR [ID]
GO
ALTER TABLE [dbo].[EE_NOM_R_INT_DIVIZIE] ADD  CONSTRAINT [DF_EE_NOM_R_INT_DIVIZIE_MOD_TIMP]  DEFAULT (switchoffset(getdate(),'+03:00')) FOR [MOD_TIMP]
GO
ALTER TABLE [dbo].[EE_NOM_R_INT_DIVIZIE] ADD  CONSTRAINT [DF_EE_NOM_R_INT_DIVIZIE_BLOC]  DEFAULT ((0)) FOR [BLOC]
GO
ALTER TABLE [dbo].[EE_NOM_R_INT_ENERGOINTENSIV] ADD  CONSTRAINT [DF_EE_NOM_R_INT_ENERGOINTENSIV_MOD_TIMP]  DEFAULT (switchoffset(getdate(),'+03:00')) FOR [MOD_TIMP]
GO
ALTER TABLE [dbo].[EE_NOM_R_INT_EXCL_ACH] ADD  CONSTRAINT [DF_EE_NOM_R_INT_EXCL_ACH_MOD_TIMP]  DEFAULT (switchoffset(getdate(),'+03:00')) FOR [MOD_TIMP]
GO
ALTER TABLE [dbo].[EE_NOM_R_INT_EXCL_DISTR] ADD  CONSTRAINT [DF_EE_NOM_R_INT_EXCL_DISTR_MOD_TIMP]  DEFAULT (switchoffset(getdate(),'+03:00')) FOR [MOD_TIMP]
GO
ALTER TABLE [dbo].[EE_NOM_R_INT_EXCL_TRANS] ADD  CONSTRAINT [DF_EE_NOM_R_INT_EXCL_TRANS_MOD_TIMP]  DEFAULT (switchoffset(getdate(),'+03:00')) FOR [MOD_TIMP]
GO
ALTER TABLE [dbo].[EE_NOM_R_INT_INVOICINGPARTY] ADD  CONSTRAINT [DF_EE_NOM_R_INT_I__MOD_T__15E52B55]  DEFAULT (switchoffset(getdate(),'+03:00')) FOR [MOD_TIMP]
GO
ALTER TABLE [dbo].[EE_NOM_R_INT_MANAGER] ADD  CONSTRAINT [DF__EE_NOM_R_INT_M__MOD_T]  DEFAULT (switchoffset(getdate(),'+03:00')) FOR [MOD_TIMP]
GO
ALTER TABLE [dbo].[EE_NOM_R_INT_MAPARE_CURBA] ADD  CONSTRAINT [DF_EE_NOM_R_INT_MAPARE_CURBA_MOD_TIMP]  DEFAULT (switchoffset(getdate(),'+03:00')) FOR [MOD_TIMP]
GO
ALTER TABLE [dbo].[EE_NOM_R_INT_MAPARE_SUBPOR] ADD  CONSTRAINT [DF_EE_NOM_R_INT_MAPARE_SUBPOR_MOD_TIMP]  DEFAULT (switchoffset(getdate(),'+03:00')) FOR [MOD_TIMP]
GO
ALTER TABLE [dbo].[EE_NOM_R_INT_MM_CANT] ADD  CONSTRAINT [DF_EE_NOM_R_INT_MM_CANT_ID_INST]  DEFAULT ('MM'+Trim(str(NEXT VALUE FOR [dbo].[EE_NOM_R_INT_MM_CANT_SQ1]))) FOR [ID_INST]
GO
ALTER TABLE [dbo].[EE_NOM_R_INT_MM_CANT] ADD  CONSTRAINT [DF_EE_NOM_R_INT_MM_CANT_MOD_TIMP]  DEFAULT (switchoffset(getdate(),'+03:00')) FOR [MOD_TIMP]
GO
ALTER TABLE [dbo].[EE_NOM_R_INT_NT] ADD  CONSTRAINT [DF_EE_NOM_R_INT_NT__MOD_T]  DEFAULT (switchoffset(getdate(),'+03:00')) FOR [MOD_TIMP]
GO
ALTER TABLE [dbo].[EE_NOM_R_INT_REG_LC] ADD  CONSTRAINT [DF_EE_NOM_R_INT_LC__MOD_T]  DEFAULT (switchoffset(getdate(),'+03:00')) FOR [MOD_TIMP]
GO
ALTER TABLE [dbo].[EE_NOM_R_INT_REG_PORTOF] ADD  CONSTRAINT [DF_EE_NOM_R_INT_R__MOD_T]  DEFAULT (switchoffset(getdate(),'+03:00')) FOR [MOD_TIMP]
GO
ALTER TABLE [dbo].[EE_NOM_R_INT_SEGMENT] ADD  CONSTRAINT [DF_EE_NOM_R_INT_S__MOD_T__15E52B55]  DEFAULT (switchoffset(getdate(),'+03:00')) FOR [MOD_TIMP]
GO
ALTER TABLE [dbo].[EE_NOM_R_INT_STARE] ADD  CONSTRAINT [DF_EE_NOM_R_INT_STARE_MOD_TIMP]  DEFAULT (switchoffset(getdate(),'+03:00')) FOR [MOD_TIMP]
GO
ALTER TABLE [dbo].[EE_NOM_R_INT_SUBPOR] ADD  CONSTRAINT [DF_EE_NOM_R_INT_SUBPOR__MOD_T]  DEFAULT (switchoffset(getdate(),'+03:00')) FOR [MOD_TIMP]
GO
ALTER TABLE [dbo].[EE_NOM_R_INT_SUBSEGMENT] ADD  CONSTRAINT [DF__EE_NOM_R_INT_S__MOD_T]  DEFAULT (switchoffset(getdate(),'+03:00')) FOR [MOD_TIMP]
GO
ALTER TABLE [dbo].[EE_NOM_R_INT_TARIF_CD_CF] ADD  CONSTRAINT [DF_EE_NOM_R_INT_TARIF_CD_CF_MOD_TIMP]  DEFAULT (switchoffset(getdate(),'+03:00')) FOR [MOD_TIMP]
GO
ALTER TABLE [dbo].[EE_NOM_R_INT_TARIF_DISTR] ADD  CONSTRAINT [DF_EE_NOM_R_INT_TARIF_DISTR_MOD_TIMP]  DEFAULT (switchoffset(getdate(),'+03:00')) FOR [MOD_TIMP]
GO
ALTER TABLE [dbo].[EE_NOM_R_INT_TARIF_TRANS] ADD  CONSTRAINT [DF_EE_NOM_R_INT_TARIF_TRANS_MOD_TIMP]  DEFAULT (switchoffset(getdate(),'+03:00')) FOR [MOD_TIMP]
GO
ALTER TABLE [dbo].[EE_NOM_R_INT_TIP] ADD  CONSTRAINT [DF_EE_NOM_R_INT_TIP_MOD_TIMP]  DEFAULT (switchoffset(getdate(),'+03:00')) FOR [MOD_TIMP]
GO
ALTER TABLE [dbo].[EE_NOM_R_INT_PER_CALC]  WITH CHECK ADD  CONSTRAINT [CK_EE_NOM_R_INT_PER_CALC] CHECK  (([DEN_CALC]='CALC_ACH' OR [DEN_CALC]='CALC_DISTR' OR [DEN_CALC]='CALC_MAPARI' OR [DEN_CALC]='CALC_MARIMI'))
GO
ALTER TABLE [dbo].[EE_NOM_R_INT_PER_CALC] CHECK CONSTRAINT [CK_EE_NOM_R_INT_PER_CALC]
GO
ALTER TABLE [dbo].[EE_NOM_R_INT_STARE]  WITH CHECK ADD  CONSTRAINT [EE_NOM_R_INT_STARE_CK1] CHECK  (([NUME]='ATIPIC' OR [NUME]='AGENTSU' OR [NUME]='AGENTFUI' OR [NUME]='ELIGIBIL' OR [NUME] IS NULL))
GO
ALTER TABLE [dbo].[EE_NOM_R_INT_STARE] CHECK CONSTRAINT [EE_NOM_R_INT_STARE_CK1]
GO
ALTER TABLE [dbo].[EE_NOM_R_INT_STARE]  WITH CHECK ADD  CONSTRAINT [EE_NOM_R_INT_STARE_CK2] CHECK  (([DIVIZIE]='01'))
GO
ALTER TABLE [dbo].[EE_NOM_R_INT_STARE] CHECK CONSTRAINT [EE_NOM_R_INT_STARE_CK2]
GO
ALTER TABLE [dbo].[EE_NOM_R_INT_SUBPOR]  WITH CHECK ADD  CONSTRAINT [EE_NOM_R_INT_SUBPOR_CK1] CHECK  (([DIVIZIE]='01'))
GO
ALTER TABLE [dbo].[EE_NOM_R_INT_SUBPOR] CHECK CONSTRAINT [EE_NOM_R_INT_SUBPOR_CK1]
GO
ALTER TABLE [dbo].[EE_NOM_R_INT_TIP]  WITH CHECK ADD  CONSTRAINT [EE_NOM_R_INT_TIP_CK1] CHECK  (([TIP]='INTERN' OR [TIP]='EXTERN'))
GO
ALTER TABLE [dbo].[EE_NOM_R_INT_TIP] CHECK CONSTRAINT [EE_NOM_R_INT_TIP_CK1]
GO
/
CREATE  TRIGGER  [dbo].[EE_NOM_R_INT_CODCOMPANIE_T1] ON [dbo].[EE_NOM_R_INT_CODCOMPANIE]
INSTEAD OF DELETE,UPDATE
AS
BEGIN;
SET NOCOUNT ON;

	THROW 50001,'INREGISTRARILE NU POT FII STERSE DIN TABEL!', 1; 

END
GO
/
CREATE  TRIGGER  [dbo].[EE_NOM_R_INT_DIVIZIE_T1] ON [dbo].[EE_NOM_R_INT_DIVIZIE]
AFTER DELETE,INSERT
AS
BEGIN;
SET NOCOUNT ON;

	DECLARE @CHECK BIT;
	SELECT  @CHECK= BLOC FROM EE_NOM_R_INT_DIVIZIE GROUP BY BLOC ;

	IF @CHECK=1
		BEGIN

			RAISERROR ('INREGISTRARILE NU POT FII MODIFICATE!', 16, 1);
			ROLLBACK TRANSACTION;
		END

END
GO
ALTER TABLE [dbo].[EE_NOM_R_INT_DIVIZIE] ENABLE TRIGGER [EE_NOM_R_INT_DIVIZIE_T1]
GO
/
CREATE  TRIGGER  [dbo].[EE_NOM_R_INT_INVOICINGPARTY_T1] ON [dbo].[EE_NOM_R_INT_INVOICINGPARTY]
INSTEAD OF DELETE,UPDATE
AS
BEGIN;
SET NOCOUNT ON;

	THROW 50001,'INREGISTRARILE NU POT FII STERSE DIN TABEL!', 1; 

END
GO
ALTER TABLE [dbo].[EE_NOM_R_INT_INVOICINGPARTY] ENABLE TRIGGER [EE_NOM_R_INT_INVOICINGPARTY_T1]
GO
/
CREATE TRIGGER  [dbo].[EE_NOM_R_INT_MANAGER_T1]  ON [dbo].[EE_NOM_R_INT_MANAGER]
INSTEAD OF INSERT, UPDATE 
AS

BEGIN ;

-- pentru insert 

		     INSERT INTO dbo.EE_NOM_R_INT_MANAGER ( IDMANAGER,DENUMIREMANAGER,MOD_DE,MOD_TIMP)
		     SELECT          UPPER(TRIM(IDMANAGER)) AS IDMANAGER,UPPER(TRIM(DENUMIREMANAGER)) AS DENUMIREMANAGER , MOD_DE, SWITCHOFFSET(getdate(), '+03:00')  AS MOD_TIMP
		    FROM             INSERTED 
		    WHERE           NOT EXISTS ( SELECT * FROM DELETED  WHERE DELETED.IDMANAGER=INSERTED.IDMANAGER )

-- pentru update

		     UPDATE  a
		     SET          DENUMIREMANAGER=UPPER(TRIM(I.DENUMIREMANAGER)),								    
				     MOD_DE=I.MOD_DE,
				     MOD_TIMP= SWITCHOFFSET(getdate(), '+03:00')
		FROM dbo.EE_NOM_R_INT_MANAGER a INNER JOIN INSERTED I ON a.IDMANAGER=I.IDMANAGER
		WHERE EXISTS ( SELECT * FROM DELETED WHERE DELETED.IDMANAGER=I.IDMANAGER )

END;
GO
ALTER TABLE [dbo].[EE_NOM_R_INT_MANAGER] ENABLE TRIGGER [EE_NOM_R_INT_MANAGER_T1]
GO
/
CREATE  TRIGGER  [dbo].[EE_NOM_R_INT_MANAGER_T2] ON [dbo].[EE_NOM_R_INT_MANAGER]
INSTEAD OF DELETE
AS
BEGIN;
SET NOCOUNT ON;

	THROW 50001,'INREGISTRARILE NU POT FII STERSE DIN TABEL!', 1; 

END
GO
ALTER TABLE [dbo].[EE_NOM_R_INT_MANAGER] ENABLE TRIGGER [EE_NOM_R_INT_MANAGER_T2]
GO
/
CREATE TRIGGER  [dbo].[EE_NOM_R_INT_MM_CANT_T1]  ON [dbo].[EE_NOM_R_INT_MM_CANT]
INSTEAD OF INSERT
AS

BEGIN ;

-- for insert 

		     INSERT INTO dbo.EE_NOM_R_INT_MM_CANT (	 AN, LUNA, DIVIZIE, SUBPORTOFOLIU, CURBA, STARECLIENT, SEGMENTCLIENT,													
													 CANT_FARA_CD_CF, ID_INST , MOD_DE , MOD_TIMP )
		     SELECT     AN, LUNA, DIVIZIE, SUBPORTOFOLIU, TRIM(CURBA), STARECLIENT, SEGMENTCLIENT,
					    CANT_FARA_CD_CF,
					    'MM'+trim(str(next value for dbo.EE_NOM_R_INT_MM_CANT_SQ1)) as ID_INST, MOD_DE, SWITCHOFFSET(getdate(), '+03:00')  AS MOD_TIMP
		    FROM             INSERTED 
		    WHERE           NOT EXISTS ( SELECT * FROM DELETED  WHERE DELETED.ID_INST=INSERTED.ID_INST )

END;
GO
ALTER TABLE [dbo].[EE_NOM_R_INT_MM_CANT] ENABLE TRIGGER [EE_NOM_R_INT_MM_CANT_T1]
GO
/
CREATE  TRIGGER  [dbo].[EE_NOM_R_INT_NT_BLOCK] ON [dbo].[EE_NOM_R_INT_NT]
AFTER DELETE,INSERT,UPDATE
AS
BEGIN;
SET NOCOUNT ON;

			RAISERROR ('INREGISTRARILE NU POT FII MODIFICATE!', 16, 1);
			ROLLBACK TRANSACTION;

END
GO
ALTER TABLE [dbo].[EE_NOM_R_INT_NT] DISABLE TRIGGER [EE_NOM_R_INT_NT_BLOCK]
GO
/
CREATE TRIGGER  [dbo].[EE_NOM_R_INT_NT_T1]  ON [dbo].[EE_NOM_R_INT_NT]
INSTEAD OF INSERT, UPDATE 
AS

BEGIN ;

-- for insert 

		    INSERT INTO dbo.EE_NOM_R_INT_NT ( COD, DESCRIERE, MOD_DE, MOD_TIMP)
		    SELECT          UPPER(TRIM(COD)) AS COD,UPPER(TRIM(DESCRIERE)) AS DESCRIERE, MOD_DE, SWITCHOFFSET(getdate(), '+03:00')  AS MOD_TIMP
		    FROM             INSERTED 
		    WHERE           NOT EXISTS ( SELECT * FROM DELETED  WHERE DELETED.COD=INSERTED.COD )

-- for update

		     UPDATE  a
		     SET     DESCRIERE=UPPER(TRIM(I.DESCRIERE)),							    
				     MOD_DE=I.MOD_DE,
				     MOD_TIMP= SWITCHOFFSET(getdate(), '+03:00')
		FROM dbo.EE_NOM_R_INT_NT a INNER JOIN INSERTED I ON a.COD=I.COD
		WHERE EXISTS ( SELECT * FROM DELETED WHERE DELETED.COD=I.COD )

END;
GO
ALTER TABLE [dbo].[EE_NOM_R_INT_NT] ENABLE TRIGGER [EE_NOM_R_INT_NT_T1]
GO
/
CREATE  TRIGGER  [dbo].[EE_NOM_R_INT_NT_T2] ON [dbo].[EE_NOM_R_INT_NT]
INSTEAD OF DELETE
AS
BEGIN;
SET NOCOUNT ON;

	THROW 50001,'INREGISTRARILE NU POT FII STERSE DIN TABEL!', 1; 

END
GO
ALTER TABLE [dbo].[EE_NOM_R_INT_NT] ENABLE TRIGGER [EE_NOM_R_INT_NT_T2]
GO
/
CREATE TRIGGER  [dbo].[EE_NOM_R_INT_REG_PORTOF_T1]  ON [dbo].[EE_NOM_R_INT_REG_PORTOF]
INSTEAD OF INSERT, UPDATE 
AS

BEGIN ;

-- for insert 

		     INSERT INTO dbo.EE_NOM_R_INT_REG_PORTOF ( COD,MOD_DE,MOD_TIMP)
		     SELECT          UPPER(TRIM(COD)), MOD_DE, SWITCHOFFSET(getdate(), '+03:00')  AS MOD_TIMP
		    FROM             INSERTED 
		    WHERE           NOT EXISTS ( SELECT * FROM DELETED  WHERE DELETED.COD=INSERTED.COD )

-- for update

		     UPDATE  a
		     SET          MOD_DE=I.MOD_DE,
				     MOD_TIMP= SWITCHOFFSET(getdate(), '+03:00')
		FROM dbo.EE_NOM_R_INT_REG_PORTOF a INNER JOIN INSERTED I ON a.COD=I.COD
		WHERE EXISTS ( SELECT * FROM DELETED WHERE DELETED.COD=I.COD )

END;
GO
ALTER TABLE [dbo].[EE_NOM_R_INT_REG_PORTOF] ENABLE TRIGGER [EE_NOM_R_INT_REG_PORTOF_T1]
GO
/
CREATE  TRIGGER  [dbo].[EE_NOM_R_INT_REG_PORTOF_T2] ON [dbo].[EE_NOM_R_INT_REG_PORTOF]
INSTEAD OF DELETE
AS
BEGIN;
SET NOCOUNT ON;

	THROW 50001,'INREGISTRARILE NU POT FII STERSE DIN TABEL!', 1; 

END
GO
ALTER TABLE [dbo].[EE_NOM_R_INT_REG_PORTOF] ENABLE TRIGGER [EE_NOM_R_INT_REG_PORTOF_T2]
GO
/
CREATE TRIGGER  [dbo].[EE_NOM_R_INT_SEGMENT_T1]  ON [dbo].[EE_NOM_R_INT_SEGMENT]
INSTEAD OF INSERT, UPDATE 
AS

BEGIN ;

-- for insert 

		     INSERT INTO dbo.EE_NOM_R_INT_SEGMENT ( COD, NUME, MOD_DE, MOD_TIMP, GROUP_SEGM)
		     SELECT          UPPER(TRIM(COD)), UPPER(TRIM(NUME)), MOD_DE, SWITCHOFFSET(getdate(), '+03:00')  AS MOD_TIMP, UPPER(TRIM(GROUP_SEGM))
		    FROM             INSERTED 
		    WHERE           NOT EXISTS ( SELECT * FROM DELETED  WHERE DELETED.COD=INSERTED.COD )

-- for update

		     UPDATE  a
		     SET     
					 NUME=I.NUME,
					 GROUP_SEGM=I.GROUP_SEGM,
			         MOD_DE=I.MOD_DE,
				     MOD_TIMP= SWITCHOFFSET(getdate(), '+03:00')
		FROM dbo.EE_NOM_R_INT_SEGMENT a INNER JOIN INSERTED I ON a.COD=I.COD
		WHERE EXISTS ( SELECT * FROM DELETED WHERE DELETED.COD=I.COD )

END;
GO
ALTER TABLE [dbo].[EE_NOM_R_INT_SEGMENT] ENABLE TRIGGER [EE_NOM_R_INT_SEGMENT_T1]
GO
/
CREATE  TRIGGER  [dbo].[EE_NOM_R_INT_SEGMENT_T2] ON [dbo].[EE_NOM_R_INT_SEGMENT]
INSTEAD OF DELETE
AS
BEGIN;
SET NOCOUNT ON;

	THROW 50001,'INREGISTRARILE NU POT FII STERSE DIN TABEL!', 1; 

END
GO
ALTER TABLE [dbo].[EE_NOM_R_INT_SEGMENT] ENABLE TRIGGER [EE_NOM_R_INT_SEGMENT_T2]
GO
/
CREATE TRIGGER  [dbo].[EE_NOM_R_INT_STARE_T1]  ON [dbo].[EE_NOM_R_INT_STARE]
INSTEAD OF INSERT, UPDATE 
AS

BEGIN ;

-- for insert 

		    INSERT INTO dbo.EE_NOM_R_INT_STARE ( COD, NUME, DIVIZIE, MOD_DE,MOD_TIMP)
		    SELECT          UPPER(TRIM(COD)) AS COD, UPPER(TRIM(NUME)) AS NUME , UPPER(TRIM(DIVIZIE)) AS DIVIZIE, MOD_DE, SWITCHOFFSET(getdate(), '+02:00')  AS MOD_TIMP
		    FROM             INSERTED 
		    WHERE           NOT EXISTS ( SELECT * FROM DELETED  WHERE DELETED.COD=INSERTED.COD )

-- for update

		     UPDATE  a
		     SET      NUME=UPPER(TRIM(I.NUME)),
				     DIVIZIE=UPPER(TRIM(I.DIVIZIE)),
				     MOD_DE=I.MOD_DE,
				     MOD_TIMP= SWITCHOFFSET(getdate(), '+03:00')
		FROM dbo.EE_NOM_R_INT_STARE a INNER JOIN INSERTED I ON a.COD=I.COD
		WHERE EXISTS ( SELECT * FROM DELETED WHERE DELETED.COD=I.COD )

END;
GO
ALTER TABLE [dbo].[EE_NOM_R_INT_STARE] ENABLE TRIGGER [EE_NOM_R_INT_STARE_T1]
GO
/
CREATE  TRIGGER  [dbo].[EE_NOM_R_INT_STARE_T2] ON [dbo].[EE_NOM_R_INT_STARE]
INSTEAD OF DELETE
AS
BEGIN;
SET NOCOUNT ON;

	THROW 50001,'INREGISTRARILE NU POT FII STERSE DIN TABEL!', 1; 

END
GO
ALTER TABLE [dbo].[EE_NOM_R_INT_STARE] ENABLE TRIGGER [EE_NOM_R_INT_STARE_T2]
GO
/
CREATE TRIGGER  [dbo].[EE_NOM_R_INT_SUBPOR_T1]  ON [dbo].[EE_NOM_R_INT_SUBPOR]
INSTEAD OF INSERT, UPDATE 
AS

BEGIN ;

-- for insert 

		     INSERT INTO dbo.EE_NOM_R_INT_SUBPOR ( COD,DESCRIERE,DIVIZIE,MOD_DE,MOD_TIMP)
		     SELECT          UPPER(TRIM(COD)) AS COD,UPPER(TRIM(DESCRIERE)) AS DESCRIERE, UPPER(TRIM(DIVIZIE)) AS DIVIZIE, MOD_DE, SWITCHOFFSET(getdate(), '+03:00')  AS MOD_TIMP
		    FROM             INSERTED 
		    WHERE           NOT EXISTS ( SELECT * FROM DELETED  WHERE DELETED.COD=INSERTED.COD )

-- for update

		     UPDATE  a
		     SET          DESCRIERE=UPPER(TRIM(I.DESCRIERE)),
				     DIVIZIE=	UPPER(TRIM(I.DIVIZIE)),					    
				     MOD_DE=I.MOD_DE,
				     MOD_TIMP= SWITCHOFFSET(getdate(), '+03:00')
		FROM dbo.EE_NOM_R_INT_SUBPOR a INNER JOIN INSERTED I ON a.COD=I.COD
		WHERE EXISTS ( SELECT * FROM DELETED WHERE DELETED.COD=I.COD )

END;
GO
ALTER TABLE [dbo].[EE_NOM_R_INT_SUBPOR] ENABLE TRIGGER [EE_NOM_R_INT_SUBPOR_T1]
GO
/
CREATE TRIGGER  [dbo].[EE_NOM_R_INT_SUBPOR_T2] ON [dbo].[EE_NOM_R_INT_SUBPOR]
INSTEAD OF DELETE
AS
BEGIN;
SET NOCOUNT ON;

	THROW 50001,'INREGISTRARILE NU POT FII STERSE DIN TABEL!', 1; 

END
GO
ALTER TABLE [dbo].[EE_NOM_R_INT_SUBPOR] ENABLE TRIGGER [EE_NOM_R_INT_SUBPOR_T2]
GO
/
CREATE TRIGGER  [dbo].[EE_NOM_R_INT_SUBSEGMENT_T1]  ON [dbo].[EE_NOM_R_INT_SUBSEGMENT]
INSTEAD OF INSERT, UPDATE 
AS

BEGIN ;

-- for insert 

		     INSERT INTO dbo.EE_NOM_R_INT_SUBSEGMENT ( COD,MOD_DE,MOD_TIMP)
		     SELECT          UPPER(TRIM(COD)) AS COD, CURRENT_USER AS MOD_DE, SWITCHOFFSET(getdate(), '+03:00')  AS MOD_TIMP
		    FROM             INSERTED 
		    WHERE           NOT EXISTS ( SELECT * FROM DELETED  WHERE DELETED.COD=INSERTED.COD )

-- for update

		     UPDATE  a
		     SET          MOD_DE=I.MOD_DE,
				     MOD_TIMP= SWITCHOFFSET(getdate(), '+03:00')
		FROM dbo.EE_NOM_R_INT_SUBSEGMENT a INNER JOIN INSERTED I ON a.COD=I.COD
		WHERE EXISTS ( SELECT * FROM DELETED WHERE DELETED.COD=I.COD )

END;
GO
ALTER TABLE [dbo].[EE_NOM_R_INT_SUBSEGMENT] ENABLE TRIGGER [EE_NOM_R_INT_SUBSEGMENT_T1]
GO
/
CREATE  TRIGGER  [dbo].[EE_NOM_R_INT_SUBSEGMENT_T2] ON [dbo].[EE_NOM_R_INT_SUBSEGMENT]
INSTEAD OF DELETE
AS
BEGIN;
SET NOCOUNT ON;

	THROW 50001,'INREGISTRARILE NU POT FII STERSE DIN TABEL!', 1; 

END
GO
ALTER TABLE [dbo].[EE_NOM_R_INT_SUBSEGMENT] ENABLE TRIGGER [EE_NOM_R_INT_SUBSEGMENT_T2]
GO
/
CREATE TRIGGER  [dbo].[EE_NOM_R_INT_TIP_T1]  ON [dbo].[EE_NOM_R_INT_TIP]
INSTEAD OF INSERT, UPDATE 
AS

BEGIN ;

-- for insert 

		     INSERT INTO dbo.EE_NOM_R_INT_TIP ( COD, NUME, TIP, MOD_DE,MOD_TIMP)
		     SELECT          UPPER(TRIM(COD)) AS COD, UPPER(TRIM(NUME)) AS NUME , UPPER(TRIM(TIP)) AS TIP, MOD_DE, SWITCHOFFSET(getdate(), '+03:00')  AS MOD_TIMP
		    FROM             INSERTED 
		    WHERE           NOT EXISTS ( SELECT * FROM DELETED  WHERE DELETED.COD=INSERTED.COD )

-- for update

		     UPDATE  a
		     SET          NUME=UPPER(TRIM(I.NUME)),
				     TIP=UPPER(TRIM(I.TIP)),
				     MOD_DE=I.MOD_DE,
				     MOD_TIMP= SWITCHOFFSET(getdate(), '+03:00')
		FROM dbo.EE_NOM_R_INT_TIP a INNER JOIN INSERTED I ON a.COD=I.COD
		WHERE EXISTS ( SELECT * FROM DELETED WHERE DELETED.COD=I.COD )

END;
GO
ALTER TABLE [dbo].[EE_NOM_R_INT_TIP] ENABLE TRIGGER [EE_NOM_R_INT_TIP_T1]
GO
/
CREATE  TRIGGER  [dbo].[EE_NOM_R_INT_TIP_T2] ON [dbo].[EE_NOM_R_INT_TIP]
INSTEAD OF DELETE
AS
BEGIN;
SET NOCOUNT ON;

	THROW 50001,'INREGISTRARILE NU POT FII STERSE DIN TABEL!', 1; 

END
GO
ALTER TABLE [dbo].[EE_NOM_R_INT_TIP] ENABLE TRIGGER [EE_NOM_R_INT_TIP_T2]
GO
