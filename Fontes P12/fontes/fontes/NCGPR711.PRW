#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'TopConn.ch'
#INCLUDE "RPTDEF.CH"
#INCLUDE "Font.ch"
#INCLUDE "COLORS.CH"
#INCLUDE "REPORT.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR711  ºAutor  ³Microsiga           º Data ³  01/11/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function NCGPR711()
Local oReport	:= Nil
Private clAlias		:= GetNextAlias()
Private clAliasZZK	:=""
Private clAliasZZN	:=""
Private clAliasNCC	:=""
Private clAliasZZL	:=""

oReport:=ReportDef()

IIF(Select((clAlias)) > 0,(clAlias)->(dbCloseArea()),.f.  )

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR711  ºAutor  ³Microsiga           º Data ³  01/12/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function ReportDef()

Local cTitulo	:= "Relatório Gerencial VPC Verba"
Local cDescricao:= "Este programa tem como objetivo imprimir relatório de acordo com os parametros informados pelo usuario."
Local clPerg	:= Padr("NCGPR711",Len(SX1->X1_GRUPO))
Local oReport	:= Nil

Local oBreak	:= Nil
Local oTotal1	:= nil
Local oTotal2	:= nil
Local oTotal3	:= nil
Local oNotas	:= nil


NCRL1SX1(clPerg)

