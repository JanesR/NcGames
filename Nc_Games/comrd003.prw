#include "rwmake.ch"
#include "protheus.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCOMRD003  บAutor  ณTHIAGO QUEIROZ      บ Data ณ  26/09/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Envia WorkFlow de Aprovacao de Solicitacao de Compras      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ 		                                                      บฑฑ
ฑฑบ          ณ Necessario Criar Campo                                     บฑฑ
ฑฑบ          ณ Nome			Tipo	Tamanho	Titulo			OBS           บฑฑ
ฑฑบ          ณ C1_CODAPROV  C         6    Cod Aprovador                  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function COMRD003(EMAILS,APROVADOR)

Local cSuperior := PswRet()[1][11]
//Local cTotItem 	:= Strzero(Len(aCols),4)
Private cDiasA
Private cDiasE
/*
IF PswRet()[1][1] == "000000"
cSuperior := "000000"
ELSEIF ALLTRIM(PswRet()[1][1]) == "" // Usuario nao tem superior preenchido
cSuperior := "N"
ENDIF

//GRAVA O NOME DA FUNCAO NA Z03
//U_CFGRD001(FunName())
*/
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณVerifica a Existencia de Parametro MV__TIMESCณ
//ณCaso nao exista. Cria o parametro.           ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
dbSelectArea("SX6")
If !dbSeek("  "+"MV__TIMESC")
	RecLock("SX6",.T.)
	X6_VAR    	:= "MV__TIMESC"
	X6_TIPO 	:= "C"
	X6_CONTEUD 	:= "0305"
	X6_CONTENG 	:= "0305"
	X6_CONTSPA 	:= "0305"
	X6_DESCRIC	:= "DEFINE TEMPO EM DIAS DE TIMEOUT DA APROVACAO DE SO"
	X6_DESC1	:= "LICITACAO DE COMPRAS - EX: AVISO EM 3 DIAS E EXCLU"
	X6_DESC2	:= "SAO EM 5 DIAS = 0305                              "
	MsUnlock("SX6")
EndIf

cDiasA := SubStr(GetMv("MV__TIMESC"),1,2) //TIMEOUT Dias para Avisar Aprovador
cDiasE := SubStr(GetMv("MV__TIMESC"),3,2) //TIMEOUT Dias para Excluir a Solicitacao

//Pergunte("COMRD3",.F.) //Carrega Perguntas

/*
If mv_par04 == 1 //Aprovacao por ITEM
U_COMWF002()
ElseIf SC1->C1_ITEM == cTotItem //Aprovacao por SOLICITACAO
U_COMWF001()
EndIf
*/

//If SC1->C1_ITEM == cTotItem
U_COMWF001(EMAILS,APROVADOR) //Envido do Resumo da Solicitacao
//EndIf

//U_COMWF002() //Envio dos Detalhes da Solicitacao

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCOMWF001  บAutor  ณTHIAGO QUEIROZ      บ Data ณ  26/09/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Envia Workflow de Aprovacao de Solicitacao de Compras      บฑฑ
ฑฑบ          ณ Para quando a aprovacao e feita por SOLICITACAO            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function COMWF001(EMAILS,APROVADOR)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณDeclara็ใo de Variaveisณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Local cMvAtt 	:= GetMv("MV_WFHTML")
Local _cEMails	:= EMAILS
Local cMailSup	:= "" //"thiago@stch.com.br" //UsrRetMail(cAprov)
Local cCopia 	:= "thiago@stch.com.br;soliveira@ncgames.com.br"
Local cDiasA 	:= SubStr(GetMv("MV__TIMESC"),1,2) //TIMEOUT Dias para Avisar Aprovador
Local cDiasE 	:= SubStr(GetMv("MV__TIMESC"),3,2) //TIMEOUT Dias para Excluir a Solicitacao
Local nVlrTotSC	:= 0
Local nI		:= 1

Private oHtml

cQuery := " SELECT * " //C1_NUM, C1_EMISSAO, C1_SOLICIT, C1_ITEM, C1_PRODUTO, C1_DESCRI, C1_UM, C1_QUANT, C1_DATPRF, C1_OBS, C1_CC, C1_CODAPRO, C1_USER"
cQuery += " FROM SC1010"
//IF EMPTY(ALLTRIM(cNumSC))
IF TYPE("cNumSC") == "U"
	//	cQuery += " WHERE C1_NUM = '"+SC1->C1_NUM+"'"
	cQuery += " WHERE C1_NUM = '"+SZM->ZM_NUM+"'"
ELSE
	cQuery += " WHERE C1_NUM = '"+cNumSC+"'"
ENDIF

MemoWrit("COMWF001.sql",cQuery)
dbUseArea(.T.,"TOPCONN", TCGenQry(,,cQuery),"TRB", .F., .T.)

TcSetField("TRB","C1_EMISSAO","D")
TcSetField("TRB","C1_DATPRF","D")

COUNT TO nRec
//CASO TENHA DADOS
If nRec > 0
	
	dbSelectArea("TRB")
	dbGoTop()
	
	cNumSc			:= TRB->C1_NUM
	cSolicit		:= TRB->C1_SOLICIT
	cUserLib		:= GETADVFVAL("SAI","AI_NCSUPER",XFILIAL("SAI")+TRB->C1_USER,2,SPACE(06))
	CONOUT("TRB->C1_USER = " + cUserLib)
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณMuda o parametro para enviar no corpo do e-mailณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	PutMv("MV_WFHTML","T") // MANDA O HTML NO CORPO DO EMAIL
	/*
	// SE O USUARIO NAO TIVER SUPERIOR CADASTRADO, MANDA EMAIL PARA O ADMINISTRADOR
	IF ALLTRIM(TRB->C1_USRAPRO) == ""
	cMailSup 		:= "thiago@stch.com.br"
	ELSE
	cMailSup 		:= "thiago@stch.com.br" //UsrRetMail(TRB->USRAPRO)
	ENDIF
	*/
	oProcess		:=TWFProcess():New("000004","WORKFLOW PARA APROVACAO DE SC")
	oProcess:NewTask('Inicio',"\WORKFLOW\HTML\COMWF001.htm")
	oHtml   		:= oProcess:oHtml
	
	IF EMPTY(Aprovador)
		Aprovador	:= GETADVFVAL("SAI","AI_NCSUPER",XFILIAL("SAI")+TRB->C1_USER,2,SPACE(06))
	ELSE
		Aprovador	:= Aprovador
	ENDIF
	
	cCCusto			:= GETADVFVAL("SAI","AI_CC",XFILIAL("SAI")+TRB->C1_USER,2,SPACE(06))
	cCCDesc			:= GETADVFVAL("CTT","CTT_DESC01",XFILIAL("CTT")+cCCusto,1,SPACE(06))
	
	// CRIA VARIAVEL COM O EMAIL DO SUPERIOR RESPONSAVEL PELA APROVACAO DA SOLICITACAO DE COMPRAS
	//cMailSup 		:= UsrRetMail(GETADVFVAL("SAI","AI_NCSUPER",XFILIAL("SAI")+TRB->C1_USRAPRO,2,SPACE(06))) // SAI - SOLICITANTES
	//cMailSup 		:= UsrRetMail(GETADVFVAL("SAI","AI_NCSUPER",XFILIAL("SAI")+SC1->C1_USER,2,SPACE(06)))
	//cMailSup 		:= UsrRetMail(GETADVFVAL("SAK","AK_USER",XFILIAL("SAK")+TRB->C1_USRAPRO,2,SPACE(09)))	 // SAK - APROVADORES
	IF !EMPTY(ALLTRIM(TRB->C1_USRAPRO))
		cMailSup 	:= UsrRetMail(TRB->C1_USRAPRO)
	ELSE
		cMailSup 	:= UsrRetMail(GETADVFVAL("SAI","AI_NCSUPER",XFILIAL("SAI")+TRB->C1_USER,2,SPACE(06))) // SAI - SOLICITANTES
	ENDIF
	
	CONOUT("PREENCHE O EMAIL DO SUPERIOR COM O EMAIL: " + cMailSup + " DO SUPERIOR: " + TRB->C1_USRAPRO)
	
	oHtml:ValByName("diasA"			, cDiasA)
	oHtml:ValByName("diasE"			, cDiasE)
	oHtml:ValByName("cNUM"			, TRB->C1_NUM)
	oHtml:ValByName("cEMISSAO"		, DTOC(TRB->C1_EMISSAO))
	oHtml:ValByName("cSOLICIT"		, TRB->C1_SOLICIT)
	oHtml:ValByName("cCUSTO"		, Alltrim(cCCusto)+"-"+Alltrim(cCCDesc))
	oHtml:ValByName("cCODUSR"		, TRB->C1_USER)
	oHtml:ValByName("cCODAPROV"		, Aprovador)
	oHtml:ValByName("cAPROV"		, "")
	oHtml:ValByName("cMOTIVO"		, "")
	oHtml:ValByName("it.ITEM"		, {})
	oHtml:ValByName("it.PRODUTO"	, {})
	oHtml:ValByName("it.DESCRI"		, {})
	//oHtml:ValByName("it.UM"		 {})
	oHtml:ValByName("it.VALUNIT"	, {})
	oHtml:ValByName("it.VALTOTAL"	, {})
	oHtml:ValByName("it.QUANT"		, {})
	//oHtml:ValByName("it.DATPRF"	, {})
	oHtml:ValByName("it.OBS"		, {})
	//oHtml:ValByName("it.CC"		, {})
	
	dbSelectArea("TRB")
	dbGoTop()
	While !EOF()
		aadd(oHtml:ValByName("it.ITEM")		,TRB->C1_ITEM																			) //Item Cotacao
		aadd(oHtml:ValByName("it.PRODUTO")	,TRB->C1_PRODUTO																		) //Cod Produto
		aadd(oHtml:ValByName("it.DESCRI")	,TRB->C1_DESCRI																			) //Descricao Produto
		//aadd(oHtml:ValByName("it.UM")		,TRB->C1_UM																				) //Unidade Medida
		aadd(oHtml:ValByName("it.QUANT")	,TRANSFORM( TRB->C1_QUANT										,'@E 999,999.99' )		) //Quantidade Solicitada
		//aadd(oHtml:ValByName("it.QUANT")	,TRB->C1_QUANT       																	) //Quantidade Solicitada
		aadd(oHtml:ValByName("it.VALUNIT")	,TRANSFORM( TRB->C1_NCVLUNI										,'@E 999,999,999.99' )	) //Valor Unitario
		aadd(oHtml:ValByName("it.VALTOTAL")	,TRANSFORM( (TRB->C1_QUANT - TRB->C1_QUJE) * TRB->C1_NCVLUNI	,'@E 9,999,999,999.99' )) //Valor Total
		//aadd(oHtml:ValByName("it.DATPRF")	,DTOC(TRB->C1_DATPRF)																	) //Data da Necessidade
		aadd(oHtml:ValByName("it.OBS")		,TRB->C1_OBS																			) //Observacao
		//aadd(oHtml:ValByName("it.CC")		,TRB->C1_CC																				) //Centro de Custo
		
		nVlrTotSC += (SC1->C1_QUANT - SC1->C1_QUJE) * SC1->C1_NCVLUNI
		dbSkip()
	End
	
	dbSelectArea("SZI")
	dbSetOrder(1)
	IF dbSeek(xFilial("SZI")+"SC1"+cNumSC)
		
		WHILE !EOF() .AND. cNumSC == SZI->ZI_DOC .AND. SZI->ZI_ROTINA == "SC1"
			
			IF NI <= 3
				IF NI == 1
					oHtml:ValByName("cAprov1"			, SZI->ZI_NOMEUSR)
					oHtml:ValByName("cCusto1"			, ALLTRIM(SZI->ZI_CC)+"-"+Alltrim(SZI->ZI_DESCCC))
				ELSEIF NI == 2
					oHtml:ValByName("cAprov2"			, SZI->ZI_NOMEUSR)
					oHtml:ValByName("cCusto2"			, ALLTRIM(SZI->ZI_CC)+"-"+Alltrim(SZI->ZI_DESCCC))
				ELSEIF NI == 3
					oHtml:ValByName("cAprov3"			, SZI->ZI_NOMEUSR)
					oHtml:ValByName("cCusto3"			, ALLTRIM(SZI->ZI_CC)+"-"+Alltrim(SZI->ZI_DESCCC))
				ENDIF
			ENDIF
			
			NI++
			dbSelectArea("SZI")
			dbSkip()
		ENDDO
	ELSE
		oHtml:ValByName("cAprov1"			, "")
		oHtml:ValByName("cCusto1"			, "")
		oHtml:ValByName("cAprov2"			, "")
		oHtml:ValByName("cCusto2"			, "")
		oHtml:ValByName("cAprov3"			, "")
		oHtml:ValByName("cCusto3"			, "")
	ENDIF
	
	//Grava o email na pasta referente as solicita็๕es de compras "SOLCOMPRA"
	oProcess:cTo    	:= "SOLCOMPRA
	oProcess:bReturn  	:= "U_COMWF01a()"
	//oProcess:bTimeOut 	:= {{"U_COMWF01b()", 0 , 0, 3 },{"U_COMWF01c()", 0 , 0, 6 }}
	//oProcess:bTimeOut 	:= {{"U_COMWF01b()", Val(cDiasA) , 0, 0 },{"U_COMWF01c()", Val(cDiasE) , 0, 0 }}
	cMailID				:= oProcess:Start()
	
	oProcess:Free()
	//conout("(INICIO|WFLINK)Processo: " + oProcess:fProcessID + " - Task: " + oProcess:fTaskID )
	
	// INICIA O ENVIO DO EMAIL COM O LINK PARA APROVACAO DO WORKFLOW DE SOLICITACAO DE COMRPAS
	oProcess:NewTask("LINK", "\WORKFLOW\HTML\WF_LINK_COM_SOLICITACAO.html")
	
	oProcess:oHtml:ValByName("A_LINK", "http://192.168.0.200:8092/messenger/emp" + "01"/*cEmpAnt*/ + "/SOLCOMPRA/" + cMailId + ".htm")
	oProcess:oHtml:ValByName("B_LINK", "http://186.215.160.178:8092/messenger/emp" + "01"/*cEmpAnt*/ + "/SOLCOMPRA/" + cMailId + ".htm")
	
	oProcess:ClientName( Subs(cUsuario,7,15) )
	oProcess:cTo 		:= cMailSup // _cEMails
	oProcess:cBCC     	:= cCopia   // "thiago@stch.com.br"
	oProcess:cSubject  	:= "Aprova็ใo de SC - "+cNumSc+" - De: "+cSolicit
	
	oProcess:Start()
	
	//RastreiaWF( ID do Processo                        , Codigo do Processo, Codigo do Status, Descricao Especifica                   , Usuario )
	RastreiaWF(oProcess:fProcessID+'.'+oProcess:fTaskID,"000004"           ,"1001"           ,"ENVIO DE WORKFLOW PARA APROVACAO DE SC",cUsername)
	oProcess:Free()
	oProcess			:= Nil
	
	PutMv("MV_WFHTML",cMvAtt)
	
	Alert("Enviado Workflow para aprova็ใo da Solicita็ใo de Compras N:" + cSolicit)
	
	TRB->(dbCloseArea())
	
	//WFSendMail({"01","03"})
	
