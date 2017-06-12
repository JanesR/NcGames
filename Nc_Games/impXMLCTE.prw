#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'RWMAKE.CH'
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �GetIdEnt  �Autor  �Microsiga         � Data �  01/30/14     ���
�������������������������������������������������������������������������͹��
���Desc.     �IMPORTA��O CHAVE DE ACESSO CTE				              ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

user function ImpCTENC()
	Local aArea := GetArea()

	Private cDirPadr    	:= "C:\CTE-xml\"
	Private cDirErro		:= "C:\CTE-xml-erro\"
	Private cDirProces	:= "C:\CTE-xml-processadas\"

	IF !(EXISTDIR(cDirPadr))
		MakeDir(cDirPadr)
	EndIF

	IF !(EXISTDIR(cDirErro))
		MakeDir(cDirErro)
	EndIF

	IF !(EXISTDIR(cDirProces))
		MakeDir(cDirProces)
	EndIF

	MsgAlert("Por favor, certifique-se que os XMLs que deseja processa est�o na pasta!")

	Processa( {|| buscaXML()} )

	RestArea(aArea)
Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �BuscaXML  �Autor  �Microsiga         � Data �  01/30/14     ���
�������������������������������������������������������������������������͹��
���Desc.     �IMPORTA��O CHAVE DE ACESSO CTE				              ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
static function BuscaXML()
	local aArea := GetArea()
	Local aDiretorio
	Local cEndOri := ""
	Local cBuffer := ""
	Local tagsXML :=""
	Private arquivo :=""
	Private arqName :=""
	Private oXML
	Public cError      := ""
	Public cWarning    := ""

	aDiretorio := Directory(cDirPadr + "*.xml")

	if(len(aDiretorio)>0)

		ProcRegua(len(aDiretorio))

		for nA :=1 to len(aDiretorio)
			IncProc( "Processando Arquivos: " + alltrim(str(nA)) +  " de " + alltrim(str(len(aDiretorio))) )
			arqName := aDiretorio[nA][1]
			arquivo := cDirPadr + arqName
			tagsXML := ""
			FT_FUSE(arquivo)  //ABRIR XLM
			FT_FGOTOP() 		//PONTO NO TOPO
			While !FT_FEOF()  //FACA ENQUANTO NAO FOR FIM DE ARQUIVO
				cBuffer := FT_FREADLN() //LENDO LINHA
				tagsXML += cBuffer
				FT_FSKIP()   //pr?imo registro no arquivo txt
			EndDo
			FT_FUSE()

			oXML := XmlParser( tagsXML, "_", @cError, @cWarning)
			ProcXML()

			IF (FILE(arquivo))
				frename( arquivo , cDirProces + arqName)
			EndIF
		next
	else
		ApMsgAlert( 'N�o existem notas no local informado!')
	endif

	RestArea(aArea)
return

static function ProcXML()
	local aArea := GetArea()
	local cChave := ""
	local cIdEnt	:= GetIdEnt()
	local lAuto := .F.
	local cCNPJ := ""
	local cNumCTE := ""
	local cSerieCTE := ""
	local cForn :=""
	local cLojForn :=""
	local cEmissao :=""
	local cIcms :=""

	cChave := oXML:_CTEPROC:_PROTCTE:_INFPROT:_CHCTE:TEXT
	cEmissao := oXML:_CTEPROC:_CTE:_INFCTE:_IDE:_DHEMI:TEXT
	cEmissao := substr( Replace(cEmissao, "-", ""), 1, 8) 

	If(XmlChildEx ( oXml:_CTEPROC:_CTE:_INFCTE:_IMP:_ICMS ,"_ICMS00")<>Nil)
		cIcms :=  oXML:_CTEPROC:_CTE:_INFCTE:_IMP:_ICMS:_ICMS00:_PICMS:TEXT
	endif

	if( ConsNFeChave(cChave, cIdEnt) == "100")

		cCNPJ := substr(cChave,7,14)
		cSerieCTE := val(substr(cChave,23,3))
		cSerieCTE := padr(cSerieCTE,3,' ')
		cNumCte := substr(cChave,26,9)

		DbSelectArea("SA2")
		DbSetOrder(3)
		If DbSeek(xFilial("SA2")+cCNPJ)
			cForn := SA2->A2_COD
			cLojForn := SA2->A2_LOJA
		Else
			restArea(aArea)
			return
		EndIf
		DbCloseArea("SA2")

		DbSelectArea("SF1")
		DbSetOrder(1)

		if DbSeek(xFilial("SF1") + cNumCte + cSerieCTE + cForn + cLojForn)
			if !(SF1->F1_FIMP == "A")
				if RECLOCK("SF1", .F.)
					SF1->F1_CHVNFE := cChave
					SF1->F1_EMISSAO := StoD(cEmissao)
					MSUNLOCK()
				endif
			endif
		endIf
		DbCloseArea("SF1")

		DbSelectArea("SD1")
		DbSetOrder(1)

		if DbSeek(xFilial("SD1") + cNumCte + cSerieCTE + cForn + cLojForn)
			while SD1->(!EOF()) .And. SD1->D1_DOC = cNumCte
				if RECLOCK("SD1", .F.)
					if !( cIcms == "" )
						SD1->D1_PICM := VAL(cIcms)				
					endif
					MSUNLOCK()
				endif
				SD1->(DbSkip())
				Loop
			endDo
		endIf
		DbCloseArea("SD1")
	endif

	restArea(aArea)
