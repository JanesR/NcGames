#INCLUDE "rwmake.CH"
#Include "topconn.Ch"
#DEFINE CRLF Chr(13)+Chr(10)

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ TREPSZD³ Autor ³ Marco Bianchi        ³ Data ³ 15/06/12    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ RELATORIO DA CAMPANHA ANALITICO                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ SIGAFAT - R4 - ESPECIFICO NC GAMES                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function TREPSZD()

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
Private cArqTRB	:= CriaTrab(,.F.)		//Nome do arq. temporario

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
oReport := TReport():New("TREPSZD","Campanha Analitico","TREPSZD", {|oReport| ReportPrint(oReport,oFatVend)},"")
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
oFatVend := TRSection():New(oReport,"Campanha",{"SZB"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)
oFatVend:SetTotalInLine(.F.)
//Dados cadastrais
TRCell():New(oFatVend,"CODPRO"	,"cArqTRB",RetTitle("ZD_CODPRO")		,PesqPict("SZD","ZD_CODPRO")	,TamSx3("ZD_CODPRO")	[1]	,/*lPixel*/,/*{|| cVend }*/						)		// "Codigo do Cliente"
TRCell():New(oFatVend,"UPC"		,"cArqTRB",RetTitle("ZD_UPC")			,PesqPict("SZD","ZD_UPC")		,TamSx3("ZD_UPC")		[1]	,/*lPixel*/,/*{|| cLjCli }*/					)		// "Codigo do Cliente"
TRCell():New(oFatVend,"XDESC"	,"cArqTRB",RetTitle("ZD_XDESC")		,PesqPict("SZD","ZD_XDESC")		,TamSx3("ZD_XDESC")		[1]	,/*lPixel*/,/*{|| cUf }*/						)		// "Nome do Cliente"
TRCell():New(oFatVend,"PLATEXT"	,"cArqTRB",RetTitle("ZD_PLATEXT")		,PesqPict("SZD","ZD_PLATEXT")	,TamSx3("ZD_PLATEXT")	[1]	,/*lPixel*/,/*{|| cNome }*/						)		// "Nome do Cliente"
TRCell():New(oFatVend,"PUBLISH"	,"cArqTRB",RetTitle("ZD_PUBLISH")		,PesqPict("SZD","ZD_PUBLISH")	,TamSx3("ZD_PUBLISH")	[1]	,/*lPixel*/,/*{|| cNome }*/						)		// "Nome do Cliente"
TRCell():New(oFatVend,"DESCCAT"	,"cArqTRB",RetTitle("ZD_DESCCAT")		,PesqPict("SZD","ZD_DESCCAT")	,TamSx3("ZD_DESCCAT")	[1]	,/*lPixel*/,/*{|| cNome }*/						)		// "Nome do Cliente"
TRCell():New(oFatVend,"DESCCLA"	,"cArqTRB",RetTitle("ZD_DESCCLA")		,PesqPict("SZD","ZD_DESCCLA")	,TamSx3("ZD_DESCCLA")	[1]	,/*lPixel*/,/*{|| cNome }*/						)		// "Nome do Cliente"
TRCell():New(oFatVend,"NOMVEND"	,"cArqTRB",RetTitle("ZD_NOMVEND")		,PesqPict("SZD","ZD_NOMVEND")	,TamSx3("ZD_NOMVEND")	[1]	,/*lPixel*/,/*{|| cNome }*/						)		// "Nome do Cliente"
TRCell():New(oFatVend,"DCANAL"	,"cArqTRB",RetTitle("ZD_DCANAL")		,PesqPict("SZD","ZD_DCANAL")	,TamSx3("ZD_DCANAL")	[1]	,/*lPixel*/,/*{|| cNome }*/						)		// "Nome do Cliente"
TRCell():New(oFatVend,"CODCLI"	,"cArqTRB",RetTitle("ZD_CODCLI")		,PesqPict("SZD","ZD_CODCLI")	,TamSx3("ZD_CODCLI")	[1]	,/*lPixel*/,/*{|| cNome }*/						)		// "Nome do Cliente"
TRCell():New(oFatVend,"LOJACLI"	,"cArqTRB",RetTitle("ZD_LOJACLI")		,PesqPict("SZD","ZD_LOJACLI")	,TamSx3("ZD_LOJACLI")	[1]	,/*lPixel*/,/*{|| cNome }*/						)		// "Nome do Cliente"
TRCell():New(oFatVend,"NOMCLI"	,"cArqTRB",RetTitle("ZD_NOMCLI")		,PesqPict("SZD","ZD_NOMCLI")	,TamSx3("ZD_NOMCLI")	[1]	,/*lPixel*/,/*{|| cNome }*/						)		// "Nome do Cliente"
//Valores Faturamento
TRCell():New(oFatVend,"QFTDIA"	,"cArqTRB","Quant Faturada"		,PesqPict("SZD","ZD_QFTDIA")	,TamSx3("ZD_QFTDIA")	[1]	,/*lPixel*/,/*{|| cNome }*/						)		// "Nome do Cliente"
TRCell():New(oFatVend,"VFTDIA"	,"cArqTRB","Valor Faturado"		,PesqPict("SZD","ZD_VFTDIA")	,TamSx3("ZD_VFTDIA")	[1]	,/*lPixel*/,/*{|| cNome }*/						)		// "Nome do Cliente"
TRCell():New(oFatVend,"VLSIMPD"	,"cArqTRB","Valor Fat sem Impostos"	,PesqPict("SZD","ZD_VLSIMPD")	,TamSx3("ZD_VLSIMPD")	[1]	,/*lPixel*/,/*{|| cNome }*/						)		// "Nome do Cliente"
TRCell():New(oFatVend,"QDVDIA"	,"cArqTRB","Quant Devolvida"		,PesqPict("SZD","ZD_VLSIMPD")	,TamSx3("ZD_VLSIMPD")	[1]	,/*lPixel*/,/*{|| cNome }*/						)		// "Nome do Cliente"
TRCell():New(oFatVend,"VDVDIA"	,"cArqTRB","Valor Devolvido"		,PesqPict("SZD","ZD_VLSIMPD")	,TamSx3("ZD_VLSIMPD")	[1]	,/*lPixel*/,/*{|| cNome }*/						)		// "Nome do Cliente"
TRCell():New(oFatVend,"DVSIMP"	,"cArqTRB","Valor Dev sem Impostos"	,PesqPict("SZD","ZD_VLSIMPD")	,TamSx3("ZD_VLSIMPD")	[1]	,/*lPixel*/,/*{|| cNome }*/						)		// "Nome do Cliente"
TRCell():New(oFatVend,"CUSTDIA"	,"cArqTRB","Custo Total Faturados"	,PesqPict("SZD","ZD_VLSIMPD")	,TamSx3("ZD_VLSIMPD")	[1]	,/*lPixel*/,/*{|| cNome }*/						)		// "Nome do Cliente"
TRCell():New(oFatVend,"CMDEVDI"	,"cArqTRB","Custo Total Devolvidos"	,PesqPict("SZD","ZD_VLSIMPD")	,TamSx3("ZD_VLSIMPD")	[1]	,/*lPixel*/,/*{|| cNome }*/						)		// "Nome do Cliente"
TRCell():New(oFatVend,"LBRDIA"	,"cArqTRB","Lucro Bruto"		,PesqPict("SZD","ZD_VLSIMPD")	,TamSx3("ZD_VLSIMPD")	[1]	,/*lPixel*/,/*{|| cNome }*/						)		// "Nome do Cliente"
TRCell():New(oFatVend,"MARKUP"	,"cArqTRB","Mark Up"			,PesqPict("SZD","ZD_VLSIMPD")	,TamSx3("ZD_VLSIMPD")	[1]	,/*lPixel*/,/*{|| cNome }*/						)		// "Nome do Cliente"
TRCell():New(oFatVend,"LLDIA"	,"cArqTRB","Lucro Líquido"		,PesqPict("SZD","ZD_VLSIMPD")	,TamSx3("ZD_VLSIMPD")	[1]	,/*lPixel*/,/*{|| cNome }*/						)		// "Nome do Cliente"
//TRCell():New(oFatVend,"QTDPED"	,"cArqTRB","Quant em Pedido"	,PesqPict("SZD","ZD_VLSIMPD")	,TamSx3("ZD_VLSIMPD")	[1]	,/*lPixel*/,/*{|| cNome }*/						)		// "Nome do Cliente"
//TRCell():New(oFatVend,"VALPED"	,"cArqTRB","Valor em Pedido"	,PesqPict("SZD","ZD_VLSIMPD")	,TamSx3("ZD_VLSIMPD")	[1]	,/*lPixel*/,/*{|| cNome }*/						)		// "Nome do Cliente"

// Alinhamento das colunas de valor a direita
oFatVend:Cell("QFTDIA"):SetHeaderAlign("RIGHT")
oFatVend:Cell("VFTDIA"):SetHeaderAlign("RIGHT")
oFatVend:Cell("VLSIMPD"):SetHeaderAlign("RIGHT")
oFatVend:Cell("QDVDIA"):SetHeaderAlign("RIGHT")
oFatVend:Cell("VDVDIA"):SetHeaderAlign("RIGHT")
oFatVend:Cell("DVSIMP"):SetHeaderAlign("RIGHT")
oFatVend:Cell("CUSTDIA"):SetHeaderAlign("RIGHT")
oFatVend:Cell("CMDEVDI"):SetHeaderAlign("RIGHT")
oFatVend:Cell("LBRDIA"):SetHeaderAlign("RIGHT")
oFatVend:Cell("MARKUP"):SetHeaderAlign("RIGHT")
oFatVend:Cell("LLDIA"):SetHeaderAlign("RIGHT")
//oFatVend:Cell("QTDPED"):SetHeaderAlign("RIGHT")
//oFatVend:Cell("VALPED"):SetHeaderAlign("RIGHT")

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


DDATAINI := GETADVFVAL("SZA","ZA_DTINI",xfilial("SZA")+MV_PAR01,1,"")
DDATAFIM := GETADVFVAL("SZA","ZA_DTFIM",xfilial("SZA")+MV_PAR01,1,"")
IF MV_PAR02 > DDATAFIM
	MV_PAR02 := DDATAFIM
ENDIF


cQry := ""
cQry += CRLF+" SELECT D2_CLIENTE CODCLI, VEND_FAT,
cQry += CRLF+" D2_LOJA LOJACLI, A1_NOME NOMCLI, B1_CODBAR UPC, B1_XDESC XDESC, 
cQry += CRLF+" B1_PLATEXT PLATEXT, B1_PUBLISH PUBLISH, B1_DESCCAT DESCCAT, 
cQry += CRLF+" B1_DESCCLA DESCCLA, A3_NOME NOMVEND, ACA_DESCRI DCANAL,
cQry += CRLF+" FAT.PRODUTO CODPRO, 
cQry += CRLF+" QFATDIA QFTDIA, 
cQry += CRLF+" VALBRUTO VFTDIA, 
cQry += CRLF+" VLSIMPT VLSIMPD, 
cQry += CRLF+" CASE WHEN QDEVDIA IS NULL THEN 0 ELSE QDEVDIA END QDVDIA, 
cQry += CRLF+" CASE WHEN DEVVALBRUTO IS NULL THEN 0 ELSE DEVVALBRUTO END VDVDIA, 
cQry += CRLF+" CASE WHEN DEVVLSIMPT IS NULL THEN 0 ELSE DEVVLSIMPT END DVSIMP, 
cQry += CRLF+" CASE WHEN QFATDIA = 0 THEN 0 ELSE ROUND(VALBRUTO/QFATDIA,2) END PRMEDIO,
cQry += CRLF+" CASE WHEN QFATDIA = 0 THEN 0 ELSE ROUND(CMVFTTOT/QFATDIA,2) END CMVUNIT,
cQry += CRLF+" CMVFTTOT CUSTDIA, 
cQry += CRLF+" CASE WHEN CMVDVTOT IS NULL THEN 0 ELSE CMVDVTOT END CMDEVDI, 
cQry += CRLF+" CASE WHEN DEVVLSIMPT-CMVDVTOT IS NULL 
cQry += CRLF+" 		THEN VLSIMPT - CMVFTTOT ELSE (VLSIMPT - DEVVLSIMPT)-(CMVFTTOT-CMVDVTOT) END LBRDIA, 
cQry += CRLF+" CASE WHEN CMVFTTOT <> 0 OR DEVVLSIMPT IS NULL
cQry += CRLF+" 		THEN ROUND((VLSIMPT)/(CMVFTTOT),2) 
cQry += CRLF+" 	WHEN CMVFTTOT-CMVDVTOT = 0
cQry += CRLF+" 		THEN 0
cQry += CRLF+" 	ELSE ROUND((VLSIMPT - DEVVLSIMPT)/(CMVFTTOT-CMVDVTOT),2) END MARKUP,
cQry += CRLF+" CASE WHEN DEVVLSIMPT IS NULL
cQry += CRLF+" 		THEN ROUND((VLSIMPT-CMVFTTOT)-(VLSIMPT*(9/100)),2)
cQry += CRLF+" 	ELSE ROUND(((VLSIMPT - DEVVLSIMPT)-(CMVFTTOT-CMVDVTOT))-((VLSIMPT - DEVVLSIMPT)*(9/100)),2) END LLDIA
cQry += CRLF+" FROM
cQry += CRLF+" (SELECT PRODUTO||D2_CLIENTE||D2_LOJA||F2_VEND1 CHVFAT, F2_VEND1 VEND_FAT,
cQry += CRLF+" PRODUTO, D2_CLIENTE, D2_LOJA,
cQry += CRLF+" CASE WHEN VALMERC IS NULL THEN 0 ELSE VALMERC END VALMERC,
cQry += CRLF+" CASE WHEN VALBRUTO IS NULL THEN 0 ELSE VALBRUTO END VALBRUTO,
cQry += CRLF+" CASE WHEN QFATDIA IS NULL THEN 0 ELSE QFATDIA END QFATDIA,  
cQry += CRLF+" CASE WHEN CMVFTTOT IS NULL THEN 0 ELSE CMVFTTOT END CMVFTTOT, 
cQry += CRLF+" CASE WHEN VLSIMPT IS NULL THEN 0 ELSE VLSIMPT END VLSIMPT, 
cQry += CRLF+" CASE WHEN LBRUT IS NULL THEN 0 ELSE LBRUT END LBRUT, 
cQry += CRLF+" CASE WHEN LLIQ IS NULL THEN 0 ELSE LLIQ END LLIQ 
cQry += CRLF+" FROM 
cQry += CRLF+" (SELECT D2_COD PRODUTO, D2_CLIENTE, D2_LOJA, F2_VEND1, SUM(D2_TOTAL) VALMERC, 
cQry += CRLF+" SUM(D2_VALBRUT) VALBRUTO, SUM(D2_QUANT) QFATDIA, SUM(D2_CUSTO1) CMVFTTOT,
cQry += CRLF+" SUM(D2_TOTAL) - SUM(D2_VALICM) - SUM(D2_VALIMP6) - SUM(D2_VALIMP5) VLSIMPT,
cQry += CRLF+" (SUM(D2_TOTAL) - SUM(D2_VALICM) - SUM(D2_VALIMP6) - SUM(D2_VALIMP5))-(SUM(D2_CUSTO1)) LBRUT,
cQry += CRLF+" ROUND((SUM(D2_TOTAL) - SUM(D2_VALICM) - SUM(D2_VALIMP6) - SUM(D2_VALIMP5))-(SUM(D2_CUSTO1)) - ((SUM(D2_TOTAL) - SUM(D2_VALICM) - SUM(D2_VALIMP6) - SUM(D2_VALIMP5))*(9/100)),2) LLIQ
cQry += CRLF+" FROM "+RetSqlName("SD2")+" SD2, "+RetSqlName("SF4")+" SF4, "+RetSqlName("SF2")+" SF2
cQry += CRLF+" WHERE D2_FILIAL = '"+XFILIAL("SD2")+"'
cQry += CRLF+" AND D2_EMISSAO BETWEEN '"+DTOS(DDATAINI)+"' AND '"+DTOS(MV_PAR02)+"'
cQry += CRLF+" AND D2_TIPO NOT IN ('D', 'B')
cQry += CRLF+" AND F2_FILIAL  = '"+XFILIAL("SF2")+"'
cQry += CRLF+" AND D2_DOC     = F2_DOC
cQry += CRLF+" AND D2_SERIE   = F2_SERIE
cQry += CRLF+" AND D2_CLIENTE = F2_CLIENTE
cQry += CRLF+" AND D2_LOJA    = F2_LOJA
cQry += CRLF+" AND F4_FILIAL  = '"+XFILIAL("SF4")+"'
cQry += CRLF+" AND F4_CODIGO  = D2_TES
cQry += CRLF+" AND SF4.F4_ESTOQUE = 'S'
cQry += CRLF+" AND SF4.F4_DUPLIC = 'S'
cQry += CRLF+" AND SD2.D_E_L_E_T_ = ' '
cQry += CRLF+" AND SF2.D_E_L_E_T_ = ' '
cQry += CRLF+" AND SF4.D_E_L_E_T_ = ' '
cQry += CRLF+" AND SD2.D2_COD IN(SELECT ZB_CODPRO FROM "+RetSqlName("SZB")+" WHERE D_E_L_E_T_ = ' ' AND ZB_COD = '"+MV_PAR01+"' AND ZB_FILIAL = '"+XFILIAL("SZB")+"')
cQry += CRLF+" GROUP BY D2_COD, D2_CLIENTE, D2_LOJA, F2_VEND1) VWAPUR) FAT,
cQry += CRLF+" (SELECT PRODUTO||D1_FORNECE||D1_LOJA||F2_VEND1 CHVDEV, F2_VEND1 VEND_DEV, PRODUTO, D1_FORNECE, D1_LOJA,
cQry += CRLF+" CASE WHEN VALMERC IS NULL THEN 0 ELSE VALMERC END DEVVALMERC,
cQry += CRLF+" CASE WHEN VALBRUTO IS NULL THEN 0 ELSE VALBRUTO END DEVVALBRUTO,
cQry += CRLF+" CASE WHEN QFATDIA IS NULL THEN 0 ELSE QFATDIA END QDEVDIA,  
cQry += CRLF+" CASE WHEN CMVFTTOT IS NULL THEN 0 ELSE CMVFTTOT END CMVDVTOT, 
cQry += CRLF+" CASE WHEN VLSIMPT IS NULL THEN 0 ELSE VLSIMPT END DEVVLSIMPT, 
cQry += CRLF+" CASE WHEN LBRUT IS NULL THEN 0 ELSE LBRUT END DEVLBRUT, 
cQry += CRLF+" CASE WHEN LLIQ IS NULL THEN 0 ELSE LLIQ END DEVLLIQ 
cQry += CRLF+" FROM 
cQry += CRLF+" (SELECT D1_COD PRODUTO, D1_FORNECE, D1_LOJA, F2_VEND1, SUM(D1_TOTAL) VALMERC, 
cQry += CRLF+" SUM(D1_TOTAL+D1_VALIPI+D1_ICMSRET) VALBRUTO, SUM(D1_QUANT) QFATDIA, SUM(D1_CUSTO) CMVFTTOT,
cQry += CRLF+" SUM(D1_TOTAL) - SUM(D1_VALICM) - SUM(D1_VALIMP6) - SUM(D1_VALIMP5) VLSIMPT,
cQry += CRLF+" (SUM(D1_TOTAL) - SUM(D1_VALICM) - SUM(D1_VALIMP6) - SUM(D1_VALIMP5))-(SUM(D1_CUSTO)) LBRUT,
cQry += CRLF+" ROUND((SUM(D1_TOTAL) - SUM(D1_VALICM) - SUM(D1_VALIMP6) - SUM(D1_VALIMP5))-(SUM(D1_CUSTO)) - ((SUM(D1_TOTAL) - SUM(D1_VALICM) - SUM(D1_VALIMP6) - SUM(D1_VALIMP5))*(9/100)),2) LLIQ
cQry += CRLF+" FROM "+RetSqlName("SD1")+" SD1, "+RetSqlName("SF4")+" SF4, "+RetSqlName("SF1")+" SF1, "+RetSqlName("SF2")+" SF2
cQry += CRLF+" WHERE D1_FILIAL = '"+XFILIAL("SD1")+"'
cQry += CRLF+" AND D1_DTDIGIT BETWEEN '"+DTOS(DDATAINI)+"' AND '"+DTOS(MV_PAR02)+"'
cQry += CRLF+" AND D1_TIPO = 'D'
cQry += CRLF+" AND F1_FILIAL  = '"+XFILIAL("SF1")+"'
cQry += CRLF+" AND SF2.F2_FILIAL = '"+XFILIAL("SF2")+"'
cQry += CRLF+" AND SF2.F2_DOC = SD1.D1_NFORI
cQry += CRLF+" AND SF2.F2_SERIE = SD1.D1_SERIORI
cQry += CRLF+" AND D1_DOC     = F1_DOC
cQry += CRLF+" AND D1_SERIE   = F1_SERIE
cQry += CRLF+" AND D1_FORNECE = F1_FORNECE
cQry += CRLF+" AND D1_LOJA    = F1_LOJA
cQry += CRLF+" AND F4_FILIAL  = '"+XFILIAL("SF4")+"'
cQry += CRLF+" AND F4_CODIGO  = D1_TES
cQry += CRLF+" AND SF4.F4_ESTOQUE = 'S'
cQry += CRLF+" AND SF4.F4_DUPLIC = 'S'
cQry += CRLF+" AND SD1.D_E_L_E_T_ = ' '
cQry += CRLF+" AND SF1.D_E_L_E_T_ = ' '
cQry += CRLF+" AND SF4.D_E_L_E_T_ = ' '
cQry += CRLF+" AND SF2.D_E_L_E_T_ = ' '
cQry += CRLF+" AND SD1.D1_COD IN(SELECT ZB_CODPRO FROM "+RetSqlName("SZB")+" WHERE D_E_L_E_T_ = ' ' AND ZB_COD = '"+MV_PAR01+"' AND ZB_FILIAL = '"+XFILIAL("SZB")+"')
cQry += CRLF+" GROUP BY D1_COD, D1_FORNECE, D1_LOJA, F2_VEND1) VWAPUR) DEV,
cQry += CRLF+" "+RetSqlName("SB1")+" SB1, "+RetSqlName("SA1")+" SA1, "+RetSqlName("SA3")+" SA3, "+RetSqlName("ACA")+" ACA
cQry += CRLF+" WHERE FAT.CHVFAT = DEV.CHVDEV(+)
cQry += CRLF+" AND SB1.D_E_L_E_T_ = ' '
cQry += CRLF+" AND SA1.D_E_L_E_T_ = ' '
cQry += CRLF+" AND SA3.D_E_L_E_T_ = ' '
cQry += CRLF+" AND B1_FILIAL = '"+XFILIAL("SB1")+"'
cQry += CRLF+" AND A1_FILIAL = '"+XFILIAL("SA1")+"'
cQry += CRLF+" AND A3_FILIAL = '"+XFILIAL("SA3")+"'
cQry += CRLF+" AND ACA_FILIAL = '"+XFILIAL("ACA")+"'
cQry += CRLF+" AND FAT.PRODUTO = SB1.B1_COD
cQry += CRLF+" AND D2_CLIENTE = SA1.A1_COD
cQry += CRLF+" AND D2_LOJA = SA1.A1_LOJA
cQry += CRLF+" AND VEND_FAT = A3_COD
cQry += CRLF+" AND A3_GRPREP = ACA_GRPREP
cQry := ChangeQuery(cQry)
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),"cArqTRB",.T.,.T.)


