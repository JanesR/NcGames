#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"


//---------------------------------------------------------------Tela de Recebimento --------------------------------------------

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³	NCProcAut º Autor ³ Elton C.	 º Data ³  04/09/13   	  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Rotina de processamento automatico da Nota Fiscal de 	  º±±
±±º          ³ Entrada, Liberação do Pedido de Venda, Emissao da nota 	  º±±
±±º          ³ de saída de acordo com o pedido de venda e envio da 		  º±±
±±º          ³	nota para SEFAZ											  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function NCGA005()

Local aArea 	:= GetArea()
Local aDadosNf  := {}
Local cPerg:=PADR("NCGA005",Len(SX1->X1_GRUPO))

//Recebe os itens selecionados

PutSX1(cPerg, "01", "Informe o Nr. Romaneio", "", "", "mv_ch1", "C", 06, 2, 0, "G", "", "", "", "", "mv_par01", "", "", "", "", "", "", "", "","", "", "", "", "", "", "","",,,, )

If !Pergunte(cPerg)
	Return
EndIf

aDadosNf := RecebNFE(mv_par01)

Processa( {|| NCProcAut(aDadosNf) }, "Aguarde...", "",.F.)

RestArea(aArea)
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³	NCProcAut  º Autor ³ Elton C. 		 º Data ³  04/09/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³Rotina utilizada para informar o recebimento do documento   º±±
±±º          ³de entrada. Os dados selecionados serão utilizados na 	  º±±
±±º          ³liberação do PV e a geração do documento de saída na filial º±±
±±º          ³origem (Exemplo Curitiba)									  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function NCProcAut(aDadosNf)

Local aArea := GetArea()
Local aNfs		:= {}
Local cMsgErr	:= ""
Local nX		:= 0

Default aDadosNf := {}

//Indicador de processamento
ProcRegua(Len(aDadosNf))


//Verifica se existe itens selecionados
If Len(aDadosNf) > 0
	
	//Processamento automatico dos itens selecionados
	For nX := 1  To Len(aDadosNf)
		
		cMsgErr := ""
		
		IncProc("Processando...     Doc->"+Alltrim(aDadosNf[nX][1][1])+" / Pedido Ori-> "+Alltrim(aDadosNf[nX][2]) )
		
		
		//Verifica se a nota de entrada ja foi gerada
		If Empty(aDadosNf[nX][3])
			//Gera a nota fiscal de entrada
			//                  Doc. de Saida       Serie               Cod. Cliente        //Loja              //Filial da NF
			cMsgErr := DadosNfe(aDadosNf[nX][1][1], aDadosNf[nX][1][2], aDadosNf[nX][1][3], aDadosNf[nX][1][4], aDadosNf[nX][1][5])
			
		Else
			
			//Verifica se a nota de entrada existe na base de dados, para não gerar erro de duplicadade
			DbSelectArea("SF1")
			DbSetOrder(1)
			If !SF1->(DbSeek(xFilial("SF1") + PADR(aDadosNf[nX][1][1],TAMSX3("F1_DOC")[1]) + PADR(aDadosNf[nX][1][2],TAMSX3("F1_SERIE")[1])  ))
				//Gera a nota fiscal de entrada
				//                  Doc. de Saida       Serie               Cod. Cliente        //Loja              //Filial da NF
				cMsgErr := DadosNfe(aDadosNf[nX][1][1], aDadosNf[nX][1][2], aDadosNf[nX][1][3], aDadosNf[nX][1][4], aDadosNf[nX][1][5])
			EndIf
		EndIf
		
		//Verifica se não ocorreu erro, para continuar o processamento automatico
		If Empty(cMsgErr)
			
			//Log de sucesso na geração do documento de entrada
			U_M001PZ1Grv("GRAVA_NOTA_ENTRADA_ORIGEM","",cFilAnt,"",aDadosNf[nX][2],"","",;
			"",aDadosNf[nX][1][1],aDadosNf[nX][1][2],,,"Documento de Entrada gerado com sucesso", .F.)
			
			
			//Efetua a liberação do pedido de venda da filial origem (Exemplo Curitiba)
			LiberaPV(aDadosNf[nX][2])
			
			//Gera nota fiscal de saida de acordo com o numero do pedido
			aNfs := {}
			aNfs := GerNFS(aDadosNf[nX][2])
			
			//Verifica se a nota de saída foi gerada corretamente
			If Len(aNfs) > 0
				
				//Log de SUCESSO na gravação do documento de saida da empresa origem
				U_M001PZ1Grv("GRAVA_NOTA_SAIDA_ORIGEM","",cFilAnt,"",aDadosNf[nX][2],"",aNfs[1][1],;
				aNfs[1][2],"","",,,"Sucesso na inclusão do documento"+;
				" de saída: "+aNfs[1][1]+"/"+aNfs[1][2], .F.)
				
				
				//Envia a nota fiscal para SEFAZ
				EnvNFSefaz(aNfs[1][1], aNfs[1][2])
			Else
				
				//Log de erro na gravação do documento de saida da empresa origem
				U_M001PZ1Grv("GRAVA_NOTA_SAIDA_ORIGEM","",cFilAnt,"",aDadosNf[nX][2],"","",;
				"",aDadosNf[nX][1][1],aDadosNf[nX][1][2],,,"Erro na inclusão do documento"+;
				" de saída. Verifique se existe algum bloqueio no pedido: "+aDadosNf[nX][2], .T.)
				
				
			EndIf
		Else
			//Log de erro na emissão da nota de entrada
			U_M001PZ1Grv("GRAVA_NOTA_ENTRADA_ORIGEM","",cFilAnt,"",aDadosNf[nX][2],"","",;
			"",aDadosNf[nX][1][1],aDadosNf[nX][1][2],,,cMsgErr, .T.)
		EndIf
	Next
