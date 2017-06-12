#INCLUDE "rwmake.ch"
#INCLUDE "tbiconn.ch"
#INCLUDE "PROTHEUS.CH"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ UFC7APROV ³ Autor ³ Carlos N. Puerta       ³ Data ³ Set/2012 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Programa para Aprovar/Rejeitar PVs Atraves dos arquivos      ³±±
±±³          ³ SZO e SZP                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Especifico NCGames                                           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function UFC7APROV()
SetPrvt("aRotina,cCadastro")
Private _cUsuario   := RetCodUsr()
Private _cNomeUsr   := UsrRetName(_cUsuario)
Private _cMailUser  := AllTrim(UsrRetMail(_cUsuario))
Private _cFiltraSZO := 'ZO_USRAPRO==_cUsuario'     //  .And. (ZO_APROV="B" .Or. ZO_APROV="R")'
Private _aIndexSZO  := {}

SetKey( VK_F8, { || U_CONSC7ZI() } )

Private _aCores	    := {;
	{'ZO_APROV$" ,L"' 	              ,'DISABLE' },;	//Pedido em Aberto
	{'ZO_APROV="B"'	                  ,'BR_CINZA'},;	//Pedido Bloqueado
	{'ZO_APROV="R"'	                  ,'BR_LARANJA'}}	//Pedido Rejeitado

aRotina   := { { "Pesquisar"  	,"AxPesqui"		, 0 , 1 , 0,.F.},;
		       { "Visualizar" 	,"U_VIS01SZOP"	, 0 , 1 , 0, nil},;
		       { "Rejeitar" 	,"U_UFA120RJ"	, 0 , 2 , 0, nil},;
		       { "Aprovar" 		,"U_UFA120AP"	, 0 , 4 , 0, nil},;
		       { "Legenda"      ,"U_LEGC7APROV" , 0 , 7 , 0, nil}}

cCadastro := "Rotina de Liberacao de PVs"

_bFiltraBrw := {|| FilBrowse("SZO",@_aIndexSZO,@_cFiltraSZO) }
Eval(_bFiltraBrw)

MBrowse(06,1,22,75,"SZO",,,,,,_aCores)

EndFilBrw("SZO",_aIndexSZO)
Return(Nil)

////////////////////////////////////////////////////////////////////////////////////
// PROCESSO DE REJEICAO DO PEDIDO DE COMPRAS ************************************ //
////////////////////////////////////////////////////////////////////////////////////
User Function UFA120RJ()
Private _aArea  := GetArea()

If SZO->ZO_APROV == "R"
    Alert("Pedido de Compras Ja Rejeitado anteriormente...")
    Return
EndIf

RecLock("SZO",.F.)
SZO->ZO_APROV   := "R"
MsUnlock()
Alert("Pedido de Compras Rejeitado pelo usuario "+_cUsuario+" - "+_cNomeUsr)

cCCusto	:= GETADVFVAL("SAK","AK_CC",XFILIAL("SAK")+SZO->ZO_USRAPRO,2,SPACE(09)) //SZM->ZO_CC
cCCDesc	:= GETADVFVAL("CTT","CTT_DESC01",XFILIAL("CTT")+cCCusto,1,SPACE(40))  //SZM->ZM_DESCCC

dbSelectArea("SZI")
dbSetOrder(1)
RecLock("SZI",.T.)
SZI->ZI_FILIAL  := xFilial("SZI")
SZI->ZI_ROTINA  := "SC7"
SZI->ZI_DOC     := SZO->ZO_NUM
SZI->ZI_STATUS  := "R"
SZI->ZI_USER    := _cUsuario
SZI->ZI_NOMEUSR := _cNomeUsr
SZI->ZI_CC      := cCCusto //SZO->ZO_CC
SZI->ZI_DESCCC  := cCCDesc //SZO->ZO_DESCCC
SZI->ZI_DATA    := DDATABASE
SZI->ZI_HORA    := TIME()
MsUnLock()

EmailRJPV()

RestArea(_aArea)
Return

