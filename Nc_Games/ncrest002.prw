#Include "Protheus.ch"
#Include "Topconn.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCRST002  บAutor  ณMauricio Mendes     บ Data ณ  27/04/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณPlanilha de Vendas Totais                                   บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NCGAMES.                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function NCRST002()

Public _aCampos := {}
Public aCabec	:= {}
Public aItensExcel	:= {}
Private _cArqTmp	:= ""
Private _cIndTmp	:= ""

fRelato()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfRelato   บAutor  ณMauricio Mendes     บ Data ณ  23/04/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao da chamada do relatorio.                             บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNCGAMES                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fRelato()

Private cPerg := "REST02"

fCriaSx1()

Pergunte(cPerg,.t.)

If Empty(mv_par09)
	msgstop("Arquivo de saida nใo especificado ")
	Return
Endif


If ApMsgYesNo("Confirma geracao da Planilha ??","Confirmar")
	fGeraTmp()
Else
	Return
EndIf

Processa({|| fAtuDados() },"Processando Planilha")

/*cFOpen := cGetFile("Todos os Arquivos|*.*",'Selecione o Diretorio',0,'C:\',.T.,GETF_LOCALFLOPPY+GETF_LOCALHARD+GETF_NETWORKDRIVE+GETF_RETDIRECTORY,.F.)

mv_par09 := cfOpen+alltrim(mv_par09)+".XLS"

__CopyFile(_cArqTmp+".DBF",mv_par09)

apmsgstop("Arquivo Gerado "+mv_par09,"ATENCAO")



If ! ApOleClient( 'MsExcel' )
	MsgStop( 'MsExcel nao instalado' )
	Return
EndIf
// abre arquivo temporario em excel.
oExcelApp := MsExcel():New()
oExcelApp:WorkBooks:Open( mv_par09 ) // Abre uma planilha
oExcelApp:SetVisible(.T.)

Ferase(_cArqTmp+".DBF")
*/


Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfCriaSx1  บAutor  ณMauricio Mendes     บ Data ณ  23/04/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCriacao de perguntas do relatorio.                          บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NCGAMES                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fCriaSx1()

PutSX1(cPerg,"01","Data de?     "   ,"Data de?     "	,"Data de?     "	,"mv_ch1","D",08,0,1,"G","","","","","mv_par01","","","","","","","","","","","","","","","","")
PutSX1(cPerg,"02","Data Ate?    "   ,"Data Ate?    "	,"Data Ate?    "	,"mv_ch2","D",08,0,1,"G","","","","","mv_par02","","","","","","","","","","","","","","","","")
PutSX1(cPerg,"03","Produto de?  "   ,"Produto de? "		,"Produto de ?"		,"mv_ch3","C",15,0,1,"G","","SB1","","","mv_par03","","","","","","","","","","","","","","","","")
PutSX1(cPerg,"04","Produto ate? "   ,"Produto ate?"		,"Produto ate?"		,"mv_ch4","C",15,0,1,"G","","SB1","","","mv_par04","","","","","","","","","","","","","","","","")
PutSX1(cPerg,"05","Item Ctb de? "   ,"Item Ctb de? "   	,"Item Ctb de? "   	,"mv_ch5","C",09,0,1,"G","","CTD","","","mv_par05","","","","","","","","","","","","","","","","")
PutSX1(cPerg,"06","Item Ctb ate?"   ,"Item Ctb ate?"   	,"Item Ctb ate?"   	,"mv_ch6","C",09,0,1,"G","","CTD","","","mv_par06","","","","","","","","","","","","","","","","")
PutSX1(cPerg,"07","Grupo de    ? "  ,"Grupo de    ? "	,"Grupo de    ? "	,"mv_ch7","C",04,0,1,"G","","SBM","","","mv_par07","","","","","","","","","","","","","","","","")
PutSX1(cPerg,"08","Grupo Ate   ?"   ,"Grupo Ate   ?"   	,"Grupo Ate   ?"   	,"mv_ch8","C",04,0,1,"G","","SBM","","","mv_par08","","","","","","","","","","","","","","","","")
PutSX1(cPerg,"09","Arquivo ?    "   ,"Arquivo    ?"		,"Arquivo    ?"		,"mv_ch9","C",80,0,1,"G","","","","","mv_par09","","","","","","","","","","","","","","","","")

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfGeraTmp  บAutor  ณAdriano Luis Brandaoบ Data ณ  15/04/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao para gerar arquivo temporario em branco.            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP - TISHMAN.                                              บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fGeraTmp()


aAdd(_aCampos,{"CODIGO","C",15,0})		//Codigo Nc B1_COD
aAdd(_aCampos,{"CODBAR","C",15,0})		//Codigo Barras B1_CODBAR
aAdd(_aCampos,{"DESC_NG","C",100,00})	//Descricao NG B1_XDESC
aAdd(_aCampos,{"RESP_PUBL","C",30,00})	//Responsavel pelo Publisher CTD_RESPON a ser procurado pelo item B1_ITEMCC
aAdd(_aCampos,{"PUBLISH","C",40,0})		//B1_PUBLISH
aAdd(_aCampos,{"GRUPO","C",30,0})		//BM_DESC a partir do campo B1_GRUPO
aAdd(_aCampos,{"GENERO","C",55,0})		//X5_DESCRI ATRAVES DA TABELA Z2 DO SX5 B1_CODGEN
aAdd(_aCampos,{"BLOQUEADO","C",03,0})	//Trazer sim ou nao conforme combo do campo B1_BLQVEND 1=Sim 2=Nใo Campo Caractere
aAdd(_aCampos,{"INATIVO","C",03,0})		//Trazer sim ou nao conforme combo do campo B1_MSBLQL  1=Sim 2=Nใo Campo Caractere

