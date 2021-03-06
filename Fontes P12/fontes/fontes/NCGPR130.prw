#INCLUDE "PROTHEUS.CH"
#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"


#DEFINE CODCLIENTE 	1
#DEFINE LOJACLIENTE 2
#DEFINE CODFORNECE 	3
#DEFINE LOJAFORNCE 	4
#DEFINE EMPDESTINO	5
#DEFINE FILDESTINO 	6
#DEFINE LOJADESTINO	7

Static aDadosFilt:={}


User Function PR130JSt(aDados)
	Default aDados := {"03","30"}
	
	aDadosFilt:={"1","*"}
	U_NCJOB130(aDados)
Return 

User Function PR130JPr(aDados)
	Default aDados := {"40","01","1","*"}
	aDadosFilt:={"1","*"}
	U_NCJOB130(aDados)
Return 



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGPR130  �Autor  �Microsiga           � Data �  01/17/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function NCGPR130()
Local aArea 	:= GetArea()
Local aPerg		:= {}
Local aPergAux  := {}

aPergAux := PergCCega()

If aPergAux[1]
	aPerg	:= aPergAux[2]
	
	If Len(aPerg) > 0
		Processa( {|| 	RunConfCega(.F.,;
		aPerg[1],; //Emissao de
		aPerg[2],; //Emissao at�
		aPerg[3],; //Documento de
		aPerg[4],; //Documento ate
		aPerg[5],; //Serie de
		aPerg[6],; //Cliente de
		aPerg[7],; //Cliente at�
		aPerg[8],; //Loja de
		aPerg[9]); //Loja ate
		},"","Processando." )
	EndIf
EndIf
RestArea(aArea)
Return

User Function PR130REL()

Local aAreaAtu	:=GetArea()
Local cPerg     :=PADR('NCGPR130', LEN(SX1->X1_GRUPO))
Local oReport

Private cQryAlias	:= GetNextAlias()
Private cStatusNF
PergImp(cPerg)
Pergunte(cPerg,.F.)

oReport:=ReportDef(cPerg)
oReport:PrintDialog()

If Select(cQryAlias)>0
	(cQryAlias)->(DbCloseArea())
EndIf


RestArea(aAreaAtu)

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCJOB130  �Autor  �Microsiga           � Data �  01/17/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function NCJOB130(aDados)

Local aArea := {}

Default aDados := {"01","03",,""}

aArea := GetArea()

RpcClearEnv()
RpcSettype(3)
RpcSetEnv(aDados[1],aDados[2])

If Empty(aDadosFilt)
	aDadosFilt:={,""}
EndIf	

//Executa a rotina para envio a conferencia cega
//RunConfCega(,,,,,aDados[3],,,,,AllTrim(aDados[4]))

RunConfCega(/*lJob*/,/*dDtIni*/, /*dDtFin*/,/*cDocDe*/,/*cDocAte*/,aDadosFilt[1]/* cSerie*/,/*cCodCliDe*/,/*cCodCliAte*/,/*cLojaDe*/,/*cLojaAte*/,AllTrim(aDadosFilt[2])/*cFilExec*/)

RestArea(aArea)
Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PergCCega	 �Autor  �Microsiga          � Data �  26/01/16   ���
�������������������������������������������������������������������������͹��
���Desc.     �Perguntas da conferencia cega                               ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function PergCCega()

Local aArea 		:= GetArea()
Local aRetPath  	:= {}
Local aParamBox	:= {}
Local lRet			:= .F.
Local aRet			:= {}

AADD(aParamBox,{1,"Emiss�o de "		,CtoD("//")					,"@D"	,"" 	,"" 	,"",70,.T.})
AADD(aParamBox,{1,"Emiss�o at� "	,CtoD("//")					,"@D"	,"" 	,""		,"",70,.T.})
AADD(aParamBox,{1,"Documento de: "	,Space(TAMSX3("F2_DOC")[1])	,"@!"	,""		,""	 	,"",70,.F.})
AADD(aParamBox,{1,"Documento at� "	,Space(TAMSX3("F2_DOC")[1])	,"@!"	,""		,""	 	,"",70,.T.})
AADD(aParamBox,{1,"Serie"			,Space(TAMSX3("A1_LOJA")[1]),"@!"	,""		,""		,"",70,.F.})
AADD(aParamBox,{1,"Cliente de"		,Space(TAMSX3("A1_COD")[1])	,"@!"	,""		,"SA1"	,"",70,.F.})
AADD(aParamBox,{1,"Cliente at�"		,Space(TAMSX3("A1_COD")[1])	,"@!"	,""		,"SA1"	,"",70,.T.})
AADD(aParamBox,{1,"Loja de"			,Space(TAMSX3("A1_LOJA")[1]),"@!"	,""		,""		,"",70,.F.})
AADD(aParamBox,{1,"Loja at�"		,Space(TAMSX3("A1_LOJA")[1]),"@!"	,""		,""		,"",70,.T.})

//Monta a pergunta
lRet := ParamBox(aParamBox ,"Endere�o do arquivo",@aRetPath,,,.T.,50,50,,,.T.,.T.)

aRet := {lRet, aRetPath}

RestArea(aArea)
Return aRet


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �RunConfCega  �Autor  �Microsiga        � Data �  01/17/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �Executa a rotina para verificar e enviar conferencia cega   ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function RunConfCega(lJob,dDtIni, dDtFin, cDocDe, cDocAte, cSerie, cCodCliDe, cCodCliAte, cLojaDe, cLojaAte,cFilExec)

Local aArea 	:= GetArea()
Local cQuery    := ""
Local cArqTmp	:= GetNextAlias()
Local aLojDest	:= {}
Local cMsgErr	:= ""
Local cAssunto 	:= "Erro ao enviar para conferencia cega "
Local cMsgEmail := ""
Local nCnt		:= 0
Local dDtAux		:=U_MyNewSX6("NC_NCINT02","01/04/17","D","Data de Corte para envio Conferencia Cega","","",.F. )
Local cFiltroSF2
Local cEmailPara:= U_MyNewSX6("NC_IWMCC",;
"",;
"C",;
"E-mail para envio de erros na conferencia cega",;
"E-mail para envio de erros na conferencia cega",;
"E-mail para envio de erros na conferencia cega",;
.F. )

Default lJob		:= .T.
Default cDocDe		:= "  "
Default cDocAte		:= "ZZZZZZZZZ"
Default cSerie		:= "3"
Default dDtIni		:= MsDate()-30
Default dDtFin		:= MsDate()
Default cCodCliDe	:= "  "
Default cCodCliAte	:= "ZZZZZZ"
Default cLojaDe		:= " "
Default cLojaAte	:= "ZZ"
Default cFilExec	:=cFilAnt    

//MemoWrite("\Logs\RunConfCega_P.txt",cTextoLog)


If lJob
	If (cEmpAnt=="03")
	
		If Empty(dDtAux)
			Return
		EndIf
		
		If dDtAux>dDtIni
			dDtIni:=dDtAux
		EndIf
		
	EndIf
	
EndIf