Else
	TRB->(dbCloseArea())
	MsgStop("Problemas no Envio do E-Mail de Aprova็ใo!","ATENวรO!")
EndIf
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCOMWF01a  บAutor  ณTHIAGO QUEIROZ      บ Data ณ  26/09/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Retor Workflow de Aprovacao/Rejeicao                       บฑฑ
ฑฑบ          ณ de Solicitacao de Compras                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ 		                                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function COMWF01a(oProcess)

Local cMvAtt 		:= GetMv("MV_WFHTML")
Local _cUserLib		:= oProcess:oHtml:RetByName("cCODAPROV")
Local cCodSol		:= oProcess:oHtml:RetByName("cCODUSR")
Local cMailSol 		:= UsrRetMail(cCodSol)

Public cNumSc		:= oProcess:oHtml:RetByName("cNUM")
Public cEmissao		:= oProcess:oHtml:RetByName("cEMISSAO")
Public cAprov		:= oProcess:oHtml:RetByName("cAPROV")
Public cMotivo		:= oProcess:oHtml:RetByName("cMOTIVO")
Public cSolicit		:= oProcess:oHtml:RetByName("cSOLICIT")
Public cItemSc		:= oProcess:oHtml:RetByName("it.ITEM")
Public cCod			:= oProcess:oHtml:RetByName("it.PRODUTO")
Public cDesc		:= oProcess:oHtml:RetByName("it.DESCRI")

Private _nVlrMin   	:= SUPERGETMV("MV_NCVLRSC")
Private _lBloq     	:= .F.
Private _cAprovad  	:= ""
Private _cNomeLib  	:= ""
Private _cMailLib  	:= ""
Private _cUsuario   := oProcess:oHtml:RetByName("cCODAPROV") // RetCodUsr()
Private _cNomeUsr   := UsrRetName(_cUsuario)
Private _aArea     	:= GetArea()
Private oHtml

ConOut("Retorno WF - Aprovacao/Rejeicao SC: "+cNumSc)
CONOUT("VERIFICA SE VAI APROVAR OU REPROVAR A SOLICITACAO DE COMPRAS")
CONOUT("cAprov igual a L ('LIBERADO') e R ('REPROVADO'), cAprov : " + cAprov)

IF cAprov == "L"
	// INICIA APROVACAO VIA WORKFLOW
	CONOUT("CHAMA FUNCAO PARA APROVAR A SC")
	//U_UFA110AP(cNumSc)
	
	dbSelectArea("SC1")
	dbSetOrder(1)
	dbSeek(xFilial("SC1")+cNumSC)
	
	dbSelectArea("SZM")
	dbSetOrder(1)
	dbSeek(xFilial("SZM")+cNumSC)
	/*
	IF EMPTY(ALLTRIM(_cUserLib)) == .T.
	//cNumSC 		:= SZM->ZM_NUM
	_cUserLib		:= SZM->ZM_USRAPRO
	ENDIF
	*/
	
	CONOUT("REALIZADO BUSCA NA SC1 E SZM COM O FILTRO : " +cNumSC)
	cCCusto	:= GETADVFVAL("SAK","AK_CC",XFILIAL("SAK")+SZM->ZM_USRAPRO,2,SPACE(09)) //SZM->ZM_CC
	cCCDesc	:= GETADVFVAL("CTT","CTT_DESC01",XFILIAL("CTT")+cCCusto,1,SPACE(40))  //SZM->ZM_DESCCC
	
	
	dbSelectArea("SZI")
	dbSetOrder(1)
	RecLock("SZI",.T.)
	SZI->ZI_FILIAL  := xFilial("SZI")
	SZI->ZI_ROTINA  := "SC1"
	SZI->ZI_DOC     := SZM->ZM_NUM
	SZI->ZI_STATUS  := "A"
	SZI->ZI_USER    := _cUsuario
	SZI->ZI_NOMEUSR := _cNomeUsr
	SZI->ZI_CC      := cCCusto //SZM->ZM_CC
	SZI->ZI_DESCCC  := cCCDesc //SZM->ZM_DESCCC
	SZI->ZI_DATA    := DDATABASE
	SZI->ZI_HORA    := TIME()
	MsUnLock()
	
	CONOUT("SZI - Solicitacao de Compras Liberada pelo usuario "+_cUsuario+" - "+_cNomeUsr)
	CONOUT("Vai procurar na SAK pelo aprovador de codigo: " + _cUserLib)
	
	dbSelectArea("SAK")
	dbSetOrder(2)                // AK_FILIAL+AK_USER
	If dbSeek(xFilial("SAK")+_cUserLib)
		CONOUT("ACHOU O APROVADOR NA SAK COM O CODIGO " + _cUserLib)
		If SZM->ZM_VALORT >= SAK->AK_LIMMIN .And. SZM->ZM_VALORT <= SAK->AK_LIMMAX
			_cUserLib := Space(06)
			CONOUT("_cUserLib recebe branco, nao entrou na regra de valores")
		Else
			_cUserLib := GETADVFVAL("SAK","AK_USER",XFILIAL("SAK")+SAK->AK_APROSUP,1,SPACE(06))
			CONOUT("_cUserLib recebe "+_cUserLib)
		EndIf
	EndIf
	
	If !Empty(_cUserLib) .And. _cUserLib != SZM->ZM_USRAPRO
		CONOUT("_cUserLib nao e vazio E _cUserLib - "+_cUserLib+" != SZM->ZM_USRAPRO - "+SZM->ZM_USRAPRO)
		_cNomeLib := UsrRetName(_cUserLib)
		_cMailLib := AllTrim(UsrRetMail(_cUserLib))
		/*/
		dbGoTop()
		Do While !Eof()
			If SZM->ZM_VALORT >= SAK->AK_LIMMIN .And. SZM->ZM_VALORT <= SAK->AK_LIMMAX
				If SAK->AK_USER == _cUserLib
					_cNomeLib := UsrRetName(_cUserLib)
					_cMailLib := AllTrim(UsrRetMail(_cUserLib))
					Exit
				EndIf
			EndIf
			dbSkip()
		EndDo
		/*/
		dbSelectArea("SC1")
		dbSetOrder(1)          // C1_FILIAL+C1_NUM+C1_ITEM
		dbSeek(xFilial("SC1")+cNumSC,.T.)
		Do While !Eof() .And. SC1->C1_NUM == cNumSC
			RecLock("SC1",.F.)
			SC1->C1_APROV   := "B"
			SC1->C1_USRAPRO := _cUserLib
			SC1->C1_NOMEAPR := _cNomeLib
			MsUnlock()
			_cNome          := SC1->C1_USER+" - "+UsrRetName(SC1->C1_USER)
			_cNomFor        := POSICIONE("SA2",1,XFILIAL("SA2")+SC1->C1_FORNECE+SC1->C1_LOJA,"A2_NOME")
			_lBloq          := .T.
			dbSkip()
		EndDo
		
		RestArea(_aArea)
		RecLock("SZM",.F.)
		SZM->ZM_APROV   	:= "B"
		SZM->ZM_USRAPRO 	:= _cUserLib
		SZM->ZM_NOMEAPR 	:= _cNomeLib
		MsUnlock()
	Else
		CONOUT("ELSE do IF que verifica o usuario de liberacao")
		CONOUT("_cUserLib - "+_cUserLib+" != SZM->ZM_USRAPRO - "+SZM->ZM_USRAPRO)
		
		dbSelectArea("SC1")
		dbSetOrder(1)          // C1_FILIAL+C1_NUM+C1_ITEM
		dbSeek(xFilial("SC1")+cNumSC,.T.)
		Do While !Eof() .And. SC1->C1_NUM == cNumSC
			RecLock("SC1",.F.)
			SC1->C1_APROV   := "L"
			MsUnlock()
			dbSkip()
		EndDo
		
		RestArea(_aArea)
		RecLock("SZM",.F.)
		SZM->ZM_APROV		:= "L"
		MsUnlock()
		
		U_COMWF02a(oProcess)
	EndIf
	
	CONOUT("Verifica se manda email para o proximo aprovador")
	If _lBloq
		//Env_B_EMail()
		U_COMWF001("soliveira@ncgames.com.br;rogerio@stch.com.br" /*_cMailLib*/,_cUserLib)
		CONOUT("MANDA EMAIL PARA O PROXIMO APROVADOR")
	ELSE
		CONOUT("NAO MANDOU EMAIL PARA O PROXIMO APROVADOR, SC APROVADA")
	EndIf
	
	RestArea(_aArea)
	// FINALIZA APROVACAO VIA WORKFLOW
