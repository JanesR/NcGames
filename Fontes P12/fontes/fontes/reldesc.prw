#INCLUDE "rwmake.ch"

/*/
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠иммммммммммяммммммммммкмммммммяммммммммммммммммммммкммммммяммммммммммммм╩╠╠
╠╠╨Programa  ЁRELDESC   ╨ Autor Ё THIAGO QUEIROZ     ╨ Data Ё  15/09/10   ╨╠╠
╠╠лммммммммммьммммммммммймммммммоммммммммммммммммммммйммммммоммммммммммммм╧╠╠
╠╠╨Descricao Ё RELATORIO PARA IMPRESSCAO DE DESCONTO ANALITICO/SINTETICO  ╨╠╠
╠╠╨          Ё                                                            ╨╠╠
╠╠лммммммммммьмммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╧╠╠
╠╠╨Uso       Ё AP6 IDE                                                    ╨╠╠
╠╠хммммммммммомммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╪╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/

User Function reldesc()

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Declaracao de Variaveis                                             Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды

Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := "de acordo com os parametros informados pelo usuario."
Local cDesc3         := "RelDesc"+RIGHT(TIME(),2)
Local cPict          := ""
Local titulo         := "RelDesc"+RIGHT(time(),2)
Local nLin           := 80
Local Cabec1         := "PRODUTO            DESCRICAO                                            QUANTIDADE        PREгO S/ IPI            PREгO TABELA           COD. TABELA                 % DESCONTO            USUARIO LIB."
Local Cabec1B        := "PRODUTO            DESCRICAO                                               TOTAL NF       PREгO S/ IPI            PREгO TABELA           % DESCONTO            USUARIO LIB."
Local Cabec2         := ""
Local imprime        := .T.
Local aOrd           := {}
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite       := 220
Private tamanho      := "G"
Private nomeprog     := "RELDESC"+RIGHT(time(),2) // Coloque aqui o nome do programa para impressao no cabecalho
Private nTipo        := 18
Private aReturn      := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey     := 0
Private cPerg        := "RDESCF"
Private cbtxt        := Space(10)
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01
Private wnrel        := "RELDESC"+RIGHT(time(),2) // Coloque aqui o nome do arquivo usado para impressao em disco

/*
зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
ЁPERGUNTAS RELATORIO     RDESCF                                       |                                                                                                                                        Ё
|                                                                     |
| MV_PAR01 -> DA NOTA ?                                               |
| MV_PAR02 -> ATE NOTA ?                                              |
| MV_PAR03 -> DA SERIE ?                                              |
| MV_PAR04 -> ATE SERIE ?                                             |
| MV_PAR05 -> DA CLIENTE ?                                            |
| MV_PAR06 -> ATE CLIENTE ?                                           |
| MV_PAR07 -> DA LOJA ?                                               |
| MV_PAR08 -> ATE LOJA ?                                              |
| MV_PAR09 -> TIPO RELATORIO ?                                        |
| MV_PAR10 -> DO PRODUTO ?                                            |
| MV_PAR11 -> ATE PRODUTO ?                                           |
| MV_PAR12 -> DE DATA ?                                               |
| MV_PAR13 -> ATE DATA ?                                              |
| MV_PAR14 -> SINTETICO POR PERIODO OU PRODUTO ?                      |
| MV_PAR15 -> ORDENA POR GRUPO ?                                      |
|                                                                     |
юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
*/

Private cString := "SF2"

dbSelectArea("SF2")
dbSetOrder(1)

pergunte(cPerg,.F.)


// ALTERA O TITULO DO RELATORIO DE ACORDO COM A TIPO ESCOLHIDO
IF MV_PAR09 == 1									// ANALITICO
	titulo     := "Relatorio Analitico de desconto"
ELSEIF MV_PAR09 == 2 .AND. MV_PAR14 == 1	// SINTETICO CLI X PERIODO
	titulo     := "Relatorio Sintetico - Cliente por Periodo"
ELSEIF MV_PAR09 == 2 .AND. MV_PAR14 == 2	// SINTETICO CLI X PRODUTO
	titulo     := "Relatorio Sintetico - Cliente por Produto"
ENDIF


//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Monta a interface padrao com o usuario...                           Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды

wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.T.,aOrd,.T.,Tamanho,,.T.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

nTipo := If(aReturn[4]==1,15,18)

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Processamento. RPTSTATUS monta janela com a regua de processamento. Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды

RptStatus({|| RunReport(Cabec1,Cabec1B,Cabec2,Titulo,nLin) },Titulo)
Return

