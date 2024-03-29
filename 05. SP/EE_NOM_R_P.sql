CREATE PROCEDURE [dbo].[sp_EE_NOM_R_MAPARI]
(
@AN SMALLINT,
@LUNA SMALLINT
)
AS
BEGIN

	SET NOCOUNT ON;

	SET XACT_ABORT , NOCOUNT ON;


				DECLARE @OBJECT_NAME  CHAR(100);
				DECLARE @AN_CALC CHAR(4);
				DECLARE @LUNA_CALC CHAR(2);
				DECLARE @MSG VARCHAR(100);
				SET     @OBJECT_NAME=OBJECT_NAME(@@PROCID) ;

				SET     @OBJECT_NAME=OBJECT_NAME(@@PROCID) ;
				SET     @MSG ='START ACTUALIZARE TABELE DE MAPARI !';
				SET		@AN_CALC=TRIM(CONVERT(CHAR(4),@AN)) ;
				SET		@LUNA_CALC=TRIM(CONVERT(CHAR(2),@LUNA)) ;

				EXEC sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'INFORMARE' ,@MSG
				PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG

				BEGIN TRY ;

-- => DATA PROCESSING INTO TABEL EE_NOM_R_MAPARI_PA

			BEGIN TRAN ;

								MERGE 
											  INTO  EE_NOM_R_MAPARI_PA tgt
											  USING ( Select    PartenerDeAfaceri,CONVERT(CHAR(10),DELADATA,101) as DeLaData,CONVERT(CHAR(10),PANALADATA,101) as PanaLaData,DenumirePartener,Regiune_Portofoliu,
															NULL AS PK_PA
													  From      EE_NOM_R_INT_FACT
													  WHERE     An=@AN and Luna=@LUNA
													  Group By  PartenerDeAfaceri,DeLaData,PanaLaData,DenumirePartener,Regiune_Portofoliu
													) src
											  ON     (
													 tgt.PARTENERDEAFACERI=src.PARTENERDEAFACERI AND
													 tgt.DELADATA=src.DELADATA					    AND
													 tgt.PANALADATA=src.PANALADATA   
													 )
											WHEN NOT MATCHED THEN
											INSERT (  PartenerDeAfaceri,DeLaData,PanaLaData,DenumirePartener,Regiune_Portofoliu,PK_PA,ENERGOINTENSIV)
											VALUES (  src.PartenerDeAfaceri,src.DeLaData,src.PanaLaData,src.DenumirePartener,src.Regiune_Portofoliu,src.PK_PA,'NU') ;

								UPDATE EE_NOM_R_MAPARI_PA
								SET PK_PA=TRIM(PARTENERDEAFACERI+convert(varchar(8), DELADATA, 112)+convert(varchar(8), PANALADATA, 112))
								WHERE PK_PA IS NULL ;

				SET     @MSG = '01-  '+cast(@@rowcount as varchar(255)) + ' DE INREGISTRARI AU FOST PROCESATE DIN TABELA EE_NOM_R_FACT IN TABELA EE_NOM_R_MAPARI_PA !' ;

				EXEC sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'INFORMARE' ,@MSG
				PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG

			COMMIT TRAN ;

			BEGIN TRAN ;

							MERGE 
										  INTO  EE_NOM_R_MAPARI_PA tgt
										  USING ( Select    PartenerDeAfaceri,CONVERT(CHAR(10),DELADATA,101) as DeLaData,CONVERT(CHAR(10),PANALADATA,101) as PanaLaData,DenumirePartener,
														NULL AS PK_PA
												  From      EE_NOM_R_INT_DIF
												  WHERE     An=@AN and Luna=@LUNA
												  Group By  PartenerDeAfaceri,DeLaData,PanaLaData,DenumirePartener
												) src
										  ON     (
												tgt.PARTENERDEAFACERI=src.PARTENERDEAFACERI AND
												tgt.DELADATA=src.DELADATA					    AND
												tgt.PANALADATA=src.PANALADATA   
												 )
										WHEN NOT MATCHED THEN
										INSERT (  PartenerDeAfaceri,DeLaData,PanaLaData,DenumirePartener,PK_PA,ENERGOINTENSIV)
										VALUES (  src.PartenerDeAfaceri,src.DeLaData,src.PanaLaData,src.DenumirePartener,src.PK_PA,'NU') ;


							UPDATE EE_NOM_R_MAPARI_PA
							SET PK_PA=TRIM(PARTENERDEAFACERI+convert(varchar(8), DELADATA, 112)+convert(varchar(8), PANALADATA, 112))
							WHERE PK_PA IS NULL ;

				SET     @MSG = '02-  '+cast(@@rowcount as varchar(255)) + ' DE INREGISTRARI AU FOST PROCESATE DIN TABELA EE_NOM_R_DIF IN TABELA EE_NOM_R_MAPARI_PA !' ;

				EXEC sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'INFORMARE' ,@MSG
				PRINT @AN_CALC+' '+@LUNA_CALC  +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG

			COMMIT TRAN ;

			BEGIN TRAN ;

							   MERGE 
										  INTO  EE_NOM_R_MAPARI_PA tgt
										  USING ( Select    PartenerDeAfaceri,CONVERT(CHAR(10),DELADATA,101) as DeLaData,CONVERT(CHAR(10),PANALADATA,101) as PanaLaData,DenumirePartener,
														NULL AS PK_PA
												  From      EE_NOM_R_INT_DELTA_CUT_OFF
												  WHERE     An=@AN and Luna=@LUNA 
												  Group By  PartenerDeAfaceri,DeLaData,PanaLaData,DenumirePartener
												) src
										  ON     (
												tgt.PARTENERDEAFACERI=src.PARTENERDEAFACERI AND
												tgt.DELADATA=src.DELADATA					    AND
												tgt.PANALADATA=src.PANALADATA   
												 )
										WHEN NOT MATCHED THEN
										INSERT (  PartenerDeAfaceri,DeLaData,PanaLaData,DenumirePartener,PK_PA,ENERGOINTENSIV )
										VALUES (  src.PartenerDeAfaceri,src.DeLaData,src.PanaLaData,src.DenumirePartener,src.PK_PA, 'NU') ;

							UPDATE EE_NOM_R_MAPARI_PA
							SET PK_PA=TRIM(PARTENERDEAFACERI+convert(varchar(8), DELADATA, 112)+convert(varchar(8), PANALADATA, 112))
							WHERE PK_PA IS NULL ;
            
				SET     @MSG ='03-  '+cast(@@rowcount as varchar(255)) + ' DE INREGISTRARI AU FOST PROCESATE DIN TABELA EE_NOM_R_DELTA_CUT_OFF IN TABELA EE_NOM_R_MAPARI_PA !' ;

				EXEC sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'INFORMARE' ,@MSG
				PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG

			COMMIT TRAN ;

			BEGIN TRAN ;

							MERGE 
									  INTO  EE_NOM_R_MAPARI_PA tgt
									  USING ( Select    PartenerDeAfaceri,CONVERT(CHAR(10),DELADATA,101) as DeLaData,CONVERT(CHAR(10),PANALADATA,101) as PanaLaData,DenumirePartener,
													NULL AS PK_PA
											  From      EE_NOM_R_INT_FACT_CD_CF
											  WHERE     An=@AN and Luna=@LUNA
											  Group By  PartenerDeAfaceri,DeLaData,PanaLaData,DenumirePartener
											) src
									  ON     (
											tgt.PARTENERDEAFACERI=src.PARTENERDEAFACERI AND
											tgt.DELADATA=src.DELADATA					    AND
											tgt.PANALADATA=src.PANALADATA   
											 )
									WHEN NOT MATCHED THEN
									INSERT (  PartenerDeAfaceri,DeLaData,PanaLaData,DenumirePartener, PK_PA,ENERGOINTENSIV)
									VALUES (  src.PartenerDeAfaceri,src.DeLaData,src.PanaLaData,src.DenumirePartener,src.PK_PA, 'NU') ;

							UPDATE EE_NOM_R_MAPARI_PA
							SET PK_PA=TRIM(PARTENERDEAFACERI+convert(varchar(8), DELADATA, 112)+convert(varchar(8), PANALADATA, 112))
							WHERE PK_PA IS NULL ;
            
				SET     @MSG ='04-  '+cast(@@rowcount as varchar(255)) + ' DE INREGISTRARI AU FOST PROCESATE DIN TABELA EE_NOM_R_FACT_CD_CF IN TABELA EE_NOM_R_MAPARI_PA !' ;

				EXEC sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'INFORMARE' ,@MSG
				PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG

			COMMIT TRAN ;

 --  Nomenclator Mapping

 			BEGIN TRAN ;

								MERGE 
										  INTO  EE_NOM_R_MAPARI_PA tgt
										  USING (   Select    PartenerDeAfaceri,CONVERT(CHAR(10),DELADATA,101) as DeLaData,CONVERT(CHAR(10),PANALADATA,101) as PanaLaData,CUI,SubSegment
													From      EE_NOM_R_INT_FACT
													WHERE     An=@AN and Luna=@LUNA AND CUI!='9999999999'
													Group By  PartenerDeAfaceri,DeLaData,PanaLaData,CUI,SubSegment
												) src
										  ON     (
												 tgt.PartenerDeAfaceri=src.PartenerDeAfaceri      and
												 tgt.DeLaData=src.DeLaData                        and
												 tgt.PanaLaData=src.PanaLaData    
												 )
										WHEN MATCHED THEN
										UPDATE   
										SET      tgt.CUI=src.CUI,
												 tgt.SubSegment=src.SubSegment;
            
				SET     @MSG ='05-  '+cast(@@rowcount as varchar(255)) + ' DE INREGISTRARI AU FOST MAPATE CU CUI !' ;

				EXEC sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'INFORMARE' ,@MSG
				PRINT @AN_CALC+' '+@LUNA_CALC  +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG

			COMMIT TRAN ;

			BEGIN TRAN ;
								MERGE 
										INTO  EE_NOM_R_MAPARI_PA tgt
										USING (   Select    IDManager, DENUMIREMANAGER
												From      AFC_INT_MANAGER
												Group By  IDManager, DENUMIREMANAGER
											) src
										ON     (
												tgt.IDManager=src.IDManager    
												)
										WHEN MATCHED AND tgt.DENUMIREMANAGER='' OR tgt.DENUMIREMANAGER IS NULL THEN
										UPDATE   
										SET      tgt.DENUMIREMANAGER=src.DENUMIREMANAGER ;
            
				SET     @MSG ='06-  '+cast(@@rowcount as varchar(255)) + ' DE INREGISTRARI AU FOST MAPATE CU IDMANAGER !' ;

				EXEC sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'INFORMARE' ,@MSG
				PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG

			COMMIT TRAN ;

			BEGIN TRAN ;

						MERGE INTO  EE_NOM_R_MAPARI_PA tgt
							USING ( SELECT    PARTENERDEAFACERI, DELADATA, PANALADATA
									FROM      dbo.EE_NOM_R_INT_ENERGOINTENSIV
									GROUP BY  PARTENERDEAFACERI, DELADATA, PANALADATA
								) SRC
							ON     (
								tgt.PARTENERDEAFACERI=src.PARTENERDEAFACERI 
								)
						WHEN MATCHED AND tgt.PANALADATA between src.DELADATA and src.PANALADATA THEN
						UPDATE   
						SET      tgt.ENERGOINTENSIV= 'DA';
            
				SET     @MSG ='07-  '+cast(@@rowcount as varchar(255)) + ' DE INREGISTRARI ENERGOINTENSIVI AU FOST MAPATI !' ;

				EXEC sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'INFORMARE' ,@MSG
				PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG

			COMMIT TRAN ;

