CREATE PROCEDURE [dbo].[sp_EE_NOM_R_R_ACH_ORA]
(
@AN SMALLINT,
@LUNA SMALLINT 
)
AS
BEGIN ;

		SET XACT_ABORT , NOCOUNT ON;

		DECLARE @PARAMDEFINITON NVARCHAR(2000);
		DECLARE @SQLQUERY NVARCHAR(MAX);

		SET @PARAMDEFINITON =N'@AN SMALLINT, @LUNA SMALLINT ';

		SET @SQLQUERY= N'SELECT * FROM EE_NOM_R_MARIMI_ACH_ORA WHERE AN=@AN AND LUNA=@LUNA' ;

		Execute sp_Executesql  @SQLQUERY, @PARAMDEFINITON, @AN, @LUNA ;

END;

CREATE PROCEDURE [dbo].[sp_EE_NOM_R_R_ACH_POR]
@an smallint,
@luna smallint,
@start int = 0,
@length int = 10,
@search nvarchar(50) = null,
@sort nvarchar(50) = 'asc',
@sort_column nvarchar(50) = 'DATA_REF',
@limit int = null,
@ResCount int output,
@TotalCount int output
AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @SQLQUERY NVARCHAR(4000);
    DECLARE @SQLQUERYCOUNT NVARCHAR(4000);
    DECLARE @PARAMDEFINITION NVARCHAR(2000);
    DECLARE @SQLLIMIT NVARCHAR(100) = ' '; 

    IF @limit IS NOT NULL 
        SET @sqlLimit = 'top '+CAST(@limit AS NVARCHAR);
	SET @SQLQUERY = 'select '+@sqlLimit+' * FROM dbo.EE_NOM_R_INT_ACH_POR WHERE AN=@an AND LUNA=@luna AND (1=1) ';
	SET @SQLQUERYCOUNT = 'select '+@sqlLimit+' @ResCount = Count(*) FROM dbo.EE_NOM_R_INT_ACH_POR WHERE AN=@an AND LUNA=@luna AND (1=1) ';
                                
    IF @search IS NOT NULL 
	    BEGIN
		SET @SQLQUERY = @SQLQUERY + ' AND ( DATA_REF like ''%'+@search+'%'') '
		SET @SQLQUERYCOUNT = @SQLQUERYCOUNT + ' AND ( DATA_REF like ''%'+@search+'%'') '
	    END;
                
    SET @PARAMDEFINITION =	'
				@an smallint,
				@luna smallint,
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int,
				@ResCount int output
				';
                PRINT @SQLQUERYCOUNT;

    EXEC sp_Executesql @SQLQUERYCOUNT, @PARAMDEFINITION, @an, @luna, @search, @sort_column, @sort, @start, @length, @ResCount output

    SET @SQLQUERY = @SQLQUERY + 'order by '+@sort_column+' '+ @sort;
                                

    Set @SQLQUERY = @SQLQUERY + ' offset (@start) rows fetch next @length Rows only'; 
    
    Set @ParamDefinition =      ' 
				@an smallint,
				@luna smallint,
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int
				';
                PRINT @SQLQUERY;

    Execute sp_Executesql  @SQLQUERY, @PARAMDEFINITION, @an, @luna, @search, @sort_column, @sort, @start, @length

    SET @TotalCount=  ( SELECT COUNT(*) FROM dbo.EE_NOM_R_INT_ACH_POR WHERE AN=@an AND LUNA=@luna)
        
    If @@ERROR <> 0 GoTo ERRORHANDLER
    SET NOCOUNT OFF
    RETURN(0)
  
ERRORHANDLER:
    RETURN(@@ERROR)


END
GO
/
CREATE PROCEDURE [dbo].[sp_EE_NOM_R_R_ACH_POR_ERORI]
@start int = 0,
@length int = 10,
@search nvarchar(50) = null,
@sort nvarchar(50) = 'asc',
@sort_column nvarchar(50) = 'MESAJ_EROARE',
@limit int = null,
@ResCount int output,
@TotalCount int output
AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @SQLQUERY NVARCHAR(4000);
    DECLARE @SQLQUERYCOUNT NVARCHAR(4000);
    DECLARE @PARAMDEFINITION NVARCHAR(2000);
    DECLARE @SQLLIMIT NVARCHAR(100) = ' '; 

    IF @limit IS NOT NULL 
        SET @sqlLimit = 'top '+CAST(@limit AS NVARCHAR);
	SET @SQLQUERY = 'select '+@sqlLimit+' * FROM dbo.EE_NOM_R_VF_COST_ACH_TRANS WHERE (1=1) ';
	SET @SQLQUERYCOUNT = 'select '+@sqlLimit+' @ResCount = Count(*) FROM dbo.EE_NOM_R_VF_COST_ACH_TRANS WHERE (1=1) ';
                                
    IF @search IS NOT NULL 
	    BEGIN
		SET @SQLQUERY = @SQLQUERY + ' AND ( MESAJ_EROARE like ''%'+@search+'%'') '
		SET @SQLQUERYCOUNT = @SQLQUERYCOUNT + ' AND ( MESAJ_EROARE like ''%'+@search+'%'') '
	    END;
                
    SET @PARAMDEFINITION =	'
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int,
				@ResCount int output
				';
                PRINT @SQLQUERYCOUNT;

    EXEC sp_Executesql @SQLQUERYCOUNT, @PARAMDEFINITION, @search, @sort_column, @sort, @start, @length, @ResCount output

    SET @SQLQUERY = @SQLQUERY + 'order by '+@sort_column+' '+ @sort;
                                

    Set @SQLQUERY = @SQLQUERY + ' offset (@start) rows fetch next @length Rows only'; 
    
    Set @ParamDefinition =      ' 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int
				';
                PRINT @SQLQUERY;

    Execute sp_Executesql  @SQLQUERY, @PARAMDEFINITION, @search, @sort_column, @sort, @start, @length

    SET @TotalCount=  ( SELECT COUNT(*) FROM dbo.EE_NOM_R_VF_COST_ACH_TRANS )
        
    If @@ERROR <> 0 GoTo ERRORHANDLER
    SET NOCOUNT OFF
    RETURN(0)
  
