#INCLUDE "TOPCONN.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#include "ap5mail.ch" 



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCRFTSAG		  �Autor  �Microsiga      � Data �  18/11/14  ���
�������������������������������������������������������������������������͹��
���Desc.     � Rotina utilizada para gerar relat�rio de pedidos faturados ���
���          � sem a confirma��o de agendamento			  				  ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function NCRFTSAG() 

Local aArea := GetArea()

Processa({ || RFTSAGEND()})

RestArea(aArea)
Return



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCJBRFSA		  �Autor  �Microsiga      � Data �  18/11/14  ���
�������������������������������������������������������������������������͹��
���Desc.     � Rotina (JOB) utilizada para gerar relat�rio de pedidos     ���
���          � faturados sem a confirma��o de agendamento  				  ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function NCJBRFSA(aDados) 

Default aDados:={"01","03",.F.}

RpcClearEnv()
RpcSettype(3)
RpcSetEnv(aDados[1],aDados[2])  

If aDados[3]//Envia para os vendedores cadastros (PZG)
	JobFatSAgend()
	
Else//Envia apenas para os e-mails cadastrados no parametro NC_EGEFSAG
	JobFatSAgG()
	
EndIf

RpcClearEnv()
Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �RFTSAGEND		  �Autor  �Microsiga      � Data �  18/11/14  ���
�������������������������������������������������������������������������͹��
���Desc.     � Rotina utilizada para gerar relat�rio coms pedidos   	  ���
���          � faturadas sem a confirma��o de entrega	  				  ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/      
Static Function RFTSAGEND()

Local aArea 	:= GetArea()
Local cArqTmp   := ""
Local aParams	:= {}
Local apExcel	:= {}
Local cNameArq 	:= "FatSemAgendamento_" + DtoS(Date())+STRTRAN(Time(), ":", "")+".xls"
Local aAcaoAg	:= {}
Local nQtdReg	:= 0
Local nDiasFSAg	:=	U_MyNewSX6("NC_DIASFSA",;
									"15",;
									"N",;
									"Quantidade de dias para faturamento sem agendamento",;
									"Quantidade de dias para faturamento sem agendamento",;
									"Quantidade de dias para faturamento sem agendamento",;
									.F. )

If ParamRel(@aParams)
	
	//Lista os dados de acordo com os filtros
	cArqTmp := GetDRel(dtos(aParams[1]), dtos(aParams[2]), aParams[3],aParams[4], aParams[5], aParams[6], aParams[7], aParams[8],.F.)
	
	
	If (cArqTmp)->(!Eof())
		//Verifica quantidade de registros
		(cArqTmp)->( dbEval( {|| nQtdReg++ } ) )
		(cArqTmp)->( dbGoTop() )
		
		++nQtdReg//Soma 1, para considerar o cabe�alho
		ProcRegua(nQtdReg)
		//Tags de inicializa��o do arquivo html (</html></body>)
		WrTXMLArq(1,@apExcel, nQtdReg)
		
		While (cArqTmp)->(!Eof()) 
			IncProc("Processando...")
			
			aAcaoAg	:= {}
			aAcaoAg	:= GetAcaoAg(STOD((cArqTmp)->F2_EMISSAO))
			
			If Len(aAcaoAg) >= 2
				
				WrTXMLArq(2,;//Op��o para preenchimento dos itens
				@apExcel,;//Array com as informa��es do XML
				nQtdReg,;//Qauntidade de itens
				(cArqTmp)->A3_COD,;//Codigo do vendedor
				(cArqTmp)->A3_NOME,;//Nome do vendedor
				(cArqTmp)->A1_COD,;//Codigo do cliente
				(cArqTmp)->A1_LOJA,;//Loja do cliente
				(cArqTmp)->A1_NOME,;//Razao social
				(cArqTmp)->A1_NREDUZ,;//Nome fantasia
				DTOS(STOD((cArqTmp)->F2_EMISSAO)),;//Dt.Emissao NF
				(cArqTmp)->F2_DOC,;// NF
				(cArqTmp)->C5_NUM,;//Pedido NC
				(cArqTmp)->C5_PEDCLI,;//Pedido do cliente
				(cArqTmp)->A1_MUN,;//Municipio
				(cArqTmp)->F2_EST,;//UF
				(cArqTmp)->F2_VALBRUT,;//Valor da NF
				(cArqTmp)->E1_HISTWF,;//Ultimo historico
				aAcaoAg[1],;//Dias de pendencia
				DTOS(STOD((cArqTmp)->F2_EMISSAO) + nDiasFSAg ),;//Dt.Limite para agendamento
				aAcaoAg[2])//A��o
				
			EndIf
			
			(cArqTmp)->(DbSkip())
		EndDo
		
		//Fecha as tags de inicializa��o do arquivo html (<html><body>)
		WrTXMLArq(3,@apExcel)
		
		//Chama a rotina para gerar Excel
		GeraExcel(apExcel, cNameArq, .F.)
		
		
		(cArqTmp)->(DbCloseArea())
	Else
		Aviso("Registro n�o encontrado","Nenhum registro encontrado.",{"Ok"},2)
	EndIf
EndIf

RestArea(aArea)
Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Funcao    �ParamRel	�Autor  �Elton C.		     � Data �  17/02/2012 ���
�������������������������������������������������������������������������͹��
���Desc.     � Parametros utilizados no filtro do relatorio			      ���
���          � 			                                                  ���
�������������������������������������������������������������������������͹��
���Uso       � Ap		                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function ParamRel(aParams)

Local aParamBox  := {}
Local lRet       := .T.

AADD(aParamBox,{1,"Emiss�o NF de"		,CtoD("//")	,"@D"	,"","","",60,.F.})
AADD(aParamBox,{1,"Emiss�o NF at�:"		,CtoD("//")	,"@D"	,"","","",60,.F.})
aAdd(aParamBox,{1,"Cliente de"			,Space(TamSx3("A1_COD")[1]) 	,""	,"","SA1"	,"",TamSx3("A1_COD")[1],.F.})
aAdd(aParamBox,{1,"Cliente Ate"			,Space(TamSx3("A1_COD")[1]) 	,""	,"","SA1"	,"",TamSx3("A1_COD")[1],.F.})
aAdd(aParamBox,{1,"Da loja"				,Space(TamSx3("A1_LOJA")[1]) 	,""	,"",""		,"",TamSx3("A1_LOJA")[1]	,.F.})
aAdd(aParamBox,{1,"At� a loja"			,Space(TamSx3("A1_LOJA")[1]) 	,""	,"",""		,"",TamSx3("A1_LOJA")[1]	,.F.})
aAdd(aParamBox,{1,"Vendedor de"			,Space(TamSx3("A3_COD")[1]) 	,""	,"","SA3"	,"",TamSx3("A3_COD")[1],.F.})
aAdd(aParamBox,{1,"Vendedor At�"		,Space(TamSx3("A3_COD")[1]) 	,""	,"","SA3"	,"",TamSx3("A3_COD")[1],.F.})


lRet := ParamBox(aParamBox, "Par�metros", aParams, , /*alButtons*/, .T., /*nlPosx*/, /*nlPosy*/,, /*clLoad*/, .T., .T.)

