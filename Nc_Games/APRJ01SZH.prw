#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "FIVEWIN.CH"
#INCLUDE "AP5MAIL.CH"
#INCLUDE "TOPCONN.CH"
//
//  Programa  : APRJ01SZH
//  Autor     : Carlos Nemesio Puerta
//  Data      : MARÇO/2013
//  Descricao : Rotina para aprovar ou rejeitar Tabela de preço intermediaria - SZH / SZJ
//
User Function APRJ01SZH()
Private aRotina    := {}
Private cCadastro  := "Aprovar/Rejeitar Tabela de Preço Intermediaria"
Private cDelFunc   := ".T."
Private cmarca     := GetMark()
Private lInverte   := .F.
Private _cIndex    := CriaTrab(,.F.)



Private _cFiltro   := Space(01)
Private _cKey      := Space(01)

Private _aIndex	 := {}
Private _cPerg	    := "APRJSZH   "
Private _lAbortP   := .F.

Private _aAPItens  := {}
Private _aRJItens  := {}
//
//  SX1
//
ValidPerg()
Pergunte(_cPerg,.T.)

aRotina  := { { "Aprova Tab." ,'ExecBlock("APRJ02SZH",.F.,.F.)',0,4,2},;
{ "Rejeita Tab.",'ExecBlock("APRJ03SZH",.F.,.F.)',0,4,2}}

dbSelectArea("SZH")
dbGoTop()

_cFiltro := 'SZH->ZH_CODIGO == "'+MV_PAR01+'" .And. (SZH->ZH_STAPROV == "P" .Or. SZH->ZH_STAPROV == "R")'
_cKey    := "ZH_FILIAL+ZH_CODIGO+ZH_ITEM+ZH_PRODUTO"
IndRegua("SZH",_cIndex,_cKey,,_cFiltro,OemToAnsi("Selecionando Registros..."))

Markbrow("SZH","ZH_OK",,,lInverte,cMarca)

dbSelectArea("SZH")
dbClearFilter()
RetIndex("SZH")
Ferase(_cIndex+OrdBagExt())

DepuraSZHJ()
Return

////////////////////////////////////////////////////////////////////////////////
// ************************************************************************** //
////////////////////////////////////////////////////////////////////////////////
User Function APRJ02SZH()
Private _aAPItens := {}

dbSelectArea("SZH")
dbSetOrder(4)
dbSeek(xFilial("SZH")+AllTrim(MV_PAR01))
While !Eof() .And. AllTrim(SZH->ZH_CODIGO) == AllTrim(MV_PAR01)
	//IF AllTrim(SZH->ZH_CODIGO) == AllTrim(MV_PAR01)
	If SZH->ZH_CODIGO <> MV_PAR01
		dbSkip()
		Loop
	EndIf
	If Marked('ZH_OK')
		RecLock("SZH",.F.)
		SZH->ZH_STAPROV := "A"            // P=Pendente;A=Aprovado;R=Rejeitado
		SZH->ZH_USERAP  := RetCodUsr()
		SZH->ZH_NUSERAP := UsrRetName(RetCodUsr())
		SZH->ZH_DTAPROV := dDataBase
		SZH->ZH_HRAPROV := Time()
		MsUnlock()
		AADD(_aAPItens,{SZH->ZH_ITEM,SZH->ZH_PRODUTO,SZH->ZH_XDESC,Str(SZH->ZH_PRV0,10,2),SZH->ZH_STAPROV})
		
		// desmarca
		RecLock("SZH",.F.)
		Replace ZH_OK With Space(2)
		MsUnlock()
	Else
		//If SZH->ZH_STAPROV == "R" .Or. SZH->ZH_STAPROV == "P"
		AADD(_aAPItens,{SZH->ZH_ITEM,SZH->ZH_PRODUTO,SZH->ZH_XDESC,Str(SZH->ZH_PRV0,10,2),SZH->ZH_STAPROV})
		//EndIf
	EndIf
	
	dbSkip()
EndDo
If Len(_aAPItens) > 0
	Env_APMail()
EndIf

//Markbrow("SZH","ZH_OK",,,lInverte,cMarca)

Return

////////////////////////////////////////////////////////////////////////////////
// ************************************************************************** //
////////////////////////////////////////////////////////////////////////////////
User Function APRJ03SZH()
Private _aRJItens := {}

