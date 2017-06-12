#INCLUDE "rwmake.ch"
#INCLUDE "tbiconn.ch"
#INCLUDE "PROTHEUS.CH"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ UFNCAPROV ³ Autor ³ Carlos N. Puerta       ³ Data ³ Set/2012 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Programa para Aprovar/Rejeitar SCs Atraves dos arquivos      ³±±
±±³          ³ SZM e SZN                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Especifico NCGames                                           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function UFNCAPROV()
SetPrvt("aRotina,cCadastro")
Private _cUsuario   := RetCodUsr()
Private _cNomeUsr   := UsrRetName(_cUsuario)
Private _cMailUser  := AllTrim(UsrRetMail(_cUsuario))
Private _cFiltraSZM := 'ZM_USRAPRO == _cUsuario .And. (ZM_APROV = "B" .Or. ZM_APROV = "R")'
Private _aIndexSZM  := {}

SetKey( VK_F8, { || U_CONSC1ZI() } )

Private _aCores	    := {;
	{'ZM_APROV$" ,L"' 	              ,'DISABLE' },;	//Solicitacao de Compras Liberada
	{'ZM_APROV="B"'	                  ,'BR_CINZA'},;	//Solicitacao de Compras Bloqueada
	{'ZM_APROV="R"'	                  ,'BR_LARANJA'}}	//Solicitacao de Compras Rejeitada

aRotina   := { { "Pesquisar"  ,"AxPesqui"    , 0 , 1 , 0,.F.},;
		       { "Visualizar" ,"U_VIS01SZMN" , 0 , 1 , 0, nil},;
		       { "Rejeitar"   ,"U_UFA110RJ"  , 0 , 2 , 0, nil},;
		       { "Aprovar"    ,"U_UFA110AP"  , 0 , 4 , 0, nil},;
		       { "Legenda"    ,"U_LEGAPROV"  , 0 , 7 , 0, nil}}

cCadastro := "Rotina de Liberacao de SCs"

_bFiltraBrw := {|| FilBrowse("SZM",@_aIndexSZM,@_cFiltraSZM) }
Eval(_bFiltraBrw)

MBrowse(06,1,22,75,"SZM",,,,,,_aCores)

EndFilBrw("SZM",_aIndexSZM)
Return(Nil)


//////////////////////////////////////////////////////////////////////////////////
// **************************************************************************** //
//////////////////////////////////////////////////////////////////////////////////
User Function UFA110RJ()
Private _aArea  	:= GetArea()
Private _cUsuario   := RetCodUsr()
Private _cNomeUsr   := UsrRetName(_cUsuario)

If SZM->ZM_APROV == "R"
    Alert("Solicitacao de Compra Ja Rejeitada anteriormente...")
    Return
EndIf

RecLock("SZM",.F.)
SZM->ZM_APROV   	:= "R"
MsUnlock()
Alert("Solicitacao de Compras Rejeitada pelo usuario "+_cUsuario+" - "+_cNomeUsr)

cCCusto	:= GETADVFVAL("SAK","AK_CC",XFILIAL("SAK")+SZM->ZM_USRAPRO,2,SPACE(09)) //SZM->ZM_CC
cCCDesc	:= GETADVFVAL("CTT","CTT_DESC01",XFILIAL("CTT")+cCCusto,1,SPACE(40))  //SZM->ZM_DESCCC

dbSelectArea("SZI")
dbSetOrder(1)
RecLock("SZI",.T.)
SZI->ZI_FILIAL  	:= xFilial("SZI")
SZI->ZI_ROTINA  	:= "SC1"
SZI->ZI_DOC     	:= SZM->ZM_NUM
SZI->ZI_STATUS  	:= "R"
SZI->ZI_USER    	:= _cUsuario
SZI->ZI_NOMEUSR 	:= _cNomeUsr
SZI->ZI_CC      	:= cCCusto //SZM->ZM_CC
SZI->ZI_DESCCC  	:= cCCDesc //SZM->ZM_DESCCC
SZI->ZI_DATA    	:= DDATABASE
SZI->ZI_HORA    	:= TIME()
MsUnLock()

Env_RJ_Email()

RestArea(_aArea)
Return

