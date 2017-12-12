#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ MT450ABT  ºAutor  ³KHALIL OMAR SALHA    Data ³  06/09/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function MT450ABT()
Local oDlg:=GetWndDefault()
Local aButtons := {}



AADD(aButtons, {"Analise Credito", {|| u_OBSFN450() } })
AADD(aButtons, {"Alterar Legenda", {|| U_LEGNDALTERA() } })
AADD(aButtons, {"Informações Cliente", {|| U_BrwCred() } })
AADD(aButtons, {"Relatório Análise de Crédito", {|| U_ZRCredi() } })
AADD(aButtons, {"Tit Aberto", {|| Lj010Brow({'SA1'},Recno()) } })
AADD(aButtons, {"Tit Baixados", {|| U_EXIBBAIXDO({'SA1'}, RECNO()) }})

Processa({|| TotPV() })

Return aButtons  //


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MT450ABT  ºAutor  ³Microsiga           º Data ³  08/21/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function TotPV()
Local aRelImp    := MaFisRelImp("MT100",{"SF2","SD2"})
Local cAliasSC6:="SC6"
Local cAliasSC9:="SC9"
Local cAliasSC5:="SC5"
Local aFisGetSC5
Local	aFisGet
Local nContar
Local cFilAtu	:=cFilAnt

ProcRegua( TMP->(RecCount()) )
TMP->(DbGoTop())
SC5->(DbSetOrder(1))
SC6->(DbSetOrder(1))
SC9->(DbSetOrder(1))

MaFisSave()


nTotal:=0

