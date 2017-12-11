#INCLUDE "PROTHEUS.CH"
#INCLUDE "topconn.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCVTEX05  บAutor  ณMicrosiga           บ Data ณ  08/10/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function Vtex05Ras(aDados)
Default aDados := {"01","03"}

RpcSetEnv(aDados[1],aDados[2])

U_V05Rastreio()

RpcClearEnv()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCVTEX05  บAutor  ณMicrosiga           บ Data ณ  05/12/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function V05JobErro(aDadosEmp)
Default aDadosEmp:={"01","03",.T.}

If aDadosEmp[3]
	RpcSetEnv(aDadosEmp[1],aDadosEmp[2])
EndIf

U_VTEX05PvErro()
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCVTEX05  บAutor  ณMicrosiga           บ Data ณ  05/08/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function VTEX05PvErro()
U_VTEX05Prod(.T.)// Reprocessar com Erro
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCVTEX05  บAutor  ณMicrosiga           บ Data ณ  04/29/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function VTEX05Menu()

Local cMsgYes := "Deseja execultar a rotina de Importa็ใo de Pedido B2C?"


If MsgYesno(cMsgYes)
	Processa( {|| U_NCVTEX05()}	 ,"Gravando Cabecalho")
	Processa( {|| U_VTEX05Cli()} ,"Gravando Cliente")
	Processa( {|| U_VTEX05Prod()},"Gravando Produto")
EndIf


Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCVTEX05  บAutor  ณMicrosiga           บ Data ณ  04/09/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function VTEX05Job(aDados)

Local cNomeArq := "VTEX05Job"
Local nHDL

Default aDados := {"01","03"}

RpcSetType(3)
RpcSetEnv(aDados[1],aDados[2])

If !Semaforo(.T.,@nHDL,cNomeArq)
	Return()
EndIf

U_NCVTEX05()
U_VTEX05Cli()
U_VTEX05Prod()

Semaforo(.F.,nHDL,cNomeArq)

RpcClearEnv()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCVTEX05  บAutor  ณMicrosiga           บ Data ณ  04/07/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function NCVTEX05(aStatus)

Local cCliNc		:= Alltrim(U_MyNewSX6("VT_NCG0005","000000","C","C๓d. de cliente NcGames utilizado no VTex","","",.F. ))
Local cLojaNc		:= Alltrim(U_MyNewSX6("VT_NCG0006","00","C","C๓d. de loja NcGames utilizado no VTex","","",.F. ))
Local oSite
Local aLojas		:= {{"Ncgames","00"},{"UzGames","03"}}
Local nInd
Local nYnd
Local cPedido
Local aDados
Local aGetDados
Local lCancelado
Local aCabec		:= {{"CREATIONDATE","D"},{"CLIENTNAME","C"},{"TOTALVALUE","N"},{"PAYMENTNAME","C"},{"MARKETPLACEORDERID","C"},{"SEQUENCE","C"},{"SALESCHANNEL","C"},{"ORIGIN","C"},{"WORKFLOWINERRORSTATE","L"},{"LISTID","C"}}

Local nAt
Local nI
Local aDadosAux	:= {}
Local nPerPage		:= 100
Local nPages		:= 1
Local aPages		:= {AllTrim(Str(nPages))}
Local cRespAux		:= ""
Local nPCancReq

Default aStatus 	:= {"ready-for-handling","payment-pending","payment-approved"}

aAdd(aStatus,"cancellation-requested")// Cancelamento solicitado
nPCancReq 	:= Ascan(aStatus,{|a| a=="cancellation-requested" })

aAdd(aStatus,"canceled")


ZC5->(DbSetOrder(5))//ZC5_FILIAL+ZC5_PLATAF+ZC5_PVVTEX

For nInd:=1 To Len(aLojas)
	oSite	:= Nil
	oSite	:= ApiVtex():New(aLojas[nInd,1])
	oSite:nPaginas := nPerPage
	
	For nYnd:=1 To Len(aStatus)
		
		lCancelado:=(nYnd==Len(aStatus))
		
		oSite:cStatus:=aStatus[nYnd]
		oSite:GetPedidoStatus()
		MyMensagem(ProcName(0) +" - Status: "+ aStatus[nYnd])
		
		
		If !ValType(oSite:cResponse)=="C"
			Loop
		EndIf
		
		If !((nAt:= AT('"name":"StatusDescription"',oSite:cResponse))==0)
			
			cRespAux 	:= SubStr(oSite:cResponse,nAt,150)
			aDadosAux 	:= U_VTEX05GetDet({{"QUANTITY","N"}},cRespAux)
			
			nPages := aDadosAux[1]/nPerPage
			aPages := {}
			
			For nI:=1 to Ceiling(nPages)
				aAdd(aPages,AllTrim(Str(nI)))
			Next
			
		EndIf
		
		For nI:=1 to Len(aPages)
			
			oSite:cStatus	:= aStatus[nYnd]
			oSite:nPage	:= AllTrim(aPages[nI])
			oSite:GetPedidoStatus()
			
			If !ValType(oSite:cResponse)=="C"
				Loop
			EndIf
			If At('orderId',oSite:cResponse)==0
				Loop
			EndIf
			
			aDados	:= Separa(oSite:cResponse,'orderId')
			
			For nXnd	:= 1 To Len(aDados)
				If !"CREATIONDATE"$Upper(aDados[nXnd])
					Loop
				EndIf
				cPedido	:= GetNumPV(aDados[nXnd])
				aGetDados	:= U_VTEX05GetDet(aCabec,aDados[nXnd])
				PtInternal(1,ProcName(0)+" Pedido Site:"+cPedido)
				
				If !ZC5->(MsSeek(xFilial("ZC5")+aLojas[nInd,2]+cPedido))
					If VTEX05Aut(aLojas[nInd,2],aGetDados[Ascan(aCabec,{|a|a[1]=="SALESCHANNEL" })] ,aGetDados[Ascan(aCabec,{|a|a[1]=="CREATIONDATE" })] )
						If !lCancelado
							Begin Transaction
							ZC5->(Reclock("ZC5",.T.))
							ZC5->ZC5_FILIAL	:= xFilial("ZC5")
							ZC5->ZC5_PVVTEX	:= cPedido
							ZC5->ZC5_PLATAF	:= aLojas[nInd,2]
							ZC5->ZC5_FLAG		:= "2"
							ZC5->ZC5_ORIGEM	:= aGetDados[Ascan(aCabec,{|a|a[1]=="ORIGIN" })]
							ZC5->ZC5_TOTAL	:= aGetDados[Ascan(aCabec,{|a|a[1]=="TOTALVALUE" })]/100
							//ZC5->ZC5_CODENT	:= "862"
							ZC5->ZC5_QTDPAR	:= 1
							ZC5->ZC5_STATUS 	:= IIf(nYnd==2,"4","10")
							ZC5->ZC5_SALES	:= aGetDados[Ascan(aCabec,{|a|a[1]=="SALESCHANNEL" })]
							ZC5->ZC5_DTVTEX	:= aGetDados[Ascan(aCabec,{|a|a[1]=="CREATIONDATE" })]
							ZC5->ZC5_SEQUEN	:= aGetDados[Ascan(aCabec,{|a|a[1]=="SEQUENCE" })]
							If ZC5->ZC5_STATUS == "10"
								ZC5->ZC5_PAGTO:= "2"
							EndIf
							
							SA1->(dbOrderNickName("SA1SALES"))
							If SA1->(MsSeek(xFilial("SA1")+cCliNc+ZC5->ZC5_PLATAF+Trim(ZC5->ZC5_SALES)))
								ZC5->ZC5_LJECOM:=SA1->A1_LOJA
								ZC5->ZC5_NOECOM:=SA1->A1_NOME
							EndIf
							ZC5->(MsUnlock())
							End Transaction
						EndIf
					EndIf
				Else
					Do Case
						Case lCancelado
							Begin Transaction
							ZC5->(Reclock("ZC5",.F.))
							ZC5->ZC5_STATUS 	:= "96"
							ZC5->ZC5_FLAG		:= ""
							ZC5->ZC5_PAGTO 	:= ""
							ZC5->(MsUnlock())
							End Transaction
						Case nYnd == nPCancReq //Cancelation Requested
							Begin Transaction
							U_PvCancel(ZC5->(Recno()),.T.)
							End Transaction
						Case nYnd<>2
							If AllTrim(ZC5->ZC5_STATUS)=="4"
								Begin Transaction
								ZC5->(Reclock("ZC5",.F.))
								ZC5->ZC5_STATUS 	:= "10"
								ZC5->ZC5_PAGTO	:= "2"
								ZC5->(MsUnlock())
								End Transaction
							EndIf
					EndCase
					
				EndIf
			Next
		Next
	Next
Next


Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCVTEX05  บAutor  ณMicrosiga           บ Data ณ  04/07/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function VTEX05Cli()
Local cErro
Local cCliNc	:= Alltrim(U_MyNewSX6("VT_NCG0005","000000","C","C๓d. de cliente NcGames utilizado no VTex","","",.F. ))
Local cLojaNc	:= Alltrim(U_MyNewSX6("VT_NCG0006","00","C","C๓d. de loja NcGames utilizado no VTex","","",.F. ))

Local aAreaAtu	:= GetArea()
Local cAliasQry	:= GetNextAlias()
Local cQuery	:= ""

Local oSite
Local aLojas	:={{"NcGames","00"},{"UzGames","03"}}
Local nInd

Local aCabec	:={}
Local aItens	:={}

Local cPlataforma
Local aZA1_SA1	:={}
Local aDadosEnt	:={}
Local nPosTransp:= 0
Local nPosEmail := 0
Local cErro

aADD(aCabec,{"ID"				,"C"})
aADD(aCabec,{"EMAIL"			,"C"})
aADD(aCabec,{"FIRSTNAME"		,"C"})
aADD(aCabec,{"LASTNAME"			,"C"})
aADD(aCabec,{"DOCUMENTTYPE"		,"C"})
aADD(aCabec,{"DOCUMENT"			,"C"})
aADD(aCabec,{"PHONE"			,"C"})
aADD(aCabec,{"CORPORATENAME"	,"C"})
aADD(aCabec,{"TRADENAME"		,"C"})
aADD(aCabec,{"CORPORATEDOCUMENT","C"})
aADD(aCabec,{"STATEINSCRIPTION"	,"C"})
aADD(aCabec,{"CORPORATEPHONE"	,"C"})
aADD(aCabec,{"ISCORPORATE"		,"L"})
aADD(aCabec,{"USERPROFILEID"	,"C"})
aADD(aCabec,{"ADDRESSTYPE"		,"C"})
aADD(aCabec,{"RECEIVERNAME"		,"C"})
aADD(aCabec,{"ADDRESSID"		,"C"})
aADD(aCabec,{"POSTALCODE"		,"C"})
aADD(aCabec,{"CITY"				,"C"})
aADD(aCabec,{"STATE"			,"C"})
aADD(aCabec,{"COUNTRY"			,"C"})
aADD(aCabec,{"STREET"			,"C"})
aADD(aCabec,{"NUMBER"			,"C"})
aADD(aCabec,{"NEIGHBORHOOD"		,"C"})
aADD(aCabec,{"COMPLEMENT"		,"C"})
aADD(aCabec,{"REFERENCE"		,"C"})
aADD(aCabec,{"COURIERID"		,"C"})

nPosEmail 	:= Ascan(aCabec,{|a| a[1]=="EMAIL"  })
nPosTransp 	:= Ascan(aCabec,{|a| a[1]=="COURIERID"  })

cQuery:=" Select ZC5.R_E_C_N_O_ RecSZC5,ZC5_PLATAF,ZC5_PVVTEX" "
cQuery+=" From "+RetSqlName("ZC5")+" ZC5"
cQuery+=" Where ZC5.ZC5_FILIAL='"+xFilial("ZC5")+"'"
cQuery+=" And ZC5.ZC5_PLATAF IN('"+cLojaNc+"','03')"
cQuery+=" And ZC5.ZC5_FLAG='2'"
cQuery+=" And ZC5.ZC5_ESTORN=' '"
cQuery+=" And D_E_L_E_T_=' '"
cQuery+=" Order By ZC5_PLATAF,ZC5_PVVTEX"


dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), cAliasQry, .T., .F.)

Do While (cAliasQry)->(!Eof())
	
	oSite	:= Nil
	cPlataforma	:= (cAliasQry)->ZC5_PLATAF
	
	If cPlataforma == cLojaNc
		oSite:=ApiVtex():New("NcGames")
	ElseIf cPlataforma=="03"
		oSite:=ApiVtex():New("UzGames")
	EndIf
	
	oSite:lSemAcento:=.T.
	
	Do While (cAliasQry)->(!Eof()) .And. (cAliasQry)->ZC5_PLATAF==cPlataforma
		
		ZC5->(DbGoTo((cAliasQry)->RecSZC5))
		
		PtInternal(1,ProcName(0)+" Pedido Site:"+ZC5->ZC5_PVVTEX)
		
		oSite:cPedido:=AllTrim(ZC5->ZC5_PVVTEX)
		oSite:GetDetalhePedido()
		
		aDados		:= U_VTEX05GetDet(aCabec,oSite:cResponse)
		aDadosEnt	:= {}
		cErro		:=""
		
		If VTEX05GrvCli(aCabec,aDados,cPlataforma,Trim(ZC5->ZC5_SALES),ZC5->ZC5_PVVTEX,aZA1_SA1,aDadosEnt,@cErro)
			
			Begin Transaction
			ZC5->(RecLock("ZC5",.F.))
			
			ZC5->ZC5_FLAG	:= '3'
			ZC5->ZC5_CLIENT	:= SA1->A1_COD
			ZC5->ZC5_LOJA	:= SA1->A1_LOJA
			ZC5->ZC5_CONDPG	:= aDadosEnt[09]
			ZC5->ZC5_ENDENT	:= aDadosEnt[01]
			ZC5->ZC5_BAIROE	:= aDadosEnt[02]
			ZC5->ZC5_CEPE	:= aDadosEnt[03]
			ZC5->ZC5_MUNE	:= aDadosEnt[04]
			ZC5->ZC5_ESTE  	:= aDadosEnt[05]
			ZC5->ZC5_COMPLE	:= aDadosEnt[06]
			ZC5->ZC5_CODMUE	:= aDadosEnt[07]
			ZC5->ZC5_EMAIL	:= aDados[nPosEmail]
			ZC5->ZC5_CODENT	:= U_V05CodEnt(ZC5->(Recno()),aDados[nPosTransp],aDadosEnt[03])
			ZC5->ZC5_CGC	:= SA1->A1_CGC
			//JR
			ZC5->ZC5_TPECOM	:= "B2C"//DEFINE COMO PEDIDO E-COMMERCE SEMPRE EM CASOS DE PEDIDOS VINDOS DO VTEX			
			ZC5->(MsUnlock())
			
			End Transaction
		Else
			
			Begin Transaction
			ZC5->(RecLock("ZC5",.F.))
			
			ZC5->ZC5_FLAG := '4'
			U_EcomHtmE(AllTrim(ZC5->ZC5_PVVTEX))
			
			ZC5->(MsUnlock())
			End Transaction
			
			
		EndIf
		(cAliasQry)->(DbSkip())
	EndDo
	
