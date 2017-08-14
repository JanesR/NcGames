#INCLUDE "PROTHEUS.CH"
#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCECOM08  ºAutor  ³Microsiga           º Data ³  02/27/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function M08WMenu()

U_M08WMJOB({"01","03",.F.})
U_COM08GRAVA("VERIFICA_RASTREIO_WM" )

Processa( {|| U_COM07WM()},"Status Pedido" )

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCECOM08  ºAutor  ³Microsiga           º Data ³  02/12/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function M08WMJOB(aDados,aAcao)
Local nInd

Default aAcao:={"GRAVA_PEDIDO","VERIFICA_EXPEDICAO","VERIFICA_RASTREIO_WM"}//,,"VERIFICA_ENTREGA","VERIFICA_PAGAMENTO",}
Default aDados:={"01","03",.T.}


For nInd:=1 To Len(aAcao)
	U_NCECOM08( {aDados[1], aDados[2], aAcao[nInd], aDados[3] })
Next

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCECOM08  ºAutor  ³Microsiga           º Data ³  02/17/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function M08WMMen()

Local aAreaAtu	:= GetArea()
Local aAreaZC5	:= ZC5->(GetArea())
Local cNomeArq 	:= "GRAVA_PEDIDOWM"

Local nHDL
Local cNomeArq
Local cMensagem := "A rotina já está sendo executada em outro processo, favor aguarde o fim da execução"

If !Semaforo(.T.,@nHDL,cNomeArq)
	MsgAlert(cMensagem,ProcName(0))
	Return()
EndIf

Processa({|| U_COM08GRAVA("GRAVA_PEDIDO",,,)},"Gravando Pedidos.. ")
Semaforo(.F.,nHDL,cNomeArq)

RestArea(aAreaZC5)
RestArea(aAreaAtu)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCECOM08  ºAutor  ³Microsiga           º Data ³  02/17/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function M08WMCOM(nWMPed)

Local aAreaAtu	:= GetArea()
Local aAreaZC5	:= ZC5->(GetArea())
Local cNomeArq := "GRAVA_PEDIDOWM"

Local nHDL
Local cNomeArq
Local cMensagem := "A rotina já está sendo executada em outro processo, favor aguarde o fim da execução"

If !Semaforo(.T.,@nHDL,cNomeArq)
	MsgAlert(cMensagem,ProcName(0))
	Return()
EndIf

Processa({|| U_COM08GRAVA("GRAVA_PEDIDO",,,nWMPed )},"Gravando Pedido "+AllTrim(Str(nWMPed)) )
Semaforo(.F.,nHDL,cNomeArq)

RestArea(aAreaZC5)
RestArea(aAreaAtu)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCECOM08  ºAutor  ³Microsiga           º Data ³  05/01/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function COM08Menu(aDados)

Local nHDL
Local cNomeArq 	:= "GRAVA_PEDIDOVT"
Local cMensagem := "A rotina já está sendo executada em outro processo, favor aguarde o fim da execução"

If !Semaforo(.T.,@nHDL,cNomeArq)
	MsgAlert(cMensagem,"COM08MENU")
	Return
EndIf

Processa( {|| U_NCECOM08({cEmpAnt,cFilAnt,"GRAVA_PEDIDO",.F.}) }	,"Gravando PV Protheus")

Semaforo(.F.,nHDL,cNomeArq)

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCECOM08  ºAutor  ³Microsiga           º Data ³  09/10/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function Com08Moni(cAcao,aDados,cPVVtex,xPVCia,nRecZC5)

Local aAreaAtu	:= GetArea()
Local aAreaZC5	:= ZC5->(GetArea())

Local nHDL
Local cNomeArq
Local cMensagem := "A rotina já está sendo executada em outro processo, favor aguarde o fim da execução"

Default cPVVtex := ""
Default xPVCia  := ""

If ValType(xPVCia) == "N"
	xPVCia := Alltrim(Str(xPVCia))
EndIf

If Empty(cAcao)
	Return
EndIf

If !Empty(nRecZC5)
	ZC5->(DbGoTo(nRecZC5))
EndIf

If !(ZC5->ZC5_FLAG $ '7|6')
	cNomeArq := cAcao+IIf(ZC5->ZC5_PLATAF=="01","","VT")
	
	If !Semaforo(.T.,@nHDL,cNomeArq)
		MsgAlert(cMensagem,"Com08Moni")
		Return()
	EndIf
	Processa({|| U_COM08GRAVA(cAcao,,cPVVtex,xPVCia)},"Gravando Pedido "+ cPVVtex + xPVCia)
	
	Semaforo(.F.,nHDL,cNomeArq)
Else
	Processa({|| U_COM08GRAVA(cAcao,,cPVVtex,xPVCia)},"Gravando Pedido "+ cPVVtex + xPVCia)
Endif

RestArea(aAreaZC5)
RestArea(aAreaAtu)

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCECOM08  ºAutor  ³Microsiga           º Data ³  05/01/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function COM08Vtex(aDados)

Local nHDL
Local cNomeArq := "GRAVA_PEDIDOVT"

If !Semaforo(.T.,@nHDL,cNomeArq)
	Return
EndIf

Default aDados:={"01","03"}

RpcSetEnv(aDados[1],aDados[2])

U_NCECOM08({aDados[1],aDados[2],"GRAVA_PEDIDO",.T.})

RpcClearEnv()

Semaforo(.F.,nHDL,cNomeArq)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCECOM08  ºAutor  ³Microsiga           º Data ³  03/13/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function COM08GrvPV(aDados)
Default aDados:={"01","03"}

RpcSetEnv(aDados[1],aDados[2])
U_NCECOM08({"01","03","GRAVA_PEDIDO",.t.})
RpcClearEnv()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCECOM08  ºAutor  ³Microsiga           º Data ³  06/06/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function Ecom08Job(aDados)
Default aDados:={"01","03"}
RpcSetEnv(aDados[1],aDados[2])

U_ecom08bol()

RpcClearEnv()

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCECOM08  ºAutor  ³Microsiga           º Data ³  03/11/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function COM08ENTR(aDados)
Default aDados:={"01","03","VERIFICA_ENTREGA",.F.}
U_NCECOM08(aDados)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCE08VER  ºAutor  ³Microsiga           º Data ³  02/20/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Verifica Rastreio                                          º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function NCE08VER()

LJMsgRun("Aguarde o processamento...","Aguarde...",{|| U_NCECOM08({"01","03","VERIFICA_RASTREIO",.F.}) })


Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCECOM08  ºAutor  ³Microsiga           º Data ³  02/20/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function COM08Canc(aDados)

Default aDados:={"01","03","VERIFICA_CANCELAMENTO",.F.}
U_NCECOM08(aDados)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCECOM08  ºAutor  ³Microsiga           º Data ³  02/20/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function COM08Exped(aDados)

Default aDados:={"01","03","VERIFICA_EXPEDICAO",.F.}
U_NCECOM08(aDados)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCECOM08  ºAutor  ³Microsiga           º Data ³  16/03/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function COM08ESTO(aDados)
Default aDados:={"01","03","VERIFICA_ESTORNO",.F.}
U_NCECOM08(aDados)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCECOM08  ºAutor  ³Microsiga           º Data ³  01/30/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function COM08Job(aDados)
Local aAcao:={"GRAVA_PEDIDO","VERIFICA_EXPEDICAO","VERIFICA_ENTREGA","VERIFICA_PAGAMENTO","VERIFICA_RASTREIO","VERIFICA_ESTORNO"}
Local nInd

Default aDados:={"01","03"}

For nInd:=1 To Len(aAcao)
	U_NCECOM08( {aDados[1], aDados[2], aAcao[nInd], .T.})
Next

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCECOM08  ºAutor  ³Microsiga           º Data ³  01/30/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function NCECOM08(aDados)
Local nRecSM0
Local nHDL
Local aAreaAtu
Local lGravou   := .T.
Local lEcomVtex := IsIncallStack("U_COM08VTEX") .Or. IsIncallStack("U_V05RASTREIO")
Local lWMPedido	:= IsIncallStack("U_M08WMJOB") .Or. IsIncallStack("U_NCGWM002") .Or. IsInCallStack("U_M08WMMen")
Local cNomeArq

Default aDados := {"01","03","GRAVA_PEDIDO",.F.}

If Empty(aDados[3])
	Return
EndIf

cNomeArq := aDados[3]

If lEcomVtex
	cNomeArq+="V"
ElseIf lWMPedido
	cNomeArq+="WM"
EndIf

If !Semaforo(.T.,@nHDL,cNomeArq)
	Return()
EndIf

If aDados[4]
	RpcClearEnv()
	RpcSetType( 3 )
	RpcSetEnv(aDados[1],aDados[2])
EndIf

If IsBlind()
	lGravou:=U_COM08GRAVA(aDados[3])
Else
	Processa({||lGravou:=U_COM08GRAVA(aDados[3]) })
EndIf

Semaforo(.F.,nHDL,cNomeArq)

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCECOM08  ºAutor  ³Microsiga           º Data ³  01/30/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function COM08GRAVA(cAcao,aDados,cPvVtex,cNumCia)

Local aAreaAtu	:= GetArea()
Local aAreaSC9	:= SC9->(GetArea() )
Local clAlias	:= GetNextAlias()

Local aCabec
Local aItens
Local aRecZC6

Local cQuery	:= ""
Local cBloqLib 	:= AllTrim(U_MyNewSX6("NCG_000067","S"		,"C","Bloquear Liberacao do PV S=Sim ou N=Nao"	,"","",	.F. ))
Local cBloqEcom	:= AllTrim(U_MyNewSX6("NCG_000074","S"		,"C","Bloquear Gravacao do PV S=Sim ou N=Nao"	,"","",	.F. ))
Local cMvTES 	:= Alltrim(U_MyNewSX6("EC_NCG0001","578"	,"C","TES do Pedido de Venda Site"        	 	,"TES do Pedido de Venda Site","",.F. ))
Local cNotImp	:= Alltrim(U_MyNewSX6("EC_NCG0002","96"		,"C","Status PV que não deve ser importado"		,"Status PV que não deve ser importado","",.F. ))
Local cOperPV	:= Alltrim(U_MyNewSX6("EC_NCG0003","01"	    ,"C","Operacao Pedido de Venda Site"       		,"Operacao do Pedido de Venda Site","",.F. ))
Local cCancPV 	:= Alltrim(U_MyNewSX6("EC_NCG0004","96;90"	,"C","Status para cancelamento do PV"      		,"Status para cancelamento do PV","",.F. ))
Local cLiberPV	:= Alltrim(U_MyNewSX6("EC_NCG0005","10"		,"C","Status para liberação do PV"         		,"Status para liberação do PV","",.F. ))
Local cCondPag	:= Alltrim(U_MyNewSX6("EC_NCG0007","WEB"	,"C","Condicaço de Pagamento E-commerce"   		,"Condicaço de Pagamento E-commerce","",.F. ))
Local cTranspo	:= Alltrim(U_MyNewSX6("EC_NCG0013","864"	,"C","Codigos Transportadora"					,"Codigos Transportadora","Codigos Transportadora",.F. ))
Local nDias		:= U_MyNewSX6("EC_NCG0012","2","N","Numeros de dias de antecedencia para envio de WF de expiração data de entrega","","",.F. )
Local cUser		:= SuperGetMV("EC_NCG0010",,"wsncgames")
Local cPassword	:= SuperGetMV("EC_NCG0011",,"apeei.1453")
Local cUrl		:= Alltrim(U_MyNewSX6("EC_NCG0021",'http://websro.correios.com.br/sro_bin/txect01$.QueryList?P_LINGUA=001&P_TIPO=001&P_COD_UNI=',"C","URL Correrios","","",.F. ))
Local cUrlTra	:= Alltrim(U_MyNewSX6("EC_NCG0025",'https://www.rapiddo.com.br/t/',"C","URL de para montagem do link transportadora","","",.F. ))
Local cTransp		:= "000002"

Local cNumZC5
Local cNotaCanc
Local cMensagem	:= ""
Local cTipoLib
Local cPreVenda
Local cCodRast
Local cUrlAux
Local cHtmlPage
Local cDoc
Local cXML
Local cBody		:= ""
Local cFilSD2
Local cErro
Local cNumCliPV
Local cCliEcom 	:= "000000"

Local nInd
Local nTotSC5
Local nTotal
Local nDiff
Local nCont
local nVlrUnit
Local nDesc3

Local lEnviaWMS := U_MyNewSX6("EC_NCG0019",".F.","L","Enviar WMS apos confirmacao Pagamento?","","",.F. )
Local lEcomVtex	:= IsIncallStack("U_COM08VTEX") .Or. !Empty(cPvVtex) .Or. IsIncallStack("U_COM08Menu")
Local lWMPedido	:= IsIncallStack("U_M08WMJOB") .Or. IsIncallStack("U_NCGWM002") .Or. IsInCallStack("U_M08WMMen")
Local lCredito 	:= .F.
Local lEstoque 	:= .F.
Local lEstornar	:= .F.
Local lConecta
Local lPvVtex
Local lBloqCred
Local bWbile
Local lZerado
Local clUsrBD 	:= Alltrim(U_MyNewSX6("NCG_000019","WMS", "C","Usuário para acessar a base do WMS","","",.F. ))

Local _nCont 	:= 0
Local _aXml 	:= {}
Local _aStatus := {}
Local cError	:= ""
Local cWarning	:= ""
Local oobj
Local oXml

Default cPvVtex	:= ""
Default cNumCia 	:= ""
Default aDados	:= {}

Private aCols	:= {}
Private aHeader	:= {}

Private lMsErroAuto := .F.

SB2->(DbSetOrder(1))
SC9->(DbSetOrder(1))

If IsIncallStack("U_M08WMenu")
	IncProc(cAcao)
EndIf

