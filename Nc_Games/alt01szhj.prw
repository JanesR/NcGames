#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "AP5MAIL.CH"

////////////////////////////////////////////////////////////////////////////////
// ************************************************************************** // 
////////////////////////////////////////////////////////////////////////////////
User Function ALT01SZHJ()
Private _aUser  := PswRet(1)
Private _lRet   := .T.
Private _cOpcao := "ALTERAR"
Private _nOpcE  := 3
Private _nOpcG  := 3

Do Case
	Case _cOpcao == "INCLUIR"    ; _nOpcE := 3 ; _nOpcG := 3
	Case _cOpcao == "ALTERAR"    ; _nOpcE := 3 ; _nOpcG := 3
	Case _cOpcao == "VISUALIZAR" ; _nOpcE := 2 ; _nOpcG := 2
EndCase

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria variaveis M->????? da Enchoice                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
RegToMemory("SZJ",(_cOpcao == "INCLUIR"))

Private _cCodigo   := SZJ->ZJ_CODIGO
Private _nI        := 0
Private nUsado     := 0
Private aHeader    := {}
Private aCols      := {}
Private _aItensSZH := {}

If SZJ->ZJ_STATUS == "2"
    Alert("Tabela Ja Concluida, portanto NAO sera possivel sua alteracao...")
    Return
EndIf

dbSelectArea("SX3")
dbSeek("SZH")
Do While !Eof().And.(x3_arquivo=="SZH")
	If Upper(AllTrim(X3_CAMPO)) == "ZH_CODIGO"
		dbSkip()
		Loop
	EndIf
	If X3USO(x3_usado) .And. cNivel >= x3_nivel
		nUsado:=nUsado+1
		Aadd(aHeader,{ TRIM(x3_titulo), x3_campo, x3_picture,;
		x3_tamanho, x3_decimal,X3_VALID,;
		x3_usado, x3_tipo, x3_arquivo, x3_context } )
	EndIf
	dbSkip()
EndDo

If _cOpcao == "INCLUIR"
	aCols := {Array(nUsado+1)}
	aCols[1,nUsado+1] := .F.
	For _nI:=1 To nUsado
		aCols[1,_nI] := If(AllTrim(Upper(aHeader[_nI,2]))=="ZH_ITEM",StrZero(_nI,4),CriaVar(aHeader[_nI,2]))
	Next
Else
	aCols:={}
	dbSelectArea("SZH")
	dbSetOrder(3)
	dbSeek(xFilial("SZH")+_cCodigo,.T.)
	Do While !Eof() .And. SZH->ZH_CODIGO == _cCodigo
		AADD(aCols,Array(nUsado+1))
		For _nI:=1 to nUsado
			If Upper(AllTrim(aHeader[_nI,10])) != "V" 
				aCols[Len(aCols),_ni]:=FieldGet(FieldPos(aHeader[_ni,2]))
			Else 
				aCols[Len(aCols),_ni]:=CriaVar(aHeader[_ni,2])
			Endif
		Next
		aCols[Len(aCols),nUsado+1]:=.F.
		dbSkip()
	EndDo
EndIf
//
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis de posicionamento no aCols                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private _nPosItem      := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="ZH_ITEM"    })
Private _nPosProduto   := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="ZH_PRODUTO" })
Private _nPosXDesc     := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="ZH_XDESC"   })
Private _nPosPrv0      := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="ZH_PRV0"    })
Private _nPos00Mkup    := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="ZH_MKUP00" })
//Private _nPos18Preco   := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="ZH_PRECO18" })
//Private _nPos18Mkup    := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="ZH_MKUP18" })
//Private _nPos12Preco   := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="ZH_PRECO12" })
//Private _nPos12Mkup    := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="ZH_MKUP12" })
//Private _nPos07Preco   := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="ZH_PRECO07" })
//Private _nPos07Mkup    := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="ZH_MKUP07" })
Private _nPosUprc      := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="ZH_UPRC" })
Private _nPosCM1       := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="ZH_CM1" })
Private _nPosMKUP      := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="ZH_MKUP" })
Private _nPosQATU      := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="ZH_QATU" })
Private _nPosVATU1     := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="ZH_VATU1" })

Private _nPosObs001    := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="ZH_OBS001"  })
Private _nPosCodigo    := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="ZH_CODIGO"  })
Private _nPosPrvSug    := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="ZH_PRVSUG"  })

Private _nPosDTInc     := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="ZH_DTINC"  })
Private _nPosHRInc     := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="ZH_HRINC"  })
Private _nPosSTAprov   := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="ZH_STAPROV"  })
Private _nIPosDel      := Len(aHeader) + 1

