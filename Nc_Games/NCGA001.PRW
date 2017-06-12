#INCLUDE "PROTHEUS.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGA001   ºAutor  ³Microsiga           º Data ³  09/05/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function NCGA001(cPedido,cFilOrigem,cCliOrig,cLojaOrig)
Local aAreaAtu	:=GetArea()
Local cFilDest	:=""

Default cCliOrig:=""
Default cLojaOrig:=""


If U_A001EnvPVTran(cFilOrigem,cPedido,@cFilDest)
	U_M001PZ1Grv("GRAVA_PEDIDO_ORIGEM",,cFilOrigem,cFilDest,cPedido,,,,,,,,,,cCliOrig,cLojaOrig,,)
EndIf


RestArea(aAreaAtu)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGA001   ºAutor  ³Microsiga           º Data ³  09/17/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function A001EnvPVTran(cFilOrigem,cPedido,cFilDest)
Local aAreaAtu	:=GetArea()
Local aAreaSC5	:=SC5->(GetArea())
Local aAreaSC6	:=SC6->(GetArea())
Local lRetorno  :=.F.
Local cGerarPV	:= Alltrim(U_MyNewSX6(	"NCG_100000","S"		,"C","Gerar Pedido de Transferencia na Matriz","Gerar Pedido de Transferencia na Matriz","Gerar Pedido de Transferencia na Matriz",.F. ))
Local cFilPV	:= Alltrim(U_MyNewSX6(	"NCG_100001","04;05"	,"C","Filiais que devem gerar Pedido de Transferencia","Filiais que devem gerar Pedido de Transferencia","Filiais que devem gerar Pedido de Transferencia",.F. ))

cFilDest	:= Alltrim(U_MyNewSX6(	"NCG_100003","03"	   ,"C","Filial Destino PV Transferencia","Filial Destino PV Transferencia","Filial Destino PV Transferencia",.F. ))

If cGerarPV=="N"  .Or. !(cFilOrigem$cFilPV) .Or. IsInCallStack("U_NCGJ001")
	Return .F.
EndIf



SC5->(DbSetOrder(1))//C5_FILIAL+C5_NUM
SC6->(DbSetOrder(1))//C6_FILIAL+C6_NUM+C6_ITEM+C6_PRODUTO

If SC5->(DbSeek(cFilOrigem+cPedido)) .And. SC5->C5_TIPO=="N"
	SC6->(DbSeek(cFilOrigem+cPedido))
	
	Do While SC6->(C6_FILIAL+C6_NUM)==cFilOrigem+cPedido
		If AvalTes(SC6->C6_TES,'S','S')
			lRetorno:=.T.
			Exit
		EndIf
		SC6->(DbSkip())
	EndDo
EndIf

RestArea(aAreaSC5)
RestArea(aAreaSC6)
RestArea(aAreaAtu)


Return lRetorno
