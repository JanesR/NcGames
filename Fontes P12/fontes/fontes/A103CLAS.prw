

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NOVO6     �Autor  �Microsiga           � Data �  07/05/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function A103CLAS()
Local cAliasSD1:=ParamIxb[1]
Local nInd



For nInd:=1 To Len(aCols)
	cProduto:=GdFieldGet("D1_COD",nInd)
	GdFieldPut("D1_XDESC", Posicione("SB1",1,xFilial("SB1")+cProduto,"B1_DESC"),nInd )
Next

Return 