cFiltroSF2:=" SF2.F2_FILIAL = '"+xFilial("SF2")+"'"
If cFilExec=="*" // Todas as Filiais
	cFiltroSF2:=" SF2.F2_FILIAL Between '    ' And 'ZZZZZ'"
EndIf


cQuery    := " SELECT DISTINCT F2_FILIAL, F2_EMISSAO, F2_DOC, F2_SERIE, F2_CLIENTE, F2_LOJA, F2_TIPO, SF2.R_E_C_N_O_ RECNOSF2, "+CRLF
cQuery    += " A1_COD, A1_LOJA, A1_NOME, A1_NREDUZ FROM "+RetSqlName("SF2")+" SF2 "+CRLF

cQuery    += " INNER JOIN "+RetSqlName("SA1")+" SA1 "+CRLF
cQuery    += " ON SA1.A1_FILIAL = '"+xFilial("SA1")+"' "+CRLF
cQuery    += " AND SA1.A1_COD  BETWEEN '"+cCodCliDe+"' AND '"+cCodCliAte+"' "+CRLF
cQuery    += " AND SA1.A1_LOJA BETWEEN '"+cLojaDe+"' AND '"+cLojaAte+"' "+CRLF
cQuery    += " AND SA1.A1_YEMPDES <> ' ' "+CRLF//Empresa destino
cQuery    += " AND SA1.A1_YFILDES <> ' ' "+CRLF//Filial destino
cQuery    += " AND SA1.D_E_L_E_T_ = ' ' "+CRLF


cQuery    += " WHERE "+cFiltroSF2+CRLF
cQuery    += " AND SF2.F2_EMISSAO BETWEEN '"+dtos(dDtIni)+"' AND '"+dtos(dDtFin)+"' "+CRLF


cQuery    += " AND SF2.F2_DOC BETWEEN '"+cDocDe+"' AND '"+cDocAte+"' "+CRLF
//cQuery    += " AND SF2.F2_DOC = '000218319' "+CRLF

cQuery    += " AND SF2.F2_SERIE = '"+cSerie+"' "+CRLF
cQuery    += " AND SF2.F2_CLIENTE =SA1.A1_COD"+CRLF
cQuery    += " AND SF2.F2_LOJA =SA1.A1_LOJA"+CRLF
cQuery    += " AND SF2.F2_TIPO = 'N' "+CRLF
cQuery    += " AND SF2.F2_CHVNFE <> ' ' "+CRLF
cQuery    += " AND SF2.D_E_L_E_T_ = ' ' "+CRLF

cQuery := ChangeQuery(cQuery)

dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)


(cArqTmp)->( DbGoTop() )
(cArqTmp)->( dbEval( { || nCnt++ },,{ || !Eof() } ) )
(cArqTmp)->( DbGoTop() )

ProcRegua(nCnt)

DbSelectArea("SF2")
DbSetOrder(1)
While (cArqTmp)->(!Eof())
	
	IncProc("Processando...")
	
	cMsgErr := ""
	SF2->(DbGoTo((cArqTmp)->RECNOSF2))
	
	aLojDest	:= {}
	aLojDest	:= GetLjDest((cArqTmp)->F2_CLIENTE, (cArqTmp)->F2_LOJA)
	
	
	//Verifica se a NF ja existe na conferencia cega / Verifica se a NF esta autorizada na SEFAZ
	If Len(aLojDest) > 0
		If VldNfCC(aLojDest[LOJADESTINO], SF2->(F2_DOC+F2_SERIE+ aLojDest[CODFORNECE] + aLojDest[LOJAFORNCE] +F2_TIPO) );
			.Or. !VldNFSefaz(SF2->F2_CHVNFE);
			.Or. !VldItemPA(SF2->F2_DOC, SF2->F2_SERIE, SF2->F2_CLIENTE, SF2->F2_LOJA)
			
			(cArqTmp)->(DbSkip());Loop
		EndIf
	Else
		(cArqTmp)->(DbSkip());Loop
	EndIf
	
	if SF2->F2_TIPO == "D"
		DbSelectArea("SA2")
		DbSetOrder(1)
		if DbSeek(xFilial("SA2")+SF2->F2_CLIENTE+SF2->F2_LOJA, .T.)		
			If SA2->A2_TIPO == "F"
				(cArqTmp)->(DbSkip());Loop
			Endif
		EndIF
	Else
		DbSelectArea("SA1")
		DbSetOrder(1)
		if DbSeek(xFilial("SA1")+SF2->F2_CLIENTE+SF2->F2_LOJA, .T.)		
			If SA1->A1_PESSOA == "F"
				(cArqTmp)->(DbSkip());Loop
			Endif
		EndIF
	EndIF

	//Realiza a valida��o dos dados antes de enviar para conferencia cega
	If VldConfCega(SF2->F2_DOC, SF2->F2_SERIE, SF2->F2_CLIENTE, SF2->F2_LOJA, @cMsgErr)
		
		cMsgErr := ""
		
		//Envia a nota fiscal para conferencia cega
		GrvConfCega(SF2->F2_DOC, SF2->F2_SERIE, aLojDest[CODFORNECE], aLojDest[LOJAFORNCE], @cMsgErr)
		
		//Verificar se houve erro na conferencia cega
		If !Empty(cMsgErr)
			If lJob
				//Envia o Arquivo por e-mail
				NCEnvEmail(cAssunto+" NF - "+SF2->F2_DOC +"/"+ SF2->F2_SERIE,;//Assunto
				"Erro ao enviar a NF"+SF2->F2_DOC +"/"+ SF2->F2_SERIE+" para a conferencia cega. "+CRLF+CRLF+cMsgErr,;//Mensagem
				{},;//Anexo
				Alltrim(cEmailPara),;//E-mail do destinatario
				"",;//C�pia do e-mail
				"")
			Else
				Aviso("Erro","Erro ao enviar a NF"+SF2->F2_DOC +"/"+ SF2->F2_SERIE+" para a conferencia cega. "+CRLF+CRLF+cMsgErr, {"Ok"},3)
			EndIf
			
			//Grava Log
			GrvLogProc(SF2->F2_DOC,;					//Doc
			SF2->F2_SERIE,;            //Serie
			SF2->F2_CLIENTE,;			//Cliente
			SF2->F2_LOJA,;				//Loja
			aLojDest[LOJADESTINO],;	//Codigo da Loja WM
			aLojDest[EMPDESTINO],;     //Empresa Destino
			aLojDest[FILDESTINO],;		//Filial Destino
			SF2->F2_CHVNFE,;			//Chave NFE
			Iif(lJob, "JOB", UsrRetName(RetCodUsr())),;//Usuario
			"2",;						//Status (1=Enviado, 2=Pendente)
			cMsgErr)					//Observa��o
			
			
		Else //Sen�o ocorreu erro na conferencia cega, grava os dados na tabela de log e tenta gravar o pr�documento de entrada
			
			//Grava Log
			GrvLogProc(SF2->F2_DOC,;					//Doc
			SF2->F2_SERIE,;            //Serie
			SF2->F2_CLIENTE,;			//Cliente
			SF2->F2_LOJA,;				//Loja
			aLojDest[LOJADESTINO],;	//Codigo da Loja WM
			aLojDest[EMPDESTINO],;     //Empresa Destino
			aLojDest[FILDESTINO],;		//Filial Destino
			SF2->F2_CHVNFE,;			//Chave NFE
			Iif(lJob, "JOB", UsrRetName(RetCodUsr())),;//Usuario
			"1",;						//Status (1=Enviado, 2=Pendente)
			cMsgErr)					//Observa��o
			
			//Gera o pre-nota de entrada
			cMsgErr := u_NCGPR131()
			
			//Verifica se houve erro ao gerar a pre-nota de entrada
			If !Empty(cMsgErr)
				If lJob
					
					cAssunto := "Erro ao gerar pr�-documento de entrada - Confer�ncia Cega "
					
					//Envia o Arquivo por e-mail
					NCEnvEmail(cAssunto+" NF - "+SF2->F2_DOC +"/"+ SF2->F2_SERIE,;//Assunto
					"Erro ao gerar pr�-documento de entrada "+SF2->F2_DOC +"/"+ SF2->F2_SERIE+". "+CRLF+CRLF+cMsgErr,;//Mensagem
					{},;//Anexo
					Alltrim(cEmailPara),;//E-mail do destinatario
					"",;//C�pia do e-mail
					"")
				Else
					Aviso("Erro","Erro ao gerar o Pr�-documento de entrada "+SF2->F2_DOC +"/"+ SF2->F2_SERIE+". "+CRLF+CRLF+cMsgErr, {"Ok"},3)
				EndIf
			EndIf
			
		EndIf
	Else
		If lJob
			//Envia o Arquivo por e-mail
			NCEnvEmail(cAssunto+" NF - "+SF2->F2_DOC +"/"+ SF2->F2_SERIE,;//Assunto
			"Erro ao enviar a NF"+SF2->F2_DOC +"/"+ SF2->F2_SERIE+" para a conferencia cega. "+CRLF+CRLF+cMsgErr,;//Mensagem
			{},;//Anexo
			Alltrim(cEmailPara),;//E-mail do destinatario
			"",;//C�pia do e-mail
			"")
		Else
			Aviso("Erro","Erro ao enviar a NF"+SF2->F2_DOC +"/"+ SF2->F2_SERIE+" para a conferencia cega. "+CRLF+CRLF+cMsgErr, {"Ok"},3)
		EndIf
		
		
		//Grava Log
		GrvLogProc(SF2->F2_DOC,;						//Doc
		SF2->F2_SERIE,;            //Serie
		SF2->F2_CLIENTE,;			//Cliente
		SF2->F2_LOJA,;				//Loja
		aLojDest[LOJADESTINO],;	//Codigo da Loja WM
		aLojDest[EMPDESTINO],;     //Empresa Destino
		aLojDest[FILDESTINO],;		//Filial Destino
		SF2->F2_CHVNFE,;			//Chave NFE
		Iif(lJob, "JOB", UsrRetName(RetCodUsr())),;//Usuario
		"2",;						//Status (1=Enviado, 2=Pendente)
		cMsgErr)					//Observa��o
		
	EndiF
	
	(cArqTmp)->(DbSkip())
