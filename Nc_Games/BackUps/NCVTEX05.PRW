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
ฑฑบUso       ณ AP                                                        บฑฑ
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
ฑฑบUso       ณ AP                                                        บฑฑ
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
	Processa( {|| U_NCVTEX05()}	,"Gravando Cabecalho")
	Processa( {|| U_VTEX05Cli()}	,"Gravando Cliente")
	Processa( {|| U_VTEX05Prod()}	,"Gravando Produto")
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
Default aDados := {"01","03"}

RpcSetEnv(aDados[1],aDados[2])

U_NCVTEX05()
U_VTEX05Cli()
U_VTEX05Prod()

//U_COM08MENU()//Adicionado para gravar pedido.

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

User Function NCVTEX05()
Local cCliNc	:= Alltrim(U_MyNewSX6("VT_NCG0005","000000","C","C๓d. de cliente NcGames utilizado no VTex","","",.F. ))
Local cLojaNc	:= Alltrim(U_MyNewSX6("VT_NCG0006","00","C","C๓d. de loja NcGames utilizado no VTex","","",.F. ))
Local oSite
Local aLojas	:={{"Ncgames","00"},{"UzGames","03"}}
Local aStatus 	:= {"ready-for-handling","payment-pending","payment-approved"}
Local nInd
Local nYnd
Local cPedido
Local aDados
Local aGetDados
Local lCancelado
Local aCabec	:= {{"CREATIONDATE","D"},{"CLIENTNAME","C"},{"TOTALVALUE","N"},{"PAYMENTNAME","C"},{"MARKETPLACEORDERID","C"},{"SEQUENCE","C"},{"SALESCHANNEL","C"},{"ORIGIN","C"},{"WORKFLOWINERRORSTATE","L"},{"LISTID","C"}}

Local nAt
Local nI
Local aDadosAux	:= {}
Local nPerPage	:= 100
Local nPages	:= 1
Local aPages	:= {AllTrim(Str(nPages))}
Local cRespAux	:= ""

AADD(aStatus,"canceled")

ZC5->(DbSetOrder(5))//ZC5_FILIAL+ZC5_PLATAF+ZC5_PVVTEX
For nInd:=1 To Len(aLojas)
	oSite	:= Nil
	oSite	:= ApiVtex():New(aLojas[nInd,1])
	oSite:nPaginas := nPerPage
	
	For nYnd:=1 To Len(aStatus)
		
		lCancelado:=(nYnd==Len(aStatus))
		
		oSite:cStatus:=aStatus[nYnd]
		oSite:GetPedidoStatus()
		
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
			oSite:nPage		:= AllTrim(aPages[nI])
			oSite:GetPedidoStatus()
			
			If !ValType(oSite:cResponse)=="C"
				Loop
			EndIf
			If At('orderId',oSite:cResponse)==0
				Loop
			EndIf
			
			aDados:=Separa(oSite:cResponse,'orderId')
			
			For nXnd:=1 To Len(aDados)
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
							ZC5->ZC5_FLAG	:= "2"
							ZC5->ZC5_ORIGEM	:= aGetDados[Ascan(aCabec,{|a|a[1]=="ORIGIN" })]
							ZC5->ZC5_TOTAL	:= aGetDados[Ascan(aCabec,{|a|a[1]=="TOTALVALUE" })]/100
							ZC5->ZC5_CODENT	:= "862"
							ZC5->ZC5_QTDPAR	:= 1
							ZC5->ZC5_STATUS := IIf(nYnd==2,"4","10")
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
							ZC5->ZC5_STATUS := "96"
							ZC5->ZC5_FLAG	:= ""
							ZC5->ZC5_PAGTO 	:= ""
							ZC5->(MsUnlock())
							End Transaction
						Case nYnd<>2
							If AllTrim(ZC5->ZC5_STATUS)=="4"
								Begin Transaction
								ZC5->(Reclock("ZC5",.F.))
								ZC5->ZC5_STATUS 	:="10"
								ZC5->ZC5_PAGTO 	:= "2"
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
		
		If VTEX05GrvCli(aCabec,aDados,cPlataforma,Trim(ZC5->ZC5_SALES),ZC5->ZC5_PVVTEX,aZA1_SA1,aDadosEnt )
			
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
			ZC5->ZC5_EMAIL	:= aDados[2]
			
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
Local cTagDes	:= '"Discounts Total"'
Local cTagFrete	:= '"Shipping Total"'
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
		
		Begin Transaction
		
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
		
		End Transaction     
				
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
Static Function VTEX05GrvCli(aCabec,aDados,cLojaNc,cSalesChanel,cPvVtex,aZA1_SA1,aDadosEnt)

