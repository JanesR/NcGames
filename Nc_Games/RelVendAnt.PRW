#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'RWMAKE.CH'
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'

#Define BMPSAIR "FINAL.PNG"
#Define BMPRFSH "PMSRRFSH.PNG"
#Define BMPSAVE "SALVAR.PNG"

User Function NcCLiProNF                                
                         
	Local aArea := GetArea()
	Private cCliFim    	:= Space(TamSx3("A1_COD")[1])
	Private cCliIni    	:= Space(TamSx3("A1_COD")[1])
	Private cLojaFim   	:= Space(TamSx3("A1_LOJA")[1])
	Private cLojaIni   	:= Space(TamSx3("A1_LOJA")[1])
	Private cProdFim	:= Space(TamSx3("B1_COD")[1])
	Private cProdIni	:= Space(TamSx3("B1_COD")[1])
	Private dDataFim	:= cTod("  /  /  ")
	Private dDataIni	:= cTod("  /  /  ")
	Private lCheck		:= .F. //Utiliza Fornecedor 

	/*컴컴컴컴컴컴컨컴컴컴컴좔컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴袂?
	굇 Declara豫o de Variaveis Private dos Objetos                             굇
	袂굼컴컴컴컴컴컴컴좔컴컴컴컨컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴?*/
	SetPrvt("oDlg1","oGrp1","oSay1","oSay2","oSay3","oSay4","oSay5","oSay6","oSay7","oSay8","oGet1","oGet2")
	SetPrvt("oGet4","oGet5","oGet6","oGet7","oGet8","oSBtn1","oSBtn2")

	/*컴컴컴컴컴컴컨컴컴컴컴좔컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴袂?
	굇 Definicao do Dialog e todos os seus componentes.                        굇
	袂굼컴컴컴컴컴컴컴좔컴컴컴컨컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴?*/
	oDlg1      := MSDialog():New( 147,256,418,693,"PRODUTOS, NOTAS E CLIENTE",,,.F.,,,,,,.T.,,,.T. )
	oGrp1      := TGroup():New( 004,004,124,212,"Produtos Comprados",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
	oSay1      := TSay():New( 016,008,{||"Cliente Inicial"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
	oSay2      := TSay():New( 016,120,{||"Loja Inicial"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
	oSay3      := TSay():New( 036,008,{||"Ate Cliente"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
	oSay4      := TSay():New( 036,120,{||"Ate Loja"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,028,008)
	oSay5      := TSay():New( 056,008,{||"Produto de"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
	oSay6      := TSay():New( 056,120,{||"Ate"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,012,008)
	oSay7      := TSay():New( 076,008,{||"Emissao de"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
	oSay8      := TSay():New( 076,120,{||"Ate"},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,012,008)
	oGet1      := TGet():New( 016,044,{|u| If(PCount()>0,cCliIni:=u,cCliIni)},oGrp1,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SA1","cCliIni",,)
	oGet2      := TGet():New( 016,152,{|u| If(PCount()>0,cLojaIni:=u,cLojaIni)},oGrp1,016,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cLojaIni",,)
	oGet3      := TGet():New( 036,044,{|u| If(PCount()>0,cCliFim:=u,cCliFim)},oGrp1,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SA1","cCliFim",,)
	oGet4      := TGet():New( 036,152,{|u| If(PCount()>0,cLojaFim:=u,cLojaFim)},oGrp1,016,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cLojaFim",,)
	oGet5      := TGet():New( 056,044,{|u| If(PCount()>0,cProdIni:=u,cProdIni)},oGrp1,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SB1","cProdIni",,)
	oGet6      := TGet():New( 056,140,{|u| If(PCount()>0,cProdFim:=u,cProdFim)},oGrp1,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SB1","cProdFim",,)
	oGet7      := TGet():New( 076,044,{|u| If(PCount()>0,dDataIni:=u,dDataIni)},oGrp1,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dDataIni",,)
	oGet8      := TGet():New( 076,140,{|u| If(PCount()>0,dDataFim:=u,dDataFim)},oGrp1,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","dDataFim",,)
	oSBtn1     := SButton():New( 100,140,1,{ || oDlg1:End(),CriaConsulta() },oGrp1,,"", )
	oSBtn2     := SButton():New( 100,172,2,{ || oDlg1:End() },oGrp1,,"", )
                                                                             
	oCheck	   := TCheckBox():New( 100,30,'Usa Fornecedor',{|u| If(PCount()>0,lCheck:=u,lCheck)},oDlg1,060,008,,/*bLClicked*/{|| _Fornece()},,,CLR_BLACK,CLR_WHITE,,.T.,"",, )


	oDlg1:Activate(,,,.T.)



	RestArea(aArea)
Return


/*
Fun豫o que reliza a consulta e mostra a tela de notas
*/
Static Function CriaConsulta

	Local aArea := GetArea()      
	Local cAlias :="TRB"
	Local cQuery
	Local aCabExcel  :={}
	Local aItens	 :={}
	
	If Select(cAlias) > 0
		(cAlias)->(DbCloseArea())
	EndIf

	cQuery := " SELECT B1_CODBAR EAN, B1_COD COD_NC,B1_DESC DESCRICAO, D2_DOC DOCUMENTO,D2_SERIE SERIE, "
	cQuery += " D2_EMISSAO EMISSAO, D2_QUANT QUANTIDADE, "

	cQuery += Iif(lCheck,"A2_NREDUZ NOME,","A1_NREDUZ NOME,") //Tratamento quando utiliza Fornecedor

	cQuery += " D2_CLIENTE CLIENTE, D2_LOJA LOJA "
	cQuery += " FROM "+RetSqlName("SD2")+" SD2 "
	
	cQuery += " INNER JOIN "+RetSqlName("SB1")+" SB1 ON  "
	cQuery += " 	B1_COD = D2_COD "

	If lCheck //Tratamento quando utiliza Fornecedor
	
		cQuery += " INNER JOIN "+RetSqlName("SA2")+" SA2 ON "
		cQuery += " 	A2_COD = D2_CLIENTE "
		cQuery += " 	AND A2_LOJA = D2_LOJA "
		
	Else
	
		cQuery += " INNER JOIN "+RetSqlName("SA1")+" SA1 ON "
		cQuery += " 	A1_COD = D2_CLIENTE "
		cQuery += " 	AND A1_LOJA = D2_LOJA "
		
	EndIf
	
	cQuery += " WHERE SD2.D_E_L_E_T_ = ' ' "
	cQuery += " AND SB1.D_E_L_E_T_ = ' ' " 
	If lCheck
		cQuery += " AND SA2.D_E_L_E_T_ = ' '"  
		cQuery += " AND SA2.A2_FILIAL = '"+xFilial("SA2")+"'"	
	Else		
		cQuery += " AND SA1.D_E_L_E_T_ = ' '"  
		cQuery += " AND SA1.A1_FILIAL = '"+xFilial("SA1")+"'"	
	EndIf
	
	cQuery += " AND SD2.D2_FILIAL = '"+xFilial("SD2")+"'"
	cQuery += " AND SB1.B1_FILIAL = '"+xFilial("SB1")+"'"
                                     
	cQuery += " AND SD2.D2_COD BETWEEN '"+cProdIni+"' AND '"+cProdFim+"'"
	cQuery += " AND SD2.D2_CLIENTE BETWEEN '"+cCliIni+"' AND '"+cCliFim+"'"
	cQuery += " AND SD2.D2_LOJA BETWEEN '"+cLojaIni+"' AND '"+cLojaFim+"' "
	cQuery += " AND SD2.D2_EMISSAO BETWEEN '"+DTOS(dDataIni)+"' AND '"+DTOS(dDataFim)+"'"
	cQuery += " AND SD2.D2_COD = SB1.B1_COD"
	cQuery += " ORDER BY SD2.D2_DOC,SD2.D2_EMISSAO"
	
	
	 
	cQuery := ChangeQuery(cQuery)
		
	MsgRun( "Coletando os dados......","Coleta de Dados",{|| dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAlias,.T.,.T.)} )
		//	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAlias,.T.,.T.)
	
	IF !(cAlias)->(Eof())
	                                                                                      
	   //Monta tela de consulta
	   _ConsTela()
  		
	ELSE
	    
  		alert("SEM RESULTADOS PARA ESTES PARAMETROS")
	
	ENDIF
	
	dbCloseArea(cAlias)
	
	RestArea(aArea)

Return

Static Function _ConsTela()

Local bExcel := {|| _GoToExcel(aCols)} //Local bExcel := {|| _GoToExcel(aCols), oDlg:End() }
Local bSair := {|| oDlg:End()}
Local aArea := GetArea()
Local oDlg
Local oWin01
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
Local oButton
Local oButton2

Private aHeader  := {}
Private aCols 	:= {}
Private oGetD
Private oTMultiget

//Preenche o aheader e o acols da tabela TRB
aHeader := CriaHeader()//Cria o aheader da tabela TRB
aCols := CriaAcols()//Cria o acols da tabela TRB

//Botoes do monitor
aAdd(aButton, { BMPSAIR		, BMPSAIR		, /*"Sair"*/	   	, bSair		, /*"Sair"*/  	})
aAdd(aButton, { BMPSAVE		, BMPSAVE		,  /*"Exporta Excel"*/  		, bExcel		, /*"Exporta Excel"*/  	})


//Montagem da tela
DEFINE DIALOG oDlg TITLE "Consulta IMEI" SIZE nWStage,nHStage PIXEL STYLE nOr(WS_VISIBLE,WS_POPUP) //"Empresas"

//Cria instancia do fwlayer
oFWLayer := FWLayer():New()

//Inicializa componente passa a Dialog criada,o segundo parametro ?para
//cria豫o de um botao de fechar utilizado para Dlg sem cabe?lho
oFWLayer:Init( oDlg, .T. )

// Efetua a montagem das colunas das telas
oFWLayer:AddCollumn( "Col01", 100, .T. )


// Cria windows passando, nome da coluna onde sera criada, nome da window
// titulo da window, a porcentagem da altura da janela, se esta habilitada para click,
// se ?redimensionada em caso de minimizar outras janelas e a a豫o no click do split
oFWLayer:AddWindow( "Col01", "Win01", "Consulta IMEI", 100 , .F., .T., {|| .T. },,)

oWin01 := oFWLayer:getWinPanel('Col01','Win01')

//Cria a getdados da tabela PZ1
oGetD := MsNewGetDados():New(005,005,aSize[4]-40,aSize[6]-10,0 ,"","","",,,9999,"AllWaysTrue()",,,oWin01,aHeader,aCols)

//Adiciona a barra dos bot?s
DEFINE BUTTONBAR oBarBtn SIZE 30,30 3D BOTTOM OF oWin01

oButton	:= TBtnBmp():NewBar( aButton[1,1],aButton[1,2],,,aButton[1,3], aButton[1,4],.T.,oBarBtn,,,aButton[1,5])
oButton:cTitle := aButton[1,3]
oButton:Align := CONTROL_ALIGN_LEFT

oButton2	:= TBtnBmp():NewBar( aButton[2,1],aButton[2,2],,,aButton[2,3], aButton[2,4],.T.,oBarBtn,,,aButton[2,5])
oButton:cTitle := aButton[2,3]
oButton:Align := CONTROL_ALIGN_LEFT

ACTIVATE DIALOG oDlg CENTERED

RestArea(aArea)

Return Nil


Static Function CriaHeader()

	Local aRet	 	:= {}
	
/*	AADD(aRet,{"EAN"			,"EAN"			,""	,TamSX3("B1_CODBAR")[1],0,,,"C",,,,} )//	AADD(aRet,{"EAN"				,"EAN"			,"@!"	,TamSX3("B1_CODBAR")[1],0,,,"C",,,,} )
	AADD(aRet,{"CODIGO NC"		,"COD_NC"		,""	,TamSX3("B1_COD")[1],0,,,"C",,,,} )
	AADD(aRet,{"DESCRICAO"		,"DESCRICAO"	,""	,TamSX3("B1_DESC")[1],0,,,"C",,,,} )
	AADD(aRet,{"NOTA FISCAL"	,"DOCUMENTO"	,""	,TamSX3("D2_DOC")[1],0,,,"C",,,,} )
	AADD(aRet,{"SERIE"			,"SERIE"		,""	,TamSX3("D2_SERIE")[1],0,,,"C",,,,} )
	AADD(aRet,{"EMISSAO"		,"EMISSAO"		,""	,10,0,,,"C",,,,} )
	AADD(aRet,{"QUANTIDADE"		,"QUANTIDADE"	,""	,TamSX3("D2_QUANT")[1],0,,,"C",,,,} )
	AADD(aRet,{"COD.CLIENTE"	,"CLIENTE"		,""	,TamSX3("A1_COD")[1],0,,,"C",,,,})
	AADD(aRet,{"LOJA "			,"LOJA"			,""	,TamSX3("A1_LOJA")[1],0,,,"C",,,,})
	AADD(aRet,{"NOME CLIENTE"	,"NOME"			,""	,TamSX3("A1_NOME")[1],0,,,"C",,,,} )*/
	AADD(aRet,{"EAN"			,"EAN"			,""	,TamSX3("B1_CODBAR")[1],0,,,"N",,,,} )//	AADD(aRet,{"EAN"				,"EAN"			,"@!"	,TamSX3("B1_CODBAR")[1],0,,,"C",,,,} )
	AADD(aRet,{"CODIGO NC"		,"COD_NC"		,""	,TamSX3("B1_COD")[1],0,,,"N",,,,} )
	AADD(aRet,{"DESCRICAO"		,"DESCRICAO"	,""	,TamSX3("B1_DESC")[1],0,,,"N",,,,} )
	AADD(aRet,{"NOTA FISCAL"	,"DOCUMENTO"	,""	,TamSX3("D2_DOC")[1],0,,,"N",,,,} )
	AADD(aRet,{"SERIE"			,"SERIE"		,""	,TamSX3("D2_SERIE")[1],0,,,"N",,,,} )
	AADD(aRet,{"EMISSAO"		,"EMISSAO"		,""	,10,0,,,"D",,,,} )
	AADD(aRet,{"QUANTIDADE"		,"QUANTIDADE"	,""	,TamSX3("D2_QUANT")[1],0,,,"N",,,,} )
	AADD(aRet,{"COD.CLIENTE"	,"CLIENTE"		,""	,TamSX3("A1_COD")[1],0,,,"N",,,,})
	AADD(aRet,{"LOJA "			,"LOJA"			,""	,TamSX3("A1_LOJA")[1],0,,,"N",,,,})
	AADD(aRet,{"NOME CLIENTE"	,"NOME"			,""	,TamSX3("A1_NOME")[1],0,,,"N",,,,} )



Return aRet


Static Function CriaAcols()

	Local aStruct	 	:= {}
	Local nX			:= 0
	Local aRet			:= {}
	Local cAliasTmp		:= ""
	Local cQuery		:= ""
	
	aRet := {}
	
	DbSelectArea("TRB")
	While !eof()
		aAdd(aRet,{		TRB->EAN,;
						TRB->COD_NC,;
						TRB->DESCRICAO,;
						TRB->DOCUMENTO,;
						TRB->SERIE,;
						DTOC(STOD(TRB->EMISSAO)),;  //para deixar no formato XX/XX/XX,;
						TRB->QUANTIDADE,;
						TRB->CLIENTE,;
						TRB->LOJA,;
						TRB->NOME,;
						,.F.})
		
		TRB->(dbSkip())
	End

Return aRet


Static Function _GoToExcel(aCols)
   
   Local aItens := {}
   Local aCabExcel := {}
   
   For x:=1 to Len(aCols)  
   						/*"'"+aCols[x][1],;
   						"'"+aCols[x][2],;
   						aCols[x][3],;
   						"'"+aCols[x][4],;
   						"'"+aCols[x][5],;
   						aCols[x][6],;
   						aCols[x][7],;
   						"'"+aCols[x][8],;
   						"'"+aCols[x][9],;
   						aCols[x][10],;
   						"";
 						*/
   	AADD(aItens,{;
   						aCols[x][1],;
   						aCols[x][2],;
   						aCols[x][3],;
   						aCols[x][4],;
   						aCols[x][5],;
   						aCols[x][6],;
   						aCols[x][7],;
   						aCols[x][8],;
   						aCols[x][9],;
   						aCols[x][10],;
   						"";
 						})
	Next x
   						
    
	AADD(aCabExcel, {"EAN" 			,"N", 15, 0})   
	AADD(aCabExcel, {"COD_NC" 		,"N", 2,  0})   
	AADD(aCabExcel, {"DESCRI플O" 	,"N", 50, 0})   
	AADD(aCabExcel, {"DOCUMENTO" 	,"N", 9,  0})   
	AADD(aCabExcel, {"SERIE" 		,"N", 2,  0})   
	AADD(aCabExcel, {"EMISSAO" 		,"N", 11, 0})   
	AADD(aCabExcel, {"QUANTIDADE" 	,"N", 15, 2}) 
	AADD(aCabExcel, {"CLIENTE" 		,"N", 6,  0})   
	AADD(aCabExcel, {"LOJA" 		,"N", 2,  0})
    AADD(aCabExcel, 	{"Nome" 		,"N", 30, 0})   
	AADD(aCabExcel, {" " 			,"N", 2,  0})   
  

	MsgRun("Favor Aguardar, Exportando para EXCEL....", "Exportando os Registros para o Excel",{||DlgToExcel({{"GETDADOS","",aCabExcel,aItens}})})

Return


Static Function _Fornece()

If lCheck
	oSay1:cCaption := "Fornecedor"
	oSay3:cCaption := "Ate Fornece"
	oGet1:cF3 := "SA2"
	oGet3:cF3 := "SA2"	
	cCliFim    	:= Space(TamSx3("A1_COD")[1])
	cCliIni    	:= Space(TamSx3("A1_COD")[1])
	cLojaFim   	:= Space(TamSx3("A1_LOJA")[1])
	cLojaIni   	:= Space(TamSx3("A1_LOJA")[1])
	oGet1:Refresh()
	oGet2:Refresh()
	oGet3:Refresh()
	oGet4:Refresh()
Else
	oSay1:cCaption := "Cliente Inicial"
	oSay3:cCaption := "Ate Cliente"
	oGet1:cF3 := "SA1"
	oGet3:cF3 := "SA1" 
	cCliFim    	:= Space(TamSx3("A1_COD")[1])
	cCliIni    	:= Space(TamSx3("A1_COD")[1])
	cLojaFim   	:= Space(TamSx3("A1_LOJA")[1])
	cLojaIni   	:= Space(TamSx3("A1_LOJA")[1])
	oGet1:Refresh()
	oGet2:Refresh()
	oGet3:Refresh()
	oGet4:Refresh()
EndIf 

Return