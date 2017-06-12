#INCLUDE "rwmake.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGA006   บ Autor ณ AP6 IDE            บ Data ณ  09/09/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Codigo gerado pelo AP6 IDE.                                บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

User Function NCGA006()

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de Variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

Private cCadastro := "Amarra็ใo Grupo de Clientes x NCM x Filial de Faturamento"

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Monta um aRotina proprio                                            ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

Private aRotina := { {"Pesquisar","AxPesqui",0,1} ,;
						{"Visualizar","u_GA006MNT",0,2} ,;
						{"Incluir","AxInclui",0,3} ,; 
						{"Manuten็ใo","u_GA006MNT",0,4} }
						
Private cDelFunc := ".T." // Validacao para a exclusao. Pode-se utilizar ExecBlock


dbSelectArea("ACY")
dbSetOrder(1)
mBrowse( 6,1,22,75,"ACY")


Return

//*************************************
//Processamento da rotina de manuten็ใo
//*************************************
User Function GA006MNT(cAlias, nRecno, nOpc)

Local aArea     := GetArea()
Local aRecNo    := {}
Local aSize     := MsAdvSize(.T.)
Local aObjects  := {}
Local aInfo     := {}
Local nOpcA    	:= 0
Local nCntFor  	:= 0
Local nUsado   	:= 0
Local nColFreeze:= 1
Local lFreeze	:= .F.
Local aCpos1   := {}
Local aCpos2   := {}
Local cAliasPZ3 := "PZ3"
Local lQuery    := .F.
Local oDlg
Local nIndex := 0
Local cSeek  	:= Nil
Local cWhile 	:= Nil

Local lFt150Grv	:= ExistBlock("FT150GRV")
Local aFt150CpoCab	:= {} // Campos do Cabecalho da tela (enchoice)

Local aVisual := {}
Local aAltera := {}
Local oEnch

Local cQuery    := ""
Local aStruPZ3  := {}
Local cFt150Seq	:= ""

Local aNoFields  := {}
Local aYesFields := {}
Local nOpcAux	 := 0

PRIVATE bRefresh	:= {|| oGetd:oBrowse:Refresh() }	// Bloco de codigo que sera chamado na funcao
PRIVATE aHeader 	:= {}
PRIVATE aCols   	:= {}
PRIVATE oGetD		
RegToMemory(cAlias,INCLUI)

dbSelectArea( "ACY" )

cQuery := "SELECT * "
cQuery += "FROM "+RetSqlName("ACY")+" PZ3 "
cQuery += "WHERE "
cQuery += "PZ3.PZ3_FILIAL = '"+xFilial("PZ3")+"' AND "
cQuery += "PZ3.PZ3_GRPCLI ='"+M->ACY_GRPVEN+"' AND "
cQuery += "PZ3.D_E_L_E_T_= ' ' "
cQuery += "ORDER BY "+SqlOrder(PZ3->(IndexKey(1)))
cQuery := ChangeQuery(cQuery)

cSeek  := xFilial("PZ3") + PZ3->PZ3_GRPCLI
cWhile :="PZ3->PZ3_FILIAL + PZ3->PZ3_GRPCLI"

DbSelectArea("ACY")
DbCloseArea()

aNoFields:={}

nIndex := 1
cSeek  := xFilial("PZ3") + M->ACY_GRPVEN
cWhile := "PZ3->PZ3_FILIAL + PZ3->PZ3_GRPCLI"


If nOpc == 3 .Or. nOpc == 4
	nOpcAux := GD_INSERT + GD_UPDATE + GD_DELETE
Else
	nOpcAux := 0
EndIf



