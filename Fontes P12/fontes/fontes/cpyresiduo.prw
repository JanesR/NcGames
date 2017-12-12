#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#DEFINE ITENSSC6 300

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³CPYRESIDUO³ Autor ³ Rodrigo Okamoto       ³ Data ³20/11/2010³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Prepara a funcao de copia para evitar que seja chamada a   ³±±
±±³          ³ janela de filiais                                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpC1: Alias do cabecalho do pedido de venda                ³±±
±±³          ³ExpN2: Recno do cabecalho do pedido de venda                ³±±
±±³          ³ExpN3: Opcao do arotina                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nenhum                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Function U_CPYRESIDUO(cAlias,nReg,nOpc)

Local aRotBkp := aClone(aRotina)

aRotina := { { OemToAnsi("Pesquisar"),"AxPesqui"  ,0,1},;		//"Pesquisar"
{ OemToAnsi("Visual"),"A410Visual",0,2},;		//"Visual"
{ OemToAnsi("Incluir"),"U_CPYRESD",0,3}}		//"Incluir"

lContCPY	:= u_ContCPY()

IF lContCPY
	U_CPYRESD(calias,nReg,3)
ENDIF

aRotina := aClone(aRotBkp)

Return(.T.)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³U_CPYRESD ³Autor  ³Rodrigo Okamoto        ³ Data ³20.11.2010³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Copia do Pedido de Venda                                    ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpC1: Alias do cabecalho do pedido de venda                ³±±
±±³          ³ExpN2: Recno do cabecalho do pedido de venda                ³±±
±±³          ³ExpN3: Opcao do arotina                                     ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Esta rotina tem como objetivo efetuar a interface com o usua³±±
±±³          ³rio e o pedido de vendas                                    ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Observacao³                                                            ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Materiais/Distribuicao/Logistica                           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Function U_CPYRESD(cAlias,nReg,nOpc)

Local aArea     := GetArea()
Local aPosObj   := {}
Local aObjects  := {}
Local aSize     := {}
Local aPosGet   := {}
Local aRegSC6   := {}
Local aRegSCV   := {}
Local aInfo     := {}
Local lLiber 	:= .F.
Local lTransf	:= .F.
Local lGrade	:= MaGrade()
Local lQuery    := .F.
Local lContinua := .T.
Local lFreeze   := (SuperGetMv("MV_PEDFREZ",.F.,0) <> 0)
Local nOpcA		:= 0
Local nTotalPed := 0
Local nTotalDes := 0
Local nNumDec   := TamSX3("C6_VALOR")[2]
Local nGetLin   := 0
Local nStack    := GetSX8Len()
Local nColFreeze:= SuperGetMv("MV_PEDFREZ",.F.,0)
Local cArqQry   := "SC6"
Local cCadastro := OemToAnsi("Atualização de Pedidos de Venda") //"Atualiza‡„o de Pedidos de Venda"
Local cTipoDat  := SuperGetMv("MV_TIPCPDT",.F.,"1")
Local oDlg
Local oGetd
Local dOrig     := Ctod("//")
Local dCopia    := Ctod("//")
Local oSAY1
Local oSAY2
Local oSAY3
Local oSAY4
Local lMt410Ace := Existblock("MT410ACE")

Local cSeek     := ""
Local aNoFields := {"C6_NUM","C6_QTDEMP","C6_QTDENT","C6_QTDEMP2","C6_QTDENT2"}		// Campos que nao devem entrar no aHeader e aCols
Local bWhile    := {|| }
Local cQuery    := ""
Local bCond     := {|| .T. }
Local bAction1  := {|| Mta410Cop(cArqQry,@nTotalPed,@nTotalDes,lGrade) }
Local bAction2  := {|| .T. }
Local lCopia    := .T.

PRIVATE cPedRes	:=	SC5->C5_NUM
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas na LinhaOk                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE aCols      := {}
PRIVATE aHeader    := {}
PRIVATE aHeadFor   := {}
PRIVATE aColsFor   := {}
PRIVATE N          := 1

PRIVATE aGEMCVnd :={"",{},{}} //Template GEM - Condicao de Venda

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta a entrada de dados do arquivo                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE aTELA[0][0],aGETS[0]

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ponto de entrada para validar acesso do usuario na funcao ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//If lMt410Ace
//	lContinua := Execblock("MT410ACE",.F.,.F.,{nOpc})
//Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria Ambiente/Objeto para tratamento de grade        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If FindFunction("MsMatGrade") .And. IsAtNewGrd()
	//MsMatGrade():New(cObj,cProdRef,cCpo,cTudoOk,cVldCpoGrd,aSetKey,aCposCtrlGrd,lShowGrd)
	PRIVATE oGrade	  := MsMatGrade():New('oGrade',,"C6_QTDVEN",,"a410GValid()",;
	{ 	{VK_F4,{|| A440Saldo(.T.,oGrade:aColsAux[oGrade:nPosLinO][aScan(oGrade:aHeadAux,{|x| AllTrim(x[2])=="C6_LOCAL"})])}} },;
	{ 	{"C6_QTDVEN",.T.,{{"C6_UNSVEN",{|| ConvUm(AllTrim(oGrade:GetNameProd(,nLinha,nColuna)),aCols[nLinha][nColuna],0,2) } }} },;
	{"C6_QTDLIB",NIL,NIL},;
	{"C6_QTDENT",NIL,NIL},;
	{"C6_ITEM"	,NIL,NIL},;
	{"C6_UNSVEN", {{"C6_QTDVEN",{|| ConvUm(AllTrim(oGrade:GetNameProd(,nLinha,nColuna)),0,aCols[nLinha][nColuna],1) }}} },;
	{"C6_BLQ",NIL,NIL};
	})
