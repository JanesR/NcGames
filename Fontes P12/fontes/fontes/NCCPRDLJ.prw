#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCCPRDLJ  ºAutor  ³Microsiga		    º Data ³  06/16/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Consulta o codigo do produto utilizado nas lojas		    º±±
±±º          ³ 	                          								    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function NCCPRDLJ(cProd)

Local aArea 		:= GetArea()
Local aPerg		:= {}
Local aPergAux  	:= {}

Default cProd := ""

aPergAux := PergCons(cProd)

If aPergAux[1]
	aPerg	:= aPergAux[2]

	If Len(aPerg) > 0
		Processa( {|| 	TelaCons(aPerg[1]	,;//Emissao de
									 aPerg[2]	,;//Emissao ate 
									 aPerg[3]	,;//Doc de 	
									 aPerg[4]	,;//Doc Ate 
									 aPerg[5]	,;//Serie 
									 aPerg[6]); //Codigo do Produto
			 	},"","Processando..." ) 
	EndIf
EndIf
RestArea(aArea)
Return .T.




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PergCons	 ºAutor  ³Microsiga          º Data ³  26/01/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Perguntas utilizada na consulta	                             º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PergCons(cProd)

Local aArea 		:= GetArea()
Local aRetResp  	:= {}
Local aParamBox	:= {} 
Local lRet			:= .F.
Local aRet			:= {}		

AADD(aParamBox,{1,"Emissão de "		,CtoD("//")						,"@D"	,"" 	,"" 		,"",70,.T.})
AADD(aParamBox,{1,"Emissão até "	,CtoD("//")						,"@D"	,"" 	,""			,"",70,.T.})
AADD(aParamBox,{1,"Documento de: "	,Space(TAMSX3("D2_DOC")[1])		,"@!"	,""		,""	 		,"",70,.F.})
AADD(aParamBox,{1,"Documento até "	,Space(TAMSX3("D2_DOC")[1])		,"@!"	,""		,""	 		,"",70,.T.})
AADD(aParamBox,{1,"Serie"			,Space(TAMSX3("D2_SERIE")[1])	,"@!"	,""		,""			,"",70,.F.})

If Alltrim(cEmpAnt) $ '03|40'
	AADD(aParamBox,{1,"Produto Loja"	,Iif( !Empty(cProd), cProd, Space(TAMSX3("A7_CODCLI")[1])	),"@!"	,""		,"SB1"	,"",70,.F.})
Else
	AADD(aParamBox,{1,"Produto Loja"	,Iif( !Empty(cProd), cProd ,Space(TAMSX3("A7_CODCLI")[1])	),"@!"	,""		,"SA7LJ"	,"",70,.F.})
EndIf

//Monta a pergunta
lRet := ParamBox(aParamBox ,"Parametros",@aRetResp,,,.T.,50,50,,,.T.,.T.)

aRet := {lRet, aRetResp}

RestArea(aArea)
Return aRet  


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³TelaCons	 ºAutor  ³Microsiga          º Data ³  26/01/16  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Tela de consulta			                               	    º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function TelaCons(dEmissaoDe, dEmissaoAte, cDocDe, cDocAte, cSerie, cCodProd)

Local aArea := GetArea()
Local oDlg
Local oWin01
Local oFWLayer
Local oSize 			:= Nil
Local aButtons		:= {}
Local aCampos			:= {}
Local aHeader			:= {}
Local aAcols			:= {}
Local oGetD			:= Nil
Local bOk				:= {|| oDlg:End() }
Local lRet				:= .F.
Local bCancel			:= {|| oDlg:End() }


Default dEmissaoDe	:= CTOD('') 
Default dEmissaoAte	:= CTOD('') 
Default cDocDe		:= "" 
Default cDocAte		:= "" 
Default cSerie		:= "" 
Default cCodProd		:= ""

If Upper(Alltrim(cEmpAnt)) $ "03|40"
	aCampos 	:= {"D1_DOC",	"D1_SERIE","D1_DTDIGIT","D1_COD","B1_CODBAR","A7_CODCLI","D1_QUANT","D1_VUNIT","D1_TOTAL","B1_XDESC"}
	aHeader	:= CriaHeader(aCampos) 	
	aAcols		:= CriaAcUzPg(cDocDe, cDocAte, cSerie, dEmissaoDe, dEmissaoAte, cCodProd) 

