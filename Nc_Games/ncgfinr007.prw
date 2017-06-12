#INCLUDE "PROTHEUS.CH"
#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"

#Define Enter Chr(13)+Chr(10)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ?ÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGFINR007ºAutor  ³Microsiga           º Data ³  02/19/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function R007JOB(aDados)
Local cQuery
Local cAliasQry
Default aDados:={"01","03"}
RpcSetEnv(aDados[1],aDados[2])

cAliasQry:=GetNextAlias()
cQuery:="Select ZAL_CODIGO From "+RetSqlName("ZAL")+" Where ZAL_FILIAL='"+xFilial("ZAL")+"' And ZAL_FLAG='0' And ZAL_AGENDA='S' And D_E_L_E_T_=' '"
dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cAliasQry , .F., .T.)
Do While (cAliasQry)->(!Eof() )
	U_R007Print( .T.,(cAliasQry)->ZAL_CODIGO )
	 (cAliasQry)->(DbSkip())
EndDo
RpcClearEnv()
Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma   |NCGFINR007º Autor ³ Cleverson                 ºData³05.02.2013º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao  ³ Fluxo de Caixa Projetado									 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºProjeto/ID ³Fluxo de Caixa Projetado                                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros ³                                                              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±º Retorno   ³                                                              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºSolicitante³                                              ºData³          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍ¹±±
±±º               ALTERACOES EFETUADAS APOS CONSTRUCAO INICIAL               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºAnalista   ³   Cleverson                                  ºData³          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao  ³                                                              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºAutor      ³                                              ºData³          º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function NCGFINR007
Private cCadastro := "Fluxo Caixa Projetado"
Private aRotina := MenuDef()

DbSelectArea("ZAL")
mBrowse( 6,1,22,75,"ZAL",,,,,,,,,,,,,,"ZAL_FLAG='0'")
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGFINR007ºAutor  ³Microsiga           º Data ³  02/05/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function R007Manut(cAlias,nReg,nOpc)
Local oDlg
Local lGravar	:=.F.
Local aArea		:= GetArea()
Local aSize   	:= MsAdvSize()
Local aObjects	:= {}
Local aCpoCab	:= {"ZAL_CODIGO","ZAL_DTVENC","ZAL_TIPO","ZAL_EMAIL","ZAL_AGENDA","ZAL_RELATO","NOUSER"}
Local aInfo		:= {}
Local aPosObj	:= {}
Local aPosFld	:= {}
Local aObjFld	:= {}
Local bOk		:={|| Iif(Obrigatorio(aGets,aTela) .And. U_R007TOK(),(lGravar:=.T.,oDlg:End()),) }
Local bCancel	:={|| lGravar:=.F.,oDlg:End() }
Local aButtons	:={}
Local aFolders	:={OemToAnsi('Banco'),OemToAnsi('Carteira'),OemToAnsi('Canal de Venda'),OemToAnsi('Cliente')}
Local oFolder
Local nOpcy		:=IIf( (nOpc==3 .Or. nOpc==4),GD_INSERT+GD_UPDATE+GD_DELETE,0   )

Local cSeekKey	:=xFilial("ZAL")+ZAL->ZAL_CODIGO
Local bSeekWhile := {|| ZAL_FILIAL+ZAL_CODIGO+ZAL_FLAG }
Local uSeekFor	:={}

Local oGetBanco
Local aHeadBanco:={}
Local aColsBanco:={}

Local oGetCarteira
Local aHeadCarteira:={}
Local aColsCarteira:={}

Local oGetCanal
Local aHeadCanal:={}
Local aColsCanal:={}


Local aHeadCliente:={}
Local aColsCliente:={}

Private oGetCliente
Private aTELA[0][0],aGETS[0]




RegToMemory("ZAL",nOpc==3)
//FillGetDados ( < nOpc>, < cAlias>, [ nOrder], [ cSeekKey], [ bSeekWhile], [ uSeekFor], [ aNoFields], [ aYesFields], [ lOnlyYes], [ cQuery], [ bMontCols], [ lEmpty], [ aHeaderAux], [ aColsAux], [ bAfterCols], [ bBeforeCols], [ bAfterHeader], [ cAliasQry], [ bCriaVar], [ lUserFields], [ aYesUsado] ) --> lRet

//Banco
ZAL->(FillGetDados ( nOpc, "ZAL",1, cSeekKey+"1", bSeekWhile,  /*uSeekFor*/, /*aNoFields*/, {"ZAL_BANCO","ZAL_DESCB"}, .T., /*[ cQuery]*/, /*[bMontCols]*/, nOpc==3, aHeadBanco, aColsBanco, /*[ bAfterCols]*/, /*[ bBeforeCols]*/, /*[ bAfterHeader]*/, /*[ cAliasQry]*/, /*[ bCriaVar]*/, .F., {"ZAL_BANCO","ZAL_DESCB"} ))

//Carteira
ZAL->(FillGetDados ( nOpc, "ZAL",1, cSeekKey+"2", bSeekWhile,  /*uSeekFor*/, /*aNoFields*/, {"ZAL_CARTEI","ZAL_DESCAR"}, .T., /*[ cQuery]*/, /*[bMontCols]*/, nOpc==3, aHeadCarteira, aColsCarteira, /*[ bAfterCols]*/, /*[ bBeforeCols]*/, /*[ bAfterHeader]*/, /*[ cAliasQry]*/, /*[ bCriaVar]*/, .F., {"ZAL_CARTEI","ZAL_DESCAR"} ))

//Canal Venda
ZAL->(FillGetDados ( nOpc, "ZAL",1, cSeekKey+"3", bSeekWhile,  /*uSeekFor*/, /*aNoFields*/, {"ZAL_CANAL","ZAL_DESCAN"}, .T., /*[ cQuery]*/, /*[bMontCols]*/, nOpc==3, aHeadCanal, aColsCanal, /*[ bAfterCols]*/, /*[ bBeforeCols]*/, /*[ bAfterHeader]*/, /*[ cAliasQry]*/, /*[ bCriaVar]*/, .F., {"ZAL_CANAL","ZAL_DESCAN"} ))

//Cliente
ZAL->(FillGetDados ( nOpc, "ZAL",1, cSeekKey+"4", bSeekWhile,  /*uSeekFor*/, /*aNoFields*/, {"ZAL_CLIENT","ZAL_LOJA","ZAL_NOMCLI"}, .T., /*[ cQuery]*/, /*[bMontCols]*/, nOpc==3, aHeadCliente, aColsCliente, /*[ bAfterCols]*/, /*[ bBeforeCols]*/, /*[ bAfterHeader]*/, /*[ cAliasQry]*/, /*[ bCriaVar]*/, .F., {"ZAL_CLIENT","ZAL_LOJA","ZAL_NOMCLI"} ))



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

