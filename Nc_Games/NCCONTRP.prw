#INCLUDE "PROTHEUS.CH"
#INCLUDE "msgraphi.ch"
#INCLUDE "APWIZARD.CH"
 

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCCONTRP  �Autor  �Elton C.            � Data �  13/09/13   ���
�������������������������������������������������������������������������͹��
���Desc.     �Controle de repasse									      ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function NCCONTRP()

Local aArea 	:= GetArea()
Private aCores  	:= {;
						{"PZ5_VALUSA == 0"								, "BR_VERMELHO"	, "N�o utilizado"  },;
						{"(PZ5_VALUSA != 0) .And. (PZ5_VALSLD != 0)"	, "BR_AMARELO"  , "Parcialmente utilizado"  },;
						{"(PZ5_VALUSA != 0) .And. (PZ5_VALSLD == 0)"	, "BR_VERDE"   	, "Utilizado"  };
					  }

Private cCadastro := "Controle de repasse Price Protection - CLIENTE"
Private aRotina := MenuDef()

dbSelectArea("PZ5")
dbSetOrder(1)
mBrowse( 6,1,22,75,"PZ5",,,,,,aCores)

RestArea(aArea)
Return        
               



/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Funcao    �Menudef   � Autor � Elton C.		     � Data �  29/09/11   ���
�������������������������������������������������������������������������͹��
���Descricao � Cria o menu da MBrowse.                                    ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � 			                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Static Function Menudef()

Local alRotina := {	{"Pesquisar"		,"AxPesqui"		,0,1},;
					{"&Visualizar"		,"AxVisual"		,0,2},;
					{"&Legenda"			,"U_LEGCTRRP"	,0,6},;
					{"&Pedido/NF Compensa��o","U_NCPNFCOMP"	,0,7},;
					{"&Consulta Titulo" ,"U_NCHISTIT"	,0,8},;
					{"&Vis.Price Protection" ,"U_NCVISPPC",0,9};					
					}
Return alRotina


/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Funcao    �NCPNFCOMP  � Autor � Elton C.		     � Data �  29/09/11   ���
�������������������������������������������������������������������������͹��
���Descricao � Cria o menu da MBrowse.                                    ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � 			                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function NCPNFCOMP()

Local aArea := GetArea()

VisPedNfs(PZ5->PZ5_PREFIX, PZ5->PZ5_TITULO, PZ5->PZ5_PARCEL, PZ5->PZ5_TIPO)

RestArea(aArea)
Return


/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Funcao    �NCHISTIT  � Autor � Elton C.		     � Data �  29/09/11   ���
�������������������������������������������������������������������������͹��
���Descricao � Consulta historico do titulo                               ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � 			                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function NCHISTIT()

Local aArea := GetArea()

VisHisNCC(PZ5->PZ5_PREFIX, PZ5->PZ5_TITULO, PZ5->PZ5_PARCEL, PZ5->PZ5_TIPO)

RestArea(aArea)
Return

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Funcao    �NCVISPPC  � Autor � Elton C.		     � Data �  29/09/11   ���
�������������������������������������������������������������������������͹��
���Descricao � Visualiza��o do Price Protection                           ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � 			                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function NCVISPPC()
Local aArea := GetArea()

VisPP(PZ5->PZ5_CODPP)

RestArea(aArea)
Return



