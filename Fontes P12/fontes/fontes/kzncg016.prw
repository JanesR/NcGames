#INCLUDE "PROTHEUS.CH"
#INCLUDE "TBICONN.CH"

/* 
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออปฑฑ
ฑฑบ                ___  "  ___                             		      		   บฑฑ
ฑฑบ              ( ___ \|/ ___ ) Kazoolo                   		      		   บฑฑ
ฑฑบ               ( __ /|\ __ )  Codefacttory 				      			   บฑฑ
ฑฑฬออออออออออัอออออออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออนฑฑ
ฑฑบFuncao    ณKZMAILVD		 บAutor  ณAdam Diniz Lima 	  บ Data ณ23/05/2011   บฑฑ
ฑฑฬออออออออออุอออออออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณEnvia email para o vendedores em caso de estorno de nota fiscal  บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ			                                                       บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณclMail - Email dos responsaveis da area, nao obrigatorio  	   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   | llRet - logico, informando sucesso no envio do email		       บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function KZMAILVD(clMail)

Local clMailServ	:= SuperGetMV("MV_RELSERV", .T., "") 	//servidor de envio de e-mails
Local llSmtpAuth  	:= SuperGetMV("MV_RELAUTH", .T., "")	//determina se o servidor requer autenticacao
Local clMailCont	:= SuperGetMV("MV_RELACNT", .T., "") 	//conta que enviara o e-mail
Local clMailSenh	:= SuperGetMV("MV_RELAPSW", .T., "")	//senha da conta que enviara o e-mail
Local llOk 			:= .F.
Local llAutOk 		:= .F.
Local llSendOk		:= .F.
Local llRet 		:= .F. 
Local llCond		:= .T.

Local clTitle		:= ""
Local clVend		:= ""

Default clMail := " "

If Empty(clMail)
	clVend := SA3->A3_EMAIL
Else
	clVend := clMail
EndIf

If Empty(clMailServ)
	Conout(dtoc( Date() ) + " " + Time() + " O servidor de e-mails nใo estแ preenchido no parโmetro MV_RELSERV.")
	llCond	:= .F.
ElseIf ValType(llSmtpAuth) <> "L"
	Conout(dtoc( Date() ) + " " + Time() + " Nใo foi informado se o servidor requer autentica็ใo no parโmetro MV_RELAUTH.")
	llCond	:= .F.
ElseIf Empty(clMailCont)
	Conout(dtoc( Date() ) + " " + Time() + " A conta de envio de e-mails nใo estแ preenchida no parโmetro MV_RELACNT.")
	llCond	:= .F.
ElseIf Empty(clMailSenh)
	Conout(dtoc( Date() ) + " " + Time() + " A senha da conta de envio de e-mails nใo estแ preenchida no parโmetro MV_RELAPSW.")
	llCond	:= .F.
Else
	llOk := .T.
EndIf
// Titulo do Email
clTitle	:= "Cancelamento Nota Fiscal"

//Monta corpo do ema
clBody := "<b>Cancelamento Nota Fiscal</b>" + CRLF + CRLF
clBody += "<b>E-mail informativo referente ao cancelamento de uma Nota Fiscal. </b>" + CRLF + CRLF
clBody += "<b>Seguem Abaixo os Dados: </b> " + CRLF
clBody += "N๚mero da Nota Fiscal 	: " + SF2->F2_DOC				+ CRLF
clBody += "S้rie da Nota Fiscal		: " + SF2->F2_SERIE				+ CRLF
clBody += "N๚mero do Pedido EDI  	: " + SC5->C5_NUMEDI			+ CRLF
clBody += "N๚mero do Pedido      	: " + SC9->C9_PEDIDO			+ CRLF
clBody += "C๓digo do Cliente		: " + SC5->C5_CLIENTE			+ CRLF
clBody += "Loja do Cliente		 	: " + SC5->C5_LOJACLI			+ CRLF
clBody += "Nome do Cliente		 	: " + Posicione("SA1",1,xFilial("SA1")+SC5->C5_CLIENTE+SC5->C5_LOJACLI ,"A1_NREDUZ") 	+ CRLF
clBody += "Data da Ocorr๊ncia	 	: " + DtoC(dDataBase)	+ CRLF 	+ CRLF	+ CRLF
clBody += "____________________________________________ " + CRLF
clBody += "E-Mail Automแtico via Protheus  " + CRLF
clBody += "Favor Nใo Responder  " + CRLF
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//| conecta uma vez com o servidor de e-mails                                        |
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู 
If llCond
	If llOk
		CONNECT SMTP SERVER clMailServ ACCOUNT clMailCont PASSWORD clMailSenh RESULT llOk
	Else
		Conout(dtoc( Date() ) + " " + Time() + " Nใo foi possํvel estabelecer a conexใo com o servidor de e-mails. Parโmetro relacionado: MV_RELSERV.")
		llCond	:= .F.
	EndIf 
EndIf	

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//| efetua a autenticacao, conforme parametro                                        |
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู 
If llCond
	If llSmtpAuth
		llAutOk := MailAuth(clMailCont, clMailSenh)
		If !llAutOK
			Conout(dtoc( Date() ) + " " + Time() + " Falha na autentica็ใo do usuแrio no servidor de e-mails. Parโmetro relacionado: MV_RELACNT.")
			llCond	:= .F.			
		EndIf
	Else
		llAutOk := .T.
	EndIf 
EndIf	

If llCond 		
	If llOk .And. llAutOk 
		SEND MAIL FROM clMailCont to clVend SUBJECT clTitle BODY clBody RESULT llSendOk
		If !llSendOk
			Conout(dtoc( Date() ) + " " + Time() + " Nใo foi possํvel enviar o e-mail.")
			llCond	:= .F.
    	Else
    		llRet := .T.
		EndIf
	EndIf  
EndIf	
	
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณdesconecta o servidor de e-mails	                                       ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
If llOk
	DISCONNECT SMTP SERVER
EndIf

Return llRet
