#INCLUDE "PROTHEUS.CH"
#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"
#INCLUDE "RPTDEF.CH"
#INCLUDE "FWPRINTSETUP.CH"

Static cSerieNf:=""
Static cPrinter:=""


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR118  บAutor  ณMicrosiga           บ Data ณ  11/07/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NCGPR118()
Local nInterval:=15*(1000) // 30 segundos
Private cCadastro := "Lote de Pedidos(GATI)"
Private aRotina := MenuDef()

//P07->(DbSetOrder(1))//P07_FILIAL+P07_LOTE+P07_DTLOTE+P07_HRLOTE+P07_USLOTE
P07->(DbSetOrder(4))//P07_FILIAL+P07_NRLOTE

oBrowse := FWMBrowse():New()
oBrowse:SetAlias("P07")
oBrowse:SetDescription(cCadastro)
oBrowse:AddLegend("P07_STATUS='0'", "WHITE", "Nใo Iniciado")
oBrowse:AddLegend("P07_STATUS='1'", "RED", "Nใo Concluํdo")
oBrowse:AddLegend("P07_STATUS='2'", "GREEN", "Concluํdo.")


oBrowse:SetTimer( {|| MsgRun ( "Atualizando Dados", "NcGames", {||  P07->(DbSetOrder(4)),oBrowse:ChangeTopBot(.T.) } ) },nInterval )
oBrowse:Activate()

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR118  บAutor  ณMicrosiga           บ Data ณ  11/07/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PR118BRW(cAlias,nReg,nOpc)
Local aAreaAtu	:= GetArea()
Local aAreaP07	:= P07->(GetArea())
Local oDlg
Local aSize   	:= MsAdvSize()
Local aObjects	:= {}
Local aCpoCab	:= {"NOUSER"}
Local aCpoGrid	:= {}
Local aInfo		:= {}
Local aPosObj	:= {}
Local bOk		:= {|| lProcessar:=.F.,oDlg:End() }
Local bCancel	:= {|| lProcessar:=.F.,oDlg:End() }
Local aButtons	:= {}
Local nOpcy		:= 0
Local cSeekKey	:= xFilial("P07")+P07->P07_LOTE
Local bSeekWhile:= {|| PA7->(PA7_FILIAL+PA7_LOTE) }
Local uSeekFor	:= {}
Local bExecutar	:={||.T.}
Local cNrLote :=P07->P07_LOTE
Local cFilter := PA7->(DbFilter())
Local cNomeSemaforo:="PR118"+cNrLote
Local nHDL
Local lProcessar:=.F.

Private aTELA[0][0],aGETS[0]
Private aHeader:={}
Private aCols:={}
Private oGetPA7DB
Private oTimer

Private cUrl:=AllTrim(PadR(GetNewPar("MV_SPEDURL","http://"),250))
Private cIdEnt

If nOpc<>2
	If !Semaforo(.T.,@nHDL,cNomeSemaforo)
		MsgStop("Lote "+cNrLote+" jแ estแ sendo executado.","NcGames")
		Return
	EndIf
	AAdd(aButtons,{"SIMULACAO"  , {|| PR118Init(cNrLote,nOpc) }   ,"Processando Lote"})
Else
	oTimer 		:= TTimer():New(100,{|| MsgRun("Atualizando tela...","Atualiza็ใo",{|| PA7->(DbGoTop()),oGetPA7DB:ForceRefresh() }) },oDlg)
EndIf


AAdd(aButtons,{"SIMULACAO"  , {|| PR118PV( ) }   ,"Pedido Venda"})
AAdd(aButtons,{"SIMULACAO"  , {|| PR118NF( ) }   ,"Nota Fiscal"})


PA7->(DbSetFilter({|| .T.},"@PA7_LOTE='"+cNrLote+"'"))


aadd(aCpoCab,"P07_LOTE")
aadd(aCpoCab,"P07_DTLOTE")
aadd(aCpoCab,"P07_HRLOTE")
aadd(aCpoCab,"P07_USLOTE")
/*
aadd(aCpoGrid,"PA7_LEGEND")
aadd(aCpoGrid,"PA7_STATUS")
aadd(aCpoGrid,"PA7_PEDIDO")
aadd(aCpoGrid,"PA7_CLIENT")
aadd(aCpoGrid,"PA7_LOJA")
aadd(aCpoGrid,"PA7_NOME")
aadd(aCpoGrid,"PA7_NOTA")
aadd(aCpoGrid,"PA7_SERIE")
aadd(aCpoGrid,"PA7_OBS")
*/

RegToMemory("P07",.F.)
//FillGetDados ( < nOpc>, < cAlias>, [ nOrder], [ cSeekKey], [ bSeekWhile], [ uSeekFor], [ aNoFields], [ aYesFields], [ lOnlyYes], [ cQuery], [ bMontCols], [ lEmpty], [ aHeaderAux], [ aColsAux], [ bAfterCols], [ bBeforeCols], [ bAfterHeader], [ cAliasQry], [ bCriaVar], [ lUserFields], [ aYesUsado] ) --> lRet
PA7->(FillGetDados ( nOpc, "PA7",5, cSeekKey, bSeekWhile,  /*uSeekFor*/, /*aNoFields*/, /*aCpoGrid*/, .T., /*[ cQuery]*/, /*[bMontCols]*/, nOpc==3, aHeader, aCols, /*[ bAfterCols]*/, /*[ bBeforeCols]*/, /*[ bAfterHeader]*/, /*[ cAliasQry]*/, /*[ bCriaVar]*/, .F.))


aSizeAut	:= MsAdvSize(,.F.,400)
AAdd( aObjects, { 0,    70, .T., .F. } )
AAdd( aObjects, { 100, 100, .T., .T. } )

aInfo := { aSizeAut[ 1 ], aSizeAut[ 2 ], aSizeAut[ 3 ], aSizeAut[ 4 ], 3, 3 }
aPosObj := MsObjSize( aInfo, aObjects )

PA7->(DbSetOrder(1))
DEFINE MSDIALOG oDlg TITLE "Lote Pedido(GATI)" From aSize[7],0 To aSize[6],aSize[5] of oMainWnd PIXEL


Enchoice( "P07", nReg, nOpc, , , , aCpoCab, {aPosObj[1,1],aPosObj[1,2],aPosObj[1,3],aPosObj[1,4]},, 1, , ,"AllwaysTrue()", oDlg, .F.,  .T., .F., , .T., .F.)
oGetPA7DB:=MsGetDB():New(aPosObj[2,1],aPosObj[2,2],aPosObj[2,3],aPosObj[2,4],1,,,,.F.,,,.F.,,"PA7")

ACTIVATE MSDIALOG oDlg ON INIT ( PR118Init(cNrLote,nOpc), EnchoiceBar(oDlg,bOk,bCancel,,aButtons)  )


PA7->(DbSetFilter({|| .T.},"@"+cFilter))
Semaforo(.F.,nHDL,cNomeSemaforo)

RestArea(aAreaP07)
RestArea(aAreaAtu)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR118  บAutor  ณMicrosiga           บ Data ณ  11/07/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PR118Grv(aPVNF)
Local aAreaAtu:=GetArea()
Local aAreaSC5:=SC5->(GetArea())
Local aAreaZC5:=ZC5->(GetArea())
Local nInd
Local cFilP07:=xFilial("P07")
Local cFilPA7:=xFilial("PA7")
Local cFilSC5:=xFilial("SC5")
Local cFilZC5:=xFilial("SC5")
Local cNrLote:=GetSXENum("P07","P07_LOTE")
Local cDtLote:=MsDate()
Local cHrLote:=Time()
Local cUsrNome:=UsrRetName(__cUserId)

SC5->(DbSetOrder(1))
ZC5->(DbSetOrder(2))//ZC5_FILIAL+ZC5_NUMPV

Begin Transaction
P07->(RecLock("P07",.T.))
P07->P07_FILIAL	:=cFilP07
P07->P07_LOTE	:=cNrLote
P07->P07_DTLOTE	:=cDtLote
P07->P07_HRLOTE	:=cHrLote
P07->P07_USLOTE	:=cUsrNome
P07->P07_NRLOTE	:=99999999-Val(cNrLote)
P07->P07_STATUS:="0"