Private cTitulo        := "Tabela Intermediaria - Incluir"
Private cAliasEnchoice := "SZJ"
Private cAliasGetD     := "SZH"
Private cLinOk         := 'ExecBlock("VAL_PRVSUG",.F.,.F.) .And. ExecBlock("AMESMOPROD",.F.,.F.)'               // "AllwaysTrue()"
Private cTudOk         := "AllwaysTrue()"
Private cFieldOk       := "AllwaysTrue()"
Private aCpoEnchoice   := {SZH->ZH_CODIGO}
//Private aCordW       := {001,0,700,998}
//Private aCordW 	     := {0,0,650,1300}
//Private aCordW       := {450,0,990,990}
//Private nSizeHeader  := 350

Private aCordW         := {001,005,700,1250}
Private nSizeHeader    := 200

Private nFreeze        := 2
Private aBotao         := {}

Do While .T.
	//               1          2              3     4    5      6     7      8      9      10 11 12 13  14     15      16
	_lRet:=Modelo3(cTitulo,cAliasEnchoice,cAliasGetD,,cLinOk,cTudOk,_nOpcE,_nOpcG,cFieldOk,  , ,  ,  ,aBotao,aCordW,nSizeHeader)
	
	If _lRet
		If Empty(M->ZJ_CODIGO) .Or. Empty(M->ZJ_TIPOALT) .OR. Empty(M->ZJ_STATUS)
			Help("",1,"OBRIGAT")
			Loop
		Else
			Rot_01ReGrava()
			Exit
		EndIf
	Else
		Exit
	EndIf
EndDo
Return

////////////////////////////////////////////////////////////////////////////////
// ************************************************************************** // 
////////////////////////////////////////////////////////////////////////////////
Static Function Rot_01ReGrava()
//
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Gravacao do Cabecalho - SZJ                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//
dbSelectArea("SZJ")
dbSetOrder(1)
If dbSeek(xFilial("SZJ")+_cCodigo)
	RecLock("SZJ",.F.)
	SZJ->ZJ_FILIAL  := xFilial("SZJ")
	SZJ->ZJ_CODIGO  := _cCodigo
	SZJ->ZJ_TIPOALT := M->ZJ_TIPOALT
	SZJ->ZJ_CODUSR  := M->ZJ_CODUSR
	SZJ->ZJ_NOMUSR  := UsrRetName(M->ZJ_CODUSR)
	SZJ->ZJ_DTPROG  := M->ZJ_DTPROG
	SZJ->ZJ_STATUS  := "4"    // M->ZJ_STATUS
	MsUnLock()
EndIf
Private _lAprovado  := .F.
Private _lPendente  := .F.
Private _lRejeitado := .F.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Gravacao dos itens - SZN                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
For _nIT := 1 To Len(aCols)
	If !(aCols[_nIT,_nIPosDel])
		dbSelectArea("SZH")
		dbSetOrder(4)
		If !dbSeek(xFilial("SZH")+_cCodigo+aCols[_nIT,_nPosProduto])
			RecLock("SZH",.T.)
		Else
			RecLock("SZH",.F.)
		EndIf
		SZH->ZH_FILIAL  := xFilial("SZH")
		SZH->ZH_CODIGO  := _cCodigo
		SZH->ZH_ITEM    := aCols[_nIT,_nPosItem]
		SZH->ZH_PRODUTO := aCols[_nIT,_nPosProduto]
		SZH->ZH_XDESC   := aCols[_nIT,_nPosXDesc]
		SZH->ZH_PRV0    := aCols[_nIT,_nPosPrv0]
		SZH->ZH_MKUP00  := aCols[_nIT,_nPos00Mkup]
