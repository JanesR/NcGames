#INCLUDE "rwmake.CH"
#Include "topconn.Ch"
#DEFINE CRLF Chr(13)+Chr(10)

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ TREPSZG³ Autor ³ Marco Bianchi        ³ Data ³ 15/06/12    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ RELATORIO DA CAMPANHA ANALITICO                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ SIGAFAT - R4 - ESPECIFICO NC GAMES                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function TREPSZG()

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
Local oCadPj
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
oReport := TReport():New("TREPSZG","Cadastro Funcionario PJ","TREPSZG", {|oReport| ReportPrint(oReport,oCadPj)},"")
//oReport:SetLandscape()
oReport:SetTotalInLine(.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//AjustaSx1()
//Pergunte(oReport:uParam,.F.)

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
oCadPj := TRSection():New(oReport,"Campanha",{"SZG"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)
oCadPj:SetTotalInLine(.F.)
//Dados cadastrais
//Dados cadastrais
TRCell():New(oCadPj,"CODIGO"	,"cArqTRB",RetTitle("ZG_CODIGO")		,PesqPict("SZG","ZG_CODIGO")	,TamSx3("ZG_CODIGO")	[1]	,/*lPixel*/,/*{|| cVend }*/						)		// "Codigo do Cliente"
TRCell():New(oCadPj,"RAZAO"		,"cArqTRB",RetTitle("ZG_RAZAO")			,PesqPict("SZG","ZG_RAZAO")		,TamSx3("ZG_RAZAO")		[1]	,/*lPixel*/,/*{|| cLjCli }*/					)		// "Codigo do Cliente"
TRCell():New(oCadPj,"CNPJ"	,"cArqTRB",RetTitle("ZG_CGC")		,PesqPict("SZG","ZG_CGC")		,TamSx3("ZG_CGC")		[1]	,/*lPixel*/,/*{|| cUf }*/						)		// "Nome do Cliente"
//Funcionais
TRCell():New(oCadPj,"CCUSTO"	,"cArqTRB","Centro de Custo"		,PesqPict("SZG","ZG_CC")	,TamSx3("ZG_CC")	[1]	,/*lPixel*/,/*{|| cNome }*/						)		// "Nome do Cliente"
TRCell():New(oCadPj,"DESCC"	,"cArqTRB","Desc Centro de Custo"		,PesqPict("SZG","ZG_DESCC")	,TamSx3("ZG_DESCC")	[1]	,/*lPixel*/,/*{|| cNome }*/						)		// "Nome do Cliente"
TRCell():New(oCadPj,"dAdmissa"	,/*Tabela*/,"Data de Admissao"	,""								,TamSX3("ZG_ADMISSA")[1],/*lPixel*/,{||dAdmissa		})	// Genero1 do Produto
TRCell():New(oCadPj,"dDemissa"	,/*Tabela*/,"Data de Demissao"	,""								,TamSX3("ZG_DEMISSA")[1],/*lPixel*/,{||dDemissa		})	// Genero1 do Produto
TRCell():New(oCadPj,"BANCO"	,"cArqTRB","Nome do Banco"		,PesqPict("SZG","ZG_BANCO")	,TamSx3("ZG_BANCO")	[1]	,/*lPixel*/,/*{|| cNome }*/						)		// "Nome do Cliente"
TRCell():New(oCadPj,"AGENCIA"	,"cArqTRB","Codigo da Agencia"	,PesqPict("SZG","ZG_AGENCIA")	,TamSx3("ZG_AGENCIA")	[1]	,/*lPixel*/,/*{|| cNome }*/						)		// "Nome do Cliente"
TRCell():New(oCadPj,"DIGITO"	,"cArqTRB","Digito da Agencia"	,PesqPict("SZG","ZG_AGEDV")	,TamSx3("ZG_AGEDV")	[1]	,/*lPixel*/,/*{|| cNome }*/						)		// "Nome do Cliente"
TRCell():New(oCadPj,"CONTA"	,"cArqTRB","Numero da Conta Corrente"	,PesqPict("SZG","ZG_CTABCO")	,TamSx3("ZG_CTABCO")	[1]	,/*lPixel*/,/*{|| cNome }*/						)		// "Nome do Cliente"
TRCell():New(oCadPj,"DIGITOCC"	,"cArqTRB","Digito Conta Corrente"		,PesqPict("SZG","ZG_CTADV")	,TamSx3("ZG_CTADV")	[1]	,/*lPixel*/,/*{|| cNome }*/						)		// "Nome do Cliente"
TRCell():New(oCadPj,"SITFOLHA"	,"cArqTRB","Situacao da Folha"			,PesqPict("SZG","ZG_SITFOLH")	,TamSx3("ZG_SITFOLH")	[1]	,/*lPixel*/,/*{|| cNome }*/						)		// "Nome do Cliente"
TRCell():New(oCadPj,"CODFUNC"	,"cArqTRB","Codigo da Funcao"		,PesqPict("SZG","ZG_CODFUNC")	,TamSx3("ZG_CODFUNC")	[1]	,/*lPixel*/,/*{|| cNome }*/						)		// "Nome do Cliente"
TRCell():New(oCadPj,"DESCFUN"	,"cArqTRB","Descricao da Funcao"		,PesqPict("SZG","ZG_DESCFUN")	,TamSx3("ZG_DESCFUN")	[1]	,/*lPixel*/,/*{|| cNome }*/						)		// "Nome do Cliente"
TRCell():New(oCadPj,"SALARIO"	,"cArqTRB","Salario"		,PesqPict("SZG","ZG_SALARIO")	,TamSx3("ZG_SALARIO")	[1]	,/*lPixel*/,/*{|| cNome }*/						)		// "Nome do Cliente"
TRCell():New(oCadPj,"SALAUT"	,"cArqTRB","Alteracao Salario"		,PesqPict("SZG","ZG_SALAUT")	,TamSx3("ZG_SALAUT")	[1]	,/*lPixel*/,/*{|| cNome }*/						)		// "Nome do Cliente"
TRCell():New(oCadPj,"CARGO"	,"cArqTRB","Codigo do Cargo"		,PesqPict("SZG","ZG_CARGO")	,TamSx3("ZG_CARGO")	[1]	,/*lPixel*/,/*{|| cNome }*/						)		// "Nome do Cliente"
TRCell():New(oCadPj,"DESCCAR"	,"cArqTRB","Descricao do Cargo"		,PesqPict("SZG","ZG_DESCCAR")	,TamSx3("ZG_DESCCAR")	[1]	,/*lPixel*/,/*{|| cNome }*/						)		// "Nome do Cliente"
TRCell():New(oCadPj,"dFCONTC"	,/*Tabela*/,"Data Fim do Contrato"	,""								,TamSX3("ZG_FIMCONT")	[1]	, 			,{||dDemissa		})		

// Alinhamento das colunas de valor a direita
//oCadPj:Cell("QFTDIA"):SetHeaderAlign("RIGHT")
//oCadPj:Cell("VFTDIA"):SetHeaderAlign("RIGHT")
//oCadPj:Cell("VLSIMPD"):SetHeaderAlign("RIGHT")
//oCadPj:Cell("QDVDIA"):SetHeaderAlign("RIGHT")
//oCadPj:Cell("VDVDIA"):SetHeaderAlign("RIGHT")
oCadPj:Cell("BANCO"):SetHeaderAlign("RIGHT")
oCadPj:Cell("AGENCIA"):SetHeaderAlign("RIGHT")
oCadPj:Cell("DIGITO"):SetHeaderAlign("RIGHT")
oCadPj:Cell("CONTA"):SetHeaderAlign("RIGHT")
oCadPj:Cell("DIGITOCC"):SetHeaderAlign("RIGHT")
oCadPj:Cell("SALARIO"):SetHeaderAlign("RIGHT")
oCadPj:Cell("SALAUT"):SetHeaderAlign("RIGHT")
//oCadPj:Cell("VALPED"):SetHeaderAlign("RIGHT")

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
Static Function ReportPrint(oReport,oCadPj)

/*
DDATAINI := GETADVFVAL("SZA","ZA_DTINI",xfilial("SZA")+MV_PAR01,1,"")
DDATAFIM := GETADVFVAL("SZA","ZA_DTFIM",xfilial("SZA")+MV_PAR01,1,"")
IF MV_PAR02 > DDATAFIM
	MV_PAR02 := DDATAFIM
ENDIF
*/

dAdmissa := ("  /  /  ")
dDemissa := ("  /  /  ")
dFCONTC   := ("  /  /  ")

cQry := ""
cQry += CRLF+" SELECT ZG_CODIGO CODIGO, ZG_NOME NOME, ZG_RAZAO RAZAO, ZG_CGC CNPJ, ZG_CC CCUSTO, ZG_DESCC DESCRCAO, ZG_ADMISSA ADMISSAO,
cQry += CRLF+" ZG_DEMISSA DEMISSAO, ZG_BANCO BANCO, ZG_AGENCIA AGENCIA, ZG_AGEDV DIGITO, ZG_CTABCO CONTA, ZG_CTADV DIGITOC, 
cQry += CRLF+" ZG_SITFOLH SITFOLHA, ZG_CODFUNC CODIGO, ZG_DESCFUN DESCRICAO, ZG_SALARIO SALARIO, 
cQry += CRLF+" ZG_SALAUT ALTERACAO, ZG_CARGO CARGO, ZG_DESCCAR DESCCAR, ZG_FIMCONT FCONTC
cQry += CRLF+" FROM "+RetSqlName("SZG")+" SZG
cQry += CRLF+" WHERE D_E_L_E_T_ <> '*'
cQry += CRLF+" ORDER BY ZG_CODIGO
cQry := ChangeQuery(cQry)
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),"cArqTRB",.T.,.T.)


DbSelectArea("cArqTRB")
oReport:section(1):Init()
oReport:SetMeter(LastRec())

//oReport:Section(1):Cell("dAdmissa"  ):SetBlock({|| dAdmissa })
//oReport:Section(1):Cell("dDemissa"  ):SetBlock({|| dDemissa })
//oReport:Section(1):Cell("dFCONTC"  ):SetBlock({|| dFCONTC })

While cArqTRB->(!EOF())
	
	dAdmissa := STOD(("cArqTRB")->ADMISSAO)
	dDemissa := STOD(("cArqTRB")->DEMISSAO)
	dFCONTC :=  STOD(("cArqTRB")->FCONTC)

	oReport:IncMeter()
	
	oReport:Section(1):Cell("dAdmissa"  ):SetBlock({|| dAdmissa })
	oReport:Section(1):Cell("dDemissa"  ):SetBlock({|| dDemissa })
	oReport:Section(1):Cell("dFCONTC"  ):SetBlock({|| dFCONTC })
	
	oReport:section(1):PrintLine()
	
	dbSkip()
EndDo

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
/*
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
*/