Local aAreaAtu		:= GetArea()
Local cCodCli
Local cEmail		:= aDados[Ascan(aCabec,{|a|a[1]=="EMAIL" })]
Local cCPF_CNPJ		:= aDados[Ascan(aCabec,{|a|a[1]=="DOCUMENT" })]
Local cCep			:= aDados[Ascan(aCabec,{|a|a[1]=="POSTALCODE" })]
Local cNumber		:= aDados[Ascan(aCabec,{|a|a[1]=="NUMBER" })]
Local cTelefone		:= aDados[Ascan(aCabec,{|a|a[1]=="PHONE" })]
Local cTipoDoc		:= aDados[Ascan(aCabec,{|a|a[1]=="DOCUMENTTYPE" })]
Local lIsPJ			:= aDados[Ascan(aCabec,{|a|a[1]=="ISCORPORATE" })]
Local cEstado		:= Upper(aDados[Ascan(aCabec,{|a|a[1]=="STATE" })])
Local cNome			:= VTE05NoAcen(Upper(aDados[Ascan(aCabec,{|a|a[1]=="FIRSTNAME" })]+Space(1)+aDados[Ascan(aCabec,{|a|a[1]=="LASTNAME" })]))
Local cBairro		:= VTE05NoAcen(Upper(aDados[Ascan(aCabec,{|a|a[1]=="NEIGHBORHOOD" })]))
Local cEndereco		:= VTE05NoAcen(Upper(aDados[Ascan(aCabec,{|a|a[1]=="STREET" })]))
Local cComplemento	:= VTE05NoAcen(Upper(aDados[Ascan(aCabec,{|a|a[1]=="COMPLEMENT" })]))
Local cReferencia	:= VTE05NoAcen(Upper(aDados[Ascan(aCabec,{|a|a[1]=="REFERENCE" })]))
Local cMun        	:= VTE05NoAcen(Padr( Upper(aDados[Ascan(aCabec,{|a|a[1]=="CITY" })]), AvSx3("CC2_MUN",3) ))
Local cIE			:= Upper(aDados[Ascan(aCabec,{|a|a[1]=="STATEINSCRIPTION" })])

Local cPessoa		:= "F"
Local cCliNc		:= Alltrim(U_MyNewSX6("VT_NCG0005","000000","C","C๓d. de cliente NcGames utilizado no VTex","","",.F. ))
Local cGrpVen		:= "999999"
Local cCodMun		:= ""

Local cTipo			:= "F"
Local GrpCli		:= "CFIE"
Local cContrib		:= "2"
Local cBloqueado	:= "2"
Local cTab			:= "018"
Local cEstCiv		:= " "
Local cSexo			:= " "
Local cCodpais		:= "01058" //Brasil
Local dDtNasc		:= Ctod("//")
Local aVetor		:= {}
Local lJaExiste
Local cErroAdiconal	:= ""
Local cVendedor		:= "VN9902"
Local cCondPag		:= ""
Local cCanal		:= "990001"

Local cEmailOri 	:= ""
If lIsPJ
	cCPF_CNPJ	:= aDados[Ascan(aCabec,{|a|a[1]=="CORPORATEDOCUMENT" })]
	cTelefone	:= aDados[Ascan(aCabec,{|a|a[1]=="CORPORATEPHONE" })]
	cNome		:= FwNoAccent(Upper(aDados[Ascan(aCabec,{|a|a[1]=="CORPORATENAME" })]+Space(1)+aDados[Ascan(aCabec,{|a|a[1]=="TRADENAME" })]))
	cPessoa		:=	"J"
	cVendedor	:= "VN9902"
	cCondPag	:= ""
	cCanal		:= "990001"
Endif
If "0000000" $ cTelefone
	cTelefone := "+5511409530001"
EndIf

cTelefone:=AllTrim(Str(Val(StrTran(cTelefone,"+55",""))))                    

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
	AADD(aDadosEnt,cCondPag)		//09
	AADD(aDadosEnt,cCanal)			//10
	
	Return .T.
EndIf