/*/
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠иммммммммммяммммммммммкмммммммяммммммммммммммммммммкммммммяммммммммммммм╩╠╠
╠╠╨Fun┤└o    ЁRUNREPORT ╨ Autor Ё AP6 IDE            ╨ Data Ё  15/09/10   ╨╠╠
╠╠лммммммммммьммммммммммймммммммоммммммммммммммммммммйммммммоммммммммммммм╧╠╠
╠╠╨Descri┤└o Ё Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS ╨╠╠
╠╠╨          Ё monta a janela com a regua de processamento.               ╨╠╠
╠╠лммммммммммьмммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╧╠╠
╠╠╨Uso       Ё Programa principal                                         ╨╠╠
╠╠хммммммммммомммммммммммммммммммммммммммммммммммммммммммммммммммммммммммм╪╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/

Static Function RunReport(Cabec1,Cabec1B,Cabec2,Titulo,nLin)

Local nOrdem

dbSelectArea(cString)
dbSetOrder(1)

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё SETREGUA -> Indica quantos registros serao processados para a regua Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
SetRegua(RecCount())

//IF MSGYESNO("Exporta para Excel ?")
//IF MSGNOYES("Exporta para Excel ?")

//DBSKIP()

//ELSE

aDbStru := {}

AADD(aDbStru,{"CLIENTE"  ,"C",015,0})
AADD(aDbStru,{"LOJA"     ,"C",005,0})
AADD(aDbStru,{"NOMEC"    ,"C",060,0})
AADD(aDbStru,{"UF"       ,"C",005,2})
AADD(aDbStru,{"DOC"      ,"C",010,0})
AADD(aDbStru,{"SERIE"    ,"C",010,0})
AADD(aDbStru,{"DTEMISSAO","C",014,0})
AADD(aDbStru,{"TIPONF"   ,"C",014,0})
AADD(aDbStru,{"CFOP"     ,"C",014,0})
AADD(aDbStru,{"VENDEDOR" ,"C",015,0})
AADD(aDbStru,{"NOMEV"    ,"C",080,0})
AADD(aDbStru,{"GRUPO"    ,"C",014,0})
AADD(aDbStru,{"DESC"     ,"C",014,0})
AADD(aDbStru,{"COND"     ,"C",014,0})
AADD(aDbStru,{"DESCRIC"  ,"C",040,0})
AADD(aDbStru,{"PRODUTO"  ,"C",015,0})
AADD(aDbStru,{"DESCRIP"  ,"C",100,0})
AADD(aDbStru,{"QTD"      ,"N",014,2})
AADD(aDbStru,{"VALVEND"  ,"N",014,2})
AADD(aDbStru,{"VALTAB"   ,"N",014,2})
AADD(aDbStru,{"CODTAB"   ,"C",003,0}) //AADD(aDbStru,{"VALEST"   ,"N",014,2})
AADD(aDbStru,{"PORCDESC" ,"N",014,2})
AADD(aDbStru,{"REGRADESC","C",006,0})
AADD(aDbStru,{"PREGRADESC","N",014,2})
AADD(aDbStru,{"USUARIO"  ,"C",014,0})
AADD(aDbStru,{"VALFAT"	 ,"N",014,2})
AADD(aDbStru,{"STATUSCML","C",020,0})

//CRIA ARQ TEMPORARIO COMO DBF PARA O EXCEL PODER ABRIR
CNOMEDBF := "RELDESC2"+RIGHT(TIME(),2)
DBCREATE(CNOMEDBF,aDbStru,"DBFCDXADS")
DbUseArea(.T.,"DBFCDXADS","SYSTEM\" + CNOMEDBF,"XLS",.T.,.F.)

If Select("TRB") > 0
	dbSelectArea("TRB")
	dbCloseArea()
Endif

_cQry:="	SELECT 	F2_DOC, F2_SERIE, F2_COND, 	F2_EMISSAO, F2_VEND1,  "
_cQry+="		D2_DOC, D2_COD, D2_TOTAL, D2_QUANT, D2_PRCVEN, D2_VALIPI, D2_PICM, D2_EST, D2_TIPO, D2_CF,
_cQry+="		F4_VENDA, D2_VALFRE, D2_SEGURO, D2_ICMSRET,
_cQry+="		B1_DESC, B1_XDESC, B1_STACML,
_cQry+="		A1_COD, A1_LOJA, A1_NOME, A1_NREDUZ,
_cQry+="		ACA_DESCRI,
_cQry+="		A3_NOME, F2_YCANAL,
_cQry+="		C6_PRCVEN, C6_PRCTAB, C6_X_USRLB,
_cQry+="		C5_FATURPV, C5_TABELA,
_cQry+="		E4_DESCRI, C6_REGDESC, C6_PREGDES
_cQry+="	FROM   	SF2010 F2, 
_cQry+="		SD2010 D2,
_cQry+="		SF4010 F4, 
_cQry+="		SB1010 B1, 
_cQry+="		SA1010 A1, 
_cQry+="		SA3010 A3, 
_cQry+="		ACA010 ACA,
_cQry+="		SC6010 C6,
_cQry+="		SC5010 C5,
_cQry+="		SE4010 E4
_cQry+=" WHERE	F2_DOC >= '"     	+ALLTRIM(MV_PAR01)+ "' "
_cQry+=" AND 	F2_DOC <= '"     	+ALLTRIM(MV_PAR02)+ "' "
_cQry+=" AND  	F2_SERIE >= '" 	+ALLTRIM(MV_PAR03)+ "' "
_cQry+=" AND 	F2_SERIE <= '" 	+ALLTRIM(MV_PAR04)+ "' "
_cQry+=" AND  	F2_CLIENTE >= '" 	+ALLTRIM(MV_PAR05)+ "' "
_cQry+=" AND 	F2_CLIENTE <= '" 	+ALLTRIM(MV_PAR06)+ "' "
_cQry+=" AND  	F2_LOJA >= '" 		+ALLTRIM(MV_PAR07)+ "' "
_cQry+=" AND 	F2_LOJA <= '" 		+ALLTRIM(MV_PAR08)+ "' "
_cQry+=" AND  	D2_COD >= '" 		+ALLTRIM(MV_PAR10)+ "' "
_cQry+=" AND 	D2_COD <= '" 		+ALLTRIM(MV_PAR11)+ "' "
_cQry+=" AND  	F2_EMISSAO >= '" 	+DTOS(MV_PAR12)+ "' "
_cQry+=" AND 	F2_EMISSAO <= '" 	+DTOS(MV_PAR13)+ "' "
_cQry+="	AND  	F2_FILIAL 	= D2_FILIAL  
_cQry+="	AND  	F2_DOC 		= D2_DOC  
_cQry+="	AND  	F2_SERIE 	= D2_SERIE  
_cQry+="	AND  	D2_TES 		= F4_CODIGO  
_cQry+="	AND		F4_DUPLIC 	= 'S'  
_cQry+="	AND  	D2_COD 		= B1_COD  
_cQry+="	AND  	F2_CLIENTE 	= A1_COD  
_cQry+="	AND  	F2_LOJA 	= A1_LOJA  
_cQry+="	AND  	F2_VEND1 	= A3_COD  
_cQry+="	AND		F2_YCANAL 	= ACA_GRPREP 
_cQry+="	AND  	F2_FILIAL 	= C6_FILIAL  
_cQry+="	AND  	D2_PEDIDO	= C6_NUM
_cQry+="	AND  	D2_ITEMPV	= C6_ITEM
_cQry+="	AND  	C6_FILIAL 	= C5_FILIAL  
_cQry+="	AND  	C6_NUM 		= C5_NUM  
_cQry+="	AND		E4_CODIGO 	= F2_COND  
_cQry+="	AND  	F2.D_E_L_E_T_ 	!= '*'   
_cQry+="	AND  	D2.D_E_L_E_T_ 	!= '*'   
_cQry+="	AND  	F4.D_E_L_E_T_ 	!= '*'   
_cQry+="	AND  	B1.D_E_L_E_T_ 	!= '*'   
_cQry+="	AND  	A1.D_E_L_E_T_ 	!= '*'   
_cQry+="	AND  	A3.D_E_L_E_T_ 	!= '*'   
_cQry+="	AND  	ACA.D_E_L_E_T_ 	!= '*'   
_cQry+="	AND  	C6.D_E_L_E_T_ 	!= '*'   
_cQry+="	AND  	C5.D_E_L_E_T_ 	!= '*'   
_cQry+="	AND  	E4.D_E_L_E_T_ 	!= '*'   
_cQry+=" GROUP BY 	F2_DOC, F2_SERIE, D2_DOC, D2_COD, B1_DESC, B1_XDESC, B1_STACML, D2_TOTAL, D2_QUANT, D2_PRCVEN, D2_VALIPI, D2_PICM, D2_VALFRE, D2_SEGURO, D2_ICMSRET,"
_cQry+=" 				A1_COD, A1_LOJA, A1_NOME, A1_NREDUZ, D2_EST, F2_EMISSAO, D2_TIPO, D2_CF, F2_VEND1, ACA_DESCRI, "
_cQry+=" 				A3_NOME, F2_YCANAL , F2_COND, C6_PRCVEN, C6_PRCTAB, E4_DESCRI, C6_X_USRLB, F4_VENDA, C5_FATURPV, C5_TABELA, D2_ITEM, C6_REGDESC, C6_PREGDES"
IF MV_PAR09 == 2 .AND. MV_PAR14 == 1
	_cQry+=" ORDER BY 	A1_COD, A1_LOJA, F2_EMISSAO, F2_YCANAL, A1_NOME, F2_DOC, F2_SERIE "
ELSEIF MV_PAR09 == 1 .AND. MV_PAR15 == 2
	_cQry+=" ORDER BY 	F2_DOC, F2_SERIE, F2_EMISSAO, A1_COD, A1_LOJA, A1_NOME, F2_YCANAL, D2_COD "
ELSEIF MV_PAR09 == 1 .AND. MV_PAR15 == 1
	_cQry+=" ORDER BY 	F2_YCANAL, F2_DOC, F2_SERIE, F2_EMISSAO, A1_COD, A1_LOJA, A1_NOME, D2_COD "
ELSE
	_cQry+=" ORDER BY 	F2_EMISSAO, A1_COD, A1_LOJA, A1_NOME, F2_YCANAL, D2_COD, F2_DOC, F2_SERIE "
ENDIF

memowrit("RELDESC.sql",_cQry)
_cQry := ChangeQuery(_cQry)
dbUseArea( .T., "TOPCONN", TCGENQRY(,,_cQry),"TRB", .F., .T.)
dbGoTop()

DBSELECTAREA("TRB")
DBGOTOP()

//	While !TRB->(EOF())

// TOTALIZADORES

//GERAL
Public nTotGeral 	:= 0	// TOTAL GERAL DE TODAS AS NF
Public nTotGeralv	:= 0	// TOTAL GERAL DE VENDAS
Public nTotGeralt	:= 0  // TOTAL GERAL DE TABELA
Public nTotGerale := 0  // TOTAL GERAL DE ESTADO
Public nPorcTot	:= 0  // % DESCONTO MEDIO DOS TOTAIS
// UNITARIO
Public nValTab  	:= 0  // VALOR TABELA
Public nValVend 	:= 0  // VALOR VENDA
Public nValEst		:= 0  // VALOR ESTADO
Public nPorcDesc	:= 0  // % DESCONTO
// TOTAL NOTA FISCAL
Public nTotNf 		:= 0	// TOTAL NF
Public nTotValv	:= 0	// TOTAL PREгO DE VENDAS
Public nTotValt	:= 0	// TOTAL PREгO DE TABELA
Public nTotVale	:= 0	// TOTAL PREгO ESTADO
// TOTAL DIA
Public nTotDiaNF	:= 0 	// TOTAL NF/DIA
Public nTotDiav	:= 0	// TOTAL VENDA
Public nTotDiat	:= 0  // TOTAL TABELA
Public nTotDiae	:= 0  // TOTAL ESTADO
// TOTAL CLIENTE
Public nTotCliNF	:= 0	// TOTAL NF/CLIENTE
Public nTotCliv	:= 0	// TOTAL VENDA
Public nTotClit	:= 0  // TOTAL TABELA
Public nTotClie	:= 0  // TOTAL ESTADO
// NOTA FISCAL
Public cSerie		:= TRB->F2_SERIE
Public cData		:= TRB->F2_EMISSAO
Public cDoc 		:= TRB->D2_DOC
Public cCod 		:= TRB->D2_COD
// CONDIгцO DE PAGAMENTO
Public cCondc		:= TRB->F2_COND
Public cCond		:= TRB->E4_DESCRI
// CLIENTE
Public cCli			:= TRB->A1_COD
Public cLoja		:= TRB->A1_LOJA
Public cCliNR		:= TRB->A1_NREDUZ
Public nLoop		:= 1 // NцO ESTа SENDO UTILIZADO
Public nQuebra		:= 1 // VARIAVEL QUE VERIFICA SE O CABEгALHO JA FOI IMPRESSO
Public nLin

While !EOF()
		
	XLS->(RECLOCK("XLS",.T.))
	
	// CAMPOS SQL X EXCEL
	XLS->CLIENTE      :=            TRB->A1_COD
	XLS->LOJA      	:=            TRB->A1_LOJA
	XLS->NOMEC       	:=            TRB->A1_NREDUZ
	XLS->UF     		:=            TRB->D2_EST
	XLS->DOC      		:=            TRB->F2_DOC
	XLS->SERIE     	:=            TRB->F2_SERIE
	XLS->DTEMISSAO   	:=            DTOC(STOD(TRB->F2_EMISSAO))
	XLS->TIPONF     	:=            TRB->D2_TIPO
	XLS->CFOP		   :=            TRB->D2_CF
	XLS->VENDEDOR     :=            TRB->F2_VEND1
	XLS->NOMEV      	:=            TRB->A3_NOME
	XLS->GRUPO   		:=            TRB->F2_YCANAL
	XLS->DESC   		:=            TRB->ACA_DESCRI
	XLS->COND    	 	:=            TRB->F2_COND
	XLS->DESCRIC      :=            TRB->E4_DESCRI
	XLS->PRODUTO     	:=            TRB->D2_COD
	XLS->DESCRIP      :=            TRB->B1_XDESC
	XLS->QTD      		:=            TRB->D2_QUANT
	//		CAMPOS SERцO ADICIONADOS NO MOMENTO QUE SцO CALCULADOS
	//		XLS->VALVEND      :=            nValVend
	//		XLS->VALTAB   		:=            nValTab
	//		XLS->VALEST   		:=            nValEst
	//		XLS->PORCDESC  	:=            nPorcDesc
	XLS->USUARIO   	:=            TRB->C6_X_USRLB
	XLS->CODTAB	   	:=            TRB->C5_TABELA
	XLS->VALFAT	   	:=            TRB->(D2_VALFRE + D2_SEGURO + D2_ICMSRET + D2_VALIPI + D2_TOTAL)
	XLS->REGRADESC	:=  TRB->C6_REGDESC
	XLS->PREGRADESC	:= 	TRB->C6_PREGDES
	XLS->STATUSCML	:= 	noacento(GETADVFVAL("SX5","X5_DESCRI",XFILIAL("SX5")+"ZX"+TRB->B1_STACML,1,""))


	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Verifica o cancelamento pelo usuario...                             Ё
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	
	If lAbortPrint
		@nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
		Exit
	Endif
	
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Impressao do cabecalho do relatorio. . .                            Ё
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	
	// Salto de Pagina. Neste caso o formulario tem 55 linhas...
	If nLin > 55 //.OR. nLina > 55 .OR. nLins > 55 // .OR. nLint > 55// .OR. nLinc > 55
		IF MV_PAR09 == 2 .AND. MV_PAR14 == 1
			Cabec(Titulo,Cabec1B,Cabec2,NomeProg,Tamanho,nTipo)
		ELSE
			Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		ENDIF
		nLin  := 8
	Endif
	
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//|         CALCULOS                                                    |
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	
	// CALCULO VALOR VENDA
	nValVend	:= TRB->D2_PRCVEN //TRB->D2_PRCVEN+(TRB->D2_VALIPI/TRB->D2_QUANT)
	
	// CALCULO VALOR TABELA
	nValTab		:= TRB->C6_PRCTAB //TRB->C6_PRCTAB*3.2
	cCodTab		:= TRB->C5_TABELA
	
	// CALCULO VALOR ESTADO
/*	IF TRB->D2_PICM == 7
		nValEst := nValTab - ((nValTab/100)*11.83)
	ELSEIF TRB->D2_PICM == 12
		nValEst := nValTab - ((nValTab/100)*6.82)
	ELSEIF TRB->D2_PICM == 0
		nValEst := nValTab*0.83
	ELSE
		nValEst := nValTab
	ENDIF*/
	nValEst := nValTab
	// CALCULO PORCENTAGEM DE DESCONTO
	//	nPorcDesc := (((TRB->D2_PRCVEN+(TRB->D2_VALIPI/TRB->D2_QUANT))/nValEst)*100) - 100
	nPorcDesc := (((nValVend)/nValEst)*100) - 100
	
	// CAMPOS VALORES CALCULADOS PROGRAMA X EXCEL
	XLS->VALVEND      :=            nValVend * XLS->QTD
	XLS->VALTAB   		:=            nValTab * XLS->QTD
