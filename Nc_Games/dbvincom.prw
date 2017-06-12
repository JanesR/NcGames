#Include "MATR580.CH"
#Include "FIVEWIN.Ch"
#INCLUDE "protheus.ch"     
#Include "TBICONN.CH"  
#INCLUDE "TOPCONN.CH" 

#DEFINE CRLF Chr(13)+Chr(10)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณDBVINCOM บ Autor ณ Alberto Kibino    บ Data ณ  29/10/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ RELATORIO PARA GERAR DBF PARA RELATึRIO de COMISSOES       บฑฑ
ฑฑบ          ณ Regional 1 e Regional 2                                    บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6 IDE                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

User Function DBVINCOM()

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
Local nComissao	:= 0 
Local alData	:= {}
Local cSqlDev	:= "" 
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
Private cAliSZQ	:= "" 

Private lAuto := IIF(Select("SM0") > 0, .f., .t.)
		
IF LAUTO                                          
	QOUT("Preparando Environment ... "+DTOC(Date()) + " - "+Time())
	PREPARE ENVIRONMENT EMPRESA '01' FILIAL '03' TABLES 'SA1,SE1,SF4,SFM' //USER 'ADMIN' PASSWORD 'Ncg@m1' 
ENDIF 
nDecs:=msdecimais(1)
cSA1Fil	:= xFilial("SA1") 

clAlias := GetNextAlias()
cAliSZQ := GetNextAlias() 
nVendedor	:= Fa440CntVen()

            
DBMCRIASX1()

If !Pergunte("DBM_VINCOM",.T.)
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
    
alData := {DtoS(Firstday(CtoD("01/" +  MV_PAR01 + "/" + MV_PAR02))),DtoS(Lastday(CtoD("01/" +  MV_PAR01 + "/" + MV_PAR02)))}
 

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
AADD(aDbStru,{"DTENTR","C",10,aTam[2]})
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
                                                    

aTam:=TamSX3("A3_EMAIL")
AADD(aDbStru,{"EMAIL"    ,aTam[3],aTam[1],aTam[2]})

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

AADD(aDbStru,{"STATUSCML","C",20,0})

If Select("DGXLS") > 0
	DGXLS->(dbCloseArea())
EndIf

clTime := Time()
While ":" $ clTime
	clTime := Stuff(clTime,At(":",clTime),1,"")
End

CNOMEDBF := "NCVICOM"