For nInd:=1 To Len(aPVNF)
	PA7->(RecLock("PA7",.T.))
	PA7->PA7_FILIAL	:=cFilPA7
	PA7->PA7_LOTE	:=cNrLote
	PA7->PA7_PEDIDO	:=aPVNF[nInd]
	
	PA7->PA7_STATUS:="0"
	PA7->PA7_LEGEND:="BR_BRANCO"
	If SC5->(DbSeek(cFilSC5+PA7->PA7_PEDIDO) )
		PA7->PA7_CLIENT	:=SC5->C5_CLIENTE
		PA7->PA7_LOJA	:=SC5->C5_LOJACLI
		PA7->PA7_NOME	:=SC5->C5_NOMCLI
	EndIf
	
	If ZC5->(DbSeek(cFilZC5+PA7->PA7_PEDIDO) )
		PA7->PA7_PVSITE	:=	Iif(!Empty(ZC5->ZC5_PVVTEX),ZC5->ZC5_PVVTEX, (Iif(ZC5->ZC5_NUM <> 0, Alltrim(Str(ZC5->ZC5_NUM)),"")))
	EndIf
	
Next

End Transaction
ConfirmSX8()

RestArea(aAreaSC5)
RestArea(aAreaZC5)
RestArea(aAreaAtu)

Return cNrLote
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR118  บAutor  ณMicrosiga           บ Data ณ  11/07/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PR118Exec(cNrLote,lEnd)
Local aAreaAtu:=GetArea()
Local aAreaSC5:=SC5->(GetArea())
Local aAreaSC6:=SC6->(GetArea())
Local aAreaSC9:=SC9->(GetArea())
Local aAreaSB1:=SB1->(GetArea())
Local aAreaSB2:=SB2->(GetArea())
Local aAreaSF4:=SF4->(GetArea())
Local aAreaSD2:=SD2->(GetArea())
Local aAreaSF2:=SF2->(GetArea())
Local aAreaPA7:=PA7->(GetArea())
Local aAreaSA1:=SA1->(GetArea())

Local aPrinters :=RetImpWin(.F.)
Local cFiliais	:= SuperGetMV("NCG_000030",.F.,'03')
Local oDlgProc	:=GetWndDefault()
Local aParamBox	:={}
Local aRet		:={}
Local aPvlNfs	:={}

Local nContar	:=0

Local nYnd
Local oRetorno
Local lOK


Local cFilSA1	:=xFilial("SA1")
Local cFilPA7	:=xFilial("PA7")
Local cFilSC6	:=xFilial("SC6")
Local cFilSC5	:=xFilial("SC5")
Local cFilSC9	:=xFilial("SC9")
Local cFilSC6	:=xFilial("SC6")
Local cFilSB1	:=xFilial("SB1")
Local cFilSB2	:=xFilial("SB2")
Local cFilSF4	:=xFilial("SF4")
Local cFilSD2	:=xFilial("SD2")
Local cFilSF2	:=xFilial("SF2")
Local cSerieIni :=Padr(Alltrim(U_MyNewSX6("NC_GATISER","3","C","Serie Default","","",.F. )),Len(SF2->F2_SERIE))
Local cNotaFiscal:=""
Local cAliasQry

Local aMvPar	:={}
Local lOKWebService
Local nMv
Local cModalidade
Local cVersao
Local cVersaoDpec
Local cFunName:=FunName()
Local cErroWMS := ""
Local aItens:={}
Local aItensAux:={}
Default cNrLote:=PA7->PA7_LOTE


For nMv := 1 To 40
	aAdd( aMvPar, &( "MV_PAR" + StrZero( nMv, 2, 0 ) ) )
Next nMv

aAdd(aParamBox,{1,"Selecione a Serie",cSerieIni,"","","GATISE","",0,.T.}) // Tipo caractere
// Tipo 1 -> MsGet()
//           [2]-Descricao
//           [3]-String contendo o inicializador do campo
//           [4]-String contendo a Picture do campo
//           [5]-String contendo a validacao
//           [6]-Consulta F3
//           [7]-String contendo a validacao When
//           [8]-Tamanho do MsGet
//           [9]-Flag .T./.F. Parametro Obrigatorio ?

aAdd(aParamBox,{2,"Selecione Impressora DANFE",1,aPrinters,100,"",.T.})
// Tipo 2 -> Combo
//           [2]-Descricao
//           [3]-Numerico contendo a opcao inicial do combo
//           [4]-Array contendo as opcoes do Combo
//           [5]-Tamanho do Combo
//           [6]-Validacao
//           [7]-Flag .T./.F. Parametro Obrigatorio ?

If Empty(cSerieNf) .Or. Empty(cPrinter)
	
	If !ParamBox(aParamBox,"Parametros",@aRet,,,,,,,,.F.)  //(aParametros,cTitle,aRet,bOk,aButtons,lCentered,nPosx,nPosy, oDlgWizard, cLoad, lCanSave,lUserSave)
		Return .T.
	EndIf
	
	cSerieNf:=aRet[1]
	If ValType(aRet[2])=="N"
		cPrinter:=aPrinters[ aRet[2] ]
	Else
		cPrinter:= aRet[2]
	EndIf
EndIf
//cSerieNf:="TST"

For nMv := 1 To Len( aMvPar )
	&( "MV_PAR" + StrZero( nMv, 2, 0 ) ) := aMvPar[ nMv ]
Next nMv

SC5->(DbSetOrder(1))//C5_FILIAL+C5_NUM
SC9->(DbsetOrder(1))//C9_FILIAL+C9_PEDIDO+C9_ITEM+C9_SEQUEN+C9_PRODUTO
SC6->(DbSetOrder(1))//C6_FILIAL+C6_NUM+C6_ITEM+C6_PRODUTO
SB1->(DbSetOrder(1))//B1_FILIAL+B1_COD
SA1->(DbSetOrder(1))//A1_FILIAL+A1_COD+A1_LOJA
SB2->(DbSetOrder(1))//B2_FILIAL+B2_COD+B2_LOCAL
SF4->(DbSetOrder(1))//F4_FILIAL+F4_CODIGO
SD2->(DbSetOrder(8))//D2_FILIAL+D2_PEDIDO+D2_ITEMPV

Pr118Qry(@cAliasQry,cNrLote,"0" )

Do While (cAliasQry)->(!Eof())
	
	PA7->(DbGoTo((cAliasQry)->RECPA7 ) )
	
	If SD2->(MsSeek(cFilSD2+PA7->PA7_PEDIDO))
		PA7->(RecLock("PA7",.F.))
		PA7->PA7_NOTA:=SD2->D2_DOC
		PA7->PA7_SERIE:=SD2->D2_SERIE
		PA7->(MsUnLock())
		P118Status("1")
	EndIf
	
	If !Empty(PA7->PA7_NOTA)
		(cAliasQry)->(DbSkip());Loop
	EndIf
	
	//Verifica se a filial faz integra็ใo com o WMS
	If cFilSF2 $ FormatIN(cFiliais,"|")
		If !PR118WMS(PA7->PA7_PEDIDO,@cErroWMS)
			PR118Obs(cErroWMS)
			P118Status("E")
			(cAliasQry)->(DbSkip());Loop
		EndIf
	EndIf
	
	aPvlNfs:={}
	SC9->(MsSeek(cFilSC9+PA7->PA7_PEDIDO))
	SA1->(MsSeek(cFilSA1+SC9->(C9_CLIENTE+C9_LOJA)) )
	
	Do While SC9->(!Eof()) .And. SC9->(C9_FILIAL+C9_PEDIDO)==cFilSC9+PA7->PA7_PEDIDO
		
		If ! ( Empty(SC9->C9_BLWMS) .And. Empty(SC9->C9_BLEST) .And. Empty(SC9->C9_BLCRED) )
			SC9->(DbSkip());Loop
		EndIf
		
		If !SC9->C9_QTDLIB > 0
			SC9->(DbSkip());Loop
		EndIf
		SC5->(DbSeek(cFilSC5+PA7->PA7_PEDIDO) )
		SC6->(MsSeek(cFilSC6+SC9->(C9_PEDIDO+C9_ITEM)  ))
		SB1->(MsSeek(cFilSB1+SC9->C9_PRODUTO) )
		SB2->(MsSeek(cFilSB2+SC9->(C9_PRODUTO+C9_LOCAL)) )
		SF4->(MsSeek(cFilSF4+SC6->C6_TES) )
		
		aAdd(aPvlNfs,{ SC9->C9_PEDIDO,;
		SC9->C9_ITEM,;
		SC9->C9_SEQUEN,;
		SC9->C9_QTDLIB,;
		SC9->C9_PRCVEN,;
		SC9->C9_PRODUTO,;
		SF4->F4_ISS=='S',;
		SC9->(RecNo()),;
		SC5->(RecNo()),;
		SC6->(RecNo()),;
		SE4->(RecNo()),;
		SB1->(RecNo()),;
		SB2->(RecNo()),;
		SF4->(RecNo()),;
		SB2->B2_LOCAL,;
		0,;
		SC9->C9_QTDLIB2})
		
		SC9->(DBSkip())
	EndDo
	
	cNotaFiscal := U_PR118NFGRV({cEmpAnt, cFilAnt, aPvlNfs, cSerieNf})
	
	If !Empty(cNotaFiscal)
		PA7->(RecLock("PA7",.F.))
		PA7->PA7_NOTA:=cNotaFiscal
		PA7->PA7_SERIE:=cSerieNf
		PA7->(MsUnLock())
		P118Status("1")
	EndIf
	
	If lEnd
		lEnd:=MsgYesNo("Interromper o processo de gera็ใo de Notas?")
	EndIf
	
	If lEnd
		Exit
	EndIf
	
	(cAliasQry)->(DbSkip())
