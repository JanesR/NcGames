
#INCLUDE "PROTHEUS.CH"
#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR100  บAutor  ณMicrosiga           บ Data ณ  01/17/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NCPR100()
	Local aCargas		:={}
	Local aExecJob		:={}
	Local cPerg			:="NCGPR100"
	Local cFiltro		:=""

	Private aRotina 	:= { }
	Private cCadastro	:="Monitor - Nota Fiscal entre Empresas "
	Private lTemSA7		:=cEmpAnt=="01"


	AAdd(aRotina,{"Pesquisar"		,"AxPesqui"		,0,1})
	AAdd(aRotina,{"Visualizar"		,"AxVisual"		,0,2})
	AAdd(aRotina,{"Transferir NF"	,"U_PR100Tranf"	,0,3})

	mBrowse( 6,1,22,75,"ZAO",,,,,,,,,,,,,,cFiltro)

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR100  บAutor  ณMicrosiga           บ Data ณ  01/17/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PR100Tranf()
	Local aAreaAtu		:=GetArea()
	Private cMarca		:= GetMark()
	Private lInverte	:= .F.

	Private oMarcar       := LoadBitmap( GetResources(), 'LBOK' )
	Private oDesmarcar    := LoadBitmap( GetResources(), 'LBNO' )
	Private oErro 	       := LoadBitmap( GetResources(), 'BR_VERMELHO' )
	Private oGravado	    := LoadBitmap( GetResources(), 'BR_VERDE' )


	Processa({ || PR100GETNV() })

	RestArea(aAreaAtu)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR100  บAutor  ณMicrosiga           บ Data ณ  01/17/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PR100GETNV()
	Local aAreaAtu	:=GetArea()
	Local aAreaSA1	:=SA1->(GetArea())
	Local aAreaSA2	:=SA2->(GetArea())
	Local aAreaSM0	:=SM0->(GetArea())
	Local cAliasQry	:=GetNextAlias()
	Local cPerg			:='_NCGPR100'
	Local nRecSF2
	Local cQuery
	Local aStructSF2:={}
	Local aStructSD2:={}
	Local aCposStru
	Local nInd
	Local cSF2NomeWork
	Local cSD2NomeWork
	Local lFoundEmp
	Local cStatus:="OK"
	Local cAliasSB1
	Local cModo:=""
	Local cCodCli:="000000"
	Local cLojaCli:="01"


	CriaSX1(cPerg)

	Do While .T.
	
		If !Pergunte(cPerg)
			Return .T.
		EndIf

	
		Exit
	
	EndDo


