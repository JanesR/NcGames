#INCLUDE "rwmake.ch"
#INCLUDE "tbiconn.ch"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ MT120FIM ³ Autor ³ CARLOS N. PUERTA      ³ Data ³ 22/07/12 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Envia e-mail solicitando liberação do pedido de compra     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ NCGAMES                                                    ³±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MT120FIM()
Private _aArea     := GetArea()
Private _aAreaC7   := {}
Private _aAreaAK   := {}
Private _cPedido   := CA120NUM
Private _cUserLib  := Space(06)
Private _cMailLib  := ""
Private _cNome     := "" //UsrRetName(M->C7_USER)
Private _cFornece  := CA120FORN //M->C7_FORNECE
Private _cLoja     := CA120LOJ 	//M->C7_LOJA
Private _cNomeFor  := POSICIONE("SA2",1,XFILIAL("SA2")+CA120FORN+CA120LOJ,"A2_NOME")
Private _nVlrMin   := SUPERGETMV("MV_NCVLRSC")
Private _lBloq     := .F.
Private _nValor    := 0.00
Private _nQuant    := 0.00
Private _cImport   := Space(01)
Private _cTipo     := Space(02)
Private _nOpcao	   := PARAMIXB[3]

IF _nOpcao == 1
	_cImport := Space(01)
	_cTipo   := Space(02)
	dbSelectArea("SC7")
	_aAreaC7 := GetArea()
	dbSetOrder(1)
	dbSeek(xFilial("SC7")+_cPedido,.T.)
	Do While !Eof() .And. _cPedido == SC7->C7_NUM .And. xFilial("SC7") == SC7->C7_FILIAL
		If AllTrim(SC7->C7_RESIDUO) == "S"
			dbSkip()
			Loop
		EndIf
		_cNome   := UsrRetName(SC7->C7_USER)
		_cImport := GETADVFVAL("SB1","B1_IMPORT",XFILIAL("SB1")+SC7->C7_PRODUTO,1,SPACE(01))
		_cTipo   := GETADVFVAL("SB1","B1_TIPO",XFILIAL("SB1")+SC7->C7_PRODUTO,1,SPACE(02))
		If _cImport <> "S" .Or. _cTipo = "MC"
			_nValor += SC7->C7_PRECO * (SC7->C7_QUANT - SC7->C7_QUJE)
			_nQuant += (SC7->C7_QUANT - SC7->C7_QUJE)
		EndIf
		dbSkip()
	EndDo
	RestArea(_aAreaC7)
	
	dbSelectArea("SAK")
	_aAreaAK := GetArea()
	dbSetOrder(2)
	If Empty(SC7->C7_USRAPRO)
		dbGoTop()
		Do While !Eof()
			If SAK->AK_SEQLIBP == "000001"
				_cUserLib := SAK->AK_USER
				_cNomeLib := UsrRetName(_cUserLib)
				_cMailLib := AllTrim(UsrRetMail(_cUserLib))
				Exit
			EndIf
			dbSkip()
		EndDo
	Else
		dbSeek(xFilial("SAK")+SC7->C7_USRAPRO)
		_cSeqLibPC := Soma1(SAK->AK_SEQLIBP,6)
		dbGoTop()
		Do While !Eof()
			If AllTrim(SAK->AK_SEQLIBP) == AllTrim(_cSeqLibPC)
				If _nValor > SAK->AK_LIMMAX
					_cUserLib := SAK->AK_USER
					_cNomeLib := UsrRetName(_cUserLib)
					_cMailLib := AllTrim(UsrRetMail(_cUserLib))
					Exit
				Else
					_cUserLib := Space(06)
				EndIf
			EndIf
			dbSkip()
		EndDo
	EndIf
	RestArea(_aAreaAK)
	
	_cImport := Space(01)
	_cTipo   := Space(02)
	dbSelectArea("SC7")
	_aAreaC7 := GetArea()
	dBSetOrder(1)          // C7_FILIAL+C7_NUM+C7_ITEM
	dbSeek(xFilial("SC7")+_cPedido,.T.)
	Do While !Eof() .And. SC7->C7_NUM == _cPedido
		_cImport := GETADVFVAL("SB1","B1_IMPORT",XFILIAL("SB1")+SC7->C7_PRODUTO,1,SPACE(01))
		_cTipo   := GETADVFVAL("SB1","B1_TIPO",XFILIAL("SB1")+SC7->C7_PRODUTO,1,SPACE(02))
		If !EMPTY(_cUserLib)  .And. (_cImport <> "S" .Or. _cTipo = "MC")
			RecLock("SC7",.F.)
			SC7->C7_STATUS  := "B"
			SC7->C7_USRAPRO := _cUserLib
			SC7->C7_NOMEAPR := _cNomeLib
			MsUnlock()
			_lBloq := .T.
			
			_aArea1 := GetArea()
			dbSelectArea("SZO")
			dbSetOrder(1)
			If dbSeek(xFilial("SZ0")+SC7->C7_NUM)
				RecLock("SZO",.F.)
				SZO->ZO_APROV   := SC7->C7_CONAPRO
				SZO->ZO_USRAPRO := _cUserLib
				SZO->ZO_NOMEAPR := _cNomeLib
				SZO->ZO_QUANTT  := _nQuant
				SZO->ZO_VALORT  := _nValor
			Else
				RecLock("SZO",.T.)
				SZO->ZO_FILIAL  := SC7->C7_FILIAL
				SZO->ZO_NUM     := SC7->C7_NUM
				SZO->ZO_FORNECE := SC7->C7_FORNECE
				SZO->ZO_LOJA    := SC7->C7_LOJA
				SZO->ZO_EMISSAO := SC7->C7_EMISSAO
				SZO->ZO_USRAPRO := _cUserLib
				SZO->ZO_NOMEAPR := _cNomeLib
				SZO->ZO_APROV   := SC7->C7_CONAPRO
				SZO->ZO_QUANTT  := _nQuant
				SZO->ZO_VALORT  := _nValor
			EndIf
			MsUnlock()
			
			dbSelectArea("SZP")
			dbSetOrder(1)
			If dbSeek(xFilial("SZP")+SC7->C7_NUM+SC7->C7_ITEM)
				RecLock("SZP",.F.)
				SZP->ZP_PRODUTO := SC7->C7_PRODUTO
				SZP->ZP_DESCRI  := SC7->C7_DESCRI
				SZP->ZP_UM      := SC7->C7_UM
				SZP->ZP_QUANT   := SC7->C7_QUANT
				SZP->ZP_PRECO   := SC7->C7_PRECO
				SZP->ZP_TOTAL   := SC7->C7_TOTAL
				SZP->ZP_SEGUM   := SC7->C7_SEGUM
				SZP->ZP_QTSEGUM := SC7->C7_QTSEGUM
				SZP->ZP_NUMSC   := SC7->C7_NUMSC
				SZP->ZP_ITEMSC  := SC7->C7_ITEMSC
			Else
				RecLock("SZP",.T.)
				SZP->ZP_FILIAL  := SC7->C7_FILIAL
				SZP->ZP_NUM     := SC7->C7_NUM
				SZP->ZP_ITEM    := SC7->C7_ITEM
				SZP->ZP_PRODUTO := SC7->C7_PRODUTO
				SZP->ZP_DESCRI  := SC7->C7_DESCRI
				SZP->ZP_UM      := SC7->C7_UM
				SZP->ZP_QUANT   := SC7->C7_QUANT
				SZP->ZP_PRECO   := SC7->C7_PRECO
				SZP->ZP_TOTAL   := SC7->C7_TOTAL
				SZP->ZP_SEGUM   := SC7->C7_SEGUM
				SZP->ZP_QTSEGUM := SC7->C7_QTSEGUM
				SZP->ZP_NUMSC   := SC7->C7_NUMSC
				SZP->ZP_ITEMSC  := SC7->C7_ITEMSC
			EndIf
			MsUnlock()
			RestArea(_aArea1)
		Else
			RecLock("SC7",.F.)
			SC7->C7_STATUS  := "L"
			SC7->C7_USRAPRO := Space(06)
			MsUnlock()
			
			_aArea1 := GetArea()
			dbSelectArea("SZO")
			dbSetOrder(1)
			If dbSeek(xFilial("SZO")+_cPedido)
				RecLock("SZO",.F.)
				SZO->ZO_APROV   := "L"
				SZO->ZO_USRAPRO := SC7->C7_USRAPRO
				SZO->ZO_NOMEAPR := SC7->C7_NOMEAPR
			EndIf
			MsUnlock()
			RestArea(_aArea1)
		EndIf
		dbSkip()
	EndDo
	RestArea(_aAreaC7)
	
	If _lBloq
		EmailINCPV()
	EndIf
	
