#include "rwmake.ch"
#include "protheus.ch"
//#include "TbiConn.ch"
//#include "TbiCode.ch"

/*
+-----------------------------------------------------------------------------+
* Programa  * W1881502   º  THIAGO QUEIROZ               * Data ³  26/09/2012 *
*-----------------------------------------------------------------------------*
* Objetivo  * Programa que envia e-mail para aprovação de um Pedido de Compra *
*           * a partir de um Ponto de Entrada chamado WFW120P.                *
*-----------------------------------------------------------------------------*
* Uso       * WorkFlow/AP5 - VideoLar                                         *
*-----------------------------------------------------------------------------+
| Starting  | Ponto de Entrada                                                |
+-----------------------------------------------------------------------------+
*/

//USER FUNCTION WFW120P( nOpcao, oProcess )
USER FUNCTION WFPCNC()

If ValType(nOpcao) = "A"
	nOpcao := nOpcao[1]
Endif

If nOpcao == NIL
	nOpcao := 0
End

cstatus := 0

If oProcess == NIL
	oProcess := TWFProcess():New( "PEDCOM", "Pedido de Compras" )
End

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("CPAR,NBARRA,N_ITEM,C_MAT,C_DEST,CGRAP")
SetPrvt("C_NUM,C_MOTIVO,N_TOTPC,CGRAPANT,N_TERMINA,N_DOHTML")
SetPrvt("CRAIZ,NRET,NHLDHTM,NHLDSCP,CIND,C_PCANT")
SetPrvt("N_QTDPC,N_FRTPC,A_ITENS,LCABEC,_AREGISTROS,NLIMITE")
SetPrvt("CAB_NUM,CAB_EMIS,CAB_FORN,CAB_COND,CAB_NOME,_NI")
SetPrvt("ARRAYCAB,ARRAYITENS,C_ITPED,NPRESUP,CAPROV,AINFO")
SetPrvt("CMAILAP,CNOMEAP,CORIGEM,CABEC,NHDLVLR,NCOUNT")
SetPrvt("NRESULT,CHTML,NHDLCONNECT")

lPrimeira := .F.
//Do Case
IF nOpcao == 0 //CASE
	//SPCIniciar( oProcess,lPrimeira,_cRecebe,_cMailLib )
	U_SPCIniciar(EMAILS,APROVADOR)
ELSEIF nOpcao == 1 //CASE
	U_SPCRetorno( oProcess,lPrimeira )
ELSEIF nOpcao == 2 //CASE
	U_SPCTimeOut( oProcess )
EndIF

oProcess:Free()
RETURN

////////////////////////////////////////////////////////////////////////////////////
// ****************************************************************************** //
////////////////////////////////////////////////////////////////////////////////////
USER FUNCTION SPCRetorno( oProcess )
Local cMvAtt		:= GetMv("MV_WFHTML")
Local lLast 		:= .T.,_oProc,nTotal

Public _cPedido   	:= oProcess:oHtml:RetByName("pedido") //SZO->ZO_NUM
Public cEmissao		:= oProcess:oHtml:RetByName("EMISSAO")
Public cAprov		:= oProcess:oHtml:RetByName("cAPROV")
Public cMotivo		:= oProcess:oHtml:RetByName("cMOTIVO")
Public cSolicit		:= oProcess:oHtml:RetByName("cSOLICIT")
Public cItemSc		:= oProcess:oHtml:RetByName("it.ITEM")
Public cCod			:= oProcess:oHtml:RetByName("it.CODIGO")
Public cDesc		:= oProcess:oHtml:RetByName("it.DESCRICAO")

Private _aArea     	:= GetArea()
Private _nVlrMin  	:= SUPERGETMV("MV_NCVLRSC")
Private cCodSol		:= oProcess:oHtml:RetByName("cCODUSR")
Private _cUserLib	:= oProcess:oHtml:RetByName("cCODAPROV") //SZO->ZO_USRAPRO
Private _cAprovad  	:= ""
Private _cNomeLib  	:= ""
Private _cMailLib  	:= ""
Private _cUsuario   := oProcess:oHtml:RetByName("cCODAPROV") // RetCodUsr()
Private _cNomeUsr   := UsrRetName(_cUsuario)
Private _lBloq     	:= .F.
Private _nValMax   	:= 0.00


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Muda o parametro para enviar no corpo do e-mail³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PutMv("MV_WFHTML","T")
//RastreiaWF(oProcess:fProcessID+'.'+oProcess:fTaskID,oProcess:fProcCode,'10002','Respondendo ao email',"BI")
ConOut('Pedido:'+oProcess:oHtml:RetByName('Pedido'))