DEFINE MSDIALOG oDlg TITLE OemtoAnsi("Parametros Fluxo Caixa Projetado") From aSize[7],0 To aSize[6],aSize[5] of oMainWnd PIXEL
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Monta a Enchoice superior com? os Dados da Carga³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Enchoice( "ZAL", nReg, nOpc, , , , aCpoCab, {aPosObj[1,1],aPosObj[1,2],aPosObj[1,3],aPosObj[1,4]},, 1, , ,"AllwaysTrue()", oDlg, .F.,  .T., .F., , .T., .F.)
oFolder := TFolder():New(aPosObj[2,1],aPosObj[2,2],aFolders,{'','','','',''},oDlg,,,,.T.,.F.,aPosObj[2,4]-aPosObj[2,2],aPosObj[2,3]-aPosObj[2,1])
nGd1 := 2
nGd2 := 2
nGd3 := aPosObj[2,3]-aPosObj[2,1]-15
nGd4 := aPosObj[2,4]-aPosObj[2,2]-4


//MsNewGetDados(): New ( [ nTop], [ nLeft], [ nBottom], [ nRight ], [ nStyle], [ cLinhaOk], [ cTudoOk], [ cIniCpos], [ aAlter], [ nFreeze], [ nMax], [ cFieldOk], [ cSuperDel], [ cDelOk], [ oWnd], [ aPartHeader], [ aParCols], [ uChange], [ cTela] ) --> Objeto

oGetBanco	:= MsNewGetDados():New(nGd1,nGd2,nGd3,nGd4,nOpcy,"AllwaysTrue","AllwaysTrue",/*'+ITEM'*/,/*aCpoEnable*/,/*nFreeze*/,/*nMax*/,/*cFieldOk*/,/*cSuperDel*/,/*cDelOk*/ ,oFolder:aDialogs[1],aHeadBanco,aColsBanco)

oGetCarteira:= MsNewGetDados():New(nGd1,nGd2,nGd3,nGd4,nOpcy,"AllwaysTrue","AllwaysTrue",/*'+ITEM'*/,/*aCpoEnable*/,/*nFreeze*/,/*nMax*/,/*cFieldOk*/,/*cSuperDel*/,/*cDelOk*/ ,oFolder:aDialogs[2],aHeadCarteira,aColsCarteira)

oGetCanal	:= MsNewGetDados():New(nGd1,nGd2,nGd3,nGd4,nOpcy,"AllwaysTrue","AllwaysTrue",/*'+ITEM'*/,/*aCpoEnable*/,/*nFreeze*/,/*nMax*/,/*cFieldOk*/,/*cSuperDel*/,/*cDelOk*/ ,oFolder:aDialogs[3],aHeadCanal,aColsCanal)

oGetCliente	:= MsNewGetDados():New(nGd1,nGd2,nGd3,nGd4,nOpcy,"AllwaysTrue","AllwaysTrue",/*'+ITEM'*/,/*aCpoEnable*/,/*nFreeze*/,/*nMax*/,/*cFieldOk*/,/*cSuperDel*/,/*cDelOk*/ ,oFolder:aDialogs[4],aHeadCliente,aColsCliente)


ACTIVATE MSDIALOG oDlg ON INIT ( EnchoiceBar(oDlg,bOk,bCancel,,aButtons) )

If nOpc<>2 .And. lGravar
	Begin Transaction
	Processa( {|| FINR007Grv(nOpc,aCpoCab,aHeadBanco,oGetBanco:aCols,aHeadCarteira,oGetCarteira:aCols,aHeadCanal,oGetCanal:aCols,aHeadCliente,oGetCliente:aCols) } )
	End Transaction
ElseIf __lSX8
	RollBackSX8()
EndIf


Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGFINR007ºAutor  ³Microsiga           º Data ³  02/05/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FINR007Grv(nOpc,aCpoCab,aHeadBanco,aColsBanco,aHeadCarteira,aColsCarteira,aHeadCanal,aColsCanal,aHeadCliente,aColsCliente)
Local cFilZAL	:=xFilial("ZAL")
Local cChaveZAL	:=cFilZAL+M->ZAL_CODIGO
Local nInd


If nOpc==5 // Exclusao
	ZAL->(DbSetOrder(1))//ZAL_FILIAL+ZAL_CODIGO+ZAL_FLAG
	ZAL->(DbSeek(cChaveZAL))
	ZAL->( DbEval( {|| RecLock("ZAL",.F.),DbDelete(),MsUnLock()  },{|| ZAL_FILIAL+ZAL_CODIGO==cChaveZAL  },{|| .T. }  )    )
Else
	If nOpc==4//Alterar
		ZAL->(DbSetOrder(1))//ZAL_FILIAL+ZAL_CODIGO+ZAL_FLAG
		ZAL->(DbSeek(cChaveZAL+"0"))
	EndIf
	ZAL->(RecLock("ZAL",nOpc==3))
	For nInd:=1 To Len(aCpoCab)
		If (nPosCpo:=ZAL->(FieldPos(aCpoCab[nInd]) ))>0
			ZAL->( FieldPut(nPosCpo, M->&(aCpoCab[nInd]) ) )
		EndIf
	Next
	ZAL->ZAL_FILIAL:=cFilZAL
	ZAL->ZAL_FLAG:="0"
	
	For nInd:=1 To Len(aColsBanco)
		If !Empty(GdFieldGet("ZAL_BANCO",nInd,,aHeadBanco,aColsBanco))
			R007GrvItens(aHeadBanco,aColsBanco,nInd,"1",cFilZAL)
		EndIf
	Next
	
	For nInd:=1 To Len(aColsCarteira)
		If !Empty(GdFieldGet("ZAL_CARTEI",nInd,,aHeadCarteira,aColsCarteira))
			R007GrvItens(aHeadCarteira,aColsCarteira,nInd,"2",cFilZAL)
		EndIf
	Next
	
	For nInd:=1 To Len(aColsCanal)
		If !Empty(GdFieldGet("ZAL_CANAL",nInd,,aHeadCanal,aColsCanal))
			R007GrvItens(aHeadCanal,aColsCanal,nInd,"3",cFilZAL)
		EndIf
	Next
	
	For nInd:=1 To Len(aColsCliente)
		If !Empty(GdFieldGet("ZAL_CLIENT",nInd,,aHeadCliente,aColsCliente))
			R007GrvItens(aHeadCliente,aColsCliente,nInd,"4",cFilZAL)
		EndIf
	Next
	ConfirmSX8()
EndIf

Return .T.


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGFINR007ºAutor  ³Microsiga           º Data ³  02/05/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function R007GrvItens(aHeader,aCols,nInd,cFlag,cFilZAL)
Local nPosRec		:=GdFieldPos("ZAL_REC_WT",aHeader)
Local nColuna
Local lTemRecno:=.F.
Local nYnd

If aCols[nInd,nPosRec]>0
	ZAL->( DbGoTo( aCols[nInd,nPosRec] ) )
	lTemRecno:=.T.
EndIf

If GdDeleted( nInd , aHeader , aCols )
	If lTemRecno
		ZAL->(RecLock("ZAL",.F.))
		ZAL->(dbDelete())
		ZAL->(MsUnLock())
	EndIf
Else
	ZAL->(RecLock("ZAL",!lTemRecno))
	For nYnd:=1 To Len(aHeader)
		nColuna:=ZAL->(FieldPos(aHeader[nYnd,2]))
		If nColuna>0
			ZAL->(FieldPut(nColuna,GdFieldGet(aHeader[nYnd,2],nInd,,aHeader,aCols)))
		EndIf
	Next
	ZAL->ZAL_FILIAL	:=cFilZAL
	ZAL->ZAL_CODIGO	:=M->ZAL_CODIGO
	ZAL->ZAL_FLAG	:=cFlag