Else
	aCampos 	:= {"D2_DOC",	"D2_SERIE","D2_EMISSAO","D2_COD","B1_CODBAR","A7_CODCLI","D2_QUANT","D2_PRCVEN","D2_TOTAL","B1_XDESC"}
	aHeader	:= CriaHeader(aCampos) 	
	aAcols		:= CriaAcol01( cDocDe, cDocAte, cSerie, dEmissaoDe, dEmissaoAte, cCodProd ) 
EndIf

//-----------------------------------------
// Criação de classe para definição da proporção da interface
//-----------------------------------------
oSize := FWDefSize():New(.T.)
oSize:Process()

DEFINE DIALOG oDlg TITLE "Consulta de produto utilizado em lojas proprias" FROM oSize:aWindSize[1],oSize:aWindSize[2] TO oSize:aWindSize[3],oSize:aWindSize[4] PIXEL STYLE nOr(WS_VISIBLE,WS_POPUP)

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
oFWLayer:AddWindow( "Col01", "Win01", "Consulta de produto utilizado em loja",100, .F., .T., ,,)


oWin01 := oFWLayer:getWinPanel('Col01','Win01')
    
//Cria a getdados
oGetD := MsNewGetDados():New(001,001,__Dlgheight(oWin01)-10,__DlgWidth(oWin01),0 ,"","","",,,9999,"AllWaysTrue()",,,oWin01,aHeader,aAcols)



ACTIVATE DIALOG oDlg CENTERED ON INIT ( EnchoiceBar(oDlg,bOk,bCancel,,aButtons) )

RestArea(aArea)
Return         


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CriaHeader	 ºAutor  ³Microsiga          º Data ³  26/01/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Cria o cabeçalho do acols		                             º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
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
		
		aAdd( aRet, {SX3->X3_TITULO		, ;	// 01 - Titulo
						SX3->X3_CAMPO		, ;	// 02 - Campo
						SX3->X3_Picture	, ;	// 03 - Picture
						SX3->X3_TAMANHO	, ;	// 04 - Tamanho
						SX3->X3_DECIMAL	, ;	// 05 - Decimal
						SX3->X3_Valid  	, ;	// 06 - Valid
						SX3->X3_USADO  	, ;	// 07 - Usado
						SX3->X3_TIPO   	, ;	// 08 - Tipo
						SX3->X3_F3			, ;	// 09 - F3
						SX3->X3_CONTEXT	, ;	// 10 - Contexto
						SX3->X3_CBOX		, ; // 11 - ComboBox
						SX3->X3_RELACAO	} )	// 12 - Relacao
	Endif
Next

RestArea( aArea )
Return aRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CriaAcolsNC ºAutor  ³Microsiga         º Data ³  26/01/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Cria o cabeçalho do acols		                             º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function CriaAcol01( cDocDe, cDocAte, cSerie, dEmisDe, dEmisAte, cCodProd )
Local aArea    	:= GetArea()
Local aStruct	 	:= {}
Local nX				:= 0
Local aRet			:= {}
Local cAliasTmp	:= ""
Local cQuery		:= ""
Local cCodCli		:= Alltrim(U_MyNewSX6("NC_NCG130C","000000"	,"C","Cliente utilizado na amarração do SA7","","",.F. )) 
Local cLojaCli	:= Alltrim(U_MyNewSX6("NC_NCG130L","01"		,"C","Loja do cliente utilizado na amarração do SA7","","",.F. )) 
Local nCnt			:= 0

Default cDocDe	:= "" 
Default cDocAte	:= "" 
Default cSerie	:= "" 
Default dEmisDe	:= CTOD('') 
Default dEmisAte	:= CTOD('') 
Default cCodProd	:= ""

cAliasTmp := GetNextAlias()

