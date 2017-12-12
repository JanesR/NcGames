

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GatTabPrc ºAutor  ³Microsiga           º Data ³  11/18/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function GatTabP()

Local cFilSC5	:= xFilial("SC5")
Local cFilSA1	:= xFilial("SA1")
Local cAliasSA1:= SA1->(GetArea())
Local cRet		:= ""
Local cTabEst	:= Alltrim(U_MyNewSX6("NCG_000072","017","C","Tabela de Preço para clientes ES para ES"," "," ",.F. ))

SA1->(DbSetOrder(1))
SA1->(DbSeek(cFilSA1+M->C5_CLIENTE+M->C5_LOJACLI))

If cFilSC5 == "03"
	cRet:= SA1->A1_TABELA
//ElseIf cFilSC5 == "05"
//	cRet:= SA1->A1_YTAB05
//ElseIf cFilSC5 == "06" //removido por Jisidoro 22/08/16
//	If SA1->A1_EST == "ES"
//		cRet:= cTabEst
//	Else
//		cRet:= SA1->A1_TABELA
//	EndIf
ElseIF cFilSC5 == "04"
		cRet:= SA1->A1_TABELA
ElseIf cFilSC5 == "07"
		cRet:= SA1->A1_TABELA
EndIf

Return cRet

IIF(xFilial("SC5")=="03",SA1->A1_TABELA,SA1->A1_YTAB05)                                             
