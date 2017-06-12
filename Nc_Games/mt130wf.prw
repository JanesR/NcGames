#include "rwmake.ch"
#include "TbiConn.ch"
#include "TbiCode.ch"
#include "ap5mail.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMT130WF   บ Autor ณ Thiago Queiroz     บ Data ณ  18/10/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณPonto de entrada para envio de Workflow na cota็ใo          บฑฑ
ฑฑบ          ณde Compras                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function MT130WF(oProcess)

Local aCond		:= {}
Local aFrete	:= {}
Local aSubst	:= {}
Local nTotal 	:= 0
Local _cC8_NUM, _cC8_FORNECE, _cC8_LOJA
Local _cEmlFor
Local cEmail  	:= Space(30)
Local cUsermail
Private oHmtl

//atualiza quando nao for rotina automatica do configurador
If len(PswRet()) # 0
	cUsermail := PswRet()[1][14]
EndIF

dbSelectArea("SC8")
dbSetOrder(1)
dbSeek(xFilial("SC8")+ParamIXB[1])
while !eof() .and. xFilial("SC8")+ParamIXB[1]==C8_FILIAL+C8_NUM
	//caso ja tenha sido respondida
	If C8_WFCO == "1004"
		dbSkip()
		Loop
	EndIF
	
	_cC8_NUM     := SC8->C8_NUM
	_cC8_FORNECE := SC8->C8_FORNECE
	_cC8_LOJA    := SC8->C8_LOJA
	
	// Tabela de Fornecedores
	dbSelectArea('SA2')
	dbSetOrder(1)
	dbSeek( xFilial('SA2') + _cC8_FORNECE + _cC8_LOJA )
	_cEmlFor := SA2->A2_EMAIL
	//caso nao encontre um e-mail
	If Empty(_cEmlFor)
		If MsgYesNo("O Fornecedor "+SA2->A2_COD+"-"+SA2->A2_NOME+" nใo tem um email cadsatrado, deseja cadastrar agora?")
			
			@ 100,153 To 329,435 Dialog oDlg Title OemToAnsi("Endere็o de e-mail")
			@ 9,9 Say OemToAnsi("E-mail") Size 99,8
			@ 28,9 Get cEmail  Size 79,10
			
			@ 62,39 BMPBUTTON TYPE 1 ACTION Close(oDlg)
			
			Activate Dialog oDlg Centered
			//grava o email no SA2
			RecLock("SA2",.F.)
			A2_EMAIL = cEmail
			MsUnlock()
			_cEmlFor := cEmail
		EndIf
	EndIf
	
	//Faz nova verificacao do e-mail
	if Alltrim(_cEmlFor) <> ""
		PutMv("MV_WFHTML","T")//MUDA O PARAMETRO PARA ANEXAR O HTM
		
		oProcess := TWFProcess():New( "000002", "Cota็ใo de Pre็os" )
		oProcess :NewTask( "Fluxo de Compras", "\WORKFLOW\HTML\COTACAO.HTM" )
		oHtml    := oProcess:oHTML
		
		// Cotacoes
		dbSelectArea('SC8')
		dbSetOrder(1)
		dbSeek( xFilial('SC8') + _cC8_NUM + _cC8_FORNECE + _cC8_LOJA )
		
		//armazena dados do usuario
		
		/*** Preenche os dados do cabecalho ***/
		oHtml:ValByName( "C8_NUM"    	, SC8->C8_NUM     )
		oHtml:ValByName( "C8_VALIDA" 	, SC8->C8_VALIDA  )
		oHtml:ValByName( "C8_FORNECE"	, SC8->C8_FORNECE )
		oHtml:ValByName( "C8_LOJA"  	, SC8->C8_LOJA    )
		oHtml:ValByName( "C8_CONTATO"	, SC8->C8_CONTATO  )
		
		// Tabela de Fornecedores
		dbSelectArea('SA2')
		dbSetOrder(1)
		dbSeek( xFilial('SA2') + _cC8_FORNECE + _cC8_LOJA )
		oHtml:ValByName( "A2_NOME"   	, SA2->A2_NOME   )
		oHtml:ValByName( "A2_END"    	, SA2->A2_END    )
		oHtml:ValByName( "A2_MUN"    	, SA2->A2_MUN    )
		oHtml:ValByName( "A2_BAIRRO" 	, SA2->A2_BAIRRO )
		oHtml:ValByName( "A2_TEL"    	, SA2->A2_TEL    )
		oHtml:ValByName( "A2_FAX"    	, SA2->A2_FAX    )
		//oHtml:ValByName( "A2_CONTATO" , SA2->A2_CONTATO  )
		//natureza
		dbSelectArea("SE4")
		dbSetOrder(1)
		if dbSeek(xFilial("SE4") + SA2->A2_COND )
			aAdd( aCond, SE4->E4_Codigo + " - " + SE4->E4_Descri )
		endif
		dbGoTop()
		while !eof() .and. SE4->E4_Filial == xFilial("SE4")
			aAdd( aCond, SE4->E4_Codigo + " - " + SE4->E4_Descri )
			dbSkip()
		enddo
		
		// Cotacoes
		dbSelectArea('SC8')
		dbSetOrder(1)
		dbSeek( xFilial('SC8') + _cC8_NUM + _cC8_FORNECE + _cC8_LOJA )
		oHtml:ValByName( "C8_CONTATO" 	, SC8->C8_CONTATO  )
		//busca os itens
		while !eof() .and. SC8->C8_FILIAL == xFilial("SC8") ;
			.and. SC8->C8_NUM     == _cC8_NUM ;
			.and. SC8->C8_FORNECE == _cC8_FORNECE ;
			.and. SC8->C8_LOJA    == _cC8_LOJA
			
			aAdd( (oHtml:ValByName( "it.item"    ))		, SC8->C8_ITEM   	)
			aAdd( (oHtml:ValByName( "it.produto" ))		, SC8->C8_PRODUTO	)
			/*
			// BUSCA PRODUTOS PELA AMARRACAO 'PRODUTO X FORNECEDOR' - NAO UTILIZADO
			//dbSelectArea("SA5")
			//dbSetOrder(1)
			//dbSeek(xFilial("SA5") + _cC8_FORNECE + _cC8_LOJA + SC8->C8_PRODUTO )
			//aAdd( (oHtml:ValByName( "it.produto" ))		, SA5->A5_CODPRF )
			//aAdd( (oHtml:ValByName( "it.descri"  ))		, SA5->A5_DESREF     )
			*/
			dbSelectArea("SB1")
			dbSetOrder(1)
			dbSeek(xFilial("SB1") + SC8->C8_PRODUTO )
			aAdd( (oHtml:ValByName( "it.descri"	))		, SB1->B1_DESC     										)
			aAdd( (oHtml:ValByName( "it.obs" 	))		, SC8->C8_OBS	  										)			
			aAdd( (oHtml:ValByName( "it.quant" 	))		, TRANSFORM( SC8->C8_QUANT,'@E 999999.99' ) 			)
			aAdd( (oHtml:ValByName( "it.um"    	))		, SC8->C8_UM      										)
			aAdd( (oHtml:ValByName( "it.preco" 	))		, TRANSFORM( 0.00,'@E 99999999.99' ) 					)
			aAdd( (oHtml:ValByName( "it.valor"	))		, TRANSFORM( 0.00,'@E 99999999.99' ) 					)
			aAdd( (oHtml:ValByName( "it.prazo"	))		, " "													)
			//aAdd( (oHtml:ValByName( "it.ipi"  ))		, TRANSFORM( 0.00,'@E 99999.99' ) 						)
			aAdd( (oHtml:ValByName( "it.dia" 	))		, str(day(SC8->C8_DATPRF))         						)
			aAdd( (oHtml:ValByName( "it.mes"  	))		, padl( alltrim( str( month(SC8->C8_DATPRF) ) ),2,"0")	)
			aAdd( (oHtml:ValByName( "it.ano"	))		, right(str(year(SC8->C8_DATPRF)),2)					)
			dbSelectArea("SC8")
			//GRAVA DADOS NO SC8
			RecLock('SC8')
			C8_WFCO   := "1003"
			If Empty(C8_WFDT)
				C8_WFDT   := dDataBase
			EndIF
			If Empty(C8_WFEMAIL)
				If cUsername == "Administrador"
					C8_WFEMAIL := GetMV("MV_RELACNT")
				Else
					C8_WFEMAIL := cUsermail
				EndIF
			EndIf
			C8_WFID := oProcess:fProcessID
			MsUnlock()
			dbSkip()
		enddo
		//_cMailID:=oProcess:Start()   //ENCERROU O PROCESSO    errado
		oHtml:ValByName( "Pagamento"	, aCond    )
		oHtml:ValByName( "Frete"    	, {"CIF","FOB"}   )
		oHtml:ValByName( "subtot"   	, TRANSFORM( 0 	,'@E 9999999999.99' ) )
		oHtml:ValByName( "vldesc"   	, TRANSFORM( 0 	,'@E 999999999.99' ) )
		//oHtml:ValByName( "aliipi"   	, TRANSFORM( 0 	,'@E 999999.99' ) )
		//oHtml:ValByName( "Valipi"   	, TRANSFORM( 0 	,'@E 999999.99' ) )
		oHtml:ValByName( "valfre"   	, TRANSFORM( 0 	,'@E 999999999.99' ) )
		oHtml:ValByName( "totped"   	, TRANSFORM( 0 	,'@E 9999999999.99' ) )
		
		oProcess:cTo		:= "COTACAO" //_cEmlFor
		oProcess:bReturn	:= "U_MT130WFR(1)"
		//		oProcess:bTimeOut := { { "U_MT130WF(6)", 1, 1, 10 } } //oProcess:bTimeOut := { { funcao, dias, horas, minutos0 } }
		cMailID				:= oProcess:Start()
		
		//RastreiaWF( ID do Processo, Codigo do Processo, Codigo do Status, Descricao Especifica, Usuario )
		//RastreiaWF(oProcess:fProcessID+'.'+oProcess:fTaskID,"000002",'1003',"Email Enviado Para o Fornecedor:"+SA2->A2_NOME,RetCodUsr())
		//	WFSendMail()
		
		oProcess:Free()
		//conout("(INICIO|WFLINK)Processo: " + oProcess:fProcessID + " - Task: " + oProcess:fTaskID )
		
		// INICIA O ENVIO DO EMAIL COM O LINK PARA APROVACAO DO WORKFLOW DE SOLICITACAO DE COMRPAS
		oProcess:NewTask("LINK", "\WORKFLOW\HTML\WF_LINK_COM_SOLICITACAO.html")
		
		oProcess:oHtml:ValByName("A_LINK", "http://192.168.0.200:8092/messenger/emp" + "01"/*cEmpAnt*/ + "/COTACAO/" + cMailId + ".htm")
		oProcess:oHtml:ValByName("B_LINK", "http://186.215.160.178:8092/messenger/emp" + "01"/*cEmpAnt*/ + "/COTACAO/" + cMailId + ".htm")
		
		//VERIFICAR OUTRO PONTO
		//_oProc := TWFProcess():New("000003", "Cota็ใo de Pre็os")
		oProcess:NewTask( "Email", "\WORKFLOW\wflinkCota.htm" )
		oProcess:cSubject	:= "Cota็ใo de Pre็os No " + _cC8_NUM + " - NC Games"
		oProcess:cTo		:= _cEmlFor
		
		oProcess:Start()
		//wfSendMail()
	else
		// Atualizar SC8 para nao processar novamente
		dbSelectArea("SC8")
		RecLock('SC8')
		SC8->C8_WFID 		:= "WF9999"
		MsUnlock()
		dbSkip()
	endif
