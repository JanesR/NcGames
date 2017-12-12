#Include "PROTHEUS.CH "


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCIWMF03 �Autor  �Microsiga 	          � Data � 07/04/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �Cadastro de amarra��o Cliente x Forma de Pagto x Prefixo x  ���
���          �Tipo.  													  ���
���          �Obs. Amarra��o utilizada para identificar o prefixo utiliza ���
���          �na gera��o do titulo no contas a receber, referente a   	  ���
���          �integra��o com o Web Manager  							  ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function NCIWMF03()

Local aArea := GetArea()

DbSelectArea("PZO")
DbSetOrder(1)
Axcadastro( "PZO", "Cadastro de regra para prefixo - WM" )

RestArea(aArea)
Return


