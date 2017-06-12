#INCLUDE "PROTHEUS.CH"
#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"

#Define Enter Chr(13)+Chr(10)

Static aDados:={}
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR702บAutor  ณMicrosiga           บ Data ณ  02/05/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function NCGPR702()
Private cCadastro := "WorkFlow Inadimplencia"
Private aRotina := MenuDef()

DbSelectArea("ZZ5")
mBrowse( 6,1,22,75,"ZZ5",,,,,,,,,,,,,,"ZZ5_FLAG='0'")
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR702บAutor  ณMicrosiga           บ Data ณ  02/05/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function R702Manut(cAlias,nReg,nOpc)
Local oDlg
Local lGravar	:=.F.
Local aArea		:= GetArea()
Local aSize   	:= MsAdvSize()
Local aObjects	:= {}
Local aCpoCab	:= {"ZZ5_WF","ZZ5_DESCWF","ZZ5_HTMARQ","ZZ5_HTMASS","ZZ5_REENVI","ZZ5_DIASRE","NOUSER"}
Local aInfo		:= {}
Local aPosObj	:= {}
Local aPosFld	:= {}
Local aObjFld	:= {}
Local bOk		:={|| Iif(Obrigatorio(aGets,aTela) .And. U_R702TOK(),(lGravar:=.T.,oDlg:End()),) }
Local bCancel	:={|| lGravar:=.F.,oDlg:End() }
Local aButtons	:={}
Local aFolders	:={OemToAnsi('Canal de Venda'),OemToAnsi('Cliente'),OemToAnsi('Exce็ใo Cliente')}

Local nOpcy		:=IIf( (nOpc==3 .Or. nOpc==4),GD_INSERT+GD_UPDATE+GD_DELETE,0   )

Local cSeekKey	:=xFilial("ZZ5")+ZZ5->ZZ5_WF
Local bSeekWhile := {|| ZZ5_FILIAL+ZZ5_WF+ZZ5_FLAG }
Local uSeekFor	:={}

Local oGetCanal
Local aHeadCanal:={}
Local aColsCanal:={}


Local aHeadCliente:={}
Local aColsCliente:={}


Local aHeadNoCliente:={}
Local aColsNoCliente:={}

Private oFolder
Private oGetCliente
Private oGetNoCliente


Private aTELA[0][0],aGETS[0]


RegToMemory("ZZ5",nOpc==3)
//FillGetDados ( < nOpc>, < cAlias>, [ nOrder], [ cSeekKey], [ bSeekWhile], [ uSeekFor], [ aNoFields], [ aYesFields], [ lOnlyYes], [ cQuery], [ bMontCols], [ lEmpty], [ aHeaderAux], [ aColsAux], [ bAfterCols], [ bBeforeCols], [ bAfterHeader], [ cAliasQry], [ bCriaVar], [ lUserFields], [ aYesUsado] ) --> lRet

//Canal Venda
ZZ5->(FillGetDados ( nOpc, "ZZ5",1, cSeekKey+"3", bSeekWhile,  /*uSeekFor*/, /*aNoFields*/, {"ZZ5_CANAL","ZZ5_DESCAN","ZZ5_DIAS","ZZ5_SITUAC"}, .T., /*[ cQuery]*/, /*[bMontCols]*/, nOpc==3, aHeadCanal, aColsCanal, /*[ bAfterCols]*/, /*[ bBeforeCols]*/, /*[ bAfterHeader]*/, /*[ cAliasQry]*/, /*[ bCriaVar]*/, .F., {"ZZ5_CANAL","ZZ5_DESCAN"} ))

//Cliente
ZZ5->(FillGetDados ( nOpc, "ZZ5",1, cSeekKey+"4", bSeekWhile,  /*uSeekFor*/, /*aNoFields*/, {"ZZ5_CLIENT","ZZ5_LOJA","ZZ5_NOMCLI","ZZ5_DIAS","ZZ5_SITUAC"}, .T., /*[ cQuery]*/, /*[bMontCols]*/, nOpc==3, aHeadCliente, aColsCliente, /*[ bAfterCols]*/, /*[ bBeforeCols]*/, /*[ bAfterHeader]*/, /*[ cAliasQry]*/, /*[ bCriaVar]*/, .F., {"ZZ5_CLIENT","ZZ5_LOJA","ZZ5_NOMCLI"} ))


