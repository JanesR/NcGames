#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'TopConn.ch'
#INCLUDE "RPTDEF.CH"
#INCLUDE "Font.ch"
#INCLUDE "COLORS.CH"
#INCLUDE "REPORT.CH"   

#define clr Chr(13)+Chr(10)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGRL101  บAutor  ณHermes Ferreira     บ Data ณ  23/11/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRelatorio Gerencial VPC e Verba, baseado na apura็ใo        บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Nc Games						                              บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
IF(LEN(GetSXENum("SC5","C5_NUMPV"))==6,GetSXENum("SC5","C5_NUMPV"),"C"+GetSXENum("SC5","C5_NUMPV")                              */

User Function NCGRL101()

	Local oReport	:= Nil

	Private clAlias		:= GetNextAlias()
	Private CLALIASS1	:= ""
	Private AliasVERFN	:= ""
	Private clAliasSC5	:= ""
	Private clAliasVPV	:= ""
	Private clAliasNotas:= ""

	//ErrorBlock( SysErrorBlock( { | e | ErrorDialog( e ) } ) )
	
		
	If FindFunction("TRepInUse")// .And. TRepInUse()

		oReport:= ReportDef()
		If Valtype(oReport) <> "U"
			oReport:PrintDialog()
		EndIf
		
	EndIf

	IIF(Select((clAlias)) > 0,(clAlias)->(dbCloseArea()),.f.  ) 
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณReportDef บAutor  ณHermes Ferreira     บ Data ณ  23/11/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณMonta a estrutura do relatorio em TReport                   บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Nc Games						                              บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ReportDef()

	Local cTitulo	:= "Relat๓rio Gerencial VPC Verba"
	Local cDescricao:= "Este programa tem como objetivo imprimir relat๓rio de acordo com os parametros informados pelo usuario."
	Local clPerg	:= Padr("NCGRL101_",Len(SX1->X1_GRUPO))
    Local oReport	:= Nil
    
    Local oBreak	:= Nil
    Local oTotal1	:= nil
    Local oTotal2	:= nil
    Local oTotal3	:= nil
    Local oNotas	:= nil
    
    
    Private lArchExcel  := .F.
    
	//ErrorBlock( SysErrorBlock( { | e | ErrorDialog( e ) } ) )
	
	NCRL1SX1(clPerg)

	If Pergunte(clPerg, .T. )
   			
   		If MV_PAR08 == 2
   		
			oReport := TReport():New("NCGRL101",cTitulo,clPerg,{|oReport| ReportPrint(oReport)},cDescricao)
		   	oReport:SetLandscape(.T.)//Impressao Paissagem
		   	oReport:oPage:nPaperSize:= 9
		   	oReport:DisableOrientation()//Desabilita a mudanca de impressao
			oReport:nDevice := 4
			
			oSection := TRSection():NeW(oReport,"",(clAlias),,/*lLoadCells*/,/*lLoadOrder*/,/*uTotalText*/,/*lTotalInLine*/,/*lHeaderPage*/,.T./*lHeaderBreak*/,/*lPageBreak*/,/*lLineBreak*/,/*nLeftMargin*/,/*lLineStyle*/,/*nColSpace*/,/*lAutoSize*/,/*cCharSeparator*/,/*nLinesBefore*/,/*nCols*/,/*nClrBack*/,/*nClrFore*/,/*nPercentage*/)
			oSection:SetHeaderSection():=.F.
			TRCell():New(oSection,"P01_CODCLI"		,(clAlias),/*Titulo*/			,/*Picture*/					,/*Tamanho*/,/*lPixel*/,{|| (clAlias)->P01_CODCLI		})
			TRCell():New(oSection,"P01_LOJCLI"		,(clAlias),/*Titulo*/			,/*Picture*/					,/*Tamanho*/,/*lPixel*/,{|| (clAlias)->P01_LOJCLI		})
			TRCell():New(oSection,"A1_NOME"			,(clAlias),/*Titulo*/			,/*Picture*/					,/*Tamanho*/,/*lPixel*/,{|| (clAlias)->A1_NOME			})

			// SECTION 1
			oSection1 := TRSection():NeW(oSection,"VPC com repasse Financeiro",(clAliasS1),,/*lLoadCells*/,/*lLoadOrder*/,"Sub-Total VPC com repasse Financeiro"/*uTotalText*/,/*lTotalInLine*/,/*lHeaderPage*/,.T./*lHeaderBreak*/,/*lPageBreak*/,/*lLineBreak*/,/*nLeftMargin*/,/*lLineStyle*/,/*nColSpace*/,/*lAutoSize*/,/*cCharSeparator*/,/*nLinesBefore*/,/*nCols*/,/*nClrBack*/,/*nClrFore*/,/*nPercentage*/)
			oSection1:SetHeaderSection():=.F.
			oBreak1:= TRBreak():New( oSection1, {|| (clAliasS1)->(A1_COD+A1_LOJA)}, "Sub-Total VPC com repasse Financeiro") 

			//TRCell():New(oSection1,"P01_CODIGO"		,(clAliasS1),"Contrato"			,/*Picture*/					,/*Tamanho*/,/*lPixel*/,{|| (clAliasS1)->P01_CODIGO									},/*cAlign*/,/*lLineBreak*/,/*cHeaderAlign*/,/*lCellBreak*/,/*nColSpace*/,/*lAutoSize*/,/*nClrBack*/,/*nClrFore*/,/*lBold*/)
			
			
			TRCell():New(oSection1,"P01_CODIGO"		,(clAliasS1),"Contrato VPC"		,/*Picture*/					,/*Tamanho*/,/*lPixel*/,{|| (clAliasS1)->P01_CODIGO									})
			TRCell():New(oSection1,"P01_VERSAO"		,(clAliasS1),/*Titulo*/			,/*Picture*/					,/*Tamanho*/,/*lPixel*/,{|| (clAliasS1)->P01_VERSAO									})
			TRCell():New(oSection1,"P01_DTVINI"		,(clAliasS1),/*Titulo*/			,/*Picture*/					,/*Tamanho*/,/*lPixel*/,{|| (clAliasS1)->P01_DTVINI									})
			TRCell():New(oSection1,"P01_DTVFIM"		,(clAliasS1),/*Titulo*/			,/*Picture*/					,/*Tamanho*/,/*lPixel*/,{|| (clAliasS1)->P01_DTVFIM									})
			TRCell():New(oSection1,"P01_TPVPC"		,(clAliasS1),/*Titulo*/			,/*Picture*/					,/*Tamanho*/,/*lPixel*/,{|| X3COMBO("P01_TPVPC" ,Alltrim((clAliasS1)->P01_TPVPC))		})
			TRCell():New(oSection1,"P01_STATUS"		,(clAliasS1),					,/*Picture*/					,			,/*lPixel*/,{|| X3COMBO("P01_STATUS",Alltrim((clAliasS1)->P01_STATUS))		})
			TRCell():New(oSection1,"P01_REPASS"		,(clAliasS1),					,/*Picture*/					,12			,/*lPixel*/,{|| X3COMBO("P01_REPASS",Alltrim((clAliasS1)->P01_REPASS)) 	})
			TRCell():New(oSection1,"P01_TPFAT"		,(clAliasS1),					,/*Picture*/					,			,/*lPixel*/,{|| X3COMBO("P01_TPFAT" ,Alltrim((clAliasS1)->P01_TPFAT))		})
			TRCell():New(oSection1,"P01_TOTPER"		,(clAliasS1),/*Titulo*/			,/*Picture*/					,/*Tamanho*/,/*lPixel*/,{|| (clAliasS1)->P01_TOTPER									})
			TRCell():New(oSection1,"P04_CODIGO"		,(clAliasS1),/*Titulo*/			,/*Picture*/					,/*Tamanho*/,/*lPixel*/,{|| (clAliasS1)->P04_CODIGO									})
			TRCell():New(oSection1,"P04_DTINI"		,(clAliasS1),/*Titulo*/			,/*Picture*/					,/*Tamanho*/,/*lPixel*/,{|| (clAliasS1)->P04_DTINI										})
			TRCell():New(oSection1,"P04_DTFIM"		,(clAliasS1),/*Titulo*/			,/*Picture*/					,/*Tamanho*/,/*lPixel*/,{|| (clAliasS1)->P04_DTFIM										})
			TRCell():New(oSection1,"P04_FECHAM"		,(clAliasS1),					,								,/*Tamanho*/,/*lPixel*/,{|| (clAliasS1)->P04_FECHAM									})			
			TRCell():New(oSection1,"FATREALIZADO"	,(clAliasS1),"Fat. Realizado"	,PesqPict("P04", "P04_FATLIQ")	,/*Tamanho*/,/*lPixel*/,{|| (clAliasS1)->FATREALIZADO									})
			TRCell():New(oSection1,"A1_COD"			,(clAliasS1),/*Titulo*/			,/*Picture*/					,/*Tamanho*/,/*lPixel*/,{|| (clAliasS1)->A1_COD										})
			TRCell():New(oSection1,"A1_LOJA"		,(clAliasS1),/*Titulo*/			,/*Picture*/					,/*Tamanho*/,/*lPixel*/,{|| (clAliasS1)->A1_LOJA										})
			TRCell():New(oSection1,"A1_NREDUZ"		,(clAliasS1),/*Titulo*/			,/*Picture*/					,/*Tamanho*/,/*lPixel*/,{|| (clAliasS1)->A1_NREDUZ										})
			TRCell():New(oSection1,"P04_TOTAL1"		,(clAliasS1),"Repasse"			,PesqPict("P04", "P04_TOTAL1")	,/*Tamanho*/,/*lPixel*/,{|| (clAliasS1)->P04_TOTAL1									})
			TRCell():New(oSection1,"E1_PREFIXO"		,(clAliasS1),/*Titulo*/			,/*Picture*/					,/*Tamanho*/,/*lPixel*/,{|| (clAliasS1)->E1_PREFIXO									})
			TRCell():New(oSection1,"E1_NUM"			,(clAliasS1),/*Titulo*/			,/*Picture*/					,/*Tamanho*/,/*lPixel*/,{|| (clAliasS1)->E1_NUM 										})
			TRCell():New(oSection1,"E1_EMISSAO"		,(clAliasS1),/*Titulo*/			,/*Picture*/					,/*Tamanho*/,/*lPixel*/,{|| (clAliasS1)->E1_EMISSAO									})		
			TRCell():New(oSection1,"E1_VALOR"		,(clAliasS1),/*Titulo*/			,/*Picture*/					,/*Tamanho*/,/*lPixel*/,{|| (clAliasS1)->E1_VALOR										})		
			TRCell():New(oSection1,"E1_SALDO"		,(clAliasS1),/*Titulo*/			,/*Picture*/					,/*Tamanho*/,/*lPixel*/,{|| (clAliasS1)->E1_SALDO										})		

			oTotal1:= TRFunction():New(oSection1:Cell("P04_TOTAL1"),/* cID */,"SUM",oBreak1,"Sub-Total Repasse"		,PesqPict("P04","P04_TOTAL1"  	),/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
			oTotal2:= TRFunction():New(oSection1:Cell("E1_VALOR")	,/* cID */,"SUM",oBreak1,"Sub-Total Vlr. Tํtulo"	,PesqPict("SE1","E1_VALOR"  	),/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
			oTotal3:= TRFunction():New(oSection1:Cell("E1_SALDO")	,/* cID */,"SUM",oBreak1,"Sub-Total Saldo"			,PesqPict("SE1","E1_SALDO"  	),/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
			
			
			// SECTION 2
			oSection2 := TRSection():NeW(oSection,"Verba Financeiro",(AliasVERFN),,/*lLoadCells*/,/*lLoadOrder*/,/*uTotalText*/,/*lTotalInLine*/,/*lHeaderPage*/,.T./*lHeaderBreak*/,/*lPageBreak*/,/*lLineBreak*/,/*nLeftMargin*/,/*lLineStyle*/,/*nColSpace*/,/*lAutoSize*/,/*cCharSeparator*/,/*nLinesBefore*/,/*nCols*/,/*nClrBack*/,/*nClrFore*/,/*nPercentage*/)
			oSection2:SetHeaderSection():=.F.
			oBreak2:= TRBreak():New( oSection2, {|| (AliasVERFN)->(A1_COD+A1_LOJA)}, "Sub-Total Verba Financeiro") 
			
			TRCell():New(oSection2,"P01_CODIGO"		,(AliasVERFN),"Cod. Verba"	,/*Picture*/,/*Tamanho*/	,.F.		,{|| (AliasVERFN)->P01_CODIGO										})
			TRCell():New(oSection2,"P01_VERSAO"		,(AliasVERFN),/*Titulo*/	,/*Picture*/,/*Tamanho*/	,.F.		,{|| (AliasVERFN)->P01_VERSAO										})
			TRCell():New(oSection2,"P01_DTVINI"		,(AliasVERFN),/*Titulo*/	,/*Picture*/,/*Tamanho*/	,.F.		,{|| (AliasVERFN)->P01_DTVINI										})
			TRCell():New(oSection2,"P01_DTVFIM"		,(AliasVERFN),/*Titulo*/	,/*Picture*/,/*Tamanho*/	,.F.		,{|| (AliasVERFN)->P01_DTVFIM										})
			TRCell():New(oSection2,"P01_TPVPC"		,(AliasVERFN),/*Titulo*/	,/*Picture*/,/*Tamanho*/	,.F.		,{|| X3COMBO("P01_TPVPC" ,Alltrim((AliasVERFN)->P01_TPVPC))		})
			TRCell():New(oSection2,"P01_STATUS"		,(AliasVERFN),	  			,/*Picture*/,				,.F.		,{|| X3COMBO("P01_STATUS",Alltrim((AliasVERFN)->P01_STATUS))		})
			TRCell():New(oSection2,"P01_REPASS"		,(AliasVERFN),				,/*Picture*/,				,.F.		,{|| X3COMBO("P01_REPASS",Alltrim((AliasVERFN)->P01_REPASS))		})
			TRCell():New(oSection2,"P01_TPFAT"		,(AliasVERFN),				,/*Picture*/,				,.F.		,{|| X3COMBO("P01_TPFAT" ,Alltrim((AliasVERFN)->P01_TPFAT))		})
			TRCell():New(oSection2,""				,(AliasVERFN),""			,/*Picture*/,				,.F.		,{|| ""																})
			TRCell():New(oSection2,"P01_FILPED"		,(AliasVERFN),				,/*Picture*/,				,.F.		,{|| (AliasVERFN)->P01_FILPED										})
			TRCell():New(oSection2,"P01_PEDVEN"		,(AliasVERFN),				,/*Picture*/,				,.F.		,{|| (AliasVERFN)->P01_PEDVEN										})
			TRCell():New(oSection2,"C5_EMISSAO"		,(AliasVERFN),				,/*Picture*/,				,.F.		,{|| (AliasVERFN)->C5_EMISSAO										})
			TRCell():New(oSection2,""				,(AliasVERFN),""			,/*Picture*/,				,.F.		,{|| ""																})
			TRCell():New(oSection2,"C5_TOTAL"		,(AliasVERFN),"Total Pedido",/*Picture*/,				,.F.		,{|| GetTotPed((AliasVERFN)->P01_FILPED,(AliasVERFN)->P01_PEDVEN)	})
			TRCell():New(oSection2,"A1_COD"			,(AliasVERFN),				,/*Picture*/,				,.F.		,{|| (AliasVERFN)->A1_COD											})
			TRCell():New(oSection2,"A1_LOJA"		,(AliasVERFN),				,/*Picture*/,				,.F.		,{|| (AliasVERFN)->A1_LOJA											})			
			TRCell():New(oSection2,"A1_NREDUZ"		,(AliasVERFN),/*Titulo*/	,/*Picture*/,/*Tamanho*/	,.F.		,{|| (AliasVERFN)->A1_NREDUZ   										})
			TRCell():New(oSection2,"P01_TOTVAL"		,(AliasVERFN),				,/*Picture*/,				,.F.		,{|| (AliasVERFN)->P01_TOTVAL										})
			TRCell():New(oSection2,"E2_PREFIXO"		,(AliasVERFN),/*Titulo*/	,/*Picture*/,/*Tamanho*/	,.F.		,{|| (AliasVERFN)->E2_PREFIXO										})
			TRCell():New(oSection2,"E2_NUM"			,(AliasVERFN),/*Titulo*/	,/*Picture*/,/*Tamanho*/	,.F.		,{|| (AliasVERFN)->E2_NUM											})
			TRCell():New(oSection2,"E2_EMISSAO"		,(AliasVERFN),/*Titulo*/	,/*Picture*/,/*Tamanho*/	,.F.		,{|| (AliasVERFN)->E2_EMISSAO										})
			TRCell():New(oSection2,"E2_VALOR"		,(AliasVERFN),				,/*Picture*/,				,.F.		,{|| (AliasVERFN)->E2_VALOR											})
			TRCell():New(oSection2,"E2_SALDO"		,(AliasVERFN),				,/*Picture*/,				,.F.		,{|| (AliasVERFN)->E2_SALDO											})
			
			oTotal4:= TRFunction():New(oSection2:Cell("P01_TOTVAL"),/* cID */,"SUM",oBreak2,"Sub-Total Verba"	  		,PesqPict("P01","P01_TOTVAL")	,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
			oTotal5:= TRFunction():New(oSection2:Cell("E2_VALOR")	,/* cID */,"SUM",oBreak2,"Sub-Total Vlr. Tํtulo"	,PesqPict("SE2","E2_VALOR"  )	,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
			oTotal6:= TRFunction():New(oSection2:Cell("E2_SALDO")	,/* cID */,"SUM",oBreak2,"Sub-Total Saldo"			,PesqPict("SE2","E2_SALDO"  )	,/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)

			
			// SECTION 3
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
			TRCell():New(oSaldo,""				,""	,""					,/*Picture*/					,			,.F.		,{|| ""	})
			TRCell():New(oSaldo,""				,""	,""					,/*Picture*/					,			,.F.		,{|| ""	})
			TRCell():New(oSaldo,""				,""	,""					,/*Picture*/					,			,.F.		,{|| ""	})
			TRCell():New(oSaldo,""				,""	,""					,/*Picture*/					,			,.F.		,{|| ""	})
			TRCell():New(oSaldo,""				,""	,""					,/*Picture*/					,			,.F.		,{|| ""	})
			TRCell():New(oSaldo,"TOTREPAS"		,""	,"Total Repasse"	,PesqPict("P04","P04_TOTAL1")	,/*Tamanho*/,/*lPixel*/	,{|| 	})
			TRCell():New(oSaldo,""				,""	,""					,/*Picture*/					,			,.F.		,{|| ""	})
			TRCell():New(oSaldo,""				,""	,""					,/*Picture*/					,			,.F.		,{|| ""	})
			TRCell():New(oSaldo,""				,""	,""					,/*Picture*/					,			,.F.		,{|| ""	})
			TRCell():New(oSaldo,"TOTALTIT"		,""	,"Total Titulos"	,PesqPict("SE1","E1_VALOR")		,/*Tamanho*/,/*lPixel*/	,{|| ""	})
			TRCell():New(oSaldo,"SALDOABER"		,""	,"Total Saldo"		,PesqPict("SE1","E1_SALDO")		,/*Tamanho*/,/*lPixel*/	,{|| ""	})

			// SECTION 4
			oSection4:= TRSection():NeW(oSection,"VPC Aplicado em Pedido de Venda",{},,/*lLoadCells*/,/*lLoadOrder*/,/*uTotalText*/,/*lTotalInLine*/,/*lHeaderPage*/,.T./*lHeaderBreak*/,/*lPageBreak*/,/*lLineBreak*/,/*nLeftMargin*/,/*lLineStyle*/,/*nColSpace*/,/*lAutoSize*/,/*cCharSeparator*/,/*nLinesBefore*/,/*nCols*/,/*nClrBack*/,/*nClrFore*/,/*nPercentage*/)
			oSection4:SetHeaderSection():=.F.
			oBreak3:= TRBreak():New( oSection4, {|| (clAliasSC5)->(A1_COD+A1_LOJA)}, "Sub-Total VPC Aplicado em Pedido de Venda") 
			
			TRCell():New(oSection4,"P01_CODIGO"		,(clAliasSC5),"Contrato VPC"	,/*Picture*/,/*Tamanho*/	,.F.	,{|| (clAliasSC5)->P01_CODIGO									})
			TRCell():New(oSection4,"P01_VERSAO"		,(clAliasSC5),/*Titulo*/		,/*Picture*/,/*Tamanho*/	,.F.	,{|| (clAliasSC5)->P01_VERSAO									})
			TRCell():New(oSection4,"P01_DTVINI"		,(clAliasSC5),/*Titulo*/		,/*Picture*/,/*Tamanho*/	,.F.	,{|| (clAliasSC5)->P01_DTVINI									})
			TRCell():New(oSection4,"P01_DTVFIM"		,(clAliasSC5),/*Titulo*/		,/*Picture*/,/*Tamanho*/	,.F.	,{|| (clAliasSC5)->P01_DTVFIM									})
			TRCell():New(oSection4,"P01_TPVPC"		,(clAliasSC5),/*Titulo*/		,/*Picture*/,/*Tamanho*/	,.F.	,{|| X3COMBO("P01_TPVPC" ,Alltrim((clAliasSC5)->P01_TPVPC))	})
			TRCell():New(oSection4,"P01_STATUS"		,(clAliasSC5),					,/*Picture*/,				,.F.	,{|| X3COMBO("P01_STATUS",Alltrim((clAliasSC5)->P01_STATUS))	})
			TRCell():New(oSection4,"P01_REPASS"		,(clAliasSC5),					,/*Picture*/,				,.F.	,{|| X3COMBO("P01_REPASS",Alltrim((clAliasSC5)->P01_REPASS)) 	})
			TRCell():New(oSection4,"P01_TPFAT"		,(clAliasSC5),					,/*Picture*/,				,.F.	,{|| X3COMBO("P01_TPFAT" ,Alltrim((clAliasSC5)->P01_TPFAT))	})
			TRCell():New(oSection4,"P01_TOTPER"		,(clAliasSC5),/*Titulo*/		,/*Picture*/,/*Tamanho*/	,.F.	,{|| (clAliasSC5)->P01_TOTPER									})
			TRCell():New(oSection4,"C5_FILIAL"		,(clAliasSC5),/*Titulo*/		,/*Picture*/,/*Tamanho*/	,.F.	,{|| (clAliasSC5)->C5_FILIAL 									})
			TRCell():New(oSection4,"C5_NUM"			,(clAliasSC5),/*Titulo*/		,/*Picture*/,/*Tamanho*/	,.F.	,{|| (clAliasSC5)->C5_NUM						 		  		})			
			TRCell():New(oSection4,"C5_EMISSAO"		,(clAliasSC5),/*Titulo*/		,/*Picture*/,/*Tamanho*/	,.F.	,{|| (clAliasSC5)->C5_EMISSAO									})			
			TRCell():New(oSection4,""				,(clAliasSC5),""   				,/*Picture*/,				,.F.	,{|| ""															})
			TRCell():New(oSection4,"C5_TOTAL"		,(clAliasSC5),"Total Pedido"	,/*Picture*/,				,.F.	,{|| GetTotPed((clAliasSC5)->C5_FILIAL,(clAliasSC5)->C5_NUM)	})
			TRCell():New(oSection4,"A1_COD"			,(clAliasSC5),/*Titulo*/		,/*Picture*/,/*Tamanho*/	,.F.	,{|| (clAliasSC5)->A1_COD 	 	   								})			
			TRCell():New(oSection4,"A1_LOJA"		,(clAliasSC5),/*Titulo*/		,/*Picture*/,/*Tamanho*/	,.F.	,{|| (clAliasSC5)->A1_LOJA 							 			})			
			TRCell():New(oSection4,"A1_NREDUZ"		,(clAliasSC5),/*Titulo*/		,/*Picture*/,/*Tamanho*/	,.F.	,{|| (clAliasSC5)->A1_NREDUZ 	  						 		})			
			TRCell():New(oSection4,"C6_YVALVPC"		,(clAliasSC5),/*Titulo*/		,/*Picture*/,/*Tamanho*/	,.F.	,{|| GetDescVPC((clAliasSC5)->C5_FILIAL,(clAliasSC5)->C5_NUM)	})
			TRCell():New(oSection4,"C5_SERIE"		,(clAliasSC5),/*Titulo*/		,/*Picture*/,/*Tamanho*/	,.F.	,{|| (clAliasSC5)->C5_SERIE 	 								})
			TRCell():New(oSection4,"C5_NOTA"		,(clAliasSC5),/*Titulo*/		,/*Picture*/,/*Tamanho*/	,.F.	,{|| (clAliasSC5)->C5_NOTA 	 									})
			TRCell():New(oSection4,"F2_EMISSAO"		,(clAliasSC5),/*Titulo*/		,/*Picture*/,/*Tamanho*/	,.F.	,{|| (clAliasSC5)->F2_EMISSAO 	 								})
			TRCell():New(oSection4,"F2_VALBRUT"		,(clAliasSC5),"Vlr. Total NF"	,/*Picture*/,/*Tamanho*/	,.F.	,{|| (clAliasSC5)->F2_VALBRUT 	 								})
			TRCell():New(oSection4,""				,(clAliasSC5),""	   			,/*Picture*/,				,.F.	,{|| ""															})						
	
			oTotal7:= TRFunction():New(oSection4:Cell("C6_YVALVPC"),/* cID */,"SUM",oBreak3,"Sub-Total Desconto"	  	,PesqPict("SC6","C6_YVALVPC"  ),/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
			oTotal8:= TRFunction():New(oSection4:Cell("F2_VALBRUT"),/* cID */,"SUM",oBreak3,"Sub-Total Vlr. Nota"		,PesqPict("SF2","F2_VALBRUT"  ),/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)


			// SECTION 5
			oSection5:= TRSection():NeW(oSection,"Verba Aplicado em Pedido de Venda",{},,/*lLoadCells*/,/*lLoadOrder*/,/*uTotalText*/,/*lTotalInLine*/,/*lHeaderPage*/,.T./*lHeaderBreak*/,/*lPageBreak*/,/*lLineBreak*/,/*nLeftMargin*/,/*lLineStyle*/,/*nColSpace*/,/*lAutoSize*/,/*cCharSeparator*/,/*nLinesBefore*/,/*nCols*/,/*nClrBack*/,/*nClrFore*/,/*nPercentage*/)
			oSection5:SetHeaderSection():=.F.
			oBreak4:= TRBreak():New( oSection5, {|| (clAliasVPV)->(A1_COD+A1_LOJA)}, "Sub-Total Verba Aplicado em Pedido de Venda") 
			
			TRCell():New(oSection5,"P01_CODIGO"		,(clAliasVPV),"Cod. Verba"		,/*Picture*/,/*Tamanho*/	,.F.,{|| (clAliasVPV)->P01_CODIGO		  							})
			TRCell():New(oSection5,"P01_VERSAO"		,(clAliasVPV),/*Titulo*/		,/*Picture*/,/*Tamanho*/	,.F.,{|| (clAliasVPV)->P01_VERSAO		  							})
			TRCell():New(oSection5,"P01_DTVINI"		,(clAliasVPV),/*Titulo*/		,/*Picture*/,/*Tamanho*/	,.F.,{|| (clAliasVPV)->P01_DTVINI		 							})
			TRCell():New(oSection5,"P01_DTVFIM"		,(clAliasVPV),/*Titulo*/		,/*Picture*/,/*Tamanho*/	,.F.,{|| (clAliasVPV)->P01_DTVFIM									})
			TRCell():New(oSection5,"P01_TPVPC"		,(clAliasVPV),/*Titulo*/		,/*Picture*/,/*Tamanho*/	,.F.,{|| X3COMBO("P01_TPVPC" ,Alltrim((clAliasVPV)->P01_TPVPC))	})
			TRCell():New(oSection5,"P01_STATUS"		,(clAliasVPV),					,/*Picture*/,				,.F.,{|| X3COMBO("P01_STATUS",Alltrim((clAliasVPV)->P01_STATUS))	})
			TRCell():New(oSection5,"P01_REPASS"		,(clAliasVPV),					,/*Picture*/,				,.F.,{|| X3COMBO("P01_REPASS",Alltrim((clAliasVPV)->P01_REPASS)) 	})
			TRCell():New(oSection5,"P01_TPFAT"		,(clAliasVPV),					,/*Picture*/,				,.F.,{|| X3COMBO("P01_TPFAT" ,Alltrim((clAliasVPV)->P01_TPFAT))	})
			TRCell():New(oSection5,""				,(clAliasVPV),""				,/*Picture*/,/*Tamanho*/	,.F.,{|| ""															})
			TRCell():New(oSection5,"P01_FILPED"		,(clAliasVPV),/*Titulo*/		,/*Picture*/,/*Tamanho*/	,.F.,{|| (clAliasVPV)->P01_FILPED						 			})
			TRCell():New(oSection5,"P01_PEDVEN"		,(clAliasVPV),/*Titulo*/		,/*Picture*/,/*Tamanho*/	,.F.,{|| (clAliasVPV)->P01_PEDVEN 	 								})			
			TRCell():New(oSection5,"C5_EMISSAO"		,(clAliasVPV),/*Titulo*/		,/*Picture*/,/*Tamanho*/	,.F.,{|| (clAliasVPV)->C5_EMISSAO									})			
			TRCell():New(oSection5,""				,(clAliasVPV),""	   			,/*Picture*/,				,.F.,{|| ""															})
			TRCell():New(oSection5,"C5_TOTAL"		,(clAliasVPV),"Total Pedido"	,/*Picture*/,				,.F.,{|| GetTotPed((clAliasVPV)->P01_FILPED,(clAliasVPV)->P01_PEDVEN)	})
			TRCell():New(oSection5,"A1_COD"			,(clAliasVPV),/*Titulo*/		,/*Picture*/,/*Tamanho*/	,.F.,{|| (clAliasVPV)->A1_COD 		 								})			
			TRCell():New(oSection5,"A1_LOJA"		,(clAliasVPV),/*Titulo*/		,/*Picture*/,/*Tamanho*/	,.F.,{|| (clAliasVPV)->A1_LOJA	 							 		})			
			TRCell():New(oSection5,"A1_NREDUZ"		,(clAliasVPV),/*Titulo*/		,/*Picture*/,/*Tamanho*/	,.F.,{|| (clAliasVPV)->A1_NREDUZ 	  						 		})			
			TRCell():New(oSection5,"P01_TOTVAL"		,(clAliasVPV),					,/*Picture*/,				,.F.,{|| (clAliasVPV)->P01_TOTVAL									})
			TRCell():New(oSection5,"C5_SERIE"		,(clAliasVPV),/*Titulo*/		,/*Picture*/,/*Tamanho*/	,.F.,{|| (clAliasVPV)->C5_SERIE 							 		})
			TRCell():New(oSection5,"C5_NOTA"		,(clAliasVPV),/*Titulo*/		,/*Picture*/,/*Tamanho*/	,.F.,{|| (clAliasVPV)->C5_NOTA							 	 		})
			TRCell():New(oSection5,"F2_EMISSAO"		,(clAliasVPV),/*Titulo*/		,/*Picture*/,/*Tamanho*/	,.F.,{|| (clAliasVPV)->F2_EMISSAO 							 		})
			TRCell():New(oSection5,"F2_VALBRUT"		,(clAliasVPV),"Vlr. Total NF"	,/*Picture*/,/*Tamanho*/	,.F.,{|| (clAliasVPV)->F2_VALBRUT 							 		})
			TRCell():New(oSection5,""				,(clAliasVPV),""	   			,/*Picture*/,				,.F.,{|| ""															})			

			oTotal9 := TRFunction():New(oSection5:Cell("P01_TOTVAL"),/* cID */,"SUM",oBreak4,"Sub-Total Verba"	   		,PesqPict("P01","P01_TOTVAL"  ),/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
			oTotal10:= TRFunction():New(oSection5:Cell("F2_VALBRUT"),/* cID */,"SUM",oBreak4,"Sub-Total Vlr. Nota"		,PesqPict("SF2","F2_VALBRUT"  ),/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)

			

			// SECTION 6
			oSaldo2 	:= TRSection():New(oSection,"Saldo",,,/*lLoadCells*/,/*lLoadOrder*/,"Saldo",/*lTotalInLine*/,/*lHeaderPage*/,.T./*lHeaderBreak*/,/*lPageBreak*/,/*lLineBreak*/,/*nLeftMargin*/,/*lLineStyle*/,/*nColSpace*/,/*lAutoSize*/,/*cCharSeparator*/,/*nLinesBefore*/,/*nCols*/,/*nClrBack*/,/*nClrFore*/,/*nPercentage*/)
			oSaldo2:SetHeaderSection():=.F.
			
			TRCell():New(oSaldo2,""				,""	,""					,					,			,.F.		,{|| ""	})
			TRCell():New(oSaldo2,""				,""	,""					,					,			,.F.		,{|| ""	})
			TRCell():New(oSaldo2,""				,""	,""					,					,			,.F.		,{|| ""	})
			TRCell():New(oSaldo2,""				,""	,""					,					,			,.F.		,{|| ""	})
			TRCell():New(oSaldo2,""				,""	,""					,					,			,.F.		,{|| ""	})
			TRCell():New(oSaldo2,""				,""	,""					,					,			,.F.		,{|| ""	})
			TRCell():New(oSaldo2,""				,""	,""					,					,			,.F.		,{|| ""	})
			TRCell():New(oSaldo2,""				,""	,""					,					,			,.F.		,{|| ""	})
			TRCell():New(oSaldo2,""				,""	,""					,					,			,.F.		,{|| ""	})
			TRCell():New(oSaldo2,""				,""	,""					,					,			,.F.		,{|| ""	})
			TRCell():New(oSaldo2,""				,""	,""					,					,			,.F.		,{|| ""	})
			TRCell():New(oSaldo2,""				,""	,""					,					,			,.F.		,{|| ""	})
			TRCell():New(oSaldo2,""				,""	,""					,					,			,.F.		,{|| ""	})
			TRCell():New(oSaldo2,""				,""	,""					,					,			,.F.		,{|| ""	})
			TRCell():New(oSaldo2,""				,""	,""					,					,			,.F.		,{|| ""	})
			TRCell():New(oSaldo2,""				,""	,""					,					,			,.F.		,{|| ""	})
			TRCell():New(oSaldo2,""				,""	,""					,					,			,.F.		,{|| ""	})
			TRCell():New(oSaldo2,"TOTREPAS"		,""	,"Total Geral" 		,PesqPict("P04","P04_TOTAL1")	,,			,{|| 	})
			TRCell():New(oSaldo2,""				,""	,""					,					,			,.F.		,{|| ""	})
			TRCell():New(oSaldo2,""				,""	,""					,					,			,.F.		,{|| ""	})
			TRCell():New(oSaldo2,""				,""	,""					,					,			,.F.		,{|| ""	})
			TRCell():New(oSaldo2,""	  			,""	,""					,   				,,	,{|| ""	})
			TRCell():New(oSaldo2,""	  			,""	,""	   				,	 				,,	,{|| ""	})


			oGeral 	:= TRSection():New(oSection,"Geral",,,/*lLoadCells*/,/*lLoadOrder*/,"Geral",/*lTotalInLine*/,/*lHeaderPage*/,.T./*lHeaderBreak*/,/*lPageBreak*/,/*lLineBreak*/,/*nLeftMargin*/,/*lLineStyle*/,/*nColSpace*/,/*lAutoSize*/,/*cCharSeparator*/,/*nLinesBefore*/,/*nCols*/,/*nClrBack*/,/*nClrFore*/,/*nPercentage*/)
			oGeral:SetHeaderSection():=.F.
			
			TRCell():New(oGeral,""				,""	,""					,					,			,.F.		,{|| ""	})
			TRCell():New(oGeral,""				,""	,""					,					,			,.F.		,{|| ""	})
			TRCell():New(oGeral,""				,""	,""					,					,			,.F.		,{|| ""	})
			TRCell():New(oGeral,""				,""	,""					,					,			,.F.		,{|| ""	})
			TRCell():New(oGeral,""				,""	,""					,					,			,.F.		,{|| ""	})
			TRCell():New(oGeral,""				,""	,""					,					,			,.F.		,{|| ""	})
			TRCell():New(oGeral,""				,""	,""					,					,			,.F.		,{|| ""	})
			TRCell():New(oGeral,""				,""	,""					,					,			,.F.		,{|| ""	})
			TRCell():New(oGeral,""				,""	,""					,					,			,.F.		,{|| ""	})
			TRCell():New(oGeral,""				,""	,""					,					,			,.F.		,{|| ""	})
			TRCell():New(oGeral,""				,""	,""					,					,			,.F.		,{|| ""	})
			TRCell():New(oGeral,""				,""	,""					,					,			,.F.		,{|| ""	})
			TRCell():New(oGeral,""				,""	,""					,					,			,.F.		,{|| ""	})
			TRCell():New(oGeral,""				,""	,""					,					,			,.F.		,{|| ""	})
			TRCell():New(oGeral,""				,""	,""					,					,			,.F.		,{|| ""	})
			TRCell():New(oGeral,""				,""	,""					,					,			,.F.		,{|| ""	})
			TRCell():New(oGeral,""				,""	,""					,					,			,.F.		,{|| ""	})
			TRCell():New(oGeral,"TOTREPAS"		,""	,"Total Geral Relat.",PesqPict("P04","P04_TOTAL1")	,,			,{|| 	})
			TRCell():New(oGeral,""				,""	,""					,					,			,.F.		,{|| ""	})
			TRCell():New(oGeral,""				,""	,""					,					,			,.F.		,{|| ""	})
			TRCell():New(oGeral,""				,""	,""					,					,			,.F.		,{|| ""	})
			TRCell():New(oGeral,""	  			,""	,""					,   				,			,.F.		,{|| ""	})
			TRCell():New(oGeral,""	  			,""	,""	   				,	 				,			,.F. 		,{|| ""	})
                                                                                            	



			oReport:Section(1):SetLineStyle(.F.)    
			oReport:Section(1):Section(1):SetLineStyle(.F.) 
			oReport:Section(1):Section(2):SetLineStyle(.F.)    
			oReport:Section(1):Section(3):SetLineStyle(.F.)
			oReport:Section(1):Section(4):SetLineStyle(.F.)
			oReport:Section(1):Section(5):SetLineStyle(.F.)
			oReport:Section(1):Section(6):SetLineStyle(.F.)
			oReport:Section(1):Section(7):SetLineStyle(.F.)

			
			oReport:Section(1):lReadOnly := .T. 
			oReport:Section(1):Section(1):lReadOnly := .T. 
			oReport:Section(1):Section(2):lReadOnly := .T. 
			oReport:Section(1):Section(3):lReadOnly := .T. 
			oReport:Section(1):Section(4):lReadOnly := .T. 
			oReport:Section(1):Section(5):lReadOnly := .T. 
			oReport:Section(1):Section(6):lReadOnly := .T. 
			oReport:Section(1):Section(7):lReadOnly := .T. 
			
		ElseIf MV_PAR08 == 1

			oReport := TReport():New("NCGRL101",cTitulo,clPerg,{|oReport| ReportList(oReport)},cDescricao)
		   	oReport:SetLandscape(.T.)//Impressao Paissagem
		   	oReport:oPage:nPaperSize:= 9
		   	oReport:DisableOrientation()//Desabilita a mudanca de impressao		
			oReport:nDevice := 4
			
			
			oNotas := TRSection():New(oReport,"Notas de Entrada e Saida",(clAliasNotas))
			oNotas:lReadOnly := .T. 
			oNotas:SetTotalInLine(.T.)  
			oBreak1:= TRBreak():New( oNotas, {|| (clAliasNotas)->(P04_CLIENT+P04_LOJCLI)}, "") 
			oBreak2:= TRBreak():New( oNotas, {|| (clAliasNotas)->P04_CLIENT}, "Total Geral") 

			
			TRCell():New(oNotas,"P04_CODIGO"	,(clAliasNotas),				,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| (clAliasNotas)->P04_CODIGO		})
			TRCell():New(oNotas,"ADATADE"		,(clAliasNotas),"Data De"		,PesqPict("P04","P04_DTINI" ),TamSx3("P04_DTINI")[1],/*lPixel*/,{|| MV_PAR01		})
			TRCell():New(oNotas,"ADATAATE"		,(clAliasNotas),"Data At้"		,PesqPict("P04","P04_DTINI" ),TamSx3("P04_DTINI")[1],/*lPixel*/,{|| MV_PAR02		})
			TRCell():New(oNotas,"P04_FECHAM"	,(clAliasNotas),				,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| (clAliasNotas)->P04_FECHAM		})
			TRCell():New(oNotas,"P04_CLIENT"	,(clAliasNotas),/*Titulo*/		,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| (clAliasNotas)->P04_CLIENT		})
			TRCell():New(oNotas,"P04_LOJCLI"	,(clAliasNotas),/*Titulo*/		,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| (clAliasNotas)->P04_LOJCLI		})
			TRCell():New(oNotas,"A1_NOME"		,(clAliasNotas),/*Titulo*/		,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| (clAliasNotas)->A1_NOME		})
			TRCell():New(oNotas,"A1_EST"		,(clAliasNotas),/*Titulo*/		,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| (clAliasNotas)->A1_EST	 		})
			TRCell():New(oNotas,"P04_CODVPC"	,(clAliasNotas),/*Titulo*/		,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| (clAliasNotas)->P04_CODVPC		})
			TRCell():New(oNotas,"P04_VERVPC"	,(clAliasNotas),/*Titulo*/		,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| (clAliasNotas)->P04_VERVPC		})
			TRCell():New(oNotas,"P04_TPFAT"		,(clAliasNotas),/*Titulo*/		,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| IIF( (clAliasNotas)->P04_TPFAT == "1","Bruto","Liquido")		})
			TRCell():New(oNotas,"P04_DTINI"		,(clAliasNotas),/*Titulo*/		,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| (clAliasNotas)->P04_DTINI		})
			TRCell():New(oNotas,"P04_DTFIM"		,(clAliasNotas),/*Titulo*/		,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| (clAliasNotas)->P04_DTFIM		})
			TRCell():New(oNotas,"P04_STATUS"	,(clAliasNotas),/*Titulo*/		,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| IIF((clAliasNotas)->P04_STATUS == "1","Aberta","Fechada")		})
			TRCell():New(oNotas,"P04_CODVEN"	,(clAliasNotas),/*Titulo*/		,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| (clAliasNotas)->P04_CODVEN		})
			TRCell():New(oNotas,"TPDOC"			,(clAliasNotas),"Documento"		,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| (clAliasNotas)->TPDOC  		})
			TRCell():New(oNotas,"DOCUMEN"		,(clAliasNotas),"Num/Serie"		,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| Alltrim((clAliasNotas)->DOCUMEN) +"/"+ Alltrim((clAliasNotas)->SERIE)	})
			TRCell():New(oNotas,"EMISSAO"		,(clAliasNotas),"Emissใo"		,PesqPict("P04","P04_DTINI" ),TamSx3("P04_DTINI")[1]		,/*lPixel*/,{|| (clAliasNotas)->EMISSAO		})
			TRCell():New(oNotas,"DIGITACAO" 	,(clAliasNotas),"Dt. Digitacao"	,PesqPict("P04","P04_DTINI" ),TamSx3("P04_DTINI")[1]		,/*lPixel*/,{|| (clAliasNotas)->DIGITACAO		})
			TRCell():New(oNotas,"TOTNF"			,(clAliasNotas),"Total NF"		,PesqPict("SF2","F2_VALBRUT"),TamSx3("F2_VALBRUT")[1]+2	,/*lPixel*/,{|| (clAliasNotas)->TOTNF			})
			TRCell():New(oNotas,"FRETESEG"		,(clAliasNotas),"Frete+Seg+Despesa",PesqPict("SF2","F2_VALMERC"),TamSx3("F2_VALMERC")[1]+2	,/*lPixel*/,{|| (clAliasNotas)->(FRETE+SEGURO+DESPESA)		})
			TRCell():New(oNotas,"VALMERC"		,(clAliasNotas),"Valor Mercad"	,PesqPict("SF2","F2_VALMERC"),TamSx3("F2_VALMERC")[1]+2	,/*lPixel*/,{|| (clAliasNotas)->VALMERC		})
			TRCell():New(oNotas,"BASEPIS"		,(clAliasNotas),"Base Pis"		,PesqPict("SF2","F2_BASPIS"),TamSx3("F2_BASPIS")[1]+2 		,/*lPixel*/,{|| (clAliasNotas)->BASEPIS		})
			TRCell():New(oNotas,"BASECOF"		,(clAliasNotas),"Base Cofins"	,PesqPict("SF2","F2_BASCOFI"),TamSx3("F2_BASCOFI")[1]+2	,/*lPixel*/,{|| (clAliasNotas)->BASECOF		})
			TRCell():New(oNotas,"BASEICM"		,(clAliasNotas),"Base ICMS"		,PesqPict("SF2","F2_BASEICM"),TamSx3("F2_BASEICM")[1]+2	,/*lPixel*/,{|| (clAliasNotas)->BASEICM		})
			TRCell():New(oNotas,"VALPIS"		,(clAliasNotas),"Valor Pis"		,PesqPict("SF2","F2_VALPIS"),TamSx3("F2_VALPIS")[1]+2		,/*lPixel*/,{|| (clAliasNotas)->VALPIS		})
			TRCell():New(oNotas,"VALCOF"		,(clAliasNotas),"Valor Cofins"	,PesqPict("SF2","F2_VALCOFI"),TamSx3("F2_VALCOFI")[1]+2	,/*lPixel*/,{|| (clAliasNotas)->VALCOF		})
			TRCell():New(oNotas,"VALICM"		,(clAliasNotas),"Valor ICMS"	,PesqPict("SF2","F2_VALICM"),TamSx3("F2_VALICM")[1]+2		,/*lPixel*/,{|| (clAliasNotas)->VALICM		})
			TRCell():New(oNotas,"VALIPI"		,(clAliasNotas),"Valor IPI"		,PesqPict("SF2","F2_VALIPI"),TamSx3("F2_VALIPI")[1]+2		,/*lPixel*/,{|| (clAliasNotas)->VALIPI  		})
			TRCell():New(oNotas,"ICMSRET"		,(clAliasNotas),"ICMS Retido"	,PesqPict("SF2","F2_ICMSRET"),TamSx3("F2_ICMSRET")[1]+2	,/*lPixel*/,{|| (clAliasNotas)->ICMSRET		})
			TRCell():New(oNotas,"LIQNF"			,(clAliasNotas),"Liquido NF"	,PesqPict("SF2","F2_VALMERC"),TamSx3("F2_VALMERC")[1]+2	,/*lPixel*/,{|| (clAliasNotas)->LIQNF			})
			TRCell():New(oNotas,"P04_PERCEN"   	,(clAliasNotas),				,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| (clAliasNotas)->P04_PERCEN		})
			TRCell():New(oNotas,"PERCENAPL"		,(clAliasNotas),"VPC Aplicado"	,PesqPict("SF2","F2_VALMERC"),TamSx3("F2_VALMERC")[1]+2	,/*lPixel*/,{|| (IIF( (clAliasNotas)->P04_TPFAT == "1",(clAliasNotas)->TOTNF,(clAliasNotas)->LIQNF)*(clAliasNotas)->P04_PERCEN) /100		})
			TRCell():New(oNotas,"AGENDAM"		,(clAliasNotas),"Agendamento"	,PesqPict("P04","P04_DTINI" ),TamSx3("P04_DTINI")[1]		,/*lPixel*/,{|| (clAliasNotas)->AGENDAM		})
			TRCell():New(oNotas,"TRANSP"		,(clAliasNotas),"Transportadora",/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| (clAliasNotas)->TRANSP			})
			TRCell():New(oNotas,"DTENTRE"		,(clAliasNotas),"Data Entrega"	,PesqPict("P04","P04_DTINI" ),TamSx3("P04_DTINI")[1]		,/*lPixel*/,{|| (clAliasNotas)->DTENTRE		})
			TRCell():New(oNotas,"NFORIG"		,(clAliasNotas),"NF Original"	,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| (clAliasNotas)->NFORIG			})
			TRCell():New(oNotas,"PEDIDO"		,(clAliasNotas),"Pedido"		,/*Picture*/,/*Tamanho*/,/*lPixel*/,{|| (clAliasNotas)->PEDIDO			})
			TRCell():New(oNotas,"EMISPED"		,(clAliasNotas),"Emissใo"		,PesqPict("P04","P04_DTINI" ),TamSx3("P04_DTINI")[1]		,/*lPixel*/,{|| (clAliasNotas)->EMISPED		})
			TRCell():New(oNotas,"ENTREGORI"		,(clAliasNotas),"Data Entrega NF Original"	,PesqPict("P04","P04_DTINI" ),TamSx3("P04_DTINI")[1]		,/*lPixel*/,{|| GetDtEntreg((clAliasNotas)->NFORIG,(clAliasNotas)->P04_CLIENT,(clAliasNotas)->P04_LOJCLI )		})
			
			

			oTotal1:= TRFunction():New(oNotas:Cell("TOTNF")		,/* cID */,"SUM",oBreak1,"Total Bruto"			,PesqPict("SF2","F2_VALMERC"  ),/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
			oTotal2:= TRFunction():New(oNotas:Cell("LIQNF")		,/* cID */,"SUM",oBreak1,"Total Liquido"		,PesqPict("SF2","F2_VALMERC"  ),/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
			oTotal3:= TRFunction():New(oNotas:Cell("PERCENAPL")	,/* cID */,"SUM",oBreak1,"Total Aplicado VPC"	,PesqPict("SF2","F2_VALMERC"  ),/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
			
			oTotal4:= TRFunction():New(oNotas:Cell("TOTNF")		,/* cID */,"SUM",oBreak2,"Total Bruto"			,PesqPict("SF2","F2_VALMERC"  ),/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
			oTotal5:= TRFunction():New(oNotas:Cell("LIQNF")		,/* cID */,"SUM",oBreak2,"Total Liquido"		,PesqPict("SF2","F2_VALMERC"  ),/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
			oTotal6:= TRFunction():New(oNotas:Cell("PERCENAPL")	,/* cID */,"SUM",oBreak2,"Total Aplicado VPC"	,PesqPict("SF2","F2_VALMERC"  ),/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
			
		EndIf
		

	EndIf
	
Return oReport


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณReportPrintAutor  ณHermes Ferreira     บ Data ณ  23/11/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณImpressใo do Relat๓rio			 			              บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Nc Games						                              บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ReportPrint(oReport)
	
	Local oSecIni 	:= oReport:Section(1)
	Local oSection1 := oReport:Section(1):Section(1)
	Local oSection2 := oReport:Section(1):Section(2)
	Local oSection3 := oReport:Section(1):Section(3)
	Local oSection4 := oReport:Section(1):Section(4)
	Local oSection5 := oReport:Section(1):Section(5)
	Local oSection6 := oReport:Section(1):Section(6)
	Local oSection7 := oReport:Section(1):Section(7)

	               
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
	Local lMovContrat := .F. // Existe movimenta็ใo desse contrato
	
	Local cPrfVerba	:= U_MyNewSX6(	"NCG_000017"	 								,;
										"VER"											,;
										"C"												,;
										"Prefixo para relacionamento do Titulo a pagar com a Verba."	,;
										"Prefixo para relacionamento do Titulo a pagar com a Verba."	,;
										"Prefixo para relacionamento do Titulo a pagar com a Verba."	,;
										.F. )

	Local cPrfVPC	:= U_MyNewSX6(	"NCG_000016"	 								,;
										"VPC"											,;
										"C"												,;
										"Prefixo para relacionamento do NCC com o VPC."	,;
										"Prefixo para relacionamento do NCC com o VPC."	,;
										"Prefixo para relacionamento do NCC com o VPC."	,;
										.F. )
   
	//ErrorBlock( SysErrorBlock( { | e | ErrorDialog( e ) } ) )

	// Query Principal
	FGetQry()

	(clAlias)->(dbGoTop())
	oReport:SetMeter(RecCount())
	(clAlias)->(dbGoTop())

	While !oReport:Cancel() .AND. (clAlias)->(!Eof())                                   

		oReport:IncMeter()
		If oReport:Cancel()
			Exit
		EndIf
	
		//lNivel1 := .T.
		lMovContrat := .F.
		
		cCliente	:= Alltrim((clAlias)->P01_CODCLI)
		cLoja		:= iif(Empty(Alltrim((clAlias)->P01_LOJCLI)),"  ",Alltrim((clAlias)->P01_LOJCLI))
		
		If MV_PAR07 <> 1 .or. oReport:nDevice == 4 
			oReport:SkipLine()
			oReport:SkipLine()
			oReport:SkipLine()
			oReport:SkipLine()
		EndIf
		
       	oSecIni:Init()
		oSecIni:PrintLine()
		
		nTotRepas	:= 0
		nTotTit 	:= 0
		nTotSaldo	:= 0
		nTotGeral	:= 0

		// VPC APURADO
		oSection1:BeginQuery()
		
		clAliasS1	:= GetNextAlias()
		
		BeginSql Alias clAliasS1
	
			SELECT				
				P01_CODIGO	
				,P01_VERSAO	
				,P01_DTCRIA	
				,P01_DTVINI	
				,P01_DTVFIM	
				,P01_TPVPC	
				,P01_STATUS	
				,P01_REPASS	
				,P01_TPFAT	
				,P01_TOTPER	
				,P04_CODIGO	
				,P04_DTINI	
				,P04_DTFIM	
				,P04_FECHAM	
				,CASE WHEN P04_TPFAT = '1' THEN P04_FATBRU ELSE P04_FATLIQ END AS FATREALIZADO 	
				,A1_COD	
				,A1_LOJA
				,A1_NREDUZ	
				,P04_TOTAL1	
				,E1_PREFIXO	
				,E1_NUM		
				,E1_EMISSAO	
				,E1_VALOR	
				,E1_SALDO
			
			FROM %table:P04% P04 
			
			JOIN %table:P01% P01
			ON  P01.P01_FILIAL = P04.P04_FILIAL
			AND P01.P01_CODIGO = P04.P04_CODVPC
			AND P01.P01_VERSAO = P04.P04_VERVPC
			AND P01.P01_TPCAD = %Exp:'1'% 
			AND P01.P01_REPASS = %Exp:'1'%
			AND P01.P01_DTVINI >= %Exp:DtoS(MV_PAR01)%
			AND P01.P01_DTVFIM <= %Exp:DtoS(MV_PAR02)%
			AND P01.P01_STSAPR = %Exp:'1'%
			AND P01.%notDel%
			
			JOIN %table:SA1% SA1
			ON SA1.A1_FILIAL = %xfilial:SA1%
			AND SA1.A1_COD = P04.P04_CLIENT
			AND SA1.A1_LOJA = P04.P04_LOJCLI
			AND SA1.%notDel%

			LEFT JOIN %table:SE1% SE1
			ON E1_FILIAL = %xfilial:SE1% 
			AND SE1.E1_PREFIXO  =  %Exp:cPrfVPC%
			AND SE1.E1_NUM BETWEEN %Exp:' '% AND %Exp:'Z'%
			AND SE1.E1_PARCELA BETWEEN %Exp:' '% AND %Exp:'Z'%
			AND SE1.E1_TIPO BETWEEN %Exp:' '% AND %Exp:'Z'%
			AND SE1.E1_CLIENTE	=  P04.P04_CLIENT
			AND SE1.E1_LOJA = P04.P04_LOJCLI
			AND SE1.E1_YVPC = P04.P04_CODVPC
			AND SE1.E1_YVERVPC = P04.P04_VERVPC
			AND SE1.E1_YAPURAC = P04.P04_CODIGO
			AND SE1.%notDel%					
			
			WHERE P04.P04_FILIAL = %xfilial:p04% 
			AND P04.P04_CLIENT = %Exp:cCliente%
			AND P04.P04_LOJCLI between  %Exp:cLoja%  and %Exp:IIF(Empty(cLoja),"ZZ",cLoja)%  
			AND P04.P04_FECHAM <> %Exp:' '%
			AND P04.%notDel%
			
			ORDER BY P04_CLIENT,P04_LOJCLI,P04_CODVEN 
		
		EndSql
		
		oSection1:EndQuery()

		(clAliasS1)->(dbGoTop())
		
		If (clAliasS1)->(!Eof())

			llCabVPC := .F.
			
			If oReport:nDevice <> 4
				oReport:SkipLine()
				oReport:SkipLine()
			EndIf
						
			lMovContrat := .T.
			
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
			
			While (clAliasS1)->(!Eof())

		       	oSection1:Init()
				oSection1:PrintLine()
				
				nTotRepas	+= oSection1:Cell("P04_TOTAL1"):uprint
				nTotTit 	+= oSection1:Cell("E1_VALOR"):uprint
				nTotSaldo	+= oSection1:Cell("E1_SALDO"):uprint
								
				(clAliasS1)->(dbSkip())
				
			EndDo
		
			oSection1:Finish()
			
		EndIf
		
		(clAliasS1)->(dbCloseArea())


		
		oSection2:BeginQuery()
		
		AliasVERFN	:= GetNextAlias()
				
		BeginSql Alias AliasVERFN
		
			SELECT P01_CODIGO
					,P01_VERSAO
					,P01_DTVINI
					,P01_DTVFIM
					,P01_TPVPC
					,P01_STATUS
					,P01_REPASS
					,P01_TPFAT
					,P01_FILPED
					,P01_PEDVEN
					,C5_EMISSAO
					,A1_COD
					,A1_LOJA
					,A1_NREDUZ
					,P01_TOTVAL
					,E2_PREFIXO
					,E2_NUM	
					,E2_EMISSAO
					,E2_VALOR
					,E2_SALDO
					
			FROM %table:SE2% SE2

			JOIN %table:P01% P01
			ON  P01.P01_FILIAL = %xfilial:p01% 
			AND P01.P01_CODIGO = SE2.E2_YVPC 
			AND P01.P01_VERSAO = SE2.E2_YVERVPC
			AND P01.P01_TPCAD = %Exp:'2'% 
			AND P01.P01_REPASS = %Exp:'1'%
			AND P01.P01_DTVINI >= %Exp:DtoS(MV_PAR01)%
			AND P01.P01_DTVFIM <= %Exp:DtoS(MV_PAR02)%
			AND P01.P01_STSAPR = %Exp:'1'%
			AND P01.%notDel%
				
			JOIN %table:SA2% SA2
			ON SA2.A2_FILIAL =  %xfilial:SA2% 
			AND SA2.A2_COD = SE2.E2_FORNECE
			AND SA2.A2_LOJA = SE2.E2_LOJA
			AND SA2.%notDel%
			
			JOIN %table:SA1% SA1
			ON SA1.A1_FILIAL =  %xfilial:SA1% 
			AND SA1.A1_CGC  = SA2.A2_CGC
			AND SA1.A1_COD 	= %Exp:cCliente% 
			AND SA1.A1_LOJA between %Exp:cLoja%  and %Exp:IIF(Empty(cLoja),"ZZ",cLoja)%  				
			AND SA1.%notDel%
			                            
			LEFT JOIN %table:SC5% SC5  
			ON SC5.C5_FILIAL =  P01.P01_FILPED
			AND SC5.C5_NUM = P01_PEDVEN
			AND SC5.%notDel%
				
			WHERE
								
			SE2.E2_FILIAL = %xfilial:SE2% 
			AND SE2.E2_PREFIXO  =  %Exp:cPrfVerba%
			AND SE2.E2_NUM BETWEEN %Exp:' '% AND %Exp:'Z'%
			AND SE2.E2_PARCELA BETWEEN %Exp:' '% AND %Exp:'Z'%
			AND SE2.E2_TIPO BETWEEN %Exp:' '% AND %Exp:'Z'%
			AND SE2.E2_YVPC 	<> %Exp:' '% 
			AND SE2.E2_YVERVPC 	<> %Exp:' '% 
			AND SE2.%notDel%
			
			ORDER BY P01_CODIGO,P01_VERSAO
			
		EndSql
				
		oSection2:EndQuery()

		(AliasVERFN)->(dbGoTop())				
		
		If (AliasVERFN)->(!Eof())

			If oReport:nDevice <> 4
				oReport:SkipLine()
				oReport:SkipLine()
			EndIf
			
			oReport:oFontBody:Bold := .T.
			oReport:oFontBody:NHEIGHT:= nlNewTamF

			If oReport:nDevice <> 4
	
				oReport:Say(oReport:Row() ,1500,"Verba com Repasse Financeiro",,,)
				oReport:SkipLine()

			Else
				oReport:SkipLine()
				oReport:PrintText("Verba com Repasse Financeiro")

			EndIf
			
			oReport:oFontBody:NHEIGHT := nlTamFonte
			oReport:oFontBody:Bold := .F.
					
			// Encontro de Contas (NCC)
			While (AliasVERFN)->(!Eof()) 
				
				oSection2:Init()
				oSection2:PrintLine()

				nTotRepas	+= oSection2:Cell("P01_TOTVAL"):uprint
				nTotTit 	+= oSection2:Cell("E2_VALOR"):uprint
				nTotSaldo	+= oSection2:Cell("E2_SALDO"):uprint

				(AliasVERFN)->(dbSkip())
				
			EndDo
				
			oSection2:Finish()
			
		EndIf
		
		(AliasVERFN)->(dbCloseArea())
		
		If oReport:nDevice <> 4
			oReport:SkipLine()
			oReport:SkipLine()
		EndIf
		
		oReport:oFontBody:Bold := .T.
		oReport:oFontBody:NHEIGHT:= nlNewTamF
		
		
		If oReport:nDevice <> 4
		
			oReport:Say(oReport:Row() ,1500,"Saldo Encontro de Contas - Contratos com repasse Financeiro",,,)
			oReport:SkipLine()
		Else
			oReport:SkipLine()
			oReport:PrintText("Saldo Encontro de Contas - Contratos com repasse Financeiro")

		EndIf
		
		oReport:oFontBody:NHEIGHT := nlTamFonte
		oReport:oFontBody:Bold := .F.
		

		nPerAcert := 0
		
		oSection3:Init()	
		oSection3:Cell("TOTREPAS")	:SetValue(  nTotRepas)
		oSection3:Cell("TOTALTIT")	:SetValue(  nTotTit  )
		oSection3:Cell("SALDOABER")	:SetValue(  nTotSaldo)  
		oSection3:PrintLine()
		
		nTotGeral += nTotRepas
		
		oSection3:Finish()
		
		//Contratos VPC - Repasse Pedido de Venda

		oSection4:BeginQuery()
		
		clAliasSC5	:= GetNextAlias()
		
		BeginSql Alias clAliasSC5

			SELECT P01_CODIGO
					,P01_VERSAO
					,P01_DTVINI
					,P01_DTVFIM
					,P01_TPVPC
					,P01_STATUS
					,P01_REPASS
					,P01_TPFAT
					,P01_TOTPER
					,C5_FILIAL
					,C5_NUM
					,C5_EMISSAO	
					,A1_COD
					,A1_LOJA
					,C5_YDSCVER
					,A1_NREDUZ	
					,C5_SERIE
					,C5_NOTA
					,F2_EMISSAO
					,F2_VALBRUT
					
					
			FROM %table:P01% P01

			JOIN %table:SA1% SA1
			ON SA1.A1_FILIAL = %xfilial:SA1%  
			AND SA1.A1_COD = %Exp:cCliente%
			AND SA1.A1_LOJA between  %Exp:cLoja%  and %Exp:IIF(Empty(cLoja),"ZZ",cLoja)%  
			AND SA1.%notDel%
			
			LEFT JOIN %table:SC5% SC5
			ON SC5.C5_FILIAL = %xfilial:SC5%  
			AND SC5.C5_NUM between  %Exp:' '%  and %Exp:'Z'%  
			AND SC5.C5_CLIENTE = SA1.A1_COD
			AND SC5.C5_LOJACLI = SA1.A1_LOJA
			AND SC5.C5_YCODVPC = P01.P01_CODIGO
			AND SC5.C5_YVERVPC = P01.P01_VERSAO
			AND SC5.%notDel%
			
			LEFT JOIN %table:SF2% SF2
			ON SF2.F2_FILIAL = SC5.C5_FILIAL
			AND SF2.F2_SERIE = SC5.C5_SERIE
			AND SF2.F2_DOC = SC5.C5_NOTA
			AND SF2.F2_CLIENTE = SC5.C5_CLIENTE
			AND SF2.F2_LOJA = SC5.C5_LOJACLI
			AND SF2.%notDel%					
            
			WHERE P01.P01_FILIAL = %xfilial:p01% 
			AND P01.P01_CODIGO BETWEEN %Exp:' '% AND %Exp:'Z'% 
			AND P01.P01_VERSAO BETWEEN %Exp:' '% AND %Exp:'Z'% 
			AND P01.P01_TPCAD = %Exp:'1'% 
			AND P01.P01_REPASS = %Exp:'2'%
			AND P01.P01_DTVINI >= %Exp:DtoS(MV_PAR01)%
			AND P01.P01_DTVFIM <= %Exp:DtoS(MV_PAR02)%
			AND P01.P01_STSAPR = %Exp:'1'%
			AND P01.P01_CODCLI = SA1.A1_COD
			AND P01.P01_LOJCLI = SA1.A1_LOJA			
			AND P01.%notDel%
							
			ORDER BY P01_CODIGO ,P01_VERSAO			
		
		EndSql
		
		oSection4:EndQuery()

		(clAliasSC5)->(dbGoTop())

								
		If (clAliasSC5)->(!Eof())

			lMovContrat := .T.
			If oReport:nDevice <> 4
		  		oReport:SkipLine()
				oReport:SkipLine()
			EndIf
			oReport:oFontBody:Bold := .T.
			oReport:oFontBody:NHEIGHT:= nlNewTamF

			If oReport:nDevice <> 4
			
				oReport:Say(oReport:Row() ,1500,"VPC com repasse Pedido de Venda",,,)
				oReport:SkipLine()
				
			Else
				oReport:SkipLine()
				oReport:PrintText("VPC com repasse Pedido de Venda")
				
			EndIf
			
			oReport:oFontBody:NHEIGHT := nlTamFonte
			oReport:oFontBody:Bold := .F.
			
			While (clAliasSC5)->(!Eof())
			
		       	oSection4:Init()
				oSection4:PrintLine()
				
				nTotGeral += oSection4:Cell("C6_YVALVPC"):uprint
				
				(clAliasSC5)->(dbSkip())
			EndDo
		
	    EndIf

		oSection4:Finish()
	
		(clAliasSC5)->(dbCloseArea())
	    
	
   				// Verbas nos pedidos de Venda
		oSection5:BeginQuery()
		
		clAliasVPV	:= GetNextAlias()
		
		BeginSql Alias clAliasVPV
		
			SELECT 	P01_CODIGO
					,P01_VERSAO
					,P01_DTVINI
					,P01_DTVFIM
					,P01_TPVPC
					,P01_STATUS
					,P01_REPASS
					,P01_TPFAT
					,P01_FILPED
					,P01_PEDVEN
					,C5_EMISSAO
					,A1_COD
					,A1_LOJA
					,A1_NREDUZ
					,P01_TOTVAL
					,C5_SERIE
					,C5_NOTA	
					,F2_EMISSAO
					,F2_VALBRUT
					
			FROM %table:P01% P01

			JOIN %table:SA1% SA1
			ON SA1.A1_FILIAL = %xfilial:SA1%  
			AND SA1.A1_COD = %Exp:cCliente%
			AND SA1.A1_LOJA between %Exp:cLoja%  and %Exp:IIF(Empty(cLoja),"ZZ",cLoja)%  
			AND SA1.%notDel%
			
			JOIN %table:SC5% SC5
			ON SC5.C5_FILIAL = P01.P01_FILPED
			AND SC5.C5_NUM = P01.P01_PEDVEN
			AND SC5.C5_CLIENTE = SA1.A1_COD
			AND SC5.C5_LOJACLI = SA1.A1_LOJA
			AND SC5.C5_YCODVPC = P01.P01_CODIGO
			AND SC5.C5_YVERVPC = P01.P01_VERSAO
			AND SC5.%notDel%
			
			LEFT JOIN %table:SF2% SF2
			ON SF2.F2_FILIAL = SC5.C5_FILIAL
			AND SF2.F2_SERIE = SC5.C5_SERIE
			AND SF2.F2_DOC = SC5.C5_NOTA
			AND SF2.F2_CLIENTE = SC5.C5_CLIENTE
			AND SF2.F2_LOJA = SC5.C5_LOJACLI
			AND SF2.%notDel%
					            
			WHERE 
				P01.P01_FILIAL =  %xfilial:P01%  
				AND P01.P01_CODIGO BETWEEN %Exp:' '% AND %Exp:'Z'% 
				AND P01.P01_VERSAO BETWEEN %Exp:' '% AND %Exp:'Z'% 
				AND P01.P01_TPCAD = %Exp:'2'% 
				AND P01.P01_STSAPR = %Exp:'1'% 
				AND P01.P01_REPASS = %Exp:'2'%
				AND P01.P01_DTVINI >= %Exp:DtoS(MV_PAR01)%  
				AND P01.P01_DTVFIM <= %Exp:DtoS(MV_PAR02)% 
				AND P01.%notDel%
							
			ORDER BY P01_CODIGO ,P01_VERSAO
			
		EndSql
				
		oSection5:EndQuery()

		(clAliasVPV)->(dbGoTop())
	
        If (clAliasVPV)->(!Eof())
			If oReport:nDevice <> 4
				oReport:SkipLine()
				oReport:SkipLine()	
			EndIf
			oReport:oFontBody:Bold := .T.
			oReport:oFontBody:NHEIGHT:= nlNewTamF

			If oReport:nDevice <> 4
			
				oReport:Say(oReport:Row() ,1500,"Verba com repasse Pedido de Venda",,,)
				oReport:SkipLine()	
				
			Else
				oReport:SkipLine()
				oReport:PrintText("Verba com repasse Pedido de Venda")

			EndIf
			oReport:oFontBody:NHEIGHT := nlTamFonte
			oReport:oFontBody:Bold := .F.
					
			While (clAliasVPV)->(!Eof()) 
				
				oSection5:Init()
				oSection5:PrintLine()
				
				nTotGeral += oSection5:Cell("P01_TOTVAL"):uprint
				
				(clAliasVPV)->(dbSkip())
				
			EndDo
			
			oSection5:Finish()
			
        EndIf
        
        (clAliasVPV)->(dbCloseArea())
		        
		If oReport:nDevice <> 4
			oReport:SkipLine()
			oReport:SkipLine()
        EndIf
		oReport:oFontBody:Bold := .T.
		oReport:oFontBody:NHEIGHT:= nlNewTamF

		If oReport:nDevice <> 4
			oReport:Say(oReport:Row() ,1500,"Total Geral do Cliente",,,)
			oReport:SkipLine()
		Else
			oReport:SkipLine()
			oReport:PrintText("Total Geral do Cliente")
		EndIf
		
		oReport:oFontBody:NHEIGHT := nlTamFonte
		oReport:oFontBody:Bold := .F.

		nPerAcert := 0
		oSection6:Init()	
		oSection6:Cell("TOTREPAS")	:SetValue(  nTotGeral)
		oSection6:PrintLine()
		
		nGeralRel += nTotGeral
		
		oSection6:Finish()
		
		(clAlias)->(dbSkip())

		If cCliente+cLoja <> Alltrim((clAlias)->P01_CODCLI) + Alltrim((clAlias)->P01_LOJCLI)
		
			If MV_PAR07 == 1
				oReport:EndPage()
			EndIf
			
		EndIf
		
	EndDo	

	oReport:oFontBody:Bold := .T.
	oReport:oFontBody:NHEIGHT:= nlNewTamF

	
	If oReport:nDevice <> 4
		oReport:Say(oReport:Row() ,1500,"Total Geral Relat๓rio",,,)
		oReport:SkipLine()
	Else
		oReport:SkipLine()
		oReport:SkipLine()
		oReport:SkipLine()
		oReport:PrintText("Total Geral Relat๓rio")
	EndIf

	oReport:oFontBody:NHEIGHT := nlTamFonte
	oReport:oFontBody:Bold := .F.		


	nPerAcert := 0
	oSection7:Init()	
	oSection7:Cell("TOTREPAS")	:SetValue(  nGeralRel)
	oSection7:PrintLine()
	
	oSection7:Finish()	
	
Return
  
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFGetQry   บAutor  ณHermes Ferreira     บ Data ณ  23/11/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณQuery Principal do relatorio		 			              บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Nc Games						                              บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function FGetQry()

	Local cQry := ""

	//ErrorBlock( SysErrorBlock( { | e | ErrorDialog( e ) } ) )

	cQry := " SELECT "				+ clr
	cQry += " P01_CODCLI "			+ clr
	cQry += " ,P01_LOJCLI "			+ clr
	cQry += " ,A1_NOME "			+ clr

	cQry += " FROM "+RetSqlName("P01")+" P01 "	  					 				+ clr

	cQry += " JOIN "+RetSqlName("SA1")+" SA1 "	  					 				+ clr
	cQry += " ON SA1.A1_FILIAL = '"+xFilial("SA1")+"'"								+ clr
	cQry += " AND SA1.A1_COD = P01_CODCLI "				  		  					+ clr
	cQry += " AND SA1.A1_LOJA = P01_LOJCLI "	   									+ clr
	cQry += " AND SA1.D_E_L_E_T_= ' '"												+ clr

	cQry += " WHERE P01.P01_FILIAL = '"+xFilial("P01")+"'"							+ clr
	cQry += " AND P01.P01_CODCLI BETWEEN '"+MV_PAR03+"' AND '"+MV_PAR05+"' "		+ clr
	cQry += " AND P01.P01_LOJCLI BETWEEN '"+MV_PAR04+"' AND '"+MV_PAR06+"' "		+ clr
	cQry += " AND P01.P01_DTVINI >= '"+DtoS(MV_PAR01)+"'" 							+ clr
	cQry += " AND P01.P01_DTVFIM <= '"+DtoS(MV_PAR02)+"'"							+ clr
	cQry += " AND P01.P01_STSAPR = '1'"												+ clr
	cQry += " AND P01_CODCLI <> ' ' "												+ clr
	cQry += " AND P01_LOJCLI <> ' ' "												+ clr
	cQry += " AND P01.D_E_L_E_T_ = ' ' "								   			+ clr
	
	
	cQry += " GROUP BY  P01_CODCLI  ,P01_LOJCLI ,A1_NOME "				 			+ clr
	
	// Verifica as apura็๕es geradas pelo contrato de grupo de clientes
	cQry += " UNION "  						 								 		+ clr
	
	
	cQry += " SELECT A1_COD AS P01_CODCLI "	 					 					+ clr
	cQry += " , A1_LOJA AS P01_LOJCLI	"	 					 					+ clr
	cQry += " ,A1_NOME "	 														+ clr
	cQry += " FROM "+RetSqlName("SA1")+" SA1 "										+ clr
	cQry += " WHERE A1_FILIAL = '"+xFilial("SA1")+"'"								+ clr
	cQry += " AND A1_GRPVEN <> ' '"													+ clr
	cQry += " AND EXISTS (       SELECT P01_GRPCLI "								+ clr
	cQry += "       FROM "+RetSqlName("P01")+" P01 "								+ clr
	       
	cQry += "       JOIN "+RetSqlName("P04")+" P04 "								+ clr
	cQry += "       ON P04_FILIAL = '"+xFilial("P04")+"'"							+ clr
	cQry += "       AND P04_CODVPC = P01_CODIGO "									+ clr
	cQry += "       AND P04_VERVPC = P01_VERSAO "									+ clr
	cQry += "       AND P04_FECHAM <> ' ' "											+ clr
	cQry += "       AND P04.D_E_L_E_T_= ' ' "										+ clr
	       
	cQry += "       WHERE P01.P01_FILIAL = '"+xFilial("P01")+"' "					+ clr
	cQry += " 		AND P01.P01_CODCLI BETWEEN '"+MV_PAR03+"' AND '"+MV_PAR05+"' "	+ clr
	cQry += " 		AND P01.P01_LOJCLI BETWEEN '"+MV_PAR04+"' AND '"+MV_PAR06+"' "	+ clr
	cQry += " 		AND P01.P01_DTVINI >= '"+DtoS(MV_PAR01)+"'" 					+ clr
	cQry += " 		AND P01.P01_DTVFIM <= '"+DtoS(MV_PAR02)+"'"						+ clr
	cQry += " 		AND P01.P01_STSAPR = '1'"										+ clr
	cQry += "       AND P01_GRPCLI = A1_GRPVEN "									+ clr
	cQry += "       AND P01.D_E_L_E_T_ = ' '  "										+ clr
	cQry += " ) "	   																+ clr
	cQry += " AND SA1.D_E_L_E_T_ = ' ' "											+ clr
	
	cQry += " GROUP BY  A1_COD  ,A1_LOJA , A1_NOME "				 			+ clr
	
	// Verifica os pedidos de vendas geradas pelo contrato de grupo de clientes
	cQry += " UNION "  						 								 		+ clr
	
	cQry += " SELECT A1_COD AS P01_CODCLI "	 					 					+ clr
	cQry += " , A1_LOJA AS P01_LOJCLI	"	 					 					+ clr
	cQry += " ,A1_NOME "	 														+ clr
	cQry += " FROM "+RetSqlName("SA1")+" SA1 "										+ clr
	cQry += " WHERE A1_FILIAL = '"+xFilial("SA1")+"'"								+ clr
	cQry += " AND A1_GRPVEN <> ' '"													+ clr
	cQry += " AND EXISTS (       SELECT P01_GRPCLI "								+ clr
	cQry += "       FROM "+RetSqlName("P01")+" P01 "								+ clr
       	       
	cQry += "       JOIN "+RetSqlName("SC5")+" SC5 "								+ clr
	cQry += "       ON C5_FILIAL = '"+xFilial("SC5")+"'"							+ clr
	cQry += "       AND C5_YCODVPC = P01_CODIGO "									+ clr
	cQry += "       AND C5_YVERVPC = P01_VERSAO "									+ clr
	cQry += "       AND SC5.D_E_L_E_T_= ' ' "										+ clr
	       
	cQry += "       WHERE P01.P01_FILIAL = '"+xFilial("P01")+"' "					+ clr
	cQry += " 		AND P01.P01_CODCLI BETWEEN '"+MV_PAR03+"' AND '"+MV_PAR05+"' "	+ clr
	cQry += " 		AND P01.P01_LOJCLI BETWEEN '"+MV_PAR04+"' AND '"+MV_PAR06+"' "	+ clr
	cQry += " 		AND P01.P01_DTVINI >= '"+DtoS(MV_PAR01)+"'" 					+ clr
	cQry += " 		AND P01.P01_DTVFIM <= '"+DtoS(MV_PAR02)+"'"						+ clr
	cQry += " 		AND P01.P01_STSAPR = '1'"										+ clr
	cQry += "       AND P01_GRPCLI = A1_GRPVEN "									+ clr
	cQry += "       AND P01.D_E_L_E_T_ = ' '  "										+ clr
	cQry += " ) "	   																+ clr
	cQry += " AND SA1.D_E_L_E_T_ = ' ' "											+ clr	
	
	cQry += " GROUP BY  A1_COD  ,A1_LOJA , A1_NOME "				 			+ clr
	
	// Verifica as apura็๕es  geradas pelo contrato de cliente sem informar a loja ( serve para todas as lojas )
	cQry += " UNION "  						 								 		+ clr
	
	cQry += " SELECT A1_COD AS P01_CODCLI "	 					 					+ clr
	cQry += " , A1_LOJA AS P01_LOJCLI	"	 					 					+ clr
	cQry += " ,A1_NOME "	 														+ clr
	cQry += " FROM "+RetSqlName("SA1")+" SA1 "				 						+ clr
	cQry += " WHERE A1_FILIAL = '"+xFilial("SA1")+"'"								+ clr

	cQry += " AND EXISTS (       SELECT P04_CLIENT"									+ clr
	cQry += "        FROM "+RetSqlName("P04")+" P04 "								+ clr
       
	cQry += "        JOIN "+RetSqlName("P01")+" P01 "								+ clr
	cQry += "        ON P01_FILIAL = '"+xFilial("P01")+"'"							+ clr
	cQry += "        AND P01_CODIGO = P04_CODVPC"									+ clr
	cQry += "        AND P01_VERSAO = P04_VERVPC "									+ clr
	cQry += "		 AND P01.P01_DTVINI >= '"+DtoS(MV_PAR01)+"'" 					+ clr
	cQry += " 		 AND P01.P01_DTVFIM <= '"+DtoS(MV_PAR02)+"'"					+ clr
	cQry += " 		 AND P01.P01_STSAPR = '1'"										+ clr
	cQry += "        AND P01.P01_CODCLI <> ' '"										+ clr
	cQry += "        AND P01.P01_LOJCLI = ' '"										+ clr
	cQry += "        AND P01.D_E_L_E_T_= ' '"										+ clr
       
	cQry += "        WHERE P04.P04_FILIAL = '"+xFilial("P04")+"'"					+ clr
	cQry += "        AND P04_CLIENT = A1_COD "										+ clr
	cQry += "        AND P04_LOJCLI = A1_LOJA "										+ clr
	cQry += "        AND P04_FECHAM <> ' ' "										+ clr
	cQry += "        AND P04.D_E_L_E_T_ = ' ' "										+ clr
	cQry += "         )"	  														+ clr
	cQry += " AND SA1.D_E_L_E_T_ = ' ' "											+ clr
	cQry += " GROUP BY  A1_COD  ,A1_LOJA , A1_NOME "				 			+ clr
	

	// Verifica as vendas  geradas pelo contrato de cliente sem informar a loja ( serve para todas as lojas )
	cQry += " UNION "  						 								 		+ clr
	
	cQry += " SELECT A1_COD AS P01_CODCLI "	 					 					+ clr
	cQry += " , A1_LOJA AS P01_LOJCLI	"	 					 					+ clr
	cQry += " ,A1_NOME "	 														+ clr
	cQry += " FROM "+RetSqlName("SA1")+" SA1 "				 						+ clr
	cQry += " WHERE A1_FILIAL = '"+xFilial("SA1")+"'"								+ clr

	cQry += " AND EXISTS (       SELECT C5_CLIENTE "								+ clr
	cQry += "        FROM "+RetSqlName("SC5")+" SC5 "								+ clr
       
	cQry += "        JOIN "+RetSqlName("P01")+" P01 "								+ clr
	cQry += "        ON P01_FILIAL = '"+xFilial("P01")+"'"							+ clr
	cQry += "        AND P01_CODIGO = C5_YCODVPC "									+ clr
	cQry += "        AND P01_VERSAO = C5_YVERVPC "									+ clr
	cQry += "		 AND P01.P01_DTVINI >= '"+DtoS(MV_PAR01)+"'" 					+ clr
	cQry += " 		 AND P01.P01_DTVFIM <= '"+DtoS(MV_PAR02)+"'"					+ clr
	cQry += " 		 AND P01.P01_STSAPR = '1'"										+ clr
	cQry += "        AND P01.P01_CODCLI <> ' '"										+ clr
	cQry += "        AND P01.P01_LOJCLI = ' '"										+ clr
	cQry += "        AND P01.D_E_L_E_T_= ' '"										+ clr
       
	cQry += "        WHERE SC5.C5_FILIAL = '"+xFilial("SC5")+"'"					+ clr
	cQry += "        AND SC5.C5_CLIENTE = A1_COD "									+ clr
	cQry += "        AND SC5.C5_LOJACLI = A1_LOJA "									+ clr
	cQry += "        AND SC5.D_E_L_E_T_ = ' ' "										+ clr
	cQry += "         )"	  														+ clr
	cQry += " AND SA1.D_E_L_E_T_ = ' ' "											+ clr
	cQry += " GROUP BY  A1_COD  ,A1_LOJA , A1_NOME "				 			+ clr
	
	cQry += " ORDER BY P01_CODCLI,P01_LOJCLI  "		   								+ clr
	
	TcQuery cQry New Alias &(clAlias)
	TCSetField((clAlias),"P01_DTCRIA"	,"D",TamSx3("P01_DTCRIA")[1],TamSx3("P01_DTCRIA")[2]	)
	TCSetField((clAlias),"P01_DTVINI"	,"D",TamSx3("P01_DTVFIM")[1],TamSx3("P01_DTVFIM")[2]	)
	TCSetField((clAlias),"P01_DTVFIM"	,"D",TamSx3("P01_DTVFIM")[1],TamSx3("P01_DTVFIM")[2]	)
	TCSetField((clAlias),"P01_TOTPER"	,"N",TamSx3("P01_TOTPER")[1],TamSx3("P01_TOTPER")[2]	)
	TCSetField((clAlias),"P01_PREVI"	,"N",TamSx3("P01_PREVI")[1]	,TamSx3("P01_PREVI")[2]		)

		
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCRL1SX1  บAutor  ณHermes Ferreira     บ Data ณ  09/11/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCria o grupo de perguntas para o relatorio gerencial VPC e  บฑฑ
ฑฑบ          ณverba                                                       บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Nc Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function NCRL1SX1( clPerg )

Local alAreaAtu	:= GetArea()
Local alAux		:= {}

//ErrorBlock( SysErrorBlock( { | e | ErrorDialog( e ) } ) )
	
aAdd( alAux, {	"01",;		  					// 01-Ordem da Pergunta (2)
"Da Data",;					  					// 02-Descri็ใo em Portugues (30)
"Da Data",;				  						// 03-Descri็ใo em Espanhol (30)
"Da Data",;				  						// 04-Descri็ใo em Ingles (30)
"mv_ch1",;							  			// 05-Nome da Variแvel (6)
"D",;											// 06-Tipo da Variแvel (1)
8,;												// 07-Tamanho da Variแvel (2)
0,;												// 08-Casas Decimais da Variแvel (1)
0,;												// 09-Elemento pr้-selecionado, quando Choice (1)
"G",;											// 10-Tipo de Exibi็ใo (C=Choice,G=Get,K=CheckBox)(1)
"",;											// 11-Expressใo de Valida็ใo da Variแvel (60)
"",;											// 12-Consulta Padrใo para a Variแvel (6)
"",;											// 13-Identifica de a versใo ้ Pyme (1)
"",;											// 14-Grupo de Configura็ใo do Tamanho (3)
"@!",;											// 15-Picture para a variแvel (40)
"",;											// 16-Identificador de Filtro da variแvel (6)
"",;											// 17-Nome do Help para o grupo de perguntas (14)
"MV_PAR01",;									// 18-Nome da variแvel (15)
"",;											// 19-Conte๚do da Variแvel (15)
{ ;
"",;											// 20,01-1a. Defini็ใo em Portugues (15)
"",;											// 20,02-1a. Defini็ใo em Espanhol (15)
"",;											// 20,03-1a. Defini็ใo em Ingles (15)
"",;											// 20,04-2a. Defini็ใo em Portugues (15)
"",;											// 20,05-2a. Defini็ใo em Espanhol (15)
"",;											// 20,06-2a. Defini็ใo em Ingles (15)
"",;											// 20,07-3a. Defini็ใo em Portugues (15)
"",;											// 20,08-3a. Defini็ใo em Espanhol (15)
"",;											// 20,09-3a. Defini็ใo em Ingles (15)
"",;											// 20,10-4a. Defini็ใo em Portugues (15)
"",;											// 20,11-4a. Defini็ใo em Espanhol (15)
"",;											// 20,12-4a. Defini็ใo em Ingles (15)
"",;											// 20,13-5a. Defini็ใo em Portugues (15)
"",;											// 20,14-5a. Defini็ใo em Espanhol (15)
"" },;									   		// 20,15-5a. Defini็ใo em Ingles (15)
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
"Ate Data",;					  				// 02-Descri็ใo em Portugues (30)
"Ate Data",;				  					// 03-Descri็ใo em Espanhol (30)
"Ate Data",;				  					// 04-Descri็ใo em Ingles (30)
"mv_ch2",;							  			// 05-Nome da Variแvel (6)
"D",;											// 06-Tipo da Variแvel (1)
8,;												// 07-Tamanho da Variแvel (2)
0,;												// 08-Casas Decimais da Variแvel (1)
0,;												// 09-Elemento pr้-selecionado, quando Choice (1)
"G",;											// 10-Tipo de Exibi็ใo (C=Choice,G=Get,K=CheckBox)(1)
"",;											// 11-Expressใo de Valida็ใo da Variแvel (60)
"",;											// 12-Consulta Padrใo para a Variแvel (6)
"",;											// 13-Identifica de a versใo ้ Pyme (1)
"",;											// 14-Grupo de Configura็ใo do Tamanho (3)
"@!",;											// 15-Picture para a variแvel (40)
"",;											// 16-Identificador de Filtro da variแvel (6)
"",;											// 17-Nome do Help para o grupo de perguntas (14)
"MV_PAR02",;									// 18-Nome da variแvel (15)
"",;											// 19-Conte๚do da Variแvel (15)
{ ;
"",;											// 20,01-1a. Defini็ใo em Portugues (15)
"",;											// 20,02-1a. Defini็ใo em Espanhol (15)
"",;											// 20,03-1a. Defini็ใo em Ingles (15)
"",;											// 20,04-2a. Defini็ใo em Portugues (15)
"",;											// 20,05-2a. Defini็ใo em Espanhol (15)
"",;											// 20,06-2a. Defini็ใo em Ingles (15)
"",;											// 20,07-3a. Defini็ใo em Portugues (15)
"",;											// 20,08-3a. Defini็ใo em Espanhol (15)
"",;											// 20,09-3a. Defini็ใo em Ingles (15)
"",;											// 20,10-4a. Defini็ใo em Portugues (15)
"",;											// 20,11-4a. Defini็ใo em Espanhol (15)
"",;											// 20,12-4a. Defini็ใo em Ingles (15)
"",;											// 20,13-5a. Defini็ใo em Portugues (15)
"",;											// 20,14-5a. Defini็ใo em Espanhol (15)
"" },;									   		// 20,15-5a. Defini็ใo em Ingles (15)
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
"Do Cliente",;					  				// 02-Descri็ใo em Portugues (30)
"Do Cliente",;				  					// 03-Descri็ใo em Espanhol (30)
"Do Cliente",;				  					// 04-Descri็ใo em Ingles (30)
"mv_ch3",;							  			// 05-Nome da Variแvel (6)
"C",;											// 06-Tipo da Variแvel (1)
TamSx3("A1_COD")[1],;							// 07-Tamanho da Variแvel (2)
TamSx3("A1_COD")[2],;							// 08-Casas Decimais da Variแvel (1)
0,;												// 09-Elemento pr้-selecionado, quando Choice (1)
"G",;											// 10-Tipo de Exibi็ใo (C=Choice,G=Get,K=CheckBox)(1)
"",;											// 11-Expressใo de Valida็ใo da Variแvel (60)
"SA1",;											// 12-Consulta Padrใo para a Variแvel (6)
"",;											// 13-Identifica de a versใo ้ Pyme (1)
"",;											// 14-Grupo de Configura็ใo do Tamanho (3)
"@!",;											// 15-Picture para a variแvel (40)
"",;											// 16-Identificador de Filtro da variแvel (6)
"",;											// 17-Nome do Help para o grupo de perguntas (14)
"MV_PAR03",;									// 18-Nome da variแvel (15)
"",;											// 19-Conte๚do da Variแvel (15)
{ ;
"",;											// 20,01-1a. Defini็ใo em Portugues (15)
"",;											// 20,02-1a. Defini็ใo em Espanhol (15)
"",;											// 20,03-1a. Defini็ใo em Ingles (15)
"",;											// 20,04-2a. Defini็ใo em Portugues (15)
"",;											// 20,05-2a. Defini็ใo em Espanhol (15)
"",;											// 20,06-2a. Defini็ใo em Ingles (15)
"",;											// 20,07-3a. Defini็ใo em Portugues (15)
"",;											// 20,08-3a. Defini็ใo em Espanhol (15)
"",;											// 20,09-3a. Defini็ใo em Ingles (15)
"",;											// 20,10-4a. Defini็ใo em Portugues (15)
"",;											// 20,11-4a. Defini็ใo em Espanhol (15)
"",;											// 20,12-4a. Defini็ใo em Ingles (15)
"",;											// 20,13-5a. Defini็ใo em Portugues (15)
"",;											// 20,14-5a. Defini็ใo em Espanhol (15)
"" },;									   		// 20,15-5a. Defini็ใo em Ingles (15)
{ { ;
"Informe o c๓digo inicial do cliente     ",;
"                                        ",;	// 21,01-Array com os textos de help em Portugues
"										 " ;
}, { ;
"Informe o c๓digo inicial do cliente     ",;
"                                        ",;	// 21,02-Array com os textos de help em Espanhol
"										 " ;
}, { ;
"Informe o c๓digo inicial do cliente     ",;
"                                        ",;	// 21,02-Array com os textos de help em Ingles
"										 " ;
} } } )

aAdd( alAux, {	"04",;		  									// 01-Ordem da Pergunta (2)
"Da Loja",;						  				// 02-Descri็ใo em Portugues (30)
"Da Loja",;				  						// 03-Descri็ใo em Espanhol (30)
"Da Loja",;				  						// 04-Descri็ใo em Ingles (30)
"mv_ch4",;							  			// 05-Nome da Variแvel (6)
"C",;											// 06-Tipo da Variแvel (1)
TamSx3("A1_LOJA")[1],;							// 07-Tamanho da Variแvel (2)
TamSx3("A1_LOJA")[2],;							// 08-Casas Decimais da Variแvel (1)
0,;												// 09-Elemento pr้-selecionado, quando Choice (1)
"G",;											// 10-Tipo de Exibi็ใo (C=Choice,G=Get,K=CheckBox)(1)
"",;											// 11-Expressใo de Valida็ใo da Variแvel (60)
"",;											// 12-Consulta Padrใo para a Variแvel (6)
"",;											// 13-Identifica de a versใo ้ Pyme (1)
"",;											// 14-Grupo de Configura็ใo do Tamanho (3)
"@!",;											// 15-Picture para a variแvel (40)
"",;											// 16-Identificador de Filtro da variแvel (6)
"",;											// 17-Nome do Help para o grupo de perguntas (14)
"MV_PAR04",;									// 18-Nome da variแvel (15)
"",;											// 19-Conte๚do da Variแvel (15)
{ ;
"",;											// 20,01-1a. Defini็ใo em Portugues (15)
"",;											// 20,02-1a. Defini็ใo em Espanhol (15)
"",;											// 20,03-1a. Defini็ใo em Ingles (15)
"",;											// 20,04-2a. Defini็ใo em Portugues (15)
"",;											// 20,05-2a. Defini็ใo em Espanhol (15)
"",;											// 20,06-2a. Defini็ใo em Ingles (15)
"",;											// 20,07-3a. Defini็ใo em Portugues (15)
"",;											// 20,08-3a. Defini็ใo em Espanhol (15)
"",;											// 20,09-3a. Defini็ใo em Ingles (15)
"",;											// 20,10-4a. Defini็ใo em Portugues (15)
"",;											// 20,11-4a. Defini็ใo em Espanhol (15)
"",;											// 20,12-4a. Defini็ใo em Ingles (15)
"",;											// 20,13-5a. Defini็ใo em Portugues (15)
"",;											// 20,14-5a. Defini็ใo em Espanhol (15)
"" },;									   		// 20,15-5a. Defini็ใo em Ingles (15)
{ { ;
"Informe o c๓digo inicial da loja do clie",;
"nte                                     ",;	// 21,01-Array com os textos de help em Portugues
"										 " ;
}, { ;
"Informe o c๓digo inicial da loja do clie",;
"nte                                     ",;	// 21,02-Array com os textos de help em Espanhol
"										 " ;
}, { ;
"Informe o c๓digo inicial da loja do clie",;
"nte                                     ",;	// 21,02-Array com os textos de help em Ingles
"										 " ;
} } } )

aAdd( alAux, {	"05",;		  									// 01-Ordem da Pergunta (2)
"At้ o Cliente",;					  			// 02-Descri็ใo em Portugues (30)
"At้ o Cliente",;				  					// 03-Descri็ใo em Espanhol (30)
"At้ o Cliente",;				  					// 04-Descri็ใo em Ingles (30)
"mv_ch5",;							  			// 05-Nome da Variแvel (6)
"C",;											// 06-Tipo da Variแvel (1)
TamSx3("A1_COD")[1],;							// 07-Tamanho da Variแvel (2)
TamSx3("A1_COD")[2],;							// 08-Casas Decimais da Variแvel (1)
0,;												// 09-Elemento pr้-selecionado, quando Choice (1)
"G",;											// 10-Tipo de Exibi็ใo (C=Choice,G=Get,K=CheckBox)(1)
"",;		  									// 11-Expressใo de Valida็ใo da Variแvel (60)
"SA1",;											// 12-Consulta Padrใo para a Variแvel (6)
"",;											// 13-Identifica de a versใo ้ Pyme (1)
"",;											// 14-Grupo de Configura็ใo do Tamanho (3)
"@!",;											// 15-Picture para a variแvel (40)
"",;											// 16-Identificador de Filtro da variแvel (6)
"",;											// 17-Nome do Help para o grupo de perguntas (14)
"MV_PAR05",;									// 18-Nome da variแvel (15)
"",;											// 19-Conte๚do da Variแvel (15)
{ ;
"",;											// 20,01-1a. Defini็ใo em Portugues (15)
"",;											// 20,02-1a. Defini็ใo em Espanhol (15)
"",;											// 20,03-1a. Defini็ใo em Ingles (15)
"",;											// 20,04-2a. Defini็ใo em Portugues (15)
"",;											// 20,05-2a. Defini็ใo em Espanhol (15)
"",;											// 20,06-2a. Defini็ใo em Ingles (15)
"",;											// 20,07-3a. Defini็ใo em Portugues (15)
"",;											// 20,08-3a. Defini็ใo em Espanhol (15)
"",;											// 20,09-3a. Defini็ใo em Ingles (15)
"",;											// 20,10-4a. Defini็ใo em Portugues (15)
"",;											// 20,11-4a. Defini็ใo em Espanhol (15)
"",;											// 20,12-4a. Defini็ใo em Ingles (15)
"",;											// 20,13-5a. Defini็ใo em Portugues (15)
"",;											// 20,14-5a. Defini็ใo em Espanhol (15)
"" },;									   		// 20,15-5a. Defini็ใo em Ingles (15)
{ { ;
"Informe o c๓digo final do cliente       ",;
"                                        ",;	// 21,01-Array com os textos de help em Portugues
"										 " ;
}, { ;
"Informe o c๓digo final do cliente       ",;
"                                        ",;	// 21,02-Array com os textos de help em Espanhol
"										 " ;
}, { ;
"Informe o c๓digo final do cliente       ",;
"                                        ",;	// 21,02-Array com os textos de help em Ingles
"										 " ;
} } } )

aAdd( alAux, {	"06",;		  									// 01-Ordem da Pergunta (2)
"Ate a Loja",;						  				// 02-Descri็ใo em Portugues (30)
"Ate a Loja",;				  						// 03-Descri็ใo em Espanhol (30)
"Ate a Loja",;				  						// 04-Descri็ใo em Ingles (30)
"mv_ch6",;							  			// 05-Nome da Variแvel (6)
"C",;											// 06-Tipo da Variแvel (1)
TamSx3("A1_LOJA")[1],;							// 07-Tamanho da Variแvel (2)
TamSx3("A1_LOJA")[2],;							// 08-Casas Decimais da Variแvel (1)
0,;												// 09-Elemento pr้-selecionado, quando Choice (1)
"G",;											// 10-Tipo de Exibi็ใo (C=Choice,G=Get,K=CheckBox)(1)
"",;											// 11-Expressใo de Valida็ใo da Variแvel (60)
"",;											// 12-Consulta Padrใo para a Variแvel (6)
"",;											// 13-Identifica de a versใo ้ Pyme (1)
"",;											// 14-Grupo de Configura็ใo do Tamanho (3)
"@!",;											// 15-Picture para a variแvel (40)
"",;											// 16-Identificador de Filtro da variแvel (6)
"",;											// 17-Nome do Help para o grupo de perguntas (14)
"MV_PAR06",;									// 18-Nome da variแvel (15)
"",;											// 19-Conte๚do da Variแvel (15)
{ ;
"",;											// 20,01-1a. Defini็ใo em Portugues (15)
"",;											// 20,02-1a. Defini็ใo em Espanhol (15)
"",;											// 20,03-1a. Defini็ใo em Ingles (15)
"",;											// 20,04-2a. Defini็ใo em Portugues (15)
"",;											// 20,05-2a. Defini็ใo em Espanhol (15)
"",;											// 20,06-2a. Defini็ใo em Ingles (15)
"",;											// 20,07-3a. Defini็ใo em Portugues (15)
"",;											// 20,08-3a. Defini็ใo em Espanhol (15)
"",;											// 20,09-3a. Defini็ใo em Ingles (15)
"",;											// 20,10-4a. Defini็ใo em Portugues (15)
"",;											// 20,11-4a. Defini็ใo em Espanhol (15)
"",;											// 20,12-4a. Defini็ใo em Ingles (15)
"",;											// 20,13-5a. Defini็ใo em Portugues (15)
"",;											// 20,14-5a. Defini็ใo em Espanhol (15)
"" },;									   		// 20,15-5a. Defini็ใo em Ingles (15)
{ { ;
"Informe o c๓digo final da loja do client",;
"e                                       ",;	// 21,01-Array com os textos de help em Portugues
"										 " ;
}, { ;
"Informe o c๓digo final da loja do client",;
"e                                       ",;	// 21,02-Array com os textos de help em Espanhol
"										 " ;
}, { ;
"Informe o c๓digo final da loja do client",;
"e                                       ",;	// 21,02-Array com os textos de help em Ingles
"										 " ;
} } } )

 
aAdd( alAux, {	"07",;							// 01-Ordem da Pergunta (2)
"Quebra Pแgina por Cliente",;			  		// 02-Descri็ใo em Portugues (30)
"Quebra Pแgina por Cliente",;	  				// 03-Descri็ใo em Espanhol (30)
"Quebra Pแgina por Cliente",;	  				// 04-Descri็ใo em Ingles (30)
"mv_ch7",;							  			// 05-Nome da Variแvel (6)
"N",;											// 06-Tipo da Variแvel (1)
1,;												// 07-Tamanho da Variแvel (2)
0,;												// 08-Casas Decimais da Variแvel (1)
0,;												// 09-Elemento pr้-selecionado, quando Choice (1)
"C",;											// 10-Tipo de Exibi็ใo (C=Choice,G=Get,K=CheckBox)(1)
"",;											// 11-Expressใo de Valida็ใo da Variแvel (60)
"",;											// 12-Consulta Padrใo para a Variแvel (6)
"",;											// 13-Identifica de a versใo ้ Pyme (1)
"",;											// 14-Grupo de Configura็ใo do Tamanho (3)
"@!",;											// 15-Picture para a variแvel (40)
"",;											// 16-Identificador de Filtro da variแvel (6)
"",;											// 17-Nome do Help para o grupo de perguntas (14)
"MV_PAR07",;									// 18-Nome da variแvel (15)
"",;											// 19-Conte๚do da Variแvel (15)
{ ;
"Sim",;											// 20,01-1a. Defini็ใo em Portugues (15)
"Sim",;											// 20,02-1a. Defini็ใo em Espanhol (15)
"Sim",;											// 20,03-1a. Defini็ใo em Ingles (15)
"Nใo",;											// 20,04-2a. Defini็ใo em Portugues (15)
"Nใo",;											// 20,05-2a. Defini็ใo em Espanhol (15)
"Nใo",;											// 20,06-2a. Defini็ใo em Ingles (15)
"",;											// 20,07-3a. Defini็ใo em Portugues (15)
"",;											// 20,08-3a. Defini็ใo em Espanhol (15)
"",;											// 20,09-3a. Defini็ใo em Ingles (15)
"",;											// 20,10-4a. Defini็ใo em Portugues (15)
"",;											// 20,11-4a. Defini็ใo em Espanhol (15)
"",;											// 20,12-4a. Defini็ใo em Ingles (15)
"",;											// 20,13-5a. Defini็ใo em Portugues (15)
"",;											// 20,14-5a. Defini็ใo em Espanhol (15)
"" },;									   		// 20,15-5a. Defini็ใo em Ingles (15)
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
"Analitico/Sintetico",;	 				  		// 02-Descri็ใo em Portugues (30)
"Analitico/Sintetico",;	 	 					// 03-Descri็ใo em Espanhol (30)
"Analitico/Sintetico",;	 	 					// 04-Descri็ใo em Ingles (30)
"mv_ch8",;							  			// 05-Nome da Variแvel (6)
"N",;											// 06-Tipo da Variแvel (1)
1,;												// 07-Tamanho da Variแvel (2)
0,;												// 08-Casas Decimais da Variแvel (1)
0,;												// 09-Elemento pr้-selecionado, quando Choice (1)
"C",;											// 10-Tipo de Exibi็ใo (C=Choice,G=Get,K=CheckBox)(1)
"",;											// 11-Expressใo de Valida็ใo da Variแvel (60)
"",;											// 12-Consulta Padrใo para a Variแvel (6)
"",;											// 13-Identifica de a versใo ้ Pyme (1)
"",;											// 14-Grupo de Configura็ใo do Tamanho (3)
"@!",;											// 15-Picture para a variแvel (40)
"",;											// 16-Identificador de Filtro da variแvel (6)
"",;											// 17-Nome do Help para o grupo de perguntas (14)
"MV_PAR08",;									// 18-Nome da variแvel (15)
"",;											// 19-Conte๚do da Variแvel (15)
{ ;
"Analitico",;									// 20,01-1a. Defini็ใo em Portugues (15)
"Analitico",;									// 20,02-1a. Defini็ใo em Espanhol (15)
"Analitico",;									// 20,03-1a. Defini็ใo em Ingles (15)
"Sintetico",;									// 20,04-2a. Defini็ใo em Portugues (15)
"Sintetico",;									// 20,05-2a. Defini็ใo em Espanhol (15)
"Sintetico",;									// 20,06-2a. Defini็ใo em Ingles (15)
"",;											// 20,07-3a. Defini็ใo em Portugues (15)
"",;											// 20,08-3a. Defini็ใo em Espanhol (15)
"",;											// 20,09-3a. Defini็ใo em Ingles (15)
"",;											// 20,10-4a. Defini็ใo em Portugues (15)
"",;											// 20,11-4a. Defini็ใo em Espanhol (15)
"",;											// 20,12-4a. Defini็ใo em Ingles (15)
"",;											// 20,13-5a. Defini็ใo em Portugues (15)
"",;											// 20,14-5a. Defini็ใo em Espanhol (15)
"" },;									   		// 20,15-5a. Defini็ใo em Ingles (15)
{ { ;
"Analitico ou sintetico. Quando Escolhido",;
"analitico, serแ apresentado as notas de ",;	// 21,01-Array com os textos de help em Portugues
"entrada e saida usadas na apura็ใo		 " ;
}, { ;
"Analitico ou sintetico. Quando Escolhido",;
"analitico, serแ apresentado as notas de ",;	// 21,02-Array com os textos de help em Espanhol
"entrada e saida usadas na apura็ใo		 " ;
}, { ;
"Analitico ou sintetico. Quando Escolhido",;
"analitico, serแ apresentado as notas de ",;	// 21,02-Array com os textos de help em Ingles
"entrada e saida usadas na apura็ใo		 " ;
} } } )

U_MyNewX1( { clPerg, aClone( alAux ) } )

RestArea( alAreaAtu )

Return()


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณReportListบAutor  ณHermes Ferreira     บ Data ณ  03/01/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณImpressใo em planilha do relatorio analitico de apura็cao deบฑฑ
ฑฑบ          ณvpc, lista todas as notas utilizadas na apura็ใo            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ReportList(oReport)
	
	Local oSection1 := oReport:Section(1)
	Local cSql		:= ""
	
	clAliasNotas := GetNextAlias()
	
	cSql := FQryAnalit()
	TcQuery cSql New Alias &(clAliasNotas)

	
	TCSetField((clAliasNotas),"P04_FECHAM"	,"D",TamSx3("P04_FECHAM")[1],TamSx3("P04_FECHAM")[2]	)
	TCSetField((clAliasNotas),"P04_DTINI"	,"D",TamSx3("P04_DTINI" )[1],TamSx3("P04_DTINI" )[2]	)
	TCSetField((clAliasNotas),"P04_DTFIM"	,"D",TamSx3("P01_DTVFIM")[1],TamSx3("P01_DTVFIM")[2]	)
	TCSetField((clAliasNotas),"EMISSAO"		,"D",TamSx3("P01_DTVFIM")[1],TamSx3("P01_DTVFIM")[2]	)
	TCSetField((clAliasNotas),"DIGITACAO"	,"D",TamSx3("P01_DTVFIM")[1],TamSx3("P01_DTVFIM")[2]	)
	TCSetField((clAliasNotas),"AGENDAM"		,"D",TamSx3("P01_DTVFIM")[1],TamSx3("P01_DTVFIM")[2]	)
	TCSetField((clAliasNotas),"DTENTRE"		,"D",TamSx3("P01_DTVFIM")[1],TamSx3("P01_DTVFIM")[2]	)
	TCSetField((clAliasNotas),"EMISPED"		,"D",TamSx3("P01_DTVFIM")[1],TamSx3("P01_DTVFIM")[2]	)
	TCSetField((clAliasNotas),"TOTNF"		,"N",TamSx3("F2_VALMERC")[1],TamSx3("F2_VALMERC")[2]	)
	TCSetField((clAliasNotas),"FRETE"		,"N",TamSx3("F2_FRETE"  )[1],TamSx3("F2_FRETE"  )[2]	)
	TCSetField((clAliasNotas),"SEGURO"		,"N",TamSx3("F2_SEGURO" )[1],TamSx3("F2_SEGURO" )[2]	)
	TCSetField((clAliasNotas),"DESPESA"		,"N",TamSx3("F2_DESPESA" )[1],TamSx3("F2_DESPESA" )[2]	)
	TCSetField((clAliasNotas),"VALMERC"		,"N",TamSx3("F2_VALMERC")[1],TamSx3("F2_VALMERC")[2]	)
	TCSetField((clAliasNotas),"BASEPIS"		,"N",TamSx3("F2_BASPIS" )[1],TamSx3("F2_BASPIS" )[2]	)
	TCSetField((clAliasNotas),"BASECOF"		,"N",TamSx3("F2_BASCOFI")[1],TamSx3("F2_BASCOFI")[2]	)
	TCSetField((clAliasNotas),"BASEICM"		,"N",TamSx3("F2_BASEICM")[1],TamSx3("F2_BASEICM")[2]	)
	TCSetField((clAliasNotas),"VALPIS"		,"N",TamSx3("F2_VALPIS" )[1],TamSx3("F2_VALPIS" )[2]	)
	TCSetField((clAliasNotas),"VALCOF"		,"N",TamSx3("F2_VALCOFI")[1],TamSx3("F2_VALCOFI")[2]	)
	TCSetField((clAliasNotas),"VALICM"		,"N",TamSx3("F2_VALICM" )[1],TamSx3("F2_VALICM" )[2]	)
	TCSetField((clAliasNotas),"VALIPI"		,"N",TamSx3("F2_VALIPI" )[1] ,TamSx3("F2_VALIPI")[2]	)
	TCSetField((clAliasNotas),"ICMSRET"		,"N",TamSx3("F2_ICMSRET")[1],TamSx3("F2_ICMSRET")[2]	)
	TCSetField((clAliasNotas),"LIQNF"		,"N",TamSx3("F2_VALMERC")[1],TamSx3("F2_VALMERC")[2]	)
	TCSetField((clAliasNotas),"P04_PERCEN"	,"N",TamSx3("P04_PERCEN")[1],TamSx3("P04_PERCEN")[2]	)
	
	
	(clAliasNotas)->(dbGoTop())


	If (clAliasNotas)->(!Eof())
		While (clAliasNotas)->(!Eof())
			oSection1:Init()
			oSection1:PrintLine()
			(clAliasNotas)->(dbSkip())
		EndDo
	EndIf
	oSection1:Finish()	
	
	(clAliasNotas)->(dbCloseArea())
	
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFQryAnalitบAutor  ณHermes Ferreira     บ Data ณ  03/01/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณMonta a query para listar as notas utilizadas na apura็ใo   บฑฑ
ฑฑบ          ณa serem impressas no relatorio                              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function FQryAnalit()

	Local cSql := ""
	
	cSql := " SELECT "		   							+ clr
	cSql += " P04_CODIGO "		 						+ clr
	cSql += ", P04_FECHAM"								+ clr
	cSql += ", P04_CLIENT"								+ clr
	cSql += ", P04_LOJCLI"								+ clr
	cSql += ", A1_NOME"									+ clr
	cSql += ", A1_EST"									+ clr
	cSql += ", P04_CODVPC"								+ clr
	cSql += ", P04_VERVPC"								+ clr
	cSql += ", P04_TPFAT"								+ clr
	cSql += ", P04_DTINI"								+ clr
	cSql += ", P04_DTFIM"								+ clr
	cSql += ", P04_STATUS"								+ clr
	cSql += ", P04_CODVEN"								+ clr
	cSql += ", 'Faturamento' AS TPDOC" 		 		+ clr
	cSql += ", '0' AS FLAG" 		 		+ clr
	
	cSql += ", F2_DOC AS DOCUMEN"						+ clr
	cSql += ", F2_SERIE AS SERIE"						+ clr
	cSql += ", F2_EMISSAO AS EMISSAO"					+ clr
	cSql += ", '' AS DIGITACAO"							+ clr
	
	cSql += "  			,( SELECT "				 		+ clr
	cSql += "  					(SUM (SUBBT.D2_TOTAL + SUBBT.D2_ICMSRET + SUBBT.D2_VALIPI +  SUBBT.D2_DESPESA + SUBBT.D2_SEGURO + SUBBT.D2_VALFRE  ))  AS BRUT "	+ clr
	cSql += "  					FROM "+RetSqlName("SD2")+" SUBBT "			+ clr
	cSql += "  					WHERE SUBBT.D_E_L_E_T_ <> '*'"				+ clr
	cSql += "  					AND SUBBT.D2_FILIAL		= SF2.F2_FILIAL"	+ clr
	cSql += "  					AND SUBBT.D2_CLIENTE	= SF2.F2_CLIENTE"	+ clr
	cSql += "  			 		AND SUBBT.D2_LOJA		= SF2.F2_LOJA"		+ clr
	cSql += "  			 		AND SUBBT.D2_TIPO		= SF2.F2_TIPO"		+ clr
	cSql += "  			 		AND SUBBT.D2_DOC		= SF2.F2_DOC"		+ clr
	cSql += "  			 		AND SUBBT.D2_SERIE		= SF2.F2_SERIE"		+ clr
	cSql += "  			 	) AS TOTNF "									+ clr
		
	cSql += ", F2_FRETE   AS FRETE "		 		+ clr
	cSql += ", F2_SEGURO  AS SEGURO "		 		+ clr
	cSql += ", F2_DESPESA  AS DESPESA "		 		+ clr
	cSql += ", F2_VALMERC AS VALMERC"				+ clr
	cSql += ", F2_BASIMP5  AS BASEPIS"				+ clr
	cSql += ", F2_BASIMP6 AS BASECOF"				+ clr
	cSql += ", F2_BASEICM AS BASEICM"				+ clr
	cSql += ", F2_VALIMP5  AS VALPIS"				+ clr
	cSql += ", F2_VALIMP6 AS VALCOF"				+ clr
	cSql += ", F2_VALICM  AS VALICM"				+ clr
	cSql += ", F2_VALIPI  AS VALIPI"				+ clr
	cSql += ", F2_ICMSRET AS ICMSRET"				+ clr
	cSql += " 			,( SELECT "					+ clr
	cSql += " 				((SUM (SUBD2.D2_TOTAL + SUBD2.D2_ICMSRET + SUBD2.D2_VALIPI +   SUBD2.D2_DESPESA + SUBD2.D2_SEGURO + SUBD2.D2_VALFRE  ))  -  (SUM(SUBD2.D2_VALICM+SUBD2.D2_VALIMP6+SUBD2.D2_VALIMP5+SUBD2.D2_VALIPI+SUBD2.D2_ICMSRET+   SUBD2.D2_DESPESA + SUBD2.D2_SEGURO + SUBD2.D2_VALFRE))) AS LIQ " 	+ clr
	cSql += " 				FROM "+RetSqlName("SD2")+ " SUBD2 "			+ clr
	cSql += " 				WHERE SUBD2.D_E_L_E_T_ <> '*'"				+ clr
	cSql += " 				AND SUBD2.D2_FILIAL		= SF2.F2_FILIAL"	+ clr
	cSql += " 				AND SUBD2.D2_CLIENTE	= SF2.F2_CLIENTE"	+ clr
	cSql += " 				AND SUBD2.D2_LOJA		= SF2.F2_LOJA"		+ clr
	cSql += " 				AND SUBD2.D2_TIPO		= SF2.F2_TIPO"		+ clr
	cSql += " 				AND SUBD2.D2_DOC		= SF2.F2_DOC"		+ clr
	cSql += " 				AND SUBD2.D2_SERIE		= SF2.F2_SERIE"		+ clr
	cSql += " 				)  LIQNF "							  		+ clr		
	
	cSql += ", P04_PERCEN "						+ clr
	cSql += ", F2_DATAAG  AGENDAM"				+ clr
	cSql += ", F2_TRANSP TRANSP"				+ clr
	cSql += ", Z1_DTENTRE AS DTENTRE"			+ clr
	
	cSql += ", ' ' AS NFORIG"					+ clr
	cSql += ", ( 	SELECT C5_NUM "				+ clr
	cSql += "		FROM "+RetSqlName("SC5")+" SC5 "				+ clr
	cSql += "		WHERE SC5.C5_FILIAL = '"+xFilial("SC5")+"'"		+ clr
	cSql += "		AND SC5.C5_CLIENTE = SF2.F2_CLIENTE "			+ clr
	cSql += "		AND SC5.C5_LOJACLI = SF2.F2_LOJA "				+ clr
	cSql += "		AND SC5.C5_NOTA = SF2.F2_DOC "					+ clr
	cSql += "		AND SC5.C5_SERIE = SF2.F2_SERIE "				+ clr
	cSql += "		AND SC5.D_E_L_E_T_ = ' '"						+ clr
	cSql += "  ) 	PEDIDO "		   								+ clr
	cSql += ", ( 	SELECT C5_EMISSAO "								+ clr
	cSql += "		FROM "+RetSqlName("SC5")+" SC5 "		   		+ clr
	cSql += "		WHERE SC5.C5_FILIAL = '"+xFilial("SC5")+"'"		+ clr
	cSql += "		AND SC5.C5_CLIENTE = SF2.F2_CLIENTE "			+ clr
	cSql += "		AND SC5.C5_LOJACLI = SF2.F2_LOJA "				+ clr
	cSql += "		AND SC5.C5_NOTA = SF2.F2_DOC "					+ clr
	cSql += "		AND SC5.C5_SERIE = SF2.F2_SERIE "				+ clr
	cSql += "		AND SC5.D_E_L_E_T_ = ' '"		 				+ clr
	cSql += "  ) 	EMISPED "										+ clr

	     
	cSql += " FROM "+RetSqlName("P04")+ " P04 "			+ clr

	cSql += " JOIN "+RetSqlName("SA1")+" SA1 "			+ clr
	cSql += " ON SA1.A1_COD = P04.P04_CLIENT"			+ clr
	cSql += " AND SA1.A1_LOJA = P04.P04_LOJCLI"			+ clr
	cSql += " AND SA1.D_E_L_E_T_= ' '"					+ clr
		
	cSql += " JOIN "+RetSqlName("SF2")+ " SF2 " 		+ clr
	cSql += " ON SF2.F2_FILIAL = '"+xFilial("SF2")+"'"	+ clr
	cSql += " AND SF2.F2_YAPURAC = P04_CODIGO "			+ clr
	cSql += " AND SF2.F2_YVERAPU = P04_VERSAO "			+ clr
	cSql += " AND SF2.F2_CLIENTE = P04_CLIENT "			+ clr
	cSql += " AND SF2.F2_LOJA = P04_LOJCLI "			+ clr
	cSql += " AND SF2.D_E_L_E_T_= ' ' "					+ clr
	

	cSql += " JOIN "+RetSqlName("SZ1")+ " SZ1 " 		+ clr
	cSql += " ON SZ1.Z1_FILIAL = SF2.F2_FILIAL "		+ clr
	cSql += " AND SZ1.Z1_DOC = SF2.F2_DOC "				+ clr
	cSql += " AND SZ1.Z1_SERIE = SF2.F2_SERIE "			+ clr
	cSql += " AND SZ1.Z1_CLIENTE = SF2.F2_CLIENTE"		+ clr
	cSql += " AND SZ1.Z1_LOJA = SF2.F2_LOJA"			+ clr
	cSql += " AND SZ1.D_E_L_E_T_= ' ' "					+ clr
		
	cSql += " WHERE P04.P04_FILIAL = '"+xFilial("P04")+"'"						+ clr
	cSql += " AND P04.P04_CLIENT BETWEEN '"+MV_PAR03+"' AND '"+MV_PAR05+"' "	+ clr
	cSql += " AND P04.P04_LOJCLI BETWEEN '"+MV_PAR04+"' AND '"+MV_PAR06+"' "	+ clr
	//cSql += " AND P04.P04_CODVEN BETWEEN '"+MV_PAR07+"' AND '"+MV_PAR08+"' "	+ clr
	cSql += " AND P04.P04_DTINI >= '"+DtoS(MV_PAR01)+"'" 						+ clr
	cSql += " AND P04.P04_DTFIM <= '"+DtoS(MV_PAR02)+"'"						+ clr
	cSql += " AND P04.D_E_L_E_T_= ' '"											+ clr
	
	cSql += " UNION "		+ clr	+ clr
	
	cSql += " SELECT "				+ clr
	cSql += " P04_CODIGO "			+ clr
	cSql += ", P04_FECHAM"			+ clr
	cSql += ", P04_CLIENT"			+ clr
	cSql += ", P04_LOJCLI"			+ clr
	cSql += ", A1_NOME"				+ clr
	cSql += ", A1_EST"				+ clr
	cSql += ", P04_CODVPC"			+ clr
	cSql += ", P04_VERVPC"			+ clr
	cSql += ", P04_TPFAT"			+ clr
	cSql += ", P04_DTINI"			+ clr
	cSql += ", P04_DTFIM"			+ clr
	cSql += ", P04_STATUS"			+ clr
	cSql += ", P04_CODVEN"			+ clr
	cSql += ", 'Devolu็ใo' AS TPDOC"+ clr
	cSql += ", '9' AS FLAG"+ clr
	
	cSql += ", F1_DOC AS DOCUMEN"	+ clr
	cSql += ", F1_SERIE AS SERIE"	+ clr
	cSql += ", F1_EMISSAO AS EMISSAO"+ clr
	cSql += ", F1_DTDIGIT AS DIGITACAO"+ clr

	cSql += "  			,( SELECT  " 									+ clr
	cSql += "  				( (Sum ((SUBD0.D1_TOTAL + SUBD0.D1_VALIPI + SUBD0.D1_ICMSRET + SUBD0.D1_DESPESA + SUBD0.D1_SEGURO + SUBD0.D1_VALFRE ) - SUBD0.D1_VALDESC ))  * -1 )  "	+ clr
	cSql += "  				FROM "+RetSqlName("SD1")+" SUBD0 "			+ clr
	cSql += "  				WHERE SUBD0.D_E_L_E_T_ <> '*' "				+ clr
	cSql += "  				AND SUBD0.D1_FILIAL		= SF1.F1_FILIAL "	+ clr
	cSql += "  				AND SUBD0.D1_FORNECE	= SF1.F1_FORNECE "	+ clr
	cSql += "  				AND SUBD0.D1_LOJA		= SF1.F1_LOJA "		+ clr
	cSql += "  				AND SUBD0.D1_TIPO		= SF1.F1_TIPO "		+ clr
	cSql += "  				AND SUBD0.D1_DOC		= SF1.F1_DOC " 		+ clr
	cSql += "  				AND SUBD0.D1_SERIE		= SF1.F1_SERIE "	+ clr
	cSql += "  			 )  AS  TOTNF "									+ clr
		
	cSql += ", F1_FRETE   AS FRETE "	   			+ clr
	cSql += ", F1_SEGURO  AS SEGURO "				+ clr
	cSql += ", F1_DESPESA  AS DESPESA "		 		+ clr	
	cSql += ", F1_VALMERC AS VALMERC"				+ clr
	cSql += ", F1_BASIMP5  AS BASEPIS"				+ clr
	cSql += ", F1_BASIMP6  AS BASECOF"				+ clr
	cSql += ", F1_BASEICM AS BASEICM"				+ clr
	cSql += ", F1_VALIMP5  AS VALPIS"				+ clr
	cSql += ", F1_VALIMP6 AS VALCOF"				+ clr
	cSql += ", F1_VALICM  AS VALICM"				+ clr
	cSql += ", F1_VALIPI  AS VALIPI"				+ clr
	cSql += ", F1_ICMSRET AS ICMSRET"				+ clr
	
	cSql += "  			,( SELECT  "									+ clr
	cSql += "  				( (Sum ((SUBD1.D1_TOTAL + SUBD1.D1_VALIPI + SUBD1.D1_ICMSRET + SUBD1.D1_DESPESA + SUBD1.D1_SEGURO + SUBD1.D1_VALFRE ) - (SUBD1.D1_VALDESC) )  - SUM(SUBD1.D1_VALICM+SUBD1.D1_VALIMP6+SUBD1.D1_VALIMP5+SUBD1.D1_VALIPI+SUBD1.D1_ICMSRET+ SUBD1.D1_DESPESA + SUBD1.D1_SEGURO + SUBD1.D1_VALFRE) )  * -1 )	AS LIQ "	+ clr

	cSql += "  				FROM "+RetSqlName("SD1")+" SUBD1 "			+ clr
	cSql += "  				WHERE SUBD1.D_E_L_E_T_ <> '*' "				+ clr
	cSql += "  				AND SUBD1.D1_FILIAL		= SF1.F1_FILIAL "	+ clr
	cSql += "  				AND SUBD1.D1_FORNECE	= SF1.F1_FORNECE "	+ clr
	cSql += "  				AND SUBD1.D1_LOJA		= SF1.F1_LOJA "		+ clr
	cSql += "  				AND SUBD1.D1_TIPO		= SF1.F1_TIPO "		+ clr
	cSql += "  				AND SUBD1.D1_DOC		= SF1.F1_DOC " 		+ clr
	cSql += "  				AND SUBD1.D1_SERIE		= SF1.F1_SERIE "	+ clr
	cSql += "  			 )  LIQNF "					  			  		+ clr			
	
	cSql += ", P04_PERCEN "		  			+ clr

	cSql += ", ' ' AS AGENDAM "				+ clr
	cSql += ", ' ' AS TRANSP "				+ clr
	cSql += ", ' ' AS DTENTRE "				+ clr
	cSql += ", (SELECT SD1NFO.D1_NFORI || '/' || SD1NFO.D1_SERIORI"		+ clr
	cSql += "			FROM "+RetSqlName("SD1")+" SD1NFO "				+ clr
	cSql += " 			WHERE SD1NFO.D1_FILIAL = SF1.F1_FILIAL "		+ clr
	cSql += " 			AND SD1NFO.D1_DOC = SF1.F1_DOC "				+ clr
	cSql += " 			AND SD1NFO.D1_SERIE = SF1.F1_SERIE "			+ clr
	cSql += " 			AND SD1NFO.D1_FORNECE = SF1.F1_FORNECE"			+ clr
	cSql += " 			AND SD1NFO.D1_LOJA = SF1.F1_LOJA "				+ clr
	cSql += " 			AND ROWNUM < 2 "								+ clr
	cSql += "	)   NFORIG"												+ clr
	
	
	cSql += ", ( 	SELECT C5_NUM "									+ clr
	cSql += "		FROM "+RetSqlName("SC5")+" SC5 "				+ clr
	cSql += "		WHERE SC5.C5_FILIAL = '"+xFilial("SC5")+"'"		+ clr
	cSql += "		AND SC5.C5_CLIENTE = SF1.F1_FORNECE "			+ clr
	cSql += "		AND SC5.C5_LOJACLI = SF1.F1_LOJA "				+ clr
	cSql += "		AND SC5.C5_NOTA ||  SC5.C5_SERIE = (SELECT SD1NFO.D1_NFORI ||  SD1NFO.D1_SERIORI"	+ clr
	cSql += "	   											FROM "+RetSqlName("SD1")+" SD1NFO "			+ clr
	cSql += " 	   											WHERE SD1NFO.D1_FILIAL = SF1.F1_FILIAL "	+ clr
	cSql += " 	   											AND SD1NFO.D1_DOC = SF1.F1_DOC "			+ clr
	cSql += " 	   											AND SD1NFO.D1_SERIE = SF1.F1_SERIE "		+ clr
	cSql += " 		 										AND SD1NFO.D1_FORNECE = SF1.F1_FORNECE"		+ clr
	cSql += " 												AND SD1NFO.D1_LOJA = SF1.F1_LOJA "			+ clr
	cSql += " 	  											AND ROWNUM < 2 "							+ clr
	cSql += "  													)  "									+ clr
	cSql += "		AND SC5.D_E_L_E_T_ = ' ' "			+ clr
	cSql += "  ) 	PEDIDO "							+ clr
	
	cSql += ", ( 	SELECT C5_EMISSAO "					+ clr
	cSql += "		FROM "+RetSqlName("SC5")+" SC5 "	+ clr
	cSql += "		WHERE SC5.C5_FILIAL = '"+xFilial("SC5")+"'"		+ clr
	cSql += "		AND SC5.C5_CLIENTE = SF1.F1_FORNECE "			+ clr
	cSql += "		AND SC5.C5_LOJACLI = SF1.F1_LOJA "				+ clr
	cSql += "		AND SC5.C5_NOTA ||  SC5.C5_SERIE = (SELECT SD1NFO.D1_NFORI ||  SD1NFO.D1_SERIORI"		+ clr
	cSql += "	   											FROM "+RetSqlName("SD1")+" SD1NFO "				+ clr
	cSql += " 	   											WHERE SD1NFO.D1_FILIAL = SF1.F1_FILIAL "		+ clr
	cSql += " 	   											AND SD1NFO.D1_DOC = SF1.F1_DOC "				+ clr
	cSql += " 	   											AND SD1NFO.D1_SERIE = SF1.F1_SERIE "			+ clr
	cSql += " 		 										AND SD1NFO.D1_FORNECE = SF1.F1_FORNECE"			+ clr
	cSql += " 												AND SD1NFO.D1_LOJA = SF1.F1_LOJA "				+ clr
	cSql += " 	  											AND ROWNUM < 2 "								+ clr
	cSql += "  													)  "
	cSql += "		AND SC5.D_E_L_E_T_ = ' '"			+ clr
	cSql += "  ) 	EMISPED "							+ clr
	
	     
	cSql += " FROM "+RetSqlName("P04")+ " P04 "			+ clr

	cSql += " JOIN "+RetSqlName("SA1")+" SA1 "			+ clr
	cSql += " ON SA1.A1_COD = P04.P04_CLIENT"			+ clr
	cSql += " AND SA1.A1_LOJA = P04.P04_LOJCLI"			+ clr
	cSql += " AND SA1.D_E_L_E_T_= ' '"					+ clr
		
	cSql += " JOIN "+RetSqlName("SF1")+ " SF1 " 		+ clr
	cSql += " ON SF1.F1_FILIAL = '"+xFilial("SF1")+"'"	+ clr
	cSql += " AND SF1.F1_YAPURAC = P04_CODIGO "			+ clr
	cSql += " AND SF1.F1_YVERAPU = P04_VERSAO "			+ clr
	cSql += " AND SF1.F1_FORNECE = P04_CLIENT "			+ clr
	cSql += " AND SF1.F1_LOJA = P04_LOJCLI "			+ clr
	cSql += " AND SF1.D_E_L_E_T_= ' ' "					+ clr
		
	cSql += " WHERE P04.P04_FILIAL = '"+xFilial("P04")+"'"						+ clr
	cSql += " AND P04.P04_CLIENT BETWEEN '"+MV_PAR03+"' AND '"+MV_PAR05+"' "	+ clr
	cSql += " AND P04.P04_LOJCLI BETWEEN '"+MV_PAR04+"' AND '"+MV_PAR06+"' "	+ clr
	//cSql += "dbms AND P04.P04_CODVEN BETWEEN '"+MV_PAR07+"' AND '"+MV_PAR08+"' "	+ clr
	cSql += " AND P04.P04_DTINI >= '"+DtoS(MV_PAR01)+"'" 						+ clr
	cSql += " AND P04.P04_DTFIM <= '"+DtoS(MV_PAR02)+"'"						+ clr
	cSql += " AND P04.D_E_L_E_T_= ' '"											+ clr
	
	
	cSql += " ORDER BY P04_CLIENT,P04_LOJCLI,FLAG"						+ clr

Return cSql




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGRL101  บAutor  ณMicrosiga           บ Data ณ  01/17/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetDtEntreg(cNotaFiscal,cCliente,cLoja)

	Local aDados	:= Strtokarr(cNotaFiscal,"/")
	Local aAreaAtu	:= GetArea()
	Local dRetorno	:= CTOD("  /  /  ")
	
	SZ1->(DbSetOrder(1)) //Z1_FILIAL+Z1_DOC+Z1_SERIE+Z1_CLIENTE+Z1_LOJA
	If !Empty(cNotaFiscal) .And. SZ1->(DbSeek( xFilial("SZ1")+Padr( aDados[1],Len(SZ1->Z1_DOC) )  + PADR( aDados[2],Len(SZ1->Z1_SERIE)) +cCliente+cLoja  )   )
		dRetorno:=SZ1->Z1_DTENTRE
	EndIf
	
	RestArea(aAreaAtu)
	
Return dRetorno


Static Function GetTotPed(cFilPed,cNumPed)

	Local cSql	:= ""
	Local nRet	:= 0
	
	Local cAliasTT := GetNextAlias()
	
	
	cSql	:= " SELECT "
	cSql	+= " C5_NUM,SUM(C6_VALOR) + "
	cSql	+= "(
	cSql	+= "SELECT DISTINCT  (C5_FRETE+C5_SEGURO+C5_DESPESA+C5_FRETAUT - C5_DESCONT  )"
	cSql	+= " FROM "+RetSqlName("SC5")+" A "
	
	cSql	+= " JOIN "+RetSqlName("SC6")+"  B "
	cSql	+= " ON B.C6_FILIAL = A.C5_FILIAL"
	cSql	+= " AND B.C6_NUM = A.C5_NUM"
	cSql	+= " AND B.C6_CLI = A.C5_CLIENTE"
	cSql	+= " AND B.C6_LOJA = A.C5_LOJACLI"
	cSql	+= " AND B.D_E_L_E_T_= ' '"

	cSql	+= " WHERE A.C5_FILIAL = '"+cFilPed+"'"
	cSql	+= " AND A.C5_NUM = '"+cNumPed+"'"
	cSql	+= " AND A.D_E_L_E_T_= ' '"
	cSql	+= " ) TOTPED "


	cSql	+= " FROM "+RetSqlName("SC5")+ " SC5 "

	cSql	+= " JOIN "+RetSqlName("SC6")+ " SC6 "
	cSql	+= " ON SC6.C6_FILIAL = SC5.C5_FILIAL "
	cSql	+= " AND SC6.C6_NUM = SC5.C5_NUM "
	cSql	+= " AND SC6.C6_CLI = SC5.C5_CLIENTE "
	cSql	+= " AND SC6.C6_LOJA = SC5.C5_LOJACLI "
	cSql	+= " AND SC6.D_E_L_E_T_= ' ' "

	cSql	+= " WHERE SC5.C5_FILIAL = '"+cFilPed+"'"
	cSql	+= " AND SC5.C5_NUM = '"+cNumPed+"'"
	cSql	+= " AND SC5.D_E_L_E_T_= ' '"
	
	cSql	+= " GROUP BY C5_NUM "

	TcQuery cSql New Alias &(cAliasTT)
	TCSetField((cAliasTT),"TOTPED"	,"N",TamSx3("F2_VALMERC")[1],TamSx3("F2_VALMERC")[2]	)
		
	(cAliasTT)->(dbGoTop())
	
	If (cAliasTT)->(!Eof())
	
		nRet := (cAliasTT)->TOTPED
		
	EndIf
	
	(cAliasTT)->(dbCloseArea())
	

	
Return nRet


Static Function GetDescVPC(cFilPed,cNumPed)

	Local cSql	:= ""
	Local nRet	:= 0
	
	Local cAliasTT := GetNextAlias()
	
	
	cSql	:= " SELECT "
	cSql	+= " C5_NUM,SUM(C6_YVALVPC) C6_YVALVPC "

	cSql	+= " FROM "+RetSqlName("SC5")+ " SC5 "

	cSql	+= " JOIN "+RetSqlName("SC6")+ " SC6 "
	cSql	+= " ON SC6.C6_FILIAL = SC5.C5_FILIAL "
	cSql	+= " AND SC6.C6_NUM = SC5.C5_NUM "
	cSql	+= " AND SC6.C6_CLI = SC5.C5_CLIENTE "
	cSql	+= " AND SC6.C6_LOJA = SC5.C5_LOJACLI "
	cSql	+= " AND SC6.D_E_L_E_T_= ' ' "

	cSql	+= " WHERE SC5.C5_FILIAL = '"+cFilPed+"'"
	cSql	+= " AND SC5.C5_NUM = '"+cNumPed+"'"
	cSql	+= " AND SC5.D_E_L_E_T_= ' '"
	
	cSql	+= " GROUP BY C5_NUM "

	TcQuery cSql New Alias &(cAliasTT)
	TCSetField((cAliasTT),"C6_YVALVPC"	,"N",TamSx3("C6_YVALVPC")[1],TamSx3("C6_YVALVPC")[2]	)
		
	(cAliasTT)->(dbGoTop())
	
	If (cAliasTT)->(!Eof())
	
		nRet := (cAliasTT)->C6_YVALVPC
		
	EndIf
	
	(cAliasTT)->(dbCloseArea())
	
	
Return nRet