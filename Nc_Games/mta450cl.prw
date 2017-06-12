#INCLUDE "RWMAKE.CH"

User Function MTA450CL

Local cOpcao	:= PARAMIXB[1]
Local aRegSSCC6	:= PARAMIXB[2]
LOCAL CCODBLOQ	:= ""
Local cFilStore:=Alltrim(U_MyNewSX6("ES_NCG0000","06","C","Filiais que utilizam WMS Store","","",.F. ))
Local lWmsStore:=(cFilAnt$cFilStore)
Local lGravouP0A:=.F.
Local clArea	:= GetArea()
Local llSc5		:= .F.
Local clFil		:= SC5->C5_FILIAL
Local clCli		:= SC5->C5_CLIENTE
Local clPedido	:= SC5->C5_NUM
Local clLoja	:= SC5->C5_LOJACLI
Local clArmz	:= SuperGetMV("MV_ARMWMAS")
Local cAlias	:= GetNextAlias()
Local cAliasCES	:= GetNextAlias()
Local clQry		:= ""
Local cQry2		:= ""
Local cFiliais	:= SuperGetMV("NCG_000030",.F.,"03")
Local aItePed	:= {}
Local lEnvia	:= .T.

dbSelectArea("SC6")
SC6->(dbSetOrder(1))
SC6->(dbSeek(xFilial("SC6")+SC5->C5_NUM))

aVaiWMS	:= {}
IF cOpcao == 1
	WHILE SC6->(!EOF()) .AND. SC5->C5_NUM == SC6->C6_NUM
		//Verificação se vai para o WMS
		cAtuEst	:= getadvfval("SF4","F4_ESTOQUE",xFilial("SF4")+SC6->C6_TES,1,"")
		If alltrim(funname()) == "MATA450A"
			//			If SC6->C6_LOCAL $ GETMV("MV_ARMWMAS") .and. cAtuEst == "S"
			If cAtuEst == "S"
				TCSQLEXEC("UPDATE SC9010 SET C9_BLWMS='02' WHERE C9_FILIAL='"+xFilial("SC9")+"' and C9_PEDIDO='"+alltrim(SC5->C5_NUM)+"' AND C9_BLCRED = ' ' AND C9_BLEST = ' '")
				
				TCSQLEXEC("COMMIT")
			EndIf
		EndIf
		IF !EMPTY(POSICIONE("SC9",1,XFILIAL("SC9")+SC5->C5_NUM+SC6->C6_ITEM,"C9_BLCRED")) //DBSEEK(XFILIAL("SC9")+SC5->C5_NUM+SC6->C6_ITEM)
			CCODBLOQ:= POSICIONE("SC9",1,XFILIAL("SC9")+SC5->C5_NUM+SC6->C6_ITEM,"C9_BLCRED")
			EXIT
		Endif
		cBlqEst	:= POSICIONE("SC9",1,XFILIAL("SC9")+SC5->C5_NUM+SC6->C6_ITEM,"C9_BLEST")
		If !(SC6->C6_LOCAL $ GETMV("MV_ARMWMAS")) .or. cAtuEst <> "S"
			//		AADD(aNaoWMS,{SC6->C6_ITEM,SC6->C6_LOCAL,cAtuEst})
		Else
			If Empty(cBlqEst)
				AADD(aVaiWMS,{SC6->C6_ITEM,SC6->C6_LOCAL,cAtuEst})
			EndIf
		EndIf
		
		SC6->(DBSKIP())
	ENDDO
	
	dbSelectArea("SC6")
	SC6->(dbSetOrder(1))
	SC6->(dbSeek(xFilial("SC6")+SC5->C5_NUM))
	
	If alltrim(funname()) == "MATA450A"
		
		If len(aVaiWMS) > 0 .and. EMPTY(CCODBLOQ)
			//			U_INTPEDVEN(SC5->C5_NUM) //ACRESCENTADO POR ERICH BUTTNER 25/04/11 - PROJETO DE INTEGRAÇÃO COM O WMAS
			
			TCSQLEXEC("UPDATE SC9010 SET C9_BLWMS='02' WHERE C9_FILIAL='"+xFilial("SC9")+"' and C9_PEDIDO='"+alltrim(SC5->C5_NUM)+"'")
			
			TCSQLEXEC("COMMIT")
		EndIf
	EndIf
ENDIF

