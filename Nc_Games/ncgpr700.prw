#INCLUDE "PROTHEUS.CH"
#INCLUDE "APWIZARD.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR700   ºAutor  ³Microsiga           º Data ³  04/05/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Pedido Pai e Pedidos Filhos                                º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function NCGPR700()
Local oBrowse
Local aFields:={}
Private aRotina :=Menudef()
Private cMarca		:= GetMark()
Private lInverte := .F.
Private cUserLog	:= Alltrim(__cUserId)
Private cCadastro := "Pedido Pai"

oBrowse := FWMBrowse():New()
oBrowse:SetAlias('SC5')      
oBrowse:SetFilterDefault( "C5_XSTAPED=='00' .And. C5_YSTATUS$'01*06'" )
oBrowse:SetDescription('Pedidos de Venda Pai Aprovados')
oBrowse:Activate()


Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR700  ºAutor  ³Microsiga           º Data ³  05/31/13   º±±
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
Local aRotina := { }



AADD(aRotina, {"Pesquisar"	  		,"AxPesqui"			,0,1} )
AADD(aRotina, {"Visualizar"	  		,"A410Visual"		,0,2})
AADD(aRotina, {"Aprovar/Reprovar Pedidos Filhos"	    ," Processa( {|| U_PR700LibPv('APROVAR') } )" ,0,4} )
aadd(aRotina, {'Analise Margem Liquida','U_PR107Margem' ,0,2,0 ,NIL}) 

Return aRotina




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR700  ºAutor  ³Microsiga           º Data ³  05/31/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function  PR700LibPv(cAcao)
Local aAreaAtu	:=GetArea()
Local oDlg
Local lGravar	:=.F.
Local aSize   	:= MsAdvSize()
Local aObjects	:= {}
Local aInfo		:= {}
Local aPosObj	:= {}
Local aPosFld	:= {}
Local aObjFld	:= {}
Local bOk		:={|| lGravar:=.T.,oDlg:End() }
Local bCancel	:={|| lGravar:=.F.,oDlg:End() }
Local aButtons	:={}
Local aFoldCabec	:={OemToAnsi('Pedido Pai')		,OemToAnsi('Itens Pedido Pai')}
Local aFoldItens	:={OemToAnsi('Pedido(s) Filho')	,OemToAnsi('Itens Pedido(s) Filho')}
Local nOpcy		:=0
Local oFoldCabec
Local oFoldItens
Local cNumPV	:=SC5->C5_NUM
Local aHeadSC5:={}
Local aColsSC5:={}
Local aHeadSC6:={}
Local aColsSC6:={}
Local aCpoBrw	:={}
Local aCpoTrb	:={}
Local aStructSC5:=SC5->(DbStruct())
Local aStructSC6:=SC6->(DbStruct())
Local cAliasQry	:=GetNextAlias()
Local cIndexTrb	:=E_Create(,.F.)
Local aDadosAprov:={}


Private oAprovar       := LoadBitmap( GetResources(), 'BR_VERDE' )
Private oReprovar      := LoadBitmap( GetResources(), 'BR_VERMELHO' )

Private oDesmarcar  := LoadBitmap( GetResources(), 'LBNO' )
Private oJaAprovado := LoadBitmap( GetResources(), "BR_AZUL" )

           

//***********************************Pedido Pai
RegToMemory("SC5",.F.)
//Pedido de Venda
SC5->(FillGetDados ( 2, "SC5",1, xFilial("SC5")+cNumPV, {|| C5_FILIAL+C5_NUM},  /*uSeekFor*/, /*aNoFields*/, /*{"C5_NUM","C5_NOMCLI","C5_YSTATUS"}*/, .F., /*[ cQuery]*/, /*[bMontCols]*/, .F., aHeadSC5, aColsSC5, /*[ bAfterCols]*/, /*[ bBeforeCols]*/, /*[ bAfterHeader]*/, /*[ cAliasQry]*/, /*[ bCriaVar]*/, .T., /*{"C5_NUM","C5_NOMCLI","C5_YSTATUS"}*/ ))

SC6->(DbSetOrder(1))
SC6->(DbSeek(xFilial("SC6") +cNumPV))
//Itens Pedido Venda
SC6->(FillGetDados ( 2, "SC6",1, xFilial("SC6")+cNumPV, {|| C6_FILIAL+C6_NUM},  /*uSeekFor*/, /*aNoFields*/, /*{}*/, .F., /*[ cQuery]*/, /*[bMontCols]*/, .F., aHeadSC6, aColsSC6, /*[ bAfterCols]*/, /*[ bBeforeCols]*/, /*[ bAfterHeader]*/, /*[ cAliasQry]*/, /*[ bCriaVar]*/, .T., /*{}*/ ))

//***********************************Pedido Filhos

AADD(aStructSC5,{"OK"	 ,"C",2,0})
AADD(aStructSC5,{"ORDERNA","C",2,0})

AADD(aStructSC5,{"P0B_STATUS",AvSX3("P0B_STATUS",2),AvSX3("P0B_STATUS",3),AvSX3("P0B_STATUS",4)})
AADD(aStructSC5,{"P0B_USER",AvSX3("P0B_USER",2),AvSX3("P0B_USER",3),AvSX3("P0B_USER",4)})
AADD(aStructSC5,{"STATUSPV","C",20,0})
AADD(aStructSC5,{"NOMEUSER","C",20,0})
AADD(aStructSC5,{"RECP0B"  ,"N",15,0})
                                  