If cAcao=="GRAVA_PEDIDO"
	
	ChkFile("SF4")
	ChkFile("SB1")
	
	cQuery:=" SELECT ZC5_NUM, "+CRLF
	cQuery+=" 		ZC5_PVVTEX, "+CRLF
	cQuery+=" 		ZC5.R_E_C_N_O_ RecZC5, "+CRLF
	cQuery+=" 		ZC6.R_E_C_N_O_ RecZC6 "+CRLF
	cQuery+=" FROM "+RetSqlName("ZC5")+" ZC5, "+CRLF
	cQuery+=" 		 "+RetSqlName("ZC6")+" ZC6 "+CRLF
	cQuery+=" WHERE ZC5.ZC5_FILIAL = '"+xFilial("ZC5")+"' "+CRLF
	cQuery+=" And ZC5.ZC5_NUMPV = ' ' "+CRLF
	cQuery+=" And ZC5.ZC5_ESTORN <> 'S' "+CRLF
	cQuery+=" And ZC5.ZC5_STATUS Not In "+FormatIn(cNotImp,",") +CRLF
	cQuery+=" And ZC5.D_E_L_E_T_ = ' '"+CRLF
	cQuery+=" And ZC6.ZC6_FILIAL = '"+xFilial("ZC6")+"' "+CRLF
	
	If lEcomVtex
		
		cQuery+=" And ZC5_PLATAF In ('00','03') "+CRLF
		cQuery+=" And ZC5.ZC5_PVVTEX = ZC6.ZC6_PVVTEX "+CRLF
		cQuery+=" And ZC5.D_E_L_E_T_ = ' ' "+CRLF
		cQuery+=" And ZC6.D_E_L_E_T_ = ' ' "+CRLF
		cQuery+=" And ZC5.ZC5_NOTA = ' ' "+CRLF
		
		If !Empty(cPvVtex)
			cQuery+=" And ZC5.ZC5_PVVTEX='"+cPvVtex+"' "+CRLF
			cQuery+=" And (	ZC5.ZC5_FLAG = ' ' Or ZC5.ZC5_FLAG = '6') "+CRLF
		Else
			cQuery+=" And ZC5.ZC5_FLAG = ' ' "+CRLF
		EndIf
		
		If cBloqLib == "S" .Or. cBloqEcom == "S"
			cQuery+=" And 1=2 "+CRLF	 //Forco retorno falso
		EndIf
		cQuery+=" Order By ZC5.ZC5_PVVTEX, ZC6.ZC6_ITEM "+CRLF
		
	ElseIf lWMPedido
		
		cQuery+=" And ZC5_PLATAF ='WM' "+CRLF
		cQuery+=" And ZC5.ZC5_NUM = ZC6.ZC6_NUM "+CRLF
		cQuery+=" And ZC5.D_E_L_E_T_ = ' ' "+CRLF
		cQuery+=" And ZC6.D_E_L_E_T_ = ' ' "+CRLF
		cQuery+=" And ZC5.ZC5_NOTA = ' ' "+CRLF
		cQuery+=" And ZC5.ZC5_FLAG = ' ' "+CRLF
		cQuery+=" And ZC6.ZC6_PLATAF='WM'"+CRLF
		
		If IsInCallStack("U_NCGWM002")
			cQuery+=" And ZC5.ZC5_NUM='"+AllTrim(Str(ZC5->ZC5_NUM))+"'"+CRLF
		EndIf
		
		cQuery+=" Order By ZC5.ZC5_NUM"+CRLF
		
	Else
		cQuery+=" And ZC5_PLATAF In ('  ','01') "+CRLF
		cQuery+=" And ZC5.ZC5_NUM = ZC6.ZC6_NUM "+CRLF
		cQuery+=" And ZC5.D_E_L_E_T_ = ' ' "+CRLF
		cQuery+=" And ZC6.D_E_L_E_T_ = ' ' "+CRLF
		cQuery+=" And ZC5.ZC5_NOTA = ' ' "+CRLF
		cQuery+=" And ZC6.ZC6_PLATAF='  '"+CRLF
		
		If !Empty(cNumCia)
			cQuery+="  And ZC5.ZC5_NUM='"+cNumCia+"'"+CRLF
			cQuery+=" And ZC5.ZC5_FLAG IN (' ','2','6','7') "+CRLF
		Else
			cQuery+=" And ZC5.ZC5_FLAG in(' ','2') "+CRLF
		EndIf
		
		If cBloqLib=="S" .Or. cBloqEcom=="S"
			cQuery+=" And 1=2"+CRLF	 //Forco retorno falso
		EndIf
		
		cQuery+=" Order By ZC5.ZC5_NUM "+CRLF
		
	EndIf
	
	cQuery:= ChangeQuery(cQuery)
	
	DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),clAlias, .F., .F.)
	
	Do While (clAlias)->(!Eof())
		
		nRecZC5:=(clAlias)->RecZC5
		
		ZC5->(DbGoTo( nRecZC5))
		lPvVtex := ZC5->ZC5_PLATAF $ '00*03'
		
		MyMensagem( ProcName(0)+"-"+ Iif(lPvVtex,"PVVTEX="+ZC5->ZC5_PVVTEX,"PV="+AllTrim(Str(ZC5->ZC5_NUM)) ) )
		
		
		If !Empty(ZC5->ZC5_NUMPV)
			(clAlias)->(DbSkip());Loop
		EndIf
		
		If !COM08VAL()
			
			If lPvVtex
				cNumZC5	:= ZC5->ZC5_PVVTEX
				bWbile	:= {|| (clAlias)->ZC5_PVVTEX == cNumZC5}
			Else
				cNumZC5	:= ZC5->ZC5_NUM
				bWbile	:= {(clAlias)->ZC5_NUM == cNumZC5}
			EndIf
			
			Do While (clAlias)->(!Eof() ) .And. Eval(bWhile)
				(clAlias)->(DbSkip())
			EndDo
			Loop
			
		EndIf
		
		
		
		cDoc := GetSxeNum("SC5","C5_NUM")
		Do While SC5->(DbSeek(xFilial("SC5") +cDoc ))
			ConfirmSX8()
			cDoc := GetSxeNum("SC5","C5_NUM")
		EndDo
		
		RollBAckSx8()
		aCabec 		:= {}
		aItens 		:= {}
		aRecZC6		:= {}
		cTipoLib	:= "1"
		cPreVenda	:= "N"
		
		If lPvVtex
			
			cNumCliPV	:= AllTrim(ZC5->ZC5_SEQUEN)
			nDesc3		:= 0 //ZC5->ZC5_VDESCO
			cCondPag 	:= ZC5->ZC5_CONDPG
			
			SA1->(dbOrderNickName("SA1SALES"))
			SA1->(MsSeek(xFilial("SA1")+cCliEcom+ZC5->ZC5_PLATAF+Trim(ZC5->ZC5_SALES)))
			
			cVendedor	:= SA1->A1_VEND
			
			//JR
			cCanal		:= "990001"
			if ZC5->ZC5_TPECOM == "B2B"
				cCanal		:= "990000"
			Elseif ZC5->ZC5_TPECOM == "B2C"
				cCanal		:= "990001"
			ELSE
				cCanal		:= "990001"
			Endif
			cTransp	:= "000002"
			
		ElseIf lWMPedido
			
			cNumCliPV	:= AllTrim(Str(ZC5->ZC5_NUM))
			nDesc3		:= 0
			
			SA1->(DbSetOrder(1))
			SA1->(DbSeek(xFilial("SA1")+ZC5->ZC5_CLIENT+ZC5->ZC5_LOJA))
			
			cVendedor:= SA1->A1_VEND
			cCondPag := SA1->A1_COND
			
			cCanal		:= SA1->A1_YCANAL
			cTransp	:= SA1->A1_TRANSP
			
		Else
			cNumCliPV	:= AllTrim(Str(ZC5->ZC5_NUM))
			nDesc3		:= 0
			
			SA1->(DbSetOrder(1))
			SA1->(DbSeek(xFilial("SA1")+ZC5->ZC5_CLIENT+ZC5->ZC5_LOJA))
			
			cVendedor	:= SA1->A1_VEND
			
			if ZC5->ZC5_TPECOM == "B2B"
				cCanal		:= "990000"
			Elseif ZC5->ZC5_TPECOM == "B2C"
				cCanal		:= "990001"
			ELSE
				cCanal		:= "990001"
			Endif
			
			cTransp	:= "000002"
			
		EndIf
		
		PtInternal(1,"Pedido Site:"+cNumCliPV)
		
		//cVendedor:=Posicione("SA1",1,xFilial("SA1")+ZC5->ZC5_CLIENT+ZC5->ZC5_LOJA,"A1_VEND")
		aadd(aCabec,{"C5_NUM"   	,cDoc							,Nil})
		aadd(aCabec,{"C5_TIPO" 	   	,"N"							,Nil})
		aadd(aCabec,{"C5_XSTAPED"  	,"15"							,Nil})
		aadd(aCabec,{"C5_XECOMER"  	,IIf(!lWMPedido,"C","P")	,Nil})
		aadd(aCabec,{"C5_CLIENTE"	,ZC5->ZC5_CLIENT				,Nil})
		aadd(aCabec,{"C5_LOJACLI"	,ZC5->ZC5_LOJA					,Nil})
		aadd(aCabec,{"C5_VEND1"    	,cVendedor						,Nil})
		aadd(aCabec,{"C5_MODAL"    	,IIf(!lWMPedido,"2","1")		,Nil})
		aadd(aCabec,{"C5_FRETE"    	,ZC5->ZC5_FRETE					,Nil})
		aadd(aCabec,{"C5_GEROFRE"  	,Iif(ZC5->ZC5_FRETE>0,"1","2")	,Nil})
		aadd(aCabec,{"C5_XCODENT"  	,ZC5->ZC5_CODENT				,Nil})
		aadd(aCabec,{"C5_TRANSP"   	,cTransp						,Nil})
		
		if !Empty(ZC5->ZC5_COND)
			aadd(aCabec,{"C5_XFORMPG"  	,ZC5->ZC5_COND					,Nil})
		EndIf
		
		If Empty(cCondPag) .And. lWMPedido
			cCondPag:=M008CONPG(cCanal)
		EndIf
		
		aadd(aCabec,{"C5_CONDPAG"  	,cCondPag					,Nil})
		aadd(aCabec,{"C5_YCANAL"   	,cCanal						,Nil})
		aadd(aCabec,{"C5_DESPESA"  	,0								,Nil})
		
		If lPvVtex
			If ZC5->ZC5_VDESCO>0
				aadd(aCabec,{"C5_DESC1"	,ZC5->ZC5_VDESCO			,Nil})
			EndIf
			aadd(aCabec,{"C5_YPVECOM",AllTrim(ZC5->ZC5_PVVTEX)		,Nil})
		EndIf
		
		aadd(aCabec,{"C5_DESC3"    ,nDesc3							,Nil})
		aadd(aCabec,{"C5_PEDCLI"   ,cNumCliPV						,Nil})
		
		If lWMPedido
			aadd(aCabec,{"C5_YORIGEM"    ,"WM"							,Nil})
			aadd(aCabec,{"C5_XDESPVV"    ,SA1->A1_EMAIL					,Nil})
		EndIf
		
		dDataEntr   := CM08Entrega(ZC5->ZC5_CODENT)
		
		If !lWMPedido
			aParcelas	:= CM08Parcelas(ZC5->ZC5_QTDPAR)
			
			For nInd:=1 To Len(aParcelas)
				aadd(aCabec,{aParcelas[nInd,1]  ,aParcelas[nInd,2],Nil})	//Parcelas
				aadd(aCabec,{aParcelas[nInd,3]  ,aParcelas[nInd,4],Nil})	//Data Vencimento
			Next
		EndIf
		
		SB5->(DbSetOrder(1))
		
		If lPvVtex
			cNumZC5	:= ZC5->ZC5_PVVTEX
			bWbile	:= {|| (clAlias)->ZC5_PVVTEX==cNumZC5}
		Else
			cNumZC5	:= ZC5->ZC5_NUM
			bWbile	:= {|| (clAlias)->ZC5_NUM==cNumZC5}
		EndIf
		
		Do While (clAlias)->(!Eof() ) .And. Eval(bWbile)
			
			ZC6->(DbGoTo( (clAlias)->RecZC6 ))
			
			If cPreVenda=="N" .And. SB5->(MsSeek(xFilial("SB5")+ZC6->ZC6_PRODUT)) .And. SB5->(FieldPos("B5_YPREVEN"))>0 .And. SB5->B5_YPREVEN=="S"
				cTipoLib :="2"
				cPreVenda:="S"
			EndIf
			
			If lPvVtex .Or. lWMPedido
				If !SB2->(MsSeek(xFilial("SB2")+ZC6->ZC6_PRODUT+ZC6->ZC6_LOCAL))
					CriaSB2(ZC6->ZC6_PRODUT,ZC6->ZC6_LOCAL)
					SB1->(DbSetOrder(1))
					If SB1->(MsSeek(xFilial("SB1")+ZC6->ZC6_PRODUT)) .And. SB1->B1_YCUSTPR==0
						SB1->(RecLock("SB1",.F.))
						SB1->B1_YCUSTPR:=0.1
						SB1->(MsUnLock())
					EndIf
				EndIf
			EndIf
			
			aLinha := {}
			aadd(aLinha,{"C6_ITEM"			,ZC6->ZC6_ITEM,Nil})
			aadd(aLinha,{"C6_PRODUTO"		,ZC6->ZC6_PRODUT,  })
			aadd(aLinha,{"C6_QTDVEN"		,ZC6->ZC6_QTDVEN,Nil})
			aadd(aLinha,{"C6_OPER"			,cOperPV,Nil})
			aadd(aLinha,{"C6_LOCAL"			,ZC6->ZC6_LOCAL,Nil})
			
			nVlrUnit:=ZC6->ZC6_VLRUNI*(1-(ZC5->ZC5_PDESCON)/100)
			
			If !lWMPedido
				aadd(aLinha,{"C6_PRCVEN"		,nVlrUnit,Nil})
				aadd(aLinha,{"C6_PRUNIT"		,nVlrUnit,Nil})
			EndIf
			
			aadd(aLinha,{"C6_ENTREG"		,dDataEntr ,Nil})
			
			
			aadd(aRecZC6, (clAlias)->RecZC6 )
			aadd(aItens,aLinha)
			(clAlias)->(DbSkip())
		EndDo
		
		aadd(aCabec,{"C5_TIPLIB"   	,cTipoLib	,Nil})
		aadd(aCabec,{"C5_YPREVEN"	,cPreVenda	,Nil})
		
		
		U_COM08SIMUL(aCabec,aItens,lWMPedido)
		
		ZC5->(DbGoTo( nRecZC5))
		
		If !(ZC5->ZC5_PLATAF $ '  |01|WM')
			
			ZC5->(RecLock("ZC5",.F.))
			
			ZC5->ZC5_FLAG:= "7" //processando pedido
			
			ZC5->(MsUnLock())
			
		EndIf
		
		MyMensagem( "MsExecAuto MATA410 - "+ Iif(lPvVtex,"PVVTEX="+ZC5->ZC5_PVVTEX,"PV="+AllTrim(Str(ZC5->ZC5_NUM)) ) )
		Begin Transaction
		lMsErroAuto := .F.
		//MATA410(aCabec,aItens,3)
		MsExecAuto({|x,y,z| MATA410(x,y,z)}, aCabec,aItens,3)
		
		cMsg :="Tarefa executada com Sucesso"
		If lMsErroAuto
			cMsg := MemoRead(NomeAutoLog())
			MostraErro('cPath',NomeAutoLog())
			U_NCECOM09(ZC5->ZC5_NUM, ZC5->ZC5_NUMPV,"Erro Inclusão de Pedido de Venda",cMsg,ZC5->ZC5_STATUS,lMsErroAuto,,,ZC5->ZC5_PVVTEX,ZC5->ZC5_PLATAF)
			
			/*---------------------------------------------------------------------------//
			// Atualiza o status atual do pedido (Pedido não gerado por erro)				//
			//---------------------------------------------------------------------------*/
			U_NCEC10CI(ZC5->ZC5_NUM, "001",ZC5->ZC5_PVVTEX)
		Else
			
			ZC5->(DbGoTo( nRecZC5))
			ZC5->(RecLock("ZC5",.F.))
			
			ZC5->ZC5_NUMPV	:= SC5->C5_NUM
			ZC5->ZC5_PREVEN := SC5->C5_YPREVEN
			ZC5->ZC5_FLAG	:= " "
			ZC5->(MsUnLock())
			
			If lPvVtex .And. AllTrim(ZC5->ZC5_TPPGTO)=="6"//Boleto
				
				cBody 		:= U_ECOMHTMG(ZC5->(Recno()))
				cEmailTo	:= Alltrim(U_MyNewSX6("VT_000007","rciambarella@ncgames.com.br","C","E-mail do responsavél financeiro Vtex","","",.F. ))
				cAssunto	:= "Pedido "+AllTrim(Posicione("SA1",1,xFilial("SA1")+"000000"+ZC5->ZC5_PLATAF,"A1_NOME"))+" Nr."+AllTrim(ZC5->ZC5_PVVTEX)+" Forma de Pagamento Boleto"
				
				If !U_COM08SEND(cAssunto, cBody, , cEmailTo,, @cErro)
					U_NCECOM09(ZC5->ZC5_NUM, ZC5->ZC5_NUMPV,'Erro ao enviar e-mail para '+cEmailTo,cErro,ZC5->ZC5_STATUS,.T.,,,ZC5->ZC5_PVVTEX)
				EndIf
				
			ElseIf lWMPedido
				
				If ZC5->ZC5_PLATAF == "WM"
					U_WM001Send("PEDIDO",ZC5->ZC5_NUMPV)
				EndIf
				
			EndIf
			
			SC6->(DbSetOrder(1))//C6_FILIAL+C6_NUM+C6_ITEM+C6_PRODUTO
			SC0->(DbSetOrder(1))//C0_FILIAL+C0_NUM+C0_PRODUTO+C0_LOCAL
			
			lPvParcial	:= .F.
			lZerado	:= .T.
			
			For nInd:=1 To Len(aRecZC6)
				ZC6->(DbGoTo(  aRecZC6[nInd]  )	)
				ZC6->(RecLock("ZC6",.F.))
				ZC6->ZC6_QTDRES:=0
				
				If SC6->( DbSeek(xFilial("SC6")+SC5->C5_NUM+ZC6->(ZC6_ITEM+ZC6_PRODUTO)   ) ) .And.   SC0->( DbSeek( xFilial("SC0") +SC6->(C6_RESERVA+C6_PRODUTO+C6_LOCAL)   )   )
					If lPvVtex
						U_NCVTEX03(SC6->C6_PRODUTO)
					
					//JR\\
					ElseIf !lWMPedido
						u_sndPrdUnic(SC6->C6_PRODUTO, SC6->C6_LOCAL)
					EndIf
					
					ZC6->ZC6_QTDRES := SC0->C0_QTDPED
					
					If lWMPedido
						ZC6->ZC6_VLRUNI := SC6->C6_PRCVEN
					EndIf
					
					lZerado := .F.
					If ZC6->ZC6_QTDRES<>ZC6->ZC6_QTDVEN
						lPvParcial:=.T.
					EndIf
					
				Else
					lPvParcial:=.T.
				EndIf
				
				ZC6->(MsUnLock())
				
			Next
			
			SC6->(DbSetOrder(1))//C6_FILIAL+C6_NUM+C6_ITEM+C6_PRODUTO
			SC6->( DbSeek(xFilial("SC6")+ SC5->C5_NUM ))
			Do While SC6->(!Eof()) .And. SC6->(C6_FILIAL+C6_NUM)==xFilial("SC6")+SC5->C5_NUM
				If lPvParcial
					SC6->(RecLock("SC6",.F. ))
					SC6->C6_BLOQUEI := StrZero(1, Len(SC6->C6_BLOQUEI))
					SC6->(MsUnLock())
				ElseIf lWMPedido
					MaLibDoFat(SC6->(Recno()),SC6->C6_QTDVEN ,.F.,.F.,.T.,.T.,.T.)//MaLibDoFat(nRegSC6,nQtdaLib,lCredito,lEstoque,lAvCred,lAvEst,lLibPar,lTrfLocal,aEmpenho,bBlock,aEmpPronto,lTrocaLot,lOkExpedicao,nVlrCred,nQtdalib2)
				EndIf
				
				SC6->(DbSkip())
			EndDo
			
			
			If lWMPedido
				
				U_NCECOM09(ZC5->ZC5_NUM, ZC5->ZC5_NUMPV,"Inclusão do Pedido de Venda"+IIf(cPreVenda=="S","(Pré-Venda)",""),cMsg,ZC5->ZC5_STATUS,lMsErroAuto,,,ZC5->ZC5_PVVTEX)
				
				If !cPreVenda=="S"
					If lZerado
						U_NCECOM09(ZC5->ZC5_NUM, ZC5->ZC5_NUMPV,"Não foi possível reservar nenhum item no estoque",cMsg,ZC5->ZC5_STATUS,lMsErroAuto,,,ZC5->ZC5_PVVTEX)
					ElseIf lPvParcial
						U_NCECOM09(ZC5->ZC5_NUM, ZC5->ZC5_NUMPV,"Pedido parcialmente reservado no estoque",cMsg,ZC5->ZC5_STATUS,lMsErroAuto,,,ZC5->ZC5_PVVTEX)
					Endif
				EndIf
				
				lBloqCred := U_WM001StatPV(SC5->C5_NUM,ZC5->ZC5_NUM,lPvParcial,cPreVenda=="S")
				
				If !lZerado .And. !cPreVenda=="S"
					If lBloqCred
						U_NCECOM09(ZC5->ZC5_NUM, ZC5->ZC5_NUMPV,"Pedido em analise de Crédito.",cMsg,ZC5->ZC5_STATUS,lMsErroAuto,,,ZC5->ZC5_PVVTEX)
					Else
						U_COM08WMS(SC5->C5_NUM,lWMPedido,!lPvParcial)
					Endif
				EndIf
				
				If SC9->(DbSeek(xFilial("SC9")+SC5->C5_NUM ))
					SC5->(RecLock("SC5",.F.))
					SC5->C5_LIBEROK := "S"
					SC5->(MsUnLock())
				EndIf
				
			Else
				
				If lPvParcial
					SC5->(RecLock("SC5",.F. ))
					SC5->C5_BLQ := StrZero(1, Len(SC5->C5_BLQ))
					SC5->(MsUnLock())
				Else
					MaLiberOk({ SC5->C5_NUM }, .F.)
					//Atualiza o status atual do pedido (Pedido gerado e liberado, Aguardando envio para o WMS)
					U_NCEC10CI(ZC5->ZC5_NUM, "002",ZC5->ZC5_PVVTEX)
				EndIf
				U_NCECOM09(ZC5->ZC5_NUM, ZC5->ZC5_NUMPV,"Inclusão do Pedido de Venda",cMsg,ZC5->ZC5_STATUS,lMsErroAuto,,,ZC5->ZC5_PVVTEX)
				
				//Atualiza o status atual do pedido (Pedido gerado, aguardando pagamento)
				U_NCEC10CI(ZC5->ZC5_NUM, "008",ZC5->ZC5_PVVTEX)
				
				IF ZC5->ZC5_NUM != 0
				//Chama a rotina para gravar log de produto bloqeuado por venda no monitor
					U_VNcPrdBlq(ZC5->ZC5_NUM, ZC5->ZC5_NUMPV, 'B2C')
				Else
					//Chama a rotina para gravar log de produto bloqeuado por venda no monitor
					U_VNcPrdBlq(ZC5->ZC5_PVVTEX, ZC5->ZC5_NUMPV, 'B2B')
				EndIF
				
				lEstornar:=.F.
				If lPvParcial
					U_NCECOM09(ZC5->ZC5_NUM, ZC5->ZC5_NUMPV,'Erro Liberacao Estoque','Estoque Insuficiente',ZC5->ZC5_STATUS,.F.,,,ZC5->ZC5_PVVTEX)
					//Atualiza o status atual do pedido (Pedido gerado com estoque insuficiente)
					U_NCEC10CI(ZC5->ZC5_NUM, "003",ZC5->ZC5_PVVTEX)
					COM08EnvMail(aRecZC6,cAcao,lPvVtex)
				EndIf
				
				If lEstornar
					cMsg :="Estorno da Liberacao - Pedido Liberado Parcialmente"
				Else
					//COM08WMS()
				EndIf
			EndIf
		EndIf
		
		End Transaction
		
	EndDo
	
	(clAlias)->(DbCloseArea())
	DbSelectArea("ZC5")
	U_COM08GRAVA("VERIFICA_PAGAMENTO")
	
ElseIf cAcao=="PEDIDO_CANCELADO_MOIP"
	
	cQuery:=" Select ZC5_NUM,ZC5.R_E_C_N_O_ RecZC5, ZC6.R_E_C_N_O_ RecZC6"+CRLF
	cQuery+=" From "+RetSqlName("ZC5")+" ZC5, "+RetSqlName("ZC6")+" ZC6"+CRLF
	cQuery+=" Where ZC5.ZC5_FILIAL='"+xFilial("ZC5")+"'"+CRLF
	cQuery+=" And ZC5.ZC5_NUMPV=' '"+CRLF
	cQuery+=" And ZC5.ZC5_FLAG=' '"+CRLF
	cQuery+=" And ZC5.ZC5_ESTORN<>'S'"+CRLF
	cQuery+=" And ZC5.ZC5_STATUS In "+FormatIn(cNotImp,",")+CRLF
	cQuery+=" And ZC5.ZC5_PLATAF In (' ','01')"+CRLF
	cQuery+=" And ZC5.D_E_L_E_T_=' '"+CRLF
	cQuery+=" And ZC6.ZC6_FILIAL='"+xFilial("ZC6")+"'"	+CRLF
	cQuery+=" And ZC5.ZC5_NUM=ZC6.ZC6_NUM "+CRLF
	cQuery+=" And ZC5.D_E_L_E_T_=' '"+CRLF
	cQuery+=" And ZC6.D_E_L_E_T_=' '"+CRLF
	cQuery+=" Order By ZC5.ZC5_NUM "+CRLF
	
	DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),clAlias, .F., .F.)
	
	Do While (clAlias)->(!Eof())
		
		nRecZC5:=(clAlias)->RecZC5
		
		ZC5->(DbGoTo( nRecZC5))
		cNumZC5:=ZC5->ZC5_NUM
		
		//Atualiza o status atual do pedido (Pedido cancelado pelo MOIP)
		U_NCEC10CI(ZC5->ZC5_NUM, "004",ZC5->ZC5_PVVTEX)
		Do While (clAlias)->(!Eof() ) .And. (clAlias)->ZC5_NUM==cNumZC5
			ZC6->(DbGoTo( (clAlias)->RecZC6 ))
			aadd(aRecZC6, (clAlias)->RecZC6 )
			(clAlias)->(DbSkip())
		EndDo
		
		Begin Transaction
		
		U_ECOMHTMB(aRecZC6)
		
		ZC5->(DbGoTo( nRecZC5))
		ZC5->(RecLock("ZC5",.F.))
		
		ZC5->ZC5_NUMPV:='CANCEL'
		
		ZC5->(MsUnLock())
		
		End Transaction
	EndDo
ElseIf  cAcao=="VERIFICA_CANCELAMENTO"
	
	cNotaCanc:=Repl("X",Len(SC5->C5_NOTA))
	
	cQuery:=" Select SC5.R_E_C_N_O_  RecSC5,ZC5.R_E_C_N_O_  RecZC5, ZC5_NUM "+CRLF
	cQuery+=" From "+RetSqlName("ZC5")+" ZC5, "+RetSqlName("SC5")+" SC5"+CRLF
	cQuery+=" Where	ZC5.ZC5_FILIAL='"+xFilial("ZC5")+"'"+CRLF
	cQuery+=" And ZC5.ZC5_STATUS  In "+FormatIn(cCancPV,";")+CRLF
	cQuery+=" And ZC5.ZC5_NUMPV=SC5.C5_NUM "  +CRLF
	cQuery+=" And ZC5.ZC5_FLAG=' '"+CRLF
	cQuery+=" And ZC5.D_E_L_E_T_=' '"+CRLF
	cQuery+=" And	SC5.C5_FILIAL='"+xFilial("SC5")+"'"	+CRLF
	cQuery+=" And SC5.D_E_L_E_T_=' '"+CRLF
	cQuery+=" And ZC5_PLATAF<>'WM' "+CRLF
	cQuery+=" Order By SC5.C5_NUM "+CRLF
	
	DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),clAlias, .F., .F.)
	
	SC6->(DbSetOrder(1))//C6_FILIAL+C6_NUM+C6_ITEM+C6_PRODUTO
	SC0->(DbSetOrder(1))//C0_FILIAL+C0_NUM+C0_PRODUTO+C0_LOCAL
	
	Do While (clAlias)->(!Eof())
		
		ZC5->(DbGoTo( (clAlias)->RecZC5 ))
		SC5->(DbGoTo( (clAlias)->RecSC5 ))
		
		If Left(SC5->C5_NOTA,2)=="XX"
			(clAlias)->(DbSkip());Loop
		EndIf
		
		If !Empty(SC5->C5_NOTA)
			COM08EnvMail( ,"CANCELAMENTO_SITE_FATURADO" )
			(clAlias)->(DbSkip());Loop
		EndIf
		
		INLCUI:=.F.
		ALTERA:=.T.
		If !U_M410ALOK()
			aStatus:=U_ALOKGetStat(.T.)
			U_NCECOM09(ZC5->ZC5_NUM, ZC5->ZC5_NUMPV,cAcao,aStatus[1],ZC5->ZC5_STATUS,.T.,,,ZC5->ZC5_PVVTEX)
			If aStatus[2]
				//Atualiza o status atual do pedido (Aguardando liberação do WMS para excluir o pedido)
				U_NCEC10CI(ZC5->ZC5_NUM, "005",ZC5->ZC5_PVVTEX)
				COM08EnvMail(,"AGUARDANDO_WMS")
			EndIf
			(clAlias)->(DbSkip());Loop
		EndIf
		
		If !SC6->( DbSeek(xFilial("SC6")+ SC5->C5_NUM ))
			(clAlias)->(DbSkip());Loop
		EndIf
		
		U_C08CANCPV(SC5->C5_NUM)
		
		DbSelectArea("ZC6")
		DbSetOrder(1)
		If ZC6->(DbSeek(xFilial("ZC6") + Alltrim(Str(ZC5->ZC5_NUM))  ))
			aRecZC6 := {}
			Do While (clAlias)->(!Eof() ) .And. ZC6->ZC6_NUM == ZC5->ZC5_NUM
				U_NCVTEX03(ZC6->ZC6_PRODUT)
				//JR
				u_sndPrdUnic(ZC6->ZC6_PRODUT, ZC6->ZC6_LOCAL)
				aadd(aRecZC6, ZC6->(Recno()) )
				
				ZC6->(DbSkip())
			EndDo
			
			U_ECOMHTMB(aRecZC6)
			
		EndIf
		
		ZC5->(RecLock("ZC5",.F.))
		ZC5->ZC5_NOTA:=SC5->C5_NOTA
		ZC5->(MsUnLock())
		
		U_NCECOM09(ZC5->ZC5_NUM, ZC5->ZC5_NUMPV,"Cancelar Pedido de Venda","Executado com sucesso",ZC5->ZC5_STATUS,.T.,,,ZC5->ZC5_PVVTEX)
		
		//Atualiza o status atual do pedido (Pedido cancelado)
		U_NCEC10CI(ZC5->ZC5_NUM, "009",ZC5->ZC5_PVVTEX)
		(clAlias)->(DbSkip())
		
	EndDo
