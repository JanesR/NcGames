#include "rwmake.ch"
#include "ap5mail.ch"
#include "tbiconn.ch"
#include "topconn.ch"
#INCLUDE "TOTVS.CH"

/////////////////////////////////////////////////////////////////////////
// ******************************************************************* //
/////////////////////////////////////////////////////////////////////////
User Function GETMAIL()

Local lCont	:= .T.

While lCont
	lCont	:= u_saveatt({.T.,"01","03",.T.,.F.,""})
End

RETURN

/////////////////////////////////////////////////////////////////////////
// ******************************************************************* //
/////////////////////////////////////////////////////////////////////////
User Function SaveAtt(alParams)

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
Local nCount 			:= 0
Local nAtach 			:= 0
Local nMessageDown 		:= 0
Local _cBody			:= ""

Private cDirTemp			:= ""
Private cDirAnex			:= ""
Private cDirCham			:= ""
Public cMnumOS			:= ""

Default alParams:={.F.,"","",.F.,.F.,""}

If alParams[1]
	RpcSetType(3)
	RpcSetEnv(alParams[2],alParams[3])
Else
	alAreaSM0 := SM0->(GetArea())
	llJob:=.T.
EndIf

cDirTemp 		:= 	U_MyNewSX6(	"HD_DIRTMP", ;
							"\HELPDESK\temp\", ;
							"C", ;
							"Diretório dos arquivos temporários do HD",;
							"Diretório dos arquivos temporários do HD",;
							"Diretório dos arquivos temporários do HD",;
							.F. )

cDirAnex 		:= 	U_MyNewSX6(	"HD_DIRANX", ;
							"\HELPDESK\Anexos\", ;
							"C", ;
							"Diretório dos arquivos anexos do HD",;
							"Diretório dos arquivos anexos do HD",;
							"Diretório dos arquivos anexos do HD",;
							.F. )
							
cDirCham 		:= 	U_MyNewSX6(	"HD_DIRCHM", ;
							"\HelpDesk\Chamados\", ;
							"C", ;
							"Diretório dos arquivos de chamados do HD",;
							"Diretório dos arquivos de chamados do HD",;
							"Diretório dos arquivos de chamados do HD",;
							.F. )

cPopServer 		:= 	U_MyNewSX6(	"HD_POPSERV", ;
							"ncsrvsbs", ;
							"C", ;
							"Servidor Pop do HelpDesk",;
							"Servidor Pop do HelpDesk",;
							"Servidor Pop do HelpDesk",;
							.F. )

cAccount 		:= 	U_MyNewSX6(	"HD_ACCOUNT", ;
							"prj.helpdesk", ;
							"C", ;
							"Usuário da conta recebimento do e-mail do Helpdesk",;
							"Usuário da conta do e-mail do Helpdesk",;
							"Usuário da conta do e-mail do Helpdesk",;
							.F. )

cPwd	 		:= 	U_MyNewSX6(	"HD_ACCPSW", ;
							"Ncgames.2012", ;
							"C", ;
							"Senha de autenticação recebimento do e-mail do Helpdesk",;
							"Senha de autenticação do e-mail do Helpdesk",;
							"Senha de autenticação do e-mail do Helpdesk",;
							.F. )


oPopServer := TMailManager():New()
oPopServer:Init(cPopServer , cPopServer, cAccount, cPwd, nPortPop)
//oPopServer:Init(cPopServer , cPopServer, "workflow", "W.2ncgames", nPortPop)

nPopResult := oPopServer:PopConnect()

