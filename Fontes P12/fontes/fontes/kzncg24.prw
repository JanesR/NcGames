#INCLUDE "PROTHEUS.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±º                ___  "  ___                             		      		   º±±
±±º              ( ___ \|/ ___ ) Kazoolo                   		      		   º±±
±±º               ( __ /|\ __ )  Codefacttory 				      			   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºFuncao    ³KZNCG24		 ºAutor  ³Adam Diniz Lima	  º Data ³ 19/05/12    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Rotina de Consistencia do PEDIDO EDI				 			   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³			                                                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ alPedEDI - 	Array[x][1]-Num.Ped.EDI							   º±±
±±º			 ³				Array[x][2]-Cli Fat  			 			       º±±
±±º			 ³				Array[x][3]-Lj Fat								   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³ alPDCons - Array com os pedidos e status			               º±±
±±º			 |				Array[x][1]-Num.Ped.EDI							   º±±
±±º			 ³				Array[x][2]-Cli Fat  			 			       º±±
±±º			 ³				Array[x][3]-Lj Fat								   º±±
±±º			 ³				Array[x][4]-Status apos rotina de consistencia	   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function KZNCG24(alPedEDI)

Local alArea   		:= GetArea()
Local nlI	   		:= 0
Local nlJ	   		:= 0
Local alPDCons		:= {}

Private apPedEDI	:= ACLONE(alPedEDI)
Private apIncons	:= {}
Private cpStatus	:= ""

If Len(alPedEDI) > 0
	DbSelectArea("ZAE")
	ZAE->(DbSetOrder(1))
	     
	DbSelectArea("ZAB")
	ZAB->(DbSetOrder(1))
	
	DbSelectArea("SX5")
	SX5->(DbSetOrder(1))
	If SX5->(DbSeek(xFilial("SX5")+"ZC"))
		While SX5->(!EoF()) .And. X5_TABELA == "ZC"
			If Val(SX5->X5_CHAVE) <= 11
				ZAB->(DbGoTop())
				If ZAB->(DbSeek(xFilial("ZAB")+SX5->X5_CHAVE))
					aAdd(apIncons,{SX5->X5_CHAVE,(ZAB->ZAB_APROVA == '1'),(ZAB->ZAB_IMPED == '1')})
				EndIf
			EndIf
			Sx5->(DbSkip())
		EndDo
	EndIf
	
	If Len(apIncons) > 0
		For nlI := 1 to Len(alPedEDI)
			cpStatus	:= "1" // "Apto a gerar Pedido de Venda"
			ZAE->(DbGoTop())
			If ZAE->(DbSeek(xFilial("ZAE")+PadR(alPedEDI[nlI][1],TamSx3("ZAE_NUMEDI")[1])+PadR(alPedEDI[nlI][2],TamSx3("ZAE_CLIFAT")[1])+PadR(alPedEDI[nlI][3],TamSx3("ZAE_LJFAT")[1]) ))
				For nlJ := 1 to Len(apIncons)
					&("KzInc"+apIncons[nlJ][1]+"()")
				Next nlJ
			EndIf
			aAdd(alPDCons, {alPedEDI[nlI][1],alPedEDI[nlI][2],alPedEDI[nlI][3],cpStatus})
		Next nlI
	EndIf
EndIf

RestArea(alArea)

Return alPDCons

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±º                ___  "  ___                             		      		   º±±
±±º              ( ___ \|/ ___ ) Kazoolo                   		      		   º±±
±±º               ( __ /|\ __ )  Codefacttory 				      			   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºFuncao    ³KzGrvZ7		 ºAutor  ³Adam Diniz Lima	  º Data ³ 19/05/12    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao que realiza a gravacao na tabela ZAG - Inconsistencias   º±±
±±º			 ³	EDI Comercial, em funcao dos parametros recebidos 			   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³			                                                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³	llAllPed - Logico informando se gravara todos os itens ou nao  º±±
±±º			 ³	clIncons - Codigo da inconsistencia para efetuar gravacao ZAG  º±±
±±º			 ³	clItem - Codigo do Item para gravacao da inconsistencia		   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³ 								                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function KzGrvZ7(llAllPed,clIncons,clItem)
                 
Local alArea:= GetArea()
Local clQry := ""