//////////////////////////////////////////////////////////////////////////////////
// **************************************************************************** //
//////////////////////////////////////////////////////////////////////////////////
Static Function Env_RJ_Email()
/*
Local   _cMensagem := "O usuário     : "+_cNomeUsr+" rejeitou a solicitacao de compra  " + SZM->ZM_NUM +"." ;
+ CHR(10)+CHR(13) + CHR(10)+CHR(13) + CHR(10)+"Valor Total: "+ Transform(SZM->ZM_VALORT ,"@E 999,999,999.99" );
+ CHR(10)+CHR(13) + CHR(10)+CHR(13) + CHR(10)+"Data          : "+ Dtoc(dDataBase)+;
" Horario "+Time()+"." + CHR(13) + CHR(10)+"____________________________________________________________________________________" + ;
CHR(13) + CHR(10)+CHR(13) + CHR(10)+"Por favor não responda esse e-mail. Mensagem enviada automaticamente"
Local   _aFiles    := {}
Private _cRecebe   := 'cnpuerta@globo.com;soliveira@ncgames.com.br;ebuttner@ncgames.com.br;' + _cMailUser ///  + _cMailSoli
Private _cCC       := ' '
Private _cBCC      := 'thiago@stch.com.br'
Private _cAssunto  := "Solicitacao de Compra : "+ SZM->ZM_NUM +" rejeitada."

U_ENVIAEMAIL(_cRecebe,_cCC,_cBCC,_cAssunto,_cMensagem,_aFiles)
*/
Private _cRecebe   := 'cnpuerta@globo.com;soliveira@ncgames.com.br;ebuttner@ncgames.com.br;' 

Alert("Workflow enviado para rejeicao da Solicitação de Compras")
U_COMWF01a()

Return

//////////////////////////////////////////////////////////////////////////////////
// **************************************************************************** //
//////////////////////////////////////////////////////////////////////////////////
User Function UFA110AP()                        // UFA110AP(cNumSc)
Private _aArea     	:= GetArea()
Private _cNumSC    	:= SZM->ZM_NUM              // ""
Private _nVlrMin   	:= SUPERGETMV("MV_NCVLRSC")
Private _cUserLib  	:= SZM->ZM_USRAPRO          // ""
Private _cAprovad  	:= ""
Private _cNomeLib  	:= ""
Private _cMailLib  	:= ""
Private _lBloq     	:= .F.
Private _cUsuario   := RetCodUsr()
Private _cNomeUsr   := UsrRetName(_cUsuario)

/*/
CONOUT("INICIO DA FUNCAO DE APROVACAO")

IF EMPTY(ALLTRIM(cNumSC)) == .F.
	CONOUT("Atualiza a variavel _cNumSC com o valor do WORKFLOW")
	_cNumSC 		:= cNumSC
ENDIF
     
IF EMPTY(ALLTRIM(cNumSC)) == .T.
	CONOUT("Atualiza a variavel _cNumSC com o valor do BROWSE de liberacao da SC")
	_cNumSC 		:= SZM->ZM_NUM
	_cUserLib		:= SZM->ZM_USRAPRO
ENDIF

dbSelectArea("SC1")
dbSetOrder(1)
dbSeek(xFilial("SC1")+_cNumSC)

dbSelectArea("SZM")
dbSetOrder(1)
dbSeek(xFilial("SZM")+_cNumSC)

IF EMPTY(ALLTRIM(_cUserLib)) == .T.
	//_cNumSC 		:= SZM->ZM_NUM
	_cUserLib		:= SZM->ZM_USRAPRO
ENDIF

CONOUT("REALIZADO BUSCA NA SC1 E SZM COM O FILTRO : " +_cNumSC)
/*/

If SZM->ZM_APROV == "L" .Or. SZM->ZM_APROV == " "
    Alert("Solicitacao de Compra Ja Aprovada anteriormente...")
    Return
EndIf

Alert("Solicitacao de Compras Liberada pelo usuario "+_cUsuario+" - "+_cNomeUsr)

cCCusto	:= GETADVFVAL("SAK","AK_CC",XFILIAL("SAK")+SZM->ZM_USRAPRO,2,SPACE(09)) //SZM->ZM_CC
cCCDesc	:= GETADVFVAL("CTT","CTT_DESC01",XFILIAL("CTT")+cCCusto,1,SPACE(40))  //SZM->ZM_DESCCC

dbSelectArea("SZI")
dbSetOrder(1)
RecLock("SZI",.T.)
SZI->ZI_FILIAL  := xFilial("SZI")
SZI->ZI_ROTINA  := "SC1"
SZI->ZI_DOC     := SZM->ZM_NUM
SZI->ZI_STATUS  := "A"
SZI->ZI_USER    := _cUsuario
SZI->ZI_NOMEUSR := _cNomeUsr
SZI->ZI_CC      := cCCusto //SZM->ZM_CC
SZI->ZI_DESCCC  := cCCDesc //SZM->ZM_DESCCC
SZI->ZI_DATA    := DDATABASE
SZI->ZI_HORA    := TIME()
MsUnLock()

