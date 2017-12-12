#Include 'Protheus.Ch'
#Include 'TopConn.Ch'
#Include 'TbiConn.Ch'
#Include 'XMLXFUN.Ch'
#Include 'TOTVS.Ch'
#INCLUDE 'RWMAKE.CH'
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'
#INCLUDE "TOTVS.CH"
#include "Fileio.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ NC_IMPNFE   ºAutor  ³  Janes Raulino  º Data ³  14/10/2013 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Rotina de Importação de XMl de nota fiscal eletrônica      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³    Nc Games                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/


User Function IMPNFE01()

Local aArea 			:= GetArea()
Private nCombo1
Private nCombo2
Private aItensOp1:={"","COMPRA","DEVOLUÇÃO"}
Private aItensOp2:={"","DEVOLUÇÃO"}

Private cDirPadr    	:= "C:\notas-xml\"
Private cDirErro		:= "C:\notas-xml-erro\"
Private cDirProces	:= "C:\notas-xml-processadas\"

IF !(EXISTDIR(cDirPadr))
	MakeDir(cDirPadr)
EndIF

IF !(EXISTDIR(cDirErro))
	MakeDir(cDirErro)
EndIF

IF !(EXISTDIR(cDirProces))
	MakeDir(cDirProces)
EndIF


SetPrvt("oDlg1","oSay1","oSay2","oCombo1","oCombo2","oBtn1","oCloseBTN")

oDlg1      := MSDialog():New( 091,232,247,521,"Importação de Notas em XML",,,.F.,,,,,,.T.,,,.T. )
oSay1      := TSay():New( 008,008,{||"Tipo Fornecedor:"},oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,044,008)
oSay2      := TSay():New( 028,008,{||"Tipo NF:"},oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)

oCombo1    := TComboBox():New( 008,056,{|u| If(PCount()>0,nCombo1:=u,nCombo1)},{"COMPRA","DEVOLUCAO"},072,010,oDlg1,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nCombo1 )
oCombo2    := TComboBox():New( 028,056,{|u| If(PCount()>0,nCombo2:=u,nCombo2)},{"FORNECEDOR","CLIENTE"},072,010,oDlg1,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nCombo2 )

//oCombo1    := TComboBox():New( 028,056,{|u| If(PCount()>0,nCombo1:=u,nCombo1)},{"","COMPRA","DEVOLUÇÃO"},072,010,oDlg1,,,,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nCombo1 )
//oCombo2    := TComboBox():New( 008,056,{|u| If(PCount()>0,nCombo2:=u,nCombo2)},{"","FORNECEDOR","CLIENTE"},072,010,oDlg1,,{|| iif(nCombo2 == "FORNECEDOR", oCombo1:SetItems(aItensOp1), oCombo1:SetItems(aItensOp2))},,CLR_BLACK,CLR_WHITE,.T.,,"",,,,,,,nCombo2 )


oBtn1      := TButton():New( 052,092,"OK",oDlg1,{||oDlg1:END(), Processa( {|| buscaXML()} )},037,012,,,,.T.,,"",,,,.F. )
oCloseBTN  := TButton():New( 052,048,"CANCELAR",oDlg1,{||oDlg1:END()},037,012,,,,.T.,,"",,,,.F. )

oDlg1:Activate(,,,.T.)

RestArea(aArea)
Return

Static Function buscaXML()
Local aArea 		:= GetArea()
Local aDiretorio
Local cEndOri := ""
Local cBuffer := ""
Local tagsXML :=""
Private arquivo :=""
Private arqName :=""
Private oXML
Public cError      := ""
Public cWarning    := ""


cEndOri:= cGetFile( '*.xml' , 'NOTAS (XML)', 1, cDirPadr, .T., nOR( GETF_LOCALHARD, GETF_RETDIRECTORY,GETF_NETWORKDRIVE ),.F., .T. )
                                          
If Empty(cEndOri)
   MsgAlert("Nenhum arquivo selecionado! O processo será finalizado!","Arquivo Vazio!")
   Return
ENDIF

aDiretorio := Directory(cEndOri+ "*.xml")

If(Len(aDiretorio)>0)
	ProcRegua( Len(aDiretorio) )
	For nA:=1 To Len(aDiretorio)
		IncProc( 'Processando Arquivo: ' + aDiretorio[nA][1] )
		arqName := aDiretorio[nA][1]
		arquivo := cEndOri + arqName
		
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
	Next
Else
	ApMsgAlert( 'Não existem notas no local informado!')
EndIf

MsgInfo("Processamento Finalizado!"," Processamento ")

RestArea(aArea)
Return


Static Function ProcXML()
Local aArea := GetArea()

IF!(Type("oXML:_NFEPROC:_NFE") == "O")
	Alert("Formato do XML invalido. Contate Suporte.Arquivo: "+arquivo+". Falta TAG <NFEPROC>.")
	frename( arquivo , cDirErro + aDiretorio[nX][1])
	RestArea(aArea)
	RETURN
ENDIF

Private aCabSF1 	:= {}
Private aItensD1	:= {}
Private cCNPJ		:= oXML:_NFEPROC:_NFE:_INFNFE:_EMIT:_CNPJ:TEXT
Private cNF			:= oXML:_NFEPROC:_NFE:_INFNFE:_IDE:_NNF:TEXT
Private cSERIE		:=	oXML:_NFEPROC:_NFE:_INFNFE:_IDE:_SERIE:TEXT
Private dEmissao	:= oXML:_NFEPROC:_NFE:_INFNFE:_IDE:_DHEMI:TEXT
Private cNomeCli
Private forn
Private loja
Private cond
Private uf
Private aCoBrw1 := {}
Private aHoBrw1 := {}
Private noBrw1  := 0

