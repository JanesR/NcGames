#INCLUDE "PROTHEUS.CH"
#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"

#Define CRLF Chr(13)+Chr(10)

Static nVlrPed := 0

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR124  ºAutor  ³Microsiga           º Data ³  10/23/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function NCGPR124()

Local cFiltro	:= ""
Local cUser		:= RetCodUsr(Substr(cUsuario,1,6))
Local cUserPer	:= "000307;000456" //Alltrim(U_MyNewSX6("EC_NCG0023","000307;000086;000311;000371","C","Usuário com acesso a alterar o pedido","","",.F. ))

Private cCadastro := "Regras de Cond. Pagto."
Private aRotina	:= MenuDef()


// If cUser $ cUserPer

cFiltro:= "ZE4_FLAG='1'"

DbSelectArea("ZE4")
MBrowse( 6,1,22,75,"ZE4",,,,,,,,,,,,,,cFiltro)

//Else

//	Alert("Usuário você não possue acesso a este menu, solicitar ao Administrador do sistema.","NCGPR124")

//EndIf


Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MenuDef   ºAutor  ³Microsiga           º Data ³  10/23/14   º±±
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

Private aRotina := {{"Pesquisar"	,"AxPesqui"			,0,1} ,;
{"Visualizar"	,"U_Pr124Manu"		,0,2} ,;
{"Incluir"		,"U_Pr124Manu"		,0,3} ,;
{"Alterar"		,"U_Pr124Manu"		,0,4} ,;
{"Excluir"		,"U_Pr124Manu"		,0,5} }


Return aRotina

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR124  ºAutor  ³Microsiga           º Data ³  10/23/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function Pr124Manu(cAlias,nReg,nOpc)

Local oDlg
Local lGravar		:= .F.
Local aArea			:= GetArea()
Local aSize   		:= MsAdvSize()
Local aObjects		:= {}

Local aCpoCab		:= {}//Campos do Cabeçalho
Local aCpoEnable	:= {}//Campos Ativos
Local aCpoGrid		:= {}//Campos de Grid

Local bOk			:= {|| Iif(Obrigatorio(aGets,aTela),(lGravar:=.T.,oDlg:End()),) }
Local bCancel		:= {|| lGravar:=.F.,oDlg:End() }
Local aButtons		:= {}
Local aFolders		:= {OemToAnsi('Condições de Pagto. Válidas')}

Local nOpcy			:= IIf( (nOpc==3 .Or. nOpc==4),GD_INSERT+GD_UPDATE+GD_DELETE,0   )

Local cSeekKey		:= xFilial("ZE4")+ZE4->ZE4_COD
Local bSeekWhile	:= {|| ZE4_FILIAL+ZE4_COD+ZE4_FLAG }
Local uSeekFor		:= {}

Local aInfo			:= {}
Local aPosObj		:= {}
Local aPosFld		:= {}
Local aObjFld		:= {}

Local aHeadCond	:= {}
Local aColsCond	:= {}

Private aHeadGrid	:= {}
Private aColsGrid	:= {}

Private oFolder
Private oObjBrow
Private oGetGrid

Private aTELA[0][0],aGETS[0]

aCpoCab		:= {"ZE4_COD","ZE4_CANAL","ZE4_DCANAL","ZE4_CRULES","NOUSER"}
aCpoGrid		:= {"ZE4_ITEM","ZE4_VLRMIN","ZE4_VLRMAX","ZE4_PMEDIO","ZE4_CPDEFA"}
aCpoEnable	:= {}


