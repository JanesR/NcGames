#include "rwmake.ch"
User Function NFatg04

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NFATG04   �Autor  �Microsiga           � Data �  24/08/04   ���
�������������������������������������������������������������������������͹��
���Desc.     �Retorna grupo de produtos                                   ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Local _aArea  :=GetArea()
Local _cGrupo :=""

IF Substr(M->B1_COD,1,2) =="01" .and. Substr(M->B1_COD,5,2) == "01"
	_cGrupo:="0001" // 
ElseIF Substr(M->B1_COD,1,2) =="01" .and. Substr(M->B1_COD,5,2) == "02"
	_cGrupo:="0002"
ElseIF Substr(M->B1_COD,1,2) =="01" .and. Substr(M->B1_COD,5,2) == "03"
	_cGrupo:="0003"
ElseIF Substr(M->B1_COD,1,2) =="01" .and. Substr(M->B1_COD,5,2) == "04"
	_cGrupo:="0004"	
ElseIF Substr(M->B1_COD,1,2) =="01" .and. Substr(M->B1_COD,5,2) == "05"
	_cGrupo:="0005"
ElseIF Substr(M->B1_COD,1,2) =="01" .and. Substr(M->B1_COD,5,2) == "06"
	_cGrupo:="0006"
ElseIF Substr(M->B1_COD,1,2) =="01" .and. Substr(M->B1_COD,5,2) == "07"
	_cGrupo:="0007"
ElseIF Substr(M->B1_COD,1,2) =="01" .and. Substr(M->B1_COD,5,2) == "08"
	_cGrupo:="0008"
ElseIF Substr(M->B1_COD,1,2) =="01" .and. Substr(M->B1_COD,5,2) == "09"
	_cGrupo:="0009"	
ElseIF Substr(M->B1_COD,1,2) =="01" .and. Substr(M->B1_COD,5,2) == "10"
	_cGrupo:="0010"	
ElseIF Substr(M->B1_COD,1,2) =="02" .and. Substr(M->B1_COD,5,2) == "01" //PSX2
	_cGrupo:="0011"	
ElseIF Substr(M->B1_COD,1,2) =="02" .and. Substr(M->B1_COD,5,2) == "02" //GC
	_cGrupo:="0012"	
ElseIF Substr(M->B1_COD,1,2) =="02" .and. Substr(M->B1_COD,5,2) == "03" //GBA
	_cGrupo:="0013"	
ElseIF Substr(M->B1_COD,1,2) =="02" .and. Substr(M->B1_COD,5,2) == "04" //XB
	_cGrupo:="0014"	
ElseIF Substr(M->B1_COD,1,2) =="02" .and. Substr(M->B1_COD,5,2) == "05" //PSX1
	_cGrupo:="0015"	
ElseIF Substr(M->B1_COD,1,2) =="02" .and. Substr(M->B1_COD,5,2) == "06" //PSX2
	_cGrupo:="0016"	
ElseIF Substr(M->B1_COD,1,2) =="02" .and. Substr(M->B1_COD,5,2) == "10" //SN
	_cGrupo:="0018"	
ElseIF Substr(M->B1_COD,1,2) =="02" .and. Substr(M->B1_COD,5,2) == "08" //PSX2
	_cGrupo:="0019"	
ElseIF Substr(M->B1_COD,1,2) =="02" .and. Substr(M->B1_COD,5,2) == "09" //NGAGE
	_cGrupo:="0029"		
EndIF
RestArea(_aArea)
Return(_cGrupo)