EndIf

RestArea(aArea)
Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³	RecebNFE  º Autor ³ Elton C. 		 º Data ³  04/09/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³Rotina utilizada para informar o recebimento do documento   º±±
±±º          ³de entrada. Os dados selecionados serão utilizados na 	  º±±
±±º          ³liberação do PV e a geração do documento de saída na filial º±±
±±º          ³origem (Exemplo Curitiba)									  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function RecebNFE(cRomaneio)
Local olMark	:= Nil
Local clSql		:= ""
Local clAlias	:= GetNextAlias()
Local clAliasB	:= GetNextAlias()
Local clTmp		:= CriaTrab(Nil,.F.)
Local alColuns	:= {}
Local _oDlg		:= Nil
Local llOk		:= .F.
Local clPesq 	:= Space(30)
Local clResult	:= ""
Local aDadosNFE	:= {}
Local aDadosPV	:= {}
Local aDAuxNFE	:= {}
Local aRetDados	:= {}

Private cMarca  := GetMark()  // Essa variável não pode ter outro nome

AADD(alColuns,{"OK"				,,""			,""})
aAdd(alColuns,{"PZ1_ROMAN"	 	,,"Romaneio" 		,""})
aAdd(alColuns,{"PZ1_DOCSF2" 	,,"Nota" 		,""})
aAdd(alColuns,{"PZ1_SERSF2" 	,,"Serie" 		,""})
aAdd(alColuns,{"PZ1_PVORIG" 	,,"Pedido Orig.",""})
aAdd(alColuns,{"PZ1_PVDEST" 	,,"Pedido Dest.",""})
aAdd(alColuns,{"PZ1_FILORI" 	,,"Filial Orig.",""})
aAdd(alColuns,{"PZ1_FILDES" 	,,"Filial Dest.",""})

clSql += " SELECT "+CRLF
clSql += "          '" + cMarca + "' AS OK "+CRLF
clSql += "         ,PZ1_DOCSF2 "+CRLF
clSql += "         ,PZ1_SERSF2 "+CRLF
clSql += "         ,PZ1_PVORIG "+CRLF
clSql += "         ,PZ1_PVDEST "+CRLF
clSql += "         ,PZ1_FILORI "+CRLF
clSql += "         ,PZ1_FILDES "+CRLF
clSql += "         ,PZ1_DOCSF1 "+CRLF
clSql += "         ,PZ1_ROMAN  "+CRLF
clSql += " FROM " + RetSqlName("PZ1") + " PZ1 "+CRLF
clSql += " WHERE PZ1.D_E_L_E_T_ = ' ' "+CRLF
clSql += " AND PZ1.PZ1_FILIAL = '"+xFilial("PZ1")+"' "+CRLF
clSql += " AND PZ1.PZ1_FILORI = '"+cFilAnt+"' "+CRLF
clSql += " AND PZ1.PZ1_DOCSF2 != ' ' "+CRLF
//If !Empty(cRomaneio)
clSql += " AND PZ1.PZ1_ROMAN = '"+cRomaneio+"'"+CRLF
//EndIf
clSql += " AND ( (PZ1.PZ1_DOCSF1 = ' ') OR (PZ1.PZ1_DSF2OR = ' ' ) )"+CRLF
clSql += " ORDER BY PZ1_DOCSF2 "+CRLF

DbUseArea(.T.,"TOPCONN",TCGENQRY(,,clSql),clAliasB, .F., .T.)
DbSelectArea(clAliasB)

Copy To &clTmp

(clAliasB)->(DbCloseArea())

DbUseArea(.T.,,clTmp,clAlias,.T.,.F.)


//Tela para selecionar os documentos de entrada e os pedidos a serem liberados e faturados
DEFINE MSDIALOG _oDlg TITLE "Recebimento" FROM 001,001 TO 600,1200 PIXEL of oMainWnd

@ 15, 07 COMBOBOX oComb VAR clResult ITEMS {"1-N.º do Doc.","2-Pedido Ori."} SIZE 53, 38 OF _oDlg PIXEL
@ 15, 60 MSGET clPesq SIZE	80, 9 OF _oDlg PIXEL
@ 15, 140 BUTTON "Pesquisar" SIZE 030,011 ACTION {|| GetPesq(Iif(Alltrim(SUBSTRING(clResult,1,1)) == "1","PZ1_DOCSF2","PZ1_PVORIG"),clAlias ,clPesq), olMark:OBROWSE:Refresh()} PIXEL OF _oDlg

