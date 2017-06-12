#INCLUDE "rwmake.ch"
#INCLUDE "tbiconn.ch"

////////////////////////////////////////////////////////////////////////////////
// ************************************************************************** // 
////////////////////////////////////////////////////////////////////////////////
User Function INC02SZHJ()
Private _aUser     := PswRet(1)
Private _lRet      := .T.
Private _lContinua := .T.
Private _cOpcao    := "INCLUIR"
Private _nOpcE     := 3
Private _nOpcG     := 3

Do Case
	Case _cOpcao == "INCLUIR"    ; _nOpcE := 3 ; _nOpcG := 3
	Case _cOpcao == "ALTERAR"    ; _nOpcE := 3 ; _nOpcG := 3
	Case _cOpcao == "VISUALIZAR" ; _nOpcE := 2 ; _nOpcG := 2
EndCase

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria variaveis M->????? da Enchoice                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
RegToMemory("SZJ",(_cOpcao == "INCLUIR"))

Private _cCodigo    := M->ZJ_CODIGO //NEXTNUMERO("SZJ",1,"ZJ_CODIGO",.T.)      // M->ZJ_CODIGO   // GETSXENUM("SZJ","ZJ_CODIGO")
Private _nI         := 0
Private nUsado      := 0
Private aHeader     := {}
Private aCols       := {}
Private _aItensSZH  := {}
Private _cUsuario   := RetCodUsr()
Private _cNomeUsr   := UsrRetName(_cUsuario)
Private _lProdEmTab := .F.


//Processo incluso para recuperar o ultimo registro na tabela SZJ pois a função RegToMemory não estava funcionando corretamente
Private nX3Tam	:= TamSx3("ZJ_CODIGO")
dbSelectArea("SZJ")
dbGoBottom()

if ZJ_CODIGO != _cCodigo
	_cCodigo := PADl(CValToChar(Val(AllTrim(ZJ_CODIGO))+1),nX3Tam[1],'0')
	
	M->ZJ_CODIGO := _cCodigo
endif
//FIm do processo incluso para corrigir o problema com a função RegToMemory

dbSelectArea("SX3")
dbSetOrder(1)
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

Private _cPublisher := AllTrim(RetCodUsr())
Private _cItemCC    := Space(09)
Private aCols       := {}

dbSelectArea("CTD")
dbOrderNickName("CTDCODUSR")
dbSeek(xFilial("CTD")+_cPublisher,.T.)
Do While !Eof() .And. AllTrim(_cPublisher) == AllTrim(CTD->CTD_CODUSR)
    _cItemCC := CTD->CTD_ITEM
    dbSelectArea("SB1")
    dbOrderNickName("B1ITEMCC")
    dbSeek(xFilial("SB1")+_cItemCC,.T.)
    Do While !Eof() .And. _cItemCC == SB1->B1_ITEMCC
	    If SB1->B1_MSBLQL == "1"
		    dbSkip()
		    Loop
	    EndIf

        _lProdEmTab := .F.
	    dbSelectArea("SZH")
	    dbSetOrder(1)
	    dbSeek(xFilial("SZH")+SB1->B1_COD)
	    Do While !Eof() .And. SB1->B1_COD == SZH->ZH_PRODUTO
	        If GETADVFVAL("SZJ","ZJ_STATUS",XFILIAL("SZJ")+SZH->ZH_CODIGO,1,SPACE(01)) <> "2"
