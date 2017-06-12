#INCLUDE "PROTHEUS.CH"
#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"

#Define Enter Chr(13)+Chr(10)
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR707  บAutor  ณMicrosiga           บ Data ณ  10/03/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PR707JOB(aDados)
//SEND MAIL
Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษอออออออออออัออออออออออหอออออออัอออออออออออออออออออออออออออหออออัออออออออออปฑฑ
ฑฑบPrograma   |NCGPR707  บ Autor ณ Cleverson                 บDataณ03.10.2013บฑฑ
ฑฑฬอออออออออออุออออออออออสอออออออฯอออออออออออออออออออออออออออสออออฯออออออออออนฑฑ
ฑฑบDescricao  ณ Tabela de Preco Promocional			   							  บฑฑ
ฑฑฬอออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametros ณ                                                              บฑฑ
ฑฑฬอออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบ Retorno   ณ                                                              บฑฑ
ฑฑฬอออออออออออุออออออออออออออออออออออออออออออออออออออออออออออหออออัออออออออออนฑฑ
ฑฑบSolicitanteณ                                              บDataณ          บฑฑ
ฑฑฬอออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออสออออฯออออออออออนฑฑ
ฑฑบ               ALTERACOES EFETUADAS APOS CONSTRUCAO INICIAL               บฑฑ
ฑฑฬอออออออออออัออออออออออออออออออออออออออออออออออออออออออออออหออออัออออออออออนฑฑ
ฑฑบAnalista   ณ   Cleverson                                  บDataณ          บฑฑ
ฑฑฬอออออออออออุออออออออออออออออออออออออออออออออออออออออออออออสออออฯออออออออออนฑฑ
ฑฑบDescricao  ณ                                                              บฑฑ
ฑฑฬอออออออออออุออออออออออออออออออออออออออออออออออออออออออออออหออออัออออออออออนฑฑ
ฑฑบAutor      ณ                                              บDataณ          บฑฑ
ฑฑศอออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออสออออฯออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
User Function NCGPR707()
Private aStatus	:=RetSx3Box( Posicione("SX3", 2, "ZZE_STATUS","X3CBox()" ),,,1)
Private cCadastro := OemToAnsi("Tabela de Pre็o Promocional")
Private aRotina := MenuDef()

U_PR707Staus("X") // Verifica se hแ tabela promocional encerrada e atualiza o Status

oBrowse:=FwMbrowse():New()
oBrowse:SetAlias("ZZE")
oBrowse:SetDescription(cCadastro)

//P=Pendente Aprovacao;E=Em Aprovacao;A=Aprovada;R=Reprovada;X=Encerrada

oBrowse:AddLegend( 'ZZE->ZZE_STATUS=="P"'		 ,"ORANGE"	,"Pendente Aprovacao" )
oBrowse:AddLegend( 'ZZE->ZZE_STATUS=="E"'		 ,"YELLOW"	,"Em Aprovacao" )
oBrowse:AddLegend( 'ZZE->ZZE_STATUS=="A"'		 ,"GREEN"	,"Aprovada" )
oBrowse:AddLegend( 'ZZE->ZZE_STATUS=="R"'		 ,"RED"		,"Reprovada" )
oBrowse:AddLegend( 'ZZE->ZZE_STATUS=="X"'		 ,"GRAY"		,"Encerrada" )


// Defini็ใo de filtro
oBrowse:SetFilterDefault("ZZE_FLAG='0'")

oBrowse:DisableDetails()

oBrowse:Activate()


Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR707  บAutor  ณMicrosiga           บ Data ณ  10/05/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function MenuDef()
Local aCor := {}
Local aRotina:={}

AADD(aRotina,{"Pesquisar","AxPesqui"		,0,1})
AADD(aRotina,{"Visualizar","U_PR707Manut",0,2})
AADD(aRotina,{"Incluir","U_PR707Manut",0,3})
AADD(aRotina,{"Alterar","U_PR707Manut",0,4})
AADD(aRotina,{"Excluir","U_PR707Manut",0,2})
AADD(aRotina,{"Encerrar Manual","U_PR707Manut",0,4})
AADD(aRotina,{"Enviar Aprovacao","U_PR707Envi",0,5})
AADD(aRotina,{"Legenda","U_PR707LEG('1')",0,2})

Return aRotina

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR707  บAutor  ณMicrosiga           บ Data ณ  10/05/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PR707Manut(cAlias,nReg,nOpc,cOpcao)
Local lTabPreco :=IsInCallStack("U_PR707WFA")//Analise da Tabela de Prec็o
Local oDlg
Local lGravar	:=.F.
Local aArea		:= GetArea()
Local aSize   	:= MsAdvSize()
Local aObjects	:= {}
Local aCpoCab	:= {"ZZE_CODIGO","ZZE_DESCRI","ZZE_CANAL","ZZE_DESCAN","ZZE_STATUS","ZZE_DTINI","ZZE_DTFIM","NOUSER"}
Local aInfo		:= {}
Local aPosObj	:= {}
Local aPosFld	:= {}
Local aObjFld	:= {}
Local bOk		:={|| Iif(Obrigatorio(aGets,aTela) .And. U_PR707TOK(),(lGravar:=.T.,oDlg:End()),) }
Local bCancel	:={|| lGravar:=.F.,oDlg:End() }
Local aButtons	:={}
Local aFolders	:={OemToAnsi('Pre็o Promocionais')}
Local nOpcy		:=IIf( (nOpc==3 .Or. nOpc==4),GD_INSERT+GD_UPDATE+GD_DELETE,0   )
Local bAfterCols:={|| U_PR707Ini() }
Local cSeekKey	:=xFilial("ZZE")+ZZE->ZZE_CODIGO
Local bSeekWhile := {|| ZZE_FILIAL+ZZE_CODIGO+ZZE_FLAG }
Local uSeekFor	:={}

Local aHeadPreco:={}
Local aColsPreco:={}

Local aHeadCliente:={}
Local aColsCliente:={}

Default cOpcao:=""

Private oGetCliente
Private aTELA[0][0],aGETS[0]
Private oFolder


If !PR707EDIT(nOpc,lTabPreco,cOpcao)//Verifica a possibilidade de edi็ใo da Tabela Promocional
	Return
EndIf

nRecZZE:=ZZE->(Recno())
RegToMemory("ZZE",nOpc==3)
//FillGetDados ( < nOpc>, < cAlias>, [ nOrder], [ cSeekKey], [ bSeekWhile], [ uSeekFor], [ aNoFields], [ aYesFields], [ lOnlyYes], [ cQuery], [ bMontCols], [ lEmpty], [ aHeaderAux], [ aColsAux], [ bAfterCols], [ bBeforeCols], [ bAfterHeader], [ cAliasQry], [ bCriaVar], [ lUserFields], [ aYesUsado] ) --> lRet
//Pre็o
ZZE->(FillGetDados ( nOpc, "ZZE",1, cSeekKey+"1", bSeekWhile,  /*uSeekFor*/, /*aNoFields*/, {"ZZE_ITEM","ZZE_UF","ZZE_DESCUF","ZZE_CLIENT","ZZE_LOJA","ZZE_NOMCLI","ZZE_PRODUT","ZZE_DESCPR","ZZE_PRECO","ZZE_ATIVO"}, .T., /*[ cQuery]*/, /*[bMontCols]*/, nOpc==3, aHeadPreco, aColsPreco, bAfterCols, /*[ bBeforeCols]*/, /*[ bAfterHeader]*/, /*[ cAliasQry]*/, /*[ bCriaVar]*/, .F., {"ZZE_ITEM","ZZE_UF","ZZE_DESCUF","ZZE_CLIENT","ZZE_LOJA","ZZE_NOMCLI","ZZE_PRODUT","ZZE_DESCPR","ZZE_PRECO","ZZE_ATIVO"} ))