aCabSF1 := CabNota()

If (LEN(aCabSF1) > 0)
	ProcItens()
EndIf

RestArea(aArea)
Return

Static Function CabNota()
Local aArea 			:= GetArea()
Local cAliasQry     	:= GetNextAlias()
Local cAliasQry2    	:= GetNextAlias()
Local cAlias03     	:= SF1->(GetArea())
Local aCab           :={}
Local	ok := .F.
Local tpNota
Private cA7FORN := SuperGetMV("MV_A7NFORN",.F.,"")

IF!(Type("oXML:_NFEPROC:_NFE") == "O")
	Alert("Formato do XML invalido!")
	frename( arquivo , cDirProces + arqName)
	RETURN 0
ENDIF

if nCombo2 == "CLIENTE"
	
	If Select(cAliasQry) > 0
		(cAliasQry)->(DbCloseArea())
	EndIf
	
	cQuery01:="SELECT A1_NOME ,A1_COD, A1_LOJA, A1_CGC, A1_COND, A1_EST FROM "+RetSqlName("SA1")+" WHERE A1_CGC = '"+cCNPJ+"'"
	cQuery01 := ChangeQuery(cQuery01)
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery01),cAliasQry,.T.,.T.)
	
	IF (!empty((cAliasQry)->A1_CGC))
		cNomeCli :=(cAliasQry)->A1_NOME
		forn 	 :=(cAliasQry)->A1_COD
		loja 	 :=(cAliasQry)->A1_LOJA
		cond 	 :=(cAliasQry)->A1_COND
		uf	 	 :=(cAliasQry)->A1_EST
		ok 		:= .T.
	ENDIF
	(cAliasQry)->(DbCloseArea())
	
else
	
	If Select(cAliasQry2) > 0
		(cAliasQry2)->(DbCloseArea())
	EndIf
	
	cQuery02:="SELECT A2_NOME ,A2_COD, A2_LOJA, A2_CGC, A2_COND, A2_EST FROM "+RetSqlName("SA2")+" WHERE A2_CGC = '"+cCNPJ+"'"
	cQuery02 := ChangeQuery(cQuery02)
	DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery02),cAliasQry2,.T.,.T.)
	
	IF (!empty((cAliasQry2)->A2_CGC))
		cNomeCli :=(cAliasQry2)->A2_NOME
		forn 	 :=(cAliasQry2)->A2_COD
		loja 	 :=(cAliasQry2)->A2_LOJA
		cond 	 :=(cAliasQry2)->A2_COND
		uf	 	 :=(cAliasQry2)->A2_EST
		ok 	 	 := .T.
	EndIF
	(cAliasQry2)->(DbCloseArea())
endif

IF (ok == .F.)
	ALERT("Fornecedor/Cliente Não Localizado")
	frename( arquivo , cDirProces + arqName)
	RestArea(aArea)
	Return
ENDIF

IIF(nCombo1 == "COMPRA",tpNota := "N",tpNota := "D")

MHoBrw1()
   
SF1->(dbSetOrder(1))

If !SF1->( dbSeek( xFilial("SF1") + StrZero(Val(cNF), 9) + Padr( cSERIE, 3) + forn + loja + tpNota ) )
	
	
	AAdd(aCab,{"F1_TIPO"		,tpNota		   			   			,Nil})
	AAdd(aCab,{"F1_FORMUL"	,"N"    	   			   				,Nil})
	AAdd(aCab,{"F1_DOC"		,StrZero(Val(cNF), 9)					,Nil})
	AAdd(aCab,{"F1_SERIE"	,cSerie										,Nil})
	AAdd(aCab,{"F1_EMISSAO"	,STOD(Replace(dEmissao, "-", ""))	,Nil})
	AAdd(aCab,{"F1_FORNECE"	,forn											,Nil})
	AAdd(aCab,{"F1_LOJA"		,loja											,Nil})
	AAdd(aCab,{"F1_ESPECIE"	,"SPED"										,Nil})
	AAdd(aCab,{"F1_CHVNFE"	,""											,Nil})
Else
	ApMsgAlert( 'Nota: '+ StrZero(Val(cNF), 9) + " Serie: " + Padr( cSERIE, 3) + "já está no sistema!")
	frename( arquivo , cDirProces + arqName)
	RestArea(aArea)
	Return aCab
EndIf
dbCloseArea(cAlias03)

RestArea(cAlias03)

RestArea(aArea)
Return aCab


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NC_IMPNFE ºAutor  ³Microsiga           º Data ³  08/10/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function ProcItens()
Local aArea := GetArea()
Local cAliasSB1 :="SB1"
Local cAliasSA5 :="SA5"
Local cAliasSA7 :="SA7"
Local cQuery	 :=""
Local aLinha	 :={}
Local aItensSD1 :={}
Local nItens
Local bProd
Local aRespB1 	:= {}
Local aProduto := {}
Local cBlqProd := ""
Local cProd 	:= ""
Local prodNE 	:= .F.
Private cA7FORN := SuperGetMV("MV_A7NFORN",.F.,"")
Private semProdCad := .F.
Private qtd
Private vuni
Private vTot

