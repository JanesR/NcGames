#INCLUDE "TOPCONN.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#include "ap5mail.ch"
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �M410FSQL  �Autor  �Microsiga           � Data �  08/15/13   ���
�������������������������������������������������������������������������͹��
���Desc.     �Ponto de entrada para filtro do Browse do Pedido de Venda   ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function M410FSQL()
Local cQuery	:=""
Local lPvSimul	:=IsInCallStack("U_PR107PVSIMUL")                    
Local lPvSite	:=IsInCallStack("U_ECOM08PV")                    
Local lPvB2C	:=IsInCallStack("U_ECOM08B2C")                    
Local lPvWM		:=IsInCallStack("U_WM001PV")

If lPvSimul
	cQuery	:="@C5_YORIGEM='SIMULAR' And C5_XECOMER<>'C' " 	
ElseIf lPvSite
	cQuery	:="@C5_YORIGEM=' ' And C5_XECOMER='C'" 		
ElseIf lPvB2C	
	cQuery	:="@C5_YORIGEM=' ' And C5_XECOMER='C' And C5_YCANAL='990001'" 	
ElseIf lPvWM
	cQuery	:="@C5_YORIGEM='WM'" 
Else
	cQuery	:="@C5_YORIGEM=' ' And C5_XECOMER<>'C'" 	
EndIf	

Return  cQuery
