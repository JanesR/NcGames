#INCLUDE "TOPCONN.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#include "ap5mail.ch"
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �M440FIL  �Autor  �Microsiga  	        � Data �  09/04/10   ���
�������������������������������������������������������������������������͹��
���Desc.     �Ponto de entrada para filtro do Browse da libera��o do 	  ���
���          �pedido de venda                                             ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function M440FIL()
Local aArea 	:= GetArea()
Local cRetFil	:="@ C5_YORIGEM=' ' "
Local lPvSite	:=IsInCallStack("U_ECM08LPV")                    
Local lLibADM	:=IsInCallStack("U_M001LibAdm")
Local lPedWm	:=IsInCallStack("U_WM001LB")
                      
                      
If lPvSite	
	cRetFil	+=" AND C5_XECOMER='C' " 	
ElseIf lPedWm
	cRetFil	:="@ C5_YORIGEM='WM' "
Else
	cRetFil	+=" AND C5_XECOMER <> 'C' " 	
	
	If lLibADM
		cRetFil	+=" And C5_XSTAPED In('10','15')	   
		cRetFil	+=" And C5_YSTATUS In('01','06')	   
		cRetFil	+=" And C5_LIBEROK=' ' "
		cRetFil	+=" And C5_NOTA=' '"
		cRetFil	+=" And C5_BLQ=' ' "
		cRetFil	+=" And C5_BLQ=' ' "		
		cRetFil	+=" And Not Exists ( Select 'X' From "+RetSqlName("SC9")+" SC9 Where C9_FILIAL=C5_FILIAL And C9_PEDIDO=C5_NUM And SC9.D_E_L_E_T_	=' ')"	
	
	Endif
	
EndIf


RestArea(aArea)
Return  cRetFil