////////////////////////////////////////////////////////////////////////////////////
// MANDA EMAIL DE REJEICAO DO PEDIDO DE COMPRAS ********************************* //
////////////////////////////////////////////////////////////////////////////////////
Static Function EmailRJPV()
/*
Local   _cMensagem := "O usuário     : "+_cNomeUsr+" rejeitou o pedido de compra  " + SZO->ZO_NUM +"." ;
+ CHR(10)+CHR(13) + CHR(10)+CHR(13) + CHR(10)+"Valor Total: "+ Transform(SZO->ZO_VALORT ,"@E 999,999,999.99" );
+ CHR(10)+CHR(13) + CHR(10)+CHR(13) + CHR(10)+"Data          : "+ Dtoc(dDataBase)+;
" Horario "+Time()+"." + CHR(13) + CHR(10)+"____________________________________________________________________________________" + ;
CHR(13) + CHR(10)+CHR(13) + CHR(10)+"Por favor não responda esse e-mail. Mensagem enviada automaticamente"
Local   _aFiles     := {}
Private _cRecebe   := 'cnpuerta@globo.com;soliveira@ncgames.com.br;ebuttner@ncgames.com.br;' + _cMailUser ///  + _cMailSoli
Private _cCC       := ' '
Private _cBCC      := 'thiago@stch.com.br'
Private _cAssunto  := "Solicitacao de Compra : "+ SZO->ZO_NUM +" rejeitada."

U_ENVIAEMAIL(_cRecebe,_cCC,_cBCC,_cAssunto,_cMensagem,_aFiles)
*/

Public _cRecebe   := 'cnpuerta@globo.com;soliveira@ncgames.com.br;ebuttner@ncgames.com.br;'
alert("Workflow enviado para rejeicao de Pedido de Compra")
//U_SPCIniciar(_cRecebe,"")
U_SPCRetorno()

Return

////////////////////////////////////////////////////////////////////////////////////
// PROCESSO DE APROVACAO DO PEDIDO DE COMPRAS *********************************** //
////////////////////////////////////////////////////////////////////////////////////
User Function UFA120AP()
Private _aArea     := GetArea()
Private _cPedido   := SZO->ZO_NUM
Private _nVlrMin   := SUPERGETMV("MV_NCVLRSC")
Private _cUserLib  := SZO->ZO_USRAPRO
Private _cAprovad  := ""
Private _cNomeLib  := ""
Private _cMailLib  := ""
Private _lBloq     := .F.
Private _nValMax   := 0.00

If SZO->ZO_APROV == "L" .Or. SZO->ZO_APROV == " "
    Alert("Pedido de Compras Ja Liberado anteriormente...")
    Return
EndIf

Alert("Pedido de Compras Liberado pelo usuario "+_cUsuario+" - "+_cNomeUsr)

cCCusto	:= GETADVFVAL("SAK","AK_CC",XFILIAL("SAK")+SZO->ZO_USRAPRO,2,SPACE(09)) //SZM->ZM_CC
cCCDesc	:= GETADVFVAL("CTT","CTT_DESC01",XFILIAL("CTT")+cCCusto,1,SPACE(40))  //SZM->ZM_DESCCC

dbSelectArea("SZI")
dbSetOrder(1)
RecLock("SZI",.T.)
SZI->ZI_FILIAL  := xFilial("SZI")
SZI->ZI_ROTINA  := "SC7"
SZI->ZI_DOC     := SZO->ZO_NUM
SZI->ZI_STATUS  := "A"
SZI->ZI_USER    := _cUsuario
SZI->ZI_NOMEUSR := _cNomeUsr
SZI->ZI_CC      := cCCusto //SZO->ZO_CC
SZI->ZI_DESCCC  := cCCDesc //SZO->ZO_DESCCC
SZI->ZI_DATA    := DDATABASE
SZI->ZI_HORA    := TIME()
MsUnLock()

dbSelectArea("SAK")
_aAreaAK := GetArea()
dbSetOrder(2)                // AK_FILIAL+AK_USER
If dbSeek(xFilial("SAK")+_cUserLib)
    _cSeqLibPC := Soma1(SAK->AK_SEQLIBP,6)
    _nValMax   := SAK->AK_LIMMAX
    dbGoTop()
    Do While !Eof()     
	    If AllTrim(SAK->AK_SEQLIBP) == AllTrim(_cSeqLibPC)
	        If SZO->ZO_VALORT > _nValMax
		        _cUserLib := SAK->AK_USER
                _cNomeLib := UsrRetName(_cUserLib)
     	        _cMailLib := AllTrim(UsrRetMail(_cUserLib))
		        Exit
		    Else
		        _cUserLib := Space(06)
	        EndIf
	    EndIf
	    dbSkip()
	EndDo
EndIf
RestArea(_aAreaAK)

