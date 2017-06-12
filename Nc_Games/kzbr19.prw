#INCLUDE "PROTHEUS.CH" 
#Include "TBICONN.CH"  
#INCLUDE "TOPCONN.CH" 
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             					  บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   					  บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 								  บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออนฑฑ
ฑฑบFuncao    ณ KZBR19	     บAutor  ณVinicius Almeida	  บData  ณ 16/05/2012 บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณmBrowse para vizualizacao da copia do pedido				 	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณSigaFat                                                     	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณllManut - Se eh acessado pela tela de manutencao				  บฑฑ
ฑฑบ          ณclNumEDI - Numero do Pedido EDI								  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณNil						   									  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ 
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ 
*/ 
User Function KZBR19(llManut,clNumEDI)

	Local alArea 	:= GetARea() 
	Local llRet		:= .T.
	Local alIndice	:= {}
    Local nlX 		:= 1 
    
	Private cCadastro 	:= "Revisใo de Pedido EDI"
	Private aRotina  	:= {} 
	Private	cpAlias     := "ZAH"
	Private cpIndice	:= ""
	
	Default llManut 	:= .F.
	Default clNumEDI 	:= ""
	
	dbSelectArea("SX2")
		SX2->(dbSetOrder(1))
		SX2->(dbGoTop())
		
		If SX2->(dbSeek(cpAlias))	

			dbSelectArea("SIX")
				SIX->(dbSetOrder(1))
				SIX->(dbGoTop())
				If SIX->(dbSeek(cpAlias))
					alIndice := SEPARA(SIX->CHAVE,"+")
				Else
					ShowHelpDlg(cpAlias, {"Nใo existe ํndice para a tabela " + cpAlias + "."},5,{"Execute o update U_UPDNCG19."},5)
					llRet := .F.
				EndIf
			If llRet	
				dbSelectArea("SX3")
					SX3->(dbSetOrder(2))
					SX3->(dbGoTop())
					For nlX := 1 to Len(alIndice)
						If SX3->(!dbSeek(alIndice[nlX]))
							ShowHelpDlg(cpAlias, {"O campo" + alIndice[nlX] + " nใo existe no Dicionแrio de Dados"},5,{"Execute o update U_UPDNCG19."},5)
							llRet := .F.
							Exit
						Else
							If Empty(cpIndice)
								cpIndice := "M->" + alIndice[nlX]
							Else						 	
								cpIndice += "+M->" + alIndice[nlX]
							EndIf	 	
						EndIf
					Next nlX
					If "FILIAL" $ alIndice[1]
						cpIndice := STRTRAN(cpIndice,"M->"+alIndice[1],"'" + xFilial(cpAlias) + "'")
					EndIf
					
				If llRet	 					
					AADD(aRotina,{"Pesquisar"	,"AxPesqui"		,0,1})
					AADD(aRotina,{"Visualizar"	,"U_KZVisual"	,0,2})			
							
					dbSelectArea(cpAlias)
					dbSetOrder(1)
					If !llManut
						mBrowse(,,,,cpAlias)
					Else
						MBrowse(,,,,cpAlias,,,,,,,,,,,,,,"ZAH_NUMEDI = '" + clNumEDI + "'") 					
					EndIf	
				EndIf 
			EndIf 			
		Else  
			ShowHelpDlg(cpAlias, {"A tabela " + cpAlias + " nใo existe no Dicionแrio de Arquivos"},5,{"Execute o update U_UPDNCG19."},5)	
		EndIf
	RestArea(alArea)
Return  
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             					  บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   					  บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 								  บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออนฑฑ
ฑฑบFuncao    ณ KZVisual	     บAutor  ณVinicius Almeida	  บData  ณ 16/05/2012 บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณMonta as colunas e linhas									 	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณSigaFat                                                     	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณNil															  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณNil						   									  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ 
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ 
*/     
User Function KZVisual()

	Private aHeader		:= {}
	Private aCols		:= {}
	Private aAlterGda	:= {}
	Private oGet		:= Nil
	Private oMsMGet		:= Nil
	
	Private lRet1		:= .F.
	Private lRet2		:= .F.
	
	Private aTela[0][0]
	Private aGets[0] 
	
	KZCRIAHEAD()	
	KZFILTERS()	
	KZPRCACOLS()	
 	KZMNTTELA()
	