If Select("WORK")>0
	WORK->(DbCloseArea())
EndIf	
cNomeWork:=E_CriaTrab(,aStructSC5,"WORK")
IndRegua("Work",cNomeWork+OrdBagExt(),"ORDERNA", , , ,.F. )

If Select("TRB")>0
	TRB->(DbCloseArea())
EndIf	

cNomeTrb :=E_CriaTrab(,aStructSC6,"TRB")
IndRegua("Trb",cNomeTrb+OrdBagExt(),"C6_NUM+C6_ITEM", , , ,.F. )

cQuery:=" Select SC5.R_E_C_N_O_ RecSC5 From "+RetSqlName("SC5")+" SC5 "
cQuery+=" Where SC5.C5_FILIAL='"+xFilial("SC5")+"'"
cQuery+=" And SC5.C5_YPEDPAI='"+SC5->C5_NUM+"'"
cQuery+=" And SC5.D_E_L_E_T_=' '"
cQuery+=" Order By SC5.C5_NUM"

//If cAcao=="ENVIAR"
//	cQuery+=" And SC5.C5_YSATUS='02'"
//EndIf

DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasQry, .F., .F.)

SC6->(DbSetOrder(1))
Do While (cAliasQry)->(!Eof())

	SC5->( DbGoTo( (cAliasQry)->RecSC5 )  )
	Work->(DbAppend())
	AvReplace("SC5","Work")
	                 
	cOrdena:="00"	
	
	If SC5->C5_YSTATUS$"01*06"
		Work->OK:="AP"
		cOrdena:="98"
	ElseIf SC5->C5_YSTATUS$"07"
		Work->OK:="RE"
		cOrdena:="99"
	EndIf
	
	Work->ORDERNA:=cOrdena
	
	If !SC5->C5_YSTATUS=="01"
		aDadosAprov:=U_PR700LastApr(SC5->C5_NUM)
		
		
		//aDadosRet:={P0B->P0B_STATUS,"Aguardando Aprovação",P0B->P0B_USER,UsrFullName(P0B->P0B_USER)}
		
		Work->P0B_STATUS:=aDadosAprov[1]
		Work->STATUSPV	:=aDadosAprov[2]
		Work->P0B_USER	:=aDadosAprov[3]
		Work->NOMEUSER	:=aDadosAprov[4]
		Work->RECP0B    :=aDadosAprov[5]
	EndIf
	
	SC6->(DbSeek(xFilial("SC6")+SC5->C5_NUM  ))
	Do While SC6->( !Eof() .And.  C6_FILIAL+C6_NUM)==xFilial("SC6")+SC5->C5_NUM
		Trb->(DbAppend())
		AvReplace("SC6","Trb")
		SC6->(DbSkip())
	EndDo
	(cAliasQry)->(DbSkip())
EndDo


(cAliasQry)->(DbCloseArea())
aAdd( aCpoBrw, { "OK",		,    " ",					" " } )
aAdd( aCpoBrw, { "C5_NUM"		,	,AvSx3("C5_NUM",5)   ,		AvSx3("C5_NUM",6) } )
aAdd( aCpoBrw, { "C5_YAPROV" 	,	,AvSx3("C5_YAPROV",5),		AvSx3("C5_YAPROV",6) } )
aAdd( aCpoBrw, { "C5_YSTATUS" 	,	,AvSx3("C5_YSTATUS",5),		AvSx3("C5_YSTATUS",6) } )
aAdd( aCpoBrw, { "C5_YLUCRBR"	,	,AvSx3("C5_YLUCRBR",5),		AvSx3("C5_YLUCRBR",6) } )
aAdd( aCpoBrw, { "C5_YPERRBR"	,	,AvSx3("C5_YPERRBR",5),		AvSx3("C5_YPERRBR",6) } )
aAdd( aCpoBrw, { "C5_YTOTLIQ"	,	,AvSx3("C5_YTOTLIQ",5),		AvSx3("C5_YTOTLIQ",6) } )
aAdd( aCpoBrw, { "C5_YPERLIQ"	,	,AvSx3("C5_YPERLIQ",5),		AvSx3("C5_YPERLIQ",6) } )
aAdd( aCpoBrw, { "P0B_USER"		,	,AvSx3("P0B_USER",5),		AvSx3("P0B_USER",6)} )
aAdd( aCpoBrw, { "NOMEUSER"	,	,"Nome Aprovador",			"@!"} )
aAdd( aCpoBrw, { "STATUSPV"	,	,"Status Liberacao",		"@!"} )


aAdd( aCpoBrw, { "C5_FILIAL"	,	,AvSx3("C5_FILIAL",5),		AvSx3("C5_FILIAL",6) } )

//   aadd(aheader,{alltrim(sx3->(x3titulo())),sx3->x3_campo,sx3->x3_picture,sx3->x3_tamanho,sx3->x3_decimal, sx3->x3_valid,sx3->x3_usado,sx3->x3_tipo,sx3->x3_arquivo,sx3->x3_context})
For nInd:=1 To Len(aHeadSC6)
	If SC6->(FieldPos( aHeadSC6[nInd,2] )  ) >0
		aAdd( aCpoTrb, { aHeadSC6[nInd,2]		,	,aHeadSC6[nInd,1]   ,		aHeadSC6[nInd,3] } )
	EndIf
