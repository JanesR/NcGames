#INCLUDE "TOPCONN.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGWF101  ºAutor  ³Hermes Ferreira     º Data ³  10/12/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Gera alçada de controle de aprovação de VERBA e de VPC ao   º±±
±±º          ³relacionar a um tú‘ulo NCC ou a pagar                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Nc Games                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function NCGWF101(clAlias,cTpDocAlc,cChaveInd,nIndiceOrig,cAliasOri,_CodVPC, _VERVPC)

Local cUserAprov 	:= ""
Local cFirstNivel	:= ""
Local cMailDest		:= ""
Local cNomeAprov	:= ""
Local aAreaP09		:= P09->(GetArea())
Local llRet			:= .F.
Local aAreaOrig		:= &(cAliasOri)->(GetArea())

//ErrorBlock( { |oErro| U_MySndError(oErro) } )

dbSelectArea("P0B")
P0B->(dbSetOrder(2))

(clAlias)->(dbGoTop())

If (clAlias)->(!Eof()) .AND. (clAlias)->(!Bof())
	
	cNumAlc := GetSxeNum("P0B","P0B_NUM")
	
	While (clAlias)->(!Eof())
		
		cUserAprov := Posicione("P09",1,xFilial("P09") + (clAlias)->P09_CODIGO,"P09_USER" )
		
		If !Empty(cUserAprov)
			
			If !(P0B->(DbSeek(xFilial("P0B") + PadR(cTpDocAlc,TamSx3("P0B_TIPO")[1]) + PadR(cNumAlc,TamSx3("P0B_NUM")[1])+ PadR( cUserAprov ,TamSx3("P0B_USER")[1]) ) ))
				
				If Empty(cFirstNivel)
					cFirstNivel := Alltrim((clAlias)->P09_ORDEM)
				EndIf
				DbSelectArea(cAliasOri)
				DbSetOrder(nIndiceOrig)
				
				&(cAliasOri)->(DbSeek(xFilial(cAliasOri) + cChaveInd))
				
				
				P0B->(RecLock("P0B",.T.) )
				
				P0B->P0B_FILIAL	:= xFilial("P0B")
				P0B->P0B_NUM	:= cNumAlc
				P0B->P0B_TIPO  	:= cTpDocAlc
				P0B->P0B_USER  	:= cUserAprov
				P0B->P0B_APROV 	:= (clAlias)->P09_CODIGO
				P0B->P0B_NIVEL 	:= (clAlias)->P09_ORDEM
				P0B->P0B_STATUS	:= IIF(Alltrim(cFirstNivel) == Alltrim((clAlias)->P09_ORDEM),"01", "") // Se for o primeiro nivel deixa aberto para aparecer no borwse do primeiro nivel. Senao fica em branco aguardando primeira aprovação
				P0B->P0B_DTLIB 	:= CTOD("  /  /  ")
				//P0B->P0B_OBS   	:= ""
				P0B->P0B_EMISSA	:= MsDate()
				P0B->P0B_HEMISS	:= SubStr(Time(),1,2)+":"+SubStr(Time(),4,2)
				P0B->P0B_WF    	:= "1"
				P0B->P0B_USEORI	:= __cUserId
				P0B->P0B_TABORI	:= cAliasOri
				P0B->P0B_CHVIND	:= cChaveInd
				P0B->P0B_INDCHO	:= nIndiceOrig
				If cAliasOri == "SC5"
					P0B->P0B_PEDIDO := SC5->C5_NUM
					P0B->P0B_CODCLI	:= SC5->C5_CLIENTE
					P0B->P0B_LOJA	:= SC5->C5_LOJACLI
					P0b->P0B_EMIPED	:= SC5->C5_EMISSAO
					P0B->P0B_CANAL	:= SC5->C5_YCANAL 
					P0B->P0B_CODVEN	:= SC5->C5_VEND1
					P0B->P0B_RENFIN := (clAlias)->P09_RENFIN
				EndIf
				llRet := .T.
				
				P0B->(MsUnLock())
				
				If !Empty(P0B->P0B_STATUS)
					
					cMailDest := Posicione("P09",1,xFilial("P09") + (clAlias)->P09_CODIGO,"P09_EMAIL" )
					cNomeAprov:= Posicione("P09",1,xFilial("P09")+P0B->P0B_APROV,"P09_NOME")
					
					If AllTrim(P0B->P0B_TABORI) == "SC5"
						U_ENVWF103(P0B->P0B_NUM,P0B->P0B_TIPO,cNomeAprov,cMailDest,P0B->P0B_TABORI,P0B->P0B_CHVIND,P0B->P0B_INDCHO)
					ElseIf AllTrim(P0B->P0B_TABORI) $ "ZZ7"
						U_R705ENVWF(cNumAlc,cTpDocAlc,cNomeAprov,cMailDest,P0B->P0B_TABORI,P0B->P0B_CHVIND,P0B->P0B_INDCHO,_CodVPC, _VERVPC)
					ElseIf AllTrim(P0B->P0B_TABORI) $ "ZZM"
						U_R710ENVWF(cNumAlc,cTpDocAlc,cNomeAprov,cMailDest,P0B->P0B_TABORI,P0B->P0B_CHVIND,P0B->P0B_INDCHO,_CodVPC, _VERVPC)											
					Else
						U_ENVWF102(cNumAlc,cTpDocAlc,cNomeAprov,cMailDest,P0B->P0B_TABORI,P0B->P0B_CHVIND,P0B->P0B_INDCHO,_CodVPC, _VERVPC)
					EndIf
				EndIf
			Else
				P0B->(ConfirmSx8())
				
			EndIf
			
		EndIf
		
		(clAlias)->(dbSkip())
		
	EndDo
	
EndIf

If llRet
	P0B->(ConfirmSx8())
Else
	P0B->(RollBackSX8())
EndIf

RestArea(aAreaP09)
RestArea(aAreaOrig)

Return llRet