//Cliente
//ZZE->(FillGetDados ( nOpc, "ZZE",1, cSeekKey+"2", bSeekWhile,  /*uSeekFor*/, /*aNoFields*/, {"ZZE_UF","ZZE_DESCUF","ZZE_CLIENT","ZZE_LOJA","ZZE_NOMCLI","ZZE_PRODUT","ZZE_DESCPR","ZZE_PRECO","ZZE_ATIVO"}, .T., /*[ cQuery]*/, /*[bMontCols]*/, nOpc==3, aHeadCliente, aColsCliente, /*[ bAfterCols]*/, /*[ bBeforeCols]*/, /*[ bAfterHeader]*/, /*[ cAliasQry]*/, /*[ bCriaVar]*/, .F., {"ZZE_CLIENT","ZZE_LOJA","ZZE_NOMCLI","ZZE_PRODUT","ZZE_DESCPR","ZZE_PRECO","ZZE_ATIVO"} ))



aSizeAut	:= MsAdvSize(,.F.,400)
//AAdd( aObjects, { 0,    70, .T., .F. } )
//AAdd( aObjects, { 100, 100, .T., .T. } )

AAdd( aObjects, { 0,    70, .T., .F. } )
AAdd( aObjects, { 100, 100, .T., .T. } )

If lTabPreco
	AAdd( aObjects, { 0,    50, .T., .F. } )
	cObservacao:=""
	If !Empty(P0B->P0B_CODOBS)
		cObservacao:= Msmm(P0B->P0B_CODOBS, 1000,,,3 ,,, "P0B","P0B_CODOBS" ,, )
	EndIf
	
EndIf

aInfo := { aSizeAut[ 1 ], aSizeAut[ 2 ], aSizeAut[ 3 ], aSizeAut[ 4 ], 3, 3 }
aPosObj := MsObjSize( aInfo, aObjects )

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณCalcula o Size para os Foldersณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Aadd( aObjFld, {   1  ,  1, .T., .T. } )
aInfoFld := {1,1,aPosObj[2,4] - aPosObj[2,2] ,aPosObj[2,3] - aPosObj[2,1],3,3}
aPosFld := MsObjSize( aInfoFld, aObjFld )

DEFINE MSDIALOG oDlg TITLE OemtoAnsi("Tabela de Pre็o Promocional") From aSize[7],0 To aSize[6],aSize[5] of oMainWnd PIXEL
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณMonta a Enchoice superior com? os Dados da Cargaณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
ZZE->(DbGoto(nRecZZE))
Enchoice( "ZZE", nReg, nOpc, , , , aCpoCab, {aPosObj[1,1],aPosObj[1,2],aPosObj[1,3],aPosObj[1,4]},, 1, , ,"AllwaysTrue()", oDlg, .F.,  .T., .F., , .T., .F.)
oFolder := TFolder():New(aPosObj[2,1],aPosObj[2,2],aFolders,{'',''},oDlg,,,,.T.,.F.,aPosObj[2,4]-aPosObj[2,2],aPosObj[2,3]-aPosObj[2,1])
If INCLUI
	oFolder:lActive:=.F.
EndIf
nGd1 := 2
nGd2 := 2
nGd3 := aPosObj[2,3]-aPosObj[2,1]-15
nGd4 := aPosObj[2,4]-aPosObj[2,2]-4

//MsNewGetDados(): New ( [ nTop], [ nLeft], [ nBottom], [ nRight ], [ nStyle], [ cLinhaOk], [ cTudoOk], [ cIniCpos], [ aAlter], [ nFreeze], [ nMax], [ cFieldOk], [ cSuperDel], [ cDelOk], [ oWnd], [ aPartHeader], [ aParCols], [ uChange], [ cTela] ) --> Objeto
oGetPreco	:= MsNewGetDados():New(nGd1,nGd2,nGd3,nGd4,nOpcy,"U_PR707Line(oGetPreco:nAt,oGetPreco:aHeader,oGetPreco:aCols)","AllwaysTrue","+ZZE_ITEM",/*aCpoEnable*/,/*nFreeze*/,/*nMax*/,/*cFieldOk*/,/*cSuperDel*/,/*cDelOk*/ ,oFolder:aDialogs[1],aHeadPreco,aColsPreco)

If lTabPreco
	nGd1 := aPosObj[3,1]
	nGd2 := aPosObj[3,2]
	nGd3 := aPosObj[3,3]
	nGd4 := aPosObj[3,4]
	
	
	@nGd1,nGd2 Say "Observa็ใo"
	@nGd1,nGd2+50 Get cObservacao MEMO SIZE 300,50
	
	nButoCol:=nGd4*0.75
	
	oButton2	:= tButton():New(nGd3,nButoCol, "Aprovar"  , oDlg, {|| U_PR707Aprov('A',.F.,cObservacao),oDlg:End() }, 0040, 0015, , , , .T.)
	nButoCol+=60
	
	oButton3	:= tButton():New(nGd3, nButoCol, "Reprovar" , oDlg, {|| U_PR707Aprov('R',.F.,cObservacao),oDlg:End() }, 0040, 0015, , , , .T.)
	nButoCol+=60
	
	oButton4	:= tButton():New(nGd3, nButoCol, "Sair"  	, oDlg, bCancel, 0040, 0015, , , , .T.)
	
EndIf

ACTIVATE MSDIALOG oDlg ON INIT ( Iif(lTabPreco .And. cOpcao=="A",{|| .T. },EnchoiceBar(oDlg,bOk,bCancel,,aButtons)) )


If !lTabPreco
	If nOpc<>2 .And. lGravar
		Begin Transaction
		Processa( {|| PR707Grv(nOpc,aCpoCab,aHeadPreco,oGetPreco:aCols) } )
		End Transaction
	ElseIf __lSX8
		RollBackSX8()
	EndIf
EndIf


Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR707  บAutor  ณMicrosiga           บ Data ณ  10/04/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PR707Line(nLinha,aHeader,aCols)
Local aCposObrigat:= GdObrigat( aHeader )
Local aCposKey:={"ZZE_UF","ZZE_CLIENT","ZZE_LOJA","ZZE_PRODUT"}

n:=nLinha

If ! ( GdDeleted(n) .Or. GdFieldGet("ZZE_ATIVO")=="N" )
	If !GdCheckKey(aCposKey,4,aCposObrigat,,,nLinha) //Verifica Itens duplicados na getdados
		Return .F.
	EndIf
EndIf

Return .T.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR707  บAutor  ณMicrosiga           บ Data ณ  10/04/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PR707Grv(nOpc,aCpoCab,aHeadPreco,aColsPreco)
Local cFilZZE	:=xFilial("ZZE")
Local cChaveZZE	:=cFilZZE+M->ZZE_CODIGO
Local nInd


If nOpc==5 // Exclusao
	ZZE->(DbSetOrder(1))//ZZE_FILIAL+ZZE_CODIGO+ZZE_FLAG
	ZZE->(DbSeek(cChaveZZE))
	ZZE->( DbEval( {|| RecLock("ZZE",.F.),DbDelete(),MsUnLock()  },{|| ZZE_FILIAL+ZZE_CODIGO==cChaveZZE  },{|| .T. }  )    )
