#INCLUDE "PROTHEUS.CH"
#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFA330ORD บAutor  ณMicrosiga           บ Data ณ  07/29/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ  Ponto de Entrada permite alterar o indice que              ณ
ฑฑบ          ณsera aplicado no Markbrowse                                 บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function FA330ORD
Local nRetorno	  :=IndexOrd() 	
Local cBloquear :=AllTrim(U_MyNewSX6(	"NCG_000065","S"		,"C","Bloquear Compensa็๕es de Clientes Diferentes","","",.F. ))


//Chamado 005963 Bloqueio nas Compensa็๕es de Clientes Diferentes
If MV_PAR02==2  .And. cBloquear=="S"	.And. (MV_PAR03<>cCliente .Or.  MV_PAR04<>cCliente)
	MsgInfo("Bloqueado pela มrea Contabil Compensa็๕es de Clientes Diferentes."+CRLF+"Serแ filtrado somente titulo(s) do cliente "+cCliente+".")
	MV_PAR03:=cCliente
	MV_PAR04:=cCliente
EndIf 


If nRetorno==0 .Or. nRetorno==Nil
	nRetorno:=1
EndIf	


Return  nRetorno