EndIf


Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGFINR007ºAutor  ³Microsiga           º Data ³  02/05/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function MenuDef()
Local aRotina:={ {"Pesquisar","AxPesqui",0,1} ,;
{"Visualizar","U_R007Manut",0,2} ,;
{"Incluir","U_R007Manut",0,3} ,;
{"Alterar","U_R007Manut",0,4} ,;
{"Excluir","U_R007Manut",0,5} ,;
{"Imprimir","U_R007Print(.F.,ZAL->ZAL_CODIGO)",0,2}}

Return aRotina


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGFINR007ºAutor  ³Microsiga           º Data ³  02/05/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function FINR007VAL(cCampo)
Local lRetorno	:=.T.
Local cCodCli	:=M->ZAL_CLIENT
Local cLoja		:=M->ZAL_LOJA

Default cCampo:=__ReadVar

If cCampo$"M->ZAL_CLIENT*M->ZAL_LOJA"
	SA1->(DbSetOrder(1))
	If cCampo=="M->ZAL_CLIENT
		cLoja:=GdFieldGet("ZAL_LOJA",oGetCliente:nAt,, oGetCliente:aHeader,oGetCliente:aCols)
	Else
		cCodCli:=GdFieldGet("ZAL_CLIENT",oGetCliente:nAt, ,oGetCliente:aHeader,oGetCliente:aCols)
	EndIf
	
	cChaveSA1:=xFilial("SA1")+cCodCli+IIf(!Empty(cLoja),cLoja,"")
	If !SA1->(DbSeek(cChaveSA1))
		ExistCpo("SA1",cChaveSA1)
		lRetorno:=.F.
	Else
		GDFieldPut ( "ZAL_NOMCLI", SA1->A1_NOME, oGetCliente:nAt, oGetCliente:aHeader, oGetCliente:aCols)
		
	EndIf
EndIf

Return lRetorno

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGFINR007ºAutor  ³Microsiga           º Data ³  02/05/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function R007Print(lJob,cCodRelat)
Local aSays:={}
Local aButtons:={}
Local lOk:=.F.
Local cCadastro:="Fluxo de Caixa Projetado"

Default lJob	:=.F.

Private nHdl
Private cPathExcel  	:= ""
Private cExtExcel   	:= ".xml"

If !lJob
	AADD( aSays, "Fluxo de Caixa Projetado para titulo com Data Vencimento Até "+Dtoc(ZAL->ZAL_DTVENC) )
	AADD( aButtons, { 01, .T., {|| lOk := .T.,(cPathExcel:=cGetFile( "Defina o diretório | ",OemToAnsi("Selecione Diretorio de Gravação da Planilha"), ,"" ,.f.,GETF_RETDIRECTORY + GETF_LOCALFLOPPY + GETF_LOCALHARD + GETF_NETWORKDRIVE) ) ,Iif( !Empty(cPathExcel), FechaBatch(), msgStop("Informe o diretorio de gravaçao da planilha") ) } } )
	AADD( aButtons, { 02, .T., {|| lOk := .F., FechaBatch() } } )
	;FormBatch( cCadastro, aSays, aButtons )
Else
	lOk := .T.
	cPathExcel:="."
EndIf

If lOk .And. !Empty(cPathExcel)
	Processa({ || R007Filter(lJob,cCodRelat)})
EndIf

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGFINR007ºAutor  ³Microsiga           º Data ³  02/05/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R007Filter(lJob,cCodRelat)
Local cAliasQry:=GetNextAlias()
Local cQuery
Local cLine:=""
Local nContTot:=0
Local cCpoQry
Local nInd
Local aLinha:={}
Local aDadosCli:={}

Private cNomArq:="Relatorio_CR"

Private cPathArq:=StrTran(GetSrvProfString( "StartPath", "" )+"\","\\","\")
Private cArqXls:=E_Create(,.F.)
Private aDtValidas	:={}
Private cZALBanco:=""
Private cZALCarteira:=""
Private cZALCanal:=""
Private cZALClient:=""
Private cEmailTo   :=""

ZAL->(DbSetOrder(1))//ZAL_FILIAL+ZAL_CODIGO+ZAL_FLAG
ZAL->(DbSeek(xFilial("ZAL")+cCodRelat+"0"))
If !Empty(ZAL->ZAL_RELATO)
	cNomArq:=AllTrim(ZAL->ZAL_RELATO)
EndIf

cEmailTo:=ZAL->ZAL_EMAIL

ProcRegua(2)
IncProc("Filtrando...")

nHdl := FCreate(cPathArq+cArqXls+cExtExcel)
cQuery:=R007Query(cCodRelat,"E1_VENCREA","Order By E1_VENCREA","",.T.)
dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cAliasQry , .F., .T.)

R007Cabec(cCodRelat,cAliasQry)
(cAliasQry)->(DbCloseArea())

cCpoQry:="E1_PORTADO,E1_SITUACA,E1_CLIENTE,E1_VENCREA,Sum(E1_SALDO) E1_SALDO"
cQuery:=R007Query(cCodRelat,cCpoQry," Order By E1_PORTADO,E1_SITUACA,E1_CLIENTE,E1_VENCREA","Group By E1_PORTADO,E1_SITUACA,E1_CLIENTE,E1_VENCREA",.F.)
dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cAliasQry , .F., .T.)


