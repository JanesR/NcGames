#Include 'Protheus.ch'

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �F060QRCP  �Autor  �Microsiga    	   � Data �  05/01/16   	���
�������������������������������������������������������������������������͹��
���Desc.     �PE para altera��o da query de gera��o do bordero	           ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                     	                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������  
*/
User Function F060QRCP()

Local aArea		:= GetArea()
Local cQueryOri 	:= Paramixb[1]
Local cQueryRet	:= ""

MsgRun( "Realizando filtro dos titulos...",, { || cQueryRet := GetQryFil(cQueryOri)  } )

If Empty(cQueryRet)
	cQueryRet := cQueryOri
EndIf

RestArea(aArea)	
Return cQueryRet

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �GetQryFil  �Autor  �Microsiga    	   � Data �  05/01/16   	���
�������������������������������������������������������������������������͹��
���Desc.     �Retorna query com o filtro					                  ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                     	                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������  
*/
Static Function GetQryFil(cQueryOri)


Local aArea		:= GetArea()
Local cOrderByAux	:= " ORDER BY "+ SqlOrder(SE1->(IndexKey()))
Local cQueryAux 	:= ""
Local cQueryRet 	:= ""
Local cRecnoNot	:= ""
Local cFilQry		:= ""
Local cArqTmp		:= GetNextAlias()

Default cQueryOri := ""


//Retira o order by da query	
cQueryAux := StrTran(cQueryOri,cOrderByAux,"")

cQueryAux := ChangeQuery(cQueryAux)

//Cria o arquivo temporario
dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQueryAux) , cArqTmp,.T.,.T.)


//Seleciona os recnos que n�o ser�o enviados para o bordero
While (cArqTmp)->(!Eof())
	
	If !VldNfAut((cArqTmp)->RECNO)
		If Empty(cRecnoNot)
			cRecnoNot += Alltrim(Str((cArqTmp)->RECNO))
		Else
			cRecnoNot += "|"+Alltrim(Str((cArqTmp)->RECNO))
		EndIf
	EndIf 	
	
	(cArqTmp)->(DbSkip())
EndDo


//Filtro adicional na query (Retira os recnos que n�o ser�o utilizados)
If !Empty(cRecnoNot)
	cFilQry :=  "   AND R_E_C_N_O_ NOT IN"+FormatIn(cRecnoNot,"|")
Else
	cFilQry := ""
EndIf

//Monta a query de retorno
cQueryRet := cQueryAux+cFilQry+cOrderByAux


(cArqTmp)->(DbCloseArea())
RestArea(aArea)	
Return cQueryRet


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �VldNfAut  �Autor  �Microsiga          � Data �  05/01/16   	���
�������������������������������������������������������������������������͹��
���Desc.     �Verifica se existe chave da nota fiscal	                  ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                     	                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������  
*/
Static Function VldNfAut(nRecSE1)

Local aArea 	:= GetArea()
Local lRet		:= .T.

Default nRecSE1 := 0

If nRecSE1 > 0
	DbSelectArea("SE1")
	
	SE1->(DbGoTo(nRecSE1))
	
	If !VldNf(SE1->E1_NUM, SE1->E1_PREFIXO, SE1->E1_FILORIG)
		lRet := .F.		
	EndIf
EndIf

RestArea(aArea)
Return lRet


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �VldNf  �Autor  �Microsiga          � Data �  05/01/16   	���
�������������������������������������������������������������������������͹��
���Desc.     �Consulta a NF na SEFAZ					                     ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                     	                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������  
*/
Static Function VldNf(cDoc, cSerie, cFilOri)

Local aArea 	:= GetArea()
Local cQuery	:= ""
Local cArqTmp	:= GetNextAlias()
Local lRet		:= .T.

Default cDoc		:= "" 
Default cSerie	:= ""
Default cFilOri	:= ""


cQuery	:= " SELECT F2_DOC, F2_SERIE, F2_DUPL, F2_PREFIXO, R_E_C_N_O_ RECNOSF2, F2_CHVNFE FROM "+RetSqlName("SF2")+CRLF
cQuery	+= " WHERE F2_FILIAL = '"+cFilOri+"' " +CRLF
cQuery	+= " AND F2_DOC = '"+cDoc+"' "+CRLF
cQuery	+= " AND F2_DUPL = '"+cDoc+"' "+CRLF
cQuery	+= " AND F2_PREFIXO = '"+cSerie+"' "+CRLF
cQuery	+= " AND D_E_L_E_T_ = ' ' "+CRLF

dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cArqTmp,.T.,.T.)


If (cArqTmp)->(!Eof())
	
	//Verifica se existe chave da NFE
	If Empty((cArqTmp)->F2_CHVNFE)	
		lRet := .F.
	EndIf
EndIf

(cArqTmp)->(DbCloseArea())
RestArea(aArea)
Return lRet

