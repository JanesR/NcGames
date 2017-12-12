#INCLUDE "PROTHEUS.CH"
#Include "FIVEWIN.Ch"  
#Include "TBICONN.CH"  
#INCLUDE "TOPCONN.CH" 

#DEFINE CRLF Chr(13)+Chr(10)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGRL207  บ Autor ณ Alberto Kibino     บ Data ณ  13/12/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ RELATORIO PARA GERAR DBF 							      บฑฑ
ฑฑบ          ณ CRIAวรO BASE VISรO DOS PEDIDOS EM CARTEIRA                 บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NCGAMES VENDAS KEY ACCOUNT                                 บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

User Function NCGRL207(aFiliais)

Local aAreaSx3 := {} 
Default aFiliais := {"01","03"}

If SELECT("SM0") <= 0 
	RpcSetType( 3 )
	RpcSetEnv( aFiliais[1], aFiliais[2] )
EndIf 
aAreaSx3 := SX3->(GetArea()) 
            
DBMCRIASX1()


If !isblind()
	If !Pergunte("DBM_VISPED",.T.)       
		Return
	endIf
Else
	Pergunte("DBM_VISPED",.F.)
	MV_PAR01 := Firstday(Date())-15		// Data emissใo do Pedido
	MV_PAR02 := LastDay(Date())			//Data emissใo final do Pedido
	MV_PAR03 := Firstday(Date())		// Data inํcio faturamento
	MV_PAR04 := LastDay(Date())			// Data final faturamento
EndIf 

Processa( {|| MyGetVispd() }, "Aguarde...", "Carregando tabelas Visao de pedidos. DBF...",.F.)
   
If Len(aAreaSx3) > 0
	RestArea(aAreaSX3)
EndIf
If !Isblind() 
	MsgAlert("Arquivo gerado com sucesso. " ,"Termino" ) 
Else
	Conout("Arquivo gerado com sucesso. ")
EndIf
 
Return