//oProcess:oHtml:RetByName("Aprovacao") == "S"
if oProcess:oHtml:RetByName("cAPROV") == "L"
	ConOut("Aprovando o pedido de compras")
	//U_UFA120AP()
	
	dbSelectArea("SC7")
	dbSetOrder(1)
	dbSeek(xFilial("SC7")+_cPedido)
	
	dbSelectArea("SZO")
	dbSetOrder(1)
	dbSeek(xFilial("SZO")+_cPedido)
	
	CONOUT("REALIZADO BUSCA NA SC7 E SZO COM O FILTRO : " +_cPedido)
	
	cCCusto	:= GETADVFVAL("SAK","AK_CC",XFILIAL("SAK")+SZO->ZO_USRAPRO,2,SPACE(09)) 	//SZM->ZM_CC
	cCCDesc	:= GETADVFVAL("CTT","CTT_DESC01",XFILIAL("CTT")+cCCusto,1,SPACE(40))  		//SZM->ZM_DESCCC
	
	dbSelectArea("SZI")
	dbSetOrder(1)
	RecLock("SZI",.T.)
	SZI->ZI_FILIAL  := xFilial("SZI")
	SZI->ZI_ROTINA  := "SC7"
	SZI->ZI_DOC     := SZO->ZO_NUM
	SZI->ZI_STATUS  := "A"
	SZI->ZI_USER    := _cUsuario
	SZI->ZI_NOMEUSR := _cNomeUsr
	SZI->ZI_CC      := cCCusto //SZO->ZO_CC
	SZI->ZI_DESCCC  := cCCDesc //SZO->ZO_DESCCC
	SZI->ZI_DATA    := DDATABASE
	SZI->ZI_HORA    := TIME()
	MsUnLock()
	CONOUT("GRAVOU NA SZI")
	
	dbSelectArea("SAK")
	_aAreaAK := GetArea()
	dbSetOrder(2)                // AK_FILIAL+AK_USER
	If dbSeek(xFilial("SAK")+_cUserLib)
		CONOUT("ACHOU REGISTRO NA SAK - " + _cUserLib)
		_cSeqLibPC := Soma1(SAK->AK_SEQLIBP,6)
		_nValMax   := SAK->AK_LIMMAX
		dbGoTop()
		Do While !Eof()
			If AllTrim(SAK->AK_SEQLIBP) == AllTrim(_cSeqLibPC)
				If SZO->ZO_VALORT > _nValMax
					_cUserLib := SAK->AK_USER
					_cNomeLib := UsrRetName(_cUserLib)
					_cMailLib := AllTrim(UsrRetMail(_cUserLib))
					CONOUT("ENTROU NA REGRA DE VALORES E ATUALIZA O USUARIO DE LIBERACAO")
					Exit
				Else
					_cUserLib := Space(06)
					CONOUT("NAO ENTROU NA REGRA, USUARIO DE LIBERACAO RECEBE BRANCO")
				EndIf
			EndIf
			dbSkip()
		EndDo
	EndIf
	RestArea(_aAreaAK)
	
	If !Empty(_cUserLib) .And. _cUserLib != SZO->ZO_USRAPRO
		CONOUT("SE USUARIO DE LIBERACAO NAO FOR VAZIO E DIFERENTE DO ZO_USRAPRO")
		_cNomeLib := UsrRetName(_cUserLib)
		_cMailLib := AllTrim(UsrRetMail(_cUserLib))
		
		dbSelectArea("SC7")
		dbSetOrder(1)          // C1_FILIAL+C1_NUM+C1_ITEM
		dbSeek(xFilial("SC7")+_cPedido,.T.)
		Do While !Eof() .And. SC7->C7_NUM == _cPedido
			RecLock("SC7",.F.)
			SC7->C7_STATUS  := "B"
			SC7->C7_USRAPRO := _cUserLib
			SC7->C7_NOMEAPR := _cNomeLib
			MsUnlock()
			_cNomFor        := POSICIONE("SA2",1,XFILIAL("SA2")+SC1->C1_FORNECE+SC1->C1_LOJA,"A2_NOME")
			_lBloq          := .T.
			dbSkip()
		EndDo
		
		RestArea(_aArea)
		RecLock("SZO",.F.)
		SZO->ZO_APROV   := "B"
		SZO->ZO_USRAPRO := _cUserLib
		SZO->ZO_NOMEAPR := _cNomeLib
		MsUnlock()
	Else
		CONOUT("PEDIDO LIBERADO")
		dbSelectArea("SC7")
		dbSetOrder(1)          // C1_FILIAL+C1_NUM+C1_ITEM
		dbSeek(xFilial("SC7")+_cPedido,.T.)
		Do While !Eof() .And. SC7->C7_NUM == _cPedido
			RecLock("SC7",.F.)
			SC7->C7_STATUS := "L"
			MsUnlock()
			dbSkip()
		EndDo
		
		RestArea(_aArea)
		RecLock("SZO",.F.)
		SZO->ZO_APROV := "L"
		MsUnlock()
		
		ConOut("Enviando email de Aprovacao/Rejeicao da :"+_cPedido)
		
		//RastreiaWF( ID do Processo, Codigo do Processo, Codigo do Status, Descricao Especifica, Usuario )
		RastreiaWF(oProcess:fProcessID+'.'+oProcess:fTaskID,"000004",'1002',"RETORNO DE WORKFLOW PARA APROVACAO DE PC",cUsername)
		
		oProcess:Finish()
		oProcess:Free()
		oProcess:= Nil
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Inicia Envio de Mensagem de Aviso³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		PutMv("MV_WFHTML","T")
		
		oProcess:=TWFProcess():New("000001","WORKFLOW PARA APROVACAO DE PC")
		oProcess:NewTask('Inicio',"\workflow\HTML\WFW120P1A.htm")
		
		
		oHtml   := oProcess:oHtml
		
		oHtml:valbyname("Num"				, _cPedido)
		oHtml:valbyname("Req"    			, cSolicit)
		oHtml:valbyname("Emissao"  			, cEmissao)
		oHtml:valbyname("Motivo"   			, cMotivo)
		oHtml:valbyname("it.Item"   		, {})
		oHtml:valbyname("it.Cod"  			, {})
		oHtml:valbyname("it.Desc"   		, {})
		
		/*
		aadd(oHtml:ValByName("it.Item")		, "")
		aadd(oHtml:ValByName("it.Cod")		, "")
		aadd(oHtml:ValByName("it.Desc")		, "")
		*/
		dbSelectArea("SC7")
		dbSetOrder(1)
		dbSeek(xFilial("SC7")+_cPedido)
		WHILE !EOF() .AND. SC7->C7_NUM == _cPedido
			
			cMailSol	:= UsrRetMail(SC7->C7_USER)
			cMailSup	:= "" //UsrRetMail(SC7->C7_USRAPRO)
			
			aadd(oHtml:ValByName("it.Item")		, SC7->C7_ITEM)
			aadd(oHtml:ValByName("it.Cod")		, SC7->C7_PRODUTO)
			aadd(oHtml:ValByName("it.Desc")		, SC7->C7_DESCRI)
			
			dbSelectArea("SC7")
			dbSkip()
		ENDDO
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Funcoes para Envio do Workflow³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		//envia o e-mail
		
		IF SELECT("TRBSC7") > 0
			dbSelectArea("TRBSC7")
			dbCloseArea()
		ENDIF
		
		cQuery := " SELECT ZI_USER, ZI_NOMEUSR, ZI.*
		cQuery += " FROM "+RetSqlName("SZI")+" ZI "
		cQuery += " WHERE ZI_ROTINA 	= 'SC7'
		cQuery += " AND ZI_FILIAL		= '"+XFILIAL("SZI")+"'"
		cQuery += " AND ZI_DOC 			= '"+_cPedido+"'"
		cQuery += " AND ZI.D_E_L_E_T_  != '*'
		
		MemoWrit("COMWF001A.sql",cQuery)
		dbUseArea(.T.,"TOPCONN", TCGenQry(,,cQuery),"TRBSC7", .F., .T.)
		
		WHILE !EOF() .AND. TRBSC7->ZI_DOC == _cPEDIDO
			
			//IF AT(ALLTRIM(cMailSup), ALLTRIM(UsrRetMail(TRBSC7->ZI_USER))) == 0
			IF !(ALLTRIM(UsrRetMail(TRBSC7->ZI_USER)) $ ALLTRIM(cMailSup))
				
				cMailSup += ALLTRIM(UsrRetMail(TRBSC7->ZI_USER))+";"
				
			ENDIF
			
			//UsrRetMail(SC7->C7_USRAPRO)
			
			dbSelectArea("TRBSC7")
			DBSKIP()
		ENDDO
		
		
		cUser 			  := Subs(cUsuario,7,15)
		oProcess:ClientName(cUser)
		IF !EMPTY(cMailSup)
			oProcess:cTo	  := cMailSup+cMailSol //cMailSup+';'+cMailSol
		ELSE
			oProcess:cTo	  := "lfelipe@ncgames.com.br"
		ENDIF
		oProcess:cBCC     := 'lfelipe@ncgames.com.br' //cCopia
		
		oProcess:cSubject := "Pedido de Compra N°: "+_cPedido+" - Aprovado"
		
		oProcess:cBody    := ""
		oProcess:bReturn  := ""
		oProcess:Start()
		
		oProcess:Free()
		oProcess:Finish()
		oProcess:= Nil
		
	EndIf
	
	If _lBloq
		CONOUT("MANDA EMAIL PARA O PROXIMO APROVADOR")
		//INCPV_EMail()
		U_SPCIniciar("lfelipe@ncgames.com.br",_cUserLib)
	EndIf
	
	RestArea(_aArea)
	
