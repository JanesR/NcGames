#INCLUDE "PROTHEUS.CH"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCECOM10  �Autor  � Elton C.		     � Data �  28/01/14   ���
�������������������������������������������������������������������������͹��
���Desc.     � Rotina utilizada pra verificar se a nota fiscal � referente���
���			 � pedido do ECOMMERCE, para que possa efetuar a compensa��o  ���
���			 � do titulo RA (Recebimento Antecipado)       			   	  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function NCECOM10(cDoc, cSerie, cCliente, cLoja,cTransp)

	Local aArea 	:= GetArea()
	Local cQuery	:= ""
	Local cArqTmp	:= GetNextAlias()

	Default cDoc		:= ""
	Default cSerie		:= ""
	Default cCliente	:= ""
	Default cLoja		:= ""

	cQuery	:= " SELECT F2_DOC, F2_SERIE, F2_CLIENTE, F2_LOJA, D2_PEDIDO, ZC5_NUM, ZC5_NUMPV "+CRLF
	cQuery	+= "       FROM "+RetSqlName("SF2")+" SF2 "+CRLF

	cQuery	+= " INNER JOIN "+RetSqlName("SD2")+" SD2 "+CRLF
	cQuery	+= " ON SD2.D_E_L_E_T_ = ' ' "+CRLF
	cQuery	+= " AND SD2.D2_FILIAL = SF2.F2_FILIAL "+CRLF
	cQuery	+= " AND SD2.D2_DOC = SF2.F2_DOC "+CRLF
	cQuery	+= " AND SD2.D2_SERIE = SF2.F2_SERIE "+CRLF
	cQuery	+= " AND SD2.D2_CLIENTE = SF2.F2_CLIENTE "+CRLF
	cQuery	+= " AND SD2.D2_LOJA = SF2.F2_LOJA "+CRLF

	cQuery	+= " INNER JOIN "+RetSqlName("ZC5")+" ZC5 "+CRLF
	cQuery	+= " ON ZC5.D_E_L_E_T_ = ' ' "+CRLF
	cQuery	+= " AND ZC5.ZC5_FILIAL = '"+xFilial("ZC5")+"' "+CRLF
	cQuery	+= " AND ZC5.ZC5_NUMPV = SD2.D2_PEDIDO "+CRLF

	cQuery	+= " WHERE SF2.D_E_L_E_T_ = ' ' "+CRLF
	cQuery	+= " AND SF2.F2_FILIAL = '"+xFilial("SF2")+"' "+CRLF
	cQuery	+= " AND SF2.F2_DOC = '"+cDoc+"' "+CRLF
	cQuery	+= " AND SF2.F2_SERIE = '"+cSerie+"' "+CRLF
	cQuery	+= " AND SF2.F2_CLIENTE = '"+cCliente+"' "+CRLF
	cQuery	+= " AND SF2.F2_LOJA = '"+cLoja+"' "+CRLF

	cQuery	:= ChangeQuery(cQuery)

	dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)

	(cArqTmp)->(DbGoTop())
	If (cArqTmp)->(!Eof())

	//Chama a rotina para atualizar a tabela ZC5, com o numero da nota fisca de saida
		AtuZC5((cArqTmp)->ZC5_NUM, (cArqTmp)->ZC5_NUMPV, cDoc, cSerie,"16",cTransp)

	//Chamar a rotina para gravar mensagem de log da nota fiscal de saida                                                        
		U_NCECOM09((cArqTmp)->ZC5_NUM, (cArqTmp)->ZC5_NUMPV,"Inclus�o Nota Fiscal de Sa�da","Nota fiscal "+Alltrim(cDoc)+"/"+Alltrim(cSerie)+" de sa�da inclu�da com sucesso ","",.T.,,,ZC5->ZC5_PVVTEX)
    
	//Atualiza o status atual do pedido (NF Emitida aguardando expedi��o)
		U_NCEC10CI((cArqTmp)->ZC5_NUM, "010",ZC5->ZC5_PVVTEX)
 
 	//Chama a rotina para gravar os dados referentes os titulos gerados na nota fiscal de e-commerce
		NCGRVZC8((cArqTmp)->F2_DOC, (cArqTmp)->F2_SERIE, (cArqTmp)->F2_CLIENTE, F2_LOJA, (cArqTmp)->ZC5_NUM, (cArqTmp)->ZC5_NUMPV)
	
	EndIf

	(cArqTmp)->(DbCloseArea())

	RestArea(aArea)
Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCECOM1D  �Autor  � Elton C.		     � Data �  28/01/14   ���
�������������������������������������������������������������������������͹��
���Desc.     � Rotina utilizada na devolu��o de mercadoria					  ���
���			 �   																			  ���
���			 �        			     													  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function NCECOM1D(cDocDev, cSerieDev, cDoc, cSerie, cCliente, cLoja)

	Local aArea 	:= GetArea()
	Local cQuery	:= ""
	Local cArqTmp	:= GetNextAlias()

	Default cDocDev	:= ""
	Default cSerieDev := ""
	Default cDoc		:= ""
	Default cSerie		:= ""
	Default cCliente	:= ""
	Default cLoja		:= ""


	cQuery	:= " SELECT F2_DOC, F2_SERIE, D2_PEDIDO, ZC5.R_E_C_N_O_ RECNOZC5 FROM "+RetSqlName("SF2")+" SF2 "+CRLF
 
	cQuery	+= "  INNER JOIN "+RetSqlName("SD2")+" SD2 "+CRLF
	cQuery	+= "   ON SD2.D_E_L_E_T_ = ' ' "+CRLF
	cQuery	+= "   AND SD2.D2_FILIAL = SF2.F2_FILIAL "+CRLF
	cQuery	+= "   AND SD2.D2_DOC = SF2.F2_DOC "+CRLF
	cQuery	+= "   AND SD2.D2_SERIE = SF2.F2_SERIE "+CRLF
	cQuery	+= "   AND SD2.D2_CLIENTE = SF2.F2_CLIENTE "+CRLF
	cQuery	+= "   AND SD2.D2_LOJA = SF2.F2_LOJA "+CRLF
 
	cQuery	+= "   INNER JOIN "+RetSqlName("ZC5")+" ZC5 "+CRLF
	cQuery	+= "   ON ZC5.D_E_L_E_T_ = ' ' "+CRLF
	cQuery	+= "   AND ZC5.ZC5_FILIAL = '"+xFilial("ZC5")+"' "+CRLF
	cQuery	+= "   AND ZC5.ZC5_NUMPV = SD2.D2_PEDIDO "+CRLF
 
	cQuery	+= "   WHERE SF2.D_E_L_E_T_ = ' ' "+CRLF
	cQuery	+= "   AND SF2.F2_FILIAL = '"+xFilial("SF2")+"' "+CRLF
	cQuery	+= "    AND SF2.F2_DOC = '"+cDoc+"' "+CRLF
	cQuery	+= "    AND SF2.F2_SERIE = '"+cSerie+"' "+CRLF
	cQuery	+= "    AND SF2.F2_CLIENTE = '"+cCliente+"' "+CRLF
	cQuery	+= "    AND F2_LOJA = '"+cLoja+"' "+CRLF

	cQuery	:= ChangeQuery(cQuery)

	dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)

	(cArqTmp)->(DbGoTop())
	If (cArqTmp)->(!Eof())
		DbSelectArea("ZC5")
		DbSetOrder(1)
		ZC5->(DbGoTo((cArqTmp)->RECNOZC5))
	//Informa ao site que o pedido foi devolvido
		Reclock("ZC5",.F.)
		ZC5->ZC5_STATUS := "91"
		ZC5->ZC5_DOCDEV := cDocDev
		ZC5->ZC5_SERDEV := cSerieDev
		ZC5->(MsUnLock())
	
		U_NCECOM09((cArqTmp)->ZC5_NUM, (cArqTmp)->ZC5_NUMPV,"Devolu��o",	"Devolu��o de efetuada com sucesso. Doc/Serie: "+Alltrim(cDocDev)+"/"+Alltrim(cSerieDev)	,"",.T.,,,ZC5->ZC5_PVVTEX)
	
	EndIf


	RestArea(aArea)
Return






/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �AtuZC5	  �Autor  �Elton C.		     � Data �  28/01/14   ���
�������������������������������������������������������������������������͹��
���Desc.     � Rotina utilizada para atualizar a tabela ZC5				  ���
���			 � 			      											  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function AtuZC5(nPedSite, cPedProth, cDoc, cSerie, cStatus,cTransp)

	Local aArea 		:= GetArea()
	Local cQuery    	:= ""
	Local cArqTmp	:= GetNextAlias()

	Default nPedSite	:= 0
	Default cPedProth	:= ""
	Default cDoc		:= ""
	Default cSerie		:= ""
	Default cStatus		:= ""

	cQuery    := " SELECT R_E_C_N_O_ RECNOZC5 FROM "+RetSqlName("ZC5")+" ZC5 "
	cQuery    += " WHERE ZC5.D_E_L_E_T_ = ' ' "
	cQuery    += " AND ZC5.ZC5_FILIAL = '"+xFilial("ZC5")+"' "
	cQuery    += " AND ZC5.ZC5_NUM = '"+Alltrim(Str(nPedSite))+"' "
	cQuery    += " AND ZC5.ZC5_NUMPV = '"+cPedProth+"' "

	dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)

	DbSelectArea("ZC5")
	DbSetOrder(1)
	SA4->(DbSetOrder(1))

	(cArqTmp)->(DbGoTop())
	While (cArqTmp)->(!Eof())

		ZC5->(DbGoTo((cArqTmp)->RECNOZC5))
		RecLock("ZC5",.F.)
		ZC5->ZC5_NOTA 		:= cDoc
		ZC5->ZC5_SERIE  	:= cSerie
		ZC5->ZC5_STATUS		:= cStatus
		If SA4->(MsSeek( xFilial("SA4")+cTransp)) .And. SA4->A4_ZCODCIA<>Val(ZC5->ZC5_CODENT)
			ZC5->ZC5_CODENT:=AllTrim(Str(SA4->A4_ZCODCIA))
		EndIf
		ZC5->(MsUnLock())
   
		(cArqTmp)->(DbSkip())
	EndDo


	(cArqTmp)->(DbCloseArea())

	RestArea(aArea)
Return




/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CompTCR  �Autor  �Elton C.		     � Data �  28/01/14   ���
�������������������������������������������������������������������������͹��
���Desc.     � Rotina utilizada para efetuar a compensa��o da   		  ���
���			 � RA (Recebimento Antecipado), efetuado no E-commerce.	 	  ���
���			 � Essa rotina tem o objetivo de baixar a primeira parcela.	  ���
���			 � As outras parcelas ser�o baixadas pro schedule de acordo   ���
���			 � com o vencimento										 	  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function CompTCR(nPedSite, cPedProth)

	Local aArea 	:= 	GetArea()
	Local cQuery	:=  ""
	Local cArqTmp	:= GetNextAlias()
	Local lTitComp	:= .F.

	Default nPedSite	:= 0
	Default cPedProth	:= ""

	cQuery	:=  " SELECT ZC5.R_E_C_N_O_ RECNOZC5, ZC5.ZC5_PREFIX , ZC5.ZC5_TIT, ZC5.ZC5_PARC, 'RA' TIPOTIT, ZC5_NUM, ZC5_NUMPV,"+CRLF
	cQuery	+=  "        ZC8.R_E_C_N_O_ RECNOZC8, SE1.E1_PREFIXO, SE1.E1_NUM, SE1.E1_PARCELA, SE1.E1_TIPO FROM "+RetSqlName("ZC5")+" ZC5 "+CRLF

	cQuery	+=  " INNER JOIN "+RetSqlName("ZC8")+" ZC8 "+CRLF
	cQuery	+=  " ON ZC8.D_E_L_E_T_ = ' ' "+CRLF
	cQuery	+=  " AND ZC8.ZC8_FILIAL = ZC5.ZC5_FILIAL "+CRLF
	cQuery	+=  " AND ZC8.ZC8_PVECOM = ZC5.ZC5_NUM "+CRLF
	cQuery	+=  " AND ZC8.ZC8_PEDIDO = ZC5.ZC5_NUMPV "+CRLF
	cQuery	+=  " AND ZC8.ZC8_STATUS != '01' "+CRLF

	cQuery	+=  " INNER JOIN "+RetSqlName("SE1")+" SE1 "+CRLF
	cQuery	+=  " ON SE1.D_E_L_E_T_ = ' ' "+CRLF
	cQuery	+=  " AND SE1.E1_FILIAL = '"+xFilial("SE1")+"' "+CRLF
	cQuery	+=  " AND SE1.E1_PREFIXO = ZC8.ZC8_PREFIX "+CRLF
	cQuery	+=  " AND SE1.E1_NUM = ZC8.ZC8_TITULO "+CRLF
	cQuery	+=  " AND SE1.E1_PARCELA = ZC8.ZC8_PARCEL "+CRLF
	cQuery	+=  " AND SE1.E1_TIPO = ZC8.ZC8_TIPO "+CRLF