cQuery := " SELECT D2_FILIAL, D2_DOC, D2_SERIE, D2_EMISSAO,D2_COD, B1_COD, B1_XDESC, B1_CODBAR, A7_CODCLI, "+CRLF 
cQuery += " D2_QUANT, D2_PRCVEN, D2_TOTAL FROM "+RetSqlName("SD2")+" SD2 "+CRLF

cQuery += " INNER JOIN "+RetSqlName("SB1")+" SB1 "+CRLF
cQuery += " ON SB1.B1_FILIAL = '"+xFilial("SB1")+"' "+CRLF
cQuery += " AND SB1.B1_COD = SD2.D2_COD "+CRLF
cQuery += " AND SB1.D_E_L_E_T_ = ' ' "+CRLF

cQuery += " INNER JOIN "+RetSqlName("SA7")+" SA7 "+CRLF
cQuery += " ON SA7.A7_FILIAL = '"+xFilial("SA7")+"' "+CRLF
cQuery += " AND SA7.A7_CLIENTE = '"+cCodCli+"' "+CRLF
cQuery += " AND SA7.A7_LOJA = '"+cLojaCli+"' "+CRLF
cQuery += " AND SA7.A7_CODCLI = '"+cCodProd+"' "+CRLF
cQuery += " AND SA7.A7_PRODUTO = SD2.D2_COD "+CRLF
cQuery += " AND SA7.D_E_L_E_T_ = ' ' "

cQuery += " WHERE SD2.D2_FILIAL = '"+xFilial("SD2")+"' "+CRLF
cQuery += " AND SD2.D2_DOC BETWEEN '"+cDocDe+"' AND '"+cDocAte+"' "+CRLF
cQuery += " AND SD2.D2_SERIE = '"+cSerie+"' "+CRLF
cQuery += " AND SD2.D2_EMISSAO BETWEEN '"+DTOS(dEmisDe)+"' AND '"+DTOS(dEmisAte)+"' "+CRLF
cQuery += " AND SD2.D_E_L_E_T_ = ' ' "+CRLF

cQuery := ChangeQuery(cQuery)
dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cAliasTmp,.T.,.T.)

(cAliasTmp)->( DbGoTop() )
(cAliasTmp)->( dbEval( { || nCnt++ },,{ || !Eof() } ) )
(cAliasTmp)->( DbGoTop() )

ProcRegua(nCnt)  

aRet := {}

(cAliasTmp)->(DbGoTop())
While (cAliasTmp)->(!Eof())
	
	aAdd(aRet,{(cAliasTmp)->D2_DOC,;				//Nota fiscal de
				(cAliasTmp)->D2_SERIE,;				//Nota discal ate
				STOD((cAliasTmp)->D2_EMISSAO)  ,;	//Emissao
				(cAliasTmp)->D2_COD,;				//Codigo do produto na distribuidora
				(cAliasTmp)->B1_CODBAR,;				//Codigo de barras
				(cAliasTmp)->A7_CODCLI,;				//Codigo do produto na loja
				(cAliasTmp)->D2_QUANT,;				//Quantidade
				(cAliasTmp)->D2_PRCVEN,;				//Valor unitario
				(cAliasTmp)->D2_TOTAL,;				//Total
				(cAliasTmp)->B1_XDESC;				//Descrição do produto
				,.F.})
	
	(cAliasTmp)->(dbSkip())
EndDo

If Len(aRet) == 0
	
	aAdd(aRet,{"",;		//Nota fiscal de
				"",;		//Nota discal ate
				CTOD(''),;	//Emissao
				"",;		//Codigo do produto na distribuidora
				"",;		//Codigo de barras
				"",;		//Codigo do produto na loja
				0,;			//Quantidade
				0,;			//Valor unitario
				0,;			//Total
				"";		//Descrição do produto
				,.F.})

				
EndIf


