#INCLUDE 'PROTHEUS.CH'
#Include "FIVEWIN.Ch"  
#Include "TBICONN.CH"  
#INCLUDE "TOPCONN.CH" 

#DEFINE CRLF Chr(13)+Chr(10)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³DBVISPED  º Autor ³ Alberto Kibino     º Data ³  13/12/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ RELATORIO PARA GERAR DBF 							      º±±
±±º          ³ CRIAÇÃO BASE VISÃO DOS PEDIDOS EM CARTEIRA                 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NCGAMES VENDAS KEY ACCOUNT                                 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function DBVISPED()

Local aAreaSx3 := SX3->(GetArea())
            
DBMCRIASX1()

If !Pergunte("DBM_VISPED",.T.)  
	Return
endIf 

Processa( {|| MyGetVispd() }, "Aguarde...", "Carregando tabela VISPED.DBF...",.F.)
   
If Len(aAreaSx3) > 0
	RestArea(aAreaSX3)
EndIf 
MsgAlert("Arquivo gerado com sucesso. " ,"Termino" )
 
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
                               
DbSelectArea("SX3")
DbSetORder(2)


If SX3->(DbSeek("C6_FILIAL"))	
	AADD(aDbStru,{"FILIAL",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"FILIAL", SX3->X3_CAMPO})
EndIf  

If SX3->(DbSeek("C6_TPOPER"))
	AADD(aDbStru,{"TPOPER",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"TPOPER", SX3->X3_CAMPO})
EndIf 