Do While TMP->(!Eof())
	
	IncProc("Pedido de Venda "+TMP->C5_NUM)
	
	
	cFilAnt:=TMP->C5_FILIAL
	
	If !SC5->(DbSeek(xFilial("SC5") +TMP->C5_NUM ))
		TMP->(DbSkip())  ;Loop
	EndIf
	
	
	
	nContar:=0
	FisGetInit(@aFisGet,@aFisGetSC5)
	
	MaFisIni(SC5->C5_CLIENT,;							// 1-Codigo Cliente/Fornecedor
	SC5->C5_LOJACLI,;			// 2-Loja do Cliente/Fornecedor
	Iif(SC5->C5_TIPO$'DB',"F","C"),;	// 3-C:Cliente , F:Fornecedor
	SC5->C5_TIPO,;				// 4-Tipo da NF
	SC5->C5_TIPOCLI,;			// 5-Tipo do Cliente/Fornecedor
	aRelImp,;							// 6-Relacao de Impostos que suportados no arquivo
	,;						   			// 7-Tipo de complemento
	,;									// 8-Permite Incluir Impostos no Rodape .T./.F.
	"SB1",;							// 9-Alias do Cadastro de Produtos - ("SBI" P/ Front Loja)
	"MATA461")							// 10-Nome da rotina que esta utilizando a funcao
	
	
	nFrete	:= (cAliasSC5)->C5_FRETE
	nSeguro	:= (cAliasSC5)->C5_SEGURO
	nFretAut	:= (cAliasSC5)->C5_FRETAUT
	nDespesa	:= (cAliasSC5)->C5_DESPESA
	nDescCab	:= (cAliasSC5)->C5_DESCONT
	nPDesCab	:= (cAliasSC5)->C5_PDESCAB
	
	
	dbSelectArea(cAliasSC5)
	For nY := 1 to Len(aFisGetSC5)
		If !Empty(&(aFisGetSC5[ny][2]))
			If aFisGetSC5[ny][1] == "NF_SUFRAMA"
				MaFisAlt(aFisGetSC5[ny][1],Iif(&(aFisGetSC5[ny][2]) == "1",.T.,.F.),1,.T.)
			Else
				MaFisAlt(aFisGetSC5[ny][1],&(aFisGetSC5[ny][2]),1,.T.)
			Endif
		EndIf
	Next nY
	
	
	
	SC6->(DbSeek(xFilial("SC6") +TMP->C5_NUM ))
	nQtdLib:=0
	
	Do While SC6->(!Eof()) .And. SC6->(C6_FILIAL+C6_NUM)==xFilial("SC6") +TMP->C5_NUM
		
		If SC9->(DbSeek(xFilial("SC9")+SC6->(C6_NUM+C6_ITEM)  )  ) .And. Empty((cAliasSC9)->C9_BLEST)
			cNfOri     := Nil
			cSeriOri   := Nil
			nRecnoSD1  := Nil
			nDesconto  := 0
			
			If !Empty((cAliasSC6)->C6_NFORI)
				dbSelectArea("SD1")
				dbSetOrder(1)
				dbSeek(xFilial("SC6")+(cAliasSC6)->C6_NFORI+(cAliasSC6)->C6_SERIORI+(cAliasSC6)->C6_CLI+(cAliasSC6)->C6_LOJA+(cAliasSC6)->C9_PRODUTO+(cAliasSC6)->C6_ITEMORI)
				cNfOri     := (cAliasSC6)->C6_NFORI
				cSeriOri   := (cAliasSC6)->C6_SERIORI
				nRecnoSD1  := SD1->(RECNO())
			EndIf
			
			dbSelectArea(cAliasSC6)
			
			nValMerc  := (cAliasSC9)->(C9_PRCVEN*C9_QTDLIB)
			
			nPrcLista := (cAliasSC6)->C6_PRUNIT
			
			
			If ( nPrcLista == 0 )
				nPrcLista := NoRound(nValMerc/(cAliasSC9)->C9_QTDLIB,TamSX3("C6_PRCVEN")[2])
			EndIf
			
			
			nPrcVenda	:=(cAliasSC9)->C9_PRCVEN
			nQtdLib		:=(cAliasSC9)->C9_QTDLIB
			cItemPV		:=(cAliasSC9)->C9_ITEM
			
			nAcresFin := A410Arred(nPrcVenda*(cAliasSC5)->C5_ACRSFIN/100,"D2_PRCVEN")
			nValMerc  += A410Arred(nQtdLib*nAcresFin,"D2_TOTAL")
			nDesconto := a410Arred(nPrcLista*nQtdLib,"D2_DESCON")-nValMerc
			nDesconto := IIf(nDesconto==0,(cAliasSC6)->C6_VALDESC,nDesconto)
			nDesconto := Max(0,nDesconto)
			nPrcLista += nAcresFin
			nValMerc  += nDesconto
			
			MaFisAdd((cAliasSC6)->C6_PRODUTO,; 	  // 1-Codigo do Produto ( Obrigatorio )
			(cAliasSC6)->C6_TES,;			  // 2-Codigo do TES ( Opcional )
			nQtdLib,;		  // 3-Quantidade ( Obrigatorio )
			nPrcLista,;		  // 4-Preco Unitario ( Obrigatorio )
			nDesconto,;       // 5-Valor do Desconto ( Opcional )
			cNfOri,;		                  // 6-Numero da NF Original ( Devolucao/Benef )
			cSeriOri,;		                  // 7-Serie da NF Original ( Devolucao/Benef )
			nRecnoSD1,;			          // 8-RecNo da NF Original no arq SD1/SD2
			0,;							  // 9-Valor do Frete do Item ( Opcional )
			0,;							  // 10-Valor da Despesa do item ( Opcional )
			0,;            				  // 11-Valor do Seguro do item ( Opcional )
			0,;							  // 12-Valor do Frete Autonomo ( Opcional )
			nValMerc,;// 13-Valor da Mercadoria ( Obrigatorio )
			0,;							  // 14-Valor da Embalagem ( Opiconal )
			0,;		     				  // 15-RecNo do SB1
			0,; 							  // 16-RecNo do SF4
			0)
			
			nContar++
			
			dbSelectArea(cAliasSC6)
			For nY := 1 to Len(aFisGet)
				If !Empty(&(aFisGet[ny][2]))
					MaFisAlt(aFisGet[ny][1],&(aFisGet[ny][2]),nContar)
				EndIf
			Next nY
			
			
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Calculo do ISS                               ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			SF4->(dbSetOrder(1))
			SF4->(MsSeek(xFilial("SF4")+(cAliasSC6)->C6_TES))
			If ( (cAliasSC5)->C5_INCISS == "N" .And. (cAliasSC5)->C5_TIPO == "N")
				If ( SF4->F4_ISS=="S" )
					nPrcLista := a410Arred(nPrcLista/(1-(MaAliqISS(nContar)/100)),"D2_PRCVEN")
					nValMerc  := a410Arred(nValMerc/(1-(MaAliqISS(nContar)/100)),"D2_PRCVEN")
					MaFisAlt("IT_PRCUNI",nPrcLista,nContar)
					MaFisAlt("IT_VALMERC",nValMerc,nContar)
				EndIf
			EndIf
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Altera peso para calcular frete              ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			SB1->(dbSetOrder(1))
			SB1->(MsSeek(xFilial("SB1")+(cAliasSC6)->C6_PRODUTO))
			MaFisAlt("IT_PESO",nQtdLib*SB1->B1_PESO,nContar)
			MaFisAlt("IT_PRCUNI",nPrcLista,nContar)
			MaFisAlt("IT_VALMERC",nValMerc,nContar)
			
			
			
			
			
			
			
		EndIf
		
		SC6->(DbSkip())
		
		
	EndDo
	For nInd:=1 To nContar
		aRetorno	:= U_NCGPR001( nInd )
		MaFisAlt( "IT_BASESOL", aRetorno[1], nInd )
		MaFisAlt( "IT_VALSOL", aRetorno[2], nInd )	
	Next
	
	nTotal+=MaFisRet(,"NF_TOTAL")
	
	TMP->(DbRLock())                    //Deixar esses campos visiveis
	TMP->C5_VALOR:=MaFisRet(,"NF_TOTAL")
	TMP->(DbRUnLock())
	
	TMP->(DbSkip())
	