//		SZH->ZH_PRECO18 := aCols[_nIT,_nPos18Preco]
//    SZH->ZH_MKUP18  := aCols[_nIT,_nPos18Mkup]
//	   SZH->ZH_PRECO12 := aCols[_nIT,_nPos12Preco]
//		SZH->ZH_MKUP12  := aCols[_nIT,_nPos12Mkup]
//		SZH->ZH_PRECO07 := aCols[_nIT,_nPos07Preco]
//		SZH->ZH_MKUP07  := aCols[_nIT,_nPos07Mkup]
		SZH->ZH_UPRC    := aCols[_nIT,_nPosUprc]
		SZH->ZH_CM1     := aCols[_nIT,_nPosCM1]
		SZH->ZH_QATU    := aCols[_nIT,_nPosQATU]
		SZH->ZH_VATU1   := aCols[_nIT,_nPosVATU1]
		SZH->ZH_OBS001  := aCols[_nIT,_nPosObs001]
		SZH->ZH_PRVSUG  := aCols[_nIT,_nPosPrvSug]
		SZH->ZH_DTINC   := aCols[_nIT,_nPosDTInc]
		SZH->ZH_HRINC   := aCols[_nIT,_nPosHRInc]
		SZH->ZH_STAPROV := aCols[_nIT,_nPosSTAprov]
      AADD(_aItensSZH,{SZH->ZH_ITEM,SZH->ZH_PRODUTO,SZH->ZH_XDESC,Str(SZH->ZH_PRV0,10,2),AllTrim(SZH->ZH_STAPROV)/*/,Str(SZH->ZH_PRECO18,10,2),Str(SZH->ZH_PRECO12,10,2),Str(SZH->ZH_PRECO07,10,2),Str(SZH->ZH_PRVSUG,10,2)/*/})
		MsUnLock()
	Else
		dbSelectArea("SZH")
		dbSetOrder(3)
		If dbSeek(xFilial("SZH")+_cCodigo+aCols[_nIT,_nPosItem])
			RecLock("SZH",.F.)
			dbDelete()
			MsUnLock()
		Endif
	Endif
   If AllTrim(SZH->ZH_STAPROV) == "P"
       _lPendente := .T.
   Else
       If AllTrim(SZH->ZH_STAPROV) == "A"
           _lAprovado := .T.
       Else
           If AllTrim(SZH->ZH_STAPROV) == "R"
               _lRejeitado := .T.
           EndIf
       EndIf
   EndIf
Next _nIT

dbSelectArea("SZJ")
dbSetOrder(1)
If dbSeek(xFilial("SZJ")+_cCodigo)
	RecLock("SZJ",.F.)
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

If Len(_aItensSZH) > 0
    ReZHItem()
    Envia_02EMail()
    _aItensSZH := {}
EndIf
Return

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Renumera os itens do cadastro                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Static Function ReZHItem()
Private _cNumIt := 0
dbSelectArea("SZH")
dbSetOrder(4)                // ZH_FILIAL+ZH_CODIGO+ZH_PRODUTO
dbSeek(xFilial("SZH")+SZH->ZH_CODIGO,.T.)
Do While !Eof() .And. SZH->ZH_CODIGO == _cCodigo
	RecLock("SZH",.F.)
	_cNumIt      := _cNumIt + 1
	SZH->ZH_ITEM := StrZero(_cNumIt,4)
	MsUnLock()
	dbSkip()
EndDo
Return

////////////////////////////////////////////////////////////////////////////////
// ************************************************************************** // 
////////////////////////////////////////////////////////////////////////////////
User Function AMESMOPROD()
Private _lRet     := .T.
Private _cProduto := ACOLS[N][aScan(AHEADER,{|e|Trim(e[2])=="ZH_PRODUTO"})]

If _lRet
	If !(aCols[N,Len(aHeader)+1])
	    _nI := 0
	    For _nI := 1  To  Len(aCols)
	        If _nI <> N .And. !(aCols[_nI,Len(aHeader)+1])
               If AllTrim(_cProduto) == AllTrim(ACOLS[_nI][aScan(AHEADER,{|e|Trim(e[2])=="ZH_PRODUTO"})])
		             Alert("Produto ja digitado nessa mesma tabela... Item: "+StrZero(_nI,4))
		             _lRet := .F.
		         EndIf
		     EndIf
		 Next
	EndIf
EndIf
Return(_lRet)

////////////////////////////////////////////////////////////////////////////////
// ************************************************************************** // 
////////////////////////////////////////////////////////////////////////////////
Static Function Envia_02EMail()
Private _cServer   := GetNewPar("MV_RELSERV","")             // "mail.emd.com.br:587"
Private _cAccount  := GetNewPar("MV_RELACNT","")             // "avisoprotheus@emd.com.br"
Private _cEnvia    := GetNewPar("MV_RELACNT","")             // "avisoprotheus@emd.com.br"
Private _cPassword := GetNewPar("MV_RELAPSW","")             // 'emdavisop367'
Private _lMailAuth := GetNewPar("MV_RELAUTH",.F.)
Private _cUserAp   := GetNewPar("MV_NCAPTAB","")             // Usuario aprovador.
Private _cCRLF     := Chr(13) + Chr(10)

Private _nI        := 0
Private _cUser     := RetCodUsr(Substr(cUsuario,1,6))
Private _cNomeusr  := UsrRetName(_cUser)
Private _cRecebe   := UsrRetMail(AllTrim(_cUserAp))

Private _cVendedor := Space(06)
Private _cEMailVen := Space(30)
Private _cVenEMail := Space(01)

Private _cAssunto  := "INCLUSAO DE TABELA DE PREÇO INTERMEDIARIA A SER LIBERADA"
Private _cMensagem := ""