Return lRet


       
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �GetDRel		  �Autor  �Microsiga      � Data �  18/11/14  ���
�������������������������������������������������������������������������͹��
���Desc.     � Retorna o arquivo temporario com os dados do relatorio 	  ���
���          � 											  				  ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/        
Static Function GetDRel(cEmisDe, cEmisAte, cClieDe,cCliAte, cLojaDe, cLojaAte, cVendDe, cVendAte, lJob)

Local aArea 	:= GetArea()
Local cQuery    := ""
Local cArqTmp	:= GetNextAlias() 
Local cCFOPVend	:= U_MyNewSX6("NC_CFOPVND",;
									"5102/6102/5403/6403/5405/6405/5108/6108/5110/6110/5404/6404/5114/6114/7102",;
									"C",;
									"CFOP utilizado nas vendas",;
									"CFOP utilizado nas vendas ",;
									"CFOP utilizado nas vendas ",;
									.F. )                                           

Default cEmisDe		:= "" 
Default cEmisAte	:= "" 
Default cClieDe		:= ""
Default cCliAte		:= "" 
Default cLojaDe		:= "" 
Default cLojaAte	:= "" 
Default cVendDe		:= "" 
Default cVendAte	:= ""
Default lJob		:= .F.

cQuery    := " SELECT DISTINCT A1_COD, A1_LOJA, A1_NOME, A1_NREDUZ, A1_MUN, A1_EST, "+CRLF
cQuery    += "         A3_COD, A3_NOME, "+CRLF
cQuery    += "         F2_DOC, F2_SERIE, F2_EMISSAO, F2_EST, F2_VALBRUT, "+CRLF
cQuery    += "         D2_DOC, D2_SERIE, D2_PEDIDO, "+CRLF
cQuery    += "         C5_NUM, C5_PEDCLI, "+CRLF
cQuery    += "         E1_PREFIXO, E1_NUM, E1_HISTWF, "+CRLF
cQuery    += "         Z1_DOC, Z1_SERIE "+CRLF
cQuery    += "         FROM "+RetSqlName("SF2")+" SF2 "+CRLF

cQuery    += " INNER JOIN "+RetSqlName("SZ1")+" SZ1 "+CRLF
cQuery    += "  ON SZ1.Z1_FILIAL = SF2.F2_FILIAL "+CRLF
cQuery    += "  AND SZ1.Z1_DOC = SF2.F2_DOC "+CRLF
cQuery    += "  AND SZ1.Z1_SERIE = SF2.F2_SERIE "+CRLF
cQuery    += "  AND SZ1.Z1_CLIENTE = SF2.F2_CLIENTE "+CRLF
cQuery    += "  AND SZ1.Z1_LOJA = SF2.F2_LOJA "+CRLF
cQuery    += "  AND SZ1.Z1_DTENTRE = ' ' "+CRLF
cQuery    += "  AND SZ1.D_E_L_E_T_ = ' ' "+CRLF

cQuery    += " INNER JOIN "+RetSqlName("SA1")+" SA1 "+CRLF
cQuery    += " ON SA1.A1_FILIAL = '"+xFilial("SA1")+"' "+CRLF
cQuery    += " AND SA1.A1_COD = SF2.F2_CLIENT "+CRLF
cQuery    += " AND SA1.A1_LOJA = SF2.F2_LOJA "+CRLF
cQuery    += " AND SA1.A1_AGEND = '1' "+CRLF
cQuery    += " AND SA1.A1_VEND BETWEEN '"+cVendDe+"' AND '"+cVendAte+"'  "+CRLF
cQuery    += " AND SA1.D_E_L_E_T_ = ' ' "+CRLF

cQuery    += " LEFT JOIN "+RetSqlName("SA3")+" SA3 "+CRLF
cQuery    += " ON SA3.A3_FILIAL = '"+xFilial("SA3")+"' "+CRLF
cQuery    += " AND SA3.A3_COD = SA1.A1_VEND "+CRLF
cQuery    += " AND SA3.D_E_L_E_T_ = ' ' "+CRLF

cQuery    += " INNER JOIN "+RetSqlName("SD2")+" SD2 "+CRLF
cQuery    += " ON SD2.D2_FILIAL = SF2.F2_FILIAL  "+CRLF
cQuery    += " AND SD2.D2_DOC = SF2.F2_DOC "+CRLF
cQuery    += " AND SD2.D2_SERIE = SF2.F2_SERIE "+CRLF
cQuery    += " AND SD2.D2_CLIENTE = SF2.F2_CLIENTE "+CRLF
cQuery    += " AND SD2.D2_LOJA = SF2.F2_LOJA "+CRLF  
cQuery    += " AND SD2.D2_QUANT != '0' "+CRLF  
cQuery    += " AND SD2.D2_CF  IN " + FormatIn(cCFOPVend, "/")+CRLF
cQuery    += " AND NOT EXISTS(SELECT X FROM "+RetSqlName("SD1")+" SD1 "+CRLF
cQuery    += "                 WHERE SD1.D1_FILIAL = SD2.D2_FILIAL "+CRLF
cQuery    += "                 AND SD1.D1_COD = SD2.D2_COD "+CRLF
cQuery    += "                 AND SD1.D1_NFORI = SD2.D2_DOC "+CRLF
cQuery    += "                 AND SD1.D1_SERIORI = SD2.D2_SERIE "+CRLF
cQuery    += "                 AND SD1.D1_FORNECE = SD2.D2_CLIENTE "+CRLF
cQuery    += "                 AND SD1.D1_LOJA = SD2.D2_LOJA "+CRLF
cQuery    += "                 AND SD1.D1_TIPO = 'D' "+CRLF
cQuery    += "                 AND SD1.D_E_L_E_T_ = ' ' "+CRLF
cQuery    += "                 ) "+CRLF
cQuery    += " AND SD2.D_E_L_E_T_ = ' ' "+CRLF

cQuery    += " INNER JOIN "+RetSqlName("SC5")+" SC5 "+CRLF
cQuery    += " ON SC5.C5_FILIAL = SD2.D2_FILIAL "+CRLF
cQuery    += " AND SC5.C5_NUM = SD2.D2_PEDIDO "+CRLF
cQuery    += " AND SC5.C5_TIPO != 'C' "+CRLF //Complemento
cQuery    += " AND SC5.D_E_L_E_T_ = ' ' "+CRLF

cQuery    += " LEFT JOIN "+RetSqlName("SE1")+" SE1 "+CRLF
cQuery    += " ON SE1.E1_FILIAL = '"+xFilial("SE1")+"' "+CRLF
cQuery    += " AND SE1.E1_PREFIXO = SF2.F2_PREFIXO "+CRLF
cQuery    += " AND SE1.E1_NUM = SF2.F2_DUPL "+CRLF
cQuery    += " AND SE1.D_E_L_E_T_ = ' ' "+CRLF


cQuery    += " WHERE SF2.F2_FILIAL = '"+xFilial("SF2")+"' "+CRLF
If !lJob       
	cQuery    += " AND SF2.F2_EMISSAO BETWEEN '"+cEmisDe+"' AND '"+cEmisAte+"'  "+CRLF
	cQuery    += " AND SF2.F2_CLIENTE BETWEEN '"+cClieDe+"' AND '"+cCliAte+"'  "+CRLF
	cQuery    += " AND SF2.F2_LOJA  BETWEEN '"+cLojaDe+"' AND '"+cLojaAte+"' "+CRLF
Else
	cQuery    += " AND SF2.F2_EMISSAO >= '20130101'"+CRLF	