ERRORHANDLER:
    RETURN(@@ERROR)


END
GO
/

CREATE PROCEDURE [dbo].[sp_EE_NOM_R_R_ACH_SUBPOR]
(
@AN SMALLINT,
@LUNA SMALLINT 
)
AS
BEGIN ;

		SET XACT_ABORT , NOCOUNT ON;

		DECLARE @PARAMDEFINITON NVARCHAR(2000);
		DECLARE @SQLQUERY NVARCHAR(MAX);

		SET @PARAMDEFINITON =N'@AN SMALLINT, @LUNA SMALLINT ';

		SET @SQLQUERY= N'SELECT * FROM EE_NOM_R_MARIMI_ACH_SUBPOR WHERE AN=@AN AND LUNA=@LUNA' ;

		Execute sp_Executesql  @SQLQUERY, @PARAMDEFINITON, @AN, @LUNA ;

END;
GO
/

CREATE PROCEDURE [dbo].[sp_EE_NOM_R_R_ALOC]
(
@AN SMALLINT,
@LUNA SMALLINT 
)
AS
BEGIN ;

		SET XACT_ABORT , NOCOUNT ON;

		DECLARE @PARAMDEFINITON NVARCHAR(2000);
		DECLARE @SQLQUERY NVARCHAR(MAX);

		SET @PARAMDEFINITON =N'@AN SMALLINT, @LUNA SMALLINT ';

		SET @SQLQUERY= N'SELECT * FROM EE_NOM_R_MARIMI_ALOC WHERE AN=@AN AND LUNA=@LUNA' ;

		Execute sp_Executesql  @SQLQUERY, @PARAMDEFINITON, @AN, @LUNA ;

END;
GO
/

CREATE PROCEDURE [dbo].[sp_EE_NOM_R_R_CD_CF]
@an smallint,
@luna smallint,
@start int = 0,
@length int = 10,
@search nvarchar(50) = null,
@sort nvarchar(50) = 'asc',
@sort_column nvarchar(50) = 'INSTALATIE',
@limit int = null,
@ResCount int output,
@TotalCount int output
AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @SQLQUERY NVARCHAR(4000);
    DECLARE @SQLQUERYCOUNT NVARCHAR(4000);
    DECLARE @PARAMDEFINITION NVARCHAR(2000);
    DECLARE @SQLLIMIT NVARCHAR(100) = ' '; 

    IF @limit IS NOT NULL 
        SET @sqlLimit = 'top '+CAST(@limit AS NVARCHAR);
	SET @SQLQUERY = 'select '+@sqlLimit+' * FROM dbo.EE_NOM_R_INT_FACT_CD_CF WHERE AN=@an and LUNA=@luna and (1=1)';
	SET @SQLQUERYCOUNT = 'select '+@sqlLimit+' @ResCount = Count(*) FROM dbo.EE_NOM_R_INT_FACT_CD_CF WHERE AN=@an and LUNA=@luna and (1=1)';
                                
    IF @search IS NOT NULL 
	    BEGIN
		SET @SQLQUERY = @SQLQUERY + ' AND ( AN like ''%'+@search+'%'' or LUNA like ''%'+@search+'%'' or INSTALATIE like ''%'+@search+'%'' or PARTENERDEAFACERI like ''%'+@search+'%'' or DENUMIREPARTENER like ''%'+@search+'%'') '
		SET @SQLQUERYCOUNT = @SQLQUERYCOUNT + ' AND ( AN like ''%'+@search+'%'' or LUNA like ''%'+@search+'%'' or INSTALATIE like ''%'+@search+'%'' or PARTENERDEAFACERI like ''%'+@search+'%'' or DENUMIREPARTENER like ''%'+@search+'%'') '
	    END;
                
    SET @PARAMDEFINITION =	'
				@an smallint,
				@luna smallint,
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int,
				@ResCount int output
				';
                PRINT @SQLQUERYCOUNT;

    EXEC sp_Executesql @SQLQUERYCOUNT, @PARAMDEFINITION, @an, @luna, @search, @sort_column, @sort, @start, @length, @ResCount output

    SET @SQLQUERY = @SQLQUERY + 'order by '+@sort_column+' '+ @sort;
                                

    Set @SQLQUERY = @SQLQUERY + ' offset (@start) rows fetch next @length Rows only'; 
    
    Set @ParamDefinition =      ' 
				@an smallint,
				@luna smallint,
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int
				';
                PRINT @SQLQUERY;

    Execute sp_Executesql  @SQLQUERY, @PARAMDEFINITION, @an, @luna, @search, @sort_column, @sort, @start, @length

    SET @TotalCount=  ( SELECT COUNT(*) FROM dbo.EE_NOM_R_INT_FACT_CD_CF WHERE AN=@an and LUNA=@luna )
        
    If @@ERROR <> 0 GoTo ERRORHANDLER
    SET NOCOUNT OFF
    RETURN(0)
  
