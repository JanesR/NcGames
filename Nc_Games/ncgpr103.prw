#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'TopConn.ch'
#define clr Chr(13)+Chr(10)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³DisVPCC6  ºAutor  ³Microsiga           º Data ³  11/21/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funçao chamada pelo P.E MT410TOK, para aplicar o percentual º±±
±±º          ³de desconto do VPC no pedido de venda                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Nc Games                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function DisVPCC6(nOpcX)

Local aVPC		:= {}
Local lPV_EDI  :=	IsInCallStack("U_KZNCG11")//Pedidos de Venda originario do EDI

If nOpcX==4 .And. M->C5_XSTAPED=="00" // Se for alteracao de uma simulacao nao realizar.
	Return
EndIf

If ! (INCLUI .Or. ALTERA)
	Return
EndIf

aVPC := U_PERDESCVPC(M->C5_CLIENTE,M->C5_LOJACLI,DtoS(M->C5_EMISSAO),M->C5_YCODVPC,M->C5_YVERVPC,nOpcX)

If Len(aVPC) > 0
		If !lPV_EDI 
			M->C5_YCODVPC	:= aVPC[1]
			M->C5_YVERVPC	:= aVPC[2]
			//M->C5_DESC2  	:= aVPC[3]
			M->C5_YDVPCPV   :=Posicione("P01",1,xFilial("P01")+M->(C5_YCODVPC+C5_YVERVPC),"P01_DESC")
			Eval ( MemVarBlock("C5_DESC2"),aVPC[3])
		EndIf

  		M->C5_YDESC2  	:=aVPC[3]
Else
	If nOpcX == 4 // Caso seja alteração e ja tenha sido vinculado há um VPC, e na alteração não associe novamente, deverá limpar os dados do VPC
		If !Empty(M->C5_YCODVPC) .and. !Empty(M->C5_YVERVPC)
			M->C5_YCODVPC 	:= ""
			M->C5_YVERVPC	:= ""
			//M->C5_DESC2  	:=0
			Eval ( MemVarBlock("C5_DESC2"),0)
		EndIf
	EndIf
EndIf
U_PR107RatDesc()



Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PERDESCVPCºAutor  ³Hermes Ferreira     º Data ³  08/11/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Função retorna o Percentual de desconto de um VPC cadastradoº±±
±±º          ³para o Cliente ou Grupo de cliente no pedido de venda       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NC Games                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function PERDESCVPC(cCliente,cLoja,cEmissao,_cVPCSC5,_cVerVPCSC5,nOpc)


Local cSql 		:= ""
Local clAlias 	:= GetNextAlias()
Local aRet		:= {}
Local aArea		:= SC5->(GetArea())
Local llUsado	:= .F.

Default cCliente	:= ""
Default cLoja		:= ""
Default cEmissao	:= MsDate()
Default _cVPCSC5	:= ""
Default _cVerVPCSC5	:= ""

//ErrorBlock( { |oErro| U_MySndError(oErro) } )

// Verifica por codigo de cliente

cSql := " SELECT P01_TOTPER,P01_CODIGO, P01_VERSAO "		+ clr
cSql += " FROM "+RetSqlName("P01")+ " P01 "					+ clr
cSql += " WHERE P01.P01_FILIAL = '"+xFilial("P01")+"'"		+ clr
cSql += " AND P01.P01_CODCLI = '"+cCliente+"'"				+ clr
cSql += " AND P01.P01_LOJCLI = CASE WHEN P01.P01_LOJCLI = '  ' THEN  '  '  ELSE '"+cLoja+"' END "+ clr
cSql += " AND P01.P01_DTVINI <= '"+cEmissao+"'"				+ clr
cSql += " AND P01.P01_DTVFIM >= '"+cEmissao+"'"  			+ clr
cSql += " AND P01.P01_TPCAD = '1'"							+ clr // SOMENTE TIPO VPC
cSql += " AND P01.P01_REPASS = '2'"							+ clr // SOMENTE DE PEDIDO DE VENDA
cSql += " AND P01.P01_STATUS = '1'"				 			+ clr // ATIVO
cSql += " AND P01.P01_STSAPR = '1'"				 			+ clr // aprovado


