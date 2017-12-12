#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "FILEIO.CH"
#INCLUDE "AP5MAIL.CH"


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGFG101  บAutor  ณMicrosiga           บ Data ณ  09/27/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ FUN็๕ES GEN้RICAS PARA UTILIZA็ใO EM OUTROS FONTES         บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ NC GAMES - TECNOLOGIA DA INFORMAวรO                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function NCGFG101()

Return()

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMyNewSX6  บAutor  ณAlmir Bandina       บ Data ณ  10/02/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescri็ใo ณAtualiza o arquivo de parโmetros.                           บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNC GAMES - TECNOLOGIA DA INFORMAวรO                         บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametro ณExpC1 = Nome do Parโmetro                                   บฑฑ
ฑฑบ          ณExpX1 = Conte๚do do Parโmetro           	                  บฑฑ
ฑฑบ          ณExpC2 = Tipo do Parโmetro                                   บฑฑ
ฑฑบ          ณExpC3 = Descri็ใo em portugues                              บฑฑ
ฑฑบ          ณExpC4 = Descri็ใo em espanhol                               บฑฑ
ฑฑบ          ณExpC5 = Descri็ใo em ingles                                 บฑฑ
ฑฑบ          ณExpL1 = Grava o conte๚do se existir o parโmetro             บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function MyNewSX6( cMvPar, xValor, cTipo, cDescP, cDescS, cDescE, lAlter )

Local aAreaAtu	:= GetArea()
Local lRecLock	:= .F.
Local xlReturn

Default lAlter := .F.

If ( ValType( xValor ) == "D" )
	If Len(StrTran(Dtoc(xValor),"/","")) == 6
		xValor := Dtoc( xValor, "ddmmyy" )
	Else
		xValor	:= Dtos( xValor )
	Endif
ElseIf ( ValType( xValor ) == "N" )
	xValor	:= AllTrim( Str( xValor ) )
ElseIf ( ValType( xValor ) == "L" )
	xValor	:= If ( xValor , ".T.", ".F." )
EndIf

DbSelectArea('SX6')
DbSetOrder(1)

lRecLock := !MsSeek( Space( Len( X6_FIL ) ) + Padr( cMvPar, Len( X6_VAR ) ) )

If lRecLock
	
	RecLock( "SX6", lRecLock )
	
	FieldPut( FieldPos( "X6_VAR" ), cMvPar )
	
	FieldPut( FieldPos( "X6_TIPO" ), cTipo )
	
	FieldPut( FieldPos( "X6_PROPRI" ), "U" )
	
	If !Empty( cDescP )
		FieldPut( FieldPos( "X6_DESCRIC" ), SubStr( cDescP, 1, Len( X6_DESCRIC ) ) )
		FieldPut( FieldPos( "X6_DESC1" ), SubStr( cDescP, Len( X6_DESC1 ) + 1, Len( X6_DESC1 ) ) )
		FieldPut( FieldPos( "X6_DESC2" ), SubStr( cDescP, ( Len( X6_DESC2 ) * 2 ) + 1, Len( X6_DESC2 ) ) )
	EndIf
	
	If !Empty( cDescS )
		FieldPut( FieldPos( "X6_DSCSPA" ), cDescS )
		FieldPut( FieldPos( "X6_DSCSPA1" ), SubStr( cDescS, Len( X6_DSCSPA1 ) + 1, Len( X6_DSCSPA1 ) ) )
		FieldPut( FieldPos( "X6_DSCSPA2" ), SubStr( cDescS, ( Len( X6_DSCSPA2 ) * 2 ) + 1, Len( X6_DSCSPA2 ) ) )
	EndIf
	
	If !Empty( cDescE )
		FieldPut( FieldPos( "X6_DSCENG" ), cDescE )
		FieldPut( FieldPos( "X6_DSCENG1" ), SubStr( cDescE, Len( X6_DSCENG1 ) + 1, Len( X6_DSCENG1 ) ) )
		FieldPut( FieldPos( "X6_DSCENG2" ), SubStr( cDescE, ( Len( X6_DSCENG2 ) * 2 ) + 1, Len( X6_DSCENG2 ) ) )
	EndIf
	
	If lRecLock .Or. lAlter
		FieldPut( FieldPos( "X6_CONTEUD" ), xValor )
		FieldPut( FieldPos( "X6_CONTSPA" ), xValor )
		FieldPut( FieldPos( "X6_CONTENG" ), xValor )
	EndIf
	
	MsUnlock()
	
EndIf

xlReturn := GetNewPar(cMvPar)

RestArea( aAreaAtu )

Return(xlReturn)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMySndError บAutor  ณFELIPE V. NAMBARA  บ Data ณ  09/27/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFUNวรO QUE ENVIA O ERRO DO SISTEMA POR E-MAIL PARA O ADMINISบฑฑ
ฑฑบ          ณTRADOR DO SISTEMA                                           บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNC GAMES - TECNOLOGIA DA INFORMAวรO                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function MySndError(oErro)