//	XLS->VALEST   		:=            nValEst * XLS->QTD
	XLS->PORCDESC  	:=            nPorcDesc
	
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//|   IMPRIME TOTAL POR NOTA E ZERA OS TOTAIS CASO A NF SEJA DIFERENTE  |
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	
	IF	cDoc != TRB->D2_DOC //.AND. nQuebra == 1
		
		//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//|   IMPRIME O TOTAL/NOTA			                                    |
		//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		
		IF MV_PAR09 == 1 				// ANALITICO
			// imprime totais
			nLin++
			//			nLin++
			@nLin,000 PSAY "NOTA FISCAL"
			@nLin,012 PSAY cDoc + " - " + cSerie
			@nLin,025 PSAY "TOTAL NF"
			@nLin,035 PSAY Transform(nTotNF,"@E  999,999,999.99")
			@nLin,065 PSAY "TOTAIS --->"
			@nLin,087 PSAY Transform(nTotValv,"@E  999,999,999.99") 		// PRECO VENDA
			@nLin,108 PSAY Transform(nTotValt,"@E  999,999,999.99") 		// PRECO TABELA
//			@nLin,133 PSAY Transform(nTotVale,"@E  999,999,999.99") 		// PRECO ESTADO
			@nLin,157 PSAY Transform(((nTotValv/nTotValt)*100) - 100, "@E  999,999,999.99") //@nLin,157 PSAY Transform(((nTotValv/nTotVale)*100) - 100, "@E  999,999,999.99")
			nLin++
			@nLin,00 PSAY "COND PAGTO"
			@nLin,12 PSAY cCondc
			@nLin,32 PSAY cCond
			nLin++
			@nLin,00 PSAY REPLICATE("-", 220)
			
		ELSEIF MV_PAR09 == 2 			// SINTETICO
			
		ENDIF
		
		//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//|   IMPRIME O TOTAL/DIA			                                    |
		//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		
		IF MV_PAR09 == 2 //.AND. MV_PAR14 == 2
			
		ELSE
			IF cData != TRB->F2_EMISSAO
				
				nLin++
				@nLin,000 PSAY "TOTAL DO DIA"
				@nLin,014 PSAY DTOC(STOD(cData))
				@nLin,025 PSAY "TOTAL NFs"
				@nLin,035 PSAY Transform(nTotDiaNF,"@E  999,999,999.99")
				@nLin,065 PSAY "TOTAIS --->"
				@nLin,087 PSAY Transform(nTotDiav,"@E  999,999,999.99") 		// PRECO VENDA
				@nLin,108 PSAY Transform(nTotDiat,"@E  999,999,999.99") 		// PRECO TABELA