ERRORHANDLER:
    RETURN(@@ERROR)


END
GO
/

CREATE PROCEDURE [dbo].[sp_EE_NOM_R_R_CD_CF_ERORI]
@start int = 0,
@length int = 10,
@search nvarchar(50) = null,
@sort nvarchar(50) = 'asc',
@sort_column nvarchar(50) = 'INSTALATIE',
@limit int = null,
@ResCount int output,
@TotalCount int output
AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @SQLQUERY NVARCHAR(4000);
    DECLARE @SQLQUERYCOUNT NVARCHAR(4000);
    DECLARE @PARAMDEFINITION NVARCHAR(2000);
    DECLARE @SQLLIMIT NVARCHAR(100) = ' '; 

    IF @limit IS NOT NULL 
        SET @sqlLimit = 'top '+CAST(@limit AS NVARCHAR);
	SET @SQLQUERY = 'select '+@sqlLimit+' * FROM dbo.EE_NOM_R_VF_CD_CF WHERE (1=1)';
	SET @SQLQUERYCOUNT = 'select '+@sqlLimit+' @ResCount = Count(*) FROM dbo.EE_NOM_R_VF_CD_CF WHERE (1=1)';
                                
    IF @search IS NOT NULL 
	    BEGIN
		SET @SQLQUERY = @SQLQUERY + ' AND ( INSTALATIE like ''%'+@search+'%'' or PARTENERDEAFACERI like ''%'+@search+'%'' or DENUMIREPARTENER like ''%'+@search+'%'') '
		SET @SQLQUERYCOUNT = @SQLQUERYCOUNT + ' AND ( INSTALATIE like ''%'+@search+'%'' or PARTENERDEAFACERI like ''%'+@search+'%'' or DENUMIREPARTENER like ''%'+@search+'%'') '
	    END;
                
    SET @PARAMDEFINITION =	'
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int,
				@ResCount int output
				';
                PRINT @SQLQUERYCOUNT;

    EXEC sp_Executesql @SQLQUERYCOUNT, @PARAMDEFINITION, @search, @sort_column, @sort, @start, @length, @ResCount output

    SET @SQLQUERY = @SQLQUERY + 'order by '+@sort_column+' '+ @sort;
                                

    Set @SQLQUERY = @SQLQUERY + ' offset (@start) rows fetch next @length Rows only'; 
    
    Set @ParamDefinition =      ' 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int
				';
                PRINT @SQLQUERY;

    Execute sp_Executesql  @SQLQUERY, @PARAMDEFINITION, @search, @sort_column, @sort, @start, @length

    SET @TotalCount=  ( SELECT COUNT(*) FROM dbo.EE_NOM_R_VF_CD_CF )
        
    If @@ERROR <> 0 GoTo ERRORHANDLER
    SET NOCOUNT OFF
    RETURN(0)
  
ERRORHANDLER:
    RETURN(@@ERROR)


END
GO
/

