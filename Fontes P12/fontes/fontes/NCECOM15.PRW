#INCLUDE "PROTHEUS.CH"
#INCLUDE "msgraphi.ch"
#INCLUDE "APWIZARD.CH"


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCECOM12  ºAutor  ³                     º Data ³  02/2014	  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Monitor Cadastro - E-commerce							      º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NC Games                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function NCECOM15()
Local ACPOZC2	:={}
Local aArea 	:= GetArea()
Local cFiltro
Local cPerg		:=Padr("NCECOM15",Len(SX1->X1_GRUPO))
Local  cCadastro := "Monitor Cadastro - E-commerce"
Private  aRotina := {	{"Pesquisar","AxPesqui",0,1} ,	{"Monitor","u_COM15Manut",0,2}	}

AADD(aCpoZC2,"ZC2_CODERP")
AADD(aCpoZC2,"ZC2_CODCIA")
AADD(aCpoZC2,"ZC2_NOME")

cFiltro:="@"
PutSx1(cPerg,"01","Cadastro?" ,"","","mv_ch1","N",1,0,1,"C","","","","","mv_par01","Cliente","Cliente","Cliente","","Preco","Preco","Preco","Estoque","Estoque","Estoque","","","","","","")//,aHelpP11,aHelpE11,aHelpS11)
PutSx1(cPerg,"02","Filtrar?"  ,"","","mv_ch2","N",1,0,1,"C","","","","","mv_par02","Com Erro","Com Erro","Com Erro","","Sem Erro","Sem Erro","Sem Erro","Todos","Todos","Todos","","","","","","")//,aHelpP11,aHelpE11,aHelpS11)

If Pergunte(cPerg)
	If mv_par01==1
		
		cFiltro+=" ZC2_CADAST='CLIENTE'"
		
		AADD(aCpoZC2,"ZC2_PESSOA")
		AADD(aCpoZC2,"ZC2_BLOQUE")
		AADD(aCpoZC2,"ZC2_CODVEN")
		AADD(aCpoZC2,"ZC2_NOMEVE")
		AADD(aCpoZC2,"ZC2_CANAL")
		AADD(aCpoZC2,"ZC2_DESCCA")
		
	ElseIf mv_par01==2
		cFiltro+=" ZC2_CADAST='PRECO'"
	ElseIf mv_par01==3
		cFiltro+=" ZC2_CADAST='ESTOQUE'"
	EndIf
	
	If mv_par02<>3
		//cFiltro+=" And Exists ( Select 'X' From "+RetSqlName("ZC7")+" ZC7 Where ZC7_FILIAL='"+xFilial("ZC7")+"' And  ZC7_CADAST=ZC2_CADAST  AND  ZC7_CODCIA=ZC2_CODCIA AND ZC7_ERRO"+Iif(mv_par02==1,"=","<>")+"'S'  AND ZC7.D_E_L_E_T_=' ')"
		cFiltro+=" And ZC2_ERRO "+Iif(mv_par02==1,"=","<>")+"'S' "		
	EndIf
EndIf


ZC2->(DbSetOrder(1))
oBrowse := FWMBrowse():New()
oBrowse:AddLegend( 'ZC2->ZC2_ERRO<>"S"'	    	 ,"GREEN"	,"Cadastro Sem Erro" )
oBrowse:AddLegend( 'ZC2->ZC2_ERRO=="S"'			 ,"RED"		,"Cadastro Com Erro" )

oBrowse:SetOnlyFields( aCpoZC2 )
oBrowse:SetAlias("ZC2")

oBrowse:SetFilterDefault(cFiltro)
oBrowse:SetDescription(cCadastro)
oBrowse:Activate()


