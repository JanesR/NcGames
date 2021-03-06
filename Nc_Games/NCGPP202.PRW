#INCLUDE "PROTHEUS.CH"
#INCLUDE "msgraphi.ch"
#INCLUDE "APWIZARD.CH"


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGPP02  �Autor  �Elton C.            � Data �  13/09/13 	  ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina utilizada para incluir e/ou alterar os saldos 		  ���
���          � de repasse Publisher x NcGames (Tabelas PZ7 e PZ8)         ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function NCGPP02(cCodPP,nOpc)
Local aArea 	:= GetArea()
Local cCodPubl	:= GetCodPub(cCodPP)

Default cCodPP  := ""
Default nOpc 	:= 0

If (nOpc == 1) .Or. (nOpc == 2)//Inclus�o ou altera��o de Price Protection
	INCALTPP02(cCodPP)//Inclui ou altera o controle de Price Protection 
Else
	EXCPP02(cCodPP)//Exclui dados do controle de price protection
EndIf

//Atualiza saldo do Publisher
u_NCAtuRPP(cCodPubl)

RestArea(aArea)
Return     



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �INCALTPP02  �Autor  �Elton C.        � Data �  13/09/13 	  ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina utilizada para incluir \ alterar saldos das campanhas���
���          �dos Publishers			       							  ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function INCALTPP02(cCodPP)  

Local aArea 	:= GetArea()      
Local cQuery    := ""
Local cArqTmp	:= GetNextAlias()
Local aStruct	:= {}
Local nX		:= 0

Default cCodPP 	:= ""               


cQuery    := " SELECT P05_CODPP, P05_VALOR, P05_NCUSTO, P05_PPPUB, P05_DTAPLI, P05_DTACEI, P05_DTEFET, P0C_PUBLIS, P0C_DPUBLI, P0C_CAMP FROM "+RetSqlName("P05")+" P05 "+CRLF
cQuery    += " INNER JOIN "+RetSqlName("P0C")+" P0C "+CRLF
cQuery    += " ON P0C.P0C_FILIAL = P05.P05_FILIAL "+CRLF
cQuery    += " AND P0C.P0C_PPPUB = P05.P05_PPPUB "+CRLF
cQuery    += " AND P0C.D_E_L_E_T_ = ' ' " +CRLF

cQuery    += " WHERE P05.P05_FILIAL = '"+xFilial("P05")+"' "+CRLF
cQuery    += " AND P05.P05_CODPP = '"+cCodPP+"' "+CRLF
cQuery    += " AND P05.D_E_L_E_T_ = ' ' "+CRLF

dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)

aStruct   := P05->(dbStruct())
For nX := 1 To Len(aStruct)
	If aStruct[nX][2] <> "C" .And. FieldPos( aStruct[nX][1] ) <> 0
		TcSetField( cArqTmp, aStruct[nX][1], aStruct[nX][2], aStruct[nX][3], aStruct[nX][4] )
	EndIf
Next nX


If (cArqTmp)->(!Eof())
	
	DbSelectArea("PZ8")
	DbSetOrder(1)	
	If PZ8->(DbSeek(xFilial("PZ8") + cCodPP))
		
		//Altera��o de price protection
		RecLock("PZ8",.F.)

		PZ8->PZ8_VLREPS := (cArqTmp)->P05_NCUSTO
		PZ8->PZ8_VLCONS	:= 0
		PZ8->PZ8_SALDO 	:= (cArqTmp)->P05_NCUSTO
		PZ8->PZ8_DTAPLI	:= (cArqTmp)->P05_DTAPLI
		PZ8->PZ8_DTACEI	:= (cArqTmp)->P05_DTACEI
		PZ8->PZ8_DTEFET := (cArqTmp)->P05_DTEFET 
		
		If Empty((cArqTmp)->P05_DTACEI) .And. Empty((cArqTmp)->P05_DTACEI) 
			PZ8->PZ8_STATUS	:= "1"//PP N�o aprovado
		ElseIf !Empty((cArqTmp)->P05_DTACEI) .And. Empty((cArqTmp)->P05_DTACEI) 
			PZ8->PZ8_STATUS	:= "2"//PP aprovado e n�o aplicad
		ElseIf !Empty((cArqTmp)->P05_DTACEI) .And. !Empty((cArqTmp)->P05_DTACEI) 
			PZ8->PZ8_STATUS	:= "3"//PP aprovado e aplicado (Saldo total em aberto)
		EndIf

		PZ8->(MsUnLock())
	                                    
	Else                
		//Inclus�o de price protection
		RecLock("PZ8",.T.)
		PZ8->PZ8_FILIAL := xFilial("PZ8")
		PZ8->PZ8_CODPP	:= (cArqTmp)->P05_CODPP
		PZ8->PZ8_PUBLIS	:= (cArqTmp)->P0C_PUBLIS
		PZ8->PZ8_CAMP	:= (cArqTmp)->P05_PPPUB
		PZ8->PZ8_VLREPS := (cArqTmp)->P05_NCUSTO
		PZ8->PZ8_VLCONS	:= 0
		PZ8->PZ8_SALDO 	:= (cArqTmp)->P05_NCUSTO
		PZ8->PZ8_DTAPLI	:= (cArqTmp)->P05_DTAPLI
		PZ8->PZ8_STATUS	:= "1"//1-PP Cadastrado e n�o aprovado 
		PZ8->(MsUnLock())

    EndIf