-- => DATA PROCESSING INTO TABEl EE_NOM_R_MAPARI_INST

  			BEGIN TRAN ;

							MERGE 
									  INTO  EE_NOM_R_MAPARI_INST tgt
									  USING (   Select    Instalatie,CONVERT(CHAR(10),DELADATA,101) as DeLaData,CONVERT(CHAR(10),PANALADATA,101) as PanaLaData,DenumireDistribuitor,Regiune_LC,Divizie,PunctDeConsum,Localitate,
													 NULL AS PK_INST
												From      EE_NOM_R_INT_FACT
												 WHERE     An=@AN and Luna=@LUNA
												Group By  Instalatie,DeLaData, PanaLaData,DenumireDistribuitor,DenumireDistribuitor,Regiune_LC,Divizie,PunctDeConsum,Localitate
											) src
									  ON     (
											 tgt.INSTALATIE=src.INSTALATIE AND
											 tgt.DELADATA=src.DELADATA AND
											 tgt.PANALADATA=src.PANALADATA
											 )
									WHEN NOT MATCHED THEN
											 INSERT (  Instalatie,DeLaData,PanaLaData,DenumireDistribuitor,Regiune_LC,Divizie,PunctDeConsum,Localitate, PK_Inst)
											VALUES (  src.Instalatie,src.DeLaData,src.PanaLaData,src.DenumireDistribuitor,src.Regiune_LC,src.Divizie,src.PunctDeConsum,src.Localitate, src.PK_Inst) ;

							UPDATE EE_NOM_R_MAPARI_INST
							SET PK_INST=TRIM(INSTALATIE+convert(varchar(8), DELADATA, 112)+convert(varchar(8), PANALADATA, 112))
							WHERE PK_INST IS NULL ;

				SET     @MSG ='08-  '+cast(@@rowcount as varchar(255)) + ' DE INREGISTRARI AU FOST PROCESATE DIN TABELA EE_NOM_R_INT_FACT IN TABELUL EE_NOM_R_MAPARI_INST !' ;

				EXEC sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'INFORMARE' ,@MSG
				PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG

			COMMIT TRAN ;
  
  			BEGIN TRAN ;

								MERGE 
										  INTO  EE_NOM_R_MAPARI_INST tgt
										  USING ( Select    Instalatie,CONVERT(CHAR(10),DELADATA,101) as DeLaData,CONVERT(CHAR(10),PANALADATA,101) as PanaLaData,DenumireDistribuitor,Regiune_LC,Divizie,PunctDeConsum,Localitate,
														NULL AS PK_INST
												  From      EE_NOM_R_INT_DIF
												  WHERE     An=@AN and Luna=@LUNA
												  Group By  Instalatie,DeLaData, PanaLaData,DenumireDistribuitor,DenumireDistribuitor,Regiune_LC,Divizie,PunctDeConsum,Localitate
												) src
										  ON     (
												 tgt.INSTALATIE=src.INSTALATIE AND
												 tgt.DELADATA=src.DELADATA AND
												 tgt.PANALADATA=src.PANALADATA
												 )
										WHEN NOT MATCHED THEN
										INSERT (  Instalatie,DeLaData,PanaLaData,DenumireDistribuitor,Regiune_LC,Divizie,PunctDeConsum,Localitate, PK_Inst)
										VALUES (  src.Instalatie,src.DeLaData,src.PanaLaData,src.DenumireDistribuitor,src.Regiune_LC,src.Divizie,src.PunctDeConsum,src.Localitate, src.PK_Inst) ;

								UPDATE EE_NOM_R_MAPARI_INST
								SET PK_INST=TRIM(INSTALATIE+convert(varchar(8), DELADATA, 112)+convert(varchar(8), PANALADATA, 112))
								WHERE PK_INST IS NULL ;
            
				SET     @MSG ='09-  '+cast(@@rowcount as varchar(255)) + ' DE INREGISTRARI AU FOST PROCESATE DIN TABELA EE_NOM_R_INT_DIF IN TABELUL EE_NOM_R_MAPARI_INST !' ;

				EXEC sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'INFORMARE' ,@MSG
				PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG

			COMMIT TRAN ;

   			BEGIN TRAN ;

							MERGE 
										  INTO  EE_NOM_R_MAPARI_INST tgt
										  USING ( Select    Instalatie,CONVERT(CHAR(10),DELADATA,101) as DeLaData,CONVERT(CHAR(10),PANALADATA,101) as PanaLaData,DenumireDistribuitor,Regiune_LC,Divizie,PunctDeConsum,Localitate,
														NULL AS PK_INST
												  From      EE_NOM_R_INT_DELTA_CUT_OFF
												  WHERE     An=@AN and Luna=@LUNA
												  Group By  Instalatie,DeLaData, PanaLaData,DenumireDistribuitor,DenumireDistribuitor,Regiune_LC,Divizie,PunctDeConsum,Localitate
												) src
										  ON     (
												 tgt.INSTALATIE=src.INSTALATIE AND
												 tgt.DELADATA=src.DELADATA AND
												 tgt.PANALADATA=src.PANALADATA
												 )
										WHEN NOT MATCHED THEN
										INSERT (  Instalatie,DeLaData,PanaLaData,DenumireDistribuitor,Regiune_LC,Divizie,PunctDeConsum,Localitate,PK_Inst)
										VALUES (  src.Instalatie,src.DeLaData,src.PanaLaData,src.DenumireDistribuitor,src.Regiune_LC,src.Divizie,src.PunctDeConsum,src.Localitate,src.PK_Inst) ;

							UPDATE EE_NOM_R_MAPARI_INST
							SET PK_INST=TRIM(INSTALATIE+convert(varchar(8), DELADATA, 112)+convert(varchar(8), PANALADATA, 112))
							WHERE PK_INST IS NULL ;
            
				SET     @MSG ='10-  '+cast(@@rowcount as varchar(255)) + ' DE INREGISTRARI AU FOST PROCESATE DIN TABELA EE_NOM_R_INT_DELTA_CUT_OFF IN TABELUL EE_NOM_R_MAPARI_INST !' ;

				EXEC sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'INFORMARE' ,@MSG
				PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG

			COMMIT TRAN ;

  			BEGIN TRAN ;

								MERGE 
											INTO  EE_NOM_R_MAPARI_INST tgt
											USING ( Select    Instalatie,CONVERT(CHAR(10),DELADATA,101) as DeLaData,CONVERT(CHAR(10),PANALADATA,101) as PanaLaData,DenumireDistribuitor,Regiune_LC,Divizie,PunctDeConsum,
														      NULL AS PK_INST
													From      EE_NOM_R_INT_FACT_CD_CF
													WHERE     An=@AN and Luna=@LUNA
													Group By  Instalatie,DeLaData, PanaLaData,DenumireDistribuitor,DenumireDistribuitor,Regiune_LC,Divizie,PunctDeConsum
												) src
											ON     (
													 tgt.INSTALATIE=src.INSTALATIE AND
													 tgt.DELADATA=src.DELADATA AND
													 tgt.PANALADATA=src.PANALADATA
												   )
										WHEN NOT MATCHED THEN
										INSERT (  Instalatie,DeLaData,PanaLaData,DenumireDistribuitor,Regiune_LC,Divizie,PunctDeConsum,PK_Inst)
										VALUES (  src.Instalatie,src.DeLaData,src.PanaLaData,src.DenumireDistribuitor,src.Regiune_LC,src.Divizie,src.PunctDeConsum,src.PK_Inst) ;

								UPDATE EE_NOM_R_MAPARI_INST
								SET PK_INST=TRIM(INSTALATIE+convert(varchar(8), DELADATA, 112)+convert(varchar(8), PANALADATA, 112))
								WHERE PK_INST IS NULL ;
       
				SET     @MSG ='11-  '+cast(@@rowcount as varchar(255)) + ' DE INREGISTRARI AU FOST PROCESATE DIN TABELA EE_NOM_R_INT_FACT_CD_CF IN TABELUL EE_NOM_R_MAPARI_INST !' ;

				EXEC sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'INFORMARE' ,@MSG
				PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG

			COMMIT TRAN ;

 -- => Nomenclator Mapping
  
  			BEGIN TRAN ;

							WITH SRC AS (
										 SELECT    F.INSTALATIE,CONVERT(CHAR(10),F.DELADATA,101) AS DELADATA,CONVERT(CHAR(10),F.PANALADATA,101) AS PANALADATA,F.CODINDUSTRIE,CAEN.DESCRIERECODINDUSTRIE,
												   ROW_NUMBER()OVER(PARTITION BY F.INSTALATIE, CONVERT(CHAR(10),F.DELADATA,101), CONVERT(CHAR(10),F.PANALADATA,101)
																	ORDER BY F.INSTALATIE, CONVERT(CHAR(10),F.DELADATA,101),CONVERT(CHAR(10),F.PANALADATA,101) ) RN
										 FROM      EE_NOM_R_INT_FACT F, EE_NOM_R_MAPARI_CAEN CAEN
										 WHERE     F.CODINDUSTRIE=CAEN.CODINDUSTRIE AND 
												   F.AN=@AN AND F.LUNA=@LUNA
										 GROUP BY  F.INSTALATIE,F.DELADATA, F.PANALADATA,F.CODINDUSTRIE,CAEN.DESCRIERECODINDUSTRIE
										)

							MERGE 
										INTO  EE_NOM_R_MAPARI_INST TGT
										USING (  SELECT    INSTALATIE, DELADATA, PANALADATA, CODINDUSTRIE, DESCRIERECODINDUSTRIE
												 FROM      SRC
												 WHERE     RN=1
												 GROUP BY  INSTALATIE, DELADATA, PANALADATA, CODINDUSTRIE, DESCRIERECODINDUSTRIE
											) SRC
										ON     (
												TGT.INSTALATIE=SRC.INSTALATIE        AND
												TGT.DELADATA=SRC.DELADATA            AND
												TGT.PANALADATA=SRC.PANALADATA        
												)
									WHEN MATCHED THEN
									UPDATE   
									SET     TGT.CODINDUSTRIE=SRC.CODINDUSTRIE,
											TGT.DESCRIERECODINDUSTRIE=SRC.DESCRIERECODINDUSTRIE;
            
				SET     @MSG ='12-  '+cast(@@rowcount as varchar(255)) + ' DE INREGISTRARI AU FOST MAPATE CU CAEN!' ;

				EXEC sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'INFORMARE' ,@MSG
				PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG

			COMMIT TRAN ;

  			BEGIN TRAN ;

							MERGE 
										INTO  EE_NOM_R_MAPARI_STARE tgt
										USING ( Select    CategorieTarif,StareClient
												From      EE_NOM_R_INT_FACT
												WHERE     An=@AN and Luna=@LUNA
												Group By  CategorieTarif,StareClient
											) src
										ON     (
												tgt.CategorieTarif=src.CategorieTarif
												)
									WHEN NOT MATCHED THEN
									INSERT (  CategorieTarif,StareClient)
									VALUES (  src.CategorieTarif,src.StareClient) ;

								MERGE 
										  INTO  EE_NOM_R_MAPARI_STARE tgt
										  USING ( Select    CategorieTarif,StareClient
												  From      EE_NOM_R_INT_DIF
												  WHERE     AN=@AN and Luna=@LUNA
												  Group By  CategorieTarif,StareClient
												) src
										  ON     (
												 tgt.CategorieTarif=src.CategorieTarif
												 )
										WHEN NOT MATCHED THEN
										INSERT (  CategorieTarif,StareClient)
										VALUES (  src.CategorieTarif,src.StareClient) ;

								MERGE 
										  INTO  EE_NOM_R_MAPARI_STARE tgt
										  USING ( Select    CategorieTarif,StareClient
												  From      EE_NOM_R_INT_DELTA_CUT_OFF
												  WHERE     An=@AN and Luna=@LUNA
												  Group By  CategorieTarif,StareClient
												) src
										  ON     (
												 tgt.CategorieTarif=src.CategorieTarif
												 )
										WHEN NOT MATCHED THEN
										INSERT (  CategorieTarif,StareClient)
										VALUES (  src.CategorieTarif,src.StareClient) ;
            
								MERGE 
										  INTO  EE_NOM_R_MAPARI_STARE tgt
										  USING ( Select    CategorieTarif,StareClient
												  From      EE_NOM_R_INT_FACT_CD_CF 
												  WHERE     An=@AN and Luna=@LUNA
												  Group By  CategorieTarif,StareClient
												) src
										  ON     (
												 tgt.CategorieTarif=src.CategorieTarif
												 )
										WHEN NOT MATCHED THEN
										INSERT (  CategorieTarif,StareClient)
										VALUES (  src.CategorieTarif,src.StareClient) ;

				SET     @MSG ='13-  '+cast(@@rowcount as varchar(255)) + ' DE INREGISTRARI AU FOST PROCESATE IN TABELUL STARECLIENT' ;

				EXEC sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'INFORMARE' ,@MSG
				PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG

			COMMIT TRAN ;
 
   			BEGIN TRAN ;

					  MERGE 
								  INTO   EE_NOM_R_MAPARI_TIPCLIENT tgt
								  USING ( Select    DenumireDistribuitor,TipClient
										  From      EE_NOM_R_INT_FACT
										  WHERE     An=@AN and Luna=@LUNA
										  Group By  DenumireDistribuitor,TipClient
										) src
								  ON     (
										 tgt.DenumireDistribuitor=src.DenumireDistribuitor
										 )
								WHEN NOT MATCHED THEN
								INSERT (  DenumireDistribuitor,TipClient)   
								VALUES (  src.DenumireDistribuitor,src.TipClient) ;

				SET     @MSG ='14-  '+cast(@@rowcount as varchar(255)) + ' DE INREGISTRARI AU FOST PROCESATE IN TABELUL TIPCLIENT' ;

				EXEC sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'INFORMARE' ,@MSG
				PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG

				SET     @MSG ='FINISH ACTUALIZARE TABELE DE MAPARI !' ;

				EXEC sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'INFORMARE' ,@MSG
				PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG

			COMMIT TRAN ;

-- => ERROR HANDLING

	END TRY 

		BEGIN CATCH ;
			IF @@TRANCOUNT>0
			ROLLBACK TRAN ;

			DECLARE @ERROR_MESSAGE VARCHAR(1000);
			SET @ERROR_MESSAGE=ERROR_MESSAGE() ;

			EXEC  sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'EROARE' ,@ERROR_MESSAGE
			PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->EROARE'+' ->'+@ERROR_MESSAGE

		END CATCH ;
END;


CREATE PROCEDURE [dbo].[sp_EE_NOM_R_MARIMI]
(
@AN SMALLINT,
@LUNA SMALLINT
)
AS
BEGIN

	SET NOCOUNT ON;

	SET XACT_ABORT , NOCOUNT ON;



				DECLARE @OBJECT_NAME  CHAR(100);
				DECLARE @AN_CALC CHAR(4);
				DECLARE @LUNA_CALC CHAR(2);
				DECLARE @MSG_1 VARCHAR(100);

				SET     @OBJECT_NAME=OBJECT_NAME(@@PROCID) ;
				SET		@AN_CALC=TRIM(CONVERT(CHAR(4),@AN)) ;
				SET		@LUNA_CALC=TRIM(CONVERT(CHAR(2),@LUNA)) ;
				SET     @MSG_1 ='START ACTUALIZARE TABELA DE MARIMI !';

				EXEC sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'INFORMARE' ,@MSG_1
				PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG_1

				BEGIN TRY ;

