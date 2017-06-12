#INCLUDE "RWMAKE.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MT450FIM  ºAutor  ³Paulo Palhares      º Data ³  14/05/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³  Ponto de entrada para gravar informações após a liberação º±±
±±º          ³  de crédito                                                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function MT450FIM(cPedido)

Local cPedido 	:= SC9->C9_PEDIDO
LOCAL CCODBLOQ	:= ""
Local cMensagem	:= ""
Local clArea	:= GetArea()
Local llSc5		:= .F.
Local clFil		:= SC5->C5_FILIAL
Local clPedido	:= SC5->C5_NUM
Local clCli		:= SC5->C5_CLIENTE
Local clLoja	:= SC5->C5_LOJACLI
Local clTipoPed	:= SC5->C5_TIPO
Local clArmz	:= SuperGetMV("MV_ARMWMAS")
Local cFiliais	:= SuperGetMV("NCG_000030",.F.,"03")
Local cFilStore := Alltrim(U_MyNewSX6("ES_NCG0000","06","C","Filiais que utilizam WMS Store","","",.F. ))
Local lWmsStore := (cFilAnt$cFilStore)
Local cAlias	:= GetNextAlias()
Local cAliasCES	:= GetNextAlias()
Local clQry		:= ""
Local aItePed	:= {}
Local lEnvia	:= .T.
             

TCSQLEXEC("UPDATE SC9010 SET C9_ULIBCRD='"+alltrim(cUsername)+"', C9_DTLICRD=to_char(sysdate,'yyyymmdd') where c9_filial='"+xFilial("SC9")+"' and c9_pedido='"+alltrim(cPedido)+"'")
TCSQLEXEC("COMMIT")
TCSQLEXEC("UPDATE SC5010 SET C5_TRAK='LIBFIN' where c5_filial='"+xFilial("SC5")+"' and c5_num='"+alltrim(cPedido)+"'")
TCSQLEXEC("COMMIT")

cMensagem:="LIBERADO PELO FINANCEIRO"

If IsInCallStack("U_NCGJ001")
	cMensagem:="LIBERADO PELO FINANCEIRO PELA FILIAL"
EndIf

U_Z7Status(xFilial("SZ7"),cPedido,"000006",cMensagem,SC9->C9_CLIENTE)

dbSelectArea("SC6")
SC6->(dbSetOrder(1))
SC6->(dbSeek(xFilial("SC6")+SC5->C5_NUM))

//aNaoWMS	:= {}
aVaiWMS	:= {}
WHILE SC6->(!EOF()) .AND. SC5->C5_NUM == SC6->C6_NUM
	//Verificação se vai para o WMS
	cAtuEst	:= getadvfval("SF4","F4_ESTOQUE",xFilial("SF4")+SC6->C6_TES,1,"")
	//	If SC6->C6_LOCAL $ GETMV("MV_ARMWMAS") .and. cAtuEst == "S"
	If cAtuEst == "S"
		TCSQLEXEC("UPDATE SC9010 SET C9_BLWMS = '02' WHERE C9_FILIAL='"+xFilial("SC9")+"' and C9_PEDIDO='"+alltrim(cPedido)+"' AND C9_BLCRED = ' ' AND C9_BLEST = ' '")
		
		TCSQLEXEC("COMMIT")
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

IF DBSEEK(XFILIAL("SC9")+SC5->C5_NUM+SC6->C6_ITEM)
	RECLOCK("SC5")
	SC5->C5_CODBL:= POSICIONE("SC9",1,XFILIAL("SC9")+SC5->C5_NUM,"C9_BLCRED")
	SC5->(MSUNLOCK())
Endif
dbSelectArea("SC6")
SC6->(dbSetOrder(1))
SC6->(dbSeek(xFilial("SC6")+SC5->C5_NUM))

CODARM := 0

CPED := SC5->C5_NUM