//cQuery	+=  " AND SE1.E1_VENCREA <= '"+DTOS(MsDate())+"' "+CRLF

	cQuery	+=  " WHERE ZC5.D_E_L_E_T_ = ' ' "+CRLF
	cQuery	+=  " AND ZC5.ZC5_FILIAL = '"+xFilial("ZC5")+"' "+CRLF
	cQuery	+=  "  AND ZC5.ZC5_NUM = '"+Alltrim(Str(nPedSite))+"' "+CRLF
	cQuery	+=  " AND ZC5.ZC5_NUMPV = '"+cPedProth+"' "+CRLF
	cQuery	+=  " ORDER BY E1_PARCELA, SE1.E1_PREFIXO, SE1.E1_NUM, SE1.E1_TIPO "+CRLF

	cQuery	:= ChangeQuery(cQuery)

	dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)

	DbSelectArea("ZC5")
	DbSetOrder(1)

	DbSelectArea("ZC8")
	DbSetOrder(1)

	DbSelectArea("SE1")
	DbSetOrder(1)

	(cArqTmp)->(DbGoTop())
	If (cArqTmp)->(!Eof())

	//Chama a rotina para efetuar a compensa��o do titulo 
		lTitComp	:= CompTitR((cArqTmp)->ZC5_PREFIX, (cArqTmp)->ZC5_TIT, (cArqTmp)->ZC5_PARC, (cArqTmp)->TIPOTIT,;//Dados do titulo do tipo RA
		(cArqTmp)->E1_PREFIXO, (cArqTmp)->E1_NUM, (cArqTmp)->E1_PARCELA, (cArqTmp)->E1_TIPO,;//Dados do titulo a ser baixado
		(cArqTmp)->ZC5_NUM, (cArqTmp)->ZC5_NUMPV )//Dados do pedido*/
	
		If lTitComp
			ZC8->(DbGoTo((cArqTmp)->RECNOZC8))
			RecLock("ZC8", .F.)
			ZC8->ZC8_STATUS := "01"
			ZC8->ZC8_OBS    := "Titulo compensado com sucesso"
			ZC8->(MsUnLock())
	 
			U_NCECOM09(nPedSite, cPedProth,"COMPENS_TITULO_RA","Erro na tentativa de compensar titulo. ","22",.T.,,,ZC5->ZC5_PVVTEX)
   
		Else
			ZC8->(DbGoTo((cArqTmp)->RECNOZC8))
			RecLock("ZC8", .F.)
			ZC8->ZC8_STATUS := "02"
			ZC8->ZC8_OBS    := "Erro na tentativa de compensar titulo. Entre em contato com o Administrador "
			ZC8->(MsUnLock())

			U_NCECOM09(nPedSite, cPedProth,"ERRO_COMPENS_TITULO_RA","Erro na tentativa de compensar titulo. ","23",.F.,,,ZC5->ZC5_PVVTEX)
	
		EndIf

	Else
		lTitComp := .F.
	EndIf


	(cArqTmp)->(DbCloseArea())

	RestArea(aArea)
Return lTitComp



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CompTitR  �Autor  �Elton C.		     � Data �  28/01/14   ���
�������������������������������������������������������������������������͹��
���Desc.     � Rotina utilizada para efetuar a compensa��o da   		  ���
���			 � RA (Recebimento Antecipado), efetuado no Ecommerce	 	  ���
���			 � 			  											      ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function CompTitR(cPrefRa, cNumRa, cParcRa, cTipoRA,;//Dados do titulo do tipo RA
	cPrefCR, cNumCR, cParcCR, cTipoCR,;//Dados do titulo a ser baixado
	nPediSite, cPedido )//Dados do pedido

	Local aArea 	:= GetArea()
	Local cQuery    := ""
	Local cArqTmp	:= GetNextAlias()
	Local aRecRA	:= {}
	Local aRecCR	:= {}
	Local lRet		:= .T.
	Local cMsgErr	:= ""

	Default cPrefRa 	:= ""
	Default cNumRa		:= ""
	Default cParcRa		:= ""
	Default cTipoRA		:= ""
	Default cPrefCR		:= ""
	Default cNumCR		:= ""
	Default cParcCR		:= ""
	Default cTipoCR 	:= ""
	Default nPediSite	:= 0
	Default cPedido 	:= ""


//Chama a rotina de valida��o dos parametros
	If VldParam(cPrefRa, cNumRa, cTipoRA,;//Dados do titulo do tipo RA
		cPrefCR, cNumCR, cTipoCR, @cMsgErr )//Dados do titulo a ser baixado
	
		cQuery := " SELECT R_E_C_N_O_ RECNOCP, 'RA' TIPO FROM "+RetSqlName("SE1")+" SE1RA "+CRLF
		cQuery += " WHERE SE1RA.D_E_L_E_T_ = ' ' "+CRLF
		cQuery += " AND SE1RA.E1_FILIAL = '"+xFilial("SE1")+"' "+CRLF
		cQuery += " AND SE1RA.E1_PREFIXO = '"+cPrefRa+"' "+CRLF
		cQuery += " AND SE1RA.E1_NUM = '"+cNumRa+"' "+CRLF
	
		If !Empty(cParcRa)
			cQuery += " AND SE1RA.E1_PARCELA = '"+cParcRa+"' "+CRLF
		EndIf
	
		cQuery += " AND SE1RA.E1_TIPO = '"+cTipoRA+"' "+CRLF
		cQuery += " AND SE1RA.E1_SALDO != '0' "+CRLF//Titulo em aberto
	
		cQuery += " UNION ALL "+CRLF
		cQuery += " SELECT R_E_C_N_O_ RECNOCP, 'CR' TIPO FROM "+RetSqlName("SE1")+" SE1CR "+CRLF
		cQuery += " WHERE D_E_L_E_T_ = ' ' "+CRLF
		cQuery += " AND SE1CR.E1_FILIAL = '"+xFilial("SE1")+"' "+CRLF
		cQuery += " AND SE1CR.E1_PREFIXO = '"+cPrefCR+"' "+CRLF
		cQuery += " AND SE1CR.E1_NUM = '"+cNumCR+"' "+CRLF
	
		If !Empty(cParcCR)
			cQuery += " AND SE1CR.E1_PARCELA = '"+cParcCR+"' "+CRLF
		EndIf
	
		cQuery += " AND SE1CR.E1_TIPO = '"+cTipoCR+"' "+CRLF
		cQuery += " AND SE1CR.E1_SALDO != '0' "+CRLF
	
		cQuery := ChangeQuery(cQuery)
	
		dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)
	
		(cArqTmp)->(DbGoTop())
		While (cArqTmp)->(!Eof())
		
		//Preenche os dados dos titulos a compensar
			If Alltrim((cArqTmp)->TIPO) == "RA"
				aadd(aRecRA,(cArqTmp)->RECNOCP)

			Else
				aadd(aRecCR,(cArqTmp)->RECNOCP)

			EndIf
		
		
			(cArqTmp)->(DbSkip())
		EndDo
	
	//Verifica se existe titulo a ser compensado
		If Len(aRecRA) > 0 .And. Len(aRecCR) > 0
			Begin Transaction
		
		//Chama a rotina para compensar o tituo a receber
				If !MaIntBxCR(3,aRecCR,,aRecRA,,{.F.,.F.,.F.,.F.,.F.,.F.},,,,,MsDate() )
	
			//Retorno da compensa��o
					lRet		:= .F.
				Else

			//Retorno da compensa��o
					lRet		:= .T.

				EndIf
		
			End Transaction
		EndIf
	
	Else
	
	//Retorno da compensa��o
		lRet		:= .F.

	EndIf


	(cArqTmp)->(DbCloseArea())
	RestArea(aArea)
Return lRet


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �VldParam  �Autor  �Elton C.		     � Data �  28/01/14   ���
�������������������������������������������������������������������������͹��
���Desc.     � rotina utilizada para eetuar valida��o dos parametros	  ���
���			 � obrigatorio da compensa��o de titulo					 	  ���
���			 � 			  											      ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function VldParam(cPrefRa, cNumRa, cTipoRA,;//Dados do titulo do tipo RA
	cPrefCR, cNumCR, cTipoCR, cMsgErr )//Dados do titulo a ser baixado


	Local aArea 	:= GetArea()
	Local cMsgAux	:= "Erro ao efetuar a compensa��o de titulo. Um ou mais campo obrigat�rios n�o preenchido: " +CRLF+CRLF
	Local lRet		:= .T.

	Default cPrefRa	:= ""
	Default cNumRa	:= ""
	Default cTipoRA	:= ""
	Default cPrefCR	:= ""
	Default cNumCR	:= ""
	Default cTipoCR	:= ""
	Default cMsgErr := ""
           

	If Empty(cPrefRa)
		cMsgErr	+= "Prefixo do titulo 'RA' n�o preenchido;"+CRLF
	EndIf

	If Empty(cNumRa)
		cMsgErr	+= "N�mero do titulo 'RA' n�o preenchido;"+CRLF
	EndIf
    
	If Empty(cTipoRA)
		cMsgErr	+= "Tipo do titulo'RA' n�o preenchido;"+CRLF
	EndIf
                           
	If Empty(cPrefCR)
		cMsgErr	+= "Prefixo do titulo a ser compensado n�o preenchido;"+CRLF
	EndIf

	If Empty(cNumCR)
		cMsgErr	+= "Numero do titulo a ser compensado n�o preenchido;"+CRLF
	EndIf

	If Empty(cTipoCR)
		cMsgErr	+= "Tipo do titulo a ser compensado n�o preenchido;"+CRLF
	EndIf
     
            
	If !Empty(cMsgErr)
		cMsgErr := cMsgAux + cMsgErr
		lRet 	:= .F.
	EndIf


	RestAreA(aArea)