Enddo
Pr118CloseArea(cAliasQry)
DbSelectArea("PA7")


If !lEnd
	Processa( {|lEnd| U_PR118Trans(cNrLote,@lEnd) },"NcGames","Transmissao Nota Fiscal",.T. )
	//U_PR118Trans(cNrLote,.F.)
EndIf

Processa({|| PR118SetStatus(cNrLote)} ,"NcGames","Atualizando Status" )


RestArea(aAreaAtu)

SetFunName(cFunName)
RestArea(aAreaSC5)
RestArea(aAreaSC6)
RestArea(aAreaSC9)
RestArea(aAreaSA1)
RestArea(aAreaSB1)
RestArea(aAreaSB2)
RestArea(aAreaSF4)
RestArea(aAreaSD2)
RestArea(aAreaSF2)
RestArea(aAreaPA7)
RestArea(aAreaAtu)


Return .T.
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR118  บAutor  ณMicrosiga           บ Data ณ  11/07/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ
บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PR118Trans(cNrLote,lEnd)
Local aAreatu	:=GetArea()
Local cFilPA7	:=xFilial("PA7")
Local cFilSF2	:=xFilial("SF2")
Local cAliasQry
Local nAt
Local cRetorno
Local cMensagem:="TOTVS SPED SERVICES"
Local cStatNf	:= " "+GetNewPar("MV_NFEAUTR","")

SF2->(DbSetOrder(1))//F2_FILIAL+F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA+F2_FORMUL+F2_TIPO

Pr118Qry(@cAliasQry,cNrLote,"1")
Do While (cAliasQry)->(!Eof())
	
	If lEnd
		lEnd:=MsgYesNo("Interromper o processo de Trasmissใo das Notas?")
	EndIf
	
	If lEnd
		Exit
	EndIf
	PA7->(DbGoTo( (cAliasQry)->RecPA7 ) )
	
	If !SF2->(DbSeek(cFilSF2+PA7->(PA7_NOTA+PA7_SERIE+PA7_CLIENT+PA7_LOJA)))
		PR118Obs("Nota Fiscal "+PA7->(PA7_NOTA+"/"+PA7_SERIE)+" excluida.")
		P118Status("E")
		(cAliasQry)->(DbSkip());Loop
	EndIf
	
	
	Pergunte(Padr("MT460A",Len(SX1->X1_GRUPO)),.F.)
	
	MV_PAR01 := 2
	MV_PAR02 := 2
	MV_PAR03 := 2
	MV_PAR04 := 2
	MV_PAR05 := 2
	MV_PAR06 := 0
	MV_PAR08 := 1
	MV_PAR09 := ""
	MV_PAR10 := ""
	MV_PAR11 := 2
	MV_PAR12 := 0
	MV_PAR13 := ""
	MV_PAR14 := "Z"
	MV_PAR15 := 2
	MV_PAR16 := 2
	MV_PAR17 := 1
	MV_PAR18 := 2
	MV_PAR19 := 2
	MV_PAR20 := 2
	
	IncProc("Transmitindo Nota Fiscal "+SF2->F2_DOC)
	
	If Empty( cIdEnt:=GetIdEnt() )
		PR118Obs(AllTrim( StrTran( GetWscError(1),CRLF," ") ))
		Return
	EndIf
	
	If !IsReady()
		PR118Obs(AllTrim( StrTran( GetWscError(1),CRLF," ") ))
		(cAliasQry)->(DbSkip());Loop
	EndIf
	SF2->(RecLock("SF2",.F.))
	SF2->F2_FIMP:=" "+GetNewPar("MV_NFEAUTR","")
	SF2->(MsUnLock())
	
	cRetorno:=MyAutoNfeEnv(cEmpAnt,cFilAnt,"60","3",SF2->F2_SERIE,SF2->F2_DOC,SF2->F2_DOC)
	cRetorno:=StrTran(cRetorno,CRLF,"")
	nAt:=At(cMensagem,Upper(cRetorno))
	
	If nAt>0
		PR118Obs( AllTrim(Substr(cRetorno,nAt)) )
	Else
		P118Status("2")
	EndIf
	
	
	(cAliasQry)->(DbSkip())
EndDo
Pr118CloseArea(cAliasQry)
RestArea(aAreatu)

If !lEnd
	Sleep(6000)
	Processa( {|lEnd| U_PR118Danfe(cNrLote,@lEnd) },"NcGames","Danfe",.T. )
	//U_PR118Danfe(cNrLote,.F.)
EndIf




