#INCLUDE "rwmake.ch"
#include 'Ap5Mail.ch'
#INCLUDE "topconn.ch"
#include "tbiconn.ch"
/*/                                             
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ENVIAEMAILº Autor ³ ERICH BUTTNER	     º Data ³  01/08/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Rotina de envio de e-mail.                                 º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP6 IDE                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function ENVIAEMAIL(cTO, cCC, cBCC, cSUBJECT, cBODY, aFiles)

Local cServer   := ALLTRIM(GETMV("MV_RELSERV"))//'192.168.0.209' //'smtp.sao.terra.com.br'
Local cAccount  := ALLTRIM(GETMV("MV_RELACNT"))//'nfe@ncgames.com.br' 
Local cEnvia    := ALLTRIM(GETMV("MV_RELACNT"))//'nfe@ncgames.com.br' 
Local cPassword := ALLTRIM(GETMV("MV_RELAPSW"))//'games105' 
Local CRLF      := Chr(13) + Chr(10)
Local lRelauth := .T.		// Parametro que indica se existe autenticacao no e-mail
Local lRet	   := .f.

Private _aARQS := {}

Private _lENVIA := .T.

IF ValType(aFiles) == "U"
	aFiles := {}
ENDIF

_aARQS := ACLONE(aFiles)

cTO 		:= cTO

cCC 		:= IIF(ValType(cCC) == "U",'', cCC)

//cCC 		:= IIF(_lENVIA, cCC, 'erich.buttner@ftg.com.br')

cBCC 		:= IIF(ValType(cBCC) == "U",'erich.buttner@ftg.com.br', cBCC)

cBCC 		:= IIF(_lENVIA, cBCC, 'erich.buttner@ftg.com.br')

cSUBJECT 	:= IIF( ValType(cSUBJECT) == "U", 'E-mail pelo Protheus', cSUBJECT)

cBODY := IIF( ValType(cBODY) == "U", '', cBODY)

//RETURN

//cMensagem := 'Teste de mensagem, com arquivo anexo.' + CRLF +;
//             'Segunda Linha'

CONNECT SMTP SERVER cServer ACCOUNT cAccount PASSWORD cPassword Result lConectou

// Se existe autenticacao para envio valida pela funcao MAILAUTH
If lRelauth
	lRet := Mailauth(cAccount,cPassword)
Else
	lRet := .T.
Endif

_cFILES := ""
IF Len(_aARQS) > 0

	//	SEND MAIL FROM cEnvia	TO cTO	CC cCC	BCC cBCC SUBJECT cSUBJECT	BODY cBODY ATTACHMENT  _aARQS[1], _aARQS[2] RESULT lEnviado
	DO CASE
		CASE LEN(_aARQS) == 1
			SEND MAIL FROM cEnvia	TO cTO	CC cCC	BCC cBCC SUBJECT cSUBJECT	BODY cBODY ATTACHMENT  _aARQS[1] RESULT lEnviado
		CASE LEN(_aARQS) == 2
			SEND MAIL FROM cEnvia	TO cTO	CC cCC	BCC cBCC SUBJECT cSUBJECT	BODY cBODY ATTACHMENT  _aARQS[1], _aARQS[2] RESULT lEnviado
		CASE LEN(_aARQS) == 3
			SEND MAIL FROM cEnvia	TO cTO	CC cCC	BCC cBCC SUBJECT cSUBJECT	BODY cBODY ATTACHMENT  _aARQS[1], _aARQS[2], _aARQS[3] RESULT lEnviado
		CASE LEN(_aARQS) == 4
			SEND MAIL FROM cEnvia	TO cTO	CC cCC	BCC cBCC SUBJECT cSUBJECT	BODY cBODY ATTACHMENT  _aARQS[1], _aARQS[2], _aARQS[3], _aARQS[4] RESULT lEnviado
		CASE LEN(_aARQS) == 5
			SEND MAIL FROM cEnvia	TO cTO	CC cCC	BCC cBCC SUBJECT cSUBJECT	BODY cBODY ATTACHMENT  _aARQS[1], _aARQS[2], _aARQS[3], _aARQS[4], _aARQS[5] RESULT lEnviado
	ENDCASE
ELSE
	SEND MAIL FROM cEnvia	TO cTO	CC cCC	BCC cBCC SUBJECT cSUBJECT	BODY cBODY RESULT lEnviado
ENDIF

If lEnviado
	//	Alert("Enviado E-Mail")
	_cT := ""
Else
	cERRO := ""
	GET MAIL ERROR cERRO
	CONOUT("ERRO AO MANDAR E-MAIL: "+cERRO)
	_cT := ""
	//	Alert(cERRO)
Endif

DISCONNECT SMTP SERVER Result lDisConectou

If lDisConectou
	//	Alert("Desconectado com servidor de E-Mail - " + cServer)
Endif

Return   