// Exce็ใo Cliente
ZZ5->(FillGetDados ( nOpc, "ZZ5",1, cSeekKey+"5", bSeekWhile,  /*uSeekFor*/, /*aNoFields*/, {"ZZ5_CLIENT","ZZ5_LOJA","ZZ5_NOMCLI"}, .T., /*[ cQuery]*/, /*[bMontCols]*/, nOpc==3, aHeadNoCliente, aColsNoCliente, /*[ bAfterCols]*/, /*[ bBeforeCols]*/, /*[ bAfterHeader]*/, /*[ cAliasQry]*/, /*[ bCriaVar]*/, .F., {"ZZ5_CLIENT","ZZ5_LOJA","ZZ5_NOMCLI"} ))



aSizeAut	:= MsAdvSize(,.F.,400)
AAdd( aObjects, { 0,    70, .T., .F. } )
AAdd( aObjects, { 100, 100, .T., .T. } )

aInfo := { aSizeAut[ 1 ], aSizeAut[ 2 ], aSizeAut[ 3 ], aSizeAut[ 4 ], 3, 3 }
aPosObj := MsObjSize( aInfo, aObjects )

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณCalcula o Size para os Foldersณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Aadd( aObjFld, {   1  ,  1, .T., .T. } )
aInfoFld := {1,1,aPosObj[2,4] - aPosObj[2,2] ,aPosObj[2,3] - aPosObj[2,1],3,3}
aPosFld := MsObjSize( aInfoFld, aObjFld )

DEFINE MSDIALOG oDlg TITLE OemtoAnsi("Parametros WorkFlow Inadimplencia") From aSize[7],0 To aSize[6],aSize[5] of oMainWnd PIXEL
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณMonta a Enchoice superior com? os Dados da Cargaณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Enchoice( "ZZ5", nReg, nOpc, , , , aCpoCab, {aPosObj[1,1],aPosObj[1,2],aPosObj[1,3],aPosObj[1,4]},, 1, , ,"AllwaysTrue()", oDlg, .F.,  .T., .F., , .T., .F.)
oFolder := TFolder():New(aPosObj[2,1],aPosObj[2,2],aFolders,{'','',''},oDlg,,,,.T.,.F.,aPosObj[2,4]-aPosObj[2,2],aPosObj[2,3]-aPosObj[2,1])
nGd1 := 2
nGd2 := 2
nGd3 := aPosObj[2,3]-aPosObj[2,1]-15
nGd4 := aPosObj[2,4]-aPosObj[2,2]-4


//MsNewGetDados(): New ( [ nTop], [ nLeft], [ nBottom], [ nRight ], [ nStyle], [ cLinhaOk], [ cTudoOk], [ cIniCpos], [ aAlter], [ nFreeze], [ nMax], [ cFieldOk], [ cSuperDel], [ cDelOk], [ oWnd], [ aPartHeader], [ aParCols], [ uChange], [ cTela] ) --> Objeto


oGetCanal     := MsNewGetDados():New(nGd1,nGd2,nGd3,nGd4,nOpcy,"AllwaysTrue","AllwaysTrue",/*'+ITEM'*/,/*aCpoEnable*/,/*nFreeze*/,/*nMax*/,/*cFieldOk*/,/*cSuperDel*/,/*cDelOk*/ ,oFolder:aDialogs[1],aHeadCanal,aColsCanal)
oGetCliente	  := MsNewGetDados():New(nGd1,nGd2,nGd3,nGd4,nOpcy,"AllwaysTrue","AllwaysTrue",/*'+ITEM'*/,/*aCpoEnable*/,/*nFreeze*/,/*nMax*/,/*cFieldOk*/,/*cSuperDel*/,/*cDelOk*/ ,oFolder:aDialogs[2],aHeadCliente,aColsCliente)
oGetNoCliente := MsNewGetDados():New(nGd1,nGd2,nGd3,nGd4,nOpcy,"AllwaysTrue","AllwaysTrue",/*'+ITEM'*/,/*aCpoEnable*/,/*nFreeze*/,/*nMax*/,/*cFieldOk*/,/*cSuperDel*/,/*cDelOk*/ ,oFolder:aDialogs[3],aHeadNoCliente,aColsNoCliente)


ACTIVATE MSDIALOG oDlg ON INIT ( EnchoiceBar(oDlg,bOk,bCancel,,aButtons) )

If nOpc<>2 .And. lGravar
	Begin Transaction
	Processa( {|| R702Grv(nOpc,aCpoCab,aHeadCanal,oGetCanal:aCols,aHeadCliente,oGetCliente:aCols,aHeadNoCliente,oGetNoCliente:aCols) } )
	End Transaction
ElseIf __lSX8
	RollBackSX8()