Return lRet



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGRVZC8  �Autor  �Elton C.		     � Data �  28/01/14   ���
�������������������������������������������������������������������������͹��
���Desc.     � Grava os dados dos titulos gerados no ecommerce			  ���
���			 � 	  											      		  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function NCGRVZC8(cDoc, cSerie, cCliente, cLoja, nPedSite, cPedProth)

	Local aArea 	:=  GetArea()
	Local cQuery	:= ""
	Local cArqTmp	:= GetNextAlias()

	Default cDoc		:= ""
	Default cSerie		:= ""
	Default cCliente	:= ""
	Default cLoja		:= ""
	Default nPedSite	:= 0
	Default cPedProth	:= ""


	cQuery	:= " SELECT E1_PREFIXO, E1_NUM, E1_PARCELA, E1_TIPO, E1_VALOR, E1_SALDO, E1_VENCTO, E1_VENCREA FROM "+RetSqlName("SE1")+" SE1 "+CRLF

	cQuery	+= " WHERE SE1.D_E_L_E_T_ = ' ' "+CRLF
	cQuery	+= " AND SE1.E1_FILIAL  = '"+xFilial("SE1")+"' "+CRLF
	cQuery	+= " AND SE1.E1_NUM = '"+cDoc+"' "+CRLF
	cQuery	+= " AND SE1.E1_PREFIXO = '"+cSerie+"' "+CRLF
	cQuery	+= " AND SE1.E1_CLIENTE = '"+cCliente+"' "+CRLF
	cQuery	+= " AND SE1.E1_LOJA = '"+cLoja+"' "+CRLF
	cQuery	+= " AND NOT EXISTS (SELECT * FROM "+RetSqlName("ZC8")+" ZC8 "
	cQuery	+= "                   WHERE ZC8.D_E_L_E_T_ = ' ' "
	cQuery	+= "                   AND ZC8.ZC8_FILIAL = '"+xFilial("ZC8")+"' "
	cQuery	+= "                   AND ZC8.ZC8_PREFIX = SE1.E1_PREFIXO "
	cQuery	+= "                   AND ZC8.ZC8_TITULO = SE1.E1_NUM "
	cQuery	+= "                   AND ZC8.ZC8_PARCEL = SE1.E1_PARCELA "
	cQuery	+= "                   AND ZC8.ZC8_TIPO = SE1.E1_TIPO "
	cQuery	+= "                   ) "


	dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)

	DbSelectArea("ZC8")
	DbSetOrder(2)


//Grava os dados do titulo na tabela ZC8 (Controle de titulos do E-commerce)
	(cArqTmp)->(DbGoTop())
	While (cArqTmp)->(!Eof())

		Reclock("ZC8",.T.)
		ZC8->ZC8_FILIAL 	:= xFilial("ZC8")
		ZC8->ZC8_PVECOM 	:= nPedSite
		ZC8->ZC8_PEDIDO 	:= cPedProth
		ZC8->ZC8_PREFIX 	:= (cArqTmp)->E1_PREFIXO
		ZC8->ZC8_TITULO	:= (cArqTmp)->E1_NUM
		ZC8->ZC8_PARCEL	:= (cArqTmp)->E1_PARCELA
		ZC8->ZC8_TIPO		:= (cArqTmp)->E1_TIPO
		ZC8->ZC8_VALOR		:= (cArqTmp)->E1_VALOR
		ZC8->ZC8_SALDO		:= (cArqTmp)->E1_SALDO
		ZC8->ZC8_VENCTO	:= Stod((cArqTmp)->E1_VENCTO)
		ZC8->ZC8_VENREA	:= Stod((cArqTmp)->E1_VENCREA)

		ZC8->(MsUnlock())

		(cArqTmp)->(DbSkip())
	EndDo


	(cArqTmp)->(DbCloseArea())
	RestArea(aArea)
Return


/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Funcao    �EcoGerRA  � Autor � Elton C.		 � Data �  04/09/13   	  ���
�������������������������������������������������������������������������͹��
���Descricao �Rotina automatica para gerar a RA	 no modulo financeiro	  ���
���          �					  						  									  ���
�������������������������������������������������������������������������͹��
�����������������������������������������������������������������������������
/*/
User Function EcoGerRA(nPedSite, cPedProth, lCancel )

	Local aArea 	:= GetArea()
	Local aTitulo	:= {}
	Local cQuery	:= ""
	Local cArqTmp	:= GetNextAlias()
	Local cNumTit	:= ""
	Local cRet		:= ""
	Local nValor	:= 0
	Local cPrefixo  := U_MyNewSX6("EC_NCG0015",;
		"WEB",;
		"C",;
		"Prefixo utilizado na RA do E-commerce",;
		"Prefixo utilizado na RA do E-commerce",;
		"Prefixo utilizado na RA do E-commerce",;
		.F. )


	Local cHistNCC  := U_MyNewSX6("EC_NCG0016",;
		"RA E-commerce",;
		"C",;
		"Historico da RA para E-commerce",;
		"Historico da RA para E-commerce",;
		"Historico da RA para E-commerce",;
		.F. )

	Default nPedSite		:= 0
	Default cPedProth 	:= ""
	Default lCancel		:= .F.

	cQuery := " SELECT ZC5_NUM, ZC5_NUMPV, ZC5_CLIENT, ZC5_LOJA, ZC5_STATUS, ZC5_PAGTO, ZC5_NOTA, ZC5_SERIE, ZC5_TOTAL FROM "+RetSqlName("ZC5")+" ZC5 "+CRLF

	cQuery += " WHERE ZC5.D_E_L_E_T_ = ' ' "+CRLF
	cQuery += " AND ZC5.ZC5_FILIAL = '"+xFilial("ZC5")+"' "+CRLF
	cQuery += " AND ZC5.ZC5_NUM = '"+Alltrim(Str(nPedSite))+"' "+CRLF
	cQuery += " AND ZC5.ZC5_NUMPV = '"+cPedProth+"' "+CRLF
	cQuery += " AND ZC5.ZC5_PAGTO = '2' "+CRLF

	dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)

	If (cArqTmp)->(!Eof())
	
	//Valida��o antes de gerar o titulo RA
		If VldGerTit((cArqTmp)->ZC5_NUM, (cArqTmp)->ZC5_NUMPV, (cArqTmp)->ZC5_STATUS, (cArqTmp)->ZC5_PAGTO)
		
			If lCancel .Or. Aviso("Aten��o","Deseja gerar T�tulo do tipo RA - Recebimento Antecipado ?",{"Sim","N�o"},2) == 1
			
			//Verifica se o processo � de cancelamento
				If Alltrim((cArqTmp)->ZC5_STATUS) == "90"
				
					nValor := (cArqTmp)->ZC5_TOTAL
				
				Else//Faturamento parcial
				
				//Chama a rotina para retornar o valor do titulo no caso de faturamento parcial
					nValor := GetVlPvParc((cArqTmp)->ZC5_NUM, (cArqTmp)->ZC5_NUMPV)
				
				EndIf
			
				cNumTit := GetSXENum("SE1","E1_NUM")
			
			//Preenchiemnto do titulo (ra)
				AADD(aTitulo,	{"E1_PREFIXO"	,cPrefixo					,Nil})
				AADD(aTitulo,	{"E1_NUM"		,cNumTit						,Nil})
				AADD(aTitulo,	{"E1_PARCELA"	,"1"							,Nil})
				AADD(aTitulo,	{"E1_TIPO"		,"RA"							,Nil})
				AADD(aTitulo,	{"E1_CLIENTE"	,(cArqTmp)->ZC5_CLIENT	,Nil})
				AADD(aTitulo,	{"E1_LOJA"	   ,(cArqTmp)->ZC5_LOJA		,Nil})
				AADD(aTitulo,	{"E1_NOMCLI"	,Posicione("SA1",1,xFilial("SA1")+(cArqTmp)->ZC5_CLIENT+(cArqTmp)->ZC5_LOJA,"A1_NOME")	,Nil})
			//	AADD(aTitulo,	{"E1_NATUREZ"	,cNaturez					,Nil})
				AADD(aTitulo,	{"E1_EMISSAO" 	,MsDate()		 			,Nil})
				AADD(aTitulo,	{"E1_VENCTO" 	,MsDate()		  			,Nil})
				AADD(aTitulo,	{"E1_VENCREA" 	,MsDate()		  			,Nil})
				AADD(aTitulo,	{"E1_VALOR"		,nValor						,Nil})
				AADD(aTitulo,	{"E1_VLRREAL"	,nValor						,Nil})
				AADD(aTitulo,	{"E1_LA"			,"S"							,Nil})
				AADD(aTitulo,	{"E1_HIST"		,Alltrim(UPPER(cHistNCC))+ "- (Pedido Site: "+Alltrim(Str(nPedSite))+" Pedido Protheus: "+Alltrim(cPedProth)+") " ,Nil})
				AADD(aTitulo,	{"E1_ORIGEM"	,"ECOMMERCE"				,Nil})
			
			
			//Chama a rotina automatica para gerar a RA
				cRet := NCGerTRA(aTitulo, 3 )
			
			//Verifica se ocorreu algum erro na gera��o da RA
				If Empty(cRet)
				//Confirma o valor reservado para o titulo
					ConfirmSX8()
				
					U_NCECOM09(nPedSite, cPedProth,"Inclus�o Titulo RA","Titulo "+cNumTit+" do tipo RA inclu�do com sucesso ","",.T.)
				
				//Grava os dados na tabela ZC8 - Controle de Titulos
					GRVRAZC8(nPedSite, cPedProth, cPrefixo, cNumTit, "1", "RA", nValor)
				
				
				Else
					cRet := "Erro ao tentar criar RA para a NF de n.�: "+cDoc+"/"+cSerie+CRLF+CRLF+cRet
					U_NCECOM09(nPedSite, cPedProth,"Erro na inclus�o do titulo RA",cRet,"",.T.)
				
					RollBackSx8()
				EndIf
			
			EndIf

		EndIf
	
	Else
		Aviso("NOEXISTERA","N�o � poss�vel gerar RA. Verifique se o pagamento foi efetuado. ",{"Ok"},2)
		cRet := " N�o � poss�vel gerar RA. Verifique se o pagamento foi efetuado. "
	EndIf

	(cArqTmp)->(DbCloseArea())
	RestArea(aArea)
Return cRet



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �GRVRAZC8  �Autor  �Elton C.		     � Data �  28/01/14		  ���
�������������������������������������������������������������������������͹��
���Desc.     � Rotina utilizada para gravar os dados do titulo RA 		  ���
���			 � na tabela ZC8 -Controle de Titulos				      		  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function GRVRAZC8(nPedSite, cPedProth, cPref, cNum, cParc, cTipo, nValor)

	Local aArea 	:=  GetArea()

	Default nPedSite	:= 0
	Default cPedProth	:= ""
	Default cPref		:= ""
	Default cNum		:= ""
	Default cParc		:= ""
	Default cTipo		:= ""
	Default nValor		:= 0

	DbSelectArea("ZC8")
	DbSetOrder(1)

	Reclock("ZC8",.T.)
	ZC8->ZC8_FILIAL 	:= xFilial("ZC8")
	ZC8->ZC8_PVECOM 	:= nPedSite
	ZC8->ZC8_PEDIDO 	:= cPedProth
	ZC8->ZC8_PREFIX 	:= cPref
	ZC8->ZC8_TITULO	:= cNum
	ZC8->ZC8_PARCEL	:= cParc
	ZC8->ZC8_TIPO		:= cTipo
	ZC8->ZC8_VALOR		:= nValor
	ZC8->ZC8_SALDO		:= nValor
	ZC8->ZC8_VENCTO	:= MsDate()
	ZC8->ZC8_VENREA	:= MsDate()

	ZC8->(MsUnlock())

	RestArea(aArea)
Return



/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Funcao    �VldGerTit	  � Autor � 	Elton C.		 � Data �  04/09/13	  ���
�������������������������������������������������������������������������͹��
���Descricao �Verifica se j� foi gerado titulo RA para este pedido  		  ���
���          �					  						  				  					  ���
�������������������������������������������������������������������������͹��
�����������������������������������������������������������������������������
/*/
Static Function VldGerTit(nPedSite, cPedProth, cStatus, cPago)

	Local aArea 	:= GetArea()
	Local lRet		:= .T.
	Local cMsg		:= ""
	Local cMsgAux	:= ""

	Default nPedSite	:= 0
	Default cPedProth	:= ""
	Default cStatus	:= ""
	Default cPago		:= ""