ELSEIF cAprov == "R"
	CONOUT("CHAMA FUNCAO PARA REPROVAR A SC")
	//U_UFA110RJ(cNumSc)
	
	dbSelectArea("SC1")
	dbSetOrder(1)
	dbSeek(xFilial("SC1")+cNumSC)
	
	dbSelectArea("SZM")
	dbSetOrder(1)
	dbSeek(xFilial("SZM")+cNumSC)
	
	CONOUT("REALIZADO BUSCA NA SC1 E SZM COM O FILTRO : " +cNumSC)
	
	RecLock("SZM",.F.)
	SZM->ZM_APROV   	:= "R"
	MsUnlock()
	Alert("Solicitacao de Compras Rejeitada pelo usuario "+_cUsuario+" - "+_cNomeUsr)
	cCCusto	:= GETADVFVAL("SAK","AK_CC",XFILIAL("SAK")+SZM->ZM_USRAPRO,2,SPACE(09)) //SZM->ZM_CC
	cCCDesc	:= GETADVFVAL("CTT","CTT_DESC01",XFILIAL("CTT")+cCCusto,1,SPACE(40))  //SZM->ZM_DESCCC
	
	dbSelectArea("SZI")
	dbSetOrder(1)
	RecLock("SZI",.T.)
	SZI->ZI_FILIAL  	:= xFilial("SZI")
	SZI->ZI_ROTINA  	:= "SC1"
	SZI->ZI_DOC     	:= SZM->ZM_NUM
	SZI->ZI_STATUS  	:= "R"
	SZI->ZI_USER    	:= _cUsuario
	SZI->ZI_NOMEUSR 	:= _cNomeUsr
	SZI->ZI_CC        	:= cCCusto //SZM->ZM_CC
	SZI->ZI_DESCCC    	:= cCCDesc //SZM->ZM_DESCCC
	SZI->ZI_DATA    	:= DDATABASE
	SZI->ZI_HORA    	:= TIME()
	MsUnLock()
	
	U_COMWF02a(oProcess)
	
ENDIF

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCOMWF01b  บAutor  ณTHIAGO QUEIROZ      บ Data ณ  26/09/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Envia um Aviso para Aprovador apos periodo de TIMEOUT      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ 		                                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function COMWF01b(oProcess)

Local cMvAtt 	:= GetMv("MV_WFHTML")
Local cNumSc	:= oProcess:oHtml:RetByName("cNUM")
Local cSolicit	:= oProcess:oHtml:RetByName("cSOLICIT")
Local cEmissao	:= oProcess:oHtml:RetByName("cEMISSAO")
Local cDiasA	:= oProcess:oHtml:RetByName("diasA")
Local cDiasE	:= oProcess:oHtml:RetByName("diasE")
Local cMailSup	:= ""
Local cCopia	:= "thiago@stch.com.br;soliveira@ncgames.com.br"
Private oHtml

ConOut("AVISO POR TIMEOUT SC:"+cNumSc+" Solicitante:"+cSolicit)

oProcess:Free()
oProcess:= Nil

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณInicia Envio de Mensagem de Avisoณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
PutMv("MV_WFHTML","T")

oProcess:=TWFProcess():New("000004","WORKFLOW PARA APROVACAO DE SC")
oProcess:NewTask('Inicio',"\workflow\HTML\COMWF003.htm")
oHtml   := oProcess:oHtml

oHtml:valbyname("Num"		, cNumSc)
oHtml:valbyname("Req"    	, cSolicit)
oHtml:valbyname("Emissao"   , cEmissao)
oHtml:valbyname("diasA"   	, cDiasA)
oHtml:valbyname("diasE"   	, Val(cDiasE)-Val(cDiasA))
oHtml:valbyname("it.Item"   , {})
oHtml:valbyname("it.Cod"  	, {})
oHtml:valbyname("it.Desc"   , {})

cQuery := " SELECT * " // C1_ITEM, C1_PRODUTO, C1_DESCRI, C1_CODAPRO"
cQuery += " FROM SC1010"
cQuery += " WHERE C1_NUM = '"+cNumSc+"'"

MemoWrit("COMWF01b.sql",cQuery)
dbUseArea(.T.,"TOPCONN", TCGenQry(,,cQuery),"TRB", .F., .T.)

COUNT TO nRec
//CASO TENHA DADOS
If nRec > 0
	
	dbSelectArea("TRB")
	dbGoTop()
	// CRIA VARIAVEL COM O EMAIL DO SUPERIOR RESPONSAVEL PELA APROVACAO DA SOLICITACAO DE COMPRAS
	//cMailSup := UsrRetMail(TRB->C1_USRAPRO)
	cMailSup 		:= UsrRetMail(GETADVFVAL("SAI","AI_NCSUPER",XFILIAL("SAI")+TRB->C1_USER,2,SPACE(06)))
	
	While !EOF()
		aadd(oHtml:ValByName("it.Item")		, TRB->C1_ITEM)
		aadd(oHtml:ValByName("it.Cod")		, TRB->C1_PRODUTO)
		aadd(oHtml:ValByName("it.Desc")		, TRB->C1_DESCRI)
		dbSkip()
	End
	
EndIf
TRB->(dbCloseArea())
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณFuncoes para Envio do Workflowณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

//envia o e-mail
cUser 			  := Subs(cUsuario,7,15)
oProcess:ClientName(cUser)
oProcess:cTo	  := cMailSup
oProcess:cBCC     := cCopia
oProcess:cSubject := "Aviso de TimeOut de SC Nฐ: "+cNumSc+" - De: "+cSolicit
oProcess:cBody    := ""
oProcess:bReturn  := ""
oProcess:Start()
//RastreiaWF( ID do Processo, Codigo do Processo, Codigo do Status, Descricao Especifica, Usuario )
RastreiaWF(oProcess:fProcessID+'.'+oProcess:fTaskID,"000004",'1003',"TIMEOUT DE WORKFLOW PARA APROVACAO DE SC",cUsername)
oProcess:Free()
oProcess:Finish()
oProcess:= Nil

PutMv("MV_WFHTML",cMvAtt)

WFSendMail({"01","03"})

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCOMWF01c  บAutor  ณTHIAGO QUEIROZ      บ Data ณ  26/09/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Exclui a solicitacao apos um periodo de TIMEOUT            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ 		                                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function COMWF01c(oProcess)

Local cMvAtt 	:= GetMv("MV_WFHTML")
Local cNumSc	:= oProcess:oHtml:RetByName("cNUM")
Local cSolicit	:= oProcess:oHtml:RetByName("cSOLICIT")
Local cEmissao	:= oProcess:oHtml:RetByName("cEMISSAO")
Local cDiasA	:= oProcess:oHtml:RetByName("diasA")
Local cDiasE	:= oProcess:oHtml:RetByName("diasE")
Local cCodSol	:= RetCodUsr(cSolicit)
Local cMailSol 	:= "" //UsrRetMail(cCodSol)
Local aCab 		:= {}
Local aItem		:= {}
Private oHtml

ConOut("EXCLUSAO POR TIMEOUT SC:"+cNumSc+" Solicitante:"+cSolicit)

cQuery := " SELECT * " //C1_ITEM, C1_PRODUTO, C1_DESCRI, C1_CODAPRO"
cQuery += " FROM SC1010"
cQuery += " WHERE C1_NUM = '"+cNumSc+"'"

MemoWrit("COMWF01b.sql",cQuery)
dbUseArea(.T.,"TOPCONN", TCGenQry(,,cQuery),"TRB", .F., .T.)

COUNT TO nRec
//CASO TENHA DADOS
If nRec > 0
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณInicia MsExecAuto da Exclusaoณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	dbSelectArea("TRB")
	dbGoTop()
	// CRIA VARIAVEL COM O EMAIL DO SUPERIOR RESPONSAVEL PELA APROVACAO DA SOLICITACAO DE COMPRAS
	//cMailSup 		:= UsrRetMail(TRB->C1_USRAPRO)
	cMailSup 		:= UsrRetMail(GETADVFVAL("SAI","AI_NCSUPER",XFILIAL("SAI")+TRB->C1_USER,2,SPACE(06)))
	cMailSol 		:= UsrRetMail(TRB->C1_USER)
	While !EOF()
		lMsErroAuto := .F.
		aCab:= {		{"C1_NUM",cNumSc,NIL}}
		Aadd(aItem, {	{"C1_ITEM",TRB->C1_ITEM,NIL}})
		
		Begin Transaction
		MSExecAuto({|x,y,z| mata110(x,y,z)},aCab,aItem,5) //Exclusao
		End Transaction
		
		dbSkip()
	End
	
	oProcess:Finish()
	oProcess:Free()
	oProcess:= Nil
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณInicia Envio de Mensagem de Avisoณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	PutMv("MV_WFHTML","F")
	
	oProcess	:=TWFProcess():New("000004","WORKFLOW PARA APROVACAO DE SC")
	oProcess:NewTask('Inicio',"\workflow\HTML\COMWF004.htm")
	oHtml   	:= oProcess:oHtml
	
	oHtml:valbyname("Num"		, cNumSc)
	oHtml:valbyname("Req"    	, cSolicit)
	oHtml:valbyname("Emissao"	, cEmissao)
	oHtml:valbyname("diasE"		, cDiasE)
	oHtml:valbyname("it.Item"	, {})
	oHtml:valbyname("it.Cod"	, {})
	oHtml:valbyname("it.Desc"	, {})
	
	dbSelectArea("TRB")
	dbGoTop()
	
	While !EOF()
		aadd(oHtml:ValByName("it.Item")		, TRB->C1_ITEM)
		aadd(oHtml:ValByName("it.Cod")		, TRB->C1_PRODUTO)
		aadd(oHtml:ValByName("it.Desc")		, TRB->C1_DESCRI)
		dbSkip()
	End
	
