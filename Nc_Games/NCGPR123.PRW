#INCLUDE "PROTHEUS.CH"
#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"

#Define Enter Chr(13)+Chr(10)

Static aDados:={}

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR123  บAutor  ณMicrosiga           บ Data ณ  07/01/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function NCGPR123()

Local cFiltro	:= ""
Local cUser		:= RetCodUsr(Substr(cUsuario,1,6))
Local cUserPer	:= Alltrim(U_MyNewSX6("EC_NCG0023","000307;000086;000311;000371","C","Usuแrio com acesso a alterar o pedido","","",.F. ))

Local aParams 	:= {}

Private cCadastro := "Pedido Intermediario"
Private aRotina	:= MenuDef()

cUserPer := Alltrim(SuperGetMv("EC_NCG0023",.t.,"000307;000086"))

If cUser $ cUserPer
	
	If !PergFil(@aParams)
		Return
	EndIf
	
	cFiltro := Fil123B2B(aParams[1])
	
	DbSelectArea("ZC5")
	MBrowse( 6,1,22,75,"ZC5",,,,,,,,,,,,,,cFiltro)
	
Else
	
	Alert("Usuแrio voc๊ nใo possue acesso a este menu, solicitar ao Administrador do sistema.")
	
EndIf


Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR123  บAutor  ณMicrosiga           บ Data ณ  07/01/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function Pr123Manu(cAlias,nReg,nOpc)
Local oDlg
Local lGravar	:= .F.
Local aArea		:= GetArea()
Local aSize   	:= MsAdvSize()
Local aObjects	:= {}

Local aCpoCab	:= {"ZC5_NUM","ZC5_CLIENT","ZC5_LOJA","ZC5_COND","ZC5_STATUS","ZC5_TOTAL","ZC5_FRETE","ZC5_VDESCO","NOUSER"}
Local aCposAlt  := {"ZC5_VDESCO"}

Local aCpoItPV	:= {"ZC6_ITEM","ZC6_PRODUT","B1_XDESC","ZC6_QTDVEN","ZC6_VLRUNI","ZC6_VLRTOT","B2_QATU","R_E_C_N_O_"}
Local aCpoEnable:= {"ZC6_PRODUT","ZC6_VLRUNI","ZC6_QTDVEN"}
Local aInfo		:= {}
Local aPosObj	:= {}
Local aPosFld	:= {}
Local aObjFld	:= {}
Local bOk		:= {|| Iif(Obrigatorio(aGets,aTela),(lGravar:=.T.,oDlg:End()),) }
Local bCancel	:= {|| lGravar:=.F.,oDlg:End() }
Local aButtons	:= {}
Local aFolders	:= {OemToAnsi('Itens do Pedido Intermediแrio')}

Local nOpcy		:=IIf( (nOpc==3 .Or. nOpc==4),GD_INSERT+GD_UPDATE+GD_DELETE,0   )

Local cSeekKey	:= xFilial("ZC5")+STR(ZC5->ZC5_NUM,6,0)
Local bSeekWhile:= {|| ZC5_FILIAL+STR(ZC5->ZC5_NUM,6,0) }
Local uSeekFor	:= {}
Local nPvSite	:= STR(ZC5->ZC5_NUM,6,0)
Local cArmPad	:= "01"

Local aHeadPedido:= {}
Local aColsPedido:= {}

Private aHeadProd:= {}
Private aColsProd:= {}

Private oFolder
Private oObjBrow
Private oGetProd

Private aTELA[0][0],aGETS[0]

RegToMemory("ZC5",nOpc==3)
//FillGetDados ( < nOpc>, < cAlias>, [ nOrder], [ cSeekKey], [ bSeekWhile], [ uSeekFor], [ aNoFields], [ aYesFields], [ lOnlyYes], [ cQuery], [ bMontCols], [ lEmpty], [ aHeaderAux], [ aColsAux], [ bAfterCols], [ bBeforeCols], [ bAfterHeader], [ cAliasQry], [ bCriaVar], [ lUserFields], [ aYesUsado] ) --> lRet
ZC5->(FillGetDados ( nOpc, "ZC5",1, cSeekKey, bSeekWhile,  /*uSeekFor*/, /*aNoFields*/, aCpoCab, .T., /*[ cQuery]*/, /*[bMontCols]*/, nOpc==3, aHeadPedido, aColsPedido, /*[ bAfterCols]*/, /*[ bBeforeCols]*/, /*[ bAfterHeader]*/, /*[ cAliasQry]*/, /*[ bCriaVar]*/, .F.,/*[aYesUsado]*/))

aHeadProd	:= CriaHeader(aCpoItPV)
aColsProd	:= CriaAItSt(nPvSite, cArmPad)

aSizeAut	:= MsAdvSize(,.F.,400)
AAdd( aObjects, { 0,    70, .T., .F. } )
AAdd( aObjects, { 100, 100, .T., .T. } )