CC2->(DBSETORDER(2)) //CC2_FILIAL+CC2_MUN
If CC2->(DbSeek(xFilial("CC2")+cMun))
	Do While CC2->(!Eof()) .And.  CC2->CC2_MUN==cMun
		If CC2->CC2_EST==cEstado
			cCodMun	:= CC2->CC2_CODMUN
		EndIf
		CC2->(DbSkip())
	EndDo
Else
	cErroAdiconal:="Codigo Municipio nใo encontrado para o Municipio "+cMun
EndIf

//Corrige a ordem para as valida็๕es do campo
CC2->(DBSETORDER(1))

SA1->(DbSetOrder(3))

If (lJaExiste:=SA1->(MsSeek(xFilial("SA1")+cCPF_CNPJ)))
	cCodCli		:= SA1->A1_COD
	cEmailOri	:= SA1->A1_EMAIL
Else
	cCodCli := GETSXENUM("SA1","A1_COD")
	SA1->(DbSetOrder(1))
	Do While SA1->(DbSeek(xFilial("SA1") +cCodCli+"01" ))
		ConfirmSX8()
		cCodCli := GETSXENUM("SA1","A1_COD")
	EndDo
EndIf

cCep	:= StrTran(StrTran(cCep,"-",""),Space(1),"")
cTabPrc := "CON"
cIE		:= IIf(Empty(cIE),"ISENTO",cIE)

M->A1_COMPLEM:=""
If !Empty(cComplemento)
	M->A1_COMPLEM:=cComplemento
EndIf

If !Empty(cReferencia)
	M->A1_COMPLEM+=Space(1)+cReferencia
EndIf

AADD(aDadosEnt,cEndereco+", "+cNumber)	//01
AADD(aDadosEnt,cBairro)					//02
AADD(aDadosEnt,cCep)					//03
AADD(aDadosEnt,cMun)					//04
AADD(aDadosEnt,cEstado)					//05
AADD(aDadosEnt,M->A1_COMPLEM)			//06
AADD(aDadosEnt,cCodMun)					//07
AADD(aDadosEnt,cVendedor)				//08
AADD(aDadosEnt,cCondPag)				//09
AADD(aDadosEnt,cCanal)					//10


AADD(aVetor,{"A1_FILIAL" 	,xFilial("SA1") ,Nil})
AADD(aVetor,{"A1_COD" 		,cCodCli,Nil})
AADD(aVetor,{"A1_LOJA" 		,"01" ,Nil})
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
AADD(aVetor,{"A1_TEL" 		,SubStr(cTelefone,2) ,Nil})
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
AADD(aVetor,{"A1_INSCR" 	,cIE ,Nil})
AADD(aVetor,{"A1_VEND" 		,cVendedor ,Nil})
AADD(aVetor,{"A1_CONTA" 	,"11201010001" ,Nil})
AADD(aVetor,{"A1_TRANSP" 	,"000002" ,Nil})
AADD(aVetor,{"A1_TPFRET" 	,"C" ,Nil})
AADD(aVetor,{"A1_GRPTRIB"	,GrpCli ,Nil})
AADD(aVetor,{"A1_SATIV1" 	,"000037" ,Nil})
AADD(aVetor,{"A1_GRPVEN" 	,"990000" ,Nil})
AADD(aVetor,{"A1_CODPAIS"	,cCodpais ,Nil})
AADD(aVetor,{"A1_FRETE" 	,"1" ,Nil})
AADD(aVetor,{"A1_TEMODAL" 	,"2" ,Nil})
AADD(aVetor,{"A1_YCANAL" 	,cCanal ,Nil})
AADD(aVetor,{"A1_XGRPCOM" 	,"ECOMME" ,Nil})
AADD(aVetor,{"A1_CONTRIB" 	,cContrib ,Nil})
AADD(aVetor,{"A1_TABELA" 	,cTabPrc ,Nil})
AADD(aVetor,{"A1_COND" 		,cCondPag ,Nil})
AADD(aVetor,{"A1_XSORTER"	 ,"1" ,Nil})
AADD(aVetor,{"A1_DTNASC" 	,MsDate() ,Nil})
AADD(aVetor,{"A1_AGEND" 	,"2" ,Nil})
AADD(aVetor,{"A1_OPER" 		,"" ,Nil})
If Empty(cEmailOri) //adicionado para atender a necessidade de email do cliente.
	AADD(aVetor,{"A1_EMAIL" ,cEmail		,Nil})