//validar empresa e filial
//VALIDAR ESPECIE ExistCpo("SX5","42"+M->F1_ESPECIE)

	aCposStru:={"F2_FILIAL","F2_DOC","F2_SERIE","F2_CLIENTE","F2_LOJA","F2_TIPO","F2_EMISSAO","A1_NREDUZ","A1_YFORDES","A1_YLOJDES","A2_NOME","ZAO_EMPDES","ZAO_FILDES","ZAO_ERRO","ZAO_OBS"}
	For nInd:=1 To Len(aCposStru)
		AADD(aStructSF2,{aCposStru[nInd],AvSX3(aCposStru[nInd],2),AvSX3(aCposStru[nInd],3),AvSX3(aCposStru[nInd],4)})
	Next

	AADD(aStructSF2,{"MARCA","C",2,0})
	AADD(aStructSF2,{"CHAVE","C",Len(SF2->(F2_FILIAL+F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA)),0})

	If Select("WORKSF2")>0
		WORKSF2->(DbCloseArea())
	EndIf
	cSF2NomeWork=E_CriaTrab(,aStructSF2,"WORKSF2")
	IndRegua("WORKSF2",cSF2NomeWork+OrdBagExt(),"F2_FILIAL+F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA", , , ,.F. )



	aCposStru:={"D2_FILIAL","D2_DOC","D2_SERIE","D2_CLIENTE","D2_LOJA","D2_COD","D2_LOCAL","D2_QUANT","D2_PRCVEN","D2_TOTAL","D2_TES","D2_CF","B1_XDESC","D2_ITEM"}
	For nInd:=1 To Len(aCposStru)
		AADD(aStructSD2,{aCposStru[nInd],AvSX3(aCposStru[nInd],2),AvSX3(aCposStru[nInd],3),AvSX3(aCposStru[nInd],4)})
	Next
	AADD(aStructSD2,{"PRODWM","C",AvSx3("B1_COD",3),0})

	AADD(aStructSD2,{"CHAVE","C",Len(SF2->(F2_FILIAL+F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA)),0})
	If Select("WORKSD2")>0
		WORKSD2->(DbCloseArea())
	EndIf
	cSD2NomeWork=E_CriaTrab(,aStructSD2,"WORKSD2")
	IndRegua("WORKSD2",cSD2NomeWork+OrdBagExt(),"D2_FILIAL+D2_DOC+D2_SERIE+D2_CLIENTE+D2_LOJA", , , ,.F. )


	SA1->(DbSetOrder(1))//A1_FILIAL+A1_COD+A1_LOJA


	cQuery:=" Select SF2.R_E_C_N_O_ SF2RECNO,SD2.R_E_C_N_O_ SD2RECNO,F2_FILIAL,F2_DOC,F2_SERIE,F2_CLIENTE,F2_LOJA,F2_FORMUL,F2_TIPO"+CRLF
	cQuery+=" From "+RetSqlName("SF2")+" SF2,"+RetSqlName("SD2")+" SD2"+CRLF
	cQuery+=" Where SF2.F2_FILIAL='"+xFilial("SF2")+"'"+CRLF
	cQuery+=" And SF2.F2_DOC Between '         ' And 'ZZZZZZZZZ'"+CRLF
	cQuery+=" And SF2.F2_SERIE Between ' ' And 'ZZ'"+CRLF
	cQuery+=" And SF2.F2_CLIENTE Between '"+mv_par05+"' And '"+mv_par07+"'"+CRLF
	cQuery+=" And SF2.F2_LOJA    Between '"+mv_par06+"' And '"+mv_par08+"'"+CRLF
	cQuery+=" And SF2.F2_EMISSAO Between '"+Dtos(mv_par01)+"' And '"+Dtos(mv_par02)+"'"+CRLF
	cQuery+=" And SF2.D_E_L_E_T_=' '"+CRLF

	cQuery+=" And SD2.D2_FILIAL=SF2.F2_FILIAL"+CRLF
	cQuery+=" And SD2.D2_DOC=SF2.F2_DOC"+CRLF
	cQuery+=" And SD2.D2_SERIE=SF2.F2_SERIE"+CRLF
	cQuery+=" And SD2.D2_CLIENTE=SF2.F2_CLIENTE"+CRLF
	cQuery+=" And SD2.D2_LOJA=SF2.F2_LOJA"+CRLF
	cQuery+=" And SD2.D2_CF Between '"+mv_par03+"' And '"+mv_par04+"'"+CRLF
	cQuery+=" And SD2.D_E_L_E_T_=' '"+CRLF
	cQuery+=" Order By F2_FILIAL,F2_DOC,F2_SERIE,F2_CLIENTE,F2_LOJA,F2_FORMUL,F2_TIPO"

	cQuery := ChangeQuery(cQuery)
	dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery),cAliasQry, .T., .F.)

	ProcRegua(0)

	Do While !(cAliasQry)->(Eof())
	
		SF2->(DbGoTo((cAliasQry)->SF2RECNO))
	
		IncProc("Processando Nota Fiscal:"+SF2->(F2_DOC+"/"+F2_SERIE))
		
	
		WorkSF2->(DbAppend())
		AvReplace("SF2","WORKSF2")
	
		WORKSF2->F2_FILIAL	:=SF2->F2_FILIAL
		WORKSF2->F2_DOC		:=SF2->F2_DOC
		WORKSF2->F2_SERIE	:=SF2->F2_SERIE
		WORKSF2->F2_CLIENTE	:=SF2->F2_CLIENTE
		WORKSF2->F2_LOJA	:=SF2->F2_LOJA
		WORKSF2->F2_TIPO	:=SF2->F2_TIPO
		WORKSF2->F2_EMISSAO	:=SF2->F2_EMISSAO
		WORKSF2->CHAVE		:=SF2->(F2_FILIAL+F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA)
	
		SA1->(MsSeek(xFilial("SA1")+SF2->(F2_CLIENTE+F2_LOJA) ))
		WORKSF2->ZAO_EMPDES	:=SA1->A1_YEMPDES
		WORKSF2->ZAO_FILDES	:=SA1->A1_YFILDES
	
		cErro	 :=""
		cStatus:="OK"
	
		nRecSM0:=SM0->(Recno())
		If !SM0->(MsSeek(WORKSF2->(ZAO_EMPDES+ZAO_FILDES)))
			cErro+="Empresa/Filial invalidas."
			cStatus:="ER"
		EndIf
		SM0->(DbGoTo(nRecSM0))
	
		SA1->(MsSeek(xFilial("SA1")+WorkSF2->(F2_CLIENTE+F2_LOJA) ))
		WORKSF2->A1_NREDUZ	    :=SA1->A1_NREDUZ
		WORKSF2->A1_YFORDES 	:=SA1->A1_YFORDES
		WORKSF2->A1_YLOJDES 	:=SA1->A1_YLOJDES
	
	
		If Select(cAliasSB1)>0
			(cAliasSB1)->(DbCloseArea())
		EndIf
	
		cAliasSB1:=GetNextAlias()
	
		If !Empty(WORKSF2->ZAO_EMPDES)
			EmpOpenFile(cAliasSB1,"SB1",1,.T.,WORKSF2->ZAO_EMPDES,@cModo)
		EndIf
	
		Do While !(cAliasQry)->(Eof()) .And. (cAliasQry)->(F2_FILIAL+F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA+F2_FORMUL+F2_TIPO)==SF2->(F2_FILIAL+F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA+F2_FORMUL+F2_TIPO)
			SD2->(DbGoTo((cAliasQry)->SD2RECNO))
			SB1->(MsSeek(xFilial("SB1")+SD2->D2_COD))
		
			WorkSD2->(DbAppend())
			WORKSD2->D2_FILIAL	:=SD2->D2_FILIAL
			WORKSD2->D2_DOC		:=SD2->D2_DOC
			WORKSD2->D2_SERIE	:=SD2->D2_SERIE
			WORKSD2->D2_CLIENTE	:=SD2->D2_CLIENTE
			WORKSD2->D2_LOJA	:=SD2->D2_LOJA
			WORKSD2->D2_COD		:=SD2->D2_COD
			WORKSD2->D2_ITEM	:=SD2->D2_ITEM
			WORKSD2->D2_LOCAL	:=SD2->D2_LOCAL
			WORKSD2->D2_QUANT	:=SD2->D2_QUANT
			WORKSD2->D2_PRCVEN	:=SD2->D2_PRCVEN
			WORKSD2->D2_TOTAL	:=SD2->D2_TOTAL
			WORKSD2->D2_TES		:=SD2->D2_TES
			WORKSD2->D2_CF		:=SD2->D2_CF
			WORKSD2->CHAVE		:=SD2->(D2_FILIAL+D2_DOC+D2_SERIE+D2_CLIENTE+D2_LOJA)
			WORKSD2->B1_XDESC	:=SB1->B1_XDESC
		
		
			If SB1->B1_TIPO<>"PA"
				U_NCGRAVASA7(cCodCli,cLojaCli,SB1->B1_COD,SB1->B1_XDESC,SB1->B1_COD)
			EndIf
			cProduto:=""
		
			If !lTemSA7
				cProduto:=SD2->D2_COD
			Else
				cProduto:=""
				SA7->(DbSetOrder(1)) //A7_FILIAL+A7_CLIENTE+A7_LOJA+A7_PRODUTO
				If SA7->(MsSeek(xFilial("SA7")+cCodCli+cLojaCli+SD2->D2_COD))
					cProduto:=AllTrim(SA7->A7_CODCLI)
				EndIf
		
			EndIf
		
			If Empty(cProduto)
				cErro+="Item "+SD2->D2_ITEM+" Produto "+AlLTrim(SD2->D2_COD)+" Tipo "+SB1->B1_TIPO+" nao encontrado codigo produto (SA7) WebManager"+CRLF
				cStatus:="ER"
			ElseIf  Select(cAliasSB1) >0 .And. !(cAliasSB1)->(DbSeek(xFilial("SB1")+AllTrim(cProduto)) )
				cErro+="Item "+SD2->D2_ITEM+" Produto "+AllTrim(cProduto)+"(Produto na nota  "+SD2->D2_COD+") Tipo "+SB1->B1_TIPO+" nใo encontrado no cadastro e produto(SB1) da empresa "+WORKSF2->ZAO_EMPDES+CRLF
				cStatus:="ER"
			Else
				WORKSD2->PRODWM:=cProduto
			EndIf
		
			(cAliasQry)->(DbSkip())
		EndDo
	
		WORKSF2->MARCA		:=cStatus
		WORKSF2->ZAO_OBS	:=cErro
	
		If WORKSF2->MARCA=="ER"
			WORKSF2->ZAO_ERRO:="S"
		EndIf
	
	EndDo


	PR100Tela()

	WorkSF2->(E_EraseArq(cSF2NomeWork))
	WorkSd2->(E_EraseArq(cSD2NomeWork))
	(cAliasQry)->(DbCloseArea())

	RestArea(aAreaSA2)
	RestArea(aAreaSA1)
	RestArea(aAreaAtu)
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR100  บAutor  ณMicrosiga           บ Data ณ  01/17/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PR100Tela()
	Local oDlg
	Local aSize   	:= MsAdvSize()
	Local aObjects	:= {}
	Local aInfo		:= {}
	Local aPosObj	:= {}
	Local aPosFld	:= {}
	Local aObjFld	:= {}
	Local bOk		:={|| lGravar:=.T.,oDlg:End() }
	Local bCancel	:={|| lGravar:=.F.,oDlg:End() }
	Local lGravar	:=.F.
	Local aButtons	:={}
	Local aFolder	:={"Notas Fiscais de Saํda"}
	Local aCpoSF2	:={}
	Local aCpoSD2	:={}
	Local oFolder
	Local cModo		:=""


	aSizeAut	:= MsAdvSize(,.F.,400)
	AAdd( aObjects, { 100,   100, .T., .T. } )
	AAdd( aObjects, { 100, 100, .T., .T. } )

	aInfo := { aSizeAut[ 1 ], aSizeAut[ 2 ], aSizeAut[ 3 ], aSizeAut[ 4 ], 3, 3 }
	aPosObj := MsObjSize( aInfo, aObjects )

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณCalcula o Size para os Foldersณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	Aadd( aObjFld, {   1  ,  1, .T., .T. } )
	aInfoFld := {1,1,aPosObj[2,4] - aPosObj[2,2] ,aPosObj[2,3] - aPosObj[2,1],3,3}
	aPosFld := MsObjSize( aInfoFld, aObjFld )

	nGd1 := 2
	nGd2 := 2
	nGd3 := aPosObj[1,3]-aPosObj[1,1]-15
	nGd4 := aPosObj[1,4]-aPosObj[1,2]-4


	nGd5 := aPosObj[2,1]
	nGd6 := aPosObj[2,2]
	nGd7 := aPosObj[2,3]-15
	nGd8 := aPosObj[2,4]-4


	aAdd(aButtons, {'CONTAINR'  , {|| PR100WKLEG()      }  					   , "Legenda"                 ,"Legenda"})


	aAdd( aCpoSF2, {"MARCA",," "   ,		" " } )
	aAdd( aCpoSF2, {"F2_FILIAL",,AvSx3("F2_FILIAL",5)   ,		AvSx3("F2_FILIAL",6) } )
	aAdd( aCpoSF2, {"F2_DOC",,AvSx3("F2_DOC",5)   ,		AvSx3("F2_DOC",6) } )
	aAdd( aCpoSF2, {"F2_SERIE",,AvSx3("F2_SERIE",5)   ,		AvSx3("F2_SERIE",6) } )
	aAdd( aCpoSF2, {"F2_CLIENTE",,AvSx3("F2_CLIENTE",5)   ,		AvSx3("F2_CLIENTE",6) } )
	aAdd( aCpoSF2, {"F2_LOJA",,AvSx3("F2_LOJA",5)   ,		AvSx3("F2_LOJA",6) } )
	aAdd( aCpoSF2, {"A1_NREDUZ",,"Nome Cliente"   ,		AvSx3("A1_NREDUZ",6) } )