RegToMemory("ZE4",nOpc==3)
//FillGetDados ( < nOpc>, < cAlias>, [ nOrder], [ cSeekKey], [ bSeekWhile], [ uSeekFor], [ aNoFields], [ aYesFields], [ lOnlyYes], [ cQuery], [ bMontCols], [ lEmpty], [ aHeaderAux], [ aColsAux], [ bAfterCols], [ bBeforeCols], [ bAfterHeader], [ cAliasQry], [ bCriaVar], [ lUserFields], [ aYesUsado] ) --> lRet
ZE4->(FillGetDados ( nOpc, "ZE4",1, cSeekKey+"2", bSeekWhile,  /*uSeekFor*/, /*aNoFields*/, aCpoGrid, .T., /*[ cQuery]*/, /*[bMontCols]*/, nOpc==3, aHeadGrid, aColsGrid, /*[ bAfterCols]*/, /*[ bBeforeCols]*/, /*[ bAfterHeader]*/, /*[ cAliasQry]*/, /*[ bCriaVar]*/, .F.,/*[aYesUsado]*/))

aSizeAut	:= MsAdvSize(,.F.,400)
AAdd( aObjects, { 0,    70, .T., .F. } )
AAdd( aObjects, { 100, 100, .T., .T. } )

aInfo	:= { aSizeAut[ 1 ], aSizeAut[ 2 ], aSizeAut[ 3 ], aSizeAut[ 4 ], 3, 3 }
aPosObj	:= MsObjSize( aInfo, aObjects )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Calcula o Size para os Folders³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Aadd( aObjFld, {   1  ,  1, .T., .T. } )
aInfoFld := {1,1,aPosObj[2,4] - aPosObj[2,2] ,aPosObj[2,3] - aPosObj[2,1],3,3}
aPosFld := MsObjSize( aInfoFld, aObjFld )

DEFINE MSDIALOG oDlg TITLE OemtoAnsi("Regra de Condição de Pagamento") From aSize[7],0 To aSize[6],aSize[5] of oMainWnd PIXEL
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Monta a Enchoice superior com? os Dados da Carga³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Enchoice( "ZE4", nReg, nOpc, , , , aCpoCab, {aPosObj[1,1],aPosObj[1,2],aPosObj[1,3],aPosObj[1,4]},/*{}*/, 1, , ,"AllwaysTrue()", oDlg, .F.,  .T., .F., , .T., .F.)


oFolder := TFolder():New(aPosObj[2,1],aPosObj[2,2],aFolders,{'','',''},oDlg,,,,.T.,.F.,aPosObj[2,4]-aPosObj[2,2],aPosObj[2,3]-aPosObj[2,1])
nGd1 := 2
nGd2 := 2
nGd3 := aPosObj[2,3]-aPosObj[2,1]-15
nGd4 := aPosObj[2,4]-aPosObj[2,2]-4

//MsNewGetDados(): New ( [ nTop], [ nLeft], [ nBottom], [ nRight ], [ nStyle], [ cLinhaOk], [ cTudoOk], [ cIniCpos], [ aAlter], [ nFreeze], [ nMax], [ cFieldOk], [ cSuperDel], [ cDelOk], [ oWnd], [ aPartHeader], [ aParCols], [ uChange], [ cTela] ) --> Objeto
oGetGrid := MsNewGetDados():New(nGd1,nGd2,nGd3,nGd4,nOpcy,"AllwaysTrue","AllwaysTrue","+ZE4_ITEM",/*aCpoEnable*/,/*nFreeze*/,/*nMax*/,/*cFieldOk*/,/*cSuperDel*/,/*cDelOk*/ ,oFolder:aDialogs[1],aHeadGrid,aColsGrid)

ACTIVATE MSDIALOG oDlg ON INIT ( EnchoiceBar(oDlg,bOk,bCancel,,aButtons) )

If nOpc<>2 .And. lGravar
	Begin Transaction
	Processa( {|| PR124Grav(nOpc,aCpoCab,aCpoGrid,aHeadGrid,oGetGrid:aCols) } )
	End Transaction
ElseIf __lSX8
	RollBackSX8()
EndIf


RestArea(aArea)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR124  ºAutor  ³Microsiga           º Data ³  10/23/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PR124Grav(nOpc,aCpoCab,aCpoGrid,aHeadGrid,aColsGrid)
Local aAreaAtu		:= GetArea()
Local aAreaZE4		:= ZE4->(GetArea())