If File("SYSTEM\" + CNOMEDBF + ".dbf")
	//fErase("XLSNC\" + CNOMEDBF +GetDBExtension())
	//COPY FILE ("XLSNC\" + CNOMEDBF + ".dbf") TO ("XLSNC\" + CNOMEDBF + SubStr(DtoS(Date()),5,4) + ".dbf")
	fErase("SYSTEM\" + CNOMEDBF +GetDBExtension())
EndIf

DBCREATE(CNOMEDBF,aDbStru,"DBFCDXADS")


MakeDir("C:\relatorios")



DbUseArea(.T.,"DBFCDXADS", "SYSTEM\" + CNOMEDBF,"DGXLS",.T.,.F.)


If File("DGXLS.cdx")
	fErase("DGXLS.cdx")
endIf

//Index On FILIAL+DOC+SERIE+CODCLI+LOJA+PRODUTO+D2ITEM TAG IND1 to DGXLS 
//Index On FILIAL+DOC+CODVEN1 TAG IND1 to DGXLS   


//IndRegua("SA1",cArquivo,cChave,,cFor)DbSelectArea("SA1")nIndex := RetIndex("SA1")#IFNDEF TOP   DbSetIndex(cArquivo

//IndRegua("DGXLS","SYSTEM\" + CNOMEDBF + "A","FILIAL+DOC+SERIE+CODCLI+LOJA+PRODUTO+D2ITEM",,,"Filtro a") 
//IndRegua("DGXLS","SYSTEM\" + CNOMEDBF ,"FILIAL+DOC+SERIE+D2ITEM+CODCLI+LOJA",,)
//dbClearIndex()
//dbSetIndex("SYSTEM\" + CNOMEDBF + OrdBagExt()) 
//dbClearIndex()
//dbSetIndex("SYSTEM\" + CNOMEDBF+ "B" + OrdBagExt())

//DbSelectArea("DGXLS")
//DbSetOrder(1) 

MyNewSX6( "DBM_SUPERV", "000001", "C", "Grupo Clientes SuperVarejo", "Grupo Clientes SuperVarejo", "Grupo Clientes SuperVarejo", .F. ) 
MyNewSX6( "DBM_RCOMSV", 1, "N", "Percentual de comissใo Canal Regional Super Varejo", "Percentual de comissใo Canal Regional Super Varejo", "Percentual de comissใo Canal Regional Super Varejo", .F. )
MyNewSX6( "DBM_RCOMNO", 3, "N", "Percentual comissใo Cana Regional","Percentual comissใo Cana Regional","Percentual comissใo Cana Regional", .F. )
MyNewSX6( "DBM_DTFCKA", 15, "N", "Data de Fechamento comissใo Canal Regional","Data de Fechamento comissใo Canal Regional","Data de Fechamento comissใo Canal Regional", .F. )
MyNewSX6( "DBM_DTFCES", 10, "N", "Data de Fechamento comissใo Canal Regional","Data de Fechamento comissใo Canal Regional","Data de Fechamento comissใo Canal Regional", .F. )
MyNewSX6( "DBM_GRPVIN", "000006", "C", "Grupo de venda interna","Grupo de venda interna","Grupo de venda interna", .F. )
MyNewSX6( "DBM_GRPVI2", "000007", "C", "Grupo de venda interna2","Grupo de venda interna2","Grupo de venda interna2", .F. )



If Select(clAlias) > 0
	dbSelectArea(clAlias)
	(clAlias)->(dbCloseArea())
Endif


_cQry:="	SELECT F2_FILIAL, F2_DOC, F2_SERIE, F2_COND, F2_EMISSAO, F2_VEND1, F2_VEND2, F2_VEND3, D2_ITEM, F2_YCANAL,"
_cQry+="		D2_DOC, D2_ITEM, D2_COD, D2_TOTAL, D2_QUANT, D2_PRCVEN, D2_VALIPI, D2_PICM, D2_EST, D2_TIPO, D2_CF,D2_PEDIDO, D2_ITEMPV, D2_CUSTO1, "
_cQry+="		F4_VENDA, D2_VALFRE, D2_SEGURO, D2_ICMSRET,"
_cQry+="		B1_DESC, B1_XDESC, B1_STACML,B1_PUBLISH,B1_PLATAF,"
_cQry+="		A1_COD, A1_LOJA, A1_NOME, A1_NREDUZ,A1_YCANAL, A1_YDCANAL, A1_GRPVEN,"
_cQry+="		ACA_DESCRI," 
_cQry+="		A3_COD, A3_NOME, A3_GRPREP, A3_EMAIL,"
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
_cQry+=" AND	ACA_GRPREP BETWEEN '" + GetMv("DBM_GRPVIN") + "' AND '" + GetMv("DBM_GRPVI2") + "'"  


_cQry+="	AND  	F2_FILIAL 	= D2_FILIAL
_cQry+="	AND  	F2_DOC 		= D2_DOC
_cQry+="	AND  	F2_SERIE 	= D2_SERIE
_cQry+="	AND  	D2_TES 		= F4_CODIGO
_cQry+="	AND		F4_DUPLIC 	= 'S'
_cQry+="	AND  	D2_COD 		= B1_COD
_cQry+="	AND  	F2_CLIENTE 	= A1_COD
_cQry+="	AND  	F2_LOJA 	= A1_LOJA
_cQry+="	AND  	F2_VEND1 	= A3_COD
_cQry+="	AND		A3_GRPREP 	= ACA_GRPREP 
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
dbUseArea(.T.,"TOPCONN",TCGENQRY(,,_cQry),clAlias, .T., .T.)
//dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cQry,.T.,.T.)
cSd1Fil := Xfilial("SD1")
 
DbSelectArea("SZQ")
DbSetORder(1) 


ProcRegua(1000)
fcount()


DBSELECTAREA(clAlias)
DBGOTOP()
DbSelectArea("DGXLS")
While !(clAlias)->(EOF()) 
	IncProc()    
	If AllTrim((clAlias)->A1_GRPVEN) == AllTrim(GetMv("DBM_SUPERV"))
		nComissao := GetMv("DBM_RCOMSV")
	Else
		nComissao := GetMv("DBM_RCOMNO")
	EndIf
	 
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
		DGXLS->DATANF			:= SUBSTR((clAlias)->F2_EMISSAO,7,2) + "/" + SUBSTR((clAlias)->F2_EMISSAO,5,2) + "/" + SUBSTR((clAlias)->F2_EMISSAO,1,4) //STOD((clAlias)->F2_EMISSAO)
		//DGXLS->DTENTR		:= SUBSTR((clAlias)->ZQ_DTENTR,7,2) + "/" + SUBSTR((clAlias)->ZQ_DTENTR,5,2) + "/" + SUBSTR((clAlias)->ZQ_DTENTR,1,4) //StoD((clAlias)->ZQ_DTENTR)
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
		DGXLS->JUSTIFICAT := " "
		DGXLS->REFAT		:= " "
		DGXLS->CFOP			:=            (clAlias)->D2_CF
		DGXLS->CODVEN1     :=            (clAlias)->F2_VEND1
   		DGXLS->CODVEN2     :=            (clAlias)->F2_VEND2
		DGXLS->CODVEN3     :=            (clAlias)->F2_VEND3
		DGXLS->EMAIL		:=  (clAlias)->A3_EMAIL
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
		DGXLS->USUARIO  	:= (clAlias)->C6_X_USRLB //USUARIO QUE EMITIU O PEDIDO
		DGXLS->VALFAT		:= (clAlias)->(D2_VALFRE + D2_SEGURO + D2_ICMSRET + D2_VALIPI + D2_TOTAL)
		DGXLS->CUSTO		:= (clAlias)->D2_CUSTO1
		DGXLS->META	:= 0
		DGXLS->PEDIDO		:= (clAlias)->D2_PEDIDO
		DGXLS->ITEMPED	:= (clAlias)->D2_ITEMPV 
		DGXLS->COMISS	:= 	nComissao
		DGXLS->VRLCOMIS :=  (clAlias)->(D2_VALFRE + D2_SEGURO + D2_ICMSRET + D2_VALIPI + D2_TOTAL) * (nComissao/100)
		DGXLS->STATUSCML	:= " " //noacento(GETADVFVAL("SX5","X5_DESCRI",XFILIAL("SX5")+"ZX"+(clAlias)->B1_STACML,1,""))
		DGXLS->(MsUnLock())
	EndIf
	DBSELECTAREA(clAlias)
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


//oReport:Section(3):BeginQuery()
//BeginSql Alias cAliasSD1

cSqlDev := " SELECT SD1.*, F1_EMISSAO, F1_DOC, F1_SERIE, F1_FORNECE, F1_LOJA, F1_FRETE, F1_DESPESA, F1_SEGURO, F1_ICMSRET, F1_EST, F1_COND,"
cSqlDev += " F1_DTDIGIT, F2_EMISSAO, F2_CLIENTE, F2_LOJA, F2_VEND1, F1_TXMOEDA, F1_MOEDA, A3_NOME, A3_GRPREP, A3_EMAIL, ACA_DESCRI, B1_XDESC, B1_PLATAF, B1_PUBLISH " + cAddField
cSqlDev += " FROM " + RetSqlName("SD1") + " SD1, " + RetSqlname("SF4") + " SF4, " + RetSqlName("SF2") + " SF2, " + RetSqlName("SF1") + " SF1, " + RetSqlName("SA3") + " SA3," + RetSqlName("ACA") + " ACA,"+ RetSqlName("SB1") + " SB1"
cSqlDev += " WHERE D1_FILIAL  = '" + xFilial("SD1") + "'"
cSqlDev += " AND D1_DTDIGIT BETWEEN '" + DTOS(cl_par12) + "' AND '" + DTOS(cl_par13) + "'"
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
cSqlDev += " AND ACA_FILIAL = '" + xFilial("ACA") + "'"
cSqlDev += " AND ACA_GRPREP = A3_GRPREP" 
cSqlDev += " AND B1_FILIAL = '" + xFilial("SB1") + "' "
cSqlDev += " AND B1_COD = D1_COD "
cSqlDev += " AND A3_FILIAL	= '" + xFilial("SA3")  + "' " 
cSqlDev += " AND A3_GRPREP BETWEEN '" + GetMv("DBM_GRPVIN") + "' AND '" + GetMv("DBM_GRPVI2") + "'"

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
	//oReport:IncMeter()
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
		//If MV_PAR10 == 1 .Or. Empty((cAliasSD1)->F2_EMISSAO)           
			//DtMoedaDev  := (cAliasSD1)->F1_DTDIGIT
		//Else
			DtMoedaDev  := StoD((cAliasSD1)->F2_EMISSAO)
		//EndIf  
            
		If cPaisLoc == "BRA"
			If AvalTes((cAliasSD1)->D1_TES,cEstoq,cDupli)

				nVALICM := xMoeda((cAliasSD1)->D1_VALICM,1,1,DtMoedaDev,nDecs+1)
				nVALIPI := xMoeda((cAliasSD1)->D1_VALIPI,1,1,DtMoedaDev ,nDecs+1)
				nTOTAL  := xMoeda(((cAliasSD1)->D1_TOTAL - (cAliasSD1)->D1_VALDESC),1,1,DtMoedaDev,nDecs+1)
				nQtdVend:= (cAliasSD1)->D1_QUANT

				cVendedor := "1"
//						For nContador := 1 TO nVendedor
					
					dbSelectArea("DGXLS")
					//dbClearIndex() 
					//dbSetIndex("SYSTEM\" + CNOMEDBF + OrdBagExt())
					//dbSetOrder(1) 
					If SA1->(dbSeek( cSA1Fil + (cAliasSD1)->F2_CLIENTE + (cAliasSD1)->F2_LOJA)) 
						If AllTrim(SA1->A1_GRPVEN) == AllTrim(GetMv("DBM_SUPERV"))
							cDocDev := "DEVOLUCSV"
							nComissao := GetMv("DBM_RCOMSV")
						Else
							cDocDev := "DEVOLUCAO"
							nComissao := GetMv("DBM_RCOMNO")
						EndIf
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
							DbSelectArea("DGXLS")
							//dbCLearIndex()  
							//dbSetIndex("SYSTEM\" + CNOMEDBF + OrdBagExt())
							//DbsetOrder(1)
							//DbGoTop()
							//If ("DGXLS")->(dbSeek( cSd1fil + (cAliasSD1)->(F1_DOC) +  (cAliasSD1)->(F1_SERIE) +  (cAliasSD1)->(D1_ITEM)+ (cAliasSD1)->(F2_CLIENTE) + (cAliasSD1)->(F2_LOJA) ))
								//("DGXLS")->(RecLock("DGXLS",.F.) )
							//Else 
								//dbClearIndex()
								("DGXLS")->(RecLock("DGXLS",.T.))
							//EndIf
							
							("DGXLS")->FILIAL	:= cSd1fil
							("DGXLS")->COMISS	:=	nComissao
							("DGXLS")->VRLCOMIS := -nTOTAL * (nComissao/100)
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
							("DGXLS")->EMAIL		:=  (cAliasSd1)->A3_EMAIL
							("DGXLS")->GRPREP		:= (cAliasSd1)->A3_GRPREP
							("DGXLS")->CANAL 	:= (cAliasSD1)->ACA_DESCRI
							("DGXLS")->CODPGTO	:= (cAliasSd1)->F1_COND
							("DGXLS")->TITULONC	:= (cAliasSD1)->B1_XDESC
							("DGXLS")->TB_PLATRED := (cAliasSD1)->B1_PLATAF
							("DGXLS")->TB_PUBLISH	:= (cAliasSD1)->B1_PUBLISH
							("DGXLS")->DATANF := SUBSTR((cAliasSD1)->F1_EMISSAO,7,2) + "/" + SUBSTR((cAliasSD1)->F1_EMISSAO,5,2) + "/" + SUBSTR((cAliasSD1)->F1_EMISSAO,1,4)//Stod((cAliasSD1)->F1_EMISSAO)
							("DGXLS")->MES		:= STRZERO(MONTH(STOD((cAliasSD1)->F1_EMISSAO)),2)
							("DGXLS")->CUSTO	:=	(cAliasSd1)->D1_CUSTO							
							("DGXLS")->VALDEVM  :=  ("DGXLS")->VALDEVM-nTOTAL
							("DGXLS")->VALDSIMP  :=  ("DGXLS")->VALDSIMP-(nTOTAL-nVALICM)
							("DGXLS")->VALDTOT  :=  ("DGXLS")->VALDTOT-nTOTAL-nVALIPI
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
						If AllTrim(SA1->A1_GRPVEN) == AllTrim(GetMv("DBM_SUPERV"))
							cDocDev := "DEVOLUCSV" 
							nComissao := GetMv("DBM_RCOMSV")
						Else
							cDocDev := "DEVOLUCAO" 
							nComissao := GetMv("DBM_RCOMNO")
						EndIf
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
							
							("DGXLS")->FILIAL	:= cSd1fil
							("DGXLS")->COMISS	:= nComissao
							("DGXLS")->VRLCOMIS := -nTOTAL * (nComissao/100)
							("DGXLS")->D2ITEM    := 	(cAliasSD1)->D1_ITEM
							("DGXLS")->DOC		:= (cAliasSD1)->(F1_DOC)
							("DGXLS")->SERIE		:= (cAliasSD1)->(F1_SERIE)
							("DGXLS")->CODCLI		:= (cAliasSD1)->(F2_CLIENTE)
							("DGXLS")->LOJA	   := (cAliasSD1)->(F2_LOJA)
							("DGXLS")->CLIENTE	:= SA1->A1_NREDUZ
							("DGXLS")->EMAIL		:=  (cAliasSd1)->A3_EMAIL
							("DGXLS")->CODVEN1    := cVend
							("DGXLS")->VEND1    := 	(cAliasSD1)->A3_NOME
							("DGXLS")->DATANF := StoD((cAliasSD1)->F1_EMISSAO)
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
	(cAliasSD1)->(dbSkip())
	
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
					If AllTrim(SA1->A1_GRPVEN) == AllTrim(GetMv("DBM_SUPERV"))
						cDocDev := "DEVOLUCSV" 
						nComissao := GetMv("DBM_RCOMSV")
					Else
						cDocDev := "DEVOLUCAO" 
						nComissao := GetMv("DBM_RCOMNO")
					EndIf
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
					("DGXLS")->VRLCOMIS := ("DGXLS")->VALDTOT* (nComissao/100)
					nValor3	:= 0										
					("DGXLS")->(MsUnlock())
				//EndIf
			Next nContador
			aVend:={} 
			//dbSelectArea(cAliasSD1)
			//dbSkip()
		EndIf				
	EndIf			
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


PutSx1("DBM_VINCOM","01","Mes Base"	   		,"Mes Base"			,"Mes Base"  		,"mv_ch1","C",02,0,1,"G","",""   ,"","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
PutSx1("DBM_VINCOM","02","Ano Base"	   		,"Ano Base"			,"Ano Base"  		,"mv_ch2","C",04,0,1,"G","",""   ,"","","mv_par02","","","","","","","","","","","","","","","","",{},{},{})


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
	
	
