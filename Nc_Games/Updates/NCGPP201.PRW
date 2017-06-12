#INCLUDE "PROTHEUS.CH"
#INCLUDE "msgraphi.ch"
#INCLUDE "APWIZARD.CH"
 

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCContPP  บAutor  ณElton C.            บ Data ณ  13/09/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณControle de repasse Price Protection Publisher x NC Games   บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NCGPP201()

Local aArea 		:= GetArea()

Private cCadastro 	:= "Controle de repasse Price Protection - Publisher X NC Games"
Private oBrowse	
Private aRotina 	:= Menudef()

dbSelectArea("PZ7")
dbSetOrder(1)

oBrowse := FWMBrowse():New() 
oBrowse:SetAlias("PZ7")    

oBrowse:AddLegend("(Alltrim(PZ7->PZ7_STATUS) == '1') "	, "BR_VERMELHO"		, "Saldo em aberto (Total)"  )
oBrowse:AddLegend("(Alltrim(PZ7->PZ7_STATUS) == '2') "	, "BR_AMARELO"		, "Saldo em aberto (Parcial)"  )
oBrowse:AddLegend("(Alltrim(PZ7->PZ7_STATUS) == '3') "	, "BR_VERDE"		, "Sem saldo"  )

oBrowse:SetDescription(cCadastro) 
oBrowse:Activate() 

	
RestArea(aArea)
Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณPrograma  ณMenuDef   ณ Autor ณ Microsiga             ณ Data ณ00/00/0000ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescri…o ณ Utilizacao de menu Funcional                               ณฑฑ
ฑฑณ          ณ                                                            ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณRetorno   ณArray com opcoes da rotina.                                 ณฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function MenuDef()


Private aRotina := { }


AAdd(aRotina, {"Pesquisar"				, "AxPesqui"  	,0 , 1})
AAdd(aRotina, {"Detalhe"				, "u_NCRepPN", 0, 2})
AAdd(aRotina, {"Legenda"				, "u_NCPP2Leg"	,0,6} )     

Return(aRotina)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ NCPP2Leg บAutor  ณElton C.	         บ Data ณ  02/2014	  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณLegenda do browse                                           บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NCPP2Leg()
Local aLegenda 	:= {}
Local aCores	:= {}

Aadd(aCores, {" (PZ7_STATUS) == '1') "	, "BR_VERMELHO"		, "Saldo em aberto (Total)"  })
Aadd(aCores, {" PZ7_STATUS) == '2') "	, "BR_AMARELO"		, "Saldo em aberto (Parcial)"  })
Aadd(aCores, {" (PZ7_STATUS) == '3') "	, "BR_VERDE"   		, "Sem saldo"  } )

aEval(aCores, {|z| Aadd(aLegenda, {z[2], z[3]})})
BrwLegenda(cCadastro, "Legenda", aLegenda)

Return(Nil)




/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณNCRepPN   บ Autor ณ Elton C.		     บ Data ณ  29/09/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Rotina utilizada para incluir e visualizar detalhe do      บฑฑ
ฑฑบ          ณ repasse Pblisher X NC  Games                               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ 			                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function NCRepPN()

Local aArea := GetArea()
Local oDlg 
Local oWin01
Local oWin02
Local oFWLayer 
Local oButSair
Local oButLeg
Local oButDCamp
Local oButCons
Local aScreen 		:= GetScreenRes()
Local nWStage 		:= aScreen[1]-45
Local nHStage 		:= aScreen[2]-225
Local oButton		            

Local aCamposPZ7	:= {"PZ7_STATUS","PZ7_PUBLIS", "PZ7_DPUBLI", "PZ7_VLREPS", "PZ7_VLCONS", "PZ7_SALDO"}
Local aCamposPZ8	:= {"PZ8_STATUS","PZ8_CAMP", "PZ8_PUBLIS", "PZ8_VLREPS", "PZ8_VLCONS", "PZ8_SALDO"}
Local cGet		:= ""     
Local aSize		:= MsAdvSize(.T.) 
Local aHeaderPZ7  := {}
Local aHeaderPZ8  := {}
Local aColsPZ7 	:= {}
Local aColsPZ8 	:= {}             

Private oGetDPZ7
Private oGetDPZ8	


//Preenche o aheader e o acols da tabela PZ7
aHeaderPZ7 	:= CriaHeader(aCamposPZ7)//Cria o aheader da tabela PZ7
aColsPZ7 	:= CriaAcPZ7(PZ7->PZ7_PUBLIS)//Cria o acols da tabela PZ7

//Preenche o aheader e o acols da tabela PZ8
aHeaderPZ8 	:= CriaHeader(aCamposPZ8)//Cria o aheader da tabela ZC7
aColsPZ8 	:= CriaAcPZ8(PZ7->PZ7_PUBLIS)//Cria o acols da tabela ZC7


//Montagem da tela
DEFINE DIALOG oDlg TITLE "Repasse Publisher x NC Games" SIZE nWStage,nHStage PIXEL STYLE nOr(WS_VISIBLE,WS_OVERLAPPEDWINDOW)

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
oFWLayer:AddWindow( "Col01", "Win01", "Publisher", 25, .F., .T., ,,) 
oFWLayer:AddWindow( "Col01", "Win02", "Campanhas", 75 , .F., .T., {|| .T. },,)                           


oWin01 := oFWLayer:getWinPanel('Col01','Win01')
oWin02 := oFWLayer:getWinPanel('Col01','Win02')