(cAliasTmp)->(DbCloseArea())
RestArea( aArea )
Return aRet



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CriaAcUzPg ºAutor  ³Microsiga         º Data ³  26/01/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Cria acols quando estiver posiciona na empresa UZ e PG      º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function CriaAcUzPg( cDocDe, cDocAte, cSerie, dEmisDe, dEmisAte, cCodProd )
Local aArea    	:= GetArea()
Local aStruct	 	:= {}
Local nX				:= 0
Local aRet			:= {}
Local cAliasTmp	:= ""
Local cQuery		:= ""
Local cCodCli		:= Alltrim(U_MyNewSX6("NC_NCG130C","000000"	,"C","Cliente utilizado na amarração do SA7","","",.F. )) 
Local cLojaCli	:= Alltrim(U_MyNewSX6("NC_NCG130L","01"		,"C","Loja do cliente utilizado na amarração do SA7","","",.F. ))
Local nCnt			:= 0

Default cDocDe	:= "" 
Default cDocAte	:= "ZZZZZZZZZ" 
Default cSerie	:= "3" 
Default dEmisDe	:= CTOD('') 
Default dEmisAte	:= CTOD('') 
Default cCodProd	:= ""

cAliasTmp := GetNextAlias()

cQuery := " SELECT D1_FILIAL, D1_DOC, D1_SERIE, D1_DTDIGIT,D1_COD, B1_COD, B1_XDESC, B1_CODBAR, A7_CODCLI, "+CRLF 
cQuery += " D1_QUANT, D1_VUNIT, D1_TOTAL, A7_PRODUTO FROM "+RetSqlName("SD1")+" SD1 "+CRLF

cQuery += " INNER JOIN "+RetSqlName("SB1")+" SB1 "+CRLF
cQuery += " ON SB1.B1_FILIAL = '"+xFilial("SB1")+"' "+CRLF
cQuery += " AND SB1.B1_COD = SD1.D1_COD "+CRLF
cQuery += " AND SB1.D_E_L_E_T_ = ' ' "+CRLF

cQuery += " INNER JOIN "+RetSqlName("SA7")+" SA7 "+CRLF
cQuery += " ON SA7.A7_FILIAL = '"+xFilial("SA7")+"' "+CRLF
cQuery += " AND SA7.A7_CLIENTE = '"+cCodCli+"' "+CRLF
cQuery += " AND SA7.A7_LOJA = '"+cLojaCli+"' "+CRLF
cQuery += " AND SA7.A7_CODCLI = '"+cCodProd+"' "+CRLF
cQuery += " AND SA7.D_E_L_E_T_ = ' ' "+CRLF

cQuery += " WHERE SD1.D1_FILIAL = '"+xFilial("SD1")+"' "+CRLF
cQuery += " AND SD1.D1_DOC BETWEEN '"+cDocDe+"' AND '"+cDocAte+"' "+CRLF
cQuery += " AND SD1.D1_SERIE = '"+cSerie+"' "+CRLF
cQuery += " AND SD1.D1_COD = '"+cCodProd+"' "+CRLF
cQuery += " AND SD1.D1_EMISSAO BETWEEN '"+DTOS(dEmisDe)+"' AND '"+DTOS(dEmisAte)+"' "+CRLF

cQuery += " AND SD1.D_E_L_E_T_ = ' ' "+CRLF

//cQuery := ChangeQuery(cQuery)
dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cAliasTmp,.T.,.T.)

(cAliasTmp)->( DbGoTop() )
(cAliasTmp)->( dbEval( { || nCnt++ },,{ || !Eof() } ) )
(cAliasTmp)->( DbGoTop() )

ProcRegua(nCnt)  

aRet := {}

(cAliasTmp)->(DbGoTop())
While (cAliasTmp)->(!Eof())
	
	aAdd(aRet,{(cAliasTmp)->D1_DOC,;				//Nota fiscal de
				(cAliasTmp)->D1_SERIE,;				//Nota discal ate
				STOD((cAliasTmp)->D1_DTDIGIT)  ,;	//Emissao
				(cAliasTmp)->A7_PRODUTO,;			//Codigo do produto na distribuidora
				(cAliasTmp)->B1_CODBAR,;				//Codigo de barras
				(cAliasTmp)->A7_CODCLI,;				//Codigo do produto na loja
				(cAliasTmp)->D1_QUANT,;				//Quantidade
				(cAliasTmp)->D1_VUNIT,;				//Valor unitario
				(cAliasTmp)->D1_TOTAL,;				//Total
				(cAliasTmp)->B1_XDESC;				//Descrição do produto
				,.F.})
	
	(cAliasTmp)->(dbSkip())