Do While (cAliasQry)->(!Eof() )
	cBanco		:=(cAliasQry)->E1_PORTADO
	cNomeBanco	:=Posicione("SA6",1,xFilial("SA6")+ cBanco,"A6_NOME")
	Do While (cAliasQry)->(!Eof()) .And. (cAliasQry)->E1_PORTADO==cBanco
		cCarteira:=(cAliasQry)->E1_SITUACA
		cNomeCart:=Posicione("SX5",1,xFilial("SX5")+ "07" + cCarteira,"X5DESCRI()")
		nContTot:=0
		Do While (cAliasQry)->(!Eof()) .And. (cAliasQry)->(E1_PORTADO+E1_SITUACA)==cBanco+cCarteira
			cLine:='<Row ss:AutoFitHeight="0">'+Enter
			cLine+='    <Cell ss:StyleID="s124"><Data ss:Type="String">'+cBanco+'</Data></Cell>'+Enter
			cLine+='    <Cell ss:StyleID="s124"><Data ss:Type="String">'+cNomeBanco+'</Data></Cell>'+Enter
			cLine+='    <Cell ss:StyleID="s124"><Data ss:Type="String">'+cCarteira+'</Data></Cell>'+Enter
			cLine+='    <Cell ss:StyleID="s124"><Data ss:Type="String">'+cNomeCart+'</Data></Cell>'+Enter
			cCliente	:=(cAliasQry)->E1_CLIENTE
			cNomeClie	:=Posicione("SA1",1,xFilial("SA1")+ cCliente,"A1_NOME")
			aAuxDt:=aClone(aDtValidas)
			
			cLine+='    <Cell ss:StyleID="s124"><Data ss:Type="String">'+cCliente+'</Data></Cell>'+Enter
			cLine+='    <Cell ss:StyleID="s124"><Data ss:Type="String">'+cNomeClie+'</Data></Cell>'+Enter
			nContTot++
			
			If (nAscan:=Ascan(aDadosCli,{|a| a[1]==cCliente}))==0
				AADD(aDadosCli,{cCliente,cNomeClie,aClone(aAuxDt)})
				nLinCli:=Len(aDadosCli)
			Else
				nLinCli:=nAscan
			EndIf
			aAuxCli:=aDadosCli[nLinCli,3]
			
			Do While (cAliasQry)->(!Eof()) .And. (cAliasQry)->(E1_PORTADO+E1_SITUACA+E1_CLIENTE)==cBanco+cCarteira+cCliente
				IncProc("Processamento....")
				If (nAscan:=Ascan(aAuxDt,{|a| a[1]==(cAliasQry)->E1_VENCREA}))>0
					aAuxDt[nAscan,2]	+=(cAliasQry)->E1_SALDO
					aAuxCli[nAscan,2]   +=(cAliasQry)->E1_SALDO
				EndIf
				(cAliasQry)->(DbSkip())
			EndDo
			
			nCont:=Len(aAuxDt)
			For nInd:=1 To nCont
				cLine+='    <Cell ss:StyleID="s126"><Data ss:Type="Number">'+R007Trans(aAuxDt[nInd,2])+'</Data></Cell>'+Enter
			Next
			cLine+='    <Cell ss:StyleID="s126" ss:Formula="=SUM(RC[-'+AllTrim(Str(nCont))+']:RC[-1])"><Data'+Enter
			cLine+='      ss:Type="Number">305520000</Data></Cell>'+Enter
			cLine+='   </Row>'+Enter
			R007Write(@cLine)
		EndDo
		R007Write(@cLine)
		cLine+="<Row>"+Enter
		cLine+='    <Cell ss:StyleID="s121"><Data ss:Type="String">'+cBanco+'</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s121"><Data ss:Type="String">'+cNomeBanco+'</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s121"><Data ss:Type="String">'+AllTrim(cCarteira)+'</Data></Cell>'+Enter
		cLine+='    <Cell ss:StyleID="s121"><Data ss:Type="String">'+cNomeCart+'</Data></Cell>'+Enter
		cLine+='    <Cell ss:MergeAcross="1" ss:StyleID="m223706008"><Data ss:Type="String">TOTAL</Data></Cell>'+Enter
		
		nCont:=Len(aDtValidas)
		For nInd:=1 To nCont+1
			cLine+='    <Cell ss:StyleID="s128" ss:Formula="=SUM(R[-'+AllTrim(Str(nContTot))+']C:R[-1]C)"><Data ss:Type="Number">1018400</Data></Cell>'+Enter
		Next
		cLine+='   </Row>'+Enter
		R007Write(@cLine)
	EndDo
	//Total Banco
EndDo
cLine+='   <Row ss:AutoFitHeight="0">'+Enter
cLine+='    <Cell ss:StyleID="Default"></Cell>'+Enter
cLine+='   </Row>'+Enter
R007Write(@cLine)
//Total Por Cliente
nCont:=Len(aDtValidas)
nContar:=Len(aDadosCli)
For nInd:=1 To nContar
	//cLine+='   <Row '+IIf(nInd==1,'ss:Index="8"','')+' ss:AutoFitHeight="0">'+Enter
	cLine+='   <Row  ss:AutoFitHeight="0">'+Enter
	cLine+='   <Cell><Data ss:Type="String"></Data></Cell>'+Enter
	cLine+='   <Cell><Data ss:Type="String"></Data></Cell>'+Enter
	cLine+='   <Cell><Data ss:Type="String"></Data></Cell>'+Enter
	cLine+='   <Cell><Data ss:Type="String"></Data></Cell>'+Enter
	cLine+='    <Cell ss:Index="5" ss:StyleID="s124"><Data ss:Type="String">'+aDadosCli[nInd,1]+'</Data></Cell>'+Enter
	cLine+='    <Cell ss:StyleID="s124"><Data ss:Type="String">'+aDadosCli[nInd,2]+'</Data></Cell>'+Enter
	aAuxDt:=aDadosCli[nInd,3]
	nCont:=Len(aAuxDt)
	For nYnd:=1 To nCont
		cLine+='    <Cell ss:StyleID="s126"><Data ss:Type="Number">'+R007Trans(aAuxDt[nYnd,2])+'</Data></Cell>'+Enter
	Next
	cLine+='    <Cell ss:StyleID="s126" ss:Formula="=SUM(RC[-'+AllTrim(Str(nCont))+']:RC[-1])"><Data'+Enter
	cLine+='      ss:Type="Number">305520000</Data></Cell>'+Enter
	cLine+='   </Row>'+Enter
	R007Write(@cLine)
Next

//Total Geral
cLine+='   <Row>'+Enter
cLine+='    <Cell ss:Index="5" ss:MergeAcross="1" ss:StyleID="m223706028"><Data'+Enter
cLine+='      ss:Type="String">TOTAL</Data></Cell>'+Enter
For nInd:=1 To nCont+1
	cLine+='    <Cell ss:StyleID="s128" ss:Formula="=SUM(R[-'+AllTrim(Str(nContar))+']C:R[-1]C)"><Data ss:Type="Number">509200</Data></Cell>'+Enter
Next

cLine+='   </Row>'+Enter
cLine+='  </Table>'+Enter
R007Write(@cLine)

R007RodaPe()
FClose(nHdl)

cNomArq:=cNomArq+"_"+dTos(MsDate()) + StrTran(Time(),":","")

If lJob
	fRename( cPathArq+cArqXls+cExtExcel,cPathArq+cNomArq+cExtExcel )
	MySndMail("Fluxo de Caixa Projetado", "Em anexo Fluxo de Caixa gerado em "+DTOC(MsDate()), {cPathArq+cNomArq+cExtExcel}, cEmailTo)
Else
	IncProc("Copiando planilha "+cNomArq+" para "+cPathExcel)
	
	If __CopyFile(cPathArq+cArqXls+cExtExcel, cPathExcel+cArqXls+cExtExcel)
		fRename( cPathExcel+cArqXls+cExtExcel,cPathExcel+cNomArq+cExtExcel )
		If !lJob
			If !ApOleCliente( "MsExcel" )
				MsgStop( "Microsoft Excel não Instalado... Contate o Administrador do Sistema!" )
			Else
				If MsgYesNo("Abrir o Microsoft Excel?")
					oExcelApp:=MsExcel():New()
					oExcelApp:WorkBooks:Open( cPathExcel+cNomArq+cExtExcel )
					oExcelApp:SetVisible( .T. )
					oExcelApp:Destroy()
				EndIf
			EndIf
		EndIf
	ElseIf !lJob
		MsgStop("Erro ao copiar planilha")
	EndIf
EndIf


Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGR007  ºAutor  ³Microsiga           º Data ³  12/04/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R007Trans(xDados)
Local xRetorno

If ValType(xDados)=="N"
	xRetorno:=AllTrim(Str(xDados))
