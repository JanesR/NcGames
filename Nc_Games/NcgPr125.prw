#Include 'Protheus.ch'
#INCLUDE "RPTDEF.CH"
#INCLUDE "FWPRINTSETUP.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNOVO8     บAutor  ณMicrosiga           บ Data ณ  04/29/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function Ncgpr125(cNumPv,lViewPDF,lSavePDF)

Local aAreaAtu  := GetArea()
Local aAreaSC5  := SC5->(GetArea())
Local aAreaSC6  := SC6->(GetArea())
Local aAreaSF2  := SF2->(GetArea())

Local cNota 	:= ""
Local cSerie 	:= ""
Local cCli		:= ""
Local cLoja		:= ""

Default lViewPDF := .T. //Visualiza Danfe
Default cNumPv := ""

If !Empty(cNumPv)
	SC6->(DbSetOrder(1))
	If SC6->(MsSeek(xFilial("SC6")+cNumPv))
		Do While SC6->(!EoF()) .And. SC6->C6_FILIAL+SC6->C6_NUM  == xFilial("SC6")+cNumPv
			If !Empty(SC6->(C6_NOTA))
				cNota 	:= SC6->(C6_NOTA)
				cSerie 	:= SC6->(C6_SERIE)
				cCli	:= SC6->(C6_CLI)
				cLoja	:= SC6->(C6_LOJA)
				Exit
			EndIf
			SC6->(DbSkip())
		EndDo
		
		If !Empty(cNota)
			LJMsgRun("Aguarde o processamento...","Aguarde...",{|| Pr125Danf(cNota, cSerie, cCli, cLoja,lViewPDF)})
		Else
			MsgAlert("Nota fiscal nใo encontrada")
		EndIf
	EndIf
EndIf


RestArea(aAreaSF2)
Return


//------------------------------------------------------------------------------------------
/*/{Protheus.doc} Ec11Danfe
// Fun็ใo que irแ imprimir a Danfe dos pedidos Ecommerce diretamente no monitor Ticket#4148
//
// @author    Lucas Felipe
// @version   1.00
// @since     12/02/2015
/*/
//------------------------------------------------------------------------------------------
Static Function Pr125Danf(cNota,cSerieNf,cCliente,cCliLoja,lViewPDF,lSavePDF)

Local aAreatu	:= GetArea()
Local aAreaSF2	:= SF2->(GetArea())

Local nTentativa:= 3

Local cDirDanfe	:= "C:\relatorios" //Alltrim(U_MyNewSX6("NCG_000081","C:\relatorios","C","Diretorio onde a Danfe serแ salva","","",.F. ))
Local cPathPDF	:= cDirDanfe+"\"
Local cEndArq	:= "DANFE\"
Local cDirSystem:= GetTempPath()

Local lOKWebService
Local cModalidade
Local cVersao
Local cVersaoDpec

Local lAdjustToLegacy
Local lDisableSetup

Local oPrinter
Local oWS

Default lViewPDF := .T.
Default lSavePDF := .F.

Private cIdEnt
Private cUrl	:= AllTrim(PadR(GetNewPar("MV_SPEDURL","http://"),250))