CREATE PROCEDURE [dbo].[sp_EE_NOM_R_R_DELTA_CUT_OFF]
@an smallint,
@luna smallint,
@start int = 0,
@length int = 10,
@search nvarchar(50) = null,
@sort nvarchar(50) = 'asc',
@sort_column nvarchar(50) = 'INSTALATIE',
@limit int = null,
@ResCount int output,
@TotalCount int output
AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @SQLQUERY NVARCHAR(4000);
    DECLARE @SQLQUERYCOUNT NVARCHAR(4000);
    DECLARE @PARAMDEFINITION NVARCHAR(2000);
    DECLARE @SQLLIMIT NVARCHAR(100) = ' '; 

    IF @limit IS NOT NULL 
        SET @sqlLimit = 'top '+CAST(@limit AS NVARCHAR);
	SET @SQLQUERY = 'select '+@sqlLimit+' * FROM dbo.EE_NOM_R_INT_DELTA_CUT_OFF WHERE AN=@an and LUNA=@luna and (1=1)';
	SET @SQLQUERYCOUNT = 'select '+@sqlLimit+' @ResCount = Count(*) FROM dbo.EE_NOM_R_INT_DELTA_CUT_OFF WHERE AN=@an and LUNA=@luna and (1=1)';
                                
    IF @search IS NOT NULL 
	    BEGIN
		SET @SQLQUERY = @SQLQUERY + ' AND ( AN like ''%'+@search+'%'' or LUNA like ''%'+@search+'%'' or INSTALATIE like ''%'+@search+'%'' or PARTENERDEAFACERI like ''%'+@search+'%'' or DENUMIREPARTENER like ''%'+@search+'%'') '
		SET @SQLQUERYCOUNT = @SQLQUERYCOUNT + ' AND ( AN like ''%'+@search+'%'' or LUNA like ''%'+@search+'%'' or INSTALATIE like ''%'+@search+'%'' or PARTENERDEAFACERI like ''%'+@search+'%'' or DENUMIREPARTENER like ''%'+@search+'%'') '
	    END;
                
    SET @PARAMDEFINITION =	'
				@an smallint,
				@luna smallint,
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int,
				@ResCount int output
				';
                PRINT @SQLQUERYCOUNT;

    EXEC sp_Executesql @SQLQUERYCOUNT, @PARAMDEFINITION, @an, @luna, @search, @sort_column, @sort, @start, @length, @ResCount output

    SET @SQLQUERY = @SQLQUERY + 'order by '+@sort_column+' '+ @sort;
                                

    Set @SQLQUERY = @SQLQUERY + ' offset (@start) rows fetch next @length Rows only'; 
    
    Set @ParamDefinition =      ' 
				@an smallint,
				@luna smallint,
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int
				';
                PRINT @SQLQUERY;

    Execute sp_Executesql  @SQLQUERY, @PARAMDEFINITION, @an, @luna, @search, @sort_column, @sort, @start, @length

    SET @TotalCount=  ( SELECT COUNT(*) FROM dbo.EE_NOM_R_INT_DELTA_CUT_OFF WHERE AN=@an and LUNA=@luna )
        
    If @@ERROR <> 0 GoTo ERRORHANDLER
    SET NOCOUNT OFF
    RETURN(0)
  
ERRORHANDLER:
    RETURN(@@ERROR)


END
GO
/

CREATE PROCEDURE [dbo].[sp_EE_NOM_R_R_DELTA_CUT_OFF_ERORI]
@start int = 0,
@length int = 10,
@search nvarchar(50) = null,
@sort nvarchar(50) = 'asc',
@sort_column nvarchar(50) = 'INSTALATIE',
@limit int = null,
@ResCount int output,
@TotalCount int output
AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @SQLQUERY NVARCHAR(4000);
    DECLARE @SQLQUERYCOUNT NVARCHAR(4000);
    DECLARE @PARAMDEFINITION NVARCHAR(2000);
    DECLARE @SQLLIMIT NVARCHAR(100) = ' '; 

    IF @limit IS NOT NULL 
        SET @sqlLimit = 'top '+CAST(@limit AS NVARCHAR);
	SET @SQLQUERY = 'select '+@sqlLimit+' * FROM dbo.EE_NOM_R_VF_DELTA_CUT_OFF WHERE (1=1)';
	SET @SQLQUERYCOUNT = 'select '+@sqlLimit+' @ResCount = Count(*) FROM dbo.EE_NOM_R_VF_DELTA_CUT_OFF WHERE (1=1)';
                                
    IF @search IS NOT NULL 
	    BEGIN
		SET @SQLQUERY = @SQLQUERY + ' AND ( INSTALATIE like ''%'+@search+'%'' or PARTENERDEAFACERI like ''%'+@search+'%'' or DENUMIREPARTENER like ''%'+@search+'%'') '
		SET @SQLQUERYCOUNT = @SQLQUERYCOUNT + ' AND ( INSTALATIE like ''%'+@search+'%'' or PARTENERDEAFACERI like ''%'+@search+'%'' or DENUMIREPARTENER like ''%'+@search+'%'') '
	    END;
                
    SET @PARAMDEFINITION =	'
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int,
				@ResCount int output
				';
                PRINT @SQLQUERYCOUNT;

    EXEC sp_Executesql @SQLQUERYCOUNT, @PARAMDEFINITION, @search, @sort_column, @sort, @start, @length, @ResCount output

    SET @SQLQUERY = @SQLQUERY + 'order by '+@sort_column+' '+ @sort;
                                

    Set @SQLQUERY = @SQLQUERY + ' offset (@start) rows fetch next @length Rows only'; 
    
    Set @ParamDefinition =      ' 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int
				';
                PRINT @SQLQUERY;

    Execute sp_Executesql  @SQLQUERY, @PARAMDEFINITION, @search, @sort_column, @sort, @start, @length

    SET @TotalCount=  ( SELECT COUNT(*) FROM dbo.EE_NOM_R_VF_DELTA_CUT_OFF )
        
    If @@ERROR <> 0 GoTo ERRORHANDLER
    SET NOCOUNT OFF
    RETURN(0)
  
ERRORHANDLER:
    RETURN(@@ERROR)


END
GO
/

