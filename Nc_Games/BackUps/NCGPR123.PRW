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

Local cFiltro	:= "ZC5_STATUS IN ('4','10') AND ZC5_CODINT <> '015'" 
Local cUser		:= RetCodUsr(Substr(cUsuario,1,6))
Local cUserPer	:= Alltrim(U_MyNewSX6("EC_NCG0023","000307;000086;000311;000371","C","Usuแrio com acesso a alterar o pedido","","",.F. ))

Private cCadastro := "Pedido Intermediario"
Private aRotina	:= MenuDef() 

cUserPer := Alltrim(SuperGetMv("EC_NCG0023",.t.,"000307;000086"))

If cUser $ cUserPer

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
Local aCpoCab	:= {"ZC5_NUM","ZC5_CLIENT","ZC5_LOJA","ZC5_COND","ZC5_STATUS","ZC5_TOTAL","ZC5_FRETE","NOUSER"}
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
Enchoice( "ZC5", nReg, nOpc,/*aCRA*/,/*cLetras*/,/*cTexto*/, aCpoCab, {aPosObj[1,1],aPosObj[1,2],aPosObj[1,3],aPosObj[1,4]},{}, 1, , ,"AllwaysTrue()", oDlg, .F.,  .T., .F., , .T., .F.)

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
	lCancPV 				:= .t.
	
ElseIf M->ZC5_STATUS $ "15,30,16"
	
	U_NCECOM09(ZC5->ZC5_NUM, ZC5->ZC5_NUMPV,"Pedido Reimportado")
	
EndIf

ZC5->ZC5_ESTORN	:= "S"
ZC5->ZC5_CODINT	:= "015" //Adicionado para controlar pedidos que jแ foram alterados

ZC5->(MsUnlock())

If lCancPV .And. !Empty(M->ZC5_NUMPV)
	U_COM08GRAVA("VERIFICA_CANCELAMENTO")
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

If __ReadVar $ "M->ZC6_QTDVEN"
	nQtnPed	:= M->ZC6_QTDVEN
	nPrcVen	:= GdFieldGet("ZC6_VLRUNI")
	If M->ZC6_QTDVEN > 0 .And. !(Empty(GdFieldGet("ZC6_PRODUT")))
		SB2->(DbSetOrder(1))
		SB2->(MsSeek(xFilial("SB2")+GdFieldGet("ZC6_PRODUT")+cArmPad))
		nEstAtu := SB2->B2_QATU-SB2->B2_RESERVA
		GdFieldPut("B2_QATU",nEstAtu,oGetProd:nAT,oGetProd:aHeader,oGetProd:aCols)
	EndIf
ElseIf __ReadVar $ "M->ZC6_VLRUNI"
	nQtnPed	:= GdFieldGet("ZC6_QTDVEN")
	nPrcVen	:= M->ZC6_VLRUNI
EndIf

nVlrTot := nQtnPed*nPrcVen

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