aInfo	:= { aSizeAut[ 1 ], aSizeAut[ 2 ], aSizeAut[ 3 ], aSizeAut[ 4 ], 3, 3 }
aPosObj	:= MsObjSize( aInfo, aObjects )

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณCalcula o Size para os Foldersณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Aadd( aObjFld, {   1  ,  1, .T., .T. } )
aInfoFld := {1,1,aPosObj[2,4] - aPosObj[2,2] ,aPosObj[2,3] - aPosObj[2,1],3,3}
aPosFld := MsObjSize( aInfoFld, aObjFld )

DEFINE MSDIALOG oDlg TITLE OemtoAnsi("Pedido Intermediแrio Ecommerce") From aSize[7],0 To aSize[6],aSize[5] of oMainWnd PIXEL
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณMonta a Enchoice superior com? os Dados da Cargaณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
//Enchoice(/*cAlias*/,/*nReg*/,/*nOpc*/,/*aCRA*/,/*cLetras*/,/*cTexto*/,/*aAcho*/,/*aPos*/,/*aCpos*/,/*nModelo*/,/*nColMens*/,/*cMensagem*/,/*cTudoOk*/,/*oWnd*/,/*lF3*/,/*lMemoria*/,/*lColumn*/,/*caTela*/,/*lNoFolder*/,/*lProperty*/,/*aField*/,/*aFolder*/,/*lCreate*/,/*lNoMDIStretch*/ )
Enchoice( "ZC5", nReg, nOpc,/*aCRA*/,/*cLetras*/,/*cTexto*/, aCpoCab,{aPosObj[1,1],aPosObj[1,2],aPosObj[1,3],aPosObj[1,4]}, aCposAlt, 1,/*nColMens*/,/*cMensagem*/ ,"AllwaysTrue()", oDlg, .F.,  .T., .F., , .T., .F.)

oFolder := TFolder():New(aPosObj[2,1],aPosObj[2,2],aFolders,{'','',''},oDlg,,,,.T.,.F.,aPosObj[2,4]-aPosObj[2,2],aPosObj[2,3]-aPosObj[2,1])
nGd1 := 2
nGd2 := 2
nGd3 := aPosObj[2,3]-aPosObj[2,1]-15
nGd4 := aPosObj[2,4]-aPosObj[2,2]-4


//MsNewGetDados(): New ( [ nTop],[nLeft],[nBottom],[nRight],[nStyle],[cLinhaOk],[cTudoOk],[cIniCpos],[aAlter],[nFreeze],[nMax],[cFieldOk],[cSuperDel],[cDelOk],[oWnd],[aPartHeader],[aParCols],[uChange],[cTela])--> Objeto
oGetProd := MsNewGetDados():New(nGd1,nGd2,nGd3,nGd4,nOpcy,/*cLinhaOk*/,/*Pr123TOk()*/,"+ZC6_ITEM",aCpoEnable,/*nFreeze*/,/*nMax*/,"U_P123Trg()",/*cSuperDel*/,/*cDelOk*/ ,oFolder:aDialogs[1],aHeadProd,aColsProd)
oGetProd:lInsert:=.t.
//oGetProd:oBrowse:bAdd := {|| MsgInfo("inclusao nao permitida") }

ACTIVATE MSDIALOG oDlg ON INIT ( EnchoiceBar(oDlg,bOk,bCancel,,aButtons) )

If nOpc<>2 .And. lGravar
	
	Begin Transaction
	Processa( {|| PR123Grv(nOpc,aCpoCab,aCpoItPV,aHeadProd,oGetProd:aCols) } )
	End Transaction
	
	If MsgYesNo("Deseja gravar o pedido de venda?","GravarPedido")
		Processa( { || U_COM08GRAVA("GRAVA_PEDIDO") }, "Aguarde...", "Gravando Pedido...",.F.)
	EndIf
	
ElseIf __lSX8
	
	RollBackSX8()
	
EndIf

oObjBrow := GetObjBrow()
oObjBrow:Refresh()

RestArea(aArea)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR123  บAutor  ณMicrosiga           บ Data ณ  07/02/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PR123Grv(nOpc,aCpoCab,aCpoItPV,aHeadProd,aColsProd)
Local aAreaAtu		:= GetArea()
Local aAreaZC5		:= ZC5->(GetArea())

Local cFilZC5		:= xFilial("ZC5")
Local cFilZC6		:= xFilial("ZC6")
Local cChaveZC6		:= cFilZC6+STR(M->ZC5_NUM,6,0)
Local nY
Local bCampoZC5 	:= {|nCPO| Field(nCPO) }
Local nTotalZC6 	:= 0
Local nVlrFrete 	:= 0
Local nVlrDesc	 	:= 0
Local cPago 		:= ""
Local lCancPV		:= .f.


ZC5->(RecLock("ZC5",.F.))

If M->ZC5_STATUS $ "4 ,10"
	
	ZC5->ZC5_STATUS	:= "90"
	ZC5->ZC5_ATUALI	:= "N"
	lCancPV 		:= .t.
	
