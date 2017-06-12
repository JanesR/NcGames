#INCLUDE "rwmake.CH"
#Include "topconn.Ch"
#DEFINE CRLF Chr(13)+Chr(10)

/*���������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  � TREPSZG� Autor � Marco Bianchi        � Data � 15/06/12    ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � RELATORIO DA CAMPANHA ANALITICO                            ���
�������������������������������������������������������������������������Ĵ��
���Uso       � SIGAFAT - R4 - ESPECIFICO NC GAMES                         ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
���������������������������������������������������������������������������*/
User Function TREPSZG()

Local oReport

oReport := ReportDef()
oReport:PrintDialog()

Return

/*���������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  �ReportDef � Autor � Marco Bianchi         � Data � 26/06/06 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o �A funcao estatica ReportDef devera ser criada para todos os ���
���          �relatorios que poderao ser agendados pelo usuario.          ���
���          �                                                            ���
�������������������������������������������������������������������������Ĵ��
���Retorno   �ExpO1: Objeto do relat�rio                                  ���
�������������������������������������������������������������������������Ĵ��
���Parametros�Nenhum                                                      ���
���          �                                                            ���
�������������������������������������������������������������������������Ĵ��
���   DATA   � Programador   �Manutencao efetuada                         ���
�������������������������������������������������������������������������Ĵ��
���          �               �                                            ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Static Function ReportDef()

Local oReport
Local oCadPj
Private cArqTRB	:= CriaTrab(,.F.)		//Nome do arq. temporario

//������������������������������������������������������������������������Ŀ
//�Criacao do componente de impressao                                      �
//�                                                                        �
//�TReport():New                                                           �
//�ExpC1 : Nome do relatorio                                               �
//�ExpC2 : Titulo                                                          �
//�ExpC3 : Pergunte                                                        �
//�ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  �
//�ExpC5 : Descricao                                                       �
//�                                                                        �
//��������������������������������������������������������������������������
oReport := TReport():New("TREPSZG","Cadastro Funcionario PJ","TREPSZG", {|oReport| ReportPrint(oReport,oCadPj)},"")
//oReport:SetLandscape()
oReport:SetTotalInLine(.F.)

//��������������������������������������������������������������Ŀ
//� Verifica as perguntas selecionadas                           �
//����������������������������������������������������������������
//AjustaSx1()
//Pergunte(oReport:uParam,.F.)

//������������������������������������������������������������������������Ŀ
//�Criacao da secao utilizada pelo relatorio                               �
//�                                                                        �
//�TRSection():New                                                         �
//�ExpO1 : Objeto TReport que a secao pertence                             �
//�ExpC2 : Descricao da se�ao                                              �
//�ExpA3 : Array com as tabelas utilizadas pela secao. A primeira tabela   �
//�        sera considerada como principal para a se��o.                   �
//�ExpA4 : Array com as Ordens do relat�rio                                �
//�ExpL5 : Carrega campos do SX3 como celulas                              �
//�        Default : False                                                 �
//�ExpL6 : Carrega ordens do Sindex                                        �
//�        Default : False                                                 �
//�                                                                        �
//��������������������������������������������������������������������������
//������������������������������������������������������������������������Ŀ
//�Criacao da celulas da secao do relatorio                                �
//�                                                                        �
//�TRCell():New                                                            �
//�ExpO1 : Objeto TSection que a secao pertence                            �
//�ExpC2 : Nome da celula do relat�rio. O SX3 ser� consultado              �
//�ExpC3 : Nome da tabela de referencia da celula                          �
//�ExpC4 : Titulo da celula                                                �
//�        Default : X3Titulo()                                            �
//�ExpC5 : Picture                                                         �
//�        Default : X3_PICTURE                                            �
//�ExpC6 : Tamanho                                                         �
//�        Default : X3_TAMANHO                                            �
//�ExpL7 : ITforme se o tamanho esta em pixel                              �
//�        Default : False                                                 �
//�ExpB8 : Bloco de c�digo para impressao.                                 �
//�        Default : ExpC2                                                 �
//�                                                                        �
//��������������������������������������������������������������������������
oCadPj := TRSection():New(oReport,"Campanha",{"SZG"},/*{Array com as ordens do relat�rio}*/,/*Campos do SX3*/,/*Campos do SIX*/)
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
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  �ReportPrin� Autor �Marco Bianchi          � Data � 26/06/06 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o �A funcao estatica ReportDef devera ser criada para todos os ���
���          �relatorios que poderao ser agendados pelo usuario.          ���
���          �                                                            ���
�������������������������������������������������������������������������Ĵ��
���Retorno   �Nenhum                                                      ���
�������������������������������������������������������������������������Ĵ��
���Parametros�ExpO1: Objeto Report do Relat�rio                           ���
���          �                                                            ���
�������������������������������������������������������������������������Ĵ��
���   DATA   � Programador   �Manutencao efetuada                         ���
�������������������������������������������������������������������������Ĵ��
���          �               �                                            ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
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
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Funcao    �AjustaSX1 � Autor �Marco Bianchi          � Data �10/11/2006���
�������������������������������������������������������������������������Ĵ��
���Descri��o �Acerta o arquivo de perguntas                               ���
�������������������������������������������������������������������������Ĵ��
���Retorno   �Nenhum                                                      ���
�������������������������������������������������������������������������Ĵ��
���   DATA   � Programador   �Manutencao Efetuada                         ���
�������������������������������������������������������������������������Ĵ��
���          �               �                                            ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
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

Aadd( aHelpP11, "Considera faturamento at� a data ?" )
PutSx1("TREPSZD","02","Data refer�ncia ?" ,"","","mv_ch2","D",8,0,,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",aHelpP11,aHelpE11,aHelpS11)
aHelpP11	:= {}

RestArea(aArea)

Return
*/