EndIf


Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR702บAutor  ณMicrosiga           บ Data ณ  02/05/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function R702Grv(nOpc,aCpoCab,aHeadCanal,aColsCanal,aHeadCliente,aColsCliente,aHeadNoCliente,aColsNoCliente)
Local cFilZZ5	:=xFilial("ZZ5")
Local cChaveZZ5	:=cFilZZ5+M->ZZ5_WF
Local nInd


If nOpc==5 // Exclusao
	ZZ5->(DbSetOrder(1))//ZZ5_FILIAL+ZZ5_WF+ZZ5_FLAG
	ZZ5->(DbSeek(cChaveZZ5))
	ZZ5->( DbEval( {|| RecLock("ZZ5",.F.),DbDelete(),MsUnLock()  },{|| ZZ5_FILIAL+ZZ5_WF==cChaveZZ5  },{|| .T. }  )    )
Else
	If nOpc==4//Alterar
		ZZ5->(DbSetOrder(1))//ZZ5_FILIAL+ZZ5_WF+ZZ5_FLAG
		ZZ5->(DbSeek(cChaveZZ5+"0"))
	EndIf
	ZZ5->(RecLock("ZZ5",nOpc==3))
	For nInd:=1 To Len(aCpoCab)
		If (nPosCpo:=ZZ5->(FieldPos(aCpoCab[nInd]) ))>0
			ZZ5->( FieldPut(nPosCpo, M->&(aCpoCab[nInd]) ) )
		EndIf
	Next
	ZZ5->ZZ5_FILIAL:=cFilZZ5
	ZZ5->ZZ5_FLAG:="0"
	
	For nInd:=1 To Len(aColsCanal)
		If !Empty(GdFieldGet("ZZ5_CANAL",nInd,,aHeadCanal,aColsCanal))
			R702GrvItens(aHeadCanal,aColsCanal,nInd,"3",cFilZZ5)
		EndIf
	Next
	
	For nInd:=1 To Len(aColsCliente)
		If !Empty(GdFieldGet("ZZ5_CLIENT",nInd,,aHeadCliente,aColsCliente))
			R702GrvItens(aHeadCliente,aColsCliente,nInd,"4",cFilZZ5)
		EndIf
	Next
	
	For nInd:=1 To Len(aColsNoCliente)
		If !Empty(GdFieldGet("ZZ5_CLIENT",nInd,,aHeadNoCliente,aColsNoCliente))
			R702GrvItens(aHeadNoCliente,aColsNoCliente,nInd,"5",cFilZZ5)
		EndIf
	Next
	
	ConfirmSX8()
EndIf

Return .T.


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR702บAutor  ณMicrosiga           บ Data ณ  02/05/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function R702GrvItens(aHeader,aCols,nInd,cFlag,cFilZZ5)
Local nPosRec		:=GdFieldPos("ZZ5_REC_WT",aHeader)
Local nColuna
Local lTemRecno:=.F.
Local nYnd

If aCols[nInd,nPosRec]>0
	ZZ5->( DbGoTo( aCols[nInd,nPosRec] ) )
	lTemRecno:=.T.
EndIf

If GdDeleted( nInd , aHeader , aCols )
	If lTemRecno
		ZZ5->(RecLock("ZZ5",.F.))
		ZZ5->(dbDelete())
		ZZ5->(MsUnLock())
	EndIf
Else
	ZZ5->(RecLock("ZZ5",!lTemRecno))
	For nYnd:=1 To Len(aHeader)
		nColuna:=ZZ5->(FieldPos(aHeader[nYnd,2]))
		If nColuna>0
			ZZ5->(FieldPut(nColuna,GdFieldGet(aHeader[nYnd,2],nInd,,aHeader,aCols)))
		EndIf
	Next
	ZZ5->ZZ5_FILIAL	:=cFilZZ5
	ZZ5->ZZ5_WF	:=M->ZZ5_WF
	ZZ5->ZZ5_FLAG	:=cFlag
EndIf


Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR702บAutor  ณMicrosiga           บ Data ณ  02/05/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function MenuDef()
Local aRotina:={ ;
{"Pesquisar","AxPesqui"		,0,1} ,;
{"Visualizar","U_R702Manut",0,2} ,;
{"Incluir","U_R702Manut",0,3} ,;
{"Alterar","U_R702Manut",0,4} ,;
{"Excluir","U_R702Manut",0,5},;
{"Executar WF","U_PR702EXEC",0,5} }
              