EndDo

MaFisRestore()

TMP->(DbGoTop())
cFilAnt:=cFilAtu


Return





User Function EXIBBAIXDO( cAlias,	nRecno, aGet )

Local aParam  := {}     										//Array com as perguntas no SX1
Local aSavRot := {}											//Array com as informacoes para salvar
Local nX      := 0												//Controle de Loop


PRIVATE Inclui := .F.										//Se inclui
PRIVATE Altera := .F.     									//Se altera
PRIVATE nCasas := SuperGetmv("MV_CENT")							//Retorna o parametro MV_CENT

If Pergunte("FIC010",.T.)
	aadd(aParam,MV_PAR01)
	aadd(aParam,MV_PAR02)
	aadd(aParam,MV_PAR03)
	aadd(aParam,MV_PAR04)
	aadd(aParam,MV_PAR05)
	aadd(aParam,MV_PAR06)
	aadd(aParam,MV_PAR07)
	aadd(aParam,MV_PAR08)
	aadd(aParam,MV_PAR09)
	aadd(aParam,MV_PAR10)
	aadd(aParam,MV_PAR11)
	aadd(aParam,MV_PAR12)
	aadd(aParam,MV_PAR13)
	aadd(aParam,MV_PAR14)
	aadd(aParam,MV_PAR15)
	aSavRot := aClone(aRotina)
	aRotina := {}
	For nX := 1 To Len(aSavRot)
		AAdd(aRotina,{"","",0,2})
	Next nX
	Fc010Brow(2,@cAlias,aParam,.T.,aGet)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³	Ao sair da rotina do Financ. fecha o Alias e exclui o arq. temporario gerado  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !Empty(cAlias[2,1])
		(cAlias[2,1])->(dbCloseArea())
		Ferase(cAlias[2,2]+GetDBExtension())
		Ferase(cAlias[2,2]+OrdBagExt())
	EndIf
	aRotina := aClone(aSavRot)
EndIf

Return(Nil)




User Function LEGNDALTERA()        //KHALIL SALHA
Local oDlg_1,oCombo3,oSay4,oSBtn5,oSBtn6
oDlg_1 := MSDIALOG():Create()
oDlg_1:cName := "oDlg_1"
oDlg_1:cCaption := "Legenda"
oDlg_1:nLeft := 0
oDlg_1:nTop := 0
oDlg_1:nWidth := 300
oDlg_1:nHeight := 170
oDlg_1:lShowHint := .F.
oDlg_1:lCentered := .F.

oCombo3 := TCOMBOBOX():Create(oDlg_1)
oCombo3:cName := "oCombo3"
oCombo3:nLeft := 19
oCombo3:nTop := 44
oCombo3:nWidth := 250
oCombo3:nHeight := 21
oCombo3:lShowHint := .F.
oCombo3:lReadOnly := .F.
oCombo3:Align := 0
oCombo3:lVisibleControl := .T.
//oCombo3:aItems := { "A Vista","Titulo Vencido","Serasa","Limite Tomado","Cliente Novo","A Avaliar",""}
oCombo3:aItems := { "A Vista","Titulo Vencido","Serasa","Limite Tomado","Cliente Novo","A Avaliar","Cartao de Credito",""}
oCombo3:nAt := 0

oSay4 := TSAY():Create(oDlg_1)
oSay4:cName := "oSay4"                  // Label
oSay4:cCaption := "Alterar lengenda para:"
oSay4:nLeft := 17
oSay4:nTop := 18
oSay4:nWidth := 197
oSay4:nHeight := 15
oSay4:lShowHint := .F.
oSay4:lReadOnly := .F.
oSay4:Align := 0
oSay4:lVisibleControl := .T.
oSay4:lWordWrap := .F.
oSay4:lTransparent := .F.

