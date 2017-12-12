#include "rwmake.ch"
User Function NFatg01

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NFATG01   �Autor  �Microsiga           � Data �  24/08/04   ���
�������������������������������������������������������������������������͹��
���Desc.     �Retorna percentual de IPI                                   ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Local _aArea:=GetArea()
Local _nIPI := M->B1_IPI

IF Substr(M->B1_COD,1,2) =="01" .and. Substr(M->B1_COD,5,2) $ "03/06/07/09"
	_nIPI:=0  //_nIPI:=30
ElseIF Substr(M->B1_COD,1,2) =="01" .and. Substr(M->B1_COD,5,2) $"05/02/01/04/10" .or. Substr(M->B1_COD,1,2) =="02" .and. M->B1_TIPO =="MD"
	_nIPI:=0 //_nIPI:=15
ElseIF Substr(M->B1_COD,1,2) =="01" .and. Substr(M->B1_COD,5,2)=="08" .or. Substr(M->B1_COD,1,2) =="02" .and. Substr(M->B1_COD,5,2)$ "03/06/11"
	_nIPI:=20
ElseIF Substr(M->B1_COD,1,2) =="02" .and. M->B1_TIPO == "CB"
	_nIPI:=5
ElseIF Substr(M->B1_COD,1,2) =="02" .and. M->B1_TIPO == "FT"
	_nIPI:=10
ElseIF Substr(M->B1_COD,1,2) =="02" .and. Substr(M->B1_COD,5,2) $ "07/10"
	_nIPI:=40
ElseIF Substr(M->B1_COD,1,2) =="02" .and. Substr(M->B1_COD,5,2) $ "01/04/02/05/08"
	_nIPI:=25
ElseIF Substr(M->B1_COD,1,2) =="05" 
	_nIPI:=10
EndIF
RestArea(_aArea)
Return(_nIPI)