If !Empty(_cUserLib) .And. _cUserLib != SZO->ZO_USRAPRO
    _cNomeLib := UsrRetName(_cUserLib)
    _cMailLib := AllTrim(UsrRetMail(_cUserLib))

    dbSelectArea("SC7")
    dbSetOrder(1)          // C1_FILIAL+C1_NUM+C1_ITEM
    dbSeek(xFilial("SC7")+_cPedido,.T.)
    Do While !Eof() .And. SC7->C7_NUM == _cPedido
        RecLock("SC7",.F.)
        SC7->C7_STATUS  := "B"
        SC7->C7_USRAPRO := _cUserLib
        SC7->C7_NOMEAPR := _cNomeLib
        MsUnlock()
        _cNomFor        := POSICIONE("SA2",1,XFILIAL("SA2")+SC1->C1_FORNECE+SC1->C1_LOJA,"A2_NOME")
        _lBloq          := .T.
        dbSkip()
    EndDo
    
    RestArea(_aArea)
    RecLock("SZO",.F.)
    SZO->ZO_APROV   := "B"
    SZO->ZO_USRAPRO := _cUserLib
    SZO->ZO_NOMEAPR := _cNomeLib
    MsUnlock()
Else
    dbSelectArea("SC7")
    dbSetOrder(1)          // C1_FILIAL+C1_NUM+C1_ITEM
    dbSeek(xFilial("SC7")+_cPedido,.T.)
    Do While !Eof() .And. SC7->C7_NUM == _cPedido
        RecLock("SC7",.F.)
        SC7->C7_STATUS := "L"
        MsUnlock()
        dbSkip()
    EndDo

    RestArea(_aArea)
    RecLock("SZO",.F.)
    SZO->ZO_APROV := "L"
    MsUnlock()
EndIf

If _lBloq
    INCPV_EMail()
EndIf

RestArea(_aArea)
Return

////////////////////////////////////////////////////////////////////////////////////
// ENVIA EMAIL DE INCLUSAO DE PEDIDO DE COMPRAS - WORKFLOW ********************** //
////////////////////////////////////////////////////////////////////////////////////
Static Function INCPV_Email()
/*
Local   _cMensagem := "O usuário     : "+_cNomeUsr+" incluiu o pedido de compra  " + SZO->ZO_NUM +" que necessitara de sua Aprovacao." ;
+ CHR(10)+CHR(13) + CHR(10)+CHR(13) + CHR(10)+"Valor Total: "+ Transform(SZO->ZO_VALORT ,"@E 999,999,999.99" );
+ CHR(10)+CHR(13) + CHR(10)+CHR(13) + CHR(10)+"Data          : "+ Dtoc(dDataBase)+;
" Horario "+Time()+"." + CHR(13) + CHR(10)+"____________________________________________________________________________________" + ;
CHR(13)+CHR(10) +CHR(13)+CHR(10) +"Por favor não responda esse e-mail. Mensagem enviada automaticamente"
Local   _aFiles     := {}
Private _cRecebe   := 'cnpuerta@globo.com;soliveira@ncgames.com.br;ebuttner@ncgames.com.br;' + _cMailLib
Private _cCC       := ' '
Private _cBCC      := ' '
Private _cAssunto  := "Pedido de Compra : "+ SZO->ZO_NUM +" necessita de Aprovacao."

U_ENVIAEMAIL(_cRecebe,_cCC,_cBCC,_cAssunto,_cMensagem,_aFiles)
*/
Public _cRecebe   := 'cnpuerta@globo.com;soliveira@ncgames.com.br;ebuttner@ncgames.com.br;'
alert("Workflow enviado para aprovação de Pedido de Compra")
U_SPCIniciar(_cRecebe,"")


Return

////////////////////////////////////////////////////////////////////////////////////
// ****************************************************************************** //
////////////////////////////////////////////////////////////////////////////////////
User Function VIS01SZOP()
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
RegToMemory("SZO",(_cOpcao == "INCLUIR"))

Private _cCodigo  := M->ZO_NUM
Private _nI       := 0
Private nUsado    := 0
Private aHeader   := {}
Private aCols     := {}

dbSelectArea("SX3")
dbSeek("SZP")
Do While !Eof().And.(x3_arquivo=="SZP")
    If Upper(AllTrim(X3_CAMPO)) == "ZP_NUM"
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
dbSelectArea("SZP")
dbSetOrder(1)            // ZN_FILIAL+ZN_NUM+ZN_ITEM
dbSeek(xFilial("SZP")+_cCodigo,.T.)
Do While !Eof() .And. SZP->ZP_NUM == _cCodigo
	AADD(aCols,Array(nUsado+1))
	For _nI:=1 to nUsado
		aCols[Len(aCols),_nI]:=FieldGet(FieldPos(aHeader[_nI,2]))
	Next
	aCols[Len(aCols),nUsado+1]:=.F.
	dbSkip()