Else
	//oProcess:cSubject := "Pedido Reprovado
	//U_UFA120RJ()
	CONOUT("REJEICAO DO PEDIDO DE COMPRA")
	//Private _aArea  := GetArea()
	
	dbSelectArea("SC7")
	dbSetOrder(1)
	dbSeek(xFilial("SC7")+_cPedido)
	/*
	RecLock("SC7",.F.)
	SZO->ZO_APROV   := "B"
	MsUnlock()
	*/
	dbSelectArea("SZO")
	dbSetOrder(1)
	dbSeek(xFilial("SZO")+_cPedido)
	
	CONOUT("REALIZADO BUSCA NA SC7 E SZO COM O FILTRO : " +_cPedido)
	
	RecLock("SZO",.F.)
	SZO->ZO_APROV   := "R"
	MsUnlock()
	Alert("Pedido de Compras Rejeitado pelo usuario "+_cUsuario+" - "+_cNomeUsr)
	
	cCCusto	:= GETADVFVAL("SAK","AK_CC",XFILIAL("SAK")+SZO->ZO_USRAPRO,2,SPACE(09)) //SZO->ZO_CC
	cCCDesc	:= GETADVFVAL("CTT","CTT_DESC01",XFILIAL("CTT")+cCCusto,1,SPACE(40))  //SZO->ZO_DESCCC
	
	dbSelectArea("SZI")
	dbSetOrder(1)
	RecLock("SZI",.T.)
	SZI->ZI_FILIAL  := xFilial("SZI")
	SZI->ZI_ROTINA  := "SC7"
	SZI->ZI_DOC     := SZO->ZO_NUM
	SZI->ZI_STATUS  := "R"
	SZI->ZI_USER    := _cUsuario
	SZI->ZI_NOMEUSR := _cNomeUsr
	SZI->ZI_CC      := cCCusto //SZO->ZO_CC
	SZI->ZI_DESCCC  := cCCDesc //SZO->ZO_DESCCC
	SZI->ZI_DATA    := DDATABASE
	SZI->ZI_HORA    := TIME()
	MsUnLock()
	
	//EmailRJPV()
	
	ConOut("Enviando email de Aprovacao/Rejeicao da :"+_cPedido)
	
	//RastreiaWF( ID do Processo, Codigo do Processo, Codigo do Status, Descricao Especifica, Usuario )
	RastreiaWF(oProcess:fProcessID+'.'+oProcess:fTaskID,"000004",'1002',"RETORNO DE WORKFLOW PARA REJEICAO DE PC",cUsername)
	
	oProcess:Finish()
	oProcess:Free()
	oProcess:= Nil
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Inicia Envio de Mensagem de Aviso³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	PutMv("MV_WFHTML","T")
	
	oProcess:=TWFProcess():New("000001","WORKFLOW PARA REJEICAO DE PC")
	oProcess:NewTask('Inicio',"\workflow\HTML\WFW120P1R.htm")
	
	
	oHtml   := oProcess:oHtml
	
	oHtml:valbyname("Num"				, _cPedido)
	oHtml:valbyname("Req"    			, cSolicit)
	oHtml:valbyname("Emissao"  			, cEmissao)
	oHtml:valbyname("Motivo"   			, cMotivo)
	oHtml:valbyname("it.Item"   		, {})
	oHtml:valbyname("it.Cod"  			, {})
	oHtml:valbyname("it.Desc"   		, {})
	
	/*
	aadd(oHtml:ValByName("it.Item")		, "")
	aadd(oHtml:ValByName("it.Cod")		, "")
	aadd(oHtml:ValByName("it.Desc")		, "")
	*/
	dbSelectArea("SC7")
	dbSetOrder(1)
	dbSeek(xFilial("SC7")+_cPedido)
	WHILE !EOF() .AND. SC7->C7_NUM == _cPedido
		
		cMailSol	:= UsrRetMail(SC7->C7_USER)
		cMailSup	:= "" //UsrRetMail(SC7->C7_USRAPRO)
		
		aadd(oHtml:ValByName("it.Item")		, SC7->C7_ITEM)
		aadd(oHtml:ValByName("it.Cod")		, SC7->C7_PRODUTO)
		aadd(oHtml:ValByName("it.Desc")		, SC7->C7_DESCRI)
		
		dbSelectArea("SC7")
		dbSkip()
	ENDDO
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Funcoes para Envio do Workflow³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	//envia o e-mail
	
	IF SELECT("TRBSC7") > 0
		dbSelectArea("TRBSC7")
		dbCloseArea()
	ENDIF
	
	cQuery := " SELECT ZI_USER, ZI_NOMEUSR, ZI.*
	cQuery += " FROM "+RetSqlName("SZI")+" ZI "
	cQuery += " WHERE ZI_ROTINA 	= 'SC7'
	cQuery += " AND ZI_FILIAL		= '"+XFILIAL("SZI")+"'"
	cQuery += " AND ZI_DOC 			= '"+_cPedido+"'"
	cQuery += " AND ZI.D_E_L_E_T_  != '*'
	
	MemoWrit("COMWF001A.sql",cQuery)
	dbUseArea(.T.,"TOPCONN", TCGenQry(,,cQuery),"TRBSC7", .F., .T.)
	
	WHILE !EOF() .AND. TRBSC7->ZI_DOC == _cPEDIDO
		
		//IF AT(ALLTRIM(cMailSup), ALLTRIM(UsrRetMail(TRBSC7->ZI_USER))) == 0
		IF !(ALLTRIM(UsrRetMail(TRBSC7->ZI_USER)) $ ALLTRIM(cMailSup))
				
				cMailSup += ALLTRIM(UsrRetMail(TRBSC7->ZI_USER))+";"
				
			
		ENDIF
		
		//UsrRetMail(SC7->C7_USRAPRO)
		
		dbSelectArea("TRBSC7")
		DBSKIP()
	ENDDO
	
	cUser 			  := Subs(cUsuario,7,15)
	oProcess:ClientName(cUser)
	
	IF !EMPTY(cMailSup)
		oProcess:cTo	  := cMailSup+cMailSol //cMailSup+';'+cMailSol
	ELSE
		oProcess:cTo	  := "lfelipe@ncgames.com.br"
	ENDIF
	oProcess:cBCC     := 'lfelipe@ncgames.com.br' //cCopia
	
	oProcess:cSubject := "Workflow de Compras Indiretas - Pedido de Compra N°: "+_cPedido+" - Reprovado "//+cItemSc+" - Reprovada"
	
	oProcess:cBody    := ""
	oProcess:bReturn  := ""
	oProcess:Start()
	
	oProcess:Free()
	oProcess:Finish()
	oProcess:= Nil
	
	
	RestArea(_aArea)
	