aAdd(aCabec,{"Codigo Nc","C",15,0})		//Codigo Nc B1_COD
aAdd(aCabec,{"UPC","C",15,0})		//Codigo Barras B1_CODBAR
aAdd(aCabec,{"Descri็ใo NC","C",100,0})	//Descricao NG B1_XDESC
aAdd(aCabec,{"Resp. Publisher","C",30,0})	//Responsavel pelo Publisher CTD_RESPON a ser procurado pelo item B1_ITEMCC
aAdd(aCabec,{"Publisher","C",40,0})		//B1_PUBLISH
aAdd(aCabec,{"Grupo","C",30,0})		//BM_DESC a partir do campo B1_GRUPO
aAdd(aCabec,{"Genero","C",55,0})		//X5_DESCRI ATRAVES DA TABELA Z2 DO SX5 B1_CODGEN
aAdd(aCabec,{"Bloqueado?","C",03,0})	//Trazer sim ou nao conforme combo do campo B1_BLQVEND 1=Sim 2=Nใo Campo Caractere
aAdd(aCabec,{"Inativo?","C",03,0})		//Trazer sim ou nao conforme combo do campo B1_MSBLQL  1=Sim 2=Nใo Campo Caractere

// Produtos mes a mes

_dDataIni := MV_PAR01
_dDataFim := Lastday(MV_PAR02)
Do While _dDataIni <= _dDataFim
	cCampo := Strzero(month(_dDataIni),2)+Strzero(Year(_dDataIni),4)
	aAdd(_aCampos,{"Q_"+cCampo,"N",16,2})	// Coluna do mes
	aAdd(_aCampos,{"V_"+cCampo,"N",16,2})	// Coluna do mes

	aAdd(aCabec,{"Qtd Fat m๊s "+cCampo,"N",16,2})	// Coluna do mes
	aAdd(aCabec,{"Valor Fat m๊s "+cCampo,"N",16,2})	// Coluna do mes

	_dDataIni := Lastday(_dDataIni)+1
EndDo

// Fim de Produtos mes a mes
aAdd(_aCampos,{"TOTPROV","N",16,2})		// Total de Produtos Vendidos
aAdd(_aCampos,{"TOTQFAT3","N",16,2})	// Total Quantidade Faturada -3
aAdd(_aCampos,{"TOTQFAT2","N",16,2})	// Total Quantidade Faturada -2
aAdd(_aCampos,{"TOTQFAT1","N",16,2})	// Total Quantidade Faturada -1
aAdd(_aCampos,{"QTDDISP","N",16,2})		// Quantidade Disponivel B2_QATU
aAdd(_aCampos,{"DT1AVD","D",08,0})		// Data 1a Venda ( B1_DTLANC )
aAdd(_aCampos,{"CMV","N",16,2})		// Custo Medio unitario atual do produto
aAdd(_aCampos,{"DIASVD","N",16,2})		// Dias de Venda ( Quantidade de dias desde a 1a entrada em estoque ate hoje )
aAdd(_aCampos,{"PRCVEN","N",16,2})		// Preco de venda ( Tabela 018 DA1_PRCVEN DA1_CODTAB = '018' )
aAdd(_aCampos,{"PRCSICMS","N",16,2})	// Campo anterior multiplicado * 0,0847458
aAdd(_aCampos,{"PR_M_SIC","N",16,2})	// Preco medio realizado sem ICMS mes corrente.
aAdd(_aCampos,{"PER_DESMC","N",16,2})	// Percentual de desconto mes corrente.
aAdd(_aCampos,{"ESTVENDA","N",16,2})	// Preco da tabela 018 * Quantidade disponivel
aAdd(_aCampos,{"MEDIA","N",16,2})		// Quantidade Faturada nos ultimos 3 meses/3.
aAdd(_aCampos,{"GIRO","N",16,2})		// Media * Preco de Venda.
aAdd(_aCampos,{"MES_EST","N",16,2})		// Quantidade disponivel / Media.
aAdd(_aCampos,{"____","N",16,2})		// ฺltima linha


aAdd(aCabec,{"Tot. Produtos Vendidos","N",16,2})		// Total de Produtos Vendidos
aAdd(aCabec,{"Qtd Fat D-3","N",16,2})	// Total Quantidade Faturada -3
aAdd(aCabec,{"Qtd Fat D-2","N",16,2})	// Total Quantidade Faturada -2
aAdd(aCabec,{"Qtd Fat D-1","N",16,2})	// Total Quantidade Faturada -1
aAdd(aCabec,{"Qtd Disponivel","N",16,2})		// Quantidade Disponivel B2_QATU
aAdd(aCabec,{"Dt 1a. Venda","D",08,0})		// Data 1a Venda ( B1_DTLANC )
aAdd(aCabec,{"CMV Unitแrio","N",16,2})		// Custo Medio unitario atual do produto
aAdd(aCabec,{"Dias Venda","N",16,2})		// Dias de Venda ( Quantidade de dias desde a 1a entrada em estoque ate hoje )
aAdd(aCabec,{"Pre็o Venda","N",16,2})		// Preco de venda ( Tabela 018 DA1_PRCVEN DA1_CODTAB = '018' )
aAdd(aCabec,{"Pre็o sem ICMS","N",16,2})	// Campo anterior multiplicado * 0,0847458
aAdd(aCabec,{"Pre็o m้dio sem ICMS","N",16,2})	// Preco medio realizado sem ICMS mes corrente.
aAdd(aCabec,{"Desconto m๊s atual","N",16,2})	// Percentual de desconto mes corrente.
aAdd(aCabec,{"Estoque Venda","N",16,2})	// Preco da tabela 018 * Quantidade disponivel
aAdd(aCabec,{"M้dia","N",16,2})		// Quantidade Faturada nos ultimos 3 meses/3.
aAdd(aCabec,{"Giro","N",16,2})		// Media * Preco de Venda.
aAdd(aCabec,{"Meses de Estoque","N",16,2})		// Quantidade disponivel / Media.
aAdd(aCabec,{"____","N",16,2})		// ฺltima linha