//aAdd( aCpoSF2, {"F2_TIPO",,AvSx3("F2_TIPO",5)   ,		AvSx3("F2_TIPO",6) } )
	aAdd( aCpoSF2, {"F2_EMISSAO",,AvSx3("F2_EMISSAO",5)   ,		AvSx3("F2_EMISSAO",6) } )
	aAdd( aCpoSF2, {"ZAO_EMPDES",,AvSx3("ZAO_EMPDES",5)   ,		AvSx3("ZAO_EMPDES",6) } )
	aAdd( aCpoSF2, {"ZAO_FILDES",,AvSx3("ZAO_FILDES",5)   ,		AvSx3("ZAO_FILDES",6) } )
	aAdd( aCpoSF2, {"A1_YFORDES",,AvSx3("A1_YFORDES",5)   ,		AvSx3("A1_YFORDES",6) } )
	aAdd( aCpoSF2, {"A1_YLOJDES",,AvSx3("A1_YLOJDES",5)   ,		AvSx3("A1_YLOJDES",6) } )
	aAdd( aCpoSF2, {"A2_NOME",,"Nome Fornecedor"   ,		AvSx3("A2_NOME",6) } )
	aAdd( aCpoSF2, {"ZAO_OBS",,AvSx3("ZAO_OBS",5)   ,		AvSx3("ZAO_OBS",6) } )