//Cria a getdados da tabela PZ7
oGetDPZ7 := MsNewGetDados():New(005,005,(aSize[4]*65/100)-40,aSize[3]-30 ,0 ,"","","",,,9999,"AllWaysTrue()",,,oWin01,aHeaderPZ7,aColsPZ7)
                                                            

//Cria a getdados da tabela PZ8
oGetDPZ8 := MsNewGetDados():New(005,005,(aSize[4]*65/100)-40,aSize[3]-30 ,0 ,"","","",,,9999,"AllWaysTrue()",,,oWin02,aHeaderPZ8,aColsPZ8, {||})
          


oButLeg			:= TButton():New( (aSize[4]*65/100)-35, aSize[3]-199, "Legenda",oWin02,{ || LengAglut() }, 40,10,,,.F.,.T.,.F.,,.F.,,,.F. )   
oButCons		:= TButton():New( (aSize[4]*65/100)-35, aSize[3]-156, "Cons.Credito",oWin02,{ || ConsCredPP(PZ7->PZ7_PUBLIS, oGetDPZ8:Acols[oGetDPZ8:nAt][2])}, 40,10,,,.F.,.T.,.F.,,.F.,,,.F. )   

oButDCamp		:= TButton():New( (aSize[4]*65/100)-35, aSize[3]-113, "Det.Campanha",oWin02,{ || DetCampP(PZ7->PZ7_PUBLIS, oGetDPZ8:Acols[oGetDPZ8:nAt][2]) }, 50,10,,,.F.,.T.,.F.,,.F.,,,.F. ) 


oButSair		:= TButton():New( (aSize[4]*65/100)-35, aSize[3]-60, "Sair",oWin02,{ || oDlg:End() }, 30,10,,,.F.,.T.,.F.,,.F.,,,.F. )

             
ACTIVATE DIALOG oDlg CENTERED

RestArea(aArea)
Return                                                       


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCriaHeaderบAutor  ณElton C.	         บ Data ณ  02/2014	  บฑฑ
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
		
		cDescCpo := X3Titulo() 		
		
		aAdd( aRet, {AlLTrim( cDescCpo)	, ;	// 01 - Titulo
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
ฑฑบPrograma  ณCriaAcolsZC7บAutor  ณElton C.          บ Data ณ  02/2014	  บฑฑ
ฑฑฬออออออออออุออออออออออออสอออออออฯออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCria e atualiza o aCols                                     บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CriaAcPZ7(cCodPublis)
Local aArea    		:= GetArea()
Local aStruct	 	:= {}
Local nX			:= 0
Local aRet			:= {}
Local cAliasTmp		:= ""
Local cQuery		:= ""

Default cCodPublis 	:= ""


cAliasTmp := GetNextAlias()

cQuery :=  "SELECT * FROM "+RetSqlName("PZ7")
cQuery +=  " WHERE PZ7_FILIAL = '"+xFilial("PZ7")+"'  "
cQuery +=  " AND PZ7_PUBLIS = '"+cCodPublis+"' "
cQuery +=  " AND D_E_L_E_T_ = ' ' "


dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cAliasTmp,.T.,.T.)

aStruct   := PZ7->(dbStruct())
For nX := 1 To Len(aStruct)
	If aStruct[nX][2] <> "C" .And. FieldPos( aStruct[nX][1] ) <> 0
		TcSetField( cAliasTmp, aStruct[nX][1], aStruct[nX][2], aStruct[nX][3], aStruct[nX][4] )
	EndIf
Next nX
 
aRet := {}

(cAliasTmp)->(DbGoTop())
While (cAliasTmp)->(!Eof())

	aAdd(aRet,{GetSts((cAliasTmp)->PZ7_VLCONS,(cAliasTmp)->PZ7_SALDO),;
				(cAliasTmp)->PZ7_PUBLIS,;
				(cAliasTmp)->PZ7_DPUBLI,;
				(cAliasTmp)->PZ7_VLREPS  ,;
				(cAliasTmp)->PZ7_VLCONS  ,;
				(cAliasTmp)->PZ7_SALDO,;
				,.F.})

	(cAliasTmp)->(dbSkip())
EndDo

If Len(aRet) == 0
	aAdd(aRet,{"",;
				"",;
				"",;
				0  ,;
				0  ,;
				0,;
				,.F.})
	
EndIf

(cAliasTmp)->(DbCloseArea())

RestArea( aArea )
Return aRet




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออหอออออออัออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCriaAcPZ8	บAutor  ณElton C.          บ Data ณ  02/2014	  บฑฑ
ฑฑฬออออออออออุออออออออออออสอออออออฯออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCria e atualiza o aCols                                     บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CriaAcPZ8(cCodPublis)
Local aArea    		:= GetArea()
Local aStruct	 	:= {}
Local nX			:= 0
Local aRet			:= {}
Local cAliasTmp		:= ""
Local cQuery		:= ""

Default cCodPublis 	:= ""

cAliasTmp := GetNextAlias()

cQuery :=  " SELECT PZ8_PUBLIS, PZ8_CAMP, SUM(PZ8_VLREPS) PZ8_VLREPS, SUM(PZ8_VLCONS) PZ8_VLCONS, SUM(PZ8_SALDO) PZ8_SALDO FROM "+RetSqlName("PZ8")+" PZ8 "
cQuery +=  " WHERE PZ8_FILIAL = '"+xFilial("PZ8")+"' "
cQuery +=  " AND PZ8_PUBLIS = '"+cCodPublis+"' "
cQuery +=  " AND D_E_L_E_T_ = ' ' "
cQuery +=  " GROUP BY PZ8_PUBLIS, PZ8_CAMP "

dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cAliasTmp,.T.,.T.)