ElseIf  cAcao=="VERIFICA_PAGAMENTO"
	
	cQuery:=" Select SC5.R_E_C_N_O_  RecSC5,ZC5.R_E_C_N_O_  RecZC5"+CRLF
	cQuery+=" From "+RetSqlName("ZC5")+" ZC5, "+RetSqlName("SC5")+" SC5"+CRLF
	cQuery+=" Where ZC5.ZC5_FILIAL='"+xFilial("ZC5")+"'"+CRLF
	
	If !lWMPedido
		cQuery+=" And ZC5.ZC5_STATUS  In "+FormatIn(cLiberPV,",")+CRLF
	EndIf
	
	cQuery+=" And ZC5.ZC5_NUMPV=SC5.C5_NUM "  +CRLF
	cQuery+=" And ZC5.D_E_L_E_T_=' '"+CRLF
	cQuery+=" And SC5.C5_FILIAL='"+xFilial("SC5")+"'"	+CRLF
	cQuery+=" And SC5.C5_NOTA='  ' " 	+CRLF
	cQuery+=" And SC5.D_E_L_E_T_=' '"+CRLF
	
	If lWMPedido
		cQuery+=" And ZC5_NUMPV='"+ZC5->ZC5_NUMPV+"'"+CRLF
		cQuery+=" And ZC5_PLATAF ='WM' "+CRLF
	EndIf
	
	If cBloqLib=="S" .Or. cBloqEcom=="S"
		cQuery+=" And 1=2"+CRLF	 //Forco retorno falso
	EndIf
	
	cQuery+=" And Not Exists (Select 'X' From "+RetSqlName("SC9")+" SC9  Where SC9.C9_FILIAL ='"+xFilial("SC9")+"'  And SC9.C9_PEDIDO=SC5.C5_NUM And SC9.D_E_L_E_T_=' '  )"+CRLF
	cQuery+=" And Exists 	 (Select 'X' From "+RetSqlName("SC0")+" SC0  Where SC0.C0_FILIAL ='"+xFilial("SC0")+"'  And SC0.C0_NUM=SC5.C5_NUM And SC0.D_E_L_E_T_=' '  )"+CRLF
	cQuery+=" Order By SC5.C5_NUM "+CRLF
	
	DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),clAlias, .F., .F.)
	
	SC6->(DbSetOrder(1))//C6_FILIAL+C6_NUM+C6_ITEM+C6_PRODUTO
	SC9->(DbSetOrder(1))//C9_FILIAL+C9_PEDIDO+C9_ITEM+C9_SEQUEN+C9_PRODUTO
	SC0->(DbSetOrder(1))//C0_FILIAL+C0_NUM+C0_PRODUTO+C0_LOCAL
	
	Do While (clAlias)->(!Eof())
		
		ZC5->(DbGoTo( (clAlias)->RecZC5 ))
		SC5->(DbGoTo( (clAlias)->RecSC5 ))
		
		If !SC6->( DbSeek(xFilial("SC6")+ SC5->C5_NUM ))
			(clAlias)->(DbSkip());Loop
		EndIf
		
		//MaLibDoFat(nRegSC6,nQtdaLib,lCredito,lEstoque,lAvCred,lAvEst,lLibPar,lTrfLocal,aEmpenho,bBlock,aEmpPronto,lTrocaLot,lOkExpedicao,nVlrCred,nQtdalib2)
		Do While SC6->(!Eof()) .And. SC6->(C6_FILIAL+C6_NUM)==xFilial("SC6")+SC5->C5_NUM
			
			lCredito:=.T.
			lEstoque:=.T.
			lAvCred:=lWMPedido
			
			If lWMPedido .And. !Empty(SC6->C6_BLOQUEI)
				SC6->(RecLock("SC6",.F. ))
				SC6->C6_BLOQUEI :=""
				SC6->(MsUnLock())
			EndIf
			
			nQtdReserva:=0
			If SC0->( DbSeek( xFilial("SC0") +SC6->(C6_RESERVA+C6_PRODUTO+C6_LOCAL)   )   )
				nQtdReserva:=SC0->C0_QTDPED
			EndIf
			
			//If nQtdReserva == 0
			//	lEnviaWMS := .F.
			//	Exit
			//EndIf
			
			If nQtdReserva>0
				MaLibDoFat(SC6->(Recno()),nQtdReserva ,,, lAvCred ,.T.,.T.)
			EndIf
			
			SC6->(DbSkip())
		EndDo
		MaLiberOk({ SC5->C5_NUM }, .F.)
		
		If lEnviaWMS .And. !lWMPedido
			U_COM08WMS(SC5->C5_NUM,lWMPedido,lEnviaWMS)
		EndIf
		
		
		(clAlias)->(DbSkip())
		
	EndDo
	
ElseIf  cAcao=="VERIFICA_EXPEDICAO"
	
	cQuery:=" Select ZC5_NUM,ZC5_NUMPV,ZC5.R_E_C_N_O_ RecZC5, SZ1.R_E_C_N_O_ RecSZ1"+CRLF
	cQuery+=" From "+RetSqlName("ZC5")+" ZC5, "+RetSqlName("SZ1")+" SZ1"+CRLF
	cQuery+=" Where ZC5.ZC5_FILIAL='"+xFilial("ZC5")+"'"+CRLF
	cQuery+=" And ZC5.ZC5_NUMPV=SZ1.Z1_PEDIDO "+CRLF
	cQuery+=" And ZC5.ZC5_NOTA=SZ1.Z1_DOC "+CRLF
	cQuery+=" And ZC5.ZC5_SERIE=SZ1.Z1_SERIE"+CRLF
	cQuery+=" And ZC5.ZC5_STATUS='16'"+CRLF
	cQuery+=" And ZC5.ZC5_ESTORN=' '"+CRLF
	cQuery+=" And SZ1.Z1_DTSAIDA<>' '"+CRLF
	cQuery+=" And ZC5.D_E_L_E_T_=' '"+CRLF
	cQuery+=" And SZ1.D_E_L_E_T_=' '"+CRLF
	cQuery+=" Order By ZC5_NUMPV"
	
	DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),clAlias, .F., .F.)
	
	Do While (clAlias)->(!Eof())
		ZC5->(DbGoTo( (clAlias)->RecZC5 ))
		SZ1->(DbGoTo( (clAlias)->RecSZ1 ))
		
		MyMensagem(cAcao+" ZC5_NUMPV="+ZC5->ZC5_NUMPV)
		
		ZC5->(RecLock("ZC5",.F.))
		
		ZC5->ZC5_STATUS	:= '15'
		ZC5->ZC5_ATUALI	:= 'S'
		
		ZC5->(MsUnLock())
		
		U_NcEcom07( ZC5->ZC5_NUMPV )
		U_NCECOM09(ZC5->ZC5_NUM, ZC5->ZC5_NUMPV,"Pedido Expedido com Sucesso","Executado com sucesso",ZC5->ZC5_STATUS,.F.,,,ZC5->ZC5_PVVTEX)
		//Atualiza o status atual do pedido (Pedido expedido Status 15)
		U_NCEC10CI(ZC5->ZC5_NUM, "006")
		
		(clAlias)->(DbSkip())
	EndDo
ElseIf  cAcao=="VERIFICA_RASTREIO"
	
	cQuery:=" Select ZC5_NUM,ZC5_NUMPV,ZC5.R_E_C_N_O_ RecZC5, SZ1.R_E_C_N_O_ RecSZ1"+CRLF
	cQuery+=" From "+RetSqlName("ZC5")+" ZC5, "+RetSqlName("SZ1")+" SZ1"+CRLF
	cQuery+=" Where ZC5.ZC5_FILIAL='"+xFilial("ZC5")+"'"+CRLF
	cQuery+=" And ZC5.ZC5_NUMPV=SZ1.Z1_PEDIDO "+CRLF
	cQuery+=" And ZC5.ZC5_NOTA=SZ1.Z1_DOC "+CRLF
	cQuery+=" And ZC5.ZC5_SERIE=SZ1.Z1_SERIE"+CRLF
	cQuery+=" And ZC5.ZC5_STATUS ='30'"+CRLF
	cQuery+=" And ZC5.ZC5_YMSEXP=' '"+CRLF
	cQuery+=" And ZC5.ZC5_RASTRE<>' '"+CRLF
	cQuery+=" And ZC5.ZC5_ESTORN=' '"+CRLF
	cQuery+=" And SZ1.Z1_FILIAL='"+xFilial("SZ1")+"'"+CRLF
	cQuery+=" And ZC5.ZC5_CODENT Not In "+FormatIn(cTranspo,",")+CRLF
	cQuery+=" And ZC5.D_E_L_E_T_=' '"+CRLF
	cQuery+=" And SZ1.D_E_L_E_T_=' '"+CRLF
	cQuery+=" And ZC5_PLATAF In ('  ','01') "+CRLF
	cQuery+=" Union All " +CRLF
	cQuery+=" Select ZC5_NUM,ZC5_NUMPV,ZC5.R_E_C_N_O_ RecZC5, SZ1.R_E_C_N_O_ RecSZ1 "+CRLF
	cQuery+=" From "+RetSqlName("ZC5")+" ZC5, "+RetSqlName("SZ1")+" SZ1 "+CRLF
	cQuery+=" Where ZC5.ZC5_FILIAL='"+xFilial("ZC5")+"' "+CRLF
	cQuery+=" And ZC5.ZC5_NUMPV=SZ1.Z1_PEDIDO "+CRLF
	cQuery+=" And ZC5.ZC5_NOTA=SZ1.Z1_DOC "+CRLF
	cQuery+=" And ZC5.ZC5_SERIE=SZ1.Z1_SERIE "+CRLF
	cQuery+=" And ZC5.ZC5_STATUS ='15' "+CRLF
	cQuery+=" And ZC5.ZC5_YMSEXP=' ' "+CRLF
	cQuery+=" And ZC5.ZC5_ESTORN=' ' "+CRLF
	cQuery+=" And SZ1.Z1_FILIAL='"+xFilial("SZ1")+"' "+CRLF
	cQuery+=" And SZ1.Z1_DTSAIDA>='20140509' "+CRLF
	cQuery+=" And Trunc(sysdate-to_date(Z1_DTSAIDA,'YYYYMMDD'),0)>1 "+CRLF
	cQuery+=" And ZC5.ZC5_CODENT In "+ FormatIn(cTranspo,",") +CRLF
	cQuery+=" And ZC5.D_E_L_E_T_=' ' "+CRLF
	cQuery+=" And SZ1.D_E_L_E_T_=' ' "+CRLF
	cQuery+=" And ZC5_PLATAF In ('  ','01') "+CRLF
	cQuery+=" Order By ZC5_NUMPV"
	
	DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),clAlias, .F., .F.)
	
	
	Do While (clAlias)->(!Eof())
		
		oobj:=Nil
		
		ZC5->(DbGoTo( (clAlias)->RecZC5 ))
		SZ1->(DbGoTo( (clAlias)->RecSZ1 ))
		
		MyMensagem(cAcao+" ZC5_NUMPV="+ZC5->ZC5_NUMPV)
		
		oobj := NC_WSWSIntegracao():new()
		
		If Empty(SZ1->Z1_DTSAIDA)
			
			ZC5->(RecLock("ZC5",.F.))
			
			ZC5->ZC5_ATUALI:='S'
			ZC5->ZC5_STATUS:="15"
			
			ZC5->(MsUnLock())
			//U_NcEcom07(ZC5->ZC5_NUMPV )
		EndIf
		ZC5->(DbGoTo( (clAlias)->RecZC5 ))
		
		cxml:='<?xml version="1.0" encoding="utf-8" standalone="no" ?><receipt_statusList xmlns="dsReceipt.xsd">'
		cxml+='<receipt_status xmlns="" op="I" order_id="'+alltrim(str(ZC5->ZC5_NUM))+'"'
		cxml+=' passo="30" '
		cxml+=' status_shopper="Pedido Enviado"
		cxml+=' status_adm="Pedido Enviado"'
		
		If AllTrim(ZC5->ZC5_CODENT)=="864"
			cxml+=' rastreamento="&amp;pedido='+AllTrim(Str(Val(ZC5->ZC5_NUMPV)))+'&amp;nfiscal='+AllTrim(Str(Val(ZC5->ZC5_NOTA)))+'"'
		ElseIf AllTrim(ZC5->ZC5_CODENT)== "861"
			cxml+=' rastreamento="'+Alltrim(cUrlTra)+AllTrim(ZC5->ZC5_RASTRE)+'"'
		Else
			cCodRast:=AllTrim(ZC5->ZC5_RASTRE)
			
			If !Empty(cCodRast) .And. Right(cCodRast,2)<>"BR"
				cCodRast+="BR"
			EndIf
			
			If !Empty(cCodRast)
				cUrlAux:=cUrl+cCodRast
				lConecta:=.F.
				For nCont:=1 To 2
					
					Conout("URL"+cUrlAux)
					cHtmlPage := Httpget(cUrlAux)
					
					If !ValType(cHtmlPage)=="C"
						(clAlias)->(DbSkip())
						Loop
					EndIf
					
					If At(cCodRast,cHtmlPage)>0
						lConecta:=.T.
						Exit
					EndIf
					
					cCodRast	:= AllTrim(ZC5->ZC5_RASTRE)
					cUrlAux	:= cUrl+cCodRast
				Next
				
				
			EndIf
			
			If !lConecta
				ZC1->(RecLock("ZC1",.F.))
				
				ZC1->ZC1_REGIST	:=cCodRast
				ZC1->ZC1_OBSRAS	:="Codigo de Rastreio não encontrado no site dos Correios"
				ZC1->ZC1_ERRO	:=.T.
				
				ZC1->(MsUnLock())
				(clAlias)->(DbSkip());Loop
			EndIf
			
			ZC1->(RecLock("ZC1",.F.))
			ZC1->ZC1_REGIST := cCodRast
			ZC1->(MsUnLock())
			
			ZC5->(RecLock("ZC5",.F.))
			ZC5->ZC5_RASTRE := cCodRast
			ZC5->(MsUnLock())
			cxml+=' rastreamento="'+AllTrim(ZC5->ZC5_RASTRE)+'"'
		EndIf
		
		cxml+=' sendMail="1"'
		cxml+=' shipping_method="'+AllTrim(ZC5->ZC5_CODENT)+'"/>'
		cxml+='</receipt_statusList>'
		
		oobj:StatusPedidos(cUser,cPassword,cxml)
		If oobj:lStatusPedidosResult
			ZC5->(RecLock("ZC5",.F.))
			
			ZC5->ZC5_STATUS	:= '30'
			ZC5->ZC5_MSEXP 	:= Dtos(MsDate())
			ZC5->ZC5_YMSEXP := MsDate()
			ZC5->ZC5_ATUALI	:= 'N'
			ZC5->ZC5_CODINT	:= "007"
			
			ZC5->(MsUnLock())
			
			U_NcEcom07(ZC5->ZC5_NUMPV)
			
			U_NCECOM09(ZC5->ZC5_NUM, ZC5->ZC5_NUMPV,"Pedido Enviado com o rastreio "+cxml,"Executado com sucesso",ZC5->ZC5_STATUS,.F.,,,ZC5->ZC5_PVVTEX)
			//Atualiza o status atual do pedido (Pedido enviado com rastreio Status 30)
			//U_NCEC10CI(ZC5->ZC5_NUM, "007",ZC5->ZC5_PVVTEX)
		Endif
		
		(clAlias)->(DbSkip())
	EndDo
	// Adicionado para integrar o status Delivered (40-Entregue)
	
	(clAlias)->(DbCloseArea())
	
	clAlias := GetNextAlias()
	
	BeginSql Alias clAlias
		
		SELECT ZC5.R_E_C_N_O_ RecZC5,
		SZ1.R_E_C_N_O_ RecSZ1
		FROM %Table:ZC5% ZC5
		INNER JOIN %Table:SZ1% SZ1
		ON SZ1.Z1_FILIAL = %xfilial:ZC1%
		AND ZC5.ZC5_NUMPV = SZ1.Z1_PEDIDO
		AND ZC5.ZC5_NOTA = SZ1.Z1_DOC
		AND ZC5.ZC5_SERIE = SZ1.Z1_SERIE
		AND SZ1.%NotDel%
		AND SZ1.Z1_DTENTRE <> ' '
		WHERE ZC5.ZC5_FILIAL = %xfilial:ZC5%
		AND ZC5.ZC5_STATUS = '30'
		AND ZC5.ZC5_YMSEXP <> ' '
		AND ZC5.%NotDel%
		AND ZC5_PLATAF in (' ','01')
		AND ZC5_NUM > 10000
		
	EndSql
	
	While (clAlias)->(!Eof())
		
		ZC5->(DbGoTo((clAlias)->RecZC5))
		SZ1->(DbGoTo((clAlias)->RecSZ1))
		
		If !Empty(ZC5->ZC5_NUMPV)
			MyMensagem("Atualiza entrega NC x Ciashop Pv="+ZC5->ZC5_NUMPV)
			
			cxml := '<?xml version="1.0" encoding="utf-8" standalone="no" ?><receipt_statusList xmlns="dsReceipt.xsd">'
			cxml += '	<receipt_status xmlns="" op="I" order_id="'+AllTrim(Str(ZC5->ZC5_NUM))+'" passo="40"'
			cxml += ' 	status_shopper="Pedido entregue"'
			cxml += ' 	status_adm="Pedido entregue"'
			cxml += ' 	rastreamento=""'
			cxml += ' 	sendMail="1"'
			cxml += ' 	shipping_method="" />'
			cxml += '</receipt_statusList>'
			
			oobj := NC_WSWSIntegracao():new()
			oobj:StatusPedidos(SuperGetMV("EC_NCG0010",,"wsncgames"),SuperGetMV("EC_NCG0011",,"apeei.1453"),cxml)
			
			If oobj:lStatusPedidosResult
				ZC5->(RecLock("ZC5",.F.))
				
				ZC5->ZC5_STATUS := '40'
				ZC5->ZC5_ATUALI := 'N'
				ZC5->ZC5_MSEXP  := Dtos(MsDate())
				ZC5->ZC5_YMSEXP := MsDate()
				
				ZC5->(MsUnlock())
				
				U_NCECOM09(ZC5->ZC5_NUM, ZC5->ZC5_NUMPV,"Pedido Entregue em "+DtoS(SZ1->Z1_DTENTRE),"Executado com sucesso",ZC5->ZC5_STATUS,.F.,,,ZC5->ZC5_PVVTEX)
			Endif
		Endif
		
		(clAlias)->(DbSkip())
		
	EndDo
	
	
