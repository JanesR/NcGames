/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �MTA103MNU �Autor  �Microsiga           � Data �  06/20/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function MTA103MNU()

If cEmpAnt$"03*40"
	aAdd(aRotina,{OemToAnsi("Enviar para Conferencia Loja"), "U_NCGINT001", 0 , 2, 0, nil})
	aAdd(aRotina,{OemToAnsi("Excluir NF Conf. Cega"), "U_NCGINTEX1", 0 , 2, 0, nil})
EndIf

Return 