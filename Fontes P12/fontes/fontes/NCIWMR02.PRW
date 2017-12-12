#include "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "msgraphi.ch"
#INCLUDE "APWIZARD.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWMR02  บAutor  ณMicrosiga           บ Data ณ  09/18/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NCIWMR02()
Local aAreaAtu	   :=GetArea()
Local aAreaSFI	   :=SFI->(GetArea())
Local cPerg  		:= 'NCIWMR02'
Local cQryAlias 	:= GetNextAlias()
Local oReport
Private aDadosWM:={}

SFI->(DbSetOrder(1))//FI_FILIAL+DTOS(FI_DTMOVTO)+FI_PDV+FI_NUMREDZ
CriaSx1(cPerg)
Pergunte(cPerg, .F.)

oReport := ReportDef(cQryAlias, cPerg)
oReport:PrintDialog()

If Select(cQryAlias)>0
	(cQryAlias)->(DbCloseArea())
EndIf

RestArea(aAreaSFI)
RestArea(aAreaAtu)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWMR02  บAutor  ณMicrosiga           บ Data ณ  09/18/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ReportDef(cQryAlias,cPerg)
Local cTitle  := "Valores de Contabeis"
Local cHelp   := "Lista valores Contabeis entre Nota Fiscal,Livro Fiscal e Mapa Resumo(Somente Cupom Fiscal)"
Local oReport
Local oSection1
Local cPicture:=PesqPict("SD2","D2_VALICM")


oReport := TReport():New('NCIWMR02',cTitle,cPerg,{|oReport| ReportPrint(oReport,cQryAlias)},cHelp)
oSection1 := TRSection():New(oReport,"Valores Contabeis Cupom",{"SD2","SFT","SF3","SFI"})

TRCell():New(oSection1,"FILIAL" 	, cQryAlias	, "Filial")
TRCell():New(oSection1,"WEBMANAGER_CODIGO"	,"SFI"	,"Cod.Loja"		,"@!",20	,/*lPixel*/,{|| DadosWebManager( cQryAlias,"C"  )  }	)           
TRCell():New(oSection1,"PDV"	   	, cQryAlias	, "PDV")
TRCell():New(oSection1,"DATA"	, cQryAlias	, "DT EMISSรO	")

TRCell():New(oSection1,"WEBMANAGER_VALOR"	    ,cQryAlias	,"(1)CUPOM"	,cPicture,14,/*lPixel*/,{|| Abs(DadosWebManager( cQryAlias,"V" ))  } ,"RIGHT"	)
TRCell():New(oSection1,"MAPA"					,"SFI"	,"(2)MAPA RESUMO"         ,cPicture,14,/*lPixel*/,{|| MapaResumo(cQryAlias)  },"RIGHT"	)
TRCell():New(oSection1,"DIFERENCA0"				,"SFI"	,"DIF. (1-2)"         ,cPicture,14,/*lPixel*/,{|| Abs(MapaResumo(cQryAlias) - DadosWebManager( cQryAlias,"V" ))  },"RIGHT"	)

TRCell():New(oSection1,"NOTA_VALOR_CONTABIL" 	, cQryAlias	,"(3)NOTA",cPicture)
TRCell():New(oSection1,"VALCONTSFT" 	, cQryAlias	,"(4) LIVRO",cPicture)
TRCell():New(oSection1,"VALCONTSF3" 	, cQryAlias	,"(5) ITEM",cPicture)
TRCell():New(oSection1,"DIFERENCA1"		,"SFI"	,"DIF. (3-(4+5)/2)   "         ,cPicture,14,/*lPixel*/,{|| (cQryAlias)->NOTA_VALOR_CONTABIL - ((cQryAlias)->VALCONTSF3 + (cQryAlias)->VALCONTSFT)/2  },"RIGHT"	)
TRCell():New(oSection1,"DIFERENCA2"				,"SFI"	,"DIF. (1-4)     "         ,cPicture,14,/*lPixel*/,{|| Abs(DadosWebManager( cQryAlias,"V" ) - (cQryAlias)->VALCONTSFT ) },"RIGHT"	)