Local cFilZE4		:= xFilial("ZE4")
Local cChaveZE4	:= cFilZE4+ZE4->ZE4_COD
Local nY

If nOpc==5 // Exclusao
	ZE4->(DbSetOrder(1))
	ZE4->(DbSeek(cChaveZE4))
	ZE4->( DbEval( {|| RecLock("ZE4",.F.),DbDelete(),MsUnLock()  },{|| ZE4_FILIAL+ZE4_COD==cChaveZE4  },{|| .T. }  )    )
Else
	If nOpc==4//Alterar
		ZE4->(DbSetOrder(1))
		ZE4->(DbSeek(cChaveZE4+"1"))
	EndIf
	ZE4->(RecLock("ZE4",nOpc==3))
	For nInd:=1 To Len(aCpoCab)
		If (nPosCpo:=ZE4->(FieldPos(aCpoCab[nInd]) ))>0
			ZE4->( FieldPut(nPosCpo, M->&(aCpoCab[nInd]) ) )
		EndIf
	Next
	ZE4->ZE4_FILIAL:= cFilZE4
	ZE4->ZE4_FLAG	:= "1"
	
	ZE4->(MsUnlock())
	
	For nInd:=1 To Len(aColsGrid)
		If !Empty(GdFieldGet("ZE4_VLRMIN",nInd,,aHeadGrid,aColsGrid))
			P124GrGrid(aHeadGrid,aColsGrid,nInd,"2")
		EndIf
	Next
	
	ConfirmSX8()
EndIf

RestArea(aAreaZE4)
RestArea(aAreaAtu)

Return .T.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR123  ºAutor  ³Microsiga           º Data ³  07/02/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function P124GrGrid(aHeader,aCols,nInd,cFlag)

Local cFilZE4	:= xFilial("ZE4")
Local nPosRec	:= GdFieldPos("ZE4_REC_WT",aHeader)
Local lTemRecno:= .F.
Local nColuna
Local nYnd

If aCols[nInd,nPosRec]>0
	ZE4->( DbGoTo( aCols[nInd,nPosRec] ) )
	lTemRecno:=.T.
EndIf

If GdDeleted( nInd , aHeader , aCols )
	If lTemRecno
		ZE4->(RecLock("ZE4",.F.))
		ZE4->(dbDelete())
		ZE4->(MsUnLock())
	EndIf
Else
	ZE4->(RecLock("ZE4",!lTemRecno))
	For nYnd:=1 To Len(aHeader)
		nColuna:=ZE4->(FieldPos(aHeader[nYnd,2]))
		If nColuna>0
			ZE4->(FieldPut(nColuna,GdFieldGet(aHeader[nYnd,2],nInd,,aHeader,aCols)))
		EndIf
	Next
	ZE4->ZE4_COD	 := M->ZE4_COD
	ZE4->ZE4_CANAL	 := M->ZE4_CANAL
	ZE4->ZE4_DCANAL := M->ZE4_DCANAL
	ZE4->ZE4_FILIAL := cFilZE4
	ZE4->ZE4_FLAG	 := cFlag
	ZE4->ZE4_CRULES := M->ZE4_CRULES
	
	ZE4->(MsUnlock())
EndIf


Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR124  ºAutor  ³Microsiga           º Data ³  11/13/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function P124CONDPG()
Local cAliasQry:= GetNextAlias()
Local aAreaAtu	:= GetArea()
Local aAreaSC5	:= SC5->(GetArea())
Local aAreaZE4	:= ZE4->(GetArea())
Local aAreaSE4	:= SE4->(GetArea())

Local cFiltro	:="@#"
Local cQry		:= ""

Local cUserAdm	:= Alltrim(U_MyNewSX6("NCG_000073","000086","C","Usuário Adm. das condições de pagto no pedido"," "," ",.F. ))
Local cCanEspe	:= Alltrim(U_MyNewSX6("NCG_000057","000013","C","Canais que precisaram de validação de condições liberadas pelo financeiro"," "," ",.F. ))
Local cUser		:= RetCodUsr(Substr(cUsuario,1,6))
Local lVerEstoque := .T.
Local lExec 	:=.F.