If SX3->(DbSeek("C5_CODBL"))
	AADD(aDbStru,{"C5CODBL",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"C5CODBL", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("D2_CF"))
	AADD(aDbStru,{"D2CFOP",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"D2CFOP", SX3->X3_CAMPO})
EndIf

If SX3->(DbSeek("D2_EMISSAO"))
	AADD(aDbStru,{"EMISSANF",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"EMISSANF", SX3->X3_CAMPO})
EndIf 

If SX3->(DbSeek("C9_SEQUEN"))
	AADD(aDbStru,{"C9SEQUEN",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"C9SEQUEN", SX3->X3_CAMPO})
EndIf


AADD(aDbStru,{"SITUACAO","C",13,0}) 
AADD(aCampos, {"SITUACAO", " "})

AADD(aDbStru,{"QUANTIDADE","N",13,0}) 
AADD(aCampos, {"QUANTIDADE", " "}) 

AADD(aDbStru,{"VLRPEDIDO","N",13,5}) 
AADD(aCampos, {"VLRPEDIDO", " "})
If SX3->(DbSeek("A1_LOJA"))
	AADD(aDbStru,{"LOJA",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"LOJA", SX3->X3_CAMPO})
EndIf 

If SX3->(DbSeek("C9_NFISCAL"))
	AADD(aDbStru,{"NFFAT",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"NFFAT", SX3->X3_CAMPO})
EndIf 

If SX3->(DbSeek("C9_SERIENF"))
	AADD(aDbStru,{"SERIEFAT",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"SERIEFAT", SX3->X3_CAMPO})
EndIf 

If SX3->(DbSeek("A1_INSCR"))
	AADD(aDbStru,{"IECLIENTE",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"IECLIENTE", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("A1_NOME"))
	AADD(aDbStru,{"NOME_CLIEN",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL})
	AADD(aCampos, {"NOME_CLIEN", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("A1_PESSOA"))
	AADD(aDbStru,{"PESSOA",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"PESSOA", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("A3_NOME"))
	AADD(aDbStru,{"NOME_VENDE",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL})
	AADD(aCampos, {"NOME_VENDE", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("A1_NREDUZ"))
	AADD(aDbStru,{"NFANTASIA",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"NFANTASIA", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("A3_END"))
	AADD(aDbStru,{"END_VENDED",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL})
	AADD(aCampos, {"END_VENDED", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("A1_EST"))
	AADD(aDbStru,{"UF_CLIENTE",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL})
	AADD(aCampos, {"UF_CLIENTE", SX3->X3_CAMPO})
EndIf

If SX3->(DbSeek("A1_X_DESC"))
	AADD(aDbStru,{"MAXDESC",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"MAXDESC", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("A1_VEND"))
	AADD(aDbStru,{SUBSTR("COD_VENDED",1,10),SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL})
	AADD(aCampos, {SUBSTR("COD_VENDED",1,10), SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("A1_MUN"))
	AADD(aDbStru,{"MUNIC_CLIE",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL})
	AADD(aCampos, {"MUNIC_CLIE", SX3->X3_CAMPO})
EndIf

If SX3->(DbSeek("A3_GRPREP"))
	AADD(aDbStru,{"GRUPOREP",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"GRUPOREP", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("A3_SUPER"))
	AADD(aDbStru,{"SUPERVISOR",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"SUPERVISOR", SX3->X3_CAMPO})
EndIf

If SX3->(DbSeek("ACA_DESCRI"))
	AADD(aDbStru,{"CANAL_VEND", SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"CANAL_VEND", SX3->X3_CAMPO})
EndIf
                                  
If SX3->(DbSeek("C6_ITEM"))
	AADD(aDbStru,{"ITEM_PEDID",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL})
	AADD(aCampos, {"ITEM_PEDID",SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("C6_DESCRI"))
	AADD(aDbStru,{"DESCPEDIDO",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"DESCPEDIDO", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("B1_XDESC"))
	AADD(aDbStru,{"DESCNC",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"DESCNC", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("B1_PUBLISH"))
	AADD(aDbStru,{"PUBLISH",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"PUBLISH", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("B1_DESCCAT"))
	AADD(aDbStru,{"CATEGORIA",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"CATEGORIA", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("C6_PRODUTO"))
	AADD(aDbStru,{"PRODUTO",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"PRODUTO", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("C6_QTDVEN"))
	AADD(aDbStru,{"QTDVEND",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"QTDVEND", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("C6_QTDENT"))
	AADD(aDbStru,{"QTDENT",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"QTDENT", SX3->X3_CAMPO}) 
EndIf

If SX3->(DbSeek("C6_PRCTAB"))
	AADD(aDbStru,{"PRCTAB",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"PRCTAB", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("C6_PRCVEN"))
	AADD(aDbStru,{"PRCVENSIPI",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"PRCVENSIPI", SX3->X3_CAMPO})
EndIf

AADD(aDbStru,{"DESCONTO","N" ,10,2})                                                       
If SX3->(DbSeek("C6_VALOR"))
	AADD(aDbStru,{"TOTALITEM",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"TOTALITEM", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("C6_DESCONT"))
	AADD(aDbStru,{"DESCONT",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"DESCONT", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("C6_NOTA"))
	AADD(aDbStru,{"NFISCAL",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"NFISCAL", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("C6_SERIE"))
	AADD(aDbStru,{"SERIENF",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"SERIENF", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("C6_NUM"))
	AADD(aDbStru,{"NUMPED",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"NUMPED", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("C6_COMIS1"))
	AADD(aDbStru,{"COMISSAO",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL})
	AADD(aCampos, {"COMISSAO", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("C6_TES"))
	AADD(aDbStru,{"TES",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"TES", SX3->X3_CAMPO})
EndIf

If SX3->(DbSeek("C6_ENTREG"))
	AADD(aDbStru,{"DTENTREG","C",8,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"DTENTREG", SX3->X3_CAMPO})
EndIf

If SX3->(DbSeek("C6_X_USRLB"))
	AADD(aDbStru,{"USRLIB",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, { "USRLIB", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("C6_BLQ"))
	AADD(aDbStru,{"BLOQ",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"BLOQ", SX3->X3_CAMPO})
EndIf

If SX3->(DbSeek("C6_LOCAL"))
	AADD(aDbStru,{"LOCAL",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"LOCAL", SX3->X3_CAMPO})
EndIf

If SX3->(DbSeek("C5_TIPO"))
	AADD(aDbStru,{"TIPOPED",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"TIPOPED", SX3->X3_CAMPO})
EndIf

If SX3->(DbSeek("C5_CONDPAG"))
	AADD(aDbStru,{"CONDPAG",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"CONDPAG", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("C5_TABELA"))
	AADD(aDbStru,{"TABELAPRC",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"TABELAPRC", SX3->X3_CAMPO})
EndIf

If SX3->(DbSeek("C5_TRANSP"))
	AADD(aDbStru,{"TRANSPORT",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"TRANSPORT", SX3->X3_CAMPO})
EndIf

If SX3->(DbSeek("C5_EMISSAO"))
	AADD(aDbStru,{"EMISSAOC5","C" ,8,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"EMISSAOC5", SX3->X3_CAMPO})
EndIf

If SX3->(DbSeek("C5_PEDCLI"))
	AADD(aDbStru,{"PEDCLI",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"PEDCLI", SX3->X3_CAMPO})
EndIf                    

If SX3->(DbSeek("C9_DATALIB"))

	AADD(aDbStru,{"DATALIB","D", 8,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"DATALIB", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("C9_QTDLIB"))
	AADD(aDbStru,{"QTDLIBC9",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"QTDLIBC9", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("C9_BLOQUEI"))
	AADD(aDbStru,{"BLOQUEIOC9",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"BLOQUEIOC9", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("C9_BLCRED"))
	AADD(aDbStru,{"BLQCREDC9",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"BLQCREDC9", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("C9_BLEST"))
	AADD(aDbStru,{"BLEST",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"BLEST", SX3->X3_CAMPO})
EndIf

If SX3->(DbSeek("C9_DTLIBES"))

	AADD(aDbStru,{"DTLIBES", "C" ,8,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"DTLIBES", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("C9_ULIBCRD"))
	AADD(aDbStru,{"ULIBCRD",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"ULIBCRD", SX3->X3_CAMPO})
EndIf                       

If SX3->(DbSeek("ACA_DESCRI"))
	AADD(aDbStru,{"CANALVEND",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"CANALVEND", SX3->X3_CAMPO})
EndIf 

If SX3->(DbSeek("C9_DTLICRD"))
	AADD(aDbStru,{"DTLICRD",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"DTLICRD", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("Z1_DTENTRE"))
	AADD(aDbStru,{"DTENTRE",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"DTENTRE", SX3->X3_CAMPO})
EndIf
If SX3->(DbSeek("Z1_DTSAIDA"))
	AADD(aDbStru,{"DTSAIDA",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"DTSAIDA", SX3->X3_CAMPO})
EndIf

If SX3->(DbSeek("F2_PBRUTO"))
	AADD(aDbStru,{"PESOBRUTO",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"PESOBRUTO", SX3->X3_CAMPO})
EndIf

If SX3->(DbSeek("F2_DATAAG"))
	AADD(aDbStru,{"NF_DATAAG",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"NF_DATAAG", SX3->X3_CAMPO})
EndIf 

If SX3->(DbSeek("C5_DTAGEND"))
	AADD(aDbStru,{"PD_DTAGEND",SX3->X3_TIPO,SX3->X3_TAMANHO,SX3->X3_DECIMAL}) 
	AADD(aCampos, {"PD_DTAGEND", SX3->X3_CAMPO})
EndIf 



AADD(aDbStru,{"TOTITEMLIB","N",10, 0}) 
AADD(aCampos, {"TOTITEMLIB", " "})
 
AADD(aDbStru,{"TOTITEMPED","N",10, 0}) 
AADD(aCampos, {"TOTITEMPED", " "})

AADD(aDbStru,{"TOTITEMFAT","N",10, 0}) 
AADD(aCampos, {"TOTITEMFAT", " "})


 
AADD(aDbStru,{"CAPITAL","C",01, 0}) 
AADD(aCampos, {"CAPITAL", " "})
                                                                      

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
	Aviso("Nao foi possível criar a tabela temporárioa.")  
	Return
EndIf

MakeDir("C:\relatorios")

DbUseArea(.T.,"DBFCDXADS", "SYSTEM\" + CNOMEDBF,"DGPED",.T.,.F.)

If File("DGPED.cdx")
	fErase("DGPED.cdx")
endIf


If Select(clAlias) > 0
	dbSelectArea(clAlias)
	(clAlias)->(dbCloseArea())
Endif
   



_cQry:= " SELECT" 
_cQry+=  " A1_COD, A1_LOJA,A1_INSCR,"
_cQry+= " A1_NOME, A1_PESSOA, A1_NREDUZ, A1_EST, A1_MUN,A1_COD_MUN, A1_X_DESC , A1_VEND,"
_cQry+= " A3_COD, A3_NOME, A3_NREDUZ, A3_END, A3_GRPREP, A3_SUPER,"
_cQry+= " ACA_GRPREP, ACA_DESCRI,"
_cQry+= " A3_COD, A3_NOME, A3_NREDUZ, A3_END, A3_SUPER, A3_GRPREP,"
_cQry+= " C6_FILIAL,C6_ITEM, C6_DESCRI, B1_XDESC, B1_PUBLISH, B1_DESCCAT, C6_PRODUTO, C6_QTDVEN, C6_PRCTAB, C6_PRCVEN, C6_VALOR, C6_DESCONT, "
_cQry+= " C6_NOTA, C6_SERIE,C6_CLI, C6_LOJA, C6_NUM, C6_COMIS1,C6_TES,C6_ENTREG,C6_X_USRLB,"
_cQry+= " C6_BLQ, C6_BLOQUEI, C6_LOCAL,C6_QTDENT,C6_TPOPER,"
_cQry+= " C5_NUM, C5_TIPO, C5_CLIENTE, C5_LOJACLI, C5_CONDPAG,C5_TABELA, C5_VEND1,"
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


DbSelectArea("DGPED")
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
	If DGPED->(RecLock("DGPED",.T.))
		//If !Empty((clAlias)->C9_DATALIB)
		
		DGPED->(CAPITAL)  := IIF(Mycapitais((clAlias)->A1_COD_MUN, (clAlias)->A1_EST), "S","N") 
		DGPED->(TOTITEMLIB) := MyItensC9((clAlias)->C6_NUM) 
		DGPED->(PD_DTAGEND) := StoD((clAlias)->C5_DTAGEND)
		
		DGPED->(TOTITEMPED) := MyItensPed((clAlias)->C6_NUM )
		DGPED->(TOTITEMLIB) := MyItensC9((clAlias)->C6_NUM )
		DGPED->(TOTITEMFAT) := MyItensD2((clAlias)->C6_NUM )
		
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
		
		DGPED->(QUANTIDADE)	:= 	nQtdLib
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
        DGPED->(EMISSAOC5)		:= (clAlias)->C5_EMISSAO 
        DGPED->(PEDCLI)			:= (clAlias)->C5_PEDCLI
        DGPED->(DATALIB)		:= StoD((clAlias)->C9_DATALIB) 
        DGPED->(QTDLIBC9)	:= (clAlias)->C9_QTDLIB
        DGPED->(BLOQUEIOC9)	:= (clAlias)->C9_BLOQUEI  
        DGPED->(BLQCREDC9)	:= (clAlias)->C9_BLCRED 
    	DGPED->(BLEST) 		:= (clAlias)->C9_BLEST 
    	DGPED->(DTLIBES) 	:=	(clAlias)->C9_DTLIBES
    	DGPED->(ULIBCRD)		:= (clAlias)->C9_ULIBCRD
    	DGPED->(DTLICRD)    := StoD((clAlias)->C9_DTLICRD) 
    	
    	If SD2->(dbseek(xFilial("SD2") + (clAlias)->C6_NUM + (clAlias)->C6_ITEM))  
	    	If SZ1->(dbSeek(xFilial("SZ1")+SD2->D2_DOC+SD2->D2_SERIE+SD2->D2_CLIENTE+SD2->D2_LOJA))  
		    	DGPED->(DTENTRE)	:= SZ1->Z1_DTENTRE
		    	DGPED->(DTSAIDA)	:= SZ1->Z1_DTSAIDA 
		    	DGPED->(EMISSANF)	:= SD2->D2_EMISSAO 
		    	DGPED->(QUANTIDADE)	:= SD2->D2_QUANT
		    EndIf
		EndIf
    	                     
		DGPED->(MsUnLock())
	EndIf
	(clAlias)->(dbSkip())
End


clQry := " SELECT D2_FILIAL, D2_LOJA,D2_QUANT,D2_CF,D2_EMISSAO, D2_DOC, D2_SERIE, D2_CLIENTE, D2_LOJA, D2_NUMSEQ,D2_COD, D2_LOCAL, D2_NUMSEQ,A1_NOME, A1_PESSOA,A1_NREDUZ,A1_X_DESC, A1_EST,A1_INSCR, C5_VEND1,C5_TIPO,C5_CONDPAG,C5_TABELA,C5_TRANSP,C5_DTAGEND, C5_EMISSAO,C5_PEDCLI, A1_MUN,A1_EST, A1_COD_MUN,  A3_NOME,A3_GRPREP, ACA_GRPREP, ACA_DESCRI, D2_TOTAL,D2_VALIPI ,D2_VALFRE, D2_SEGURO, D2_ICMSRET, D2_DESPESA,C6_ITEM,"
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
DbSetOrder(2)

DbSelectArea("SC9")
DbSetOrder(7) //C9_FILIAL+C9_PRODUTO+C9_LOCAL+C9_NUMSEQ   
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
		
		
		DGPED->(NF_DATAAG)	:= SF2->F2_DATAAG
		DGPED->(PD_DTAGEND)	:= StoD((cAliSD2)->C5_DTAGEND) 
		DGPED->(CAPITAL)  := IIF(Mycapitais((cAliSD2)->A1_COD_MUN, (cAliSD2)->A1_EST), "S","N") 
	
		
		DGPED->(TOTITEMPED) := MyItensPed((cAliSD2)->C6_NUM )
		DGPED->(TOTITEMLIB) := MyItensC9((cAliSD2)->C6_NUM )
		DGPED->(TOTITEMFAT) := MyItensD2((cAliSD2)->C6_NUM )
		DGPED->(FILIAL) 	:= (cAliSD2)->C6_FILIAL 
		DGPED->(SITUACAO)	:= "FATURADO" 
		DGPED->(QUANTIDADE)	:= (cAliSD2)->D2_QUANT
		DGPED->(VLRPEDIDO)	:= (cAliSD2)->D2_TOTAL +(cAliSD2)->D2_VALIPI + (cAliSD2)->D2_VALFRE + (cAliSD2)->D2_SEGURO + (cAliSD2)->D2_ICMSRET + (cAliSD2)->D2_DESPESA
		DGPED->(D2CFOP)		:= (cAliSD2)->D2_CF
		DGPED->(TPOPER)		:= (cAliSD2)->C6_TPOPER
		//DGPED->(C5CODBL)	:= (cAliSD2)->C5_CODBL
	   	DGPED->(NFFAT)		:= (cAliSD2)->D2_DOC
		DGPED->(SERIEFAT)	:= (cAliSD2)->D2_SERIE 
		DGPED->(EMISSANF)	:= StoD((cAliSD2)->D2_EMISSAO)
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
        DGPED->(EMISSAOC5)		:= (cAliSD2)->C5_EMISSAO 
        DGPED->(PEDCLI)			:= (cAliSD2)->C5_PEDCLI
        If SC9->(DbSeek(xFilial("SC9") + (cAliSD2)->D2_COD+(cAliSD2)->D2_LOCAL+(cAliSD2)->D2_NUMSEQ )) 
        	//DGPED->(TOTITEMLIB) := 1    
        	DGPED->(DATALIB)	:= SC9->C9_DATALIB 
        	DGPED->(QTDLIBC9)	:= SC9->C9_QTDLIB
        	DGPED->(BLOQUEIOC9)	:= SC9->C9_BLOQUEI  
        	DGPED->(BLQCREDC9)	:= SC9->C9_BLCRED 
    		DGPED->(BLEST) 		:= SC9->C9_BLEST 
    		DGPED->(DTLIBES) 	:= DtoS(SC9->C9_DTLIBES)
    		DGPED->(ULIBCRD)	:= SC9->C9_ULIBCRD
    		DGPED->(DTLICRD)    := SC9->C9_DTLICRD
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
    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
    //³Esta Rotina adiciona a cQuery os campos retornados na string de filtro do  |
    //³ponto de entrada MR580FIL.                                                 |
    //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	   
    



cSqlDev := " SELECT SD1.*, F1_EMISSAO, F1_DOC, F1_SERIE, F1_FORNECE, F1_LOJA, F1_FRETE, F1_DESPESA, F1_SEGURO, F1_ICMSRET, F1_EST, F1_COND,"
cSqlDev += " F1_DTDIGIT,F2_DOC, F2_SERIE, F2_EMISSAO, F2_CLIENTE, F2_LOJA, F2_VEND1, F1_TXMOEDA, F1_MOEDA, F1_FORMUL, A3_NOME, A3_GRPREP, ACA_DESCRI, B1_XDESC, B1_PLATAF, B1_DESCCAT, B1_PUBLISH,A1_INSCR,A1_EST,A1_COD_MUN,A1_X_DESC, A1_NREDUZ,A1_PESSOA, A1_MUN,  A1_NOME " + cAddField
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
		DGPED->(QUANTIDADE)	:= -((cAliasSD1)->D1_QUANT)
		DGPED->(VLRPEDIDO)	:= -((cAliasSD1)->D1_TOTAL +(cAliasSD1)->D1_VALIPI + (cAliasSD1)->D1_VALFRE + (cAliasSD1)->D1_SEGURO + (cAliasSD1)->D1_ICMSRET + (cAliasSD1)->D1_DESPESA )
		DGPED->(D2CFOP)		:= (cAliasSD1)->D1_CF
		DGPED->(CAPITAL)  := IIF(Mycapitais((cAliasSD1)->A1_COD_MUN, (cAliasSD1)->A1_EST), "S","N")  
	
		//DGPED->(TPOPER)		:= (cAliasSD1)->C6_TPOPER
		//DGPED->(C5CODBL)	:= (cAliasSD1)->C5_CODBL
	   	DGPED->(NFFAT)		:= (cAliasSD1)->D1_DOC
		DGPED->(SERIEFAT)	:= (cAliasSD1)->D1_SERIE 
		DGPED->(EMISSANF)	:= StoD((cAliasSD1)->D1_DTDIGIT)
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
        //	DGPED->(BLQCREDC9)	:= SC9->C9_BLCRED 
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




//*************************************

	 

dbSelectArea("DGPED")
dbCloseArea()

//COPY FILE ("SYSTEM\" + CNOMEDBF + ".dbf") TO ("XLSNC\" + CNOMEDBF + ".dbf") 
CPYS2T("\SYSTEM\" + CNOMEDBF + ".dbf","C:\relatorios",.T.)
fErase("SYSTEM\" + CNOMEDBF +GetDBExtension()) 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Restaura a integridade dos dados                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SF2")
dbClearFilter()
dbSetOrder(1)


Return
	
	
	
	/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³DBMCRIASX1ºAutor  ³ DBMS- Alberto      º Data ³ 27/02/2012  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Static Function para criacao de perguntas                  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function DBMCRIASX1()


PutSx1("DBM_VISPED","01","Emissao Pedido de"	   		,"Emissao Pedido de"			,"Emissao Pedido de"  		,"mv_ch1","D",08,0,1,"G","",""   ,"","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
PutSx1("DBM_VISPED","02","Emissao Pedido Ate"	   		,"Emissao Pedido Ate"			,"Emissao Pedido Ate"  		,"mv_ch2","D",08,0,1,"G","",""   ,"","","mv_par02","","","","","","","","","","","","","","","","",{},{},{})
PutSx1("DBM_VISPED","03","Data Faturamento de"	   		,"Data Faturamento de"			,"Data Faturamento de"  		,"mv_ch3","D",08,0,1,"G","",""   ,"","","mv_par03","","","","","","","","","","","","","","","","",{},{},{})
PutSx1("DBM_VISPED","04","Data Faturamento Ate"	   		,"Data Faturamento Ate"			,"Data Faturamento Ate"  		,"mv_ch4","D",08,0,1,"G","",""   ,"","","mv_par04","","","","","","","","","","","","","","","","",{},{},{})


Return  
	
	
/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MyNewSX6  ºAutor  ³Almir Bandina       º Data ³  10/02/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescrição ³Atualiza o arquivo de parâmetros.                           º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³NCGAMES - TECNOLOGIA DA INFORMAÇÃO                              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametro ³ExpC1 = Nome do Parâmetro                                   º±±
±±º          ³ExpX1 = Conteúdo do Parâmetro           	                  º±±
±±º          ³ExpC2 = Tipo do Parâmetro                                   º±±
±±º          ³ExpC3 = Descrição em portugues                              º±±
±±º          ³ExpC4 = Descrição em espanhol                               º±±
±±º          ³ExpC5 = Descrição em ingles                                 º±±
±±º          ³ExpL1 = Grava o conteúdo se existir o parâmetro             º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
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
	Case cCodmun == "04302"	.And. cUf == "AL" //Maceió	AL
		llRet := .T.
	Case cCodmun == "00303" .And. cUf == "AP" //		Macapá	AP 
		llRet := .T.
	Case cCodmun == "02603" .And. cUf == "AM" //	Manaus	AM  
		llRet := .T.
	Case cCodmun == "27408" .And. cUf == "BA" //	Salvador	BA 
		llRet := .T.
	Case cCodmun == "04400" .And. cUf == "CE" //	Fortaleza	CE 
		llRet := .T.
	Case cCodmun == "00108" .And. cUf == "DF" //		Brasília	DF
		llRet := .T.
	Case cCodmun == "05309" .And. cUf == "ES" //	Vitória	ES
		llRet := .T.
	Case cCodmun == "06200" .And. cUf == "GO" //	Goiânia	GO 
		llRet := .T.
	Case cCodmun == "11300" .And. cUf == "MA" //	São Luiz	MA
		llRet := .T.
	Case cCodmun == "03403" .And. cUf == "MT" //	Cuiabá	MT 
		llRet := .T.
	Case cCodmun == "02704" .And. cUf == "MS" //	Campo Grande	MS
		llRet := .T.
	Case cCodmun == "06200" .And. cUf == "MG" //	Belo Horizonte	MG
		llRet := .T.
	Case cCodmun == "06902" .And. cUf == "PR" //	Curitiba	PR
		llRet := .T.
	Case cCodmun == "07507" .And. cUf == "PB" //	João Pessoa	PB
		llRet := .T.
	Case cCodmun == "01402" .And. cUf == "PA" //	Belém	PA 
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
	Case cCodmun == "05407" .And. cUf == "SC" //	Florianópolis	SC
		llRet := .T.
	Case cCodmun == "00308" .And. cUf == "SE" //		Aracajú	SE
		llRet := .T.
	Case cCodmun == "50308" .And. cUf == "SP" //	São Paulo	SP
		llRet := .T.
	Case cCodmun == "21000" .And. cUf == "TO" //	Palmas	TO
		llRet := .T.
EndCase

Return llRet