oBreak := TRBreak():New(oSection1,oSection1:Cell("FILIAL"),,.F.)
TRFunction():New(oSection1:Cell("WEBMANAGER_VALOR")	    ,"TOTAL FILIAL","SUM",oBreak,,cPicture,,.F.,.F.)
TRFunction():New(oSection1:Cell("MAPA")	   				,"TOTAL FILIAL","SUM",oBreak,,cPicture,,.F.,.F.)

TRFunction():New(oSection1:Cell("NOTA_VALOR_CONTABIL"),"TOTAL FILIAL","SUM",oBreak,,cPicture,,.F.,.F.)
TRFunction():New(oSection1:Cell("VALCONTSF3"),"TOTAL FILIAL","SUM",oBreak,,cPicture,,.F.,.F.)
TRFunction():New(oSection1:Cell("VALCONTSFT"),"TOTAL FILIAL","SUM",oBreak,,cPicture,,.F.,.F.)

TRFunction():New(oSection1:Cell("DIFERENCA0")	    ,"TOTAL FILIAL","SUM",oBreak,,cPicture,,.F.,.F.)
TRFunction():New(oSection1:Cell("DIFERENCA1")	    ,"TOTAL FILIAL","SUM",oBreak,,cPicture,,.F.,.F.)
TRFunction():New(oSection1:Cell("DIFERENCA2")	    ,"TOTAL FILIAL","SUM",oBreak,,cPicture,,.F.,.F.)

Return(oReport)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWMR02  บAutor  ณMicrosiga           บ Data ณ  09/18/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ReportPrint(oReport,cQryAlias)
Local aAreaAtu	   :=GetArea()
Local oSecao1 := oReport:Section(1)

oReport:SetMsgPrint("Buscando dados no WebManager") 
GetDadosWM()

oReport:SetMsgPrint("Buscando dados no Protheus")

//oSecao1:BeginQuery()

BeginSQL Alias cQryAlias
	
	COLUMN DATA AS DATE
	
	SELECT SD2.D2_FILIAl FILIAL,
	SD2.LOJAWM,
	sd2.PDV PDV,
	SD2.DATA DATA,
	sum(SD2.NOTA_VALOR_CONTABIL) NOTA_VALOR_CONTABIL,
	sum(SF3.VALCONT) VALCONTSF3,
	sum(SFT.LIVRO_VALOR_CONTABIL) VALCONTSFT
	FROM
	(SELECT D2_FILIAL||D2_DOC||D2_SERIE||TO_DATE(D2_EMISSAO,'YYYYMMDD') CHAVE,
	D2_FILIAL,
	D2_DOC,
	D2_SERIE,
	d2_pdv PDV,
	D2_YLOJAWM LOJAWM,
	TO_DATE(D2_EMISSAO,'YYYYMMDD')DATA,
	SUM(SD2.D2_TOTAL+SD2.D2_VALIPI+SD2.D2_ICMSRET+SD2.D2_SEGURO+SD2.D2_DESPESA+SD2.D2_VALFRE) NOTA_VALOR_CONTABIL,
	D2_YLOJAWM
	FROM %Table:SD2% SD2
	WHERE SD2.D2_FILIAL BETWEEN %Exp:MV_PAR01% AND %Exp:MV_PAR02%
	AND SD2.D2_DOC BETWEEN '      ' AND 'ZZZZZZ'
	AND SD2.D2_SERIE BETWEEN '  ' AND 'ZZ'
	AND SD2.D2_CLIENTE BETWEEN '  ' AND 'ZZ'
	AND SD2.D2_LOJA BETWEEN '  ' AND 'ZZ'
	AND SD2.D2_EMISSAO BETWEEN %Exp:MV_PAR03% AND %Exp:MV_PAR04%
	AND SD2.D_E_L_E_T_ = ' '
	AND SD2.D2_SERIE = 'ECF'
	GROUP BY D2_FILIAL,
	D2_DOC,
	D2_SERIE,
	D2_PDV,
	D2_EMISSAO,
	D2_YLOJAWM)SD2
	LEFT JOIN
	( SELECT FT_FILIAL||FT_NFISCAL||FT_SERIE||TO_DATE(FT_ENTRADA,'YYYYMMDD') CHAVE,
	FT_FILIAL,
	FT_NFISCAL,
	FT_SERIE,
	TO_DATE(FT_ENTRADA,'YYYYMMDD'),
	SUM(NVL(FT_VALCONT,0)) LIVRO_VALOR_CONTABIL
	FROM %Table:SFT% SFT
	WHERE FT_FILIAL BETWEEN %Exp:MV_PAR01% AND %Exp:MV_PAR02%
	AND FT_TIPOMOV='S'
	AND FT_ENTRADA BETWEEN %Exp:MV_PAR03% AND %Exp:MV_PAR04%
	AND FT_SERIE BETWEEN '  ' AND 'ZZ'
	AND FT_NFISCAL BETWEEN '      ' AND 'ZZZZZZ'
	AND FT_CLIEFOR BETWEEN '  ' AND 'ZZ'
	AND FT_LOJA BETWEEN '  ' AND 'ZZ'
	AND FT_ITEM BETWEEN '  ' AND 'ZZ'
	AND FT_PRODUTO BETWEEN '  ' AND 'ZZ'
	AND FT_DTCANC=' '
	AND D_E_L_E_T_=' '
	AND FT_ESPECIE='CF'
	GROUP BY FT_FILIAL,
	FT_NFISCAL,
	FT_SERIE,
	FT_ENTRADA)SFT ON SD2.CHAVE = SFT.CHAVE
	LEFT JOIN
	( SELECT f3_filial||f3_nfiscal||f3_serie||to_date(F3_ENTRADA,'yyyymmdd') CHAVE,
	f3_filial filial,
	f3_nfiscal nota,
	f3_serie serie,
	to_date(F3_ENTRADA,'yyyymmdd') entrada,
	F3_CLIEFOR cliente,
	F3_LOJA loja,
	sum(F3_VALCONT) VALCONT
	FROM %Table:SF3%
	WHERE F3_EMISSAO BETWEEN %Exp:MV_PAR03% AND %Exp:MV_PAR04%
	AND D_E_L_E_T_ = ' '
	AND F3_SERIE = 'ECF'
	GROUP BY f3_filial,
	f3_nfiscal,
	f3_serie,
	to_date(F3_ENTRADA,'yyyymmdd'),
	F3_CLIEFOR,
	F3_LOJA)SF3 ON SD2.CHAVE = SF3.CHAVE
	group by d2_filial,SD2.LOJAWM ,sd2.pdv, d2_serie,sd2.data
	order by d2_filial,SD2.LOJAWM ,sd2.pdv, sd2.data, d2_serie
	