dbSelectArea("SAK")
dbSetOrder(2)                // AK_FILIAL+AK_USER
If dbSeek(xFilial("SAK")+_cUserLib)
    If SZM->ZM_VALORT >= SAK->AK_LIMMIN .And. SZM->ZM_VALORT <= SAK->AK_LIMMAX
        _cUserLib := Space(06)
    Else
        _cUserLib := GETADVFVAL("SAK","AK_USER",XFILIAL("SAK")+SAK->AK_APROSUP,1,SPACE(06))
    EndIf
EndIf

If !Empty(_cUserLib) .And. _cUserLib != SZM->ZM_USRAPRO
    _cNomeLib := UsrRetName(_cUserLib)
    _cMailLib := AllTrim(UsrRetMail(_cUserLib))
/*/
    dbGoTop()
    Do While !Eof()
        If SZM->ZM_VALORT >= SAK->AK_LIMMIN .And. SZM->ZM_VALORT <= SAK->AK_LIMMAX
            If SAK->AK_USER == _cUserLib
                _cNomeLib := UsrRetName(_cUserLib)
                _cMailLib := AllTrim(UsrRetMail(_cUserLib))
                Exit
            EndIf
        EndIf
        dbSkip()
    EndDo
/*/
    dbSelectArea("SC1")
    dbSetOrder(1)          // C1_FILIAL+C1_NUM+C1_ITEM
    dbSeek(xFilial("SC1")+_cNumSC,.T.)
    Do While !Eof() .And. SC1->C1_NUM == _cNumSC
        RecLock("SC1",.F.)
        SC1->C1_APROV   := "B"
        SC1->C1_USRAPRO := _cUserLib
        SC1->C1_NOMEAPR := _cNomeLib
        MsUnlock()
        _cNome          := SC1->C1_USER+" - "+UsrRetName(SC1->C1_USER)
        _cNomFor        := POSICIONE("SA2",1,XFILIAL("SA2")+SC1->C1_FORNECE+SC1->C1_LOJA,"A2_NOME")
        _lBloq          := .T.
        dbSkip()
    EndDo
    
    RestArea(_aArea)
    RecLock("SZM",.F.)
    SZM->ZM_APROV   := "B"
    SZM->ZM_USRAPRO := _cUserLib
    SZM->ZM_NOMEAPR := _cNomeLib
    MsUnlock()
Else
    dbSelectArea("SC1")
    dbSetOrder(1)          // C1_FILIAL+C1_NUM+C1_ITEM
    dbSeek(xFilial("SC1")+_cNumSC,.T.)
    Do While !Eof() .And. SC1->C1_NUM == _cNumSC
        RecLock("SC1",.F.)
        SC1->C1_APROV   := "L"
        MsUnlock()
        dbSkip()
    EndDo

    RestArea(_aArea)    
    RecLock("SZM",.F.)
    SZM->ZM_APROV := "L"
    MsUnlock()
EndIf

If _lBloq
    Env_B_EMail()
EndIf

RestArea(_aArea)
Return

//////////////////////////////////////////////////////////////////////////////////
// **************************************************************************** //
//////////////////////////////////////////////////////////////////////////////////
Static Function Env_B_Email()
/*
// REMOVIDO PARA ATUALIZAR COM O EMAIL DO WORKFLOW
Local   _cMensagem := "O usuário     : "+_cNomeUsr+" incluiu a solicitacao de compra  " + SZM->ZM_NUM +" que necessitara de sua Aprovacao." ;
+ CHR(10)+CHR(13) + CHR(10)+CHR(13) + CHR(10)+"Valor Total: "+ Transform(SZM->ZM_VALORT,  "@E 999,999,999.99" );
+ CHR(10)+CHR(13) + CHR(10)+CHR(13) + CHR(10)+"Data          : "+ Dtoc(dDataBase)+;
" Horario "+Time()+"." + CHR(13) + CHR(10)+"____________________________________________________________________________________" + ;
CHR(13)+CHR(10) +CHR(13)+CHR(10) +"Por favor não responda esse e-mail. Mensagem enviada automaticamente"
Local   _aFiles     := {}
Private _cRecebe   := 'cnpuerta@globo.com;soliveira@ncgames.com.br;ebuttner@ncgames.com.br;' + _cMailLib
Private _cCC       := ' '
Private _cBCC      := ' '
Private _cAssunto  := "Solicitacao de Compra : "+ SZM->ZM_NUM +" necessita de Aprovacao."

U_ENVIAEMAIL(_cRecebe,_cCC,_cBCC,_cAssunto,_cMensagem,_aFiles)
*/
Private _cRecebe   := 'cnpuerta@globo.com;soliveira@ncgames.com.br;ebuttner@ncgames.com.br;' 

