#INCLUDE "PROTHEUS.CH "

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCIWMF11 บAutor  ณMicrosiga 	          บ Data ณ 07/04/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRelatorio para analise de de baixa e concilia็ใo			  บฑฑ
ฑฑบ          ณdos titulos (Conta a Receber)					    		  บฑฑ
ฑฑบ          ณ												    		  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NCIWMF07                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/          
User Function NCIWMF11(lTBxConc, cFilAuxDe, cFilAuxAte, cGrpTpFin, dDtIni, dDtFin, cOpcConc)

Local aArea 		:= GetArea()
Local oReport                                                                    
Local aParams		:= {}
Private cArqWM	:= GetNextAlias() 	

Default lTBxConc 		:= .F.
Default cFilAuxDe		:= "" 
Default cFilAuxAte	:= "" 
Default cGrpTpFin		:= "" 
Default dDtIni		:= CTOD('') 
Default dDtFin 		:= CTOD('')
Default cOpcConc		:= ""

If lTBxConc
	
	If VldPesqTit(cFilAuxAte, cGrpTpFin, dDtIni, dDtFin)//Valida็ใo dos parametros
		GetDRel(cFilAuxDe, cFilAuxAte, cGrpTpFin, dDtIni, dDtFin, cOpcConc)
	Else
		RestArea(aArea)
		Return
	EndIf
	
Else
	If PRelWM11(@aParams)
		If VldPesqTit(aParams[3], aParams[1], aParams[4], aParams[5])//Valida็ใo dos parametros
			GetDRel(aParams[2], aParams[3], aParams[1], aParams[4], aParams[5], aParams[6])
		Else
			RestArea(aArea)
			Return
		EndIf
	EndIf
EndIf

//Rotina de impressใo do relat๓rio
oReport := ReportDef()
oReport:PrintDialog()

//Fecha o arquivo temporario
If !Empty(cArqWM) .And. Select(cArqWM) > 0
	dbSelectArea(cArqWM)
	(cArqWM)->(dbCloseArea())
EndIf

RestArea(aArea)      
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณReportDef บAutor  ณMicrosiga           บ Data ณ  13/09/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณDefinicao do objeto do relatorio personalizavel e das		  บฑฑ
ฑฑบ          ณsecoes que serao utilizadas                                 บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ReportDef()

Local oReport 
Local oSection1     
Local oBreak1
Local oBreak2                 
Local oTotal1
Local oTotal2

oReport:= TReport():New("NCIWMF11","Titulos Provenientes do Web Manager",;
							"", {|oReport| ReportPrint(oReport)},"Relat๓rio para analise dos tํtulos provenientes do Web Manager")
oReport:SetLandscape(.F.)    
oreport:DisableOrientation()

oSection1 := TRSection():New(oReport,"Titulos Provenientes do Web Manager",/*(cArqTmp)*/)
oSection1:SetHeaderPage()
oSection1:lReadOnly := .T. 
oSection1:SetTotalInLine(.T.)  