//Verifica se o pedido est� pago
	If Alltrim(cPago) == "2"
	
	//Verifica se o pedido esta cancelado
		If  (Alltrim(cStatus) == "90")
	   
		//Verifica se j� existe titulo do tipo RA para este pedido
			If ( !VldExisTit(nPedSite, cPedProth))
				cMsgAux 	:= "J� existe titulo do tipo RA para este pedido. "
				lRet 		:= .F.
			Else
				lRet 		:= .T.
			EndIf
	
		ElseIf !VldPedParc(nPedSite, cPedProth)//Verifica se o pedido � parcial
			cMsgAux 	:= "N�o foi poss�vel gerar t�tulo do tipo RA. "+CRLF+CRLF
			cMsgAux 	+= " Obs. Procedimento efetuado apenas para pedido faturado parcialmente ou cancelado (Status = 90)."
 
			lRet 		:= .F.
	
		EndIf
	
	
	//Alerta ao usu�rio
		If !lRet
	  	
			Aviso("ERROGERRA",cMsgAux,{"Ok"},2)
	
		EndIf
	Else
		Aviso("ERROGERRA","N�o foi poss�vel gerar RA para o pedido "+Alltrim(cPedProth)+" (PV Site "+Alltrim(Str(nPedSite))+"). O pagamento n�o foi efetuado. ",{"Ok"},2)
		lRet 		:= .F.
	EndIf

	RestArea(aArea)
Return lRet


/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Funcao    �VldPedParc  � Autor � 	Elton C.		 � Data �  04/09/13	  ���
�������������������������������������������������������������������������͹��
���Descricao �Verifica se o pedido foi atendido parcialmente, para o 	  ���
���          �sistema gerar titulo do tipo RA  				  					  ���
�������������������������������������������������������������������������͹��
�����������������������������������������������������������������������������
/*/
Static Function VldPedParc(nPedSite, cPedProth)

	Local aArea 	:= GetArea()
	Local cQuery	:= ""
	Local cTmpArq	:= GetNextAlias()
	Local lRet		:= .F.

	Default nPedSite	:= 0
	Default cPedProth	:= ""


	cQuery := " SELECT ZC5_NUM, ZC5_NUMPV, ZC5_CLIENT, ZC5_LOJA, ZC5_STATUS, ZC5_PAGTO, ZC5_NOTA, "+CRLF
	cQuery += " ZC5_SERIE, ZC5_TOTAL, F2_VALBRUT FROM "+RetSqlName("ZC5")+" ZC5 "+CRLF

	cQuery += " INNER JOIN "+RetSqlName("SF2")+" SF2 "
	cQuery += " ON SF2.D_E_L_E_T_ = ' ' "
	cQuery += " AND SF2.F2_FILIAL = '"+xFilial("SF2")+"' "
	cQuery += " AND SF2.F2_DOC = ZC5.ZC5_NOTA "
	cQuery += " AND SF2.F2_SERIE = ZC5.ZC5_SERIE "
	cQuery += " AND SF2.F2_CLIENT = ZC5.ZC5_CLIENT "
	cQuery += " AND SF2.F2_LOJA = ZC5.ZC5_LOJA "

	cQuery += " WHERE ZC5.D_E_L_E_T_ = ' ' "
	cQuery += " AND ZC5.ZC5_FILIAL = '"+xFilial("ZC5")+"' "
	cQuery += " AND ZC5.ZC5_NUM = '"+Alltrim(Str(nPedSite))+"' "
	cQuery += " AND ZC5.ZC5_NUMPV = '"+cPedProth+"' "
	cQuery += " AND ZC5.ZC5_PAGTO = '2' "

	dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cTmpArq , .F., .T.)

	If (cTmpArq)->(!Eof())
	
	//Verifica se o valor do pedido � maior que o valor da Nota Fiscal de Saida. 
	// Se o valor for maior, ent�o a rotina retornar� .T. para gerar o titulo RA com o valor da diferen�a.	
		If (cTmpArq)->ZC5_TOTAL >  (cTmpArq)->F2_VALBRUT
			lRet := .T.
		EndIf
	
	EndIf

	(cTmpArq)->(DbCloseArea())
	RestArea(aArea)
Return lRet


/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Funcao    �GetVlPvParc  � Autor � 	Elton C.		 � Data �  04/09/13	  ���
�������������������������������������������������������������������������͹��
���Descricao �Retorna o valor a ser gerado no titulo RA para pedido	 	  ���
���          �faturado parcialmente				  				  					  ���
�������������������������������������������������������������������������͹��
�����������������������������������������������������������������������������
/*/
Static Function GetVlPvParc(nPedSite, cPedProth)

	Local aArea 	:= GetArea()
	Local cQuery	:= ""
	Local cTmpArq	:= GetNextAlias()
	Local nRet		:= 0

	Default nPedSite	:= 0
	Default cPedProth	:= ""


	cQuery := " SELECT ZC5_NUM, ZC5_NUMPV, ZC5_CLIENT, ZC5_LOJA, ZC5_STATUS, ZC5_PAGTO, ZC5_NOTA, "+CRLF
	cQuery += " ZC5_SERIE, ZC5_TOTAL, F2_VALBRUT FROM "+RetSqlName("ZC5")+" ZC5 "+CRLF

	cQuery += " INNER JOIN "+RetSqlName("SF2")+" SF2 "
	cQuery += " ON SF2.D_E_L_E_T_ = ' ' "
	cQuery += " AND SF2.F2_FILIAL = '"+xFilial("SF2")+"' "
	cQuery += " AND SF2.F2_DOC = ZC5.ZC5_NOTA "
	cQuery += " AND SF2.F2_SERIE = ZC5.ZC5_SERIE "
	cQuery += " AND SF2.F2_CLIENT = ZC5.ZC5_CLIENT "
	cQuery += " AND SF2.F2_LOJA = ZC5.ZC5_LOJA "

	cQuery += " WHERE ZC5.D_E_L_E_T_ = ' ' "
	cQuery += " AND ZC5.ZC5_FILIAL = '"+xFilial("ZC5")+"' "
	cQuery += " AND ZC5.ZC5_NUM = '"+Alltrim(Str(nPedSite))+"' "
	cQuery += " AND ZC5.ZC5_NUMPV = '"+cPedProth+"' "
	cQuery += " AND ZC5.ZC5_PAGTO = '2' "

	dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cTmpArq , .F., .T.)

	If (cTmpArq)->(!Eof())
	
		If (cTmpArq)->ZC5_TOTAL >  (cTmpArq)->F2_VALBRUT
			nRet := (cTmpArq)->ZC5_TOTAL - (cTmpArq)->F2_VALBRUT
		EndIf
	
	EndIf

	(cTmpArq)->(DbCloseArea())
	RestArea(aArea)
Return nRet



/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Funcao    �VldExisTit  � Autor � 	Elton C.		 � Data �  04/09/13	  ���
�������������������������������������������������������������������������͹��
���Descricao �Verifica se j� foi gerado titulo RA para este pedido  		  ���
���          �					  						  				  					  ���
�������������������������������������������������������������������������͹��
�����������������������������������������������������������������������������
/*/
Static Function VldExisTit(nPedSite, cPedProth)

	Local aArea 	:= GetArea()
	Local cQuery	:= ""
	Local cArqTmp	:= GetNextAlias()
	Local lRet		:= .T.

	Default nPedSite	:= 0
	Default cPedProth	:= ""

	cQuery	:= " SELECT COUNT(*) CONT_RA FROM "+RetSqlName("ZC8")+CRLF
	cQuery	+= "  WHERE D_E_L_E_T_ = ' ' "+CRLF
	cQuery	+= "  AND ZC8_PVECOM = '"+Alltrim(Str(nPedSite))+"' "+CRLF
	cQuery	+= "  AND ZC8_PEDIDO = '"+cPedProth+"' "+CRLF
	cQuery	+= "  AND ZC8_TIPO = 'RA' "+CRLF
	cQuery	+= "  AND ZC8_STATUS != '04' "+CRLF

	dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)


	If (cArqTmp)->CONT_RA >= 1
		lRet		:= .F.
	EndIf


	(cArqTmp)->(DbCloseArea())
	RestArea(aArea)
Return lRet

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Funcao    �NCGerTRA  � Autor � 	Elton C.		 � Data �  04/09/13   ���
�������������������������������������������������������������������������͹��
���Descricao �Rotina automatica para gerar a RA no modulo financeiro	  ���
���          �					  						  				  ���
�������������������������������������������������������������������������͹��
�����������������������������������������������������������������������������
/*/
Static Function NCGerTRA(aTitulo, nOpc )

	Local aArea 	:= GetArea()
	Local cRet		:= ""
	Local cMsgErro	:= ""

	Private lMsErroAuto := .F.

	Default aTitulo := {}
	Default nOpc	:= 3//Inclus�o

	Begin Transaction
		If (Len(aTitulo) > 0)
	
	//Chama a rotina automatica para gravar os dados da nota de entrada
			MsExecAuto({|x,y| Fina040(x,y)}, aTitulo, nOpc)
	
	//Verifica se ocorreru algum erro no processamento
			If lMSErroAuto
		
				cMsgErro := AllTrim(MemoRead(NomeAutoLog()))
				MemoWrite(NomeAutoLog()," ")
		
				cRet := cMsgErro
				DisarmTransaction()
		
			EndIf
	
		Else
			cRet := "Os dados informados est�o incorretos. Verifique o preenchimento do mesmo."
		EndIf

	End Transaction

	RestArea(aArea)
Return cRet




