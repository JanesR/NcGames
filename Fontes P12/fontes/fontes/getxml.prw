#INCLUDE "PROTHEUS.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "COLORS.CH"
#INCLUDE "RPTDEF.CH"
#INCLUDE "FWPrintSetup.ch"

Static Function GetXML(cIdEnt,aIdNFe,cModalidade)

Local cURL       := PadR(GetNewPar("MV_SPEDURL","http://localhost:8080/sped"),250)
Local oWS
Local cRetorno   := ""
Local cProtocolo := ""
Local cRetDPEC   := ""
Local cProtDPEC  := ""
Local nX         := 0
Local nY         := 0
Local nL		 := 0
Local aRetorno   := {}
Local aResposta  := {}
Local aFalta     := {}
Local aExecute   := {}
Local nLenNFe
Local nLenWS
Local cDHRecbto  := ""
Local cDtHrRec   := ""
Local cDtHrRec1	 := ""
Local nDtHrRec1  := 0
Local lFlag      := .T.
Local dDtRecib	:=	CToD("")

Private oDHRecbto

If Empty(cModalidade)
	oWS := WsSpedCfgNFe():New()
	oWS:cUSERTOKEN := "TOTVS"
	oWS:cID_ENT    := cIdEnt
	oWS:nModalidade:= 0
	oWS:_URL       := AllTrim(cURL)+"/SPEDCFGNFe.apw"
	If oWS:CFGModalidade()
		cModalidade    := SubStr(oWS:cCfgModalidadeResult,1,1)
	Else
		cModalidade    := ""
	EndIf
EndIf
oWS:= WSNFeSBRA():New()
oWS:cUSERTOKEN        := "TOTVS"
oWS:cID_ENT           := cIdEnt
oWS:oWSNFEID          := NFESBRA_NFES2():New()
oWS:oWSNFEID:oWSNotas := NFESBRA_ARRAYOFNFESID2():New()
nLenNFe := Len(aIdNFe)
For nX := 1 To nLenNFe
	aadd(aRetorno,{"","",aIdNfe[nX][4]+aIdNfe[nX][5],"","","",CToD("")})
	aadd(oWS:oWSNFEID:oWSNotas:oWSNFESID2,NFESBRA_NFESID2():New())
	Atail(oWS:oWSNFEID:oWSNotas:oWSNFESID2):cID := aIdNfe[nX][4]+aIdNfe[nX][5]
Next nX
oWS:nDIASPARAEXCLUSAO := 0
oWS:_URL := AllTrim(cURL)+"/NFeSBRA.apw"

If oWS:RETORNANOTASNX()
	If Len(oWs:oWSRETORNANOTASNXRESULT:OWSNOTAS:OWSNFES5) > 0
		For nX := 1 To Len(oWs:oWSRETORNANOTASNXRESULT:OWSNOTAS:OWSNFES5)
			cRetorno        := oWs:oWSRETORNANOTASNXRESULT:OWSNOTAS:OWSNFES5[nX]:oWSNFE:CXML
			cProtocolo      := oWs:oWSRETORNANOTASNXRESULT:OWSNOTAS:OWSNFES5[nX]:oWSNFE:CPROTOCOLO
			cDHRecbto  		:= oWs:oWSRETORNANOTASNXRESULT:OWSNOTAS:OWSNFES5[nX]:oWSNFE:CXMLPROT
			If ValType(oWs:OWSRETORNANOTASNXRESULT:OWSNOTAS:OWSNFES5[nX]:OWSDPEC)=="O"
				cRetDPEC        := oWs:oWSRETORNANOTASNXRESULT:OWSNOTAS:OWSNFES5[nX]:oWSDPEC:CXML
				cProtDPEC       := oWs:oWSRETORNANOTASNXRESULT:OWSNOTAS:OWSNFES5[nX]:oWSDPEC:CPROTOCOLO
			EndIf
			//Tratamento para gravar a hora da transmissao da NFe
			If !Empty(cProtocolo)
				oDHRecbto		:= XmlParser(cDHRecbto,"","","")
				cDtHrRec		:= IIf(Type("oDHRecbto:_ProtNFE:_INFPROT:_DHRECBTO:TEXT")<>"U",oDHRecbto:_ProtNFE:_INFPROT:_DHRECBTO:TEXT,"")
				nDtHrRec1		:= RAT("T",cDtHrRec)
				
				If nDtHrRec1 <> 0
					cDtHrRec1   :=	SubStr(cDtHrRec,nDtHrRec1+1)
					dDtRecib	:=	SToD(StrTran(SubStr(cDtHrRec,1,AT("T",cDtHrRec)-1),"-",""))
				EndIf
				dbSelectArea("SF2")
				dbSetOrder(1)
				If MsSeek(xFilial("SF2")+aIdNFe[nX][5]+aIdNFe[nX][4]+aIdNFe[nX][6]+aIdNFe[nX][7])
					If SF2->(FieldPos("F2_HORA"))<>0 .And. Empty(SF2->F2_HORA)
						RecLock("SF2")
						SF2->F2_HORA := cDtHrRec1
						MsUnlock()
					EndIf
				EndIf
				dbSelectArea("SF1")
				dbSetOrder(1)
				If MsSeek(xFilial("SF1")+aIdNFe[nX][5]+aIdNFe[nX][4]+aIdNFe[nX][6]+aIdNFe[nX][7])
					If SF1->(FieldPos("F1_HORA"))<>0 .And. Empty(SF1->F1_HORA)
						RecLock("SF1")
						SF1->F1_HORA := cDtHrRec1
						MsUnlock()
					EndIf
				EndIf
			EndIf
			nY := aScan(aIdNfe,{|x| x[4]+x[5] == SubStr(oWs:oWSRETORNANOTASNXRESULT:OWSNOTAS:OWSNFES5[nX]:CID,1,Len(x[4]+x[5]))})
			If nY > 0
				aRetorno[nY][1] := cProtocolo
				aRetorno[nY][2] := cRetorno
				aRetorno[nY][4] := cRetDPEC
				aRetorno[nY][5] := cProtDPEC
				aRetorno[nY][6] := cDtHrRec1
				aRetorno[nY][7] := dDtRecib
				
				aadd(aResposta,aIdNfe[nY])
			EndIf
			cRetDPEC := ""
			cProtDPEC:= ""
		Next nX
		For nX := 1 To Len(aIdNfe)
			If aScan(aResposta,{|x| x[4] == aIdNfe[nX,04] .And. x[5] == aIdNfe[nX,05] })==0
				aadd(aFalta,aIdNfe[nX])
			EndIf
		Next nX
		If Len(aFalta)>0
			aExecute := GetXML(cIdEnt,aFalta,@cModalidade)
		Else
			aExecute := {}
		EndIf
		For nX := 1 To Len(aExecute)
			nY := aScan(aRetorno,{|x| x[3] == aExecute[nX][03]})
			If nY == 0
				aadd(aRetorno,{aExecute[nX][01],aExecute[nX][02],aExecute[nX][03]})
			Else
				aRetorno[nY][01] := aExecute[nX][01]
				aRetorno[nY][02] := aExecute[nX][02]
			EndIf
		Next nX
	EndIf
Else
	Aviso("DANFE",IIf(Empty(GetWscError(3)),GetWscError(1),GetWscError(3)),{"OK"},3)
EndIf

Return(aRetorno)

Static Function ConvDate(cData)

Local dData
cData  := StrTran(cData,"-","")
dData  := Stod(cData)
Return PadR(StrZero(Day(dData),2)+ "/" + StrZero(Month(dData),2)+ "/" + StrZero(Year(dData),4),15)