Next


aSizeAut	:= MsAdvSize(,.F.,400)
AAdd( aObjects, { 0,   90, .T., .T. } )
AAdd( aObjects, { 100, 100, .T., .T. } )

aInfo := { aSizeAut[ 1 ], aSizeAut[ 2 ], aSizeAut[ 3 ], aSizeAut[ 4 ], 3, 3 }
aPosObj := MsObjSize( aInfo, aObjects )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Calcula o Size para os Folders³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Aadd( aObjFld, {   1  ,  1, .T., .T. } )
aInfoFld := {1,1,aPosObj[2,4] - aPosObj[2,2] ,aPosObj[2,3] - aPosObj[2,1],3,3}
aPosFld := MsObjSize( aInfoFld, aObjFld )


aadd(aButtons,{"BUDGET",{||   SC5->(DbSetOrder(1)),SC5->(DbSeek(xFilial()+GdFieldGet("C5_NUM",oGetSC5:nAt,,aHeadSC5,aColsSC5))),U_PR107Margem() },"Analise Margem Pai", "Analise Margem Pai" })

If Trb->(RecCount())>0
	aadd(aButtons,{"BUDGET",{|| SC5->(DbSetOrder(1)),SC5->(DbSeek(xFilial()+Work->C5_NUM )),U_PR107Margem() }, "Analise Margem Filho", "Analise Margem Filho" })
EndIf	
                                                       
                                                                                          



DEFINE MSDIALOG oDlg TITLE OemtoAnsi("Pedido de Venda Pai x Filhos") From aSize[7],0 To aSize[6],aSize[5] of oMainWnd PIXEL
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Monta a Enchoice superior com? os Dados da Carga³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

oFoldCabec := TFolder():New(aPosObj[1,1],aPosObj[1,2],aFoldCabec,{'','','','',''},oDlg,,,,.T.,.F.,aPosObj[1,4]-aPosObj[1,2],aPosObj[1,3]-aPosObj[1,1])
nGd1 := 2
nGd2 := 2
nGd3 := aPosObj[1,3]-aPosObj[1,1]-15
nGd4 := aPosObj[1,4]-aPosObj[1,2]-4

//MsNewGetDados(): New ( [ nTop], [ nLeft], [ nBottom], [ nRight ], [ nStyle], [ cLinhaOk], [ cTudOk], [ cIniCpos], [ aAlter], [ nFreeze], [ nMax], [ cFieldOk], [ cSuperDel], [ cDelOk], [ oWnd], [ aPartHeader], [ aParCols], [ uChange], [ cTela] ) --> Objeto

oGetSC5 := MsNewGetDados():New(nGd1,nGd2,nGd3,nGd4,nOpcy,"AllwaysTrue","AllwaysTrue",/*'+ITEM'*/,/*aCpoEnable*/,/*nFreeze*/,/*nMax*/,/*cFieldOk*/,/*cSuperDel*/,/*cDelOk*/ ,oFoldCabec:aDialogs[1],aHeadSC5,aColsSC5)
oGetSC6 := MsNewGetDados():New(nGd1,nGd2,nGd3,nGd4,nOpcy,"AllwaysTrue","AllwaysTrue",/*'+ITEM'*/,/*aCpoEnable*/,/*nFreeze*/,/*nMax*/,/*cFieldOk*/,/*cSuperDel*/,/*cDelOk*/ ,oFoldCabec:aDialogs[2],aHeadSC6,aColsSC6)

oFoldItens := TFolder():New(aPosObj[2,1],aPosObj[2,2],aFoldItens,{'','','','',''},oDlg,,,,.T.,.F.,aPosObj[2,4]-aPosObj[2,2],aPosObj[2,3]-aPosObj[2,1])

nGd3 := aPosObj[2,3]-aPosObj[2,1]-15
nGd4 := aPosObj[2,4]-aPosObj[2,2]-4

//MsSelect(): New ( < cAlias>, [ cCampo], [ cCpo], [ aCampos], [ lInv], [ cMar], < aCord>, [cTopFun], [ cBotFun], < oWnd>, [ uPar11], [ aColors] ) --> oSelf
//(cAlias,cCampo,cCpo,aCampos,lInv,cMar,aCord,cTopFun,cBotFun,oWnd,aIdxCol,aColors)
Work->(DbGoTop())
oMarkSC5 :=MsSelect():New("WORK","OK","  ",aCpoBrw,@lInverte,@cMarca,{nGd1,nGd2,nGd3,nGd4} ,/*cTopFun*/,/*cBotFun*/ ,oFoldItens:aDialogs[1])

oMarkSC5:oBrowse:aColumns[1]:bData:={ ||  u_PR700RetMark(cAcao) }
oMarkSC5:bAval:={||  U_PR700GET(cAcao), oMarkSC5:oBrowse:Refresh() }
oMarkSC5:oBrowse:bChange:={|| oMarkSC6:oBrowse:SetFilter("C6_NUM",Work->C5_NUM),oMarkSC6:oBrowse:Default(),oMarkSC6:oBrowse:Refresh()}