EndSQL
oSecao1:Init()

Do While (cQryAlias)->(!Eof()) 

	If oReport:Cancel()
		Exit
	EndIf                            
	
	oReport:SetMsgPrint("Imprimindo Filial "+(cQryAlias)->FILIAL+" Dia:"+DTOC((cQryAlias)->DATA) )
	oSecao1:PrintLine()       
	oReport:ThinLine()             
	(cQryAlias)->(DbSkip())
EndDo 
oSecao1:Finish()
(cQryAlias)->(DbCloseArea())
RestArea(aAreaAtu)
//oReport:SetMeter(0)
//oSecao1:Print()
Return

//oReport:SetMsgPrint("Imprimindo")
//oSecao1:EndQuery()
//oReport:SetMeter(0)
//oSecao1:Print()


Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWMR02  บAutor  ณMicrosiga           บ Data ณ  09/18/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static function criaSX1(cPerg)

PutSx1(cPerg,"01","Da Filial  ","","","MV_CH1" ,"C",02,0,0,"G","                                                            ","XM0","   "," ","MV_PAR01","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")
PutSx1(cPerg,"02","Ate Filial ","","","MV_CH2","C",02,0,0,"G","                                                            ","XM0","   "," ","MV_PAR02","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")

PutSx1(cPerg,"03","Da Emissao"	,"","","MV_CH3","D",8,0,0,"G","                                                             ","      ","   "," ","MV_PAR03","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")
PutSx1(cPerg,"04","Ate Emissao"	,"","","MV_CH4","D",8,0,0,"G","                                                            ","      ","   "," ","MV_PAR04","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")


Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWMR02  บAutor  ณMicrosiga           บ Data ณ  09/18/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function MapaResumo( cQryAlias  )
Local nValor:=0


If SFI->(MsSeek((cQryAlias)->(FILIAL+DTOS(DATA)+PDV)) )
	nValor:=SFI->FI_VALCON 
