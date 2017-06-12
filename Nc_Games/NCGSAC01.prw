#include "rwmake.ch"
#include "ap5mail.ch"
#include "tbiconn.ch"
#include "topconn.ch"
#INCLUDE "TOTVS.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGSAC01  บAutor  ณMicrosiga           บ Data ณ  01/23/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function NCGSAC01()
Local lCont	:= .T.
U_SAC01Att({"01","03",.T.,.T.,.F.,""})
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGSAC01  บAutor  ณMicrosiga           บ Data ณ  01/23/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function SAC01Att(alParams)
Local llJob			:= .T.
Local alAreaSM0 	:= {}
Local alUsrs		:= {}
Local oMessage
Local oPopServer
Local aAttInfo
Local cPopServer 		:= ""
Local cAccount 	   		:= ""
Local cPwd 				:= ""
Local nPortPop 	   		:= 110
Local nPopResult 		:= 0
Local nMessages 		:= 0
Local nMessage 			:= 0
Local lMessageDown 		:= .F.
Local nAtach 			:= 0
Local nMessageDown 		:= 0
Local cMnumOS			:= ""
Local cMailBox
Local oMail
Local oLogFile
Local oPop3
Local nMsg := 0
Local cRootPath
Local nHDL
Private _cFrom
Private cDirTemp			:= ""
Private cDirAnex			:= ""
Private cDirCham			:= ""
Private _cFrom				:=""
Private _cTo				:=""
Private _cCc				:=""
Private _cSubject			:=""
Private _cBody	   			:=""

If !Semaforo(.T.,@nHDL,"SAC01ATT")
	Return()
EndIf



Default alParams:={.F.,"","",.F.,.F.,""}

If alParams[3]
	RpcClearEnv()
	RpcSetType(3)
	RpcSetEnv(alParams[1],alParams[2])
Else
	alAreaSM0 := SM0->(GetArea())
	llJob:=.T.
EndIf

cRootPath:=U_MyNewSX6(	"SAC_DIRAIZ","\\192.168.0.187\totvsteste\Protheus_Data","C","Diret๓rio raiz dos arquivos temporแrios do SAC","Diret๓rio raiz dos arquivos temporแrios do SAC","Diret๓rio raiz dos arquivos temporแrios do SAC",.F. )

