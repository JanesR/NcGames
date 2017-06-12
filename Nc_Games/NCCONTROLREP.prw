#INCLUDE "PROTHEUS.CH"
#INCLUDE "msgraphi.ch"
#INCLUDE "APWIZARD.CH"
 

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCCONTRP  ºAutor  ³Elton C.            º Data ³  13/09/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Controle de repasse									      º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NC Games                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function NCCONTRP()

Local aArea 	:= GetArea()
Private aCores  	:= {;
						{"PZ6_VALUSA == 0"	, "BR_VERMELHO", "Não aplicado"  },;
						{"(PZ6_VALUSA != 0) .And. (PZ6_VALSLD != 0)"	, "BR_AMARELO"   , "Parcialmente aplicado"  },;
						{"(PZ6_VALUSA != 0) .And. (PZ6_VALSLD == 0)"	, "BR_VERDE"   , "Aplicado"  };
					  }

Private cCadastro := "Controle de repasse Price Protection - CLIENTE"
Private aRotina := MenuDef()

dbSelectArea("PZ6")
dbSetOrder(1)


mBrowse( 6,1,22,75,"PZ6",,,,,,aCores)

RestArea(aArea)
Return        
               



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³Menudef   º Autor ³ Elton C.		     º Data ³  29/09/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Cria o menu da MBrowse.                                    º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ 			                                                  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Menudef()


Local alRotina := {	{"&Pesquisar"		,"U_NCCRPAPe"	,0,1},;
					{"&Detalhe"			,"U_DetCtrRp"	,0,6},;
					{"&Legenda"			,"U_LEGCTRRP"	,0,2};
					}
Return alRotina


/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³NCCRPAPe  ³ Autor ³ELTON SANTANA		    ³ Data ³ 11/10/11 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Funcao para pesquisa                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ 								                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpC1 = Alias do arquivo                                   ³±±
±±³          ³ ExpN1 = Numero do registro                                 ³±±
±±³          ³ ExpN2 = Numero da opcao selecionada                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function NCCRPAPe(ciAlias,nReg,nOpcx)

Local cOrd		:= ""
Local cCampo	:= Space(40)
Local nOpca		:=0
Local nOpt1		:=0
Local nI			:=0
Local aOrd 		:= {"Cliente + Loja"}
Local bSav12 	:= SetKey(VK_F12)
Local oDlg
Local oCbx

SetKey( VK_F12, {||nil} )

cOrd := aOrd[1]

For ni:=1 to Len(aOrd)
	aOrd[nI] := OemToAnsi(aOrd[nI])
Next

If IndexOrd() >= Len(aOrd)
	cOrd 	:= aOrd[Len(aOrd)]
	nOpt1 := Len(aOrd)
ElseIf IndexOrd() <= 1
	cOrd := aOrd[1]
	nOpt1 := 1
Else
	cOrd := aOrd[1]
	nOpt1 := IndexOrd()
EndIf

DEFINE MSDIALOG oDlg FROM 5, 5 TO 14, 50 TITLE OemToAnsi("Buscar") //"Buscar"
@ 0.6,1.3 COMBOBOX oCBX VAR cOrd ITEMS aOrd  SIZE 165,44  ON CHANGE (nOpt1:=oCbx:nAt)  OF oDlg FONT oDlg:oFont
@ 2.1,1.3	MSGET cCampo SIZE 165,10
DEFINE SBUTTON FROM 055,122	TYPE 1 ACTION (nOpca := 1,oDlg:End()) ENABLE OF oDlg
DEFINE SBUTTON FROM 055,149.1 TYPE 2 ACTION (oDlg  :End()) ENABLE OF oDlg
ACTIVATE MSDIALOG oDlg CENTERED

If nOpca == 1
	dbSelectArea(ciAlias)
	nReg := RecNo()
	dbSetOrder(nOpt1)
	
	MsSeek(Alltrim(cCampo),.T.)
	If ! Found()
		Help(" ",1,"PESQ01")
		MsGoTo(nReg)
	EndIf
Else
	DbSelectArea(ciAlias)
EndIf

lRefresh := .T.
SetKey(VK_F12,bSav12)

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
User Function LEGCTRRP()
Local aLegenda := {}

aEval(aCores, {|z| Aadd(aLegenda, {z[2], z[3]})})
BrwLegenda(cCadastro, "Legenda", aLegenda)

Return(Nil)



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³DetCtrRp  ºAutor  ³Elton C.	         º Data ³  13/09/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Dealhe do controle de repasse						          º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NC Games                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function DetCtrRp(cAlias, nRecno, nOpc)

Local aArea := GetArea()
Local oDlg 
Local oWin01
Local oWin02   
Local oWin03
Local oFWLayer 
Local oFont        

Local aHeader		:= {}
Local aCols			:= {} 
Local aScreen 		:= GetScreenRes()
Local aObjects  	:= {}
Local nWStage 		:= aScreen[1]-75
Local nHStage 		:= aScreen[2]-225
Local nX			:= 0
Local aButton		:= {}
Local oBarBtn
Local bSair			:= {|| oDlg:End() }//Sair
Local bLegend		:= {||u_LEGCTRRP()}
Local bDetalhe		:= {||DetPP(oGetDPZ53:Acols[oGetDPZ53:nAt][2] ,oGetDPZ51:Acols[oGetDPZ51:nAt][2],;
								 oGetDPZ51:Acols[oGetDPZ51:nAt][3], oGetDPZ53:Acols[oGetDPZ53:nAt][4] )}

Local oButton		