aStruct   := PZ8->(dbStruct())
For nX := 1 To Len(aStruct)
	If aStruct[nX][2] <> "C" .And. FieldPos( aStruct[nX][1] ) <> 0
		TcSetField( cAliasTmp, aStruct[nX][1], aStruct[nX][2], aStruct[nX][3], aStruct[nX][4] )
	EndIf
Next nX
 
aRet := {}

(cAliasTmp)->(DbGoTop())
While (cAliasTmp)->(!Eof())

	aAdd(aRet,{GetSts((cAliasTmp)->PZ8_VLCONS,(cAliasTmp)->PZ8_SALDO),;
				(cAliasTmp)->PZ8_CAMP,;
				(cAliasTmp)->PZ8_PUBLIS,;
				(cAliasTmp)->PZ8_VLREPS  ,;
				(cAliasTmp)->PZ8_VLCONS  ,;
				(cAliasTmp)->PZ8_SALDO,;
				,.F.})

	(cAliasTmp)->(dbSkip())
EndDo

If Len(aRet) == 0
	aAdd(aRet,{"",;
				"",;
				"",;
				0  ,;
				0  ,;
				0,;
				,.F.})
	
EndIf

(cAliasTmp)->(DbCloseArea())

RestArea( aArea )
Return aRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณDetCampPบAutor  ณElton C.	     บ   Data ณ  02/2014		  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณDetalhe da campanha do Publisher		                   	  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿#฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function DetCampP(cCodPub, cCamp)

Local aArea 		:= GetArea()
Local aCpoCabCP 	:= {"PZ8_STATUS","PZ8_CODPP", "PZ8_PUBLIS", "PZ8_CAMP", "PZ8_VLREPS", "PZ8_VLCONS", "PZ8_SALDO"} 
Local aCpoCons 	  	:= {"PZ9_ITEM", "PZ9_DTEMIS", "PZ9_PUBLIS", "PZ9_CAMP", "PZ9_VLCONS", "PZ9_PEDIDO"} 
       
Local nWStage 		:= 800
Local nHStage 		:= 500
Local oDlg 
Local oFWLayer
Local oWin01
Local oButReimp
Local oButSair
Local oButLeg
Local oFolder
Local aTitles	:= {"Campanha","Det.Consumo"}
Local aPages	:= {}


Local oGetDCP	
Local oGetDCons
Local aHeadCbCP		:= {}
Local aAcolsCp		:= {}
Local aHeadCons		:= {}
Local aAcolsCons 	:= {}


Default cCodPub := ""

aHeadCbCP	:= CriaHeader(aCpoCabCP)
aAcolsCp  	:= CriaACP(cCodPub, cCamp)

aHeadCons	 	:= CriaHeader(aCpoCons)
aAcolsCons  	:= CriaACons(cCodPub, cCamp)


//Verifica se existe dados no acols
If ((	Len(aAcolsCp) > 0)  )

	//Montagem da tela
	DEFINE DIALOG oDlg TITLE "Detalhe da Campanha Publisher " SIZE nWStage,nHStage PIXEL STYLE nOr(WS_VISIBLE,WS_OVERLAPPEDWINDOW)
	
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
	oFWLayer:AddWindow( "Col01", "Win01", "Detalhe da Campanha", 100, .F., .T., ,,)
	
	
	oWin01 := oFWLayer:getWinPanel('Col01','Win01')
   
	oFolder := TFolder():New(005,001,aTitles,aPages,oWin01,,,,.T.,.F.,390,190)
	
	//Cria a getdados com resumo do cabe็alho
	oGetDCP 	:= MsNewGetDados():New(005,005,175,385 ,0 ,"","","",,,9999,"AllWaysTrue()",,,oFolder:aDialogs[1],aHeadCbCP,aAcolsCp, {||	})



	//Cria a getdados com detalhes do consumo    
    oGetDCons	:= MsNewGetDados():New(005,005,175,385 ,0 ,"","","",,,9999,"AllWaysTrue()",,,oFolder:aDialogs[2],aHeadCons,aAcolsCons, {||	})

	oButLeg		:= TButton():New( 200, 325, "Legenda",oWin01,{ || LengDet() }, 30,10,,,.F.,.T.,.F.,,.F.,,,.F. )
	oButSair	:= TButton():New( 200, 360, "Sair",oWin01,{ || oDlg:End() }, 30,10,,,.F.,.T.,.F.,,.F.,,,.F. )
	
	ACTIVATE DIALOG oDlg CENTERED
	
	
Else
	Aviso("NOEXISTE","Nenhuma campanha encontrada.",{"Ok"},2)
EndIf


RestArea(aArea)
Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณDetCampPบAutor  ณElton C.	     บ   Data ณ  02/2014		  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณDetalhe da campanha do Publisher		                   	  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿#฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ConsCredPP(cCodPub, cCamp)

Local aArea 		:= GetArea()
Local aCpoCons 	  	:= {"PZ9_ITEM", "PZ9_DTEMIS", "PZ9_PUBLIS", "PZ9_CAMP", "PZ9_VLCONS", "PZ9_PEDIDO"} 
Local nWStage 		:= 800
Local nHStage 		:= 500
Local oDlg 
Local oFWLayer
Local oWin01
Local aPages	:= {}
Local oButInc
Local oButAlt
Local oButExc
Local oButConhe		
Local oGetDPZ9
Local aHeadCons		:= {}
Local aAcolsCons 	:= {}


Default cCodPub := ""

aHeadCons	 	:= CriaHeader(aCpoCons)
aAcolsCons  	:= CriaACons(cCodPub, cCamp)