Else
	If nOpc==4//Alterar
		ZZE->(DbSetOrder(1))//ZZE_FILIAL+ZZE_CODIGO+ZZE_FLAG
		ZZE->(DbSeek(cChaveZZE+"0"))
	EndIf
	ZZE->(RecLock("ZZE",nOpc==3))
	For nInd:=1 To Len(aCpoCab)
		If (nPosCpo:=ZZE->(FieldPos(aCpoCab[nInd]) ))>0
			ZZE->( FieldPut(nPosCpo, M->&(aCpoCab[nInd]) ) )
		EndIf
	Next
	ZZE->ZZE_FILIAL:=cFilZZE
	ZZE->ZZE_FLAG	:="0"
	If nOpc==4//Alterar
		ZZE->ZZE_STATUS:="P"
	EndIf
	
	For nInd:=1 To Len(aColsPreco)
		R007GrvItens(aHeadPreco,aColsPreco,nInd,"1",cFilZZE,aCpoCab)
	Next
	
	ConfirmSX8()
EndIf

Return .T.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR707  บAutor  ณMicrosiga           บ Data ณ  10/05/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function R007GrvItens(aHeader,aCols,nInd,cFlag,cFilZZE,aCpoCab)
Local nPosRec		:=GdFieldPos("ZZE_REC_WT",aHeader)
Local nColuna
Local lTemRecno:=.F.
Local nYnd

If aCols[nInd,nPosRec]>0
	ZZE->( DbGoTo( aCols[nInd,nPosRec] ) )
	lTemRecno:=.T.
EndIf

If GdDeleted( nInd , aHeader , aCols )
	If lTemRecno
		ZZE->(RecLock("ZZE",.F.))
		ZZE->(dbDelete())
		ZZE->(MsUnLock())
	EndIf
Else
	ZZE->(RecLock("ZZE",!lTemRecno))
	For nYnd:=1 To Len(aHeader)
		nColuna:=ZZE->(FieldPos(aHeader[nYnd,2]))
		If nColuna>0
			ZZE->(FieldPut(nColuna,GdFieldGet(aHeader[nYnd,2],nInd,,aHeader,aCols)))
		EndIf
	Next
	
	For nInd:=1 To Len(aCpoCab)
		If (nPosCpo:=ZZE->(FieldPos(aCpoCab[nInd]) ))>0
			ZZE->( FieldPut(nPosCpo, M->&(aCpoCab[nInd]) ) )
		EndIf
	Next
	
	ZZE->ZZE_FILIAL	:=cFilZZE
	ZZE->ZZE_CODIGO	:=M->ZZE_CODIGO
	ZZE->ZZE_FLAG	:=cFlag
EndIf
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR707  บAutor  ณMicrosiga           บ Data ณ  10/05/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function PR707VAL(cCampo)
Local lRetorno	:=.T.
Local cCodCli	:=M->ZZE_CLIENT
Local cLoja		:=M->ZZE_LOJA
Default cCampo:=__ReadVar

If  oFolder:nOption==1
	aCols		:=oGetPreco:aCols
	aHeader	:=oGetPreco:aHeader
	n			:=oGetPreco:nAt
Else
	aCols		:=oGetCliente:aCols
	aHeader	:=oGetCliente:aHeader
	n			:=oGetCliente:nAt
Endif

If cCampo$"M->ZZE_CANAL"
	
	If !(oFolder:lActive:=ExistCpo("ACA",M->ZZE_CANAL))
		Return .F.
	EndIf
	
ElseIf cCampo$"M->ZZE_DTINI"
	If !Empty(M->ZZE_DTFIM) .And. M->ZZE_DTINI >M->ZZE_DTFIM
		MsgInfo(Trim(AvSx3("ZZE_DTINI ",5))+" nใo pode ser superior a "+Trim(AvSx3("ZZE_DTFIM",5)))
		Return .F.
	EndIf
ElseIf cCampo$"M->ZZE_DTFIM"
	If !Empty(M->ZZE_DTINI ) .And. M->ZZE_DTFIM<M->ZZE_DTINI
		MsgInfo(Trim(AvSx3("ZZE_DTFIM",5))+" nใo pode ser inferior a "+Trim(AvSx3("ZZE_DTINI ",5)))
		Return .F.
	EndIf
	
ElseIf cCampo$"M->ZZE_PRODUT"
	
	If !ExistCpo("SB1",M->ZZE_PRODUT)
		Return .F.
	EndIf
	
ElseIf cCampo$"M->ZZE_CLIENT*M->ZZE_LOJA"
	
	SA1->(DbSetOrder(1))
	If cCampo=="M->ZZE_CLIENT
		cLoja:=GdFieldGet("ZZE_LOJA")
	Else
		cCodCli:=GdFieldGet("ZZE_CLIENT")
	EndIf
	
	cChaveSA1:=xFilial("SA1")+cCodCli+IIf(!Empty(cLoja),cLoja,"")
	If !SA1->(DbSeek(cChaveSA1))
		ExistCpo("SA1",cChaveSA1)
		lRetorno:=.F.
	ElseIf M->ZZE_CANAL<>SA1->A1_YCANAL
		MsgInfo(AvSx3("ZZE_CANAL",5)+" "+SA1->A1_YCANAL+" do cliente "+AllTrim(SA1->A1_NOME)+" difere do "+AvSx3("ZZE_CANAL",5)+" "+M->ZZE_CANAL+" digitado.")
		lRetorno:=.F.
	ElseIf !Empty(cLoja) .And. SA1->A1_EST<>GdFieldGet("ZZE_UF")
		MsgInfo(AvSx3("A1_EST",5)+"["+SA1->A1_EST+"] do cliente "+AllTrim(SA1->A1_NOME)+" difere do "+AvSx3("ZZE_UF",5)+"["+GdFieldGet("ZZE_UF")+"] digitado.")
		lRetorno:=.F.
	Else
		GDFieldPut ( "ZZE_NOMCLI", SA1->A1_NOME)
	EndIf
	
	If cCampo$"M->ZZE_CLIENT" .And. !lRetorno
		GDFieldPut ( "ZZE_LOJA", CriaVar("ZZE_LOJA",.F.) )
	EndIf
	
ElseIf cCampo$"M->ZZE_UF"

	If !Empty(cLoja:=GdFieldGet("ZZE_LOJA")	)
		SA1->(DbSetOrder(1))
		cCodCli:=GdFieldGet("ZZE_CLIENT")
		SA1->(DbSeek(xFilial("SA1")+cCodCli+cLoja))
	EndIf
		
	If !Empty(cLoja) .And. AllTrim(M->ZZE_UF)<>"*" .And. SA1->A1_EST <>M->ZZE_UF
		MsgInfo(AvSx3("A1_EST",5)+"["+SA1->A1_EST+"] do cliente "+AllTrim(SA1->A1_NOME)+" difere do "+AvSx3("ZZE_UF",5)+"["+M->ZZE_UF+"] digitado.")
		lRetorno:=.F.
	ElseIf AllTrim(M->ZZE_UF)=="*"
		GDFieldPut ( "ZZE_DESCUF", "TODOS")
	ElseIf !Empty(M->ZZE_UF) .And. !ExistCpo("SX5","12"+M->ZZE_UF)
		lRetorno:=.F.
	Else
		GDFieldPut ( "ZZE_DESCUF",Iif(Empty(M->ZZE_UF),"",Tabela("12",M->ZZE_UF)))
	EndIf
	
EndIf

Return lRetorno

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR707  บAutor  ณMicrosiga           บ Data ณ  10/05/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PR707TOK()
Local lRetorno:=.T.

aCols		:=oGetPreco:aCols
aHeader	:=oGetPreco:aHeader

For nInd:=1 To Len(aCols)
	If !U_PR707Line(nInd,aHeader,aCols)
		Return .F.
	EndIf
Next
Return lRetorno
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR707  บAutor  ณMicrosiga           บ Data ณ  10/05/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PR707Ini()
Local nInd
Local cFilSA1	:=xFilial("SA1")
Local cFilSB1	:=xFilial("SB1")

