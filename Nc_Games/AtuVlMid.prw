#include "Totvs.ch"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NOVO6     �Autor  �Microsiga           � Data �  03/31/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function AtuVlMid() 
	
	Local nRet := 0
	Local nValMid := SuperGetMv("NC_VALMID",.F.,4.80)
	Local cPosIpi := SuperGetMv("NC_NCMMID",.F.,"85234990")

	If AllTrim(M->B1_POSIPI) == AllTrim(cPosIpi)
		nRet := nValMid
	EndIf

Return nRet


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �ATUVLMID  �Autor  �Microsiga           � Data �  03/31/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function VVlMid()

	Local lRet := .T.
	Local cPosIpi := SuperGetMv("NC_NCMMID",.F.,"85234990")

	If AllTrim(M->B1_POSIPI) == AllTrim(cPosIpi)
		lRet := .F. // N�o pode alterar o campo 
	EndIf
	
Return lRet