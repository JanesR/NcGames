#include "rwmake.ch"
User Function NFatg03

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NFATG03   �Autor  �Microsiga           � Data �  24/08/04   ���
�������������������������������������������������������������������������͹��
���Desc.     �Retorna fator de conversao                                  ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Local _aArea  :=GetArea()
Local _nFator :=0

IF Substr(M->B1_COD,1,2) =="01" .and. Substr(M->B1_COD,5,2) $ "05/10/08/11/12" //"05/10/08/11/12/15"
	_nFator:=0.15
ElseIF Substr(M->B1_COD,1,2) =="01" .and. Substr(M->B1_COD,5,2) =="07"
	_nFator:=0.25
ElseIF Substr(M->B1_COD,1,2) =="01" .and. Substr(M->B1_COD,5,2) $ "06/03"
	_nFator:=0.10
ElseIF Substr(M->B1_COD,1,2) == "01" .and. Substr(M->B1_COD,5,2) $ "01/02/04/13/14/15/16" //"01/02/04/13"
	_nFator:=0.23	
EndIF
RestArea(_aArea)
Return(_nFator)