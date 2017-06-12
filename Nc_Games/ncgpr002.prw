#include 'protheus.ch'
#include "rwmake.ch"
#include "topconn.ch"
#include "tbiconn.ch"
#include "shell.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR002  บAutor  ณMicrosiga           บ Data ณ  12/13/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ  RELATORIO DE COMPARACAO ENTRE A REDUCAO Z E O LIVRO FISCALบฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NcGames                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NCGPR002()
Local aAreaAtu	   :=GetArea()
Local aAreaSB1	   :=SB1->(GetArea())
Local aAreaSB2	   :=SB2->(GetArea())
Local cPerg  		:= 'NCGPR002'
Local cQryAlias 	:= GetNextAlias()
Local oReport
Local cNomeTmp
Private cProduto:=""
Private cProdAux:=""

SB2->(DbSetOrder(1))

PutSx1(cPerg,"01","Da  Emissao",".",".","MV_CH1","D",08,0,0,"G","","","   "," ","MV_PAR01","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")
PutSx1(cPerg,"02","Ate Emissao",".",".","MV_CH2","D",08,0,0,"G","","","   "," ","MV_PAR02","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")
PutSx1(cPerg,"03","Aliquotas",".",".","MV_CH3","C",40,0,0,"G","","","   "," ","MV_PAR03","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")

oReport := ReportDef(cQryAlias, cPerg,@cNomeTmp)
oReport:PrintDialog()

If Select(cQryAlias)>0
	(cQryAlias)->(DbCloseArea())
EndIf

RestArea(aAreaSB1)
RestArea(aAreaSB2)
RestArea(aAreaAtu)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR002  บAutor  ณMicrosiga           บ Data ณ  05/06/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ReportDef(cQryAlias,cPerg,cNomeTmp)
Local cTitle  := "Relat๓rio Resumo Reducao Z x Livro Fiscal"
Local aOrdem    := {}
Local cHelp   := ""
Local oReport
Local oSection1
Local oBreak
Local MV_PAR03 := ALLTRIM(MV_PAR03)
Pergunte(cPerg,.T.)
oReport := TReport():New('NCGPR002',cTitle,cPerg,{|oReport| ReportPrint(oReport,@cQryAlias,aOrdem)},cHelp)
oReport:SetLandscape()
oSection1 := TRSection():New(oReport,"Relat๓rio Resumo Reducao Z x Livro Fiscal",{cQryAlias},aOrdem)
oBreak1 := TRBreak():New(oSection1,{|| "datamov" },"Total:",.F.)

//TRCell():New(oSection1,"FI_FILIAL"	,cQryAlias	,"Filial"	,/*Picture*/,,/*lPixel*/,/*{|| PrintList(1)  }*/)
TRCell():New(oSection1,"datamov"	,cQryAlias	,"Data Mov"	   ,/*Picture*/,,/*lPixel*/,/*{|| PrintList(1)  }*/)
TRCell():New(oSection1,"valcontz"	,cQryAlias	,"Val. Cont."	   ,"@E 9,999,999.99",,/*lPixel*/,/*{|| PrintList(1)  }*/)
TRFunction():New(oSection1:Cell("valcontz" ), "TOT1", "SUM", oBreak1,,,, .F., .F.)
IF !EMPTY(MV_PAR03) .AND. ('07' $ MV_PAR03)
	TRCell():New(oSection1,"bas07z"	,cQryAlias	,"BASE 7%RZ"	   ,"@E 9,999,999.99",,/*lPixel*/,/*{|| PrintList(1)  }*/)
	TRCell():New(oSection1,"bas07"		,cQryAlias	,"BASE 7%LF"	   ,"@E 9,999,999.99",,/*lPixel*/,/*{|| PrintList(1)  }*/)
	TRCell():New(oSection1,"val07z"		,cQryAlias	,"VAL 7%RZ"	   ,"@E 9,999,999.99",,/*lPixel*/,/*{|| PrintList(1)  }*/)
	TRCell():New(oSection1,"val07"		,cQryAlias	,"VAL 7%LF"	   ,"@E 9,999,999.99",,/*lPixel*/,/*{|| PrintList(1)  }*/)
	TRFunction():New(oSection1:Cell("bas07z" ), "TOT2", "SUM", oBreak1,,,, .F., .F.)
	TRFunction():New(oSection1:Cell("bas07" ), "TOT3", "SUM", oBreak1,,,, .F., .F.)
	TRFunction():New(oSection1:Cell("val07z" ), "TOT4", "SUM", oBreak1,,,, .F., .F.)
	TRFunction():New(oSection1:Cell("val07" ), "TOT5", "SUM", oBreak1,,,, .F., .F.)