EndIf

(cArqTmp)->(DbCloseArea())
RestArea(aArea)
Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �EXCPP02  �Autor  �Elton C.	        � Data �  13/09/13 	  ���
�������������������������������������������������������������������������͹��
���Desc.     � Exclus�o de Price Protection								  ���
���          �			       							  				  ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function EXCPP02(cCodPP)

Local aArea := GetArea()

Default cCodPP := ""
                         
DbSelectArea("PZ8")
DbSetOrder(1)	
If PZ8->(DbSeek(xFilial("PZ8") + cCodPP))
	RecLock("PZ8",.F.)
	PZ8->(DbDelete())
	PZ8->(MsUnLock())
EndIf

RestArea(aArea)
Return
  

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCAtuRPP  �Autor  �Elton C.	        � Data �  13/09/13 	  ���
�������������������������������������������������������������������������͹��
���Desc.     � Rotina utilizada para atualizar saldo do cabe�alho		  ���
���          � do controle de repasse (Tabela PZ7)		  				  ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function NCAtuRPP(cCodPub)

Local aArea := GetArea()

Default cCodPub := ""

If !Empty(cCodPub)
	DbSelectArea("PZ7")
	DbSetOrder(1)
	If PZ7->(DbSeek(xFilial("PZ7") + cCodPub))
		NCUDPP02(cCodPub)//Atualiza saldo
	Else
		NCINPP02(cCodPub)//Inclui saldo
	EndIf
EndIf

RestArea(aArea)
Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCUDPP02  �Autor  �Elton C.	        � Data �  13/09/13 	  ���
�������������������������������������������������������������������������͹��
���Desc.     � Rotina utilizada para atualizar saldo do cabe�alho		  ���
���          � do controle de repasse (Tabela PZ7)		  				  ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function NCUDPP02(cCodPublis)

Local aArea 	:= GetArea()
Local cQuery	:= ""
Local cArqTmp	:= GetNextAlias()

Default cCodPublis := ""

cQuery	:= " SELECT PZ7.R_E_C_N_O_ RECNOPZ7, SUM(PZ8_VLREPS) PZ8_VLREPS, SUM(PZ8.PZ8_VLCONS) PZ8_VLCONS, SUM(PZ8.PZ8_SALDO) PZ8_SALDO,  "+CRLF
cQuery	+= "  PZ8_PUBLIS, CTD_DESC01  FROM "+RetSqlName("PZ7")+" PZ7 "+CRLF

cQuery	+= "  INNER JOIN "+RetSqlName("PZ8")+" PZ8 "+CRLF
cQuery	+= "  ON PZ8.PZ8_FILIAL = PZ7.PZ7_FILIAL  "+CRLF
cQuery	+= "  AND PZ8.PZ8_PUBLIS = PZ7.PZ7_PUBLIS "+CRLF
cQuery	+= "  AND PZ8.D_E_L_E_T_ = ' ' "+CRLF

cQuery	+= "  INNER JOIN "+RetSqlName("CTD")+" CTD "+CRLF
cQuery	+= "  ON CTD.CTD_FILIAL = '"+xFilial("CTD")+"' "+CRLF
cQuery	+= "  AND CTD.CTD_ITEM = PZ7.PZ7_PUBLIS "+CRLF
cQuery	+= "  AND CTD.D_E_L_E_T_ = ' ' "+CRLF

cQuery	+= "  WHERE PZ7.PZ7_FILIAL = '"+xFilial("PZ7")+"'  "+CRLF
cQuery	+= "  AND PZ7.PZ7_PUBLIS = '"+cCodPublis+"' "+CRLF
cQuery	+= "  AND PZ7.D_E_L_E_T_ = ' ' "

cQuery	+= "   GROUP BY PZ7.R_E_C_N_O_,PZ8_PUBLIS, CTD_DESC01 "+CRLF

dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)