EndDo
(cAliasQry)->(DbCloseArea())
RestArea(aAreaAtu)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCVTEX05  บAutor  ณMicrosiga           บ Data ณ  04/09/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function VTEX05Prod(lComErro,cPvVtex)

Local cCliNc	:= Alltrim(U_MyNewSX6("VT_NCG0005","000000","C","C๓d. de cliente NcGames utilizado no VTex","","",.F. ))
Local cLojaNc	:= Alltrim(U_MyNewSX6("VT_NCG0006","00","C","C๓d. de loja NcGames utilizado no VTex","","",.F. ))
Local aAreaAtu	:= GetArea()
Local cAliasQry	:= GetNextAlias()
Local cQuery
Local oSite
Local aLojas	:= {{"NcGames",cLojaNc},{"UzGames","03"}}
Local nInd

Local aCabecProd:= {}
Local aItens	:= {}
Local cPlataforma
Local cTagPagto	:= '"payments"'
Local cTagParc	:= '"installments"'
Local cTagDes	:= '"id":"Discounts"' 	//'"Discounts Total"'
Local cTagFrete	:= '"id":"Shipping"'	//'"Shipping Total"'
Local cTagItem	:= '"items":['
Local cTagMarket:= '"marketplaceItems":['

Local aCabec	:= {}
Local nItem
Local cLocalERP	:= Alltrim(U_MyNewSX6("VT_000005","51" ,"C","Armaz้m de Venda Protheus","","",.F. ))
Local nAscan
Local aItens
Local aItemZC6
Local nAt
Local lNotFound
Local cDescricao
Local cErro
Local dDataCorte:= Ctod("30/04/2015")

Default lComErro:= .F.
Default cPvVtex	:= ""

aCabec	:= { {"UNIQUEID","C"},;
{"ID","C"},;
{"PRODUCTID","C"},;
{"EAN","C"},;
{"LOCKID","C"},;
{"QUANTITY","N"},;
{"SELLER","C"},;
{"NAME","C"},;
{"PRICE","N"},;
{"SELLINGPRICE","N"},;
{"SHIPPINGPRICE","N"} }


cQuery:=" Select ZC5.R_E_C_N_O_ RecSZC5,ZC5_PLATAF,ZC5_PVVTEX" "
cQuery+=" From "+RetSqlName("ZC5")+" ZC5"
cQuery+=" Where ZC5.ZC5_FILIAL='"+xFilial("ZC5")+"'"
cQuery+=" And ZC5.ZC5_PLATAF IN('"+cLojaNc+"','03')"

If lComErro
	cQuery+=" And ZC5.ZC5_FLAG = '5'"
Else
	cQuery+=" And ZC5.ZC5_FLAG = '3'"
EndIf

cQuery+=" And ZC5.ZC5_ESTORN = ' '"

If !Empty(cPvVtex)
	cQuery+=" And ZC5_PVVTEX = '"+cPvVtex+"'"
EndIf

cQuery+=" And D_E_L_E_T_ = ' '"
cQuery+=" Order By ZC5_PLATAF,ZC5_PVVTEX""
dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), cAliasQry, .T., .F.)

SA7->(DbSetOrder(3))//A7_FILIAL+A7_CLIENTE+A7_LOJA+A7_CODCLI
SB1->(DbSetOrder(5))//B1_FILIAL+B1_CODBAR

Do While (cAliasQry)->(!Eof())
	
	oSite		:= Nil
	cPlataforma	:= (cAliasQry)->ZC5_PLATAF
	
	If cPlataforma == cLojaNc
		oSite:=ApiVtex():New("NcGames")
	ElseIf cPlataforma=="03"
		oSite:=ApiVtex():New("UzGames")
	EndIf
	
	oSite:lSemAcento := .T.
	
	Do While (cAliasQry)->(!Eof()) .And. (cAliasQry)->ZC5_PLATAF==cPlataforma
		
		ZC5->(DbGoTo((cAliasQry)->RecSZC5))
		
		aItemZC6	:= {}
		lNotFound	:= .F.
		
		oSite:cPedido := AllTrim(ZC5->ZC5_PVVTEX)
		oSite:GetDetalhePedido()
		
		nPosIni		:= At(cTagItem, oSite:cResponse)
		nPosFim		:= At(cTagMarket, oSite:cResponse)-nPosIni
		cJson		:= SubStr( oSite:cResponse,nPosIni,nPosFim)
		
		Do While .T.
			
			aItens := {}
			aItens := U_VTEX05GetDet(aCabec,@cJson)
			
			If Empty(cJson)
				Exit
			EndIf
			
			If Len(aItens)==0
				Loop
			EndIf
			
			aItens[Ascan(aCabec,{|a|a[1]=="PRICE" })]:=aItens[Ascan(aCabec,{|a|a[1]=="PRICE" })]/100
			aItens[Ascan(aCabec,{|a|a[1]=="SELLINGPRICE" })]:=aItens[Ascan(aCabec,{|a|a[1]=="SELLINGPRICE" })]/100
			
			If Alltrim(ZC5->ZC5_ORIGEM) == "Fulfillment" .And. !(aItens[Ascan(aCabec,{|a|a[1]=="SELLINGPRICE" })]==0)
				If (nAscan:=Ascan(aItemZC6,{|a| a[3]==aItens[Ascan(aCabec,{|a|a[1]=="ID" })] .And.  a[2]==aItens[Ascan(aCabec,{|a|a[1]=="SELLINGPRICE" })]  } ))==0
					AADD(aItemZC6,{aItens[Ascan(aCabec,{|a|a[1]=="EAN" })],aItens[Ascan(aCabec,{|a|a[1]=="SELLINGPRICE" })],aItens[Ascan(aCabec,{|a|a[1]=="ID" })],aItens[Ascan(aCabec,{|a|a[1]=="QUANTITY" })],AllTrim(aItens[Ascan(aCabec,{|a|a[1]=="NAME" })])})
				Else
					aItemZC6[nAscan,4]+=aItens[Ascan(aCabec,{|a|a[1]=="QUANTITY" })]
				EndIf
			Else
				If (nAscan:=Ascan(aItemZC6,{|a| a[3]==aItens[Ascan(aCabec,{|a|a[1]=="ID" })] .And.  a[2]==aItens[Ascan(aCabec,{|a|a[1]=="PRICE" })]  } ))==0
					AADD(aItemZC6,{aItens[Ascan(aCabec,{|a|a[1]=="EAN" })],aItens[Ascan(aCabec,{|a|a[1]=="PRICE" })],aItens[Ascan(aCabec,{|a|a[1]=="ID" })],aItens[Ascan(aCabec,{|a|a[1]=="QUANTITY" })],AllTrim(aItens[Ascan(aCabec,{|a|a[1]=="NAME" })])})
				Else
					aItemZC6[nAscan,4]+=aItens[Ascan(aCabec,{|a|a[1]=="QUANTITY" })]
				EndIf
			EndIf
		EndDo
		
		ZC6->(DbSetOrder(3))
		
		//Begin Transaction
		
		For nItem:=1 To Len(aItemZC6)
			lAppend:=!ZC6->(MsSeek(xFilial()+ZC5->ZC5_PVVTEX+AllTrim(aItemZC6[nItem,3]) )  )
			
			PtInternal(1,ProcName(0)+" Pedido Site:"+ZC5->ZC5_PVVTEX+"Id "+aItemZC6[nItem,3])
			
			ZC6->(RecLock("ZC6",lAppend))
			
			ZC6->ZC6_FILIAL	:= xFilial("ZC6")
			ZC6->ZC6_PVVTEX	:= ZC5->ZC5_PVVTEX
			ZC6->ZC6_ITEM  	:= StrZero(nItem,2)
			ZC6->ZC6_EAN	:= aItemZC6[nItem,1]
			ZC6->ZC6_VLRUNI	:= aItemZC6[nItem,2]
			ZC6->ZC6_IDPROD	:= aItemZC6[nItem,3]
			ZC6->ZC6_QTDVEN	:= aItemZC6[nItem,4]
			ZC6->ZC6_VLRTOT	:= ZC6->(ZC6_QTDVEN*ZC6_VLRUNI)
			ZC6->ZC6_LOCAL	:= cLocalERP
			ZC6->ZC6_DESCRI	:= Upper(aItemZC6[nItem,5])
			
			If SA7->(MsSeek(xFilial("SA7")+cCliNc+ZC5->ZC5_PLATAF+AllTrim(ZC6->ZC6_IDPROD)))
				ZC6->ZC6_PRODUTO:=SA7->A7_PRODUTO
			EndIf
			
			If Empty(ZC6->ZC6_PRODUTO)
				lNotFound:=.T.
				U_NCECOM09(0,"PRODUTO","IMPORTA_PRODUTO "+ZC6->ZC6_IDPROD,"Produto ID "+AllTrim(ZC6->ZC6_IDPROD)+" ("+AllTrim(ZC6->ZC6_DESCRI)+") nao encontrado no ERP","",.T.,,"Produto",ZC5->ZC5_PVVTEX)
			EndIf
			ZC6->(MsUnlock())
		Next
		
		ZC5Local(Alltrim(ZC5->ZC5_PVVTEX))
		//End Transaction
		
		ZC5->(RecLock("ZC5",.F.))
		ZC5->ZC5_FLAG:=IIf(lNotFound,"5", IIf(ZC5->ZC5_DTVTEX<=dDataCorte,"X","") )
		
		If (nAt:=At( cTagDes, oSite:cResponse))>0
			cJson:= SubStr( oSite:cResponse,nAt )
			ZC5->ZC5_VDESCO:= U_VTEX05GetDet({{"VALUE","N"}},cJson)[1]/100
		EndIF
		
		If (nAt:=At( cTagFrete, oSite:cResponse) )>0
			cJson:= SubStr( oSite:cResponse,nAt )
			ZC5->ZC5_FRETE:= U_VTEX05GetDet({{"VALUE","N"}},cJson)[1]/100
		EndIF
		
		If (nAt:=At( cTagPagto, oSite:cResponse))>0
			cJson:= SubStr( oSite:cResponse,nAt )
			ZC5->ZC5_TPPGTO:= U_VTEX05GetDet({{"PAYMENTSYSTEM","C"}},cJson)[1]
			If !(U_VTEX05GetDet({{"PAYMENTSYSTEM","C"}},cJson)[1] == "0")
				ZC5->ZC5_QTDPAR:= U_VTEX05GetDet({{"INSTALLMENTS","N"}},cJson)[1]
			EndIF
		EndIF
		
		If lNotFound
			U_EcoHtmE(AllTrim(ZC5->ZC5_PVVTEX))
		EndIf
		
		ZC5->(MsUnLock())
		
		(cAliasQry)->(DbSkip())
	EndDo
	
EndDo

(cAliasQry)->(DbCloseArea())
RestArea(aAreaAtu)

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCVTEX05  บAutor  ณMicrosiga           บ Data ณ  04/07/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function GetNumPV(cLinha)
Local cLinha	:= Substr(cLinha,4)
Local cPedido	:= ""
Local nInd

For nInd:=1 To Len(cLinha)
	If SubStr(cLinha,nInd,1)=='"'
		Exit
	EndIf
	cPedido+=SubStr(cLinha,nInd,1)
Next

Return cPedido
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCVTEX05  บAutor  ณMicrosiga           บ Data ณ  04/09/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function VTEX05GetDet(aCabec,cJson)

Local nInd
Local nYnd
Local nPosicao
Local aRetorno	:= {}
Local uRetorno
Local cString
Local lFound	:= .F.

For nInd:=1 To Len(aCabec)
	
	uRetorno:=""
	cToken:=','
	
	If aCabec[nInd,2]$"C*D"
		cToken:='"'
	EndIf
	If (nPosicao:=At(aCabec[nInd,1],Upper(cJson)))>0
		lFound:=.T.
		cJson:=Substr(cJson,nPosicao+Len(aCabec[nInd,1])+2)
		If SubStr(cJson,1,4)<>'null'
			If aCabec[nInd,2]$"C*D"
				cJson:=SubStr(cJson,2)
			EndIf
			For nYnd:=1 To Len(cJson)
				If SubStr(cJson,nYnd,1)==cToken
					Exit
				EndIf
				uRetorno+=SubStr(cJson,nYnd,1)
			Next
		EndIf
	EndIf
	
	If aCabec[nInd,2]=="N"
		
		If IsIncallStack("U_NCVTEX06")
			uRetorno:=Val(uRetorno)
		Else
			uRetorno:=Val(StrTran(uRetorno,'.',','))
		EndIf
		
	EndIf
	If aCabec[nInd,2]=="D"
		uRetorno:=Stod(Left(StrTran(uRetorno,'-',''),8))
	EndIf
	If aCabec[nInd,2]=="L"
		uRetorno:=(uRetorno=="true")
	EndIf
	AADD(aRetorno,uRetorno)
	
Next

If !lFound
	cJson:=""
EndIf


Return aRetorno

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCVTEX05  บAutor  ณMicrosiga           บ Data ณ  04/09/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function VTEX05GrvCli(aCabec,aDados,cLojaNc,cSalesChanel,cPvVtex,aZA1_SA1,aDadosEnt,_cError)

Local aAreaAtu		:= GetArea()
Local cCodCli
Local cEmail			:= aDados[Ascan(aCabec,{|a|a[1]=="EMAIL" })]
Local cCPF_CNPJ		:= aDados[Ascan(aCabec,{|a|a[1]=="DOCUMENT" })]
Local cCep				:= aDados[Ascan(aCabec,{|a|a[1]=="POSTALCODE" })]
Local cNumber			:= aDados[Ascan(aCabec,{|a|a[1]=="NUMBER" })]
Local cTelefone		:= aDados[Ascan(aCabec,{|a|a[1]=="PHONE" })]
Local cTipoDoc		:= aDados[Ascan(aCabec,{|a|a[1]=="DOCUMENTTYPE" })]
Local lIsPJ			:= aDados[Ascan(aCabec,{|a|a[1]=="ISCORPORATE" })]
Local cEstado			:= Upper(aDados[Ascan(aCabec,{|a|a[1]=="STATE" })])
Local cNome			:= VTE05NoAcen(Upper(aDados[Ascan(aCabec,{|a|a[1]=="FIRSTNAME" })]+Space(1)+aDados[Ascan(aCabec,{|a|a[1]=="LASTNAME" })]))
Local cBairro			:= VTE05NoAcen(Upper(aDados[Ascan(aCabec,{|a|a[1]=="NEIGHBORHOOD" })]))
Local cEndereco		:= VTE05NoAcen(Upper(aDados[Ascan(aCabec,{|a|a[1]=="STREET" })]))
Local cComplemento	:= VTE05NoAcen(Upper(aDados[Ascan(aCabec,{|a|a[1]=="COMPLEMENT" })]))
Local cReferencia		:= VTE05NoAcen(Upper(aDados[Ascan(aCabec,{|a|a[1]=="REFERENCE" })]))
Local cMun        	:= VTE05NoAcen(Padr( Upper(aDados[Ascan(aCabec,{|a|a[1]=="CITY" })]), AvSx3("CC2_MUN",3) ))
Local cIE				:= Upper(aDados[Ascan(aCabec,{|a|a[1]=="STATEINSCRIPTION" })])