olMark := MsSelect():New(clAlias,"OK","",alColuns,.T.,@cMarca,{030,006,285,595},,,_oDlg)

olMark:OBROWSE:LCANALLMARK := .T.

olMark:OBROWSE:BALLMARK := {|| MarkTodos(clAlias)}

EnchoiceBar(_oDlg, {||llOk := .T., _oDlg:End() },{|| _oDlg:End() },,)

ACTIVATE MSDIALOG _oDlg CENTERED

If llOk
	
	DbSelectArea(clAlias)
	
	(clAlias)->(DbGotop())
	
	//Preenchimento do array de retorno com os dados dos itens selecionados
	While (clAlias)->(!Eof())
		
		aDAuxNFE	:= {}
		
		If Empty((clAlias)->OK)
			
			//Recebe os dados para gerar a nota fiscal de entrada
			//GetDNFE(cDoc, cSerie, cFilOri)
			aDAuxNFE := GetDNFE((clAlias)->PZ1_DOCSF2, (clAlias)->PZ1_SERSF2, (clAlias)->PZ1_FILDES)
			
			If Len(aDAuxNFE) > 0
				//Preenche os dados a serem utilizados no processamento
				//aDados[1] = Dados da nota fiscal de entrada
				//aDados[2] = Numero do pedido de venda
				//aDados[3] = Documento de saida, caso exista
				Aadd(aRetDados, {aDAuxNFE, (clAlias)->PZ1_PVORIG, (clAlias)->PZ1_DOCSF1} )
				
			EndIf
			
		EndIf
		
		(clAlias)->(DbSkip())
	EndDo
	
EndIf

(clAlias)->(DbCloseArea())
Return aRetDados



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³	GetPesq  º Autor ³ Elton C. 		 º Data ³  04/09/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³Posiciona no item pesquisado							      º±±
±±º			 ³														      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function GetPesq(cCampo, clAlias, cPesq)

Local nRet 	:= 1
Local nCont	:= 0

Default cCampo 	:= ""
Default clAlias	:= ""
Default cPesq	:= ""

(clAlias)->(DbGoTop())
If !Empty(cPesq)
	While (clAlias)->(!EOF())
		
		++nCont
		
		If UPPER(Alltrim(cPesq)) $ UPPER(Alltrim((clAlias)->&cCampo))
			nRet := nCont
			Exit
		EndIf
		
		(clAlias)->(DbSkip())
	EndDo
EndIf

Return nRet



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³	MarkTodos  º Autor ³ Elton C. 		 º Data ³  04/09/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³Marca e desmarca os itens do MSsELECT					      º±±
±±º			 ³														      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function MarkTodos(clAlias)
Local nlRecno 	:= (clAlias)->(Recno())
Local nlCont    := 0

(clAlias)->(DbGoTop())
While (clAlias)->(!Eof())
	nlCont++
	
	If (clAlias)->(RecLock(clAlias,.F.))
		
		If (clAlias)->OK == cMarca
			(clAlias)->OK := Space(2)
		Else
			(clAlias)->OK := cMarca
		EndIf
		(clAlias)->(MsUnlock())
	EndIf
	
	
	(clAlias)->(DbSkip())
EndDo

(clAlias)->(DbGoTo(nlRecno))

Return()




/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³	GetPesq  º Autor ³ Elton C. 		 º Data ³  04/09/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³Posiciona no item pesquisado							      º±±
±±º			 ³														      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function GetDNFE(cDoc, cSerie, cFilOri)

Local aArea 	:= GetArea()
Local cQuery    := ""
Local cArqTmp	:= GetNextAlias()
Local aRet		:= {}

Default cDoc	:= ""
Default cSerie	:= ""
Default cFilOri	:= ""

cQuery    := " SELECT A1_COD, A1_NOME, A1_LOJA, F2_DOC, F2_SERIE, F2_FILIAL FROM "+RetSqlName("SF2")+" SF2 "+CRLF

cQuery    += " INNER JOIN "+RetSqlName("SA1")+" SA1 "+CRLF
cQuery    += " ON SA1.D_E_L_E_T_ = ' ' "+CRLF
cQuery    += " AND SA1.A1_FILIAL = '"+xFilial("SA1")+"' "+CRLF
cQuery    += " AND SA1.A1_COD = SF2.F2_CLIENTE "+CRLF
cQuery    += " AND SA1.A1_LOJA = SF2.F2_LOJA "+CRLF

cQuery    += " WHERE SF2.D_E_L_E_T_ = ' ' " +CRLF
cQuery    += " AND SF2.F2_FILIAL = '"+cFilOri+"' "+CRLF
cQuery    += " AND SF2.F2_DOC = '"+cDoc+"' "+CRLF
cQuery    += " AND SF2.F2_SERIE = '"+cSerie+"' "+CRLF

dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)