CREATE PROCEDURE [dbo].[sp_EE_NOM_R_R_DIF]
@an smallint,
@luna smallint,
@start int = 0,
@length int = 10,
@search nvarchar(50) = null,
@sort nvarchar(50) = 'asc',
@sort_column nvarchar(50) = 'INSTALATIE',
@limit int = null,
@ResCount int output,
@TotalCount int output
AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @SQLQUERY NVARCHAR(4000);
    DECLARE @SQLQUERYCOUNT NVARCHAR(4000);
    DECLARE @PARAMDEFINITION NVARCHAR(2000);
    DECLARE @SQLLIMIT NVARCHAR(100) = ' '; 

    IF @limit IS NOT NULL 
        SET @sqlLimit = 'top '+CAST(@limit AS NVARCHAR);
	SET @SQLQUERY = 'select '+@sqlLimit+' * FROM dbo.EE_NOM_R_INT_DIF WHERE AN=@an and LUNA=@luna and (1=1)';
	SET @SQLQUERYCOUNT = 'select '+@sqlLimit+' @ResCount = Count(*) FROM dbo.EE_NOM_R_INT_DIF WHERE AN=@an and LUNA=@luna and (1=1)';
                                
    IF @search IS NOT NULL 
	    BEGIN
		SET @SQLQUERY = @SQLQUERY + ' AND ( AN like ''%'+@search+'%'' or LUNA like ''%'+@search+'%'' or INSTALATIE like ''%'+@search+'%'' or PARTENERDEAFACERI like ''%'+@search+'%'' or DENUMIREPARTENER like ''%'+@search+'%'') '
		SET @SQLQUERYCOUNT = @SQLQUERYCOUNT + ' AND ( AN like ''%'+@search+'%'' or LUNA like ''%'+@search+'%'' or INSTALATIE like ''%'+@search+'%'' or PARTENERDEAFACERI like ''%'+@search+'%'' or DENUMIREPARTENER like ''%'+@search+'%'') '
	    END;
                
    SET @PARAMDEFINITION =	'
				@an smallint,
				@luna smallint,
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int,
				@ResCount int output
				';
                PRINT @SQLQUERYCOUNT;

    EXEC sp_Executesql @SQLQUERYCOUNT, @PARAMDEFINITION, @an, @luna, @search, @sort_column, @sort, @start, @length, @ResCount output

    SET @SQLQUERY = @SQLQUERY + 'order by '+@sort_column+' '+ @sort;
                                

    Set @SQLQUERY = @SQLQUERY + ' offset (@start) rows fetch next @length Rows only'; 
    
    Set @ParamDefinition =      ' 
				@an smallint,
				@luna smallint,
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int
				';
                PRINT @SQLQUERY;

    Execute sp_Executesql  @SQLQUERY, @PARAMDEFINITION, @an, @luna, @search, @sort_column, @sort, @start, @length

    SET @TotalCount=  ( SELECT COUNT(*) FROM dbo.EE_NOM_R_INT_DIF WHERE AN=@an and LUNA=@luna )
        
    If @@ERROR <> 0 GoTo ERRORHANDLER
    SET NOCOUNT OFF
    RETURN(0)
  
ERRORHANDLER:
    RETURN(@@ERROR)


END
GO
/

CREATE PROCEDURE [dbo].[sp_EE_NOM_R_R_DIF_ERORI]
@start int = 0,
@length int = 10,
@search nvarchar(50) = null,
@sort nvarchar(50) = 'asc',
@sort_column nvarchar(50) = 'INSTALATIE',
@limit int = null,
@ResCount int output,
@TotalCount int output
AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @SQLQUERY NVARCHAR(4000);
    DECLARE @SQLQUERYCOUNT NVARCHAR(4000);
    DECLARE @PARAMDEFINITION NVARCHAR(2000);
    DECLARE @SQLLIMIT NVARCHAR(100) = ' '; 

    IF @limit IS NOT NULL 
        SET @sqlLimit = 'top '+CAST(@limit AS NVARCHAR);
	SET @SQLQUERY = 'select '+@sqlLimit+' * FROM dbo.EE_NOM_R_VF_DIF WHERE (1=1)';
	SET @SQLQUERYCOUNT = 'select '+@sqlLimit+' @ResCount = Count(*) FROM dbo.EE_NOM_R_VF_DIF WHERE (1=1)';
                                
    IF @search IS NOT NULL 
	    BEGIN
		SET @SQLQUERY = @SQLQUERY + ' AND ( INSTALATIE like ''%'+@search+'%'' or PARTENERDEAFACERI like ''%'+@search+'%'' or DENUMIREPARTENER like ''%'+@search+'%'') '
		SET @SQLQUERYCOUNT = @SQLQUERYCOUNT + ' AND ( INSTALATIE like ''%'+@search+'%'' or PARTENERDEAFACERI like ''%'+@search+'%'' or DENUMIREPARTENER like ''%'+@search+'%'') '
	    END;
                
    SET @PARAMDEFINITION =	'
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int,
				@ResCount int output
				';
                PRINT @SQLQUERYCOUNT;

    EXEC sp_Executesql @SQLQUERYCOUNT, @PARAMDEFINITION, @search, @sort_column, @sort, @start, @length, @ResCount output

    SET @SQLQUERY = @SQLQUERY + 'order by '+@sort_column+' '+ @sort;
                                

    Set @SQLQUERY = @SQLQUERY + ' offset (@start) rows fetch next @length Rows only'; 
    
    Set @ParamDefinition =      ' 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int
				';
                PRINT @SQLQUERY;

    Execute sp_Executesql  @SQLQUERY, @PARAMDEFINITION, @search, @sort_column, @sort, @start, @length

    SET @TotalCount=  ( SELECT COUNT(*) FROM dbo.EE_NOM_R_VF_DIF )
        
    If @@ERROR <> 0 GoTo ERRORHANDLER
    SET NOCOUNT OFF
    RETURN(0)
  
