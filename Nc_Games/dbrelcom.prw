#Include "MATR580.CH"
#Include "FIVEWIN.Ch"
#INCLUDE "protheus.ch"
#Include "TBICONN.CH"  
#INCLUDE "TOPCONN.CH" 

#DEFINE CRLF Chr(13)+Chr(10)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³DBRELCOM º Autor ³ THIAGO QUEIROZ     º Data ³  15/09/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ RELATORIO PARA IMPRESSCAO DE DESCONTO ANALITICO/SINTETICO  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP6 IDE                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function DBRELCOM(aldata)

Local nOrdem		 := 1
Local aOrd           := {}
Local aTam			 := {}

Local nX := 0
Local nli := 0

//VARIAVEIS PROGRAMA MRAGEM

Local cEstoq 	:= ""
Local cDupli 	:= ""//If( (MV_PAR08 == 1),"S",If( (MV_PAR08 == 2),"N","SN" ) )
Local aCampos 	:= {}
Local nAg1		:= 0,nAg2:=0,nAg3:=0
Local nMoeda	:= ""
Local cMoeda	:= ""
Local nContador,nTOTAL,nVALICM,nVALIPI,QtdVend,NMEDIA
Local nVendedor	:= " "//Fa440CntVen()
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
Local dldtde	:= ""
Local dldtate	:= ""
Local cltime := "" 
Local ni	:= "" 

Private lAuto := IIF(Select("SM0") > 0, .f., .t.)
		
IF LAUTO
	QOUT("Preparando Environment ... "+DTOC(Date()) + " - "+Time())
	PREPARE ENVIRONMENT EMPRESA '01' FILIAL '03' TABLES 'SA1,SE1,SF4,SFM' //USER 'ADMIN' PASSWORD 'Ncg@m1' 
ENDIF

FOR nI:=1 TO LEN(ALDATA)
	IF VALTYPE(ALDATA[nI])== 'N'
		CONOUT(STR(ALDATA[nI]))
	ELSE
		CONOUT(ALDATA[nI])
	ENDIF		
NEXT nI
nVendedor	:= Fa440CntVen()


nOrdem    := 0 //If(MV_PAR05==1,3,1)  //1=Aglutina por cliente+loja, 3= Aglutina por cliente

Private CbTxt        := ""
Private nomeprog     := "RELDESC" // Coloque aqui o nome do programa para impressao no cabecalho
Private nTipo        := 18
Private nLastKey     := 0
Private cPerg        := "RDESCF"
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01
Private wnrel        := "RELDESC" // Coloque aqui o nome do arquivo usado para impressao em disco
//GERAL
Private nTotGeral 	:= 0	// TOTAL GERAL DE TODAS AS NF
Private nTotGeralv	:= 0	// TOTAL GERAL DE VENDAS
Private nTotGeralt	:= 0  // TOTAL GERAL DE TABELA
Private nTotGerale := 0  // TOTAL GERAL DE ESTADO
Private nPorcTot	:= 0  // % DESCONTO MEDIO DOS TOTAIS
// UNITARIO
Private nValTab  	:= 0  // VALOR TABELA
Private nValVend 	:= 0  // VALOR VENDA
Private nValEst		:= 0  // VALOR ESTADO
Private nPorcDesc	:= 0  // % DESCONTO
// TOTAL NOTA FISCAL
Private nTotNf 		:= 0	// TOTAL NF
Private nTotValv	:= 0	// TOTAL PREÇO DE VENDAS
Private nTotValt	:= 0	// TOTAL PREÇO DE TABELA
Private nTotVale	:= 0	// TOTAL PREÇO ESTADO
// TOTAL DIA
Private nTotDiaNF	:= 0 	// TOTAL NF/DIA
Private nTotDiav	:= 0	// TOTAL VENDA
Private nTotDiat	:= 0  // TOTAL TABELA
Private nTotDiae	:= 0  // TOTAL ESTADO
// TOTAL CLIENTE
Private nTotCliNF	:= 0	// TOTAL NF/CLIENTE
Private nTotCliv	:= 0	// TOTAL VENDA
Private nTotClit	:= 0  // TOTAL TABELA
Private nTotClie	:= 0  // TOTAL ESTADO
// NOTA FISCAL
Private cSerie		:= ""//(clAlias)->F2_SERIE
Private cData		:= ""//(clAlias)->F2_EMISSAO
Private cDoc 		:= ""//(clAlias)->D2_DOC
Private cCod 		:= ""//(clAlias)->D2_COD
// CONDIÇÃO DE PAGAMENTO
Private cCondc		:= ""//(clAlias)->F2_COND
Private cCond		:= ""//(clAlias)->E4_DESCRI
// CLIENTE
Private cCli			:= ""//(clAlias)->A1_COD
Private cLoja		:= ""//(clAlias)->A1_LOJA
Private cCliNR		:= ""//(clAlias)->A1_NREDUZ
Private nLoop		:= 1 // NÃO ESTÁ SENDO UTILIZADO
Private nQuebra		:= 1 // VARIAVEL QUE VERIFICA SE O CABEÇALHO JA FOI IMPRESSO
Private nLin
Private cQry1 := ""
Private cQry2 := ""
Private clAli1 := GetNextAlias()
Private  clAli2 := GetNextAlias()
Private alArea := {}
/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³PERGUNTAS RELATORIO     RDESCF                                       |                                                                                                                                        ³
|                                                                     |
| MV_PAR01 -> DA NOTA ?                                               |
| MV_PAR02 -> ATE NOTA ?                                              |
| MV_PAR03 -> DA SERIE ?                                              |
| MV_PAR04 -> ATE SERIE ?                                             |
| MV_PAR05 -> DA CLIENTE ?                                            |
| MV_PAR06 -> ATE CLIENTE ?                                           |
| MV_PAR07 -> DA LOJA ?                                               |
| MV_PAR08 -> ATE LOJA ?                                              |
| MV_PAR09 -> TIPO RELATORIO ?                                        |
| MV_PAR10 -> DO PRODUTO ?                                            |
| MV_PAR11 -> ATE PRODUTO ?                                           |
| MV_PAR12 -> DE DATA ?                                               |
| MV_PAR13 -> ATE DATA ?                                              |
| MV_PAR14 -> SINTETICO POR PERIODO OU PRODUTO ?                      |
| MV_PAR15 -> ORDENA POR GRUPO ?                                      |
|                                                                     |
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/

Private cString := "SF2"
Private aDbStru := {}
Private clAlias := GetNextAlias()

cl_PAR01 := "         "
cl_PAR02 := "ZZZZZZZZZ"
cl_PAR03 := "   "
cl_PAR04 := "ZZZ"
cl_PAR05 := "         "
cl_PAR06 := "ZZZZZZZZZ"
cl_PAR07 := "  "
cl_PAR08 := "ZZ"
cl_PAR09 := 1
cl_PAR10 := "              "
cl_PAR11 := "ZZZZZZZZZZZZZZZ" //ATE PRODUTO ?   
cl_par12 := ""
cl_Par13 := ""

Default alData := {}
 

If Len(alData) > 1
	If ValType(alData[1]) == "N" 
		cldata := StoD(AllTrim(Str(alData[1])))
		cldtate := StoD(AllTrim(Str(alData[2])))
	Else
		cldata := StoD(alData[1])
		cldtate := StoD(alData[2])
	EndIf
EndIf

If Empty(cldata) // = nil //,cldtate)
	cl_PAR12 := FirstDay(cldata)
	cl_PAR13 := cldtate //dlDtde //CtoD("01/05/2012") //DE DATA ?
//cl_PAR13 := dlDtAte //CtoD("30/05/2012") //ATE DATA ?
	dldtde	:= cl_PAR12
	dldtate	:= cl_PAR13
Else

	If VALTYPE(clData) == "N"
		clData := AllTrim(STR(clData))
		clDtAte := AllTrim(STR(clDtAte))	
	EndIf
	dldtde	:= cldata
	dldtate	:= cldtate 
	cl_PAR12 := dldtde	
	cl_PAR13 := dldtate	
EndIf


cl_PAR14 := 2 //SINTETICO POR PERIODO OU PRODUTO ?
cl_PAR15 := 1 // ORDENA POR GRUPO ?

dbSelectArea("SF2")
dbSetOrder(1)



dbSelectArea(cString)
dbSetOrder(1)


aDbStru := {} 


aTam:=TamSX3("A1_FILIAL")
AADD(aDbStru,{"FILIAL"  ,aTam[3],aTam[1],aTam[2]})

aTam:=TamSX3("F2_DOC")
AADD(aDbStru,{"DOC"      ,aTam[3],aTam[1],aTam[2]})

aTam:=TamSX3("F2_SERIE")
AADD(aDbStru,{"SERIE"    ,aTam[3],aTam[1],aTam[2]})

aTam:=TamSX3("A1_COD")
AADD(aDbStru,{"CODCLI"  ,aTam[3],aTam[1],aTam[2]})

aTam:= TamSX3("A1_LOJA")
AADD(aDbStru,{"LOJA"     ,aTam[3],aTam[1],aTam[2]})

aTam:=TamSX3("A1_NREDUZ")
AADD(aDbStru,{"CLIENTE"    ,aTam[3],aTam[1],aTam[2]})

aTam:=TamSX3("F2_EST")
AADD(aDbStru,{"UF"       ,aTam[3],aTam[1],aTam[2]})

aTam:=TamSX3("B1_COD")
AADD(aDbStru,{"PRODUTO"	,aTam[3],aTam[1],aTam[2] } )

aTam:=TamSX3("D2_ITEM")
AADD(aDbStru,{"D2ITEM",aTam[3],aTam[1],aTam[2]})

aTam:=TamSX3("F2_EMISSAO")
AADD(aDbStru,{"DATANF","D",aTam[1],aTam[2]})

AADD(aDbStru,{"ANO"   ,"C",4,0})
AADD(aDbStru,{"MES"   ,"C",2,0})
AADD(aDbStru,{"QUARTER" ,"C",2,0})

aTam:=TamSX3("F2_TIPO")
AADD(aDbStru,{"TIPONF"   ,aTam[3],aTam[1],aTam[2]})

aTam:=TamSX3("F1_MOTIVO")
If Len(aTam) == 0
	aTam := {30,0,"C"}
EndIf
AADD(aDbStru,{"MOTIVO"   ,aTam[3],aTam[1],aTam[2]})

aTam:=TamSX3("F1_JUSTIF")
If Len(aTam) == 0
	aTam := {30,0,"C"}
EndIf
AADD(aDbStru,{"JUSTIFICAT"   ,aTam[3],aTam[1],aTam[2]})

aTam:=TamSX3("F1_REFAT")
If Len(aTam) == 0
	aTam := {1,0,"C"}
EndIf
AADD(aDbStru,{"REFAT"   ,aTam[3],aTam[1],aTam[2]})



aTam:=TamSX3("D2_CF")
AADD(aDbStru,{"CFOP"     ,"C",aTam[1],aTam[2]})
//VENDEDORES
aTam:=TamSX3("A3_COD")
AADD(aDbStru,{"CODVEN1" ,aTam[3],aTam[1],aTam[2]})
AADD(aDbStru,{"CODVEN2" ,aTam[3],aTam[1],aTam[2]})
AADD(aDbStru,{"CODVEN3" ,aTam[3],aTam[1],aTam[2]})

aTam:=TamSX3("A3_NOME")
AADD(aDbStru,{"VEND1"    ,aTam[3],aTam[1],aTam[2]})
AADD(aDbStru,{"VEND2"    ,aTam[3],aTam[1],aTam[2]})
AADD(aDbStru,{"VEND3"    ,aTam[3],aTam[1],aTam[2]})

aTam:=TamSX3("A3_GRPREP")
If Len(aTam) == 0
	aTam := {6,0,"C"}
EndIf
AADD(aDbStru,{"GRPREP"    ,aTam[3],aTam[1],aTam[2]})
aTam:=TamSX3("ACA_DESCRI")
//AADD(aDbStru,{"CANALCLI"  ,aTam[3],aTam[1],aTam[2]})

//aTam:=TamSX3("ACA_DESCRI")
If Len(aTam) == 0
	aTam := {30,0,"C"}
EndIf
AADD(aDbStru,{"CANAL"    ,aTam[3],aTam[1],aTam[2]})
//	XLS->GRPREP		:= (clAlias)->A3_GRPREP
//	XLS->CANAL 	:= (clAlias)->ACA_DESCRI



aTam:=TamSX3("F2_COND")
AADD(aDbStru,{"CODPGTO"     ,aTam[3],aTam[1],aTam[2]})

aTam:=TamSX3("E4_DESCRI")
AADD(aDbStru,{"CONDPG"  ,aTam[3],aTam[1],aTam[2]})

aTam:=TamSX3("B1_XDESC")
If Len(aTam) == 0
	aTam := {12,0,"C"}
EndIf
AADD(aDbStru,{"TITULONC"  ,aTam[3],aTam[1],aTam[2]})

aTam:=TamSX3("Z5_PLATRED")
If Len(aTam) == 0
	aTam := {6,0,"C"}
EndIf
AADD(aDbStru,{"TB_PLATRED"	,aTam[3],aTam[1],aTam[2] } )

aTam:=TamSX3("B1_PUBLISH")
If Len(aTam) == 0
	aTam := {6,0,"C"}
EndIf
AADD(aDbStru,{"TB_PUBLISH",aTam[3],aTam[1],aTam[2] } )

AADD(aDbStru,{ "CATEGORIA"	,"C",15,0} )
AADD(aDbStru,{ "CAMPANHA"	,"C",15,0} )

aTam:=TamSX3("D2_QUANT")
AADD(aDbStru,{"QTDFAT"   ,aTam[3],aTam[1],aTam[2]})

aTam:=TamSX3("D2_PRCVEN")
AADD(aDbStru,{"PRCVEN"  ,aTam[3],aTam[1],aTam[2]})

aTam:=TamSX3("C6_PRCTAB")
If Len(aTam) == 0
	aTam := {15,2,"N"}
EndIf
AADD(aDbStru,{"PRCTAB"	,aTam[3],aTam[1],aTam[2]})

aTam:=TamSX3("C6_PRCTAB")
If Len(aTam) == 0
	aTam := {15,2,"N"}
EndIf
AADD(aDbStru,{"VALTAB"	,aTam[3],aTam[1],aTam[2]})

aTam:=TamSX3("C5_TABELA")
If Len(aTam) == 0
	aTam := {6,0,"C"}
EndIf
AADD(aDbStru,{"CODTAB"	,aTam[3],aTam[1],aTam[2]})

//AADD(aDbStru,{"CODTAB"   ,"C",003,0}) //AADD(aDbStru,{"VALEST"   ,"N",014,2})
//aTam:=TamSX3("D2_TOTAL")

//nPorcDesc := (((nValVend)/nValEst)*100) - 100

AADD(aDbStru,{"PORCDESC" ,"N",14,2}) //((Valor de venda/ valor de tabela) * 100) - 100

aTam:=TamSX3("D2_TOTAL")
AADD(aDbStru,{"VALVEND",aTam[3],aTam[1],aTam[2]})

aTam:=TamSX3("C6_REGDESC")
If Len(aTam) == 0
	aTam := {15,2,"N"}
EndIf
AADD(aDbStru,{"REGRADESC",aTam[3],aTam[1],aTam[2]})

aTam:=TamSX3("C6_PREGDES")
If Len(aTam) == 0
	aTam := {15,2,"N"}
EndIf
AADD(aDbStru,{"PREGRADESC",aTam[3],aTam[1],aTam[2]})

AADD(aDbStru,{"USUARIO"  ,"C",14,0})

aTam:=TamSX3("F2_VALBRUT")
AADD(aDbStru,{"VALFAT"	 ,aTam[3],aTam[1],aTam[2]})
//AADD(aDbStru,{"USUARIO"  ,"C",014    ,0      })

AADD(aDbStru,{"META"	 ,"N",aTam[1],aTam[2]})

aTam:=TamSX3("C5_NUM")
AADD(aDbStru,{"PEDIDO"	 ,aTam[3],aTam[1],aTam[2]})

aTam:=TamSX3("C6_ITEM")
AADD(aDbStru,{"ITEMPED"	 ,aTam[3],aTam[1],aTam[2]})



AADD(aDbStru,{"STATUSCML","C",20,0})





aTam:=TamSX3("F2_VALFAT")
AADD(aDbStru,{ "TB_VALOR1 ","N",aTam[1],aTam[2] } )

AADD(aDbStru,{ "TB_VALOR2 ","N",aTam[1],aTam[2] } )

AADD(aDbStru,{ "TB_ICMS ","N",aTam[1],aTam[2] } )

AADD(aDbStru,{ "TB_PIS ","N",aTam[1],aTam[2] } )

AADD(aDbStru,{ "TB_COFINS ","N",aTam[1],aTam[2] } )

AADD(aDbStru,{ "TB_IPI ","N",aTam[1],aTam[2] } )

AADD(aDbStru,{ "TB_ICMSRET ","N",aTam[1],aTam[2] } )

AADD(aDbStru,{ "TB_FRETE ","N",aTam[1],aTam[2] } )

AADD(aDbStru,{ "TB_SEGURO ","N",aTam[1],aTam[2] } )

AADD(aDbStru,{ "TB_DESPESA ","N",aTam[1],aTam[2] } )


AADD(aDbStru,{ "TB_VALOR11 ","N",aTam[1],aTam[2] } )

AADD(aDbStru,{ "TB_VALOR12 ","N",aTam[1],aTam[2] } )

AADD(aDbStru,{ "TB_VALOR13 ","N",aTam[1],aTam[2] } )

AADD(aDbStru,{ "TB_VALOR14 ","N",aTam[1],aTam[2] } )

AADD(aDbStru,{ "TB_VALOR15 ","N",aTam[1],aTam[2] } )

AADD(aDbStru,{ "TB_VALOR16 ","N",aTam[1],aTam[2] } )

AADD(aDbStru,{ "TB_VALOR17 ","N",aTam[1],aTam[2] } )

AADD(aDbStru,{ "TB_VALOR18 ","N",aTam[1],aTam[2] } )

AADD(aDbStru,{ "TB_VALOR19 ","N",aTam[1],aTam[2] } )

AADD(aDbStru,{ "TB_VALOR20 ","N",aTam[1],aTam[2] } )

AADD(aDbStru,{ "TB_CUSTUNI ","N",aTam[1],aTam[2] } )

AADD(aDbStru,{ "MARGBRU ","N",aTam[1],aTam[2] } )
AADD(aDbStru,{ "MARGBRUP ","N",aTam[1],aTam[2] } )
AADD(aDbStru,{ "MARKUP ","N",aTam[1],aTam[2] } )
AADD(aDbStru,{ "REGIAO","C",aTam[1],aTam[2] } )

 





//CRIA ARQ TEMPORARIO COMO DBF PARA O EXCEL PODER ABRIR
//cNomArq 	:= CriaTrab(aDbStru,.T.)
//GetNextAlias()
//CNOMEDBF := "RELDESC2"
//DBCREATE(CNOMEDBF,aDbStru,"DBFCDXADS")
//CRIA ARQ TEMPORARIO COMO DBF PARA O EXCEL PODER ABRIR
Do Case
	Case Month(CL_PAR12) < 4
   		CNOMEDBF := "NC"+STRZERO(YEAR(CL_PAR12),4) + "Q1"
 	Case Month(CL_PAR12) < 7 .And. Month(CL_PAR12) > 3
 		CNOMEDBF := "NC"+STRZERO(YEAR(CL_PAR12),4) + "Q2"
 	Case Month(CL_PAR12) < 10 .And. Month(CL_PAR12) > 6 
 		CNOMEDBF := "NC"+STRZERO(YEAR(CL_PAR12),4) + "Q3"
 	Case Month(CL_PAR12) > 9 
 		CNOMEDBF := "NC"+STRZERO(YEAR(CL_PAR12),4) + "Q4"
 EndCase

//CNOMEDBF := "NC" + STRZero(YEAR(dDataBase),4) + StrZero(Month(dDataBase),2)

//cArq := "\TESTE1\TESTE.TXT"
//nHdl := FCreate(cArq)
//fErase(cArq)