RestArea(aArea)
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³  ºAutor  ³            	              º Data ³  02/2014	  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Tela utilizada para mostrar o detalhe do processo           º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NC Games                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function COM15Manut(cAlias, nRecno, nOpc)
Local aArea := GetArea()
Local oDlg
Local oWin01
Local oWin02
Local oFWLayer
Local oFont
Local oButPed
Local oButSair
Local oButHisRa
Local oButNfs
Local aHeader		:= {}
Local aCols			:= {}
Local aScreen 		:= GetScreenRes()
Local aObjects  	:= {}
Local nWStage 		:= aScreen[1]-45
Local nHStage 		:= aScreen[2]-225
Local nX		  		:= 0
Local aButton		:= {}
Local aSize     	:= MsAdvSize(.T.)
Local oBarBtn
Local bSair			:= {|| oDlg:End() }//Sair
Local bAtu			:= {|| RefrMonitor()}//Atualiza o monitor
Local oButton
Local oTimer


Local aCamposZC2	:= {"ZC2_CADAST","ZC2_CODCIA","ZC2_NOME"}
Local aCamposZC7	:= {"ZC7_ACAO","ZC7_DATA","ZC7_HORA","ZC7_USUARI","ZC7_ERRO","ZC7_OBS"}

Private aHeaderZC2  := {}
Private aHeaderZC7  := {}
Private aColsZC2 	:= {}
Private aColsZC7 	:= {}
Private oGetDZC2
Private oGetDZC7
Private oTMultiget
Private cGet		:= ""
Private aSize		:= MsAdvSize(.T.)

//Preenche o aheader e o acols da tabela ZC2
aHeaderZC2 	:= CriaHeader(aCamposZC2)//Cria o aheader da tabela ZC7
aColsZC2 	:= CriaAcZC2( ZC2->ZC2_CADAST, ZC2->ZC2_CODCIA )//Cria o acols da tabela ZC7

//Preenche o aheader e o acols da tabela ZC7
aHeaderZC7 	:= CriaHeader(aCamposZC7)//Cria o aheader da tabela ZC7
aColsZC7 	:= CriaAcZC7( ZC2->ZC2_CADAST, ZC2->ZC2_CODCIA )//Cria o acols da tabela ZC7


//Montagem da tela
DEFINE DIALOG oDlg TITLE "Monitor Cadastros- E-commerce" SIZE nWStage,nHStage PIXEL STYLE nOr(WS_VISIBLE,WS_OVERLAPPEDWINDOW)

//Cria instancia do fwlayer
oFWLayer := FWLayer():New()

//Inicializa componente passa a Dialog criada,o segundo parametro é para
//criação de um botao de fechar utilizado para Dlg sem cabeçalho
oFWLayer:Init( oDlg, .T. )

// Efetua a montagem das colunas das telas
oFWLayer:AddCollumn( "Col01", 100, .T. )


// Cria windows passando, nome da coluna onde sera criada, nome da window
// titulo da window, a porcentagem da altura da janela, se esta habilitada para click,
// se é redimensionada em caso de minimizar outras janelas e a ação no click do split
oFWLayer:AddWindow( "Col01", "Win01", "Processo", 25, .F., .T., ,,)
oFWLayer:AddWindow( "Col01", "Win02", "Detalhe", 75 , .F., .T., {|| .T. },,)


oWin01 := oFWLayer:getWinPanel('Col01','Win01')
oWin02 := oFWLayer:getWinPanel('Col01','Win02')

oTMultiget := TMultiGet():New( 005,005, {|u| if( Pcount()>0, cGet:= u, cGet) },oWin02,200,160,,.T.,CLR_BLACK,CLR_WHITE,,.T.,"",,,.F.,.F.,.T.,,,.F.,,.T.)

//Cria a getdados da tabela ZC2
oGetDZC2 := MsNewGetDados():New(005,005,(aSize[4]*65/100)-40,aSize[3]-30 ,0 ,"","","",,,9999,"AllWaysTrue()",,,oWin01,aHeaderZC2,aColsZC2)


//Cria a getdados da tabela ZC7
oGetDZC7 := MsNewGetDados():New(005,210,(aSize[4]*65/100)-40,aSize[3]-30 ,0 ,"","","",,,9999,"AllWaysTrue()",,,oWin02,aHeaderZC7,aColsZC7, {||RefresDet(GdFieldGet("ZC7_OBS")) })

//Atualiza o monitor a cada 1 segundo.
oTimer:= TTimer():New(1000,{|| RefrMonitor() },oDlg) // Ativa timer
oTimer:Activate()