Local cPessoa			:= "F"
Local cCliNc			:= Alltrim(U_MyNewSX6("VT_NCG0005","000000","C","C๓d. de cliente NcGames utilizado no VTex","","",.F. ))
Local cGrpVen			:= "999999"
Local cCodMun			:= ""

Local cTipo			:= "F"
Local GrpCli			:= "CFIE"
Local cContrib		:= "2"
Local cBloqueado		:= "2"
Local cTab				:= "018"
Local cEstCiv			:= " "
Local cSexo			:= " "
Local cCodpais		:= "01058" //Brasil
Local dDtNasc			:= Ctod("//")
Local aVetor			:= {}
Local lJaExiste
Local cErroAdiconal	:= ""
Local cVendedor		:= "VN9902"
Local cCondPag		:= ""
Local cCanal			:= "990001"
Local cEmailOri 		:= ""
Local cLjCli			:= ""

Default _cError		:= ""


If lIsPJ
	cCPF_CNPJ	:= aDados[Ascan(aCabec,{|a|a[1]=="CORPORATEDOCUMENT" })]
	cTelefone	:= aDados[Ascan(aCabec,{|a|a[1]=="CORPORATEPHONE" })]
	cNome		:= FwNoAccent(Upper(aDados[Ascan(aCabec,{|a|a[1]=="CORPORATENAME" })]+Space(1)+aDados[Ascan(aCabec,{|a|a[1]=="TRADENAME" })]))
	cPessoa	:=	"J"
	cVendedor	:= "VN9902"
	cCondPag	:= ""
	cCanal		:= "990001"
Endif

If "00000" $ cTelefone .Or. Empty(cTelefone)
	cTelefone := "+5511409530001"
EndIf

cTelefone	:= AllTrim(Str(Val(StrTran(cTelefone,"+55",""))))

SA1->(dbOrderNickName("SA1SALES"))
If SA1->(MsSeek(xFilial("SA1")+cCliNc+cLojaNc+cSalesChanel))
	cVendedor	:= SA1->A1_VEND
	cCondPag	:= SA1->A1_COND
	cCanal		:= SA1->A1_YCANAL
EndIf


SA1->(DbSetOrder(1))
ZA1->(DbSetOrder(1))
If ZA1->(MsSeek(xFilial("ZA1")+cPvVtex)) .And. !Empty(ZA1->ZA1_CODSA1) .And. SA1->(MsSeek(xFilial("SA1")+ZA1->ZA1_CODSA1))
	
	AADD(aDadosEnt,SA1->A1_ENDENT)	//01
	AADD(aDadosEnt,SA1->A1_BAIRROE)	//02
	AADD(aDadosEnt,SA1->A1_CEPE)	//03
	AADD(aDadosEnt,SA1->A1_MUNE)	//04
	AADD(aDadosEnt,SA1->A1_ESTE)	//05
	AADD(aDadosEnt,SA1->A1_COMPLEM)	//06
	AADD(aDadosEnt,SA1->A1_COD_MUN)	//07
	
	AADD(aDadosEnt,cVendedor)		//08
	AADD(aDadosEnt,cCondPag)			//09
	AADD(aDadosEnt,cCanal)			//10
	
	Return .T.
EndIf


CC2->(DBSETORDER(2)) //CC2_FILIAL+CC2_MUN
If CC2->(DbSeek(xFilial("CC2")+cMun))
	Do While CC2->(!Eof()) .And.  CC2->CC2_MUN==cMun
		If CC2->CC2_EST == cEstado
			cCodMun	:= CC2->CC2_CODMUN
		EndIf
		CC2->(DbSkip())
	EndDo
Else
	cErroAdiconal := "Codigo Municipio nใo encontrado para o Municipio "+cMun
EndIf

//Corrige a ordem para as valida็๕es do campo
CC2->(DbSetOrder(1))
SA1->(DbSetOrder(3))

cCep	:= StrTran(StrTran(cCep,"-",""),Space(1),"")
If cEstado == "SP"
	cCep	:=	StrZero(Val(AllTrim(cCep)),8)
EndIf

If (lJaExiste := SA1->(MsSeek(xFilial("SA1")+cCPF_CNPJ)))
	
	Do While SA1->(!EoF()) .And. SA1->(A1_FILIAL + AllTrim(A1_CGC)) == xFilial("SA1")+cCPF_CNPJ
		If SA1->(AllTrim(A1_EST)+ AllTrim(A1_CEP)) == AllTrim(cEstado)+AllTrim(cCep)
			
			cEndAux := AllTrim(StrTran(StrTran(SA1->A1_End," ",""),",",""))
			//aEndAux := Separa(SA1->A1_End,",")
			//If Alltrim(aEndAux[1])+Alltrim(aEndAux[2]) ==AllTrim(StrTran(cEndereco," ",""))+ AllTrim(cNumber)
			If Alltrim(cEndAux) == AllTrim(StrTran(cEndereco," ",""))+ AllTrim(cNumber)
				cCodCli	:= SA1->A1_COD
				cLjCli		:= SA1->A1_LOJA
				cEmailOri	:= SA1->A1_EMAIL
				
				Exit
			Else
				cCodCli	:= SA1->A1_COD
				cEmailOri	:= SA1->A1_EMAIL
			EndIf
			
		Else
			cCodCli	:= SA1->A1_COD
			cEmailOri	:= SA1->A1_EMAIL
			
		EndIf
		
		SA1->(DbSkip())
	EndDo
	
	If lJaExiste .And. Empty(cLjCli)
		cLjCli 	:= GetLoja(cCodCli)
		lJaExiste	:= .F.
	EndIf
Else
	cCodCli := GETSXENUM("SA1","A1_COD")
	SA1->(DbSetOrder(1))
	Do While SA1->(DbSeek(xFilial("SA1") +cCodCli+"01" ))
		ConfirmSX8()
		cCodCli := GETSXENUM("SA1","A1_COD")
	EndDo
EndIf

cTabPrc	:= "CON"
cIE			:= IIf(Empty(cIE),"ISENTO",cIE)

M->A1_COMPLEM := ""

If !Empty(cComplemento)
	M->A1_COMPLEM := cComplemento
EndIf

If !Empty(cReferencia)
	M->A1_COMPLEM += Space(1)+cReferencia
EndIf

AADD(aDadosEnt,cEndereco+", "+cNumber)	//01
AADD(aDadosEnt,cBairro)					//02
AADD(aDadosEnt,cCep)						//03
AADD(aDadosEnt,cMun)						//04
AADD(aDadosEnt,cEstado)					//05
AADD(aDadosEnt,M->A1_COMPLEM)			//06
AADD(aDadosEnt,cCodMun)					//07
AADD(aDadosEnt,cVendedor)				//08
AADD(aDadosEnt,cCondPag)					//09
AADD(aDadosEnt,cCanal)					//10


AADD(aVetor,{"A1_FILIAL" 	,xFilial("SA1") ,Nil})
AADD(aVetor,{"A1_COD" 		,cCodCli,Nil})
AADD(aVetor,{"A1_LOJA" 		,IIf(Empty(cLjCli),"01",cLjCli) ,Nil})
AADD(aVetor,{"A1_PESSOA" 	,cPessoa ,Nil})
AADD(aVetor,{"A1_NOME" 		,cNome ,Nil})
AADD(aVetor,{"A1_NREDUZ" 	,cNome ,Nil})
AADD(aVetor,{"A1_END" 		,cEndereco+", "+cNumber   ,Nil})
AADD(aVetor,{"A1_TIPO" 		,cTipo ,Nil})
AADD(aVetor,{"A1_EST" 		,cEstado ,Nil})
AADD(aVetor,{"A1_NATUREZ" 	,"19101" ,Nil})
AADD(aVetor,{"A1_COD_MUN" 	,cCodMun ,Nil})
AADD(aVetor,{"A1_MUN" 		,cMun ,Nil})
AADD(aVetor,{"A1_BAIRRO" 	,cBairro ,Nil})
AADD(aVetor,{"A1_CEP" 		,cCep,Nil})
AADD(aVetor,{"A1_DDD" 		,Left(cTelefone,2) ,Nil})
AADD(aVetor,{"A1_TEL" 		,SubStr(cTelefone,3) ,Nil})
AADD(aVetor,{"A1_ESTC" 		,cEstado ,Nil})
AADD(aVetor,{"A1_ENDCOB" 	,cEndereco+", "+cNumber ,Nil})
AADD(aVetor,{"A1_BAIRROC"	,cBairro ,Nil})
AADD(aVetor,{"A1_CEPC" 		,cCep ,Nil})
AADD(aVetor,{"A1_MUNC" 		,cMun ,Nil})

AADD(aVetor,{"A1_ESTE" 		,cEstado ,Nil})
AADD(aVetor,{"A1_ENDENT" 	,cEndereco+", "+cNumber ,Nil})
AADD(aVetor,{"A1_BAIRROE"	,cBairro ,Nil})
AADD(aVetor,{"A1_CEPE" 		,cCep ,Nil})
AADD(aVetor,{"A1_MUNE" 		,cMun ,Nil})

AADD(aVetor,{"A1_X_LOCZ" 	,"C" ,Nil})
AADD(aVetor,{"A1_CGC" 		,cCPF_CNPJ ,Nil})
AADD(aVetor,{"A1_INSCR" 		,cIE ,Nil})
AADD(aVetor,{"A1_VEND" 		,cVendedor ,Nil})
AADD(aVetor,{"A1_CONTA" 		,"11201010001" ,Nil})
AADD(aVetor,{"A1_TRANSP" 	,"000002" ,Nil})
AADD(aVetor,{"A1_TPFRET" 	,"C" ,Nil})
AADD(aVetor,{"A1_GRPTRIB"	,GrpCli ,Nil})
AADD(aVetor,{"A1_SATIV1" 	,"000037" ,Nil})
AADD(aVetor,{"A1_GRPVEN" 	,"990000" ,Nil})
AADD(aVetor,{"A1_CODPAIS"	,cCodpais ,Nil})
AADD(aVetor,{"A1_FRETE" 		,"1" ,Nil})
AADD(aVetor,{"A1_TEMODAL" 	,"2" ,Nil})
AADD(aVetor,{"A1_YCANAL" 	,cCanal ,Nil})
AADD(aVetor,{"A1_XGRPCOM" 	,"ECOMME" ,Nil})
AADD(aVetor,{"A1_CONTRIB" 	,cContrib ,Nil})
AADD(aVetor,{"A1_TABELA" 	,cTabPrc ,Nil})
AADD(aVetor,{"A1_COND" 		,cCondPag ,Nil})
AADD(aVetor,{"A1_XSORTER"	,"1" ,Nil})
AADD(aVetor,{"A1_DTNASC" 	,MsDate() ,Nil})
AADD(aVetor,{"A1_AGEND" 		,"2" ,Nil})
AADD(aVetor,{"A1_OPER" 		,"" ,Nil})

If Empty(cEmailOri) //adicionado para atender a necessidade de email do cliente.
	AADD(aVetor,{"A1_EMAIL" ,cEmail		,Nil})
EndIf

AADD(aVetor,{"A1_XEMAIL2" 	,cEmail 	,Nil})
AADD(aVetor,{"A1_COMPLEM" 	,Upper(M->A1_COMPLEM),Nil})
AADD(aVetor,{"A1_REGIAO" 	,U_AchaReg(cEstado) ,Nil})

If lIsPJ
	AADD(aVetor,{"A1_MSBLQL" ,"1" ,Nil})
Else
	AADD(aVetor,{"A1_MSBLQL" ,cBloqueado ,Nil})
EndIf

If lJaExiste .And. !lIsPJ
	Return .T.
EndIf

BEGIN TRANSACTION

lMsErroAuto := .F.
CC2->(DBSETORDER(1))
MSExecAuto({|x,y| MATA030(x,y)},aVetor, Iif(lJaExiste,4,3))
_cError := ""
If lMsErroAuto
	_cError := MemoRead(NomeAutoLog())+CRLF+cErroAdiconal+CRLF
	MostraErro('cPath',NomeAutoLog())//Apagar o arquivo atual
	ExecValid(aVetor,@_cError)
	U_NCECOM09(0,"CLIENT","IMPORTA_CLIENTE","Erro de Gravacao: "+_cError,"",.T.,,"Cliente",cPvVtex)
	GravaZA1(cPvVtex,_cError,aVetor,aZA1_SA1)
	RollBackSXe()
Else
	If !lJaExiste
		//U_EcomHtm7("INCLUSAO")
	EndIf
Endif

If lIsPJ .And. !lMsErroAuto
	U_NCECOM09(0,"CLIENT","Bloqueio cliente CNPJ","Cliente "+ cCodCli +"/"+ IIf(Empty(cLjCli),"01",cLjCli) +" Cnpj necessita desbloqueio do mesmo.","",.T.,,"Cliente",cPvVtex)
EndIf

END TRANSACTION

RestArea(aAreaAtu)
Return (!lMsErroAuto)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCVTEX05  บAutor  ณMicrosiga           บ Data ณ  04/09/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ExecValid(aVetor,_cError)
Local nInd

RegToMemory("SA1",.F.,.F.)
For nInd:=1 To Len(aVetor)
	
	Eval ( MemVarBlock(aVetor[nInd][1]),aVetor[nInd][2])
	__READVAR		:= "M->"+aVetor[nInd][1]
	cReadVar		:= &(__READVAR)
	&(__READVAR)	:= aVetor[nInd][2]
	
	bValid := AvSx3(aVetor[nInd][1],7)
	If !Eval( bValid )
		xConteudo := aVetor[nInd][2]
		If ValType(xConteudo)=="N"
			xConteudo := AllTrim(Str(xConteudo))
		ElseIf ValType(xConteudo)=="D"
			xConteudo := DTOC(xConteudo)
		EndIf
		_cError += "Erro campo "+ aVetor[nInd][1] +" conteudo "+ xConteudo+CRLF
	EndIf
	
Next

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCVTEX05  บAutor  ณMicrosiga           บ Data ณ  04/24/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function VTEX05Aut(cLoja,cSales,dDtVtex)

Local aAreaAtu	:= GetArea()
Local aAreaZX5	:= ZX5->(GetArea())
Local aAreaSA1	:= SA1->(GetArea())
Local cCliNc		:= Alltrim(U_MyNewSX6("VT_NCG0005","000000","C","C๓d. de cliente NcGames utilizado no VTex","","",.F. ))
Local cTabela		:= "00003"
Local lPodeGravar	:= .F.
Local dDtCorte	:= U_MyNewSX6("VT_900001","23/05/2015","D","Data de Corte","","",.F. )

If dDtVtex>dDtCorte
	ZX5->(DbSetOrder(1))//ZX5_FILIAL+ZX5_TABELA+ZX5_CHAVE
	SA1->(dbOrderNickName("SA1SALES"))//A1_FILIAL+A1_COD+A1_LJECOME+A1_YSALES
	lPodeGravar := (SA1->(MsSeek(xFilial("SA1")+cCliNc+cLoja+Trim(cSales))) .And. ZX5->(MsSeek(xFilial("ZX5")+cTabela+SA1->A1_LOJA)))
EndIf

RestArea(aAreaSA1)
RestArea(aAreaZX5)
RestArea(aAreaAtu)

Return lPodeGravar

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCVTEX05  บAutor  ณMicrosiga           บ Data ณ  04/26/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GravaZA1(cPvVtex,cErro,aVetor,aZA1_SA1)