//aAdd( aCpoSD2, {"D2_FILIAL",,AvSx3("D2_FILIAL",5)   ,		AvSx3("D2_FILIAL",6) } )
//aAdd( aCpoSD2, {"D2_DOC",,AvSx3("D2_DOC",5)   ,		AvSx3("D2_DOC",6) } )
//aAdd( aCpoSD2, {"D2_SERIE",,AvSx3("D2_SERIE",5)   ,		AvSx3("D2_SERIE",6) } )
//aAdd( aCpoSD2, {"D2_CLIENTE",,AvSx3("D2_CLIENTE",5)   ,		AvSx3("D2_CLIENTE",6) } )
//aAdd( aCpoSD2, {"D2_LOJA",,AvSx3("D2_LOJA",5)   ,		AvSx3("D2_LOJA",6) } )
	aAdd( aCpoSD2, {"D2_ITEM",,AvSx3("D2_ITEM",5)   ,		AvSx3("D2_ITEM",6) } )
	aAdd( aCpoSD2, {"D2_COD",,AvSx3("D2_COD",5)   ,		AvSx3("D2_COD",6) } )
	
	If lTemSA7
		aAdd( aCpoSD2, {"PRODWM",,"Produto WM"   ,		AvSx3("D2_COD",6) } )
	EndIf	
	
	aAdd( aCpoSD2, {"B1_XDESC",,AvSx3("B1_XDESC",5)   ,		AvSx3("B1_XDESC",6) } )
	aAdd( aCpoSD2, {"D2_LOCAL",,AvSx3("D2_LOCAL",5)   ,		AvSx3("D2_LOCAL",6) } )
	aAdd( aCpoSD2, {"D2_QUANT",,AvSx3("D2_QUANT",5)   ,		AvSx3("D2_QUANT",6) } )
	aAdd( aCpoSD2, {"D2_PRCVEN",,AvSx3("D2_PRCVEN",5)   ,		AvSx3("D2_PRCVEN",6) } )
	aAdd( aCpoSD2, {"D2_TOTAL",,AvSx3("D2_TOTAL",5)   ,		AvSx3("D2_TOTAL",6) } )
	aAdd( aCpoSD2, {"D2_TES",,AvSx3("D2_TES",5)   ,		AvSx3("D2_TES",6) } )
	aAdd( aCpoSD2, {"D2_CF",,AvSx3("D2_CF",5)   ,		AvSx3("D2_CF",6) } )



	Do While .T.
	
		DEFINE MSDIALOG oDlg TITLE OemtoAnsi("Notas Saida") From aSize[7],0 To aSize[6],aSize[5] of oMainWnd PIXEL
	
		oFolder := TFolder():New(aPosObj[1,1],aPosObj[1,2],aFolder,{},oDlg,,,,.T.,.F.,aPosObj[2,4]-aPosObj[2,2],aSize[6]-aPosObj[2,1])
	
	//MsSelect(): New ( < cAlias>, [ cCampo], [ cCpo], [ aCampos], [ lInv], [ cMar], < aCord>, [cTopFun], [ cBotFun], < oWnd>, [ uPar11], [ aColors] ) --> oSelf
	//(cAlias,cCampo,cCpo,aCampos,lInv,cMar,aCord,cTopFun,cBotFun,oWnd,aIdxCol,aColors)
	
		WorkSF2->(DbGoTop())
		oBrowSF2:=MsSelect():New("WorkSF2","MARCA","",aCpoSF2,@lInverte,@cMarca,{nGd1,nGd2,nGd3,nGd4} ,/*cTopFun*/,/*cBotFun*/ ,oFolder:aDialogs[1],,)
		oBrowSF2:oBrowse:aColumns[1]:bData:={ ||  u_PR100RetMark() }
		oBrowSF2:bAval:={||  U_PR100GETMA(), oBrowSF2:oBrowse:Refresh() }
	
		oBrowSF2:oBrowse:bChange:={|| oBrowSD2:oBrowse:SetFilter("CHAVE",WorkSF2->CHAVE),oBrowSD2:oBrowse:Default(),oBrowSD2:oBrowse:Refresh()}
	
		WorkSD2->(DbGoTop())
		oBrowSD2:=MsSelect():New("WorkSD2","","",aCpoSD2,.F.,,{nGd5,nGd6,nGd7,nGd8} ,/*cTopFun*/,/*cBotFun*/ ,oFolder:aDialogs[1],,)
	
		Activate MSdialog oDlg ON INIT ( EnchoiceBar(oDlg,bOk,bCancel,,aButtons) )
	
		If lGravar
			Processa( {|| PR100GrvNF() } )
		Else
			Exit
		EndIf
	
	EndDo

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR100  บAutor  ณMicrosiga           บ Data ณ  01/17/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PR100GrvNF()
	Local aAreaAtu	:=GetArea()
	Local aAreaSF2	:=SF2->(GetArea())
	Local aAreaSD2	:=SD2->(GetArea())
	Local aAreaSA2	:=SA2->(GetArea())
	Local aAreaSA1	:=SA1->(GetArea())
	Local cEspecie	:='SPED'
	Local cArmDest	:=Alltrim(U_MyNewSX6("ES_PR100LO","01","C","Armazem da Pre Nota de Entrada","","",.F. ))
	Local cModo		:=""
	Local cAliasSB1
	Local aCabec	:={}
	Local aItens	:={}
	Local cChaveSD2
	Local nItem
	Local aLinha
	Local oSrv
	Local aGrvNF
	Local cTesClass
	Local cErro
	Local nFatConv	:= 0

	SF2->(DbSetOrder(1))//F2_FILIAL+F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA+F2_FORMUL+F2_TIPO
	SD2->(DbSetOrder(3))//D2_FILIAL+D2_DOC+D2_SERIE+D2_CLIENTE+D2_LOJA+D2_COD+D2_ITEM
	SA1->(DbSetOrder(1))//A1_FILIAL+A1_COD+A1_LOJA
	SA2->(DbSetOrder(3))//A2_FILIAL+A2_CGC

	ProcRegua(WorkSF2->(RecCount()))

	WorkSF2->(DbGoTop())

	Do While !WorkSF2->(Eof())
	
	
		If WorkSF2->MARCA<>"OK"
			WorkSF2->(DbSkip());Loop
		EndIf
	
		If !SF2->(MsSeek(xFilial("SF2")+WorkSF2->(F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA) ))
			WorkSF2->ZAO_ERRO:="S"
			WorkSF2->ZAO_OBS :="Cabecalho da Nota de saida nใo encontrado."
			WorkSF2->(DbSkip());Loop
		EndIf
	
		If !SD2->(MsSeek(xFilial("SD2")+WorkSF2->(F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA) ))
			WorkSF2->ZAO_ERRO:="S"
			WorkSF2->ZAO_OBS :="Item da Nota de saida nใo encontrado."
			WorkSF2->(DbSkip());Loop
		EndIf
	
	
		cModo:=""
		cErro:=""
	
		If Select(cAliasSB1)>0
			(cAliasSB1)->(DbCloseArea())
		EndIf
	
		cAliasSB1:=GetNextAlias()
		EmpOpenFile(cAliasSB1,"SB1",1,.T.,WORKSF2->ZAO_EMPDES,@cModo)
	
		IncProc("Processando Nota Fiscal:"+SF2->(F2_DOC+"/"+F2_SERIE))
	
	// Cabecalho da nota fiscal de entrada
		aCabec   := {}
		aadd(aCabec,{"F1_DOC"    	,SF2->F2_DOC})
		aadd(aCabec,{"F1_SERIE"  	,SF2->F2_SERIE})
		aadd(aCabec,{"F1_EST"   	,SM0->M0_ESTCOB})
		aadd(aCabec,{"F1_TIPO"   	,"N"})
		aadd(aCabec,{"F1_FORMUL" 	,"N"})
		aadd(aCabec,{"F1_EMISSAO"	,SF2->F2_EMISSAO})
	
		aadd(aCabec,{"F1_FORNECE"	,WORKSF2->A1_YFORDES})
		aadd(aCabec,{"F1_LOJA"   	,WORKSF2->A1_YLOJDES})
		aadd(aCabec,{"F1_ESPECIE"	,cEspecie})//mv
		aadd(aCabec,{"F1_COND"		,SF2->F2_COND})//mv
	
		aadd(aCabec,{"F1_FILORIG"  ,SF2->F2_FILIAL})
		aadd(aCabec,{"F1_CLIORI"	,SF2->F2_CLIENTE})
		aadd(aCabec,{"F1_LOJAORI"	,SF2->F2_LOJA})
	
		aadd(aCabec,{"F1_CHVNFE"	,SF2->F2_CHVNFE})
	
		aadd(aCabec,{"F1_XORIG"	,"NCGPR100"})
	// Itens da nota fiscal de entrada
		cChaveSD2	:=xFilial("SD2")+WorkSF2->(F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA)
	
		aItemSD2 :={}
		aItens   :={}
		nItem		:=0
	
		Do While !SD2->(Eof()) .And. SD2->(D2_FILIAL+D2_DOC+D2_SERIE+D2_CLIENTE+D2_LOJA)==cChaveSD2
			SD2->(AADD(aItemSD2,{Recno(),D2_ITEM} ) )
			SD2->(dbSkip())
		EndDo
		aSort(aItemSD2,,,{|x,y| x[2]<y[2]})
	
		For nXnd:=1 To Len(aItemSD2)
			SD2->(DbGoTo(aItemSD2[nXnd,1]))
		
			IncProc()// Incrementa regua de processamento
		
			If !SB2->(MsSeek(xFilial("SB2")+SD2->D2_COD+cArmDest ))
				CriaSb2(SD2->D2_COD,cArmDest)
			EndIf
		
			aLinha		:={}
			aadd(aLinha,{"D1_ITEM"		,SD2->D2_ITEM	,Nil})
		//aadd(aLinha,{"D1_ITEM"	,Strzero(Val(SD2->D2_ITEM),4)	,Nil})
			
			If !lTemSA7
				cProduto:=SD2->D2_COD
			Else
				cProduto:=""
				SA7->(DbSetOrder(1)) //A7_FILIAL+A7_CLIENTE+A7_LOJA+A7_PRODUTO
				If SA7->(MsSeek(xFilial("SA7")+"00000001"+SD2->D2_COD))
					cProduto:=SA7->A7_CODCLI
				EndIf
			EndIf
					
			If Empty(cProduto)
				cErro+="Item "+SD2->D2_ITEM+" Produto "+SD2->D2_COD+" nao encontrado codigo produto WebManager"+CRLF
			ElseIf  !(cAliasSB1)->(DbSeek(xFilial("SB1")+cProduto) )
				cErro+="Item "+SD2->D2_ITEM+" Produto "+SD2->D2_COD+" nใo encontrado no cadastro e produto da empresa "+WORKSF2->ZAO_EMPDES+CRLF
			EndIf
		
		//Fator de conversใo
			nFatConv	:= 0
			If (cAliasSB1)->(DbSeek(xFilial("SB1")+cProduto) )
				nFatConv := (cAliasSB1)->B1_YFCONV
			EndIf
		
			aadd(aLinha,{"D1_COD"  		,cProduto			,Nil})

			If nFatConv > 0
				aadd(aLinha,{"D1_QUANT"		,SD2->D2_QUANT * nFatConv	,Nil})
				aadd(aLinha,{"D1_VUNIT"		,SD2->D2_TOTAL / (SD2->D2_QUANT * nFatConv)		,Nil})
			Else
				aadd(aLinha,{"D1_QUANT"		,SD2->D2_QUANT		,Nil})
				aadd(aLinha,{"D1_VUNIT"		,SD2->D2_PRCVEN	,Nil})
			EndIf

			aadd(aLinha,{"D1_TOTAL"		,SD2->D2_TOTAL		,Nil})
			aadd(aLinha,{"D1_IPI"		,SD2->D2_IPI		,Nil})
			aadd(aLinha,{"D1_PICM"		,SD2->D2_PICM		,Nil})
			aadd(aLinha,{"D1_EMISSAO"	,SD2->D2_EMISSAO	,Nil})
			aadd(aLinha,{"D1_YCODPRO"	,SD2->D2_COD		,Nil})
		
		
			aadd(aLinha,{"D1_LOCAL"	,cArmDest			,Nil})
			cTesClass:=""
			If SD2->D2_CF=="5102"
				cTesClass:="493"
			ElseIf SD2->D2_CF=="5405"
				cTesClass:="492"
			ElseIf SD2->D2_CF=="5403"
				cTesClass:="490"
			ElseIf SD2->D2_CF=="5910"
				cTesClass:="491"
			EndIf
		
			aadd(aLinha,{"D1_TESACLA",cTesClass,Nil})
		
		
		
			aadd(aLinha,{"D1_ICMSRET"	,SD2->D2_ICMSRET			,Nil})
			aadd(aLinha,{"D1_BRICMS"	,SD2->D2_BRICMS 			,Nil})
		
		// Checa se utiliza rastreabilidade
			If Rastro(SD2->D2_COD,"L")
				aadd(aLinha,{"D1_LOTECTL",SD2->D2_LOTECTL,Nil})
				aadd(aLinha,{"D1_DTVALID",SD2->D2_DTVALID,Nil})
			EndIf
			If Rastro(SD2->D2_COD,"S")
				aadd(aLinha,{"D1_LOTECTL",SD2->D2_LOTECTL,Nil})
				aadd(aLinha,{"D1_NUMLOTE",SD2->D2_NUMLOTE,Nil})
				aadd(aLinha,{"D1_DTVALID",SD2->D2_DTVALID,Nil})
			EndIf
		
			If Rastro(SD2->D2_COD,"L") .Or. Rastro(cProduto,"S")
				aadd(aLinha,{"D1_FCICOD",SD2->D2_FCICOD,Nil})
			Endif
		
			aadd(aItens,aLinha)
		Next
	
		If !Empty(cErro)
			WorkSF2->MARCA		:="ER"
			WorkSF2->ZAO_ERRO :="S"
			WorkSF2->ZAO_OBS	:=cErro
		
		ElseIf Len(aItens) > 0 .And. Len(aCabec) > 0// Caso tenha itens e cabecalho definidos
		
			aGrvNF:=StartJob('U_PR100GeraNF',GetEnvServer(),.T.,WORKSF2->ZAO_EMPDES,WORKSF2->ZAO_FILDES,aCabec,aItens)
		
			If ValType(aGrvNF) =="U"//Erro ao tentar abrir a empresa destino
				aGrvNF:={.F.,"Erro ao abrir a empresa destino."}
			EndIf
		
			If aGrvNF[1]  //Gravado
				RecLock("SF2",.F.)
				SF2->F2_FILDEST:=WORKSF2->ZAO_FILDES
				SF2->F2_FORDES :=SA2->A2_COD
				SF2->F2_LOJADES:=SA2->A2_LOJA
				SF2->F2_FORMDES:="N"
				SF2->(MsUnlock())
			
				PR100GrvZAO(aGrvNF)
			
				WorkSF2->MARCA:="GR"
				WorkSF2->ZAO_OBS:="Nota gerada com sucesso."
			
			
			Else
				WorkSF2->MARCA		:="ER"
				WorkSF2->ZAO_ERRO:="S"
				WorkSF2->ZAO_OBS	:=aGrvNF[2]
			EndIf
		
		EndIf
	
	
		WorkSF2->(DbSkip())
	EndDo

	RestArea(aAreaSF2)
	RestArea(aAreaSD2)
	RestArea(aAreaSA2)
	RestArea(aAreaSA1)
	RestArea(aAreaAtu)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR100  บAutor  ณMicrosiga           บ Data ณ  01/17/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PR100GeraNF(cNCEmpresa,cNCFilial,aCabec,aItens)
	Local aDados:={.F.,"Erro","","",""}

	RpcSetType(3)
	RpcSetEnv(cNCEmpresa,cNCFilial)


	lMsErroAuto:=.F.
	MATA140(aCabec,aItens,3)

	If lMsErroAuto
		aDados:={.F.,MemoRead(NomeAutoLog())}
		MostraErro('cPath',NomeAutoLog()) //Apagar o log
	Else
		aDados:={.T.,"",SF1->F1_DOC,SF1->F1_SERIE,SF1->F1_DTDIGIT}
	EndIf
	RpcClearEnv()