ElseIf M->ZC5_STATUS $ "15,30,16"
	
	U_NCECOM09(ZC5->ZC5_NUM, ZC5->ZC5_NUMPV,"Pedido Reimportado")
	
EndIf

ZC5->ZC5_ESTORN	:= "S"
ZC5->ZC5_CODINT	:= "015" //Adicionado para controlar pedidos que jแ foram alterados

ZC5->(MsUnlock())

If lCancPV .And. !Empty(M->ZC5_NUMPV)
	Pr123Canc(M->ZC5_NUMPV)
EndIf


cPago := ZC5->ZC5_PAGTO
nVlrFrete := ZC5->ZC5_FRETE
nVlrDesc := ZC5_VDESCO

ZC5->(RecLock("ZC5",.T.))
For nY := 1 TO ZC5->(FCount())
	If ("FILIAL" $ ZC5->(FieldName(nY)) )
		ZC5->(FieldPut(nY,cFilZC5))
	Else
		ZC5->(FieldPut(nY,M->&(EVAL(bCampoZC5,nY))))
	EndIf
Next nY


ZC6->(DbSetOrder(2)) //ZC6_FILIAL+STR(ZC6_NUM, 6, 0)+ZC6_PRODUT
ZC6->(DbSeek(cChaveZC6))

Do While ZC6->(!EOF()) .And. ZC6->(ZC6_FILIAL+STR(ZC6_NUM, 6, 0)) == cChaveZC6
	ZC6->(RecLock("ZC6",.F.))
	ZC6->(dbDelete())
	ZC6->(MsUnLock())
	ZC6->(DbSkip())
EndDo

For nInd:=1 To Len(aColsProd)
	P123GrZC6(aHeadProd,aColsProd,nInd,@nTotalZC6)
Next

ZC5->ZC5_NUMPV	:= ""
ZC5->ZC5_STATUS	:= IIf(cPago =="2","10","4")
ZC5->ZC5_TOTAL	:= nTotalZC6 + nVlrFrete - nVlrDesc

ZC5->(MsUnlock())


RestArea(aAreaZC5)
RestArea(aAreaAtu)


Return .T.


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR123  บAutor  ณMicrosiga           บ Data ณ  07/02/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function P123GrZC6(aHeader,aCols,nInd,nTotalZC6)

Local cAliasZC6 := ZC6->(GetArea())
Local cFilZC6	:= xFilial("ZC6")


If !(GdDeleted( nInd , aHeader , aCols ))
	ZC6->(RecLock("ZC6",.T.))
	
	For nYnd:=1 To Len(aHeader)
		nColuna:=ZC6->(FieldPos(aHeader[nYnd,2]))
		If nColuna>0
			ZC6->(FieldPut(nColuna,GdFieldGet(aHeader[nYnd,2],nInd,,aHeader,aCols)))
		EndIf
	Next
	ZC6->ZC6_FILIAL:= cFilZC6
	ZC6->ZC6_NUM	:= ZC5->ZC5_NUM
	ZC6->ZC6_LOCAL	:= "01"
	
	ZC6->(MsUnLock())
	
	nTotalZC6 += GdFieldGet("ZC6_VLRTOT",nInd,,aHeader,aCols) // Salvar novo valor final
	
EndIf
RestArea(cAliasZC6)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMenuDef  บAutor  ณMicrosiga           บ Data ณ  07/01/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina Static para aRotina                                  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function MenuDef()
Local aRotina:={{"Pesquisar","AxPesqui"		,0,1} ,;
{"Visualizar","U_Pr123Manu"	,0,2} ,;//{"Incluir","U_Pr123Manu"	,0,3} ,;
{"Gravar Pedido","U_GrvPV123"	,0,3} ,;
{"Alterar","U_Pr123Manu"	,0,4} }

Return aRotina

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCriaAItSt บAutor  ณElton C Santana     บ Data ณ  08/10/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CriaAItSt(nPvSite, cArmPad)

Local aArea 	:= GetArea()
Local cQuery  	:= ""
Local cArqTmp	:= GetNextAlias()
Local aAcolsRt 	:= {}

Default nPvSite:= 0
Default cArmPad:= ""