SA1->(DbSetOrder(1))
If ZC2->ZC2_CADAST='CLIENTE' .And. SA1->(MsSeek(xFilial("ZC2")+ZC2->ZC2_CODERP ))
	oMenu := TMenu():New(0,0,0,0,.T.)
	
	oMenu:Add(TMenuItem():New(oDlg,'Alterar'	,,,,{|| COM15CLI("A")  },,,,,,,,,.T.))
	oMenu:Add(TMenuItem():New(oDlg,'Visualisar',,,, {||COM15CLI("V")  },,,,,,,,,.T.))
	
	oButCli		:= TButton():New( (aSize[4]*65/100)-35, aSize[3]-113,"Cliente",oWin02,{ || }, 50,10,,,.F.,.T.,.F.,,.F.,,,.F. )
	oButCli:SetPopupMenu(oMenu)
EndIf

oButSair	:= TButton():New( (aSize[4]*65/100)-35, aSize[3]-60, "Sair",oWin02,{ || oDlg:End() }, 30,10,,,.F.,.T.,.F.,,.F.,,,.F. )



ACTIVATE DIALOG oDlg CENTERED

RestArea(aArea)
Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³RefrMonitorºAutor  ³            	         º Data ³  02/2014	  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina de atualização do monitro							  º±±
±±º          ³			                                                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function RefrMonitor()

Local aArea := GetArea()

aColsZC2 := CriaAcZC2( ZC2->ZC2_CADAST, ZC2->ZC2_CODCIA )//Cria o acols da tabela ZC7
aColsZC7 := CriaAcZC7( ZC2->ZC2_CADAST, ZC2->ZC2_CODCIA )//Cria o acols da tabela ZC7

oGetDZC2:Acols := aColsZC2
oGetDZC2:Refresh()

oGetDZC7:Acols := aColsZC7
oGetDZC7:Refresh()


RestArea(aArea)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³RefresDetºAutor  ³            	         º Data ³  02/2014	  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Atualiza o campo de detalhe do monitor, na mudança de linha º±±
±±º          ³do acols                                                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function RefresDet(cObs)
Local aArea 	:= GetArea()
Default cObs	:= ""

cGet := cObs
oTMultiget:Refresh()

RestArea(aArea)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CriaHeaderºAutor  ³            	         º Data ³  02/2014	  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Cria o aHeader						                   	  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
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
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CriaAcolsZC7ºAutor  ³                      º Data ³  02/2014	  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Cria e atualiza o aCols                                     º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function CriaAcZC7( cCadastro, cCodCiaShop )
Local aArea    	:= GetArea()
Local aStruct	 	:= {}
Local nX				:= 0
Local aRet			:= {}
Local cQuery		:= ""
Local cAliasTmp := GetNextAlias()

cQuery :="SELECT utl_raw.cast_to_varchar2(DBMS_LOB.SUBSTR(ZC7_OBS,2000,1)) ZC7_OBS, "+CRLF
cQuery +=" ZC7_ACAO,  ZC7_DATA, ZC7_HORA, ZC7_USUARI, ZC7_ERRO, R_E_C_N_O_ RECNOZC7 "
cQuery +=" FROM "+RetSqlName("ZC7")+" ZC7 "+CRLF
cQuery +=" WHERE ZC7_FILIAL='"+xFilial("ZC7")+"'"
cQuery +=" AND ZC7_CADAST = '"+cCadastro+"' "+CRLF
cQuery +=" AND ZC7_CODCIA = '"+cCodCiaShop+"' "+CRLF
cQuery +=" AND D_E_L_E_T_ = ' ' "+CRLF
cQuery += " ORDER BY ZC7_DATA,ZC7_HORA DESC "+CRLF

cQuery := ChangeQuery(cQuery)
dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cAliasTmp,.T.,.T.)

aStruct   := ZC7->(dbStruct())
For nX := 1 To Len(aStruct)
	If aStruct[nX][2] <> "C" .And. FieldPos( aStruct[nX][1] ) <> 0
		TcSetField( cAliasTmp, aStruct[nX][1], aStruct[nX][2], aStruct[nX][3], aStruct[nX][4] )
	EndIf
