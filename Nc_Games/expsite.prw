#include "protheus.ch"
#include "rwmake.ch"
#DEFINE CRLF Chr(13)+Chr(10)

User Function EXPSITE()
Local oReport
ctime	:= time()

ajustasx1()
Pergunte("EXPSTE    ",.F.)
//execução do relatório
oReport := ReportDef()
oReport:PrintDialog()
//fim do relatório
ctimeend	:= time()

cMensagem := "Tempo de execução: "+ CRLF
cMensagem += "[ Hora inicial ]  "+ctime    + CRLF
cMensagem += "[ Hora Final   ]  "+ctimeend
//+----------------------------------------------------------------------------+
//|Apresenta uma mensagem com os resultados obtidos                            |
//+----------------------------------------------------------------------------+
MsgInfo(cMensagem, "Tempo de execução")

Return

/*
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Chamada da função      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/
Static Function ReportDef()
Local 	oReport
Local 	oSection1
Local 	cAliasSB1 	:= "SB1"
Local 	cAliasSB5 	:= "SB5"
Local 	cAliasQRY 	:= "SB1QRY"
Private	cProduto	:= ""
Private	cTitulo		:= ""
Private	cCeme		:= ""
Private	CPLATRED	:= ""
Private	CPLATEXT	:= ""
Private	cClasind	:= ""
Private	cVsint1 	:= ""
Private	cVsint2 	:= ""
Private	cVsint3 	:= ""
Private	cVsint4 	:= ""
Private	cVsint5 	:= ""
Private	cVsint6 	:= ""
Private	cVsint7 	:= ""
Private	cVsint8 	:= ""
Private	cVsint9 	:= ""
Private	cVreqsis1 	:= ""
Private	cVreqsis2 	:= ""
Private	cVreqsis3 	:= ""
Private	cVreqsis4 	:= ""
Private	cVreqsis5 	:= ""
Private	cGenero1	:= ""
Private	cGenero2	:= ""
Private	cGenero3	:= ""
Private	cGenero4	:= ""
Private	cVBUNDLE1	:= ""
Private	cVBUNDLE2	:= ""
Private	cVBUNDLE3	:= ""
Private	cSINOPSE1 	:= ""
Private	cSINOPSE2 	:= ""
Private	cSINOPSE3 	:= ""
Private	cSINOPSE4 	:= ""
Private	cSINOPSE5 	:= ""
Private	cSINOPSE6 	:= ""
Private	cSINOPSE7 	:= ""
Private	cSINOPSE8 	:= ""
Private	cSINOPSE9 	:= ""
Private	nseqstr		:= ""
Private	cLANC		:= ""

oReport := TReport():New("EXPSITE","Informações para o site","EXPSTE",{|oReport| PrintReport(oReport,cAliasSB1,cAliasSB5,cAliasQRY)},"Relatorio para importação para o site NC Games")

oSection1 := TRSection():New(oReport,"Produtos"		,{"SB1","SB5"})
TRCell():New(oSection1,"B5_GRPSITE"	,/*Tabela*/,"CodigoGrupo"  		,PesqPict("SB5","B5_GRPSITE")	,TamSX3("B5_GRPSITE")[1],/*lPixel*/,{||IIF(EMPTY((cAliasSB5)->B5_GRPSITE),"0",(cAliasSB5)->B5_GRPSITE)	})	// Grupo Site
TRCell():New(oSection1,"cLANC"		,/*Tabela*/,"Lancamento"		,"X"							,1						,/*lPixel*/,{||cLANC															})	// Codigo do Produto
TRCell():New(oSection1,"NSEQSTR"	,/*Tabela*/,"TopGames"			,"@!"							,4						,/*lPixel*/,{||IIF(EMPTY(alltrim(nSeqstr)),"0",nSeqstr) 										})	// Top Games
TRCell():New(oSection1,"B1_PROMO"	,/*Tabela*/,"Promocao"			,""								,1						,/*lPixel*/,{||IIF(!empty((cAliasSB1)->B1_PROMO),"1","0")						})	// Promoção
TRCell():New(oSection1,"B5_DTBUSCA"	,/*Tabela*/,"DataBusca"			,"XXXXXXXXXX"					,10						,/*lPixel*/,{||IIF(EMPTY((cAliasSB5)->B5_DTBUSCA),"0",(cAliasSB5)->B5_DTBUSCA)	})	// Data de Busca
TRCell():New(oSection1,"B5_TITULO"	,/*Tabela*/,"Titulo"			,PesqPict("SB5","B5_TITULO")	,TamSX3("B5_TITULO")[1]	,/*lPixel*/,{||IIF(EMPTY((cAliasSB5)->B5_TITULO),"0",(cAliasSB5)->B5_TITULO)	})//Titulo do produto
TRCell():New(oSection1,"CPLATRED"	,/*Tabela*/,"SiglaPlataforma"	,PesqPict("SZ5","Z5_PLATRED")	,TamSX3("Z5_PLATRED")[1],/*lPixel*/,{||IIF(EMPTY(alltrim(cPlatred)),"0",cPlatred) 								})	// Código Plataforma
TRCell():New(oSection1,"CPLATEXT"	,/*Tabela*/,"Plataforma"		,PesqPict("SZ5","Z5_PLATEXT")	,TamSX3("Z5_PLATEXT")[1],/*lPixel*/,{||IIF(EMPTY(alltrim(cPlatExt)),"0",cPlatExt) 								})	// Plataforma Extenso
TRCell():New(oSection1,"B5_OUTVER"	,/*Tabela*/,"OutrasVersoes"		,PesqPict("SB5","B5_OUTVER")	,TamSX3("B5_OUTVER")[1]	,/*lPixel*/,{||IIF(EMPTY((cAliasSB5)->B5_OUTVER),"0",(cAliasSB5)->B5_OUTVER)	})	// Outras Versões
TRCell():New(oSection1,"B5_PUBLISH"	,/*Tabela*/,"Fabricante"   		,PesqPict("SB5","B5_PUBLISH")	,TamSX3("B5_PUBLISH")[1],/*lPixel*/,{||IIF(EMPTY((cAliasSB5)->B5_PUBLISH),"0",UPLOW((cAliasSB5)->B5_PUBLISH))})	// Fabricante
TRCell():New(oSection1,"cVBUNDLE1"	,/*Tabela*/,"Conteudo1"			,PesqPict("SB5","B5_VBUNDLE")	,255					,/*lPixel*/,{||IIF(alltrim(SUBSTR(cVBUNDLE1,1,255))=="","0",SUBSTR(cVBUNDLE1,1,255))	})	// Codigo do Produto
TRCell():New(oSection1,"cVBUNDLE2"	,/*Tabela*/,"Conteudo2"			,PesqPict("SB5","B5_VBUNDLE")	,255					,/*lPixel*/,{||IIF(alltrim(SUBSTR(cVBUNDLE2,256,255))=="","0",SUBSTR(cVBUNDLE2,256,255))})	// Codigo do Produto
TRCell():New(oSection1,"cVBUNDLE3"	,/*Tabela*/,"Conteudo3"			,PesqPict("SB5","B5_VBUNDLE")	,255					,/*lPixel*/,{||IIF(alltrim(SUBSTR(cVBUNDLE3,511,255))=="","0",SUBSTR(cVBUNDLE3,511,255))})	// Codigo do Produto
TRCell():New(oSection1,"B5_FOCO"	,/*Tabela*/,"Foco"				,PesqPict("SB5","B5_FOCO")		,TamSX3("B5_FOCO")[1]	,/*lPixel*/,{||IIF(EMPTY((cAliasSB5)->B5_FOCO),"0",IIF(alltrim((cAliasSB5)->B5_FOCO)=="N","0",(cAliasSB5)->B5_FOCO)) })	// Foco
TRCell():New(oSection1,"B5_LANCSIM"	,/*Tabela*/,"LancamentoSimultaneo",PesqPict("SB5","B5_LANCSIM")	,TamSX3("B5_LANCSIM")[1],/*lPixel*/,{||IIF(EMPTY((cAliasSB5)->B5_LANCSIM),"0",(cAliasSB5)->B5_LANCSIM)	})	// Lançamento Simultâneo
TRCell():New(oSection1,"cPREVENTR"	,/*Tabela*/,"PrevisaoEntrega"	,""								,15						,/*lPixel*/,{||IIF(alltrim(cPREVENTR)=="","0",cPREVENTR)								})	// Previsão de chegada
TRCell():New(oSection1,"B5_PREVCHE"	,/*Tabela*/,"Mes"				,"XX"							,TamSX3("B5_PREVCHE")[1],/*lPixel*/,{||IIF(EMPTY((cAliasSB5)->B5_PREVCHE).or.(cAliasSB5)->B5_PREVCHE < ddatabase,"0",month((cAliasSB5)->B5_PREVCHE))})	// mes de chegada
TRCell():New(oSection1,"B5_PREVCHE"	,/*Tabela*/,"Ano"				,"XXXX"							,TamSX3("B5_PREVCHE")[1],/*lPixel*/,{||IIF(EMPTY((cAliasSB5)->B5_PREVCHE).or.(cAliasSB5)->B5_PREVCHE < ddatabase,"0",year((cAliasSB5)->B5_PREVCHE))})// ano de chegada
TRCell():New(oSection1,"B1_COD"		,/*Tabela*/,"CodigoNCGames"		,PesqPict("SB1","B1_COD")		,TamSX3("B1_COD")[1]	,/*lPixel*/,{||(cAliasSB1)->B1_COD }	)	// Codigo do Produto
TRCell():New(oSection1,"B1_CODBAR"	,/*Tabela*/,"CodigoBarras"		,PesqPict("SB1","B1_CODBAR")	,TamSX3("B1_CODBAR")[1]	,/*lPixel*/,{||(cAliasSB1)->B1_CODBAR }	)	// Codigo de Barras
TRCell():New(oSection1,"B1_ALT"		,/*Tabela*/,"Altura"			,PesqPict("SB1","B1_ALT")		,TamSX3("B1_ALT")[1]	,/*lPixel*/,{||(cAliasSB1)->B1_ALT }	)	// Altura do Produto
TRCell():New(oSection1,"B1_LARGURA"	,/*Tabela*/,"Largura"			,PesqPict("SB1","B1_LARGURA")	,TamSX3("B1_LARGURA")[1],/*lPixel*/,{||(cAliasSB1)->B1_LARGURA })	// Largura do Produto
TRCell():New(oSection1,"B1_PROF"	,/*Tabela*/,"Profundidade"		,PesqPict("SB1","B1_PROF")		,TamSX3("B1_PROF")[1]	,/*lPixel*/,{||(cAliasSB1)->B1_PROF }	)	// Profundidade do Produto
TRCell():New(oSection1,"B1_PESO"	,/*Tabela*/,"Peso"				,PesqPict("SB1","B1_PESO")		,TamSX3("B1_PESO")[1]	,/*lPixel*/,{||(cAliasSB1)->B1_PESO }	)	// Peso do Produto
TRCell():New(oSection1,"cGenero1"	,/*Tabela*/,"Genero1"			,""								,TamSX3("Z5_PLATRED")[1],/*lPixel*/,{||IIF(alltrim(cGenero1)=="","0",UPLOW(cGenero1)) 						})	// Genero1 do Produto
TRCell():New(oSection1,"cGenero2"	,/*Tabela*/,"Genero2"			,""								,TamSX3("Z5_PLATRED")[1],/*lPixel*/,{||IIF(alltrim(cGenero2)=="","0",UPLOW(cGenero2)) 						})	// Genero2 do Produto
TRCell():New(oSection1,"cGenero3"	,/*Tabela*/,"Genero3"			,""								,TamSX3("Z5_PLATRED")[1],/*lPixel*/,{||IIF(alltrim(cGenero3)=="","0",UPLOW(cGenero3)) 						})	// Genero3 do Produto
TRCell():New(oSection1,"cGenero4"	,/*Tabela*/,"Genero4"			,""								,TamSX3("Z5_PLATRED")[1],/*lPixel*/,{||IIF(alltrim(cGenero4)=="","0",UPLOW(cGenero4)) 						})	// Genero4 do Produto
TRCell():New(oSection1,"CCLASIND"	,/*Tabela*/,"Classificacao"		,""								,TamSX3("Z5_PLATRED")[1],/*lPixel*/,{||IIF(alltrim(cClasind)=="","0",cClasind)								})	// Classificação indicativa
TRCell():New(oSection1,"B5_NUMJOG"	,/*Tabela*/,"NumeroJogadores"	,PesqPict("SB5","B5_NUMJOG")	,TamSX3("B5_NUMJOG")[1]	,/*lPixel*/,{||IIF(EMPTY((cAliasSB5)->B5_NUMJOG),"0",(cAliasSB5)->B5_NUMJOG)	})	// Número de jogadores
TRCell():New(oSection1,"cVreqsis1"	,/*Tabela*/,"Requisitos1"		,""								,255					,/*lPixel*/,{||IIF(alltrim(cVreqsis1)=="","0",cVreqsis1) 								}) // Requisitos do sistema1
TRCell():New(oSection1,"cVreqsis2"	,/*Tabela*/,"Requisitos2"		,""								,255					,/*lPixel*/,{||IIF(alltrim(cVreqsis2)=="","0",cVreqsis2) 								}) // Requisitos do sistema2
TRCell():New(oSection1,"cVreqsis3"	,/*Tabela*/,"Requisitos3"		,""								,255					,/*lPixel*/,{||IIF(alltrim(cVreqsis3)=="","0",cVreqsis3) 								}) // Requisitos do sistema3
TRCell():New(oSection1,"cVreqsis4"	,/*Tabela*/,"Requisitos4"		,""								,255					,/*lPixel*/,{||IIF(alltrim(cVreqsis4)=="","0",cVreqsis4) 								}) // Requisitos do sistema4
TRCell():New(oSection1,"cVreqsis5"	,/*Tabela*/,"Requisitos5"		,""								,255					,/*lPixel*/,{||IIF(alltrim(cVreqsis5)=="","0",cVreqsis5) 								}) // Requisitos do sistema5
TRCell():New(oSection1,"B5_SINOPS"	,/*Tabela*/,"SinopseReduzida1"	,PesqPict("SB5","B5_SINOPS")	,255					,/*lPixel*/,{||IIF(EMPTY(SUBSTR((cAliasSB5)->B5_SINOPS,1,255)),"0",SUBSTR((cAliasSB5)->B5_SINOPS,1,255))})// Sinopse reduzida
TRCell():New(oSection1,"B5_SINOPS"	,/*Tabela*/,"SinopseReduzida2"	,PesqPict("SB5","B5_SINOPS")	,255					,/*lPixel*/,{||IIF(EMPTY(SUBSTR((cAliasSB5)->B5_SINOPS,256,255)),"0",SUBSTR((cAliasSB5)->B5_SINOPS,256,255))})// Sinopse reduzida
TRCell():New(oSection1,"B5_SINOPS"	,/*Tabela*/,"SinopseReduzida3"	,PesqPict("SB5","B5_SINOPS")	,255					,/*lPixel*/,{||IIF(EMPTY(SUBSTR((cAliasSB5)->B5_SINOPS,511,255)),"0",SUBSTR((cAliasSB5)->B5_SINOPS,511,255))})	// Sinopse reduzida
TRCell():New(oSection1,"cSINOPSE1"	,/*Tabela*/,"SinopseCompleta1"	,PesqPict("SB5","B5_SINOPSE")	,255					,/*lPixel*/,{||IIF(alltrim(cSINOPSE1)=="","0",cSINOPSE1) 								})	// Sinopse reduzida1
TRCell():New(oSection1,"cSINOPSE2"	,/*Tabela*/,"SinopseCompleta2"	,PesqPict("SB5","B5_SINOPSE")	,255					,/*lPixel*/,{||IIF(alltrim(cSINOPSE2)=="","0",cSINOPSE2) 								})	// Sinopse reduzida2
TRCell():New(oSection1,"cSINOPSE3"	,/*Tabela*/,"SinopseCompleta3"	,PesqPict("SB5","B5_SINOPSE")	,255					,/*lPixel*/,{||IIF(alltrim(cSINOPSE3)=="","0",cSINOPSE3) 								})	// Sinopse reduzida3
TRCell():New(oSection1,"cSINOPSE4"	,/*Tabela*/,"SinopseCompleta4"	,PesqPict("SB5","B5_SINOPSE")	,255					,/*lPixel*/,{||IIF(alltrim(cSINOPSE4)=="","0",cSINOPSE4) 								})	// Sinopse reduzida4
TRCell():New(oSection1,"cSINOPSE5"	,/*Tabela*/,"SinopseCompleta5"	,PesqPict("SB5","B5_SINOPSE")	,255					,/*lPixel*/,{||IIF(alltrim(cSINOPSE5)=="","0",cSINOPSE5) 								})	// Sinopse reduzida5
TRCell():New(oSection1,"cSINOPSE6"	,/*Tabela*/,"SinopseCompleta6"	,PesqPict("SB5","B5_SINOPSE")	,255					,/*lPixel*/,{||IIF(alltrim(cSINOPSE6)=="","0",cSINOPSE6) 								})	// Sinopse reduzida6
TRCell():New(oSection1,"cSINOPSE7"	,/*Tabela*/,"SinopseCompleta7"	,PesqPict("SB5","B5_SINOPSE")	,255					,/*lPixel*/,{||IIF(alltrim(cSINOPSE7)=="","0",cSINOPSE7) 								})	// Sinopse reduzida7
TRCell():New(oSection1,"cSINOPSE8"	,/*Tabela*/,"SinopseCompleta8"	,PesqPict("SB5","B5_SINOPSE")	,255					,/*lPixel*/,{||IIF(alltrim(cSINOPSE8)=="","0",cSINOPSE8) 								})	// Sinopse reduzida8
TRCell():New(oSection1,"cSINOPSE9"	,/*Tabela*/,"SinopseCompleta9"	,PesqPict("SB5","B5_SINOPSE")	,255					,/*lPixel*/,{||IIF(alltrim(cSINOPSE9)=="","0",cSINOPSE9) 								})	// Sinopse reduzida9
TRCell():New(oSection1,"B5_LINKA"	,/*Tabela*/,"Links"				,PesqPict("SB5","B5_LINKA")		,TamSX3("B5_LINKA")[1]	,/*lPixel*/,{||IIF(EMPTY((cAliasSB5)->B5_LINKA),"0",(cAliasSB5)->B5_LINKA)		})// Links
TRCell():New(oSection1,"B5_TAG1"	,/*Tabela*/,"Tag1"				,PesqPict("SB5","B5_TAG1")		,TamSX3("B5_TAG1")[1]	,/*lPixel*/,{||IIF(EMPTY((cAliasSB5)->B5_TAG1),"0",(cAliasSB5)->B5_TAG1)		})// TAG1
TRCell():New(oSection1,"B5_TAG2"	,/*Tabela*/,"Tag2"				,PesqPict("SB5","B5_TAG2")		,TamSX3("B5_TAG2")[1]	,/*lPixel*/,{||IIF(EMPTY((cAliasSB5)->B5_TAG2),"0",(cAliasSB5)->B5_TAG2)		})// TAG2
TRCell():New(oSection1,"B5_TAG3"	,/*Tabela*/,"Tag3"				,PesqPict("SB5","B5_TAG3")		,TamSX3("B5_TAG3")[1]	,/*lPixel*/,{||IIF(EMPTY((cAliasSB5)->B5_TAG3),"0",(cAliasSB5)->B5_TAG3)		})// TAG3
TRCell():New(oSection1,"B5_TAG4"	,/*Tabela*/,"Tag4"				,PesqPict("SB5","B5_TAG4")		,TamSX3("B5_TAG4")[1]	,/*lPixel*/,{||IIF(EMPTY((cAliasSB5)->B5_TAG4),"0",(cAliasSB5)->B5_TAG4)		})// TAG4
TRCell():New(oSection1,"B5_TAG5"	,/*Tabela*/,"Tag5"				,PesqPict("SB5","B5_TAG5")		,TamSX3("B5_TAG5")[1]	,/*lPixel*/,{||IIF(EMPTY((cAliasSB5)->B5_TAG5),"0",(cAliasSB5)->B5_TAG5)		})// TAG5
TRCell():New(oSection1,"B5_TAG6"	,/*Tabela*/,"Tag6"				,PesqPict("SB5","B5_TAG6")		,TamSX3("B5_TAG6")[1]	,/*lPixel*/,{||IIF(EMPTY((cAliasSB5)->B5_TAG6),"0",(cAliasSB5)->B5_TAG6)		})// TAG6
TRCell():New(oSection1,"B5_TAG7"	,/*Tabela*/,"Tag7"				,PesqPict("SB5","B5_TAG7")		,TamSX3("B5_TAG7")[1]	,/*lPixel*/,{||IIF(EMPTY((cAliasSB5)->B5_TAG7),"0",(cAliasSB5)->B5_TAG7)		})// TAG7
TRCell():New(oSection1,"B5_TAG8"	,/*Tabela*/,"Tag8"				,PesqPict("SB5","B5_TAG8")		,TamSX3("B5_TAG8")[1]	,/*lPixel*/,{||IIF(EMPTY((cAliasSB5)->B5_TAG8),"0",(cAliasSB5)->B5_TAG8)		})// TAG8
TRCell():New(oSection1,"B5_TAG9"	,/*Tabela*/,"Tag9"				,PesqPict("SB5","B5_TAG9")		,TamSX3("B5_TAG9")[1]	,/*lPixel*/,{||IIF(EMPTY((cAliasSB5)->B5_TAG9),"0",(cAliasSB5)->B5_TAG9)		})// TAG9
TRCell():New(oSection1,"B5_TAG10"	,/*Tabela*/,"Tag10"				,PesqPict("SB5","B5_TAG10")		,TamSX3("B5_TAG10")[1]	,/*lPixel*/,{||IIF(EMPTY((cAliasSB5)->B5_TAG10),"0",(cAliasSB5)->B5_TAG10)		})// TAG10
TRCell():New(oSection1,"B5_PROMCON"	,/*Tabela*/,"PromocaoAssociadaConsumidor1",PesqPict("SB5","B5_PROMCON"),TamSX3("B5_PROMCON")[1],/*lPixel*/,{||IIF(EMPTY(substr((cAliasSB5)->B5_PROMCON,1,255)),"0",substr((cAliasSB5)->B5_PROMCON,1,255))})// Promoção consumidor
TRCell():New(oSection1,"B5_PROMCON"	,/*Tabela*/,"PromocaoAssociadaConsumidor2",PesqPict("SB5","B5_PROMCON"),TamSX3("B5_PROMCON")[1],/*lPixel*/,{||IIF(EMPTY(substr((cAliasSB5)->B5_PROMCON,256,255)),"0",substr((cAliasSB5)->B5_PROMCON,256,255))})// Promoção consumidor
TRCell():New(oSection1,"B5_PROMCON"	,/*Tabela*/,"PromocaoAssociadaConsumidor3",PesqPict("SB5","B5_PROMCON"),TamSX3("B5_PROMCON")[1],/*lPixel*/,{||IIF(EMPTY(substr((cAliasSB5)->B5_PROMCON,511,255)),"0",substr((cAliasSB5)->B5_PROMCON,511,255))})// Promoção consumidor
TRCell():New(oSection1,"B5_PROMREV"	,/*Tabela*/,"PromocaoAssociadaRevenda1",PesqPict("SB5","B5_PROMREV"),TamSX3("B5_PROMREV")[1],/*lPixel*/,{||IIF(EMPTY(substr((cAliasSB5)->B5_PROMREV,1,255)),"0",substr((cAliasSB5)->B5_PROMREV,1,255))}	)// Promoção revenda
TRCell():New(oSection1,"B5_PROMREV"	,/*Tabela*/,"PromocaoAssociadaRevenda2",PesqPict("SB5","B5_PROMREV"),TamSX3("B5_PROMREV")[1],/*lPixel*/,{||IIF(EMPTY(substr((cAliasSB5)->B5_PROMREV,256,255)),"0",substr((cAliasSB5)->B5_PROMREV,256,255))}	)// Promoção revenda
TRCell():New(oSection1,"B5_PROMREV"	,/*Tabela*/,"PromocaoAssociadaRevenda3",PesqPict("SB5","B5_PROMREV"),TamSX3("B5_PROMREV")[1],/*lPixel*/,{||IIF(EMPTY(substr((cAliasSB5)->B5_PROMREV,511,255)),"0",substr((cAliasSB5)->B5_PROMREV,511,255))}	)// Promoção revenda
TRCell():New(oSection1,"B5_INFCONS"	,/*Tabela*/,"InformacaoAdicionalConsumidor1",PesqPict("SB5","B5_INFCONS"),TamSX3("B5_INFCONS")[1],/*lPixel*/,{||IIF(EMPTY(substr((cAliasSB5)->B5_INFCONS,1,255)),"0",substr((cAliasSB5)->B5_INFCONS,1,255))}	)// Informação consumidor
TRCell():New(oSection1,"B5_INFCONS"	,/*Tabela*/,"InformacaoAdicionalConsumidor2",PesqPict("SB5","B5_INFCONS"),TamSX3("B5_INFCONS")[1],/*lPixel*/,{||IIF(EMPTY(substr((cAliasSB5)->B5_INFCONS,256,255)),"0",substr((cAliasSB5)->B5_INFCONS,256,255))}	)// Informação consumidor
TRCell():New(oSection1,"B5_INFCONS"	,/*Tabela*/,"InformacaoAdicionalConsumidor3",PesqPict("SB5","B5_INFCONS"),TamSX3("B5_INFCONS")[1],/*lPixel*/,{||IIF(EMPTY(substr((cAliasSB5)->B5_INFCONS,511,255)),"0",substr((cAliasSB5)->B5_INFCONS,511,255))}	)// Informação consumidor
TRCell():New(oSection1,"B5_INFREV"	,/*Tabela*/,"InformacaoAdicionalRevenda1",PesqPict("SB5","B5_INFREV"),TamSX3("B5_INFREV")[1],/*lPixel*/,{||IIF(EMPTY(substr((cAliasSB5)->B5_INFREV,1,255)),"0",substr((cAliasSB5)->B5_INFREV,1,255))}	)// Informação revenda
TRCell():New(oSection1,"B5_INFREV"	,/*Tabela*/,"InformacaoAdicionalRevenda2",PesqPict("SB5","B5_INFREV"),TamSX3("B5_INFREV")[1],/*lPixel*/,{||IIF(EMPTY(substr((cAliasSB5)->B5_INFREV,256,255)),"0",substr((cAliasSB5)->B5_INFREV,256,255))}	)// Informação revenda
TRCell():New(oSection1,"B5_INFREV"	,/*Tabela*/,"InformacaoAdicionalRevenda3",PesqPict("SB5","B5_INFREV"),TamSX3("B5_INFREV")[1],/*lPixel*/,{||IIF(EMPTY(substr((cAliasSB5)->B5_INFREV,511,255)),"0",substr((cAliasSB5)->B5_INFREV,511,255))}	)// Informação revenda
TRCell():New(oSection1,"B5_NUMVID"	,/*Tabela*/,"NumeroVideo"	,PesqPict("SB5","B5_NUMVID")	,TamSX3("B5_NUMVID")[1]	,/*lPixel*/,{||IIF(EMPTY((cAliasSB5)->B5_NUMVID),"0",(cAliasSB5)->B5_NUMVID)		})// Numero Video
TRCell():New(oSection1,"B5_FICHTEC"	,/*Tabela*/,"NumeroFichaTecnica",PesqPict("SB5","B5_FICHTEC"),TamSX3("B5_FICHTEC")[1]	,/*lPixel*/,{||IIF(EMPTY((cAliasSB5)->B5_FICHTEC),"0",(cAliasSB5)->B5_FICHTEC)	})// Ficha tecnica
TRCell():New(oSection1,"B5_TEXTVID"	,/*Tabela*/,"TextoVideo"	,PesqPict("SB5","B5_TEXTVID")	,TamSX3("B5_TEXTVID")[1]	,/*lPixel*/,{||IIF(EMPTY((cAliasSB5)->B5_TEXTVID),"0",(cAliasSB5)->B5_TEXTVID)	})// Texto Video
TRCell():New(oSection1,"B5_TEXTDEM"	,/*Tabela*/,"TextoDemo"		,PesqPict("SB5","B5_TEXTDEM")	,TamSX3("B5_TEXTDEM")[1]	,/*lPixel*/,{||IIF(EMPTY((cAliasSB5)->B5_TEXTDEM),"0",(cAliasSB5)->B5_TEXTDEM)	})// Texto demo
TRCell():New(oSection1,"cVsint1"	,/*Tabela*/,"SinopseTitulo1",PesqPict("SB5","B5_VSINTIT")	,255						,/*lPixel*/,{||IIF(alltrim(cVsint1)=="","0",cVsint1) 									})// Sinopse titulo
TRCell():New(oSection1,"cVsint2"	,/*Tabela*/,"SinopseTitulo2",PesqPict("SB5","B5_VSINTIT")	,255						,/*lPixel*/,{||IIF(alltrim(cVsint2)=="","0",cVsint2) 									})// Sinopse titulo
TRCell():New(oSection1,"cVsint3"	,/*Tabela*/,"SinopseTitulo3",PesqPict("SB5","B5_VSINTIT")	,255						,/*lPixel*/,{||IIF(alltrim(cVsint3)=="","0",cVsint3) 									})// Sinopse titulo
TRCell():New(oSection1,"cVsint4"	,/*Tabela*/,"SinopseTitulo4",PesqPict("SB5","B5_VSINTIT")	,255						,/*lPixel*/,{||IIF(alltrim(cVsint4)=="","0",cVsint4) 									})// Sinopse titulo
TRCell():New(oSection1,"cVsint5"	,/*Tabela*/,"SinopseTitulo5",PesqPict("SB5","B5_VSINTIT")	,255						,/*lPixel*/,{||IIF(alltrim(cVsint5)=="","0",cVsint5) 									})// Sinopse titulo
TRCell():New(oSection1,"cVsint6"	,/*Tabela*/,"SinopseTitulo6",PesqPict("SB5","B5_VSINTIT")	,255						,/*lPixel*/,{||IIF(alltrim(cVsint6)=="","0",cVsint6) 									})// Sinopse titulo
TRCell():New(oSection1,"cVsint7"	,/*Tabela*/,"SinopseTitulo7",PesqPict("SB5","B5_VSINTIT")	,255						,/*lPixel*/,{||IIF(alltrim(cVsint7)=="","0",cVsint7) 									})// Sinopse titulo
TRCell():New(oSection1,"cVsint8"	,/*Tabela*/,"SinopseTitulo8",PesqPict("SB5","B5_VSINTIT")	,255						,/*lPixel*/,{||IIF(alltrim(cVsint8)=="","0",cVsint8) 									})// Sinopse titulo
TRCell():New(oSection1,"cVsint9"	,/*Tabela*/,"SinopseTitulo9",PesqPict("SB5","B5_VSINTIT")	,255						,/*lPixel*/,{||IIF(alltrim(cVsint9)=="","0",cVsint9) 									})// Sinopse titulo
TRCell():New(oSection1,""	,/*Tabela*/,"ImagemPromocao",PesqPict("SB1","B1_COD")	,TamSX3("B1_COD")[1]					,/*lPixel*/,{||"0" 																})// Imagem da promoção
TRCell():New(oSection1,"B1_ECIV"		,/*Tabela*/,"CIV"			,PesqPict("SB1","B1_ECIV")	,6							,/*lPixel*/,{||IIF(EMPTY((cAliasSB1)->B1_ECIV),"0",(cAliasSB1)->B1_ECIV)})// CIV
TRCell():New(oSection1,"B1_OLD"			,/*Tabela*/,"CIF"			,PesqPict("SB1","B1_OLD")	,TamSX3("B1_OLD")[1]		,/*lPixel*/,{||IIF(EMPTY((cAliasSB1)->B1_OLD),"0",(cAliasSB1)->B1_OLD) 				})// CIF

