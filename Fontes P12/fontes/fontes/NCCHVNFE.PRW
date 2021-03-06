#INCLUDE "PROTHEUS.CH"


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Funcao    �NCCHVNFE	�Autor  �Microsiga		     � Data �  29/10/2014 ���
�������������������������������������������������������������������������͹��
���Desc.     � Rotina utilizada para retornar a chave da NF de sa�da      ���
���          � de acordo com o prefixo e numero do titulo                 ���
�������������������������������������������������������������������������͹��
���Uso       � Ap		                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function NCCHVNFE()

Local aArea 	:= GetArea()
Local cRet		:= ""
Local cQuery    := ""
Local cArqTmp	:= GetNextAlias()
/*
cQuery    := " SELECT F2_CHVNFE FROM "+RetSqlName("SF2")+" SF2 "+CRLF
cQuery    += " WHERE SF2.F2_FILIAL = '"+xFilial("SF2")+"' "+CRLF
cQuery    += " AND SF2.F2_PREFIXO = '"+SE1->E1_PREFIXO+"' "+CRLF
cQuery    += " AND SF2.F2_DUPL = '"+SE1->E1_NUM+"' "+CRLF
cQuery    += " AND SF2.F2_CLIENTE = '"+SE1->E1_CLIENTE+"' "+CRLF
cQuery    += " AND SF2.F2_LOJA = '"+SE1->E1_LOJA+"' "+CRLF
cQuery    += " AND SF2.D_E_L_E_T_ = ' ' "+CRLF
*/

cQuery    := " SELECT F2_CHVNFE FROM "+RetSqlName("SF2")+" SF2 "+CRLF
cQuery    += " WHERE SF2.F2_PREFIXO = '"+SE1->E1_PREFIXO+"' "+CRLF
cQuery    += " AND SF2.F2_DUPL = '"+SE1->E1_NUM+"' "+CRLF
cQuery    += " AND SF2.F2_CLIENTE = '"+SE1->E1_CLIENTE+"' "+CRLF
cQuery    += " AND SF2.F2_LOJA = '"+SE1->E1_LOJA+"' "+CRLF
cQuery    += " AND SF2.D_E_L_E_T_ = ' ' "+CRLF

dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)


If (cArqTmp)->(!Eof())
	cRet := (cArqTmp)->F2_CHVNFE
Else
	cRet := ""		
Endif

(cArqTmp)->(DbCloseArea())
RestArea(aArea)
Return cRet