If nOpc == 4
	
	If !Empty(_cVPCSC5) .AND. !Empty(_cVerVPCSC5)
		
		llUsado := .F.
		
	EndIf
	
EndIf

If llUsado  // O Conforme planilha e solicitação o vpc pode ser usado em mais de um pedido de venda
	
	cSql += " AND NOT EXISTS (SELECT C5_YCODVPC "							+ clr
	cSql += " 					FROM "+RetSqlName("SC5")+ " SC5 "			+ clr
	cSql += " 					WHERE SC5.C5_FILIAL = '"+xFilial("SC5")+"'"	+ clr
	cSql += " 					AND SC5.C5_YCODVPC = P01_CODIGO "			+ clr
	cSql += " 					AND SC5.C5_YVERVPC = P01_VERSAO "			+ clr
	cSql += " 					AND SC5.D_E_L_E_T_= ' '"					+ clr
	cSql += " 				) "												+ clr
	
EndIf

cSql += " AND P01.D_E_L_E_T_= ' '"							+ clr

TcQuery cSql New Alias &(clAlias)

(clAlias)->(dbGoTop())

IF (clAlias)->(!Eof()) .AND. (clAlias)->(!Bof())
	
	AADD(aRet,(clAlias)->P01_CODIGO)
	AADD(aRet,(clAlias)->P01_VERSAO)
	AADD(aRet,(clAlias)->P01_TOTPER)
	
	(clAlias)->(dbCloseArea())
	
Else
	
	// Se não achar, procura por Grupo
	(clAlias)->(dbCloseArea())
	
	clAlias 	:= GetNextAlias()
	
	cSql := ""
	cSql := " SELECT P01_TOTPER,P01_CODIGO, P01_VERSAO "	+ clr
	cSql += " FROM "+RetSqlName("P01")+ " P01 "				+ clr
	
	cSql += " JOIN "+RetSqlName("SA1")+" SA1 "		   		+ clr
	cSql += " ON SA1.A1_FILIAL = '"+xFilial("SA1")+"'"		+ clr
	cSql += " AND SA1.A1_COD = '"+cCliente+"'"				+ clr
	cSql += " AND SA1.A1_LOJA = '"+cLoja+"'"				+ clr
	cSql += " AND A1_GRPVEN <> ' ' "						+ clr
	cSql += " AND SA1.D_E_L_E_T_= ' '"						+ clr
	
	cSql += " WHERE P01.P01_FILIAL = '"+xFilial("P01")+"'"	+ clr
	cSql += " AND P01.P01_DTVINI <= '"+cEmissao+"'"			+ clr
	cSql += " AND P01.P01_DTVFIM >= '"+cEmissao+"'"  		+ clr
	cSql += " AND P01.P01_GRPCLI = A1_GRPVEN "				+ clr
	cSql += " AND P01.P01_TPCAD = '1'"						+ clr
	cSql += " AND P01.P01_REPASS = '2'"						+ clr
	cSql += " AND P01.P01_STATUS = '1'"						+ clr
	cSql += " AND P01.P01_STSAPR = '1'"						+ clr
	cSql += " AND P01.D_E_L_E_T_= ' '"						+ clr
	
	If llUsado  // O Conforme planilha e solicitação o vpc pode ser usado em mais de um pedido de venda
		
		cSql += " AND NOT EXISTS (SELECT C5_YCODVPC "							+ clr
		cSql += " 					FROM "+RetSqlName("SC5")+ " SC5 "			+ clr
		cSql += " 					WHERE SC5.C5_FILIAL = '"+xFilial("SC5")+"'"	+ clr
		cSql += " 					AND SC5.C5_YCODVPC = P01_CODIGO "			+ clr
		cSql += " 					AND SC5.C5_YVERVPC = P01_VERSAO "			+ clr
		cSql += " 					AND SC5.D_E_L_E_T_= ' '"					+ clr
		cSql += " 				) "												+ clr
		
	EndIf
	
	TcQuery cSql New Alias &(clAlias)
	(clAlias)->(dbGoTop())
	
	If (clAlias)->(!Eof()) .AND. (clAlias)->(!Bof())
		AADD(aRet,(clAlias)->P01_CODIGO)
		AADD(aRet,(clAlias)->P01_VERSAO)
		AADD(aRet,(clAlias)->P01_TOTPER)
	EndIf
	
	(clAlias)->(dbCloseArea())
	