If (cArqTmp)->(!Eof())
	DbSelectArea("PZ7")
	DbSetOrder(1)
	PZ7->(DbGoto((cArqTmp)->RECNOPZ7))
	
	Reclock("PZ7",.F.)
    PZ7->PZ7_VLREPS := (cArqTmp)->PZ8_VLREPS
    PZ7->PZ7_VLCONS := (cArqTmp)->PZ8_VLCONS
    PZ7->PZ7_SALDO  := (cArqTmp)->PZ8_SALDO
	PZ7->(MsUnLock())                      
	
EndIf

(cArqTmp)->(DbCloseArea())

RestArea(aArea)
Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCSldConPP  �Autor  �Elton C.	        � Data �  13/09/13 	  ���
�������������������������������������������������������������������������͹��
���Desc.     � atualiza o saldo da campanha do publisher 				  ���
���          � 											  				  ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function NCSldConPP(cCodPublis, cCamp)

Local aArea 	:= GetArea()
Local cQuery	:= ""
Local cArqTmp	:= GetNextAlias()

Default cCodPublis	:= "" 
Default cCamp		:= ""

cQuery	:= " SELECT SUM(PZ9_VLCONS) PZ9_VLCONS FROM "+RetSqlName("PZ9")
cQuery	+= " WHERE D_E_L_E_T_ = ' ' "
cQuery	+= " AND PZ9_FILIAL = '"+xFilial("PZ9")+"' "
cQuery	+= " AND PZ9_PUBLIS = '"+cCodPublis+"' "
cQuery	+= " AND PZ9_CAMP  = '"+cCamp+"' "

dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)

If (cArqTmp)->(!Eof())
	                   
	//Atualiza o saldo da tabela PZ8
	NCSldPZ8(cCodPublis, cCamp, (cArqTmp)->PZ9_VLCONS)
Else

	//Atualiza o saldo da tabela PZ8
	NCSldPZ8(cCodPublis, cCamp, 0)
EndIf

(cArqTmp)->(DbCloseArea())

RestArea(aArea)
Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCSldPZ8  �Autor  �Elton C.	        � Data �  13/09/13 	  ���
�������������������������������������������������������������������������͹��
���Desc.     � atualiza o saldo da campanha do publisher 				  ���
���          � 											  				  ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function NCSldPZ8(cCodPublis, cCamp, nValCon)

Local aArea 	:= GetArea()
Local cQuery	:= ""
Local cArqTmp	:= GetNextAlias()
Local nCnt		:= 0
Local nValRat	:= 0

Default cCodPublis	:= "" 
Default cCamp 		:= ""
Default nValCon		:= 0

cQuery	:= " SELECT R_E_C_N_O_ RECNOPZ8 FROM "+RetSqlName("PZ8")+" PZ8 "

cQuery	+= " WHERE PZ8.PZ8_FILIAL = '"+xFilial("PZ8")+"' "
cQuery	+= " AND PZ8.PZ8_PUBLIS = '"+cCodPublis+"' "
cQuery	+= " AND PZ8.PZ8_CAMP  = '"+cCamp+"'  "
cQuery	+= " AND PZ8.D_E_L_E_T_ = ' ' "

dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)

(cArqTmp)->( dbGoTop() )
(cArqTmp)->( dbEval( { || nCnt++ },,{ || !Eof() } ) )
(cArqTmp)->( dbGoTop() )


If nCnt > 0 
	
	//Efetua o rateio do valor para os itens da campanha
	If nValCon > 0
		nValRat := nValCon / nCnt
	Else
		nValRat := 0	
	EndIf
	
	DbSelectArea("PZ8")
	DbSetOrder(1)
	
	While (cArqTmp)->(!Eof())
		
		PZ8->(DbGoTo((cArqTmp)->RECNOPZ8))		           
		
		Reclock("PZ8",.F.)
	    PZ8->PZ8_VLCONS := nValRat
	    PZ8->PZ8_SALDO  := PZ8->PZ8_VLREPS - PZ8->PZ8_VLCONS
	    PZ8->PZ8_STATUS	:= GetStatus(PZ8->PZ8_VLREPS, PZ8->PZ8_VLCONS, PZ8->PZ8_SALDO)
	    PZ8->(MsUnlock())
	                       
	    //Atualiza o saldo do cabe�alho PZ7
	    u_NCAtuRPP(cCodPublis)
	    
		(cArqTmp)->(DbSkip())
	EndDo
	
EndIf


(cArqTmp)->(DbCloseArea())

RestArea(aArea)
Return  

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCINPP02  �Autor  �Elton C.	        � Data �  13/09/13 	  ���
�������������������������������������������������������������������������͹��
���Desc.     � Rotina utilizad apara incluir saldo no cabe�alho 		  ���
���          � do controle de Price Protection			  				  ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function NCINPP02(cCodPublis)

