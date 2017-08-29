#INCLUDE "PROTHEUS.CH"
#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"

#Define Enter Chr(13)+Chr(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR120  ºAutor  ³Microsiga           º Data ³  03/13/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function PR120JOB(aDados)

Default aDados:={"01","03"}
RpcSetEnv(aDados[1],aDados[2])

U_Pr120ReCalc()

RpcClearEnv()

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR120  ºAutor  ³Lucas Felipe     º Data ³  02/05/13      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function NcgPr120()
Private cCadastro := "Tabela de Preço - Ecommerce"
Private aRotina := MenuDef()

DbSelectArea("ZC4")
mBrowse( 6,1,22,75,"ZC4",,,,,,,,,,,,,,"ZC4_FLAG='1'")
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PR120BRW  ºAutor  ³Lucas Felipe        º Data ³  02/05/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function PR120BRW(cAlias,nReg,nOpc)

Local oDlg
Local lGravar		:= .F.
Local aArea		:= GetArea()
Local aSize   	:= MsAdvSize()
Local aObjects	:= {}
Local aCpoCab		:= {"ZC4_CODTAB","ZC4_TABDES","ZC4_PESSOA","ZC4_TCONSU","ZC4_TABBAS","ZC4_EST","ZC4_PERFRT","ZC4_DESP","NOUSER"}
Local aCpoGrid	:= {"ZC4_ITEM","ZC4_CODPRO","ZC4_DESCRI","ZC4_PRCBAS","ZC4_PRCCIA","ZC4_CIAOFE","ZC4_DTINIO","ZC4_DTFIMO","ZC4_PERIPI","ZC4_ALIINT","ZC4_ALIEXT","ZC4_MARGEM","ZC4_ALIDST","ZC4_BSICM","ZC4_BICMST","ZC4_TESINT"}
Local aInfo		:= {}
Local aPosObj		:= {}
Local aPosFld		:= {}
Local aObjFld		:= {}
Local bOk			:= {|| Iif(Obrigatorio(aGets,aTela),(lGravar:=.T.,oDlg:End()),) }
Local bCancel		:= {|| lGravar:=.F.,oDlg:End() }
Local aButtons	:= {}
Local aFolders	:= {OemToAnsi('Itens Tabela de Preço - ECommerce')}

Local nOpcy		:= IIf( (nOpc==3 .Or. nOpc==4),GD_INSERT+GD_UPDATE+GD_DELETE,0 )

Local cSeekKey	:= xFilial("ZC4")+ZC4->ZC4_CODTAB
Local bSeekWhile	:= {|| ZC4_FILIAL+ZC4_CODTAB+ZC4_FLAG }
Local uSeekFor	:= {}

Local oGetCanal
Local aHeadCanal	:= {}
Local aColsCanal	:= {}

Private oFolder
Private oGetCliente
Private oGetNoCliente

Private aTELA[0][0],aGETS[0]


RegToMemory("ZC4",nOpc==3)
//FillGetDados ( < nOpc>, < cAlias>, [ nOrder], [ cSeekKey], [ bSeekWhile], [ uSeekFor], [ aNoFields], [ aYesFields], [ lOnlyYes], [ cQuery], [ bMontCols], [ lEmpty], [ aHeaderAux], [ aColsAux], [ bAfterCols], [ bBeforeCols], [ bAfterHeader], [ cAliasQry], [ bCriaVar], [ lUserFields], [ aYesUsado] ) --> lRet

//Tabela de preço ecommerce
ZC4->(FillGetDados ( nOpc, "ZC4",4, cSeekKey+"2", bSeekWhile,  /*uSeekFor*/, /*aNoFields*/, aCpoGrid, .T., /*[ cQuery]*/, /*[bMontCols]*/, nOpc==3, aHeadCanal, aColsCanal, /*[ bAfterCols]*/, /*[ bBeforeCols]*/, /*[ bAfterHeader]*/, /*[ cAliasQry]*/, /*[ bCriaVar]*/, .F., aCpoGrid))

If Inclui .Or. Altera
	aColsCanal[1,GdFieldPos("ZC4_ITEM",aHeadCanal)] := StrZero(1,Len(ZC4->ZC4_ITEM))
Endif

aSizeAut	:= MsAdvSize(,.F.,400)
AAdd( aObjects, { 0,    70, .T., .F. } )
AAdd( aObjects, { 100, 100, .T., .T. } )

aInfo := { aSizeAut[ 1 ], aSizeAut[ 2 ], aSizeAut[ 3 ], aSizeAut[ 4 ], 3, 3 }
aPosObj := MsObjSize( aInfo, aObjects )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Calcula o Size para os Folders³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Aadd( aObjFld, {   1  ,  1, .T., .T. } )
aInfoFld := {1,1,aPosObj[2,4] - aPosObj[2,2] ,aPosObj[2,3] - aPosObj[2,1],3,3}
aPosFld := MsObjSize( aInfoFld, aObjFld )

DEFINE MSDIALOG oDlg TITLE OemtoAnsi("Tabela de Preços CiaShop") From aSize[7],0 To aSize[6],aSize[5] of oMainWnd PIXEL

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Monta a Enchoice superior com? os Dados da Carga³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Enchoice( "ZC4", nReg, nOpc, , , , aCpoCab, {aPosObj[1,1],aPosObj[1,2],aPosObj[1,3],aPosObj[1,4]},, 1, , ,"AllwaysTrue()", oDlg, .F.,  .T., .F., , .T., .F.)
oFolder := TFolder():New(aPosObj[2,1],aPosObj[2,2],aFolders,{'','',''},oDlg,,,,.T.,.F.,aPosObj[2,4]-aPosObj[2,2],aPosObj[2,3]-aPosObj[2,1])
nGd1 := 2
nGd2 := 2
nGd3 := aPosObj[2,3]-aPosObj[2,1]-15
nGd4 := aPosObj[2,4]-aPosObj[2,2]-4


//MsNewGetDados(): New ( [ nTop], [ nLeft], [ nBottom], [ nRight ], [ nStyle], [ cLinhaOk], [ cTudoOk], [ cIniCpos], [ aAlter], [ nFreeze], [ nMax], [ cFieldOk], [ cSuperDel], [ cDelOk], [ oWnd], [ aPartHeader], [ aParCols], [ uChange], [ cTela] ) --> Objeto

//oGetCanal:= MsNewGetDados():New(nGd1,nGd2,nGd3,nGd4,nOpcy,"AllwaysTrue","AllwaysTrue","+ZC4_ITEM",/*aCpoEnable*/,/*nFreeze*/,/*nMax*/,/*cFieldOk*/,/*cSuperDel*/,/*cDelOk*/ ,oFolder:aDialogs[1],aHeadCanal,aColsCanal)
oGetCanal:= MsNewGetDados():New(nGd1,nGd2,nGd3,nGd4,nOpcy,"AllwaysTrue","AllwaysTrue","+ZC4_ITEM",/*aCpoEnable*/,/*nFreeze*/,/*nMax*/,/*cFieldOk*/,/*cSuperDel*/,/*cDelOk*/,oFolder:aDialogs[1],aHeadCanal,aColsCanal)