If Select("DGXLS") > 0
	DGXLS->(dbCloseArea())
EndIf

clTime := Time()
While ":" $ clTime
	clTime := Stuff(clTime,At(":",clTime),1,"")
End

CNOMEDBF := "NC" + STRZero(YEAR(dDataBase),4) + "Q3"

If File("XLSNC\" + CNOMEDBF + ".dbf")
	//fErase("XLSNC\" + CNOMEDBF +GetDBExtension())
	//COPY FILE ("XLSNC\" + CNOMEDBF + ".dbf") TO ("XLSNC\" + CNOMEDBF + SubStr(DtoS(Date()),5,4) + ".dbf")
	fErase("XLSNC\" + CNOMEDBF +GetDBExtension())
EndIf

DBCREATE(CNOMEDBF,aDbStru,"DBFCDXADS")
COPY FILE ("SYSTEM\" + CNOMEDBF + ".dbf") TO ("XLSNC\" + CNOMEDBF + ".dbf")
fErase("SYSTEM\" + CNOMEDBF +GetDBExtension())


DbUseArea(.T.,"DBFCDXADS","XLSNC\" + CNOMEDBF,"DGXLS",.T.,.F.)

//DbSelectArea("DGXLS")
//ZAP



//dbUseArea( .T.,"DBFCDXADS", cNomArq,"DGXLS", .T. , .F. )
//DbUseArea(.T.,"DBFCDXADS","SYSTEM\" + CNOMEDBF,"DGXLS",.T.,.F.)

If File("DGXLS.cdx")
	fErase("DGXLS.cdx")
endIf

Index On FILIAL+DOC+SERIE+CODCLI+LOJA+PRODUTO+D2ITEM TAG IND1 to DGXLS
DbSelectArea("DGXLS" )
dbSetORder(1)
//Index On FILIAL+CODCLI+PRODUTO 						 TAG IND2 to DGXLS

//cNomArq1 := Subs(cNomArq,1,7)+"A"
//IndRegua("DGXLS",cNomArq1,"CODCLI+LOJA+PRODUTO",,,STR0011)		//"Selecionando Registros..."
//IndRegua("DGXLS",cNomArq,"FILIAL+DOC+SERIE+CODCLI+LOJA+PRODUTO+D2ITEM",,,STR0011)		//"Selecionando Registros..."

//aTamVal 	:= TamSX3("F2_VALFAT")
//cNomArq2 := Subs(cNomArq,1,7)+"B"
//IndRegua("DGXLS",cNomArq,"(STRZERO(TB_ICMS,aTamVal[1],aTamVal[2]))",,,STR0011)		//"Selecionando Registros..."

//cNomArq3 := Subs(cNomArq,1,7)+"C"
//IndRegua("DGXLS",cNomArq,"FILIAL+CODCLI+PRODUTO",,,STR0011)		//"Selecionando Registros..."

//cNomArq4 := Subs(cNomArq,1,7)+"D"
//IndRegua("DGXLS",cNomArq,"FILIAL+CODCLI+LOJA+TB_PUBLISH+TB_PLATRED",,,STR0011)		//"Selecionando Registros..."
/*
dbSelectArea("DGXLS")
dbCloseArea()
fErase(cNomArq+GetDBExtension())
//fErase(cNomArq1+OrdBagExt())
//fErase(cNomArq2+OrdBagExt())
//fErase(cNomArq3+OrdBagExt())
//fErase(cNomArq4+OrdBagExt())
*/
//dbClearIndex()


//dbSetIndex(cNomArq1+OrdBagExt())
//dbSetIndex(cNomArq2+OrdBagExt())
//dbSetIndex(cNomArq3+OrdBagExt())
//dbSetIndex(cNomArq4+OrdBagExt())

If Select(clAlias) > 0
	dbSelectArea(clAlias)
	(clAlias)->(dbCloseArea())
Endif


_cQry:="	SELECT F2_FILIAL, F2_DOC, F2_SERIE, F2_COND, F2_EMISSAO, F2_VEND1, F2_VEND2, F2_VEND3, D2_ITEM, F2_YCANAL,"
_cQry+="		D2_DOC, D2_ITEM, D2_COD, D2_TOTAL, D2_QUANT, D2_PRCVEN, D2_VALIPI, D2_PICM, D2_EST, D2_TIPO, D2_CF,D2_PEDIDO, D2_ITEMPV,"
_cQry+="		F4_VENDA, D2_VALFRE, D2_SEGURO, D2_ICMSRET,"
_cQry+="		B1_DESC, B1_XDESC, B1_STACML,B1_PUBLISH,B1_PLATAF,"
_cQry+="		A1_COD, A1_LOJA, A1_NOME, A1_NREDUZ,A1_YCANAL, A1_YDCANAL,"
_cQry+="		ACA_DESCRI,"
_cQry+="		A3_COD, A3_NOME, A3_GRPREP,"
_cQry+="		C6_PRCVEN, C6_PRCTAB, C6_X_USRLB,"
_cQry+="		C5_FATURPV, C5_TABELA,"
_cQry+="		E4_DESCRI, C6_REGDESC, C6_PREGDES"
_cQry+="	FROM "+ RetSqlName("SF2")+" F2,
_cQry+="		"+ RetSqlName("SD2") +" D2,
_cQry+="		"+ RetSqlName("SF4") +" F4,
_cQry+="		"+ RetSqlName("SB1") +" B1,
_cQry+="		"+ RetSqlName("SA1") +" A1,
_cQry+="		"+ RetSqlName("SA3") +" A3,
_cQry+="		"+ RetSqlName("ACA") +" ACA,
_cQry+="		"+ RetSqlName("SC6") +" C6,
_cQry+="		"+ RetSqlName("SC5") +" C5,
_cQry+="		"+ RetSqlName("SE4") +" E4
_cQry+=" WHERE	D2_FILIAL = '" + xFilial("SD2") + "'"
_cQry+=" AND    F2_DOC >= '"     	+ALLTRIM(cl_PAR01)+ "' "
_cQry+=" AND 	F2_DOC <= '"     	+ALLTRIM(cl_PAR02)+ "' "
_cQry+=" AND  	F2_SERIE >= '" 	+ALLTRIM(cl_PAR03)+ "' "
_cQry+=" AND 	F2_SERIE <= '" 	+ALLTRIM(cl_PAR04)+ "' "
_cQry+=" AND  	F2_CLIENTE >= '" 	+ALLTRIM(cl_PAR05)+ "' "
_cQry+=" AND 	F2_CLIENTE <= '" 	+ALLTRIM(cl_PAR06)+ "' "
_cQry+=" AND  	F2_LOJA >= '" 		+ALLTRIM(cl_PAR07)+ "' "
_cQry+=" AND 	F2_LOJA <= '" 		+ALLTRIM(cl_PAR08)+ "' "
_cQry+=" AND  	D2_COD >= '" 		+ALLTRIM(cl_PAR10)+ "' "
_cQry+=" AND 	D2_COD <= '" 		+ALLTRIM(cl_PAR11)+ "' "
_cQry+=" AND  	F2_EMISSAO >= '" 	+DTOS(cl_PAR12)+ "' "
_cQry+=" AND 	F2_EMISSAO <= '" 	+DTOS(cl_PAR13)+ "' "
_cQry+=" AND  	F2_FILIAL 	= D2_FILIAL
_cQry+=" AND  	F2_FILIAL 	= C6_FILIAL
_cQry+=" AND  	C6_FILIAL 	= C5_FILIAL
_cQry+=" AND	F4_FILIAL	= '"+ xFilial("SF4") +"'
_cQry+=" AND  	F2_DOC 		= D2_DOC
_cQry+=" AND  	F2_SERIE 	= D2_SERIE
_cQry+=" AND  	D2_TES 		= F4_CODIGO
_cQry+=" AND	F4_DUPLIC 	= 'S'
_cQry+=" AND  	D2_COD 		= B1_COD
_cQry+=" AND  	F2_CLIENTE 	= A1_COD
_cQry+=" AND  	F2_LOJA 	= A1_LOJA
_cQry+=" AND  	F2_VEND1 	= A3_COD
_cQry+=" AND	A1_YCANAL 	= ACA_GRPREP
_cQry+=" AND  	D2_PEDIDO	= C6_NUM
_cQry+=" AND  	D2_ITEMPV	= C6_ITEM
_cQry+=" AND  	C6_NUM 		= C5_NUM
_cQry+=" AND	E4_CODIGO 	= F2_COND
_cQry+=" AND  	F2.D_E_L_E_T_ 	= ' '
_cQry+=" AND  	D2.D_E_L_E_T_ 	= ' '
_cQry+=" AND  	F4.D_E_L_E_T_ 	= ' '
_cQry+=" AND  	B1.D_E_L_E_T_ 	= ' '
_cQry+=" AND  	A1.D_E_L_E_T_ 	= ' '
_cQry+=" AND  	A3.D_E_L_E_T_ 	= ' '
_cQry+=" AND  	ACA.D_E_L_E_T_ 	= ' '
_cQry+=" AND  	C6.D_E_L_E_T_ 	= ' '
_cQry+=" AND  	C5.D_E_L_E_T_ 	= ' '
_cQry+=" AND  	E4.D_E_L_E_T_ 	= ' '

IF cl_PAR09 == 2 .AND. cl_PAR14 == 1
	_cQry+=" ORDER BY 	A1_COD, A1_LOJA, F2_EMISSAO, A3_GRPREP, A1_NOME, F2_DOC, F2_SERIE "
ELSEIF cl_PAR09 == 1 .AND. cl_PAR15 == 2
	_cQry+=" ORDER BY 	F2_DOC, F2_SERIE, F2_EMISSAO, A1_COD, A1_LOJA, A1_NOME, A3_GRPREP, D2_COD "
ELSEIF cl_PAR09 == 1 .AND. cl_PAR15 == 1
	_cQry+=" ORDER BY 	A3_GRPREP, F2_DOC, F2_SERIE, F2_EMISSAO, A1_COD, A1_LOJA, A1_NOME, D2_COD "
ELSE
	_cQry+=" ORDER BY 	F2_EMISSAO, A1_COD, A1_LOJA, A1_NOME, A3_GRPREP, D2_COD, F2_DOC, F2_SERIE "
ENDIF

//memowrit("RELDESC.sql",_cQry)
_cQry := ChangeQuery(_cQry)
dbUseArea(.T.,"TOPCONN",TCGENQRY(,,_cQry),clAlias, .T., .T.)
//dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cQry,.T.,.T.)


DBSELECTAREA(clAlias)
DBGOTOP()
cSerie		:= (clAlias)->F2_SERIE
cData		:= (clAlias)->F2_EMISSAO
cDoc 		:= (clAlias)->D2_DOC
cCod 		:= (clAlias)->D2_COD
// CONDIÇÃO DE PAGAMENTO
cCondc		:= (clAlias)->F2_COND
cCond		:= (clAlias)->E4_DESCRI
// CLIENTE
cCli			:= (clAlias)->A1_COD
cLoja		:= (clAlias)->A1_LOJA
cCliNR		:= (clAlias)->A1_NREDUZ


While !(clAlias)->(EOF())
	
	If DGXLS->(RECLOCK("DGXLS",.T.))
		
		// CAMPOS SQL X EXCEL
		DGXLS->FILIAL		:= (clAlias)->F2_FILIAL
		DGXLS->DOC		:= (clAlias)->F2_DOC
		DGXLS->SERIE     	:=            (clAlias)->F2_SERIE
		DGXLS->CODCLI		:= (clAlias)->A1_COD
		DGXLS->LOJA		:= (clAlias)->A1_LOJA
		DGXLS->CLIENTE       	:=            (clAlias)->A1_NREDUZ
		DGXLS->UF     		:=            (clAlias)->D2_EST
		DGXLS->PRODUTO     	:=            (clAlias)->D2_COD
		DGXLS->D2ITEM     	:=            (clAlias)->D2_ITEM
		DGXLS->DATANF			:= STOD((clAlias)->F2_EMISSAO)
		DGXLS->ANO			:= strzero(Year(STOD((clAlias)->F2_EMISSAO)),4)
		DGXLS->MES			:= STRZERO(MONTH(STOD((clAlias)->F2_EMISSAO)),2)
		If MONTH(STOD((clAlias)->F2_EMISSAO)) <= 3
			DGXLS->QUARTER		:= "Q1"
		ElseIf MONTH(STOD((clAlias)->F2_EMISSAO)) > 3 .And. MONTH(STOD((clAlias)->F2_EMISSAO)) <= 6
			DGXLS->QUARTER		:= "Q2"
		ElseIf MONTH(STOD((clAlias)->F2_EMISSAO)) > 6 .And. MONTH(STOD((clAlias)->F2_EMISSAO)) <= 9
			DGXLS->QUARTER		:= "Q3"
		ElseIf MONTH(STOD((clAlias)->F2_EMISSAO)) > 9 //.And. MONTH(STOD((clAlias)->F2_EMISSAO)) <= 12
			DGXLS->QUARTER		:= "Q4"
		EndIf
		
		DGXLS->TIPONF     	:= (clAlias)->D2_TIPO
		DGXLS->MOTIVO     	:= " "
		DGXLS->JUSTIFICAT	:= " "
		DGXLS->REFAT			:= " "
		DGXLS->CFOP			:=            (clAlias)->D2_CF
		DGXLS->CODVEN1     :=            (clAlias)->F2_VEND1
		DGXLS->CODVEN2     :=            (clAlias)->F2_VEND2
		DGXLS->CODVEN3     :=            (clAlias)->F2_VEND3
		DGXLS->VEND1		:=            (clAlias)->A3_NOME
		DGXLS->VEND2		:= 	" "
		DGXLS->VEND3		:=  " "
		//DGXLS->CANALCLI := (clAlias)->A1_YCANAL
		//CRIAR DESCRICAO
		DGXLS->GRPREP		:= (clAlias)->A3_GRPREP
		DGXLS->CANAL 	:= (clAlias)->ACA_DESCRI
		DGXLS->CODPGTO	:= (clAlias)->F2_COND
		DGXLS->CONDPG		:= (clAlias)->E4_DESCRI
		
		DGXLS->TITULONC	:= (clAlias)->B1_XDESC
		DGXLS->TB_PLATRED := (clAlias)->B1_PLATAF
		DGXLS->TB_PUBLISH	:= (clAlias)->B1_PUBLISH
		DGXLS->CATEGORIA	:= " "  // CARREGA DE OUTRA PLANILHA
		DGXLS->CAMPANHA	:= " " //CARREGA DE OUTRA PLANILHA DEFINIR REGRA
		DGXLS->QTDFAT		:= (clAlias)->D2_QUANT
		DGXLS->PRCVEN		:= (clAlias)->D2_PRCVEN
		DGXLS->PRCTAB		:= (clAlias)->C6_PRCTAB
		DGXLS->CODTAB	   	:= (clAlias)->C5_TABELA
		DGXLS->PORCDESC	:= (((clAlias)->D2_PRCVEN/(clAlias)->C6_PRCTAB) * 100) - 100
		DGXLS->VALVEND	:= (clAlias)->D2_PRCVEN * (clAlias)->D2_QUANT
		DGXLS->VALTAB		:= (clAlias)->C6_PRCTAB * (clAlias)->D2_QUANT
		DGXLS->REGRADESC	:= (clAlias)->C6_REGDESC
		DGXLS->PREGRADESC	:= (clAlias)->C6_PREGDES
		DGXLS->USUARIO   	:= (clAlias)->C6_X_USRLB //USUARIO QUE EMITIU O PEDIDO
		DGXLS->VALFAT		:= (clAlias)->(D2_VALFRE + D2_SEGURO + D2_ICMSRET + D2_VALIPI + D2_TOTAL)
		DGXLS->META		:= 0
		DGXLS->PEDIDO		:= (clAlias)->D2_PEDIDO
		DGXLS->ITEMPED	:= (clAlias)->D2_ITEMPV
		DGXLS->STATUSCML	:= " " //noacento(GETADVFVAL("SX5","X5_DESCRI",XFILIAL("SX5")+"ZX"+(clAlias)->B1_STACML,1,""))
		DGXLS->(MsUnLock())
	EndIf
	DBSELECTAREA(clAlias)
	dbSkip() // Avanca o ponteiro do registro no arquivo
EndDo



_cQry:="	SELECT F2_FILIAL, F2_DOC, F2_SERIE, F2_COND, F2_EMISSAO, F2_VEND1, F2_VEND2, F2_VEND3, D2_ITEM, F2_YCANAL,"
_cQry+="		D2_DOC, D2_ITEM, D2_COD, D2_TOTAL, D2_QUANT, D2_PRCVEN, D2_VALIPI, D2_PICM, D2_EST, D2_TIPO, D2_CF,D2_PEDIDO, D2_ITEMPV,"
_cQry+="		F4_VENDA, D2_VALFRE, D2_SEGURO, D2_ICMSRET,"
_cQry+="		B1_DESC, B1_XDESC, B1_STACML,B1_PUBLISH,B1_PLATAF,"
_cQry+="		A1_COD, A1_LOJA, A1_NOME, A1_NREDUZ,A1_YCANAL, A1_YDCANAL,"
_cQry+="		ACA_DESCRI,"
_cQry+="		A3_COD, A3_NOME, A3_GRPREP,"
_cQry+="		C6_PRCVEN, C6_PRCTAB, C6_X_USRLB,"
_cQry+="		C5_FATURPV, C5_TABELA,"
_cQry+="		E4_DESCRI, C6_REGDESC, C6_PREGDES"
_cQry+="	FROM "+ RetSqlName("SF2")+" F2,
_cQry+="		"+ RetSqlName("SD2") +" D2,
_cQry+="		"+ RetSqlName("SF4") +" F4,
_cQry+="		"+ RetSqlName("SB1") +" B1,
_cQry+="		"+ RetSqlName("SA1") +" A1,
_cQry+="		"+ RetSqlName("SA3") +" A3,
_cQry+="		"+ RetSqlName("ACA") +" ACA,
_cQry+="		"+ RetSqlName("SC6") +" C6,
_cQry+="		"+ RetSqlName("SC5") +" C5,
_cQry+="		"+ RetSqlName("SE4") +" E4
_cQry+=" WHERE	D2_FILIAL = '" + xFilial("SD2") + "'"
_cQry+=" AND    F2_DOC >= '"     	+ALLTRIM(cl_PAR01)+ "' "
_cQry+=" AND 	F2_DOC <= '"     	+ALLTRIM(cl_PAR02)+ "' "
_cQry+=" AND  	F2_SERIE >= '" 	+ALLTRIM(cl_PAR03)+ "' "
_cQry+=" AND 	F2_SERIE <= '" 	+ALLTRIM(cl_PAR04)+ "' "
_cQry+=" AND  	F2_CLIENTE >= '" 	+ALLTRIM(cl_PAR05)+ "' "
_cQry+=" AND 	F2_CLIENTE <= '" 	+ALLTRIM(cl_PAR06)+ "' "
_cQry+=" AND  	F2_LOJA >= '" 		+ALLTRIM(cl_PAR07)+ "' "
_cQry+=" AND 	F2_LOJA <= '" 		+ALLTRIM(cl_PAR08)+ "' "
_cQry+=" AND  	D2_COD >= '" 		+ALLTRIM(cl_PAR10)+ "' "
_cQry+=" AND 	D2_COD <= '" 		+ALLTRIM(cl_PAR11)+ "' "
_cQry+=" AND  	F2_EMISSAO >= '" 	+StrZero(Val(SubStr(DTOS(cl_PAR12),1,4))-1,4)+SubStr(DTOS(cl_PAR12),5,4) + "' "
_cQry+=" AND 	F2_EMISSAO <= '" 	+StrZero(Val(SubStr(DTOS(cl_PAR13),1,4))-1,4)+SubStr(DTOS(cl_PAR13),5,4) + "' "
_cQry+=" AND  	F2_FILIAL 	= D2_FILIAL
_cQry+=" AND  	F4_FILIAL 	= '"+ xFilial("SF4") +"'
_cQry+=" AND  	F2_DOC 		= D2_DOC
_cQry+=" AND  	F2_SERIE 	= D2_SERIE
_cQry+=" AND  	D2_TES 		= F4_CODIGO
_cQry+=" AND	F4_DUPLIC 	= 'S'
_cQry+=" AND  	D2_COD 		= B1_COD
_cQry+=" AND  	F2_CLIENTE 	= A1_COD
_cQry+=" AND  	F2_LOJA 	= A1_LOJA
_cQry+=" AND  	F2_VEND1 	= A3_COD
_cQry+=" AND	A1_YCANAL 	= ACA_GRPREP
_cQry+=" AND  	F2_FILIAL 	= C6_FILIAL
_cQry+=" AND  	D2_PEDIDO	= C6_NUM
_cQry+=" AND  	D2_ITEMPV	= C6_ITEM
_cQry+=" AND  	C6_FILIAL 	= C5_FILIAL
_cQry+=" AND  	C6_NUM 		= C5_NUM
_cQry+=" AND	E4_CODIGO 	= F2_COND
_cQry+=" AND  	F2.D_E_L_E_T_ 	= ' '
_cQry+=" AND  	D2.D_E_L_E_T_ 	= ' '
_cQry+=" AND  	F4.D_E_L_E_T_ 	= ' '
_cQry+=" AND  	B1.D_E_L_E_T_ 	= ' '
_cQry+=" AND  	A1.D_E_L_E_T_ 	= ' '
_cQry+=" AND  	A3.D_E_L_E_T_ 	= ' '
_cQry+=" AND  	ACA.D_E_L_E_T_ 	= ' '
_cQry+=" AND  	C6.D_E_L_E_T_ 	= ' '
_cQry+=" AND  	C5.D_E_L_E_T_ 	= ' '
_cQry+=" AND  	E4.D_E_L_E_T_ 	= ' '

//_cQry+=" GROUP BY F2_DOC,F2_SERIE, D2_DOC, D2_COD, B1_DESC, B1_XDESC, B1_STACML, D2_TOTAL, D2_QUANT, D2_PRCVEN, D2_VALIPI, D2_PICM, D2_VALFRE, D2_SEGURO, D2_ICMSRET,"
//_cQry+=" 				A1_COD, A1_LOJA, A1_NOME, A1_NREDUZ, D2_EST, F2_EMISSAO, D2_TIPO, D2_CF, F2_VEND1, ACA_DESCRI, "
//_cQry+=" 				A3_NOME, A3_GRPREP , F2_COND, C6_PRCVEN, C6_PRCTAB, E4_DESCRI, C6_X_USRLB, F4_VENDA, C5_FATURPV, C5_TABELA, D2_ITEM, C6_REGDESC, C6_PREGDES"
IF cl_PAR09 == 2 .AND. cl_PAR14 == 1
	_cQry+=" ORDER BY 	A1_COD, A1_LOJA, F2_EMISSAO, A3_GRPREP, A1_NOME, F2_DOC, F2_SERIE "
ELSEIF cl_PAR09 == 1 .AND. cl_PAR15 == 2
	_cQry+=" ORDER BY 	F2_DOC, F2_SERIE, F2_EMISSAO, A1_COD, A1_LOJA, A1_NOME, A3_GRPREP, D2_COD "
ELSEIF cl_PAR09 == 1 .AND. cl_PAR15 == 1
	_cQry+=" ORDER BY 	A3_GRPREP, F2_DOC, F2_SERIE, F2_EMISSAO, A1_COD, A1_LOJA, A1_NOME, D2_COD "
ELSE
	_cQry+=" ORDER BY 	F2_EMISSAO, A1_COD, A1_LOJA, A1_NOME, A3_GRPREP, D2_COD, F2_DOC, F2_SERIE "
ENDIF

//memowrit("RELDESC.sql",_cQry)
_cQry := ChangeQuery(_cQry)

If Select(clAlias) > 0
	(clAlias)->(dbCloseArea())
EndIf

dbUseArea(.T.,"TOPCONN",TCGENQRY(,,_cQry),clAlias, .T., .T.)
//dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cQry,.T.,.T.)


DBSELECTAREA(clAlias)
DBGOTOP()
cSerie		:= (clAlias)->F2_SERIE
cData		:= (clAlias)->F2_EMISSAO
cDoc 		:= (clAlias)->D2_DOC
cCod 		:= (clAlias)->D2_COD
// CONDIÇÃO DE PAGAMENTO
cCondc		:= (clAlias)->F2_COND
cCond		:= (clAlias)->E4_DESCRI
// CLIENTE
cCli			:= (clAlias)->A1_COD
cLoja		:= (clAlias)->A1_LOJA
cCliNR		:= (clAlias)->A1_NREDUZ


While !(clAlias)->(EOF())
	
	If DGXLS->(RECLOCK("DGXLS",.T.))
		
		// CAMPOS SQL X EXCEL
		DGXLS->FILIAL		:= (clAlias)->F2_FILIAL
		DGXLS->DOC		:= (clAlias)->F2_DOC
		DGXLS->SERIE     	:=            (clAlias)->F2_SERIE
		DGXLS->CODCLI		:= (clAlias)->A1_COD
		DGXLS->LOJA		:= (clAlias)->A1_LOJA
		DGXLS->CLIENTE       	:=            (clAlias)->A1_NREDUZ
		DGXLS->UF     		:=            (clAlias)->D2_EST
		DGXLS->PRODUTO     	:=            (clAlias)->D2_COD
		DGXLS->D2ITEM     	:=            (clAlias)->D2_ITEM
		DGXLS->DATANF			:= STOD((clAlias)->F2_EMISSAO)
		DGXLS->ANO			:= strzero(Year(STOD((clAlias)->F2_EMISSAO)),4)
		DGXLS->MES			:= STRZERO(MONTH(STOD((clAlias)->F2_EMISSAO)),2)
		If MONTH(STOD((clAlias)->F2_EMISSAO)) <= 3
			DGXLS->QUARTER		:= "Q1"
		ElseIf MONTH(STOD((clAlias)->F2_EMISSAO)) > 3 .And. MONTH(STOD((clAlias)->F2_EMISSAO)) <= 6
			DGXLS->QUARTER		:= "Q2"
		ElseIf MONTH(STOD((clAlias)->F2_EMISSAO)) > 6 .And. MONTH(STOD((clAlias)->F2_EMISSAO)) <= 9
			DGXLS->QUARTER		:= "Q3"
		ElseIf MONTH(STOD((clAlias)->F2_EMISSAO)) > 9 //.And. MONTH(STOD((clAlias)->F2_EMISSAO)) <= 12
			DGXLS->QUARTER		:= "Q4"
		EndIf
		
		DGXLS->TIPONF     	:= (clAlias)->D2_TIPO
		DGXLS->MOTIVO     	:= " "
		DGXLS->JUSTIFICAT	:= " "
		DGXLS->REFAT			:= " "
		DGXLS->CFOP			:=            (clAlias)->D2_CF
		DGXLS->CODVEN1     :=            (clAlias)->F2_VEND1
		DGXLS->CODVEN2     :=            (clAlias)->F2_VEND2
		DGXLS->CODVEN3     :=            (clAlias)->F2_VEND3
		DGXLS->VEND1		:=            (clAlias)->A3_NOME
		DGXLS->VEND2		:= 	" "
		DGXLS->VEND3		:=  " "
		//DGXLS->CANALCLI := (clAlias)->A1_YCANAL
		//CRIAR DESCRICAO
		DGXLS->GRPREP		:= (clAlias)->A3_GRPREP
		DGXLS->CANAL 	:= (clAlias)->ACA_DESCRI
		DGXLS->CODPGTO	:= (clAlias)->F2_COND
		DGXLS->CONDPG		:= (clAlias)->E4_DESCRI
		
		DGXLS->TITULONC	:= (clAlias)->B1_XDESC
		DGXLS->TB_PLATRED := (clAlias)->B1_PLATAF
		DGXLS->TB_PUBLISH	:= (clAlias)->B1_PUBLISH
		DGXLS->CATEGORIA	:= " "  // CARREGA DE OUTRA PLANILHA
		DGXLS->CAMPANHA	:= " " //CARREGA DE OUTRA PLANILHA DEFINIR REGRA
		DGXLS->QTDFAT		:= (clAlias)->D2_QUANT
		DGXLS->PRCVEN		:= (clAlias)->D2_PRCVEN
		DGXLS->PRCTAB		:= (clAlias)->C6_PRCTAB
		DGXLS->CODTAB	   	:= (clAlias)->C5_TABELA
		DGXLS->PORCDESC	:= (((clAlias)->D2_PRCVEN/(clAlias)->C6_PRCTAB) * 100) - 100
		DGXLS->VALVEND	:= (clAlias)->D2_PRCVEN * (clAlias)->D2_QUANT
		DGXLS->VALTAB		:= (clAlias)->C6_PRCTAB * (clAlias)->D2_QUANT
		DGXLS->REGRADESC	:= (clAlias)->C6_REGDESC
		DGXLS->PREGRADESC	:= (clAlias)->C6_PREGDES
		DGXLS->USUARIO   	:= (clAlias)->C6_X_USRLB //USUARIO QUE EMITIU O PEDIDO
		DGXLS->VALFAT		:= (clAlias)->(D2_VALFRE + D2_SEGURO + D2_ICMSRET + D2_VALIPI + D2_TOTAL)
		DGXLS->META		:= 0
		DGXLS->PEDIDO		:= (clAlias)->D2_PEDIDO
		DGXLS->ITEMPED	:= (clAlias)->D2_ITEMPV
		DGXLS->STATUSCML	:= " " //noacento(GETADVFVAL("SX5","X5_DESCRI",XFILIAL("SX5")+"ZX"+(clAlias)->B1_STACML,1,""))
		DGXLS->(MsUnLock())
	EndIf
	DBSELECTAREA(clAlias)
	dbSkip() // Avanca o ponteiro do registro no arquivo
EndDo



//********************************************************



CD_PAR01 := dldtde //CtoD("01/05/2012") //A partir da data ?"
CD_PAR02 := dldtate //CtoD("30/05/2012") //"Até a data ?
CD_PAR03 := "      " // Do cliente ?
CD_PAR04 := "ZZZZZZ" //"Até o cliente ?" )
CD_PAR05 := 1 //Aglutina por rede de lojas 1= SIM 2=NAO
CD_PAR06 := 1 //Qual a Moeda ?
CD_PAR07 := 1 //Considera Devoluções ? 1= Sim 2 = Não
CD_PAR08 := 1 //TES Qto Faturamento ?  1= GERA 2= NAO GERA 3 = AMBAS
CD_PAR09 := 3 //TES Qto Estoque ?      1= MOVIMENTA 2= NAO MOVIMENTA 3 = Considera Ambas
CD_PAR10 := 2 // Converte Moeda da Devolução ?  1 = Pela devolução 2 = Pela Dt.NF Orig
CD_PAR11 := 2 // Desconsidera os valores de frete, seguro 1 = SIM 2 = NAO
CD_PAR12 := "  " //Do Estado ?
CD_PAR13 := "ZZ" // Considera clientes até o Estado (UF) ?
CD_PAR14 := SPACE(15) //Considera os produtos de ?
CD_PAR15 := "ZZZZZZZZZZZZZZZ" //Até o produto ?
CD_PAR16 := SPACE(9)  // Considera o Publisher de ?
CD_PAR17 := "ZZZZZZZZZ"  // Considera o Publisher até ?
CD_PAR18 := SPACE(6) //Da Plataforma ?
CD_PAR19 := "ZZZZZZ" //Considera produtos até a Plataforma ?" )
CD_PAR20 := 1 //Calculo Devoluções 1 = Dt.de Digitacao 2 = Dt. NF original




cEstoq 	:= If( (CD_PAR09 == 1),"S",If( (CD_PAR09 == 2),"N","SN" ) )
cDupli 	:= If( (CD_PAR08 == 1),"S",If( (CD_PAR08 == 2),"N","SN" ) )
nOrdem    := If(CD_PAR05==1,3,1)  //1=Aglutina por cliente+loja, 3= Aglutina por cliente



Private cCampImp
Private aTamVal:= { 16, 2 }
Private nDecs:=msdecimais(CD_par06)

If lMR580FIL
	aFilUsrSF1 := ExecBlock("MR580FIL",.F.,.F.,aReturn[7])
EndIf



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
		cWhereAux += "(" + cCampo + " between '" + CD_par03 + "' and '" + CD_par04 + "') or "
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
/*
BeginSql Alias cAliasSD2
SELECT  SD2.*, F2_EMISSAO, F2_TIPO, F2_COND,F2_DOC, F2_FRETE, F2_SEGURO, F2_DESPESA, F2_FRETAUT, F2_ICMSRET,
F2_TXMOEDA, F2_MOEDA %Exp:cAddField%
FROM %Table:SD2% SD2, %Table:SF4% SF4, %Table:SF2% SF2
WHERE D2_FILIAL  = %xFilial:SD2%
AND D2_EMISSAO between %Exp:DTOS(CD_par01)% AND %Exp:DTOS(CD_par02)%
AND F2_EST between %Exp:CD_par12% AND %Exp:CD_par13%
AND D2_COD between %Exp:CD_par14% AND %Exp:CD_par15%
AND D2_TIPO NOT IN ('D', 'B')
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
ORDER BY D2_FILIAL,D2_EMISSAO,D2_NUMSEQ
EndSql
*/

clQry1 := " SELECT  SD2.*, F2_EMISSAO, F2_TIPO, F2_COND,F2_DOC, F2_FRETE, F2_SEGURO, F2_DESPESA, F2_FRETAUT, F2_ICMSRET,"
clQry1 += " F2_TXMOEDA, F2_MOEDA " + SubStr(cAddField,2,Len(cAddField)-2)
clQry1 += " FROM " + retSqlName("SD2") + " SD2, " + RetSqlName("SF4") + " SF4, " +RetSqlName("SF2") + " SF2"
clQry1 += " WHERE D2_FILIAL  = '" + xFilial("SD2") +"'"
clQry1 += " AND D2_EMISSAO between '" + DtoS(CD_par01) + "' AND '" + DTOS(CD_par02) + "'"
clQry1 += " AND F2_EST between '" + CD_par12 + "' AND '" + CD_par13 + "'"
clQry1 += " AND D2_COD between '" + CD_par14 + "' AND '" + CD_par15 + "'"
clQry1 += " AND D2_TIPO NOT IN ('D', 'B') "
clQry1 += " AND F2_FILIAL  = '" + xFilial("SF2") + "'"
clQry1 += " AND D2_DOC     = F2_DOC"
clQry1 += " AND D2_SERIE   = F2_SERIE"
clQry1 += " AND D2_CLIENTE = F2_CLIENTE"
clQry1 += " AND D2_LOJA    = F2_LOJA"
clQry1 += " AND F4_FILIAL  = '"  + xFilial("SF4") + "' "
clQry1 += " AND F4_CODIGO  = D2_TES"
clQry1 += " AND SD2.D_E_L_E_T_ = ' '" //%notdel%
clQry1 += " AND SF2.D_E_L_E_T_ = ' '" //%notdel%
clQry1 += " AND SD2.D_E_L_E_T_ = ' '" //%notdel%
clQry1 += " AND SF4.D_E_L_E_T_ = ' '" //%notdel%
clQry1 += " AND " + SubStr(cWhere,2,Len(cWhere)-2)
clQry1 += " ORDER BY D2_FILIAL,D2_EMISSAO,D2_NUMSEQ"

clQry1 := ChangeQuery(clQry1)
dbUseArea(.T.,"TOPCONN",TCGENQRY(,,clQry1),cAliasSD2, .T., .T.)
dbGoTop()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Processa Faturamento                                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nTotVal2:= 0
nTotFre	:= 0
nTotSeg	:= 0
nTotDes := 0

nOrdem := 1 //Sempre pela ordem 1

DbSelectArea("SB1")
SB1->(dbSetOrder(1))
DbSelectArea("SA1")
SA1->(dBSetOrder(1))
DbSelectArea("SA3")
SA3->(DbSetOrder(1))
DbSelectArea("SC6")
SC6->(dbSetOrder(1))
DbSelectArea("SZ5")
SZ5->(DbSetOrder(1))
DbSelectArea("SE4")
SE4->(dbSetOrder(1))
While !(cAliasSD2)->(Eof())
	
	nTOTAL  :=0
	nVALICM :=0
	nVALIPI :=0
	nQtdVend:= 0
	NMEDIA	:= 0
	
	cCodPro	:= (cAliasSD2)->D2_COD
	SB1->(DbSeek(xFilial("SB1") + cCodPro ))
	cPublish:= SB1->B1_PUBLISH //getadvfval("SB1","B1_PUBLISH",xFilial("SB1")+cCodPro,1,"")
	cItemCC	:= SB1->B1_ITEMCC //getadvfval("SB1","B1_ITEMCC",xFilial("SB1")+cCodPro,1,"")
	cCdPlat	:= SB1->B1_PLATAF //getadvfval("SB1","B1_PLATAF",xFilial("SB1")+cCodPro,1,"")
	cDescPro:= SB1->B1_XDESC //"getadvfval("SB1","B1_XDESC",xFilial("SB1")+cCodPro,1,"")
	//Campos buscados do cadastro de produtos e não da tabela SD2 propositalmente
	If !(cItemCC >= CD_par16 .and. cItemCC <= CD_par17 .and. cCdPlat >= CD_par18 .and. cCdPlat <= CD_par19)
		(cAliasSD2)->(dbSkip())
		loop
	EndIf
	
	cPlataf := " "
	
	If SZ5->(dbSeek(xFilial("SZ5")+SUBSTR(cCdPlat,1,6)) )
		cPlataf	:= SZ5->Z5_PLATRED //getadvfval("SZ5","Z5_PLATRED",xFilial("SZ5")+SUBSTR(cCdPlat,1,6),1,"")
	EndIf
	
	cCodcli	:= (cAliasSD2)->D2_CLIENTE
	cLjcli	:= (cAliasSD2)->D2_LOJA
	SA1->(dbSeek(xFilial("SA1") + cCodcli+cLjcli))
	cUF		:= SA1->A1_EST  //getadvfval("SA1","A1_EST",xFilial("SA1")+cCodcli+cLjcli,1,"")
	cNome	:= SA1->A1_NREDUZ //getadvfval("SA1","A1_NREDUZ",xFilial("SA1")+cCodcli+cLjcli,1,"")
	cycanal	:= SA1->A1_YCANAL //getadvfval("SA1","A1_YCANAL",xFilial("SA1")+cCodcli+cLjcli,1,"")
	cyDcanal:= SA1->A1_YDCANAL //getadvfval("SA1","A1_YDCANAL",xFilial("SA1")+cCodcli+cLjcli,1,"")
	nTaxa	:=	IIf((cAliasSD2)->(FieldPos("F2_TXMOEDA"))>0,(cAliasSD2)->F2_TXMOEDA,0)
	nMoedNF	:=	IIf((cAliasSD2)->(FieldPos("F2_MOEDA"))>0,(cAliasSD2)->F2_MOEDA,0)
	
	clVend1 := " "
	clvend2 := " "
	clVend3 := " "
	If SA3->(dbSeek(xFilial("SA3")+(cAliasSD2)->F2_VEND1))
		clVend1 := SA3->A3_NOME //getadvfval("SA3","A3_NOME",xFilial("SA3")+(cAliasSD2)->F2_VEND1,1,"")
	EndIf
	If SA3->(DbSeek(xFilial("SA3")+(cAliasSD2)->F2_VEND2))
		clVend2 := SA3->A3_NOME // getadvfval("SA3","A3_NOME",xFilial("SA3")+(cAliasSD2)->F2_VEND2,1,"")
	EndIf
	If SA3->(dbseek(xFilial("SA3")+(cAliasSD2)->F2_VEND3))
		clVend3 := SA3->A3_NOME //getadvfval("SA3","A3_NOME",xFilial("SA3")+(cAliasSD2)->F2_VEND3,1,"")
	EndIf
	clCondPg := " " //
	If SE4->(dbSeek(xFilial("SE4")+(cAliasSD2)->F2_COND))
		clCondpg := SE4->E4_DESCRI //getadvfval("SE4","E4_DESCRI",xFilial("SE4")+(cAliasSD2)->F2_COND,1,"")
	EndIf
	SC6->(dbSeek(xFilial("SC6")+(cAliasSD2)->D2_PEDIDO + (cAliasSD2)->D2_ITEMPV))
	clUSER := SC6->C6_X_USRLBI //getadvfval("SC6","C6_X_USRLBI",xFilial("SC6")+(cAliasSD2)->D2_PEDIDO + (cAliasSD2)->D2_ITEMPV,1,"")
	nlPrcTab := SC6->C6_PRCTAB //getadvfval("SC6","C6_PRCTAB",xFilial("SC6")+(cAliasSD2)->D2_PEDIDO + (cAliasSD2)->D2_ITEMPV,1,"")
	clRegradesc := SC6->C6_REGDESC //getadvfval("SC6","C6_REGDESC",xFilial("SC6")+(cAliasSD2)->D2_PEDIDO + (cAliasSD2)->D2_ITEMPV,1,"")
	nlPRegrades := SC6->C6_PREGDES //getadvfval("SC6","C6_PREGDES",xFilial("SC6")+(cAliasSD2)->D2_PEDIDO + (cAliasSD2)->D2_ITEMPV,1,"")
	clTabela := getadvfval("SC5","C5_TABELA",xFilial("SC5")+(cAliasSD2)->D2_PEDIDO ,1,"")
	
	// Considera Adicionais
	nAdic 	:= 0
	nFrete	:= (cAliasSD2)->D2_VALFRE
	nSeguro	:= (cAliasSD2)->D2_SEGURO
	nDespesa:= (cAliasSD2)->D2_DESPESA
	
	
	//nValor2  := (cAliasSD2)->D2_ICMSRET //xMoeda(/*(cAliasSD2)->F2_FRETAUT+*/(cAliasSD2)->D2_ICMSRET,nMoedNF,CD_par06,(cAliasSD2)->F2_EMISSAO,nDecs+1,nTaxa)
	
	
	If AvalTes((cAliasSD2)->D2_TES,cEstoq,cDupli)
		nAdic := 0
		nValor2  := 0
		nVALICM += (cAliasSD2)->D2_VALICM //xMoeda((cAliasSD2)->D2_VALICM,1,CD_par06,(cAliasSD2)->D2_EMISSAO,nDecs+1)
		nVALIPI += (cAliasSD2)->D2_VALIPI //xMoeda((cAliasSD2)->D2_VALIPI,1,CD_par06,(cAliasSD2)->D2_EMISSAO,nDecs+1)
		nTotal	+=	xMoeda((cAliasSD2)->D2_TOTAL,nMoedNF,CD_par06,(cAliasSD2)->D2_EMISSAO,nDecs+1,nTaxa)
		nQtdVend+= (cAliasSD2)->D2_QUANT
		nValor2  := (cAliasSD2)->D2_ICMSRET //xMoeda(/*(cAliasSD2)->F2_FRETAUT+*/(cAliasSD2)->D2_ICMSRET,nMoedNF,CD_par06,(cAliasSD2)->F2_EMISSAO,nDecs+1,nTaxa)
		
		
		
		If ( nTotal <> 0 )
			cVendedor := "1"
			
			//For nContador := 1 To nVendedor
			dbSelectArea("DGXLS")
			dbSetOrder(nOrdem)
			//cVend := (cAliasSD2)->(FieldGet(FieldPos("F2_VEND"+cVendedor)))
			cVendedor := Soma1(cVendedor,1)
			If cCodcli >= CD_par03 .And. cCodcli <= CD_par04
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Se vendedor em branco, considera apenas 1 vez        ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				//If Empty(cVend) .and. nContador > 1
				//	Loop
				//Endif
				
				If ( aScan(aVend,cVend)==0 )
					Aadd(aVend,cVend)
				EndIf
				
				If nOrdem == 1
					//If (dbSeek( cCodcli+cLjcli+cCodPro )) //CD_par05
					DbSelectArea("DGXLS")
					DbSetOrder(1)
					If CD_par11 == 2
						//xMoeda((cAliasSD1)->F1_FRETE+(cAliasSD1)->F1_DESPESA+(cAliasSD1)->F1_SEGURO,1,mv_par06,DtMoedaDev,nDecs+1)
						nAdic := xMoeda((cAliasSD2)->D2_VALFRE+(cAliasSD2)->D2_SEGURO+(cAliasSD2)->D2_DESPESA,nMoedNF,CD_par06,(cAliasSD2)->F2_EMISSAO,nDecs+1,nTaxa)
					EndIf
					
					
					If DGXLS->(dbSeek((cAliasSD2)->D2_FILIAL+(cAliasSD2)->D2_DOC+(cAliasSD2)->D2_SERIE+(cAliasSD2)->D2_CLIENTE+(cAliasSD2)->D2_LOJA+(cAliasSD2)->D2_COD +(cAliasSD2)->D2_ITEM))
						If RecLock("DGXLS",.F.)
							Replace DGXLS->TB_VALOR1  With TB_VALOR1+nQtdVend  //quantidade vendida
							Replace DGXLS->TB_VALOR2  With TB_VALOR2+IIF((cAliasSD2)->F2_TIPO == "P",0,nTotal)+nVALIPI+nValor2+nAdic //Valor total
							Replace DGXLS->TB_ICMS  With TB_ICMS+nVALICM //Valor ICMS
							Replace DGXLS->TB_PIS  With TB_PIS+(cAliasSD2)->D2_VALIMP6 //Valor PIS
							Replace DGXLS->TB_COFINS  With TB_COFINS+(cAliasSD2)->D2_VALIMP5 //Valor COFINS
							Replace DGXLS->TB_IPI  With TB_IPI+nVALIPI                 //Valor IPI
							Replace DGXLS->TB_ICMSRET  With nValor2 //Valor ICMS-ST
							Replace DGXLS->TB_FRETE  With nFrete   //Valor Frete
							Replace DGXLS->TB_SEGURO  With nSeguro  //Valor Seguro
							Replace DGXLS->TB_DESPESA With nDespesa //Valor Despesa
							Replace DGXLS->TB_CUSTUNI With (cAliasSD2)->D2_CUSTO1/nQtdVend   //Custo Unitário
							DGXLS->(MsUnlock())
							
							//Replace DGXLS->TB_DOC	    With (cAliasSD2)->F2_DOC
						EndIf
					Else
						If RecLock("DGXLS",.T.)
							DGXLS->FILIAL		:= (cAliasSD2)->D2_FILIAL
							DGXLS->DOC		:= (cAliasSD2)->D2_DOC
							DGXLS->SERIE     	:= (cAliasSD2)->D2_SERIE
							DGXLS->CODCLI		:= (cAliasSD2)->D2_CLIENTE
							DGXLS->LOJA		:= (cAliasSD2)->D2_LOJA
							DGXLS->CLIENTE	:= cNome
							DGXLS->UF			:= (cAliasSD2)->D2_EST
							DGXLS->PRODUTO	:= (cAliasSD2)->D2_COD
							DGXLS->D2ITEM		:= (cAliasSD2)->D2_ITEM
							DGXLS->DATANF		:= StoD((cAliasSD2)->F2_EMISSAO)
							DGXLS->ANO			:= strzero(Year(STOD((cAliasSD2)->F2_EMISSAO)),4)
							DGXLS->MES			:= STRZERO(MONTH(STOD((cAliasSD2)->F2_EMISSAO)),2)
							If MONTH(STOD((cAliasSD2)->F2_EMISSAO)) <= 3
								DGXLS->QUARTER		:= "Q1"
							ElseIf MONTH(STOD((cAliasSD2)->F2_EMISSAO)) > 3 .And. MONTH(STOD((cAliasSD2)->F2_EMISSAO)) <= 6
								DGXLS->QUARTER		:= "Q2"
							ElseIf MONTH(STOD((cAliasSD2)->F2_EMISSAO)) > 6 .And. MONTH(STOD((cAliasSD2)->F2_EMISSAO)) <= 9
								DGXLS->QUARTER		:= "Q3"
							ElseIf MONTH(STOD((cAliasSD2)->F2_EMISSAO)) > 9 //.And. MONTH(STOD((clAlias)->F2_EMISSAO)) <= 12
								DGXLS->QUARTER		:= "Q4"
							EndIf
							
							DGXLS->TIPONF     	:= (cAliasSD2)->D2_TIPO
							DGXLS->MOTIVO     	:= " "
							DGXLS->JUSTIFICAT	:= " "
							DGXLS->REFAT			:= " "
							DGXLS->CFOP			:= (cAliasSD2)->D2_CF
							DGXLS->CODVEN1     := (cAliasSD2)->F2_VEND1
							DGXLS->CODVEN2     := (cAliasSD2)->F2_VEND2
							DGXLS->CODVEN3     := (cAliasSD2)->F2_VEND3
							DGXLS->VEND1		:= clVend1
							DGXLS->VEND2		:= clVend2
							DGXLS->VEND3		:= clVend3
							//DGXLS->CANALCLI := (clAlias)->A1_YCANAL
							//CRIAR DESCRICAO
							DGXLS->GRPREP		:= cyCanal
							DGXLS->CANAL 	:= cyDcanal
							DGXLS->CODPGTO	:= (cAliasSD2)->F2_COND
							DGXLS->CONDPG		:= clCondPg
							DGXLS->TITULONC	:= cDescPro
							DGXLS->TB_PLATRED := cPlataf
							DGXLS->TB_PUBLISH	:= cPublish
							DGXLS->CATEGORIA	:= " "  // CARREGA DE OUTRA PLANILHA
							DGXLS->CAMPANHA	:= " " //CARREGA DE OUTRA PLANILHA DEFINIR REGRA
							DGXLS->QTDFAT		:= (cAliasSD2)->D2_QUANT
							DGXLS->PRCVEN		:= (cAliasSD2)->D2_PRCVEN
							DGXLS->PRCTAB		:= nlPrcTab
							DGXLS->CODTAB 	   	:= clTabela
							DGXLS->PORCDESC	:= (((cAliasSD2)->D2_PRCVEN/nlPrcTab) * 100) - 100
							DGXLS->VALVEND	:= (cAliasSD2)->D2_PRCVEN * (cAliasSD2)->D2_QUANT
							DGXLS->VALTAB		:= nlPrcTab * (cAliasSD2)->D2_QUANT
							DGXLS->REGRADESC	:= clRegradesc
							DGXLS->PREGRADESC	:= nlPRegrades
							DGXLS->USUARIO   	:= clUSER  //USUARIO QUE EMITIU O PEDIDO
							DGXLS->VALFAT		:= (cAliasSD2)->(D2_VALFRE + D2_SEGURO + D2_ICMSRET + D2_VALIPI + D2_TOTAL)
							DGXLS->META		:= 0
							DGXLS->PEDIDO		:= (cAliasSD2)->D2_PEDIDO
							DGXLS->ITEMPED	:= (cAliasSD2)->D2_ITEMPV
							DGXLS->STATUSCML	:= " "//noacento(GETADVFVAL("SX5","X5_DESCRI",XFILIAL("SX5")+"ZX"+(clAlias)->B1_STACML,1,""))
							
							DGXLS->TB_VALOR1  := nQtdVend  //quantidade vendida
							DGXLS->TB_VALOR2  := IIF((cAliasSD2)->F2_TIPO == "P",0,nTotal)+nVALIPI+nValor2+nAdic //Valor total
							DGXLS->TB_ICMS  := nVALICM //Valor ICMS
							DGXLS->TB_PIS  := (cAliasSD2)->D2_VALIMP6 //Valor PIS
							DGXLS->TB_COFINS  := (cAliasSD2)->D2_VALIMP5 //Valor COFINS
							DGXLS->TB_IPI  := nVALIPI                 //Valor IPI
							DGXLS->TB_ICMSRET  := nValor2 //Valor ICMS-ST
							DGXLS->TB_FRETE  := nFrete   //Valor Frete
							DGXLS->TB_SEGURO  := nSeguro  //Valor Seguro
							DGXLS->TB_DESPESA := nDespesa //Valor Despesa
							DGXLS->TB_CUSTUNI := (cAliasSD2)->D2_CUSTO1/nQtdVend   //Custo Unitário
							DGXLS->(MsUnlock())
							
						EndIf
					EndIF
				EndIf
			Endif
			//	Next nContador
		EndIf
	EndIf
	
	dbSelectArea(cAliasSD2)
	(cAliasSD2)->(dbSkip())
EndDo
(cAliasSD2)->(dbCloseArea())

clQry1 := " SELECT  SD2.*, F2_EMISSAO, F2_TIPO, F2_COND,F2_DOC, F2_FRETE, F2_SEGURO, F2_DESPESA, F2_FRETAUT, F2_ICMSRET,"
clQry1 += " F2_TXMOEDA, F2_MOEDA " + SubStr(cAddField,2,Len(cAddField)-2)
clQry1 += " FROM " + retSqlName("SD2") + " SD2, " + RetSqlName("SF4") + " SF4, " +RetSqlName("SF2") + " SF2"
clQry1 += " WHERE D2_FILIAL  = '" + xFilial("SD2") +"'"
clQry1 += " AND D2_EMISSAO between '" + StrZero(Val(SubStr(DTOS(cd_PAR01),1,4))-1,4) + SubStr(DTOS(cd_PAR01),5,4) + "' AND '" +  StrZero(Val(SubStr(DTOS(cd_PAR02),1,4))-1,4) + SubStr(DTOS(cd_PAR02),5,4) + "'"
clQry1 += " AND F2_EST between '" + CD_par12 + "' AND '" + CD_par13 + "'"
clQry1 += " AND D2_COD between '" + CD_par14 + "' AND '" + CD_par15 + "'"
clQry1 += " AND D2_TIPO NOT IN ('D', 'B') "
clQry1 += " AND F2_FILIAL  = '" + xFilial("SF2") + "'"
clQry1 += " AND D2_DOC     = F2_DOC"
clQry1 += " AND D2_SERIE   = F2_SERIE"
clQry1 += " AND D2_CLIENTE = F2_CLIENTE"
clQry1 += " AND D2_LOJA    = F2_LOJA"
clQry1 += " AND F4_FILIAL  = '"  + xFilial("SF4") + "' "
clQry1 += " AND F4_CODIGO  = D2_TES"
clQry1 += " AND SD2.D_E_L_E_T_ = ' '" //%notdel%
clQry1 += " AND SF2.D_E_L_E_T_ = ' '" //%notdel%
clQry1 += " AND SD2.D_E_L_E_T_ = ' '" //%notdel%
clQry1 += " AND SF4.D_E_L_E_T_ = ' '" //%notdel%
clQry1 += " AND " + SubStr(cWhere,2,Len(cWhere)-2)
clQry1 += " ORDER BY D2_FILIAL,D2_EMISSAO,D2_NUMSEQ"

clQry1 := ChangeQuery(clQry1)
dbUseArea(.T.,"TOPCONN",TCGENQRY(,,clQry1),cAliasSD2, .T., .T.)
dbGoTop()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Processa Faturamento                                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nTotVal2:= 0
nTotFre	:= 0
nTotSeg	:= 0
nTotDes := 0

nOrdem := 1 //Sempre pela ordem 1

DbSelectArea("SB1")
SB1->(dbSetOrder(1))
DbSelectArea("SA1")
SA1->(dBSetOrder(1))
DbSelectArea("SA3")
SA3->(DbSetOrder(1))
DbSelectArea("SC6")
SC6->(dbSetOrder(1))
DbSelectArea("SZ5")
SZ5->(DbSetOrder(1))
DbSelectArea("SE4")
SE4->(dbSetOrder(1))
While !(cAliasSD2)->(Eof())
	
	nTOTAL  :=0
	nVALICM :=0
	nVALIPI :=0
	nQtdVend:= 0
	NMEDIA	:= 0
	
	cCodPro	:= (cAliasSD2)->D2_COD
	SB1->(DbSeek(xFilial("SB1") + cCodPro ))
	cPublish:= SB1->B1_PUBLISH //getadvfval("SB1","B1_PUBLISH",xFilial("SB1")+cCodPro,1,"")
	cItemCC	:= SB1->B1_ITEMCC //getadvfval("SB1","B1_ITEMCC",xFilial("SB1")+cCodPro,1,"")
	cCdPlat	:= SB1->B1_PLATAF //getadvfval("SB1","B1_PLATAF",xFilial("SB1")+cCodPro,1,"")
	cDescPro:= SB1->B1_XDESC //"getadvfval("SB1","B1_XDESC",xFilial("SB1")+cCodPro,1,"")
	//Campos buscados do cadastro de produtos e não da tabela SD2 propositalmente
	If !(cItemCC >= CD_par16 .and. cItemCC <= CD_par17 .and. cCdPlat >= CD_par18 .and. cCdPlat <= CD_par19)
		(cAliasSD2)->(dbSkip())
		loop
	EndIf
	
	cPlataf := " "
	
	If SZ5->(dbSeek(xFilial("SZ5")+SUBSTR(cCdPlat,1,6)) )
		cPlataf	:= SZ5->Z5_PLATRED //getadvfval("SZ5","Z5_PLATRED",xFilial("SZ5")+SUBSTR(cCdPlat,1,6),1,"")
	EndIf
	
	cCodcli	:= (cAliasSD2)->D2_CLIENTE
	cLjcli	:= (cAliasSD2)->D2_LOJA
	SA1->(dbSeek(xFilial("SA1") + cCodcli+cLjcli))
	cUF		:= SA1->A1_EST  //getadvfval("SA1","A1_EST",xFilial("SA1")+cCodcli+cLjcli,1,"")
	cNome	:= SA1->A1_NREDUZ //getadvfval("SA1","A1_NREDUZ",xFilial("SA1")+cCodcli+cLjcli,1,"")
	cycanal	:= SA1->A1_YCANAL //getadvfval("SA1","A1_YCANAL",xFilial("SA1")+cCodcli+cLjcli,1,"")
	cyDcanal:= SA1->A1_YDCANAL //getadvfval("SA1","A1_YDCANAL",xFilial("SA1")+cCodcli+cLjcli,1,"")
	nTaxa	:=	IIf((cAliasSD2)->(FieldPos("F2_TXMOEDA"))>0,(cAliasSD2)->F2_TXMOEDA,0)
	nMoedNF	:=	IIf((cAliasSD2)->(FieldPos("F2_MOEDA"))>0,(cAliasSD2)->F2_MOEDA,0)
	
	clVend1 := " "
	clvend2 := " "
	clVend3 := " "
	If SA3->(dbSeek(xFilial("SA3")+(cAliasSD2)->F2_VEND1))
		clVend1 := SA3->A3_NOME //getadvfval("SA3","A3_NOME",xFilial("SA3")+(cAliasSD2)->F2_VEND1,1,"")
	EndIf
	If SA3->(DbSeek(xFilial("SA3")+(cAliasSD2)->F2_VEND2))
		clVend2 := SA3->A3_NOME // getadvfval("SA3","A3_NOME",xFilial("SA3")+(cAliasSD2)->F2_VEND2,1,"")
	EndIf
	If SA3->(dbseek(xFilial("SA3")+(cAliasSD2)->F2_VEND3))
		clVend3 := SA3->A3_NOME //getadvfval("SA3","A3_NOME",xFilial("SA3")+(cAliasSD2)->F2_VEND3,1,"")
	EndIf
	clCondPg := " " //
	If SE4->(dbSeek(xFilial("SE4")+(cAliasSD2)->F2_COND))
		clCondpg := SE4->E4_DESCRI //getadvfval("SE4","E4_DESCRI",xFilial("SE4")+(cAliasSD2)->F2_COND,1,"")
	EndIf
	SC6->(dbSeek(xFilial("SC6")+(cAliasSD2)->D2_PEDIDO + (cAliasSD2)->D2_ITEMPV))
	clUSER := SC6->C6_X_USRLBI //getadvfval("SC6","C6_X_USRLBI",xFilial("SC6")+(cAliasSD2)->D2_PEDIDO + (cAliasSD2)->D2_ITEMPV,1,"")
	nlPrcTab := SC6->C6_PRCTAB //getadvfval("SC6","C6_PRCTAB",xFilial("SC6")+(cAliasSD2)->D2_PEDIDO + (cAliasSD2)->D2_ITEMPV,1,"")
	clRegradesc := SC6->C6_REGDESC //getadvfval("SC6","C6_REGDESC",xFilial("SC6")+(cAliasSD2)->D2_PEDIDO + (cAliasSD2)->D2_ITEMPV,1,"")
	nlPRegrades := SC6->C6_PREGDES //getadvfval("SC6","C6_PREGDES",xFilial("SC6")+(cAliasSD2)->D2_PEDIDO + (cAliasSD2)->D2_ITEMPV,1,"")
	clTabela := getadvfval("SC5","C5_TABELA",xFilial("SC5")+(cAliasSD2)->D2_PEDIDO ,1,"")
	
	// Considera Adicionais
	nAdic 	:= 0
	nFrete	:= (cAliasSD2)->D2_VALFRE
	nSeguro	:= (cAliasSD2)->D2_SEGURO
	nDespesa:= (cAliasSD2)->D2_DESPESA
	
	
	//nValor2  := (cAliasSD2)->D2_ICMSRET //xMoeda(/*(cAliasSD2)->F2_FRETAUT+*/(cAliasSD2)->D2_ICMSRET,nMoedNF,CD_par06,(cAliasSD2)->F2_EMISSAO,nDecs+1,nTaxa)
	
	
	If AvalTes((cAliasSD2)->D2_TES,cEstoq,cDupli)
		nAdic := 0
		nValor2  := 0
		nVALICM += (cAliasSD2)->D2_VALICM //xMoeda((cAliasSD2)->D2_VALICM,1,CD_par06,(cAliasSD2)->D2_EMISSAO,nDecs+1)
		nVALIPI += (cAliasSD2)->D2_VALIPI //xMoeda((cAliasSD2)->D2_VALIPI,1,CD_par06,(cAliasSD2)->D2_EMISSAO,nDecs+1)
		nTotal	+=	xMoeda((cAliasSD2)->D2_TOTAL,nMoedNF,CD_par06,(cAliasSD2)->D2_EMISSAO,nDecs+1,nTaxa)
		nQtdVend+= (cAliasSD2)->D2_QUANT
		nValor2  := (cAliasSD2)->D2_ICMSRET //xMoeda(/*(cAliasSD2)->F2_FRETAUT+*/(cAliasSD2)->D2_ICMSRET,nMoedNF,CD_par06,(cAliasSD2)->F2_EMISSAO,nDecs+1,nTaxa)
		
		
		
		If ( nTotal <> 0 )
			cVendedor := "1"
			
			//For nContador := 1 To nVendedor
			dbSelectArea("DGXLS")
			dbSetOrder(nOrdem)
			//cVend := (cAliasSD2)->(FieldGet(FieldPos("F2_VEND"+cVendedor)))
			cVendedor := Soma1(cVendedor,1)
			If cCodcli >= CD_par03 .And. cCodcli <= CD_par04
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Se vendedor em branco, considera apenas 1 vez        ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				//If Empty(cVend) .and. nContador > 1
				//	Loop
				//Endif
				
				If ( aScan(aVend,cVend)==0 )
					Aadd(aVend,cVend)
				EndIf
				
				If nOrdem == 1
					//If (dbSeek( cCodcli+cLjcli+cCodPro )) //CD_par05
					DbSelectArea("DGXLS")
					DbSetOrder(1)
					If CD_par11 == 2
						nAdic := (cAliasSD2)->D2_VALFRE+(cAliasSD2)->D2_SEGURO+(cAliasSD2)->D2_DESPESA //
						//nAdic := xMoeda((cAliasSD2)->D2_VALFRE+(cAliasSD2)->D2_SEGURO+(cAliasSD2)->D2_DESPESA,nMoedNF,CD_par06,(cAliasSD2)->F2_EMISSAO,nDecs+1,nTaxa)
					EndIf
					
					
					If DGXLS->(dbSeek((cAliasSD2)->D2_FILIAL+(cAliasSD2)->D2_DOC+(cAliasSD2)->D2_SERIE+(cAliasSD2)->D2_CLIENTE+(cAliasSD2)->D2_LOJA+(cAliasSD2)->D2_COD +(cAliasSD2)->D2_ITEM))
						If RecLock("DGXLS",.F.)
							Replace DGXLS->TB_VALOR1  With TB_VALOR1+nQtdVend  //quantidade vendida
							Replace DGXLS->TB_VALOR2  With TB_VALOR2+IIF((cAliasSD2)->F2_TIPO == "P",0,nTotal)+nVALIPI+nValor2+nAdic //Valor total
							Replace DGXLS->TB_ICMS  With TB_ICMS+nVALICM //Valor ICMS
							Replace DGXLS->TB_PIS  With TB_PIS+(cAliasSD2)->D2_VALIMP6 //Valor PIS
							Replace DGXLS->TB_COFINS  With TB_COFINS+(cAliasSD2)->D2_VALIMP5 //Valor COFINS
							Replace DGXLS->TB_IPI  With TB_IPI+nVALIPI                 //Valor IPI
							Replace DGXLS->TB_ICMSRET  With nValor2 //Valor ICMS-ST
							Replace DGXLS->TB_FRETE  With nFrete   //Valor Frete
							Replace DGXLS->TB_SEGURO  With nSeguro  //Valor Seguro
							Replace DGXLS->TB_DESPESA With nDespesa //Valor Despesa
							Replace DGXLS->TB_CUSTUNI With (cAliasSD2)->D2_CUSTO1/nQtdVend   //Custo Unitário
							DGXLS->(MsUnlock())
							
							//Replace DGXLS->TB_DOC	    With (cAliasSD2)->F2_DOC
						EndIf
					Else
						If RecLock("DGXLS",.T.)
							DGXLS->FILIAL		:= (cAliasSD2)->D2_FILIAL
							DGXLS->DOC		:= (cAliasSD2)->D2_DOC
							DGXLS->SERIE     	:= (cAliasSD2)->D2_SERIE
							DGXLS->CODCLI		:= (cAliasSD2)->D2_CLIENTE
							DGXLS->LOJA		:= (cAliasSD2)->D2_LOJA
							DGXLS->CLIENTE	:= cNome
							DGXLS->UF			:= (cAliasSD2)->D2_EST
							DGXLS->PRODUTO	:= (cAliasSD2)->D2_COD
							DGXLS->D2ITEM		:= (cAliasSD2)->D2_ITEM
							DGXLS->DATANF		:= StoD((cAliasSD2)->F2_EMISSAO)
							DGXLS->ANO			:= strzero(Year(STOD((cAliasSD2)->F2_EMISSAO)),4)
							DGXLS->MES			:= STRZERO(MONTH(STOD((cAliasSD2)->F2_EMISSAO)),2)
							If MONTH(STOD((cAliasSD2)->F2_EMISSAO)) <= 3
								DGXLS->QUARTER		:= "Q1"
							ElseIf MONTH(STOD((cAliasSD2)->F2_EMISSAO)) > 3 .And. MONTH(STOD((cAliasSD2)->F2_EMISSAO)) <= 6
								DGXLS->QUARTER		:= "Q2"
							ElseIf MONTH(STOD((cAliasSD2)->F2_EMISSAO)) > 6 .And. MONTH(STOD((cAliasSD2)->F2_EMISSAO)) <= 9
								DGXLS->QUARTER		:= "Q3"
							ElseIf MONTH(STOD((cAliasSD2)->F2_EMISSAO)) > 9 //.And. MONTH(STOD((clAlias)->F2_EMISSAO)) <= 12
								DGXLS->QUARTER		:= "Q4"
							EndIf
							
							DGXLS->TIPONF     	:= (cAliasSD2)->D2_TIPO
							DGXLS->MOTIVO     	:= " "
							DGXLS->JUSTIFICAT	:= " "
							DGXLS->REFAT			:= " "
							DGXLS->CFOP			:= (cAliasSD2)->D2_CF
							DGXLS->CODVEN1     := (cAliasSD2)->F2_VEND1
							DGXLS->CODVEN2     := (cAliasSD2)->F2_VEND2
							DGXLS->CODVEN3     := (cAliasSD2)->F2_VEND3
							DGXLS->VEND1		:= clVend1
							DGXLS->VEND2		:= clVend2
							DGXLS->VEND3		:= clVend3
							//DGXLS->CANALCLI := (clAlias)->A1_YCANAL
							//CRIAR DESCRICAO
							DGXLS->GRPREP		:= cyCanal
							DGXLS->CANAL 	:= cyDcanal
							DGXLS->CODPGTO	:= (cAliasSD2)->F2_COND
							DGXLS->CONDPG		:= clCondPg
							DGXLS->TITULONC	:= cDescPro
							DGXLS->TB_PLATRED := cPlataf
							DGXLS->TB_PUBLISH	:= cPublish
							DGXLS->CATEGORIA	:= " "  // CARREGA DE OUTRA PLANILHA
							DGXLS->CAMPANHA	:= " " //CARREGA DE OUTRA PLANILHA DEFINIR REGRA
							DGXLS->QTDFAT		:= (cAliasSD2)->D2_QUANT
							DGXLS->PRCVEN		:= (cAliasSD2)->D2_PRCVEN
							DGXLS->PRCTAB		:= nlPrcTab
							DGXLS->CODTAB	   	:= clTabela
							DGXLS->PORCDESC	:= (((cAliasSD2)->D2_PRCVEN/nlPrcTab) * 100) - 100
							DGXLS->VALVEND	:= (cAliasSD2)->D2_PRCVEN * (cAliasSD2)->D2_QUANT
							DGXLS->VALTAB		:= nlPrcTab * (cAliasSD2)->D2_QUANT
							DGXLS->REGRADESC	:= clRegradesc
							DGXLS->PREGRADESC	:= nlPRegrades
							DGXLS->USUARIO   	:= clUSER  //USUARIO QUE EMITIU O PEDIDO
							DGXLS->VALFAT		:= (cAliasSD2)->(D2_VALFRE + D2_SEGURO + D2_ICMSRET + D2_VALIPI + D2_TOTAL)
							DGXLS->META		:= 0
							DGXLS->PEDIDO		:= (cAliasSD2)->D2_PEDIDO
							DGXLS->ITEMPED	:= (cAliasSD2)->D2_ITEMPV
							DGXLS->STATUSCML	:= " "//noacento(GETADVFVAL("SX5","X5_DESCRI",XFILIAL("SX5")+"ZX"+(clAlias)->B1_STACML,1,""))
							
							DGXLS->TB_VALOR1  := nQtdVend  //quantidade vendida
							DGXLS->TB_VALOR2  := IIF((cAliasSD2)->F2_TIPO == "P",0,nTotal)+nVALIPI+nValor2+nAdic //Valor total
							DGXLS->TB_ICMS  := nVALICM //Valor ICMS
							DGXLS->TB_PIS  := (cAliasSD2)->D2_VALIMP6 //Valor PIS
							DGXLS->TB_COFINS  := (cAliasSD2)->D2_VALIMP5 //Valor COFINS
							DGXLS->TB_IPI  := nVALIPI                 //Valor IPI
							DGXLS->TB_ICMSRET  := nValor2 //Valor ICMS-ST
							DGXLS->TB_FRETE  := nFrete   //Valor Frete
							DGXLS->TB_SEGURO  := nSeguro  //Valor Seguro
							DGXLS->TB_DESPESA := nDespesa //Valor Despesa
							DGXLS->TB_CUSTUNI := (cAliasSD2)->D2_CUSTO1/nQtdVend   //Custo Unitário
							DGXLS->(MsUnlock())
							
						EndIf
					EndIF
				EndIf
			Endif
			//Next nContador
		EndIf
	EndIf
	
	dbSelectArea(cAliasSD2)
	(cAliasSD2)->(dbSkip())
EndDo
(cAliasSD2)->(dbCloseArea())

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Processa Devolucao                                                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If ( CD_PAR07 == 1 )
	
	cAliasSD1:= GetNextAlias()
	
	cWhereAux 	:= ""
	cVendedor 	:= "1"
	cWhere := ""
	
	cWhere += "%"
	cAddField := "%"
	If cPaisLoc == "BRA"
		For nCampo := 1 To nVendedor
			cCampo := "F2_VEND"+cVendedor
			If SF2->(FieldPos(cCampo)) > 0
				cWhereAux += "(" + cCampo + " between '" + CD_par03 + "' and '" + CD_par04 + "') or "
				cAddField += ", "  + cCampo
			EndIf
			cVendedor := Soma1(cVendedor,1)
		Next nCampo
	Else
		For nCampo := 1 To 35
			cCampo := "F1_VEND"+cVendedor
			If SF1->(FieldPos(cCampo)) > 0
				cWhereAux += "(" + cCampo + " between '" + CD_par03 + "' and '" + CD_par04 + "') or "
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
	//Alteração no where para adicionar o tratamento do novo parametro CD_par20
	cWhere := SubStr(AllTrim(cWhere),1,Len(AllTrim(cWhere))-1)
	If CD_par20 == 1
		cWhere += " AND D1_DTDIGIT between '" + DTOS(CD_par01) + "' AND '" + DTOS(CD_par02) + "' %"
	Else
		cWhere += " AND F2_EMISSAO between '" + DTOS(CD_par01) + "' AND '" + DTOS(CD_par02) + "' %"
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
	
	//oReport:Section(3):BeginQuery()
	/*
	BeginSql Alias cAliasSD1
	
	
	SELECT SD1.*, F1_EMISSAO, F1_DOC, F1_SERIE, F1_FORNECE, F1_LOJA, F1_FRETE, F1_DESPESA, F1_SEGURO, F1_ICMSRET,F1_COND,
	F1_DTDIGIT,F1_MOTIVO,F1_JUSTIF, F2_EMISSAO, F2_CLIENTE, F2_LOJA,F2_VEND1, F2_VEND2,F2_VEND3, F1_TXMOEDA, F1_MOEDA %Exp:cAddField%
	FROM %Table:SD1% SD1, %Table:SF4% SF4, %Table:SF2% SF2, %Table:SF1% SF1
	WHERE D1_FILIAL  = %xFilial:SD1%
	AND D1_DTDIGIT between %Exp:DTOS(CD_par01)% AND %Exp:DTOS(CD_par02)%
	AND F1_EST between %Exp:CD_par12% AND %Exp:CD_par13%
	AND D1_COD between %Exp:CD_par14% AND %Exp:CD_par15%
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
	ORDER BY D1_FILIAL,D1_DTDIGIT,D1_DOC,D1_NUMSEQ
	EndSql
	*/
	clQry2 := " SELECT SD1.*, F1_EMISSAO, F1_DOC, F1_SERIE, F1_FORNECE, F1_LOJA, F1_FRETE, F1_DESPESA, F1_SEGURO, F1_ICMSRET,F1_COND, F1_REFAT,
	clqry2 += "	F1_DTDIGIT,F1_MOTIVO,F1_JUSTIF, F2_TIPO, F2_EMISSAO, F2_CLIENTE, F2_LOJA,F2_VEND1, F2_VEND2,F2_VEND3, F1_TXMOEDA, F1_MOEDA " + SubStr(cAddField,2,Len(cAddField)-2)
	clqry2 += "	FROM " + RetSqlName("SD1") + " SD1, " + RetSqlName("SF4") + " SF4, " + RetSqlName("SF2") + " SF2, " + RetSqlName("SF1") + " SF1"
	clqry2 += "	WHERE D1_FILIAL  = '" + xFilial("SD1") + "'"
	clqry2 += "	AND D1_DTDIGIT between '" + DTOS(CD_par01) + "' AND '" + DTOS(CD_par02) + "'"
	clqry2 += "	AND F1_EST between '" + CD_par12 + "' AND '" + CD_par13 + "'"
	clqry2 += "	AND D1_COD between '" + CD_par14 + "' AND '" + CD_par15 + "'"
	clqry2 += "	AND D1_TIPO = 'D'"
	clqry2 += "	AND F4_FILIAL  = '" + xFilial("SF4") + "'"
	clqry2 += "	AND F4_CODIGO  = D1_TES"
	clqry2 += "	AND F2_FILIAL  = '" + xFilial("SF2") + "'"
	clqry2 += "	AND F2_DOC     = D1_NFORI"
	clqry2 += "	AND F2_SERIE   = D1_SERIORI"
	clqry2 += "	AND F2_LOJA    = D1_LOJA"
	clqry2 += "	AND F1_FILIAL  = '" + xFilial("SF1") + "'"
	clqry2 += "	AND F1_DOC     = D1_DOC"
	clqry2 += "	AND F1_SERIE   = D1_SERIE"
	clqry2 += "	AND F1_FORNECE = D1_FORNECE"
	clqry2 += "	AND F1_LOJA    = D1_LOJA"
	//clQry2 += " AND F1_STATUS <> ' '"
	clqry2 += "	AND SD1.D_E_L_E_T_ = ' '"
	clqry2 += "	AND SF4.D_E_L_E_T_ = ' '"
	clqry2 += "	AND SF2.D_E_L_E_T_ = ' '"
	clqry2 += "	AND SF1.D_E_L_E_T_ = ' '"
	clqry2 += "	AND " + SubStr(cWhere,2,Len(cWhere)-2)
	clqry2 += "	ORDER BY D1_FILIAL,D1_DTDIGIT,D1_DOC
	//,D1_NUMSEQ
	clQry2 := ChangeQuery(clQry2)
	dbUseArea(.T.,"TOPCONN",TCGENQRY(,,clQry2),cAliasSD1, .T., .T.)
	dbGoTop()
	//oReport:Section(3):EndQuery()
	
	DbSelectArea(cAliasSD1)
	DbGotop()
	While !(cAliasSD1)->(Eof())
		nTOTAL :=0
		nVALICM:=0
		nVALIPI:=0
		nQtdVend:= 0
		nmedia	:= 0
		cCodPro	:= (cAliasSD1)->D1_COD
		SB1->(dbSeek(xFilial("SB1")+(cAliasSD1)->D1_COD))
		cItemCC	:= SB1->B1_ITEMCC //getadvfval("SB1","B1_ITEMCC",xFilial("SB1")+cCodPro,1,"")
		cPublish:= SB1->B1_PUBLISH  //getadvfval("SB1","B1_PUBLISH",xFilial("SB1")+cCodPro,1,"")
		cCdPlat	:= SB1->B1_PLATAF //getadvfval("SB1","B1_PLATAF",xFilial("SB1")+cCodPro,1,"")
		cDescPro:= SB1->B1_XDESC  //getadvfval("SB1","B1_XDESC",xFilial("SB1")+cCodPro,1,"")
		cPlataf := " "
		If SZ5->(dbSeek(xFilial("SZ5")+SUBSTR(cCdPlat,1,6)))
			cPlataf	:= SZ5->Z5_PLATRED  ///getadvfval("SZ5","Z5_PLATRED",xFilial("SZ5")+SUBSTR(cCdPlat,1,6),1,"")
		EndIf
		
		
		cCodcli	:= (cAliasSD1)->D1_FORNECE
		cLjcli	:= (cAliasSD1)->D1_LOJA
		cCodPro	:= (cAliasSD1)->D1_COD
		SA1->(dbSeek(xFilial("SA1") + cCodcli+cLjcli))
		cUF		:= SA1->A1_EST //getadvfval("SA1","A1_EST",xFilial("SA1")+cCodcli+cLjcli,1,"")
		cNome	:= SA1->A1_NREDUZ //getadvfval("SA1","A1_NREDUZ",xFilial("SA1")+cCodcli+cLjcli,1,"")
		cycanal	:= SA1->A1_YCANAL //getadvfval("SA1","A1_YCANAL",xFilial("SA1")+cCodcli+cLjcli,1,"")
		cyDcanal:= SA1->A1_YDCANAL //getadvfval("SA1","A1_YDCANAL",xFilial("SA1")+cCodcli+cLjcli,1,"")
		nTaxa	:=	IIf((cAliasSD1)->(FieldPos("F1_TXMOEDA"))>0,(cAliasSD1)->F1_TXMOEDA,0)
		nMoedNF	:=	IIf((cAliasSD1)->(FieldPos("F1_MOEDA"))>0,(cAliasSD1)->F1_MOEDA,0)
		clVend1 := " "
		clVend2 := " "
		clvend3 := " "
		If SA3->(dbSeek(xfilial("SA3") + (cAliasSD1)->F2_VEND1 ))
			clVend1 := SA3->A3_NOME //getadvfval("SA3","A3_NOME",xFilial("SA3")+(cAliasSD1)->F2_VEND1,1,"")
		EndIf
		If SA3->(dbSeek(xfilial("SA3") + (cAliasSD1)->F2_VEND2 ))
			clVend2 := SA3->A3_NOME //getadvfval("SA3","A3_NOME",xFilial("SA3")+(cAliasSD1)->F2_VEND2,1,"")
		EndIf
		If SA3->(dbSeek(xfilial("SA3") + (cAliasSD1)->F2_VEND3 ))
			clVend3 := SA3->A3_NOME //getadvfval("SA3","A3_NOME",xFilial("SA3")+(cAliasSD1)->F2_VEND3,1,"")
		EndIf
		DbSelectArea("SX5")
		SX5->(DbSetOrder(1))
		If SX5->(DbSeek(xFilial("SX5")+AvKey("Z5","X5_TABELA")+AvKey((cAliasSD1)->F1_MOTIVO,"X5_CHAVE")))
			cMotivo := SubStr(SX5->X5_DESCRI,1,30)
		Else
			cMotivo := (cAliasSD1)->F1_MOTIVO
		EndIf
		If !Empty((cAliasSD1)->F1_COND)
			clCondpg := getadvfval("SE4","E4_DESCRI",xFilial("SE4")+(cAliasSD1)->F1_COND,1,"")
		Else
			clCondPg := " "
		EndIf
		
		//clUSER := getadvfval("SC6","C6_X_USRLBI",xFilial("SC6")+(cAliasSD2)->D2_PEDIDO + (cAliasSD2)->D2_ITEMPV,1,"")
		clUser := " "
		alArea := SD2->(GetArea())
		DbSelectArea("SD2")
		DbSetOrder(3)
		If SD2->(dbSeek(xFilial("SF1")+(cAliasSD1)->D1_NFORI+(cAliasSD1)->D1_SERIORI+(cAliasSD1)->D1_FORNECE+(cAliasSD1)->D1_LOJA+(cAliasSD1)->D1_COD+(cAliasSD1)->D1_ITEMORI ))
			nlPrcTab := getadvfval("SC6","C6_PRCTAB",xFilial("SC6")+SD2->D2_PEDIDO + SD2->D2_ITEMPV,1,"")
			clRegradesc := getadvfval("SC6","C6_REGDESC",xFilial("SC6")+SD2->D2_PEDIDO + SD2->D2_ITEMPV,1,"")
			nlPRegrades := getadvfval("SC6","C6_PREGDES",xFilial("SC6")+SD2->D2_PEDIDO + SD2->D2_ITEMPV,1,"")
			clTabela := getadvfval("SC5","C5_TABELA",xFilial("SC5")+SD2->D2_PEDIDO ,1,"")
			cmPedido := SD2->D2_PEDIDO
			cmItemPed := SD2->D2_ITEMPV
		Else
			nlPrcTab := 0
			clRegradesc := " "
			nlPRegrades := 0
			clTabela := "  "
			cmPedido := " "
			cmItemPed := " "
		EndIf
		
		
		
		// Considera Adicionais
		nAdic 	:= 0
		nFrete	:= (cAliasSD1)->D1_VALFRE
		nSeguro	:= (cAliasSD1)->D1_SEGURO
		nDespesa:= (cAliasSD1)->D1_DESPESA
		
		//Campos buscados do cadastro de produtos e não da tabela SD2 propositalmente
		If !(cItemCC >= CD_par16 .and. cItemCC <= CD_par17 .and. cCdPlat >= CD_par18 .and. cCdPlat <= CD_par19)
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
			If CD_PAR10 == 1 .Or. Empty((cAliasSD1)->F2_EMISSAO)
				DtMoedaDev  := (cAliasSD1)->F1_DTDIGIT
			Else
				DtMoedaDev  := (cAliasSD1)->F2_EMISSAO
			EndIf
			
			If AvalTes((cAliasSD1)->D1_TES,cEstoq,cDupli)
				
				nVALICM :=  xMoeda((cAliasSD1)->D1_VALICM,1,CD_par06,DtMoedaDev,nDecs+1)
				nVALIPI :=  xMoeda((cAliasSD1)->D1_VALIPI,1,CD_par06,DtMoedaDev ,nDecs+1)
				nTOTAL  :=  xMoeda(((cAliasSD1)->D1_TOTAL - (cAliasSD1)->D1_VALDESC),1,CD_par06,DtMoedaDev,nDecs+1)
				nQtdVend:=   (cAliasSD1)->D1_QUANT
				nFrete	:=  (cAliasSD1)->D1_VALFRE
				nSeguro	:=  (cAliasSD1)->D1_SEGURO
				nDespesa:=  (cAliasSD1)->D1_DESPESA
					
				//nValor3	:= xMoeda((cAliasSD1)->F1_ICMSRET,1,mv_par06,DtMoedaDev,nDecs+1)
				
				
				If CD_par11 == 2
					//nAdic := xMoeda((cAliasSD1)->F1_FRETE+(cAliasSD1)->F1_DESPESA+(cAliasSD1)->F1_SEGURO,1,CD_par06,DtMoedaDev,nDecs+1)
					nAdic := xMoeda((cAliasSD1)->D1_VALFRE+(cAliasSD1)->D1_DESPESA+(cAliasSD1)->D1_SEGURO,1,CD_par06,DtMoedaDev,nDecs+1)
				EndIf
				//nValor2	:= xMoeda((cAliasSD1)->F1_ICMSRET,1,CD_par06,DtMoedaDev,nDecs+1)
				nValor2	:= xMoeda((cAliasSD1)->D1_ICMSRET,1,CD_par06,DtMoedaDev,nDecs+1)
				
				cVendedor := "1"
				//For nContador := 1 TO nVendedor
				dbSelectArea("DGXLS")
				dbSetOrder(nOrdem)
				cVend := (cAliasSD1)->(FieldGet((cAliasSD1)->(FieldPos("F2_VEND"+cVendedor))))
				cVendedor := Soma1(cVendedor,1)
				//cVendedor := "F2_VEND1"
				If cCodcli >= CD_PAR03 .And. cCodcli <= CD_PAR04
					//If Empty(cVend) .and. nContador > 1
					//	Loop
					//	EndIf
					If ( aScan(aVend,cVend) == 0 )
						AADD(aVend,cVend)
					EndIf
					If nTOTAL > 0
						If nOrdem == 1
							//DtMoedaDev  := (cAliasSD1)->F1_DTDIGIT
							//nTax	:=	IIf((cAliasSD1)->(FieldPos("F1_TXMOEDA"))>0,(cAliasSD1)->F1_TXMOEDA,0)
							//nMoed	:=	IIF((cAliasSD1)->(FieldPos("F1_MOEDA"))>0,(cAliasSD1)->F1_MOEDA,1)
		 					//nTOT1	:=  xMoeda(((cAliasSD1)->D1_TOTAL -(cAliasSD1)->D1_VALDESC),nMoed,1,DtMoedaDev,nDecs+1)// xMoeda(((cAliasSD1)->D1_TOTAL -(cAliasSD1)->D1_VALDESC),nMoed,1,DtMoedaDev,nDecs+1,nTax)

							If RecLock("DGXLS",.T.)
								DGXLS->FILIAL		:= (cAliasSD1)->D1_FILIAL
								DGXLS->DOC		:= (cAliasSD1)->D1_DOC
								DGXLS->SERIE     	:= (cAliasSD1)->D1_SERIE
								DGXLS->CODCLI		:= (cAliasSD1)->D1_FORNECE
								DGXLS->LOJA		:= (cAliasSD1)->D1_LOJA
								DGXLS->CLIENTE	:= cNome
								DGXLS->UF			:= cUF //"  " //(cAliasSD1)->D1_EST
								DGXLS->PRODUTO	:= (cAliasSD1)->D1_COD
								DGXLS->D2ITEM		:= (cAliasSD1)->D1_ITEM
								DGXLS->DATANF		:= StoD((cAliasSD1)->F1_DTDIGIT)//Pela data de digitação da NF
								DGXLS->ANO			:= strzero(Year(STOD((cAliasSD1)->F1_DTDIGIT)),4)
								DGXLS->MES			:= STRZERO(MONTH(STOD((cAliasSD1)->F1_DTDIGIT)),2)
								If MONTH(STOD((cAliasSD1)->F1_DTDIGIT)) <= 3
									DGXLS->QUARTER		:= "Q1"
								ElseIf MONTH(STOD((cAliasSD1)->F1_DTDIGIT)) > 3 .And. MONTH(STOD((cAliasSD1)->F1_DTDIGIT)) <= 6
									DGXLS->QUARTER		:= "Q2"
								ElseIf MONTH(STOD((cAliasSD1)->F1_DTDIGIT)) > 6 .And. MONTH(STOD((cAliasSD1)->F1_DTDIGIT)) <= 9
									DGXLS->QUARTER		:= "Q3"
								ElseIf MONTH(STOD((cAliasSD1)->F1_DTDIGIT)) > 9 //.And. MONTH(STOD((clAlias)->F1_DTDIGIT)) <= 12
									DGXLS->QUARTER		:= "Q4"
								EndIf
								
								DGXLS->TIPONF     	:= (cAliasSD1)->D1_TIPO
								DGXLS->MOTIVO     	:= cMotivo ///(cAliasSD1)->F1_MOTIVO
								DGXLS->JUSTIFICAT	:= (cAliasSD1)->F1_JUSTIF
								DGXLS->REFAT			:= (cAliasSD1)->F1_REFAT
								DGXLS->CFOP			:= (cAliasSD1)->D1_CF
								DGXLS->CODVEN1     := (cAliasSD1)->F2_VEND1
								DGXLS->CODVEN2     := (cAliasSD1)->F2_VEND1
								DGXLS->CODVEN3     := (cAliasSD1)->F2_VEND3
								DGXLS->VEND1		:= clVend1
								DGXLS->VEND1		:= clVenD1
								DGXLS->VEND3		:= clVend3
								//DGXLS->CANALCLI := (clAlias)->A1_YCANAL
								//CRIAR DESCRICAO
								DGXLS->GRPREP		:= cyCanal
								DGXLS->CANAL 	:= cyDcanal
								DGXLS->CODPGTO	:= (cAliasSD1)->F1_COND
								DGXLS->CONDPG		:= clCondPg
								DGXLS->TITULONC	:= cDescPro
								DGXLS->TB_PLATRED := cPlataf
								DGXLS->TB_PUBLISH	:= cPublish
								DGXLS->CATEGORIA	:= " "  // CARREGA DE OUTRA PLANILHA
								DGXLS->CAMPANHA	:= " " //CARREGA DE OUTRA PLANILHA DEFINIR REGRA
								DGXLS->QTDFAT		:= -(cAliasSD1)->D1_QUANT
								DGXLS->PRCVEN		:= -(cAliasSD1)->D1_VUNIT
								DGXLS->PRCTAB		:= -nlPrcTab
								DGXLS->CODTAB	   	:= clTabela
								DGXLS->PORCDESC	:= 0 //(((cAliasSD1)->D1_PRCVEN/nlPrcTab) * 100) - 100
								DGXLS->VALVEND	:= (cAliasSD1)->D1_VUNIT * -(cAliasSD1)->D1_QUANT
								DGXLS->VALTAB		:= nlPrcTab * -(cAliasSD1)->D1_QUANT
								DGXLS->REGRADESC	:= clRegradesc
								DGXLS->PREGRADESC	:= nlPRegrades
								DGXLS->USUARIO   	:= clUSER  //USUARIO QUE EMITIU O PEDIDO
								DGXLS->VALFAT		:= (IIF((cAliasSD1)->F2_TIPO == "P",0,nTotal)+nVALIPI+nValor2)* -1//+nAdic //-nTOT1//-(cAliasSD1)->(D1_VALFRE + D1_SEGURO + D1_ICMSRET + D1_VALIPI + D1_TOTAL)
								DGXLS->META		:= 0
								DGXLS->PEDIDO		:= 	cmPedido
								DGXLS->ITEMPED	:= cmItemPed
								DGXLS->STATUSCML	:= " "//noacento(GETADVFVAL("SX5","X5_DESCRI",XFILIAL("SX5")+"ZX"+(clAlias)->B1_STACML,1,""))
								
								DGXLS->TB_VALOR1  := -nQtdVend  //quantidade vendida
								DGXLS->TB_VALOR2  := -(IIF((cAliasSD1)->F2_TIPO == "P",0,nTotal)+nVALIPI+nValor2+nAdic) //Valor total
								DGXLS->TB_ICMS  :=- nVALICM //Valor ICMS
								DGXLS->TB_PIS  := -(cAliasSD1)->D1_VALIMP6 //Valor PIS
								DGXLS->TB_COFINS  := -(cAliasSD1)->D1_VALIMP5 //Valor COFINS
								DGXLS->TB_IPI  := -nVALIPI                 //Valor IPI
								DGXLS->TB_ICMSRET  := -nValor2 //Valor ICMS-ST
								DGXLS->TB_FRETE  := -nFrete   //Valor Frete
								DGXLS->TB_SEGURO  := -nSeguro  //Valor Seguro
								DGXLS->TB_DESPESA := -nDespesa //Valor Despesa
								DGXLS->TB_CUSTUNI := -(cAliasSD1)->D1_CUSTO/nQtdVend   //Custo Unitário
								DGXLS->TB_VALOR11 := -nQtdVend  //quantidade vendida
								DGXLS->TB_VALOR12 := -nTOTAL-nVALIPI //Valor total
								DGXLS->TB_VALOR13 := -nVALICM //Valor ICMS
								DGXLS->TB_VALOR14 := -(cAliasSD1)->D1_VALIMP6 //Valor PIS
								DGXLS->TB_VALOR15 := -(cAliasSD1)->D1_VALIMP5 //Valor COFINS
								DGXLS->TB_VALOR16 := -nVALIPI //Valor IPI
								
								DGXLS->(MsUnlock())
							EndIf
						EndIf
					EndIf
				Endif
				//Next nContador
			EndIf
		EndIf
		
		dbSelectArea(cAliasSD1)
		(cAliasSD1)->(dbSkip())
		
	EndDo
	(cAliasSD1)->(dbCloseArea())
	cWhere := "" 
	
	cWhereAux 	:= ""
	cVendedor 	:= "1"
	
	cWhere += "%"
	cAddField := "%"
	If cPaisLoc == "BRA"
		For nCampo := 1 To nVendedor
			cCampo := "F2_VEND"+cVendedor
			If SF2->(FieldPos(cCampo)) > 0
				cWhereAux += "(" + cCampo + " between '" + CD_par03 + "' and '" + CD_par04 + "') or "
				cAddField += ", "  + cCampo
			EndIf
			cVendedor := Soma1(cVendedor,1)
		Next nCampo
	Else
		For nCampo := 1 To 35
			cCampo := "F1_VEND"+cVendedor
			If SF1->(FieldPos(cCampo)) > 0
				cWhereAux += "(" + cCampo + " between '" + CD_par03 + "' and '" + CD_par04 + "') or "
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
	//Alteração no where para adicionar o tratamento do novo parametro CD_par20
	cWhere := SubStr(AllTrim(cWhere),1,Len(AllTrim(cWhere))-1)

	If CD_par20 == 1
		cWhere += " AND D1_DTDIGIT between '" + StrZero(val(SubStr(DTOS(CD_par01),1,4))-1,4) + SubStr(DTOS(CD_par01),5,4) + "' AND '" + StrZero(val(SubStr(DTOS(CD_par02),1,4))-1,4) + SubStr(DTOS(CD_par02),5,4) + "' %"
	Else
		cWhere += " AND F2_EMISSAO between '" + StrZero(val(SubStr(DTOS(CD_par01),1,4))-1,4) + SubStr(DTOS(CD_par01),5,4) + "' AND '" +  StrZero(val(SubStr(DTOS(CD_par02),1,4))-1,4) + SubStr(DTOS(CD_par02),5,4) + "' %"
	EndIf
	
	clQry2 := " SELECT SD1.*, F1_EMISSAO, F1_DOC, F1_SERIE, F1_FORNECE, F1_LOJA, F1_FRETE, F1_DESPESA, F1_SEGURO, F1_ICMSRET,F1_COND, F1_REFAT,
	clqry2 += "	F1_DTDIGIT,F1_MOTIVO,F1_JUSTIF, F2_TIPO, F2_EMISSAO, F2_CLIENTE, F2_LOJA,F2_VEND1, F2_VEND2,F2_VEND3, F1_TXMOEDA, F1_MOEDA " + SubStr(cAddField,2,Len(cAddField)-1)
	clqry2 += "	FROM " + RetSqlName("SD1") + " SD1, " + RetSqlName("SF4") + " SF4, " + RetSqlName("SF2") + " SF2, " + RetSqlName("SF1") + " SF1"
	clqry2 += "	WHERE D1_FILIAL  = '" + xFilial("SD1") + "'"
	clqry2 += "	AND D1_DTDIGIT between '" + StrZero(val(SubStr(DTOS(CD_par01),1,4))-1,4) + SubStr(DTOS(CD_par01),5,4) + "' AND '" +  StrZero(val(SubStr(DTOS(CD_par02),1,4))-1,4) + SubStr(DTOS(CD_par02),5,4)  + "'"
	clqry2 += "	AND F1_EST between '" + CD_par12 + "' AND '" + CD_par13 + "'"
	clqry2 += "	AND D1_COD between '" + CD_par14 + "' AND '" + CD_par15 + "'"
	clqry2 += "	AND D1_TIPO = 'D'"
	clqry2 += "	AND F4_FILIAL  = '" + xFilial("SF4") + "'"
	clqry2 += "	AND F4_CODIGO  = D1_TES"
	clqry2 += "	AND F2_FILIAL  = '" + xFilial("SF2") + "'"
	clqry2 += "	AND F2_DOC     = D1_NFORI"
	clqry2 += "	AND F2_SERIE   = D1_SERIORI"
	clqry2 += "	AND F2_LOJA    = D1_LOJA"
	clqry2 += "	AND F1_FILIAL  = '" + xFilial("SF1") + "'"
	clqry2 += "	AND F1_DOC     = D1_DOC"
	clqry2 += "	AND F1_SERIE   = D1_SERIE"
	clqry2 += "	AND F1_FORNECE = D1_FORNECE"
	clqry2 += "	AND F1_LOJA    = D1_LOJA"
	clqry2 += "	AND SD1.D_E_L_E_T_ = ' '"
	clqry2 += "	AND SF4.D_E_L_E_T_ = ' '"
	clqry2 += "	AND SF2.D_E_L_E_T_ = ' '"
	clqry2 += "	AND SF1.D_E_L_E_T_ = ' '"
	clqry2 += "	AND " + SubStr(cWhere,2,Len(cWhere)-2)
	clqry2 += "	ORDER BY D1_FILIAL,D1_DTDIGIT,D1_DOC
	//,D1_NUMSEQ
	clQry2 := ChangeQuery(clQry2)
	dbUseArea(.T.,"TOPCONN",TCGENQRY(,,clQry2),cAliasSD1, .T., .T.)
	dbGoTop()
	//oReport:Section(3):EndQuery()
	
	DbSelectArea(cAliasSD1)
	DbGotop()
	While !(cAliasSD1)->(Eof())
		nTOTAL :=0
		nVALICM:=0
		nVALIPI:=0
		nQtdVend:= 0
		nmedia	:= 0
		cCodPro	:= (cAliasSD1)->D1_COD
		SB1->(dbSeek(xFilial("SB1")+(cAliasSD1)->D1_COD))
		cItemCC	:= SB1->B1_ITEMCC //getadvfval("SB1","B1_ITEMCC",xFilial("SB1")+cCodPro,1,"")
		cPublish:= SB1->B1_PUBLISH  //getadvfval("SB1","B1_PUBLISH",xFilial("SB1")+cCodPro,1,"")
		cCdPlat	:= SB1->B1_PLATAF //getadvfval("SB1","B1_PLATAF",xFilial("SB1")+cCodPro,1,"")
		cDescPro:= SB1->B1_XDESC  //getadvfval("SB1","B1_XDESC",xFilial("SB1")+cCodPro,1,"")
		cPlataf := " "
		If SZ5->(dbSeek(xFilial("SZ5")+SUBSTR(cCdPlat,1,6)))
			cPlataf	:= SZ5->Z5_PLATRED  ///getadvfval("SZ5","Z5_PLATRED",xFilial("SZ5")+SUBSTR(cCdPlat,1,6),1,"")
		EndIf
		
		
		cCodcli	:= (cAliasSD1)->D1_FORNECE
		cLjcli	:= (cAliasSD1)->D1_LOJA
		cCodPro	:= (cAliasSD1)->D1_COD
		SA1->(dbSeek(xFilial("SA1") + cCodcli+cLjcli))
		cUF		:= SA1->A1_EST //getadvfval("SA1","A1_EST",xFilial("SA1")+cCodcli+cLjcli,1,"")
		cNome	:= SA1->A1_NREDUZ //getadvfval("SA1","A1_NREDUZ",xFilial("SA1")+cCodcli+cLjcli,1,"")
		cycanal	:= SA1->A1_YCANAL //getadvfval("SA1","A1_YCANAL",xFilial("SA1")+cCodcli+cLjcli,1,"")
		cyDcanal:= SA1->A1_YDCANAL //getadvfval("SA1","A1_YDCANAL",xFilial("SA1")+cCodcli+cLjcli,1,"")
		nTaxa	:=	IIf((cAliasSD1)->(FieldPos("F1_TXMOEDA"))>0,(cAliasSD1)->F1_TXMOEDA,0)
		nMoedNF	:=	IIf((cAliasSD1)->(FieldPos("F1_MOEDA"))>0,(cAliasSD1)->F1_MOEDA,0)
		clVend1 := " "
		clVend2 := " "
		clvend3 := " "
		If SA3->(dbSeek(xfilial("SA3") + (cAliasSD1)->F2_VEND1 ))
			clVend1 := SA3->A3_NOME //getadvfval("SA3","A3_NOME",xFilial("SA3")+(cAliasSD1)->F2_VEND1,1,"")
		EndIf
		If SA3->(dbSeek(xfilial("SA3") + (cAliasSD1)->F2_VEND2 ))
			clVend2 := SA3->A3_NOME //getadvfval("SA3","A3_NOME",xFilial("SA3")+(cAliasSD1)->F2_VEND2,1,"")
		EndIf
		If SA3->(dbSeek(xfilial("SA3") + (cAliasSD1)->F2_VEND3 ))
			clVend3 := SA3->A3_NOME //getadvfval("SA3","A3_NOME",xFilial("SA3")+(cAliasSD1)->F2_VEND3,1,"")
		EndIf
		DbSelectArea("SX5")
		SX5->(DbSetOrder(1))
		If SX5->(DbSeek(xFilial("SX5")+AvKey("Z5","X5_TABELA")+AvKey((cAliasSD1)->F1_MOTIVO,"X5_CHAVE")))
			cMotivo := SubStr(SX5->X5_DESCRI,1,30)
		Else
			cMotivo := (cAliasSD1)->F1_MOTIVO
		EndIf
		If !Empty((cAliasSD1)->F1_COND)
			clCondpg := getadvfval("SE4","E4_DESCRI",xFilial("SE4")+(cAliasSD1)->F1_COND,1,"")
		Else
			clCondPg := " "
		EndIf
		
		//clUSER := getadvfval("SC6","C6_X_USRLBI",xFilial("SC6")+(cAliasSD2)->D2_PEDIDO + (cAliasSD2)->D2_ITEMPV,1,"")
		clUser := " "
		alArea := SD2->(GetArea())
		DbSelectArea("SD2")
		DbSetOrder(3)
		If SD2->(dbSeek(xFilial("SF1")+(cAliasSD1)->D1_NFORI+(cAliasSD1)->D1_SERIORI+(cAliasSD1)->D1_FORNECE+(cAliasSD1)->D1_LOJA+(cAliasSD1)->D1_COD+(cAliasSD1)->D1_ITEMORI ))
			nlPrcTab := getadvfval("SC6","C6_PRCTAB",xFilial("SC6")+SD2->D2_PEDIDO + SD2->D2_ITEMPV,1,"")
			clRegradesc := getadvfval("SC6","C6_REGDESC",xFilial("SC6")+SD2->D2_PEDIDO + SD2->D2_ITEMPV,1,"")
			nlPRegrades := getadvfval("SC6","C6_PREGDES",xFilial("SC6")+SD2->D2_PEDIDO + SD2->D2_ITEMPV,1,"")
			clTabela := getadvfval("SC5","C5_TABELA",xFilial("SC5")+SD2->D2_PEDIDO ,1,"")
			cmPedido := SD2->D2_PEDIDO
			cmItemPed := SD2->D2_ITEMPV
		Else
			nlPrcTab := 0
			clRegradesc := " "
			nlPRegrades := 0
			clTabela := "  "
			cmPedido := " "
			cmItemPed := " "
		EndIf
		
		
		
		// Considera Adicionais
		nAdic 	:= 0
		nFrete	:= (cAliasSD1)->D1_VALFRE
		nSeguro	:= (cAliasSD1)->D1_SEGURO
		nDespesa:= (cAliasSD1)->D1_DESPESA
		
		//Campos buscados do cadastro de produtos e não da tabela SD2 propositalmente
		If !(cItemCC >= CD_par16 .and. cItemCC <= CD_par17 .and. cCdPlat >= CD_par18 .and. cCdPlat <= CD_par19)
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
			If CD_PAR10 == 1 .Or. Empty((cAliasSD1)->F2_EMISSAO)
				DtMoedaDev  := (cAliasSD1)->F1_DTDIGIT
			Else
				DtMoedaDev  := (cAliasSD1)->F2_EMISSAO
			EndIf
			
			If AvalTes((cAliasSD1)->D1_TES,cEstoq,cDupli)
				
				nVALICM := xMoeda((cAliasSD1)->D1_VALICM,1,CD_par06,DtMoedaDev,nDecs+1)
				nVALIPI := xMoeda((cAliasSD1)->D1_VALIPI,1,CD_par06,DtMoedaDev ,nDecs+1)
				nTOTAL  := xMoeda(((cAliasSD1)->D1_TOTAL - (cAliasSD1)->D1_VALDESC),1,CD_par06,DtMoedaDev,nDecs+1)
				nQtdVend:= (cAliasSD1)->D1_QUANT
				nFrete	:= (cAliasSD1)->D1_VALFRE
				nSeguro	:= (cAliasSD1)->D1_SEGURO
				nDespesa:= (cAliasSD1)->D1_DESPESA
				If CD_par11 == 2
					//nAdic := xMoeda((cAliasSD1)->F1_FRETE+(cAliasSD1)->F1_DESPESA+(cAliasSD1)->F1_SEGURO,1,CD_par06,DtMoedaDev,nDecs+1)
					nAdic := (cAliasSD1)->D1_VALFRE+(cAliasSD1)->D1_DESPESA+(cAliasSD1)->D1_SEGURO //xMoeda((cAliasSD1)->D1_VALFRE+(cAliasSD1)->D1_DESPESA+(cAliasSD1)->D1_SEGURO,1,CD_par06,DtMoedaDev,nDecs+1)
				EndIf
				//nValor2	:= xMoeda((cAliasSD1)->F1_ICMSRET,1,CD_par06,DtMoedaDev,nDecs+1)
				nValor2	:= xMoeda((cAliasSD1)->D1_ICMSRET,1,CD_par06,DtMoedaDev,nDecs+1)
				
				cVendedor := "1"
				//For nContador := 1 TO nVendedor
				dbSelectArea("DGXLS")
				dbSetOrder(nOrdem)
				cVend := (cAliasSD1)->(FieldGet((cAliasSD1)->(FieldPos("F2_VEND"+cVendedor))))
				cVendedor := Soma1(cVendedor,1)
				//cVendedor := "F2_VEND1"
				If cCodcli >= CD_PAR03 .And. cCodcli <= CD_PAR04
					//If Empty(cVend) .and. nContador > 1
					//	Loop
					//	EndIf
					If ( aScan(aVend,cVend) == 0 )
						AADD(aVend,cVend)
					EndIf
					If nTOTAL > 0
						If nOrdem == 1
							//DtMoedaDev  := (cAliasSD1)->F1_DTDIGIT
							//nTax	:=	IIf((cAliasSD1)->(FieldPos("F1_TXMOEDA"))>0,(cAliasSD1)->F1_TXMOEDA,0)
							//nMoed	:=	IIF((cAliasSD1)->(FieldPos("F1_MOEDA"))>0,(cAliasSD1)->F1_MOEDA,1)
		 					//nTOT1	:= xMoeda(((cAliasSD1)->D1_TOTAL -(cAliasSD1)->D1_VALDESC),nMoed,1,DtMoedaDev,nDecs+1) //nTOT1	:= xMoeda(((cAliasSD1)->D1_TOTAL -(cAliasSD1)->D1_VALDESC),nMoed,1,DtMoedaDev,nDecs+1,nTax)

							If RecLock("DGXLS",.T.)
								DGXLS->FILIAL		:= (cAliasSD1)->D1_FILIAL
								DGXLS->DOC		:= (cAliasSD1)->D1_DOC
								DGXLS->SERIE     	:= (cAliasSD1)->D1_SERIE
								DGXLS->CODCLI		:= (cAliasSD1)->D1_FORNECE
								DGXLS->LOJA		:= (cAliasSD1)->D1_LOJA
								DGXLS->CLIENTE	:= cNome
								DGXLS->UF			:= cUF //"  " //(cAliasSD1)->D1_EST
								DGXLS->PRODUTO	:= (cAliasSD1)->D1_COD
								DGXLS->D2ITEM		:= (cAliasSD1)->D1_ITEM
								DGXLS->DATANF		:= StoD((cAliasSD1)->F1_DTDIGIT)//Pela data de digitação da NF
								DGXLS->ANO			:= strzero(Year(STOD((cAliasSD1)->F1_DTDIGIT)),4)
								DGXLS->MES			:= STRZERO(MONTH(STOD((cAliasSD1)->F1_DTDIGIT)),2)
								If MONTH(STOD((cAliasSD1)->F1_DTDIGIT)) <= 3
									DGXLS->QUARTER		:= "Q1"
								ElseIf MONTH(STOD((cAliasSD1)->F1_DTDIGIT)) > 3 .And. MONTH(STOD((cAliasSD1)->F1_DTDIGIT)) <= 6
									DGXLS->QUARTER		:= "Q2"
								ElseIf MONTH(STOD((cAliasSD1)->F1_DTDIGIT)) > 6 .And. MONTH(STOD((cAliasSD1)->F1_DTDIGIT)) <= 9
									DGXLS->QUARTER		:= "Q3"
								ElseIf MONTH(STOD((cAliasSD1)->F1_DTDIGIT)) > 9 //.And. MONTH(STOD((clAlias)->F1_DTDIGIT)) <= 12
									DGXLS->QUARTER		:= "Q4"
								EndIf
								
								DGXLS->TIPONF     	:= (cAliasSD1)->D1_TIPO
								DGXLS->MOTIVO     	:= cMotivo ///(cAliasSD1)->F1_MOTIVO
								DGXLS->JUSTIFICAT	:= (cAliasSD1)->F1_JUSTIF
								DGXLS->REFAT			:= (cAliasSD1)->F1_REFAT
								DGXLS->CFOP			:= (cAliasSD1)->D1_CF
								DGXLS->CODVEN1     := (cAliasSD1)->F2_VEND1
								DGXLS->CODVEN2     := (cAliasSD1)->F2_VEND1
								DGXLS->CODVEN3     := (cAliasSD1)->F2_VEND3
								DGXLS->VEND1		:= clVend1
								DGXLS->VEND1		:= clVenD1
								DGXLS->VEND3		:= clVend3
								//DGXLS->CANALCLI := (clAlias)->A1_YCANAL
								//CRIAR DESCRICAO
								DGXLS->GRPREP		:= cyCanal
								DGXLS->CANAL 	:= cyDcanal
								DGXLS->CODPGTO	:= (cAliasSD1)->F1_COND
								DGXLS->CONDPG		:= clCondPg
								DGXLS->TITULONC	:= cDescPro
								DGXLS->TB_PLATRED := cPlataf
								DGXLS->TB_PUBLISH	:= cPublish
								DGXLS->CATEGORIA	:= " "  // CARREGA DE OUTRA PLANILHA
								DGXLS->CAMPANHA	:= " " //CARREGA DE OUTRA PLANILHA DEFINIR REGRA
								DGXLS->QTDFAT		:= -(cAliasSD1)->D1_QUANT
								DGXLS->PRCVEN		:= (cAliasSD1)->D1_VUNIT
								DGXLS->PRCTAB		:= nlPrcTab
								DGXLS->CODTAB	   	:= clTabela
								DGXLS->PORCDESC	:= 0 //(((cAliasSD1)->D1_PRCVEN/nlPrcTab) * 100) - 100
								DGXLS->VALVEND	:= (cAliasSD1)->D1_VUNIT * -(cAliasSD1)->D1_QUANT
								DGXLS->VALTAB		:= -nlPrcTab * (cAliasSD1)->D1_QUANT
								DGXLS->REGRADESC	:= clRegradesc
								DGXLS->PREGRADESC	:= nlPRegrades
								DGXLS->USUARIO   	:= clUSER  //USUARIO QUE EMITIU O PEDIDO
								DGXLS->VALFAT		:= (IIF((cAliasSD1)->F2_TIPO == "P",0,nTotal)+nVALIPI+nValor2) * -1 //+nAdic // -nTOT1//-(cAliasSD1)->(D1_VALFRE + D1_SEGURO + D1_ICMSRET + D1_VALIPI + D1_TOTAL)
								DGXLS->META		:= 0
								DGXLS->PEDIDO		:= 	cmPedido
								DGXLS->ITEMPED	:= cmItemPed
								DGXLS->STATUSCML	:= " "//noacento(GETADVFVAL("SX5","X5_DESCRI",XFILIAL("SX5")+"ZX"+(clAlias)->B1_STACML,1,""))
								
								DGXLS->TB_VALOR1  := -nQtdVend  //quantidade vendida
								DGXLS->TB_VALOR2  := -(IIF((cAliasSD1)->F2_TIPO == "P",0,nTotal)+nVALIPI+nValor2 +nAdic) //Valor total
								DGXLS->TB_ICMS  := -nVALICM //Valor ICMS
								DGXLS->TB_PIS  := -(cAliasSD1)->D1_VALIMP6 //Valor PIS
								DGXLS->TB_COFINS  := -(cAliasSD1)->D1_VALIMP5 //Valor COFINS
								DGXLS->TB_IPI  := -nVALIPI                 //Valor IPI
								DGXLS->TB_ICMSRET  := -nValor2 //Valor ICMS-ST
								DGXLS->TB_FRETE  := -nFrete   //Valor Frete
								DGXLS->TB_SEGURO  := nSeguro  //Valor Seguro
								DGXLS->TB_DESPESA := nDespesa //Valor Despesa
								DGXLS->TB_CUSTUNI := (cAliasSD1)->D1_CUSTO/nQtdVend   //Custo Unitário
								DGXLS->TB_VALOR11 := -nQtdVend  //quantidade vendida
								DGXLS->TB_VALOR12 := -nTOTAL-nVALIPI //Valor total
								DGXLS->TB_VALOR13 := -nVALICM //Valor ICMS
								DGXLS->TB_VALOR14 := -(cAliasSD1)->D1_VALIMP6 //Valor PIS
								DGXLS->TB_VALOR15 := -(cAliasSD1)->D1_VALIMP5 //Valor COFINS
								DGXLS->TB_VALOR16 := -nVALIPI //Valor IPI
								
								DGXLS->(MsUnlock())
							EndIf
						EndIf
					EndIf
				Endif
				//Next nContador
			EndIf
		EndIf
		
		dbSelectArea(cAliasSD1)
		(cAliasSD1)->(dbSkip())
		
	EndDo
	(cAliasSD1)->(dbCloseArea())
EndIf

alMostra := {}

aadd(alMostra,{"000003"," ","AMERICANAS"})
aadd(alMostra,{"000535"," ","SARAIVA.COM"})
aadd(alMostra,{"000105"," ","LOJAS AMERICANAS  (SP)"})
aadd(alMostra,{"002097"," ","PONTO FRIO MATRIZ"})
aadd(alMostra,{"001777","05","WAL MART"})
aadd(alMostra,{"000090"," ","UZ GAMES QUISQ S CRU"})
aadd(alMostra,{"002055"," ",	"EXTRA - MATRIZ"})
aadd(alMostra,{"002137"," ",	"RICARDO ELETRO - ESCRITORIO"})
aadd(alMostra,{"000011"," ",	"FNAC PINHEIROS"})
aadd(alMostra,{"002037"," ",	"CARREFOUR - OSASCO"})
aadd(alMostra,{"003295"," ",	"NETSHOES"})
aadd(alMostra,{"001392"," ",	"LIVRARIAS CURITIBA"})
aadd(alMostra,{"001933"," ",	"LIVRARIA CULTURA  ESCRITORIO"})
aadd(alMostra,{"000167"," ",	"MAGAZINE LUIZA"})
aadd(alMostra,{"001741"," ",	"CTIS TECNOLOGIA MATRIZ"})
aadd(alMostra,{"002597"," ",	"LIVRARIA DA FOLHA"})
aadd(alMostra,{"000923"," ",	"PERNAMBUCANAS"})
aadd(alMostra,{"001993"," ",	"BITPOPSHOP"})
aadd(alMostra,{"004103"," ",	"GIMBA"})
aadd(alMostra,{"003930"," ",	"BLOCKBUSTER"})
aadd(alMostra,{"000038"," ",	"SHOP TIME  (SP)"})
aadd(alMostra,{"000032"," ",	"FAST SHOP"})
aadd(alMostra,{"001777"," ",	"WAL MART SUPERCENTER"})
aadd(alMostra,{"000468"," ",	"PB KIDS HIGIENOPOLIS"})
aadd(alMostra,{"001186"," ",	"KALUNGA"})
aadd(alMostra,{"001817"," ",	"SNIPER GAME"})
aadd(alMostra,{"001475"," ",	"CASA E VIDEO (RAZAO ANTIGA)"})
aadd(alMostra,{"000232"," ",	"RI RAPPY - ESCRITORI"})
aadd(alMostra,{"000030"," ",	"SUBMARINO"})
//aadd(alMostra,{"ESP",,	"Especializado"})
//aadd(alMostra,{"ENORTE,,	"NORTE"})
//aadd(alMostra,{ENORD ,,	"NORDESTE"})
//aadd(alMostra,{ECENOEST,,	"CENTRO-OESTE"})
//aadd(alMostra,{ESUD,,	"SUDESTE"})
//aadd(alMostra,{ESUL,,	"SUL"})
//aadd(alMostra,{REG1,,	"Regional 1"})
//aadd(alMostra,{REG1SUL,,	"SUL"})
//aadd(alMostra,{REG1SUD,,	"SUDESTE"})
//aadd(alMostra,{REG2,,	"Regional 2"})
//aadd(alMostra,{REG2NORT,,	"NORTE"})
//aadd(alMostra,{REG2NORD,,	"NORDESTE"})
//aadd(alMostra,{REG2CENOEST,,	"CENTRO-OESTE"})
//aadd(alMostra,{VI	,,"Vendas Internas"})//
//aadd(alMostra,{VINORT,,	"NORTE"})
//aadd(alMostra,{VINORD,,	"NORDESTE"})
//aadd(alMostra,{NICENOEST,,	"CENTRO-OESTE"})
//aadd(alMostra,{VISUD,,	"SUDESTE"})
//aadd(alMostra,{VISUL,,	"SUL"})

For nli := 1 to Len(alMostra) 
	If RecLock("DGXLS",.T.)
	
		DGXLS->FILIAL		:= xFilial("SD1") //(cAliasSD1)->D1_FILIAL
		DGXLS->DOC		:= " " //(cAliasSD1)->D1_DOC
		DGXLS->SERIE     	:= " "//(cAliasSD1)->D1_SERIE
		DGXLS->CODCLI		:= alMostra[nli,1] //(cAliasSD1)->D1_FORNECE
		DGXLS->LOJA		:= alMostra[nli,2]  //(cAliasSD1)->D1_LOJA
		DGXLS->CLIENTE	:= "  " //cNome
		DGXLS->UF			:= "  " ////"  "cUF //"  " //(cAliasSD1)->D1_EST
		DGXLS->PRODUTO	:= "  " ////"  "(cAliasSD1)->D1_COD
		DGXLS->D2ITEM		:= "  " //(cAliasSD1)->D1_ITEM
		DGXLS->DATANF		:=  cd_PAR02  //StoD((cAliasSD1)->F1_DTDIGIT)//Pela data de digitação da NF
		DGXLS->ANO			:= strzero(Year(cd_PAR02),4)
		DGXLS->MES			:= STRZERO(MONTH(cd_PAR02),2)
		If MONTH(cd_PAR02) <= 3
			DGXLS->QUARTER		:= "Q1"
		ElseIf MONTH(cd_PAR02) > 3 .And. MONTH(cd_PAR02) <= 6
	   		DGXLS->QUARTER		:= "Q2"
		ElseIf MONTH(cd_PAR02) > 6 .And. MONTH(cd_PAR02) <= 9
	   		DGXLS->QUARTER		:= "Q3"
		ElseIf MONTH(cd_PAR02) > 9 //.And. MONTH(STOD((clAlias)->F1_DTDIGIT)) <= 12
			DGXLS->QUARTER		:= "Q4"
		EndIf
		
		DGXLS->TIPONF     	:= "N"
		DGXLS->MOTIVO     	:= " " //cMotivo ///(cAliasSD1)->F1_MOTIVO
		DGXLS->JUSTIFICAT	:= " " //(cAliasSD1)->F1_JUSTIF
		DGXLS->REFAT		:= " " // (cAliasSD1)->F1_REFAT
		DGXLS->CFOP			:= " " // (cAliasSD1)->D1_CF
		DGXLS->CODVEN1     := " " // (cAliasSD1)->F2_VEND1
		DGXLS->CODVEN2     := " " // (cAliasSD1)->F2_VEND1
		DGXLS->CODVEN3     := " " // (cAliasSD1)->F2_VEND3
		DGXLS->VEND1		:= " " // clVend1
		DGXLS->VEND1		:= "  " //clVenD1
		DGXLS->VEND3		:= " " //clVend3
		//DGXLS->CANALCLI := (clAlias)->A1_YCANAL
		//CRIAR DESCRICAO
		DGXLS->GRPREP		:= " " //cyCanal
		DGXLS->CANAL 	:= " " //cyDcanal
		DGXLS->CODPGTO	:= " " //(cAliasSD1)->F1_COND
		DGXLS->CONDPG		:= " " //clCondPg
		DGXLS->TITULONC	:= " " // cDescPro
		DGXLS->TB_PLATRED := " " //cPlataf
		DGXLS->TB_PUBLISH	:= " " //cPublish
		DGXLS->CATEGORIA	:= " "  // CARREGA DE OUTRA PLANILHA
		DGXLS->CAMPANHA	:= " " //CARREGA DE OUTRA PLANILHA DEFINIR REGRA
		DGXLS->QTDFAT		:= 0 //-(cAliasSD1)->D1_QUANT
		DGXLS->PRCVEN		:= 0 //(cAliasSD1)->D1_VUNIT
		DGXLS->PRCTAB		:= 0 //nlPrcTab
		DGXLS->CODTAB	   	:= "  " //0 //clTabela
		DGXLS->PORCDESC	:= 0 //(((cAliasSD1)->D1_PRCVEN/nlPrcTab) * 100) - 100
		DGXLS->VALVEND	:= 0 //(cAliasSD1)->D1_VUNIT * -(cAliasSD1)->D1_QUANT
		DGXLS->VALTAB		:= 0 //nlPrcTab * (cAliasSD1)->D1_QUANT
		DGXLS->REGRADESC	:= " " //clRegradesc
		DGXLS->PREGRADESC	:= 0 //nlPRegrades
		DGXLS->USUARIO   	:= " " //clUSER  //USUARIO QUE EMITIU O PEDIDO
		DGXLS->VALFAT		:= 0 //(cAliasSD1)->(D1_VALFRE + D1_SEGURO + D1_ICMSRET + D1_VALIPI + D1_TOTAL)
		DGXLS->META		:= 0
		DGXLS->PEDIDO		:= " " //	cmPedido
		DGXLS->ITEMPED	:= " " //cmItemPed
		DGXLS->STATUSCML	:= " "//noacento(GETADVFVAL("SX5","X5_DESCRI",XFILIAL("SX5")+"ZX"+(clAlias)->B1_STACML,1,""))
		DGXLS->TB_VALOR1  := 0 //-nQtdVend  //quantidade vendida
		DGXLS->TB_VALOR2  := 0 // IIF((cAliasSD1)->F2_TIPO == "P",0,nTotal)+nVALIPI+nValor2+nAdic //Valor total
		DGXLS->TB_ICMS  := 0 //nVALICM //Valor ICMS
		DGXLS->TB_PIS  := 0 //(cAliasSD1)->D1_VALIMP6 //Valor PIS
		DGXLS->TB_COFINS  := 0 //(cAliasSD1)->D1_VALIMP5 //Valor COFINS
		DGXLS->TB_IPI  := 0 //nVALIPI                 //Valor IPI
		DGXLS->TB_ICMSRET  := 0 //nValor2 //Valor ICMS-ST
		DGXLS->TB_FRETE  := 0 //nFrete   //Valor Frete
		DGXLS->TB_SEGURO  := 0 //nSeguro  //Valor Seguro
		DGXLS->TB_DESPESA := 0 //nDespesa //Valor Despesa
		DGXLS->TB_CUSTUNI := 0 //(cAliasSD1)->D1_CUSTO/nQtdVend   //Custo Unitário
		DGXLS->TB_VALOR11 := 0 //-nQtdVend  //quantidade vendida
		DGXLS->TB_VALOR12 := 0 //-nTOTAL-nVALIPI //Valor total
		DGXLS->TB_VALOR13 := 0 //-nVALICM //Valor ICMS
		DGXLS->TB_VALOR14 := 0 //-(cAliasSD1)->D1_VALIMP6 //Valor PIS
		DGXLS->TB_VALOR15 := 0 //-(cAliasSD1)->D1_VALIMP5 //Valor COFINS
		DGXLS->TB_VALOR16 := 0 //-nVALIPI //Valor IPI
		
		DGXLS->(MsUnlock())
	EndIf  
Next nli
	    
	
For nli := 1 to Len(alMostra)

	If RecLock("DGXLS",.T.)
	
		DGXLS->FILIAL		:= xFilial("SD1") //(cAliasSD1)->D1_FILIAL
		DGXLS->DOC		:= " " //(cAliasSD1)->D1_DOC
		DGXLS->SERIE     	:= " "//(cAliasSD1)->D1_SERIE
		DGXLS->CODCLI		:= alMostra[nli,1]  ////(cAliasSD1)->D1_FORNECE
		DGXLS->LOJA		:= alMostra[nli,2] ///(cAliasSD1)->D1_LOJA
		DGXLS->CLIENTE	:= "  " //cNome
		DGXLS->UF			:= "  " ////"  "cUF //"  " //(cAliasSD1)->D1_EST
		DGXLS->PRODUTO	:= "  " ////"  "(cAliasSD1)->D1_COD
		DGXLS->D2ITEM		:= "  " //(cAliasSD1)->D1_ITEM
		DGXLS->DATANF		:=  cd_PAR01 //StoD((cAliasSD1)->F1_DTDIGIT)//Pela data de digitação da NF
		DGXLS->ANO			:= strzero(Year(cd_PAR01),4)
		DGXLS->MES			:= STRZERO(MONTH(cd_PAR01),2)
		If MONTH(cd_PAR01) <= 3
			DGXLS->QUARTER		:= "Q1"
		ElseIf MONTH(cd_PAR01) > 3 .And. MONTH(cd_PAR01) <= 6
	   		DGXLS->QUARTER		:= "Q2"
		ElseIf MONTH(cd_PAR01) > 6 .And. MONTH(cd_PAR01) <= 9
	   		DGXLS->QUARTER		:= "Q3"
		ElseIf MONTH(cd_PAR01) > 9 //.And. MONTH(STOD((clAlias)->F1_DTDIGIT)) <= 12
			DGXLS->QUARTER		:= "Q4"
		EndIf
		
		DGXLS->TIPONF     	:= "D"
		DGXLS->MOTIVO     	:= " " //cMotivo ///(cAliasSD1)->F1_MOTIVO
		DGXLS->JUSTIFICAT	:= " " //(cAliasSD1)->F1_JUSTIF
		DGXLS->REFAT		:= " " // (cAliasSD1)->F1_REFAT
		DGXLS->CFOP			:= " " // (cAliasSD1)->D1_CF
		DGXLS->CODVEN1     := " " // (cAliasSD1)->F2_VEND1
		DGXLS->CODVEN2     := " " // (cAliasSD1)->F2_VEND1
		DGXLS->CODVEN3     := " " // (cAliasSD1)->F2_VEND3
		DGXLS->VEND1		:= " " // clVend1
		DGXLS->VEND1		:= "  " //clVenD1
		DGXLS->VEND3		:= " " //clVend3
		//DGXLS->CANALCLI := (clAlias)->A1_YCANAL
		//CRIAR DESCRICAO
		DGXLS->GRPREP		:= " " //cyCanal
		DGXLS->CANAL 	:= " " //cyDcanal
		DGXLS->CODPGTO	:= " " //(cAliasSD1)->F1_COND
		DGXLS->CONDPG		:= " " //clCondPg
		DGXLS->TITULONC	:= " " // cDescPro
		DGXLS->TB_PLATRED := " " //cPlataf
		DGXLS->TB_PUBLISH	:= " " //cPublish
		DGXLS->CATEGORIA	:= " "  // CARREGA DE OUTRA PLANILHA
		DGXLS->CAMPANHA	:= " " //CARREGA DE OUTRA PLANILHA DEFINIR REGRA
		DGXLS->QTDFAT		:= 0 //-(cAliasSD1)->D1_QUANT
		DGXLS->PRCVEN		:= 0 //(cAliasSD1)->D1_VUNIT
		DGXLS->PRCTAB		:= 0 //nlPrcTab
		DGXLS->CODTAB	   	:= "   " //0 //clTabela
		DGXLS->PORCDESC	:= 0 //(((cAliasSD1)->D1_PRCVEN/nlPrcTab) * 100) - 100
		DGXLS->VALVEND	:= 0 //(cAliasSD1)->D1_VUNIT * -(cAliasSD1)->D1_QUANT
		DGXLS->VALTAB		:= 0 //nlPrcTab * (cAliasSD1)->D1_QUANT
		DGXLS->REGRADESC	:= " " //clRegradesc
		DGXLS->PREGRADESC	:= 0 //nlPRegrades
		DGXLS->USUARIO   	:= " " //clUSER  //USUARIO QUE EMITIU O PEDIDO
		DGXLS->VALFAT		:= 0 //(cAliasSD1)->(D1_VALFRE + D1_SEGURO + D1_ICMSRET + D1_VALIPI + D1_TOTAL)
		DGXLS->META		:= 0
		DGXLS->PEDIDO		:= " " //	cmPedido
		DGXLS->ITEMPED	:= " " //cmItemPed
		DGXLS->STATUSCML	:= " "//noacento(GETADVFVAL("SX5","X5_DESCRI",XFILIAL("SX5")+"ZX"+(clAlias)->B1_STACML,1,""))
		DGXLS->TB_VALOR1  := 0 //-nQtdVend  //quantidade vendida
		DGXLS->TB_VALOR2  := 0 // IIF((cAliasSD1)->F2_TIPO == "P",0,nTotal)+nVALIPI+nValor2+nAdic //Valor total
		DGXLS->TB_ICMS  := 0 //nVALICM //Valor ICMS
		DGXLS->TB_PIS  := 0 //(cAliasSD1)->D1_VALIMP6 //Valor PIS
		DGXLS->TB_COFINS  := 0 //(cAliasSD1)->D1_VALIMP5 //Valor COFINS
		DGXLS->TB_IPI  := 0 //nVALIPI                 //Valor IPI
		DGXLS->TB_ICMSRET  := 0 //nValor2 //Valor ICMS-ST
		DGXLS->TB_FRETE  := 0 //nFrete   //Valor Frete
		DGXLS->TB_SEGURO  := 0 //nSeguro  //Valor Seguro
		DGXLS->TB_DESPESA := 0 //nDespesa //Valor Despesa
		DGXLS->TB_CUSTUNI := 0 //(cAliasSD1)->D1_CUSTO/nQtdVend   //Custo Unitário
		DGXLS->TB_VALOR11 := 0 //-nQtdVend  //quantidade vendida
		DGXLS->TB_VALOR12 := 0 //-nTOTAL-nVALIPI //Valor total
		DGXLS->TB_VALOR13 := 0 //-nVALICM //Valor ICMS
		DGXLS->TB_VALOR14 := 0 //-(cAliasSD1)->D1_VALIMP6 //Valor PIS
		DGXLS->TB_VALOR15 := 0 //-(cAliasSD1)->D1_VALIMP5 //Valor COFINS
		DGXLS->TB_VALOR16 := 0 //-nVALIPI //Valor IPI
		
		DGXLS->(MsUnlock()) 
	EndIf 
Next nli
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Impressao do Relatorio                                                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	
	//dbSetOrder(1)
	
	
alReturn := {}
dbSelectArea("DGXLS")
DGXLS->(dbgotop())

While !DGXLS->(EOF())
	If DGXLS->TIPONF == "N"
		nValLiq1 := DGXLS->(TB_VALOR2+TB_VALOR12) - DGXLS->(TB_ICMS+TB_PIS+TB_COFINS+TB_IPI+TB_ICMSRET+TB_FRETE+TB_SEGURO+TB_DESPESA+TB_VALOR13+TB_VALOR14+TB_VALOR15+TB_VALOR16+TB_VALOR17)
		
		NVALMGR1	:= nValLiq1-(DGXLS->(TB_CUSTUNI*(TB_VALOR1+TB_VALOR11)))
		nMARGBRUP1	:= NVALMGR1/nValLiq1
		NMARKUP1	:= (DGXLS->(TB_VALOR2+TB_VALOR12))/(DGXLS->(TB_CUSTUNI*(TB_VALOR1+TB_VALOR11)))
		If  DGXLS->UF $ "SP*RJ*MG*ES"
			clCANAL  := "SUDESTE"
		ElseIf DGXLS->UF $ "AM*RR*AP*RO*AC*TO"
			clCANAL  := "NORTE"
		ElseIf DGXLS->UF $ "MT*MS*DF*GO"
			clCANAL  := "CENTRO"      
		ElseIf DGXLS->UF $ "PR*SC*RS"
			clCANAL  := "SUL"
		Else 
			clCANAL  := "NORDESTE"
		EndIF
		
	 
		If RecLock("DGXLS",.F.)
			DGXLS->MARGBRU := NVALMGR1
			DGXLS->MARGBRUP := nMARGBRUP1
			DGXLS->MARKUP := NMARKUP1
			DGXLS->REGIAO := clCANAL
			DGXLS->(MsUnLock())
		EndIF
	EndIf
		
	DGXLS->(DbSkip())
End








                                                
/*
While !DGXLS->(eof()) //!Bof()
nValLiq1 := DGXLS->(TB_VALOR2+TB_VALOR12) - DGXLS->(TB_ICMS+TB_PIS+TB_COFINS+TB_IPI+TB_ICMSRET+TB_FRETE+TB_SEGURO+TB_DESPESA+TB_VALOR13+TB_VALOR14+TB_VALOR15+TB_VALOR16+TB_VALOR17)

MARGBRU	:= nValLiq1-(DGXLS->(TB_CUSTUNI*(TB_VALOR1+TB_VALOR11)))
MARGBRUP1	:= MARGBRU/nValLiq1
NMARKUP1	:= (DGXLS->(TB_VALOR2+TB_VALOR12))/(DGXLS->(TB_CUSTUNI*(TB_VALOR1+TB_VALOR11)))
AADD(alReturn,{DGXLS->FILIAL, DGXLS->DOC, DGXLS->SERIE, DGXLS->CODCLI, DGXLS->LOJA, DGXLS->CLIENTE, DGXLS->UF, DGXLS->PRODUTO, DGXLS->D2ITEM, DGXLS->DATANF;
,DGXLS->ANO, DGXLS->MES,	DGXLS->QUARTER, DGXLS->TIPONF, DGXLS->MOTIVO, DGXLS->JUSTIFICAT, DGXLS->REFAT, DGXLS->CFOP, DGXLS->CODVEN1, DGXLS->CODVEN2;
,DGXLS->CODVEN3,DGXLS->VEND1,DGXLS->VEND1,DGXLS->VEND3,DGXLS->GRPREP,DGXLS->CANAL,DGXLS->CODPGTO,DGXLS->CONDPG,DGXLS->TITULONC,DGXLS->TB_PLATRED;
,DGXLS->TB_PUBLISH,DGXLS->CATEGORIA,DGXLS->CAMPANHA,DGXLS->QTDFAT,DGXLS->PRCVEN,DGXLS->PRCTAB,DGXLS->VALVEND,DGXLS->VALTAB,DGXLS->TABELA,DGXLS->PORCDESC;
,DGXLS->REGRADESC,DGXLS->PREGRADESC,DGXLS->USUARIO,DGXLS->VALFAT,DGXLS->META,DGXLS->PEDIDO,DGXLS->ITEMPED,DGXLS->STATUSCML,DGXLS->TB_CUSTUNI;
,MARGBRU, MARGBRUP1, NMARKUP1,DGXLS->TB_ICMS,DGXLS->TB_PIS,DGXLS->TB_COFINS,DGXLS->TB_IPI,DGXLS->TB_ICMSRET,DGXLS->TB_FRETE,DGXLS->TB_SEGURO,DGXLS->TB_VALOR2})
FILIAL	DOC	SERIE	CLIENTE	LOJA	NOMEC	UF	PRODUTO	ITEMNF	DATA	ANO	MÊS	Quarter	TIPONF	MOTDEV	JUSTIFICATIVA	Refaturado	CFOP	CODVEN1	CODVEN2	CODVEN3	VENDED1	VENDED2	VENDED3	GRUPO	DESC	CODPG	CONDPG	TITULO NC	Plataforma	Publisher	CATEGORIA	CAMPANHA	QTD	PRCVEN	PRCTAB	VALVEND	VALTAB	CODTAB	PORCDESC	REGRADESC	PREGRADESC	USUARIO	VALFAT	METAS	PEDIDO	ITEMPED	STATUSCML	Custo Unitario	Margem Bruta	Margem Bruta %	Mark Up	ICMS	PIS	COFINS	IPI	ICMS-ST	FRETE	SEGURO	DESPESA	VALOR


/*
,DGXLS->TB_VALOR2;
,DGXLS->TB_ICMS,DGXLS->TB_PIS,DGXLS->TB_COFINS,DGXLS->TB_IPI,DGXLS->TB_ICMSRET,DGXLS->TB_FRETE,DGXLS->TB_SEGURO,DGXLS->TB_DESPESA,DGXLS->TB_CUSTUNI;
,DGXLS->TB_VALOR11,DGXLS->TB_VALOR12,DGXLS->TB_VALOR13,DGXLS->TB_VALOR14,DGXLS->TB_VALOR15,DGXLS->TB_VALOR16})
dbSkip()        */
//DGXLS->(dbSkip())
//dbSkip(-1)
//EndDo

dbSelectArea("DGXLS")
dbCloseArea()
//fErase(cNomArq+GetDBExtension())
fErase("DGXLS"+OrdBagExt())
//fErase(cNomArq2+OrdBagExt())/
//fErase(cNomArq3+OrdBagExt())//
//fErase(cNomArq4+OrdBagExt())

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Restaura a integridade dos dados                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SF2")
dbClearFilter()
dbSetOrder(1)

If Len(alArea) > 0
	RestArea(alArea)
EndIf


Return alReturn
	
	
	
	
	
	