If llAllPed
	
	clQry	:= "	Select 			"  								+ CRLF
	clQry	+= " 		ZAF_ITEM		"								+ CRLF
	clQry	+= "	From	"		   								+ CRLF
	clQry	+= RetSqlName("ZAF")   									+ CRLF
	clQry	+= "	Where ZAF_FILIAL = '"+xFilial("ZAF")+"' "		+ CRLF
	clQry	+= "	AND D_E_L_E_T_ = '' "							+ CRLF
	clQry	+= "	AND ZAF_NUMEDI = '"+ZAE->ZAE_NUMEDI+"'"			+ CRLF
	
	clQry := ChangeQuery(clQry)

	If Select("QRYP") > 0
		QRYP->(DbCloseArea())
	EndIf
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,clQry), "QRYP" ,.T.,.F.)
	
	DbSelectArea("ZAG")
	ZAG->(DbSetOrder(1))

	While QRYP->(!EOF())
		ZAG->(DbGoTop())
		If ZAG->(!DbSeek(xFilial("ZAG")+avKey(ZAE->ZAE_NUMEDI,"ZAG_NUMEDI")+avKey(ZAE->ZAE_CLIFAT,"ZAG_CLIFAT")+avKey(ZAE->ZAE_LJFAT,"ZAG_LJFAT")+avKey(QRYP->ZAF_ITEM,"ZAG_ITEM")+AllTrim(clIncons)))
			If RecLock("ZAG",.T.)
				ZAG->ZAG_FILIAL	:= xFilial("ZAG")
				ZAG->ZAG_NUMEDI	:= ZAE->ZAE_NUMEDI
				ZAG->ZAG_CLIFAT	:= ZAE->ZAE_CLIFAT
				ZAG->ZAG_LJFAT	:= ZAE->ZAE_LJFAT
				ZAG->ZAG_ITEM	:= QRYP->ZAF_ITEM
				ZAG->ZAG_INCONS	:= AllTrim(clIncons)
			    ZAG->(MsUnLock())
			EndIf
		EndIf
		QRYP->(DbSkip())
	EndDo
	QRYP->(DbCloseArea())
Else
	DbSelectArea("ZAG")
	ZAG->(DbSetOrder(1))
	ZAG->(DbGoTop())
	
	If ZAG->(!DbSeek(xFilial("ZAG")+PadR(ZAE->ZAE_NUMEDI,TamSx3("ZAG_NUMEDI")[1])+PadR(ZAE->ZAE_CLIFAT,TamSx3("ZAG_CLIFAT")[1])+PadR(ZAE->ZAE_LJFAT,TamSx3("ZAG_LJFAT")[1])+PadR(clItem,TamSx3("ZAG_ITEM")[1])+AllTrim(clIncons)))
		If RecLock("ZAG",.T.)
			ZAG->ZAG_FILIAL	:= xFilial("ZAG")
			ZAG->ZAG_NUMEDI	:= ZAE->ZAE_NUMEDI
			ZAG->ZAG_CLIFAT	:= ZAE->ZAE_CLIFAT
			ZAG->ZAG_LJFAT	:= ZAE->ZAE_LJFAT
			ZAG->ZAG_ITEM	:= AllTrim(clItem)
			ZAG->ZAG_INCONS	:= AllTrim(clIncons)
		    ZAG->(MsUnLock())
		EndIf
	EndIf
EndIf


RestArea(alArea)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±º                ___  "  ___                             		      		   º±±
±±º              ( ___ \|/ ___ ) Kazoolo                   		      		   º±±
±±º               ( __ /|\ __ )  Codefacttory 				      			   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºFuncao    ³KzGeraSt		 ºAutor  ³Adam Diniz Lima	  º Data ³ 19/05/12    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao que realiza a logica da regra de inconsistencia		   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³			                                                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³	llAprov - Logico se a inconsistencia precisa de aprovacao	   º±±
±±º			 ³	llImped - Logico se a inconsistencia sera Impeditiva		   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³clStatus - Codigo do Status por avaliacao de prioridade          º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function KzGeraSt(llAprov, llImped)

Local clStatus := ""

If llAprov .And. llImped
	clStatus := "4" // Com Inconsistencia
ElseIf llAprov .And. !llImped
	clStatus := "3" // Aguardando Aprovacao
ElseIf !llAprov .And. llImped
	clStatus := "4" // Com Inconsistencia
Else // !llAprov .And. !llImped
	clStatus := "2" // Apto a gerar pedido de venda - advertencia