IF(Type("oXML:_NFEPROC:_NFE:_INFNFE:_DET") == "A")
	nItens := LEN(oXML:_NFEPROC:_NFE:_INFNFE:_DET)
ELSEIF(Type("oXML:_NFEPROC:_NFE:_INFNFE:_DET") == "O")
	nItens := 1
ENDIF

//ProcRegua(nItens)
For nX:=1 To nItens
//	IncProc( 'Processando Item ' + Str(nX) + " de " + Str(nItens) + " itens.")
	
	IF !(nItens == 1)
		qtd   := iiF(VALTYPE(oXML:_NFEPROC:_NFE:_INFNFE:_DET[nX]:_PROD:_QCOM) 	== "O",oXML:_NFEPROC:_NFE:_INFNFE:_DET[nX]:_PROD:_QCOM:TEXT	,"")
		vuni  := iiF(VALTYPE(oXML:_NFEPROC:_NFE:_INFNFE:_DET[nX]:_PROD:_VUNCOM) 	== "O",oXML:_NFEPROC:_NFE:_INFNFE:_DET[nX]:_PROD:_VUNCOM:TEXT,"")
		vTot  := iiF(VALTYPE(oXML:_NFEPROC:_NFE:_INFNFE:_DET[nX]:_PROD:_VPROD) 	== "O",oXML:_NFEPROC:_NFE:_INFNFE:_DET[nX]:_PROD:_VPROD:TEXT	,"")
		bProd := iiF(VALTYPE(oXML:_NFEPROC:_NFE:_INFNFE:_DET[nX]:_PROD:_CEAN) 	== "O",oXML:_NFEPROC:_NFE:_INFNFE:_DET[nX]:_PROD:_CEAN:TEXT	,"")
	ELSE
		qtd   := iiF(VALTYPE(oXML:_NFEPROC:_NFE:_INFNFE:_DET:_PROD:_QCOM) 	== "O",oXML:_NFEPROC:_NFE:_INFNFE:_DET:_PROD:_QCOM:TEXT		,"")
		vuni  := iiF(VALTYPE(oXML:_NFEPROC:_NFE:_INFNFE:_DET:_PROD:_VUNCOM) == "O",oXML:_NFEPROC:_NFE:_INFNFE:_DET:_PROD:_VUNCOM:TEXT	,"")
		vTot  := iiF(VALTYPE(oXML:_NFEPROC:_NFE:_INFNFE:_DET:_PROD:_VPROD) 	== "O",oXML:_NFEPROC:_NFE:_INFNFE:_DET:_PROD:_VPROD:TEXT	,"")
		bProd := iiF(VALTYPE(oXML:_NFEPROC:_NFE:_INFNFE:_DET:_PROD:_CEAN) 	== "O",oXML:_NFEPROC:_NFE:_INFNFE:_DET:_PROD:_CEAN:TEXT		,"")
	ENDIF
	
	
	If !(Empty(bProd))
		aRespB1 := buscaB1(nX, bProd , .T.)
		If !(Len(aRespB1)== 0)
			AAdd(aProduto , aRespB1)
			Loop
		EndIf
	EndIF
	
	If (nCombo2 == "CLIENTE" .Or. (forn $ cA7FORN) .Or. cCNPJ == "01455929000330")
		If Select(cAliasSA7) > 0
			(cAliasSA7)->(DbCloseArea())
		EndIf
		
		cQuery := "SELECT A7_CODCLI,A7_CLIENTE,A7_LOJA,A7_FILIAL,A7_DESCCLI,A7_PRODUTO FROM "+RetSqlName("SA7") +CRLF
		IF !(nItens == 1)
			
			if (forn $ cA7FORN .And. !(cCNPJ == "01455929000330"))
				cQuery += " WHERE A7_CODCLI = '"+M->(oXML:_NFEPROC:_NFE:_INFNFE:_DET[nX]:_PROD:_CPROD:TEXT)+"' "+CRLF
				cQuery += " AND A7_CLIENTE = '000000' "+CRLF
				cQuery += " AND A7_LOJA = '01' "+CRLF
				
			ELSEIF cCNPJ == "01455929000330"
				cQuery += " WHERE A7_PRODUTO = '"+M->(oXML:_NFEPROC:_NFE:_INFNFE:_DET[nX]:_PROD:_CPROD:TEXT)+"' "+CRLF
				cQuery += " AND A7_CLIENTE = '000000' "+CRLF
				cQuery += " AND A7_LOJA = '01' "+CRLF
			Else
				cQuery += " WHERE A7_PRODUTO = '"+M->(oXML:_NFEPROC:_NFE:_INFNFE:_DET[nX]:_PROD:_CPROD:TEXT)+"' "+CRLF
				cQuery += " AND A7_CLIENTE = '"+forn+"' "+CRLF
				cQuery += " AND A7_LOJA = '"+loja+"' "+CRLF
				
			ENDIF
		ELSE
			
			if (forn $ cA7FORN)
				cQuery += " WHERE A7_CODCLI = '"+M->(oXML:_NFEPROC:_NFE:_INFNFE:_DET:_PROD:_CPROD:TEXT)+"' "+CRLF
				cQuery += " AND A7_CLIENTE = '000000' "+CRLF
				cQuery += " AND A7_LOJA = '01' "+CRLF
				
			ELSEIF cCNPJ == "01455929000330"
				cQuery += " WHERE A7_PRODUTO = '"+M->(oXML:_NFEPROC:_NFE:_INFNFE:_DET:_PROD:_CPROD:TEXT)+"' "+CRLF
				cQuery += " AND A7_CLIENTE = '000000' "+CRLF
				cQuery += " AND A7_LOJA = '01' "+CRLF
			else
				cQuery += " WHERE A7_CODCLI = '"+M->(oXML:_NFEPROC:_NFE:_INFNFE:_DET:_PROD:_CPROD:TEXT)+"' "+CRLF
				cQuery += " AND A7_CLIENTE = '"+forn+"' "+CRLF
				cQuery += " AND A7_LOJA = '"+loja+"' "+CRLF
			ENDIF
		ENDIF
		
		cQuery := ChangeQuery(cQuery)
		dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSA7,.T.,.T.)
		
		if !(forn $ cA7FORN) .Or. !(cCNPJ == "01455929000330")
			cProd :=((cAliasSA7)->A7_PRODUTO)
		ELSEIF cCNPJ == "01455929000330"
			cProd :=((cAliasSA7)->A7_CODCLI)
		ELSE
			cProd :=((cAliasSA7)->A7_PRODUTO)
		ENDIF
		
		If !EMPTY(cProd)
			aRespB1 := buscaB1(nX, cProd , .F.)
			If !(Len(aRespB1) == 0)
				AAdd(aProduto , aRespB1)
				Loop
			Else
				//Alert("Não foi encontrado o produto " + cProd + " no cadastro de produtos!")
				cBlqProd += cProd + CRLF
				semProdCad := .T.
			EndIf
		Else
			MCoBrw1(forn, loja,(oXML:_NFEPROC:_NFE:_INFNFE:_DET[nX]:_PROD:_CPROD:TEXT), nX)
			prodNE := .T.
		EndIF
	EndIf
	
	If (nCombo2 == "FORNECEDOR" .And. !(cCNPJ == "01455929000330"))
		
		cQuery := "SELECT A5_CODPRF,A5_FORNECE,A5_LOJA,A5_FILIAL,A5_NOMPROD,A5_PRODUTO FROM "+RetSqlName("SA5") +CRLF
		IF !(nItens == 1)
			cQuery += " WHERE A5_CODPRF = '"+M->(oXML:_NFEPROC:_NFE:_INFNFE:_DET[nX]:_PROD:_CPROD:TEXT)+"' "+CRLF
		ELSE
			cQuery += " WHERE A5_CODPRF = '"+M->(oXML:_NFEPROC:_NFE:_INFNFE:_DET:_PROD:_CPROD:TEXT)+"' "+CRLF
		ENDIF
		cQuery += " AND A5_FORNECE = '"+forn+"' "+CRLF
		cQuery += " AND A5_LOJA = '"+loja+"' "+CRLF
		cQuery += " AND A5_FILIAL = '"+xFilial("SA5")+"' "+CRLF
		cQuery += " AND D_E_L_E_T_ = ' ' "+CRLF
		
		cQuery := ChangeQuery(cQuery)
		
		If Select(cAliasSA5) > 0
			(cAliasSA5)->(DbCloseArea())
		EndIf
		dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSA5,.T.,.T.)
		
		cProd := (cAliasSA5)->A5_PRODUTO
		
		If !EMPTY(cProd)
			aRespB1 := buscaB1(nX, cProd , .F.)
			If !(Len(aRespB1) == 0)
				AAdd(aProduto , aRespB1)
				Loop
			Else
				//Alert("Não foi encontrado o produto " + cProd + " no cadastro de produtos!")
				cBlqProd += cProd + CRLF
				semProdCad := .T.
				Loop
			EndIf
		Else
			MCoBrw1(forn,loja,(oXML:_NFEPROC:_NFE:_INFNFE:_DET[nX]:_PROD:_CPROD:TEXT),nX)
			prodNE := .T.
		EndIF
	EndIf
	
	