/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Funcao    �ECOBXTIT  � Autor � 	Elton C.				� Data �  04/09/13  ���
�������������������������������������������������������������������������͹��
���Descricao �Rotina utilizada em schedule para efetuar a baixa de 	 	  ���
���          �de titulos (Pago) gerados pelo E-commerce 						  ���
�������������������������������������������������������������������������͹��
�����������������������������������������������������������������������������
/*/
User Function ECOBXTIT(aEmpFil)

                     
	Local aArea 		:= {}
	Local cQuery 		:= ""
	Local cArqTmp  	:= ""
	Local lTitComp		:= .F.
	Local aTitBaix		:= {}
	Local cMsgBxTit   := ""
	Local aTitBxAux	:= {}
	Local cAssunto		:= "Baixa de Titulo(s) E-commerce"
	Local cBody			:= ""
	Local aAnexos		:= {}
	Local cEmailTo		:= U_MyNewSX6("EC_NCG0014",;
		"lfelipe@ncgames.com.br",;
		"C",;
		"E-mail de usu�rio - Titulos Baixados E-commerce",;
		"",;
		"E-mail de usu�rio - Titulos Baixados E-commerce",;
		.F. )

	Local cEmailCc		:= ""
	Local cErro			:= ""


	Default aEmpFil := {"01","03"}

//Chama a rotina para setar a empresa e filial
	If IsBlind()
		SetEmpFil( aEmpFil[1], aEmpFil[2] )
	EndIf

	aArea 	:= GetArea()
	cQuery 	:= ""
	cArqTmp  := GetNextAlias()
	lTitComp	:= .F.



	cQuery 	:= " SELECT E1_PREFIXO, E1_NUM, E1_PARCELA, E1_TIPO, E1_VENCTO, E1_VENCREA, SE1.R_E_C_N_O_ RECNOSE1, "+CRLF
	cQuery 	+= "        ZC8.R_E_C_N_O_ RECNOZC8, ZC8_PEDIDO, ZC8_PVECOM, ZC5_NUM, ZC5_NUMPV FROM "+RetSqlName("ZC8")+" ZC8 "+CRLF

	cQuery 	+= " INNER JOIN "+RetSqlName("ZC5")+" ZC5 "+CRLF
	cQuery 	+= " ON ZC5.D_E_L_E_T_ = ' ' "+CRLF
	cQuery 	+= " AND ZC5.ZC5_FILIAL = ZC8.ZC8_FILIAL "+CRLF
	cQuery 	+= " AND ZC5.ZC5_NUM = ZC8.ZC8_PVECOM "+CRLF
	cQuery 	+= " AND ZC5.ZC5_NUMPV = ZC8.ZC8_PEDIDO "+CRLF
	cQuery 	+= " AND ZC5.ZC5_PAGTO = '2' "+CRLF//Pagamento efetuado (Autorizado pelo moip)
	cQuery 	+= " AND ZC5.ZC5_DOCDEV = ' ' "+CRLF//Nota de devolu��o

	cQuery 	+= " INNER JOIN "+RetSqlName("SE1")+" SE1 "+CRLF
	cQuery 	+= " ON SE1.D_E_L_E_T_ = ' ' "+CRLF
	cQuery 	+= " AND SE1.E1_FILIAL = '"+xFilial("SE1")+"' "+CRLF
	cQuery 	+= " AND SE1.E1_PREFIXO = ZC8.ZC8_PREFIX  "+CRLF
	cQuery 	+= " AND SE1.E1_NUM = ZC8.ZC8_TITULO "+CRLF
	cQuery 	+= " AND SE1.E1_PARCELA = ZC8.ZC8_PARCEL "+CRLF
	cQuery 	+= " AND SE1.E1_TIPO = ZC8.ZC8_TIPO "+CRLF
	cQuery 	+= " AND SE1.E1_VENCREA <= '"+Dtos(MsDate())+"' "+CRLF

	cQuery 	+= " WHERE ZC8.D_E_L_E_T_ = ' ' "+CRLF
	cQuery 	+= " AND ZC8.ZC8_FILIAL = '"+xFilial("ZC8")+"' "+CRLF
	cQuery 	+= " AND ZC8.ZC8_STATUS NOT IN('01','04') "+CRLF//Pedido compensado e\ou excluido
	cQuery 	+= " AND ZC8.ZC8_TIPO != 'RA' "+CRLF

	dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)

	DbSelectArea("ZC5")
	DbSetOrder(1)

	DbSelectArea("SE1")
	DbSetOrder(1)

	DbSelectArea("ZC8")
	DbSetOrder(1)

	While (cArqTmp)->(!Eof())

		SE1->(DbGoTo((cArqTmp)->RECNOSE1))
 	
		aTitBaix := {}
 	
 	//Preenche o array com os dados a serem baixados
		AADD(aTitBaix, {"E1_PREFIXO"	, SE1->E1_PREFIXO		, Nil	} )
		AADD(aTitBaix, {"E1_NUM"		, SE1->E1_NUM			, Nil	} )
		AADD(aTitBaix, {"E1_PARCELA" 	, SE1->E1_PARCELA		, Nil	} )
		AADD(aTitBaix, {"E1_TIPO"		, SE1->E1_TIPO			, Nil	} )
		AADD(aTitBaix, {"E1_CLIENTE"	, SE1->E1_CLIENTE		, Nil	} )
		AADD(aTitBaix, {"E1_LOJA"		, SE1->E1_LOJA			, Nil	} )
		AADD(aTitBaix, {"AUTMOTBX"	   ,"NOR"            	, Nil } )
		AADD(aTitBaix, {"AUTDTBAIXA"	,MsDate()     			, Nil } )
		AADD(aTitBaix,	{"AUTHIST"	   ,"BX.E-COMMERCE PEDIDO: "+Alltrim(Str((cArqTmp)->ZC5_NUM)) ,Nil } )
		AADD(aTitBaix, {"AUTBANCO"		,"CX1"       			, Nil } )
		AADD(aTitBaix,	{"AUTAGENCIA"	,"00001"       		, Nil } )
		AADD(aTitBaix,	{"AUTCONTA"		,"0000000001"			, Nil } )
		AADD(aTitBaix,	{"AUTJUROS"		,0 						, Nil } )
		AADD(aTitBaix, {"AUTMULTA"		,0 						, Nil } )
		AADD(aTitBaix,	{"AUTCM1"		,0							, Nil } )
		AADD(aTitBaix,	{"AUTPRORATA"	,0 						, Nil } )
		AADD(aTitBaix,	{"AUTVALREC"	,SE1->E1_SALDO			, Nil } )
   
		cMsgBxTit := ""
		cMsgBxTit := BxTitEcom(aTitBaix, 3 )
		
		If Empty(cMsgBxTit)
			ZC8->(DbGoTo((cArqTmp)->RECNOZC8))
			RecLock("ZC8", .F.)
			ZC8->ZC8_STATUS := "01"
			ZC8->ZC8_OBS    := "Titulo baixado com sucesso"
			ZC8->(MsUnLock())
	 
			U_NCECOM09((cArqTmp)->ZC5_NUM, (cArqTmp)->ZC5_NUMPV,"Compensa��o de titulo","Titulo compensado com sucesso","22",.T.)
	   
	   
			Aadd(aTitBxAux,{Alltrim(Str((cArqTmp)->ZC5_NUM)),;//Pedido Site
			(cArqTmp)->ZC5_NUMPV,;//Pedido Protheus
			SE1->E1_PREFIXO,;//Prefixo
			SE1->E1_NUM,;//Titulo
			SE1->E1_PARCELA,;//Parcela
			SE1->E1_TIPO,;//Tipo
			Transform(SE1->E1_VALOR, "@E 999,999,999.99"),;//Valor
			Transform(SE1->E1_SALDO, "@E 999,999,999.99"),;//Saldo
			DTOC(SE1->E1_VENCREA),;
				DTOC(SE1->E1_BAIXA)} )
	   
		Else
			ZC8->(DbGoTo((cArqTmp)->RECNOZC8))
			RecLock("ZC8", .F.)
			ZC8->ZC8_STATUS := "02"
			ZC8->ZC8_OBS    := "Erro na tentativa de baixar titulo. Entre em contato com o Administrador "+CRLF+CRLF+cMsgBxTit
			ZC8->(MsUnLock())

			U_NCECOM09((cArqTmp)->ZC5_NUM, (cArqTmp)->ZC5_NUMPV,"Erro baixa de tiutlo","Erro na tentativa de baixar titulo. "+cMsgBxTit,"23",.F.)
	
		EndIf


		(cArqTmp)->(DbSkip())
	EndDo

//Envia e-mail ao Depto. Finaceiro, informando os titulo baixados
	If Len(aTitBxAux) > 0
	
	//Preenche o Html   
		cBody := u_ECOMHTM9(aTitBxAux, DtoC(MsDate()))
	
		U_COM08SEND(cAssunto, cBody, aAnexos, cEmailTo, cEmailCc, cErro)
	
	EndIf



	(cArqTmp)->(DbCloseArea())
	RestArea(aArea)
Return
               

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Funcao    �BxTitEcom  � Autor � 	Elton C.		 	� Data �  	04/09/13   ���
�������������������������������������������������������������������������͹��
���Descricao �Rotina automatica para baixar titulos do contas a receber   ���
���          �										  						  				  ���
�������������������������������������������������������������������������͹��
�����������������������������������������������������������������������������
/*/
Static Function BxTitEcom(aTitulo, nOpc )

	Local aArea 	:= GetArea()
	Local cRet		:= ""
	Local cMsgErro	:= ""

	Private lMsErroAuto := .F.

	Default aTitulo := {}
	Default nOpc	:= 3//Inclus�o

	Begin Transaction
		If (Len(aTitulo) > 0)
	
	//Chama a rotina automatica para gravar os dados da nota de entrada
			MsExecAuto({|x,y| Fina070(x,y)}, aTitulo, nOpc)
	
	//Verifica se ocorreru algum erro no processamento
			If lMSErroAuto
		
				cMsgErro := AllTrim(MemoRead(NomeAutoLog()))
				MemoWrite(NomeAutoLog()," ")
		
				cRet := cMsgErro
				DisarmTransaction()
		
			EndIf
	
		Else
			cRet := "Os dados informados est�o incorretos. Verifique o preenchimento do mesmo."
		EndIf

	End Transaction

	RestArea(aArea)
Return cRet


             

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �SetEmpFil �Autor  �Elton C.         	 �Fecha �  10/05/11   ���
�������������������������������������������������������������������������͹��
���Desc.     �Funcao utilizada para setar a empresa e filial	  	  	  ���
���			 |						                    				  ���
�������������������������������������������������������������������������͹��
���Uso       � AP 	                                                      ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function SetEmpFil(cYEmpresa, cYFilial)

	Default cYEmpresa := ""
	Default cYFilial  := ""

//Vai para empresa complemnetar
	RpcClearEnv()
	RpcSettype(3)
	RpcSetEnv(cYEmpresa,cYFilial)

Return


                 

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � NcAtuZc8 �Autor  �Elton C.         	 �Fecha �  10/05/11   ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina utilizada para alterar o status dos titulos	  	  	  ���
���			 |	na tabela ZC8		 			                    				  ���
�������������������������������������������������������������������������͹��
���Uso       � AP 	                                                      ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function NcAtuZc8(cPrefix, cNum, cParcela, cTipo, nOpc)

	Local aArea 	:= GetArea()
	Local cQuery   := ""
	Local cArqTmp	:= GetNextAlias()
	Local cComMsg	:= ""

	Default cPrefix	:= ""
	Default cNum		:= ""
	Default cParcela	:= ""
	Default cTipo		:= ""
	Default nOpc		:= 0//1=Baixa, 2=Exclus�o \ Cancelamento da baixa