DbSelectArea("cArqTRB")
oReport:section(1):Init()
oReport:SetMeter(LastRec())
While cArqTRB->(!EOF())
	
	oReport:IncMeter()
	
	oReport:section(1):PrintLine()
	
	dbSkip()
EndDo
DbSelectArea("cArqTRB")
dbclosearea()

cQry := ""
cQry += CRLF+" SELECT D1_FORNECE CODCLI, VEND_DEV,
cQry += CRLF+" D1_LOJA LOJACLI, A1_NOME NOMCLI, B1_CODBAR UPC, B1_XDESC XDESC,
cQry += CRLF+" B1_PLATEXT PLATEXT, B1_PUBLISH PUBLISH, B1_DESCCAT DESCCAT, 
cQry += CRLF+" B1_DESCCLA DESCCLA, A3_NOME NOMVEND, ACA_DESCRI DCANAL,
cQry += CRLF+" PRODUTO CODPRO,
cQry += CRLF+" 0 QFTDIA, 
cQry += CRLF+" 0 VFTDIA, 
cQry += CRLF+" 0 VLSIMPD, 
cQry += CRLF+" CASE WHEN QDEVDIA IS NULL THEN 0 ELSE QDEVDIA END QDVDIA, 
cQry += CRLF+" CASE WHEN DEVVALBRUTO IS NULL THEN 0 ELSE DEVVALBRUTO END VDVDIA, 
cQry += CRLF+" CASE WHEN DEVVLSIMPT IS NULL THEN 0 ELSE DEVVLSIMPT END DVSIMP, 
cQry += CRLF+" 0 PRMEDIO,
cQry += CRLF+" 0 CMVUNIT,
cQry += CRLF+" 0 CUSTDIA,
cQry += CRLF+" CASE WHEN CMVDVTOT IS NULL THEN 0 ELSE CMVDVTOT END CMDEVDI, 
cQry += CRLF+" CASE WHEN DEVVLSIMPT-CMVDVTOT IS NULL 
cQry += CRLF+" 		THEN 0 ELSE -(DEVVLSIMPT-CMVDVTOT) END LBRDIA,
cQry += CRLF+" ROUND(DEVVLSIMPT/CMVDVTOT,2) MARKUP,
cQry += CRLF+" -ROUND(((DEVVLSIMPT)-(CMVDVTOT))-((DEVVLSIMPT)*(9/100)),2) LLDIA
cQry += CRLF+" FROM
cQry += CRLF+" (SELECT PRODUTO||D1_FORNECE||D1_LOJA||F2_VEND1 CHVDEV, F2_VEND1 VEND_DEV, PRODUTO, D1_FORNECE, D1_LOJA,
cQry += CRLF+" CASE WHEN VALMERC IS NULL THEN 0 ELSE VALMERC END DEVVALMERC,
cQry += CRLF+" CASE WHEN VALBRUTO IS NULL THEN 0 ELSE VALBRUTO END DEVVALBRUTO,
cQry += CRLF+" CASE WHEN QFATDIA IS NULL THEN 0 ELSE QFATDIA END QDEVDIA,  
cQry += CRLF+" CASE WHEN CMVFTTOT IS NULL THEN 0 ELSE CMVFTTOT END CMVDVTOT, 
cQry += CRLF+" CASE WHEN VLSIMPT IS NULL THEN 0 ELSE VLSIMPT END DEVVLSIMPT, 
cQry += CRLF+" CASE WHEN LBRUT IS NULL THEN 0 ELSE LBRUT END DEVLBRUT, 
cQry += CRLF+" CASE WHEN LLIQ IS NULL THEN 0 ELSE LLIQ END DEVLLIQ 
cQry += CRLF+" FROM 
cQry += CRLF+" (SELECT D1_COD PRODUTO, D1_FORNECE, D1_LOJA, F2_VEND1, SUM(D1_TOTAL) VALMERC, 
cQry += CRLF+" SUM(D1_TOTAL+D1_VALIPI+D1_ICMSRET) VALBRUTO, SUM(D1_QUANT) QFATDIA, SUM(D1_CUSTO) CMVFTTOT,
cQry += CRLF+" SUM(D1_TOTAL) - SUM(D1_VALICM) - SUM(D1_VALIMP6) - SUM(D1_VALIMP5) VLSIMPT,
cQry += CRLF+" (SUM(D1_TOTAL) - SUM(D1_VALICM) - SUM(D1_VALIMP6) - SUM(D1_VALIMP5))-(SUM(D1_CUSTO)) LBRUT,
cQry += CRLF+" ROUND((SUM(D1_TOTAL) - SUM(D1_VALICM) - SUM(D1_VALIMP6) - SUM(D1_VALIMP5))-(SUM(D1_CUSTO)) - ((SUM(D1_TOTAL) - SUM(D1_VALICM) - SUM(D1_VALIMP6) - SUM(D1_VALIMP5))*(9/100)),2) LLIQ
cQry += CRLF+" FROM "+RetSqlName("SD1")+" SD1, "+RetSqlName("SF4")+" SF4, "+RetSqlName("SF1")+" SF1, "+RetSqlName("SF2")+" SF2
cQry += CRLF+" WHERE D1_FILIAL = '"+XFILIAL("SD1")+"'
cQry += CRLF+" AND SF2.F2_FILIAL = '"+XFILIAL("SF2")+"'
cQry += CRLF+" AND SF2.F2_DOC = SD1.D1_NFORI
cQry += CRLF+" AND SF2.F2_SERIE = SD1.D1_SERIORI
cQry += CRLF+" AND D1_DTDIGIT BETWEEN '"+DTOS(DDATAINI)+"' AND '"+DTOS(MV_PAR02)+"'
cQry += CRLF+" AND D1_TIPO = 'D'
cQry += CRLF+" AND F1_FILIAL  = '"+XFILIAL("SF1")+"'
cQry += CRLF+" AND D1_DOC     = F1_DOC
cQry += CRLF+" AND D1_SERIE   = F1_SERIE
cQry += CRLF+" AND D1_FORNECE = F1_FORNECE
cQry += CRLF+" AND D1_LOJA    = F1_LOJA
cQry += CRLF+" AND F4_FILIAL  = '"+XFILIAL("SF4")+"'
cQry += CRLF+" AND F4_CODIGO  = D1_TES
cQry += CRLF+" AND SF4.F4_ESTOQUE = 'S'
cQry += CRLF+" AND SF4.F4_DUPLIC = 'S'
cQry += CRLF+" AND SD1.D_E_L_E_T_ = ' '
cQry += CRLF+" AND SF1.D_E_L_E_T_ = ' '
cQry += CRLF+" AND SF2.D_E_L_E_T_ = ' '
cQry += CRLF+" AND SF4.D_E_L_E_T_ = ' '
cQry += CRLF+" AND SD1.D1_COD IN(SELECT ZB_CODPRO FROM "+RetSqlName("SZB")+" WHERE D_E_L_E_T_ = ' ' AND ZB_COD = '"+MV_PAR01+"' AND ZB_FILIAL = '"+XFILIAL("SZB")+"')
cQry += CRLF+" AND D1_COD||D1_FORNECE||D1_LOJA||F2_VEND1 NOT IN(SELECT D2_COD||D2_CLIENTE||D2_LOJA||F2_VEND1 CHVFAT
cQry += CRLF+" FROM "+RetSqlName("SD2")+" SD2, "+RetSqlName("SF4")+" SF4, "+RetSqlName("SF2")+" SF2
cQry += CRLF+" WHERE D2_FILIAL = '"+XFILIAL("SD2")+"'
cQry += CRLF+" AND D2_EMISSAO BETWEEN '"+DTOS(DDATAINI)+"' AND '"+DTOS(MV_PAR02)+"'
cQry += CRLF+" AND D2_TIPO NOT IN ('D', 'B')
cQry += CRLF+" AND F2_FILIAL  = '"+XFILIAL("SF2")+"'
cQry += CRLF+" AND D2_DOC     = F2_DOC
cQry += CRLF+" AND D2_SERIE   = F2_SERIE
cQry += CRLF+" AND D2_CLIENTE = F2_CLIENTE
cQry += CRLF+" AND D2_LOJA    = F2_LOJA
cQry += CRLF+" AND F4_FILIAL  = '"+XFILIAL("SF4")+"'
cQry += CRLF+" AND F4_CODIGO  = D2_TES
cQry += CRLF+" AND SF4.F4_ESTOQUE = 'S'
cQry += CRLF+" AND SF4.F4_DUPLIC = 'S'
cQry += CRLF+" AND SD2.D_E_L_E_T_ = ' '
cQry += CRLF+" AND SF2.D_E_L_E_T_ = ' '
cQry += CRLF+" AND SF4.D_E_L_E_T_ = ' '
cQry += CRLF+" AND SD2.D2_COD IN(SELECT ZB_CODPRO FROM "+RetSqlName("SZB")+" WHERE D_E_L_E_T_ = ' ' AND ZB_COD = '"+MV_PAR01+"' AND ZB_FILIAL = '"+XFILIAL("SZB")+"')
cQry += CRLF+" GROUP BY D2_COD, D2_CLIENTE, D2_LOJA, F2_VEND1)
cQry += CRLF+" GROUP BY D1_COD, D1_FORNECE, D1_LOJA, F2_VEND1) VWAPUR) DEV,
cQry += CRLF+" "+RetSqlName("SB1")+" SB1, "+RetSqlName("SA1")+" SA1, "+RetSqlName("SA3")+" SA3, "+RetSqlName("ACA")+" ACA
cQry += CRLF+" WHERE SB1.D_E_L_E_T_ = ' '
cQry += CRLF+" AND SA1.D_E_L_E_T_ = ' '
cQry += CRLF+" AND SA3.D_E_L_E_T_ = ' '
cQry += CRLF+" AND B1_FILIAL = '"+XFILIAL("SB1")+"'
cQry += CRLF+" AND A1_FILIAL = '"+XFILIAL("SA1")+"'
cQry += CRLF+" AND A3_FILIAL = '"+XFILIAL("SA3")+"'
cQry += CRLF+" AND ACA_FILIAL = '"+XFILIAL("ACA")+"'
cQry += CRLF+" AND PRODUTO = SB1.B1_COD
cQry += CRLF+" AND D1_FORNECE = SA1.A1_COD
cQry += CRLF+" AND D1_LOJA = SA1.A1_LOJA
cQry += CRLF+" AND VEND_DEV = A3_COD
cQry += CRLF+" AND A3_GRPREP = ACA_GRPREP
cQry := ChangeQuery(cQry)
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),"cArqTRB",.T.,.T.)


DbSelectArea("cArqTRB")
oReport:SetMeter(LastRec())
While cArqTRB->(!EOF())
	
	oReport:IncMeter()
	
	oReport:section(1):PrintLine()
	
	dbSkip()
EndDo
DbSelectArea("cArqTRB")
dbclosearea()

oReport:Section(1):PageBreak()


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
PutSx1("TREPSZD","01","Campanha a apurar ?" ,"","","mv_ch1","C",6,0,,"G","","SZA","","","mv_par01","","","","","","","","","","","","","","","","",aHelpP11,aHelpE11,aHelpS11)
aHelpP11	:= {}

Aadd( aHelpP11, "Considera faturamento até a data ?" )
PutSx1("TREPSZD","02","Data referência ?" ,"","","mv_ch2","D",8,0,,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",aHelpP11,aHelpE11,aHelpS11)
aHelpP11	:= {}

RestArea(aArea)

Return
