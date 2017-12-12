#INCLUDE "rwmake.ch"
#include "colors.ch"  
#include "protheus.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NOVO2     � Autor � AP6 IDE            � Data �  17/08/12   ���
�������������������������������������������������������������������������͹��
���Descricao � Codigo gerado pelo AP6 IDE.                                ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP6 IDE                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function CADPJ 

Local aCores  := {}

AADD(aCores,{"SZG->ZG_DEMISSA = ctod('  /  /  ')" ,"BR_VERDE" })
AADD(aCores,{"SZG->ZG_DEMISSA <> ctod('  /  /  ')" ,"BR_VERMELHO" })
AADD(aCores,{"SZG->ZG_FIMCONT >= ctod(dDatabase)","BR_AMARELO"})
                                                                            

//���������������������������������������������������������������������Ŀ
//� Declaracao de Variaveis                                             �
//�����������������������������������������������������������������������

Private cCadastro := "Cadastro de Funcionario PJ"
Private aRotina := { {"Pesquisar","AxPesqui",0,1} ,;
             {"Visualizar","AxVisual",0,2} ,;
             {"Incluir","AxInclui",0,3} ,;
             {"Alterar","AxAltera",0,4} ,;
             {"Excluir","AxDeleta",0,5} ,;
             {"Vencimentos","u_Vencimento",0,6} ,;
             {"Rel.Cad.PJ","u_RELSZG",0,7} ,;
             {"Rel.Cont.Venc","u_RRELVENC",0,8} ,;
             {"Legenda","u_nLegenda",0,9}}

Private cDelFunc := ".T." // Validacao para a exclusao. Pode-se utilizar ExecBlock

Private cString := "SZG"

dbSelectArea("SZG")
dbSetOrder(1)

//���������������������������������������������������������������������Ŀ
//� Executa a funcao MBROWSE. Sintaxe:                                  �
//�                                                                     �
//� mBrowse(<nLin1,nCol1,nLin2,nCol2,Alias,aCampos,cCampo)              �
//� Onde: nLin1,...nCol2 - Coordenadas dos cantos aonde o browse sera   �
//�                        exibido. Para seguir o padrao da AXCADASTRO  �
//�                        use sempre 6,1,22,75 (o que nao impede de    �
//�                        criar o browse no lugar desejado da tela).   �
//�                        Obs.: Na versao Windows, o browse sera exibi-�
//�                        do sempre na janela ativa. Caso nenhuma este-�
//�                        ja ativa no momento, o browse sera exibido na�
//�                        janela do proprio SIGAADV.                   �
//� Alias                - Alias do arquivo a ser "Browseado".          �
//� aCampos              - Array multidimensional com os campos a serem �
//�                        exibidos no browse. Se nao informado, os cam-�
//�                        pos serao obtidos do dicionario de dados.    �
//�                        E util para o uso com arquivos de trabalho.  �
//�                        Segue o padrao:                              �
//�                        aCampos := { {<CAMPO>,<DESCRICAO>},;         �
//�                                     {<CAMPO>,<DESCRICAO>},;         �
//�                                     . . .                           �
//�                                     {<CAMPO>,<DESCRICAO>} }         �
//�                        Como por exemplo:                            �
//�                        aCampos := { {"TRB_DATA","Data  "},;         �
//�                                     {"TRB_COD" ,"Codigo"} }         �
//� cCampo               - Nome de um campo (entre aspas) que sera usado�
//�                        como "flag". Se o campo estiver vazio, o re- �
//�                        gistro ficara de uma cor no browse, senao fi-�
//�                        cara de outra cor.                           �
//�����������������������������������������������������������������������

dbSelectArea("SZG")
mBrowse( 6,1,22,75,cString,,,,,,aCores)


dbSelectArea("SZG")
dbclosearea()

Return 


/*BEGINDOC
//�������������������Ŀ
//�Legendas           �
//�                   �
//�VERDE - ATIVO      �
//�VERMELHO - DEMITIDO�
//���������������������
ENDDOC*/

User Function nLegenda()

BrwLegenda(cCadastro,"Legenda",;
{ { 'BR_VERDE', 'Funcionario Ativo'},;
{ 'BR_VERMELHO', 'Funcionario Demitido'},;
{ 'BR_AMARELO', 'Contrato Vencido'}})

Return

