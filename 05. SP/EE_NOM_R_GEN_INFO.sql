CREATE PROCEDURE [dbo].[gen_info_EE_NOM_R]
( 
@AN SMALLINT,
@LUNA SMALLINT
 )
AS
BEGIN

		SET XACT_ABORT, NOCOUNT ON;

EXEC dbo.master_EE_NOM_R_INREG @AN,@LUNA ;
EXEC dbo.master_EE_NOM_R_CALC_CANT_ORA @AN,@LUNA ; 
EXEC dbo.master_EE_NOM_R_CALC_SUBPOR @AN,@LUNA ;  
EXEC dbo.master_EE_NOM_R_CALC_COST_DISTR @AN,@LUNA ;  
EXEC dbo.master_EE_NOM_R_CALC_ACH @AN,@LUNA ; 
EXEC dbo.master_EE_NOM_R_CALC_MARJA @AN,@LUNA ;  

END


GO