//Montagem da tela
DEFINE DIALOG oDlg TITLE "Consumo do cr้dito da campanha Publisher" SIZE nWStage,nHStage PIXEL STYLE nOr(WS_VISIBLE,WS_OVERLAPPEDWINDOW)

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
oFWLayer:AddWindow( "Col01", "Win01", "Detalhe da Campanha", 100, .F., .T., ,,)


oWin01 := oFWLayer:getWinPanel('Col01','Win01')

//Cria a getdados com detalhes do consumo
oGetDPZ9	:= MsNewGetDados():New(005,005,175,385 ,0 ,"","","",,,9999,"AllWaysTrue()",,,oWin01,aHeadCons,aAcolsCons, {||	})

oButConhe	:= TButton():New( 200, 148, "Conhecimento",oWin01,{ ||GrvConhec(oGetDPZ9:Acols[oGetDPZ9:nAt][1]), AtuPZ9(cCodPub,cCamp,@oGetDPZ9) }, 50,10,,,.F.,.T.,.F.,,.F.,,,.F. )
oButInc		:= TButton():New( 200, 201, "Incluir",oWin01,{ ||ConsCredPub(cCodPub, cCamp, 3, ""), AtuPZ9(cCodPub,cCamp,@oGetDPZ9)}, 50,10,,,.F.,.T.,.F.,,.F.,,,.F. )
oButAlt		:= TButton():New( 200, 254, "Alterar",oWin01,{ ||ConsCredPub(cCodPub, cCamp, 4, oGetDPZ9:Acols[oGetDPZ9:nAt][1]), AtuPZ9(cCodPub,cCamp,@oGetDPZ9) }, 50,10,,,.F.,.T.,.F.,,.F.,,,.F. )
oButExc		:= TButton():New( 200, 307, "Excluir",oWin01,{ ||ConsCredPub(cCodPub, cCamp, 5, oGetDPZ9:Acols[oGetDPZ9:nAt][1]), AtuPZ9(cCodPub,cCamp,@oGetDPZ9) }, 50,10,,,.F.,.T.,.F.,,.F.,,,.F. )
oButSair	:= TButton():New( 200, 360, "Sair",oWin01,{ || oDlg:End() }, 30,10,,,.F.,.T.,.F.,,.F.,,,.F. )

ACTIVATE DIALOG oDlg CENTERED

RestArea(aArea)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAtuPZ9บAutor  ณElton C.	     บ   Data ณ  02/2014		  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณAtualiza o acols do consumo de credito                  	  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿#฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function AtuPZ9(cCodPub,cCamp,oGetDPZ9)

Local aArea 	:= GetArea()
Local aAcolsPZ9 := {}

Default cCodPub	:= "" 
Default cCamp   := ""

aAcolsPZ9 		:= CriaACons(cCodPub, cCamp)
oGetDPZ9:Acols 	:= aAcolsPZ9	          
oGetDPZ9:Refresh()

//Atualiza o acols das tables PZ7 e PZ8
AtuPZ7PZ8(cCodPub)

RestArea(aArea)
Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAtuPZ9บAutor  ณElton C.	     บ   Data ณ  02/2014		  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ										                  	  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿#฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function AtuPZ7PZ8(cCodPub)

Local aArea 	:= GetArea()
Local aColsPZ7  := {}
Local aColsPZ8	:= {}

Default cCodPub	:= "" 

aColsPZ7 	:= CriaAcPZ7(cCodPub)//Cria o acols da tabela PZ7
oGetDPZ7:Acols 	:= aColsPZ7	          
oGetDPZ7:Refresh()


aColsPZ8 	:= CriaAcPZ8(cCodPub)//Cria o acols da tabela ZC7
oGetDPZ8:Acols 	:= aColsPZ8	          
oGetDPZ8:Refresh()


RestArea(aArea)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออหอออออออัออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCriaACP	บAutor  ณElton C.          บ Data ณ  02/2014	  บฑฑ
ฑฑฬออออออออออุออออออออออออสอออออออฯออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCria e atualiza o aCols com detalhes da campnha do Publisherบฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CriaACP(cCodPublis, cCamp)
Local aArea    		:= GetArea()
Local aStruct	 	:= {}
Local nX			:= 0
Local aRet			:= {}
Local cAliasTmp		:= ""
Local cQuery		:= ""

Default cCodPublis 	:= ""
Default cCamp		:= ""

cAliasTmp := GetNextAlias()

cQuery :=  " SELECT PZ8_STATUS, PZ8_CODPP, PZ8_PUBLIS, PZ8_CAMP, PZ8_VLREPS, PZ8_VLCONS, PZ8_SALDO FROM "+RetSqlName("PZ8")+" PZ8 "
cQuery +=  " WHERE PZ8_FILIAL = '"+xFilial("PZ8")+"' "
cQuery +=  " AND PZ8_PUBLIS = '"+cCodPublis+"' "
cQuery +=  " AND PZ8_CAMP = '"+cCamp+"' "
cQuery +=  " AND D_E_L_E_T_ = ' ' "

dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cAliasTmp,.T.,.T.)

aStruct   := PZ8->(dbStruct())
For nX := 1 To Len(aStruct)
	If aStruct[nX][2] <> "C" .And. FieldPos( aStruct[nX][1] ) <> 0
		TcSetField( cAliasTmp, aStruct[nX][1], aStruct[nX][2], aStruct[nX][3], aStruct[nX][4] )
	EndIf
Next nX
 
aRet := {}