Local nPosUF	:=GdFieldPos("ZZE_UF")
Local nPosDesUF:=GdFieldPos("ZZE_DESCUF")

Local nPosCli	:=GdFieldPos("ZZE_CLIENT")
Local nPosLoj	:=GdFieldPos("ZZE_LOJA")
Local nPosNome	:=GdFieldPos("ZZE_NOMCLI")

Local nPosProd		:=GdFieldPos("ZZE_PRODUT")
Local nPosDesPro	:=GdFieldPos("ZZE_DESCPR")



If INCLUI
	GDFieldPut ( "ZZE_ITEM", StrZero(1, AvSx3("ZZE_ITEM",3) ), 1)
Else
	For nInd:=1 To Len(aCols)
		aCols[nInd,nPosDesUF]:=IIf( AllTrim(aCols[nInd,nPosUF])=="*","TODOS", Tabela("12",aCols[nInd,nPosUF]))
		If !Empty(aCols[nInd,nPosCli])
			cChaveSA1:= cFilSA1+aCols[nInd,nPosCli]+IIf(  !Empty(aCols[nInd,nPosLoj]),aCols[nInd,nPosLoj],""  )
			aCols[nInd,nPosNome] :=Posicione("SA1",1,cChaveSA1,"A1_NOME")
		EndIf
		
		aCols[nInd,nPosDesPro]:=Posicione("SB1",1,cFilSB1+aCols[nInd,nPosProd],"B1_XDESC")
		
	Next
EndIf

Return .T.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR707  บAutor  ณMicrosiga           บ Data ณ  10/05/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PR707Envi()
Local lGerouP0B:=.F.
Local aAreaAtu:=GetArea()
Local aAreaZZE:=ZZE->(GetArea())
Local clAlias:=GetNextAlias()
Local cSql
Local cDesTab:="Tabela Promocional "+ZZE->ZZE_CODIGO+"-"+Trim(ZZE->ZZE_DESCRI) +" Canal "+ZZE->ZZE_CANAL+Space(1)+Trim( Posicione("ACA",1,xFilial("ACA")+ZZE->ZZE_CANAL,"ACA_DESCRI") )


If ZZE->ZZE_STATUS<>"P"
	MsgStop("Tabela Promocional com status ["+Trim(aStatus[Ascan(aStatus,{|a| a[2]==ZZE->ZZE_STATUS} ),3])+"]."+Chr(13)+Chr(10)+"Somente status ["+Trim(aStatus[Ascan(aStatus,{|a| a[2]=='P'} ),3])+"] poderแ ser enviado para Aprova็ใo.")
	Return
EndIf

If !MsgYesNo("Confirma para envio de aprova็ใo da "+cDesTab+"?")
	Return
EndIf

cSql := " SELECT "
cSql += " P09_ORDEM "
cSql += " ,P09_CODIGO "
cSql += " ,P09_NOME "
cSql += " ,P09_EMAIL "
cSql += " FROM " +RetSqlName("P09")+ " P09 "
cSql += " WHERE P09.P09_FILIAL = '"+xFilial("P09")+"'"
cSql += " AND P09.P09_TIPO = '4'"
cSql += " AND P09.P09_ATIVO = '1'"
cSql += " AND P09.P09_CANAL='"+ZZE->ZZE_CANAL+"'"
cSql += " AND P09.D_E_L_E_T_= ' '"
cSql += " ORDER BY P09_ORDEM "

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cSql),clAlias, .F., .F.)


(clAlias)->(dbGoTop())

If (clAlias)->(!Eof()) .and. (clAlias)->(!Bof())
	
	lGerouP0B:=PR707GrvP0B(clAlias,ZZE->(ZZE_CODIGO+ZZE_FLAG) )
	
	RestArea(aAreaZZE)
	If lGerouP0B
		ZZE->(RecLock("ZZE",.F.))
		ZZE->ZZE_STATUS:="E"
		ZZE->(MsUnLock())
		cMensagem:=cDesTab+" enviada para aprova็ใo."
	Else
		cMensagem:="Ocorreu um erro ao enviar para aprova็ใo a "+cDesTab+" Contate o Administrador do sistema."
	EndIf
Else
	cMensagem:="Nใo hแ al็ada de aprova็ใo para "+cDesTab+"."
EndIf
MsgInfo(cMensagem)


(clAlias)->(dbCloseArea())

RestArea(aAreaAtu)
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR707  บAutor  ณMicrosiga           บ Data ณ  10/05/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PR707GrvP0B(clAlias,cChaveZZE)
Local cUserAprov 	:= ""
Local cFirstNivel	:= ""
Local cMailDest		:= ""
Local cNomeAprov	:= ""
Local aAreaP09		:= P09->(GetArea())
Local llRet			:= .F.
Local aAreaOrig	:= ZZE->(GetArea())
Local cFilZZE		:= xFilial("ZZE")

P0B->(dbSetOrder(2))
(clAlias)->(dbGoTop())
If (clAlias)->(!Eof()) .AND. (clAlias)->(!Bof())
	cNumAlc := GetSxeNum("P0B","P0B_NUM")
EndIf


Do While (clAlias)->(!Eof())
	
	cUserAprov := Posicione("P09",1,xFilial("P09") + (clAlias)->P09_CODIGO,"P09_USER" )
	
	If Empty(cUserAprov) .Or. (P0B->(DbSeek(xFilial("P0B") + PadR("4",TamSx3("P0B_TIPO")[1]) + PadR(cNumAlc,TamSx3("P0B_NUM")[1])+ PadR( cUserAprov ,TamSx3("P0B_USER")[1]) ) ))
		(clAlias)->(dbSkip());Loop
	EndIf
	
	If Empty(cFirstNivel)
		cFirstNivel := Alltrim((clAlias)->P09_ORDEM)
	EndIf
	ZZE->(DbSetOrder(1))
	ZZE->(DbSeek(cFilZZE + cChaveZZE))
	
	P0B->(RecLock("P0B",.T.) )
	P0B->P0B_FILIAL	:= xFilial("P0B")
	P0B->P0B_NUM	:= cNumAlc
	P0B->P0B_TIPO  	:= "4"
	P0B->P0B_USER  	:= cUserAprov
	P0B->P0B_APROV 	:= (clAlias)->P09_CODIGO
	P0B->P0B_NIVEL 	:= (clAlias)->P09_ORDEM
	P0B->P0B_STATUS	:= IIF(Alltrim(cFirstNivel) == Alltrim((clAlias)->P09_ORDEM),"01", "") // Se for o primeiro nivel deixa aberto para aparecer no borwse do primeiro nivel. Senao fica em branco aguardando primeira aprova็ใo
	P0B->P0B_DTLIB 	:= CTOD("  /  /  ")
	P0B->P0B_EMISSA	:= MsDate()
	P0B->P0B_WF    	:= "1"
	P0B->P0B_USEORI	:= __cUserId
	P0B->P0B_TABORI	:= "ZZE"
	P0B->P0B_CHVIND	:= cChaveZZE
	P0B->P0B_PEDIDO   :=ZZE->ZZE_CODIGO
	P0B->P0B_CANAL		:=ZZE->ZZE_CANAL
	P0B->P0B_INDCHO	:= 1
	
	llRet := .T.
	
	P0B->(MsUnLock())
	
	If !Empty(P0B->P0B_STATUS)
		PR707ENVWF((clAlias)->P09_NOME,(clAlias)->P09_EMAIL)
	Else
		P0B->(ConfirmSx8())
	EndIf
	
	(clAlias)->(dbSkip())
	
EndDo

If llRet
	P0B->(ConfirmSx8())
Else
	P0B->(RollBackSX8())
