#Include 'Protheus.ch'



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCRCRD01 บAutor  ณMicrosiga      		 บ Data ณ  05/14/15	บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NCRCRD01()

Local aArea 	:= GetArea()
Local aParam	:= {}

If PergRel(@aParam)
	
	//Valida็ใo dos parametros
	If VldParam(aParam)
		Processa({|| GerRel(aParam) })
	EndIf
	
EndIf


RestArea(aArea)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPergRel บAutor  ณMicrosiga      		 บ Data ณ  05/14/15	บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Perguntas do relatorio                                     บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PergRel(aParam)

Local aArea 		:= GetArea()
Local aParamBox		:= {} 
Local lRet			:= .F.

Default aParam :={}		

//Monta a pergunta
AADD(aParamBox,{1,"Data de:"					,CtoD("//")							,"@D"	,"","","",70,.T.})
AADD(aParamBox,{1,"Data at้:"					,CtoD("//")							,"@D"	,"","","",70,.T.})
AADD(aParamBox,{1,"Filial de:"					,Space(TAMSX3("FT_FILIAL")[1])		,"@!"	,"","SM0","",70,.F.})
AADD(aParamBox,{1,"Filial at้:"					,Space(TAMSX3("FT_FILIAL")[1])		,"@!"	,"","SM0","",70,.T.})
AADD(aParamBox,{2,"Status retorno ?"			,"1"	, {"1=Retornadas","2=Nใo retornadas","3=Todas"}	, 70,".T."	,.F.})
AADD(aParamBox,{6,"Endere็o do relatorio: "	,"","","ExistDir(&(ReadVar()))","",070,.T.,"","",GETF_LOCALHARD+GETF_NETWORKDRIVE + GETF_RETDIRECTORY})

lRet := ParamBox(aParamBox ,"Parโmetros",@aParam,,,.T.,70,70,,,.T.,.T.)

RestArea(aArea)
Return lRet



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณVldParam บAutor  ณMicrosiga      		 บ Data ณ  05/14/15	บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Valida็ใo dos parametros do relatorio                      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function VldParam(aParam)

Local aArea 	:= GetArea()
Local lRet		:= .T.
Local cMsgAux	:= ""

Default aParam := {}

If Empty(aParam[1])
	cMsgAux	+= "'Data de' nใo preenchido."+CRLF 
	lRet		:= .F.
EndIf

If Empty(aParam[2])
	cMsgAux	+=  "'Data ate' nใo preenchido."+CRLF
	lRet		:= .F.
EndIf

If Empty(aParam[4])
	cMsgAux	+=  "'Filial ate' nใo preenchido."+CRLF
	lRet		:= .F.
EndIf

If Empty(aParam[5])
	cMsgAux	+=  "'Status retorno' nใo preenchido."+CRLF
	lRet		:= .F.
EndIf


If Empty(aParam[6])
	cMsgAux	+=  "'Endere็o do relatorio' nใo preenchido."+CRLF
	lRet		:= .F.
ElseIf !ExistDir(aParam[6])
	cMsgAux	+=  "Endere็o do arquivo nใo encontrado."+CRLF
	lRet		:= .F.	
EndIf


If !lRet
	Aviso("Aten็ใo", "Valida็ใo dos parametros: "+CRLF+CRLF+cMsgAux,{"Ok"},3)
EndIf

RestArea(aArea)
Return lRet



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGerRel  บAutor  ณMicrosiga          บ Data ณ  05/01/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณGera o relatorio		                                       บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿  
*/
Static Function GerRel(aParam)

Local aArea 		:= GetArea()
Local cQuery		:= ""
Local cArqTmp		:= GetNextAlias()
Local nCnt			:= 1
Local cNomeArq	:= "Rel_Retorno_remessa"+ DtoS(MsDate())+STRTRAN(Time(), ":", "")+".xls"
Local dDtRetAux	:= CTOD('')
Local cCFOPS		:= U_MyNewSX6("NC_CFOPRR",;
  								  		"5912|6912",;
										"C",;
										"CFOP de remessa",;
										"CFOP de remessa",;
										"CFOP de remessa",;
										.F. )
Local nDiasRet	:= U_MyNewSX6("NC_DIARETR",;
  								  		"60",;
										"N",;
										"Retorno p/ remessa",;
										"Retorno p/ remessa",;
										"Retorno p/ remessa",;
										.F. )												
Default aParam := {}

cQuery	:= " SELECT * FROM ( "+CRLF
cQuery	+= " SELECT "+CRLF  
cQuery	+= " SFT.FT_NFISCAL AS NOTA_SAIDA, "+CRLF
cQuery	+= " SFT.FT_SERIE AS SERIE_SAIDA, "+CRLF
cQuery	+= " SFT.FT_EMISSAO AS EMISSAO_SAIDA, "+CRLF
//cQuery	+= " ROUND( CURRENT_DATE - (TO_DATE(SD2.D2_EMISSAO, 'YYYYMMDD') + INTERVAL '60' DAY ) ) AS DIAS_RETORNO, "+CRLF
//cQuery	+= " SD2.D2_EMISSAO AS DATA_LIMITE_RETORNO, "+CRLF
cQuery	+= " SD2.D2_PEDIDO AS PEDIDO_VENDA, "+CRLF
cQuery	+= " SD2.D2_CLIENTE AS COD_CLIENTE, "+CRLF
cQuery	+= " SD2.D2_LOJA AS LOJA, "+CRLF
cQuery	+= " SA1.A1_NOME, " +CRLF
cQuery	+= " SD2.D2_COD PRODUTO, "+CRLF
cQuery	+= " SB1.B1_XDESC, "+CRLF
cQuery	+= " SD2.D2_CF AS CFOP_SAIDA, "+CRLF
cQuery	+= " SD2.D2_PRCVEN AS VALOR_UNITARIO,"+CRLF
cQuery	+= " SD2.D2_QUANT AS QUANT_SAIDA, "+CRLF
cQuery	+= " SD2.D2_TOTAL AS TOTAL_SAIDA, "+CRLF
cQuery	+= " SFT.FT_VALCONT AS TOTAL_CTB_SAIDA, "+CRLF
cQuery	+= " SD2.D2_BASEICM AS BASE_ICMS, "+CRLF
cQuery	+= " SD2.D2_VALICM AS VALOR_ICMS, "+CRLF
cQuery	+= " SD2.D2_BASEIPI AS BASE_IPI, "+CRLF
cQuery	+= " SD2.D2_VALIPI AS VALOR_IPI, "+CRLF
cQuery	+= " SD1.D1_DOC AS NOTA_ENTRADA, "+CRLF
cQuery	+= " SD1.D1_SERIE AS SERIE_ENTRADA, "+CRLF
cQuery	+= " SD1.D1_CF AS CFOP_ENTRADA, "+CRLF
cQuery	+= " SD1.D1_EMISSAO AS EMISSAO_ENTRADA, "+CRLF
cQuery	+= " SD1.D1_DTDIGIT AS DATA_DIGITACAO_ENTRADA "+CRLF