EndDo

(cArqTmp)->(DbCloseArea())

RestArea(aArea)
Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �VldConfCega  �Autor  �Microsiga        � Data �  01/17/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �Valida��o da conferencia cega                               ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function VldConfCega(cDoc, cSerie, cCodCli, cLoja, cMsgAux)

Local aArea 		:= GetArea()
Local cQuery    	:= ""
Local cArqTmp		:= GetNextAlias()
Local lRet			:= .T.
Local aLojDest		:= {}
Local cCfopPerm		:= Alltrim(U_MyNewSX6("NC_NCINT01","1102*1403*1910*2102*2403*2910","C","CFOPS que ser�o enviadas WM.","","",.F. ))
Local cCategCons	:= Alltrim(U_MyNewSX6("NC_CONSNWM","98*9888","C","Subcategorias de produtos que n�o ser�o enviados para o WM","","",.F. ))

Default cDoc	:= ""
Default cSerie	:= ""
Default cCodCli	:= ""
Default cLoja 	:= ""
Default cMsgAux	:= ""

cQuery    := " SELECT * FROM "+RetSqlName("SD2")+" SD2 "
cQuery    += " WHERE SD2.D2_FILIAL = '"+xFilial("SD2")+"' "
cQuery    += " AND SD2.D2_DOC = '"+cDoc+"' "
cQuery    += " AND SD2.D2_SERIE = '"+cSerie+"' "
cQuery    += " AND SD2.D2_CLIENTE = '"+cCodCli+"' "
cQuery    += " AND SD2.D2_LOJA = '"+cLoja+"' "
cQuery    += " AND SD2.D_E_L_E_T_ = ' ' "

dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)

While (cArqTmp)->(!Eof())
	
	If !(cArqTmp)->D2_TP=="PA" .Or. AvalTes((cArqTmp)->D2_TES,"N") .Or. !AllTrim(GetCfDes((cArqTmp)->D2_CF)) $ cCfopPerm
		(cArqTmp)->(DbSkip());Loop
	EndIf
	
	
	DbSelectArea("SB1")
	DbSetOrder(1)
	If SB1->(DbSeek(xFilial("SB1") + (cArqTmp)->D2_COD))
		If Alltrim(SB1->B1_SBCATEG) $ Alltrim(cCategCons)
			(cArqTmp)->(DbSkip());Loop
		EndIf
	Else
		cMsgAux += "Produto n�o encontrado: "+(cArqTmp)->D2_COD+CRLF
		lRet 	:= .F.
	EndIf
	
	If Empty(GetCliPrd((cArqTmp)->D2_COD))
		cMsgAux += "N�o existe amarra��o no cadastro de Produto x Prod.Cliente (SA7): "+(cArqTmp)->D2_COD+CRLF
		lRet 	:= .F.
	EndIf
	
	aLojDest	:= {}
	aLojDest	:= GetLjDest((cArqTmp)->D2_CLIENTE, (cArqTmp)->D2_LOJA)
	If Len(aLojDest) <= 0
		cMsgAux += "Loja n�o cadastrada na tabela de/para (ZX5 tabela 00009). Entre em contato com administrador. Cliente: "+(cArqTmp)->D2_CLIENTE+"/"+(cArqTmp)->D2_LOJA+CRLF
		lRet 	:= .F.
	EndIf
	
	(cArqTmp)->(DbSkip())
EndDo

(cArqTmp)->(DbCloseArea())
RestArea(aArea)
Return lRet


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �VldItemPA		�Autor  �Microsiga       � Data �  01/17/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �Verifica se existe item apto a fatura                       ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function VldItemPA(cDoc, cSerie, cCodCli, cLoja)

Local aArea 	:= GetArea()
Local cQuery    := ""
Local cArqTmp	:= GetNextAlias()
Local lRet		:= .F.
Local aLojDest	:= {}
Local cCfopPerm	:= Alltrim(U_MyNewSX6("NC_NCINT01","1102*1403*1910*2102*2403*2910","C","CFOPS que ser�o enviadas WM.","","",.F. ))
Local cCategCons	:= Alltrim(U_MyNewSX6("NC_CONSNWM","98*9888","C","Subcategorias de produtos que n�o ser�o enviados para o WM","","",.F. ))