//U_COMWF001(_cRecebe,_cMailLib)
Alert("Workflow enviado para aprovação da Solicitação de Compras")
U_COMRD003(_cRecebe,"" /*_cMailLib*/)


Return

//////////////////////////////////////////////////////////////////////////////////
// **************************************************************************** //
//////////////////////////////////////////////////////////////////////////////////
User Function LEGAPROV()
Local _aLegenda  := {}
Private _cTitulo := "Solicitacoes de Compras"
AADD(_aLegenda,{"DISABLE"   ,"Solicitacao de Compras Liberada" })
AADD(_aLegenda,{"BR_CINZA"  ,"Solicitacao de Compras Bloqueada" })
AADD(_aLegenda,{"BR_LARANJA","Solicitacao de Compras Rejeitada" })

BrwLegenda(_cTitulo,"Legenda", _aLegenda)
Return

//////////////////////////////////////////////////////////////////////////////////
// **************************************************************************** //
//////////////////////////////////////////////////////////////////////////////////
User Function VIS01SZMN()
Private _aUser  := PswRet(1)
Private _lRet   := .T.
Private _cOpcao := "VISUALIZAR"
Private _nOpcE  := 2
Private _nOpcG  := 2

Do Case
	Case _cOpcao == "INCLUIR"    ; _nOpcE := 3 ; _nOpcG := 3
	Case _cOpcao == "ALTERAR"    ; _nOpcE := 3 ; _nOpcG := 3
	Case _cOpcao == "VISUALIZAR" ; _nOpcE := 2 ; _nOpcG := 2
EndCase

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria variaveis M->????? da Enchoice                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
RegToMemory("SZM",(_cOpcao == "INCLUIR"))

Private _cCodigo  := M->ZM_NUM
Private _nI       := 0
Private nUsado    := 0
Private aHeader   := {}
Private aCols     := {}

dbSelectArea("SX3")
dbSeek("SZN")
Do While !Eof().And.(x3_arquivo=="SZN")
    If Upper(AllTrim(X3_CAMPO)) == "ZN_NUM"
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

aCols:={}
dbSelectArea("SZN")
dbSetOrder(1)            // ZN_FILIAL+ZN_NUM+ZN_ITEM
dbSeek(xFilial("SZN")+_cCodigo,.T.)
Do While !Eof() .And. SZN->ZN_NUM == _cCodigo
	AADD(aCols,Array(nUsado+1))
	For _nI:=1 to nUsado
		aCols[Len(aCols),_nI]:=FieldGet(FieldPos(aHeader[_nI,2]))
	Next
	aCols[Len(aCols),nUsado+1]:=.F.
	dbSkip()
EndDo
/*/
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis de posicionamento no aCols                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private _nPosItem      := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="ZN_ITEM"    })
Private _nPosNum       := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="ZN_NUM" })
Private _nPosProduto   := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="ZN_PRODUTO" })
Private _nPosDescri    := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="ZN_DESCRI"   })
Private _nPosUM        := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="ZN_UM"    })
Private _nPosQuant     := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="ZN_QUANT" })
Private _nPosNCVLUNI   := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="ZN_NCVLUNI" })
Private _nPosVLTOTAL   := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="ZN_VLTOTAL" })
Private _nPosSEGUM     := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="ZN_SEGUM" })
Private _nPosQTSEGUM   := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="ZN_QTSEGUM" })
Private _nPosDATPRF    := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="ZN_DATPRF" })
Private _nPosOBS       := aScan(aHeader,{|x| AllTrim(Upper(x[2]))=="ZN_OBS" })

Private _nIPosDel      := Len(aHeader) + 1
/*/
Private cTitulo        := "Solicitacao de Compra - Visualizar"
Private cAliasEnchoice := "SZM"
Private cAliasGetD     := "SZN"
Private cLinOk         := "AllwaysTrue()"      // 'ExecBlock("ESTVLD",.F.,.F.)'
Private cTudOk         := "AllwaysTrue()"
Private cFieldOk       := "AllwaysTrue()"
Private aCpoEnchoice   := {SZM->ZM_NUM}
Private aCordW         := {001,005,700,1250}
Private nSizeHeader    := 200