endif

PutMv("MV_WFHTML",cMvAtt)

Return


////////////////////////////////////////////////////////////////////////////////////
// FUNCAO PARA INICIAR O PROCESSO DE ENVIO DO WORKFLOW ************************** //
////////////////////////////////////////////////////////////////////////////////////
USER FUNCTION SPCIniciar(EMAILS,APROVADOR)//( oProcess,lPrimeira )

Local cMvAtt 		:= GetMv("MV_WFHTML")
Local aCond			:= {},nTotal := 0
Local NI			:= 1
Local cNomeFor		:= ""
Local ccond			:= ""
Local cMailSup		:= ""
Local cMailSol		:= ""
Public nCotacao 	:= 1

PutMv("MV_WFHTML","T")
oProcess			:= TWFProcess():New("000001","WORKFLOW PARA APROVACAO DE PC")

oProcess:NewTask( "Solicitação", "\WORKFLOW\HTML\WFW120P1.HTM" )
oHTML 				:= oProcess:oHTML

/*
//Procura nome do aprovador
dbSelectArea('SCR')
DBSETORDER(1)
dbSeek(xFilial('SCR') + SC7->C7_NUM)
cAprov   			:= SCR->CR_USER
//CNivel   			:= SCR->CR_NIVEL
PswOrder(1)
IF PswSeek(cAprov,.t.)// .and. cAprov <> "000000"
aInfo   		:= PswRet(1)
cMailAp 		:= alltrim(aInfo[1,14])
cNomeAP 		:= aInfo[1,2]
ENDIF
*/
dbSelectArea('SC7')
IF TYPE("_cPedido") != "U"
	dbSetOrder(1)
	dbSeek(xFilial('SC7')+_cPedido)