EndIf

Return nValor

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWMR02  บAutor  ณMicrosiga           บ Data ณ  09/26/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetDadosWM(aDados)
Local aAreaAtu		:=GetArea()
Local cQryAlias	:=GetNextAlias()
Local aCodLojas		:={}
Local nFilSize		:=FWSizeFilial()  
Local cCodEmp 		:= FWCodEmp()
Local cCodWM		:=""
Local oConectDB
Local lConectou
Local cFilLoja
Local cDataIni:=StrZero( Year(mv_par03),4) +"-"+StrZero( Month(mv_par03),2) +"-"+StrZero(Day(mv_par03),2)+" 00:00:00"
Local cDataFim:=StrZero( Year(mv_par04),4) +"-"+StrZero( Month(mv_par04),2) +"-"+StrZero(Day(mv_par04),2)+" 23:59:59"
Local cTabZX5:="%ZX5010%" //Somente a empresa 01 tem os dados
Local cLike:=cCodEmp+"%"
Local nAscan

BeginSQL Alias cQryAlias
	SELECT ZX5_DESCRI, ZX5_CHAVE
	FROM %exp:cTabZX5% ZX5
	WHERE ZX5_FILIAL=' '
	AND ZX5_TABELA='00006'
	AND ZX5_DESCRI LIKE %Exp:cLike%
	AND ZX5.%notDel%	
EndSql


Do While (cQryAlias)->(!Eof())
	cFilLoja:=Separa((cQryAlias)->ZX5_DESCRI,";")[2]
	AADD(aCodLojas,{cFilLoja,AllTrim((cQryAlias)->ZX5_CHAVE) }   )
	(cQryAlias)->(DbSkip())
EndDo


(cQryAlias)->(DbCloseArea())
BeginSQL Alias cQryAlias
	SELECT DISTINCT D2_FILIAL,SD2.D2_YLOJAWM
	FROM %Table:SD2% SD2
	WHERE SD2.D2_FILIAL BETWEEN %Exp:MV_PAR01% AND %Exp:MV_PAR02%
	And SD2.D2_DOC BETWEEN '      ' And 'ZZZZZZ'
	And SD2.D2_SERIE BETWEEN '  ' And 'ZZ'
	And SD2.D2_CLIENTE BETWEEN '  ' And 'ZZ'
	And SD2.D2_LOJA BETWEEN '  ' And 'ZZ'
	AND SD2.D2_EMISSAO BETWEEN %Exp:DTOS(MV_PAR03)% AND %Exp:DTOS(MV_PAR04)%
	AND SD2.D2_ESPECIE='2D'
	AND SD2.%notDel%
	ORDER BY SD2.D2_FILIAL//, SD2.D2_YLOJAWM
EndSql

Do While (cQryAlias)->(!Eof())
	If (nAscan:=Ascan(aCodLojas,{|a|a[1]==(cQryAlias)->D2_FILIAL} )    )>0
		cCodWM+=alltrim( (cQryAlias)->D2_YLOJAWM )+"/"
	EndIf
	(cQryAlias)->(DbSkip())
EndDo 
If !Empty(cCodWM)
	cCodWM:=Left(cCodWM,Len(cCodWM)-1)
EndIf

(cQryAlias)->(DbCloseArea())

oConectDB:= U_DBWebManager() //Funcao encontrada no NCIWMF02
If oConectDB:OpenConnection()	
	
	cQuery:=" SELECT COD_LOJA,DATA_CADASTROU,NUMERO_ECF,SUM(VALOR_OPERACAO) AS VALOR_TOTAL,Count(1) Cupom"
	cQuery+=" FROM INTEGRACAO_MOVIMENTO_FINANCEIRO "
	cQuery+=" WHERE DATA_MOVIMENTO Between '"+cDataIni+"' And '"+cDataFim+"'"
	cQuery+=" AND COD_LOJA IN "+FormatIn(cCodWM,"/")
	cQuery+=" AND TIPO_OPERACAO in('VE','TRV')"
	cQuery+=" 	GROUP BY COD_LOJA,DATA_CADASTROU,NUMERO_ECF "
	cQuery+=" ORDER BY COD_LOJA, NUMERO_ECF,DATA_CADASTROU "