ElseIf ValType(xDados)=="D"
	xRetorno:=StrZero(Year(xDados),4)+"-"+StrZero(Month(xDados),2)+"-"+StrZero(Day(xDados),2)+'T00:00:00.000'
EndIf


Return xRetorno
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGR007  ºAutor  ³Microsiga           º Data ³  12/04/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R007Query(cCodRelat,cCpoQry,cOrdenar,cGroupBy,lDistinct)
Local cQuery	:=""
Local cFilZAL	:=xFilial("ZAL")
Local nInd
Local cQryClient:=""
Default cCpoQry	:="*"
Default cOrdenar:=""
Default cGroupBy:=""


ZAL->(DbSetOrder(1))//ZAL_FILIAL+ZAL_CODIGO+ZAL_FLAG

If Empty(cZALBanco)
	ZAL->(DbSeek(cFilZAL+cCodRelat+"1"))
	ZAL->( DbEval( {|| cZALBanco+=ZAL_BANCO+";" },{|| ZAL_FILIAL+ZAL_CODIGO+ZAL_FLAG==cFilZAL+cCodRelat+"1" },{||.T.} ) )
	cZALBanco:=Left(cZALBanco,Len(cZALBanco)-1)
EndIf

If Empty(cZALCarteira)
	ZAL->(DbSeek(cFilZAL+cCodRelat+"2"))
	ZAL->( DbEval( {|| cZALCarteira+=AllTrim(ZAL_CARTEI)+";" },{|| ZAL_FILIAL+ZAL_CODIGO+ZAL_FLAG==cFilZAL+cCodRelat+"2" },{||.T.} ) )
	cZALCarteira:=Left(cZALCarteira,Len(cZALCarteira)-1)
EndIf


If Empty(cZALCanal)
	ZAL->(DbSeek(cFilZAL+cCodRelat+"3"))
	ZAL->( DbEval( {|| cZALCanal+=ZAL_CANAL+";" },{|| ZAL_FILIAL+ZAL_CODIGO+ZAL_FLAG==cFilZAL+cCodRelat+"3" },{||.T.} ) )
	cZALCanal:=Left(cZALCanal,Len(cZALCanal)-1)
EndIf


If Empty(cZALClient)
	ZAL->(DbSeek(cFilZAL+cCodRelat+"4"))
	ZAL->( DbEval( {|| cZALClient+=ZAL_CLIENT+";" },{|| ZAL_FILIAL+ZAL_CODIGO+ZAL_FLAG==cFilZAL+cCodRelat+"4" },{||.T.} ) )
	cZALClient:=Left(cZALClient,Len(cZALClient)-1)
EndIf


ZAL->(DbSeek(cFilZAL+cCodRelat+"0"))

If !Empty(cZALCanal)
	cQryClient+="Select A1_COD,A1_LOJA From "+Enter
	cQryClient+=RetSqlName("ZAL")+" ZAL,"+RetSqlName("SA3")+" SA3,"+RetSqlName("SA1")+" SA1 "+Enter
	cQryClient+=" Where ZAL.ZAL_FILIAL='"+cFilZAL+"'"+Enter
	cQryClient+=" And ZAL.ZAL_CODIGO='"+cCodRelat+"'"+Enter
	cQryClient+=" And ZAL.ZAL_FLAG='3'"+Enter
	cQryClient+=" And ZAL.ZAL_CANAL=SA3.A3_GRPREP"+Enter
	cQryClient+=" And ZAL.D_E_L_E_T_=' '"+Enter
	cQryClient+=" And SA3.A3_FILIAL='"+xFilial("SA3")+"'"+Enter
	cQryClient+=" And SA3.D_E_L_E_T_=' '"+Enter
	cQryClient+=" And SA3.A3_COD=SA1.A1_VEND"+Enter
	cQryClient+=" And SA1.A1_FILIAL='"+xFilial("SA1")+"'"+Enter
	cQryClient+=" And SA1.D_E_L_E_T_=' '"+Enter
EndIf

If !Empty(cZALClient)
	
	If !Empty(cZALCanal)
		cQryClient+=" Union "+Enter
	EndIf
	
	cQryClient+="Select A1_COD,A1_LOJA From "+Enter
	cQryClient+=RetSqlName("ZAL")+" ZAL,"+RetSqlName("SA1")+" SA1 "+Enter
	cQryClient+=" Where ZAL.ZAL_FILIAL='"+cFilZAL+"'"+Enter
	cQryClient+=" And ZAL.ZAL_CODIGO='"+cCodRelat+"'"+Enter
	cQryClient+=" And ZAL.ZAL_FLAG='4'"+Enter
	cQryClient+=" And ZAL.D_E_L_E_T_=' '"+Enter
	cQryClient+=" And ZAL.ZAL_CLIENT=SA1.A1_COD"+Enter
	cQryClient+=" And ZAL.ZAL_LOJA=(CASE WHEN ZAL.ZAL_LOJA = '  ' THEN  '  '  ELSE SA1.A1_LOJA END )
	cQryClient+=" And SA1.A1_FILIAL='"+xFilial("SA1")+"'"+Enter
	cQryClient+=" And SA1.D_E_L_E_T_=' '"+Enter
EndIf

If Empty(cQryClient)
	cQryClient:=RetSqlName("SA1")
EndIf



If lDistinct
	cQuery+="Select Distinct "+cCpoQry+" From ("
EndIf

cQuery+=" SELECT "+cCpoQry+Enter
cQuery+=" From "+RetSqlName("SE1")+" SE1,("+cQryClient+") SA1 "+Enter
cQuery+=" Where SE1.E1_FILIAL between '  ' And 'ZZ'"+Enter
cQuery+=" AND SE1.E1_VENCREA <='"+Dtos(ZAL->ZAL_DTVENC)+"'"+Enter

If !Empty(ZAL->ZAL_TIPO)
	cQuery+=" AND SE1.E1_TIPO IN "+FormatIn(ZAL->ZAL_TIPO,";") +Enter
EndIf

If !Empty(cZALCarteira)
	cQuery+=" AND SE1.E1_SITUACA IN "+FormatIn(cZALCarteira,";") +Enter
EndIf

If !Empty(cZALBanco)
	cQuery+=" AND SE1.E1_PORTADO IN "+FormatIn(cZALBanco,";") +Enter
EndIf
cQuery+=" AND SE1.E1_CLIENTE=SA1.A1_COD"+Enter
cQuery+=" AND SE1.E1_LOJA=SA1.A1_LOJA"+Enter
cQuery+=" AND SE1.E1_PREFIXO between '   ' AND 'ZZZ' "+Enter
cQuery+=" AND SE1.E1_NUM     between '         ' AND 'ZZZZZZZZZ' "+Enter
cQuery+=" AND SE1.D_E_L_E_T_ = ' '  "+Enter
cQuery+=" AND SE1.E1_SALDO>0"+Enter

If !Empty(cGroupBy)
	cQuery+=cGroupBy
EndIf

If lDistinct
	cQuery+=")"
EndIf

If !Empty(cOrdenar)
	cQuery+=cOrdenar
EndIf