EndIf

Return clStatus

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±º                ___  "  ___                             		      		   º±±
±±º              ( ___ \|/ ___ ) Kazoolo                   		      		   º±±
±±º               ( __ /|\ __ )  Codefacttory 				      			   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºFuncao    ³KzVldSts		 ºAutor  ³Adam Diniz Lima	  º Data ³ 19/05/12    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao para Montar o Status do Pedido EDI, avalia os Status.	   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³			                                                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ clInc - Codigo da inconsistencia								   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³ (alteracao da variavel principal de status do pedido cpStatus)  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function KzVldSts(clInc)

Local nlPos		:= 0
Local clStatus	:= "" 
      
nlPos := aScan(apIncons,{|x| AllTrim(x[1]) == clInc})
clStatus := KzGeraSt(apIncons[nlPos][2], apIncons[nlPos][3])

If Val(clStatus) > Val(cpStatus)
	cpStatus := clStatus
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±º                ___  "  ___                             		      		   º±±
±±º              ( ___ \|/ ___ ) Kazoolo                   		      		   º±±
±±º               ( __ /|\ __ )  Codefacttory 				      			   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºFuncao    ³KzInc01		 ºAutor  ³Adam Diniz Lima	  º Data ³ 19/05/12    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Verifica inconsistencia de Cliente de entrega/fat/cobranca 	   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³			                                                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ 																   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³ 								                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function KzInc01()

Local alArea	:= GetArea()

Local llIncons	:= .F.           

DbSelectArea("SA1")
SA1->(DbSetOrder(3)) // Por CPF

SA1->(DbGoTop())
// Pesquisa primeiro o CNPJ do cliente de ENTREGA
If SA1->(DbSeek(xFilial("SA1")+ZAE->ZAE_CGCENT)) .And. !Empty(ZAE->ZAE_CGCENT)
	// Pesquisa primeiro o CNPJ do cliente de FATURAMENTO
	SA1->(DbGoTop())
	If SA1->(DbSeek(xFilial("SA1")+ZAE->ZAE_CGCFAT)) .And. !Empty(ZAE->ZAE_CGCFAT)
	    // Pesquisa primeiro o CNPJ do cliente de COBRANCA
	   	SA1->(DbGoTop())
   		If SA1->(!DbSeek(xFilial("SA1")+ZAE->ZAE_CGCCOB)) .Or. Empty(ZAE->ZAE_CGCCOB)
			llIncons := .T.
		EndIf
	Else
		llIncons := .T.
	EndIf
Else
	llIncons := .T.
EndIf

If llIncons 
	KzGrvZ7(.T.,'01')
	KzVldSts('01')
EndIf

RestArea(alArea)
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±º                ___  "  ___                             		      		   º±±
±±º              ( ___ \|/ ___ ) Kazoolo                   		      		   º±±
±±º               ( __ /|\ __ )  Codefacttory 				      			   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºFuncao    ³KzInc02		 ºAutor  ³Adam Diniz Lima	  º Data ³ 19/05/12    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Verifica Inconsistencia de Codigo EAN							   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³			                                                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ 																   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³ 								                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function KzInc02()

Local alArea	:= GetArea()

DbSelectArea("SB1")
SB1->(DbSetOrder(5))

DbSelectArea("ZAF")
ZAF->(DbSetOrder(1))

If ZAF->(DbSeek(xFilial("ZAF")+PadR(ZAE->ZAE_NUMEDI,TamSx3("ZAF_NUMEDI")[1])))
	While ZAF->(!Eof()) .And. AllTrim(ZAF->ZAF_NUMEDI) == AllTrim(ZAE->ZAE_NUMEDI)
		SB1->(DbGoTop())
		If SB1->(!DbSeek(xFilial("SB1")+ ZAF->ZAF_EAN)) .Or. Empty(ZAF->ZAF_EAN)
			KzGrvZ7(.F.,'02',ZAF->ZAF_ITEM)
			KzVldSts('02')
  		EndIf
		ZAF->(DbSkip())
	EndDo
EndIf

RestArea(alArea)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±º                ___  "  ___                             		      		   º±±
±±º              ( ___ \|/ ___ ) Kazoolo                   		      		   º±±
±±º               ( __ /|\ __ )  Codefacttory 				      			   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºFuncao    ³KzInc03		 ºAutor  ³Adam Diniz Lima	  º Data ³ 19/05/12    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Verifica inconsistencia de Valor unitario			 			   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³			                                                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ 																   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³ 								                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function KzInc03()

