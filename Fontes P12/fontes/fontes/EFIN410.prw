#INCLUDE "rwmake.ch"
#INCLUDE "TOTVS.CH"
#Include "topconn.Ch"
#Include "tbiconn.Ch"


User Function EFIN410(aDados)

	Default aDados:={"01","03"}

	RpcSetEnv(aDados[1],aDados[2])//Empresa 01 Filial Barueri

	SEFIN410()

	RpcClearEnv()
	
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณEFIN410   บAutor  ณMicrosiga           บ Data ณ  08/26/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function  SEFIN410()

	Local _aArea     	:= GetArea()
	Local aAreaSA1	:= SA1->(GetArea())
	Local aAliasSql	:= GetNextAlias()

	Local nDiasPV		:= SuperGetMv("NCG_000080",.F.,180)
	Local nDiasMV		:= SuperGetMv("NCG_000081",.F.,120)
	Local nDiasKA		:= SuperGetMv("NCG_000082",.F.,180)
	Local _lBLQL     	:= .F.
	Local nDiasBlq 	:= 180

	Local aClientes 	:= {}
	Local aCliAlert 	:= {}
	
	Local cPara   	:= AllTrim(U_MyNewSX6("NC_EF41001","lfelipe@ncgames.com.br","C","Workflow de clientes inativos Financeiro","Workflow de clientes inativos Financeiro","Workflow de clientes inativos Financeiro",.F. ))
	Local nAvisoBlq	:= U_MyNewSX6("NCG_000092","5","N","Dias de antecend๊ncia para informar que o cliente serแ blq","","",.F. )
		
	Local cSubject	:= "CLIENTES INATIVOS "+ DtoC(MsDate()) + "."
	Local cSubAlert	:= "CLIENTES QUE SERรO INATIVADOS ATษ "+ DtoC(MsDate()+ nAvisoBlq) + "."
	Local nAviso		:= 180 - nAvisoBlq

	Conout("Execucao EFIN410 em "+DTOC(MsDate())+" as "+Time())
	
	BeginSql Alias aAliasSql
	
		Select R_e_c_n_o_ RecSA1
		From %Table:SA1% SA1
		Where SA1.A1_FILIAL = %xfilial:SA1%
		AND SA1.%notDel%
		AND SA1.A1_MSBLQL <> '1'
		AND SA1.A1_YBLQFIN <> '1'
		AND SA1.A1_LC > 0
	
	EndSql
	
	Do While (aAliasSql)->(!Eof())
		
		SA1->(dbGoto( (aAliasSql)->RecSA1 ) )
	
		Do Case
		Case SA1->A1_YCANAL == "000001"//KA
			nDiasBlq	:= nDiasKA
			nAviso		:= nDiasKA - nAvisoBlq
		Case SA1->A1_YCANAL == "000013"//MedioVarejo
			nDiasBlq	:= nDiasMV
			nAviso		:= nDiasMV - nAvisoBlq
		Case SA1->A1_YCANAL == "000012"//PequenoVarejo
			nDiasBlq	:= nDiasPV
			nAviso		:= nDiasPV - nAvisoBlq
		EndCase
	
		If SA1->A1_ULTCOM == (MsDate()-nAviso)
			
			If GetVldVen(SA1->A1_COD, SA1->A1_LOJA) .And. !SA1->A1_YBLQFIN == "3"
			
				SA1->(RecLock("SA1",.F.))
			
				SA1->A1_YBLQFIN	:= "3"
	  	  	
				SA1->(MsUnlock())
			
				AADD(aCliAlert,{SA1->A1_VEND,SA1->A1_COD,SA1->A1_LOJA,SA1->A1_NOME,cValToChar(SA1->A1_ULTCOM),cValToChar(SA1->A1_ULTCOM+nDiasBlq)})
				
			EndIf
			
		ElseIf SA1->A1_ULTCOM < (MsDate()-nDiasBlq) .OR. EMPTY(SA1->A1_ULTCOM)

			If GetVldVen(SA1->A1_COD, SA1->A1_LOJA) .Or. (MsDate() > SA1->A1_VENCLC)
			
				SA1->(RecLock("SA1",.F.))
			
				cObs				:= SA1->A1_PRF_OBS
			
				SA1->A1_RISCO		:= "E"
				SA1->A1_YBLQFIN	:= "1" // INCLUIDO POR ROBERTO SUPERTECH
				SA1->A1_PRF_OBS	:= UPPER(cObs) + CRLF + " LIMITE DE CRษDITO ZERADO AUTOMATICAMENTE POR INATIVIDADE DO CLIENTE EM " + Dtoc(dDatabase)+ " ภS " + Time() + "  LIMITE ANTERIOR = R$ " + Transform(SA1->A1_LC, "@E 9,999,999.99")
				SA1->A1_LC			:= 0
		
				SA1->(MsUnlock())
			
				AADD(aClientes,{SA1->A1_COD,SA1->A1_LOJA,SA1->A1_NOME,cValToChar(SA1->A1_ULTCOM)})
			EndIf
		EndIf
	
		(aAliasSql)->(dbSkip())
	EndDo


	_fEnv_Email(aClientes,cPara,cSubject,.T.)
	_fEnv_Email(aCliAlert,cPara,cSubAlert,.f.)

	If Select(aAliasSql)>0
		(aAliasSql)->(DbCloseArea())
	EndIf

	RestArea(aAreaSA1)
	RestArea(_aArea)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGetVldVen  บAutor  ณMicrosiga          บ Data ณ  05/14/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRetorna se ja houve venda para o cliente                    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function _fEnv_Email(_aClientes,cPara,cAssunto,lBlq)

	Local cUser 		:= GetNewPar("MV_RELACNT","")
	Local cPass 		:= GetNewPar("MV_RELAPSW","")
	Local cSendSrv 	:= GetNewPar("MV_RELSERV","")
	Local lMailAuth	:= GetNewPar("MV_RELAUTH",.F.)
	Local nSmtpPort 	:= GetNewPar("MV_GCPPORT","")
	Local lSSL	:= SuperGetMv("MV_RELSSL",.F.)
	Local lTLS	:= SuperGetMv("MV_RELTLS",.F.)

	default _aClientes := {}
	
	If Empty(cPara)
		Return
	EndIf
		
	If !Empty(_aClientes)

		_cClientes:=''

		cBody := '<!DOCTYPE html>'
		cBody += '<html lang="pt-br">'
		cBody += '	<head>'
		cBody += '		<title> Sem Titulo </title>'
		cBody += '	</head>'
		cBody += '	<body>'
		If lBlq
			cBody += '   <h2>Lista de clientes Inativos </h2>'
			cBody += '   <br/>'

			cBody+='<table style="border-collapse:collapse; width:90%; border: 1px solid black;" cellspacing="0" cellpadding="2">'
			cBody+=' 	<tr>'
			cBody+=' 		<th style="background-color: #999999; border: 1px solid black;" >CODIGO </th>'
			cBody+=' 		<th style="background-color: #999999; border: 1px solid black;" >LOJA </th>'
			cBody+=' 		<th style="background-color: #999999; border: 1px solid black;" >CLIENTE </th>'
			cBody+=' 		<th style="background-color: #999999; border: 1px solid black;" >ULTIMA COMPRA </th>'
			cBody+='	</tr>'

			For _nI:= 1  To  Len(_aClientes)
	
				_cClientes := _cClientes + AllTrim(_aClientes[_nI,1])+' - '+AllTrim(_aClientes[_nI,2])+' - '+AllTrim(_aClientes[_nI,3])+Chr(13)+Chr(10)
	
				cBody +=	'<tr> '
				cBody +=	'	<td style="border: 1px solid black;">' + AllTrim(_aClientes[_nI,1]) + ' </td>'
				cBody +=	'	<td style="border: 1px solid black;">' + AllTrim(_aClientes[_nI,2]) + ' </td>'
				cBody +=	'	<td style="border: 1px solid black;">' + AllTrim(_aClientes[_nI,3]) + ' </td>'
				cBody +=	'	<td style="border: 1px solid black;">' + AllTrim(_aClientes[_nI,4]) + ' </td>'
				cBody +=	'</tr>'
	
			Next
		
		Else
			cBody += '   <h2>Lista de clientes que serใo Inativados em 5 dias </h2>'
			cBody += '   <br/>'

			cBody+='<table style="border-collapse:collapse; width:90%; border: 1px solid black;" cellspacing="0" cellpadding="2">'
			cBody+=' 	<tr>'
			cBody+=' 		<th style="background-color: #999999; border: 1px solid black;" >VN </th>'
			cBody+=' 		<th style="background-color: #999999; border: 1px solid black;" >CLIENTE </th>'
			cBody+=' 		<th style="background-color: #999999; border: 1px solid black;" >LOJA </th>'
			cBody+=' 		<th style="background-color: #999999; border: 1px solid black;" >CLIENTE </th>'
			cBody+=' 		<th style="background-color: #999999; border: 1px solid black;" >ULTIMA COMPRA </th>'
			cBody+=' 		<th style="background-color: #999999; border: 1px solid black;" >SERA INATIVADO EM </th>'
			cBody+='	</tr>'

			For _nI:= 1  To  Len(_aClientes)
	
				_cClientes := _cClientes + AllTrim(_aClientes[_nI,1])+' - '+AllTrim(_aClientes[_nI,2])+' - '+AllTrim(_aClientes[_nI,3])+Chr(13)+Chr(10)
	
				cBody +=	'<tr> '
				cBody +=	'	<td style="border: 1px solid black;">' + AllTrim(_aClientes[_nI,1]) + ' </td>'
				cBody +=	'	<td style="border: 1px solid black;">' + AllTrim(_aClientes[_nI,2]) + ' </td>'
				cBody +=	'	<td style="border: 1px solid black;">' + AllTrim(_aClientes[_nI,3]) + ' </td>'
				cBody +=	'	<td style="border: 1px solid black;">' + AllTrim(_aClientes[_nI,4]) + ' </td>'
				cBody +=	'	<td style="border: 1px solid black;">' + AllTrim(_aClientes[_nI,5]) + ' </td>'
				cBody +=	'	<td style="border: 1px solid black;">' + AllTrim(_aClientes[_nI,6]) + ' </td>'
				cBody +=	'</tr>'
			Next
	
		EndIf

		cBody += '</table>'
		cBody += '<br/>'
		cBody += '<hr color=CC0000 /> '
		cBody += '		<font size="2" face="Verdana">E-Mail enviado automaticamente pelo sistema Protheus - NC GAMES.</font><br>'
		cBody += '	</body>'
		cBody += '</html>'

		oMessage := TMailMessage():New()
		oMessage:Clear()

		oMessage:cDate 		:= cValToChar( Date() )
		oMessage:cFrom 		:= "workflow2@ncgames.com.br"
		oMessage:cTo 			:= cPara
		oMessage:cSubject 	:= cAssunto
		oMessage:cBody 		:= cBody

		If At(":",cSendSrv) > 0
			cSendSrv := SubStr(cSendSrv,1,At(":",cSendSrv)-1)
		EndIf

		oServer := TMailManager():New()
		oServer:SetUseSSL( lSSL ) //ADD 26/05/2015 -- configura็ใo de gmail
		oServer:SetUseTLS(lTLS ) //ADD 23/06/2016 -- configura็ใo de gmail

		xRet := oServer:Init( "", cSendSrv, cUser, cPass,/*nPopPort*/,nSmtpPort)
		if xRet != 0
			cMsg := "Could not initialize SMTP server: " + oServer:GetErrorString( xRet )
			conout( cMsg )
			return
		endif

		xRet := oServer:SetSMTPTimeout( 60 )
		if xRet != 0
			cMsg := "Could not set timeout to " + cValToChar( nTimeout )
			conout( cMsg )
		endif

		xRet := oServer:SMTPConnect()
		if xRet <> 0
			cMsg := "Could not connect on SMTP server: " + oServer:GetErrorString( xRet )
			conout( cMsg )
			return
		endif

		xRet := oServer:SmtpAuth( cUser, cPass )
		if xRet <> 0
			cMsg := "Could not authenticate on SMTP server: " + oServer:GetErrorString( xRet )
			conout( cMsg )
			oServer:SMTPDisconnect()
		endif

		xRet := oMessage:Send( oServer )
		if xRet <> 0
			cMsg := "Could not send message: " + oServer:GetErrorString( xRet )
			conout( cMsg )
		endif

		xRet := oServer:SMTPDisconnect()
		if xRet <> 0
			cMsg := "Could not disconnect from SMTP server: " + oServer:GetErrorString( xRet )
			conout( cMsg )
		endif
	endif


Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGetVldVen  บAutor  ณMicrosiga          บ Data ณ  05/14/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRetorna se ja houve venda para o cliente                    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetVldVen(cCodCli, cLoja)

	Local aArea := GetArea()
	Local lRet	:= .F.

	Default cCodCli := ""
	Default cLoja 	:= ""

	DbSelectArea("SD2")
	DbSetOrder(9)
	If SD2->(MsSeek(xFilial("SD2");
			+ PADR(cCodCli	, TAMSX3("D2_CLIENTE")[1]) ;
			+ PADR(cLoja 	, TAMSX3("D2_LOJA")[1]) ;
			))
		
		lRet	:= .T.
	Else
		lRet	:= .F.
	EndIf

	RestArea(aArea)
Return lRet