Return  
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             					  บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   					  บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 								  บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออนฑฑ
ฑฑบFuncao    ณ KZCRIAHEAD    บAutor  ณVinicius Almeida	  บData  ณ 16/05/2012 บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณMonta o cabecalho											  	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณSigaFat                                                     	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณNil															  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณNil						   									  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ 
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ 
*/
Static Function KZCRIAHEAD()
	
	SX3->(DbSetOrder(1))
	If SX3->(DbSeek("ZAI"))
		While SX3->(!Eof()) .And. SX3->X3_ARQUIVO == "ZAI"
			If cNivel >= SX3->X3_NIVEL .And. !Alltrim(SX3->X3_CAMPO) $ "ZAI_FILIAL|ZAI_NUMEDI|ZAI_REVISA|ZAI_CLIFAT|ZAI_LJFAT"
				
				aAdd(aAlterGda,SX3->X3_CAMPO)
				
				AAdd(aHeader,	{AllTrim(X3Titulo())	,;
								SX3->X3_CAMPO			,;
								SX3->X3_PICTURE			,;
								SX3->X3_TAMANHO			,;
 								SX3->X3_DECIMAL			,;
								SX3->X3_VALID			,;
								SX3->X3_USADO			,;
								SX3->X3_TIPO			,;
								SX3->X3_F3				,;
								SX3->X3_CONTEXT			})
			EndIf
			SX3->(dbSkip())
		EndDo	
	EndIf
	
	//Inclui coluna de recno do registro.
	AAdd(aHeader,	{"Recno","ZAI_XRECNO","",10,0,"","","N","",""})
	
Return()
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             					  บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   					  บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 								  บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออนฑฑ
ฑฑบFuncao    ณ KZFILTERS     บAutor  ณVinicius Almeida	  บData  ณ 16/05/2012 บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณFiltra o carregamento dos itens							  	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณSigaFat                                                     	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณNil															  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณNil						   									  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ 
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ 
*/
Static Function KZFILTERS()
	
	Local cQry:= ""
