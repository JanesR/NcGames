#include "rwmake.ch"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CTB001    �Autor  �Microsiga           � Data �  01/09/14   ���
�������������������������������������������������������������������������͹��
���Desc.     � Fun��o para utiliza��o no lan�amento padr�o de nota fiscal ���
���          � de importa��o                                              ���
���          � Retorna o valor do II, Frete e Seguro                      ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function CTB001(cDoc,cSerie,cFornece,cLoja,cItem)

Local nValor	:= 0
Local aArea		:= GetArea()
Local aAreaSWN	:= SWN->(GetArea())

DbSelectArea("SWN")
SWN->(DbOrderNickName("SWNNFSD1"))
SWN->(DbSeek(xFilial("SWN")+cDoc+cSerie+cFornece+cLoja+cItem))
While SWN->(!eof()) .and. xFilial("SWN")+cDoc+cSerie+cFornece+cLoja+cItem == SWN->(WN_FILIAL+WN_DOC+WN_SERIE+WN_FORNECE+WN_LOJA+WN_ITEM)

	nValor	+= SWN->WN_IIVAL + SWN->WN_SEGURO + SWN->WN_FRETE

	SWN->(DbSkip())
End

RestArea(aAreaSWN)
RestArea(aArea)

Return nValor




#include "rwmake.ch"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CTB002    �Autor  �Microsiga           � Data �  01/09/14   ���
�������������������������������������������������������������������������͹��
���Desc.     � Fun��o para utiliza��o no lan�amento padr�o de nota fiscal ���
���          � de importa��o                                              ���
���          � Retorna o valor do Seguro                      ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function CTB002(cDoc,cSerie,cFornece,cLoja,cItem)

Local nValor	:= 0
Local aArea		:= GetArea()
Local aAreaSWN	:= SWN->(GetArea())

DbSelectArea("SWN")
SWN->(DbOrderNickName("SWNNFSD1"))
SWN->(DbSeek(xFilial("SWN")+cDoc+cSerie+cFornece+cLoja+cItem))
While SWN->(!eof()) .and. xFilial("SWN")+cDoc+cSerie+cFornece+cLoja+cItem == SWN->(WN_FILIAL+WN_DOC+WN_SERIE+WN_FORNECE+WN_LOJA+WN_ITEM)

	nValor	+= SWN->WN_SEGURO

	SWN->(DbSkip())
End

RestArea(aAreaSWN)
RestArea(aArea)

Return nValor