Local cMensagem		:= ""
Local cMyAux		:= ""
Local cMyPilha		:= ""
Local nPilha		:= 0
Local oHtmlModel    := Nil
Local cDirLog		:= U_MyNewSX6("NCG_000004"			,;
""														,;
"C"														,;
"Define o diret๓rio para grava็ใo dos logs de erro das rotinas customizadas."	,;
"Define o diret๓rio para grava็ใo dos logs de erro das rotinas customizadas."	,;
"Define o diret๓rio para grava็ใo dos logs de erro das rotinas customizadas."	,;
.F. )
Local cDirSystem	:= Alltrim(GetSrvProfString("STARTPATH",""))
Local nHandle		:= -1
Local cError		:= ""

If Right(cDirSystem,1) <> "\"
	cDirSystem += "\"
EndIf

If Right(cDirLog,1) <> "\"
	cDirLog += "\"
EndIf

MakeDir(cDirSystem + cDirLog)

While !Empty(cMyAux:=ProcName(nPilha))
	
	cMyPilha 	+= cMyAux + Chr(13) + Chr(10)
	cMyAux		:= ""
	nPilha++
	
EndDo



If File("\Workflow\Error.html")
	
	oHtmlModel := TWFHTML():New("\Workflow\Error.html")
	
	oHtmlModel:ValByName( "EMPRESA"		, SM0->(Alltrim(M0_NOME) + " - (" + Alltrim(M0_CODIGO) ) + ")" 		)
	oHtmlModel:ValByName( "FILIAL"		, SM0->(Alltrim(M0_FILIAL) + " - (" + Alltrim(M0_CODFIL) ) + ")" 	)
	oHtmlModel:ValByName( "SERVIDOR"	,  GetServerIp() 													)
	oHtmlModel:ValByName( "AMBIENTE"	,  GetEnvServer() 													)
	oHtmlModel:ValByName( "USUARIO"		,  GetWebJob()	 													)
	oHtmlModel:ValByName( "PILHA"		,  cMyPilha		 													)
	oHtmlModel:ValByName( "DATAHORA"	,  Dtoc(MsDate())+ " - " + Time() 									)
	oHtmlModel:ValByName( "ERRO"		,  oErro:ERRORSTACK													)
	
	cMensagem := oHtmlModel:HtmlCode()
	
Else
	
	cMensagem := "Sr(a) administrador(a),"
	cMensagem += "<Br></Br>"
	cMensagem += "<Br></Br>"
	cMensagem += "<Br></Br>"
	cMensagem += "Ocorreu o seguinte erro no ambiente do ERP Protheus: "
	cMensagem += "<Br></Br>"
	cMensagem += "<Br></Br>"
	cMensagem += "<table border='1'> "
	cMensagem += "	<tr> "
	cMensagem += "		<th>Empresa</th> "
	cMensagem += "		<th>Filial</th> "
	cMensagem += "		<th>Servidor</th> "
	cMensagem += "		<th>Ambiente</th> "
	cMensagem += "		<th>Usuแrio</th> "
	cMensagem += "		<th>Pilha de chamada</th> "
	cMensagem += "		<th>Data/hora</th> "
	cMensagem += "		<th>Erro</th> "
	cMensagem += "	</tr>"
	cMensagem += "	<tr>"
	cMensagem += "		<td>" + SM0->(Alltrim(M0_NOME) + " - (" + Alltrim(M0_CODIGO) ) + ")" + "</td>"
	cMensagem += "		<td>" + SM0->(Alltrim(M0_FILIAL) + " - (" + Alltrim(M0_CODFIL) ) + ")" + "</td>"
	cMensagem += "		<td>" + GetServerIp() + "</td>"
	cMensagem += "		<td>" + GetEnvServer() + "</td>"
	cMensagem += "		<td>" + GetWebJob() + "</td>"
	cMensagem += "		<td>" + cMyPilha + "</td>"
	cMensagem += "		<td>" + Dtoc(MsDate())+ " - " + Time() + "</td>"
	cMensagem += "		<td>" + oErro:ERRORSTACK + "</td>"
	cMensagem += "	</tr> "
	cMensagem += " </table> "
	cMensagem += "<Br></Br>"
	cMensagem += "<Br></Br>"
	cMensagem += "Departamento de Tecnologia Da Informacao"
	cMensagem += "<Br></Br>"
	cMensagem += "<Br></Br>"
	cMensagem += "At."
	
EndIf

U_MySndMail("ERRO PROTHEUS - " + SM0->(Alltrim(M0_NOME) + " - " + Alltrim(M0_FILIAL) + " - (" + Alltrim(M0_CODIGO) + Alltrim(M0_CODFIL)) + ")", cMensagem, Nil, Nil, Nil, Nil)

nHandle := FCreate(cDirSystem + cDirLog  + "error_" + dTos(MsDate()) + StrTran(Time(),":","") + ".log")