EndIf

RestArea(aAreaP09)
RestArea(aAreaOrig)

Return llRet
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR707  บAutor  ณMicrosiga           บ Data ณ  10/05/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PR707WF()
Local cFiltro		:=" P0B_TIPO ='4' AND P0B_STATUS <> '  ' AND P0B_USER = '"+Alltrim(__cUserId)+"'"
Local aCores		:= {}
Local aAreaX3		:= SX3->(GetArea())


Private aRotina		:=  {  {"Pesquisar"		,"AxPesqui"			,0,1} ,;
{"Visualizar"						,"U_PR707WFA('V')"		,0,2} ,;
{"Analisar"							,"U_PR707WFA('A')"	,0,4} ,;
{"Observa็ใo"						,"U_PR707WFO()"		,0,4} ,;
{"Aprovar"							,"U_PR707A_R('A')"		,0,4} ,;
{"Reprovar"							,"U_PR707A_R('B')"		,0,4} ,;
{"Legenda"							,"U_PR707LEG('2')"		,0,2} }


Private cCadastro	:= "Aprova็ใo Tabela Pre็o"
Private cUserLog	:= Alltrim(__cUserId)
Private aFixes		:= {}


SX3->(dbSetOrder(2))

aCores := {	 {"P0B->P0B_STATUS == '01' "	,"BR_AMARELO"   };
,{"P0B->P0B_STATUS == '02' "	,"BR_LARANJA"	};
,{"P0B->P0B_STATUS == '03' "	,"BR_AZUL"		};
,{"P0B->P0B_STATUS == '04' "	,"BR_VERDE"		};
,{"P0B->P0B_STATUS == '05' "	,"BR_VERMELHO"	}}



dbSelectArea("P0B")
P0B->(dbSetOrder(1))


If SX3->(dbSeek( "P0B_PEDIDO" ))
	AADD(aFixes, {"Tabela Pre็o","P0B_PEDIDO"   })
EndIf

If SX3->(dbSeek( "ZZE_DESCRI" ))
	AADD(aFixes, {SX3->X3_TITULO, {|| TransForm( Posicione("ZZE",1,xFilial("ZZE")+P0B->P0B_PEDIDO ,"ZZE_DESCRI"  ),AvSx3("ZZE_DESCRI",6) )  }   })
EndIf

If SX3->(dbSeek( "P0B_STATUS" ))
	AADD(aFixes, {"Status"+Space(20), {|| P0B->P0B_STATUS+"-"+IIf(P0B->P0B_STATUS== '01',"Aguardando sua aprova็ใo", IIf(P0B->P0B_STATUS == '02',"Aguar. demais aprov. no mesmo nํvel", IIf(P0B->P0B_STATUS == '03',"Aguardando aprova็ใo nํvel superior", IIf(P0B->P0B_STATUS == '04',"Aprovado",IIf(P0B->P0B_STATUS == '05',"Reprovado",""))) ) )  }  })
EndIf

If SX3->(dbSeek( "P0B_CANAL" ))
	AADD(aFixes, {SX3->X3_TITULO,"P0B_CANAL" })
EndIf

If SX3->(dbSeek( "P0B_DCANAL" ))
	AADD(aFixes, {SX3->X3_TITULO,"P0B_DCANAL" })
EndIf

If SX3->(dbSeek( "P0B_EMISSA" ))
	AADD(aFixes, {"Inicio Aprov","P0B_EMISSA" })
EndIf

If SX3->(dbSeek( "P0B_USER" ))
	AADD(aFixes, {SX3->X3_TITULO,"P0B_USER"  })
EndIf

If SX3->(dbSeek( "P0B_NOMAPR" ))
	AADD(aFixes, {SX3->X3_TITULO,"P0B_NOMAPR"})
EndIf
If SX3->(dbSeek( "P0B_DTLIB" ))
	AADD(aFixes, {"Dt. Aprovacao","P0B_DTLIB" })
EndIf

If SX3->(dbSeek( "P0B_DTREPR" ))
	AADD(aFixes, {SX3->X3_TITULO,"P0B_DTREPR"  })
EndIf

mBrowse( 6, 1,22,75,'P0B',aFixes,,,,, aCores,,,,,,,,cFiltro)

SX3->(RestArea(aAreaX3))

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR707  บAutor  ณMicrosiga           บ Data ณ  10/05/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PR707WFA(cOpcao)

Local aAreaP0b 		:= P0B->(GetArea())
Local nRet			:= 2


If !P0B->P0B_USER == Alltrim(cUserLog)
	Aviso("NCPR707 - Linha "+StrZero( ProcLine() ,5 ),"S๓ permitido analise pelo aprovador "+UsrFullName(P0B->P0B_USER)+".",{"Ok"},3)
	Return
EndIf


If P0B->P0B_STATUS == '01'
	ZZE->(dbSetOrder(P0B->P0B_INDCHO))
	If ZZE->(dbSeek(xFilial("ZZE")+ P0B->P0B_CHVIND ))
		U_PR707Manut("ZZE",ZZE->(Recno()),2,cOpcao)
	EndIf
Else
	Aviso("NCPR707 - Linha "+StrZero( ProcLine() ,5 ),"S๓ permitido aprovar/reprovar caso esteja aguardando alguma a็ใo para seu usuแrio.",{"Ok"},3)
EndIf



RestArea(aAreaP0b)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR707  บAutor  ณMicrosiga           บ Data ณ  10/05/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function PR707Aprov(cChose,lShow,cObservacao)
Local cMemoObs	:= ""
Local llNextNivel 	:= .F.
Local llMesmoNivel	:= .F.
Local aAreaAux 		:= {}
Local cTipoAlc		:= P0B->P0B_TIPO
Local cNumDoc		:= P0B->P0B_NUM
Local cNivel		:= P0B->P0B_NIVEL
Local cTabOrig		:= P0B->P0B_TABORI
Local cCodUser		:= P0B->P0B_USEORI
Local cNomeUser      :=UsrFullName(P0B->P0B_USER)
Local lIncMemo		:= .F.
Local nRecno		:= P0B->(Recno())
Local alArea := P0B->(GetArea())


Default lShow:=.T.
Default cObservacao:=""

If P0B->P0B_STATUS<>'01'
	MsgStop(UsrFullName(P0B->P0B_USER)+"-Tabela Pre็o "+P0B->P0B_STATUS+"-"+IIf(P0B->P0B_STATUS== '01',"Aguardando sua aprova็ใo", IIf(P0B->P0B_STATUS == '02',"Aguar. demais aprov. no mesmo nํvel", IIf(P0B->P0B_STATUS == '03',"Aguardando aprova็ใo nํvel superior", IIf(P0B->P0B_STATUS == '04',"Aprovado",IIf(P0B->P0B_STATUS == '05',"Reprovado",""	 ))))))
	Return
EndIf

If lShow
	
	If !Empty(P0B->P0B_CODOBS)
		cMemoObs := Msmm(P0B->P0B_CODOBS, 1000,,,3 ,,, "P0B","P0B_CODOBS" ,, )
	EndIf
	
	If Aviso("NCGWF103 - 15",@cMemoObs,{"Sim","Nใo"},3,"Confirma "+IIf(cChose == "R","Reprova็ใo","Aprova็ใo")+" da Tabela de Pre็o "+P0B->P0B_PEDIDO,,,.T.) == 1
		lIncMemo := .T.
	Else
		lIncMemo := .F.
	EndIf
Else
	cMemoObs :=cObservacao
	lIncMemo := .T.
EndIf



If !lIncMemo
	P0B->(RestArea(alArea))
	Return
EndiF