/*********************************************************************************************

Mensagem de vencimento de contrato

*********************************************************************************************/

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �RELSZG    � Autor � Sidney Oliveira    � Data �  29/08/12   ���
�������������������������������������������������������������������������͹��
���Descricao � Relatorio com cadastro dos funcionarios Pessoa Juridica    ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP6 IDE                                                    ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function RELSZG()


//���������������������������������������������������������������������Ŀ
//� Declaracao de Variaveis                                             �
//�����������������������������������������������������������������������

Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := "de acordo com os parametros informados pelo usuario."
Local cDesc3         := "RELACAO DE FUNCIONARIOS PJ"
Local cPict          := ""
Local titulo       := "RELACAO DE FUNCIONARIOS PESSOA JURIDICA"
Local nLin         := 80

Local Cabec1       := ""
Local Cabec2       := ""
Local imprime      := .T.
Local aOrd := {}
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite           := 80
Private tamanho          := "P"
Private nomeprog         := "RELSZG" // Coloque aqui o nome do programa para impressao no cabecalho
Private nTipo            := 18
Private aReturn          := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey        := 0
//Private cPerg       := "RELSZG"
Private cbtxt      := Space(10)
Private cbcont     := 00
Private CONTFL     := 01
Private m_pag      := 01
Private wnrel      := "RELSZG" // Coloque aqui o nome do arquivo usado para impressao em disco

Private cString := "SZG"

dbSelectArea("SZG")
dbSetOrder(1)


//���������������������������������������������������������������������Ŀ
//� Processamento. RPTSTATUS monta janela com a regua de processamento. �
//�����������������������������������������������������������������������

RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)

SZG->(dbclosearea())

Return

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Fun��o    �RUNREPORT � Autor � AP6 IDE            � Data �  28/06/10   ���
�������������������������������������������������������������������������͹��
���Descri��o � Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS ���
���          � monta a janela com a regua de processamento.               ���
�������������������������������������������������������������������������͹��
���Uso       � Programa principal                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)

Local nOrdem

cQry := ""
dbSelectArea(cString)
dbSetOrder(1)

//���������������������������������������������������������������������Ŀ
//� SETREGUA -> Indica quantos registros serao processados para a regua �
//�����������������������������������������������������������������������

SetRegua(RecCount())

/*
cPERG := "RELSZG"
VALIDPERG()
Pergunte(cPERG,.t.)
*/


aDbStru := {}

	AADD(aDbStru,{"CODIGO"	,"C",06,0})
	AADD(aDbStru,{"NOME"	,"C",30,0})
	AADD(aDbStru,{"RAZAO"	,"C",40,0})		
	AADD(aDbStru,{"CNPJ"	,"C",14,0})		
	AADD(aDbStru,{"CC"	,"C",09,0})			
	AADD(aDbStru,{"DESC_CC"	,"C",20,0})
	AADD(aDbStru,{"ADMISSAO","D",08,0})	
	AADD(aDbStru,{"DEMISSAO","D",08,0})	
	AADD(aDbStru,{"BANCO"	,"C",10,0})	
	AADD(aDbStru,{"AGENCIA"	,"C",05,0})
	AADD(aDbStru,{"DIGITO"	,"C",01,0})	
	AADD(aDbStru,{"CONTA" 	,"C",10,0})	
	AADD(aDbStru,{"DIGCTA"	,"C",01,0})	
	AADD(aDbStru,{"SITFOLHA","C",01,0})	
	AADD(aDbStru,{"CODFUNC"	,"C",05,0})				
	AADD(aDbStru,{"DESCFUN"	,"C",20,0})
	AADD(aDbStru,{"SALARIO"	,"C",12,0})
	AADD(aDbStru,{"SALAUT"	,"C",08,0})
	AADD(aDbStru,{"CARGO"	,"C",05,0})
	AADD(aDbStru,{"DESCCAR"	,"C",30,0})
	AADD(aDbStru,{"FIMCONT"	,"D",08,0})

//CRIA ARQ TEMPORARIO COMO DBF PARA O EXCEL PODER ABRIR
CNOMEDBF := "RELSZG-"+DTOS(DDATABASE)
DBCREATE(CNOMEDBF,aDbStru,"DBFCDXADS")
DbUseArea(.T.,"DBFCDXADS","SYSTEM\" + CNOMEDBF,"XLS",.T.,.F.)


cQry += " SELECT ZG_CODIGO, ZG_NOME, ZG_RAZAO, ZG_CGC, ZG_CC, ZG_DESCC, ZG_ADMISSA,
cQry += " ZG_DEMISSA, ZG_BANCO, ZG_AGENCIA, ZG_AGEDV, ZG_CTABCO, ZG_CTADV, 
cQry += " ZG_SITFOLH, ZG_CODFUNC, ZG_DESCFUN, ZG_SALARIO, 
cQry += " ZG_SALAUT, ZG_CARGO, ZG_DESCCAR, ZG_FIMCONT
cQry += " FROM "+RetSqlName("SZG")+" SZG
cQry += " WHERE D_E_L_E_T_ <> '*'
cQry += " ORDER BY ZG_CODIGO

If Select("TRB") > 0
	dbSelectArea("TRB")
	dbCloseArea("TRB")
Endif

cQry := ChangeQuery(cQry)


dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),"TRB",.T.,.T.)

