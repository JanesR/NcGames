#include "totvs.ch"
#include "MSGRAPHI.CH"
#INCLUDE "FONT.CH"
#INCLUDE "COLORS.CH"
#include "TOPCONN.ch"
#INCLUDE "APWIZARD.CH"

#Define BMPSAIR "FINAL.PNG"
#Define BMPRFSH "PMSRRFSH.PNG"
#Define BMPSAVE "SALVAR.PNG"

User Function ConsZZC()

	/*
	-----------------------------------------------------------------------------------------------
	Funcao		- ConsZZC
	Autor 		- Jorge Heitor
	Descricao 	- Consulta IMEI a partir de Parametros
	Data 			- 14/03/2014
	-----------------------------------------------------------------------------------------------
	*/
	
	Private nOpc      := 0
	Private lContinua	:= .F.
	Private cCliente	:= Space(TamSX3("A1_COD")[1])
	Private cLoja		:= Space(TamSX3("A1_LOJA")[1])
	Private cCliAte	:= Space(TamSX3("A1_COD")[1])
	Private cLojaAte	:= Space(TamSX3("A1_LOJA")[1])
	Private cNF			:= Space(TamSX3("D2_DOC")[1])
	Private cSerie		:= Space(TamSX3("D2_SERIE")[1])
	Private cPedido	:= Space(TamSX3("D2_PEDIDO")[1])
	Private cIMEI		:= Space(TamSX3("ZZC_IMEI_1")[1])
	
	_Parametros()
	
	If nOpc > 0 .And. lContinua
		
		_Consulta(nOpc)
		
	EndIf

Return Nil


Static Function _Consulta(nOpc)

	/*
	-----------------------------------------------------------------------------------------------
	Funcao		- _Consulta
	Autor 		- Jorge Heitor
	Descricao 	- Consulta IMEI a partir de Parametros
	Data 			- 14/03/2014
	-----------------------------------------------------------------------------------------------
	*/
	
	Local cQuery := ""
	
	cQuery := " SELECT DISTINCT "
	
	cQuery += " ZZC_PEDIDO AS PEDIDO, "
	cQuery += " ZZC_CODBAR AS CODBAR, "
	cQuery += " ZZC_IMEI_1 AS IMEI_1, "
	cQuery += " ZZC_IMEI_2 AS IMEI_2, "
	cQuery += " ZZC_CLIENT AS CLI, "
	cQuery += " ZZC_LOJA   AS LOJA, "
	cQuery += " ZZC_NOMCLI AS NOMCLI, "
	cQuery += " D2_DOC     AS NF, "
	cQuery += " D2_SERIE   AS SERIE, "
	cQuery += " D2_EMISSAO AS EMISSAO "
	
	cQuery += " FROM "+RetSqlName("ZZC")+" ZZC "
	
	cQuery += " INNER JOIN "+RetSqlName("SC5")+" SC5 ON "
	
	cQuery += " 	C5_NUM = ZZC_PEDIDO "
	cQuery += " 	AND C5_CLIENTE = ZZC_CLIENT "
	cQuery += " 	AND C5_LOJACLI = ZZC_LOJA "
	
	cQuery += " INNER JOIN "+RetSqlName("SD2")+" SD2 ON  "
	cQuery += " 	D2_PEDIDO = C5_NUM "
	
	cQuery += " WHERE "
	cQuery += " 	ZZC.D_E_L_E_T_ = ' ' "
	cQuery += " 	AND SC5.D_E_L_E_T_ = ' ' "
	cQuery += " 	AND SD2.D_E_L_E_T_ = ' ' "
	cQuery += " 	AND ZZC_FILIAL = '"+xFilial("ZZC")+"' "
	cQuery += " 	AND SD2.D2_FILIAL = '"+xFilial("SD2")+"' "
	cQuery += " 	AND SC5.C5_FILIAL = '"+xFilial("SC5")+"' "
	
	If nOpc == 1  // Por Cliente
		
		cQuery += " 	AND ZZC_CLIENT BETWEEN '"+cCliente+"' AND '"+cCliAte+"' "
		cQuery += " 	AND ZZC_LOJA BETWEEN '"+cLoja+"' AND '"+cLojaAte+"' "
		
	ElseIf nOpc == 2 //Por Nota Fiscal
		
		cQuery += " AND D2_DOC = '"+cNF+"'"
		cQuery += " AND D2_SERIE = '"+cSerie+"'"
		
	ElseIf nOpc == 3 // Por IMEI (Verifica IMEI 1 e IMEI 2).
		
		cQuery += " AND ( LTRIM(RTRIM(ZZC_IMEI_1)) = '"+AllTrim(cIMEI)+"' OR LTRIM(RTRIM(ZZC_IMEI_2)) = '"+AllTrim(cIMEI)+"' )"
		
	EndIf
	
	If Select("TRB") > 0
		TRB->(dbCloseArea())
	EndIf
	
	cQuery := ChangeQuery(cQuery)
	
	MsAguarde({|| dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), "TRB", .F., .T.)},"Aguarde! Obtendo os dados...")
	
	dbSelectArea("TRB")
	dbGoTop()
	
	If TRB->(Eof())
		
		MsgStop("Dados não encontrados")
		
	Else
		
		//Monta Tela de Consulta
		_TelaCons()
		
	EndIf

