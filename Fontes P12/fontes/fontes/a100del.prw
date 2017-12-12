#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"
#INCLUDE "protheus.ch"
//
//  Jun/2011 - Carlos Nemesio Puerta
//
//  A100DEL() - Ponto de entrada com valida��o adicional na exclus�o do documento de entrada.
//
User Function A100DEL()
Local clDoc		:= SF1->F1_DOC 
Local clSerie	:= SF1->F1_SERIE 
Local clFil		:= SF1->F1_FILIAL
Local clForn	:= SF1->F1_FORNECE
Local clLoja	:= SF1->F1_LOJA
Local clForm	:= Iif(EMPTY(SF1->F1_FORMUL),'N',SF1->F1_FORMUL)
Local clChave	:= clFil+clDoc+clSerie+clForn+clLoja+clForm
Local cFilStore:=Alltrim(U_MyNewSX6("ES_NCG0000","06","C","Filiais que utilizam WMS Store","","",.F. ))
Local lWmsStore:=(cFilAnt$cFilStore)
Local clQry		:= ""
Local clQry2	:= ""
Local cAlias	:= GetNextAlias()
Local cAlias1	:= GetNextAlias()
Local cAlias2	:= GetNextAlias()
Local cAlias3	:= GetNextAlias()
Local llCntValid:= .F.
Local alCampos1 := {}
Local alReg1 	:= {}
Local alCmpChave:= {}
Local alValChave:= {}
Local cFiliais	:= SuperGetMV("NCG_000030",.F.,"03") 
Local _lRet		:= .T.
Local clUsrBD	:=	U_MyNewSX6(	"NCG_000019", ;
								"", ;
								"C", ;
								"Usu�rio para acessar a base do WMS",;
								"Usu�rio para acessar a base do WMS",;
								"Usu�rio para acessar a base do WMS",;
								.F. )
								
Private _aArea	:= GetArea()
Public	_aRecno	:= {}
Public _cQuery	:= ""

If _lRet

	If IsIncallStack("A140ESTCLA")
	
    	If  clFil $ FormatIN(cFiliais,"|")
			/******************************************************************************************************************
			| O estorno da Classifica��o Documento de Entrada s� pode ocorrer se o mesmo n�o estiver na tabela P0A ou se	  | 
			| ainda n�o foi exportado para o WMS, caso j� tenha sido exportado n�o pode estar no sistema WMS  				  |
			| ou deve possuir uma integra��o de exclus�o com a tabela TB_WMSINTERF_CANC_ENT_SAI	  		  	  				  |
			******************************************************************************************************************/     
			clQry2 	:= " SELECT P0A_EXPORT, R_E_C_N_O_ FROM " + RetSqlName("P0A") + " P0A "
			clQry2	+= " WHERE P0A_CHAVE LIKE '%"+ ALLTRIM(clFil) +"'||'"+clDoc+"'||'"+clSerie +"'||'"+ ALLTRIM(clForn)+"'||'"+ ALLTRIM(clLoja)+"%' "