EndIf
TRB->(dbCloseArea())

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณFuncoes para Envio do Workflowณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

//envia o e-mail
cUser 			  := Subs(cUsuario,7,15)
oProcess:ClientName(cUser)
oProcess:cTo	  := cMailSup+";"+cMailSol
oProcess:cBCC     := cCopia
oProcess:cSubject := "Exclusใo por TimeOut - SC Nฐ: "+cNumSc+" - De: "+cSolicit
oProcess:cBody    := ""
oProcess:bReturn  := ""
oProcess:Start()
//RastreiaWF( ID do Processo, Codigo do Processo, Codigo do Status, Descricao Especifica, Usuario )
RastreiaWF(oProcess:fProcessID+'.'+oProcess:fTaskID,"000004",'1004',"TIMEOUT EXCLUSAO DE WORKFLOW PARA APROVACAO DE SC",cUsername)
oProcess:Free()
oProcess:Finish()
oProcess:= Nil

PutMv("MV_WFHTML",cMvAtt)

WFSendMail({"01","03"})

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCOMWF002  บAutor  ณTHIAGO QUEIROZ      บ Data ณ  26/09/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Envia Workflow de Aprovacao de Solicitacao de Compras      บฑฑ
ฑฑบ          ณ Para quando a aprovacao e feita por ITEM                   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function COMWF002()
// FUNCAO NAO ESTA EM USO
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณDeclara็ใo de Variaveisณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Local cMvAtt 	:= GetMv("MV_WFHTML")
Local cAprov 	:= PswRet()[1][11]
//Local cMailSup := "soliveira@ncgames.com.br" //UsrRetMail(cAprov)
Local cMailSup 	:= "thiago@stch.com.br" //UsrRetMail(cAprov)
Local cCopia	:= "thiago@stch.com.br"
LOCAL aMeses	:= {"Jan","Fev","Mar","Abr","Mai","Jun","Jul","Ago","Set","Out","Nov","Dez"}
Private oHtml

cQuery := " SELECT * "
cQuery += " FROM "+RetSqlName("SC1")+" C1, "+RetSqlName("SB1")+" B1, "+RetSqlName("SB2")+" B2 "
cQuery += " WHERE C1_PRODUTO 	= B2_COD  "
cQuery += " AND C1_PRODUTO 		= B1_COD "
cQuery += " AND C1_LOCAL 		= B2_LOCAL "
cQuery += " AND C1_NUM 			= '"+SC1->C1_NUM+"'"
cQuery += " AND C1_ITEM 		= '"+SC1->C1_ITEM+"'"

MemoWrit("COMWF002.sql",cQuery)
dbUseArea(.T.,"TOPCONN", TCGenQry(,,cQuery),"TRB", .F., .T.)

TcSetField("TRB","C1_EMISSAO","D")
TcSetField("TRB","C1_DATPRF","D")