Return .T.
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR118  บAutor  ณMicrosiga           บ Data ณ  11/13/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PR118Danfe(cNrLote)
Local aAreatu	:=GetArea()
Local cFilPA7	:=xFilial("PA7")
Local cFilSC6	:=xFilial("SC6")
Local cFilSC9	:=xFilial("SC9")
Local cFilSC6	:=xFilial("SC6")
Local cFilSB1	:=xFilial("SB1")
Local cFilSB2	:=xFilial("SB2")
Local cFilSF4	:=xFilial("SF4")
Local cFilSD2	:=xFilial("SD2")
Local cFilSF2	:=xFilial("SF2")
Local nTentativa:=10
Local cDirDanfe:=Alltrim(U_MyNewSX6("NC_GATIDIR","C:\GATI_DANFE\","C","Diretorio do DANFE","","",.F. ))
Local cAliasQry
Local cSerieNf
Local cNotaFiscal
Local cPathPDF:=cDirDanfe+cNrLote+"\"

Local lOKWebService
Local nMv
Local cModalidade
Local cVersao
Local cVersaoDpec
Local cEndArq	:="GATI_DANFE\"
Local cDirSystem:=GetTempPath()

If !IsReady()
	PR118Obs(AllTrim( StrTran( GetWscError(1),CRLF," ") ))
	Return
EndIf

If Right(cDirSystem,1) <> "\"
	cDirSystem += "\"
EndIf

MakeDir(cDirSystem + cEndArq)
MakeDir(cPathPDF)


If Empty( cIdEnt:=GetIdEnt() )
	PR118Obs(AllTrim( StrTran( GetWscError(1),CRLF," ") ))
	Return
EndIf

If !Empty(cIdEnt)
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณObtem o ambiente de execucao do Totvs Services SPED                     ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	oWS := WsSpedCfgNFe():New()
	oWS:cUSERTOKEN := "TOTVS"
	oWS:cID_ENT    := cIdEnt
	oWS:nAmbiente  := 0
	oWS:_URL       := AllTrim(cURL)+"/SPEDCFGNFe.apw"
	lOKWebService := oWS:CFGAMBIENTE()
	cAmbiente := oWS:cCfgAmbienteResult
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณObtem a modalidade de execucao do Totvs Services SPED                   ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If lOKWebService
		oWS:cUSERTOKEN := "TOTVS"
		oWS:cID_ENT    := cIdEnt
		oWS:nModalidade:= 0
		oWS:cModelo	   := "55"
		oWS:_URL       := AllTrim(cURL)+"/SPEDCFGNFe.apw"
		lOKWebService := oWS:CFGModalidade()
		cModalidade    := oWS:cCfgModalidadeResult
	EndIf
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณObtem a versao de trabalho da NFe do Totvs Services SPED                ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If lOKWebService
		oWS:cUSERTOKEN := "TOTVS"
		oWS:cID_ENT    := cIdEnt
		oWS:cVersao    := "0.00"
		oWS:_URL       := AllTrim(cURL)+"/SPEDCFGNFe.apw"
		lOKWebService := oWS:CFGVersao()
		cVersao        := oWS:cCfgVersaoResult
	EndIf
	
	If lOKWebService
		oWS:cUSERTOKEN := "TOTVS"
		oWS:cID_ENT    := cIdEnt
		oWS:cVersao    := "0.00"
		oWS:_URL       := AllTrim(cURL)+"/SPEDCFGNFe.apw"
		lOKWebService := oWS:CFGVersaoDpec()
		cVersaoDpec	   := oWS:cCfgVersaoDpecResult
	EndIf
	
Endif

PA7->(DbSetOrder(5))//PA7_FILIAL+PA7_LOTE+PA7_STATUS
If PA7->(DbSeek(cFilPA7+cNrLote+"2"))
	If !lOKWebService
		PR118Obs("Erro ao conectar WebService Sefaz")
		Return
	EndIf
EndIf

oWS:= WSNFeSBRA():New()
oWS:cUSERTOKEN := "TOTVS"
oWS:cID_ENT    := cIdEnt
oWS:_URL       := AllTrim(cURL)+"/NFeSBRA.apw"
SF2->(DbSetOrder(1))//F2_FILIAL+F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA+F2_FORMUL+F2_TIPO


Pr118Qry(@cAliasQry,cNrLote,"2")
Do While (cAliasQry)->(!Eof()) .And.  lOKWebService
	
	
	If lEnd
		lEnd:=MsgYesNo("Interromper o processo de impressao do DANFE?")
	EndIf
	
	If lEnd
		Exit
	EndIf
	
	
	PA7->(DbGoTo( (cAliasQry)->RecPA7 ) )
	lPrinter:=.F.
	nContar:=1
	
	If !SF2->(DbSeek(cFilSF2+PA7->(PA7_NOTA+PA7_SERIE+PA7_CLIENT+PA7_LOJA)))
		PR118Obs("Nota Fiscal "+PA7->(PA7_NOTA+"/"+PA7_SERIE)+" excluida.")
		P118Status("E")
		(cAliasQry)->(DbSkip());Loop
	EndIf
	
	If !IsReady()
		PR118Obs(AllTrim( StrTran( GetWscError(1),CRLF," ") ))
		(cAliasQry)->(DbSkip());Loop
	EndIf
	
	IncProc("Verificando Status Sefaz Nota: "+SF2->F2_DOC+"(Tentativa "+StrZero(nContar,2)+" de "+StrZero(nTentativa,2)+")" )
	
	oWS:cIdInicial := SF2->F2_SERIE+SF2->F2_DOC
	oWS:cIdFinal   := SF2->F2_SERIE+SF2->F2_DOC
	
	Do While ++nContar<nTentativa
		IncProc("Verificando Status Sefaz Nota: "+SF2->F2_DOC+"(Tentativa "+StrZero(nContar,2)+" de "+StrZero(nTentativa,2)+")" )
		
		lOk := oWS:MONITORFAIXA()
		oRetorno := oWS:oWsMonitorFaixaResult
		cStatus:=GetStatus(oRetorno)
		PR118Obs(cStatus)
		
		If Left(cStatus,3)=="001"
			lPrinter:=.T.;Exit
		ElseIf Left(cStatus,3)=="014" //014 - NFe nใo autorizada
			lPrinter:=.F.
			P118Status("1");Exit
		ElseIf "029 - Falha no Schema do XML"$cStatus
			lPrinter:=.F.
			P118Status("1");Exit
		ElseIf Left(cStatus,4)=="ERRO"
			lPrinter:=.F.
			P118Status("1");Exit
		EndIf
		
		Sleep(3000)
	EndDo
	
	If lPrinter
		
		IncProc("Imprimindo DANFE Nota  "+SF2->F2_DOC)
		
		cNameArq := 	SM0->(Alltrim(M0_CODIGO)+	Alltrim(M0_CODFIL))+	SF2->F2_DOC	+	SF2->F2_SERIE+	Alltrim(Str(Randomize(00,10)))+	Alltrim(Str(Randomize(11,20))) +	Alltrim(Str(Randomize(21,30))) 	;
		+	Alltrim(Str(Randomize(31,40))) 	;
		+	Alltrim(Str(Randomize(41,50))) 	;
		+	Alltrim(Str(Randomize(51,60))) 	;
		+ ".REL"
		
		
		oMyFwMsPrinter := FWMsPrinter():New(cNameArq,IMP_SPOOL,.F.,cDirSystem + cEndArq,.T.,.F.,Nil,cPrinter,.T.,.F.,.F.,.F.,001)
		
		oMyFwMsPrinter:lServer 		:= .F.
		oMyFwMsPrinter:lInJob 		:= .T.
		oMyFwMsPrinter:lViewPDF 	:= .F.
		oMyFwMsPrinter:SetResolution(78)
		oMyFwMsPrinter:SetPortrait()
		oMyFwMsPrinter:SetPaperSize(DMPAPER_A4)
		oMyFwMsPrinter:SetMargin(60,60,60,60)
		
		Pergunte(Padr("NFSIGW",Len(SX1->X1_GRUPO)),.F.)
		
		MV_PAR01 := SF2->F2_DOC
		MV_PAR02 := SF2->F2_DOC
		MV_PAR03 := SF2->F2_SERIE
		MV_PAR04 := 2 // Nota de Saida
		MV_PAR05 := 2//Danfe Simplificado ?
		MV_PAR06 := 2//Imprime no verso?
		
		If !IsReady()
			PR118Obs(AllTrim( StrTran( GetWscError(1),CRLF," ") ))
			(cAliasQry)->(DbSkip());Loop
		EndIf
		
		U_PrtNfeSef(cIdEnt,Nil,Nil,oMyFwMsPrinter,Nil,Nil,.T.)
		P118Status("3")
		oMyFwMsPrinter:=Nil
		
		Pr118PDF(cNrLote)
		
		
		
		
	EndIf
	
	(cAliasQry)->(DbSkip())
EndDo

//oWS       := Nil

Pr118CloseArea(cAliasQry)
RestArea(aAreatu)

Return .T.


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR118  บAutor  ณMicrosiga           บ Data ณ  11/07/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function P118Status(cStatus)
Local aAreaAtu:=GetArea()
Local aAreaPA7:=PA7->(GetArea())

PA7->(RecLock("PA7",.F.))
PA7->PA7_STATUS:=cStatus
PA7->PA7_LEGEND:=Iif(cStatus$"3*E","BR_VERDE","BR_VERMELHO")
PA7->(MsUnLock())

//oGetPA7DB:ForceRefresh()

RestArea(aAreaPA7)
RestArea(aAreaAtu)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR118  บAutor  ณMicrosiga           บ Data ณ  11/07/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function GetIdEnt(lHelp)
Local aArea  := GetArea()
Local cIdEnt := ""
Local oWs
Default lHelp:=.F.



//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณObtem o codigo da entidade                                              ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
oWS := WsSPEDAdm():New()
oWS:cUSERTOKEN := "TOTVS"

oWS:oWSEMPRESA:cCNPJ       := IIF(SM0->M0_TPINSC==2 .Or. Empty(SM0->M0_TPINSC),SM0->M0_CGC,"")
oWS:oWSEMPRESA:cCPF        := IIF(SM0->M0_TPINSC==3,SM0->M0_CGC,"")
oWS:oWSEMPRESA:cIE         := SM0->M0_INSC
oWS:oWSEMPRESA:cIM         := SM0->M0_INSCM
oWS:oWSEMPRESA:cNOME       := SM0->M0_NOMECOM
oWS:oWSEMPRESA:cFANTASIA   := SM0->M0_NOME
oWS:oWSEMPRESA:cENDERECO   := FisGetEnd(SM0->M0_ENDENT)[1]
oWS:oWSEMPRESA:cNUM        := FisGetEnd(SM0->M0_ENDENT)[3]
oWS:oWSEMPRESA:cCOMPL      := FisGetEnd(SM0->M0_ENDENT)[4]
oWS:oWSEMPRESA:cUF         := SM0->M0_ESTENT
oWS:oWSEMPRESA:cCEP        := SM0->M0_CEPENT
oWS:oWSEMPRESA:cCOD_MUN    := SM0->M0_CODMUN
oWS:oWSEMPRESA:cCOD_PAIS   := "1058"
oWS:oWSEMPRESA:cBAIRRO     := SM0->M0_BAIRENT
oWS:oWSEMPRESA:cMUN        := SM0->M0_CIDENT
oWS:oWSEMPRESA:cCEP_CP     := Nil
oWS:oWSEMPRESA:cCP         := Nil
oWS:oWSEMPRESA:cDDD        := Str(FisGetTel(SM0->M0_TEL)[2],3)
oWS:oWSEMPRESA:cFONE       := AllTrim(Str(FisGetTel(SM0->M0_TEL)[3],15))
oWS:oWSEMPRESA:cFAX        := AllTrim(Str(FisGetTel(SM0->M0_FAX)[3],15))
oWS:oWSEMPRESA:cEMAIL      := UsrRetMail(RetCodUsr())
oWS:oWSEMPRESA:cNIRE       := SM0->M0_NIRE
oWS:oWSEMPRESA:dDTRE       := SM0->M0_DTRE
oWS:oWSEMPRESA:cNIT        := IIF(SM0->M0_TPINSC==1,SM0->M0_CGC,"")
oWS:oWSEMPRESA:cINDSITESP  := ""
oWS:oWSEMPRESA:cID_MATRIZ  := ""
oWS:oWSOUTRASINSCRICOES:oWSInscricao := SPEDADM_ARRAYOFSPED_GENERICSTRUCT():New()
oWS:_URL := AllTrim(cURL)+"/SPEDADM.apw"
If oWs:ADMEMPRESAS()
	cIdEnt  := oWs:cADMEMPRESASRESULT
ElseIf lHelp
	//Aviso("SPED",IIf(Empty(GetWscError(3)),GetWscError(1),GetWscError(3)),{"Ok"},3)
EndIf

RestArea(aArea)
Return(cIdEnt)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR106  บAutor  ณMicrosiga           บ Data ณ  11/06/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function IsReady(cURL,nTipo,lHelp)
Local nX       := 0
Local cHelp    := ""
Local oWS
Local lRetorno := .F.
DEFAULT nTipo := 1
DEFAULT lHelp := .F.
If !Empty(cURL) .And. !PutMV("MV_SPEDURL",cURL)
	RecLock("SX6",.T.)
	SX6->X6_FIL     := xFilial( "SX6" )
	SX6->X6_VAR     := "MV_SPEDURL"
	SX6->X6_TIPO    := "C"
	SX6->X6_DESCRIC := "URL SPED NFe"
	MsUnLock()
	PutMV("MV_SPEDURL",cURL)
EndIf



SuperGetMv() //Limpa o cache de parametros - nao retirar
DEFAULT cURL      := PadR(GetNewPar("MV_SPEDURL","http://"),250)
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณVerifica se o servidor da Totvs esta no ar                              ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
oWs := WsSpedCfgNFe():New()
oWs:cUserToken := "TOTVS"
oWS:_URL := AllTrim(cURL)+"/SPEDCFGNFe.apw"
If oWs:CFGCONNECT()
	lRetorno := .T.
Else
	If lHelp
		//Aviso("SPED",IIf(Empty(GetWscError(3)),GetWscError(1),GetWscError(3)),{"Ok"},3)
	EndIf
	lRetorno := .F.
EndIf
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณVerifica se o certificado digital ja foi transferido                    ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If nTipo <> 1 .And. lRetorno
	oWs:cUserToken := "TOTVS"
	oWs:cID_ENT    := GetIdEnt()
	oWS:_URL := AllTrim(cURL)+"/SPEDCFGNFe.apw"
	If oWs:CFGReady()
		lRetorno := .T.
	Else
		If nTipo == 3
			cHelp := IIf(Empty(GetWscError(3)),GetWscError(1),GetWscError(3))
			If lHelp .And. !"003" $ cHelp
				//Aviso("SPED",cHelp,{"Ok"},3)
				lRetorno := .F.
			EndIf
		Else
			lRetorno := .F.
		EndIf
	EndIf
EndIf
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณVerifica se o certificado digital ja foi transferido                    ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If nTipo == 2 .And. lRetorno
	oWs:cUserToken := "TOTVS"
	oWs:cID_ENT    := GetIdEnt()
	oWS:_URL := AllTrim(cURL)+"/SPEDCFGNFe.apw"
	If oWs:CFGStatusCertificate()
		If Len(oWs:oWSCFGSTATUSCERTIFICATERESULT:OWSDIGITALCERTIFICATE) > 0
			For nX := 1 To Len(oWs:oWSCFGSTATUSCERTIFICATERESULT:OWSDIGITALCERTIFICATE)
				If oWs:oWSCFGSTATUSCERTIFICATERESULT:OWSDIGITALCERTIFICATE[nx]:DVALIDTO-30 <= Date()
					
					//Aviso("SPED","O certificado digital irแ vencer em: "+Dtoc(oWs:oWSCFGSTATUSCERTIFICATERESULT:OWSDIGITALCERTIFICATE[nX]:DVALIDTO),{"Ok"},3) //"O certificado digital irแ vencer em: "
					
				EndIf
			Next nX
		EndIf
	EndIf
EndIf

Return(lRetorno)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR118  บAutor  ณMicrosiga           บ Data ณ  11/07/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetStatus(oRetorno)
Local cRecomendacao:="ERRO. Nใo foi possivel identificar o erro. Verifque via Monitor NFE"

For nX := 1 To Len(oRetorno:oWSMONITORNFE)
	oXml := oRetorno:oWSMONITORNFE[nX]
	cRecomendacao:=oXml:CRECOMENDACAO
Next nX

Return cRecomendacao


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR118  บAutor  ณMicrosiga           บ Data ณ  11/07/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function xAcertPA7()
Local aPedidos:={}
Local cNrLote:="000000496"

RpcSetEnv("01","03")
cFilPA7:=xFilial("PA7")
cFilP07:=xFilial("P07")
cFilSC5:=xFilial("SC5")
cFilZC5:=xFilial("ZC5")


SC5->(DbSetOrder(1))
ZC5->(DbSetOrder(2))

AADD(aPedidos,"150321")
AADD(aPedidos,"150324")
AADD(aPedidos,"150327")
AADD(aPedidos,"150329")
AADD(aPedidos,"150330")
AADD(aPedidos,"150332")
AADD(aPedidos,"150336")
AADD(aPedidos,"150339")
AADD(aPedidos,"150346")
/*AADD(aPedidos,"150")
AADD(aPedidos,"150")
AADD(aPedidos,"150")
AADD(aPedidos,"150")
*/

Begin Transaction


For nInd:=1 To Len(aPedidos)  

	cAliasQry:=GetNextAlias()
	BeginSQL Alias cAliasQry
		SELECT Count(1) Contar
		FROM  %Table:PA7% PA7,%Table:SA1% SA1
		WHERE PA7_FILIAL = %xfilial:PA7%
		AND PA7.PA7_LOTE=%exp:cNrLote%
		AND PA7.PA7_PEDIDO=%exp:aPedidos[nInd]%
		AND PA7.%notDel%
		AND A1_FILIAL = %xfilial:SA1%
		AND PA7.PA7_CLIENT=SA1.A1_COD
		AND PA7.PA7_LOJA=SA1.A1_LOJA
		AND SA1.%notDel%
	EndSQL
	
	If (cAliasQry)->Contar==0
		
		PA7->(RecLock("PA7",.T.))
		PA7->PA7_FILIAL:=xFilial("PA7")
		PA7->PA7_STATUS:="0"
		PA7->PA7_LOTE:=cNrLote
		PA7->PA7_PEDIDO:=aPedidos[nInd]
		If SC5->(DbSeek(cFilSC5+PA7->PA7_PEDIDO) )
			PA7->PA7_CLIENT	:=SC5->C5_CLIENTE
			PA7->PA7_LOJA	:=SC5->C5_LOJACLI
			PA7->PA7_NOME	:=SC5->C5_NOMCLI
		EndIf
		If ZC5->(DbSeek(cFilZC5+PA7->PA7_PEDIDO) )
			PA7->PA7_PVSITE	:=	Iif(!Empty(ZC5->ZC5_PVVTEX),ZC5->ZC5_PVVTEX, (Iif(ZC5->ZC5_NUM <> 0, Alltrim(Str(ZC5->ZC5_NUM)),"")))
		EndIf
		
	EndIf
	(cAliasQry)->(DbCloseArea())
Next



End Transaction

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR118  บAutor  ณMicrosiga           บ Data ณ  11/18/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯอออออออออออออออออ'อออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Pr118Qry(cAliasQry,cNrLote,cStatus,cOperador)
Local cFiltro:=""
Default cOperador:=""


If !Empty(cOperador)
	cFiltro:=" AND SA1.A1_EST"+cOperador+"SP"
EndIf

cFiltro:="%"+cFiltro+"%"

cAliasQry:=GetNextAlias()
BeginSQL Alias cAliasQry
	SELECT PA7.R_E_C_N_O_ RecPA7,SA1.A1_EST
	FROM  %Table:PA7% PA7,%Table:SA1% SA1
	WHERE PA7_FILIAL = %xfilial:PA7%
	AND PA7.PA7_LOTE=%exp:cNrLote%
	AND PA7.PA7_STATUS=%exp:cStatus%
	AND PA7.%notDel%
	AND A1_FILIAL = %xfilial:SA1%
	AND PA7.PA7_CLIENT=SA1.A1_COD
	AND PA7.PA7_LOJA=SA1.A1_LOJA
	AND SA1.%notDel%
	%exp:cFiltro%
	ORDER BY PA7_PEDIDO
EndSQL



Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR118  บAutor  ณMicrosiga           บ Data ณ  11/18/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Pr118CloseArea(cAliasQry)

If Select(cAliasQry)>0
	(cAliasQry)->(DbCloseArea())
EndIf


Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR118  บAutor  ณMicrosiga           บ Data ณ  11/18/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function MyAutoNfeEnv(cEmpresa,cFilProc,cWait,cOpc,cSerie,cNotaIni,cNotaFim)

Local aArea       := GetArea()
Local aPerg       := {}
Local lEnd        := .F.
Local aParam      := {Space(Len(SF2->F2_SERIE)),Space(Len(SF2->F2_DOC)),Space(Len(SF2->F2_DOC))}
Local aXML        := {}
Local cRetorno    := ""

Local cModalidade := ""
Local cAmbiente   := ""
Local cVersao     := ""
Local cVersaoCTe  := ""
Local cVersaoDpec := ""
Local cMonitorSEF := ""
Local cSugestao   := ""
Local cURL        := PadR(GetNewPar("MV_SPEDURL","http://"),250)
Local nX          := 0
Local lOk         := .T.
Local oWs
Local cParNfeRem  := SM0->M0_CODIGO+SM0->M0_CODFIL+"AUTONFEREM"

MV_PAR01 := aParam[01] := cSerie
MV_PAR02 := aParam[02] := cNotaIni
MV_PAR03 := aParam[03] := cNotaFim

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณObtem o ambiente de execucao do Totvs Services SPED                     ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
oWS := WsSpedCfgNFe():New()
oWS:cUSERTOKEN := "TOTVS"
oWS:cID_ENT    := cIdEnt
oWS:nAmbiente  := 0
oWS:_URL       := AllTrim(cURL)+"/SPEDCFGNFe.apw"
lOk := oWS:CFGAMBIENTE()
cAmbiente := oWS:cCfgAmbienteResult
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณObtem a modalidade de execucao do Totvs Services SPED                   ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If lOk
	oWS:cUSERTOKEN := "TOTVS"
	oWS:cID_ENT    := cIdEnt
	oWS:nModalidade:= 0
	oWS:cModelo	   := "55"
	oWS:_URL       := AllTrim(cURL)+"/SPEDCFGNFe.apw"
	lOk := oWS:CFGModalidade()
	cModalidade    := oWS:cCfgModalidadeResult
EndIf
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณObtem a versao de trabalho da NFe do Totvs Services SPED                ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If lOk
	oWS:cUSERTOKEN := "TOTVS"
	oWS:cID_ENT    := cIdEnt
	oWS:cVersao    := "0.00"
	oWS:_URL       := AllTrim(cURL)+"/SPEDCFGNFe.apw"
	lOk := oWS:CFGVersao()
	cVersao        := oWS:cCfgVersaoResult
EndIf
If lOk
	oWS:cUSERTOKEN := "TOTVS"
	oWS:cID_ENT    := cIdEnt
	oWS:cVersao    := "0.00"
	oWS:_URL       := AllTrim(cURL)+"/SPEDCFGNFe.apw"
	lOk := oWS:CFGVersaoCTe()
	cVersaoCTe     := oWS:cCfgVersaoCTeResult
EndIf
If lOk
	oWS:cUSERTOKEN := "TOTVS"
	oWS:cID_ENT    := cIdEnt
	oWS:cVersao    := "0.00"
	oWS:_URL       := AllTrim(cURL)+"/SPEDCFGNFe.apw"
	lOk := oWS:CFGVersaoDpec()
	cVersaoDpec	   := oWS:cCfgVersaoDpecResult
EndIf
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณVerifica o status na SEFAZ                                              ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If lOk
	oWS:= WSNFeSBRA():New()
	oWS:cUSERTOKEN := "TOTVS"
	oWS:cID_ENT    := cIdEnt
	oWS:_URL       := AllTrim(cURL)+"/NFeSBRA.apw"
	lOk := oWS:MONITORSEFAZMODELO()
	If lOk
		aXML := oWS:oWsMonitorSefazModeloResult:OWSMONITORSTATUSSEFAZMODELO
		For nX := 1 To Len(aXML)
			Do Case
				Case aXML[nX]:cModelo == "55"
					cMonitorSEF += "- NFe"+CRLF
					cMonitorSEF += "Versao do layout: "+cVersao+CRLF	//"Versao do layout: "
					If !Empty(aXML[nX]:cSugestao)
						cSugestao += "Sugestใo"+"(NFe)"+": "+aXML[nX]:cSugestao+CRLF //"Sugestใo"
					EndIf
					
				Case aXML[nX]:cModelo == "57"
					cMonitorSEF += "- CTe"+CRLF
					cMonitorSEF += "Versao do layout: "+cVersaoCTe+CRLF	//"Versao do layout: "
					If !Empty(aXML[nX]:cSugestao)
						cSugestao += "Sugestใo"+"(CTe)"+": "+aXML[nX]:cSugestao+CRLF //"Sugestใo"
					EndIf
			EndCase
			cMonitorSEF += Space(6)+"Versใo da mensagem"+": "+aXML[nX]:cVersaoMensagem+CRLF //"Versใo da mensagem"
			cMonitorSEF += Space(6)+"C๓digo do Status"+": "+aXML[nX]:cStatusCodigo+"-"+aXML[nX]:cStatusMensagem+CRLF //"C๓digo do Status"
			cMonitorSEF += Space(6)+"UF Origem"+": "+aXML[nX]:cUFOrigem //"UF Origem"
			If !Empty(aXML[nX]:cUFResposta)
				cMonitorSEF += "("+aXML[nX]:cUFResposta+")"+CRLF //"UF Resposta"
			Else
				cMonitorSEF += CRLF
			EndIf
			If aXML[nX]:nTempoMedioSEF <> Nil
				cMonitorSEF += Space(6)+"Tempo de espera"+": "+Str(aXML[nX]:nTempoMedioSEF,6)+CRLF //"Tempo de espera"
			EndIf
			If !Empty(aXML[nX]:cMotivo)
				cMonitorSEF += Space(6)+"Motivo"+": "+aXML[nX]:cMotivo+CRLF //"Motivo"
			EndIf
			If !Empty(aXML[nX]:cObservacao)
				cMonitorSEF += Space(6)+"Observa็ใo"+": "+aXML[nX]:cObservacao+CRLF //"Observa็ใo"
			EndIf
		Next nX
	EndIf
EndIf

Conout("[JOB  ]["+cIdEnt+"] - Iniciando transmissao NF-e de saida!")
cRetorno := SpedNFeTrf("SF2",aParam[1],aParam[2],aParam[3],cIdEnt,cAmbiente,cModalidade,cVersao   ,@lEnd,.F.,.T.)
Conout("[JOB  ]["+cIdEnt+"] - "+cRetorno)


RestArea(aArea)

Return(cRetorno)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR118  บAutor  ณMicrosiga           บ Data ณ  11/18/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Semaforo(lTipo,nHdl,cArq)
Local lRet		:=	.f.
Local cSemaf	:=	"SEMAFORO\"+cArq+".LCK"

If lTipo
	nHdl := MSFCREATE(cSemaf,1 + 16)
	lRet := nHdl > 0
Else
	lRet :=	Fclose(nHdl)
	Ferase(cSemaf)
EndIf

Return(lRet)



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR118  บAutor  ณMicrosiga           บ Data ณ  11/18/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Pr118PDF(cNrLote)
Local aDevice:={}
Local cSession
Local nLocal
Local nOrientation
Local cDevice
Local nPrintType
Local cDirDanfe:=Alltrim(U_MyNewSX6("NC_GATIDIR","C:\GATI_DANFE\","C","Diretorio do DANFE","","",.F. ))
Local cPathPDF:=cDirDanfe+cNrLote+"\"

MakeDir(cPathPDF)



lAdjustToLegacy:=.F.
lDisabeSetup:=.F.
cFilePrint:="Danfe_NF_"+SF2->F2_DOC+"-"+SF2->F2_SERIE+" Pedido_"+Posicione("SD2",3,SF2->(F2_FILIAL+F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA),"D2_PEDIDO")+".pdf"

oDanfe:=FWMsPrinter():New(cFilePrint,IMP_PDF,.F.,cPathPDF,.T.,.F.,Nil,,.F.,.F.,.F.,.F.,001)
oDanfe:cPathPDF := cPathPDF

IncProc("Salvando PDF DANFE Nota  "+SF2->F2_DOC)

If !IsReady()
	PR118Obs(AllTrim( StrTran( GetWscError(1),CRLF," ") ))
Else
	u_PrtNfeSef(cIdEnt,,,oDanfe, , cFilePrint)
EndIf
oDanfe:=Nil

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR118  บAutor  ณMicrosiga           บ Data ณ  11/19/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PR118Obs(cObservacao)
PA7->(RecLock("PA7",.F.))
PA7->PA7_OBS:=cObservacao
PA7->(MsUnLock())
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR118  บAutor  ณMicrosiga           บ Data ณ  11/21/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PR118Init(cNrLote,nOpc)

If nOpc<>2
	Processa( {|lEnd| PR118Exec(cNrLote,@lEnd) },"Lote Gati","Gerando Notas",.T.   )
	oGetPA7DB:ForceRefresh()
Else
	oTimer:Activate()
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR118  บAutor  ณMicrosiga           บ Data ณ  11/21/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PR118SetStatus(cNrLote)
Local aAreaAtu:=GetArea()
Local aAreaPA7:=PA7->(GetArea())
Local aAreaP07:=P07->(GetArea())
Local cStatus
Local cChavePA7
P07->(DbSetOrder(1))//P07_FILIAL+P07_LOTE+DTOS(P07_DTLOTE)+P07_HRLOTE+P07_USLOTE
If P07->(DbSeek(xFilial("P07")+cNrLote  ))
	
	PA7->(DbSetOrder(5))//PA7_FILIAL+PA7_LOTE+PA7_STATUS
	cStatus:="2"
	cChavePA7:=xFilial("PA7")+cNrLote
	PA7->(DbSeek(cChavePA7))
	Do While PA7->(!Eof()) .And. PA7->(PA7_FILIAL+PA7_LOTE)==cChavePA7
		If !PA7->PA7_STATUS$'3*E'
			cStatus:="1";Exit
		EndIf
		PA7->(DbSkip())
	EndDo
	
	Begin Transaction
	P07->(RecLock("P07",.F.))
	P07->P07_STATUS:=cStatus
	P07->(MsUnLock())
	End Transaction
	
EndIf



RestArea(aAreaPA7)
RestArea(aAreaP07)
RestArea(aAreaAtu)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR118  บAutor  ณMicrosiga           บ Data ณ  11/13/15   บฑฑ
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
Local aRotina :={}

AADD(aRotina,{"Pesquisar"	,""			 ,0,1})
AADD(aRotina,{"Visualizar"	,"U_PR118BRW",0,2})
AADD(aRotina,{"Processar"	,"U_PR118BRW",0,4})
AADD(aRotina,{"Legenda","U_PR118LEG()"   ,0,2})
AADD(aRotina,{"Imprimir","U_PR118PRINT()"   ,0,2})

Return aRotina


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR118  บAutor  ณMicrosiga           บ Data ณ  11/21/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PR118LEG()
Local aCor := {}
aAdd(aCor,{"BR_BRANCO"	,"Nใo Iniciado"	})
aAdd(aCor,{"BR_VERMELHO","Nใo Concluํdo"})
aAdd(aCor,{"BR_VERDE"	,"Concluํdo"	})

BrwLegenda(,"Status",aCor)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR118  บAutor  ณMicrosiga           บ Data ณ  11/25/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PR118PRINT()
Local aAreaAtu	   :=GetArea()
Local cPerg  		:= 'NCGPR118'
Local cQryAlias 	:= GetNextAlias()
Local oReport

CriaSx1(cPerg)
Pergunte(cPerg, .F.)

oReport := ReportDef(cQryAlias, cPerg)
oReport:PrintDialog()

If Select(cQryAlias)>0
	(cQryAlias)->(DbCloseArea())
EndIf

RestArea(aAreaAtu)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR118  บAutor  ณMicrosiga           บ Data ณ  11/25/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ReportDef(cQryAlias,cPerg)
Local cTitle  := "Relat๓rio Lote GATI nใo concluido"
Local cHelp   := "Permite gerar relat๓rio Lote GATI nใo concluido"
Local oReport
Local oSection1
Local aOrdem    := {}

oReport := TReport():New('NCGPR118',cTitle,cPerg,{|oReport| ReportPrint(oReport,cQryAlias,aOrdem)},cHelp)
oSection1 := TRSection():New(oReport,"Lote GATI",{"PA7","P07"},aOrdem)

TRCell():New(oSection1,"P07_LOTE" 	, cQryAlias, "Lote")
TRCell():New(oSection1,"P07_DTLOTE" , cQryAlias, "Data")
TRCell():New(oSection1,"P07_HRLOTE" , cQryAlias, "Hora")
TRCell():New(oSection1,"P07_USLOTE" , cQryAlias, "Usuario")

TRCell():New(oSection1,"PA7_PEDIDO" , cQryAlias, "Pedido")
TRCell():New(oSection1,"PA7_PVSITE" , cQryAlias, "PV Site")
TRCell():New(oSection1,"PA7_CLIENT" , cQryAlias, "Cliente")
TRCell():New(oSection1,"PA7_LOJA"   , cQryAlias, "Loja")
TRCell():New(oSection1,"PA7_NOTA" 	, cQryAlias, "Nota")
TRCell():New(oSection1,"PA7_SERIE" 	, cQryAlias, "Serie")
TRCell():New(oSection1,"PA7_OBS" 	, cQryAlias, "Obs. SEFAZ")

Return(oReport)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR118  บAutor  ณMicrosiga           บ Data ณ  11/25/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ReportPrint(oReport,cQryAlias,aOrdem)
Local oSecao1 := oReport:Section(1)
Local nOrdem  := oSecao1:GetOrder()
Local cOrderBy

/*
oReport:SetTitle(oReport:Title()+' (' + AllTrim(aOrdem[nOrdem]) + ')')


cOrderBy := "%"
If nOrdem == 1 //-- Por Produto+Local
cOrderBy += "ZZX_PRODUT,ZZX_LOCAL"
ElseIf nOrdem == 2 //-- Por Local+Produto
cOrderBy += "ZZX_LOCAL,ZZX_PRODUT"
EndIf
cOrderBy += "%"
*/

cOrderBy := "%PA7_LOTE DESC%"

oSecao1:BeginQuery()

BeginSQL Alias cQryAlias
	
	COLUMN P07_DTLOTE AS DATE
	
	SELECT *
	FROM %Table:P07% P07,%Table:PA7% PA7
	WHERE P07_FILIAL = %xfilial:P07%
	AND P07_LOTE BETWEEN '     ' AND 'ZZZZZZZ'
	AND P07_STATUS<>'2'
	AND P07.%notDel%
	AND PA7_FILIAL = %xfilial:PA7%
	AND PA7_LOTE=P07_LOTE
	AND PA7_NOTA<>' '
	AND PA7_STATUS NOT IN ('E','3')
	AND PA7.%notDel%
	ORDER BY %Exp:cOrderBy%
	
EndSQL
oSecao1:EndQuery()
oReport:SetMeter(0)
oSecao1:Print()
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR113  บAutor  ณMicrosiga           บ Data ณ  11/13/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static function criaSX1(cPerg)
//PutSx1(cPerg,"01","Do Lote                    	","","","MV_CH1","C",09,0,0,"G","","P07","   "," ","MV_PAR01","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")
//PutSx1(cPerg,"02","Ate Lote                    	","","","MV_CH2","C",09,0,0,"G","","P07","   "," ","MV_PAR02","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")

Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR118  บAutor  ณMicrosiga           บ Data ณ  11/26/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PR118PV()
Local aAreaAtu:=GetArea()
Local aAreaSC5:=SC5->(GetArea())
Local  aRotAtu:=aClone(aRotina)
Local aDados:={INCLUI,ALTERA}

aRotina := {	{ OemToAnsi("Pesquisar"),"AxPesqui"		,0,1,0 ,.F.},{ OemToAnsi("Visual"),"A410Visual"	,0,2,0 ,NIL}}

SC5->(DbSetOrder(1))
If SC5->(DbSeek(xFilial("SC5") + PA7->PA7_PEDIDO ))
	A410Visual("SC5",SC5->(Recno()),2)
	INCLUI:=aDados[1]
	ALTERA:=aDados[2]
EndIf

aRotina:=aClone(aRotAtu)
RestArea(aAreaSC5)
RestArea(aAreaAtu)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR118  บAutor  ณMicrosiga           บ Data ณ  11/26/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PR118NF()
Local aAreaAtu:=GetArea()
Local aAreaSF2:=SF2->(GetArea())
Local  aRotAtu:=aClone(aRotina)
Local aDados:={INCLUI,ALTERA}

aRotina := {	{ "Pesquisar","AxPesqui"		,0,1,0,.F.},	{ "Visualizar","MC090Visual"	,0,2,0,NIL}}		//


SF2->(DbSetOrder(1))
If SF2->(DbSeek(xFilial("SF2") + PA7->(PA7_NOTA+PA7_SERIE) ))
	Mc090Visual("SF2",SF2->(Recno()),2)
	INCLUI:=aDados[1]
	ALTERA:=aDados[2]
Else
	MsgStop("Nota nใo encontrada","NcGames")
EndIf

aRotina:=aClone(aRotAtu)
RestArea(aAreaSF2)
RestArea(aAreaAtu)
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR118  บAutor  ณMicrosiga           บ Data ณ  12/18/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PR118WMS(cPedido,cErroWMS)
Local aArea		:= GetArea()
Local cAlias	:= GetNextAlias()
Local cQry		:= ""
Local cTpEst	:= ""
Local cProdWms	:= ""
Local cCodChvPd	:= ""
Local nCont		:= 0
Local nTamprod	:= TamSx3("C9_PRODUTO")[1]
Local nTamLoc	:= TamSx3("C9_LOCAL")[1]
Local cArmz		:= SuperGetMV("MV_ARMWMAS")
Local lRet		:= .T.
Local aDadosWMS	:= {}
Local aDadosC9	:= {}



//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณQUERY COM ITENS SELECIONADOS PARA NF CONTROLADOS WMS     ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
cQry := " SELECT C9_PEDIDO, C9_PRODUTO, C9_LOCAL, sum(C9_QTDLIB) QTDLIB
cQry += " FROM "+RetSqlName("SC9")+" SC9
cQry += " WHERE C9_FILIAL = '"+xFilial("SC9")+"'"
cQry += " AND C9_PEDIDO ='"+cPedido+"'"
cQry += " AND C9_NFISCAL = ' ' "
cQry += " AND C9_BLEST = ' ' "
cQry += " AND C9_BLCRED = ' ' "
cQry += " And C9_BLWMS=' '""
cQry += " AND C9_LOCAL IN "+FORMATIN(cArmz,"/")
cQry += " AND D_E_L_E_T_ = ' ' "


//*****************************************************************
//Tratamento para considerar apenas os itens com controle de estoque - 02/12/2013
cQry += "  AND SC9.C9_FILIAL||SC9.C9_PEDIDO||SC9.C9_ITEM NOT IN(SELECT C6_FILIAL||C6_NUM||C6_ITEM "
cQry += " 	FROM "+RetSqlName("SC6")+" C6, "+RetSqlName("SF4")+" F4 "
cQry += " 	WHERE C6.D_E_L_E_T_ = ' ' "
cQry += " 	AND F4.D_E_L_E_T_ = ' ' "
cQry += " 	AND F4.F4_FILIAL = '"+xFilial("SF4")+"' "
cQry += " 	AND C6.C6_FILIAL = '"+xFilial("SC6")+"' "
cQry += " 	AND C6.C6_TES = F4.F4_CODIGO "
cQry += " 	AND F4.F4_ESTOQUE = 'N' "
cQry += " 	AND C6_NUM ='"+cPedido+"')"
//*****************************************************************
cQry += " GROUP BY C9_PEDIDO, C9_PRODUTO, C9_LOCAL
cQry := ChangeQuery(cQry)
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),cAlias,.T.,.T.)
(cAlias)->(dbGoTop())
While (cAlias)->(!Eof())
	cCodChvPd	:= xFilial("SC9")+(cAlias)->C9_PEDIDO
	aadd(aDadosC9,{(cAlias)->C9_PRODUTO,(cAlias)->C9_LOCAL,(cAlias)->QTDLIB,""})
	(cAlias)->(DbSkip())
End
(cAlias)->(DbCloseArea())

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณQUERY COM ITENS SELECIONADOS PARA NF                     ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
cQry := " SELECT CS_COD_DEPOSITO, CS_COD_DEPOSITANTE, CS_COD_PRODUTO CODPRODWMS, CS_COD_TIPO_ESTOQUE TPESTWMS, SUM(CS_QTDE_SEPARADA) QTDE
cQry += " FROM WMS.TB_WMSINTERF_CONF_SEPARACAO
cQry += " WHERE CS_COD_CHAVE = '"+alltrim(cCodChvPd)+"' AND CS_COD_DEPOSITO = "+alltrim(str(val(cEmpAnt)))
cQry += " GROUP BY CS_COD_DEPOSITO, CS_COD_DEPOSITANTE, CS_COD_PRODUTO, CS_COD_TIPO_ESTOQUE
cQry := ChangeQuery(cQry)
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),cAlias,.T.,.T.)
(cAlias)->(dbGoTop())
While (cAlias)->(!Eof())
	cProdWms:= Padr((cAlias)->CODPRODWMS,nTamProd)
	cTpEst	:= strzero((cAlias)->TPESTWMS,nTamLoc)
	If (nPos := aScan(aDadosC9,{|x| x[1]+x[2] == cProdWms+cTpEst})) > 0
		aDadosC9[nPos,3] -= (cAlias)->QTDE
	Else
		aadd(aDadosC9,{cProdWms,cTpEst,-(cAlias)->QTDE,""})
	EndIf
	(cAlias)->(DbSkip())