_cArqTmp	:= Criatrab(_aCampos,.t.)
//_cIndTmp	:= Criatrab(,.f.)

If Select("TMP") > 0
	TMP->(dbCloseArea())
Endif

DbUseArea(.T.,,_cArqTmp,"TMP",.T.,.F.)

//IndRegua("TMP",_cIndTmp,"TIPO+C_CUSTO",,,"Criando indice....")

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfAtuDados บAutor  ณMauricio Mendes     บ Data ณ  23/04/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao para gerar dados para o arquivo Excel               บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NCGAMES                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function fAtuDados()

Private nQatu 		:= 0
Private nVatu 		:= 0
Private nCMV  		:= 0
Private nuCMVS  	:= 0
Private nprcven 	:= 0
Private cGenero 	:= Space(55)
Private cPlataf 	:= space(30)
Private cRespPubl	:= space(30)
Private aRetVal 	:= {}
Private n_PR_M_SIC := 0	// Valor faturado no mes corrente sem icms
Private nMedia := 0
Private _nTotfat1 := 0
Private _nTotfat2 := 0
Private _nTotfat3 := 0

IF EMPTY(MV_PAR04)
	MV_PAR04 = 'ZZZZZZZZZZZZZZZ'
Endif

IF EMPTY(MV_PAR06)
	MV_PAR06 = 'ZZZZZZZZZ'
Endif

IF EMPTY(MV_PAR08)
	MV_PAR08 = 'ZZZZ'
Endif

_cQuery := "SELECT count(*) total FROM "+RETSQLNAME("SB1")+ " B1 "
_cQuery += "       WHERE B1_FILIAL = '" + xFilial("SB1") + "' "
_cQuery += "             AND B1_COD BETWEEN '" + MV_PAR03 + "' AND '" + MV_PAR04 + "' "
_cQuery += "             AND B1_ITEMCC BETWEEN '" + MV_PAR05 + "' AND '" + MV_PAR06 + "' "
_cQuery += "             AND B1_GRUPO BETWEEN '" + MV_PAR07 + "' AND '" + MV_PAR08 + "' "
_cQuery += "             AND B1.D_E_L_E_T_ = ' ' "

If Select("QR1") > 0
	QR1->(dbCloseArea())
Endif

TcQuery _cQuery New Alias "QR1"
dbSelectArea("QR1")
dbGotop()

nTotal := QR1->total

If Select("QR1") > 0
	QR1->(dbCloseArea())
Endif

_cQuery := "SELECT * FROM "+RETSQLNAME("SB1")+ " B1 "
_cQuery += "       WHERE B1_FILIAL = '" + xFilial("SB1") + "' "
_cQuery += "             AND B1_COD BETWEEN '" + MV_PAR03 + "' AND '" + MV_PAR04 + "' "
_cQuery += "             AND B1_ITEMCC BETWEEN '" + MV_PAR05 + "' AND '" + MV_PAR06 + "' "
_cQuery += "             AND B1_GRUPO BETWEEN '" + MV_PAR07 + "' AND '" + MV_PAR08 + "' "
_cQuery += "             AND B1.D_E_L_E_T_ = ' ' "
_cQuery += "ORDER BY B1_COD "

If Select("QR1") > 0
	QR1->(dbCloseArea())
Endif

TcQuery _cQuery New Alias "QR1"

dbSelectArea("QR1")
dbGotop()

ProcRegua(nTotal)

// Valor faturado no mes corrente sem icms sem icms
n_PR_M_SIC := 0

// Media vendida nos ultimos 3 meses
nMedia := 0