EndDo
Private _cTitulo       := "Pedido de Compra - Visualizar"
Private cAliasEnchoice := "SZO"
Private cAliasGetD     := "SZP"
Private cLinOk         := "AllwaysTrue()"      // 'ExecBlock("ESTVLD",.F.,.F.)'
Private cTudOk         := "AllwaysTrue()"
Private cFieldOk       := "AllwaysTrue()"
Private aCpoEnchoice   := {SZO->ZO_NUM}
Private aCordW         := {001,005,700,1250}
Private nSizeHeader    := 200

Private nFreeze        := 2
Private aBotao         := {}

_lRet:=Modelo3(_cTitulo,cAliasEnchoice,cAliasGetD,,cLinOk,cTudOk,_nOpcE,_nOpcG,cFieldOk,  , ,  ,  ,aBotao,aCordW,nSizeHeader)
Return

////////////////////////////////////////////////////////////////////////////////////
// ****************************************************************************** //
////////////////////////////////////////////////////////////////////////////////////
User Function AX2SZISC7()
Local   _aIndexSZI := {}
Local   _cCondicao := 'ZI_ROTINA == "SC7" .And. ZI_DOC == SZO->ZO_NUM'     // .Or. (ZI_ROTINA == "SC1" .And. ZI_DOC $ _cSCs)'
Private _cNumPC    := SZO->ZO_NUM
Private _aArea     := GetArea()
Private aRotina
Private cCadastro

dbSelectArea("SZI")
dbSetOrder(1)
dbGotop()
_bFiltraBrw := {|| FilBrowse("SZI",@_aIndexSZI,@_cCondicao) }
Eval(_bFiltraBrw)

U_AX2CADSZI()

EndFilBrw("SZI",_aIndexSZI)

dbSelectArea("SC7")
RestArea(_aArea)
Return

////////////////////////////////////////////////////////////////////////////////////
// ****************************************************************************** //
////////////////////////////////////////////////////////////////////////////////////
User Function AX2CADSZI(_cNumPC)
dbSelectArea("SZI")
dbSetOrder(1)
AxCadastro("SZI","APROVACOES E REJEICOES - PCs",".F.",".F.")
Return
//
//  Nova tela de Consulta ao CADASTRO DE APROVACOES E REJEICOES - SZI
//
User Function CONSC7ZI()
Local oDlg         := Nil
Local oLbx         := Nil
Local oOk          := LoadBitmap( GetResources(), "BR_VERDE" )
Local oNo          := LoadBitmap( GetResources(), "BR_VERMELHO" )
Local _lTru        := .T.
Private _aArea     := {}
Private _aVetor    := {}
Private _cZITitulo := "Aprovacoes / Rejeicoes"
Private _cPedido   := SZO->ZO_NUM
Private _cSolicit  := Space(06)

dbSelectArea("SZP")
dbSetOrder(1)
dbSeek(xFilial("SZP")+_cPedido,.T.)
Do While !Eof() .And. _cPedido == SZP->ZP_NUM
    If !Empty(SZP->ZP_NUMSC)
        _cSolicit := SZP->ZP_NUMSC
        Exit
    EndIf
    dbSkip()
EndDo

dbSelectArea("SZI")
_aArea := GetArea()
dbSetOrder(1)
If !Empty(_cSolicit)
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
EndIf
dbSeek(xFilial("SZI")+"SC7"+_cPedido,.T.)
Do While !Eof() .And. ZI_ROTINA+ZI_DOC == "SC7"+_cPedido
    If SZI->ZI_STATUS == "R"
        _lTru := .F.
    Else
        _lTru := .T.
    EndIf
    AAdd( _aVetor, { _lTru, "PC", ZI_DOC, ZI_USER, ZI_NOMEUSR, ZI_CC, ZI_DESCCC, Dtoc(ZI_DATA), ZI_HORA, ZI_STATUS } )
    dbSkip()
EndDo

If Len( _aVetor ) == 0
   Aviso( _cZITitulo, "Fim da Consulta", {"Ok"} )
   Return
EndIf

//+-----------------------------------------------+
//| Monta a tela para usuario visualizar consulta |
//+-----------------------------------------------+
//DEFINE MSDIALOG oDlg TITLE _cZITitulo FROM 0,0 TO 240,500 PIXEL
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

User Function LEGC7APROV()
Local _aLegenda  := {}
Private _cTitulo := "Pedidos de Compras"
AADD(_aLegenda,{"DISABLE"   ,"Pedido de Compras Liberada" })
AADD(_aLegenda,{"BR_CINZA"  ,"Pedido de Compras Bloqueada" })
AADD(_aLegenda,{"BR_LARANJA","Pedido de Compras Rejeitada" })

BrwLegenda(_cTitulo,"Legenda", _aLegenda)
Return