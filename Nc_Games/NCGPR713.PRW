#include "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "msgraphi.ch"
#INCLUDE "APWIZARD.CH"


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR713  บAutor  ณMicrosiga           บ Data ณ  11/02/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NCGPR713()
Local aAreaAtu	   :=GetArea()
Local aAreaSFI	   :=SC5->(GetArea())
Local cPerg  		:= 'NCGPR713'
Local cQryAlias 	:= GetNextAlias()
Local oReport

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
ฑฑบPrograma  ณNCGPR713  บAutor  ณMicrosiga           บ Data ณ  11/02/15   บฑฑ
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
Local cTitle  := "Pedidos Residuais"
Local cHelp   := "Lista pedidos que contem pedido residual"
Local oReport
Local oSection1
Local cPicture:=PesqPict("SD2","D2_QUANT")

oReport := TReport():New('NCGPR713',cTitle,cPerg,{|oReport| ReportPrint(oReport,cQryAlias)},cHelp)
oSection1 := TRSection():New(oReport,"Valores ICMS",{"SD2","SFT"})

TRCell():New(oSection1,"C5_ORIGRES" ,cQryAlias	, "Pv Pai")
TRCell():New(oSection1,"C5_EMISSAO" ,cQryAlias	, "Emissao")
TRCell():New(oSection1,"C5_CLIENTE" ,cQryAlias	, "Cliente")
TRCell():New(oSection1,"C5_LOJA" 	,cQryAlias	, "Loja")
TRCell():New(oSection1,"C5_NOMCLI" 	,cQryAlias	, "Nome")
TRCell():New(oSection1,"C6_ITEM"	,cQryAlias	, "Item")
TRCell():New(oSection1,"C6_PRODUTO"	,cQryAlias	, "Produto")
TRCell():New(oSection1,"C6_QTDVEN"	,cQryAlias	,"QuantPV",cPicture,14)
TRCell():New(oSection1,"D2_DOC"		,"SD2"	,"Nota"		,,,/*lPixel*/			,{|| GetDados("D2_DOC","O") }	)
TRCell():New(oSection1,"D2_SERIE"	,"SD2"	,"Serie"	,,,/*lPixel*/			,{|| GetDados("D2_SERIE","O") }	)
TRCell():New(oSection1,"D2_EMISSAO"	,"SD2"	,"Emissao"	,,,/*lPixel*/			,{|| GetDados("D2_EMISAO","O") }	)
TRCell():New(oSection1,"D2_QUANT"	,"SD2"	,"QuantNF"	,cPicture,,/*lPixel*/	,{|| GetDados("D2_QUANT","O") }	)



TRCell():New(oSection1,"C5_NUM" 	,"SC5"	, "Pv Pai"		,,,/*lPixel*/			,{|| GetDados("C5_NUM","R") }	)
TRCell():New(oSection1,"C5_EMISSAO" ,"SC5"	, "Emissao"		,,,/*lPixel*/			,{|| GetDados("C5_EMISSAO","R") }	)
TRCell():New(oSection1,"C5_CLIENTE" ,"SC5"	, "Cliente"		,,,/*lPixel*/			,{|| GetDados("C5_CLIENTE","R") }	)
TRCell():New(oSection1,"C5_LOJA" 	,"SC5"	, "Loja"		,,,/*lPixel*/			,{|| GetDados("C5_LOJA","R") }	)
TRCell():New(oSection1,"C5_NOMCLI" 	,"SC5"	, "Nome"		,,,/*lPixel*/			,{|| GetDados("C5_NOMCLI","R") }	)
TRCell():New(oSection1,"C6_ITEM"	,"SC6"	, "Item"		,,,/*lPixel*/			,{|| GetDados("C6_ITEM","R") }	)
TRCell():New(oSection1,"C6_PRODUTO"	,"SC6"	, "Produto"		,,,/*lPixel*/			,{|| GetDados("C6_PRODUTO","R") }	)
TRCell():New(oSection1,"C6_QTDVEN"	,"SC6"	,"QuantPV",cPicture,14/*lPixel*/	,{|| GetDados("C6_QTDVEN","O") }	)
TRCell():New(oSection1,"D2_DOC"		,"SD2"	,"Nota"		,,,/*lPixel*/			,{|| GetDados("D2_DOC","R") }	)
TRCell():New(oSection1,"D2_SERIE"	,"SD2"	,"Serie"	,,,/*lPixel*/			,{|| GetDados("D2_SERIE","R") }	)
TRCell():New(oSection1,"D2_EMISSAO"	,"SD2"	,"Emissao"	,,,/*lPixel*/			,{|| GetDados("D2_EMISAO","R") }	)
TRCell():New(oSection1,"D2_QUANT"	,"SD2"	,"QuantNF"	,cPicture,,/*lPixel*/	,{|| GetDados("D2_QUANT","R") }	)