//Complemento da menagem
	cComMsg += " Prefixo: "+cPrefix+CRLF
	cComMsg += " Titulo: "+cNum+CRLF
	cComMsg += " Parcela: "+cParcela+CRLF
	cComMsg += " Tipo: "+cTipo+CRLF

	cQuery   := " SELECT ZC8.R_E_C_N_O_ RECNOZC8, ZC8_PVECOM, ZC8_PEDIDO, E1_VALOR, E1_SALDO FROM "+RetSqlName("ZC8")+" ZC8 "+CRLF

	cQuery	+=  " INNER JOIN "+RetSqlName("SE1")+" SE1 "+CRLF
	cQuery	+=  " ON SE1.D_E_L_E_T_ = ' ' "+CRLF
	cQuery	+=  " AND SE1.E1_FILIAL = '"+xFilial("SE1")+"' "+CRLF
	cQuery	+=  " AND SE1.E1_PREFIXO = ZC8.ZC8_PREFIX "+CRLF
	cQuery	+=  " AND SE1.E1_NUM = ZC8.ZC8_TITULO "+CRLF
	cQuery	+=  " AND SE1.E1_PARCELA = ZC8.ZC8_PARCEL "+CRLF
	cQuery	+=  " AND SE1.E1_TIPO = ZC8.ZC8_TIPO "+CRLF

	cQuery   += " WHERE ZC8.D_E_L_E_T_ = ' ' "+CRLF
	cQuery   += " AND ZC8.ZC8_FILIAL = '"+xFilial("ZC8")+"' "+CRLF
	cQuery   += " AND ZC8.ZC8_PREFIX = '"+cPrefix+"' "+CRLF
	cQuery   += " AND ZC8.ZC8_TITULO = '"+cNum+"' "+CRLF
	cQuery   += " AND ZC8.ZC8_PARCEL = '"+cParcela+"' "+CRLF
	cQuery   += " AND ZC8.ZC8_TIPO = '"+cTipo+"' "+CRLF

	dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)
                                              
	DbSelectArea("ZC8")
	DbSetOrder(1)

	(cArqTmp)->(DbGoTop())
	While (cArqTmp)->(!Eof())
	
		If nOpc == 1//Baixa do titulo a receber
			ZC8->(DbGoTo((cArqTmp)->RECNOZC8))
			RecLock("ZC8",.F.)
			ZC8->ZC8_STATUS := "01"
			ZC8->ZC8_VALOR  := (cArqTmp)->E1_VALOR
			ZC8->ZC8_SALDO  := (cArqTmp)->E1_SALDO
			ZC8->ZC8_OBS	 := "Titulo baixado com sucesso: "+CRLF+CRLF+cComMsg
			ZC8->(MsUnLock())

			U_NCECOM09((cArqTmp)->ZC8_PVECOM, (cArqTmp)->ZC8_PEDIDO,"Baixa titulo manual","Titulo baixado com sucesso: "+CRLF+CRLF+cComMsg,"22",.T.)
		
		ElseIf nOpc == 2//Exclus�o do titulo a receber

			ZC8->(DbGoTo((cArqTmp)->RECNOZC8))
			RecLock("ZC8",.F.)
			ZC8->ZC8_STATUS := ""
			ZC8->ZC8_VALOR  := (cArqTmp)->E1_VALOR
			ZC8->ZC8_SALDO  := (cArqTmp)->E1_SALDO
			ZC8->ZC8_OBS	 := "Baixa do titulo cancelada e\ou excluida manualmente: "+CRLF+CRLF+cComMsg
			ZC8->(MsUnLock())
			U_NCECOM09((cArqTmp)->ZC8_PVECOM, (cArqTmp)->ZC8_PEDIDO,;
				"Cancelamento da baixa manual","Baixa do titulo cancelada e\ou excluida manualmente: "+CRLF+CRLF+cComMsg,"23",.T.)

		ElseIf nOpc == 3//Compensa��o

			ZC8->(DbGoTo((cArqTmp)->RECNOZC8))
			RecLock("ZC8",.F.)
			ZC8->ZC8_STATUS := Iif((cArqTmp)->E1_VALOR == 0,"01","03" )
			ZC8->ZC8_VALOR  := (cArqTmp)->E1_VALOR
			ZC8->ZC8_SALDO  := (cArqTmp)->E1_SALDO
			ZC8->ZC8_OBS	 := "Titulo a receber compensado manualmente: "+CRLF+CRLF+cComMsg
			ZC8->(MsUnLock())
			U_NCECOM09((cArqTmp)->ZC8_PVECOM, (cArqTmp)->ZC8_PEDIDO,;
				"Compensa��o de titulo manual","Titulo a receber compensado manualmente: "+CRLF+CRLF+cComMsg,"25",.T.)

		ElseIf nOpc == 4//Exclus�o da Compensa��o

			ZC8->(DbGoTo((cArqTmp)->RECNOZC8))
			RecLock("ZC8",.F.)
		
			If (cArqTmp)->E1_VALOR ==  (cArqTmp)->E1_SALDO
				ZC8->ZC8_STATUS := ""
			Else
				ZC8->ZC8_STATUS := "03"
			EndIf
		
			ZC8->ZC8_VALOR  := (cArqTmp)->E1_VALOR
			ZC8->ZC8_SALDO  := (cArqTmp)->E1_SALDO
			ZC8->ZC8_OBS	 := "Exclus�o da compensa��o do titulo a receber manualmente:"+CRLF+CRLF+cComMsg
			ZC8->(MsUnLock())
			U_NCECOM09((cArqTmp)->ZC8_PVECOM, (cArqTmp)->ZC8_PEDIDO,;
				"Exclus�o da compensa��o manual","Exclus�o da compensa��o do titulo a receber manualmente:"+CRLF+CRLF+cComMsg,"26",.T.)

		EndIf

		(cArqTmp)->(DbSkip())
	EndDo
                        
	RestArea(aArea)
Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCAtuDev  �Autor  � Elton C.		     � Data �  28/01/14   ���
�������������������������������������������������������������������������͹��
���Desc.     � Rotina utilizada na devolu��o de mercadoria					  ���
���			 �   																			  ���
���			 �        			     													  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function NCAtuDev(cDocDev, cSerieDev, cCliente, cLoja)

	Local aArea 	:= GetArea()
	Local cQuery	:= ""
	Local cArqTmp	:= GetNextAlias()

	Default cDocDev	:= ""
	Default cSerieDev := ""
	Default cCliente	:= ""
	Default cLoja		:= ""


	cQuery	:= " SELECT DISTINCT D1_DOC, D1_SERIE, D1_NFORI, D1_SERIORI, ZC5_NUM, ZC5_NUMPV, ZC5.R_E_C_N_O_ RECNOZC5, D2_PEDIDO FROM "+RetSqlName("SD1")+" SD1 "+CRLF

	cQuery	+= " INNER JOIN "+RetSqlName("SD2")+" SD2 "	+CRLF
	cQuery	+= " ON SD2.D_E_L_E_T_ = ' ' "+CRLF
	cQuery	+= " AND SD2.D2_FILIAL = SD1.D1_FILIAL "+CRLF
	cQuery	+= " AND SD2.D2_DOC = SD1.D1_NFORI "+CRLF
	cQuery	+= " AND SD2.D2_SERIE = SD1.D1_SERIORI "+CRLF
	cQuery	+= " AND SD2.D2_CLIENTE = SD1.D1_FORNECE "+CRLF
	cQuery	+= " AND SD2.D2_LOJA = SD1.D1_LOJA "+CRLF

	cQuery	+= " INNER JOIN ZC5010 ZC5 "+CRLF
	cQuery	+= " ON ZC5.ZC5_FILIAL = SD1.D1_FILIAL "+CRLF
	cQuery	+= " AND ZC5.ZC5_NUMPV = SD2.D2_PEDIDO "+CRLF
	cQuery	+= " AND ZC5.ZC5_CLIENT = SD2.D2_CLIENTE "+CRLF
	cQuery	+= " AND ZC5.ZC5_LOJA = SD2.D2_LOJA "+CRLF

	cQuery	+= " WHERE SD1.D_E_L_E_T_ = ' ' "+CRLF
	cQuery	+= " AND SD1.D1_FILIAL = '"+xFilial("SD1")+"' "+CRLF
	cQuery	+= " AND SD1.D1_TIPO = 'D' "+CRLF
	cQuery	+= " AND SD1.D1_DOC =  '"+cDocDev+"' "+CRLF
	cQuery	+= " AND SD1.D1_SERIE = '"+cSerieDev+"' "+CRLF
	cQuery	+= " AND SD1.D1_FORNECE = '"+cCliente+"' "+CRLF
	cQuery	+= " AND SD1.D1_LOJA = '"+cLoja+"' "+CRLF

	cQuery	:= ChangeQuery(cQuery)

	dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)

	(cArqTmp)->(DbGoTop())

	DbSelectArea("ZC5")
	DbSetOrder(1)

	While (cArqTmp)->(!Eof())
		ZC5->(DbGoTo((cArqTmp)->RECNOZC5))
	//Informa ao site que o pedido foi devolvido
		Reclock("ZC5",.F.)
	
	//Verifica se � necess�rio atualizar o status de devolu��o
		If VldStsDev((cArqTmp)->D1_NFORI, (cArqTmp)->D1_SERIORI, cCliente, cLoja)
			ZC5->ZC5_STATUS := "91"
			ZC5->ZC5_ATUALI	:='S'
		EndIf
	
		ZC5->ZC5_DOCDEV := (cArqTmp)->D1_DOC
		ZC5->ZC5_SERDEV := (cArqTmp)->D1_SERIE
		ZC5->(MsUnLock())
	
		U_NCECOM09((cArqTmp)->ZC5_NUM, (cArqTmp)->ZC5_NUMPV,"Devolu��o",;
			"Devolu��o efetuada com sucesso. Doc/Serie: "+Alltrim(cDocDev)+"/"+Alltrim(cSerieDev)	,"",.T.)

	//Atualiza o status atual do pedido (Devolu��o do pedido de venda)
		U_NCEC10CI((cArqTmp)->ZC5_NUM, "011",ZC5->ZC5_PVVTEX)
		(cArqTmp)->(DbSkip())
	EndDo


	RestArea(aArea)
Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �VldStsDev  �Autor  � Elton C.		     � Data �  28/01/14   ���
�������������������������������������������������������������������������͹��
���Desc.     � Valida status de devolu��o											  ���
���			 �   																			  ���
���			 �        			     													  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function VldStsDev(cDoc, cSerie, cCliente, cLoja)

	Local aArea 	:= GetArea()
	Local lRet		:= .T.
	Local cQuery	:= ""
	Local cArqTmp	:= GetNextAlias()

	Default cDoc		:= ""
	Default cSerie		:= ""
	Default cCliente	:= ""
	Default cLoja		:= ""

	cQuery	:= " SELECT D2_COD, D2_QUANT FROM "+RetSqlName("SD2")+" SD2 "+CRLF
	cQuery	+= " WHERE SD2.D_E_L_E_T_ = ' ' " +CRLF
	cQuery	+= " AND SD2.D2_FILIAL = '"+xFilial("SD2")+"' "+CRLF
	cQuery	+= " AND SD2.D2_DOC = '"+cDoc+"' "+CRLF
	cQuery	+= " AND SD2.D2_SERIE = '"+cSerie+"' "+CRLF
	cQuery	+= " AND SD2.D2_CLIENTE = '"+cCliente+"' "+CRLF
	cQuery	+= " AND SD2.D2_LOJA = '"+cLoja+"' "+CRLF

	dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)

	(cArqTmp)->(DbGoTop())
	While (cArqTmp)->(!Eof())
	
	//Verifica a existencia do produto e quantidade no documento de devolu��o.
	//Esse procedimento e efetuado para n�o enviar Sstatus de devolu��o para o Site, em caso de devolu��o parcial.
		If !(ExisPrdDev(cDoc, cSerie, cCliente, cLoja, (cArqTmp)->D2_COD, (cArqTmp)->D2_QUANT))
		
			lRet		:= .F.
			Exit
		EndIf

		(cArqTmp)->(DbSkip())
	EndDo


	(cArqTmp)->(DbCloseArea())
	RestArea(aArea)
Return lRet

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �ExisPrdDev  �Autor  � Elton C.		     � Data �  28/01/14   ���
�������������������������������������������������������������������������͹��
���Desc.     � Verifica se o produto e quantidade existe no documento 	  ���
���			 � de devolu��o de acordo com a nota fiscal de origem			  ���
���			 �        			     													  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function ExisPrdDev(cDocOri, cSerOri, cCliente, cLoja, cCod, nQuant)

	Local aArea 	:= GetArea()
	Local cQuery   := ""
	Local lRet		:= .F.
	Local cArqTmp	:= GetNextAlias()

	Default cDocOri	:= ""
	Default cSerOri	:= ""
	Default cCliente	:= ""
	Default cLoja		:= ""
	Default cCod		:= ""
	Default nQuant		:= 0


	cQuery   := " SELECT * FROM "+RetSqlName("SD1")+" SD1 "+CRLF
	cQuery   += " WHERE SD1.D_E_L_E_T_ = ' ' "+CRLF
	cQuery   += " AND SD1.D1_FILIAL = '"+xFilial("SD1")+"' "+CRLF
	cQuery   += " AND SD1.D1_NFORI = '"+cDocOri+"' "+CRLF
	cQuery   += " AND SD1.D1_SERIORI = '"+cSerOri+"' "+CRLF
	cQuery   += " AND SD1.D1_FORNECE = '"+cCliente+"' "+CRLF
	cQuery   += " AND SD1.D1_LOJA = '"+cLoja+"' "+CRLF
	cQuery   += " AND SD1.D1_COD = '"+cCod+"' "+CRLF
	cQuery   += " AND SD1.D1_QUANT = '"+Alltrim(Str(nQuant))+"' "+CRLF

	dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)

	(cArqTmp)->(DbGoTop())
	If (cArqTmp)->(!Eof())
		lRet		:= .T.
	EndIf


	(cArqTmp)->(DbCloseArea())
	RestArea(aArea)