Return cQuery
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGR007  ºAutor  ³Microsiga           º Data ³  12/04/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function R007Write(cLine)
FWrite(nHdl,cLine,Len(cLine))
cLine:=""
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGR007  ºAutor  ³Microsiga           º Data ³  12/04/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R007Cabec(cCodRelat,cAliasQry)
Local cCabec:=""
Local aLinhas:={ {"Todos","Todos","Todos","Todos","Todos"}}
Local nInd
Local nYnd
ZAL->(DbSetOrder(1))//ZAL_FILIAL+ZAL_CODIGO+ZAL_FLAG
ZAL->(DbSeek(xFilial("ZAL")+cCodRelat+"0"))



cCabec+='<?xml version="1.0"?>'+Enter
cCabec+='<?mso-application progid="Excel.Sheet"?>'+Enter
cCabec+='<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet"'+Enter
cCabec+=' xmlns:o="urn:schemas-microsoft-com:office:office"'+Enter
cCabec+=' xmlns:x="urn:schemas-microsoft-com:office:excel"'+Enter
cCabec+=' xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"'+Enter
cCabec+=' xmlns:html="http://www.w3.org/TR/REC-html40">'+Enter
cCabec+=' <DocumentProperties xmlns="urn:schemas-microsoft-com:office:office">'+Enter
cCabec+='  <Author>NCGames</Author>'+Enter
cCabec+='  <LastAuthor>NCGames</LastAuthor>'+Enter
cCabec+='  <Created>2013-02-05T20:24:45Z</Created>'+Enter
cCabec+='  <Version>15.00</Version>'+Enter
cCabec+=' </DocumentProperties>'+Enter
cCabec+=' <OfficeDocumentSettings xmlns="urn:schemas-microsoft-com:office:office">'+Enter
cCabec+='  <AllowPNG/>'+Enter
cCabec+=' </OfficeDocumentSettings>'+Enter
cCabec+=' <ExcelWorkbook xmlns="urn:schemas-microsoft-com:office:excel">'+Enter
cCabec+='  <WindowHeight>11985</WindowHeight>'+Enter
cCabec+='  <WindowWidth>25200</WindowWidth>'+Enter
cCabec+='  <WindowTopX>0</WindowTopX>'+Enter
cCabec+='  <WindowTopY>0</WindowTopY>'+Enter
cCabec+='  <ActiveSheet>1</ActiveSheet>'+Enter
cCabec+='  <ProtectStructure>False</ProtectStructure>'+Enter
cCabec+='  <ProtectWindows>False</ProtectWindows>'+Enter
cCabec+=' </ExcelWorkbook>'+Enter
cCabec+=' <Styles>'+Enter
cCabec+='  <Style ss:ID="Default" ss:Name="Normal">'+Enter
cCabec+='   <Alignment ss:Vertical="Bottom"/>'+Enter
cCabec+='   <Borders/>'+Enter
cCabec+='   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#000000"/>'+Enter
cCabec+='   <Interior/>'+Enter
cCabec+='   <NumberFormat/>'+Enter
cCabec+='   <Protection/>'+Enter
cCabec+='  </Style>'+Enter

cCabec+='  <Style ss:ID="s80">'+Enter
cCabec+='   <Alignment ss:Vertical="Center"/>'+Enter
cCabec+='   <Borders>'+Enter
cCabec+='    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cCabec+='    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cCabec+='    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cCabec+='    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cCabec+='   </Borders>'+Enter
cCabec+='   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#FFFFFF"'+Enter
cCabec+='    ss:Bold="1"/>'+Enter
cCabec+='   <Interior ss:Color="#2F75B5" ss:Pattern="Solid"/>'+Enter
cCabec+='   <NumberFormat ss:Format="Short Date"/>'+Enter
cCabec+='  </Style>'+Enter


