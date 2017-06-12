#INCLUDE "rwmake.ch"
#INCLUDE "TOPCONN.ch"
#INCLUDE "protheus.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCILM001  บAutor  ณMicrosiga           บ Data ณ  26/01/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NCILM001()

Local aArea 		:= GetArea()
Local aPerg		:= {}

aPerg	:= PergArqDes()
If VldParam(aPerg)
	
	
	//Executa a rotina para criar o arquivo
	Processa( {|| RunProcArq(.F., aPerg[2][2], aPerg[2][3], aPerg[2][4], aPerg[2][5], Alltrim(aPerg[2][1])) },"","Processando." ) 
		
EndIf

RestArea(aArea)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPergArqDes บAutor  ณMicrosiga          บ Data ณ  26/01/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณArquivo de destino                                          บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
-฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function PergArqDes()

Local aArea 		:= GetArea()
Local aRetPath  	:= {}
Local aParamBox	:= {} 
Local lRet			:= .F.
Local aRet			:= {}		

AADD(aParamBox,{6,"Endere็o para gravar o arquivo:","","","ExistDir(&(ReadVar()))","",080,.T.,"","",GETF_LOCALHARD+GETF_NETWORKDRIVE + GETF_RETDIRECTORY})
AADD(aParamBox,{1,"Periodo de "		,CtoD("//")					, "@D"	,"" 	,"" 	,"",70,.T.})
AADD(aParamBox,{1,"Periodo at้ "	,CtoD("//")					, "@D"	,"" 	,""		,"",70,.T.})
AADD(aParamBox,{1,"Loja de: "		,0	, "@E 99999"	,""		,""	 	,"",70,.F.	})
AADD(aParamBox,{1,"Loja at้: "		,0	, "@E 99999"	,""		,""	 	,"",70,.T.	})

//Monta a pergunta
lRet := ParamBox(aParamBox ,"Endere็o do arquivo",@aRetPath,,,.T.,50,50,				,			,.T.			,.T.)

aRet := {lRet, aRetPath}

RestArea(aArea)
Return aRet  



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCILMJ01  บAutor  ณMicrosiga           บ Data ณ  26/01/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Job utilizado para gerar arquivo de concilia็ใo com o 	    บฑฑ
ฑฑบ          ณ sistema Luma                                               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NCILMJ01(aDados)


Default aDados := {"01","03"}

RpcClearEnv()
RpcSettype(3)
RpcSetEnv(aDados[1],aDados[2])



RunProcArq(.T., MsDate()-1, MsDate()-1) 
//RunProcArq(.T., CTOD('01/01/2016'), CTOD('31/01/2016')) 

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRunProcArq  บAutor  ณMicrosiga         บ Data ณ  26/01/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina utilizada para realizar o processamento do arquivo   บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function RunProcArq(lJob, dDtIni, dDtFin, nLojaDe, nLojaAte, cDirGrv)

Local aArea 		:= GetArea()
Local cQuery		:= ""
Local cArqTmp		:= GetNextAlias()
Local cNomArq		:= ""
Local cLinha		:= ""
Local cValorAux	:= ""
Local cDtIniAux	:= ""
Local cDtFinAux	:= ""
Local cFilLuma	:= ""
Local lCab			:= .T.
Local nCnt			:= 0
Local nHandle		:= 0
Local cDir			:= Alltrim(U_MyNewSX6("NC_DIRILM",;
									"N:\Financeiro\Concilia็ใo Lojas\",;
									"C",;
									"Diretorio para gravar o arquivo de concilia็ใo com o sistema Luma",;
									"Diretorio para gravar o arquivo de concilia็ใo com o sistema Luma",;
									"Diretorio para gravar o arquivo de concilia็ใo com o sistema Luma",;
									.F. ))
Local cCodFinExc	:= Alltrim(U_MyNewSX6("NC_NCFIILM",;
									"1;350;-2;163;8",;
									"C",;
									"Codigos financeiros nใo considerados na busca dos dados",;
									"Codigos financeiros nใo considerados na busca dos dados",;
									"Codigos financeiros nใo considerados na busca dos dados",;
									.F. ))



Default lJob 		:= .T.
Default dDtIni		:= CTOD('') 
Default dDtFin		:= CTOD('')
Default nLojaDe		:= 0
Default nLojaAte	:= 999999
Default cDirGrv		:= ""


cDtIniAux	:= DTOS(dDtIni)
cDtFinAux	:= DTOS(dDtFin)
cDtIniAux 	:= SubStr(cDtIniAux,1,4)+"-"+SubStr(cDtIniAux,5,2)+"-"+SubStr(cDtIniAux,7,2)
cDtFinAux	:= SubStr(cDtFinAux,1,4)+"-"+SubStr(cDtFinAux,5,2)+"-"+SubStr(cDtFinAux,7,2)

//Diretorio informado no pergunte
If !lJob
	cDir := Alltrim(cDirGrv)
EndIf

//Nome do arquivo
cNomArq	:= "Vendas"+DTOS(MsDate())+".csv"

