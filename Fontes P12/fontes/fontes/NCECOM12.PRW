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
User Function NCECOM12() 
Local ACPOZC5	:={}
Local aArea 	:= GetArea()
Local cFiltro
Local cPerg		:=Padr("NCECOM12",Len(SX1->X1_GRUPO))


Private cCadastro := "Monitor Cadastro - E-commerce"
Private aRotina := {	{"Pesquisar","AxPesqui",0,1} ,	{"Monitor","u_COM12Manut",0,2}	}

//RPCSETENV("01","03")
//chkfile("ZC5")

//AADD(aCpoZC5,"ZC5_CADAST")
//AADD(aCpoZC5,"ZC5_CODCIA")
//AADD(aCpoZC5,"ZC5_NOMCIA")



AADD(aCpoZC5, {AvSx3("ZC5_CADAST",5),"ZC5_CADAST"  })
AADD(aCpoZC5, {AvSx3("ZC5_CODCIA",5),"ZC5_CODCIA"  })
AADD(aCpoZC5, {AvSx3("ZC5_NOMCIA",5),"ZC5_NOMCIA"  })

//oBrowse := FWMBrowse():New() 
//oBrowse:SetOnlyFields( aCpoZC5 ) 
//oBrowse:SetAlias("ZC5")    
                     
      
      
cFiltro:="ZC5_FLAG='1'"
PutSx1(cPerg,"01","Mostrar Cadastro" ,"","","mv_ch1","C",1,0,1,"C","","","","","mv_par01","Com Erro","Com Erro","Com Erro","","Sem Erro","Sem Erro","Sem Erro","Todos","Todos","Todos","","","","","","")//,aHelpP11,aHelpE11,aHelpS11)
If Pergunte(cPerg)
	If mv_par01<>3
		cFiltro+=" And Exists ( Select 'X' From "+RetSqlName("ZC7")+" ZC7 Where ZC7_FILIAL=ZC5_FILIAL And  ZC7_CADAST=ZC5_CADAST  AND  ZC7_CODCIA=ZC5_CODCIA AND ZC7_ERRO='"+Iif(mv_par01==1,"S","N")+"'  AND ZC7.D_E_L_E_T_=' ')"	
	EndIf
EndIf               

     
                       
//oBrowse:SetFilterDefault(cFiltro)
//oBrowse:SetDescription(cCadastro) 
//oBrowse:Activate() 
MBrowse(,,,,"ZC5",aCpoZC5,,,,,,,,,,,,,cFiltro)


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
User Function COM12Manut(cAlias, nRecno, nOpc)
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
                                                

Local aCamposZC5	:= {"ZC5_CADAST","ZC5_CODCIA","ZC5_NOMCIA"}
Local aCamposZC7	:= {"ZC7_ACAO","ZC7_DATA","ZC7_HORA","ZC7_USUARI","ZC7_ERRO","ZC7_OBS"}

Private aHeaderZC5  := {}
Private aHeaderZC7  := {}
Private aColsZC5 	:= {}
Private aColsZC7 	:= {}
Private oGetDZC5	
Private oGetDZC7	
Private oTMultiget 			 
Private cGet		:= ""     
Private aSize		:= MsAdvSize(.T.)

//Preenche o aheader e o acols da tabela ZC5
aHeaderZC5 	:= CriaHeader(aCamposZC5)//Cria o aheader da tabela ZC7
aColsZC5 	:= CriaAcZC5( ZC5->ZC5_CADAST, ZC5->ZC5_CODCIA )//Cria o acols da tabela ZC7

//Preenche o aheader e o acols da tabela ZC7
aHeaderZC7 	:= CriaHeader(aCamposZC7)//Cria o aheader da tabela ZC7
aColsZC7 	:= CriaAcZC7( ZC5->ZC5_CADAST, ZC5->ZC5_CODCIA )//Cria o acols da tabela ZC7


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

//Cria a getdados da tabela ZC5
oGetDZC5 := MsNewGetDados():New(005,005,(aSize[4]*65/100)-40,aSize[3]-30 ,0 ,"","","",,,9999,"AllWaysTrue()",,,oWin01,aHeaderZC5,aColsZC5)
                                                            

//Cria a getdados da tabela ZC7
oGetDZC7 := MsNewGetDados():New(005,210,(aSize[4]*65/100)-40,aSize[3]-30 ,0 ,"","","",,,9999,"AllWaysTrue()",,,oWin02,aHeaderZC7,aColsZC7, {||RefresDet(GdFieldGet("ZC7_OBS")) })

//Atualiza o monitor a cada 1 segundo.
oTimer:= TTimer():New(1000,{|| RefrMonitor() },oDlg) // Ativa timer
oTimer:Activate()

oButSair		:= TButton():New( (aSize[4]*65/100)-35, aSize[3]-60, "Sair",oWin02,{ || oDlg:End() }, 30,10,,,.F.,.T.,.F.,,.F.,,,.F. )
          
             
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

aColsZC5 := CriaAcZC5( ZC5->ZC5_CADAST, ZC5->ZC5_CODCIA )//Cria o acols da tabela ZC7
aColsZC7 := CriaAcZC7( ZC5->ZC5_CADAST, ZC5->ZC5_CODCIA )//Cria o acols da tabela ZC7

oGetDZC5:Acols := aColsZC5
oGetDZC5:Refresh()

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
±±ºPrograma  ³CriaAcolsZC5ºAutor  ³                      º Data ³  02/2014    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Cria e atualiza o aCols                                     º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                         
Static Function CriaAcZC5( cCadastro, cCodCiaShop )
Local aRet:={}

aAdd(aRet,{ZC5->ZC5_CADAST,ZC5->ZC5_CODCIA,ZC5->ZC5_NOMCIA,.F.})

Return aRet