Private aCpoPZ51	:= {"PZ5_STATUS","PZ5_CLIENT","PZ5_LOJA","PZ5_NOMCLI","PZ5_VALNCC","PZ5_VALUSA","PZ5_VALSLD"}//Acols com o detalhe do repasse aglutinado por cliente
Private aCpoPZ52	:= {"PZ5_STATUS","PZ5_CODPUB","PZ5_DPUBLI","PZ5_VALNCC","PZ5_VALUSA","PZ5_VALSLD"}//Acols com o detalhe do repasse aglutinado por publisher
Private aCpoPZ53	:= {"PZ5_STATUS","PZ5_CODPUB","PZ5_DPUBLI","PZ5_PPPUB", "PZ5_VALNCC","PZ5_VALUSA","PZ5_VALSLD"}//Acols com o detalhe do repasse aglutinado por codigo do publisher
Private aHeadPZ51 	:= {}
Private aHeadPZ52 	:= {}
Private aHeadPZ53 	:= {}              
Private aColsPZ51 	:= {}
Private aColsPZ52 	:= {}
Private aColsPZ53 	:= {}
Private oGetDPZ51	
Private oGetDPZ52	
Private oGetDPZ53
Private oTMultiget 			 
Private	cGet		:= ""

//Preenche o aheader e o acols da tabela pz1
aHeadPZ51 := CriaHeader(aCpoPZ51)//Cabeçalho com o detalhe de repasse por cliente
aHeadPZ52 := CriaHeader(aCpoPZ52)//Cabeçalho com o detalhe de repasse por codigo do publisher
aHeadPZ53 := CriaHeader(aCpoPZ53)//Cabeçalho com o detalhe de repasse por codigo de price protection

aColsPZ51 	:= CriaAcPZ51(PZ6->PZ6_CLIENT, PZ6->PZ6_LOJA )//Cria o acols com o detalhe de repasse por cliente
aColsPZ52	:= CriaAcPZ52(PZ6->PZ6_CLIENT, PZ6->PZ6_LOJA)//Cria o acols com o detalhe de repasse por publisher
aColsPZ53	:= CriaAcPZ53(PZ6->PZ6_CLIENT, PZ6->PZ6_LOJA)//Cria o acols com o detalhe de repasse por codigo de publisher


//Montagem da tela
DEFINE DIALOG oDlg TITLE "Controle de repasse Price Protection - CLIENTE" SIZE nWStage,nHStage PIXEL STYLE nOr(WS_VISIBLE,WS_OVERLAPPEDWINDOW) 

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
oFWLayer:AddWindow( "Col01", "Win01", "Cliente", 30, .F., .T., ,,) 
oFWLayer:AddWindow( "Col01", "Win02", "Publisher", 30, .F., .T., ,,) 
oFWLayer:AddWindow( "Col01", "Win03", "Campanha Publisher", 40, .F., .T., ,,) 

oWin01 	:= oFWLayer:getWinPanel('Col01','Win01')
oWin02 	:= oFWLayer:getWinPanel('Col01','Win02')
oWin03	:= oFWLayer:getWinPanel('Col01','Win03')

//Getdados com o controle de repasse com os dados do cliente
oGetDPZ51 := MsNewGetDados():New(001,001,52,638 ,0 ,"","","",,,9999,"AllWaysTrue()",,,oWin01,aHeadPZ51,aColsPZ51)

//Getdados com o controle de repasse com os dados do publisher
oGetDPZ52 := MsNewGetDados():New(001,001,52,638 ,0 ,"","","",,,9999,"AllWaysTrue()",,,oWin02,aHeadPZ52,aColsPZ52,;
								 {|| AtuAcPZ53( oGetDPZ51:Acols[oGetDPZ51:nAt][2], oGetDPZ51:Acols[oGetDPZ51:nAt][3], oGetDPZ52:Acols[oGetDPZ52:nAt][2] )})
                                                              
//Getdados com o controle de repasse com os dados da campanha publisher
oGetDPZ53 := MsNewGetDados():New(001,001,68,638 ,0 ,"","","",,,9999,"AllWaysTrue()",,,oWin03,aHeadPZ53,aColsPZ53)

//Adiciona os botões
//Botoes da tela de detalhe PP
oButSair		:= TButton():New(68, 475, "Sair",oWin03,bSair, 50,10,,,.F.,.T.,.F.,,.F.,,,.F. )
oButLegend		:= TButton():New(68, 530, "Legenda",oWin03,bLegend, 50,10,,,.F.,.T.,.F.,,.F.,,,.F. )
oButDetalh		:= TButton():New(68, 585, "Detalhe",oWin03,bDetalhe, 50,10,,,.F.,.T.,.F.,,.F.,,,.F. )


ACTIVATE DIALOG oDlg CENTERED

RestArea(aArea)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³DetPPºAutor  ³Elton C.		         º Data ³  02/24/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Cria o aHeader						                   	  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function DetPP(cCodPublis,cCodCli, cLoja, cCodCamp)

Local aArea := GetArea()
Local oDlg 
Local oWin01
Local oFWLayer 
Local oFont        

Local aHeader		:= {}
Local aCols			:= {} 
Local aScreen 		:= GetScreenRes()
Local aObjects  	:= {}
Local nWStage 		:= aScreen[1]-130
Local nHStage 		:= aScreen[2]-225
Local nX			:= 0
Local aButton		:= {}
Local oBarBtnPP
Local bSair			:= {|| oDlg:End() }//Sair
Local bLegend		:= {||u_LEGCTRRP()}
Local bDetalhe		:= {||MsgAlert("Detalhe")}
Local oButPed		
Local oButNF		
Local oButHisNCC		
Local oButPP
Local oButSair

Private aCpoPZ54	:= {"PZ5_STATUS","PZ5_CODPUB","PZ5_DPUBLI","PZ5_PPPUB","PZ5_CODPP",;
						"PZ5_VALNCC","PZ5_VALUSA","PZ5_VALSLD","PZ5_PREFIX", "PZ5_TITULO", "PZ5_PARCEL", "PZ5_TIPO"}//Acols com o detalhe do repasse aglutinado por Price Protection


Private aHeaderPZ54 := {}              
Private aColsPZ54 	:= {}
Private oGetDPZ54

Default cCodPublis	:= ""
Default cCodCli		:= "" 
Default cLoja		:= ""
Default cCodCamp	:= ""

//Preenche o aheader e o acols da tabela 
aHeaderPZ54 := CriaHeader(aCpoPZ54)//Cabeçalho com o detalhe de repasse por codigo de price protection
aColsPZ54	:= CriaAcPZ54( cCodCli, cLoja, cCodPublis, cCodCamp)//Cria o acols com o detalhe de repasse por codigo de PP