//Exclui o arquivo se o mesmo existir
ExcluiArq(cDir+cNomArq) 

cQuery    := " SELECT COD_LOJA, "+CRLF
cQuery    += " 		CONVERT(VARCHAR, IMF.DATA_MOVIMENTO, 112) AS DATA_MOVIMENTO_CONV, "+CRLF  
cQuery    += " 		TEF_NSU_aprovacao AS AUTORIZACAO, "+CRLF
cQuery    += " 		' ' AS NSU, "+CRLF
cQuery    += " 		' ' AS NSU_VENDA, "+CRLF
cQuery    += " 		COD_FINANCEIRO_TIPO, "+CRLF
cQuery    += " 		SUM(VALOR_OPERACAO) TOTAL_OPERACAO, "+CRLF
cQuery    += " 		TOTAL_PARCELA, "+CRLF
cQuery    += " 		COD_MOVIMENTO "+CRLF		
cQuery    += " 		FROM "+u_NCGetBWM("INTEGRACAO_MOVIMENTO_FINANCEIRO")+" IMF "+CRLF 

cQuery    += " WHERE DATA_MOVIMENTO >= '"+cDtIniAux+" 00:00:00' AND DATA_MOVIMENTO <= '"+cDtFinAux+" 23:59:59' "+CRLF 
cQuery    += " AND COD_LOJA >= '"+Alltrim(Str(nLojaDe))+"' AND COD_LOJA <= '"+Alltrim(Str(nLojaAte))+"' "+CRLF 
cQuery    += " AND COD_FINANCEIRO_TIPO NOT IN"+FormatIn(cCodFinExc,";")+" "+CRLF 
cQuery    += " AND TIPO_OPERACAO IN('VE','TRV','OS') "+CRLF 

//cQuery    += " AND COD_MOVIMENTO = '1490363' "

cQuery    += "  GROUP BY COD_LOJA, IMF.DATA_MOVIMENTO, COD_FINANCEIRO_TIPO, TOTAL_PARCELA, COD_MOVIMENTO, TEF_NSU_aprovacao " +CRLF
cQuery    += "  ORDER BY COD_LOJA, COD_MOVIMENTO "+CRLF


//Executa a query na base de dados do WEB MANAGER
cArqTmp		:= U_NCIWMF02(cQuery)


(cArqTmp)->( DbGoTop() )
(cArqTmp)->( dbEval( { || nCnt++ },,{ || !Eof() } ) )
(cArqTmp)->( DbGoTop() )

ProcRegua(nCnt)  

DbSelectArea("PZU")
DbSetOrder(1)
While (cArqTmp)->(!Eof())
	
	IncProc("Processando...")
	
	//Preenche o cabe็alho do arquivo
	If lCab
		cLinha := "FILIAL;DATA;AUTORIZACAO;NSUSITEF;NSUADMIN;ADMIN;BANDEIRA;CREDDEB;VALOR;QTPARC;NUMCARTAO;TID;NOMEARQ;NOMECLI;NUMPEDIDO" 
		
		//Atualiza os dados do arquivo
		nHandle := GrvTxtArq( cNomArq, cLinha, cDir, nHandle)
		
		lCab := .F.
	EndIf
	
	
	cValorAux := ""
	cValorAux := StrTran(Transform((cArqTmp)->TOTAL_OPERACAO,"@E 999,999,999,999.99"),",","")
	cValorAux := StrTran(cValorAux,".","")
	
	cLinha		:= ""
	cFilLuma	:= ""
	cFilLuma	:= GetFilLuma(Alltrim(Str((cArqTmp)->COD_LOJA)))
	
	If !Empty((cArqTmp)->COD_FINANCEIRO_TIPO);
			.And. !Empty(cFilLuma);
			.And. PZU->(MsSeek(xFilial("PZU") + PADR(Alltrim(Str((cArqTmp)->COD_FINANCEIRO_TIPO)), TAMSX3("PZU_CODFIN")[1]) ) )
			 	
		If !Empty(PZU->PZU_ADMLUM)
		
				cLinha 	:= cFilLuma+";";												//Filial
							+Alltrim((cArqTmp)->DATA_MOVIMENTO_CONV)+";";				//Data do movimento
							+Iif( !Empty((cArqTmp)->AUTORIZACAO), Alltrim((cArqTmp)->AUTORIZACAO), "0" )+";";//Id da autorizacao
							+Alltrim((cArqTmp)->NSU)+";";								//Numero do NSU
							+Alltrim((cArqTmp)->NSU_VENDA)+";";							//Numero do NSU da venda
							+Alltrim(PZU->PZU_ADMLUM)+";";								//Codigo da Administradora
							+Iif( !Empty(PZU->PZU_BANLUM), Alltrim(PZU->PZU_BANLUM), "0")+";";	//Codigo da Bandeira
							+Alltrim(PZU->PZU_CRDB)+";";								//Indicador de cartใo
							+Alltrim(cValorAux)+";";									//Valor total da opera็ใo
							+Alltrim(Str((cArqTmp)->TOTAL_PARCELA))+";";				//Quantidade de parcelas
							+''+";";													//Numero do cartao
							+''+";";													//Id para e-commerce
							+''+";";													//Nome do arquivo SITEF
							+''+";";													//Nome do cliente
							+Alltrim(Str((cArqTmp)->COD_MOVIMENTO))						//Numero do pedido
			
				//Atualiza os dados do arquivo
				nHandle := GrvTxtArq( cNomArq, cLinha, cDir, nHandle)
		EndIf
	EndIf
	