If cChose == "R"  //Reprovado
	
	P0B->(DbSetOrder(1)) //	P0B_FILIAL+P0B_TIPO+P0B_NUM+P0B_NIVEL
	P0B->(dbSeek(xfilial("P0B") + cTipoAlc + cNumDoc))
	
	Do While !P0B->(EOF()) .And. cNumDoc== P0B->P0B_NUM
		
		P0B->(RecLock("P0B",.F.))
		P0B->P0B_STATUS := '05'
		P0B->P0B_DTREPR	:= MsDate()
		P0B->(MsUnLock())
		
		If lIncMemo .And. cCodUser == P0B->P0B_USEORI .And. cNivel == P0B->P0B_NIVEL
			If Empty(P0B->P0B_CODOBS)
				P0B->(MSMM(,,, cMemoObs ,1,,,"P0B","P0B_CODOBS","SYP"))
			Else
				MSMM(P0B->P0B_CODOBS,1000,,AllTrim(cMemoObs),1,,,"P0B","P0B_CODOBS")
			EndIf
		EndIf
		P0B->(dbSkip())
		
	EndDo
	
	
	P0B->(MsUnlock())
	P0B->(DbGoTo(nRecno))
	
	
	ZZE->(dbSetOrder(P0B->P0B_INDCHO))
	If ZZE->(dbSeek(xFilial("ZZE")+ P0B->P0B_CHVIND ))
		ZZE->(RecLock("ZZE",.F.))
		ZZE->ZZE_STATUS := "R"
		ZZE->(MsUnLock())
	EndIf
Else
	
	llMesmoNivel := ExstMemNiv(AllTrim(P0B->P0B_NUM),Alltrim(P0B->P0B_NIVEL))
	
	If llMesmoNivel // Agurada aprova็ใo mesmo nivel
		
		P0B->(RecLock("P0B",.F.))
		
		P0B->P0B_STATUS := '02'
		If lIncMemo .And. cCodUser == P0B->P0B_USEORI .And. cNivel == P0B->P0B_NIVEL
			If Empty(P0B->P0B_CODOBS)
				P0B->(MSMM(,,, cMemoObs ,1,,,"P0B","P0B_CODOBS","SYP"))
			Else
				MSMM(P0B->P0B_CODOBS,1000,,AllTrim(cMemoObs),1,,,"P0B","P0B_CODOBS")
			EndIf
		EndIf
		
		P0B->(MsUnLock())
		
	Else // Proximo Nivel
		
		llNextNivel := GetNextNivel(AllTrim(P0B->P0B_NUM),Alltrim(P0B->P0B_NIVEL))
		
		If llNextNivel
			
			aAreaAux := P0B->(GetArea())
			
			P0B->(RecLock("P0B",.F.))
			
			P0B->P0B_STATUS := '03'
			
			P0B->(MsUnLock())
			// Atualiza todos os status no mesmo nํvel
			P0B->(dbSetOrder(1))
			P0B->(dbGoTop())
			P0B->(dbSeek(xFilial("P0B")+cTipoAlc+cNumDoc+cNivel))
			
			While P0B->(!Eof()) .AND. cTipoAlc+cNumDoc+cNivel == P0B->(P0B_TIPO+P0B_NUM+P0B_NIVEL)
				
				P0B->(RecLock("P0B",.F.))
				P0B->P0B_STATUS := '03'
				
				If lIncMemo .And. cCodUser == P0B->P0B_USEORI .And. cNivel == P0B->P0B_NIVEL
					If Empty(P0B->P0B_CODOBS)
						P0B->(MSMM(,,, cMemoObs ,1,,,"P0B","P0B_CODOBS","SYP"))
					Else
						MSMM(P0B->P0B_CODOBS,1000,,AllTrim(cMemoObs),1,,,"P0B","P0B_CODOBS")
					EndIf
				EndIf
				P0B->(MsUnLock())
				P0B->(dbSkip())
				
			EndDo
			
			RestArea(aAreaAux)
			
			
		Else // Nใo tem mais nํveis
			
			aAreaAux := P0B->(GetArea())
			
			P0B->(dbGoTop())
			P0B->(dbSetOrder(1))
			
			If P0B->(dbSeek(xFilial("P0B")+ cTipoAlc +cNumDoc))
				
				While P0B->(!Eof()) .AND. cNumDoc == P0B->P0B_NUM
					
					P0B->(RecLock("P0B",.F.))
					
					P0B->P0B_STATUS := '04'
					P0B->P0B_DTLIB	:= dDataBase
					If lIncMemo .And. cCodUser == P0B->P0B_USEORI .And. cNivel == P0B->P0B_NIVEL
						If Empty(P0B->P0B_CODOBS)
							P0B->(MSMM(,,, cMemoObs ,1,,,"P0B","P0B_CODOBS","SYP"))
						Else
							MSMM(P0B->P0B_CODOBS,1000,,AllTrim(cMemoObs),1,,,"P0B","P0B_CODOBS")
						EndIf
					EndIf
					
					P0B->(MsUnLock())
					
					P0B->(dbSkip())
					
				EndDo
				
			EndIf
			
			RestArea(aAreaAux)
			
			P0B->(DbGoTo(nRecno))
			ZZE->(dbSetOrder(P0B->P0B_INDCHO))
			If ZZE->(dbSeek(xFilial("ZZE")+ P0B->P0B_CHVIND ))
				ZZE->(RecLock("ZZE",.F.))
				ZZE->ZZE_STATUS := "A"
				ZZE->(MsUnLock())
			EndIf
			
			
		EndIf
		
	EndIf
	If lShow
		MsgAlert("Tabela de Pre็o Aprovada", "Tabela")
	EndIf
EndIf

P0B->(RestArea(alArea))

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณExstMemNivบAutor  ณHermes		         บ Data ณ  15/12/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณVerifica se existe outro aprovador no mesmo nivel p/  atualiบฑฑ
ฑฑบ          ณzar a legenda da tela do usuแrio aprovador                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ExstMemNiv(cNumAlc,cNivel)

Local llRet 	:= .F.
Local cSql 		:= ""
Local cAlias	:= GetNextAlias()

//ErrorBlock( { |oErro| U_MySndError(oErro) } )

cSql	:= " SELECT "
cSql	+= " P0B_USER "
cSql	+= " FROM " +RetSqlName("P0B")+ " P0B "
cSql	+= " WHERE P0B.P0B_FILIAL = '"+xFilial("P0B")+"'"
cSql	+= " AND P0B.P0B_NUM = '"+cNumAlc+"'"
cSql	+= " AND P0B.P0B_NIVEL = '"+cNivel+"'"
cSql	+= " AND P0B.P0B_USER <> '"+Alltrim(cUserLog)+"'"
cSql	+= " AND P0B.P0B_STATUS = '01'"
cSql	+= " AND P0B.D_E_L_E_T_= ' '"

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cSql),cAlias, .F., .F.)

(cAlias)->(dbGoTop())

If (cAlias)->(!Eof()) .AND. (cAlias)->(!Bof())
	llRet := .T.
EndIf

(cAlias)->(dbCloseArea())

Return llRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGetNextNivelบAutor  ณHermes   	     บ Data ณ  15/12/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณVerifica se existe outro aprovador no nivel superior para   บฑฑ
ฑฑบ          ณatualizar a legenda da tela do usuแrio aprovador            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetNextNivel(cNumAlc,cNivel)

Local llRet 	:= .F.
Local cSql 		:= ""
Local cTabOrig	:= ""
Local _VERVPC	:= ""
Local _CodVPC	:= ""
Local cPreCampo	:= ""
Local cAlias	:= GetNextAlias()
Local aAreaP0B	:= P0B->(GetArea())