-- => DATA PROCESSING INTO FACT TABLE

 			BEGIN TRAN;

						  MERGE 
									  INTO EE_NOM_R_MARIMI tgt
									  USING ( Select    An,Luna,PartenerDeAfaceri,SegmentClient,Instalatie,CategorieTarif,NivelDeTensiune,CONVERT(CHAR(10),DELADATA,101) as DeLaData,CONVERT(CHAR(10),PANALADATA,101) as PanaLaData,DenumireDistribuitor,StareClient,
														sum(VolumTotal) as VolumTotal,sum(ValoareFaraCV) as ValoareFaraCV, sum(ABATERE) as ABATERE,sum(VALOAREBONIFICATIE) as BONUS,
														NULL AS FK_PA,
														NULL AS FK_INST
											  From      EE_NOM_R_INT_FACT
											  WHERE     An=@AN and Luna=@LUNA
											  Group By  An,Luna,PartenerDeAfaceri,SegmentClient,Instalatie,CategorieTarif,NivelDeTensiune,DeLaData,PanaLaData,DenumireDistribuitor,StareClient
											) src
									  ON     (
											 tgt.An=src.An                                   AND
											 tgt.Luna=src.Luna                               AND
											 tgt.CategorieTarif=src.CategorieTarif           AND
											 tgt.PartenerDeAfaceri=src.PartenerDeAfaceri     AND
											 tgt.Instalatie=src.Instalatie                   AND
											 tgt.DeLaData=src.DeLaData                       AND
											 tgt.PanaLaData=src.PanaLaData                   AND
											 tgt.NivelDeTensiune=src.NivelDeTensiune         AND
											 tgt.SegmentClient=src.SegmentClient              
											 )
									WHEN MATCHED THEN
									UPDATE   
									SET   tgt.DENUMIREDISTRIBUITOR=src.DenumireDistribuitor,
											 tgt.STARECLIENT=src.StareClient,
											 tgt.CANT_FACT= src.VolumTotal,
											 tgt.VALOAREFARACV_FACT=src.ValoareFaraCV,
											 tgt.BONUS_FACT=src.Bonus,
											 tgt.ABATERE_FACT=src.Abatere
									WHEN NOT MATCHED THEN
									INSERT (  An,Luna,PartenerDeAfaceri,SegmentClient,Instalatie,CategorieTarif,NivelDeTensiune,DeLaData,PanaLaData,DenumireDistribuitor,StareClient,CANT_FACT,VALOAREFARACV_FACT,BONUS_FACT,ABATERE_FACT, FK_PA,FK_INST )
									VALUES (  src.An,src.Luna,src.PartenerDeAfaceri,src.SegmentClient,src.Instalatie,src.CategorieTarif,src.NivelDeTensiune,src.DeLaData,src.PanaLaData,src.DenumireDistribuitor,src.StareClient,src.VolumTotal,src.ValoareFaraCV,src.Bonus,src.Abatere,src.FK_PA,src.FK_INST);
			
			
						UPDATE EE_NOM_R_MARIMI
						SET FK_PA=TRIM(PARTENERDEAFACERI+convert(varchar(8), DELADATA, 112)+convert(varchar(8), PANALADATA, 112)),
						FK_INST=TRIM(INSTALATIE+convert(varchar(8), DELADATA, 112)+convert(varchar(8), PANALADATA, 112))
						WHERE FK_PA IS NULL OR FK_INST IS NULL ;

				DECLARE @MSG_2 VARCHAR(100);
				SET     @MSG_2 ='01-  '+cast(@@rowcount as varchar(255)) + ' DE INREGISTRARI AU FOST PROCESATE DIN TABELA EE_NOM_R_FACT IN TABELA EE_NOM_R_MARIMI!' ;

				EXEC sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'INFORMARE' ,@MSG_2
				PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG_2

			COMMIT TRAN ;

			BEGIN TRAN ;
				 
						MERGE 
									  INTO  EE_NOM_R_MARIMI tgt
									  USING ( Select    An,Luna,PartenerDeAfaceri,SegmentClient,Instalatie,CategorieTarif,NivelDeTensiune,CONVERT(CHAR(10),DELADATA,101) as DeLaData,CONVERT(CHAR(10),PANALADATA,101) as PanaLaData,DenumireDistribuitor,StareClient,
														sum(VolumTotal) as VolumTotal, sum(ValoareFaraCV) as ValoareFaraCV,
														NULL AS FK_PA,
														NULL AS FK_INST
											  From      EE_NOM_R_INT_DIF
											  WHERE     An=@AN and Luna=@LUNA
											  Group By  An,Luna,PartenerDeAfaceri,SegmentClient,Instalatie,CategorieTarif,NivelDeTensiune,DeLaData,PanaLaData,DenumireDistribuitor,StareClient
											) src
									  ON     (
											 tgt.An=src.An                                   AND
											 tgt.Luna=src.Luna                               AND
											 tgt.CategorieTarif=src.CategorieTarif           AND
											 tgt.PartenerDeAfaceri=src.PartenerDeAfaceri     AND
											 tgt.Instalatie=src.Instalatie                   AND
											 tgt.DeLaData=src.DeLaData                       AND
											 tgt.PanaLaData=src.PanaLaData                   AND
											 tgt.NivelDeTensiune=src.NivelDeTensiune         AND
											 tgt.SegmentClient=src.SegmentClient             
											 )
									WHEN MATCHED THEN
									UPDATE   
									SET      tgt.DENUMIREDISTRIBUITOR=src.DenumireDistribuitor,
											 tgt.STARECLIENT=src.StareClient,
											 tgt.CANT_DIF= src.VolumTotal, 
											 tgt.VALOAREFARACV_DIF=src.ValoareFaraCV
									WHEN NOT MATCHED THEN
									INSERT (  An,Luna,PartenerDeAfaceri,SegmentClient,Instalatie,CategorieTarif,NivelDeTensiune,DeLaData,PanaLaData,DenumireDistribuitor,StareClient,CANT_DIF,VALOAREFARACV_DIF,FK_PA,FK_INST )
									VALUES (  src.An,src.Luna,src.PartenerDeAfaceri,src.SegmentClient,src.Instalatie,src.CategorieTarif,src.NivelDeTensiune,src.DeLaData,src.PanaLaData,src.DenumireDistribuitor,src.StareClient,src.VolumTotal,src.ValoareFaraCV,src.FK_PA,src.FK_INST );

						UPDATE EE_NOM_R_MARIMI
						SET FK_PA=TRIM(PARTENERDEAFACERI+convert(varchar(8), DELADATA, 112)+convert(varchar(8), PANALADATA, 112)),
						FK_INST=TRIM(INSTALATIE+convert(varchar(8), DELADATA, 112)+convert(varchar(8), PANALADATA, 112))
						WHERE FK_PA IS NULL OR FK_INST IS NULL ;

				DECLARE @MSG_3 VARCHAR(100);
				SET     @MSG_3 ='02-  '+cast(@@rowcount as varchar(255)) + ' DE INREGISTRARI AU FOST PROCESATE DIN TABELA EE_NOM_R_DIF IN TABELA EE_NOM_R_MARIMI!' ;

				EXEC sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'INFORMARE' ,@MSG_3
				PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG_3

			COMMIT TRAN ;

			BEGIN TRAN ;

							  MERGE 
											INTO EE_NOM_R_MARIMI tgt
											USING ( Select    An,Luna,PartenerDeAfaceri,SegmentClient,Instalatie,CategorieTarif,NivelDeTensiune,CONVERT(CHAR(10),DELADATA,101) as DeLaData,CONVERT(CHAR(10),PANALADATA,101) as PanaLaData,DenumireDistribuitor,StareClient,
															sum(VolumTotal) as VolumTotal,sum(ValoareFaraCV) as ValoareFaraCV, sum(CostDistributie) as CostDistributie,
															NULL AS FK_PA,
														        NULL AS FK_INST
													From      EE_NOM_R_INT_DELTA_CUT_OFF
													WHERE     An=@AN and Luna=@LUNA
													Group By  An,Luna,PartenerDeAfaceri,SegmentClient,Instalatie,CategorieTarif,NivelDeTensiune,DeLaData,PanaLaData,DenumireDistribuitor,StareClient
												) src
											ON     (
													tgt.An=src.An                                   AND
													tgt.Luna=src.Luna                               AND
													tgt.CategorieTarif=src.CategorieTarif           AND
													tgt.PartenerDeAfaceri=src.PartenerDeAfaceri     AND
													tgt.Instalatie=src.Instalatie                   AND
													tgt.DeLaData=src.DeLaData                       AND
													tgt.PanaLaData=src.PanaLaData                   AND
													tgt.NivelDeTensiune=src.NivelDeTensiune         AND
													tgt.SegmentClient=src.SegmentClient              
													)
										WHEN MATCHED THEN
										UPDATE   
										SET      tgt.DENUMIREDISTRIBUITOR=src.DenumireDistribuitor,
													tgt.STARECLIENT=src.StareClient,
													tgt.CANT_DELTA_CUT_OFF= src.VolumTotal,
													tgt.VALOAREFARACV_DELTA_CUT_OFF=src.ValoareFaraCV,
													tgt.COST_DISTR_DELTA_CUT_OFF=src.CostDistributie
										WHEN NOT MATCHED THEN
										INSERT (  An,Luna,PartenerDeAfaceri,SegmentClient,Instalatie,CategorieTarif,NivelDeTensiune,DeLaData,PanaLaData,DenumireDistribuitor,StareClient,CANT_DELTA_CUT_OFF,VALOAREFARACV_DELTA_CUT_OFF,COST_DISTR_DELTA_CUT_OFF, FK_PA,FK_INST )
										VALUES (  src.An,src.Luna,src.PartenerDeAfaceri,src.SegmentClient,src.Instalatie,src.CategorieTarif,src.NivelDeTensiune,src.DeLaData,src.PanaLaData,src.DenumireDistribuitor,src.StareClient,src.VolumTotal,src.ValoareFaraCV,src.CostDistributie, src.FK_PA, src.FK_INST);
        
						UPDATE EE_NOM_R_MARIMI
						SET FK_PA=TRIM(PARTENERDEAFACERI+convert(varchar(8), DELADATA, 112)+convert(varchar(8), PANALADATA, 112)),
						FK_INST=TRIM(INSTALATIE+convert(varchar(8), DELADATA, 112)+convert(varchar(8), PANALADATA, 112))
						WHERE FK_PA IS NULL OR FK_INST IS NULL ;

				DECLARE @MSG_4 VARCHAR(100);
				SET     @MSG_4 ='03-  '+cast(@@rowcount as varchar(255)) + ' DE INREGISTRARI AU FOST PROCESATE DIN TABELA EE_NOM_R_DELTA_CUT_OFF IN TABELA EE_NOM_R_MARIMI!' ;

				EXEC sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'INFORMARE' ,@MSG_4
				PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG_4

			COMMIT TRAN ;

			BEGIN TRAN ;
			
					  MERGE 
								  INTO  EE_NOM_R_MARIMI tgt
								  USING ( Select    An,Luna,PartenerDeAfaceri,SegmentClient,Instalatie,CategorieTarif,NivelDeTensiune,CONVERT(CHAR(10),DELADATA,101) as DeLaData,CONVERT(CHAR(10),PANALADATA,101) as PanaLaData,DenumireDistribuitor,StareClient,
													sum(VolumTotal) as VolumTotal,
													NULL AS FK_PA,
													NULL AS FK_INST
										  From      EE_NOM_R_INT_FACT_CD_CF
										  WHERE     An=@AN and Luna=@LUNA
										  Group By  An,Luna,PartenerDeAfaceri,SegmentClient,Instalatie,CategorieTarif,NivelDeTensiune,DeLaData,PanaLaData,DenumireDistribuitor,StareClient
										) src
								  ON     (
										 tgt.An=src.An                                    AND
										 tgt.Luna=src.Luna                                AND
										 tgt.CategorieTarif=src.CategorieTarif            AND
										 tgt.PartenerDeAfaceri=src.PartenerDeAfaceri      AND
										 tgt.Instalatie=src.Instalatie                    AND
										 tgt.DeLaData=src.DeLaData                        AND
										 tgt.PanaLaData=src.PanaLaData                    AND
										 tgt.NivelDeTensiune=src.NivelDeTensiune          AND
										 tgt.SegmentClient=src.SegmentClient              
										 )
								WHEN MATCHED THEN
								UPDATE   
								SET      tgt.CANT_FACT_CD_CF= src.VolumTotal 
								WHEN NOT MATCHED THEN
								INSERT (  An,Luna,PartenerDeAfaceri,SegmentClient,Instalatie,CategorieTarif,NivelDeTensiune,DeLaData,PanaLaData,DenumireDistribuitor,StareClient,CANT_FACT_CD_CF,FK_PA,FK_INST )
								VALUES (  src.An,src.Luna,src.PartenerDeAfaceri,src.SegmentClient,src.Instalatie,src.CategorieTarif,src.NivelDeTensiune,src.DeLaData,src.PanaLaData,src.DenumireDistribuitor,src.StareClient,src.VolumTotal ,src.FK_PA,src.FK_INST);


						UPDATE EE_NOM_R_MARIMI
						SET FK_PA=TRIM(PARTENERDEAFACERI+convert(varchar(8), DELADATA, 112)+convert(varchar(8), PANALADATA, 112)),
						FK_INST=TRIM(INSTALATIE+convert(varchar(8), DELADATA, 112)+convert(varchar(8), PANALADATA, 112))
						WHERE FK_PA IS NULL OR FK_INST IS NULL ;
            
				DECLARE @MSG_5 VARCHAR(100);
				SET     @MSG_5 ='04-  '+cast(@@rowcount as varchar(255)) + ' DE INREGISTRARI AU FOST PROCESATE DIN TABELA EE_NOM_R_FACT_CD_CF IN TABELA EE_NOM_R_MARIMI!' ;

				EXEC sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'INFORMARE' ,@MSG_5
				PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG_5

			COMMIT TRAN ;

 -- => MAPPING NULL WITH ZERO

			BEGIN TRAN ;

				 UPDATE EE_NOM_R_MARIMI
						SET     CANT_FACT=ISNULL(CANT_FACT,0),
								CANT_DIF=ISNULL(CANT_DIF,0),
								CANT_DELTA_CUT_OFF=ISNULL(CANT_DELTA_CUT_OFF,0),
								CANT_FACT_CD_CF=ISNULL(CANT_FACT_CD_CF,0),
								CANT_DIF_CD_CF=ISNULL(CANT_DIF_CD_CF,0),
								VALOAREFARACV_FACT=ISNULL(VALOAREFARACV_FACT,0),
								VALOAREFARACV_DIF=ISNULL(VALOAREFARACV_DIF,0),
								VALOAREFARACV_DELTA_CUT_OFF=ISNULL(VALOAREFARACV_DELTA_CUT_OFF,0),
								ABATERE_FACT=ISNULL(ABATERE_FACT,0),
								BONUS_FACT=ISNULL(BONUS_FACT,0),
								COST_DISTR_DELTA_CUT_OFF=ISNULL(COST_DISTR_DELTA_CUT_OFF,0)
						WHERE  An=@AN and Luna=@LUNA ;     
            
				DECLARE @MSG_6 VARCHAR(100);
				SET     @MSG_6 ='05-  '+cast(@@rowcount as varchar(255)) + ' DE VALORI NUL AU FOST ACTUALIZATE CU ZERO IN TABELA EE_NOM_R_MARIMI!' ;

				EXEC sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'INFORMARE' ,@MSG_6
				PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG_6

			COMMIT TRAN ;

 -- => CALCULATION OF INDICATORS

			BEGIN TRAN ;

				 UPDATE EE_NOM_R_MARIMI
						SET  CANT_TOTAL=ISNULL(CANT_FACT,0)+ISNULL(CANT_DIF,0)+ISNULL(CANT_DELTA_CUT_OFF,0),
							VALOAREFARACV_TOTAL=ISNULL(VALOAREFARACV_FACT,0)+ISNULL(VALOAREFARACV_DIF,0)+ISNULL(VALOAREFARACV_DELTA_CUT_OFF,0)
						WHERE  An=@AN and Luna=@LUNA ;     
            
				DECLARE @MSG_7 VARCHAR(100);
				SET     @MSG_7 ='06-  '+cast(@@rowcount as varchar(255)) + ' DE INREGISTRARI AU CALC CANTITATE SI VALOARE TOTATLA !' ;

				EXEC sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'INFORMARE' ,@MSG_7
				PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG_7

			COMMIT TRAN ;

 -- => CONVERT DATA TO TEXT
 
			BEGIN TRAN ;

				UPDATE EE_NOM_R_MARIMI
				SET DELAANLUNAZI=CONVERT(CHAR(8), DELADATA , 112)
				WHERE AN=@AN AND LUNA=@LUNA ;
            
				DECLARE @MSG_8 VARCHAR(100);
				SET     @MSG_8 ='07-  '+cast(@@rowcount as varchar(255)) + ' DE INREGISTRARI AU FOST MAPATE CU DELAANLUNAZI !' ;

				EXEC sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'INFORMARE' ,@MSG_8
				PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG_8

				DECLARE @MSG_9 VARCHAR(100);
				SET     @MSG_9 ='FINISH ACTUALIZARE TABELE DE MARIMI !' ;

				EXEC sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'INFORMARE' ,@MSG_9
				PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG_9


			COMMIT TRAN ;

-- => ERROR HANDLING

END TRY 

		BEGIN CATCH ;
			IF @@TRANCOUNT>0
			ROLLBACK TRAN ;

			DECLARE @ERROR_MESSAGE VARCHAR(1000);
			SET @ERROR_MESSAGE=ERROR_MESSAGE() ;

			EXEC  sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'EROARE' ,@ERROR_MESSAGE
			PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->EROARE'+' ->'+@ERROR_MESSAGE

		END CATCH ;
END;

CREATE PROCEDURE [dbo].[sp_EE_NOM_R_P_ACH_ORA]
(
@AN SMALLINT,
@LUNA SMALLINT
)
AS
BEGIN ;
				SET XACT_ABORT , NOCOUNT ON;

				DECLARE @OBJECT_NAME  CHAR(100);
				DECLARE @AN_CALC CHAR(4);
				DECLARE @LUNA_CALC CHAR(2);
				SET     @OBJECT_NAME=OBJECT_NAME(@@PROCID) ;
				SET		@AN_CALC=TRIM(CONVERT(CHAR(4),@AN)) ;
				SET		@LUNA_CALC=TRIM(CONVERT(CHAR(2),@LUNA)) ;

				DECLARE @MSG_1 VARCHAR(100);
				SET     @MSG_1 ='START PROCESARE COST ACHIZITIE PE INTERVALE ORARE !';

				EXEC sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'INFORMARE' ,@MSG_1
				PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG_1

	BEGIN TRY ;

-- => DATA PROCESSING INTO TABLE AFC_MD_ACH_ORA

	BEGIN TRAN ;

		DECLARE @PORTOFOLIU CHAR(3);
		SET	@PORTOFOLIU='POR';

		DELETE FROM dbo.EE_NOM_R_MARIMI_ACH_ORA WHERE AN=@AN AND LUNA=@LUNA ;

		INSERT INTO dbo.EE_NOM_R_MARIMI_ACH_ORA ( 
						 AN, LUNA , DATA_CONS, TIP_ACH,
						 CANT_ACH_CONTR, COST_ACH_CONTR, COST_MED_ACH_CONTR,
						 CANT_ACH_PZU, COST_ACH_PZU, COST_MED_ACH_PZU,
						 COST_ACH_ECH, COST_MED_ACH_ECH
						 )

		SELECT  AN, LUNA, IIF( ORA_CONS='3.5' ,(CAST(CONVERT(CHAR(10),DATA_REF,101)AS DATETIME)+ CAST(TIMEFROMPARTS(ORA_CONS,30,0,0,0) AS DATETIME)), (CAST(CONVERT(CHAR(10),DATA_REF,101)AS DATETIME)+ CAST(TIMEFROMPARTS(ORA_CONS,0,0,0,0) AS DATETIME))) ,@PORTOFOLIU, 		
			CANT_ACH_CONTR, COST_ACH_CONTR,IIF(ISNULL(CANT_ACH_CONTR,0)=0, 0,COST_ACH_CONTR/CANT_ACH_CONTR) ,
			CANT_ACH_PZU,COST_ACH_PZU,IIF(ISNULL(CANT_ACH_PZU,0)=0 , 0,COST_ACH_PZU/CANT_ACH_PZU) ,
			(ISNULL(CANT_ACH_CONTR,0)+ISNULL(CANT_ACH_PZU,0))*ISNULL(COST_MED_ACH_ECH,0) , COST_MED_ACH_ECH
		FROM    dbo.EE_NOM_R_INT_ACH_POR
		WHERE AN=@AN AND LUNA=@LUNA
		GROUP BY  AN, LUNA, DATA_REF, ORA_CONS, CANT_ACH_CONTR, COST_ACH_CONTR,CANT_ACH_PZU,COST_ACH_PZU,COST_MED_ACH_ECH ;
						
		DECLARE @MSG_2 VARCHAR(MAX);
		SET     @MSG_2='02-  '+cast(@@rowcount as varchar(255)) + ' DE INREGISTRARI AU FOST INSERATE PENTRU CLIENTILOR DIN PORTOFOLIU ! ' ;

		EXEC sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'INFORMARE' ,@MSG_2
		PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG_2

		UPDATE dbo.EE_NOM_R_MARIMI_ACH_ORA
		SET    COST_ACH=ISNULL(COST_ACH_CONTR,0)+ISNULL(COST_ACH_PZU,0)+ISNULL(COST_ACH_ECH,0),
		       COST_MED_ACH=CASE WHEN (ISNULL(CANT_ACH_CONTR,0)+ISNULL(CANT_ACH_PZU,0))=0 THEN 0
					 ELSE (ISNULL(COST_ACH_CONTR,0)+ISNULL(COST_ACH_PZU,0)+ISNULL(COST_ACH_ECH,0))/(ISNULL(CANT_ACH_CONTR,0)+ISNULL(CANT_ACH_PZU,0))
				     END,
			   PROCENT_CONTR= CASE WHEN (ISNULL(CANT_ACH_CONTR,0)+ISNULL(CANT_ACH_PZU,0))!=0 THEN ISNULL(CANT_ACH_CONTR,0)/ (ISNULL(CANT_ACH_CONTR,0)+ISNULL(CANT_ACH_PZU,0)) ELSE 0 END ,
			   PROCENT_PZU= CASE WHEN (ISNULL(CANT_ACH_CONTR,0)+ISNULL(CANT_ACH_PZU,0))!=0 THEN ISNULL(CANT_ACH_PZU,0)/ (ISNULL(CANT_ACH_CONTR,0)+ISNULL(CANT_ACH_PZU,0)) ELSE 0 END
		WHERE AN=@AN AND LUNA=@LUNA AND TIP_ACH=@PORTOFOLIU ;

		DECLARE @MSG_3 VARCHAR(MAX);
		SET     @MSG_3='03-  '+cast(@@rowcount as varchar(255)) + ' DE INREGISTRARI AU FOST ACTUALIZATE CU COST MEDIU DE ACHIZITIE AFERENT CLIENTILOR DIN PORTOFOLIU ! ' ;

		EXEC sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'INFORMARE' ,@MSG_3
		PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG_3

		DECLARE @MSG_4 VARCHAR(100);
		SET     @MSG_4 ='FINISH PROCESARE COST ACHIZITIE PE INTERVALE ORARE !';

		EXEC sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'INFORMARE' ,@MSG_4
		PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG_4

	COMMIT TRAN;											