TRCell():New(oSection1,"YYY_FILORI"	,cArqWM,"Filial"		,/*Picture*/,/*Tamanho*/30,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
TRCell():New(oSection1,"YYY_NOMELJ"	,cArqWM,"Nome Loja"	,/*Picture*/,/*Tamanho*/80,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
TRCell():New(oSection1,"YYY_PREFIX"	,cArqWM,"Prefixo"		,/*Picture*/,/*Tamanho*/30,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
TRCell():New(oSection1,"YYY_NUM"		,cArqWM,"Titulo"		,/*Picture*/,/*Tamanho*/40,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
TRCell():New(oSection1,"YYY_PARCEL"	,cArqWM,"Parcela"		,/*Picture*/,/*Tamanho*/40,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
TRCell():New(oSection1,"YYY_TIPO"		,cArqWM,"Tipo"		,/*Picture*/,/*Tamanho*/40,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
TRCell():New(oSection1,"YYY_CLIENT"	,cArqWM,"Cliente"		,/*Picture*/,/*Tamanho*/30,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
TRCell():New(oSection1,"YYY_LOJA"		,cArqWM,"Loja"		,/*Picture*/,/*Tamanho*/30,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
TRCell():New(oSection1,"YYY_NOMCLI"	,cArqWM,"Nome"		,/*Picture*/,/*Tamanho*/40,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
TRCell():New(oSection1,"YYY_EMISSA"	,cArqWM,"Emissใo"		,/*Picture*/,/*Tamanho*/40,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
TRCell():New(oSection1,"YYY_VENCRE"	,cArqWM,"Vencimento"	,/*Picture*/,/*Tamanho*/40,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
TRCell():New(oSection1,"YYY_VALOR"		,cArqWM,"Valor" 		,/*Picture*/,/*Tamanho*/40,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
TRCell():New(oSection1,"YYY_YCODWM"	,cArqWM,"Codigo WM"	,/*Picture*/,/*Tamanho*/40,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
TRCell():New(oSection1,"YYY_YCUPOM"	,cArqWM,"Cupom"		,/*Picture*/,/*Tamanho*/40,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)


//Quebra por loja
oBreak1:= TRBreak():New( oSection1, {|| (cArqWM)->YYY_FILORI  }, "Total Loja:" )

//Total geral
oBreak2:= TRBreak():New( oSection1, {|| (cArqWM)->(Eof())}		,"Total Geral:")

oTotal1:= TRFunction():New(oSection1:Cell("YYY_VALOR")	,/* cID */,"SUM",oBreak1,""	,"@E 999,999,999,999.99",/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
oTotal2:= TRFunction():New(oSection1:Cell("YYY_VALOR")	,/* cID */,"SUM",oBreak2,""	,"@E 999,999,999,999.99",/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)

Return oReport


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณReportPrint บAutor  ณMicrosiga         บ Data ณ  13/09/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณPreenchimento dos dados a ser impresso no relat๓rio		  บฑฑ
ฑฑบ          ณ                                 							  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ReportPrint(oReport)

Local aArea 	:= GetArea()
Local oSection1 := oReport:Section(1)

DbSelectArea(cArqWM)
(cArqWM)->(DbGoTop())

oSection1:Init()
oReport:SetMeter(LastRec())
While (cArqWM)->(!Eof()	)
	
	oReport:IncMeter()
	oSection1:PrintLine()
	
	(cArqWM)->(DbSkip())
EndDo

oSection1:Finish()

RestArea(aArea)
Return NIL  


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณPRelWM11	บAutor  ณMicrosiga		     บ Data ณ  17/02/2012 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Perguntas a serem utilizadas no filtro do relatorio        บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Ap		                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PRelWM11(aParams)

Local aParamBox 	:= {}
Local lRet      	:= .T.
Local aCombConc	:= {"1=Sim","2=Nใo","3=Todos"}

AADD(aParamBox,{1,"Tp.Financeiro:"		,Space(TAMSX3("PZS_COD")[1])	,"@!"	,"","PZS","",70,.F.})
AADD(aParamBox,{1,"Filial de:"			,Space(TAMSX3("E1_FILIAL")[1])	,"@!"	,"","SM0","",70,.F.})
AADD(aParamBox,{1,"Filial at้:"			,Space(TAMSX3("E1_FILIAL")[1])	,"@!"	,"","SM0","",70,.F.})
AADD(aParamBox,{1,"Emissใo de: "		,CtoD("//")						,"@D"	,"","","",70,.F.})
AADD(aParamBox,{1,"Emissใo at้: "		,CtoD("//")						,"@D"	,"","","",70,.F.})
AADD(aParamBox,{2,"Conciliados C.Card ?"									,"1"	, aCombConc	, 70,".T."	,.F.})

lRet := ParamBox(aParamBox, "Parโmetros", aParams, , /*alButtons*/, .T., /*nlPosx*/, /*nlPosy*/,, /*clLoad*/, .t., .t.)

Return lRet



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGetDRel บAutor  ณMicrosiga 	          บ Data ณ 07/04/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRetorna o arquivo temporario com os dados do relatorio	  บฑฑ
ฑฑบ          ณ												    		  บฑฑ
ฑฑบ          ณ												    		  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetDRel(cFilAuxDe, cFilAuxAte, cGrpTpFin, dDtIni, dDtFin, cOpcConc)

Local aArea 	:= GetArea()
Local cQuery  := ""
Local cArqTmp	:= ""
Local lAddAux := .F.
Local nCnt		:= 1
Local cEmpAux	:= Alltrim(U_MyNewSX6("NC_NCWMEMP",;
									"01",;
									"C",;
									"Empresa com a tabela intermediaria de integra็ใo Web Manager x Protheus",;
									"Empresa com a tabela intermediaria de integra็ใo Web Manager x Protheus",;
									"Empresa com a tabela intermediaria de integra็ใo Web Manager x Protheus",;
									.F. ))


Default cFilAuxDe		:= "" 
Default cFilAuxAte	:= ""                         
Default cGrpTpFin		:= ""                                 
Default dDtIni		:= ctod('') 
Default dDtFin 		:= ctod('')
Default cOpcConc		:= ""

//Cria a tabela temporaria
TabTmpICC()


cArqTmp	:= GetNextAlias()


cQuery	:= " SELECT E1_FILORIG, PZP_NOMELJ, E1_PREFIXO, E1_NUM, E1_PARCELA,  E1_TIPO, E1_CLIENTE, E1_LOJA, "+CRLF
cQuery	+= "     E1_NOMCLI, E1_EMISSAO, E1_VALOR, E1_VENCREA, E1_YCODWM, E1_YCUPOM FROM "+RetSqlName("SE1")+" SE1 "+CRLF

cQuery	+= "  INNER JOIN "+RetFullName("PZP", cEmpAux)+" PZP "+CRLF
cQuery	+= "  ON PZP.PZP_FILIAL = '"+xFilial("PZP", cEmpAux)+"' "+CRLF
cQuery	+= "  AND PZP.PZP_CODMOV = SE1.E1_YCODWM "+CRLF
cQuery	+= "  AND PZP.PZP_PREFIX = SE1.E1_PREFIXO "+CRLF
cQuery	+= "  AND PZP.PZP_NUM = SE1.E1_NUM "+CRLF
cQuery	+= "  AND PZP.PZP_PARCEL = SE1.E1_PARCELA "+CRLF
cQuery	+= "  AND PZP.PZP_TIPO = SE1.E1_TIPO "+CRLF
cQuery	+= "  AND PZP.D_E_L_E_T_ = ' ' "+CRLF

cQuery	+= "  INNER JOIN "+RetSqlName("PZT")+" PZT "+CRLF
cQuery	+= "  ON PZT.PZT_FILIAL = '"+xFilial("PZT")+"' "+CRLF
cQuery	+= "  AND PZT.PZT_COD = '"+cGrpTpFin+"' "+CRLF
cQuery	+= "  AND PZT.PZT_CODFIN = PZP.PZP_CODFIN "+CRLF
cQuery	+= "  AND PZT.D_E_L_E_T_ = ' ' "+CRLF

cQuery	+= "  WHERE SE1.E1_FILIAL = '"+xFilial("SE1")+"' "+CRLF
cQuery	+= "  AND SE1.E1_TIPO NOT IN('RA','NCC') "+CRLF
cQuery	+= "  AND SE1.E1_EMISSAO BETWEEN '"+Dtos(dDtIni)+"' AND '"+Dtos(dDtFin)+"'  "+CRLF
cQuery	+= "  AND SE1.E1_FILORIG BETWEEN '"+cFilAuxDe+"' AND '"+cFilAuxAte+"' "+CRLF
cQuery	+= "  AND SE1.E1_SALDO > '0' "+CRLF
cQuery	+= "  AND SE1.D_E_L_E_T_ = ' ' "+CRLF
cQuery	+= " ORDER BY E1_FILORIG, E1_EMISSAO, E1_PREFIXO, E1_NUM, E1_PARCELA, E1_TIPO "+CRLF

dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cArqTmp,.T.,.T.)

TCSETFIELD( cArqTmp,"E1_EMISSAO","D")
TCSETFIELD( cArqTmp,"E1_VENCREA","D")

(cArqTmp)->( DbGoTop() )
(cArqTmp)->( dbEval( {|| nCnt++ },,{ || !Eof() } ) )
(cArqTmp)->( DbGoTop() )

ProcRegua(nCnt)

DbSelectArea(cArqWM)
While (cArqTmp)->(!Eof())

	IncProc("Aguarde, carregando arquivo temporแrio...")

	lAddAux := .F.
	
	If Alltrim(cOpcConc) $ "1|2"//1=Conciliados | 2=Nao Conciliados   
		If VldConc((cArqTmp)->E1_YCODWM, cOpcConc)
			lAddAux := .T.
		EndIf
	Else
		lAddAux := .T.
	EndIf
	
	//Grava os dados na tabela Temporaria
	If lAddAux	
		Reclock(cArqWM,.T.)
		(cArqWM)->YYY_FILORI		:= (cArqTmp)->E1_FILORIG
		(cArqWM)->YYY_NOMELJ   	:= (cArqTmp)->PZP_NOMELJ 
		(cArqWM)->YYY_PREFIX  	:= (cArqTmp)->E1_PREFIXO
		(cArqWM)->YYY_NUM      	:= (cArqTmp)->E1_NUM    
		(cArqWM)->YYY_PARCEL  	:= (cArqTmp)->E1_PARCELA
		(cArqWM)->YYY_TIPO     	:= (cArqTmp)->E1_TIPO   
		(cArqWM)->YYY_CLIENT  	:= (cArqTmp)->E1_CLIENTE
		(cArqWM)->YYY_LOJA     	:= (cArqTmp)->E1_LOJA   
		(cArqWM)->YYY_NOMCLI   	:= (cArqTmp)->E1_NOMCLI 
		(cArqWM)->YYY_EMISSA  	:= (cArqTmp)->E1_EMISSAO
		(cArqWM)->YYY_VENCRE  	:= (cArqTmp)->E1_VENCREA
		(cArqWM)->YYY_VALOR    	:= (cArqTmp)->E1_VALOR  
		(cArqWM)->YYY_YCODWM   	:= (cArqTmp)->E1_YCODWM 
		(cArqWM)->YYY_YCUPOM   	:= (cArqTmp)->E1_YCUPOM 		
		(cArqWM)->(MsUnLock())	
	EndIf
		
	(cArqTmp)->(DbSkip())
EndDo


(cArqTmp)->(DbCloseArea())
RestArea(aArea)
Return
                     
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณTabTmpICC  บAutor  ณMicrosiga        บ Data ณ  13/02/15 	บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑณDescri…o ณ Integra็ใo com C.CARD										  	ณฑฑ
ฑฑณ          ณ 					                                          ณฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function TabTmpICC()

Local aArea 	:= GetArea()
Local aCmp		:= {}
Local cArq		:= ""


aAdd (aCmp, {"YYY_FILORI"	,"C", TAMSX3("E1_FILORIG")[1]	,	0})
aAdd (aCmp, {"YYY_NOMELJ"	,"C", TAMSX3("PZP_NOMELJ")[1]	,	0})
aAdd (aCmp, {"YYY_PREFIX"	,"C", TAMSX3("E1_PREFIXO")[1]	,	0})
aAdd (aCmp, {"YYY_NUM"		,"C", TAMSX3("E1_NUM")[1]		,	0})
aAdd (aCmp, {"YYY_PARCEL"	,"C", TAMSX3("E1_PARCELA")[1]	,	0})
aAdd (aCmp, {"YYY_TIPO"		,"C", TAMSX3("E1_TIPO")[1]		,	0})
aAdd (aCmp, {"YYY_CLIENT"	,"C", TAMSX3("E1_CLIENTE")[1]	,	0})
aAdd (aCmp, {"YYY_LOJA"		,"C", TAMSX3("E1_LOJA")[1]		,	0})
aAdd (aCmp, {"YYY_NOMCLI"	,"C", TAMSX3("E1_NOMCLI")[1]	,	0})
aAdd (aCmp, {"YYY_EMISSA"	,"D", TAMSX3("E1_EMISSAO")[1]	,	0})
aAdd (aCmp, {"YYY_VENCRE"	,"D", TAMSX3("E1_VENCREA")[1]	,	0})
aAdd (aCmp, {"YYY_VALOR"		,"N", TAMSX3("E1_VALOR")[1]		,	TAMSX3("E1_VALOR")[2]})
aAdd (aCmp, {"YYY_YCODWM"	,"C", TAMSX3("E1_YCODWM")[1]	,	0})
aAdd (aCmp, {"YYY_YCUPOM"	,"C", TAMSX3("E1_YCUPOM")[1]	,	0})



cArq	:=	CriaTrab (aCmp)
DbUseArea (.T., __LocalDriver, cArq, cArqWM)
IndRegua (cArqWM, cArq, "YYY_FILORI+YYY_PREFIX+YYY_NUM+YYY_PARCEL+YYY_TIPO")

RestArea(aArea)
Return                      
                     


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณVldPesqTit บAutor  ณMicrosiga 	      บ Data ณ 07/04/15   	บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณValida็ใo dos parametros da pesquisa						  	บฑฑ
ฑฑบ          ณ		    		  										  		บฑฑ
ฑฑบ          ณ												    		  		บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC Games                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function VldPesqTit(cFilAuxAte, cGrpTpFin, dDtIni, dDtFin)

Local aArea 	:= GetArea()
Local lRet		:= .T.
Local cMsg		:= "Campo(s) obrigat๓rio(s) nใo preenchido(s): "+CRLF+CRLF
Local cMsgAux   := ""

Default cFilAuxAte	:= "" 
Default cGrpTpFin	:= "" 
Default dDtIni		:= CTOD('')
Default dDtFin  	:= CTOD('')

If Empty(cGrpTpFin)
	cMsgAux   += "-Tp.Financeiro; "+CRLF
	lRet := .F.
EndIf

If Empty(cFilAuxAte)
	cMsgAux   += "-Filial at้; "+CRLF
	lRet := .F.
EndIf

If Empty(dDtIni)
	cMsgAux   += "-Dt.Movimento de; "+CRLF
	lRet := .F.
EndIf

If Empty(dDtIni)
	cMsgAux   += "-Dt.Movimento ate; "+CRLF
	lRet := .F.
EndIf

If !lRet
    Aviso("Aten็ใo",cMsg+cMsgAux, {"Ok"}, 3 )	
EndIf

RestArea(aArea)
Return lRet