EndIf

RestArea(aArea)

Return aRet




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GETVPCCT  ºAutor  ³Hermes Ferreira     º Data ³  19/11/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Tela para seleção dos VPC disponiveis para o periodo        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³NC Games                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function GETVPCCT(clAlias,cCliente, cLoja, dDtEmissao,cTpVPC,nValorTIT)

Local oDlg		:= Nil
Local aCampos	:= {}
Local cpNomTmp	:= ""
Local olMark	:= Nil
Local llOk		:= .F.
Local aRet		:= {}
Local _Cliente	:= cCliente
Local _Loja  	:= cLoja
Local _dtRefet	:= dDtEmissao
Local llUsa		:= .T.
Local cNome		:= Alltrim(GetAdvFVal( "SA1", "A1_NOME", xFilial( "SA1" ) + cCliente+cLoja, 1, "" ) )

Default nValorTIT	:= 0

Private cpMarca	:= GetMark()

//ErrorBlock( { |oErro| U_MySndError(oErro) } )

AADD(aCampos,{"TEMP_OK","","",""})
aAdd(aCampos,{ "P01_CODIGO"	,"","Contrato "										,PesqPict("P01","P01_CODIGO")   	})
aAdd(aCampos,{ "P01_DESC"	,"",AllTrim(GetSX3Cache("P01_DESC"	, "X3_TITULO"))	,PesqPict("P01","P01_DESC")  		})
aAdd(aCampos,{ "P01_VERSAO"	,"",AllTrim(GetSX3Cache("P01_VERSAO", "X3_TITULO"))	,PesqPict("P01","P01_VERSAO")   	})
aAdd(aCampos,{ "P01_DTVINI"	,"",AllTrim(GetSX3Cache("P01_DTVINI", "X3_TITULO")),PesqPict("P01","P01_DTVINI")   	})
aAdd(aCampos,{ "P01_DTVFIM"	,"",AllTrim(GetSX3Cache("P01_DTVFIM", "X3_TITULO")),PesqPict("P01","P01_DTVFIM")  		})

If cTpVPC == "1"
	
	aAdd(aCampos,{"P01_TOTPER"	,"","Percentual" 		,"@E 999.99%"/*PesqPict("P01","P01_TOTPER") */	})
	aAdd(aCampos,{"P04_TOTAL1"	,"","Val. APurado" 		,PesqPict("P04","P04_TOTAL1")	})
	aAdd(aCampos,{"P04_FECHAM"	,"","Dt Fechamento"		,"@D"	})
	aAdd(aCampos,{"P04_CODIGO"	,"","Cod Apuração" 		,"@!"	})
	aAdd(aCampos,{"P04_DESC"	,"","Descrição" 		,"@!"	})
	
Else
	
	aAdd(aCampos,{"P01_TOTVAL"	,"","Valor Total" 		,PesqPict("P01","P01_TOTVAL") 	})
	aAdd(aCampos,{"TEMP_VALCO"	,"","Valor Consumido"	,PesqPict("P01","P01_TOTVAL") 	})
	aAdd(aCampos,{"P01_FILPED"	,"",AllTrim(GetSX3Cache("P01_FILPED", "X3_TITULO"))		,PesqPict("P01","P01_FILPED") 	})
	aAdd(aCampos,{"P01_PEDVEN"	,"",AllTrim(GetSX3Cache("P01_PEDVEN", "X3_TITULO"))		,PesqPict("P01","P01_PEDVEN") 	})
	
EndIf

cpNomTmp := CriaTrab(Nil,.F.)
dbSelectArea(clAlias)
Copy To &(cpNomTmp)
dbCloseArea()
dbUseArea(.T., , cpNomTmp, "TEMP", .F., .F.)