/*	
	cQry+=" SELECT *,ZAI.R_E_C_N_O_ AS ZAI_XRECNO FROM"+CRLF 
	cQry+=" (SELECT * FROM "+RETSQLNAME("ZAI")+CRLF	
	cQry+=" 	WHERE ZAI_FILIAL = '"+xFilial("ZAI")+"'"+CRLF
	cQry+=" 	AND D_E_L_E_T_ = ' '"+CRLF
	cQry+=" 	AND RTRIM(LTRIM(ZAI_NUMEDI)) = '"+Alltrim(ZAH->ZAH_NUMEDI)+"'"+CRLF 
	cQry+=" 	AND RTRIM(LTRIM(ZAI_CLIFAT)) = '"+Alltrim(ZAH->ZAH_CLIFAT)+"'"+CRLF 
	cQry+=" 	AND RTRIM(LTRIM(ZAI_VERSAO)) = '"+Alltrim(ZAH->ZAH_VERSAO)+"'"+CRLF
	cQry+=" 	AND RTRIM(LTRIM(ZAI_LJFAT)) = '"+Alltrim(ZAH->ZAH_LJFAT)+"') ZAI"+CRLF 	
	cQry+=" LEFT JOIN ("+CRLF
	cQry+=" SELECT B1_COD, B1_DESC FROM "+RETSQLNAME("SB1")+CRLF	
	cQry+=" 	WHERE B1_FILIAL = '"+xFilial("SB1")+"'"+CRLF	
	cQry+=" 	AND D_E_L_E_T_ = ' ')"+CRLF
	cQry+=" 	SB1 ON SB1.B1_COD = ZAI.ZAI_PRODUT"+CRLF
*/
	cQry+="  SELECT "
	cQry+=" 	ZAI.ZAI_FILIAL,ZAI.ZAI_NUMEDI,ZAI.ZAI_REVISA,ZAI.ZAI_VERSAO,"
	cQry+=" 	ZAI.ZAI_CLIFAT,ZAI.ZAI_LJFAT,ZAI.ZAI_ITEM,ZAI.ZAI_EAN,"
	cQry+=" 	ZAI.ZAI_PRODUT,ZAI.ZAI_DESCRI,ZAI.ZAI_LOCAL,ZAI.ZAI_UM,"
	cQry+=" 	ZAI.ZAI_QTD,ZAI.ZAI_UNID2,ZAI.ZAI_QTD2,ZAI.ZAI_PRCUNI,"
	cQry+=" 	ZAI.ZAI_TOTAL,ZAI.ZAI_DTENT,ZAI.ZAI_NCM,ZAI.ZAI_OPER,"
	cQry+=" 	ZAI.ZAI_TES,ZAI.ZAI_CFOP,ZAI.ZAI_CST,ZAI.ZAI_DESC,"
	cQry+=" 	ZAI.ZAI_VLRDES,ZAI.ZAI_PERCIP,ZAI.ZAI_VLRIPI,ZAI.ZAI_VLRDSP,"
	cQry+=" 	ZAI.ZAI_VLRSEG,ZAI.ZAI_VLRFRT,ZAI.ZAI_PERICM,ZAI.ZAI_VLRICM,"
	cQry+=" 	ZAI.R_E_C_N_O_ AS ZAI_XRECNO,SB1.B1_DESC "
	cQry+=" FROM "
	cQry+=" 	("
	cQry+=" 	SELECT"
	cQry+=" 	ZAI_FILIAL,ZAI_NUMEDI,ZAI_REVISA,ZAI_VERSAO,"
	cQry+=" 	ZAI_CLIFAT,ZAI_LJFAT,ZAI_ITEM,ZAI_EAN,ZAI_DESCRI,"
	cQry+=" 	ZAI_PRODUT,ZAI_LOCAL,ZAI_UM,"
	cQry+=" 	ZAI_QTD,ZAI_UNID2,ZAI_QTD2,ZAI_PRCUNI,"
	cQry+=" 	ZAI_TOTAL,ZAI_DTENT,ZAI_NCM,ZAI_OPER,"
	cQry+=" 	ZAI_TES,ZAI_CFOP,ZAI_CST,ZAI_DESC,"
	cQry+=" 	ZAI_VLRDES,ZAI_PERCIP,ZAI_VLRIPI,ZAI_VLRDSP,"
	cQry+=" 	ZAI_VLRSEG,ZAI_VLRFRT,ZAI_PERICM,ZAI_VLRICM, R_E_C_N_O_"
	cQry+=" 	FROM " + RetSQLName("ZAI")
	cQry+="  	WHERE ZAI_FILIAL = '" + xFilial("ZAI") + "'"
	cQry+=" 	AND D_E_L_E_T_ = ' '"+CRLF
	cQry+=" 	AND RTRIM(LTRIM(ZAI_NUMEDI)) = '"+Alltrim(ZAH->ZAH_NUMEDI)+"'"+CRLF 
	cQry+=" 	AND RTRIM(LTRIM(ZAI_CLIFAT)) = '"+Alltrim(ZAH->ZAH_CLIFAT)+"'"+CRLF 
	cQry+=" 	AND RTRIM(LTRIM(ZAI_VERSAO)) = '"+Alltrim(ZAH->ZAH_VERSAO)+"'"+CRLF
	cQry+=" 	AND RTRIM(LTRIM(ZAI_LJFAT)) = '"+Alltrim(ZAH->ZAH_LJFAT)+"') ZAI"+CRLF 	
	//cQry+="  	) ZAI"
	cQry+=" LEFT JOIN (" 
	cQry+=" 	SELECT B1_COD, B1_DESC FROM "+RETSQLNAME("SB1")+CRLF
	cQry+=" 	WHERE B1_FILIAL = '"+xFilial("SB1")+"'"+CRLF
	cQry+=" 	AND D_E_L_E_T_ = ' '"+CRLF
	cQry+=" 	) SB1 ON SB1.B1_COD = ZAI.ZAI_PRODUT"+CRLF
	cQry := ChangeQuery(cQry)                            
	
	If Select("TRB1") > 0
		TRB1->(DbCloseArea())
	EndIf
		
	TcQuery cQry New Alias "TRB1"
	