cCabec+='  <Style ss:ID="s18" ss:Name="Moeda">'+Enter
cCabec+='   <NumberFormat'+Enter
cCabec+='    ss:Format="_-&quot;R$&quot;\ * #,##0.00_-;\-&quot;R$&quot;\ * #,##0.00_-;_-&quot;R$&quot;\ * &quot;-&quot;??_-;_-@_-"/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="m223706008">'+Enter
cCabec+='   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>'+Enter
cCabec+='   <Borders>'+Enter
cCabec+='    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cCabec+='    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cCabec+='    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cCabec+='    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cCabec+='   </Borders>'+Enter
cCabec+='   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#FFFFFF"'+Enter
cCabec+='    ss:Bold="1"/>'+Enter
cCabec+='   <Interior ss:Color="#2F75B5" ss:Pattern="Solid"/>'+Enter
cCabec+='   <NumberFormat ss:Format="@"/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="m223706028">'+Enter
cCabec+='   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>'+Enter
cCabec+='   <Borders>'+Enter
cCabec+='    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cCabec+='    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cCabec+='    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cCabec+='    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cCabec+='   </Borders>'+Enter
cCabec+='   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#FFFFFF"'+Enter
cCabec+='    ss:Bold="1"/>'+Enter
cCabec+='   <Interior ss:Color="#2F75B5" ss:Pattern="Solid"/>'+Enter
cCabec+='   <NumberFormat ss:Format="@"/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="s63">'+Enter
cCabec+='   <Borders>'+Enter
cCabec+='    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cCabec+='    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cCabec+='    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cCabec+='    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cCabec+='   </Borders>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="s69">'+Enter
cCabec+='   <Borders>'+Enter
cCabec+='    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cCabec+='    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cCabec+='    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cCabec+='    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cCabec+='   </Borders>'+Enter
cCabec+='   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="12" ss:Color="#000000"'+Enter
cCabec+='    ss:Bold="1"/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="s70">'+Enter
cCabec+='   <Borders>'+Enter
cCabec+='    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cCabec+='    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cCabec+='    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cCabec+='    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cCabec+='   </Borders>'+Enter
cCabec+='   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="12" ss:Color="#000000"'+Enter
cCabec+='    ss:Bold="1"/>'+Enter
cCabec+='   <NumberFormat ss:Format="Short Date"/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="s71">'+Enter
cCabec+='   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="12" ss:Color="#000000"/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="s73">'+Enter
cCabec+='   <NumberFormat ss:Format="@"/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="s121">'+Enter
cCabec+='   <Alignment ss:Vertical="Bottom"/>'+Enter
cCabec+='   <Borders>'+Enter
cCabec+='    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cCabec+='    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cCabec+='    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cCabec+='    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cCabec+='   </Borders>'+Enter
cCabec+='   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#FFFFFF"'+Enter
cCabec+='    ss:Bold="1"/>'+Enter
cCabec+='   <Interior ss:Color="#2F75B5" ss:Pattern="Solid"/>'+Enter
cCabec+='   <NumberFormat ss:Format="@"/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="s122">'+Enter
cCabec+='   <Alignment ss:Vertical="Center"/>'+Enter
cCabec+='   <Borders>'+Enter
cCabec+='    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cCabec+='    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cCabec+='    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cCabec+='    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cCabec+='   </Borders>'+Enter
cCabec+='   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#FFFFFF"'+Enter
cCabec+='    ss:Bold="1"/>'+Enter
cCabec+='   <Interior ss:Color="#2F75B5" ss:Pattern="Solid"/>'+Enter
cCabec+='   <NumberFormat ss:Format="@"/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="s123">'+Enter
cCabec+='   <Alignment ss:Vertical="Bottom"/>'+Enter
cCabec+='   <Borders>'+Enter
cCabec+='    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cCabec+='    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cCabec+='    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cCabec+='    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cCabec+='   </Borders>'+Enter
cCabec+='   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#FFFFFF"'+Enter
cCabec+='    ss:Bold="1"/>'+Enter
cCabec+='   <Interior ss:Color="#2F75B5" ss:Pattern="Solid"/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="s124">'+Enter
cCabec+='   <Alignment ss:Vertical="Bottom"/>'+Enter
cCabec+='   <Borders>'+Enter
cCabec+='    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cCabec+='    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cCabec+='    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cCabec+='    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cCabec+='   </Borders>'+Enter
cCabec+='   <NumberFormat ss:Format="@"/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="s126" ss:Parent="s18">'+Enter
cCabec+='   <Alignment ss:Vertical="Bottom"/>'+Enter
cCabec+='   <Borders>'+Enter
cCabec+='    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cCabec+='    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cCabec+='    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cCabec+='    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cCabec+='   </Borders>'+Enter
cCabec+='   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#000000"/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+='  <Style ss:ID="s128">'+Enter
cCabec+='   <Alignment ss:Vertical="Bottom"/>'+Enter
cCabec+='   <Borders>'+Enter
cCabec+='    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cCabec+='    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cCabec+='    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cCabec+='    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>'+Enter
cCabec+='   </Borders>'+Enter
cCabec+='   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#FFFFFF"'+Enter
cCabec+='    ss:Bold="1"/>'+Enter
cCabec+='   <Interior ss:Color="#2F75B5" ss:Pattern="Solid"/>'+Enter
cCabec+='   <NumberFormat'+Enter
cCabec+='    ss:Format="_-&quot;R$&quot;\ * #,##0.00_-;\-&quot;R$&quot;\ * #,##0.00_-;_-&quot;R$&quot;\ * &quot;-&quot;??_-;_-@_-"/>'+Enter
cCabec+='  </Style>'+Enter
cCabec+=' </Styles>'+Enter
cCabec+=' <Worksheet ss:Name="Parametros">'+Enter
cCabec+='  <Table ss:ExpandedColumnCount="99999" ss:ExpandedRowCount="9999999" x:FullColumns="1"'+Enter
cCabec+='   x:FullRows="1" ss:DefaultRowHeight="15">'+Enter
cCabec+='   <Column ss:Width="118.5"/>'+Enter
cCabec+='   <Column ss:AutoFitWidth="0" ss:Width="81"/>'+Enter
cCabec+='   <Column ss:Width="57"/>'+Enter
cCabec+='   <Column ss:Width="87"/>'+Enter
cCabec+='   <Column ss:Width="51"/>'+Enter
cCabec+='   <Row ss:Height="15.75">'+Enter
cCabec+='    <Cell ss:StyleID="s69"><Data ss:Type="String">Data Vencimento</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s70"><Data ss:Type="DateTime">'+R007Trans(  ZAL->ZAL_DTVENC  )+'</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s71"/>'+Enter
cCabec+='    <Cell ss:StyleID="s71"/>'+Enter
cCabec+='    <Cell ss:StyleID="s71"/>'+Enter
cCabec+='   </Row>'+Enter
cCabec+='   <Row ss:Height="15.75">'+Enter
cCabec+='    <Cell ss:StyleID="s71"/>'+Enter
cCabec+='    <Cell ss:StyleID="s71"/>'+Enter
cCabec+='    <Cell ss:StyleID="s71"/>'+Enter
cCabec+='    <Cell ss:StyleID="s71"/>'+Enter
cCabec+='    <Cell ss:StyleID="s71"/>'+Enter
cCabec+='   </Row>'+Enter
cCabec+='   <Row ss:Height="15.75">'+Enter
cCabec+='    <Cell ss:StyleID="s69"><Data ss:Type="String">Tipos Titulos</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s69"><Data ss:Type="String">Banco</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s69"><Data ss:Type="String">Carteira</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s69"><Data ss:Type="String">Canal Venda</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s69"><Data ss:Type="String">Cliente</Data></Cell>'+Enter
cCabec+='   </Row>'+Enter
R007Write(@cCabec)

If !Empty(ZAL->ZAL_TIPO)
	aAux:=StrTokArr(ZAL->ZAL_TIPO,";")
	R007AdLinha(aAux,aLinhas,1)
EndIf

If !Empty(cZALBanco)
	aAux:=StrTokArr(cZALBanco,";")
	R007AdLinha(aAux,aLinhas,2)
EndIf

If !Empty(cZALCarteira)
	aAux:=StrTokArr(cZALCarteira,";")
	R007AdLinha(aAux,aLinhas,3)
EndIf

If !Empty(cZALCanal)
	aAux:=StrTokArr(cZALCanal,";")
	R007AdLinha(aAux,aLinhas,4)
EndIf

If !Empty(cZALClient)
	aAux:=StrTokArr(cZALClient,";")
	R007AdLinha(aAux,aLinhas,5)
EndIf

For nInd:=1 To Len(aLinhas)
	aAux:=aLinhas[nInd]
	cCabec+='   <Row>'+Enter
	For nYnd:=1 To Len(aAux)
		cCabec+='    <Cell ss:StyleID="s63"><Data ss:Type="String">'+aAux[nYnd]+'</Data></Cell>'+Enter
	Next
	cCabec+='   </Row>'+Enter
Next
R007Write(@cCabec)

cCabec+='  </Table>'+Enter

cCabec+='  <WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">'+Enter
cCabec+='   <PageSetup>'+Enter
cCabec+='    <Header x:Margin="0.31496062000000002"/>'+Enter
cCabec+='    <Footer x:Margin="0.31496062000000002"/>'+Enter
cCabec+='    <PageMargins x:Bottom="0.78740157499999996" x:Left="0.511811024"'+Enter
cCabec+='     x:Right="0.511811024" x:Top="0.78740157499999996"/>'+Enter
cCabec+='   </PageSetup>'+Enter
cCabec+='   <Print>'+Enter
cCabec+='    <ValidPrinterInfo/>'+Enter
cCabec+='    <HorizontalResolution>600</HorizontalResolution>'+Enter
cCabec+='    <VerticalResolution>600</VerticalResolution>'+Enter
cCabec+='   </Print>'+Enter
cCabec+='   <Panes>'+Enter
cCabec+='    <Pane>'+Enter
cCabec+='     <Number>3</Number>'+Enter
cCabec+='     <ActiveRow>2</ActiveRow>'+Enter
cCabec+='     <ActiveCol>4</ActiveCol>'+Enter
cCabec+='    </Pane>'+Enter
cCabec+='   </Panes>'+Enter
cCabec+='   <ProtectObjects>False</ProtectObjects>'+Enter
cCabec+='   <ProtectScenarios>False</ProtectScenarios>'+Enter
cCabec+='  </WorksheetOptions>'+Enter
cCabec+=' </Worksheet>'+Enter
R007Write(@cCabec)