Return aRotina

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR702บAutor  ณMicrosiga           บ Data ณ  02/05/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function R702VAL(cCampo)
Local lRetorno	:=.T.
Local cCodCli	:=M->ZZ5_CLIENT
Local cLoja		:=M->ZZ5_LOJA
Local oAux		:=oGetCliente

Default cCampo:=__ReadVar


If oFolder:nOption==3
	oAux:=oGetNoCliente
EndIf

If cCampo$"M->ZZ5_CLIENT*M->ZZ5_LOJA"
	
	SA1->(DbSetOrder(1))
	If cCampo=="M->ZZ5_CLIENT
		cLoja:=GdFieldGet("ZZ5_LOJA",oAux:nAt,, oAux:aHeader,oAux:aCols)
	Else
		cCodCli:=GdFieldGet("ZZ5_CLIENT",oAux:nAt, ,oAux:aHeader,oAux:aCols)
	EndIf
	
	cChaveSA1:=xFilial("SA1")+cCodCli+IIf(!Empty(cLoja),cLoja,"")
	If !SA1->(DbSeek(cChaveSA1))
		ExistCpo("SA1",cChaveSA1)
		lRetorno:=.F.
	Else
		GDFieldPut ( "ZZ5_NOMCLI", SA1->A1_NOME, oAux:nAt, oAux:aHeader, oAux:aCols)
	EndIf
	
ElseIf cCampo$"M->ZZ5_HTMARQ"
	
	If !File(M->ZZ5_HTMARQ)
		MsgStop("Arquivo "+AllTrim(M->ZZ5_HTMARQ)+" nao encontrado")
		lRetorno:=.F.
	Endif
	
	
	
	
EndIf

Return lRetorno


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR702บAutor  ณMicrosiga           บ Data ณ  02/19/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function R702TOK()
Local lRetorno:=.T.

If M->ZZ5_REENVI=="S" .And. M->ZZ5_DIASRE==0
	lRetorno:=.F.
	MsgInfo("Campo ["+AllTrim(AvSx3("ZZ5_DIASRE",5))+"] deve ser maior que 0  quando campo ["+AllTrim(AvSx3("ZZ5_REENVI",5))+"] igual a Sim." )
EndIf

Return lRetorno


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR702  บAutor  ณMicrosiga           บ Data ณ  06/15/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function PR702SXB()
Local cType	:= "Modelo Html|*.htm?"

