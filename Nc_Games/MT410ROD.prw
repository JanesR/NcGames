
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �MT410ROD  �Autor  �Microsiga           � Data �  09/13/13   ���
�������������������������������������������������������������������������͹��
���Desc.     � Ponto de entrada na montagem/altera��o no rodap� do PV     ���
���          � est� sendo utilizado para realizar o refresh ap�s a        ���
���          � remontagem do split do pedido de vendas                    ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function MT410ROD

If Type('oGetDad:oBrowse')<>"U"
	oGetDad:oBrowse:Refresh()
Endif

Eval(PARAMIXB[1],PARAMIXB[2],PARAMIXB[3],PARAMIXB[4],PARAMIXB[5])

Return