oMarkSC6 :=MsSelect():New("TRB","","",aCpoTrb,.F.,,{nGd1,nGd2,nGd3,nGd4} ,/*cTopFun*/,/*cBotFun*/ ,oFoldItens:aDialogs[2])

ACTIVATE MSDIALOG oDlg ON INIT ( EnchoiceBar(oDlg,bOk,bCancel,,aButtons) )

If lGravar
	Processa( {|| PR700Gravar()} )
EndIf


Work->(E_EraseArq(cNomeWork))
Trb->(E_EraseArq(cNomeTrb))
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR700  ºAutor  ³Microsiga           º Data ³  04/05/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PR700VINC(cParam) //cParam= V Vincluar  ou D Desnvincular
Processa( {|| PR700Tela(cParam) } )

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR700  ºAutor  ³Microsiga           º Data ³  04/05/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function PR700Tela(cParam)
Local aAreaAtu	:=GetArea()
Local oDlg
Local lGravar	:=.F.
Local aSize   	:= MsAdvSize()
Local aObjects	:= {}
Local aInfo		:= {}
Local aPosObj	:= {}
Local aPosFld	:= {}
Local aObjFld	:= {}
Local bOk		:={|| Iif(Obrigatorio(aGets,aTela) .And. U_R007TOK(),(lGravar:=.T.,oDlg:End()),) }
Local bCancel	:={|| lGravar:=.F.,oDlg:End() }
Local aButtons	:={}
Local aFoldCabec	:={OemToAnsi('Pedido Pai'),OemToAnsi('Itens Pedido Pai')}
Local aFoldItens	:={OemToAnsi('Pedido EDI'),OemToAnsi('Itens Pedido EDI')}
Local nOpcy		:=0
Local oFoldCabec
Local oFoldItens


Local oGetSC5
Local aHeadSC5:={}
Local aColsSC5:={}

Local oGetSC6
Local aHeadSC6:={}
Local aColsSC6:={}

Local oGetZAE
Local aHeadZAE:={}
Local aColsZAE:={}