Next

If prodNE
	validProdu(aHoBrw1,aCoBrw1,noBrw1,forn,loja,cNomeCli,StrZero(Val(cNF), 9))
	RestArea(aArea)
	Return
Else
	For nY :=1 to Len(aProduto)
		If !(aProduto[nY][8] == "2")
			AAdd(aLinha,{"D1_ITEM"		, nY							,".T."})
			AAdd(aLinha,{"D1_COD"		, aProduto[nY][1]			,".T."})
			AAdd(aLinha,{"D1_UM"			, aProduto[nY][3]			,".T."})
			AAdd(aLinha,{"D1_SEGUM"		, aProduto[nY][4]			,".T."})
			AAdd(aLinha,{"D1_QUANT"		, VAL(aProduto[nY][5])	,".T."})
			AAdd(aLinha,{"D1_VUNIT"		, VAL(aProduto[nY][6])	,".T."})
			AAdd(aLinha,{"D1_TOTAL"		, VAL(aProduto[nY][7])	,".T."})
			AAdd(aLinha,{"D1_LOCAL"		, "03"						,".T."})
			AAdd(aItensSD1,aLinha)
		Else
			cBlqProd += aProduto[nY][1] + CRLF
		EndIf
	Next
	
	If (Len(cBlqProd) == 0) .And. !semProdCad
		If !(EMPTY(aCabSF1) .And. !EMPTY(aItensSD1))
			MSExecAuto({|x,y,z| MATA140(x,y,z)}, aCabSF1, aItensSD1,3)
			aCabSF1 	 	:= {}
			aItemSD1 :={}
		EndIf
	Else
		//MsgInfo("Os seguintes produtos estão bloqueados ou não foram encontrados:" + CRLF + cBlqProd," Produtos Bloqueados! ")
		PrdNotEnc(cBlqProd)
		cBlqProd :={}
	EndIf
	