//	            Alert("Produto "+SB1->B1_COD+" esta digitado na Tabela "+SZJ->ZJ_CODIGO+" que ainda se encontra com Status Pendente Efetivacao....")
	            _lProdEmTab := .T.
	            Exit
            EndIf
            dbSkip()
        EndDo

        dbSelectArea("SB1")
        If _lProdEmTab
            dbSkip()
            Loop
        EndIf
	    
	    AADD(aCols,Array(nUsado+1))
	    For _nI:=1 To nUsado
		    If AllTrim(Upper(aHeader[_nI,2])) == "ZH_ITEM"
			    aCols[Len(aCols),_nI] := StrZero(Len(aCols),4)
		    EndIf
		    If AllTrim(Upper(aHeader[_nI,2])) == "ZH_PRODUTO"
			    aCols[Len(aCols),_nI] := SB1->B1_COD
    	    EndIf
		    If AllTrim(Upper(aHeader[_nI,2])) == "ZH_XDESC"
			    aCols[Len(aCols),_nI] := SB1->B1_XDESC
		    EndIf
		    If AllTrim(Upper(aHeader[_nI,2])) == "ZH_UPRC"
			    aCols[Len(aCols),_nI] := SB1->B1_UPRC
		    EndIf
		    If AllTrim(Upper(aHeader[_nI,2])) == "ZH_CM1"
			    aCols[Len(aCols),_nI] := GETADVFVAL("SB2","B2_CM1",XFILIAL("SB2")+SB1->B1_COD+"01",1,0.00)
		    EndIf
		    If AllTrim(Upper(aHeader[_nI,2])) == "ZH_QATU"
			    aCols[Len(aCols),_nI] := GETADVFVAL("SB2","B2_QATU",XFILIAL("SB2")+SB1->B1_COD+"01",1,0.00)
		    EndIf
		    If AllTrim(Upper(aHeader[_nI,2])) == "ZH_VATU1"
			    aCols[Len(aCols),_nI] := GETADVFVAL("SB2","B2_VATU1",XFILIAL("SB2")+SB1->B1_COD+"01",1,0.00)
		    EndIf
		    If AllTrim(Upper(aHeader[_nI,2]))<>"ZH_ITEM"    .And. AllTrim(Upper(aHeader[_nI,2]))<>"ZH_PRODUTO" .And.;
		       AllTrim(Upper(aHeader[_nI,2]))<>"ZH_XDESC"   .And. AllTrim(Upper(aHeader[_nI,2]))<>"ZH_UPRC"    .And.;
		       AllTrim(Upper(aHeader[_nI,2]))<>"ZH_CM1"     .And. AllTrim(Upper(aHeader[_nI,2]))<>"ZH_QATU"    .And.;
 		       AllTrim(Upper(aHeader[_nI,2]))<>"ZH_VATU1"
			    aCols[Len(aCols),_nI] := CriaVar(aHeader[_nI,2])
		    EndIf
	    Next
	    aCols[Len(aCols),nUsado+1]:=.F.
	    dbSkip()
    EndDo
    dbSelectArea("CTD")
    dbSkip()
EndDo
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
Private _nPosObs001    := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="ZH_OBS001" })
Private _nPosCodigo    := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="ZH_CODIGO"  })
Private _nPosPrvSug    := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="ZH_PRVSUG"  })
//Private _nPos04Preco   := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="ZH_PRECO04" })

Private _nPosDTInc     := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="ZH_DTINC"  })
Private _nPosHRInc     := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="ZH_HRINC"  })
Private _nPosSTAprov   := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="ZH_STAPROV"  })

Private _nIPosDel      := Len(aHeader) + 1

Private cTitulo        := "Tabela Intermediaria - Incluir"
Private cAliasEnchoice := "SZJ"
Private cAliasGetD     := "SZH"
Private cLinOk         := 'ExecBlock("VAL_PRVSUG",.F.,.F.) .And. ExecBlock("I02MESMOPROD",.F.,.F.)'    // "AllwaysTrue()"
Private cTudOk         := "AllwaysTrue()"
Private cFieldOk       := "AllwaysTrue()"
Private aCpoEnchoice   := {SZH->ZH_CODIGO}
//Private aCordW       := {001,0,700,998}
//Private aCordW 	   := {0,0,650,1300}
//Private aCordW         := {450,0,990,990}
//Private nSizeHeader    := 350

Private aCordW         := {001,005,700,1250}
Private nSizeHeader    := 200

Private nFreeze        := 2
Private aBotao         := {}