//MemoWrit("RELSZG",cQry)


//TCQUERY cQry ALIAS "TRB" NEW

dbSelectArea("TRB")

While !TRB->(EOF())
	
	XLS->(RECLOCK("XLS",.T.))
	
	XLS->CODIGO 		:= TRB->ZG_CODIGO
	XLS->NOME 			:= TRB->ZG_NOME
	XLS->RAZAO			:= TRB->ZG_RAZAO
	XLS->CNPJ			:= TRB->ZG_CGC
	XLS->CC				:= TRB->ZG_CC
	XLS->DESC_CC		:= TRB->ZG_DESCC
	XLS->ADMISSAO		:= CTOD(SUBSTR(TRB->ZG_ADMISSA,7,2)+"/"+SUBSTR(TRB->ZG_ADMISSA,5,2)+"/"+SUBSTR(TRB->ZG_ADMISSA,1,4))
	XLS->DEMISSAO		:= CTOD(SUBSTR(TRB->ZG_DEMISSA,7,2)+"/"+SUBSTR(TRB->ZG_DEMISSA,5,2)+"/"+SUBSTR(TRB->ZG_DEMISSA,1,4))
	XLS->BANCO			:= TRB->ZG_BANCO
	XLS->AGENCIA		:= TRB->ZG_AGENCIA
	XLS->DIGITO			:= TRB->ZG_AGEDV
	XLS->CONTA 			:= TRB->ZG_CTABCO
	XLS->DIGCTA			:= TRB->ZG_CTADV
	XLS->SITFOLHA		:= TRB->ZG_SITFOLH
	XLS->CODFUNC		:= TRB->ZG_CODFUNC
	XLS->DESCFUN		:= TRB->ZG_DESCFUN
   	XLS->SALARIO		:= STR(TRB->ZG_SALARIO)
	XLS->SALAUT			:= TRB->ZG_SALAUT
	XLS->CARGO			:= TRB->ZG_CARGO
	XLS->DESCCAR		:= TRB->ZG_DESCCAR
   	XLS->FIMCONT		:= CTOD(SUBSTR(TRB->ZG_FIMCONT,7,2)+"/"+SUBSTR(TRB->ZG_FIMCONT,5,2)+"/"+SUBSTR(TRB->ZG_FIMCONT,1,4))
	
	TRB->(DBSKIP())

EndDo