cDirTemp:=U_MyNewSX6(	"SAC_DIRTMP","\SAC\Temp\","C","Diret๓rio dos arquivos temporแrios do SAC","Diret๓rio dos arquivos temporแrios do SAC","Diret๓rio dos arquivos temporแrios do SAC",.F. )
SAC01Dir(cRootPath+cDirTemp)


cDirAnex	:=U_MyNewSX6("SAC_DIRANX","\SAC\Anexos\","C","Diret๓rio dos arquivos anexos do SAC","Diret๓rio dos arquivos anexos do SAC","Diret๓rio dos arquivos anexos do SAC",.F. )
SAC01Dir(cRootPath+cDirAnex)

cDirCham	:=AllTrim(U_MyNewSX6("SAC_DIRCHM","\SAC\Chamados\","C", "Diret๓rio dos arquivos de chamados do SAC","Diret๓rio dos arquivos de chamados do SAC","Diret๓rio dos arquivos de chamados do SAC",.F. ))
SAC01Dir(cRootPath+cDirCham)

cPopServer	:=U_MyNewSX6("SAC_POPSER","ncmail", "C", "Servidor Pop do SAC","Servidor Pop do SAC","Servidor Pop do SAC",.F. )
cAccount 	:=U_MyNewSX6("SAC_ACCOUN","sactst","C","Usuแrio da conta recebimento do e-mail do SAC","Usuแrio da conta recebimento do e-mail do SAC","Usuแrio da conta recebimento do e-mail do SAC",.F. )
cPwd	   	:=U_MyNewSX6("SAC_ACCPSW","Teste.123","C","Senha de autentica็ใo recebimento do e-mail do SAC","Senha de autentica็ใo recebimento do e-mail do SAC","Senha de autentica็ใo recebimento do e-mail do SAC",.F. )

cMailBox := AllTrim(U_MyNewSX6(	"SAC_MAILBO","SAC","C","MAIL BOX SAC","MAIL BOX SAC","MAIL BOX SAC",.F. ))
/*oMail	 := TWFMail():New( {alParams[2],alParams[3]} )
oMailBox := oMail:GetMailBox( cMailBox )
oLogFile := WFFileSpec( oMailBox:cRootPath + "\" + oMailBox:cRecipient + ".log" )

oPop3:=oMail:oPop3Srv
oPop3:cName := AllTrim( oMailBox:cPop3Server )
oPop3:nPort := oMailBox:nPop3Port
If oMail:InitServer( oMailBox, oLogFile ) .And. oMail:oPop3Srv:Connect( oLogFile )
nMsg := oMail:oPop3Srv:GetNumMsgs()
For nInd:=1 To nMsg
oPop3:Receive( nInd, oLogFile )
oInboxFolder := oMailBox:GetFolder( "\inbox")
oInboxFolder:CROOTPATH:=cDirTemp
While oInboxFolder:FileExists( cEMLFile := ChgFileExt( CriaTrab(,.f.), ".eml" ) )
end
oInboxFolder:SaveFile( oPop3:oMsg, cEMLFile )
Next
EndIf
*/
oPopServer := TMailManager():New()
oPopServer:Init(cPopServer , cPopServer, cAccount, cPwd, nPortPop)

nPopResult := oPopServer:PopConnect()
If !( nPopResult == 0)
	conout( oPopServer:GetErrorString( nPopResult ) )
	Return
EndIf
oPopServer:GetNumMsgs(@nMessages)	//Conta quantas mensagens hแ no servidor

If  nMessages = 0
	oPopServer:PopDisconnect()
	Return
EndIf

oMessage:= TMailMessage():New()		//Verifica todas mensagens no servidor
oMail	:= TMailMessage():New()
For nMessage := 1 To nMessages
	oMessage:Clear()
	If !( nPopResult := oMessage:Receive( oPopServer, nMessage))==0
		Loop
	EndIf
	SAC01Ini(oMessage)
	
	cMnumOS			:= GetSxENum("ZZS","ZZS_CODIGO")
	lMessageDown	:= .F.
	
	nAnexos		:=oMessage:getAttachCount()
	cPathArq	:=cRootPath+cDirCham+cMnumOS+"\"
	SAC01Dir(cPathArq)
	
	
	For nAtach := 1 to nAnexos
		aAttInfo		:= oMessage:getAttachInfo(nAtach)
		MemoWrite( cPathArq+"\"+cMnumOS+"_INFO_oMessage.html" , VARINFO ( 'aAttInfo' , aAttInfo ,  ,.T. , .F. )  )
		If aAttInfo[2]=="message/rfc822"
			oMessage:SaveAttach(nAtach, cPathArq+"\"+cMnumOS+".eml"  )//oMessage:Save( cDirCham+cMnumOS+"\"+cMnumOS+".eml") oMessage:SaveAttach(nAtach, cPathArq+cMnumOS+".html")
			oMail:Load( cPathArq+"\"+cMnumOS+".eml")
			For nInd:=1 To oMail:getAttachCount()
				aAttMail:=oMail:getAttachInfo(nInd)
				MemoWrite( cPathArq+"\"+cMnumOS+"_INFO_oMail.html" , VARINFO ( 'aAttInfo' , aAttMail ,  ,.T. , .F. )  )
				If aAttMail[2]=="text/html"
					oMail:SaveAttach(nInd, cPathArq+cMnumOS )
					SAC01Ini(oMail)
					GETREMET(cPathArq,cMnumOS)
					Exit
				EndIf
			Next
			Exit
		EndIf
	Next
	If !File(cPathArq+cMnumOS+".html")
		GETREMET(cPathArq,cMnumOS+".eml",.F.)
		MemoWrite(cPathArq+cMnumOS+".html",_cBody)
	EndIf
	

	
	Begin Transaction
	
	If !(lGravou:=gravamsg(_cFrom,_cTo,_cSubject,"",cMnumOS))
		RollbackSx8()
		Ferase(cRootPath+cDirAnex+cMnumOS+".eml")
		Break
	EndIf
	
	End Transaction
	
	If lGravou
		oMessage:SetConfirmRead(.T.)
		oPopServer:DeleteMsg(nMessage)		//Deleta mensagem
	EndIf
Next

oPopServer:PopDisconnect()


If alParams[3]
	RpcClearEnv()
Else
	RestArea(alAreaSM0)
EndIf

Semaforo(.F.,nHDL,"SAC01ATT")

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGSAC01  บAutor  ณMicrosiga           บ Data ณ  01/24/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function gravamsg(cFrom,cTo,cSubject,cBody,cMnumOS)
Local cAbertura:="000000"              
Local cUsuario:=upper(UsrFullName(__CUSERID))
// GRAVA NO ZZS MSG VINDAS DIRETO DOS CLIENTES - 1 TAREFA POR EMAIL

Reclock("ZZS",.T.)
ZZS->ZZS_FILIAL		:= xFilial("ZZS")
ZZS->ZZS_DESCRI		:= ALLTRIM(cSubject)

ZZS->ZZS_AUTORI 	:= "2"
ZZS->ZZS_HRSPRE 	:= 0
ZZS->ZZS_SOLICI 	:= "DEFINIR"
ZZS->ZZS_CLIENT 	:= "DEFINIR"
ZZS->ZZS_CODCLI 	:= ""
ZZS->ZZS_ANALIS	:= ""
ZZS->ZZS_CODANA	:= "DEFINIR"
ZZS->ZZS_STATUS	:= "1"
ZZS->ZZS_EMISSA	:= ddatabase
ZZS->ZZS_HREMIS	:= time()
ZZS->ZZS_CODIGO 	:= cMnumOS

aRetorno:=U_SAC01SLA(cAbertura)

ZZS->ZZS_TIPOHD	:=cAbertura
ZZS->ZZS_DESCTI	:=Posicione("ZZU",1,xFilial("ZZU")+cAbertura,"ZZU_DESC")
ZZS->ZZS_ENTREG	:=aRetorno[1]
ZZS->ZZS_HRENTR   :=aRetorno[2]

ZZS->(MSUNLOCK())
ConfirmSx8()

Reclock("ZZT",.T.)
ZZT->ZZT_FILIAL	:= xFilial("ZZT")
ZZT->ZZT_CHAMAD	:= cMnumOS
ZZT->ZZT_DATA		:= dDatabase
ZZT->ZZT_HRINI		:= time()
ZZT->ZZT_HRFIM		:= time()
ZZT->ZZT_OCORREN	:= "Abertura de Chamado: " +cSubject+CHR(13)+CHR(10)+cBody
If IsBlind()
	cUsuario:="JOB"
EndIf
	
ZZT->ZZT_ANALIS	:=cUsuario 
ZZT->(MSUNLOCK())


Return .T.


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGSAC01  บAutor  ณMicrosiga           บ Data ณ  01/24/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function SAC01EML(cMailID,cDiretorio)
Local aDirEmls	    :=DIRECTORY(cDiretorio+"*.eml")
Local nInd
Local cNomeArq		:=""
aDirEmls:=Asort(aDirEmls,,,{|a,b|a[1]>b[1]})

For nInd:=1 To Len(aDirEmls)
	
	cNomeArq:=aDirEmls[nInd,1]
	If !File(cDiretorio+cNomeArq)
		Loop
	EndIf
	
	FT_FUse(cDiretorio+cNomeArq)
	FT_FGoTop()
	While !FT_FEOF() .And. Empty(cNomeArq)
		
		cLinha:=FT_FReadLn()
		
		If !"MESSAGE-ID"$Upper(cLinha)
			Loop
		EndIf
		
		If cMailID$cLinha
			cNomeArq:=aDirEmls[nInd,1]
		EndIf
		FT_FSkip()
	EndDo
	FT_FUse()
	
	If !Empty(cNomeArq)
		Exit
	EndIf
Next

Return cNomeArq

//Converte uma string em formato ISO-8859-1
Static Function Conv88591(cAssunto)
Local cRet		:= ""
Local aISO8859	:= {}

aadd(aISO8859,{'=00',''})
aadd(aISO8859,{'=01',''})
aadd(aISO8859,{'=02',''})
aadd(aISO8859,{'=03',''})
aadd(aISO8859,{'=04',''})
aadd(aISO8859,{'=05',''})
aadd(aISO8859,{'=06',''})
aadd(aISO8859,{'=07',''})
aadd(aISO8859,{'=08',''})
aadd(aISO8859,{'=09',''})
aadd(aISO8859,{'=0A',''})
aadd(aISO8859,{'=0B',''})
aadd(aISO8859,{'=0C',''})
aadd(aISO8859,{'=0D',''})
aadd(aISO8859,{'=0E',''})
aadd(aISO8859,{'=0F',''})
aadd(aISO8859,{'=10',''})
aadd(aISO8859,{'=11',''})
aadd(aISO8859,{'=12',''})
aadd(aISO8859,{'=13',''})
aadd(aISO8859,{'=14',''})
aadd(aISO8859,{'=15',''})
aadd(aISO8859,{'=16',''})
aadd(aISO8859,{'=17',''})
aadd(aISO8859,{'=18',''})
aadd(aISO8859,{'=19',''})
aadd(aISO8859,{'=1A',''})
aadd(aISO8859,{'=1B',''})
aadd(aISO8859,{'=1C',''})
aadd(aISO8859,{'=1D',''})
aadd(aISO8859,{'=1E',''})
aadd(aISO8859,{'=1F',''})
aadd(aISO8859,{'=20',' '})
aadd(aISO8859,{'=21','!'})
aadd(aISO8859,{'=22','"'})
aadd(aISO8859,{'=23','#'})
aadd(aISO8859,{'=24','$'})
aadd(aISO8859,{'=25','%'})
aadd(aISO8859,{'=26','&'})
aadd(aISO8859,{'=27',"'"})
aadd(aISO8859,{'=28','('})
aadd(aISO8859,{'=29',')'})
aadd(aISO8859,{'=2A','*'})
aadd(aISO8859,{'=2B','+'})
aadd(aISO8859,{'=2C',','})
aadd(aISO8859,{'=2D','-'})
aadd(aISO8859,{'=2E','.'})
aadd(aISO8859,{'=2F','/'})
aadd(aISO8859,{'=30','0'})
aadd(aISO8859,{'=39','9'})
aadd(aISO8859,{'=3A',':'})
aadd(aISO8859,{'=3B',';'})
aadd(aISO8859,{'=3C','<'})
aadd(aISO8859,{'=3D','='})
aadd(aISO8859,{'=3E','>'})
aadd(aISO8859,{'=3F','?'})
aadd(aISO8859,{'=40','@'})
aadd(aISO8859,{'=41','A'})
aadd(aISO8859,{'=5A','Z'})
aadd(aISO8859,{'=5B','['})
aadd(aISO8859,{'=5C','\'})
aadd(aISO8859,{'=5D',']'})
aadd(aISO8859,{'=5E','^'})
aadd(aISO8859,{'=5F','_'})
aadd(aISO8859,{'=60','`'})
aadd(aISO8859,{'=61','a'})
aadd(aISO8859,{'=7A','z'})
aadd(aISO8859,{'=7B','{'})
aadd(aISO8859,{'=7C','|'})
aadd(aISO8859,{'=7D','}'})
aadd(aISO8859,{'=7E','~'})
aadd(aISO8859,{'=7F',''})
aadd(aISO8859,{'=80',''})
aadd(aISO8859,{'=81',''})
aadd(aISO8859,{'=82',''})
aadd(aISO8859,{'=83',''})
aadd(aISO8859,{'=84',''})
aadd(aISO8859,{'=85',''})
aadd(aISO8859,{'=86',''})
aadd(aISO8859,{'=87',''})
aadd(aISO8859,{'=88',''})
aadd(aISO8859,{'=89',''})
aadd(aISO8859,{'=8A',''})
aadd(aISO8859,{'=8B',''})
aadd(aISO8859,{'=8C',''})
aadd(aISO8859,{'=8D',''})
aadd(aISO8859,{'=8E',''})
aadd(aISO8859,{'=8F',''})
aadd(aISO8859,{'=90',''})
aadd(aISO8859,{'=91',''})
aadd(aISO8859,{'=92',''})
aadd(aISO8859,{'=93',''})
aadd(aISO8859,{'=94',''})
aadd(aISO8859,{'=95',''})
aadd(aISO8859,{'=96',''})
aadd(aISO8859,{'=97',''})
aadd(aISO8859,{'=98',''})
aadd(aISO8859,{'=99',''})
aadd(aISO8859,{'=9A',''})
aadd(aISO8859,{'=9B',''})
aadd(aISO8859,{'=9C',''})
aadd(aISO8859,{'=9D',''})
aadd(aISO8859,{'=9E',''})
aadd(aISO8859,{'=9F',''})
aadd(aISO8859,{'=A0',' '})
aadd(aISO8859,{'=A1','ก'})
aadd(aISO8859,{'=A2','ข'})
aadd(aISO8859,{'=A3','ฃ'})
aadd(aISO8859,{'=A4','ค'})
aadd(aISO8859,{'=A5','ฅ'})
aadd(aISO8859,{'=A6','ฆ'})
aadd(aISO8859,{'=A7','ง'})
aadd(aISO8859,{'=A8','จ'})
aadd(aISO8859,{'=A9','ฉ'})
aadd(aISO8859,{'=AA','ช'})
aadd(aISO8859,{'=AB','ซ'})
aadd(aISO8859,{'=AC','ฌ'})
aadd(aISO8859,{'=AD','ญ'})
aadd(aISO8859,{'=AE','ฎ'})
aadd(aISO8859,{'=AF','ฏ'})
aadd(aISO8859,{'=B0','ฐ'})
aadd(aISO8859,{'=B1','ฑ'})
aadd(aISO8859,{'=B2','ฒ'})
aadd(aISO8859,{'=B3','ณ'})
aadd(aISO8859,{'=B4','ด'})
aadd(aISO8859,{'=B5','ต'})
aadd(aISO8859,{'=B6','ถ'})
aadd(aISO8859,{'=B7','ท'})
aadd(aISO8859,{'=B8','ธ'})
aadd(aISO8859,{'=B9','น'})
aadd(aISO8859,{'=BA','บ'})
aadd(aISO8859,{'=BB','ป'})
aadd(aISO8859,{'=BC','ผ'})
aadd(aISO8859,{'=BD','ฝ'})
aadd(aISO8859,{'=BE','พ'})
aadd(aISO8859,{'=BF','ฟ'})
aadd(aISO8859,{'=C0','ภ'})
aadd(aISO8859,{'=C1','ม'})
aadd(aISO8859,{'=C2','ย'})
aadd(aISO8859,{'=C3','ร'})
aadd(aISO8859,{'=C4','ฤ'})
aadd(aISO8859,{'=C5','ล'})
aadd(aISO8859,{'=C6','ฦ'})
aadd(aISO8859,{'=C7','ว'})
aadd(aISO8859,{'=C8','ศ'})
aadd(aISO8859,{'=C9','ษ'})
aadd(aISO8859,{'=CA','ส'})
aadd(aISO8859,{'=CB','ห'})
aadd(aISO8859,{'=CC','ฬ'})
aadd(aISO8859,{'=CD','อ'})
aadd(aISO8859,{'=CE','ฮ'})
aadd(aISO8859,{'=CF','ฯ'})
aadd(aISO8859,{'=D0','ะ'})
aadd(aISO8859,{'=D1','ั'})
aadd(aISO8859,{'=D2','า'})
aadd(aISO8859,{'=D3','ำ'})
aadd(aISO8859,{'=D4','ิ'})
aadd(aISO8859,{'=D5','ี'})
aadd(aISO8859,{'=D6','ึ'})
aadd(aISO8859,{'=D7','ื'})
aadd(aISO8859,{'=D8','ุ'})
aadd(aISO8859,{'=D9','ู'})
aadd(aISO8859,{'=DA','ฺ'})
aadd(aISO8859,{'=DB','Û'})
aadd(aISO8859,{'=DC','Ü'})
aadd(aISO8859,{'=DD','Ý'})
aadd(aISO8859,{'=DE','Þ'})
aadd(aISO8859,{'=DF','฿'})
aadd(aISO8859,{'=E0','เ'})
aadd(aISO8859,{'=E1','แ'})
aadd(aISO8859,{'=E2','โ'})
aadd(aISO8859,{'=E3','ใ'})
aadd(aISO8859,{'=E4','ไ'})
aadd(aISO8859,{'=E5','ๅ'})
aadd(aISO8859,{'=E6','ๆ'})
aadd(aISO8859,{'=E7','็'})
aadd(aISO8859,{'=E8','่'})
aadd(aISO8859,{'=E9','้'})
aadd(aISO8859,{'=EA','๊'})
aadd(aISO8859,{'=EB','๋'})
aadd(aISO8859,{'=EC','์'})
aadd(aISO8859,{'=ED','ํ'})
aadd(aISO8859,{'=EE','๎'})
aadd(aISO8859,{'=EF','๏'})
aadd(aISO8859,{'=F0','๐'})
aadd(aISO8859,{'=F1','๑'})
aadd(aISO8859,{'=F2','๒'})
aadd(aISO8859,{'=F3','๓'})
aadd(aISO8859,{'=F4','๔'})
aadd(aISO8859,{'=F5','๕'})
aadd(aISO8859,{'=F6','๖'})
aadd(aISO8859,{'=F7','๗'})
aadd(aISO8859,{'=F8','๘'})
aadd(aISO8859,{'=F9','๙'})
aadd(aISO8859,{'=FA','๚'})
aadd(aISO8859,{'=FB','๛'})
aadd(aISO8859,{'=FC','ü'})
aadd(aISO8859,{'=FD','ý'})
aadd(aISO8859,{'=FE','þ'})
aadd(aISO8859,{'=FF','ÿ'})

If At("; =?WINDOWS-",Upper(cAssunto))  >0
	cAssunto	:= strtran(cAssunto,Left(cAssunto,At("Q?",Upper(cAssunto))+1),"")
EndIf

cAssunto	:= strtran(cAssunto,"; =?iso-8859-1?Q?ENC:_","")
cAssunto	:= strtran(cAssunto," =?iso-8859-1?Q?ENC:_","")
cAssunto	:= strtran(cAssunto,"; =?iso-8859-1?Q?","")
cAssunto	:= strtran(cAssunto," =?iso-8859-1?Q?","")
cAssunto	:= strtran(cAssunto,"?=","")

For nx:=1 to len(aISO8859)
	
	cAssunto	:= strtran(cAssunto,aISO8859[nx,1],aISO8859[nx,2])
	
Next nx

cRet	:= strtran(cAssunto,"_"," ")

Return cRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGSAC01  บAutor  ณMicrosiga           บ Data ณ  01/23/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function SAC01Dir(cDir)

If !lIsDir(cDir)
	MakeDir( cDir )
EndIf
Return

Return .T.
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGSAC01  บAutor  ณMicrosiga           บ Data ณ  01/25/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function SAC01GetFrom(_cFrom,clArqPro)
Local cLinha   	:= ""
Local nContagem	:= 0
Local cFromAux	:=_cFrom
Local cDe		:=""
_cFrom:=""
FT_FUse(clArqPro)
FT_FGoTop()

While !ft_feof()
	cLinha 	:= ""
	cLinha   	:= FT_FReadLn() //Le alinha
	
	If "De:</b>" $ cLinha
		cLinAux:=Substr(cLinha, At("De:</b>",cLinha)+8  )
		_cFrom	:= Substr(cLinAux,1,At(  "<br>" ,cLinAux)-1)
		Exit
	Endif
	
	
	FT_FSkip()
EndDo

//If Empty(_cFrom)
//_cFrom:=cFromAux
//EndIf

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGSAC01  บAutor  ณMicrosiga           บ Data ณ  01/28/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function SAC01Ini(oMessage)
_cFrom 		:=oMessage:cFrom
_cFrom		:=SubStr(_cFrom,At("<",_cFrom)+1, (RAt(">",_cFrom)-At("<",_cFrom))-1   )
_cSubject	:=oMessage:cSubject
_cTo			:=oMessage:cTo
_cCc			:=oMessage:cCc
_cSubject	:=Conv88591(_cSubject)
_cBody	   :=omessage:cBody
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGSAC01  บAutor  ณMicrosiga           บ Data ณ  02/06/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GETREMET(cPathArq,cMnumOS,lGravar)
Local cLinha   	:= ""
Local clArqPro 	:= ""
Local lBody	:= .F.
Local nContagem	:= 0
Local cRet	:= ""

Default lGravar:=.T.

clArqPro := cPathArq+cMnumOS

FT_FUse(clArqPro)
FT_FGoTop()

While !ft_feof() .and. nContagem < 5000
	
	nContagem++
	
	//Inicia as variaveis com vazio
	cLinha 	:= ""
	
	cLinha   	:= FT_FReadLn() //Le alinha
	cLinha   	:=Conv88591(cLinha)
	
	
	if "From: " $ cLinha
		cRet	:= substring(cLinha,at("<",cLinha)+1,at(">",cLinha)-at("<",cLinha)-1) //cBuffer
	ENDIF
	
	If "[cid:" $ cLinha
		exit
	EndIf
	If lBody
		_cBody	+= 	cLinha+CRLF
	EndIf
	If "Content-Transfer-Encoding: quoted-printable" $ cLinha
		lBody	:= .T.
	EndIf
	
	
	FT_FSkip()
EndDo

FT_FUse()
_cbody := alltrim(substr(_cbody,1,65000))

If lGravar
	MemoWrite(cPathArq+cMnumOS+".html",_cBody)
	Ferase(clArqPro)
EndIf

If !Empty(cRet)
	_cFrom:=cRet
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGSAC01  บAutor  ณMicrosiga           บ Data ณ  02/20/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Semaforo(lTipo,nHdl,cArq)
Local lRet		:=	.f.
Local cSemaf	:=	"SEMAFORO\"+cArq+".LCK"

If lTipo
	nHdl := MSFCREATE(cSemaf,1 + 16)
	lRet := nHdl > 0
Else
	lRet :=	Fclose(nHdl)
	Ferase(cSemaf)
EndIf

Return(lRet)
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGSAC01  บAutor  ณMicrosiga           บ Data ณ  03/07/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function xAcerZZS()
Local cFilZZS

RpcSetEnv("01","03")
cFilZZS:=xFilial("ZZS")
ZZS->(DbSeek(cFilZZS))
Do While ZZS->(!Eof()) .And. ZZS->ZZS_FILIAL==cFilZZS
	ZZS->(RecLock("ZZS",.F.))
	ZZS->ZZS_DESCRI:= Conv88591(ZZS->ZZS_DESCRI)
	ZZS->(MsUnLock())
	ZZS->(DbSkip())
EndDo

Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGSAC01  บAutor  ณMicrosiga           บ Data ณ  03/23/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function SAC01SLA(cCodSLA,dData,cHora)
Local aAreaAtu:=GetArea()
Local aAreaZZU:=ZZU->(GetArea())
Local aRetorno

Default dData:=MsDate()
Default cHora:=Time()

ZZU->(DbSetOrder(1))//ZZU_FILIAL+ZZU_CODIGO
aRetorno:={dData,cHora}

If ZZU->(DbSeek(xFilial("ZZU")+cCodSLA) )
	aRetorno:=SAC01GetDados(dData,cHora,ZZU->ZZU_SLA,ZZU->ZZU_SLAHR)
EndIf

RestArea(aAreaZZU)
RestArea(aAreaAtu)
Return aRetorno

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณNCGSAC01  บAutor  ณMicrosiga           บ Data ณ  03/23/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function SAC01GetDados(dData,cHora,nDiasSLA,nHoraSLA)
Local cHoraRet
Local dDataRet
Local dDataAux:=dData
Local nHora:=HoraToInt(cHora)
Local aHoraExp:={8.5,18,"08:30","18:00"}
Local nCont	:=0

If nHora>aHoraExp[2]
	nHora:=aHoraExp[1]
	dDataAux:=DataValida(dDataAux+1)
EndIf

If nHoraSLA>0	
	Do While nCont<nHoraSLA		
		If	(nHora+1)>aHoraExp[2]
			nHora:=aHoraExp[1]
			dDataAux:=DataValida(dDataAux+1)
		EndIf
		nHora++
		nCont++
	EndDo
EndIf

cHoraRet:=IntToHora(nHora)
dDataAux:=DataValida(dDataAux)

Do While nCont<nDiasSLA
	++dDataAux
	If DataValida(dDataAux)	==dDataAux
		++nCont
	EndIf
EndDo
dDataRet:=dDataAux

aRetorno:={dDataRet,cHoraRet}

Return aRetorno