EndIf             
cQuery    += " AND SF2.F2_DATAAG = ' ' "+CRLF
cQuery    += " AND SF2.D_E_L_E_T_ = ' ' "+CRLF

cQuery    += " ORDER BY A3_NOME, A1_COD, A1_LOJA, F2_EMISSAO "+CRLF

//Aviso("",cQuery,{"Ok"},3)

dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)

RestArea(aArea)
Return cArqTmp          


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Funcao    �GeraExcel �Autor  �Elton C.		     � Data �  11/07/2011 ���
�������������������������������������������������������������������������͹��
���Desc.     �Funcao que cria e escreve o arquivo excel.                  ���
�������������������������������������������������������������������������͹��
���Uso       �                                                            ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function GeraExcel(alPlanilha, cNameArq, lJob, cDirJob)
	
Local nlHandle
Local clLocal 	:= ""
Local olExcelApp
Local aPerg		:= {}
Local lRet		:= .T.

Default alPlanilha	:= {}
Default cNameArq 	:= ""
Default lJob 		:= .F.
Default cDirJob		:= ""


If !lJob
	
	aPerg	:= PergFile()//Pergunta com o endere�o do arquivo
	
	If Len(aPerg[2] ) > 0
		If !aPerg[1]
			Return
		EndIf
	Else
		return
	EndIf
	clDir := Alltrim(aPerg[2][1])
	clLocal := clDir + cNameArq
	
	nlHandle  := FCREATE(clLocal)
	
	if nlHandle == -1
		MsgStop("N�o foi poss�vel criar o arquivo em: " + CRLF + clLocal)
	else
		AEVAL(alPlanilha, {|x| FWRITE(nlHandle, x)} )
		FCLOSE(nlHandle)
		
		if File(clLocal)
			
			olExcelApp	:= MsExcel():New()
			olExcelApp:WorkBooks:Open(clLocal)
			olExcelApp:SetVisible(.T.)
			olExcelApp:Destroy()
			
		else
			Conout("Erro ao criar o arquivo em: " + clLocal)
			MsgAlert("Erro ao criar o arquivo em: " + clLocal)
		endif
		
	endif
	
	
Else
	
	clDir 	:= cDirJob
	
	//Verifica se existe o diret�rio, sen�o existir ser� criado no ProtheusData
	If !EXISTDIR(clDir)
		If MakeDir( clDir ) < 0
			lRet := .F.
			Conout("Erro na cria��o do diretorio")
			
			Return lRet
		Else
			lRet := .T.
		EndIf
	EndIf
	
	If lRet
		clLocal := clDir + cNameArq
		nlHandle  := FCREATE(clLocal)
		
		if nlHandle == -1
			Conout("N�o foi poss�vel criar o arquivo em: " + CRLF + clLocal)
		else
			AEVAL(alPlanilha, {|x| FWRITE(nlHandle, x)} )
			FCLOSE(nlHandle)
			
			/*if File(clLocal)
				olExcelApp	:= MsExcel():New()
				olExcelApp:WorkBooks:Open(clLocal)
				olExcelApp:Destroy()
			else
				Conout("Erro ao criar o arquivo em: " + clLocal)
			endif*/
		endif
	EndIf
EndIf

Return lRet     

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PergFile	�Autor  �Elton C.			 � Data �  05/11/11   ���
�������������������������������������������������������������������������͹��
���Desc.     �Pergunta com o endere�o do arquivo				          ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       �			                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function PergFile()

Local aArea 		:= GetArea()
Local alRetPath  	:= {}
Local alParamBox	:= {} 
Local llRet			:= .F.
Local alRet			:= {}		

aAdd( alParamBox ,{6,"Endere�o para gravar o arquivo do Excel","","","ExistDir(&(ReadVar()))","",080,.T.,"","",GETF_LOCALHARD+GETF_NETWORKDRIVE + GETF_RETDIRECTORY})

//Monta a pergunta
llRet := ParamBox(alParamBox ,"Endere�o de arquivo",@alRetPath,,,.T.,50,50,				,			,.T.			,.T.)

alRet := {llRet, alRetPath}

RestArea(aArea)
Return alRet  

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Funcao    �JobFatSAgend � Autor � Elton C.	     � Data �  02/02/12   ���
�������������������������������������������������������������������������͹��
���Descricao � Fun��o utilizada em schedule para enviar o relatorio por	  ���
���          � e-mail aos vendedores						              ���
�������������������������������������������������������������������������͹��
���Uso       � 			                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Static Function JobFatSAgend()

Local aArea 	:= GetArea()
Local cNameArq 	:= ""
Local cDir		:= "\FatSAgend\"
Local cQuery    := ""
Local cArqTmp	:= GetNextAlias()
Local cMsgEmail	:= ""       

cMsgEmail	:= " Voc� recebeu e-mail com a planilha anexa dos Pedidos de Vendas Faturados pendentes de Agendamento de Entrega. "+CRLF+CRLF

cMsgEmail	+= " A rotina autom�tica, enviar� todos os dias, de 2�-feira a 6� feira, a partir das 23:00 h, para cada vendedor, "+CRLF
cMsgEmail	+= " desde que tenha na carteira,  clientes que solicitam agendamento de entrega. "+CRLF+CRLF
cMsgEmail	+= " A rela��o de pedidos pendentes de agendamento segue a ordem de cliente e data de emiss�o de Nota Fiscal,"+CRLF
cMsgEmail	+= " em arquivo no formato Excel."+CRLF+CRLF
cMsgEmail	+= " Se n�o houver pend�ncia de agendamento, a nota Fiscal n�o ser� relacionada "+CRLF+CRLF
cMsgEmail	+= " Para acessar os detalhes, abrir o arquivo em anexo com o programa Excel. "+CRLF+CRLF
cMsgEmail	+= " Em caso de d�vidas, por favor, entrar em contato com o departamento de Log�stica. "+CRLF


cQuery    := " SELECT DISTINCT SA3_VEND.A3_COD CODVEND, SA3_VEND.A3_NOME NOMEVEND, SA3_VEND.A3_EMAIL EMAILVEND, "+CRLF
cQuery    += "         SA3_SPVS.A3_COD CODSUP, SA3_SPVS.A3_NOME NOMESUP, SA3_SPVS.A3_EMAIL EMAILSUP,  "+CRLF
cQuery    += "         SA3_GEREN.A3_COD CODGER, SA3_GEREN.A3_NOME NOMEGER, SA3_GEREN.A3_EMAIL EMAILGER, "+CRLF
cQuery    += "         PZG.PZG_CODVEN,  utl_raw.cast_to_varchar2(DBMS_LOB.SUBSTR(PZG_EMAILP,2000,1)) EMAILPARA, "+CRLF
cQuery    += "         utl_raw.cast_to_varchar2(DBMS_LOB.SUBSTR(PZG_EMAILC,2000,1)) EMAILCOPIA "+CRLF
cQuery    += "         FROM "+RetSqlName("SA1")+" SA1  "+CRLF

cQuery    += " INNER JOIN "+RetSqlName("SA3")+" SA3_VEND "+CRLF
cQuery    += " ON SA3_VEND.A3_FILIAL = '"+xFilial("SA3")+"'  "+CRLF
cQuery    += " AND SA3_VEND.A3_COD = SA1.A1_VEND "+CRLF
cQuery    += " AND SA3_VEND.D_E_L_E_T_ = ' ' "+CRLF