ElseIf  cAcao=="VERIFICA_RASTREIO_WM"
	
	cQuery:=" Select ZC5_NUM,ZC5_NUMPV,ZC5.R_E_C_N_O_ RecZC5, SZ1.R_E_C_N_O_ RecSZ1"+CRLF
	cQuery+=" From "+RetSqlName("ZC5")+" ZC5, "+RetSqlName("SZ1")+" SZ1"+CRLF
	cQuery+=" Where ZC5.ZC5_FILIAL='"+xFilial("ZC5")+"'"+CRLF
	cQuery+=" And ZC5.ZC5_NUMPV=SZ1.Z1_PEDIDO "+CRLF
	cQuery+=" And ZC5.ZC5_NOTA=SZ1.Z1_DOC "+CRLF
	cQuery+=" And ZC5.ZC5_SERIE=SZ1.Z1_SERIE"+CRLF
	cQuery+=" And ZC5.ZC5_STATUS ='30'"+CRLF
	cQuery+=" And ZC5.ZC5_YMSEXP=' '"+CRLF
	cQuery+=" And ZC5.ZC5_RASTRE<>' '"+CRLF
	cQuery+=" And ZC5.ZC5_ESTORN=' '"+CRLF
	cQuery+=" And SZ1.Z1_FILIAL='"+xFilial("SZ1")+"'"+CRLF
	cQuery+=" And ZC5.ZC5_CODENT Not In "+FormatIn(cTranspo,",")+CRLF
	cQuery+=" And ZC5.D_E_L_E_T_=' '"+CRLF
	cQuery+=" And SZ1.D_E_L_E_T_=' '"+CRLF
	cQuery+=" And ZC5_PLATAF='WM' "+CRLF
	
	cQuery+=" Union All " +CRLF
	
	cQuery+=" Select ZC5_NUM,ZC5_NUMPV,ZC5.R_E_C_N_O_ RecZC5, SZ1.R_E_C_N_O_ RecSZ1 "+CRLF
	cQuery+=" From "+RetSqlName("ZC5")+" ZC5, "+RetSqlName("SZ1")+" SZ1 "+CRLF
	cQuery+=" Where ZC5.ZC5_FILIAL='"+xFilial("ZC5")+"' "+CRLF
	cQuery+=" And ZC5.ZC5_NUMPV=SZ1.Z1_PEDIDO "+CRLF
	cQuery+=" And ZC5.ZC5_NOTA=SZ1.Z1_DOC "+CRLF
	cQuery+=" And ZC5.ZC5_SERIE=SZ1.Z1_SERIE "+CRLF
	cQuery+=" And ZC5.ZC5_STATUS ='15' "+CRLF
	cQuery+=" And ZC5.ZC5_YMSEXP=' ' "+CRLF
	cQuery+=" And ZC5.ZC5_ESTORN=' ' "+CRLF
	cQuery+=" And SZ1.Z1_FILIAL='"+xFilial("SZ1")+"' "+CRLF
	cQuery+=" And SZ1.Z1_DTSAIDA>='20140509' "+CRLF
	cQuery+=" And Trunc(sysdate-to_date(Z1_DTSAIDA,'YYYYMMDD'),0)>1 "+CRLF
	cQuery+=" And ZC5.ZC5_CODENT In "+ FormatIn(cTranspo,",") +CRLF
	cQuery+=" And ZC5.D_E_L_E_T_=' ' "+CRLF
	cQuery+=" And SZ1.D_E_L_E_T_=' ' "+CRLF
	cQuery+=" And ZC5_PLATAF='WM' "+CRLF
	cQuery+=" Order By ZC5_NUMPV"
	
	DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),clAlias, .F., .F.)
	
	
	Do While (clAlias)->(!Eof())
		
		ZC5->(DbGoTo( (clAlias)->RecZC5 ))
		SZ1->(DbGoTo( (clAlias)->RecSZ1 ))
		
		MyMensagem(cAcao+" ZC5_NUMPV="+ZC5->ZC5_NUMPV)
		
		If Empty(SZ1->Z1_DTSAIDA)
			
			ZC5->(RecLock("ZC5",.F.))
			
			ZC5->ZC5_ATUALI:='S'
			ZC5->ZC5_STATUS:="15"
			
			ZC5->(MsUnLock())
		EndIf
		ZC5->(DbGoTo( (clAlias)->RecZC5 ))
		
		
		If AllTrim(ZC5->ZC5_CODENT)=="864"
			//cxml+=' rastreamento="&amp;pedido='+AllTrim(Str(Val(ZC5->ZC5_NUMPV)))+'&amp;nfiscal='+AllTrim(Str(Val(ZC5->ZC5_NOTA)))+'"'
		ElseIf AllTrim(ZC5->ZC5_CODENT)== "861"
			//cxml+=' rastreamento="'+Alltrim(cUrlTra)+AllTrim(ZC5->ZC5_RASTRE)+'"'
		Else
			cCodRast:=AllTrim(ZC5->ZC5_RASTRE)
			
			If !Empty(cCodRast) .And. Right(cCodRast,2)<>"BR"
				cCodRast+="BR"
			EndIf
			
			If !Empty(cCodRast)
				cUrlAux:=cUrl+cCodRast
				lConecta:=.F.
				For nCont:=1 To 2
					
					Conout("URL"+cUrlAux)
					cHtmlPage := Httpget(cUrlAux)
					
					If !ValType(cHtmlPage)=="C"
						Loop
					EndIf
					
					If At(cCodRast,cHtmlPage)>0
						lConecta:=.T.
						Exit
					EndIf
					
					cCodRast:=AllTrim(ZC5->ZC5_RASTRE)
					cUrlAux:=cUrl+cCodRast
				Next
				
				
			EndIf
			
			If !lConecta
				ZC1->(RecLock("ZC1",.F.))
				ZC1->ZC1_REGIST	:=cCodRast
				ZC1->ZC1_OBSRAS	:="Codigo de Rastreio não encontrado no site dos Correios"
				ZC1->ZC1_ERRO	:=.T.
				ZC1->(MsUnLock())
				(clAlias)->(DbSkip());Loop
			EndIf
			
			ZC1->(RecLock("ZC1",.F.))
			ZC1->ZC1_REGIST:=cCodRast
			ZC1->(MsUnLock())
			
			ZC5->(RecLock("ZC5",.F.))
			ZC5->ZC5_RASTRE:=cCodRast
			ZC5->(MsUnLock())
		EndIf
		
		ZC5->(RecLock("ZC5",.F.))
		
		ZC5->ZC5_STATUS	:= '30'
		ZC5->ZC5_MSEXP 	:= Dtos(MsDate())
		ZC5->ZC5_YMSEXP := MsDate()
		ZC5->ZC5_ATUALI	:= 'S'
		ZC5->ZC5_CODINT	:= "007"
		
		ZC5->(MsUnLock())
		
		U_NcEcom07(ZC5->ZC5_NUMPV)
		U_NCECOM09(ZC5->ZC5_NUM, ZC5->ZC5_NUMPV,"Pedido Enviado com o rastreio ","Executado com sucesso",ZC5->ZC5_STATUS,.F.,,,ZC5->ZC5_PVVTEX)
		
		//Atualiza o status atual do pedido (Pedido enviado com rastreio Status 30)
		//U_NCEC10CI(ZC5->ZC5_NUM, "007",ZC5->ZC5_PVVTEX)
		
		
		(clAlias)->(DbSkip())
	EndDo
	
	
ElseIf cAcao=="VERIFICA_ENTREGA"
	
	
	cQuery:=" Select Distinct ZC5_NUMPV,SC5.R_E_C_N_O_  RecSC5,ZC5.R_E_C_N_O_  RecZC5"+CRLF
	cQuery+=" From "+RetSqlName("ZC5")+" ZC5, "+RetSqlName("SC5")+" SC5,"+RetSqlName("SC6")+" SC6"+CRLF
	cQuery+=" Where ZC5.ZC5_FILIAL='"+xFilial("ZC5")+"'"+CRLF
	cQuery+=" And ZC5.ZC5_STATUS  In "+FormatIn(cLiberPV,",")+CRLF
	cQuery+=" And ZC5.ZC5_NUMPV=SC5.C5_NUM "  +CRLF
	cQuery+=" And ZC5.D_E_L_E_T_=' '"+CRLF
	cQuery+=" And SC5.C5_FILIAL='"+xFilial("SC5")+"'"	+CRLF
	cQuery+=" And SC5.C5_NOTA='  ' " 	+CRLF
	cQuery+=" And SC5.D_E_L_E_T_=' '"+CRLF
	cQuery+=" And ZC5.ZC5_PREVEN <> 'S'"+CRLF
	cQuery+=" And SC6.C6_FILIAL='"+xFilial("SC6")+"'"+CRLF
	cQuery+=" And SC6.D_E_L_E_T_=' '"+CRLF
	cQuery+=" And SC6.C6_NUM=SC5.C5_NUM	"+CRLF
	cQuery+=" And SC6.C6_ENTREG<='"+Dtos(MsDate()+nDias)+"'"+CRLF
	
	
	cQuery+=" And Not Exists 	(Select 'X' From "+RetSqlName("SC9")+" SC9  Where SC9.C9_FILIAL ='"+xFilial("SC9")+"'  And SC9.C9_PEDIDO=SC5.C5_NUM And SC9.D_E_L_E_T_=' '  )"+CRLF
	cQuery+=" And Exists 	(Select 'X' From "+RetSqlName("SC0")+" SC0  Where SC0.C0_FILIAL ='"+xFilial("SC0")+"'  And SC0.C0_NUM=SC5.C5_NUM And SC0.D_E_L_E_T_=' '  )"+CRLF
	
	cQuery+=" Order By ZC5_NUMPV"
	
	DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),clAlias, .F., .F.)
	
	
	Do While (clAlias)->(!Eof())
		SC5->(DbGoTo( (clAlias)->RecSC5 ))
		ZC5->(DbGoTo( (clAlias)->RecZC5 ))
		
		MyMensagem(cAcao+" ZC5_NUMPV="+ZC5->ZC5_NUMPV)
		
		lPvVtex := !empty(ZC5->ZC5_PVVTEX )
		
		//COM08EnvMail( ,cAcao,lPvVtex )   //inativado o envio de email ticket 7023
		
		(clAlias)->(DbSkip())
		
	EndDo
	
ElseIf cAcao=="VERIFICA_ESTORNO"
	
	BeginSql Alias clAlias
		
		SELECT ZC5.R_E_C_N_O_ ZC5REC FROM %table:ZC5% ZC5
		Where ZC5.ZC5_FILIAL = %xfilial:ZC5%
		And ZC5.ZC5_STATUS = '10'
		AND ZC5.ZC5_NUMPV IN(SELECT SUBSTR(CES_NUM_DOCUMENTO,1,6)
		FROM WMS.TB_WMSINTERF_CANC_ENT_SAI
		WHERE CES_COD_CHAVE IN (SELECT SUBSTR(P0A_CHAVE,1,8)
		FROM %table:P0A% P0A
		WHERE P0A.P0A_FILIAL = %xfilial:P0A%
		AND P0A.%NotDel%
		AND P0A.P0A_CHAVE IN (SELECT ZC52.ZC5_FILIAL||ZC52.ZC5_NUMPV
		FROM %table:ZC5% ZC52
		WHERE ZC52.ZC5_FILIAL = %xfilial:ZC5%
		AND ZC52.%NotDel%
		AND ZC52.ZC5_NUMPV <> ' '
		AND ZC52.ZC5_STATUS = '10'		) )
		AND NOT EXISTS ( SELECT 'X' FROM WMS.tb_wmsinterf_doc_saida WHERE DPCS_NUM_DOCUMENTO = CES_NUM_DOCUMENTO ))
		
	EndSql
	
	Do While (clAlias)->(!Eof())
		
		ZC5->(DbGoTo( (clAlias)->ZC5REC) )
		
		ZC5->(RecLock("ZC5",.F.))
		ZC5->ZC5_STATUS := '94'
		ZC5->(MsUnlock())
		
		
		(clAlias)->(DbSkip())
	EndDo
	
EndIf

If Select(clAlias)>0
	(clAlias)->(DbCloseArea())
EndIf

RestArea(aAreaSC9)
RestArea(aAreaAtu)

Return .T.


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCECOM08  ºAutor  ³Microsiga           º Data ³  01/30/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Semaforo(lTipo,nHdl,cArq)
Local lRet		:=	.f.
Local cSemaf	:=	"SEMAFORO\"+cArq+"_.LCK"

If lTipo
	nHdl := MSFCREATE(cSemaf,1 + 16)
	lRet := nHdl > 0
Else
	lRet :=	Fclose(nHdl)
	Ferase(cSemaf)
EndIf

Return(lRet)
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCECOM08  ºAutor  ³Microsiga           º Data ³  01/30/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function COM08EnvMail( aRecZC6,cAcao,lPvVtex )

Local cBody
Local nInd
Local cErro
Local cEmailCc
Local aAnexos:={}
Local cEmailTo
Local cAssunto


If cAcao == "GRAVA_PEDIDO"
	If !lPvVtex
		cBody := U_ECOMHTM1(aRecZC6)
		cEmailTo:=Alltrim(U_MyNewSX6(	"EC_NCG0006","cleverson.silva@acpd.com.br"	   ,"C","E-mail do responsavél do PV Site","","",.F. ))
		cAssunto:="Estoque insuficiente - Pedido de Venda Site:"+AllTrim(Str(ZC5->ZC5_NUM)) +" Pedido de Venda Protheus:"+ZC5->ZC5_NUMPV
	Else
		cBody := U_ECOMHTMF(aRecZC6)
		cEmailTo:=Alltrim(U_MyNewSX6("VT_000008","lfelipe@ncgames.com.br;rciambarella@ncgames.com.br","C","E-mail do responsavél do PV Site B2C","","",.F. ))
		cAssunto:="Operação B2C - Estoque insuficiente - Pedido Site:"+AllTrim(ZC5->ZC5_PVVTEX) +" Pedido Protheus:"+ZC5->ZC5_NUMPV
	EndIf
	
ElseIf cAcao == "AGUARDANDO_WMS"
	
	cBody 	:= U_ECOMHTM2()
	cEmailTo:= Alltrim(U_MyNewSX6(	"EC_NCG0008","cleverson.silva@acpd.com.br"	   ,"C","E-mail do responsavél WMS do PV Site","E-mail do responsavél WMS do PV Site","E-mail do responsavél WMS do PV Site",.F. ))
	cAssunto:= "Solicitação de Estorno WMS - Pedido de Venda Site:"+AllTrim(Str(ZC5->ZC5_NUM)) +" Pedido de Venda Protheus:"+ZC5->ZC5_NUMPV
	
ElseIf cAcao == "VERIFICA_CANCELAMENTO"
	
	cBody 	:= U_ECOMHTM3()
	cEmailTo:= Alltrim(U_MyNewSX6(	"EC_NCG0006","cleverson.silva@acpd.com.br"	   ,"C","E-mail do responsavél do PV Site","E-mail do responsavél do PV Site","E-mail do responsavél do PV Site",.F. ))
	cAssunto:= "Cancelamento - Pedido de Venda Site:"+AllTrim(Str(ZC5->ZC5_NUM)) +" Pedido de Venda Protheus:"+ZC5->ZC5_NUMPV
	
ElseIf cAcao == "VERIFICA_ENTREGA"
	
	If !lPvVtex
		cBody 	:= U_ECOMHTM8()
		cEmailTo:= Alltrim(U_MyNewSX6(	"EC_NCG0006","cleverson.silva@acpd.com.br"	   ,"C","E-mail do responsavél do PV Site","E-mail do responsavél do PV Site","E-mail do responsavél do PV Site",.F. ))
		cAssunto:= "Pedido Ecommerce esta por expirar a data de entrega - Pedido de Venda Site:"+AllTrim(Str(ZC5->ZC5_NUM)) +" Pedido de Venda Protheus:"+ZC5->ZC5_NUMPV
	Else
		cBody 	:= U_ECOMHTM8()
		cEmailTo:= Alltrim(U_MyNewSX6("VT_000008","lfelipe@ncgames.com.br;rciambarella@ncgames.com.br","C","E-mail do responsavél do PV Site B2C","","",.F. ))
		cAssunto:= "Pedido Ecommerce esta por expirar a data de entrega - Pedido de Venda Site:"+AllTrim((ZC5->ZC5_PVVTEX)) +" Pedido de Venda Protheus:"+ZC5->ZC5_NUMPV
	EndIf
	
ElseIf cAcao == "CANCELAMENTO_SITE_FATURADO"
	
	cBody 	:= U_ECOMHTMA()
	cEmailTo:= Alltrim(U_MyNewSX6(	"EC_NCG0006","cleverson.silva@acpd.com.br"	   ,"C","E-mail do responsavél do PV Site","E-mail do responsavél do PV Site","E-mail do responsavél do PV Site",.F. ))
	cAssunto:= "Pedido Ecommerce Cancelado Site e Faturado ERP - Pedido de Venda Site:"+AllTrim(Str(ZC5->ZC5_NUM)) +" Pedido de Venda Protheus:"+ZC5->ZC5_NUMPV
	
ElseIf cAcao == "PEDIDO_CANCELADO_MOIP"
	
	cBody 	:= U_ECOMHTMB(aRecZC6)
	cEmailTo:= Alltrim(U_MyNewSX6(	"EC_NCG0006","cleverson.silva@acpd.com.br"	   ,"C","E-mail do responsavél do PV Site","E-mail do responsavél do PV Site","E-mail do responsavél do PV Site",.F. ))
	cAssunto:= "Pedido Ecommerce Cancelado pelo MOIP - Pedido de Venda Site:"+AllTrim(Str(ZC5->ZC5_NUM))
	
EndIf

If !U_COM08SEND(cAssunto, cBody, aAnexos, cEmailTo, cEmailCc, cErro)
	U_NCECOM09(ZC5->ZC5_NUM, ZC5->ZC5_NUMPV,'Erro ao enviar e-mail para '+cEmailTo,'',ZC5->ZC5_STATUS,.T.,,,ZC5->ZC5_PVVTEX)
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCECOM08  ºAutor  ³Microsiga           º Data ³  01/30/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function COM08SEND(cAssunto, cBody, aAnexos, cEmailTo, cEmailCc, cErro)

Local lRetorno	:= .T.
Local cServer   := GetNewPar("MV_RELSERV","")
Local cAccount	:= GetNewPar("MV_RELACNT","")
Local cPassword	:= GetNewPar("MV_RELAPSW","")
Local lMailAuth	:= GetNewPar("MV_RELAUTH",.F.)

Default aAnexos	:= {}
Default cBody	:= ""
Default cAssunto:= ""
Default cErro	:= ""
Default cEmailCc:=""

If MailSmtpOn( cServer, cAccount, cPassword )
	If lMailAuth
		If ! ( lRetorno := MailAuth(cAccount,cPassword) )
			lRetorno := MailAuth(SubStr(cAccount,1,At("@",cAccount)-1),cPassword)
		EndIf
	Endif
	If lRetorno
		If !MailSend(cAccount,{cEmailTo},{cEmailCc},{},cAssunto,cBody,aAnexos,.F.)
			cErro := "Erro na tentativa de e-mail para " + cEmailTo + ". " + Mailgeterr()
			lRetorno := .F.
		EndIf
	Else
		cErro := "Erro na tentativa de autenticação da conta " + cAccount + ". "
		lRetorno := .F.
	EndIf
	MailSmtpOff()
Else
	cErro := "Erro na tentativa de conexão com o servidor SMTP: " + cServer + " com a conta " + cAccount + ". "
	lRetorno := .F.
EndIf


Return lRetorno

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCECOM08  ºAutor  ³Microsiga           º Data ³  02/06/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function COM08Estorna(cPVPgto,cNumPV)

Local cFormaPgto:=Alltrim(U_MyNewSX6("EC_NCG0001","BOL"	,"C","Forma de Pagamento que não aceita pedido parcial","","",.F. ))
Local lRetorno:=.F.

If !cPVPgto$cFormaPgto
	Return lRetorno
EndIf

Return U_C08CANCPV(cNumPV)
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCECOM08  ºAutor  ³Microsiga           º Data ³  02/07/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function C08CANCPV(cNumPV)

Local aAreaAtu 		:= GetArea()
Local aAreaSC9 		:= SC9->(GetArea())
Local aAreaSC6 		:= SC9->(GetArea())
Local aAreaSC5		:= SC5->(GetArea())
Local cFormaPgto 	:= Alltrim(U_MyNewSX6(	"EC_NCG0001","BOL"	,"C","Forma de Pagamento que não aceita pedido parcial","","",.F. ))
Local lRetorno 		:= .T.

SC6->(DbSetOrder(1))//C6_FILIAL+C6_NUM+C6_ITEM+C6_PRODUTO
SC9->(DbSetOrder(1))//C9_FILIAL+C9_PEDIDO+C9_ITEM+C9_SEQUEN+C9_PRODUTO
SC5->(DbSetOrder(1))//C5_FILIAL+C5_NUM
SC9->(DbSeek(xFilial("SC9")+cNumPV ))
SC5->(MsSeek(xFilial("SC5")+cNumPV ))

Do While SC9->(!Eof()) .And. SC9->(C9_FILIAL+C9_PEDIDO)==xFilial("SC9")+cNumPV
	SC9->(a460Estorna(.T.))
	lRetorno := .T.
	SC9->(DbSkip())
EndDo

If lRetorno
	If SC6->( DbSeek(xFilial("SC6")+cNumPV  ))
		U_NC110Del(cNumPV)
		nVlrDep := 0
		Do While SC6->(!Eof() ) .And. SC6->( C6_FILIAL+C6_NUM==xFilial("SC6")+ cNumPV )
			MaResDoFat(nil, .T., .F., @nVlrDep)
			SC6->(DbSkip())
		EndDo
		MaLiberOk({ cNumPV }, .T.)
		SC5->(RecLock("SC5",.F.))
		SC5->C5_NOTA := "XXXXXXXXX"
		SC5->(MsUnlock())
	Else
		lRetorno := .F.
	EndIf
EndIf

RestArea(aAreaSC5)
RestArea(aAreaSC6)
RestArea(aAreaSC9)
RestArea(aAreaAtu)

Return lRetorno

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCECOM08  ºAutor  ³Microsiga           º Data ³  02/07/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function COM08AjustPV(nDiff,aHeadC6,aColsC6)

Local aAreaAtu:=GetArea()
Local aLinha
Local nTotSC6:=0
Local nFator :=0
Local nPreco :=0
Local nLinhas:=Len(aColsC6)

For nInd:=1 To Len(aColsC6)
	nTotSC6+=GdFieldGet( "C6_PRCVEN", nInd,,aHeadC6,aColsC6)
Next

For nInd:=1 To nLinhas
	nPreco:=GdFieldGet( "C6_PRCVEN", nInd,,aHeadC6,aColsC6)
	nFator:=(nPreco/nTotSC6	*nDiff)/GdFieldGet( "C6_QTDVEN", nInd,,aHeadC6,aColsC6)
	nPreco:=A410Arred((nPreco-nFator),'C6_VALOR')
	
	GdFieldPut('C6_PRCVEN', nPreco ,nInd,aHeadC6,aColsC6)
	GdFieldPut("C6_PRUNIT", nPreco ,nInd,aHeadC6,aColsC6)
	//GdFieldPut("C6_PRCTAB", nPreco ,nInd,aHeadC6,aColsC6)
Next


RestArea(aAreaAtu)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCECOM08  ºAutor  ³Microsiga           º Data ³  02/13/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CM08Parcelas(nParcelas)