Local aAreaAtu := GetArea()
Local aAreaZA1 := ZA1->(GetArea())
Local nInd
Local nAscan
Local bGrava
Local aAux

If Empty(aZA1_SA1)
	ZX5->(DbSetOrder(1))//ZX5_FILIAL+ZX5_TABELA+ZX5_CHAVE
	ZX5->(MsSeek(xFilial()+"00004") )
	Do While ZX5->(!Eof()) .And. ZX5->ZX5_TABELA=="00004"
		AADD(aZA1_SA1,Separa(ZX5->ZX5_DESCRI,"#"))
		ZX5->(DbSkip())
	EndDo
EndIf
For nInd:=1 To Len(aZA1_SA1)
	aAux := aZA1_SA1[nInd]
	For nYnd:=1 To Len(aAux)
		aAux[nYnd]:=AllTrim(aAux[nYnd])
	Next
Next

ZA1->(DbSetOrder(1))

Begin Transaction
ZA1->(RecLock("ZA1", !ZA1->(MsSeek(xFilial("ZA1")+cPvVtex )) ) )
For nInd:=1 To Len(aVetor)
	If (nAscan:=Ascan(aZA1_SA1,{|a| a[2]==aVetor[nInd][1] }))>0
		ZA1->(FieldPut(FieldPos(aZA1_SA1[nAscan,1]) ,aVetor[nInd][2] )  )
	EndIf
Next

ZA1->ZA1_FILIAL	:= xFilial("ZA1")
ZA1->ZA1_PVVTEX	:= cPvVtex
ZA1->ZA1_ERRO		:= cErro
ZA1->(MsUnLock())
End Transaction

RestArea(aAreaZA1)
RestArea(aAreaAtu)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCVTEX05  บAutor  ณMicrosiga           บ Data ณ  04/28/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function VTE05NoAcen(cString)
Local cRetorno := FwNoAccent(cString)
Local aAlterar := {{"'"," "}}

For nInd := 1 To Len(aAlterar)
	cRetorno := StrTran(cRetorno,aAlterar[nInd,1],aAlterar[nInd,2])
Next

Return cRetorno


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCVTEX05  บAutor  ณMicrosiga           บ Data ณ  04/29/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function DelZC6(cPvVtex)

Local aAreaAtu	:= GetArea()
Local aAreaZC6	:= ZC6->(GetArea())
Local cChaveZC6	:= xFilial("ZC6")+cPvVtex

ZC6->(DbSetOrder(3))//ZC6_FILIAL+ZC6_PVVTEX
ZC6->(DbSeek(cChaveZC6))

Do While ZC6->(!Eof()) .And. ZC6->(ZC6_FILIAL+ZC6_PVVTEX)==cChaveZC6
	ZC6->(RecLock("ZC6",.F.))
	ZC6->(DbDelete())
	ZC6->(MsUnLock())
	ZC6->(DbSkip())
EndDo

RestArea(aAreaZC6)
RestArea(aAreaAtu)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCVTEX05  บAutor  ณMicrosiga           บ Data ณ  05/27/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function V05Rastreio()

Local aAreaAtu		:= GetArea()
Local cAliasQry	:= GetNextAlias()
Local cQry 	  		:= ""
Local cItem 		:= ""
Local cBody			:= ""
Local cResp			:= ""

Local cUrl			:= Alltrim(U_MyNewSX6("EC_NCG0021",'http://websro.correios.com.br/sro_bin/txect01$.QueryList?P_LINGUA=001&P_TIPO=001&P_COD_UNI=',"C","URL Correrios","","",.F. ))
Local cTranspo		:= Alltrim(U_MyNewSX6("EC_NCG0013","864","C","Codigos Transportadora","Codigos Transportadora","Codigos Transportadora",.F. ))
Local cUrlTra		:= Alltrim(U_MyNewSX6("EC_NCG0025",'https://www.rapiddo.com.br/t/',"C","URL de para montagem do link transportadora","","",.F. ))
Local cPedido 		:= ""

Local nValNf 		:= 0
Local cCodRast
Local lError 		:= .F.
Local oSite


cQry := " SELECT ZC5_NUM,ZC5.R_E_C_N_O_ RecZC5, SZ1.R_E_C_N_O_ RecSZ1 "+CRLF
cQry += " FROM "+ RetSqlName("ZC5") +" ZC5 "+CRLF
cQry += " 	INNER JOIN "+ RetSqlName("SZ1") +" SZ1 "+CRLF
cQry += " 	ON SZ1.D_E_L_E_T_=' ' "+CRLF
cQry += " 	AND SZ1.Z1_FILIAL='"+xFilial("SZ1")+"' "+CRLF
cQry += " 	AND ZC5.ZC5_NUMPV = SZ1.Z1_PEDIDO  "+CRLF
cQry += " 	AND ZC5.ZC5_NOTA = SZ1.Z1_DOC "+CRLF
cQry += " 	AND ZC5.ZC5_SERIE = SZ1.Z1_SERIE "+CRLF
cQry += " WHERE ZC5.ZC5_FILIAL='"+xFilial("ZC5")+"' "+CRLF
cQry += " AND ZC5.D_E_L_E_T_=' ' "+CRLF
cQry += " AND ZC5.ZC5_STATUS IN ('16','15','30') "+CRLF
//cQry += " AND ZC5.ZC5_ATUALI <> 'N' "+CRLF
cQry += " AND ZC5.ZC5_YMSEXP = ' ' "+CRLF
cQry += " AND ZC5.ZC5_RASTRE <> ' ' "+CRLF
cQry += " AND ZC5.ZC5_ESTORN = ' ' "+CRLF
cQry += " AND ZC5.ZC5_PLATAF = '00'  "+CRLF
cQry += " AND ZC5.ZC5_DTVTEX > '20160201' "+CRLF
cQry += " AND ZC5.ZC5_FLAG <> '8' "+CRLF
cQry += " ORDER BY ZC5_STATUS,ZC5_NUMPV "+CRLF

cQry	:= ChangeQuery(cQry)

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),cAliasQry, .F., .F.)


Do While (cAliasQry)->(!Eof())
	
	oSite:=Nil
	
	ZC5->(DbGoTo( (cAliasQry)->RecZC5 ))
	SZ1->(DbGoTo( (cAliasQry)->RecSZ1 ))
	
	If !("I" $ ZC5->ZC5_PVVTEX)
		If ZC5->ZC5_PLATAF=="00"
			oSite:=ApiVtex():New("NcGames")
		ElseIf ZC5->ZC5_PLATAF=="02"
			oSite:=ApiVtex():New("ProximoGames")
		ElseIf ZC5->ZC5_PLATAF=="03"
			oSite:=ApiVtex():New("UzGames")
		EndIf
		
		ZC5->(DbGoTo( (cAliasQry)->RecZC5 ))
		
		MyMensagem(ProcName(0)+" Atualizando Status PV VTEX: "+Alltrim(ZC5->ZC5_PVVTEX)+" PV "+ZC5->ZC5_NUMPV  )
		cStatus := Alltrim(Upper(U_Vt05Status(ZC5->ZC5_PVVTEX)))
		
		If cStatus == Upper("ready-for-handling")
			MyMensagem(ProcName(0)+" Atualizando Status PV VTEX: "+Alltrim(ZC5->ZC5_PVVTEX) +" PV "+ZC5->ZC5_NUMPV+" - Pronto para Entrega")
			
			oSite:cPedido := AllTrim(ZC5->ZC5_PVVTEX)
			oSite:PedidoStartHandling()
			
			cResp := oSite:cResponse
			
			If Valtype(cResp) == "U"
				cResp := "ERROR"
			EndIf
			
			lError :=  At("ERROR",Upper(cResp))>0
			
		EndIf
		
		If !lError .And. cStatus == Upper("handling")
			
			MyMensagem(ProcName(0)+" Atualizando Status PV VTEX: "+Alltrim(ZC5->ZC5_PVVTEX) +" PV "+ZC5->ZC5_NUMPV+" - Faturado")
			
			If Alltrim(ZC5->ZC5_CODENT) == "681"
				cCodRast:=AllTrim(ZC5->ZC5_RASTRE)
			Else
				
				cCodRast:=AllTrim(ZC5->ZC5_RASTRE)
				
				If !Empty(cCodRast) .And. Right(cCodRast,2)<>"BR"
					cCodRast+="BR"
				EndIf
			EndIf
			
			SF2->(DbSetOrder(1))
			If SF2->(MsSeek(xFilial("SF2")+ZC5->(ZC5_NOTA+ZC5_SERIE+ZC5_CLIENTE+ZC5_LOJA) ))
				SD2->(DbSetOrder(3))//D2_FILIAL+D2_DOC+D2_SERIE+D2_CLIENTE+D2_LOJA+D2_COD+D2_ITEM
				cFilSD2:=xFilial("SD2")
				
				nValNf := IIf(ZC5->ZC5_TOTAL == SF2->F2_VALFAT,SF2->F2_VALFAT,ZC5->ZC5_TOTAL) //Vtex05NF(ZC5->ZC5_NOTA,ZC5->ZC5_SERIE,ZC5->ZC5_CLIENTE,ZC5->ZC5_LOJA)
				
				cBody:='{'+CRLF
				cBody+='	"invoiceNumber": "'+AllTrim(SF2->F2_DOC)+AllTrim(SF2->F2_SERIE)+'",'+CRLF
				cBody+='	"invoiceValue": "'+AllTrim(Str(nValNf*100))+'",'+CRLF // Adicionar o frete
				cBody+='	"invoiceKey":"'+AllTrim(SF2->F2_CHVNFE)+'",'+CRLF
				cBody+='	"courier": "Correios",'+CRLF
				cBody+='	"issuanceDate": "'+StrZero(Year(SF2->F2_EMISSAO),4)+"-"+StrZero(Month(SF2->F2_EMISSAO),2)+"-"+StrZero(Day(SF2->F2_EMISSAO),2)+'",'+CRLF
				cBody+='	"trackingNumber": "'+AllTrim(ZC5->ZC5_RASTRE)+'",'+CRLF
				If Alltrim(ZC5->ZC5_CODENT) == "681"
					cBody+='	"trackingUrl": "'+ AllTrim(cUrlTra) + AllTrim(ZC5->ZC5_RASTRE) +'",'+CRLF
				EndIf
				cBody+='	"items": ['+CRLF
				
				cItem:=""
				SD2->(MsSeek(cFilSD2+SF2->(F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA)))
				Do While SD2->(!Eof()) .And. SD2->(D2_FILIAL+D2_DOC+D2_SERIE+D2_CLIENTE+D2_LOJA)==(cFilSD2+SF2->(F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA))
					If ZC5->ZC5_PLATAF == "00"
						cItem+='{"id": "'+AllTrim(u_VTEX01PROD(SD2->D2_COD,.F.))+'", '
					Else
						cItem+='{"id": "'+AllTrim(U_VTEXPROD(SD2->D2_COD,ZC5->ZC5_PLATAF,.F.))+'", '
					EndIf
					cItem+=' "price":'+AllTrim(Str(SD2->D2_TOTAL *100))+','
					cItem+='  "quantity": '+AllTrim(TransForm(SD2->D2_QUANT,'@E 99999999.99'))+'},'
					SD2->(DbSkip())
				EndDo
				cItem:=Left(cItem,Len(cItem)-1)//Retirar ultima virgula
				cBody+=cItem
				cBody+=']'+CRLF
				cBody+='}'+CRLF
				
				oSite:cPedido	:= AllTrim(ZC5->ZC5_PVVTEX)
				oSite:cBody	:= cBody
				oSite:PreparandoEntrega()
				
				cResp := oSite:cResponse
				
				If Valtype(cResp) == "U"
					cResp := "ERROR"
				EndIf
				
				If At("ERROR",Upper(cResp))>0
					
					oSite:cBody	:= cBody
					oSite:cHttp	:= ""
					oSite:cUrl		:= "http://oms.vtexcommerce.com.br/api/oms/pvt/orders/"+AllTrim(ZC5->ZC5_PVVTEX)+"/invoice/?an="+oSite:cLoja
					
					oSite:HttpPost()
					
					cResp := oSite:cResponse
				EndIf
				
				If Valtype(cResp) == "U"
					cResp := "ERROR"
				EndIf
				
				If At("ERROR",Upper(cResp))==0
					ZC5->(RecLock("ZC5",.F.))
					
					ZC5->ZC5_STATUS	:= '30'
					ZC5->ZC5_MSEXP 	:= Dtos(MsDate())
					ZC5->ZC5_YMSEXP 	:= MsDate()
					ZC5->ZC5_ATUALI	:= 'N'
					ZC5->ZC5_CODINT	:= "007"
					
					ZC5->(MsUnLock())
					
					//U_NcEcom07(ZC5->ZC5_NUMPV)
					U_NCECOM09(ZC5->ZC5_NUM, ZC5->ZC5_NUMPV,"Pedido Enviado com o rastreio "+AllTrim(ZC5->ZC5_RASTRE),"Executado com sucesso",ZC5->ZC5_STATUS,.F.,,,ZC5->ZC5_PVVTEX)
					
				EndIf
			EndIf
			
		ElseIf cStatus == Upper("invoiced")
			
			ZC5->(RecLock("ZC5",.F.))
			
			ZC5->ZC5_STATUS	:= '30'
			ZC5->ZC5_MSEXP 	:= Dtos(MsDate())
			ZC5->ZC5_YMSEXP 	:= MsDate()
			ZC5->ZC5_ATUALI	:= 'N'
			ZC5->ZC5_CODINT	:= "007"
			
			ZC5->(MsUnLock())
		EndIf
		
	ElseIf "I" $ ZC5->ZC5_PVVTEX .And. !Empty(ZC5->ZC5_RASTRE)
		ZC5->(RecLock("ZC5",.F.))
		
		ZC5->ZC5_STATUS	:= '30'
		ZC5->ZC5_MSEXP 	:= Dtos(MsDate())
		ZC5->ZC5_YMSEXP 	:= MsDate()
		ZC5->ZC5_ATUALI	:= 'N'
		ZC5->ZC5_CODINT	:= "007"
		
		ZC5->(MsUnLock())
		
	EndIf
	
	(cAliasQry)->(DbSkip())
EndDo

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCVTEX05  บAutor  ณMicrosiga           บ Data ณ  07/28/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Simula gera็ใo de nota fiscal                              บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Vtex05NF(cDoc,cSerie,cClient,cCliLoja)

Local aAreaAtu	:= GetArea()
Local aAreaSF2	:= SF2->(GetArea())
Local aAreaSD2	:= SD2->(GetArea())

Local cCliTipo	:= "C"
Local cTipoNf		:= "N"

Local nVlrTotal 	:= 0