Return aDados
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR100  บAutor  ณMicrosiga           บ Data ณ  01/17/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PR100Conect(cNCEmpresa,cNCFilial,cServerIP,cPortIP,cAmbiente,aTabelas)
	Local oSrv
	Local cDriver:=GetPVProfString("Drivers",'ACTIVE',"",GetADV97())

	Default aTabelas	:={}
	Default cServerIP	:=GetServerIP()
	Default cPortIP	:=GetPVProfString(cDriver,'PORT',"",GetADV97())
	Default cAmbiente	:=GetEnvServer()


	oSrv:=RpcConnect( cServerIP,cPortIP,cAmbiente,cNCEmpresa,cNCFilial,aTabelas )


Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR100  บAutor  ณMicrosiga           บ Data ณ  01/17/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CriaSX1(cPerg)
	PutSx1(cPerg,"01","Da Emissao"		,"Da Emissao                    ","Da Emissao                    ","MV_CH1","D",8,0,0,"G","","      ","   "," ","MV_PAR01","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")
	PutSx1(cPerg,"02","Ate Emissao"		,"Ate Emissao                   ","Ate Emissao                   ","MV_CH2","D",8,0,0,"G","","      ","   "," ","MV_PAR02","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")

	PutSx1(cPerg,"03","Do Cod. Fiscal"	,"Do Cod. Fiscal                ","Do Cod. Fiscal                ","MV_CH3","C",5,0,0,"G","","13    ","   "," ","MV_PAR03","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")
	PutSx1(cPerg,"04","Ate Cod. Fiscal"	,"Ate Cod. Fiscal               ","Ate Cod. Fiscal               ","MV_CH4","C",5,0,0,"G","","13    ","   "," ","MV_PAR04","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")

	PutSx1(cPerg,"05","Do Cliente"		,"Do Cliente                    ","Do Cliente                    ","MV_CH5","C",6,0,0,"G","","SA1"   ,"   "," ","MV_PAR05","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")
	PutSx1(cPerg,"06","Da Loja"			,"Da Loja                       ","Da Loja                       ","MV_CH6","C",2,0,0,"G","","      ","   "," ","MV_PAR06","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")

	PutSx1(cPerg,"07","Ate Cliente"		,"Ate Cliente                   ","Ate Cliente                   ","MV_CH5","C",6,0,0,"G","","SA1   ","   "," ","MV_PAR07","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")
	PutSx1(cPerg,"08","Ate Loja"		,"Ate Loja  	                ","Ate Loja		                 ","MV_CH7","C",2,0,0,"G","","      ","   "," ","MV_PAR09","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")