oSBtn5 := SBUTTON():Create(oDlg_1)   // Botão OK
oSBtn5:cName := "oSBtn5"
oSBtn5:cCaption := "OK"
oSBtn5:nLeft := 217
oSBtn5:nTop := 76
oSBtn5:nWidth := 51
oSBtn5:nHeight := 22
oSBtn5:lShowHint := .F.
oSBtn5:lReadOnly := .F.
oSBtn5:Align := 0
oSBtn5:lVisibleControl := .T.
oSBtn5:nType := 1
oCombo3:nAt := 1    // Indice do combo
// retorna o valor contido no combobox        //fecha o dialog
oSBtn5:bLClicked := {||  (U_Botao_OK_click(oCombo3:aItems[oCombo3:nAt]), Close(oDlg_1)) }

oSBtn6 := SBUTTON():Create(oDlg_1)   // Botão Cancelar
oSBtn6:cName := "oSBtn6"
oSBtn6:cCaption := "Cancelar"
oSBtn6:nLeft := 161
oSBtn6:nTop := 76
oSBtn6:nWidth := 52
oSBtn6:nHeight := 22
oSBtn6:lShowHint := .F.
oSBtn6:lReadOnly := .F.
oSBtn6:Align := 0
oSBtn6:lVisibleControl := .T.
oSBtn6:nType := 1
oSBtn6:bLClicked := {|| (Close(oDlg_1)) }

oDlg_1:Activate()

Return

User Function Botao_OK_click(Legenda)   // KHALIL SALHA

dbSelectArea("SA1")
dbSetOrder(1)      // A1_FILIAL + A1_COD + A1_LOJA

RECLOCK("SA1",.F.)

SA1->A1_YLEGEND := Legenda
Alert("As informações do cliente " + SA1->A1_NOME + SA1->A1_LOJA + SA1->A1_COD + " foram alteradas para " + Legenda)

MSUNLOCK()
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ OBSFN450  ºAutor  ³Rodrigo Okamoto    º Data ³  06/09/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/


User Function OBSFN450()

Local aArea	:= getarea()
Local cPed	:= TMP->C5_NUM

Private cCliAtu	:= TMP->C5_CLIENTE
Private cLojaAtu	:= TMP->C5_LOJACLI
Private	cObsfin	:= space(354)
Private cTexto	:= ""
Private dData	:= ctod("  /  /  ")

@ 100,001 To 550,800 Dialog oDlg Title "Analise de crédito do cliente: " + SA1->A1_NOME + " " + cCliAtu+"/"+cLojaAtu
@ 003,010 To 375,500
@ 014,014 Say OemToAnsi("Observações Crédito")
@ 034,014 Get cObsfin PICTURE "@e" Size 300,10 valid naovazio()
@ 054,014 Say OemToAnsi("Informações Adicionais Crédito")
@ 074,010 GET cTexto   Size 300,080  MEMO                // Object oMemo
@ 160,014 Say OemToAnsi("Data Limite?")
@ 180,014 Get dData Size 50,10 valid naovazio()

@ 204,130 BMPBUTTON TYPE 01 ACTION ObsFin()
@ 204,160 BmpButton Type 02 Action Close(oDlg)
Activate Dialog oDlg Centered

RestArea(aArea)


Return