While QR1->(!EOF())
	
	IncProc()
	
	dbSelectArea("SB2")
	dbSetOrder(1)
	If dbSeek(xfilial("SB2")+QR1->B1_COD+QR1->B1_LOCPAD)
		nQatu 	:= SB2->B2_QATU
		nVatu	:= SB2->B2_VATU1
	Else
		nQatu 	:= 0
		nVatu	:= 0
	Endif
	
	
	//-- cQuery := "SELECT TOP 1 * FROM "+RETSQLNAME("SD2")+" SD2, "+CHR(13) + CHR(10)
	cQuery := "SELECT D2_QUANT,D2_CUSTO1,D2_QUANT FROM "+RETSQLNAME("SD2")+" SD2, "+CHR(13) + CHR(10)
	cQuery += RETSQLNAME("SF4")+ " SF4  WHERE SD2.D_E_L_E_T_ = ' ' " + CHR(13) + CHR(10)
	cQuery += "AND SF4.D_E_L_E_T_ = ' ' " + CHR(13) + CHR(10)
	cQuery += "AND D2_TES = F4_CODIGO " + CHR(13) + CHR(10)
	cQuery += "AND F4_ESTOQUE = 'S' " + CHR(13) + CHR(10)
	cQuery += "AND D2_COD = '"+QR1->B1_COD+"' "+ CHR(13) +CHR(10)
	cQuery += "AND D2_LOCAL = '"+QR1->B1_LOCPAD+"' "+ CHR(13) +CHR(10)
	cQuery += "AND D2_FILIAL = '"+XFILIAL("SD2")+"' "+ CHR(13) +CHR(10)
	cQuery += "AND F4_FILIAL = '"+XFILIAL("SF4")+"' "+ CHR(13) +CHR(10)
	cQuery += "AND Rownum < 2 "+ CHR(13) +CHR(10)
	cQuery += "ORDER BY SD2.D2_FILIAL, SD2.D2_EMISSAO DESC "+CHR(13) + CHR(10)
	
	If Select("TMP1") > 0
		TMP1->(dbCloseArea())                     
	Endif                                         
	
	TcQuery cQuery New Alias "TMP1"
	dbSelectArea("TMP1")
	dbGotop()
	IF !EOF() .AND. TMP1->D2_QUANT <> 0
		nuCmvs := TMP1->D2_CUSTO1 / TMP1->D2_QUANT
	Else
		nuCmvs := 0
	Endif
	
	If nQatu <= 0
		nCmv := nuCmvs
	Else
		nCmv := nVatu / nQatu
	Endif
	
	dbSelectArea("SZ5")
	dbSetOrder(1)
	If dbSeek(xFilial("SZ5")+QR1->B1_PLATAF)
		cPlataf := SZ5->Z5_PLATRED
	Else
		cPlataf := "NAO CADASTRADO"
	Endif
	
	dbSelectArea("DA1")
	dbSetOrder(1)
	If dbSeek(xfilial("DA1")+"018"+QR1->B1_COD)
		nprcven := DA1->DA1_PRCVEN
	Endif
	
	dbSelectArea("SX5")
	dbSetOrder(1)
	If dbSeek(xFilial("SX5")+"Z2"+QR1->B1_CODGEN)
		cGenero := SX5->X5_DESCRI
	Endif
	
	dbSelectArea("CTD")
	dbSetOrder(1)
	If dbSeek(xFilial("CTD")+QR1->B1_ITEMCC)
		cRespPubl := CTD->CTD_RESPON
	Endif
	
	// Calculo das colunas mes a mes conforme
	// parametros mv_par01 e mv_par02
	aRetVal := CalcMes()
	
	// Pre็o medio realizado sem icms no mes corrente
	//n_PR_M_SIC := Calcvfsi()
	
	// Media vendida nos ultimos 3 meses
	//	nMedia := Calcmedia()
	
	If month(dDataBase -1) <> month(dDatabase)
		_dDataIni := ctod("01/"+strzero(month(dDataBase),2,0)+"/"+strzero(year(dDataBase),4,0))
		_dDataFim := ctod("01/"+strzero(month(dDataBase),2,0)+"/"+strzero(year(dDataBase),4,0))
		
	Else
		_dDataIni := ctod("01/"+strzero(month(dDataBase),2,0)+"/"+strzero(year(dDataBase),4,0))
		_dDataFim := dDataBase -1
	Endif
	_nTotfat1 := Calcprdvd(_dDataIni,_dDataFim)
	
	
	If month(dDataBase -2) <> month(dDatabase)
		_dDataIni := ctod("01/"+strzero(month(dDataBase),2,0)+"/"+strzero(year(dDataBase),4,0))
		_dDataFim := dDataBase -2
		If _dDataFim < _dDataini
			_dDatafim := _dDataFim + 1
		Endif
		If _dDataFim < _dDataini
			_dDatafim := _dDataFim + 1
		Endif
	Else
		_dDataIni := ctod("01/"+strzero(month(dDataBase),2,0)+"/"+strzero(year(dDataBase),4,0))
		_dDataFim := dDataBase -2
	Endif
	_nTotfat2 := Calcprdvd(_dDataIni,_dDataFim)
	
	If month(dDataBase -3) <> month(dDatabase)
		_dDataIni := ctod("01/"+strzero(month(dDataBase),2,0)+"/"+strzero(year(dDataBase),4,0))
		_dDataFim := dDataBase -3
		If _dDataFim < _dDataini
			_dDatafim := _dDataFim + 1
		Endif
		If _dDataFim < _dDataini
			_dDatafim := _dDataFim + 1
		Endif
		If _dDataFim < _dDataini
			_dDatafim := _dDataFim + 1
		Endif
	Else
		_dDataIni := ctod("01/"+strzero(month(dDataBase),2,0)+"/"+strzero(year(dDataBase),4,0))
		_dDataFim := dDataBase -3
	Endif
	
	_ntotfat3 :=Calcprdvd(_dDataIni,_dDataFim)
	
	
	RecLock("TMP",.t.)
	
	TMP->CODIGO		:= QR1->B1_COD
	TMP->CODBAR		:= QR1->B1_CODBAR
	TMP->DESC_NG	:= QR1->B1_XDESC
	TMP->RESP_PUBL	:= cRespPubl
	TMP->PUBLISH    := QR1->B1_PUBLISH
	TMP->GRUPO		:= getadvfval("SBM","BM_DESC",xFILIAL("SBM")+QR1->B1_GRUPO,1,"")
	TMP->GENERO    	:= cGenero
	TMP->BLOQUEADO  := IIF(QR1->B1_BLQVEND == "2","NAO","SIM")
	TMP->INATIVO	:= IIF(QR1->B1_MSBLQL == "2","NAO","SIM")
	
	_nTotpv := 0
	for x := 1 to len(aRetVal)
		TMP->&(aRetVal[x][1]) := aRetVal[x][4]
		TMP->&(aRetVal[x][2]) := aRetVal[x][5]
		_nTotpv += aRetVal[x][4]
	Next x
	
	aRetCol := {}
	
	TMP->TOTPROV  := _nTotpv
	TMP->TOTQFAT1	:= _nTotfat1
	TMP->TOTQFAT2  	:= _nTotfat2
	TMP->TOTQFAT3	:= _nTotfat3
	TMP->QTDDISP	:= nQatu
	TMP->DT1AVD		:= STOD(QR1->B1_DTLANC)
	TMP->CMV        := nCmv
	TMP->DIASVD     := dDatabase - STOD(QR1->B1_DTLANC)
	TMP->PRCVEN     := nPrcven
	TMP->PRCSICMS   := nPrcven * 0.847458  
	
	aRetCol := CalcCol()
	
	TMP->PR_M_SIC	:= aRetCol[1][3] 
	TMP->PER_DESMC	:= aRetCol[2][3]
	TMP->ESTVENDA  	:= aRetCol[6][3]
	TMP->MEDIA  	:= aRetCol[3][3]
	TMP->GIRO		:= aRetCol[4][3]
	TMP->MES_EST	:= aRetCol[5][3]
	TMP->____		:= 0
	
	aItem := Array(Len(_aCampos))
	//inicio
	for nX := 1 to len(_aCampos)
		if _aCampos[nX][2] == "C"
			aItem[nX] := CHR(160) + TMP->&(_aCampos[nX][1])
		else 
			aItem[nX] :=TMP->&(_aCampos[nX][1]) 
		endif
	next nX
	AADD(aItensExcel,aItem)
	aItem := {}
	
	MsUnlock()
	
	QR1->(DbSkip())

	
