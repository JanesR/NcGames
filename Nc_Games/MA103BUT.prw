#Include 'Protheus.ch'



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �MA103BUT  �Autor  �Microsiga		    � Data �  06/16/10   ���
�������������������������������������������������������������������������͹��
���Desc.     �Adiciona bot�es na tela do documento de entrada				���
���          � 	                          								    ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function MA103BUT()
Local aArea 	:= GetArea()
Local aRet		:= {}

aadd(aRet, {'Consult.Produto Loja', {|| U_NCCPRDLJ()}, 'Consult.Produto Loja'})

RestArea(aArea)
Return aRet