ENDIF
IF !EMPTY(MV_PAR03) .AND. ('12' $ MV_PAR03)
	TRCell():New(oSection1,"bas12z"	,cQryAlias	,"BASE 12%RZ"	   ,"@E 9,999,999.99",,/*lPixel*/,/*{|| PrintList(1)  }*/)
	TRCell():New(oSection1,"bas12"		,cQryAlias	,"BASE 12%LF"	   ,"@E 9,999,999.99",,/*lPixel*/,/*{|| PrintList(1)  }*/)
	TRCell():New(oSection1,"val12z"		,cQryAlias	,"VAL 12%RZ"	   ,"@E 9,999,999.99",,/*lPixel*/,/*{|| PrintList(1)  }*/)
	TRCell():New(oSection1,"val12"		,cQryAlias	,"VAL 12%LF"	   ,"@E 9,999,999.99",,/*lPixel*/,/*{|| PrintList(1)  }*/)
	TRFunction():New(oSection1:Cell("bas12z" ), "TOT6", "SUM", oBreak1,,,, .F., .F.)
	TRFunction():New(oSection1:Cell("bas12" ), "TOT7", "SUM", oBreak1,,,, .F., .F.)
	TRFunction():New(oSection1:Cell("val12z" ), "TOT8", "SUM", oBreak1,,,, .F., .F.)
	TRFunction():New(oSection1:Cell("val12" ), "TOT9", "SUM", oBreak1,,,, .F., .F.)
	
ENDIF
IF !EMPTY(MV_PAR03) .AND. ('18' $ MV_PAR03)
	TRCell():New(oSection1,"bas18z"	,cQryAlias	,"BASE 18%RZ"	   ,"@E 9,999,999.99",,/*lPixel*/,/*{|| PrintList(1)  }*/)
	TRCell():New(oSection1,"bas18"		,cQryAlias	,"BASE 18%LF"	   ,"@E 9,999,999.99",,/*lPixel*/,/*{|| PrintList(1)  }*/)
	TRCell():New(oSection1,"val18z"		,cQryAlias	,"VAL 18%RZ"	   ,"@E 9,999,999.99",,/*lPixel*/,/*{|| PrintList(1)  }*/)
	TRCell():New(oSection1,"val18"		,cQryAlias	,"VAL 18%LF"	   ,"@E 9,999,999.99",,/*lPixel*/,/*{|| PrintList(1)  }*/)
	TRFunction():New(oSection1:Cell("bas18z" ), "TOT10", "SUM", oBreak1,,,, .F., .F.)
	TRFunction():New(oSection1:Cell("bas18" ), "TOT11", "SUM", oBreak1,,,, .F., .F.)
	TRFunction():New(oSection1:Cell("val18z" ), "TOT12", "SUM", oBreak1,,,, .F., .F.)
	TRFunction():New(oSection1:Cell("val18" ), "TOT13", "SUM", oBreak1,,,, .F., .F.)
	