/*	cQuery:=" 	select COD_LOJA,DATA_CADASTROU, replicate('0', 3-len(numero_ecf))+convert(varchar,NUMERO_ECF) as NUMERO_ECF, SUM(VALOR_TOTAL) as VALOR_TOTAL, sum(cupom) as cupom FROM "
	cQuery+=" 	( "
	cQuery+="select COD_LOJA,CONVERT(VARCHAR(10), DATA_EMISSAO, 103) AS DATA_CADASTROU, NUMERO_ECF ,SUM(TOTAL)/count(COD_MOVIMENTO) AS VALOR_TOTAL,Count(1) Cupom  "
	cQuery+="from integracao_movimento_fiscal  "
	cQuery+=" WHERE DATA_EMISSAO Between '"+cDataIni+"' And '"+cDataFim+"'" 
	cQuery+=" AND COD_LOJA IN "+FormatIn(cCodWM,"/")
	cQuery+="group by COD_LOJA,COD_MOVIMENTO,CONVERT(VARCHAR(10), DATA_EMISSAO, 103), NUMERO_ECF   "
	cQuery+=")CONSULTA GROUP BY COD_LOJA,DATA_CADASTROU, replicate('0', 3-len(numero_ecf))+convert(varchar,NUMERO_ECF) "
*/
	oConectDB:NewAlias( cQuery, cQryAlias )
	Do While (cQryAlias)->(!Eof())
		nAscan:=Ascan(aCodLojas,{|a|a[2]==AllTrim(Str((cQryAlias)->COD_LOJA))} )
		If nAscan>0
			(cQryAlias)->(AADD(aDadosWM,{aCodLojas[nAscan,1],CTOD(DATA_CADASTROU),NUMERO_ECF,VALOR_TOTAL,aCodLojas[nAscan,2],CUPOM}))
		EndIf		
		(cQryAlias)->(DbSkip())
	EndDo
	oConectDB:CloseConnection() //Fecha Conexao e o cQryAlias
EndIf

If ValType(oConectDB)=="O"
	oConectDB:Finish()
EndIf
      
RestArea(aAreaAtu)
Return 

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWMR02  บAutor  ณMicrosiga           บ Data ณ  09/26/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function DadosWebManager(cQryAlias,cCampo )
Local nAscan
Local nPos
Local uValor
Local Zx5Query :=""
Local Zx5Alias := GetNextAlias()

If cCampo=="V"
	uValor:=0
	nPos  :=4
Else
	uValor:=""
	nPos  :=5
EndIf	
If (nAscan:=Ascan(aDadosWM,{|a| a[1]== (cQryAlias)->FILIAL .And. a[2]==(cQryAlias)->DATA .And.  alltrim(a[3])== alltrim((cQryAlias)->PDV)}  ))>0
	If cCampo=="V"
		uValor:=aDadosWM[nAscan,nPos]
	Else                             
	
   		Zx5Query +=" SELECT ZX5_DESCRI, ZX5_CHAVE "
		Zx5Query +=" 		FROM ZX5010 ZX5 "
		Zx5Query +=" 		WHERE ZX5_FILIAL=' ' "
		Zx5Query +=" 		AND ZX5_TABELA='00006' "
		Zx5Query +=" 		AND ZX5.ZX5_CHAVE = '"+aDadosWM[nAscan,nPos]+"' "
		Zx5Query +=" 		AND ZX5.D_E_L_E_T_ = ' '	 "
	
		Zx5Query := ChangeQuery(Zx5Query)
		DbUseArea(.T.,"TOPCONN",TcGenQry(,,Zx5Query),Zx5Alias,.T.,.T.)
	    IF !((Zx5Alias)->ZX5_DESCRI == "")
			uValor:= aDadosWM[nAscan,nPos] +"-"+ (Separa((Zx5Alias)->ZX5_DESCRI,";")[3])
        ENDIF
	DbSelectArea(Zx5Alias)	
	
	EndIf	
EndIf 

Return uValor

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWMR02  บAutor  ณMicrosiga           บ Data ณ  09/26/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function xTeste(cQryAlias,oSection1)

Abs(oSection1:Cell("MAPA"):GetValue()- oSection1:Cell("LIVRO_VALOR_CONTABIL"):GetValue())
 
Return  0