If clFil $ FormatIN(cFiliais,"|") .Or. lWmsStore

	VerWMS(clFil,clPedido)
	U_PR106ExcP0A(clFil,clPedido)
	
	
	clQry := " SELECT C9_ITEM, C9_PRODUTO "
	clQry := " SELECT C9_ITEM, C9_PRODUTO,SC9.R_E_C_N_O_  RECSC9 "
	
	clQry += " FROM "+RetSqlName("SC9") + " SC9	"
	clQry += " INNER JOIN "+RetSqlName("SC6") + " SC6 "
	clQry += " ON SC6.C6_NUM = SC9.C9_PEDIDO "
	clQry += " AND SC6.C6_FILIAL = SC9.C9_FILIAL "
	clQry += " AND SC6.C6_PRODUTO = SC9.C9_PRODUTO "
	clQry += " AND SC6.C6_CLI = SC9.C9_CLIENTE "
	clQry += " AND SC6.C6_LOJA = SC9.C9_LOJA "
	clQry += " AND SC6.C6_ITEM = SC9.C9_ITEM "
	clQry += " AND SC6.C6_LOCAL IN " + FORMATIN(clArmz,"/") //SOMENTE ITENS COM OS ARMAZENS CONTROLADOS PELO WMS (MV_ARMWMAS) DEVEM SER EXPORTADOS PARA O WMS
	clQry += " AND SC6.D_E_L_E_T_ = ' ' "
	
	clQry += " INNER JOIN "+RetSqlName("SF4") + " SF4 "
	clQry += " ON SF4.F4_FILIAL = '" + xFilial("SF4") + "'"
	clQry += " AND SF4.F4_CODIGO = SC6.C6_TES "
	clQry += " AND SF4.F4_ESTOQUE = 'S' " //SOMENTE ITENS QUE MOVIMENTEM ESTOQUE DEVEM SER EXPORTADORS PARA O WMS
	clQry += " AND SF4.D_E_L_E_T_ = ' ' "
	
	clQry += " INNER JOIN "+RetSqlName("SB1") + " SB1 "
	clQry += " ON SB1.B1_FILIAL = '" + xFilial("SB1") + "'"
	clQry += " AND SB1.B1_COD = SC9.C9_PRODUTO "
	clQry += " AND SB1.B1_TIPO = 'PA' " //SOMENTE PRODUTOS DO TIPO PA DEVEM SER EXPORTADOS PARA O WMS
	clQry += " AND SB1.D_E_L_E_T_ = ' ' "
	
	clQry += " WHERE SC9.C9_FILIAL = '" + clFil + "'"
	clQry += " AND SC9.C9_CLIENTE = '" + clCli + "'"
	clQry += " AND SC9.C9_PEDIDO = '" + clPedido + "'"
	clQry += " AND SC9.C9_LOJA = '" + clLoja + "'"
	clQry += " AND  ( C9_BLEST = ' ' OR C9_BLEST  = '10' OR C9_BLEST  = 'ZZ' ) " // O ITEM NAO PODE ESTAR BLOQUEADO POR ESTOQUE
	//clQry += " AND SC9.C9_BLCRED <> '09' AND SC9.C9_BLCRED <> ' ' AND SC9.C9_BLCRED<>'10' AND SC9.C9_BLCRED<>'ZZ' "
	clQry += " AND SC9.C9_BLCRED = ' ' "
	clQry += " AND SC9.D_E_L_E_T_ = ' ' "
	
	clQry += " ORDER BY C9_PEDIDO,C9_ITEM "
	
	Iif(Select(cAlias) > 0,(cAlias)->(dbCloseArea()),Nil)
	
	DbUseArea(.T.,'TOPCONN',TCGENQRY(,,clQry),cAlias,.F.,.T.)
	
	DBSelectArea("P0A")
	P0A->(DBSetOrder(1))
	
	Begin Transaction
	
	If (cAlias)->(!EOF())
		While (cAlias)->(!EOF())
			//tratamento para não enviar produtos duplicados
			If (nPos := Ascan( aItePed, { |x| clFil+clPedido+(cAlias)->C9_PRODUTO $ x[1] } ) ) == 0
				lEnvia	:= .T.
				aadd(aItePed,{clFil+clPedido+(cAlias)->C9_PRODUTO,1})
			Else
				lEnvia	:= .F.
				aItePed[nPos,2] += 1
			EndIf
			
			If lEnvia
				
				SC9->(DbGoTo( (cAlias)->RECSC9)  )
				If !Empty(SC9->C9_BLEST)
					U_COM08SEND("Produto:"+AllTrim((cAlias)->C9_PRODUTO)+" item "+(cAlias)->C9_ITEM+" do Pedido:"+clPedido+" enviado para o WMS com C9_BLEST='"+SC9->C9_BLEST+".", "P0A_CHAVE="+clFil+clPedido+(cAlias)->C9_ITEM+(cAlias)->C9_PRODUTO, , "cleverson.silva@acpd.com.br")
				EndIf
				If P0A->(RecLock("P0A",.T.))
					P0A->P0A_FILIAL	:= xFilial("P0A")
					P0A->P0A_CHAVE	:= clFil+clPedido+(cAlias)->C9_ITEM+(cAlias)->C9_PRODUTO
					P0A->P0A_TABELA	:= "SC6"
					P0A->P0A_EXPORT := '9'
					P0A->P0A_INDICE	:= 'C6_FILIAL+C6_NUM+C6_ITEM+C6_PRODUTO'
					P0A->P0A_TIPO	:= '1'
					U_PR105LogP0A()
					//P0A->(MsUnlock())
				EndIF
			EndIf
			llSc5 := .T.
			
			(cAlias)->(DBSkip())
		EndDO
	EndIF
	
	If llSc5
		
		//caso o pedido já tenha sido excluido do WMS uma vez, ao liberar novamente o pedido, será excluida a confirmação do cancelamento anterior no WMS
		cQry2	:= " SELECT STATUS STATWMS FROM WMS.TB_WMSINTERF_CANC_ENT_SAI WHERE CES_COD_CHAVE = '"+ALLTRIM(clFil+clPedido)+"'
		Iif(Select(cAliasCES) > 0,(cAliasCES)->(dbCloseArea()),Nil)
		DbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQry2),cAliasCES,.F.,.T.)
		While (cAliasCES)->(!eof())
			If alltrim((cAliasCES)->STATWMS) <> "P"
				cQry2	:= " DELETE FROM WMS.TB_WMSINTERF_CANC_ENT_SAI WHERE CES_COD_CHAVE = '"+ALLTRIM(clFil+clPedido)+"'
				If TcSqlExec(cQry2) >= 0
					TcSqlExec("COMMIT")
					conout("Interface de cancelamento de entrada e saída excluido para o pedido: "+clFil+clPedido)
				Endif
			EndIf
			(cAliasCES)->(dbskip())
		End
		
		Iif(Select(cAliasCES) > 0,(cAliasCES)->(dbCloseArea()),Nil)
		//***********************************************************************************************************************************************
		If P0A->(RecLock("P0A",.T.))
			
			P0A->P0A_FILIAL	:= xFilial("P0A")
			P0A->P0A_CHAVE	:= clFil+clPedido
			P0A->P0A_TABELA	:= "SC5"
			P0A->P0A_EXPORT 	:= '9'
			P0A->P0A_INDICE	:= 'C5_FILIAL+C5_NUM'
			P0A->P0A_TIPO		:= '1'
			lGravouP0A			:= .T.
			
			U_PR105LogP0A()
			//P0A->(MsUnlock())
		EndIF
	EndIF
	
	MsUnLockAll()
	End Transaction
	
	TcSqlExec("UPDATE "+RetSqlName("P0A")+" SET P0A_EXPORT = '2' WHERE P0A_FILIAL='"+xFilial("P0A")+"' And P0A_CHAVE LIKE '"+clFil+clPedido+"%' And D_E_L_E_T_=' ' And P0A_EXPORT='9'")
	TcSqlExec("Commit")
	
	
	
	P0A->(DBCloseArea())