EndIf
AADD(aVetor,{"A1_XEMAIL2" 	,cEmail 	,Nil})
AADD(aVetor,{"A1_COMPLEM" 	,Upper(M->A1_COMPLEM),Nil})
AADD(aVetor,{"A1_REGIAO" 	,U_AchaReg(cEstado) ,Nil})
AADD(aVetor,{"A1_MSBLQL" 	,cBloqueado ,Nil})

If lJaExiste
	Return .T.
EndIf

BEGIN TRANSACTION

lMsErroAuto:=.F.
CC2->(DBSETORDER(1))
MSExecAuto({|x,y| MATA030(x,y)},aVetor, Iif(lJaExiste,4,3))
_cError:=""
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
	__READVAR := "M->"+aVetor[nInd][1]
	cReadVar := &(__READVAR)
	&(__READVAR) := aVetor[nInd][2]
	
	bValid:=AvSx3(aVetor[nInd][1],7)
	If !Eval( bValid )
		xConteudo:=aVetor[nInd][2]
		If ValType(xConteudo)=="N"
			xConteudo:=AllTrim(Str(xConteudo))
		ElseIf ValType(xConteudo)=="D"
			xConteudo:=DTOC(xConteudo)
		EndIf
		_cError+="Erro campo "+aVetor[nInd][1]+" conteudo "+xConteudo+CRLF
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

Local cCliNc		:= Alltrim(U_MyNewSX6("VT_NCG0005","000000","C","C๓d. de cliente NcGames utilizado no VTex","","",.F. ))
Local cTabela		:= "00003"
Local aAreaAtu		:= GetArea()
Local aAreaZX5		:= ZX5->(GetArea())
Local aAreaSA1		:= SA1->(GetArea())
Local lPodeGravar	:= .F.
Local dDtCorte		:= U_MyNewSX6("VT_900001","23/05/2015","D","Data de Corte","","",.F. )

If dDtVtex>dDtCorte
	ZX5->(DbSetOrder(1))//ZX5_FILIAL+ZX5_TABELA+ZX5_CHAVE
	SA1->(dbOrderNickName("SA1SALES"))//A1_FILIAL+A1_COD+A1_LJECOME+A1_YSALES
	lPodeGravar:=(SA1->(MsSeek(xFilial("SA1")+cCliNc+cLoja+Trim(cSales))) .And. ZX5->(MsSeek(xFilial("ZX5")+cTabela+SA1->A1_LOJA)))
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
Local aAreaAtu:=GetArea()
Local aAreaZA1:=ZA1->(GetArea())
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
	aAux:=aZA1_SA1[nInd]
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
ZA1->ZA1_FILIAL	:=xFilial("ZA1")
ZA1->ZA1_PVVTEX	:=cPvVtex
ZA1->ZA1_ERRO		:=cErro
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
Local cRetorno:=FwNoAccent(cString)
Local aAlterar :={{"'"," "}	}

For nInd:=1 To Len(aAlterar)
	cRetorno:=StrTran(cRetorno,aAlterar[nInd,1],aAlterar[nInd,2])
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
Local aAreaAtu	:=GetArea()
Local aAreaZC6	:=ZC6->(GetArea())
Local cChaveZC6:=xFilial("ZC6")+cPvVtex

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

Local aAreaAtu	:= GetArea()
Local cAliasQry	:= GetNextAlias()
Local cQry 		:= ""
Local cItem 	:= ""
Local cBody		:= ""
Local cResp		:= ""

Local cUrl		:= Alltrim(U_MyNewSX6("EC_NCG0021",'http://websro.correios.com.br/sro_bin/txect01$.QueryList?P_LINGUA=001&P_TIPO=001&P_COD_UNI=',"C","URL Correrios","","",.F. ))
Local cTranspo	:= Alltrim(U_MyNewSX6("EC_NCG0013","864","C","Codigos Transportadora","Codigos Transportadora","Codigos Transportadora",.F. ))
Local cPedido 	:= ""

Local nValNf 	:= 0
Local cCodRast
Local cUrlAux
Local cHtmlPage
Local lConecta
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
cQry += " AND ZC5.ZC5_ATUALI = 'S' "+CRLF
cQry += " AND ZC5.ZC5_YMSEXP=' ' "+CRLF
cQry += " AND ZC5.ZC5_RASTRE<>' ' "+CRLF
cQry += " AND ZC5.ZC5_ESTORN=' ' "+CRLF
cQry += " AND ZC5_PLATAF In ('00','03','02')  "+CRLF
cQry += " ORDER BY ZC5_NUM "+CRLF