cQuery	+= " FROM "+RetSqlName("SFT")+" SFT "+CRLF 

cQuery	+= " INNER JOIN "+RetSqlName("SD2")+" SD2 "+CRLF 
cQuery	+= "   ON SD2.D2_FILIAL = SFT.FT_FILIAL "+CRLF
cQuery	+= "   AND SD2.D2_DOC = SFT.FT_NFISCAL "+CRLF
cQuery	+= "   AND SD2.D2_SERIE = SFT.FT_SERIE "+CRLF
cQuery	+= "   AND SD2.D2_CLIENTE = SFT.FT_CLIEFOR "+CRLF
cQuery	+= "   AND SD2.D2_LOJA = SFT.FT_LOJA "+CRLF
cQuery	+= "   AND SD2.D2_COD = SFT.FT_PRODUTO "+CRLF
cQuery	+= "   AND SD2.D_E_L_E_T_ = ' ' "+CRLF


cQuery	+= " INNER JOIN "+RetSqlName("SB1")+" SB1 "+CRLF
cQuery	+= " ON SB1.B1_FILIAL = '"+xFilial("SB1")+"' "+CRLF
cQuery	+= " AND SB1.B1_COD = SD2.D2_COD "+CRLF
cQuery	+= " AND SB1.D_E_L_E_T_ = ' ' "+CRLF

cQuery	+= " INNER JOIN "+RetSqlName("SA1")+" SA1 "+CRLF
cQuery	+= " ON SA1.A1_FILIAL = '"+xFilial("SA1")+"' "+CRLF
cQuery	+= " AND SA1.A1_COD = SD2.D2_CLIENTE "+CRLF
cQuery	+= " AND SA1.A1_LOJA = SD2.D2_LOJA "+CRLF
cQuery	+= " AND SA1.D_E_L_E_T_ = ' ' "+CRLF

cQuery	+= " LEFT JOIN "+RetSqlName("SD1")+" SD1 "+CRLF 
cQuery	+= "   ON SD1.D1_FILIAL = SD2.D2_FILIAL "+CRLF
cQuery	+= "   AND SD1.D1_NFORI = SD2.D2_DOC "+CRLF
cQuery	+= "   AND SD1.D1_SERIORI = SD2.D2_SERIE "+CRLF
cQuery	+= "   AND SD1.D1_COD = SD2.D2_COD "+CRLF
//cQuery	+= "   AND SD1.D1_FORMUL = 'S' "+CRLF
cQuery	+= "   AND SD1.D_E_L_E_T_ = ' ' "+CRLF

cQuery	+= " WHERE SFT.FT_FILIAL BETWEEN '"+aParam[3]+"' and '"+aParam[4]+"' "+CRLF 
cQuery	+= "     AND SFT.FT_EMISSAO BETWEEN '"+dtos(aParam[1])+"' AND '"+dtos(aParam[2])+"' "+CRLF
cQuery	+= "     AND SFT.FT_CFOP IN"+FormatIn(cCFOPS, "|")+CRLF
cQuery	+= "     AND SFT.FT_TIPOMOV = 'S' "+CRLF
cQuery	+= "     AND SFT.D_E_L_E_T_ = ' ' "+CRLF
cQuery	+= " ) DADOS "+CRLF

If Alltrim(aParam[5]) == "1"
	cQuery	+= " WHERE NOTA_ENTRADA != ' ' "+CRLF
ElseIf Alltrim(aParam[5]) == "2"
	cQuery	+= " WHERE (NOTA_ENTRADA = ' ' OR NOTA_ENTRADA IS NULL)"+CRLF
EndIf


dbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cArqTmp,.T.,.T.)

(cArqTmp)->( DbGoTop() )
(cArqTmp)->( dbEval( { || nCnt++ },,{ || !Eof() } ) )
(cArqTmp)->( DbGoTop() )	

ProcRegua(nCnt)


//Cabe็alho do Workbook
CabBook(Alltrim(aParam[6])+cNomeArq, aParam)

//Cabe็alho do worksheet
CabSheet(Alltrim(aParam[6])+cNomeArq, nCnt, "Relatorio")