//Montagem da tela
DEFINE DIALOG oDlg TITLE "Controle de repasse Price Protection - CLIENTE" SIZE nWStage,nHStage PIXEL STYLE nOr(WS_VISIBLE,WS_OVERLAPPEDWINDOW) 

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
oFWLayer:AddWindow( "Col01", "oWin04", "Price Protection", 100, .F., .T., ,,) 
oWin04	:= oFWLayer:getWinPanel('Col01','oWin04') 

//Getdados com o controle de repasse com os dados do PP
oGetDPZ54 := MsNewGetDados():New(005,005,220,605 ,0 ,"","","",,,9999,"AllWaysTrue()",,,oWin04,aHeaderPZ54,aColsPZ54)
oGetDPZ54:Refresh()


//Botoes da tela de detalhe PP
oButNF		:= TButton():New( 225, 415, "Pedido \ NF.Saída",oWin04,{ ||VisPedNfs(oGetDPZ54:Acols[oGetDPZ54:nAt][9],oGetDPZ54:Acols[oGetDPZ54:nAt][10],;
																				 oGetDPZ54:Acols[oGetDPZ54:nAt][11], "NCC")}, 50,10,,,.F.,.T.,.F.,,.F.,,,.F. )

oButHisNCC	:= TButton():New( 225, 470, "Hist. NCC",oWin04,{ || VisHisNCC(oGetDPZ54:Acols[oGetDPZ54:nAt][9], oGetDPZ54:Acols[oGetDPZ54:nAt][10],;
																		  oGetDPZ54:Acols[oGetDPZ54:nAt][11], "NCC")}, 40,10,,,.F.,.T.,.F.,,.F.,,,.F. )


oButPP		:= TButton():New( 225, 515, "Price Protection",oWin04,{ || VisPP(oGetDPZ54:Acols[oGetDPZ54:nAt][5] )}, 50,10,,,.F.,.T.,.F.,,.F.,,,.F. )


oButSair	:= TButton():New( 225, 570, "Sair",oWin04,{ || oDlg:End() }, 30,10,,,.F.,.T.,.F.,,.F.,,,.F. )

ACTIVATE DIALOG oDlg CENTERED

RestArea(aArea)
Return        


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³VisPedNfsºAutor  ³Elton C.	         º Data ³  02/24/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina utilizada para visualizar os pedidos e NF de vendas º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßß#ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function VisPedNfs(cPrefixo,cNumTit, cParcela, cTipo)

Local aArea 	:= GetArea()
Local cQuery	:= ""
Local cArqTmp	:= GetNextAlias()
Local aCpoPVNF	:= {"F2_DOC","F2_SERIE","E1_PEDIDO","E1_CLIENTE","E1_LOJA","E1_NOMCLI"}
Local oDlg 
Local oWin01
Local oFWLayer 
Local oFont        
Local aScreen 		:= GetScreenRes()
Local aObjects  	:= {}
Local nWStage 		:= aScreen[1]-130
Local nHStage 		:= aScreen[2]-225
Local oGetDPVNF	
Local oButPed		
Local oButNF		
Local oButSair		


Private aAcolsPVNF 	:= {}
Private aHeadPVNF   := {}

Default cPrefixo	:= ""
Default cNumTit		:= "" 
Default cParcela	:= "" 
Default cTipo		:= ""

aHeadPVNF := CriaHeader(aCpoPVNF)

//Query utilizada para montar o Acols
cQuery := " SELECT DISTINCT SE1.E1_NUM TITULONCC, SE1.E1_PREFIXO PREFIXONCC, SE1.E1_TIPO TIPONCC, SE1.E1_PARCELA PARCELANCC, " +CRLF
cQuery += "         E5_NUMERO, E5_PREFIXO, E5_TIPO, E5_PARCELA, E5_DOCUMEN, SUBSTR(E5_DOCUMEN,1,3) PREFIXO, SUBSTR(E5_DOCUMEN,4,9) TITULOE5, "+CRLF
cQuery += "         SUBSTR(E5_DOCUMEN,13,1) PARCELAE5, SUBSTR(E5_DOCUMEN,14,3) TIPOE5, "+CRLF
cQuery += "         SE12.E1_NOMCLI NOMCLIBX, SE12.E1_NUM TITULOBX, SE12.E1_PREFIXO PREFIXOBX, SE12.E1_TIPO TIPOBX, SE12.E1_PARCELA PARCELABX, SE12.E1_CLIENTE CLIENTEBX, SE12.E1_LOJA LOJABX, "+CRLF
cQuery += "         F2_DOC, F2_SERIE, SE12.E1_PEDIDO PEDIDOBX"+CRLF
cQuery += "         FROM "+RetSqlName("SE1")+" SE1 "+CRLF

cQuery += " INNER JOIN "+RetSqlName("SE5")+" SE5 "+CRLF
cQuery += " ON SE5.D_E_L_E_T_ = ' ' "+CRLF
cQuery += " AND SE5.E5_FILIAL = '"+xFilial("SE5")+"' "+CRLF
cQuery += " AND SE5.E5_NUMERO = SE1.E1_NUM  "+CRLF
cQuery += " AND SE5.E5_PREFIXO = SE1.E1_PREFIXO  "+CRLF
cQuery += " AND SE5.E5_TIPO = SE1.E1_TIPO "+CRLF
cQuery += " AND SE5.E5_PARCELA = SE1.E1_PARCELA "+CRLF
cQuery += " AND SE5.E5_CLIENTE = SE1.E1_CLIENTE "+CRLF
cQuery += " AND SE5.E5_LOJA = SE1.E1_LOJA "+CRLF

cQuery += " INNER JOIN "+RetSqlName("SE1")+" SE12 "+CRLF
cQuery += " ON SE12.D_E_L_E_T_ = ' ' "+CRLF
cQuery += " AND SE12.E1_FILIAL = '"+xFilial("SE1")+"' "+CRLF
cQuery += " AND SE12.E1_PREFIXO = SUBSTR(SE5.E5_DOCUMEN,1,3) "+CRLF
cQuery += " AND SE12.E1_NUM = SUBSTR(SE5.E5_DOCUMEN,4,9) "+CRLF
cQuery += " AND SE12.E1_PARCELA = SUBSTR(SE5.E5_DOCUMEN,13,1) "+CRLF
cQuery += " AND SE12.E1_TIPO = SUBSTR(SE5.E5_DOCUMEN,14,3) "+CRLF