EndDo

If Len(aRet) == 0
	
	aAdd(aRet,{"",;		//Nota fiscal de
				"",;		//Nota discal ate
				CTOD(''),;	//Emissao
				"",;		//Codigo do produto na distribuidora
				"",;		//Codigo de barras
				"",;		//Codigo do produto na loja
				0,;			//Quantidade
				0,;			//Valor unitario
				0,;			//Total
				"";		//Descrição do produto
				,.F.})

				
EndIf


(cAliasTmp)->(DbCloseArea())
RestArea( aArea )
Return aRet




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCTCONC6 ºAutor  ³Microsiga    		    º Data ³  26/01/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Consulta produto com mais de 1 codigo correspondente        º±±
±±º          ³na distribuidora                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function NCTCONC6(cProd)

Local aArea 		:= GetArea()
Local cCnpjVld	:= Alltrim(U_MyNewSX6("NC_CNPJDIS","01455929000330"	,"C","CNPJ da distribuidora utilizado no de/para de produto","","",.F. ))
Local cCodForn	:= M->C5_CLIENTE
Local cLoja		:= M->C5_LOJACLI 
Local cTipo		:= M->C5_TIPO


Default cProd	:= "" 

If !Empty(cProd) .And. (Upper(Alltrim(cTipo)) == "D") .And. (Alltrim(cEmpAnt) $ "03|40")
	
	DbSelectArea("SA2")
	DbSetOrder(1)
	If SA2->(MsSeek(xFilial("SA2") + cCodForn + cLoja))
		If (Alltrim(SA2->A2_CGC) $ Alltrim(cCnpjVld) ) .And. !VldPrdDist(cProd)  
			
			If Aviso("Atenção", "Existe mais de um código correspondente para este produto ("+Alltrim(cProd)+"). "+;
						"Deseja visualizar as notas fiscais já emitidas para o mesmo ?",{"Sim","Não"})==1
				u_NCCPRDLJ(cProd)
			EndIf
			
				
		EndIf
	EndIf
EndIf

RestArea(aArea)
Return .T.


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³VldPrdDist ºAutor  ³Microsiga  		    º Data ³  26/01/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Verifica se o produto tem mais de um codigo correspondente  º±±
±±º          ³na distribuidora	                                           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function VldPrdDist(cCodProd)

Local aArea 		:= GetArea()
Local lRet			:= .T.
Local cQuery		:= ""
Local cArqTmp		:= GetNextAlias()
Local cCodCli		:= Alltrim(U_MyNewSX6("NC_NCG130C","000000"	,"C","Cliente utilizado na amarração do SA7","","",.F. )) 
Local cLojaCli	:= Alltrim(U_MyNewSX6("NC_NCG130L","01"		,"C","Loja do cliente utilizado na amarração do SA7","","",.F. ))
	
Default cCodProd := ""	


cQuery	:= " SELECT * FROM ( "+CRLF
cQuery	+= " SELECT A7_CODCLI, COUNT(A7_PRODUTO) CONTADOR FROM "+RetSqlName("SA7")+CRLF
cQuery	+= " WHERE A7_FILIAL = '  ' "+CRLF
cQuery	+= " AND A7_CLIENTE = '"+cCodCli+"' "+CRLF
cQuery	+= " AND A7_LOJA = '"+cLojaCli+"' "+CRLF
cQuery	+= " AND A7_CODCLI = '"+cCodProd+"' "+CRLF
cQuery	+= " AND D_E_L_E_T_ = ' ' "+CRLF

cQuery	+= " GROUP BY A7_CODCLI "+CRLF
cQuery	+= " ) DADOS "+CRLF
cQuery	+= " WHERE CONTADOR > 1 "+CRLF



cQuery := ChangeQuery(cQuery)
dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cArqTmp,.T.,.T.)

If (cArqTmp)->(!Eof())
	lRet := !((cArqTmp)->CONTADOR > 0)	
EndIf

(cArqTmp)->(DbCloseArea())
RestArea(aArea)
Return lRet