M->ZZ5_HTMARQ	:= cGetFile(cType, "Selecione o Arquivo Arquivo Html "+M->ZZ5_DESCWF,0,"SERVIDOR\",.T.,GETF_NETWORKDRIVE )

Return( M->ZZ5_HTMARQ )

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR702  บAutor  ณMicrosiga           บ Data ณ  06/15/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function R702TITVAL(cCodWF,cCliente,cLoja,dVencimento,cPrefixo,cNum,cParcela)
Local aAreaAtu	:=GetArea()
Local aAreaZZ4	:=ZZ4->(GetArea() )
Local aAreaZZ5	:=ZZ5->(GetArea() )
Local aAreaSA1	:=SA1->(GetArea() )
Local cFilZZ5	:=xFilial("ZZ5")
Local cFilZZ4	:=xFilial("ZZ4")
Local bRestArea	:={|| RestArea(aAreaSA1),RestArea(aAreaZZ5),RestArea(aAreaZZ4), RestArea(aAreaAtu)}
Local lReeenviar
Local lJaEnviado
Local cArqQry:=GetNextAlias()
Local cQuery
Local dUltEnvio:=CTOD("")


ZZ5->(DbSetOrder(1))//ZZ5_FILIAL+ZZ5_WF+ZZ5_FLAG+ZZ5_CLIENT+ZZ5_LOJA
If !ZZ5->(DbSeek(cFilZZ5+cCodWF+"0"))
	Eval(bRestArea)
	Return .F.
EndIf
lReeenviar:=(ZZ5->ZZ5_REENVI=="S")
nDiasReenv:=ZZ5->ZZ5_DIASRE

ZZ4->(DbSetOrder(2))//ZZ4_FILIAL+ZZ4_TIPOWF+ZZ4_PREFIX+ZZ4_NUM+ZZ4_PARCEL+ZZ4_CLIENT+ZZ4_LOJA+ZZ4_DTENVI
lJaEnviado:=ZZ4->(DbSeek(cFilZZ4+cCodWF+cPrefixo+cNum+cParcela+cCliente+cLoja ))

If !lReeenviar .And. lJaEnviado
	Eval(bRestArea)
	Return .F.
EndIf

If lJaEnviado
	cQuery:=" Select Max(ZZ4_DTENVI) ZZ4_DTENVI From "+RetSqlName("ZZ4") +" ZZ4 "
	cQuery+=" Where ZZ4.ZZ4_FILIAL='"+cFilZZ4+"'"
	cQuery+=" And ZZ4.ZZ4_TIPOWF='"+cCodWF+"'"
	cQuery+=" And ZZ4.ZZ4_PREFIX='"+cPrefixo+"'"
	cQuery+=" And ZZ4.ZZ4_NUM='"+cNum+"'"
	cQuery+=" And ZZ4.ZZ4_PARCEL='"+cParcela+"'"
	cQuery+=" And ZZ4.ZZ4_CLIENT='"+cCliente+"'"
	cQuery+=" And ZZ4.ZZ4_LOJA='"+cLoja+"'"
	cQuery+=" And ZZ4.ZZ4_MENSAG='OK'"
	
	dbUseArea( .T., __cRdd, TcGenQry(,,cQuery), cArqQry, .F., .T. )
	TcSetField(cArqQry,"ZZ4_DTENVI","D")
	dUltEnvio:=(cArqQry)->ZZ4_DTENVI
	
	(cArqQry)->(DbCloseArea())
	
EndIf

If ZZ5->(DbSeek(cFilZZ5+cCodWF+"5"+cCliente))
	Do While ZZ5->(ZZ5_FILIAL+ZZ5_WF+ZZ5_FLAG+ZZ5_CLIENT)==cFilZZ5+cCodWF+"5"+cCliente
		If Empty(ZZ5->ZZ5_LOJA) .Or. ZZ5->ZZ5_LOJA==cLoja
			Eval(bRestArea)
			Return .F.
		EndIf
		ZZ5->(DbSkip())
	EndDo
EndIf


If ZZ5->(DbSeek(cFilZZ5+cCodWF+"4"))
	If Len(aDados)==0
		Do While ZZ5->(ZZ5_FILIAL+ZZ5_WF+ZZ5_FLAG)==cFilZZ5+cCodWF+"4"
			ZZ5->(AADD(aDados,{ZZ5_CLIENT, ZZ5_LOJA,ZZ5_DIAS,ZZ5_SITUAC}))
			ZZ5->(DbSkip())
		EndDo
	EndIf
	
	If (nAscan:=Ascan(aDados,{|a|a[1]==cCliente .And. a[2]==cLoja }))>0	 .Or. (nAscan:=Ascan(aDados,{|a|a[1]==cCliente .And. a[2]==Space(Len(cLoja)) }))>0
		Return PR702VDATA(dVencimento,aDados[nAscan,3],aDados[nAscan,4],lReeenviar,nDiasReenv,lJaEnviado,dUltEnvio)
	EndIf
EndIf

SA1->(DbSetOrder(1))
SA1->(DbSeek(xFilial("SA1")+cCliente+cLoja ))

ZZ5->(DbSetOrder(2))//ZZ5_FILIAL+ZZ5_WF+ZZ5_FLAG+ZZ5_CANAL
If !ZZ5->(DbSeek(cFilZZ5+cCodWF+"3"+SA1->A1_YCANAL))
	Eval(bRestArea)
	Return .F.
EndIf

lReturn:=PR702VDATA(dVencimento,ZZ5->ZZ5_DIAS,ZZ5->ZZ5_SITUAC,lReeenviar,nDiasReenv,lJaEnviado,dUltEnvio)

Eval(bRestArea)
Return lReturn
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR702  บAutor  ณMicrosiga           บ Data ณ  06/15/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PR702VDATA(dVencimento,nDias,cSituacao,lReeenviar,nDiasReenv,lJaEnviado,dUltEnvio)
Local lRetorno

If !lReeenviar .And. lJaEnviado
	Return .F.
EndIf

If lJaEnviado	
	If lReeenviar .And. (dDataBase-dUltEnvio)<nDiasReenv
		Return .F.
	EndIf
EndIf

If nDias==0
	Return .T.
EndIf

If cSituacao=="1"
	lRetorno:=(dVencimento-dDataBase )<=nDias
Else
	lRetorno:=(dVencimento-dDataBase )<=nDias*-1
EndIf

Return lRetorno
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR702  บAutor  ณMicrosiga           บ Data ณ  06/27/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PR702Init()

aDados:={}

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR702  บAutor  ณMicrosiga           บ Data ณ  07/16/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PR702EXEC()
U_PR703RUN( .F.,ZZ5->ZZ5_WF)
Return