If !Empty(cNota)
	
	If !IsReady()
		Return
	EndIf
	
	If Right(cDirSystem,1) <> "\"
		cDirSystem += "\"
	EndIf
	
	If !lSavePDF
		MakeDir(cDirSystem + cEndArq)
	Else
		MakeDir(cPathPDF+ cEndArq)
	EndIf
	
	If Empty( cIdEnt:=GetIdEnt() )
		Return
	EndIf
	
	If !Empty(cIdEnt)
		
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณObtem o ambiente de execucao do Totvs Services SPED                     ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		
		oWS := WsSpedCfgNFe():New()
		oWS:cUSERTOKEN 		:= "TOTVS"
		oWS:cID_ENT    		:= cIdEnt
		oWS:nAmbiente  		:= 0
		oWS:_URL       		:= AllTrim(cURL)+"/SPEDCFGNFe.apw"
		lOKWebService 		:= oWS:CFGAMBIENTE()
		cAmbiente 			:= oWS:cCfgAmbienteResult
		
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณObtem a modalidade de execucao do Totvs Services SPED                   ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		
		If lOKWebService
			oWS:cUSERTOKEN 	:= "TOTVS"
			oWS:cID_ENT    	:= cIdEnt
			oWS:nModalidade	:= 0
			oWS:cModelo	   	:= "55"
			oWS:_URL       	:= AllTrim(cURL)+"/SPEDCFGNFe.apw"
			lOKWebService 	:= oWS:CFGModalidade()
			cModalidade    	:= oWS:cCfgModalidadeResult
		EndIf
		
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณObtem a versao de trabalho da NFe do Totvs Services SPED                ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		
		If lOKWebService
			oWS:cUSERTOKEN 	:= "TOTVS"
			oWS:cID_ENT    	:= cIdEnt
			oWS:cVersao    	:= "0.00"
			oWS:_URL       	:= AllTrim(cURL)+"/SPEDCFGNFe.apw"
			lOKWebService  	:= oWS:CFGVersao()
			cVersao        	:= oWS:cCfgVersaoResult
		EndIf
		
		If lOKWebService
			oWS:cUSERTOKEN 	:= "TOTVS"
			oWS:cID_ENT    	:= cIdEnt
			oWS:cVersao    	:= "0.00"
			oWS:_URL       	:= AllTrim(cURL)+"/SPEDCFGNFe.apw"
			lOKWebService	:= oWS:CFGVersaoDpec()
			cVersaoDpec	   	:= oWS:cCfgVersaoDpecResult
		EndIf
		
	Endif
	
	SF2->(DbSetOrder(1))//F2_FILIAL+F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA+F2_FORMUL+F2_TIPO
	If SF2->(MsSeek(xFilial("SF2")+cNota+cSerieNf+cCliente+cCliLoja))
		
		oWS:= WSNFeSBRA():New()
		oWS:cUSERTOKEN := "TOTVS"
		oWS:cID_ENT    := cIdEnt
		oWS:_URL       := AllTrim(cURL)+"/NFeSBRA.apw"
		
		If lOKWebService
			
			lPrinter:=.F.
			nContar	:= 1
			
			IncProc("Verificando Status Sefaz Nota: "+SF2->F2_DOC+"(Tentativa "+StrZero(nContar,2)+" de "+StrZero(nTentativa,2)+")" )
			
			oWS:cIdInicial := SF2->F2_SERIE+SF2->F2_DOC
			oWS:cIdFinal   := SF2->F2_SERIE+SF2->F2_DOC
			
			Do While ++nContar<nTentativa
				IncProc("Verificando Status Sefaz Nota: "+SF2->F2_DOC+"(Tentativa "+StrZero(nContar,2)+" de "+StrZero(nTentativa,2)+")" )
				
				lOk 		:= oWS:MONITORFAIXA()
				oRetorno 	:= oWS:oWsMonitorFaixaResult
				cStatus		:= GetStatus(oRetorno)
				
				If Left(cStatus,3)=="001"
					lPrinter:=.T.;Exit
				ElseIf Left(cStatus,3)=="014" //014 - NFe nใo autorizada
					lPrinter:=.F.;Exit
				ElseIf "029 - Falha no Schema do XML"$cStatus
					lPrinter:=.F.;Exit
				ElseIf Left(cStatus,4)=="ERRO"
					lPrinter:=.F.;Exit
				EndIf
				
				Sleep(3000)
			EndDo
			
			If lPrinter
				
				IncProc("Imprimindo DANFE Nota  "+SF2->F2_DOC)
				
				cNameArq := SF2->F2_DOC;
				+	Alltrim(Str(Randomize(00,10)));
				+	Alltrim(Str(Randomize(11,20)));
				+	Alltrim(Str(Randomize(21,30)));
				+	Alltrim(Str(Randomize(31,40)));
				+	Alltrim(Str(Randomize(41,50)));
				+	Alltrim(Str(Randomize(51,60)));
				+ ".REL"
				
				lAdjustToLegacy := .F.
				lDisableSetup  := .T.
				
				//oPrinter := FWMsPrinter():New(cNameArq,IMP_PDF,.F.,,.T.,.F.,Nil,,.T.,.F.,.F.,.F.,001)
				oPrinter	:= FWMSPrinter():New(cNameArq,IMP_PDF,lAdjustToLegacy,/*cPathInServer*/,lDisableSetup,.F.,Nil,/*cPrinter*/,.T.,.F.,.F.,lViewPDF)
				
				oPrinter:SetResolution(78)
				oPrinter:SetPortrait()
				oPrinter:SetPaperSize(DMPAPER_A4)
				oPrinter:SetMargin(60,60,60,60)
				oPrinter:cPathPDF := cPathPDF + cEndArq
				
				Pergunte(Padr("NFSIGW",Len(SX1->X1_GRUPO)),.F.)
				
				MV_PAR01 := SF2->F2_DOC
				MV_PAR02 := SF2->F2_DOC
				MV_PAR03 := SF2->F2_SERIE
				MV_PAR04 := 2	//Nota de Saida
				MV_PAR05 := 2	//Danfe Simplificado?
				MV_PAR06 := 2	//Imprime no verso?
				
				U_PrtNfeSef(cIdEnt,/*cVal1*/,/*cVal2*/,oPrinter,/*oSetup*/,cNameArq)
				
				oPrinter:=Nil
				
				If !lSavePDF
					FErase(cDirSystem + cEndArq + cNameArq) 
				Else
					Alert("Nota fiscal: "+cNameArq+" salva no caminho "+cPathPDF + cEndArq + cNameArq )
				EndIf
				
			EndIf
		EndIf
	EndIf