SF2->(DbSetOrder(1))
If SF2->(MsSeek(xFilial("SF2")+cDoc+cSerie+cClient+cCliLoja))
	
	MaFisSave()
	MaFisClear()
	
	MaFisIni(cClient,;// 1-Codigo Cliente/Fornecedor
	cCliLoja	,;		// 2-Loja do Cliente/Fornecedor
	"C"			,;		// 3-C:Cliente , F:Fornecedor
	cTipoNf	,;		// 4-Tipo da NF
	cCliTipo	,;		// 5-Tipo do Cliente/Fornecedor
	Nil			,;		// 6-Relacao de Impostos que suportados no arquivo
	,;					// 7-Tipo de complemento
	,;					// 8-Permite Incluir Impostos no Rodape .T./.F.
	"SB1" ,;			// 9-Alias do Cadastro de Produtos - ("SBI" P/ Front Loja)
	"U_NCGPR120")		// 10-Nome da rotina que esta utilizando a funcao
	
	
	SD2->(DbSetOrder(3))
	SD2->(MsSeek(xFilial("SD2")+cDoc+cSerie+cClient+cCliLoja))
	
	Do While SD2->(!Eof()) .And. SD2->(D2_FILIAL+D2_DOC+D2_SERIE+D2_CLIENTE+D2_LOJA)==(cFilSD2+SF2->(F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA))
		
		MaFisAdd(SD2->D2_COD	,;	// 1-Codigo do Produto ( Obrigatorio )
		SD2->D2_TES			,;	// 2-Codigo do TES ( Opcional )
		SD2->D2_QUANT			,;	// 3-Quantidade ( Obrigatorio )
		SD2->D2_QUANT			,;	// 4-Preco Unitario ( Obrigatorio )
		SD2->D2_DESC			,;	// 5-Valor do Desconto ( Opcional )
		Nil						,;	// 6-Numero da NF Original ( Devolucao/Benef )
		Nil		   				,;	// 7-Serie da NF Original ( Devolucao/Benef )
		Nil						,;	// 8-RecNo da NF Original no arq SD1/SD2
		0		   				,;	// 9-Valor do Frete do Item ( Opcional )
		0						,;	// 10-Valor da Despesa do item ( Opcional )
		0						,;	// 11-Valor do Seguro do item ( Opcional )
		0						,;	// 12-Valor do Frete Autonomo ( Opcional )
		SD2->(D2_QUANT*D2_PRCVEN)		,;	// 13-Valor da Mercadoria ( Obrigatorio )
		0						,;	// 14-Valor da Embalagem ( Opiconal )
		0						,;	// 15-RecNo do SB1
		0						)	// 16-RecNo do SF4
		
		SD2->(DbSkip())
		
	EndDo
	
	nVlrTotal := MaFisRet(,"NF_TOTAL" )
	
	MaFisRestore()
	
EndIf

RestArea(aAreaSD2)
RestArea(aAreaSF2)
RestArea(aAreaAtu)

Return nPrcVen

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCVTEX05  บAutor  ณMicrosiga           บ Data ณ  10/20/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function Vt05Status(cPvVtex)

Local cAreaAtu 	:= GetArea()
Local oSite
Local aDadosAux 	:= {}
Local nAt			:= 0
Local cRespAux 	:= ""

Local cStatusRet 	:= ""


If !Empty(cPvVtex)
	
	ZC5->(DbSetOrder(6))
	If ZC5->(MsSeek(xFilial("ZC5")+Alltrim(cPvVtex)))
		
		oSite := Nil
		
		If ZC5->ZC5_PLATAF=="00"
			oSite:=ApiVtex():New("NcGames")
		ElseIf ZC5->ZC5_PLATAF=="02"
			oSite:=ApiVtex():New("ProximoGames")
		ElseIf ZC5->ZC5_PLATAF=="03"
			oSite:=ApiVtex():New("UzGames")
		EndIf
		
		oSite:cPedido := AllTrim(ZC5->ZC5_PVVTEX)
		oSite:GetDetalhePedido()
		
		If Valtype(oSite:cResponse) == "U"
			Return cStatusRet
		EndIf
		nAt := At("STATUS",Upper(oSite:cResponse))
		
		cRespAux	:= SubStr(oSite:cResponse,nAt,100)
		aDadosAux 	:= U_VTEX05GetDet({{"STATUS","C"}},cRespAux)
		
		cStatusRet	:= aDadosAux[1]
		
	EndIf
	
EndIf

Return cStatusRet


//------------------------------------------------------------------------------------------
/*/{Protheus.doc} V05CodEnt
// Fun็ใo que irแ controlar a gestใo das transportadoras para pv Ecommerce B2C.

@author    Lucas Felipe
@version   1.00
@since     11/11/2015
/*/
//------------------------------------------------------------------------------------------

User Function V05CodEnt(nZC5Rec,cCodEnt,cCepPed)

Local aAliasAtu 	:= GetArea()
Local aAliasZC9 	:= ZC9->(GetArea())
Local aAliasZX5 	:= ZX5->(GetArea())

Local aAliasQry	:= GetNextAlias()
Local cQuery		:= ""

Local cAtivaGFT 	:= Alltrim(U_MyNewSX6("VT_NCG0015","N","C","Atualiza forma de entrega de acordo com a configura็ใo do Ecommerce","","",.F. ))
Local cIdPad		:= Alltrim(U_MyNewSX6("VT_NCG0016","862","C","Id Padrใo para a forma de entrega do Ecommerce","","",.F. ))

Local cIdZC9		:= ""
Local lExecutar	:= .f.
Local cTabPad		:= Alltrim(U_MyNewSX6("VT_NCG0021","00011","C","Tabela responsแvel por cod padrใo de entrega por canal","","",.F. ))

Default cCodEnt 	:= cIdPad
Default cCepPed 	:= ""

ZC5->(DbGoTo(nZC5Rec))

If !Empty(cCepPed)
	
	If !(cAtivaGFT == "S")
		If !(ZC5->ZC5_PLATAF == '01')
			cCodEnt := cIdPad
		EndIf
	Else
		ZX5->(DbSetOrder(1))
		If ZX5->(DbSeek(xFilial("ZX5")+cTabPad))
			Do While ZX5->(!EoF()) .And. ZX5->ZX5_FILIAL + ZX5->ZX5_TABELA == xFilial("ZX5")+cTabPad
				
				If AllTrim(ZC5->ZC5_SALES) == AllTrim(ZX5->ZX5_CHAVE)
					cCodEnt := AllTrim(ZX5->ZX5_DESCRI)
					lExecutar := .T.
					Exit
				EndIf
				
				ZX5->(DbSkip())
				
			EndDo
		EndIf
		
		If !lExecutar
			
			cQuery += " SELECT DISTINCT ZC9_CODENT, "+CRLF
			cQuery += " 				ZC9_CEPINI, "+CRLF
			cQuery += " 				ZC9_CEPFIM "+CRLF
			cQuery += " FROM "+RetSqlName("ZC9")+" ZC9 "+CRLF
			cQuery += " WHERE ZC9.ZC9_FILIAL = '"+ xFilial("ZC9") +"' "+CRLF
			cQuery += " AND ZC9.D_E_L_E_T_ = ' ' "+CRLF
			cQuery += " AND '"+ cCepPed +"' BETWEEN ZC9.ZC9_CEPINI AND ZC9.ZC9_CEPFIM "+CRLF
			cQuery += " AND ZC9.ZC9_CODENT <> ' ' "+CRLF
			cQuery += " GROUP BY ZC9_CODENT, ZC9_CEPINI, ZC9_CEPFIM "+CRLF
			
			cQuery := ChangeQuery(cQuery)
			
			DbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), aAliasQry, .T., .F.)
			
			Do While (aAliasQry)->(!Eof())
				
				cCodEnt := (aAliasQry)->ZC9_CODENT
				
				(aAliasQry)->(DbSkip())
				
			EndDo
			
			If Empty(cCodEnt)
				cCodEnt := cIdPad
			EndIf
			
			(aAliasQry)->(DbCloseArea())
			
		EndIf
		
	EndIf
EndIf

RestArea(aAliasZX5)
RestArea(aAliasZC9)
RestArea(aAliasAtu)

Return cCodEnt
//------------------------------------------------------------------------------------------
/*/{Protheus.doc} ZC5Local
Fun็ใo que irแ controlar a gestใo das transportadoras para pv Ecommerce B2C.

@author    Lucas Felipe
@version   1.00
@since     11/11/2015
/*/
//------------------------------------------------------------------------------------------

Static Function ZC5Local(cPVVtex)

Local aAreaAtu	:= GetArea()
Local aAreaZC6	:= ZC6->(GetArea())
Local aAliasQry	:= GetNextAlias()
Local cQry			:= ""

Local lAltArm		:= .F.
Local lB2C			:= .T.

Local cArmPv		:= ""
Local nQtdPed 	:= 0
Local nQtdDisp	:= 0
Local nQtDisp		:= 0


If Empty(cPvVtex)
	Return
Else
	cPVVtex := Alltrim(cPVVtex)
EndIf


cQry += " SELECT ZC6_NUM AS NUMCIA "+CRLF
cQry += "       ,ZC6_PVVTEX AS PVVTEX "+CRLF
cQry += "	   ,ZC6_PRODUT AS PRODUTO "+CRLF
cQry += "	   ,ZC6.ZC6_QTDVEN AS QTD "+CRLF
cQry += "	   ,ZC6_LOCAL AS lOCAL_PV "+CRLF
cQry += "	   ,NVL((SB2.B2_QATU-SB2.B2_RESERVA),0) AS ARM51 "+CRLF
cQry += "	   ,NVL((B2.B2_QATU - B2.B2_RESERVA),0) AS ARM01 "+CRLF
cQry += " FROM "+RetSqlName("ZC6")+" ZC6 "+CRLF
cQry += "	LEFT OUTER JOIN "+RetSqlName("SB2")+" B2 "+CRLF
cQry += "		ON B2.D_E_L_E_T_ = ' ' "+CRLF
cQry += "		AND B2.B2_FILIAL = '"+ xFilial("SB2") +"' "+CRLF
cQry += "		AND B2.B2_LOCAL = '01' "+CRLF
cQry += "		AND B2.B2_COD = ZC6.ZC6_PRODUT "+CRLF
cQry += "	LEFT OUTER JOIN "+RetSqlName("SB2")+" SB2 "+CRLF
cQry += "		ON SB2.B2_FILIAL = '"+ xFilial("SB2") +"' "+CRLF
cQry += "		AND SB2.B2_LOCAL = '51' "+CRLF
cQry += "		AND SB2.D_E_L_E_T_ =' ' "+CRLF
cQry += "		AND SB2.B2_COD = ZC6.ZC6_PRODUT "+CRLF
cQry += " WHERE ZC6.ZC6_FILIAL = '"+ xFilial("ZC6") +"' "+CRLF
cQry += " AND ZC6.D_E_L_E_T_ =' ' "+CRLF
If lB2C
	cQry	+= " AND ZC6.ZC6_PVVTEX = '"+ cPvVtex +"' "+CRLF
Else
	cQry	+= " AND ZC6.ZC6_NUM = '"+ cNum +"' "+CRLF
EndIf
cQry	+= " ORDER BY ZC6_ITEM "+CRLF

cQry := ChangeQuery(cQry)

DbUseArea(.T., "TOPCONN", TCGenQry(,,cQry), aAliasQry, .T., .F.)


Do While (aAliasQry)->(!EoF())
	
	cArmPv 		:= (aAliasQry)->lOCAL_PV
	nQtdPed 	:= (aAliasQry)->QTD
	nQtdDisp 	:=  Iif(cArmPv == '51',(aAliasQry)->ARM51,(aAliasQry)->ARM01)
	
	If !(nQtdDisp >= nQtdPed) .And. !lAltArm
		
		nQtDisp :=  Iif( cArmPv =='51',(aAliasQry)->ARM01,(aAliasQry)->ARM51) //Troca de Estoque
		
		If nQtDisp >= nQtdPed
			
			If !lAltArm
				lAltArm := .T.
				(aAliasQry)->(DbGoTop())
				Loop
			EndIf
			
		EndIf
		
	Else
		
		nQtDisp :=  Iif( cArmPv =='51',(aAliasQry)->ARM01,(aAliasQry)->ARM51) //Troca de Estoque
		
		If !( nQtDisp >= nQtdPed ) .And. lAltArm
			lAltArm := .F.
			Exit
		Endif
		
	EndIf
	
	(aAliasQry)->(DbSkip())
	
EndDo


If lAltArm
	
	If lB2C
		
		ZC6->(DbSetOrder(3)) //ZC6_FILIAL+ZC6_PVVTEX
		If ZC6->(MsSeek(xFilial("ZC6")+AllTrim(cPvVtex)))
			
			Do While ZC6->(!EoF()) .And. ZC6->ZC6_FILIAL+AllTrim(ZC6->ZC6_PVVTEX) == xFilial("ZC6")+AllTrim(cPvVtex)
				
				ZC6->(RecLock("ZC6",.F.))
				
				ZC6->ZC6_LOCAL := Iif(ZC6->ZC6_LOCAL=="51","01","51")
				
				ZC6->(MsUnlock())
				
				ZC6->(DbSkip())
			EndDo
			
			U_NCECOM09(0,"ESTOQU","Altera็ใo de Armaz้m","O Armaz้m foi alterado de 51 para 01, afim de atender o pedido completamente","",.F.,,"Estoque",cPVVtex)
		EndIf
		
	Else
		
		ZC6->(DbSetOrder(1)) //ZC6_FILIAL+STR(ZC6_NUM)
		ZC6->(MsSeek(xFilial("ZC6")+cNum))
		
		Do While ZC6->(!EoF()) .And. ZC6->ZC6_FILIAL+STR(ZC6->ZC6_NUM) == xFilial("ZC6")+cNum
			
			ZC6->(RecLock("ZC6",.F.))
			
			ZC6->ZC6_LOCAL := Iif(ZC6->ZC6_LOCAL=="51","01","51")
			
			ZC6->(MsUnlock())
			
			ZC6->(DbSkip())
		EndDo
		
		//U_NCECOM09(cNum,"ESTOQUE","ALTERACAO DE ESTOQUE","O Armaz้m foi alterado para "+ZC6->ZC6_LOCAL+" para atender o pv completamente","",.T.,,"Estoque")
	EndIf
	
EndIf

(aAliasQry)->(DbCloseArea())

RestArea(aAreaZC6)
RestArea(aAreaAtu)

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCVTEX05  บAutor  ณMicrosiga           บ Data ณ  12/03/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function VTEX05IMP()

Local aAreaAtu	:= GetArea()
Local aButtons	:={}
Local cCadastro	:="Importa็ใo E-commerce"
Local cPerg		:=Padr("VTEX05IMP",Len(SX1->X1_GRUPO))

PutSx1(cPerg,"01","Arquivo E-commerce","","","MV_CH1","C",60,0,0,"F"," "," "," "," ","MV_PAR01","56","","","","","","","","","","","","","","","","","","","")
PutSx1(cPerg,"02","Reimportar Pedidos","","","MV_CH1","N",1,0,1,"C","","","","","mv_par02","Nใo","","","","Sim","","","","","","","","","","","",,,)

If SX1->(DbSeek(cPerg+"01")) .And. AllTrim(SX1->X1_DEF01)<>"56"
	SX1->(RecLock("SX1",.F.))
	SX1->X1_DEF01:="56"
	SX1->(MsUnLock())
EndIf


If Pergunte(cPerg)
	If !File(mv_par01)
		MsgStop("Arquivo nใo encontrado.","NcGames")
		Return
	EndIf
	Processa( {|| ImpTab(AllTrim(mv_par01))  })
EndIf

RestArea(aAreaAtu)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCVTEX05  บAutor  ณMicrosiga           บ Data ณ  12/03/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ImpTab(cArquivo)