//PutSx1(cGrupo, cOrdem,cPergunt, cPerSpa ,cPerEng, cVar, cTipo, nTamanho, nDecimal, nPresel, cGSC, cValid, cF3, cGrpSxg, cPyme, cVar01, cDef01, cDefSpa1, cDefEng1, cCnt01, cDef02, cDefSpa2, cDefEng2, cDef03, cDefSpa3, cDefEng3, cDef04, cDefSpa4, cDefEng4, cDef05, cDefSpa5, cDefEng5, aHelpPor, aHelpEng, aHelpSpa, cHelp)
If cParam=="V"
	
	cPerg:="PR700VINC "
	PutSX1(cPerg, "01", "Cliente "  , "", "", "mv_ch1", "C", 6, 0, 0, "G", "ExistCpo('SA1',mv_par01)", "CLI", "", "", "mv_par01", "", "", "", "", "", "", "", "","", "", "", "", "", "", "","",,,, )
	PutSX1(cPerg, "02", "Loja"      , "", "", "mv_ch2", "C", 2, 0, 0, "G", ""                        , ""   , "", "", "mv_par02", "", "", "", "", "", "", "", "","", "", "", "", "", "", "","",,,, )
	PutSX1(cPerg, "03", "Pedido Pai", "", "", "mv_ch3", "C", 6, 0, 0, "G", "ExistCpo('SC5',mv_par03) .And. U_PR700VPRG('PVPAI')", "", "", "", "mv_par03", "", "", "", "", "", "", "", "","", "", "", "", "", "", "","",,,, )
	
	If !Pergunte(cPerg)
		Return
	EndIf
	
	//FillGetDados( nOpcx, cAlias, nOrder, cSeekKey, bSeekWhile, uSeekFor, aNoFields, aYesFields, lOnlyYes, cQuery, bMontCols,lEmpty, aHeaderAux, aColsAux, bAfterCols, bBeforeCols, bAfterHeader, cAliasQry, bCriaVar, lUserFields, aYesUsado )
	
	SC5->(DbSetOrder(1))
	SC5->(DbSeek(xFilial("SC5") +mv_par03))
	RegToMemory("SC5",.F.)
	//Pedido de Venda
	SC5->(FillGetDados ( 2, "SC5",1, xFilial("SC5")+mv_par03, {|| C5_FILIAL+C5_NUM},  /*uSeekFor*/, /*aNoFields*/, /*{"C5_NUM","C5_NOMCLI","C5_YSTATUS"}*/, .F., /*[ cQuery]*/, /*[bMontCols]*/, .F., aHeadSC5, aColsSC5, /*[ bAfterCols]*/, /*[ bBeforeCols]*/, /*[ bAfterHeader]*/, /*[ cAliasQry]*/, /*[ bCriaVar]*/, .T., /*{"C5_NUM","C5_NOMCLI","C5_YSTATUS"}*/ ))
	
	SC6->(DbSetOrder(1))
	SC6->(DbSeek(xFilial("SC6") +mv_par03))
	//Itens Pedido Venda
	SC6->(FillGetDados ( 2, "SC6",1, xFilial("SC6")+mv_par03, {|| C6_FILIAL+C6_NUM},  /*uSeekFor*/, /*aNoFields*/, /*{}*/, .F., /*[ cQuery]*/, /*[bMontCols]*/, .F., aHeadSC6, aColsSC6, /*[ bAfterCols]*/, /*[ bBeforeCols]*/, /*[ bAfterHeader]*/, /*[ cAliasQry]*/, /*[ bCriaVar]*/, .T., /*{}*/ ))
	
	
	ZAE->(FillGetDados ( 2, "ZAE",1, , xFilial("ZAE"),  /*uSeekFor*/, /*aNoFields*/, /*{}*/, .F., /*cQuery*/, /*[bMontCols]*/, .F., aHeadZAE, aColsZAE, /*[ bAfterCols]*/, /*[ bBeforeCols]*/, /*[ bAfterHeader]*/, /*[ cAliasQry]*/, /*[ bCriaVar]*/, .T., /*{}*/ ))
	
	
	aSizeAut	:= MsAdvSize(,.F.,400)
	AAdd( aObjects, { 0,   90, .T., .T. } )
	AAdd( aObjects, { 100, 100, .T., .T. } )
	
	aInfo := { aSizeAut[ 1 ], aSizeAut[ 2 ], aSizeAut[ 3 ], aSizeAut[ 4 ], 3, 3 }
	aPosObj := MsObjSize( aInfo, aObjects )
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Calcula o Size para os Folders³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Aadd( aObjFld, {   1  ,  1, .T., .T. } )
	aInfoFld := {1,1,aPosObj[2,4] - aPosObj[2,2] ,aPosObj[2,3] - aPosObj[2,1],3,3}
	aPosFld := MsObjSize( aInfoFld, aObjFld )
	
	
	DEFINE MSDIALOG oDlg TITLE OemtoAnsi("Vinculo Pedido de Venda") From aSize[7],0 To aSize[6],aSize[5] of oMainWnd PIXEL
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Monta a Enchoice superior com? os Dados da Carga³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	oFoldCabec := TFolder():New(aPosObj[1,1],aPosObj[1,2],aFoldCabec,{'','','','',''},oDlg,,,,.T.,.F.,aPosObj[1,4]-aPosObj[1,2],aPosObj[1,3]-aPosObj[1,1])
	nGd1 := 2
	nGd2 := 2
	nGd3 := aPosObj[1,3]-aPosObj[1,1]-15
	nGd4 := aPosObj[1,4]-aPosObj[1,2]-4
	
	//MsNewGetDados(): New ( [ nTop], [ nLeft], [ nBottom], [ nRight ], [ nStyle], [ cLinhaOk], [ cTudoOk], [ cIniCpos], [ aAlter], [ nFreeze], [ nMax], [ cFieldOk], [ cSuperDel], [ cDelOk], [ oWnd], [ aPartHeader], [ aParCols], [ uChange], [ cTela] ) --> Objeto
	
	oGetSC5	:= MsNewGetDados():New(nGd1,nGd2,nGd3,nGd4,nOpcy,"AllwaysTrue","AllwaysTrue",/*'+ITEM'*/,/*aCpoEnable*/,/*nFreeze*/,/*nMax*/,/*cFieldOk*/,/*cSuperDel*/,/*cDelOk*/ ,oFoldCabec:aDialogs[1],aHeadSC5,aColsSC5)
	oGetSC6 := MsNewGetDados():New(nGd1,nGd2,nGd3,nGd4,nOpcy,"AllwaysTrue","AllwaysTrue",/*'+ITEM'*/,/*aCpoEnable*/,/*nFreeze*/,/*nMax*/,/*cFieldOk*/,/*cSuperDel*/,/*cDelOk*/ ,oFoldCabec:aDialogs[2],aHeadSC6,aColsSC6)
	
	oFoldItens := TFolder():New(aPosObj[2,1],aPosObj[2,2],aFoldCabec,{'','','','',''},oDlg,,,,.T.,.F.,aPosObj[2,4]-aPosObj[2,2],aPosObj[2,3]-aPosObj[2,1])
	
	oGetZAE	:= MsNewGetDados():New(nGd1,nGd2,nGd3,nGd4,nOpcy,"AllwaysTrue","AllwaysTrue",/*'+ITEM'*/,/*aCpoEnable*/,/*nFreeze*/,/*nMax*/,/*cFieldOk*/,/*cSuperDel*/,/*cDelOk*/ ,oFoldItens:aDialogs[1],aHeadZAE,aColsZAE)
	oGetSCy := MsNewGetDados():New(nGd1,nGd2,nGd3,nGd4,nOpcy,"AllwaysTrue","AllwaysTrue",/*'+ITEM'*/,/*aCpoEnable*/,/*nFreeze*/,/*nMax*/,/*cFieldOk*/,/*cSuperDel*/,/*cDelOk*/ ,oFoldItens:aDialogs[2],aHeadSC6,aColsSC6)
	
	
	
	ACTIVATE MSDIALOG oDlg ON INIT ( EnchoiceBar(oDlg,bOk,bCancel,,aButtons) )
	
	If lGravar
		Begin Transaction
		//Processa( {|| FINR007Grv(nOpc,aCpoCab,aHeadBanco,oGetBanco:aCols,aHeadCarteira,oGetCarteira:aCols,aHeadCanal,oGetCanal:aCols,aHeadCliente,oGetCliente:aCols) } )
		End Transaction
	ElseIf __lSX8
		RollBackSX8()
	EndIf
	