ACTIVATE MSDIALOG oDlg ON INIT ( EnchoiceBar(oDlg,bOk,bCancel,,aButtons) )

If nOpc<>2 .And. lGravar
	Begin Transaction
	Processa( {|| PR120GRV(nOpc,aCpoCab,aHeadCanal,oGetCanal:aCols) } )
	End Transaction
ElseIf __lSX8
	RollBackSX8()
EndIf

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PR120GRV  ºAutor  ³Lucas Felipe        º Data ³  02/05/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PR120GRV(nOpc,aCpoCab,aHeadCanal,aColsCanal)
Local cFilZC4	:=xFilial("ZC4")
Local cChaveZC4:=cFilZC4+M->ZC4_CODTAB
Local nInd

If nOpc==5 // Exclusao
	ZC4->(DbSetOrder(4))
	ZC4->(DbSeek(cChaveZC4))
	ZC4->( DbEval( {|| RecLock("ZC4",.F.),DbDelete(),MsUnLock()  },{|| ZC4_FILIAL+ZC4_CODTAB==cChaveZC4  },{|| .T. }  )    )
Else
	If nOpc==4//Alterar
		ZC4->(DbSetOrder(4))
		ZC4->(DbSeek(cChaveZC4+"1"))
	EndIf
	ZC4->(RecLock("ZC4",nOpc==3))
	For nInd:=1 To Len(aCpoCab)
		If (nPosCpo:=ZC4->(FieldPos(aCpoCab[nInd]) ))>0
			ZC4->( FieldPut(nPosCpo, M->&(aCpoCab[nInd]) ) )
		EndIf
	Next
	ZC4->ZC4_FILIAL:=cFilZC4
	ZC4->ZC4_FLAG:="1"
	
	For nInd:=1 To Len(aColsCanal)
		If !Empty(GdFieldGet("ZC4_CODPRO",nInd,,aHeadCanal,aColsCanal))
			R120GrvItens(aHeadCanal,aColsCanal,nInd,"2",cFilZC4)
		EndIf
	Next
	
	ConfirmSX8()
EndIf

Return .T.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³R120GrvItens  ºAutor  ³Lucas Felipe    º Data ³  01/28/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function R120GrvItens(aHeader,aCols,nInd,cFlag,cFilZC4)
Local nPosRec	:= GdFieldPos("ZC4_REC_WT",aHeader)
Local nColuna
Local lTemRecno:= .F.
Local nYnd

If aCols[nInd,nPosRec]>0
	ZC4->( DbGoTo( aCols[nInd,nPosRec] ) )
	lTemRecno:=.T.
EndIf

If GdDeleted( nInd , aHeader , aCols )
	If lTemRecno
		ZC4->(RecLock("ZC4",.F.))
		ZC4->(dbDelete())
		ZC4->(MsUnLock())
	EndIf
Else
	ZC4->(RecLock("ZC4",!lTemRecno))
	For nYnd:=1 To Len(aHeader)
		nColuna:=ZC4->(FieldPos(aHeader[nYnd,2]))
		If nColuna>0
			ZC4->(FieldPut(nColuna,GdFieldGet(aHeader[nYnd,2],nInd,,aHeader,aCols)))
		EndIf
	Next
	ZC4->ZC4_FILIAL:= cFilZC4
	ZC4->ZC4_CODTAB:= M->ZC4_CODTAB
	ZC4->ZC4_FLAG	:= cFlag
EndIf


Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MenuDef   ºAutor  ³Lucas Felipe        º Data ³  01/27/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function MenuDef()
Local aRotina

aRotina	:= {{"Pesquisar"				,""					,0,1},;
{"Visualizar"			,"U_P120BRW('V')"	,0,2},;
{"Incluir"	  			,"U_PR120BRW"		,0,3},;
{"Excluir"				,"U_P120BRW('E')"	,0,5},;
{"Recalcular Preços"	,"U_Pr120Proc"	,0,4},;
{"Alterar"				,"U_PR120BRW" 		,0,4},;
{"Incluir preços"		,"U_Pr120Inc"		,0,3}}

Return aRotina


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³Pr120Inc  ºAutor  ³Lucas Felipe        º Data ³  01/28/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function Pr120Inc(cCodZC4,cTabBase,cUFTab)

Local cAliasZC4 := ZC4->(GetArea())
Local cAliasSQL := GetNextAlias()
Local lRecalc	:= IsInCallStack("U_PR120ReCalc")

If lRecalc
	ZC4->(DbGoTop())
	ZC4->(dbSetOrder(3))
	ZC4->(DbSeek(cFilZC4+cCodZC4+cTabBase+cUFTab))
Else
	cTabBase:= ZC4->ZC4_TABBAS
	cUFTab	:= ZC4->ZC4_EST
	cCodZC4	:= ZC4->ZC4_CODTAB
	cFilZC4	:= xFilial("ZC4")
EndIf


