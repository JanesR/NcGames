#Include "rwmake.ch"
#Include "protheus.ch"


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ SF2460I  ºAutor  ³                    º Data ³  25/04/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Ponto de entrada após a geração da NF de saída para gravar º±±
±±º          ³ informações específicas                                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NCGAMES                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User function SF2460I

Local aArea	:= GetArea()
Local aAreaSD2	:= GetArea()
Local aAreaSE1	:= GetArea()
Local cNumPed	:= Posicione("SD2",3,xFilial("SD2")+SF2->(F2_DOC+F2_SERIE),"D2_PEDIDO")
Local cCondPg	:= Posicione("SC5",1,xFilial("SC5")+cNumPed,"C5_CONDPAG")
Local cFmPgto	:= Posicione("SE4",1,xFilial("SE4")+cCondPg,"E4_FORMA")

If SF2->F2_TIPO == "N" .and. Alltrim(cFmPgto) == "CC"
	DbselectArea("SE1")
	DbSetOrder(1)
	If DbSeek(xFilial("SE1")+SF2->(F2_SERIE+F2_DOC))
		While SE1->(!eof()) .and. alltrim(SE1->(E1_FILIAL+E1_PREFIXO+E1_NUM+E1_TIPO)) == alltrim(xFilial("SE1")+SF2->(F2_SERIE+F2_DOC)+MVNOTAFIS)
			reclock("SE1",.f.)
			SE1->E1_TIPO := cFmPgto
			msunlock()
			SE1->(DbSkip())		
		End
	EndIf
EndIf

RestArea(aAreaSE1)
RestArea(aAreaSD2)                        
RestArea(aArea)                        

Return()