Else
	
	MsgAlert("Nใo existe nota fiscal")
	
EndIf


RestArea(aAreaSF2)
RestArea(aAreatu)

Return .T.
//------------------------------------------------------------------------------------------
/*/{Protheus.doc} IsReady
// Fun็ใo que irแ conectar com Sped para a confirma็ใo que o servi็o estแ ativo
//
// Fun็ใo utilizada no programa NcgPr118(GATI)
//
// @author    Lucas Felipe
// @version   1.00
// @since     12/02/2015
/*/
//------------------------------------------------------------------------------------------

Static Function IsReady(cURL,nTipo,lHelp)
Local nX       := 0
Local cHelp    := ""
Local oWS
Local lRetorno := .F.

Default nTipo := 1
Default lHelp := .F.

If !Empty(cURL) .And. !PutMV("MV_SPEDURL",cURL)
	RecLock("SX6",.T.)
	SX6->X6_FIL     := xFilial( "SX6" )
	SX6->X6_VAR     := "MV_SPEDURL"
	SX6->X6_TIPO    := "C"
	SX6->X6_DESCRIC := "URL SPED NFe"
	MsUnLock()
	PutMV("MV_SPEDURL",cURL)
EndIf

SuperGetMv() //Limpa o cache de parametros - nao retirar

Default cURL      := PadR(GetNewPar("MV_SPEDURL","http://"),250)
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณVerifica se o servidor da Totvs esta no ar                              ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
oWs := WsSpedCfgNFe():New()
oWs:cUserToken := "TOTVS"
oWS:_URL := AllTrim(cURL)+"/SPEDCFGNFe.apw"

If oWs:CFGCONNECT()
	lRetorno := .T.
Else
	If lHelp
		//Aviso("SPED",IIf(Empty(GetWscError(3)),GetWscError(1),GetWscError(3)),{"Ok"},3)
	EndIf
	lRetorno := .F.
EndIf
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณVerifica se o certificado digital ja foi transferido                    ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If nTipo <> 1 .And. lRetorno
	oWs:cUserToken := "TOTVS"
	oWs:cID_ENT    := GetIdEnt()
	oWS:_URL := AllTrim(cURL)+"/SPEDCFGNFe.apw"
	If oWs:CFGReady()
		lRetorno := .T.
	Else
		If nTipo == 3
			cHelp := IIf(Empty(GetWscError(3)),GetWscError(1),GetWscError(3))
			If lHelp .And. !"003" $ cHelp
				//Aviso("SPED",cHelp,{"Ok"},3)
				lRetorno := .F.
			EndIf
		Else
			lRetorno := .F.
		EndIf
	EndIf
EndIf
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณVerifica se o certificado digital ja foi transferido                    ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If nTipo == 2 .And. lRetorno
	oWs:cUserToken := "TOTVS"
	oWs:cID_ENT    := GetIdEnt()
	oWS:_URL := AllTrim(cURL)+"/SPEDCFGNFe.apw"
	If oWs:CFGStatusCertificate()
		If Len(oWs:oWSCFGSTATUSCERTIFICATERESULT:OWSDIGITALCERTIFICATE) > 0
			For nX := 1 To Len(oWs:oWSCFGSTATUSCERTIFICATERESULT:OWSDIGITALCERTIFICATE)
				If oWs:oWSCFGSTATUSCERTIFICATERESULT:OWSDIGITALCERTIFICATE[nx]:DVALIDTO-30 <= Date()
					
					//Aviso("SPED","O certificado digital irแ vencer em: "+Dtoc(oWs:oWSCFGSTATUSCERTIFICATERESULT:OWSDIGITALCERTIFICATE[nX]:DVALIDTO),{"Ok"},3) //"O certificado digital irแ vencer em: "
					
				EndIf
			Next nX
		EndIf
	EndIf