Return()
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             					  บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   					  บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 								  บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออนฑฑ
ฑฑบFuncao    ณ KZPRCACOLS    บAutor  ณVinicius Almeida	  บData  ณ 16/05/2012 บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณCria o aCols e carrega seu conteudo							  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณSigaFat                                                     	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณNil															  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณNil						   									  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ 
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ 
*/
Static Function KZPRCACOLS()
	
	Local nCont	:= 0
	Local nX	:= 0
	
	Count To nCont
	ProcRegua(nCont)
	TRB1->(DbGoTop())
	While TRB1->(!Eof())
		IncProc("Processando registro "+Alltrim(TRB1->ZAI_PRODUT)+".")	
		
		//Funcao Cria aCols
		KZCRIACOLS()
		
		//Carrega conteudo no aCols
		For nX:= 1 To Len(aHeader)
			If Alltrim(aHeader[nX][2]) == "ZAI_DESCRI"
				If aHeader[nX][10] == "V"  //Virtual
					aCols[Len(aCols)][nX] := TRB1->B1_DESC	
					Loop
				Else // campo REAL
					// Se o campo tiver vazio tenta buscar a descricao do produto da SB1. Senao Pega a Informacao do campo da tabela ZAI
					If Empty(&("TRB1->"+Alltrim(aHeader[nX][2]))) 
						aCols[Len(aCols)][nX] := TRB1->B1_DESC	
						Loop
					EndIf					
				EndIf
			EndIf
			aCols[Len(aCols)][nX] := &("TRB1->"+Alltrim(aHeader[nX][2]))
		Next nX
		
		TRB1->(DbSkip())		
	EndDo
	
Return()
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             					  บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   					  บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 								  บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออนฑฑ
ฑฑบFuncao    ณ KZMNTTELA     บAutor  ณVinicius Almeida	  บData  ณ 16/05/2012 บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณMonta a tela de revisao de pedidos						 	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณSigaFat                                                     	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณNil															  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณNil						   									  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ 
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ 
*/
Static Function KZMNTTELA()
	
	Local aSize	:= {} //MsAdvSize()
	                          
	Local oDlg			:= Nil
	Local oPanel1		:= Nil
	Local oPanel2		:= Nil
	Local oPanel3		:= Nil
	Local oPanel4		:= Nil
	Local oPanel5		:= Nil                    
	Local oSay1			:= Nil
	Local oSay2			:= Nil
	Local cSay1			:= "Serแ desenvolvido"
	Local cSay2			:= "Serแ desenvolvido"
	Local oFont1		:= TFont():New("Arial",08,10,,.T.,,,,,)
	Local oFont2		:= TFont():New("Arial",13,15,,.T.,,,,,)
	Local aButtons		:= {}
	
	Local nFreeze		:= 0
	Local nMax			:= 0
	Local cLinOk		:= "U_KZLINOK()"
	Local cTudoOk		:= ""
	Local cIniCpos		:= ""
	Local cFieldOk		:= "AllwaysTrue()"
	Local cSuperDel		:= "AllwaysTrue()"
	Local cDelOk		:= "AllwaysTrue()"  
	Local lRet1			:= .T.   
	Local lRet2			:= .T. 
	
	Local aXInfo 		:= Array(0) 
	Local aXObjects	    := Array(0) 
	Local aXPosObj		:= Array(0)    

	Local aXPosGet      := Array(0)
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Faz o calculo automatico de dimensoes de objetos     ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	Local aXSize   := MsAdvSize()
	
	AAdd( aXObjects, { 000, 000, .t., .t. } )
	AAdd( aXObjects, { 000, 000, .t., .t. } )

	aXInfo := { aXSize[1], aXSize[2], aXSize[3], aXSize[4], 3, 3 }
	aXPosObj := MsObjSize( aXInfo, aXObjects )

	aXPosGet := MsObjGetPos(aXSize[3]-aXSize[1], 315, {{003,033,160,200,240,263}} )

	
	DEFINE MSDIALOG oDlg TITLE "Revisใo de Pedido EDI" FROM aXSize[7],0 TO aXSize[6],aXSize[5] PIXEL OF oDlg
		
		oDlg:lMaximized := .T.
		
		RegToMemory("ZAH",.F.)
		