While (cArqTmp)->(!Eof())
	
	IncProc("Processando...")
	
	dDtRetAux := 	CTOD('')
	If !Empty((cArqTmp)->DATA_DIGITACAO_ENTRADA)
		dDtRetAux := STOD((cArqTmp)->DATA_DIGITACAO_ENTRADA)
	Else
		dDtRetAux := MsDate()
	EndIf
	
	//Preenchimento das linhas do relatorio
	PrintSheet(Alltrim(aParam[6])+cNomeArq,; 			//Endere็o do arquivo
					(cArqTmp)->NOTA_SAIDA,;				//Nota de saida 
					(cArqTmp)->SERIE_SAIDA,;				//Serie de saida
					STOD((cArqTmp)->EMISSAO_SAIDA),;	//Data de emissใo de saida 	
					(STOD((cArqTmp)->EMISSAO_SAIDA)+nDiasRet)-dDtRetAux,; 			//Dias de retorno
					STOD((cArqTmp)->EMISSAO_SAIDA)+nDiasRet,;	//Data limite para retorno 
					(cArqTmp)->PEDIDO_VENDA,;			//Pedido de venda 
					(cArqTmp)->COD_CLIENTE,;				//Codigo do cliente 
					(cArqTmp)->LOJA,;						//Loja 
					(cArqTmp)->A1_NOME,;					//Nome do cliente 
					(cArqTmp)->PRODUTO,;					//Codigo do produto 
					(cArqTmp)->B1_XDESC,;				//Descri็ใo do produto
					(cArqTmp)->CFOP_SAIDA,;				//CFOP de saida 
					(cArqTmp)->VALOR_UNITARIO,;			//Valor unitario 
					(cArqTmp)->QUANT_SAIDA,;				//Quantidade 
					(cArqTmp)->TOTAL_SAIDA,; 			//Total da saida
					(cArqTmp)->TOTAL_CTB_SAIDA,;		//Total contabil	 
					(cArqTmp)->BASE_ICMS,;				//Base ICMS 
					(cArqTmp)->VALOR_ICMS,;				//Valor ICMS 
					(cArqTmp)->BASE_IPI,;				//Base IPI 
					(cArqTmp)->VALOR_IPI,;				//Valor IPI
					(cArqTmp)->NOTA_ENTRADA,; 			//Nota de Entrada
					(cArqTmp)->SERIE_ENTRADA,;			//Serie de entrada 
					(cArqTmp)->CFOP_ENTRADA,; 			//CFOP Entrada
					STOD((cArqTmp)->EMISSAO_ENTRADA),;	//Emissใo de entrada 
					STOD((cArqTmp)->DATA_DIGITACAO_ENTRADA);	//Data de digita็ใo do documento de entrada 
					) 
		
	
	(cArqTmp)->( DbSkip() )
EndDo

//Fecha o WorkSheet
CloseSheet(Alltrim(aParam[6])+cNomeArq)
              
//Fecha Workbook
CloseBook(Alltrim(aParam[6])+cNomeArq)

//Fecha o arquivo temporario
(cArqTmp)->(DbCloseArea())

//Gera o arquivo do excel
GeraExcel(Alltrim(aParam[6])+cNomeArq)


RestArea(aArea)
Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCabWkBook  บAutor  ณMicrosiga          บ Data ณ  05/01/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCabe็alho do workbook                                       บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿  
*/
Static Function CabBook(cArq, aParam)

Local aArea 		:= GetArea()
Local cDadosArq   := ""     

Default cArq 		:= ""
Default aParam	:= {}                           