COUNT TO nRec
//CASO TENHA DADOS
If nRec > 0
	
	dbSelectArea("TRB")
	TRB->(dbGoTop())
	
	cNumSc		:= TRB->C1_NUM
	cSolicit	:= TRB->C1_SOLICIT
	cItem		:= TRB->C1_ITEM
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณMuda o parametro para enviar no corpo do e-mailณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	PutMv("MV_WFHTML","T")
	
	oProcess:=TWFProcess():New("000004","WORKFLOW PARA APROVACAO DE SC")
	oProcess:NewTask('Inicio',"\WORKFLOW\HTML\COMWF002.htm")
	oHtml   := oProcess:oHtml
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณDados do Cabecalhoณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	oHtml:ValByName("diasA"			, cDiasA)
	oHtml:ValByName("diasE"			, cDiasE)
	oHtml:ValByName("Num"			, TRB->C1_NUM				) //Numero da Cotacao
	oHtml:ValByName("Item1"			, TRB->C1_ITEM 				) //Item Cotacao
	oHtml:ValByName("CC"			, TRB->C1_CC				) //Centro de Custo
	oHtml:ValByName("DescCC"		, GETADVFVAL("CTT","CTT_DESC01",XFILIAL("CTT")+TRB->C1_CC,1,"")) //Descricao Centro de Custo
	oHtml:ValByName("Req"	  		, TRB->C1_SOLICIT			) //Nome Requisitante
	oHtml:ValByName("Emissao"		, DTOC(TRB->C1_EMISSAO)		) //Data de Emissao Solicitacao
	oHtml:ValByName("cAPROV"		, ""						) //Variavel que Retorna "Aprovado / Rejeitado"
	oHtml:ValByName("cMOTIVO"		, ""						) //Variavel que Retorna o Motivo da Rejeicao
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณSaldos em Estoqueณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	oHtml:ValByName("Item"		, TRB->C1_ITEM		   												) //Item Cotacao
	oHtml:ValByName("CodProd"	, TRB->C1_PRODUTO	   												) //Cod Produto
	oHtml:ValByName("Desc"		, TRB->C1_DESCRI													) //Descricao Produto
	oHtml:ValByName("SaldoAtu"	, TRANSFORM(TRB->B2_QATU  		, PesqPict("SB2","B2_QATU" ,12))	) //Saldo Atual Estoque
	oHtml:ValByName("EstMin"	, TRANSFORM(TRB->B1_EMIN		, PesqPict("SB1","B1_EMIN" ,12))	) //Ponto de Pedido
	oHtml:ValByName("QuantSol"	, TRANSFORM(TRB->C1_QUANT - TRB->C1_QUJE , PesqPict("SC1","C1_QUANT",12))) //Saldo da Solicitacao
	oHtml:ValByName("UM"		, TRANSFORM(TRB->C1_UM			, PesqPict("SC1","C1_UM"))			) //Unidade de Medida
	oHtml:ValByName("Local"		, TRANSFORM(TRB->C1_LOCAL		, PesqPict("SC1","C1_LOCAL"))		) //Armazem da Solicitacao
	oHtml:ValByName("QuantEmb"	, TRANSFORM(TRB->B1_QE			, PesqPict("SB1","B1_QE"   ,09))	) //Quantidade Por Embalagem
	oHtml:ValByName("UPRC"		, TRANSFORM(TRB->B1_UPRC		, PesqPict("SB1","B1_UPRC",12))		) //Ultimo Preco de Compra
	oHtml:ValByName("Lead" 		, TRANSFORM(CalcPrazo(TRB->C1_PRODUTO,TRB->C1_QUANT), "999")		) //Lead Time
	oHtml:ValByName("DataNec"	, If(Empty(TRB->C1_DATPRF),TRB->C1_EMISSAO,TRB->C1_DATPRF)			)//Data da Necessidade
	oHtml:ValByName("DataCom"	, SomaPrazo(If(Empty(TRB->C1_DATPRF),TRB->C1_EMISSAO,TRB->C1_DATPRF), -CalcPrazo(TRB->C1_PRODUTO,TRB->C1_QUANT)))// Data para Comprar
	oHtml:ValByName("Obs"		, TRANSFORM(TRB->C1_OBS , "@!")										) //Observacao da Cotacao
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณOrdens de Produ็ใoณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	oHtml:ValByName("op1.OP"		, {})//Coloca em Branco para
	oHtml:ValByName("op1.Prod"		, {})//caso nao tenha nenhuma OP
	oHtml:ValByName("op1.Ini"		, {})
	oHtml:ValByName("op1.QtdOp"		, {})
	oHtml:ValByName("op2.OP"		, {})
	oHtml:ValByName("op2.Prod"		, {})
	oHtml:ValByName("op2.Ini"		, {})
	oHtml:ValByName("op2.QtdOp"		, {})
	oHtml:ValByName("op3.OP"		, {})
	oHtml:ValByName("op3.Prod"		, {})
	oHtml:ValByName("op3.Ini"		, {})
	oHtml:ValByName("op3.QtdOp"		, {})
	
	//Query busca as OPs do produto
	cQuery1 := " SELECT D4_OP, D4_DATA, D4_QUANT, C2_PRODUTO "
	cQuery1 += " FROM "+RetSqlName("SD4")+" D4,  "+RetSqlName("SC2")+" C2 "
	cQuery1 += " WHERE D4_COD 				= '"+TRB->C1_PRODUTO+"' "
	cQuery1 += " AND SUBSTR(D4_OP,1,6) 		= C2_NUM "
	cQuery1 += " AND SUBSTR(D4_OP,7,2) 		= C2_ITEM "
	cQuery1 += " AND SUBSTR(D4_OP,9,3) 		= C2_SEQUEN "
	cQuery1 += " AND D4_QUANT 				> 0 "
	cQuery1 += " AND D4.D_E_L_E_T_ 			<> '*' "
	cQuery1 += " AND C2.D_E_L_E_T_ 			<> '*' "
	cQuery1 += " ORDER BY D4_DATA "
	
	MemoWrit("COMWF002a.sql",cQuery1)
	dbUseArea(.T.,"TOPCONN", TCGenQry(,,cQuery1),"TRB1", .F., .T.)
	
	TcSetField("TRB1","D4_DATA","D")
	
	COUNT TO nRec1
	//CASO TENHA DADOS
	If nRec1 > 0
		
		dbSelectArea("TRB1")
		TRB1->(dbGoTop())
		
		While !EOF()
			aadd(oHtml:ValByName("op1.OP")		, TRB1->D4_OP			) 											//Numero da OP 1
			aadd(oHtml:ValByName("op1.Prod")	, TRB1->C2_PRODUTO		) 											//Produto a Ser Produzido OP 1
			aadd(oHtml:ValByName("op1.Ini")		, DTOC(TRB1->D4_DATA)	) 											//Data da OP 1
			aadd(oHtml:ValByName("op1.QtdOp")	, TRANSFORM(TRB1->D4_QUANT , PesqPict("SD4","D4_QUANT",12))	) 	//Quantidade OP 1
			TRB1->(dbSkip())
			aadd(oHtml:ValByName("op2.OP")		, TRB1->D4_OP			) 											//Numero da OP 2
			aadd(oHtml:ValByName("op2.Prod")	, TRB1->C2_PRODUTO		) 											//Produto a Ser Produzido OP 2
			aadd(oHtml:ValByName("op2.Ini")		, DTOC(TRB1->D4_DATA)	) 											//Data da OP 2
			aadd(oHtml:ValByName("op2.QtdOp")	, TRANSFORM(TRB1->D4_QUANT , PesqPict("SD4","D4_QUANT",12))	) 	//Quantidade OP 2
			TRB1->(dbSkip())
			aadd(oHtml:ValByName("op3.OP")		, TRB1->D4_OP			) 											//Numero da OP 3
			aadd(oHtml:ValByName("op3.Prod")	, TRB1->C2_PRODUTO		) 											//Produto a Ser Produzido OP 3
			aadd(oHtml:ValByName("op3.Ini")		, DTOC(TRB1->D4_DATA)	) 											//Data da OP 3
			aadd(oHtml:ValByName("op3.QtdOp")	, TRANSFORM(TRB1->D4_QUANT , PesqPict("SD4","D4_QUANT",12))	)	//Quantidade OP 3
			TRB1->(dbSkip())
		End
		
	Else
		
		aadd(oHtml:ValByName("op1.OP")		, "")
		aadd(oHtml:ValByName("op1.Prod")	, "")
		aadd(oHtml:ValByName("op1.Ini")		, "")
		aadd(oHtml:ValByName("op1.QtdOp")	, "")
		aadd(oHtml:ValByName("op2.OP")		, "")
		aadd(oHtml:ValByName("op2.Prod")	, "")
		aadd(oHtml:ValByName("op2.Ini")		, "")
		aadd(oHtml:ValByName("op2.QtdOp")	, "")
		aadd(oHtml:ValByName("op3.OP")		, "")
		aadd(oHtml:ValByName("op3.Prod")	, "")
		aadd(oHtml:ValByName("op3.Ini")		, "")
		aadd(oHtml:ValByName("op3.QtdOp")	, "")
	EndIf
	TRB1->(dbCloseArea())
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณConsumo Ultimos 12 Mesesณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	//Query busca Consumo do produto
	cQuery2 := " SELECT * "
	cQuery2 += " FROM "+RetSqlName("SB3")+" B3 "
	cQuery2 += " WHERE B3_COD 		= '"+TRB->C1_PRODUTO+"' "
	cQuery2 += " AND B3.D_E_L_E_T_ 	<> '*' "
	
	MemoWrit("COMWF002b.sql",cQuery2)
	dbUseArea(.T.,"TOPCONN", TCGenQry(,,cQuery2),"TRB2", .F., .T.)
	
	COUNT TO nRec2
	//CASO TENHA DADOS
	If nRec2 > 0
		
		dbSelectArea("TRB2")
		TRB2->(dbGoTop())
		
		cMeses := Space(5)
		nAno := YEAR(dDataBase)
		nMes := MONTH(dDataBase)
		aOrdem := {}
		
		For j := nMes To 1 Step -1 //Preenche Meses Anteriores do Ano Atual
			cMeses += aMeses[j]+"/"+Substr(Str(nAno,4),3,2)
			AADD(aOrdem,j)
		Next j
		
		nAno-- //Volta para Ano Anterior
		
		For j := 12 To nMes+1 Step -1 //Preenche Meses Finais do Ano Anterior
			cMeses += aMeses[j]+"/"+Substr(Str(nAno,4),3,2)
			AADD(aOrdem,j)
		Next j
		
		For j :=1 to 12 //Preenche as variaveis do HTML
			cVarMes := "Mes"+AllTrim(Str(j))
			oHtml:ValByName(cVarMes		, SubStr(cMeses,(j*6),6)) // Meses de Consumo
		Next j
		
		For j := 1 To Len(aOrdem)
			cMes    := StrZero(aOrdem[j],2)
			cCampos := "TRB2->B3_Q"+cMes
			oHtml:ValByName("CMes"+AllTrim(Str(j))	, TRANSFORM(&cCampos , PesqPict("SB3","B3_Q01"))) //Valor de Consumo nos Meses
		Next j
		
		oHtml:ValByName("MedC"		, TRANSFORM(TRB2->B3_MEDIA, PesqPict("SB3","B3_MEDIA",8))) //Media de Consumo
		
	Else //Caso nao tenha dados
		
		oHtml:ValByName("MedC"		, "")
		For m := 1 To 12
			oHtml:ValByName("CMes"+AllTrim(Str(m))	, "")
			oHtml:ValByName("Mes"+AllTrim(Str(m))	, "")
		Next m
	EndIf
	TRB2->(dbCloseArea())
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณUltimos Pedidos de Compra ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	oHtml:ValByName("it.NumP"			, {})
	oHtml:ValByName("it.ItemP"			, {})
	oHtml:ValByName("it.CodP"			, {})
	oHtml:ValByName("it.LjP"			, {})
	oHtml:ValByName("it.NomeP"			, {})
	oHtml:ValByName("it.QtdeP"			, {})
	oHtml:ValByName("it.UMP"			, {})
	oHtml:ValByName("it.VlrUnP"			, {})
	oHtml:ValByName("it.VlrTotP"		, {})
	oHtml:ValByName("it.EmiP"			, {})
	oHtml:ValByName("it.NecP"			, {})
	oHtml:ValByName("it.PraP"			, {})
	oHtml:ValByName("it.CondP"			, {})
	oHtml:ValByName("it.QtdeEntP"		, {})
	oHtml:ValByName("it.SalP"			, {})
	oHtml:ValByName("it.EliP"			, {})
	
	//Query busca Pedidos do Produto
	cQuery3 := " SELECT * " //C1_NUM, C1_ITEM, C1_FORNECE, C1_LOJA, A2_NOME, C1_QUANT, C1_UM, C1_PRECO, C1_TOTAL, C1_EMISSAO, C1_DATPRF, C1_COND, C1_QUJE, C1_RESIDUO"
	cQuery3 += " FROM "+RetSqlName("SC1")+" C1, " +RetSqlName("SA2")+" A2 "
	cQuery3 += " WHERE C1_FILIAL 	= '"+TRB->C1_FILIAL+"' "
	cQuery3 += " AND A2_COD 		= C1_FORNECE "
	cQuery3 += " AND A2_LOJA 		= C1_LOJA "
	cQuery3 += " AND C1_PRODUTO		= '"+TRB->C1_PRODUTO+"' "
	cQuery3 += " AND C1.D_E_L_E_T_ 	<> '*' "
	cQuery3 += " AND A2.D_E_L_E_T_ 	<> '*' "
	cQuery3 += " AND ROWNUM <= 5 "
	cQuery3 += " ORDER BY C1_EMISSAO DESC "
	
	MemoWrit("COMWF002c.sql",cQuery3)
	dbUseArea(.T.,"TOPCONN", TCGenQry(,,cQuery3),"TRB3", .F., .T.)
	
	TcSetField("TRB3","C1_EMISSAO","D")
	TcSetField("TRB3","C1_DATPRF","D")
	
	COUNT TO nRec3
	//CASO TENHA DADOS
	If nRec3 > 0
		
		dbSelectArea("TRB3")
		TRB3->(dbGoTop())
		
		nContador := 0
		
		While !TRB3->(EOF())
			
			nContador++
			If nContador > 03 //Numero de Pedidos
				Exit
			EndIf
			
			aadd(oHtml:ValByName("it.NumP")			, TRB3->C1_NUM		)
			aadd(oHtml:ValByName("it.ItemP")		, TRB3->C1_ITEM		)
			aadd(oHtml:ValByName("it.CodP")			, TRB3->C1_FORNECE	)
			aadd(oHtml:ValByName("it.LjP")			, TRB3->C1_LOJA		)
			aadd(oHtml:ValByName("it.NomeP")		, TRB3->A2_NOME		)
			aadd(oHtml:ValByName("it.QtdeP")		, TRANSFORM(TRB3->C1_QUANT , PesqPict("SC1","C1_QUANT",14))	)
			aadd(oHtml:ValByName("it.UMP")			, TRB3->C1_UM		)
			aadd(oHtml:ValByName("it.VlrUnP")		, TRANSFORM(TRB3->C1_PRECO, PesqPict("SC1","C1_preco",14))	)
			aadd(oHtml:ValByName("it.VlrTotP")		, TRANSFORM(TRB3->C1_TOTAL, PesqPict("SC1","C1_total",14))	)
			aadd(oHtml:ValByName("it.EmiP")			, DTOC(TRB3->C1_EMISSAO))
			aadd(oHtml:ValByName("it.NecP")			, DTOC(TRB3->C1_DATPRF)	)
			aadd(oHtml:ValByName("it.PraP")			, TRANSFORM(Val(DTOC(TRB3->C1_DATPRF))-Val(DTOC(TRB3->C1_EMISSAO)), "999"))
			aadd(oHtml:ValByName("it.CondP")		, " "		)
			aadd(oHtml:ValByName("it.QtdeEntP")		, TRANSFORM(TRB3->C1_QUJE, PesqPict("SC1","C1_QUJE",14))		)
			aadd(oHtml:ValByName("it.SalP")			, TRANSFORM(If(Empty(TRB3->C1_RESIDUO),TRB3->C1_QUANT-TRB3->C1_QUJE,0), PesqPict("SC1","C1_QUJE",14)))
			aadd(oHtml:ValByName("it.EliP")			, If(Empty(TRB3->C1_RESIDUO),'Nใo','Sim'))
			
			TRB3->(dbSkip())
		End
		
	Else //Caso nao tenha dados
		
		aadd(oHtml:ValByName("it.NumP")			, "")
		aadd(oHtml:ValByName("it.ItemP")		, "")
		aadd(oHtml:ValByName("it.CodP")			, "")
		aadd(oHtml:ValByName("it.LjP")			, "")
		aadd(oHtml:ValByName("it.NomeP")		, "")
		aadd(oHtml:ValByName("it.QtdeP")		, "")
		aadd(oHtml:ValByName("it.UMP")			, "")
		aadd(oHtml:ValByName("it.VlrUnP")		, "")
		aadd(oHtml:ValByName("it.VlrTotP")		, "")
		aadd(oHtml:ValByName("it.EmiP")			, "")
		aadd(oHtml:ValByName("it.NecP")			, "")
		aadd(oHtml:ValByName("it.PraP")			, "")
		aadd(oHtml:ValByName("it.CondP")		, "")
		aadd(oHtml:ValByName("it.QtdeEntP")		, "")
		aadd(oHtml:ValByName("it.SalP")			, "")
		aadd(oHtml:ValByName("it.EliP")			, "")
		
	EndIf
	TRB3->(dbCloseArea())
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณUltimos Fornecedoresณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	
	oHtml:ValByName("it1.CodF"			, {})
	oHtml:ValByName("it1.LjF"			, {})
	oHtml:ValByName("it1.NomeF"			, {})
	oHtml:ValByName("it1.TelF"			, {})
	oHtml:ValByName("it1.ContF"			, {})
	oHtml:ValByName("it1.FaxF"			, {})
	oHtml:ValByName("it1.UlComF"		, {})
	oHtml:ValByName("it1.MunicF"		, {})
	oHtml:ValByName("it1.UFF"			, {})
	oHtml:ValByName("it1.RisF"			, {})
	oHtml:ValByName("it1.CodForF"		, {})
	
	If mv_par03 == 1 // Amarracao por Produto
		
		//Query busca Fornecedores do Produto
		cQuery4 := " SELECT A5_FORNECE, A5_LOJA, A2_NOME, A2_TEL, A2_CONTATO, A2_FAX, A2_ULTCOM, A2_MUN, A2_EST, A2_RISCO, A5_CODPRF"
		cQuery4 += " FROM "+RetSqlName("SA5")+" A5, "+RetSqlName("SA2")+" A2 "
		cQuery4 += " WHERE A5_PRODUTO 	= '"+TRB->C1_PRODUTO+"'"
		cQuery4 += " AND A5_FORNECE 	= A2_COD "
		cQuery4 += " AND A5_LOJA 		= A2_LOJA "
		cQuery4 += " AND A5.D_E_L_E_T_ 	<> '*'"
		cQuery4 += " AND A2.D_E_L_E_T_ 	<> '*'"
		cQuery4 += " order by  A2_ULTCOM DESC"
		
		MemoWrit("COMWF002d.sql",cQuery4)
		dbUseArea(.T.,"TOPCONN", TCGenQry(,,cQuery4),"TRB4", .F., .T.)
		
		TcSetField("TRB4","A2_ULTCOM","D")
		
		COUNT TO nRec4
		//CASO TENHA DADOS
		If nRec4 > 0
			
			dbSelectArea("TRB4")
			TRB4->(dbGoTop())
			
			nContador := 0
			
			While !TRB4->(EOF())
				
				nContador++
				If nContador > 03 //Numero de Fornecedores
					Exit
				EndIf
				
				aadd(oHtml:ValByName("it1.CodF")		, TRB4->A5_FORNECE	) //Codigo do Fornecedor
				aadd(oHtml:ValByName("it1.LjF")			, TRB4->A5_LOJA		) //Codigo da Loja
				aadd(oHtml:ValByName("it1.NomeF")		, TRB4->A2_NOME		) //Nome do Fornecedor
				aadd(oHtml:ValByName("it1.TelF")		, TRB4->A2_TEL		) //Telefone do Fornecedor
				aadd(oHtml:ValByName("it1.ContF")		, TRB4->A2_CONTATO	) //Contato no Fornecedor
				aadd(oHtml:ValByName("it1.FaxF")		, TRB4->A2_FAX		) //Fax no Fornecedor
				aadd(oHtml:ValByName("it1.UlComF")		, DTOC(TRB4->A2_ULTCOM)	) //Ultima Compra com o Fornecedor
				aadd(oHtml:ValByName("it1.MunicF")		, TRB4->A2_MUN		) //Municipio do Fornecedor
				aadd(oHtml:ValByName("it1.UFF")			, TRB4->A2_EST		) //Estado do Fornecedor
				aadd(oHtml:ValByName("it1.RisF")		, TRB4->A2_RISCO	) //Risco do Fornecedor
				aadd(oHtml:ValByName("it1.CodForF")		, TRB4->A5_CODPRF	) //Codigo no Forncedor
				
				TRB4->(dbSkip())
			End
			
		Else //Caso nao tenha dados
			
			aadd(oHtml:ValByName("it1.CodF")		, ""	) //Codigo do Fornecedor
			aadd(oHtml:ValByName("it1.LjF")			, ""	) //Codigo da Loja
			aadd(oHtml:ValByName("it1.NomeF")		, ""	) //Nome do Fornecedor
			aadd(oHtml:ValByName("it1.TelF")		, ""	) //Telefone do Fornecedor
			aadd(oHtml:ValByName("it1.ContF")		, ""	) //Contato no Fornecedor
			aadd(oHtml:ValByName("it1.FaxF")		, ""	) //Fax no Fornecedor
			aadd(oHtml:ValByName("it1.UlComF")		, ""	) //Ultima Compra com o Fornecedor
			aadd(oHtml:ValByName("it1.MunicF")		, ""	) //Municipio do Fornecedor
			aadd(oHtml:ValByName("it1.UFF")			, ""	) //Estado do Fornecedor
			aadd(oHtml:ValByName("it1.RisF")		, ""	) //Risco do Fornecedor
			aadd(oHtml:ValByName("it1.CodForF")		, ""	) //Codigo no Forncedor
			
		EndIf
		TRB4->(dbCloseArea())
		
	Else
		
		//Query busca Fornecedores do Grupo de Produtos
		cQuery4 := " SELECT AD_FORNECE, AD_LOJA, A2_NOME, A2_TEL, A2_CONTATO, A2_FAX, A2_ULTCOM, A2_MUN, A2_EST, A2_RISCO"
		cQuery4 += " FROM "+RetSqlName("SB1")+" B1, "+RetSqlName("SAD")+" AD, "+RetSqlName("SA2")+" A2 "
		cQuery4 += " WHERE B1_COD 		= '"+TRB->C1_PRODUTO+"' "
		cQuery4 += " AND B1_GRUPO 		= AD_GRUPO "
		cQuery4 += " AND AD_FORNECE 	= A2_COD "
		cQuery4 += " AND AD_LOJA 		= A2_LOJA "
		cQuery4 += " AND AD.D_E_L_E_T_ 	<> '*'"
		cQuery4 += " AND A2.D_E_L_E_T_ 	<> '*'"
		cQuery4 += " AND B1.D_E_L_E_T_ 	<> '*'"
		cQuery4 += " ORDER BY  A2_ULTCOM DESC"
		
		MemoWrit("COMWF002d.sql",cQuery4)
		dbUseArea(.T.,"TOPCONN", TCGenQry(,,cQuery4),"TRB4", .F., .T.)
		
		TcSetField("TRB4","A2_ULTCOM","D")
		
		COUNT TO nRec4
		//CASO TENHA DADOS
		If nRec4 > 0
			
			dbSelectArea("TRB4")
			TRB4->(dbGoTop())
			
			nContador := 0
			
			While !TRB4->(EOF())
				
				nContador++
				If nContador > 03 //Numero de Fornecedores
					Exit
				EndIf
				
				aadd(oHtml:ValByName("it1.CodF")		, TRB4->AD_FORNECE	) 		//Codigo do Fornecedor
				aadd(oHtml:ValByName("it1.LjF")			, TRB4->AD_LOJA		) 		//Codigo da Loja
				aadd(oHtml:ValByName("it1.NomeF")		, TRB4->A2_NOME		) 		//Nome do Fornecedor
				aadd(oHtml:ValByName("it1.TelF")		, TRB4->A2_TEL		) 		//Telefone do Fornecedor
				aadd(oHtml:ValByName("it1.ContF")		, TRB4->A2_CONTATO	) 		//Contato no Fornecedor
				aadd(oHtml:ValByName("it1.FaxF")		, TRB4->A2_FAX		) 		//Fax no Fornecedor
				aadd(oHtml:ValByName("it1.UlComF")		, DTOC(TRB4->A2_ULTCOM)	) 	//Ultima Compra com o Fornecedor
				aadd(oHtml:ValByName("it1.MunicF")		, TRB4->A2_MUN		) 		//Municipio do Fornecedor
				aadd(oHtml:ValByName("it1.UFF")			, TRB4->A2_EST		) 		//Estado do Fornecedor
				aadd(oHtml:ValByName("it1.RisF")		, TRB4->A2_RISCO	) 		//Risco do Fornecedor
				aadd(oHtml:ValByName("it1.CodForF")		, ""				) 		//Codigo no Forncedor
				TRB4->(dbSkip())
			End
			
		Else //Caso nao tenha dados
			
			aadd(oHtml:ValByName("it1.CodF")		, ""	) //Codigo do Fornecedor
			aadd(oHtml:ValByName("it1.LjF")			, ""	) //Codigo da Loja
			aadd(oHtml:ValByName("it1.NomeF")		, ""	) //Nome do Fornecedor
			aadd(oHtml:ValByName("it1.TelF")		, ""	) //Telefone do Fornecedor
			aadd(oHtml:ValByName("it1.ContF")		, ""	) //Contato no Fornecedor
			aadd(oHtml:ValByName("it1.FaxF")		, ""	) //Fax no Fornecedor
			aadd(oHtml:ValByName("it1.UlComF")		, ""	) //Ultima Compra com o Fornecedor
			aadd(oHtml:ValByName("it1.MunicF")		, ""	) //Municipio do Fornecedor
			aadd(oHtml:ValByName("it1.UFF")			, ""	) //Estado do Fornecedor
			aadd(oHtml:ValByName("it1.RisF")		, ""	) //Risco do Fornecedor
			aadd(oHtml:ValByName("it1.CodForF")		, ""	) //Codigo no Forncedor
			
		EndIf
		TRB4->(dbCloseArea())
		
	EndIf
	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณFuncoes para Envio do Workflowณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	//envia o e-mail
	cUser 			  := Subs(cUsuario,7,15)
	oProcess:ClientName(cUser)
	oProcess:cTo	  := cMailSup
	oProcess:cBCC     := cCopia
	oProcess:cSubject := "Aprova็ใo de SC Nฐ: "+cNumSc+" Item: "+cItem+" - De: "+cSolicit
	oProcess:cBody    := ""
	oProcess:bReturn  := "U_COMWF02a()"
	//oProcess:bTimeOut := {{"U_COMWF02b()", Val(cDiasA) , 0, 0 },{"U_COMWF02c()", Val(cDiasE) , 0, 0 }}
	oProcess:bTimeOut := {{"U_COMWF02b()",0, 0, 05 },{"U_COMWF02c()",0, 0, 10 }}
	oProcess:Start()
	//RastreiaWF( ID do Processo, Codigo do Processo, Codigo do Status, Descricao Especifica, Usuario )
	RastreiaWF(oProcess:fProcessID+'.'+oProcess:fTaskID,"000004","1001","ENVIO DE WORKFLOW PARA APROVACAO DE SC",cUsername)
	oProcess:Free()
	oProcess:= Nil
	
	PutMv("MV_WFHTML",cMvAtt)
	
