
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �MA020TOK  �Autor  �Lucas Felipe        � Data �  08/25/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/


User Function MA020TDOK()  

Local lExecuta 	:= .T.// Valida��es do usu�rio para inclus�o de fornecedor
Local cAliasCTD := CTD->(GetArea())
Local lItem		:= .F.

CTD->(DbSetOrder(1))
lItem := CTD->(DbSeek(xFilial("CTD")+"F"+M->A2_COD+M->A2_LOJA))

CTD->(RecLock("CTD",!lItem))

CTD->CTD_ITEM	:= "F"+M->A2_COD+M->A2_LOJA
CTD->CTD_CLASSE	:= "2"
CTD->CTD_DESC01	:= M->A2_NOME
CTD->CTD_BLOQ	:= "2"
CTD->CTD_DTEXIS	:= CtoD("01/01/2014")
CTD->CTD_CLOBRG	:= "2"
CTD->CTD_ACCLVL	:= "1"

CTD->(MsUnlock())
If !IsBlind()
	IIf(lItem==.T.,MsgAlert("O fornecedor "+CTD->CTD_ITEM+" foi alterado"),MsgAlert("O fornecedor "+CTD->CTD_ITEM+" foi incluso"))
EndIf
RestArea(cAliasCTD)
   
Return (lExecuta)