(cAliasTmp)->(DbGoTop())
While (cAliasTmp)->(!Eof())

	aAdd(aRet,{GetStsPz8((cAliasTmp)->PZ8_STATUS),;
				(cAliasTmp)->PZ8_CODPP,;
				(cAliasTmp)->PZ8_PUBLIS,;
				(cAliasTmp)->PZ8_CAMP  ,;
				(cAliasTmp)->PZ8_VLREPS  ,;
				(cAliasTmp)->PZ8_VLCONS,;
				(cAliasTmp)->PZ8_SALDO,;
				,.F.})

	(cAliasTmp)->(dbSkip())
EndDo

If Len(aRet) == 0
	aAdd(aRet,{"",;
				"",;
				"",;
				"",;
				0,;
				0,;
				0,;
				,.F.})
	
EndIf

(cAliasTmp)->(DbCloseArea())

RestArea( aArea )
Return aRet



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออหอออออออัออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCriaACons	บAutor  ณElton C.          บ Data ณ  02/2014	  บฑฑ
ฑฑฬออออออออออุออออออออออออสอออออออฯออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCria e atualiza o aCols com do consumo do credito de repasseบฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CriaACons(cCodPublis, cCamp)
Local aArea    		:= GetArea()
Local aStruct	 	:= {}
Local nX			:= 0
Local aRet			:= {}
Local cAliasTmp		:= ""
Local cQuery		:= ""

Default cCodPublis 	:= ""
Default cCamp		:= ""

cAliasTmp := GetNextAlias()

cQuery	:= " SELECT PZ9_ITEM, PZ9_DTEMIS, PZ9_PUBLIS, PZ9_CAMP, PZ9_VLCONS, PZ9_PEDIDO FROM "+RetSqlName("PZ9")
cQuery	+= " WHERE D_E_L_E_T_ = ' ' "
cQuery	+= " AND PZ9_FILIAL = '"+xFilial("PZ9")+"' "
cQuery	+= " AND PZ9_PUBLIS = '"+cCodPublis+"' "
cQuery	+= " AND PZ9_CAMP  = '"+cCamp+"' "

dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cAliasTmp , .F., .T.)

aStruct   := PZ9->(dbStruct())
For nX := 1 To Len(aStruct)
	If aStruct[nX][2] <> "C" .And. FieldPos( aStruct[nX][1] ) <> 0
		TcSetField( cAliasTmp, aStruct[nX][1], aStruct[nX][2], aStruct[nX][3], aStruct[nX][4] )
	EndIf
Next nX
 
aRet := {}

(cAliasTmp)->(DbGoTop())
While (cAliasTmp)->(!Eof())

	aAdd(aRet,{(cAliasTmp)->PZ9_ITEM,;
				(cAliasTmp)->PZ9_DTEMIS,;
				(cAliasTmp)->PZ9_PUBLIS  ,;
				(cAliasTmp)->PZ9_CAMP  ,;
				(cAliasTmp)->PZ9_VLCONS,;
				(cAliasTmp)->PZ9_PEDIDO,;
				,.F.})

	(cAliasTmp)->(dbSkip())
EndDo

If Len(aRet) == 0
	aAdd(aRet,{"",;
				ctod(''),;
				""  ,;
				""  ,;
				0,;
				"",;
				,.F.})
	
EndIf

(cAliasTmp)->(DbCloseArea())

RestArea( aArea )
Return aRet





/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณConsCredPub บAutor  ณElton C.		     บ Data ณ  15/12/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณTela de manuten็ใo de cadastro de consumo		 			  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ConsCredPub(cCodPublis, cCamp, nOpc, cCodPZ9)

Local aArea := GetArea()                                     

Default cCodPublis	:= "" 
Default cCamp		:= "" 
Default nOpc		:= 3 
Default cCodPZ9		:= ""


//Chama a rotina para manuten็ใo do consumo de credito
If Empty(cCodPZ9) .And. (nOpc == 4 .Or. nOpc == 5)
   Aviso("Aten็ใo","Nenhum item selecionado.",{"Ok"},2)
Else
	ManutConPP(, , nOpc, cCodPublis, cCamp, cCodPZ9)
EndIf
                
RestArea(aArea)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณManutConPP บAutor  ณElton C.		     บ Data ณ  15/12/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณTela de manuten็ใo de cadastro de consumo		 			  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ManutConPP(cAlias, nReg, nlOpcx, cCodPublis, cCamp, cCodPZ9)

Local oFont01   	:=TFont():New( "Courier New",,20,,.F.,,,20,,,,,,,,)
Local cTitulo		:= "Consumo de Cr้dito Publisher"
Local nlResoluc		:= oMainWnd:nClientWidth
Local alCoord		:= MsAdvSize(.T.,.F.,0)
Local aButtons		:= {}
Local aCmps			:= {}
Local alPrcPrinc	:= {0,0,0}
Local alPrc			:= {0}
Local odlgCab		:= Nil
Local oEncCab		:= Nil  
Local lGrv			:= .T.
Local lAltEnch		:= Iif(nlOpcx ==3 .or. nlOpcx == 4,.T.,.F.)


Private aTela[0][0]
Private aGets[0]

Private opOdlg		:= Nil
Private opLayer		:= FWLayer():New()

alPrcPrinc 		:= {090,005,005}
alPrc			:= {100}

//Campos que serใo exibidos editados
aCmps := {}
AADD(aCmps,"PZ9_VLCONS")
AADD(aCmps,"PZ9_PEDIDO")
AADD(aCmps,"PZ9_DESCRI")

opOdlg := TDialog():New(alCoord[1],alCoord[2],alCoord[6]-100,alCoord[5]-500,cTitulo,,,,,CLR_BLACK,CLR_WHITE,,,.T.)