ENDIF
IF !EMPTY(MV_PAR03) .AND. ('25' $ MV_PAR03)
	TRCell():New(oSection1,"bas25z"	,cQryAlias	,"BASE 25%RZ"	   ,"@E 9,999,999.99",,/*lPixel*/,/*{|| PrintList(1)  }*/)
	TRCell():New(oSection1,"bas25"		,cQryAlias	,"BASE 25%LF"	   ,"@E 9,999,999.99",,/*lPixel*/,/*{|| PrintList(1)  }*/)
	TRCell():New(oSection1,"val25z"		,cQryAlias	,"VAL 25%RZ"	   ,"@E 9,999,999.99",,/*lPixel*/,/*{|| PrintList(1)  }*/)
	TRCell():New(oSection1,"val25"		,cQryAlias	,"VAL 25%LF"	   ,"@E 9,999,999.99",,/*lPixel*/,/*{|| PrintList(1)  }*/)
	TRFunction():New(oSection1:Cell("bas25z" ), "TOT14", "SUM", oBreak1,,,, .F., .F.)
	TRFunction():New(oSection1:Cell("bas25" ), "TOT15", "SUM", oBreak1,,,, .F., .F.)
	TRFunction():New(oSection1:Cell("val25z" ), "TOT16", "SUM", oBreak1,,,, .F., .F.)
	TRFunction():New(oSection1:Cell("val25" ), "TOT17", "SUM", oBreak1,,,, .F., .F.)
ENDIF

	TRCell():New(oSection1,"DIFBASE"		,cQryAlias	,"DIF BASE"	   ,"@E 9,999,999.99",,/*lPixel*/,/*{|| PrintList(1)  }*/)
	TRCell():New(oSection1,"DIFVALOR"		,cQryAlias	,"DIF VALOR"	   ,"@E 9,999,999.99",,/*lPixel*/,/*{|| PrintList(1)  }*/)
	TRFunction():New(oSection1:Cell("DIFBASE" ), "TOT18", "SUM", oBreak1,,,, .F., .F.)
	TRFunction():New(oSection1:Cell("DIFVALOR" ), "TOT19", "SUM", oBreak1,,,, .F., .F.)

Return(oReport)
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGPR002  บAutor  ณMicrosiga           บ Data ณ  05/06/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ReportPrint(oReport,cQryAlias,aOrdem)
Local oSecao1 		:= oReport:Section(1)
Local cChaveTmp
Local cNomeTmp
Local sDtIni :=Dtos(mv_par01)
Local sDtFim :=Dtos(mv_par02)