Local aAreaAtu	:= GetArea()
Local aAreaZC5	:= ZC5->(GetArea())
Local aAreaZC6	:= ZC6->(GetArea())

Local aAreaSA7	:= SA7->(GetArea())
Local aAreaSB1	:= SB1->(GetArea())

Local cFilZC5		:= xFilial("ZC5")
Local cFilZC6		:= xFilial("ZC6")
Local cFilSA7		:= xFilial("SA7")
Local cFilSA1		:= xFilial("SA1")
Local cFilSB1		:= xFilial("SB1")
Local cFilSA3		:= xFilial("SA3")

Local cAliasWork 	:= GetNextAlias()
Local cCliNc		:= Alltrim(U_MyNewSX6("VT_NCG0005","000000","C","C๓d. de cliente NcGames utilizado no VTex","","",.F. ))
Local cLocalERP	:= Alltrim(U_MyNewSX6("VT_000005","51" ,"C","Armaz้m de Venda Protheus","","",.F. ))
Local aLojas		:= {{"Ncgames","00"},{"UzGames","03"}}
Local aCabec		:= {}
Local aZA1_SA1	:= {}
Local aDados		:= {}
Local aDadosEnt	:= {}
Local aPostUrl	:= {}
Local aStruct		:= {}
Local aDados		:= {}
Local aMensagem 	:= {}
Local cLinha		:= ""
Local nTotLinha	:= 0
Local nLinha
Local nInd
Local lIsCorporate
Local cPedido
Local nItemZC6
Local cUser
Local cPassword
Local nWebService
Local cSoap
Local oWSVtex
Local cBuffer
Local cTelefone
Local cChaveWork
Local nPosEmail
Local nPosTransp
Local oSite
Local aMensagem	:= {}
Local lHelpAtu	:= HelpInDark(.T.)//Nใo mostrar as mensagens de help
Local cErro
Local lReimportar	:= (mv_par02==2)
Local lAppendZC5
Local lFoundZC5
Local cChaveZC5
Local nLenPVVtex	:= AvSx3("ZC5_PVVTEX",3)
Local nRecZC5
Local cCpoSequen
Local cMV_PAR		:= "VT_NCGVT01"
Local cPrefixo
Local nFrete
Local aDadosProd
Local cIDZC6
Local aDadosError

Local cMsgReimp 	:= ""
Local cMotivo	 	:= ""


FT_FUSE(cArquivo)  //ABRIR
FT_FGOTOP() //PONTO NO TOPO
ProcRegua(nTotLinha:=FT_FLASTREC())

FT_FGOTOP()
cBuffer := FT_FREADLN() //LENDO LINHA
nLinha:=0
If MsgYesNo("Arquivo cont๊m cabe็alho?"+CRLF+"Sim=A primeira linha serแ ignorada"+CRLF+"Nใo=A primeira linha Nใo serแ ignorada"+CRLF+"Conteudo inicial primeira linha "+Left(cBuffer,10)+"...","NcGames")
	FT_FSKIP();nLinha:=1
EndIf

If !MsgYesNo("Confirma processamento do arquivo "+AllTrim(cArquivo)+"?","NcGames")
	Return
EndIf


U_VTEX01Param(@cUser,@cPassword,aPostUrl)
oWSVtex:=WSVtex():New
oWSVtex:cUrlWS:=aPostUrl[1,2]

IncProc("Criando tabela temporaria")
For nInd:=1 To 40
	AADD(aStruct,{"CAMPO_"+StrZero(nInd,2),"C",70,0  })
Next
cWorkName:=E_CriaTrab(,aStruct,cAliasWork)
IndRegua(cAliasWork,cWorkName+OrdBagExt(),"CAMPO_05", , , ,.F. )


Do While !FT_FEOF()
	cBuffer := FT_FREADLN() //LENDO LINHA
	IncProc("Gravando dados Tabela Temporaria(TMP) - Linha:"+StrZero(++nLinha,5))
	aDados:=Separa(cBuffer,";")
	(cAliasWork)->(DbAppend())
	For nInd:=1 To Len(aDados)
		(cAliasWork)->(FieldPut(nInd,AllTrim(aDados[nInd])))
	Next
	FT_FSKIP()   //pr๓ximo registro no arquivo txt
EndDo
FT_FUSE() //fecha o arquivo txt

aADD(aCabec,{"ID"				,"C"})
aADD(aCabec,{"EMAIL"			,"C"})
aADD(aCabec,{"FIRSTNAME"		,"C"})
aADD(aCabec,{"LASTNAME"			,"C"})
aADD(aCabec,{"DOCUMENTTYPE"		,"C"})
aADD(aCabec,{"DOCUMENT"			,"C"})
aADD(aCabec,{"PHONE"			,"C"})
aADD(aCabec,{"CORPORATENAME"	,"C"})
aADD(aCabec,{"TRADENAME"		,"C"})
aADD(aCabec,{"CORPORATEDOCUMENT","C"})
aADD(aCabec,{"STATEINSCRIPTION"	,"C"})
aADD(aCabec,{"CORPORATEPHONE"	,"C"})
aADD(aCabec,{"ISCORPORATE"		,"L"})
aADD(aCabec,{"USERPROFILEID"	,"C"})
aADD(aCabec,{"ADDRESSTYPE"		,"C"})
aADD(aCabec,{"RECEIVERNAME"		,"C"})
aADD(aCabec,{"ADDRESSID"		,"C"})
aADD(aCabec,{"POSTALCODE"		,"C"})
aADD(aCabec,{"CITY"				,"C"})
aADD(aCabec,{"STATE"			,"C"})
aADD(aCabec,{"COUNTRY"			,"C"})
aADD(aCabec,{"STREET"			,"C"})
aADD(aCabec,{"NUMBER"			,"C"})
aADD(aCabec,{"NEIGHBORHOOD"		,"C"})
aADD(aCabec,{"COMPLEMENT"		,"C"})
aADD(aCabec,{"REFERENCE"		,"C"})
aADD(aCabec,{"COURIERID"		,"C"})

nPosEmail 	:= Ascan(aCabec,{|a| a[1]=="EMAIL"  })
nPosTransp 	:= Ascan(aCabec,{|a| a[1]=="COURIERID"  })

ProcRegua(nTotLinha:=(cAliasWork)->(RecCount()) )

oSite	:= ApiVtex():New(aLojas[1,1])

ZC5->(DbSetOrder(5))//ZC5_FILIAL+ZC5_PLATAF+ZC5_PVVTEX
ZC6->(DbSetOrder(3))//ZC6_FILIAL+ZC6_PVVTEX+ZC6_IDPROD
SB1->(DbSetOrder(1))//B1_FILIAL+B1_COD
SA3->(DbSetOrder(1))//A3_FILIAL+A3_COD

(cAliasWork)->(DbGoTop())
nLinha:=0
Do While (cAliasWork)->(!Eof())
	
	IncProc("Gravando Tabela Intermediaria(ZC5) - Pedido:"+AllTrim((cAliasWork)->CAMPO_05))
	
	If Empty( (cAliasWork)->CAMPO_05 )
		(cAliasWork)->(DbSkip());Loop
	EndIf
	
	SA1->(dbOrderNickName("SA1SALES"))
	If !SA1->(MsSeek(cFilSA1+cCliNc+aLojas[1,2]+AllTrim((cAliasWork)->CAMPO_03)))
		AADD(aMensagem,{"QMT_NO",AllTrim((cAliasWork)->CAMPO_05),"Canal nใo encontrado: "+(cAliasWork)->CAMPO_03} )
		(cAliasWork)->(DbSkip());Loop
	EndIf
	cPrefixo:="I"
	If !Empty(SA1->A1_HPAGE)
		cPrefixo+=AllTrim((SA1->A1_HPAGE))+"-"
	EndIf
	
	cPedido:=cPrefixo+AllTrim((cAliasWork)->CAMPO_05)
	cChaveZC5:=cFilZC5+aLojas[1,2]+Padr(cPedido,nLenPVVtex)
	lFoundZC5:=ZC5->(MsSeek(cChaveZC5))
	nRecZC5:=ZC5->(Recno())
	
	Do While ZC5->(!Eof()) .And. ZC5->(ZC5_FILIAL+ZC5_PLATAF+ZC5_PVVTEX)==cChaveZC5
		cPedido:=AllTrim(ZC5->ZC5_PVVTEX)
		nRecZC5:=ZC5->(Recno())
		ZC5->(DbSkip())
	EndDo
	ZC5->(DbGoTo(nRecZC5))
	lAppendZC5:=.T.
	
	If lReimportar
		If lFoundZC5 .And. Left(ZC5->ZC5_SEQUEN,1)=="I"
			If Empty(ZC5->ZC5_FLAG)
				AADD(aMensagem,{"UPDINFORMATION",cPedido,"Pedido jแ reimportado na base da NcGames."} )
				(cAliasWork)->(DbSkip());Loop
			Else
				lAppendZC5:=.F.
			EndIf
		EndIf
	Else
		//oSite:cPedido:=cPedido
		//oSite:GetPedido()
		If lFoundZC5 .And. Left(ZC5->ZC5_SEQUEN,1)=="I" .And. !Empty(ZC5->ZC5_FLAG)
			lAppendZC5:=.F.
			//ElseIf ValType(oSite:cResponse)=="C" .And. At(cPedido,oSite:cResponse)>0 //.And. At('"orderId": "'+AllTrim(cPedido)+'"',oSite:cResponse)>0
			//AADD(aMensagem,{"UPDINFORMATION",cPedido,"Pedido encontrado no VTEX. Aguarde integra็ใo."} )
			//(cAliasWork)->(DbSkip());Loop
		ElseIf lFoundZC5
			AADD(aMensagem,{"UPDINFORMATION",cPedido,"Pedido encontrado na base da NcGames."} )
			(cAliasWork)->(DbSkip());Loop
		EndIf
	EndIf
	
	
	If lAppendZC5
		cSequen	:= AllTrim(U_MyNewSX6(cMV_PAR,"00000000","C","Sequencia Automatica E-commerce","","",.F. ))
		cSequen	:=Soma1(GetMv( cMV_PAR ))
		PutMv(cMV_PAR,cSequen)//Gravar conteudo no parametro
		cCpoSequen:="I"+cSequen
	Else
		cCpoSequen:=ZC5->ZC5_SEQUEN
	EndIf
	
	lGravaCli	:= .F.
	lNotFound	:= .F.
	
	Begin Transaction
	ZC5->(Reclock("ZC5",lAppendZC5))
	ZC5->ZC5_FILIAL	:= cFilZC5
	ZC5->ZC5_PVVTEX	:= cPedido
	ZC5->ZC5_PLATAF	:= aLojas[1,2]
	ZC5->ZC5_FLAG	:= "2"
	ZC5->ZC5_ORIGEM	:= IIf(IsDigit( Left(ZC5->ZC5_PVVTEX,1) ),"Marketplace","Fulfillment")
	ZC5->ZC5_TOTAL	:= VTEX05Trans((cAliasWork)->CAMPO_06,"N")
	ZC5->ZC5_CODENT	:= "862"
	ZC5->ZC5_QTDPAR	:= 1
	ZC5->ZC5_STATUS := IIf(Upper(AllTrim((cAliasWork)->CAMPO_02))=="PEDIDO APROVADO","10","4")
	ZC5->ZC5_SALES	:= SA1->A1_YSALES
	ZC5->ZC5_DTVTEX	:= VTEX05Trans((cAliasWork)->CAMPO_01,"D_EXCEL")
	ZC5->ZC5_SEQUEN	:= cCpoSequen
	
	If ZC5->ZC5_STATUS == "10"
		ZC5->ZC5_PAGTO:= "2"
	EndIf
	
	ZC5->ZC5_LJECOM:=SA1->A1_LOJA
	ZC5->ZC5_NOECOM:=SA1->A1_NOME
	
	aDados		:= {}
	
	If Len( AllTrim((cAliasWork)->CAMPO_07) )>=12
		(cAliasWork)->CAMPO_07:=Padl(AllTrim((cAliasWork)->CAMPO_07),14,"0")
		lIsCorporate:=.T.
	Else
		(cAliasWork)->CAMPO_07:=Padl(AllTrim((cAliasWork)->CAMPO_07),11,"0")
		lIsCorporate:=.F.
	EndIf
	
	cTelefone:=StrTran((cAliasWork)->CAMPO_18,"(","")
	cTelefone:=StrTran(cTelefone,")","")
	
	cMotivo		:= Alltrim((cAliasWork)->CAMPO_28)
	cMsgReimp 	:= Alltrim((cAliasWork)->CAMPO_29)
	
	aADD(aDados,"")									//{"ID"				,"C"})
	aADD(aDados,AllTrim((cAliasWork)->CAMPO_27))	//{"EMAIL"				,"C"})xx
	aADD(aDados,AllTrim((cAliasWork)->CAMPO_08))	//FIRSTNAME"			,"C"})xx
	aADD(aDados,"")									//LASTNAME"			,"C"})xx
	
	
	aADD(aDados,Iif(lIsCorporate,"cnpj","cpf"))	//DOCUMENTTYPE"		,"C"})xx
	aADD(aDados,AllTrim((cAliasWork)->CAMPO_07))	//DOCUMENT"			,"C"}) xx
	aADD(aDados,AllTrim(cTelefone))					//PHONE"				,"C"}) xx
	aADD(aDados,AllTrim((cAliasWork)->CAMPO_08))	//CORPORATENAME"		,"C"})xx
	aADD(aDados,"")									//TRADENAME"			,"C"})xx
	aADD(aDados,AllTrim((cAliasWork)->CAMPO_07))	//CORPORATEDOCUMENT"	,"C"})xx
	aADD(aDados,"")									//STATEINSCRIPTION"	,"C"})xx
	aADD(aDados,AllTrim((cAliasWork)->CAMPO_18))	//CORPORATEPHONE"		,"C"})xx
	aADD(aDados,lIsCorporate)						//ISCORPORATE"		,"L"})xx
	aADD(aDados,"")									//USERPROFILEID"		,"C"})
	aADD(aDados,"")									//ADDRESSTYPE"		,"C"})
	aADD(aDados,"")	   								//RECEIVERNAME		,"C"})
	aADD(aDados,"")									//ADDRESSID"			,"C"})
	aADD(aDados,AllTrim((cAliasWork)->CAMPO_14))	//POSTALCODE"			,"C"})xx
	aADD(aDados,AllTrim((cAliasWork)->CAMPO_16))	//CITY"				,"C"})xx
	aADD(aDados,AllTrim((cAliasWork)->CAMPO_15))	//STATE"				,"C"})xx
	aADD(aDados,"")									//COUNTRY"				,"C"})
	aADD(aDados,AllTrim((cAliasWork)->CAMPO_09))	//STREET"				,"C"})xx
	aADD(aDados,AllTrim((cAliasWork)->CAMPO_10))	//NUMBER"				,"C"})xx
	aADD(aDados,AllTrim((cAliasWork)->CAMPO_13))	//NEIGHBORHOOD"		,"C"})xx
	aADD(aDados,AllTrim((cAliasWork)->CAMPO_11))	//COMPLEMENT"			,"C"})xx
	aADD(aDados,AllTrim((cAliasWork)->CAMPO_12))	//REFERENCE"			,"C"})xx
	aADD(aDados,"")									//COURIERID"			,"C"})
	
	aDadosEnt	:= {}
	cErro		:=""
	
	If VTEX05GrvCli(aCabec,aDados,ZC5->ZC5_PLATAF,Trim(ZC5->ZC5_SALES),ZC5->ZC5_PVVTEX,aZA1_SA1,aDadosEnt,@cErro)
		ZC5->ZC5_CLIENT	:= SA1->A1_COD
		ZC5->ZC5_LOJA	:= SA1->A1_LOJA
		
		ZC5->ZC5_ENDENT	:= IIf(!Empty(aDadosEnt[01]),aDadosEnt[01],SA1->A1_ENDENT)
		ZC5->ZC5_BAIROE	:= IIf(!Empty(aDadosEnt[02]),aDadosEnt[02],SA1->A1_BAIRROE)
		ZC5->ZC5_CEPE	:= IIf(!Empty(aDadosEnt[03]),aDadosEnt[03],SA1->A1_CEPE)
		ZC5->ZC5_MUNE	:= IIf(!Empty(aDadosEnt[04]),aDadosEnt[04],SA1->A1_MUNE)
		ZC5->ZC5_ESTE  	:= IIf(!Empty(aDadosEnt[05]),aDadosEnt[05],SA1->A1_ESTE)
		ZC5->ZC5_COMPLE	:= IIf(!Empty(aDadosEnt[06]),aDadosEnt[06],SA1->A1_COMPLEM)
		ZC5->ZC5_CODMUE	:= IIf(!Empty(aDadosEnt[07]),aDadosEnt[07],SA1->A1_COD_MUN)
		
		ZC5->ZC5_CONDPG	:= aDadosEnt[09]
		ZC5->ZC5_EMAIL	:= aDados[nPosEmail]
		ZC5->ZC5_CODENT	:= U_V05CodEnt(ZC5->(Recno()),aDados[nPosTransp],aDadosEnt[03])
		ZC5->ZC5_CGC		:= SA1->A1_CGC
		ZC5->ZC5_FLAG	:= '3'
	Else
		aDadosError:=Separa(cErro,CRLF)
		For nInd:=1 To Len(aDadosError)
			If "INVALIDO"$Upper(aDadosError[nInd])
				cErro:=aDadosError[nInd]
				Exit
			EndIf
		Next
		ZC5->ZC5_FLAG	:= '4'
		AADD(aMensagem,{"QMT_NO",cPedido,"Erro gravar cliente: "+cErro} )
	EndIf
	
	nFrete		:= 0
	cChaveWork	:= (cAliasWork)->CAMPO_05
	nItemZC6		:= 0
	cErroProd	:= ""
	
	Do While (cAliasWork)->(!Eof()) .And. (cAliasWork)->CAMPO_05==cChaveWork //Gravar Itens
		
		PtInternal(1,ProcName(0)+" Pedido Site:"+ZC5->ZC5_PVVTEX+"Id "+(cAliasWork)->CAMPO_21 )
		
		nFrete+=VTEX05Trans((cAliasWork)->CAMPO_25,"N")
		
		cIdZC6:=AllTrim((cAliasWork)->CAMPO_21 )
		aDadosProd:={"",""}
		SA7->(DbSetOrder(3))//A7_FILIAL+A7_CLIENTE+A7_LOJA+A7_CODCLI
		If SA7->(MsSeek(cFilSA7+cCliNc+ZC5->ZC5_PLATAF+cIdZC6))
			cIdZC6:=SA7->A7_CODCLI
			If SB1->(DbSeek(cFilSB1+SA7->A7_PRODUTO ) )
				aDadosProd:={SB1->B1_COD,SB1->B1_CODBAR}
			EndIf
		ElseIf SB1->(DbSeek(cFilSB1+cIdZC6 ) ) .Or. SB1->(DbSeek(cFilSB1+"0"+cIdZC6))
			SA7->(DbSetOrder(2))//A7_FILIAL+A7_PRODUTO+A7_CLIENTE+A7_LOJA
			If SA7->(DbSeek(cFilSA7+SB1->B1_COD+cCliNc+ZC5->ZC5_PLATAF))
				cIdZC6:=SA7->A7_CODCLI
			EndIf
		EndIf
		
		lAppend:=!ZC6->(MsSeek(cFilZC6+ZC5->ZC5_PVVTEX+cIdZC6)  )
		ZC6->(RecLock("ZC6",lAppend))
		
		ZC6->ZC6_FILIAL	:= cFilZC6
		ZC6->ZC6_PVVTEX	:= ZC5->ZC5_PVVTEX
		ZC6->ZC6_ITEM  	:= StrZero(++nItemZC6,2)
		
		ZC6->ZC6_VLRUNI	:= VTEX05Trans((cAliasWork)->CAMPO_24,"N")
		ZC6->ZC6_IDPROD	:= cIdZC6
		ZC6->ZC6_QTDVEN	:= VTEX05Trans((cAliasWork)->CAMPO_23,"N")
		
		ZC6->ZC6_VLRTOT	:= ZC6->(ZC6_VLRUNI*ZC6_QTDVEN)
		ZC6->ZC6_LOCAL	:= cLocalERP
		ZC6->ZC6_DESCRI	:= VTE05NoAcen( Upper((cAliasWork)->CAMPO_22))
		ZC6->ZC6_PRODUTO:=aDadosProd[1]
		ZC6->ZC6_EAN   	:=aDadosProd[2]
		
		If Empty(ZC6->ZC6_PRODUTO)
			lNotFound:=.T.
			cErroProd+="Produto ID "+AllTrim(ZC6->ZC6_IDPROD)+" ("+AllTrim(ZC6->ZC6_DESCRI)+") nao encontrado no ERP"+CRLF
			U_NCECOM09(0,"PRODUTO","IMPORTA_PRODUTO "+ZC6->ZC6_IDPROD,"Produto ID "+AllTrim(ZC6->ZC6_IDPROD)+" ("+AllTrim(ZC6->ZC6_DESCRI)+") nao encontrado no ERP","",.T.,,"Produto",ZC5->ZC5_PVVTEX)
		EndIf
		
		(cAliasWork)->(DbSkip())
	EndDo
	
	ZC5->ZC5_FRETE:= nFrete
	
	If ZC5->ZC5_FLAG=='3'
		ZC5->ZC5_FLAG:=IIf(lNotFound,"5","")
		If Empty(ZC5->ZC5_FLAG)
			U_NCECOM09(0,"REIMPORTACAO","REIMPORTACAO DE PEDIDO","Pedido reimportado com sucesso","",.F.,,,ZC5->ZC5_PVVTEX)
			U_NCECOM09(0,"REIMPORTACAO","Motivo de reimporta็ใo",cMsgReimp,"",.F.,,,ZC5->ZC5_PVVTEX)
			ZC5->ZC5_MOTIVO := cMotivo
		EndIf
	EndIf
	
	If !Empty(cErroProd)
		AADD(aMensagem,{"QMT_NO",cPedido,cErroProd} )
	ElseIf Empty(ZC5->ZC5_FLAG)
		AADD(aMensagem,{"QMT_OK",cPedido,"Pedido gravado com sucesso."} )
		//ZC5Local(Alltrim(ZC5->ZC5_PVVTEX))
	EndIf
	
	ZC5->(MsUnlock())
	
	End Transaction
