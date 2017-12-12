
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGC002   �Autor  �Microsiga           � Data �  09/16/13   ���
�������������������������������������������������������������������������͹��
���Desc.     � Consulta que retorna o CNPJ da Filial                      ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function NCGC002(cYFilial)

Local aArea		:= GetArea()
Local aAreaSM0	:= SM0->(GetArea())
Local aFiliais	:= {}
Local nRegSM0 	:= SM0->(RECNO())
Local cEmpAtu 	:= SM0->M0_CODIGO
Local cYCGC		:= SM0->M0_CGC

DbSelectArea("SM0")
While SM0->(!eof())
	If cEmpAtu == SM0->M0_CODIGO .and. cYFilial == SM0->M0_CODFIL
		cYCGC		:= SM0->M0_CGC
		exit
	EndIf
	SM0->(dbskip()())
End

SM0->(dbGoto(nRegSM0))

RestArea(aAreaSM0)
RestArea(aArea)

Return cYCGC
