#Include "PROTHEUS.CH "


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCIWMF06 �Autor  �Microsiga 	          � Data � 07/04/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �Relatorio resumido do contas a receber, referente a 		  ���
���          �integra��o com Web Manager					    		  ���
���          �												    		  ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function NCIWMF06()

Local aArea 	:= GetArea()
Local aParam    := {}    
Local oReport

Private cArqWM := GetNextAlias()


//Grava os dados no arquivo temporario
If PergRel(@aParam)

	//Cria a tabela temporaria com os dados do relatorio
	TabTmpIMW()
	

	//Grava os dados do relatorio na tabela temporaria	
	Processa({||; 
				GetDadosRel(aParam[1],;//Data de emiss�o no web manager inicial
							aParam[2],;//Data de emiss�o no web manager final
							aParam[3],;//Filial de
							aParam[4],;//Filial at� 
							aParam[5],;//Tipo Financeiro Web manager de
							aParam[6],;//Tipo Financeiro Web manager ate
							aParam[7]);//Tipo do relatorio (Sintetico / Analitico) 
				}, "Aguarde...", "Processando os dados...") 	

	//Imprime o relatorio
	oReport := NCReportDef(aParam)
	oReport:PrintDialog()

	(cArqWM)->(DbCloseArea())
EndIf	                 

RestArea(aArea)
Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Funcao    �PergRel	�Autor  �Microsiga		     � Data �  17/02/2012 ���
�������������������������������������������������������������������������͹��
���Desc.     � Perguntas a serem utilizadas no filtro do relatorio        ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Ap		                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function PergRel(aParams)

Local aParamBox := {}
Local llRet      := .T.

AADD(aParamBox,{1,"Emiss�o de: "		,CtoD("//")						,"@D"	,"","","",70,.F.})
AADD(aParamBox,{1,"Emiss�o at�: "		,CtoD("//")						,"@D"	,"","","",70,.F.})
AADD(aParamBox,{1,"Filial de:"			,Space(TAMSX3("E1_FILIAL")[1])	,"@!"	,"","SM0","",70,.F.})
AADD(aParamBox,{1,"Filial at�:"			,Space(TAMSX3("E1_FILIAL")[1])	,"@!"	,"","SM0","",70,.F.})
AADD(aParamBox,{1,"Tipo Finan.WM de:"	,Space(TAMSX3("PZP_CODFIN")[1])	,"@!"	,"","PZU","",70,.F.})
AADD(aParamBox,{1,"Tipo Finan.WM at�:"	,Space(TAMSX3("PZP_CODFIN")[1])	,"@!"	,"","PZU","",70,.F.})  
AADD(aParamBox,{2,"Tipo do Relat�rio: "	,"1"							, {"1=Sint�tico","2=Anal�tico"}	, 70,".T."					,.F.})

llRet := ParamBox(aParamBox, "Par�metros", aParams, , /*alButtons*/, .T., /*nlPosx*/, /*nlPosy*/,, /*clLoad*/, .t., .t.)

Return llRet



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �ReportDef �Autor  �Elton C.            � Data �  13/09/13   ���
�������������������������������������������������������������������������͹��
���Desc.     �Definicao do objeto do relatorio personalizavel e das		  ���
���          �secoes que serao utilizadas                                 ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function NCReportDef(aParam)

Local oReport 
Local oSection1
Local cNomeprog := "NCIWMF06"
Local oTotal1
Local oTotal2
Local oTotal3
Local oTotal4
Local oBreak1  
Local oBreak2
Local oBreak3
Local oBreak4
Local cTitFun	:= ""
             

Default aParam := {}

oReport:= TReport():New(cNomeprog,"Relat�rio Movimento de Caixa","", {|oReport| ReportPrint(oReport)},"Relatorio movimento de caixa.")
oReport:SetLandscape(.F.)    
oreport:DisableOrientation()

oSection1 := TRSection():New(oReport,"Relatorio movimento de caixa.",cArqWM)
oSection1:SetHeaderPage()
oSection1:lReadOnly := .T. 
oSection1:SetTotalInLine(.T.)  