ZE4->(DbSetOrder(2))

If IsInCallStack('MATA410')
	lExec := ZE4->(DbSeek(xFilial("ZE4")+M->C5_YCANAL))
EndIf

If lExec .And. !(cUserAdm$cUser) // Verificar se o usuário é o Adm. da condição
	
	cQry+="		SELECT MAX(ZE4_PMEDIO) MEDIA"+CRLF
	cQry+="		FROM "+RetSqlName("ZE4")+" ZE4"+CRLF
	cQry+="		WHERE ZE4_COD IN"+CRLF
	cQry+="			("+CRLF
	cQry+="			SELECT ZE4_COD"+CRLF
	cQry+="			FROM "+RetSqlName("ZE4")+" E4"+CRLF
	cQry+="			WHERE E4.ZE4_CANAL = '"+M->C5_YCANAL+"'"+CRLF
	cQry+="			AND E4.ZE4_FILIAL = '"+xFilial("ZE4")+"'"+CRLF
	cQry+="			)"+CRLF
	cQry+="		AND ZE4.ZE4_FILIAL = '"+xFilial("ZE4")+"'"+CRLF
	cQry+="		AND ZE4.ZE4_FLAG = '2'"+CRLF
	
	If nVlrPed > 0
		cQry+="		AND ZE4.ZE4_VLRMIN <= "+AllTrim(str(nVlrPed))+""+CRLF
		cQry+="		AND ZE4.ZE4_VLRMAX >= "+AllTrim(str(nVlrPed))+""+CRLF
	Endif
	
	cQry := ChangeQuery(cQry)
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),cAliasQry,.T.,.T.)
	
	nMedia:= (cAliasQry)->MEDIA
	(cAliasQry)->(DbCloseArea())
	
	If M->C5_YCANAL $ cCanEspe
		cFiltro:="@#SE4->E4_YPMEDIO<="+Alltrim(Str(nMedia))+"@#"
	Else
		cFiltro:="@#SE4->E4_YPMEDIO<="+Alltrim(Str(nMedia))+" .And. SE4->E4_XPORTAL=='S'@#"
	EndIf
Else
	cFiltro:="@#SE4->E4_XPORTAL=='S'@#"
EndIf

RestArea(aAreaSC5)
RestArea(aAreaZE4)
RestArea(aAreaSE4)
RestArea(aAreaAtu)

Return cFiltro



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR124  ºAutor  ³Microsiga           º Data ³  11/19/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function P124ValCP(lRet)

Local cAliasSE4	:= SE4->(GetArea())
Local cAliasZE4	:= ZE4->(GetArea())
Local cAliasSA1	:= SA1->(GetArea())
Local cAliasQry	:= GetNextAlias()
Local cQry			:= ""

Local nSaldo		:= 0
Local nQuantPed	:= 0
Local cProdut		:= ""
Local nQuantPV		:= 0
Local nTotalPV		:= 0
Local nQtdResva	:= 0

Local cUserAdm		:= Alltrim(U_MyNewSX6("NCG_000073","000086","C","Usuário Adm. das condições de pagto no pedido"," "," ",.F. ))
Local cUser			:= RetCodUsr(Substr(cUsuario,1,6))
Local lVerEstoque := U_MyNewSX6("NCG_000076",".T.","L","Total do pedido apenas de produtos disponiveis"," "," ",.F. )
Local lValida		:= .t.
Local lExec

Default lRet 		:= .f.

ZE4->(DbSetOrder(2))

lExec := ZE4->(DbSeek(xFilial("ZE4")+M->C5_YCANAL))

SE4->(DbSetOrder(1))
SE4->(DbSeek(xFilial("SE4")+M->C5_CONDPAG))

IF SE4->E4_TIPO=="9"
	
	lRet := .F.
	MsgAlert("A Condição de pagamento escolhida é de uso exclusivo do Ecommerce","NCGPR124-3")
	
	RestArea(cAliasSA1)
	RestArea(cAliasZE4)
	RestArea(cAliasSE4)
	
	Return (lret)