Private nFreeze        := 2
Private aBotao         := {}

_lRet:=Modelo3(cTitulo,cAliasEnchoice,cAliasGetD,,cLinOk,cTudOk,_nOpcE,_nOpcG,cFieldOk,  , ,  ,  ,aBotao,aCordW,nSizeHeader)
Return

////////////////////////////////////////////////////////////////////////////////////
// ****************************************************************************** //
////////////////////////////////////////////////////////////////////////////////////
User Function AX1SZISC1()
Local   _aIndexSZI := {}
Local   _cCondicao := 'ZI_ROTINA == "SC1" .And. ZI_DOC == SZM->ZM_NUM'
Private _cNumPC    := SZM->ZM_NUM
Private _aArea     := GetArea()
Private aRotina
Private cCadastro

dbSelectArea("SZI")
dbSetOrder(1)
dbGotop()
_bFiltraBrw := {|| FilBrowse("SZI",@_aIndexSZI,@_cCondicao) }
Eval(_bFiltraBrw)

U_AX1CADSZI()

EndFilBrw("SZI",_aIndexSZI)

dbSelectArea("SC7")
RestArea(_aArea)
Return

////////////////////////////////////////////////////////////////////////////////////
// ****************************************************************************** //
////////////////////////////////////////////////////////////////////////////////////
User Function AX1CADSZI(_cNumPC)
dbSelectArea("SZI")
dbSetOrder(1)
AxCadastro("SZI","APROVACOES E REJEICOES - SCs",".F.",".F.")
Return
//
//  Nova tela de Consulta ao CADASTRO DE APROVACOES E REJEICOES - SZI
//
User Function CONSC1ZI()
Local oDlg         := Nil
Local oLbx         := Nil
Local oOk          := LoadBitmap( GetResources(), "BR_VERDE" )
Local oNo          := LoadBitmap( GetResources(), "BR_VERMELHO" )
Local _lTru        := .T.
Private _aArea     := {}
Private _aVetor    := {}
Private _cZITitulo := "Aprovacoes / Rejeicoes"
Private _cSolicit  := SZM->ZM_NUM

dbSelectArea("SZI")
_aArea := GetArea()
dbSetOrder(1)
dbSeek(xFilial("SZI")+"SC1"+_cSolicit,.T.)
Do While !Eof() .And. ZI_ROTINA+ZI_DOC == "SC1"+_cSolicit
    If SZI->ZI_STATUS == "R"
        _lTru := .F.
    Else
        _lTru := .T.
    EndIf
    AAdd( _aVetor, { _lTru, "SC", ZI_DOC, ZI_USER, ZI_NOMEUSR, ZI_CC, ZI_DESCCC, Dtoc(ZI_DATA), ZI_HORA, ZI_STATUS } )
    dbSkip()
EndDo

If Len( _aVetor ) == 0
   Aviso( _cZITitulo, "Fim da Consulta", {"Ok"} )
   Return
EndIf

//+-----------------------------------------------+
//| Monta a tela para usuario visualizar consulta |
//+-----------------------------------------------+
DEFINE MSDIALOG oDlg TITLE _cZITitulo FROM 0,0 TO 360,1200 PIXEL
@ 10,10 LISTBOX oLbx FIELDS HEADER ;
   " ", "SC/PC", "Documento", "Usuario", "Nome Usuario", "Centro de Custo", "Descricao", "Data", "Hora", "Status" ;
   SIZE 580,150 OF oDlg PIXEL

oLbx:SetArray( _aVetor )
oLbx:bLine := {|| {IIF(_aVetor[oLbx:nAt,1],oOk,oNo),;
                                    _aVetor[oLbx:nAt,2],;
                                    _aVetor[oLbx:nAt,3],;
                                    _aVetor[oLbx:nAt,4],;
                                    _aVetor[oLbx:nAt,5],;
                                    _aVetor[oLbx:nAt,6],;
                                    _aVetor[oLbx:nAt,7],;
                                    _aVetor[oLbx:nAt,8],;
                                    _aVetor[oLbx:nAt,9],;
                                    _aVetor[oLbx:nAt,10]}}

DEFINE SBUTTON FROM 165,550 TYPE 1 ACTION oDlg:End() ENABLE OF oDlg
ACTIVATE MSDIALOG oDlg CENTER
RestArea( _aArea )
Return