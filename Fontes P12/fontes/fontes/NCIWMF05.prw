#Include "PROTHEUS.CH "


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NCIWMF05 ºAutor  ³Microsiga 	          º Data ³ 07/04/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Relatorio detalhado do contas a receber, referente a 		  º±±
±±º          ³integração com Web Manager					    		  º±±
±±º          ³												    		  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NC Games                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function NCIWMF05()

Local aArea 	:= GetArea()
Local aParam    := {}    
Local oReport

Private cArqWM := GetNextAlias()


//Grava os dados no arquivo temporario
If PergRel(@aParam)

	//Cria a tabela temporaria
	TabTmpIMW()
	

	//Grava os dados do relatorio na tabela temporaria	
	Processa({||; 
				GetDadosRel(aParam[1],;//Data de emissão no web manager inicial
							aParam[2],;//Data de emissão no web manager final
							aParam[3],;//Filial de
							aParam[4],;//Filial até 
							aParam[5],;//Tipo Financeiro Web manager de
							aParam[6],;//Tipo Financeiro Web manager ate
							); 
				}, "Aguarde...", "Processando os dados...") 	

	//Imprime o relatorio
	oReport := ReportDef()
	oReport:PrintDialog()

	(cArqWM)->(DbCloseArea())
EndIf	                 

RestArea(aArea)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³PergRel	ºAutor  ³Microsiga		     º Data ³  17/02/2012 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Perguntas a serem utilizadas no filtro do relatorio        º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Ap		                                                  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PergRel(aParams)

Local aParamBox := {}
Local llRet      := .T.

AADD(aParamBox,{1,"Emissão WM de: "		,CtoD("//")						,"@D"	,"","","",70,.F.})
AADD(aParamBox,{1,"Emissão WM até: "	,CtoD("//")						,"@D"	,"","","",70,.F.})
AADD(aParamBox,{1,"Filial de:"			,Space(TAMSX3("E1_FILIAL")[1])	,"@!"	,"","SM0","",70,.F.})
AADD(aParamBox,{1,"Filial até:"			,Space(TAMSX3("E1_FILIAL")[1])	,"@!"	,"","SM0","",70,.F.})
AADD(aParamBox,{1,"Tipo Finan.WM de:"	,Space(TAMSX3("PZP_CODFIN")[1])	,"@!"	,"","PZU","",70,.F.})
AADD(aParamBox,{1,"Tipo Finan.WM até:"	,Space(TAMSX3("PZP_DESCFI")[1])	,"@!"	,"","PZU","",70,.F.})

llRet := ParamBox(aParamBox, "Parâmetros", aParams, , /*alButtons*/, .T., /*nlPosx*/, /*nlPosy*/,, /*clLoad*/, .t., .t.)

Return llRet



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportDef ºAutor  ³Microsiga           º Data ³  13/09/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Definicao do objeto do relatorio personalizavel e das		  º±±
±±º          ³secoes que serao utilizadas                                 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NC Games                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef()

Local oReport 
Local oSection1                      
Local cNomeprog := "NCIWMF05"
Local oTotal1
Local oBreak1  
Local oTotal2
Local oBreak2  
Local oBreak3
Local oTotal7

oReport:= TReport():New(cNomeprog,"Relatório Movimento de Caixa (Detalhado))",;
							"", {|oReport| ReportPrint(oReport)},"Relatório Movimento de Caixa (Detalhado)")
oReport:SetLandscape(.F.)    
oreport:DisableOrientation()

oSection1 := TRSection():New(oReport,"Relatório Movimento de Caixa (Detalhado)",cArqWM)
oSection1:SetHeaderPage()
oSection1:lReadOnly := .T. 
oSection1:SetTotalInLine(.T.)  