EndIF

RestArea(aArea)
Return

Static Function buscaB1(item, produto , EAN)
Local aArea 	 := GetArea()
Local cAliaSB1 := "SB1"
Local aDadosB1	 := {}
Local cQuery 	 :=""

If Select(cAliaSB1) > 0
	(cAliaSB1)->(DbCloseArea())
EndIf

cQuery := "SELECT B1_COD, B1_DESC, B1_SEGUM, B1_UM, B1_MSBLQL FROM  "+RetSqlName("SB1")
IIF(EAN, cQuery +=" WHERE B1_CODBAR = '"+produto+"'", cQuery +=" WHERE B1_COD = '"+produto+"'")
cQuery := ChangeQuery(cQuery)
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliaSB1,.T.,.T.)

IF !Empty((cAliaSB1)->B1_COD)
	AAdd(aDadosB1, (cAliaSB1)->B1_COD ) //1
	AAdd(aDadosB1, (cAliaSB1)->B1_DESC )//2
	AAdd(aDadosB1, (cAliaSB1)->B1_UM )  //3
	AAdd(aDadosB1, (cAliaSB1)->B1_SEGUM )//4
	AAdd(aDadosB1, qtd )                 //5
	AAdd(aDadosB1, vuni )                //6
	AAdd(aDadosB1, vTot )                //7
	AAdd(aDadosB1, (cAliaSB1)->B1_MSBLQL )//8
EndIf

If Select(cAliaSB1) > 0
	(cAliaSB1)->(DbCloseArea())
EndIf

RestArea(aArea)
Return aDadosB1



Static Function MHoBrw1()

Local aArea := GetArea()


if nCombo2 == "CLIENTE"
	DbSelectArea("SX3")
	DbSetOrder(1)
	DbSeek("SA7")
	
	IF  !(noBrw1 == 0)
		noBrw1 := 0
	ENDIF
	
	If len(aHoBrw1) > 0
		RestArea(aArea)
		Return
	EndIf
	
	While SX3->(!Eof()) .and. (SX3->X3_ARQUIVO == "SA7")
		If X3Uso(SX3->X3_USADO) .and. cNivel >= SX3->X3_NIVEL
			If (trim(SX3->X3_CAMPO) == "A7_CLIENTE")
				noBrw1++
				Aadd(aHoBrw1,{Trim(X3Titulo()),;
				SX3->X3_CAMPO,;
				SX3->X3_PICTURE,;
				SX3->X3_TAMANHO,;
				SX3->X3_DECIMAL,;
				"",;
				"",;
				SX3->X3_TIPO,;
				"",;
				"" } )
			ElseIf (trim(SX3->X3_CAMPO) == "A7_LOJA")
				noBrw1++
				Aadd(aHoBrw1,{Trim(X3Titulo()),;
				SX3->X3_CAMPO,;
				SX3->X3_PICTURE,;
				SX3->X3_TAMANHO,;
				SX3->X3_DECIMAL,;
				"",;
				"",;
				SX3->X3_TIPO,;
				"",;
				"" } )
			ElseIf (trim(SX3->X3_CAMPO) == "A7_PRODUTO")
				noBrw1++
				Aadd(aHoBrw1,{Trim(X3Titulo()),;
				SX3->X3_CAMPO,;
				SX3->X3_PICTURE,;
				SX3->X3_TAMANHO,;
				SX3->X3_DECIMAL,;
				"",;
				"",;
				SX3->X3_TIPO,;
				"",;
				"" } )
			ElseIf (trim(SX3->X3_CAMPO) == "A7_CODCLI")
				noBrw1++
				Aadd(aHoBrw1,{Trim(X3Titulo()),;
				SX3->X3_CAMPO,;
				SX3->X3_PICTURE,;
				SX3->X3_TAMANHO,;
				SX3->X3_DECIMAL,;
				"",;
				"",;
				SX3->X3_TIPO,;
				"",;
				"" } )
			ElseIf (trim(SX3->X3_CAMPO) == "A7_DESCCLI")
				noBrw1++
				Aadd(aHoBrw1,{Trim(X3Titulo()),;
				SX3->X3_CAMPO,;
				SX3->X3_PICTURE,;
				SX3->X3_TAMANHO,;
				SX3->X3_DECIMAL,;
				"",;
				"",;
				SX3->X3_TIPO,;
				"",;
				"" } )
			ElseIf (trim(SX3->X3_CAMPO) == "A7_PRECO01")
				noBrw1++
				Aadd(aHoBrw1,{Trim(X3Titulo()),;
				SX3->X3_CAMPO,;
				SX3->X3_PICTURE,;
				SX3->X3_TAMANHO,;
				SX3->X3_DECIMAL,;
				"",;
				"",;
				SX3->X3_TIPO,;
				"",;
				"" } )
			EndIf
		EndIf
		SX3->(DbSkip())
	EndDo
	
	dbclosearea("SX3")
	