Next nX

aRet := {}
(cAliasTmp)->(DbGoTop())
While (cAliasTmp)->(!Eof())
	
	aAdd(aRet,{(cAliasTmp)->ZC7_ACAO,;
	(cAliasTmp)->ZC7_DATA,;
	(cAliasTmp)->ZC7_HORA  ,;
	(cAliasTmp)->ZC7_USUARI  ,;
	Iif((cAliasTmp)->ZC7_ERRO == "S","Sim","Não")  ,;
	Alltrim((cAliasTmp)->ZC7_OBS)   ,;
	,.F.})
	(cAliasTmp)->(dbSkip())
EndDo

(cAliasTmp)->(DbCloseArea())

RestArea( aArea )
Return aRet



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CriaAcolsZC2ºAutor  ³                      º Data ³  02/2014    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Cria e atualiza o aCols                                     º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function CriaAcZC2( cCadastro, cCodCiaShop )
Local aRet:={}

aAdd(aRet,{ZC2->ZC2_CADAST,ZC2->ZC2_CODCIA,ZC2->ZC2_NOME,.F.})

Return aRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCECOM15  ºAutor  ³Microsiga           º Data ³  04/29/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function COM15INIT(cCampo)
Local uRetorno:=CriaVar(cCampo,.F.)

SA1->(DbSetOrder(1))//A1_FILIAL+A1_COD+A1_LOJA
If SA1->(MsSeek(xFilial()+ZC2->ZC2_CODERP+"01" ))
	
	
	Do Case
		Case cCampo=="ZC2_PESSOA"
			uRetorno:=Iif(SA1->A1_PESSOA=="J","Juridica","Fisica")
		Case cCampo=="ZC2_BLOQUE"
			uRetorno:=IIf(SA1->A1_MSBLQL=="1","Sim","Nao")
		Case cCampo=="ZC2_CODVEN"
			uRetorno:=SA1->A1_VEND
		Case cCampo=="ZC2_NOMEVE"
			SA3->(DbSetOrder(1))//A3_FILIAL+A3_COD
			SA3->(MsSeek(xFilial("SA3")+SA1->A1_VEND ))
			uRetorno:=SA3->A3_NOME
		Case cCampo=="ZC2_CANAL"
			uRetorno:=SA1->A1_YCANAL
		Case cCampo=="ZC2_DESCCA"
			ACA->(DbSetOrder(1))//ACA_FILIAL+ACA_GRPREP
			ACA->(MsSeek(xFilial("SA3")+SA1->A1_YCANAL))
			uRetorno:=ACA->ACA_DESCRI
	EndCase
	
EndIf

Return uRetorno


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCECOM15  ºAutor  ³Microsiga           º Data ³  04/29/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function ZC5TOZC2()
Local cQuery
Local cAlias:=GetNextAlias()
Local cFilZC2
//Local nConecOld := AdvConnection()
//Local nConection := TcLink(  'MSSQL7' +"/"+ 'REPLICA' ,  '127.0.0.1' , 0  )


RpcSetType(3)
RpcSetEnv("01","03")


cFilZC2:=xFilial("ZC2")


cQuery:=" Select ZC5.R_E_C_N_O_ RECZC5 From "+RetSqlName("ZC5")+" ZC5"
cQuery+=" Where ZC5_FILIAL='"+xFilial("ZC5")+"'"
cQuery+=" And ZC5_CADAST ='CLIENTE'"
//cQuery+=" And ZC5_FLAG='1'"
cQuery+=" And D_E_L_E_T_=' '" 
cQuery+=" Order by 1 "
DbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQuery),cAlias  ,.F.,.T.)