enddo

Return

/*
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMT130WF   บ Autor ณ Thiago Queiroz     บ Data ณ  18/10/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFaz a gravacao no retorno do workflow                       บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function MT130WFR(AOpcao, oProcess)
Local aCab   		:= {}
Local aItem  		:= {}
Local nUsado 		:= 0
Local aRelImp 	:= MaFisRelImp("MT150",{"SC8"})

if ValType(aOpcao) = "A"
	aOpcao 			:= aOpcao[1]
endif

if aOpcao == NIL
	aOpcao 			:= 0
endIf

if aOpcao == 1
	_cC8_NUM    	:= oProcess:oHtml:RetByName("C8_NUM"     )
	_cC8_FORNECE	:= oProcess:oHtml:RetByName("C8_FORNECE" )
	_cC8_LOJA   	:= oProcess:oHtml:RetByName("C8_LOJA"    )
endif

dbSelectArea("SC8")
dbSetOrder(1)
dbSeek( xFilial("SC8") + Padr(_cC8_NUM,6) + Padr(_cC8_FORNECE,6) + _cC8_LOJA )

// Cotacao Recebida
if oProcess:oHtml:RetByName("Aprovacao") = "S"
	
	RastreiaWF(oProcess:fProcessID+'.'+oProcess:fTaskID,"000002",'1004',"Email respondido pelo Fornecedor:"+_cC8_FORNECE,RetCodUsr())
	_cC8_VLDESC 	:= oProcess:oHtml:RetByName("VLDESC" )
	//_cC8_ALIIPI 	:= oProcess:oHtml:RetByName("ALIIPI" )
	_cC8_VALFRE 	:= oProcess:oHtml:RetByName("VALFRE" )
	
	//verifica o frete
	if oProcess:oHtml:RetByName("Frete") = "FOB"
		_cC8_RATFRE := 0
	endif
	
	//grava no SC8
	for _nind := 1 to len(oProcess:oHtml:RetByName("it.preco"))
		//BASE DO ICMS
		MaFisIni(Padr(_cC8_FORNECE,6),_cC8_LOJA,"F","N","R",aRelImp)
		MaFisIniLoad(1)
		For nY := 1 To Len(aRelImp)
			MaFisLoad(aRelImp[nY][3],SC8->(FieldGet(FieldPos(aRelImp[nY][2]))),1)
		Next nY
		MaFisEndLoad(1)
		
		dbSelectArea("SB1")
		dbSetOrder(1)
		dbSeek( xFilial() + oProcess:oHtml:RetByName("it.produto")[_nind] )
		cIcm 				:= SC8->C8_PICM
		
		_cC8_ITEM := oProcess:oHtml:RetByName("it.item")[_nind]
		dbSelectArea("SC8")
		dbSetOrder(1)
		dbSeek( xFilial("SC8") + Padr(_cC8_NUM,6) + Padr(_cC8_FORNECE,6) + _cC8_LOJA + _cC8_ITEM )
		//caso o prazo tenha vencido nใo permite gravacao
		If C8_WFID == "9999"
			Return
		EndIf
		RecLock("SC8",.f.)
		SC8->C8_WFCO  	:= "1004"
		SC8->C8_PRECO	:= Val(oProcess:oHtml:RetByName("it.preco")[_nind])
		SC8->C8_TOTAL	:= Val(oProcess:oHtml:RetByName("it.valor")[_nind])
		/*
		//SC8->C8_ALIIPI := Val(oProcess:oHtml:RetByName("it.ipi"  )[_nind])
		//caso o IPI nใo seja zero
		If Val(oProcess:oHtml:RetByName("it.ipi"  )[_nind])>0
			C8_VALIPI  := (Val(oProcess:oHtml:RetByName("it.ipi"  )[_nind])*Val(oProcess:oHtml:RetByName("it.valor")[_nind]))/100
			C8_BASEIPI := SC8->C8_TOTAL
		EndIf
		*/
		SC8->C8_PRAZO  	:= Val(oProcess:oHtml:RetByName("it.prazo")[_nind])
		//caso o icm nao seja zero
		MaFisAlt("IT_ALIQICM",cIcm,1)
		C8_PICM        	:= MaFisRet(1,"IT_ALIQICM")
		
		If C8_PICM >0
			C8_BASEICM 	:= SC8->C8_TOTAL
			MaFisAlt("IT_VALICM",cIcm,1)
			C8_VALICM	:= MaFisRet(1,"IT_VALICM")
		EndIf
		//		_C8_DATPRF     :=     oProcess:oHtml:RetByName("it.dia"  )[_nind] + "/" + ;
		//		oProcess:oHtml:RetByName("it.mes"  )[_nind] + "/" + ;
		//		oProcess:oHtml:RetByName("it.ano"  )[_nind]
		//		SC8->C8_DATPRF := CTOD(_C8_DATPRF)
		SC8->C8_COND   	:= Substr(oProcess:oHtml:RetByName("pagamento"),1,3)
		SC8->C8_TPFRETE	:= Substr(oProcess:oHtml:RetByName("Frete"),1,1)
		
		iif( oProcess:oHtml:RetByName("Frete") = "FOB", ;
		SC8->C8_VALFRE	:= 0, ;
		SC8->C8_VALFRE	:= Val(oProcess:oHtml:RetByName("it.quant")[_nind]) * ;
		Val(oProcess:oHtml:RetByName("it.preco")[_nind]) / ;
		Val(oProcess:oHtml:RetByName("totped") ) *         ;
		Val(oProcess:oHtml:RetByName("valfre") ) )
		
		iif( Val(oProcess:oHtml:RetByName("vldesc")) == 0 ,;
		SC8->C8_VLDESC	:= 0, ;
		SC8->C8_VLDESC	:= Val(oProcess:oHtml:RetByName("it.quant")[_nind]) * ;
		Val(oProcess:oHtml:RetByName("it.preco")[_nind]) / ;
		Val(oProcess:oHtml:RetByName("totped") ) * ;
		Val(oProcess:oHtml:RetByName("vldesc") ) )
		
		
		MsUnlock()
		MaFisEnd()
		
		
	next
	
	cEmailComp	:= 'soliveira@ncgames.com.br'
	Aprovar(oProcess,cEmailComp)
	