Else
	
	DbSelectArea("SX3")
	DbSetOrder(1)
	DbSeek("SA5")
	
	IF  !(noBrw1 == 0)
		noBrw1 := 0
	ENDIF
	
	If len(aHoBrw1) > 0
		RestArea(aArea)
		Return
	EndIf
	
	While SX3->(!Eof()) .and. (SX3->X3_ARQUIVO == "SA5")
		If X3Uso(SX3->X3_USADO) .and. cNivel >= SX3->X3_NIVEL
			If (trim(SX3->X3_CAMPO) == "A5_FORNECE")
				noBrw1++
				Aadd(aHoBrw1,{Trim(X3Titulo()),;
				SX3->X3_CAMPO,;
				SX3->X3_PICTURE,;
				SX3->X3_TAMANHO,;
				SX3->X3_DECIMAL,;
				"",;
				"",;
				SX3->X3_TIPO,;
				"",;
				"" } )
				
			ElseIf (trim(SX3->X3_CAMPO) == "A5_LOJA")
				noBrw1++
				Aadd(aHoBrw1,{Trim(X3Titulo()),;
				SX3->X3_CAMPO,;
				SX3->X3_PICTURE,;
				SX3->X3_TAMANHO,;
				SX3->X3_DECIMAL,;
				"",;
				"",;
				SX3->X3_TIPO,;
				"",;
				"" } )
			ElseIf (trim(SX3->X3_CAMPO) == "A5_PRODUTO")
				
				noBrw1++
				Aadd(aHoBrw1,{Trim(X3Titulo()),;
				SX3->X3_CAMPO,;
				SX3->X3_PICTURE,;
				SX3->X3_TAMANHO,;
				SX3->X3_DECIMAL,;
				"",;
				"",;
				SX3->X3_TIPO,;
				"",;
				"" } )
				
				
			ElseIf (trim(SX3->X3_CAMPO) == "A5_CODPRF")
				noBrw1++
				Aadd(aHoBrw1,{Trim(X3Titulo()),;
				SX3->X3_CAMPO,;
				SX3->X3_PICTURE,;
				SX3->X3_TAMANHO,;
				SX3->X3_DECIMAL,;
				"",;
				"",;
				SX3->X3_TIPO,;
				"",;
				"" } )
				
			ElseIf (trim(SX3->X3_CAMPO) == "A5_NOMPROD")
				noBrw1++
				Aadd(aHoBrw1,{Trim(X3Titulo()),;
				SX3->X3_CAMPO,;
				SX3->X3_PICTURE,;
				SX3->X3_TAMANHO,;
				SX3->X3_DECIMAL,;
				"",;
				"",;
				SX3->X3_TIPO,;
				"",;
				"" } )
				
			ElseIf (trim(SX3->X3_CAMPO) == "A5_PRECO01")
				noBrw1++
				Aadd(aHoBrw1,{Trim(X3Titulo()),;
				SX3->X3_CAMPO,;
				SX3->X3_PICTURE,;
				SX3->X3_TAMANHO,;
				SX3->X3_DECIMAL,;
				"",;
				"",;
				SX3->X3_TIPO,;
				"",;
				"" } )
			EndIF
			
		EndIf
		SX3->(DbSkip())
	EndDo
	
	dbclosearea("SX3")
	
endif

RestArea(aArea)
Return

Static Function MCoBrw1(forn,loja, bProd ,item)

Local aArea := GetArea()
Local aAux := {}
Local descPro
Local pVen
Local uCom
Local proCli
Local nPosArq
Local aDados

IF(VALTYPE(oXML:_NFEPROC:_NFE:_INFNFE:_DET) == "O")
	proCli := M->(oXML:_NFEPROC:_NFE:_INFNFE:_DET:_PROD:_CPROD:TEXT)
	descPro:= M->oXML:_NFEPROC:_NFE:_INFNFE:_DET:_PROD:_XPROD:TEXT
	pVen  :=M->oXML:_NFEPROC:_NFE:_INFNFE:_DET:_PROD:_VUNCOM:TEXT
	uCom  := M->oXML:_NFEPROC:_NFE:_INFNFE:_DET:_PROD:_UCOM:TEXT
ELSE
	proCli := M->(oXML:_NFEPROC:_NFE:_INFNFE:_DET[item]:_PROD:_CPROD:TEXT)
	descPro:= M->oXML:_NFEPROC:_NFE:_INFNFE:_DET[item]:_PROD:_XPROD:TEXT
	pVen  := M->oXML:_NFEPROC:_NFE:_INFNFE:_DET[item]:_PROD:_VUNCOM:TEXT
	uCom  := M->oXML:_NFEPROC:_NFE:_INFNFE:_DET[item]:_PROD:_UCOM:TEXT
ENDIF

aDados:={}