cQuery += " INNER JOIN "+RetSqlName("SF2")+" SF2 "	+CRLF
cQuery += " ON SF2.D_E_L_E_T_ = ' ' "+CRLF
cQuery += " AND SF2.F2_FILIAL = '"+xFilial("SF2")+"' "+CRLF
cQuery += " AND SF2.F2_DOC =  SE12.E1_NUM "+CRLF
cQuery += " AND SF2.F2_SERIE = SE12.E1_PREFIXO "+CRLF
cQuery += " AND SF2.F2_CLIENT = SE12.E1_CLIENTE "+CRLF
cQuery += " AND SF2.F2_LOJA = SE12.E1_LOJA "+CRLF

cQuery += " WHERE SE1.D_E_L_E_T_ = ' ' "+CRLF
cQuery += " AND SE1.E1_FILIAL = '"+xFilial("SE1")+"' "+CRLF
cQuery += " AND SE1.E1_PREFIXO = '"+cPrefixo+"' "+CRLF
cQuery += " AND SE1.E1_NUM = '"+cNumTit+"' "+CRLF
cQuery += " AND SE1.E1_PARCELA = '"+cParcela+"' "+CRLF
cQuery += " AND SE1.E1_TIPO = '"+cTipo+"' "+CRLF

//Aviso("Query", cQuery,{"Ok"},3)

cQuery := ChangeQuery(cQuery)
dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cArqTmp,.T.,.T.)

aAcolsPVNF 	:= {}

//Preenchimento do Acols
(cArqTmp)->(DbGoTop())
While (cArqTmp)->(!Eof())
    
	//Preenche o acols
	aAdd(aAcolsPVNF,{(cArqTmp)->F2_DOC,;
				(cArqTmp)->F2_SERIE,;
				(cArqTmp)->PEDIDOBX,;
				(cArqTmp)->CLIENTEBX,;
				(cArqTmp)->LOJABX,;
				(cArqTmp)->NOMCLIBX,;
				,.F.})
	
	(cArqTmp)->(DbSkip())
EndDo                 

If Len(aAcolsPVNF) > 0
	//Montagem da tela
	DEFINE DIALOG oDlg TITLE "Controle de repasse Price Protection - CLIENTE" SIZE nWStage,nHStage PIXEL STYLE nOr(WS_VISIBLE,WS_OVERLAPPEDWINDOW)
	
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
	oFWLayer:AddWindow( "Col01", "oWin01", "Nota Fiscal \ Pedido - NCC", 100, .F., .T., ,,)
	oWin01	:= oFWLayer:getWinPanel('Col01','oWin01')
	
	//{"F2_DOC","F2_SERIE","E1_PEDIDO","E1_CLIENTE","E1_LOJA","E1_NOMCLI"}	
	
	//Getdados com o controle de repasse com os dados do PP
	oGetDPVNF := MsNewGetDados():New(005,005,220,605 ,0 ,"","","",,,9999,"AllWaysTrue()",,,oWin01,aHeadPVNF,aAcolsPVNF)
	oButPed		:= TButton():New( 225, 470, "Pedido",oWin01,{ || VisPedido(oGetDPVNF:Acols[oGetDPVNF:nAt][3])}, 40,10,,,.F.,.T.,.F.,,.F.,,,.F. )

	oButNF		:= TButton():New( 225, 515, "NF. Saída",oWin01,{ ||	VisNfs(oGetDPVNF:Acols[oGetDPVNF:nAt][1],oGetDPVNF:Acols[oGetDPVNF:nAt][2],; 
																	oGetDPVNF:Acols[oGetDPVNF:nAt][4], oGetDPVNF:Acols[oGetDPVNF:nAt][5])};
								, 50,10,,,.F.,.T.,.F.,,.F.,,,.F. )

	oButSair	:= TButton():New( 225, 570, "Sair",oWin01,{ || oDlg:End() }, 30,10,,,.F.,.T.,.F.,,.F.,,,.F. )

	
	ACTIVATE DIALOG oDlg CENTERED
	
	
Else
	Aviso("Dados não encontrado", "Não existe pedido e/ou nota fiscal para esta NCC",{"Ok"},2)
EndIf

(cArqTmp)->(DbCloseArea())

RestArea(aArea)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³VisPPºAutor  ³Elton C.	         º Data ³  02/24/10   	  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Visualiza price protection			                   	  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßß#ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/  
Static Function VisPP(cCodPP)

Local aArea := GetArea()

Private cAlias1 := "P05"
Private cAlias2 := "P06" 

Default cCodPP := ""

DbSelectArea("P05")
DbSetOrder(1)
If P05->(DbSeek(xFilial("P05") + cCodPP))

	//Chama a rotina para visualizar o Price Protection
	u_PR102Manut("P05", P05->(Recno()), 2)
Else
	Aviso("Não encontrado", "Price Protection não encontrado "+cCodPP, {"Ok"},2)
EndIf


RestArea(aArea)
Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³VisPedidoºAutor  ³Elton C.	         º Data ³  02/24/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Visualiza pedido de vendas			                   	  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßß#ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function VisPedido(cPedido)

Local aArea := GetArea()

Default cPedido := ""

DbSelectArea("SC5")
DbSetOrder(1)


If SC5->(DbSeek(xFilial("SC5") + cPedido))
	
	VISUAL := .T.
	
	//Chama a rotina para visualizar o pedido de venda	
	A410Visual("SC5",SC5->(Recno()),1)
	
	VISUAL := .F.
Else 
	Aviso("Não encontrado", "Pedido não encontrado "+cPedido, {"Ok"},2)
	
EndIf

RestArea(aArea)
Return   


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³VisNfsºAutor  ³Elton C.	         º	   Data ³  02/24/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Visualiza nota fiscal de vendas		                   	  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßß#ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function VisNfs(cDoc, cSerie, cClient, cLoja)
Local aArea := GetArea()