cQry	:= ChangeQuery(cQry)

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),cAliasQry, .F., .F.)


Do While (cAliasQry)->(!Eof())
	
	oSite:=Nil
	
	
	ZC5->(DbGoTo( (cAliasQry)->RecZC5 ))
	SZ1->(DbGoTo( (cAliasQry)->RecSZ1 ))
	lPvVtex:=ZC5->ZC5_PLATAF$"00|03|02"
	
	If lPvVtex
		If ZC5->ZC5_PLATAF=="00"
			oSite:=ApiVtex():New("NcGames")
		ElseIf ZC5->ZC5_PLATAF=="02"
			oSite:=ApiVtex():New("ProximoGames")
		ElseIf ZC5->ZC5_PLATAF=="03"
			oSite:=ApiVtex():New("UzGames")
		EndIf
		
		If ZC5->ZC5_STATUS == '16'
			If Empty(SZ1->Z1_DTSAIDA)
				
				ZC5->(RecLock("ZC5",.F.))
				ZC5->ZC5_ATUALI:='S'
				ZC5->ZC5_STATUS:="15"
				ZC5->(MsUnLock())
				
				oSite:cPedido := AllTrim(ZC5->ZC5_PVVTEX)
				oSite:PedidoStartHandling()
			EndIf
		EndIf
		ZC5->(DbGoTo( (cAliasQry)->RecZC5 ))
		
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
				
				cCodRast:= AllTrim(ZC5->ZC5_RASTRE)
				cUrlAux	:= cUrl+cCodRast
			Next
			
		EndIf
		
		If !lConecta
			ZC1->(RecLock("ZC1",.F.))
			
			ZC1->ZC1_REGIST	:=cCodRast
			ZC1->ZC1_OBSRAS	:="Codigo de Rastreio nใo encontrado no site dos Correios"
			ZC1->ZC1_ERRO	:=.T.
			
			ZC1->(MsUnLock())
			
			(cAliasQry)->(DbSkip());Loop
		EndIf
		
		ZC1->(RecLock("ZC1",.F.))
		ZC1->ZC1_REGIST:=cCodRast
		ZC1->(MsUnLock())
		
		ZC5->(RecLock("ZC5",.F.))
		ZC5->ZC5_RASTRE:=cCodRast
		ZC5->(MsUnLock())
	EndIf
	
	If lConecta
		
		SF2->(DbSetOrder(1))
		If SF2->(MsSeek(xFilial("SF2")+ZC5->(ZC5_NOTA+ZC5_SERIE+ZC5_CLIENTE+ZC5_LOJA) ))
			SD2->(DbSetOrder(3))//D2_FILIAL+D2_DOC+D2_SERIE+D2_CLIENTE+D2_LOJA+D2_COD+D2_ITEM
			cFilSD2:=xFilial("SD2")
			
			nValNf := IIf(ZC5->ZC5_TOTAL == SF2->F2_VALFAT,SF2->F2_VALFAT,ZC5->ZC5_TOTAL) //Vtex05NF(ZC5->ZC5_NOTA,ZC5->ZC5_SERIE,ZC5->ZC5_CLIENTE,ZC5->ZC5_LOJA)
			
			cBody:='{'+CRLF
			cBody+='	"invoiceNumber": "'+AllTrim(SF2->F2_DOC)+AllTrim(SF2->F2_SERIE)+'",'+CRLF
			cBody+='	"invoiceValue": "'+AllTrim(Str(nValNf*100))+'",'+CRLF // Adicionar o frete
			cBody+='	"courier": "Correios",'+CRLF
			//cBody+='	"invoiceUrl":"",'
			//cBody+='	"embeddedInvoice":"'+AllTrim(SF2->F2_CHVNFE)+'",'
			cBody+='	"issuanceDate": "'+StrZero(Year(SF2->F2_EMISSAO),4)+"-"+StrZero(Month(SF2->F2_EMISSAO),2)+"-"+StrZero(Day(SF2->F2_EMISSAO),2)+'",'+CRLF
			cBody+='	"trackingNumber": "'+AllTrim(ZC5->ZC5_RASTRE)+'",'+CRLF
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
			
			oSite:cPedido := AllTrim(ZC5->ZC5_PVVTEX)
			oSite:PedidoStartHandling()
			
			oSite:cBody	:= cBody
			oSite:PreparandoEntrega()
			
			cResp := oSite:cResponse
			
			If Valtype(cResp) == "U"
				cResp := "ERROR"
			EndIf
			
			If At("ERROR",Upper(cResp))>0
				
				oSite:cBody	:= cBody
				oSite:cHttp	:= ""
				oSite:cUrl	:= "http://oms.vtexcommerce.com.br/api/oms/pvt/orders/"+AllTrim(ZC5->ZC5_PVVTEX)+"/invoice/?an="+oSite:cLoja
				
				oSite:HttpPost()
			EndIf
			
			If Valtype(oSite:cResponse) == "U"
				cResp := "ERROR"
			EndIf
			
			If At("ERROR",Upper(cResp))==0
				ZC5->(RecLock("ZC5",.F.))
				
				ZC5->ZC5_STATUS	:= '30'
				ZC5->ZC5_MSEXP 	:= Dtos(MsDate())
				ZC5->ZC5_YMSEXP := MsDate()
				ZC5->ZC5_ATUALI	:= 'N'
				ZC5->ZC5_CODINT	:= "007"
				
				ZC5->(MsUnLock())
				
				//U_NcEcom07(ZC5->ZC5_NUMPV)
				U_NCECOM09(ZC5->ZC5_NUM, ZC5->ZC5_NUMPV,"Pedido Enviado com o rastreio "+AllTrim(ZC5->ZC5_RASTRE),"Executado com sucesso",ZC5->ZC5_STATUS,.F.,,,ZC5->ZC5_PVVTEX)
				
			EndIf
		EndIf
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
Local cTipoNf	:= "N"