(cArqTmp)->(DbGoTop())
While (cArqTmp)->(!Eof())
	
	aRet := {(cArqTmp)->F2_DOC, (cArqTmp)->F2_SERIE, (cArqTmp)->A1_COD,(cArqTmp)->A1_LOJA, (cArqTmp)->F2_FILIAL, (cArqTmp)->A1_NOME}
	
	(cArqTmp)->(DbSkip())
EndDo

If Len(aRet) <= 0
	aRet := {,,,,,}
EndIf

(cArqTmp)->(DbCloseArea())
RestArea(aArea)
Return aRet


//---------------------------------------------Documento de entrada--------------------------------------------------


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³DadosNfe	  º Autor ³ Elton C. 		 º Data ³  04/09/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³Rotina utilizada para gerar os dados da nota de entrada  	  º±±
±±º          ³de acordo com a nota de saida		  						  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function DadosNfe(cDoc, cSerie, cCliente, cLoja, cFilOri)

Local aArea 	:= GetArea()
Local cArqTmp	:= GetNextAlias()
Local cQuery	:= ""
Local aCab		:= {}
Local aItens	:= {}
Local aItenAux	:= {}
Local cRet		:= ""
Local cFornece	:= GetCtParam("NC_FORNMS",;
"000184",;
"C",;
"Fornecedor utilizado no documento de entrada (Midia x Software)",;
"Fornecedor utilizado no documento de entrada (Midia x Software)",;
"Fornecedor utilizado no documento de entrada (Midia x Software)",;
.F. )
Local cLojaForn	:= GetCtParam("NC_LOJAMS",;
"04",;
"C",;
"Loja utilizado no documento de entrada (Midia x Software)",;
"Loja utilizado no documento de entrada (Midia x Software)",;
"Loja utilizado no documento de entrada (Midia x Software)",;
.F. )
Local cUFForn	:= Posicione("SA2",1,xFilial("SA2")+padr(cFornece,tamsx3("A2_COD")[1])+padr(cLojaForn,tamsx3("A2_COD")[1]),"A2_EST")


Default cDoc		:= ""
Default cSerie		:= ""
Default cCliente	:= ""
Default cLoja		:= ""
Default cFilOri		:= ""


cQuery	:=	" SELECT * FROM "+RetSqlName("SF2")+" SF2 "+CRLF

cQuery	+=	" INNER JOIN "+RetSqlName("SD2")+" SD2 "+CRLF
cQuery	+=	" ON SD2.D_E_L_E_T_ = ' ' "+CRLF
cQuery	+=	" AND SD2.D2_FILIAL = SF2.F2_FILIAL "+CRLF
cQuery	+=	" AND SD2.D2_DOC = SF2.F2_DOC "+CRLF
cQuery	+=	" AND SD2.D2_SERIE = SF2.F2_SERIE "+CRLF
cQuery	+=	" AND SD2.D2_CLIENTE = SF2.F2_CLIENTE "+CRLF
cQuery	+=	" AND SD2.D2_LOJA = SF2.F2_LOJA "+CRLF

cQuery	+=	" INNER JOIN "+RetSqlName("SF4")+" SF4 "+CRLF
cQuery	+=	" ON SF4.D_E_L_E_T_ = ' ' "+CRLF
cQuery	+=	" AND SF4.F4_FILIAL = SD2.D2_FILIAL "+CRLF
cQuery	+=	" AND SF4.F4_CODIGO = SD2.D2_TES "+CRLF

cQuery	+=	" WHERE SF2.D_E_L_E_T_ = ' ' "+CRLF
cQuery	+=	" AND SF2.F2_FILIAL = '"+cFilOri+"' "+CRLF
cQuery	+=	" AND SF2.F2_DOC = '"+cDoc+"' "+CRLF
cQuery	+=	" AND SF2.F2_SERIE = '"+cSerie+"' "+CRLF
cQuery	+=	" AND SF2.F2_CLIENTE = '"+cCliente+"' "+CRLF
cQuery	+=	" AND SF2.F2_LOJA = '"+cLoja+"' "+CRLF


cQuery	:=	ChangeQuery(cQuery)

dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)

DbSelectArea("SF4")
DbSetOrder(1)