EndDo

//alert("stop")
MsgRun ("Favor aguardar ...", "Exportando os Registros para o Excel",{||DlgToExcel({{"GETDADOS","Vendas Totais",aCabec,aItensExcel}})})

If Select("TMP") > 0
	TMP->(dbCloseArea())
Endif


Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCalcMes   บAutor  ณMauricio Mendes     บ Data ณ  30/04/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Calculo do valor mes a mes para gravar na Planilha         บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NCGAMES                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CalcMes()


Private _dData 		:= ctod("  /  /  ")
Private _nQtdv 		:= 0
Private _nValv 		:= 0
Private _aRet 		:= {}
Private _aRetgrv 	:= {}

_dDataIni := MV_PAR01
_dDataFim := Lastday(MV_PAR02)
_aRetgrv 	:= {}


Do While _dDataIni <= _dDataFim
	cCampo01 	:= "Q_"+Strzero(month(_dDataIni),2)+Strzero(Year(_dDataIni),4)
	cCampo02 	:= "V_"+Strzero(month(_dDataIni),2)+Strzero(Year(_dDataIni),4)
	_dData      := _dDataIni
	
	_aRet := Calcval(_dData,_aRet)
	aAdd(_aRetGrv,{cCampo01,cCampo02,_aRet[1],_aRet[2],_aRet[3]})
	
	_dDataIni := Lastday(_dDataIni)+1
EndDo


Return(_aRetGrv)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณcALCVAL   บAutor  ณMauricio Mendes     บ Data ณ  01/05/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NCGAMES                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CalcVal(_dData,_aRet)
Local _a 		:= _aRet
Local _dD 		:= _dData
Local cQuery 	:= ''
Local cNameSD1 	:= RetSqlName("SD1")
Local cNameSD2 	:= RetSqlName("SD2")
Local cNameSF4 	:= RetSqlName("SF4")
Local _nTotQ := 0
Local _nTotV := 0
Local _aNotas := {}

cQuery := "SELECT F4_ESTOQUE,F4_DUPLIC,D2_QUANT,D2_TOTAL+D2_VALFRE+D2_DESPESA+D2_SEGURO+D2_ICMSRET AS D2_TOTAL,D2_DOC,D2_SERIE,D2_COD,D2_CLIENTE,D2_LOJA, D2_ICMSRET "
cQuery += " FROM " + cNameSD2 + " SD2, " + cNameSF4 + " SF4 "
cQuery += " where D2_FILIAL  = '" + xFilial("SD2") + "'"
cQuery += " and SUBSTR(D2_EMISSAO,1,6) = '" + SUBSTR(DTOS(_dD),1,6) + "'"
cQuery += " and D2_COD = '" + QR1->B1_COD + "'"
cQuery += " and D2_LOCAL = '" + QR1->B1_LOCPAD + "'"
cQuery += " and D2_TIPO NOT IN ('D', 'B') "
cQuery += " and F4_FILIAL  = '" + xFilial("SF4") + "' "
cQuery += " and F4_CODIGO  = D2_TES "
cQuery += " and SD2.D_E_L_E_T_ <> '*' "
cQuery += " and SF4.D_E_L_E_T_ <> '*' "
cQuery += " ORDER BY " + SQLORDER (SD2->(INDEXKEY()))

If Select("QR11") > 0
	QR11->(dbCloseArea())
Endif

TcQuery cQuery New Alias "QR11"
dbSelectArea("QR11")
dbGotop()

_nTotQ := 0
_nTotV := 0
_aNotas := {}      

while QR11->(!EOF())
	IF QR11->F4_ESTOQUE == 'S' .AND. QR11->F4_DUPLIC == 'S'
		_nTotQ += QR11->D2_QUANT
		_nTotV += QR11->D2_TOTAL
		aAdd(_aNotas,QR11->D2_DOC+QR11->D2_SERIE+QR11->D2_COD+QR11->D2_CLIENTE+QR11->D2_LOJA)
	Endif
	QR11->(dbSkip())
End

If Select("QR11") > 0
	QR11->(dbCloseArea())
Endif
                                                                                                                             