XLS->(DBGOTOP())
CpyS2T( "\SYSTEM\" + CNOMEDBF +".DBF" , "C:\RELATORIOS\" , .F. )
Alert("Arquivo salvo em C:\RELATORIOS\" + CNOMEDBF + ".DBF" )

If ! ApOleClient( 'MsExcel' )
	MsgStop( 'MsExcel nao instalado' )
	Return
EndIf

DbSelectArea("TRB")
DbCloseArea()

oExcelApp := MsExcel():New()
oExcelApp:WorkBooks:Open( "C:\RELATORIOS\" + CNOMEDBF +".DBF" ) // Abre uma planilha
oExcelApp:SetVisible(.T.)
XLS->(DBCLOSEAREA())

//MS_FLUSH()
dbCloseArea("TRB")
Return  

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  �VALIDPERG � Autor � RAIMUNDO PEREIRA      � Data � 01/08/02 ���
�������������������������������������������������������������������������Ĵ��
���          � Verifica as perguntas inclu�ndo-as caso n�o existam        ���
�������������������������������������������������������������������������Ĵ��
���Uso       � Especifico para Clientes Microsiga                         ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
/*
Static Function ValidPerg()
_aAreaVP := GetArea()
DBSelectArea("SX1")
DBSetOrder(1)
cPerg := PADR(cPerg,10)
aRegs:={}

// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05
AADD(aRegs,{cPerg,"01","Data DE ?","","","mv_ch1","D", 8,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"02","Data ATE ?","","","mv_ch2","D", 8,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"03","Tipo ?","","","mv_ch3","C",1,0,1,"C","","mv_par03","TODOS","","","","","LIB POR VENDAS","","","","","LIB FINANCEIRO","","","","","FATURADO","","","","","","","","",""})

For i:=1 to Len(aRegs)
	If !DBSeek(cPerg+aRegs[i,2])
		RecLock("SX1",.T.)
		For j:=1 to Len(aRegs[i])
			FieldPut(j,aRegs[i,j])
		Next
		MsUnlock()
	Endif
Next

RestArea(_aAreaVP)
Return 
*/


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �RELVENC   �Autor  �Sidney Oliveira     � Data �  31/08/12   ���
�������������������������������������������������������������������������͹��
���Desc.     � Relatorio referente ao controle de contratos vencidos      ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/


/*���������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  � TREPSZD� Autor � Marco Bianchi        � Data � 15/06/12    ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � RELATORIO DA CAMPANHA ANALITICO                            ���
�������������������������������������������������������������������������Ĵ��
���Uso       � SIGAFAT - R4 - ESPECIFICO NC GAMES                         ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
���������������������������������������������������������������������������*/
User Function RRELVENC()

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
Local oFatVend
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
oReport := TReport():New("RRELVENC","Vencimento de Contrato",, {|oReport| ReportPrint(oReport,oFatVend)},"")
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
oFatVend := TRSection():New(oReport,"Vencimento de contrato",{"SZG"},/*{Array com as ordens do relat�rio}*/,/*Campos do SX3*/,/*Campos do SIX*/)
oFatVend:SetTotalInLine(.F.)
//Dados cadastrais
TRCell():New(oFatVend,"ZG_CODIGO"	,"SZG",RetTitle("ZG_CODIGO")		,PesqPict("SZG","ZG_CODIGO")	,TamSx3("ZG_CODIGO")	[1]	,/*lPixel*/,/*{|| cVend }*/						)		// "Codigo do Cliente"
TRCell():New(oFatVend,"ZG_NOME"		,"SZG",RetTitle("ZG_NOME")			,PesqPict("SZG","ZG_NOME")		,TamSx3("ZG_NOME")		[1]	,/*lPixel*/,/*{|| cLjCli }*/					)		// "Codigo do Cliente"
TRCell():New(oFatVend,"ZG_RAZAO"	,"SZG",RetTitle("ZG_RAZAO")		,PesqPict("SZG","ZG_RAZAO")		,TamSx3("ZG_RAZAO")		[1]	,/*lPixel*/,/*{|| cUf }*/	 )		// "Codigo do Cliente"
TRCell():New(oFatVend,"ZG_CGC"		,"SZG",RetTitle("ZG_CGC")		,PesqPict("SZG","ZG_CGC")		,TamSx3("ZG_CGC")		[1]	,/*lPixel*/,/*{|| cUf }*/)		// "Codigo do Cliente"
TRCell():New(oFatVend,"ZG_CC"		,"SZG",RetTitle("ZG_CC")		,PesqPict("SZG","ZG_CC")		,TamSx3("ZG_CC")		[1]	,/*lPixel*/,/*{|| cUf }*/)		// "Codigo do Cliente"
TRCell():New(oFatVend,"ZG_DESCC"	,"SZG",RetTitle("ZG_DESCC")		,PesqPict("SZG","ZG_DESCC")		,TamSx3("ZG_DESCC")		[1]	,/*lPixel*/,/*{|| cUf }*/)		// "Codigo do Cliente"
TRCell():New(oFatVend,"ZG_FIMCONT"	,"SZG",RetTitle("ZG_FIMCONT")		,PesqPict("SZG","ZG_FIMCONT")		,TamSx3("ZG_FIMCONT")		[1]	,/*lPixel*/,/*{|| cUf }*/)		// "Codigo do Cliente"

// Alinhamento das colunas de valor a direita
/*
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
*/
//oFatVend:Cell("QTDPED"):SetHeaderAlign("RIGHT")
//oFatVend:Cell("VALPED"):SetHeaderAlign("RIGHT")

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
Static Function ReportPrint(oReport,oFatVend)

DbSelectArea("SZG")
oReport:section(1):Init()
oReport:SetMeter(LastRec())
While SZG->(!EOF())
	
	oReport:IncMeter()
	
	oReport:section(1):PrintLine()
	
	dbSkip()
EndDo
DbSelectArea("SZG")
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