#include "rwmake.ch"
User Function NFatg02

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NFATG02   �Autor  �Microsiga           � Data �  24/08/04   ���
�������������������������������������������������������������������������͹��
���Desc.     �Retorna POS/NCM                                             ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Local _aArea:=GetArea()
Local _cNCM :=""

IF Substr(M->B1_COD,1,2) == "01" .and. Substr(M->B1_COD,5,2) $ "07/09" //"06/07/09" //Jogos
	_cNCM:="95041091"
ElseIF Substr(M->B1_COD,1,2) == "01" .And. Substr(M->B1_COD,5,2) $ "03/11"
	_cNCM:="85234029" //"95049090"  
ElseIF Substr(M->B1_COD,1,2) =="01" .and. Substr(M->B1_COD,5,2) $ "05/02/01/04/10/12/13/14/15/16" //"05/02/01/04/10/12/13"
	_cNCM:="85234029" //"85243900"
ElseIF Substr(M->B1_COD,1,2) =="01" .and. Substr(M->B1_COD,5,2) == "08" 
	_cNCM:="95049000"
ElseIF Substr(M->B1_COD,1,2) =="02" .and. Substr(M->B1_COD,5,2) $ "07/10"  //Acessorios
	_cNCM:="95041099"
ElseIF Substr(M->B1_COD,1,2) =="02" .and. Substr(M->B1_COD,5,2) $ "03/06/11" 
	_cNCM:="95049090"
ElseIF Substr(M->B1_COD,1,2) =="02" .and. Substr(M->B1_COD,5,2) $ "01/04/02/05/08/12/13"
	_cNCM:="85229090" 
ElseIF Substr(M->B1_COD,1,2) =="02" .and. M->B1_TIPO == "CB"
	_cNCM:="85444100"
ElseIF Substr(M->B1_COD,1,2) =="02" .and. M->B1_TIPO == "MD" 
	_cNCM:="85175010"
ElseIF Substr(M->B1_COD,1,2) =="02" .and. M->B1_TIPO == "FT" 
	_cNCM:="85043111"		
EndIF
RestArea(_aArea)
Return(_cNCM)