-- => ERROR HANDLING

	END TRY 

		BEGIN CATCH ;
			IF @@TRANCOUNT>0
			ROLLBACK TRAN ;

			DECLARE @ERROR_MESSAGE VARCHAR(1000);
			SET @ERROR_MESSAGE=ERROR_MESSAGE() ;

			EXEC  sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'EROARE' ,@ERROR_MESSAGE
			PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->EROARE'+' ->'+@ERROR_MESSAGE

		END CATCH ;
END;


CREATE PROCEDURE [dbo].[sp_EE_NOM_R_P_ACH_PROF_FIX]
(
@AN SMALLINT,
@LUNA SMALLINT,
@SUBPOR CHAR(2)
)
AS
BEGIN ;
				SET XACT_ABORT , NOCOUNT ON;

				DECLARE @OBJECT_NAME  CHAR(100);
				DECLARE @MSG_1 VARCHAR(100);
				DECLARE @AN_CALC CHAR(4);
				DECLARE @LUNA_CALC CHAR(2);
				DECLARE @PORTOFOLIU CHAR(3);
				DECLARE @VALABIL_OFERTA CHAR(2);
				DECLARE @ECH FLOAT;

				SET     @OBJECT_NAME=OBJECT_NAME(@@PROCID) ;
				SET		@AN_CALC=TRIM(CONVERT(CHAR(4),@AN)) ;
				SET		@LUNA_CALC=TRIM(CONVERT(CHAR(2),@LUNA)) ;

				SET     @OBJECT_NAME=OBJECT_NAME(@@PROCID) ;
				SET     @MSG_1 ='START CALCUL ACHIZIITE PROFILATA !';

				EXEC sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'INFORMARE' ,@MSG_1
				PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG_1

	BEGIN TRY ;

-- => COST ALOCATION

BEGIN TRAN ;

-- CALC PENTRU INTERVAL OFERTA VALABILA

		SET     @VALABIL_OFERTA='DA';
	    SET     @PORTOFOLIU='POR';
		SELECT  @ECH= COST_MED_ACH_ECH FROM fn_EE_NOM_R_CALC_ECH (@AN, @LUNA);

					UPDATE	tgt
					SET	  COST_MED_ACH_PZU=src.COST_MED_ACH_PZU,
						  CANT_ACH_PZU=ISNULL(CANT_ALOC,0)-ISNULL(CANT_BANDA,0),
						  COST_ACH_PZU=(ISNULL(CANT_ALOC,0)-ISNULL(CANT_BANDA,0))*src.COST_MED_ACH_PZU,
					      COST_MED_ACH_ECH=@ECH,
						  COST_ACH_ECH=ISNULL(tgt.CANT_ALOC,0)*@ECH
					FROM  dbo.EE_NOM_R_MARIMI_ALOC tgt, dbo.EE_NOM_R_MARIMI_ACH_ORA src 
					WHERE tgt.AN=src.AN								AND 
						  tgt.LUNA=src.LUNA  						AND 
						  tgt.DATA_CONS=src.DATA_CONS				AND
						  tgt.AN=@AN								AND
						  tgt.LUNA=@LUNA							AND
						  tgt.SUBPOR_ACTUAL=@SUBPOR					AND
						  tgt.VALABIL_OFERTA=@VALABIL_OFERTA		AND
						  src.TIP_ACH=@PORTOFOLIU;

					UPDATE tgt
					SET    COST_ACH=ISNULL(CANT_BANDA,0)*ISNULL(PRET_BANDA,0)+ISNULL(COST_ACH_PZU,0)+ISNULL(COST_ACH_ECH,0)
					FROM   dbo.EE_NOM_R_MARIMI_ALOC tgt
					WHERE  AN=@AN								AND
						   LUNA=@LUNA							AND
						   VALABIL_OFERTA=@VALABIL_OFERTA		AND
						   SUBPOR_ACTUAL=@SUBPOR;

					UPDATE tgt
					SET    COST_MED_ACH=CASE WHEN ISNULL(CANT_ALOC,0)!=0 THEN ISNULL(COST_ACH,0)/ISNULL(CANT_ALOC,0) ELSE 0 END
					FROM   dbo.EE_NOM_R_MARIMI_ALOC tgt
					WHERE  AN=@AN								AND
						   LUNA=@LUNA						    AND
						   VALABIL_OFERTA=@VALABIL_OFERTA		AND
						   SUBPOR_ACTUAL=@SUBPOR;

					UPDATE	tgt
					SET	  CANT_ACH_CONTR=ISNULL(CANT_ALOC,0)*ISNULL(src.PROCENT_CONTR,0),
						  COST_MED_ACH_CONTR=ISNULL(src.COST_MED_ACH_CONTR,0),
						  CANT_ACH_PZU=ISNULL(CANT_ALOC,0)*ISNULL(src.PROCENT_PZU,0),
						  COST_MED_ACH_PZU=ISNULL(src.COST_MED_ACH_PZU,0),
					      COST_MED_ACH_ECH=@ECH
					FROM  dbo.EE_NOM_R_MARIMI_ALOC tgt, dbo.EE_NOM_R_MARIMI_ACH_ORA src
					WHERE tgt.AN=src.AN								AND 
						  tgt.LUNA=src.LUNA							AND 
						  tgt.DATA_CONS=src.DATA_CONS				AND
						  tgt.AN=@AN								AND
						  tgt.LUNA=@LUNA							AND
						  tgt.SUBPOR_ACTUAL=@SUBPOR					AND
						  tgt.VALABIL_OFERTA IS NULL				AND
						  src.TIP_ACH=@PORTOFOLIU;

					UPDATE tgt
					SET    COST_ACH_CONTR=ISNULL(CANT_ACH_CONTR,0)*ISNULL(COST_MED_ACH_CONTR,0),
						   COST_ACH_PZU=ISNULL(CANT_ACH_PZU,0)*ISNULL(COST_MED_ACH_PZU,0),
						   COST_ACH_ECH=ISNULL(CANT_ALOC,0)*@ECH
					FROM   dbo.EE_NOM_R_MARIMI_ALOC tgt
					WHERE  AN=@AN							AND
						   LUNA=@LUNA						AND
						   SUBPOR_ACTUAL=@SUBPOR			AND
						   VALABIL_OFERTA IS NULL ;

					UPDATE tgt
					SET    COST_ACH=ISNULL(COST_ACH_CONTR,0)+ISNULL(COST_ACH_PZU,0)+ISNULL(COST_ACH_ECH,0),
						   COST_MED_ACH=CASE WHEN ISNULL(CANT_ALOC,0)=0 THEN 0 ELSE (ISNULL(COST_ACH_CONTR,0)+ISNULL(COST_ACH_PZU,0)+ISNULL(COST_ACH_ECH,0))/ISNULL(CANT_ALOC,0) END
					FROM   dbo.EE_NOM_R_MARIMI_ALOC tgt
					WHERE  AN=@AN							 AND
						   LUNA=@LUNA						 AND
						   SUBPOR_ACTUAL=@SUBPOR			 AND
						   VALABIL_OFERTA IS NULL ;


		   IF @SUBPOR='P3'

			BEGIN

			   DECLARE @NR_1 CHAR(10); 
			   DECLARE @MSG_2 VARCHAR(100);

			   SET	@NR_1=TRIM(CONVERT(CHAR(10),(SELECT COUNT(*) FROM dbo.EE_NOM_R_MARIMI_ALOC WHERE AN=@AN AND LUNA=@LUNA AND SUBPOR_ACTUAL=@SUBPOR AND COST_MED_ACH IS NOT NULL))) ;
			   SET  @MSG_2='01- SUBPORTOFOLIU '+@SUBPOR+' '+@NR_1+' DE INREGISTRARI AU COST DE ACHIZITIE ALOCATA !';

				EXEC sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'INFORMARE' ,@MSG_2
				PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG_2

			END

			IF @SUBPOR='P2'

			BEGIN

			   DECLARE @NR_2 CHAR(10); 
			   DECLARE @MSG_3 VARCHAR(100);

			   SET	@NR_2=TRIM(CONVERT(CHAR(10),(SELECT COUNT(*) FROM dbo.EE_NOM_R_MARIMI_ALOC WHERE AN=@AN AND LUNA=@LUNA AND SUBPOR_ACTUAL=@SUBPOR AND COST_MED_ACH IS NOT NULL))) ;
			   SET  @MSG_3='02- SUBPORTOFOLIU '+@SUBPOR+' '+@NR_2+' DE INREGISTRARI AU COST DE ACHIZITIE ALOCATA !';

				EXEC sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'INFORMARE' ,@MSG_3
				PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG_3

			END

	COMMIT TRAN;																

-- => ERROR HANDLING

	END TRY 

		BEGIN CATCH ;
			IF @@TRANCOUNT>0
			ROLLBACK TRAN ;

			DECLARE @ERROR_MESSAGE VARCHAR(1000);
			SET @ERROR_MESSAGE=ERROR_MESSAGE() ;

			EXEC  sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'EROARE' ,@ERROR_MESSAGE
			PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->EROARE'+' ->'+@ERROR_MESSAGE

		END CATCH ;
END;

CREATE PROCEDURE [dbo].[sp_EE_NOM_R_P_ACH_PROF_REST]
(
@AN SMALLINT,
@LUNA SMALLINT,
@SUBPOR CHAR(2)
)
AS
BEGIN ;
				SET XACT_ABORT , NOCOUNT ON;

				DECLARE @OBJECT_NAME  CHAR(100) ;
				DECLARE @PORTOFOLIU CHAR(3);
				DECLARE @AN_CALC CHAR(4);
				DECLARE @LUNA_CALC CHAR(2);
				DECLARE @ECH FLOAT;

				SET     @OBJECT_NAME=OBJECT_NAME(@@PROCID) ;
				SET		@AN_CALC=TRIM(CONVERT(CHAR(4),@AN)) ;
				SET		@LUNA_CALC=TRIM(CONVERT(CHAR(2),@LUNA)) ;

	BEGIN TRY ;


-- => COST ALOCATION FOR THE REST OF CLIENTS

	BEGIN TRAN;

	   	SET @PORTOFOLIU='POR';
	
		TRUNCATE TABLE dbo.EE_NOM_R_CALC_ALOC_REST ;
	
		CREATE TABLE #Temp_Aloc  ( 
									AN SMALLINT NOT NULL,
									LUNA SMALLINT NOT NULL,
									DATA_CONS DATETIME NOT NULL,
									COST_ACH_ALOC FLOAT NOT NULL,
									INDEX #Temp_Aloc NONCLUSTERED ( AN, DATA_CONS, LUNA )
									) ;

		WITH src AS (
						SELECT	 AN, LUNA, DATA_CONS, SUM(ISNULL(COST_ACH,0)-ISNULL(COST_ACH_ECH,0)) COST_ACH_ALOC
						FROM	 dbo.EE_NOM_R_MARIMI_ALOC
						WHERE	 AN=@AN AND LUNA=@LUNA AND SUBPOR_ACTUAL IN ('P2','P3') 
						GROUP BY AN, LUNA, DATA_CONS 
					)
	    INSERT INTO #Temp_Aloc ( AN, LUNA, DATA_CONS, COST_ACH_ALOC )
		SELECT	 AN, LUNA, DATA_CONS, COST_ACH_ALOC
		FROM	 src
		GROUP BY AN, LUNA, DATA_CONS, COST_ACH_ALOC ;


		WITH t AS (
				SELECT   AN, LUNA, DATA_CONS, SUM(ISNULL(COST_ACH_CONTR,0)+ISNULL(COST_ACH_PZU,0)) AS COST_ACH_TOTAL
				FROM	 dbo.EE_NOM_R_MARIMI_ACH_ORA
				WHERE	 AN=@AN AND LUNA=@LUNA AND TIP_ACH=@PORTOFOLIU AND MONTH(DATA_CONS)=@LUNA
				GROUP BY AN, LUNA, DATA_CONS
			   ),
		     a AS  (
				SELECT   AN, LUNA, DATA_CONS, SUM(COST_ACH_ALOC) COST_ACH_ALOC
				FROM     #Temp_Aloc
				WHERE	 MONTH(DATA_CONS)=@LUNA
				GROUP BY AN, LUNA, DATA_CONS
			    )

		INSERT INTO dbo.EE_NOM_R_CALC_ALOC_REST (
												AN, DATA_CONS, LUNA,
												COST_ACH_TOTAL,
												COST_ACH_ALOC
											   )

		SELECT		t.AN, t.DATA_CONS,t.LUNA ,
					t.COST_ACH_TOTAL, 
					a.COST_ACH_ALOC
		FROM		 t, a
		WHERE		t.AN=a.AN AND t.LUNA=a.LUNA AND t.DATA_CONS=a.DATA_CONS
		GROUP BY	t.AN, t.DATA_CONS, t.LUNA, t.COST_ACH_TOTAL, a.COST_ACH_ALOC

		UPDATE dbo.EE_NOM_R_CALC_ALOC_REST
		SET    COST_ACH_REST=ISNULL(COST_ACH_TOTAL,0)-ISNULL(COST_ACH_ALOC,0)
		WHERE  AN=@AN AND LUNA=@LUNA ;

-- => CALCULATION OF COST REST

		CREATE TABLE #Temp_Cant_Rest  ( 
									AN SMALLINT NOT NULL,
									LUNA SMALLINT NOT NULL,
									DATA_CONS DATETIME NOT NULL,
									CANT_REST FLOAT NOT NULL,
									INDEX #Temp_Aloc NONCLUSTERED ( AN, DATA_CONS, LUNA )
									) ;

		WITH rest AS (
						SELECT	 AN, LUNA, DATA_CONS, SUM(CANT_ALOC) CANT_REST
						FROM	 dbo.EE_NOM_R_MARIMI_ALOC
						WHERE	 AN=@AN AND LUNA=@LUNA AND SUBPOR_ACTUAL=@SUBPOR
						GROUP BY AN, LUNA, DATA_CONS 
					)

	    INSERT INTO #Temp_Cant_Rest ( AN, LUNA, DATA_CONS, CANT_REST )
		SELECT	 AN, LUNA, DATA_CONS, CANT_REST
		FROM	 rest
		GROUP BY AN, LUNA, DATA_CONS, CANT_REST ;

		UPDATE tgt
		SET    CANT_REST=ISNULL(src.CANT_REST,0),
			   COST_MED_ACH_REST=ISNULL(COST_ACH_REST,0)/ISNULL(src.CANT_REST,0)
		FROM   dbo.EE_NOM_R_CALC_ALOC_REST tgt , #Temp_Cant_Rest src
		WHERE  tgt.AN=src.AN AND tgt.LUNA=src.LUNA AND tgt.DATA_CONS=src.DATA_CONS AND tgt.AN=@AN AND tgt.LUNA=@LUNA ;