Else
	MsgStop("Foi encontrado um problema na Gera็ใo do E-Mail de Aprova็ใo. Favor avisar o Depto de Informแtica. NREC =","ATENวรO!")
EndIf

TRB->(dbCloseArea())

// FUNCAO ACIMA NAO ESTA EM USO

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCOMWF02a  บAutor  ณTHIAGO QUEIROZ      บ Data ณ  26/09/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Retor Workflow de Aprovacao de Solicitacao de Compras      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ 		                                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function COMWF02a(oProcess)

Local cMvAtt 	:= GetMv("MV_WFHTML")
//Local cNumSc	:= oProcess:oHtml:RetByName("Num")
//Local cItemSc	:= oProcess:oHtml:RetByName("Item")
//Local cSolicit	:= oProcess:oHtml:RetByName("Req")
//Local cEmissao	:= oProcess:oHtml:RetByName("Emissao")
Local cDiasA	:= oProcess:oHtml:RetByName("diasA")
Local cDiasE	:= oProcess:oHtml:RetByName("diasE")
//Local cCod		:= oProcess:oHtml:RetByName("CodProd")
//Local cDesc		:= oProcess:oHtml:RetByName("Desc")
Local cAprov	:= oProcess:oHtml:RetByName("cAPROV")
//Local cMotivo	:= oProcess:oHtml:RetByName("cMOTIVO")

Private oHtml

ConOut("Enviando email de Aprovacao/Rejeicao da :"+cNumSc)
/*
cQuery := " UPDATE SC1010"
cQuery += " SET C1_APROV = '"+cAprov+"'"
cQuery += " WHERE C1_NUM = '"+cNumSc+"'"
cQuery += " AND C1_ITEM = '"+cItemSc+"'"

MemoWrit("COMWF02a.sql",cQuery)
TcSqlExec(cQuery)
TCREFRESH(RetSqlName("SC1"))
*/
//RastreiaWF( ID do Processo, Codigo do Processo, Codigo do Status, Descricao Especifica, Usuario )
RastreiaWF(oProcess:fProcessID+'.'+oProcess:fTaskID,"000004",'1002',"RETOR DE WORKFLOW PARA APROVACAO DE SC",cUsername)