//				@nLin,133 PSAY Transform(nTotDiae,"@E  999,999,999.99") 		// PRECO ESTADO
				if MV_PAR14 == 2
					@nLin,158 PSAY Transform(((nTotDiav/nTotDiat)*100) - 100, "@E  999,999,999.99")
				else
					@nLin,133 PSAY Transform(((nTotDiav/nTotDiat)*100) - 100, "@E  999,999,999.99")
				endif
				nLin++
				@nLin,00 PSAY REPLICATE("-", 220)
				nLin++
				
			ENDIF
		ENDIF
		
		//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
		//|   IMPRIME O TOTAL/CLIENTE                                           |
		//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
		IF MV_PAR09 == 2 .AND. MV_PAR14 == 1
			IF cCli != TRB->A1_COD .OR. cLoja != TRB->A1_LOJA //.AND. cDoc != TRB->F2_DOC //.AND. MV_PAR09 == 2
				
				//				nLin++
				//				@nLin,000 PSAY "DT EMISSAO:"
				//				@nLin,015 PSAY DTOC(STOD(TRB->F2_EMISSAO))
				nLin++
				@nLin,000 PSAY "Cliente"
				@nLin,010 PSAY cCli
				@nLin,017 PSAY cLoja
				@nLin,023 PSAY SUBSTR(cCliNR ,1,25) //cCliNR
				@nLin,064 PSAY "TOTAL NFs"
				@nLin,071 PSAY Transform(nTotCliNF,"@E  999,999,999.99")
				//			@nLin,065 PSAY "TOTAIS --->"
				@nLin,088 PSAY Transform(nTotCliv,"@E  999,999,999.99") 		// PRECO VENDA
				@nLin,109 PSAY Transform(nTotClit,"@E  999,999,999.99") 		// PRECO TABELA