//			clQry2 	+= " WHERE P0A_CHAVE LIKE '"+ clFil +"'||'"+ clDoc+"'||'"+ clSerie +"'||'"+ ALLTRIM(clForn)+"'||'"+ ALLTRIM(clLoja)+"'||'"+clForm+"' "	
			clQry2	+= " AND D_E_L_E_T_ = ' ' "  
			clQry2 	+= " ORDER BY R_E_C_N_O_ DESC "
			
			If(Select(cAlias2) > 0,(cAlias2)->(dbCloseArea()),Nil) 
			DbUseArea(.T.,'TOPCONN',TCGENQRY(,,clQry2),cAlias2  ,.F.,.T.)
			
			If (cAlias2)->(EOF())
				_lRet := .T.
			Else
				If (cAlias2)->P0A_EXPORT == '2'
					_lRet := .T.
					
					clQry3 := " SELECT R_E_C_N_O_ FROM " + RetSqlName("P0A") + " P0A "
					clQry3 += " WHERE P0A_CHAVE LIKE '%"+ ALLTRIM(clFil) +"'||'"+clDoc+"'||'"+clSerie +"'||'"+ ALLTRIM(clForn)+"'||'"+ ALLTRIM(clLoja)+"%' "
					clQry3 += " AND D_E_L_E_T_ = ' ' "
					clQry3 += " ORDER BY R_E_C_N_O_ "
					 
					If(Select(cAlias3) > 0,(cAlias3)->(dbCloseArea()),Nil) 
					DbUseArea(.T.,'TOPCONN',TCGENQRY(,,clQry3),cAlias3  ,.F.,.T.)
					
					DBSelectArea("P0A")
					
					While (cAlias3)->(!EOF())
		                
		                //ESTA EXCLUSAO SER� REALIZADA DENTRO DO PONTO DE ENTRADA A103VLEX
						/*P0A->(DBGoTO((cAlias3)->R_E_C_N_O_))
						//IF RecLock("P0A",.F.)
							//P0A->(DBDelete())	
							//P0A->(MsUnlock())
						//EndIF*/
						aadd(_aRecno,(cAlias3)->R_E_C_N_O_) 
							
						(cAlias3)->(DBSkip())
						
					EndDO
					
				Else
					llCntValid := .T.
				EndIF
			EndIF
			
			IF llCntValid
			
				//VERIFICA SE O DOCUMENTO DE ENTRADA ESTA NO WMS NA TABELA TB_WMSINTERF_DOC_ENTRADA
				clQry1 	:= " SELECT DPCE_COD_CHAVE, STATUS AS S_T_A_T_U_S FROM "+clUsrBD+".TB_WMSINTERF_DOC_ENTRADA 
				clQry1	+= " WHERE DPCE_COD_CHAVE = '"+clChave+"' "  
				
				If(Select(cAlias1) > 0,(cAlias1)->(dbCloseArea()),Nil) 
				DbUseArea(.T.,'TOPCONN',TCGENQRY(,,clQry1),cAlias1  ,.F.,.T.)
				
				If (cAlias1)->(!EOF())
			        
			        If (cAlias1)->S_T_A_T_U_S == 'ER' 
						_lRet := .T.
					Else
						//VERIFICA SE O PEDIDO POSSUI INTEGRA��O DE EXCLUS�O NA TABELA TB_WMSINTERF_CANC_ENT_SAI
						clQry	:= " SELECT CES_COD_CHAVE FROM "+clUsrBD+".TB_WMSINTERF_CANC_ENT_SAI "
						clQry	+= " WHERE CES_COD_CHAVE = '"+clChave+"' "
						clQry	+= " AND STATUS = 'NP' "
						
						If(Select(cAlias) > 0,(cAlias)->(dbCloseArea()),Nil) 
						DbUseArea(.T.,'TOPCONN',TCGENQRY(,,clQry),cAlias  ,.F.,.T.)
						
						If (cAlias)->(!EOF())    
							
							aadd(alCampos1,"STATUS")
						    aadd(alReg1,"P")
						    
							clTabWMS := "TB_WMSINTERF_CANC_ENT_SAI"
							aadd(alCmpChave,"CES_COD_CHAVE")
							
							aadd(alValChave,ALLTRIM((cAlias)->CES_COD_CHAVE))
							
							clQuery := U_EXESQL105(2,alCampos1,alReg1,clTabWMS,alCmpChave,alValChave)
							
							_cQuery := clQuery 
					   		
						Else
							If !ALTERA
								//MSgInfo("O Documento de Entrada n�o pode ser Estornado, pois n�o possui uma integra��o com a tabela TB_WMSINTERF_CANC_ENT_SAI do WMS ","ATEN��O")
								MSgInfo("O Documento de Entrada n�o pode ser Estornado, pois deve ser cancelado primeiramente no WMS ","ATEN��O")
								_lRet := .F.
							EndIF	
						EndIF
					EndIF
				Else
					_lRet := .T.
				EndIF
			EndIF
			
		ElseIf lWmsStore
			If !U_PR109Canc("SF1",clFil+clDoc+clSerie+clForn+clLoja)
				MSgInfo("O Documento de Entrada n�o pode ser Estornado, pois deve ser Estornado primeiramente no Monitor WMS Strore ","ATEN��O")
				_lRet := .F.
			Endif			
		Endif
		
	ElseIf	lWmsStore
		If !U_PR109Canc("SF1",clFil+clDoc+clSerie+clForn+clLoja)
			MSgInfo("O Documento de Entrada n�o pode ser Estornado, pois deve ser Estornado primeiramente no Monitor WMS Strore ","ATEN��O")
			_lRet := .F.
		Endif			
	ElseIf  clFil $ FormatIN(cFiliais,"|")
		
		/********************************************************************************************
		| O Documento de entrada s� pode ser Exclu�do se o mesmo n�o estiver na tabela P0A ou se    | 
		| ainda n�o foi exportado para o WMS, caso j� tenha sido exportado n�o pode estar no sistema|
		| WMS e deve possuir uma integra��o com a tabela TB_WMSINTERF_CANC_ENT_SAI					|
		********************************************************************************************/     
		clQry2 	:= " SELECT P0A_EXPORT, R_E_C_N_O_ FROM " + RetSqlName("P0A") + " P0A "
		clQry2 	+= " WHERE P0A_CHAVE = '"+ clFil +"'||'"+ clDoc+"'||'"+ clSerie +"'||'"+ ALLTRIM(clForn)+"'||'"+ ALLTRIM(clLoja)+"'||'"+clForm+"' "	
		clQry2 	+= " AND D_E_L_E_T_ = ' ' "
		clQry2 	+= " ORDER BY R_E_C_N_O_ DESC "
		
		If(Select(cAlias2) > 0,(cAlias2)->(dbCloseArea()),Nil) 
		DbUseArea(.T.,'TOPCONN',TCGENQRY(,,clQry2),cAlias2  ,.F.,.T.)
		
		If (cAlias2)->(EOF())
			_lRet := .T.
		Else
			If (cAlias2)->P0A_EXPORT == '2'
				_lRet := .T.

				clQry3 := " SELECT R_E_C_N_O_ FROM " + RetSqlName("P0A") + " P0A "
				clQry3 += " WHERE P0A_CHAVE LIKE '%"+ ALLTRIM(clFil) +"'||'"+clDoc+"'||'"+clSerie +"'||'"+ ALLTRIM(clForn)+"'||'"+ ALLTRIM(clLoja)+"%' "
				clQry3 += " AND D_E_L_E_T_ = ' ' "
				clQry3 += " ORDER BY R_E_C_N_O_ " 
				If(Select(cAlias3) > 0,(cAlias3)->(dbCloseArea()),Nil) 
				DbUseArea(.T.,'TOPCONN',TCGENQRY(,,clQry3),cAlias3  ,.F.,.T.)
				
				DBSelectArea("P0A")
				
				While (cAlias3)->(!EOF())
                    //ESTA EXCLUSAO SER� REALIZADA DENTRO DO PONTO DE ENTRADA A103VLEX
					/*P0A->(DBGoTO((cAlias3)->R_E_C_N_O_))
					//IF RecLock("P0A",.F.)
					//	P0A->(DBDelete())	
					 //	P0A->(MsUnlock())
					//EndIF*/
					aadd(_aRecno,(cAlias3)->R_E_C_N_O_) 
	
					(cAlias3)->(DBSkip())
					
				EndDO
				
			Else
				llCntValid := .T.
			EndIF
		EndIF
		
		If llCntValid
		
			/**************************************************************************************
			| S� deve validar a exclus�o se o mesmo foi chamado pela rotina Documento de entrada  |
			**************************************************************************************/ 								
			If  clFil $ FormatIN(cFiliais,"|") .AND. ( IsIncallStack("MATA103") )
				
				/**************************************************************************************************
				| O Documento de Entrada s� pode ser Exclu�do/Estornado se o mesmo n�o estiver no sistema WMS	  |
				| e possuir uma integra��o de exclus�o com a tabela TB_WMSINTERF_CANC_ENT_SAI	  		  |
				**************************************************************************************************/     
				
				//VERIFICA SE O DOCUMENTO DE ENTRADA ESTA NO WMS NA TABELA TB_WMSINTERF_DOC_ENTRADA
				clQry1 	:= " SELECT DPCE_COD_CHAVE, STATUS AS S_T_A_T_U_S FROM "+clUsrBD+".TB_WMSINTERF_DOC_ENTRADA 
				clQry1	+= " WHERE DPCE_COD_CHAVE = '"+clChave+"' "  
				
				If(Select(cAlias1) > 0,(cAlias1)->(dbCloseArea()),Nil) 
				DbUseArea(.T.,'TOPCONN',TCGENQRY(,,clQry1),cAlias1  ,.F.,.T.)
				
				If (cAlias1)->(!EOF())
			        
					If (cAlias1)->S_T_A_T_U_S == 'ER' 
						_lRet := .T.
					Else
					
						//VERIFICA SE O PEDIDO POSSUI INTEGRA��O DE EXCLUS�O NA TABELA TB_WMSINTERF_CANC_ENT_SAI
						clQry	:= " SELECT * FROM "+clUsrBD+".TB_WMSINTERF_CANC_ENT_SAI "
						clQry	+= " WHERE CES_COD_CHAVE = '"+clChave+"' "
						clQry	+= " AND STATUS = 'NP' "
						
						If(Select(cAlias) > 0,(cAlias)->(dbCloseArea()),Nil) 
						DbUseArea(.T.,'TOPCONN',TCGENQRY(,,clQry),cAlias  ,.F.,.T.)
						
						If (cAlias)->(!EOF())    
		
							aadd(alCampos1,"STATUS")
						    aadd(alReg1,"P")
						    
							clTabWMS := "TB_WMSINTERF_CANC_ENT_SAI"
	
							aadd(alCmpChave,"CES_COD_CHAVE")
							aadd(alValChave,ALLTRIM((cAlias)->CES_COD_CHAVE))						
							
							clQuery := U_EXESQL105(2,alCampos1,alReg1,clTabWMS,alCmpChave,alValChave)
							
							_cQuery := clQuery

							/*If !Empty(clQuery)
								If TcSqlExec(clQuery) >= 0
									TcSqlExec("COMMIT")
									_lRet := .T.
								Else
									_lRet := .F.
									Aviso("ERRO",TCSQLError() + " - " + clQuery, {"Ok"})	
								EndIf
					   		EndIf*/
					   		
						Else
							If !ALTERA
								//MSgInfo("O Documento de Entrada n�o pode ser Exclu�do, pois n�o possui uma integra��o com a tabela TB_WMSINTERF_CANC_ENT_SAI do WMS ","ATEN��O")
								MSgInfo("O Documento de Entrada n�o pode ser Estornado, pois deve ser cancelado primeiramente no WMS ","ATEN��O")
								_lRet := .F.
							EndIF	
						EndIF
					EndIF
				Else
					//VERIFICA SE O PEDIDO POSSUI INTEGRA��O DE EXCLUS�O NA TABELA TB_WMSINTERF_CANC_ENT_SAI
					clQry	:= " SELECT * FROM "+clUsrBD+".TB_WMSINTERF_CANC_ENT_SAI "
					clQry	+= " WHERE CES_COD_CHAVE = '"+clChave+"' "
					clQry	+= " AND STATUS = 'NP' "						
					Iif(Select(cAlias) > 0,(cAlias)->(dbCloseArea()),Nil) 
					DbUseArea(.T.,'TOPCONN',TCGENQRY(,,clQry),cAlias  ,.F.,.T.)						
					If (cAlias)->(!EOF())    		
						aadd(alCampos1,"STATUS")
					    aadd(alReg1,"P")						    
						clTabWMS := "TB_WMSINTERF_CANC_ENT_SAI"	
						aadd(alCmpChave,"CES_COD_CHAVE")
						aadd(alValChave,ALLTRIM((cAlias)->CES_COD_CHAVE))						
						
						clQuery := U_EXESQL105(2,alCampos1,alReg1,clTabWMS,alCmpChave,alValChave)			
						_cQuery := clQuery					   		
					EndIf

					//MSgInfo("O Documento de Entrada n�o pode ser Exclu�do, pois encontra-se no sistema WMS. Solicitar ao departamento responsavel para realizar a exclus�o do mesmo.","ATEN��O")
					_lRet := .T.
				EndIF
			EndIF
		EndIF 								
	EndIF
EndIF

RestArea(_aArea)
Return(_lRet)