EndDo

HelpInDark(lHelpAtu)
(cAliasWork)->(E_EraseArq(cWorkName))

VTEX05Tela(aMensagem)

RestArea(aAreaZC5)
RestArea(aAreaZC6)

RestArea(aAreaSB1)
RestArea(aAreaSA7)

RestArea(aAreaAtu)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCVTEX05  บAutor  ณMicrosiga           บ Data ณ  12/03/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function VTEX05Trans(xDado,cTipo,nLen,nDec)
Local xRetorno:=xDado
If cTipo=="N"
	xDado:=StrTran(xDado,",",".")
	xRetorno:=Val(xDado)
ElseIf cTipo=="D"
	xRetorno:=STOD(xDado)
ElseIf cTipo=="D_EXCEL"
	xRetorno:=CTOD(Left(xDado,10))
ElseIf cTipo=="C"
	xRetorno:=AllTrim(xDado)
EndIf


Return xRetorno

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCVTEX05  บAutor  ณMicrosiga           บ Data ณ  12/04/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function VTEX05Tela(aLogPrc)
Local oDlg
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Mostra a tela com o resumo do processamento                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
DEFINE MSDIALOG oDlg TITLE "Resumo" FROM 000,000 TO 400,810 OF oDlg PIXEL
DEFINE SBUTTON FROM 187,345 TYPE 1 OF oDlg ENABLE ACTION( oDlg:End() )
DEFINE SBUTTON FROM 187,375 TYPE 6 OF oDlg ENABLE ACTION( ImpRel(aLogPrc) )
@ 005,003 LISTBOX oLst FIELDS ;
HEADER		" ",;
"Pedido Site",;
"Detalhes" ;
COLSIZES	GetTextWidth( 0, "BBB" ),;
GetTextWidth( 0, "BBBBBBBBBBBBBBBBBBBB" ),;
GetTextWidth( 0, "BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB" ),;
SIZE 400,180 OF oDlg PIXEL
oLst:SetArray( aLogPrc )
oLst:bLine := { || {	LoadBitMap( GetResources(), aLogPrc[oLst:nAt,01] ),;	// Imagem
aLogPrc[oLst:nAt,02],;											// Motivo
aLogPrc[oLst:nAt,03] ;											// Detalhes
} }
ACTIVATE DIALOG oDlg CENTERED


//------------------------------------------------------------------------------------------
// {Protheus.doc} ImpRel
//------------------------------------------------------------------------------------------

Static Function ImpRel(aLogPrc)

Local aCabec	:= {}
Local aItens	:= {}
Local nLoop		:= 0
aAdd( aCabec, { "Tipo",				1, 1, .F. } )
aAdd( aCabec, { "Pedido Site",			1, 1, .F. } )
aAdd( aCabec, { "Detalhamento",		1, 1, .F. } )
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Monta array com os itens da planilha                                                     ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
For nLoop := 1 to Len( aLogPrc )
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Alimenta o array que gera o Excel                                                    ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	aAdd( aItens, Array( Len( aCabec ) ) )
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Grava as informa็๕es do documento de origem                                          ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If "UPDINFORMATION" $ aLogPrc[nLoop,01]
		aItens[Len( aItens ),01]	:= "Informa็ใo"
	ElseIf "UPDERROR" $ aLogPrc[nLoop,01]
		aItens[Len( aItens ),01]	:= "Erro"
	ElseIf "UPDWARNING" $ aLogPrc[nLoop,01]
		aItens[Len( aItens ),01]	:= "Aten็ใo"
	ElseIf "QMT_OK" $ aLogPrc[nLoop,01]
		aItens[Len( aItens ),01]	:= "Processo Concluํdo Com Sucesso"
	ElseIf "QMT_COND" $ aLogPrc[nLoop,01]
		aItens[Len( aItens ),01]	:= "Processo Concluํdo Com Aten็ใo"
	ElseIf "QMT_NO" $ aLogPrc[nLoop,01]
		aItens[Len( aItens ),01]	:= "Processo Concluํdo Com Divereg๊ncia"
	Else
		aItens[Len( aItens ),01]	:= "Sem Defini็ใo"
	EndIf
	aItens[Len( aItens ),02]	:= aLogPrc[nLoop,02]
	aItens[Len( aItens ),03]	:= aLogPrc[nLoop,03]
Next nLoop
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Se tem dados exporta para o Excel                                                       ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If Len( aItens ) > 0
	Msgrun( "Gerando Planilha Excel", "Nc Games", { || FExExcel( aCabec, aItens ) } )
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Se nใo tem dados aviso usuแrio                                                          ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Else
	Aviso(	"Nc Games",	"Nใo hแ registros a exportar.",	{"&Ok"},3,"Sem Dados" )
EndIf

Return( Nil )

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณDS_ATUSA1 บAutor  ณMicrosiga           บ Data ณ  09/14/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function FExExcel( aCabec,aItens, aExtMes )
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Define as variแveis da rotina                                                           ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Local oExcelApp	:= Nil
Local oExcel	:= FWMSEXCEL():New()
Local lVisual	:= .T.
Local nLoop		:= 0
Local cArquivo	:= CriaTrab(,.F.) + ".xls"
Local cDirDocs	:= MsDocPath()
Local cPath		:= AllTrim(GetTempPath())
Local cWSheet	:= "Erros"
Local cTable	:= "Erros"

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Verifica se a esta็ใo tem o Excel instalado                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If !ApOleClient('MsExcel')
	Aviso(	"FExExcel-01",;
	"MsExcel nใo instalado na esta็ใo de trabalho." + CRLF +;
	"O Arquivo serแ gerado mas nใo serแ possํvel efetuar a visualiza็ใo do mesmo." + CRLF +;
	"Path: " + AllTrim( cPath ) + "." + CRLF +;
	"Arquivo: " + AllTrim( cArquivo ) + ".",;
	{ "&Continua" },3,;
	"MSExcel Nใo Instalado" )
	lVisual	:= .F.
EndIf
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Define as configura็๕es de cabe็alho                                                    ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
oExcel:SetTitleSizeFont( 14 )
oExcel:SetTitleItalic( .T. )
oExcel:SetTitleBold( .T. )
oExcel:SetTitleFrColor( "#FFFFFF" )	//Cor de Fonte - Branco
oExcel:SetTitleBgColor( "#00009C" )	//Cor da Fundo - Azul Escuro
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Cria a WorkSheet                                                                        ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
oExcel:AddworkSheet( cWSheet )
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Cria a Tabela                                                                           ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
oExcel:AddTable( cWSheet, cTable )
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Cria o Cabe็alho                                                                        ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
For nLoop := 1 To Len( aCabec )
	//	cWorkSheet,	cTable,	cColumm,			nAlign,				nFormat,			lTotal
	oExcel:AddColumn(	cWSheet,	cTable, aCabec[nLoop,01],	aCabec[nLoop,2],	aCabec[nLoop,3],	aCabec[nLoop,4] )
Next nLoop
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Cria os Itens                                                                           ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
For nLoop := 1 to Len( aItens )
	oExcel:AddRow( cWSheet, cTable, aItens[nLoop] )
