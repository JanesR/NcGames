#Include 'Protheus.ch'



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �GP660ROT �Autor  �Microsiga           � Data �  05/14/15    ���
�������������������������������������������������������������������������͹��
���Desc.     �																	 ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function GP660ROT()

Local aArea := GetArea()

Local aRotina := {	{ "Pesquisar"	, 'PesqBrw'  , 0, 1,,.F.},;
					 	{ "Visualizar", 'AxVisual' , 0, 2},;
 					 	{ "Log de Erros", 'fVerLog'  , 0, 2,,.F.},;
					 	{ "Excluir", 'u_NCIDMF'  , 0, 1,,.F.},;
		             	{ "Legenda", 'fMostLeg' , 0, 5,,.F.} }


RestArea(aArea)
Return aRotina