Local aArea 	:= GetArea()
Local cQuery	:= ""
Local cArqTmp	:= GetNextAlias()
                         
Default cCodPublis := ""

cQuery	:= " SELECT SUM(PZ8_VLREPS) PZ8_VLREPS, SUM(PZ8.PZ8_VLCONS) PZ8_VLCONS, SUM(PZ8.PZ8_SALDO) PZ8_SALDO, "
cQuery	+= "  PZ8_PUBLIS, CTD_DESC01  FROM "+RetSqlName("PZ8")+" PZ8 "


cQuery	+= " INNER JOIN "+RetSqlName("CTD")+" CTD "
cQuery	+= " ON CTD.CTD_FILIAL = '"+xFilial("CTD")+"' "
cQuery	+= " AND CTD.CTD_ITEM = PZ8.PZ8_PUBLIS "
cQuery	+= " AND CTD.D_E_L_E_T_ = ' ' "


cQuery	+= " WHERE PZ8.PZ8_FILIAL = '"+xFilial("PZ8")+"' "
cQuery	+= " AND PZ8.PZ8_PUBLIS = '"+cCodPublis+"' "
cQuery	+= " AND PZ8.D_E_L_E_T_ = ' ' "
cQuery	+= " GROUP BY PZ8_PUBLIS, CTD_DESC01 "

dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)

If (cArqTmp)->(!Eof())

	DbSelectArea("PZ7")
	DbSetOrder(1)
	
	Reclock("PZ7",.T.)
	PZ7->PZ7_FILIAL := xFilial("PZ7")
    PZ7->PZ7_PUBLIS := (cArqTmp)->PZ8_PUBLIS
    PZ7->PZ7_DPUBLI	:= (cArqTmp)->CTD_DESC01
    PZ7->PZ7_VLREPS := (cArqTmp)->PZ8_VLREPS
    PZ7->PZ7_VLCONS := (cArqTmp)->PZ8_VLCONS
    PZ7->PZ7_SALDO  := (cArqTmp)->PZ8_SALDO
    
	PZ7->(MsUnLock())                      
	
EndIf

(cArqTmp)->(DbCloseArea())

RestArea(aArea)
Return




/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �GetCodPub  �Autor  �Elton C.	        � Data �  13/09/13 	  ���
�������������������������������������������������������������������������͹��
���Desc.     � Retorna o codigo do Publisher de acordo com o codigo do	  ���
���          � Price Protection							  				  ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function GetCodPub(cCodPP)

Local aArea 	:= GetArea()
Local cCodRet	:= ""
Local cQuery   	:= ""
Local cArqTmp	:= GetNextAlias()

cQuery    := " SELECT P05_CODPP, P05_VALOR, P05_PPPUB, P0C_PUBLIS, P0C_DPUBLI, P0C_CAMP FROM "+RetSqlName("P05")+" P05 "+CRLF

cQuery    += " INNER JOIN "+RetSqlName("P0C")+" P0C "+CRLF
cQuery    += " ON P0C.P0C_FILIAL = P05.P05_FILIAL "+CRLF
cQuery    += " AND P0C.P0C_PPPUB = P05.P05_PPPUB "+CRLF
cQuery    += " AND P0C.D_E_L_E_T_ = ' ' " +CRLF

cQuery    += " WHERE P05.P05_FILIAL = '"+xFilial("P05")+"' "+CRLF
cQuery    += " AND P05.P05_CODPP = '"+cCodPP+"' "+CRLF
cQuery    += " AND P05.D_E_L_E_T_ = ' ' "+CRLF

dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)

If (cArqTmp)->(!Eof())
	cCodRet := (cArqTmp)->P0C_PUBLIS	
EndIf

(cArqTmp)->(DbCloseArea())
RestArea(aArea)
Return cCodRet                    



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �GetStatus  �Autor  �Elton C.	        � Data �  13/09/13 	  ���
�������������������������������������������������������������������������͹��
���Desc.     � Retorna o Status de consumo								  ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function GetStatus(nVlRep, nVlCons, nVlSaldo)

Local aArea := GetArea() 
Local cRet	:= ""

Default nVlRep		:= 0 
Default nVlCons		:= 0 
Default nVlSaldo    := 0

If nVlRep == nVlSaldo
	cRet	:= "3"	//Saldo total em aberto
ElseIf  nVlSaldo != 0 .And. nVlCons != 0
	cRet	:= "4"	//Saldo parcial
ElseIf nVlSaldo != 0
	cRet	:= "5"	//Sem saldo
EndIf

RestArea(aArea)
Return cRet




User Function XXE()

RpcClearEnv()
RpcSettype(3)
RpcSetEnv("01","03")


u_NCAtuRPP("1314")

Return