Return lRet



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCExcNFS  �Autor  �Elton C.			 � Data �  28/01/14   ���
�������������������������������������������������������������������������͹��
���Desc.     � Rotina utilizada na exclus�o do titulo, para q	  ���
���			 � alterar o status da tabela ZC5 (ZC5_ESTORN = S), 		  ���
���			 � status dos titulos na tabela ZC8 para excluidos e		  ���
���			 � elimina residuo											  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function NCExcNFS(cNumPed)

	Local aArea 	:= GetArea()
	Local cQuery	:= ""
	Local cArqTmp	:= GetNextAlias()

	Default cNumPed := ""

	cQuery	:= " SELECT ZC5_NUM, ZC5_NUMPV, ZC5.R_E_C_N_O_ RECNOZC5 "+CRLF
	cQuery	+= " FROM "+RetSqlName("ZC5")+" ZC5 "+CRLF
	cQuery	+= " WHERE ZC5.D_E_L_E_T_ = ' ' "+CRLF
	cQuery	+= " AND ZC5.ZC5_FILIAL = '"+xFilial("ZC5")+"' "+CRLF
	cQuery	+= " AND ZC5.ZC5_NUMPV = '"+cNumPed+"' "+CRLF

	cQuery	:= ChangeQuery(cQuery)

	dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)

	(cArqTmp)->(DbGoTop())
	If (cArqTmp)->(!Eof())

		DbSelectArea("ZC5")
		DbSetOrder(1)
   
	//Flag para informar que o pedido foi estornado
		ZC5->(DbGoTo((cArqTmp)->RECNOZC5))
		Reclock("ZC5",.F.)
		ZC5->ZC5_ESTORN := "S"
		ZC5->ZC5_STATUS := "92"//Aguardando estorno / cancelamento
		ZC5->(MsUnLock())
	
		U_NCECOM09((cArqTmp)->ZC5_NUM, (cArqTmp)->ZC5_NUMPV,"Exclus�o Nota Fiscal de Sa�da",;
			"Exclus�o da nota fiscal efetuada com sucesso. "+ZC5->ZC5_NOTA+"/"+ZC5->ZC5_SERIE,"",.F.)
	
	//Chama a rotina para alterar o Status dos titulos para excluido	
		AltStsZC8((cArqTmp)->ZC5_NUM, (cArqTmp)->ZC5_NUMPV)
	
	//Exclui titulo RA se existir (Faturamento parcial)
		ExcTitRa((cArqTmp)->ZC5_NUM, (cArqTmp)->ZC5_NUMPV)
	
	//Chama a rotina para eliminar residuo
		DbSelectArea("SC5")
		DbSetOrder(1)
		If SC5->(DbSeek(xFilial("SC5") + (cArqTmp)->ZC5_NUMPV ) )

		//Chama a rotina para eliminar residuo
			If u_C08CANCPV(SC5->C5_NUM)
				U_NCECOM09((cArqTmp)->ZC5_NUM, (cArqTmp)->ZC5_NUMPV,"Elimina��o de res�duo","Res�duo eliminado com sucesso. Pedido: "+(cArqTmp)->ZC5_NUMPV,"",.F.)
			//Atualiza o status atual do pedido (Exclus�o da NF e elimina��o de residuo)
				U_NCEC10CI((cArqTmp)->ZC5_NUM, "012",ZC5->ZC5_PVVTEX)
			Else
				U_NCECOM09((cArqTmp)->ZC5_NUM, (cArqTmp)->ZC5_NUMPV,"Erro elimina��o de res�duo","Erro ao tentar eliminar res�duo do pedido "+(cArqTmp)->ZC5_NUMPV,"",.F.)
			//Atualiza o status atual do pedido (Exclus�o da NF e erro na elimina��o de residuo)
				U_NCEC10CI((cArqTmp)->ZC5_NUM, "013",ZC5->ZC5_PVVTEX)
			EndIf

		EndIf
	
	EndIf

	(cArqTmp)->(DbCloseArea())
	RestArea(aArea)
Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �AltStsZC8  �Autor  �Elton C.		  � Data �  28/01/14   	  ���
�������������������������������������������������������������������������͹��
���Desc.     � Altera��o do Status do titulo para excluido				  	  ���
���			 � no caso da exclus�o da nota fiscal						  		  ���
���			 �    			     										  				  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function AltStsZC8(nPedSite, cNumPV)

	Local aArea 	:= GetArea()
	Local cQuery   := ""
	Local cArqTmp	:= GetNextAlias()
	Local nCondDel	:= 0

	Default cNumPV 	:= ""
	Default nPedSite  := 0

	cQuery   := " SELECT ZC8.R_E_C_N_O_ RECNOZC8 FROM "+RetSqlName("ZC8")+" ZC8 "+CRLF

	cQuery   += " WHERE ZC8.D_E_L_E_T_ = ' ' "+CRLF
	cQuery   += " AND ZC8.ZC8_FILIAL = '"+xFilial("ZC8")+"' "+CRLF
	cQuery   += " AND ZC8.ZC8_PVECOM = '"+Alltrim(Str(nPedSite))+"' "+CRLF
	cQuery   += " AND ZC8.ZC8_PEDIDO = '"+cNumPV+"' "+CRLF
	cQuery   += " AND NOT EXISTS(SELECT * FROM "+RetSqlName("SE1")+" SE1 "+CRLF
	cQuery   += " 						WHERE SE1.D_E_L_E_T_ = ' ' "+CRLF
	cQuery   += " 						AND SE1.E1_FILIAL = '"+xFilial("SE1")+"' " +CRLF
	cQuery   += " 						AND SE1.E1_PREFIXO = ZC8.ZC8_PREFIX " +CRLF
	cQuery   += " 						AND SE1.E1_NUM = ZC8.ZC8_TITULO "+CRLF
	cQuery   += " 						AND SE1.E1_TIPO = ZC8.ZC8_TIPO )"+CRLF

	dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)

	DbSelectArea("ZC8")
	DbSetOrder(1)

	While (cArqTmp)->(!Eof())
	
		ZC8->(DbGoTo((cArqTmp)->RECNOZC8))
		Reclock("ZC8",.F.)
		ZC8->ZC8_STATUS := "04" //Status excluido
		ZC8->(MsUnLock())
	
		++nCondDel
		(cArqTmp)->(DbSkip())
	EndDo

	If nCondDel != 0
		U_NCECOM09(nPedSite, cNumPV,"EXCLUSAO_TITULO","T�tulo exclu�do.","",.F.)
	Else
		U_NCECOM09(nPedSite, cNumPV,"ERRO_EXCLUSAO_TITULO","Erro na exclus�o de t�tulo(s)","",.F.)
	EndIf

	(cArqTmp)->(DbCloseArea())
	RestArea(aArea)
Return

                                           

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �ExcTitRa  �Autor  �Elton C.			  � Data �  28/01/14   	  ���
�������������������������������������������������������������������������͹��
���Desc.     � Rotina utilizada para excluir titulo RA gerado no caso de  ���
���			 � faturamento parcial											  		  ���
���			 �    			     										  				  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function ExcTitRa(nPedSite, cPedProth)

	Local aArea 	:= GetArea()
	Local cQuery	:= ""
	Local cArqTmp	:= GetNextAlias()
	Local aTitulo 	:= {}
	Local cRet 		:= ""

	Default nPedSite	:= 0
	Default cPedProth	:= ""

	cQuery   := " SELECT E1_PREFIXO, E1_NUM, E1_PARCELA, E1_TIPO, E1_CLIENTE, E1_LOJA, E1_ORIGEM, "
	cQuery   += " ZC8_PVECOM, ZC8_PEDIDO ,ZC8.R_E_C_N_O_ RECNOZC8 FROM "+RetSqlName("ZC8")+" ZC8 "+CRLF

	cQuery   += " INNER JOIN "+RetSqlName("SE1")+" SE1 "+CRLF
	cQuery   += " ON SE1.D_E_L_E_T_ = ' '  "+CRLF
	cQuery   += " AND SE1.E1_FILIAL = '"+xFilial("SE1")+"'  "+CRLF
	cQuery   += " AND SE1.E1_PREFIXO = ZC8.ZC8_PREFIX "+CRLF
	cQuery   += " AND SE1.E1_NUM = ZC8.ZC8_TITULO "+CRLF
	cQuery   += " AND SE1.E1_PARCELA = ZC8.ZC8_PARCEL "+CRLF
	cQuery   += " AND SE1.E1_TIPO = ZC8.ZC8_TIPO "+CRLF
                                             
	cQuery   += " WHERE ZC8.D_E_L_E_T_ = ' ' "+CRLF
	cQuery   += " AND ZC8.ZC8_FILIAL = '"+xFilial("ZC8")+"' "+CRLF
	cQuery   += " AND ZC8.ZC8_PVECOM = '"+Alltrim(Str(nPedSite))+"' "+CRLF
	cQuery   += " AND ZC8.ZC8_PEDIDO = '"+cPedProth+"' "+CRLF
	cQuery   += " AND ZC8.ZC8_TIPO = 'RA' "+CRLF
	cQuery   += " AND ZC8.ZC8_STATUS != '04' "

	dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)

	If (cArqTmp)->(!Eof())

		AADD(aTitulo,	{"E1_PREFIXO"	,(cArqTmp)->E1_PREFIXO	,Nil})
		AADD(aTitulo,	{"E1_NUM"		,(cArqTmp)->E1_NUM		,Nil})
		AADD(aTitulo,	{"E1_PARCELA"  ,(cArqTmp)->E1_PARCELA	,Nil})
		AADD(aTitulo,	{"E1_TIPO"		,(cArqTmp)->E1_TIPO		,Nil})
		AADD(aTitulo,	{"E1_CLIENTE"	,(cArqTmp)->E1_CLIENTE	,Nil})
		AADD(aTitulo,	{"E1_LOJA"	   ,(cArqTmp)->E1_LOJA   	,Nil})
		AADD(aTitulo,	{"E1_ORIGEM"	,(cArqTmp)->E1_ORIGEM  	,Nil})
   
	//Chama a rotina para excluir o titulo
		cRet := NCGerTRA(aTitulo, 5 )
   
		If Empty(cRet)
    	
			DbSelectArea("ZC8")
			DbSetOrder(1)
			ZC8->(DbGoTo((cArqTmp)->RECNOZC8))
			RecLock("ZC8",.F.)
			ZC8->ZC8_STATUS = "04"//Cancelado
			ZC8->(MsUnLock())
		
			U_NCECOM09(nPedSite, cPedProth,"EXCLUSAO_TITULO_RA","Titulo exclu�do com sucesso. ","",.F.)
		Else
			If !IsBlind()
				Aviso("ERROEXCRA","Erro ao tentar excluir RA. Verifique o log de erro no monitor.",{"Ok"},2)
			EndIf
		
			U_NCECOM09(nPedSite, cPedProth,"ERR_EXCLUSAO_TITULO_RA","Erro ao tentar excluir RA. "+CRLF+CRLF+cRet,"",.F.)
		EndIf
	
	EndIf

	(cArqTmp)->(DbCloseArea())

	RestArea(aArea)