ENDIF
cNum 				:= SC7->C7_NUM
nCotacao 			:= 1

//Preenche o nome do Fornecedor
dbSelectArea('SA2')
dbSetOrder(1)
dbSeek(xFilial('SA2')+SC7->C7_FORNECE)
cNomeFor			:= SA2->A2_NREDUZ

//Pego as condiicoes de Pagamento
dbSelectArea('SE4')
DBSETORDER(1)
dbSeek(xFilial('SE4') + SC7->C7_COND)
ccond 				:= SE4->E4_DESCRI

//Busca na SC1 o solicitante original
dbSelectArea('SC1')
dbSetOrder(1)
dbSeek(xFilial('SC1')+SC7->C7_NUMSC+SC7->C7_ITEMSC)
cSolicitante		:= UsrRetName(SC1->C1_USER)
cMailSol			:= UsrRetMail(SC1->C1_USER)

// Preenche o codigo e nome do centro de custo do aprovador/solicitante
dbSelectArea("SAI")
dbSetOrder(2)
//IF EMPTY(ALLTRIM(GETADVFVAL("SAI","AI_CC",XFILIAL("SAI")+SC7->C7_USER,2,SPACE(06))))
IF dbSeek(xFilial("SAI")+SC1->C1_USER)
	cCCusto			:= GETADVFVAL("SAI","AI_CC",XFILIAL("SAI")+SC1->C1_USER,2,SPACE(06))
