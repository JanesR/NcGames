
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �MT103PN   �Autor  �Microsiga           � Data �  03/12/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �Ponto de Entrada definicao da Operacao                      ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function MT103PN()
Local nInd
Local lRetorno:=.T.
Local cCodOper:=Alltrim(U_MyNewSX6("NCG_000078","51" ,"C","","","",.F. ))

If AllTrim(SF1->F1_X_MSG)=="NCGPR100"                       
	For nInd:=1 To Len(aCols)
		GdFieldPut('D1_OPER',cCodOper,nInd)		
	Next
	SF1->F1_X_MSG:=""
EndIf	           

Return lRetorno