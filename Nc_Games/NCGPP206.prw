#INCLUDE "PROTHEUS.CH"


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGPP206  �Autor  �Elton Santana        � Data �  01/11/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �Cadastro de aprvadores do Price Protection	              ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function NCGPP206()

Local aArea := GetArea()

Private cCadastro	:= "Aprovadores do Price Protection"


AxCadastro( "PZA", cCadastro)

RestArea(aArea)
Return