(cArqTmp)->(DbGoTop())
While (cArqTmp)->(!Eof())
	
	//Preenchimento do cabeçalho da nota fiscal de entrada
	If Len(aCab) <= 0
		Aadd(aCab,{"F1_DOC" 	,	(cArqTmp)->F2_DOC		, Nil})
		Aadd(aCab,{"F1_SERIE" 	,	(cArqTmp)->F2_SERIE		, Nil})
		Aadd(aCab,{"F1_FORNECE" ,	cFornece				, Nil})
		Aadd(aCab,{"F1_LOJA" 	,	cLojaForn				, Nil})
		Aadd(aCab,{"F1_EMISSAO" ,	stod((cArqTmp)->F2_EMISSAO)	, Nil})
		Aadd(aCab,{"F1_TIPO" 	,	"N"						, Nil})
		Aadd(aCab,{"F1_FORMUL" 	,	"N"						, Nil})
		Aadd(aCab,{"F1_ESPECIE" ,	(cArqTmp)->F2_ESPECIE	, Nil})
		Aadd(aCab,{"F1_EST" 	,	cUFForn					, Nil}) /*(cArqTmp)->F2_EST*/
		
		If Alltrim((cArqTmp)->F2_TPFRETE) == "F"//Verifica se o frete de saida e do tipo FOB. Se for então deve ser considerado CIF na entrada
			Aadd(aCab,{"F1_TPFRETE" ,	"C"	, Nil})
			
		ElseIf Alltrim((cArqTmp)->F2_TPFRETE) == "C"//Verifica se o frete de saida e do tipo CIF. Se for então deve ser considerado FOB na entrada
			Aadd(aCab,{"F1_TPFRETE" ,	"F"	, Nil})
			
		Else
			Aadd(aCab,{"F1_TPFRETE" ,	(cArqTmp)->F2_TPFRETE	, Nil})
		EndIf
	EndIf
	aItenAux := {}
	
	//Preenche os dados do item da nota de entrada
	Aadd(aItenAux,{"D1_ITEM" 	,	(cArqTmp)->D2_ITEM			, Nil})
	Aadd(aItenAux,{"D1_COD" 	,	(cArqTmp)->D2_COD			, Nil})
	Aadd(aItenAux,{"D1_UM" 		,	(cArqTmp)->D2_UM			, Nil})
	Aadd(aItenAux,{"D1_SEGUM" 	,	(cArqTmp)->D2_SEGUM			, Nil})
	Aadd(aItenAux,{"D1_QUANT" 	,	(cArqTmp)->D2_QUANT			, Nil})
	Aadd(aItenAux,{"D1_VUNIT" 	,	(cArqTmp)->D2_PRCVEN		, Nil})
	Aadd(aItenAux,{"D1_TOTAL" 	,	(cArqTmp)->D2_TOTAL			, Nil})
	Aadd(aItenAux,{"D1_VALIPI" 	,	(cArqTmp)->D2_VALIPI		, Nil})
	Aadd(aItenAux,{"D1_VALICM" 	,	(cArqTmp)->D2_VALICM		, Nil})
	//	Aadd(aItenAux,{"D1_CONTA" 	,	Padr("1120500001",avsx3("D1_CONTA",3))	, Nil})
	
	//Se este campo não estiver preenchido, o processo não pode ser executado
	If !Empty((cArqTmp)->F4_YTESENT)
		
		If SF4->(DbSeek(xFilial("SF4") + (cArqTmp)->F4_YTESENT))
			Aadd(aItenAux,{"D1_TES" 	,	(cArqTmp)->F4_YTESENT		, Nil})
		Else
			cRet := " TES-> "+(cArqTmp)->F4_YTESENT+" não encontrada na filial-> "+xFilial("SF4")
			Exit
			
			Return cRet
			
		EndIf
	Else
		cRet := "O TES de entrada não foi especificado no cadastro da TES  de saída. " +CRLF
		cRet += " Verifique o preenchimento do campo TES Entrada (F4_YTESENT) no cadastro da TES-> "+Alltrim((cArqTmp)->D2_TES)+", filial "+cFilOri
		Exit
		
		Return cRet
	EndIf
	
	//Aadd(aItenAux,{"D1_CF" 		,	Cod. Fiscal				, Nil})
	//Aadd(aItenAux,{"D1_DESC   " ,	(cArqTmp)->D2_DESCON		, Nil})
	Aadd(aItenAux,{"D1_IPI" 	,	(cArqTmp)->D2_IPI			, Nil})
	Aadd(aItenAux,{"D1_PICM" 	,	(cArqTmp)->D2_PICM			, Nil})
	Aadd(aItenAux,{"D1_PESO" 	,	(cArqTmp)->D2_PESO			, Nil})
	Aadd(aItenAux,{"D1_LOCAL" 	,	(cArqTmp)->D2_LOCAL			, Nil})
	Aadd(aItenAux,{"D1_QTSEGUM" ,	(cArqTmp)->D2_QTSEGUM		, Nil})
	Aadd(aItenAux,{"D1_ICMSRET" ,	(cArqTmp)->D2_ICMSRET		, Nil})
	Aadd(aItenAux,{"D1_BRICMS" 	,	(cArqTmp)->D2_BRICMS		, Nil})
	Aadd(aItenAux,{"D1_DATORI" 	,	(cArqTmp)->D2_EMISSAO		, Nil})
	Aadd(aItenAux,{"D1_BASEICM" ,	(cArqTmp)->D2_BASEICM		, Nil})
	Aadd(aItenAux,{"D1_VALDESC" ,	(cArqTmp)->D2_DESCON		, Nil})
	Aadd(aItenAux,{"D1_BASEIPI" ,	(cArqTmp)->D2_BASEIPI		, Nil})
	Aadd(aItenAux,{"D1_CLASFIS" ,	(cArqTmp)->D2_CLASFIS		, Nil})
	Aadd(aItenAux,{"D1_BASIMP5" ,	(cArqTmp)->D2_BASIMP5		, Nil})
	Aadd(aItenAux,{"D1_BASIMP6" ,	(cArqTmp)->D2_BASIMP6		, Nil})
	Aadd(aItenAux,{"D1_VALIMP5" ,	(cArqTmp)->D2_VALIMP5		, Nil})
	Aadd(aItenAux,{"D1_VALIMP6" ,	(cArqTmp)->D2_VALIMP6		, Nil})
	Aadd(aItenAux,{"D1_ALQIMP5" ,	(cArqTmp)->D2_ALQIMP5		, Nil})
	Aadd(aItenAux,{"D1_ALQIMP6" ,	(cArqTmp)->D2_ALQIMP6		, Nil})
	Aadd(aItenAux,{"D1_VALFRE" 	,	(cArqTmp)->D2_VALFRE		, Nil})
	Aadd(aItenAux,{"D1_ALIQSOL" ,	(cArqTmp)->D2_ALIQSOL		, Nil})
	
	//Adiciona os itens da nota
	Aadd(aItens,aItenAux)
	
	(cArqTmp)->(DbSkip())