Else //caso tenha sido rejeitado

	aCab	:= {	{"C8_NUM"	,_cC8_NUM,NIL}}
	
	//ATUALIZA O SC8
	for _nind := 1 to len(oProcess:oHtml:RetByName("it.preco"))
		
		_cC8_ITEM := oProcess:oHtml:RetByName("it.item")[_nind]
		//PEGA O EMAIL PARA AVISAR O COMPRADOR
		dbSelectArea("SC8")
		dbSetOrder(1)
		dbSeek( xFilial("SC8") + Padr(_cC8_NUM,6) + Padr(_cC8_FORNECE,6) + _cC8_LOJA + _cC8_ITEM )
		//caso o prazo tenha vencido nใo permite gravacao
		If C8_WFCO == "9999"
			Return
		EndIf
		cEmailComp 	:= C8_WFEMAIL
		
		lMsErroAuto := .F.
		
		aadd(aItem,   {{"C8_ITEM",_cC8_ITEM ,NIL},;
		{"C8_FORNECE",_cC8_FORNECE ,NIL},;
		{"C8_LOJA",_cC8_LOJA ,NIL}})
		
		MSExecAuto({|x,y,z| mata150(x,y,z)},aCab,aItem,5) //EXCLUI
		
		If lMsErroAuto
			Alert("Erro")
		Else
			Alert("Ok")
		Endif
		
		
	Next
	Reprovar(oProcess,cEmailComp)
	