EndIf
If (cUser$cUserAdm) .And. !AllTrim(M->C5_YORIGEM)=="WM"
	If MsgYesNo("Indentificamos que seu usuário tem acesso de Administrador, deseja validar a Condição de Pagamento?","Val_Cond_Pag")
		lValida := .T.
	Else
		lValida := .F.
	EndIf
EndIf

If lValida .And. M->C5_YCANAL <> "990000" // Verificar se o usuário é o Adm. da condição.
	
	If lExec .And. lRet
		
		MaFisSave()
		MaFisClear()
		
		
		MaFisIni(M->C5_CLIENT,;    		// 1-Codigo Cliente/Fornecedor
		M->C5_LOJACLI,;   					// 2-Loja do Cliente/Fornecedor
		Iif(M->C5_TIPO$'DB',"F","C"),; 	// 3-C:Cliente , F:Fornecedor
		M->C5_TIPO,;    						// 4-Tipo da NF
		M->C5_TIPOCLI,;   		   		// 5-Tipo do Cliente/Fornecedor
		Nil,;       			   			// 6-Relacao de Impostos que suportados no arquivo
		Nil,;            						// 7-Tipo de complemento
		Nil,;         							// 8-Permite Incluir Impostos no Rodape .T./.F.
		"SB1",;       							// 9-Alias do Cadastro de Produtos - ("SBI" P/ Front Loja)
		"MATA410")       						// 10-Nome da rotina que esta utilizando a funcao
		
		
		nTotLinha := Len(aCols)
		
		For nInd := 1 To nTotLinha
			
			If GdDeleted( nInd)
				Loop
			Endif
			
			cProdut		:= GdFieldGet( "C6_PRODUTO", nInd)
			nQuantPV		:= GdFieldGet( "C6_QTDVEN", nInd)
			nSaldo		:= 0
			nQuantPed	:= 0
			
			If lVerEstoque
				SB2->(DbSeek(xFilial("SB2")+cProdut+GdFieldGet("C6_LOCAL", nInd)))
				SC0->(DbSetOrder(2))
				If SC0->(DbSeek(xFilial("SC0")+cProdut+GdFieldGet("C6_LOCAL", nInd)+GdFieldGet("C6_RESERVA", nInd)))
					If GdFieldGet("C6_QTDRESE",nInd) > 0
						nQtdResva:=GdFieldGet("C6_QTDRESE",nInd)
					Else
						If SC0->C0_QUANT > 0 .And. GdFieldGet( "C6_QTDVEN", nInd)<=SC0->C0_QUANT
							nQtdResva:=SC0->C0_QUANT
						EndIf
					EndIf
					
					nSaldo := SB2->B2_QATU-SB2->B2_RESERVA+nQtdResva
				Else
					nSaldo := SB2->(B2_QATU-B2_RESERVA)
				EndIf
				
				If nQuantPV > nSaldo
					nQuantPed := nSaldo
				elseIf nQuantPV <= nSaldo
					nQuantPed := nQuantPV
				EndIf
			EndIf
			
			If AVALTES(GdFieldGet("C6_TES",nInd),,'N')
				Loop
			EndIf
			
			If lVerEstoque
				nTotalPV := nQuantPed*GdFieldGet("C6_PRCVEN", nInd)
			Else
				nTotalPV := nQuantPV*GdFieldGet("C6_PRCVEN", nInd)
			EndIf
			
			
			MaFisAdd(cProdut,;   				// 1-Codigo do Produto ( Obrigatorio )
			GdFieldGet("C6_TES", nInd),;	   // 2-Codigo do TES ( Opcional )
			nQuantPV,;  							// 3-Quantidade ( Obrigatorio )
			GdFieldGet( "C6_PRCVEN", nInd),;	// 4-Preco Unitario ( Obrigatorio )
			0,; 			   						// 5-Valor do Desconto ( Opcional )
			"",;	   								// 6-Numero da NF Original ( Devolucao/Benef )
			"",;			   						// 7-Serie da NF Original ( Devolucao/Benef )
			"",;										// 8-RecNo da NF Original no arq SD1/SD2
			0,;										// 9-Valor do Frete do Item ( Opcional )
			0,;										// 10-Valor da Despesa do item ( Opcional )
			0,;				   					// 11-Valor do Seguro do item ( Opcional )
			0,;				   					// 12-Valor do Frete Autonomo ( Opcional )
			nTotalPV,;								// 13-Valor da Mercadoria ( Obrigatorio )
			0,;										// 14-Valor da Embalagem ( Opiconal )
			,;											//
			,;											//
			GdFieldGet("C6_ITEM", nInd))
			
		Next
		
		nVlrPed	:=	MaFisRet(,"NF_TOTAL")
		
		cQry+="	SELECT ZE4.ZE4_PMEDIO MEDIA, "+CRLF
		cQry+="	ZE4.ZE4_CPDEFA CPDEF,"+CRLF
		cQry+="	ZE4.ZE4_CRULES RULES"+CRLF
		cQry+="	FROM "+RetSqlName("ZE4")+" ZE4"+CRLF
		cQry+="	WHERE ZE4.ZE4_FILIAL = '"+xFilial("ZE4")+"'"+CRLF
		cQry+="	AND ZE4.ZE4_CANAL = '"+M->C5_YCANAL+"'"+CRLF
		cQry+="	AND ZE4.ZE4_FLAG = '2'"+CRLF
		cQry+="	AND ZE4.D_E_L_E_T_ = ' '"+CRLF
		If nVlrPed > 0
			cQry+="	AND ZE4.ZE4_VLRMIN <= "+AllTrim(str(nVlrPed))+""+CRLF
			cQry+="	AND ZE4.ZE4_VLRMAX >= "+AllTrim(str(nVlrPed))+""+CRLF
		EndIf
		
		cQry := ChangeQuery(cQry)
		dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),cAliasQry,.T.,.T.)
		
		SA1->(DbSetOrder(1))
		SA1->(DbSeek(xFilial("SA1")+M->C5_CLIENT+M->C5_LOJACLI))
		
		SZR->(DbSetOrder(1))
		
		If SZR->(DbSeek(xFilial("SZR")+M->C5_NUM)) .And. M->C5_CONDPAG == M->C5_YCONDPG
			MsgAlert("Pedido já foi liberado por este motivo a condição anterior é válida","NCGPR124-1")
		Else
			If AllTrim(M->C5_YORIGEM)=="WM" .And. !Empty((cAliasQry)->CPDEF)
				M->C5_CONDPAG := (cAliasQry)->CPDEF
				lRet := .T.
			Else
				IF (cAliasQry)->RULES == 'S' .And. M->C5_CONDPAG == SA1->A1_COND
					lRet := .T.
				Else
					If SE4->E4_YPMEDIO <= (cAliasQry)->MEDIA
						lRet := .T.
					Else
						lRet := .F.
						MsgAlert("A Condição de pagamento escolhida não atende o valor do pedido, favor alterar a mesma","NCGPR124-2")
					EndIf
				EndIf
			EndIf
		EndIf
		MaFisRestore()
		(cAliasQry)->(DbCloseArea())
	EndIf
EndIf


RestArea(cAliasSA1)
RestArea(cAliasZE4)
RestArea(cAliasSE4)

Return (lret)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR124  ºAutor  ³Microsiga           º Data ³  11/26/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function Pr124Gat()

Local nTotCond		:= 0
Local aCondPgto 	:= {}
Local nY
Local nTotlinhas

aCondPgto := Separa(M->E4_COND,",")
nTotlinhas:= Len(aCondPgto)

For nY:=1 To Len(aCondPgto)
	nTotCond += Val(aCondPgto[nY])
Next

nMedia := nTotCond/nTotlinhas

Return (nMedia)
