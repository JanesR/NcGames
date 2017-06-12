#INCLUDE "TBICONN.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "RPTDEF.CH"
#INCLUDE "FWPrintSetup.ch"
#INCLUDE "msgraphi.ch"
#INCLUDE "APWIZARD.CH"
#Define Enter Chr(13)+Chr(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR_TRANSF  ºAutor  ³Janes R	       º Data ³  03/05/17   º±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
user Function PrTRFDanf(cFilNota,cNota,cSerieNf,cCliente,cCliLoja,cNome,cTPIMP,cPrinter,lViewPDF,lSavePDF)

	Local aAreatu	:= GetArea()
	local cCodEmp := FWCodEmp()
	local cFilAtu := cFilAnt
	Local nTentativa:= 3

	Local cDirDanfe	:= "C:\relatorios" //Alltrim(U_MyNewSX6("NCG_000081","C:\relatorios","C","Diretorio onde a Danfe será salva","","",.F. ))
	Local cPathPDF	:= cDirDanfe+"\"
	Local cEndArq	:= "DANFE\"
	Local cDirSystem:= GetTempPath()
	local cCodEmp := FWCodEmp()
	Local lOKWebService
	Local cModalidade
	Local cVersao
	Local cVersaoDpec

	Local lAdjustToLegacy
	Local lDisableSetup

	Local oPrinter
	Local oPrinter2
	Local oWS

	Default lViewPDF := .T.
	Default lSavePDF := .F.

	Private cIdEnt
	Private cUrl	:= AllTrim(PadR(GetNewPar("MV_SPEDURL","http://"),250))


	//RpcSetType(3)
	//RpcSetEnv(cCodEmp,cFilNota)
	cEmpAnt := cCodEmp
	cFilAnt := cFilNota
	cNumEmp := cCodEmp+cFilNota
	cModulo := "FAT"
	nModulo := 5
	OpenSM0(cEmpAnt+cFilAnt)
	OpenFile(cEmpAnt+cFilAnt)

	If !Empty(cNota)

		If !IsReady()
			msgAlert("Não foi possibel gerar a nota","não foi possivel")
			restaArea(aArea)
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
			msgAlert("Não foi possibel gerar a nota","não foi possivel")
			restaArea(aArea)
			Return
		EndIf

		If !Empty(cIdEnt)

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Obtem o ambiente de execucao do Totvs Services SPED                     ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

			oWS := WsSpedCfgNFe():New()
			oWS:cUSERTOKEN 		:= "TOTVS"
			oWS:cID_ENT    		:= cIdEnt
			oWS:nAmbiente  		:= 0
			oWS:_URL       		:= AllTrim(cURL)+"/SPEDCFGNFe.apw"
			lOKWebService 		:= oWS:CFGAMBIENTE()
			cAmbiente 			:= oWS:cCfgAmbienteResult

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Obtem a modalidade de execucao do Totvs Services SPED                   ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

			If lOKWebService
				oWS:cUSERTOKEN 	:= "TOTVS"
				oWS:cID_ENT    	:= cIdEnt
				oWS:nModalidade	:= 0
				oWS:cModelo	   	:= "55"
				oWS:_URL       	:= AllTrim(cURL)+"/SPEDCFGNFe.apw"
				lOKWebService 	:= oWS:CFGModalidade()
				cModalidade    	:= oWS:cCfgModalidadeResult
			EndIf

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Obtem a versao de trabalho da NFe do Totvs Services SPED                ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

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

		if !(Select ("SF2") > 0)
			DbSelectArea("SF2")
		EndIf

		SF2->(DbSetOrder(1))//F2_FILIAL+F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA+F2_FORMUL+F2_TIPO
		If SF2->(MsSeek(cFilNota+cNota+cSerieNf+cCliente+cCliLoja))

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
					ElseIf Left(cStatus,3)=="014" //014 - NFe não autorizada
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

					/*cNameArq := SF2->F2_DOC;
					+	Alltrim(Str(Randomize(00,10)));
					+	Alltrim(Str(Randomize(11,20)));
					+	Alltrim(Str(Randomize(21,30)));
					+	Alltrim(Str(Randomize(31,40)));
					+	Alltrim(Str(Randomize(41,50)));
					+	Alltrim(Str(Randomize(51,60)));
					+ ".REL"
					*/

					cNameArq := cNome+".rel""

					lAdjustToLegacy := .F.
					lDisableSetup  := .T.

					do Case
						//DANFE
						case cTPIMP == "1"
						oPrinter	:= FWMSPrinter():New(cNameArq,IMP_PDF,lAdjustToLegacy,/*cPathInServer*/,lDisableSetup,.F.,Nil,/*cPrinter*/,.T.,.F.,.F.,lViewPDF)
						case cTPIMP == "2"
						//oPrinter	:= FWMSPrinter():New(cNameArq,IMP_SPOOL,lAdjustToLegacy,/*cPathInServer*/,lDisableSetup,.F.,Nil,/*cPrinter*/,.T.,.F.,.F.,lViewPDF)
						oPrinter2	:= FWMSPrinter():New(cNameArq,IMP_SPOOL,lAdjustToLegacy,cDirSystem + cEndArq,.T.,.F.,Nil,cPrinter,.T.,.F.,.F.,.F.,001)
						case cTPIMP == "3"
						oPrinter	:= FWMSPrinter():New(cNameArq,IMP_PDF,lAdjustToLegacy,/*cPathInServer*/,lDisableSetup,.F.,Nil,/*cPrinter*/,.T.,.F.,.F.,lViewPDF)
						oPrinter2	:= FWMSPrinter():New(cNameArq,IMP_SPOOL,lAdjustToLegacy,cDirSystem + cEndArq,.T.,.F.,Nil,cPrinter,.T.,.F.,.F.,.F.,001)
					endCase

					Pergunte(Padr("NFSIGW",Len(SX1->X1_GRUPO)),.F.)

					MV_PAR01 := SF2->F2_DOC
					MV_PAR02 := SF2->F2_DOC
					MV_PAR03 := SF2->F2_SERIE
					MV_PAR04 := 2	//Nota de Saida
					MV_PAR05 := 2	//Danfe Simplificado?
					MV_PAR06 := 2	//Imprime no verso?


					if oPrinter != nil
						oPrinter:SetResolution(78)
						oPrinter:SetPortrait()
						oPrinter:SetPaperSize(DMPAPER_A4)
						oPrinter:SetMargin(60,60,60,60)
						oPrinter:cPathPDF := cPathPDF + cEndArq
						U_PrtNfeSef(cIdEnt,/*cVal1*/,/*cVal2*/,oPrinter,/*oSetup*/,cNameArq)
					endif

					if oPrinter2 != nil .And. !(empty(cPrinter))

						oPrinter2:lServer 		:= .F.
						oPrinter2:lInJob 		:= .T.
						oPrinter2:lViewPDF 	:= .F.
						oPrinter2:SetResolution(78)
						oPrinter2:SetPortrait()
						oPrinter2:SetPaperSize(DMPAPER_A4)
						oPrinter2:SetMargin(60,60,60,60)

						U_PrtNfeSef(cIdEnt,/*cVal1*/,/*cVal2*/,oPrinter2,/*oSetup*/,cNameArq)
					endif

					oPrinter:=Nil
					oPrinter2:=Nil

					If !lSavePDF
						FErase(cDirSystem + cEndArq + cNameArq) 
						//Else
						//MsgAlert("Nota fiscal: "+cNameArq+" salva no caminho "+cPathPDF + cEndArq + cNameArq )
					EndIf

				EndIf
			EndIf
		EndIf
	Else

		MsgAlert("Não existe nota fiscal")

	EndIf

	if select ("SF2") >0
		DbCloseArea("SF2")
	endif

	OpenSM0(cEmpAnt+cFilAtu)
	OpenFile(cEmpAnt+cFilAtu)

	RestArea(aAreatu)