ELSE
	cCCusto			:= GETADVFVAL("SAK","AK_CC",XFILIAL("SAK")+SZO->ZO_USRAPRO,2,SPACE(09))
ENDIF

cCCDesc				:= GETADVFVAL("CTT","CTT_DESC01",XFILIAL("CTT")+cCCusto,1,SPACE(40))


dbSelectArea('SC7')
dbSetOrder(1)
dbSeek(xFilial('SC7')+cNUm)

cMailSup			:= UsrRetMail(SC7->C7_USRAPRO)

/*** Preenche os dados do cabecalho ***/
oHtml:ValByName( "PEDIDO"		, SC7->C7_NUM 			)
oHtml:ValByName( "EMISSAO"		, SC7->C7_EMISSAO 		)
oHtml:ValByName( "lb_cond"		, CCOND 				)
oHtml:ValByName( "lb_nome"		, cNomeFor				)
oHtml:ValByName( "FORNECEDOR"	, SC7->C7_FORNECE 		)
oHtml:ValByName( "loja"			, SC7->C7_LOJA 			)
oHtml:ValByName( "Contato"		, SC7->C7_CONTATO 		)
oHtml:ValByName( "cSolicit"		, cSolicitante 			)
oHtml:ValByName( "cCusto"		, cCCusto+'-'+cCCDesc 	)
oHtml:ValByName( "cCODUSR"		, SC7->C7_USER 			)
oHtml:ValByName( "cCODAPROV"	, SC7->C7_USRAPRO 		)