While !(ZC4->(EOF())) .And. cFilZC4 == ZC4->ZC4_FILIAL .And. cCodZC4 == ZC4->ZC4_CODTAB .And. ZC4->ZC4_FLAG == "1"
	
	cTabBase := ZC4->ZC4_TABBAS
	cUFTab	:= ZC4->ZC4_EST
	cCodZC4	:= ZC4->ZC4_CODTAB
	nFrtZC4	:= ZC4->ZC4_PERFRT
	nDespZC4	:= ZC4->ZC4_DESP
	
	cQuery:= ""
	cQuery+= "SELECT SF7.F7_EST, "+CRLF
	cQuery+= "		SB1.B1_COD, "+CRLF
	cQuery+= "		SB1.B1_XDESC, "+CRLF
	cQuery+= "		SB1.B1_POSIPI, "+CRLF
	cQuery+= "		SB1.B1_GRTRIB, "+CRLF
	cQuery+= "		SB1.B1_IPI, "+CRLF
	cQuery+= "		DA1.DA1_PRCVEN, "+CRLF
	cQuery+= "		SF7.F7_ALIQINT, "+CRLF
	cQuery+= "		SF7.F7_ALIQEXT, "+CRLF
	cQuery+= "		SF7.F7_MARGEM, "+CRLF
	cQuery+= "		SF7.F7_ALIQDST, "+CRLF
	cQuery+= "		SFM.FM_TS, "+CRLF
	cQuery+= "		SF4.F4_BASEICM, "+CRLF
	cQuery+= "		SF4.F4_BSICMST "+CRLF
	cQuery+= "FROM " +RetSqlName("SB1")+ " SB1 "+CRLF
	cQuery+= "	LEFT OUTER JOIN " +RetSqlName("DA1")+ " DA1 "+CRLF
	cQuery+= "	ON DA1.D_E_L_E_T_ = ' ' "+CRLF
	cQuery+= "	AND DA1.DA1_FILIAL = '"+ xFilial("DA1") +"' "+CRLF
	cQuery+= "	AND DA1.DA1_CODPRO = SB1.B1_COD "+CRLF
	cQuery+= "	LEFT OUTER JOIN " +RetSqlName("SF7")+ " SF7 "+CRLF
	cQuery+= "	ON SF7.D_E_L_E_T_ = ' ' "+CRLF
	cQuery+= "	AND SF7.F7_FILIAL = '"+xFilial("SF7")+"' "+CRLF
	cQuery+= "	AND SF7.F7_GRTRIB = SB1.B1_GRTRIB "+CRLF
	cQuery+= "	AND SF7.F7_GRPCLI = 'SOL' "+CRLF
	cQuery+= "	AND SF7.F7_EST = '"+ cUFTab +"' "+CRLF
	cQuery+= "			LEFT OUTER JOIN " +RetSqlName("SFM")+ " SFM "+CRLF
	cQuery+= "			ON SFM.FM_GRTRIB = 'SOL' "+CRLF
	cQuery+= "			AND SFM.FM_CLIENTE = ' ' "+CRLF
	cQuery+= "			AND SFM.FM_LOJACLI = ' ' "+CRLF
	cQuery+= "			AND SFM.FM_EST = '"+ cUFTab +"' "+CRLF
	cQuery+= "			AND SFM.FM_GRPROD = SB1.B1_GRTRIB "+CRLF
	cQuery+= "			AND SFM.D_E_L_E_T_ = ' ' "+CRLF
	cQuery+= "			AND SFM.FM_FILIAL = '"+xFilial("SFM")+"' "+CRLF
	cQuery+= "			AND SFM.FM_TIPO = '01' "+CRLF //Tipo de Operação de Vendas
	cQuery+= "				LEFT OUTER JOIN " +RetSqlName("SF4")+ " SF4 "+CRLF
	cQuery+= "				ON SF4.F4_FILIAL = '"+xFilial("SF4")+"' "+CRLF
	cQuery+= "				AND SF4.D_E_L_E_T_ = ' ' "+CRLF
	cQuery+= "				AND SFM.FM_TS = SF4.F4_CODIGO "+CRLF
	cQuery+= "				AND SF4.F4_MSBLQL = '2' "+CRLF
	cQuery+= "WHERE SB1.D_E_L_E_T_ = ' ' "+CRLF
	cQuery+= "AND DA1.DA1_CODTAB = '"+ cTabBase +"' "+CRLF
	cQuery+= "AND SB1.B1_MSBLQL = '2' "+CRLF
	cQuery+= "AND NOT EXISTS (SELECT ZC4_CODPRO FROM " +RetSqlName("ZC4")+ " ZC4 "+CRLF
	cQuery+= "				WHERE ZC4.D_E_L_E_T_ = ' ' "+CRLF
	cQuery+= "				AND ZC4.ZC4_CODTAB = '"+ cCodZC4 +"' "+CRLF
	cQuery+= "				AND ZC4.ZC4_CODPRO = SB1.B1_COD) "+CRLF
	cQuery+= "AND SB1.B1_COD IN (SELECT ZC3.ZC3_CODPRO FROM " +RetSqlName("ZC3")+ " ZC3 "+CRLF
	cQuery+= "					WHERE ZC3.D_E_L_E_T_ = ' '"+CRLF
	cQuery+= "					AND ZC3.ZC3_STATUS IN ('01','03'))"+CRLF
	
	cQuery := ChangeQuery(cQuery)
	
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSQL,.T.,.T.)
	
	cItem:=StrZero(0,Len(ZC4->ZC4_ITEM))
	
	While !((cAliasSQL)->(EOF()))
		Reclock("ZC4",.T.)
		cItem:=Soma1(cItem)
		
		ZC4->ZC4_CODTAB	:= cCodZC4
		ZC4->ZC4_TABBAS	:= cTabBase
		ZC4->ZC4_EST  	:= cUFTab
		ZC4->ZC4_ITEM	:= cItem
		ZC4->ZC4_CODPRO	:= (cAliasSQL)->B1_COD
		ZC4->ZC4_DESCRI	:= (cAliasSQL)->B1_XDESC
		ZC4->ZC4_PRCBAS	:= (cAliasSQL)->DA1_PRCVEN
		ZC4->ZC4_PERFRT	:= nFrtZC4
		ZC4->ZC4_DESP	:= nDespZC4
		ZC4->ZC4_PERIPI	:= (cAliasSQL)->B1_IPI
		ZC4->ZC4_ALIINT	:= (cAliasSQL)->F7_ALIQINT
		ZC4->ZC4_ALIEXT	:= (cAliasSQL)->F7_ALIQEXT
		ZC4->ZC4_MARGEM	:= (cAliasSQL)->F7_MARGEM
		If (cAliasSQL)->F7_ALIQDST == 0
			cAliqDST:= Alltrim(SuperGetMv("MV_ESTICM",.T.,""))
			cAliqST := SubStr(cAliqDST,(At(cUFTab,cAliqDST))+2,2)
			nAliqDST:= Val(cAliqST)
			ZC4->ZC4_ALIDST:= nAliqDST
		Else
			ZC4->ZC4_ALIDST:= (cAliasSQL)->F7_ALIQDST
		EndIf
		ZC4->ZC4_TESINT	:=(cAliasSQL)->FM_TS
		ZC4->ZC4_BSICM		:=(cAliasSQL)->F4_BASEICM
		ZC4->ZC4_BICMST	:=(cAliasSQL)->F4_BSICMST
		ZC4->ZC4_FLAG		:= "2"
		
		//If cUFTab == "PR"
		//	ZC4->ZC4_PRCCIA	:=	U_Pr120STRet((cAliasSQL)->B1_COD,(cAliasSQL)->DA1_PRCVEN,(cAliasSQL)->FM_TS)
		///Else
		ZC4->ZC4_PRCCIA	:=	Pr120Calc()
		//EndIf
		
		MsUnLock()
		
		(cAliasSQL)->(DbSkip())
	End
	If !lRecalc
		MsgAlert("A inclusão de preços na tabela "+cCodZC4+" foi feita com sucesso")
	EndIf
	ZC4->(DbSkip())
End

//If !lRecalc // Inativado, pois a gestão dos preços e a inclusão na tabela CON é de responsabilidade do Ecommerce.
//	P120CONS() //Buscar informações de produtos cadastros para compor a tabela CON.
//EndIf

(cAliasSQL)->(DbCloseArea())

Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³Pr120Calc  ºAutor  ³Lucas Felipe       º Data ³  01/27/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function Pr120Calc()

nPrecoBase	:= ZC4->ZC4_PRCBAS
nPerFrete	:= (ZC4->ZC4_PERFRT/100)
nPerDesp	:= (ZC4->ZC4_DESP/100)