cQuery    += " INNER JOIN "+RetSqlName("PZG")+" PZG "+CRLF
cQuery    += " ON PZG.PZG_FILIAL = '"+xFilial("PZG")+"' "+CRLF
cQuery    += " AND PZG.PZG_CODVEN = SA3_VEND.A3_COD "+CRLF
cQuery    += " AND PZG.D_E_L_E_T_ = ' ' "+CRLF

cQuery    += " LEFT JOIN "+RetSqlName("SA3")+" SA3_SPVS "+CRLF
cQuery    += " ON SA3_SPVS.A3_FILIAL = '"+xFilial("SA3")+"'  "+CRLF
cQuery    += " AND SA3_SPVS.A3_COD = SA3_VEND.A3_SUPER  "+CRLF
cQuery    += " AND SA3_SPVS.D_E_L_E_T_ = ' '  "+CRLF

cQuery    += " LEFT JOIN "+RetSqlName("SA3")+" SA3_GEREN  "+CRLF
cQuery    += " ON SA3_GEREN.A3_FILIAL = '"+xFilial("SA3")+"' "+CRLF
cQuery    += " AND SA3_GEREN.A3_COD = SA3_VEND.A3_GEREN "+CRLF
cQuery    += " AND SA3_GEREN.D_E_L_E_T_ = ' ' "+CRLF

cQuery    += " WHERE SA1.A1_FILIAL = '"+xFilial("SA1")+"' "+CRLF
cQuery    += " AND SA1.A1_AGEND = '1' "+CRLF
cQuery    += " AND SA1.D_E_L_E_T_ = ' ' "+CRLF

dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)

While (cArqTmp)->(!Eof())
	
	cNameArq := ""    
	
	//Gerar o arquivo por vendedor
	cNameArq := GerRelMail((cArqTmp)->CODVEND, (cArqTmp)->CODVEND, cDir)
    
	If !Empty(cNameArq)
		//Envia o Arquivo por e-mail
		NCEnvEmail("Pedidos faturados sem agendamento - Vendedor ("+Alltrim((cArqTmp)->CODVEND)+"-"+ Alltrim((cArqTmp)->NOMEVEND)+")",;//Assunto
				 cMsgEmail,;//Mensagem
				 {cDir+cNameArq},;//Anexo
				 Alltrim((cArqTmp)->EMAILPARA),;//E-mail do destinatario
				 Alltrim((cArqTmp)->EMAILCOPIA),;//C�pia do e-mail
				  "")
	
		//Exclui o arquivo temporario do relatorio, ap�s o envio do e-mail
		ExclArq(cDir, cNameArq)
	EndIf
		    
	(cArqTmp)->(DbSkip())
EndDo


(cArqTmp)->(DbCloseArea())
RestArea(aArea)
Return



/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Funcao    �JobFatSAgG � Autor � Elton C.		     � Data �  02/02/12   ���
�������������������������������������������������������������������������͹��
���Descricao � Fun��o utilizada em schedule para enviar o relatorio geral ���
���          � de todos os vendedores 			 			              ���
�������������������������������������������������������������������������͹��
���Uso       � 			                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Static Function JobFatSAgG()

Local aArea 		:= GetArea()
Local cNameArq 		:= ""
Local cDir			:= "\FatSAgend\"
Local cEmailPara    := U_MyNewSX6("NC_EGEFSAG",;
									"ebrito@ncgames.com.br;fafonso@ncgames.com.br;emezzalira@ncgames.com.br;asalete@ncgames.com.br;anunes@ncgames.com.br",;
									"C",;
									"E-mail para envio do WF c/ relatorio PV Fat.sem agendamento",;
									"E-mail para envio do WF c/ relatorio PV Fat.sem agendamento",;
									"E-mail para envio do WF c/ relatorio PV Fat.sem agendamento",;
									.F. )
Local cEmailPar2    := U_MyNewSX6("NC_EGEFSA2",;
									"",;
									"C",;
									"E-mail para envio do WF c/ relatorio PV Fat.sem agendamento",;
									"E-mail para envio do WF c/ relatorio PV Fat.sem agendamento",;
									"E-mail para envio do WF c/ relatorio PV Fat.sem agendamento",;
									.F. )									
Local cMsgEmail	:= ""

cMsgEmail	:= " Voc� recebeu e-mail com a planilha anexa dos Pedidos de Vendas Faturados pendentes de Agendamento de Entrega. "+CRLF+CRLF

cMsgEmail	+= " A rotina autom�tica, enviar� todos os dias, de 2�-feira a 6� feira, a partir das 23:00 h, para cada vendedor, "+CRLF
cMsgEmail	+= " desde que tenha na carteira,  clientes que solicitam agendamento de entrega. "+CRLF+CRLF
cMsgEmail	+= " A rela��o de pedidos pendentes de agendamento segue a ordem de cliente e data de emiss�o de Nota Fiscal,"+CRLF
cMsgEmail	+= " em arquivo no formato Excel."+CRLF+CRLF
cMsgEmail	+= " Se n�o houver pend�ncia de agendamento, a nota Fiscal n�o ser� relacionada "+CRLF+CRLF
cMsgEmail	+= " Para acessar os detalhes, abrir o arquivo em anexo com o programa Excel. "+CRLF+CRLF
cMsgEmail	+= " Em caso de d�vidas, por favor, entrar em contato com o departamento de Log�stica. "+CRLF


//Gerar o arquivo por vendedor
cNameArq := GerRelMail(" ", "ZZZZZZ", cDir)

If !Empty(cNameArq) .And. !Empty(cEmailPara)
    
	//Envia o Arquivo por e-mail
	NCEnvEmail("Pedidos faturados sem agendamento ",;//Assunto
				cMsgEmail,;//Mensagem
				{cDir+cNameArq},;//Anexo
				Alltrim(cEmailPara+";"+cEmailPar2),;//E-mail do destinatario
				"",;//C�pia do e-mail
				"")
				
	//Exclui o arquivo temporario do relatorio, ap�s o envio do e-mail
	ExclArq(cDir, cNameArq)

EndIf
		    
RestArea(aArea)
Return



/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Funcao    �GerRelMail � Autor � Elton C.		     � Data �  02/02/12   ���
�������������������������������������������������������������������������͹��
���Descricao � Fun��o utilizada para gerar e enviar o relatorio por e-mail���
���          � 															  ���
�������������������������������������������������������������������������͹��
���Uso       � 			                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Static Function GerRelMail(cVendDe, cVendAte, cDir)
Local aArea 		:= GetArea()
Local cArqTmp   	:= ""
Local aParams		:= {}
Local apExcel		:= {} 
Local cNameArq 		:= "FatSemAgendamento_" + DtoS(Date())+STRTRAN(Time(), ":", "")+".xls"
Local nQtdReg		:= 0
Local nDiasFSAg	:=	U_MyNewSX6("NC_DIASFSA",;
									"15",;
									"N",;
									"Quantidade de dias para faturamento sem agendamento",;
									"Quantidade de dias para faturamento sem agendamento",;
									"Quantidade de dias para faturamento sem agendamento",;
									.F. )
                          

Default cVendDe		:= "" 
Default cVendAte    := "" 
Default cDir		:= ""

//Lista os dados do relatorio
cArqTmp :=  GetDRel(,,,,,, cVendDe, cVendAte, .T.)
	