If !Empty(cArq)

	cDadosArq   := '<?xml version="1.0"?>'+CRLF
	cDadosArq   += '<?mso-application progid="Excel.Sheet"?>'+CRLF
	cDadosArq   += '<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet"'+CRLF
	cDadosArq   += ' xmlns:o="urn:schemas-microsoft-com:office:office"'+CRLF
	cDadosArq   += ' xmlns:x="urn:schemas-microsoft-com:office:excel"'+CRLF
	cDadosArq   += ' xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"'+CRLF
	cDadosArq   += ' xmlns:html="http://www.w3.org/TR/REC-html40">'+CRLF
	cDadosArq   += ' <DocumentProperties xmlns="urn:schemas-microsoft-com:office:office">'+CRLF
	cDadosArq   += '  <Author>Janes Raulino Isidoro</Author>'+CRLF
	cDadosArq   += '  <LastAuthor>Elton Santana</LastAuthor>'+CRLF
	cDadosArq   += '  <Created>2016-04-14T14:03:38Z</Created>'+CRLF
	cDadosArq   += '  <LastSaved>2016-05-05T12:38:04Z</LastSaved>'+CRLF
	cDadosArq   += '  <Version>15.00</Version>'+CRLF
	cDadosArq   += ' </DocumentProperties>'+CRLF
	cDadosArq   += ' <OfficeDocumentSettings xmlns="urn:schemas-microsoft-com:office:office">'+CRLF
	cDadosArq   += '  <AllowPNG/>'+CRLF
	cDadosArq   += ' </OfficeDocumentSettings>'+CRLF
	cDadosArq   += ' <ExcelWorkbook xmlns="urn:schemas-microsoft-com:office:excel">'+CRLF
	cDadosArq   += '  <WindowHeight>9735</WindowHeight>'+CRLF
	cDadosArq   += '  <WindowWidth>24000</WindowWidth>'+CRLF
	cDadosArq   += '  <WindowTopX>0</WindowTopX>'+CRLF
	cDadosArq   += '  <WindowTopY>0</WindowTopY>'+CRLF
	cDadosArq   += '  <ActiveSheet>1</ActiveSheet>'+CRLF
	cDadosArq   += '  <ProtectStructure>False</ProtectStructure>'+CRLF
	cDadosArq   += '  <ProtectWindows>False</ProtectWindows>'+CRLF
	cDadosArq   += ' </ExcelWorkbook>'+CRLF
	cDadosArq   += ' <Styles>'+CRLF
	cDadosArq   += '  <Style ss:ID="Default" ss:Name="Normal">'+CRLF
	cDadosArq   += '   <Alignment ss:Vertical="Bottom"/>'+CRLF
	cDadosArq   += '   <Borders/>'+CRLF
	cDadosArq   += '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#000000"/>'+CRLF
	cDadosArq   += '   <Interior/>'+CRLF
	cDadosArq   += '   <NumberFormat/>'+CRLF
	cDadosArq   += '   <Protection/>'+CRLF
	cDadosArq   += '  </Style>'+CRLF
	cDadosArq   += '  <Style ss:ID="s16" ss:Name="Vรญrgula">'+CRLF
	cDadosArq   += '   <NumberFormat ss:Format="_-* #,##0.00_-;\-* #,##0.00_-;_-* &quot;-&quot;??_-;_-@_-"/>'+CRLF
	cDadosArq   += '  </Style>'+CRLF
	cDadosArq   += '  <Style ss:ID="s65">'+CRLF
	cDadosArq   += '   <Borders>'+CRLF
	cDadosArq   += '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
	cDadosArq   += '    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
	cDadosArq   += '    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
	cDadosArq   += '    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
	cDadosArq   += '   </Borders>'+CRLF
	cDadosArq   += '  </Style>'+CRLF
	cDadosArq   += '  <Style ss:ID="s66">'+CRLF
	cDadosArq   += '   <Borders>'+CRLF
	cDadosArq   += '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
	cDadosArq   += '    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
	cDadosArq   += '    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
	cDadosArq   += '    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
	cDadosArq   += '   </Borders>'+CRLF
	cDadosArq   += '   <NumberFormat ss:Format="Short Date"/>'+CRLF
	cDadosArq   += '  </Style>'+CRLF
	cDadosArq   += '  <Style ss:ID="s67">'+CRLF
	cDadosArq   += '   <Borders>'+CRLF
	cDadosArq   += '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
	cDadosArq   += '    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
	cDadosArq   += '    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
	cDadosArq   += '    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
	cDadosArq   += '   </Borders>'+CRLF
	cDadosArq   += '   <NumberFormat ss:Format="@"/>'+CRLF
	cDadosArq   += '  </Style>'+CRLF
	cDadosArq   += '  <Style ss:ID="s68">'+CRLF
	cDadosArq   += '   <Alignment ss:Horizontal="Right" ss:Vertical="Bottom"/>'+CRLF
	cDadosArq   += '   <Borders>'+CRLF
	cDadosArq   += '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
	cDadosArq   += '    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
	cDadosArq   += '    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
	cDadosArq   += '    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
	cDadosArq   += '   </Borders>'+CRLF
	cDadosArq   += '   <NumberFormat ss:Format="@"/>'+CRLF
	cDadosArq   += '  </Style>'+CRLF
	cDadosArq   += '  <Style ss:ID="s72">'+CRLF
	cDadosArq   += '   <Alignment ss:Horizontal="Center" ss:Vertical="Bottom"/>'+CRLF
	cDadosArq   += '   <Borders>'+CRLF
	cDadosArq   += '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
	cDadosArq   += '    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
	cDadosArq   += '    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
	cDadosArq   += '    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>'+CRLF
	cDadosArq   += '   </Borders>'+CRLF
	cDadosArq   += '   <Interior ss:Color="#D0CECE" ss:Pattern="Solid"/>'+CRLF
	cDadosArq   += '  </Style>'+CRLF
	cDadosArq   += '  <Style ss:ID="s73">'+CRLF
	cDadosArq   += '   <Interior ss:Color="#D0CECE" ss:Pattern="Solid"/>'+CRLF
	cDadosArq   += '  </Style>'+CRLF
	cDadosArq   += '  <Style ss:ID="s74">'+CRLF
	cDadosArq   += '   <Interior ss:Color="#D0CECE" ss:Pattern="Solid"/>'+CRLF
	cDadosArq   += '   <NumberFormat ss:Format="@"/>'+CRLF
	cDadosArq   += '  </Style>'+CRLF
	cDadosArq   += '  <Style ss:ID="s75">'+CRLF
	cDadosArq   += '   <NumberFormat ss:Format="@"/>'+CRLF
	cDadosArq   += '  </Style>'+CRLF
	cDadosArq   += '  <Style ss:ID="s76">'+CRLF
	cDadosArq   += '   <NumberFormat ss:Format="Short Date"/>'+CRLF
	cDadosArq   += '  </Style>'+CRLF
	cDadosArq   += '  <Style ss:ID="s80">'+CRLF
	cDadosArq   += '   <NumberFormat ss:Format="0"/>'+CRLF
	cDadosArq   += '  </Style>'+CRLF
	cDadosArq   += '  <Style ss:ID="s81" ss:Parent="s16">'+CRLF
	cDadosArq   += '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#000000"/>'+CRLF
	cDadosArq   += '  </Style>'+CRLF
	cDadosArq   += '  <Style ss:ID="s85" ss:Parent="s16">'+CRLF
	cDadosArq   += '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#000000"/>'+CRLF
	cDadosArq   += '   <NumberFormat ss:Format="0"/>'+CRLF
	cDadosArq   += '  </Style>'+CRLF
	cDadosArq   += '  <Style ss:ID="s87" ss:Parent="s16">'+CRLF
	cDadosArq   += '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#000000"/>'+CRLF
	cDadosArq   += '   <NumberFormat ss:Format="@"/>'+CRLF
	cDadosArq   += '  </Style>'+CRLF
	cDadosArq   += ' </Styles>'+CRLF
	
	GrvTxtArq( cArq, cDadosArq )
	
	//Preenche a aba com os parametros
	PrtSheetPr(cArq, aParam)
	
Else
	Aviso("ERRO","Endere็o do arquivo nใo informado",{"Ok"},2)
EndIf

RestArea(aArea)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPrtSheetPr   บAutor  ณMicrosiga        บ Data ณ  05/01/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณPreenche os parametros                                      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿  
*/
Static Function PrtSheetPr(cArq, aParam)

Local aArea 		:= GetArea()
Local cDadosArq  	:= ""     

Default cArq 		:= ""      
Default aParam	:= {}

