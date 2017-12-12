#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"


User Function VERVPCJOB(aDados)

Default aDados:={"01","03"}
RpcSetEnv(aDados[1],aDados[2])

u_NCGRL209()

RpcClearEnv()

Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  VerVPC     º Autor ³ AP6 IDE            º Data ³  23/07/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Codigo gerado pelo AP6 IDE.                                º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP6 IDE                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function NCGRL209()

Local dVpcAte	:= SuperGetMv("NC_VPCATE",.F.,60)
Local dVPCAte1	:= dVpcAte - 15
Local dVPCAte2	:= dVPCAte1 - 15
Local dVPCAte3	:= dVPCAte2 - 15
Local dDiasAte 	:= Msdate()

Private lEnviar		:= .F.
Private aTipoFat	:= RetSx3Box( Posicione("SX3", 2, "P01_TPFAT","X3CBox()" ),,,1)
Private aTipoRep	:= RetSx3Box( Posicione("SX3", 2, "P01_REPASS","X3CBox()" ),,,1)
Private cGrupo	 	:= ""
Private cCliente 	:= ""
Private cErro    	:= ""
Private aAreaP01 	:= P01->(GetArea())
Private cPath		:= "\MARGEMLIQ\"
Private cHtml		:= "VPCAVENCER.htm"
Private oHtml       :={}


oHtml:=TWFHTML():New(Alltrim(cPath) + Alltrim(cHtml))

P01->(DbSeek(xFilial("P01")))

Do While P01->(!EOF() .And. P01_FILIAL==xFilial("P01"))
	
	If P01->P01_TPCAD <> '1'
		P01->(DbSkip());Loop
	EndIf
	
	If P01->P01_STATUS <> '1'
		P01->(DbSkip());Loop
	EndIf
	
	dDiasAte := P01->P01_DTVFIM - MsDate()
	
	
	If dDiasAte == dVpcAte
		RL209Html()
		lEnviar	:=.T.
		P01->(DbSkip())
	ElseIf 	dDiasAte  == dVPCAte1
		RL209Html()
	  	lEnviar	:=.T.
		P01->(DbSkip())
	ElseIf 	dDiasAte  == dVPCAte2
		RL209Html()
	   	lEnviar	:=.T.
		P01->(DbSkip())
	ElseIf dDiasAte  <= dVPCAte3
		RL209Html()
	  	lEnviar	:=.T.
		P01->(DbSkip())
	Else
		P01->(DbSkip())
	EndIf
Enddo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Salva o Html gerado                                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If lEnviar
	cNomeArq:=E_Create(,.F.)
	
	oHtml:SaveFile( cNomeArq+".htm" )
	oHtml:Free()
	cBody:= WFLoadFile(cNomeArq+".htm" )
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Envia o Html por e-mail                                                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	cMailDest:= Alltrim(SuperGetMv("NC_VPCEMAI",.t.,"lfelipe@ncgames.com.br"))
	//cMailDest:="lfelipe@ncgames.com.br"
	RL209SEND( "Contratos de VPC a Vencer",cBody,{}, cMailDest, "", @cErro )
	
	Ferase(cNomeArq+".htm")
EndIf

RestArea(aAreaP01)

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³VERVPC    ºAutor  ³Microsiga           º Data ³  07/23/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function RL209SEND(cAssunto, cBody, aAnexos, cEmailTo, cEmailCc, cErro)

Local lRetorno	:= .T.
Local cServer   := GetNewPar("MV_RELSERV","")
Local cAccount	:= GetNewPar("MV_RELACNT","")
Local cPassword	:= GetNewPar("MV_RELAPSW","")
Local lMailAuth := GetNewPar("MV_RELAUTH",.F.)

Default aAnexos		:= {}
Default cBody		:= ""
Default cAssunto	:= ""
Default cErro		:= ""

//cEmailCc:=cEmailTo

If !Empty(cEmailTo) .And. !Empty(cAssunto) .And. !Empty(cBody)
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
Else
	If Empty(cEmailTo)
		cErro := "É neessário fornecedor o destinátario para o e-mail. "
		lRetorno := .F.
	EndIf
	If Empty(cAssunto)
		cErro := "É neessário fornecer o assunto para o e-mail. "
		lRetorno := .F.
		
	EndIf
	If Empty(cBody)
		cErro := "É neessário fornecer o corpo do e-mail. "
		lRetorno := .F.
	EndIf
Endif

Return(lRetorno)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³VERVPC    ºAutor  ³Microsiga           º Data ³  10/11/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function RL209Html()

cGrupo	:=""
cCliente:=""

If !Empty(P01->P01_GRPCLI)
	cGrupo	:=P01->P01_GRPCLI+"-"+AllTrim(Posicione("ACY",1,xFilial("ACY")+P01->P01_GRPCLI,"ACY_DESCRI"))
EndIf

If !Empty(P01->P01_CODCLI)
	cCliente	:=P01->P01_CODCLI+" "+P01->P01_LOJCLI+"-"+AllTrim(Posicione("SA1",1,xFilial("SA1")+P01->(P01_CODCLI+Alltrim(P01_LOJCLI)),"A1_NREDUZ"))
EndIf


AAdd( oHtml:ValByName("it.tipocadastro")	,"VPC")
AAdd( oHtml:ValByName("it.codigovpc")		,P01->P01_CODIGO+"/"+P01->P01_VERSAO)
AAdd( oHtml:ValByName("it.descricao")		,P01->P01_DESC)
AAdd( oHtml:ValByName("it.grpcliente")		,cGrupo)
AAdd( oHtml:ValByName("it.codigocliente")	,cCliente)
AAdd( oHtml:ValByName("it.tpfaturamento")	,aTipoFat[Ascan(aTipoFat,{|a| a[2]==P01->P01_TPFAT} ),3])
AAdd( oHtml:ValByName("it.tprepasse")		,aTipoRep[Ascan(aTipoRep,{|a| a[2]==P01->P01_REPASS} ),3])
AAdd( oHtml:ValByName("it.dtinicio")		,DToC(P01->P01_DTVINI))
AAdd( oHtml:ValByName("it.dtfim")			,DToC(P01->P01_DTVFIM))


Return