Define MsDialog oDlg Title IIF(cTpVPC == "1","VPC","Verba") From (158),(181) To (690),(1200) Pixel Of oDlg

@ 005,004 TO 35,507 LABEL "" OF oDlg PIXEL

oSayCliente	 	:= TSay():New(014,020, {|| "Cliente"}	,oDlg,,,,,, .T.,,)
olGetCliente 	:= TGet():New(012,050,bSETGET(_Cliente),oDlg ,40,10,"",,0,,,.F.,,.T.,,.T.,{|| .F.},.T.,.T.,,.F.,.F.,,_Cliente,,,, )

oSayLoja	 	:= TSay():New(014,105, {|| "Loja"}		,oDlg,,,,,, .T.,,)
olGetLoja 		:= TGet():New(012,120,bSETGET(_Loja),oDlg ,20,10,"",,0,,,.F.,,.T.,,.T.,{|| .F.},.T.,.T.,,.F.,.F.,,_Loja,,,, )

oSayNome	 	:= TSay():New(014,165, {|| "Nome"}		,oDlg,,,,,, .T.,,)
olGetNome 		:= TGet():New(012,185,bSETGET(cNome),oDlg ,200,10,"",,0,,,.F.,,.T.,,.T.,{|| .F.},.T.,.T.,,.F.,.F.,,cNome,,,, )

oSayRefer	 	:= TSay():New(014,400, {|| "Referencia"},oDlg,,,,,, .T.,,)
olGetRefer 		:= TGet():New(012,435,bSETGET(DtoC(_dtRefet)),oDlg ,40,10,"",,0,,,.F.,,.T.,,.T.,{|| .F.},.T.,.T.,,.F.,.F.,,DtoC(_dtRefet),,,, )

dbSelectArea("TEMP")
olMark := MsSelect():New("TEMP", "TEMP_OK" , ,aCampos,,@cpMarca,{040,004,240,507},,,oDlg)
olMark:oBrowse:lhasMark := .T.
olMark:oBrowse:lCanAllmark := .F.
olMark:bMark := {|| FMARCABOX(olMark,cTpVPC)}

ACTIVATE MSDIALOG oDlg CENTERED  ON INIT EnchoiceBar(oDlg, {|| llOk := .T., oDlg:End()},{|| oDlg:End()})

If llOk
	
	TEMP->(dbGoTop())
	
	While TEMP->(!Eof())
		
		If !Empty(TEMP->(TEMP_OK))
			
			If cTpVPC == "2"
				
				If TEMP->TEMP_VALCO > 0
					
					If (TEMP->P01_TOTVAL - TEMP->TEMP_VALCO) < nValorTIT
						Aviso("NCGPR103 - 03","Saldo disponível é inferior ao valor do título e não será relacionado a este título." ,{"Ok"},3)
						llUsa := .F.
					EndIf
					
				EndIf
				
			EndIf
			
			If llUsa
				
				If cTpVPC == "1"
					
					AADD( aRet, {TEMP->P01_CODIGO,TEMP->P01_VERSAO,TEMP->P04_CODIGO, TEMP->P04_TOTAL1})
					
				Else
					
					AADD( aRet, {TEMP->P01_CODIGO,TEMP->P01_VERSAO})
					
				EndIf
				
				Exit
				
			EndIf
		EndIf
		
		TEMP->(dbSkip())
		
	EndDo
	
EndIf

TEMP->(dbCloseArea())

Return aRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FMARCABOX ºAutor  ³Hermes Ferreira     º Data ³  19/11/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Marca o item selecionado na tela                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³NC Games                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FMARCABOX(olMark,cTpVPC)
Local nRecno := 0

//ErrorBlock( { |oErro| U_MySndError(oErro) } )

