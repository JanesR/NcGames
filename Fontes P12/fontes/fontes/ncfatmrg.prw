#Include "MATR580.CH"
#Include "FIVEWIN.Ch"
#DEFINE CRLF Chr(13)+Chr(10)

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ NC_MATR580³ Autor ³ Marco Bianchi        ³ Data ³ 26/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Estatistica de Venda por Ordem de Vendedor                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ SIGAFAT - R4 - ESPECIFICO NC GAMES                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function NCFATMRG()

Local oReport

oReport := ReportDef()
oReport:PrintDialog()

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Marco Bianchi         ³ Data ³ 26/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatório                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()

Local oReport
Local oFatVend

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao do componente de impressao                                      ³
//³                                                                        ³
//³TReport():New                                                           ³
//³ExpC1 : Nome do relatorio                                               ³
//³ExpC2 : Titulo                                                          ³
//³ExpC3 : Pergunte                                                        ³
//³ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  ³
//³ExpC5 : Descricao                                                       ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport := TReport():New("NCFATMRG","Vendas e Margem Realizado","FATMRG", {|oReport| ReportPrint(oReport,oFatVend)},STR0016 + " " + STR0017 + " " + STR0018)
//oReport:SetLandscape()
oReport:SetTotalInLine(.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
AjustaSx1()
Pergunte(oReport:uParam,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao da secao utilizada pelo relatorio                               ³
//³                                                                        ³
//³TRSection():New                                                         ³
//³ExpO1 : Objeto TReport que a secao pertence                             ³
//³ExpC2 : Descricao da seçao                                              ³
//³ExpA3 : Array com as tabelas utilizadas pela secao. A primeira tabela   ³
//³        sera considerada como principal para a seção.                   ³
//³ExpA4 : Array com as Ordens do relatório                                ³
//³ExpL5 : Carrega campos do SX3 como celulas                              ³
//³        Default : False                                                 ³
//³ExpL6 : Carrega ordens do Sindex                                        ³
//³        Default : False                                                 ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao da celulas da secao do relatorio                                ³
//³                                                                        ³
//³TRCell():New                                                            ³
//³ExpO1 : Objeto TSection que a secao pertence                            ³
//³ExpC2 : Nome da celula do relatório. O SX3 será consultado              ³
//³ExpC3 : Nome da tabela de referencia da celula                          ³
//³ExpC4 : Titulo da celula                                                ³
//³        Default : X3Titulo()                                            ³
//³ExpC5 : Picture                                                         ³
//³        Default : X3_PICTURE                                            ³
//³ExpC6 : Tamanho                                                         ³
//³        Default : X3_TAMANHO                                            ³
//³ExpL7 : ITforme se o tamanho esta em pixel                              ³
//³        Default : False                                                 ³
//³ExpB8 : Bloco de código para impressao.                                 ³
//³        Default : ExpC2                                                 ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oFatVend := TRSection():New(oReport,"Clientes",{"SA3"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)
oFatVend:SetTotalInLine(.F.)
//Dados cadastrais
TRCell():New(oFatVend,"TB_YDCANAL"	,"TRB"	,"Canal de Vendas" 			,PesqPict("ACA","ACA_DESCRI")	,TamSx3("ACA_DESCRI")	[1]	,/*lPixel*/,/*{|| code-block de impressao }*/	)       // "Quantidade Vendida"
TRCell():New(oFatVend,"CCODCLI"		,		,RetTitle("A1_COD")			,PesqPict("SA1","A1_COD")		,TamSx3("A1_COD")		[1]	,/*lPixel*/,/*{|| cVend }*/						)		// "Codigo do Cliente"
TRCell():New(oFatVend,"CLJCLI"		,		,RetTitle("A1_LOJA")		,PesqPict("SA1","A1_LOJA")		,TamSx3("A1_LOJA")		[1]	,/*lPixel*/,/*{|| cLjCli }*/					)		// "Codigo do Cliente"
TRCell():New(oFatVend,"CUF"			,		,RetTitle("A1_EST")			,PesqPict("SA1","A1_EST")		,TamSx3("A1_EST")		[1]	,/*lPixel*/,/*{|| cUf }*/						)		// "Nome do Cliente"
TRCell():New(oFatVend,"CNOME"		,		,RetTitle("A1_NOME")		,PesqPict("SA1","A1_NOME")		,TamSx3("A1_NOME")		[1]	,/*lPixel*/,/*{|| cNome }*/						)		// "Nome do Cliente"
TRCell():New(oFatVend,"CPUBLISH"	,		,RetTitle("B1_PUBLISH")		,PesqPict("SB1","B1_PUBLISH")	,TamSx3("B1_PUBLISH")	[1]	,/*lPixel*/,/*{|| cNome }*/						)		// "Nome do Cliente"
TRCell():New(oFatVend,"CPLATAF"		,		,RetTitle("Z5_PLATRED")		,PesqPict("SZ5","Z5_PLATRED")	,TamSx3("Z5_PLATRED")	[1]	,/*lPixel*/,/*{|| cNome }*/						)		// "Nome do Cliente"
TRCell():New(oFatVend,"CCODPRO"		,		,RetTitle("B1_COD")			,PesqPict("SB1","B1_COD")		,TamSx3("B1_COD")		[1]	,/*lPixel*/,/*{|| cNome }*/						)		// "Nome do Cliente"
TRCell():New(oFatVend,"CDESCPRO"	,		,RetTitle("B1_XDESC")		,PesqPict("SB1","B1_XDESC")		,TamSx3("B1_XDESC")		[1]	,/*lPixel*/,/*{|| cNome }*/						)		// "Nome do Cliente"
//Valores Faturamento
TRCell():New(oFatVend,"TB_VALOR1"	,"TRB"	,"Qtd. Faturada"			,PesqPict("SD2","D2_QUANT")		,TamSx3("D2_QUANT")		[1]	,/*lPixel*/,/*{|| code-block de impressao }*/	)		// "Quantidade Faturada"
TRCell():New(oFatVend,"TB_VALOR2"	,"TRB"	,"Valor Total"				,PesqPict("SF2","F2_VALBRUT")	,TamSx3("F2_VALBRUT")	[1]	,/*lPixel*/,/*{|| code-block de impressao }*/	)       // "Valor Total"
TRCell():New(oFatVend,"TB_VALOR3"	,"TRB"	,"Vlr. ICMS"				,PesqPict("SF2","F2_VALICM")	,TamSx3("F2_VALICM")	[1]	,/*lPixel*/,/*{|| code-block de impressao }*/	)       // "Valor do ICMS"
TRCell():New(oFatVend,"TB_VALOR4"	,"TRB"	,"Vlr. PIS"					,PesqPict("SD2","D2_VALIMP6")	,TamSx3("D2_VALIMP6")	[1]	,/*lPixel*/,/*{|| code-block de impressao }*/	)       // "Valor PIS"
TRCell():New(oFatVend,"TB_VALOR5"	,"TRB"	,"Vlr. COFINS"				,PesqPict("SD2","D2_VALIMP5")	,TamSx3("D2_VALIMP5")	[1]	,/*lPixel*/,/*{|| code-block de impressao }*/	)       // "Valor COFINS"
TRCell():New(oFatVend,"TB_VALOR6"	,"TRB"	,"Vlr. IPI"					,PesqPict("SD2","D2_VALIPI")	,TamSx3("D2_VALIMP5")	[1]	,/*lPixel*/,/*{|| code-block de impressao }*/	)       // "Valor COFINS"
TRCell():New(oFatVend,"TB_VALOR7"	,"TRB"	,"Vlr. ICMS-ST"				,PesqPict("SD2","D2_VALIMP5")	,TamSx3("D2_VALIMP5")	[1]	,/*lPixel*/,/*{|| code-block de impressao }*/	)       // "Valor COFINS"
TRCell():New(oFatVend,"TB_VALOR8"	,"TRB"	,"Vlr. Frete"				,PesqPict("SD2","D2_VALIMP5")	,TamSx3("D2_VALIMP5")	[1]	,/*lPixel*/,/*{|| code-block de impressao }*/	)       // "Valor COFINS"
TRCell():New(oFatVend,"TB_VALOR9"	,"TRB"	,"Vlr. Seguro"				,PesqPict("SD2","D2_VALIMP5")	,TamSx3("D2_VALIMP5")	[1]	,/*lPixel*/,/*{|| code-block de impressao }*/	)       // "Valor COFINS"
TRCell():New(oFatVend,"TB_VALOR10"	,"TRB"	,"Vlr. Despesas"			,PesqPict("SD2","D2_VALIMP5")	,TamSx3("D2_VALIMP5")	[1]	,/*lPixel*/,/*{|| code-block de impressao }*/	)       // "Valor COFINS"
//Valores de Devolução
TRCell():New(oFatVend,"TB_VALOR11"	,"TRB"	,"Qtd. Devolvida"			,PesqPict("SD2","D2_QUANT")		,TamSx3("D2_QUANT")		[1]	,/*lPixel*/,/*{|| code-block de impressao }*/	)		// "Quantidade Faturada"
TRCell():New(oFatVend,"TB_VALOR12"	,"TRB"	,"Dev. Valor Total"			,PesqPict("SF2","F2_VALBRUT")	,TamSx3("F2_VALBRUT")	[1]	,/*lPixel*/,/*{|| code-block de impressao }*/	)       // "Valor Total"
TRCell():New(oFatVend,"TB_VALOR13"	,"TRB"	,"Dev. Vlr. ICMS"			,PesqPict("SF2","F2_VALICM")	,TamSx3("F2_VALICM")	[1]	,/*lPixel*/,/*{|| code-block de impressao }*/	)       // "Valor do ICMS"
TRCell():New(oFatVend,"TB_VALOR14"	,"TRB"	,"Dev. Vlr. PIS"			,PesqPict("SD2","D2_VALIMP6")	,TamSx3("D2_VALIMP6")	[1]	,/*lPixel*/,/*{|| code-block de impressao }*/	)       // "Valor PIS"
TRCell():New(oFatVend,"TB_VALOR15"	,"TRB"	,"Dev. Vlr. COFINS"			,PesqPict("SD2","D2_VALIMP5")	,TamSx3("D2_VALIMP5")	[1]	,/*lPixel*/,/*{|| code-block de impressao }*/	)       // "Valor COFINS"
TRCell():New(oFatVend,"TB_VALOR16"	,"TRB"	,"Dev. Vlr. IPI"			,PesqPict("SD2","D2_VALIPI")	,TamSx3("D2_VALIMP5")	[1]	,/*lPixel*/,/*{|| code-block de impressao }*/	)       // "Valor COFINS"
TRCell():New(oFatVend,"TB_VALOR17"	,"TRB"	,"Dev. Vlr. ICMS-ST"		,PesqPict("SD2","D2_VALIMP5")	,TamSx3("D2_VALIMP5")	[1]	,/*lPixel*/,/*{|| code-block de impressao }*/	)       // "Valor COFINS"
TRCell():New(oFatVend,"TB_VALOR18"	,"TRB"	,"Dev. Vlr. Frete"			,PesqPict("SD2","D2_VALIMP5")	,TamSx3("D2_VALIMP5")	[1]	,/*lPixel*/,/*{|| code-block de impressao }*/	)       // "Valor COFINS"
TRCell():New(oFatVend,"TB_VALOR19"	,"TRB"	,"Dev. Vlr. Seguro"			,PesqPict("SD2","D2_VALIMP5")	,TamSx3("D2_VALIMP5")	[1]	,/*lPixel*/,/*{|| code-block de impressao }*/	)       // "Valor COFINS"
TRCell():New(oFatVend,"TB_VALOR20"	,"TRB"	,"Dev. Vlr. Despesas"		,PesqPict("SD2","D2_VALIMP5")	,TamSx3("D2_VALIMP5")	[1]	,/*lPixel*/,/*{|| code-block de impressao }*/	)       // "Valor COFINS"
//Apuração
TRCell():New(oFatVend,"NVALLIQ"		,"TRB"	,"Fat. Liquido" 			,PesqPict("SD2","D2_QUANT")		,TamSx3("D2_QUANT")	[1]		,/*lPixel*/,/*{|| code-block de impressao }*/	)       // "Faturamento Líquido"

TRCell():New(oFatVend,"TB_VALOR21"	,"TRB"	,"Custo Unitário" 			,PesqPict("SD2","D2_QUANT")		,TamSx3("D2_QUANT")	[1]		,/*lPixel*/,/*{|| code-block de impressao }*/	)       // "Quantidade Vendida"
TRCell():New(oFatVend,"NVALMGR"		, 		,"Margem Bruta R$"			,PesqPict("SD2","D2_QUANT")		,TamSx3("D2_QUANT")	[1]		,/*lPixel*/,/*{|| code-block de impressao }*/	)       // "Quantidade Vendida"
TRCell():New(oFatVend,"NPERMGR"		, 		,"Margem Bruta %"			,PesqPict("SD2","D2_QUANT")		,TamSx3("D2_QUANT")	[1]		,/*lPixel*/,/*{|| code-block de impressao }*/	)       // "Quantidade Vendida"
TRCell():New(oFatVend,"NMARKUP"		, 		,"Mark UP"					,PesqPict("SD2","D2_QUANT")		,TamSx3("D2_QUANT")	[1]		,/*lPixel*/,/*{|| code-block de impressao }*/	)       // "Quantidade Vendida"

TRCell():New(oFatVend,"NFATORDV"	,"TRB"	,"% Desp Var s/ Fat. Bruto"	,PesqPict("SD2","D2_QUANT")		,TamSx3("D2_QUANT")	[1]		,/*lPixel*/,/*{|| code-block de impressao }*/	)       // "Desp Var s/ Fat. Bruto" - Pegar o valor na tabela de despesas variáveis
TRCell():New(oFatVend,"NVALDV"		,"TRB"	,"Desp Var R$"				,PesqPict("SD2","D2_QUANT")		,TamSx3("D2_QUANT")	[1]		,/*lPixel*/,/*{|| code-block de impressao }*/	)       // "Despesas Variaveis R$"
//TRCell():New(oFatVend,"NPERDV"		,"TRB"	,"Desp Var %"				,PesqPict("SD2","D2_QUANT")		,TamSx3("D2_QUANT")	[1]		,/*lPixel*/,/*{|| code-block de impressao }*/	)       // "Despesas Variaveis %"
TRCell():New(oFatVend,"NVALMC"		,"TRB"	,"Margem Contribuição"		,PesqPict("SD2","D2_QUANT")		,TamSx3("D2_QUANT")	[1]		,/*lPixel*/,/*{|| code-block de impressao }*/	)       // "Despesas Variaveis %"
TRCell():New(oFatVend,"NPERMC"		,"TRB"	,"% MC"						,PesqPict("SD2","D2_QUANT")		,TamSx3("D2_QUANT")	[1]		,/*lPixel*/,/*{|| code-block de impressao }*/	)       // "Despesas Variaveis %"

//Adicionais de canal de vendas
//TRCell():New(oFatVend,"TB_YCANAL"	,"TRB"	,"Cod Canal" 				,PesqPict("ACA","ACA_GRPREP")	,TamSx3("ACA_GRPREP")	[1]	,/*lPixel*/,/*{|| code-block de impressao }*/	)       // "Quantidade Vendida"

// Totalizadores Faturamento
TRFunction():New(oFatVend:Cell("TB_VALOR1") ,/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
TRFunction():New(oFatVend:Cell("TB_VALOR2") ,/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
TRFunction():New(oFatVend:Cell("TB_VALOR3") ,/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
TRFunction():New(oFatVend:Cell("TB_VALOR4") ,/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
TRFunction():New(oFatVend:Cell("TB_VALOR6") ,/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
TRFunction():New(oFatVend:Cell("TB_VALOR7") ,/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
TRFunction():New(oFatVend:Cell("TB_VALOR8") ,/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
TRFunction():New(oFatVend:Cell("TB_VALOR9") ,/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
TRFunction():New(oFatVend:Cell("TB_VALOR10"),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)

// Totalizadores Devolução
TRFunction():New(oFatVend:Cell("TB_VALOR11") ,/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
TRFunction():New(oFatVend:Cell("TB_VALOR12") ,/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
TRFunction():New(oFatVend:Cell("TB_VALOR13") ,/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
TRFunction():New(oFatVend:Cell("TB_VALOR14") ,/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
TRFunction():New(oFatVend:Cell("TB_VALOR16") ,/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
TRFunction():New(oFatVend:Cell("TB_VALOR17") ,/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
TRFunction():New(oFatVend:Cell("TB_VALOR18") ,/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
TRFunction():New(oFatVend:Cell("TB_VALOR19") ,/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)
TRFunction():New(oFatVend:Cell("TB_VALOR20"),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,.T./*lEndReport*/,/*lEndPage*/)

// Alinhamento das colunas de valor a direita
oFatVend:Cell("TB_VALOR1"):SetHeaderAlign("RIGHT")
oFatVend:Cell("TB_VALOR2"):SetHeaderAlign("RIGHT")
oFatVend:Cell("TB_VALOR3"):SetHeaderAlign("RIGHT")
oFatVend:Cell("TB_VALOR4"):SetHeaderAlign("RIGHT")
oFatVend:Cell("TB_VALOR5"):SetHeaderAlign("RIGHT")
oFatVend:Cell("TB_VALOR6"):SetHeaderAlign("RIGHT")
oFatVend:Cell("TB_VALOR7"):SetHeaderAlign("RIGHT")
oFatVend:Cell("TB_VALOR8"):SetHeaderAlign("RIGHT")
oFatVend:Cell("TB_VALOR9"):SetHeaderAlign("RIGHT")
oFatVend:Cell("TB_VALOR10"):SetHeaderAlign("RIGHT")
oFatVend:Cell("TB_VALOR11"):SetHeaderAlign("RIGHT")
oFatVend:Cell("TB_VALOR12"):SetHeaderAlign("RIGHT")
oFatVend:Cell("TB_VALOR13"):SetHeaderAlign("RIGHT")
oFatVend:Cell("TB_VALOR14"):SetHeaderAlign("RIGHT")
oFatVend:Cell("TB_VALOR15"):SetHeaderAlign("RIGHT")
oFatVend:Cell("TB_VALOR16"):SetHeaderAlign("RIGHT")
oFatVend:Cell("TB_VALOR17"):SetHeaderAlign("RIGHT")
oFatVend:Cell("TB_VALOR18"):SetHeaderAlign("RIGHT")
oFatVend:Cell("TB_VALOR19"):SetHeaderAlign("RIGHT")
oFatVend:Cell("TB_VALOR20"):SetHeaderAlign("RIGHT")


// Esta Secao serve apenas para receber as Querys, pois como o relatorio e baseado na tabela TRB, as Querys
// sao fechadas, estes Alias nao sao reconhecidos pelo objeto oFatVend pois nao esta no array de tabelas
//oTemp := TRSection():New(oReport,STR0027,{"SD2","SF2","SF4","SD1","SF1","TRB"},,/*Campos do SX3*/,/*Campos do SIX*/)
oTemp1 := TRSection():New(oReport,STR0027,{"SF2","SD2","SF4"},,/*Campos do SX3*/,/*Campos do SIX*/)
oTemp1:SetTotalInLine(.F.)

oTemp2 := TRSection():New(oReport,STR0028,{"SF1","SD1"},,/*Campos do SX3*/,/*Campos do SIX*/)
oTemp2:SetTotalInLine(.F.)

oReport:Section(2):SeteditCell(.F.)
oReport:Section(3):SeteditCell(.F.)

Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³Marco Bianchi          ³ Data ³ 26/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatório                           ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport,oFatVend)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cEstoq 	:= If( (MV_PAR09 == 1),"S",If( (MV_PAR09 == 2),"N","SN" ) )
Local cDupli 	:= If( (MV_PAR08 == 1),"S",If( (MV_PAR08 == 2),"N","SN" ) )
Local aCampos 	:= {}
Local aTam	 	:= {}
Local nAg1		:= 0,nAg2:=0,nAg3:=0
Local nMoeda	:= ""
Local cMoeda	:= ""
Local nContador,nTOTAL,nVALICM,nVALIPI,QtdVend,NMEDIA
Local nVendedor	:= Fa440CntVen()
Local cVendedor	:= ""
Local aVend    	:= {}
Local aImpostos	:= {}
Local nImpos	:= 0.00
Local lContinua	:= .F.
Local nMoedNF	:=	1
Local nTaxa		:=	0
Local cAddField	:=	""
Local cName     :=  ""
Local nCampo	:=	0
Local cCampo	:=	""
Local cSD2Old	:=	""
Local cSD1Old	:=	""
Local aStru		:=	{}
Local nY        := 	0
Local lFiltro   := .T.
Local lMR580FIL := ExistBlock("MR580FIL")
Local dtMoedaDev:= CtoD("")
Local cUF	 	:= ""
Local cVend    	:= ""
Local cNome    	:= ""
Local cCodcli	:= ""
Local cLjcli	:= ""
Local cFilSA3   := ""
Local cPublish 	:= ""
Local cPlataf 	:= ""
Local cCodPro 	:= ""
Local cDescPro 	:= ""
Local nAdic     := ""
Local nOrdem    := If(MV_PAR05==1,3,1)  //1=Aglutina por cliente+loja, 3= Aglutina por cliente

#IFDEF TOP
	Local nX := 0
#ENDIF

Private cCampImp
Private aTamVal:= { 16, 2 }
Private nDecs:=msdecimais(mv_par06)

If lMR580FIL
	aFilUsrSF1 := ExecBlock("MR580FIL",.F.,.F.,aReturn[7])
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ SetBlock: faz com que as variaveis locais possam ser         ³
//³ utilizadas em outras funcoes nao precisando declara-las      ³
//³ como private											  	 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:Section(1):Cell("CCODCLI" 	):SetBlock({|| cCodcli 	})
oReport:Section(1):Cell("CLJCLI" 	):SetBlock({|| cLjcli 	})
oReport:Section(1):Cell("CUF" 		):SetBlock({|| cUF 		})
oReport:Section(1):Cell("CNOME" 	):SetBlock({|| cNome 	})
oReport:Section(1):Cell("CPUBLISH" 	):SetBlock({|| cPublish })
oReport:Section(1):Cell("CPLATAF" 	):SetBlock({|| cPlataf 	})
oReport:Section(1):Cell("CCODPRO" 	):SetBlock({|| cCodPro 	})
oReport:Section(1):Cell("CDESCPRO" 	):SetBlock({|| cDescPro })
oReport:Section(1):Cell("NVALMGR" 	):SetBlock({|| nValMgr  })
oReport:Section(1):Cell("NPERMGR" 	):SetBlock({|| nPerMgr  })
oReport:Section(1):Cell("NMARKUP" 	):SetBlock({|| nMarkUp  })
oReport:Section(1):Cell("NVALLIQ" 	):SetBlock({|| nValLiq  })
oReport:Section(1):Cell("NVALDV" 	):SetBlock({|| NVALDV   })
//oReport:Section(1):Cell("NPERDV" 	):SetBlock({|| NPERDV   })
oReport:Section(1):Cell("NVALMC" 	):SetBlock({|| NVALMC   })
oReport:Section(1):Cell("NPERMC" 	):SetBlock({|| NPERMC   })
oReport:Section(1):Cell("NFATORDV" 	):SetBlock({|| NFATORDV })



//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Altera o Titulo do Relatorio de acordo com Moeda escolhida 	 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetTitle(oReport:Title() + " " + IIF(mv_par05 == 1,STR0023,STR0024) + " - "  + GetMv("MV_MOEDA"+STR(mv_par06,1)) )		// "Faturamento por Vendedor"###"(Ordem Decrescente por Vendedor)"###"(Por Ranking)"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria array para gerar arquivo de trabalho                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If Select("TRB") > 0
	dbselectArea("TRB")
	dbclosearea()
EndIf
aTam:=TamSX3("A1_COD")
AADD(aCampos,{ "TB_CODCLI" 	,"C",aTam[1],aTam[2] } )
aTam:=TamSX3("A1_LOJA")
AADD(aCampos,{ "TB_LJCLI"  	,"C",aTam[1],aTam[2] } )
aTam:=TamSX3("A1_EST")
AADD(aCampos,{ "TB_EST"    	,"C",aTam[1],aTam[2] } )
aTam:=TamSX3("A1_NOME")
AADD(aCampos,{ "TB_NOME"   	,"C",aTam[1],aTam[2] } )
aTam:=TamSX3("B1_PUBLISH")
AADD(aCampos,{ "TB_PUBLISH"	,"C",aTam[1],aTam[2] } )
aTam:=TamSX3("Z5_PLATRED")
AADD(aCampos,{ "TB_PLATRED"	,"C",aTam[1],aTam[2] } )
aTam:=TamSX3("B1_COD")
AADD(aCampos,{ "TB_COD"		,"C",aTam[1],aTam[2] } )
aTam:=TamSX3("B1_XDESC")
AADD(aCampos,{ "TB_XDESC"	,"C",aTam[1],aTam[2] } )
aTam:=TamSX3("F2_EMISSAO")
AADD(aCampos,{ "TB_EMISSAO","D",aTam[1],aTam[2] } )
aTam:=TamSX3("F2_VALFAT")
AADD(aCampos,{ "TB_VALOR1 ","N",aTam[1],aTam[2] } )
aTam:=TamSX3("F2_VALFAT")
AADD(aCampos,{ "TB_VALOR2 ","N",aTam[1],aTam[2] } )
aTam:=TamSX3("F2_VALFAT")
AADD(aCampos,{ "TB_VALOR3 ","N",aTam[1],aTam[2] } )
aTam:=TamSX3("F2_VALFAT")
AADD(aCampos,{ "TB_VALOR4 ","N",aTam[1],aTam[2] } )
aTam:=TamSX3("F2_VALFAT")
AADD(aCampos,{ "TB_VALOR5 ","N",aTam[1],aTam[2] } )
aTam:=TamSX3("F2_VALFAT")
AADD(aCampos,{ "TB_VALOR6 ","N",aTam[1],aTam[2] } )
aTam:=TamSX3("F2_VALFAT")
AADD(aCampos,{ "TB_VALOR7 ","N",aTam[1],aTam[2] } )
aTam:=TamSX3("F2_VALFAT")
AADD(aCampos,{ "TB_VALOR8 ","N",aTam[1],aTam[2] } )
aTam:=TamSX3("F2_VALFAT")
AADD(aCampos,{ "TB_VALOR9 ","N",aTam[1],aTam[2] } )
aTam:=TamSX3("F2_VALFAT")
AADD(aCampos,{ "TB_VALOR10 ","N",aTam[1],aTam[2] } )
aTam:=TamSX3("F2_VALFAT")
AADD(aCampos,{ "TB_VALOR11 ","N",aTam[1],aTam[2] } )
aTam:=TamSX3("F2_VALFAT")
AADD(aCampos,{ "TB_VALOR12 ","N",aTam[1],aTam[2] } )
aTam:=TamSX3("F2_VALFAT")
AADD(aCampos,{ "TB_VALOR13 ","N",aTam[1],aTam[2] } )
aTam:=TamSX3("F2_VALFAT")
AADD(aCampos,{ "TB_VALOR14 ","N",aTam[1],aTam[2] } )
aTam:=TamSX3("F2_VALFAT")
AADD(aCampos,{ "TB_VALOR15 ","N",aTam[1],aTam[2] } )
aTam:=TamSX3("F2_VALFAT")
AADD(aCampos,{ "TB_VALOR16 ","N",aTam[1],aTam[2] } )
aTam:=TamSX3("F2_VALFAT")
AADD(aCampos,{ "TB_VALOR17 ","N",aTam[1],aTam[2] } )
aTam:=TamSX3("F2_VALFAT")
AADD(aCampos,{ "TB_VALOR18 ","N",aTam[1],aTam[2] } )
aTam:=TamSX3("F2_VALFAT")
AADD(aCampos,{ "TB_VALOR19 ","N",aTam[1],aTam[2] } )
aTam:=TamSX3("F2_VALFAT")
AADD(aCampos,{ "TB_VALOR20 ","N",aTam[1],aTam[2] } )
aTam:=TamSX3("F2_VALFAT")
AADD(aCampos,{ "TB_VALOR21 ","N",aTam[1],aTam[2] } )
aTam:=TamSX3("F2_DOC")
AADD(aCampos,{ "TB_DOC    ","C",aTam[1],aTam[2] } )
aTam:=TamSX3("F2_YCANAL")
AADD(aCampos,{ "TB_YCANAL ","C",aTam[1],aTam[2] } )
aTam:=TamSX3("ACA_DESCRI")
AADD(aCampos,{ "TB_YDCANAL","C",aTam[1],aTam[2] } )
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria arquivo de trabalho                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cNomArq 	:= CriaTrab(aCampos,.T.)
dbUseArea( .T.,, cNomArq,"TRB", .T. , .F. )

cNomArq1 := Subs(cNomArq,1,7)+"A"
IndRegua("TRB",cNomArq1,"TB_CODCLI+TB_LJCLI+TB_YCANAL+TB_COD",,,STR0011)		//"Selecionando Registros..."

aTamVal 	:= TamSX3("F2_VALFAT")
cNomArq2 := Subs(cNomArq,1,7)+"B"
IndRegua("TRB",cNomArq2,"(STRZERO(TB_VALOR3,aTamVal[1],aTamVal[2]))",,,STR0011)		//"Selecionando Registros..."

cNomArq3 := Subs(cNomArq,1,7)+"C"
IndRegua("TRB",cNomArq3,"TB_CODCLI+TB_YCANAL+TB_COD",,,STR0011)		//"Selecionando Registros..."

cNomArq4 := Subs(cNomArq,1,7)+"D"
IndRegua("TRB",cNomArq4,"TB_CODCLI+TB_LJCLI+TB_PUBLISH+TB_PLATRED",,,STR0011)		//"Selecionando Registros..."

dbClearIndex()
dbSetIndex(cNomArq1+OrdBagExt())
dbSetIndex(cNomArq2+OrdBagExt())
dbSetIndex(cNomArq3+OrdBagExt())
dbSetIndex(cNomArq4+OrdBagExt())

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Geracao do Arquivo para Impressao                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Transforma parametros Range em expressao SQL                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr(oReport:uParam)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Filtragem do relatório                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
#IFDEF TOP
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Abre tabelas e indices a serem utilizados                              ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("SD2")			// Itens de Venda da NF
	dbSetOrder(5)				// Filial,Emissao,NumSeq
	dbSelectArea("SD1")			// Itens da Nota de Entrada
	dbSetOrder(6)				// Filial,Data de Digitacao,NumSeq
	
	cAliasSD2	:=	GetNextAlias()
	cWhereAux 	:= ""
	cVendedor 	:= "1"
	cAddField   := "%"
	For nCampo 	:= 1 To nVendedor
		cCampo	:= "F2_VEND"+cVendedor
		If SF2->(FieldPos(cCampo)) > 0
			//			cWhereAux += "(" + cCampo + " between '" + mv_par03 + "' and '" + mv_par04 + "') or "
			cWhereAux += "(" + cCampo + " between '      ' and 'ZZZZZZ') or "
			cAddField += ", " + cCampo
		EndIf
		cVendedor := Soma1(cVendedor,1)
	Next nCampo
	cAddField += "%"
	If Empty(cWhereAux)
		cWhere += "% NOT ("+IsRemito(2,"D2_TIPODOC")+")%"
	Else
		cWhereAux := Left(cWhereAux,Len(cWhereAux)-4)
		cWhere := "%(" + cWhereAux + " ) AND NOT ("+IsRemito(2,"D2_TIPODOC")+")%"
	EndIf
	
	oReport:Section(2):BeginQuery()
	BeginSql Alias cAliasSD2
		SELECT  SD2.*, F2_EMISSAO, F2_TIPO, F2_DOC, F2_FRETE, F2_SEGURO, F2_DESPESA, F2_FRETAUT, F2_ICMSRET, F2_YCANAL,
		F2_TXMOEDA, F2_MOEDA %Exp:cAddField%
		FROM %Table:SD2% SD2, %Table:SF4% SF4, %Table:SF2% SF2
		WHERE D2_FILIAL  = %xFilial:SD2%
		AND D2_EMISSAO between %Exp:DTOS(mv_par01)% AND %Exp:DTOS(mv_par02)%
		AND F2_EST between %Exp:mv_par12% AND %Exp:mv_par13%
		AND D2_COD between %Exp:mv_par14% AND %Exp:mv_par15%
		AND D2_TIPO NOT IN ('D', 'B')
		AND F2_CLIENTE between %Exp:mv_par03% AND %Exp:mv_par04%
		AND F2_FILIAL  = %xFilial:SF2%
		AND D2_DOC     = F2_DOC
		AND D2_SERIE   = F2_SERIE
		AND D2_CLIENTE = F2_CLIENTE
		AND D2_LOJA    = F2_LOJA
		AND F4_FILIAL  = %xFilial:SF4%
		AND F4_CODIGO  = D2_TES
		AND SD2.%notdel%
		AND SF2.%notdel%
		AND SF4.%notdel%
		AND %Exp:cWhere%
		ORDER BY D2_FILIAL,D2_EMISSAO,D2_DOC,D2_NUMSEQ
//		ORDER BY D2_FILIAL,D2_EMISSAO,D2_NUMSEQ
	EndSql
	oReport:Section(2):EndQuery()
	
	oReport:SetMeter( (cAliasSD2)->(LastRec() ))
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Processa Faturamento                                                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nTotVal2:= 0
	nTotFre	:= 0
	nTotSeg	:= 0
	nTotDes := 0
	While !Eof()
		
		oReport:IncMeter()
		nTOTAL  :=0
		nVALICM :=0
		nVALIPI :=0
		nQtdVend:= 0
		NMEDIA	:= 0
		
		cCodPro	:= (cAliasSD2)->D2_COD
		cPublish:= getadvfval("SB1","B1_PUBLISH",xFilial("SB1")+cCodPro,1,"")
		cItemCC	:= getadvfval("SB1","B1_ITEMCC",xFilial("SB1")+cCodPro,1,"")
		cCdPlat	:= getadvfval("SB1","B1_PLATAF",xFilial("SB1")+cCodPro,1,"")
		cGrpRep := (cAliasSD2)->F2_YCANAL
		cACADes := getadvfval("ACA","ACA_DESCRI",xFilial("ACA")+cGrpRep,1,"")
		
		//Campos buscados do cadastro de produtos e não da tabela SD2 propositalmente
		If !(cItemCC >= mv_par16 .and. cItemCC <= mv_par17 .and. cCdPlat >= alltrim(mv_par18) .and. cCdPlat <= mv_par19)
			(cAliasSD2)->(dbSkip())
			loop
		EndIf
		
		cPlataf	:= getadvfval("SZ5","Z5_PLATRED",xFilial("SZ5")+SUBSTR(cCdPlat,1,6),1,"")
		cDescPro:= getadvfval("SB1","B1_XDESC",xFilial("SB1")+cCodPro,1,"")
		cCodcli	:= (cAliasSD2)->D2_CLIENTE
		cLjcli	:= (cAliasSD2)->D2_LOJA
		cUF		:= getadvfval("SA1","A1_EST",xFilial("SA1")+cCodcli,1,"")
		cNome	:= getadvfval("SA1","A1_NOME",xFilial("SA1")+cCodcli,1,"")
		nTaxa	:=	IIf((cAliasSD2)->(FieldPos("F2_TXMOEDA"))>0,(cAliasSD2)->F2_TXMOEDA,0)
		nMoedNF	:=	IIf((cAliasSD2)->(FieldPos("F2_MOEDA"))>0,(cAliasSD2)->F2_MOEDA,0)
		
		If AvalTes((cAliasSD2)->D2_TES,cEstoq,cDupli)
			nAdic := 0
			nValor2  := 0
			nVALICM += (cAliasSD2)->D2_VALICM //xMoeda((cAliasSD2)->D2_VALICM,1,mv_par06,(cAliasSD2)->D2_EMISSAO,nDecs+1)
			nVALIPI += (cAliasSD2)->D2_VALIPI //xMoeda((cAliasSD2)->D2_VALIPI,1,mv_par06,(cAliasSD2)->D2_EMISSAO,nDecs+1)
			nTotal	+=	xMoeda((cAliasSD2)->D2_TOTAL,nMoedNF,mv_par06,(cAliasSD2)->D2_EMISSAO,nDecs+1,nTaxa)
			nQtdVend+= (cAliasSD2)->D2_QUANT
			
			If ( nTotal <> 0 )
				cVendedor := "1"
				For nContador := 1 To nVendedor
					dbSelectArea("TRB")
					dbSetOrder(nOrdem)
					cVend := (cAliasSD2)->(FieldGet(FieldPos("F2_VEND"+cVendedor)))
					cVendedor := Soma1(cVendedor,1)
					If cCodcli >= mv_par03 .And. cCodcli <= mv_par04
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³Se vendedor em branco, considera apenas 1 vez        ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						If Empty(cVend) .and. nContador > 1
							Loop
						Endif
						
						If ( aScan(aVend,cVend)==0 )
							Aadd(aVend,cVend)
						EndIf
						If nOrdem == 1
							If (dbSeek( cCodcli+cLjcli+cGrpRep+cCodPro )) //mv_par05
								RecLock("TRB",.F.)
							Else
								RecLock("TRB",.T.)
							EndIF
						Else
							If (dbSeek( cCodcli+cGrpRep+cCodPro )) //mv_par05
								RecLock("TRB",.F.)
							Else
								RecLock("TRB",.T.)
							EndIF
						EndIF
						
						
						Replace TB_CODCLI  With cCodcli
						Replace TB_LJCLI   With cLjcli
						Replace TB_EST	   With cUF
						Replace TB_NOME	   With cNome
						Replace TB_PUBLISH With cPublish
						Replace TB_PLATRED With cPlataf
						Replace TB_COD	   With cCodPro
						Replace TB_XDESC   With cDescPro
						Replace TB_YCANAL  With cGrpRep
						Replace TB_YDCANAL With cACADes
						
						Replace TB_EMISSAO With (cAliasSD2)->F2_EMISSAO
						Replace TB_VALOR1  With TB_VALOR1+nQtdVend  //quantidade vendida
						Replace TB_VALOR2  With TB_VALOR2+IIF((cAliasSD2)->F2_TIPO == "P",0,nTotal)+nVALIPI //Valor total
						Replace TB_VALOR3  With TB_VALOR3+nVALICM //Valor ICMS
						Replace TB_VALOR4  With TB_VALOR4+(cAliasSD2)->D2_VALIMP6 //Valor PIS
						Replace TB_VALOR5  With TB_VALOR5+(cAliasSD2)->D2_VALIMP5 //Valor COFINS
						Replace TB_VALOR6  With TB_VALOR6+nVALIPI                 //Valor IPI
						Replace TB_VALOR21 With (cAliasSD2)->D2_CUSTO1/nQtdVend   //Custo Unitário
						Replace TB_DOC	   With (cAliasSD2)->F2_DOC
						
						MsUnlock()
					Endif
				Next nContador
			EndIf
		EndIf
		
		dbSelectArea(cAliasSD2)
		cSD2Old	 := (cAliasSD2)->D2_DOC+(cAliasSD2)->D2_SERIE+(cAliasSD2)->D2_CLIENTE+(cAliasSD2)->D2_LOJA+(cAliasSD2)->D2_COD+(cAliasSD2)->D2_ITEM
		
		// Considera Adicionais
		nAdic 	:= 0
		nFrete	:= (cAliasSD2)->D2_VALFRE
		nSeguro	:= (cAliasSD2)->D2_SEGURO
		nDespesa:= (cAliasSD2)->D2_DESPESA
		
		If mv_par11 == 2
			nAdic := (cAliasSD2)->D2_VALFRE+(cAliasSD2)->D2_SEGURO+(cAliasSD2)->D2_DESPESA //xMoeda((cAliasSD2)->D2_VALFRE+(cAliasSD2)->D2_SEGURO+(cAliasSD2)->D2_DESPESA,nMoedNF,mv_par06,(cAliasSD2)->F2_EMISSAO,nDecs+1,nTaxa)
		EndIf
		nValor2  := (cAliasSD2)->D2_ICMSRET //xMoeda(/*(cAliasSD2)->F2_FRETAUT+*/(cAliasSD2)->D2_ICMSRET,nMoedNF,mv_par06,(cAliasSD2)->F2_EMISSAO,nDecs+1,nTaxa)
				
		dbSkip()
		If Eof() .Or. ( (cAliasSD2)->D2_DOC+(cAliasSD2)->D2_SERIE+(cAliasSD2)->D2_CLIENTE+(cAliasSD2)->D2_LOJA+(cAliasSD2)->D2_COD+(cAliasSD2)->D2_ITEM != cSD2Old )
			//			For nContador := 1 To Len(aVend)
			dbSelectArea("TRB")
			DBGOTOP()
			If nOrdem == 1
				cChvOrd	:= cCodcli+cLjcli+cGrpRep+cCodPro
			Else
				cChvOrd	:= cCodcli+cGrpRep+cCodPro
			EndIF
			dbSetOrder(nOrdem)
			If dbSeek( cChvOrd )
				RecLock("TRB",.F.)
				TRB->TB_VALOR2	+= nValor2+nAdic
				TRB->TB_VALOR7  += nValor2 //Valor ICMS-ST
				TRB->TB_VALOR8  += nFrete   //Valor Frete
				TRB->TB_VALOR9  += nSeguro  //Valor Seguro
				TRB->TB_VALOR10 += nDespesa //Valor Despesa
				MsUnLock()
			ElseIf nValor2+nAdic+nFrete+nDespesa > 0
				RecLock("TRB",.T.)
				TRB->TB_CODCLI  := cCodcli
				TRB->TB_LJCLI   := cLjcli
				TRB->TB_EST	    := cUF
				TRB->TB_NOME	:= cNome
				TRB->TB_PUBLISH := cPublish
				TRB->TB_PLATRED := cPlataf
				TRB->TB_COD	    := cCodPro
				TRB->TB_XDESC   := cDescPro
				TRB->TB_YCANAL  := cGrpRep
				TRB->TB_YDCANAL := cACADes
				TRB->TB_VALOR2	+= nValor2+nAdic
				TRB->TB_VALOR7  += nValor2 //Valor ICMS-ST
				TRB->TB_VALOR8  += nFrete   //Valor Frete
				TRB->TB_VALOR9  += nSeguro  //Valor Seguro
				TRB->TB_VALOR10 += nDespesa //Valor Despesa
				MsUnLock()
			EndIf
			
			nValor2	:= 0
			nAdic 	:= 0
			nFrete	:= 0
			nSeguro	:= 0
			nDespesa:= 0
			//			Next nContador
			
			aVend := {}
		EndIf
		dbSelectArea(cAliasSD2)
	EndDo
	dbCloseArea()
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Processa Devolucao                                                      ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If ( MV_PAR07 == 1 )
		
		cAliasSD1:= GetNextAlias()
		
		cWhereAux 	:= ""
		cVendedor 	:= "1"
		
		cWhere += "%"
		cAddField := "%"
		If cPaisLoc == "BRA"
			For nCampo := 1 To nVendedor
				cCampo := "F2_VEND"+cVendedor
				If SF2->(FieldPos(cCampo)) > 0
					//					cWhereAux += "(" + cCampo + " between '" + mv_par03 + "' and '" + mv_par04 + "') or "
					cWhereAux += "(" + cCampo + " between '      ' and 'ZZZZZZ') or "
					cAddField += ", "  + cCampo
				EndIf
				cVendedor := Soma1(cVendedor,1)
			Next nCampo
		Else
			For nCampo := 1 To 35
				cCampo := "F1_VEND"+cVendedor
				If SF1->(FieldPos(cCampo)) > 0
					//					cWhereAux += "(" + cCampo + " between '" + mv_par03 + "' and '" + mv_par04 + "') or "
					cWhereAux += "(" + cCampo + " between '      ' and 'ZZZZZZ') or "
					cAddField += ", "  + cCampo
				EndIf
				cVendedor := Soma1(cVendedor,1)
			Next nCampo
		EndIf
		
		If Empty(cWhereAux)
			cWhere += "% NOT ("+IsRemito(2,"D1_TIPODOC")+")%"
		Else
			cWhereAux := Left(cWhereAux,Len(cWhereAux)-4)
			cWhere := "%(" + cWhereAux + " ) AND NOT ("+IsRemito(2,"D1_TIPODOC")+")%"
		EndIf
		//Alteração no where para adicionar o tratamento do novo parametro mv_par20
		cWhere := SubStr(AllTrim(cWhere),1,Len(AllTrim(cWhere))-1)
		If mv_par20 == 1
			cWhere += " AND D1_DTDIGIT between '" + DTOS(mv_par01) + "' AND '" + DTOS(mv_par02) + "' %"
		Else
			cWhere += " AND F2_EMISSAO between '" + DTOS(mv_par01) + "' AND '" + DTOS(mv_par02) + "' %"
		EndIf
		
		If SF1->(FieldPos("F1_FRETINC")) > 0
			cAddField += ", F1_FRETINC"
		EndIf
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Esta Rotina adiciona a cQuery os campos retornados na string de filtro do  |
		//³ponto de entrada MR580FIL.                                                 |
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If lMR580FIL
			aStru := SF1->(dbStruct())
			If !Empty(aFilUsrSF1[1])
				For nX := 1 To SF1->(FCount())
					cName := SF1->(FieldName(nX))
					If AllTrim( cName ) $ aFilUsrSF1[1]
						If aStru[nX,2] <> "M"
							If !cName $ cAddField
								cAddField += ","+cName
							Endif
						EndIf
					EndIf
				Next nX
			Endif
		EndIf
		cAddField += "%"
		
		oReport:Section(3):BeginQuery()
		BeginSql Alias cAliasSD1
			
			SELECT SD1.*, F1_EMISSAO, F1_DOC, F1_SERIE, F1_FORNECE, F1_LOJA, F1_FRETE, F1_DESPESA, F1_SEGURO, F1_ICMSRET,
			F1_DTDIGIT, F2_EMISSAO, F2_CLIENTE, F2_YCANAL, F2_LOJA, F1_TXMOEDA, F1_MOEDA %Exp:cAddField%
			FROM %Table:SD1% SD1, %Table:SF4% SF4, %Table:SF2% SF2, %Table:SF1% SF1
			WHERE D1_FILIAL  = %xFilial:SD1%
			//AND D1_DTDIGIT between %Exp:DTOS(mv_par01)% AND %Exp:DTOS(mv_par02)%
			AND F1_EST between %Exp:mv_par12% AND %Exp:mv_par13%
			AND F2_CLIENTE between %Exp:mv_par03% AND %Exp:mv_par04%
			AND D1_COD between %Exp:mv_par14% AND %Exp:mv_par15%
			AND D1_TIPO = 'D'
			AND F4_FILIAL  = %xFilial:SF4%
			AND F4_CODIGO  = D1_TES
			AND F2_FILIAL  = %xFilial:SF2%
			AND F2_DOC     = D1_NFORI
			AND F2_SERIE   = D1_SERIORI
			AND F2_LOJA    = D1_LOJA
			AND F1_FILIAL  = %xFilial:SF1%
			AND F1_DOC     = D1_DOC
			AND F1_SERIE   = D1_SERIE
			AND F1_FORNECE = D1_FORNECE
			AND F1_LOJA    = D1_LOJA
			AND SD1.%notdel%
			AND SF4.%notdel%
			AND SF2.%notdel%
			AND SF1.%notdel%
			AND %Exp:cWhere%
			ORDER BY D1_FILIAL,D1_FORNECE,D1_LOJA,D1_DTDIGIT,D1_DOC,D1_SERIE,D1_NUMSEQ
			//ORDER BY D1_FILIAL,D1_DTDIGIT,D1_DOC,D1_NUMSEQ
		EndSql
		oReport:Section(3):EndQuery()
		
		
		While !Eof()
			oReport:IncMeter()
			nTOTAL :=0
			nVALICM:=0
			nVALIPI:=0
			nQtdVend:= 0
			nmedia	:= 0
			cCodPro	:= (cAliasSD1)->D1_COD
			cGrpRep := (cAliasSD1)->F2_YCANAL
			cACADes := getadvfval("ACA","ACA_DESCRI",xFilial("ACA")+cGrpRep,1,"")
			cItemCC	:= getadvfval("SB1","B1_ITEMCC",xFilial("SB1")+cCodPro,1,"")
			cPublish:= getadvfval("SB1","B1_PUBLISH",xFilial("SB1")+cCodPro,1,"")
			cCdPlat	:= getadvfval("SB1","B1_PLATAF",xFilial("SB1")+cCodPro,1,"")
			cPlataf	:= getadvfval("SZ5","Z5_PLATRED",xFilial("SZ5")+SUBSTR(cCdPlat,1,6),1,"")
			cDescPro:= getadvfval("SB1","B1_XDESC",xFilial("SB1")+cCodPro,1,"")
			cCodcli	:= (cAliasSD1)->D1_FORNECE
			cLjcli	:= (cAliasSD1)->D1_LOJA
			cUF		:= getadvfval("SA1","A1_EST",xFilial("SA1")+cCodcli,1,"")
			cNome	:= getadvfval("SA1","A1_NOME",xFilial("SA1")+cCodcli,1,"")
			
			//Campos buscados do cadastro de produtos e não da tabela SD2 propositalmente
			If !(cItemCC >= mv_par16 .and. cItemCC <= mv_par17 .and. cCdPlat >= mv_par18 .and. cCdPlat <= mv_par19)
				(cAliasSD1)->(dbSkip())
				loop
			EndIf
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Se a origem for loja, ignora o filtro e mostra o registro               ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If (cAliasSD1)->D1_ORIGLAN <> "LO"
				If (cAliasSD1)->F2_CLIENTE <> (cAliasSD1)->D1_FORNECE .And. (cAliasSD1)->F2_LOJA <> (cAliasSD1)->D1_LOJA
					(cAliasSD1)->(DbSkip())
					Loop
				EndIf
			EndIf
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Processa o ponto de entrada com o filtro do usuario para devolucoes.    ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If lMR580FIL
				lFiltro := .T.
				dbSelectArea("SF1")
				dbSetOrder(1)
				MsSeek(xFilial("SF1")+(cAliasSD1)->D1_DOC+(cAliasSD1)->D1_SERIE+(cAliasSD1)->D1_FORNECE+(cAliasSD1)->D1_LOJA)
				If !Empty(aFilUsrSF1[1]).And.!&(aFilUsrSF1[1])
					dbSelectArea(cAliasSD1)
					lFiltro := .F.
				Endif
			EndIf
			
			If lFiltro
				If MV_PAR10 == 1 .Or. Empty((cAliasSD1)->F2_EMISSAO)
					DtMoedaDev  := (cAliasSD1)->F1_DTDIGIT
				Else
					DtMoedaDev  := (cAliasSD1)->F2_EMISSAO
				EndIf
				
				If AvalTes((cAliasSD1)->D1_TES,cEstoq,cDupli)
					
					nVALICM := (cAliasSD1)->D1_VALICM //xMoeda((cAliasSD1)->D1_VALICM,1,mv_par06,DtMoedaDev,nDecs+1)
					nVALIPI := (cAliasSD1)->D1_VALIPI //xMoeda((cAliasSD1)->D1_VALIPI,1,mv_par06,DtMoedaDev ,nDecs+1)
					nTOTAL  := (cAliasSD1)->D1_TOTAL - (cAliasSD1)->D1_VALDESC //xMoeda(((cAliasSD1)->D1_TOTAL - (cAliasSD1)->D1_VALDESC),1,mv_par06,DtMoedaDev,nDecs+1)
					nQtdVend:= (cAliasSD1)->D1_QUANT
					
					cVendedor := "1"
					For nContador := 1 TO nVendedor
						dbSelectArea("TRB")
						dbSetOrder(nOrdem)
						cVend := (cAliasSD1)->(FieldGet((cAliasSD1)->(FieldPos("F2_VEND"+cVendedor))))
						cVendedor := Soma1(cVendedor,1)
						If cCodcli >= MV_PAR03 .And. cCodcli <= MV_PAR04
							If Empty(cVend) .and. nContador > 1
								Loop
							EndIf
							If ( aScan(aVend,cVend) == 0 )
								AADD(aVend,cVend)
							EndIf
							If nTOTAL > 0
								If nOrdem == 1
									
									If (dbSeek( cCodcli+cLjcli+cGrpRep+cCodPro )) //mv_par05
										RecLock("TRB",.F.)
									Else
										RecLock("TRB",.T.)
										Replace TB_PUBLISH With cPublish
										Replace TB_PLATRED With cPlataf
										Replace TB_COD	   With cCodPro
										Replace TB_XDESC   With cDescPro
										Replace TB_VALOR21  With (cAliasSD1)->D1_CUSTO/nQtdVend   //Custo Unitário
										Replace TB_EST	  	With cUF   //Estado do cliente
										Replace TB_CODCLI  With cCodcli
										Replace TB_LJCLI   With cLjcli
										Replace TB_NOME	   With cNome
										Replace TB_YCANAL  With cGrpRep
										Replace TB_YDCANAL With cACADes
									EndIF
								Else
									If (dbSeek( cCodcli+cGrpRep+cCodPro )) //mv_par05
										RecLock("TRB",.F.)
									Else
										RecLock("TRB",.T.)
										Replace TB_PUBLISH With cPublish
										Replace TB_PLATRED With cPlataf
										Replace TB_COD	   With cCodPro
										Replace TB_XDESC   With cDescPro
										Replace TB_VALOR21  With (cAliasSD1)->D1_CUSTO/nQtdVend   //Custo Unitário
										Replace TB_EST	  	With cUF   //Estado do cliente
										Replace TB_CODCLI  With cCodcli
										Replace TB_LJCLI   With cLjcli
										Replace TB_NOME	   With cNome
										Replace TB_YCANAL  With cGrpRep
										Replace TB_YDCANAL With cACADes
									EndIF
								EndIF
								//									Replace TB_VEND    With cVend
								Replace TB_EMISSAO With (cAliasSD1)->F1_EMISSAO
								Replace TB_VALOR11  With TB_VALOR11-nQtdVend  //quantidade vendida
								Replace TB_VALOR12  With TB_VALOR12-nTOTAL-nVALIPI //Valor total
								Replace TB_VALOR13  With TB_VALOR13-nVALICM //Valor ICMS
								Replace TB_VALOR14  With TB_VALOR14-(cAliasSD1)->D1_VALIMP6 //Valor PIS
								Replace TB_VALOR15  With TB_VALOR15-(cAliasSD1)->D1_VALIMP5 //Valor COFINS
								Replace TB_VALOR16  With TB_VALOR16-nVALIPI //Valor IPI
								Replace TB_DOC	    With (cAliasSD1)->F1_DOC
								MsUnlock()
							EndIf
						Endif
					Next nContador
				EndIf
				dbSelectArea(cAliasSD1)
				cSD1Old := (cAliasSD1)->D1_DOC+(cAliasSD1)->D1_SERIE+(cAliasSD1)->D1_FORNECE+(cAliasSD1)->D1_LOJA+(cAliasSD1)->D1_COD+(cAliasSD1)->D1_ITEM
				// Considera Adicionais
				nFrete	:= (cAliasSD1)->D1_VALFRE
				nSeguro	:= (cAliasSD1)->D1_SEGURO
				nDespesa:= (cAliasSD1)->D1_DESPESA
				If mv_par11 == 2
					//nAdic := xMoeda((cAliasSD1)->F1_FRETE+(cAliasSD1)->F1_DESPESA+(cAliasSD1)->F1_SEGURO,1,mv_par06,DtMoedaDev,nDecs+1)
					nAdic := (cAliasSD1)->D1_VALFRE+(cAliasSD1)->D1_DESPESA+(cAliasSD1)->D1_SEGURO //xMoeda((cAliasSD1)->D1_VALFRE+(cAliasSD1)->D1_DESPESA+(cAliasSD1)->D1_SEGURO,1,mv_par06,DtMoedaDev,nDecs+1)
				EndIf
				//nValor12	:= xMoeda((cAliasSD1)->F1_ICMSRET,1,mv_par06,DtMoedaDev,nDecs+1)
				nValor12	:= (cAliasSD1)->D1_ICMSRET //xMoeda((cAliasSD1)->D1_ICMSRET,1,mv_par06,DtMoedaDev,nDecs+1)
			EndIf
			
			dbSelectArea(cAliasSD1)
			dbSkip()
			
			If lFiltro
				If Eof() .Or. ( (cAliasSD1)->D1_DOC+(cAliasSD1)->D1_SERIE+(cAliasSD1)->D1_FORNECE+(cAliasSD1)->D1_LOJA+(cAliasSD1)->D1_COD+(cAliasSD1)->D1_ITEM != cSD1Old)
					//					FOR nContador := 1 TO Len(aVend)
					dbSelectArea("TRB")
					DBGOTOP()
					If nOrdem == 1
						cChvOrd	:= cCodcli+cLjcli+cGrpRep+cCodPro
					Else
						cChvOrd	:= cCodcli+cGrpRep+cCodPro
					EndIf
					dbSetOrder(nOrdem)
					If dbSeek( cChvOrd ) //mv_par05
						RecLock("TRB",.F.)
						Replace TB_PUBLISH  With cPublish
						Replace TB_PLATRED  With cPlataf
						Replace TB_COD	    With cCodPro
						Replace TB_XDESC    With cDescPro
						Replace TB_VALOR12  With TB_VALOR12-nValor12
						Replace TB_VALOR17  With TB_VALOR17-nValor12 //Valor ICMS-ST
						Replace TB_VALOR18  With TB_VALOR18-nFrete //Valor Frete
						Replace TB_VALOR19  With TB_VALOR19-nSeguro //Valor Seguro
						Replace TB_VALOR20  With TB_VALOR20-nDespesa //Valor Despesa
						MsUnlock()
					ElseIf nValor12+nSeguro+nFrete+nDespesa > 0
						RecLock("TRB",.T.)
						
						If nOrdem == 1
							Replace TB_LJCLI   With cLjcli
						EndIf
						Replace TB_PUBLISH With cPublish
						Replace TB_PLATRED With cPlataf
						Replace TB_COD	   With cCodPro
						Replace TB_XDESC   With cDescPro
						Replace TB_VALOR21  With (cAliasSD1)->D1_CUSTO/nQtdVend   //Custo Unitário
						Replace TB_EST	  	With cUF   //Estado do cliente
						Replace TB_CODCLI  With cCodcli
						Replace TB_NOME	   With cNome
						Replace TB_YCANAL  With cGrpRep
						Replace TB_YDCANAL With cACADes
						
						Replace TB_PUBLISH  With cPublish
						Replace TB_PLATRED  With cPlataf
						Replace TB_COD	    With cCodPro
						Replace TB_XDESC    With cDescPro
						Replace TB_VALOR12  With TB_VALOR12-nValor12
						Replace TB_VALOR17  With TB_VALOR17-nValor12 //Valor ICMS-ST
						Replace TB_VALOR18  With TB_VALOR18-nFrete //Valor Frete
						Replace TB_VALOR19  With TB_VALOR19-nSeguro //Valor Seguro
						Replace TB_VALOR20  With TB_VALOR20-nDespesa //Valor Despesa
						MsUnlock()
					EndIf

					nValor12	:= 0
					nAdic 		:= 0
					nFrete		:= 0
					nSeguro		:= 0
					nDespesa	:= 0

					//					Next nContador
					aVend:={}
				EndIf
			EndIf
			dbSelectArea(cAliasSD1)
		EndDo
		dbCloseArea()
	EndIf
	
#ELSE
	
#ENDIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impressao do Relatorio                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("TRB")

dbSetOrder(4)


If len(oReport:Section(1):GetAdvplExp("SA3")) > 0
	cFilSA3 := oReport:Section(1):GetAdvplExp("SA3")
EndIf

//dbGoBottom()
dbgotop()
cNFiscal := TRB->TB_DOC
oReport:section(1):Init()
oReport:SetMeter(LastRec())
While !eof() //!Bof()
	

	NFATORDV := BUSCASZE(TRB->TB_CODCLI,TRB->TB_LJCLI,TRB->TB_YCANAL,mv_par01,mv_par02)

	oReport:IncMeter()
	//	cVend := TRB->TB_VEND
	cCodcli	:= TRB->TB_CODCLI
	cLjcli	:= TRB->TB_LJCLI
	cNome	:= TRB->TB_NOME
	cUF		:= TRB->TB_EST
	cPublish:= TRB->TB_PUBLISH
	cPlataf := TRB->TB_PLATRED
	cCodPro := TRB->TB_COD
	cDescPro:= TRB->TB_XDESC
	nValLiq := TRB->(TB_VALOR2+TB_VALOR12)-TRB->(TB_VALOR3+TB_VALOR4+TB_VALOR5+TB_VALOR6+TB_VALOR7+TB_VALOR8+TB_VALOR9+TB_VALOR10+TB_VALOR13+TB_VALOR14+TB_VALOR15+TB_VALOR16+TB_VALOR17)
	NVALMGR	:= nValLiq-(TRB->(TB_VALOR21*(TB_VALOR1+TB_VALOR11)))
	NPERMGR	:= NVALMGR/nValLiq
	NMARKUP	:= (TRB->(TB_VALOR2+TB_VALOR12))/(TRB->(TB_VALOR21*(TB_VALOR1+TB_VALOR11)))
	NVALDV	:= TRB->(TB_VALOR2+TB_VALOR12)*-(NFATORDV/100)
//	NPERDV	:= (NVALDV/nValLiq)
	NVALMC	:= NVALMGR+NVALDV
	NPERMC	:= (NVALMC/nValLiq)
		
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica filtro de usuario                                   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("SA3")
	dbSeek(xFilial()+cVend)
	If !Empty(cFilSA3) .And. !(&cFilSA3)
		dbSelectArea("TRB")
		dbSkip() //dbSkip(-1)
		Loop
	EndIf
	
	dbSelectArea("TRB")
	If MV_PAR05 == 1
		oReport:Section(1):Cell("CLJCLI"):Disable()
		oReport:Section(1):Cell("CUF"):Disable()
	EndIf
	If MV_PAR07 <> 1
		oReport:Section(1):Cell("TB_VALOR11"):Disable()
		oReport:Section(1):Cell("TB_VALOR12"):Disable()
		oReport:Section(1):Cell("TB_VALOR13"):Disable()
		oReport:Section(1):Cell("TB_VALOR14"):Disable()
		oReport:Section(1):Cell("TB_VALOR15"):Disable()
		oReport:Section(1):Cell("TB_VALOR16"):Disable()
		oReport:Section(1):Cell("TB_VALOR17"):Disable()
		oReport:Section(1):Cell("TB_VALOR18"):Disable()
		oReport:Section(1):Cell("TB_VALOR19"):Disable()
		oReport:Section(1):Cell("TB_VALOR20"):Disable()
	EndIf
	
	oReport:section(1):PrintLine()
	
	cNFiscal := TRB->TB_DOC
	dbSkip()
	//	dbSkip(-1)
EndDo

oReport:Section(1):PageBreak()

dbSelectArea( "TRB" )
dbCloseArea()
fErase(cNomArq+GetDBExtension())
fErase(cNomArq1+OrdBagExt())
fErase(cNomArq2+OrdBagExt())
fErase(cNomArq3+OrdBagExt())
fErase(cNomArq4+OrdBagExt())

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Restaura a integridade dos dados                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SF2")
dbClearFilter()
dbSetOrder(1)


Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³AjustaSX1 ³ Autor ³Marco Bianchi          ³ Data ³10/11/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Acerta o arquivo de perguntas                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao Efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function AjustaSx1()
Local aArea := GetArea()
Local aHelpP11	:= {}
Local aHelpE11	:= {}
Local aHelpS11	:= {}

Aadd( aHelpP11, "Considera faturamento a partir da data ?" )
PutSx1("FATMRG","01","A partir da data ?" ,"","","mv_ch1","D",8,0,,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",aHelpP11,aHelpE11,aHelpS11)
aHelpP11	:= {}

Aadd( aHelpP11, "Considera faturamento até a data ?" )
PutSx1("FATMRG","02","Até a data ?" ,"","","mv_ch2","D",8,0,,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",aHelpP11,aHelpE11,aHelpS11)
aHelpP11	:= {}

Aadd( aHelpP11, "Do cliente ?" )
PutSx1("FATMRG","03","Do cliente ?" ,"","","mv_ch3","C",6,0,,"G","","SB1","001","","mv_par03","","","","","","","","","","","","","","","","",aHelpP11,aHelpE11,aHelpS11)
aHelpP11	:= {}

Aadd( aHelpP11, "Até o cliente ?" )
PutSx1("FATMRG","04","Até o cliente ?" ,"","","mv_ch4","C",6,0,,"G","","SB1","001","","mv_par04","","","","","","","","","","","","","","","","",aHelpP11,aHelpE11,aHelpS11)
aHelpP11	:= {}

Aadd( aHelpP11, "Deseja aglutinar os dados por rede de lojas ?" )
PutSx1("FATMRG","05","Aglutina por rede de lojas ?" ,"","","mv_ch5","N",1,0,1,"C","","","","","mv_par05","Sim","Si","Yes","","Não","No","No","","","","","","","","","",aHelpP11,aHelpE11,aHelpS11)
aHelpP11	:= {}

Aadd( aHelpP11, "Qual a Moeda ?" )
PutSx1("FATMRG","06","Qual a Moeda ?" ,"","","mv_ch6","N",1,0,1,"C","","","","","mv_par06","1a Moeda","1a Moeda","1a Moeda","","2a Moeda","2a Moeda","2a Moeda","3a Moeda","3a Moeda","3a Moeda","4a Moeda","4a Moeda","4a Moeda","5a Moeda","5a Moeda","5a Moeda",aHelpP11,aHelpE11,aHelpS11)
aHelpP11	:= {}

Aadd( aHelpP11, "Considera Devoluções ?" )
PutSx1("FATMRG","07","Considera Devoluções ?" ,"","","mv_ch7","N",1,0,1,"C","","","","","mv_par07","Sim","Si","Yes","","Não","No","No","","","","","","","","","",aHelpP11,aHelpE11,aHelpS11)
aHelpP11	:= {}

Aadd( aHelpP11, "TES Qto Faturamento ?" )
PutSx1("FATMRG","08","TES Qto Faturamento ?" ,"","","mv_ch8","N",1,0,1,"C","","","","","mv_par08","Gera","Gera","Gera","","Não gera","Não gera","Não gera","Considera Ambas","Considera Ambas","Considera Ambas","","","","","","",aHelpP11,aHelpE11,aHelpS11)
aHelpP11	:= {}

Aadd( aHelpP11, "TES Qto Estoque ?" )
PutSx1("FATMRG","09","TES Qto Estoque ?" ,"","","mv_ch9","N",1,0,1,"C","","","","","mv_par09","Movimenta","Movimenta","Movimenta","","Não movimenta","Não movimenta","Não movimenta","Considera Ambas","Considera Ambas","Considera Ambas","","","","","","",aHelpP11,aHelpE11,aHelpS11)
aHelpP11	:= {}

Aadd( aHelpP11, "Converte Moeda da Devolução por ?" )
PutSx1("FATMRG","10","Converte Moeda da Devolução ?" ,"","","mv_cha","N",1,0,1,"C","","","","","mv_par10","Pela devolução","Pela devolução","Pela devolução","","Pela Dt.NF Orig","Pela Dt.NF Orig","Pela Dt.NF Orig","","","","","","","","","",aHelpP11,aHelpE11,aHelpS11)
aHelpP11	:= {}

Aadd( aHelpP11, "Desconsidera os valores de frete, seguro" )
Aadd( aHelpP11, "e despesa no valor total.       " )
PutSx1("FATMRG","11","Desconsidera adicionais ?" ,"","","mv_chb","N",1,0,2,"C","","","","","mv_par11","Sim","Si","Yes","","Não","No","No","","","","","","","","","",aHelpP11,aHelpE11,aHelpS11)
aHelpP11	:= {}

Aadd( aHelpP11, "Considera clientes do Estado (UF) ?" )
PutSx1("FATMRG","12","Do Estado ?" ,"","","mv_chc","C",2,0,,"G","","12","","","mv_par12","","","","","","","","","","","","","","","","",aHelpP11,aHelpE11,aHelpS11)
aHelpP11	:= {}

Aadd( aHelpP11, "Considera clientes até o Estado (UF) ?" )
PutSx1("FATMRG","13","Até o Estado ?" ,"","","mv_chd","C",2,0,,"G","","12","","","mv_par13","","","","","","","","","","","","","","","","",aHelpP11,aHelpE11,aHelpS11)
aHelpP11	:= {}

Aadd( aHelpP11, "Considera os produtos de ?" )
PutSx1("FATMRG","14","Do produto ?" ,"","","mv_che","C",15,0,,"G","","SB1","","","mv_par14","","","","","","","","","","","","","","","","",aHelpP11,aHelpE11,aHelpS11)
aHelpP11	:= {}

Aadd( aHelpP11, "Considera os produtos até ?" )
PutSx1("FATMRG","15","Até o produto ?" ,"","","mv_chf","C",15,0,,"G","","SB1","","","mv_par15","","","","","","","","","","","","","","","","",aHelpP11,aHelpE11,aHelpS11)
aHelpP11	:= {}

Aadd( aHelpP11, "Considera o Publisher de ?" )
PutSx1("FATMRG","16","Do Publisher ?" ,"","","mv_chg","C",9,0,,"G","","CTD","","","mv_par16","","","","","","","","","","","","","","","","",aHelpP11,aHelpE11,aHelpS11)
aHelpP11	:= {}

Aadd( aHelpP11, "Considera o Publisher até ?" )
PutSx1("FATMRG","17","Até o Publisher ?" ,"","","mv_chh","C",9,0,,"G","","CTD","","","mv_par17","","","","","","","","","","","","","","","","",aHelpP11,aHelpE11,aHelpS11)
aHelpP11	:= {}

Aadd( aHelpP11, "Considera produtos da Plataforma ?" )
PutSx1("FATMRG","18","Da Plataforma ?" ,"","","mv_chi","C",10,0,,"G","","SZ5","","","mv_par18","","","","","","","","","","","","","","","","",aHelpP11,aHelpE11,aHelpS11)
aHelpP11	:= {}

Aadd( aHelpP11, "Considera produtos até a Plataforma ?" )
PutSx1("FATMRG","19","Até a Plataforma ?" ,"","","mv_chj","C",10,0,,"G","","SZ5","","","mv_par19","","","","","","","","","","","","","","","","",aHelpP11,aHelpE11,aHelpS11)
aHelpP11	:= {}

Aadd( aHelpP11, "Informe o tipo de apuracao" )
Aadd( aHelpP11, "dos dados.       " )
PutSx1("FATMRG","20","Calculo Devoluções" ,"","","mv_chk","N",1,0,1,"C","","","","","mv_par20","Dt.de Digitacao","la fecha de escribir","Date of typing","","Dt. NF original","la fecha del original NF","Date NF original","","","","","","","","","",aHelpP11,aHelpE11,aHelpS11)
aHelpP11	:= {}
RestArea(aArea)

Return



/*BEGINDOC
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Busca fator das despesas variáveis³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ENDDOC*/

Static Function BUSCASZE(CODCLI,LJCLI,YCANAL,DINI,DFIM)

Local nFatVar	:= 0

cArqTRB	:= CriaTrab(,.F.)		//Nome do arq. temporario
				
cQry	:= " SELECT ZE_FILIAL, ZE_COD, ZE_CLIENTE, ZE_LOJA, ZE_CANAL, ZE_DTINI, ZE_DTFIM, 
cQry	+= " SUM(ZE_DESP01+ZE_DESP02+ZE_DESP03+ZE_DESP04+ZE_DESP05+ZE_DESP06+ZE_DESP07) TOTALDESP
cQry	+= " FROM SZE010 SZE
cQry	+= " WHERE SZE.D_E_L_E_T_ = ' '
cQry	+= " AND SZE.ZE_FILIAL = '"+xFilial("SZE")+"'
cQry	+= " AND SZE.ZE_DTFIM >= '"+dtos(DFIM)+"'
cQry	+= " AND SZE.ZE_DTINI <= '"+dtos(DINI)+"'
cQry	+= " AND ((SZE.ZE_CLIENTE = ' ' AND SZE.ZE_LOJA = ' ' AND SZE.ZE_CANAL = '"+YCANAL+"')
cQry	+= " OR (SZE.ZE_CLIENTE = '"+CODCLI+"' AND SZE.ZE_LOJA = ' ' AND SZE.ZE_CANAL = '"+YCANAL+"')
cQry	+= " OR (SZE.ZE_CLIENTE = '"+CODCLI+"' AND SZE.ZE_LOJA = '"+LJCLI+"' AND SZE.ZE_CANAL = '"+YCANAL+"'))
cQry	+= " GROUP BY ZE_FILIAL, ZE_COD, ZE_CLIENTE, ZE_LOJA, ZE_CANAL, ZE_DTINI, ZE_DTFIM
cQry	+= " ORDER BY ZE_CLIENTE DESC, ZE_LOJA DESC, ZE_CANAL DESC
cQry := ChangeQuery(cQry)
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),"cArqTRB",.T.,.T.)

DbSelectArea("cArqTRB")
cArqTRB->(dbgotop())
While !Eof() 
	If cArqTRB->TOTALDESP > 0 
		nFatVar := cArqTRB->TOTALDESP
		Exit
	EndIf
	cArqTRB->(dbskip())
End
DbSelectArea("cArqTRB")
dbclosearea()

Return nFatVar