If !Empty(cArq)

	cDadosArq   := ' <Worksheet ss:Name="Parametros"> '+CRLF
	cDadosArq   += '  <Table ss:ExpandedColumnCount="2" ss:ExpandedRowCount="6" x:FullColumns="1" '+CRLF
	cDadosArq   += '   x:FullRows="1" ss:DefaultRowHeight="15"> '+CRLF
	cDadosArq   += '   <Column ss:Width="74.25"/> '+CRLF
	cDadosArq   += '   <Column ss:AutoFitWidth="0" ss:Width="171"/> '+CRLF
	cDadosArq   += '   <Row> '+CRLF
	cDadosArq   += '    <Cell ss:MergeAcross="1" ss:StyleID="s72"><Data ss:Type="String">Parametros</Data></Cell> '+CRLF
	cDadosArq   += '   </Row> '+CRLF
	cDadosArq   += '   <Row> '+CRLF
	cDadosArq   += '    <Cell ss:StyleID="s65"><Data ss:Type="String">Data de</Data></Cell> '+CRLF
	cDadosArq   += '    <Cell ss:StyleID="s66"><Data ss:Type="DateTime">'+ConvDateEx(aParam[1])+'</Data></Cell> '+CRLF
	cDadosArq   += '   </Row> '+CRLF
	cDadosArq   += '   <Row> '+CRLF
	cDadosArq   += '    <Cell ss:StyleID="s65"><Data ss:Type="String">Data Atรฉ</Data></Cell> '+CRLF
	cDadosArq   += '    <Cell ss:StyleID="s66"><Data ss:Type="DateTime">'+ConvDateEx(aParam[2])+'</Data></Cell> '+CRLF
	cDadosArq   += '   </Row> '+CRLF
	cDadosArq   += '   <Row> '+CRLF
	cDadosArq   += '    <Cell ss:StyleID="s65"><Data ss:Type="String">Filial de</Data></Cell> '+CRLF
	cDadosArq   += '    <Cell ss:StyleID="s68"><Data ss:Type="String">'+aParam[3]+'</Data></Cell> '+CRLF
	cDadosArq   += '   </Row> '+CRLF
	cDadosArq   += '   <Row> '+CRLF
	cDadosArq   += '    <Cell ss:StyleID="s65"><Data ss:Type="String">Filial atรฉ</Data></Cell> '+CRLF
	cDadosArq   += '    <Cell ss:StyleID="s68"><Data ss:Type="String">'+aParam[4]+'</Data></Cell> '+CRLF
	cDadosArq   += '   </Row> '+CRLF
	cDadosArq   += '   <Row> '+CRLF
	cDadosArq   += '    <Cell ss:StyleID="s65"><Data ss:Type="String">Status Retorno</Data></Cell> '+CRLF
	
	If Alltrim(aParam[5]) == "1"
		cDadosArq   += '    <Cell ss:StyleID="s67"><Data ss:Type="String">Retornadas</Data></Cell> '+CRLF
	ElseIf  Alltrim(aParam[5]) == "2"
		cDadosArq   += '    <Cell ss:StyleID="s67"><Data ss:Type="String">Nรฃo Retornadas</Data></Cell> '+CRLF
	Else
		cDadosArq   += '    <Cell ss:StyleID="s67"><Data ss:Type="String">Todas</Data></Cell> '+CRLF
	EndIf
	
	
	cDadosArq   += '   </Row> '+CRLF
	cDadosArq   += '  </Table> '+CRLF
	cDadosArq   += '  <WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel"> '+CRLF
	cDadosArq   += '   <PageSetup> '+CRLF
	cDadosArq   += '    <Header x:Margin="0.31496062000000002"/> '+CRLF
	cDadosArq   += '    <Footer x:Margin="0.31496062000000002"/> '+CRLF
	cDadosArq   += '    <PageMargins x:Bottom="0.78740157499999996" x:Left="0.511811024" '+CRLF
	cDadosArq   += '     x:Right="0.511811024" x:Top="0.78740157499999996"/> '+CRLF
	cDadosArq   += '   </PageSetup> '+CRLF
	cDadosArq   += '   <Panes> '+CRLF
	cDadosArq   += '    <Pane> '+CRLF
	cDadosArq   += '     <Number>3</Number> '+CRLF
	cDadosArq   += '     <ActiveRow>1</ActiveRow> '+CRLF
	cDadosArq   += '    </Pane> '+CRLF
	cDadosArq   += '   </Panes> '+CRLF
	cDadosArq   += '   <ProtectObjects>False</ProtectObjects> '+CRLF
	cDadosArq   += '   <ProtectScenarios>False</ProtectScenarios> '+CRLF
	cDadosArq   += '  </WorksheetOptions> '+CRLF
	cDadosArq   += ' </Worksheet> '+CRLF	
	

	GrvTxtArq( cArq, cDadosArq )
Else
	Aviso("ERRO","Endere็o do arquivo nใo informado",{"Ok"},2)
EndIf

RestArea(aArea)
Return




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCloseWkBook  บAutor  ณMicrosiga        บ Data ณ  05/01/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFecha o Workbook                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿  
*/
Static Function CloseBook(cArq)

Local aArea 		:= GetArea()
Local cDadosArq   := ""     
Default cArq 		:= ""

If !Empty(cArq)
	

	cDadosArq := '  <WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">'+CRLF
	cDadosArq += '   <PageSetup>'+CRLF
	cDadosArq += '    <Header x:Margin="0.31496062000000002"/>'+CRLF
	cDadosArq += '    <Footer x:Margin="0.31496062000000002"/>'+CRLF
	cDadosArq += '    <PageMargins x:Bottom="0.78740157499999996" x:Left="0.511811024"'+CRLF
	cDadosArq += '     x:Right="0.511811024" x:Top="0.78740157499999996"/>'+CRLF
	cDadosArq += '   </PageSetup>'+CRLF
	cDadosArq += '   <Selected/>'+CRLF
	cDadosArq += '   <Panes>'+CRLF
	cDadosArq += '    <Pane>'+CRLF
	cDadosArq += '     <Number>3</Number>'+CRLF
	cDadosArq += '     <ActiveRow>1</ActiveRow>'+CRLF
	cDadosArq += '    </Pane>'+CRLF
	cDadosArq += '   </Panes>'+CRLF
	cDadosArq += '   <ProtectObjects>False</ProtectObjects>'+CRLF
	cDadosArq += '   <ProtectScenarios>False</ProtectScenarios>'+CRLF
	cDadosArq += '  </WorksheetOptions>'+CRLF
	cDadosArq += ' </Worksheet>'+CRLF
	cDadosArq += '</Workbook>'+CRLF


	
	GrvTxtArq( cArq, cDadosArq )
Else
	Aviso("ERRO","Endere็o do arquivo nใo informado",{"Ok"},2)
EndIf

RestArea(aArea)
Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCabSheet  บAutor  ณMicrosiga 	        บ Data ณ  05/01/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCabe็alho WorkSheet                                         บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                	                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿  
*/
Static Function CabSheet(cArq, nQtdRow, cNameSheet)

Local aArea 		:= GetArea()
Local cDadosArq   := ""     

Default cArq 			:= ""        
Default nQtdRow		:= 0 
Default cNameSheet	:= ""