Default cDoc	:= ""
Default cSerie	:= ""
Default cCodCli	:= ""
Default cLoja 	:= ""

cQuery    := " SELECT D2_COD,D2_TP,D2_TES,D2_CF 
cQuery    += " FROM "+RetSqlName("SD2")+" SD2 "
cQuery    += " WHERE SD2.D2_FILIAL = '"+xFilial("SD2")+"' "
cQuery    += " AND SD2.D2_DOC = '"+cDoc+"' "
cQuery    += " AND SD2.D2_SERIE = '"+cSerie+"' "
cQuery    += " AND SD2.D2_CLIENTE = '"+cCodCli+"' "
cQuery    += " AND SD2.D2_LOJA = '"+cLoja+"' "
cQuery    += " AND SD2.D_E_L_E_T_ = ' ' "

dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)

DbSelectArea("SB1")
DbSetOrder(1)

While (cArqTmp)->(!Eof())
	
	If SB1->(DbSeek(xFilial("SB1") + (cArqTmp)->D2_COD))
		If Alltrim(SB1->B1_SBCATEG) $ Alltrim(cCategCons)
			(cArqTmp)->(DbSkip());Loop
		EndIf
	EndIf
	
	If !(cArqTmp)->D2_TP=="PA" .Or. AvalTes((cArqTmp)->D2_TES,"N") .Or. !AllTrim(GetCfDes((cArqTmp)->D2_CF)) $ cCfopPerm
		lRet := .F.
		(cArqTmp)->(DbSkip());Loop
	Else
		lRet := .T.
		Exit
	EndIf
	
	(cArqTmp)->(DbSkip())
EndDo

(cArqTmp)->(DbCloseArea())
RestArea(aArea)
Return lRet



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �VldProd  �Autor  �Microsiga           � Data �  01/17/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �Verifica se o produto existe                                ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function VldProd(cCodProd)

Local aArea := GetArea()
Local lRet	:= .F.

Default cCodProd := ""

If !Empty(cCodProd)
	DbSelectArea("SB1")
	DbSetOrder(1)
	If SB1->(DbSeek(xFilial("SB1") + cCodProd))
		lRet	:= .T.
	Else
		lRet	:= .F.
	EndIf
Else
	lRet	:= .F.
EndIf

RestArea(aArea)
Return lRet


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �GetCliPrd  �Autor  �Microsiga         � Data �  01/17/15    ���
�������������������������������������������������������������������������͹��
���Desc.     �Retorna o codigo do produto no cliente 					  ���
���          � amarra��odo no SA7 (Cliente x Produto)                     ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function GetCliPrd(cCodProd)

Local aArea 	:= GetArea()
Local cCodRet   := ""
Local cCodCli	:= Alltrim(U_MyNewSX6("NC_NCG130C","000000"	,"C","Cliente utilizado na amarra��o do SA7","","",.F. ))
Local cLojaCli	:= Alltrim(U_MyNewSX6("NC_NCG130L","01"		,"C","Loja do cliente utilizado na amarra��o do SA7","","",.F. ))

Default cCodCli		:= ""
Default cLojaCli	:= ""
Default cCodProd	:= ""

If cEmpAnt<>"01"
	cCodRet:=cCodProd	
Else
	If !Empty(cCodProd)
		DbSelectArea("SA7")
		DbSetOrder(1)//A7_FILIAL+A7_CLIENTE+A7_LOJA+A7_PRODUTO
		If SA7->(DbSeek(xFilial("SA7") + cCodCli + cLojaCli + cCodProd ))
			cCodRet := SA7->A7_CODCLI
		Else
			cCodRet := ""
		EndIf
	Else
		cCodRet := ""
	EndIf
EndIf
RestArea(aArea)
Return cCodRet


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �GetLjDest  �Autor  �Microsiga         � Data �  01/17/15    ���
�������������������������������������������������������������������������͹��
���Desc.     �Retorna a loja de destino da conferencia cega			  ���
���          � amarra��odo no SA7 (Cliente x Produto)                     ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function GetLjDest(cCodCli, cLoja)

Local aArea 	:= GetArea()
Local aRet		:= {}
Local cArqTmp	:= GetNextAlias()
Local cTabZX5	:= Alltrim(U_MyNewSX6("NC_CGTBZX5","00009"		,"C","Tabela de De/Para Conferencia Cega ZX5","","",.F. ))
Local cQuery	:= ""

Default cCodCli	:= ""
Default cLoja	:= ""

cQuery	:= " SELECT ZX5_DESCRI FROM "+RetSqlname("ZX5")+CRLF
cQuery	+= " WHERE ZX5_FILIAL= '"+xFilial("ZX5")+"' "+CRLF
cQuery	+= " AND ZX5_TABELA = '"+cTabZX5+"' "+CRLF
cQuery	+= " AND ZX5_DESCRI LIKE '%"+cCodCli+";"+cLoja+"%' "+CRLF
cQuery	+= " AND D_E_L_E_T_ = ' ' "+CRLF

dbUseArea( .T., 'TOPCONN', TCGENQRY(,,cQuery), cArqTmp , .F., .T.)

If (cArqTmp)->(!Eof())
	aRet := SEPARA((cArqTmp)->ZX5_DESCRI, ";")
EndIf

(cArqTmp)->(DbCloseArea())
RestArea(aArea)
Return aRet

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �GetCfDes  �Autor  �Microsiga         � Data �  01/17/15     ���
�������������������������������������������������������������������������͹��
���Desc.     �Retorna o CFOP a ser utilizado na conferencia cega		  ���
���          �										                      ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function GetCfDes(cCfOrig)

Local aArea 	:= GetArea()
Local cCfRet    := ""
Local cTbZX5	:= "00010"

Default cCfOrig := ""

DbSelectArea("ZX5")
DbSetOrdeR(1)
If ZX5->(DbSeek(xFilial("ZX5");
	+PADR(cTbZX5,TAMSX3("ZX5_TABELA")[1]);
	+PADR(cCfOrig,TAMSX3("ZX5_CHAVE")[1]);
	))
	cCfRet := Alltrim(ZX5->ZX5_DESCRI)
	
EndIf

Return cCfRet

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �VldNfCC  �Autor  �Microsiga         � Data �  01/17/15	  ���
�������������������������������������������������������������������������͹��
���Desc.     �Verifica se a NF ja foi enviada para conferencia cega		  ���
���          �											                  ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function VldNfCC(cLojaWM, cCodRef)

Local aArea 	:= GetArea()
Local lRet		:= .F.
Local cQuery	:= ""
Local cArqTmp	:= ""

Default cLojaWM	:= ""
Default cCodRef	:= ""

cQuery	:=" Select Count(*) Contar From "+U_NCGetBWM("Conferencia_cega")
cQuery	+=" Where Cod_referencia='"+cCodRef+"'"
cQuery	+=" And Cod_loja_WM = '"+cLojaWM+"' "

cArqTmp :=U_NCIWMF02(cQuery,"1")

If Select(cArqTmp) > 0
	lRet := ((cArqTmp)->Contar > 0)
	
	(cArqTmp)->(DbCloseArea())
