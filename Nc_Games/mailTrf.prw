
#INCLUDE "TOPCONN.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#include "ap5mail.ch" 

User Function trfMailEnv(aDados) 
Local aArea := GetArea()
Default aDados:={"01","03",.F.}

RpcClearEnv()
RpcSettype(3)
RpcSetEnv(aDados[1],aDados[2])  

envMail()

RpcClearEnv()
RestArea
Return

static function envMail()

NCEnvEmail("teste", "teste", {"C:\relatorios\danfe\nf_000291436 lj 3004 para 3016.pdf"}, "jisidoro@ncgames.com.br", "", "")

return

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
		cErro := "Erro na tentativa de autenticação da conta " + cAccount + ". "
		lRetorno := .F.
	EndIf
	MailSmtpOff()
Else
	cErro := "Erro na tentativa de conexão com o servidor SMTP: " + cServer + " com a conta " + cAccount + ". "
	lRetorno := .F.
EndIf


Return lRetorno