opLayer:Init(opOdlg,.F.)

opLayer:AddCollumn("CENTRO"	,alPrc[1],.F.)

opLayer:AddWindow("CENTRO","CONSREPPP"					,"Consumo"		,alPrcPrinc[1],.T.,.T.,{||},,{||})

odlgCab	:= opLayer:GetWinPanel("CENTRO","CONSREPPP")

RegToMemory("PZ9", lAltEnch,.T.,.T.)

oEncCab	:= MSMGet():New("PZ9",,3	,,,,{},{0,0,0,0},aCmps,,,,,odlgCab	,,,,,,,,,)


//Atualiza enchoice com os dados iniciais do cadastro de consumo                 
If nlOpcx == 3       
	AtuEncInc(cCodPublis, cCamp, @oEncCab)
Else
	AtuEncAlt(cCodPublis, cCamp, @oEncCab, cCodPZ9, nlOpcx)
EndIf

oEncCab:oBox:Align := CONTROL_ALIGN_ALLCLIENT

Activate Msdialog opOdlg Centered On Init EnchoiceBar(opOdlg,;
	{|| Iif(NcGrvCRP(nlOpcx),opOdlg:End(),.T.)},;
	{||opOdlg:End()};
	,,aButtons)

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGrvCRP	 บAutor  ณElton C.		     บ Data ณ  15/12/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina utilizada para efetuar a manuten็ใo do consumo		  บฑฑ
ฑฑบ          ณdo price protection			                              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function NCGrvCRP(nOpc)

Local aArea 	:= GetArea()
Local lRet		:= .T.      

Default nOpc := 3

If nOpc == 3 .Or. nOpc == 4
	
	//Verifica se existe saldo disponivel no momento da grva็ใo
	If M->PZ9_VLCONS <= M->PZ9_SALDO
	
		If Aviso("Aten็ใo","Confirma a grava็ใo dos dados ?",{"Sim","Nใo"},2) == 1

			//Chama a rotina para gravar a inclusใo e\ou altera็ใo
			GrvCRP(nOpc)
		EndIf
	Else
	    Aviso("Saldo indisponํvel", "O valor informado ("+Alltrim(transform(M->PZ9_VLCONS,"@E 999,999,999,999.99"))+") ้ maior que o saldo disponํvel ("+Alltrim(transform(M->PZ9_SALDO,"@E 999,999,999,999.99"))+").",{"Ok"},2)
	    lRet := .F.
	EndIf

ElseIf nOpc == 5
	If Aviso("Aten็ใo","Confirma a exclusใo do registro ?",{"Sim","Nใo"},2) == 1

		//Chama a rotina para gravar a inclusใo e\ou altera็ใo
		GrvCRP(nOpc)
	EndIf
EndiF


RestArea(aArea)
Return lRet




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGrvCRP	 บAutor  ณElton C.		     บ Data ณ  15/12/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina utilizada para gravar os dados do consumo do credito บฑฑ
ฑฑบ          ณdisponibilizado pelo Publisher                              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GrvCRP(nOpc)

Local aArea := GetArea()
Local lRet	:= .T.

If nOpc == 3//Inclusใo
    
	Reclock("PZ9",.T.)
	PZ9->PZ9_FILIAL := xFilial("PZ9")
	PZ9->PZ9_ITEM  	:= M->PZ9_ITEM
	PZ9->PZ9_DTEMIS := M->PZ9_DTEMIS
	PZ9->PZ9_PUBLIS := M->PZ9_PUBLIS
	PZ9->PZ9_CAMP   := M->PZ9_CAMP
	PZ9->PZ9_VLCONS := M->PZ9_VLCONS
	PZ9->PZ9_PEDIDO := M->PZ9_PEDIDO
	PZ9->PZ9_DESCRI := M->PZ9_DESCRI
	PZ9->(MsUnLock())
	
	//Atualiza saldo
	u_NCSldConPP(M->PZ9_PUBLIS, M->PZ9_CAMP)	

ElseIf nOpc == 4//Altera็ใo

	DbSelectArea("PZ9")
	DbSetOrder(1)
	If PZ9->(DbSeek(xFilial("PZ9") + M->PZ9_ITEM)) //Altera็ใo
		Reclock("PZ9",.F.)
		PZ9->PZ9_ITEM  	:= M->PZ9_ITEM
		PZ9->PZ9_DTEMIS := M->PZ9_DTEMIS
		PZ9->PZ9_PUBLIS := M->PZ9_PUBLIS
		PZ9->PZ9_CAMP   := M->PZ9_CAMP
		PZ9->PZ9_VLCONS := M->PZ9_VLCONS
		PZ9->PZ9_PEDIDO := M->PZ9_PEDIDO
		PZ9->PZ9_DESCRI := M->PZ9_DESCRI
		PZ9->(MsUnLock())
	EndIf

	//Atualiza saldo
	u_NCSldConPP(M->PZ9_PUBLIS, M->PZ9_CAMP)	


ElseIf nOpc == 5//Exclusใo

	DbSelectArea("PZ9")
	DbSetOrder(1)
	If PZ9->(DbSeek(xFilial("PZ9") + M->PZ9_ITEM)) //Altera็ใo
		
		Reclock("PZ9",.F.)
		PZ9->(DbDelete())
		PZ9->(MsUnLock())
		
		//Atualiza saldo
		u_NCSldConPP(M->PZ9_PUBLIS, M->PZ9_CAMP)	

	EndIf
	
EndIf