cQuery := "select F4_ESTOQUE,F4_DUPLIC,D1_NFORI,D1_SERIORI,D1_COD,D1_FORNECE,D1_LOJA,D1_QUANT,D1_TOTAL "
cQuery += " from " + cNameSD1 + " SD1, " + cNameSF4 + " SF4 "
cQuery += " where D1_FILIAL  = '" + xFilial("SD1") + "'"
cQuery += " and SUBSTR(D1_EMISSAO,1,6) >= '" + SUBSTR(DTOS(_dD),1,6) + "' "
cQuery += " and D1_COD  = '" + QR1->B1_COD + "' "
cQuery += " and D1_TIPO = 'D'"
cQuery += " and F4_FILIAL  = '" + xFilial("SF4") + "'"
cQuery += " and F4_CODIGO  = D1_TES"
cQuery += " and SD1.D_E_L_E_T_ = ' '"
cQuery += " and SF4.D_E_L_E_T_ = ' '"

If Select("QR11") > 0
	QR11->(dbCloseArea())
Endif

TcQuery cQuery New Alias "QR11"
dbSelectArea("QR11")
dbGotop()

While QR11->(!EOF())
	IF QR11->F4_ESTOQUE == 'S' .AND. QR11->F4_DUPLIC == 'S'
		If Ascan(_aNotas,QR11->D1_NFORI+QR11->D1_SERIORI+QR11->D1_COD+QR11->D1_FORNECE+QR11->D1_LOJA) > 0
			_nTotQ -= QR11->D1_QUANT
			_nTotV -= QR11->D1_TOTAL
		Endif
	Endif
	QR11->(dbSkip())
End


If Select("QR11") > 0
	QR11->(dbCloseArea())
Endif

_a := {QR1->B1_COD,_nTotQ,_nTotv}

Return(_a)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCalcvfsi  บAutor  ณMauricio Mendes     บ Data ณ  01/05/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCalculo Pre็o medio realizado                               บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NCGAMES                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Calcprdvd(_dIni,_dFinal)
Local nRet := 0
Local cNameSD1 	:= RetSqlName("SD1")
Local cNameSD2 	:= RetSqlName("SD2")
Local cNameSF4 	:= RetSqlName("SF4")
Local _nTotQ := 0
Local _nTotV := 0
Local _aNotas := {}
Local _ddini	:= _dIni
Local _ddFim    := _dFinal

cQuery := "SELECT D2_DOC,D2_SERIE,D2_COD,D2_CLIENTE,D2_LOJA,F4_ESTOQUE,F4_DUPLIC,D2_TOTAL,D2_VALICM, D2_QUANT "
cQuery += " FROM " + cNameSD2 + " SD2, " + cNameSF4 + " SF4 "
cQuery += " where D2_FILIAL  = '" + xFilial("SD2") + "'"
cQuery += " and D2_EMISSAO between '" + DTOS(_ddIni) + "' and  '"+DTOS(_ddFim) + "' "
cQuery += " and D2_COD = '" + QR1->B1_COD + "'"
cQuery += " and D2_LOCAL = '" + QR1->B1_LOCPAD + "'"
cQuery += " and D2_TIPO NOT IN ('D', 'B') "
cQuery += " and F4_FILIAL  = '" + xFilial("SF4") + "' "
cQuery += " and F4_CODIGO  = D2_TES "
cQuery += " and SD2.D_E_L_E_T_ <> '*' "
cQuery += " and SF4.D_E_L_E_T_ <> '*' "
cQuery += " ORDER BY " + SQLORDER (SD2->(INDEXKEY()))

If Select("QR11") > 0
	QR11->(dbCloseArea())
Endif

TcQuery cQuery New Alias "QR11"
dbSelectArea("QR11")
dbGotop()


_nTotV := 0
_nTotQ := 0
_aNotas := {}

while QR11->(!EOF())
	IF QR11->F4_ESTOQUE == 'S' .AND. QR11->F4_DUPLIC == 'S'
		_nTotV += QR11->D2_TOTAL - QR11->D2_VALICM
		_nTotQ += QR11->D2_QUANT
		aAdd(_aNotas,QR11->D2_DOC+QR11->D2_SERIE+QR11->D2_COD+QR11->D2_CLIENTE+QR11->D2_LOJA)
	Endif
	QR11->(dbSkip())
End


cQuery := "select D1_NFORI,D1_SERIORI,D1_COD,D1_FORNECE,D1_LOJA,F4_ESTOQUE,D1_TOTAL,D1_VALICM,D1_QUANT,F4_DUPLIC "
cQuery += " from " + cNameSD1 + " SD1, " + cNameSF4 + " SF4 "
cQuery += " where D1_FILIAL  = '" + xFilial("SD1") + "'"
cQuery += " and SUBSTR(D1_EMISSAO,1,6) >= '" + SUBSTR(DTOS(_ddIni),1,6) + "' "
cQuery += " and D1_COD  = '" + QR1->B1_COD + "' "
cQuery += " and D1_TIPO = 'D'"
cQuery += " and F4_FILIAL  = '" + xFilial("SF4") + "'"
cQuery += " and F4_CODIGO  = D1_TES"
cQuery += " and SD1.D_E_L_E_T_ = ' '"
cQuery += " and SF4.D_E_L_E_T_ = ' '"


If Select("QR11") > 0
	QR11->(dbCloseArea())
Endif

TcQuery cQuery New Alias "QR11"
dbSelectArea("QR11")
dbGotop()                                                                                           

while QR11->(!EOF())
	IF QR11->F4_ESTOQUE == 'S' .AND. QR11->F4_DUPLIC == 'S'
		If Ascan(_aNotas,QR11->D1_NFORI+QR11->D1_SERIORI+QR11->D1_COD+QR11->D1_FORNECE+QR11->D1_LOJA) > 0
			_nTotV -= QR11->D1_TOTAL - QR11->D1_VALICM
			_nTotQ -= QR11->D1_QUANT
		Endif
	Endif
	QR11->(dbSkip())