ENDIF

RestArea(_aArea)

Return

////////////////////////////////////////////////////////////////////////////////////
// ****************************************************************************** //
////////////////////////////////////////////////////////////////////////////////////
Static Function EmailINCPV()
// REMOVIDO PARA UTILIZAR A FUNCAO DE ENVIO DO EMAIL PELO WORKFLOW
/*
Local   _cMensagem := "O usuário     : "+_cNome+" incluiu o Pedido de Compra  " + _cPedido +" que necessitara de sua Aprovacao." ;
+ CHR(13)+CHR(10) + CHR(13)+CHR(10) + "PC do Fornec. : "+_cFornece+" - " +_cLoja+" "+_cNomeFor ;
+ CHR(13)+CHR(10) + CHR(13)+CHR(10) + CHR(13)+CHR(10)+ "Valor Total: "+ Transform(_nValor ,"@E 999,999,999.99" );
+ CHR(13)+CHR(10) + CHR(13)+CHR(10) + CHR(13)+CHR(10)+ "Data          : "+ Dtoc(dDataBase) + "        - Horario "+Time()+".";
+ CHR(13)+CHR(10) + CHR(13)+CHR(10) + CHR(13)+CHR(10)+ "____________________________________________________________________________________";
+ CHR(13)+CHR(10) +                                      "Por favor não responda esse e-mail. Mensagem enviada automaticamente."
Local   _aFiles     := {}
Private _cRecebe   := 'cnpuerta@globo.com;soliveira@ncgames.com.br;ebuttner@ncgames.com.br;' + _cMailLib
Private _cCC       := ' '
Private _cBCC      := 'thiago@stch.com.br'
Private _cAssunto  := "Pedido de Compra : "+ _cPedido +" necessita de aprovacao."

U_ENVIAEMAIL(_cRecebe,_cCC,_cBCC,_cAssunto,_cMensagem,_aFiles)
*/
Public _cRecebe   := 'cnpuerta@globo.com;soliveira@ncgames.com.br;ebuttner@ncgames.com.br;'
alert("Workflow enviado para aprovação de Pedido de Compra")
U_SPCIniciar(_cRecebe,"")

Return