Default cDoc	:= "" 
Default cSerie	:= "" 
Default cClient	:= "" 
Default cLoja	:= ""

DbSelectArea("SF2")
DbSetOrder(1)

If SF2->(DbSeek(xFilial("SF2") + PADR(cDoc,TAMSX3("F2_DOC")[1]) + PADR(cSerie, TAMSX3("F2_SERIE")[1]);
		 		+ PADR(cClient,TAMSX3("F2_CLIENT")[1]) + PADR(cLoja,TAMSX3("F2_LOJA")[1]) ))
	
	//Chama a rotina para visualizar a Nota Fiscal de Saida
	Mc090Visual("SF2",SF2->(Recno()),2)
Else 
	Aviso("Não encontrado", "Nota fiscal não encontrada "+cDoc+"/"+cSerie, {"Ok"},2)
EndIf

RestArea(aArea)
Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³VisHisNCCºAutor  ³Elton C.	      º	   Data ³  02/24/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Visualiza historico da NCC			                   	  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßß#ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function VisHisNCC(cPrefixo, cTitulo, cParcela, cTipo)
Local aArea := GetArea()

Default cPrefixo	:= "" 
Default cTitulo		:= "" 
Default cParcela	:= ""
Default cTipo		:= ""

DbSelectArea("SE1")
DbSetOrder(1)
alAreaSE1	:=	SE1->(GetArea())

If SE1->(DbSeek(xFilial("SE1") + PADR(cPrefixo, TAMSX3("E1_PREFIXO")[1]) + PADR(cTitulo, TAMSX3("E1_NUM")[1]) ;
				+ PADR(cParcela,TAMSX3("E1_PARCELA")[1]) + PADR(cTipo,TAMSX3("E1_TIPO")[1]) ))

	//CHama a rotina para consultar a NCC
	Fc040Con()
Else 
	Aviso("Não encontrado", "NCC não encontrada. Prefixo: "+cPrefixo+" Titulo: "+cTitulo+" Parcela: "+cParcela+" Tipo: "+cTipo, {"Ok"},2)
EndIf

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
±±ºPrograma  ³CriaAcPZ51ºAutor  ³Elton C. 	         º Data ³  13/09/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Cria e atualiza o aCols aglutinado por cliente              º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function CriaAcPZ51( cCodCli, cLoja )
Local aArea    		:= GetArea()
Local aStruct	 	:= {}
Local nX			:= 0
Local aRet			:= {}
Local cAliasTmp		:= ""
Local cQuery		:= ""

Default cCodCli		:= "" 
Default cLoja		:= ""

cAliasTmp := GetNextAlias()

cQuery := " SELECT PZ5_CLIENT, A1_NREDUZ AS PZ5_NOMCLI,PZ5_LOJA,SUM(PZ5_VALNCC) PZ5_VALNCC, "+CRLF
cQuery += " SUM(PZ5_VALUSA) PZ5_VALUSA, SUM(PZ5_VALSLD) PZ5_VALSLD FROM "+RetSqlName("PZ5")+" PZ5 "+CRLF

cQuery += " INNER JOIN "+RetSqlName("SA1")+" SA1 "+CRLF
cQuery += " ON SA1.D_E_L_E_T_ = ' ' "+CRLF
cQuery += " AND SA1.A1_FILIAL = '"+xFilial("SA1")+"' "+CRLF
cQuery += " AND SA1.A1_COD = PZ5.PZ5_CLIENT "+CRLF
cQuery += " AND SA1.A1_LOJA = PZ5.PZ5_LOJA "+CRLF

cQuery += " WHERE PZ5.D_E_L_E_T_ = ' ' "+CRLF
cQuery += " AND PZ5.PZ5_FILIAL = '"+xFilial("PZ5")+"' "+CRLF
cQuery += " AND PZ5.PZ5_CLIENT = '"+cCodCli+"' "+CRLF
cQuery += " AND PZ5.PZ5_LOJA = '"+cLoja+"' "+CRLF
cQuery += " GROUP BY PZ5_CLIENT, PZ5_LOJA, A1_NREDUZ "+CRLF


cQuery := ChangeQuery(cQuery)
dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cAliasTmp,.T.,.T.)

aStruct   := PZ5->(dbStruct())
For nX := 1 To Len(aStruct)
	If aStruct[nX][2] <> "C" .And. FieldPos( aStruct[nX][1] ) <> 0
		TcSetField( cAliasTmp, aStruct[nX][1], aStruct[nX][2], aStruct[nX][3], aStruct[nX][4] )
	EndIf
Next nX
 
aRet := {}

(cAliasTmp)->(DbGoTop())
While (cAliasTmp)->(!Eof())

	aAdd(aRet,{u_NcStsCR((cAliasTmp)->PZ5_VALUSA, (cAliasTmp)->PZ5_VALSLD),;
				(cAliasTmp)->PZ5_CLIENT,;
				(cAliasTmp)->PZ5_LOJA,;
				(cAliasTmp)->PZ5_NOMCLI,;
				(cAliasTmp)->PZ5_VALNCC,;
				(cAliasTmp)->PZ5_VALUSA,;
				(cAliasTmp)->PZ5_VALSLD,;
				,.F.})
                              
	(cAliasTmp)->(dbSkip())
EndDo

(cAliasTmp)->(DbCloseArea())

If Len(aRet) == 0
	aAdd(aRet,{"","","","","",0,0,0,.F.})
EndIf

RestArea( aArea )
Return aRet



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CriaAcPZ52ºAutor  ³Elton C. 	         º Data ³  13/09/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Cria e atualiza o aCols aglutinado por codigo de Publisher  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function CriaAcPZ52( cCodCli, cLoja)
Local aArea    		:= GetArea()
Local aStruct	 	:= {}
Local nX			:= 0
Local aRet			:= {}
Local cAliasTmp		:= ""
Local cQuery		:= ""

Default cCodCli		:= "" 
Default cLoja		:= ""       

cAliasTmp := GetNextAlias()