nPerIPI		:= (ZC4->ZC4_PERIPI/100)

nPerAliInt	:= (ZC4->ZC4_ALIINT/100)
nPerAliExt	:= (ZC4->ZC4_ALIEXT/100)
nPerMrgLcr	:= (ZC4->ZC4_MARGEM/100)
nPerAliqST	:= (ZC4->ZC4_ALIDST/100)
nPRedICM	:= ZC4->ZC4_BSICM
nPerRedICM	:= ((100-ZC4->ZC4_BSICM)/100)
nPRedST	 	:= ZC4->ZC4_BICMST
nPerRedST 	:= ((100-ZC4->ZC4_BICMST)/100)

nPrcFrete	:= (nPrecoBase*nPerFrete)
nPrcDesp	:= (nPrecoBase*nPerDesp)

nPrcFrtD	:= nPrcFrete + nPrcDesp + nPrecoBase

nBaseIva	:= (nPrcFrtD * nPerIPI)+nPrcFrtD

nVlrAdic	:= (nBaseIva * nPerMrgLcr)

nVlrBase	:= (nBaseIva + nVlrAdic)

If nPRedST != 0
	nVlrBsRed:= (nVlrBase*nPerRedST)
	nVlrBase := nVlrBase - nVlrBsRed
EndIf

nVlrICMSST:= (nVlrBase*nPerAliqST)

If nPerAliExt == 0
	nVlrPropio:= (nPrcFrtD*nPerAliInt)
Else
	nVlrPropio:= (nPrcFrtD*nPerAliExt)
EndIf

If nPRedICM != 0
	nVlrProRed:= (nVlrPropio*nPerRedICM)
	nVlrPropio:= nVlrPropio - nVlrProRed
EndIf

nVlrST	 := nVlrICMSST-nVlrPropio


If nPerMrgLcr == 0 //se Margem Lucro for igual a 0 significa que o item não tem ICMS-ST
	nPrecoST	:= nBaseIva
Else
	nPrecoST	:= (nBaseIva + nVlrST)
Endif

Return nPrecoST

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³Pr120ReCalc  ºAutor  ³Lucas Felipe     º Data ³  01/27/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function Pr120ReCalc()

Local lPr120Job	:= IsInCallStack("U_PR120JOB")
Local cAliasZC4	:= ZC4->(GetArea())
Local cAliasTRB	:= ""
Local cAliasFIL	:= GetNextAlias()
Local cQry:= ""

Local nVlrAnt		:= 0
Local nVlrOfe		:= 0
Local nVlrNew		:= 0
Local nDiasVenc	:= U_MyNewSx6("EC_NCG0026","30","N","Dias para o vencimento das ofertas no Ecommerce B2B","","",.F. )
Local nPToleran	:= U_MyNewSx6("EC_NCG0027","5","N","Percentual de tolerancia de alteração de preço no Ecommerce B2B","","",.F. )
/* nPToleran *Percentual de tolerancia de preço, quando os produto tiver uma variação > que a deste preço */

Local lOferta		:= .F.

Private cFilZC4	:= xFilial("ZC4")


cQry:= " SELECT ZC4_CODTAB,ZC4_TABBAS,ZC4_EST,ZC4_DESP,ZC4_PERFRT "+CRLF
cQry+= " FROM "+RetSqlName("ZC4")+ " ZC4 "+CRLF
cQry+= " WHERE ZC4.ZC4_FILIAL = '"+xFilial("ZC4")+"' "+CRLF
cQry+= " AND ZC4.ZC4_FLAG = '1' "+CRLF
cQry+= " AND ZC4.D_E_L_E_T_ = ' ' "+CRLF
cQry+= " AND ZC4.ZC4_PESSOA = 'J' "+CRLF
cQry := ChangeQuery(cQry)

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),cAliasFIL,.T.,.T.)