If ( nPopResult == 0)
	//Conta quantas mensagens há no servidor
	oPopServer:GetNumMsgs(@nMessages)
	If( nMessages > 0 )
		oMessage := TMailMessage():New()
		//Verifica todas mensagens no servidor 
		oMessage:cFrom
		oMessage:cTo
		oMessage:cSubject	
		For nMessage := 1 To nMessages
			oMessage:Clear()
			nPopResult := oMessage:Receive( oPopServer, nMessage)
			If (nPopResult == 0 ) //Recebido com sucesso?
				nCount 			:= 0
				lMessageDown	:= .F.
				cMnumOS			:= GetSxENum("SZX","ZX_CODIGO")

				//Verifica todos anexos da mensagem e os salva
				For nAtach := 1 to oMessage:getAttachCount()
					CONOUT("[HELPDESK] VERIFICACAO DOS ANEXOS")
					aAttInfo		:= oMessage:getAttachInfo(nAtach)
					
					// SALVA NA PASTA TEMPORARIA
//					lSave 			:= oMessage:SaveAttach(nAtach, "H:\Anexos\"+cMnumOS+" - "+aAttInfo[1])
					lSave 			:= oMessage:SaveAttach(nAtach, alltrim(GetSrvProfString( "RootPath","" ))+cDirTemp+cMnumOS+" - "+aAttInfo[1])					
					//Se nao conseguiu tenta salvar na SYSTEM
					//Se nao conseguir novamente, salva na pasta %temp% do usuario
					IF lSAVE
						
						CONOUT("[HELPDESK] SALVOU OS ANEXOS EM "+alltrim(GetSrvProfString( "RootPath","" ))+cDirTemp)
						IF SUBSTR(cMnumOS+" - "+aAttInfo[1],LEN(cMnumOS+" - "+aAttInfo[1])-3,1) != "."
							CONOUT("[HELPDESK] RENOMEIA O ARQUIVO 1 " )
//							FRENAME("H:\temp\"+cMnumOS+" - "+aAttInfo[1], "H:\temp\"+cMnumOS+".txt")
							FRENAME(alltrim(GetSrvProfString( "RootPath","" ))+cDirTemp+cMnumOS+" - "+aAttInfo[1], alltrim(GetSrvProfString( "RootPath","" ))+cDirTemp+cMnumOS+".txt")
							_cBody	:= ""
							_cFrom := GETREMET(@_cBody)							
						ENDIF
						
						// Copia o anexo para pasta de Helpdesk
						
						// Deleta o arquivo original