EndIF


If lWmsStore .And. lGravouP0A
	SC5->( U_PR109Grv("SC5",C5_FILIAL+C5_NUM,"3"))
EndIf

If AllTrim(SC5->C5_YORIGEM)=="WM"
	U_WM001Cred(IIf(cOpcao==1,"A","R"))
EndIf
RestArea(clArea)

Return .T.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MTA450CL  ºAutor  ³Microsiga           º Data ³  05/15/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function VerWMS(cFilPV,cNumPV)

Local aAreaAtu	:= GetArea()
Local aAreaP0A	:= P0A->( GetArea() )
Local cAliasQry	:= GetNextAlias()
Local cQuery		:= ""
Local cErro		:= ""
Local cMensagem	:= ""

cQuery:=" SELECT DOC.DPCS_NUM_DOCUMENTO PEDIDO,
cQuery+=" CASE WHEN DOC.STATUS IN('P','NP','ER','FR') THEN 'S' ELSE 'N' END WMS,
cQuery+=" DECODE(SEP.STATUS,'NP','S','P','LF',NULL,'NS') SEPARACAO
cQuery+=" FROM WMS.TB_WMSINTERF_DOC_SAIDA DOC
cQuery+=" LEFT JOIN WMS.TB_WMSINTERF_CONF_SEPARACAO SEP ON DOC.DPCS_NUM_DOCUMENTO = SEP.CS_NUM_DOCUMENTO
cQuery+=" WHERE DOC.DPCS_NUM_DOCUMENTO = '"+cNumPV+"'"

DbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQuery),cAliasQry,.F.,.T.)

If (cAliasQry)->( !Eof() .And. !Bof() )                
	cMensagem:="Ocorreu uma (re)liberacao do Pedido de Venda "+cFilPV+cNumPV+" que já se encontrava no WMS."+CHR(13)+CHR(10)+" Verique a necessidade de exclusao do WMS."
	U_MySndMail("Erro Integração WMS("+cNumPV+")",cMensagem, {}, "jisidoro@ncgames.com.br;lfelipe@ncgames.com.br;fbborges@ncgames.com.br", "rciambarella@ncgames.com.br", cErro)
EndIf

(cAliasQry)->(DbCloseArea())

RestArea(aAreaP0A)
RestArea(aAreaAtu)

Return