End
(cAlias)->(DbCloseArea())

nCont	:= 0
For nInd:=1 To Len(aDadosC9)
	If (nAscan:=Ascan(aDadosC9,{|a| a[3]==0}))>0
		Adel(aDadosC9,nAscan)
		aSize(aDadosC9,Len(aDadosC9)-1)
		
	EndIf
Next nInd

cErroWMS:=""
lRet:=len(aDadosC9)==0
For nx:=1 to len(aDadosC9)
	If aDadosC9[nx,3] > 0
		cErroWMS+= "Produto "+AllTrim(aDadosC9[nx][1])+" Quantidade a maior na NF/"
	Else
		cErroWMS+= "Produto "+AllTrim(aDadosC9[nx][1])+" Quantidade a maior no WMS*"
	EndIf
	cErroWMS:=Left(cErroWMS,Len(cErroWMS)-1)
Next nx

RestArea(aArea)
Return lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR118  บAutor  ณMicrosiga           บ Data ณ  01/20/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function PR118NFGRV(aDados)
Local aPvlNfs	:=aDados[3]
Local cSerieNf	:=aDados[4]
Local cNotaFiscal
Local aCabec:={}
Local cFilSC5:=xFilial("SC5")


SetFunName("MATA461")
Pergunte("MT460A",.F.)
mv_par24:=1 //Gera Guia ICM Compl. UF Dest.?
mv_par25:=1//Gera Guia FECP da UF Destino? 

//MaPvlNfs(aPvlNfs,cSerieNFS,lMostraCtb,lAglutCtb,lCtbOnLine,lCtbCusto,lReajuste,nCalAcrs,nArredPrcLis,lAtuSA7,lECF,cEmbExp,bAtuFin,bAtuPGerNF,bAtuPvl,bFatSE1,dDataMoe)
cNotaFiscal := 	MaPvlNfs(aPvlNfs,cSerieNf,.F.,.F.,.F.,.F.,.F.,1,1,.F.,.F.,,,,)


Return cNotaFiscal
