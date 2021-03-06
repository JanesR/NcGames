#INCLUDE "TOPCONN.CH"
#INCLUDE "PROTHEUS.CH"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NcVTransp  �Autor  �Microsiga 	     � Data �  09/04/10   ���
�������������������������������������������������������������������������͹��
���Desc.     �Verifica se a forma de entrega ja existe para outra 		  ���
���          �transportadora	                                          ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function NcVTransp(nCodCia)

Local aArea 	:= GetArea()
Local cQuery   := ""
Local cArqTmp	:= GetNextAlias()
Local lRet		:= .T.

Default nCodCia := 0

If nCodCia == 0
	Return (.t.)
EndIf

cQuery   := " SELECT A4_COD FROM "+RetSqlName("SA4")+" SA4 "+CRLF
cQuery   += " WHERE SA4.D_E_L_E_T_ = ' ' "+CRLF
cQuery   += " AND SA4.A4_FILIAL = '"+xFilial("SA4")+"' "+CRLF
cQuery   += " AND SA4.A4_ZCODCIA = '"+Alltrim(str(nCodCia))+"'  "+CRLF

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cArqTmp, .F., .F.)

If (cArqTmp)->(!Eof())
	lRet		:= .F.
	Aviso("VldTransportadora","Forma de entrega E-commerce j� cadastrado para a transportadora "+(cArqTmp)->A4_COD,{"Ok"},2)
EndIf


(cArqTmp)->(DbCloseArea())
RestArea(aArea)
Return lRet