(cArqTmp)->(DbSkip())
EndDo 

//Fecha o arquivo
If nHandle != 0 
	FClose( nHandle )
EndIf


(cArqTmp)->(DbCloseArea())
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
Static Function GrvTxtArq( cArq, cTexto, cDir, nHandle)

Local alArea	:= GetArea()
Local cPathAbs	:= cDir + cArq

Default cArq 		:= ""
Default cTexto 	:= ""
Default cDir 		:= ""
Default nHandle	:= 0 

If !Empty(cDir) .And. !Empty(cArq)

	If !ExistDir(cDir)
		
		If MakeDir( cDir ) < 0
			conout( 'Erro na cria็ใo da pasta ' + Alltrim( cDir ) )
			Return NIL
		EndIf

	EndIf
	 
	If !File(cPathAbs)
		nHandle := FCreate( cPathAbs )
		FSeek( nHandle, 0, 2 )	// Posiciona no final do arquivo
		FWrite( nHandle, cTexto + Chr(13) + Chr(10), Len(cTexto)+2 )		
	Else
		FSeek( nHandle, 0, 2 )	// Posiciona no final do arquivo
		FWrite( nHandle, cTexto + Chr(13) + Chr(10), Len(cTexto)+2 )
	Endif

EndIf

RestArea(alArea)
Return nHandle  


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณExcluiArq  บAutor  ณMicrosiga          บ Data ณ  05/01/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณExclui arquivo						                         บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ExcluiArq(cPathAbs)
Local aArea := GetArea()

If File(cPathAbs)
   FERASE(cPathAbs)
EndIf

RestArea(aArea)
Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGetFilLuma  บAutor  ณMicrosiga         บ Data ณ  05/01/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ										                         บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetFilLuma(cCodLoja)

Local aArea 		:= GetArea()
Local cQuery		:= ""
Local cArqTmp		:= GetNextAlias()
Local cRet			:= ""
Local aEmpFilAux	:= {}

Default cCodLoja := ""

cQuery	:= " SELECT ZX5_DESCRI FROM "+RetSqlName("ZX5")+CRLF
cQuery	+= " WHERE ZX5_FILIAL = '"+xFilial("ZX5")+"' "+CRLF
cQuery	+= " AND ZX5_TABELA = '00008' "+CRLF
cQuery	+= " AND ZX5_CHAVE = '"+cCodLoja+"' "+CRLF
cQuery	+= " AND D_E_L_E_T_ = ' ' "+CRLF

DbUseArea( .T. , "TOPCONN" , TcGenQry(,,cQuery) , cArqTmp,.T.,.T.)

If (cArqTmp)->(!Eof()) 
	aEmpFilAux := Separa(Alltrim((cArqTmp)->ZX5_DESCRI), ";")
	If Len(aEmpFilAux) >= 4 
		cRet := aEmpFilAux[4] 
	EndIf	
EndiF

(cArqTmp)->(DbCloseArea())

RestArea(aArea)
Return cRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณVldParam บAutor  ณMicrosiga  	        บ Data ณ  26/01/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณValida็ใo dos parametros                                    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
-฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function VldParam(aParam)

Local aArea 	:= GetArea()
Local lRet		:= .T.
Local cMsgAux	:= ""

Default aParam	:= {}

If Len(aParam) >= 2 .And. aParam[1]
	If !ExistDir(aParam[2][1])
		cMsgAux	+= "Diret๓rio para grava็ใo do arquivo invแlido;"+CRLF
		lRet 		:= .F.
	EndIf
	
	If Empty(aParam[2][2])
		cMsgAux	+= "'Periodo de: ' nใo preenchido; "+CRLF
		lRet 		:= .F.	
	EndIf

	If Empty(aParam[2][3])
		cMsgAux	+= "'Periodo ate: ' nใo preenchido; "+CRLF
		lRet 		:= .F.	
	EndIf

	If Empty(aParam[2][5])
		cMsgAux	+= "'Loja ate: ' nใo preenchida; "+CRLF
		lRet 		:= .F.
	EndIf
	
	If !lRet
		Aviso("Valida็ใo de Parโmetros ",cMsgAux,{"Ok"},2)
	EndIf
Else
	lRet := .F.
	//Aviso("Valida็ใo de Parโmetros ","Preenchimento dos parโmetros invalido. ",{"Ok"},2)				
EndIf


RestArea(aArea)
Return lRet