//Verifica quantidade de registros
(cArqTmp)->( dbEval( {|| nQtdReg++ } ) )
(cArqTmp)->( dbGoTop() )

++nQtdReg//Soma 1, para considerar o cabe�alho

If (cArqTmp)->(!Eof())
	//Tags de inicializa��o do arquivo html (</html></body>)
	WrTXMLArq(1,@apExcel, nQtdReg)
	
	While (cArqTmp)->(!Eof())
		aAcaoAg	:= {}
		aAcaoAg	:= GetAcaoAg(STOD((cArqTmp)->F2_EMISSAO))
		
		If Len(aAcaoAg) >= 2
			
			WrTXMLArq(2,;//Op��o para preenchimento dos itens
			@apExcel,;//Array com as informa��es do XML
			nQtdReg,;//Qauntidade de itens
			(cArqTmp)->A3_COD,;//Codigo do vendedor
			(cArqTmp)->A3_NOME,;//Nome do vendedor
			(cArqTmp)->A1_COD,;//Codigo do cliente
			(cArqTmp)->A1_LOJA,;//Loja do cliente
			(cArqTmp)->A1_NOME,;//Razao social
			(cArqTmp)->A1_NREDUZ,;//Nome fantasia
			DTOS(STOD((cArqTmp)->F2_EMISSAO)),;//Dt.Emissao NF
			(cArqTmp)->F2_DOC,;// NF
			(cArqTmp)->C5_NUM,;//Pedido NC
			(cArqTmp)->C5_PEDCLI,;//Pedido do cliente
			(cArqTmp)->A1_MUN,;//Municipio
			(cArqTmp)->F2_EST,;//UF
			(cArqTmp)->F2_VALBRUT,;//Valor da NF
			(cArqTmp)->E1_HISTWF,;//Ultimo historico
			aAcaoAg[1],;//Dias de pendencia
			DTOS(STOD((cArqTmp)->F2_EMISSAO) + nDiasFSAg ),;//Dt.Limite para agendamento
			aAcaoAg[2])//A��o
			
		EndIf
		
		(cArqTmp)->(DbSkip())
	EndDo
	
	//Fecha as tags de inicializa��o do arquivo html (<html><body>)
	WrTXMLArq(3,@apExcel)

	//Gera a planilha do Excel
	GeraExcel(apExcel, cNameArq, .T., cDir )
Else
	cNameArq := ""
EndIf

(cArqTmp)->(DbCloseArea())
RestArea(aArea)
Return cNameArq

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Funcao    �ExclArq	� Autor � Elton C.		     � Data �  02/02/12   ���
�������������������������������������������������������������������������͹��
���Descricao � Exclui arquivos ap�s o envio do e-mail					  ���
���          �                      									  ���
�������������������������������������������������������������������������͹��
���Uso       � 			                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Static Function ExclArq(cDir, cNomeArq)

Local aArea		:= GetArea()
Local nRetExc   := 0
Local cMsgErr	:= ""
Local lRet		:= .T. 

Default cDir 		:= ""  
Default cNomeArq    := ""


nRetExc := FERASE(Alltrim(cDir)+Alltrim(cNomeArq))
If nRetExc !=  0
	conout("Erro ao excluir arquivo -> "+Alltrim(cDir)+Alltrim(cNomeArq))
	lRet := .F.
EndIf

RestArea(aArea)
Return lRet


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCEnvEmail  �Autor  �Microsiga         � Data �  01/30/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function NCEnvEmail(cAssunto, cBody, aAnexos, cEmailTo, cEmailCc, cErro)
Local lRetorno	:= .T.
Local cServer   := GetNewPar("MV_RELSERV","")
Local cAccount	:= GetNewPar("MV_RELACNT","")
Local cPassword	:= GetNewPar("MV_RELAPSW","")
Local lMailAuth	:= GetNewPar("MV_RELAUTH",.F.)

Default aAnexos		:= {}
Default cBody		:= ""
Default cAssunto	:= ""
Default cErro		:= ""
Default cEmailCc:=""

If MailSmtpOn( cServer, cAccount, cPassword )
	If lMailAuth
		If ! ( lRetorno := MailAuth(cAccount,cPassword) )
			lRetorno := MailAuth(SubStr(cAccount,1,At("@",cAccount)-1),cPassword)
		EndIf
	Endif
	If lRetorno
		If !MailSend(cAccount,{cEmailTo},{cEmailCc},{},cAssunto,cBody,aAnexos,.F.)
			cErro := "Erro na tentativa de e-mail para " + cEmailTo + ". " + Mailgeterr()
			lRetorno := .F.
		EndIf
	Else
		cErro := "Erro na tentativa de autentica��o da conta " + cAccount + ". "
		lRetorno := .F.
	EndIf
	MailSmtpOff()
Else
	cErro := "Erro na tentativa de conex�o com o servidor SMTP: " + cServer + " com a conta " + cAccount + ". "
	lRetorno := .F.
EndIf


Return lRetorno
                    


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �GetAcaoAg  �Autor  �Microsiga         � Data �  01/30/14   ���
�������������������������������������������������������������������������͹��
���Desc.     � Retorna o status/ a��o do agendamento                      ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function GetAcaoAg(dDtEmissao)

Local nDiasFSAg	:=	U_MyNewSX6("NC_DIASFSA",;
									"15",;
									"N",;
									"Quantidade de dias para faturamento sem agendamento",;
									"Quantidade de dias para faturamento sem agendamento",;
									"Quantidade de dias para faturamento sem agendamento",;
									.F. )

Local dDtAtual		:= MsDate()
Local dDtAtM15		:= Iif(!Empty(nDiasFSAg) .And. nDiasFSAg != 0 ,dDtEmissao + nDiasFSAg, MsDate())
Local nDiasDif		:= 0
Local aRet			:= {}
                           
Default dDtEmissao := CTOD('')

If dDtAtM15 < dDtAtual

	nDiasDif := dDtAtM15 - dDtAtual
	aRet := {nDiasDif,"Prazo expirado, cancelar venda"}

ElseIf dDtAtM15 >= dDtAtual 
	nDiasDif := dDtAtM15 - dDtAtual
	if nDiasDif == 0
		aRet := {nDiasDif,OemToAnsi("Agendamento urgente, a data p/ agendamento expira hoje")}	
	ElseIf nDiasDif == 1
		aRet := {nDiasDif,OemToAnsi("Agendamento urgente, falta "+Alltrim(Str(nDiasDif))+" dia p/ expirar a data de agendamento")}	
	ElseIf nDiasDif == 2	
		aRet := {nDiasDif,OemToAnsi("Agendamento urgente, faltam "+Alltrim(Str(nDiasDif))+" dias p/ expirar a data de agendamento")}
	Else
		aRet := {nDiasDif,OemToAnsi("Atencao, faltam "+Alltrim(Str(nDiasDif))+" dias p/ expirar a data de agendamento ")}	
	EndIf
EndIf

Return aRet




/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �WrTXMLArq  �Autor  �Microsiga         � Data �  01/30/14   ���
�������������������������������������������������������������������������͹��
���Desc.     � Retorna os dados do XML a ser gravado no relat�rio do Excel���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                  	      ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/            
Static Function WrTXMLArq(nOpc, apExcel, nQtdReg, cCodVend, cNomeVend, cCodCli, cLoja, cRazaoSoc, cNomFantas, cDtNotaFis,;
							cNotaFisca, cPedidoNC, cPedidoCli, cCidade, cUF, nValorBrt, cUltimHist, nDiasPend,;
							cDtLimAgen,	cAcao)
								
                     