Else
	lRet := .F.
EndIf

RestArea(aArea)
Return lRet

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �GrvConfCega  �Autor  �Microsiga        � Data �  01/17/15	  ���
�������������������������������������������������������������������������͹��
���Desc.     �Grava Conferencia Cega									  ���
���          �											                  ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function GrvConfCega(cDoc, cSerie, cCodFornece, cLoja, cMensagem)

Local aAreaAtu	:= GetArea()
Local nInd		:= 0
Local cScript	:= ""
Local cMensagem	:= ""
Local cQuery	:= ""
Local nCodConf	:= 0
Local cCodRef	:= SF2->(F2_DOC + F2_SERIE + cCodFornece + cLoja + F2_TIPO)
Local aDadosCG	:= {}
Local aProdutos	:= {}
Local cCfopPerm	:= Alltrim(U_MyNewSX6("NC_NCINT01","1102*1403*1910*2102*2403*2910","C","CFOPS que ser�o enviadas WM.","","",.F. ))
Local cCategCons := Alltrim(U_MyNewSX6("NC_CONSNWM","98*9888","C","Subcategorias de produtos que n�o ser�o enviados para o WM","","",.F. ))
Local nTotUnit	:= 0
Local nAscan	:= 0
Local cCfopAux	:= ""
Local cLjSemConf:=Alltrim(U_MyNewSX6("NCG_000112","3001/3009","C","lOJAS SEM CONF. CEGA","","",.F. ))
Default cDoc		:= ""
Default cSerie		:= ""
Default cCodFornece	:= ""
Default cLoja		:= ""
Default cMensagem	:= ""

DbSelectArea("SB1")
DbSetOrder(1)

//Dados complementares da conferencia cega
aDadosCG := GetLjDest(SF2->F2_CLIENTE, SF2->F2_LOJA)

If aDadosCG[LOJADESTINO] $ cLjSemConf
	RestArea(aAreaAtu)
	Return
EndIf

SD2->(DbSetOrder(3))
If SD2->(MsSeek(xFilial("SD2")+SF2->(F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA) ))
	
	cScript	:="INSERT INTO "+u_NCGetBWM("Conferencia_cega")+CRLF
	cScript	+="("+CRLF
	cScript	+=" [Cod_referencia]"+CRLF
	cScript	+=",[CNPJ_fornecedor]"+CRLF
	cScript	+=",[Cod_loja_WM]"+CRLF
	cScript	+=",[CNPJ_loja]"+CRLF
	cScript	+=",[Data_nota]"+CRLF
	cScript	+=",[Numero_nota]"+CRLF
	cScript	+=",[Total]"+CRLF
	cScript	+=",[Estado]"+CRLF
	cScript	+=",[Valor_IPI]"+CRLF
	cScript	+=",[Base_ICMS]"+CRLF
	cScript	+=",[Valor_ICMS]"+CRLF
	cScript	+=",[Base_ICMS_ST]"+CRLF
	cScript	+=",[Valor_ICMS_ST]"+CRLF
	cScript	+=",[CST_origem]"+CRLF
	cScript	+=",[CFOP]"+CRLF
	cScript	+=",[Data_cadastrou]"+CRLF
	cScript	+=")"+CRLF
	
	cScript	+="VALUES"+CRLF
	
	cScript	+="("+CRLF
	
	cScript	+="'"+cCodRef+"'"
	cScript	+=",'"+TransForm(Posicione("SA2",1,xFilial("SA2")+aDadosCG[CODFORNECE]+aDadosCG[LOJAFORNCE],"A2_CGC" ),'@R 99.999.999/9999-99')+"'"
	cScript	+=",'"+aDadosCG[LOJADESTINO]+"'"
	cScript	+=",'"+TransForm(Posicione("SA1",1,xFilial("SA1") + SF2->F2_CLIENTE + SF2->F2_LOJA,"A1_CGC" ),'@R 99.999.999/9999-99')+"'"
	cScript	+=","+INT001Trans(SF2->F2_EMISSAO,"D")
	cScript	+=","+SF2->F2_DOC
	cScript	+=","+INT001Trans(SF2->F2_VALBRUT,"N")
	cScript	+=","+"0"
	cScript	+=","+INT001Trans(SF2->F2_VALIPI,"N")
	cScript	+=","+INT001Trans(SF2->F2_BASEICM,"N")
	cScript	+=","+INT001Trans(SF2->F2_VALICM,"N")
	cScript	+=","+INT001Trans(SF2->F2_BRICMS,"N")
	cScript	+=","+INT001Trans(SF2->F2_ICMSRET,"N")
	cScript	+=",'"+SubStr(SD2->D2_CLASFIS,2,1)+"'"
	
	cCfopAux := GetCfDes(SD2->D2_CF)
	
	//Verificar
	cScript	+=",'"+cCfopAux+"'"
	cScript	+=","+INT001Trans(MsDate(),"D")
	cScript	+=")"+CRLF
	
	U_NCIWMF02(cScript,"2",@cMensagem)
	
	cQuery	:=" Select Cod_conferencia From "+U_NCGetBWM("Conferencia_cega")
	cQuery	+=" Where Cod_referencia='"+cCodRef+"'"
	cAliasQry:=U_NCIWMF02(cQuery,"1",@cMensagem)
	
	If Select(cAliasQry)>0
		nCodConf:=(cAliasQry)->Cod_conferencia
		(cAliasQry)->(DbCloseArea())
	EndIf
	
	
	If nCodConf > 0
		
		//Preenchimento dos itens
		While SD2->D2_FILIAL == SF2->F2_FILIAL;
			.And. SD2->D2_DOC == SF2->F2_DOC;
			.And. SD2->D2_SERIE == SF2->F2_SERIE;
			.And. SD2->D2_CLIENTE == SF2->F2_CLIENTE;
			.And. SD2->D2_LOJA == SF2->F2_LOJA
			
			//Verifica se o material � de consumo
			If SB1->(DbSeek(xFilial("SB1") + SD2->D2_COD))
				If Alltrim(SB1->B1_SBCATEG) $ Alltrim(cCategCons)
					SD2->(DbSkip());Loop
				EndIf
			EndIf
			
			If !SD2->D2_TP=="PA" .Or. AvalTes(SD2->D2_TES,"N") .Or. !AllTrim(GetCfDes(SD2->D2_CF)) $ cCfopPerm
				SD2->(DbSkip());Loop
			EndIf
			
			nTotUnit := SD2->((D2_TOTAL+D2_VALIPI+D2_ICMSRET+D2_VALFRE+D2_SEGURO+D2_DESPESA)/D2_QUANT)
			
			//Verifica se o produto ja foi utilizado para n�o haver duplicidade
			If (nAscan:=Ascan(aProdutos,{|a|a[1] == AllTrim(GetCliPrd(SD2->D2_COD))  }  )) != 0
				aProdutos[nAscan,2]	+= SD2->D2_QUANT
				aProdutos[nAscan,3]	+= nTotUnit
				aProdutos[nAscan,4]	+= SD2->D2_PICM
				
			ElseIf(nAscan:=Ascan(aProdutos,{|a|a[1]==AllTrim(GetCliPrd(SD2->D2_COD))  .And. a[4]==SD2->D2_PICM }  ))==0
				AADD(aProdutos,{AllTrim(GetCliPrd(SD2->D2_COD)), SD2->D2_QUANT,nTotUnit,SD2->D2_PICM,SD2->D2_PRCVEN, SD2->D2_COD} )
			Else
				aProdutos[nAscan,2]	+=SD2->D2_QUANT
				aProdutos[nAscan,3]	+=nTotUnit
			EndIF
			
			SD2->(DbSkip())
		EndDo
		
		
		For nInd:=1 To Len(aProdutos)
			cScript	:=	"INSERT INTO "+u_NCGetBWM("Conferencia_cega_item")+CRLF
			cScript	+=	"("+CRLF
			cScript	+=	"[Cod_conferencia]"+CRLF
			cScript	+=	",[Cod_produto_WM]"+CRLF
			cScript	+=	",[Quantidade_original]"+CRLF
			cScript	+=	",[Quantidade]"+CRLF
			cScript	+=	",[Qtde_aux1]"+CRLF
			cScript	+=	",[Qtde_aux2]"+CRLF
			cScript	+=	",[Qtde_aux3]"+CRLF
			cScript	+=	",[Valor]"+CRLF
			cScript	+=	",[ICMS]"+CRLF
			cScript	+=	",[NCM]"+CRLF
			cScript	+=	",[Data_cadastrou]"+CRLF
			cScript	+=	")"+CRLF
			
			cScript	+=	"VALUES"+CRLF
			cScript	+=	"("+CRLF
			
			cScript	+=	""+AllTrim(Str(nCodConf))
			cScript	+=	","+AllTrim(aProdutos[nInd,1])
			cScript	+=	","+INT001Trans(aProdutos[nInd,2],"N")
			cScript	+=	",0"
			cScript	+=	",0"
			cScript	+=	",0"
			cScript	+=	",0"
			cScript	+=	","+INT001Trans(aProdutos[nInd,3],"N")
			cScript	+=	","+INT001Trans(aProdutos[nInd,4],"N")
			cScript	+=	",'"+AllTrim(Posicione("SB1",1,xFilial("SB1")+aProdutos[nInd,6],"B1_POSIPI"))+"'"
			cScript	+=	","+INT001Trans(MsDate(),"D")
			
			cScript	+=	")"+CRLF
			
			U_NCIWMF02(cScript,"2",@cMensagem)
			
		Next
		
	EndIf
	
