#include "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "msgraphi.ch"
#INCLUDE "APWIZARD.CH"

#Define	BMPSAIR	"FINAL.PNG"
#Define BMPRFSH "PMSRRFSH.PNG"
#Define BMPSAVE "SALVAR.PNG"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGC0001  บAutor  ณElton C.            บ Data ณ  13/09/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณBrowse do monitor de processos Midia e Software             บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function MBCADZZC()

Local aArea := GetArea()

Private aCores    := {	{"!Empty(C5_NOTA)"	, "BR_VERMELHO", "Pedido Faturado"  },;
{"Empty(C5_NOTA)"	, "BR_VERDE"   , "Pedido em aberto"  }}


Private aRotina := {{"Pesquisar","AxPesqui",0,1} ,;
{"Imprime Rel IMEI","u_PRINTZZC",0,2},;
{"Vincula IMEI","u_CADZZC",0,4},;
{"Legenda","u_MBZZCLEG",0,4}}

Private cCadastro := "Cadastro de IMEI x Pedidos de Vendas"

dbSelectArea("SC5")
dbSetOrder(1)
mBrowse( 6,1,22,75,"SC5",,,,,,aCores)

RestArea(aArea)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ NCGC01Leg บAutor  ณElton C.	         บ Data ณ  01/11/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณLegenda do browse                                           บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function MBZZCLEG()
Local aLegenda := {}

aEval(aCores, {|z| Aadd(aLegenda, {z[2], z[3]})})
BrwLegenda(cCadastro, "Legenda", aLegenda)

Return(Nil)



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ  บAutor  ณElton C.	                 บ Data ณ  13/09/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณTela utilizada para mostrar o detalhe do processo           บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function CADZZC(cAlias, nRecno, nOpc)

Local aArea := GetArea()
Local oDlg
Local oWin01
Local oWin02
Local oFWLayer
Local oFont

Local aHeader		:= {}
Local aCols			:= {}
Local aScreen 		:= GetScreenRes()
Local aObjects  	:= {}
Local nWStage 		:= aScreen[1]-45
Local nHStage 		:= aScreen[2]-225
Local nX			:= 0
Local aButton		:= {}
Local aSize     	:= MsAdvSize(.T.)
Local oBarBtn
Local bSair			:= {|| oDlg:End() } //Sair
Local bSave			:= {|| SaveZZC(),oDlg:End()  }  //Salva o Cadastro
Local oButton

Private aCamposPz1	:= {"ZZC_PEDIDO","ZZC_CLIENT","ZZC_LOJA","ZZC_NOMCLI"}
Private aCamposPz2	:= {"ZZC_ITEM","ZZC_CODBAR","ZZC_IMEI_1","ZZC_IMEI_2"}//,"ZZC_IMEI_2","ZZC_NSERIE"}
Private aHeaderPz1  := {}
Private aHeaderPz2  := {}
Private aColsPZ1 	:= {}
Private aColsPZ2 	:= {}
Private oGetDPz1
Private oGetDPz2
Private oTMultiget
Private	cGet		:= ""
Private	oCodBar
Private	oIMEI1
Private	oIMEI2
Private	oOkIm
Private	cCodBar		:= space(avsx3("ZZC_CODBAR",3))
Private	cIMEI1		:= space(avsx3("ZZC_IMEI_1",3)+1)
Private	cIMEI2		:= space(avsx3("ZZC_IMEI_2",3)+1)
Private	cOkIm		:= space(1)

//Preenche o aheader e o acols da tabela pz1
aHeaderPz1 := CriaHeader(aCamposPz1)//Cria o aheader da tabela PZ2
aColsPZ1 := CriaAcPZ1( SC5->C5_NUM )//Cria o acols da tabela PZ2

//Preenche o aheader e o acols da tabela pz2
aHeaderPz2 := CriaHeader(aCamposPz2)//Cria o aheader da tabela PZ2
aColsPZ2 := CriaAcPZ2( SC5->C5_NUM )//Cria o acols da tabela PZ2

//Botoes do monitor
aAdd(aButton, { BMPSAIR		, BMPSAIR		, /*"Sair"*/	   	, bSair		, /*"Sair"*/  	})
aAdd(aButton, { BMPSAVE		, BMPSAVE		, /*"Salvar"*/		, bSave		, /*"Salvar"*/  	})


//Montagem da tela
DEFINE DIALOG oDlg TITLE "Cadastramento IMEI" SIZE nWStage,nHStage PIXEL STYLE nOr(WS_VISIBLE,WS_POPUP) //"Empresas"

//Cria instancia do fwlayer
oFWLayer := FWLayer():New()

//Inicializa componente passa a Dialog criada,o segundo parametro ้ para
//cria็ใo de um botao de fechar utilizado para Dlg sem cabe็alho
oFWLayer:Init( oDlg, .T. )

// Efetua a montagem das colunas das telas
oFWLayer:AddCollumn( "Col01", 100, .T. )