EndDo

If (Len(aCab) > 0) .And. (Len(aItens) > 0) .And. Empty(cRet)
	
	//Chama a rotina para gerar a nota de entrada
	cRet := NCGeraNFE(aCab, aItens, 3 )
Else
	cRet := "Nota fiscal de saída -> "+cDoc+"/"+cSerie+" não encontrada"
EndIf

(cArqTmp)->(DbCloseArea())

RestArea(aArea)
Return cRet




/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³NCGeraNFE  º Autor ³ Elton C. 		 º Data ³  04/09/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³Rotina utilizada para gerar a nota fiscal de entrada na 	  º±±
±±º          ³filial destino					  						  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function NCGeraNFE(aCabec, aItens, nOpc )

Local aArea 	:= GetArea()
Local cRet		:= ""
Local cMsgErro	:= ""

Private lMsErroAuto := .F.

Default aCabec 	:= {}
Default aItens  := {}
Default nOpc	:= 3//Inclusão

Begin Transaction
If (Len(aCabec) > 0) .And. (Len(aItens) > 0)
	
	//Chama a rotina automatica para gravar os dados da nota de entrada
	MsExecAuto({|x,y,z| Mata103(x,y,z)},aCabec, aItens, nOpc)
	
	//Verifica se ocorreru algum erro no processamento
	If lMSErroAuto
		
		cMsgErro := AllTrim(MemoRead(NomeAutoLog()))
		MemoWrite(NomeAutoLog()," ")
		
		cRet := cMsgErro
		DisarmTransaction()
		
	EndIf
	
	
Else
	cRet := "Os dados do cabeçalho e itens estão incorretos. "
EndIf

End Transaction

RestArea(aArea)
Return cRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GetCtParamºAutor  ³Elton C.		     º Data ³  03/13/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Retorna o conteudo do parametro e ou cria o parametro       º±±
±±º          ³caso não exista                                             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                              	          º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GetCtParam( cMvPar, xValor, cTipo, cDescP, cDescS, cDescE, lAlter )

Local aAreaAtu	:= GetArea()
Local lRecLock	:= .F.
Local xlReturn

Default lAlter := .F.

If ( ValType( xValor ) == "D" )
	If " $ xValor
		xValor := Dtoc( xValor, "ddmmyy" )
	Else
		xValor	:= Dtos( xValor )
	Endif
ElseIf ( ValType( xValor ) == "N" )
	xValor	:= AllTrim( Str( xValor ) )
ElseIf ( ValType( xValor ) == "L" )
	xValor	:= If ( xValor , ".T.", ".F." )
EndIf

DbSelectArea('SX6')
DbSetOrder(1)
lRecLock := !MsSeek( Space( Len( X6_FIL ) ) + Padr( cMvPar, Len( X6_VAR ) ) )
RecLock( "SX6", lRecLock )
FieldPut( FieldPos( "X6_VAR" ), cMvPar )
FieldPut( FieldPos( "X6_TIPO" ), cTipo )
FieldPut( FieldPos( "X6_PROPRI" ), "U" )
If !Empty( cDescP )
	FieldPut( FieldPos( "X6_DESCRIC" ), SubStr( cDescP, 1, Len( X6_DESCRIC ) ) )
	FieldPut( FieldPos( "X6_DESC1" ), SubStr( cDescP, Len( X6_DESC1 ) + 1, Len( X6_DESC1 ) ) )
	FieldPut( FieldPos( "X6_DESC2" ), SubStr( cDescP, ( Len( X6_DESC2 ) * 2 ) + 1, Len( X6_DESC2 ) ) )
EndIf
If !Empty( cDescS )
	FieldPut( FieldPos( "X6_DSCSPA" ), cDescS )
	FieldPut( FieldPos( "X6_DSCSPA1" ), SubStr( cDescS, Len( X6_DSCSPA1 ) + 1, Len( X6_DSCSPA1 ) ) )
	FieldPut( FieldPos( "X6_DSCSPA2" ), SubStr( cDescS, ( Len( X6_DSCSPA2 ) * 2 ) + 1, Len( X6_DSCSPA2 ) ) )