/*		
		@ 000, 080 MSPANEL oPanel1 PROMPT "" SIZE 000, 000 OF oDlg CENTERED RAISED  //COLORS RGB(255,255,255),RGB(000,000,045) FONT oFont1
		oPanel1:Align := CONTROL_ALIGN_TOP
		oMsMGet:= MsMget():New("ZAH",0,Iif(lRet1,2,nOpcAux),,,,,{0,0,170,0},,,,.T.,,oDlg,,.T.,,,.F.)
		oMsMGet:oBox:Align := CONTROL_ALIGN_TOP

	    @ 000, 100 MSPANEL oPanel2 PROMPT "" SIZE 000, 000 OF oDlg CENTERED RAISED //COLORS RGB(255,255,255),RGB(000,000,045) FONT oFont1 
	    oPanel2:Align := CONTROL_ALIGN_TOP
	    oGet := MsNewGetDados():New(080,0,280,0,Iif(lRet2,0,GD_UPDATE+GD_DELETE),cLinOk,cTudoOk,cIniCpos,aAlterGda,nFreeze,nMax,cFieldOk,cSuperDel,cDelOk,oDlg,aHeader,aCols)
		oGet:oBrowse:Align := CONTROL_ALIGN_TOP		
*/

		
//		@ 000, 080 MSPANEL oPanel1 PROMPT "" SIZE 000, 000 OF oDlg /*COLORS RGB(255,255,255),RGB(000,000,045) FONT oFont1*/ CENTERED RAISED
//		oPanel1:Align := CONTROL_ALIGN_TOP
		oMsMGet:= MsMget():New("ZAH",0,Iif(lRet1,2,nOpcAux),,,,,aXPosObj[1],,,,.T.,,oDlg,,.T.,,,.F.)
		oMsMGet:oBox:Align := CONTROL_ALIGN_TOP

//	    @ 000, 100 MSPANEL oPanel2 PROMPT "" SIZE 000, 000 OF oDlg /*COLORS RGB(255,255,255),RGB(000,000,045) FONT oFont1 */CENTERED RAISED
//	    oPanel2:Align := CONTROL_ALIGN_TOP
	    oGet := MsNewGetDados():New(  aXPosObj[2,1],aXPosObj[2,2],aXPosObj[2,3],aXPosObj[2,4], Iif(lRet2,0,GD_UPDATE+GD_DELETE),cLinOk,cTudoOk,cIniCpos,aAlterGda,nFreeze,nMax,cFieldOk,cSuperDel,cDelOk,oDlg,aHeader,aCols)
		oGet:oBrowse:Align := CONTROL_ALIGN_TOP		
		                                   
	    
	ACTIVATE MSDIALOG oDlg CENTERED ON INIT EnchoiceBar(oDlg,{||oDlg:End(),oDlg:End()},{|| oDlg:End()},,@aButtons)
		
Return()  

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             					  บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   					  บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 								  บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออนฑฑ
ฑฑบFuncao    ณ KZCRIACOLS    บAutor  ณVinicius Almeida	  บData  ณ 16/05/2012 บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณ Cria o aCols													  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณSigaFat                                                     	  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณNil															  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณNil						   									  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ 
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ 
*/
Static Function KZCRIACOLS()
	
	Local nX	:= 0
	
	Aadd(aCols,Array(Len(aHeader)+1)) 
	aCols[Len(aCols)][Len(aHeader)+1]:= .F. 
	For nX:= 1 To Len(aHeader)-1
		aCols[Len(aCols)][nX]:= CriaVar(aHeader[nX][2],.T.)
	Next nX
		
Return()