// Cria windows passando, nome da coluna onde sera criada, nome da window
// titulo da window, a porcentagem da altura da janela, se esta habilitada para click,
// se ้ redimensionada em caso de minimizar outras janelas e a a็ใo no click do split
oFWLayer:AddWindow( "Col01", "Win01", "Pedido", 22, .F., .T., ,,)
oFWLayer:AddWindow( "Col01", "Win02", "Rela็ใo IMEI", 78 , .F., .T., {|| .T. },,)

oWin01 := oFWLayer:getWinPanel('Col01','Win01')
oWin02 := oFWLayer:getWinPanel('Col01','Win02')

//Cria a getdados da tabela PZ1
oGetDPz1 := MsNewGetDados():New(005,005,35,650 ,0 ,"","","",,,9999,"AllWaysTrue()",,,oWin01,aHeaderPz1,aColsPZ1)
nOpc	:= GD_INSERT + GD_UPDATE + GD_DELETE
//Cria a getdados da tabela PZ2
oGetDPz2 := MsNewGetDados():New(005,005,165,650 ,nOpc ,.T.,.T.,"+ZZC_ITEM",,,9999,"AllWaysTrue()",,,oWin02,aHeaderPz2,aColsPZ2)

//Adiciona a barra dos bot๕es
DEFINE BUTTONBAR oBarBtn SIZE 30,30 3D BOTTOM OF oWin02

oButton	:= TBtnBmp():NewBar( aButton[1,1],aButton[1,2],,,aButton[1,3], aButton[1,4],.T.,oBarBtn,,,aButton[1,5])
oButton:cTitle := aButton[1,3]
oButton:Align := CONTROL_ALIGN_LEFT

oButton	:= TBtnBmp():NewBar( aButton[2,1],aButton[2,2],,,aButton[2,3], aButton[2,4],.T.,oBarBtn,,,aButton[2,5])
oButton:cTitle := aButton[2,3]
oButton:Align := CONTROL_ALIGN_LEFT

@ 170,100 MSGet oCodBar var cCodBar  Size 70,10 PIXEL OF oWin02
@ 170,200 MSGet oIMEI1  var cIMEI1   Size 70,10 PIXEL OF oWin02
@ 170,280 MSGet oIMEI2  var cIMEI2   Size 70,10 PIXEL OF oWin02
//@ 170,350 MSGet oOkIm   var cOkIm    Size 01,01 PIXEL OF oWin02
oIMEI2:bLostFocus := {|| iif(!Empty(cCodBar).and.!Empty(cIMEI1).and.!Empty(cIMEI2),AtuGet02(@cCodBar,@cIMEI1,@cIMEI2),oCodBar:SetFocus()) }

//@ 170,271 MSGet oConfir var cConfir  Size 01,01 PIXEL OF oWin02  valid(AtuGet02(@cCodBar,@cIMEI1,@cConfir))

ACTIVATE DIALOG oDlg CENTERED

RestArea(aArea)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCriaHeaderบAutor  ณElton C.	         บ Data ณ  02/24/10   บฑฑ
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

Default aCampos := {}

DbSelectArea( "SX3" )
DbSetOrder(2)