Return(oReport)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWMR01  บAutor  ณMicrosiga           บ Data ณ  09/18/15   บฑฑ
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
Local oSecao1 := oReport:Section(1)
Local cQryAlias:=GetNextAlias()

BeginSQL Alias cQryAlias
	
	SELECT C5_ORIGRES,
	FROM %Table:SC5% SC5,%Table:SC6% SC6
	WHERE SC5.C5_FILIAL
	And SC5.C5_NUM BETWEEN '      ' And 'ZZZZZZ'
	AND SC5.D_E_L_E_T_=' '
	AND SC5.C5_ORIGRES<>' '
	AND EXISTS (SELECT 'X ' FROM  WHERE SC6.C6_FILIAL='03' AND SC6.C6_NUM=SC5.C5_NUM AND C6_PRODUTO='01152550320    ' AND SC6.D_E_L_E_T_=' ')
	ORDER BY C5_ORIGRES
EndSql





oSecao1:BeginQuery()

BeginSQL Alias cQryAlias
	
	COLUMN D2_EMISSAO AS DATE
	
	SELECT D2_PDV,D2_FILIAL,D2_EMISSAO,D2_VALICM,FT_VALICM,ABS(D2_VALICM-FT_VALICM) DIFNFLF
	From
	(SELECT D2_FILIAL,D2_PDV,D2_EMISSAO,SUM(D2_VALICM) D2_VALICM
	FROM %Table:SD2% SD2
	WHERE SD2.D2_FILIAL BETWEEN %Exp:MV_PAR01% AND %Exp:MV_PAR02%
	And SD2.D2_DOC BETWEEN '      ' And 'ZZZZZZ'
	And SD2.D2_SERIE BETWEEN '  ' And 'ZZ'
	And SD2.D2_CLIENTE BETWEEN '  ' And 'ZZ'
	And SD2.D2_LOJA BETWEEN '  ' And 'ZZ'
	AND SD2.D2_EMISSAO BETWEEN %Exp:DTOS(MV_PAR03)% AND %Exp:DTOS(MV_PAR04)%
	AND SD2.D2_ESPECIE='2D'
	AND SD2.%notDel%
	GROUP BY D2_FILIAL,D2_PDV,D2_EMISSAO) Tab1,
	(SELECT FT_FILIAL,FT_PDV,FT_ENTRADA,SUM(FT_VALICM ) FT_VALICM
	FROM %Table:SFT% SFT
	WHERE FT_FILIAL BETWEEN %Exp:MV_PAR01% AND %Exp:MV_PAR02%
	AND FT_TIPOMOV='S'
	AND FT_ENTRADA  BETWEEN %Exp:DTOS(MV_PAR03)% AND %Exp:DTOS(MV_PAR04)%
	And FT_SERIE BETWEEN '  ' And 'ZZ'
	And FT_NFISCAL BETWEEN '      ' And 'ZZZZZZ'
	And FT_CLIEFOR BETWEEN '  ' And 'ZZ'
	And FT_LOJA BETWEEN '  ' And 'ZZ'
	And FT_ITEM BETWEEN '  ' And 'ZZ'
	And FT_PRODUTO BETWEEN '  ' And 'ZZ'
	AND FT_DTCANC=' '
	AND D_E_L_E_T_=' '
	AND FT_ESPECIE='CF'
	GROUP BY FT_FILIAL,FT_PDV,FT_ENTRADA) Tab2
	Where Tab1.D2_FILIAL=Tab2.FT_FILIAL
	And Tab1.D2_EMISSAO=Tab2.FT_ENTRADA
	And Tab1.D2_PDV=Tab2.FT_PDV
	//And Tab1.D2_CF=Tab2.FT_CFOP
	And Tab1.D2_VALICM<>Tab2.FT_VALICM
	and ABS(D2_VALICM-FT_VALICM) >1
	ORDER BY Tab1.D2_FILIAL,Tab1.D2_EMISSAO
	