ERRORHANDLER:
    RETURN(@@ERROR)


END
GO
/

CREATE PROCEDURE [dbo].[sp_EE_NOM_R_R_FACT]
@an smallint,
@luna smallint,
@start int = 0,
@length int = 10,
@search nvarchar(50) = null,
@sort nvarchar(50) = 'asc',
@sort_column nvarchar(50) = 'INSTALATIE',
@limit int = null,
@ResCount int output,
@TotalCount int output
AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @SQLQUERY NVARCHAR(4000);
    DECLARE @SQLQUERYCOUNT NVARCHAR(4000);
    DECLARE @PARAMDEFINITION NVARCHAR(2000);
    DECLARE @SQLLIMIT NVARCHAR(100) = ' '; 

    IF @limit IS NOT NULL 
        SET @sqlLimit = 'top '+CAST(@limit AS NVARCHAR);
	SET @SQLQUERY = 'select '+@sqlLimit+' * FROM dbo.EE_NOM_R_INT_FACT WHERE AN=@an and LUNA=@luna and (1=1)';
	SET @SQLQUERYCOUNT = 'select '+@sqlLimit+' @ResCount = Count(*) FROM dbo.EE_NOM_R_INT_FACT WHERE AN=@an and LUNA=@luna and (1=1)';
                                
    IF @search IS NOT NULL 
	    BEGIN
		SET @SQLQUERY = @SQLQUERY + ' AND ( AN like ''%'+@search+'%'' or LUNA like ''%'+@search+'%'' or INSTALATIE like ''%'+@search+'%'' or PARTENERDEAFACERI like ''%'+@search+'%'' or DENUMIREPARTENER like ''%'+@search+'%'') '
		SET @SQLQUERYCOUNT = @SQLQUERYCOUNT + ' AND ( AN like ''%'+@search+'%'' or LUNA like ''%'+@search+'%'' or INSTALATIE like ''%'+@search+'%'' or PARTENERDEAFACERI like ''%'+@search+'%'' or DENUMIREPARTENER like ''%'+@search+'%'') '
	    END;
                
    SET @PARAMDEFINITION =	'
				@an smallint,
				@luna smallint,
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int,
				@ResCount int output
				';
                PRINT @SQLQUERYCOUNT;

    EXEC sp_Executesql @SQLQUERYCOUNT, @PARAMDEFINITION, @an, @luna, @search, @sort_column, @sort, @start, @length, @ResCount output

    SET @SQLQUERY = @SQLQUERY + 'order by '+@sort_column+' '+ @sort;
                                

    Set @SQLQUERY = @SQLQUERY + ' offset (@start) rows fetch next @length Rows only'; 
    
    Set @ParamDefinition =      ' 
				@an smallint,
				@luna smallint,
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int
				';
                PRINT @SQLQUERY;

    Execute sp_Executesql  @SQLQUERY, @PARAMDEFINITION, @an, @luna, @search, @sort_column, @sort, @start, @length

    SET @TotalCount=  ( SELECT COUNT(*) FROM dbo.EE_NOM_R_INT_FACT WHERE AN=@an and LUNA=@luna )
        
    If @@ERROR <> 0 GoTo ERRORHANDLER
    SET NOCOUNT OFF
    RETURN(0)
  
ERRORHANDLER:
    RETURN(@@ERROR)


END
GO
/

CREATE PROCEDURE [dbo].[sp_EE_NOM_R_R_FACT_ERORI]
@start int = 0,
@length int = 10,
@search nvarchar(50) = null,
@sort nvarchar(50) = 'asc',
@sort_column nvarchar(50) = 'INSTALATIE',
@limit int = null,
@ResCount int output,
@TotalCount int output
AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @SQLQUERY NVARCHAR(4000);
    DECLARE @SQLQUERYCOUNT NVARCHAR(4000);
    DECLARE @PARAMDEFINITION NVARCHAR(2000);
    DECLARE @SQLLIMIT NVARCHAR(100) = ' '; 

    IF @limit IS NOT NULL 
        SET @sqlLimit = 'top '+CAST(@limit AS NVARCHAR);
	SET @SQLQUERY = 'select '+@sqlLimit+' * FROM dbo.EE_NOM_R_VF_FACT WHERE (1=1)';
	SET @SQLQUERYCOUNT = 'select '+@sqlLimit+' @ResCount = Count(*) FROM dbo.EE_NOM_R_VF_FACT WHERE (1=1)';
                                
    IF @search IS NOT NULL 
	    BEGIN
		SET @SQLQUERY = @SQLQUERY + ' AND (  INSTALATIE like ''%'+@search+'%'' or PARTENERDEAFACERI like ''%'+@search+'%'' or DENUMIREPARTENER like ''%'+@search+'%'') '
		SET @SQLQUERYCOUNT = @SQLQUERYCOUNT + ' AND ( INSTALATIE like ''%'+@search+'%'' or PARTENERDEAFACERI like ''%'+@search+'%'' or DENUMIREPARTENER like ''%'+@search+'%'') '
	    END;
                
    SET @PARAMDEFINITION =	'
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int,
				@ResCount int output
				';
                PRINT @SQLQUERYCOUNT;

    EXEC sp_Executesql @SQLQUERYCOUNT, @PARAMDEFINITION, @search, @sort_column, @sort, @start, @length, @ResCount output

    SET @SQLQUERY = @SQLQUERY + 'order by '+@sort_column+' '+ @sort;
                                

    Set @SQLQUERY = @SQLQUERY + ' offset (@start) rows fetch next @length Rows only'; 
    
    Set @ParamDefinition =      ' 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int
				';
                PRINT @SQLQUERY;

    Execute sp_Executesql  @SQLQUERY, @PARAMDEFINITION, @search, @sort_column, @sort, @start, @length

    SET @TotalCount=  ( SELECT COUNT(*) FROM dbo.EE_NOM_R_VF_FACT )
        
    If @@ERROR <> 0 GoTo ERRORHANDLER
    SET NOCOUNT OFF
    RETURN(0)
  