oProcess:Finish()
oProcess:Free()
oProcess:= Nil

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณInicia Envio de Mensagem de Avisoณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
PutMv("MV_WFHTML","T")

oProcess:=TWFProcess():New("000004","WORKFLOW PARA APROVACAO DE SC")
If cAprov == "L" //Verifica se foi aprovado
	oProcess:NewTask('Inicio',"\workflow\HTML\COMWF005.htm")
ElseIf cAprov == "R" //Verifica se foi rejeitado
	oProcess:NewTask('Inicio',"\workflow\HTML\COMWF006.htm")
EndIf

oHtml   := oProcess:oHtml

oHtml:valbyname("Num"				, cNumSc)
oHtml:valbyname("Req"    			, cSolicit)
oHtml:valbyname("Emissao"  			, cEmissao)
oHtml:valbyname("Motivo"   			, cMotivo)
oHtml:valbyname("it.Item"   		, {})
oHtml:valbyname("it.Cod"  			, {})
oHtml:valbyname("it.Desc"   		, {})
oHtml:valbyname("it.Obs "   		, {})

dbSelectArea("SC1")
dbSetOrder(1)
dbSeek(xFilial("SC1")+cNumSC)

cMailSol	:= UsrRetMail(SC1->C1_USER)
cMailSup 	:= UsrRetMail(GETADVFVAL("SAI","AI_NCSUPER",XFILIAL("SAI")+SC1->C1_USER,2,SPACE(06)))
conout("REJEICAO SC - fez a busca na SC1 com a chave - "+ xFilial("SC1")+cNumSC)
While !EOF() .AND. SC1->C1_NUM == cNumSC
	conout("REJEICAO SC - entrou no WHILE para preencher os produtos")
	aadd(oHtml:ValByName("it.Item")			,SC1->C1_ITEM			) 			//Item Cotacao
	aadd(oHtml:ValByName("it.Cod")			,SC1->C1_PRODUTO		) 			//Cod Produto
	aadd(oHtml:ValByName("it.Desc")			,SC1->C1_DESCRI			) 			//Descricao Produto
	aadd(oHtml:ValByName("it.Obs")			,SC1->C1_OBS			) 			//Observa็ใo Produto
	dbSelectArea("SC1")
	dbSkip()
EndDO

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณFuncoes para Envio do Workflowณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
//envia o e-mail

cMailSup := ""

IF SELECT("TRBSC1") > 0
	dbSelectArea("TRBSC1")
	dbCloseArea()
ENDIF

cQuery := " SELECT ZI_USER, ZI_NOMEUSR, ZI.*
cQuery += " FROM "+RetSqlName("SZI")+" ZI "
cQuery += " WHERE ZI_ROTINA 	= 'SC1'
cQuery += " AND ZI_FILIAL		= '"+XFILIAL("SZI")+"'"
cQuery += " AND ZI_DOC 			= '"+cNumSC+"'"
cQuery += " AND ZI.D_E_L_E_T_  != '*'

MemoWrit("COMRD003AR.sql",cQuery)
dbUseArea(.T.,"TOPCONN", TCGenQry(,,cQuery),"TRBSC1", .F., .T.)

WHILE !EOF() .AND. TRBSC1->ZI_DOC == cNumSC
	
	//IF AT(ALLTRIM(cMailSup), ALLTRIM(UsrRetMail(TRBSC1->ZI_USER))) == 0
	IF !(ALLTRIM(UsrRetMail(TRBSC1->ZI_USER)) $ ALLTRIM(cMailSup))
		
		cMailSup += ALLTRIM(UsrRetMail(TRBSC1->ZI_USER))+";"
				
	ENDIF
	
	//UsrRetMail(SC7->C7_USRAPRO)
	
	dbSelectArea("TRBSC1")
	DBSKIP()
ENDDO

cUser 			  		:= Subs(cUsuario,7,15)
oProcess:ClientName(cUser)
IF !EMPTY(ALLTRIM(cMailSup))
	oProcess:cTo	  	:= cMailSup+cMailSol //cMailSup+";"+cMailSol
ELSE
	oProcess:cTo	  	:= "soliveira@ncgames.com.br"
ENDIF
oProcess:cBCC     		:= 'thiago@stch.com.br;soliveira@ncgames.com.br' //cCopia

If cAprov == "L" //Verifica se foi aprovado
	oProcess:cSubject := "SC Nฐ: "+cNumSc+" - Aprovada "//+cItemSc+" - Aprovada"
ElseIf cAprov == "R" //Verifica se foi rejeitado
	oProcess:cSubject := "SC Nฐ: "+cNumSc+" - Reprovada "//+cItemSc+" - Reprovada"
EndIf

oProcess:cBody    := ""
oProcess:bReturn  := ""
oProcess:Start()

/*
//RastreiaWF( ID do Processo, Codigo do Processo, Codigo do Status, Descricao Especifica, Usuario )
If cAprov == "L" //Verifica se foi aprovado
RastreiaWF(oProcess:fProcessID+'.'+oProcess:fTaskID,"000004",'1005',"TIMEOUT DE WORKFLOW PARA APROVACAO DE SC",cUsername)
ElseIf cAprov == "R" //Verifica se foi rejeitado
RastreiaWF(oProcess:fProcessID+'.'+oProcess:fTaskID,"000004",'1006',"TIMEOUT DE WORKFLOW PARA APROVACAO DE SC",cUsername)
EndIf
*/

oProcess:Free()
oProcess:Finish()
oProcess:= Nil

PutMv("MV_WFHTML",cMvAtt)

//WFSendMail({"01","03"})

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCOMWF02b  บAutor  ณTHIAGO QUEIROZ      บ Data ณ  26/09/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Envia um Aviso para Aprovador apos periodo de TIMEOUT      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ 		                                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function COMWF02b(oProcess)

Local cMvAtt 	:= GetMv("MV_WFHTML")
Local cNumSc	:= oProcess:oHtml:RetByName("Num")
Local cItemSc	:= oProcess:oHtml:RetByName("Item")
Local cSolicit	:= oProcess:oHtml:RetByName("Req")
Local cEmissao	:= oProcess:oHtml:RetByName("Emissao")
Local cDiasA	:= oProcess:oHtml:RetByName("diasA")
Local cDiasE	:= oProcess:oHtml:RetByName("diasE")
Local cCod		:= oProcess:oHtml:RetByName("CodProd")
Local cDesc		:= oProcess:oHtml:RetByName("Desc")
Local cObs		:= oProcess:oHtml:RetByName("Obs")
Private oHtml

ConOut("AVISO POR TIMEOUT SC:"+cNumSc+" Item:"+cItemSc+" Solicitante:"+cSolicit)

oProcess:Free()
oProcess:= Nil

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณInicia Envio de Mensagem de Avisoณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
PutMv("MV_WFHTML","T")

oProcess:=TWFProcess():New("000004","WORKFLOW PARA APROVACAO DE SC")
oProcess:NewTask('Inicio',"\workflow\HTML\COMWF003.htm")
oHtml   := oProcess:oHtml

oHtml:valbyname("Num"				, cNumSc)
oHtml:valbyname("Req"    			, cSolicit)
oHtml:valbyname("Emissao"   		, cEmissao)
oHtml:valbyname("diasA"   			, cDiasA)
oHtml:valbyname("diasE"   			, Val(cDiasE)-Val(cDiasA))
oHtml:valbyname("it.Item"   		, {})
oHtml:valbyname("it.Cod"  			, {})
oHtml:valbyname("it.Desc"   		, {})
oHtml:valbyname("it.Obs "   		, {})

dbSelectArea("SC1")
dbSetOrder(1)
dbSeek(xFilial("SC1")+cNumSC)

cMailSup		:= UsrRetMail(SC1->C1_USER)
//cMailSup 		:= UsrRetMail(GETADVFVAL("SAI","AI_NCSUPER",XFILIAL("SAI")+SC1->C1_USER,2,SPACE(06)))
cCopia			:= "thiago@stch.com.br;soliveira@ncgames.com.br"

conout("Solicitacao de compra nao respondida > Chave - "+ xFilial("SC1")+cNumSC)
While !EOF() .AND. SC1->C1_NUM == cNumSC
	conout("SC nao respondida > entrou no WHILE para preencher os produtos")
	aadd(oHtml:ValByName("it.Item")			,SC1->C1_ITEM			) 			//Item Cotacao
	aadd(oHtml:ValByName("it.Cod")			,SC1->C1_PRODUTO		) 			//Cod Produto
	aadd(oHtml:ValByName("it.Desc")			,SC1->C1_DESCRI			) 			//Descricao Produto
	aadd(oHtml:ValByName("it.Obs")			,SC1->C1_OBS			) 			//Observa็ใo Produto
	dbSelectArea("SC1")
	dbSkip()
EndDO

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณFuncoes para Envio do Workflowณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

//envia o e-mail
cUser 			  := Subs(cUsuario,7,15)
oProcess:ClientName(cUser)
oProcess:cTo	  := cMailSup
oProcess:cBCC     := cCopia
oProcess:cSubject := "Aviso de TimeOut de SC Nฐ: "+cNumSc+" Item: "+cItemSc+" - De: "+cSolicit
oProcess:cBody    := ""
oProcess:bReturn  := ""
oProcess:Start()
//RastreiaWF( ID do Processo, Codigo do Processo, Codigo do Status, Descricao Especifica, Usuario )
RastreiaWF(oProcess:fProcessID+'.'+oProcess:fTaskID,"000004",'1003',"TIMEOUT DE WORKFLOW PARA APROVACAO DE SC",cUsername)
oProcess:Free()
oProcess:Finish()
oProcess:= Nil

PutMv("MV_WFHTML",cMvAtt)

//WFSendMail({"01","03"})

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCOMWF02c  บAutor  ณTHIAGO QUEIROZ      บ Data ณ  26/09/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Exclui a solicitacao apos um periodo de TIMEOUT            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ 		                                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function COMWF02c(oProcess)

Local cMvAtt 	:= GetMv("MV_WFHTML")
Local cNumSc	:= oProcess:oHtml:RetByName("Num")
Local cItemSc	:= oProcess:oHtml:RetByName("Item")
Local cSolicit	:= oProcess:oHtml:RetByName("Req")
Local cEmissao	:= oProcess:oHtml:RetByName("Emissao")
Local cDiasE	:= oProcess:oHtml:RetByName("diasE")
Local cCod		:= oProcess:oHtml:RetByName("CodProd")
Local cDesc		:= oProcess:oHtml:RetByName("Desc")
Local cCodSol	:= RetCodUsr(cSolicit)
Local cMailSup	:= ""//"thiago@stch.com.br"
Local cMailSol 	:= UsrRetMail(cCodSol)
Local cCopia 	:= "thiago@stch.com.br;soliveira@ncgames.com.br"
Private oHtml