Local alArea	:= GetArea() 
Local cTabPrc	:= ZAE->ZAE_TABPRC

DbSelectArea("DA1")
DA1->(DbSetOrder(1))

DbSelectArea("ZAF")
ZAF->(DbSetOrder(1))

If !Empty(cTabPrc)
	If ZAF->(DbSeek(xFilial("ZAF")+PadR(ZAE->ZAE_NUMEDI,TamSx3("ZAF_NUMEDI")[1])))
		While ZAF->(!Eof()) .And. AllTrim(ZAF->ZAF_NUMEDI) == AllTrim(ZAE->ZAE_NUMEDI)
			DA1->(DbGoTop())
			If DA1->(DbSeek(xFilial("DA1")+ avKey(cTabPrc,"DA1_CODTAB")+ZAF->ZAF_PRODUT))
				If ZAF->ZAF_PRCUNI != DA1->DA1_PRCVEN
					KzGrvZ7(.F.,'03',ZAF->ZAF_ITEM)
					KzVldSts('03')
				EndIf
			Else
				KzGrvZ7(.F.,'03',ZAF->ZAF_ITEM)
				KzVldSts('03')
			EndIf
			ZAF->(DbSkip())	
		EndDo
	EndIf
Else
	KzGrvZ7(.T.,'03')
	KzVldSts('03')	
EndIf

RestArea(alArea)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±º                ___  "  ___                             		      		   º±±
±±º              ( ___ \|/ ___ ) Kazoolo                   		      		   º±±
±±º               ( __ /|\ __ )  Codefacttory 				      			   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºFuncao    ³KzInc04		 ºAutor  ³Adam Diniz Lima	  º Data ³ 19/05/12    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Verifica Inconsistencia de Percentual de IPI		 			   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³			                                                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ 																   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³ 								                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function KzInc04()

Local alArea	:= GetArea()

DbSelectArea("SB1")
SB1->(DbSetOrder(1))

DbSelectArea("ZAF")
ZAF->(DbSetOrder(1))

If ZAF->(DbSeek(xFilial("ZAF")+PadR(ZAE->ZAE_NUMEDI,TamSx3("ZAF_NUMEDI")[1])))
	While ZAF->(!Eof()) .And. AllTrim(ZAF->ZAF_NUMEDI) == AllTrim(ZAE->ZAE_NUMEDI)
		SB1->(DbGoTop())
		If SB1->(DbSeek(xFilial("SB1")+ PadR(ZAF->ZAF_PRODUT,TamSx3("B1_COD")[1])))
			If ZAF->ZAF_PERCIP != SB1->B1_IPI
				KzGrvZ7(.F.,'04',ZAF->ZAF_ITEM)
				KzVldSts('04')
			EndIf
		EndIf
		ZAF->(DbSkip())
	EndDo
EndIf

RestArea(alArea)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±º                ___  "  ___                             		      		   º±±
±±º              ( ___ \|/ ___ ) Kazoolo                   		      		   º±±
±±º               ( __ /|\ __ )  Codefacttory 				      			   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºFuncao    ³KzInc05		 ºAutor  ³Adam Diniz Lima	  º Data ³ 19/05/12    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Verifica Inconsistencia de Percentual de Desconto				   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³			                                                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ 																   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³ 								                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function KzInc05()

Local alArea	:= GetArea()
Local alDesc	:= {}

DbSelectArea("SA1")
SA1->(DbSetOrder(1))

DbSelectArea("ZAF")
ZAF->(DbSetOrder(1))