-- => COST ALOCATION FOR REST CLIENTS

			DECLARE @START INT ;
			DECLARE @END INT;

			SELECT @START= MIN(ORA) FROM EE_NOM_R_MARIMI_ALOC WHERE AN=@AN AND LUNA=@LUNA;
			SELECT @END= MAX(ORA) FROM EE_NOM_R_MARIMI_ALOC WHERE AN=@AN AND LUNA=@LUNA;
			SELECT @ECH= COST_MED_ACH_ECH FROM fn_EE_NOM_R_CALC_ECH (@AN, @LUNA);

			WHILE @START <= @END

				BEGIN

						UPDATE EE_NOM_R_MARIMI_ALOC
						SET    COST_MED_ACH_ECH=@ECH,
							   COST_ACH_ECH=ISNULL(CANT_ALOC,0)*@ECH
						WHERE  AN=@AN AND LUNA=@LUNA AND SUBPOR_ACTUAL='P1'
							   AND ORA=@START

						UPDATE tgt
						SET    COST_ACH=ISNULL(COST_ACH_ECH,0)+ISNULL(CANT_ALOC,0)*ISNULL(src.COST_MED_ACH_REST,0)
						FROM   EE_NOM_R_MARIMI_ALOC tgt , EE_NOM_R_CALC_ALOC_REST src
						WHERE  tgt.AN=src.AN AND tgt.LUNA=src.LUNA AND tgt.DATA_CONS=src.DATA_CONS
							   AND tgt.AN=@AN AND tgt.LUNA=@LUNA AND tgt.SUBPOR_ACTUAL='P1'
							   AND tgt.ORA=@START

						UPDATE EE_NOM_R_MARIMI_ALOC
						SET    COST_MED_ACH= CASE WHEN ISNULL(CANT_ALOC,0)!=0 THEN  COST_ACH/CANT_ALOC ELSE 0 END
						WHERE  AN=@AN AND LUNA=@LUNA AND SUBPOR_ACTUAL='P1' AND ORA=@START

						SET @START = @START + 1 ;

				END

		DECLARE @NR_1 CHAR(10); 
		DECLARE @MSG_1 VARCHAR(100);

		SET	@NR_1=TRIM(CONVERT(CHAR(10),(SELECT COUNT(*) FROM dbo.EE_NOM_R_MARIMI_ALOC WHERE AN=@AN AND SUBPOR_ACTUAL=@SUBPOR AND LUNA=@LUNA AND COST_MED_ACH IS NOT NULL))) ;
		SET @MSG_1='03- SUBPORTOFOLIU '+@SUBPOR+' '+@NR_1+' DE INREGISTRARI AU COST DE ACHIZITIE ALOCATA !';

		EXEC sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'INFORMARE' ,@MSG_1
		PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG_1

	COMMIT TRAN;	
															
-- => ERROR HANDLING

	END TRY 

		BEGIN CATCH ;
			IF @@TRANCOUNT>0
			ROLLBACK TRAN ;

			DECLARE @ERROR_MESSAGE VARCHAR(1000);
			SET @ERROR_MESSAGE=ERROR_MESSAGE() ;

			EXEC  sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'EROARE' ,@ERROR_MESSAGE
			PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->EROARE'+' ->'+@ERROR_MESSAGE

		END CATCH ;
END;

CREATE PROCEDURE [dbo].[sp_EE_NOM_R_P_ALOC]
(
@AN SMALLINT,
@LUNA SMALLINT
)
AS
BEGIN ;
				SET XACT_ABORT , NOCOUNT ON;

				DECLARE @OBJECT_NAME  CHAR(100);
				DECLARE @AN_CALC CHAR(4);
				DECLARE @LUNA_CALC CHAR(2);
				SET     @OBJECT_NAME=OBJECT_NAME(@@PROCID) ;
				SET		@AN_CALC=TRIM(CONVERT(CHAR(4),@AN)) ;
				SET		@LUNA_CALC=TRIM(CONVERT(CHAR(2),@LUNA)) ;

				DECLARE @MSG_1 VARCHAR(100);
				SET     @MSG_1 ='START PROCESARE ALOCARE CANTITATE PE INTERVAL ORAR !';

				EXEC sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'INFORMARE' ,@MSG_1
				PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG_1

	BEGIN TRY ;

-- => DATA PROCESSING INTO FACT TABLE

		BEGIN TRAN ;
							
				DECLARE @RC INT;
				DECLARE @BATCH_DELETE INT ;
				SET	@RC=1;
				SET	@BATCH_DELETE=500000 ;

					WHILE @RC>0
						BEGIN
							DELETE TOP(@BATCH_DELETE) FROM dbo.EE_NOM_R_MARIMI_ALOC WHERE AN=@AN AND LUNA=@LUNA ;
							SET @RC=@@ROWCOUNT;
						END
		
				CREATE TABLE #Temp_Luna (
										AN smallint NOT NULL,
										LUNA smallint NOT NULL,
										PARTENERDEAFACERI char(10) NOT NULL,
										INSTALATIE char(10) NOT NULL,
										CANT_LUNA float NOT NULL,
										CURBA_ACTUAL char(50) NOT NULL,
										SUBPOR_ACTUAL char(2) NOT NULL,
										INDEX Temp_Luna NONCLUSTERED ( AN, LUNA )
										) ;

				WITH src AS (
								SELECT	 AN,LUNA,PARTENERDEAFACERI, INSTALATIE,SUM(ISNULL(CANT_TOTAL,0)-ISNULL(CANT_FACT_CD_CF,0)-ISNULL(CANT_DIF_CD_CF,0)) AS CANT_LUNA,
										 CURBA_ACTUAL, SUBPOR_ACTUAL
								FROM	 dbo.EE_NOM_R_MARIMI
								WHERE	 AN=@AN AND LUNA=@LUNA AND STARECLIENT IN ('ELIGIBIL','AGENTFUI','AGENTSU')
								GROUP BY AN,LUNA,PARTENERDEAFACERI, INSTALATIE, CURBA_ACTUAL, SUBPOR_ACTUAL
								)

				INSERT INTO #Temp_Luna (  AN, LUNA, PARTENERDEAFACERI, INSTALATIE, CANT_LUNA, SUBPOR_ACTUAL, CURBA_ACTUAL ) 
				SELECT	AN, LUNA, PARTENERDEAFACERI, INSTALATIE, SUM(CANT_LUNA), SUBPOR_ACTUAL, CURBA_ACTUAL
				FROM	 src
				GROUP BY AN, LUNA, PARTENERDEAFACERI, INSTALATIE, SUBPOR_ACTUAL, CURBA_ACTUAL ;
				
				CREATE TABLE #Temp_Coef (
										DATA_CONS datetime NOT NULL,
										INTERVAL_CONS char(4) NOT NULL,
										AN smallint NOT NULL,
										LUNA smallint NOT NULL,
										LUNA_NUME char(20) NOT NULL,
										ZI smallint NOT NULL,
										ZI_NUME char(20) NOT NULL,
										ORA smallint NOT NULL,
										CURBA char(50) NOT NULL,
										COEF float NOT NULL,
										INDEX Temp_Coef_IND1 NONCLUSTERED ( AN, LUNA )
										) ;

				INSERT INTO #Temp_Coef (  DATA_CONS, INTERVAL_CONS, AN ,LUNA, LUNA_NUME, ZI, ZI_NUME, ORA,CURBA, COEF )
				SELECT	 DATA_CONS, INTERVAL_CONS, AN ,LUNA, LUNA_NUME, ZI, ZI_NUME, ORA,CURBA, COEF
				FROM	 dbo.AFC_MD_DIM_COEF
				WHERE	 AN=@AN AND LUNA=@LUNA AND MOD_ID=1
				GROUP BY  DATA_CONS, INTERVAL_CONS, AN ,LUNA, LUNA_NUME, ZI, ZI_NUME, ORA,CURBA, COEF ;

				CREATE TABLE #Temp_Aloc (
										DATA_CONS datetime NOT NULL,
										INTERVAL_CONS char(4) NOT NULL,
										AN smallint NOT NULL,
										LUNA smallint NOT NULL,
										LUNA_NUME char(20) NOT NULL,
										ZI smallint NOT NULL,
										ZI_NUME char(20) NOT NULL,
										ORA smallint NOT NULL,
										SUBPOR_ACTUAL CHAR(2) NOT NULL,
										PARTENERDEAFACERI CHAR(10) NOT NULL,
										CURBA_ACTUAL VARCHAR(50) NOT NULL,
										CANT_LUNA FLOAT NOT NULL,
										COEF FLOAT NOT NULL,
										CANT_ALOC FLOAT NOT NULL,
										ID INT IDENTITY(1,1) NOT NULL,
										INDEX Temp_Aloc_IND1 NONCLUSTERED ( AN, LUNA )
										) ;

				WITH luna AS (
							SELECT	 AN, LUNA, PARTENERDEAFACERI, INSTALATIE,  CURBA_ACTUAL, SUBPOR_ACTUAL,  SUM(CANT_LUNA) AS CANT_LUNA
							FROM	 #Temp_Luna
							GROUP BY AN, LUNA, PARTENERDEAFACERI, INSTALATIE, CURBA_ACTUAL, SUBPOR_ACTUAL
							 ),
					coef AS (
							SELECT	 DATA_CONS, INTERVAL_CONS, AN ,LUNA, LUNA_NUME, ZI, ZI_NUME, ORA,CURBA, COEF
							FROM	 #Temp_Coef
							GROUP BY  DATA_CONS, INTERVAL_CONS, AN ,LUNA, LUNA_NUME, ZI, ZI_NUME, ORA,CURBA, COEF 
							)

				INSERT INTO #Temp_Aloc (
										DATA_CONS, INTERVAL_CONS, AN, LUNA,LUNA_NUME,
										ZI, ZI_NUME, ORA, SUBPOR_ACTUAL, PARTENERDEAFACERI, CURBA_ACTUAL, 
										CANT_LUNA, COEF, CANT_ALOC
										)
				SELECT    coef.DATA_CONS, coef.INTERVAL_CONS, coef.AN, coef.LUNA, coef.LUNA_NUME,
						  coef.ZI, coef.ZI_NUME, coef.ORA, luna.SUBPOR_ACTUAL, luna.PARTENERDEAFACERI, luna.CURBA_ACTUAL, 
						  SUM(luna.CANT_LUNA) , coef.COEF, SUM(luna.CANT_luna)*coef.COEF
				FROM	  luna, coef
				WHERE	  luna.AN=coef.AN AND luna.LUNA=coef.LUNA AND luna.CURBA_ACTUAL=coef.CURBA
				GROUP BY  coef.DATA_CONS, coef.INTERVAL_CONS, coef.AN, coef.LUNA, coef.LUNA_NUME,
						  coef.ZI, coef.ZI_NUME, coef.ORA, luna.SUBPOR_ACTUAL, luna.PARTENERDEAFACERI, luna.CURBA_ACTUAL, coef.COEF ;

				DECLARE @START INT;
				DECLARE @FINISH INT;
				DECLARE @BATCH_INSERT INT ;

				SELECT	@START=MIN(ID) FROM #Temp_Aloc ;
				SELECT  @FINISH=MAX(ID) FROM #Temp_Aloc ;
				SET		@BATCH_INSERT=100000;

				WHILE @START<=@FINISH

					BEGIN	

						INSERT INTO dbo.EE_NOM_R_MARIMI_ALOC (
																DATA_CONS, INTERVAL_CONS, AN, LUNA,LUNA_NUME,
																ZI, ZI_NUME, ORA, SUBPOR_ACTUAL, PARTENERDEAFACERI, CURBA_ACTUAL, 
																CANT_LUNA, COEF, CANT_ALOC
																)
						SELECT   	DATA_CONS, INTERVAL_CONS, AN, LUNA,LUNA_NUME,
									ZI, ZI_NUME, ORA, SUBPOR_ACTUAL, PARTENERDEAFACERI, CURBA_ACTUAL, 
									CANT_LUNA, COEF, CANT_ALOC
						FROM        #Temp_Aloc
						WHERE		ID BETWEEN @START AND @START+@BATCH_INSERT
						GROUP BY    AN, LUNA, DATA_CONS, INTERVAL_CONS, AN, LUNA,LUNA_NUME,
									ZI, ZI_NUME, ORA, SUBPOR_ACTUAL, PARTENERDEAFACERI, CURBA_ACTUAL, 
									CANT_LUNA, COEF, CANT_ALOC

						SET @START=@START+@BATCH_INSERT
						SET @START=@START+1 ;
					END


				DECLARE @NR_1 CHAR(10); 
				DECLARE @MSG_2 VARCHAR(MAX);

				SET	@NR_1= TRIM(CONVERT(CHAR(10),(SELECT COUNT(*) FROM dbo.EE_NOM_R_MARIMI_ALOC WHERE AN=@AN AND LUNA=@LUNA AND PARTENERDEAFACERI NOT LIKE 'MM%' )));
				SET @MSG_2='01-  '+@NR_1 + ' DE INREGISTRARI B2B AU FOST INSERATE IN TABELA DE ALOC !' ;

				EXEC sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'INFORMARE' ,@MSG_2
				PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG_2

		COMMIT TRAN;

		BEGIN TRAN;
			   		 			
					   WITH coef AS (
									 SELECT	   DATA_CONS, INTERVAL_CONS, AN ,LUNA, LUNA_NUME, ZI, ZI_NUME, ORA,CURBA, COEF
									 FROM	   dbo.AFC_MD_DIM_COEF
									 WHERE	   MOD_ID=1 AND AN=@AN AND LUNA=@LUNA
									 GROUP BY  DATA_CONS, INTERVAL_CONS, AN ,LUNA, LUNA_NUME, ZI, ZI_NUME, ORA,CURBA, COEF
								    ),
						    cant AS (
									SELECT   AN, LUNA, REPLACE(ID_INST,'4','1') AS INSTALATIE, SUBPORTOFOLIU, CURBA,SUM(CANT_FARA_CD_CF) CANT_TOTAL
									FROM     dbo.EE_NOM_R_INT_MM_CANT
									where    AN=@AN AND LUNA=@LUNA
									GROUP BY AN, LUNA, ID_INST, SUBPORTOFOLIU, CURBA
									 )

						INSERT INTO dbo.EE_NOM_R_MARIMI_ALOC (
															 DATA_CONS, INTERVAL_CONS, AN, LUNA,LUNA_NUME,
															 ZI, ZI_NUME, ORA, SUBPOR_ACTUAL, PARTENERDEAFACERI, CURBA_ACTUAL, 
															 CANT_LUNA, COEF, CANT_ALOC
															 )
						SELECT	 coef.DATA_CONS, coef.INTERVAL_CONS, coef.AN, coef.LUNA, coef.LUNA_NUME,
								 coef.ZI, coef.ZI_NUME, coef.ORA, cant.SUBPORTOFOLIU, cant.INSTALATIE, cant.CURBA, 
								 SUM(cant.CANT_TOTAL) AS CANT_LUNA, coef.COEF, SUM(cant.CANT_TOTAL)*coef.COEF
						FROM	 coef, cant
						WHERE	 coef.AN=cant.AN AND coef.LUNA=cant.LUNA AND coef.CURBA=cant.CURBA
						GROUP BY coef.DATA_CONS, coef.INTERVAL_CONS, coef.AN, coef.LUNA, coef.LUNA_NUME,
								 coef.ZI, coef.ZI_NUME, coef.ORA, cant.SUBPORTOFOLIU, cant.INSTALATIE, cant.CURBA , coef.COEF;
			
				DECLARE @NR_2 CHAR(10); 
				DECLARE @MSG_3 VARCHAR(MAX);

				SET	@NR_2= TRIM(CONVERT(CHAR(10),(SELECT COUNT(*) FROM dbo.EE_NOM_R_MARIMI_ALOC WHERE AN=@AN AND LUNA=@LUNA AND PARTENERDEAFACERI LIKE 'MM%' )));
				SET @MSG_3='02-  '+@NR_2 + ' DE INREGISTRARI B2C AU FOST INSERATE IN TABELA DE ALOC ! ' ;

				EXEC sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'INFORMARE' ,@MSG_3
				PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG_3

		COMMIT TRAN;