If !Empty(cArq)

	cDadosArq   := ' <Worksheet ss:Name="'+cNameSheet+'">'+CRLF
	cDadosArq   += '  <Names>'+CRLF
	cDadosArq   += '   <NamedRange ss:Name="_FilterDatabase" ss:RefersTo="='+cNameSheet+'!R1C1:R1C25"'+CRLF
	cDadosArq   += '    ss:Hidden="1"/>'+CRLF
	cDadosArq   += '  </Names>'+CRLF
	cDadosArq   += '  <Table ss:ExpandedColumnCount="25" ss:ExpandedRowCount="'+Alltrim(Str(nQtdRow))+'" x:FullColumns="1"'+CRLF
	cDadosArq   += '   x:FullRows="1" ss:DefaultRowHeight="15">'+CRLF
	cDadosArq   += '   <Column ss:StyleID="s75" ss:Width="69.75"/>'+CRLF
	cDadosArq   += '   <Column ss:StyleID="s75" ss:Width="29.25"/>'+CRLF
	cDadosArq   += '   <Column ss:Width="83.25"/>'+CRLF
	cDadosArq   += '   <Column ss:Width="118.5"/>'+CRLF
	cDadosArq   += '   <Column ss:Width="97.5"/>'+CRLF
	cDadosArq   += '   <Column ss:Width="85.5"/>'+CRLF
	cDadosArq   += '   <Column ss:AutoFitWidth="0" ss:Width="62.25"/>'+CRLF
	cDadosArq   += '   <Column ss:Width="24"/>'+CRLF
	cDadosArq   += '   <Column ss:AutoFitWidth="0" ss:Width="233.25"/>'+CRLF
	cDadosArq   += '   <Column ss:AutoFitWidth="0" ss:Width="133.5"/>'+CRLF
	cDadosArq   += '   <Column ss:AutoFitWidth="0" ss:Width="220.5"/>'+CRLF
	cDadosArq   += '   <Column ss:AutoFitWidth="0" ss:Width="69.75"/>'+CRLF
	cDadosArq   += '   <Column ss:Width="70.5"/>'+CRLF
	cDadosArq   += '   <Column ss:Width="60"/>'+CRLF
	cDadosArq   += '   <Column ss:AutoFitWidth="0" ss:Width="101.25"/>'+CRLF
	cDadosArq   += '   <Column ss:AutoFitWidth="0" ss:Width="105"/>'+CRLF
	cDadosArq   += '   <Column ss:Width="66.75"/>'+CRLF
	cDadosArq   += '   <Column ss:AutoFitWidth="0" ss:Width="84"/>'+CRLF
	cDadosArq   += '   <Column ss:AutoFitWidth="0" ss:Width="81.75"/>'+CRLF
	cDadosArq   += '   <Column ss:AutoFitWidth="0" ss:Width="91.5"/>'+CRLF
	cDadosArq   += '   <Column ss:Width="80.25"/>'+CRLF
	cDadosArq   += '   <Column ss:Width="31.5"/>'+CRLF
	cDadosArq   += '   <Column ss:Width="67.5"/>'+CRLF
	cDadosArq   += '   <Column ss:Width="88.5"/>'+CRLF
	cDadosArq   += '   <Column ss:AutoFitWidth="0" ss:Width="84.75"/>'+CRLF
	cDadosArq   += '   <Row>'+CRLF
	cDadosArq   += '    <Cell ss:StyleID="s74"><Data ss:Type="String">Nota de Saida</Data><NamedCell'+CRLF
	cDadosArq   += '      ss:Name="_FilterDatabase"/></Cell>'+CRLF
	cDadosArq   += '    <Cell ss:StyleID="s74"><Data ss:Type="String">Serie</Data><NamedCell'+CRLF
	cDadosArq   += '      ss:Name="_FilterDatabase"/></Cell>'+CRLF
	cDadosArq   += '    <Cell ss:StyleID="s73"><Data ss:Type="String">Dt Emissao Saida</Data><NamedCell'+CRLF
	cDadosArq   += '      ss:Name="_FilterDatabase"/></Cell>'+CRLF
	cDadosArq   += '    <Cell ss:StyleID="s73"><Data ss:Type="String">Dias Limite para retorno</Data><NamedCell'+CRLF
	cDadosArq   += '      ss:Name="_FilterDatabase"/></Cell>'+CRLF
	cDadosArq   += '    <Cell ss:StyleID="s73"><Data ss:Type="String">Data limite Retorno</Data><NamedCell'+CRLF
	cDadosArq   += '      ss:Name="_FilterDatabase"/></Cell>'+CRLF
	cDadosArq   += '    <Cell ss:StyleID="s73"><Data ss:Type="String">Pedido de Venda</Data><NamedCell'+CRLF
	cDadosArq   += '      ss:Name="_FilterDatabase"/></Cell>'+CRLF
	cDadosArq   += '    <Cell ss:StyleID="s73"><Data ss:Type="String">Cliente</Data><NamedCell'+CRLF
	cDadosArq   += '      ss:Name="_FilterDatabase"/></Cell>'+CRLF
	cDadosArq   += '    <Cell ss:StyleID="s73"><Data ss:Type="String">Loja</Data><NamedCell'+CRLF
	cDadosArq   += '      ss:Name="_FilterDatabase"/></Cell>'+CRLF
	cDadosArq   += '    <Cell ss:StyleID="s73"><Data ss:Type="String">Nome </Data><NamedCell'+CRLF
	cDadosArq   += '      ss:Name="_FilterDatabase"/></Cell>'+CRLF
	cDadosArq   += '    <Cell ss:StyleID="s73"><Data ss:Type="String">Produto</Data><NamedCell'+CRLF
	cDadosArq   += '      ss:Name="_FilterDatabase"/></Cell>'+CRLF
	cDadosArq   += '    <Cell ss:StyleID="s73"><Data ss:Type="String">Descriรงรฃo</Data><NamedCell'+CRLF
	cDadosArq   += '      ss:Name="_FilterDatabase"/></Cell>'+CRLF
	cDadosArq   += '    <Cell ss:StyleID="s73"><Data ss:Type="String">CFOP Saida</Data><NamedCell'+CRLF
	cDadosArq   += '      ss:Name="_FilterDatabase"/></Cell>'+CRLF
	cDadosArq   += '    <Cell ss:StyleID="s73"><Data ss:Type="String">Valor Unitario</Data><NamedCell'+CRLF
	cDadosArq   += '      ss:Name="_FilterDatabase"/></Cell>'+CRLF
	cDadosArq   += '    <Cell ss:StyleID="s73"><Data ss:Type="String">Quantidade</Data><NamedCell'+CRLF
	cDadosArq   += '      ss:Name="_FilterDatabase"/></Cell>'+CRLF
	cDadosArq   += '    <Cell ss:StyleID="s73"><Data ss:Type="String">Total</Data><NamedCell'+CRLF
	cDadosArq   += '      ss:Name="_FilterDatabase"/></Cell>'+CRLF
	cDadosArq   += '    <Cell ss:StyleID="s73"><Data ss:Type="String">Valor Contabil</Data><NamedCell'+CRLF
	cDadosArq   += '      ss:Name="_FilterDatabase"/></Cell>'+CRLF
	cDadosArq   += '    <Cell ss:StyleID="s73"><Data ss:Type="String">Base de ICMS</Data><NamedCell'+CRLF
	cDadosArq   += '      ss:Name="_FilterDatabase"/></Cell>'+CRLF
	cDadosArq   += '    <Cell ss:StyleID="s73"><Data ss:Type="String">Valor do ICMS</Data><NamedCell'+CRLF
	cDadosArq   += '      ss:Name="_FilterDatabase"/></Cell>'+CRLF
	cDadosArq   += '    <Cell ss:StyleID="s73"><Data ss:Type="String">Base do IPI</Data><NamedCell'+CRLF
	cDadosArq   += '      ss:Name="_FilterDatabase"/></Cell>'+CRLF
	cDadosArq   += '    <Cell ss:StyleID="s73"><Data ss:Type="String">Valor do IPI</Data><NamedCell'+CRLF
	cDadosArq   += '      ss:Name="_FilterDatabase"/></Cell>'+CRLF
	cDadosArq   += '    <Cell ss:StyleID="s73"><Data ss:Type="String">Nota de Entrada</Data><NamedCell'+CRLF
	cDadosArq   += '      ss:Name="_FilterDatabase"/></Cell>'+CRLF
	cDadosArq   += '    <Cell ss:StyleID="s73"><Data ss:Type="String">Serie</Data><NamedCell'+CRLF
	cDadosArq   += '      ss:Name="_FilterDatabase"/></Cell>'+CRLF
	cDadosArq   += '    <Cell ss:StyleID="s73"><Data ss:Type="String">CFOP Entrada</Data><NamedCell'+CRLF
	cDadosArq   += '      ss:Name="_FilterDatabase"/></Cell>'+CRLF
	cDadosArq   += '    <Cell ss:StyleID="s73"><Data ss:Type="String">Dt Emissao Entrda</Data><NamedCell'+CRLF
	cDadosArq   += '      ss:Name="_FilterDatabase"/></Cell>'+CRLF
	cDadosArq   += '    <Cell ss:StyleID="s73"><Data ss:Type="String">Dt Digitaรงรฃo</Data><NamedCell'+CRLF
	cDadosArq   += '      ss:Name="_FilterDatabase"/></Cell>'+CRLF
	cDadosArq   += '   </Row>'+CRLF



	GrvTxtArq( cArq, cDadosArq )
