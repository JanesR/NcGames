#INCLUDE "PROTHEUS.CH"
#INCLUDE "TBICONN.CH"

/* 
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±º                ___  "  ___                             		      		   º±±
±±º              ( ___ \|/ ___ ) Kazoolo                   		      		   º±±
±±º               ( __ /|\ __ )  Codefacttory 				      			   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºFuncao    ³M521DNFS		 ºAutor  ³Adam Diniz Lima 	  º Data ³23/05/2011   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Ponto de Entrada APOS Exclusao Doc.Saida via FATURAMENTO	 	   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³			                                                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³																   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   |								                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function M521DNFS()
      
Local alArea	:= GetArea()
Local llRet		:= .F.
Local llEnviou	:= .F.
Local clEmails	:= ""
Local clMail	:= SuperGetMV("KZ_MAILRES", .F., "")
Local nlTotal	:= 0
Local alEmail	:= {}


DbSelectArea("ZAE")
ZAE->(DbSetOrder(1))
ZAE->(DbGoTop())

DbSelectArea("SA3")
SA3->(DbSetOrder(1))

If ZAE->(DbSeek(xFilial("ZAE")+avKey(SC5->C5_NUMEDI,"ZAE_NUMEDI")+avKey(SC5->C5_CLIENTE,"ZAE_CLIFAT")+avKey(SC5->C5_LOJACLI,"ZAE")))
	Begin Transaction
		If RecLock("ZAE",.F.)
			ZAE->ZAE_STATUS := "5" // Encerrado - Pedido de Venda Gerado
			ZAE->(MsUnlock())
		EndIf
		If RecLock("SF2",.F.)
			SF2->F2_SEQ		:= " "
			SF2->F2_NUMEDI	:= " "
			SF2->F2_DTINV 	:= StoD(" ")
			SF2->(MsUnlock())
		EndIf
		llRet := .T.
	End Transaction
EndIf

If llRet
	alEmail := Separa(clMail,";")
	nlTotal := Len(alEmail)
	While nlTotal > 0
		If nlTotal == 1 .And. Empty(alEmail[nlTotal])
			Exit
		Else
			If !Empty(alEmail[nlTotal])
				If U_KZMAILVD(allTrim(alEmail[nlTotal]))
					llEnviou := .T.
					clEmails += allTrim(alEmail[nlTotal]) + CRLF
				EndIf
			EndIf
		EndIf
		nlTotal--
	EndDo
	
	If !Empty(SC5->C5_VEND1)
		SA3->(DbGoTop())
		If SA3->(DbSeek(xFilial("SA3")+SC5->C5_VEND1))
			If !Empty(SA3->A3_EMAIL)
				 If U_KZMAILVD()
				 	llEnviou := .T.
				 	clEmails += SA3->A3_EMAIL + CRLF
				 EndIf
			EndIf
		EndIf
	EndIf
	If !Empty(SC5->C5_VEND2)
		SA3->(DbGoTop())
		If SA3->(DbSeek(xFilial("SA3")+SC5->C5_VEND2))
			If !Empty(SA3->A3_EMAIL)
				If U_KZMAILVD()
					llEnviou := .T.
					clEmails += SA3->A3_EMAIL + CRLF
				EndIF
			EndIf
		EndIf
	EndIf
	If !Empty(SC5->C5_VEND3)
		SA3->(DbGoTop())
		If SA3->(DbSeek(xFilial("SA3")+SC5->C5_VEND3))
			If !Empty(SA3->A3_EMAIL)
				If U_KZMAILVD()
					llEnviou := .T.
					clEmails += SA3->A3_EMAIL + CRLF
				EndIf
			EndIf
		EndIf
	EndIf
	If !Empty(SC5->C5_VEND4)
		SA3->(DbGoTop())
		If SA3->(DbSeek(xFilial("SA3")+SC5->C5_VEND4))
			If !Empty(SA3->A3_EMAIL)
				If U_KZMAILVD()
					llEnviou := .T.
					clEmails += SA3->A3_EMAIL + CRLF
				EndIf
			EndIf
		EndIf
	EndIf
	If !Empty(SC5->C5_VEND5)
		SA3->(DbGoTop())
		If SA3->(DbSeek(xFilial("SA3")+SC5->C5_VEND5))
			If !Empty(SA3->A3_EMAIL)
				If U_KZMAILVD()
					llEnviou := .T.
					clEmails += SA3->A3_EMAIL + CRLF
				EndIf
			EndIf
		EndIf
	EndIf
	
	If llEnviou
		Aviso("Cancelamento da NF/Serie: " + AllTrim(SF2->F2_DOC)+"/"+AllTrim(SF2->F2_SERIE),; // Titulo da Janela
				"Esse Cancelamento gerou notificação para:" + CRLF + clEmails,; // Conteudo do aviso
				{"Ok"})
	EndIf
	
EndIf
          

//Rotina utilizada no E-commerce para atulizar as tabelas do monitor
U_NCExcNFS(SC5->C5_NUM)


RestArea(alArea)
Return