End

If Select("QR11") > 0
	QR11->(dbCloseArea())
Endif

Return(_nTotQ) 



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCalcMes   บAutor  ณMauricio Mendes     บ Data ณ  30/04/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Calculo do valor mes a mes para gravar na Planilha         บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NCGAMES                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CalcCol()


Private _dData 		:= ctod("  /  /  ")
Private _nQtdv 		:= 0
Private _nValv 		:= 0
Private _aRet 		:= {}
Private _aRetMD		:= {}
Private _aRetgrv 	:= {}

_dDataIni := MV_PAR01
_dDataFim := Lastday(MV_PAR02)
_aRetgrv 	:= {}

_aRet := ULTCalcval(_dDataFim,_aRet)

aAdd(_aRetGrv,{"PR_M_SIC",_aRet[1],_aRet[3]/_aRet[2]})

dbSelectArea("DA1")
dbSetOrder(1)
If dbSeek(xfilial("DA1")+"018"+_aRet[1])
	nprcven := DA1->DA1_PRCVEN
Endif

aAdd(_aRetGrv,{"PER_DESMC",_aRet[1],(nPrcven * 0.847458)/(_aRet[3]/_aRet[2])})

_aRetMD := mdCalcval(_dDataFim,_aRet)
aAdd(_aRetGrv,{"MEDIA",_aRetMD[1],_aRetMD[2]/3})

aAdd(_aRetGrv,{"GIRO",_aRetMD[1],(_aRetMD[2]/3)* DA1->DA1_PRCVEN})

dbSelectArea("SB2")
dbSetOrder(1)
If dbSeek(xfilial("SB2")+_aRet[1])
	nQatu 	:= SB2->B2_QATU
Else
	nQatu 	:= 0
Endif

aAdd(_aRetGrv,{"MES_EST",_aRetMD[1],nQatu/(_aRetMD[2]/3)})        
aAdd(_aRetGrv,{"ESTVEN",_aRet[1], DA1->DA1_PRCVEN * nQatu})


Return(_aRetGrv)



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณULTcALCVAL  บAutor  ณMauricio Mendes     บ Data ณ  01/05/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NCGAMES                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function ULTCalcVal(_dData,_aRet)
Local _a 		:= _aRet
Local _dD 		:= _dData
Local cQuery 	:= ''
Local cNameSD1 	:= RetSqlName("SD1")
Local cNameSD2 	:= RetSqlName("SD2")
Local cNameSF4 	:= RetSqlName("SF4")
Local _nTotQ := 0
Local _nTotV := 0
Local _aNotas := {}

cQuery := "SELECT F4_ESTOQUE,F4_DUPLIC,D2_QUANT,D2_TOTAL-D2_VALICM AS D2_TOTSICM,D2_DOC,D2_SERIE,D2_COD,D2_CLIENTE,D2_LOJA, D2_ICMSRET "
cQuery += " FROM " + cNameSD2 + " SD2, " + cNameSF4 + " SF4 "
cQuery += " where D2_FILIAL  = '" + xFilial("SD2") + "'"
cQuery += " and SUBSTR(D2_EMISSAO,1,6) = '" + SUBSTR(DTOS(_dD),1,6) + "'"
cQuery += " and D2_COD = '" + QR1->B1_COD + "'"
cQuery += " and D2_LOCAL = '" + QR1->B1_LOCPAD + "'"
cQuery += " and D2_TIPO NOT IN ('D', 'B') "
cQuery += " and F4_FILIAL  = '" + xFilial("SF4") + "' "
cQuery += " and F4_CODIGO  = D2_TES "
cQuery += " and SD2.D_E_L_E_T_ <> '*' "
cQuery += " and SF4.D_E_L_E_T_ <> '*' "
cQuery += " ORDER BY " + SQLORDER (SD2->(INDEXKEY()))

If Select("QR11") > 0
	QR11->(dbCloseArea())
Endif

TcQuery cQuery New Alias "QR11"
dbSelectArea("QR11")
dbGotop()

_nTotQ := 0
_nTotV := 0
_aNotas := {}      

while QR11->(!EOF())
	IF QR11->F4_ESTOQUE == 'S' .AND. QR11->F4_DUPLIC == 'S'
		_nTotQ += QR11->D2_QUANT
		_nTotV += QR11->D2_TOTSICM
		aAdd(_aNotas,QR11->D2_DOC+QR11->D2_SERIE+QR11->D2_COD+QR11->D2_CLIENTE+QR11->D2_LOJA)
	Endif
	QR11->(dbSkip())
End

If Select("QR11") > 0
	QR11->(dbCloseArea())
Endif
                                                                                                                             
cQuery := "select F4_ESTOQUE,F4_DUPLIC,D1_NFORI,D1_SERIORI,D1_COD,D1_FORNECE,D1_LOJA,D1_QUANT,D1_TOTAL-D1_VALICM D1_TOTSICM "
cQuery += " from " + cNameSD1 + " SD1, " + cNameSF4 + " SF4 "
cQuery += " where D1_FILIAL  = '" + xFilial("SD1") + "'"
cQuery += " and SUBSTR(D1_EMISSAO,1,6) >= '" + SUBSTR(DTOS(_dD),1,6) + "' "
cQuery += " and D1_COD  = '" + QR1->B1_COD + "' "
cQuery += " and D1_TIPO = 'D'"
cQuery += " and F4_FILIAL  = '" + xFilial("SF4") + "'"
cQuery += " and F4_CODIGO  = D1_TES"
cQuery += " and SD1.D_E_L_E_T_ = ' '"
cQuery += " and SF4.D_E_L_E_T_ = ' '"