cSql	:= " SELECT "
cSql	+= " P0B_NUM "
cSql	+= " ,P0B_TIPO "
cSql	+= " ,P0B_USER "
cSql	+= " ,P0B_NIVEL "
cSql	+= " ,P0B_WF "
cSql	+= " FROM " +RetSqlName("P0B")+ " P0B "
cSql	+= " WHERE P0B.P0B_FILIAL = '"+xFilial("P0B")+"'"
cSql	+= " AND P0B.P0B_NUM = '"+cNumAlc+"'"
cSql	+= " AND P0B.P0B_NIVEL > '"+cNivel+"'" // Proximo Nivel
cSql	+= " AND P0B.D_E_L_E_T_= ' ' "
cSql	+= " ORDER BY P0B_NIVEL "

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cSql),cAlias, .F., .F.)

(cAlias)->(dbGoTop())

If (cAlias)->(!Eof()) .AND. (cAlias)->(!Bof())
	
	llRet := .T.
	
	//P0B->(dbSetOrder(1)) // P0B_FILIAL+P0B_TIPO+P0B_NUM+P0B_NIVEL
	P0B->(dbSetOrder(2)) //P0B_FILIAL+P0B_TIPO+P0B_NUM+P0B_USER
	
	cNextNivel := Alltrim((cAlias)->P0B_NIVEL)
	
	While (cAlias)->(!Eof())
		
		If Alltrim(cNextNivel) == Alltrim((cAlias)->P0B_NIVEL)
			If P0B->(dbSeek(xFilial("P0B")+ (cAlias)->(P0B_TIPO+P0B_NUM+P0B_USER )))
				
				If P0B->(RecLock("P0B",.F.))
					P0B->P0B_STATUS := '01'
					P0B->(MsUnLock())
				EndIf
				
				If (cAlias)->P0B_WF == "1"
					ZZE->(dbSetOrder(P0B->P0B_INDCHO))
					If ZZE->(dbSeek(xFilial("ZZE")+ P0B->P0B_CHVIND ))
						cMailDest := Posicione("P09",1,xFilial("P09")+ P0B->P0B_APROV,"P09_EMAIL" )
						cNomeAprov:= Posicione("P09",1,xFilial("P09")+ P0B->P0B_APROV,"P09_NOME")
						PR707ENVWF(cNomeAprov,cMailDest)
					EndIf
					
					
				EndIf
				
			EndIf
		Else
			Exit
		EndIf
		(cAlias)->(dbSkip())
		
	EndDo
	
EndIf

(cAlias)->(dbCloseArea())

RestArea(aAreaP0B)

Return llRet



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR707  บAutor  ณMicrosiga           บ Data ณ  10/05/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function PR707LEG(cParam)
Local aCor := {}


If cParam=="1"
	aAdd(aCor,{"BR_VERDE"	,"Aprovada" })
	aAdd(aCor,{"BR_VERMELHO"		,"Reprovada" })
	aAdd(aCor,{"BR_LARANJA"	,"Pendente Aprovacao"} )
	aAdd(aCor,{"BR_AMARELO"	,"Em Aprovacao"} )
	aAdd(aCor,{"BR_CINZA"		,"Encerrada"} )
Else
	aAdd(aCor,{"BR_AMARELO"	,"Aguardando sua aprova็ใo"   						}) 	// 01
	aAdd(aCor,{"BR_LARANJA"	,"Aguar. demais aprov. no mesmo nํvel" 				})	// 02
	aAdd(aCor,{"BR_AZUL"	,"Aguardando aprova็ใo nํvel superior"				}) 	// 03
	aAdd(aCor,{"BR_VERDE"	,"Aprovado"											}) 	// 04
	aAdd(aCor,{"BR_VERMELHO","Reprovado" 										})	// 05
EndIf


BrwLegenda(,"Status",aCor)


Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR707  บAutor  ณMicrosiga           บ Data ณ  10/05/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PR707ENVWF(cNomeAprov,cMailDest)
Local lReturn		:=.T.
Local cAssunto :="Tabela Promocional "+ZZE->ZZE_CODIGO+"-"+Trim(ZZE->ZZE_DESCRI) +" Canal "+ZZE->ZZE_CANAL+Space(1)+Trim( Posicione("ACA",1,xFilial("ACA")+ZZE->ZZE_CANAL,"ACA_DESCRI") )
Local cEndHtml  :=U_MyNewSX6(	"NCG_000022","","C","Diretorio do Html do Workflow","Diretorio do Html do Workflow","Diretorio do Html do Workflow Link  wflink.htm",.F.)
Local cNomeArq:=E_Create(,.F.)
Local oHtml
Local cErro