_cMensagem += '<html>'
_cMensagem += '<head>'
_cMensagem += '<title> Sem Titulo </title>'
_cMensagem += '</head>' + _cCRLF
_cMensagem += '<BODY>'  + _cCRLF
_cMensagem += '<DIV>'   + _cCRLF
_cMensagem += '<DIV><IMG alt="" hspace=0 src="C:\Logo Email.jpg" border=0></DIV>'
_cMensagem += '<DIV> <hr color=CC0000> </DIV>' + _cCRLF + _cCRLF

_cMensagem += '<font size="3" face="Verdana">O usuário '+AllTrim(_cNomeusr)+' em '+Dtoc(dDataBase)+' incluiu a Tabela de Preço Intermediaria '+SZJ->ZJ_CODIGO+' </font>'   + _cCRLF
_cMensagem += '<font size="3" face="Verdana">Os Itens abaixo necessitam de sua aprovação. </font>' + _cCRLF + _cCRLF

//Abre Tabela
_cMensagem += '<table border="0" width="100%" bgcolor="#EEE9E9">'
_cMensagem += '<tr>'
_cMensagem += '<td width="006%">'
_cMensagem += '<b><font size="2" face="Verdana">Item</font></b></td>'
_cMensagem += '<td width="024%">'
_cMensagem += '<b><font size="2" face="Verdana">Produto</font></b></td>'
_cMensagem += '<td width="60%">'
_cMensagem += '<b><font size="2" face="Verdana">Descrição</font></b></td>'
_cMensagem += '<td width="10%">'
_cMensagem += '<b><font size="2" face="Verdana"><p align="Right">Preço 00</p></font></b></td>'
_cMensagem += '</tr></table>'

//Preenche Tabela
For _nX := 1  To  Len(_aItensSZH)
	_cItem    := AllTrim(_aItensSZH[_nX,1])
	_cProduto := AllTrim(_aItensSZH[_nX,2])
	_cDescri  := AllTrim(_aItensSZH[_nX,3])
	_nPreco0  := AllTrim(_aItensSZH[_nX,4])
	
	If Int(_nX / 2) == (_nX / 2)
		_cMensagem += '<table border="0" width="100%" bgcolor="#EEE9E9">'
		_cMensagem += '<tr>'
		_cMensagem += '<td width="06%">'
		_cMensagem += '<font size="2" face="Verdana">' + _cItem +    '</font></td>'
		_cMensagem += '<td width="24%">'
		_cMensagem += '<font size="2" face="Verdana">' + _cProduto + '</font></td>'
		_cMensagem += '<td width="60%">'
		_cMensagem += '<font size="2" face="Verdana">' + _cDescri +  '</font></td>'
		_cMensagem += '<td width="10%">'
		_cMensagem += '<font size="2" face="Verdana"><p align="Right">' + _nPreco0 + '</p></font></td>'
		_cMensagem += '</tr></table>'
	Else
		_cMensagem += '<table border="0" width="100%" bgcolor="#FFFFFF">'
		_cMensagem += '<tr>'
		_cMensagem += '<td width="06%">'
		_cMensagem += '<font size="2" face="Verdana">' + _cItem +    '</font></td>'
		_cMensagem += '<td width="24%">'
		_cMensagem += '<font size="2" face="Verdana">' + _cProduto + '</font></td>'
		_cMensagem += '<td width="60%">'
		_cMensagem += '<font size="2" face="Verdana">' + _cDescri +  '</font></td>'
		_cMensagem += '<td width="10%">'
		_cMensagem += '<font size="2" face="Verdana"><p align="Right">' + _nPreco0 + '</p></font></td>'
		_cMensagem += '</tr></table>'
	EndIf
Next

_cMensagem += _cCRLF
_cMensagem += '<DIV> <hr color=CC0000> </DIV>'     + _cCRLF
_cMensagem += '<font size="2" face="Verdana">E-Mail enviado automaticamente pelo sistema da ' + SM0->M0_NOMECOM + '</font>'       + _cCRLF
_cMensagem += '</body>'
_cMensagem += '</html>'

//_cRecebe   := "cnpuerta@globo.com;"

CONNECT SMTP SERVER _cServer ACCOUNT _cAccount PASSWORD _cPassword Result lConectou
MAILAUTH(_cAccount,_cPassword)

SEND MAIL FROM _cEnvia;
TO _cRecebe;
SUBJECT _cAssunto;
BODY _cMensagem;
RESULT lEnviado

If !lEnviado
	_cMensagem := "Falha ao Enviar"
	GET MAIL ERROR _cMensagem
	Alert(_cMensagem)
EndIf

DISCONNECT SMTP SERVER Result lDisConectou

If !lDisConectou
	Alert("Falha ao Desconectar com servidor de E-Mail - " + _cServer)
EndIf
Return