cQuery   := " SELECT ZC6_NUM,"+CRLF
cQuery   += "  		ZC6_ITEM, "+CRLF
cQuery   += " 		ZC6_PRODUT, "+CRLF
cQuery   += " 		B1_XDESC, "+CRLF
cQuery   += " 		ZC6_QTDVEN, "+CRLF
cQuery   += " 		ZC6_VLRUNI, "+CRLF
cQuery   += " 		ZC6_VLRTOT, "+CRLF
cQuery   += " 		(B2_QATU - B2_RESERVA - B2_QEMP + ZC6_QTDRES) AS SALDO, "+CRLF
cQuery   += " 		ZC6_LOCAL "+CRLF
cQuery   += " FROM "+RetSqlName("ZC6")+" ZC6 "+CRLF
cQuery   += " INNER JOIN "+RetSqlName("SB1")+" SB1 "+CRLF
cQuery   += " ON SB1.B1_FILIAL = '"+xFilial("SB1")+"' "+CRLF
cQuery   += " AND SB1.B1_COD = ZC6.ZC6_PRODUT "+CRLF
cQuery   += " AND SB1.D_E_L_E_T_ = ' ' "+CRLF
cQuery   += " INNER JOIN "+RetSqlName("SB2")+" SB2 "+CRLF
cQuery   += " ON SB2.B2_FILIAL = '"+xFilial("SB2")+"' "+CRLF
cQuery   += " AND SB2.B2_COD =  ZC6.ZC6_PRODUT "+CRLF
cQuery   += " AND SB2.B2_LOCAL = '"+cArmPad+"' "+CRLF
cQuery   += " AND SB2.D_E_L_E_T_ = ' ' "+CRLF
cQuery   += " WHERE ZC6.ZC6_FILIAL = '"+xFilial("ZC6")+"' "+CRLF
cQuery   += " AND ZC6.ZC6_NUM = '"+Alltrim(nPvSite)+"' "+CRLF
cQuery   += " AND ZC6.D_E_L_E_T_ = ' ' "+CRLF

cQuery := ChangeQuery(cQuery)
dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cArqTmp,.f.,.T.)

//Preenchimento do Acols
(cArqTmp)->(DbGoTop())

While (cArqTmp)->(!Eof())
	//Preenche o acols pv
	aAdd(aAcolsRt,;
	{(cArqTmp)->ZC6_ITEM,;
	(cArqTmp)->ZC6_PRODUT,;
	(cArqTmp)->B1_XDESC,;
	(cArqTmp)->ZC6_QTDVEN,;
	(cArqTmp)->ZC6_VLRUNI,;
	(cArqTmp)->ZC6_VLRTOT,;
	(cArqTmp)->SALDO;
	,.F.})
	
	(cArqTmp)->(DbSkip())
EndDo


(cArqTmp)->(DbCloseArea())
RestArea(aArea)

Return aAcolsRt

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCriaHeaderบAutor  ณElton C.	         บ Data ณ  02/2014	  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCria o aHeader						                   	  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CriaHeader(aCampos)
Local aArea		:= GetArea()
Local aRet	 	:= {}
Local nIx		:= 0
Local lDif		:= .F.

Default aCampos := {}

DbSelectArea( "SX3" )
DbSetOrder(2)

For nIx := 1 To Len( aCampos )
	If SX3->( MsSeek( aCampos[ nIx ] ) )
		
		If Alltrim(SX3->X3_CAMPO) == "C0_QTDPED".And. !lDif
			cDescCpo	:= "Qtd.Reserv."
			lDif		:= .T.
		ElseIf	(Alltrim(SX3->X3_CAMPO) == "C0_QTDPED" ) .And. lDif//Tratamento para alterar o titulo (Itens do pedido)
			cDescCpo	:= "Dif.Qtd.Pv. x Reserva"
			lDif		:= .F.
		ElseIf Alltrim(SX3->X3_CAMPO) == "B2_QATU"
			cDescCpo := "Qtd.Disponํvel"
		Else
			cDescCpo := X3Titulo()
		EndIf
		
		
		aAdd( aRet, {AlLTrim( cDescCpo)	, ;	// 01 - Titulo
		SX3->X3_CAMPO	, ;	// 02 - Campo
		SX3->X3_Picture	, ;	// 03 - Picture
		SX3->X3_TAMANHO	, ;	// 04 - Tamanho
		SX3->X3_DECIMAL	, ;	// 05 - Decimal
		SX3->X3_Valid  	, ;	// 06 - Valid
		SX3->X3_USADO  	, ;	// 07 - Usado
		SX3->X3_TIPO   	, ;	// 08 - Tipo
		SX3->X3_F3		, ;	// 09 - F3
		SX3->X3_CONTEXT	, ;	// 10 - Contexto
		SX3->X3_CBOX	, ; // 11 - ComboBox
		SX3->X3_RELACAO	} )	// 12 - Relacao
	Endif
Next

RestArea( aArea )

Return aRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR123  บAutor  ณMicrosiga           บ Data ณ  09/12/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function GrvPV123()

Processa( { || U_NCECOM08() }, "Aguarde...", "Gravando Pedido...",.F.)

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR123  บAutor  ณMicrosiga           บ Data ณ  02/26/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function Pr123Gat()

Local aAreaSb2	:= SB2->(GetArea())
Local nQtnPed	:= 0
Local nPrcVen	:= 0
Local nVlrTot	:= 0

Local cArmPad	:= "01"
Local nEstAtu	:= 0
Local cCmpRead	:= __ReadVar