/*/
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �NCCRPAPe  � Autor �ELTON SANTANA		    � Data � 11/10/11 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Funcao para pesquisa                                       ���
�������������������������������������������������������������������������Ĵ��
���Sintaxe   � 								                              ���
�������������������������������������������������������������������������Ĵ��
���Parametros� ExpC1 = Alias do arquivo                                   ���
���          � ExpN1 = Numero do registro                                 ���
���          � ExpN2 = Numero da opcao selecionada                        ���
�������������������������������������������������������������������������Ĵ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function NCCRPAPe(cAlias,nReg,nOpcx)

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

cOrd := aOrd[3]

For ni:=1 to Len(aOrd)
	aOrd[nI] := OemToAnsi(aOrd[nI])
Next

If IndexOrd() >= Len(aOrd)
	cOrd 	:= aOrd[Len(aOrd)]
	nOpt1 := Len(aOrd)
ElseIf IndexOrd() <= 1
	cOrd := aOrd[3]
	nOpt1 := 3
Else
	cOrd := aOrd[3]
	nOpt1 := IndexOrd()
EndIf

DEFINE MSDIALOG oDlg FROM 5, 5 TO 14, 50 TITLE OemToAnsi("Buscar") //"Buscar"
@ 0.6,1.3 COMBOBOX oCBX VAR cOrd ITEMS aOrd  SIZE 165,44  ON CHANGE (nOpt1:=oCbx:nAt)  OF oDlg FONT oDlg:oFont
@ 2.1,1.3	MSGET cCampo SIZE 165,10
DEFINE SBUTTON FROM 055,122	TYPE 1 ACTION (nOpca := 1,oDlg:End()) ENABLE OF oDlg
DEFINE SBUTTON FROM 055,149.1 TYPE 2 ACTION (oDlg  :End()) ENABLE OF oDlg
ACTIVATE MSDIALOG oDlg CENTERED

If nOpca == 1
	dbSelectArea(cAlias)
	nReg := RecNo()
	dbSetOrder(nOpt1)
	
	MsSeek(Alltrim(cCampo),.T.)
	If ! Found()
		Help(" ",1,"PESQ01")
		MsGoTo(nReg)
	EndIf
Else
	DbSelectArea(cAlias)
EndIf

lRefresh := .T.
SetKey(VK_F12,bSav12)

Return



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � NCGC01Leg �Autor  �Elton C.	         � Data �  01/11/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �Legenda do browse                                           ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function LEGCTRRP()
Local aLegenda := {}

aEval(aCores, {|z| Aadd(aLegenda, {z[2], z[3]})})
BrwLegenda(cCadastro, "Legenda", aLegenda)

Return(Nil)



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �VisPedNfs�Autor  �Elton C.	         � Data �  02/24/10   ���
�������������������������������������������������������������������������͹��
���Desc.     �Rotina utilizada para visualizar os pedidos e NF de vendas ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
�����������������������������������������������������������������������������
��#���������������������������������������������������������������������������
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
	
	//Inicializa componente passa a Dialog criada,o segundo parametro � para
	//cria��o de um botao de fechar utilizado para Dlg sem cabe�alho
	oFWLayer:Init( oDlg, .T. )
	
	// Efetua a montagem das colunas das telas
	oFWLayer:AddCollumn( "Col01", 100, .T. )
	
	
	// Cria windows passando, nome da coluna onde sera criada, nome da window
	// titulo da window, a porcentagem da altura da janela, se esta habilitada para click,
	// se � redimensionada em caso de minimizar outras janelas e a a��o no click do split
	oFWLayer:AddWindow( "Col01", "oWin01", "Nota Fiscal \ Pedido - NCC", 100, .F., .T., ,,)
	oWin01	:= oFWLayer:getWinPanel('Col01','oWin01')
	
	//{"F2_DOC","F2_SERIE","E1_PEDIDO","E1_CLIENTE","E1_LOJA","E1_NOMCLI"}	
	
	//Getdados com o controle de repasse com os dados do PP
	oGetDPVNF := MsNewGetDados():New(005,005,220,605 ,0 ,"","","",,,9999,"AllWaysTrue()",,,oWin01,aHeadPVNF,aAcolsPVNF)
	oButPed		:= TButton():New( 225, 470, "Pedido",oWin01,{ || VisPedido(oGetDPVNF:Acols[oGetDPVNF:nAt][3])}, 40,10,,,.F.,.T.,.F.,,.F.,,,.F. )

	oButNF		:= TButton():New( 225, 515, "NF. Sa�da",oWin01,{ ||	VisNfs(oGetDPVNF:Acols[oGetDPVNF:nAt][1],oGetDPVNF:Acols[oGetDPVNF:nAt][2],; 
																	oGetDPVNF:Acols[oGetDPVNF:nAt][4], oGetDPVNF:Acols[oGetDPVNF:nAt][5])};
								, 50,10,,,.F.,.T.,.F.,,.F.,,,.F. )

	oButSair	:= TButton():New( 225, 570, "Sair",oWin01,{ || oDlg:End() }, 30,10,,,.F.,.T.,.F.,,.F.,,,.F. )

	
	ACTIVATE DIALOG oDlg CENTERED
	
	
Else
	Aviso("Dados n�o encontrado", "O t�tulo "+cNumTit+" n�o foi compensado ",{"Ok"},2)
EndIf

(cArqTmp)->(DbCloseArea())

RestArea(aArea)
Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �VisPP�Autor  �Elton C.	         � Data �  02/24/10   	  ���
�������������������������������������������������������������������������͹��
���Desc.     �Visualiza price protection			                   	  ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
�����������������������������������������������������������������������������
��#���������������������������������������������������������������������������
*/  
Static Function VisPP(cCodPP)

Local aArea := GetArea()

Private cAlias1 := "PZC"
Private cAlias2 := "PZD" 

Default cCodPP := ""

DbSelectArea("PZC")
DbSetOrder(1)
If PZC->(DbSeek(xFilial("PZC") + cCodPP))

	//Chama a rotina para visualizar o Price Protection
	u_PP3CManut("PZC", PZC->(Recno()), 2)
Else
	Aviso("N�o encontrado", "Price Protection n�o encontrado "+cCodPP, {"Ok"},2)
EndIf


RestArea(aArea)
Return



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �VisPedido�Autor  �Elton C.	         � Data �  02/24/10   ���
�������������������������������������������������������������������������͹��
���Desc.     �Visualiza pedido de vendas			                   	  ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
�����������������������������������������������������������������������������
��#���������������������������������������������������������������������������
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
	Aviso("N�o encontrado", "Pedido n�o encontrado "+cPedido, {"Ok"},2)
	
EndIf

RestArea(aArea)
Return   


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �VisNfs�Autor  �Elton C.	         �	   Data �  02/24/10   ���
�������������������������������������������������������������������������͹��
���Desc.     �Visualiza nota fiscal de vendas		                   	  ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
�����������������������������������������������������������������������������
��#���������������������������������������������������������������������������
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
	Aviso("N�o encontrado", "Nota fiscal n�o encontrada "+cDoc+"/"+cSerie, {"Ok"},2)
EndIf

RestArea(aArea)
Return



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �VisHisNCC�Autor  �Elton C.	      �	   Data �  02/24/10   ���
�������������������������������������������������������������������������͹��
���Desc.     �Visualiza historico da NCC			                   	  ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
�����������������������������������������������������������������������������
��#���������������������������������������������������������������������������
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
	Aviso("N�o encontrado", "NCC n�o encontrada. Prefixo: "+cPrefixo+" Titulo: "+cTitulo+" Parcela: "+cParcela+" Tipo: "+cTipo, {"Ok"},2)
EndIf

RestArea(aArea)
Return




/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CriaHeader�Autor  �Elton C.	         � Data �  02/24/10   ���
�������������������������������������������������������������������������͹��
���Desc.     �Cria o aHeader						                   	  ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
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

