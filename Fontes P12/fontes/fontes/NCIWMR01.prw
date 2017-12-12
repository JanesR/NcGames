#include "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "msgraphi.ch"
#INCLUDE "APWIZARD.CH"

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
User Function NCIWMR01()
Local aAreaAtu	   :=GetArea()
Local aAreaSFI	   :=SFI->(GetArea())
Local cPerg  		:= 'NCIWMR01'
Local cQryAlias 	:= GetNextAlias()
Local oReport

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
Static Function ReportDef(cQryAlias,cPerg)
Local cTitle  := "Valores de ICMS"
Local cHelp   := "Lista valores de ICMS entre Nota Fiscal,Livro Fiscal e Mapa Resumo(Somente Cupom Fiscal)"
Local oReport
Local oSection1
Local cPicture:=PesqPict("SD2","D2_VALICM")

oReport := TReport():New('NCIWMR01',cTitle,cPerg,{|oReport| ReportPrint(oReport,cQryAlias)},cHelp)
oSection1 := TRSection():New(oReport,"Valores ICMS",{"SD2","SFT"})

TRCell():New(oSection1,"D2_FILIAL" 	, cQryAlias	, "Filial")
TRCell():New(oSection1,"D2_PDV"	   	, cQryAlias	, "PDV")
TRCell():New(oSection1,"D2_EMISSAO"	, cQryAlias	, "Emissao")
TRCell():New(oSection1,"D2_VALICM" 	, cQryAlias	, "ICMS Nota")
TRCell():New(oSection1,"FT_VALICM" 	, cQryAlias	, "ICMS Livro")
TRCell():New(oSection1,"DIFNFLF" 	, cQryAlias	, "Dif. NF_LF",cPicture)
TRCell():New(oSection1,"MAPA"		,"SFI"	,"Mapa",cPicture,14	,/*lPixel*/,{|| MapaResumo( cQryAlias  )  }	)
TRCell():New(oSection1,"DIFMAPA"	,"SFI"	,"Dif. LF_Mapa",cPicture,14	,/*lPixel*/,{|| Abs(  (cQryAlias)->FT_VALICM -MapaResumo( cQryAlias  )   )  }	)


oBreak := TRBreak():New(oSection1,oSection1:Cell("D2_FILIAL"),,.F.)
TRFunction():New(oSection1:Cell("D2_VALICM"),"TOTAL FILIAL","SUM",oBreak,,cPicture,,.F.,.F.) 
TRFunction():New(oSection1:Cell("FT_VALICM"),"TOTAL FILIAL","SUM",oBreak,,cPicture,,.F.,.F.) 
TRFunction():New(oSection1:Cell("DIFNFLF")	,"TOTAL FILIAL","SUM",oBreak,,cPicture,,.F.,.F.) 
TRFunction():New(oSection1:Cell("MAPA")		,"TOTAL FILIAL","SUM",oBreak,,cPicture,,.F.,.F.)    
TRFunction():New(oSection1:Cell("DIFMAPA")	,"TOTAL FILIAL","SUM",oBreak,,cPicture,,.F.,.F.) 

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
Local aAreaAtu:=GetArea()
Local oSecao1 := oReport:Section(1)

BeginSQL Alias cQryAlias
	
	COLUMN D2_EMISSAO AS DATE
	
	SELECT D2_PDV,D2_FILIAL,D2_EMISSAO,D2_VALICM,NVL(FT_VALICM,0) FT_VALICM,ABS(D2_VALICM-NVL(FT_VALICM,0)) DIFNFLF
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
	GROUP BY D2_FILIAL,D2_PDV,D2_EMISSAO) Tab1
	LEFT OUTER JOIN            
	(SELECT FT_FILIAL,FT_PDV,FT_ENTRADA,SUM(NVL(FT_VALICM,0)) FT_VALICM
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
	On Tab1.D2_FILIAL=Tab2.FT_FILIAL
	And Tab1.D2_EMISSAO=Tab2.FT_ENTRADA
	And Tab1.D2_PDV=Tab2.FT_PDV
	//And Tab1.D2_CF=Tab2.FT_CFOP
	//And Tab1.D2_VALICM<>Tab2.FT_VALICM
	//and ABS(D2_VALICM-FT_VALICM) >1
	ORDER BY Tab1.D2_FILIAL,Tab1.D2_EMISSAO	
EndSQL  
oSecao1:Init()

Do While (cQryAlias)->(!Eof()) 

	If oReport:Cancel()
		Exit
	EndIf                            
	
	oReport:SetMsgPrint("Imprimindo Filial "+(cQryAlias)->D2_FILIAL+" Dia:"+DTOC((cQryAlias)->D2_EMISSAO) )
	
	If (cQryAlias)->(ABS(D2_VALICM-FT_VALICM)) >1		
		oSecao1:PrintLine()                    
	EndIf
	
		
	(cQryAlias)->(DbSkip())
EndDo 
oSecao1:Finish()
(cQryAlias)->(DbCloseArea())
RestArea(aAreaAtu)
//oReport:SetMeter(0)
//oSecao1:Print()
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

PutSx1(cPerg,"01","Da Filial  ","","","MV_CH1" ,"C",02,0,0,"G","                                                            ","XM0","   "," ","MV_PAR01","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")
PutSx1(cPerg,"02","Ate Filial ","","","MV_CH2","C",02,0,0,"G","                                                            ","XM0","   "," ","MV_PAR02","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")

PutSx1(cPerg,"03","Da Emissao","","","MV_CH3","D",8,0,0,"G","                                                            ","      ","   "," ","MV_PAR03","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")
PutSx1(cPerg,"04","Ate Emissao","","","MV_CH4","D",8,0,0,"G","                                                            ","      ","   "," ","MV_PAR04","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")


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