dbSelectArea("SZI")
dbSetOrder(1)
IF dbSeek(xFilial("SZI")+"SC7"+cNum)
	
	WHILE !EOF() .AND. cNum == SZI->ZI_DOC .AND. SZI->ZI_ROTINA == "SC7"
		
		IF NI <= 4
			IF NI == 1
				oHtml:ValByName("cAprov1"			, SZI->ZI_NOMEUSR)
				oHtml:ValByName("cCusto1"			, ALLTRIM(SZI->ZI_CC)+"-"+Alltrim(SZI->ZI_DESCCC))
			ELSEIF NI == 2
				oHtml:ValByName("cAprov2"			, SZI->ZI_NOMEUSR)
				oHtml:ValByName("cCusto2"			, ALLTRIM(SZI->ZI_CC)+"-"+Alltrim(SZI->ZI_DESCCC))
			ELSEIF NI == 3
				oHtml:ValByName("cAprov3"			, SZI->ZI_NOMEUSR)
				oHtml:ValByName("cCusto3"			, ALLTRIM(SZI->ZI_CC)+"-"+Alltrim(SZI->ZI_DESCCC))
			ELSEIF NI == 4
				oHtml:ValByName("cAprov4"			, SZI->ZI_NOMEUSR)
				oHtml:ValByName("cCusto4"			, ALLTRIM(SZI->ZI_CC)+"-"+Alltrim(SZI->ZI_DESCCC))
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
	oHtml:ValByName("cAprov4"			, "")
	oHtml:ValByName("cCusto4"			, "")
ENDIF

dbSelectArea('SC7')
dbSetOrder(1)
dbSeek(xFilial('SC7')+cNum)
While !Eof() .and. SC7->C7_NUM = cNum
	nTotal := nTotal + SC7->C7_TOTAL
	AAdd( (oHtml:ValByName( "it.ITEM" ))		,SC7->C7_ITEM )
	AAdd( (oHtml:ValByName( "it.CODIGO" ))		,SC7->C7_PRODUTO )
	dbSelectArea('SB1')
	dbSetOrder(1)
	dbSeek(xFilial('SB1')+SC7->C7_PRODUTO)
	AAdd( (oHtml:ValByName( "it.DESCRICAO" ))	,SB1->B1_DESC )
	dbSelectArea('SC7')
	AAdd( (oHtml:ValByName( "it.QUANT" ))		,TRANSFORM( SC7->C7_QUANT,'@E 999,999.99' ) )
	AAdd( (oHtml:ValByName( "it.PRECO" ))		,TRANSFORM( SC7->C7_PRECO,'@E 999,999,999.99' ) )
	AAdd( (oHtml:ValByName( "it.TOTAL" ))		,TRANSFORM( SC7->C7_TOTAL,'@E 9,999,999,999.99' ) )
	AAdd( (oHtml:ValByName( "it.OBS" ))			,SC7->C7_OBS )
	//AAdd( (oHtml:ValByName( "it.unid" ))		,SB1->B1_UM )
	//AAdd( (oHtml:ValByName( "it.entrega" ))	,'0' )
	//AAdd( (oHtml:ValByName( "it.condPag" ))	,CCond )
	
	RecLock('SC7')
	C7_WFID 		:= oProcess:fProcessID
	C7_FILENT 		:= C7_FILIAL
	MsUnlock()
	dbSkip()
Enddo

/*
oHtml:ValByName( "lbValor" ,TRANSFORM( nTotal		,'@E 999,999.99' ) )
oHtml:ValByName( "lbFrete" ,TRANSFORM( 0			,'@E 999,999.99' ) )
oHtml:ValByName( "lbTotal" ,TRANSFORM( nTotal		,'@E 999,999.99' ) )
*/

//Adiciona os botoes para enviar e limpar os dados
//oHtml:valByName('botoes', '<input type="submit" name="B1" value="Enviar"> <input type="reset" name="B2" value="Limpar">')

//Grava o email na pasta referente as solicitações de compras "PEDCOMPRA"
oProcess:cTo    	:= "PEDCOMPRA
oProcess:bReturn  	:= "U_SPCRetorno()"
//oProcess:bReturn 	:= "U_WFW120P( 1 )"
//oProcess:bTimeOut 	:= {{"U_WFW120P(2)", 0 ,0 ,2 }}
cMailID				:= oProcess:Start()

oProcess:Free()
conout("(INICIO|WFLINK)COM-PC Processo Worfklow ID: " + cMailID )

// INICIA O ENVIO DO EMAIL COM O LINK PARA APROVACAO DO WORKFLOW DE SOLICITACAO DE COMRPAS
oProcess:NewTask("LINK", "\WORKFLOW\HTML\WF_LINK_COM_PEDIDO.html")

oProcess:oHtml:ValByName("A_LINK", "http://192.168.0.200:8092/messenger/emp" + "01"/*cEmpAnt*/ + "/PEDCOMPRA/" + cMailId + ".htm")
oProcess:oHtml:ValByName("B_LINK", "http://186.215.160.178:8092/messenger/emp" + "01"/*cEmpAnt*/ + "/PEDCOMPRA/" + cMailId + ".htm")