Local cDtEmisAux	:= ""
Local cDtLimAux 	:= ""

Default nOpc 		:= 1
Default apExcel 	:= {}
Default nQtdReg		:= 0 
Default cCodVend	:= "" 
Default cNomeVend	:= "" 
Default cCodCli		:= "" 
Default cLoja		:= "" 
Default cRazaoSoc	:= "" 
Default cNomFantas	:= "" 
Default cDtNotaFis	:= ""
Default cNotaFisca	:= "" 
Default cPedidoNC	:= "" 
Default cPedidoCli	:= "" 
Default cCidade		:= "" 
Default cUF			:= "" 
Default nValorBrt	:= 0 
Default cUltimHist	:= "" 
Default nDiasPend	:= 0
Default cDtLimAgen	:= ""	
Default cAcao		:= ""


//Converte a data de emiss�o para o formado do excel
cDtEmisAux	:= SubStr(cDtNotaFis,1,4)+"-"+SubStr(cDtNotaFis,5,2)+"-"+SubStr(cDtNotaFis,7,2)+"T00:00:00.000"
cDtLimAux 	:= SubStr(cDtLimAgen,1,4)+"-"+SubStr(cDtLimAgen,5,2)+"-"+SubStr(cDtLimAgen,7,2)+"T00:00:00.000"