If ZAF->(DbSeek(xFilial("ZAF")+PadR(ZAE->ZAE_NUMEDI,TamSx3("ZAF_NUMEDI")[1])))
	While ZAF->(!Eof()) .And. AllTrim(ZAF->ZAF_NUMEDI) == AllTrim(ZAE->ZAE_NUMEDI)
		SA1->(DbGoTop())
		If SA1->(DbSeek(xFilial("SA1")+avKey(ZAE->ZAE_CLIFAT,"A1_COD")+avKey(ZAE->ZAE_LJFAT,"A1_LOJA")))
			If ZAF->ZAF_DESC > 0
				//KzBscRg(cPrd,cCli,cLja,cTab,nQtd,cCPg)
				alDesc := KzBscRg(ZAF->ZAF_PRODUT,ZAE->ZAE_CLIFAT,ZAE->ZAE_LJFAT,SA1->A1_TABELA,ZAE->ZAE_CONDPAG)
				If Len(alDesc) == 0
					KzGrvZ7(.F.,'05',ZAF->ZAF_ITEM)
					KzVldSts('05')
				Else
					If ZAF->ZAF_DESC > alDesc[1] 
						KzGrvZ7(.F.,'05',ZAF->ZAF_ITEM)
						KzVldSts('05')
					EndIf
				EndIf
			EndIf
		Else
			KzGrvZ7(.F.,'05',ZAF->ZAF_ITEM)
			KzVldSts('05')
		EndIf
		ZAF->(DbSkip())
	EndDo
EndIf

RestArea(alArea)
Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±º                ___  "  ___                             		      		   º±±
±±º              ( ___ \|/ ___ ) Kazoolo                   		      		   º±±
±±º               ( __ /|\ __ )  Codefacttory 				      			   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºFuncao    ³KzInc06		 ºAutor  ³Adam Diniz Lima	  º Data ³ 19/05/12    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Verifica Inconsistencia de Valor total do item	 			   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³			                                                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ 																   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³ 								                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function KzInc06()

Local alArea	:= GetArea()

DbSelectArea("ZAF")
ZAF->(DbSetOrder(1))

If ZAF->(DbSeek(xFilial("ZAF")+PadR(ZAE->ZAE_NUMEDI,TamSx3("ZAF_NUMEDI")[1])))
	While ZAF->(!Eof()) .And. AllTrim(ZAF->ZAF_NUMEDI) == AllTrim(ZAE->ZAE_NUMEDI)
		If (ZAF->ZAF_PRCUNI * ZAF->ZAF_QTD) != ZAF->ZAF_TOTAL
			KzGrvZ7(.F.,'06',ZAF->ZAF_ITEM)
			KzVldSts('06')
		EndIf
		ZAF->(DbSkip())
	EndDo
EndIf


RestArea(alArea)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±º                ___  "  ___                             		      		   º±±
±±º              ( ___ \|/ ___ ) Kazoolo                   		      		   º±±
±±º               ( __ /|\ __ )  Codefacttory 				      			   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºFuncao    ³KzInc07		 ºAutor  ³Adam Diniz Lima	  º Data ³ 19/05/12    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³VerificaInconsistencia de Produto bloqueado para venda ou inativoº±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³			                                                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ 																   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³ 								                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function KzInc07()
Local alArea	:= GetArea()

DbSelectArea("SB1")
SB1->(DbSetOrder(1))

DbSelectArea("ZAF")
ZAF->(DbSetOrder(1))

If ZAF->(DbSeek(xFilial("ZAF")+PadR(ZAE->ZAE_NUMEDI,TamSx3("ZAF_NUMEDI")[1])))
	While ZAF->(!Eof()) .And. AllTrim(ZAF->ZAF_NUMEDI) == AllTrim(ZAE->ZAE_NUMEDI)
		SB1->(DbGoTop())
		If SB1->(DbSeek(xFilial("SB1")+ PadR(ZAF->ZAF_PRODUT,TamSx3("B1_COD")[1])))
			If SB1->B1_MSBLQL == "1" .Or. SB1->B1_ATIVO == "N"
				KzGrvZ7(.F.,'07',ZAF->ZAF_ITEM)
				KzVldSts('07')
			EndIf
		EndIf
		ZAF->(DbSkip())
	EndDo
EndIf

RestArea(alArea)
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±º                ___  "  ___                             		      		   º±±
±±º              ( ___ \|/ ___ ) Kazoolo                   		      		   º±±
±±º               ( __ /|\ __ )  Codefacttory 				      			   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºFuncao    ³KzInc08		 ºAutor  ³Adam Diniz Lima	  º Data ³ 19/05/12    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Verifica Inconsistencia de Produto alternativo				   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³			                                                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ 																   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³ 								                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function KzInc08()

Local alArea	:= GetArea()

DbSelectArea("SX2")
SX2->(dbSetOrder(1))
SX2->(dbGoTop())

dbSelectArea("SX2")
SX2->(dbSetOrder(1))
SX2->(dbGoTop())