-- => CHECK COST ALOCATION

		BEGIN TRAN;

				DECLARE @CHECK FLOAT ;
				SELECT  @CHECK = SUM(CANT_DIF) FROM dbo.fn_EE_NOM_R_CANT_ALOC_CHECK (@AN, @LUNA) ;

				IF ISNULL(@CHECK,0) BETWEEN -1000 AND 1000
					BEGIN									   					 
						DECLARE @MSG_4 VARCHAR(100);
						SET     @MSG_4 ='FINISH PROCESARE ALOCARE CANTITATE PE INTERVAL ORAR !';
						EXEC sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'INFORMARE' ,@MSG_4
						PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG_4
					END

				ELSE
					BEGIN
						DECLARE @MSG_5 VARCHAR(100);
						SET     @MSG_5 ='CANTITATILE NU AU FOST CORECT ALOCATE PE INTERVAL ORAR !';
						EXEC sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'EROARE' ,@MSG_5
						PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->EROARE'+' ->'+@MSG_5
						;THROW 500001,@MSG_5,1;
					END;

		COMMIT TRAN;																	

-- => ERROR HANDLING

	END TRY 

		BEGIN CATCH ;
			IF @@TRANCOUNT>0
			ROLLBACK TRAN ;

			DECLARE @ERROR_MESSAGE VARCHAR(1000);
			SET @ERROR_MESSAGE=ERROR_MESSAGE() ;

			EXEC  sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'EROARE' ,@ERROR_MESSAGE
			PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->EROARE'+' ->'+@ERROR_MESSAGE

		END CATCH ;
END;


CREATE PROCEDURE [dbo].[sp_EE_NOM_R_P_COEF]
(
@AN SMALLINT,
@LUNA SMALLINT
)
AS
BEGIN ;
				SET XACT_ABORT , NOCOUNT ON;

				DECLARE @OBJECT_NAME  CHAR(100);
				DECLARE @AN_CALC CHAR(4);
				DECLARE @LUNA_CALC CHAR(2);
				SET     @OBJECT_NAME=OBJECT_NAME(@@PROCID) ;
				SET		@AN_CALC=TRIM(CONVERT(CHAR(4),@AN)) ;
				SET		@LUNA_CALC=TRIM(CONVERT(CHAR(2),@LUNA)) ;

				DECLARE @MSG_1 VARCHAR(100);
				SET     @MSG_1 ='START PROCESARE COEF CURBA PENTRU PERIOADA !';

				EXEC sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'INFORMARE' ,@MSG_1
				PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG_1

	BEGIN TRY ;

-- => DATA PROCESSING INTO TABLE EE_NOM_R_CALC_COEF_CURBA

	BEGIN TRAN ;
		
		DECLARE @RC INT;
		DECLARE @BATCH_DELETE INT ;
		SET	@RC=1;
		SET	@BATCH_DELETE=1000000 ;

			WHILE @RC>0
				BEGIN
					DELETE TOP(@BATCH_DELETE) FROM dbo.EE_NOM_R_CALC_COEF_CURBA ;
					SET @RC=@@ROWCOUNT;
				END

		DECLARE @START INT;
		DECLARE @FINISH INT;
		DECLARE @BATCH_INSERT INT ;

		SELECT	@START=MIN(ID) FROM dbo.EE_NOM_R_INT_COEF_CURBA ;
		SELECT  @FINISH=MAX(ID) FROM dbo.EE_NOM_R_INT_COEF_CURBA ;
		SET	@BATCH_INSERT=1000000;

		WHILE @START<=@FINISH

		BEGIN		
			INSERT INTO dbo.EE_NOM_R_CALC_COEF_CURBA ( 
								 DATA_CONS, 
								 INTERVAL_CONS, AN, 
								 LUNA, 
								 LUNA_NUME, 
								 ZI, 
								 ZI_NUME, 
								 ORA, 
								 COD, COEF, MOD_DE, MOD_TIMP 
								 )
			SELECT  IIF( ORA_CONS='3.5' ,(CAST(CONVERT(CHAR(10),DATA_CONS,101)AS DATETIME)+ CAST(TIMEFROMPARTS(ORA_CONS,30,0,0,0) AS DATETIME)), (CAST(CONVERT(CHAR(10),DATA_CONS,101)AS DATETIME)+ CAST(TIMEFROMPARTS(ORA_CONS,0,0,0,0) AS DATETIME))) ,
				INTERVAL_CONS,DATEPART( YEAR , CONVERT(CHAR(10),DATA_CONS,101)), 
				DATEPART( MONTH , CONVERT(CHAR(10),DATA_CONS,101)) ,
				DATENAME( MONTH , CONVERT(CHAR(10),DATA_CONS,101)) ,
				DATEPART( DAY , CONVERT(CHAR(10),DATA_CONS,101)) ,
				DATENAME( WEEKDAY , CONVERT(CHAR(10),DATA_CONS,101)) ,
				IIF( ORA_CONS='3.5', DATEPART( HOUR , (CAST(CONVERT(CHAR(10),DATA_CONS,101)AS DATETIME)+ CAST(TIMEFROMPARTS(ORA_CONS,30,0,0,0) AS DATETIME)))+0.5,DATEPART( HOUR , (CAST(CONVERT(CHAR(10),DATA_CONS,101)AS DATETIME)+ CAST(TIMEFROMPARTS(ORA_CONS,0,0,0,0) AS DATETIME)))),
				COD, sum(COEF), MOD_DE, MOD_TIMP
			FROM	dbo.EE_NOM_R_INT_COEF_CURBA
			WHERE ID BETWEEN @START AND @START+@BATCH_INSERT
			GROUP BY DATA_CONS,ORA_CONS,INTERVAL_CONS, COD, MOD_DE, MOD_TIMP

			SET @START=@START+@BATCH_INSERT
			SET @START=@START+1 ;
		END
														

		DECLARE @NR_1 CHAR(10); 
		DECLARE @MSG_2 VARCHAR(MAX);

		SET	@NR_1= TRIM(CONVERT(CHAR(10),(SELECT COUNT(*) FROM dbo.AFC_EE_CALC_COEF_CURBA))) ;
		SET @MSG_2='01-  '+@NR_1 + ' DE INREGISTRARI AU FOST INSERATE IN TABELA DE CALC !' ;

		EXEC sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'INFORMARE' ,@MSG_2
		PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG_2

	COMMIT TRAN;				

-- => DATA PROCESSING INTO TABLE AFC_MD_DIM_COEF

	BEGIN TRAN ;
			
		DECLARE @START_2 INT;
		DECLARE @FINISH_2 INT;
		DECLARE @BATCH_2 INT;
		
		SET	@START_2=1;
		SET	@BATCH_2=1000000;
		SELECT  @FINISH_2=COUNT(*) FROM dbo.EE_NOM_R_CALC_COEF_CURBA;
		
		WHILE	@START_2<=@FINISH_2

			BEGIN							
				MERGE INTO AFC_MD_DIM_COEF tgt
				USING (
					SELECT   DATA_CONS, INTERVAL_CONS, AN, LUNA, LUNA_NUME, ZI, ZI_NUME, ORA, COD, COEF, MOD_DE, MOD_TIMP,
						 ROW_NUMBER() OVER (ORDER BY  DATA_CONS ASC ,COD ASC) AS RN
					FROM	 dbo.EE_NOM_R_CALC_COEF_CURBA
					GROUP BY DATA_CONS, INTERVAL_CONS, AN, LUNA, LUNA_NUME, ZI, ZI_NUME, ORA, COD, COEF, MOD_DE, MOD_TIMP
					) src
				ON     (
					tgt.DATA_CONS=src.DATA_CONS AND
					tgt.CURBA=src.COD			AND
					tgt.COEF=src.COEF			AND
					tgt.MOD_TIMP=src.MOD_TIMP
					)
				WHEN NOT MATCHED AND RN BETWEEN @START_2 AND @START_2+@BATCH_2 THEN
				INSERT (  DATA_CONS, INTERVAL_CONS, AN, LUNA, LUNA_NUME, ZI, ZI_NUME, ORA, CURBA, COEF, MOD_DE, MOD_TIMP )
				VALUES (  src.DATA_CONS, src.INTERVAL_CONS, src.AN, src.LUNA, src.LUNA_NUME, src.ZI, src.ZI_NUME, src.ORA, src.COD, src.COEF, src.MOD_DE, src.MOD_TIMP);

				SET @START_2=@START_2+@BATCH_2
				SET @START_2=@START_2+1 ;
			END


		DECLARE @NR_2 CHAR(10); 
		DECLARE @MSG_3 VARCHAR(MAX);

		SET	@NR_2= TRIM(CONVERT(CHAR(10),(SELECT COUNT(*) FROM dbo.AFC_MD_DIM_COEF WHERE MOD_ID IS NULL))) ;
		SET @MSG_3='02-  '+@NR_2 + ' DE INREGISTRARI AU FOST INSERATE IN TABELA DE DIM !' ;

		EXEC sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'INFORMARE' ,@MSG_3;
		PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG_3 ;

		WITH src AS   (
				SELECT   DATA_CONS, CURBA,MOD_TIMP,
					 ROW_NUMBER() OVER (PARTITION BY DATA_CONS,CURBA ORDER BY  DATA_CONS DESC, CURBA DESC ,MOD_TIMP DESC)AS MOD_ID
				FROM	 dbo.AFC_MD_DIM_COEF
				GROUP BY DATA_CONS, CURBA,MOD_TIMP
			       ) 

		UPDATE tgt
		SET    MOD_ID=src.MOD_ID
		FROM   dbo.AFC_MD_DIM_COEF tgt, src
		WHERE  tgt.DATA_CONS=src.DATA_CONS AND tgt.CURBA=src.CURBA AND tgt.MOD_TIMP=src.MOD_TIMP ;
		
		DECLARE @MSG_4 VARCHAR(100);
		SET     @MSG_4='03-  '+cast(@@rowcount as varchar(255)) + ' DE INREGISTRARI AU FOST ACTUALIZATE CU ID !';

		EXEC sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'INFORMARE' ,@MSG_4
		PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG_4

		DECLARE @MSG_5 VARCHAR(100);
		SET     @MSG_5 ='FINISH PROCESARE COEF CURBA !';

		EXEC sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'INFORMARE' ,@MSG_5
		PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG_5


	COMMIT TRAN;											

-- => ERROR HANDLING

	END TRY 

		BEGIN CATCH ;
			IF @@TRANCOUNT>0
			ROLLBACK TRAN ;

			DECLARE @ERROR_MESSAGE VARCHAR(1000);
			SET @ERROR_MESSAGE=ERROR_MESSAGE() ;

			EXEC  sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'EROARE' ,@ERROR_MESSAGE
			PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->EROARE'+' ->'+@ERROR_MESSAGE

		END CATCH ;
END;


CREATE PROCEDURE [dbo].[sp_EE_NOM_R_P_COST_ACH]
(
@AN SMALLINT,
@LUNA SMALLINT
)
AS
BEGIN ;
				SET XACT_ABORT , NOCOUNT ON;

				DECLARE @OBJECT_NAME  CHAR(100) ;
				DECLARE @MSG_1 VARCHAR(100);
				DECLARE @AN_CALC CHAR(4);
				DECLARE @LUNA_CALC CHAR(2);
			
				SET     @OBJECT_NAME=OBJECT_NAME(@@PROCID) ;
				SET		@AN_CALC=TRIM(CONVERT(CHAR(4),@AN)) ;
				SET		@LUNA_CALC=TRIM(CONVERT(CHAR(2),@LUNA)) ;
				SET     @MSG_1 ='START CALCUL COST ACHIZITIE SI COST TRANSPORT !';
				
				EXEC sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'INFORMARE' ,@MSG_1
				PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG_1

	BEGIN TRY ;

-- => COST CALCULATION FOR ELIGIBLE CLIENTS

	BEGIN TRAN ;

		CREATE TABLE #EE_NOM_R_CALC_ACH_MED  ( 
											AN SMALLINT NOT NULL,
											LUNA SMALLINT NOT NULL,
											PARTENERDEAFACERI CHAR(10) NOT NULL,
											SUBPOR_ACTUAL CHAR(2) NOT NULL,
											CURBA_ACTUAL  VARCHAR(50)NOT NULL,
											CANT_ALOC FLOAT ,
											COST_ACH_ALOC FLOAT ,
											COST_MED_ACH_ALOC FLOAT,
											PRIMARY KEY ( AN, LUNA, PARTENERDEAFACERI, SUBPOR_ACTUAL, CURBA_ACTUAL )
											 );

		INSERT INTO  #EE_NOM_R_CALC_ACH_MED  ( AN, LUNA, PARTENERDEAFACERI, SUBPOR_ACTUAL, CURBA_ACTUAL, CANT_ALOC, COST_ACH_ALOC, COST_MED_ACH_ALOC )
		SELECT		 AN, LUNA, PARTENERDEAFACERI, SUBPOR_ACTUAL, CURBA_ACTUAL, SUM(CANT_ALOC), SUM(COST_ACH),
					 CASE WHEN ISNULL(SUM(CANT_ALOC),0)=0 THEN 0 ELSE (SUM(COST_ACH)/SUM(CANT_ALOC)) END "COST_MED_ACH_ALOC"
		FROM		 dbo.EE_NOM_R_MARIMI_ALOC
		WHERE		 AN=@AN AND LUNA=@LUNA 
		GROUP BY	 AN, LUNA, PARTENERDEAFACERI, SUBPOR_ACTUAL, CURBA_ACTUAL;	

		UPDATE      #EE_NOM_R_CALC_ACH_MED
		SET			COST_MED_ACH_ALOC=src.TARIF_ACH_MEDIE,
					COST_ACH_ALOC=CANT_ALOC*ISNULL(src.TARIF_ACH_MEDIE,0)
		FROM        #EE_NOM_R_CALC_ACH_MED tgt, EE_NOM_R_INT_ACH_P3 src
		WHERE		tgt.AN=src.AN AND tgt.LUNA=src.LUNA AND tgt.SUBPOR_ACTUAL=src.SUBPOR AND tgt.PARTENERDEAFACERI=src.PARTENERDEAFACERI;	

				UPDATE   tgt
				SET      TARIF_ACH_PROFILAT_INITIAL=src.COST_MED_ACH_ALOC,
				         COST_ACH_PROFILAT_INITIAL=(ISNULL(tgt.Cant_Fact,0)+ISNULL(tgt.Cant_Delta_Cut_Off,0)+ISNULL(tgt.Cant_Dif,0)-ISNULL(tgt.Cant_Fact_CD_CF,0)-ISNULL(tgt.Cant_Dif_CD_CF,0))*src.COST_MED_ACH_ALOC,
						 TARIF_ACH_PROFILAT_FINAL=src.COST_MED_ACH_ALOC,
				         COST_ACH_PROFILAT_FINAL=(ISNULL(tgt.Cant_Fact,0)+ISNULL(tgt.Cant_Delta_Cut_Off,0)+ISNULL(tgt.Cant_Dif,0)-ISNULL(tgt.Cant_Fact_CD_CF,0)-ISNULL(tgt.Cant_Dif_CD_CF,0))*src.COST_MED_ACH_ALOC
				FROM     dbo.EE_NOM_R_MARIMI tgt, #EE_NOM_R_CALC_ACH_MED src
				WHERE    tgt.AN=src.AN								 AND 
				         tgt.LUNA=src.LUNA							 AND 
				         tgt.PARTENERDEAFACERI=src.PARTENERDEAFACERI AND 
						 tgt.SUBPOR_ACTUAL=src.SUBPOR_ACTUAL AND 
						 tgt.CURBA_ACTUAL=src.CURBA_ACTUAL ;     
					 
		DECLARE @NR_1 CHAR(10); 
		DECLARE @MSG_2 VARCHAR(100);

		SET	    @NR_1=TRIM(CONVERT(CHAR(10),(SELECT COUNT(*) FROM dbo.EE_NOM_R_MARIMI WHERE AN=@AN AND LUNA=@LUNA AND STARECLIENT IN ('ELIGIBIL','AGENTFUI','AGENTSU') AND TARIF_ACH_PROFILAT_INITIAL IS NOT NULL))) ;
		SET     @MSG_2='02-  '+@NR_1+' DE INREGISTRARI ELIGIBILI AU COST DE ACHIZITIE CALCULAT !';

		EXEC sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'INFORMARE' ,@MSG_2
		PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG_2


	COMMIT TRAN;	
	