ERRORHANDLER:
    RETURN(@@ERROR)


END
GO
/

CREATE PROCEDURE [dbo].[sp_EE_NOM_R_R_MAPARE_CURBA_ERORI]
@start int = 0,
@length int = 10,
@search nvarchar(50) = null,
@sort nvarchar(50) = 'asc',
@sort_column nvarchar(50) = 'INSTALATIE',
@limit int = null,
@ResCount int output,
@TotalCount int output
AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @SQLQUERY NVARCHAR(4000);
    DECLARE @SQLQUERYCOUNT NVARCHAR(4000);
    DECLARE @PARAMDEFINITION NVARCHAR(2000);
    DECLARE @SQLLIMIT NVARCHAR(100) = ' '; 

    IF @limit IS NOT NULL 
        SET @sqlLimit = 'top '+CAST(@limit AS NVARCHAR);
	SET @SQLQUERY = 'select '+@sqlLimit+' * FROM dbo.EE_NOM_R_VF_MAPARE_CURBA WHERE (1=1)';
	SET @SQLQUERYCOUNT = 'select '+@sqlLimit+' @ResCount = Count(*) FROM dbo.EE_NOM_R_VF_MAPARE_CURBA WHERE (1=1)';
                                
    IF @search IS NOT NULL 
	    BEGIN
		SET @SQLQUERY = @SQLQUERY + ' AND ( INSTALATIE like ''%'+@search+'%'' ) '
		SET @SQLQUERYCOUNT = @SQLQUERYCOUNT + ' AND ( INSTALATIE like ''%'+@search+'%'' ) '
	    END;
                
    SET @PARAMDEFINITION =	'
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int,
				@ResCount int output
				';
                PRINT @SQLQUERYCOUNT;

    EXEC sp_Executesql @SQLQUERYCOUNT, @PARAMDEFINITION, @search, @sort_column, @sort, @start, @length, @ResCount output

    SET @SQLQUERY = @SQLQUERY + 'order by '+@sort_column+' '+ @sort;
                                

    Set @SQLQUERY = @SQLQUERY + ' offset (@start) rows fetch next @length Rows only'; 
    
    Set @ParamDefinition =      ' 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int
				';
                PRINT @SQLQUERY;

    Execute sp_Executesql  @SQLQUERY, @PARAMDEFINITION, @search, @sort_column, @sort, @start, @length

    SET @TotalCount=  ( SELECT COUNT(*) FROM dbo.EE_NOM_R_VF_MAPARE_CURBA )
        
    If @@ERROR <> 0 GoTo ERRORHANDLER
    SET NOCOUNT OFF
    RETURN(0)
  
ERRORHANDLER:
    RETURN(@@ERROR)


END
GO
/

CREATE PROCEDURE [dbo].[sp_EE_NOM_R_R_MARIMI]
(
@AN SMALLINT,
@LUNA SMALLINT 
)
AS
BEGIN ;

		SET XACT_ABORT , NOCOUNT ON;

		DECLARE @PARAMDEFINITON NVARCHAR(2000);
		DECLARE @SQLQUERY NVARCHAR(MAX);

		SET @PARAMDEFINITON =N'@AN SMALLINT, @LUNA SMALLINT ';

		SET @SQLQUERY= N'SELECT * FROM EE_NOM_R_MARIMI WHERE AN=@AN AND LUNA=@LUNA' ;

		Execute sp_Executesql  @SQLQUERY, @PARAMDEFINITON, @AN, @LUNA ;

END;
GO
/