Do While !(cAlias)->(Eof())
	
	ZC5->(DbGoTo((cAlias)->RECZC5))
	
	cCadastro:=AllTrim(ZC5->ZC5_CADAST)
	
	If  cCadastro=="CLIENTE"
		
		cQuery:=" Select SA1.R_E_C_N_O_ RECSA1 From "+RetSqlName("SA1")+" SA1"
		cQuery+=" Where A1_FILIAL='"+xFilial("SA1")+"'"
		If Len(AllTrim(ZC5->ZC5_CODCIA))>5
			cQuery+=" And A1_CGC Like '"+ZC5->ZC5_CODCIA+"%'"
			M->ZC2_CADAST:="CLIENTE_EX"
		Else                       
			M->ZC2_CADAST:="CLIENTE"
			cQuery+=" And A1_ZCODCIA ='"+ZC5->ZC5_CODCIA+"'"
		EndIf
		cQuery+=" And SA1.D_E_L_E_T_=' '"
		//cQuery+=" And Not Exists( Select 'x' From "+RetSqlName("ZC2")+" ZC2 Where ZC2_CADAST='"+cCadastro+"' And ZC2_CODERP=A1_COD And ZC2.D_E_L_E_T_=' ')"
		
		DbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQuery),"__SA1"  ,.F.,.T.)
		
		nRecno:=__SA1->RECSA1
		__SA1->(DbCloseArea())
		
		If nRecno>0
			SA1->(DbGoTo(nRecno))
			
			Begin Transaction
			ZC2->(RecLock("ZC2",.T.))
			ZC2->ZC2_FILIAL:=cFilZC2
			ZC2->ZC2_CADAST:=M->ZC2_CADAST
			ZC2->ZC2_CODERP:=SA1->A1_COD
			ZC2->ZC2_CODCIA:=AllTrim(Str(SA1->A1_ZCODCIA))
			ZC2->ZC2_CNPJ  :=SA1->A1_CGC
			ZC2->ZC2_NOME  :=SA1->A1_NOME

			
			cQuery :="SELECT MAX(R_E_C_N_O_) RECZC7 "+CRLF
			cQuery +=" FROM "+RetSqlName("ZC7")+" ZC7 "+CRLF
			cQuery +=" WHERE ZC7_FILIAL='"+xFilial("ZC7")+"'"
			cQuery +=" AND ZC7_CADAST = 'CLIENTE' "+CRLF
			cQuery +=" AND ZC7_CODCIA = '"+ZC2->ZC2_CODCIA+"' "+CRLF
			cQuery +=" AND D_E_L_E_T_ = ' ' "+CRLF
			
			DbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQuery),"__ZC7"  ,.F.,.T.)
		
			nRecno:=__ZC7->RECZC7
			__ZC7->(DbCloseArea())
			
			If nRecno>0
				ZC7->(DbGoTo(nRecno))
				ZC2->ZC2_ERRO:=ZC7->ZC7_ERRO
			EndIf	
			DbSelectArea("ZC2")
			ZC2->(MsUnLock())
			
			
			
			End Transaction
		EndIf
	EndIf
	
	
	
	
	(cAlias)->(DbSkip())
EndDo



Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCECOM15  ºAutor  ³Microsiga           º Data ³  05/08/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function COM15CLI(cTipo)
Local aRotAtual	:=aClone(aRotina)
Local aAreaAtu	:=GetArea()

_SetOwnerPrvt("aRotAuto")
_SetOwnerPrvt("CCADASTRO","Cadastro de Cliente")

aRotina := { 	{"Pesquisar","PesqBrw"    , 0 , 1,0 ,.F.},{"Visualizar", "A030Visual" , 0 , 2,0   , NIL},{"Incluir", "A030Inclui" , 0 , 3,81  , NIL},{"Alterar", "A030Altera" , 0 , 4,143 , NIL},{"Excluir", "A030Deleta" , 0 , 5,144 , NIL}}



SA1->(DbSetOrder(1))

If SA1->(MsSeek(xFilial("ZC2")+ZC2->ZC2_CODERP ))
	
	If cTipo=="V"
		INCLUI:=.F.
		ALTERA:=.F.
		A030Visual("SA1",SA1->(Recno()),2)
	Else
		INCLUI:=.F.
		ALTERA:=.T.
		A030Altera("SA1",SA1->(Recno()),4)
	EndIf
EndIf          

aRotina:=aClone(aRotAtual)
RestArea(aAreaAtu)

Return