if nCombo2 == "CLIENTE" .Or. (forn $ cA7FORN) .Or. (cCNPJ == "01455929000330")
	
	DbSelectArea("SX3")
	SX3->(DbSetOrder(1))
	SX3->(DbSeek("SA7"))
	While SX3->(!Eof()) .and. (SX3->X3_ARQUIVO == "SA7")
		If X3Uso(SX3->X3_USADO) .and. cNivel >= SX3->X3_NIVEL
			cCampo := SX3->X3_CAMPO
			If (nPosArq := aScan(aHoBrw1,{|x| AllTrim(Upper(x[2]))== alltrim(cCampo)})) > 0
				If (ALLTRIM(cCampo) == "A7_CLIENTE")
					AADD(aDados, forn)
				ElseIf (ALLTRIM(cCampo) == "A7_LOJA")
					AADD(aDados, loja)
				ElseIf (ALLTRIM(cCampo) == "A7_PRODUTO")
					AADD(aDados, space(15))
				ElseIf (ALLTRIM(cCampo) == "A7_CODCLI")
					AADD(aDados, proCli)
				ElseIf (ALLTRIM(cCampo) == "A7_DESCCLI")
					AADD(aDados, descPro)
				ElseIf (ALLTRIM(cCampo) == "A7_PRECO01")
					AADD(aDados,VAL(pVen))
				ElseIf (ALLTRIM(cCampo) == "A7_DTREF01")
					AADD(aDados,msdate())
				Else
					AADD(aDados,criavar(cCampo))
				EndIf
			EndIf
			
		EndIf
		SX3->(DbSkip())
	EndDo
	
else
	
	DbSelectArea("SX3")
	SX3->(DbSetOrder(1))
	SX3->(DbSeek("SA5"))
	
	While SX3->(!Eof()) .and. (SX3->X3_ARQUIVO == "SA5")
		If X3Uso(SX3->X3_USADO) .and. cNivel >= SX3->X3_NIVEL
			cCampo := trim(SX3->X3_CAMPO)
			If (nPosArq := aScan(aHoBrw1,{|x| AllTrim(Upper(x[2]))== alltrim(cCampo)})) > 0
				If (ALLTRIM(cCampo) == "A5_FORNECE")
					AADD(aDados,M->forn)
				ElseIf (ALLTRIM(cCampo) == "A5_LOJA")
					AADD(aDados,M->loja)
				ElseIf (ALLTRIM(cCampo) == "A5_PRODUTO")
					AADD(aDados,criavar(cCampo))
				ElseIf (ALLTRIM(cCampo) == "A5_CODPRF")
					AADD(aDados,bProd)
				ElseIf (ALLTRIM(cCampo) == "A5_NOMPROD")
					AADD(aDados,descPro)
				ElseIf (ALLTRIM(cCampo) == "A5_PRECO01")
					AADD(aDados,VAL(pVen))
				Else
					AADD(aDados,criavar(cCampo))
				EndIf
			EndIf
			
		EndIf
		SX3->(DbSkip())
	EndDo
	
	
endif

AADD(aDados,.F.)
aadd(aCoBrw1,aClone(aDados))
aDados	:={}

RestArea(aArea)
Return

Static Function validProdu(aHoBrw1,aCoBrw1,noBrw1,forn,loja,cliente,nf)

Local aArea := GetArea()
Local okProd
Local nOpc := GD_INSERT+GD_DELETE+GD_UPDATE
Local Retorno := .F.
Local FecJane
Private aHeader
Private aCols


/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Declaração de Variaveis Private dos Objetos                             ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
SetPrvt("oDlgv","oSay1","oSay2","oSay3","oSay4","oSay5","oSay6","oSay7","oSay8","oSay9","oBrw1","oBtn1","oBtn2")