If cTpVPC == "2"
	If TEMP->TEMP_VALCO == TEMP->P01_TOTVAL
		
		Aviso("NCGPR103 - 02","Essa verba já foi totalmente utilizada e não poderá ser vinculada a esse título." ,{"Ok"},3)
		olMark:obrowse:Refresh()
		RecLock("TEMP", .F.)
		Replace TEMP_OK With Space(2)
		MsUnLock()
		
		Return .F.
		
	EndIf
EndIf

If Marked("TEMP_OK")
	
	nRecno := TEMP->(Recno())
	
	RecLock("TEMP", .F.)
	Replace TEMP_OK With cpMarca
	MsUnLock()
	
	TEMP->(dbGoTop())
	
	While TEMP->(!Eof())
		If TEMP->(Recno()) <> nRecno
			RecLock("TEMP", .F.)
			Replace TEMP_OK With Space(2)
			MsUnLock()
		EndIf
		TEMP->(dbSkip())
	EndDo
	
	TEMP->(dbGoTo(nRecno))
	olMark:obrowse:Refresh()
	
Else
	
	RecLock("TEMP", .F.)
	Replace TEMP_OK With Space(2)
	MsUnLock()
	
EndIf

Return .T.


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³SQLVPCCTS ºAutor  ³Hermes Ferreira     º Data ³  19/11/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Retorna a query com os VPC disponiveis                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³NC Games                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function SQLVPCCTS(clAlias, cCliente, cLoja, dDtEmissao,cTpVPC,lFiltRepas,lveriFin,lSimular)

Local cSql := ""

Local cPrefixoVPC	:= ""
Local cTipoTIT		:= ""
Default lFiltRepas	:= .T.
Default lveriFin	:= .T.
Default lSimular	:=.F.

//ErrorBlock( { |oErro| U_MySndError(oErro) } )

cPrefixoVPC	:= U_MyNewSX6(	"NCG_000016"	 								,;
"VPC"											,;
"C"												,;
"Prefixo para relacionamento do NCC com o VPC."	,;
"Prefixo para relacionamento do NCC com o VPC."	,;
"Prefixo para relacionamento do NCC com o VPC."	,;
.F. )

cTipoTIT	:= Alltrim(U_MyNewSX6(	"NCG_000018"		 					   		,;
"NCC"											,;
"C"												,;
"Tipo de título a considerar para o relacionamento com VPC."	,;
"Tipo de título a considerar para o relacionamento com VPC."	,;
"Tipo de título a considerar para o relacionamento com VPC."	,;
.F. ))


If cTpVPC == "2"
	
	cSql	+= " SELECT * FROM (" +clr
	
EndIf

cSql	+= " SELECT "			+clr
cSql	+= " '  ' AS TEMP_OK "	+clr
cSql	+= " , P01_CODCLI "		+clr
cSql	+= " , P01_LOJCLI "		+clr
cSql	+= " , A1_NOME "		+clr
cSql	+= " , P01_CODIGO "		+clr
cSql	+= " , P01_DESC "		+clr
cSql	+= " , P01_VERSAO "		+clr
cSql	+= " , P01_DTVINI "		+clr
cSql	+= " , P01_DTVFIM "		+clr
cSql	+= " , P01_FILPED "		+clr
cSql	+= " , P01_PEDVEN "		+clr

If cTpVPC == "1"
	If ! lSimular
		cSql	+= " , P01_TOTPER "	+clr
		cSql	+= " , P04_FECHAM "	+clr
		cSql	+= " , P04_CODIGO "	+clr
		cSql	+= " , P04_DESC "	+clr
		cSql	+= " , P04_TOTAL1 "	+clr
	EndIf
	
Else
	cSql	+= " , P01_TOTVAL "	+clr
	
	cSql	+= " , ( SELECT CASE WHEN SUM(E2_VALOR) > P01_TOTVAL THEN P01_TOTVAL ELSE SUM(E2_VALOR) END AS TOT   "+clr
	cSql	+= " 			FROM "+ RetSqlName("SE2")+" SE2 "			+clr
	cSql	+= " 			WHERE SE2.E2_FILIAL = '"+xFilial("SE2")+"'"	+clr
	cSql	+= " 			AND SE2.E2_YVPC = P01_CODIGO "				+clr
	cSql	+= " 			AND SE2.E2_YVERVPC = P01_VERSAO "			+clr
	cSql	+= " 			AND SE2.D_E_L_E_T_ = ' ' "					+clr
	cSql	+= "   ) AS TEMP_VALCO "+clr
