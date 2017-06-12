#Include "Protheus.ch"
#Include "Topconn.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ NCDEPSC0 ºAutor  ³Microsiga           º Data ³  05/04/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Programa para finalizar os registros de reservas canceladasº±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/


User Function NCDEPSC0

Processa({|| PROCDEPSC0() },"Processando Verificação...")

Return

//Processamento //
Static Function PROCDEPSC0

Local aArea	:= GetArea()
Local aAreaSC0	:= SC0->(GetArea())
Local aAreaSC9	:= SC9->(GetArea())
Local lResAtiva	:= .T.
Local lSC9Ativo	:= .T.

SC0->(DbSetOrder(1)) //C0_FILIAL+C0_NUM+C0_PRODUTO+C0_LOCAL
SC9->(DbSetOrder(1)) //C9_FILIAL+C9_PEDIDO+C9_ITEM+C9_SEQUEN+C9_PRODUTO


DbSelectArea("SC6")
SET FILTER TO Alltrim(SC6->C6_PRODUTO) == "01441449086" .AND. SC6->C6_QTDVEN > SC6->C6_QTDENT .AND. SC6->C6_BLQ <> "R" .AND. !Empty(SC6->C6_RESERVA)

SC6->(DbSetOrder(1))
SC6->(DbGoTop())

While SC6->(!Eof())
	lSC9ResAtivo	:= .T.
	incproc()
	lResAtiva	:= VerifSC0(SC6->C6_FILIAL,SC6->C6_NUM,SC6->C6_PRODUTO,SC6->C6_LOCAL)
	If !lResAtiva
		lSC9ResAtivo	:= VerifSC9(SC6->C6_FILIAL,SC6->C6_NUM,SC6->C6_ITEM)
		If !lSC9ResAtivo
			SC6->(Reclock("SC6",.F.))
			SC6->C6_RESERVA	:= criavar("C6_RESERVA")
			SC6->(MsUnlock())
		EndIf
	EndIf
	SC6->(DbSkip())
End

DbSelectArea("SC6")
SET FILTER TO

RestArea(aAreaSC9)
RestArea(aAreaSC0)
RestArea(aArea)

Return



Static Function VerifSC0(cFilSC0,cNumRes,cProd,cLocal)

Local lRet	:= .F.

SC0->(DbSetOrder(1)) //C0_FILIAL+C0_NUM+C0_PRODUTO+C0_LOCAL
If SC0->(DbSeek(cFilSC0+cNumRes+cProd+cLocal))
	lRet	:= .T.
EndIf

Return lRet


Static Function VerifSC9(cFilSC9,cNumPed,cItem)

Local lRet	:= .F.

DbSelectArea("SC9")
SET FILTER TO SC9->C9_PEDIDO == cNumPed .AND. SC9->C9_ITEM == cItem .AND. Empty(SC9->C9_NFISCAL)

SC9->(DbSetOrder(1)) //C9_FILIAL+C9_PEDIDO+C9_ITEM+C9_SEQUEN+C9_PRODUTO
SC9->(DbGoTop())
SC9->(DbSeek(cFilSC9+cNumPed+cItem))
While SC9->(!Eof()) .and. SC9->(C9_FILIAL+C9_PEDIDO+C9_ITEM) == cFilSC9+cNumPed+cItem
	If !EMPTY(SC9->C9_RESERVA)
		If (!Empty(SC9->C9_BLEST) .or. !Empty(SC9->C9_BLCRED))
			SC9->(Reclock("SC9",.F.))
			SC9->C9_RESERVA := ""
			SC9->(MsUnlock())
		Else
			lRet	:= .T.
		EndIf
	EndIf
	SC9->(DbSkip())
End

DbSelectArea("SC9")
SET FILTER TO


Return lRet


/*User Function MT215EXC

Local aArea	:= GetArea()
Local cRet	:= ""

RestArea(aArea)


Return*/