dbSelectArea("SZH")
dbSetOrder(4)
dbSeek(xFilial("SZH")+AllTrim(MV_PAR01))
While !Eof() .And. ALLTRIM(SZH->ZH_CODIGO) == ALLTRIM(MV_PAR01)
	If SZH->ZH_CODIGO <> MV_PAR01
		dbSkip()
		Loop
	EndIf
	
	If Marked('ZH_OK')
		If SZH->ZH_STAPROV == "A"
			AADD(_aRJItens,{SZH->ZH_ITEM,SZH->ZH_PRODUTO,SZH->ZH_XDESC,Str(SZH->ZH_PRV0,10,2),SZH->ZH_STAPROV})
			dbSkip()
			Loop
		EndIf
		
		AADD(_aRJItens,{SZH->ZH_ITEM,SZH->ZH_PRODUTO,SZH->ZH_XDESC,Str(SZH->ZH_PRV0,10,2),"R"})
		RecLock("SZH",.F.)
		SZH->ZH_STAPROV := "R"
		dbDelete()
		MsUnlock()
		
		// desmarca
		RecLock("SZH",.F.)
		Replace ZH_OK With Space(2)
		MsUnlock()
	ELSE
		AADD(_aRJItens,{SZH->ZH_ITEM,SZH->ZH_PRODUTO,SZH->ZH_XDESC,Str(SZH->ZH_PRV0,10,2),SZH->ZH_STAPROV})
	EndIf
	
	dbSelectArea("SZH")
	dbSkip()
EndDo

If Len(_aRJItens) > 0
	Env_RJMail()
EndIf

//Markbrow("SZH","ZH_OK",,,lInverte,cMarca)

Return
/*/
_____________________________________________________________________________
¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
¦¦+-----------------------------------------------------------------------+¦¦
¦¦¦Funçào    ¦ValidPerg ¦ Autor ¦ Carlos N. Puerta    ¦ Data ¦ 21/05/2008 ¦¦¦
¦¦+----------+------------------------------------------------------------¦¦¦
¦¦¦Descriçào ¦ Verifica as perguntas incluindo-as caso nao existam        ¦¦¦
¦¦+----------+------------------------------------------------------------¦¦¦
¦¦¦Uso       ¦ Diversos programas especificos                             ¦¦¦
¦¦+-----------------------------------------------------------------------+¦¦
¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
/*/
Static Function ValidPerg()
_aArea := GetArea()
dbSelectArea("SX1")
dbSetOrder(1)
_cPerg := PADR(_cPerg,10)
_aRegs:={}