EndIf

cSql	+= " FROM "+RetSqlName("P01")+" P01 "  		   		+clr

cSql	+= " JOIN "+RetSqlName("SA1")+" SA1 "		   		+clr
cSql	+= " ON SA1.A1_FILIAL = '"+xFilial("SA1")+"'"  		+clr
cSql	+= " AND SA1.A1_COD = '"+cCliente+"'"		   		+clr
cSql	+= " AND SA1.A1_LOJA = '"+cLoja+"'"			   		+clr
cSql	+= " AND ( ( SA1.A1_COD = P01.P01_CODCLI AND SA1.A1_LOJA = (CASE WHEN P01.P01_LOJCLI = '  ' THEN  '"+cLoja+"'  ELSE P01.P01_LOJCLI END ) )  "	+clr
cSql	+= "		OR (SA1.A1_GRPVEN = P01.P01_GRPCLI)"	+clr
cSql	+= "      )"										+clr
cSql	+= " AND SA1.D_E_L_E_T_ = ' ' "						+clr

If cTpVPC == "1" .And. !lSimular
	
	cSql	+= " JOIN "+RetSqlName("P04")+" P04 "		   		+clr
	cSql	+= " ON P04.P04_FILIAL = '"+xFilial("P04")+"'"  	+clr
	cSql	+= " AND P04.P04_CLIENT = '"+cCliente+"'"		   	+clr
	cSql	+= " AND P04.P04_LOJCLI = '"+cLoja+"'"			   	+clr
	cSql	+= " AND P04.P04_STATUS = '2'"						+clr // Somente apuração encerrada
	cSql	+= " AND P04.P04_CODVPC = P01.P01_CODIGO "		  	+clr
	cSql	+= " AND P04.P04_VERVPC = P01.P01_VERSAO " 		 	+clr
	cSql	+= " AND ( ( P04.P04_CLIENT = P01.P01_CODCLI AND P04.P04_LOJCLI = (CASE WHEN P01.P01_LOJCLI = '  ' THEN  '"+cLoja+"'  ELSE P01.P01_LOJCLI END ) )  "	+clr
	cSql	+= "      )"										+clr
	cSql	+= " AND NOT EXISTS (SELECT E1_YAPURAC "+clr
	cSql	+= " 							FROM "+ RetSqlName("SE1") + " SE1NCC "	+clr
	cSql	+= " 							WHERE SE1NCC.E1_FILIAL = '"+xFilial("SE1")+"'"+clr
	cSql	+= " 							AND SE1NCC.E1_YAPURAC = P04_CODIGO "	+clr
	cSql	+= " 							AND SE1NCC.E1_YVPC= P01_CODIGO "		+clr
	cSql	+= " 							AND SE1NCC.E1_YVERVPC = P01_VERSAO "	+clr
	cSql	+= " 							AND SE1NCC.D_E_L_E_T_= ' '"				+clr
	cSql	+= " 							)"										+clr
	cSql	+= " AND P04.D_E_L_E_T_ = ' ' "						+clr
	
EndIf

cSql	+= " WHERE P01.P01_FILIAL = '"+xFilial("P01")+"'"	+clr
cSql	+= " AND P01.P01_STATUS = '1'"						+clr
cSql	+= " AND P01.P01_STSAPR = '1'"						+clr

If cTpVPC == "1"
	cSql	+= " AND P01.P01_TPCAD = '1'"					+clr
ElseIf cTpVPC == "2"
	cSql	+= " AND P01.P01_TPCAD = '2'"					+clr
EndIf

If lFiltRepas
	cSql 	+= " AND P01.P01_REPASS = '1'"			 		+clr // Somente o que estão cadastrado para o Financeiro
EndIf