ElseIf cParam=="D"
	//PutSx1(cGrupo, cOrdem,cPergunt, cPerSpa ,cPerEng, cVar, cTipo, nTamanho, nDecimal, nPresel, cGSC, cValid, cF3, cGrpSxg, cPyme, cVar01, cDef01, cDefSpa1, cDefEng1, cCnt01, cDef02, cDefSpa2, cDefEng2, cDef03, cDefSpa3, cDefEng3, cDef04, cDefSpa4, cDefEng4, cDef05, cDefSpa5, cDefEng5, aHelpPor, aHelpEng, aHelpSpa, cHelp)
	cPerg:="PR700DVINC"
	PutSX1(cPerg, "01", "Do Pedido Pai ", "", "", "mv_ch1", "C", 6, 0, 0, "G", "", "", "", "", "mv_par01", "", "", "", "", "", "", "", "","", "", "", "", "", "", "","",,,, )
	If !Pergunte(cPerg)
		Return
	EndIf
EndIF



RestArea(aAreaAtu)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR700  ºAutor  ³Microsiga           º Data ³  04/05/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PR700VPRG(cParam)
Local lRetorno:=.T.
Local aAreaAtu:=GetArea()


If cParam=='PVPAI'
	SC5->(DbSetOrder(1))
	SC5->(DbSeek(xFilial("SC5") +mv_par03))
	
	If  SC5->C5_XSTAPED<>"00"
		MsgStop("Pedido "+SC5->C5_NUM+" não é uma proposta(Pedido Pai).")
		Return .F.
	EndIf
	
	If SC5->C5_YSTATUS<>"06"
		MsgStop("Pedido "+SC5->C5_NUM+" não está aprovado(Status"+SC5->C5_YSTATUS+")")
		Return .F.
	EndIf
	
	If SC5->C5_CLIENTE<>mv_par01
		MsgStop("Cliente "+SC5->C5_CLIENTE+" da Proposta "+SC5->C5_NUM+" difere do cliente "+mv_par01+" do filtro solicitado.")
		Return .F.
	EndIf
	If SC5->C5_LOJACLI<>mv_par02
		MsgStop("Loja do Cliente "+SC5->C5_LOJACLI+" da Proposta "+SC5->C5_NUM+" difere da loja  "+mv_par02+" do filtro solicitado.")
		Return .F.
	EndIf
	
EndIf



Return lRetorno

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR700  ºAutor  ³Microsiga           º Data ³  05/31/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function PR700SXB()
Local aAreaAtu	:=GetArea()
Local aAreaSX3	:=SX3->(GetArea())
Local cSql		:= ""
Local cAliasTmp:= GetNextAlias()
Local llOk		:= .F.
Local aCoord	:=	MsAdvSize(.F.,.F.,0)
Local aMyHeader:= {}
Local aMyCols	:= {}
Local aAux		:={}
Local oGrid		:= Nil
Local oDlg		:= Nil




cSql := " SELECT C5_NUM,C5_CLIENTE,C5_LOJACLI,C5_EMISSAO"
cSql += " FROM  " + RetSqlName("SC5") + " SC5 "
cSql += " Where SC5.C5_FILIAL = '" + xFilial("SC5") + "' "
cSql+=" And SC5.C5_XSTAPED='00'"
cSql+=" And SC5.C5_CLIENTE='"+M->C5_CLIENTE+"'"
cSql += " AND SC5.D_E_L_E_T_ = ' ' "
cSql += " ORDER BY C5_NUM "
DbUseArea(.T.,"TOPCONN",TcGenQry(,,cSql),cAliasTmp, .F., .T.)
aEval( SC5->( dbStruct() ) ,{ |x| If( x[2]!="C", TcSetField( cAliasTmp,AllTrim(x[1]),x[2],x[3],x[4]),Nil ) } )


Do While (cAliasTmp)->(!Eof())
	AADD(aMyCols,{})
	aAux:=aMyCols[Len(aMyCols)]
	For nInd:=1 To Len((cAliasTmp)->(DbStruct()))
		(cAliasTmp)->( aAdd(aAux,FieldGet(nInd)  ))
	Next 
	AADD(aAux,.F.)
	(cAliasTmp)->(DbSkip())
EndDo

SX3->(DbSetOrder(2))


For nInd:=1 To Len((cAliasTmp)->(DbStruct()))
	
	If !SX3->(DbSeek( (cAliasTmp)->(FieldName(nInd))  ))
		Loop
	EndIf
	
	aAdd( aMyHeader, {	AllTrim( X3Titulo() ),;
	AllTrim( SX3->X3_CAMPO ),;
	SX3->X3_PICTURE,;
	SX3->X3_TAMANHO,;
	SX3->X3_DECIMAL,;
	SX3->X3_VALID,;
	SX3->X3_USADO,;
	SX3->X3_TIPO,;
	SX3->X3_F3,;
	SX3->X3_CONTEXT,;
	SX3->X3_CBOX,;
	SX3->X3_RELACAO,;
	SX3->X3_WHEN,;
	SX3->X3_VISUAL,;
	SX3->X3_VLDUSER,;
	SX3->X3_PICTVAR,;
	SX3->X3_OBRIGAT,;
	SX3->X3_FOLDER ;
	} )
	
	
	