Else
	Aviso("ERRO","Endere็o do arquivo nใo informado",{"Ok"},2)
EndIf
                            

RestArea(aArea)
Return
             


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPrintSheet  บAutor  ณMicrosiga 	     บ Data ณ  05/01/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณPreenche as linhas do WorkSheet (Dados do relatorio)        บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿  
*/
Static Function PrintSheet(cArq, cDocS, cSerieS,dDtEmissS, nDiasLim, dDtLimRet, cPedVend, cCliente, cLoja, cNome, cProd, cDesc,;
								cCfopS, nValUnit, nQuantS, nTotS, nValorCtb, nBasIcmsS, nValIcmsS, nBasIpiS, nValIpiS,;
								cDocE, cSerieE, cCfopE, dDtEmisE, dDtDigit )

Local aArea  		:= GetArea()
Local cDadosArq   := ""
        

Default cArq 		:= ""
Default cDocS		:= "" 
Default cSerieS	:= ""
Default dDtEmissS	:= CTOD('') 
Default nDiasLim	:= 0 
Default dDtLimRet	:= CTOD('') 
Default cPedVend	:= "" 
Default cCliente	:= "" 
Default cLoja		:= "" 
Default cNome		:= "" 
Default cProd		:= "" 
Default cDesc		:= ""
Default cCfopS	:= "" 
Default nValUnit	:= 0 
Default nQuantS	:= 0 
Default nTotS		:= 0 
Default nValorCtb	:= 0 
Default nBasIcmsS	:= 0 
Default nValIcmsS	:= 0 
Default nBasIpiS	:= 0 
Default nValIpiS	:= 0
Default cDocE		:= "" 
Default cSerieE	:= "" 
Default cCfopE	:= "" 
Default dDtEmisE	:= CTOD('') 
Default dDtDigit	:= CTOD('')