endif
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณReprovar  บAutor  ณMicrosiga           บ Data ณ  11/23/05   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณEnvia e-mail para os compradores                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

static function Reprovar(oProcess,cEmailComp)

_user := Subs(cUsuario,7,15)
oProcess:ClientName(_user)
oProcess:cTo      := cEmailComp
oProcess:cCC      := ""
oProcess:cBCC     := "thiago@stch.com.br;rogerio@stch.com.br"
oProcess:cSubject := "Desist๊ncia do Fornecedor"

oProcess:cBody    := ""
oProcess:bReturn  := ""
oProcess:bTimeOut := ""

oProcess:Start()
oProcess:Finish()

WFSendMail()
return

//////////////////////////////////////////////////////////////////////////////////////////
// ************************************************************************************ //
//////////////////////////////////////////////////////////////////////////////////////////
static function Aprovar(oProcess,cEmailComp)

_user := Subs(cUsuario,7,15)
oProcess:ClientName(_user)
oProcess:cTo      := 'soliveira@ncgames.com.br'
oProcess:cCC      := ""
oProcess:cBCC     := "thiago@stch.com.br;rogerio@stch.com.br"
oProcess:cSubject := "A cotacao foi respondida por um dos fornecedores"
oProcess:cBody    := "O Fornecedor respondeu a cotacao"
oProcess:bReturn  := ""
oProcess:bTimeOut := ""

oProcess:Start()
oProcess:Finish()

WFSendMail()

return