oProcess:ClientName( Subs(cUsuario,7,15) )
oProcess:cTo 		:= cMailSup
oProcess:cBCC     	:= "lfelipe@ncgames.com.br"
oProcess:cSubject  	:= "Aprovação de Pedido de Compra - " + cNum

oProcess:Start()

//RastreiaWF( ID do Processo                        , Codigo do Processo, Codigo do Status, Descricao Especifica                   , Usuario )
//RastreiaWF(oProcess:fProcessID+'.'+oProcess:fTaskID,"000001"           ,"10001"           ,"ENVIO DE WORKFLOW PARA APROVACAO DE PC",cUsername)
oProcess:Free()
oProcess			:= Nil

PutMv("MV_WFHTML",cMvAtt)

/*
////WFSendMail({"01","03"})

//oProcess:ClientName( Subs(cUsuario,7,15) )
//oProcess:cTo 		:= "soliveira@ncgames.com.br"
//oProcess:cBCC     	:= "thiago@stch.com.br"
//oProcess:cBody    	:= "Solicitacao de aprovacao de pedido de Compras. <BR><BR> Abra o arquivo em anexo para ver o pedido. <BR><BR><BR>_________________________________________________________________________________________________________ <BR>Por favor nao responda esse e-mail. Mensagem enviada automaticamente pelo sistema Protheus. "

oProcess:Start()
//RastreiaWF("00001"+'.'+oProcess:fTaskID,"000001",'1005')
wfSendMail()
//RastreiaWF(oProcess:fProcessID+'.'+oProcess:fTaskID,oProcess:fProcCode,'10001','Processo do Pedido '+cNum+' iniciado!' )

PutMv("MV_WFHTML",cMvAtt)
*/
Return

////////////////////////////////////////////////////////////////////////////////////
// ****************************************************************************** //
////////////////////////////////////////////////////////////////////////////////////
USER FUNCTION SPCTimeOut( oProcess )
Local cMvAtt := GetMv("MV_WFHTML")

PutMv("MV_WFHTML","F")
ConOut("Funcao de TIMEOUT executada")
oProcess:NewTask('Time Out',"\workflow\HTML\timeout.htm")
oHtml:=oProcess:oHtml
oHtml:RetByName("Titulo","Usuario não respondeu e-mail")
oHtml:RetByName("numPed",_cPedido)
oHtml:RetByName("cliente",_ccliente)
_cUser = Subs(cUsuario,7,15)
oHtml:RetByName("usuario",_cUser)
subj := "Pedido"+ _cPedido + " por " + _ccliente
oProcess:Start()
WFSendMail()

PutMv("MV_WFHTML",cMvAtt)

Return

////////////////////////////////////////////////////////////////////////////////////
// ****************************************************************************** //
////////////////////////////////////////////////////////////////////////////////////
USER FUNCTION TestProcess(oProc)
Local cMvAtt := GetMv("MV_WFHTML")

PutMv("MV_WFHTML","F")
//Prepare Environment Empresa '99' Filial '01'
//Proc:oHtml:valByName('botoes',"")

oHTML := oProc:oHTML
ConOut("abe")
//oProc:cTo := "soliveira@ncgames.com.br"	//vendedor
oProc:cTo := "lfelipe@ncgames.com.br"	//vendedor
//oProcess:cBody := 'Processo do Pedido: '+oProc:oHTML:RetByName('Pedido')+' concluido!'

oProc:Start()
WFSendMail()
//RastreiaWF(oProc:fProcessID+'.'+oProc:fTaskID,oProc:fProcCode,'1003','Finalizando Processo',Subs(cUsuario,7,15))

PutMv("MV_WFHTML",cMvAtt)

Return .T.

////////////////////////////////////////////////////////////////////////////////////
// ****************************************************************************** //
////////////////////////////////////////////////////////////////////////////////////
USER FUNCTION SeekEml(cAprovador)
//Local cMvAtt := GetMv("MV_WFHTML")

//PutMv("MV_WFHTML","F")
PswOrder(1)
IF PswSeek(cAprovador,.t.)
	aInfo   := PswRet(1)
	cMailAp := alltrim(aInfo[1,14])
	conout ("Email do Aprovador" + cMailAp)
ENDIF
//PutMv("MV_WFHTML",cMvAtt)
RETURN