cQuery := " SELECT PZ5_CLIENT, A1_NOME AS PZ5_NOMCLI,PZ5_LOJA,  PZ5_CODPUB, PZ5_DPUBLI, SUM(PZ5_VALNCC) PZ5_VALNCC, "+CRLF
cQuery += " SUM(PZ5_VALUSA) PZ5_VALUSA, SUM(PZ5_VALSLD) PZ5_VALSLD FROM "+RetSqlName("PZ5")+" PZ5 "+CRLF

cQuery += " INNER JOIN "+RetSqlName("SA1")+" SA1 "+CRLF
cQuery += " ON SA1.D_E_L_E_T_ = ' ' "+CRLF
cQuery += " AND SA1.A1_FILIAL = '"+xFilial("SA1")+"' "+CRLF
cQuery += " AND SA1.A1_COD = PZ5.PZ5_CLIENT "+CRLF
cQuery += " AND SA1.A1_LOJA = PZ5.PZ5_LOJA "+CRLF

cQuery += " WHERE PZ5.D_E_L_E_T_ = ' ' "+CRLF
cQuery += " AND PZ5.PZ5_FILIAL = '"+xFilial("PZ5")+"' "+CRLF
cQuery += " AND PZ5.PZ5_CLIENT = '"+cCodCli+"' "+CRLF
cQuery += " AND PZ5.PZ5_LOJA = '"+cLoja+"' "+CRLF     
cQuery += " GROUP BY PZ5_CLIENT, PZ5_LOJA, A1_NOME,  PZ5_CODPUB, PZ5_DPUBLI "+CRLF


cQuery := ChangeQuery(cQuery)
dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cAliasTmp,.T.,.T.)

aStruct   := PZ5->(dbStruct())
For nX := 1 To Len(aStruct)
	If aStruct[nX][2] <> "C" .And. FieldPos( aStruct[nX][1] ) <> 0
		TcSetField( cAliasTmp, aStruct[nX][1], aStruct[nX][2], aStruct[nX][3], aStruct[nX][4] )
	EndIf
Next nX
 
aRet := {}

(cAliasTmp)->(DbGoTop())
While (cAliasTmp)->(!Eof())
	
	
	aAdd(aRet,{u_NcStsCR((cAliasTmp)->PZ5_VALUSA, (cAliasTmp)->PZ5_VALSLD),;
				(cAliasTmp)->PZ5_CODPUB,; 
				(cAliasTmp)->PZ5_DPUBLI,;
				(cAliasTmp)->PZ5_VALNCC,;
				(cAliasTmp)->PZ5_VALUSA,;
				(cAliasTmp)->PZ5_VALSLD,;
				,.F.})

	(cAliasTmp)->(dbSkip())
EndDo

(cAliasTmp)->(DbCloseArea())

If Len(aRet) == 0
	aAdd(aRet,{"","","",0,0,0,.F.})
EndIf

RestArea( aArea )
Return aRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AtuAcPZ53ºAutor  ³Elton C. 	         º Data ³  13/09/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Atualiza o acols da campanha do Publisher					 º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function AtuAcPZ53( cCodCli, cLoja, cCodPubli )

Local aArea := GetArea()

Default cCodCli		:= "" 
Default cLoja		:= "" 
Default cCodPubli   := ""                         

oGetDPZ53:Acols :=  CriaAcPZ53( cCodCli, cLoja, cCodPubli)
oGetDPZ53:Refresh()
oGetDPZ53:ForceRefresh()

RestArea(aArea)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CriaAcPZ53ºAutor  ³Elton C. 	         º Data ³  13/09/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Cria e atualiza o aCols aglutinado porcampanah do Publisher º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function CriaAcPZ53( cCodCli, cLoja, cCodPubli)
Local aArea    		:= GetArea()
Local aStruct	 	:= {}
Local nX			:= 0
Local aRet			:= {}
Local cAliasTmp		:= ""
Local cQuery		:= ""

Default cCodCli		:= "" 
Default cLoja		:= ""       
Default cCodPubli	:= ""                     

cAliasTmp := GetNextAlias()

cQuery := " SELECT PZ5_CLIENT, A1_NOME AS PZ5_NOMCLI,PZ5_LOJA,  PZ5_CODPUB, PZ5_DPUBLI, PZ5_PPPUB, SUM(PZ5_VALNCC) PZ5_VALNCC, "+CRLF
cQuery += " SUM(PZ5_VALUSA) PZ5_VALUSA, SUM(PZ5_VALSLD) PZ5_VALSLD FROM "+RetSqlName("PZ5")+" PZ5 "+CRLF

cQuery += " INNER JOIN "+RetSqlName("SA1")+" SA1 "+CRLF
cQuery += " ON SA1.D_E_L_E_T_ = ' ' "+CRLF
cQuery += " AND SA1.A1_FILIAL = '"+xFilial("SA1")+"' "+CRLF
cQuery += " AND SA1.A1_COD = PZ5.PZ5_CLIENT "+CRLF
cQuery += " AND SA1.A1_LOJA = PZ5.PZ5_LOJA "+CRLF

cQuery += " WHERE PZ5.D_E_L_E_T_ = ' ' "+CRLF
cQuery += " AND PZ5.PZ5_FILIAL = '"+xFilial("PZ5")+"' "+CRLF
cQuery += " AND PZ5.PZ5_CLIENT = '"+cCodCli+"' "+CRLF
cQuery += " AND PZ5.PZ5_LOJA = '"+cLoja+"' "+CRLF     
cQuery += " AND PZ5.PZ5_CODPUB = '"+cCodPubli+"' "+CRLF                                           
cQuery += " GROUP BY PZ5_CLIENT, PZ5_LOJA, A1_NOME,  PZ5_CODPUB, PZ5_DPUBLI, PZ5_PPPUB "+CRLF


cQuery := ChangeQuery(cQuery)
dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cAliasTmp,.T.,.T.)

aStruct   := PZ5->(dbStruct())
For nX := 1 To Len(aStruct)
	If aStruct[nX][2] <> "C" .And. FieldPos( aStruct[nX][1] ) <> 0
		TcSetField( cAliasTmp, aStruct[nX][1], aStruct[nX][2], aStruct[nX][3], aStruct[nX][4] )
	EndIf