For nIx := 1 To Len( aCampos )
	If SX3->( MsSeek( aCampos[ nIx ] ) )
		aAdd( aRet, {AlLTrim( X3Titulo() )	, ;	// 01 - Titulo
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
ฑฑษออออออออออัออออออออออออหอออออออัออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCriaAcolsPZ2บAutor  ณElton C.          บ Data ณ  13/09/13   บฑฑ
ฑฑฬออออออออออุออออออออออออสอออออออฯออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCria e atualiza o aCols                                     บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CriaAcPZ2( cPvOri )
Local aArea    		:= GetArea()
Local aStruct	 	:= {}
Local nX			:= 0
Local aRet			:= {}
Local cAliasTmp		:= ""
Local cQuery		:= ""

Default cPvOri	:= ""

aStruct   := ZZC->(dbStruct())
For nX := 1 To Len(aStruct)
	If aStruct[nX][2] <> "C" .And. FieldPos( aStruct[nX][1] ) <> 0
		TcSetField( cAliasTmp, aStruct[nX][1], aStruct[nX][2], aStruct[nX][3], aStruct[nX][4] )
	EndIf
Next nX

aRet := {}

DbSelectArea("ZZC")
DbSetOrder(1)
If DbSeek(xFilial("ZZC")+cPvOri)
	While ZZC->(!eof()) .and. ZZC->(ZZC_FILIAL+ZZC_PEDIDO) == SC5->(C5_FILIAL+C5_NUM)
		aAdd(aRet,{ZZC_ITEM,;
		ZZC_CODBAR,;
		ZZC_IMEI_1,;
		ZZC_IMEI_2,;
		,.F.})
		
		ZZC->(dbSkip())
	End
End

RestArea( aArea )
Return aRet



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออหอออออออัออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCriaAcolsPZ3บAutor  ณElton C.          บ Data ณ  13/09/13   บฑฑ
ฑฑฬออออออออออุออออออออออออสอออออออฯออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCria e atualiza o aCols                                     บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CriaAcPZ1( cPvOri )
Local aArea    		:= GetArea()
Local aStruct	 	:= {}
Local nX			:= 0
Local aRet			:= {}
Local cAliasTmp		:= ""
Local cQuery		:= ""
Local lPreencheu	:= .F.

Default cPvOri	:= ""

cAliasTmp := GetNextAlias()

DbSelectArea("ZZC")
DbSetOrder(1)
If !DbSeek(xFilial("ZZC")+cPvOri)
	reclock("ZZC",.T.)
	ZZC->ZZC_FILIAL := xFilial("ZZC")
	ZZC->ZZC_PEDIDO	:= SC5->C5_NUM
	ZZC->ZZC_CLIENT	:= SC5->C5_CLIENTE
	ZZC->ZZC_LOJA	:= SC5->C5_LOJACLI
	ZZC->ZZC_NOMCLI	:= SC5->C5_NOMCLI
	ZZC->ZZC_ITEM	:= "0001"
	msUnlock()
EndIf

aStruct   := ZZC->(dbStruct())
For nX := 1 To Len(aStruct)
	If aStruct[nX][2] <> "C" .And. FieldPos( aStruct[nX][1] ) <> 0
		TcSetField( cAliasTmp, aStruct[nX][1], aStruct[nX][2], aStruct[nX][3], aStruct[nX][4] )
	EndIf
Next nX

aRet := {}

While ZZC->(!Eof()) .and. ZZC->(ZZC_FILIAL+ZZC_PEDIDO) == SC5->(C5_FILIAL+C5_NUM) .and. !lPreencheu
	lPreencheu	:= .T.
	aAdd(aRet,{ZZC->ZZC_PEDIDO,;
	ZZC->ZZC_CLIENT,;
	ZZC->ZZC_LOJA,;
	ZZC->ZZC_NOMCLI,;
	,.F.})
	
	ZZC->(dbSkip())
EndDo

RestArea( aArea )
Return aRet



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ SaveZZC  บAutor  ณMicrosiga           บ Data ณ  09/26/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function SaveZZC

Local aArea	:= GetArea()
aHeader	:= aClone(oGetDPz2:aHeader)
aCols	:= aClone(oGetDPz2:Acols)

DbSelectArea("ZZC")
DbSetOrder(1)
DbGoTop()
If DbSeek(xFilial("ZZC")+SC5->C5_NUM)
	While ZZC->(!eof()) .and. ZZC->(ZZC_FILIAL+ZZC_PEDIDO == SC5->(C5_FILIAL+C5_NUM))
		nPos := Ascan( aCols, { |x| ZZC->ZZC_ITEM $ x[1] } )
		If nPos == 0
			reclock("ZZC")
			dbDelete()
			msunlock()
		ElseIf aCols[nPos,len(aCols[nPos])]
			reclock("ZZC")
			dbDelete()
			msunlock()
		EndIf
		ZZC->(DbSkip())
	End
EndIf


For nx:=1 to Len(aCols)
	If !aCols[nx,len(aCols[nx])] .and. !Empty(aCols[nx,2]+aCols[nx,3]+aCols[nx,4])
		If !DbSeek(xFilial("ZZC")+SC5->C5_NUM+aCols[nx,1])
			reclock("ZZC",.T.)
			ZZC->ZZC_FILIAL := xFilial("ZZC")
			ZZC->ZZC_PEDIDO	:= SC5->C5_NUM
			ZZC->ZZC_CLIENT	:= SC5->C5_CLIENTE
			ZZC->ZZC_LOJA	:= SC5->C5_LOJACLI
			ZZC->ZZC_NOMCLI	:= SC5->C5_NOMCLI
			msunlock()
		EndIf
		reclock("ZZC",.F.)
		For nY := 1 to Len(aHeaderPz2)
			If aHeaderPz2[nY][10] <> "V"
				ZZC->(FieldPut(FieldPos(aHeaderPz2[nY][2]),aCols[nX][nY]))
			EndIf
		Next nY
		msUnlock()
		
	EndIf
Next nx

RestArea(aArea)

Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAtuGet02  บAutor  ณMicrosiga           บ Data ณ  09/26/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function AtuGet02(cCodBar,cIMEI1,cIMEI2)

Local lRet	:= .F.

Gdfieldput("ZZC_CODBAR",cCodBar,oGetDPz2:nAT,oGetDPz2:aHeader,oGetDPz2:aCols)
Gdfieldput("ZZC_IMEI_1",cIMEI1,oGetDPz2:nAT,oGetDPz2:aHeader,oGetDPz2:aCols)
Gdfieldput("ZZC_IMEI_2",cIMEI2,oGetDPz2:nAT,oGetDPz2:aHeader,oGetDPz2:aCols)

oGetDPz2:AddLine()
cCodBar		:= space(avsx3("ZZC_CODBAR",3))
cIMEI1		:= space(avsx3("ZZC_IMEI_1",3)+1)
cIMEI2		:= space(avsx3("ZZC_IMEI_2",3)+1)

oCodBar:SetFocus()

Return lRet