/*
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Bloco para execução das observações da analise do crédito³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/

Static Function ObsFin
Local aAreaSC5:= SC5->(getarea())
Local cVend1	:= ""

If empty(dData) .or. dData < ddatabase
	alert("Defina corretamente a data limite para a apresentação dos documentos solicitados!")
	Return
Endif

cTMPPeds	:= ""

Begin Transaction

DbSelectArea("TMP")
DbGotop()
While !eof()
	
	RECLOCK("TMP",.F.)
	TMP->C5_YOBSFIN	:= cObsfin
	TMP->C5_YTEMOBS	:= "1"
	TMP->C5_YDLIMIT	:= dData
	MSUNLOCK()
	cTMPPeds	+= " "+TMP->C5_NUM+","
	
	DbSelectArea("SC5")
	DbSetOrder(1)
	If DbSeek(xFilial("SC5")+TMP->C5_NUM)
		cVend1	:= SC5->C5_VEND1
		//		alert(cObsfin)
		RECLOCK("SC5",.F.)
		SC5->C5_YOBSFIN	:= cObsfin
		SC5->C5_YTEMOBS	:= "1"
		SC5->C5_YDLIMIT	:= dData
		SC5->C5_YFINOBS	:= cTexto
		MSUNLOCK()
		
		//Realiza a gravação na tabela de ocorrências da analise do crédito
		DbSelectArea("SZR")
		SET FILTER TO SZR->ZR_FILIAL+SZR->ZR_PEDIDO == xFilial("SZR")+TMP->C5_NUM
		DbSetOrder(1)
		If DbSeek(xFilial("SZR")+TMP->C5_NUM)
			While !eof() .and. TMP->C5_NUM == SZR->ZR_PEDIDO
				cSequen	:= SZR->ZR_ITEM
				SZR->(DbSkip())
			End
			cSequen := SOMA1(cSequen)
		Else
			cSequen	:= "000001"
		EndIf
		
		RECLOCK("SZR",.T.)
		SZR->ZR_FILIAL	:= xFilial("SZR")
		SZR->ZR_ITEM	:= cSequen
		SZR->ZR_PEDIDO	:= TMP->C5_NUM
		SZR->ZR_TEXTO	:= cObsfin
		SZR->ZR_DTLIMIT	:= dData
		SZR->ZR_DTOCORR	:= dDatabase
		SZR->ZR_HORA	:= Time()
		SZR->ZR_TIPO	:= "1"
		SZR->ZR_INFADIC := cTexto
		SZR->ZR_CLIENTE := TMP->C5_CLIENTE
		SZR->ZR_LOJA	:= TMP->C5_LOJACLI
		SZR->ZR_USER	:= cUsername
		MSUNLOCK()
		SET FILTER TO
		SZR->(DBCLOSEAREA())
		
	EndIf
	
	DbSelectArea("TMP")
	DbSkip()
End

//QUANDO FOR IMPLANTAR EM AMBIENTE OFICIAL, SUBSTITUIR A LINHA DO E-MAIL cTO
cTO	 := getadvfval("SA3","A3_EMAIL",xFilial("SA3")+cVend1,1,"")
//cTO	 := "pcesar@ncgames.com.br;halves@ncgames.com.br"
cCC	 := ""
cBCC	 := ""
cSUBJECT := "[NC GAMES] Analise de Crédito do cliente: "+alltrim(posicione("SA1",1,xFilial("SA1")+cCliAtu+cLojaAtu,"A1_NOME"))+"( "+cCliAtu+"/"+cLojaAtu+" )"
cBODY	:= "Pedidos em análise: "+substr(cTMPPeds,1,len(cTMPPeds)-1)+chr(13)+chr(10)+chr(13)+chr(10)
cBODY	+= "Prezado Vendedor: "+getadvfval("SA3","A3_NOME",xFilial("SA3")+cVend1,1,"")+","+chr(13)+chr(10)+"Os pedidos informados necessitam de informações para a aprovação de crédito:"+chr(13)+chr(10)+chr(13)+chr(10)+chr(13)+chr(10)
cBODY	+= alltrim(cObsfin)+chr(13)+chr(10)+ctexto+chr(13)+chr(10)+chr(13)+chr(10)
cBODY	+= "Data limite para retorno das informações: "+dtoc(dData)+chr(13)+chr(10)+chr(13)+chr(10)
cBODY	+= "Esta notificação também está disponível para visualização no seu pedido de vendas."
aFiles	:= {}

End Transaction

RestArea(aAreaSC5)

Close(oDlg)

u_ENVIAEMAIL(cTO, cCC, cBCC, cSUBJECT, cBODY, aFiles)
alert("E-mail de notificação enviado para: "+cTO)

Return

Static Function NewDlg1()
/*
A tag abaixo define a criação e ativação do novo diálogo. Você pode colocar esta tag
onde quer que deseje em seu código fonte. A linha exata onde esta tag se encontra, definirá
quando o diálogo será exibido ao usuário.
Nota: Todos os objetos definidos no diálogo serão declarados como Local no escopo da
função onde a tag se encontra no código fonte.
*/


Return


Static Function NewDlg2()
/*
A tag abaixo define a criação e ativação do novo diálogo. Você pode colocar esta tag
onde quer que deseje em seu código fonte. A linha exata onde esta tag se encontra, definirá
quando o diálogo será exibido ao usuário.
Nota: Todos os objetos definidos no diálogo serão declarados como Local no escopo da
função onde a tag se encontra no código fonte.
*/