Next nLoop
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Fez a montagem correta do objeto excel                                                  ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If !Empty(oExcel:aWorkSheet)
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Ativa o objeto e gera o arquivo                                                     ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	oExcel:Activate()
	oExcel:GetXMLFile(cDirDocs+"\"+cArquivo)
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Copia para a esta็ใo de trabalho o arquivo gerado                                   ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	CpyS2T(cDirDocs+"\"+cArquivo,cPath)
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Abre o arquivo no excel se existir na esta็ใo de trabalho                           ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If lVisual
		oExcelApp := MsExcel():New()
		oExcelApp:WorkBooks:Open(cPath+cArquivo) // Abre uma planilha
		oExcelApp:SetVisible(.T.)
		oExcelApp:Destroy()
	EndIf
Else
	Aviso(	"FExExcel-01",;
	"Nใo foi possํvel criar a planilha com os dados selecionados." + CRLF +;
	"Verifique os parโmetros utilizados para execu็ใo da rotina.",;
	{ "&Continua" },3,;
	"Sem Dados" )
EndIf

Return( Nil )

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCVTEX05  บAutor  ณMicrosiga           บ Data ณ  01/28/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function MyMensagem(cMensagem)
PtInternal(1,cMensagem)
TcInternal(1,cMensagem)
Conout(cMensagem)

Return
//------------------------------------------------------------------------------------------
/*/{Protheus.doc} GetLoja

@author    Lucas Felipe
@version   1.00
@since     09/03/2016
/*/
//------------------------------------------------------------------------------------------

Static Function GetLoja(cCliente)

Local aAreaAtu 	:= GetArea()
Local aAreaSA1 	:= SA1->(GetArea())
Local cLjCli		:= "01"

If !Empty(cCliente)
	
	SA1->(DbSetOrder(1))
	SA1->(MsSeek(xFilial("SA1")+cCliente))
	
	While SA1->(!Eof()) .And. SA1->(A1_FILIAL+A1_COD) == xFilial("SA1")+cCliente
		
		If SA1->(MsSeek(xFilial("SA1")+A1_COD+cLjCli))
			cLjCli := Soma1(cLjCli)
		Else
			Exit
		EndIf
		SA1->(DbSkip())
		
	End
	
EndIf

RestArea(aAreaSA1)
RestArea(aAreaAtu)

Return cLjCli

//------------------------------------------------------------------------------------------
/*/{Protheus.doc} GetLoja

@author    Lucas Felipe
@version   1.00
@since     09/03/2016
/*/
//------------------------------------------------------------------------------------------

User Function Vt05When(cCampo)

Local aAreaAtu:= GetArea()
Local aAreaSA1:= SA1->(GetArea())

Local lRet
Local xVlrCpo	:= &(__ReadVar)
Local lEcomm	:= IsInCallStack("U_VTEX05ClI")  //Verifica se foi chamado pela U_VTEX05Cli

Default cCampo:= __ReadVar

If lEcomm
	Do Case
		Case cCampo=="M->A1_CGC"
			If SA1->(MsSeek(xFilial("SA1")+M->A1_CGC))
				Do While SA1->(!Eof()) .And. SA1->(A1_FILIAL+A1_CGC) == xFilial("SA1")+M->A1_CGC
					If SA1->A1_COD == M->A1_COD
						lRet := .T.
					EndIf
					SA1->(DbSkip())
				EndDo
			EndIf
			
		Case cCampo=="M->A1_INSCR"
			lRet := .T.
	EndCase
EndIf


RestArea(aAreaSA1)
RestArea(aAreaAtu)

Return lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCVTEX05  บAutor  ณMicrosiga           บ Data ณ  08/10/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
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
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCVTEX05  บAutor  ณMicrosiga           บ Data ณ  08/10/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Rotina para atualizar os status dos pedidos no sistema Vtex บฑฑ
ฑฑบ          ณ atualizar para status FATURADO                              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function Vt05Fatu()

Local aAreaAtu		:= GetArea()
Local cAliasQry	:= GetNextAlias()
Local cQry 	  		:= ""
Local cItem 		:= ""
Local cBody			:= ""
Local cResp			:= ""

Local cUrl			:= Alltrim(U_MyNewSX6("EC_NCG0021",'http://websro.correios.com.br/sro_bin/txect01$.QueryList?P_LINGUA=001&P_TIPO=001&P_COD_UNI=',"C","URL Correrios","","",.F. ))
Local cTranspo		:= Alltrim(U_MyNewSX6("EC_NCG0013","864","C","Codigos Transportadora","Codigos Transportadora","Codigos Transportadora",.F. ))
Local cUrlTra		:= Alltrim(U_MyNewSX6("EC_NCG0025",'https://www.rapiddo.com.br/t/',"C","URL de para montagem do link transportadora","","",.F. ))
Local cPedido 		:= ""

Local nValNf 		:= 0
Local cCodRast
Local lError 		:= .F.
Local oSite
Local dData			:= Date()
Local nDiaCorri		:= 20

cQry := " SELECT ZC5_NUM,ZC5.R_E_C_N_O_ RecZC5, SZ1.R_E_C_N_O_ RecSZ1 "+CRLF
cQry += " FROM "+ RetSqlName("ZC5") +" ZC5 "+CRLF
cQry += " 	INNER JOIN "+ RetSqlName("SZ1") +" SZ1 "+CRLF
cQry += " 	ON SZ1.D_E_L_E_T_=' ' "+CRLF
cQry += " 	AND SZ1.Z1_FILIAL='"+xFilial("SZ1")+"' "+CRLF
cQry += " 	AND ZC5.ZC5_NUMPV = SZ1.Z1_PEDIDO  "+CRLF
cQry += " 	AND ZC5.ZC5_NOTA = SZ1.Z1_DOC "+CRLF
cQry += " 	AND ZC5.ZC5_SERIE = SZ1.Z1_SERIE "+CRLF
cQry += " WHERE ZC5.ZC5_FILIAL='"+xFilial("ZC5")+"' "+CRLF
cQry += " AND ZC5.D_E_L_E_T_=' ' "+CRLF
cQry += " AND ZC5.ZC5_STATUS IN ('10','16','15','30') "+CRLF
//cQry += " AND ZC5.ZC5_ATUALI <> 'N' "+CRLF
cQry += " AND ZC5.ZC5_YMSEXP = ' ' "+CRLF
//cQry += " AND ZC5.ZC5_RASTRE <> ' ' "+CRLF
cQry += " AND ZC5.ZC5_ESTORN = ' ' "+CRLF
cQry += " AND ZC5.ZC5_PLATAF = '00'  "+CRLF
//cQry += " AND (SUBSTR(ZC5.ZC5_DTVTEX,5,2) < '" + cMes + "' OR SUBSTR(ZC5.ZC5_DTVTEX,0,4) < '" + cAno + "') "+CRLF
cQry += " AND ZC5.ZC5_DTVTEX < '"+ Dtos(DaySub(dData, nDiaCorri))+"' "+CRLF
cQry += " AND ZC5.ZC5_FLAG <> '8' "+CRLF
cQry += " ORDER BY ZC5_STATUS,ZC5_NUMPV"+CRLF

cQry	:= ChangeQuery(cQry)

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),cAliasQry, .F., .F.)


Do While (cAliasQry)->(!Eof())
	
	oSite:=Nil
	
	ZC5->(DbGoTo( (cAliasQry)->RecZC5 ))
	SZ1->(DbGoTo( (cAliasQry)->RecSZ1 ))

	
	If !("I" $ ZC5->ZC5_PVVTEX)
		//Atualizara a numera็ใo da NF e Serie caso ainda 
		U_V05STATU()
		
		If ZC5->ZC5_PLATAF=="00"
			oSite:=ApiVtex():New("NcGames")
		ElseIf ZC5->ZC5_PLATAF=="02"
			oSite:=ApiVtex():New("ProximoGames")
		ElseIf ZC5->ZC5_PLATAF=="03"
			oSite:=ApiVtex():New("UzGames")
		EndIf
		
		
		MyMensagem(ProcName(0)+" Atualizando Status PV VTEX: "+Alltrim(ZC5->ZC5_PVVTEX)+" PV "+ZC5->ZC5_NUMPV  )
		cStatus := Alltrim(Upper(U_Vt05Status(ZC5->ZC5_PVVTEX)))
		
		
		If cStatus == Upper("ready-for-handling")
		MyMensagem(ProcName(0)+" Atualizando Status PV VTEX: "+Alltrim(ZC5->ZC5_PVVTEX) +" PV "+ZC5->ZC5_NUMPV+" - Pronto para Entrega")
			
			oSite:cPedido := AllTrim(ZC5->ZC5_PVVTEX)
			oSite:PedidoStartHandling()
			
			cResp := oSite:cResponse
			
			If Valtype(cResp) == "U"
				cResp := "ERROR"
			EndIf
			
			lError :=  At("ERROR",Upper(cResp))>0
			
		EndIf
		
		If !lError .And. cStatus == Upper("handling")
			
			MyMensagem(ProcName(0)+" Atualizando Status PV VTEX: "+Alltrim(ZC5->ZC5_PVVTEX) +" PV "+ZC5->ZC5_NUMPV+" - Faturado")
			
			If Alltrim(ZC5->ZC5_CODENT) == "681"
				cCodRast:=AllTrim(ZC5->ZC5_RASTRE)
			Else
				
				cCodRast:=AllTrim(ZC5->ZC5_RASTRE)
				
				If !Empty(cCodRast) .And. Right(cCodRast,2)<>"BR"
					cCodRast+="BR"
				EndIf
			EndIf
			
			SF2->(DbSetOrder(1))
			If SF2->(MsSeek(xFilial("SF2")+ZC5->(ZC5_NOTA+ZC5_SERIE+ZC5_CLIENTE+ZC5_LOJA) ))
				SD2->(DbSetOrder(3))//D2_FILIAL+D2_DOC+D2_SERIE+D2_CLIENTE+D2_LOJA+D2_COD+D2_ITEM
				cFilSD2:=xFilial("SD2")
				
				nValNf := IIf(ZC5->ZC5_TOTAL == SF2->F2_VALFAT,SF2->F2_VALFAT,ZC5->ZC5_TOTAL) //Vtex05NF(ZC5->ZC5_NOTA,ZC5->ZC5_SERIE,ZC5->ZC5_CLIENTE,ZC5->ZC5_LOJA)
				
				cBody:='{'+CRLF
				cBody+='	"invoiceNumber": "'+AllTrim(SF2->F2_DOC)+AllTrim(SF2->F2_SERIE)+'",'+CRLF
				cBody+='	"invoiceValue": "'+AllTrim(Str(nValNf*100))+'",'+CRLF // Adicionar o frete
				cBody+='	"invoiceKey":"'+AllTrim(SF2->F2_CHVNFE)+'",'+CRLF
				cBody+='	"courier": "Correios",'+CRLF
				cBody+='	"issuanceDate": "'+StrZero(Year(SF2->F2_EMISSAO),4)+"-"+StrZero(Month(SF2->F2_EMISSAO),2)+"-"+StrZero(Day(SF2->F2_EMISSAO),2)+'",'+CRLF
				
				//cBody+='	"trackingNumber": "'+AllTrim(ZC5->ZC5_RASTRE)+'",'+CRLF
				If empty(AllTrim(ZC5->ZC5_RASTRE))
					cBody+='	"trackingNumber": null,'+CRLF
					cBody+='	"trackingUrl": null,'+CRLF
				Else
					cBody+='	"trackingNumber": "'+AllTrim(ZC5->ZC5_RASTRE)+'",'+CRLF
					If Alltrim(ZC5->ZC5_CODENT) == "681"
						cBody+='	"trackingUrl": "'+ AllTrim(cUrlTra) + AllTrim(ZC5->ZC5_RASTRE) +'",'+CRLF
					EndIf
					
				Endif					
				
				cBody+='	"items": ['+CRLF
				
				cItem:=""
				SD2->(MsSeek(cFilSD2+SF2->(F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA)))
				Do While SD2->(!Eof()) .And. SD2->(D2_FILIAL+D2_DOC+D2_SERIE+D2_CLIENTE+D2_LOJA)==(cFilSD2+SF2->(F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA))
					If ZC5->ZC5_PLATAF == "00"
						cItem+='{"id": "'+AllTrim(u_VTEX01PROD(SD2->D2_COD,.F.))+'", '
					Else
						cItem+='{"id": "'+AllTrim(U_VTEXPROD(SD2->D2_COD,ZC5->ZC5_PLATAF,.F.))+'", '
					EndIf
					cItem+=' "price":'+AllTrim(Str(SD2->D2_TOTAL *100))+','
					cItem+='  "quantity": '+AllTrim(TransForm(SD2->D2_QUANT,'@E 99999999.99'))+'},'
					SD2->(DbSkip())
				EndDo
				cItem:=Left(cItem,Len(cItem)-1)//Retirar ultima virgula
				cBody+=cItem
				cBody+=']'+CRLF
				cBody+='}'+CRLF
				
				oSite:cPedido	:= AllTrim(ZC5->ZC5_PVVTEX)
				oSite:cBody	:= cBody
				oSite:PreparandoEntrega()
				
				cResp := oSite:cResponse
				
				If Valtype(cResp) == "U"
					cResp := "ERROR"
				EndIf
				
				If At("ERROR",Upper(cResp))>0
					
					oSite:cBody	:= cBody
					oSite:cHttp	:= ""
					oSite:cUrl		:= "http://oms.vtexcommerce.com.br/api/oms/pvt/orders/"+AllTrim(ZC5->ZC5_PVVTEX)+"/invoice/?an="+oSite:cLoja
					
					oSite:HttpPost()
					
					cResp := oSite:cResponse
				EndIf
				
				If Valtype(cResp) == "U"
					cResp := "ERROR"
				EndIf
				
				If At("ERROR",Upper(cResp))==0
					ZC5->(RecLock("ZC5",.F.))
					
					ZC5->ZC5_STATUS	:= '30'
					ZC5->ZC5_MSEXP 	:= Dtos(MsDate())
					ZC5->ZC5_YMSEXP 	:= MsDate()
					ZC5->ZC5_ATUALI	:= 'N'
					ZC5->ZC5_CODINT	:= "007"
					
					ZC5->(MsUnLock())
					
					//U_NcEcom07(ZC5->ZC5_NUMPV)
					U_NCECOM09(ZC5->ZC5_NUM, ZC5->ZC5_NUMPV,"Pedido Enviado com o rastreio "+AllTrim(ZC5->ZC5_RASTRE),"Executado com sucesso",ZC5->ZC5_STATUS,.F.,,,ZC5->ZC5_PVVTEX)
					
				EndIf
			EndIf
			
		ElseIf cStatus == Upper("invoiced")
			
			ZC5->(RecLock("ZC5",.F.))
			
			ZC5->ZC5_STATUS	:= '30'
			ZC5->ZC5_MSEXP 	:= Dtos(MsDate())
			ZC5->ZC5_YMSEXP 	:= MsDate()
			ZC5->ZC5_ATUALI	:= 'N'
			ZC5->ZC5_CODINT	:= "007"
			
			ZC5->(MsUnLock())
		Else
			cOutStatus := U_V05STATU(ZC5->ZC5_PVVTEX)
		EndIf
		
	ElseIf "I" $ ZC5->ZC5_PVVTEX .And. !Empty(ZC5->ZC5_RASTRE)
		ZC5->(RecLock("ZC5",.F.))
		
		ZC5->ZC5_STATUS	:= '30'
		ZC5->ZC5_MSEXP 	:= Dtos(MsDate())
		ZC5->ZC5_YMSEXP 	:= MsDate()
		ZC5->ZC5_ATUALI	:= 'N'
		ZC5->ZC5_CODINT	:= "007"
		
		ZC5->(MsUnLock())
		*/
	
	EndIf
	
	(cAliasQry)->(DbSkip())
EndDo

Return

User function V05STATU()

if Empty(Alltrim(ZC5->ZC5_NOTA))

	dbSelectArea("SZ1")
	dbSetOrder(2)
	if dbSeek(xFilial("SZ1")+ZC5->ZC5_NUMPV)
		ZC5->(RecLock("ZC5",.F.))
		
		ZC5->ZC5_NOTA := Z1_DOC
		ZC5->ZC5_SERIE:= Z1_SERIE
		ZC5->ZC5_STATUS:='15'
		ZC5->ZC5_ATUALI:='S'
		
		ZC5->(MsUnLock())	
	EndIf

EndIf 
Return