CREATE PROCEDURE [dbo].[sp_EE_NOM_R_R_TARIF_DISTR]
@start int = 0,
@length int = 10,
@search nvarchar(50) = null,
@sort nvarchar(50) = 'asc',
@sort_column nvarchar(50) = 'DENUMIREDISTRIBUITOR',
@limit int = null,
@ResCount int output,
@TotalCount int output
AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @SQLQUERY NVARCHAR(4000);
    DECLARE @SQLQUERYCOUNT NVARCHAR(4000);
    DECLARE @PARAMDEFINITION NVARCHAR(2000);
    DECLARE @SQLLIMIT NVARCHAR(100) = ' '; 

    IF @limit IS NOT NULL 
        SET @sqlLimit = 'top '+CAST(@limit AS NVARCHAR);
	SET @SQLQUERY = 'select '+@sqlLimit+' * FROM dbo.EE_NOM_R_INT_TARIF_DISTR WHERE (1=1) ';
	SET @SQLQUERYCOUNT = 'select '+@sqlLimit+' @ResCount = Count(*) FROM dbo.EE_NOM_R_INT_TARIF_DISTR WHERE (1=1) ';
                                
    IF @search IS NOT NULL 
	    BEGIN
		SET @SQLQUERY = @SQLQUERY + ' AND ( DENUMIREDISTRIBUITOR like ''%'+@search+'%'') '
		SET @SQLQUERYCOUNT = @SQLQUERYCOUNT + ' AND ( DENUMIREDISTRIBUITOR like ''%'+@search+'%'') '
	    END;
                
    SET @PARAMDEFINITION =	'
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int,
				@ResCount int output
				';
                PRINT @SQLQUERYCOUNT;

    EXEC sp_Executesql @SQLQUERYCOUNT, @PARAMDEFINITION, @search, @sort_column, @sort, @start, @length, @ResCount output

    SET @SQLQUERY = @SQLQUERY + 'order by '+@sort_column+' '+ @sort;
                                

    Set @SQLQUERY = @SQLQUERY + ' offset (@start) rows fetch next @length Rows only'; 
    
    Set @ParamDefinition =      ' 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int
				';
                PRINT @SQLQUERY;

    Execute sp_Executesql  @SQLQUERY, @PARAMDEFINITION, @search, @sort_column, @sort, @start, @length

    SET @TotalCount=  ( SELECT COUNT(*) FROM dbo.EE_NOM_R_INT_TARIF_DISTR )
        
    If @@ERROR <> 0 GoTo ERRORHANDLER
    SET NOCOUNT OFF
    RETURN(0)
  
ERRORHANDLER:
    RETURN(@@ERROR)


END
GO
/

CREATE PROCEDURE [dbo].[sp_EE_NOM_R_R_TARIF_DISTR_ERORI]
@start int = 0,
@length int = 10,
@search nvarchar(50) = null,
@sort nvarchar(50) = 'asc',
@sort_column nvarchar(50) = 'DENUMIREDISTRIBUITOR',
@limit int = null,
@ResCount int output,
@TotalCount int output
AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @SQLQUERY NVARCHAR(4000);
    DECLARE @SQLQUERYCOUNT NVARCHAR(4000);
    DECLARE @PARAMDEFINITION NVARCHAR(2000);
    DECLARE @SQLLIMIT NVARCHAR(100) = ' '; 

    IF @limit IS NOT NULL 
        SET @sqlLimit = 'top '+CAST(@limit AS NVARCHAR);
	SET @SQLQUERY = 'select '+@sqlLimit+' * FROM dbo.EE_NOM_R_VF_TARIF_DISTR WHERE (1=1) ';
	SET @SQLQUERYCOUNT = 'select '+@sqlLimit+' @ResCount = Count(*) FROM dbo.EE_NOM_R_VF_TARIF_DISTR WHERE (1=1) ';
                                
    IF @search IS NOT NULL 
	    BEGIN
		SET @SQLQUERY = @SQLQUERY + ' AND ( DENUMIREDISTRIBUITOR like ''%'+@search+'%'') '
		SET @SQLQUERYCOUNT = @SQLQUERYCOUNT + ' AND ( DENUMIREDISTRIBUITOR like ''%'+@search+'%'') '
	    END;
                
    SET @PARAMDEFINITION =	'
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int,
				@ResCount int output
				';
                PRINT @SQLQUERYCOUNT;

    EXEC sp_Executesql @SQLQUERYCOUNT, @PARAMDEFINITION, @search, @sort_column, @sort, @start, @length, @ResCount output

    SET @SQLQUERY = @SQLQUERY + 'order by '+@sort_column+' '+ @sort;
                                

    Set @SQLQUERY = @SQLQUERY + ' offset (@start) rows fetch next @length Rows only'; 
    
    Set @ParamDefinition =      ' 
				@search nvarchar(50),
				@sort_column nvarchar(50),
				@sort nvarchar(50),
				@start int,
				@length int
				';
                PRINT @SQLQUERY;

    Execute sp_Executesql  @SQLQUERY, @PARAMDEFINITION, @search, @sort_column, @sort, @start, @length

    SET @TotalCount=  ( SELECT COUNT(*) FROM dbo.EE_NOM_R_VF_TARIF_DISTR )
        
    If @@ERROR <> 0 GoTo ERRORHANDLER
    SET NOCOUNT OFF
    RETURN(0)
  
ERRORHANDLER:
    RETURN(@@ERROR)


END
GO