//				@nLin,134 PSAY Transform(nTotClie,"@E  999,999,999.99") 		// PRECO ESTADO
				IF MV_PAR09 == 2 .AND. MV_PAR14 == 2
					@nLin,158 PSAY Transform(((nTotCliv/nTotClit)*100) - 100, "@E  999,999,999.99")
				ELSE
					@nLin,134 PSAY Transform(((nTotCliv/nTotClit)*100) - 100, "@E  999,999,999.99")
				ENDIF
				nLin++
				@nLin,00 PSAY REPLICATE("-", 220)
				//				nLin++
				
			ENDIF
		ELSEIF MV_PAR09 == 2 .AND. MV_PAR14 == 2
			
			IF cCli != TRB->A1_COD .OR. cLoja != TRB->A1_LOJA //.AND. cDoc != TRB->F2_DOC //.AND. MV_PAR09 == 2
				
				//				nLin++
				//				@nLin,000 PSAY "DT EMISSAO:"
				//				@nLin,015 PSAY DTOC(STOD(TRB->F2_EMISSAO))
				nLin++
				//				@nLin,000 PSAY "Cliente"
				//				@nLin,010 PSAY cCli
				//				@nLin,017 PSAY cLoja
				//				@nLin,023 PSAY cCliNR
				@nLin,064 PSAY "TOTAL NFs"
				@nLin,071 PSAY Transform(nTotCliNF,"@E  999,999,999.99")
				//			@nLin,065 PSAY "TOTAIS --->"
				@nLin,088 PSAY Transform(nTotCliv,"@E  999,999,999.99") 		// PRECO VENDA
				@nLin,109 PSAY Transform(nTotClit,"@E  999,999,999.99") 		// PRECO TABELA