If cCmpRead $ "M->ZC6_QTDVEN"
	nQtnPed	:= M->ZC6_QTDVEN
	nPrcVen	:= GdFieldGet("ZC6_VLRUNI")
	If M->ZC6_QTDVEN > 0 .And. !(Empty(GdFieldGet("ZC6_PRODUT")))
		SB2->(DbSetOrder(1))
		SB2->(MsSeek(xFilial("SB2")+GdFieldGet("ZC6_PRODUT")+cArmPad))
		nEstAtu := SB2->B2_QATU-SB2->B2_RESERVA
		GdFieldPut("B2_QATU",nEstAtu,oGetProd:nAT,oGetProd:aHeader,oGetProd:aCols)
	EndIf
ElseIf cCmpRead $ "M->ZC6_VLRUNI"
	nQtnPed	:= GdFieldGet("ZC6_QTDVEN")
	nPrcVen	:= M->ZC6_VLRUNI
EndIf

nVlrTot := nQtnPed*nPrcVen


If cCmpRead $ "M->ZC5_VDESCO"
	If !M->ZC5_VDESCO > ZC5->ZC5_TOTAL
		If M->ZC5_VDESCO > ZC5->ZC5_VDESCO
			MsgAlert("O desconto adicional ้ de R$ "+ Alltrim(Str(M->ZC5_VDESCO - ZC5->ZC5_VDESCO)))
			nVlrTot := M->ZC5_VDESCO
		Else
			If MsgYesNo("O desconto inserido ้ menor que o desconto existente, deseja confirmar a altera็ใo do desconto.")
				nVlrTot:= M->ZC5_VDESCO
			Else
				nVlrTot:= ZC5->ZC5_VDESCO
			EndIf
		EndIf
	Else
		MsgAlert("Opera็ใo invalida, O valor de desconto digitado ้ maior que o valor total do pedido.")
		nVlrTot:= ZC5->ZC5_VDESCO
	EndIf
EndIf

RestArea(aAreaSb2)

Return nVlrTot


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR123  บAutor  ณMicrosiga           บ Data ณ  02/26/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function Pr123TOk()

Local aCols		:= {}
Local aHeader	:= {}
Local lRet 		:= .t.
Local nX

aCols := aColsProd
aHeader := aHeadProd

For nX := 1 To Len(aCols)
	
	If !U_GdCheckKey({"ZC6_PRODUT"},4,,"Produto Duplicado")
		lRet := .F.
		Exit
	EndIf
	
	
Next nX


Return lRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR123  บAutor  ณMicrosiga           บ Data ณ  02/27/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function P123Trg()

Local aAreaAtu	:= GetArea()
Local aAreaSB1	:= SB1->(GetArea())
Local lRet := .T.
Local nZerar	:= 0


If __ReadVar $ "M->ZC6_PRODUT"
	
	SB1->(DbSetOrder(1))
	SB1->(MsSeek(xFilial("SB1")+M->ZC6_PRODUT))
	
	GdfieldPut("B1_XDESC",SB1->B1_XDESC,oGetProd:nAT,oGetProd:aHeader,oGetProd:aCols)
	//zerar campos preenchidos no Acols
	GdfieldPut("ZC6_QTDVEN",nZerar,oGetProd:nAT,oGetProd:aHeader,oGetProd:aCols)
	GdfieldPut("ZC6_VLRUNI",nZerar,oGetProd:nAT,oGetProd:aHeader,oGetProd:aCols)
	GdfieldPut("ZC6_VLRTOT",nZerar,oGetProd:nAT,oGetProd:aHeader,oGetProd:aCols)
	GdfieldPut("B2_QATU",nZerar,oGetProd:nAT,oGetProd:aHeader,oGetProd:aCols)
	
EndIf

RestArea(aAreaAtu)
RestArea(aAreaSB1)

Return lRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR123  บAutor  ณMicrosiga           บ Data ณ  10/28/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Fil123B2B(cOpcao)

Local cFiltro	:= ""
Local clUsrBD	:=	AllTrim(U_MyNewSX6("NCG_000019","WMS","C","Usuแrio para acessar a base do WMS","","",	.F. ))

Default cOpcao = "0"