EndIf

RestArea(aAreaAtu)
Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGINT001 �Autor  �Microsiga           � Data �  06/20/15   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function INT001Trans(xDado,cTipo)
Local xRetorno

If cTipo=="D"
	xRetorno:="CAST(N'"+StrZero(Year(xDado),4)+"-"+StrZero(Month(xDado),2)+"-"+StrZero(Day(xDado),2)+" 00:00:00.000' AS DateTime)"
ElseIf cTipo=="N"
	xRetorno:=AllTrim(Str(Round(xDado,2)))
EndIf



Return xRetorno


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
Default cEmailCc	:= ""

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
���Programa  �VldNFSefaz  �Autor  �Microsiga      � Data �  01/30/14     ���
�������������������������������������������������������������������������͹��
���Desc.     �Valida��o do status da nota fiscal na SEFAZ                 ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function VldNFSefaz(cChvNFE)

Local aArea 	:= GetArea()
Local lRet		:= .T.
Local cIdEnt	:= RetIdEnti()//GetIdEnt()
Local cRetSefaz	:= ""
Local aVldSts	:= {}
Local nX		:= 0
Local lVldSefaz	:= U_MyNewSX6("NC_VLDSEFA",".T.","L","Valida��o do status da NF no sefaz","","",.F. )

Default cChvNFE := ""

If lVldSefaz
	
	If !Empty(cChvNFE)
		
		//Consulta a nota fiscal na SEFAZ
		cRetSefaz	:= ConsNFeChave(cChvNFE,cIdEnt)
		
		//Verifica se a NF foi autorizada
		If !Empty(cRetSefaz)
			aVldSts		:= Separa(cRetSefaz, " ")
			
			For nX := 1 To Len(aVldSts)
				If UPPER(Alltrim(aVldSts[nX])) == "AUTORIZADO"
					lRet := .T.
					Exit
				EndIf
			Next
			
		Else
			lRet := .F.
		EndIf
	Else
		lRet := .F.
	EndIf
	
Else
	lRet := .T.
EndIf

RestArea(aArea)
Return lRet



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �GetIdEnt  �Autor  �Microsiga         � Data �  01/30/14     ���
�������������������������������������������������������������������������͹��
���Desc.     �Retorna o idEnt da empresa, utilizado no TSS                ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function GetIdEnt()

Local aArea  := GetArea()
Local cIdEnt := ""
Local cURL   := PadR(GetNewPar("MV_SPEDURL","http://"),250)
Local oWs
Local lUsaGesEmp := IIF(FindFunction("FWFilialName") .And. FindFunction("FWSizeFilial") .And. FWSizeFilial() > 2,.T.,.F.)
Local lEnvCodEmp := GetNewPar("MV_ENVCDGE",.F.)

//������������������������������������������������������������������������Ŀ
//�Obtem o codigo da entidade                                              �
//��������������������������������������������������������������������������
oWS := WsSPEDAdm():New()
oWS:cUSERTOKEN := "TOTVS"

oWS:oWSEMPRESA:cCNPJ       := IIF(SM0->M0_TPINSC==2 .Or. Empty(SM0->M0_TPINSC),SM0->M0_CGC,"")
oWS:oWSEMPRESA:cCPF        := IIF(SM0->M0_TPINSC==3,SM0->M0_CGC,"")
oWS:oWSEMPRESA:cIE         := SM0->M0_INSC
oWS:oWSEMPRESA:cIM         := SM0->M0_INSCM
oWS:oWSEMPRESA:cNOME       := SM0->M0_NOMECOM
oWS:oWSEMPRESA:cFANTASIA   := IIF(lUsaGesEmp,FWFilialName(),Alltrim(SM0->M0_NOME))
oWS:oWSEMPRESA:cENDERECO   := FisGetEnd(SM0->M0_ENDENT)[1]
oWS:oWSEMPRESA:cNUM        := FisGetEnd(SM0->M0_ENDENT)[3]
oWS:oWSEMPRESA:cCOMPL      := FisGetEnd(SM0->M0_ENDENT)[4]
oWS:oWSEMPRESA:cUF         := SM0->M0_ESTENT
oWS:oWSEMPRESA:cCEP        := SM0->M0_CEPENT
oWS:oWSEMPRESA:cCOD_MUN    := SM0->M0_CODMUN
oWS:oWSEMPRESA:cCOD_PAIS   := "1058"
oWS:oWSEMPRESA:cBAIRRO     := SM0->M0_BAIRENT
oWS:oWSEMPRESA:cMUN        := SM0->M0_CIDENT
oWS:oWSEMPRESA:cCEP_CP     := Nil
oWS:oWSEMPRESA:cCP         := Nil
oWS:oWSEMPRESA:cDDD        := Str(FisGetTel(SM0->M0_TEL)[2],3)
oWS:oWSEMPRESA:cFONE       := AllTrim(Str(FisGetTel(SM0->M0_TEL)[3],15))
oWS:oWSEMPRESA:cFAX        := AllTrim(Str(FisGetTel(SM0->M0_FAX)[3],15))
oWS:oWSEMPRESA:cEMAIL      := UsrRetMail(RetCodUsr())
oWS:oWSEMPRESA:cNIRE       := SM0->M0_NIRE
oWS:oWSEMPRESA:dDTRE       := SM0->M0_DTRE
oWS:oWSEMPRESA:cNIT        := IIF(SM0->M0_TPINSC==1,SM0->M0_CGC,"")
oWS:oWSEMPRESA:cINDSITESP  := ""
oWS:oWSEMPRESA:cID_MATRIZ  := ""