cCabec+='<Worksheet ss:Name="'+cNomArq+'">'+Enter
cCabec+='  <Table ss:ExpandedColumnCount="9999" ss:ExpandedRowCount="9999999" x:FullColumns="1"'+Enter
cCabec+='   x:FullRows="1" ss:DefaultRowHeight="15">'+Enter
cCabec+='   <Column ss:StyleID="s73" ss:Width="33"/>'+Enter
cCabec+='   <Column ss:StyleID="s73" ss:Width="99.75"/>'+Enter
cCabec+='   <Column ss:StyleID="s73" ss:Width="42"/>'+Enter
cCabec+='   <Column ss:StyleID="s73" ss:Width="110.0"/>'+Enter
cCabec+='   <Column ss:StyleID="s73" ss:Width="39"/>'+Enter
cCabec+='   <Column ss:StyleID="s73" ss:Width="195"/>'+Enter
cCabec+='   <Column ss:Width="83.25" ss:Span="5"/>'+Enter
cCabec+='   <Column ss:Index="13" ss:Width="125.5"/>'+Enter
cCabec+='   <Row ss:AutoFitHeight="0">'+Enter
cCabec+='    <Cell ss:StyleID="s121"><Data ss:Type="String">Banco</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s121"><Data ss:Type="String">Nome</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s121"><Data ss:Type="String">Carteira</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s121"><Data ss:Type="String">DescriÃ§Ã£o</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s122"><Data ss:Type="String">Cliente</Data></Cell>'+Enter
cCabec+='    <Cell ss:StyleID="s122"><Data ss:Type="String">Nome</Data></Cell>'+Enter

(cAliasQry)->(DbGotop())
Do While (cAliasQry)->(!Eof())
	cCabec+='    <Cell ss:StyleID="s80"><Data ss:Type="DateTime">'+R007Trans( Stod( (cAliasQry)->E1_VENCREA )  ) +'</Data></Cell>'+Enter
	AADD(aDtValidas,{(cAliasQry)->E1_VENCREA,0} )
	(cAliasQry)->(DbSkip())
EndDo

cCabec+='    <Cell ss:StyleID="s123"><Data ss:Type="String">Total Geral</Data></Cell>'+Enter
cCabec+='   </Row>'+Enter

R007Write(@cCabec)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGR007  ºAutor  ³Microsiga           º Data ³  12/04/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function R007RodaPe()
Local cRodaPe:=""
Local nInd

cRodaPe+='<WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">'+Enter
cRodaPe+='   <PageSetup>'+Enter
cRodaPe+='    <Header x:Margin="0.31496062000000002"/>'+Enter
cRodaPe+='    <Footer x:Margin="0.31496062000000002"/>'+Enter
cRodaPe+='    <PageMargins x:Bottom="0.78740157499999996" x:Left="0.511811024"'+Enter
cRodaPe+='     x:Right="0.511811024" x:Top="0.78740157499999996"/>'+Enter
cRodaPe+='   </PageSetup>'+Enter
cRodaPe+='   <Selected/>'+Enter
cRodaPe+='   <FreezePanes/>'+Enter
cRodaPe+='   <FrozenNoSplit/>'+Enter
cRodaPe+='   <SplitHorizontal>1</SplitHorizontal>'+Enter
cRodaPe+='   <TopRowBottomPane>1</TopRowBottomPane>'+Enter
cRodaPe+='   <ActivePane>2</ActivePane>'+Enter
cRodaPe+='   <Panes>'+Enter
cRodaPe+='    <Pane>'+Enter
cRodaPe+='     <Number>3</Number>'+Enter
cRodaPe+='     <ActiveRow>8</ActiveRow>'+Enter
cRodaPe+='     <ActiveCol>6</ActiveCol>'+Enter
cRodaPe+='    </Pane>'+Enter
cRodaPe+='   </Panes>'+Enter
cRodaPe+='   <ProtectObjects>False</ProtectObjects>'+Enter
cRodaPe+='   <ProtectScenarios>False</ProtectScenarios>'+Enter
cRodaPe+='  </WorksheetOptions>'+Enter
cRodaPe+=' </Worksheet>'+Enter
cRodaPe+='</Workbook>'+Enter

R007Write(cRodaPe)

Return cRodaPe

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGFINR007ºAutor  ³Microsiga           º Data ³  02/05/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function R007AdLinha(aAux,aLinhas,nPos)
Local nInd

For nInd:=1 To Len(aAux)
	If nInd>Len(aLinhas)
		AADD(aLinhas,{"","","","",""})
	EndIf
	aLinhas[nInd,nPos]	:=aAux[nInd]
Next

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGFINR007ºAutor  ³Microsiga           º Data ³  02/19/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function MySndMail(cAssunto, cMensagem, aAnexos, cEmailTo, cEmailCc, cErro)

Local lRetorno 		:= .T.
Local cServer   := GetNewPar("MV_RELSERV","")
Local cAccount	:= GetNewPar("MV_RELACNT","")
Local cPassword	:= GetNewPar("MV_RELAPSW","")
Local lMailAuth := GetNewPar("MV_RELAUTH",.F.)


Default cEmailCc 	:= ""
Default aAnexos		:= {}
Default cMensagem	:= ""
Default cAssunto	:= ""
Default cErro		:= ""

If !Empty(cEmailTo) .And. !Empty(cAssunto) .And. !Empty(cMensagem)
	
	If MailSmtpOn( cServer, cAccount, cPassword )		
		If lMailAuth			
			If ! ( lRetorno := MailAuth(cAccount,cPassword) )				
				lRetorno := MailAuth(SubStr(cAccount,1,At("@",cAccount)-1),cPassword)				
			EndIf			
		Endif		
		If lRetorno			
			If !MailSend(cAccount,{cEmailTo},{cEmailCc},{},cAssunto,cMensagem,aAnexos,.F.)
				cErro := "Erro na tentativa de e-mail para " + cEmailTo + ". " + Mailgeterr()
				lRetorno := .F.
			EndIf
		Else			
			cErro := "Erro na tentativa de autenticação da conta " + cAccount + ". "
			lRetorno := .F.
		EndIf		
		MailSmtpOff()		
	Else
		cErro := "Erro na tentativa de conexão com o servidor SMTP: " + cServer + " com a conta " + cAccount + ". "
		lRetorno := .F.
	EndIf	
Else
	
	If Empty(cEmailTo)
		cErro := "É neessário fornecer o destinátario para o e-mail. "
		lRetorno := .F.
		
	EndIf
	
	If Empty(cAssunto)
		
		cErro := "É neessário fornecer o assunto para o e-mail. "
		lRetorno := .F.
		
	EndIf
	
	If Empty(cMensagem)
		
		cErro := "É neessário fornecer o corpo do e-mail. "
		lRetorno := .F.
		
	EndIf
	
Endif

Return(lRetorno)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGFINR007ºAutor  ³Microsiga           º Data ³  02/19/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function R007TOK()
Local lRetorno:=.T.

If M->ZAL_AGENDA=='S' .And. Empty(M->ZAL_EMAIL)
	MsgStop("Quando a opção Agendar igual a Sim é obrigatório o preenchimento do campo Email")
	lRetorno:=.F.
EndIf	

Return lRetorno