While !((cAliasFIL)->(EOF()))
	
	cAliasTRB	:= GetNextAlias()
	
	cTabBase	:= (cAliasFIL)->ZC4_TABBAS
	cUFTab		:= (cAliasFIL)->ZC4_EST
	cCodZC4	:= (cAliasFIL)->ZC4_CODTAB
	nFrtZC4	:= (cAliasFIL)->ZC4_PERFRT
	nDespZC4	:= (cAliasFIL)->ZC4_DESP
	
	cQuery := ""
	cQuery += " SELECT SF7.F7_EST, "+CRLF
	cQuery += "		SB1.B1_COD, "+CRLF
	cQuery += "		SB1.B1_XDESC, "+CRLF
	cQuery += "		SB1.B1_POSIPI, "+CRLF
	cQuery += "		SB1.B1_GRTRIB, "+CRLF
	cQuery += "		SB1.B1_IPI, "+CRLF
	cQuery += "		DA1.DA1_PRCVEN, "+CRLF
	cQuery += "		SF7.F7_ALIQINT, "+CRLF
	cQuery += "		SF7.F7_ALIQEXT, "+CRLF
	cQuery += "		SF7.F7_MARGEM, "+CRLF
	cQuery += "		SF7.F7_ALIQDST, "+CRLF
	cQuery += "		SFM.FM_TS, "+CRLF
	cQuery += "		SF4.F4_BASEICM, "+CRLF
	cQuery += "		SF4.F4_BSICMST "+CRLF
	cQuery += " FROM " +RetSqlName("SB1")+ " SB1 "+CRLF
	
	cQuery += "		LEFT OUTER JOIN " +RetSqlName("DA1")+ " DA1 "+CRLF
	cQuery += "		ON DA1.D_E_L_E_T_ = ' ' "+CRLF
	cQuery += "		AND DA1.DA1_FILIAL = '"+ xFilial("DA1") +"' "+CRLF
	cQuery += "		AND DA1.DA1_CODPRO = SB1.B1_COD "+CRLF
	
	cQuery += "		LEFT OUTER JOIN " +RetSqlName("SF7")+ " SF7 "+CRLF
	cQuery += "		ON SF7.D_E_L_E_T_ = ' ' "+CRLF
	cQuery += "		AND SF7.F7_FILIAL = '"+xFilial("SF7")+"' "+CRLF
	cQuery += "		AND SF7.F7_GRTRIB = SB1.B1_GRTRIB "+CRLF
	cQuery += "		AND SF7.F7_GRPCLI = 'SOL' "+CRLF
	cQuery += "		AND SF7.F7_EST = '"+ cUFTab +"' "+CRLF
	
	cQuery += "			LEFT OUTER JOIN " +RetSqlName("SFM")+ " SFM "+CRLF
	cQuery += "			ON SFM.FM_GRTRIB = 'SOL' "+CRLF
	cQuery += "			AND SFM.FM_CLIENTE = ' ' "+CRLF
	cQuery += "			AND SFM.FM_LOJACLI = ' ' "+CRLF
	cQuery += "			AND SFM.FM_EST = '"+ cUFTab +"' "+CRLF
	cQuery += "			AND SFM.FM_GRPROD = SB1.B1_GRTRIB "+CRLF
	cQuery += "			AND SFM.D_E_L_E_T_ = ' ' "+CRLF
	cQuery += "			AND SFM.FM_FILIAL = '"+xFilial("SFM")+"' "+CRLF
	cQuery += "			AND SFM.FM_TIPO = '01' "+CRLF //Tipo de Operação de Vendas
	
	cQuery += "				LEFT OUTER JOIN " +RetSqlName("SF4")+ " SF4 "+CRLF
	cQuery += "				ON SF4.F4_FILIAL = '"+xFilial("SF4")+"' "+CRLF
	cQuery += "				AND SF4.D_E_L_E_T_ = ' ' "+CRLF
	cQuery += "				AND SFM.FM_TS = SF4.F4_CODIGO "+CRLF
	cQuery += "				AND SF4.F4_MSBLQL = '2' "+CRLF
	
	cQuery += " WHERE SB1.D_E_L_E_T_ = ' ' "+CRLF
	cQuery += " AND DA1.DA1_CODTAB = '"+ cTabBase +"' "+CRLF
	cQuery += " AND SB1.B1_MSBLQL = '2' "+CRLF
	cQuery += " AND SB1.B1_COD IN (SELECT ZC3.ZC3_CODPRO FROM " +RetSqlName("ZC3")+ " ZC3 "+CRLF
	cQuery += "					WHERE ZC3.D_E_L_E_T_ = ' '"+CRLF
	cQuery += " 					AND ZC3.ZC3_STATUS IN ('01','03'))"+CRLF
	
	
	cQuery := ChangeQuery(cQuery)
	
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasTRB,.T.,.T.)
	
	While !((cAliasTRB)->(EOF()))
		
		ZC4->(dbSetOrder(2))//ZC4_FILIAL+ZC4_CODTAB+ZC4_CODPRO
		If ZC4->(DbSeek(cFilZC4+cCodZC4+(cAliasTRB)->B1_COD))
			
			ZC4->(Reclock("ZC4",.F.))
			
			ZC4->ZC4_CODTAB	:= cCodZC4
			ZC4->ZC4_TABBAS	:= cTabBase
			ZC4->ZC4_EST		:= cUFTab
			ZC4->ZC4_CODPRO	:= (cAliasTRB)->B1_COD
			ZC4->ZC4_DESCRI	:= (cAliasTRB)->B1_XDESC
			ZC4->ZC4_PRCBAS	:= (cAliasTRB)->DA1_PRCVEN
			ZC4->ZC4_PERFRT	:= nFrtZC4
			ZC4->ZC4_DESP		:= nDespZC4
			ZC4->ZC4_PERIPI	:= (cAliasTRB)->B1_IPI
			ZC4->ZC4_ALIINT	:= (cAliasTRB)->F7_ALIQINT
			ZC4->ZC4_ALIEXT	:= (cAliasTRB)->F7_ALIQEXT
			ZC4->ZC4_MARGEM	:= (cAliasTRB)->F7_MARGEM
			
			If (cAliasTRB)->F7_ALIQDST == 0
				cAliqDST:= Alltrim(SuperGetMv("MV_ESTICM",.T.,""))
				cAliqST := SubStr(cAliqDST,(At(cUFTab,cAliqDST))+2,2)
				nAliqDST:= Val(cAliqST)
				
				ZC4->ZC4_ALIDST:= nAliqDST
			Else
				ZC4->ZC4_ALIDST:= (cAliasTRB)->F7_ALIQDST
			EndIf
			
			ZC4->ZC4_TESINT	:=(cAliasTRB)->FM_TS
			ZC4->ZC4_BSICM	:=(cAliasTRB)->F4_BASEICM
			ZC4->ZC4_BICMST	:=(cAliasTRB)->F4_BSICMST
			ZC4->ZC4_FLAG		:= "2"
			
			/*-------------------------------------//
			// Melhoria Preço De/Por					 //
			//-------------------------------------*/
			lOferta := .f.
			nVlrAnt	:= ZC4->ZC4_PRCCIA
			nVlrOfe	:= ZC4->ZC4_CIAOFE
			nVlrNew	:= Pr120Calc()
			nNewTole:= nVlrNew + (nVlrNew*(nPToleran/100)) 
			
			If ZC4->ZC4_CIAOFE == 0
				lOferta := .T.
			Else
				If !Empty(ZC4->ZC4_DTFIMO)
					If !((ZC4->ZC4_DTFIMO) - MsDate() > 0)
						ZC4->ZC4_PRCCIA	:=	nVlrNew
						ZC4->ZC4_CIAOFE 	:= 0
					Else
						If nVlrOfe <	nNewTole
							ZC4->ZC4_PRCCIA	:=	nVlrNew
							ZC4->ZC4_CIAOFE 	:= 0
						Else
							ZC4->ZC4_PRCCIA	:=	nVlrNew
						EndIf
					EndIf
				Else
					lOferta := .T.
				EndIf
			EndIf
			
			If lOferta
				If 	nVlrAnt ==	nVlrNew
					ZC4->ZC4_PRCCIA	:=	nVlrNew
					ZC4->ZC4_CIAOFE 	:= 0
				ElseIf nVlrAnt < nNewTole
					ZC4->ZC4_PRCCIA	:=	nVlrNew
					ZC4->ZC4_CIAOFE 	:= 0
				Else
					ZC4->ZC4_PRCCIA	:=	nVlrNew
					ZC4->ZC4_DTINIO	:= MsDate()
					ZC4->ZC4_DTFIMO 	:= MsDate() + nDiasVenc
					ZC4->ZC4_CIAOFE 	:= nVlrAnt
				EndIf
			EndIf
			
			ZC4->(MsUnLock())
			
			(cAliasTRB)->(DbSkip())
		Else
			
			ZC4->(Reclock("ZC4",.T.))
			
			cItem:= LastItem(cCodZC4)
			
			ZC4->ZC4_CODTAB	:= cCodZC4
			ZC4->ZC4_TABBAS	:= cTabBase
			ZC4->ZC4_EST  	:= cUFTab
			ZC4->ZC4_ITEM		:= cItem
			ZC4->ZC4_CODPRO	:= (cAliasTRB)->B1_COD
			ZC4->ZC4_DESCRI	:= (cAliasTRB)->B1_XDESC
			ZC4->ZC4_PRCBAS	:= (cAliasTRB)->DA1_PRCVEN
			ZC4->ZC4_PERFRT	:= nFrtZC4
			ZC4->ZC4_DESP		:= nDespZC4
			ZC4->ZC4_PERIPI	:= (cAliasTRB)->B1_IPI
			ZC4->ZC4_ALIINT	:= (cAliasTRB)->F7_ALIQINT
			ZC4->ZC4_ALIEXT	:= (cAliasTRB)->F7_ALIQEXT
			ZC4->ZC4_MARGEM	:= (cAliasTRB)->F7_MARGEM
			
			If (cAliasTRB)->F7_ALIQDST == 0
				cAliqDST	:= Alltrim(SuperGetMv("MV_ESTICM",.T.,""))
				cAliqST 	:= SubStr(cAliqDST,(At(cUFTab,cAliasTRB))+2,2)
				nAliqDST	:= Val(cAliqST)
				
				ZC4->ZC4_ALIDST := nAliqDST
			Else
				ZC4->ZC4_ALIDST := (cAliasTRB)->F7_ALIQDST
			EndIf
			ZC4->ZC4_TESINT	:= (cAliasTRB)->FM_TS
			ZC4->ZC4_BSICM	:=(cAliasTRB)->F4_BASEICM
			ZC4->ZC4_BICMST	:= (cAliasTRB)->F4_BSICMST
			ZC4->ZC4_FLAG		:= "2"
			
			ZC4->ZC4_PRCCIA	:=	Pr120Calc()
			
			ZC4->(MsUnLock())
		EndIf
	End
	
	(cAliasTRB)->(DbCloseArea())
	
	(cAliasFIL)->(DbSkip())
