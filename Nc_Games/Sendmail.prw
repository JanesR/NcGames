#include "rwmake.ch"
#include "ap5mail.ch"

/////////////////////////////////////////////////////////////////////////
// ******************************************************************* //
/////////////////////////////////////////////////////////////////////////
User Function SNDMAIL(aPARA,cASSUNTO,_MSG,aFiles)

// ENVIA EMAIL
XSERV 		:= 	U_MyNewSX6(	"HD_SMTPSRV", ;
							"ncsrvsbs", ;
							"C", ;
							"Servidor SMTP do HD",;
							"Servidor SMTP do HD",;
							"Servidor SMTP do HD",;
							.F. )

XCONTA 		:= 	U_MyNewSX6(	"HD_RELACNT", ;
							"workflow@ncgames.com.br", ;
							"C", ;
							"Conta a ser utilizada no envio de E-Mail do HD",;
							"Conta a ser utilizada no envio de E-Mail do HD",;
							"Conta a ser utilizada no envio de E-Mail do HD",;
							.F. )

XPASS	 		:= 	U_MyNewSX6(	"HD_ENVPSW", ;
							"W.2ncgames", ;
							"C", ;
							"Senha de autenticação SMTP do e-mail do HD",;
							"Senha de autenticação SMTP do e-mail do HD",;
							"Senha de autenticação SMTP do e-mail do HD",;
							.F. )
XCTA2 		:= XCONTA
lAutentica	:= GETMV("MV_RELAUTH")

CONNECT SMTP SERVER XSERV ACCOUNT XCONTA PASSWORD XPASS RESULT lResult
IF lAutentica
	mailauth(XCTA2,XPASS)
ENDIF

aResul	:= ""

If lResult

	FOR i := 1 TO LEN(aPARA)
		if !empty(alltrim(aPARA[i]))
			SEND MAIL FROM XCONTA to  aPARA[i] SUBJECT cASSUNTO BODY _msg FORMAT TEXT RESULT lResult //ATTACHMENT aFiles[1]	
			If !lResult
				//Erro no envio do email
				GET MAIL ERROR cError
				Help(" ",1,"ATENCAO",,"SEND MAIL" + cError,4,5)
			else
			 	aResul:=aResul+","+alltrim(lower(aPARA[i]))//msginfo("Mensagem enviada para " + alltrim(lower(APARA[i])) + " com sucesso")
			EndIf
		endif

	NEXT i

	DISCONNECT SMTP SERVER
    
    //msginfo("Mensagem enviada para " + alltrim(aResul) + " com sucesso")
Else
	//Erro na conexao com o SMTP Server
	GET MAIL ERROR cError
	Help(" ",1,"ATENCAO",,"SMTP" + cError,4,5)
EndIf

//restarea(XSC5)

RETURN lResult