If SX2->(dbSeek("SGI"))
	If SX2->(dbSeek("SGI"))
		DbSelectArea("SGI")
		SGI->(DbSetOrder(1))
		
		If ZAF->(DbSeek(xFilial("ZAF")+PadR(ZAE->ZAE_NUMEDI,TamSx3("ZAF_NUMEDI")[1])))
			While ZAF->(!Eof()) .And. AllTrim(ZAF->ZAF_NUMEDI) == AllTrim(ZAE->ZAE_NUMEDI)
				SGI->(DbGoTop())
				If SGI->(!DbSeek(xFilial("SGI")+ZAF->ZAF_PRODUT))
					KzGrvZ7(.F.,'08',ZAF->ZAF_ITEM)
					KzVldSts('08')
				EndIf
				ZAF->(DbSkip())
			EndDo
		EndIf
	EndIf
Else
	KzGrvZ7(.T.,'08')
	KzVldSts('08')
EndIf

RestArea(alArea)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±º                ___  "  ___                             		      		   º±±
±±º              ( ___ \|/ ___ ) Kazoolo                   		      		   º±±
±±º               ( __ /|\ __ )  Codefacttory 				      			   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºFuncao    ³KzInc09		 ºAutor  ³Adam Diniz Lima	  º Data ³ 19/05/12    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Verifica Inconsistencia de Valor mínimo da parcela 			   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³			                                                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ 																   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³ 								                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function KzInc09()

Local alArea	:= GetArea()
Local alParcel	:= {}
Local nlParMin	:= SuperGetMv("KZ_PARCMIN",.F.,0)

alParcel := Condicao(ZAE->ZAE_TOTAL,ZAE->ZAE_CONDPA,0,dDataBase,0)

If Len(alParcel) > 0
	nlValPar := alParcel[1][2]
Else
	nlValPar := 0
EndIf

If nlValPar < nlParMin
	KzGrvZ7(.T.,'09')
	KzVldSts('09')
EndIf

RestArea(alArea)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±º                ___  "  ___                             		      		   º±±
±±º              ( ___ \|/ ___ ) Kazoolo                   		      		   º±±
±±º               ( __ /|\ __ )  Codefacttory 				      			   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºFuncao    ³KzInc10		 ºAutor  ³Adam Diniz Lima	  º Data ³ 19/05/12    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Verifica inconsistencia de Quantidade máxima de itens por pedido º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³			                                                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ 																   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³ 								                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function KzInc10()

Local alArea	:= GetArea()
Local clQry		:= ""
Local nlQtdMax		:= SuperGetMv("MV_MAXITPV",.F.,0)

clQry	:= "	Select 			"  								+ CRLF
clQry	+= " 		Count(ZAF_ITEM) as QTDCPOS	"				+ CRLF
clQry	+= "	From	"		   								+ CRLF
clQry	+= RetSqlName("ZAF")   									+ CRLF
clQry	+= "	Where ZAF_FILIAL = '"+xFilial("ZAF")+"' "		+ CRLF
clQry	+= "	AND D_E_L_E_T_ = '' "							+ CRLF
clQry	+= "	AND ZAF_NUMEDI = '"+ZAE->ZAE_NUMEDI+"'"			+ CRLF

clQry := ChangeQuery(clQry)

If Select("QRYQ") > 0
	QRYQ->(DbCloseArea())
EndIf
dbUseArea(.T.,"TOPCONN",TcGenQry(,,clQry), "QRYQ" ,.T.,.F.)

If QRYQ->(!Eof())
	If QRYQ->QTDCPOS > nlQtdMax
		KzGrvZ7(.T.,'10')
		KzVldSts('10')
	EndIf	
EndIf
RestArea(alArea)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±º                ___  "  ___                             		      		   º±±
±±º              ( ___ \|/ ___ ) Kazoolo                   					   º±±
±±º               ( __ /|\ __ )  Codefacttory 				      			   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºFuncao    ³KzInc11		 ºAutor  ³Adam Diniz Lima	  º Data ³ 19/05/12    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Verifica Inconsistencia de Valor máximo por pedido			   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³			                                                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ 																   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³ 								                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function KzInc11()

Local nlVlMPed		:= SuperGetMv("MV_VLMAXPV",.F.,0)

If ZAE->ZAE_TOTAL > nlVlMPed
	KzGrvZ7(.T.,'11')
	KzVldSts('11')
EndIf

Return  