End

//P120CONS() //Função para ZC4 - Pessoa Fisica
PR120DEL() //Função para deletar os itens que não estão ativos na ZC3(Produtos que vão para o site)
//PrCon120() //Função para criar e atualizar uma tabela de preço "CON"
Tab120Con()


MsgAlert("As tabelas foram atualizadas com sucesso")
(cAliasFIL)->(DbCloseArea())


Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR120  ºAutor  ³Lucas Felipe        º Data ³  02/19/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PR120DEL()

Local cAliasZC4 := ZC4->(GetArea())
Local cQueryDel := GetNextAlias()
Local cTabB2C   := Alltrim(U_MyNewSX6("VT_000010","028" ,"C","Codigo Tabela de Preco Consumidor","","",.F. ))

cQry:= "SELECT ZC4.R_E_C_N_O_ ZC4REC "+CRLF
cQry+= "FROM " +RetSqlName("ZC4")+ " ZC4 "+CRLF
cQry+= "WHERE ZC4.ZC4_FLAG = '2' "+CRLF
cQry+= "AND ZC4.D_E_L_E_T_ = ' ' "+CRLF
cQry+= "AND ZC4.ZC4_CODTAB NOT IN ('"+ cTabB2C +"') "+CRLF
cQry+= "AND ZC4.ZC4_CODPRO NOT IN (SELECT ZC3.ZC3_CODPRO FROM " +RetSqlName("ZC3")+ " ZC3 "+CRLF
cQry+= "					  					WHERE ZC3.ZC3_FILIAL = '"+xFilial("ZC3")+"' "+CRLF
cQry+= "					  			   	AND ZC3.D_E_L_E_T_ = ' ' "+CRLF
cQry+= "					  			   	AND ZC3.ZC3_STATUS <> '02') "+CRLF

cQry := ChangeQuery(cQry)

dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),cQueryDel,.T.,.T.)

While !((cQueryDel)->(EOF()))
	
	ZC4->(DbGoTo((cQueryDel)->ZC4REC))
	ZC4->(Reclock("ZC4",.F.))
	
	ZC4->(DbDelete())
	
	ZC4->(MsUnLock())
	
	(cQueryDel)->(DbSkip())
	
EndDo

(cQueryDel)->(DbCloseArea())

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³P120CCalc ºAutor  ³Lucas Felipe        º Data ³  02/28/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Calcula o valor de PrcCia para Pessoa Fisica               º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function P120CCalc()

Local nPDesc  := SuperGetMV("NCG_ECOM",.T.,15)
Local nPrcCia := 0

nPrecoBase	:= ZC4->ZC4_PRCBAS
nPerFrete	:= nPrecoBase*(ZC4->ZC4_PERFRT/100)
nPerDesp	:= nPrecoBase*(ZC4->ZC4_DESP/100)
nPerIPI		:= nPrecoBase*(ZC4->ZC4_PERIPI/100)
nPerDesc	:= nPrecoBase*0.15/*(nPDesc/100)*/

If ZC4->ZC4_TCONSU == "2"
	nPrcCia := nPrecoBase-nPerDesc
ElseIf ZC4->ZC4_TCONSU == "1"
	nPrcCia := nPrecoBase+nPerFrete+nPerDesp+nPerIPI
EndIf

Return nPrcCia


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³P120Brw   ºAutor  ³Lucas Felipe        º Data ³  03/05/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Fonte responsavel pela utilização de rotinas padrão para   º±±
±±º          ³ "EXCLUIR" e "VISUALIZAR"                                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function P120Brw(cManutOpc)

If cManutOpc == 'E'
	AxDeleta("ZC4",ZC4->(Recno()),3)
EndIf

If cManutOpc == 'V'
	AxVisual("ZC4",ZC4->(Recno()),2)
EndIf

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PrCon120  ºAutor  ³Lucas Felipe        º Data ³  03/13/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Fonte responsavel de atualizar a tabela de preços de consu º±±
±±º          ³ midor final "CON"                                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function PrCon120()

Local cTabConsu := Alltrim(U_MyNewSX6("MV_NCTABCO","CON","C","Tabela de Preço consumidor","","",.F. )   )
Local cAliasDA1 := DA1->(GetArea())
Local dAtual 	:= MsDate()
Local cItem		:= strzero(0,4)
Local cNextItem	:= ""
Local cQuery	:= ""
Local cAliasSQL	:= GetNextAlias()
Local cFilDA1	:= xFilial("DA1")

DA1->(DbSetOrder(1))
DA1->(DbSeek(cFilDA1+cTabConsu),.T.)

cQuery := ""
cQuery += "SELECT DA1_CODPRO, b1_consumi, b1_xdesc "+CRLF
cQuery += "FROM "+RetSqlName("DA1")+" DA1 "+CRLF
cQuery += "		LEFT OUTER JOIN "+RetSqlName("SB1")+" SB1 "+CRLF
cQuery += "		ON SB1.D_E_L_E_T_ = ' ' "+CRLF
cQuery += "		AND DA1.DA1_CODPRO = SB1.B1_COD "+CRLF
cQuery += "		AND SB1.B1_MSBLQL = '2' "+CRLF
cQuery += "WHERE DA1.DA1_FILIAL = '"+cFilDA1+"' "+CRLF
cQuery += "AND DA1.D_E_L_E_T_ = ' ' "+CRLF
cQuery += "AND DA1.DA1_CODTAB = '018' "+CRLF //Os produtos que estiverem na tabela 018 devem estar na tabela de consumidor.
cQuery += "AND SB1.B1_CONSUMI > 0 "+CRLF


cQuery := ChangeQuery(cQuery)

dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSQL,.T.,.T.)