EndIf
If !Empty( cDescE )
	FieldPut( FieldPos( "X6_DSCENG" ), cDescE )
	FieldPut( FieldPos( "X6_DSCENG1" ), SubStr( cDescE, Len( X6_DSCENG1 ) + 1, Len( X6_DSCENG1 ) ) )
	FieldPut( FieldPos( "X6_DSCENG2" ), SubStr( cDescE, ( Len( X6_DSCENG2 ) * 2 ) + 1, Len( X6_DSCENG2 ) ) )
EndIf
If lRecLock .Or. lAlter
	FieldPut( FieldPos( "X6_CONTEUD" ), xValor )
	FieldPut( FieldPos( "X6_CONTSPA" ), xValor )
	FieldPut( FieldPos( "X6_CONTENG" ), xValor )
EndIf

MsUnlock()

xlReturn := GetNewPar(cMvPar)

RestArea( aAreaAtu )

Return(xlReturn)



//---------------------------------------------Liberação do pedido--------------------------------------------------

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³	LiberaPV  º Autor ³ Elton C. 		 º Data ³  04/09/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³Rotina utilizada para gerar a liberação do pedido de venda  º±±
±±º          ³									  						  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function LiberaPV(cPedido)
Local aArea 	:= GetArea()
Local cQuery	:= ""
Local cArqTmp	:= GetNextAlias()
Local nQtdLib	:= 0

Default cPedido := ""

cQuery := " SELECT R_E_C_N_O_ RECNOSC9 FROM "+RetSqlName("SC9")+" SC9 "+CRLF
cQuery += " WHERE SC9.C9_FILIAL = '"+xFilial("SC9")+"' "+CRLF
cQuery += " AND SC9.D_E_L_E_T_ = ' ' "+CRLF
cQuery += " AND SC9.C9_PEDIDO = '"+cPedido+"' "+CRLF
cQuery += " ORDER BY C9_PRODUTO, C9_ITEM "+CRLF

cQuery	:=	ChangeQuery(cQuery)
dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)
SC6->(DbSetOrder(1))//C6_FILIAL+C6_NUM+C6_ITEM+C6_PRODUTO

Do While (cArqTmp)->(!Eof())
	SC9->(DbGoTo((cArqTmp)->RECNOSC9))	
	SC6->(DbSeek(xFilial("SC6")+SC9->(C9_PEDIDO+C9_ITEM+C9_PRODUTO) )  )
	SC6->(RecLock("SC6",.F.))
	MaAvalSC9("SC9",5,{},,Nil,Nil,Nil,Nil)
	SC6->(MsUnLock())
	(cArqTmp)->(DbSkip())
EndDo

//Fecha a area
(cArqTmp)->(DbCloseArea())

RestArea(aArea)
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³	LiberItPV  º Autor ³ Elton C. 		 º Data ³  04/09/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³Rotina utilizada para gerar a liberação do pedido de venda  º±±
±±º          ³									  						  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function LiberItPV(cPedido, cItem, cProd, nQtdLib)

Local aArea := GetArea()
Local nQtd	:= 0

Default cPedido	:= ""
Default cItem	:= ""
Default cProd	:= ""
Default nQtdLib	:= 0

DbSelectArea("SC6")
DbSetOrder(1)
If SC6->(DbSeek(xFilial("SC6") + PADR(cPedido,TAMSX3("C6_NUM")[1]) + PADR(cItem,TAMSX3("C6_ITEM")[1])  + PADR(cProd,TAMSX3("C6_PRODUTO")[1]) ))
	//     Recno SC6   	 ,qtd a ser lib     ,Lib Est, Lib Cred, Aval est, Aval Cred, Perm. Parcial)
	nQtd := MaLibDoFat(SC6->(Recno()),nQtdLib			,.F.    ,.F.      ,.F.     ,.F.       ,.T.)
	
	//Libera estoque e/ou credito caso esteja bloqueado
	MaLiberOk( { cPedido } )
EndIf

RestArea(aArea)
Return nQtd



//---------------------------------------------Documento de Saida--------------------------------------------------


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³	GerNFS	  º Autor ³ Elton C. 		 º Data ³  04/09/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³Rotina utilizada para gerar a nota de saida de acordo com o º±±
±±º          ³pedido de venda					  						  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function GerNFS(cPedido)

Local aArea   := GetArea()
Local aRet	  := {}
Local aPvlNfs := {}
Local cNota   := ""
Local cSerie  :=  GetCtParam("NC_SERMS",;
"5",;
"C",;
"Serie utilizada no documento de saída (Midia x Software)",;
"Serie utilizada no documento de saída (Midia x Software)",;
"Serie utilizada no documento de saída (Midia x Software)",;
.F. )

Default cPedido := ""