Next nX
 
aRet := {}

(cAliasTmp)->(DbGoTop())
While (cAliasTmp)->(!Eof())

	aAdd(aRet,{u_NcStsCR((cAliasTmp)->PZ5_VALUSA, (cAliasTmp)->PZ5_VALSLD),;
				(cAliasTmp)->PZ5_CODPUB,; 
				(cAliasTmp)->PZ5_DPUBLI,;  
				(cAliasTmp)->PZ5_PPPUB,;  				
				(cAliasTmp)->PZ5_VALNCC,;
				(cAliasTmp)->PZ5_VALUSA,;
				(cAliasTmp)->PZ5_VALSLD,;
				,.F.})

	(cAliasTmp)->(dbSkip())
EndDo

(cAliasTmp)->(DbCloseArea())

If Len(aRet) == 0
	aAdd(aRet,{"","","","",0,0,0,.F.})
EndIf

RestArea( aArea )
Return aRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CriaAcPZ54ºAutor  ³Elton C. 	         º Data ³  13/09/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Cria e atualiza o aCols aglutinado por campanha do Publisherº±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function CriaAcPZ54( cCodCli, cLoja, cCodPubli, cCodCamp)
Local aArea    		:= GetArea()
Local aStruct	 	:= {}
Local nX			:= 0
Local aRet			:= {}
Local cAliasTmp		:= ""
Local cQuery		:= ""

Default cCodCli		:= "" 
Default cLoja		:= ""       
Default cCodPubli	:= ""                     
Default cCodCamp	:= ""                                      

cAliasTmp := GetNextAlias()

cQuery := " SELECT PZ5_STATUS,PZ5_CLIENT, A1_NOME AS PZ5_NOMCLI,PZ5_LOJA,  PZ5_CODPUB, PZ5_DPUBLI, PZ5_PPPUB, PZ5_CODPP, SUM(PZ5_VALNCC) PZ5_VALNCC, "+CRLF
cQuery += " SUM(PZ5_VALUSA) PZ5_VALUSA, SUM(PZ5_VALSLD) PZ5_VALSLD, PZ5_PREFIX, PZ5_TITULO, PZ5_PARCEL, PZ5_TIPO FROM "+RetSqlName("PZ5")+" PZ5 "+CRLF

cQuery += " INNER JOIN "+RetSqlName("SA1")+" SA1 "+CRLF
cQuery += " ON SA1.D_E_L_E_T_ = ' ' "+CRLF
cQuery += " AND SA1.A1_FILIAL = '"+xFilial("SA1")+"' "+CRLF
cQuery += " AND SA1.A1_COD = PZ5.PZ5_CLIENT "+CRLF
cQuery += " AND SA1.A1_LOJA = PZ5.PZ5_LOJA "+CRLF

cQuery += " WHERE PZ5.D_E_L_E_T_ = ' ' "+CRLF
cQuery += " AND PZ5.PZ5_FILIAL = '"+xFilial("PZ5")+"' "+CRLF
cQuery += " AND PZ5.PZ5_CLIENT = '"+cCodCli+"' "+CRLF
cQuery += " AND PZ5.PZ5_LOJA = '"+cLoja+"' "+CRLF     
cQuery += " AND PZ5.PZ5_CODPUB = '"+cCodPubli+"' "+CRLF                                           
cQuery += " AND PZ5.PZ5_PPPUB = '"+cCodCamp+"' "+CRLF
cQuery += " GROUP BY PZ5_STATUS, PZ5_CLIENT, PZ5_LOJA, A1_NOME,  PZ5_CODPUB, PZ5_DPUBLI, PZ5_PPPUB, "+CRLF
cQuery += "  			PZ5_CODPP, PZ5_PREFIX, PZ5_TITULO, PZ5_PARCEL, PZ5_TIPO "+CRLF


cQuery := ChangeQuery(cQuery)
dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cAliasTmp,.T.,.T.)

aStruct   := PZ5->(dbStruct())
For nX := 1 To Len(aStruct)
	If aStruct[nX][2] <> "C" .And. FieldPos( aStruct[nX][1] ) <> 0
		TcSetField( cAliasTmp, aStruct[nX][1], aStruct[nX][2], aStruct[nX][3], aStruct[nX][4] )
	EndIf
Next nX
 
aRet := {}

(cAliasTmp)->(DbGoTop())
While (cAliasTmp)->(!Eof())

	aAdd(aRet,{u_NcStsCR((cAliasTmp)->PZ5_VALUSA, (cAliasTmp)->PZ5_VALSLD),;
				(cAliasTmp)->PZ5_CODPUB,; 
				(cAliasTmp)->PZ5_DPUBLI,;  
				(cAliasTmp)->PZ5_PPPUB,;  				
				(cAliasTmp)->PZ5_CODPP,;  				
				(cAliasTmp)->PZ5_VALNCC,;
				(cAliasTmp)->PZ5_VALUSA,;
				(cAliasTmp)->PZ5_VALSLD,;
				(cAliasTmp)->PZ5_PREFIX,;
				(cAliasTmp)->PZ5_TITULO,;
				(cAliasTmp)->PZ5_PARCEL,;
				(cAliasTmp)->PZ5_TIPO,;
				,.F.})

	(cAliasTmp)->(dbSkip())
EndDo

(cAliasTmp)->(DbCloseArea())

If Len(aRet) == 0
	aAdd(aRet,{"","","","","",0,0,0,.F.})
EndIf

RestArea( aArea )
Return aRet




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NcStsCRºAutor  ³Elton C.   		     º Data ³  13/09/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Retorna a cor referente o status do repasse                 º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function NcStsCR(nValUsa, nValSld)

Local aArea 	:= GetArea()
Local cRet		:= ""
Local cOpc		:= ""

Default nValUsa	:= 0 
Default nValSld := 0

If nValUsa == 0//Não aplicado  
	cOpc := "1"
ElseIf (nValUsa != 0) .And. (nValSld != 0)//parcialmente aplicado
	cOpc := "2"
ElseIf (nValUsa != 0) .And. (nValSld == 0)//aplicado
	cOpc := "3"