//$BEGINDIALOGDEF_oDlg_1
/*/======================================================
// These information were generated automatically by AP  
// IDE. DO NOT change anything in these information under
// any circumstance. Otherwise, it can mean loss of data 
// or the dialog invalidation by the  TOTVS | Developer Studio
//-------------------------------------------------------
//$DIALOGINFO=312E30,31373335,33363536353232383638,33383932,343739333335333433
//$DIALOGDATA=36B74D534449414C4F47B76F446C675F31B73136B743B7634E616D65B76F446C675F31B743B76343617074696F6EB74C6567656E6461B743B7634D7367B7B743B763546F6F6C546970B7B74EB76E4C656674B730B74EB76E546F70B730B74EB76E5769647468B7333037B74EB76E486569676874B7313734B74CB76C53686F7748696E74B730B74CB76C43656E7465726564B730B745B7625768656EB7B745B76256616C6964B7B745B7624C436C69636B6564B7B745B76252436C69636B6564B7B745B7624C44626C436C69636BB7B745B762496E6974B7B754434F4D424F424F58B76F446C675F31B73231B743B7634E616D65B76F436F6D626F33B743B76343617074696F6EB7B743B7634D7367B7B743B763546F6F6C546970B7B74EB76E4C656674B73130B74EB76E546F70B73338B74EB76E5769647468B7323530B74EB76E486569676874B73231B74CB76C53686F7748696E74B730B74CB76C526561644F6E6C79B730B74EB7416C69676EB730B743B7635661726961626C65B7B74CB76C56697369626C65436F6E74726F6CB731B74FB7614974656D73B730313D41205669737461A630323D546974756C6F2056656E6369646FA630333D536572617361A630343D4C696D69746520546F6D61646FA630353D436C69656E7465204E6F766FA630363D41204176616C696172A6B74EB76E4174B730B745B7625768656EB7B745B76256616C6964B7B745B7624C436C69636B6564B7B745B76252436C69636B6564B7B745B7624C44626C436C69636BB7B745B7624368616E6765B7B754534159B76F446C675F31B73231B743B7634E616D65B76F53617934B743B76343617074696F6EB7416C7465726172206C656E67656E646120706172613AB743B7634D7367B7B743B763546F6F6C546970B7B74EB76E4C656674B73130B74EB76E546F70B738B74EB76E5769647468B7313937B74EB76E486569676874B73135B74CB76C53686F7748696E74B730B74CB76C526561644F6E6C79B730B74EB7416C69676EB730B743B7635661726961626C65B7B74CB76C56697369626C65436F6E74726F6CB731B74CB76C576F726457726170B730B74CB76C5472616E73706172656E74B730B745B7625768656EB7B745B76256616C6964B7B745B7624C436C69636B6564B7B745B76252436C69636B6564B7B745B7624C44626C436C69636BB7B745B7624368616E6765B7B753425554544F4EB76F446C675F31B73231B743B7634E616D65B76F5342746E35B743B76343617074696F6EB74F4BB743B7634D7367B7B743B763546F6F6C546970B7B74EB76E4C656674B7323037B74EB76E546F70B73634B74EB76E5769647468B73531B74EB76E486569676874B73232B74CB76C53686F7748696E74B730B74CB76C526561644F6E6C79B730B74EB7416C69676EB730B743B7635661726961626C65B7B74CB76C56697369626C65436F6E74726F6CB731B74EB76E54797065B731B745B7625768656EB7B745B76256616C6964B7B745B7624C436C69636B6564B7B745B76252436C69636B6564B7B745B7624C44626C436C69636BB7B745B7624368616E6765B7B745B762416374696F6EB7B753425554544F4EB76F446C675F31B73231B743B7634E616D65B76F5342746E36B743B76343617074696F6EB743616E63656C6172B743B7634D7367B7B743B763546F6F6C546970B7B74EB76E4C656674B7313436B74EB76E546F70B73637B74EB76E5769647468B73532B74EB76E486569676874B73232B74CB76C53686F7748696E74B730B74CB76C526561644F6E6C79B730B74EB7416C69676EB730B743B7635661726961626C65B7B74CB76C56697369626C65436F6E74726F6CB731B74EB76E54797065B731B745B7625768656EB7B745B76256616C6964B7B745B7624C436C69636B6564B7436C6F7365286F446C675F3129B745B76252436C69636B6564B7B745B7624C44626C436C69636BB7B745B7624368616E6765B7B745B762416374696F6EB7B754534159B76F446C675F31B73231B743B7634E616D65B76F53617937B743B76343617074696F6EB76F53617937B743B7634D7367B7B743B763546F6F6C546970B7B74EB76E4C656674B73230B74EB76E546F70B7313036B74EB76E5769647468B7353730B74EB76E486569676874B7313532B74CB76C53686F7748696E74B730B74CB76C526561644F6E6C79B730B74EB7416C69676EB730B743B7635661726961626C65B7B74CB76C56697369626C65436F6E74726F6CB731B74CB76C576F726457726170B730B74CB76C5472616E73706172656E74B730B745B7625768656EB7B745B76256616C6964B7B745B7624C436C69636B6564B7B745B76252436C69636B6564B7B745B7624C44626C436C69636BB7B745B7624368616E6765B7B7
//======================================================/*/
//$DIALOGCODE=
4C6F63616C206F446C675F312C6F436F6D626F332C6F536179342C6F5342746E352C6F5342746E362C6F53617937
6F446C675F31203A3D204D534449414C4F4728293A43726561746528290D0A6F446C675F313A634E616D65203A3D20226F446C675F31220D0A6F446C675F313A6343617074696F6E203A3D20224C6567656E6461220D0A6F446C675F313A6E4C656674203A3D20300D0A6F446C675F313A6E546F70203A3D20300D0A6F446C675F313A6E5769647468203A3D203330370D0A6F446C675F313A6E486569676874203A3D203137340D0A6F446C675F313A6C53686F7748696E74203A3D202E462E0D0A6F446C675F313A6C43656E7465726564203A3D202E462E0D0A
6F436F6D626F33203A3D2054434F4D424F424F5828293A437265617465286F446C675F31290D0A6F436F6D626F333A634E616D65203A3D20226F436F6D626F33220D0A6F436F6D626F333A6E4C656674203A3D2031300D0A6F436F6D626F333A6E546F70203A3D2033380D0A6F436F6D626F333A6E5769647468203A3D203235300D0A6F436F6D626F333A6E486569676874203A3D2032310D0A6F436F6D626F333A6C53686F7748696E74203A3D202E462E0D0A6F436F6D626F333A6C526561644F6E6C79203A3D202E462E0D0A6F436F6D626F333A416C69676E203A3D20300D0A6F436F6D626F333A6C56697369626C65436F6E74726F6C203A3D202E542E0D0A6F436F6D626F333A614974656D73203A3D207B202230313D41205669737461222C2230323D546974756C6F2056656E6369646F222C2230333D536572617361222C2230343D4C696D69746520546F6D61646F222C2230353D436C69656E7465204E6F766F222C2230363D41204176616C696172227D0D0A6F436F6D626F333A6E4174203A3D20300D0A
6F53617934203A3D205453415928293A437265617465286F446C675F31290D0A6F536179343A634E616D65203A3D20226F53617934220D0A6F536179343A6343617074696F6E203A3D2022416C7465726172206C656E67656E646120706172613A220D0A6F536179343A6E4C656674203A3D2031300D0A6F536179343A6E546F70203A3D20380D0A6F536179343A6E5769647468203A3D203139370D0A6F536179343A6E486569676874203A3D2031350D0A6F536179343A6C53686F7748696E74203A3D202E462E0D0A6F536179343A6C526561644F6E6C79203A3D202E462E0D0A6F536179343A416C69676E203A3D20300D0A6F536179343A6C56697369626C65436F6E74726F6C203A3D202E542E0D0A6F536179343A6C576F726457726170203A3D202E462E0D0A6F536179343A6C5472616E73706172656E74203A3D202E462E0D0A
6F5342746E35203A3D2053425554544F4E28293A437265617465286F446C675F31290D0A6F5342746E353A634E616D65203A3D20226F5342746E35220D0A6F5342746E353A6343617074696F6E203A3D20224F4B220D0A6F5342746E353A6E4C656674203A3D203230370D0A6F5342746E353A6E546F70203A3D2036340D0A6F5342746E353A6E5769647468203A3D2035310D0A6F5342746E353A6E486569676874203A3D2032320D0A6F5342746E353A6C53686F7748696E74203A3D202E462E0D0A6F5342746E353A6C526561644F6E6C79203A3D202E462E0D0A6F5342746E353A416C69676E203A3D20300D0A6F5342746E353A6C56697369626C65436F6E74726F6C203A3D202E542E0D0A6F5342746E353A6E54797065203A3D20310D0A
6F5342746E36203A3D2053425554544F4E28293A437265617465286F446C675F31290D0A6F5342746E363A634E616D65203A3D20226F5342746E36220D0A6F5342746E363A6343617074696F6E203A3D202243616E63656C6172220D0A6F5342746E363A6E4C656674203A3D203134360D0A6F5342746E363A6E546F70203A3D2036370D0A6F5342746E363A6E5769647468203A3D2035320D0A6F5342746E363A6E486569676874203A3D2032320D0A6F5342746E363A6C53686F7748696E74203A3D202E462E0D0A6F5342746E363A6C526561644F6E6C79203A3D202E462E0D0A6F5342746E363A416C69676E203A3D20300D0A6F5342746E363A6C56697369626C65436F6E74726F6C203A3D202E542E0D0A6F5342746E363A6E54797065203A3D20310D0A6F5342746E363A624C436C69636B6564203A3D207B7C7C20436C6F7365286F446C675F3129207D0D0A
6F53617937203A3D205453415928293A437265617465286F446C675F31290D0A6F536179373A634E616D65203A3D20226F53617937220D0A6F536179373A6343617074696F6E203A3D20226F53617937220D0A6F536179373A6E4C656674203A3D2032300D0A6F536179373A6E546F70203A3D203130360D0A6F536179373A6E5769647468203A3D203537300D0A6F536179373A6E486569676874203A3D203135320D0A6F536179373A6C53686F7748696E74203A3D202E462E0D0A6F536179373A6C526561644F6E6C79203A3D202E462E0D0A6F536179373A416C69676E203A3D20300D0A6F536179373A6C56697369626C65436F6E74726F6C203A3D202E542E0D0A6F536179373A6C576F726457726170203A3D202E462E0D0A6F536179373A6C5472616E73706172656E74203A3D202E462E0D0A
6F446C675F313A41637469766174652829
//$ENDDIALOGDEF_oDlg_1