Return Nil


Static Function _Parametros()

	/*
	-----------------------------------------------------------------------------------------------
	Funcao		- _Parametros
	Autor 		- Jorge Heitor
	Descricao 	- Consulta IMEI a partir de Parametros
	Data 			- 14/03/2014
	-----------------------------------------------------------------------------------------------
	*/
	
	/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
	±± Declaração de Variaveis Private dos Objetos                             ±±
	Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
	SetPrvt("oDlg1","oSay1","oSay2","oSay3","oSay4","oSay5","oGet1","oGet2","oRMenu1","oGet4","oGet3","oGet5")
	SetPrvt("oSBtn3")
	
	/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
	±± Definicao do Dialog e todos os seus componentes.                        ±±
	Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
	oDlg1      := MSDialog():New( 156,307,446,594,"Consulta IMEI/Serie",,,.F.,,,,,,.T.,,,.T. )
	GoRMenu1   := TGroup():New( 004,004,056,140,"Selecione uma Opcao",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
	oRMenu1    := TRadMenu():New( 016,010,{"Cliente","Nota Fiscal","IMEI/Serie"},{|u| If(PCount()>0,nOpc:=u,nOpc)},oDlg1,,{|| _RadioChange()},CLR_BLACK,CLR_WHITE,"",,,116,17,,.F.,.F.,.T. )
	
	oSay1      := TSay():New( 060,004,{||"Cliente"},oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,020,008)
	oGet1      := TGet():New( 060,032,{|u| If(PCount()>0,cCliente:=u,cCliente)},oDlg1,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SA1","cCliente",,)
	
	oSay2      := TSay():New( 060,097,{||"Loja"},oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,015,008)
	oGet2      := TGet():New( 060,116,{|u| If(PCount()>0,cLoja:=u,cLoja)},oDlg1,020,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cLoja",,)
	
	oSay3      := TSay():New( 075,004,{||"Ate Cliente"},oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,020,008)
	oGet3      := TGet():New( 075,032,{|u| If(PCount()>0,cCliAte:=u,cCliAte)},oDlg1,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"SA1","cCliAte",,)
	
	oSay4      := TSay():New( 075,097,{||"Loja"},oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,015,008)
	oGet4      := TGet():New( 075,116,{|u| If(PCount()>0,cLojaAte:=u,cLojaAte)},oDlg1,020,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cLojaAte",,)
	
	oSay5      := TSay():New( 091,004,{||"Nota Fiscal"},oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,031,008)
	oGet5      := TGet():New( 091,033,{|u| If(PCount()>0,cNF:=u,cNF)},oDlg1,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cNF",,)
	
	oSay6      := TSay():New( 091,098,{||"Serie"},oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,015,008)
	oGet6      := TGet():New( 091,117,{|u| If(PCount()>0,cSerie:=u,cSerie)},oDlg1,020,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cSerie",,)
	
	oSay7      := TSay():New( 108,004,{||"IMEI/Serie"},oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,026,008)
	oGet7      := TGet():New( 108,042,{|u| If(PCount()>0,cIMEI:=u,cIMEI)},oDlg1,94,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cIMEI",,)
	
	oSBtn2     := SButton():New( 125,109,2,{|| lContinua := .F.,oDlg1:End()},oDlg1,,"", ) // Cancelar
	oSBtn3     := SButton():New( 125,081,1,{|| lContinua := .T.,oDlg1:End()},oDlg1,,"", ) // Confirmar
	
	//Inicializa desabilitando os outros campos para manter a logica da rotina
	oGet5:Disable()
	oGet6:Disable()
	oGet7:Disable()
	oGet1:Enable()
	oGet2:Enable()
	oGet3:Enable()
	oGet4:Enable()
	
	oDlg1:Activate(,,,.T.)
	


Return


Static Function _RadioChange()

	/*
	-----------------------------------------------------------------------------------------------
	Funcao		- _RadioChange
	Autor 		- Jorge Heitor
	Descricao 	- Ajusta componentes na mudanca de opcoes
	Data 		- 14/03/2014
	-----------------------------------------------------------------------------------------------
	*/
	
	If nOpc == 1
		oGet1:Enable()
		oGet2:Enable()
		oGet3:Enable()
		oGet4:Enable()
		oGet5:Disable()
		oGet6:Disable()
		oGet7:Disable()
		
	ElseIf nOpc == 2
		oGet1:Disable()
		oGet2:Disable()
		oGet3:Disable()
		oGet4:Disable()
		oGet5:Enable()
		oGet6:Enable()
		oGet7:Disable()
		
	ElseIf nOpc == 3
		oGet1:Disable()
		oGet2:Disable()
		oGet3:Disable()
		oGet4:Disable()
		oGet5:Disable()
		oGet6:Disable()
		oGet7:Enable()
	EndIf

Return

Static Function _TelaCons()

	/*
	-----------------------------------------------------------------------------------------------
	Funcao		- _TelaCons
	Autor 		- Jorge Heitor
	Descricao 	- Tela de Consulta Visual
	Data 			- 18/03/2014
	-----------------------------------------------------------------------------------------------
	*/
	
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
	Local bExcel			:= {|| ExpExcel(aCols),oDlg:End()  }  //Salva o Cadastro
	Local oButton
	Local oButton2
	
	Private aCampos	:= {"PEDIDO","CODBAR","IMEI_1","IMEI_2","CLI","LOJA","NOMCLI","NF","SERIE","EMISSAO"}
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
	
	//Inicializa componente passa a Dialog criada,o segundo parametro é para
	//criação de um botao de fechar utilizado para Dlg sem cabeçalho
	oFWLayer:Init( oDlg, .T. )
	
	// Efetua a montagem das colunas das telas
	oFWLayer:AddCollumn( "Col01", 100, .T. )
	
	
	// Cria windows passando, nome da coluna onde sera criada, nome da window
	// titulo da window, a porcentagem da altura da janela, se esta habilitada para click,
	// se é redimensionada em caso de minimizar outras janelas e a ação no click do split
	oFWLayer:AddWindow( "Col01", "Win01", "Consulta IMEI", 100 , .F., .T., {|| .T. },,)
	
	oWin01 := oFWLayer:getWinPanel('Col01','Win01')
	
	//Cria a getdados da tabela PZ1
	oGetD := MsNewGetDados():New(005,005,165,650 ,0 ,"","","",,,9999,"AllWaysTrue()",,,oWin01,aHeader,aCols)
	
	//Adiciona a barra dos botões
	DEFINE BUTTONBAR oBarBtn SIZE 30,30 3D BOTTOM OF oWin01
	
	oButton	:= TBtnBmp():NewBar( aButton[1,1],aButton[1,2],,,aButton[1,3], aButton[1,4],.T.,oBarBtn,,,aButton[1,5])
	oButton:cTitle := aButton[1,3]
	oButton:Align := CONTROL_ALIGN_LEFT
	
	oButton2	:= TBtnBmp():NewBar( aButton[2,1],aButton[2,2],,,aButton[2,3], aButton[2,4],.T.,oBarBtn,,,aButton[2,5])
	oButton:cTitle := aButton[2,3]
	oButton:Align := CONTROL_ALIGN_LEFT
	
	ACTIVATE DIALOG oDlg CENTERED
	
	RestArea(aArea)
	
	Return
	
	Static Function CriaHeader()
	
	Local aRet	 	:= {}
	
	AADD(aRet,{"PEDIDO","PEDIDO","@!",TamSX3("C5_NUM")[1],0,,,"C",,,,} )
	AADD(aRet,{"CODBAR","CODBAR","",TamSX3("ZZC_CODBAR")[1],0,,,"C",,,,} )
	AADD(aRet,{"IMEI_SERIE_1","IMEI1","",TamSX3("ZZC_IMEI_1")[1],0,,,"C",,,,} )
	AADD(aRet,{"IMEI_SERIE_2","IMEI2","",TamSX3("ZZC_IMEI_2")[1],0,,,"C",,,,} )
	AADD(aRet,{"CLI","CLI","",TamSX3("A1_COD")[1],0,,,"C",,,,} )
	AADD(aRet,{"LOJA","LOJA","",TamSX3("A1_LOJA")[1],0,,,"C",,,,} )
	AADD(aRet,{"NOMCLI","NOMCLI","",TamSX3("ZZC_NOMCLI")[1],0,,,"C",,,,} )
	AADD(aRet,{"NF","NF","",TamSX3("F2_DOC")[1],0,,,"C",,,,})
	AADD(aRet,{"SERIE","SERIE","",TamSX3("F2_SERIE")[1],0,,,"C",,,,})
	AADD(aRet,{"EMISSAO","EMISSAO","",10,0,,,"C",,,,} )

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
		aAdd(aRet,{	TRB->PEDIDO,;
		TRB->CODBAR,;
		TRB->IMEI_1,;
		TRB->IMEI_2,;
		TRB->CLI,;
		TRB->LOJA,;
		TRB->NOMCLI,;
		TRB->NF,;
		TRB->SERIE,;
		DTOC(STOD(TRB->EMISSAO)),; //para deixar no formato XX/XX/XX,;
		,.F.})
		
		TRB->(dbSkip())
	End

Return aRet



Static Function ExpExcel(aCols)

	/*
	-----------------------------------------------------------------------------------------------
	Funcao		- ExpExcel
	Autor 		- Jorge Heitor
	Descricao 	- Funcao que exporta os registros para o excel e abre em dbf
	Data 			- 18/03/2014
	-----------------------------------------------------------------------------------------------
	*/

   Local aItens := {}
   Local aCabExcel := {}
   
   For x:=1 to Len(aCols)
   	AADD(aItens,{;
   						"'"+aCols[x][1],;
   						"'"+aCols[x][2],;
   						"'"+aCols[x][3],;
   						"'"+aCols[x][4],;
   						"'"+aCols[x][5],;
   						"'"+aCols[x][6],;
   						aCols[x][7],;
   						"'"+aCols[x][8],;
   						"'"+aCols[x][9],;
   						aCols[x][10],;
   						"";
 						})
	Next x  
  
	AADD(aCabExcel,{"PEDIDO","C",TamSX3("C5_NUM")[1],0} )
	AADD(aCabExcel,{"CODIGO_BARRAS","C",TamSX3("ZZC_CODBAR")[1],0} )
	AADD(aCabExcel,{"IMEI_SERIE_1","C",TamSX3("ZZC_IMEI_1")[1],0} )
	AADD(aCabExcel,{"IMEI1_SERIE_2","C",TamSX3("ZZC_IMEI_2")[1],0} )
	AADD(aCabExcel,{"CLIENTE","C",TamSX3("A1_COD")[1],2} )
	AADD(aCabExcel,{"LOJA","C",TamSX3("A1_LOJA")[1],2} )
	AADD(aCabExcel,{"NOME_CLIENTE","C",TamSX3("ZZC_NOMCLI")[1],0} )
	AADD(aCabExcel,{"NOTA_FISCAL","C",TamSX3("F2_DOC")[1],0})
	AADD(aCabExcel,{"SERIE","C",TamSX3("F2_SERIE")[1],0})
	AADD(aCabExcel,{"EMISSAO","C",10,0} )
	AADD(aCabExcel,{" " 		 ,"C", 2, 0})    

	MsgRun("Favor Aguardar, Exportando para EXCEL....", "Exportando os Registros para o Excel",{||DlgToExcel({{"GETDADOS","",aCabExcel,aItens}})})

Return
