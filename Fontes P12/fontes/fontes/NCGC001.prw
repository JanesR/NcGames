#INCLUDE "PROTHEUS.CH"
#INCLUDE "msgraphi.ch"
#INCLUDE "APWIZARD.CH"


#Define	BMPSAIR	"FINAL.PNG"       
#Define BMPRFSH "PMSRRFSH.PNG"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGC0001  ºAutor  ³Elton C.            º Data ³  13/09/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Browse do monitor de processos Midia e Software             º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NC Games                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function NCGC0001()

Local aArea := GetArea()

Private aCores    := {;
						{"!Empty(PZ1_DTEXCL)"	, "BR_VERMELHO", "Processo Excluído"  },;
						{"Empty(PZ1_DTEXCL)"	, "BR_VERDE"   , "Processo Normal"  };
					  }
                                    

Private aRotina := {;
						{"Pesquisar","AxPesqui",0,1} ,;
						{"Monitor","u_NcMonMs",0,2},;
						{"Legenda","u_NCGC01Leg",0,3};
					}

Private cCadastro := "Monitor - Mídia & Sftware"

dbSelectArea("PZ1")
dbSetOrder(1)
mBrowse( 6,1,22,75,"PZ1",,,,,,aCores)

RestArea(aArea)
Return        


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ NCGC01Leg ºAutor  ³Elton C.	         º Data ³  01/11/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Legenda do browse                                           º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function NCGC01Leg()
Local aLegenda := {}

aEval(aCores, {|z| Aadd(aLegenda, {z[2], z[3]})})
BrwLegenda(cCadastro, "Legenda", aLegenda)

Return(Nil)



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³  ºAutor  ³Elton C.	                 º Data ³  13/09/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Tela utilizada para mostrar o detalhe do processo           º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NC Games                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function NcMonMs(cAlias, nRecno, nOpc)

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
Local bSair			:= {|| oDlg:End() }//Sair
Local bAtu			:= {|| RefrMonitor()}//Atualiza o monitor
Local oButton		

Private aCamposPz2	:= {"PZ2_PVORIG","PZ2_FILORI","PZ2_ACAO","PZ2_DATA","PZ2_HORA","PZ2_USUARI","PZ2_OBS","PZ2_ERRO"}                      
Private aCamposPz1	:= {"PZ1_PVORIG","PZ1_PVDEST","PZ1_DOCSF2","PZ1_DOCSF1","PZ1_SERSF2","PZ1_SERSF1","PZ1_FILORI","PZ1_FILDES","PZ1_DSF2OR","PZ1_SSF2OR","PZ1_ROMAN"}
Private aHeaderPz1  := {}
Private aHeaderPz2  := {}
Private aColsPZ1 	:= {}
Private aColsPZ2 	:= {}
Private oGetDPz1	
Private oGetDPz2	
Private oTMultiget 			 
Private	cGet		:= ""

//Preenche o aheader e o acols da tabela pz1
aHeaderPz1 := CriaHeader(aCamposPz1)//Cria o aheader da tabela PZ2
aColsPZ1 := CriaAcPZ1( PZ1->PZ1_PVORIG )//Cria o acols da tabela PZ2

//Preenche o aheader e o acols da tabela pz2
aHeaderPz2 := CriaHeader(aCamposPz2)//Cria o aheader da tabela PZ2
aColsPZ2 := CriaAcPZ2( PZ1->PZ1_PVORIG )//Cria o acols da tabela PZ2

//Botoes do monitor
aAdd(aButton, { BMPSAIR		, BMPSAIR		, /*"Sair"*/	   	, bSair		, /*"Sair"*/  	}) 
aAdd(aButton, { BMPRFSH		, BMPRFSH		, /*"Atualizar"*/	   	, bAtu		, /*"Atualizar"*/  	}) 


//Montagem da tela
DEFINE DIALOG oDlg TITLE "Monitor - Midia & Software" SIZE nWStage,nHStage PIXEL STYLE nOr(WS_VISIBLE,WS_POPUP) //"Empresas"

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

//Cria a getdados da tabela PZ1
oGetDPz1 := MsNewGetDados():New(005,005,40,650 ,0 ,"","","",,,9999,"AllWaysTrue()",,,oWin01,aHeaderPz1,aColsPZ1)


//Cria a getdados da tabela PZ2
oGetDPz2 := MsNewGetDados():New(005,220,160,650 ,0 ,"","","",,,9999,"AllWaysTrue()",,,oWin02,aHeaderPz2,aColsPZ2, {||RefresDet(GdFieldGet("PZ2_OBS")) })



//Adiciona a barra dos botões
DEFINE BUTTONBAR oBarBtn SIZE 30,30 3D BOTTOM OF oWin02

oButton	:= TBtnBmp():NewBar( aButton[1,1],aButton[1,2],,,aButton[1,3], aButton[1,4],.T.,oBarBtn,,,aButton[1,5])
oButton:cTitle := aButton[1,3]
oButton:Align := CONTROL_ALIGN_RIGHT 

oButton	:= TBtnBmp():NewBar( aButton[2,1],aButton[2,2],,,aButton[2,3], aButton[2,4],.T.,oBarBtn,,,aButton[2,5])
oButton:cTitle := aButton[2,3]
oButton:Align := CONTROL_ALIGN_RIGHT 
                                                                                                              

ACTIVATE DIALOG oDlg CENTERED