Else
	cOpc := ""
EndIf


If Alltrim(cOpc) == "1"
	cRet := "BR_VERMELHO"
ElseIf Alltrim(cOpc) == "2"
	cRet := "BR_AMARELO"
ElseIf Alltrim(cOpc) == "3"
	cRet := "BR_VERDE"	
EndIf

RestArea(aArea)
Return cRet   



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³UpCabPZ6  ºAutor  ³Elton C.	         º Data ³  13/09/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Atualiza os dados do cabeçalho de acordo com o cliente/loja º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NC Games                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function UpCabPZ6(cCliente, cLoja, nOpc)

Local aArea 	:= GetArea()
Local cQuery    := ""
Local cArqTmp	:= GetNextAlias()
Local nX		:= 1

Default cCliente	:= "" 
Default cLoja		:= "" 
Default nOpc		:= 1 //1=Inclusão; 2=Alteração; 3=Exclusão

//Se não for exclusão, a rotina vai verificar se o registro ja existe para atualização e/ou inclusão
If nOpc != 3 

	cQuery    := " SELECT PZ5_CLIENT, A1_NREDUZ AS PZ5_NOMCLI,PZ5_LOJA,SUM(PZ5_VALPP) PZ5_VALPP,SUM(PZ5_VALNCC) PZ5_VALNCC, "+CRLF
    cQuery    += " SUM(PZ5_VALUSA) PZ5_VALUSA, SUM(PZ5_VALSLD) PZ5_VALSLD, MAX(PZ5_DTEMIS) PZ5_DTEMIS FROM "+RetSqlName("PZ5")+" PZ5 "+CRLF

	cQuery    += " INNER JOIN "+RetSqlName("SA1")+" SA1 "+CRLF
	cQuery    += " ON SA1.D_E_L_E_T_ = ' ' "+CRLF
	cQuery    += " AND SA1.A1_FILIAL = '"+xFilial("SA1")+"' "+CRLF
	cQuery    += " AND SA1.A1_COD = PZ5.PZ5_CLIENT "+CRLF
	cQuery    += " AND SA1.A1_LOJA = PZ5.PZ5_LOJA "+CRLF
	
	cQuery    += " WHERE PZ5.D_E_L_E_T_ = ' ' "+CRLF
	cQuery    += " AND PZ5.PZ5_FILIAL = '"+xFilial("PZ5")+"' "+CRLF
	cQuery    += " AND PZ5.PZ5_CLIENT = '"+cCliente+"' "+CRLF
	cQuery    += " AND PZ5.PZ5_LOJA = '"+cLoja+"' "+CRLF
	cQuery    += " GROUP BY PZ5_CLIENT, PZ5_LOJA, A1_NREDUZ "+CRLF
    

	cQuery := ChangeQuery(cQuery)
	dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cArqTmp,.T.,.T.)

	aStruct   := PZ5->(dbStruct())
	For nX := 1 To Len(aStruct)
		If aStruct[nX][2] <> "C" .And. FieldPos( aStruct[nX][1] ) <> 0
			TcSetField( cArqTmp, aStruct[nX][1], aStruct[nX][2], aStruct[nX][3], aStruct[nX][4] )
		EndIf
	Next nX
	    
	(cArqTmp)->(DbGoTop())
	
	DbSelectArea("PZ6")
	DbSetOrder(1)
	If PZ6->(DbSeek(xFilial("PZ6") + PADR(cCliente, TAMSX3("PZ6_CLIENT")[1]) + PADR(cLoja, TAMSX3("PZ6_LOJA")[1])))
		nOpc := 2
	Else
		nOpc := 1
	EndIf

EndIf


If nOpc == 1 //Inclusão
	
	RecLock("PZ6",.T.)
	PZ6->PZ6_FILIAL := xFilial("PZ6")
	PZ6->PZ6_CLIENT := (cArqTmp)->PZ5_CLIENT
	PZ6->PZ6_LOJA	:= (cArqTmp)->PZ5_LOJA
	PZ6->PZ6_NOMCLI := (cArqTmp)->PZ5_NOMCLI
	PZ6->PZ6_VALPP	:= (cArqTmp)->PZ5_VALPP
	PZ6->PZ6_VALNCC	:= (cArqTmp)->PZ5_VALNCC
	PZ6->PZ6_VALUSA	:= (cArqTmp)->PZ5_VALUSA
	PZ6->PZ6_VALSLD	:= (cArqTmp)->PZ5_VALSLD
	PZ6->PZ6_DTULRP	:= (cArqTmp)->PZ5_DTEMIS
		
	PZ6->(MsUnLock())

ElseIf nOpc == 2 //Alteração

	RecLock("PZ6",.F.)
	PZ6->PZ6_FILIAL := xFilial("PZ6")
	PZ6->PZ6_CLIENT := (cArqTmp)->PZ5_CLIENT
	PZ6->PZ6_LOJA	:= (cArqTmp)->PZ5_LOJA
	PZ6->PZ6_NOMCLI := (cArqTmp)->PZ5_NOMCLI
	PZ6->PZ6_VALPP	:= (cArqTmp)->PZ5_VALPP
	PZ6->PZ6_VALNCC	:= (cArqTmp)->PZ5_VALNCC
	PZ6->PZ6_VALUSA	:= (cArqTmp)->PZ5_VALUSA
	PZ6->PZ6_VALSLD	:= (cArqTmp)->PZ5_VALSLD
	PZ6->PZ6_DTULRP	:= (cArqTmp)->PZ5_DTEMIS
		
	PZ6->(MsUnLock())

ElseIf nOpc == 3 //Exclusão
	
	DbSelectArea("PZ6")
	DbSetOrder(1)
	If PZ6->(DbSeek(xFilial("PZ6") + PADR(cCliente, TAMSX3("PZ6_CLIENT")[1]) + PADR(cLoja, TAMSX3("PZ6_LOJA")[1])))

		RecLock("PZ6",.T.)
		PZ6->(DbDelete())		  	
		PZ6->(MsUnLock())
  	EndIf

EndIf

(cArqTmp)->(DbCloseArea())

RestArea(aArea)
Return