RestArea(aArea)
Return 


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAtuEncInc บAutor  ณElton C.		     บ Data ณ  15/12/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณAtualiza o objeto da echoice com os dados iniciais		  บฑฑ
ฑฑบ          ณno caso de inclusใo                                         บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function AtuEncInc(cCodPublis, cCamp, oEncCab)

Local aArea 	:= GetArea()
Local cQuery	:= ""
Local cArqTmp	:= GetNextAlias()

Default cCodPublis	:= "" 
Default cCamp		:= ""
Default oEncCab		:= Nil

cQuery :=  " SELECT PZ8_PUBLIS, PZ8_CAMP, SUM(PZ8_VLREPS) PZ8_VLREPS, SUM(PZ8_VLCONS) PZ8_VLCONS, SUM(PZ8_SALDO) PZ8_SALDO FROM "+RetSqlName("PZ8")+" PZ8 "+CRLF
cQuery +=  " WHERE PZ8_FILIAL = '"+xFilial("PZ8")+"' "+CRLF
cQuery +=  " AND PZ8_PUBLIS = '"+cCodPublis+"' "+CRLF
cQuery +=  " AND PZ8_CAMP = '"+cCamp+"' "+CRLF
cQuery +=  " AND D_E_L_E_T_ = ' ' "+CRLF
cQuery +=  " GROUP BY PZ8_PUBLIS, PZ8_CAMP "+CRLF

dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cArqTmp,.T.,.T.)

If (cArqTmp)->(!Eof())
	M->PZ9_DTEMIS   := MsDate()
	M->PZ9_PUBLIS	:= (cArqTmp)->PZ8_PUBLIS
	M->PZ9_CAMP     := (cArqTmp)->PZ8_CAMP
	M->PZ9_SALDO  	:= u_GetSldPP((cArqTmp)->PZ8_PUBLIS, (cArqTmp)->PZ8_CAMP)//(cArqTmp)->PZ8_SALDO
EndIf

//Atualiza o objeto MsMGet
oEncCab:EnchRefreshAll()

(cArqTmp)->(DbCloseArea())
RestArea(aArea)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAtuObjPZ9 บAutor  ณElton C.		     บ Data ณ  15/12/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณAtualiza o objeto da echoice com os dados iniciais		  บฑฑ
ฑฑบ          ณno caso de inclusใo                                         บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function AtuEncAlt(cCodPublis, cCamp, oEncCab, cCod, nOpc)

Local aArea 	:= GetArea()
Local cQuery	:= ""
Local cArqTmp	:= GetNextAlias()          

Default cCodPublis	:= "" 
Default cCamp		:= ""
Default oEncCab		:= Nil                             
Default cCod		:= ""
Default nOpc		:= 3

cQuery :=  " SELECT utl_raw.cast_to_varchar2(DBMS_LOB.SUBSTR(PZ9_DESCRI,2000,1)) PZ9_DESCRI, PZ9_ITEM, PZ9_DTEMIS, PZ9_PUBLIS, "
cQuery +=  " PZ9_CAMP, PZ9_VLCONS, PZ9_PEDIDO FROM "+RetSqlName("PZ9")+" PZ9 "+CRLF

cQuery +=  " WHERE PZ9_FILIAL = '"+xFilial("PZ9")+"' "+CRLF
cQuery +=  " AND PZ9_PUBLIS = '"+cCodPublis+"' "+CRLF
cQuery +=  " AND PZ9_CAMP = '"+cCamp+"' "+CRLF
cQuery +=  " AND PZ9_ITEM = '"+cCod+"' "+CRLF
cQuery +=  " AND D_E_L_E_T_ = ' ' "+CRLF

dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cArqTmp,.T.,.T.)

If (cArqTmp)->(!Eof())
	
		
	M->PZ9_ITEM  	:= (cArqTmp)->PZ9_ITEM
	M->PZ9_DTEMIS   := STOD((cArqTmp)->PZ9_DTEMIS)
	M->PZ9_PUBLIS   := (cArqTmp)->PZ9_PUBLIS
	M->PZ9_CAMP     := (cArqTmp)->PZ9_CAMP
	M->PZ9_VLCONS   := (cArqTmp)->PZ9_VLCONS
	M->PZ9_PEDIDO   := (cArqTmp)->PZ9_PEDIDO
	M->PZ9_DESCRI   := (cArqTmp)->PZ9_DESCRI
	
	If nOpc == 4//Altera็ใo de consumo
		M->PZ9_SALDO 	:= u_GetSldPP(cCodPublis, cCamp) + (cArqTmp)->PZ9_VLCONS
	Else
		M->PZ9_SALDO 	:= u_GetSldPP(cCodPublis, cCamp)	     
	Endif
EndIf

//Atualiza o objeto MsMGet
oEncCab:EnchRefreshAll()

(cArqTmp)->(DbCloseArea())
RestArea(aArea)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGetSldPP บAutor  ณElton C.		     บ Data ณ  15/12/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina utilizada para retornar o saldo disponivel 		  บฑฑ
ฑฑบ          ณpara consumo			                                      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function GetSldPP(cCodPublis, cCamp)
Local aArea := GetArea()
Local nRet	:= 0

Local cQuery	:= ""
Local cArqTmp	:= GetNextAlias()

Default cCodPublis	:= "" 
Default cCamp		:= ""

cQuery :=  " SELECT SUM(PZ8_SALDO) PZ8_SALDO FROM "+RetSqlName("PZ8")+" PZ8 "+CRLF