RestArea(aArea)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³RefrMonitorºAutor  ³Elton C.	         º Data ³  02/24/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina de atualização do monitro							  º±±
±±º          ³			                                                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function RefrMonitor()

Local aArea := GetArea()

aColsPZ1 := CriaAcPZ1( PZ1->PZ1_PVORIG )//Cria o acols da tabela PZ2
aColsPZ2 := CriaAcPZ2( PZ1->PZ1_PVORIG )//Cria o acols da tabela PZ2

oGetDPz1:Acols := aColsPZ1
oGetDPz1:ForceRefresh()

oGetDPz2:Acols := aColsPZ2
oGetDPz2:ForceRefresh()

RestArea(aArea)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³RefresDetºAutor  ³Elton C.	         º Data ³  02/24/10   º±±
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
±±ºPrograma  ³CriaHeaderºAutor  ³Elton C.	         º Data ³  02/24/10   º±±
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
±±ºPrograma  ³CriaAcolsPZ2ºAutor  ³Elton C.          º Data ³  13/09/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Cria e atualiza o aCols                                     º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function CriaAcPZ2( cPvOri )
Local aArea    		:= GetArea()
Local aStruct	 	:= {}
Local nX			:= 0
Local aRet			:= {}
Local cAliasTmp		:= ""
Local cQuery		:= ""

Default cPvOri	:= ""

cAliasTmp := GetNextAlias()

cQuery := "SELECT utl_raw.cast_to_varchar2(DBMS_LOB.SUBSTR(PZ2_OBS,2000,1)) PZ2_OBS, "+CRLF
cQuery += " PZ2_PVORIG,PZ2_FILORI,PZ2_ACAO,PZ2_DATA,PZ2_HORA,PZ2_USUARI,PZ2_OBS,PZ2_ERRO, R_E_C_N_O_ RECNOPZ2 FROM "+RetSqlName("PZ2")+" PZ2 "+CRLF
cQuery += " WHERE D_E_L_E_T_ = ' ' "+CRLF
cQuery += " AND PZ2_PVORIG = '"+cPvOri+"' "+CRLF
cQuery += " ORDER BY R_E_C_N_O_ "+CRLF     

cQuery := ChangeQuery(cQuery)
dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cAliasTmp,.T.,.T.)

aStruct   := PZ2->(dbStruct())
For nX := 1 To Len(aStruct)
	If aStruct[nX][2] <> "C" .And. FieldPos( aStruct[nX][1] ) <> 0
		TcSetField( cAliasTmp, aStruct[nX][1], aStruct[nX][2], aStruct[nX][3], aStruct[nX][4] )
	EndIf
Next nX
 
aRet := {}

(cAliasTmp)->(DbGoTop())
While (cAliasTmp)->(!Eof())

	aAdd(aRet,{(cAliasTmp)->PZ2_PVORIG,;
				(cAliasTmp)->PZ2_FILORI,;
				(cAliasTmp)->PZ2_ACAO  ,;
				(cAliasTmp)->PZ2_DATA  ,;
				(cAliasTmp)->PZ2_HORA  ,;
				(cAliasTmp)->PZ2_USUARI,;
				(cAliasTmp)->PZ2_OBS   ,;
				Iif((cAliasTmp)->PZ2_ERRO == "S","Sim","Não")  ,;
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
±±ºPrograma  ³CriaAcolsPZ3ºAutor  ³Elton C.          º Data ³  13/09/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Cria e atualiza o aCols                                     º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function CriaAcPZ1( cPvOri )
Local aArea    		:= GetArea()
Local aStruct	 	:= {}
Local nX			:= 0
Local aRet			:= {}
Local cAliasTmp		:= ""
Local cQuery		:= ""

Default cPvOri	:= ""

cAliasTmp := GetNextAlias()

cQuery := "SELECT * FROM "+RetSqlName("PZ1")
cQuery += " WHERE D_E_L_E_T_ = ' ' "
cQuery += " AND PZ1_PVORIG = '"+cPvOri+"'" "

cQuery := ChangeQuery(cQuery)
dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cAliasTmp,.T.,.T.)

aStruct   := PZ1->(dbStruct())
For nX := 1 To Len(aStruct)
	If aStruct[nX][2] <> "C" .And. FieldPos( aStruct[nX][1] ) <> 0
		TcSetField( cAliasTmp, aStruct[nX][1], aStruct[nX][2], aStruct[nX][3], aStruct[nX][4] )
	EndIf
Next nX
 
aRet := {}

(cAliasTmp)->(DbGoTop())
While (cAliasTmp)->(!Eof())

	aAdd(aRet,{(cAliasTmp)->PZ1_PVORIG,;
				(cAliasTmp)->PZ1_PVDEST,;
				(cAliasTmp)->PZ1_DOCSF2,;
				(cAliasTmp)->PZ1_DOCSF1,;
				(cAliasTmp)->PZ1_SERSF2,;
				(cAliasTmp)->PZ1_SERSF1,;
				(cAliasTmp)->PZ1_FILORI,;
				(cAliasTmp)->PZ1_FILDES,;
				(cAliasTmp)->PZ1_DSF2OR,;
				(cAliasTmp)->PZ1_SSF2OR,;
				(cAliasTmp)->PZ1_ROMAN,; 
				,.F.})

	(cAliasTmp)->(dbSkip())
EndDo

(cAliasTmp)->(DbCloseArea())

RestArea( aArea )
Return aRet