-- => INDICATOR CALCULATION

	BEGIN TRAN ;	

					MERGE INTO  dbo.EE_NOM_R_MARIMI tgt
						USING ( SELECT   AN,LUNA,StareClient,Tarif_Trans
								FROM     dbo.EE_NOM_R_INT_TARIF_TRANS
								WHERE	 AN=@AN AND LUNA=@LUNA
								GROUP BY AN,LUNA, StareClient, Tarif_Trans
							) src
						ON     (
							tgt.AN=src.AN                    and
							tgt.LUNA=src.LUNA                and
							tgt.StareClient=src.StareClient 
							)
					WHEN MATCHED THEN
					UPDATE   
					Set    tgt.Tarif_Trans=src.Tarif_Trans;

					MERGE INTO  EE_NOM_R_MARIMI tgt
						USING ( SELECT    PARTENERDEAFACERI, INSTALATIE, DeLaAnLuna, PanaLaAnLuna
								FROM      dbo.EE_NOM_R_INT_EXCL_TRANS
								GROUP BY  PARTENERDEAFACERI, INSTALATIE, DeLaAnLuna,PanaLaAnLuna
							) src
						ON     (
							tgt.PARTENERDEAFACERI=src.PARTENERDEAFACERI and
							tgt.INSTALATIE=src.INSTALATIE
							)
					WHEN MATCHED AND CONVERT(CHAR(10),tgt.DeLaData,101) between src.DeLaAnLuna and src.PanaLaAnLuna and tgt.An=@AN and tgt.Luna=@LUNA THEN
					UPDATE   
					SET      tgt.Tarif_Trans= 0;

					UPDATE dbo.EE_NOM_R_MARIMI
					SET    Cost_Trans=(Cant_Fact+Cant_Delta_Cut_Off+Cant_Dif-Cant_Fact_CD_CF-Cant_Dif_CD_CF)*Tarif_Trans
					WHERE  An=@AN and Luna=@LUNA;


		DECLARE @NR_3 CHAR(10); 
		DECLARE @MSG_4 VARCHAR(100);

		SET	@NR_3=TRIM(CONVERT(CHAR(10),(SELECT COUNT(*) FROM dbo.EE_NOM_R_MARIMI WHERE AN=@AN AND LUNA=@LUNA AND Cost_Trans IS NOT NULL))) ;
		SET @MSG_4='03-  '+@NR_3+' DE INREGISTRARI AU COST DE TRANSPORT CALCULAT !';

		EXEC sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'INFORMARE' ,@MSG_4
		PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG_4
	
		DECLARE @MSG_5 VARCHAR(100);
		SET     @MSG_5 ='FINISH CALCUL COST ACHIZITIE SI COST TRANSPORT !';

		EXEC sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'INFORMARE' ,@MSG_5
		PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG_5


	COMMIT TRAN;																			

-- => ERROR HANDLING

	END TRY 

		BEGIN CATCH ;
			IF @@TRANCOUNT>0
			ROLLBACK TRAN ;

			DECLARE @ERROR_MESSAGE VARCHAR(1000);
			SET @ERROR_MESSAGE=ERROR_MESSAGE() ;

			EXEC  sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'EROARE' ,@ERROR_MESSAGE
			PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->EROARE'+' ->'+@ERROR_MESSAGE

		END CATCH ;
END;

CREATE PROCEDURE [dbo].[sp_EE_NOM_R_P_COST_DISTR]
(
@AN SMALLINT,
@LUNA SMALLINT
)
AS
BEGIN

	SET NOCOUNT ON;

	SET XACT_ABORT , NOCOUNT ON;


	DECLARE @OBJECT_NAME  CHAR(100);
	DECLARE @AN_CALC CHAR(4);
	DECLARE @LUNA_CALC CHAR(2);
	SET     @OBJECT_NAME=OBJECT_NAME(@@PROCID) ;
	SET		@AN_CALC=TRIM(CONVERT(CHAR(4),@AN)) ;
	SET		@LUNA_CALC=TRIM(CONVERT(CHAR(2),@LUNA)) ;

	DECLARE @MSG_1 VARCHAR(100);
	SET     @MSG_1 ='START CALCUL COST DE DISTRIBUTIE !';

	EXEC sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'INFORMARE' ,@MSG_1
	PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG_1

	BEGIN TRY ;

-- => INDICATOR CALCULATION

		BEGIN TRAN ;

			MERGE INTO  dbo.EE_NOM_R_MARIMI tgt
					USING ( SELECT    DENUMIREDISTRIBUITOR, NIVELDETENSIUNE, DELAANLUNAZI, PANALAANLUNAZI, TARIF_DISTR 
							FROM      dbo.EE_NOM_R_INT_TARIF_DISTR
							GROUP BY  DENUMIREDISTRIBUITOR, NIVELDETENSIUNE, DELAANLUNAZI, PANALAANLUNAZI, TARIF_DISTR 
						) src
					ON     (
							tgt.DENUMIREDISTRIBUITOR=src.DENUMIREDISTRIBUITOR  AND
							tgt.NIVELDETENSIUNE=src.NIVELDETENSIUNE
							)
					WHEN MATCHED AND tgt.DELAANLUNAZI BETWEEN  src.DELAANLUNAZI AND src.PANALAANLUNAZI AND  tgt.AN=@AN AND tgt.LUNA=@LUNA THEN
					UPDATE   
					SET      tgt.TARIF_DISTR= src.TARIF_DISTR ;	
										
			DECLARE @MSG_2 VARCHAR(100);
			SET     @MSG_2 ='01-  '+cast(@@rowcount as varchar(255)) + ' DE INREGISTRARI AU FOST MAPATE CU TARIF DE DISTRIBUTIE !' ;

			EXEC sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'INFORMARE' ,@MSG_2
			PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG_2										

		COMMIT TRAN ;

		BEGIN TRAN ;
				 
				MERGE INTO  dbo.EE_NOM_R_MARIMI tgt
							USING ( SELECT    PartenerDeAfaceri,Instalatie,DeLaAnLuna,PanaLaAnLuna
									FROM      dbo.EE_NOM_R_INT_EXCL_DISTR
									GROUP BY  PartenerDeAfaceri,Instalatie,DeLaAnLuna,PanaLaAnLuna
								) src
							ON     (
									tgt.PartenerDeAfaceri=src.PartenerDeAfaceri and
									tgt.Instalatie=src.Instalatie
									)
						WHEN MATCHED AND CONVERT(CHAR(10),tgt.DeLaData,101) between src.DeLaAnLuna and src.PanaLaAnLuna and  tgt.An=@AN and tgt.Luna=@LUNA THEN
						UPDATE   
						SET      tgt.Tarif_Distr= 0;

			DECLARE @MSG_3 VARCHAR(100);
			SET     @MSG_3 ='02-  '+cast(@@rowcount as varchar(255)) + ' DE INREGISTRARI AU FOST MAPATE PENTRU CARE NU SE CALCULEAZA COST DE DISTRIBUTIE !' ;

			EXEC sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'INFORMARE' ,@MSG_3
			PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG_3

		COMMIT TRAN ;

		BEGIN TRAN ;

		MERGE INTO  dbo.EE_NOM_R_MARIMI tgt
					USING ( SELECT    NIVELDETENSIUNE, DELAANLUNAZI, PANALAANLUNAZI, TARIF_CD_CF
							FROM      dbo.EE_NOM_R_INT_TARIF_CD_CF
							GROUP BY  NIVELDETENSIUNE, DELAANLUNAZI, PANALAANLUNAZI, TARIF_CD_CF
						) src
					ON     (
							tgt.NIVELDETENSIUNE=src.NIVELDETENSIUNE
							)
					WHEN MATCHED AND tgt.DELAANLUNAZI BETWEEN  src.DELAANLUNAZI AND src.PANALAANLUNAZI AND  tgt.AN=@AN AND tgt.LUNA=@LUNA THEN
					UPDATE   
					SET      tgt.TARIF_CD_CF= src.TARIF_CD_CF ;	

			DECLARE @MSG_4 VARCHAR(100);
			SET     @MSG_4 ='03-  '+cast(@@rowcount as varchar(255)) + ' DE INREGISTRARI AU FOST MAPATE CU TARIF CD_CF !' ;

			EXEC sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'INFORMARE' ,@MSG_4
			PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG_4       

		COMMIT TRAN ;

		BEGIN TRAN ;

			Update dbo.EE_NOM_R_MARIMI
			Set    Cost_Distr=Cost_Distr_Delta_Cut_Off+(Cant_Fact+Cant_Dif-Cant_Fact_CD_CF-Cant_Dif_CD_CF)*Tarif_Distr+(Cant_Fact_CD_CF+Cant_Dif_CD_CF)*TARIF_CD_CF
			WHERE  An=@AN and Luna=@LUNA ;

			DECLARE @MSG_5 VARCHAR(100);
			SET     @MSG_5 ='04-  '+cast(@@rowcount as varchar(255)) + ' DE INREGISTRARI AU CALCULAT COST DE DISTRIBUTIE !' ;

			EXEC sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'INFORMARE' ,@MSG_5
			PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG_5
			
			DECLARE @MSG_6 VARCHAR(100);
			SET     @MSG_6 ='FINISH CALCUL COST DE DISTRIBUTIE  !';
			EXEC sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'INFORMARE' ,@MSG_6
			PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG_6            

		COMMIT TRAN ;

-- => ERROR HANDLING

	END TRY 

		BEGIN CATCH ;
			IF @@TRANCOUNT>0
			ROLLBACK TRAN ;

			DECLARE @ERROR_MESSAGE VARCHAR(1000);
			SET @ERROR_MESSAGE=ERROR_MESSAGE() ;

			EXEC  sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'EROARE' ,@ERROR_MESSAGE
			PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->EROARE'+' ->'+@ERROR_MESSAGE

		END CATCH ;
END;

CREATE PROCEDURE [dbo].[sp_EE_NOM_R_P_CURBA]
(
@AN SMALLINT,
@LUNA SMALLINT
)
AS
BEGIN ;
				SET XACT_ABORT , NOCOUNT ON;

				DECLARE @OBJECT_NAME  CHAR(100);
				DECLARE @AN_CALC CHAR(4);
				DECLARE @LUNA_CALC CHAR(2);
				SET     @OBJECT_NAME=OBJECT_NAME(@@PROCID) ;
				SET		@AN_CALC=TRIM(CONVERT(CHAR(4),@AN)) ;
				SET		@LUNA_CALC=TRIM(CONVERT(CHAR(2),@LUNA)) ;

				DECLARE @MSG_1 VARCHAR(100);
				SET     @MSG_1 ='START PROCESARE MAPARE CURBA CONSUM !';

				EXEC sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'INFORMARE' ,@MSG_1
				PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG_1

	BEGIN TRY ;
	