cEndHtml := cEndHtml+IIf(Right(cEndHtml,1) <> "\", "\","")+ "wflink_tab.htm"


If File(cEndHtml)
	
	/*oHtml	:= TWFHTML():New( cEndHtml )
	
	oHtml:ValByName( "nomeaprovador",		cNomeAprov )
	oHtml:ValByName( "Tabela",		cAssunto)
	
	oHtml:SaveFile( cNomeArq+".htm" )
	oHtml:Free()
	cBody :=WFLoadFile(cNomeArq+".htm" )*/ 
	
	cBody := ""
	cBody += '<html xmlns="www.w3.org/1999/xhtml"><head><meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" /><title>Libera็ใo de Verba</title>
	cBody += '</head><body><div id="principal" style="" >                    
	cBody += '<table width="95%" border="0" align="center" cellpadding="0" cellspacing="0" bordercolor="#FFFFFF" bordercolorlight="#006600" bordercolordark="#006600"><tr>
	cBody += '<td width="33%" height="39" align="left" valign="top"><img src="www.ncgames.com.br/public/img/logo/home-logo.png" width="315" height="104" alt="Logo Nc Games" /></td>
	cBody += '<td height="39%" valign="middle" style="font-family: Trebuchet MS, Arial, Helvetica, sans-serif; font-size: 30px; color: #999; text-transform: uppercase text-align: left;" >
	cBody += '<div align="right">WORKFLOW PROTHEUS NC GAMES</div></td></tr>
	cBody += '</table>
	cBody += '<table width="95%" border="0" align="center" bordercolor="#FFFFFF" bordercolorlight="#006600" bordercolordark="#006600">
	cBody += '<tr><td width="34%" align="left" valign="top"><p>&nbsp;</p><p>Sr(a). '+ cNomeAprov +' </p>
	cBody += '<p>Workflow referente a '+ cAssunto +' aguardando sua aprova&ccedil;&atilde;o.</p><p>&nbsp;</p></td></tr>
	cBody += '</table>
	cBody += '<table width="95%" border="0" align="center" id="tbrodape"><tr>
	cBody += '<td height="30" align="center" style=" font-family: Verdana, Geneva, sans-serif; font-size: 11px; color: #000; "> WORKFLOW PROTHEUS</td>
	cBody += '</tr></table></td></tr></table></div></body></html>

	
	cErro:=""
	PR707Mail(cAssunto, cBody, , cMailDest, , @cErro)
	Ferase(cNomeArq+".htm")
	
Else
	
	Aviso("NCPR707 - Linha "+StrZero( ProcLine() ,5 ),"Nใo foi localizado o modelo HTML Workflow Tabela Promocional. Solicite ao Dpto. de Tecnologia da Informa็ใo para verificar os modelos HTML do Workflow.",{"Ok"},3)
	
EndIf



Return lReturn
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGWF103  บAutor  ณMicrosiga           บ Data ณ  04/25/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PR707A_R(cTipo)

If !P0B->P0B_USER == Alltrim(cUserLog)
	Aviso("NCPR707 - Linha "+StrZero( ProcLine() ,5 ),"S๓ permitido analise pelo aprovador "+UsrFullName(P0B->P0B_USER)+".",{"Ok"},3)
	Return
EndIf
U_PR707Aprov(cTipo)
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR707  บAutor  ณMicrosiga           บ Data ณ  10/05/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function PR707WFO()
Local cMemoObs := ""

If !Empty(P0B->P0B_CODOBS)
	cMemoObs := Msmm(P0B->P0B_CODOBS, 1000,,,3 ,,, "P0B","P0B_CODOBS" ,, )
	Aviso("PR707WFO - 01",@cMemoObs,{"Ok"},3,"Observa็ใo",,,.F.)
Else
	MsgAlert("Nใo hแ observa็๕es para esta Tabela de Pre็o.")
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR707  บAutor  ณMicrosiga           บ Data ณ  10/05/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PR707EDIT(nOpc,lTabPreco,cOpcao)


If !INCLUI .And. nOpc<>2 .And. ZZE->ZZE_STATUS=="X"
	MsgStop("Tabela Promocional Encerrada em " +DTOC(ZZE->ZZE_DTFIM)+"."+Chr(13)+Chr(10)+"Manuten็ใo nใo permitida.."  )
	Return .F.
EndIf

If !lTabPreco .And. !INCLUI .And. nOpc<>2 .And. ZZE->ZZE_STATUS=="E"
	MsgStop("Tabela Promocional com status ["+Trim(aStatus[Ascan(aStatus,{|a| a[2]=='E'} ),3])+"] manuten็ใo nใo permitida.")
	Return .F.
EndIf

If ALTERA .And. ZZE->ZZE_STATUS=="A" .And. !MsgNoYes("Tabela Promocional jแ aprovada,ap๓s altera็ใo serแ necessแria uma nova aprova็ใo"+Chr(13)+Chr(10)+"Deseja continuar?" )
	Return .F.
EndIf

Return .T.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR707  บAutor  ณMicrosiga           บ Data ณ  10/05/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PR707Staus(cStatus)


If cStatus=="X"
	cSql := " Update " +RetSqlName("ZZE")
	cSql += " Set ZZE_STATUS='X'"
	cSql += " Where ZZE_FILIAL BETWEEN '  ' AND 'ZZ' "
	cSql += " And ZZE_DTFIM<'"+Dtos(MsDate())+"'"
	cSql += " AND D_E_L_E_T_ = ' '"
	TcSQLExec( cSql )
EndIf


Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR707  บAutor  ณMicrosiga           บ Data ณ  10/05/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PR707Mail(cAssunto, cMensagem, aAnexos, cEmailTo, cEmailCc, cErro)
Local lRetorno 	:= .T.
Local cServer   	:= GetNewPar("MV_RELSERV","")
Local cAccount		:= GetNewPar("MV_RELACNT","")
Local cPassword	:= GetNewPar("MV_RELAPSW","")
Local lMailAuth 	:= GetNewPar("MV_RELAUTH",.F.)


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
			cErro := "Erro na tentativa de autentica็ใo da conta " + cAccount + ". "
			lRetorno := .F.
		EndIf
		MailSmtpOff()
	Else
		cErro := "Erro na tentativa de conexใo com o servidor SMTP: " + cServer + " com a conta " + cAccount + ". "
		lRetorno := .F.
	EndIf
Else
	
	If Empty(cEmailTo)
		cErro := "ษ neessแrio fornecer o destinแtario para o e-mail. "
		lRetorno := .F.
		
	EndIf
	
	If Empty(cAssunto)
		
		cErro := "ษ neessแrio fornecer o assunto para o e-mail. "
		lRetorno := .F.
		
	EndIf
	
	If Empty(cMensagem)
		
		cErro := "ษ neessแrio fornecer o corpo do e-mail. "
		lRetorno := .F.
		
	EndIf
	
Endif
Return(lRetorno)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR707  บAutor  ณMicrosiga           บ Data ณ  10/05/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PR707Preco(cCliente,cLojaCli,cProduto,nPrcVen,lTemPromo)
Local aAreaAtu	:=GetArea()
Local aAreaSA1	:=SA1->(GetArea())
Local aAreaZZE	:=ZZE->(GetArea())
Local clAlias:=GetNextAlias()
Local cQuery	:=""


lTemPromo:=.F.

cCliente	:=Padr(cCliente,Len(SA1->A1_COD))
cLojaCli:=Padr(cLojaCli,Len(SA1->A1_LOJA))

SA1->(DbSetOrder(1))
If SA1->(DbSeek(xFilial("SA1")+cCliente+Trim(cLojaCli)  ))
	
	cQuery:=" Select ZZE_PRECO,ZZE_CLIENT,ZZE_LOJA,ZZE_UF"
	cQuery+=" From "+RetSqlName("ZZE")+" ZZE"
	cQuery+=" Where ZZE.ZZE_FILIAL='"+xFilial("ZZE")+"'"
	cQuery+=" And ZZE_CANAL='"+SA1->A1_YCANAL+"'"
	cQuery+=" And 	ZZE_PRODUT='"+cProduto+"'"
	cQuery+=" And 	ZZE_ATIVO='S'"
	cQuery+=" And 	ZZE_FLAG='1'"
	cQuery+=" And 	'"+Dtos(MsDate())+"' Between ZZE_DTINI And ZZE_DTFIM"
	cQuery+=" And ZZE.D_E_L_E_T_=' '"
	cQuery+=" And 	Exists ( Select 'X' From "+RetSqlName("ZZE")+" ZZECAB Where ZZECAB.ZZE_FILIAL='"+xFilial("ZZE")+"' And ZZECAB.ZZE_CANAL='"+SA1->A1_YCANAL+"' And ZZECAB.ZZE_STATUS='A' And  ZZECAB.ZZE_FLAG='0'"
	cQuery+="               And ZZECAB.ZZE_CODIGO=ZZE.ZZE_CODIGO)"
	cQuery+=" Order by ZZE_CLIENT,ZZE_LOJA DESC"

	DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),clAlias, .F., .F.)
	
	If ! (clAlias)->( Eof() .And. Bof() )
		nPrcVen:=(clAlias)->ZZE_PRECO
	EndIf	
	
	lCliente:=.F. //Verificar com o Cleverson, aqui deveria fazer a valida็ใo do cliente
	
	
	Do While (clAlias)->(!Eof())
		
		lTemPromo:=.T.
		
		If !lCliente .And. (clAlias)->ZZE_UF==SA1->A1_EST
			nPrcVen:=(clAlias)->ZZE_PRECO
		EndIf
		
		If (clAlias)->ZZE_CLIENT==cCliente
			nPrcVen:=(clAlias)->ZZE_PRECO
			
			lCliente:=.T.
			
			If  (clAlias)->ZZE_LOJA==cLojaCli
				nPrcVen:=(clAlias)->ZZE_PRECO
			EndIf
		EndIf
		
		(clAlias)->(DbSkip())
	EndDo
	
	If lTemPromo	
		PR707TabFator(@nPrcVen,SA1->A1_TABELA)
	EndIf	
	
	(clAlias)->(DbCloseArea())
	
EndIf

RestArea(aAreaSA1)
RestArea(aAreaZZE)
RestArea(aAreaAtu)

Return nPrcVen

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR707  บAutor  ณMicrosiga           บ Data ณ  10/08/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PR707TabFator(nPrcVen,cTabela)
Local aAreaAtu:=GetArea()
Local aAreaSZU:=SZU->(GetArea())

SZU->(DbSetOrder(1))
If SZU->(DbSeek(xFilial("SZU") + cTabela) )
	nPrcVen:=A410Arred(nPrcVen/SZU->ZU_FATOR,"C6_VALOR")
EndIf


RestArea(aAreaSZU)
RestArea(aAreaAtu)
Return