//se tiver produto que vai para o WMS, ativa a interface de integração
If len(aVaiWMS) > 0  .and. EMPTY(CCODBLOQ)
	//	U_INTPEDVEN(CPED) //ACRESCENTADO POR ERICH BUTTNER 25/04/11 - PROJETO DE INTEGRAÇÃO COM O WMAS
	
	TCSQLEXEC("UPDATE SC9010 SET C9_BLWMS='02' WHERE C9_FILIAL='"+xFilial("SC9")+"' and C9_PEDIDO='"+alltrim(CPED)+"'")
	
	TCSQLEXEC("COMMIT")
EndIf

//tratamento para limpeza da analise do crédito
DbSelectArea("SC5")
DbSetOrder(1)
If DbSeek(xFilial("SC5")+CPED)
	RECLOCK("SC5",.F.)
	SC5->C5_YOBSFIN	:= ""
	SC5->C5_YTEMOBS	:= ""
	SC5->C5_YFINOBS	:= ""
	SC5->C5_YDLIMIT	:= CTOD("  /  /  ")
	MSUNLOCK()
EndIf

If ( lWmsStore .Or. clFil $ FormatIN(cFiliais,"|") ) .and. !(clTipoPed $ 'CIP')
	
	
	U_PR106ExcP0A(clFil,clPedido)
	
	//clQry := " SELECT C6_ITEM,C6_PRODUTO FROM "+RetSqlName("SC6") + " SC6 "
	clQry := " SELECT C6_ITEM,C6_PRODUTO,SC9.R_E_C_N_O_  RECSC9 "
	
	clQry += " FROM "+RetSqlName("SC6") + " SC6 "
	clQry += " INNER JOIN "+RetSqlName("SC9") + " SC9	"
	clQry += " ON SC9.C9_PEDIDO = SC6.C6_NUM "
	clQry += " AND SC9.C9_FILIAL = SC6.C6_FILIAL "
	clQry += " AND SC9.C9_PRODUTO = SC6.C6_PRODUTO "
	clQry += " AND SC9.C9_CLIENTE = SC6.C6_CLI "
	clQry += " AND SC9.C9_LOJA = SC6.C6_LOJA "
	clQry += " AND SC9.C9_ITEM = SC6.C6_ITEM "
	clQry += " AND SC9.D_E_L_E_T_ = ' ' "
	
	clQry += " INNER JOIN "+RetSqlName("SB1") + " SB1	"
	clQry += " ON SB1.B1_COD = SC6.C6_PRODUTO "
	clQry += " AND SB1.B1_FILIAL = '" + xFilial("SB1") + "'"
	clQry += " AND SB1.B1_TIPO = 'PA' "  //SOMENTE PRODUTOS DO TIPO PA DEVEM SER EXPORTADOS PARA O WMS
	clQry += " AND SB1.D_E_L_E_T_ = ' ' "
	
	clQry += " INNER JOIN "+RetSqlName("SF4") + " SF4	"
	clQry += " ON SF4.F4_CODIGO = SC6.C6_TES "
	clQry += " AND SF4.F4_FILIAL = '" + xFilial("SF4") + "'"
	clQry += " AND SF4.F4_ESTOQUE = 'S' " //SOMENTE ITENS QUE MOVIMENTEM ESTOQUE DEVEM SER EXPORTADORS PARA O WMS
	clQry += " AND SF4.D_E_L_E_T_ = ' ' "
	
	clQry += " WHERE SC6.C6_FILIAL = '" + clFil + "'"
	clQry += " AND SC6.C6_NUM = '" + clPedido + "'"
	clQry += " AND SC6.C6_CLI = '" + clCli + "'"
	clQry += " AND SC6.C6_LOJA = '" + clLoja + "'"
	clQry += " AND SC6.C6_LOCAL IN " + FORMATIN(clArmz,"/") //SOMENTE ITENS COM OS ARMAZENS CONTROLADOS PELO WMS (MV_ARMWMAS) DEVEM SER EXPORTADOS PARA O WMS
	clQry += " AND  ( C9_BLEST = ' ' OR C9_BLEST  = '10' OR C9_BLEST  = 'ZZ' ) " // O ITEM NAO PODE ESTAR BLOQUEADO POR ESTOQUE
	//clQry += " AND SC9.C9_BLCRED <> '09' AND SC9.C9_BLCRED <> ' ' AND SC9.C9_BLCRED<>'10' AND SC9.C9_BLCRED<>'ZZ' "
	clQry += " AND SC9.C9_BLCRED = ' ' "
	clQry += " AND SC6.D_E_L_E_T_ = ' ' "
	clQry += " ORDER BY C6_ITEM "
	
	Iif(Select(cAlias) > 0,(cAlias)->(dbCloseArea()),Nil)
	DbUseArea(.T.,'TOPCONN',TCGENQRY(,,clQry),cAlias,.F.,.T.)
	
	DBSelectArea("P0A")
	P0A->(DBSetOrder(1))
	
	Begin Transaction
	
	If (cAlias)->(!EOF())
		While (cAlias)->(!EOF())
			//tratamento para não enviar produtos duplicados
			If (nPos := Ascan( aItePed, { |x| clFil+clPedido+(cAlias)->C6_PRODUTO $ x[1] } ) ) == 0
				lEnvia	:= .T.
				aadd(aItePed,{clFil+clPedido+(cAlias)->C6_PRODUTO,1})
				SC9->(DbGoTo( (cAlias)->RECSC9)  )
				If !Empty(SC9->C9_BLEST)
					U_COM08SEND("Produto:"+AllTrim((cAlias)->C6_PRODUTO)+" item "+(cAlias)->C6_ITEM+" do Pedido:"+clPedido+" enviado para o WMS com C9_BLEST='"+SC9->C9_BLEST+".", "P0A_CHAVE="+clFil+clPedido+(cAlias)->C6_ITEM+(cAlias)->C6_PRODUTO, , "cleverson.silva@acpd.com.br")
				EndIf
				
				P0A->(RecLock("P0A",.T.))
				P0A->P0A_FILIAL	:= xFilial("P0A")
				P0A->P0A_CHAVE		:= clFil+clPedido+(cAlias)->C6_ITEM+(cAlias)->C6_PRODUTO
				P0A->P0A_TABELA	:= "SC6"
				P0A->P0A_EXPORT 	:= '9'
				P0A->P0A_INDICE	:= 'C6_FILIAL+C6_NUM+C6_ITEM+C6_PRODUTO'
				P0A->P0A_TIPO		:= '1'
				U_PR105LogP0A()
				llSc5 := .T.
			Else
				aItePed[nPos,2] += 1
			EndIf
			
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
		
		P0A->(RecLock("P0A",.T.))
		P0A->P0A_FILIAL	:= xFilial("P0A")
		P0A->P0A_CHAVE	:= clFil+clPedido
		P0A->P0A_TABELA	:= "SC5"
		P0A->P0A_EXPORT := '9'
		P0A->P0A_INDICE	:= 'C5_FILIAL+C5_NUM'
		P0A->P0A_TIPO	:= '1'      
		
		U_PR105LogP0A()
	EndIf
	
	MsUnLockAll()
	
	End Transaction
	
	If llSc5
		
		TcSqlExec("UPDATE "+RetSqlName("P0A")+" SET P0A_EXPORT = '2' WHERE P0A_FILIAL='"+xFilial("P0A")+"' And P0A_CHAVE LIKE '"+clFil+clPedido+"%' And D_E_L_E_T_=' ' And P0A_EXPORT='9'")
		
		If lWmsStore
			SC5->( U_PR109Grv("SC5",C5_FILIAL+C5_NUM,"3"))
		EndIf
		TcSqlExec("Commit")
	EndIf
	
	P0A->(DBCloseArea())
	
EndIF

RestArea(clArea)

If !IsInCallStack("U_NCGJ001") .And. !IsInCallStack("U_NCECOM08")
	U_NCGA001( /*ParamIxb[1]*/ cPedido,xFilial("SC5") )
EndIf

If AllTrim(SC5->C5_YORIGEM)=="WM"
	U_WM001WMS(SC5->C5_NUM)
EndIf

Return