Next

oDlg	:= TDialog():New(aCoord[1],aCoord[2],aCoord[6]*0.30,aCoord[5]*0.30,"Pedidos Pai" ,,,,,CLR_BLACK,CLR_WHITE,,,.T.)

oGrid	:= MsNewGetDados():New(0000,0000,0000,0000,1,"AllWaysTrue()","AllWaysTrue()","",,,9999,"AllWaysTrue()",,,oDlg,aMyHeader,aMyCols)
oGrid:lInsert := .F.
oGrid:oBrowse:Align := CONTROL_ALIGN_ALLCLIENT
oGrid:oBrowse:BLDBLCLICK		:= {|| M->C5_YPEDPAI := GdFieldGet("C5_NUM",oGrid:nAt,,aMyHeader,aMyCols),oDlg:End() }
oGrid:oBrowse:BRCLICKED 		:= oGrid:oBrowse:BLDBLCLICK

oDlg:Activate(Nil,Nil,Nil,.T.,Nil,Nil,Nil,Nil,Nil)                                                                                      

(cAliasTmp)->(DbCloseArea())

RestArea(aAreaSX3)
RestArea(aAreaAtu)

Return M->C5_YPEDPAI


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR700  ºAutor  ³Microsiga           º Data ³  04/05/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PR700VAL()
Local aAreaAtu:=GetArea()
Local aAreaAux
Local lRetorno:=.T.

If __ReadVar=="M->C5_YDTINIC"
	If !M->C5_XSTAPED=="00"
		MsgStop("Preenchimento somente quando "+AvSx3("C5_XSTAPED",5)+" igual "+ Capital( TABELA("Z6","00",.F.) )	)
		Return .F.
	EndIf
EndIf


If __ReadVar=="M->C5_YPEDPAI"
	
	SC5->(DbSetOrder(1))
	If !SC5->(DbSeek(xFilial("SC5")+M->C5_YPEDPAI))
		MsgStop("Pedido "+M->C5_YPEDPAI+" não encontrado")
		lRetorno:=.F.
	ELseIf !SC5->C5_XSTAPED=="00"
		MsgStop("Pedido "+M->C5_YPEDPAI+" não esta com "+AvSx3("C5_XSTAPED",5)+" igual "+ Capital( TABELA("Z6","00",.F.) )	)
		lRetorno:=.F.
	ElseIf !SC5->C5_CLIENTE==M->C5_CLIENTE
		MsgStop("Cliente "+SC5->C5_CLIENTE+" do Pedido "+M->C5_YPEDPAI+" pai difere no cliente atual"+M->C5_CLIENTE)
		lRetorno:=.F.
	ElseIf SC5->C5_YVALLOJ=="1"  .And.  !SC5->C5_LOJACLI==M->C5_LOJACLI
		MsgStop("Loja do Cliente "+SC5->C5_LOJACLI+" do Pedido "+M->C5_YPEDPAI+" pai difere no cliente atual"+M->C5_LOJACLI)
		lRetorno:=.F.
	ElseIf M->C5_EMISSAO > SC5->C5_YDTFIM
		MsgStop("Pedido "+M->C5_YPEDPAI+" vencido em "+DTOC(M->C5_YDTFIM) )
		lRetorno:=.F.
	EndIf
	
	If lRetorno
		M->C5_YPERIOD:=SC5->C5_YPERIOD
		M->C5_YDTINIC:=SC5->C5_YDTINIC
		M->C5_YDTFIM :=SC5->C5_YDTFIM
		M->C5_YVALLOJ:=SC5->C5_YVALLOJ
	EndIf
	
	SC5->(DbSeek(xFilial("SC5")+M->C5_NUM))
	
	
EndIf

RestArea(aAreaAtu)

Return lRetorno

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR700  ºAutor  ³Microsiga           º Data ³  05/31/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function PR700MarPVPAi(cPedido)
Local nMargem:=0
Local aAreaSC5:=SC5->(GetArea())

SC5->(DbSetOrder(1))

If SC5->(DbSeek(xFilial("SC5")+cPedido)) .And. SC5->C5_YSTATUS $ "01*06" .And. dDataBase>=SC5->C5_YDTINIC  .And. dDataBase<=SC5->C5_YDTFIM
	nMargem:=SC5->C5_YPERLIQ
EndIf

RestArea(aAreaSC5)

Return nMargem

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR700  ºAutor  ³Microsiga           º Data ³  06/04/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PR700TOK()
Local aAreaAtu:=GetArea()
Local aAreaSC6:=GetArea()
Local nInd
Local lRetorno:=.T.

//If M->C5_XSTAPED=='00' .And. Empty(M->C5_YDTINIC)
//	MsgStop("Campo "+AvSx3("C5_YDTINIC",5)+" Obrigatorio" )
//	Return .F.
//EndIf

SC6->(DbSetOrder(2))//C6_FILIAL+C6_PRODUTO+C6_NUM+C6_ITEM

