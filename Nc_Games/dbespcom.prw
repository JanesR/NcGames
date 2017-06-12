#Include "MATR580.CH"
#Include "FIVEWIN.Ch"
#INCLUDE "protheus.ch"     
#Include "TBICONN.CH"  
#INCLUDE "TOPCONN.CH" 


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณDBESPCOM บ Autor ณ Alberto Kibino    บ Data ณ  29/10/12     บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ RELATORIO PARA GERAR DBF PARA RELATึRIO de COMISSOES       บฑฑ
ฑฑบ          ณ Especializado		                                      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NCGAMES VENDAS Especializado                               บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

User Function DBESPCOM()

Local aTam			 := {}
Local nX := 0
Local cEstoq 	:= "SN"
Local cDupli 	:= "S"//If( (MV_PAR08 == 1),"S",If( (MV_PAR08 == 2),"N","SN" ) )
Local nContador,nTOTAL,nVALICM,nVALIPI,nQtdVend
Local nVendedor	:= " "//Fa440CntVen()
Local cVendedor	:= ""
Local aVend    	:= {}
Local aImpostos	:= {}
Local nImpos	:= 0.00
Local nMoedNF	:=	1
Local nTaxa		:=	0
Local cAddField	:=	""
Local cName     :=  ""
Local nCampo	:=	0
Local cCampo	:=	""
Local cSD1Old	:=	""
Local aStru		:=	{}
Local nY        := 	0
Local lFiltro   := .T.
Local lMR580FIL := ExistBlock("MR580FIL")
Local dtMoedaDev:= CtoD("")
Local cVend    	:= ""
Local dldtde	:= ""
Local dldtate	:= ""
Local cltime := "" 
Local cSA1Fil	:= ""
Local cSD1Fil	:= ""  
Local cDocDev	:= "" 
Local alData	:= {}
Local cSqlDev	:= "" 
Local cSqlSZ1	:= ""
Local cGrpCli	:= "" 
Local dtEntreg	:= CtoD("//")
Local cQano		:= ""  
Local cCalcPr	:= ""
Local cObsCalc	:= "" 
Local cDtLimite	:= ""
Local cCFOPS	:= ""
Local nValDesDev := 0 
Private alArea := {}                 	

Private nDecs:= 0
/*
ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
ณPERGUNTAS RELATORIO     RDESCF                                       |                                                                                                                                        ณ
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
ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
*/


Private aDbStru := {}
Private clAlias := ""
Private cAliSZ1	:= "" 

Private lAuto := IIF(Select("SM0") > 0, .f., .t.)
		
IF LAUTO                                          
	QOUT("Preparando Environment ... "+DTOC(Date()) + " - "+Time())
	PREPARE ENVIRONMENT EMPRESA '01' FILIAL '03' TABLES 'SA1,SE1,SF4,SFM' 
ENDIF 
nDecs:=msdecimais(1)
cSA1Fil	:= xFilial("SA1") 

clAlias := GetNextAlias()
cAliSZ1 := GetNextAlias() 
nVendedor	:= Fa440CntVen()
            
DBMCRIASX1()

If !Pergunte("DBM_ESPCOM",.T.)  
	Return
endIf

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

If MV_PAR01 == 1
 	alData := {DtoS(Firstday(StoD(MV_PAR02+"0101"))),DtoS(Lastday(StoD(MV_PAR02+"0301")))}
 	cQano := "1" + MV_PAR02
 	cDtLimite := AllTrim(MV_PAR02) + "04" + StrZero(GETMV("DBM_DTFCES"),2) 
ElseIf MV_PAR01 == 2
 	alData := {DtoS(Firstday(StoD(MV_PAR02+"0401"))),DtoS(Lastday(StoD(MV_PAR02+"0601")))}
	cQano := "2" + MV_PAR02 
	cDtLimite := AllTrim(MV_PAR02) + "07" + StrZero(GETMV("DBM_DTFCES"),2) 
ElseIf MV_PAR01 == 3
 	alData := {DtoS(Firstday(StoD(MV_PAR02+"0701"))),DtoS(Lastday(StoD(MV_PAR02+"0901")))}
 	cQano := "3" + MV_PAR02 
 	cDtLimite := AllTrim(MV_PAR02) + "10" + StrZero(GETMV("DBM_DTFCES"),2) 
Else
 	alData := {DtoS(Firstday(StoD(MV_PAR02+"1001"))),DtoS(Lastday(StoD(MV_PAR02+"1201")))}
 	cQano := "4" + MV_PAR02 
 	cDtLimite := AllTrim(Str(Val(MV_PAR02)+1)) + "01" + StrZero(GETMV("DBM_DTFCES"),2) 
EndIF
 
If Len(alData) > 1
	If ValType(alData[1]) == "N" 
		cldata := StoD(AllTrim(Str(alData[1])))
		cldtate := StoD(AllTrim(Str(alData[2])))
	Else
		cldata := StoD(alData[1])
		cldtate := StoD(alData[2])
	EndIf
EndIf

If Empty(cldata) 
	cl_PAR12 := FirstDay(cldata)
	cl_PAR13 := cldtate
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

dbSelectArea("SF2")
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

aTam:=TamSX3("D1_ITEM")
AADD(aDbStru,{"D2ITEM",aTam[3],aTam[1],aTam[2]})

aTam:=TamSX3("F2_EMISSAO")
AADD(aDbStru,{"DATANF","C",10,aTam[2]})

AADD(aDbStru,{"DATASTR","C",8,0})

AADD(aDbStru,{"DTENTR","D",8,0})
AADD(aDbStru,{"STRENTR","C",8,0})
AADD(aDbStru,{"ANO"   ,"C",4,0})
AADD(aDbStru,{"MES"   ,"C",2,0})
AADD(aDbStru,{"MESREA"   ,"C",2,0})
AADD(aDbStru,{"MESENTR"   ,"C",2,0})
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

If Len(aTam) == 0
	aTam := {30,0,"C"}
EndIf
AADD(aDbStru,{"CANAL"    ,aTam[3],aTam[1],aTam[2]})


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
AADD(aDbStru,{"QTDDEV"   ,aTam[3],aTam[1],aTam[2]})

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
AADD(aDbStru,{"VRLUNIDEV",aTam[3],aTam[1],aTam[2]})

aTam:=TamSX3("C5_TABELA")
If Len(aTam) == 0
	aTam := {6,0,"C"}
EndIf
AADD(aDbStru,{"CODTAB"	,aTam[3],aTam[1],aTam[2]})


AADD(aDbStru,{"PORCDESC" ,"N",14,2}) //((Valor de venda/ valor de tabela) * 100) - 100
AADD(aDbStru,{"COMISS" ,"N",4,2}) //((Valor de venda/ valor de tabela) * 100) - 100

aTam:=TamSX3("D2_CUSTO1")
AADD(aDbStru,{"CUSTO",aTam[3],aTam[1],aTam[2]})

aTam:=TamSX3("D2_TOTAL")
AADD(aDbStru,{"VALVEND",aTam[3],aTam[1],aTam[2]})

AADD(aDbStru,{"VALDEVM",aTam[3],aTam[1],aTam[2]})
AADD(aDbStru,{"VALDTOT",aTam[3],aTam[1],aTam[2]})
AADD(aDbStru,{"VALDSIMP",aTam[3],aTam[1],aTam[2]})
AADD(aDbStru,{"VLRUNIDEV",aTam[3],aTam[1],aTam[2]})

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
AADD(aDbStru,{"VRLCOMIS"	 ,aTam[3],20,7})
//AADD(aDbStru,{"USUARIO"  ,"C",014    ,0      })

AADD(aDbStru,{"META"	 ,"N",aTam[1],aTam[2]})

aTam:=TamSX3("C5_NUM")
AADD(aDbStru,{"PEDIDO"	 ,aTam[3],aTam[1],aTam[2]})

aTam:=TamSX3("C6_ITEM")
AADD(aDbStru,{"ITEMPED"	 ,aTam[3],aTam[1],aTam[2]})  
AADD(aDbStru,{"CALCULA"	 ,"C",1,0})
AADD(aDbStru,{"OBSCALC"	 ,"C",30,0})
                                  
                                  
AADD(aDbStru,{"STATUSCML","C",20,0})

If Select("DGXLS") > 0
	DGXLS->(dbCloseArea())
EndIf

clTime := Time()
While ":" $ clTime
	clTime := Stuff(clTime,At(":",clTime),1,"")
End

CNOMEDBF := "NCESPCOM"