Static Function FisGetInit(aFisGet,aFisGetSC5)

Local cValid      := ""
Local cReferencia := ""
Local nPosIni     := 0
Local nLen        := 0

If aFisGet == Nil
	aFisGet	:= {}
	dbSelectArea("SX3")
	dbSetOrder(1)
	MsSeek("SC6")
	While !Eof().And.X3_ARQUIVO=="SC6"
		cValid := UPPER(X3_VALID+X3_VLDUSER)
		If 'MAFISGET("'$cValid
			nPosIni 	:= AT('MAFISGET("',cValid)+10
			nLen		:= AT('")',Substr(cValid,nPosIni,Len(cValid)-nPosIni))-1
			cReferencia := Substr(cValid,nPosIni,nLen)
			aAdd(aFisGet,{cReferencia,X3_CAMPO,MaFisOrdem(cReferencia)})
		EndIf
		If 'MAFISREF("'$cValid
			nPosIni		:= AT('MAFISREF("',cValid) + 10
			cReferencia	:=Substr(cValid,nPosIni,AT('","MT410",',cValid)-nPosIni)
			aAdd(aFisGet,{cReferencia,X3_CAMPO,MaFisOrdem(cReferencia)})
		EndIf
		dbSkip()
	EndDo
	aSort(aFisGet,,,{|x,y| x[3]<y[3]})
EndIf

If aFisGetSC5 == Nil
	aFisGetSC5	:= {}
	dbSelectArea("SX3")
	dbSetOrder(1)
	MsSeek("SC5")
	While !Eof().And.X3_ARQUIVO=="SC5"
		cValid := UPPER(X3_VALID+X3_VLDUSER)
		If 'MAFISGET("'$cValid
			nPosIni 	:= AT('MAFISGET("',cValid)+10
			nLen		:= AT('")',Substr(cValid,nPosIni,Len(cValid)-nPosIni))-1
			cReferencia := Substr(cValid,nPosIni,nLen)
			aAdd(aFisGetSC5,{cReferencia,X3_CAMPO,MaFisOrdem(cReferencia)})
		EndIf
		If 'MAFISREF("'$cValid
			nPosIni		:= AT('MAFISREF("',cValid) + 10
			cReferencia	:=Substr(cValid,nPosIni,AT('","MT410",',cValid)-nPosIni)
			aAdd(aFisGetSC5,{cReferencia,X3_CAMPO,MaFisOrdem(cReferencia)})
		EndIf
		dbSkip()
	EndDo
	aSort(aFisGetSC5,,,{|x,y| x[3]<y[3]})
EndIf
MaFisEnd()
Return(.T.)