ConOut("EXCLUSAO POR TIMEOUT SC:"+cNumSc+" Item:"+cItemSc+" Solicitante:"+cSolicit)

cQuery := " UPDATE SC1010 "
cQuery += " SET D_E_L_E_T_ = '*' "
cQuery += " WHERE C1_NUM = '"+cNumSc+"' "
cQuery += " AND C1_ITEM = '"+cItemSc+"' "

MemoWrit("COMWF02c.sql",cQuery)
TcSqlExec(cQuery)
TCREFRESH(RetSqlName("SC1"))

oProcess:Finish()
oProcess:Free()
oProcess:= Nil

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณInicia Envio de Mensagem de Avisoณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
PutMv("MV_WFHTML","T")

oProcess	:=TWFProcess():New("000004","WORKFLOW PARA APROVACAO DE SC")
oProcess:NewTask('Inicio',"\workflow\HTML\COMWF004.htm")
oHtml   	:= oProcess:oHtml

oHtml:valbyname("Num"				, cNumSc)
oHtml:valbyname("Req"    			, cSolicit)
oHtml:valbyname("Emissao"   		, cEmissao)
oHtml:valbyname("diasE"				, cDiasE)
oHtml:valbyname("it.Item"   		, {})
oHtml:valbyname("it.Cod"  			, {})
oHtml:valbyname("it.Desc"   		, {})
oHtml:valbyname("it.Obs "   		, {})

dbSelectArea("SC1")
dbSetOrder(1)
dbSeek(xFilial("SC1")+cNumSC)


cMailSup		:= "" //UsrRetMail(SC1->C1_USER)
//cMailSup 		:= UsrRetMail(GETADVFVAL("SAI","AI_NCSUPER",XFILIAL("SAI")+SC1->C1_USER,2,SPACE(06)))

conout("REJEICAO SC - fez a busca na SC1 com a chave - "+ xFilial("SC1")+cNumSC)
While !EOF() .AND. SC1->C1_NUM == cNumSC
	conout("REJEICAO SC - entrou no WHILE para preencher os produtos")
	aadd(oHtml:ValByName("it.Item")			,SC1->C1_ITEM			) 			//Item Cotacao
	aadd(oHtml:ValByName("it.Cod")			,SC1->C1_PRODUTO		) 			//Cod Produto
	aadd(oHtml:ValByName("it.Desc")			,SC1->C1_DESCRI			) 			//Descricao Produto
	aadd(oHtml:ValByName("it.Obs")			,SC1->C1_OBS			) 			//Observa็ใo Produto
	dbSelectArea("SC1")
	dbSkip()
EndDO

IF SELECT("TRBSC1") > 0
	dbSelectArea("TRBSC1")
	dbCloseArea()
ENDIF

cQuery := " SELECT ZI_USER, ZI_NOMEUSR, ZI.*
cQuery += " FROM "+RetSqlName("SZI")+" ZI "
cQuery += " WHERE ZI_ROTINA 	= 'SC1'
cQuery += " AND ZI_FILIAL		= '"+XFILIAL("SZI")+"'"
cQuery += " AND ZI_DOC 			= '"+cNumSC+"'"
cQuery += " AND ZI.D_E_L_E_T_  != '*'

MemoWrit("COMRD003TO.sql",cQuery)
dbUseArea(.T.,"TOPCONN", TCGenQry(,,cQuery),"TRBSC1", .F., .T.)

WHILE !EOF() .AND. TRBSC1->ZI_DOC == cNumSC
	
	//IF AT(ALLTRIM(cMailSup), ALLTRIM(UsrRetMail(TRBSC1->ZI_USER))) == 0
	IF !(ALLTRIM(UsrRetMail(TRBSC1->ZI_USER)) $ ALLTRIM(cMailSup))
		
		cMailSup += ALLTRIM(UsrRetMail(TRBSC1->ZI_USER))+";"
		
	ENDIF
	
	//UsrRetMail(SC7->C7_USRAPRO)
	
	dbSelectArea("TRBSC1")
	DBSKIP()
ENDDO


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณFuncoes para Envio do Workflowณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

//envia o e-mail
cUser 			  	:= Subs(cUsuario,7,15)
oProcess:ClientName(cUser)
oProcess:cTo	  	:= cMailSup//+";"+cMailSol
oProcess:cBCC     	:= cCopia
oProcess:cSubject 	:= "Exclusใo por TimeOut - SC Nฐ: "+cNumSc+" Item: "+cItemSc+" - De: "+cSolicit
oProcess:cBody    	:= ""
oProcess:bReturn  	:= ""
oProcess:Start()
//RastreiaWF( ID do Processo, Codigo do Processo, Codigo do Status, Descricao Especifica, Usuario )
RastreiaWF(oProcess:fProcessID+'.'+oProcess:fTaskID,"000004",'1004',"TIMEOUT EXCLUSAO DE WORKFLOW PARA APROVACAO DE SC",cUsername)
oProcess:Free()
oProcess:Finish()
oProcess			:= Nil

PutMv("MV_WFHTML",cMvAtt)

//WFSendMail({"01","03"})

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCOMWF02d  บAutor  ณTHIAGO QUEIROZ      บ Data ณ  07/12/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Notificacao por email para SC com valor menor ou igual     บฑฑ
ฑฑบ          ณ a 1500,00 controlado pelo parametro MV_NCVLRSC             บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ 		                                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function COMWF02d(cNumSC)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณDeclara็ใo de Variaveisณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Local cMvAtt 	:= GetMv("MV_WFHTML")
Local _cEMails	:= "" //EMAILS
Local cMailSup	:= ""
Local cCopia 	:= "thiago@stch.com.br;soliveira@ncgames.com.br"
Local nVlrTotSC	:= 0
Local nI		:= 1

Private oHtml

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณMuda o parametro para enviar no corpo do e-mailณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
PutMv("MV_WFHTML","T") // MANDA O HTML NO CORPO DO EMAIL


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณInicia Envio de Mensagem de Avisoณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
oProcess		:= TWFProcess():New("000004","WORKFLOW PARA NOTIFICACAO DE SC")
oProcess:NewTask('Inicio',"\WORKFLOW\HTML\COMWF005.htm")
oHtml   		:= oProcess:oHtml

ConOut("AVISO DE NOTIFICACAO DE SC:"+cNumSc) //+" Item:"+cItemSc+" Solicitante:"+cSolicit)

dbSelectArea("SC1")
dbSetOrder(1)
dbSeek(xFilial("SC1")+cNumSC)

oHtml:valbyname("Num"				, cNumSc					)
oHtml:valbyname("Req"    			, SC1->C1_SOLICIT			)
oHtml:valbyname("Emissao"   		, DTOC(SC1->C1_EMISSAO)		)
//oHtml:ValByName("Motivo"			,"A Solicita็ใo de Compras Nฐ " +cNumSC+" foi aprovada com valor menor ou igual a 1500,00. <br>"+;
//" Com o valor de: "+TRANSFORM( nVlrTotSC,'@E 999,999.99' )			)

//oHtml:valbyname("diasA"   		, cDiasA					)
//oHtml:valbyname("diasE"   		, Val(cDiasE)-Val(cDiasA)	)
oHtml:valbyname("it.Item"   		, {}						)
oHtml:valbyname("it.Cod"  			, {}						)
oHtml:valbyname("it.Desc"   		, {}						)
oHtml:valbyname("it.Obs"    		, {}						)

dbSelectArea("SC1")
dbSetOrder(1)
dbSeek(xFilial("SC1")+cNumSC)

IF !EMPTY(ALLTRIM(SC1->C1_USRAPRO))
	cMailSup 	:= UsrRetMail(SC1->C1_USRAPRO)
	cAprov 		:= SC1->C1_USRAPRO
ELSE
	cMailSup 	:= UsrRetMail(GETADVFVAL("SAI","AI_NCSUPER",XFILIAL("SAI")+SC1->C1_USER,2,SPACE(06))) // SAI - SOLICITANTES
	cAprov 		:= GETADVFVAL("SAI","AI_NCSUPER",XFILIAL("SAI")+SC1->C1_USER,2,SPACE(06)) 				// SAI - SOLICITANTES
ENDIF

WHILE ALLTRIM(cAprov) != "CAPROV"
	dbSelectArea("SAI")
	dbSetOrder(2)
	IF dbSeek(XFILIAL("SAI")+cAprov)
		
		IF !EMPTY(SAI->AI_NCSUPER)
			cMailSup 	+= ";"+UsrRetMail(SAI->AI_NCSUPER)
			cAprov		:= SAI->AI_NCSUPER
		ELSE
			cAprov		:= "CAPROV"
		ENDIF
	ELSE
		cAprov		:= "CAPROV"
	ENDIF
	
	DBSELECTAREA("SAI")
	DBSKIP()
ENDDO
//cMailSup		:= "" //UsrRetMail(SC1->C1_USER)
//cMailSup 		:= UsrRetMail(GETADVFVAL("SAI","AI_NCSUPER",XFILIAL("SAI")+SC1->C1_USER,2,SPACE(06)))
cCopia 			:= "thiago@stch.com.br;soliveira@ncgames.com.br"

dbSelectArea("SC1")
dbSetOrder(1)
dbSeek(xFilial("SC1")+cNumSC)

conout("NOTIFICACAO DE APROVACAO COM VALOR MENOR DO QUE 1500 - "+ xFilial("SC1")+cNumSC)
While !EOF() .AND. SC1->C1_NUM == cNumSC
	aadd(oHtml:ValByName("it.Item")			,SC1->C1_ITEM			) 			//Item Cotacao
	aadd(oHtml:ValByName("it.Cod")			,SC1->C1_PRODUTO		) 			//Cod Produto
	aadd(oHtml:ValByName("it.Desc")			,SC1->C1_DESCRI			) 			//Descricao Produto
	aadd(oHtml:ValByName("it.OBS")			,SC1->C1_OBS			) 			//Observa็ใo Produto
	
	nVlrTotSC += (SC1->C1_QUANT - SC1->C1_QUJE) * SC1->C1_NCVLUNI
	dbSelectArea("SC1")
	dbSkip()
EndDO
oHtml:ValByName("Motivo"			,"A Solicita็ใo de Compras Nฐ " +cNumSC+" foi aprovada com valor menor ou igual a 1500,00. <br>"+;
" Com o valor de: "+TRANSFORM( nVlrTotSC,'@E 999,999.99' )			)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณFuncoes para Envio do Workflowณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

//envia o e-mail
cUser 			  := Subs(cUsuario,7,15)
oProcess:ClientName(cUser)
oProcess:cTo	  := cMailSup
oProcess:cBCC     := cCopia
oProcess:cSubject := "Workflow de Compras Indiretas - Aviso de Aprovacao de SC Nฐ: "+cNumSc+" com valor menor do que 1500,00 " //+cItemSc+" - De: "+cSolicit
oProcess:Start()
oProcess:Free()
oProcess:Finish()
oProcess:= Nil

PutMv("MV_WFHTML",cMvAtt)

//WFSendMail({"01","03"})

Return