If nOpc == 1
	Aadd(apExcel, '<?xml version="1.0"?>'+CRLF)
	Aadd(apExcel, '<?mso-application progid="Excel.Sheet"?>'+CRLF)
	Aadd(apExcel, '<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet"'+CRLF)
	Aadd(apExcel, ' xmlns:o="urn:schemas-microsoft-com:office:office"'+CRLF)
	Aadd(apExcel, ' xmlns:x="urn:schemas-microsoft-com:office:excel"'+CRLF)
	Aadd(apExcel, ' xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"'+CRLF)
	Aadd(apExcel, ' xmlns:html="http://www.w3.org/TR/REC-html40">'+CRLF)
	Aadd(apExcel, ' <DocumentProperties xmlns="urn:schemas-microsoft-com:office:office">'+CRLF)
	Aadd(apExcel, '  <Author>Rubens Ciambarella</Author>'+CRLF)
	Aadd(apExcel, '  <LastAuthor>Rubens Ciambarell</LastAuthor>'+CRLF)
	Aadd(apExcel, '  <Created>2014-11-26T22:11:49Z</Created>'+CRLF)
	Aadd(apExcel, '  <LastSaved>2014-11-26T22:11:49Z</LastSaved>'+CRLF)
	Aadd(apExcel, '  <Version>12.00</Version>'+CRLF)
	Aadd(apExcel, ' </DocumentProperties>'+CRLF)
	Aadd(apExcel, ' <ExcelWorkbook xmlns="urn:schemas-microsoft-com:office:excel">'+CRLF)
	Aadd(apExcel, '  <WindowHeight>8235</WindowHeight>'+CRLF)
	Aadd(apExcel, '  <WindowWidth>19200</WindowWidth>'+CRLF)
	Aadd(apExcel, '  <WindowTopX>0</WindowTopX>'+CRLF)
	Aadd(apExcel, '  <WindowTopY>0</WindowTopY>'+CRLF)
	Aadd(apExcel, '  <ProtectStructure>False</ProtectStructure>'+CRLF)
	Aadd(apExcel, '  <ProtectWindows>False</ProtectWindows>'+CRLF)
	Aadd(apExcel, ' </ExcelWorkbook>'+CRLF)
	Aadd(apExcel, ' <Styles>'+CRLF)
	Aadd(apExcel, '  <Style ss:ID="Default" ss:Name="Normal">'+CRLF)
	Aadd(apExcel, '   <Alignment ss:Vertical="Bottom"/>'+CRLF)
	Aadd(apExcel, '   <Borders/>'+CRLF)
	Aadd(apExcel, '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '   <Interior/>'+CRLF)
	Aadd(apExcel, '   <NumberFormat/>'+CRLF)
	Aadd(apExcel, '   <Protection/>'+CRLF)
	Aadd(apExcel, '  </Style>'+CRLF)
	Aadd(apExcel, '  <Style ss:ID="s66" ss:Name="Separador de milhares">'+CRLF)
	Aadd(apExcel, '   <NumberFormat ss:Format="_-* #,##0.00_-;\-* #,##0.00_-;_-* &quot;-&quot;??_-;_-@_-"/>'+CRLF)
	Aadd(apExcel, '  </Style>'+CRLF)
	Aadd(apExcel, '  <Style ss:ID="s57">'+CRLF)
	Aadd(apExcel, '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11"/>'+CRLF)
	Aadd(apExcel, '  </Style>'+CRLF)

	Aadd(apExcel, '  <Style ss:ID="s72">'+CRLF)
	Aadd(apExcel, '   <Alignment ss:Horizontal="Left" ss:Vertical="Center" ss:WrapText="1"/>'+CRLF)
	Aadd(apExcel, '   <Borders>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"'+CRLF)
	Aadd(apExcel, '     ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"'+CRLF)
	Aadd(apExcel, '     ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '   </Borders>'+CRLF)
	Aadd(apExcel, '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="8" ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '  </Style>'+CRLF)
	
	Aadd(apExcel, '  <Style ss:ID="s82">'+CRLF)
	Aadd(apExcel, '   <Alignment ss:Horizontal="Left" ss:Vertical="Center" ss:WrapText="1"/>'+CRLF)
	Aadd(apExcel, '   <Borders>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"'+CRLF)
	Aadd(apExcel, '     ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"'+CRLF)
	Aadd(apExcel, '     ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '   </Borders>'+CRLF)
	Aadd(apExcel, '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="8" ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '   <NumberFormat ss:Format="Short Date"/>'+CRLF)
	Aadd(apExcel, '  </Style>	'+CRLF)


	Aadd(apExcel, '  <Style ss:ID="s99">'+CRLF)
	Aadd(apExcel, '   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>'+CRLF)
	Aadd(apExcel, '   <Borders>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"'+CRLF)
	Aadd(apExcel, '     ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"'+CRLF)
	Aadd(apExcel, '     ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"'+CRLF)
	Aadd(apExcel, '     ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '   </Borders>'+CRLF)
	Aadd(apExcel, '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="8" ss:Color="#FFFFFF"/>'+CRLF)
	Aadd(apExcel, '   <Interior ss:Color="#5B9BD5" ss:Pattern="Solid"/>'+CRLF)
	Aadd(apExcel, '  </Style>'+CRLF)
	Aadd(apExcel, '  <Style ss:ID="s103">'+CRLF)
	Aadd(apExcel, '   <Alignment ss:Vertical="Bottom" ss:WrapText="1"/>'+CRLF)
	Aadd(apExcel, '  </Style>'+CRLF)
	Aadd(apExcel, '  <Style ss:ID="s104" ss:Parent="s66">'+CRLF)
	Aadd(apExcel, '   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>'+CRLF)
	Aadd(apExcel, '   <Borders>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"'+CRLF)
	Aadd(apExcel, '     ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"'+CRLF)
	Aadd(apExcel, '     ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"'+CRLF)
	Aadd(apExcel, '     ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '   </Borders>'+CRLF)
	Aadd(apExcel, '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="8" ss:Color="#FFFFFF"/>'+CRLF)
	Aadd(apExcel, '   <Interior ss:Color="#5B9BD5" ss:Pattern="Solid"/>'+CRLF)
	Aadd(apExcel, '  </Style>'+CRLF)
	Aadd(apExcel, '  <Style ss:ID="s105" ss:Parent="s66">'+CRLF)
	Aadd(apExcel, '   <Alignment ss:Horizontal="Right" ss:Vertical="Center" ss:WrapText="1"/>'+CRLF)
	Aadd(apExcel, '   <Borders>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"'+CRLF)
	Aadd(apExcel, '     ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"'+CRLF)
	Aadd(apExcel, '     ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '   </Borders>'+CRLF)
	Aadd(apExcel, '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="8" ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '  </Style>'+CRLF)
	Aadd(apExcel, '  <Style ss:ID="s106" ss:Parent="s66">'+CRLF)
	Aadd(apExcel, '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '  </Style>'+CRLF)
	Aadd(apExcel, '  <Style ss:ID="s116" ss:Parent="s66">'+CRLF)
	Aadd(apExcel, '   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>'+CRLF)
	Aadd(apExcel, '   <Borders>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"'+CRLF)
	Aadd(apExcel, '     ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"'+CRLF)
	Aadd(apExcel, '     ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"'+CRLF)
	Aadd(apExcel, '     ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '   </Borders>'+CRLF)
	Aadd(apExcel, '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="8" ss:Color="#FFFFFF"/>'+CRLF)
	Aadd(apExcel, '   <Interior ss:Color="#5B9BD5" ss:Pattern="Solid"/>'+CRLF)
	Aadd(apExcel, '   <NumberFormat ss:Format="_-* #,##0_-;\-* #,##0_-;_-* &quot;-&quot;??_-;_-@_-"/>'+CRLF)
	Aadd(apExcel, '  </Style>'+CRLF)
	Aadd(apExcel, '  <Style ss:ID="s117" ss:Parent="s66">'+CRLF)
	Aadd(apExcel, '   <Alignment ss:Horizontal="Right" ss:Vertical="Center" ss:WrapText="1"/>'+CRLF)
	Aadd(apExcel, '   <Borders>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"'+CRLF)
	Aadd(apExcel, '     ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"'+CRLF)
	Aadd(apExcel, '     ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '   </Borders>'+CRLF)
	Aadd(apExcel, '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="8" ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '   <NumberFormat ss:Format="_-* #,##0_-;\-* #,##0_-;_-* &quot;-&quot;??_-;_-@_-"/>'+CRLF)
	Aadd(apExcel, '  </Style>'+CRLF)
	Aadd(apExcel, '  <Style ss:ID="s118" ss:Parent="s66">'+CRLF)
	Aadd(apExcel, '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '   <NumberFormat ss:Format="_-* #,##0_-;\-* #,##0_-;_-* &quot;-&quot;??_-;_-@_-"/>'+CRLF)
	Aadd(apExcel, '  </Style>'+CRLF)
	Aadd(apExcel, '  <Style ss:ID="s119">'+CRLF)
	Aadd(apExcel, '   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>'+CRLF)
	Aadd(apExcel, '   <Borders>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"'+CRLF)
	Aadd(apExcel, '     ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"'+CRLF)
	Aadd(apExcel, '     ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"'+CRLF)
	Aadd(apExcel, '     ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '   </Borders>'+CRLF)
	Aadd(apExcel, '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="8" ss:Color="#FFFFFF"/>'+CRLF)
	Aadd(apExcel, '   <Interior ss:Color="#5B9BD5" ss:Pattern="Solid"/>'+CRLF)
	Aadd(apExcel, '   <NumberFormat ss:Format="@"/>'+CRLF)
	Aadd(apExcel, '  </Style>'+CRLF)
	Aadd(apExcel, '  <Style ss:ID="s120">'+CRLF)
	Aadd(apExcel, '   <Alignment ss:Horizontal="Left" ss:Vertical="Center" ss:WrapText="1"/>'+CRLF)
	Aadd(apExcel, '   <Borders>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"'+CRLF)
	Aadd(apExcel, '     ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"'+CRLF)
	Aadd(apExcel, '     ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '   </Borders>'+CRLF)
	Aadd(apExcel, '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="8" ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '   <NumberFormat ss:Format="@"/>'+CRLF)
	Aadd(apExcel, '  </Style>'+CRLF)
	Aadd(apExcel, '  <Style ss:ID="s121">'+CRLF)
	Aadd(apExcel, '   <NumberFormat ss:Format="@"/>'+CRLF)
	Aadd(apExcel, '  </Style>'+CRLF)
	Aadd(apExcel, '  <Style ss:ID="s122">'+CRLF)
	Aadd(apExcel, '   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>'+CRLF)
	Aadd(apExcel, '   <Borders>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"'+CRLF)
	Aadd(apExcel, '     ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"'+CRLF)
	Aadd(apExcel, '     ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"'+CRLF)
	Aadd(apExcel, '     ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"'+CRLF)
	Aadd(apExcel, '     ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '   </Borders>'+CRLF)
	Aadd(apExcel, '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="8" ss:Color="#FFFFFF"/>'+CRLF)
	Aadd(apExcel, '   <Interior ss:Color="#5B9BD5" ss:Pattern="Solid"/>'+CRLF)
	Aadd(apExcel, '   <NumberFormat ss:Format="@"/>'+CRLF)
	Aadd(apExcel, '  </Style>'+CRLF)
	Aadd(apExcel, '  <Style ss:ID="s123">'+CRLF)
	Aadd(apExcel, '   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>'+CRLF)
	Aadd(apExcel, '   <Borders>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"'+CRLF)
	Aadd(apExcel, '     ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"'+CRLF)
	Aadd(apExcel, '     ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"'+CRLF)
	Aadd(apExcel, '     ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '   </Borders>'+CRLF)
	Aadd(apExcel, '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="8" ss:Color="#FFFFFF"/>'+CRLF)
	Aadd(apExcel, '   <Interior ss:Color="#5B9BD5" ss:Pattern="Solid"/>'+CRLF)
	Aadd(apExcel, '   <NumberFormat ss:Format="@"/>'+CRLF)
	Aadd(apExcel, '  </Style>'+CRLF)
	Aadd(apExcel, '  <Style ss:ID="s124">'+CRLF)
	Aadd(apExcel, '   <Alignment ss:Horizontal="Left" ss:Vertical="Center" ss:WrapText="1"/>'+CRLF)
	Aadd(apExcel, '   <Borders>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"'+CRLF)
	Aadd(apExcel, '     ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"'+CRLF)
	Aadd(apExcel, '     ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"'+CRLF)
	Aadd(apExcel, '     ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '   </Borders>'+CRLF)
	Aadd(apExcel, '   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="8" ss:Color="#000000"/>'+CRLF)
	Aadd(apExcel, '   <NumberFormat ss:Format="@"/>'+CRLF)
	Aadd(apExcel, '  </Style>'+CRLF)
	Aadd(apExcel, ' </Styles>'+CRLF)
	Aadd(apExcel, ' <Worksheet ss:Name="FatSemAgendamento_2014112619505">'+CRLF)
	Aadd(apExcel, '  <Table ss:ExpandedColumnCount="17" ss:ExpandedRowCount="'+Alltrim(Str(nQtdReg))+'" x:FullColumns="1"'+CRLF)
	Aadd(apExcel, '   x:FullRows="1" ss:DefaultRowHeight="15">'+CRLF)
	Aadd(apExcel, '   <Column ss:StyleID="s121" ss:Width="55.5"/>'+CRLF)
	Aadd(apExcel, '   <Column ss:StyleID="s121" ss:Width="72"/>'+CRLF)
	Aadd(apExcel, '   <Column ss:StyleID="s121" ss:AutoFitWidth="0" ss:Width="58.5"/>'+CRLF)
	Aadd(apExcel, '   <Column ss:StyleID="s121" ss:AutoFitWidth="0" ss:Width="52.5"/>'+CRLF)
	Aadd(apExcel, '   <Column ss:StyleID="s121" ss:AutoFitWidth="0" ss:Width="132"/>'+CRLF)
	Aadd(apExcel, '   <Column ss:StyleID="s121" ss:AutoFitWidth="0" ss:Width="122.25"/>'+CRLF)
	Aadd(apExcel, '   <Column ss:StyleID="s121" ss:AutoFitWidth="0" ss:Width="88.5"/>'+CRLF)
	Aadd(apExcel, '   <Column ss:StyleID="s121" ss:AutoFitWidth="0" ss:Width="74.25"/>'+CRLF)
	Aadd(apExcel, '   <Column ss:StyleID="s121" ss:AutoFitWidth="0" ss:Width="63"/>'+CRLF)
	Aadd(apExcel, '   <Column ss:StyleID="s121" ss:Width="57"/>'+CRLF)
	Aadd(apExcel, '   <Column ss:StyleID="s121" ss:AutoFitWidth="0" ss:Width="63"/>'+CRLF)
	Aadd(apExcel, '   <Column ss:StyleID="s121" ss:AutoFitWidth="0" ss:Width="38.25"/>'+CRLF)
	Aadd(apExcel, '   <Column ss:StyleID="s106" ss:AutoFitWidth="0" ss:Width="66"/>'+CRLF)
	Aadd(apExcel, '   <Column ss:AutoFitWidth="0" ss:Width="350.25"/>'+CRLF)
	Aadd(apExcel, '   <Column ss:StyleID="s118" ss:AutoFitWidth="0" ss:Width="59.25"/>'+CRLF)
	Aadd(apExcel, '   <Column ss:Width="99.75"/>'+CRLF)
	Aadd(apExcel, '   <Column ss:StyleID="s103" ss:Width="261.75"/>'+CRLF)
	Aadd(apExcel, '   <Row ss:Height="22.5" ss:StyleID="s57">'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s122"><Data ss:Type="String">Cod.Vendedor</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s123"><Data ss:Type="String">Nome Vendedor</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s123"><Data ss:Type="String">Cod.Cliente</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s123"><Data ss:Type="String">Loja</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s119"><Data ss:Type="String">Razao Social</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s119"><Data ss:Type="String">Nome Fantasia</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s123"><Data ss:Type="String">Dt.Nota Fiscal</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s119"><Data ss:Type="String">Nota Fiscal</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s119"><Data ss:Type="String">Pedido NC</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s119"><Data ss:Type="String">Pedido Cliente</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s119"><Data ss:Type="String">Cidade</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s119"><Data ss:Type="String">UF</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s104"><Data ss:Type="String">Valor NF</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s99"><Data ss:Type="String">Ultimo hitorico</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s116"><Data ss:Type="String">Dias em pendencias</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s99"><Data ss:Type="String">Dt.Limite p/ Agendamento</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s99"><Data ss:Type="String">Acao</Data></Cell>'+CRLF)
	Aadd(apExcel, '   </Row>'+CRLF)
ElseIf nOpc == 2
	
	Aadd(apExcel, '   <Row ss:AutoFitHeight="0">'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s124"><Data ss:Type="String">'+cCodVend+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s120"><Data ss:Type="String">'+cNomeVend+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s120"><Data ss:Type="String">'+cCodCli+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s120"><Data ss:Type="String">'+cLoja+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s120"><Data ss:Type="String">'+cRazaoSoc+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s120"><Data ss:Type="String">'+cNomFantas+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s82"><Data ss:Type="DateTime">'+cDtEmisAux+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s120"><Data ss:Type="String">'+cNotaFisca+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s120"><Data ss:Type="String">'+cPedidoNC+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s120"><Data ss:Type="String">'+cPedidoCli+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s120"><Data ss:Type="String">'+cCidade+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s120"><Data ss:Type="String">'+cUF+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s105"><Data ss:Type="Number">'+Alltrim(Str(nValorBrt))+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s72"><Data ss:Type="String">'+cUltimHist+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s117"><Data ss:Type="Number">'+Alltrim(Str(nDiasPend)) +'</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s82"><Data ss:Type="DateTime">'+cDtLimAux+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '    <Cell ss:StyleID="s72"><Data ss:Type="String">'+cAcao+'</Data></Cell>'+CRLF)
	Aadd(apExcel, '   </Row>'+CRLF)
	
ElseIf nOpc == 3
	
	Aadd(apExcel, '  </Table>'+CRLF)
	Aadd(apExcel, '  <WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">'+CRLF)
	Aadd(apExcel, '   <PageSetup>'+CRLF)
	Aadd(apExcel, '    <Header x:Margin="0.49"/>'+CRLF)
	Aadd(apExcel, '    <Footer x:Margin="0.49"/>'+CRLF)
	Aadd(apExcel, '    <PageMargins x:Bottom="0.98" x:Left="0.79" x:Right="0.79" x:Top="0.98"/>'+CRLF)
	Aadd(apExcel, '   </PageSetup>'+CRLF)
	Aadd(apExcel, '   <Print>'+CRLF)
	Aadd(apExcel, '    <ValidPrinterInfo/>'+CRLF)
	Aadd(apExcel, '    <PaperSizeIndex>9</PaperSizeIndex>'+CRLF)
	Aadd(apExcel, '    <HorizontalResolution>600</HorizontalResolution>'+CRLF)
	Aadd(apExcel, '    <VerticalResolution>600</VerticalResolution>'+CRLF)
	Aadd(apExcel, '   </Print>'+CRLF)
	Aadd(apExcel, '   <Selected/>'+CRLF)
	Aadd(apExcel, '   <DoNotDisplayGridlines/>'+CRLF)
	Aadd(apExcel, '   <Panes>'+CRLF)
	Aadd(apExcel, '    <Pane>'+CRLF)
	Aadd(apExcel, '     <Number>3</Number>'+CRLF)
	Aadd(apExcel, '     <ActiveRow>3</ActiveRow>'+CRLF)
	Aadd(apExcel, '     <ActiveCol>4</ActiveCol>'+CRLF)
	Aadd(apExcel, '    </Pane>'+CRLF)
	Aadd(apExcel, '   </Panes>'+CRLF)
	Aadd(apExcel, '   <ProtectObjects>False</ProtectObjects>'+CRLF)
	Aadd(apExcel, '   <ProtectScenarios>False</ProtectScenarios>'+CRLF)
	Aadd(apExcel, '  </WorksheetOptions>'+CRLF)
	Aadd(apExcel, ' </Worksheet>'+CRLF)
	Aadd(apExcel, '</Workbook>'+CRLF)
EndIf

Return 