EndSQL
oSecao1:EndQuery()
oReport:SetMeter(0)
oSecao1:Print()
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWMR01  บAutor  ณMicrosiga           บ Data ณ  09/18/15   บฑฑ
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

PutSx1(cPerg,"01","Do Pedido Pai" ,"","","MV_CH1" ,"C",06,0,0,"G","","SC5","   "," ","MV_PAR01","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")
PutSx1(cPerg,"02","Ate Pedido Pai","","","MV_CH2","C" ,06,0,0,"G","","SC5","   "," ","MV_PAR02","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")

PutSx1(cPerg,"03","Do Pedido Filho" ,"","","MV_CH1" ,"C",06,0,0,"G","","SC5","   "," ","MV_PAR03","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")
PutSx1(cPerg,"04","Ate Pedido Filho","","","MV_CH2","C" ,06,0,0,"G","","SC5","   "," ","MV_PAR04","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")
                
PutSx1(cPerg,"05","Do Cliente"		,"Do Cliente                    ","Do Cliente                    ","MV_CH5","C",6,0,0,"G","","SA1"   ,"   "," ","MV_PAR05","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")
PutSx1(cPerg,"06","Ate Cliente"		,"Ate Cliente                   ","Ate Cliente                   ","MV_CH5","C",6,0,0,"G","","SA1   ","   "," ","MV_PAR06","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")

PutSx1(cPerg,"07","Da Loja"			,"Da Loja                       ","Da Loja                       ","MV_CH6","C",2,0,0,"G","","      ","   "," ","MV_PAR07","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")
PutSx1(cPerg,"08","Ate Loja"		,"Ate Loja  	                ","Ate Loja		                 ","MV_CH7","C",2,0,0,"G","","      ","   "," ","MV_PAR08","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")

PutSx1(cPerg,"10","Do Produto                    ","Do Produto                    ","Do Produto                    ","MV_CH1","C",15,0,0,"G","                                                            ","SB1   ","   "," ","MV_PAR10","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")
PutSx1(cPerg,"11","Ate Produto                   ","Ate Produto                   ","Ate Produto                   ","MV_CH2","C",15,0,0,"G","                                                            ","SB1   ","   "," ","MV_PAR11","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")


//PutSx1(cPerg,"08","Da Emissao   ","Da Emissao                    ","Da Emissao                    ","MV_CH5","D",8,0,0,"G","                                                            ","      ","   "," ","MV_PAR08","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")
//PutSx1(cPerg,"09","Ate Emissao  ","Ate Emissao                   ","Ate Emissao                   ","MV_CH6","D",8,0,0,"G","                                                            ","      ","   "," ","MV_PAR09","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")

Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWMR01  บAutor  ณMicrosiga           บ Data ณ  09/18/15   บฑฑ
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


If SFI->(MsSeek((cQryAlias)->(D2_FILIAL+DTOS(D2_EMISSAO)+D2_PDV)) )
	nValor:=SFI->(  (FI_BAS7*0.07)+(FI_BAS12*0.12)+(FI_BAS18*0.18)+(FI_BAS25*0.25)  )
EndIf

Return nValor