BeginSQL Alias cQryAlias
	COLUMN datamov AS DATE
	
	
	SELECT FI18.datamov,
	FI18.valcontz,
	NVL(FI18.base07z,0.0) bas07z,
	NVL(FT07.bas07,0.0) bas07,
	NVL(FI18.val07z,0.0) val07z,
	NVL(FT07.val07,0.0) val07,
	NVL(FI18.base12z,0.0) bas12z,
	NVL(FT12.bas12,0.0) bas12,
	NVL(FI18.val12z,0.0) val12z,
	NVL(FT12.val12,0.0) val12,
	NVL(FI18.base18z,0.0) bas18z,
	NVL(FT18.bas18,0.0) bas18,
	NVL(FI18.val18z,0.0) val18z,
	NVL(FT18.val18,0.0) val18,
	NVL(FI18.base25z,0.0) bas25z,
	NVL(FT25.bas25,0.0) bas25,
	NVL(FI18.val25z,0.0) val25z,
	NVL(FT25.val25,0.0) val25,
	NVL((NVL(FI18.base07z,0.0)-NVL(FT07.bas07,0.0))+(NVL(FI18.base12z,0.0)-NVL(FT12.bas12,0.0))+(NVL(FI18.base18z,0.0)-NVL(FT18.bas18,0.0))+(NVL(FI18.base25z,0.0)-NVL(FT25.bas25,0.0)),0.0) DIFBASE,
    NVL((NVL(FI18.val07z,0.0)-NVL(FT07.val07,0.0))+(NVL(FI18.val12z,0.0)-NVL(FT12.val12,0.0))+(NVL(FI18.val18z,0.0)-NVL(FT18.val18,0.0))+(NVL(FI18.val25z,0.0)-NVL(FT25.val25,0.0)),0.0) DIFVALOR
	FROM   (SELECT fi_dtmovto     DATAMOV,
	fi_valcon                     VALCONTZ,
	fi_bas7                       BASE07Z,
	Round(( fi_bas7 * 0.07 ), 2)  VAL07Z,
	fi_bas12                      BASE12Z,
	Round(( fi_bas12 * 0.12 ), 2) VAL12Z,
	fi_bas18                      BASE18Z,
	Round(( fi_bas18 * 0.18 ), 2) VAL18Z,
	fi_bas25                      BASE25Z,
	Round(( fi_bas25 * 0.25 ), 2) VAL25Z
	FROM   %Table:SFI%
	WHERE  fi_filial = %xfilial:SFI%
	AND d_e_l_e_t_ = ' '
	AND fi_dtmovto BETWEEN %exp:sDtIni% And %exp:sDtFim%) FI18
	LEFT JOIN (SELECT ft_entrada,
	Sum(ft_valcont)                  VALCONT,
	Sum(ft_baseicm)                  BAS07,
	Sum(Round(ft_baseicm * 0.07, 2)) VAL07
	FROM   %Table:SFT%
	WHERE  ft_filial = %xfilial:SFT%
	AND d_e_l_e_t_ = ' '
	AND ft_aliqicm = '07'
	AND ft_tipomov = 'S'
	AND ft_dtcanc = ' '
	GROUP  BY ft_entrada
	ORDER  BY ft_entrada)FT07
	ON FI18.datamov = FT07.ft_entrada
	LEFT JOIN (SELECT ft_entrada,
	Sum(ft_valcont)                  VALCONT,
	Sum(ft_baseicm)                  BAS12,
	Sum(Round(ft_baseicm * 0.12, 2)) VAL12
	FROM   %Table:SFT%
	WHERE  ft_filial = %xfilial:SFT%
	AND d_e_l_e_t_ = ' '
	AND ft_aliqicm = '12'
	AND ft_tipomov = 'S'
	AND ft_dtcanc = ' '
	GROUP  BY ft_entrada
	ORDER  BY ft_entrada)FT12
	ON FI18.datamov = FT12.ft_entrada
	LEFT JOIN (SELECT ft_entrada,
	Sum(ft_valcont)                  VALCONT,
	Sum(ft_baseicm)                  BAS18,
	Sum(Round(ft_baseicm * 0.18, 2)) VAL18
	FROM   %Table:SFT%
	WHERE  ft_filial = %xfilial:SFT%
	AND d_e_l_e_t_ = ' '
	AND ft_aliqicm = '18'
	AND ft_tipomov = 'S'
	AND ft_dtcanc = ' '
	GROUP  BY ft_entrada
	ORDER  BY ft_entrada)FT18
	ON FI18.datamov = FT18.ft_entrada
	LEFT JOIN (SELECT ft_entrada,
	Sum(ft_valcont)                  VALCONT,
	Sum(ft_baseicm)                  BAS25,
	Sum(Round(ft_baseicm * 0.25, 2)) VAL25
	FROM   %Table:SFT%
	WHERE  ft_filial = %xfilial:SFT%
	AND d_e_l_e_t_ = ' '
	AND ft_aliqicm = '25'
	AND ft_tipomov = 'S'
	AND ft_dtcanc = ' '
	GROUP  BY ft_entrada
	ORDER  BY ft_entrada)FT25
	ON FI18.datamov = FT25.ft_entrada
	ORDER  BY FI18.datamov
EndSQL

oSecao1:EndQuery()
oReport:SetMeter(0)
oSecao1:Print()
Return