Local nVlrTotal := 0

SF2->(DbSetOrder(1))
If SF2->(MsSeek(xFilial("SF2")+cDoc+cSerie+cClient+cCliLoja))
	
	MaFisSave()
	MaFisClear()
	
	MaFisIni(cClient,;	// 1-Codigo Cliente/Fornecedor
	cCliLoja		,;	// 2-Loja do Cliente/Fornecedor
	"C"				,;	// 3-C:Cliente , F:Fornecedor
	cTipoNf			,;	// 4-Tipo da NF
	cCliTipo		,;	// 5-Tipo do Cliente/Fornecedor
	Nil				,;	// 6-Relacao de Impostos que suportados no arquivo
	,;	// 7-Tipo de complemento
	,;	// 8-Permite Incluir Impostos no Rodape .T./.F.
	"SB1"			,;	// 9-Alias do Cadastro de Produtos - ("SBI" P/ Front Loja)
	"U_NCGPR120")		// 10-Nome da rotina que esta utilizando a funcao
	
	
	SD2->(DbSetOrder(3))
	SD2->(MsSeek(xFilial("SD2")+cDoc+cSerie+cClient+cCliLoja))
	
	Do While SD2->(!Eof()) .And. SD2->(D2_FILIAL+D2_DOC+D2_SERIE+D2_CLIENTE+D2_LOJA)==(cFilSD2+SF2->(F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA))
		
		MaFisAdd(SD2->D2_COD	,;	// 1-Codigo do Produto ( Obrigatorio )
		SD2->D2_TES		,;	// 2-Codigo do TES ( Opcional )
		SD2->D2_QUANT	,;	// 3-Quantidade ( Obrigatorio )
		SD2->D2_QUANT	,;	// 4-Preco Unitario ( Obrigatorio )
		SD2->D2_DESC	,;	// 5-Valor do Desconto ( Opcional )
		Nil				,;	// 6-Numero da NF Original ( Devolucao/Benef )
		Nil		   		,;	// 7-Serie da NF Original ( Devolucao/Benef )
		Nil				,;	// 8-RecNo da NF Original no arq SD1/SD2
		0		   		,;	// 9-Valor do Frete do Item ( Opcional )
		0				,;	// 10-Valor da Despesa do item ( Opcional )
		0				,;	// 11-Valor do Seguro do item ( Opcional )
		0				,;	// 12-Valor do Frete Autonomo ( Opcional )
		SD2->(D2_QUANT*D2_PRCVEN)		,;	// 13-Valor da Mercadoria ( Obrigatorio )
		0				,;	// 14-Valor da Embalagem ( Opiconal )
		0				,;	// 15-RecNo do SB1
		0				)	// 16-RecNo do SF4
		
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
ฑฑบPrograma  ณNCVTEX05  บAutor  ณMicrosiga           บ Data ณ  08/10/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
