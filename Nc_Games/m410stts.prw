#Include "Protheus.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³M410STTS   ºAutor  ³Alberto DBMS       º Data ³  10/03/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Ponto de entrada na confirma'c~ao do pedido de venda.      º±±
±±º          ³ Atualiza o status do orcamento importado.                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function M410STTS

	Local aAreaAtu	:= GetArea()
	Local aAreaSC6   	:= SC6->(GetArea())
	Local aAreaSA1  	:= SA1->(GetArea())
	Local aAreaSC0 	:= SC0->(GetArea())

	Local _cCondPag 	:= M->C5_CONDPAG // VENDAAVISTA
	Local lCondPag 	:= AllTrim(_cCondPag) $ AllTrim(SuperGetMv("MV_NCRESER",.F.,""))// VENDAAVISTA
	Local lPedidoSite	:= Iif(SC5->C5_XECOMER=="C",.T.,.F.)

	Local cFilMDSW	:= U_MyNewSX6("NCG_100002","05","C","Filiais que realizam o tratamento de midia e software","","",.F. )
	
	Local lWMPedido	:= IsIncallStack("U_M08WMJOB") .Or. IsIncallStack("U_NCGWM002") .Or. IsInCallStack("U_M08WMMen")

	DbSelectArea("SC6")
	DbSetOrder(1)
	
	SC0->(DbSetOrder(1))//C0_FILIAL+C0_NUM+C0_PRODUTO+C0_LOCAL

	If SC5->C5_XSTAPED=="20"//Rejeitado pelo Cliente
		SC5->(RecLock("SC5",.F.))
		SC5->C5_YSTATUS:="99"
		SC5->(MsUnLock())
	EndIf

	SC5->(RecLock("SC5",.F.))
	SC5->C5_YTRANSP:=""
	SC5->(MsUnLock())

	U_PR106ExcP0A(SC5->C5_FILIAL,SC5->C5_NUM)

	/*------------------------------------------------------------//
	// Projeto prospects - remover do fonte						   //
	//------------------------------------------------------------*/
	
	nRecPZ1:=0
	
	If !IsInCallStack("U_NCGJ001") .And. IsInCallStack("A410ALTERA")  .And. U_M001TemPV(xFilial("SC5"),SC5->C5_NUM,1,@nRecPZ1) 
		PZ1->(DbGoTo(nRecPZ1))
		U_M001PZ1Grv("ESTORNA_LIBERACAO_DESTINO",,PZ1->PZ1_FILORI,PZ1->PZ1_FILDES,PZ1->PZ1_PVORIG,PZ1->PZ1_PVDEST)
	EndIf


	If CFILANT $ cFilMDSW .and. SC5->C5_TIPO == "N"  .and. !(!inclui .and. !altera) //Não entra se for exclusão
	
		aItensG002:= U_A002RetaCols() //aItensG002 - variavel publica declarada no PE MT410TOK - tratamento de midia e software
	
		If len(aItensG002) > 0
			DbSelectArea("SC6")
			DbSetOrder(1)
			For nn:=1 to len(aItensG002)
				If SC6->(DbSeek(SC5->(C5_FILIAL+C5_NUM)+aItensG002[nn,1]))
					SC6->(reclock("SC6",.F.))
					
					If Empty(SC6->C6_CLI)
						SC6->C6_CLI	:= SC5->C5_CLIENTE
						SC6->C6_LOJA	:= SC5->C5_LOJACLI
					EndIf
					For nH:=1 to len(aHeader)-2  //desconsidera o AliasWT e RecnoWT
						If !(getadvfval("SX3","X3_CONTEXT",aHeader[nH,2],2,"") == "V")
							cCampo1	:= "SC6->"+aHeader[nH,2]
							&cCampo1	:= aItensG002[nn,nH]
						EndIf
					Next nH
					
					SC6->(MsUnlock())
				Else
					SC6->(reclock("SC6",.T.))
					
					SC6->C6_FILIAL	:= SC5->C5_FILIAL
					SC6->C6_NUM		:= SC5->C5_NUM
					SC6->C6_CLI		:= SC5->C5_CLIENTE
					SC6->C6_LOJA		:= SC5->C5_LOJACLI
					For nH:=1 to len(aHeader)-2 ////desconsidera o AliasWT e RecnoWT
						If !(getadvfval("SX3","X3_CONTEXT",aHeader[nH,2],2,"") == "V")
							cCampo1	:= "SC6->"+aHeader[nH,2]
							&cCampo1	:= aItensG002[nn,nH]
						EndIf
					Next nH
					SC6->(msunlock())
					If AvalTes( SC6->C6_TES,"S")
						SB2->(dbSetOrder(1))
						If SB2->(MsSeek(xFilial("SB2")+SC6->C6_PRODUTO+SC6->C6_LOCAL))
							SB2->(RecLock("SB2",.F.))
							SB2->B2_QPEDVEN += (SC6->C6_QTDVEN-SC6->C6_QTDENT-SC6->C6_QTDEMP-SC6->C6_QTDRESE	)
							SB2->B2_QPEDVE2 += ConvUM(SB2->B2_COD, SC6->C6_QTDVEN-SC6->C6_QTDENT-SC6->C6_QTDEMP-SC6->C6_QTDRESE, 0, 2)
							SB2->(MsUnLock())
						EndIf
					EndIf
				
				EndIf
			Next nn
		EndIf
	
	EndIf

	U_A002IniaCols()
	If INCLUI .Or. ALTERA
		If U_PR107TemPromo(SC5->C5_NUM)
			Processa( {|| U_PR708GrvPromo() }, "Aguarde...", "Calculando Margem Promocional...",.F.)
		EndIf
	EndIf

	SC6->(RestArea(aAreaSC6))

	/*----------------------------------------------------------------------//
	//	 PROJETO VENDA A VISTA - VENDA A VISTA									  //
	//----------------------------------------------------------------------*/
	
	U_NC110Del(SC5->C5_NUM)

	If (INCLUI .Or. ALTERA) .And. (lPedidoSite .Or.  ( lCondPag .And. SC5->C5_XSTAPED == "15")  .Or. lWMPedido )
	
		Processa({||U_NC110MTA410()},"Processando Reserva.")
	
		If SC0->(DbSeek(xFilial()+SC5->C5_NUM  ))
			If !lPedidoSite  .And. !lWMPedido
				Processa({|| U_110MTR730() },"Processando Pré-Nota.")
				Processa({|| U_NC110Mail()})
			EndIf
		Else
			MsgStop("Não foi possível realizar a reserva do pedido"+SC5->C5_NUM)
		EndIf
	EndIf
	

	If (INCLUI .Or. ALTERA)   .And. !lPedidoSite .And. AllTrim(SC5->C5_YORIGEM)<>'WM'
		U_M001DuplPV(SC5->C5_NUM)
	EndIf


	If INCLUI .Or. ALTERA .And. !lPedidoSite
		SA1->(DbSetOrder(1))
		If SA1->(MsSeek(xFilial("SA1")+SC5->C5_CLIENTE+SC5->C5_LOJACLI)) .And. SA1->A1_YBLQFIN=="1"
			MsgStop("Cliente com bloqueio financeiro, será possível "+IIf(INCLUI,"incluir","alterar")+" o pedido mas não libera-lo para faturamento.","Nc Games")
		EndIf
	EndIf

	RestArea(aAreaSC0)
	RestArea(aAreaSA1)
	RestArea(aAreaAtu)

Return