/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Definicao do Dialog e todos os seus componentes.                        ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
oDlgv      := MSDialog():New( 091,232,689,1234,"Produtos não Validados!!",,,.F.,,,,,,.T.,,,.T. )
oSay1      := TSay():New( 012,012,{||"Fornecedor:"},oDlgv,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay2      := TSay():New( 012,048,{||""+forn+""},oDlgv,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay3      := TSay():New( 012,088,{||"Loja:"},oDlgv,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,016,008)
oSay4      := TSay():New( 012,108,{||""+loja+""},oDlgv,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay5      := TSay():New( 012,148,{||"Nome:"},oDlgv,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,020,008)
oSay6      := TSay():New( 012,176,{||""+cliente+""},oDlgv,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,152,008)
oSay7      := TSay():New( 012,336,{||"NF:"},oDlgv,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,012,008)
oSay8      := TSay():New( 012,352,{||""+nf+""},oDlgv,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
oSay9      := TSay():New( 272,012,{||"Produtos não Encontrados: "+Str(LEN(aCoBrw1))+""},oDlgv,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,500,008)

oBrw1      := MsNewGetDados():New(028,008,264,484,nOpc,'AllwaysTrue()','AllwaysTrue()','',,0,200,'AllwaysTrue()','','AllwaysTrue()',oDlgv,aHoBrw1,aCoBrw1)
oBtn1      := TButton():New( 272,384,"OK",oDlgv,{||VldClixPrd(LEN(aCoBrw1)),Retorno := .T.},037,012,,,,.T.,,"",,,,.F. )


ACTIVATE MSDIALOG oDlgv CENTERED

RestArea(aArea)
Return  Retorno

Static Function VldClixPrd(nlinhas)
Local aArea := GetArea()
Local lOk := .F.
Local NUM :=0
Local NUM2 :=0
Local a7Alias := "SA7"
Local a5Alias := "SA5"
Local nPosCli	:= ""
Local nPosLj 	:= ""
Local nPosProd	:= ""
Local nPosCdCl	:= ""
Local nPosDesc	:= ""
Local nPosPrec	:= ""
Local nPosDtRf	:= ""


if nCombo2 == "CLIENTE"
	
	nPosCli	:= aScan(aHoBrw1,{|x| Alltrim(x[2]) == "A7_CLIENTE"})
	nPosLj 	:= aScan(aHoBrw1,{|x| Alltrim(x[2]) == "A7_LOJA"})
	nPosProd	:= aScan(aHoBrw1,{|x| Alltrim(x[2]) == "A7_PRODUTO"})
	nPosCdCl	:= aScan(aHoBrw1,{|x| Alltrim(x[2]) == "A7_CODCLI"})
	nPosDesc	:= aScan(aHoBrw1,{|x| Alltrim(x[2]) == "A7_DESCCLI"})
	nPosPrec	:= aScan(aHoBrw1,{|x| Alltrim(x[2]) == "A7_PRECO01"})
	nPosDtRf	:= aScan(aHoBrw1,{|x| Alltrim(x[2]) == "A7_DTREF01"})
	
	
else
	
	nPosCli	:= aScan(aHoBrw1,{|x| Alltrim(x[2]) == "A5_FORNECE"})
	nPosLj 	:= aScan(aHoBrw1,{|x| Alltrim(x[2]) == "A5_LOJA"})
	nPosProd	:= aScan(aHoBrw1,{|x| Alltrim(x[2]) == "A5_PRODUTO"})
	nPosCdCl	:= aScan(aHoBrw1,{|x| Alltrim(x[2]) == "A5_CODPRF"})
	nPosDesc	:= aScan(aHoBrw1,{|x| Alltrim(x[2]) == "A5_NOMPROD"})
	nPosPrec	:= aScan(aHoBrw1,{|x| Alltrim(x[2]) == "A5_PRECO01"})
	
endif


FOR NUM := 1 TO nlinhas
	
	IF empty(oBrw1:aCols[NUM][nPosProd])
		lOk := .T.
	ENDIF
next


IF lOk
	
	Alert("Existem Produtos em Branco, preencha os campos para continuar o processo!")
	Return
Else
	
	IF nCombo2 == "CLIENTE"
		FOR NUM2 := 1 TO nlinhas
			
			dbSelectArea("SA7")
//			dbSetOrder(1)
			
			SA7->(RECLOCK("SA7",.T.))
			SA7->A7_FILIAL  := xFilial("SA7")
			SA7->A7_CLIENTE	:= oBrw1:aCols[NUM2][nPosCli]
			SA7->A7_LOJA	:= oBrw1:aCols[NUM2][nPosLj]
			SA7->A7_PRODUTO	:= oBrw1:aCols[NUM2][nPosProd]
			SA7->A7_CODCLI	:= oBrw1:aCols[NUM2][nPosCdCl]
			SA7->A7_DESCCLI	:= oBrw1:aCols[NUM2][nPosDesc]
			SA7->A7_PRECO01	:= oBrw1:aCols[NUM2][nPosPrec]
			SA7->A7_DTREF01	:= oBrw1:aCols[NUM2][nPosDtRf]
			SA7->(MSUNLOCK())
			
			dbCloseArea("SA7")
			
			If Select(a7Alias) > 0
				(a7Alias)->(DbCloseArea())
			EndIf
			
		next
		
	else
		FOR NUM2 := 1 TO nlinhas
			dbSelectArea("SA5")
			dbSetOrder(1)
			
			SA5->(RECLOCK("SA5",.T.))
			SA5->A5_FILIAL  := xFilial("SA5")
			SA5->A5_FORNECE	:= oBrw1:aCols[NUM2][nPosCli]
			SA5->A5_LOJA	:= oBrw1:aCols[NUM2][nPosLj]
			SA5->A5_PRODUTO	:= oBrw1:aCols[NUM2][nPosProd]
			SA5->A5_CODPRF	:= oBrw1:aCols[NUM2][nPosCdCl]
			SA5->A5_NOMPROD	:= oBrw1:aCols[NUM2][nPosDesc]
			SA5->A5_PRECO01	:= oBrw1:aCols[NUM2][nPosPrec]
			SA5->(MSUNLOCK())
			
			dbCloseArea("SA5")
			
			If Select(a5Alias) > 0
				(a5Alias)->(DbCloseArea())
			EndIf
		NEXT
	endif
	Alert("A janela será fechada e a nota deverá ser reprocessada!")
	Return oDlg1:END()
ENDIF

RestArea(aArea)
Return

Static Function PrdNotEnc(texto)
Local aArea := GetArea()
Private cTexto1 := texto

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Declaração de Variaveis Private dos Objetos                             ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
SetPrvt("oDlgp","oSay1","oMGet1","okBTN")

/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±± Definicao do Dialog e todos os seus componentes.                        ±±
Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
oDlgp      := MSDialog():New( 091,232,500,618,"Produtos Bloqueados/Não entrontrados",,,.F.,,,,,,.T.,,,.T. )
oSay1      := TSay():New( 008,012,{||"Os seguintes produtos estão bloqueados ou não foram encontrados:"},oDlgp,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,168,008)
oMGet1     := TMultiGet():New( 020,004,{|u| If(PCount()>0,cTexto1:=u,cTexto1)},oDlgp,176,152,,,CLR_BLACK,CLR_WHITE,,.T.,"",,,.F.,.F.,.F.,,,.F.,,  )
okBTN      := TButton():New( 180,140,"Ok",oDlgp,{|| oDlgp:END()},037,012,,,,.T.,,"",,,,.F. )

oDlgp:Activate(,,,.T.)

RestArea(aArea)
Return