If lUsaGesEmp .And. lEnvCodEmp
	oWS:oWSEMPRESA:CIDEMPRESA:= FwGrpCompany()+FwCodFil()
EndIf

oWS:oWSOUTRASINSCRICOES:oWSInscricao := SPEDADM_ARRAYOFSPED_GENERICSTRUCT():New()
oWS:_URL := AllTrim(cURL)+"/SPEDADM.apw"
If oWs:ADMEMPRESAS()
	cIdEnt  := oWs:cADMEMPRESASRESULT
Else
	cIdEnt  := ""
EndIf

RestArea(aArea)
Return(cIdEnt)

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �ConsNFeChave  �Autor  �Microsiga     � Data �  01/30/14     ���
�������������������������������������������������������������������������͹��
���Desc.     �Consulta o status da NF na SEFAZ				              ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function ConsNFeChave(cChaveNFe,cIdEnt)

Local cURL     := PadR(GetNewPar("MV_SPEDURL","http://"),250)
Local cMensagem:= ""
Local oWS

oWs:= WsNFeSBra():New()
oWs:cUserToken   := "TOTVS"
oWs:cID_ENT    	 := cIdEnt
ows:cCHVNFE		 := cChaveNFe
oWs:_URL         := AllTrim(cURL)+"/NFeSBRA.apw"

If oWs:ConsultaChaveNFE()
	cMensagem := ""
	cMensagem += Alltrim("  Protocolo : "+oWs:oWSCONSULTACHAVENFERESULT:cPROTOCOLO )
	cMensagem += Alltrim("  Msg.Ret.NFe: "+oWs:oWSCONSULTACHAVENFERESULT:cMSGRETNFE)
Else
	cMensagem := ""
EndIf

Return cMensagem



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCVlExCC  �Autor  �Microsiga         � Data �  01/17/15	  ���
�������������������������������������������������������������������������͹��
���Desc.     �Valida��o da exclus�o de NF da conferencia cega			  ���
���          �											                  ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function NCVlExCC(cDoc, cSerie, cTipo, cCodCli, cLoja)

Local aArea 	:= GetArea()
Local lRet		:= .F.
Local cQuery	:= ""
Local cArqTmp	:= ""
Local cMensagem	:= ""
Local aLojDest	:= {}
Local cCodRef	:= ""

Default cDoc	:= ""
Default cSerie	:= ""
Default cTipo	:= ""
Default cCodCli	:= ""
Default cLoja	:= ""


DbSelectArea("SA1")
DbSetOrder(1)
If SA1->(DbSeek(xFilial("SA1") + cCodCli + cLoja ))
	If !Empty(SA1->A1_YFILDES)
		
		//Verifica se existe de/para da loja
		aLojDest	:= {}
		aLojDest	:= GetLjDest(cCodCli, cLoja)
		
		If Len(aLojDest) > 0
			
			//Chave para pesquisa no Web Manager
			cCodRef := cDoc + cSerie + aLojDest[CODFORNECE] + aLojDest[LOJAFORNCE] + cTipo
			
			cQuery	:=" Select Cod_conferencia, Estado From "+U_NCGetBWM("Conferencia_cega")
			cQuery	+=" Where Cod_referencia='"+cCodRef+"'"
			cQuery	+=" And Cod_loja_WM = '"+aLojDest[LOJADESTINO]+"' "
		Else
			Return .T.
		EndIf
		
		//Executa a query na base de dados do Web Manager
		cArqTmp :=U_NCIWMF02(cQuery,"1")
		
		//Verifica o status da conferencia cega
		If Select(cArqTmp) > 0
			
			If (cArqTmp)->(!Eof()) .And. (cArqTmp)->Estado != 0
				
				If (cArqTmp)->Estado == 1
					cMensagem	:="Processo de confer�ncia cega em andamento, nota fiscal n�o pode ser exclu�da! Entrar em contato com a Loja."
				ElseIf (cArqTmp)->Estado == 2
					cMensagem	:="Processo de confer�ncia cega concluido, nota fiscal n�o pode ser exclu�da! Entrar em contato com a Loja."
				Else
					cMensagem	:="Nota Fiscal em fase de conferencia."
				EndIf
				
				If !IsBlind()
					Aviso("Aten��o",cMensagem, {"Ok"},3)
				EndIf
			Else
				lRet := .T.
			EndIf
			
			
			(cArqTmp)->(DbCloseArea())
		Else
			lRet := .T.
		EndIf
	Else
		lRet := .T.
	EndIf
Else
	lRet := .T.
EndIf

RestArea(aArea)
Return lRet




/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �GrvLogProc  �Autor  �Microsiga         � Data �  01/17/15	  ���
�������������������������������������������������������������������������͹��
���Desc.     �Grava o log de processamento								  ���
���          �											                  ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function GrvLogProc(cDoc, cSerie, cCodCli, cLojaCli, cCodLj, cEmpDest, cFilDest, cChaveNfe, cUser, cStatus, cObs)

Local aArea := GetArea()

Default cDoc		:= ""
Default cSerie		:= ""
Default cCodCli		:= ""
Default cLojaCli	:= ""
Default cCodLj		:= ""
Default cEmpDest	:= ""
Default cFilDest	:= ""
Default cChaveNfe	:= ""
Default cUser		:= ""
Default cStatus		:= ""
Default cObs		:= ""

DbSelectArea("P0H")
DbSetOrder(1)

If P0H->(DbSeek(xFilial("P0H")+cDoc+ cSerie+ cCodCli+ cLojaCli  ))
	RecLock("P0H", .F.)
	P0H->P0H_FILIAL	:= xFilial("P0H")
	P0H->P0H_DOC    := cDoc
	P0H->P0H_SERIE  := cSerie
	P0H->P0H_CLIENT := cCodCli
	P0H->P0H_LOJA   := cLojaCli
	P0H->P0H_LOJAWM := cCodLj
	P0H->P0H_EMPDES := cEmpDest
	P0H->P0H_FILDES := cFilDest
	P0H->P0H_CHVWM  := cChaveNfe
	P0H->P0H_EMISSA := MsDate()
	P0H->P0H_USRENV := cUser
	P0H->P0H_HORA   := Time()
	P0H->P0H_STATUS := cStatus
	P0H->P0H_OBS    := cObs
	P0H->(MsUnLock())
