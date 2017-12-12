#INCLUDE "TOPCONN.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#include "ap5mail.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณM410FSQL  บAutor  ณMicrosiga           บ Data ณ  08/15/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณPonto de entrada para filtro do Browse do Pedido de Venda   บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
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