//						nDel	:= WinExec("del D:\Helpdesk\Anexos\"+cMnumOS+".eml")
						nDel	:= WinExec("del "+alltrim(GetSrvProfString( "RootPath","" ))+cDirTemp+cMnumOS+".txt")
						IF nDel == 0
							CONOUT("[HELPDESK] Deletou O ARQUIVO 1 " )
						ENDIF
					ENDIF
					//Salva o e-mail com extensão .eml na pasta anexos para o conhecimento
					lSave 		:= oMessage:SaveAttach(nAtach, alltrim(GetSrvProfString( "RootPath","" ))+cDirAnex+cMnumOS+" - "+aAttInfo[1])
					IF lSAVE
						CONOUT("[HELPDESK] SALVOU OS ANEXOS EM \HelpDesk\Anexos\" )
						
						IF SUBSTR(cMnumOS+" - "+aAttInfo[1],LEN(cMnumOS+" - "+aAttInfo[1])-3,1) != "."
							CONOUT("[HELPDESK] RENOMEIA O ARQUIVO 2 " )
							FRENAME(alltrim(GetSrvProfString( "RootPath","" ))+cDirAnex+cMnumOS+" - "+aAttInfo[1], alltrim(GetSrvProfString( "RootPath","" ))+cDirAnex+cMnumOS+".eml")
						ENDIF
						
						// VALIDA A COPIA DO ARQUIVO
						//NAO FUNCIONA EM JOB
						//lValid	:= CpyS2T("\HELPDESK\ANEXOS\"+cMnumOS+".EML","H:\Anexos\")
						lValid	:= .F.
						
						IF lValid
							CONOUT("[HELPDESK] COPIOU O ARQUIVO 2 " )
						ENDIF
						
						// DELETA O ARQUIVO ORIGINAL
						nDel	:= 	1
						IF nDel == 0
							CONOUT("[HELPDESK] DELETOU O ARQUIVO 2 " )
						ENDIF
						
					ENDIF
					//ENDIF
				Next
				
				// GRAVA EMAIL NO BANCO DE DADOS
				If Empty(_cFrom)
					_cFrom		:= oMessage:cFrom
				EndIf
				If Empty(_cBody)
					_cBody		:= oMessage:cBody
				Else
					_cBody	:= Conv88591(_cBody)
				EndIf
				_cTo		:= oMessage:cTo
				_cCc		:= oMessage:cCc
				_cSubject	:= oMessage:cSubject
				_cSubject	:= Conv88591(_cSubject)
				//SendMail()
				gravamsg(_cFrom,_cTo,_cSubject,_cBody)
				//(cFrom,cTo,cSubject,cBody)
			EndIf
			
			
			//Deleta mensagem
			oMessage:SetConfirmRead(.T.)
			//oPopServer:MoveMsg(<nMsg>,<cPasta>)
			//oPopServer:MoveMsg(nMessage,"ncgames") // AQUI!!
			oPopServer:DeleteMsg(nMessage)
			If lMessageDown
				nMessageDown++
			EndIf
		Next
		lProcessa	:= .T.
	Else
		lProcessa	:= .F.
	EndIf
	oPopServer:PopDisconnect()
Else
	conout( oPopServer:GetErrorString( nPopResult ) )
	lProcessa	:= .F.
EndIf

If alParams[1]
	RpcClearEnv()
Else
	RestArea(alAreaSM0)
EndIf


Return lProcessa


/////////////////////////////////////////////////////////////////////////
// ******************************************************************* //
/////////////////////////////////////////////////////////////////////////
Static Function gravamsg(cFrom,cTo,cSubject,cBody)
aaa		:= getarea()
_aSA1  	:= getarea()
aCODCLI	:= {}

//aCODCLI	:= AllUsers()
RestArea(_aSA1)

_aSA3	:= getarea()
aCODTEC	:= {}
dbselectarea("SA3")
dbsetorder(1)
dbgotop()
do while !eof()
	IF !EMPTY(SA3->A3_CODUSR)
		aadd(aCODTEC,{UPPER(ALLTRIM(SA3->A3_NREDUZ)),SA3->A3_CODUSR})
	ENDIF
	dbskip()
enddo

RestArea(_aSA3)

aAVISA	:= {}

IF ("@stch.com.br"$cFrom .OR. "@ncgames.com.br"$cFrom .or. "@ncgames.com"$cFrom)
	
	_XCLI := ""
	_XTEC := ""
	_XTAR := ""
	
	dbselectarea("SZX")
	dbsetorder(1)
	
	RECLOCK("SZX",.T.)
	// cFrom,cTo,cSubject,cBody
	SZX->ZX_FILIAL		:= "03"
	SZX->ZX_DESCRI		:= cSubject //"DESCRICAO" //ATASK[F]
	SZX->ZX_ENTREGA	:= ddatabase
	SZX->ZX_AUTORIZ	:= "2"

	SZX->ZX_HRSPREV	:= 0
	SZX->ZX_SOLICIT	:= cFrom
	SZX->ZX_CLIENTE	:= "DEFINIR"	//_XCLI
	SZX->ZX_CODCLI		:= "" 		//aCODCLI[nPosCLI,2]
	SZX->ZX_ANALIST	:= "DEFINIR" 	//if(nPosTEC == 0 ,"",_XTEC )
	SZX->ZX_CODANA		:= "" 		//if(nPosTEC == 0 ,"",aCODTEC[nPosTEC,2] )
	SZX->ZX_STATUS		:= "1"
	SZX->ZX_EMISSAO	:= ddatabase
	SZX->ZX_OBS			:= time()+" "+replicate("-",150)+CHR(13)+CHR(10)+cSubject+CHR(13)+CHR(10)+cBody
	SZX->ZX_CODIGO		:= cMnumOS 		//GetSxENum("SZX","ZX_CODIGO")
	SZX->ZX_HREMIS		:= time()
	CONFIRMSX8()
	MSUNLOCK()
	
	//GRAVA NA SZY O HISTORICO INICIAL DO CHAMADO
	RECLOCK("SZY",.T.)
	SZY->ZY_FILIAL		:= SZX->ZX_FILIAL
	SZY->ZY_CHAMADO	:= cMnumOS
	SZY->ZY_DATA		:= dDatabase
	SZY->ZY_ANALIST		:= ALLTRIM(cfrom)
	SZY->ZY_HRINI		:= time()
	SZY->ZY_HRFIM		:= time()
	SZY->ZY_OCORREN	:= "Abertura de Chamado: " +cSubject+CHR(13)+CHR(10)+cBody
	MSUNLOCK()
	
	//grava html do email original
	_cARQ0    := cDirCham + cMnumOS +".htm"
	_nHandle0 := FCreate(_cARQ0)
	FWrite(_nHandle0,cSubject+cfrom+cBody)
	FClose(_nHandle0)
	
	cMensagem	:= "Esta é uma mensagem automática, por favor não responda. Para melhor acompanhamento da ocorrência, anote o número do seu chamado."
	cMensagem	+= "<BR>"
	cMensagem	+= "This is an automated message, please do not answer. To better monitor the occurrence, write down the number on your ticket."
	
	AADD(aAVISA,{cMnumOS,cFrom,cMensagem /*SZX->ZX_DESCRI*/ } )
	
	
ELSE
	
	// GRAVA NO SZX MSG VINDAS DIRETO DOS CLIENTES - 1 TAREFA POR EMAIL
	
	// checar se tem HD ou nao
	// se tiver hd, liberar tarefa automaticamente e ja encaminha para o analista responsavel do cliente
	// se nao tiver hd, responde ao remetente com msg padrao informando sobre o prazo de resposta e contrato HD
	RECLOCK("SZX",.T.)
	SZX->ZX_FILIAL		:= "03"
	SZX->ZX_DESCRI		:= ALLTRIM(cSubject) + " // " + ALLTRIM(cBody)  // ATASK[F]
	SZX->ZX_ENTREGA	:= ddatabase
	SZX->ZX_AUTORIZ 	:= "2"
	SZX->ZX_HRSPREV 	:= 0
	SZX->ZX_SOLICIT 	:= "DEFINIR"
	SZX->ZX_CLIENTE 	:= "DEFINIR" //_XCLI
	SZX->ZX_CODCLI 	:= "DEFINIR" //aCODCLI[nPosCLI,2]
	SZX->ZX_ANALIST	:= "DEFINIR" //if(nPosTEC == 0 ,"",_XTEC )
	SZX->ZX_CODANA		:= "DEFINIR" //if(nPosTEC == 0 ,"",aCODTEC[nPosTEC,2] )
	SZX->ZX_STATUS		:= "1"
	SZX->ZX_EMISSAO	:= ddatabase
	SZX->ZX_CODIGO 	:= cMnumOS //GetSxENum("SZX","ZX_CODIGO")
	SZX->ZX_OBS 		:= cBody
	SZX->ZX_HREMIS		:= time()
	CONFIRMSX8()
	MSUNLOCK()
	AADD(aAVISA,{cMnumOS,cfrom ,""} )
	
ENDIF

// envia email de aviso ao analista qdo definido
FOR R := 1 TO LEN(aAVISA)
	cHtm	:= u_HD_HTML(aAVISA[r][1], )
	u_SNDMAIL({aAVISA[r][2]},'NOVO CHAMADO - ' + aAVISA[r][1] ,cHtm,{})
NEXT R

Return


/////////////////////////////////////////////////////////////////////////
// ******************************************************************* //
/////////////////////////////////////////////////////////////////////////
STATIC FUNCTION xxxxGETREMET(_cBody)

Local nTamFile, nTamLin, cBuffer, nBtLidos
Local lBody	:= .F.
Local nContagem	:= 0

Private cArqTxt 	:= alltrim(GetSrvProfString( "RootPath","" ))+cDirTemp+cMnumOS+".txt" //"D:\HELPDESK\ANEXOS\"+cMnumOS+".txt"
Private nHdl     	:= fOpen(cArqTxt) //fOpen(cArqTxt,68)
Private cEOL     	:= "CHR(13)+CHR(10)"
nTamArray			:= 0
nTamFile 			:= fSeek(nHdl,0,2)
cRet				:= ""

If Empty(cEOL)
	cEOL := CHR(13)+CHR(10)
Else
	cEOL := Trim(cEOL)
	cEOL := &cEOL
Endif

If nHdl == -1
	CONOUT("O arquivo de nome " + cArqTXT + " nao pode ser aberto!")
	Return
Endif

//Processa({|| EXECIMPTXT() },"Verificando tabelas...")

ft_fuse(cArqTxt)

//////////////////////////////////////////////////////////
// LE O ARQUIVO TXT                                     //
//////////////////////////////////////////////////////////

While !ft_feof() .and. nContagem < 10000
	nContagem++
	cBuffer := ft_freadln()
	nLinha	:= ft_frecno()
	if "From: " $ cBuffer
		cRet	:= substring(cBuffer,at("<",cBuffer)+1,at(">",cBuffer)-at("<",cBuffer)-1) //cBuffer
	ENDIF

	If "[cid:" $ cBuffer
		exit
	EndIf	
	If lBody
		_cBody	+= 	cBuffer+cEOL
	EndIf	
	If "Content-Transfer-Encoding: quoted-printable" $ cBuffer
		lBody	:= .T.	
	EndIf	

	ft_fskip() // Leitura da proxima linha do arquivo texto
EndDo

fClose(nHdl)

RETURN cRet



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ImpArqPro ºAutor  ³Elton C.			 º Data ³  05/11/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Processamento da rotina de importacao                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GETREMET(_cBody)

Local cLinha   	:= "" 
Local clArqPro 	:= ""
Local lBody	:= .F.
Local nContagem	:= 0
Local cRet	:= ""

Private cArqTxt 	:= alltrim(GetSrvProfString( "RootPath","" ))+cDirTemp+cMnumOS+".txt" //"D:\HELPDESK\ANEXOS\"+cMnumOS+".txt"

clArqPro := cArqTxt

If !File(clArqPro)
	conout("Atenção, o arquivo informado não foi localizado.")
EndIf     

FT_FUse(clArqPro)
FT_FGoTop()

While !ft_feof() .and. nContagem < 5000
	nContagem++
    
    //Inicia as variaveis com vazio
	cLinha 	:= ""
	
	cLinha   	:= FT_FReadLn() //Le alinha    



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

_cbody := alltrim(substr(_cbody,1,65000))

Return cRet










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
aadd(aISO8859,{'=A1','¡'})
aadd(aISO8859,{'=A2','¢'})
aadd(aISO8859,{'=A3','£'})
aadd(aISO8859,{'=A4','¤'})
aadd(aISO8859,{'=A5','¥'})
aadd(aISO8859,{'=A6','¦'})
aadd(aISO8859,{'=A7','§'})
aadd(aISO8859,{'=A8','¨'})
aadd(aISO8859,{'=A9','©'})
aadd(aISO8859,{'=AA','ª'})
aadd(aISO8859,{'=AB','«'})
aadd(aISO8859,{'=AC','¬'})
aadd(aISO8859,{'=AD','­'})
aadd(aISO8859,{'=AE','®'})
aadd(aISO8859,{'=AF','¯'})
aadd(aISO8859,{'=B0','°'})
aadd(aISO8859,{'=B1','±'})
aadd(aISO8859,{'=B2','²'})
aadd(aISO8859,{'=B3','³'})
aadd(aISO8859,{'=B4','´'})
aadd(aISO8859,{'=B5','µ'})
aadd(aISO8859,{'=B6','¶'})
aadd(aISO8859,{'=B7','·'})
aadd(aISO8859,{'=B8','¸'})
aadd(aISO8859,{'=B9','¹'})
aadd(aISO8859,{'=BA','º'})
aadd(aISO8859,{'=BB','»'})
aadd(aISO8859,{'=BC','¼'})
aadd(aISO8859,{'=BD','½'})
aadd(aISO8859,{'=BE','¾'})
aadd(aISO8859,{'=BF','¿'})
aadd(aISO8859,{'=C0','À'})
aadd(aISO8859,{'=C1','Á'})
aadd(aISO8859,{'=C2','Â'})
aadd(aISO8859,{'=C3','Ã'})
aadd(aISO8859,{'=C4','Ä'})
aadd(aISO8859,{'=C5','Å'})
aadd(aISO8859,{'=C6','Æ'})
aadd(aISO8859,{'=C7','Ç'})
aadd(aISO8859,{'=C8','È'})
aadd(aISO8859,{'=C9','É'})
aadd(aISO8859,{'=CA','Ê'})
aadd(aISO8859,{'=CB','Ë'})
aadd(aISO8859,{'=CC','Ì'})
aadd(aISO8859,{'=CD','Í'})
aadd(aISO8859,{'=CE','Î'})
aadd(aISO8859,{'=CF','Ï'})
aadd(aISO8859,{'=D0','Ð'})
aadd(aISO8859,{'=D1','Ñ'})
aadd(aISO8859,{'=D2','Ò'})
aadd(aISO8859,{'=D3','Ó'})
aadd(aISO8859,{'=D4','Ô'})
aadd(aISO8859,{'=D5','Õ'})
aadd(aISO8859,{'=D6','Ö'})
aadd(aISO8859,{'=D7','×'})
aadd(aISO8859,{'=D8','Ø'})
aadd(aISO8859,{'=D9','Ù'})
aadd(aISO8859,{'=DA','Ú'})
aadd(aISO8859,{'=DB','Û'})
aadd(aISO8859,{'=DC','Ü'})
aadd(aISO8859,{'=DD','Ý'})
aadd(aISO8859,{'=DE','Þ'})
aadd(aISO8859,{'=DF','ß'})
aadd(aISO8859,{'=E0','à'})
aadd(aISO8859,{'=E1','á'})
aadd(aISO8859,{'=E2','â'})
aadd(aISO8859,{'=E3','ã'})
aadd(aISO8859,{'=E4','ä'})
aadd(aISO8859,{'=E5','å'})
aadd(aISO8859,{'=E6','æ'})
aadd(aISO8859,{'=E7','ç'})
aadd(aISO8859,{'=E8','è'})
aadd(aISO8859,{'=E9','é'})
aadd(aISO8859,{'=EA','ê'})
aadd(aISO8859,{'=EB','ë'})
aadd(aISO8859,{'=EC','ì'})
aadd(aISO8859,{'=ED','í'})
aadd(aISO8859,{'=EE','î'})
aadd(aISO8859,{'=EF','ï'})
aadd(aISO8859,{'=F0','ð'})
aadd(aISO8859,{'=F1','ñ'})
aadd(aISO8859,{'=F2','ò'})
aadd(aISO8859,{'=F3','ó'})
aadd(aISO8859,{'=F4','ô'})
aadd(aISO8859,{'=F5','õ'})
aadd(aISO8859,{'=F6','ö'})
aadd(aISO8859,{'=F7','÷'})
aadd(aISO8859,{'=F8','ø'})
aadd(aISO8859,{'=F9','ù'})
aadd(aISO8859,{'=FA','ú'})
aadd(aISO8859,{'=FB','û'})
aadd(aISO8859,{'=FC','ü'})
aadd(aISO8859,{'=FD','ý'})
aadd(aISO8859,{'=FE','þ'})
aadd(aISO8859,{'=FF','ÿ'})

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