While !((cAliasSQL)->(EOF()))
	
	cCodPro := (cAliasSQL)->DA1_CODPRO
	
	If DA1->(DbSeek(cFilDA1+cTabConsu+cCodPro))
		DA1->(RecLock("DA1",.F.))
		
		DA1->DA1_PRCVEN  := (cAliasSQL)->B1_CONSUMI
		DA1->DA1_DATVIG  := dAtual
		
		DA1->(MsUnlock())
	Else
		DA1->(DbSeek(cFilDA1+cTabConsu))
		DA1->( DbEval( {|| cItem := DA1->DA1_ITEM},{|| .T. } ,{|| DA1->(DA1_FILIAL+DA1_CODTAB) == cFilDA1+cTabConsu  } )   )
		
		cNextItem := Soma1(cItem,4)
		
		DA1->(Reclock("DA1",.T.))
		
		DA1->DA1_FILIAL  := xFilial("DA1")
		DA1->DA1_ITEM    := cNextItem
		DA1->DA1_CODTAB  := cTabConsu
		DA1->DA1_CODPRO  := cCodPro
		DA1->DA1_PRCVEN  := (cAliasSQL)->B1_CONSUMI
		DA1->DA1_ATIVO   := "1"
		DA1->DA1_TPOPER  := "4"
		DA1->DA1_MOEDA   := 1
		
		DA1->DA1_DATVIG  := dAtual
		
		DA1->(MsUnlock())
	EndIf
	
	(cAliasSQL)->(DbSkip())
	
EndDo


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³Pr120Proc ºAutor  ³Lucas Felipe        º Data ³  04/08/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function Pr120Proc()

Local cMsgYes := "A Rotina de Recalculo pode demorar alguns minutos pois reprocessa todas as tabelas de preço. Deseja Prosseguir?"


If MsgYesno(cMsgYes)
	Processa( { ||U_Pr120ReCalc()}, "Aguarde...", "Processando tabela de preços...",.F.)
Else
	If MsgYesNo("Deseja executar a rotina somente para Ecommerce B2C?")
		Processa( { || Tab120Con()}, "Aguarde...", "Processando tabela de preços...",.F.)
	Else
		Return
	EndIf
EndIf

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³Pr120STRet ºAutor  ³Lucas Felipe       º Data ³  07/22/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function Pr120STRet(cCodPro,nPrcVen,cTes)
Local nItem 	:= 1
Local cCliePR	:= "000194"//TAKEAKI MURAOKA ME
Local cLojaPR	:= "01"
Local cCliTipo	:= "C"
Local cTipoNf	:= "N"

Local nQtdPR	:= 1
Local nDesconto	:= 0
Local cNfOri	:= Nil
Local cSeriOri	:= Nil
Local nRecnoSD1	:= Nil
Local nValMerc	:= nPrcVen

If cTes = " "
	cTes 	:= "666"
EndIf

nPrecoBase	:= nPrcVen
nPerFrete	:= (ZC4->ZC4_PERFRT/100)
nPerDesp	:= (ZC4->ZC4_DESP/100)

nPrcFrete:= (nPrecoBase*nPerFrete)
nPrcDesp	:= (nPrecoBase*nPerDesp)

MaFisSave()
MaFisClear()

MaFisIni(cCliePR,;	// 1-Codigo Cliente/Fornecedor
cLojaPR			,;	// 2-Loja do Cliente/Fornecedor
"C"				,;	// 3-C:Cliente , F:Fornecedor
cTipoNf			,;	// 4-Tipo da NF
cCliTipo		,;	// 5-Tipo do Cliente/Fornecedor
Nil				,;	// 6-Relacao de Impostos que suportados no arquivo
,;	// 7-Tipo de complemento
,;	// 8-Permite Incluir Impostos no Rodape .T./.F.
"SB1"			,;	// 9-Alias do Cadastro de Produtos - ("SBI" P/ Front Loja)
"U_NCGPR120")		// 10-Nome da rotina que esta utilizando a funcao

MaFisAdd(cCodPro,;	// 1-Codigo do Produto ( Obrigatorio )
cTes			,;	// 2-Codigo do TES ( Opcional )
nQtdPR			,;	// 3-Quantidade ( Obrigatorio )
nPrecoBase		,;	// 4-Preco Unitario ( Obrigatorio )
nDesconto		,;	// 5-Valor do Desconto ( Opcional )
cNfOri			,;	// 6-Numero da NF Original ( Devolucao/Benef )
cSeriOri		,;	// 7-Serie da NF Original ( Devolucao/Benef )
nRecnoSD1		,;	// 8-RecNo da NF Original no arq SD1/SD2
0				,;	// 9-Valor do Frete do Item ( Opcional )
0				,;	// 10-Valor da Despesa do item ( Opcional )
0				,;	// 11-Valor do Seguro do item ( Opcional )
0				,;	// 12-Valor do Frete Autonomo ( Opcional )
nValMerc		,;	// 13-Valor da Mercadoria ( Obrigatorio )
0				,;	// 14-Valor da Embalagem ( Opiconal )
0				,;	// 15-RecNo do SB1
0				)	// 16-RecNo do SF4

aBaseICMSST := U_NCGPR001(nItem)
nValSOL  	:= aBaseICMSST[2]
nAliqSOL	:= (nValSOL/aBaseICMSST[1])*100

nPrcVen := nPrecoBase + nValSOL + nPrcDesp + nPrcFrete

MaFisRestore()


Return nPrcVen


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR120  ºAutor  ³Microsiga           º Data ³  05/08/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function Tab120Con()

Local aAreaAtu	:= GetArea()
Local aAreaZC4	:= ZC4->(GetArea())

Local cQry	 		:= ""
Local cQryA		:= ""
Local cTipoCli	:= ""
Local cFilZC4 	:= xFilial("ZC4")

Local cQueryP		:= ""
Local cAliFisic	:= GetNextAlias()

Local cItem 		:= Space(04)

Local cTabPor		:= Alltrim(U_MyNewSX6("MV_NCTABCO","CON","C","Tabela de Preço consumidor","","",.F. )   )
Local cTabDe		:= Alltrim(U_MyNewSX6("MV_NCTABDE","CDE","C","Tabela de Preço consumidor","","",.F. )   )


cQry:= " SELECT ZC4_CODTAB,ZC4_PESSOA,ZC4_TCONSU,ZC4_TABBAS,ZC4_PERFRT,ZC4_DESP,ZC4_EST "+CRLF
cQry+= " FROM "+RetSqlName("ZC4")+ " ZC4 "+CRLF
cQry+= " WHERE ZC4.ZC4_FILIAL = '"+xFilial("ZC4")+"' "+CRLF
cQry+= " AND ZC4.ZC4_FLAG = '1' "+CRLF
cQry+= " AND ZC4.D_E_L_E_T_ = ' ' "+CRLF
cQry+= " AND ZC4.ZC4_PESSOA = 'F' "+CRLF

