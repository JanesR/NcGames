
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MTC050FI  ºAutor  ³Microsiga           º Data ³  04/16/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ PE para que sejam selecionados os campos para consulta do  º±±
±±º          ³ produto. Desenvolvido para solução do problema de número deº±±
±±º          ³ componentes por janela									  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function MTC050FI

Local cAlias	:= PARAMIXB[1]
Local aRet		:= PARAMIXB[2]
Local aArea		:= GetArea()
Local aAreaSX3	:= SX3->(GetArea())
Local nLenaRet	:= len(aRet)

dbSelectArea("SX3")
SX3->(DbSetOrder(1))

If cAlias == "SB1"
	
	If SX3->(dbSeek(cAlias))
		While SX3->(!Eof()) .AND. SX3->X3_ARQUIVO == cAlias
			nPos := aScan(aRet,Alltrim(SX3->X3_CAMPO))
			If nPos > 0 .and.!( SX3->X3_FOLDER == "1")
				aDel(aRet,nPos)
				nLenaRet:= nLenaRet-1
			EndIf
			SX3->(dbSkip())
		EndDo
	EndIf
	aSize(aRet,nLenaRet)
	
EndIf

RestArea(aAreaSX3)
RestArea(aArea)

Return aRet