/*********************************************************************************************************/
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±º                ___  "  ___                             		      		   º±±
±±º              ( ___ \|/ ___ ) Kazoolo                   		      		   º±±
±±º               ( __ /|\ __ )  Codefacttory 				      			   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºFuncao    ³KzBscRg		 ºAutor  ³Adam Diniz Lima	  º Data ³ 19/05/12    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Rotina que faz busca do percentual de desconto Produto X Clienteº±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³			                                                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ 																   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³ 								                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function KzBscRg(cPrd,cCli,cLja,cTab,cCPg)
Local aRet		:= {}
Local cGrp		:= Space(TamSx3("B1_GRUPO")[1])
Local cGrpCli 	:= Space(TamSx3("A1_GRPVEN")[1])
Local clQry		:= ""


Default cPrd := Space(TamSx3("B1_COD")[1])
Default cCli := Space(TamSx3("A1_COD")[1])
Default cLja := Space(TamSx3("A1_LOJA")[1])
Default cTab := Space(TamSx3("DA0_CODTAB")[1])
Default cCPg := Space(TamSx3("DA0_CONDPG")[1])


DbSelectArea("SA1")
SA1->(DbSetOrder(1))
If SA1->(DbSeek(xFilial("SA1")+avkey(cCli,"A1_COD")+avkey(cLja,"A1_LOJA")))
	cGrpCli := SA1->A1_GRPVEN
EndIf

cAliasACO := GetNextAlias()

clQry	:= "		SELECT										   									" + CRLF      	
clQry	+= " 			ACP_PERDES 									 					   			" + CRLF
clQry	+= " 		FROM										   			  						" + CRLF
clQry	+= " 		(										   										" + CRLF
clQry	+= " 			SELECT ACO_GRPVEN,ACO_CODCLI,ACO_LOJA,ACO_CONDPG,ACO_CODTAB,ACO_CODREG 		" + CRLF
clQry	+= " 			FROM "+ RetSqlName("ACO")+"													" + CRLF
clQry	+= " 			WHERE	ACO_FILIAL		= '"+xFilial("ACO")+"' 								" + CRLF
clQry	+= " 				AND	ACO_GRPVEN 	= '"+AllTrim(cGrpCli)+"' OR ACO_GRPVEN 	= ''			" + CRLF
clQry	+= " 				AND	ACO_CODCLI 	= '"+AllTrim(cCli)+"'									" + CRLF
clQry	+= " 				AND	ACO_LOJA	= '"+AllTrim(cLja)+"' 									" + CRLF
clQry	+= " 				AND	ACO_CONDPG 	= '"+AllTrim(cCPg)+"'	 OR ACO_CONDPG 	= ''			" + CRLF
clQry	+= "				AND	ACO_CODTAB 	= '"+AllTrim(cTab)+"'	 OR ACO_CODTAB 	= ''			" + CRLF
clQry	+= "				AND D_E_L_E_T_		<> '*'						   						" + CRLF
clQry	+= " 		) ACO 																			" + CRLF
clQry	+= " 		INNER JOIN																		" + CRLF
clQry	+= " 		(																				" + CRLF
clQry	+= "			SELECT ACP_CODPRO,ACP_CODREG,ACP_PERDES 		  							" + CRLF
clQry	+= "			FROM "+ RetSqlName("ACP")+" 					 							" + CRLF
clQry	+= "			WHERE	ACP_CODPRO = '"+AllTrim(cPrd)+"'		 							" + CRLF
clQry	+= "		 		AND	ACP_FILIAL = '"+xFilial("ACP")+"'		 							" + CRLF
clQry	+= " 				AND	D_E_L_E_T_ 	<> '*'						 							" + CRLF
clQry	+= " 		) ACPTAB											 							" + CRLF
clQry	+= "		ON 	ACPTAB.ACP_CODREG = ACO.ACO_CODREG				 							" + CRLF

If Select(cAliasACO) > 0
	(cAliasACO)->(DbCloseArea())
EndIf

clQry := ChangeQuery(clQry)

dbUseArea(.T.,"TOPCONN",TcGenQry(,,clQry), cAliasACO ,.T.,.F.)


DbSelectArea(cAliasACO)
(cAliasACO)->(DbGoTop())
While (cAliasACO)->(!Eof())
	aAdd(aRet,(cAliasACO)->ACP_PERDES)
	(cAliasACO)->(DbSkip())
EndDo
(cAliasACO)->(DbCloseArea())


Return(aRet)