FillGetDados(	nOpc 		, "PZ3", nIndex, cSeek,;
{||&(cWhile)}, /*{|| bCond,bAct1,bAct2}*/, aNoFields,;
/*aYesFields*/, /*lOnlyYes*/, /*/cQuery/*/, /*bMontAcols*/, IIf(nOpc<>3,.F.,.T.),;
/*aHeaderAux*/, /*aColsAux*/,/*bAfterCols*/ , /*bBeforeCols*/,;
/*bAfterHeader*/, "PZ3")


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Ativa a Dialog.                                      ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
aAdd( aObjects, { 100, 15, .T., .T. })
aAdd( aObjects, { 100, 85, .T., .T. })
aInfo := { aSize[ 1 ], aSize[ 2 ], aSize[ 3 ], aSize[ 4 ], 5, 5 }
aPosObj := MsObjSize( aInfo, aObjects,.T.)
DEFINE MSDIALOG oDlg TITLE cCadastro From aSize[7],0 To aSize[6],aSize[5] of oMainWnd PIXEL
//-- Monta a enchoice.
EnChoice( cAlias, nRecno, nOpc, , , , , aPosObj[1],aCpos2,3)
//oGetd := MsGetDados():New(aPosObj[2,1],aPosObj[2,2],aPosObj[2,3],aPosObj[2,4],nOpc                 ,"u_GA006Linok"       , "u_GA006Tok" ,"",   ,/*aCpos1*/,nColFreeze,,     ,,,,,,lFreeze)
oGetd := MsNewGetDados():New(aPosObj[2,1],aPosObj[2,2],aPosObj[2,3],aPosObj[2,4], nOpcAux ,"u_GA006Linok","u_GA006Tok","",,,9999,"AllWaysTrue()",,,,aHeader,aCols)

ACTIVATE MSDIALOG oDlg ON INIT EnchoiceBar(oDlg, {||If(oGetD:TudoOk(),(nOpcA:= 1,oDlg:End()),.T.)},{||oDlg:End()})
//ACTIVATE MSDIALOG oDlg ON INIT EnchoiceBar(oDlg,{||If(oGetD:TudoOk(),(nOpcA:= 1,oDlg:End()),.T.)},{||oDlg:End()})

If nOpcA == 1
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Funcao responsavel pela atualizacao do arquivo ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	BEGIN TRANSACTION
	
	//oGetd:ForceRefresh()
	GA006Grv()

	END TRANSACTION	
	
	
EndIf
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Restaura a Integridade da Tela de Entrada.                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
RestArea(aArea)

Return(.T.)


//********************
//Valida็ใo do linok
//********************
User Function GA006Linok

Local lResult	:= .T.
Local nX		:= 0
Local nUsado    := Len(aHeader)
Local nPGrupo   := aScan(aHeader, {|x|AllTrim(x[2])=='PZ3_GRPCLI'})
Local nPNCM		:= aScan(aHeader, {|x|AllTrim(x[2])=='PZ3_POSIPI'})
Local nPCodcli  := aScan(aHeader, {|x|AllTrim(x[2])=='PZ3_CODCLI'})
Local nPLojacli := aScan(aHeader, {|x|AllTrim(x[2])=='PZ3_LOJA'})
Local nPFilFat	:= aScan(aHeader, {|x|AllTrim(x[2])=='PZ3_FILFAT'})
Local cGrupo    := ""
Local cNCM  	:= " "
Local cCodcli  	:= " "
Local cLojacli  := " "
Local cFilFat  	:= " "

If nPGrupo > 0
	cGrupo   := oGetd:aCols[n][nPGrupo]
EndIf
If nPNCM > 0
	cNCM := oGetd:aCols[n][nPNCM]
EndIf
If nPCodcli > 0
	cCodcli := oGetd:aCols[n][nPCodcli]
EndIf
If nPLojacli > 0
	cLojacli := oGetd:aCols[n][nPLojacli]
EndIf
If nPFilFat > 0
	cFilFat := oGetd:aCols[n][nPFilFat]
EndIf


If Empty( cGrupo + cNCM + cFilFat ) .And. !oGetd:aCols[n][nUsado+1]
	Help(' ', 1, 'OBRIGAT')
	lResult := .F.
Else
	//valida็ใo do cliente x grupo de clientes
	If !Empty(cCodcli) .and. !Empty(cLojacli)
		If !(getadvfval("SA1","A1_GRPVEN",xFilial("SA1")+cCodcli+cLojacli,1,"") == cGrupo)
			Help(' ', 1, 'NAOPERM')
			lResult := .F.
		EndIf
	ElseIf !Empty(cCodcli)
		If !(getadvfval("SA1","A1_GRPVEN",xFilial("SA1")+cCodcli,1,"") == cGrupo)
			Help(' ', 1, 'NAOPERM')
			lResult := .F.
		EndIf
	EndIf
	
	If lResult .And. !oGetd:aCols[N][nUsado + 1]		
		For nX := 1 To Len( oGetd:aCols )
			If ( nX != n .And. !oGetd:aCols[nX][nUsado + 1] )
				If oGetd:aCols[nX,nPGrupo]+oGetd:aCols[nX,nPNCM]+oGetd:aCols[nX,nPCodcli]+oGetd:aCols[nX,nPLojacli]+oGetd:aCols[nX,nPFilFat] == cGrupo+cNCM+cCodcli+cLojacli+cFilFat
					Help(' ', 1, 'JAGRAVADO')
					lResult := .F.
					Exit
				EndIf				
			EndIf
		Next nX
	EndIf