//oSection2 := TRSection():New(oReport,"Complementos"	,"SB5")

Return oReport

/*
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Processamento das informações     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/

Static Function PrintReport(oReport,cAliasSB1,cAliasSB5,cAliasQRY)
Local oSection1 := oReport:Section(1)
Local oSection2 := oReport:Section(1):Section(1)
Local cFiltro   := ""

oReport:Section(1):Cell("NSEQSTR"  	):SetBlock({|| nSeqstr 	})
oReport:Section(1):Cell("CPLATRED"  ):SetBlock({|| cPlatred })
oReport:Section(1):Cell("CPLATEXT"  ):SetBlock({|| cPlatext })
oReport:Section(1):Cell("CCLASIND"  ):SetBlock({|| cClasind })
oReport:Section(1):Cell("cVsint1"   ):SetBlock({|| cVsint1 })
oReport:Section(1):Cell("cVsint2"   ):SetBlock({|| cVsint2 })
oReport:Section(1):Cell("cVsint3"   ):SetBlock({|| cVsint3 })
oReport:Section(1):Cell("cVsint4"   ):SetBlock({|| cVsint4 })
oReport:Section(1):Cell("cVsint5"   ):SetBlock({|| cVsint5 })
oReport:Section(1):Cell("cVsint6"   ):SetBlock({|| cVsint6 })
oReport:Section(1):Cell("cVsint7"   ):SetBlock({|| cVsint7 })
oReport:Section(1):Cell("cVsint8"   ):SetBlock({|| cVsint8 })
oReport:Section(1):Cell("cVsint9"   ):SetBlock({|| cVsint9 })
oReport:Section(1):Cell("cVreqsis1" ):SetBlock({|| cVreqsis1 })
oReport:Section(1):Cell("cVreqsis2" ):SetBlock({|| cVreqsis2 })
oReport:Section(1):Cell("cVreqsis3" ):SetBlock({|| cVreqsis3 })
oReport:Section(1):Cell("cVreqsis4" ):SetBlock({|| cVreqsis4 })
oReport:Section(1):Cell("cVreqsis5" ):SetBlock({|| cVreqsis5 })
oReport:Section(1):Cell("cGenero1" ):SetBlock({|| cGenero1 })
oReport:Section(1):Cell("cGenero2" ):SetBlock({|| cGenero2 })
oReport:Section(1):Cell("cGenero3" ):SetBlock({|| cGenero3 })
oReport:Section(1):Cell("cGenero4" ):SetBlock({|| cGenero4 })
oReport:Section(1):Cell("cVBUNDLE1" ):SetBlock({|| cVBUNDLE1 })
oReport:Section(1):Cell("cVBUNDLE2" ):SetBlock({|| cVBUNDLE2 })
oReport:Section(1):Cell("cVBUNDLE3" ):SetBlock({|| cVBUNDLE3 })
oReport:Section(1):Cell("cPREVENTR" ):SetBlock({|| cPREVENTR })
oReport:Section(1):Cell("cSINOPSE1" ):SetBlock({|| cSINOPSE1 })
oReport:Section(1):Cell("cSINOPSE2" ):SetBlock({|| cSINOPSE2 })
oReport:Section(1):Cell("cSINOPSE3" ):SetBlock({|| cSINOPSE3 })
oReport:Section(1):Cell("cSINOPSE4" ):SetBlock({|| cSINOPSE4 })
oReport:Section(1):Cell("cSINOPSE5" ):SetBlock({|| cSINOPSE5 })
oReport:Section(1):Cell("cSINOPSE6" ):SetBlock({|| cSINOPSE6 })
oReport:Section(1):Cell("cSINOPSE7" ):SetBlock({|| cSINOPSE7 })
oReport:Section(1):Cell("cSINOPSE8" ):SetBlock({|| cSINOPSE8 })
oReport:Section(1):Cell("cSINOPSE9" ):SetBlock({|| cSINOPSE9 })
oReport:Section(1):Cell("cLANC"		):SetBlock({|| cLANC	 })


cFiltro	:= "%"
If MV_PAR07 == 2
	cFiltro	+= " B1_MSBLQL <> '1' AND "
EndIf
If MV_PAR08 == 2
	cFiltro	+= " B1_BLQVEND <> '1' AND "
EndIf
cFiltro	+= "%"

////////////////////////
cQRYcount	:= "TRBCNT"
BeginSql alias cQRYcount
	SELECT COUNT(*) QTD
	FROM %table:SB1% SB1,%table:SB5% SB5
	WHERE %Exp:cFiltro%
	B1_COD = B5_COD AND B1_FILIAL = %xfilial:SB1% AND
	B1_FILIAL = B5_FILIAL AND SB1.%notDel% AND
	B1_COD BETWEEN %exp:MV_PAR01% AND %exp:MV_PAR02% AND
	B1_GRUPO BETWEEN %exp:MV_PAR03% AND %exp:MV_PAR04% AND
	B1_TIPO BETWEEN %exp:MV_PAR05% AND %exp:MV_PAR06%
EndSql
nInc	:= (cQRYcount)->QTD
dbclosearea(cQRYcount)
///////////////////////

oSection1:BeginQuery()

BeginSql alias cAliasQRY
	SELECT SB1.*
	FROM %table:SB1% SB1,%table:SB5% SB5
	WHERE %Exp:cFiltro%
	B1_COD = B5_COD AND B1_FILIAL = %xfilial:SB1% AND
	B1_FILIAL = B5_FILIAL AND SB1.%notDel% AND
	B1_COD BETWEEN %exp:MV_PAR01% AND %exp:MV_PAR02% AND
	B1_GRUPO BETWEEN %exp:MV_PAR03% AND %exp:MV_PAR04% AND
	B1_TIPO BETWEEN %exp:MV_PAR05% AND %exp:MV_PAR06%
	ORDER BY SB5.B5_FOCO, SB5.B5_DTLAN DESC, SB1.B1_COD
EndSql

oSection1:EndQuery()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Impressao do Relatorio                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:Section(1):Init()
//dbSelectArea(cAliasSB1)
//nInc	:= reccount()
//alert(nInc)
oReport:SetMeter(nInc)
nSeq	:= 0
CPLATRED:= ""
CPLATEXT:= ""
cCeme	:= ""
cVsint1 := ""
cVsint2 := ""
cVsint3 := ""
cVsint4 := ""
cVsint5 := ""
cVsint6 := ""
cVsint7 := ""
cVsint8 := ""
cVsint9 := ""
cVreqsis1 	:= ""
cVreqsis2 	:= ""
cVreqsis3 	:= ""
cVreqsis4 	:= ""
cVreqsis5 	:= ""
cGenero1	:= ""
cGenero2	:= ""
cGenero3	:= ""
cGenero4	:= ""
cVBUNDLE1	:= ""
cVBUNDLE2	:= ""
cVBUNDLE3	:= ""
cPREVENTR	:= ""
cSINOPSE1 	:= ""
cSINOPSE2 	:= ""
cSINOPSE3 	:= ""
cSINOPSE4 	:= ""
cSINOPSE5 	:= ""
cSINOPSE6 	:= ""
cSINOPSE7 	:= ""
cSINOPSE8 	:= ""
cSINOPSE9 	:= ""
cLANC	 	:= ""
dDatamax	:= ddatabase - 90
//alert(dDatamax)

While !oReport:Cancel() .And. !(cAliasQRY)->(EOF()) .And. xFilial("SB1")==(cAliasQRY)->B1_FILIAL
	
	oReport:IncMeter()
	If oReport:Cancel()
		Exit
	EndIf
	
	DBSELECTAREA("SB1")
	DBSETORDER(1)
	DBGOTOP()
	DBSEEK(XFILIAL("SB1")+(cAliasQRY)->B1_COD)
	
	If (cAliasSB1)->B1_COD < MV_PAR01 .or. (cAliasSB1)->B1_COD > MV_PAR02
		dbSelectArea(cAliasSB1)
		dbCloseArea()
		dbSelectArea(cAliasQRY)
		dbSkip()
		loop
	EndIf
	If (cAliasSB1)->B1_GRUPO < MV_PAR03 .or. (cAliasSB1)->B1_GRUPO > MV_PAR04
		dbSelectArea(cAliasSB1)
		dbCloseArea()
		dbSelectArea(cAliasQRY)
		dbSkip()
		loop
	EndIf
	If (cAliasSB1)->B1_TIPO < MV_PAR05 .or. (cAliasSB1)->B1_TIPO > MV_PAR06
		dbSelectArea(cAliasSB1)
		dbCloseArea()
		dbSelectArea(cAliasQRY)
		dbSkip()
		loop
	EndIf
	
	cPlatred	:= getadvfval("SZ5","Z5_PLATRED",xFilial("SZ5")+strzero(val((cAliasSB1)->B1_PLATAF),6),1,"")
	cPlatred	:= if(alltrim(cPlatred)=="","0",cPlatred)
	
	cPlatExt	:= getadvfval("SZ5","Z5_PLATEXT",xFilial("SZ5")+strzero(val((cAliasSB1)->B1_PLATAF),6),1,"")
	cPlatExt	:= if(alltrim(cPlatExt)=="","0",cPlatExt)
	
	cGenero1	:= uplow(getadvfval("SX5","X5_DESCSPA",xFilial("SX5")+"Z2"+(cAliasSB1)->B1_CODGEN,1,""))
	cGenero1	:= if(alltrim(cGenero1)=="","0",cGenero1)
	
	If UPPER(SUBSTR((cAliasSB1)->B1_OLD,1,2)) == "LI"
		cClasind	:= "Livre"
	Else
		cClasind	:= SUBSTR((cAliasSB1)->B1_OLD,1,2)+" Anos"
	EndIf
	if empty((cAliasSB1)->B1_OLD)
		cClasind	:= "0"
	EndIf	
	
	clinvreqsis	:= ""
	clinvsint := ""
	cVBUNDLE	:= ""
	cGenero2	:= ""
	cGenero3	:= ""
	cGenero4	:= ""
	//leitura do campo memo conteudo
	dbselectarea("SB5")
	dbsetorder(1)
	If dbseek(xfilial("SB5")+(cAliasSB1)->B1_COD)
		
		cGenero2	:= uplow(getadvfval("SX5","X5_DESCSPA",xFilial("SX5")+"Z2"+(cAliasSB5)->B5_GENERO1,1,""))
		cGenero2	:= if(alltrim(cGenero2)=="","0",cGenero2)
		
		cGenero3	:= uplow(getadvfval("SX5","X5_DESCSPA",xFilial("SX5")+"Z2"+(cAliasSB5)->B5_GENERO2,1,""))
		cGenero3	:= if(alltrim(cGenero3)=="","0",cGenero3)
		
		cGenero4	:= uplow(getadvfval("SX5","X5_DESCSPA",xFilial("SX5")+"Z2"+(cAliasSB5)->B5_GENERO3,1,""))
		cGenero4	:= if(alltrim(cGenero4)=="","0",cGenero4)
		
		cLANC	:= "0"
		If SB5->B5_DTLAN > dDataMax
			cLANC	:= "1"
		EndIf
		
		nMes	:= month(SB5->B5_PREVCHE)
		cMesExt	:= ""
		If nMes == 1
			cMesExt	:= "Jan"
		ElseIf nMes == 2
			cMesExt	:= "Fev"
		ElseIf nMes == 3
			cMesExt	:= "Mar"
		ElseIf nMes == 4
			cMesExt	:= "Abr"
		ElseIf nMes == 5
			cMesExt	:= "Mai"
		ElseIf nMes == 6
			cMesExt	:= "Jun"
		ElseIf nMes == 7
			cMesExt	:= "Jul"
		ElseIf nMes == 8
			cMesExt	:= "Ago"
		ElseIf nMes == 9
			cMesExt	:= "Set"
		ElseIf nMes == 10
			cMesExt	:= "Out"
		ElseIf nMes == 11
			cMesExt	:= "Nov"
		ElseIf nMes == 12
			cMesExt	:= "Dez"
		EndIf
		cPREVENTR	:= ""
		If SB5->B5_PREVCHE > ddatabase
			IF DAY(SB5->B5_PREVCHE) == 1
				cPREVENTR := cMesExt+"/"+alltrim(STR(YEAR(SB5->B5_PREVCHE)))+" (1ªQuinz)"
			ELSEIF DAY(SB5->B5_PREVCHE) == 15
				cPREVENTR := cMesExt+"/"+alltrim(STR(YEAR(SB5->B5_PREVCHE)))+" (2ªQuinz)"
			ELSE
				cPREVENTR := SB5->B5_PREVCHE
			ENDIF
		Else
			cPREVENTR	:= "0"
		EndIf
		
		nlinvsint := mlcount(SB5->B5_VSINTIT)
		clinvsint := ""
		For nx := 1 to nlinvsint
			clinvsint += if(right(MemoLine( SB5->B5_VSINTIT,,nx ),1) == " ",alltrim(MemoLine( SB5->B5_VSINTIT,,nx ))+" ",alltrim(MemoLine( SB5->B5_VSINTIT,,nx )))
		Next nx
		
		
		cVsint1 := if(alltrim(substr(clinvsint,   1,255))=="","0",substr(clinvsint,   1,255))
		cVsint2 := if(alltrim(substr(clinvsint, 256,255))=="","0",substr(clinvsint, 256,255))
		cVsint3 := if(alltrim(substr(clinvsint, 511,255))=="","0",substr(clinvsint, 511,255))
		cVsint4 := if(alltrim(substr(clinvsint, 766,255))=="","0",substr(clinvsint, 766,255))
		cVsint5 := if(alltrim(substr(clinvsint,1021,255))=="","0",substr(clinvsint,1021,255))
		cVsint6 := if(alltrim(substr(clinvsint,1276,255))=="","0",substr(clinvsint,1276,255))
		cVsint7 := if(alltrim(substr(clinvsint,1531,255))=="","0",substr(clinvsint,1531,255))
		cVsint8 := if(alltrim(substr(clinvsint,1786,255))=="","0",substr(clinvsint,1786,255))
		cVsint9 := if(alltrim(substr(clinvsint,2041,255))=="","0",substr(clinvsint,2041,255))
		
		//	B5_VREQSIS
		//leitura do campo memo conteudo
		nlinvreqsis := mlcount(SB5->B5_VREQSIS)
		clinvreqsis	:= ""
		For nx := 1 to nlinvreqsis
			clinvreqsis += if(right(MemoLine( SB5->B5_VREQSIS,,nx ),1) == " ",alltrim(MemoLine( SB5->B5_VREQSIS,,nx ))+" ",alltrim(MemoLine( SB5->B5_VREQSIS,,nx )))
		Next nx
		
		cVreqsis1 := if(alltrim(substr(clinvreqsis,   1,255))=="","0",substr(clinvreqsis,   1,255))
		cVreqsis2 := if(alltrim(substr(clinvreqsis, 256,255))=="","0",substr(clinvreqsis, 256,255))
		cVreqsis3 := if(alltrim(substr(clinvreqsis, 511,255))=="","0",substr(clinvreqsis, 511,255))
		cVreqsis4 := if(alltrim(substr(clinvreqsis, 766,255))=="","0",substr(clinvreqsis, 766,255))
		cVreqsis5 := if(alltrim(substr(clinvreqsis,1021,255))=="","0",substr(clinvreqsis,1021,255))
		
		//(cAliasSB5)->B5_SINOPSE
		nlinSINOPSE := mlcount(SB5->B5_SINOPSE)
		clinSINOPSE	:= ""
		For nx := 1 to nlinSINOPSE
			clinSINOPSE += if(right(MemoLine( SB5->B5_SINOPSE,,nx ),1) == " ",alltrim(MemoLine( SB5->B5_SINOPSE,,nx ))+" ",alltrim(MemoLine( SB5->B5_SINOPSE,,nx )))
		Next nx
		
		cSINOPSE1 := if(alltrim(substr(clinSINOPSE,   1,255))=="","0",substr(clinSINOPSE,   1,255))
		cSINOPSE2 := if(alltrim(substr(clinSINOPSE, 256,255))=="","0",substr(clinSINOPSE, 256,255))
		cSINOPSE3 := if(alltrim(substr(clinSINOPSE, 511,255))=="","0",substr(clinSINOPSE, 511,255))
		cSINOPSE4 := if(alltrim(substr(clinSINOPSE, 766,255))=="","0",substr(clinSINOPSE, 766,255))
		cSINOPSE5 := if(alltrim(substr(clinSINOPSE,1021,255))=="","0",substr(clinSINOPSE,1021,255))
		cSINOPSE6 := if(alltrim(substr(clinSINOPSE,1276,255))=="","0",substr(clinSINOPSE,1276,255))
		cSINOPSE7 := if(alltrim(substr(clinSINOPSE,1531,255))=="","0",substr(clinSINOPSE,1531,255))
		cSINOPSE8 := if(alltrim(substr(clinSINOPSE,1786,255))=="","0",substr(clinSINOPSE,1786,255))
		cSINOPSE9 := if(alltrim(substr(clinSINOPSE,2041,255))=="","0",substr(clinSINOPSE,2041,255))
		
		//conteudo
		nlinVBUNDLE := mlcount(SB5->B5_VBUNDLE)
		cVBUNDLE	:= ""
		For nx := 1 to nlinVBUNDLE
			cVBUNDLE += if(right(MemoLine( SB5->B5_VBUNDLE,,nx ),1) == " ",alltrim(MemoLine( SB5->B5_VBUNDLE,,nx ))+" ",alltrim(MemoLine( SB5->B5_VBUNDLE,,nx )))
		Next nx

		cVBUNDLE1 := if(alltrim(substr(cVBUNDLE,   1,255))=="","0",substr(cVBUNDLE,   1,255))
		cVBUNDLE2 := if(alltrim(substr(cVBUNDLE, 256,255))=="","0",substr(cVBUNDLE, 256,255))
		cVBUNDLE3 := if(alltrim(substr(cVBUNDLE, 511,255))=="","0",substr(cVBUNDLE, 511,255))
		
	Else
		dbSelectArea("SB5")
		dbCloseArea()
		dbSelectArea(cAliasSB1)
		dbCloseArea()
		dbSelectArea(cAliasQRY)
		dbSkip()
		loop
	EndIf
	
	If alltrim((cAliasSB5)->B5_FOCO) == "1"
		If valtype(nSeq) == "C"
			nSeq:= 0
		EndIf
		nSeq++
		nSeqstr	:= alltrim(str(nSeq))
	Else
		nSeq:= 0
		nSeqstr	:= alltrim(str(nSeq))
	EndIf
	
	oReport:Section(1):PrintLine()
	dbSelectArea("SB5")
	dbCloseArea()
	dbSelectArea(cAliasSB1)
	dbCloseArea()
	dbSelectArea(cAliasQRY)
	dbSkip()
	
END

oReport:Section(1):Finish()
oReport:Section(1):Init()
dbselectarea(cAliasQRY)
dbCloseArea()

Return



//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Função para converter string (frase) para que o primeiro caractere de cada palavra seja maiúsculo e o restante minúsculo³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Static Function UPLOW(calias)

cVar	:= ""
aUPLOW	:= StrTokArr ( calias+" ", " ")
For nx := 1 to len(aUPLOW)
	If nx <> 1
		cVar	+= " "
	EndIf
	If SUBSTR(upper(substr(alltrim(aUPLOW[nx]),1,4)+"   "),1,3) $ "A   /E   /I   /O   /U   /DE  /DA  /DO  /AO  /OS  /ATÉ /ATE /NAS /NOS /EM  /UM  /UMA /QUE "
		cVar += lower(aUPLOW[nx])
	ElseIf SUBSTR(upper(substr(alltrim(aUPLOW[nx]),1,4)+"   "),1,3) $ "EA  /THQ /3D  "
		cVar += upper(aUPLOW[nx])	
	Else
		cVar += upper(substr(aUPLOW[nx],1,1))+lower(substr(aUPLOW[nx],2,len(aUPLOW[nx])))
	EndIf
Next nx

Return(cVar)



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³AjustaSX1 ³ Autor ³Rodrigo Okamoto        ³ Data ³14/03/2011³±±
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

Aadd( aHelpP, "Produto de ? " )
PutSx1("EXPSTE","01","Produto de ?     "  ,"Produto de ?     ","Produto de ?     ","mv_ch1","C",15,0,0,"G","","SB1","","","mv_par01","","","","","","","","","","","","","","","","",aHelpP)
//³ mv_par01        // Data de                  		         ³

aHelpP	:= {}
Aadd( aHelpP, "Produto ate ? " )
PutSx1("EXPSTE","02","Produto ate ?     "  ,"Produto ate ?     ","Produto ate ?  ","mv_ch2","C",15,0,0,"G","","SB1","","","mv_par02","","","","","","","","","","","","","","","","",aHelpP)

aHelpP	:= {}
Aadd( aHelpP, "Grupo de ? " )
PutSx1("EXPSTE","03","Grupo de ?     "  ,"Grupo de ?     ","Grupo de ?           ","mv_ch3","C",4,0,0,"G","","SBM","","","mv_par03","","","","","","","","","","","","","","","","",aHelpP)

aHelpP	:= {}
Aadd( aHelpP, "Grupo ate ? " )
PutSx1("EXPSTE","04","Grupo ate ?    "  ,"Grupo ate ?    ","Grupo ate ?          ","mv_ch4","C",4,0,0,"G","","SBM","","","mv_par04","","","","","","","","","","","","","","","","",aHelpP)

aHelpP	:= {}
Aadd( aHelpP, "Tipo de ? " )
PutSx1("EXPSTE","05","Tipo de ?     "  ,"Tipo de ?     ","Tipo de ?           ","mv_ch5","C",2,0,0,"G","","02","","","mv_par05","","","","","","","","","","","","","","","","",aHelpP)

aHelpP	:= {}
Aadd( aHelpP, "Tipo ate ? " )
PutSx1("EXPSTE","06","Tipo ate ?    "  ,"Tipo ate ?    ","Tipo ate ?          ","mv_ch6","C",2,0,0,"G","","02","","","mv_par06","","","","","","","","","","","","","","","","",aHelpP)

aHelpP	:= {}
Aadd( aHelpP, "Imprime produtos inativos ? " )
PutSx1("EXPSTE","07","Imprime inativos ?    "  ,"Imprime inativos ?    ","Imprime inativos ?		","mv_ch7","N",1,0,2,"C","","","","","mv_par07","Sim","","","","Não","","","","","","","","","","","",aHelpP)

aHelpP	:= {}
Aadd( aHelpP, "Imprimir produtos bloqueados para venda ? " )
PutSx1("EXPSTE","08","Imprime Blq Vendas ?    "  ,"Imprime Blq Vendas ?    ","Imprime Blq Vendas ?	","mv_ch8","N",1,0,2,"C","","","","","mv_par08","Sim","","","","Não","","","","","","","","","","","",aHelpP)

aHelpP	:= {}

RestArea(aArea)

Return