Local aRetorno	:= {}
Local cParcela	:= "0"
Local nDiff		:= 100
Local nPercent
Local dDatAux	:= dDataBase+2

Default nParcelas := 1

nPercent := Round(100/nParcelas,2)

For nInd:=1 To nParcelas
	cParcela := Soma1(cParcela)
	dDatAux := DataValida(dDatAux+30)
	AADD(aRetorno,{"C5_PARC"+cParcela,Iif(nInd==nParcelas,nDiff,nPercent),"C5_DATA"+cParcela,dDatAux }  )
	nDiff -= nPercent
Next

Return aRetorno
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCECOM08  ºAutor  ³Microsiga           º Data ³  02/13/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function xCOM08()
Local aCpoADD:={}
Local nCont:=0
Local cMensagem:=""

RpcSetEnv("01","03")

aadd(aCpoADD,'B5_YPREVEN')

RpcSetEnv("01","03")

aStructAtu:=SB5->(DbStruct())
aStructNew:=aClone(aStructAtu)

SX3->(DbSetOrder(2))
For nInd:=1 To Len(aCpoADD)
	If (nAscan:=Ascan(aStructNew,{|a| AllTrim(a[1])==aCpoADD[nInd]  }))==0 .And. SX3->(DbSeek(aCpoADD[nInd]))
		SX3->( AADD(aStructNew,{X3_CAMPO,X3_TIPO,X3_TAMANHO,X3_DECIMAL}) )
	EndIf
Next


nTopErr:=Nil
SB5->(DbCloseArea())
cTabela:="SB5010"
If Len(aStructAtu)<>Len(aStructNew)
	If TcAlter( cTabela , aStructAtu, aStructNew, @nTopErr )
		cMensagem+="Tabela "+cTabela+" Alterada"
	Else
		cMensagem+="Erro "+AllTrim(Str(nTopErr))+" ao alterar a tabela "+cTabela
		
	EndIf
EndIf
MsgInfo(cMensagem)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCECOM08  ºAutor  ³Microsiga           º Data ³  02/14/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function NCGTOTPV(cNumeroPV,aHeadC6,aColsC6)   //cNumeroPV :=Numero do Pedido de Venda  laHeadaCols =Se retorna o aCols / aHeader do SC6

Local aAreaAtu	:= GetArea()
Local aAreaSC5	:= SC5->(GetArea())
Local aAreaSC6	:= SC6->(GetArea())
Local aColsAux
Local aHeadAux
Local nTotal	:= 0

Default cNumeroPV := SC5->C5_NUM
Default aHeadC6	:= {}
Default aColsC6 := {}


If Type("aCols")=="A"
	aColsAux:=aClone(aCols)
EndIf

If Type("aHeader")=="A"
	aHeadAux:=aClone(aHeader)
EndIf

SC5->(DbSetOrder(1))
If SC5->(DbSeek(xFilial("SC5")+cNumeroPV  ))
	RegToMemory("SC5",.F.,.F.)
	
	aCols	:= {}
	aHeader	:= {}
	
	SC6->(FillGetDados ( 2, "SC6",1, xFilial("SC6")+SC5->C5_NUM, {|| C6_FILIAL+C6_NUM }, /*bSeekFor*/ , /*aNoFields*/, /*[ aYesFields]*/, /*[ lOnlyYes]*/, /*[ cQuery]*/, /*[bMontCols]*/, .F., /*[ aHeaderAux]*/, /*[ aColsAux]*/, /*[ bAfterCols]*/, /*[ bBeforeCols]*/, /*[ bAfterHeader]*/, /*[ cAliasQry]*/, /*[ bCriaVar]*/, /*[ lUserFields]*/, /*[ aYesUsado]*/ ))
	
	nTotal	:= U_VERDSCMD(.F.)
	
EndIf

aHeadC6	:= aClone(aHeader)
aColsC6	:= aClone(aCols)

If Type("aColsAux")=="A"
	aCols:=aClone(aColsAux)
EndIf

If Type("aHeadAux")=="A"
	aHeader:=aClone(aHeadAux)
EndIf


RestArea(aAreaSC6)
RestArea(aAreaSC5)
RestArea(aAreaAtu)

Return nTotal


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCECOM08  ºAutor  ³Microsiga           º Data ³  02/18/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function COM08SIMUL(aCabec,aItens,lWMPedido)

Local nTotal
Local nPosaItem
Local aLinha
Local nPreco
Local nPosDesp := Ascan(aCabec,{|a| a[1]=="C5_DESPESA" }  )
Local nPosDesc := Ascan(aCabec,{|a| a[1]=="C5_DESC3" }  )
Local aDespesa := {}
Local nPosPrec
Local nPosPrUn
Local nPosPrTb
Local nDespesa
Local lPvVtex := ZC5->ZC5_PLATAF $ '00*03'
Local nInd
Local nPrecoOrg
Local nPDescont
Local nPValDesc
Local _nPosVlrUni
Local _nPosPrUnit


Default lWMPedido:=.F.

RegToMemory( "SC5", .T., .F. )
ECOM08Ini(aCabec,aItens)

INCLUI:=.T.

If Len(aCols)>0
	If lWMPedido
		
		nPrecoOrg := aScan(aHeader,{|x| AllTrim(x[2])=="C6_YPRCORI"})
		nPDescont  	:= aScan(aHeader,{|x| AllTrim(x[2])=="C6_DESCONT"})
		nPValDesc 	:= aScan(aHeader,{|x| AllTrim(x[2])=="C6_VALDESC"})
		_nPosVlrUni  	:= aScan(aHeader,{|x| AllTrim(x[2])=="C6_PRCVEN"})
		_nPosPrUnit	:= aScan(aHeader,{|x| AllTrim(x[2])=="C6_PRUNIT"})
		
		For nInd:=1 TO LEN(ACOLS)
			If	(aCols[nInd,_nPosPrUnit]	> aCols[nInd,_nPosVlrUni]) .or. aCols[nInd,nPValDesc] > 0 .or. aCols[nInd,nPDescont] > 0 // se o preço unitário for menor que o preço lista, haverá destaque do desconto na NF
				aCols[nInd,nPrecoOrg]	:=aCols[nInd,_nPosPrUnit]
				aCols[nInd,_nPosPrUnit]	:= aCols[nInd,_nPosVlrUni] // preco sem ipi
				aCols[nInd,nPValDesc]:= 0
				aCols[nInd,nPDescont]:= 0
			EndIf
		Next nInd
		
	Else
		
		nPosPrec:=Ascan( aItens[1],{ |a|a[1]=="C6_PRCVEN" }  )
		nPosPrUn:=Ascan( aItens[1],{ |a|a[1]=="C6_PRUNIT" }  )
		
		nTotal:=Ma410Impos(3)
		
		If Abs( nDiff:=(nTotal-ZC5->ZC5_TOTAL) )>0
			
			COM08AjustPV(nDiff,aHeader,aCols)
			
			ECOM08Ini(aCabec,aItens)
			
			MyMensagem( ProcName(0)+"-"+ Iif(lPvVtex,"PVVTEX="+ZC5->ZC5_PVVTEX,"PV="+AllTrim(Str(ZC5->ZC5_NUM)) ) )
			
			nTotal			:= Ma410Impos(3)
			M->C5_DESPESA	:= 0
			M->C5_DESC3		:= 0
			
			Do While .T. .And. !(nTotal-ZC5->ZC5_TOTAL==0)
				
				If (nTotal-ZC5->ZC5_TOTAL) <0
					nDespesa := 1
					Do While nDespesa>0.01 .And. !(nTotal-ZC5->ZC5_TOTAL==0)
						Do While (nTotal-ZC5->ZC5_TOTAL)<0
							M->C5_DESPESA += nDespesa
							nTotal := Ma410Impos(3)
						EndDo
						M->C5_DESPESA -= nDespesa
						nTotal 		:= Ma410Impos(3)
						nDespesa 	:= Round(nDespesa/2,2)
					EndDo
					
					Do While (nTotal-ZC5->ZC5_TOTAL)<0
						M->C5_DESPESA += 0.01
						nTotal := Ma410Impos(3)
					EndDo
					
				Else
					Do While (nTotal-ZC5->ZC5_TOTAL)>0
						
						M->C5_DESC3 += 0.10
						a410Recalc(.T.)
						nTotal := Ma410Impos(3)
					EndDo
					
					
					For nInd:=1 To Len(aCols)
						
						nPreco:=GdFieldGet( "C6_PRCVEN", nInd)
						
						If nPosPrec>0
							aItens[nInd,nPosPrec,2] :=nPreco
						EndIf
						
						If nPosPrUn>0
							aItens[nInd,nPosPrUn,2] :=nPreco
						Endif
						
					Next
					ECOM08Ini(aCabec,aItens)
					nTotal := Ma410Impos(3)//A410Arred( U_VERDSCMD(.F.),'C6_VALOR')
					Loop
				EndIf
				
				
				Exit
				
			EndDo
			
			
		EndIf
		aCabec[nPosDesp,2]:=M->C5_DESPESA
	EndIf
EndIf
U_GetaColsaHeader(aCols,aHeader,.T.)
RollBAckSx8()

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCECOM08  ºAutor  ³Microsiga           º Data ³  02/18/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ECOM08Ini(aCabec,aItens)
aCols	:={}
aHeader	:={}

MATA410(aCabec,aItens,3)
U_GetaColsaHeader(aCols,aHeader)

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCECOM08  ºAutor  ³Microsiga           º Data ³  02/18/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Ma410Impos( nOpc, lRetTotal, aRefRentab)
Local aArea			:= GetArea()
Local aAreaSA1		:= SA1->(GetArea())
Local aFisGet		:= {}
Local aFisGetSC5	:= {}

Local aDupl     	:= {}
Local aVencto   	:= {}
Local aEntr     	:= {}
Local aDuplTmp  	:= {}
Local aNfOri    	:= {}
Local aRentab   	:= {}

Local nPLocal   	:= aScan(aHeader,{|x| AllTrim(x[2])=="C6_LOCAL"})
Local nPTotal   	:= aScan(aHeader,{|x| AllTrim(x[2])=="C6_VALOR"})
Local nPValDesc 	:= aScan(aHeader,{|x| AllTrim(x[2])=="C6_VALDESC"})
Local nPPrUnit  	:= aScan(aHeader,{|x| AllTrim(x[2])=="C6_PRUNIT"})
Local nPPrcVen  	:= aScan(aHeader,{|x| AllTrim(x[2])=="C6_PRCVEN"})
Local nPQtdVen  	:= aScan(aHeader,{|x| AllTrim(x[2])=="C6_QTDVEN"})
Local nPDtEntr  	:= aScan(aHeader,{|x| AllTrim(x[2])=="C6_ENTREG"})
Local nPProduto 	:= aScan(aHeader,{|x| AllTrim(x[2])=="C6_PRODUTO"})
Local nPTES     	:= aScan(aHeader,{|x| AllTrim(x[2])=="C6_TES"})
Local nPCodRet  	:= Iif(cPaisLoc=="EQU",aScan(aHeader,{|x| AllTrim(x[2])=="C6_CONCEPT"}),"")
Local nPNfOri   	:= aScan(aHeader,{|x| AllTrim(x[2])=="C6_NFORI"})
Local nPSerOri  	:= aScan(aHeader,{|x| AllTrim(x[2])=="C6_SERIORI"})
Local nPItemOri 	:= aScan(aHeader,{|x| AllTrim(x[2])=="C6_ITEMORI"})
Local nPIdentB6 	:= aScan(aHeader,{|x| AllTrim(x[2])=="C6_IDENTB6"})
Local nPItem    	:= aScan(aHeader,{|x| AllTrim(x[2])=="C6_ITEM"})
Local nPProvEnt 	:= aScan(aHeader,{|x| AllTrim(x[2])=="C6_PROVENT"})
Local nPosCfo		:= aScan(aHeader,{|x| AllTrim(x[2])=="C6_CF"})
Local nPAbatISS 	:= aScan(aHeader,{|x| AllTrim(x[2])=="C6_ABATISS"})
Local nPLote    	:= aScan(aHeader,{|x| AllTrim(x[2])=="C6_LOTECTL"})
Local nPSubLot		:= aScan(aHeader,{|x| AllTrim(x[2])=="C6_NUMLOTE"})
Local nPClasFis 	:= aScan(aHeader,{|x| AllTrim(x[2])=="C6_CLASFIS"})
Local nPSuframa 	:= 0
Local nUsado    	:= Len(aHeader)
Local nX        	:= 0
Local nX1       	:= 0
Local nAcerto   	:= 0
Local nPrcLista 	:= 0
Local nValMerc  	:= 0
Local nDesconto 	:= 0
Local nAcresFin 	:= 0	// Valor do acrescimo financeiro do total do item
Local nQtdPeso  	:= 0
Local nRecOri   	:= 0
Local nPosEntr  	:= 0
Local nItem     	:= 0
Local nY        	:= 0
Local nPosCpo   	:= 0
Local nPropLot  	:= 0

Local lDtEmi    	:= SuperGetMv("MV_DPDTEMI",.F.,.T.)
Local dDataCnd  	:= M->C5_EMISSAO
Local oDlg
Local oDupl
Local oFolder
Local oRentab
Local lCondVenda	:= .F. // Template GEM
Local aRentabil 	:= {}
Local cProduto  	:= ""
Local nTotDesc  	:= 0
Local lSaldo    	:= MV_PAR04 == 1 .And. !INCLUI
Local nQtdEnt   	:= 0
Local lM410Ipi		:= ExistBlock("M410IPI")
Local lM410Icm		:= ExistBlock("M410ICM")
Local lM410Soli		:= ExistBlock("M410SOLI")
Local lUsaVenc  	:= .F.
Local lIVAAju   	:= .F.
Local lRastro	 	:= ExistBlock("MAFISRASTRO")
Local lRastroLot 	:= .F.
Local lPParc		:= .F.
Local aSolid		:= {}
Local nLancAp		:= 0
Local aHeadCDA		:= {}
Local aColsCDA		:= {}
Local aTransp		:= {"",""}
Local aSaldos		:= {}
Local aInfLote		:= {}
Local a410Preco 	:= {}  // Retorno da Project Function P_410PRECO com os novos valores das variaveis {nValMerc,nPrcLista}
Local nAcresUnit	:= 0	// Valor do acrescimo financeiro do valor unitario
Local nAcresTot 	:= 0	// Somatoria dos Valores dos acrescimos financeiros dos itens
Local dIni			:= Ctod("//")
Local cEstado		:= SuperGetMv("MV_ESTADO")
Local cTesVend  	:= SuperGetMv("MV_TESVEND",,"")
Local cCliPed   	:= ""
Local lCfo      	:= .F.
Local nlValor		:= 0
Local nValRetImp	:= 0
Local cImpRet 		:= ""
Local cNatureza 	:= ""
Local lM410FldR 	:= .T.
Local aTotSolid 	:= {}
Local nValTotal 	:= 0 //Valor total utilizado no retorno quando lRetTotal for .T.
Local INCLUI		:= .T.
Local ALTERA		:= .F.

Default lRetTotal 	:= .F.
Default aRefRentab 	:= {}

PRIVATE oLancApICMS
PRIVATE _nTotOper_ 	:= 0		//total de operacoes (vendas) realizadas com um cliente - calculo de IB - Argentina
Private _aValItem_ 	:= {}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Busca referencias no SC6                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aFisGet	:= {}
dbSelectArea("SX3")
dbSetOrder(1)
MsSeek("SC6")
While !Eof().And.X3_ARQUIVO=="SC6"
	cValid := UPPER(X3_VALID+X3_VLDUSER)
	If 'MAFISGET("'$cValid
		nPosIni 	:= AT('MAFISGET("',cValid)+10
		nLen		:= AT('")',Substr(cValid,nPosIni,Len(cValid)-nPosIni))-1
		cReferencia := Substr(cValid,nPosIni,nLen)
		aAdd(aFisGet,{cReferencia,X3_CAMPO,MaFisOrdem(cReferencia)})
	EndIf
	If 'MAFISREF("'$cValid
		nPosIni		:= AT('MAFISREF("',cValid) + 10
		cReferencia	:=Substr(cValid,nPosIni,AT('","MT410",',cValid)-nPosIni)
		aAdd(aFisGet,{cReferencia,X3_CAMPO,MaFisOrdem(cReferencia)})
	EndIf
	dbSkip()
EndDo
aSort(aFisGet,,,{|x,y| x[3]<y[3]})

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Busca referencias no SC5                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aFisGetSC5	:= {}
dbSelectArea("SX3")
dbSetOrder(1)
MsSeek("SC5")
While !Eof().And.X3_ARQUIVO=="SC5"
	cValid := UPPER(X3_VALID+X3_VLDUSER)
	If 'MAFISGET("'$cValid
		nPosIni 	:= AT('MAFISGET("',cValid)+10
		nLen		:= AT('")',Substr(cValid,nPosIni,Len(cValid)-nPosIni))-1
		cReferencia := Substr(cValid,nPosIni,nLen)
		aAdd(aFisGetSC5,{cReferencia,X3_CAMPO,MaFisOrdem(cReferencia)})
	EndIf
	If 'MAFISREF("'$cValid
		nPosIni		:= AT('MAFISREF("',cValid) + 10
		cReferencia	:=Substr(cValid,nPosIni,AT('","MT410",',cValid)-nPosIni)
		aAdd(aFisGetSC5,{cReferencia,X3_CAMPO,MaFisOrdem(cReferencia)})
	EndIf
	dbSkip()
EndDo
aSort(aFisGetSC5,,,{|x,y| x[3]<y[3]})

SA4->(dbSetOrder(1))
If SA4->(dbSeek(xFilial("SA4")+M->C5_TRANSP))
	aTransp[01] := SA4->A4_EST
	aTransp[02] := Iif(SA4->(FieldPos("A4_TPTRANS")) > 0,SA4->A4_TPTRANS,"")
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Inicializa a funcao fiscal                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³A Consultoria Tributária, por meio da Resposta à Consulta nº 268/2004, determinou a aplicação das seguintes alíquotas nas Notas Fiscais de venda emitidas pelo vendedor remetente:                                                                         ³
//³1) no caso previsto na letra "a" (venda para SP e entrega no PR) - aplicação da alíquota interna do Estado de São Paulo, visto que a operação entre o vendedor remetente e o adquirente originário é interna;                                              ³
//³2) no caso previsto na letra "b" (venda para o DF e entrega no PR) - aplicação da alíquota interestadual prevista para as operações com o Paraná, ou seja, 12%, visto que a circulação da mercadoria se dá entre os Estado de São Paulo e do Paraná.       ³
//³3) no caso previsto na letra "c" (venda para o RS e entrega no SP) - aplicação da alíquota interna do Estado de São Paulo, uma vez que se considera interna a operação, quando não se comprovar a saída da mercadoria do território do Estado de São Paulo,³
//³ conforme previsto no art. 36, § 4º do RICMS/SP                                                                                                                                                                                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If len(aCols) > 0
	If cEstado == 'SP'
		If !Empty(M->C5_CLIENT) .And. M->C5_CLIENT <> M->C5_CLIENTE
			For nX := 1 To Len(aCols)
				If Alltrim(aCols[nX][nPTES])$ Alltrim(cTesVend)
					lCfo:= .T.
				EndIf
			Next
			If lCfo
				dbSelectArea(IIF(M->C5_TIPO$"DB","SA2","SA1"))
				dbSetOrder(1)
				MsSeek(xFilial()+M->C5_CLIENTE+M->C5_LOJAENT)
				If Iif(M->C5_TIPO$"DB", SA2->A2_EST,SA1->A1_EST) == 'SP'
					cCliPed := M->C5_CLIENTE
				Else
					cCliPed := M->C5_CLIENT
				EndIf
			EndIf
		EndIf
	EndIf
EndIf

MaFisSave()
MaFisEnd()
MaFisIni(IIf(!Empty(cCliPed),cCliPed,Iif(Empty(M->C5_CLIENT),M->C5_CLIENTE,M->C5_CLIENT)),;// 1-Codigo Cliente/Fornecedor
M->C5_LOJAENT,;		// 2-Loja do Cliente/Fornecedor
IIf(M->C5_TIPO$'DB',"F","C"),;				// 3-C:Cliente , F:Fornecedor
M->C5_TIPO,;				// 4-Tipo da NF
M->C5_TIPOCLI,;		// 5-Tipo do Cliente/Fornecedor
Nil,;
Nil,;
Nil,;
Nil,;
"MATA461",;
Nil,;
Nil,;
Nil,;
Nil,;
Nil,;
Nil,;
Nil,;
aTransp)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Realiza alteracoes de referencias do SC5         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Len(aFisGetSC5) > 0
	dbSelectArea("SC5")
	For nY := 1 to Len(aFisGetSC5)
		If !Empty(&("M->"+Alltrim(aFisGetSC5[ny][2])))
			MaFisAlt(aFisGetSC5[ny][1],&("M->"+Alltrim(aFisGetSC5[ny][2])),,.F.)
		EndIf
	Next nY
Endif