DbSelectArea(cArqWM)
DbSetOrder(1)

//Sintetico
If aParam[7] == "1"

	TRCell():New(oSection1,"YYY_FILIAL"	,cArqWM,"Filial"		,/*Picture*/	,/*Tamanho*/TAMSX3("E1_FILIAL")[1]		,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
	TRCell():New(oSection1,"YYY_NOMELJ"	,cArqWM,"Nome Loja"		,/*Picture*/	,/*Tamanho*/40							,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
	TRCell():New(oSection1,"YYY_CODFIN"	,cArqWM,"Cod.Financeiro",/*Picture*/	,/*Tamanho*/TAMSX3("PZP_CODFIN")[1]		,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
	TRCell():New(oSection1,"YYY_DESCFI"	,cArqWM,"Descri��o"		,/*Picture*/	,/*Tamanho*/30/*TAMSX3("PZP_DESCFI")[1]-60*/	,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
	TRCell():New(oSection1,"YYY_VALOR"	,cArqWM,"Valor"			,"@E 999,999.99",/*Tamanho*/10		,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*//*"RIGHT"*/,,/*"RIGHT"*//*"RIGHT"*/,,,.F.)
    
   
	
	//Quebra por processo (Faturamento ou Pagamento)
	oBreak1:= TRBreak():New( oSection1, {|| (cArqWM)->YYY_FILIAL + (cArqWM)->YYY_PROCESS }, "Total ",.F.)  
	oBreak1:OnBreak({|x,y| cTitFun := " Total "+SubStr(x,3,Len(x))}) 
   	oBreak1:SetTotalText({||cTitFun})
	
	//Quebra por loja
	oBreak2:= TRBreak():New( oSection1, {|| (cArqWM)->YYY_FILIAL  }, "Total Loja (Faturamento - Pagamento):" )  
	
	//Total geral
	oBreak3:= TRBreak():New( oSection1, {|| (cArqWM)->(Eof())}		,"Total Geral:")                                           


	oTotal1:= TRFunction():New(oSection1:Cell("YYY_VALOR")	,/* cID */,"SUM",oBreak1,""	,"@E 999,999,999,999.99",/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
	oTotal2:= TRFunction():New(oSection1:Cell("YYY_VALOR")	,/* cID */,"SUM",oBreak2,""	,"@E 999,999,999,999.99",/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
	oTotal3:= TRFunction():New(oSection1:Cell("YYY_VALOR")	,/* cID */,"SUM",oBreak3,""	,"@E 999,999,999,999.99",/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)



Else//Analitico

	TRCell():New(oSection1,"YYY_FILIAL"	,cArqWM,"Filial"		,/*Picture*/	,/*Tamanho*/TAMSX3("E1_FILIAL")[1]		,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
	TRCell():New(oSection1,"YYY_NOMELJ"	,cArqWM,"Nome Loja"		,/*Picture*/	,/*Tamanho*/40							,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
	TRCell():New(oSection1,"YYY_CODFIN"	,cArqWM,"Cod.Financeiro",/*Picture*/	,/*Tamanho*/TAMSX3("PZP_CODFIN")[1]		,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
	TRCell():New(oSection1,"YYY_DESCFI"	,cArqWM,"Descri��o"		,/*Picture*/	,/*Tamanho*/30/*TAMSX3("PZP_DESCFI")[1]-60*/	,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
	TRCell():New(oSection1,"YYY_EMISSA"	,cArqWM,"Dt.Movimento"	,/*Picture*/	,/*Tamanho*/TAMSX3("E1_EMISSAO")[1]+5	,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)
	TRCell():New(oSection1,"YYY_VALOR"	,cArqWM,"Valor"			,"@E 999,999.99",/*Tamanho*/10		,/*lPixel*/,/*{|| code-block de impressao }*/, /*"RIGHT"*/,,/*"RIGHT"*/,,,.F.)


	//Quebra por tipo financeiro 
	oBreak4:= TRBreak():New( oSection1, {|| (cArqWM)->YYY_FILIAL + (cArqWM)->YYY_PROCESS + (cArqWM)->YYY_CODFIN }, "Total Tp.Financeiro",.F.)  


	//Quebra por processo (Faturamento ou Pagamento)
	oBreak1:= TRBreak():New( oSection1, {|| (cArqWM)->YYY_FILIAL + (cArqWM)->YYY_PROCESS }, "Total ",.F.)  
	oBreak1:OnBreak({|x,y| cTitFun := " Total "+SubStr(x,3,Len(x))}) 
   	oBreak1:SetTotalText({||cTitFun})
	
	//Quebra por loja
	oBreak2:= TRBreak():New( oSection1, {|| (cArqWM)->YYY_FILIAL  }, "Total Loja (Faturamento - Pagamento):" )  
	
	//Total geral
	oBreak3:= TRBreak():New( oSection1, {|| (cArqWM)->(Eof())}		,"Total Geral:")                                           

    //Totalizadores
	oTotal4:= TRFunction():New(oSection1:Cell("YYY_VALOR")	,/* cID */,"SUM",oBreak4,""	,"@E 999,999,999,999.99",/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
	oTotal1:= TRFunction():New(oSection1:Cell("YYY_VALOR")	,/* cID */,"SUM",oBreak1,""	,"@E 999,999,999,999.99",/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
	oTotal2:= TRFunction():New(oSection1:Cell("YYY_VALOR")	,/* cID */,"SUM",oBreak2,""	,"@E 999,999,999,999.99",/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)
	oTotal3:= TRFunction():New(oSection1:Cell("YYY_VALOR")	,/* cID */,"SUM",oBreak3,""	,"@E 999,999,999,999.99",/*uFormula*/,.F./*lEndSection*/,.F./*lEndReport*/,.F./*lEndPage*/)

EndIf

//oSection1:Cell("YYY_PROCES"):Hide()

Return oReport


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �ReportPrint �Autor  �Microsiga         � Data �  13/09/13   ���
�������������������������������������������������������������������������͹��
���Desc.     �Preenchimento dos dados a ser impresso no relat�rio		  ���
���          �                                 							  ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
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
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �GetDadosRel �Autor  �Microsiga          � Data � 07/04/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �Retorna o arquivo temporario com os dados do relatorio	  ���
���          �												    		  ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function GetDadosRel(dDtIni, dDtFin, cFilDe, cFilAte, cTpFinWMDe, cTpFinWMAte, cTpRel)

Local aArea 		:= GetArea()
Local cQuery		:= ""
Local cArqTmp		:= GetNextAlias()
Local nCnt			:= 0
Local cEmpAux		:= Alltrim(U_MyNewSX6("NC_NCWMEMP",;
									"01",;
									"C",;
									"Empresa com a tabela intermediaria de integra��o Web Manager x Protheus",;
									"Empresa com a tabela intermediaria de integra��o Web Manager x Protheus",;
									"Empresa com a tabela intermediaria de integra��o Web Manager x Protheus",;
									.F. ))

									


Default dDtIni		:= CTOD('') 
Default dDtFin		:= CTOD('')
Default cFilDe		:= "" 
Default cFilAte		:= ""
Default cTpFinWMDe	:= "" 
Default cTpFinWMAte	:= "" 
Default cTpRel		:= ""

//Sintetico
If Alltrim(cTpRel) == "1"

	cQuery	:= "  SELECT 'Faturamento' as PROCESSO, PZP_CODFIN, PZP_DESCFI, ' ' as PZP_EMISSA, "+CRLF
	cQuery	+= " PZP_EMPORI, PZP_FILORI, PZP_NOMELJ, SUM(PZP_VLOPER) PZP_VLOPER FROM "+RetFullName("PZP", cEmpAux)+" PZP "+CRLF
  
 	cQuery	+= " WHERE PZP_FILIAL = '"+xFilial("PZP",cEmpAux)+"'  "+CRLF
	cQuery	+= " AND PZP_CODFIN BETWEEN '"+cTpFinWMDe+"' AND '"+cTpFinWMAte+"' "+CRLF
	cQuery	+= " AND PZP_DTMOVI BETWEEN '"+DtoS(dDtIni)+"' AND '"+DtoS(dDtFin)+"' "+CRLF
	cQuery	+= " AND PZP_EMPORI = '"+cEmpAnt+"' "+CRLF
	cQuery	+= " AND PZP_FILORI BETWEEN '"+cFilDe+"' AND '"+cFilAte+"' "+CRLF

	cQuery	+= "  AND PZP.PZP_PREFIX != ' ' "+CRLF
	cQuery	+= "  AND PZP.D_E_L_E_T_ = ' ' "+CRLF
	cQuery	+= "  GROUP BY PZP_CODFIN, PZP_DESCFI, PZP_EMPORI, PZP_FILORI, PZP_NOMELJ  "+CRLF

 
	cQuery	+= "  UNION ALL "+CRLF
	cQuery	+= "  SELECT 'Pagamento' as PROCESSO, PZP_CODFIN, PZP_DESCFI, ' ' as PZP_EMISSA, PZP_EMPORI, "+CRLF
	cQuery	+= " PZP_FILORI, PZP_NOMELJ, SUM(CASE WHEN PZP_VLOPER > 0 THEN PZP_VLOPER*-1 ELSE PZP_VLOPER END) PZP_VLOPER FROM "+RetFullName("PZP", cEmpAux)+" PZP "+CRLF
 
	cQuery	+= "  WHERE PZP_FILIAL = '"+xFilial("PZP")+"'  "+CRLF
	cQuery	+= " AND PZP_CODFIN BETWEEN '"+cTpFinWMDe+"' AND '"+cTpFinWMAte+"' "+CRLF
	cQuery	+= " AND PZP_DTMOVI BETWEEN '"+DtoS(dDtIni)+"' AND '"+DtoS(dDtFin)+"' "+CRLF
	cQuery	+= " AND PZP_EMPORI = '"+cEmpAnt+"' "+CRLF
	cQuery	+= " AND PZP_FILORI BETWEEN '"+cFilDe+"' AND '"+cFilAte+"' "+CRLF
	cQuery	+= " AND PZP.PZP_PREFIX != ' ' "+CRLF
	cQuery	+= " AND PZP.D_E_L_E_T_ = ' ' "+CRLF
	cQuery	+= " AND (EXISTS (SELECT * FROM "+RetSqlName("PZO")+" PZO "+CRLF
	cQuery	+= "               WHERE PZO.PZO_FILIAL = '"+xFilial("PZO")+"' "+CRLF
	cQuery	+= "               AND PZO.PZO_IDFPAG = PZP.PZP_CODFIN "+CRLF
	cQuery	+= "               AND PZO.PZO_COMPEN = '2' "+CRLF
	cQuery	+= "               AND PZO.D_E_L_E_T_ = ' ') 
	cQuery	+= " 		OR PZP_OPER = 'DV' ) "+CRLF
 
	cQuery	+= " GROUP BY PZP_CODFIN, PZP_DESCFI, PZP_EMPORI, PZP_FILORI, PZP_NOMELJ  "+CRLF
	cQuery	+= " ORDER BY PZP_EMPORI, PZP_FILORI, PROCESSO, PZP_CODFIN "+CRLF

Else//Analitico
	cQuery	:= "  SELECT 'Faturamento' as PROCESSO, PZP_CODFIN, PZP_DESCFI, PZP_EMISSA, "+CRLF
	cQuery	+= " PZP_EMPORI, PZP_FILORI, PZP_NOMELJ, SUM(PZP_VLOPER) PZP_VLOPER FROM "+RetFullName("PZP", cEmpAux)+" PZP "+CRLF
  
 	cQuery	+= " WHERE PZP_FILIAL = '"+xFilial("PZP")+"'  "+CRLF
	cQuery	+= " AND PZP_CODFIN BETWEEN '"+cTpFinWMDe+"' AND '"+cTpFinWMAte+"' "+CRLF
	cQuery	+= " AND PZP_DTMOVI BETWEEN '"+DtoS(dDtIni)+"' AND '"+DtoS(dDtFin)+"' "+CRLF
	cQuery	+= " AND PZP_EMPORI BETWEEN '"+cEmpAnt+"' AND '"+cEmpAnt+"' "+CRLF
	cQuery	+= " AND PZP_FILORI BETWEEN '"+cFilDe+"' AND '"+cFilAte+"' "+CRLF

	cQuery	+= "  AND PZP.PZP_PREFIX != ' ' "+CRLF
	cQuery	+= "  AND PZP.D_E_L_E_T_ = ' ' "+CRLF
	cQuery	+= "  GROUP BY PZP_CODFIN, PZP_DESCFI, PZP_EMISSA, PZP_EMPORI, PZP_FILORI, PZP_NOMELJ  "+CRLF

 
	cQuery	+= "  UNION ALL "+CRLF
	cQuery	+= "  SELECT 'Pagamento' as PROCESSO, PZP_CODFIN, PZP_DESCFI, PZP_EMISSA, PZP_EMPORI, "+CRLF
	cQuery	+= " PZP_FILORI, PZP_NOMELJ, ((SUM(PZP_VLOPER))*-1) PZP_VLOPER FROM "+RetFullName("PZP", cEmpAux)+" PZP "+CRLF
 
	cQuery	+= "  WHERE PZP_FILIAL = '"+xFilial("PZP")+"'  "+CRLF
	cQuery	+= " AND PZP_CODFIN BETWEEN '"+cTpFinWMDe+"' AND '"+cTpFinWMAte+"' "+CRLF
	cQuery	+= " AND PZP_DTMOVI BETWEEN '"+DtoS(dDtIni)+"' AND '"+DtoS(dDtFin)+"' "+CRLF
	cQuery	+= " AND PZP_EMPORI BETWEEN '"+cEmpAnt+"' AND '"+cEmpAnt+"' "+CRLF
	cQuery	+= " AND PZP_FILORI BETWEEN '"+cFilDe+"' AND '"+cFilAte+"' "+CRLF
	cQuery	+= " AND PZP.PZP_PREFIX != ' ' "+CRLF
	cQuery	+= " AND PZP.D_E_L_E_T_ = ' ' "+CRLF
	cQuery	+= " AND EXISTS (SELECT * FROM "+RetSqlName("PZO")+" PZO "+CRLF
	cQuery	+= "               WHERE PZO.PZO_FILIAL = '"+xFilial("PZO")+"' "+CRLF
	cQuery	+= "               AND PZO.PZO_IDFPAG = PZP.PZP_CODFIN "+CRLF
	cQuery	+= "               AND PZO.PZO_COMPEN = '2' "+CRLF
	cQuery	+= "               AND PZO.D_E_L_E_T_ = ' ') "+CRLF
 
	cQuery	+= " GROUP BY PZP_CODFIN, PZP_DESCFI, PZP_EMISSA, PZP_EMPORI, PZP_FILORI, PZP_NOMELJ  "+CRLF
	cQuery	+= " ORDER BY PZP_EMPORI, PZP_FILORI, PROCESSO, PZP_CODFIN "+CRLF
EndIf

cQuery := ChangeQuery(cQuery)

dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cArqTmp,.T.,.T.)

(cArqTmp)->( DbGoTop() )
(cArqTmp)->( dbEval( {|| nCnt++ },,{ || !Eof() } ) )
(cArqTmp)->( DbGoTop() )

ProcRegua(nCnt)

While (cArqTmp)->(!Eof())

	IncProc("Processando...")
	
	GrvTmpIMW((cArqTmp)->PZP_EMPORI,;//Empresa 
	 			(cArqTmp)->PZP_FILORI,; //Filial
	 			(cArqTmp)->PZP_NOMELJ,; //Nome da loja
	 			(cArqTmp)->PZP_EMISSA,; //Data de emissao
	 			(cArqTmp)->PZP_CODFIN,; //Codigo financeiro
	 			(cArqTmp)->PZP_DESCFI,; //Descri��o
	 			(cArqTmp)->PZP_VLOPER,; //Valor da opera��o
	 			(cArqTmp)->PROCESSO )//Descri��o do processo(Faturamento ou Pagamento)

	(cArqTmp)->(DbSkip())
EndDo

(cArqTmp)->(DbCloseArea())
RestArea(aArea)
Return                   


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �TabTmpIMW  �Autor  �Microsiga        � Data �  13/02/15 	  ���
�������������������������������������������������������������������������͹��
���Descri��o � Cria a tabela temporaria com os dados do relatorio		  ���
���          � 					                                          ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function TabTmpIMW()

Local aArea 	:= GetArea()
Local aCmp		:= {}
Local cArq		:= ""


aAdd (aCmp, {"YYY_EMISSA"	,"D", TAMSX3("E1_EMISSAO")[1]	,	0})
aAdd (aCmp, {"YYY_CODFIN"	,"C", TAMSX3("PZP_CODFIN")[1]	,	0})
aAdd (aCmp, {"YYY_DESCFI"	,"C", TAMSX3("PZP_DESCFI")[1]	,	0})
aAdd (aCmp, {"YYY_VALOR"	,"N", TAMSX3("E1_VALOR")[1]		,	TAMSX3("E1_VALOR")[2]})
aAdd (aCmp, {"YYY_EMPRES"	,"C", 2							,	0})
aAdd (aCmp, {"YYY_FILIAL"	,"C", TAMSX3("E1_FILIAL")[1]	,	0})
aAdd (aCmp, {"YYY_NOMELJ"	,"C", TAMSX3("PZP_NOMELJ")[1]	,	0})
aAdd (aCmp, {"YYY_PROCES"	,"C", 11						,	0})

cArq	:=	CriaTrab(aCmp)
DbUseArea (.T., __LocalDriver, cArq, cArqWM)

IndRegua (cArqWM, cArq, "YYY_EMPRES+YYY_FILIAL+YYY_PROCESS+YYY_CODFIN+DTOS(YYY_EMISSA)")

RestArea(aArea)
Return 



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �GrvTmpIMW  �Autor  �Microsiga        � Data �  13/02/15 	  ���
�������������������������������������������������������������������������͹��
���Descri��o � Grava os dados na tabela temporaria 						  ���
���          � 					                                          ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function GrvTmpIMW(cEmpOrigem, cFilOrigem, cNomeLoja, cEmissao, cCodFinWM, cDescFinWM, nValor, cProcesso)

Local aArea 	:= GetArea() 

Default cEmpOrigem	:= "" 
Default cFilOrigem	:= ""                                 
Default cNomeLoja	:= ""                                 
Default cEmissao	:= ""
Default cCodFinWM	:= "" 
Default cDescFinWM	:= ""                                                     
Default nValor		:= 0
Default cProcesso	:= ""

Reclock(cArqWM, .T.)

If !Empty(cEmissao)
	(cArqWM)->YYY_EMISSA	:= stod(cEmissao)
Else
	(cArqWM)->YYY_EMISSA	:= CTOD('')
EndIf

(cArqWM)->YYY_CODFIN	:= cCodFinWM
(cArqWM)->YYY_DESCFI    := cDescFinWM
(cArqWM)->YYY_VALOR		:= nValor
(cArqWM)->YYY_EMPRES 	:= cEmpOrigem
(cArqWM)->YYY_FILIAL	:= cFilOrigem
(cArqWM)->YYY_NOMELJ	:= cNomeLoja
(cArqWM)->YYY_PROCES	:= cProcesso
(cArqWM)->(MsUnLock())
	

RestArea(aArea)
Return