cQuery +=  " INNER JOIN "+RetSqlName("P05")+" P05 "
cQuery +=  " ON P05.P05_FILIAL = '"+xFilial("P05")+"' "
cQuery +=  " AND P05.P05_CODPP = PZ8.PZ8_CODPP "
cQuery +=  " AND P05.P05_DTEFET != ' ' "
cQuery +=  " AND P05.D_E_L_E_T_ = ' ' "

cQuery +=  " WHERE PZ8.PZ8_FILIAL = '"+xFilial("PZ8")+"' "+CRLF
cQuery +=  " AND PZ8.PZ8_PUBLIS = '"+cCodPublis+"' "+CRLF
cQuery +=  " AND PZ8.PZ8_CAMP = '"+cCamp+"' "+CRLF
cQuery +=  " AND PZ8.D_E_L_E_T_ = ' ' "+CRLF
cQuery +=  " GROUP BY PZ8_PUBLIS, PZ8_CAMP "+CRLF

dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cArqTmp,.T.,.T.)

If (cArqTmp)->(!Eof())
	nRet := (cArqTmp)->PZ8_SALDO
EndIf

(cArqTmp)->(DbCloseArea())

RestArea(aArea)
Return nRet              


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGrvConhecบAutor  ณElton C.     บ   Data ณ  02/2014		  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณAtualiza o acols do consumo de credito                  	  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿#฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GrvConhec(cCodCons)

Local aArea := GetArea()

Default cCodCons := ""

If !Empty(cCodCons) 
	DbSelectArea("PZ9")
	DbSetOrder(1)
	If PZ9->(DbSeek(xFilial("PZ9") + cCodCons))
		MsDocument( "PZ9", PZ9->( Recno() ), 3 )	
	Else
		Aviso("Aten็ใo","Registro nใo encontrado",{"Ok"},2)				
	EndIf
Else
    Aviso("Aten็ใo","Registro nใo encontrado",{"Ok"},2)
EndIf

RestArea(aArea)
Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGetSts	บAutor  ณElton C.     บ   Data ณ  02/2014		  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRetorna o status do do consumo Price Protection          	  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿#฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetSts(nValUsa, nValSld)

Local aArea 	:= GetArea()
Local cRet		:= ""
Local cOpc		:= ""

Default nValUsa	:= 0 
Default nValSld := 0

If nValUsa == 0//Nใo aplicado  
	cOpc := "3"
ElseIf (nValUsa != 0) .And. (nValSld != 0)//parcialmente aplicado
	cOpc := "4"
ElseIf (nValUsa != 0) .And. (nValSld <= 0)//aplicado
	cOpc := "5"
Else
	cOpc := ""
EndIf



If Alltrim(cOpc) == "3"
	cRet := "BR_VERMELHO"
ElseIf Alltrim(cOpc) == "4"	
	cRet := "BR_AMARELO"	
ElseIf Alltrim(cOpc) == "5"		
	cRet := "BR_VERDE"
Else 
	cRet := ""
EndIf

RestArea(aArea)
Return cRet   

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGetStsPz8	บAutor  ณElton C.     บ   Data ณ  02/2014		  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRetorna o status do do consumo Price Protection          	  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿#฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetStsPz8(cStatus)

Local cRet	:= ""         

Default cStatus := "" 

If cStatus == "1"
	cRet	:= "BR_PRETO"
ElseIf  cStatus == "2"
	cRet	:= "BR_CINZA"
ElseIf  cStatus == "3"
	cRet	:= "BR_VERMELHO"
ElseIf  cStatus == "4"
	cRet	:= "BR_AMARELO"
ElseIf  cStatus == "5"
	cRet	:= "BR_VERDE"
Else

EndIf

Return cRet             



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ LengAglut บAutor  ณElton C.	         บ Data ณ  02/2014	  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณLegenda da campanha aglutinada                              บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function LengAglut()
Local aLegenda 	:= {}
Local aCores	:= {}

Aadd(aCores, {"(PZ8_STATUS == '3') "	, "BR_VERMELHO"   , "Itens que possuem saldo em aberto - Total"  } )
Aadd(aCores, {"(PZ8_STATUS == '4') "	, "BR_AMARELO"   	, "Itens que possuem saldo em aberto - Parcial"  })
Aadd(aCores, {"(PZ8_STATUS == '5') "	, "BR_VERDE"   	, "Itens que nใo possuem saldo em aberto"  } )

aEval(aCores, {|z| Aadd(aLegenda, {z[2], z[3]})})
BrwLegenda(cCadastro, "Legenda", aLegenda)

Return(Nil)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ LengDet บAutor  ณElton C.	         บ Data ณ  02/2014	  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณLegenda da campanha detalhada	                              บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function LengDet()
Local aLegenda 	:= {}
Local aCores	:= {}

Aadd(aCores, {" (PZ8_STATUS == '1') "	, "BR_PRETO"		, "Itens cadastrados e nใo aprovados"  })
Aadd(aCores, {"(PZ8_STATUS == '2') "	, "BR_CINZA"		, "Itens aprovados e nใo aplicada "  })
Aadd(aCores, {"(PZ8_STATUS == '3') "	, "BR_VERMELHO"   	, "Itens que possuem saldo em aberto - Total"  } )
Aadd(aCores, {"(PZ8_STATUS == '4') "	, "BR_AMARELO"   	, "Itens que possuem saldo em aberto - Parcial"  })
Aadd(aCores, {"(PZ8_STATUS == '5') "	, "BR_VERDE"   		, "Itens que nใo possuem saldo em aberto"  } )

aEval(aCores, {|z| Aadd(aLegenda, {z[2], z[3]})})
BrwLegenda(cCadastro, "Legenda", aLegenda)

Return(Nil)
