#INCLUDE "PROTHEUS.CH"


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �F330AE5I�Autor  �Elton C.	         � Data �  02/24/10   	  ���
�������������������������������������������������������������������������͹��
���Desc.     �Ponto de entrada utilizado na compensa��o de titulo	 	  ���
���          �                                       					  ���
�������������������������������������������������������������������������͹��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function F330AE5I()

Local aArea := GetArea()


//Chama a rotina para atualizar o controle de rapasse do Price Protection, caso encontre o titulo na tabela PZ5.
AtuPZ5CRIn(SE5->E5_PREFIXO, SE5->E5_NUMERO, SE5->E5_PARCELA, SE5->E5_TIPO, SE5->E5_VALOR)

RestArea(aArea)
Return         




/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �AtuPZ5CRIn�Autor  �Elton C.	         � Data �  02/24/10   ���
�������������������������������������������������������������������������͹��
���Desc.     �Atualiza a tabela PZ5 - Controle de Reapsse com o valor 	  ���
���          �da compensa��o da NCC                                       ���
�������������������������������������������������������������������������͹��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function AtuPZ5CRIn(cPrefixo, cNumTit, cParcela, cTipo, nValCp)

Local aArea 	:= GetArea()
Local cQuery	:= ""
Local cArqTmp	:= GetNextAlias()
Local lRet		:= .T.

Default cPrefixo	:= "" 
Default cNumTit		:= "" 
Default cParcela	:= "" 
Default cTipo		:= ""
Default nValCp		:= 0

cQuery	:= " SELECT R_E_C_N_O_ RECNOPZ5 FROM "+RetSqlName("PZ5")+" PZ5 "+CRLF
cQuery	+= " WHERE PZ5.D_E_L_E_T_ = ' ' "+CRLF
cQuery	+= "  AND PZ5_FILIAL = '"+xFilial("PZ5")+"' "+CRLF
cQuery	+= "  AND PZ5.PZ5_PREFIX = '"+cPrefixo+"' "+CRLF
cQuery	+= "  AND PZ5.PZ5_TITULO = '"+cNumTit+"' "+CRLF
cQuery	+= "  AND PZ5.PZ5_PARCEL = '"+cParcela+"' "+CRLF
cQuery	+= "  AND PZ5.PZ5_TIPO = '"+cTipo+"' "+CRLF


cQuery := ChangeQuery(cQuery)
dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cArqTmp,.T.,.T.)

(cArqTmp)->(DbGoTop())

DbSelectArea("PZ5")
DbSetOrder(1)

While (cArqTmp)->(!Eof())
    
    PZ5->(DbGoTo((cArqTmp)->RECNOPZ5))
	
	If PZ5->(Reclock("PZ5",.F.))
		PZ5->PZ5_VALUSA := (PZ5->PZ5_VALUSA + nValCp)//Atualiza o valor utilizado
		PZ5->PZ5_VALSLD := (PZ5->PZ5_VALSLD - nValCp)//Atualiza o saldo
		
		If PZ5->PZ5_VALSLD == 0
			PZ5->PZ5_STATUS := "3"//Aplicado
		Else
			PZ5->PZ5_STATUS := "2"//Parcialmente Aplicado
		EndIf       
		
		//Chama a rotina de atualiza��o do cabe�alho
//		U_UpCabPZ6(PZ5->PZ5_CLIENT, PZ5->PZ5_LOJA, 2)
	
	Else
		lRet := .F.
	EndIf
	PZ5->(MsUnLock())
	
			
	(cArqTmp)->(DbSkip())
EndDo

(cArqTmp)->(DbCloseArea())
RestArea(aArea)
Return lRet