Else
	RecLock("P0H", .T.)
	P0H->P0H_FILIAL	:= xFilial("P0H")
	P0H->P0H_DOC    := cDoc
	P0H->P0H_SERIE  := cSerie
	P0H->P0H_CLIENT := cCodCli
	P0H->P0H_LOJA   := cLojaCli
	P0H->P0H_LOJAWM := cCodLj
	P0H->P0H_EMPDES := cEmpDest
	P0H->P0H_FILDES := cFilDest
	P0H->P0H_CHVWM  := cChaveNfe
	P0H->P0H_EMISSA := MsDate()
	P0H->P0H_USRENV := cUser
	P0H->P0H_HORA   := Time()
	P0H->P0H_STATUS := cStatus
	P0H->P0H_OBS    := cObs
	P0H->(MsUnLock())
EndIf

RestArea(aArea)
Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGPR130  �Autor  �Microsiga           � Data �  03/24/17   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function PergImp(cPerg)

PutSx1(cPerg,"01","Filial De " ,"","","MV_CH1","C",2,0,0,"G","                                                            ","      ","   "," ","MV_PAR01","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")
PutSx1(cPerg,"02","Filial Ate ","","","MV_CH1","C",2,0,0,"G","                                                            ","      ","   "," ","MV_PAR02","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")

PutSx1(cPerg,"03","Periodo De" ,"","","MV_CH1","D",8,0,0,"G","                                                            ","      ","   "," ","MV_PAR03","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")
PutSx1(cPerg,"04","Periodo Ate","","","MV_CH2","D",8,0,0,"G","                                                            ","      ","   "," ","MV_PAR04","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")

PutSx1(cPerg,"05","Nota Fiscal De","","","MV_CH5","C",9,0,0,"G","                                                            ","SF2   ","   "," ","MV_PAR05","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")
PutSx1(cPerg,"06","Nota Fiscal Ate","","","MV_CH6","C",9,0,0,"G","                                                            ","SF2   ","   "," ","MV_PAR06","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")

PutSx1(cPerg,"07","Serie De","","","MV_CH3","C",3,0,0,"G","                                                            ","      ","   "," ","MV_PAR07","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")
PutSx1(cPerg,"08","Serie Ate","","","MV_CH3","C",3,0,0,"G","                                                            ","      ","   "," ","MV_PAR08","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")

PutSx1(cPerg,"09","Cliente De","","","MV_CHB","C",6,0,0,"G","                                                            ","SA1   ","   "," ","MV_PAR09","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")
PutSx1(cPerg,"10","Cliente Ate","","","MV_CHC","C",6,0,0,"G","                                                            ","SA1   ","   "," ","MV_PAR10","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")

PutSx1(cPerg,"11","Loja De","","","MV_CHD","C",2,0,0,"G","                                                            ","      ","   "," ","MV_PAR11","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")
PutSx1(cPerg,"12","Loja Ate","","","MV_CHE","C",2,0,0,"G","                                                            ","      ","   "," ","MV_PAR12","               ","               ","               ","                                                            ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","               ","          ","","","","")

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGPR130  �Autor  �Microsiga           � Data �  03/24/17   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function ReportDef(cPerg)
Local cTitle  := "Rela�ao de Notas Fiscais - Conferencia Cega"
Local cHelp   := ""
Local oReport
Local oSection1

oReport := TReport():New('NCGPR130',cTitle,cPerg,{|oReport| ReportPrint(oReport)},cHelp)

oSection1 := TRSection():New(oReport,cTitle,{"SF2"})

TRCell():New(oSection1,"F2_FILIAL"	, "SF2")
TRCell():New(oSection1,"F2_DOC"		, "SF2","NF")
TRCell():New(oSection1,"F2_SERIE"	, "SF2","Serie")
TRCell():New(oSection1,"F2_EMISSAO"	, "SF2")
TRCell():New(oSection1,"F2_CLIENTE"	, "SF2")
TRCell():New(oSection1,"F2_LOJA"	, "SF2")
TRCell():New(oSection1,"A1_NREDUZ"	, cQryAlias,"Nome",,20)
TRCell():New(oSection1,"STATUS"  	, "SF2"	,"Status",,60,/*lPixel*/,{|| cStatusNF }	)

Return(oReport)

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NCGPR130  �Autor  �Microsiga           � Data �  03/24/17   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function ReportPrint(oReport)
Local oSecao1 := oReport:Section(1)


BeginSQL Alias cQryAlias
	SELECT  SF2.R_E_C_N_O_ RECNOSF2,A1_NREDUZ
	FROM %Table:SF2% SF2
	INNER JOIN %Table:SA1% SA1
	ON SA1.A1_FILIAL = %xFilial:SA1%
	AND SA1.A1_COD Between %Exp:mv_par09% And %Exp:mv_par10%
	AND SA1.A1_LOJA Between %Exp:mv_par11% And %Exp:mv_par12%
	AND SA1.A1_YEMPDES <>' '
	AND SA1.A1_YFILDES <>' '
	AND SA1.%NotDel%
	WHERE SF2.F2_FILIAL Between %Exp:mv_par01% And %Exp:mv_par02%
	AND SF2.F2_DOC Between %Exp:mv_par05% And %Exp:mv_par06%
	AND SF2.F2_SERIE  Between %Exp:mv_par07% And %Exp:mv_par08%
	AND SF2.F2_CLIENTE=SA1.A1_COD
	AND SF2.F2_LOJA =SA1.A1_LOJA
	AND SF2.F2_EMISSAO Between %Exp:Dtos(mv_par03)% And %Exp:Dtos(mv_par04)%
	AND SF2.F2_TIPO = 'N'
	AND SF2.F2_CHVNFE <>' '
	AND SF2.%NotDel%
	Order by F2_FILIAL,F2_DOC,F2_SERIE,F2_EMISSAO
EndSQL


oSecao1:Init()
Do While (cQryAlias)->(!Eof())
	oReport:IncMeter()
	
	SF2->(DbGoTo( (cQryAlias)->RECNOSF2)) 
	
	If !VldItemPA(SF2->F2_DOC, SF2->F2_SERIE, SF2->F2_CLIENTE, SF2->F2_LOJA)
		(cQryAlias)->(DbSkip())
	EndIf	

	aLojDest:= GetLjDest(SF2->F2_CLIENTE, SF2->F2_LOJA)
	
	cStatusNF:=""
        
	If !VldNFSefaz(SF2->F2_CHVNFE)
		cStatusNF:="Nao autorizada no SEFAZ"    	
	ElseIf Len(aLojDest) == 0
		cStatusNF:="Cliente "+SF2->F2_CLIENTE+" Loja " +SF2->F2_LOJA+" nao encontrado na tabela ZX5"
	ElseIf VldNfCC(aLojDest[LOJADESTINO], SF2->(F2_DOC+F2_SERIE+ aLojDest[CODFORNECE] + aLojDest[LOJAFORNCE] +F2_TIPO) )
		cStatusNF:="J� enviada"
	Else
		cStatusNF:="Nao enviada"
	EndIf

	oSecao1:PrintLine()
	(cQryAlias)->(DbSkip())
EndDo
oSecao1:Finish()


Return