Static Function MyGetVisPd()
Local aDbStru := {}
Local aTam		:= {} 
Local aCampos := {} 
Local nli		:= 0 
Local clAlias	:= GetNextAlias()
Local cPedItem	:= ""
Local nQtdLib	:= 0
Local cSitBlq	:= "" 
Local cSd2Filial := xFilial("SD2")
Local nVlrFat := 0
Local cAliaFat	:= GetNextAlias() 
Local cAliSd2	:= ""
Local clQry	:= "" 
Local nVendedor	:= Fa440CntVen() 
Local nCampo	:= 0
Local cAliasSD1:= "" //GetNextAlias()
Local cWhereAux 	:= ""
Local cVendedor 	:= "1"
Local cWhere := "" 
Local cAddField	:= "" 
Local aItensPed := {}
Local nitemLib	:= 0
Local nItemPed	:= 0
Local nItemLib	:= 0
Local nItemFat	:= 0 
Local aDbStr2	:= {}
Local aCpoPed	:= {}
Local cprovCanal	:= "" 
Local cFilPed	:= ""
Local cDirCopy	:= MyNewSX6( "NCG_000031", "\\192.168.0.210\Company\มreas Comuns\Adm Planilha BD\Acompanhamento de Pedidos\Base de Dados\", "C", "Diret๓rio base visao de pedidos", "Diret๓rio base visao de pedidos", "Diret๓rio base visao de pedidos", .F. )
Local cDirUser	:= MyNewSX6( "NCG_000032", "C:\relatorios adm", "C", "Diret๓rio base do usuario da visao de pedidos ", "Diret๓rio base visao de pedidos", "Diret๓rio base visao de pedidos", .F. ) 
    	
     
DbSelectArea("SX3")
DbSetORder(2)

AADD(aDBstru,{"ABERTO","C",1,0}) 
AADD(aCampos, {"ABERTO", "ABERTO"}) 
AADD(aDBstr2,{"ABERTO","C",1,0}) 
AADD(aCpoPed, {"ABERTO", "ABERTO"}) 


If SX3->(DbSeek("A1_AGEND"))
	AADD(aDBstru,{"AGEND","N",SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"AGEND", SX3->X3_CAMPO}) 
	AADD(aDBstr2,{"AGEND","N",SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCpoPed, {"AGEND", SX3->X3_CAMPO})
EndIf

If SX3->(DbSeek("C9_BLCRED"))
	AADD(aDBstru,{"BLQCRED",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"BLQCRED", SX3->X3_CAMPO}) 
	AADD(aDBstr2,{"BLQCRED",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCpoPed, {"BLQCRED", SX3->X3_CAMPO})
EndIf

If SX3->(DbSeek("ACA_DESCRI"))
	AADD(aDBstru,{"CANAL_VEND",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"CANAL_VEND", SX3->X3_CAMPO}) 
	AADD(aDBstr2,{"CANAL_VEND",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCpoPed, {"CANAL_VEND", SX3->X3_CAMPO})
EndIf


If SX3->(DbSeek("C5_CLIENTE"))
	AADD(aDBstru,{"CODCLI",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"CODCLI", SX3->X3_CAMPO}) 
EndIf

AADD(aDBstru,{"CAPITAL","C",01, 0}) 
AADD(aCampos, {"CAPITAL", " "}) 
If SX3->(DbSeek("C9_DATALIB"))
	AADD(aDBstru,{"DATALIB","D", 8,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"DATALIB", SX3->X3_CAMPO})
EndIf 

If SX3->(DbSeek("B1_XDESC"))
	AADD(aDBstru,{"DESCNC",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"DESCNC", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("C6_DESCONT"))
	AADD(aDBstru,{"DESCONT",SX3->X3_TIPO,SX3->X3_TAMANHO /* ALTERADO - 22/04/2013 -> */ + 8 /* <- */, SX3->X3_DECIMAL /* ALTERADO - 22/04/2013 -> */ + 4 /* <- */}) 
	AADD(aCampos, {"DESCONT", SX3->X3_CAMPO})
EndIf
AADD(aDBstru,{"DESCONTO","N" ,10,2}) 

If SX3->(DbSeek("C6_DESCRI"))
	AADD(aDBstru,{"DESCPEDIDO",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"DESCPEDIDO", SX3->X3_CAMPO})
EndIf

If SX3->(DbSeek("Z1_DTENTRE"))
	AADD(aDBstru,{"DTENTRE",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"DTENTRE", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("C6_ENTREG"))
	AADD(aDBstru,{"DTENTREG","C",8,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"DTENTREG", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("C9_DTLIBES"))

	AADD(aDBstru,{"DTLIBES", SX3->X3_TIPO ,8,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"DTLIBES", SX3->X3_CAMPO})
EndIf

If SX3->(DbSeek("C9_DTLICRD"))
	AADD(aDBstru,{"DTLICRD",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"DTLICRD", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("Z1_DTSAIDA"))
	AADD(aDBstru,{"DTSAIDA",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"DTSAIDA", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("D2_EMISSAO"))
	AADD(aDBstru,{"EMISSANF",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"EMISSANF", SX3->X3_CAMPO})
EndIf 

If SX3->(DbSeek("C5_EMISSAO"))
	AADD(aDBstru,{"EMISSAOC5",SX3->X3_TIPO ,8,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"EMISSAOC5", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("A3_END"))
	AADD(aDBstru,{"END_VENDED",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL})
	AADD(aCampos, {"END_VENDED", SX3->X3_CAMPO})
EndIf

AADD(aDBstru,{"FATPARCIAL","N",05, 0}) 
AADD(aCampos, {"FATPARCIAL", " "})
AADD(aDBstru,{"FATTOTAL","N",05, 0}) 
AADD(aCampos, {"FATTOTAL", " "})

If SX3->(DbSeek("C6_FILIAL"))	
	AADD(aDBstru,{"FILIAL",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"FILIAL", SX3->X3_CAMPO})
EndIf  

If SX3->(DbSeek("A3_GRPREP"))
	AADD(aDBstru,{"GRUPOREP",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"GRUPOREP", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("A1_INSCR"))
	AADD(aDBstru,{"IECLIENTE",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"IECLIENTE", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("C6_ITEM"))
	AADD(aDBstru,{"ITEM_PEDID",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL})
	AADD(aCampos, {"ITEM_PEDID",SX3->X3_CAMPO})
EndIf

If SX3->(DbSeek("C6_LOCAL"))
	AADD(aDBstru,{"LOCAL",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"LOCAL", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("A1_LOJA"))
	AADD(aDBstru,{"LOJA",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"LOJA", SX3->X3_CAMPO})
EndIf 
If SX3->(DbSeek("A1_X_DESC"))
	AADD(aDBstru,{"MAXDESC",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"MAXDESC", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("A1_MUN"))
	AADD(aDBstru,{"MUNIC_CLIE",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL})
	AADD(aCampos, {"MUNIC_CLIE", SX3->X3_CAMPO})
EndIf

If SX3->(DbSeek("F2_DATAAG"))
	AADD(aDBstru,{"NF_DATAAG",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"NF_DATAAG", SX3->X3_CAMPO})
EndIf 

If SX3->(DbSeek("A1_NREDUZ"))
	AADD(aDBstru,{"NFANTASIA",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"NFANTASIA", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("C9_NFISCAL"))
	AADD(aDBstru,{"NFFAT",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"NFFAT", SX3->X3_CAMPO})
EndIf 
If SX3->(DbSeek("C6_NOTA"))
	AADD(aDBstru,{"NFISCAL",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"NFISCAL", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("A1_NOME"))
	AADD(aDBstru,{"NOME_CLIEN",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL})
	AADD(aCampos, {"NOME_CLIEN", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("A3_NOME"))
	AADD(aDBstru,{"NOME_VENDE",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL})
	AADD(aCampos, {"NOME_VENDE", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("C6_NUM"))
	AADD(aDBstru,{"NUMPED",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"NUMPED", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("C5_DTAGEND"))
	AADD(aDBstru,{"PD_DTAGEND",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"PD_DTAGEND", SX3->X3_CAMPO})
EndIf 
If SX3->(DbSeek("C5_PEDCLI"))
	AADD(aDBstru,{"PEDCLI",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"PEDCLI", SX3->X3_CAMPO})
EndIf  

AADD(aDBstru,{"PEDTOTAL","N",1, 0}) 
AADD(aCampos, {"PEDTOTAL", " "})
AADD(aDBstru,{"PEDPARCIAL","N",1, 0}) 
AADD(aCampos, {"PEDPARCIAL", " "})
If SX3->(DbSeek("F2_PBRUTO"))
	AADD(aDBstru,{"PESOBRUTO",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"PESOBRUTO", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("A1_PESSOA"))
	AADD(aDBstru,{"PESSOA",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"PESSOA", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("C6_PRCTAB"))
	AADD(aDBstru,{"PRCTAB",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"PRCTAB", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("C6_PRCVEN"))
	AADD(aDBstru,{"PRCVENSIPI",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"PRCVENSIPI", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("C6_PRODUTO"))
	AADD(aDBstru,{"PRODUTO",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"PRODUTO", SX3->X3_CAMPO})
EndIf

If SX3->(DbSeek("B1_PUBLISH"))
	AADD(aDBstru,{"PUBLISH",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"PUBLISH", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("C6_QTDENT"))
	AADD(aDBstru,{"QTDENT",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"QTDENT", SX3->X3_CAMPO}) 
EndIf
If SX3->(DbSeek("C9_QTDLIB"))
	AADD(aDBstru,{"QTDLIBC9",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"QTDLIBC9", SX3->X3_CAMPO})
EndIf

If SX3->(DbSeek("C6_QTDVEN"))
	AADD(aDBstru,{"QTDVEND",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"QTDVEND", SX3->X3_CAMPO})
EndIf
AADD(aDBstru,{"QTDFAT","N",13,0}) 
AADD(aCampos, {"QTDFAT", " "}) 

If SX3->(DbSeek("C9_SERIENF"))
	AADD(aDBstru,{"SERIEFAT",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"SERIEFAT", SX3->X3_CAMPO})
EndIf 
If SX3->(DbSeek("C6_SERIE"))
	AADD(aDBstru,{"SERIENF",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"SERIENF", SX3->X3_CAMPO})
EndIf

AADD(aDBstru,{"SITUACAO","C",13,0}) 
AADD(aCampos, {"SITUACAO", " "})


If SX3->(DbSeek("A3_SUPER"))
	AADD(aDBstru,{"SUPERVISOR",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"SUPERVISOR", SX3->X3_CAMPO})
EndIf

If SX3->(DbSeek("C5_TABELA"))
	AADD(aDBstru,{"TABELAPRC",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"TABELAPRC", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("C6_TES"))
	AADD(aDBstru,{"TES",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"TES", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("C5_TIPO"))
	AADD(aDBstru,{"TIPOPED",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"TIPOPED", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("C6_VALOR"))
	AADD(aDBstru,{"TOTALITEM",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"TOTALITEM", SX3->X3_CAMPO})
EndIf
AADD(aDBstru,{"TOTITEMFAT","N",10, 0}) 
AADD(aCampos, {"TOTITEMFAT", " "})

AADD(aDBstru,{"TOTITEMLIB","N",10, 0}) 
AADD(aCampos, {"TOTITEMLIB", " "})
 
AADD(aDBstru,{"TOTITEMPED","N",10, 0}) 
AADD(aCampos, {"TOTITEMPED", " "})
If SX3->(DbSeek("C6_TPOPER"))
	AADD(aDBstru,{"TPOPER",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"TPOPER", SX3->X3_CAMPO})
EndIf 
If SX3->(DbSeek("C5_TRANSP"))
	AADD(aDBstru,{"TRANSPORT",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"TRANSPORT", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("A1_EST"))
	AADD(aDBstru,{"UF_CLIENTE",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL})
	AADD(aCampos, {"UF_CLIENTE", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("C9_ULIBCRD"))
	AADD(aDBstru,{"ULIBCRD",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"ULIBCRD", SX3->X3_CAMPO})
EndIf   
If SX3->(DbSeek("C6_X_USRLB"))
	AADD(aDBstru,{"USRLIB",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, { "USRLIB", SX3->X3_CAMPO})
EndIf

AADD(aDBstru,{"VLRPEDIDO","N",13,5}) 
AADD(aCampos, {"VLRPEDIDO", " "})



If SX3->(DbSeek("ACA_DESCRI"))
	AADD(aDbStru,{"CANALVEND",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"CANALVEND", SX3->X3_CAMPO})
	AADD(aDBstr2,{"CANALVEND",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCpoPed, {"CANALVEND", SX3->X3_CAMPO})
EndIf
AADD(aDbStr2,{"CAPITAL","C",01, 0}) 
AADD(aCpoPed, {"CAPITAL", " "}) 
If SX3->(DbSeek("C9_DATALIB"))
	AADD(aDbStr2,{"DATALIB","D", 8,SX3->X3_DECIMAL}) 
	AADD(aCpoPed, {"DATALIB", SX3->X3_CAMPO})
EndIf

If SX3->(DbSeek("C5_CLIENTE"))
	AADD(aDBstr2,{"CODCLI",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCpoPed, {"CODCLI", SX3->X3_CAMPO}) 
EndIf
 
If SX3->(DbSeek("B1_XDESC"))
	AADD(aDbStr2,{"DESCNC",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCpoPed, {"DESCNC", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("C6_DESCONT"))                                      

	AADD(aDbStr2,{"DESCONT",SX3->X3_TIPO,SX3->X3_TAMANHO /* ALTERADO - 22/04/2013 -> */ + 8 /* <- */,SX3->X3_DECIMAL /* ALTERADO - 22/04/2013 -> */ + 4 /* <- */ }) 	
	AADD(aCpoPed, {"DESCONT", SX3->X3_CAMPO})
EndIf
AADD(aDbStr2,{"DESCONTO","N" ,10,2}) 

If SX3->(DbSeek("C6_DESCRI"))
	AADD(aDbStr2,{"DESCPEDIDO",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCpoPed, {"DESCPEDIDO", SX3->X3_CAMPO})
EndIf

If SX3->(DbSeek("Z1_DTENTRE"))
	AADD(aDbStr2,{"DTENTRE",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCpoPed, {"DTENTRE", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("C6_ENTREG"))
	AADD(aDbStr2,{"DTENTREG","C",8,SX3->X3_DECIMAL}) 
	AADD(aCpoPed, {"DTENTREG", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("C9_DTLIBES"))

	AADD(aDbStr2,{"DTLIBES", SX3->X3_TIPO ,8,SX3->X3_DECIMAL}) 
	AADD(aCpoPed, {"DTLIBES", SX3->X3_CAMPO})
EndIf

If SX3->(DbSeek("C9_DTLICRD"))
	AADD(aDbStr2,{"DTLICRD",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCpoPed, {"DTLICRD", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("Z1_DTSAIDA"))
	AADD(aDbStr2,{"DTSAIDA",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCpoPed, {"DTSAIDA", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("D2_EMISSAO"))
	AADD(aDbStr2,{"EMISSANF",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCpoPed, {"EMISSANF", SX3->X3_CAMPO})
EndIf 

If SX3->(DbSeek("C5_EMISSAO"))
	AADD(aDbStr2,{"EMISSAOC5",SX3->X3_TIPO ,8,SX3->X3_DECIMAL}) 
	AADD(aCpoPed, {"EMISSAOC5", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("A3_END"))
	AADD(aDbStr2,{"END_VENDED",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL})
	AADD(aCpoPed, {"END_VENDED", SX3->X3_CAMPO})
EndIf

AADD(aDbStr2,{"FATPARCIAL","N",05, 0}) 
AADD(aCpoPed, {"FATPARCIAL", " "})
AADD(aDbStr2,{"FATTOTAL","N",05, 0}) 
AADD(aCpoPed, {"FATTOTAL", " "})

If SX3->(DbSeek("C6_FILIAL"))	
	AADD(aDbStr2,{"FILIAL",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCpoPed, {"FILIAL", SX3->X3_CAMPO})
EndIf  

If SX3->(DbSeek("A3_GRPREP"))
	AADD(aDbStr2,{"GRUPOREP",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCpoPed, {"GRUPOREP", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("A1_INSCR"))
	AADD(aDbStr2,{"IECLIENTE",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCpoPed, {"IECLIENTE", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("C6_ITEM"))
	AADD(aDbStr2,{"ITEM_PEDID",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL})
	AADD(aCpoPed, {"ITEM_PEDID",SX3->X3_CAMPO})
EndIf

If SX3->(DbSeek("C6_LOCAL"))
	AADD(aDbStr2,{"LOCAL",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCpoPed, {"LOCAL", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("A1_LOJA"))
	AADD(aDbStr2,{"LOJA",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCpoPed, {"LOJA", SX3->X3_CAMPO})
EndIf 
If SX3->(DbSeek("A1_X_DESC"))
	AADD(aDbStr2,{"MAXDESC",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCpoPed, {"MAXDESC", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("A1_MUN"))
	AADD(aDbStr2,{"MUNIC_CLIE",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL})
	AADD(aCpoPed, {"MUNIC_CLIE", SX3->X3_CAMPO})
EndIf

If SX3->(DbSeek("F2_DATAAG"))
	AADD(aDbStr2,{"NF_DATAAG",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCpoPed, {"NF_DATAAG", SX3->X3_CAMPO})
EndIf 

If SX3->(DbSeek("A1_NREDUZ"))
	AADD(aDbStr2,{"NFANTASIA",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCpoPed, {"NFANTASIA", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("C9_NFISCAL"))
	AADD(aDbStr2,{"NFFAT",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCpoPed, {"NFFAT", SX3->X3_CAMPO})
EndIf 
If SX3->(DbSeek("C6_NOTA"))
	AADD(aDbStr2,{"NFISCAL",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCpoPed, {"NFISCAL", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("A1_NOME"))
	AADD(aDbStr2,{"NOME_CLIEN",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL})
	AADD(aCpoPed, {"NOME_CLIEN", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("A3_NOME"))
	AADD(aDbStr2,{"NOME_VENDE",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL})
	AADD(aCpoPed, {"NOME_VENDE", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("C6_NUM"))
	AADD(aDbStr2,{"NUMPED",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCpoPed, {"NUMPED", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("C5_DTAGEND"))
	AADD(aDbStr2,{"PD_DTAGEND",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCpoPed, {"PD_DTAGEND", SX3->X3_CAMPO})
EndIf 
If SX3->(DbSeek("C5_PEDCLI"))
	AADD(aDbStr2,{"PEDCLI",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCpoPed, {"PEDCLI", SX3->X3_CAMPO})
EndIf  

AADD(aDbStr2,{"PEDTOTAL","N",1, 0}) 
AADD(aCpoPed, {"PEDTOTAL", " "})
AADD(aDbStr2,{"PEDPARCIAL","N",1, 0}) 
AADD(aCpoPed, {"PEDPARCIAL", " "})
If SX3->(DbSeek("F2_PBRUTO"))
	AADD(aDbStr2,{"PESOBRUTO",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCpoPed, {"PESOBRUTO", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("A1_PESSOA"))
	AADD(aDbStr2,{"PESSOA",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCpoPed, {"PESSOA", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("C6_PRCTAB"))
	AADD(aDbStr2,{"PRCTAB",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCpoPed, {"PRCTAB", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("C6_PRCVEN"))
	AADD(aDbStr2,{"PRCVENSIPI",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCpoPed, {"PRCVENSIPI", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("C6_PRODUTO"))
	AADD(aDbStr2,{"PRODUTO",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCpoPed, {"PRODUTO", SX3->X3_CAMPO})
EndIf

If SX3->(DbSeek("B1_PUBLISH"))
	AADD(aDbStr2,{"PUBLISH",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCpoPed, {"PUBLISH", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("C6_QTDENT"))
	AADD(aDbStr2,{"QTDENT",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCpoPed, {"QTDENT", SX3->X3_CAMPO}) 
EndIf
If SX3->(DbSeek("C9_QTDLIB"))
	AADD(aDbStr2,{"QTDLIBC9",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCpoPed, {"QTDLIBC9", SX3->X3_CAMPO})
EndIf

If SX3->(DbSeek("C6_QTDVEN"))
	AADD(aDbStr2,{"QTDVEND",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCpoPed, {"QTDVEND", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("D2_QUANT"))
	AADD(aDbStr2,{"QTDFAT",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCpoPed, {"QTDFAT", " "}) 
EndIf

If SX3->(DbSeek("C9_SERIENF"))
	AADD(aDbStr2,{"SERIEFAT",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCpoPed, {"SERIEFAT", SX3->X3_CAMPO})
EndIf 
If SX3->(DbSeek("C6_SERIE"))
	AADD(aDbStr2,{"SERIENF",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCpoPed, {"SERIENF", SX3->X3_CAMPO})
EndIf

AADD(aDbStr2,{"SITUACAO","C",13,0}) 
AADD(aCpoPed, {"SITUACAO", " "})


If SX3->(DbSeek("A3_SUPER"))
	AADD(aDbStr2,{"SUPERVISOR",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCpoPed, {"SUPERVISOR", SX3->X3_CAMPO})
EndIf

If SX3->(DbSeek("C5_TABELA"))
	AADD(aDbStr2,{"TABELAPRC",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCpoPed, {"TABELAPRC", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("C6_TES"))
	AADD(aDbStr2,{"TES",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCpoPed, {"TES", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("C5_TIPO"))
	AADD(aDbStr2,{"TIPOPED",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCpoPed, {"TIPOPED", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("C6_VALOR"))
	AADD(aDbStr2,{"TOTALITEM",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCpoPed, {"TOTALITEM", SX3->X3_CAMPO})
EndIf
AADD(aDbStr2,{"TOTITEMFAT","N",10, 0}) 
AADD(aCpoPed, {"TOTITEMFAT", " "})

AADD(aDbStr2,{"TOTITEMLIB","N",10, 0}) 
AADD(aCpoPed, {"TOTITEMLIB", " "})
 
AADD(aDbStr2,{"TOTITEMPED","N",10, 0}) 
AADD(aCpoPed, {"TOTITEMPED", " "})
If SX3->(DbSeek("C6_TPOPER"))
	AADD(aDbStr2,{"TPOPER",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCpoPed, {"TPOPER", SX3->X3_CAMPO})
EndIf 
If SX3->(DbSeek("C5_TRANSP"))
	AADD(aDbStr2,{"TRANSPORT",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCpoPed, {"TRANSPORT", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("A1_EST"))
	AADD(aDbStr2,{"UF_CLIENTE",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL})
	AADD(aCpoPed, {"UF_CLIENTE", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("C9_ULIBCRD"))
	AADD(aDbStr2,{"ULIBCRD",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCpoPed, {"ULIBCRD", SX3->X3_CAMPO})
EndIf   
If SX3->(DbSeek("C6_X_USRLB"))
	AADD(aDbStr2,{"USRLIB",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCpoPed, { "USRLIB", SX3->X3_CAMPO})
EndIf

AADD(aDbStr2,{"VLRPEDIDO","N",13,5}) 
AADD(aCpoPed, {"VLRPEDIDO", " "})

                                                                

If Select("DGPED") > 0                                                 
	DGPED->(dbCloseArea())
EndIf

clTime := Time()
While ":" $ clTime
	clTime := Stuff(clTime,At(":",clTime),1,"")
End

CNOMEDBF := "NCVISPED"

If File("SYSTEM\" + CNOMEDBF + ".dbf")
	fErase("SYSTEM\" + CNOMEDBF +GetDBExtension())
EndIf
If Len(aCampos) > 0
	DBCREATE(CNOMEDBF,aDbStru,"DBFCDXADS")
Else
	Aviso("Nao foi possํvel criar a tabela temporแria.")  
	Return
EndIf

If !IsBlind()
	MakeDir(cDirUser)
EndIf

DbUseArea(.T.,"DBFCDXADS", "SYSTEM\" + CNOMEDBF,"DGPED",.T.,.F.)

If File("DGPED.cdx")
	fErase("DGPED.cdx")
endIf 


CNOM2DBF := "NCVISPE2"
If Select("DGPE2") > 0                                                 
	DGPE2->(dbCloseArea())
EndIf

If File("SYSTEM\" + CNOM2DBF + ".dbf")
	fErase("SYSTEM\" + CNOM2DBF +GetDBExtension())
EndIf
If Len(aCampos) > 0
	DBCREATE(CNOM2DBF,aDbStr2,"DBFCDXADS")
Else
	Aviso("Nao foi possํvel criar a tabela temporแria.")  
	Return
EndIf

//MakeDir(cDirUser) 


DbUseArea(.T.,"DBFCDXADS", "SYSTEM\" + CNOM2DBF,"DGPE2",.T.,.F.)

If File("DGPE2.cdx")
	fErase("DGPE2.cdx")
endIf 

IndRegua("DGPE2",CNOM2DBF,"FILIAL+NUMPED",,,"Selecionando Registros...") 	

DbClearIndex() 

DbSetIndex("NCVISPE2" + OrdBagExt())

If Select(clAlias) > 0
	dbSelectArea(clAlias)
	(clAlias)->(dbCloseArea())
Endif
   

_cQry:= " SELECT" 
_cQry+=  " A1_COD, A1_LOJA,A1_INSCR,A1_AGEND,"
_cQry+= " A1_NOME, A1_PESSOA, A1_NREDUZ, A1_EST, A1_MUN,A1_COD_MUN, A1_X_DESC , A1_VEND,"
_cQry+= " A3_COD, A3_NOME, A3_NREDUZ, A3_END, A3_GRPREP, A3_SUPER,"
_cQry+= " ACA_GRPREP, ACA_DESCRI,"
_cQry+= " A3_COD, A3_NOME, A3_NREDUZ, A3_END, A3_SUPER, A3_GRPREP,"
_cQry+= " C6_FILIAL,C6_ITEM, C6_DESCRI, B1_XDESC, B1_PUBLISH, B1_DESCCAT, C6_PRODUTO, C6_QTDVEN, C6_PRCTAB, C6_PRCVEN, C6_VALOR, C6_DESCONT, "
_cQry+= " C6_NOTA, C6_SERIE,C6_CLI, C6_LOJA, C6_NUM, C6_COMIS1,C6_TES,C6_ENTREG,C6_X_USRLB,"
_cQry+= " C6_BLQ, C6_BLOQUEI, C6_LOCAL,C6_QTDENT,C6_TPOPER,"
_cQry+= " C5_NUM, C5_TIPO, C5_CLIENTE, C5_LOJACLI, C5_CONDPAG,C5_TABELA, C5_VEND1,"
_cQry+= " C5_LIBEROK,C5_NOTA,C5_BLQ,"
_cQry+= " C5_TRANSP, C5_EMISSAO, C5_VEND1, C5_PEDCLI,C5_CODBL,C5_DTAGEND,"
_cQry+= " C9_PEDIDO, C9_ITEM,C9_PRODUTO, C9_CLIENTE, C9_LOJA,C9_PRODUTO, C9_DATALIB, C9_QTDLIB, C9_BLOQUEI," 
_cQry+= " C9_BLCRED, C9_BLEST,C9_DTLIBES, C9_ULIBCRD, C9_NFISCAL, C9_SERIENF, C9_SEQUEN, C9_DTLICRD"
_cQry+= " FROM " + RetSqlname("SC6") + " SC6"
_cQry+= " 
_cQry+= " JOIN " + RetSqlName("SC5") + " SC5"
_cQry+= " ON C5_FILIAL = C6_FILIAL"
_cQry+= " AND C5_NUM = C6_NUM"
_cQry+= " AND SC5.D_E_L_E_T_ = ''"
_cQry+= " 
_cQry+= " LEFT JOIN " + RetSqlName("SC9") + " SC9"
_cQry+= " ON C9_FILIAL = C6_FILIAL"
_cQry+= " AND C9_PEDIDO = C6_NUM"
_cQry+= " AND C9_ITEM = C6_ITEM"
_cQry+= " AND SC9.D_E_L_E_T_ =  ''" 
_cQry+= " 
_cQry+= " JOIN " + RetSqlName("SA1") + " SA1"
_cQry+= " ON A1_FILIAL = ' '"
_cQry+= " AND A1_COD = C6_CLI"
_cQry+= " AND A1_LOJA = C6_LOJA"
_cQry+= " AND SA1.D_E_L_E_T_ = ' '"

_cQry+= " JOIN " + RetSqlName("SA3") + " SA3"
_cQry+= " ON A3_FILIAL = '" + xFilial("SA3") + "'"
_cQry+= " AND A3_COD = C5_VEND1"
_cQry+= " AND SA3.D_E_L_E_T_ = ''" 

_cQry+= " JOIN " + RetSqlName("ACA") + " ACA"
_cQry+= " ON ACA_FILIAL = '" + xFilial("ACA") + "'"
_cQry+= " AND ACA_GRPREP = A3_GRPREP"
_cQry+= " AND ACA.D_E_L_E_T_ = ''"

_cQry+= " JOIN " + RetSqlName("SB1") + " SB1"
_cQry+= " ON B1_FILIAL = '" + xFilial("SB1") + "'"
_cQry+= " AND B1_COD = C6_PRODUTO"
_cQry+= " AND SB1.D_E_L_E_T_ = ''" 

_cQry+= " WHERE C6_FILIAL = '" + xFilial("SC6") + "' "
 
_cQry+= " AND C5_EMISSAO BETWEEN '" + DtoS(MV_PAR01) + "' AND '" + DtoS(MV_PAR02) + "'"
_cQry+= " AND SC6.D_E_L_E_T_ = ' '"
_cQry+= " ORDER BY C6_FILIAL, C6_NUM, C6_ITEM"  


_cQry := ChangeQuery(_cQry)
dbUseArea(.T.,"TOPCONN",TCGENQRY(,,_cQry),clAlias, .T., .T.)
cSd1Fil := Xfilial("SD1") 

//TcSetField(clAlias,"C5_EMISSAO" 	,"D",0008						,0000						)
 
//DbSelectArea("SZ1")         
//DbSetOrder(1)  // DocSerieClienteLoja


DBSELECTAREA(clAlias)
DBGOTOP()
ProcRegua(RecCount())
//cPedItem := (clAlias)->C6_NUM + (clAlias)->C6_ITEM
nQtdPed := 0

DBSELECTAREA("SD2")
SD2->(DBSETORDER(8)) //D2_FILIAL+D2_PEDIDO+D2_ITEMPV  

DbSelectArea("SZ1")
DbSetOrder(1) //Z1_FILIAL+Z1_DOC+Z1_SERIE+Z1_CLIENTE+Z1_LOJA    
DbSelectArea("SF2")
DbSetOrder(2) //F2_FILIAL+F2_CLIENTE+F2_LOJA+F2_DOC+F2_SERIE    


DbSelectArea("DGPED")
DbSelectArea("DGPE2")
DbSetOrder(1)


While !(clAlias)->(EOF())
    IncProc() 
    nQtdLib := 0 
    nVlrFat	:= 0
    //D2_FILIAL+D2_PEDIDO+D2_ITEMPV         
    /*
    
    If !empty((clAlias)->C9_NFISCAL)
	    If SD2->(DbSeek(cSd2Filial + (clAlias)->C6_NUM + (clAlias)->C6_ITEM))
	    	nVlrFat := Round(SD2->D2_TOTAL+SD2->D2_VALIPI + SD2->D2_VALFRE + SD2->D2_SEGURO + SD2->D2_ICMSRET + SD2->D2_DESPESA,5)
	    Else
	    	nVlrFat := 0
	    	//Alert("sem nota"+ (clAlias)->C6_NUM + (clAlias)->C6_ITEM)
	    EndIf
	EndIf 
	*/
	//aItensPed := MyItensPed((clAlias)->C6_NUM )
	//SZ1->(dbSeek(xFilial("SD2")+(cAliSD2)->D2_DOC+(cAliSD2)->D2_SERIE+(cAliSD2)->D2_CLIENTE+(cAliSD2)->D2_LOJA))
	
	cProvCanal	:= "" 
     
	If AllTrim((clAlias)->ACA_GRPREP) == "000003" .Or. AllTrim((clAlias)->ACA_GRPREP) == "000004" .Or. AllTrim((clAlias)->ACA_GRPREP) == "000005"   
		If AllTrim((clAlias)->A1_EST) $  "SP*SC*RS*PR"
			cProvCanal := "REGIONAL SUL"
		Else
			cprovCanal := "REGIONAL NORTE"
		EndIf                                         l
		 
	EndIf
	
	If cFilPed	<> (clAlias)->C6_NUM 
		nItemLib	:= MyItensC9((clAlias)->C6_NUM) 
		nItemPed	:= MyItensPed((clAlias)->C6_NUM )
		nItemFat	:= MyItensD2((clAlias)->C6_NUM )
		cFilPed		:= (clAlias)->C6_NUM 
	EndIf
	
	    
	If DGPED->(RecLock("DGPED",.T.))
		//If !Empty((clAlias)->C9_DATALIB)
		DGPED->(CAPITAL)  := IIF(Mycapitais((clAlias)->A1_COD_MUN, (clAlias)->A1_EST), "S","N") 
		DGPED->(AGEND) 		:= IIF((clAlias)->A1_AGEND == "1", 1,0) 
		
		If Empty((clAlias)->C5_LIBEROK) .And. Empty((clAlias)->C5_NOTA) .And. Empty((clAlias)->C5_BLQ)
			DGPED->(ABERTO)	:= "S"
		Else
			DGPED->(ABERTO)	:= "N"
		EndIf
			
		/*
		DGPED->(PD_DTAGEND) := StoD((clAlias)->C5_DTAGEND)
		
	    
		nItemLib	:= MyItensC9((clAlias)->C6_NUM) 
		nItemPed	:= MyItensPed((clAlias)->C6_NUM )
		//nItemLib	:= MyItensC9((clAlias)->C6_NUM )
		nItemFat	:= MyItensD2((clAlias)->C6_NUM ) 
		
		DGPED->(TOTITEMLIB) := nItemLib
		DGPED->(TOTITEMPED) := nItemPed
		DGPED->(TOTITEMFAT) := nItemFat 
		*/
		
		If Empty(cprovCanal)
    		DGPED->(CANALVEND) := (clAlias)->ACA_DESCRI 
    	Else	
    		DGPED->(CANALVEND)	:= cProvCanal
    	EndIf
		
	
		
		If AllTrim((clAlias)->C6_BLQ) == "R" .AND. (clAlias)->C6_QTDENT == 0
			DGPED->(SITUACAO) := "RESIDUO"
		Else	
			DGPED->(FILIAL) := (clAlias)->C6_FILIAL 
			
			If !empty((clAlias)->C9_NFISCAL)
				DGPED->(SITUACAO) := "FATPED" 
				nQtdLib	:= (clAlias)->C9_QTDLIB
				
			Else
				If Empty((clAlias)->C9_DATALIB)
					DGPED->(SITUACAO) := "NAO LIBERADO"
					nQtdLib	:= (clAlias)->C6_QTDVEN
				Else	
					If Empty((clAlias)->C9_BLCRED) 
						DGPED->(SITUACAO) := "OPERACAO"	
						nQtdLib	:= (clAlias)->C9_QTDLIB
						If AllTrim((clAlias)->C9_BLEST) == '02'
							cSitBlq := "RESIDUO"
							nQtdLib	:= (clAlias)->C9_QTDLIB	
						EndIf	
					Else
						cSitBlq := ""
						nQtdLib	:= (clAlias)->C9_QTDLIB
						
						If AllTrim((clAlias)->C9_BLCRED) == "09"
							cSitBlq := "REJEITADO"
							nQtdLib	:= (clAlias)->C9_QTDLIB
						ElseIf AllTrim((clAlias)->C9_BLCRED) <> "10"				
							cSitBlq := "EM ANALISE"
							nQtdLib	:= (clAlias)->C9_QTDLIB	
						Else
							cSitBlq := "     "
						EndIf
						DGPED->(SITUACAO) := cSitBlq
					EndIf
				EndIf			  
			EndIf                                                     
		EndIf
		
		//DGPED->(QTDFAT)	:= 	nQtdLib
		If !empty((clAlias)->C9_NFISCAL)
			DGPED->(VLRPEDIDO)	:= nVlrFat
		Else
			DGPED->(VLRPEDIDO)	:= Round(nQtdLib * (clAlias)->C6_PRCVEN,5)
		EndIf
		DGPED->(C9SEQUEN)	:= (clAlias)->C9_SEQUEN
		DGPED->(TPOPER)		:= (clAlias)->C6_TPOPER
		DGPED->(C5CODBL)	:= (clAlias)->C5_CODBL
		DGPED->(NFFAT)		:= (clAlias)->C9_NFISCAL
		DGPED->(SERIEFAT)	:= (clAlias)->C9_SERIENF
		DGPED->(CODCLI)		:= (clAlias)->A1_COD
		DGPED->(LOJA)		:= (clAlias)->A1_LOJA
		DGPED->(IECLIENTE)	:= (clAlias)->A1_INSCR
		DGPED->(NOME_CLIEN)	:= (clAlias)->A1_NOME
		DGPED->(PESSOA)		:= (clAlias)->A1_PESSOA
		DGPED->(NOME_VENDE)	:= (clAlias)->A3_NOME
		DGPED->(NFANTASIA)		:= (clAlias)->A1_NREDUZ
		DGPED->(END_VENDED)		:= (clAlias)->A3_END
		DGPED->(UF_CLIENTE)		:= (clAlias)->A1_EST  
		DGPED->(MAXDESC)	:= (clAlias)->A1_X_DESC
		DGPED->(COD_VENDED)	:= (clAlias)->C5_VEND1  
		DGPED->(MUNIC_CLIE)	:= (clAlias)->A1_MUN
		DGPED->(GRUPOREP)	:= (clAlias)->A3_GRPREP
		DGPED->(SUPERVISOR)	:= (clAlias)->A3_SUPER
		DGPED->(CANAL_VEND)	:= (clAlias)->ACA_DESCRI
		DGPED->(ITEM_PEDID)	:= (clAlias)->C6_ITEM
		DGPED->(DESCPEDIDO)	:= (clAlias)->C6_DESCRI 
		DGPED->(DESCNC)		:= (clAlias)->B1_XDESC
  		DGPED->(PUBLISH)	:= (clAlias)->B1_PUBLISH 
  		DGPED->(CATEGORIA)	:= (clAlias)->B1_DESCCAT
  		DGPED->(PRODUTO)		:= (clAlias)->C6_PRODUTO  
  		DGPED->(QTDVEND) 	:= (clAlias)->C6_QTDVEN
  		DGPED->(C6_QTDENT)	:= (clAlias)->C6_QTDENT
  		 
  		DGPED->(PRCTAB)		:= (clAlias)->C6_PRCTAB 
  		DGPED->(PRCVENSIPI) 		:= (clAlias)->C6_PRCVEN 
  		If (clAlias)->C6_PRCTAB == 0
  			DGPED->(DESCONTO)		:= 0
  		Else 
  			DGPED->(DESCONTO)		:= (((clAlias)->C6_PRCVEN /(clAlias)->C6_PRCTAB) - 1)*100 
  		EndIf
  			
  		DGPED->(TOTALITEM)	:= (clAlias)->C6_VALOR 
  		DGPED->(DESCONT)		:= (clAlias)->C6_DESCONT 
  		DGPED->(NFISCAL)		:= (clAlias)->C9_NFISCAL
  		DGPED->(SERIENF)		:= (clAlias)->C6_SERIE 
  		DGPED->(NUMPED)		:= (clAlias)->C6_NUM 
  		DGPED->(COMISSAO)	:= (clAlias)->C6_COMIS1
  		DGPED->(TES)		:= (clAlias)->C6_TES
  		DGPED->(DTENTREG)	:= (clAlias)->C6_ENTREG
  		DGPED->(USRLIB)		:= (clAlias)->C6_X_USRLB
  		DGPED->(BLOQ)		:= (clAlias)->C6_BLQ
  		DGPED->(ARMAZEM)		:= (clAlias)->C6_LOCAL
  		DGPED->(TIPOPED)		:= (clAlias)->C5_TIPO
  		DGPED->(CONDPAG)		:= (clAlias)->C5_CONDPAG            
        DGPED->(TABELAPRC)		:= (clAlias)->C5_TABELA
        DGPED->(TRANSPORT)		:= (clAlias)->C5_TRANSP
        DGPED->(EMISSAOC5)		:= StoD((clAlias)->C5_EMISSAO) 
        DGPED->(PEDCLI)			:= (clAlias)->C5_PEDCLI
        If !Empty((clAlias)->C9_DATALIB)
        	DGPED->(DATALIB)		:= StoD((clAlias)->C9_DATALIB)
        EndIf 
        DGPED->(QTDLIBC9)	:= (clAlias)->C9_QTDLIB
        DGPED->(BLOQUEIOC9)	:= (clAlias)->C9_BLOQUEI  
        DGPED->(BLQCRED)	:= (clAlias)->C9_BLCRED 
    	DGPED->(BLEST) 		:= (clAlias)->C9_BLEST 
    	DGPED->(DTLIBES) 	:=	StoD((clAlias)->C9_DTLIBES)
    	DGPED->(ULIBCRD)		:= (clAlias)->C9_ULIBCRD
    	If (clAlias)->C9_BLCRED == "10" .And. Empty((clAlias)->C9_DTLICRD)
    		DGPED->(DTLICRD) := DGPED->(DATALIB)
    	Else
    		DGPED->(DTLICRD)    := StoD((clAlias)->C9_DTLICRD)
    	EndIf
    	DGPED->(TOTITEMLIB) := nItemLib
		DGPED->(TOTITEMPED) := nItemPed
		DGPED->(TOTITEMFAT) := nItemFat 
		If nItemLib <> nItemPed 
			DGPED->(PEDTOTAL) := 0
			If nItemLib > 0
				DGPED->(PEDPARCIAL) := 1
			Else
				DGPED->(PEDPARCIAL) := 0
			EndIf
		Else
			DGPED->(PEDTOTAL) := 1
			DGPED->(PEDPARCIAL) := 0
		EndIf
		If nItemFat <> nItemPed 
			DGPED->(FATTOTAL) := 0
			If nItemFat > 0 
				DGPED->(FATPARCIAL) := 1
			EndIf
		Else
			DGPED->(FATTOTAL) := 1
			DGPED->(FATPARCIAL) := 0
		EndIf 
    	
    	If SD2->(dbseek(xFilial("SD2") + (clAlias)->C6_NUM + (clAlias)->C6_ITEM))
    		DGPED->(QTDFAT) := SD2->D2_QUANT 
    		DGPED->(EMISSANF)	:= SD2->D2_EMISSAO 
	    	If SZ1->(dbSeek(xFilial("SZ1")+SD2->D2_DOC+SD2->D2_SERIE+SD2->D2_CLIENTE+SD2->D2_LOJA))  
		    	DGPED->(DTENTRE)	:= SZ1->Z1_DTENTRE
		    	DGPED->(DTSAIDA)	:= SZ1->Z1_DTSAIDA 
		    	
		    EndIf
		    If SF2->(dbseek(xFilial("SF2")+SD2->D2_CLIENTE+SD2->D2_LOJA+SD2->D2_DOC+SD2->D2_SERIE))
		    	DGPED->(NF_DATAAG)	:= SF2->F2_DATAAG 
		    	DGPED->(PESOBRUTO)	:= SF2->F2_PBRUTO
		    EndIf
		EndIf
    	                     
		DGPED->(MsUnLock())
		
		If !DGPE2->(DbSeek((clAlias)->C6_FILIAL + (clAlias)->C6_NUM))
			If DGPE2->(RecLock("DGPE2",.T.))
				DGPE2->(ABERTO)		:= DGPED->(ABERTO) 
		   		DGPE2->(FILIAL)		:= (clAlias)->C6_FILIAL 
				DGPE2->(NUMPED)		:= (clAlias)->C6_NUM 
				DGPE2->(AGEND) 		:= IIF((clAlias)->A1_AGEND == "1", 1,0)
				DGPE2->(SITUACAO)	:= DGPED->(SITUACAO) 
				DGPE2->(GRUPOREP)	:= (clAlias)->A3_GRPREP
				DGPE2->(CANAL_VEND)	:= (clAlias)->ACA_DESCRI
				DGPE2->(CANALVEND)	:= DGPED->(CANALVEND)
				DGPE2->(CAPITAL)  := IIF(Mycapitais((clAlias)->A1_COD_MUN, (clAlias)->A1_EST), "S","N")
				DGPE2->(PD_DTAGEND) := StoD((clAlias)->C5_DTAGEND)
				DGPE2->(EMISSAOC5)	:= StoD((clAlias)->C5_EMISSAO)
				If !Empty((clAlias)->C9_DATALIB)  
					DGPE2->(DATALIB)	:= StoD((clAlias)->C9_DATALIB)
				EndIf
				If (clAlias)->C9_BLCRED == "10" .And. Empty((clAlias)->C9_DTLICRD)
		    		DGPE2->(DTLICRD) := DGPE2->(DATALIB)
		    	Else
		    		DGPE2->(DTLICRD)    := StoD((clAlias)->C9_DTLICRD)
	    		EndIf 
				DGPE2->(QTDFAT)		:= DGPED->(QTDFAT)
				DGPE2->(DTENTRE)	:= DGPED->(DTENTRE)
			 	DGPE2->(DTSAIDA)	:= DGPED->(DTSAIDA)
			    DGPE2->(EMISSANF)	:= DGPED->(EMISSANF)
			    DGPE2->(GRUPOREP)	:= (clAlias)->A3_GRPREP
				DGPE2->(CANAL_VEND)	:= (clAlias)->ACA_DESCRI 
				 
				//***************************************
				DGPE2->(TPOPER)		:= (clAlias)->C6_TPOPER
				DGPE2->(C5CODBL)	:= (clAlias)->C5_CODBL
				DGPE2->(NFFAT)		:= (clAlias)->C9_NFISCAL
				DGPE2->(SERIEFAT)	:= (clAlias)->C9_SERIENF
				DGPE2->(CODCLI)		:= (clAlias)->A1_COD
				DGPE2->(LOJA)		:= (clAlias)->A1_LOJA
				DGPE2->(IECLIENTE)	:= (clAlias)->A1_INSCR
				DGPE2->(NOME_CLIEN)	:= (clAlias)->A1_NOME
				DGPE2->(PESSOA)		:= (clAlias)->A1_PESSOA
				DGPE2->(NOME_VENDE)	:= (clAlias)->A3_NOME
				DGPE2->(NFANTASIA)		:= (clAlias)->A1_NREDUZ
				DGPE2->(END_VENDED)		:= (clAlias)->A3_END
				DGPE2->(UF_CLIENTE)		:= (clAlias)->A1_EST  
				DGPE2->(MAXDESC)	:= (clAlias)->A1_X_DESC
				DGPE2->(COD_VENDED)	:= (clAlias)->C5_VEND1  
				DGPE2->(MUNIC_CLIE)	:= (clAlias)->A1_MUN
				DGPE2->(GRUPOREP)	:= (clAlias)->A3_GRPREP
				DGPE2->(SUPERVISOR)	:= (clAlias)->A3_SUPER
				DGPE2->(CANAL_VEND)	:= (clAlias)->ACA_DESCRI
				//DGPE2->(ITEM_PEDID)	:= (clAlias)->C6_ITEM
				//DGPE2->(DESCPEDIDO)	:= (clAlias)->C6_DESCRI 
				//DGPE2->(DESCNC)		:= (clAlias)->B1_XDESC
		  		//DGPE2->(PUBLISH)	:= (clAlias)->B1_PUBLISH 
		  		//DGPE2->(CATEGORIA)	:= (clAlias)->B1_DESCCAT
		  		//DGPE2->(PRODUTO)		:= (clAlias)->C6_PRODUTO  
		  		DGPE2->(QTDVEND) 	:= (clAlias)->C6_QTDVEN
		  		DGPE2->(C6_QTDENT)	:= (clAlias)->C6_QTDENT
		  		    
		  		//DGPE2->(PRCTAB)		:= (clAlias)->C6_PRCTAB 
		  		//DGPE2->(PRCVENSIPI) 		:= (clAlias)->C6_PRCVEN 
		  		DGPE2->(TOTALITEM)	:= (clAlias)->C6_VALOR 
		  		DGPE2->(DESCONT)		:= (clAlias)->C6_DESCONT 
		  		DGPE2->(NFISCAL)		:= (clAlias)->C9_NFISCAL
		  		DGPE2->(SERIENF)		:= (clAlias)->C6_SERIE 
		  		//DGPE2->(COMISSAO)	:= (clAlias)->C6_COMIS1
		  		//DGPE2->(TES)		:= (clAlias)->C6_TES
		  		DGPE2->(DTENTREG)	:= (clAlias)->C6_ENTREG
		  		DGPE2->(USRLIB)		:= (clAlias)->C6_X_USRLB
		  		DGPE2->(BLOQ)		:= (clAlias)->C6_BLQ
		  		DGPE2->(ARMAZEM)		:= (clAlias)->C6_LOCAL
		  		DGPE2->(TIPOPED)		:= (clAlias)->C5_TIPO
		  		DGPE2->(CONDPAG)		:= (clAlias)->C5_CONDPAG            
		        DGPE2->(TABELAPRC)		:= (clAlias)->C5_TABELA
		        DGPE2->(TRANSPORT)		:= (clAlias)->C5_TRANSP
		        DGPE2->(EMISSAOC5)		:= StoD((clAlias)->C5_EMISSAO) 
		        DGPE2->(PEDCLI)			:= (clAlias)->C5_PEDCLI
		        If !Empty((clAlias)->C9_DATALIB) 
		        	DGPE2->(DATALIB)		:= StoD((clAlias)->C9_DATALIB)
		        EndIf 
		        DGPE2->(QTDLIBC9)	:= (clAlias)->C9_QTDLIB
		        DGPE2->(BLOQUEIOC9)	:= (clAlias)->C9_BLOQUEI  
		        DGPE2->(BLQCRED)	:= (clAlias)->C9_BLCRED 
		    	DGPE2->(BLEST) 		:= (clAlias)->C9_BLEST 
		    	DGPE2->(DTLIBES) 	:=	Stod((clAlias)->C9_DTLIBES)
		    	DGPE2->(ULIBCRD)		:= (clAlias)->C9_ULIBCRD

	
		       	DGPE2->(NF_DATAAG)	:= DGPED->(NF_DATAAG)
		    	DGPE2->(PESOBRUTO)	:= DGPED->(PESOBRUTO)
				
				//*************************************************			
				DGPE2->(TOTITEMLIB) := nItemLib
				DGPE2->(TOTITEMPED) := nItemPed
				DGPE2->(TOTITEMFAT) := nItemFat 
				If nItemLib <> nItemPed 
					DGPE2->(PEDTOTAL) := 0
					If nItemLib > 0
						DGPE2->(PEDPARCIAL) := 1
					Else
						DGPE2->(PEDPARCIAL) := 0
					EndIf
				Else
					DGPE2->(PEDTOTAL) := 1
					DGPE2->(PEDPARCIAL) := 0
				EndIf
				If nItemFat <> nItemPed 
					DGPE2->(FATTOTAL) := 0
					If nItemFat > 0 
						DGPE2->(FATPARCIAL) := 1
					EndIf
				Else
					DGPE2->(FATTOTAL) := 1
					DGPE2->(FATPARCIAL) := 0
				EndIf
				DGPE2->(MsUnLock())
			EndIf
		Else
			If DGPE2->(RecLock("DGPE2",.F.)) 
				DGPE2->(QTDVEND) 	:= DGPE2->(QTDVEND) + (clAlias)->C6_QTDVEN
		  		DGPE2->(C6_QTDENT)	:= DGPE2->(C6_QTDENT) + (clAlias)->C6_QTDENT
		  		DGPE2->(QTDLIBC9)	:= DGPE2->(QTDLIBC9) + DGPED->(QTDLIBC9) 
		  		DGPE2->(QTDFAT)		:= DGPE2->(QTDFAT) + DGPED->(QTDFAT)
		  		DGPE2->(TOTALITEM)	:= DGPE2->(TOTALITEM) + (clAlias)->C6_VALOR 
		  		DGPE2->(DESCONT)	:= DGPE2->(DESCONT) + (clAlias)->C6_DESCONT 
		  		
				If (clAlias)->C9_BLCRED == "10" .And. Empty((clAlias)->C9_DTLICRD)
		    		DGPE2->(DTLICRD) := DGPED->(DATALIB)
		    	Else
		    		If !Empty((clAlias)->C9_DTLICRD)
						DGPE2->(DTLICRD)    := StoD((clAlias)->C9_DTLICRD)
					EndIf
		    	EndIf
				If DGPED->(DTENTRE) <> CtoD("//") 
					DGPE2->(DTENTRE)    := DGPED->(DTENTRE)
				EndIf 
				If DGPED->(DTSAIDA) <> CtoD("//") 
		    		DGPE2->(DTSAIDA)	:= DGPED->(DTSAIDA)
		    	EndIf
		    	If DGPED->(EMISSANF) <> CtoD("//")
		    		DGPE2->(EMISSANF) := DGPED->(EMISSANF)
		    	EndIf
				DGPE2->(MsUnLock())
			EndIf
		
		EndIf 
	EndIf
	(clAlias)->(dbSkip())
End


clQry := " SELECT D2_FILIAL, D2_LOJA,D2_QUANT,D2_CF,D2_EMISSAO, D2_DOC, D2_SERIE, D2_CLIENTE, D2_LOJA, D2_NUMSEQ,D2_COD, D2_LOCAL, D2_NUMSEQ,A1_NOME, A1_PESSOA, A1_AGEND, A1_NREDUZ,A1_X_DESC, A1_EST,A1_INSCR, C5_LIBEROK, C5_NOTA, C5_BLQ, C5_VEND1,C5_TIPO,C5_CONDPAG,C5_TABELA,C5_TRANSP,C5_DTAGEND, C5_EMISSAO,C5_PEDCLI, A1_MUN,A1_EST, A1_COD_MUN,  A3_NOME,A3_GRPREP, ACA_GRPREP, ACA_DESCRI, D2_TOTAL,D2_VALIPI ,D2_VALFRE, D2_SEGURO, D2_ICMSRET, D2_DESPESA,C6_ITEM,"
clQry += " C6_FILIAL, C6_DESCRI,B1_XDESC, B1_PUBLISH ,B1_DESCCAT, C6_PRODUTO, C6_TPOPER, C6_QTDVEN, C6_QTDENT,C6_PRCTAB , C6_VALOR, C6_PRCVEN, C6_DESCONT,C6_NUM, C6_COMIS1, C6_TES, C6_ENTREG, C6_X_USRLB, C6_BLQ , C6_LOCAL
clQry += " FROM " + RetSqlName("SF2" ) +" F2"
clQry += "  ,SD2010 D2 , SF4010 F4 , SB1010 B1 , SA1010 A1 , SA3010 A3 , ACA010 ACA , SC6010 C6 , SC5010 C5 , SE4010 E4  "
clQry += " WHERE  D2_FILIAL = '" + xFilial("SD2") + "'"
clQry += " AND F2_EMISSAO >= '"  + DtoS(MV_PAR03) + "' AND F2_EMISSAO <= '" + DtoS(MV_PAR04) + "' "
clQry += " AND F2_FILIAL = D2_FILIAL AND F2_DOC = D2_DOC AND F2_SERIE = D2_SERIE"
clQry += " AND D2_TES = F4_CODIGO AND F4_DUPLIC = 'S' AND D2_COD = B1_COD "
clQry += " AND F2_CLIENTE = A1_COD AND F2_LOJA = A1_LOJA AND F2_VEND1 = A3_COD "
clQry += " AND F2_YCANAL = ACA_GRPREP" 
clQry += " AND F2_FILIAL = C6_FILIAL AND D2_PEDIDO = C6_NUM "
clQry += " AND D2_ITEMPV = C6_ITEM AND C6_FILIAL = C5_FILIAL AND C6_NUM = C5_NUM " 
//clQry += " AND C6_TPOPER = '01'"
clQry += " AND E4_CODIGO = F2_COND AND F2.D_E_L_E_T_ != '*' "
clQry += " AND D2.D_E_L_E_T_ != '*' AND F4.D_E_L_E_T_ != '*' AND B1.D_E_L_E_T_ != '*' AND A1.D_E_L_E_T_ != '*' "
clQry += " AND A3.D_E_L_E_T_ != '*' AND ACA.D_E_L_E_T_ != '*' AND C6.D_E_L_E_T_ != '*' AND C5.D_E_L_E_T_ != '*' AND E4.D_E_L_E_T_ != '*' "
//clQry += " GROUP BY ACA_GRPREP, ACA_DESCRI"
//clQry += " ORDER BY  ACA_GRPREP, ACA_DESCRI"

clQry := ChangeQuery(clQry)
cAliSd2 := GetNextAlias()

dbUseArea(.T.,"TOPCONN",TCGENQRY(,,clQry),cAliSD2, .T., .T.)
DbSelectarea(cAliSD2)
DbGoTop()


DbSelectArea("SZ1")
DbSetOrder(1) //Z1_FILIAL+Z1_DOC+Z1_SERIE+Z1_CLIENTE+Z1_LOJA                                                                                                                    

DbSelectArea("SF2")
DbSetOrder(2) //F2_FILIAL+F2_CLIENTE+F2_LOJA+F2_DOC+F2_SERIE    

DbSelectArea("SC9")
DbSetOrder(7) //C9_FILIAL+C9_PRODUTO+C9_LOCAL+C9_NUMSEQ 
//DbSetOrder(2) // C9_FILIAL+C9_CLIENTE+C9_LOJA+C9_PEDIDO+C9_ITEM     
While (cAliSD2)->(!EOF()) 
	cProvCanal	:= "" 
     
	If AllTrim((cAliSD2)->ACA_GRPREP) == "000003" .Or. AllTrim((cAliSD2)->ACA_GRPREP) == "000004" .Or. AllTrim((cAliSD2)->ACA_GRPREP) == "000005"   
		If AllTrim((cAliSD2)->A1_EST) $  "SP*SC*RS*PR"
			cProvCanal := "REGIONAL SUL"
		Else
			cprovCanal := "REGIONAL NORTE"
		EndIf                                         l
		 
	EndIf 
	
	SF2->(DbSeek((cAliSD2)->D2_FILIAL+(cAliSD2)->D2_CLIENTE+(cAliSD2)->D2_LOJA+(cAliSD2)->D2_DOC+(cAliSD2)->D2_SERIE))                                                                                                                    
	
	                                                                                                                  
	If DGPED->(RecLock("DGPED",.T.)) 
	
		If Empty((cAliSD2)->C5_LIBEROK) .And. Empty((cAliSD2)->C5_NOTA) .And. Empty((cAliSD2)->C5_BLQ)
			DGPED->(ABERTO)	:= "S"
		Else
			DGPED->(ABERTO)	:= "N"
		EndIf
		//C5_LIBEROK,C5_NOTA,C5_BLQ
		
		DGPED->(AGEND) 		:= IIF((cAliSD2)->A1_AGEND == "1", 1,0) 
		DGPED->(NF_DATAAG)	:= SF2->F2_DATAAG
		DGPED->(PD_DTAGEND)	:= StoD((cAliSD2)->C5_DTAGEND) 
		DGPED->(CAPITAL)  := IIF(Mycapitais((cAliSD2)->A1_COD_MUN, (cAliSD2)->A1_EST), "S","N") 
	
		
		DGPED->(TOTITEMPED) := MyItensPed((cAliSD2)->C6_NUM )
		DGPED->(TOTITEMLIB) := MyItensC9((cAliSD2)->C6_NUM )
		DGPED->(TOTITEMFAT) := MyItensD2((cAliSD2)->C6_NUM )
		DGPED->(FILIAL) 	:= (cAliSD2)->C6_FILIAL 
		DGPED->(SITUACAO)	:= "FATURADO" 
		DGPED->(QTDFAT)	:= (cAliSD2)->D2_QUANT
		DGPED->(VLRPEDIDO)	:= (cAliSD2)->D2_TOTAL +(cAliSD2)->D2_VALIPI + (cAliSD2)->D2_VALFRE + (cAliSD2)->D2_SEGURO + (cAliSD2)->D2_ICMSRET + (cAliSD2)->D2_DESPESA
		DGPED->(D2CFOP)		:= (cAliSD2)->D2_CF
		DGPED->(TPOPER)		:= (cAliSD2)->C6_TPOPER
		//DGPED->(C5CODBL)	:= (cAliSD2)->C5_CODBL
	   	DGPED->(NFFAT)		:= (cAliSD2)->D2_DOC
		DGPED->(SERIEFAT)	:= (cAliSD2)->D2_SERIE 
		DGPED->(EMISSANF)	:= StoD((cAliSD2)->D2_EMISSAO)
		DGPED->(CODCLI)		:= (cAliSD2)->D2_CLIENTE
		DGPED->(LOJA)		:= (cAliSD2)->D2_LOJA
		DGPED->(IECLIENTE)	:= (cAliSD2)->A1_INSCR
		DGPED->(NOME_CLIEN)	:= (cAliSD2)->A1_NOME
		DGPED->(PESSOA)		:= (cAliSD2)->A1_PESSOA
		DGPED->(NOME_VENDE)	:= (cAliSD2)->A3_NOME
		DGPED->(NFANTASIA)		:= (cAliSD2)->A1_NREDUZ
		//DGPED->(END_VENDED)		:= (cAliSD2)->A3_END
		DGPED->(UF_CLIENTE)		:= (cAliSD2)->A1_EST  
		DGPED->(MAXDESC)	:= (cAliSD2)->A1_X_DESC
		DGPED->(COD_VENDED)	:= (cAliSD2)->C5_VEND1  
		DGPED->(MUNIC_CLIE)	:= (cAliSD2)->A1_MUN
		DGPED->(GRUPOREP)	:= (cAliSD2)->A3_GRPREP
		//DGPED->(SUPERVISOR)	:= (cAliSD2)->A3_SUPER
		DGPED->(CANAL_VEND)	:= (cAliSD2)->ACA_DESCRI
		DGPED->(ITEM_PEDID)	:= (cAliSD2)->C6_ITEM
		DGPED->(DESCPEDIDO)	:= (cAliSD2)->C6_DESCRI 
		DGPED->(DESCNC)		:= (cAliSD2)->B1_XDESC
  		DGPED->(PUBLISH)	:= (cAliSD2)->B1_PUBLISH 
  		DGPED->(CATEGORIA)	:= (cAliSD2)->B1_DESCCAT
  		DGPED->(PRODUTO)		:= (cAliSD2)->C6_PRODUTO  
  		DGPED->(QTDVEND) 	:= (cAliSD2)->C6_QTDVEN
  		DGPED->(C6_QTDENT)	:= (cAliSD2)->C6_QTDENT
  		 
  		DGPED->(PRCTAB)		:= (cAliSD2)->C6_PRCTAB 
  		DGPED->(PRCVENSIPI) 		:= (cAliSD2)->C6_PRCVEN 
  		If (cAliSD2)->C6_PRCTAB == 0
  			DGPED->(DESCONTO)		:= 0
  		Else 
  			DGPED->(DESCONTO)		:= (((cAliSD2)->C6_PRCVEN /(cAliSD2)->C6_PRCTAB) - 1)*100 
  		EndIf
  			
  		DGPED->(TOTALITEM)	:= (cAliSD2)->C6_VALOR 
  		DGPED->(DESCONT)		:= (cAliSD2)->C6_DESCONT 
  		DGPED->(NFISCAL)		:= (cAliSD2)->D2_DOC
  	 	DGPED->(SERIENF)		:= (cAliSD2)->D2_SERIE 
  		DGPED->(NUMPED)		:= (cAliSD2)->C6_NUM 
  		DGPED->(COMISSAO)	:= (cAliSD2)->C6_COMIS1
  		DGPED->(TES)		:= (cAliSD2)->C6_TES
  		DGPED->(DTENTREG)	:= (cAliSD2)->C6_ENTREG
  		DGPED->(USRLIB)		:= (cAliSD2)->C6_X_USRLB
  		DGPED->(BLOQ)		:= (cAliSD2)->C6_BLQ
  		DGPED->(ARMAZEM)		:= (cAliSD2)->C6_LOCAL
  		DGPED->(TIPOPED)		:= (cAliSD2)->C5_TIPO
  		DGPED->(CONDPAG)		:= (cAliSD2)->C5_CONDPAG            
        DGPED->(TABELAPRC)	:= (cAliSD2)->C5_TABELA
        DGPED->(TRANSPORT)		:= (cAliSD2)->C5_TRANSP
        DGPED->(EMISSAOC5)		:= StoD((cAliSD2)->C5_EMISSAO) 
        DGPED->(PEDCLI)			:= (cAliSD2)->C5_PEDCLI
        //C9_FILIAL+C9_CLIENTE+C9_LOJA+C9_PEDIDO+C9_ITEM 
        SC9->(DBsEToRDER(7))                                                                                                                 
        If SC9->(DbSeek(xFilial("SC9") + (cAliSD2)->D2_COD+(cAliSD2)->D2_LOCAL+(cAliSD2)->D2_NUMSEQ ))
    	//If SC9->(DbSeek(xFilial("SC9") +(cAliSD2)->D2_CLIENTE + (cAliSD2)->D2_LOJA + (cAliSD2)->C6_NUM + (cAliSD2)->C6_ITEM))
        	//DGPED->(TOTITEMLIB) := 1 
        	If !Empty(SC9->C9_DATALIB )   
        		DGPED->(DATALIB)	:= SC9->C9_DATALIB
        	EndIf 
        	DGPED->(QTDLIBC9)	:= SC9->C9_QTDLIB
        	DGPED->(BLOQUEIOC9)	:= SC9->C9_BLOQUEI  
        	DGPED->(BLQCRED)	:= SC9->C9_BLCRED 
    		DGPED->(BLEST) 		:= SC9->C9_BLEST 
    		DGPED->(DTLIBES) 	:= SC9->C9_DTLIBES
    		DGPED->(ULIBCRD)	:= SC9->C9_ULIBCRD
    		If SC9->C9_BLCRED == "10" .And. Empty(SC9->C9_DTLICRD)
	    		DGPED->(DTLICRD) := DGPED->(DATALIB)
	    	Else
	    		If !Empty(SC9->C9_DTLICRD)
					DGPED->(DTLICRD)    := SC9->C9_DTLICRD
				EndIf
	    	EndIf
    	EndIf
    	If SZ1->(dbSeek(xFilial("SZ1")+(cAliSD2)->D2_DOC+(cAliSD2)->D2_SERIE+(cAliSD2)->D2_CLIENTE+(cAliSD2)->D2_LOJA)) 
	    	DGPED->(DTENTRE)	:= SZ1->Z1_DTENTRE
	    	DGPED->(DTSAIDA)	:= SZ1->Z1_DTSAIDA 
	    EndIf
    	
    	If Empty(cprovCanal)
    		DGPED->(CANALVEND) := (cAliSD2)->ACA_DESCRI 
    	Else	
    		DGPED->(CANALVEND)	:= cProvCanal
    	EndIf
			
		DGPED->(PESOBRUTO) := SF2->F2_PBRUTO
    	
    
    	                     
		DGPED->(MsUnLock())
	EndIF
	(cAliSD2)->(DbSkip())

End  

cAliasSD1:= GetNextAlias()

cWhereAux 	:= ""
cVendedor 	:= "1"

cWhere := ""
If cPaisLoc == "BRA"
	For nCampo := 1 To nVendedor
		cCampo := "F2_VEND"+cVendedor
		If SF2->(FieldPos(cCampo)) > 0
			cWhereAux += "(" + cCampo + " between '      ' and 'ZZZZZZ') or "
			cAddField += ", "  + cCampo
		EndIf
		cVendedor := Soma1(cVendedor,1)
	Next nCampo
Else
	For nCampo := 1 To 35
		cCampo := "F1_VEND"+cVendedor
		If SF1->(FieldPos(cCampo)) > 0
			cWhereAux += "(" + cCampo + " between '     ' and 'ZZZZZZ') or "
			cAddField += ", "  + cCampo
		EndIf
		cVendedor := Soma1(cVendedor,1)
	Next nCampo
EndIf

If Empty(cWhereAux)
	cWhere += " NOT ("+IsRemito(2,"D1_TIPODOC")+")"
Else
	cWhereAux := Left(cWhereAux,Len(cWhereAux)-4)
	cWhere := "(" + cWhereAux + " ) AND NOT ("+IsRemito(2,"D1_TIPODOC")+")"	
EndIf


If SF1->(FieldPos("F1_FRETINC")) > 0
	cAddField += ", F1_FRETINC"
EndIf
    //ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
    //ณEsta Rotina adiciona a cQuery os campos retornados na string de filtro do  |
    //ณponto de entrada MR580FIL.                                                 |
    //ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู	   
    



cSqlDev := " SELECT SD1.*, F1_EMISSAO, F1_DOC, F1_SERIE, F1_FORNECE, F1_LOJA, F1_FRETE, F1_DESPESA, F1_SEGURO, F1_ICMSRET, F1_EST, F1_COND,"
cSqlDev += " F1_DTDIGIT,F2_DOC, F2_SERIE, F2_EMISSAO, F2_CLIENTE, F2_LOJA, F2_VEND1, F1_TXMOEDA, F1_MOEDA, F1_FORMUL, A3_NOME, A3_GRPREP, ACA_DESCRI, B1_XDESC, B1_PLATAF, B1_DESCCAT, B1_PUBLISH,A1_INSCR,A1_EST,A1_COD_MUN,A1_AGEND,A1_X_DESC, A1_NREDUZ,A1_PESSOA, A1_MUN,  A1_NOME " + cAddField
cSqlDev += " FROM " + RetSqlName("SD1") + " SD1, " + RetSqlname("SF4") + " SF4, " + RetSqlName("SF2") + " SF2, " + RetSqlName("SF1") + " SF1, " + RetSqlName("SA3") + " SA3," + RetSqlName("ACA") + " ACA,"+ RetSqlName("SB1") + " SB1," + RetSqlName("SA1") + " SA1"
cSqlDev += " WHERE D1_FILIAL  = '" + xFilial("SD1") + "'" 
cSqlDev += " AND D1_DTDIGIT BETWEEN '" + DtoS(MV_PAR03) + "' AND '" + DtoS(MV_PAR04) + "'"
cSqlDev += " AND D1_TIPO = 'D'"
cSqlDev += " AND F4_FILIAL  = '" + xFilial("SF4") + "'"
cSqlDev += " AND F4_CODIGO  = D1_TES"
cSqlDev += " AND F2_FILIAL  = '" + xFilial("SF2") + "' "  
cSqlDev += " AND F2_DOC     = D1_NFORI" 
cSqlDev += " AND F2_SERIE   = D1_SERIORI"
cSqlDev += " AND F2_LOJA    = D1_LOJA"
cSqlDev += " AND F2_VEND1	= A3_COD"
cSqlDev += " AND F1_FILIAL  = '" + xFilial("SF1") + "'"
cSqlDev += " AND F1_DOC     = D1_DOC" 
cSqlDev += " AND F1_SERIE   = D1_SERIE""
cSqlDev += " AND F1_FORNECE = D1_FORNECE"
cSqlDev += " AND F1_LOJA    = D1_LOJA"
cSqlDev += " AND A1_FILIAL = '" + xFilial("SA1") + "'"
cSqlDev += " AND A1_COD		= D1_FORNECE"
cSqlDev += " AND A1_LOJA	= D1_LOJA"
cSqlDev += " AND ACA_FILIAL = '" + xFilial("ACA") + "'"
cSqlDev += " AND ACA_GRPREP = A3_GRPREP" 
cSqlDev += " AND B1_FILIAL = '" + xFilial("SB1") + "' "
cSqlDev += " AND B1_COD = D1_COD "
cSqlDev += " AND A3_FILIAL	= '" + xFilial("SA3")  + "' " 
//cSqlDev += " AND A3_GRPREP BETWEEN '" + cGrpCli + "' AND '" + cGrpCli + "'"  
cSqlDev += " AND SD1.D_E_L_E_T_ = ' '"
cSqlDev += " AND SF4.D_E_L_E_T_ = ' '"
cSqlDev += " AND SF2.D_E_L_E_T_ = ' '"
cSqlDev += " AND SF1.D_E_L_E_T_ = ' '"
cSqlDev += " AND SA3.D_E_L_E_T_ = ' '"
cSqlDev += " AND SA1.D_E_L_E_T_ = ' '"
cSqlDev += " AND ACA.D_E_L_E_T_ = ' '"
cSqlDev += " AND SB1.D_E_L_E_T_ = ' '"
cSqlDev += " AND " + cWhere 			
cSqlDev += " ORDER BY D1_FILIAL,D1_FORNECE,D1_LOJA,D1_DTDIGIT,D1_DOC,D1_SERIE,D1_NUMSEQ " 

cSqlDev := ChangeQuery(cSqlDev)
dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cSqlDev),cAliasSD1, .T., .T.)
While (cAliasSD1)->(!EOF()) 
	cProvCanal	:= "" 

	If AllTrim((cAliSD2)->ACA_GRPREP) == "000003" .Or. AllTrim((cAliSD2)->ACA_GRPREP) == "000004" .Or. AllTrim((cAliSD2)->ACA_GRPREP) == "000005"   
		If AllTrim((cAliSD2)->A1_EST) $  "SP*SC*RS*PR"
			cProvCanal := "REGIONAL SUL"
		Else
			cprovCanal := "REGIONAL NORTE"
		EndIf
		 
	EndIf  
	
	If DGPED->(RecLock("DGPED",.T.)) 
		DGPED->(FILIAL) := (cAliasSD1)->D1_FILIAL 
		DGPED->(SITUACAO) := "DEVOLUCAO" 
		DGPED->(AGEND)	:= IIf((cAliasSD1)->A1_AGEND == "1",1, 0)
		DGPED->(QTDFAT)	:= -((cAliasSD1)->D1_QUANT)
		DGPED->(VLRPEDIDO)	:= -((cAliasSD1)->D1_TOTAL +(cAliasSD1)->D1_VALIPI + (cAliasSD1)->D1_VALFRE + (cAliasSD1)->D1_SEGURO + (cAliasSD1)->D1_ICMSRET + (cAliasSD1)->D1_DESPESA )
		DGPED->(D2CFOP)		:= (cAliasSD1)->D1_CF
		DGPED->(CAPITAL)  := IIF(Mycapitais((cAliasSD1)->A1_COD_MUN, (cAliasSD1)->A1_EST), "S","N")  
	
		//DGPED->(TPOPER)		:= (cAliasSD1)->C6_TPOPER
		//DGPED->(C5CODBL)	:= (cAliasSD1)->C5_CODBL
	   	DGPED->(NFFAT)		:= (cAliasSD1)->D1_DOC
		DGPED->(SERIEFAT)	:= (cAliasSD1)->D1_SERIE 
		DGPED->(EMISSANF)	:= StoD((cAliasSD1)->D1_DTDIGIT)
		DGPED->(CODCLI)		:= (cAliasSD1)->D1_FORNECE
		DGPED->(LOJA)		:= (cAliasSD1)->D1_LOJA
		DGPED->(IECLIENTE)	:= (cAliasSD1)->A1_INSCR
		DGPED->(NOME_CLIEN)	:= (cAliasSD1)->A1_NOME
		DGPED->(PESSOA)		:= (cAliasSD1)->A1_PESSOA
		DGPED->(NOME_VENDE)	:= (cAliasSD1)->A3_NOME
		DGPED->(NFANTASIA)		:= (cAliasSD1)->A1_NREDUZ
		//DGPED->(END_VENDED)		:= (cAliasSD1)->A3_END
		DGPED->(UF_CLIENTE)		:= (cAliasSD1)->A1_EST  
		DGPED->(MAXDESC)	:= (cAliasSD1)->A1_X_DESC
		//DGPED->(COD_VENDED)	:= (cAliasSD1)->C5_VEND1  
		DGPED->(MUNIC_CLIE)	:= (cAliasSD1)->A1_MUN
		DGPED->(GRUPOREP)	:= (cAliasSD1)->A3_GRPREP
		//DGPED->(SUPERVISOR)	:= (cAliasSD1)->A3_SUPER
		DGPED->(CANAL_VEND)	:= (cAliasSD1)->ACA_DESCRI
		//DGPED->(ITEM_PEDID)	:= (cAliasSD1)->C6_ITEM
		//DGPED->(DESCPEDIDO)	:= (cAliasSD1)->C6_DESCRI 
		DGPED->(DESCNC)		:= (cAliasSD1)->B1_XDESC
  		DGPED->(PUBLISH)	:= (cAliasSD1)->B1_PUBLISH 
  		DGPED->(CATEGORIA)	:= (cAliasSD1)->B1_DESCCAT
  		//DGPED->(PRODUTO)		:= (cAliasSD1)->C6_PRODUTO  
  		//DGPED->(QTDVEND) 	:= -((cAliasSD1)->D1_QUANT )
  		//DGPED->(C6_QTDENT)	:= (cAliasSD1)->C6_QTDENT
  		 
  		//DGPED->(PRCTAB)		:= (cAliasSD1)->C6_PRCTAB 
  		//DGPED->(PRCVENSIPI) 		:= (cAliasSD1)->C6_PRCVEN 
  		//If (cAliasSD1)->C6_PRCTAB == 0
  		//	DGPED->(DESCONTO)		:= 0
  		//Else 
  		//	DGPED->(DESCONTO)		:= (((cAliasSD1)->C6_PRCVEN /(cAliasSD1)->C6_PRCTAB) - 1)*100 
  		//EndIf
  			
  		//DGPED->(TOTALITEM)	:= (cAliasSD1)->C6_VALOR 
  		//DGPED->(DESCONT)		:= (cAliasSD1)->C6_DESCONT 
  		DGPED->(NFISCAL)		:= (cAliasSD1)->F1_DOC
  	 	DGPED->(SERIENF)		:= (cAliasSD1)->D1_SERIE 
  		//DGPED->(NUMPED)		:= (cAliasSD1)->C6_NUM 
  		//DGPED->(COMISSAO)	:= (cAliasSD1)->C6_COMIS1
  		//DGPED->(TES)		:= (cAliasSD1)->C6_TES
  		//DGPED->(DTENTREG)	:= (cAliasSD1)->C6_ENTREG
  		//DGPED->(USRLIB)		:= (cAliasSD1)->C6_X_USRLB
  		//DGPED->(BLOQ)		:= (cAliasSD1)->C6_BLQ
  		//DGPED->(ARMAZEM)		:= (cAliasSD1)->C6_LOCAL
  		//DGPED->(TIPOPED)		:= (cAliasSD1)->C5_TIPO
  		//DGPED->(CONDPAG)		:= (cAliasSD1)->C5_CONDPAG            
        //DGPED->(TABELAPRC)	:= (cAliasSD1)->C5_TABELA
        //DGPED->(TRANSPORT)		:= (cAliasSD1)->C5_TRANSP
        //DGPED->(EMISSAOC5)		:= (cAliasSD1)->C5_EMISSAO 
        //DGPED->(PEDCLI)			:= (cAliasSD1)->C5_PEDCLI
        //If SC9->(DbSeek(xFilial("SC9") + (cAliasSD1)->D2_COD+(cAliasSD1)->D2_LOCAL+(cAliasSD1)->D2_NUMSEQ ))     
        //	DGPED->(DATALIB)	:= DtoS(SC9->C9_DATALIB) 
        //	DGPED->(QTDLIBC9)	:= SC9->C9_QTDLIB
        //	DGPED->(BLOQUEIOC9)	:= SC9->C9_BLOQUEI  
        //	DGPED->(BLQCRED)	:= SC9->C9_BLCRED 
    	//	DGPED->(BLEST) 		:= SC9->C9_BLEST 
    	//	DGPED->(DTLIBES) 	:= DtoS(SC9->C9_DTLIBES)
    	//	DGPED->(ULIBCRD)	:= SC9->C9_ULIBCRD
    	//EndIf 
    	
    	If Empty(cprovCanal)
    		DGPED->(CANALVEND) := (cAliasSD1)->ACA_DESCRI 
    	Else	
    		DGPED->(CANALVEND)	:= cProvCanal
    	EndIf
    	
    
    	                     
		DGPED->(MsUnLock())
	EndIF
	(cAliasSD1)->(DbSkip())

End  


dbSelectArea("DGPED")
dbCloseArea()

//COPY FILE ("SYSTEM\" + CNOMEDBF + ".dbf") TO ("XLSNC\" + CNOMEDBF + ".dbf")
If !IsBlind() 
	CPYS2T("\SYSTEM\" + CNOMEDBF + ".dbf",cDirUser,.T.)
EndIf 
//\\192.168.0.210\Company\มreas Comuns\Adm Planilha BD\Acompanhamento de Pedidos
__CopyFile( "\SYSTEM\" + CNOMEDBF + ".dbf", cDirCopy + CNOMEDBF + ".DBF" )
//COPY FILE ("SYSTEM\" + CNOMEDBF + ".dbf") TO (AllTrim(cDirCopy) + CNOMEDBF + ".dbf")


//COPY FILE ("SYSTEM\" + CNOMEDBF + ".dbf") TO (cDirCopy + CNOMEDBF + ".dbf") 

//CPYS2T("\SYSTEM\" + CNOMEDBF + ".dbf",cDirCopy,.T.)
fErase("SYSTEM\" + CNOMEDBF +GetDBExtension()) 

dbSelectArea("DGPE2")
DbCloseArea()

If !IsBLind()
	CPYS2T("\SYSTEM\" + CNOM2DBF + ".dbf",cDirUser,.T.)
EndIf
__CopyFile( "\SYSTEM\" + CNOM2DBF + ".dbf", cDirCopy + CNOM2DBF + ".DBF" )
//COPY FILE ("SYSTEM\" + CNOM2DBF + ".dbf") TO (AllTrim(cDirCopy) + CNOM2DBF + ".dbf") 

fErase("SYSTEM\" + CNOM2DBF +GetDBExtension()) 
FErase(CNOM2DBF+OrdBagExt())

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Restaura a integridade dos dados                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
dbSelectArea("SF2")
dbClearFilter()
dbSetOrder(1)


Return
	
	
	
	/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณDBMCRIASX1บAutor  ณ DBMS- Alberto      บ Data ณ 27/02/2012  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Static Function para criacao de perguntas                  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function DBMCRIASX1()


PutSx1("DBM_VISPED","01","Emissao Pedido de"	   		,"Emissao Pedido de"			,"Emissao Pedido de"  		,"mv_ch1","D",08,0,1,"G","",""   ,"","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
PutSx1("DBM_VISPED","02","Emissao Pedido Ate"	   		,"Emissao Pedido Ate"			,"Emissao Pedido Ate"  		,"mv_ch2","D",08,0,1,"G","",""   ,"","","mv_par02","","","","","","","","","","","","","","","","",{},{},{})
PutSx1("DBM_VISPED","03","Data Faturamento de"	   		,"Data Faturamento de"			,"Data Faturamento de"  		,"mv_ch3","D",08,0,1,"G","",""   ,"","","mv_par03","","","","","","","","","","","","","","","","",{},{},{})
PutSx1("DBM_VISPED","04","Data Faturamento Ate"	   		,"Data Faturamento Ate"			,"Data Faturamento Ate"  		,"mv_ch4","D",08,0,1,"G","",""   ,"","","mv_par04","","","","","","","","","","","","","","","","",{},{},{})


Return  
	
	
/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMyNewSX6  บAutor  ณAlmir Bandina       บ Data ณ  10/02/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescri็ใo ณAtualiza o arquivo de parโmetros.                           บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNCGAMES - TECNOLOGIA DA INFORMAวรO                              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametro ณExpC1 = Nome do Parโmetro                                   บฑฑ
ฑฑบ          ณExpX1 = Conte๚do do Parโmetro           	                  บฑฑ
ฑฑบ          ณExpC2 = Tipo do Parโmetro                                   บฑฑ
ฑฑบ          ณExpC3 = Descri็ใo em portugues                              บฑฑ
ฑฑบ          ณExpC4 = Descri็ใo em espanhol                               บฑฑ
ฑฑบ          ณExpC5 = Descri็ใo em ingles                                 บฑฑ
ฑฑบ          ณExpL1 = Grava o conte๚do se existir o parโmetro             บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function MyNewSX6( cMvPar, xValor, cTipo, cDescP, cDescS, cDescE, lAlter , lFilial)

Local aAreaAtu	:= GetArea()
Local lRecLock	:= .F.
Local xlReturn

Default lAlter 	:= .F.
Default lFilial	:= .F.

If ( ValType( xValor ) == "D" )
	If " $ xValor
		xValor := Dtoc( xValor, "ddmmyy" )
	Else
		xValor	:= Dtos( xValor )
	Endif
ElseIf ( ValType( xValor ) == "N" )
	xValor	:= AllTrim( Str( xValor ) )
ElseIf ( ValType( xValor ) == "L" )
	xValor	:= If ( xValor , ".T.", ".F." )
EndIf

DbSelectArea('SX6')
DbSetOrder(1)

If lFilial
	lRecLock := !MsSeek( cFilAnt + Padr( cMvPar, Len( X6_VAR ) ) )
Else
	lRecLock := !MsSeek( Space( Len( X6_FIL ) ) + Padr( cMvPar, Len( X6_VAR ) ) )
EndIf

If lRecLock
	
	RecLock( "SX6", lRecLock )
	
	If lFilial
		FieldPut( FieldPos( "X6_FIL" ), cFilAnt )	
	EndIf
		
	FieldPut( FieldPos( "X6_VAR" ), cMvPar )
	
	FieldPut( FieldPos( "X6_TIPO" ), cTipo )
	
	FieldPut( FieldPos( "X6_PROPRI" ), "U" )
	
	If !Empty( cDescP )
		FieldPut( FieldPos( "X6_DESCRIC" ), SubStr( cDescP, 1, Len( X6_DESCRIC ) ) )
		FieldPut( FieldPos( "X6_DESC1" ), SubStr( cDescP, Len( X6_DESC1 ) + 1, Len( X6_DESC1 ) ) )
		FieldPut( FieldPos( "X6_DESC2" ), SubStr( cDescP, ( Len( X6_DESC2 ) * 2 ) + 1, Len( X6_DESC2 ) ) )
	EndIf
	
	If !Empty( cDescS )
		FieldPut( FieldPos( "X6_DSCSPA" ), cDescS )
		FieldPut( FieldPos( "X6_DSCSPA1" ), SubStr( cDescS, Len( X6_DSCSPA1 ) + 1, Len( X6_DSCSPA1 ) ) )
		FieldPut( FieldPos( "X6_DSCSPA2" ), SubStr( cDescS, ( Len( X6_DSCSPA2 ) * 2 ) + 1, Len( X6_DSCSPA2 ) ) )
	EndIf
	
	If !Empty( cDescE )
		FieldPut( FieldPos( "X6_DSCENG" ), cDescE )
		FieldPut( FieldPos( "X6_DSCENG1" ), SubStr( cDescE, Len( X6_DSCENG1 ) + 1, Len( X6_DSCENG1 ) ) )
		FieldPut( FieldPos( "X6_DSCENG2" ), SubStr( cDescE, ( Len( X6_DSCENG2 ) * 2 ) + 1, Len( X6_DSCENG2 ) ) )
	EndIf
	
	If lRecLock .Or. lAlter
		FieldPut( FieldPos( "X6_CONTEUD" ), xValor )
		FieldPut( FieldPos( "X6_CONTSPA" ), xValor )
		FieldPut( FieldPos( "X6_CONTENG" ), xValor )
	EndIf
	
	MsUnlock()
	
EndIf

xlReturn := GetNewPar(cMvPar)

RestArea( aAreaAtu )


Return(xlReturn) 


Static Function MyItensPed(cPedido) 
Local nTotItens := 0
//Local aArea	:= SC6->(GetArea()) 
//Local aSc9Area := SC9->(GetArea()) 
Local cItem	:= ""

DbSelectArea("SC6") 
DbSetOrder(1)
DbGotOp()

DbSeek(xFilial("SC6") + cPedido)

While !SC6->(EOF()) .And. SC6->C6_NUM == cPedido
	nTotItens++  
	SC6->(DbSkip())
End

//SC6->(RestArea(aArea))
//SC9->(RestArea(aSC9Area))
Return nTotItens



Static Function MyItensC9(cPedido) 
//Local nTotItens := 0
//Local aArea	:= SC6->(GetArea()) 
//Local aSc9Area := SC9->(GetArea()) 
Local cItem	:= ""
Local nTotLib := 0

DbSelectArea("SC9")
DbSetOrder(1)
DbSeek(xFilial("SC9") + cPedido)
//cItem := SC9->C9_ITEM
While !SC9->(EOF()) .And. SC9->C9_PEDIDO == cPedido
	If cItem <> SC9->C9_ITEM
		nTotLib++
	EndIf
	
	cItem := SC9->C9_ITEM
	
	SC9->(DbSkip())
End

//SC9->(RestArea(aSC9Area))
Return nTotLib 

Static Function MyItensD2(cPedido) 
//Local nTotItens := 0
//Local aArea	:= SC6->(GetArea()) 
//Local aSD2Area := SD2->(GetArea()) 
Local cItem	:= ""
Local nTotLib := 0

DbSelectArea("SD2")
DbSetOrder(8) //D2_FILIAL+D2_PEDIDO+D2_ITEMPV                                                                                                                                   
DbSeek(xFilial("SD2") + cPedido)
//cItem := SC9->C9_ITEM
While !SD2->(EOF()) .And. SD2->D2_PEDIDO == cPedido
	nTotLib++
	SD2->(DbSkip())
End

//SD2->(RestArea(aSD2Area))
Return nTotLib



Static Function Mycapitais(cCodmun, cUF) 

Local llret := .F.

cCodMun := AllTrim(cCodMun)
Do Case 
	Case cCodmun == "04302"	.And. cUf == "AL" //Macei๓	AL
		llRet := .T.
	Case cCodmun == "00303" .And. cUf == "AP" //		Macapแ	AP 
		llRet := .T.
	Case cCodmun == "02603" .And. cUf == "AM" //	Manaus	AM  
		llRet := .T.
	Case cCodmun == "27408" .And. cUf == "BA" //	Salvador	BA 
		llRet := .T.
	Case cCodmun == "04400" .And. cUf == "CE" //	Fortaleza	CE 
		llRet := .T.
	Case cCodmun == "00108" .And. cUf == "DF" //	Brasํlia	DF
		llRet := .T.
	Case cCodmun == "05309" .And. cUf == "ES" //	Vit๓ria	ES
		llRet := .T.
	Case cCodmun == "06200" .And. cUf == "GO" //	Goiโnia	GO 
		llRet := .T.
	Case cCodmun == "11300" .And. cUf == "MA" //	Sใo Luiz	MA
		llRet := .T.
	Case cCodmun == "03403" .And. cUf == "MT" //	Cuiabแ	MT 
		llRet := .T.
	Case cCodmun == "02704" .And. cUf == "MS" //	Campo Grande	MS
		llRet := .T.
	Case cCodmun == "06200" .And. cUf == "MG" //	Belo Horizonte	MG
		llRet := .T.
	Case cCodmun == "06902" .And. cUf == "PR" //	Curitiba	PR
		llRet := .T.
	Case cCodmun == "07507" .And. cUf == "PB" //	Joใo Pessoa	PB
		llRet := .T.
	Case cCodmun == "01402" .And. cUf == "PA" //	Bel้m	PA 
		llRet := .T.
	Case cCodmun == "11606" .And. cUf == "PE" //	Recife	PE
		llRet := .T.
	Case cCodmun == "11001" .And. cUf == "PI" //	Terezina	PI
		llRet := .T.
	Case cCodmun == "04557" .And. cUf == "RJ" //	Rio de Janeiro	RJ 
		llRet := .T.
	Case cCodmun == "08102" .And. cUf == "RN" //	Natal	RN
		llRet := .T.
	Case cCodmun == "04902" .And. cUf == "RS" //	Porto Alegre	RS
		llRet := .T.
	Case cCodmun == "00205" .And. cUf == "RO" //		Porto Velho	RO
		llRet := .T.
	Case cCodmun == "00100" .And. cUf == "RR" //		Boa Vista	RR  
		llRet := .T.
	Case cCodmun == "05407" .And. cUf == "SC" //	Florian๓polis	SC
		llRet := .T.
	Case cCodmun == "00308" .And. cUf == "SE" //		Aracaj๚	SE
		llRet := .T.
	Case cCodmun == "50308" .And. cUf == "SP" //	Sใo Paulo	SP
		llRet := .T.
	Case cCodmun == "21000" .And. cUf == "TO" //	Palmas	TO
		llRet := .T.
EndCase

Return llRet