//				@nLin,134 PSAY Transform(nTotClie,"@E  999,999,999.99") 		// PRECO ESTADO
				IF MV_PAR09 == 2 .AND. MV_PAR14 == 2
					@nLin,158 PSAY Transform(((nTotCliv/nTotClit)*100) - 100, "@E  999,999,999.99")
				ELSE
					@nLin,134 PSAY Transform(((nTotCliv/nTotClit)*100) - 100, "@E  999,999,999.99")
				ENDIF
				nLin++
				@nLin,00 PSAY REPLICATE("-", 220)
				//				nLin++
				
			ENDIF
			
		ENDIF
		
		//--------------\\
		// ZERA TOTAIS  \\
		//--------------\\
		IF MV_PAR09 == 2 .AND. MV_PAR14 == 2 // SINTETICO
			IF cCli != TRB->A1_COD .OR. cLoja != TRB->A1_LOJA// .OR. cDoc != TRB->F2_DOC
				nQuebra 		:= 1
			ELSE
				nQuebra 		:= nQuebra
			ENDIF
		ELSE
			IF cCli != TRB->A1_COD .OR. cLoja != TRB->A1_LOJA .OR. cDoc != TRB->F2_DOC
				nQuebra 		:= 1
			ELSE
				nQuebra 		:= nQuebra
			ENDIF
		ENDIF
		
		//		IF cCod != TRB-> D2_COD
		//			nValVend  	:= 0
		//			nValTab		:= 0
		//			nValEst   	:= 0
		//			nPorcDesc 	:= 0
		//		ENDIF
		
		nLoop			:= 1
		NTOTNF 		:= 0
		nTotValv		:= 0
		nTotValt		:= 0
		nTotVale		:= 0
		//		nPorcDesc	:= 0
		
		
		//------------------\\
		// ZERA TOTAIS/DIA  \\
		//------------------\\
		IF cData != TRB->F2_EMISSAO
			nTotDiaNF	:= 0	// total das NFs/Dia
			nTotDiav		:= 0	// valor venda
			nTotDiat		:= 0	// valor tabela
			nTotDiae		:= 0	// valor estado
			cData			:= TRB->F2_EMISSAO
		ENDIF
		
		//---------------------\\
		// ZERA TOTAIS/CLIENTE \\
		//---------------------\\
		IF cCli != TRB->A1_COD .OR. cLoja != TRB->A1_LOJA
			nTotCliNF	:= 0  // total das NFs/Cliente
			nTotCliv		:= 0	// valor venda
			nTotClit		:= 0	// valor tabela
			nTotClie		:= 0	// valor estado
			cCli			:= TRB->A1_COD
			cLoja			:= TRB->A1_LOJA
		ENDIF
		
		//---------------------\\
		// ATUALIZA PONTEIRO   \\
		//---------------------\\
		cDoc 		:= TRB->D2_DOC
		cCli 		:= TRB->A1_COD
		cCliNR	:= TRB->A1_NREDUZ
		cCod		:= TRB->D2_COD
		cSerie 	:= TRB->F2_SERIE
		cCondc	:=	TRB->F2_COND
		cCond 	:= TRB->E4_DESCRI
		
	ENDIF
	
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//|			TOTALIZADORES                               	              		  	  |
	//|														 				  							  |
	//|	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд© |
	//|	//|   SOMA TOTAIS POR NOTA 			                                    | |
	//|	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды |
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	
	// TOTAIS GERAIS
	NTotGeral   := nTotGeral   + (TRB->D2_TOTAL + TRB->D2_VALIPI)
	NTotGeralv  := nTotGeralv	+ (nValVend*TRB->D2_QUANT)	// valor venda
	NTotGeralt  := nTotGeralt	+ (nValTab*TRB->D2_QUANT)   // valor tabela
//	NTotGerale  := nTotGerale	+ (nValEst*TRB->D2_QUANT)   // valor estado
	//		nPorcTot		:= nPorcTot 	+ nPorcDesc // % DESCONTO
	
	IF cDoc == TRB->D2_DOC
		nLoop++
		nTotNF      := nTotNF      + (TRB->D2_TOTAL + TRB->D2_VALIPI)
		nTotValv		:= nTotValv		+ (nValVend*TRB->D2_QUANT)	// valor venda
		nTotValt		:= nTotValt		+ (nValTab*TRB->D2_QUANT)   // valor tabela
//		nTotVale		:= nTotVale		+ (nValEst*TRB->D2_QUANT)   // valor estado
	ENDIF
	
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//|   SOMA TOTAIS POR CLIENTE		                                    |
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	
	IF cCli == TRB->A1_COD .AND. cLoja == TRB->A1_LOJA
		nTotCliNF	:= nTotCliNF   + (TRB->D2_TOTAL + TRB->D2_VALIPI)
		nTotCliv		:= nTotCliv		+ (nValVend*TRB->D2_QUANT)	// valor venda
		nTotClit		:= nTotClit		+ (nValTab*TRB->D2_QUANT)	// valor tabela
//		nTotClie		:= nTotClie		+ (nValEst*TRB->D2_QUANT)	// valor estado
	ENDIF
	
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//|   SOMA TOTAIS POR DIA			                                   		|
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	
	IF cData == TRB->F2_EMISSAO
		nTotDiaNF	:= nTotDiaNF 	+ (TRB->D2_TOTAL + TRB->D2_VALIPI)	//nTotNF
		nTotDiav		:= nTotDiav 	+ (nValVend*TRB->D2_QUANT)			// valor venda
		nTotDiat		:= nTotDiat		+ (nValTab*TRB->D2_QUANT)			// valor tabela