Return cRet




/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �VNcPrdBlq  �Autor  �Elton C.		  � Data �  28/01/14   	  ���
�������������������������������������������������������������������������͹��
���Desc.     � Rotina utilizada para enviar mensagem ao monitor 		  ���
���			 � informando os produtos bloqueados para venda		  		  ���
���			 �    			     						 				  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function VNcPrdBlq(nPedSite, cPedProth, cTIPO)

	Local aArea 	:= GetArea()
	Local cQuery	:= ""
	Local cArqTmp	:= GetNextAlias()
	Local cMsgLog 	:= ""
	Local cMsgAux	:= " Produto(s) bloqueado para venda: "	+CRLF+CRLF
	Local PedLog	:= 0
	Default nPedSite	:= 0
	Default cPedProth	:= ""

	cQuery	:= " SELECT ZC6_NUM, ZC6_ITEM, ZC6_PRODUT, ZC6_QTDVEN, ZC6_VLRUNI, ZC6_VLRTOT, B1_XDESC, B1_MSBLQL, B1_BLQVEND FROM "+RetSqlName("ZC6")+" ZC6 "

	cQuery	+= " INNER JOIN "+RetSqlName("SB1")+" SB1 "
	cQuery	+= " ON SB1.B1_FILIAL = '"+xFilial("SB1")+"' "
	cQuery	+= " AND SB1.B1_COD = ZC6.ZC6_PRODUT "
	cQuery	+= " AND SB1.D_E_L_E_T_ = ' ' "
	cQuery	+= " AND SB1.B1_BLQVEND = '1' "//Produto bloqueado

	cQuery	+= " WHERE ZC6.ZC6_FILIAL = '"+xFilial("ZC6")+"' "

	If cTIPO == 'B2C'
		cQuery	+= " AND ZC6.ZC6_NUM = '"+Alltrim(Str(nPedSite))+"' "
		PedLog := nPedSite
	ElseIF cTipo == 'B2B'
		cQuery	+= " AND ZC6.ZC6_PVVTEX = '"+nPedSite+"' "
		nPedSite := 0
	EndIF

	cQuery	+= " AND ZC6.D_E_L_E_T_ = ' ' "

	dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)

	While (cArqTmp)->(!Eof())

		cMsgLog 	+= (cArqTmp)->ZC6_PRODUT +" - "+Alltrim((cArqTmp)->B1_XDESC) + CRLF

		(cArqTmp)->(DbSkip())
	EndDo

	If !Empty(cMsgLog)
		cMsgLog := cMsgAux + cMsgLog
 	
 	//Envia mensagem de produto bloqueado para o monitor
		U_NCECOM09(PedLog, cPedProth,"Produto bloqueado para venda. ",cMsgLog,"",.T.)
	EndIf

	(cArqTmp)->(DbCloseArea())

	RestArea(aArea)
Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCEC10CI  �Autor  � Elton C.		     � Data �  28/01/14   ���
�������������������������������������������������������������������������͹��
���Desc.     � rotina utilizada para atualizar o status atual do pedido	  ���
���			 � e-commerce.												  ���
���			 � 															  ���
���			 � Codigo e descri��o do Status:							  ���
���			 � 001-Pedido n�o gerado por erro (Verificar log no monitor)  ���
���			 � 002-Aguardando envio do pedido para o WMS				  ���
���			 � 003-Pedido bloqueado por regra,devido estoque insuficiente ���
���			 � 004-Pedido cancelado pelo MOIP							  ���
���			 � 005-Aguardando WMS para cancelar o pedido e eliminar resid.���
���			 � 006-Pedido expedido (Status 15)							  ���
���			 � 007-Pedido enviado c/ rastreio(Status 30)				  ���
���			 � 008-Aguardando pagamento									  ���
���			 � 009-Pedido cancelado										  ���
���			 � 010-NF emitida, aguardando expedi��o						  ���
���			 � 011-Devolu��o do edido de venda							  ���
���			 � 012-Exclus�o da nota fiscal de elimina��o de residuo		  ���
���			 � 013-Exclus�o da nota fiscal e erro na elimina��o de residuo���
���			 � 014-Libera��o de reserva									  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function NCEC10CI(nPedSite, cCodInt,cPvVtex)
	Local aArea := GetArea()
	Local aAreaZC5:=ZC5->(GetArea())

	Default nPedSite 	:= 0
	Default cCodInt	:= ""
	Default cPvVtex	:=""

	If !Empty(cPvVtex)
		ZC5->(DbSetOrder(6))//ZC5_FILIAL+ZC5_PVVTEXS
		If ZC5->(DbSeek(xFilial("ZC5") +cPvVtex  ) )
			Reclock("ZC5",.F.)
			ZC5->ZC5_CODINT := cCodInt//Codigo do status atual do pedido
			If cCodInt = "001"
				ZC5->ZC5_FLAG	:= "6"
			EndIf
			ZC5->(MsUnLock())
		EndIf
	ElseIf nPedSite != 0
		ZC5->(DbSetOrder(1))//ZC5_FILIAL+STR(ZC5_NUM,6,0)
		If ZC5->(DbSeek(xFilial("ZC5") + Alltrim(Str(nPedSite)) ) )
			Reclock("ZC5",.F.)
			ZC5->ZC5_CODINT := cCodInt//Codigo do status atual do pedido
			If cCodInt = "001"
				ZC5->ZC5_FLAG	:= "6"
			EndIf
			ZC5->(MsUnLock())
		EndIf

	EndIf

	RestArea(aAreaZC5)
	RestArea(aArea)
Return



/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Funcao    �ECOINFBXT  � Autor � 	Elton C.				� Data �  04/09/13  ���
�������������������������������������������������������������������������͹��
���Descricao �Rotina utilizada em schedule para enviar os titulos de	 	  ���
���          �E-commerce a serem baixados (Concilia��o com o Moip).		  ���
�������������������������������������������������������������������������͹��
�����������������������������������������������������������������������������
/*/
User Function ECOINFBXT(aDados)

                     
	Local aArea 		:= {}
	Local cQuery 		:= ""
	Local cArqTmp  	:= ""
	Local lTitComp		:= .F.
	Local aTitBaix		:= {}
	Local cMsgBxTit   := ""
	Local aTitBxAux	:= {}
	Local cAssunto		:= "Concilia��o de t�tulos E-commerce x MOIP"
	Local cBody			:= ""
	Local aAnexos		:= {}
	Local cEmailTo		:= ""
	Local cEmailCc		:= ""
	Local cErro			:= ""


	Default aDados := {"01","03",.T.}

//Chama a rotina para setar a empresa e filial
	If aDados[3]
		SetEmpFil( aDados[1], aDados[2] )
	EndIf

	aArea 		:= GetArea()
	cEmailTo		:= U_MyNewSX6("EC_NCG0014",;
		"lfelipe@ncgames.com.br",;
		"C",;
		"E-mail de usu�rio - Titulos Baixados E-commerce",;
		"",;
		"E-mail de usu�rio - Titulos Baixados E-commerce",;
		.F. )

	cQuery 	:= ""
	cArqTmp  := GetNextAlias()
	lTitComp	:= .F.



	cQuery 	:= " SELECT E1_PREFIXO, E1_NUM, E1_PARCELA, E1_TIPO, E1_VENCTO, E1_VENCREA, SE1.R_E_C_N_O_ RECNOSE1, "+CRLF
	cQuery 	+= "        ZC8.R_E_C_N_O_ RECNOZC8, ZC8_PEDIDO, ZC8_PVECOM, ZC5_NUM, ZC5_NUMPV FROM "+RetSqlName("ZC8")+" ZC8 "+CRLF

	cQuery 	+= " INNER JOIN "+RetSqlName("ZC5")+" ZC5 "+CRLF
	cQuery 	+= " ON ZC5.D_E_L_E_T_ = ' ' "+CRLF
	cQuery 	+= " AND ZC5.ZC5_FILIAL = ZC8.ZC8_FILIAL "+CRLF
	cQuery 	+= " AND ZC5.ZC5_NUM = ZC8.ZC8_PVECOM "+CRLF
	cQuery 	+= " AND ZC5.ZC5_NUMPV = ZC8.ZC8_PEDIDO "+CRLF
	cQuery 	+= " AND ZC5.ZC5_PAGTO = '2' "+CRLF//Pagamento efetuado (Autorizado pelo moip)
	cQuery 	+= " AND ZC5.ZC5_DOCDEV = ' ' "+CRLF//Nota de devolu��o

	cQuery 	+= " INNER JOIN "+RetSqlName("SE1")+" SE1 "+CRLF
	cQuery 	+= " ON SE1.D_E_L_E_T_ = ' ' "+CRLF
	cQuery 	+= " AND SE1.E1_FILIAL = '"+xFilial("SE1")+"' "+CRLF
	cQuery 	+= " AND SE1.E1_PREFIXO = ZC8.ZC8_PREFIX  "+CRLF
	cQuery 	+= " AND SE1.E1_NUM = ZC8.ZC8_TITULO "+CRLF
	cQuery 	+= " AND SE1.E1_PARCELA = ZC8.ZC8_PARCEL "+CRLF
	cQuery 	+= " AND SE1.E1_TIPO = ZC8.ZC8_TIPO "+CRLF
	cQuery 	+= " AND SE1.E1_VENCREA <= '"+Dtos(MsDate())+"' "+CRLF

	cQuery 	+= " WHERE ZC8.D_E_L_E_T_ = ' ' "+CRLF
	cQuery 	+= " AND ZC8.ZC8_FILIAL = '"+xFilial("ZC8")+"' "+CRLF
	cQuery 	+= " AND ZC8.ZC8_STATUS NOT IN('01','04') "+CRLF//Pedido compensado e\ou excluido
	cQuery 	+= " AND ZC8.ZC8_TIPO != 'RA' "+CRLF

	dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)

	DbSelectArea("ZC5")
	DbSetOrder(1)

	DbSelectArea("SE1")
	DbSetOrder(1)

	DbSelectArea("ZC8")
	DbSetOrder(1)

	While (cArqTmp)->(!Eof())
	
		SE1->(DbGoTo((cArqTmp)->RECNOSE1))
	
	 //Titulos a serem baixados no Protheus
		Aadd(aTitBxAux,{Alltrim(Str((cArqTmp)->ZC5_NUM)),;//Pedido Site
		(cArqTmp)->ZC5_NUMPV,;//Pedido Protheus
		SE1->E1_PREFIXO,;//Prefixo
		SE1->E1_NUM,;//Titulo
		SE1->E1_PARCELA,;//Parcela
		SE1->E1_TIPO,;//Tipo
		Transform(SE1->E1_VALOR, "@E 999,999,999.99"),;//Valor
		Transform(SE1->E1_SALDO, "@E 999,999,999.99"),;//Saldo
		DTOC(SE1->E1_VENCREA),;
			DTOC(SE1->E1_BAIXA)} )
							
	
		(cArqTmp)->(DbSkip())
	EndDo

//Envia e-mail ao Depto. Finaceiro, informando os titulo baixados
	If Len(aTitBxAux) > 0
	//Preenche o Html   
		cBody := u_ECOMHTMD(aTitBxAux, DtoC(MsDate()))
	
		U_COM08SEND(cAssunto, cBody, aAnexos, cEmailTo, cEmailCc, cErro)
	
	EndIf

	(cArqTmp)->(DbCloseArea())
	RestArea(aArea)
Return
User Function XXF()

//u_NCECOM08({"01","03","GRAVA_PEDIDO",.T.})
	u_NCECOM08({"01","03","VERIFICA_EXPEDICAO",.T.})

Return