If lSimular
	cSql	+= " AND P01.P01_DTVINI <= '"+DtoS(dDtEmissao)+"' "	+clr
	cSql	+= " AND P01.P01_DTVFIM >= '"+DtoS(dDtEmissao)+"' "	+clr
EndIf

If cTpVPC == "1" .AND. lveriFin
	
	cSql	+= " AND NOT EXISTS (SELECT E1_YVPC "								+clr
	cSql	+= " 					FROM "+RetSqlName("SE1")+ " SE1 "			+clr
	cSql	+= " 					WHERE SE1.E1_FILIAL = '"+xFilial("SE1")+"'"	+clr
	cSql	+= " 					AND SE1.E1_YVPC = P01_CODIGO "				+clr
	cSql	+= " 					AND SE1.E1_YVERVPC = P01_VERSAO "			+clr
	cSql	+= " 					AND SE1.E1_TIPO = '"+cTipoTIT+"'"			+clr
	cSql	+= " 					AND SE1.E1_PREFIXO = '"+cPrefixoVPC+"'"		+clr
	cSql	+= "      				AND SE1.E1_CLIENTE='"+cCliente+"'"			+clr
	cSql	+= "    	  			AND SE1.E1_LOJA='"+cLoja+"'"				+clr
	cSql	+= " 					AND SE1.D_E_L_E_T_= ' '"					+clr
	cSql	+= " )"																+clr
	
EndIf

cSql	+= " AND P01.D_E_L_E_T_ = ' '"			   		+clr

If cTpVPC == "2"
	cSql	+= " 	)  TRP	" 							+ clr
	cSql	+= " WHERE CASE WHEN TRP.TEMP_VALCO IS NULL THEN 0 ELSE TRP.TEMP_VALCO END  < P01_TOTVAL "	+ clr
EndIf

TcQuery cSql NEW Alias &clAlias

TCSetField((clAlias),"P01_DTVINI"	,"D",TamSx3("P01_DTVINI")[1],TamSx3("P01_DTVINI")[2]	)
TCSetField((clAlias),"P01_DTVFIM"	,"D",TamSx3("P01_DTVFIM")[1],TamSx3("P01_DTVFIM")[2]	)

If cTpVPC == "1"
	TCSetField((clAlias),"P01_TOTPER"	,"N",TamSx3("P01_TOTPER")[1],TamSx3("P01_TOTPER")[2]	)
	TCSetField((clAlias),"P04_TOTAL1"	,"N",TamSx3("P04_TOTAL1")[1],TamSx3("P04_TOTAL1")[2]	)
	TCSetField((clAlias),"P04_FECHAM"	,"D",TamSx3("P04_FECHAM")[1],TamSx3("P04_FECHAM")[2]	)
Else
	TCSetField((clAlias),"P01_TOTVAL"	,"N",TamSx3("P01_TOTVAL")[1],TamSx3("P01_TOTVAL")[2]	)
	TCSetField((clAlias),"TEMP_VALCO"	,"N",TamSx3("P01_TOTVAL")[1],TamSx3("P01_TOTVAL")[2]	)
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GETALCAVPCºAutor  ³Hermes Ferreira     º Data ³  12/07/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Verifica se existe alçada para a liberação do título       º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NC Games                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function GETALCAVPC(nValor,cTipoAlc,cTpDocAlc,cChaveTIT,nIndiceOrig,cAliasOri,_CodVPC, _VERVPC,cCanal)

Local lRet 		:= .F.
Local clAlias	:= GetNextAlias()
Local aArea		:= &(cAliasOri)->(GetArea())

//ErrorBlock( { |oErro| U_MySndError(oErro) } )

U_QRYALC104(@clAlias,nValor,cTipoAlc,cCanal)

(clAlias)->(dbGoTop())

If (clAlias)->(!Eof()) .and. (clAlias)->(!Bof())
	
	// Gera a Alçada de controle de aprovação
	lRet := U_NCGWF101(clAlias,cTpDocAlc,cChaveTIT,nIndiceOrig,cAliasOri,_CodVPC, _VERVPC)
	
EndIf

(clAlias)->(dbCloseArea())

RestArea(aArea)

Return lRet  