return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �GetIdEnt  �Autor  �Microsiga         � Data �  01/30/14     ���
���Desc.     �IMPORTA��O CHAVE DE ACESSO CTE				              ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function GetIdEnt()

	Local aArea  := GetArea()
	Local cIdEnt := ""
	Local cURL   := PadR(GetNewPar("MV_SPEDURL","http://"),250)
	Local oWs
	Local lUsaGesEmp := IIF(FindFunction("FWFilialName") .And. FindFunction("FWSizeFilial") .And. FWSizeFilial() > 2,.T.,.F.)
	Local lEnvCodEmp := GetNewPar("MV_ENVCDGE",.F.)

	//������������������������������������������������������������������������Ŀ
	//�Obtem o codigo da entidade                                              �
	//��������������������������������������������������������������������������
	oWS := WsSPEDAdm():New()
	oWS:cUSERTOKEN := "TOTVS"

	oWS:oWSEMPRESA:cCNPJ       := IIF(SM0->M0_TPINSC==2 .Or. Empty(SM0->M0_TPINSC),SM0->M0_CGC,"")
	oWS:oWSEMPRESA:cCPF        := IIF(SM0->M0_TPINSC==3,SM0->M0_CGC,"")
	oWS:oWSEMPRESA:cIE         := SM0->M0_INSC
	oWS:oWSEMPRESA:cIM         := SM0->M0_INSCM
	oWS:oWSEMPRESA:cNOME       := SM0->M0_NOMECOM
	oWS:oWSEMPRESA:cFANTASIA   := IIF(lUsaGesEmp,FWFilialName(),Alltrim(SM0->M0_NOME))
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

	If lUsaGesEmp .And. lEnvCodEmp
		oWS:oWSEMPRESA:CIDEMPRESA:= FwGrpCompany()+FwCodFil()
	EndIf

	oWS:oWSOUTRASINSCRICOES:oWSInscricao := SPEDADM_ARRAYOFSPED_GENERICSTRUCT():New()
	oWS:_URL := AllTrim(cURL)+"/SPEDADM.apw"
	If oWs:ADMEMPRESAS()
		cIdEnt  := oWs:cADMEMPRESASRESULT
	Else
		cIdEnt  := ""
	EndIf

	RestArea(aArea)
Return(cIdEnt)

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �GetIdEnt  �Autor  �Microsiga         � Data �  01/30/14     ���
�������������������������������������������������������������������������͹��
���Desc.     �IMPORTA��O CHAVE DE ACESSO CTE				              ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function ConsNFeChave(cChaveNFe,cIdEnt)

	Local cURL     := PadR(GetNewPar("MV_SPEDURL","http://"),250)
	Local cMensagem:= ""
	Local oWS

	oWs:= WsNFeSBra():New()
	oWs:cUserToken   := "TOTVS"
	oWs:cID_ENT    	 := cIdEnt
	ows:cCHVNFE		 := cChaveNFe
	oWs:_URL         := AllTrim(cURL)+"/NFeSBRA.apw"

	If oWs:ConsultaChaveNFE()
		cMensagem := Alltrim(oWs:oWSCONSULTACHAVENFERESULT:cCODRETNFE)
	Else
		cMensagem := ""
	EndIf

Return cMensagem