cQry := ChangeQuery(cQry)

dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),cAliFisic,.T.,.T.)

While !((cAliFisic)->(EOF()))
	
	aAreaQry	:= GetNextAlias()
	
	cCodZC4	:= (cAliFisic)->ZC4_CODTAB
	cTabBase	:= (cAliFisic)->ZC4_TABBAS
	cUFTab		:= (cAliFisic)->ZC4_EST
	nFrtZC4	:= (cAliFisic)->ZC4_PERFRT
	nDespZC4	:= (cAliFisic)->ZC4_DESP
	cConsumi	:= (cAliFisic)->ZC4_TCONSU
	cPessoa	:= (cAliFisic)->ZC4_PESSOA
	
	cQryA := "SELECT SB1.B1_COD,"+CRLF
	cQryA += "		SB1.B1_XDESC,"+CRLF
	cQryA += "		SB1.B1_POSIPI,"+CRLF
	cQryA += "		SB1.B1_GRTRIB,"+CRLF
	cQryA += "		SB1.B1_IPI,"+CRLF
	cQryA += "		SB1.B1_CONSUMI,"+CRLF
	cQryA += "		DA1.DA1_PRCVEN PRCPOR,"+CRLF
	cQryA += "		DA12.DA1_PRCVEN PRCDE,"+CRLF
	cQryA += "		ZC4.ZC4_PESSOA,"+CRLF
	cQryA += "		ZC4.ZC4_TCONSU"+CRLF
	cQryA += " FROM " +RetSqlName("SB1")+ " SB1"+CRLF
	cQryA += "		LEFT OUTER JOIN " +RetSqlName("ZC4")+ " ZC4"+CRLF
	cQryA += "			ON ZC4.D_E_L_E_T_ = ' '"+CRLF
	cQryA += "			AND ZC4.ZC4_FILIAL = '"+xFilial("ZC4")+"'"+CRLF
	cQryA += "	   		AND ZC4.ZC4_CODPRO = SB1.B1_COD"+CRLF
	cQryA += "			AND ZC4.ZC4_CODTAB = '"+ cCodZC4 +"'"+CRLF
	cQryA += "		LEFT OUTER JOIN " +RetSqlName("DA1")+ " DA1"+CRLF
	cQryA += "			ON DA1.D_E_L_E_T_ = ' '"+CRLF
	cQryA += "			AND DA1.DA1_FILIAL = '"+xFilial("DA1")+"'"+CRLF
	cQryA += "			AND DA1.DA1_CODPRO = SB1.B1_COD"+CRLF
	cQryA += "			AND DA1.DA1_CODTAB = '"+ cTabPor +"'"+CRLF
	cQryA += "		LEFT OUTER JOIN " +RetSqlName("DA1")+ " DA12"+CRLF
	cQryA += "			ON DA12.D_E_L_E_T_ = ' '"+CRLF
	cQryA += "			AND DA12.DA1_FILIAL = '"+xFilial("DA1")+"'"+CRLF
	cQryA += "			AND DA12.DA1_CODPRO = SB1.B1_COD"+CRLF
	cQryA += "			AND DA12.DA1_CODTAB = '"+ cTabDe +"'"+CRLF
	cQryA += " WHERE B1_COD IN (SELECT ZC3.ZC3_CODPRO FROM " +RetSqlName("ZC3")+ " ZC3"+CRLF
	cQryA += "					WHERE ZC3.ZC3_FILIAL = '"+xFilial("ZC3")+"'"+CRLF
	cQryA += "					AND ZC3.D_E_L_E_T_ = ' ')"+CRLF
	
	cQryA := ChangeQuery(cQryA)
	
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQryA),aAreaQry,.T.,.T.)
	
	ZC4->(dbSetOrder(2))
	
	While !((aAreaQry)->(EOF()))
		
		cItem := LastItem(cCodZC4)
		
		If ZC4->(DbSeek(cFilZC4+cCodZC4+(aAreaQry)->B1_COD))
			ZC4->(Reclock("ZC4",.F.))
			
			ZC4->ZC4_PRCBAS	:= (aAreaQry)->PRCPOR
			ZC4->ZC4_CIAOFE	:= (aAreaQry)->PRCDE
			ZC4->ZC4_PRCCIA	:= (aAreaQry)->PRCPOR
			
			ZC4->(MsUnLock())
		Else
			
			ZC4->(Reclock("ZC4",.T.))
			
			ZC4->ZC4_CODTAB	:= cCodZC4
			ZC4->ZC4_TABBAS	:= cTabBase
			ZC4->ZC4_EST		:= cUFTab
			ZC4->ZC4_ITEM		:= cItem
			ZC4->ZC4_CODPRO	:= (aAreaQry)->B1_COD
			ZC4->ZC4_DESCRI	:= (aAreaQry)->B1_XDESC
			ZC4->ZC4_PRCBAS	:= (aAreaQry)->PRCPOR
			ZC4->ZC4_CIAOFE	:= (aAreaQry)->PRCDE
			ZC4->ZC4_PERFRT	:= nFrtZC4
			ZC4->ZC4_DESP		:= nDespZC4
			ZC4->ZC4_PERIPI	:= (aAreaQry)->B1_IPI
			ZC4->ZC4_FLAG		:= "2"
			ZC4->ZC4_TCONSU	:= cConsumi
			ZC4->ZC4_PESSOA	:= cPessoa
			ZC4->ZC4_PRCCIA	:= (aAreaQry)->PRCPOR//P120CCalc()
			
			ZC4->(MsUnLock())
			
		EndIf
		(aAreaQry)->(DbSkip())
		
	EndDo
	
	(aAreaQry)->(DbCloseArea())
	
	(cAliFisic)->(DbSkip())
	
EndDo

(cAliFisic)->(DbCloseArea())

RestArea(aAreaZC4)
RestArea(aAreaATU)

Return

//------------------------------------------------------------------------------------------
/*/{Protheus.doc} LastItem
Função responsavel pelo ajuste e geração de númeração de item

@author    Lucas Felipe
@version   1.xx
@since     17/04/2016
/*/
//------------------------------------------------------------------------------------------

Static Function LastItem(cTabprc)

Local aAreaAtu 	:= GetArea()
Local aAreaSql	:= GetNextAlias()
Local cItem		:= Space(04)

BeginSql Alias aAreaSql
	
	SELECT MAX(ZC4_ITEM) ZC4_ITEM FROM %Table:ZC4% ZC4 WHERE ZC4_FILIAL = %xfilial:ZC4% AND ZC4_CODTAB = %Exp:cTabprc% AND ZC4.%notDel%
	
EndSql

If !Empty((aAreaSql)->ZC4_ITEM)
	cItem := Soma1((aAreaSql)->ZC4_ITEM,4)
Else
	cItem := Soma1(cItem,4)
EndIf

(aAreaSql)->(DbCloseArea())

RestArea(aAreaAtu)

Return cItem