//Na argentina o calculo de impostos depende da serie.
If cPaisLoc == 'ARG'
	SA1->(DbSetOrder(1))
	SA1->(MsSeek(xFilial()+IIf(!Empty(M->C5_CLIENT),M->C5_CLIENT,M->C5_CLIENTE)+M->C5_LOJAENT))
	MaFisAlt('NF_SERIENF',LocXTipSer('SA1',MVNOTAFIS))
	/*
	ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	³ Tratamento de IB para monotributistas - Argentina           ³
	³ AGIP 177/2009                                               ³
	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
	If SA1->A1_TIPO == "M"
		dIni := (dDatabase + 1) - 365
		_nTotOper_ := RetTotOper(SA1->A1_COD,SA1->A1_LOJA,"C",dIni,dDatabase,1)
	Endif
ElseIf cPaisLoc=="EQU"
	SA1->(DbSetOrder(1))
	SA1->(MsSeek(xFilial()+IIf(!Empty(M->C5_CLIENT),M->C5_CLIENT,M->C5_CLIENTE)+M->C5_LOJAENT))
	cNatureza:=SA1->A1_NATUREZ
	
	lPParc:=Posicione("SED",1,xFilial("SED")+cNatureza,"ED_RATRET")=="1"
Endif

If cPaisLoc<>"BRA"
	MaFisAlt('NF_MOEDA',M->C5_MOEDA)
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Agrega os itens para a funcao fiscal         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nPTotal > 0 .And. nPValDesc > 0 .And. nPPrUnit > 0 .And. nPProduto > 0 .And. nPQtdVen > 0 .And. nPTes > 0
	For nX := 1 To Len(aCols)
		nQtdPeso := 0
		
		nItem++
		/*
		ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		³ Tratamento de IB para monotributistas - Argentina           ³
		³ AGIP 177/2009                                               ³
		ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
		If cPaisLoc == "ARG"
			If SA1->A1_TIPO == "M"
				Aadd(_aValItem_,{nItem,.F.,xmoeda(aCols[nX][nPPrcVen],SC5->C5_MOEDA ,1,)})
			Endif
		Endif
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Posiciona Registros                          ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If lSaldo .And. nPItem > 0
			dbSelectArea("SC6")
			dbSetOrder(1)
			MsSeek(xFilial("SC6")+M->C5_NUM+aCols[nX][nPItem]+aCols[nX][nPProduto])
			nQtdEnt := IIf(!SubStr(SC6->C6_BLQ,1,1)$"RS" .And. Empty(SC6->C6_BLOQUEI),SC6->C6_QTDENT,SC6->C6_QTDVEN)
		Else
			lSaldo := .F.
		EndIf
		
		cProduto := aCols[nX][nPProduto]
		MatGrdPrRf(@cProduto)
		SB1->(dbSetOrder(1))
		If SB1->(MsSeek(xFilial("SB1")+cProduto))
			nQtdPeso := If(lSaldo,aCols[nX][nPQtdVen]-nQtdEnt,aCols[nX][nPQtdVen])*SB1->B1_PESO
		EndIf
		If nPIdentB6 <> 0 .And. !Empty(aCols[nX][nPIdentB6])
			SD1->(dbSetOrder(4))
			If SD1->(MSSeek(xFilial("SD1")+aCols[nX][nPIdentB6]))
				nRecOri := SD1->(Recno())
			EndIf
		ElseIf nPNfOri > 0 .And. nPSerOri > 0 .And. nPItemOri > 0
			If !Empty(aCols[nX][nPNfOri]) .And. !Empty(aCols[nX][nPItemOri])
				SD1->(dbSetOrder(1))
				If SD1->(MSSeek(xFilial("SD1")+aCols[nX][nPNfOri]+aCols[nX][nPSerOri]+M->C5_CLIENTE+M->C5_LOJACLI+aCols[nX][nPProduto]+aCols[nX][nPItemOri]))
					nRecOri := SD1->(Recno())
				EndIf
			EndIf
		EndIf
		SB2->(dbSetOrder(1))
		SB2->(MsSeek(xFilial("SB2")+SB1->B1_COD+aCols[nX][nPLocal]))
		SF4->(dbSetOrder(1))
		SF4->(MsSeek(xFilial("SF4")+aCols[nX][nPTES]))
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Calcula o preco de lista                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nValMerc  := If(aCols[nX][nPQtdVen]==0,aCols[nX][nPTotal],If(lSaldo,(aCols[nX][nPQtdVen]-nQtdEnt)*aCols[nX][nPPrcVen],aCols[nX][nPTotal]))
		nPrcLista := aCols[nX][nPPrUnit]
		If ( nPrcLista == 0 )
			nValMerc  := If(aCols[nX][nPQtdVen]==0,aCols[nX][nPTotal],If(lSaldo,(aCols[nX][nPQtdVen]-nQtdEnt)*aCols[nX][nPPrcVen],aCols[nX][nPTotal]))
		EndIf
		nAcresUnit:= A410Arred(aCols[nX][nPPrcVen]*M->C5_ACRSFIN/100,"D2_PRCVEN")
		nAcresFin := A410Arred(If(lSaldo,aCols[nX][nPQtdVen]-nQtdEnt,aCols[nX][nPQtdVen])*nAcresUnit,"D2_TOTAL")
		nAcresTot += nAcresFin
		nValMerc  += nAcresFin
		nDesconto := a410Arred(nPrcLista*If(lSaldo,aCols[nX][nPQtdVen]-nQtdEnt,aCols[nX][nPQtdVen]),"D2_DESCON")-nValMerc
		nDesconto := IIf(nDesconto<=0,aCols[nX][nPValDesc],nDesconto)
		nDesconto := Max(0,nDesconto)
		nPrcLista += nAcresUnit
		//Para os outros paises, este tratamento e feito no programas que calculam os impostos.
		If cPaisLoc=="BRA" .or. GetNewPar('MV_DESCSAI','1') == "2"
			nValMerc  += nDesconto
		Endif
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Verifica a data de entrega para as duplicatas³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If ( nPDtEntr > 0 )
			If ( dDataCnd > aCols[nX][nPDtEntr] .And. !Empty(aCols[nX][nPDtEntr]) )
				dDataCnd := aCols[nX][nPDtEntr]
			EndIf
		Else
			dDataCnd  := M->C5_EMISSAO
		EndIf
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Tratamento do IVA Ajustado                   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		SB1->(dbSetOrder(1))
		If SB1->(MsSeek(xFilial("SB1")+cProduto))
			lIVAAju := IIF(SB1->(FieldPos("B1_IVAAJU")) > 0 .And. SB1->B1_IVAAJU == '1' .And. (IIF(lRastro,lRastroLot := ExecBlock("MAFISRASTRO",.F.,.F.),Rastro(cProduto,"S"))),.T.,.F.)
		EndIf
		dbSelectArea("SC6")
		dbSetOrder(1)
		MsSeek(xFilial("SC6")+M->C5_NUM)
		If lIVAAju
			dbSelectArea("SC9")
			dbSetOrder(1)
			If MsSeek(xFilial("SC9")+SC6->C6_NUM+SC6->C6_ITEM)
				If ( SC9->C9_BLCRED $ "  10"  .And. SC9->C9_BLEST $ "  10")
					While ( !Eof() .And. SC9->C9_FILIAL == xFilial("SC9") .And.;
						SC9->C9_PEDIDO == SC6->C6_NUM .And.;
						SC9->C9_ITEM   == SC6->C6_ITEM )
						
						aadd(aSaldos,{SC9->C9_LOTECTL,SC9->C9_NUMLOTE,,,SC9->C9_QTDLIB})
						
						dbSelectArea("SC9")
						dbSkip()
					EndDo
				Else
					dbSelectArea("SC6")
					dbSetOrder(1)
					MsSeek(xFilial("SC6")+M->C5_NUM)
					lUsaVenc:= If(!Empty(SC6->C6_LOTECTL+SC6->C6_NUMLOTE),.T.,(SuperGetMv('MV_LOTVENC')=='S'))
					aSaldos := SldPorLote(aCols[nX][nPProduto],aCols[nX][nPLocal],aCols[nX][nPQtdVen]/* nQtdLib*/,0/*nQtdLib2*/,SC6->C6_LOTECTL,SC6->C6_NUMLOTE,SC6->C6_LOCALIZ,SC6->C6_NUMSERI,NIL,NIL,NIL,lUsaVenc,nil,nil,dDataBase)
				EndIf
			Else
				dbSelectArea("SC6")
				dbSetOrder(1)
				MsSeek(xFilial("SC6")+M->C5_NUM)
				lUsaVenc:= If(!Empty(SC6->C6_LOTECTL+SC6->C6_NUMLOTE),.T.,(SuperGetMv('MV_LOTVENC')=='S'))
				aSaldos := SldPorLote(aCols[nX][nPProduto],aCols[nX][nPLocal],aCols[nX][nPQtdVen]/* nQtdLib*/,0/*nQtdLib2*/,SC6->C6_LOTECTL,SC6->C6_NUMLOTE,SC6->C6_LOCALIZ,SC6->C6_NUMSERI,NIL,NIL,NIL,lUsaVenc,nil,nil,dDataBase)
			EndIf
			For nX1 := 1 to Len(aSaldos)
				nPropLot := aSaldos[nX1][5]
				If lRastroLot
					dbSelectArea("SB8")
					dbSetOrder(5)
					If MsSeek(xFilial("SB8")+cProduto+aSaldos[nX][01])
						aadd(aInfLote,{SB8->B8_DOC,SB8->B8_SERIE,SB8->B8_CLIFOR,SB8->B8_LOJA,nPropLot})
					EndIf
				Else
					dbSelectArea("SB8")
					dbSetOrder(2)
					If MsSeek(xFilial("SB8")+aSaldos[nX][02]+aSaldos[nX][01])
						aadd(aInfLote,{SB8->B8_DOC,SB8->B8_SERIE,SB8->B8_CLIFOR,SB8->B8_LOJA,nPropLot})
					EndIf
				EndIf
				dbSelectArea("SF3")
				dbSetOrder(4)
				If !Empty(aInfLote)
					If MsSeek(xFilial("SF3")+aInfLote[nX1][03]+aInfLote[nX1][04]+aInfLote[nX1][01]+aInfLote[nX1][02])
						aadd(aNfOri,{SF3->F3_ESTADO,SF3->F3_ALIQICM,aInfLote[nX1][05],0})
					EndIf
				EndIf
			Next nX1
		EndIf
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Agrega os itens para a funcao fiscal         ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		MaFisAdd(cProduto,;   	// 1-Codigo do Produto ( Obrigatorio )
		aCols[nX][nPTES],;	   	// 2-Codigo do TES ( Opcional )
		IIf(lSaldo,aCols[nX][nPQtdVen]-nQtdEnt,aCols[nX][nPQtdVen]),;  	// 3-Quantidade ( Obrigatorio )
		nPrcLista,;		  	// 4-Preco Unitario ( Obrigatorio )
		nDesconto,; 	// 5-Valor do Desconto ( Opcional )
		"",;	   			// 6-Numero da NF Original ( Devolucao/Benef )
		"",;				// 7-Serie da NF Original ( Devolucao/Benef )
		nRecOri,;					// 8-RecNo da NF Original no arq SD1/SD2
		0,;					// 9-Valor do Frete do Item ( Opcional )
		0,;					// 10-Valor da Despesa do item ( Opcional )
		0,;					// 11-Valor do Seguro do item ( Opcional )
		0,;					// 12-Valor do Frete Autonomo ( Opcional )
		nValMerc,;			// 13-Valor da Mercadoria ( Obrigatorio )
		0,;					// 14-Valor da Embalagem ( Opiconal )
		,;					// 15
		,;					// 16
		Iif(nPItem>0,aCols[nX,nPItem],""),; //17
		0,;					// 18-Despesas nao tributadas - Portugal
		0,;					// 19-Tara - Portugal
		aCols[nX,nPosCfo],; // 20-CFO
		aNfOri,;            // 21-Array para o calculo do IVA Ajustado (opcional)
		Iif(cPaisLoc=="EQU",aCols[nX,nPCodRet],""),;// 22-Codigo Retencao - Equador
		IIF(nPAbatISS>0,aCols[nX,nPAbatISS],0),; //23-Valor Abatimento ISS
		aCols[nX,nPLote],; // 24-Lote Produto
		aCols[nX,nPSubLot],;	// 25-Sub-Lote Produto
		,;
		,;
		Iif(Len(Alltrim(aCols[nX,nPClasFis]))==3,aCols[nX,nPClasFis],"")) // 28-Classificação fiscal
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Chamada de funcao via Project Function para manipulacao das variaveis nValMerc e nPrcLista       ³
		//³ exclusivamente para o projeto MOTOROLA, nao deve ser utilizado por clientes.                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If FindFunction("P_410PRECO")
			a410Preco := P_410PRECO( nX , nValMerc , nPrcLista )
			If Valtype(a410Preco) == "A"
				nValMerc  := a410Preco[1]
				nPrcLista := a410Preco[2]
			EndIf
		EndIf
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Tratamento do IVA Ajustado                   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If lIVAAju
			For nX1 := 1 To Len(aNfOri)
				MaFisAddIT("IT_ANFORI2",{aNfOri[nX1][__UFORI],aNfOri[nX1][__ALQORI],aNfOri[nX1][__PROPOR],0},nItem,nX1==1)
			Next nX1
			aSaldos :={}
			aNfOri  :={}
		EndIf
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Provincia de entrega - Ingresos Brutos       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If cPaisLoc == "ARG"
			If nPProvEnt > 0
				MaFisAlt("IT_PROVENT",aCols[nX,nPProVent],nItem)
			Endif
		Endif
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Calculo do ISS                               ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		SF4->(dbSetOrder(1))
		SF4->(MsSeek(xFilial("SF4")+aCols[nX][nPTES]))
		If ( M->C5_INCISS == "N" .And. M->C5_TIPO == "N")
			If ( SF4->F4_ISS=="S" )
				nPrcLista := a410Arred(nPrcLista/(1-(MaAliqISS(nItem)/100)),"D2_PRCVEN")
				nValMerc  := a410Arred(nValMerc/(1-(MaAliqISS(nItem)/100)),"D2_PRCVEN")
				MaFisAlt("IT_PRCUNI",nPrcLista,nItem)
				MaFisAlt("IT_VALMERC",nValMerc,nItem)
			EndIf
		EndIf
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Altera peso para calcular frete              ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		MaFisAlt("IT_PESO",nQtdPeso,nItem)
		MaFisAlt("IT_PRCUNI",nPrcLista,nItem)
		MaFisAlt("IT_VALMERC",nValMerc,nItem)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Analise da Rentabilidade                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If SF4->F4_DUPLIC=="S"
			nTotDesc += MaFisRet(nItem,"IT_DESCONTO")
			nY := aScan(aRentab,{|x| x[1] == aCols[nX][nPProduto]})
			If nY == 0
				aadd(aRenTab,{aCols[nX][nPProduto],0,0,0,0,0})
				nY := Len(aRenTab)
			EndIf
			If cPaisLoc=="BRA"
				aRentab[nY][2] += (nValMerc - nDesconto)
			Else
				aRentab[nY][2] += nValMerc
			Endif
			aRentab[nY][3] += If(lSaldo,aCols[nX][nPQtdVen]-nQtdEnt,aCols[nX][nPQtdVen])*SB2->B2_CM1
		Else
			If GetNewPar("MV_TPDPIND","1")=="1"
				nTotDesc += MaFisRet(nItem,"IT_DESCONTO")
			EndIf
		EndIf
		
		If aCols[nX][nUsado+1]
			MaFisDel(nItem,aCols[nX][nUsado+1])
		EndIf
		
	Next nX
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Indica os valores do cabecalho               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ]
If ( ( cPaisLoc == "PER" .Or. cPaisLoc == "COL" ) .And. M->C5_TPFRETE == "F" ) .Or. ( cPaisLoc != "PER" .And. cPaisLoc != "COL" )
	MaFisAlt("NF_FRETE",M->C5_FRETE)
EndIf
MaFisAlt("NF_VLR_FRT",M->C5_VLR_FRT)
MaFisAlt("NF_SEGURO",M->C5_SEGURO)
MaFisAlt("NF_AUTONOMO",M->C5_FRETAUT)
MaFisAlt("NF_DESPESA",M->C5_DESPESA)
If cPaisLoc == "PTG"
	MaFisAlt("NF_DESNTRB",M->C5_DESNTRB)
	MaFisAlt("NF_TARA",M->C5_TARA)
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Indenizacao por valor                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If M->C5_PDESCAB > 0
	MaFisAlt("NF_DESCONTO",A410Arred(MaFisRet(,"NF_VALMERC")*M->C5_PDESCAB/100,"C6_VALOR")+MaFisRet(,"NF_DESCONTO"))
EndIf

If M->C5_DESCONT > 0
	MaFisAlt("NF_DESCONTO",Min(MaFisRet(,"NF_VALMERC")-0.01,nTotDesc+M->C5_DESCONT),/*nItem*/,/*lNoCabec*/,/*nItemNao*/,GetNewPar("MV_TPDPIND","1")=="2" )
EndIf

If lM410Ipi .Or. lM410Icm .Or. lM410Soli
	nItem := 0
	aTotSolid := {}
	For nX := 1 To Len(aCols)
		nItem++
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Ponto de Entrada M410IPI para alterar os valores do IPI referente a palnilha financeira           ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If lM410Ipi
			VALORIPI    := MaFisRet(nItem,"IT_VALIPI")
			BASEIPI     := MaFisRet(nItem,"IT_BASEIPI")
			QUANTIDADE  := MaFisRet(nItem,"IT_QUANT")
			ALIQIPI     := MaFisRet(nItem,"IT_ALIQIPI")
			BASEIPIFRETE:= MaFisRet(nItem,"IT_FRETE")
			MaFisAlt("IT_VALIPI",ExecBlock("M410IPI",.F.,.F.,{ nItem }),nItem,.T.)
			MaFisLoad("IT_BASEIPI",BASEIPI ,nItem)
			MaFisLoad("IT_ALIQIPI",ALIQIPI ,nItem)
			MaFisLoad("IT_FRETE"  ,BASEIPIFRETE,nItem,"11")
			MaFisEndLoad(nItem,1)
		EndIf
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Ponto de Entrada M410ICM para alterar os valores do ICM referente a palnilha financeira           ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If lM410Icm
			_BASEICM    := MaFisRet(nItem,"IT_BASEICM")
			_ALIQICM    := MaFisRet(nItem,"IT_ALIQICM")
			_QUANTIDADE := MaFisRet(nItem,"IT_QUANT")
			_VALICM     := MaFisRet(nItem,"IT_VALICM")
			_FRETE      := MaFisRet(nItem,"IT_FRETE")
			_VALICMFRETE:= MaFisRet(nItem,"IT_ICMFRETE")
			_DESCONTO   := MaFisRet(nItem,"IT_DESCONTO")
			ExecBlock("M410ICM",.F.,.F., { nItem } )
			MaFisLoad("IT_BASEICM" ,_BASEICM    ,nItem)
			MaFisLoad("IT_ALIQICM" ,_ALIQICM    ,nItem)
			MaFisLoad("IT_VALICM"  ,_VALICM     ,nItem)
			MaFisLoad("IT_FRETE"   ,_FRETE      ,nItem)
			MaFisLoad("IT_ICMFRETE",_VALICMFRETE,nItem)
			MaFisLoad("IT_DESCONTO",_DESCONTO   ,nItem)
			MaFisEndLoad(nItem,1)
		EndIf
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Ponto de Entrada M410SOLI para alterar os valores do ICM Solidario referente a palnilha financeira³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If lM410Soli
			ICMSITEM    := MaFisRet(nItem,"IT_VALICM")		// variavel para ponto de entrada
			QUANTITEM   := MaFisRet(nItem,"IT_QUANT")		// variavel para ponto de entrada
			BASEICMRET  := MaFisRet(nItem,"IT_BASESOL")	    // criado apenas para o ponto de entrada
			MARGEMLUCR  := MaFisRet(nItem,"IT_MARGEM")		// criado apenas para o ponto de entrada
			aSolid := ExecBlock("M410SOLI",.f.,.f.,{nItem})
			aSolid := IIF(ValType(aSolid) == "A" .And. Len(aSolid) == 2, aSolid,{})
			If !Empty(aSolid)
				MaFisLoad("IT_BASESOL",NoRound(aSolid[1],2),nItem)
				MaFisLoad("IT_VALSOL" ,NoRound(aSolid[2],2),nItem)
				MaFisEndLoad(nItem,1)
				AAdd(aTotSolid, { nItem , NoRound(aSolid[1],2) , NoRound(aSolid[2],2)} )
			Endif
		EndIf
	Next
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Realiza alteracoes de referencias do SC6         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SC6")
If Len(aFisGet) > 0
	For nX := 1 to Len(aCols)
		If Len(aCols[nX])==nUsado .Or. !aCols[nX][Len(aHeader)+1]
			For nY := 1 to Len(aFisGet)
				nPosCpo := aScan(aHeader,{|x| AllTrim(x[2])==Alltrim(aFisGet[ny][2])})
				If nPosCpo > 0
					If !Empty(aCols[nX][nPosCpo])
						MaFisAlt(aFisGet[ny][1],aCols[nX][nPosCpo],nX,.F.)
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³Quando o ponto de Entrada M410SOLI retornar valores forcar o recalculo pois o MaFisAlt acima      ³
						//³recalculava os valores retornados pelo ponto anulando a sua acao.                                 ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						If lM410Soli .And. !Empty(aTotSolid)
							nPosSolid := Ascan(aTotSolid,{|x| x[1] == nX })
							If nPosSolid > 0
								MaFisLoad("IT_BASESOL", aTotSolid[nPosSolid,02] ,nX )
								MaFisLoad("IT_VALSOL" , aTotSolid[nPosSolid,03] ,nX )
								MaFisEndLoad(nX,1)
							EndIf
						Endif
					Endif
				EndIf
			Next nY
		Endif
	Next nX
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Realiza alteracoes de referencias do SC5 Suframa ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nPSuframa:=aScan(aFisGetSC5,{|x| x[1] == "NF_SUFRAMA"})
If !Empty(nPSuframa)
	dbSelectArea("SC5")
	If !Empty(&("M->"+Alltrim(aFisGetSC5[nPSuframa][2])))
		MaFisAlt(aFisGetSC5[nPSuframa][1],Iif(&("M->"+Alltrim(aFisGetSC5[nPSuframa][2])) == "1",.T.,.F.),nItem,.F.)
	EndIf
Endif
If ExistBlock("M410PLNF")
	ExecBlock("M410PLNF",.F.,.F.)