EndIf

Return(lRetorno)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCECOM11  บAutor  ณMicrosiga           บ Data ณ  02/12/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function GetIdEnt(lHelp)
Local aArea  := GetArea()
Local cIdEnt := ""
Local oWs
Default lHelp:=.F.

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณObtem o codigo da entidade                                              ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
oWS := WsSPEDAdm():New()
oWS:cUSERTOKEN := "TOTVS"

oWS:oWSEMPRESA:cCNPJ       := IIF(SM0->M0_TPINSC==2 .Or. Empty(SM0->M0_TPINSC),SM0->M0_CGC,"")
oWS:oWSEMPRESA:cCPF        := IIF(SM0->M0_TPINSC==3,SM0->M0_CGC,"")
oWS:oWSEMPRESA:cIE         := SM0->M0_INSC
oWS:oWSEMPRESA:cIM         := SM0->M0_INSCM
oWS:oWSEMPRESA:cNOME       := SM0->M0_NOMECOM
oWS:oWSEMPRESA:cFANTASIA   := SM0->M0_NOME
oWS:oWSEMPRESA:cENDERECO   := FisGetEnd(SM0->M0_ENDENT)[1]
oWS:oWSEMPRESA:cNUM        := FisGetEnd(SM0->M0_ENDENT)[3]
oWS:oWSEMPRESA:cCOMPL      := FisGetEnd(SM0->M0_ENDENT)[4]
oWS:oWSEMPRESA:cUF         := SM0->M0_ESTENT
oWS:oWSEMPRESA:cCEP        := SM0->M0_CEPENT
oWS:oWSEMPRESA:cCOD_MUN    := SM0->M0_CODMUN
oWS:oWSEMPRESA:cCOD_PAIS   := "1058"
oWS:oWSEMPRESA:cBAIRRO     := SM0->M0_BAIRENT
oWS:oWSEMPRESA:cMUN        := SM0->M0_CIDENT
oWS:oWSEMPRESA:cCEP_CP     := Nil
oWS:oWSEMPRESA:cCP         := Nil
oWS:oWSEMPRESA:cDDD        := Str(FisGetTel(SM0->M0_TEL)[2],3)
oWS:oWSEMPRESA:cFONE       := AllTrim(Str(FisGetTel(SM0->M0_TEL)[3],15))
oWS:oWSEMPRESA:cFAX        := AllTrim(Str(FisGetTel(SM0->M0_FAX)[3],15))
oWS:oWSEMPRESA:cEMAIL      := UsrRetMail(RetCodUsr())
oWS:oWSEMPRESA:cNIRE       := SM0->M0_NIRE
oWS:oWSEMPRESA:dDTRE       := SM0->M0_DTRE
oWS:oWSEMPRESA:cNIT        := IIF(SM0->M0_TPINSC==1,SM0->M0_CGC,"")
oWS:oWSEMPRESA:cINDSITESP  := ""
oWS:oWSEMPRESA:cID_MATRIZ  := ""
oWS:oWSOUTRASINSCRICOES:oWSInscricao := SPEDADM_ARRAYOFSPED_GENERICSTRUCT():New()
oWS:_URL := AllTrim(cURL)+"/SPEDADM.apw"
If oWs:ADMEMPRESAS()
	cIdEnt  := oWs:cADMEMPRESASRESULT
ElseIf lHelp
	//Aviso("SPED",IIf(Empty(GetWscError(3)),GetWscError(1),GetWscError(3)),{"Ok"},3)
EndIf

RestArea(aArea)
Return(cIdEnt)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCECOM11  บAutor  ณMicrosiga           บ Data ณ  02/12/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetStatus(oRetorno)
Local cRecomendacao:="ERRO. Nใo foi possivel identificar o erro. Verifque via Monitor NFE"

For nX := 1 To Len(oRetorno:oWSMONITORNFE)
	oXml := oRetorno:oWSMONITORNFE[nX]
	cRecomendacao:=oXml:CRECOMENDACAO
Next nX

Return cRecomendacao
