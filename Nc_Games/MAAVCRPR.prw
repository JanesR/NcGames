/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MAAVCRPR  ºAutor  ³Microsiga           º Data ³  11/11/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function MAAVCRPR()

	Local aDados		:= ParamIxb
	Local aAreaAtu	:= GetArea()
	Local cCodigo 	:= ParamIxb[8]
	Local lPedido		:= ParamIxb[5]
	Local lLibCred	:= Empty(cCodigo)
	Local aAreaSA1	:= SA1->(GetArea())
	Local aAreaSC9	:= SC9->(GetArea())
	Local cCondPag	:= Alltrim(U_MyNewSX6("MV_NCRESER","029","C","Condições de pagamento do projeto de venda a vista","","",.F. ))

/*
aDados[01] cCodCli
aDados[02] cLoja
aDados[03] nValor
aDados[04] nMoeda
aDados[05] lPedido
aDados[06] cTipoLim
aDados[07] lRetorno
aDados[08] cCodigo
*/ 

	If lPedido .And. !Empty(cCodigo)

		SA1->(DbSetOrder(1))
		If SA1->(MsSeek(xFilial("SA1")+aDados[1]+aDados[2]  )) .And. SA1->A1_RISCO=="B"
			lLibCred := .F.
			SC9->(MsSeek(xFilial("SC9")+SC5->C5_NUM )  )
			Do While SC9->(!Eof()) .And. SC9->(C9_FILIAL+C9_PEDIDO)==xFilial("SC9")+SC5->C5_NUM
				
				SC9->(RecLock("SC9",.F.))
				SC9->C9_BLCRED:=cCodigo
				SC9->(MsUnLock())
				
				SC9->(DbSkip())
			EndDo
		EndIf
	EndIf

	If lPedido
		If SC5->C5_CONDPAG $ cCondPag .And. SC5->C5_XSTAPED == "15"// Adicionado para bloquear todos os pedidos de venda a vista
			lLibCred:=.F.
			SC9->(MsSeek(xFilial("SC9")+SC5->C5_NUM )  )
			Do While SC9->(!Eof() ) .And. SC9->(C9_FILIAL+C9_PEDIDO)==xFilial("SC9")+SC5->C5_NUM
			
				SC9->(RecLock("SC9",.F.))
				SC9->C9_BLCRED := "01"
				SC9->(MsUnLock())
		
				SC9->(DbSkip())
			EndDo
		EndIf
	EndIf

	RestArea(aAreaSC9)
	RestArea(aAreaSA1)
	RestArea(aAreaAtu)

Return lLibCred