Return

Static Function IsReady(cURL,nTipo,lHelp)
	local aArea := GetArea()
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
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Verifica se o servidor da Totvs esta no ar                              ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
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
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Verifica se o certificado digital ja foi transferido                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
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
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Verifica se o certificado digital ja foi transferido                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If nTipo == 2 .And. lRetorno
		oWs:cUserToken := "TOTVS"
		oWs:cID_ENT    := GetIdEnt()
		oWS:_URL := AllTrim(cURL)+"/SPEDCFGNFe.apw"
		If oWs:CFGStatusCertificate()
			If Len(oWs:oWSCFGSTATUSCERTIFICATERESULT:OWSDIGITALCERTIFICATE) > 0
				For nX := 1 To Len(oWs:oWSCFGSTATUSCERTIFICATERESULT:OWSDIGITALCERTIFICATE)
					If oWs:oWSCFGSTATUSCERTIFICATERESULT:OWSDIGITALCERTIFICATE[nx]:DVALIDTO-30 <= Date()

						//Aviso("SPED","O certificado digital irá vencer em: "+Dtoc(oWs:oWSCFGSTATUSCERTIFICATERESULT:OWSDIGITALCERTIFICATE[nX]:DVALIDTO),{"Ok"},3) //"O certificado digital irá vencer em: "

					EndIf
				Next nX
			EndIf
		EndIf
	EndIf
	restArea(aArea)
Return(lRetorno)


Static Function GetIdEnt(lHelp)
	Local aArea  := GetArea()
	Local cIdEnt := ""
	Local oWs
	Default lHelp:=.F.

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Obtem o codigo da entidade                                              ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
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

Static Function GetStatus(oRetorno)
	local aArea := GetArea()
	Local cRecomendacao:="ERRO. Não foi possivel identificar o erro. Verifque via Monitor NFE"

	For nX := 1 To Len(oRetorno:oWSMONITORNFE)
		oXml := oRetorno:oWSMONITORNFE[nX]
		cRecomendacao:=oXml:CRECOMENDACAO
	Next nX
	restArea(aArea)
Return cRecomendacao