If cOpcao = "0"
	cFiltro += " ZC5_NUM <> 0 "+CRLF
	cFiltro += " AND ZC5_PLATAF IN (' ','01') "+CRLF
	cFiltro += " AND ZC5_STATUS IN ('10','94') AND ZC5_NUMPV IN ( SELECT SUBSTR(CES_NUM_DOCUMENTO,1,6) "+CRLF
	cFiltro += " 					 FROM "+clUsrBD+".TB_WMSINTERF_CANC_ENT_SAI  "+CRLF
	cFiltro += " 				 	 WHERE CES_COD_CHAVE IN  ( SELECT SUBSTR(P0A_CHAVE,1,8)  "+CRLF
	cFiltro += " 						 						FROM "+RetSqlName("P0A")+" P0A  "+CRLF
	cFiltro += " 			 			 						WHERE P0A.P0A_FILIAL = '"+xFilial("P0A")+"'  "+CRLF
	cFiltro += " 				 								AND P0A.D_E_L_E_T_ = ' '  "+CRLF
	cFiltro += " 					 							AND P0A.P0A_CHAVE IN (SELECT ZC52.ZC5_FILIAL||ZC52.ZC5_NUMPV  "+CRLF
	cFiltro += " 					 													FROM "+RetSqlName("ZC5")+" ZC52  "+CRLF
	cFiltro += " 					 													WHERE ZC52.ZC5_FILIAL = '"+xFilial("ZC5")+"'  "+CRLF
	cFiltro += " 					 													AND ZC52.D_E_L_E_T_ = ' '  "+CRLF
	cFiltro += " 					 													AND ZC52.ZC5_NUM <> 0  "+CRLF
	cFiltro += " 					 													AND ZC52.ZC5_NUMPV <> ' '  "+CRLF
	cFiltro += " 					 											   		AND ZC52.ZC5_PLATAF IN ('  ','01')  "+CRLF
	cFiltro += " 					 													AND ZC52.ZC5_STATUS IN ('10','94')))	 "+CRLF
	cFiltro += " 	    				AND NOT EXISTS ( SELECT 'X' FROM "+clUsrBD+".tb_wmsinterf_doc_saida WHERE DPCS_NUM_DOCUMENTO = CES_NUM_DOCUMENTO ) ) "+CRLF
	cFiltro += " OR ZC5_STATUS IN ('4','10') AND ZC5_NUMPV IN (SELECT ZC53.ZC5_NUMPV  "+CRLF
	cFiltro += " 						FROM "+RetSqlName("ZC5")+" ZC53  "+CRLF
	cFiltro += " 						WHERE ZC53.ZC5_FILIAL = '"+xFilial("ZC5")+"'  "+CRLF
	cFiltro += " 						AND ZC53.ZC5_NUM <> 0 "+CRLF
	cFiltro += " 						AND ZC53.D_E_L_E_T_ = ' ' "+CRLF
	cFiltro += " 						AND ZC53.ZC5_STATUS IN ('4','10') "+CRLF
	cFiltro += "						AND ZC53.ZC5_PLATAF IN ('  ','01') "+CRLF
	cFiltro += "						AND NOT EXISTS (SELECT 'X'  "+CRLF
	cFiltro += "										FROM "+RetSqlName("P0A")+" P0A1  "+CRLF
	cFiltro += "										WHERE P0A1.P0A_FILIAL = '"+xFilial("P0A")+"'  "+CRLF
	cFiltro += "										AND P0A1.D_E_L_E_T_ = ' '  "+CRLF
	cFiltro += "										AND P0A1.P0A_CHAVE = ZC53.ZC5_FILIAL||ZC53.ZC5_NUMPV	)	) "+CRLF
	
ElseIf cOpcao == "1"
	cFiltro += " ZC5_NUM <> 0 "+CRLF
	cFiltro += " AND ZC5_PLATAF IN (' ','01') "+CRLF
	cFiltro += " AND ZC5_CODINT = '003' AND ZC5_STATUS NOT IN('30','90','91','93','96') "+CRLF
ElseIf cOpcao == "2"
	cFiltro += " ZC5_NUM <> 0 "+CRLF
	cFiltro += " AND ZC5_PLATAF IN (' ','01') "+CRLF
	cFiltro += " AND ZC5_STATUS IN ('10','94') AND ZC5_NUMPV IN ( SELECT SUBSTR(CES_NUM_DOCUMENTO,1,6) "+CRLF
	cFiltro += " 					 FROM "+clUsrBD+".TB_WMSINTERF_CANC_ENT_SAI  "+CRLF
	cFiltro += " 				 	 WHERE CES_COD_CHAVE IN  ( SELECT SUBSTR(P0A_CHAVE,1,8)  "+CRLF
	cFiltro += " 						 						FROM "+RetSqlName("P0A")+" P0A  "+CRLF
	cFiltro += " 			 			 						WHERE P0A.P0A_FILIAL = '"+xFilial("P0A")+"'  "+CRLF
	cFiltro += " 				 								AND P0A.D_E_L_E_T_ = ' '  "+CRLF
	cFiltro += " 					 							AND P0A.P0A_CHAVE IN (SELECT ZC52.ZC5_FILIAL||ZC52.ZC5_NUMPV  "+CRLF
	cFiltro += " 					 													FROM "+RetSqlName("ZC5")+" ZC52  "+CRLF
	cFiltro += " 					 													WHERE ZC52.ZC5_FILIAL = '"+xFilial("ZC5")+"'  "+CRLF
	cFiltro += " 					 													AND ZC52.D_E_L_E_T_ = ' '  "+CRLF
	cFiltro += " 					 													AND ZC52.ZC5_NUM <> 0  "+CRLF
	cFiltro += " 					 													AND ZC52.ZC5_NUMPV <> ' '  "+CRLF
	cFiltro += " 					 											   		AND ZC52.ZC5_PLATAF IN ('  ','01')  "+CRLF
	cFiltro += " 					 													AND ZC52.ZC5_STATUS IN ('10','94')))	 "+CRLF
	cFiltro += " 	    				AND NOT EXISTS ( SELECT 'X' FROM "+clUsrBD+".tb_wmsinterf_doc_saida WHERE DPCS_NUM_DOCUMENTO = CES_NUM_DOCUMENTO ) ) "+CRLF