EndIf
MaFisWrite(1)
//
// Template GEM - Gestao de Empreendimentos Imobiliarios
//
// Verifica se a condicao de pagamento tem vinculacao com uma condicao de venda
//
If ExistTemplate("GMCondPagto")
	lCondVenda := .F.
	lCondVenda := ExecTemplate("GMCondPagto",.F.,.F.,{M->C5_CONDPAG,} )
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Calcula os venctos conforme a condicao de pagto  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If !M->C5_TIPO == "B"
	If lDtEmi
		dbSelectarea("SE4")
		dbSetOrder(1)
		MsSeek(xFilial("SE4")+M->C5_CONDPAG)
		If ((SE4->E4_TIPO=="9".AND.!(INCLUI.OR.ALTERA)).OR.SE4->E4_TIPO<>"9")
			
			If SFB->FB_JNS == 'J' .And. cPaisLoc == 'COL'
				dbSelectArea("SFC")
				dbSetOrder(2)
				If dbSeek(xFilial("SFC") + SF4->F4_CODIGO + "RV0" )
					nValRetImp 	:= MaFisRet(,"NF_VALIV2")
					Do Case
						Case FC_INCDUPL == '1'
							nlValor := MaFisRet(,"NF_BASEDUP") - nValRetImp
						Case FC_INCDUPL == '2'
							nlValor :=MaFisRet(,"NF_BASEDUP") + nValRetImp
						Otherwise
							nlValor :=MaFisRet(,"NF_BASEDUP")
					EndCase
				Elseif dbSeek(xFilial("SFC") + SF4->F4_CODIGO + "RF0" )
					nValRetImp 	:= MaFisRet(,"NF_VALIV4")
					Do Case
						Case FC_INCDUPL == '1'
							nlValor := MaFisRet(,"NF_BASEDUP") - nValRetImp
						Case FC_INCDUPL == '2'
							nlValor :=MaFisRet(,"NF_BASEDUP") + nValRetImp
						Otherwise
							nlValor :=MaFisRet(,"NF_BASEDUP")
					EndCase
				Elseif dbSeek(xFilial("SFC") + SF4->F4_CODIGO + "RC0" )
					nValRetImp 	:= MaFisRet(,"NF_VALIV7")
					Do Case
						Case FC_INCDUPL == '1'
							nlValor := MaFisRet(,"NF_BASEDUP") - nValRetImp
						Case FC_INCDUPL == '2'
							nlValor :=MaFisRet(,"NF_BASEDUP") + nValRetImp
						Otherwise
							nlValor :=MaFisRet(,"NF_BASEDUP")
					EndCase
				Endif
			Else
				nlValor := MaFisRet(,"NF_BASEDUP")
			EndIf
			
			aDupl := Condicao(nlValor,M->C5_CONDPAG,MaFisRet(,"NF_VALIPI"),dDataCnd,MaFisRet(,"NF_VALSOL"),,,nAcresTot)
			If Len(aDupl) > 0
				If ! lCondVenda
					For nX := 1 To Len(aDupl)
						nAcerto += aDupl[nX][2]
					Next nX
					aDupl[Len(aDupl)][2] += MaFisRet(,"NF_BASEDUP") - nAcerto
				EndIf
				
				aVencto := aClone(aDupl)
				For nX := 1 To Len(aDupl)
					aDupl[nX][2] := TransForm(aDupl[nX][2],PesqPict("SE1","E1_VALOR"))
				Next nX
			Endif
		Else
			aDupl := {{Ctod(""),TransForm(MaFisRet(,"NF_BASEDUP"),PesqPict("SE1","E1_VALOR"))}}
			aVencto := {{dDataBase,MaFisRet(,"NF_BASEDUP")}}
		EndIf
	Else
		nItem := 0
		For nX := 1 to Len(aCols)
			If Len(aCols[nX])==nUsado .Or. !aCols[nX][nUsado+1]
				If nPDtEntr > 0
					nItem++
					nPosEntr := Ascan(aEntr,{|x| x[1] == aCols[nX][nPDtEntr]})
					If nPosEntr == 0
						Aadd(aEntr,{aCols[nX][nPDtEntr],MaFisRet(nItem,"IT_BASEDUP"),MaFisRet(nItem,"IT_VALIPI"),MaFisRet(nItem,"IT_VALSOL")})
					Else
						aEntr[nPosEntr][2]+= MaFisRet(nItem,"IT_BASEDUP")
						aEntr[nPosEntr][3]+= MaFisRet(nItem,"IT_VALIPI")
						aEntr[nPosEntr][4]+= MaFisRet(nItem,"IT_VALSOL")
					EndIf
				Endif
			Endif
		Next
		dbSelectarea("SE4")
		dbSetOrder(1)
		MsSeek(xFilial("SE4")+M->C5_CONDPAG)
		If !(SE4->E4_TIPO=="9")
			For nY := 1 to Len(aEntr)
				nAcerto  := 0
				
				If SFB->FB_JNS $ 'J/S' .And. cPaisLoc == 'COL'
					
					dbSelectArea("SFC")
					dbSetOrder(2)
					If dbSeek(xFilial("SFC") + SF4->F4_CODIGO + "RV0" )
						nValRetImp 	:= MaFisRet(,"NF_VALIV2")
						Do Case
							Case FC_INCDUPL == '1'
								nlValor := aEntr[nY][2] - nValRetImp
							Case FC_INCDUPL == '2'
								nlValor :=aEntr[nY][2] + nValRetImp
							Otherwise
								nlValor :=aEntr[nY][2]
						EndCase
					Elseif dbSeek(xFilial("SFC") + SF4->F4_CODIGO + "RF0" )
						nValRetImp 	:= MaFisRet(,"NF_VALIV4")
						Do Case
							Case FC_INCDUPL == '1'
								nlValor := aEntr[nY][2] - nValRetImp
							Case FC_INCDUPL == '2'
								nlValor :=aEntr[nY][2] + nValRetImp
							Otherwise
								nlValor :=aEntr[nY][2]
						EndCase
					Elseif dbSeek(xFilial("SFC") + SF4->F4_CODIGO + "RC0" )
						nValRetImp 	:= MaFisRet(,"NF_VALIV7")
						Do Case
							Case FC_INCDUPL == '1'
								nlValor := aEntr[nY][2] - nValRetImp
							Case FC_INCDUPL == '2'
								nlValor :=aEntr[nY][2] + nValRetImp
							Otherwise
								nlValor :=aEntr[nY][2]
						EndCase
					Endif
				ElseIf cPaisLoc=="EQU" .And. lPParc
					DbSelectArea("SFC")
					SFC->(dbSetOrder(2))
					If DbSeek(xFilial("SFC") + SF4->F4_CODIGO + "RIR") //Retenção IVA
						cImpRet		:= SFC->FC_IMPOSTO
						DbSelectArea("SFB")
						SFB->(dbSetOrder(1))
						If SFB->(DbSeek(xFilial("SFB")+AvKey(cImpRet,"FB_CODIGO")))
							nValRetImp 	:= MaFisRet(,"NF_VALIV"+SFB->FB_CPOLVRO)
						Endif
						DbSelectArea("SFC")
						If SFC->FC_INCDUPL == '1'
							nlValor	:=aEntr[nY][2] - nValRetImp
						ElseIf SFC->FC_INCDUPL == '2'
							nlValor :=aEntr[nY][2] + nValRetImp
						EndIf
					Endif
				Else
					nlValor := aEntr[nY][2]
				EndIf
				
				
				aDuplTmp := Condicao(nlValor,M->C5_CONDPAG,aEntr[nY][3],aEntr[nY][1],aEntr[nY][4],,,nAcresTot)
				If Len(aDuplTmp) > 0
					If ! lCondVenda
						If cPaisLoc=="EQU"
							For nX := 1 To Len(aDuplTmp)
								If nX==1
									If SFC->FC_INCDUPL == '1'
										aDuplTmp[nX][2]+= nValRetImp
									ElseIf SFC->FC_INCDUPL == '2'
										aDuplTmp[nX][2]-= nValRetImp
									Endif
								Endif
							Next nX
						Else
							For nX := 1 To Len(aDuplTmp)
								nAcerto += aDuplTmp[nX][2]
							Next nX
							aDuplTmp[Len(aDuplTmp)][2] += aEntr[nY][2] - nAcerto
						Endif
					EndIf
					
					aVencto := aClone(aDuplTmp)
					For nX := 1 To Len(aDuplTmp)
						aDuplTmp[nX][2] := TransForm(aDuplTmp[nX][2],PesqPict("SE1","E1_VALOR"))
					Next nX
					aEval(aDuplTmp,{|x| Aadd(aDupl,{aEntr[nY][1],x[1],x[2]})})
				EndIf
			Next
		Else
			aDupl := {{Ctod(""),TransForm(MaFisRet(,"NF_BASEDUP"),PesqPict("SE1","E1_VALOR"))}}
			aVencto := {{dDataBase,MaFisRet(,"NF_BASEDUP")}}
		EndIf
	EndIf
Else
	aDupl := {{Ctod(""),TransForm(0,PesqPict("SE1","E1_VALOR"))}}
	aVencto := {{dDataBase,0}}
EndIf

//
// Template GEM - Gestao de empreendimentos Imobiliarios
// Gera os vencimentos e valores das parcelas conforme a condicao de venda
//
If lCondVenda
	If ExistBlock("GMMA410Dupl")
		aVencto := ExecBlock("GMMA410Dupl",.F.,.F.,{M->C5_NUM ,M->C5_CONDPAG,dDataCnd,,MaFisRet(,"NF_BASEDUP") ,aVencto}, .F., .F.)
	ElseIf ExistTemplate("GMMA410Dupl")
		aVencto := ExecTemplate("GMMA410Dupl",.F.,.F.,{M->C5_NUM ,M->C5_CONDPAG,dDataCnd,,MaFisRet(,"NF_BASEDUP") ,aVencto})
	Endif
	aDupl := {}
	aEval(aVencto ,{|aTitulo| aAdd( aDupl ,{transform(aTitulo[1],x3Picture("E1_VENCTO")) ,transform(aTitulo[2],x3Picture("E1_VALOR"))}) })
EndIf

If Len(aDupl) == 0
	aDupl := {{Ctod(""),TransForm(MaFisRet(,"NF_BASEDUP"),PesqPict("SE1","E1_VALOR"))}}
	aVencto := {{dDataBase,MaFisRet(,"NF_BASEDUP")}}
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Analise da Rentabilidade - Valor Presente    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aRentabil := {}//a410RentPV( aCols ,nUsado ,@aRenTab ,@aVencto ,nPTES,nPProduto,nPLocal,nPQtdVen, M->C5_EMISSAO )

nValTotal := MaFisRet(,"NF_TOTAL")

MaFisEnd()
MaFisRestore()

RestArea(aAreaSA1)
RestArea(aArea)

aRefRentab := aRentabil

If SuperGetMv("MV_RSATIVO",.F.,.F.)
	lPlanRaAtv := .T.
EndIf

Return(nValTotal)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCECOM08  ºAutor  ³Microsiga           º Data ³  02/20/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function ECOM08PV()

Local aAreaSC5:=SC5->(GetArea())

MATA410()

RestArea(aAreaSC5)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCECOM08  ºAutor  ³Microsiga           º Data ³  02/27/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function COM08VAL()
Local aAreaAtu	:= GetArea()
Local aAreaSA1	:= SA1->(GetArea())
Local lRetorno	:= .T.


RestArea(aAreaSA1)
RestArea(aAreaAtu)

Return lRetorno
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ECOMHTM   ºAutor  ³Microsiga           º Data ³  02/27/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function CM08Entrega(cCodEntrega)

Local aAreaAtu:=GetArea()
Local aAreaZX5:=ZX5->(GetArea())
Local dDtRetorno:=MsDate()
Local cChaveZX5	:=xFilial("ZX5")+"00001"+Padr( AllTrim(cCodEntrega) ,Len(ZX5->ZX5_CHAVE)  )
Local aDados
Local nInd

ZX5->(DbSetOrder(1))//ZX5_FILIAL+ZX5_TABELA+ZX5_CHAVE
If ZX5->(DbSeek(cChaveZX5))
	aDados:=StrTokArr (ZX5->ZX5_DESCRI, "#" )
	If Len(aDados)>=2 .And. !Empty(aDados[2])
		dDtRetorno+=Val( aDados[2] )
	EndIf
EndIf

RestArea(aAreaAtu)
RestArea(aAreaZX5)

Return dDtRetorno

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCECOM08  ºAutor  ³Microsiga           º Data ³  03/20/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function COM08WMS(cPedido,lWMPedido,lEnviar)

Local aAreaAtu := GetArea()
Local aAreaZC5 := ZC5->(GetArea())
Local aAreaSC5 	:= SC5->(GetArea())

Local cBody		:= ""
Local cToLoja	:= ""
Local cAssunto := ""
Local cErro		:= ""

SC5->(DbSetOrder(1))
SC5->(MsSeek(xFilial("SC5")+cPedido))

If lWMPedido .And. lEnviar
	U_NCECOM09(ZC5->ZC5_NUM, ZC5->ZC5_NUMPV,"Pedido liberado no Crédito Automaticamente(Risco A)",cMsg,ZC5->ZC5_STATUS,lMsErroAuto,,,ZC5->ZC5_PVVTEX)
EndIf


U_Z7Status(SC5->C5_FILIAL,SC5->C5_NUM,"000002","PEDIDO LIBERADO POR VENDAS",SC5->C5_CLIENTE)
U_MT450FIM(SC5->C5_NUM)


If VeriEnvWMS(SC5->C5_NUM)
	U_NCECOM09(ZC5->ZC5_NUM, SC5->C5_NUM,"Envio para WMS","Pedido enviado para o WMS com sucesso.","",.T.,,,ZC5->ZC5_PVVTEX)
EndIf

If lWMPedido .And. lEnviar
	U_WM001Send("PEDIDO",ZC5->ZC5_NUMPV)
Elseif lWMPedido .And. !lEnviar
	ZC5->(DbSetOrder(2))//ZC5_FILIAL+ZC5_NUMPV
	ZC5->(DbSeek(xFilial("ZC5")+cPedido))
	
	If ZC5->ZC5_PLATAF == "WM"
		
		cBody 	:= U_ECOMHTMI(ZC5->(Recno()),.t.)
		cToLoja	:= Alltrim(U_MyNewSX6("NCG_000088","rciambarella@ncgames.com.br","C","E-mail dos usuários que irão receber as infomações do credito","","",.F. ))
		cAssunto	:= "Pedido de loja aguardando análise de crédito."
		
		If !U_COM08SEND(cAssunto, cBody, , cToLoja,, @cErro)
			U_NCECOM09(ZC5->ZC5_NUM, ZC5->ZC5_NUMPV,'Erro ao enviar e-mail para '+ cToLoja,cErro,ZC5->ZC5_STATUS,.T.)
		EndIf
		
	EndIf
	
Endif

RestArea(aAreaSC5)
RestArea(aAreaZC5)
RestArea(aAreaAtu)

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ECM08LPV  ºAutor  ³Elton		           º Data ³  02/20/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Liberação de pedido e-commerce                             º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function ECM08LPV()

Local aArea := GetArea()

Mata440()

RestArea(aArea)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ECOM08BOL ºAutor  ³Lucas Felipe        º Data ³  04/28/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Envio de Email de boletos a vencer.                         º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function Ecom08Bol()

Local cFilZC5		:= xFilial("ZC5")

Local cAliasZC5 	:= ZC5->(GetArea())
Local cAliasQry 	:= GetNextAlias()

Local cHtml			:= ""
Local cQry			:= ""

Local cAssunto		:= "Pedido com Boleto Vencido"
Local aAnexos		:= {}
Local cEmailTo		:= SuperGetMv("EC_NCG0006",,"lfelipe@ncgames.com.br")

Local cRecZC5 := ""
Local cRecSA1 := ""


cQry := ""
cQry += " SELECT 	ZC5.R_E_C_N_O_ RECZC5,  ZC5.ZC5_NUM, "+CRLF
cQry += "			SA1.R_E_C_N_O_ RECSA1 "+CRLF
cQry += " FROM "+ RetSqlName("ZC5") +" ZC5 "+CRLF
cQry += "	LEFT OUTER JOIN "+ RetSqlName("SC5") +" SC5 "+CRLF
cQry += "		ON SC5.D_E_L_E_T_ = ' ' "+CRLF
cQry += "		AND SC5.C5_FILIAL = '"+ xFilial("SC5") +"' "+CRLF
cQry += "		AND SC5.C5_NUM = ZC5.ZC5_NUMPV "+CRLF
cQry += "		AND SC5.C5_CLIENTE = ZC5.ZC5_CLIENT "+CRLF
cQry += "	LEFT OUTER JOIN "+ RetSqlName("SA1") +" SA1 "+CRLF
cQry += "		ON SA1.D_E_L_E_T_ = ' ' "+CRLF
cQry += "		AND SA1.A1_COD = ZC5.ZC5_CLIENT "+CRLF
cQry += "		AND SA1.A1_LOJA = ZC5.ZC5_LOJA "+CRLF
cQry += " WHERE ZC5.ZC5_FILIAL = '"+ cFilZC5 +"' "+CRLF
cQry += "	AND ZC5.ZC5_STATUS NOT IN ('90','96') "+CRLF
cQry += "	AND ZC5.ZC5_PAGTO = ' ' "+CRLF
cQry += "	AND ZC5.ZC5_FLAG = ' ' "+CRLF
cQry += "	AND ZC5.ZC5_COND = 'BOL' "+CRLF
cQry += "	AND ZC5.D_E_L_E_T_ = ' ' "+CRLF

cQry := ChangeQuery(cQry)

dbUseArea(.T., "TOPCONN", TCGenQry(,,cQry),cAliasQry, .T., .F.)


While (cAliasQry)->(!Eof())
	
	cRecZC5 := (cAliasQry)->RECZC5
	cRecSA1 := (cAliasQry)->RECSA1
	
	cHtml := u_ECOMHTMC(cRecZC5,cRecSA1)
	nNumPed := (cAliasQry)->ZC5_NUM
	
	If  !Empty(cHtml)
		cAssunto := "Pedido com Boleto Vencido Num: "+TransForm(nNumPed,"99999")+"."
		U_COM08SEND(cAssunto, cHtml, aAnexos, cEmailTo,"",)
		
	EndIf
	
	(cAliasQry)->(DbSkip())
	
EndDo

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCECOM08  ºAutor  ³Microsiga           º Data ³  06/05/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function VeriEnvWMS(cNumPVP)

Local aArea 		:= GetArea()
Local cQuery   	:= ""
Local cArqTmp		:= GetNextAlias()
Local lRet			:= .F.

Default cNumPVP	:= ""

cQuery   := " SELECT COUNT(*) CONTPED FROM "+RetSqlName("P0A")+" P0A  "+CRLF
cQuery   += " WHERE P0A.P0A_FILIAL = '"+xFilial("P0A")+"' "+CRLF
cQuery   += " AND P0A.P0A_CHAVE = '"+xFilial("ZC5")+Alltrim(cNumPVP)+"' "+CRLF
cQuery   += " AND P0A.D_E_L_E_T_ = ' ' "+CRLF

dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cArqTmp,.T.,.T.)

If (cArqTmp)->(!Eof())
	If (cArqTmp)->CONTPED > 0
		lRet := .T.
	EndIf
EndIf

(cArqTmp)->(DbCloseArea())

RestArea(aArea)
Return lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCECOM08  ºAutor  ³Microsiga           º Data ³  04/29/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function ECOM08B2C()

Local aAreaSC5:=SC5->(GetArea())

MATA410()

RestArea(aAreaSC5)

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCECOM08  ºAutor  ³Microsiga           º Data ³  01/22/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function M08Job(aDados)

Local aAcao:={"VERIFICA_EXPEDICAO","VERIFICA_RASTREIO","VERIFICA_ENTREGA"}
Local nInd
Local aStatus 	:= {}

Default aDados:={"01","03"}


RpcClearEnv()
RpcSetType(3)
RpcSetEnv(aDados[1], aDados[2])


MyMensagem("U_COM08Vtex")
U_COM08Vtex(aDados)

For nInd:=1 To Len(aAcao)
	MyMensagem("U_NCECOM08")
	U_NCECOM08( {aDados[1], aDados[2], aAcao[nInd], .T.})
Next

RpcClearEnv()
MyMensagem("u_Vtex05Ras")
u_Vtex05Ras(aDados)

RpcClearEnv()
MyMensagem("u_Ecom07Job")
u_Ecom07Job(aDados)


Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCECOM08  ºAutor  ³Microsiga           º Data ³  01/22/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function MyMensagem(cMensagem)

PtInternal(1,cMensagem)
TcInternal(1,cMensagem)
Conout(cMensagem)

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCECOM08  ºAutor  ³Microsiga           º Data ³  03/17/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function M008CONPG(cCanal)

Local aAreaAtu	:= GetArea()
Local cAliasQry	:= GetNextAlias()
Local cQry		:= ""
Local cRetorno	:= ""

cQry += "	SELECT ZE4.ZE4_PMEDIO MEDIA, "+CRLF
cQry += "	ZE4.ZE4_CPDEFA CPDEF,"+CRLF
cQry += "	ZE4.ZE4_CRULES RULES"+CRLF
cQry += "	FROM "+RetSqlName("ZE4")+" ZE4"+CRLF
cQry += "	WHERE ZE4.ZE4_FILIAL = '"+xFilial("ZE4")+"'"+CRLF
cQry += "	AND ZE4.ZE4_CANAL = '"+cCanal+"'"+CRLF
cQry += "	AND ZE4.ZE4_FLAG = '2'"+CRLF
cQry += "	AND ZE4.D_E_L_E_T_ = ' '"+CRLF

dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),cAliasQry,.T.,.T.)

cRetorno:=(cAliasQry)->CPDEF

(cAliasQry)->(DbCloseArea())
RestArea(aAreaAtu)

Return cRetorno


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCECOM08  ºAutor  ³Microsiga           º Data ³  03/18/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function MyMaLibDoFat(nRegSC6,nQtdaLib,lCredito,lEstoque,lAvCred,lAvEst,lLibPar,lTrfLocal,aEmpenho,bBlock,aEmpPronto,lTrocaLot,lOkExpedicao,nVlrCred,nQtdalib2)

