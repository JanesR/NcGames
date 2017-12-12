#INCLUDE "MATR590.CH" 
#INCLUDE "FIVEWIN.CH"   

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ NC_MATR590³ Autor ³ Marco Bianchi         ³ Data ³ 27/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Faturamento por Cliente                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ SIGAFAT - R4                                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function NC590MTR()

Local oReport

	//-- Interface de impressao
	oReport := ReportDef()
	oReport:PrintDialog()

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Marco Bianchi         ³ Data ³ 27/06/06 ³±±
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
Local oFatCli
Local nRank		:= 0

Private cNomArq := ""
Private nvalor1 := 0
Private nvalor2 := 0
Private nvalor3 := 0
Private nvalor4 := 0
Private nvalor5 := 0
Private nvalor6 := 0
Private nvalor7 := 0
Private nvalor8 := 0
Private nvalor9 := 0
Private nval01  := 0
Private nval02  := 0
Private nval03  := 0
Private nval04  := 0
Private nval05  := 0
Private nval06  := 0
Private nval07  := 0
Private nval08  := 0
Private nval09  := 0

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
oReport := TReport():New("NC590MTR",STR0017,"MTR590", {|oReport| ReportPrint(oReport,oFatCli)},STR0018 + " " + STR0019 + " " + STR0020)	// "Faturamento por Cliente"###"Este relatorio emite a relacao de faturamento. Podera ser"###"emitido por ordem de Cliente ou por Valor (Ranking).     "###"Se no TES estiver gera duplicata (N), nao sera computado."
oReport:SetPortrait() 
oReport:SetTotalInLine(.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ajusta grupo de perguntas 									 		   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
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
//³ExpL7 : Informe se o tamanho esta em pixel                              ³
//³        Default : False                                                 ³
//³ExpB8 : Bloco de código para impressao.                                 ³
//³        Default : ExpC2                                                 ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Secao detalhes - Section(1)  								 		   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oFatCli := TRSection():New(oReport,STR0031,{"SF2","SA1","TRB"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)	// "Faturamento por Cliente"
oFatCli:SetTotalInLine(.F.)
TRCell():New(oFatCli,"TB_CLI"		,cNomArq,RetTitle("A1_COD")	,PesqPict("SA1","A1_COD"	)	,TamSx3("A1_COD")		[1]	,/*lPixel*/,{|| (cNomArq)->TB_CLI })			// "Codigo"
TRCell():New(oFatCli,"TB_LOJA"		,cNomArq,RetTitle("A1_LOJA"),PesqPict("SA1","A1_LOJA"	)	,TamSx3("A1_LOJA")		[1]	,/*lPixel*/,{|| (cNomArq)->TB_LOJA })			// "Loja"
TRCell():New(oFatCli,"A1_NOME"		,"SA1"	,RetTitle("A1_NOME"),PesqPict("SA1","A1_NOME"	)	,TamSx3("A1_NOME")		[1]	,/*lPixel*/,/*{|| code-block de impressao }*/)	// "Razao Social"
TRCell():New(oFatCli,"TB_VALOR1"	,cNomArq,STR0021			,PesqPict("SF2","F2_VALBRUT")	,TamSx3("F2_VALBRUT")	[1]	,/*lPixel*/,{|| (cNomArq)->TB_VALOR1 })		// "Faturamento sem ICMS"
TRCell():New(oFatCli,"TB_VALOR2"	,cNomArq,STR0022			,PesqPict("SF2","F2_VALBRUT")	,TamSx3("F2_VALBRUT")	[1]	,/*lPixel*/,{|| (cNomArq)->TB_VALOR2 })		// "Valor da Mercadoria"
TRCell():New(oFatCli,"TB_VALOR3"	,cNomArq,STR0023			,PesqPict("SF2","F2_VALBRUT")	,TamSx3("F2_VALBRUT")	[1]	,/*lPixel*/,{|| (cNomArq)->TB_VALOR3 })		// "Valor Total"
TRCell():New(oFatCli,"TB_VALOR4"	,cNomArq,STR0021			,PesqPict("SF2","F2_VALBRUT")	,TamSx3("F2_VALBRUT")	[1]	,/*lPixel*/,{|| (cNomArq)->TB_VALOR4*-1 })		// "Faturamento sem ICMS"
TRCell():New(oFatCli,"TB_VALOR5"	,cNomArq,STR0022			,PesqPict("SF2","F2_VALBRUT")	,TamSx3("F2_VALBRUT")	[1]	,/*lPixel*/,{|| (cNomArq)->TB_VALOR5*-1 })		// "Valor da Mercadoria"
TRCell():New(oFatCli,"TB_VALOR6"	,cNomArq,STR0023			,PesqPict("SF2","F2_VALBRUT")	,TamSx3("F2_VALBRUT")	[1]	,/*lPixel*/,{|| (cNomArq)->TB_VALOR6*-1 })		// "Valor Total"
TRCell():New(oFatCli,"TB_VALOR7"	,cNomArq,"Quantidade"		,PesqPict("SF2","F2_VALBRUT")	,TamSx3("F2_VALBRUT")	[1]	,/*lPixel*/,{|| (cNomArq)->TB_VALOR7 })		// "Quantidade"
TRCell():New(oFatCli,"TB_VALOR8"	,cNomArq,"Media"			,PesqPict("SF2","F2_VALBRUT")	,TamSx3("F2_VALBRUT")	[1]	,/*lPixel*/,{|| ((cNomArq)->TB_VALOR3+(cNomArq)->TB_VALOR6*-1)/((cNomArq)->TB_VALOR7+(cNomArq)->TB_VALOR9*-1) })		// "Media"
TRCell():New(oFatCli,"TB_VALOR9"	,cNomArq,"Quantidade"		,PesqPict("SF2","F2_VALBRUT")	,TamSx3("F2_VALBRUT")	[1]	,/*lPixel*/,{|| (cNomArq)->TB_VALOR9*-1 })		// "Quantidade"
TRCell():New(oFatCli,"TB_RANKIN"	,cNomArq,STR0024			,"@E 9999"						,4							,/*lPixel*/,{|| (cNomArq)->TB_RANKIN })		// "Ranking"
TRCell():New(oFatCli,"TB_TIPO" 		,cNomArq,"Tipo"				,/*Picture*/					,/*Tamanho*/				,/*lPixel*/,{|| (cNomArq)->TB_TIPO })			// Se Devolucao imprime "DEV"
                           
oFatCli:Cell("TB_VALOR1"):SetHeaderAlign("RIGHT") 
oFatCli:Cell("TB_VALOR2"):SetHeaderAlign("RIGHT") 
oFatCli:Cell("TB_VALOR3"):SetHeaderAlign("RIGHT") 
oFatCli:Cell("TB_VALOR4"):SetHeaderAlign("RIGHT") 
oFatCli:Cell("TB_VALOR5"):SetHeaderAlign("RIGHT") 
oFatCli:Cell("TB_VALOR6"):SetHeaderAlign("RIGHT") 
oFatCli:Cell("TB_VALOR7"):SetHeaderAlign("RIGHT") 
oFatCli:Cell("TB_VALOR8"):SetHeaderAlign("RIGHT") 
oFatCli:Cell("TB_VALOR9"):SetHeaderAlign("RIGHT") 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Secao Totalizadora Faturamento - Section(2)  		    			   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oTotal := TRSection():New(oReport,STR0032,"",/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)	// "Faturamento por Cliente"
oTotal:SetTotalInLine(.F.)
oTotal:SetEdit(.F.)
TRCell():New(oTotal,"CCLI"		,/*Tabela*/,RetTitle("A1_COD")	,PesqPict("SA1","A1_COD"	),TamSx3("A1_COD")		[1]	,/*lPixel*/,/*{|| code-block de impressao }*/)	
TRCell():New(oTotal,"CLOJA"		,cNomArq,RetTitle("A1_LOJA")	,PesqPict("SA1","A1_LOJA"	),TamSx3("A1_LOJA")		[1]	,/*lPixel*/,/*{|| code-block de impressao }*/)			// "Loja"
TRCell():New(oTotal,"CNOME"		,/*Tabela*/,RetTitle("A1_NOME")	,PesqPict("SA1","A1_NOME"	),TamSx3("A1_NOME")		[1]	,/*lPixel*/,/*{|| code-block de impressao }*/)	
TRCell():New(oTotal,"NVALOR1"	,/*Tabela*/,STR0021				,PesqPict("SF2","F2_VALBRUT"),TamSx3("F2_VALBRUT")	[1]	,/*lPixel*/,{|| NVAL01 })	// "Faturamento sem ICMS"
TRCell():New(oTotal,"NVALOR2"	,/*Tabela*/,STR0022				,PesqPict("SF2","F2_VALBRUT"),TamSx3("F2_VALBRUT")	[1]	,/*lPixel*/,{|| NVAL02 })	// "Valor da Mercadoria"
TRCell():New(oTotal,"NVALOR3"	,/*Tabela*/,STR0023				,PesqPict("SF2","F2_VALBRUT"),TamSx3("F2_VALBRUT")	[1]	,/*lPixel*/,{|| NVAL03 })	// "Valor Total"
TRCell():New(oTotal,"NVALOR7"	,/*Tabela*/,"Quantidade"		,PesqPict("SF2","F2_VALBRUT"),TamSx3("F2_VALBRUT")	[1]	,/*lPixel*/,{|| NVAL07 })	// "Quantidade"
TRCell():New(oTotal,"NRANK"		,cNomArq,STR0024				,"@E 9999"					 ,4							,/*lPixel*/,/*{|| (cNomArq)->TB_RANKIN }*/)		// "Ranking"
//TRCell():New(oTotal,"NVALOR8"	,/*Tabela*/,"Media"				,PesqPict("SF2","F2_VALBRUT"),TamSx3("F2_VALBRUT")	[1]	,/*lPixel*/,{|| NVAL03/NVAL07 })	// "Media"

oTotal:Cell("NVALOR1"):SetHeaderAlign("RIGHT") 
oTotal:Cell("NVALOR2"):SetHeaderAlign("RIGHT") 
oTotal:Cell("NVALOR3"):SetHeaderAlign("RIGHT") 
oTotal:Cell("NVALOR7"):SetHeaderAlign("RIGHT") 
oTotal:Cell("NRANK"):SetHeaderAlign("RIGHT") 
//oTotal:Cell("NVALOR8"):SetHeaderAlign("RIGHT") 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Secao Totalizadora Devolucoes - Section(3)  		    			   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oDev := TRSection():New(oReport,STR0033,"",/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)	// "Faturamento por Cliente"
oDev:SetTotalInLine(.F.)
oDev:SetEdit(.F.)
TRCell():New(oDev,"CCLI"	,/*Tabela*/,RetTitle("A1_COD")	,PesqPict("SA1","A1_COD"	)	,TamSx3("A1_COD")	 	[1]	,/*lPixel*/,/*{|| code-block de impressao }*/)	// "Codigo"
TRCell():New(oDev,"CLOJA"	,/*Tabela*/,RetTitle("A1_LOJA")	,PesqPict("SA1","A1_LOJA"	)	,TamSx3("A1_COD")	 	[1]	,/*lPixel*/,/*{|| code-block de impressao }*/)	// "Loja"
TRCell():New(oDev,"CNOME"	,/*Tabela*/,RetTitle("A1_NOME")	,PesqPict("SA1","A1_NOME"	)	,TamSx3("A1_NOME")	  	[1]	,/*lPixel*/,/*{|| code-block de impressao }*/)	// "Razao Social"
TRCell():New(oDev,"NVALOR4"	,/*Tabela*/,STR0021				,PesqPict("SF2","F2_VALBRUT")	,TamSx3("F2_VALBRUT")	[1]	,/*lPixel*/,{|| NVAL04*-1 })	// "Faturamento sem ICMS"
TRCell():New(oDev,"NVALOR5"	,/*Tabela*/,STR0022				,PesqPict("SF2","F2_VALBRUT")	,TamSx3("F2_VALBRUT")	[1]	,/*lPixel*/,{|| NVAL05*-1 })	// "Valor da Mercadoria"
TRCell():New(oDev,"NVALOR6"	,/*Tabela*/,STR0023				,PesqPict("SF2","F2_VALBRUT")	,TamSx3("F2_VALBRUT")	[1]	,/*lPixel*/,{|| NVAL06*-1 })	// "Valor Total"
TRCell():New(oDev,"NVALOR9"	,/*Tabela*/,"Quantidade"		,PesqPict("SF2","F2_VALBRUT")	,TamSx3("F2_VALBRUT")	[1]	,/*lPixel*/,{|| NVAL09*-1 })	// "Quantidade"
//TRCell():New(oDev,"NVALOR8"	,/*Tabela*/,"Media"				,PesqPict("SF2","F2_VALBRUT")	,TamSx3("F2_VALBRUT")	[1]	,/*lPixel*/,/*{|| (NVAL06*-1)/(NVAL09*-1) }*/)	// "Media"
//TRCell():New(oDev,"NRANK"	,/*Tabela*/,STR0024				,"@E 9999"						 ,4							,/*lPixel*/,/*{|| (cNomArq)->TB_RANKIN }*/)		// "Ranking"
TRCell():New(oDev,"CDEV"	,/*Tabela*/,"Tipo"			  	,/*Picture*/ 					,/*Tamanho*/ 						,/*lPixel*/,{|| "DEV" })	// "Valor Total"

oDev:Cell("NVALOR4"):SetHeaderAlign("RIGHT") 
oDev:Cell("NVALOR5"):SetHeaderAlign("RIGHT") 
oDev:Cell("NVALOR6"):SetHeaderAlign("RIGHT") 
oDev:Cell("NVALOR9"):SetHeaderAlign("RIGHT") 
//oDev:Cell("NVALOR8"):SetHeaderAlign("RIGHT") 
//oDev:Cell("NRANK")  :SetHeaderAlign("RIGHT") 
                           

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Secao Totalizadora (Fat-Dev) - Section(4)    		    			   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oTotGer := TRSection():New(oReport,STR0034,"",/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)	// "Faturamento por Cliente"
oTotGer:SetTotalInLine(.F.)
oTotGer:SetEdit(.F.)
TRCell():New(oTotGer,"CCLI"		,/*Tabela*/,RetTitle("A1_COD")	,PesqPict("SA1","A1_COD"	)	,TamSx3("A1_COD")		[1]	,/*lPixel*/,/*{|| code-block de impressao }*/)	// "Codigo"
TRCell():New(oTotGer,"CLOJA"	,/*Tabela*/,RetTitle("A1_LOJA")	,PesqPict("SA1","A1_LOJA"	)	,TamSx3("A1_LOJA")		[1]	,/*lPixel*/,/*{|| code-block de impressao }*/)	// "Loja"
TRCell():New(oTotGer,"CNOME"	,/*Tabela*/,RetTitle("A1_NOME")	,PesqPict("SA1","A1_NOME"	)	,TamSx3("A1_NOME")		[1]	,/*lPixel*/,/*{|| code-block de impressao }*/)	// "Razao Social"
TRCell():New(oTotGer,"NVALOR1"	,/*Tabela*/,STR0021				,PesqPict("SF2","F2_VALBRUT")	,TamSx3("F2_VALBRUT")	[1]	,/*lPixel*/,{|| NVAL01-NVAL04 })	// "Faturamento sem ICMS"
TRCell():New(oTotGer,"NVALOR2"	,/*Tabela*/,STR0022				,PesqPict("SF2","F2_VALBRUT")	,TamSx3("F2_VALBRUT")	[1]	,/*lPixel*/,{|| NVAL02-NVAL05 })	// "Valor da Mercadoria"
TRCell():New(oTotGer,"NVALOR3"	,/*Tabela*/,STR0023				,PesqPict("SF2","F2_VALBRUT")	,TamSx3("F2_VALBRUT")	[1]	,/*lPixel*/,{|| NVAL03-NVAL06 })	// "Valor Total"
TRCell():New(oTotGer,"NVALOR7"	,/*Tabela*/,"Quantidade"		,PesqPict("SF2","F2_VALBRUT")	,TamSx3("F2_VALBRUT")	[1]	,/*lPixel*/,{|| NVAL07-NVAL09 })	// "Quantidade"
TRCell():New(oTotGer,"NVALOR8"	,/*Tabela*/,"Media"				,PesqPict("SF2","F2_VALBRUT")	,TamSx3("F2_VALBRUT")	[1]	,/*lPixel*/,/*{|| (NVAL03-NVAL06)/(NVAL07-NVAL09) }*/)	// "Media"
TRCell():New(oTotGer,"NRANK"	,/*Tabela*/,STR0024				,"@E 9999"						 ,4							,/*lPixel*/,/*{|| (cNomArq)->TB_RANKIN }*/)		// "Ranking"
TRCell():New(oTotGer,"CABAT"		,/*Tabela*/,"Tipo"			  				,/*Picture*/ 						,/*Tamanho*/ 						,/*lPixel*/,{|| IIf(mv_par12 == 1,"ABT","") })	

oTotGer:Cell("NVALOR1"):SetHeaderAlign("RIGHT") 
oTotGer:Cell("NVALOR2"):SetHeaderAlign("RIGHT") 
oTotGer:Cell("NVALOR3"):SetHeaderAlign("RIGHT") 
oTotGer:Cell("NVALOR7"):SetHeaderAlign("RIGHT") 
oTotGer:Cell("NVALOR8"):SetHeaderAlign("RIGHT") 
oTotGer:Cell("NRANK")  :SetHeaderAlign("RIGHT") 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Nao imprime cabecaho da secao                 	    			       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:Section(2):SetHeaderSection(.F.)
oReport:Section(3):SetHeaderSection(.F.)
oReport:Section(4):SetHeaderSection(.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Posiciona Cadastro de Clientes antes da impressao de cada linha		   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
TRPosition():New(oReport:Section(1),"SA1",1,{|| xFilial("SA1")+(cNomArq)->TB_CLI+(cNomArq)->TB_LOJA })

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impressao do Cabecalho no top da pagina                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:Section(1):SetHeaderPage()


Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³ Marco Bianchi         ³ Data ³27/06/2006³±±
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
Static Function ReportPrint(oReport,oFatCli)

Local cEstoq   := If( (MV_PAR11== 1),"S",If( (MV_PAR11== 2),"N","SN" ) )
Local cDupli   := If( (MV_PAR10== 1),"S",If( (MV_PAR10== 2),"N","SN" ) )
Local aCampos  := {}
Local aTam	   := {}
Local nMoeda   := mv_par08

Private nDecs	:= msdecimais(mv_par08)
Private aCodCli := {}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Altera o Titulo do Relatorio de acordo com parametros	 	 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
// Lista por: 1=Cliente, 2=Ranking, 3=Estado
oReport:SetTitle(oReport:Title() + " " + IIF(mv_par07 == 1,STR0026,IIF(mv_par07 == 2,STR0027,STR0028)) + " - "  + GetMv("MV_MOEDA"+STR(mv_par08,1)) )		// "Faturamento por Vendedor"###"(Ordem Decrescente por Vendedor)"###"(Por Ranking)"

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Totalizadores da Secao                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
TRFunction():New(oFatCli:Cell("TB_VALOR1"),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,{|| nValor1 - nValor4},IIf(mv_par12 == 1 .or. mv_par07 == 3,.T.,.F.) /*lEndSection*/,.F./*lEndReport*/,/*lEndPage*/)
TRFunction():New(oFatCli:Cell("TB_VALOR2"),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,{|| nValor2 - nValor5},IIf(mv_par12 == 1 .or. mv_par07 == 3,.T.,.F.) /*lEndSection*/,.F./*lEndReport*/,/*lEndPage*/)
TRFunction():New(oFatCli:Cell("TB_VALOR3"),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,{|| nValor3 - nValor6},IIf(mv_par12 == 1 .or. mv_par07 == 3,.T.,.F.)/*lEndSection*/,.F./*lEndReport*/,/*lEndPage*/)
TRFunction():New(oFatCli:Cell("TB_VALOR7"),/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,{|| nValor7 - nValor9},IIf(mv_par12 == 1 .or. mv_par07 == 3,.T.,.F.)/*lEndSection*/,.F./*lEndReport*/,/*lEndPage*/)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria arquivo de trabalho                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria array para gerar arquivo de trabalho                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aTam:=TamSX3("F2_CLIENTE")
AADD(aCampos,{ "TB_CLI"    ,"C",aTam[1],aTam[2] } )
aTam:=TamSX3("F2_LOJA")
AADD(aCampos,{ "TB_LOJA"   ,"C",aTam[1],aTam[2] } )
aTam:=TamSX3("A1_EST")
AADD(aCampos,{ "TB_EST"    ,"C",aTam[1],aTam[2] } )
aTam:=TamSX3("F2_EMISSAO")
AADD(aCampos,{ "TB_EMISSAO","D",aTam[1],aTam[2] } )
AADD(aCampos,{ "TB_VALOR1 ","N",18,nDecs } )		// Valores de Faturamento
AADD(aCampos,{ "TB_VALOR2 ","N",18,nDecs } )
AADD(aCampos,{ "TB_VALOR3 ","N",18,nDecs } )
AADD(aCampos,{ "TB_VALOR4 ","N",18,nDecs } )		// Valores para devolucao
AADD(aCampos,{ "TB_VALOR5 ","N",18,nDecs } )
AADD(aCampos,{ "TB_VALOR6 ","N",18,nDecs } )
AADD(aCampos,{ "TB_VALOR7 ","N",18,nDecs } )
AADD(aCampos,{ "TB_VALOR8 ","N",18,nDecs } )
AADD(aCampos,{ "TB_VALOR9 ","N",18,nDecs } )
AADD(aCampos,{ "TB_RANKIN ","N",18 } )        		// Ranking conforme Valor faturamento
AADD(aCampos,{ "TB_TIPO ","C",03 } )        		

cNomArq := CriaTrab(aCampos)
dbUseArea( .T.,, cNomArq,cNomArq, if(.T. .OR. .F., !.F., NIL), .F. )
cNomArq1 := SubStr(cNomArq,1,7)+"1"
cNomArq2 := SubStr(cNomArq,1,7)+"2"
cNomArq3 := SubStr(cNomArq,1,7)+"3"
cNomArq4 := SubStr(cNomArq,1,7)+"4"
IndRegua(cNomArq,cNomArq1,"TB_CLI+TB_LOJA",,,OemToAnsi(STR0012))	//"Selecionando Registros..."

dbSelectArea("SF2")		// Cabecalho da Nota de Saida
dbSetOrder(2)			// Filial,Cliente,Loja,Documento,Serie

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Chamada da Funcao para gerar arquivo de Trabalho             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If mv_par09 == 3		// Inclui Devolucao?: 1=Sim, 2=Nao, 3=Por N.F.
	cKey:="D1_FILIAL+D1_SERIORI+D1_NFORI+D1_FORNECE+D1_LOJA"
	cFiltro :="D1_FILIAL=='"+xFilial("SD1")+"'.And.!Empty(D1_NFORI)"
	cFiltro += ".And. !("+IsRemito(2,"SD1->D1_TIPODOC")+")"		

	#IFDEF SHELL
		cFiltro += '.And. D1_CANCEL <> "S"'
	#ENDIF
	IndRegua("SD1",cNomArq3,cKey,,cFiltro,OemToAnsi(STR0012))	//"Selecionando Registros..."
	nIndex:=RetIndex("SD1")
	#IFNDEF TOP
		dbSetIndex(cNomArq3+OrdBagExt())
	#ENDIF
	dbSetOrder(nIndex+1)
	dbGotop()
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Grava arquivo de trabalho.             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
GTrabR4(cEstoq,cDupli,nMoeda,oReport)

If mv_par09 == 1	   		// Inclui Devolucao?: 1=Sim, 2=Nao, 3=Por N.F.
	dbSelectArea("SF1")		// Cabecalho da Nota de entrada
	dbSetOrder(2)			// Filial,Fornecedor,Loja,Documento
	oReport:IncMeter()
	GTrab1R4(cEstoq,cDupli,nMoeda,oReport)
Endif

dbSelectArea(cNomArq)
dbCommit()
dbClearIndex()


// Lista por: 1=Cliente, 2=Ranking, 3=Estado
If mv_par07 == 1			// Listar por Cliente   
	IndRegua(cNomArq,cNomArq2,"StrZero(1000000000000 - TB_VALOR3 + TB_VALOR6,18,"+Str(nDecs)+")",,,OemToAnsi(STR0012))	// "Selecionando Registros..."
	dbGoTop()
	nRank:=1
	While !Eof()
		RecLock(cNomArq,.F.)
		Replace TB_RANKIN With nRank
		MsUnlock()
		nRank++
		dbSkip()
	Enddo
	nRank:=0
	
	dbClearIndex()
	IndRegua(cNomArq,cNomArq1,"TB_CLI+TB_LOJA",,,OemToAnsi(STR0012))	// "Selecionando Registros..."
	oReport:Section(1):SetTotalText("Total do Cliente")
ElseIf mv_par07 == 2			// Listar por Ranking	
	IndRegua(cNomArq,cNomArq2,"StrZero(1000000000000 - TB_VALOR3 + TB_VALOR6,18,"+Str(nDecs)+")",,,OemToAnsi(STR0012))	// "Selecionando Registros..."
	dbGoTop()
	nRank:=1
	While !Eof()
		RecLock(cNomArq,.F.)
		Replace TB_RANKIN With nRank
		MsUnlock()
		nRank++
		dbSkip()
	Enddo
	dbGoTop()

	oReport:Section(1):SetTotalText("Total por Ranking")	
Else							// Listar por Estado	
	IndRegua(cNomArq,cNomArq1,"TB_EST+TB_CLI+TB_LOJA",,,OemToAnsi(STR0012))	// "Selecionando Registros..."
	oReport:Section(1):SetTotalText("Total do Estado")	
	oReport:Section(1):Cell("TB_RANKIN"):Disable()	
Endif


dbSelectArea(cNomArq)
dbGoTop()
If (cNomArq)->(RecCount()) > 0
	oReport:SetMeter(RecCount())		// Total de Elementos da regua
	oReport:Section(1):Init()
	
	nVal01 :=nVal02 := nVal03 := nVal04 := nVal05 := nVal06 := nVal07 := nVal08 := nVal09 := 0
	While !oReport:Cancel() .And. !(cNomArq)->(Eof())
	
		// Lista por: 1=Cliente, 2=Ranking, 3=Estado
		If mv_par07 == 1				// Listar por Cliente   
			cChave := (cNomArq)->TB_CLI+(cNomArq)->TB_LOJA
			bChave := {|| !oReport:Cancel() .And. !(cNomArq)->(Eof()) .And. (cNomArq)->TB_CLI+(cNomArq)->TB_LOJA == cChave }
		ElseIf mv_par07 == 2			// Listar por Ranking	
			cChave := (cNomArq)->TB_RANKIN	            
			bChave := {|| !oReport:Cancel() .And. !(cNomArq)->(Eof()) .And. (cNomArq)->TB_RANKIN == cChave }		
		Else							// Listar por Estado	
			cChave := (cNomArq)->TB_EST
			bChave := {|| !oReport:Cancel() .And. !(cNomArq)->(Eof()) .And. (cNomArq)->TB_EST == cChave }		
		Endif
	
	  	oReport:Section(1):Init()
		While Eval(bChave)
		
			oReport:Section(1):Cell("TB_VALOR4"):Disable()
			oReport:Section(1):Cell("TB_VALOR5"):Disable()
			oReport:Section(1):Cell("TB_VALOR6"):Disable()
			oReport:Section(1):Cell("TB_VALOR9"):Disable()
			oReport:Section(1):Cell("TB_TIPO"):Disable()
		
			nValor1 := (cNomArq)->TB_VALOR1
			nValor2 := (cNomArq)->TB_VALOR2
			nValor3 := (cNomArq)->TB_VALOR3
			nValor4 := (cNomArq)->TB_VALOR4
			nValor5 := (cNomArq)->TB_VALOR5
			nValor6 := (cNomArq)->TB_VALOR6
			nValor7 := (cNomArq)->TB_VALOR7
			nValor8 := (cNomArq)->TB_VALOR8
			nValor9 := (cNomArq)->TB_VALOR9
			
			nVal01 += (cNomArq)->TB_VALOR1
			nVal02 += (cNomArq)->TB_VALOR2
			nVal03 += (cNomArq)->TB_VALOR3
			nVal04 += (cNomArq)->TB_VALOR4
			nVal05 += (cNomArq)->TB_VALOR5
			nVal06 += (cNomArq)->TB_VALOR6
			nVal07 += (cNomArq)->TB_VALOR7
			nVal08 += (cNomArq)->TB_VALOR8
			nVal09 += (cNomArq)->TB_VALOR9
			
			oReport:Section(1):PrintLine()
			
			// Impressao das Devolucoes
			If (cNomArq)->TB_VALOR4 <> 0 .Or. (cNomArq)->TB_VALOR5 <> 0 .Or. (cNomArq)->TB_VALOR6 <> 0
				NVALOR1 := 	NVALOR2 := 	NVALOR3 := NVALOR4 := NVALOR5 := NVALOR6 := NVALOR7 := NVALOR8 := NVALOR9 := 0
			
				oReport:Section(1):Cell("TB_CLI"):Hide()
				oReport:Section(1):Cell("TB_LOJA"):Hide()
				oReport:Section(1):Cell("A1_NOME"):Hide()
				
				oReport:Section(1):Cell("TB_VALOR1"):Disable()
				oReport:Section(1):Cell("TB_VALOR2"):Disable()
				oReport:Section(1):Cell("TB_VALOR3"):Disable()
				oReport:Section(1):Cell("TB_VALOR7"):Disable()
				oReport:Section(1):Cell("TB_VALOR4"):Enable()
				oReport:Section(1):Cell("TB_VALOR5"):Enable()
				oReport:Section(1):Cell("TB_VALOR6"):Enable()
				oReport:Section(1):Cell("TB_VALOR9"):Enable()
				oReport:Section(1):Cell("TB_VALOR8"):Disable()
				oReport:Section(1):Cell("TB_RANKIN"):Disable()
				oReport:Section(1):Cell("TB_TIPO"):Enable()
				
				oReport:Section(1):PrintLine()		
	
				oReport:Section(1):Cell("TB_CLI"):Show()
				oReport:Section(1):Cell("TB_LOJA"):Show()
				oReport:Section(1):Cell("A1_NOME"):Show()
				oReport:Section(1):Cell("TB_VALOR1"):Enable()
				oReport:Section(1):Cell("TB_VALOR2"):Enable()
				oReport:Section(1):Cell("TB_VALOR3"):Enable()
				oReport:Section(1):Cell("TB_VALOR7"):Enable()
				oReport:Section(1):Cell("TB_VALOR8"):Enable()
				oReport:Section(1):Cell("TB_VALOR4"):Disable()
				oReport:Section(1):Cell("TB_VALOR5"):Disable()
				oReport:Section(1):Cell("TB_VALOR6"):Disable()
				oReport:Section(1):Cell("TB_VALOR9"):Disable()
				If mv_par07 <> 3
					oReport:Section(1):Cell("TB_RANKIN"):Enable()
				EndIf	
				oReport:Section(1):Cell("TB_TIPO"):Disable()			
			EndIf
			
			If mv_par07 == 1		// por cliente
				If (cNomArq)->TB_VALOR4 <> 0 .Or. (cNomArq)->TB_VALOR5 <> 0 .Or. (cNomArq)->TB_VALOR6 <> 0
					oReport:Section(1):SetTotalText(STR0035 +" "+ cChave + "( ABT )")
				Else	
					oReport:Section(1):SetTotalText(STR0035 +" "+ cChave)	
				EndIf
			ElseIf mv_par07 == 3	// por estado	                
				oReport:Section(1):SetTotalText(STR0030 +" "+ cChave)	
			EndIf			
			
			dbSelectArea(cNomArq)			
			dbSkip()
		EndDo
		oReport:Section(1):Finish()
		
	EndDo
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Impressao das secoes totalizadoras no final do relatorio     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:PrintText(STR0025)
	oReport:Section(2):Init()
	oReport:Section(2):PrintLine()
	oReport:Section(2):Finish()
	
	If mv_par09 <> 2 .And. (nval04+nval05+nval06<>0)
		oReport:Section(3):Init()
		oReport:Section(3):PrintLine()
		oReport:Section(3):Finish()
	EndIf	
	                
	If mv_par12 == 1 .And. (nval04+nval05+nval06<>0)
		oReport:Section(4):Init()
		oReport:Section(4):PrintLine()
		oReport:Section(4):Finish()
	EndIf	
EndIf
	
dbSelectArea(cNomArq)
dbCloseArea()

cDelArq := cNomArq+GetDBExtension()

If File(cDelArq)
	fErase(cDelArq)
Endif
fErase(cNomArq1+OrdBagExt())
If mv_par07 <> 3
	Ferase(cNomarq2+OrdBagExt())
EndIF
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Restaura a integridade dos dados                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If mv_par09 == 3
	dbSelectArea("SD1")
	dbClearFilter()
	RetIndex()
	fErase(cNomArq3+OrdBagExt())
	dbSetOrder(1)
Endif

dbSelectArea("SF2")
dbClearFilter()
dbSetOrder(1)
dbSelectArea("SD2")
dbSetOrder(1)

Return


/*
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³GTrabR4   ³ Autor ³ Wagner Xavier         ³ Data ³ 27/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Gera arquivo de Trabalho para emissao de Estat.de Fatur.    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ ReportPrint()                                              ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static FuncTion GTrabR4(cEstoq,cDupli,nMoeda,oReport)

Local cChaven    := ""
Local nTOTAL     := 0
Local nVALICM    := 0
Local nVALIPI    := 0
Local ImpNoInc   := 0    
Local nImpInc    := 0    
Local nTB_VALOR1 := 0
Local nTB_VALOR2 := 0
Local nTB_VALOR3 := 0
Local nTB_VALOR7 := 0
Local nTB_VALOR8 := 0
Local nY         := 0
Local aImpostos	 := {}
Local lAvalTes   := .F.                  
Local lProcessa  := .T.
Local cFilUsu    := ""
Local cFilSA1    := ""
Local nAdic      := 0
Local nValSImp   := 0
Local nTotDesp   := 0

Private cCampImp
                       
// Adiciona filtro do usuario no filtro do relatorio
If len(oReport:Section(1):GetAdvplExp("SF2")) > 0
	cFilUsu += " .AND. " + oReport:Section(1):GetAdvplExp("SF2")
EndIf	

dbSelectArea("SF2")
dbsetorder(1)
cKey := indexkey()
cFiltro := "DTOS(F2_EMISSAO) >= '"+ Dtos(mv_par01) +"'.AND. DTOS(F2_EMISSAO) <= '"+ dtos(mv_par02) +"' .AND."
cFiltro += "F2_CLIENTE >= '"+ mv_par03 + "' .AND. F2_CLIENTE <= '"+ mv_par04 + "' .and. " 
cFiltro += "F2_FILIAL = '" + xFilial("SF2") + "'"
cFiltro += cFilUsu
IndRegua("SF2",cNomArq4,cKey,,cFiltro,OemToAnsi(STR0012))	//"Selecionando Registros..."
nIndex:=RetIndex("SF2")
#IFNDEF TOP
     dbSetIndex(cNomArq4+OrdBagExt())
#ENDIF
dbSetOrder(nIndex+1)
dbGotop()

If len(oReport:Section(1):GetAdvplExp("SA1")) > 0
	cFilSA1 += oReport:Section(1):GetAdvplExp("SA1")
EndIf

While !Eof() .And. xFilial()=SF2->F2_FILIAL 

	lProcessa := .T.
	
	dbSelectArea("SA1")
	dbSetOrder(1)
	dbSeek ( xFilial() + SF2->F2_CLIENTE+SF2->F2_LOJA )
	//Verifica filtro do ususario
	If !Empty(cFilSA1) .And. !(&cFilSA1)
		lProcessa := .F.
	EndIf	
	
	dbSelectArea("SF2")
	
	#IFDEF SHELL
		If SF2->F2_CANCEL == "S"
			lProcessa := .F.
		Endif
	#ENDIF
	
	If IsRemito(1,"SF2->F2_TIPODOC")
		lProcessa := .F.
	Endif	
	
	IF SA1->A1_EST 	 < mv_par05 .Or. SA1->A1_EST     > mv_par06	
		lProcessa := .F.
	EndIF
	
	If (At(SF2->F2_TIPO,"DB") != 0) .Or. (SF2->F2_TIPO == "I" .And. SF2->F2_ICMSRET == 0)
		lProcessa := .F.
	Endif

	If lProcessa
		
		dbSelectArea("SD2")
		dbSetOrder(3)
		dbSeek(xFilial()+SF2->F2_DOC+SF2->F2_SERIE)
		nTOTAL 		:=0
		nTOTALLIQ	:=0
		nVALICM		:=0
		nVALIPI		:=0
		nImpNoInc	:=0
		nImpInc  	:=0 
		nTB_VALOR7	:=0
		lAvalTes    := .F.
		nTotDesp    := 0
		While !Eof() .And. xFilial()==SD2->D2_FILIAL .And.;
			SD2->D2_DOC+SD2->D2_SERIE == SF2->F2_DOC+SF2->F2_SERIE
			
			#IFDEF SHELL
				If SD2->D2_CANCEL == "S" .Or. !(Substr(SD2->D2_CF,2,2)$"12|73|74")   
					SD2->(dbSkip())
					Loop
				Endif
			#ENDIF
			
			dbSelectArea("SF4")
			dbSeek(xFilial()+SD2->D2_TES)
			
			dbSelectArea("SD2")
			If AvalTes(D2_TES,cEstoq,cDupli)
				
				lAvalTes := .T.
				nTB_VALOR7	+= SD2->D2_QUANT
				If cPaisLoc <> "BRA" .and. Type("SF2->F2_TXMOEDA")#"U"

					nTOTAL  += xMoeda(SD2->D2_TOTAL,SF2->F2_MOEDA,nMoeda,SF2->F2_EMISSAO,nDecs+1,SF2->F2_TXMOEDA)

				Else
					If SF4->F4_AGREG <> "N"
						nTOTAL  += xMoeda(SD2->D2_TOTAL,1,nMoeda,SF2->F2_EMISSAO,nDecs+1)
					Else
						nTOTAL  += xMoeda(SD2->D2_SEGURO+SD2->D2_VALFRE+SD2->D2_DESPESA,1,nMoeda,SF2->F2_EMISSAO,nDecs+1)
						nTotDesp += xMoeda(SD2->D2_SEGURO+SD2->D2_VALFRE+SD2->D2_DESPESA,1,nMoeda,SF2->F2_EMISSAO,nDecs+1)
					EndIf
					If mv_par15 == 1  .And. SF4->F4_AGREG <> "N"
						nValSImp := MaFisSImp("SF2","SD2",SD2->D2_TES)
						nTOTALLIQ  += xMoeda(nValSImp,1,nMoeda,SF2->F2_EMISSAO,nDecs+1)
					EndIf	
				Endif
				If ( cPaisLoc=="BRA")
					nVALICM += xMoeda(SD2->D2_VALICM,1,nMoeda,SF2->F2_EMISSAO)
					nVALIPI += xMoeda(SD2->D2_VALIPI,1,nMoeda,SF2->F2_EMISSAO)
				Else
					//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
					//³ Pesquiso pelas caracteristicas de cada imposto               ³
					//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
					aImpostos:=TesImpInf(SD2->D2_TES)
					For nY:=1 to Len(aImpostos)
						cCampImp:="SD2->"+(aImpostos[nY][2])
						If ( aImpostos[nY][3]=="1" )
							nImpInc 	+= xMoeda(&cCampImp,SF2->F2_MOEDA,nMoeda,SF2->F2_EMISSAO,nDecs+1,SF2->F2_TXMOEDA)
						Else
							nImpNoInc 	+= xmoeda(&cCampImp,SF2->F2_MOEDA,nMoeda,SF2->F2_EMISSAO,nDecs+1,SF2->F2_TXMOEDA)
						Endif
					Next
				EndIf
			Endif
			
			dbSelectArea("SD2")
			dbSkip()
		EndDo
		
		dbSelectArea("SF2")
		nAdic := 0
		If lAvalTes 
		    nAdic := xMoeda(SF2->F2_FRETE+SF2->F2_SEGURO+SF2->F2_DESPESA,SF2->F2_MOEDA,nMoeda,SF2->F2_EMISSAO)
			nTOTAL  += nAdic
		Endif
		
		
		If nTOTAL > 0
			dbSelectArea(cNomArq)
			If dbSeek(SF2->F2_CLIENTE+SF2->F2_LOJA,.F.)
				RecLock(cNomArq,.F.)
			Else
				RecLock(cNomArq,.T.)
				Replace TB_CLI     With SF2->F2_CLIENTE
				Replace TB_LOJA    With SF2->F2_LOJA
			EndIF
			Replace TB_EST     With SA1->A1_EST
			Replace TB_EMISSAO With SF2->F2_EMISSAO
			
			If lAvalTes .And. MV_PAR14 == 2			
				nTB_VALOR2 := IIF(SF2->F2_TIPO == "P",0,nTOTAL-nTotDesp)
			Else
				nTB_VALOR2 := IIF(SF2->F2_TIPO == "P",0,nTOTAL-nAdic-nTotDesp)
			EndIf
			
			If ( cPaisLoc=="BRA" )
				If nTOTALLIQ <> 0
					nTB_VALOR1 := nTOTALLIQ-nVALICM
				Else
					nTB_VALOR1 := nTOTAL-nVALICM-nAdic-nTotDesp
				EndIf
				nTB_VALOR3 := IIF(SF2->F2_TIPO == "P",0,nTOTAL-nTotDesp);
				+ nVALIPI+;
				IIF(SF2->F2_TIPO=="I" .And. SF2->F2_ICMSRET > 0,xMoeda(SF2->F2_FRETAUT,1,nMoeda,SF2->F2_EMISSAO),xMoeda(SF2->F2_ICMSRET+SF2->F2_FRETAUT,1,nMoeda,SF2->F2_EMISSAO))				

				
			Else
				nTB_VALOR1 := nTOTAL-nImpNoInc
				nTB_VALOR3 := IIF(SF2->F2_TIPO == "P",0,nTOTAL)+ nImpInc+xMoeda(SF2->F2_FRETAUT,SF2->F2_MOEDA,nMoeda,SF2->F2_EMISSAO,nDecs+1,SF2->F2_TXMOEDA)
			EndIf
			
			Replace TB_VALOR1  With TB_VALOR1+ nTB_VALOR1
			Replace TB_VALOR2  With TB_VALOR2+ nTB_VALOR2
			Replace TB_VALOR3  With TB_VALOR3+ nTB_VALOR3
			Replace TB_VALOR7  With TB_VALOR7+ nTB_VALOR7
			
			// Sergio Fuzinaka - 16.10.01
			If Ascan( aCodCli, SF2->F2_CLIENTE+SF2->F2_LOJA ) == 0
				Aadd( aCodCli, SF2->F2_CLIENTE+SF2->F2_LOJA )
			Endif
			
			MsUnlock()
			
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Grava Devolucao ref a Nota Fiscal posicionada                ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If mv_par09 == 3
				GravaDevR4(SF2->F2_DOC,SF2->F2_SERIE,SF2->F2_CLIENTE,SF2->F2_LOJA,nMoeda,cEstoq,cDupli)
			Endif
		Endif

	Endif
		
	dbSelectArea("SF2")
	dbSkip()
EndDo

dbSelectArea("SF2")
dbClearFilter()
RetIndex()
fErase(cNomArq4+OrdBagExt())
dbSetOrder(1)

Return .T.


/*
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³GTrab1R4  ³ Autor ³ Adriano Sacomani      ³ Data ³ 27/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Gera arquivo de Trabalho para emissao de Estat.de Fatur.    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ ReportPrint()                                              ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static FuncTion GTrab1R4(cEstoq,cDupli,nMoeda,oReport)

Local nTOTAL     := 0
Local nVALICM    := 0
Local nVALIPI    := 0
Local nImpNoInc  := 0
Local nImpInc    := 0
Local nTB_VALOR4 := 0
Local nTB_VALOR5 := 0
Local nTB_VALOR6 := 0
Local nTB_VALOR9 := 0
Local nY         := 0 
Local aImpostos	 := {}
Local lAvalTes   := .F.
Local DtMoedaDev := SF1->F1_DTDIGIT
Local nAdic      := 0
Local nValSImp   := 0
Local cFilSA1	 := ""
Local lProcessa	 := .T.

dbSeek(xFilial()+mv_par03,.T.)

If len(oReport:Section(1):GetAdvplExp("SA1")) > 0
	cFilSA1 += oReport:Section(1):GetAdvplExp("SA1")
EndIf

While !Eof() .And. xFilial()==F1_FILIAL .And. F1_FORNECE <= mv_par04
	
	#IFDEF SHELL
		If SF1->F1_CANCEL == "S"
			SF1->(dbSkip())
			Loop
		Endif
	#ENDIF
	
	lProcessa := .T.
	
	dbSelectArea("SA1")
	dbSetOrder(1)
	dbSeek( xFilial() + SF1->F1_FORNECE + SF1->F1_LOJA)
	//Verifica filtro do ususario
	If !Empty(cFilSA1) .And. !(&cFilSA1)
		lProcessa := .F.
	EndIf	
	If lProcessa
		dbSelectArea("SF1")
		
		If IsRemito(1,"SF1->F1_TIPODOC")
			dbSkip()
			Loop
		Endif
			
		If SF1->F1_DTDIGIT < mv_par01 .Or. SF1->F1_DTDIGIT > mv_par02 .Or.;
			SA1->A1_EST     < mv_par05 .Or. SA1->A1_EST     > mv_par06
			dbSkip()
			Loop
		EndIf
		
		If SF1->F1_TIPO != "D"
			Dbskip()
			Loop
		Endif
		
		dbSelectArea("SD1")
		dbSetOrder(1)
		dbSeek(xFilial()+SF1->F1_DOC+SF1->F1_SERIE+SF1->F1_FORNECE+SF1->F1_LOJA)
		nTOTAL 		:= 0.00
		nTOTALLIQ	:= 0.00
		nVALICM		:= 0.00
		nVALIPI		:= 0.00
		nImpNoInc	:= 0.00
		nImpInc 	:= 0.00
		lAvalTes    := .F.
		nTB_VALOR9	:= 0.00
		
		dbSelectArea("SF4")
		dbSeek(xFilial()+SD1->D1_TES)
		dbSelectArea("SD1")
		
		While !Eof() .and. xFilial()==SD1->D1_FILIAL .And.;
			SD1->D1_DOC+SD1->D1_SERIE+SD1->D1_FORNECE+SD1->D1_LOJA ==;
			SF1->F1_DOC+SF1->F1_SERIE+SF1->F1_FORNECE+SF1->F1_LOJA
			
			If SD1->D1_TIPO != "D"
				dbSkip()
				Loop
			Endif
			
			#IFDEF SHELL
				If SD1->D1_CANCEL == "S"
					SD1->(dbSkip())
					Loop
				Endif
			#ENDIF
			
			dbSelectArea("SF4")
			dbSeek(xFilial()+SD1->D1_TES)
			dbSelectArea("SD1")
			
			If AvalTes(D1_TES,cEstoq,cDupli)
				
				If MV_PAR13 == 2
				   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				   //³Verifica se existe a N.F original de Saida , se existir usa a data de emissao da NF de saida             ³
				   //³conforme o parametro MV_PAR13 se não encontrar usa o campo F1_DTDIGIT para converter a moeda da devolucao³
				   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				   dbSelectArea("SF2")
				   dbSetOrder(1)
				   If MsSeek(xFilial()+SD1->D1_NFORI+SD1->D1_SERIORI+SD1->D1_FORNECE+SD1->D1_LOJA)
					  DtMoedaDev  := SF2->F2_EMISSAO
				   Else
					  DtMoedaDev  := SF1->F1_DTDIGIT
				   EndIf
				Else    
				   DtMoedaDev  := SF1->F1_DTDIGIT            
				EndIf
					  
				dbSelectArea("SD1")

				lAvalTes := .T.
				nTOTAL  +=xMoeda((SD1->D1_TOTAL-SD1->D1_VALDESC),SF1->F1_MOEDA,nMoeda,DtMoedaDev,nDecs+1,SF1->F1_TXMOEDA)
				nTB_VALOR9	+= SD1->D1_QUANT
				
				If ( cPaisLoc=="BRA" ) 
					If mv_par15 == 1
						nValSImp := MaFisSImp("SF1","SD1",SD1->D1_TES)
						nTOTALLIQ  +=xMoeda((nValSImp),SF1->F1_MOEDA,nMoeda,DtMoedaDev,nDecs+1,SF1->F1_TXMOEDA)
					EndIf	
					nVALICM += xMoeda(SD1->D1_VALICM,1,nMoeda,DtMoedaDev)
					nVALIPI += xMoeda(SD1->D1_VALIPI,1,nMoeda,DtMoedaDev)
				Else
					aImpostos:=TesImpInf(SD1->D1_TES)
					For nY:=1 to Len(aImpostos)
						cCampImp:="SD1->"+(aImpostos[nY][2])
						If ( aImpostos[nY][3]=="1" )
							nImpInc 	+= xmoeda(&cCampImp,SF1->F1_MOEDA,nMoeda,DtMoedaDev,nDecs+1,SF1->F1_TXMOEDA)
						Else
							nImpNoInc	+= xmoeda(&cCampImp,SF1->F1_MOEDA,nMoeda,DtMoedaDev,nDecs+1,SF1->F1_TXMOEDA)
						Endif
					Next
				Endif
				
			Endif
			
			dbSelectArea("SD1")
			dbSkip()
		EndDo
		
		dbSelectArea("SF1")
		nAdic := 0
		If lAvalTes 
			nAdic := xMoeda(SF1->F1_FRETE+SF1->F1_SEGURO+SF1->F1_DESPESA,SF1->F1_MOEDA,nMoeda,DtMoedaDev)
			nTOTAL += nAdic
		Endif
		
		If nTOTAL > 0
			dbSelectArea(cNomArq)
			If dbSeek(SF1->F1_FORNECE+SF1->F1_LOJA,.F.)
				RecLock(cNomArq,.F.)
			Else
				RecLock(cNomArq,.T.)
				Replace TB_CLI     With SF1->F1_FORNECE
				Replace TB_LOJA	 With SF1->F1_LOJA
			EndIf
			Replace TB_EST     With SA1->A1_EST
			Replace TB_EMISSAO With SF1->F1_EMISSAO
			
			If lAvalTes .And. MV_PAR14 == 2			
				nTB_VALOR5 := nTOTAL
			Else
				nTB_VALOR5 := nTOTAL-nAdic
			EndIf
			
			If ( cPaisLoc=="BRA")
				If nTOTALLIQ <> 0
					nTB_VALOR4 := nTOTALLIQ-nVALICM
				Else
					nTB_VALOR4 := nTOTAL-nVALICM-nAdic
				EndIf
				nTB_VALOR6 := nTOTAL+nVALIPI+xMoeda(SF1->F1_ICMSRET,1,nMoeda,DtMoedaDev)
			Else
				nTB_VALOR4 := nTOTAL-nImpNoInc
				nTB_VALOR6 := nTotal + nImpInc
			Endif
			
			Replace TB_VALOR4  With TB_VALOR4+nTB_VALOR4
			Replace TB_VALOR5  With TB_VALOR5+nTB_VALOR5
			Replace TB_VALOR6  With TB_VALOR6+nTB_VALOR6
			Replace TB_VALOR9  With TB_VALOR9+nTB_VALOR9
			Replace TB_TIPO	   With "DEV"
		Endif
	EndIf
	dbSelectArea("SF1")
	dbSkip()
	
Enddo

Return .T.

/*
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³GravaDevR4³Revisor³Alexandre Inacio Lemes ³ Data ³ 27/06/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Grava item da devolucao ref a nota fiscal posicionada.      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ GTrabR4()                                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static FuncTion GravaDevR4(cNumOri,cSerieOri,cClienteOri,cLojaOri,nMoeda,cEstoq,cDupli)

Local cNum        := ""
Local cSerie      := ""
Local cFornece    := ""
Local cLoja       := ""
Local cNumDocNfe  := ""
Local nX          := 0
Local nTOTAL      := 0
Local nVALICM     := 0
Local nVALIPI     := 0
Local nImpNoInc   := 0
Local nImpInc     := 0
Local nTB_VALOR4  := 0
Local nTB_VALOR5  := 0
Local nTB_VALOR6  := 0
Local nTB_VALOR9  := 0
Local nY          := 0
Local aImpostos   := {}
Local aNotDev     := {}
Local lAvalTes    := .F.
Local DtMoedaDev  := SF2->F2_EMISSAO
Local nAdic       := 0

dbSelectArea("SD1")
dbSetOrder(nIndex+1)
If dbseek(xFilial()+cSerieOri+cNumOri+cClienteOri+cLojaOri,.F.)
	
	cNumDocNfe := SD1->D1_FILIAL+SD1->D1_DOC+SD1->D1_SERIE+SD1->D1_FORNECE+SD1->D1_LOJA
	
	Aadd( aNotDev, cNumDocNfe )
	
	Do While !Eof() .And. xFilial()==SD1->D1_FILIAL .And. cSerieOri+cNumOri+cClienteOri+cLojaOri;
		== SD1->D1_SERIORI+SD1->D1_NFORI+SD1->D1_FORNECE+SD1->D1_LOJA
		
		If cNumDocNfe <> SD1->D1_FILIAL+SD1->D1_DOC+SD1->D1_SERIE+SD1->D1_FORNECE+SD1->D1_LOJA
			If Ascan( aCodCli, SD1->D1_FILIAL+SD1->D1_DOC+SD1->D1_SERIE+SD1->D1_FORNECE+SD1->D1_LOJA) == 0
				Aadd( aNotDev, SD1->D1_FILIAL+SD1->D1_DOC+SD1->D1_SERIE+SD1->D1_FORNECE+SD1->D1_LOJA)
				cNumDocNfe := SD1->D1_FILIAL+SD1->D1_DOC+SD1->D1_SERIE+SD1->D1_FORNECE+SD1->D1_LOJA
			Endif
		Endif
		
		dbSelectArea("SD1")
		dbSkip()
	Enddo
	
	dbSelectArea("SD1")
	dbSetOrder(nIndex+1)
	dbseek(xFilial()+cSerieOri+cNumOri+cClienteOri+cLojaOri,.F.)
	
	For nX :=1 to Len(aNotDev)
		
		dbSelectArea("SD1")
		cNum		:=D1_DOC
		cSerie	    :=D1_SERIE
		cFornece	:=D1_FORNECE
		cLoja		:=D1_LOJA
		
		dbSelectArea("SA1")
		dbSetOrder(1)
		dbSeek( xFilial() + cFornece + cLoja)
		dbSelectArea("SF1")
		dbSetOrder(1)
		
		If dbSeek(aNotDev[nX])
			
			dbSelectArea("SD1")
			dbSetOrder(1)
			dbSeek(aNotDev[nX])
			
			dbSelectArea("SF1")
			dbSetOrder(1)
			If SF1->F1_DTDIGIT < mv_par01 .Or. SF1->F1_DTDIGIT > mv_par02 .Or.;
				SA1->A1_EST < mv_par05 .Or. SA1->A1_EST > mv_par06 .Or. SF1->F1_TIPO != "D"
				SD1->(dbSkip())
				Loop
			EndIf
			
			If IsRemito(1,"SF1->F1_TIPODOC")
				dbSkip()
				Loop
			Endif

			#IFDEF SHELL
				If SF1->F1_CANCEL == "S"
					SD1->(dbSkip())
					Loop
				Endif
			#ENDIF
			
			nTOTAL 		:=0.00
			nVALICM		:=0.00
			nVALIPI		:=0.00
			nImpNoInc	:=0.00
			nImpInc 	:=0.00
			lAvalTes    := .F.
			nTB_VALOR9	:=0.00


            DtMoedaDev  := IIF(MV_PAR13 == 1,SF1->F1_DTDIGIT,SF2->F2_EMISSAO)
			
			dbSelectArea("SF4")
			dbSeek(xFilial()+SD1->D1_TES)
			dbSelectArea("SD1")
			
			While !Eof() .and. xFilial()==SD1->D1_FILIAL .And.SD1->D1_DOC+SD1->D1_SERIE+SD1->D1_FORNECE+SD1->D1_LOJA ==SF1->F1_DOC+SF1->F1_SERIE+SF1->F1_FORNECE+SF1->F1_LOJA
				
				If SD1->D1_TIPO != "D"
					dbSkip()
					Loop
				Endif
				
				If IsRemito(1,"SD1->D1_TIPODOC")
					dbSkip()
					Loop
				Endif

				#IFDEF SHELL
					If SD1->D1_CANCEL == "S"
						SD1->(dbSkip())
						Loop
					Endif
				#ENDIF
				
				dbSelectArea("SF4")
				dbSeek(xFilial()+SD1->D1_TES)
				
				If AvalTes(SD1->D1_TES,cEstoq,cDupli) .and. cSerieOri+cNumOri == SD1->D1_SERIORI+SD1->D1_NFORI
					
					lAvalTes := .T.
					
					dbSelectArea(cNomArq)
					nTOTAL  +=xMoeda((SD1->D1_TOTAL-SD1->D1_VALDESC),SF1->F1_MOEDA,nMoeda,DtMoedaDev,nDecs+1,SF1->F1_TXMOEDA)
					nTB_VALOR9+= SD1->D1_QUANT
					If ( cPaisLoc=="BRA" )
						nVALICM += xMoeda(SD1->D1_VALICM,1,nMoeda,DtMoedaDev)
						nVALIPI += xMoeda(SD1->D1_VALIPI,1,nMoeda,DtMoedaDev)
					Else
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ Pesquiso pelas caracteristicas de cada imposto               ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
						aImpostos:=TesImpInf(SD1->D1_TES)
						For nY:=1 to Len(aImpostos)
							cCampImp:="SD1->"+(aImpostos[nY][2])
							If ( aImpostos[nY][3]=="1" )
								nImpInc 	+= xmoeda(&cCampImp,SF1->F1_MOEDA,nMoeda,DtMoedaDev,nDecs+1,SF1->F1_TXMOEDA)
							Else
								nImpNoInc	+= xmoeda(&cCampImp,SF1->F1_MOEDA,nMoeda,DtMoedaDev,nDecs+1,SF1->F1_TXMOEDA)
							EndIf
						Next
					EndIf
					
				Endif
				
				dbSelectArea("SD1")
				dbSkip()
			EndDo
			
			dbSelectArea("SF1")           
			nAdic := 0
			If lAvalTes 
				nAdic := xMoeda(SF1->F1_FRETE+SF1->F1_SEGURO+SF1->F1_DESPESA,SF1->F1_MOEDA,nMoeda,DtMoedaDev,nDecs+1,SF1->F1_TXMOEDA)
				nTOTAL += nAdic
			Endif
			
			If nTOTAL > 0
				dbSelectArea(cNomArq)
				If dbSeek(SF1->F1_FORNECE+SF1->F1_LOJA,.F.)
					RecLock(cNomArq,.F.)
				Else
					RecLock(cNomArq,.T.)
					Replace TB_CLI     With SF1->F1_FORNECE
					Replace TB_LOJA	 With SF1->F1_LOJA
				EndIf
				
				Replace TB_EST     With SA1->A1_EST
				Replace TB_EMISSAO With DtMoedaDev
				
				If lAvalTes .And. MV_PAR14 == 2			
					nTB_VALOR5 := nTOTAL
				Else
					nTB_VALOR5 := nTOTAL-nAdic
				EndIf
				
				If ( cPaisLoc=="BRA" )
					nTB_VALOR4 := nTOTAL-nVALICM-nAdic
					nTB_VALOR6 := nTOTAL+nVALIPI+xMoeda(SF1->F1_ICMSRET,1,nMoeda,DtMoedaDev)
				Else
					nTB_VALOR4 := nTOTAL-nImpInc
					nTB_VALOR6 := nTotal+nImpInc
				Endif
				
				Replace TB_VALOR4  With TB_VALOR4+nTB_VALOR4
				Replace TB_VALOR5  With TB_VALOR5+nTB_VALOR5
				Replace TB_VALOR6  With TB_VALOR6+nTB_VALOR6
				Replace TB_VALOR9  With TB_VALOR9+nTB_VALOR9
				Replace TB_TIPO	   With "DEV"				
			EndIf
			
		Endif
		
	Next nX
	
endif

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³AjustaSX1 ³ Autor ³Marcelo Alexandre      ³ Data ³25/06/2007³±±
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
Local aHelpP	:= {}
Local aHelpE	:= {}
Local aHelpS	:= {}

Aadd( aHelpP, "Desconsidera os valores de PIS/COFINS" )
Aadd( aHelpP, "e ICMS nos valores.       " )

Aadd( aHelpE, "No considera los valores de PIS/COFINS" )
Aadd( aHelpE, " y ICMS en el valores"  )

Aadd( aHelpS, "Do not consider the PIS/COFINS  " )
Aadd( aHelpS, " and ICMS value.   " )

If cPaisLoc=="BRA" 
	PutSx1("MTR590","15","Deduz PIS/COFINS e ICMS?"  ,"Deduce PIS/COFINS e ICMS?","It deduces  PIS/COFINS e ICMS?","mv_chf","N",1,0,2,"C","","","","","mv_par15","Sim"            ,"Si"             ,"Yes"          ,"","Nao"            ,"No"                  ,"No"                         ,"","","","","","","","","",aHelpP,aHelpE,aHelpS)
EndIf

RestArea(aArea)

Return