If File("SYSTEM\" + CNOMEDBF + ".dbf")
	fErase("SYSTEM\" + CNOMEDBF +GetDBExtension())
EndIf

DBCREATE(CNOMEDBF,aDbStru,"DBFCDXADS")

MakeDir("C:\relatorios")

DbUseArea(.T.,"DBFCDXADS", "SYSTEM\" + CNOMEDBF,"DGXLS",.T.,.F.)

If File("DGXLS.cdx")
	fErase("DGXLS.cdx")
endIf

MyNewSX6( "DBM_ESPACC",  "000002", "C", "Grupo Especializado","Grupo Especializado","Grupo Especializado", .F. )
//MyNewSX6( "DBM_DTFCKA", 15, "N", "Data de Fechamento comissใo Canal Regional","Data de Fechamento comissใo Canal Regional","Data de Fechamento comissใo Canal Regional", .F. )
MyNewSX6( "DBM_DTFCES", 10, "N", "Data de Fechamento comissใo Canal Especializado","Data de Fechamento comissใo Canal Especializado","Data de Fechamento comissใo Canal Especializado", .F. )
MyNewSX6( "NCG_000036", "1202*2202*1411*2411", "C", "CFOPs que devem ser considerados nas devolu็๕es","CFOPs que devem ser considerados nas devolu็๕es","CFOPs que devem ser considerados nas devolu็๕es", .F. )
cGrpCli := AllTrim(GetMv("DBM_ESPACC"))                            
cGrpCli := StrTran(MV_PAR03,'*',";")
cGrpCli	:= StrTran(cGrpCli,',',";")
cGrpCli	:= StrTran(cGrpCli,'"',"")
cGrpCli	:= StrTran(cGrpCli,"'","")

cCFOPS := AllTrim(GetMv("NCG_000036")) 


cCFOPS := StrTran(cCFOPS,'*',";")
cCFOPS	:= StrTran(cCFOPS,',',";")
cCFOPS	:= StrTran(cCFOPS,'"',"")
cCFOPS	:= StrTran(cCFOPS,"'","")


If Select(clAlias) > 0
	dbSelectArea(clAlias)
	(clAlias)->(dbCloseArea())
Endif


_cQry:="	SELECT F2_FILIAL, F2_DOC, F2_SERIE, F2_COND,F2_CLIENTE, F2_LOJA, F2_EMISSAO, F2_VEND1, F2_VEND2, F2_VEND3, D2_ITEM, F2_YCANAL,"
_cQry+="		D2_DOC, D2_ITEM, D2_COD, D2_TOTAL, D2_QUANT, D2_PRCVEN, D2_VALIPI, D2_PICM, D2_EST, D2_TIPO, D2_CF,D2_PEDIDO, D2_ITEMPV, D2_CUSTO1, "
_cQry+="		F4_VENDA, D2_VALFRE, D2_SEGURO, D2_ICMSRET,D2_DESPESA,"
_cQry+="		B1_DESC, B1_XDESC, B1_STACML,B1_PUBLISH,B1_PLATAF,"
_cQry+="		A1_COD, A1_LOJA, A1_NOME, A1_NREDUZ,A1_YCANAL, A1_YDCANAL, A1_GRPVEN,"
_cQry+="		ACA_DESCRI," 
_cQry+="		A3_COD, A3_NOME, A3_GRPREP,"
_cQry+="		C6_PRCVEN, C6_PRCTAB, C6_X_USRLB,"
_cQry+="		C5_FATURPV, C5_TABELA,"
_cQry+="		E4_DESCRI, C6_REGDESC, C6_PREGDES " 
_cQry+="	FROM  " + RetSqlName("SF2") + " F2,"
_cQry+="		" + RetSqlName("SD2") + " D2,"
_cQry+="		" + RetSqlName("SF4") + " F4,"
_cQry+="		" + RetSqlName("SB1") + " B1,"
_cQry+="		" + RetSqlName("SA1") + " A1,"
_cQry+="		" + RetSqlName("SA3") + " A3,"
_cQry+="		" + RetSqlName("ACA") + " ACA,"
_cQry+="		" + RetSqlName("SC6") + " C6,"
_cQry+="		" + RetSqlName("SC5") + " C5,"
_cQry+="		" + RetSqlName("SE4") + " E4"
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
//_cQry+=" AND	ACA_GRPREP BETWEEN '" + cGrpCli + "' AND '" + cGrpCli + "'" 

_cQry+=" AND	ACA_GRPREP IN " +FormatIn(cGrpCli,";") + "" 

_cQry+="	AND  	F2_FILIAL 	= D2_FILIAL
_cQry+="	AND  	F2_DOC 		= D2_DOC
_cQry+="	AND  	F2_SERIE 	= D2_SERIE
_cQry+="	AND  	D2_TES 		= F4_CODIGO
_cQry+="	AND		F4_DUPLIC 	= 'S'
_cQry+="	AND  	D2_COD 		= B1_COD
_cQry+="	AND  	F2_CLIENTE 	= A1_COD
_cQry+="	AND  	F2_LOJA 	= A1_LOJA
_cQry+="	AND  	F2_VEND1 	= A3_COD
//_cQry+="	AND		A3_GRPREP 	= ACA_GRPREP                                L
_cQry+="	AND		F2_YCANAL 	= ACA_GRPREP  
_cQry+="	AND  	F2_FILIAL 	= C6_FILIAL
_cQry+="	AND  	D2_PEDIDO	= C6_NUM
_cQry+="	AND  	D2_ITEMPV	= C6_ITEM
_cQry+="	AND  	C6_FILIAL 	= C5_FILIAL
_cQry+="	AND  	C6_NUM 		= C5_NUM
_cQry+="	AND		E4_CODIGO 	= F2_COND
_cQry+="	AND  	F2.D_E_L_E_T_ 	!= '*'
_cQry+="	AND  	D2.D_E_L_E_T_ 	!= '*'
_cQry+="	AND  	F4.D_E_L_E_T_ 	!= '*'
_cQry+="	AND  	B1.D_E_L_E_T_ 	!= '*'
_cQry+="	AND  	A1.D_E_L_E_T_ 	!= '*'
_cQry+="	AND  	A3.D_E_L_E_T_ 	!= '*'
_cQry+="	AND  	ACA.D_E_L_E_T_ 	!= '*'
_cQry+="	AND  	C6.D_E_L_E_T_ 	!= '*'                  
_cQry+="	AND  	C5.D_E_L_E_T_ 	!= '*'"
_cQry+="	AND  	E4.D_E_L_E_T_ 	!= '*'"
IF cl_PAR09 == 2 .AND. cl_PAR14 == 1
	_cQry+=" ORDER BY 	A1_COD, A1_LOJA, F2_EMISSAO, A3_GRPREP, A1_NOME, F2_DOC, F2_SERIE "
ELSEIF cl_PAR09 == 1 .AND. cl_PAR15 == 2
	_cQry+=" ORDER BY 	F2_DOC, F2_SERIE, F2_EMISSAO, A1_COD, A1_LOJA, A1_NOME, A3_GRPREP, D2_COD "
ELSEIF cl_PAR09 == 1 .AND. cl_PAR15 == 1
	_cQry+=" ORDER BY 	A3_GRPREP, F2_DOC, F2_SERIE, F2_EMISSAO, A1_COD, A1_LOJA, A1_NOME, D2_COD "
ELSE
	_cQry+=" ORDER BY 	F2_EMISSAO, A1_COD, A1_LOJA, A1_NOME, A3_GRPREP, D2_COD, F2_DOC, F2_SERIE "
ENDIF

_cQry := ChangeQuery(_cQry)
dbUseArea(.T.,"TOPCONN",TCGENQRY(,,_cQry),clAlias, .T., .T.)
cSd1Fil := Xfilial("SD1")
 
DbSelectArea("SZ1")         
DbSetOrder(1)  // DocSerieClienteLoja


DBSELECTAREA(clAlias)
DBGOTOP()
DbSelectArea("DGXLS")
While !(clAlias)->(EOF())     
	
	If SZ1->(Dbseek(xFilial("SZ1") + (clAlias)->F2_DOC + (clAlias)->F2_SERIE + (clAlias)->A1_COD + (clAlias)->A1_LOJA))
		dtEntreg := SZ1->Z1_DTENTRE 
		If SZ1->Z1_DTENTRE == CtoD("//")  
			cCalcPr := "N"
			cObsCalc := "PRODUTO NAO ENTREGUE"
		Else
			If Empty(SZ1->Z1_PQANO)
				If SZ1->Z1_DTENTRE > StoD(cDtLimite)
					cCalcPr := "N"
					cObsCalc := "Entregue depois da data limite"
				Else
					If RecLock("SZ1",.F.)
						SZ1->Z1_PQANO := cQano
						SZ1->(MsUnLock())
						cCalcPr := "S"
						cObsCalc := "" 
					Else
						cCalcPr := "N"
						cObsCalc := "FALHA GRAVACAO GERAR NOVAMENTE"
					EndIf 
				EndIf                        
			Else
				If AllTrim(SZ1->Z1_PQANO) == AllTrim(cQano)
					cCalcPr := "S"
					cObsCalc := ""
				Else
					cCalcPr := "N" 
					cObsCalc := "CALCULADO NO "+ substr(SZ1->Z1_PQANO,1,1) +"บ QUARTER" 
				EndIf
			EndIf
		EndIf
	Else
		dtEntreg := Ctod("//")
		cCalcPr := "N"
		cObsCalc := "SEM REGISTRO LOGISTICA (SZ1)"
	EndIf                       
	 
	If DGXLS->(RECLOCK("DGXLS",.T.))
		
		//CAMPOS SQL X EXCEL
		DGXLS->CALCULA	:= cCalcPr
		DGXLS->OBSCALC	:= cObsCalc
		DGXLS->FILIAL	:= (clAlias)->F2_FILIAL         
		DGXLS->DOC		:= (clAlias)->F2_DOC
		DGXLS->SERIE    :=            (clAlias)->F2_SERIE
		DGXLS->CODCLI	:= (clAlias)->A1_COD
		DGXLS->LOJA		:= (clAlias)->A1_LOJA
		DGXLS->CLIENTE   	:=            (clAlias)->A1_NREDUZ
		DGXLS->UF     		:=            (clAlias)->D2_EST
		DGXLS->PRODUTO     	:=            (clAlias)->D2_COD
		DGXLS->D2ITEM     	:=            (clAlias)->D2_ITEM
		DGXLS->DATANF			:= SubStr((clAlias)->F2_EMISSAO,7,2) + "/" + SubStr((clAlias)->F2_EMISSAO,5,2) + "/" + SubStr((clAlias)->F2_EMISSAO,1,4) 
		DGXLS->DATASTR			:= (clAlias)->F2_EMISSAO
		
		DGXLS->DTENTR		:= dtEntreg 
		DGXLS->MESENTR		:= STRZERO(Month(dtEntreg),2) 
		DGXLS->STRENTR		:= DtoS(dtEntreg) 
		DGXLS->ANO			:= strzero(Year(STOD((clAlias)->F2_EMISSAO)),4) 
		DGXLS->MESREA		:=  STRZERO(MONTH(STOD((clAlias)->F2_EMISSAO)),2)   
		If Empty(SZ1->Z1_DTENTRE)
			DGXLS->MES		:= STRZERO(MONTH(STOD((clAlias)->F2_EMISSAO)),2)
		Else
			//StrZero(GETMV("DBM_DTFCES"),2)  
			If MV_PAR01 == 1 
				If Dtos(dtEntreg) <= (AllTrim(Str(Year(cl_PAR12)))  + "02" + StrZero(GETMV("DBM_DTFCES"),2))
					If Month(StoD((clAlias)->F2_EMISSAO)) == 2
						DGXLS->MES := "02"
					Else
						DGXLS->MES := "01"
					EndIf	
				ElseIf DtoS(dtEntreg) <= (AllTrim(Str(Year(cl_PAR12)))  + "03" + StrZero(GETMV("DBM_DTFCES"),2))
					If Month(StoD((clAlias)->F2_EMISSAO)) == 3
						DGXLS->MES := "03"
					Else
						DGXLS->MES := "02"
					EndIf
				ElseIf DtoS(dtEntreg) <= (AllTrim(Str(Year(cl_PAR12)))  + "04" + StrZero(GETMV("DBM_DTFCES"),2))
					If Month(StoD((clAlias)->F2_EMISSAO)) == 4
						DGXLS->MES := "04"
					Else
						DGXLS->MES := "03"
					EndIf
				EndIf
			EndIf
		
			If MV_PAR01 == 2 
				If DtoS(dtEntreg) <= (AllTrim(Str(Year(cl_PAR12)))  + "05" + StrZero(GETMV("DBM_DTFCES"),2))
					If Month(StoD((clAlias)->F2_EMISSAO)) == 5
						DGXLS->MES := "05"
					Else
						DGXLS->MES := "04"
					EndIf	
				ElseIf DtoS(dtEntreg) <= (AllTrim(Str(Year(cl_PAR12)))  + "06" + StrZero(GETMV("DBM_DTFCES"),2))
					If Month(StoD((clAlias)->F2_EMISSAO)) == 6
						DGXLS->MES := "06"
					Else
						DGXLS->MES := "05"
					EndIf
				ElseIf DtoS(dtEntreg) <= (AllTrim(Str(Year(cl_PAR12)))  + "07" + StrZero(GETMV("DBM_DTFCES"),2))
					If Month(StoD((clAlias)->F2_EMISSAO)) == 7
						DGXLS->MES := "07"
					Else
						DGXLS->MES := "06"
					EndIf
				EndIf
			EndIf  
			
			If MV_PAR01 == 3 
				If DtoS(dtEntreg) <= (AllTrim(Str(Year(cl_PAR12)))  + "08" + StrZero(GETMV("DBM_DTFCES"),2))  
					If Month(StoD((clAlias)->F2_EMISSAO)) == 8
						DGXLS->MES := "08"
					Else
						DGXLS->MES := "07"
					EndIf	
				ElseIf DtoS(dtEntreg) <= (AllTrim(Str(Year(cl_PAR12)))  + "09" + StrZero(GETMV("DBM_DTFCES"),2))
					If Month(StoD((clAlias)->F2_EMISSAO)) == 9
						DGXLS->MES := "09"
					Else
						DGXLS->MES := "08"
					EndIf
				ElseIf DtoS(dtEntreg) <= (AllTrim(Str(Year(cl_PAR12)))  + "10" + StrZero(GETMV("DBM_DTFCES"),2)) 
					If Month(StoD((clAlias)->F2_EMISSAO)) == 10
						DGXLS->MES := "10"
					Else
						DGXLS->MES := "09"
					EndIf
				EndIf
			EndIf  
			
			If MV_PAR01 == 4 
				If DtoS(dtEntreg) <= (AllTrim(Str(Year(cl_PAR12)))  + "11" + StrZero(GETMV("DBM_DTFCES"),2))
					If Month(StoD((clAlias)->F2_EMISSAO)) == 11
						DGXLS->MES := "11"
					Else
						DGXLS->MES := "10"
					EndIf	
				ElseIf DtoS(dtEntreg) <= (AllTrim(Str(Year(cl_PAR12)))  + "12" + StrZero(GETMV("DBM_DTFCES"),2))
					If Month(StoD((clAlias)->F2_EMISSAO)) == 12
						DGXLS->MES := "12"
					Else
						DGXLS->MES := "11"
					EndIf
				ElseIf DtoS(dtEntreg) <= (AllTrim(Str(Year(cl_PAR12)+1))  + "01" + StrZero(GETMV("DBM_DTFCES"),2))
					DGXLS->MES := "12"
				EndIf
			EndIf
			
		EndIf
			
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
		DGXLS->JUSTIFICAT := " "
		DGXLS->REFAT		:= " "
		DGXLS->CFOP			:=            (clAlias)->D2_CF
		DGXLS->CODVEN1     :=            (clAlias)->F2_VEND1
   		DGXLS->CODVEN2     :=            (clAlias)->F2_VEND2
		DGXLS->CODVEN3     :=            (clAlias)->F2_VEND3
		DGXLS->VEND1		:=            (clAlias)->A3_NOME
		DGXLS->VEND2		:= 	" "
		DGXLS->VEND3		:=  " "
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
		DGXLS->USUARIO  	:= (clAlias)->C6_X_USRLB //USUARIO QUE EMITIU O PEDIDO
		DGXLS->VALFAT		:= (clAlias)->(D2_VALFRE + D2_DESPESA + D2_SEGURO + D2_ICMSRET + D2_VALIPI + D2_TOTAL)
		DGXLS->CUSTO		:= (clAlias)->D2_CUSTO1
		DGXLS->META	:= 0
		DGXLS->PEDIDO		:= (clAlias)->D2_PEDIDO
		DGXLS->ITEMPED	:= (clAlias)->D2_ITEMPV 
	
		DGXLS->STATUSCML	:= " " //noacento(GETADVFVAL("SX5","X5_DESCRI",XFILIAL("SX5")+"ZX"+(clAlias)->B1_STACML,1,""))
		DGXLS->(MsUnLock())
	EndIf
	
	DBSELECTAREA(clAlias)
	dbSkip() // Avanca o ponteiro do registro no arquivo
EndDo 

DbSelectArea("SZ1") 

If SELECT(cAliSZ1) > 0
	(cAliSZ1)->(dBCloseArea())
EndIf


cSqlSZ1:="	SELECT F2_FILIAL, F2_DOC, F2_SERIE, F2_COND, F2_EMISSAO, F2_CLIENTE, F2_LOJA, F2_VEND1, F2_VEND2, F2_VEND3, D2_ITEM, F2_YCANAL,"
cSqlSZ1+="		D2_DOC, D2_ITEM, D2_COD, D2_TOTAL, D2_QUANT, D2_PRCVEN, D2_VALIPI, D2_PICM, D2_EST, D2_TIPO, D2_CF,D2_PEDIDO, D2_ITEMPV, D2_CUSTO1, "
cSqlSZ1+="		F4_VENDA, D2_VALFRE, D2_SEGURO, D2_ICMSRET, D2_DESPESA, "
cSqlSZ1+="		B1_DESC, B1_XDESC, B1_STACML,B1_PUBLISH,B1_PLATAF,"
cSqlSZ1+="		A1_COD, A1_LOJA, A1_NOME, A1_NREDUZ,A1_YCANAL, A1_YDCANAL, A1_GRPVEN,"
cSqlSZ1+="		ACA_DESCRI," 
cSqlSZ1+="		A3_COD, A3_NOME, A3_GRPREP,"
cSqlSZ1+="		C6_PRCVEN, C6_PRCTAB, C6_X_USRLB,"
cSqlSZ1+="		C5_FATURPV, C5_TABELA,"
cSqlSZ1+="		E4_DESCRI, C6_REGDESC, C6_PREGDES, " 
cSqlSZ1+="		Z1_DTENTRE"
cSqlSZ1+="	FROM  " + RetSqlName("SF2") + " F2,"
cSqlSZ1+="		" + RetSqlName("SD2") + " D2,"
cSqlSZ1+="		" + RetSqlName("SF4") + " F4,"
cSqlSZ1+="		" + RetSqlName("SB1") + " B1,"
cSqlSZ1+="		" + RetSqlName("SA1") + " A1,"
cSqlSZ1+="		" + RetSqlName("SA3") + " A3,"
cSqlSZ1+="		" + RetSqlName("ACA") + " ACA,"
cSqlSZ1+="		" + RetSqlName("SC6") + " C6,"
cSqlSZ1+="		" + RetSqlName("SC5") + " C5,"
cSqlSZ1+="		" + RetSqlName("SZ1") + " SZ1,"
cSqlSZ1+="		" + RetSqlName("SE4") + " E4"
cSqlSZ1+=" WHERE	D2_FILIAL = '" + xFilial("SD2") + "'"
cSqlSZ1+=" AND    F2_DOC >= '"     	+ALLTRIM(cl_PAR01)+ "' "
cSqlSZ1+=" AND 	F2_DOC <= '"     	+ALLTRIM(cl_PAR02)+ "' "
cSqlSZ1+=" AND  	F2_SERIE >= '" 	+ALLTRIM(cl_PAR03)+ "' "
cSqlSZ1+=" AND 	F2_SERIE <= '" 	+ALLTRIM(cl_PAR04)+ "' "
cSqlSZ1+=" AND  	F2_CLIENTE >= '" 	+ALLTRIM(cl_PAR05)+ "' "
cSqlSZ1+=" AND 	F2_CLIENTE <= '" 	+ALLTRIM(cl_PAR06)+ "' "
cSqlSZ1+=" AND  	F2_LOJA >= '" 		+ALLTRIM(cl_PAR07)+ "' "
cSqlSZ1+=" AND 	F2_LOJA <= '" 		+ALLTRIM(cl_PAR08)+ "' "
cSqlSZ1+=" AND  	D2_COD >= '" 		+ALLTRIM(cl_PAR10)+ "' "
cSqlSZ1+=" AND 	D2_COD <= '" 		+ALLTRIM(cl_PAR11)+ "' "
//cSqlSZ1+=" AND 	F2_EMISSAO BETWEEN '"  + Iif(Mv_Par01==1,StrZero(Year(cl_PAR12-1),4),StrZero(Year(cl_PAR12),4))  + Iif(MV_Par01==1,"12",Strzero(Month(cl_Par12)-1,2)) + "01" + "' AND '" + DtoS(LastDay(StoD(Strzero(Iif(MV_PAR01==1,Year(cl_PAR12)-1,Year(cl_PAR12)),4)   + Iif(MV_PAR01==1,"12",Strzero(Month(cl_Par12)-1,2)) + "01"))) + "'" 
If SubStr(cQano,1,1) = "1"
	cSqlSZ1+= " AND F2_EMISSAO BETWEEN '" + StrZero(Year(cl_PAR12)-1,4) + "10" + "01' AND '" + DTOS(cl_PAR12) + "'"
Else
	cSqlSZ1+= " AND F2_EMISSAO BETWEEN '" + StrZero(Year(cl_PAR12),4) + StrZero(Month(cl_PAR12)-3,2) + "01' AND '" + DTOS(cl_PAR12) + "'"
EndIf
cSqlSZ1+= " AND (Z1_PQANO = '' Or Z1_PQANO = '"+ AllTrim(cQano) + "')"
//cSqlSZ1+=" AND	ACA_GRPREP BETWEEN '" + cGrpCli + "' AND '" + cGrpCli + "'"  

cSqlSZ1+=" AND	ACA_GRPREP IN " +FormatIn(cGrpCli,";") + "" 
cSqlSZ1+=" AND Z1_FILIAL = '" + xFilial("SZ1") + "' "
cSqlSZ1+=" AND Z1_DOC = F2_DOC"
cSqlSZ1+=" AND Z1_SERIE = F2_SERIE"
cSqlSZ1+=" AND Z1_CLIENTE = F2_CLIENTE"
cSqlSZ1+=" AND Z1_LOJA = F2_LOJA"
cSqlSZ1+="	AND  	F2_FILIAL 	= D2_FILIAL"
cSqlSZ1+="	AND  	F2_DOC 		= D2_DOC"
cSqlSZ1+="	AND  	F2_SERIE 	= D2_SERIE"
cSqlSZ1+="	AND  	D2_TES 		= F4_CODIGO"
cSqlSZ1+="	AND		F4_DUPLIC 	= 'S'"
cSqlSZ1+="	AND  	D2_COD 		= B1_COD"
cSqlSZ1+="	AND  	F2_CLIENTE 	= A1_COD"
cSqlSZ1+="	AND  	F2_LOJA 	= A1_LOJA"
cSqlSZ1+="	AND  	F2_VEND1 	= A3_COD"
//cSqlSZ1+="	AND		A3_GRPREP 	= ACA_GRPREP" 
cSqlSZ1+="	AND		F2_YCANAL 	= ACA_GRPREP" 
cSqlSZ1+="	AND  	F2_FILIAL 	= C6_FILIAL"
cSqlSZ1+="	AND  	D2_PEDIDO	= C6_NUM"
cSqlSZ1+="	AND  	D2_ITEMPV	= C6_ITEM"
cSqlSZ1+="	AND  	C6_FILIAL 	= C5_FILIAL"
cSqlSZ1+="	AND  	C6_NUM 		= C5_NUM"
cSqlSZ1+="	AND		E4_CODIGO 	= F2_COND" 
cSqlSZ1 += " AND E4_FILIAL = '" + xFilial("SE4") + "'"
cSqlSZ1 += " AND A1_FILIAL = '" + xFilial("SA1") + "'"
cSqlSZ1 += " AND F4_FILIAL = '" + xFilial("SF4") + "'"
cSqlSZ1 += " AND B1_FILIAL = '" + xFilial("SB1") + "'"
cSqlSZ1 += " AND A3_FILIAL = '" + xFilial("SA3") + "'"
cSqlSZ1 += " AND  	F2.D_E_L_E_T_ 	!= '*'"
cSqlSZ1 += " AND  	D2.D_E_L_E_T_ 	!= '*'"
cSqlSZ1 += " AND  	F4.D_E_L_E_T_ 	!= '*'"
cSqlSZ1 += " AND  	B1.D_E_L_E_T_ 	!= '*'"
cSqlSZ1 += " AND  	A1.D_E_L_E_T_ 	!= '*'"
cSqlSZ1 += " AND  	A3.D_E_L_E_T_ 	!= '*'"
cSqlSZ1 += " AND  	ACA.D_E_L_E_T_ 	!= '*'"
cSqlSZ1 += " AND  	C6.D_E_L_E_T_ 	!= '*'"                  
cSqlSZ1 += " AND  	C5.D_E_L_E_T_ 	!= '*'"
cSqlSZ1 += " AND  	E4.D_E_L_E_T_ 	!= '*'"
cSqlSZ1 += " AND	SZ1.D_E_L_E_T_  != '*'"
IF cl_PAR09 == 2 .AND. cl_PAR14 == 1
	cSqlSZ1+=" ORDER BY 	A1_COD, A1_LOJA, F2_EMISSAO, A3_GRPREP, A1_NOME, F2_DOC, F2_SERIE "
ELSEIF cl_PAR09 == 1 .AND. cl_PAR15 == 2
	cSqlSZ1+=" ORDER BY 	F2_DOC, F2_SERIE, F2_EMISSAO, A1_COD, A1_LOJA, A1_NOME, A3_GRPREP, D2_COD "
ELSEIF cl_PAR09 == 1 .AND. cl_PAR15 == 1
	cSqlSZ1+=" ORDER BY 	A3_GRPREP, F2_DOC, F2_SERIE, F2_EMISSAO, A1_COD, A1_LOJA, A1_NOME, D2_COD "
ELSE
	cSqlSZ1+=" ORDER BY 	F2_EMISSAO, A1_COD, A1_LOJA, A1_NOME, A3_GRPREP, D2_COD, F2_DOC, F2_SERIE "
ENDIF

cSqlSZ1  := ChangeQuery(cSqlSZ1 )
dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cSqlSZ1 ),cAliSZ1, .T., .T.)

dbSelectArea("SA1")
DbSetOrder(1)

DbSelectArea("SA3")
DbSetOrder(1)

DbSelectArea("ACA")
DbSetOrder(1) 

DbSelectArea("SC5")
DbSetOrder(1)

While !(cAliSZ1)->(EOF()) 
	If SZ1->(Dbseek(xFilial("SZ1") + (cAliSZ1)->F2_DOC + (cAliSZ1)->F2_SERIE + (cAliSZ1)->A1_COD + (cAliSZ1)->A1_LOJA))
		dtEntreg := SZ1->Z1_DTENTRE
		cCalcPr := "N" 
		If SZ1->Z1_DTENTRE == CtoD("//")  
			cCalcPr := "N"
			cObsCalc := "PRODUTO NAO ENTREGUE"
		Else
			If Empty(SZ1->Z1_PQANO)
				If SZ1->Z1_DTENTRE > StoD(cDtLimite)
					cCalcPr := "N"
					cObsCalc := "Entregue depois da data limite"
				Else
					If RecLock("SZ1",.F.)
						SZ1->Z1_PQANO := cQano
						SZ1->(MsUnLock())
						cCalcPr := "S"
						cObsCalc := "" 
					Else
						cCalcPr := "N"
						cObsCalc := "NAO FOI POSSอVEL GRAVACAO"
					EndIf
				EndIf                         
			Else
				If AllTrim(SZ1->Z1_PQANO) == AllTrim(cQano)
					cCalcPr := "S"
					cObsCalc := ""
				Else
					cCalcPr := "N" 
					cObsCalc := "CALCULADO NO "+ substr(Z1->Z1_PQANO,1,1) +"บ QUARTER" 
				EndIf
			EndIf
		EndIf
	Else
		dtEntreg := Ctod("//")
		cCalcPr := "N"
		cObsCalc := "SEM REGISTRO LOGISTICA (SZ1)"
	EndIf                
	If SA1->(dbSeek(xFilial("SA1") + (cAliSZ1)->F2_CLIENTE + (cAliSZ1)->F2_LOJA))  
		If SA3->(dbSeek(xFilial("SA3") + (cAliSZ1)->F2_VEND1))  
			If ACA->(dbSeek(xFilial("ACA") + SA3->A3_GRPREP))		 
					If DGXLS->(RECLOCK("DGXLS",.T.))
						// CAMPOS SQL X EXCEL 
						DGXLS->CALCULA	:= cCalcPr
						DGXLS->OBSCALC	:= cObsCalc
						DGXLS->FILIAL		:= xFilial("SZ1")        
						DGXLS->DOC		:= (cAliSZ1)->F2_DOC
						DGXLS->SERIE     	:= (cAliSZ1)->F2_SERIE
						DGXLS->CODCLI		:= SA1->A1_COD
						DGXLS->LOJA		:= SA1->A1_LOJA
						DGXLS->CLIENTE       	:=   SA1->A1_NREDUZ
						DGXLS->UF     		:=            (cAliSZ1)->D2_EST
						DGXLS->PRODUTO     	:=            (cAliSZ1)->D2_COD
						DGXLS->D2ITEM     	:=            (cAliSZ1)->D2_ITEM
						DGXLS->DATANF			:= SubStr((cAliSZ1)->F2_EMISSAO,7,2) + "/" + SubStr((cAliSZ1)->F2_EMISSAO,5,2) + "/" + SubStr((cAliSZ1)->F2_EMISSAO,1,4) 
						DGXLS->DATASTR			:= (cAliSZ1)->F2_EMISSAO
						DGXLS->DTENTR		:= CtoD(SubStr((cAliSZ1)->Z1_DTENTRE,7,2) + "/" + SubStr((cAliSZ1)->Z1_DTENTRE,5,2) + "/" + SubStr((cAliSZ1)->Z1_DTENTRE,1,4)) //StoD((cAliSZ1)->Z1_DTENTRE)
						DGXLS->MESENTR		:= STRZERO(Month(dtEntreg),2) //STRZERO(Month(Stod((cAliSZ1)->Z1_DTENTRE)),2) 
						DGXLS->STRENTR	:= DtoS(dtEntreg)
						DGXLS->ANO			:= strzero(Year(STOD((cAliSZ1)->F2_EMISSAO)),4) 
						//DGXLS->MESREA		:=  "00"//STRZERO(MONTH(STOD((cAliSZ1)->F2_EMISSAO)),2)  
						If MV_PAR01 == 1 
							If (cAliSZ1)->Z1_DTENTRE <= (AllTrim(Str(Year(cl_PAR12)))  + "02" + StrZero(GETMV("DBM_DTFCES"),2))
								If Month(StoD((cAliSZ1)->F2_EMISSAO)) == 2
									DGXLS->MES := "02"
								Else
									DGXLS->MES := "01"
								EndIf	
							ElseIf (cAliSZ1)->Z1_DTENTRE <= (AllTrim(Str(Year(cl_PAR12)))  + "03" + StrZero(GETMV("DBM_DTFCES"),2))
								If Month(StoD((cAliSZ1)->F2_EMISSAO)) == 3
									DGXLS->MES := "03"
								Else
									DGXLS->MES := "02"
								EndIf
							ElseIf (cAliSZ1)->Z1_DTENTRE <= (AllTrim(Str(Year(cl_PAR12)))  + "04" + StrZero(GETMV("DBM_DTFCES"),2))
								If Month(StoD((cAliSZ1)->F2_EMISSAO)) == 4
									DGXLS->MES := "04"
								Else
									DGXLS->MES := "03"
								EndIf
							EndIf
						EndIf
					
						If MV_PAR01 == 2 
							If (cAliSZ1)->Z1_DTENTRE <= (AllTrim(Str(Year(cl_PAR12)))  + "05" + StrZero(GETMV("DBM_DTFCES"),2))
								If Month(StoD((cAliSZ1)->F2_EMISSAO)) == 5
									DGXLS->MES := "05"
								Else
									DGXLS->MES := "04"
								EndIf	
							ElseIf (cAliSZ1)->Z1_DTENTRE <= (AllTrim(Str(Year(cl_PAR12)))  + "06" + StrZero(GETMV("DBM_DTFCES"),2))
								If Month(StoD((cAliSZ1)->F2_EMISSAO)) == 6
									DGXLS->MES := "06"
								Else
									DGXLS->MES := "05"
								EndIf
							ElseIf (cAliSZ1)->Z1_DTENTRE <= (AllTrim(Str(Year(cl_PAR12)))  + "07" + StrZero(GETMV("DBM_DTFCES"),2))
								If Month(StoD((cAliSZ1)->F2_EMISSAO)) == 7
									DGXLS->MES := "07"
								Else
									DGXLS->MES := "06"
								EndIf
							EndIf
						EndIf  
						
						If MV_PAR01 == 3 
							If (cAliSZ1)->Z1_DTENTRE <= (AllTrim(Str(Year(cl_PAR12)))  + "08" + StrZero(GETMV("DBM_DTFCES"),2))  
								If Month(StoD((cAliSZ1)->F2_EMISSAO)) == 8
									DGXLS->MES := "08"
								Else
									DGXLS->MES := "07"
								EndIf	
							ElseIf (cAliSZ1)->Z1_DTENTRE <= (AllTrim(Str(Year(cl_PAR12)))  + "09" + StrZero(GETMV("DBM_DTFCES"),2))
								If Month(StoD((cAliSZ1)->F2_EMISSAO)) == 9
									DGXLS->MES := "09"
								Else
									DGXLS->MES := "08"
								EndIf
							ElseIf (cAliSZ1)->Z1_DTENTRE <= (AllTrim(Str(Year(cl_PAR12)))  + "10" + StrZero(GETMV("DBM_DTFCES"),2)) 
								If Month(StoD((cAliSZ1)->F2_EMISSAO)) == 10
									DGXLS->MES := "10"
								Else
									DGXLS->MES := "09"
								EndIf
							EndIf
						EndIf  
						
						If MV_PAR01 == 4 
							If (cAliSZ1)->Z1_DTENTRE <= (AllTrim(Str(Year(cl_PAR12)))  + "11" + StrZero(GETMV("DBM_DTFCES"),2))
								If Month(StoD((cAliSZ1)->F2_EMISSAO)) == 11
									DGXLS->MES := "11"
								Else
									DGXLS->MES := "10"
								EndIf	
							ElseIf (cAliSZ1)->Z1_DTENTRE <= (AllTrim(Str(Year(cl_PAR12)))  + "12" + StrZero(GETMV("DBM_DTFCES"),2))
								If Month(StoD((cAliSZ1)->F2_EMISSAO)) == 12
									DGXLS->MES := "12"
								Else
									DGXLS->MES := "11"
								EndIf
							ElseIf (cAliSZ1)->Z1_DTENTRE <= (AllTrim(Str(Year(cl_PAR12)+1))  + "01" + StrZero(GETMV("DBM_DTFCES"),2))
								DGXLS->MES := "12"
							EndIf
						EndIf 
						
						If MONTH(STOD((cAliSZ1)->F2_EMISSAO)) <= 3
							DGXLS->QUARTER		:= "Q1"
						ElseIf MONTH(STOD((cAliSZ1)->F2_EMISSAO)) > 3 .And. MONTH(STOD((cAliSZ1)->F2_EMISSAO)) <= 6
							DGXLS->QUARTER		:= "Q2"
						ElseIf MONTH(STOD((cAliSZ1)->F2_EMISSAO)) > 6 .And. MONTH(STOD((cAliSZ1)->F2_EMISSAO)) <= 9
							DGXLS->QUARTER		:= "Q3"
						ElseIf MONTH(STOD((cAliSZ1)->F2_EMISSAO)) > 9 //.And. MONTH(STOD((cAliSZ1)->F2_EMISSAO)) <= 12
							DGXLS->QUARTER		:= "Q4"
						EndIf
						
						DGXLS->TIPONF     	:= (cAliSZ1)->D2_TIPO
						DGXLS->MOTIVO     	:= " "
						DGXLS->JUSTIFICAT := " "
						DGXLS->REFAT		:= " "
						DGXLS->CFOP			:=            (cAliSZ1)->D2_CF
						DGXLS->CODVEN1     :=            (cAliSZ1)->F2_VEND1
				   		DGXLS->CODVEN2     :=            (cAliSZ1)->F2_VEND2
						DGXLS->CODVEN3     :=            (cAliSZ1)->F2_VEND3
						DGXLS->VEND1		:=            SA3->A3_NOME
						DGXLS->VEND2		:= 	" "
						DGXLS->VEND3		:=  " "
					
						DGXLS->GRPREP		:= SA3->A3_GRPREP
						DGXLS->CANAL 	:= ACA->ACA_DESCRI
						DGXLS->CODPGTO	:= (cAliSZ1)->F2_COND
					//	DGXLS->CONDPG		:= (cAliSZ1)->E4_DESCRI
						
						DGXLS->TITULONC	:= (cAliSZ1)->B1_XDESC
						DGXLS->TB_PLATRED := (cAliSZ1)->B1_PLATAF
						DGXLS->TB_PUBLISH	:= (cAliSZ1)->B1_PUBLISH
						DGXLS->CATEGORIA	:= " "  // CARREGA DE OUTRA PLANILHA
						DGXLS->CAMPANHA		:= " " //CARREGA DE OUTRA PLANILHA DEFINIR REGRA
						DGXLS->QTDFAT		:= (cAliSZ1)->D2_QUANT
						DGXLS->PRCVEN		:= (cAliSZ1)->D2_PRCVEN
						DGXLS->PRCTAB		:= (cAliSZ1)->C6_PRCTAB
						DGXLS->CODTAB	   	:= (cAliSZ1)->C5_TABELA
						DGXLS->PORCDESC		:= (((cAliSZ1)->D2_PRCVEN/(cAliSZ1)->C6_PRCTAB) * 100) - 100
						DGXLS->VALVEND		:= (cAliSZ1)->D2_PRCVEN * (cAliSZ1)->D2_QUANT
						DGXLS->VALTAB		:= (cAliSZ1)->C6_PRCTAB * (cAliSZ1)->D2_QUANT
						DGXLS->REGRADESC	:= (cAliSZ1)->C6_REGDESC
						DGXLS->PREGRADESC	:= (cAliSZ1)->C6_PREGDES
						DGXLS->USUARIO  	:= (cAliSZ1)->C6_X_USRLB //USUARIO QUE EMITIU O PEDIDO
						DGXLS->VALFAT		:= (cAliSZ1)->(D2_VALFRE + D2_DESPESA + D2_SEGURO + D2_ICMSRET + D2_VALIPI + D2_TOTAL)
						DGXLS->CUSTO		:= (cAliSZ1)->D2_CUSTO1
						DGXLS->META	:= 0
						DGXLS->PEDIDO		:= (cAliSZ1)->D2_PEDIDO
						DGXLS->ITEMPED	:= (cAliSZ1)->D2_ITEMPV 
						//DGXLS->COMISS	:= 	nComissao
						//DGXLS->VRLCOMIS :=  (cAliSZ1)->(D2_VALFRE + D2_SEGURO + D2_ICMSRET + D2_VALIPI + D2_TOTAL) * (nComissao/100)
						DGXLS->STATUSCML	:= " " //noacento(GETADVFVAL("SX5","X5_DESCRI",XFILIAL("SX5")+"ZX"+(cAliSZ1)->B1_STACML,1,""))
						DGXLS->(MsUnLock())
					EndIf
			EndIf
		EndIf  
	EndIf
	DBSELECTAREA(cAliSZ1)
	dbSkip() // Avanca o ponteiro do registro no arquivo
EndDo 


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณProcessa Devolucao                                                      ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู  
//DbSelectArea("DGXLS")
//dbSetIndex("SYSTEM\" + CNOMEDBF + OrdBagExt()) 
DbSelectArea("ACA") 
DbSetOrder(1)

DbSelectArea("SA1")
DbSetOrder(1)
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


cSqlDev := " SELECT SD1.*, F1_EMISSAO, F1_DOC, F1_SERIE, F1_FORNECE, F1_LOJA, F1_FRETE, F1_DESPESA, F1_SEGURO, F1_ICMSRET, F1_EST, F1_COND,"
cSqlDev += " F1_DTDIGIT,F2_DOC, F2_SERIE, F2_EMISSAO, F2_CLIENTE, F2_LOJA, F2_VEND1, F1_TXMOEDA, F1_MOEDA, F1_FORMUL, A3_NOME, A3_GRPREP, ACA_DESCRI, B1_XDESC, B1_PLATAF, B1_PUBLISH ,Z1_DTENTRE" + cAddField
cSqlDev += " FROM " + RetSqlName("SD1") + " SD1, " + RetSqlname("SF4") + " SF4, " + RetSqlName("SF2") + " SF2, " + RetSqlName("SF1") + " SF1, " + RetSqlName("SA3") + " SA3," + RetSqlName("ACA") + " ACA,"+ RetSqlName("SB1") + " SB1,"+ RetSqlName("SZ1") + " SZ1"
cSqlDev += " WHERE D1_FILIAL  = '" + xFilial("SD1") + "'"
cSqlDev += " AND D1_DTDIGIT BETWEEN '" + DTOS(cl_par12) + "' AND '" + DTOS(cl_par13) + "'"
cSqlDev += " AND D1_TIPO = 'D'" 
cSqlDev += " AND D1_CF IN " + FormatIn(cCFOPS,";") + " " 
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
cSqlDev += " AND ACA_FILIAL = '" + xFilial("ACA") + "'"
//cSqlDev += " AND ACA_GRPREP = A3_GRPREP" 
cSqlDev += " AND ACA_GRPREP = F2_YCANAL"
cSqlDev += " AND B1_FILIAL = '" + xFilial("SB1") + "' "
cSqlDev += " AND B1_COD = D1_COD "
cSqlDev += " AND A3_FILIAL	= '" + xFilial("SA3")  + "' " 
//cSqlDev += " AND A3_GRPREP BETWEEN '" + cGrpCli + "' AND '" + cGrpCli + "'" 

cSqlDev += " AND ACA_GRPREP IN " + FormatIn(cGrpCli,";") + ""
cSqlDev += " AND Z1_FILIAL = '" + xFilial("SZ1") + "'"
cSqlDev += " AND Z1_DOC = F2_DOC"
cSqlDev += " AND Z1_SERIE = F2_SERIE"
cSqlDev += " AND Z1_CLIENTE = F2_CLIENTE"
cSqlDev += " AND Z1_LOJA = F2_LOJA"

cSqlDev += " AND SZ1.D_E_L_E_T_ = ' '"
cSqlDev += " AND SD1.D_E_L_E_T_ = ' '"
cSqlDev += " AND SF4.D_E_L_E_T_ = ' '"
cSqlDev += " AND SF2.D_E_L_E_T_ = ' '"
cSqlDev += " AND SF1.D_E_L_E_T_ = ' '"
cSqlDev += " AND SA3.D_E_L_E_T_ = ' '"
cSqlDev += " AND ACA.D_E_L_E_T_ = ' '"
cSqlDev += " AND SB1.D_E_L_E_T_ = ' '"
cSqlDev += " AND " + cWhere 			
cSqlDev += " ORDER BY D1_FILIAL,D1_FORNECE,D1_LOJA,D1_DTDIGIT,D1_DOC,D1_SERIE,D1_NUMSEQ " 

cSqlDev := ChangeQuery(cSqlDev)
dbUseArea(.T.,"TOPCONN",TCGENQRY(,,cSqlDev),cAliasSD1, .T., .T.)


While (cAliasSD1)->(!Eof())
	nTOTAL :=0
	nVALICM:=0
	nVALIPI:=0
	nQtdVend:= 0
	cVend := (cAliasSD1)->F2_VEND1


	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณSe a origem for loja, ignora o filtro e mostra o registro               ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	If (cAliasSD1)->D1_ORIGLAN <> "LO"
		If (cAliasSD1)->F2_CLIENTE <> (cAliasSD1)->D1_FORNECE .And. (cAliasSD1)->F2_LOJA <> (cAliasSD1)->D1_LOJA
			(cAliasSD1)->(DbSkip())
			Loop
		EndIf
	EndIf

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณProcessa o ponto de entrada com o filtro do usuario para devolucoes.    ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
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
	
		DtMoedaDev  := StoD((cAliasSD1)->F2_EMISSAO)
	            
		If cPaisLoc == "BRA"
			If AvalTes((cAliasSD1)->D1_TES,cEstoq,cDupli)

				nVALICM := xMoeda((cAliasSD1)->D1_VALICM,1,1,DtMoedaDev,nDecs+1)
				nVALIPI := xMoeda((cAliasSD1)->D1_VALIPI,1,1,DtMoedaDev ,nDecs+1)
				nTOTAL  := xMoeda(((cAliasSD1)->D1_TOTAL - (cAliasSD1)->D1_VALDESC),1,1,DtMoedaDev,nDecs+1) 
				nValDesDev := xMoeda((cAliasSD1)->D1_ICMSRET  ,1,1,DtMoedaDev ,nDecs+1)
				nQtdVend:= (cAliasSD1)->D1_QUANT

				cVendedor := "1"
//						For nContador := 1 TO nVendedor
					
					dbSelectArea("DGXLS")
					//dbClearIndex() 
					//dbSetIndex("SYSTEM\" + CNOMEDBF + OrdBagExt())
					//dbSetOrder(1) 
					If SA1->(dbSeek( cSA1Fil + (cAliasSD1)->F2_CLIENTE + (cAliasSD1)->F2_LOJA)) 
					
					EndIf 
				
					cVend := (cAliasSD1)->(FieldGet((cAliasSD1)->(FieldPos("F2_VEND"+cVendedor))))
					
					cVendedor := Soma1(cVendedor,1)
					If cVend >= "     " .And. cVend <= "ZZZZZZ"
						If Empty(cVend) .and. nContador > 1
							Loop
						EndIf
						If ( aScan(aVend,cVend) == 0 )
							AADD(aVend,cVend)
						EndIf
						If nTOTAL > 0
							cCalcPr := "S"
							cObsCalc := "DEV"
						
							If SZ1->(Dbseek(xFilial("SZ1") + (cAliasSD1)->F2_DOC + (cAliasSD1)->F2_SERIE + (cAliasSD1)->F2_CLIENTE + (cAliasSD1)->F2_LOJA))
								dtEntreg := SZ1->Z1_DTENTRE 
								If SZ1->Z1_DTENTRE == CtoD("//")  
									If AllTrim((cAliasSD1)->F1_FORMUL) == "S"
										cCalcPr := "N"
										cObsCalc := "DEV S/ ENTREGA FORMUL. PROPRIO"
									EndIf
								EndIf
							EndIf  
							DbSelectArea("DGXLS")
			
							("DGXLS")->(RecLock("DGXLS",.T.))
						
							DGXLS->CALCULA	:= cCalcPr
							DGXLS->OBSCALC	:= cObsCalc
							("DGXLS")->FILIAL	:= cSd1fil
							//("DGXLS")->COMISS	:=	nComissao
							//("DGXLS")->VRLCOMIS := -nTOTAL * (nComissao/100)
							("DGXLS")->CODVEN1    := cVend 
							("DGXLS")->VEND1    := 	(cAliasSD1)->A3_NOME
							("DGXLS")->D2ITEM    := 	(cAliasSD1)->D1_ITEM
							("DGXLS")->DOC		:= (cAliasSD1)->(F1_DOC)
							("DGXLS")->SERIE		:= (cAliasSD1)->(F1_SERIE)
							("DGXLS")->CODCLI		:= (cAliasSD1)->(F2_CLIENTE)
							("DGXLS")->LOJA		:= (cAliasSD1)->(F2_LOJA)  
							("DGXLS")->CLIENTE	:= SA1->A1_NREDUZ
							("DGXLS")->UF		:=  (cAliasSD1)->F1_EST
							("DGXLS")->PRODUTO     	:=  (cAliasSd1)->D1_COD
							("DGXLS")->TIPONF     	:= (cAliasSD1)->D1_TIPO
							("DGXLS")->CFOP			:=  (cAliasSD1)->D1_CF
							("DGXLS")->GRPREP		:= (cAliasSd1)->A3_GRPREP
							("DGXLS")->CANAL 	:= (cAliasSD1)->ACA_DESCRI
							("DGXLS")->CODPGTO	:= (cAliasSd1)->F1_COND
							("DGXLS")->TITULONC	:= (cAliasSD1)->B1_XDESC
							("DGXLS")->TB_PLATRED := (cAliasSD1)->B1_PLATAF
							("DGXLS")->TB_PUBLISH	:= (cAliasSD1)->B1_PUBLISH
							("DGXLS")->DATANF := SubStr((cAliasSD1)->F1_EMISSAO,7,2) + "/" + SubStr((cAliasSD1)->F1_EMISSAO,5,2) + "/" + SubStr((cAliasSD1)->F1_EMISSAO,1,4) 
							("DGXLS")->DATASTR := (cAliasSD1)->F1_EMISSAO
							//("DGXLS")->DTENTR	:=	Stod((cAliasSd1)->Z1_DTENTRE)
							
							("DGXLS")->MES			:= STRZERO(MONTH(STOD((cAliasSD1)->D1_DTDIGIT)),2)
							("DGXLS")->MESREA		:=  STRZERO(MONTH(STOD((cAliasSD1)->D1_DTDIGIT)),2)  
							("DGXLS")->CUSTO	:=	(cAliasSd1)->D1_CUSTO							
							("DGXLS")->VALDEVM  :=  ("DGXLS")->VALDEVM-nTOTAL
							("DGXLS")->VALDSIMP  :=  ("DGXLS")->VALDSIMP-(nTOTAL-nVALICM)
							("DGXLS")->VALDTOT  :=  ("DGXLS")->VALDTOT-nTOTAL-nVALIPI-nValDesDev
							("DGXLS")->QTDDEV  :=  ("DGXLS")->QTDDEV-nQtdvend
							("DGXLS")->VLRUNIDEV  :=  ("DGXLS")->VALDTOT/ ("DGXLS")->QTDDEV   
							//TB_DOC	    := (cAliasSD1)->F1_DOC
							("DGXLS")->(MsUnlock())
						EndIf
					Endif
			EndIf
		Else
			If AvalTes((cAliasSD1)->D1_TES,cEstoq,cDupli)
				nTaxa	:=	IIf((cAliasSD1)->(FieldPos("F1_TXMOEDA"))>0,(cAliasSD1)->F1_TXMOEDA,0)
				nMoedNF	:=	IIF((cAliasSD1)->(FieldPos("F1_MOEDA"))>0,(cAliasSD1)->F1_MOEDA,1)
 				nTOTAL	:= xMoeda(((cAliasSD1)->D1_TOTAL - (cAliasSD1)->D1_VALDESC),nMoedNF,1,DtMoedaDev,nDecs+1,nTaxa)
				nQtdVend:= (cAliasSD1)->D1_QUANT
				cVendedor := "1"
				For nContador := 1 TO 1
					dbSelectArea("DGXLS")
					//DbClearIndex() 
					//dbSetIndex("SYSTEM\" + CNOMEDBF + OrdBagExt())
					//dbSetOrder(1) 
					
					If SA1->(dbSeek( cSA1Fil + (cAliasSD1)->F2_CLIENTE + (cAliasSD1)->F2_LOJA)) 
					
					EndIf 
					cVend := (cAliasSD1)->(FieldGet((cAliasSD1)->(FieldPos("F1_VEND"+cVendedor))))
					cVendedor := Soma1(cVendedor,1)
					If cVend >= "      " .And. cVend <= "ZZZZZZ"
						If Empty(cVend) .and. nContador > 1
							Loop
						EndIf
						If ( aScan(aVend,cVend) == 0 )
							AADD(aVend,cVend)
						EndIf
						If nTOTAL > 0
							DbSelectArea("DGXLS") 
							//DbClearIndex() 
							//dbSetIndex("SYSTEM\" + CNOMEDBF + OrdBagExt())
							//DbsetOrder(1)  
							//DbGoTop()
							If ("DGXLS")->(dbSeek( cSd1fil + (cAliasSD1)->(F1_DOC) +  (cAliasSD1)->(F1_SERIE) +  (cAliasSD1)->(D1_ITEM) + (cAliasSD1)->(F2_CLIENTE) + (cAliasSD1)->(F2_LOJA) ))
								("DGXLS")->(RecLock("DGXLS",.F.))
							Else
								//("DGXLS")->(DbGoTop())
								//("DGXLS")->(DbClearIndex())
								("DGXLS")->(RecLock("DGXLS",.T.))
							EndIf
							
							DGXLS->CALCULA	:= cCalcPr
							DGXLS->OBSCALC	:= cObsCalc
							
							("DGXLS")->FILIAL	:= cSd1fil
							//("DGXLS")->COMISS	:= nComissao
							//("DGXLS")->VRLCOMIS := -nTOTAL * (nComissao/100)
							("DGXLS")->D2ITEM    := 	(cAliasSD1)->D1_ITEM
							("DGXLS")->DOC		:= (cAliasSD1)->(F1_DOC)
							("DGXLS")->SERIE		:= (cAliasSD1)->(F1_SERIE)
							("DGXLS")->CODCLI		:= (cAliasSD1)->(F2_CLIENTE)
							("DGXLS")->LOJA	   := (cAliasSD1)->(F2_LOJA)
							("DGXLS")->CLIENTE	:= SA1->A1_NREDUZ
							("DGXLS")->CODVEN1    := cVend
							("DGXLS")->VEND1    := 	(cAliasSD1)->A3_NOME
							("DGXLS")->DATANF := SubStr((cAliasSD1)->F1_EMISSAO,7,2) + "/" + SubStr((cAliasSD1)->F1_EMISSAO,5,2) + "/" + SubStr((cAliasSD1)->F1_EMISSAO,1,4) 
							("DGXLS")->DATASTR := (cAliasSD1)->F1_EMISSAO
							("DGXLS")->VALDEVM  := ("DGXLS")->VALDEVM-nTOTAL
							("DGXLS")->VALDSIMP  := ("DGXLS")->VALDSIMP-nTOTAL
							("DGXLS")->VALDTOT  := ("DGXLS")->VALDTOT-nTotal
							("DGXLS")->QTDDEV  := ("DGXLS")->QTDDEV-nQtdvend
							("DGXLS")->VLRUNIDEV  := ("DGXLS")->VALDTOT/("DGXLS")->QTDDEV
							//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
							//ณ Pesquiso pelas caracteristicas de cada imposto               ณ
							//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
							aImpostos:=TesImpInf((cAliasSD1)->D1_TES)
							For nY:=1 to Len(aImpostos)
								cCampImp:= (cAliasSD1)+"->"+(aImpostos[nY][2])
								nImpos	:=	xMoeda(&cCampImp.,nMoedNF,1,DtMoedaDev,nDecs+1,nTaxa)
								If ( aImpostos[nY][3]=="1" )
 											("DGXLS")->VALDTOT  := VALDTOT - nImpos
									("DGXLS")->VLRUNIDEV  := VALDTOT/QTDDEV
								ElseIf ( aImpostos[nY][3]=="2" )
									("DGXLS")->VALDSIMP  := VALDSIMP + nImpos
								EndIf
							Next nY
							//TB_DOC	    := (cAliasSD1)->F1_DOC 
							("DGXLS")->(MsUnlock())
						Endif												
					EndIf
				Next nContador
			Endif
		Endif
		dbSelectArea(cAliasSD1) 
		//cSd1Old := (cAliasSD1)->D1_FILIAL+(cAliasSD1)->D1_FORNECE+(cAliasSD1)->D1_LOJA(cAliasSD1)->D1_DTDIGIT,D1_DOC,D1_SERIE//,D1_NUMSEQ
		cSD1Old := (cAliasSD1)->D1_DOC+(cAliasSD1)->D1_SERIE+(cAliasSD1)->D1_FORNECE+(cAliasSD1)->D1_LOJA
		If ( cPaisLoc=="BRA")
			nValor3	:= xMoeda((cAliasSD1)->F1_ICMSRET,1,1,DtMoedaDev,nDecs+1)
		Else
			nValor3	:= xMoeda(IIf((cAliasSD1)->(FieldPos("F1_FRETINC"))>0.And.(cAliasSD1)->F1_FRETINC<> "S",;
					(cAliasSD1)->F1_FRETE,0);
					+(cAliasSD1)->F1_DESPESA,nMoedNF,1,DtMoedaDev,nDecs+1,nTaxa)
		EndIf                  
	EndIf
	
	dbSelectArea(cAliasSD1)
	dbSkip()
	/*
	If lFiltro				
		If Eof() .Or. ( (cAliasSD1)->D1_DOC+(cAliasSD1)->D1_SERIE+(cAliasSD1)->D1_FORNECE+(cAliasSD1)->D1_LOJA != cSD1Old)
		//If Eof() .Or. ( (cAliasSD1)->D1_FILIAL,(cAliasSD1)->D1_FORNECE,(cAliasSD1)->D1_LOJA,(cAliasSD1)->D1_DTDIGIT,D1_DOC,D1_SERIE != cSD1Old)
			dbSelectArea(cAliasSD1)
			//dbSkip(-1)
			FOR nContador := 1 TO 1
				//dbSelectArea("DGXLS")
				//dbClearIndex()
				//dbSetIndex("SYSTEM\" + CNOMEDBF + OrdBagExt())
				//dbSetOrder(1)
				If SA1->(dbSeek( cSA1Fil + (cAliasSD1)->F2_CLIENTE + (cAliasSD1)->F2_LOJA) )
				
				EndIf  
		
				DbSelectArea("DGXLS") 
				//DbClearIndex() 
				//dbSetIndex("SYSTEM\" + CNOMEDBF + OrdBagExt())
				//DbsetOrder(1)
				//DbGoTop()
				//If ("DGXLS")->(dbSeek( cSd1fil + (cAliasSD1)->(F1_DOC) +  (cAliasSD1)->(F1_SERIE) +  (cAliasSD1)->(D1_ITEM) + (cAliasSD1)->(F2_CLIENTE) + (cAliasSD1)->(F2_LOJA) ))
					//("DGXLS")->(RecLock("DGXLS",.F.))
					//("DGXLS")->VALDTOT  := ("DGXLS")->VALDTOT-nValor3
					//("DGXLS")->VLRUNIDEV  := ("DGXLS")->VALDTOT/("DGXLS")->QTDDEV
					//nValor3	:= 0
					//("DGXLS")->(MsUnlock())
				//Elseif nValor3 > 0
					//("DGXLS")->(DbClearIndex())
					("DGXLS")->(RecLock("DGXLS",.F.))
					//("DGXLS")->FILIAL	:= cSd1fil 
					//("DGXLS")->COMISS	:= nComissao
					//("DGXLS")->VRLCOMIS := -nTOTAL * (nComissao/100)
					//("DGXLS")->D2ITEM    := 	(cAliasSD1)->D1_ITEM
				  	//("DGXLS")->DOC		:= (cAliasSD1)->(F1_DOC)
				   	//("DGXLS")->SERIE		:= (cAliasSD1)->(F1_SERIE)
					//("DGXLS")->CODCLI		:= (cAliasSD1)->(F2_CLIENTE)
					//("DGXLS")->LOJA		:= (cAliasSD1)->(F2_LOJA)
				   	//("DGXLS")->CODVEN1   := cVend
					//("DGXLS")->VEND1    := 	(cAliasSD1)->A3_NOME
					//("DGXLS")->DATANF := StoD((cAliasSD1)->F1_EMISSAO)
					//("DGXLS")->VALDEVM  := ("DGXLS")->VALDEVM-nTOTAL
					//("DGXLS")->VALDSIMP  := ("DGXLS")->VALDSIMP-nValor3
					("DGXLS")->VALDTOT  := ("DGXLS")->VALDTOT-nValor3
					//("DGXLS")->QTDDEV  := ("DGXLS")->QTDDEV-nQtdvend
					//("DGXLS")->VALDTOT  := ("DGXLS")->VALDTOT-nValor3
					("DGXLS")->VLRUNIDEV  := ("DGXLS")->VALDTOT/("DGXLS")->QTDDEV 
					//("DGXLS")->VRLCOMIS := ("DGXLS")->VALDTOT* (nComissao/100)
					nValor3	:= 0										
					("DGXLS")->(MsUnlock())
				//EndIf
			Next nContador
			aVend:={} 
			//dbSelectArea(cAliasSD1)
			//dbSkip()
		EndIf				
	EndIf
	*/			
	dbSelectArea(cAliasSD1)
EndDo
dbCloseArea()


dbSelectArea("DGXLS")
dbCloseArea()

//COPY FILE ("SYSTEM\" + CNOMEDBF + ".dbf") TO ("XLSNC\" + CNOMEDBF + ".dbf") 
CPYS2T("\SYSTEM\" + CNOMEDBF + ".dbf","C:\relatorios",.T.)
fErase("SYSTEM\" + CNOMEDBF +GetDBExtension()) 

//fErase("SYSTEM\DGXLSA"+OrdBagExt())
//fErase("SYSTEM\DGXLSB"+OrdBagExt())


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Restaura a integridade dos dados                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
dbSelectArea("SF2")
dbClearFilter()
dbSetOrder(1)

If Len(alArea) > 0
	RestArea(alArea)
EndIf 

MsgAlert("Arquivo gerado com sucesso. " ,"Termino" )


Return
	
	
	
	/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณDBMCRIASX1 บAutor ณ DBMS- Alberto     บ Data ณ  27/02/2012  บฑฑ
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


PutSx1("DBM_ESPCOM","01","Quarter Base"	   		,"Quarter Base"			,"Quarter Base"  		,"mv_ch1","N",01,0,1,"G","(mv_par01 < 5)",""   ,"","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
PutSx1("DBM_ESPCOM","02","Ano Base"	   		,"Ano Base"			,"Ano Base"  		,"mv_ch2","C",04,0,1,"G","",""   ,"","","mv_par02","","","","","","","","","","","","","","","","",{},{},{})
PutSx1("DBM_ESPCOM","03","Canais"			,"Canais"	   		,"Canais"	    	,"mv_ch3","C",20,0,1,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",{},{},{})
//PutSx1("DBM_REGCOM","04","Canal Ate"		,"Canal Ate"	 	,"Canal Ate"	    ,"mv_ch4","C",06,0,1,"G","","ACA","","","mv_par03","","","","","","","","","","","","","","","","",{},{},{})


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
	
	