-- => DATA PROCESSING INTO DIM TABLE

			BEGIN TRAN ;

					CREATE TABLE #T_Curba	 ( INSTALATIE CHAR(10) NOT NULL,
											   COD CHAR(50) NOT NULL ,
											   INDEX #Temp_Curba NONCLUSTERED ( INSTALATIE )
											 );

					INSERT INTO #T_Curba ( INSTALATIE , COD )
					SELECT INSTALATIE , CURBA FROM  dbo.AFC_MD_DIM_CURBA WHERE MOD_ID=1 GROUP BY INSTALATIE , CURBA ;
							
					UPDATE  tgt
					SET     CURBA_ACTUAL=src.COD
					FROM	dbo.EE_NOM_R_MARIMI tgt , ( SELECT INSTALATIE, COD FROM #T_Curba GROUP BY INSTALATIE, COD)  src
					WHERE   tgt.AN=@AN AND tgt.LUNA=@LUNA AND tgt.INSTALATIE=src.INSTALATIE  ;

				DECLARE @CHECK FLOAT;
				SELECT  @CHECK= COUNT(DISTINCT INSTALATIE) FROM dbo.EE_NOM_R_MARIMI WHERE AN=@AN AND LUNA=@LUNA AND STARECLIENT IN ('ELIGIBIL','AGENTFUI','AGENTSU') AND CURBA_ACTUAL IS NULL ;

				IF ISNULL(@CHECK,0)=0
					BEGIN

						DECLARE @NR_1 CHAR(10); 
						DECLARE @MSG_4 VARCHAR(MAX);

						SET	@NR_1= TRIM(CONVERT(CHAR(10),(SELECT COUNT(DISTINCT INSTALATIE) FROM dbo.EE_NOM_R_MARIMI WHERE  AN=@AN AND LUNA=@LUNA AND STARECLIENT IN ('ELIGIBIL','AGENTFUI','AGENTSU') AND CURBA_ACTUAL IS NOT NULL)));
						SET @MSG_4='03-  '+@NR_1 + ' DE INREGISTRARI AU FOST INSERATE IN TABELA DE MARIMI !' ;

						EXEC  sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'INFORMARE' ,@MSG_4
						PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG_4

						DECLARE @MSG_5 VARCHAR(100);
						SET     @MSG_5 ='FINISH PROCESARE MAPARE CURBA CONSUM !';

						EXEC  sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'INFORMARE' ,@MSG_5
						PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG_5
					END

				ELSE IF ISNULL(@CHECK,0)!=0
					BEGIN
						DECLARE @MSG_6 VARCHAR(100);
						SET @MSG_6='04-  '+@CHECK + ' DE INSTALATII NU AU FOST MAPATI CU COD CURBA !' ;
						EXEC sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'EROARE' ,@MSG_6
						PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->EROARE'+' ->'+@MSG_6
						;THROW 500001,@MSG_6,1;
					END

			COMMIT TRAN;											

-- => ERROR HANDLING

	END TRY 

		BEGIN CATCH ;
			IF @@TRANCOUNT>0
			ROLLBACK TRAN ;

			DECLARE @ERROR_MESSAGE VARCHAR(1000);
			SET @ERROR_MESSAGE=ERROR_MESSAGE() ;

			EXEC  sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'EROARE' ,@ERROR_MESSAGE
			PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->EROARE'+' ->'+@ERROR_MESSAGE

		END CATCH ;
END;

CREATE PROCEDURE [dbo].[sp_EE_NOM_R_P_DATE_EVO]
(
@AN SMALLINT,
@LUNA SMALLINT
)
AS
BEGIN ;
				SET XACT_ABORT , NOCOUNT ON;

				DECLARE @OBJECT_NAME  CHAR(100);
				DECLARE @AN_CALC CHAR(4);
				DECLARE @LUNA_CALC CHAR(2);
				SET     @OBJECT_NAME=OBJECT_NAME(@@PROCID) ;
				SET		@AN_CALC=TRIM(CONVERT(CHAR(4),@AN)) ;
				SET		@LUNA_CALC=TRIM(CONVERT(CHAR(2),@LUNA)) ;

				DECLARE @MSG_1 VARCHAR(100);
				SET     @MSG_1 ='START ACTUALIZARE TABEL EVOLUTIE';

				EXEC sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'INFORMARE' ,@MSG_1
				PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG_1

	BEGIN TRY ;

-- => DATA PROCESSING FOR REPORTING

	BEGIN TRAN ;	  

			DELETE FROM dbo.EE_NOM_R_MARIMI_EVO WHERE AN=@AN ;

			WITH fact AS (
							SELECT	 AN, CONCAT('CANT_',CAST(LUNA AS VARCHAR(2))) CANT_LUNA, CONCAT('MRJ_',CAST(LUNA AS VARCHAR(2))) AS MRJ_LUNA, 
									 PARTENERDEAFACERI, INSTALATIE, SEGMENTCLIENT, STARECLIENT, SUM(CANT_TOTAL) CANT_TOTAL, SUM(GROSS_MARGIN) GROSS_MARGIN,
									 DELADATA, PANALADATA
							FROM	 dbo.EE_NOM_R_MARIMI
							WHERE    AN=@AN 
							GROUP BY AN, LUNA, PARTENERDEAFACERI, INSTALATIE, SEGMENTCLIENT, STARECLIENT, DELADATA, PANALADATA
						  ),
				 pa  AS  (  SELECT   PARTENERDEAFACERI, DENUMIREPARTENER, DELADATA, PANALADATA
							FROM     dbo.EE_NOM_R_MAPARI_PA
							GROUP BY PARTENERDEAFACERI, DENUMIREPARTENER, DELADATA, PANALADATA
						 )


				INSERT INTO dbo.EE_NOM_R_MARIMI_EVO (  AN, PARTENERDEAFACERI, DENUMIREPARTENER, INSTALATIE, SEGMENTCLIENT, STARECLIENT,
													   CANT_01, CANT_02, CANT_03, CANT_04, CANT_05, CANT_06, 
													   CANT_07, CANT_08, CANT_09, CANT_10, CANT_11, CANT_12,
													   MRJ_01, MRJ_02, MRJ_03, MRJ_04, MRJ_05, MRJ_06, 
													   MRJ_07, MRJ_08, MRJ_09, MRJ_10, MRJ_11, MRJ_12
													)

				SELECT	AN, PARTENERDEAFACERI, DENUMIREPARTENER, INSTALATIE, SEGMENTCLIENT, STARECLIENT ,
						SUM(CANT_1) CANT_01,SUM(CANT_2) CANT_02, SUM(CANT_3) CANT_03, SUM(CANT_4) CANT_04, SUM(CANT_5) CANT_05, SUM(CANT_6) CANT_06,
						SUM(CANT_7) CANT_07, SUM(CANT_8) CANT_08, SUM(CANT_9) CANT_09, SUM(CANT_10) CANT_10, SUM(CANT_11) CANT_11, SUM(CANT_12) CANT_12,
						SUM(MRJ_1) MRJ_01,SUM(MRJ_2) MRJ_02, SUM(MRJ_3) MRJ_03, SUM(MRJ_4) MRJ_04, SUM(MRJ_5) MRJ_05, SUM(MRJ_6) MRJ_06,
						SUM(MRJ_7) MRJ_07, SUM(MRJ_8) MRJ_08, SUM(MRJ_9) MRJ_09, SUM(MRJ_10) MRJ_10, SUM(MRJ_11) MRJ_11, SUM(MRJ_12) MRJ_12

				FROM 
				(

				SELECT	    fact.AN, fact.CANT_LUNA , fact.MRJ_LUNA, fact.PARTENERDEAFACERI, fact.INSTALATIE, fact.SEGMENTCLIENT, pa.DENUMIREPARTENER,
							fact.STARECLIENT, SUM(fact.CANT_TOTAL) CANT_TOTAL, SUM(fact.GROSS_MARGIN) GROSS_MARGIN
				FROM		fact, pa
				WHERE		fact.PARTENERDEAFACERI=pa.PARTENERDEAFACERI AND fact.DELADATA=pa.DELADATA AND fact.PANALADATA=pa.PANALADATA
				GROUP BY	fact.AN, fact.CANT_LUNA, fact.MRJ_LUNA,  fact.PARTENERDEAFACERI, fact.INSTALATIE, fact.SEGMENTCLIENT, pa.DENUMIREPARTENER, fact.STARECLIENT
				) src
				PIVOT ( 
						SUM(CANT_TOTAL) FOR CANT_LUNA IN ( [CANT_1],[CANT_2],[CANT_3],[CANT_4],[CANT_5],[CANT_6],[CANT_7],[CANT_8],[CANT_9],[CANT_10],[CANT_11],[CANT_12]
													)
					 )  cant
				PIVOT ( 
						SUM(GROSS_MARGIN) FOR MRJ_LUNA IN ( [MRJ_1],[MRJ_2],[MRJ_3],[MRJ_4],[MRJ_5],[MRJ_6],[MRJ_7],[MRJ_8],[MRJ_9],[MRJ_10],[MRJ_11],[MRJ_12]
													)
					 )  mrj
				GROUP BY AN, PARTENERDEAFACERI, DENUMIREPARTENER, INSTALATIE, SEGMENTCLIENT, STARECLIENT	


			DECLARE @MSG_2 VARCHAR(100);
			SET     @MSG_2 ='01-  '+cast(@@rowcount as varchar(255)) + ' DE INREGISTRARI AU FOST INSERATE !';

			EXEC sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'INFORMARE' ,@MSG_2
			PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG_2

			DECLARE @MSG_3 VARCHAR(100);
			SET     @MSG_3 ='FINISH ACTUALIZARE TABEL EVOLUTIE !';

			EXEC sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'INFORMARE' ,@MSG_3
			PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG_3

	COMMIT TRAN;																			
	
-- => ERROR HANDLING

	END TRY 

		BEGIN CATCH ;
			IF @@TRANCOUNT>0
			ROLLBACK TRAN ;

			DECLARE @ERROR_MESSAGE VARCHAR(1000);
			SET @ERROR_MESSAGE=ERROR_MESSAGE() ;

			EXEC  sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'EROARE' ,@ERROR_MESSAGE
			PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->EROARE'+' ->'+@ERROR_MESSAGE

		END CATCH ;
END;


CREATE PROCEDURE [dbo].[sp_EE_NOM_R_P_DATE_SUBPOR]
(
@AN SMALLINT,
@LUNA SMALLINT
)
AS
BEGIN ;
				SET XACT_ABORT , NOCOUNT ON;

				DECLARE @OBJECT_NAME  CHAR(100);
				DECLARE @AN_CALC CHAR(4);
				DECLARE @LUNA_CALC CHAR(2);
				DECLARE @ZI_SAPT_OFERTA INT ;
				SET     @OBJECT_NAME=OBJECT_NAME(@@PROCID) ;
				SET		@AN_CALC=TRIM(CONVERT(CHAR(4),@AN)) ;
				SET		@LUNA_CALC=TRIM(CONVERT(CHAR(2),@LUNA)) ;

				DECLARE @MSG_1 VARCHAR(100);
				SET     @MSG_1 ='START PROCESARE MAPARE PRET BANDA SI PRET PZU PENTRU SUBPORTOFOLIU P2 !';

				EXEC sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'INFORMARE' ,@MSG_1
				PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG_1

	BEGIN TRY ;	

-- => DATA PROCESSING INTO FACT TABLE
	
	BEGIN TRAN ;

				WITH src AS ( 
							SELECT   AN, LUNA, SUBPOR,PARTENERDEAFACERI, CANT_BANDA_ORA, PRET_BANDA_ORA
							FROM     dbo.AFC_MD_ACH_SUBPOR_NOU
							WHERE    AN=@AN AND LUNA=@LUNA
							GROUP BY AN, LUNA, SUBPOR,PARTENERDEAFACERI, CANT_BANDA_ORA, PRET_BANDA_ORA
						   )

				UPDATE tgt
				SET     CANT_BANDA=src.CANT_BANDA_ORA,
						PRET_BANDA=src.PRET_BANDA_ORA,
						VALABIL_OFERTA='DA'
				FROM    dbo.EE_NOM_R_MARIMI_ALOC tgt, src
				WHERE  	tgt.AN=src.AN								AND
						tgt.LUNA=src.LUNA							AND
						tgt.SUBPOR_ACTUAL=src.SUBPOR				AND
						tgt.PARTENERDEAFACERI=src.PARTENERDEAFACERI	AND
						tgt.AN=@AN									AND
						tgt.LUNA=@LUNA								AND
						tgt.SUBPOR_ACTUAL='P2';

		DECLARE @NR_1 CHAR(10); 
		DECLARE @MSG_2 VARCHAR(100);

		SET	@NR_1=TRIM(CONVERT(CHAR(10),(SELECT COUNT(*) FROM dbo.EE_NOM_R_MARIMI_ALOC WHERE AN=@AN AND LUNA=@LUNA AND SUBPOR_ACTUAL IN ( 'P2' ) AND VALABIL_OFERTA IS NOT NULL))) ;
		SET @MSG_2='01-  '+@NR_1+' DE INREGISTRARI AU FOST ACTUALIZATE PENTRU SUBPORTOFOLIU P2 !';

		EXEC sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'INFORMARE' ,@MSG_2
		PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG_2

		UPDATE EE_NOM_R_MARIMI_ALOC
		SET    CANT_BANDA= NULL,
			   PRET_BANDA=NULL,
			   VALABIL_OFERTA='NU',
			   SUBPOR_ACTUAL='P1'
		WHERE AN=@AN AND LUNA=@LUNA AND CANT_LUNA=0 AND SUBPOR_ACTUAL IN ('P2','P3')

		DECLARE @MSG_3 VARCHAR(100);
		SET     @MSG_3 ='02-  '+cast(@@rowcount as varchar(255)) + ' DE INREGISTRARI P2 SI P3 AU CANTITATI LUNARE ZERO , BANDA SE MAPEAZA CU ZERO!' ;

		EXEC sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'INFORMARE' ,@MSG_3
		PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG_3


		DECLARE @MSG_4 VARCHAR(100);
		SET     @MSG_4 ='FINISH PROCESARE MAPARE PRET BANDA SI PRET PZU PENTRU SUBPORTOFOLIU P2 !';

		EXEC sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'INFORMARE' ,@MSG_4
		PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG_4


	COMMIT TRAN;												

-- => ERROR HANDLING

	END TRY 

		BEGIN CATCH ;
			IF @@TRANCOUNT>0
			ROLLBACK TRAN ;

			DECLARE @ERROR_MESSAGE VARCHAR(1000);
			SET @ERROR_MESSAGE=ERROR_MESSAGE() ;

			EXEC  sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'EROARE' ,@ERROR_MESSAGE
			PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->EROARE'+' ->'+@ERROR_MESSAGE

		END CATCH ;
END;

CREATE PROCEDURE [dbo].[sp_EE_NOM_R_P_GM]
(
@AN SMALLINT,
@LUNA SMALLINT
)
AS
BEGIN ;
				SET XACT_ABORT , NOCOUNT ON;

				DECLARE @OBJECT_NAME  CHAR(100);
				DECLARE @AN_CALC CHAR(4);
				DECLARE @LUNA_CALC CHAR(2);
				SET     @OBJECT_NAME=OBJECT_NAME(@@PROCID) ;
				SET		@AN_CALC=TRIM(CONVERT(CHAR(4),@AN)) ;
				SET		@LUNA_CALC=TRIM(CONVERT(CHAR(2),@LUNA)) ;

				DECLARE @MSG_1 VARCHAR(100);
				SET     @MSG_1 ='START CALCUL GROSS MARGIN!';

				EXEC sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'INFORMARE' ,@MSG_1
				PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG_1

	BEGIN TRY ;

-- => INDICATOR CALCULATION

	BEGIN TRAN ;	

	   		UPDATE    dbo.EE_NOM_R_MARIMI
			SET       GROSS_MARGIN=ISNULL(VALOAREFARACV_TOTAL,0)-ISNULL(COST_DISTR,0)-ISNULL(COST_TRANS,0)-ISNULL(COST_ACH_PROFILAT_FINAL,0)
			WHERE     An=@AN and Luna=@LUNA;

			DECLARE @MSG_2 VARCHAR(100);
			SET     @MSG_2 ='01-  '+cast(@@rowcount as varchar(255)) + ' DE INREGISTRARI AU CALCULAT GROSS MARGIN !';

			EXEC sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'INFORMARE' ,@MSG_2
			PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG_2
				
			DECLARE @MSG_3 VARCHAR(100);
			SET     @MSG_3 ='FINISH CALCUL GROSS MARGIN!';

			EXEC sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'INFORMARE' ,@MSG_3
			PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG_3

	COMMIT TRAN;																			

-- => ERROR HANDLING

	END TRY 

		BEGIN CATCH ;
			IF @@TRANCOUNT>0
			ROLLBACK TRAN ;

			DECLARE @ERROR_MESSAGE VARCHAR(1000);
			SET @ERROR_MESSAGE=ERROR_MESSAGE() ;

			EXEC  sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'EROARE' ,@ERROR_MESSAGE
			PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->EROARE'+' ->'+@ERROR_MESSAGE

		END CATCH ;
END;

CREATE PROCEDURE [dbo].[sp_EE_NOM_R_P_SUBPOR]
(
@AN SMALLINT,
@LUNA SMALLINT
)
AS
BEGIN ;
				SET XACT_ABORT , NOCOUNT ON;

				DECLARE @OBJECT_NAME  CHAR(100);
				DECLARE @AN_CALC CHAR(4);
				DECLARE @LUNA_CALC CHAR(2);
				SET     @OBJECT_NAME=OBJECT_NAME(@@PROCID) ;
				SET		@AN_CALC=TRIM(CONVERT(CHAR(4),@AN)) ;
				SET		@LUNA_CALC=TRIM(CONVERT(CHAR(2),@LUNA)) ;

				DECLARE @MSG_1 VARCHAR(100);
				SET     @MSG_1 ='START PROCESARE MAPARE SUBPORTOFOLIU !';

				EXEC sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'INFORMARE' ,@MSG_1
				PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG_1

	BEGIN TRY ;

-- => DATA PROCESSING INTO DIM TABLE

			BEGIN TRAN ;
						
			  WITH src AS (	
							SELECT	 AN, LUNA, PARTENERDEAFACERI, SUBPOR
							FROM	 dbo.fn_AFC_EE_ID_SUBPOR ( @AN, @LUNA )
							GROUP BY AN, LUNA, PARTENERDEAFACERI, SUBPOR
						  )

				UPDATE tgt
				SET     SUBPOR_ACTUAL=src.SUBPOR
				FROM	dbo.EE_NOM_R_MARIMI tgt , src
				WHERE   tgt.AN=src.AN AND tgt.LUNA=src.LUNA AND tgt.PARTENERDEAFACERI=src.PARTENERDEAFACERI AND tgt.STARECLIENT IN ('ELIGIBIL','AGENTFUI','AGENTSU');

				UPDATE tgt
				SET     SUBPOR_ACTUAL='P1'
				FROM	dbo.EE_NOM_R_MARIMI tgt
				WHERE   AN=@AN AND LUNA=@LUNA AND SUBPOR_ACTUAL IS NULL AND STARECLIENT IN ('ELIGIBIL','AGENTFUI','AGENTSU') ;

				DECLARE @CHECK FLOAT;
				SELECT  @CHECK= COUNT(DISTINCT PARTENERDEAFACERI) FROM dbo.EE_NOM_R_MARIMI WHERE AN=@AN AND LUNA=@LUNA AND STARECLIENT IN ('ELIGIBIL','AGENTFUI','AGENTSU')AND SUBPOR_ACTUAL IS NULL ;

				IF ISNULL(@CHECK,0)=0
					BEGIN
					
						DECLARE @MSG_2 VARCHAR(100);
						SET     @MSG_2 ='FINISH PROCESARE MAPARE SUBPORTOFOLIU !';

						EXEC  sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'INFORMARE' ,@MSG_2
						PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->INFORMARE'+' ->'+@MSG_2
					END

				ELSE IF ISNULL(@CHECK,0)!=0
					BEGIN
						DECLARE @MSG_3 VARCHAR(100);
						SET @MSG_3='01-  '+@CHECK + ' DE PARTENER NU AU FOST MAPATI CU COD SUBPORTOFOLIU !' ;
						EXEC sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'EROARE' ,@MSG_3
						PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->EROARE'+' ->'+@MSG_3
						;THROW 500001,@MSG_3,1;
					END

			COMMIT TRAN;											

-- => ERROR HANDLING

	END TRY 

		BEGIN CATCH ;
			IF @@TRANCOUNT>0
			ROLLBACK TRAN ;

			DECLARE @ERROR_MESSAGE VARCHAR(1000);
			SET @ERROR_MESSAGE=ERROR_MESSAGE() ;

			EXEC  sp_EE_NOM_R_RECORD_LOG @AN, @LUNA, @OBJECT_NAME, 'EROARE' ,@ERROR_MESSAGE
			PRINT @AN_CALC+' '+@LUNA_CALC +' : '+@OBJECT_NAME+'->EROARE'+' ->'+@ERROR_MESSAGE

		END CATCH ;
END;






GO