For nInd:=1 To Len(aCols)
	
	If GdDeleted( nInd)
		Loop
	Endif
	
	If !SC6->(DbSeek(xFilial("SC6")+GdFieldGet("C6_PRODUTO", nInd)+M->C5_YPEDPAI))
		MsgStop("Produto "+AllTrim(GdFieldGet("C6_PRODUTO", nInd))+" "+AllTrim(GdFieldGet("C6_DESCRI", nInd))+" não encontrado no Pedido Pai:"+M->C5_YPEDPAI )
		lRetorno:=.F.
		Exit
	EndIf
Next
RestArea(aAreaAtu)
RestArea(aAreaSC6)

Return lRetorno


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR700  ºAutor  ³Microsiga           º Data ³  06/04/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PR700GET(cAcao)

If Work->C5_YSTATUS$"01*06"
	Aviso("PR700GET 01","Pedido já aprovado",{"Ok"},3)
ElseIf Work->C5_YSTATUS=="07"
	Aviso("PR700GET 01","Pedido reprovado",{"Ok"},3)
ElseIf Work->C5_YSTATUS=="02"
	Aviso("PR700GET 02","Pedido sujeito a aprovação",{"Ok"},3)
ElseIf !Work->P0B_USER == Alltrim(cUserLog)
	Aviso("PR700GET 03","Só permitido analise pelo aprovador "+UsrFullName(Work->P0B_USER)+".",{"Ok"},3)
Else
	
	If Empty(Work->OK)
		Work->OK:="VE"
	ElseIf Work->OK=="VE" .And. cAcao=="APROVAR"
		Work->OK:="RE"
	Else
		Work->OK:=""
	EndIf
	
EndIf




Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR700  ºAutor  ³Microsiga           º Data ³  06/06/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PR700LastApr(cNumPedido)
Local aAreaAtu	:=GetArea()
Local aAreaP0B	:=P0B->(GetArea())
Local cFilP0B	:=xFilial("P0B")
Local aDadosRet	:={"","","","",0}
Local cQuery	:=""
Local cAliasQry	:=GetNextAlias()

//P0B->P0B_STATUS== '01',"Aguardando sua aprovação", IIf(P0B->P0B_STATUS == '02',"Aguar. demais aprov. no mesmo nível", IIf(P0B->P0B_STATUS == '03',"Aguardando aprovação nível superior", IIf(P0B->P0B_STATUS == '04',"Aprovado",IIf(P0B->P0B_STATUS == '05',"Reprovado",""

P0B->(DbSetOrder(3))//P0B_FILIAL+P0B_PEDIDO+P0B_NUM

If P0B->(DbSeek(cFilP0B+SC5->C5_NUM  ))
	
	cQuery:=" Select P0B.R_E_C_N_O_ RecP0B From "+RetSqlName("P0B")+" P0B "
	cQuery+=" Where P0B.P0B_FILIAL='"+xFilial("P0B")+"'"
	cQuery+=" And P0B.P0B_PEDIDO='"+cNumPedido+"'"
	cQuery+=" And P0B.D_E_L_E_T_=' '"
	cQuery+=" Order By P0B_NUM DESC , P0B_NIVEL ASC"
	
	DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasQry, .F., .F.)
	
	
	Do While (cAliasQry)->(!Eof())   //P0B->(!Eof()) .And. P0B->(P0B_FILIAL+P0B_PEDIDO)==cFilP0B+SC5->C5_NUM
		
		P0B->( DbGoTo(  (cAliasQry)->RecP0B )   )
		
		If P0B->P0B_STATUS== '05'
			aDadosRet:={"05","Pedido Reprovado","","",P0B->(Recno())}
			Exit
		ElseIf 	P0B->P0B_STATUS== '04'
			aDadosRet:={"04","Pedido Aprovado","","",P0B->(Recno())}
			Exit
		ElseIf P0B->P0B_STATUS== '01'
			aDadosRet:={P0B->P0B_STATUS,"Aguardando Aprovação",P0B->P0B_USER,UsrFullName(P0B->P0B_USER),P0B->(Recno())}
			Exit
		EndIf
		
		(cAliasQry)->(DbSkip())
	EndDo
	
	(cAliasQry)->(DbCloseArea())
	
EndIf


RestArea(aAreaP0B)
RestArea(aAreaAtu)
Return aDadosRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR700  ºAutor  ³Microsiga           º Data ³  06/06/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PR700RetMark(cAcao)
Local  oReturn


If Work->OK=="AP"
	oReturn:=oJaAprovado
ElseIf Empty(Work->OK)
	oReturn:=oDesmarcar
ElseIf Work->OK=="RE"
	oReturn:=oReprovar
ElseIf Work->OK=="VE"
	oReturn:=oAprovar
EndIf


Return  oReturn

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR700  ºAutor  ³Microsiga           º Data ³  06/06/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PR700Gravar()

ProcRegua( Work->(RecCount())  )
Work->(DbGoTop())

Do While Work->(!Eof())
	
	If Work->RECP0B==0
		Work->(DbSkip());Loop
	EndIf
	
	P0B->( DbGoTo( Work->RECP0B )   )
	If Work->OK=="RE"
		u_NCGATPED("R",.F.,"Reprovação via Pai Filho")
	ElseIf Work->OK=="VE"
		u_NCGATPED("A",.F.,"Aprovação via Pai Filho")
	EndIf
	Work->(DbSkip())
EndDo

Return