EndIf
Return lResult

//********************
//Valida็ใo do tudook
//********************
User Function GA006Tok

Local lResult	:= .T.

Return lResult




//********************
//Grava็ใo do cadastro
//********************
Static Function GA006Grv()

Local nX       	:= 0 					//Utilizada no contador do For
Local lGravou  	:= .T.
Local nUsado   	:= Len(aHeader)
Local nPGrupo   := aScan(aHeader, {|x|AllTrim(x[2])=='PZ3_GRPCLI'})
Local nPNCM		:= aScan(aHeader, {|x|AllTrim(x[2])=='PZ3_POSIPI'})
Local nPCodcli  := aScan(aHeader, {|x|AllTrim(x[2])=='PZ3_CODCLI'})
Local nPLojacli := aScan(aHeader, {|x|AllTrim(x[2])=='PZ3_LOJA'})
Local nPFilFat	:= aScan(aHeader, {|x|AllTrim(x[2])=='PZ3_FILFAT'})

DbSelectArea("PZ3")
DbSetOrder(1)
For nX := 1 To Len(oGetd:aCols)

		//PZ3_FILIAL+PZ3_GRPCLI+PZ3_CODCLI+PZ3_LOJA+PZ3_POSIPI
		If DbSeek(xFilial("PZ3")+oGetd:aCols[nX,nPGrupo]+oGetd:aCols[nX,nPCodcli]+oGetd:aCols[nX,nPLojacli]+oGetd:aCols[nX,nPNCM])
			If oGetd:aCols[nX,Len(aHeader)+1]//Exclusใo
				PZ3->(Reclock("PZ3",.F.))
				PZ3->(DbDelete())
				PZ3->(msunlock())
			Else//Altera็ใo
				PZ3->(reclock("PZ3",.F.))
				PZ3->PZ3_FILFAT	:= oGetd:aCols[nX,nPFilFat]			
				PZ3->(msunlock())
			EndIf
		Else
			PZ3->(reclock("PZ3",.T.))
			PZ3->PZ3_FILIAL	:= xFilial("PZ3")		
			PZ3->PZ3_GRPCLI	:= oGetd:aCols[nX,nPGrupo]
			PZ3->PZ3_CODCLI	:= oGetd:aCols[nX,nPCodcli]
			PZ3->PZ3_LOJA	:= oGetd:aCols[nX,nPLojacli]
			PZ3->PZ3_POSIPI	:= oGetd:aCols[nX,nPNCM]
			PZ3->PZ3_FILFAT	:= oGetd:aCols[nX,nPFilFat]			
			PZ3->(msunlock())
		EndIf

Next nX

Return(lGravou)



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออหอออออออัออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณ	FilClxGr	 บ Autor ณ Elton C.	 บ Data ณ  04/09/13   	  บฑฑ
ฑฑฬออออออออออุออออออออออออสอออออออฯออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Filtra os clientes cadastrados para o grupo de clientes.	  บฑฑ
ฑฑบ          ณ Utilizado na consulta padrใo								  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function FilClxGr()

	Local cQry		:= ""
	Local cCodGrp	:= GdFieldGet("PZ3_GRPCLI")//Retorna o codigo do grupo posicionado
	
	//Local nPosPjt	:= aScan(aHeader,{|x| AllTrim(x[2])=="PZ3_CODCLI"})
	//Local cProjeto	:= Alltrim(aCols[nMain,nPosPjt])

	
		If !Empty(cCodGrp)	
		
			cQry += "@ A1_GRPVEN = '"+cCodGrp+"' "
			
			//Aviso("Qeury",cQry,{"Ok"},3)
        EndIf

Return cQry