Local aArea    	:= GetArea("SC6")
Local aAreaSA1 	:= SA1->(GetArea())
Local aAreaSF4 	:= SF4->(GetArea())
Local aAreaSC5 	:= {}
Local aAreaSC6 	:= {}
Local nQtdLib  	:= nQtdALib
Local nQtdLib2 	:= nQtdALib2
Local lContinua	:= .T.
Local lIntACD  	:= SuperGetMV("MV_INTACD",.F.,"0") == "1"
Local lPedLib  	:= .F.
Local lLibItPrev	:= SuperGetMV( 'MV_FATLBPR', .F., .T. )	//Indica se permite a libera?o de Itens previstos do Pedido de Venda

nQtdLib := nQtdALib
//?????????????????????????????????????
//?eta os parametros defaults                                             ?
//?????????????????????????????????????
DEFAULT nQtdALib    := SC6->C6_QTDLIB
DEFAULT nQtdALib2   := SC6->C6_QTDLIB2
DEFAULT lCredito    := .T.
DEFAULT lEstoque    := .T.
DEFAULT lAvCred     := .T.
DEFAULT lAvEst      := .T.
DEFAULT lOkExpedicao:= .F.
//??????????????????????
//?erificar se o Pedido ja possui liberacao ?
//??????????????????????
If lIntACD .And. IsInCallStack("MATA455")
	lPedLib :=SC9->(dbSeek(xFilial("SC9")+SC6->(SC6->C6_NUM+SC6->C6_ITEM)))
EndIf

//?????????????????????????????????????
//?osiciona Pedido                                                        ?
//?????????????????????????????????????
If Empty(SC6->C6_BLOQUEI) .And. AllTrim(SC6->C6_BLQ)<>"R" .And. If(lPedLib,If(SC9->(FieldPos("C9_ORDSEP"))<> 0,If(Empty(SC9->C9_ORDSEP),.T.,If(!Empty(SC9->C9_ORDSEP) .And. !Empty(SC9->C9_NFISCAL),.T.,.F.)),.T.),.T.)
	
	dbSelectArea("SC6")
	If nRegSC6<>0
		aAreaSC6 := GetArea()
		MsGoto(nRegSC6)
	Else
		aAreaSC6 := GetArea("SC6")
	EndIf
	
	If SB1->B1_FILIAL+SB1->B1_COD <> xFilial('SB1')+SC6->C6_PRODUTO
		SB1->(DbSetOrder(1))
		SB1->(MsSeek(xFilial('SB1')+SC6->C6_PRODUTO))
	Endif
	dbSelectArea("SC5")
	dbSetOrder(1)
	If ( xFilial("SC5")==SC5->C5_FILIAL .And. SC5->C5_NUM==SC6->C6_NUM )
		aAreaSC5 := GetArea("SC5")
	Else
		MsSeek(xFilial("SC5")+SC6->C6_NUM)
		aAreaSC5 := GetArea()
	EndIf
	//?????????????????????????????????????
	//?ntegracao com EEC													   ?
	//?uncao: AvChkStDesp()												   ?
	//?arametros: Nro do pedido de venda. 									   ?
	//?etorno: True  - O pedido de venda podera ser liberado visto que as 	   ?
	//?				despesas ja foram integradas.						   ?
	//?        False - O pedido de venda n? poder?ser liberado visto que    ?
	//?				existem pendencias para as despesas.				   ?
	//?????????????????????????????????????
	If !Empty(SC5->C5_PEDEXP)
		If FindFunction("AvChkStDesp")
			If !AvChkStDesp(SC5->C5_NUM)
				lContinua := .F.
			EndIf
		EndIf
	EndIf
	
	//------------------------------------------------------------------------------
	// Verifica o tipo de opera?o (C6_TPOP) antes de liberar. Itens previstos n?
	// podem ser liberados a menos que o par?etro MV_FATLBPR esteja como .T.
	// Altera?o realizada para atender o requisito de Programa?o de Entrega.
	//------------------------------------------------------------------------------
	If ( SC6->C6_TPOP == "P" ) .And. ( !lLibItPrev )
		lContinua := .F.
	EndIf
	
	If lContinua
		If nRegSC6 == 0 .Or. ( RecLock("SC5") .And. RecLock("SC6") )
			If Empty(SC5->C5_BLQ)
				If nQtdALib2 == 0 .And. SC6->C6_UNSVEN <> 0
					nQtdALib2 := SB1->(ConvUm(SC6->C6_PRODUTO,nQtdALib,Nil,2))
					If nQtdALib2 == 0
						If SC6->C6_QTDVEN-SC6->C6_QTDEMP-SC6->C6_QTDENT-nQtdALib==0
							nQtdALib2 := SC6->C6_UNSVEN-SC6->C6_QTDEMP2-SC6->C6_QTDENT2
						Else
							nQtdALib2 := nQtdALib*SC6->C6_UNSVEN/SC6->C6_QTDVEN
						EndIf
					EndIf
					SC6->C6_QTDLIB2:= nQtdALib2
					nQtdALib2 := SC6->C6_QTDLIB2
				EndIf
				SC6->C6_QTDLIB := nQtdALib
				SC6->C6_QTDLIB2:= nQtdALib2
				FatAtuEmpN("-")
				nQtdLib := a440GeraC9(@nQtdLib,@lCredito,@lEstoque,lAvCred,lAvEst,lLibPar,lTrfLocal,@aEmpenho,bBlock,aEmpPronto,lTrocaLot,lOkExpedicao,@nVlrCred,@nQtdlib2)
				FatAtuEmpN("+")
			EndIf
		EndIf
	Else
		nQtdLib := 0
	EndIf
	RestArea(aAreaSC5)
	RestArea(aAreaSC6)
	
Else
	nQtdLib := 0
Endif

//?????????????????????????????????????
//?estaura a Entrada                                                      ?
//?????????????????????????????????????
RestArea(aAreaSA1)
RestArea(aAreaSF4)
RestArea(aArea)
Return(nQtdLib)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCECOM08  ºAutor  ³Microsiga           º Data ³  03/18/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function a440GeraC9(nQtdLib,lCredito,lEstoque,lAvCred,lAvEst,lLiber,lTransf,aEmpenho,;
bBlock,aEmpPronto,lTrocaLot,lOkExpedicao,nVlrCred,nQtdLib2)

Local aArea     := GetArea(Alias())
Local aAreaSA1  := SA1->(GetArea())
Local aAreaSB2  := SB2->(GetArea())
Local aAreaSF4  := SF4->(GetArea())
Local aSaldos   := {}
Local aLocal    := {}

Local nSldSB6   := 0
Local cBlCred   := ""
Local cBlEst    := ""
Local cAliasSB6 := "SB6"
Local lQuery    := .F.

Local lBlqCrd   := GetMv("MV_BLQCRED")
Local lTravas   := .T.

Local nQtdJaLib := 0
Local nQtdPoder3:= 0
Local nQtdNPT   := 0
Local nQtdNosso := 0
Local lMTValAvC := ExistBlock("MTVALAVC")
Local	nValAv	 := 0
Local aEmpBN	:= If(FindFunction("A410CarBen"),A410CarBen(SC6->C6_NUM,SC6->C6_ITEM),{})
Local nX        := 0
Local nMvTipCrd 	:= SuperGetMV("MV_TIPACRD", .F., 1)
Local nVlrTitAbe	:= 0
Local nVlrTitAtr	:= 0

#IFDEF TOP
	Local cQuery    := ""
#ENDIF

//?????????????????
//Tratamento para e-Commerce


Local lECommerce := SuperGetMV("MV_LJECOMM",,.F.) .And. GetRpoRelease("R5")
Local cOrcamto   := ""    //Obtem o orcamento original para poder posicionar na tabela MF5.


//?justa a Entrada da Rotina
DEFAULT lAvCred     := .T.
DEFAULT lAvEst      := .T.
DEFAULT lLiber      := .F.
DEFAULT lTransf     := .F.
DEFAULT lOkExpedicao:= .F.

If ( At(SC5->C5_TIPO,"CIP") > 0 )
	lLiber := .F.
EndIf
dbSelectArea("SF4")
dbSetOrder(1)
MsSeek(xFilial("SF4")+SC6->C6_TES)


//?osiciona Registros
If ( At(SC5->C5_TIPO,"DB") == 0 .And. SF4->F4_DUPLIC=='S' )
	dbSelectArea("SA1")
	dbSetOrder(1)
	MsSeek(xFilial("SA1")+SC6->C6_CLI+SC6->C6_LOJA)
	lTravas := RecLock("SA1")
EndIf

dbSelectArea("SB2")
dbSetOrder(1)
If ( MsSeek(xFilial("SB2")+SC6->C6_PRODUTO+SC6->C6_LOCAL) .And. lTravas )
	lTravas := RecLock("SB2")
EndIf

//?erifica se o SB2 e o SA1 estao Travados
If ( lTravas )
	//?????????????????????????????????????????????????????????????????????????
	//?omplementos nao devem ter o Credito ou Estoque Avaliado.               ?
	//?evolucao de Poder de Terceiro nao deve ter o Credito avaliado.         ?
	//?????????????????????????????????????????????????????????????????????????
	If ( AT(SC5->C5_TIPO,"CIP") > 0 .Or. ( SF4->F4_PODER3 == "D" .And. SF4->F4_ESTOQUE=="N") .Or. MaTesSel(SF4->F4_CODIGO) )
		lEstoque := .T.
		lCredito := .T.
	Else
		//?valiacao de Estoque
		If ( lAvEst )
			//?omente avalia-se estoque quando ha movimentacao e nao ha reserva
			If ( SF4->F4_ESTOQUE == "S" .And. Empty(SC6->C6_RESERVA) )
				If SuperGetMV("MV_AVALEST")==3 .And. !AtIsRotina("MATA455")
					If !((Rastro(SC6->C6_PRODUTO) .Or. Localiza(SC6->C6_PRODUTO)) .And. SuperGetMv("MV_GERABLQ")=="N")
						lEstoque := .F.
						For nX := 1 To Len( aEmpBN )
							A410LibBen(1,aEmpBN[nX,1],aEmpBN[nX,2],SC6->C6_QTDVEN,SC6->C6_UNSVEN)
						Next
					Else
						lEstoque := A440VerSB2(@nQtdLib,lLiber,lTransf,@aLocal,@aEmpenho)
					EndIf
				Else
					lEstoque := A440VerSB2(@nQtdLib,lLiber,lTransf,@aLocal,@aEmpenho)
				EndIf
			Else
				If ( !Empty(SC6->C6_RESERVA) )
					lEstoque := .T.
					
					If cPaisLoc<>"BRA" .AND. SC6->C6_QTDRESE == 0
						nQtdLib := Min(SC6->C6_QTDVEN,nQtdLib)
					Else
						nQtdLib := Min(SC6->C6_QTDRESE,nQtdLib)
					EndIf
					
				Else
					lEstoque := .T.
				EndIf
			EndIf
		EndIf
		//?valiacao de Credito
		If ( lAvCred )
			If ( !SC5->C5_TIPO $ "DB" )
				If ( SF4->F4_DUPLIC == "S" .Or. SuperGetMv("MV_LIBNODP")=="S" )
					If ( lBlqCrd .And. !lEstoque )
						lCredito := .F.
						cBlCred  := "02"
					Else
						If lMTValAvC
							nValAv	:=	ExecBLock("MTValAvC",.F.,.F.,{'A440GERAC9',SC6->C6_PRCVEN*nQtdLib,Nil})
						Else
							nValAv	:=	SC6->C6_PRCVEN*nQtdLib
						Endif
						//A variavel nValItPed (Private) he criada nas funcoes:(A440Grava, A410Grava e a440Proces)
						If nMvTipCrd == 2 .AND. FindFunction("FatCredTools") .AND. Type("nValItPed") <> "U"
							
							If nValItPed == 0
								//Consulta os titulos em aberto
								nVlrTitAbe := SldCliente(SC9->C9_CLIENTE + SC9->C9_LOJA, Nil, Nil, .F.)
								//Consulta os titulos em atraso
								nVlrTitAtr := CrdXTitAtr(SC9->C9_CLIENTE + SC9->C9_LOJA, Nil, Nil, .F.)
							EndIf
							
							nValItPed += nValAv
							
							LJMsgRun('STR0010',,{|| lCredito := FatCredTools(SA1->A1_COD,SA1->A1_LOJA, nValItPed, nVlrTitAbe, nVlrTitAtr)})//"Aguarde... Efetuando Analise de Cr?ito."
							//lCredito := FatCredTools(SA1->A1_COD,SA1->A1_LOJA, nValItPed, nVlrTitAbe, nVlrTitAtr)
						Else
							lCredito := MaAvalCred(SA1->A1_COD,SA1->A1_LOJA,nValAV,SC5->C5_MOEDA,.T.,@cBlCred,@aEmpenho,@nVlrCred)
						EndIf
					EndIf
				Else
					lCredito := .T.
				EndIf
			Else
				lCredito := .T.
			EndIf
		EndIf
	EndIf
EndIf
//????????????????????????????????????????????????????????????????????????????
//?ara e-Commerce ira gravar com bloqueio de credito para Boleto(FI) e sem   ?
//?loqueio para os demais.                                                   ?
//????????????????????????????????????????????????????????????????????????????
If  lECommerce .And. !( Empty(SC5->C5_ORCRES) ) .And. ChkFile("MF5")
	MF5->( DbSetOrder(1) ) //MF5_FILIAL+MF5_ECALIA+MF5_ECVCHV
	
	cOrcamto := Posicione("SL1",1,xFilial("SL1")+SC5->C5_ORCRES,"L1_ORCRES")
	
	If  !( Empty(cOrcamto) ) .And. !( Empty(Posicione("MF5",1,xFilial("MF5")+"SL1"+xFilial("SL1")+cOrcamto,"MF5_ECPEDI")) )
		If  (Alltrim(SL1->L1_FORMPG) == "FI") .And. (MF5->MF5_ECPAGO != "1")
			cBlCred  := "02"
			lCredito := .F.
		Else
			cBlCred  := "  "
			lCredito := .T.
		EndIf
	EndIf
EndIf
//? Neste momento eh gerado os empenhos e o SC9 dependendo do caso
If ( lTravas .And. (SC5->C5_TIPO$"CIP" .Or. nQtdLib > 0 .Or. MaTesSel(SF4->F4_CODIGO)) )
	//? Busca dados ref. ao Beneficiamento no SB6 para gerar Registros no SC9
	If ( SF4->F4_PODER3=='D' .And. !(SC5->C5_TIPO$"CIPD") )
		nQtdPoder3 := nQtdLib
	Else
		If lCredito .And. lEstoque
			aSaldos := MaNeedP3(nQtdLib)
			nQtdNosso := aSaldos[1]
			nQtdPoder3:= aSaldos[2]
			nQtdNPT   := aSaldos[3]
		Else
			nQtdNosso := nQtdLib
		EndIf
	EndIf
	//?Verifica os codigos de bloqueio
	If ( Empty(cBlCred) )
		If ( !lCredito )
			If At(SC5->C5_TIPO,"DB") == 0 .And. SF4->F4_DUPLIC == 'S' .And. SC5->C5_TIPLIB == "2" .And.;
				( !Empty(SA1->A1_VENCLC) .And. SA1->A1_VENCLC < dDataBase ) .And. nVlrCred <= 0
				cBlCred := "04"		//Vencimento do Limite de Credito
			Else
				cBlCred := "01"
			EndIf
		EndIf
	EndIf
	If ( Empty(cBlEst) )
		If ( !lEstoque )
			cBlEst := "02"
		EndIf
	EndIf
	//?Tratamento da quantidade a ser liberada do poder de terceiros
	If nQtdPoder3 > 0
		//?Posiciona Registros
		dbSelectArea("SB6")
		If Empty(SC6->C6_IDENTB6)
			dbSetOrder(1)
		Else
			dbSetOrder(3)
		EndIf
		#IFDEF TOP
			cAliasSB6 := "A440GERAC9"
			lQuery    := .T.
			aStruSB6  := SB6->(dbStruct())
			SB6->(dbCommit())
			
			cQuery := "SELECT B6_FILIAL,B6_CLIFOR,B6_LOJA,B6_IDENT,B6_PRODUTO,"
			cQuery += "B6_QULIB,B6_SALDO "
			cQuery += "FROM "+RetSqlName("SB6")+" SB6 "
			cQuery += "WHERE SB6.B6_FILIAL='"+xFilial("SB6")+"' AND "
			cQuery += "SB6.B6_PRODUTO='"+SC6->C6_PRODUTO+"' AND "
			If !Empty(SC6->C6_IDENTB6)
				cQuery += "SB6.B6_IDENT='"+SC6->C6_IDENTB6+"' AND "
			EndIf
			cQuery += "(SB6.B6_SALDO-SB6.B6_QULIB)>0 AND "
			cQuery += "SB6.D_E_L_E_T_=' ' "
			cQuery += "ORDER BY "+SqlOrder(SB6->(IndexKey()))
			
			cQuery := ChangeQuery(cQuery)
			
			dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSB6,.T.,.T.)
			For nX := 1 To Len(aStruSB6)
				If aStruSB6[nX][2] <> "C" .And. FieldPos(aStruSB6[nX][1])<>0
					TcSetField(cAliasSB6,aStruSB6[nX][1],aStruSB6[nX][2],aStruSB6[nX][3],aStruSB6[nX][4])
				EndIf
			Next nX
		#ELSE
			If Empty(SC6->C6_IDENTB6)
				MsSeek(xFilial("SB6")+SC6->C6_PRODUTO)
			Else
				MsSeek(xFilial("SB6")+SC6->C6_IDENTB6+SC6->C6_PRODUTO)
			EndIf
		#ENDIF
		While (!Eof() .And.  xFilial("SB6") == (cAliasSB6)->B6_FILIAL .And.;
			IIf(Empty(SC6->C6_IDENTB6),.T.,;
			SC6->C6_IDENTB6==(cAliasSB6)->B6_IDENT) .And.;
			SC6->C6_PRODUTO==(cAliasSB6)->B6_PRODUTO .And.;
			nQtdPoder3 > 0 )
			nSldSB6 := ( (cAliasSB6)->B6_SALDO - (cAliasSB6)->B6_QULIB )
			If ( nSldSB6 > 0 )
				nSldSb6 := Min(nSldSB6,nQtdPoder3)
				If !( ( Rastro(SC6->C6_PRODUTO).Or.Localiza(SC6->C6_PRODUTO) ) .And.;
					SuperGetMv("MV_GERABLQ")=="N" .And. !lEstoque )
					MaGravaSc9(nSldSb6,cBlCred,cBlEst,@aLocal,@aEmpenho,(cAliasSB6)->B6_IDENT,bBlock,aEmpPronto,nQtdLib2,@nVlrCred)
					nQtdJaLib += nSldSb6
				EndIf
				nQtdPoder3 -= nSldSB6
			EndIf
			dbSelectArea(cAliasSB6)
			dbSkip()
		EndDo
		If lQuery
			dbSelectArea(cAliasSB6)
			dbCloseArea()
			dbSelectArea("SB6")
		EndIf
	EndIf
	//?Tratamento da quantidade a ser liberada - Nossa em Terceiros
	If nQtdNPT > 0
		//?Verificacao do Parametro MV_GERABLQ
		If !( (Rastro(SC6->C6_PRODUTO) .Or. Localiza(SC6->C6_PRODUTO)) .And.;
			SuperGetMv("MV_GERABLQ")=="N" .And. !lEstoque )
			MaGravaSc9(nQtdNPT,cBlCred,cBlEst,@aLocal,@aEmpenho,,bBlock,aEmpPronto,,@nVlrCred,"03")
			nQtdJaLib += nQtdNPT
		EndIf
	EndIf
	//?Tratamento da quantidade a ser liberada - Nosso Poder
	
	If nQtdNosso > 0 .Or. MaTesSel(SF4->F4_CODIGO)	.Or. Ma440Compl()
		//?Verificacao do Parametro MV_GERABLQ
		If !( (Rastro(SC6->C6_PRODUTO) .Or. Localiza(SC6->C6_PRODUTO)) .And.;
			SuperGetMv("MV_GERABLQ")=="N" .And. !lEstoque )
			MaGravaSc9(nQtdNosso,cBlCred,cBlEst,@aLocal,@aEmpenho,,bBlock,aEmpPronto,nQtdLib2,@nVlrCred,,lOkExpedicao)
			nQtdJaLib += nQtdNosso
		EndIf
		//?Verificacao do Parametro MV_GRVBLQ2
		If ( SuperGetMv("MV_GRVBLQ2" ) .And. aEmpenho == Nil )
			If ( nQtdLib <> SC6->C6_QTDLIB ) .OR. ( SC6->C6_QTDLIB <> 0 )
				nQtdLib := SC6->C6_QTDLIB
				If ( nQtdLib <> 0 )
					If !lCredito
						lAvEst := .F.
						lEstoque := .F.
					Else
						lAvEst := .T.
					EndIf
					nQtdJaLib += a440GeraC9(nQtdLib,lCredito,lEstoque,lAvCred,lAvEst,lLiber,lTransf,@aEmpenho,bBlock,aEmpPronto,lTrocaLot,lOkExpedicao,@nVlrCred)
				EndIf
			EndIf
		EndIf
	EndIf
EndIf
If ( lTravas )
	//? Atualiza a quantidade liberada para zero
	If ( aEmpenho == Nil )
		SC6->C6_QTDLIB  := 0
		SC6->C6_QTDLIB2 := 0
	EndIf
EndIf

If ( !lTravas )
	lCredito := .F.
	lEstoque := .F.
	nQtdLib  := 0
EndIf

RestArea(aAreaSA1)
RestArea(aAreaSB2)
RestArea(aAreaSF4)
RestArea(aArea)

Return(nQtdJaLib)