cError := "------------------------------------------------------------------------------------------" + Chr(13) + Chr(10)
cError += "EMPRESA - " + SM0->(Alltrim(M0_NOME) + " - (" + Alltrim(M0_CODIGO) ) + ")"  + Chr(13) + Chr(10)
cError += "FILIAL - " + SM0->(Alltrim(M0_FILIAL) + " - (" + Alltrim(M0_CODFIL) ) + ")"  + Chr(13) + Chr(10)
cError += "SERVIDOR - " + GetServerIp()  + Chr(13) + Chr(10)
cError += "AMBIENTE - " + GetEnvServer()  + Chr(13) + Chr(10)
cError += "USUARIO - " + GetWebJob()  + Chr(13) + Chr(10)
cError += "PILHA DE CHAMADA - " + cMyPilha  + Chr(13) + Chr(10)
cError += "DATA/HORA - " + Dtoc(MsDate())+ " - " + Time()  + Chr(13) + Chr(10)
cError += "ERRO - " + oErro:ERRORSTACK + " - " + Time()  + Chr(13) + Chr(10)
cError += "------------------------------------------------------------------------------------------" + Chr(13) + Chr(10)

FWrite(nHandle,cError)

FClose(nHandle)

Aviso(" TRATAMENTO DE ERRO",oErro:ERRORSTACK,{"Ok"},3)

Final(" FINALIZAวรO DO SISTEMA",,.T.)

Break

Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMySndMail  บAutor  ณFELIPE V. NAMBARA  บ Data ณ  09/27/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFUNวรO GENษRICA PARA ENVIO DE E-MAIL.                       บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณNC GAMES - TECNOLOGIA DA INFORMAวรO                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function MySndMail(cAssunto, cMensagem, aAnexos, cEmailTo, cEmailCc, cErro)

Local lRetorno 		:= .T.
Local cServer   := GetNewPar("MV_RELSERV","")
Local cAccount	:= GetNewPar("MV_RELACNT","")
Local cPassword	:= GetNewPar("MV_RELAPSW","")
Local lMailAuth := GetNewPar("MV_RELAUTH",.F.)

Default cEmailTo 	:= U_MyNewSX6("NCG_000001"			,;
""														,;
"C"														,;
"Define o e-mail para envio de erros ocorridos nas customiza็๕es do ERP Protheus."	,;
"Define o e-mail para envio de erros ocorridos nas customiza็๕es do ERP Protheus."	,;
"Define o e-mail para envio de erros ocorridos nas customiza็๕es do ERP Protheus."	,;
.F. )

Default cEmailCc 	:= U_MyNewSX6("NCG_000002"			,;
""														,;
"C"														,;
"Define o e-mail em c๓pia para envio de erros ocorridos nas customiza็๕es do ERP Protheus."	,;
"Define o e-mail em c๓pia para envio de erros ocorridos nas customiza็๕es do ERP Protheus."	,;
"Define o e-mail em c๓pia para envio de erros ocorridos nas customiza็๕es do ERP Protheus."	,;
.F. )

Default aAnexos		:= {}
Default cMensagem	:= ""
Default cAssunto	:= ""
Default cErro		:= ""

If !Empty(cEmailTo) .And. !Empty(cAssunto) .And. !Empty(cMensagem)
	
	If MailSmtpOn( cServer, cAccount, cPassword )
		
		If lMailAuth
			
			If ! ( lRetorno := MailAuth(cAccount,cPassword) )
				
				lRetorno := MailAuth(SubStr(cAccount,1,At("@",cAccount)-1),cPassword)
				
			EndIf
			
		Endif
		
		If lRetorno
			
			If !MailSend(cAccount,{cEmailTo},{cEmailCc},{},cAssunto,cMensagem,aAnexos,.F.)
				
				cErro := "Erro na tentativa de e-mail para " + cEmailTo + ". " + Mailgeterr()
				lRetorno := .F.
				
			EndIf
			
		Else
			
			cErro := "Erro na tentativa de autentica็ใo da conta " + cAccount + ". "
			lRetorno := .F.
			
		EndIf
		
		MailSmtpOff()
		
	Else
		
		cErro := "Erro na tentativa de conexใo com o servidor SMTP: " + cServer + " com a conta " + cAccount + ". "
		lRetorno := .F.
		
	EndIf
	
Else
	
	If Empty(cEmailTo)
		
		cErro := "ษ neessแrio fornecedor o destinแtario para o e-mail. "
		lRetorno := .F.
		
	EndIf
	
	If Empty(cAssunto)
		
		cErro := "ษ neessแrio fornecedor o assunto para o e-mail. "
		lRetorno := .F.
		
	EndIf
	
	If Empty(cMensagem)
		
		cErro := "ษ neessแrio fornecedor o corpo do e-mail. "
		lRetorno := .F.
		
	EndIf
	
Endif

Return(lRetorno)