If Pergunte(clPerg, .T. )
	
	
	
	
	oReport := TReport():New("NCGPR711",cTitulo,clPerg,{|oReport| ReportPrint(oReport)},cDescricao)
	oReport:SetLandscape(.T.)//Impressao Paissagem
	oReport:oPage:nPaperSize:= 9
	oReport:DisableOrientation()//Desabilita a mudanca de impressao
	oReport:nDevice := 4
	
	oSection := TRSection():NeW(oReport,"",(clAlias),,/*lLoadCells*/,/*lLoadOrder*/,/*uTotalText*/,/*lTotalInLine*/,/*lHeaderPage*/,.T./*lHeaderBreak*/,/*lPageBreak*/,/*lLineBreak*/,/*nLeftMargin*/,/*lLineStyle*/,/*nColSpace*/,/*lAutoSize*/,/*cCharSeparator*/,/*nLinesBefore*/,/*nCols*/,/*nClrBack*/,/*nClrFore*/,/*nPercentage*/)
	oSection:SetHeaderSection():=.F.
	
	TRCell():New(oSection,"ZZJ_CLIENT"		,(clAlias),/*Titulo*/			,/*Picture*/					,/*Tamanho*/,/*lPixel*/,{|| (clAlias)->CLIENTE		})
	TRCell():New(oSection,"ZZJ_LOJA"		,(clAlias),/*Titulo*/			,/*Picture*/					,/*Tamanho*/,/*lPixel*/,{|| (clAlias)->LOJA		})
	TRCell():New(oSection,"ZZJ_DESCLI"		,(clAlias),/*Titulo*/			,/*Picture*/					,/*Tamanho*/,/*lPixel*/,{|| (clAlias)->NOME		})
	TRCell():New(oSection,"ZZJ_MESPGT"		,(clAlias),/*Titulo*/			,/*Picture*/					,/*Tamanho*/,/*lPixel*/,{|| (clAlias)->MESPGTO		})
	
	// SECTION 1
	oSection1 := TRSection():NeW(oSection,"VPC com repasse Financeiro",(clAliasZZK),,/*lLoadCells*/,/*lLoadOrder*/,"Sub-Total VPC com repasse Financeiro"/*uTotalText*/,/*lTotalInLine*/,/*lHeaderPage*/,.T./*lHeaderBreak*/,/*lPageBreak*/,/*lLineBreak*/,/*nLeftMargin*/,/*lLineStyle*/,/*nColSpace*/,/*lAutoSize*/,/*cCharSeparator*/,/*nLinesBefore*/,/*nCols*/,/*nClrBack*/,/*nClrFore*/,/*nPercentage*/)
	oSection1:SetHeaderSection():=.F.
	oBreak1:= TRBreak():New( oSection1, {|| (clAliasZZK)->(ZZK_CLIENT+ZZK_LOJA)}, "Sub-Total VPC com repasse Financeiro")
	
	
	TRCell():New(oSection1,"ZZK_CODIGO"		,(clAliasZZK),"Apuração"	    	,/*Picture*/				,/*Tamanho*/,/*lPixel*/,{|| (clAliasZZK)->ZZK_CODIGO								})
	TRCell():New(oSection1,"ZZJ_TIPO"		,(clAliasZZK),					,/*Picture*/					,10	,/*lPixel*/,{|| X3COMBO("ZZJ_TIPO",Alltrim((clAliasZZK)->ZZJ_TIPO)) 	})
	
	TRCell():New(oSection1,"ZZK_CODVPC"		,(clAliasZZK),"Contrato"		,/*Picture*/					,10,/*lPixel*/,{|| (clAliasZZK)->(ZZK_CODVPC+"/"+ZZK_VERSAO)								})
	TRCell():New(oSection1,"ZZK_DESVPC"		,(clAliasZZK),/*Titulo*/			,/*Picture*/					,/*Tamanho*/,/*lPixel*/,{|| (clAliasZZK)->ZZK_DESVPC									})
	
	TRCell():New(oSection1,"ZZK_DTINIC"		,(clAliasZZK),/*Titulo*/			,/*Picture*/					,/*Tamanho*/,/*lPixel*/,{|| (clAliasZZK)->ZZK_DTINIC									})
	TRCell():New(oSection1,"ZZK_DTFIM"		,(clAliasZZK),/*Titulo*/			,/*Picture*/					,/*Tamanho*/,/*lPixel*/,{|| (clAliasZZK)->ZZK_DTFIM									})
	TRCell():New(oSection1,"ZZK_PERIOD"		,(clAliasZZK),					,/*Picture*/					,09			,/*lPixel*/,{|| X3COMBO("ZZ8_PERIOD",Alltrim((clAliasZZK)->ZZK_PERIOD)) 	})
	TRCell():New(oSection1,"ZZK_TPFAT"		,(clAliasZZK),					,/*Picture*/					,			,/*lPixel*/,{|| X3COMBO("ZZ8_TPFAT" ,Alltrim((clAliasZZK)->ZZK_TPFAT))		})
	
	TRCell():New(oSection1,"ZZK_PERCEN"		,(clAliasZZK),"%"			,/*Picture*/					,/*Tamanho*/,/*lPixel*/,{|| (clAliasZZK)->ZZK_PERCEN									})
	TRCell():New(oSection1,"ZZK_VLRBRU"		,(clAliasZZK),/*Titulo*/			,/*Picture*/					,/*Tamanho*/,/*lPixel*/,{|| (clAliasZZK)->ZZK_VLRBRU									})
	TRCell():New(oSection1,"ZZK_VLRLIQ"		,(clAliasZZK),/*Titulo*/			,/*Picture*/					,/*Tamanho*/,/*lPixel*/,{|| (clAliasZZK)->ZZK_VLRLIQ									})
	TRCell():New(oSection1,"ZZK_VLRVPC"		,(clAliasZZK),/*Titulo*/			,/*Picture*/					,/*Tamanho*/,/*lPixel*/,{|| (clAliasZZK)->ZZK_VLRVPC										})
	//TRCell():New(oSection1,"ZZJ_DTFECH"		,(clAliasZZK),					,								,/*Tamanho*/,/*lPixel*/    ,{|| (clAliasZZK)->ZZJ_DTFECH									})
	TRCell():New(oSection1,"E1_PREFIXO"		,(clAliasZZK),/*Titulo*/			,/*Picture*/					,/*Tamanho*/,/*lPixel*/,{|| (clAliasZZK)->E1_PREFIXO									})
	TRCell():New(oSection1,"E1_NUM"			,(clAliasZZK),/*Titulo*/			,/*Picture*/					,/*Tamanho*/,/*lPixel*/,{|| (clAliasZZK)->E1_NUM 										})
	TRCell():New(oSection1,"E1_EMISSAO"		,(clAliasZZK),/*Titulo*/			,/*Picture*/					,/*Tamanho*/,/*lPixel*/,{|| (clAliasZZK)->E1_EMISSAO									})
	TRCell():New(oSection1,"E1_VALOR"		,(clAliasZZK),/*Titulo*/			,/*Picture*/					,/*Tamanho*/,/*lPixel*/,{|| (clAliasZZK)->E1_VALOR										})
	TRCell():New(oSection1,"E1_SALDO"		,(clAliasZZK),/*Titulo*/			,/*Picture*/					,/*Tamanho*/,/*lPixel*/,{|| (clAliasZZK)->E1_SALDO										})
	
	If mv_par08=2 //Sintetico
		oTotal1:= TRFunction():New(oSection1:Cell("ZZK_VLRVPC"),/* cID */,"SUM",oBreak1,"Sub-Total Repasse"		,PesqPict("ZZK","ZZK_VLRVPC"  	),/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
		oTotal2:= TRFunction():New(oSection1:Cell("E1_VALOR")	,/* cID */,"SUM",oBreak1,"Sub-Total Vlr. Título"	,PesqPict("SE1","E1_VALOR"  	),/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
		oTotal3:= TRFunction():New(oSection1:Cell("E1_SALDO")	,/* cID */,"SUM",oBreak1,"Sub-Total Saldo"			,PesqPict("SE1","E1_SALDO"  	),/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
	EndIf
	
	
	// SECTION 2
	oSection2:= TRSection():NeW(oSection,"Verba Extra-Pedido de Venda",{},,/*lLoadCells*/,/*lLoadOrder*/,/*uTotalText*/,/*lTotalInLine*/,/*lHeaderPage*/,.T./*lHeaderBreak*/,/*lPageBreak*/,/*lLineBreak*/,/*nLeftMargin*/,/*lLineStyle*/,/*nColSpace*/,/*lAutoSize*/,/*cCharSeparator*/,/*nLinesBefore*/,/*nCols*/,/*nClrBack*/,/*nClrFore*/,/*nPercentage*/)
	oSection2:SetHeaderSection():=.F.
	oBreak2:= TRBreak():New( oSection2, {|| (clAliasZZN)->(ZZN_CLIENT+ZZN_LOJA)}, "Sub-Total Verba Extra-Pedido de Venda")
	
	TRCell():New(oSection2,"ZZN_CODIGO"		,(clAliasZZN),"Apuração"	    	,/*Picture*/				,/*Tamanho*/,/*lPixel*/,{|| (clAliasZZN)->ZZN_CODIGO								})
	TRCell():New(oSection2,"ZZM_TIPO"		,(clAliasZZN),					,/*Picture*/					,10			,/*lPixel*/,{|| X3COMBO("ZZM_TIPO",Alltrim((clAliasZZN)->ZZM_TIPO)) 	})
	TRCell():New(oSection2,"ZZM_PEDIDO"		,(clAliasZZN),					,/*Picture*/					,/*Tamanho*/			,/*lPixel*/,{|| (clAliasZZN)->ZZM_PEDIDO	})
	TRCell():New(oSection2,"ZZN_CODVER"		,(clAliasZZN),"Verba Extra"		,/*Picture*/					,10,/*lPixel*/,{|| (clAliasZZN)->(ZZN_CODVER+"/"+ZZN_VERSAO)								})
	//TRCell():New(oSection2,"ZZN_VERSAO"		,(clAliasZZN),/*Titulo*/			,/*Picture*/					,/*Tamanho*/,/*lPixel*/,{|| (clAliasZZN)->									})
	TRCell():New(oSection2,"ZZN_DESVER"		,(clAliasZZN),/*Titulo*/			,/*Picture*/					,/*Tamanho*/,/*lPixel*/,{|| (clAliasZZN)->ZZN_DESVER									})
	TRCell():New(oSection2,"ZZN_DTINIC"		,(clAliasZZN),/*Titulo*/			,/*Picture*/					,/*Tamanho*/,/*lPixel*/,{|| (clAliasZZN)->ZZN_DTINIC									})
	TRCell():New(oSection2,"ZZN_DTFIM"		,(clAliasZZN),/*Titulo*/			,/*Picture*/					,/*Tamanho*/,/*lPixel*/,{|| (clAliasZZN)->ZZN_DTFIM									})
	//TRCell():New(oSection2,"ZZN_PERIOD"		,(clAliasZZN),					,/*Picture*/					,12			,/*lPixel*/,{|| X3COMBO("ZZ8_PERIOD",Alltrim((clAliasZZN)->ZZN_PERIOD)) 	})
	TRCell():New(oSection2,"ZZN_TPFAT"		,(clAliasZZN),					,/*Picture*/					,			,/*lPixel*/,{|| X3COMBO("ZZ8_TPFAT" ,Alltrim((clAliasZZN)->ZZN_TPFAT))		})
	TRCell():New(oSection2,"ZZN_PERCEN"		,(clAliasZZN),"%"			,/*Picture*/					,/*Tamanho*/,/*lPixel*/,{|| (clAliasZZN)->ZZN_PERCEN									})
	TRCell():New(oSection2,"ZZN_VLRVER"		,(clAliasZZN),"R$"			,/*Picture*/					,/*Tamanho*/,/*lPixel*/,{|| (clAliasZZN)->ZZN_VLRVER									})
	
	TRCell():New(oSection2,"ZZN_VLRBRU"		,(clAliasZZN),/*Titulo*/			,/*Picture*/					,/*Tamanho*/,/*lPixel*/,{|| (clAliasZZN)->ZZN_VLRBRU									})
	//TRCell():New(oSection2,"ZZN_VLRLIQ"		,(clAliasZZN),/*Titulo*/			,/*Picture*/					,/*Tamanho*/,/*lPixel*/,{|| (clAliasZZN)->ZZN_VLRLIQ									})
	TRCell():New(oSection2,"ZZN_VLRVER"		,(clAliasZZN),/*Titulo*/			,/*Picture*/					,/*Tamanho*/,/*lPixel*/,{|| (clAliasZZN)->ZZN_VLRVER										})
	//TRCell():New(oSection2,"ZZM_DTFECH"		,(clAliasZZN),					,								,/*Tamanho*/,/*lPixel*/    ,{|| (clAliasZZN)->ZZM_DTFECH									})
	TRCell():New(oSection2,"E1_PREFIXO"		,(clAliasZZN),/*Titulo*/			,/*Picture*/					,/*Tamanho*/,/*lPixel*/,{|| (clAliasZZN)->E1_PREFIXO									})
	TRCell():New(oSection2,"E1_NUM"			,(clAliasZZN),/*Titulo*/			,/*Picture*/					,/*Tamanho*/,/*lPixel*/,{|| (clAliasZZN)->E1_NUM 										})
	TRCell():New(oSection2,"E1_EMISSAO"		,(clAliasZZN),/*Titulo*/			,/*Picture*/					,/*Tamanho*/,/*lPixel*/,{|| (clAliasZZN)->E1_EMISSAO									})
	TRCell():New(oSection2,"E1_VALOR"		,(clAliasZZN),/*Titulo*/			,/*Picture*/					,/*Tamanho*/,/*lPixel*/,{|| (clAliasZZN)->E1_VALOR										})
	TRCell():New(oSection2,"E1_SALDO"		,(clAliasZZN),/*Titulo*/			,/*Picture*/					,/*Tamanho*/,/*lPixel*/,{|| (clAliasZZN)->E1_SALDO										})
	TRCell():New(oSection2,""				,(clAliasZZN),""	   			,/*Picture*/,				,.F.,{|| ""															})
	
	oTotal4 := TRFunction():New(oSection2:Cell("ZZN_VLRVER"),/* cID */,"SUM",oBreak2,"Sub-Total Verba"	   		,PesqPict("ZZN","ZZN_VLRVER"  ),/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
	oTotal5= TRFunction():New(oSection2:Cell("ZZN_VLRBRU"),/* cID */,"SUM",oBreak2,"Sub-Total Vlr. Nota"		,PesqPict("ZZN","ZZN_VLRBRU"  ),/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
	
	
	// SECTION 3
	oSection3 := TRSection():NeW(oSection,"Verba Extra-NCC Periodica",(clAliasZZK),,/*lLoadCells*/,/*lLoadOrder*/,"Sub-Total Verba Extra-NCC Periodica"/*uTotalText*/,/*lTotalInLine*/,/*lHeaderPage*/,.T./*lHeaderBreak*/,/*lPageBreak*/,/*lLineBreak*/,/*nLeftMargin*/,/*lLineStyle*/,/*nColSpace*/,/*lAutoSize*/,/*cCharSeparator*/,/*nLinesBefore*/,/*nCols*/,/*nClrBack*/,/*nClrFore*/,/*nPercentage*/)
	oSection3:SetHeaderSection():=.F.
	oBreak3:= TRBreak():New( oSection3, {|| (clAliasNCC)->(ZZN_CLIENT+ZZN_LOJA)}, "Sub-Total Verba Extra-NCC Periodica")
	
	
	TRCell():New(oSection3,"ZZN_CODIGO"		,(clAliasNCC),"Apuração"	    	,/*Picture*/					,/*Tamanho*/,/*lPixel*/,{|| (clAliasNCC)->ZZN_CODIGO								})
	TRCell():New(oSection3,"ZZM_TIPO"		,(clAliasNCC),					,/*Picture*/					,10			,/*lPixel*/,{|| X3COMBO("ZZM_TIPO",Alltrim((clAliasNCC)->ZZM_TIPO)) 	})
	
	TRCell():New(oSection3,"ZZN_CODVPC"		,(clAliasNCC),"Verba Extra"		,/*Picture*/					,10,/*lPixel*/,{|| (clAliasNCC)->(ZZN_CODVER+"/"+ZZN_VERSAO)								})
	//TRCell():New(oSection3,"ZZN_VERSAO"		,(clAliasNCC),/*Titulo*/			,/*Picture*/					,/*Tamanho*/,/*lPixel*/,{|| (clAliasNCC)->ZZN_VERSAO									})
	TRCell():New(oSection3,"ZZN_DESVER"		,(clAliasNCC),/*Titulo*/			,/*Picture*/					,20,/*lPixel*/,{|| (clAliasNCC)->ZZN_DESVER									})
	
	TRCell():New(oSection3,"ZZN_DTINIC"		,(clAliasNCC),/*Titulo*/			,/*Picture*/					,/*Tamanho*/,/*lPixel*/,{|| (clAliasNCC)->ZZN_DTINIC									})
	TRCell():New(oSection3,"ZZN_DTFIM"		,(clAliasNCC),/*Titulo*/			,/*Picture*/					,/*Tamanho*/,/*lPixel*/,{|| (clAliasNCC)->ZZN_DTFIM									})
	TRCell():New(oSection3,"ZZN_PERIOD"		,(clAliasNCC),					,/*Picture*/					,09			,/*lPixel*/,{|| X3COMBO("ZZ8_PERIOD",Alltrim((clAliasNCC)->ZZN_PERIOD)) 	})
	TRCell():New(oSection3,"ZZN_TPFAT"		,(clAliasNCC),					,/*Picture*/					,			,/*lPixel*/,{|| X3COMBO("ZZ8_TPFAT" ,Alltrim((clAliasNCC)->ZZN_TPFAT))		})
	
	TRCell():New(oSection3,"ZZM_META"		,(clAliasNCC),/*Titulo*/			,/*Picture*/					,/*Tamanho*/,/*lPixel*/,{|| (clAliasNCC)->ZZM_META									})
	
	TRCell():New(oSection3,"ZZN_PERCEN"		,(clAliasNCC),'%'			,/*Picture*/					,/*Tamanho*/,/*lPixel*/,{|| (clAliasNCC)->ZZN_PERCEN									})
	TRCell():New(oSection3,"ZZN_VLRBRU"		,(clAliasNCC),/*Titulo*/			,/*Picture*/					,/*Tamanho*/,/*lPixel*/,{|| (clAliasNCC)->ZZN_VLRBRU									})
	TRCell():New(oSection3,"ZZN_VLRLIQ"		,(clAliasNCC),/*Titulo*/			,/*Picture*/					,/*Tamanho*/,/*lPixel*/,{|| (clAliasNCC)->ZZN_VLRLIQ									})
	TRCell():New(oSection3,"ZZN_VLRVER"		,(clAliasNCC),/*Titulo*/			,/*Picture*/					,/*Tamanho*/,/*lPixel*/,{|| (clAliasNCC)->ZZN_VLRVER										})
	//TRCell():New(oSection3,"ZZM_DTFECH"		,(clAliasNCC),					,								,/*Tamanho*/,/*lPixel*/    ,{|| (clAliasNCC)->ZZM_DTFECH									})
	TRCell():New(oSection3,"E1_PREFIXO"		,(clAliasNCC),/*Titulo*/			,/*Picture*/					,/*Tamanho*/,/*lPixel*/,{|| (clAliasNCC)->E1_PREFIXO									})
	TRCell():New(oSection3,"E1_NUM"			,(clAliasNCC),/*Titulo*/			,/*Picture*/					,/*Tamanho*/,/*lPixel*/,{|| (clAliasNCC)->E1_NUM 										})
	TRCell():New(oSection3,"E1_EMISSAO"		,(clAliasNCC),/*Titulo*/			,/*Picture*/					,/*Tamanho*/,/*lPixel*/,{|| (clAliasNCC)->E1_EMISSAO									})
	TRCell():New(oSection3,"E1_VALOR"		,(clAliasNCC),/*Titulo*/			,/*Picture*/					,/*Tamanho*/,/*lPixel*/,{|| (clAliasNCC)->E1_VALOR										})
	TRCell():New(oSection3,"E1_SALDO"		,(clAliasNCC),/*Titulo*/			,/*Picture*/					,/*Tamanho*/,/*lPixel*/,{|| (clAliasNCC)->E1_SALDO										})
	
	If mv_par08=2 //Sintetico
		oTotal6:= TRFunction():New(oSection3:Cell("ZZN_VLRVER"),/* cID */,"SUM",oBreak3,"Sub-Total Repasse"		,PesqPict("ZZN","ZZN_VLRVER"  	),/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
		oTotal7:= TRFunction():New(oSection3:Cell("E1_VALOR")	,/* cID */,"SUM",oBreak3,"Sub-Total Vlr. Título"	,PesqPict("SE1","E1_VALOR"  	),/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
		oTotal8:= TRFunction():New(oSection3:Cell("E1_SALDO")	,/* cID */,"SUM",oBreak3,"Sub-Total Saldo"			,PesqPict("SE1","E1_SALDO"  	),/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
	EndIf
	
	
	// SECTION 4
	oSaldo 	:= TRSection():New(oSection,"Saldo",,,/*lLoadCells*/,/*lLoadOrder*/,"Saldo",/*lTotalInLine*/,/*lHeaderPage*/,.T./*lHeaderBreak*/,/*lPageBreak*/,/*lLineBreak*/,/*nLeftMargin*/,/*lLineStyle*/,/*nColSpace*/,/*lAutoSize*/,/*cCharSeparator*/,/*nLinesBefore*/,/*nCols*/,/*nClrBack*/,/*nClrFore*/,/*nPercentage*/)
	oSaldo:SetHeaderSection():=.F.
	
	TRCell():New(oSaldo,""				,""	,""					,/*Picture*/					,			,.F.		,{|| ""	})
	TRCell():New(oSaldo,""				,""	,""					,/*Picture*/					,			,.F.		,{|| ""	})
	TRCell():New(oSaldo,""				,""	,""					,/*Picture*/					,			,.F.		,{|| ""	})
	TRCell():New(oSaldo,""				,""	,""					,/*Picture*/					,			,.F.		,{|| ""	})
	TRCell():New(oSaldo,""				,""	,""					,/*Picture*/					,			,.F.		,{|| ""	})
	TRCell():New(oSaldo,""				,""	,""					,/*Picture*/					,			,.F.		,{|| ""	})
	TRCell():New(oSaldo,""				,""	,""					,/*Picture*/					,			,.F.		,{|| ""	})
	TRCell():New(oSaldo,""				,""	,""					,/*Picture*/					,			,.F.		,{|| ""	})
	TRCell():New(oSaldo,""				,""	,""					,/*Picture*/					,			,.F.		,{|| ""	})
	TRCell():New(oSaldo,""				,""	,""					,/*Picture*/					,			,.F.		,{|| ""	})
	TRCell():New(oSaldo,""				,""	,""					,/*Picture*/					,			,.F.		,{|| ""	})
	TRCell():New(oSaldo,""				,""	,""					,/*Picture*/					,			,.F.		,{|| ""	})
	//TRCell():New(oSaldo,""				,""	,""					,/*Picture*/					,			,.F.		,{|| ""	})
	TRCell():New(oSaldo,"TOTREPAS"		,""	,"Total Apurado"	,PesqPict("ZZN","ZZN_VLRVER")	,/*Tamanho*/,/*lPixel*/	,{|| 	})
	TRCell():New(oSaldo,""				,""	,""					,/*Picture*/					,			,.F.		,{|| ""	})
	TRCell():New(oSaldo,""				,""	,""					,/*Picture*/					,			,.F.		,{|| ""	})
	TRCell():New(oSaldo,""				,""	,""					,/*Picture*/					,			,.F.		,{|| ""	})
	TRCell():New(oSaldo,"TOTALTIT"		,""	,"Total Titulos"	,PesqPict("SE1","E1_VALOR")		,/*Tamanho*/,/*lPixel*/	,{|| ""	})
	TRCell():New(oSaldo,"SALDOABER"		,""	,"Total Saldo"		,PesqPict("SE1","E1_SALDO")		,/*Tamanho*/,/*lPixel*/	,{|| ""	})
	
	
	
	//Section Itens ZZL
	oSectionZZL := TRSection():NeW(oSection,"VPC com repasse Financeiro-Itens","ZZL",,/*lLoadCells*/,/*lLoadOrder*/,/*uTotalText*//*uTotalText*/,/*lTotalInLine*/,/*lHeaderPage*/,.T./*lHeaderBreak*/,/*lPageBreak*/,/*lLineBreak*/,/*nLeftMargin*/,/*lLineStyle*/,/*nColSpace*/,/*lAutoSize*/,/*cCharSeparator*/,/*nLinesBefore*/,/*nCols*/,/*nClrBack*/,/*nClrFore*/,/*nPercentage*/)
	oSectionZZL:SetHeaderSection():=.F.
	
	//TRCell():New(oSectionZZL,"ZZL_TPNOTA"		,"ZZL","TpNota"					,/*Picture*/					,			,/*lPixel*/,{|| X3COMBO("ZZL_TPNOTA" ,Alltrim(ZZL->ZZL_TPNOTA))		})
	TRCell():New(oSectionZZL,"ZZL_TPNOTA"		,"ZZL","Tp"					,/*Picture*/					,	 1		,/*lPixel*/,{|| ZZL->ZZL_TPNOTA		})
	TRCell():New(oSectionZZL,"ZZL_NOTA"		    ,"ZZL",/*Titulo*/	    	,/*Picture*/				,/*Tamanho*/,/*lPixel*/,{|| ZZL->(ZZL_NOTA+"-"+ZZL_SERIE)								})
	//TRCell():New(oSectionZZL,"ZZL_SERIE"		,"ZZL",/*Titulo*/	    	,/*Picture*/				,/*Tamanho*/,/*lPixel*/,{|| ZZL->ZZL_SERIE							})
	TRCell():New(oSectionZZL,"ZZL_EMISSA"		,"ZZL",/*Titulo*/	    	,/*Picture*/				,/*Tamanho*/,/*lPixel*/,{|| ZZL->ZZL_EMISSA						})
	TRCell():New(oSectionZZL,"ZZL_ENTREG"		,"ZZL",/*Titulo*/	    	,/*Picture*/				,/*Tamanho*/,/*lPixel*/,{|| ZZL->ZZL_ENTREG						})
	TRCell():New(oSectionZZL,"ZZL_PRODUT"		,"ZZL",/*Titulo*/	    	,/*Picture*/				,/*Tamanho*/,/*lPixel*/,{|| ZZL->ZZL_PRODUT							})
	TRCell():New(oSectionZZL,"B1_XDESC"		     ,"ZZL",/*Titulo*/	    	,/*Picture*/				,20,/*lPixel*/,{|| Left(SB1->B1_XDESC,20)							})
	TRCell():New(oSectionZZL,"ZZL_QUANT"		,"ZZL",/*Titulo*/	    	,/*Picture*/				,/*Tamanho*/,/*lPixel*/,{|| ZZL->ZZL_QUANT								})
	TRCell():New(oSectionZZL,"ZZL_VALIPI"		,"ZZL",/*Titulo*/	    	,/*Picture*/				,5,/*lPixel*/,{|| ZZL->ZZL_VALIPI								})
	TRCell():New(oSectionZZL,"ZZL_VALICM"		,"ZZL",/*Titulo*/	    	,/*Picture*/				,/*Tamanho*/,/*lPixel*/,{|| ZZL->ZZL_VALICM								})
	TRCell():New(oSectionZZL,"ZZL_ICMSRE"		,"ZZL",/*Titulo*/	    	,/*Picture*/				,/*Tamanho*/,/*lPixel*/,{|| ZZL->ZZL_ICMSRE								})
	TRCell():New(oSectionZZL,"ZZL_VALIM5"		,"ZZL",/*Titulo*/	    	,/*Picture*/				,/*Tamanho*/,/*lPixel*/,{|| ZZL->ZZL_VALIM5								})
	TRCell():New(oSectionZZL,"ZZL_VALIM6"		,"ZZL",/*Titulo*/	    	,/*Picture*/				,/*Tamanho*/,/*lPixel*/,{|| ZZL->ZZL_VALIM6								})
	TRCell():New(oSectionZZL,"ZZL_SEGURO"		,"ZZL","Frete+Seg+Desp"	   	,/*Picture*/				,/*Tamanho*/,/*lPixel*/,{|| ZZL->(ZZL_SEGURO+ZZL_VALFRE+ZZL_DESPES)								})
	//TRCell():New(oSectionZZL,"ZZL_VALFRE"		,"ZZL",/*Titulo*/	    	,/*Picture*/				,/*Tamanho*/,/*lPixel*/,{|| ZZL->ZZL_VALFRE								})
	//TRCell():New(oSectionZZL,"ZZL_DESPES"		,"ZZL",/*Titulo*/	    	,/*Picture*/				,/*Tamanho*/,/*lPixel*/,{|| ZZL->ZZL_DESPES								})
	TRCell():New(oSectionZZL,"ZZL_TOTAL"		,"ZZL",/*Titulo*/	    	,/*Picture*/				,/*Tamanho*/,/*lPixel*/,{|| ZZL->ZZL_TOTAL								})
	TRCell():New(oSectionZZL,"ZZL_VLRBRU"		,"ZZL",/*Titulo*/	    	,/*Picture*/				,/*Tamanho*/,/*lPixel*/,{|| ZZL->ZZL_VLRBRU							})
	TRCell():New(oSectionZZL,"ZZL_VLRLIQ"		,"ZZL",/*Titulo*/	    	,/*Picture*/				,/*Tamanho*/,/*lPixel*/,{|| ZZL->ZZL_VLRLIQ							})
	TRCell():New(oSectionZZL,"ZZL_VLRVPC"		,"ZZL",/*Titulo*/	    	,/*Picture*/				,/*Tamanho*/,/*lPixel*/,{|| ZZL->ZZL_VLRVPC							})
	
	//Section Itens ZZO
	oSectionZZO := TRSection():NeW(oSection,"Verba Extra-Itens","ZZO",,/*lLoadCells*/,/*lLoadOrder*/,/*uTotalText*//*uTotalText*/,/*lTotalInLine*/,/*lHeaderPage*/,.T./*lHeaderBreak*/,/*lPageBreak*/,/*lLineBreak*/,/*nLeftMargin*/,/*lLineStyle*/,/*nColSpace*/,/*lAutoSize*/,/*cCharSeparator*/,/*nLinesBefore*/,/*nCols*/,/*nClrBack*/,/*nClrFore*/,/*nPercentage*/)
	oSectionZZO:SetHeaderSection():=.F.
	
	//TRCell():New(oSectionZZO,"ZZO_TPNOTA"		,"ZZO","TpNota"					,/*Picture*/					,			,/*lPixel*/,{|| X3COMBO("ZZO_TPNOTA" ,Alltrim(ZZO->ZZO_TPNOTA))		})
	TRCell():New(oSectionZZO,"ZZO_TPNOTA"		,"ZZO","Tp"					,/*Picture*/					,	  1		,/*lPixel*/,{|| ZZO->ZZO_TPNOTA		})
	TRCell():New(oSectionZZO,"ZZO_NOTA"		    ,"ZZO",/*Titulo*/	    	,/*Picture*/				,/*Tamanho*/,/*lPixel*/,{|| ZZO->(ZZO_NOTA+"-"+ZZO_SERIE)								})
	//TRCell():New(oSectionZZO,"ZZO_SERIE"		,"ZZO",/*Titulo*/	    	,/*Picture*/				,/*Tamanho*/,/*lPixel*/,{|| ZZO->ZZO_SERIE							})
	TRCell():New(oSectionZZO,"ZZO_EMISSA"		,"ZZO",/*Titulo*/	    	,/*Picture*/				,/*Tamanho*/,/*lPixel*/,{|| ZZO->ZZO_EMISSA						})
	TRCell():New(oSectionZZO,"ZZO_ENTREG"		,"ZZO",/*Titulo*/	    	,/*Picture*/				,/*Tamanho*/,/*lPixel*/,{|| ZZO->ZZO_ENTREG						})
	TRCell():New(oSectionZZO,"ZZO_PRODUT"		,"ZZO",/*Titulo*/	    	,/*Picture*/				,/*Tamanho*/,/*lPixel*/,{|| ZZO->ZZO_PRODUT							})
	TRCell():New(oSectionZZO,"B1_XDESC"		    ,"ZZO",/*Titulo*/	    	,/*Picture*/				,20,/*lPixel*/,{|| Left(SB1->B1_XDESC,20)							})
	TRCell():New(oSectionZZO,"ZZO_QUANT"		,"ZZO",/*Titulo*/	    	,/*Picture*/				,/*Tamanho*/,/*lPixel*/,{|| ZZO->ZZO_QUANT								})
	TRCell():New(oSectionZZO,"ZZO_VALIPI"		,"ZZO",/*Titulo*/	    	,/*Picture*/				,5,/*lPixel*/,{|| ZZO->ZZO_VALIPI								})
	TRCell():New(oSectionZZO,"ZZO_VALICM"		,"ZZO",/*Titulo*/	    	,/*Picture*/				,/*Tamanho*/,/*lPixel*/,{|| ZZO->ZZO_VALICM								})
	TRCell():New(oSectionZZO,"ZZO_ICMSRE"		,"ZZO",/*Titulo*/	    	,/*Picture*/				,/*Tamanho*/,/*lPixel*/,{|| ZZO->ZZO_ICMSRE								})
	TRCell():New(oSectionZZO,"ZZO_VALIM5"		,"ZZO",/*Titulo*/	    	,/*Picture*/				,/*Tamanho*/,/*lPixel*/,{|| ZZO->ZZO_VALIM5								})
	TRCell():New(oSectionZZO,"ZZO_VALIM6"		,"ZZO",/*Titulo*/	    	,/*Picture*/				,/*Tamanho*/,/*lPixel*/,{|| ZZO->ZZO_VALIM6								})
	TRCell():New(oSectionZZO,"ZZO_SEGURO"		,"ZZO","Frete+Seg+Desp"	   	,/*Picture*/				,/*Tamanho*/,/*lPixel*/,{|| ZZO->(ZZO_SEGURO+ZZO_VALFRE+ZZO_DESPES)								})
	//TRCell():New(oSectionZZO,"ZZO_VALFRE"		,"ZZO",/*Titulo*/	    	,/*Picture*/				,/*Tamanho*/,/*lPixel*/,{|| ZZO->ZZO_VALFRE								})
	//TRCell():New(oSectionZZO,"ZZO_DESPES"		,"ZZO",/*Titulo*/	    	,/*Picture*/				,/*Tamanho*/,/*lPixel*/,{|| ZZO->ZZO_DESPES								})
	TRCell():New(oSectionZZO,"ZZO_TOTAL"		,"ZZO",/*Titulo*/	    	,/*Picture*/				,/*Tamanho*/,/*lPixel*/,{|| ZZO->ZZO_TOTAL								})
	TRCell():New(oSectionZZO,"ZZO_VLRBRU"		,"ZZO",/*Titulo*/	    	,/*Picture*/				,/*Tamanho*/,/*lPixel*/,{|| ZZO->ZZO_VLRBRU							})
	TRCell():New(oSectionZZO,"ZZO_VLRLIQ"		,"ZZO",/*Titulo*/	    	,/*Picture*/				,/*Tamanho*/,/*lPixel*/,{|| ZZO->ZZO_VLRLIQ							})
	TRCell():New(oSectionZZO,"ZZO_VLRVER"		,"ZZO",/*Titulo*/	    	,/*Picture*/				,/*Tamanho*/,/*lPixel*/,{|| ZZO->ZZO_VLRVER				})
	
	
	oReport:Section(1):SetLineStyle(.F.)
	oReport:Section(1):Section(1):SetLineStyle(.F.)
	oReport:Section(1):Section(2):SetLineStyle(.F.)
	oReport:Section(1):Section(3):SetLineStyle(.F.)
	oReport:Section(1):Section(4):SetLineStyle(.F.)
	oReport:Section(1):Section(5):SetLineStyle(.F.)
	oReport:Section(1):Section(6):SetLineStyle(.F.)
	
	oReport:Section(1):lReadOnly := .T.
	oReport:Section(1):Section(1):lReadOnly := .T.
	oReport:Section(1):Section(2):lReadOnly := .T.
	oReport:Section(1):Section(3):lReadOnly := .T.
	oReport:Section(1):Section(4):lReadOnly := .T.
	oReport:Section(1):Section(5):lReadOnly := .T.
	oReport:Section(1):Section(6):lReadOnly := .T.
	
	
	oReport:PrintDialog()
EndIf

Return oReport


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportPrintAutor  ³Hermes Ferreira     º Data ³  23/11/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Impressão do Relatório			 			              º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Nc Games						                              º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportPrint(oReport)
Local lProvisorio:=(mv_par09==1)
Local oSecIni 	:= oReport:Section(1)
Local oSection1 := oReport:Section(1):Section(1)
Local oSection2 := oReport:Section(1):Section(2)
Local oSection3 := oReport:Section(1):Section(3)
Local oTotal	 :=oReport:Section(1):Section(4)
Local oZZLSection :=oReport:Section(1):Section(5)
Local oZZOSection :=oReport:Section(1):Section(6)
Local lFirst	:=.T.

Local nlTamFonte:= oReport:oFontBody:NHEIGHT
Local nlNewTamF	:= 10

//Local lNivel1	:= .T.

Local llPvVerba	:= .F.
Local llNCC		:= .F.
Local llVerPagar:= .F.

Local cCliente	:= ""
Local cLoja		:= ""

Local cTpVpc		:= ""

// totalizadores VPC
Local nTotRepas	:= 0
Local nTotTit 	:= 0
Local nTotSaldo	:= 0
Local nTotGeral	:= 0


// Totalizadores Verba
Local nVerTotRep:= 0
Local nVerTotAct:= 0
Local nVerPerAct:= 0
Local nVerSldAbt:= 0
Local nGeralRel	:= 0


Local cPrfVerba	:= U_MyNewSX6("NCG_PR7102", "VE" ,"C","Prefixo Verba Extra","Prefixo Verba Extra","Prefixo Verba Extra",.F. )
Local cPrfVPC	:= PadR( GetMv("NCG_000016",,"VPC"), TAMSX3( "E1_PREFIXO" )[1] )

// Query Principal
PR711Qry()

(clAlias)->(dbGoTop())
oReport:SetMeter(RecCount())
(clAlias)->(dbGoTop())


nTotGRepas	:= 0
nTotGTit 	:= 0
nTotGSaldo	:= 0


While !oReport:Cancel() .AND. (clAlias)->(!Eof())
	
	oReport:IncMeter()
	If oReport:Cancel()
		Exit
	EndIf
	
	cCliente	:= (clAlias)->CLIENTE
	cLoja		:= (clAlias)->LOJA
	nTotRepas	:= 0
	nTotTit 	:= 0
	nTotSaldo	:= 0
	
	
	Do While (clAlias)->(!Eof()) .And. (clAlias)->(CLIENTE+LOJA)==cCliente+cLoja
		
		
		If  !lFirst .And. mv_par07==1
			oReport:EndPage()
		EndIf
		lFirst:=.F.
		
		
		If MV_PAR07 <> 1 .or. oReport:nDevice == 4
			oReport:SkipLine()
			oReport:SkipLine()
			oReport:SkipLine()
			oReport:SkipLine()
		EndIf
		
		oSecIni:Init()
		oSecIni:PrintLine()
		
		
		// VPC Financeiro
		oSection1:BeginQuery()
		clAliasZZK	:= GetNextAlias()
		
		cQuery:=" SELECT ZZK_CODIGO ,ZZK_CODVPC ,ZZK_CLIENT ,ZZK_LOJA ,ZZK_VERSAO ,ZZK_DESVPC ,ZZK_DTINIC ,ZZK_DTFIM ,ZZK_PERIOD ,ZZK_TPFAT ,ZZK_PERCEN ,ZZK_VLRLIQ ,ZZK_VLRVPC ,ZZK_VLRBRU ,E1_PREFIXO ,E1_NUM ,E1_EMISSAO ,E1_VALOR ,E1_SALDO ,ZZJ_TIPO,ZZJ_DTFECH"
		cQuery+=" FROM  "+RetSqlName('ZZK')+" ZZK JOIN  "+RetSqlName('ZZJ')+" ZZJ "
		cQuery+=" ON ZZJ.ZZJ_FILIAL = ZZK.ZZK_FILIAL
		cQuery+=" AND ZZJ.ZZJ_CODIGO = ZZK.ZZK_CODIGO
		cQuery+=" AND ZZJ.ZZJ_CLIENT = ZZK.ZZK_CLIENT
		cQuery+=" AND ZZJ.ZZJ_LOJA = ZZK.ZZK_LOJA
		
		cQuery+=" AND ZZJ.ZZJ_CODIGO='"+(clAlias)->CODIGO+"'"
		
		If lProvisorio
			cQuery+=" AND ZZJ.ZZJ_TIPO =  "+___SQLGetValue("P")
		Else
			cQuery+=" AND ZZJ.ZZJ_DTFECH <>  "+___SQLGetValue(' ')
			cQuery+=" AND ZZJ.ZZJ_TIPO =  "+___SQLGetValue(IIF(MV_PAR09==1,"P","E" ))
		EndIf
		
		cQuery+=" AND ZZJ.D_E_L_E_T_= ' ' LEFT JOIN  "+RetSqlName('SE1')+" SE1 ON E1_FILIAL =  '" +xFilial('SE1')+"'  AND SE1.E1_PREFIXO =  "+___SQLGetValue(CPRFVPC)
		cQuery+=" AND SE1.E1_NUM BETWEEN  "+___SQLGetValue(' ')+" AND  "+___SQLGetValue('Z')+" AND SE1.E1_PARCELA BETWEEN  "+___SQLGetValue(' ')+" AND  "+___SQLGetValue('Z')
		cQuery+=" AND SE1.E1_TIPO BETWEEN  "+___SQLGetValue(' ')+" AND  "+___SQLGetValue('Z')
		cQuery+=" AND SE1.E1_CLIENTE = ZZK.ZZK_CLIENT AND SE1.E1_LOJA = ZZK.ZZK_LOJA
		cQuery+=" AND SE1.E1_YAPURAC = ZZK.ZZK_CODIGO AND SE1.D_E_L_E_T_= ' ' WHERE ZZK.ZZK_FILIAL =  '" +xFilial('ZZK')+"'  AND ZZK.ZZK_CLIENT =  "+___SQLGetValue(CCLIENTE)+" AND ZZK.ZZK_LOJA between  "+___SQLGetValue(CLOJA)+" and  "+___SQLGetValue(IIF(EMPTY(CLOJA),"ZZ",CLOJA))+" AND ZZK.D_E_L_E_T_= ' ' ORDER BY ZZK_CLIENT,ZZK_LOJA"
		
		__execSql(clAliasZZK,cQuery,{},.F.)
		
		
		oSection1:EndQuery()
		
		(clAliasZZK)->(dbGoTop())
		
		If (clAliasZZK)->(!Eof())
			
			If oReport:nDevice <> 4
				oReport:SkipLine()
				oReport:SkipLine()
			EndIf
			
			
			oReport:oFontBody:Bold := .T.
			oReport:oFontBody:NHEIGHT:= nlNewTamF
			
			If oReport:nDevice <> 4
				oReport:Say(oReport:Row() ,1500,"VPC com Repasse Financeiro",,,)
				oReport:SkipLine()
				
			Else
				
				oReport:SkipLine()
				oReport:PrintText("VPC com Repasse Financeiro")
				
			EndIf
			
			oReport:oFontBody:NHEIGHT := nlTamFonte
			oReport:oFontBody:Bold := .F.
			SB1->(DbSetOrder(1))
			ZZL->(DbSetOrder(1))//ZZL_FILIAL+ZZL_CODIGO+ZZL_CLIENT+ZZL_LOJA
			
			While (clAliasZZK)->(!Eof())
				
				oSection1:Init()
				oSection1:PrintLine()
				If mv_par08==1
					ZZL->(DbSeek(xFilial("ZZL")+(clAliasZZK)->(ZZK_CODIGO+ZZK_CLIENT+ZZK_LOJA)  ))
					Do While ZZL->(!Eof()) .And. ZZL->(ZZL_FILIAL+ZZL_CODIGO+ZZL_CLIENT+ZZL_LOJA) ==xFilial("ZZL")+(clAliasZZK)->(ZZK_CODIGO+ZZK_CLIENT+ZZK_LOJA)
						SB1->(MsSeek(xFilial()+ZZL->ZZL_PRODUT ))
						oZZLSection:Init()
						oZZLSection:PrintLine()
						ZZL->(DbSkip())
					EndDo
				EndIf
				
				
				nTotRepas	+= oSection1:Cell("ZZK_VLRVPC"):uprint
				nTotTit 	+= oSection1:Cell("E1_VALOR"):uprint
				nTotSaldo	+= oSection1:Cell("E1_SALDO"):uprint
				
				(clAliasZZK)->(dbSkip())
				
			EndDo
			
			oSection1:Finish()
			
		EndIf
		(clAliasZZK)->(dbCloseArea())
		
		// Verba Extra Pedido Venda
		oSection2:BeginQuery()
		
		clAliasZZN	:= GetNextAlias()
		
		cQuery:=" SELECT ZZN_CODIGO ,ZZN_CODVER ,ZZN_CLIENT ,ZZN_LOJA ,ZZN_VERSAO ,ZZN_DESVER ,ZZN_DTINIC ,ZZN_DTFIM ,ZZN_PERIOD ,ZZN_TPFAT ,ZZN_PERCEN ,ZZN_VLRLIQ ,ZZN_VLRVER ,ZZN_VLRBRU ,E1_PREFIXO ,E1_NUM ,E1_EMISSAO ,E1_VALOR ,E1_SALDO ,ZZM_TIPO,ZZM_DTFECH,ZZM_PEDIDO"
		cQuery+=" FROM  "+RetSqlName('ZZN')+" ZZN JOIN  "+RetSqlName('ZZM')+" ZZM "
		cQuery+=" ON ZZM.ZZM_FILIAL = ZZN.ZZN_FILIAL
		cQuery+=" AND ZZM.ZZM_CODIGO = ZZN.ZZN_CODIGO
		cQuery+=" AND ZZM.ZZM_CLIENT = ZZN.ZZN_CLIENT
		cQuery+=" AND ZZM.ZZM_LOJA = ZZN.ZZN_LOJA
		cQuery+=" AND ZZM.ZZM_PEDIDO<>"+___SQLGetValue(' ')
		
		If lProvisorio
			cQuery+=" AND ZZM.ZZM_TIPO =  "+___SQLGetValue("P")
		Else
			cQuery+=" AND ZZM.ZZM_DTFECH <>  "+___SQLGetValue(' ')
			cQuery+=" AND ZZM.ZZM_TIPO =  "+___SQLGetValue(IIF(MV_PAR09==1,"P","E" ))
		EndIf
		
		cQuery+=" AND ZZM.D_E_L_E_T_= ' ' LEFT JOIN  "+RetSqlName('SE1')+" SE1 ON E1_FILIAL =  '" +xFilial('SE1')+"'  AND SE1.E1_PREFIXO =  "+___SQLGetValue(CPRFVPC)
		cQuery+=" AND SE1.E1_NUM BETWEEN  "+___SQLGetValue(' ')+" AND  "+___SQLGetValue('Z')+" AND SE1.E1_PARCELA BETWEEN  "+___SQLGetValue(' ')+" AND  "+___SQLGetValue('Z')
		cQuery+=" AND SE1.E1_TIPO BETWEEN  "+___SQLGetValue(' ')+" AND  "+___SQLGetValue('Z')
		cQuery+=" AND SE1.E1_CLIENTE = ZZN.ZZN_CLIENT AND SE1.E1_LOJA = ZZN.ZZN_LOJA
		cQuery+=" AND SE1.E1_YAPURAC = ZZN.ZZN_CODIGO AND SE1.D_E_L_E_T_= ' ' "
		cQuery+=" WHERE ZZN.ZZN_FILIAL =  '" +xFilial('ZZN')+"'  AND ZZN.ZZN_CLIENT =  "+___SQLGetValue(CCLIENTE)+" AND ZZN.ZZN_LOJA between  "+___SQLGetValue(CLOJA)+" and  "+___SQLGetValue(IIF(EMPTY(CLOJA),"ZZ",CLOJA))+" AND ZZN.D_E_L_E_T_= ' ' ORDER BY ZZN_CLIENT,ZZN_LOJA"
		
		__execSql(clAliasZZN,cQuery,{},.F.)
		
		oSection2:EndQuery()
		
		(clAliasZZN)->(dbGoTop())
		
		If (clAliasZZN)->(!Eof())
			
			If oReport:nDevice <> 4
				oReport:SkipLine()
				oReport:SkipLine()
			EndIf
			
			oReport:oFontBody:Bold := .T.
			oReport:oFontBody:NHEIGHT:= nlNewTamF
			
			If oReport:nDevice <> 4
				
				oReport:Say(oReport:Row() ,1500,"Verba Extra Pedido Venda",,,)
				oReport:SkipLine()
				
			Else
				oReport:SkipLine()
				oReport:PrintText("Verba Extra Pedido Venda")
				
			EndIf
			
			oReport:oFontBody:NHEIGHT := nlTamFonte
			oReport:oFontBody:Bold := .F.
			
			ZZO->(DbSetOrder(1))//ZZO_FILIAL+ZZO_CODIGO+ZZO_CLIENT+ZZO_LOJA
			While (clAliasZZN)->(!Eof())
				
				oSection2:Init()
				oSection2:PrintLine()
				
				If mv_par08==1
					ZZO->(DbSeek(xFilial("ZZO")+(clAliasZZN)->(ZZN_CODIGO+ZZN_CLIENT+ZZN_LOJA)  ))
					Do While ZZO->(!Eof()) .And. ZZO->(ZZO_FILIAL+ZZO_CODIGO+ZZO_CLIENT+ZZO_LOJA) ==xFilial("ZZO")+(clAliasZZN)->(ZZN_CODIGO+ZZN_CLIENT+ZZN_LOJA)
						SB1->(MsSeek(xFilial()+ZZO->ZZO_PRODUT ))
						oZZOSection:Init()
						oZZOSection:PrintLine()
						ZZO->(DbSkip())
					EndDo
				EndIf
				
				nTotRepas	+= oSection2:Cell("ZZN_VLRVER"):uprint
				nTotTit 	+= oSection2:Cell("E1_VALOR"):uprint
				nTotSaldo	+= oSection2:Cell("E1_SALDO"):uprint
				(clAliasZZN)->(dbSkip())
			EndDo
			
			oSection2:Finish()
			
		EndIf
		(clAliasZZN)->(dbCloseArea())
		
		oSection3:BeginQuery()
		
		clAliasNCC	:= GetNextAlias()
		
		cQuery:=" SELECT ZZN_CODIGO ,ZZN_CODVER ,ZZN_CLIENT ,ZZN_LOJA ,ZZN_VERSAO ,ZZN_DESVER ,ZZN_DTINIC ,ZZN_DTFIM ,ZZN_PERIOD ,ZZN_TPFAT ,ZZN_PERCEN ,ZZN_VLRLIQ ,ZZN_VLRVER ,ZZN_VLRBRU ,E1_PREFIXO ,E1_NUM ,E1_EMISSAO ,E1_VALOR ,E1_SALDO ,ZZM_TIPO,ZZM_DTFECH,ZZM_META"
		cQuery+=" FROM  "+RetSqlName('ZZN')+" ZZN JOIN  "+RetSqlName('ZZM')+" ZZM "
		cQuery+=" ON ZZM.ZZM_FILIAL = ZZN.ZZN_FILIAL
		cQuery+=" AND ZZM.ZZM_CODIGO = ZZN.ZZN_CODIGO
		cQuery+=" AND ZZM.ZZM_CLIENT = ZZN.ZZN_CLIENT
		cQuery+=" AND ZZM.ZZM_LOJA = ZZN.ZZN_LOJA
		cQuery+=" AND ZZM.ZZM_PEDIDO="+___SQLGetValue(' ')
		
		If lProvisorio
			cQuery+=" AND ZZM.ZZM_TIPO =  "+___SQLGetValue("P")
		Else
			cQuery+=" AND ZZM.ZZM_DTFECH <>  "+___SQLGetValue(' ')
			cQuery+=" AND ZZM.ZZM_TIPO =  "+___SQLGetValue(IIF(MV_PAR09==1,"P","E" ))
		EndIf
		
		cQuery+=" AND ZZM.D_E_L_E_T_= ' ' LEFT JOIN  "+RetSqlName('SE1')+" SE1 ON E1_FILIAL =  '" +xFilial('SE1')+"'  AND SE1.E1_PREFIXO =  "+___SQLGetValue(CPRFVPC)
		cQuery+=" AND SE1.E1_NUM BETWEEN  "+___SQLGetValue(' ')+" AND  "+___SQLGetValue('Z')+" AND SE1.E1_PARCELA BETWEEN  "+___SQLGetValue(' ')+" AND  "+___SQLGetValue('Z')
		cQuery+=" AND SE1.E1_TIPO BETWEEN  "+___SQLGetValue(' ')+" AND  "+___SQLGetValue('Z')
		cQuery+=" AND SE1.E1_CLIENTE = ZZN.ZZN_CLIENT AND SE1.E1_LOJA = ZZN.ZZN_LOJA
		cQuery+=" AND SE1.E1_YAPURAC = ZZN.ZZN_CODIGO AND SE1.D_E_L_E_T_= ' ' "
		cQuery+=" WHERE ZZN.ZZN_FILIAL =  '" +xFilial('ZZN')+"'  AND ZZN.ZZN_CLIENT =  "+___SQLGetValue(CCLIENTE)+" AND ZZN.ZZN_LOJA between  "+___SQLGetValue(CLOJA)+" and  "+___SQLGetValue(IIF(EMPTY(CLOJA),"ZZ",CLOJA))+" AND ZZN.D_E_L_E_T_= ' ' ORDER BY ZZN_CLIENT,ZZN_LOJA"
		
		__execSql(clAliasNCC,cQuery,{},.F.)
		
		oSection3:EndQuery()
		
		(clAliasNCC)->(dbGoTop())
		
		If (clAliasNCC)->(!Eof())
			
			If oReport:nDevice <> 4
				oReport:SkipLine()
				oReport:SkipLine()
			EndIf
			
			oReport:oFontBody:Bold := .T.
			oReport:oFontBody:NHEIGHT:= nlNewTamF
			
			If oReport:nDevice <> 4
				
				oReport:Say(oReport:Row() ,1500,"Verba Extra NCC Periodica",,,)
				oReport:SkipLine()
				
			Else
				oReport:SkipLine()
				oReport:PrintText("Verba Extra NCC Periodica")
				
			EndIf
			
			oReport:oFontBody:NHEIGHT := nlTamFonte
			oReport:oFontBody:Bold := .F.
			
			ZZO->(DbSetOrder(1))//ZZO_FILIAL+ZZO_CODIGO+ZZO_CLIENT+ZZO_LOJA
			While (clAliasNCC)->(!Eof())
				oSection3:Init()
				oSection3:PrintLine()
				
				If mv_par08==1
					ZZO->(DbSeek(xFilial("ZZO")+(clAliasNCC)->(ZZN_CODIGO+ZZN_CLIENT+ZZN_LOJA)  ))
					Do While ZZO->(!Eof()) .And. ZZO->(ZZO_FILIAL+ZZO_CODIGO+ZZO_CLIENT+ZZO_LOJA) ==xFilial("ZZO")+(clAliasNCC)->(ZZN_CODIGO+ZZN_CLIENT+ZZN_LOJA)
						SB1->(MsSeek(xFilial()+ZZO->ZZO_PRODUT ))
						oZZOSection:Init()
						oZZOSection:PrintLine()
						ZZO->(DbSkip())
					EndDo
				EndIf
				
				
				nTotRepas	+= oSection3:Cell("ZZN_VLRVER"):uprint
				nTotTit 	+= oSection3:Cell("E1_VALOR"):uprint
				nTotSaldo	+= oSection3:Cell("E1_SALDO"):uprint
				(clAliasNCC)->(dbSkip())
			EndDo
			
			oSection3:Finish()
			
		EndIf
		(clAliasNCC)->(dbCloseArea())
		
		If oReport:nDevice <> 4
			oReport:SkipLine()
			oReport:SkipLine()
		EndIf
		
		oReport:oFontBody:Bold := .T.
		oReport:oFontBody:NHEIGHT:= nlNewTamF
		
		(clAlias)->(dbSkip())
		
	EndDo
	
	oReport:oFontBody:NHEIGHT := nlTamFonte
	oReport:oFontBody:Bold := .F.
	
	
	If oReport:nDevice <> 4
		oReport:Say(oReport:Row() ,1500,"Total Geral do Cliente",,,)
		oReport:SkipLine()
	Else
		oReport:SkipLine()
		oReport:PrintText("Total Geral do Cliente")
	EndIf
	
	nTotGRepas	+= nTotRepas
	nTotGTit 	+= nTotTit
	nTotGSaldo	= nTotSaldo
	
	oTotal:Init()
	oTotal:Cell("TOTREPAS")	:SetValue(  nTotRepas)
	oTotal:Cell("TOTALTIT")	:SetValue(  nTotTit  )
	oTotal:Cell("SALDOABER")	:SetValue(  nTotSaldo)
	oTotal:PrintLine()
EndDo


If  mv_par07==1
	oReport:EndPage()
EndIf

oReport:oFontBody:Bold := .T.
oReport:oFontBody:NHEIGHT:= nlNewTamF

If oReport:nDevice <> 4
	oReport:SkipLine()
	oReport:SkipLine()
	oReport:SkipLine()
	oReport:Say(oReport:Row() ,1500,"Total Geral Relatório",,,)
	oReport:SkipLine()
	oReport:SkipLine()
Else
	oReport:SkipLine()
	oReport:SkipLine()
	oReport:SkipLine()
	oReport:PrintText("Total Geral Relatório")
EndIf


oTotal:Init()
oTotal:Cell("TOTREPAS")	:SetValue(  nTotGRepas)
oTotal:Cell("TOTALTIT")	:SetValue(  nTotGTit  )
oTotal:Cell("SALDOABER")	:SetValue(  nTotGSaldo)
oTotal:PrintLine()


oReport:oFontBody:NHEIGHT := nlTamFonte
oReport:oFontBody:Bold := .F.

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR711  ºAutor  ³Microsiga           º Data ³  01/11/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PR711Qry()
Local cQuery := ""
Local lProvisorio:=(mv_par09==1)

cQuery :="Select Distinct Cliente,Loja,Nome,MesPgto,Tipo,Codigo From ("+CRLF
cQuery +=" Select Distinct ZZJ_CLIENT Cliente,ZZJ_LOJA Loja,ZZJ_DESCLI Nome,ZZJ_MESPGT MesPgto,ZZJ_TIPO Tipo,ZZJ_CODIGO Codigo"+CRLF
cQuery +=" From "+RetSqlName("ZZJ")+" ZZJ "+CRLF
cQuery +=" Where ZZJ.ZZJ_FILIAL='"+xFilial("ZZJ")+"'"+CRLF
cQuery +=" And ZZJ.ZZJ_DTAPUR Between '"+Dtos(mv_par01)+"' And '"+Dtos(mv_par02)+"'"+CRLF
cQuery +=" And ZZJ.ZZJ_CLIENT Between '"+mv_par03+"' And '"+mv_par05+"'"+CRLF
cQuery +=" And ZZJ.ZZJ_LOJA   Between '"+mv_par04+"' And '"+mv_par06+"'"+CRLF
cQuery +=" And ZZJ.ZZJ_TIPO='"+IIf(lProvisorio,"P","E" )+"'"
cQuery +=" And ZZJ.D_E_L_E_T_=' '"+CRLF


cQuery +=" Union "+CRLF
cQuery +=" Select Distinct ZZM_CLIENT Cliente,ZZM_LOJA Loja,ZZM_DESCLI Nome,ZZM_MESPGT MesPgto,ZZM_TIPO Tipo,ZZM_CODIGO Codigo"+CRLF
cQuery +=" From "+RetSqlName("ZZM")+" ZZM "+CRLF
cQuery +=" Where ZZM.ZZM_FILIAL='"+xFilial("ZZM")+"'"+CRLF
cQuery +=" And ZZM.ZZM_DTAPUR Between '"+Dtos(mv_par01)+"' And '"+Dtos(mv_par02)+"'"+CRLF
cQuery +=" And ZZM.ZZM_CLIENT Between '"+mv_par03+"' And '"+mv_par05+"'"+CRLF
cQuery +=" And ZZM.ZZM_LOJA   Between '"+mv_par04+"' And '"+mv_par06+"'"+CRLF
cQuery +=" And ZZM.ZZM_TIPO='"+IIf(lProvisorio,"P","E" )+"'"
cQuery +=" And ZZM.D_E_L_E_T_=' '"
cQuery +=")"
cQuery +="Order By Cliente,Loja,MesPgto"
DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),clAlias, .F., .F.)


Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCGPR711  ºAutor  ³Microsiga           º Data ³  01/12/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function NCRL1SX1( clPerg )
Local alAreaAtu	:= GetArea()
Local alAux		:= {}

aAdd( alAux, {	"01",;		  					// 01-Ordem da Pergunta (2)
"Da Data Apuracao",;					  					// 02-Descrição em Portugues (30)
"Da Data Apuracao",;				  						// 03-Descrição em Espanhol (30)
"Da Data Apuracao",;				  						// 04-Descrição em Ingles (30)
"mv_ch1",;							  			// 05-Nome da Variável (6)
"D",;											// 06-Tipo da Variável (1)
8,;												// 07-Tamanho da Variável (2)
0,;												// 08-Casas Decimais da Variável (1)
0,;												// 09-Elemento pré-selecionado, quando Choice (1)
"G",;											// 10-Tipo de Exibição (C=Choice,G=Get,K=CheckBox)(1)
"",;											// 11-Expressão de Validação da Variável (60)
"",;											// 12-Consulta Padrão para a Variável (6)
"",;											// 13-Identifica de a versão é Pyme (1)
"",;											// 14-Grupo de Configuração do Tamanho (3)
"@!",;											// 15-Picture para a variável (40)
"",;											// 16-Identificador de Filtro da variável (6)
"",;											// 17-Nome do Help para o grupo de perguntas (14)
"MV_PAR01",;									// 18-Nome da variável (15)
"",;											// 19-Conteúdo da Variável (15)
{ ;
"",;											// 20,01-1a. Definição em Portugues (15)
"",;											// 20,02-1a. Definição em Espanhol (15)
"",;											// 20,03-1a. Definição em Ingles (15)
"",;											// 20,04-2a. Definição em Portugues (15)
"",;											// 20,05-2a. Definição em Espanhol (15)
"",;											// 20,06-2a. Definição em Ingles (15)
"",;											// 20,07-3a. Definição em Portugues (15)
"",;											// 20,08-3a. Definição em Espanhol (15)
"",;											// 20,09-3a. Definição em Ingles (15)
"",;											// 20,10-4a. Definição em Portugues (15)
"",;											// 20,11-4a. Definição em Espanhol (15)
"",;											// 20,12-4a. Definição em Ingles (15)
"",;											// 20,13-5a. Definição em Portugues (15)
"",;											// 20,14-5a. Definição em Espanhol (15)
"" },;									   		// 20,15-5a. Definição em Ingles (15)
{ { ;
"Da Data Inicial   						 ",;
"                                        ",;	// 21,01-Array com os textos de help em Portugues
"										 " ;
}, { ;
"Da Data Inicial   						 ",;
"                                        ",;	// 21,02-Array com os textos de help em Espanhol
"										 " ;
}, { ;
"Da Data Inicial   						 ",;
"                                        ",;	// 21,02-Array com os textos de help em Ingles
"										 " ;
} } } )


aAdd( alAux, {	"02",;		  					// 01-Ordem da Pergunta (2)
"Ate Data Apuracao",;					  				// 02-Descrição em Portugues (30)
"Ate Data Apuracao",;				  					// 03-Descrição em Espanhol (30)
"Ate Data Apuracao",;				  					// 04-Descrição em Ingles (30)
"mv_ch2",;							  			// 05-Nome da Variável (6)
"D",;											// 06-Tipo da Variável (1)
8,;												// 07-Tamanho da Variável (2)
0,;												// 08-Casas Decimais da Variável (1)
0,;												// 09-Elemento pré-selecionado, quando Choice (1)
"G",;											// 10-Tipo de Exibição (C=Choice,G=Get,K=CheckBox)(1)
"",;											// 11-Expressão de Validação da Variável (60)
"",;											// 12-Consulta Padrão para a Variável (6)
"",;											// 13-Identifica de a versão é Pyme (1)
"",;											// 14-Grupo de Configuração do Tamanho (3)
"@!",;											// 15-Picture para a variável (40)
"",;											// 16-Identificador de Filtro da variável (6)
"",;											// 17-Nome do Help para o grupo de perguntas (14)
"MV_PAR02",;									// 18-Nome da variável (15)
"",;											// 19-Conteúdo da Variável (15)
{ ;
"",;											// 20,01-1a. Definição em Portugues (15)
"",;											// 20,02-1a. Definição em Espanhol (15)
"",;											// 20,03-1a. Definição em Ingles (15)
"",;											// 20,04-2a. Definição em Portugues (15)
"",;											// 20,05-2a. Definição em Espanhol (15)
"",;											// 20,06-2a. Definição em Ingles (15)
"",;											// 20,07-3a. Definição em Portugues (15)
"",;											// 20,08-3a. Definição em Espanhol (15)
"",;											// 20,09-3a. Definição em Ingles (15)
"",;											// 20,10-4a. Definição em Portugues (15)
"",;											// 20,11-4a. Definição em Espanhol (15)
"",;											// 20,12-4a. Definição em Ingles (15)
"",;											// 20,13-5a. Definição em Portugues (15)
"",;											// 20,14-5a. Definição em Espanhol (15)
"" },;									   		// 20,15-5a. Definição em Ingles (15)
{ { ;
"Ate Data Inicial   					 ",;
"                                        ",;	// 21,01-Array com os textos de help em Portugues
"										 " ;
}, { ;
"Ate Data Inicial   					 ",;
"                                        ",;	// 21,02-Array com os textos de help em Espanhol
"										 " ;
}, { ;
"Ate Data Inicial   					 ",;
"                                        ",;	// 21,02-Array com os textos de help em Ingles
"										 " ;
} } } )


aAdd( alAux, {	"03",;		  					// 01-Ordem da Pergunta (2)
"Do Cliente",;					  				// 02-Descrição em Portugues (30)
"Do Cliente",;				  					// 03-Descrição em Espanhol (30)
"Do Cliente",;				  					// 04-Descrição em Ingles (30)
"mv_ch3",;							  			// 05-Nome da Variável (6)
"C",;											// 06-Tipo da Variável (1)
TamSx3("A1_COD")[1],;							// 07-Tamanho da Variável (2)
TamSx3("A1_COD")[2],;							// 08-Casas Decimais da Variável (1)
0,;												// 09-Elemento pré-selecionado, quando Choice (1)
"G",;											// 10-Tipo de Exibição (C=Choice,G=Get,K=CheckBox)(1)
"",;											// 11-Expressão de Validação da Variável (60)
"SA1",;											// 12-Consulta Padrão para a Variável (6)
"",;											// 13-Identifica de a versão é Pyme (1)
"",;											// 14-Grupo de Configuração do Tamanho (3)
"@!",;											// 15-Picture para a variável (40)
"",;											// 16-Identificador de Filtro da variável (6)
"",;											// 17-Nome do Help para o grupo de perguntas (14)
"MV_PAR03",;									// 18-Nome da variável (15)
"",;											// 19-Conteúdo da Variável (15)
{ ;
"",;											// 20,01-1a. Definição em Portugues (15)
"",;											// 20,02-1a. Definição em Espanhol (15)
"",;											// 20,03-1a. Definição em Ingles (15)
"",;											// 20,04-2a. Definição em Portugues (15)
"",;											// 20,05-2a. Definição em Espanhol (15)
"",;											// 20,06-2a. Definição em Ingles (15)
"",;											// 20,07-3a. Definição em Portugues (15)
"",;											// 20,08-3a. Definição em Espanhol (15)
"",;											// 20,09-3a. Definição em Ingles (15)
"",;											// 20,10-4a. Definição em Portugues (15)
"",;											// 20,11-4a. Definição em Espanhol (15)
"",;											// 20,12-4a. Definição em Ingles (15)
"",;											// 20,13-5a. Definição em Portugues (15)
"",;											// 20,14-5a. Definição em Espanhol (15)
"" },;									   		// 20,15-5a. Definição em Ingles (15)
{ { ;
"Informe o código inicial do cliente     ",;
"                                        ",;	// 21,01-Array com os textos de help em Portugues
"										 " ;
}, { ;
"Informe o código inicial do cliente     ",;
"                                        ",;	// 21,02-Array com os textos de help em Espanhol
"										 " ;
}, { ;
"Informe o código inicial do cliente     ",;
"                                        ",;	// 21,02-Array com os textos de help em Ingles
"										 " ;
} } } )

aAdd( alAux, {	"04",;		  									// 01-Ordem da Pergunta (2)
"Da Loja",;						  				// 02-Descrição em Portugues (30)
"Da Loja",;				  						// 03-Descrição em Espanhol (30)
"Da Loja",;				  						// 04-Descrição em Ingles (30)
"mv_ch4",;							  			// 05-Nome da Variável (6)
"C",;											// 06-Tipo da Variável (1)
TamSx3("A1_LOJA")[1],;							// 07-Tamanho da Variável (2)
TamSx3("A1_LOJA")[2],;							// 08-Casas Decimais da Variável (1)
0,;												// 09-Elemento pré-selecionado, quando Choice (1)
"G",;											// 10-Tipo de Exibição (C=Choice,G=Get,K=CheckBox)(1)
"",;											// 11-Expressão de Validação da Variável (60)
"",;											// 12-Consulta Padrão para a Variável (6)
"",;											// 13-Identifica de a versão é Pyme (1)
"",;											// 14-Grupo de Configuração do Tamanho (3)
"@!",;											// 15-Picture para a variável (40)
"",;											// 16-Identificador de Filtro da variável (6)
"",;											// 17-Nome do Help para o grupo de perguntas (14)
"MV_PAR04",;									// 18-Nome da variável (15)
"",;											// 19-Conteúdo da Variável (15)
{ ;
"",;											// 20,01-1a. Definição em Portugues (15)
"",;											// 20,02-1a. Definição em Espanhol (15)
"",;											// 20,03-1a. Definição em Ingles (15)
"",;											// 20,04-2a. Definição em Portugues (15)
"",;											// 20,05-2a. Definição em Espanhol (15)
"",;											// 20,06-2a. Definição em Ingles (15)
"",;											// 20,07-3a. Definição em Portugues (15)
"",;											// 20,08-3a. Definição em Espanhol (15)
"",;											// 20,09-3a. Definição em Ingles (15)
"",;											// 20,10-4a. Definição em Portugues (15)
"",;											// 20,11-4a. Definição em Espanhol (15)
"",;											// 20,12-4a. Definição em Ingles (15)
"",;											// 20,13-5a. Definição em Portugues (15)
"",;											// 20,14-5a. Definição em Espanhol (15)
"" },;									   		// 20,15-5a. Definição em Ingles (15)
{ { ;
"Informe o código inicial da loja do clie",;
"nte                                     ",;	// 21,01-Array com os textos de help em Portugues
"										 " ;
}, { ;
"Informe o código inicial da loja do clie",;
"nte                                     ",;	// 21,02-Array com os textos de help em Espanhol
"										 " ;
}, { ;
"Informe o código inicial da loja do clie",;
"nte                                     ",;	// 21,02-Array com os textos de help em Ingles
"										 " ;
} } } )

aAdd( alAux, {	"05",;		  									// 01-Ordem da Pergunta (2)
"Até o Cliente",;					  			// 02-Descrição em Portugues (30)
"Até o Cliente",;				  					// 03-Descrição em Espanhol (30)
"Até o Cliente",;				  					// 04-Descrição em Ingles (30)
"mv_ch5",;							  			// 05-Nome da Variável (6)
"C",;											// 06-Tipo da Variável (1)
TamSx3("A1_COD")[1],;							// 07-Tamanho da Variável (2)
TamSx3("A1_COD")[2],;							// 08-Casas Decimais da Variável (1)
0,;												// 09-Elemento pré-selecionado, quando Choice (1)
"G",;											// 10-Tipo de Exibição (C=Choice,G=Get,K=CheckBox)(1)
"",;		  									// 11-Expressão de Validação da Variável (60)
"SA1",;											// 12-Consulta Padrão para a Variável (6)
"",;											// 13-Identifica de a versão é Pyme (1)
"",;											// 14-Grupo de Configuração do Tamanho (3)
"@!",;											// 15-Picture para a variável (40)
"",;											// 16-Identificador de Filtro da variável (6)
"",;											// 17-Nome do Help para o grupo de perguntas (14)
"MV_PAR05",;									// 18-Nome da variável (15)
"",;											// 19-Conteúdo da Variável (15)
{ ;
"",;											// 20,01-1a. Definição em Portugues (15)
"",;											// 20,02-1a. Definição em Espanhol (15)
"",;											// 20,03-1a. Definição em Ingles (15)
"",;											// 20,04-2a. Definição em Portugues (15)
"",;											// 20,05-2a. Definição em Espanhol (15)
"",;											// 20,06-2a. Definição em Ingles (15)
"",;											// 20,07-3a. Definição em Portugues (15)
"",;											// 20,08-3a. Definição em Espanhol (15)
"",;											// 20,09-3a. Definição em Ingles (15)
"",;											// 20,10-4a. Definição em Portugues (15)
"",;											// 20,11-4a. Definição em Espanhol (15)
"",;											// 20,12-4a. Definição em Ingles (15)
"",;											// 20,13-5a. Definição em Portugues (15)
"",;											// 20,14-5a. Definição em Espanhol (15)
"" },;									   		// 20,15-5a. Definição em Ingles (15)
{ { ;
"Informe o código final do cliente       ",;
"                                        ",;	// 21,01-Array com os textos de help em Portugues
"										 " ;
}, { ;
"Informe o código final do cliente       ",;
"                                        ",;	// 21,02-Array com os textos de help em Espanhol
"										 " ;
}, { ;
"Informe o código final do cliente       ",;
"                                        ",;	// 21,02-Array com os textos de help em Ingles
"										 " ;
} } } )

aAdd( alAux, {	"06",;		  									// 01-Ordem da Pergunta (2)
"Ate a Loja",;						  				// 02-Descrição em Portugues (30)
"Ate a Loja",;				  						// 03-Descrição em Espanhol (30)
"Ate a Loja",;				  						// 04-Descrição em Ingles (30)
"mv_ch6",;							  			// 05-Nome da Variável (6)
"C",;											// 06-Tipo da Variável (1)
TamSx3("A1_LOJA")[1],;							// 07-Tamanho da Variável (2)
TamSx3("A1_LOJA")[2],;							// 08-Casas Decimais da Variável (1)
0,;												// 09-Elemento pré-selecionado, quando Choice (1)
"G",;											// 10-Tipo de Exibição (C=Choice,G=Get,K=CheckBox)(1)
"",;											// 11-Expressão de Validação da Variável (60)
"",;											// 12-Consulta Padrão para a Variável (6)
"",;											// 13-Identifica de a versão é Pyme (1)
"",;											// 14-Grupo de Configuração do Tamanho (3)
"@!",;											// 15-Picture para a variável (40)
"",;											// 16-Identificador de Filtro da variável (6)
"",;											// 17-Nome do Help para o grupo de perguntas (14)
"MV_PAR06",;									// 18-Nome da variável (15)
"",;											// 19-Conteúdo da Variável (15)
{ ;
"",;											// 20,01-1a. Definição em Portugues (15)
"",;											// 20,02-1a. Definição em Espanhol (15)
"",;											// 20,03-1a. Definição em Ingles (15)
"",;											// 20,04-2a. Definição em Portugues (15)
"",;											// 20,05-2a. Definição em Espanhol (15)
"",;											// 20,06-2a. Definição em Ingles (15)
"",;											// 20,07-3a. Definição em Portugues (15)
"",;											// 20,08-3a. Definição em Espanhol (15)
"",;											// 20,09-3a. Definição em Ingles (15)
"",;											// 20,10-4a. Definição em Portugues (15)
"",;											// 20,11-4a. Definição em Espanhol (15)
"",;											// 20,12-4a. Definição em Ingles (15)
"",;											// 20,13-5a. Definição em Portugues (15)
"",;											// 20,14-5a. Definição em Espanhol (15)
"" },;									   		// 20,15-5a. Definição em Ingles (15)
{ { ;
"Informe o código final da loja do client",;
"e                                       ",;	// 21,01-Array com os textos de help em Portugues
"										 " ;
}, { ;
"Informe o código final da loja do client",;
"e                                       ",;	// 21,02-Array com os textos de help em Espanhol
"										 " ;
}, { ;
"Informe o código final da loja do client",;
"e                                       ",;	// 21,02-Array com os textos de help em Ingles
"										 " ;
} } } )


aAdd( alAux, {	"07",;							// 01-Ordem da Pergunta (2)
"Quebra Página por Cliente",;			  		// 02-Descrição em Portugues (30)
"Quebra Página por Cliente",;	  				// 03-Descrição em Espanhol (30)
"Quebra Página por Cliente",;	  				// 04-Descrição em Ingles (30)
"mv_ch7",;							  			// 05-Nome da Variável (6)
"N",;											// 06-Tipo da Variável (1)
1,;												// 07-Tamanho da Variável (2)
0,;												// 08-Casas Decimais da Variável (1)
0,;												// 09-Elemento pré-selecionado, quando Choice (1)
"C",;											// 10-Tipo de Exibição (C=Choice,G=Get,K=CheckBox)(1)
"",;											// 11-Expressão de Validação da Variável (60)
"",;											// 12-Consulta Padrão para a Variável (6)
"",;											// 13-Identifica de a versão é Pyme (1)
"",;											// 14-Grupo de Configuração do Tamanho (3)
"@!",;											// 15-Picture para a variável (40)
"",;											// 16-Identificador de Filtro da variável (6)
"",;											// 17-Nome do Help para o grupo de perguntas (14)
"MV_PAR07",;									// 18-Nome da variável (15)
"",;											// 19-Conteúdo da Variável (15)
{ ;
"Sim",;											// 20,01-1a. Definição em Portugues (15)
"Sim",;											// 20,02-1a. Definição em Espanhol (15)
"Sim",;											// 20,03-1a. Definição em Ingles (15)
"Não",;											// 20,04-2a. Definição em Portugues (15)
"Não",;											// 20,05-2a. Definição em Espanhol (15)
"Não",;											// 20,06-2a. Definição em Ingles (15)
"",;											// 20,07-3a. Definição em Portugues (15)
"",;											// 20,08-3a. Definição em Espanhol (15)
"",;											// 20,09-3a. Definição em Ingles (15)
"",;											// 20,10-4a. Definição em Portugues (15)
"",;											// 20,11-4a. Definição em Espanhol (15)
"",;											// 20,12-4a. Definição em Ingles (15)
"",;											// 20,13-5a. Definição em Portugues (15)
"",;											// 20,14-5a. Definição em Espanhol (15)
"" },;									   		// 20,15-5a. Definição em Ingles (15)
{ { ;
"Quebra pagina por cliente + Loja		 ",;
"                                        ",;	// 21,01-Array com os textos de help em Portugues
"										 " ;
}, { ;
"Quebra pagina por cliente + Loja		 ",;
"                                        ",;	// 21,02-Array com os textos de help em Espanhol
"										 " ;
}, { ;
"Quebra pagina por cliente + Loja		 ",;
"                                        ",;	// 21,02-Array com os textos de help em Ingles
"										 " ;
} } } )



aAdd( alAux, {	"08",;							// 01-Ordem da Pergunta (2)
"Analitico/Sintetico",;	 				  		// 02-Descrição em Portugues (30)
"Analitico/Sintetico",;	 	 					// 03-Descrição em Espanhol (30)
"Analitico/Sintetico",;	 	 					// 04-Descrição em Ingles (30)
"mv_ch8",;							  			// 05-Nome da Variável (6)
"N",;											// 06-Tipo da Variável (1)
1,;												// 07-Tamanho da Variável (2)
0,;												// 08-Casas Decimais da Variável (1)
0,;												// 09-Elemento pré-selecionado, quando Choice (1)
"C",;											// 10-Tipo de Exibição (C=Choice,G=Get,K=CheckBox)(1)
"",;											// 11-Expressão de Validação da Variável (60)
"",;											// 12-Consulta Padrão para a Variável (6)
"",;											// 13-Identifica de a versão é Pyme (1)
"",;											// 14-Grupo de Configuração do Tamanho (3)
"@!",;											// 15-Picture para a variável (40)
"",;											// 16-Identificador de Filtro da variável (6)
"",;											// 17-Nome do Help para o grupo de perguntas (14)
"MV_PAR08",;									// 18-Nome da variável (15)
"",;											// 19-Conteúdo da Variável (15)
{ ;
"Analitico",;									// 20,01-1a. Definição em Portugues (15)
"Analitico",;									// 20,02-1a. Definição em Espanhol (15)
"Analitico",;									// 20,03-1a. Definição em Ingles (15)
"Sintetico",;									// 20,04-2a. Definição em Portugues (15)
"Sintetico",;									// 20,05-2a. Definição em Espanhol (15)
"Sintetico",;									// 20,06-2a. Definição em Ingles (15)
"",;											// 20,07-3a. Definição em Portugues (15)
"",;											// 20,08-3a. Definição em Espanhol (15)
"",;											// 20,09-3a. Definição em Ingles (15)
"",;											// 20,10-4a. Definição em Portugues (15)
"",;											// 20,11-4a. Definição em Espanhol (15)
"",;											// 20,12-4a. Definição em Ingles (15)
"",;											// 20,13-5a. Definição em Portugues (15)
"",;											// 20,14-5a. Definição em Espanhol (15)
"" },;									   		// 20,15-5a. Definição em Ingles (15)
{ { ;
"Analitico ou sintetico. Quando Escolhido",;
"analitico, será apresentado as notas de ",;	// 21,01-Array com os textos de help em Portugues
"entrada e saida usadas na apuração		 " ;
}, { ;
"Analitico ou sintetico. Quando Escolhido",;
"analitico, será apresentado as notas de ",;	// 21,02-Array com os textos de help em Espanhol
"entrada e saida usadas na apuração		 " ;
}, { ;
"Analitico ou sintetico. Quando Escolhido",;
"analitico, será apresentado as notas de ",;	// 21,02-Array com os textos de help em Ingles
"entrada e saida usadas na apuração		 " ;
} } } )


U_MyNewX1( { clPerg, aClone( alAux ) } )

PutSx1(clPerg,"09","Provisorio?","Provisorio?","Provisorio?","mv_ch9","N",01,0,1,"C","","","","","mv_par09","Sim","Sim","Sim","","Nao","Nao","Nao","","","","","","","","","",{},{},{})

RestArea( alAreaAtu )

Return()