//		nTotDiae		:= nTotDiae		+ (nValEst*TRB->D2_QUANT)			// valor estado
	ENDIF
	
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//|   IMPRIMIR TOTAIS E QUEBRA DE LINHA - CABEгALHO                     |
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	
	IF		cDoc == TRB->D2_DOC .AND. cCod == TRB->D2_COD .AND. nQuebra == 1
		IF MV_PAR09 == 1 			// ANALITICO
			nQuebra++
			nLin++
			@nLin,000 PSAY "Cliente:"
			@nLin,010 PSAY SUBSTR(cCliNR ,1,25) //TRB->A1_NREDUZ //SUBSTR(TRB->A1_NOME, 1, 25)
			@nLin,037 PSAY "UF:"
			@nLin,040 PSAY TRB->D2_EST
			@nLin,045 PSAY "DT EMISSAO:"
			@nLin,056 PSAY DTOC(STOD(TRB->F2_EMISSAO))
			@nLin,068 PSAY "TIPO NF:"
			@nLin,078 PSAY TRB->D2_TIPO
			@nLin,083 PSAY "CFOP:"
			@nLin,090 PSAY TRB->D2_CF
			@nLin,100 PSAY "VENDEDOR:"
			@nLin,110 PSAY ALLTRIM(TRB->F2_VEND1)
			@nLin,120 PSAY SUBSTR(TRB->A3_NOME,1,30)
			@nLin,155 PSAY "GRUPO VENDAS:"
			@nLin,170 PSAY TRB->F2_YCANAL
			@nLin,180 PSAY TRB->ACA_DESCRI
			
		ELSEIF MV_PAR09 == 2 .AND. MV_PAR14 == 2 // SINTETICO
			IF nQuebra == 1 //cCli == TRB->A1_COD .OR. cLoja != TRB->A1_LOJA .AND.
				nQuebra++
				nLin++
				nLin++
				@nLin,000 PSAY "Cliente:"
				@nLin,010 PSAY cCli
				@nLin,017 PSAY cLoja
				@nLin,023 PSAY SUBSTR(cCliNR ,1,25) //cCliNR
			ENDIF
		ENDIF
	ENDIF
	
	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//|   IMPRIME VALORES DO PRODUTO	                                    |
	//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	
	IF MV_PAR09 == 2 .AND. MV_PAR14 == 1 // SINTETICO CLIENTE-PERIODO
		
	ELSE
		nLin++
		@nLin,000 PSAY TRB->D2_COD 	// cCod
		@nLin,015 PSAY SUBSTR(TRB->B1_XDESC,1,50) // SUBSTR(TRB->B1_DESC, 1, 45)
		@nLin,078 PSAY TRB->D2_QUANT
		@nLin,087 PSAY Transform(nValVend ,"@E  999,999,999.99") 	// PREгO DE VENDA
		@nLin,108 PSAY Transform(nValTab  ,"@E  999,999,999.99")	 	// PREгO DE TABELA
//		@nLin,133 PSAY Transform(nValEst  ,"@E  999,999,999.99")		// PREгO DE ESTADO
		@nLin,143 PSAY cCodTab	//codigo da tabela	// PREгO DE ESTADO
		@nLin,157 PSAY Transform(nPorcDesc,"@E  999,999,999.99")		// % DE DESCONTO
		@nLin,185 PSAY TRB->C6_X_USRLB
		
	ENDIF
	//ENDIF
	
	DBSELECTAREA("TRB")
	dbSkip() // Avanca o ponteiro do registro no arquivo
EndDo

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//|   IMPRIME O TOTAL DA ULTIMA NOTA                                    |
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды

IF nQuebra != 1
	IF MV_PAR09 == 1 			// ANALITICO
		// imprime totais
		nLin++
		@nLin,000 PSAY "NOTA FISCAL"
		@nLin,012 PSAY cDoc + " - " + TRB->F2_SERIE
		@nLin,025 PSAY "TOTAL NF"
		@nLin,035 PSAY nTotNF
		@nLin,065 PSAY "TOTAIS --->"
		@nLin,087 PSAY Transform(nTotValV,"@E  999,999,999.99") 		// preco de venda
		@nLin,108 PSAY Transform(nTotValT,"@E  999,999,999.99")	 	// PRECO TABELA
//		@nLin,133 PSAY Transform(nTotValE,"@E  999,999,999.99")		// PRECO ESTADO
		@nLin,157 PSAY Transform(((nTotValv/nTotValT)*100) - 100, "@E  999,999,999.99") //@nLin,157 PSAY Transform(((nTotValv/nTotVale)*100) - 100, "@E  999,999,999.99")
		
		nLin++
		@nLin,00 PSAY "COND PAGTO"
		@nLin,12 PSAY TRB->E4_DESCRI
		nLin++
		@nLin,00 PSAY REPLICATE("-", 220)
	ELSEIF MV_PAR09 == 2 			// SINTETICO
		
	ENDIF
ENDIF

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//|   IMPRIME O TOTAL DO ULTIMO DIA	                                    |
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды

IF MV_PAR09 == 2 // .AND. MV_PAR14 == 2
	
ELSE
	IF cData != TRB->F2_EMISSAO
		
		nLin++
		@nLin,000 PSAY "TOTAL DO DIA:"
		@nLin,014 PSAY DTOC(STOD(cData))
		@nLin,025 PSAY "TOTAL NFs"
		@nLin,035 PSAY Transform(nTotDiaNF,"@E  999,999,999.99")
		@nLin,065 PSAY "TOTAIS --->"
		@nLin,087 PSAY Transform(nTotDiaV,"@E  999,999,999.99") 		// PRECO VENDA
		@nLin,108 PSAY Transform(nTotDiaT,"@E  999,999,999.99") 		// PRECO TABELA
//		@nLin,133 PSAY Transform(nTotDiaE,"@E  999,999,999.99") 		// PRECO ESTADO
		if MV_PAR14 == 2
			@nLin,157 PSAY Transform(((nTotDiav/nTotDiaT)*100) - 100, "@E  999,999,999.99")
		else
			@nLin,133 PSAY Transform(((nTotDiav/nTotDiaT)*100) - 100, "@E  999,999,999.99")
		endif
		nLin++
		@nLin,00 PSAY REPLICATE("-", 220)
	ENDIF
ENDIF

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//|   IMPRIME O TOTAL DO ULTIMO CLIENTE  						               |
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды

IF MV_PAR09 == 2 //.AND. MV_PAR14 == 1
	IF cCli != TRB->A1_COD
		
		nLin++
		@nLin,000 PSAY "Cliente"
		@nLin,010 PSAY cCli
		@nLin,017 PSAY cLoja
		@nLin,023 PSAY SUBSTR(cCliNR ,1,25) //cCliNR
		@nLin,064 PSAY "TOTAL NFs"
		@nLin,071 PSAY Transform(nTotCliNF,"@E  999,999,999.99")
		//			@nLin,065 PSAY "TOTAIS --->"
		@nLin,087 PSAY Transform(nTotCliv,"@E  999,999,999.99") 		// PRECO VENDA
		@nLin,108 PSAY Transform(nTotClit,"@E  999,999,999.99") 		// PRECO TABELA
//		@nLin,133 PSAY Transform(nTotClie,"@E  999,999,999.99") 		// PRECO ESTADO
		IF MV_PAR09 == 2 .AND. MV_PAR14 == 2
			@nLin,158 PSAY Transform(((nTotCliv/nTotClit)*100) - 100, "@E  999,999,999.99")
		ELSE
			@nLin,133 PSAY Transform(((nTotCliv/nTotClit)*100) - 100, "@E  999,999,999.99")
		ENDIF
		nLin++
		@nLin,00 PSAY REPLICATE("-", 220)
	ENDIF
	
ELSEIF MV_PAR09 == 2 .AND. MV_PAR14 == 2
	IF cCli != TRB->A1_COD
		
		nLin++
		//		@nLin,000 PSAY "Cliente"
		//		@nLin,010 PSAY cCli
		//		@nLin,017 PSAY cLoja
		//		@nLin,023 PSAY cCliNR
		@nLin,064 PSAY "TOTAL NFs"
		@nLin,071 PSAY Transform(nTotCliNF,"@E  999,999,999.99")
		//			@nLin,065 PSAY "TOTAIS --->"
		@nLin,087 PSAY Transform(nTotCliv,"@E  999,999,999.99") 		// PRECO VENDA
		@nLin,108 PSAY Transform(nTotClit,"@E  999,999,999.99") 		// PRECO TABELA
//		@nLin,133 PSAY Transform(nTotClie,"@E  999,999,999.99") 		// PRECO ESTADO
		IF MV_PAR09 == 2 .AND. MV_PAR14 == 2
			@nLin,158 PSAY Transform(((nTotCliv/nTotClit)*100) - 100, "@E  999,999,999.99")
		ELSE
			@nLin,133 PSAY Transform(((nTotCliv/nTotClit)*100) - 100, "@E  999,999,999.99")
		ENDIF
		nLin++
		@nLin,00 PSAY REPLICATE("-", 220)
	ENDIF
ENDIF

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//|   IMPRIME O TOTAL GERAL			                                    |
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды

nLin++
nLin++
nLin++
@nLin,000 PSAY "TOTAL GERAL --->"
@nLin,020 PSAY "NOTAS FISCAIS:"
@nLin,040 PSAY Transform(nTotGeral,"@E  999,999,999.99")
//	@nLin,025 PSAY "TOTAL NFs"
//	@nLin,033 PSAY nTotCliNF
//	@nLin,065 PSAY "TOTAIS --->"
@nLin,087 PSAY Transform(nTotGeralv,"@E  999,999,999.99") 		// PRECO VENDA
@nLin,108 PSAY Transform(nTotGeralt,"@E  999,999,999.99") 		// PRECO TABELA
//@nLin,133 PSAY Transform(nTotGerale,"@E  999,999,999.99")		// PRECO ESTADO
//@nLin,133 PSAY Transform(nTotGerale,"@E  999,999,999.99")		// PRECO ESTADO
//@nLin,157 PSAY Transform(((nTotGeralv/nTotGeralt)*100) - 100, "@E  999,999,999.99")
IF MV_PAR09 == 2 .AND. MV_PAR14 == 1
	@nLin,133 PSAY Transform(((nTotGeralv/nTotGeralt)*100) - 100, "@E  999,999,999.99")
ELSE
	@nLin,157 PSAY Transform(((nTotGeralv/nTotGeralt)*100) - 100, "@E  999,999,999.99")
ENDIF
//nLin++
//@nLin,00 PSAY REPLICATE("-", 220)

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё IMPRESSAO EXCEL							                                 Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды

XLS->(DBGOTOP())
TRB->(DBGOTOP())
CpyS2T( "\SYSTEM\" + CNOMEDBF +".DBF" , "C:\RELATORIOS\" , .F. )
Alert("Arquivo salvo em C:\Relatorios\" + CNOMEDBF + ".DBF" )

If ! ApOleClient( 'MsExcel' )
	MsgStop( 'MsExcel nao instalado' )
	DbSelectArea("TRB")
	DbCloseArea()
	XLS->(DBCLOSEAREA())
	//	Return
ELSE
	//EndIf
	
	DbSelectArea("TRB")
	DbCloseArea()
	
	oExcelApp := MsExcel():New()
	oExcelApp:WorkBooks:Open( "C:\RELATORIOS\" + CNOMEDBF +".DBF" ) // Abre uma planilha
	oExcelApp:SetVisible(.T.)
	XLS->(DBCLOSEAREA())
	
	//ENDIF
EndIf

FErase("\SYSTEM\" + CNOMEDBF +".dbf")
FErase("\SYSTEM\RELDESC.sql")

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Finaliza a execucao do relatorio...                                 Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды

SET DEVICE TO SCREEN

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Se impressao em disco, chama o gerenciador de impressao...          Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды

If aReturn[5]==1
	dbCommitAll()
	SET PRINTER TO
	OurSpool(wnrel)
Endif

MS_FLUSH()

Return