Do While _lContinua           // .T.
	//               1          2              3     4    5      6     7      8      9      10 11 12 13  14     15      16
	_lRet:=Modelo3(cTitulo,cAliasEnchoice,cAliasGetD,,cLinOk,cTudOk,_nOpcE,_nOpcG,cFieldOk,  , ,  ,  ,aBotao,aCordW,nSizeHeader)
	
	If _lRet
		If Empty(M->ZJ_CODIGO) .Or. Empty(M->ZJ_TIPOALT) .Or. Empty(M->ZJ_STATUS)
			Help("",1,"OBRIGAT")
			Loop
		Else
		    Rot_01Grava()
        	_lContinua := .F.
        	_lRet      := .F.
			Exit
		EndIf
	Else
		Exit
	EndIf
EndDo
If Len(_aItensSZH) > 0
//  Envia_01EMail()
    Envia_02EMail()
EndIf
_lContinua := .F.
_lRet      := .F.
Return

////////////////////////////////////////////////////////////////////////////////
// ************************************************************************** // 
////////////////////////////////////////////////////////////////////////////////
Static Function Rot_01Grava()
Private _nIT := 0
Private _nIU := 0
For _nIT := 1 To Len(aCols)
//	If Empty(aCols[_nIT,_nPosXDesc]) .And. aCols[_nIT,_nPosPrv0] == 0.00
	If aCols[_nIT,_nPosPrv0] == 0.00
		aCols[_nIT,_nIPosDel] := .T.
	Else
	    _nIU := _nIU + 1
	EndIf
Next

If _nIU > 0
	//
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Gravacao do Cabecalho - SZJ                                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	//
	dbSelectArea("SZJ")
	dbSetOrder(1)
	If !(dbSeek(xFilial("SZJ")+_cCodigo))
		RecLock("SZJ",.T.)
		SZJ->ZJ_FILIAL  := xFilial("SZJ")
		SZJ->ZJ_CODIGO  := _cCodigo
		SZJ->ZJ_TIPOALT := M->ZJ_TIPOALT
		SZJ->ZJ_CODUSR  := M->ZJ_CODUSR
		SZJ->ZJ_NOMUSR  := UsrRetName(M->ZJ_CODUSR)
		SZJ->ZJ_DTPROG  := M->ZJ_DTPROG
		SZJ->ZJ_STATUS  := "4"                                 // M->ZJ_STATUS
		SZJ->ZJ_MOTIVO  := M->ZJ_MOTIVO
		SZJ->ZJ_DESMOT  := M->ZJ_DESMOT
		MsUnLock()
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Gravacao dos itens - SZN                                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	For _nIT := 1 To Len(aCols)
		If !(aCols[_nIT,_nIPosDel])
			RecLock("SZH",.T.)
			SZH->ZH_FILIAL  := xFilial("SZH")
			SZH->ZH_CODIGO  := _cCodigo
			SZH->ZH_ITEM    := aCols[_nIT,_nPosItem]
			SZH->ZH_PRODUTO := aCols[_nIT,_nPosProduto]
			SZH->ZH_XDESC   := aCols[_nIT,_nPosXDesc]
			SZH->ZH_PRV0    := aCols[_nIT,_nPosPrv0]
			SZH->ZH_MKUP00  := aCols[_nIT,_nPos00Mkup]
			
//			SZH->ZH_PRECO18 := aCols[_nIT,_nPos18Preco]
//			If aCols[_nIT,_nPos18Mkup] < -999.99
//			    SZH->ZH_MKUP18  := -999.99
//			Else
//			    SZH->ZH_MKUP18  := aCols[_nIT,_nPos18Mkup]
//			EndIf
//			SZH->ZH_PRECO12 := aCols[_nIT,_nPos12Preco]
//			If aCols[_nIT,_nPos12Mkup] < -999.99
//			    SZH->ZH_MKUP12  := -999.99
//			Else
//			    SZH->ZH_MKUP12  := aCols[_nIT,_nPos12Mkup]
//			EndIf
//			SZH->ZH_PRECO07 := aCols[_nIT,_nPos07Preco]
//            If aCols[_nIT,_nPos07Mkup] < -999.99
//                SZH->ZH_MKUP07  := -999.99
//            Else
//                SZH->ZH_MKUP07  := aCols[_nIT,_nPos07Mkup]
//            EndIf