dbSelectArea("SC9")
dbSetOrder(1)
dbSeek(xFilial("SC9")+cPedido)
While !Eof() .And. SC9->(C9_FILIAL+C9_PEDIDO) == xFilial("SC9")+cPedido
	SB1->( dbSetOrder(1) )
	SB1->( MsSeek(xFilial("SB1")+SC9->C9_PRODUTO) )
	
	SC5->( dbSetOrder(1) )
	SC5->( MsSeek(xFilial("SC5")+SC9->C9_PEDIDO) )
	
	SC6->( dbSetOrder(1) )
	SC6->( MsSeek(xFilial("SC6")+SC9->C9_PEDIDO+SC9->C9_ITEM+SC9->C9_PRODUTO) )
	
	SB2->( dbSetOrder(1) )
	SB2->( MsSeek(xFilial("SB2")+SC6->C6_PRODUTO+SC9->C9_LOCAL) )
	
	SF4->( dbSetOrder(1) )
	SF4->( MsSeek(xFilial("SF4")+SC6->C6_TES) )
	
	SE4->( dbSetOrder(1) )
	SE4->( MsSeek(xFilial("SE4")+SC5->C5_CONDPAG) )
	
	// Monta array com os itens do Pedido de Venda
	AAdd(aPvlNfs,{ 	SC9->C9_PEDIDO,;
	SC9->C9_ITEM,;
	SC9->C9_SEQUEN,;
	SC9->C9_QTDLIB,;
	SC9->C9_PRCVEN,;
	SC9->C9_PRODUTO,;
	SF4->F4_ISS=="S",;
	SC9->(RecNo()),;
	SC5->(RecNo()),;
	SC6->(RecNo()),;
	SE4->(RecNo()),;
	SB1->(RecNo()),;
	SB2->(RecNo()),;
	SF4->(RecNo()),;
	SB2->B2_LOCAL,;
	0,;
	SC9->C9_QTDLIB2})
	
	// Avanca para o proximo registro
	SC9->(dbSkip())
End

// Executa funcao para geracao da NF de Saida
If Len(aPvlNfs) > 0
	dbSelectArea("SC9")
	cNota := MaPvlNfs(aPvlNfs,cSerie,.F.,.F.,.F.,.F.,.F.,3,3,.F.,.F.)
	
	If !Empty(cNota)
		Aadd(aRet, {cNota, cSerie})
	EndIf
Else
	aRet := {}
	
	Return aRet
EndIf

RestArea(aArea)
Return aRet


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³	EnvNFSefaz  º Autor ³ Elton C. 		 º Data ³  04/09/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³Rotina utilizada para gerar a nota de saida de acordo com o º±±
±±º          ³pedido de venda					  						  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function EnvNFSefaz(cNota, cSerie)

Local aArea := GetArea()
Local cAmbSefaz	:= "2"

Default cNota	:= ""
Default cSerie	:= ""

If !Empty(cNota)
	//Parametros AutoNfeEnv :
	//cEmpresa,
	//cFilial,
	//cEspera,
	//cAmbiente (1=producao,2=Homologacao) Muito cuidado.
	//cSerie
	//cDoc.Inicial
	//cDoc.Final
	
	//Recebe o ambiente a qual a nota fiscal será transmitida
	cAmbSefaz     := GetAmbSefaz()
	
	//Transmite a NF automaticamente para SEFAZ
	AutoNfeEnv(cEmpAnt,cFilAnt,"60",cAmbSefaz,cSerie,cNota,cNota)
EndIf


RestArea(aArea)
Return


/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³GetAmbSefaz  ³ Autor ³ELTON SANTANA	    ³ Data ³ 11/10/11 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Retorna o ambiente da transmissão da nota fiscal para 	  ³±±
±±³			 ³ SEFAZ (1=Produção e 2=Homologação).			  			  ³±±
±±³			 ³ Esses dados são verificados na tabela do SPED000 e SPED0001³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function GetAmbSefaz()

Local aArea 	:= GetArea()
Local cQuery	:= ""
Local cArqTmp	:= GetNextAlias()
Local cRet		:= ""


cQuery	:= " SELECT S_01.ID_ENT, PARAMETRO, CONTEUDO FROM SPED.SPED001 S_01 "+CRLF

cQuery	+= " INNER JOIN SPED.SPED000 S_02 "+CRLF
cQuery	+= " ON S_02.D_E_L_E_T_ = ' ' "+CRLF
cQuery	+= " AND S_02.ID_ENT = S_01.ID_ENT "+CRLF
cQuery	+= " AND PARAMETRO = 'MV_AMBIENT' "+CRLF

cQuery	+= " WHERE S_01.D_E_L_E_T_ = ' ' "+CRLF
cQuery	+= " AND S_01.CNPJ = '"+SM0->M0_CGC+"' "+CRLF
cQuery	+= " AND S_01.IE = '"+SM0->M0_INSC+"' "+CRLF

dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)

(cArqTmp)->(DbGoTop())
If (cArqTmp)->(!eof())
	cRet := Alltrim((cArqTmp)->CONTEUDO)
Else
	cRet := "2"
EndIf

(cArqTmp)->(DbCloseArea())

RestArea(aArea)
Return cRet