//          Grupo/Orde/Pergunt               /Perspa                /Pereng                /Variavl /Tip/Tam/D/P/GSC/Valid/Var01     /Def01/Defspa1/Defeng1/Cnt01/Var02/Def02/Defspa2/Defeng2/Cnt02/Var03/Def03/Defspa3/Defeng3/Cnt03/Var04/Def04/Defspa4/Defeng4/Cnt04/Var05/Def05/Defspa5/Defeng5/Cnt05/F3   /Grpsxg
AADD(_aRegs,{_cPerg,"01","Tabela                        ","Tabela                        ","Tabela                        ","mv_ch1","C",006,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","SZH","","","","",""})

For _nI:=1 To Len(_aRegs)
	If !dbSeek(_cPerg+_aRegs[_nI,2])
		RecLock("SX1",.T.)
		For _nJ:=1 to FCount()
			FieldPut(_nJ,_aRegs[_nI,_nJ])
		Next
		MsUnlock()
	Endif
Next

RestArea(_aArea)
Return

////////////////////////////////////////////////////////////////////////////////
// ************************************************************************** //
////////////////////////////////////////////////////////////////////////////////
Static Function Env_APMail()

Local cAliasSZJ		:= SZJ->(GetArea())
Local cFilSZJ		:= xFilial("SZJ")
Local cSoliciMail	:= ""

Private _cServer   := GetNewPar("MV_RELSERV","")             // "mail.emd.com.br:587"
Private _cAccount  := GetNewPar("MV_RELACNT","")             // "avisoprotheus@emd.com.br"
Private _cEnvia    := GetNewPar("MV_RELACNT","")             // "avisoprotheus@emd.com.br"
Private _cPassword := GetNewPar("MV_RELAPSW","")             // 'emdavisop367'
Private _lMailAuth := GetNewPar("MV_RELAUTH",.F.)
Private _cUserAp   := GetNewPar("MV_NCAPTAB","")             // Usuario aprovador.
Private _cCRLF     := Chr(13) + Chr(10)

Private _nI       	:= 0
Private _cNomeusr	:= UsrFullName(RetCodUsr(Substr(cUsuario,1,6)))

Private _cRecebe  	:= UsrRetMail(AllTrim(_cUserAp))// Usuario aprovador.
Private cEmail		:= ""
Private cConverte	:= ""

Private _cAssunto  := "ITENS DE TABELA DE PREÇO INTERMEDIARIA A SER(EM) LIBERADO(S)"
Private _cMensagem := ""

cConverte		:= _cUserAp

IF at(";",cConverte) > 0
	WHILE at(";",cConverte) > 0
		
		cEmail		:= cEmail+iif(empty(alltrim(cEmail)),UsrRetMail(AllTrim(substr(cConverte,1, at(";",cConverte)-1))),";"+UsrRetMail(AllTrim(substr(cConverte,1, at(";",cConverte)-1))))
		cConverte 	:= substr(cConverte,at(";",cConverte)+1,len(cConverte)) // pego o email do proximo codigo disponível
		
	ENDDO
ELSE
	cEmail 			:= UsrRetMail(AllTrim(cConverte))
ENDIF
_cRecebe 		:= cEmail

SZJ->(DbSetOrder(1))
DbSelectArea("SZJ")
SZJ->(DbSeek(cFilSZJ+MV_PAR01))

cSoliciMail := UsrRetMail(Alltrim(SZJ->ZJ_CODUSR))

_cMensagem += '<html>'
_cMensagem += '<head>'
_cMensagem += '<title> Sem Titulo </title>'
_cMensagem += '</head>' + _cCRLF
_cMensagem += '<BODY>'  + _cCRLF
_cMensagem += '<DIV>'   + _cCRLF
_cMensagem += '<DIV><IMG alt="" hspace=0 src="C:\Logo Email.jpg" border=0></DIV>'
_cMensagem += '<DIV> <hr color=CC0000> </DIV>' + _cCRLF + _cCRLF

//_cMensagem += '<font size="3" face="Verdana">O usuário '+AllTrim(_cNomeusr)+' em '+Dtoc(dDataBase)+' aprovou itens da Tabela de Preço Intermediaria '+SZJ->ZJ_CODIGO+' </font>'   + _cCRLF
_cMensagem += '<font size="3" face="Verdana">O usuário '+AllTrim(_cNomeusr)+' em '+Dtoc(dDataBase)+' aprovou itens da Tabela de Preço Intermediaria '+MV_PAR01+' </font>'   + _cCRLF

//Abre Tabela
_cMensagem += '<table border="0" width="100%" bgcolor="#EEE9E9">'
_cMensagem += '<tr>'
_cMensagem += '<td width="006%">'
_cMensagem += '<b><font size="2" face="Verdana">Item</font></b></td>'
_cMensagem += '<td width="024%">'
_cMensagem += '<b><font size="2" face="Verdana">Produto</font></b></td>'
_cMensagem += '<td width="55%">'
_cMensagem += '<b><font size="2" face="Verdana">Descrição</font></b></td>'
_cMensagem += '<td width="10%">'
_cMensagem += '<b><font size="2" face="Verdana"><p align="Right">Preço 00</p></font></b></td>'
_cMensagem += '<td width="05%">'
_cMensagem += '<b><font size="2" face="Verdana"><p align="Right">Status</p></font></b></td>'
_cMensagem += '</tr></table>'

//Preenche Tabela
For _nX := 1  To  Len(_aAPItens)
	_cItem    := AllTrim(_aAPItens[_nX,1])
	_cProduto := AllTrim(_aAPItens[_nX,2])
	_cDescri  := AllTrim(_aAPItens[_nX,3])
	_nPreco0  := AllTrim(_aAPItens[_nX,4])
	_cStatus  := AllTrim(_aAPItens[_nX,5])
	
	//If Int(_nX / 2) == (_nX / 2)
	_cMensagem += '<table border="0" width="100%" bgcolor="#EEE9E9">'
	_cMensagem += '<tr>'
	_cMensagem += '<td width="06%">'
	_cMensagem += '<font size="2" face="Verdana">' + _cItem +    '</font></td>'
	_cMensagem += '<td width="24%">'
	_cMensagem += '<font size="2" face="Verdana">' + _cProduto + '</font></td>'
	_cMensagem += '<td width="55%">'
	_cMensagem += '<font size="2" face="Verdana">' + _cDescri +  '</font></td>'
	_cMensagem += '<td width="10%">'
	_cMensagem += '<font size="2" face="Verdana"><p align="Right">' + _nPreco0 + '</p></font></td>'
	_cMensagem += '<td width="05%">'
	_cMensagem += '<font size="2" face="Verdana"><p align="Right">' + _cStatus + '</p></font></td>'
	_cMensagem += '</tr></table>'

Next

_cMensagem += _cCRLF
_cMensagem += '<DIV> <hr color=CC0000> </DIV>'     + _cCRLF
_cMensagem += '<font size="2" face="Verdana">E-Mail enviado automaticamente pelo sistema da ' + SM0->M0_NOMECOM + '</font>'       + _cCRLF
_cMensagem += '</body>'
_cMensagem += '</html>'

_cRecebe   := cSoliciMail+";"+_cRecebe //_cRecebe + ";" + _cUseMail

CONNECT SMTP SERVER _cServer ACCOUNT _cAccount PASSWORD _cPassword Result lConectou
MAILAUTH(_cAccount,_cPassword)

SEND MAIL FROM _cEnvia;
TO 				_cRecebe;
SUBJECT 		_cAssunto;
BODY 			_cMensagem;
RESULT 			lEnviado

If !lEnviado
	_cMensagem := "Falha ao Enviar"
	GET MAIL ERROR _cMensagem
	Alert(_cMensagem)
EndIf

DISCONNECT SMTP SERVER Result lDisConectou

If !lDisConectou
	Alert("Falha ao Desconectar com servidor de E-Mail - " + _cServer)
EndIf
     
SZJ->(DbCloseArea())
RestArea(cAliasSZJ)

Return

////////////////////////////////////////////////////////////////////////////////
// ************************************************************************** //
////////////////////////////////////////////////////////////////////////////////
Static Function Env_RJMail()

Local cAliasSZJ		:= SZJ->(GetArea())
Local cFilSZJ		:= xFilial("SZJ")
Local cSoliciMail	:= ""

Private _cServer   := GetNewPar("MV_RELSERV","")             // "mail.emd.com.br:587"
Private _cAccount  := GetNewPar("MV_RELACNT","")             // "avisoprotheus@emd.com.br"
Private _cEnvia    := GetNewPar("MV_RELACNT","")             // "avisoprotheus@emd.com.br"
Private _cPassword := GetNewPar("MV_RELAPSW","")             // 'emdavisop367'
Private _lMailAuth := GetNewPar("MV_RELAUTH",.F.)
Private _cUserAp   := GetNewPar("MV_NCAPTAB","")             // Usuario aprovador.
Private _cCRLF     := Chr(13) + Chr(10)

Private _nI        := 0
Private _cNomeusr	:= UsrFullName(RetCodUsr(Substr(cUsuario,1,6)))

Private _cRecebe   := UsrRetMail(AllTrim(_cUserAp))
Private cEmail		 := ""
Private cConverte	 := ""

Private _lDeletada := .F.

cConverte		:= _cUserAp

IF at(";",cConverte) > 0
	WHILE at(";",cConverte) > 0
		
		cEmail		:= cEmail+iif(empty(alltrim(cEmail)),UsrRetMail(AllTrim(substr(cConverte,1, at(";",cConverte)-1))),";"+UsrRetMail(AllTrim(substr(cConverte,1, at(";",cConverte)-1))))
		cConverte 	:= substr(cConverte,at(";",cConverte)+1,len(cConverte)) // pego o email do proximo codigo disponível
		
	ENDDO
ELSE
	cEmail 			:= UsrRetMail(AllTrim(cConverte))
ENDIF
_cRecebe 		:= cEmail 

SZJ->(DbSetOrder(1))
DbSelectArea("SZJ")
SZJ->(DbSeek(cFilSZJ+MV_PAR01))

cSoliciMail := UsrRetMail(Alltrim(SZJ->ZJ_CODUSR))


If !(_lDeletada)
	Private _cAssunto  := "ITENS DE TABELA DE PREÇO INTERMEDIARIA REJEITADO(S) E EXCLUIDO(S)"
Else
	Private _cAssunto  := "REJEIÇÃO E EXCLUSAO DA TABELA IENTERMEDIARIA"
EndIf
Private _cMensagem := ""

If !(_lDeletada)
	_cMensagem += '<html>'
	_cMensagem += '<head>'
	_cMensagem += '<title> Sem Titulo </title>'
	_cMensagem += '</head>' + _cCRLF
	_cMensagem += '<BODY>'  + _cCRLF
	_cMensagem += '<DIV>'   + _cCRLF
	_cMensagem += '<DIV><IMG alt="" hspace=0 src="C:\Logo Email.jpg" border=0></DIV>'
	_cMensagem += '<DIV> <hr color=CC0000> </DIV>' + _cCRLF + _cCRLF
	
	//	_cMensagem += '<font size="3" face="Verdana">O usuário '+AllTrim(_cNomeusr)+' em '+Dtoc(dDataBase)+' rejeitou itens da Tabela de Preço Intermediaria '+SZJ->ZJ_CODIGO+' </font>'   + _cCRLF
	_cMensagem += '<font size="3" face="Verdana">O usuário '+AllTrim(_cNomeusr)+' em '+Dtoc(dDataBase)+' rejeitou itens da Tabela de Preço Intermediaria '+MV_PAR01+' </font>'   + _cCRLF
	_cMensagem += '<font size="3" face="Verdana">Os Itens abaixo foram rejeitados e excluidos. </font>' + _cCRLF + _cCRLF
	
	//Abre Tabela
	_cMensagem += '<table border="0" width="100%" bgcolor="#EEE9E9">'
	_cMensagem += '<tr>'
	_cMensagem += '<td width="006%">'
	_cMensagem += '<b><font size="2" face="Verdana">Item</font></b></td>'
	_cMensagem += '<td width="024%">'
	_cMensagem += '<b><font size="2" face="Verdana">Produto</font></b></td>'
	_cMensagem += '<td width="55%">'
	_cMensagem += '<b><font size="2" face="Verdana">Descrição</font></b></td>'
	_cMensagem += '<td width="10%">'
	_cMensagem += '<b><font size="2" face="Verdana"><p align="Right">Preço 00</p></font></b></td>'
	_cMensagem += '<td width="05%">'
	_cMensagem += '<b><font size="2" face="Verdana"><p align="Right">Status</p></font></b></td>'
	_cMensagem += '</tr></table>'
Else
	_cMensagem += '<html>'
	_cMensagem += '<head>'
	_cMensagem += '<title> Sem Titulo </title>'
	_cMensagem += '</head>' + _cCRLF
	_cMensagem += '<BODY>'  + _cCRLF
	_cMensagem += '<DIV>'   + _cCRLF
	_cMensagem += '<DIV><IMG alt="" hspace=0 src="C:\Logo Email.jpg" border=0></DIV>'
	_cMensagem += '<DIV> <hr color=CC0000> </DIV>' + _cCRLF + _cCRLF
	
	//	_cMensagem += '<font size="3" face="Verdana">O usuário '+AllTrim(_cNomeusr)+' em '+Dtoc(dDataBase)+' rejeitou toda Tabela de Preço Intermediaria '+SZJ->ZJ_CODIGO+' </font>'   + _cCRLF
	_cMensagem += '<font size="3" face="Verdana">O usuário '+AllTrim(_cNomeusr)+' em '+Dtoc(dDataBase)+' rejeitou toda Tabela de Preço Intermediaria '+MV_PAR01+' </font>'   + _cCRLF
	_cMensagem += '<font size="3" face="Verdana">Toda tabela foi excluida. </font>' + _cCRLF + _cCRLF
EndIf

If !(_lDeletada)
	//Preenche Tabela
	For _nX := 1  To  Len(_aRJItens)
		_cItem    := AllTrim(_aRJItens[_nX,1])
		_cProduto := AllTrim(_aRJItens[_nX,2])
		_cDescri  := AllTrim(_aRJItens[_nX,3])
		_nPreco0  := AllTrim(_aRJItens[_nX,4])
		_cStatus  := AllTrim(_aRJItens[_nX,5])
		
		//If Int(_nX / 2) == (_nX / 2)
		_cMensagem += '<table border="0" width="100%" bgcolor="#EEE9E9">'
		_cMensagem += '<tr>'
		_cMensagem += '<td width="06%">'
		_cMensagem += '<font size="2" face="Verdana">' + _cItem +    '</font></td>'
		_cMensagem += '<td width="24%">'
		_cMensagem += '<font size="2" face="Verdana">' + _cProduto + '</font></td>'
		_cMensagem += '<td width="55%">'
		_cMensagem += '<font size="2" face="Verdana">' + _cDescri +  '</font></td>'
		_cMensagem += '<td width="10%">'
		_cMensagem += '<font size="2" face="Verdana"><p align="Right">' + _nPreco0 + '</p></font></td>'
		_cMensagem += '<td width="05%">'
		_cMensagem += '<font size="2" face="Verdana"><p align="Right">' + _cStatus + '</p></font></td>'
		_cMensagem += '</tr></table>'

	Next
EndIf

_cMensagem += _cCRLF
_cMensagem += '<DIV> <hr color=CC0000> </DIV>'     + _cCRLF
_cMensagem += '<font size="2" face="Verdana">E-Mail enviado automaticamente pelo sistema da ' + SM0->M0_NOMECOM + '</font>'       + _cCRLF
_cMensagem += '</body>'
_cMensagem += '</html>'

_cRecebe   := cSoliciMail+";"+_cRecebe //_cRecebe + ";" + _cUseMail

CONNECT SMTP SERVER _cServer ACCOUNT _cAccount PASSWORD _cPassword Result lConectou
MAILAUTH(_cAccount,_cPassword)

SEND MAIL FROM _cEnvia;
TO 				_cRecebe;
SUBJECT 			_cAssunto;
BODY 				_cMensagem;
RESULT 			lEnviado

If !lEnviado
	_cMensagem := "Falha ao Enviar"
	GET MAIL ERROR _cMensagem
	Alert(_cMensagem)
EndIf

DISCONNECT SMTP SERVER Result lDisConectou

If !lDisConectou
	Alert("Falha ao Desconectar com servidor de E-Mail - " + _cServer)
EndIf

SZJ->(DbCloseArea())
RestArea(cAliasSZJ)

Return

////////////////////////////////////////////////////////////////////////////////
// ************************************************************************** //
////////////////////////////////////////////////////////////////////////////////
Static Function DepuraSZHJ()
Private _lAprovado  := .F.
Private _lPendente  := .F.
Private _lRejeitado := .F.
Private _lDeletada  := .F.
Private _nNumItens  := 0

dbSelectArea("SZH")
dbSetOrder(3)         // ZH_FILIAL+ZH_CODIGO+ZH_ITEM
dbSeek(xFilial("SZH")+MV_PAR01,.T.)

Do While !Eof() .And. AllTrim(SZH->ZH_CODIGO) == AllTrim(MV_PAR01)
	/*If AllTrim(SZH->ZH_STAPROV) == "P"
	_lPendente := .T.
	_nNumItens++
	Else
	If AllTrim(SZH->ZH_STAPROV) == "A"
	_lAprovado := .T.
	_nNumItens++
	EndIf
	//EndIf*/
	If AllTrim(SZH->ZH_STAPROV) == "P"
		_lPendente := .T.
		_nNumItens++
	Else
		If AllTrim(SZH->ZH_STAPROV) == "A"
			_lAprovado := .T.
			_nNumItens++
		Else
			If AllTrim(SZH->ZH_STAPROV) == "R"
				_lRejeitado := .T.
				_nNumItens++
			EndIf
		EndIf
	EndIf
	
	dbSkip()
EndDo

If _nNumItens > 0
	dbSelectArea("SZJ")
	dbSetOrder(1)         // ZJ_FILIAL+ZJ_CODIGO
	If dbSeek(xFilial("SZJ")+MV_PAR01)
		RecLock("SZJ",.F.)
		//	If _lPendente .And. _lAprovado
		//SZJ->ZJ_STATUS  := "3"
		//Else
		//	If _lRejeitado .And. !(_lAprovado) .And. !(_lPendente)
		//SZJ->ZJ_STATUS  := "5"
		//	Else
		//		If _lAprovado .And. !(_lPendente) .And. !(_lRejeitada)
		//SZJ->ZJ_STATUS  := "1"
		//		EndIf
		//	EndIf
		//EndIf
		If _lPendente .And. _lAprovado
			SZJ->ZJ_STATUS  := "3"
		Else
			If _lRejeitado .And. !(_lAprovado) .And. !(_lPendente)
				SZJ->ZJ_STATUS  := "5"
			Else
				If _lAprovado .And. !(_lPendente)
					SZJ->ZJ_STATUS  := "1"
				EndIf
			EndIf
		EndIf
		MsUnLock()
	EndIf
Else
	dbSelectArea("SZJ")
	dbSetOrder(1)
	If dbSeek(xFilial("SZJ")+MV_PAR01)
		RecLock("SZJ",.F.)
		dbDelete()
		MsUnLock()
	EndIf
	_lDeletada := .T.
EndIf

If Len(_aRJItens) > 0 .Or. _lDeletada
	Env_RJMail()
EndIf

Return
