CREATE TABLE [dbo].[EE_NOM_R_CALC_ALOC_REST](
	[AN] [smallint] NOT NULL,
	[DATA_CONS] [datetime] NOT NULL,
	[LUNA] [smallint] NOT NULL,
	[COST_ACH_TOTAL] [float] NULL,
	[COST_ACH_ALOC] [float] NULL,
	[COST_ACH_REST] [float] NULL,
	[CANT_REST] [float] NULL,
	[COST_MED_ACH_REST] [float] NULL,
 CONSTRAINT [PK_EE_NOM_R_CALC_ALOC_REST] PRIMARY KEY CLUSTERED 
(
	[AN] ASC,
	[LUNA] ASC,
	[DATA_CONS] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/

CREATE TABLE [dbo].[EE_NOM_R_CALC_COEF_CURBA](
	[DATA_CONS] [datetime] NOT NULL,
	[INTERVAL_CONS] [char](4) NOT NULL,
	[AN] [smallint] NOT NULL,
	[LUNA] [smallint] NOT NULL,
	[LUNA_NUME] [varchar](50) NOT NULL,
	[ZI] [smallint] NOT NULL,
	[ZI_NUME] [varchar](50) NOT NULL,
	[ORA] [float] NOT NULL,
	[COD] [varchar](50) NOT NULL,
	[COEF] [float] NOT NULL,
	[MOD_DE] [varchar](20) NULL,
	[MOD_TIMP] [datetime] NULL,
 CONSTRAINT [PK_EE_NOM_R_CALC_COEF_CURBA] PRIMARY KEY CLUSTERED 
(
	[DATA_CONS] ASC,
	[COD] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