Else
	PRIVATE aColsGrade := {}
	PRIVATE aHeadgrade := {}
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Carrega perguntas do MATA440 e MATA410                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
INCLUI := .T.
ALTERA := .F.

Pergunte("MTA440",.F.)
lLiber := MV_PAR02 == 1
lTransf:= MV_PAR01 == 1
Pergunte("MTA410",.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variavel utilizada p/definir Op. Triangulares.       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
IsTriangular( MV_PAR03==1 )
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Salva a integridade dos campos de Bancos de Dados    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea(cAlias)
IF ( (ExistBlock("M410ALOK")) )
	If (! ExecBlock("M410ALOK",.F.,.F.) )
		lContinua := .F.
	EndIf
EndIf
IF ( SC5->C5_FILIAL <> xFilial("SC5") )
	Help(" ",1,"A000FI")
	lContinua := .F.
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//| Se o Pedido foi originado no SIGATMS - Nao Copia     |
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If SC5->(FieldPos("C5_SOLFRE")) > 0 .And. !Empty(SC5->C5_SOLFRE)
	Help(" ",1,"A410TMSNAO")
	lContinua := .F.
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa desta forma para criar uma nova instancia de variaveis private ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
RegToMemory( "SC5", .F., .F. )

dOrig  := M->C5_EMISSAO
dCopia := CriaVar("C5_EMISSAO",.T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Limpa as variaveis que possuem amarracoes do pedido anterior              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
M->C5_NOTA  := Space(Len(SC5->C5_NOTA))
M->C5_SERIE := Space(Len(SC5->C5_SERIE))
M->C5_OS    := Space(Len(SC5->C5_OS))
M->C5_ORIGRES := cPedRes


If ( lContinua )
	dbSelectArea("SC6")
	dbSetOrder(1)
	#IFDEF TOP
		If TcSrvType()<>"AS/400" .And. !InTransact() .And. Ascan(aHeader,{|x| x[8] == "M"}) == 0
			lQuery  := .T.
			cQuery := "SELECT SC6.*,SC6.R_E_C_N_O_ SC6RECNO "
			cQuery += "FROM "+RetSqlName("SC6")+" SC6 "
			cQuery += "WHERE SC6.C6_FILIAL='"+xFilial("SC6")+"' AND "
			cQuery += "SC6.C6_NUM='"+SC5->C5_NUM+"' AND "
			cQuery += "SC6.D_E_L_E_T_<>'*' "
			cQuery += "ORDER BY "+SqlOrder(SC6->(IndexKey()))
			
			dbSelectArea("SC6")
			dbCloseArea()
		EndIf
	#ENDIF
	cSeek  := xFilial("SC6")+SC5->C5_NUM
	bWhile := {|| C6_FILIAL+C6_NUM }
	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Montagem do aHeader e aCols                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³FillGetDados( nOpcx, cAlias, nOrder, cSeekKey, bSeekWhile, uSeekFor, aNoFields, aYesFields, lOnlyYes,       ³
//³				  cQuery, bMountFile, lInclui )                                                                ³
//³nOpcx			- Opcao (inclusao, exclusao, etc).                                                         ³
//³cAlias		- Alias da tabela referente aos itens                                                          ³
//³nOrder		- Ordem do SINDEX                                                                              ³
//³cSeekKey		- Chave de pesquisa                                                                            ³
//³bSeekWhile	- Loop na tabela cAlias                                                                        ³
//³uSeekFor		- Valida cada registro da tabela cAlias (retornar .T. para considerar e .F. para desconsiderar ³
//³				  o registro)                                                                                  ³
//³aNoFields	- Array com nome dos campos que serao excluidos na montagem do aHeader                         ³
//³aYesFields	- Array com nome dos campos que serao incluidos na montagem do aHeader                         ³
//³lOnlyYes		- Flag indicando se considera somente os campos declarados no aYesFields + campos do usuario   ³
//³cQuery		- Query para filtro da tabela cAlias (se for TOP e cQuery estiver preenchido, desconsidera     ³
//³	           parametros cSeekKey e bSeekWhile)                                                              ³
//³bMountFile	- Preenchimento do aCols pelo usuario (aHeader e aCols ja estarao criados)                     ³
//³lInclui		- Se inclusao passar .T. para qua aCols seja incializada com 1 linha em branco                 ³
//³aHeaderAux	-                                                                                              ³
//³aColsAux		-                                                                                              ³
//³bAfterCols	- Bloco executado apos inclusao de cada linha no aCols                                         ³
//³bBeforeCols	- Bloco executado antes da inclusao de cada linha no aCols                                     ³
//³bAfterHeader -                                                                                              ³
//³cAliasQry	- Alias para a Query                                                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	FillGetDados(7,"SC6",1,cSeek,bWhile,{{bCond,bAction1,bAction2}},aNoFields,/*aYesFields*/,/*lOnlyYes*/,cQuery,/*bMontCols*/,.F.,/*aHeaderAux*/,/*aColsAux*/,{|| AfterCols(cArqQry,cTipoDat,dCopia,dOrig,lCopia) },/*bBeforeCols*/,/*bAfterHeader*/,"SC6")
	
	nTotalPed  -= M->C5_DESCONT
	nTotalDes  += M->C5_DESCONT
	nTotalDes  += A410Arred(nTotalPed*M->C5_PDESCAB/100,"C6_VALOR")
	nTotalPed  -= A410Arred(nTotalPed*M->C5_PDESCAB/100,"C6_VALOR")
	If ( lQuery )
		dbSelectArea(cArqQry)
		dbCloseArea()
		ChkFile("SC6",.F.)
		dbSelectArea("SC6")
	EndIf
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Monta o array com as formas de pagamento do SX5³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Ma410MtFor(@aHeadFor,@aColsFor)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Caso nao ache nenhum item , abandona rotina.         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If ( lContinua )
	If ( Len(aCols) == 0 )
		lContinua := .F.
	EndIf
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ajusta as variaveis para copia                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
M->C5_NUM := CriaVar("C5_NUM",.T.)
M->C5_EMISSAO := CriaVar("C5_EMISSAO",.T.)
aRegSC6 := {}
aRegSCV := {}
//
// Template GEM - Gestao de Empreendimentos Imobiliarios
//
// Carrega a condicao de venda se a mesma tiver
// uma vinculacao com a pedido/condicao de pagamento
//
If ExistBlock("GEM410PV")
	aGEMCVnd := ExecBlock("GEM410PV",.F.,.F.,{ SC5->C5_NUM ,SC5->C5_CONDPAG ,M->C5_EMISSAO ,nTotalPed })
ElseIf ExistTemplate("GEM410PV")
	// Copia a condicao de venda
	aGEMCVnd := ExecTemplate("GEM410PV",.F.,.F.,{ SC5->C5_NUM ,SC5->C5_CONDPAG ,M->C5_EMISSAO ,nTotalPed })
EndIf

If ExistBlock("MT410CPY")
	ExecBlock("MT410CPY",.F.,.F.)
EndIf       

M->C5_YBLQPAL :=""
M->C5_YSTATUS :=""
M->C5_YAPROV  :="" 
M->C5_YULTMAR :=0

If ( lContinua )
	If ( Type("l410Auto") == "U" .OR. !l410Auto )
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Faz o calculo automatico de dimensoes de objetos     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		aSize := MsAdvSize()
		aObjects := {}
		AAdd( aObjects, { 100, 100, .t., .t. } )
		AAdd( aObjects, { 100, 100, .t., .t. } )
		AAdd( aObjects, { 100, 015, .t., .f. } )
		aInfo := { aSize[ 1 ], aSize[ 2 ], aSize[ 3 ], aSize[ 4 ], 3, 3 }
		aPosObj := MsObjSize( aInfo, aObjects )
		aPosGet := MsObjGetPos(aSize[3]-aSize[1],315,{{003,033,160,200,240,263}} )
		nGetLin := aPosObj[3,1]
		
		DEFINE MSDIALOG oDlg TITLE cCadastro From aSize[7],0 to aSize[6],aSize[5] of oMainWnd PIXEL
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Armazenar dados do Pedido anterior.                  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		IF M->C5_TIPO $ "DB"
			aTrocaF3 := {{"C5_CLIENTE","SA2"}}
		Else
			aTrocaF3 := {}
		EndIf
		EnChoice( "SC5", nReg, nOpc, , , , , aPosObj[1],,3,,,"A415VldTOk")
		@ nGetLin,aPosGet[1,1]  SAY OemToAnsi(IIF(M->C5_TIPO$"DB","Fornec.:","Cliente: ")) SIZE 020,09 PIXEL	//"Fornec.:"###"Cliente: "
		@ nGetLin,aPosGet[1,2]  SAY oSAY1 VAR Space(40)						SIZE 120,09 PICTURE "@!"	OF oDlg PIXEL
		@ nGetLin,aPosGet[1,3]  SAY OemToAnsi("Total :")						SIZE 020,09 OF oDlg PIXEL	//"Total :"
		@ nGetLin,aPosGet[1,4]  SAY oSAY2 VAR 0 PICTURE TM(0,16,Iif(cPaisloc=="CHI",NIL,nNumDec))	SIZE 050,09 OF oDlg PIXEL
		@ nGetLin,aPosGet[1,5]  SAY OemToAnsi("Desc. :")						SIZE 030,09 OF oDlg PIXEL 	//"Desc. :"
		@ nGetLin,aPosGet[1,6]  SAY oSAY3 VAR 0 PICTURE TM(0,16,Iif(cPaisloc=="CHI",NIL,nNumDec))		SIZE 050,09 OF oDlg PIXEL RIGHT
		@ nGetLin+10,aPosGet[1,5]  SAY OemToAnsi("=")							SIZE 020,09 OF oDlg PIXEL
		If cPaisLoc == "BRA"
			@ nGetLin+10,aPosGet[1,6]  SAY oSAY4 VAR 0								SIZE 050,09 PICTURE TM(0,16,2) OF oDlg PIXEL RIGHT
		Else
			@ nGetLin+10,aPosGet[1,6]  SAY oSAY4 VAR 0								SIZE 050,09 PICTURE TM(0,16,Iif(cPaisloc=="CHI",NIL,nNumDec)) OF oDlg PIXEL RIGHT
		EndIf
		oDlg:Cargo	:= {|c1,n2,n3,n4| oSay1:SetText(c1),;
		oSay2:SetText(n2),;
		oSay3:SetText(n3),;
		oSay4:SetText(n4) }
		Set Key VK_F4 to A440Stok(NIL,"A410")
		oGetd:=MsGetDados():New(aPosObj[2,1],aPosObj[2,2],aPosObj[2,3],aPosObj[2,4],nOpc,"A410LinOk","A410TudOk","+C6_ITEM/C6_Local/C6_TES/C6_CF/C6_PEDCLI",.T.,,nColFreeze,,ITENSSC6*IIF(MaGrade(),1,3.33),"A410Blq()",,,,,lFreeze)
		Private oGetDad:=oGetd
		A410Bonus(2)
		Ma410Rodap(oGetD,nTotalPed,nTotalDes)
//		ACTIVATE MSDIALOG oDlg ON INIT (A410Limpa(.F.,M->C5_TIPO),Ma410Bar(oDlg,{||nOpcA:=1,if(A410VldTOk(nOpc).And.oGetd:TudoOk(),If(!obrigatorio(aGets,aTela),nOpcA := 0,oDlg:End()),nOpcA := 0)},{||oDlg:End()},nOpc,oGetD))
		ACTIVATE MSDIALOG oDlg ON INIT (Ma410Bar(oDlg,{||nOpcA:=1,if(A410VldTOk(nOpc).And.oGetd:TudoOk(),If(!obrigatorio(aGets,aTela),nOpcA := 0,oDlg:End()),nOpcA := 0)},{||oDlg:End()},nOpc,oGetD))
		SetKey(VK_F4,)
	Else
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ validando dados pela rotina automatica                       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If EnchAuto(cAlias,aAutoCab,{|| Obrigatorio(aGets,aTela)},aRotina[nOpc][4]) .and. MsGetDAuto(aAutoItens,"A410LinOk",{|| A410VldTOk(nOpc) .and. A410TudOk()},aAutoCab)
			nOpcA := 1
		EndIf
	EndIf
	If ( nOpcA == 1 )
		A410Bonus(1)
		If Type("lOnUpDate") == "U" .Or. lOnUpdate
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Inicializa a gravacao dos lancamentos do SIGAPCO          ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			PcoIniLan("000100")
			
			If !A410Grava(lLiber,lTransf,1,aHeadFor,aColsFor,aRegSC6,aRegSCV,nStack)
				Help(" ",1,"A410NAOREG")
			EndIf
			If ( (ExistBlock("M410STTS") ) )
				ExecBlock("M410STTS",.f.,.f.)
			EndIf
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Finaliza a gravacao dos lancamentos do SIGAPCO            ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			PcoFinLan("000100")
			
		Else
			aAutoCab := MsAuto2Ench("SC5")
			aAutoItens := MsAuto2Gd(aHeader,aCols)
		EndIf
	Else
		While GetSX8Len() > nStack
			RollBackSX8()
		EndDo
		If ( (ExistBlock("M410ABN")) )
			ExecBlock("M410ABN",.f.,.f.)
		EndIf
	EndIf
EndIf
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Destrava Todos os Registros                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MsUnLockAll()
RestArea(aArea)
Return( nOpcA )


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³Mta410Cop ³ Autor ³ Marco Bianchi         ³ Data ³ 30/01/07 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Funcao executada a partir da FillGetdados para validar cada ³±±
±±³          ³registro da tabela. Se retornar .T. FILLGETDADOS considera  ³±±
±±³          ³o registro, se .F. despreza o registro.                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³MColsCop()                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametro ³                                                            ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ MATA410                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function Mta410Cop(cArqQry,nTotalPed,nTotalDes,lGrade)

Local lRet      := .T.
Local lCriaCols := .F.		// Nao permitir que a funcao A410Grade crie o aCols
Local nTamaCols :=Len(aCols)
Local nPosItem  := GDFieldPos("C6_ITEM")
Local nPosQtd   := GDFieldPos("C6_QTDVEN")
Local nPosQtd2  := GDFieldPos("C6_UNSVEN")
Local nPosVlr   := GDFieldPos("C6_VALOR")
Local nPosSld   := GDFieldPos("C6_SLDALIB")
Local nPosDesc  := GDFieldPos("C6_VALDESC")
                         
IF (cArqQry)->C6_QTDVEN == (cArqQry)->C6_QTDENT .OR. C6_BLQ == "R"
	lRet	:= .F.
	Return lRet
ENDIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se este item foi digitada atraves de uma    ³
//³ grade, se for junta todos os itens da grade em uma   ³
//³ referencia , abrindo os itens so quando teclar enter ³
//³ na quantidade                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If ( (cArqQry)->C6_GRADE == "S" .And. lGrade )
	a410Grade(.T.,,cArqQry,.F.,lCriaCols)
	If ( nTamAcols==0 .Or. aCols[nTamAcols][nPosItem] <> (cArqQry)->C6_ITEM )
		lRet := .T.	
	Else
		lRet := .F.	
		nQtdVenCPY	:= (cArqQry)->(C6_QTDVEN - C6_QTDENT)
		nUnsVenCPY	:= (cArqQry)->(C6_UNSVEN - C6_QTDENT)
		aCols[nTamAcols][nPosQtd]  += nQtdVenCPY //(cArqQry)->(C6_QTDVEN)
		aCols[nTamAcols][nPosQtd2] += nUnsVenCPY //(cArqQry)->(C6_UNSVEN)
		nValDESCCPY := (cArqQry)->C6_VALDESC - ((cArqQry)->C6_QTDENT*(cArqQry)->C6_VALDESC)
		If ( nPosDesc > 0 )
			aCols[nTamAcols][nPosDesc] += nValDESCCPY //(cArqQry)->C6_VALDESC
		Endif
		If ( nPosSld > 0 )
			aCols[nTamAcols][nPosSld] += Ma440SaLib()
		EndIf
		nValTOTCPY	:= (cArqQry)->(C6_QTDVEN - C6_QTDENT)*(cArqQry)->C6_PRCVEN
		aCols[nTamAcols][nPosVlr] += nValTOTCPY //(cArqQry)->C6_VALOR
	EndIf
EndIf

//CALCULA SOMENTE O VALOR DO RESIDUO PARA A INCLUSAO DO NOVO PEDIDO
nQtdVenCPY	:= (cArqQry)->(C6_QTDVEN - C6_QTDENT)
nValDESCCPY := (cArqQry)->C6_VALDESC - ((cArqQry)->C6_QTDENT*(cArqQry)->C6_VALDESC)
nValTOTCPY	:= (cArqQry)->(C6_QTDVEN - C6_QTDENT)*(cArqQry)->C6_PRCVEN
nTotalPed += nValTOTCPY //(cArqQry)->C6_VALOR
If ( (cArqQry)->C6_PRUNIT = 0 )
	nTotalDes += nValDESCCPY //(cArqQry)->C6_VALDESC
Else
	nTotalDes += A410Arred(((cArqQry)->C6_PRUNIT*nQtdVenCPY),"C6_VALOR")-A410Arred(((cArqQry)->C6_PRCVEN*nQtdVenCPY),"C6_VALOR")
EndIf

Return lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³AfterCols ³ Autor ³ Marco Bianchi         ³ Data ³ 24/01/07 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Funcao executada apos inclusao de nova linha no aCols pela  ³±±
±±³          ³FillgetDados.                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³AfterCols()                                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametro ³                                                            ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ MATA410                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function AfterCols(cArqQry,cTipoDat,dCopia,dOrig,lCopia)
           
Local nPosProd  := GDFieldPos("C6_PRODUTO")
Local nPosGrade := GDFieldPos("C6_GRADE")
Local cMascara  := SuperGetMv("MV_MASCGRD")
Local nTamRef   := Val(Substr(cMascara,1,2))
Local nPIdentB6 := GDFieldPos("C6_IDENTB6")
Local nPEntreg  := GDFieldPos("C6_ENTREG")
Local nPPedCli  := GDFieldPos("C6_PEDCLI")
Local nQtdLib   := GDFieldPos("C6_QTDLIB")
Local nQtdven   := GDFieldPos("C6_QTDVEN")
Local nQtdent   := GDFieldPos("C6_QTDENT")
Local nUnsven   := GDFieldPos("C6_UNSVEN")
Local nValor    := GDFieldPos("C6_VALOR")
Local nPrcven   := GDFieldPos("C6_PRCVEN")

Local nAux      := 0
Local aLiberado := {}
Local cCampo    := ""

DEFAULT lCopia  := .F.
                                 
If nPosGrade > 0 .And. aCols[Len(aCols)][nPosGrade] == "S"
	aCols[Len(aCols)][nPosProd] := SubStr((cArqQry)->C6_PRODUTO,1,nTamRef)
Else
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Mesmo nao sendo um item digitado atraves de grade e' necessa-³
	//³ rio criar o Array referente a este item para controle da     ³
	//³ grade                                                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If FindFunction("MsMatGrade") .And. IsAtNewGrd()
		oGrade:MontaGrade(Len(aCols))
	Else
		MatGrdMont(Len(aCols))
	EndIf 
EndIf	

If Altera
	If ( SC5->C5_TIPO <> "D" )
		nAux := aScan(aLiberado,{|x| x[2] == aCols[Len(aCols)][nPIdentB6]})
		If ( nAux == 0 )
			aadd(aLiberado,{ (cArqQry)->C6_ITEM , aCols[Len(aCols)][nPIdentB6] , (cArqQry)->C6_QTDEMP, (cArqQry)->C6_QTDENT })
		Else
			aLiberado[nAux][3] += (cArqQry)->C6_QTDEMP
			aLiberado[nAux][4] += (cArqQry)->C6_QTDENT
		EndIf
	Else
		nAux := aScan(aLiberado,{|x| x[1] == (cArqQry)->C6_SERIORI .And.;
		x[2] == (cArqQry)->C6_NFORI   .And.;
		x[3] == (cArqQry)->C6_ITEMORI })
		If ( nAux == 0 )
			aadd(aLiberado,{ (cArqQry)->C6_SERIORI , (cArqQry)->C6_NFORI , (cArqQry)->C6_ITEMORI , (cArqQry)->C6_QTDEMP })
		Else
			aLiberado[nAux][4] += (cArqQry)->C6_QTDEMP
		EndIf
	EndIf
	// Necessario para disparar inicializador padrao
	aCols[Len(aCols)][nQtdLib] := CriaVar("C6_QTDLIB")
EndIf

If lCopia
	cCampo := Alltrim(aHeader[nPEntreg,2])           
	Do Case
		Case cTipoDat == "1"
			aCols[Len(aCols)][nPEntreg] := FieldGet(FieldPos(cCampo))
		Case cTipoDat == "2"
			aCols[Len(aCols)][nPEntreg] := If(FieldGet(FieldPos(cCampo)) < dCopia,dCopia,FieldGet(FieldPos(cCampo)) )
		Case cTipoDat == "3"
			aCols[Len(aCols)][nPEntreg] := dCopia + (FieldGet(FieldPos(cCampo)) - dOrig )
	EndCase

	If SubStr(aCols[Len(aCols)][nPPedCli],1,3)=="TMK"
		aCols[Len(aCols)][nPPedCli] := CriaVar(cCampo)
	EndIf	
//FAZ O CALCULO PARA A QUANTIDADE E VALOR DO NOVO ACOLS
	nNewQtd	:= (cArqQry)->C6_QTDVEN-(cArqQry)->C6_QTDENT
	nNewUns	:= ConvUM(padr(aCols[Len(aCols)][nPosProd],15), nNewQtd, 0, 2)
	nNewVal	:= nNewQtd * (cArqQry)->C6_PRCVEN
	aCols[Len(aCols)][nQtdven] := nNewQtd
	aCols[Len(aCols)][nUnsven] := nNewUns
	aCols[Len(aCols)][nValor] 	:= nNewVal

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Estes campos nao podem ser copiados                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	GDFieldPut("C6_QTDLIB"  ,CriaVar("C6_QTDLIB"  ))
	GDFieldPut("C6_RESERVA" ,CriaVar("C6_RESERVA" ))
	GDFieldPut("C6_CONTRAT" ,CriaVar("C6_CONTRAT" ))
	GDFieldPut("C6_ITEMCON" ,CriaVar("C6_ITEMCON" ))
	GDFieldPut("C6_PROJPMS" ,CriaVar("C6_PROJPMS" ))
	GDFieldPut("C6_EDTPMS"  ,CriaVar("C6_EDTPMS"  ))
	GDFieldPut("C6_TASKPMS" ,CriaVar("C6_TASKPMS" ))
	GDFieldPut("C6_LICITA"  ,CriaVar("C6_LICITA"  ))
	GDFieldPut("C6_PROJET"  ,CriaVar("C6_PROJET"  ))
	GDFieldPut("C6_ITPROJ"  ,CriaVar("C6_ITPROJ"  ))
	GDFieldPut("C6_CONTRT"  ,CriaVar("C6_CONTRT"  ))
	GDFieldPut("C6_TPCONTR" ,CriaVar("C6_TPCONTR" ))
	GDFieldPut("C6_ITCONTR" ,CriaVar("C6_ITCONTR" ))
	GDFieldPut("C6_NUMOS"   ,CriaVar("C6_NUMOS"   ))
	GDFieldPut("C6_NUMOSFAT",CriaVar("C6_NUMOSFAT"))
	GDFieldPut("C6_OP"      ,CriaVar("C6_OP"      ))
	GDFieldPut("C6_NUMOP"   ,CriaVar("C6_NUMOP"   ))
	GDFieldPut("C6_ITEMOP"  ,CriaVar("C6_ITEMOP"  ))
	GDFieldPut("C6_NUMORC"  ,CriaVar("C6_NUMORC"  ))
	GDFieldPut("C6_BLQ"     ,CriaVar("C6_BLQ"     ))
	GDFieldPut("C6_NOTA"    ,CriaVar("C6_NOTA"    ))
	GDFieldPut("C6_SERIE"   ,CriaVar("C6_SERIE"   ))
	
EndIf

Return(.T.) 


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³A410Bonus ³ Autor ³Eduardo Riera          ³ Data ³16.06.2001³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Rotina de tratamento da regra de bonificacao para interface ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpN1: Tipo de operacao                                     ³±±
±±³          ³       [1] Inclusao do bonus                                ³±±
±±³          ³       [2] Exclusao do bonus                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Esta rotina tem como objetivo avaliar a regra de bonificacao³±±
±±³          ³e adicionar na respectiva interface                         ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Observacao³                                                            ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Materiais/Distribuicao/Logistica                           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function A410Bonus(nTipo)

Local aArea     := GetArea()
Local aBonus    := {}
Local lA410BLCo := ExistBlock("A410BLCO")
Local nX        := 0
Local nY        := 0
Local nW        := 0 
Local nZ        := Len(aCols)
Local nUsado    := Len(aHeader)
Local nPProd    := aScan(aHeader,{|x| AllTrim(x[2])=="C6_PRODUTO" })
Local nPQtdVen  := aScan(aHeader,{|x| AllTrim(x[2])=="C6_QTDVEN" })
Local nPPrcVen  := aScan(aHeader,{|x| AllTrim(x[2])=="C6_PRCVEN" })
Local nPValor   := aScan(aHeader,{|x| AllTrim(x[2])=="C6_VALOR" })
Local nPTES		:= aScan(aHeader,{|x| AllTrim(x[2])=="C6_TES" })
Local nPItem	:= aScan(aHeader,{|x| AllTrim(x[2])=="C6_ITEM" })
Local nPQtdLib  := aScan(aHeader,{|x| AllTrim(x[2])=="C6_QTDLIB" })
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Verifica os bonus                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nTipo == 1
	Ma410GraGr()
	If M->C5_TIPO=="N"
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Verifica os bonus por item de venda                     ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If ExistBlock('A410BONU')
			aBonus	:=	ExecBlock('A410BONU',.F.,.F.,{aCols,{nPProd,nPQtdVen,nPTES}})
		Else
			aBonus   := FtRgrBonus(aCols,{nPProd,nPQtdVen,nPTES},M->C5_CLIENTE,M->C5_LOJACLI,M->C5_TABELA,M->C5_CONDPAG)
		Endif
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Recupera os bonus ja existentes                         ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		aBonus   := FtRecBonus(aCols,{nPProd,nPQtdVen,nPTES,nUsado+1},aBonus)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Grava os novos bonus                                    ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nY := Len(aBonus)
		If nY > 0
			cItem := aCols[nZ,nPItem]
			For nX := 1 To nY
				cItem := Soma1(cItem)
				aadd(aCols,Array(nUsado+1))
				nZ++
				N := nZ
				For nW := 1 To nUsado
					If (aHeader[nW,2] <> "C6_REC_WT") .And. (aHeader[nW,2] <> "C6_ALI_WT")
						aCols[nZ,nW] := CriaVar(aHeader[nW,2],.T.)
					EndIf	
				Next nW
				aCols[nZ,nUsado+1] := .F.
				aCols[nZ,nPItem  ] := cItem
				A410Produto(aBonus[nX][1],.F.)
				A410MultT("M->C6_PRODUTO",aBonus[nX][1])
				A410MultT("M->C6_TES",aBonus[nX][3])
				aCols[nZ,nPProd  ] := aBonus[nX][1]
				
 				If ExistTrigger("C6_PRODUTO")
   					RunTrigger(2,Len(aCols))
				Endif

				aCols[nZ,nPQtdVen] := aBonus[nX][2]
				aCols[nZ,nPTES   ] := aBonus[nX][3]
				If ( aCols[nZ,nPPrcVen] == 0 )
					aCols[nZ,nPPrcVen] := 1
					aCols[nZ,nPValor ] := aCols[nZ,nPQtdVen]
				Else
					aCols[nZ,nPValor ] := A410Arred(aCols[nZ,nPQtdVen]*aCols[nZ,nPPrcVen],"C6_VALOR")
				EndIf
				
 				If ExistTrigger("C6_TES    ")
   					RunTrigger(2,Len(aCols))
				Endif

				If mv_par01 == 1 
					aCols[nZ,nPQtdLib ] := aCols[nZ,nPQtdVen ]
				Endif

				If lA410BLCo
					aCols[nZ] := ExecBlock("A410BLCO",.F.,.F.,{aHeader,aCols[nZ]})
				Endif
			Next nX
		EndIf
	EndIf
Else
	FtDelBonus(aCols,{nPProd,nPQtdVen,nPTES,nUsado+1})	
EndIf
RestArea(aArea)
Return(.T.)



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³Ma410Bar  ³ Autor ³ Eduardo Riera         ³ Data ³ 18.02.99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ EnchoiceBar especifica do Mata410                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ Nenhum                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ oDlg: 	Objeto Dialog                                     ³±±
±±³          ³ bOk:  	Code Block para o Evento Ok                       ³±±
±±³          ³ bCancel: Code Block para o Evento Cancel                   ³±±
±±³          ³ nOpc:    nOpc transmitido pela mbrowse                     ³±±
±±³          ³ aForma: Array com as formas de pagamento                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Ma410Bar(oDlg,bOk,bCancel,nOpc,oGetD)

Local aButtons  := {}
Local aButtonUsr:= {}
Local nI        := 0
LOCAL lOpcPadrao:= GetNewPar("MV_REPGOPC","N") == "N"
Local nPProduto	:= aScan(aHeader,{|x| AllTrim(x[2])=="C6_PRODUTO"})
Local nPOpcional:= If(lOpcPadrao,aScan(aHeader,{|x| AllTrim(x[2])=="C6_OPC"}),aScan(aHeader,{|x| AllTrim(x[2])=="C6_MOPC"}))

If ( nOpc == 3 .Or. nOpc == 4 .Or. (nOpc == 2 .And. !AtIsRotina("A450F4CON")) )
	aadd(aButtons,{"POSCLI",{|| If(M->C5_TIPO=="N".And.!Empty(M->C5_CLIENTE),a450F4Con(),.F.),Pergunte("MTA410",.F.)},"Posição de Cliente","Posição de Cliente" }) 	//"Posi‡„o de Cliente"
EndIf
aadd(aButtons,{"BUDGET",{|| Ma410ForPg(nOpc)},"Formas de Pagamento", "Formas de Pagamento" }) //"Formas de Pagamento"
aadd(aButtons,{"RELATORIO",{||Ma410Impos(aRotina[ nOpc, 4 ])},"Planilha Financeira", "Planilha Financeira" })	//"Planilha Financeira"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Ponto de entrada para verificar se o usuario pode acessar a formacao    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If VerSenha(107) //Permite consulta a Formacao de Precos
	If ExistBlock("A410BPRC")
		If ExecBlock("A410BPRC",.F.,.F.)
			aadd(aButtons,{"AUTOM",{||Ma410Forma()},"Formacao de Precos","Formacao de Precos" })	//"Formacao de Precos"
		Endif
	Else
		aadd(aButtons,{"AUTOM",{||Ma410Forma()},"Formacao de Precos","Formacao de Precos" })	//"Formacao de Precos"
	Endif
EndIf

If ( aRotina[ nOpc, 4 ] == 2 .Or. aRotina[ nOpc, 4 ] == 6 ) .And. !AtIsRotina("A410TRACK")
	AAdd(aButtons,{ "BMPVISUAL", {|| A410Track() }, "System Tracker", "System Tracker" } )  // "System Tracker"
EndIf
If !( nOpc == 2 .Or. nOpc == 5 ) .And. AtIsRotina("MATA410")
	If ExistBlock("A410BPRO")
		If ExecBlock("A410BPRO",.F.,.F.)
			Aadd(aButtons,{"PRODUTO", {|| Ma410BOM(aHeader,aCols,N) } ,"Estrutura de Produto","Estr.Prod."}) //"Estrutura de Produto"###"Estr.Prod."
		EndIf
	Else
		Aadd(aButtons,{"PRODUTO", {|| Ma410BOM(aHeader,aCols,N) } ,"Estrutura de Produto","Estr.Prod."}) //"Estrutura de Produto"###"Estr.Prod."	
	EndIf
EndIf
Aadd(aButtons,{"PESQUISA",{|| GdSeek(oGetD,"Pesquisar",,,.F.)},"Pesquisar","Pesquisar"}) //"Pesquisar"
If ( nOpc == 1 .Or. nOpc == 2 .Or. nOpc == 5 ) .And. nPOpcional > 0
	Aadd(aButtons,{"SDUCOUNT", {|| SeleOpc(2,,aCols[n][nPProduto],,,Ma410Opc(lOpcPadrao,nPOpcional),"M->C6_PRODUTO",.T.) } ,"Opcionais Selecionados","Opcionais"}) //"Opcionais Selecionados"###"Opcionais"
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Pontos de Entrada 													   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If ExistTemplate("A410CONS",,.T.)
	aButtonUsr := ExecTemplate("A410CONS",.F.,.F.)
	If ValType(aButtonUsr) == "A" 
		For nI   := 1  To  Len(aButtonUsr)
			Aadd(aButtons,aClone(aButtonUsr[nI]))
		Next nI
	EndIf
EndIf
If ExistBlock("A410CONS",,.T.)
	aButtonUsr := ExecBlock("A410CONS",.F.,.F.)
	If ValType(aButtonUsr) == "A"
		For nI   := 1  To  Len(aButtonUsr)
			Aadd(aButtons,aClone(aButtonUsr[nI]))
		Next nI
	EndIf
EndIf

Return (EnchoiceBar(oDlg,bOK,bcancel,,aButtons))




//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ContCPY - Programa para avaliar se continua a copia do residuo. 
//³Não pode considerar o campo C5_NOTA pois o campo somente é gravado após
//³o faturamento de todos os itens.
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

User Function ContCPY

aAreaSC6	:= SC6->(GetArea())
cFaturado:= ""
lretCPY	:= .T.


IF !EMPTY(SC5->C5_NOTA)
	lretCPY := .F.
	Help(" ",1,"CPYRESID")
	RestArea(aAreaSC6)
	return(lretCPY)
ENDIF

DbSelectArea("SC6")
DbSetOrder(1)
DbSeek(xFilial("SC6")+SC5->C5_NUM)

Do While !eof() .and. xFilial("SC6")+SC5->C5_NUM == SC6->C6_FILIAL+SC6->C6_NUM
IF SC6->C6_QTDENT	> 0 .and. empty(SC6->C6_BLQ)
	cFaturado	+= "S"
ENDIF
	DbSelectArea("SC6")
	DbSkip()
EndDo

IF EMPTY(cFaturado)
	lretCPY := .F.
	Help(" ",1,"CPYRESID")
ENDIF

RestArea(aAreaSC6)

return(lretCPY)