EndIf

Return cFiltro


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR123  บAutor  ณMicrosiga           บ Data ณ  04/01/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function Pr123Canc(cPvVtex)

Local aAreaAtu	:= GetArea()
Local aAreaZC5 	:= ZC5->(GetArea())
Local lConfirm	:= .F.

Default cPvVtex := ""

ZC5->(DbSetOrder(2))//ZC5_FILIAL+ZC5_NUMPV

If ZC5->(MsSeek(xFilial("ZC5")+Alltrim(cPvVtex)))
	If !Empty(ZC5->ZC5_NUMPV)
		If Empty(ZC5->ZC5_NOTA)
			If VldCancel(ZC5->ZC5_NUM, ZC5->ZC5_NUMPV)//Valida็ใo do cancelamento
				U_PR106ExcP0A(xFilial("ZC5"),ZC5->ZC5_NUMPV)
				If Ec11Canc(ZC5->ZC5_NUMPV)
					U_NCECOM09(ZC5->ZC5_NUM, ZC5->ZC5_NUMPV,"Altera็ใo de pedido","O pedido serแ aletado para a gera็ใo de um novo n๚mero","",.T.,,,ZC5->ZC5_PVVTEX)	//Log de processamento
				EndIf
			Else
				MsgAlert("O pedido nใo poderแ ser alterado")
			EndIf
		Else
			MsgAlert("O pedido nใo poderแ ser alterado, pois possue nota fiscal")
		EndIf
	EndIf
Else
	MsgAlert("Pedido nใo encontrado")
EndIf

RestArea(aAreaAtu)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณVldCancel		บAutor  ณElton C.		  บ   Data ณ  02/2014 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณVerifica se o pedido estแ no WMS	     					  บฑฑ
ฑฑบ          ณ	                                              		      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function VldCancel(nPedSite, cNumProth)

Local aArea 	:= GetArea()
Local lRet		:= .T.
Local cMsgAux  := "Nใo ้ possํvel cancelar o pedido pelo(s) motivo(s) abaixo:"+CRLF+CRLF
Local cMsg		:= ""

Default nPedSite	:= 0
Default cNumProth	:= ""

If !VldPedWMS(cNumProth)
	cMsg	+= "- Aguardando cancelamento do WMS. "+CRLF
	lRet	:= .F.
EndIf

If !lRet
	Aviso("Aten็ใo",cMsgAux+cMsg,{"Ok"},3)
EndIf

RestArea(aArea)
Return lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณVldPedWMS		บAutor  ณElton C.		  บ   Data ณ  02/2014 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณVerifica se o pedido estแ no WMS	     					  บฑฑ
ฑฑบ          ณ	                                              			  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function VldPedWMS(cNumPVP)

Local aArea		:= GetArea()
Local aAreaP0A	:= P0A->(GetArea())
Local cArqTmp	:= GetNextAlias()
Local cAliasQry	:= GetNextAlias()

Local cQuery   	:= ""
Local cChave   	:= ""

Local lRet		:= .T.
Local cUsrBD 	:= U_MyNewSX6("NCG_000019","","C","Usuแrio para acessar a base do WMS","","",.F.)

Default cNumPVP	:= ""

If !Empty(cNumPVP)
	
	cChave := xFilial("P0A")+AllTrim(cNumPVP)
	
	BeginSql Alias cAliasQry
		
		Select P0A.R_E_C_N_O_ P0ARec From %Table:P0A% P0A
		Where P0A.P0A_FILIAL = %xfilial:P0A%
		And P0A.%NotDel%
		And P0A.P0A_CHAVE = %exp:cChave%
		
	EndSql
	
	If (cAliasQry)->(!Eof())
		P0A->(DbGoTo((cAliasQry)->P0ARec))
		If P0A->P0A_EXPORT == "2"
			lRet := .F.
		Else
			cQuery	:= " SELECT CES_COD_CHAVE "
			cQuery	+= " FROM "+cUsrBD+".TB_WMSINTERF_CANC_ENT_SAI "
			cQuery	+= " WHERE CES_NUM_DOCUMENTO = '"+cNumPVP+"' "
			cQuery	+= " AND NOT EXISTS"
			cQuery	+= " (SELECT 'X' FROM "+cUsrBD+".TB_WMSINTERF_DOC_SAIDA"
			cQuery	+= " WHERE DPCS_NUM_DOCUMENTO = CES_NUM_DOCUMENTO )"
			
			dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cArqTmp,.T.,.T.)
			
			If (cArqTmp)->(!Eof())
				If Empty((cArqTmp)->CES_COD_CHAVE)
					lRet := .F.
				EndIf
			Else
				lRet := .F.
			EndIf
			
			(cArqTmp)->(DbCloseArea())
		EndIf
	EndIf
	