If !Empty(cArq)

   	cDadosArq   += '	 <Row>'+CRLF
	cDadosArq   += '    <Cell><Data ss:Type="String">'+cDocS+'</Data></Cell>'+CRLF
	cDadosArq   += '    <Cell><Data ss:Type="String">'+cSerieS+'</Data></Cell>'+CRLF
	cDadosArq   += '    <Cell ss:StyleID="s76"><Data ss:Type="DateTime">'+ConvDateEx(dDtEmissS)+'</Data></Cell>'+CRLF
	cDadosArq   += '    <Cell ss:StyleID="s80"><Data ss:Type="Number">'+Alltrim(Str(nDiasLim))+'</Data></Cell>'+CRLF
	cDadosArq   += '    <Cell ss:StyleID="s76"><Data ss:Type="DateTime">'+ConvDateEx(dDtLimRet)+'</Data></Cell>'+CRLF
	cDadosArq   += '    <Cell ss:StyleID="s75"><Data ss:Type="String">'+cPedVend+'</Data></Cell> '+CRLF
	cDadosArq   += '    <Cell ss:StyleID="s75"><Data ss:Type="String">'+cCliente+'</Data></Cell> '+CRLF
	cDadosArq   += '    <Cell ss:StyleID="s75"><Data ss:Type="String">'+cLoja+'</Data></Cell>'+CRLF
	cDadosArq   += '    <Cell ss:StyleID="s75"><Data ss:Type="String">'+cNome+'</Data></Cell>'+CRLF
	cDadosArq   += '    <Cell ss:StyleID="s75"><Data ss:Type="String">'+cProd+'</Data></Cell>'+CRLF
	cDadosArq   += '    <Cell ss:StyleID="s75"><Data ss:Type="String">'+cDesc+'</Data></Cell>'+CRLF
	cDadosArq   += '    <Cell ss:StyleID="s75"><Data ss:Type="String">'+cCfopS+'</Data></Cell>'+CRLF
	cDadosArq   += '    <Cell ss:StyleID="s81"><Data ss:Type="Number">'+Alltrim(Str(nValUnit))+'</Data></Cell>'+CRLF
	cDadosArq   += '    <Cell ss:StyleID="s85"><Data ss:Type="Number">'+Alltrim(Str(nQuantS))+'</Data></Cell>'+CRLF
	cDadosArq   += '    <Cell ss:StyleID="s81"><Data ss:Type="Number">'+Alltrim(Str(nTotS))+'</Data></Cell>'+CRLF
	cDadosArq   += '    <Cell ss:StyleID="s81"><Data ss:Type="Number">'+Alltrim(Str(nValorCtb))+'</Data></Cell>'+CRLF
	cDadosArq   += '    <Cell ss:StyleID="s81"><Data ss:Type="Number">'+Alltrim(Str(nBasIcmsS))+'</Data></Cell>'+CRLF
	cDadosArq   += '    <Cell ss:StyleID="s81"><Data ss:Type="Number">'+Alltrim(Str(nValIcmsS))+'</Data></Cell>'+CRLF
	cDadosArq   += '    <Cell ss:StyleID="s81"><Data ss:Type="Number">'+Alltrim(Str(nBasIpiS))+'</Data></Cell>'+CRLF
	cDadosArq   += '    <Cell ss:StyleID="s81"><Data ss:Type="Number">'+Alltrim(Str(nValIpiS))+'</Data></Cell>'+CRLF
	cDadosArq   += '    <Cell ss:StyleID="s87"><Data ss:Type="String">'+cDocE+'</Data></Cell>'+CRLF
	cDadosArq   += '    <Cell><Data ss:Type="String">'+cSerieE+'</Data></Cell>'+CRLF
	cDadosArq   += '    <Cell ss:StyleID="s75"><Data ss:Type="String">'+cCfopE+'</Data></Cell>'+CRLF
	
	If Empty(dDtEmisE)
		cDadosArq   += '    <Cell ss:StyleID="s75"><Data ss:Type="String"></Data></Cell>'+CRLF	
	Else
		cDadosArq   += '    <Cell ss:StyleID="s76"><Data ss:Type="DateTime">'+ConvDateEx(dDtEmisE)+'</Data></Cell>'+CRLF
	EndIf
	
	If Empty(dDtDigit)
		cDadosArq   += '    <Cell ss:StyleID="s75"><Data ss:Type="String"></Data></Cell>'+CRLF
	Else
		cDadosArq   += '    <Cell ss:StyleID="s76"><Data ss:Type="DateTime">'+ConvDateEx(dDtDigit)+'</Data></Cell>'+CRLF
	EndIf
	
	cDadosArq   += '   </Row>'+CRLF
	
	
	GrvTxtArq( cArq, cDadosArq )
Else
	Aviso("ERRO","Endere็o do arquivo nใo informado",{"Ok"},2)
EndIf



RestArea(aArea)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCloseSheet  บAutor  ณMicrosiga  	     บ Data ณ  05/01/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFecha a a tag Worksheet                                     บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿  
*/
Static Function CloseSheet(cArq)

Local aArea 		:= GetArea()
Local cDadosArq   := ""     
Default cArq 		:= ""     

If !Empty(cArq)
	cDadosArq := '  </Table>'+CRLF

	GrvTxtArq( cArq, cDadosArq )
	
Else
	Aviso("ERRO","Endere็o do arquivo nใo informado",{"Ok"},2)
EndIf


RestArea(aArea)
Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGrvTxtArq  บAutor  ณMicrosiga          บ Data ณ  05/01/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณGrava o texto no final do arquivo                           บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GrvTxtArq( cArq, cTexto )

Local nHandle := 0

Default cArq	:= "" 
Default cTexto	:= ""

If !Empty(cArq)
	If !File( cArq )
		nHandle := FCreate( cArq )
		FClose( nHandle )
	Endif
	
	If File( cArq )
		nHandle := FOpen( cArq, 2 )
		FSeek( nHandle, 0, 2 )	// Posiciona no final do arquivo
		FWrite( nHandle, cTexto + Chr(13) + Chr(10), Len(cTexto)+2 )
		FClose( nHandle)
	Endif
EndIf

Return   
                



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณConvDateEx  บAutor  ณMicrosiga  	     บ Data ณ  05/01/16  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณConverte a data para o Excel                                บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿  
*/
Static Function ConvDateEx(dDtConv)

Local aArea 	:= GetArea()
Local cRet		:= ""

Default dDtConv := CTOD('')

If !Empty(dDtConv)
	cRet := DTOS(dDtConv)
	cRet := SubStr(cRet,1,4)+"-"+SubStr(cRet,5,2)+"-"+SubStr(cRet,7,2)
	cRet := cRet +"T00:00:00.000"  
Else
	cRet := ""
EndIf

RestArea(aArea)
Return cRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGeraExcel	  บAutor  ณMicrosiga  	     บ Data ณ  05/01/16  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณAbre o arquivo em excel		                                บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿  
*/
Static Function GeraExcel(cPathArq)
	
Default cPathArq	:= ""


If File(cPathArq)
		
	If Aviso("OPENARQ","Deseja abrir o arquivo gerado no Excel ?",{"Sim","Nใo"},2) == 1
		olExcelApp	:= MsExcel():New()
		olExcelApp:WorkBooks:Open(cPathArq)
		olExcelApp:SetVisible(.T.)
		olExcelApp:Destroy()
	EndIf
Else
	Aviso("Aten็ใo","Erro ao criar o arquivo em: " +CRLF+ cPathArq,{"Ok"},2)
Endif

Return      


