

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �F080FIL   �Autor  �Microsiga           � Data �  01/28/14   ���
�������������������������������������������������������������������������͹��
���Desc.     � Fun��o para filtrar os t�tulos que ser�o apresentados na   ���
���          � rotina de baixas a receber por lote			              ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/


User Function F080FIL

Local cFiltro	:= ""

cFiltro	:= " !(E2_TIPO$'INV/PRE/PR ')"

Return cFiltro