TRCell():New(oSection1,"YYY_FILIAL"	,cArqWM,"Filial"		,/*Picture*/	,/*Tamanho*/TAMSX3("E1_FILIAL")[1]		,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
TRCell():New(oSection1,"YYY_NOMELJ"	,cArqWM,"Nome Loja"		,/*Picture*/	,/*Tamanho*/30							,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
TRCell():New(oSection1,"YYY_EMISSA"	,cArqWM,"Dt.Movimento"	,/*Picture*/	,/*Tamanho*/TAMSX3("E1_EMISSAO")[1]+5	,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
TRCell():New(oSection1,"YYY_CODFIN"	,cArqWM,"Cod.Fin.WM"	,/*Picture*/	,/*Tamanho*/TAMSX3("PZP_CODFIN")[1]		,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
TRCell():New(oSection1,"YYY_DESCFI"	,cArqWM,"Desc.Fin.WM"	,/*Picture*/	,/*Tamanho*/20							,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
TRCell():New(oSection1,"YYY_CODWM"	,cArqWM,"Cod.WM"		,/*Picture*/	,/*Tamanho*/TAMSX3("E1_YCODWM")[1]-10		,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
TRCell():New(oSection1,"YYY_PREIX"	,cArqWM,"Prefixo"		,/*Picture*/	,/*Tamanho*/TAMSX3("E1_PREFIXO")[1]+5	,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
TRCell():New(oSection1,"YYY_NUM"	,cArqWM,"Titulo"		,/*Picture*/	,/*Tamanho*/TAMSX3("E1_NUM")[1]+5		,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
TRCell():New(oSection1,"YYY_PARCEL"	,cArqWM,"Parcela"		,/*Picture*/	,/*Tamanho*/TAMSX3("E1_PARCELA")[1]+5	,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
TRCell():New(oSection1,"YYY_TIPO"	,cArqWM,"Tipo"			,/*Picture*/	,/*Tamanho*/TAMSX3("E1_TIPO")[1]+5		,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
TRCell():New(oSection1,"YYY_NATUR"	,cArqWM,"Natureza"		,/*Picture*/	,/*Tamanho*/TAMSX3("E1_NATUREZ")[1]		,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
TRCell():New(oSection1,"YYY_CLIENT"	,cArqWM,"Cliente"		,/*Picture*/	,/*Tamanho*/TAMSX3("E1_CLIENTE")[1]		,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
TRCell():New(oSection1,"YYY_LOJA"	,cArqWM,"Loja"			,/*Picture*/	,/*Tamanho*/TAMSX3("E1_LOJA")[1]		,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
TRCell():New(oSection1,"YYY_NOMCLI"	,cArqWM,"Nome" 			,/*Picture*/	,/*Tamanho*/15							,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
TRCell():New(oSection1,"YYY_VENCRE"	,cArqWM,"Dt.Vencto." 	,/*Picture*/	,/*Tamanho*/TAMSX3("E1_VENCREA")[1]+5	,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
TRCell():New(oSection1,"YYY_VALOR"	,cArqWM,"Valor"			,"@E 999,999.99",/*Tamanho*/TAMSX3("E1_VALOR")[1]		,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)


oBreak1:= TRBreak():New( oSection1, {|| (cArqWM)->YYY_FILIAL + (cArqWM)->YYY_CODFIN }	,"Total:")  
oBreak2:= TRBreak():New( oSection1, {|| (cArqWM)->YYY_FILIAL }	,"Total Loja:")  
oBreak3:= TRBreak():New( oSection1, {|| (cArqWM)->(Eof())}		, "Total Geral:")                                           


//Total por tipo financeiro
oTotal1:= TRFunction():New(oSection1:Cell("YYY_VALOR")	,/* cID */,"SUM",oBreak1,"Total: "		,"@E 999,999,999,999.99",/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)

//Total por loja
oTotal2:= TRFunction():New(oSection1:Cell("YYY_VALOR")	,/* cID */,"SUM",oBreak2,"Total Loja: "		,"@E 999,999,999,999.99",/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
        

//Total Geral
oTotal7:= TRFunction():New(oSection1:Cell("YYY_VALOR")	,/* cID */,"SUM",oBreak3,"Total Geral"	,"@E 999,999,999,999.99",/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)

Return oReport


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportPrint ºAutor  ³Microsiga         º Data ³  13/09/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Preenchimento dos dados a ser impresso no relatório		  º±±
±±º          ³                                 							  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NC Games                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportPrint(oReport)

Local aArea 	:= GetArea()
Local oSection1 := oReport:Section(1) 
Local nX		:= 0

DbSelectArea(cArqWM)
DbSetOrder(1)
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
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GetDadosRel ºAutor  ³Microsiga          º Data ³ 07/04/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Retorna o arquivo temporario com os dados do relatorio	  º±±
±±º          ³												    		  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NC Games                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GetDadosRel(dDtIni, dDtFin, cFilDe, cFilAte, cTpFinWMDe, cTpFinWMAte)

Local aArea 		:= GetArea()
Local cQuery		:= ""
Local cArqTmp		:= GetNextAlias()
Local nCnt			:= 0
Local cEmpAux		:= Alltrim(U_MyNewSX6("NC_NCWMEMP",;
									"01",;
									"C",;
									"Empresa com a tabela intermediaria de integração Web Manager x Protheus",;
									"Empresa com a tabela intermediaria de integração Web Manager x Protheus",;
									"Empresa com a tabela intermediaria de integração Web Manager x Protheus",;
									.F. ))

									


Default dDtIni		:= CTOD('') 
Default dDtFin		:= CTOD('')
Default cFilDe		:= "" 
Default cFilAte		:= ""
Default cTpFinWMDe	:= "" 
Default cTpFinWMAte	:= ""

cQuery	:= " SELECT * FROM "+RetFullName("PZP", cEmpAux)+CRLF
cQuery	+= " WHERE PZP_FILIAL = '"+xFilial("PZP", cEmpAux)+"'  "+CRLF      
cQuery	+= " AND PZP_CODFIN BETWEEN '"+cTpFinWMDe+"' AND '"+cTpFinWMAte+"' "+CRLF
cQuery	+= " AND PZP_DTMOVI BETWEEN '"+DtoS(dDtIni)+"' AND '"+DtoS(dDtFin)+"' "+CRLF
cQuery	+= " AND PZP_EMPORI = '"+cEmpAnt+"' "+CRLF
cQuery	+= " AND PZP_FILORI BETWEEN '"+cFilDe+"' AND '"+cFilAte+"' "+CRLF
cQuery	+= " AND D_E_L_E_T_ = ' ' "+CRLF
cQuery	+= " ORDER BY PZP_EMISSA, PZP_CODFIN, PZP_DESCFI, PZP_LOJA, PZP_CODMOV, PZP_SEQ "+CRLF

dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cArqTmp,.T.,.T.)

(cArqTmp)->( DbGoTop() )
(cArqTmp)->( dbEval( {|| nCnt++ },,{ || !Eof() } ) )
(cArqTmp)->( DbGoTop() )

ProcRegua(nCnt)

While (cArqTmp)->(!Eof())

	IncProc("Processando...")

	//Grava os dados na tabela temporaria    
	GrvTmpIMW(Alltrim((cArqTmp)->PZP_PREFIX),;//Prefixo
			 Alltrim((cArqTmp)->PZP_NUM),;//Titulo
			 Alltrim((cArqTmp)->PZP_PARCEL),;//Parcela
			 Alltrim((cArqTmp)->PZP_TIPO),;//Tipo
			 Alltrim((cArqTmp)->PZP_FILORI),;//Filial origem
			 Alltrim((cArqTmp)->PZP_NOMELJ),;//Nome da loja Web Manager	
			 Alltrim((cArqTmp)->PZP_CODFIN),;//Codigo financeiro Web Manager
			 Alltrim((cArqTmp)->PZP_DESCFI))//Descrição Financeiro Web manager
	
	(cArqTmp)->(DbSkip())
EndDo

(cArqTmp)->(DbCloseArea())
RestArea(aArea)
Return                   


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³TabTmpIMW  ºAutor  ³Microsiga        º Data ³  13/02/15 	  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±³Descri‡…o ³ Cria a tabela temporaria com os dados do relatorio		  ³±±
±±³          ³ 					                                          ³±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NC Games                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function TabTmpIMW()

Local aArea 	:= GetArea()
Local aCmp		:= {}
Local cArq		:= ""


aAdd (aCmp, {"YYY_EMISSA"	,"D", TAMSX3("E1_EMISSAO")[1]	,	0})
aAdd (aCmp, {"YYY_CODFIN"	,"C", TAMSX3("PZP_CODFIN")[1]	,	0})
aAdd (aCmp, {"YYY_DESCFI"	,"C", TAMSX3("PZP_DESCFI")[1]	,	0})
aAdd (aCmp, {"YYY_CODWM"	,"C", TAMSX3("E1_YCODWM")[1]	,	0})
aAdd (aCmp, {"YYY_PREIX"	,"C", TAMSX3("E1_PREFIXO")[1]	,	0})
aAdd (aCmp, {"YYY_NUM"		,"C", TAMSX3("E1_NUM")[1]		,	0})
aAdd (aCmp, {"YYY_PARCEL"	,"C", TAMSX3("E1_PARCELA")[1]	,	0})
aAdd (aCmp, {"YYY_TIPO"		,"C", TAMSX3("E1_TIPO")[1]		,	0})
aAdd (aCmp, {"YYY_NATUR"	,"C", TAMSX3("E1_NATUREZ")[1]	,	0})
aAdd (aCmp, {"YYY_CLIENT"	,"C", TAMSX3("E1_CLIENTE")[1]	,	0})
aAdd (aCmp, {"YYY_LOJA"		,"C", TAMSX3("E1_LOJA")[1]		,	0})
aAdd (aCmp, {"YYY_NOMCLI"	,"C", TAMSX3("E1_NOMCLI")[1]	,	0})
aAdd (aCmp, {"YYY_VENCRE"	,"D", TAMSX3("E1_VENCREA")[1]	,	0})
aAdd (aCmp, {"YYY_VALOR"	,"N", TAMSX3("E1_VALOR")[1]		,	TAMSX3("E1_VALOR")[2]})
aAdd (aCmp, {"YYY_FILIAL"	,"C", TAMSX3("E1_FILIAL")[1]	,	0})
aAdd (aCmp, {"YYY_NOMELJ"	,"C", TAMSX3("PZP_NOMELJ")[1]	,	0})

cArq	:=	CriaTrab(aCmp)
DbUseArea (.T., __LocalDriver, cArq, cArqWM)

IndRegua (cArqWM, cArq, "YYY_FILIAL+YYY_CODFIN+DTOS(YYY_EMISSA)+YYY_CODWM")

RestArea(aArea)
Return 



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GrvTmpIMW  ºAutor  ³Microsiga        º Data ³  13/02/15 	  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±³Descri‡…o ³ Grava os dados na tabela temporaria 						  ³±±
±±³          ³ 					                                          ³±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NC Games                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GrvTmpIMW(cPrefix, cTitulo, cParcela, cTipo, cFilOrigem, cNomeLoja, cCodFinWM, cDescFinWM)

Local aArea 	:= GetArea() 
Local cQuery    := ""
Local cArqTmp	:= GetNextAlias()

Default cPrefix		:= "" 
Default cTitulo		:= "" 
Default cParcela	:= "" 
Default cTipo		:= "" 
Default cFilOrigem	:= ""
Default cNomeLoja	:= ""
Default cCodFinWM	:= "" 
Default cDescFinWM	:= ""

cQuery    := " SELECT E1_EMISSAO, E1_YCODWM, E1_FILORIG, E1_PREFIXO, E1_NUM, E1_PARCELA, E1_TIPO, E1_NATUREZ, E1_CLIENTE, "
cQuery    += " E1_LOJA, A1_NOME, E1_VENCREA, E1_VALOR FROM "+RetFullName("SE1")+" SE1 "+CRLF

cQuery    += " INNER JOIN "+RetFullName("SA1")+" SA1 "+CRLF
cQuery    += " ON SA1.A1_FILIAL = '"+xFilial("SE1")+"' "+CRLF
cQuery    += " AND SA1.A1_COD = SE1.E1_CLIENTE "+CRLF
cQuery    += " AND SA1.A1_LOJA = SE1.E1_LOJA "+CRLF
cQuery    += " AND SA1.D_E_L_E_T_ = ' ' "

cQuery    += " WHERE SE1.E1_FILIAL = '"+xFilial("SE1")+"' "+CRLF
cQuery    += " AND SE1.E1_PREFIXO = '"+cPrefix+"' "+CRLF
cQuery    += " AND SE1.E1_NUM = '"+cTitulo+"' "+CRLF
cQuery    += " AND SE1.E1_PARCELA = '"+cParcela+"' "+CRLF
cQuery    += " AND SE1.E1_TIPO = '"+cTipo+"' "+CRLF
cQuery    += " AND SE1.D_E_L_E_T_ = ' ' "+CRLF
                                                               
dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cArqTmp,.T.,.T.)  


While (cArqTmp)->(!Eof())

	Reclock(cArqWM, .T.)
	(cArqWM)->YYY_EMISSA	:= STOD((cArqTmp)->E1_EMISSAO)
	(cArqWM)->YYY_CODFIN	:= cCodFinWM
	(cArqWM)->YYY_DESCFI    := cDescFinWM
	(cArqWM)->YYY_CODWM		:= (cArqTmp)->E1_YCODWM
	(cArqWM)->YYY_FILIAL	:= (cArqTmp)->E1_FILORIG
	(cArqWM)->YYY_PREIX		:= (cArqTmp)->E1_PREFIXO
	(cArqWM)->YYY_NUM		:= (cArqTmp)->E1_NUM
	(cArqWM)->YYY_PARCEL	:= (cArqTmp)->E1_PARCELA
	(cArqWM)->YYY_TIPO		:= (cArqTmp)->E1_TIPO
	(cArqWM)->YYY_NATUR		:= (cArqTmp)->E1_NATUREZ
	(cArqWM)->YYY_CLIENT	:= (cArqTmp)->E1_CLIENTE
	(cArqWM)->YYY_LOJA		:= (cArqTmp)->E1_LOJA
	(cArqWM)->YYY_NOMCLI	:= (cArqTmp)->A1_NOME
	(cArqWM)->YYY_VENCRE	:= STOD((cArqTmp)->E1_VENCREA)
	(cArqWM)->YYY_VALOR		:= (cArqTmp)->E1_VALOR
	(cArqWM)->YYY_NOMELJ	:= cNomeLoja
	(cArqWM)->(MsUnLock())
	
	(cArqTmp)->(DbSkip())
EndDo

(cArqTmp)->(DbCloseArea())
RestArea(aArea)
Return