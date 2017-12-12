
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �GETPRTS   �Autor  �Microsiga           � Data �  08/26/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �Alterando impressora do Windows para o Server.					���
���          �Recebe como par�metro a lista de impressoras instaladas      ���
���          �no windows de onde esteja instalado o Server.						���
���          �Esta lista pode ser manipulada e retorna para SetPrint�		��
���          �em forma de array unidimensional
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/            

User Function GETPRTS()
Local aReturn
Local aPrinter:=ParamIxb

If IsInCallStack("STARTPRINT")
	aReturn:={}
Else
	aReturn:={"Nenhuma Impressora Dispon�vel"}
EndIf	

Return aReturn