//PutSx1(cPerg,"09","Empresa Destino"	,"Empresa Destino               ","Empresa Destino               ","MV_CH8","C",2,0,0,"G","","JUREMP","   "," ","MV_PAR09","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")
//PutSx1(cPerg,"10","Filial Destino "	,"Filial Destino                ","Filial Destino                ","MV_CH9","C",2,0,0,"G","","      ","   "," ","MV_PAR10","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")

//PutSx1(cPerg,"11","Especie Documento"	,"Especie Documento          ","Especie Documento            ","MV_CH8","C",5,0,0,"C","","42"    ,"   "," ","MV_PAR11","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")
//PutSx1(cPerg,"12","Condicao Pagamento"	,"Condicao Pagamento         ","Condicao Pagamento           ","MV_CH8","C",5,0,0,"C","","SE4"    ,"   "," ","MV_PAR12","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")
//PutSx1(cPerg,"13","Condicao Pagamento"	,"Condicao Pagamento         ","Condicao Pagamento           ","MV_CH8","C",5,0,0,"C","","SE4"    ,"   "," ","MV_PAR12","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")


Return




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR100  บAutor  ณMicrosiga           บ Data ณ  01/18/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PR100RetMark()
	Local  oReturn

	If WorkSF2->MARCA=="OK"
		oReturn:=oMarcar
	ElseIf WorkSF2->MARCA=="NO"
		oReturn:=oDesmarcar
	ElseIf WorkSF2->MARCA=="GR"
		oReturn:=oGravado
	ElseIf WorkSF2->MARCA=="ER"
		oReturn:=oErro
	EndIf