//			SZH->ZH_PRECO04 := aCols[_nIT,_nPos04Preco]
			SZH->ZH_UPRC    := aCols[_nIT,_nPosUprc]
			SZH->ZH_CM1     := aCols[_nIT,_nPosCM1]
			SZH->ZH_QATU    := aCols[_nIT,_nPosQATU]
			SZH->ZH_VATU1   := aCols[_nIT,_nPosVATU1]
			SZH->ZH_OBS001  := aCols[_nIT,_nPosObs001]
		    SZH->ZH_PRVSUG  := aCols[_nIT,_nPosPrvSug]

			SZH->ZH_DTINC   := aCols[_nIT,_nPosDTInc]
			SZH->ZH_HRINC   := aCols[_nIT,_nPosHRInc]
			SZH->ZH_STAPROV := aCols[_nIT,_nPosSTAprov]
			MsUnLock()
            AADD(_aItensSZH,{SZH->ZH_ITEM,SZH->ZH_PRODUTO,SZH->ZH_XDESC,Str(SZH->ZH_PRV0,10,2)/*/,Str(SZH->ZH_PRECO18,10,2),Str(SZH->ZH_PRECO12,10,2),Str(SZH->ZH_PRECO07,10,2),Str(SZH->ZH_PRVSUG,10,2)/*/})
   		EndIf
	Next _nIT

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Renumera os itens do cadastro                                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Private _cNumIt := 0
	dbSelectArea("SZH")
	dbSetOrder(4)    // ZH_FILIAL+ZH_CODIGO+ZH_PRODUTO
	dbSeek(xFilial("SZH")+_cCodigo,.T.)
	Do While !Eof() .And. _cCodigo == SZH->ZH_CODIGO
		RecLock("SZH",.F.)
		_cNumIt      := _cNumIt + 1
		SZH->ZH_ITEM := StrZero(_cNumIt,4)
		MsUnLock()
		dbSkip()
	EndDo
EndIf
_lContinua := .F.
_lRet      := .F.
Return

////////////////////////////////////////////////////////////////////////////////
// ************************************************************************** // 
////////////////////////////////////////////////////////////////////////////////
User Function I02MESMOPROD()
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
Static Function Envia_01EMail()
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

_cMensagem := _cMensagem                                                                                                        + _cCRLF + _cCRLF +;
"O usuário "+AllTrim(_cNomeusr)+" em "+Dtoc(dDataBase)+" as "+time()+" inclui a Tabela de Preço Intermediaria "+SZJ->ZJ_CODIGO  + _cCRLF + _cCRLF +;
"Os Itens abaixo necessitam de sua aprovação para serem atualizadas nas tabelas de preço oficiais."                             + _cCRLF + _cCRLF +;
"Item      Produto         - Descricao                                               Preco 00"+ _cCRLF + _cCRLF

For _nI := 1  To  Len(_aItensSZH)
    _cMensagem := _cMensagem+_aItensSZH[_nI,1]+SPACE(06)+_aItensSZH[_nI,2]+" - "+Substr(_aItensSZH[_nI,3],1,30)+Space(10)+_aItensSZH[_nI,4]+_cCRLF
Next

_cMensagem := _cMensagem + _cCRLF + _cCRLF + _cCRLF +;
"Favor efetuar procedimentos necessários."                                           + _cCRLF + _cCRLF + _cCRLF + _cCRLF + _cCRLF

_cMensagem := _cMensagem + "______________________________________________________________________________________"     + _cCRLF + _cCRLF
_cMensagem := _cMensagem + "Favor não responder esse e-mail. Mensagem enviada automaticamente pelo sistema Protheus11 - TOTVS"

//_cRecebe   := "cnpuerta@globo.com;" + _cOutrosUsrs

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