#INCLUDE "PROTHEUS.CH"
#INCLUDE "TBICONN.CH"

/* 
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
������������������������������������������������������������������������������ͻ��
���                ___  "  ___                             		      		   ���
���              ( ___ \|/ ___ ) Kazoolo                   		      		   ���
���               ( __ /|\ __ )  Codefacttory 				      			   ���
������������������������������������������������������������������������������͹��
���Funcao    �KZMAILVD		 �Autor  �Adam Diniz Lima 	  � Data �23/05/2011   ���
������������������������������������������������������������������������������͹��
���Desc.     �Envia email para o vendedores em caso de estorno de nota fiscal  ���
������������������������������������������������������������������������������͹��
���Uso       �			                                                       ���
������������������������������������������������������������������������������͹��
���Parametros�clMail - Email dos responsaveis da area, nao obrigatorio  	   ���
������������������������������������������������������������������������������͹��
���Retorno   | llRet - logico, informando sucesso no envio do email		       ���
������������������������������������������������������������������������������ͼ��
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
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
	Conout(dtoc( Date() ) + " " + Time() + " O servidor de e-mails n�o est� preenchido no par�metro MV_RELSERV.")
	llCond	:= .F.
ElseIf ValType(llSmtpAuth) <> "L"
	Conout(dtoc( Date() ) + " " + Time() + " N�o foi informado se o servidor requer autentica��o no par�metro MV_RELAUTH.")
	llCond	:= .F.
ElseIf Empty(clMailCont)
	Conout(dtoc( Date() ) + " " + Time() + " A conta de envio de e-mails n�o est� preenchida no par�metro MV_RELACNT.")
	llCond	:= .F.
ElseIf Empty(clMailSenh)
	Conout(dtoc( Date() ) + " " + Time() + " A senha da conta de envio de e-mails n�o est� preenchida no par�metro MV_RELAPSW.")
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
clBody += "N�mero da Nota Fiscal 	: " + SF2->F2_DOC				+ CRLF
clBody += "S�rie da Nota Fiscal		: " + SF2->F2_SERIE				+ CRLF
clBody += "N�mero do Pedido EDI  	: " + SC5->C5_NUMEDI			+ CRLF
clBody += "N�mero do Pedido      	: " + SC9->C9_PEDIDO			+ CRLF
clBody += "C�digo do Cliente		: " + SC5->C5_CLIENTE			+ CRLF
clBody += "Loja do Cliente		 	: " + SC5->C5_LOJACLI			+ CRLF
clBody += "Nome do Cliente		 	: " + Posicione("SA1",1,xFilial("SA1")+SC5->C5_CLIENTE+SC5->C5_LOJACLI ,"A1_NREDUZ") 	+ CRLF
clBody += "Data da Ocorr�ncia	 	: " + DtoC(dDataBase)	+ CRLF 	+ CRLF	+ CRLF
clBody += "____________________________________________ " + CRLF
clBody += "E-Mail Autom�tico via Protheus  " + CRLF
clBody += "Favor N�o Responder  " + CRLF
//����������������������������������������������������������������������������������Ŀ
//| conecta uma vez com o servidor de e-mails                                        |
//������������������������������������������������������������������������������������ 
If llCond
	If llOk
		CONNECT SMTP SERVER clMailServ ACCOUNT clMailCont PASSWORD clMailSenh RESULT llOk
	Else
		Conout(dtoc( Date() ) + " " + Time() + " N�o foi poss�vel estabelecer a conex�o com o servidor de e-mails. Par�metro relacionado: MV_RELSERV.")
		llCond	:= .F.
	EndIf 
EndIf	

//����������������������������������������������������������������������������������Ŀ
//| efetua a autenticacao, conforme parametro                                        |
//������������������������������������������������������������������������������������ 
If llCond
	If llSmtpAuth
		llAutOk := MailAuth(clMailCont, clMailSenh)
		If !llAutOK
			Conout(dtoc( Date() ) + " " + Time() + " Falha na autentica��o do usu�rio no servidor de e-mails. Par�metro relacionado: MV_RELACNT.")
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
			Conout(dtoc( Date() ) + " " + Time() + " N�o foi poss�vel enviar o e-mail.")
			llCond	:= .F.
    	Else
    		llRet := .T.
		EndIf
	EndIf  
EndIf	
	
//������������������������������������������������������������������������Ŀ
//�desconecta o servidor de e-mails	                                       �
//��������������������������������������������������������������������������
If llOk
	DISCONNECT SMTP SERVER
EndIf

Return llRet