Return  oReturn

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR100  บAutor  ณMicrosiga           บ Data ณ  01/18/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PR100GETMA()

	If WorkSF2->MARCA=="ER"
		Aviso("PR100GET 01","Dados para importacao com erro."+CRLF+WORKSF2->ZAO_OBS,{"Ok"},3)
	ElseIf WorkSF2->MARCA=="GR"
		Aviso("PR100GET 02","Nota jแ Transferida para destino.",{"Ok"},3)
	Else
		WorkSF2->MARCA:=IIf(WorkSF2->MARCA=="OK","NO","OK")
	EndIf

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR100  บAutor  ณMicrosiga           บ Data ณ  01/18/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PR100GrvZAO(aDados)

	ZAO->(RecLock("ZAO",.T.))
	ZAO->ZAO_FILIAL:=xFilial("ZAO")
	ZAO->ZAO_EMPORI:=cEmpAnt
	ZAO->ZAO_FILORI:=SF2->F2_FILIAL
	ZAO->ZAO_NFORIG:=SF2->F2_DOC
	ZAO->ZAO_SERORI:=SF2->F2_SERIE
	ZAO->ZAO_CLIORI:=SF2->F2_CLIENTE
	ZAO->ZAO_LOJORI:=SF2->F2_LOJA
	ZAO->ZAO_EMNFOR:=SF2->F2_EMISSAO
	ZAO->ZAO_EMPDES:=mv_par09
	ZAO->ZAO_FILDES:=mv_par10
	ZAO->ZAO_NFDEST:=aDados[3]
	ZAO->ZAO_SERDES:=aDados[4]
	ZAO->ZAO_FORDES:=WORKSF2->A1_YFORDES
	ZAO->ZAO_LOJDES:=WORKSF2->A1_YLOJDES
	ZAO->ZAO_EMNFDE:=aDados[5]
	ZAO->ZAO_ERRO  :=IIf(aDados[1],"N","S")
	ZAO->(MsUnLock())
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR100  บAutor  ณMicrosiga           บ Data ณ  01/18/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PR100VerNF(cStatus)
	Local aAreaAtu		:=GetArea()
	Local cAliasQry	:=GetNextAlias()
	Local cQuery

	cQuery:=" Select Count(1) Contar "
	cQuery+=" From SF1"+mv_par09+"0"
	cQuery+=" Where F1_FILIAL='"+mv_par10+"'"
	cQuery+=" And F1_DOC='"+SF2->F2_DOC+"'"
	cQuery+=" And F1_SERIE='"+SF2->F2_SERIE+"'"
	cQuery+=" And F1_FORNECE='"+SA2->A2_COD+"'"
	cQuery+=" And F1_LOJA='"+SA2->A2_LOJA+"'"
	cQuery+=" And F1_TIPO='N'"
	cQuery+=" And D_E_L_E_T_=' '"+CRLF
	dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery),cAliasQry, .T., .F.)

	If (cAliasQry)->Contar>0
		WORKSF2->ZAO_OBS:="Nota jแ cadastrada."
		WORKSF2->ZAO_ERRO:="S"
		cStatus:="ER"
	EndIf
	(cAliasQry)->(DbCloseArea())

	RestArea(aAreaAtu)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR100  บAutor  ณMicrosiga           บ Data ณ  01/20/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PR100WKLEG()

	BrwLegenda('Transferencia de Notas entre Empresas',"Legenda",;
		{ { 'BR_VERDE', 'Nota cadastrada com sucesso.'},;
		{ 'BR_VERMELHO', 'Erro importa็ใo/Dados incompletos' }})


Return