If Select("QR11") > 0
	QR11->(dbCloseArea())
Endif

TcQuery cQuery New Alias "QR11"
dbSelectArea("QR11")
dbGotop()

While QR11->(!EOF())
	IF QR11->F4_ESTOQUE == 'S' .AND. QR11->F4_DUPLIC == 'S'
		If Ascan(_aNotas,QR11->D1_NFORI+QR11->D1_SERIORI+QR11->D1_COD+QR11->D1_FORNECE+QR11->D1_LOJA) > 0
			_nTotQ -= QR11->D1_QUANT
			_nTotV -= QR11->D1_TOTSICM
		Endif
	Endif
	QR11->(dbSkip())
End


If Select("QR11") > 0
	QR11->(dbCloseArea())
Endif

_a := {QR1->B1_COD,_nTotQ,_nTotv}

Return(_a)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMDCALCVAL   บAutor  ณMauricio Mendes     บ Data ณ  01/05/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NCGAMES                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function MDCalcVal(_dData,_aRet)
Local _a 		:= _aRet
Local _dD 		:= _dData
Local cQuery 	:= ''
Local cNameSD1 	:= RetSqlName("SD1")
Local cNameSD2 	:= RetSqlName("SD2")
Local cNameSF4 	:= RetSqlName("SF4")
Local _nTotQ := 0
Local _nTotV := 0
Local _aNotas := {}

cQuery := "SELECT F4_ESTOQUE,F4_DUPLIC,D2_QUANT,D2_TOTAL+D2_VALFRE+D2_DESPESA+D2_SEGURO+D2_ICMSRET AS D2_TOTAL,D2_DOC,D2_SERIE,D2_COD,D2_CLIENTE,D2_LOJA, D2_ICMSRET "
cQuery += " FROM " + cNameSD2 + " SD2, " + cNameSF4 + " SF4 "
cQuery += " where D2_FILIAL  = '" + xFilial("SD2") + "'"
cQuery += " and SUBSTR(D2_EMISSAO,1,6) BETWEEN '" + SUBSTR(DTOS(_dD-90),1,6) + "' AND '" + SUBSTR(DTOS(_dD),1,6) + "' "
cQuery += " and D2_COD = '" + QR1->B1_COD + "'"
cQuery += " and D2_LOCAL = '" + QR1->B1_LOCPAD + "'"
cQuery += " and D2_TIPO NOT IN ('D', 'B') "
cQuery += " and F4_FILIAL  = '" + xFilial("SF4") + "' "
cQuery += " and F4_CODIGO  = D2_TES "
cQuery += " and SD2.D_E_L_E_T_ <> '*' "
cQuery += " and SF4.D_E_L_E_T_ <> '*' "
cQuery += " ORDER BY " + SQLORDER (SD2->(INDEXKEY()))

If Select("QR11") > 0
	QR11->(dbCloseArea())
Endif

TcQuery cQuery New Alias "QR11"
dbSelectArea("QR11")
dbGotop()

_nTotQ := 0
_nTotV := 0
_aNotas := {}      

while QR11->(!EOF())
	IF QR11->F4_ESTOQUE == 'S' .AND. QR11->F4_DUPLIC == 'S'
		_nTotQ += QR11->D2_QUANT
		_nTotV += QR11->D2_TOTAL
		aAdd(_aNotas,QR11->D2_DOC+QR11->D2_SERIE+QR11->D2_COD+QR11->D2_CLIENTE+QR11->D2_LOJA)
	Endif
	QR11->(dbSkip())
End

If Select("QR11") > 0
	QR11->(dbCloseArea())
Endif
                                                                                                                             
cQuery := "select F4_ESTOQUE,F4_DUPLIC,D1_NFORI,D1_SERIORI,D1_COD,D1_FORNECE,D1_LOJA,D1_QUANT,D1_TOTAL "
cQuery += " from " + cNameSD1 + " SD1, " + cNameSF4 + " SF4 "
cQuery += " where D1_FILIAL  = '" + xFilial("SD1") + "'"
cQuery += " and SUBSTR(D1_EMISSAO,1,6) >= '" + SUBSTR(DTOS(_dD),1,6) + "' "
cQuery += " and D1_COD  = '" + QR1->B1_COD + "' "
cQuery += " and D1_TIPO = 'D'"
cQuery += " and F4_FILIAL  = '" + xFilial("SF4") + "'"
cQuery += " and F4_CODIGO  = D1_TES"
cQuery += " and SD1.D_E_L_E_T_ = ' '"
cQuery += " and SF4.D_E_L_E_T_ = ' '"

If Select("QR11") > 0
	QR11->(dbCloseArea())
Endif

TcQuery cQuery New Alias "QR11"
dbSelectArea("QR11")
dbGotop()

While QR11->(!EOF())
	IF QR11->F4_ESTOQUE == 'S' .AND. QR11->F4_DUPLIC == 'S'
		If Ascan(_aNotas,QR11->D1_NFORI+QR11->D1_SERIORI+QR11->D1_COD+QR11->D1_FORNECE+QR11->D1_LOJA) > 0
			_nTotQ -= QR11->D1_QUANT
			_nTotV -= QR11->D1_TOTAL
		Endif
	Endif
	QR11->(dbSkip())
End


If Select("QR11") > 0
	QR11->(dbCloseArea())
Endif

_a := {QR1->B1_COD,_nTotQ,_nTotv}

Return(_a)