EndIf

RestArea(aAreaP0A)
RestArea(aArea)
Return lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCECOM11  บAutor  ณMicrosiga           บ Data ณ  03/03/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Ec11Canc(cNumPV)

Local aAreaAtu	:= GetArea()
Local aAreaSC5	:= SC5->(GetArea())
Local aAreaSC9 	:= SC9->(GetArea())
Local aAreaSC6 	:= SC6->(GetArea())
Local aAreaSB2 	:= SB2->(GetArea())
Local aAreaSA1 	:= SA1->(GetArea())

Local lRet 		:= .T.

SC5->(DbSetOrder(1))//C5_FILIAL+C5_NUM
SC9->(DbSetOrder(1))//C9_FILIAL+C9_PEDIDO+C9_ITEM+C9_SEQUEN+C9_PRODUTO
SC6->(DbSetOrder(1))//C6_FILIAL+C6_NUM+C6_ITEM+C6_PRODUTO
SB2->(dbSetOrder(1))
SA1->(dbSetOrder(1))

If SC5->(MsSeek(xFilial("SC5")+cNumPV))
	
	If Empty(SC5->C5_NOTA)
		
		If SC9->(MsSeek(xFilial("SC9")+SC5->C5_NUM ))
			Do While SC9->(!Eof()) .And. SC9->(C9_FILIAL+C9_PEDIDO)==xFilial("SC9")+SC5->C5_NUM
				SC9->(a460Estorna(.T.))
				lRet := .T.
				SC9->(DbSkip())
			EndDo
		EndIf
		
		If lRet
			
			U_NC110Del(cNumPV)
			
			If SC6->( MsSeek(xFilial("SC6")+SC5->C5_NUM  ))
				
				Do While SC6->(!Eof() ) .And. SC6->( C6_FILIAL+C6_NUM==xFilial("SC6")+ SC5->C5_NUM )
					
					SB2->(MsSeek(xFilial("SB2")+SC6->C6_PRODUTO+SC6->C6_LOCAL))
					
					SB2->(RecLock("SB2",.F.))
					SB2->B2_QPEDVEN -= Max(SC6->C6_QTDVEN-SC6->C6_QTDEMP-SC6->C6_QTDENT,0)
					SB2->B2_QPEDVE2 -= ConvUM(SB2->B2_COD, Max(SC6->C6_QTDVEN-SC6->C6_QTDEMP-SC6->C6_QTDENT,0), 0, 2)
					If ( SC6->C6_OP$"01#03#05" )
						SB2->B2_QEMPN  -= SC6->C6_QTDVEN
						SB2->B2_QEMPN2 -= ConvUM(SB2->B2_COD, SC6->C6_QTDVEN, 0, 2)
					Endif
					
					SB2->(MsUnLock())
					
					If !SC5->C5_TIPO$'DB'
						SA1->(MsSeek(xFilial("SA1")+SC6->C6_CLI+SC6->C6_LOJA))
						SA1->(RecLock("SA1",.F.))
						nMCusto		:= If(SA1->A1_MOEDALC > 0, SA1->A1_MOEDALC, Val(GetMv("MV_MCUSTO")))
						SA1->A1_SALPED -= xMoeda(Max(SC6->C6_QTDVEN-SC6->C6_QTDEMP-SC6->C6_QTDENT,0)*SC6->C6_PRCVEN,SC5->C5_MOEDA,nMCusto,SC5->C5_EMISSAO)
						SA1->(MsUnLock())
					EndIf
					
					SC6->(RecLock("SC6",.F.))
					
					SC6->C6_BLQ := "R"
					
					SC6->(MsUnLock())
					
					SC6->(DbSkip())
					
				EndDo
			EndIf
			
			lret :=	MaLiberOk({SC5->C5_NUM}, .T.)
			
		EndIf
	EndIf
EndIf



RestArea(aAreaSA1)
RestArea(aAreaSB2)
RestArea(aAreaSC6)
RestArea(aAreaSC9)
RestArea(aAreaSC5)
RestArea(aAreaAtu)


Return lret


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPergFil	บAutor  ณMicrosiga           บ Data ณ  05/09/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PergFil(aParams)
Local llRet		:= .T.
Local aParamBox	:= {}
Local aFilt		:= {}


AADD(aFilt,"0=Todos")
AADD(aFilt,"1=Estoque insuficiente")
AADD(aFilt,"2=Estornados na logistica")

aAdd(aParamBox,{2,"Filtro"			,"1"	, aFilt	, 80,".T."					,.F.})

llRet := ParamBox(aParamBox, "Parโmetros", aParams, , /*alButtons*/, .T., /*nlPosx*/, /*nlPosy*/,, /*clLoad*/,.T.,.T.)

Return llRet
