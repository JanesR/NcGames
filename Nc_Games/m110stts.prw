#INCLUDE "rwmake.ch"
#INCLUDE "tbiconn.ch"
/*/
//ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
//±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
//±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
//±±ºPrograma  ³ M110STTS º Autor ³ CARLOS N. PUERTA   º Data ³ JULHO/2012  º±±
//±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
//±±ºDescricao ³ PONTO DE ENTRADA APOS GRAVAR A SC.                         º±±
//±±º          ³                                                            º±±
//±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
//±±ºUso       ³ AP11 NC GAMES                                              º±±
//±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
//±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
//ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function M110STTS()
Private _aArea     := GetArea()
Private _aAreaC1   := {}
Private _aArea1    := {}
Private _cNumSC    := PARAMIXB[1]
Private _nOpc      := PARAMIXB[2]
//Private _lCopia    := PARAMIXB[3]    // SE FOR COPIA (.T.), CASO CONTRARIO (.F.)
Private _cUserLib  := Space(06)
Private _cNomeLib  := ""
Private _cMailLib  := ""
Private _lBloq     := .F.
Private _nVlrMin   := SUPERGETMV("MV_NCVLRSC")
Private _nVlrTotSC := 0.00
Private _nQtdTotSC := 0.00
Private _cImport   := Space(01)
Private _cTipo     := Space(02)

If _nOpc == 1 .Or. _nOpc == 2 // .Or. _lCopia
    _cImport := Space(01)
    _cTipo   := Space(02)
    dbSelectArea("SC1")
    _aAreaC1 := GetArea()
    dBSetOrder(1)          // C1_FILIAL+C1_NUM+C1_ITEM
    dbSeek(xFilial("SC1")+_cNumSC,.T.)
    Do While !Eof() .And. SC1->C1_NUM == _cNumSC
        If !Empty(SC1->C1_RESIDUO)
            dbSkip()
            Loop
        EndIf
        _cImport := GETADVFVAL("SB1","B1_IMPORT",XFILIAL("SB1")+SC1->C1_PRODUTO,1,SPACE(01))
        _cTipo   := GETADVFVAL("SB1","B1_TIPO",XFILIAL("SB1")+SC1->C1_PRODUTO,1,SPACE(02))
        If _cImport <> "S" .Or. _cTipo == "MC"
            _nVlrTotSC += (SC1->C1_QUANT - SC1->C1_QUJE) * SC1->C1_NCVLUNI
            _nQtdTotSC += (SC1->C1_QUANT - SC1->C1_QUJE)
        EndIf
        dbSkip()
    EndDo
    RestArea(_aAreaC1)

    If _nVlrTotSC > 0
    	conout("PROCURA O APROVADOR NA TABELA SAK COM A CHAVE : " + XFILIAL("SAI")+SC1->C1_USER )
        _cUserLib := GETADVFVAL("SAI","AI_NCSUPER",XFILIAL("SAI")+SC1->C1_USER,2,SPACE(06))
        _cNomeLib := UsrRetName(_cUserLib)
        _cMailLib := AllTrim(UsrRetMail(_cUserLib))
        CONOUT("ACHOU O APROVADOR : " + _cUserLib)
    EndIf

    _cImport := Space(01)
    _cTipo   := Space(02)
    dbSelectArea("SC1")
    _aAreaC1 := GetArea()
    dBSetOrder(1)          // C1_FILIAL+C1_NUM+C1_ITEM
    dbSeek(xFilial("SC1")+_cNumSC,.T.)
    Do While !Eof() .And. SC1->C1_NUM == _cNumSC
        _cImport := GETADVFVAL("SB1","B1_IMPORT",XFILIAL("SB1")+SC1->C1_PRODUTO,1,SPACE(01))
        _cTipo   := GETADVFVAL("SB1","B1_TIPO",XFILIAL("SB1")+SC1->C1_PRODUTO,1,SPACE(02))
        If _nVlrTotSC > _nVlrMin .And. (_cImport <> "S" .Or. _cTipo == "MC")
            RecLock("SC1",.F.)
            SC1->C1_APROV   := "B"
            SC1->C1_USRAPRO := _cUserLib
            SC1->C1_NOMEAPR := _cNomeLib
            MsUnlock()
            _cNome   := UsrRetName(SC1->C1_USER)
            _cNomFor := POSICIONE("SA2",1,XFILIAL("SA2")+SC1->C1_FORNECE+SC1->C1_LOJA,"A2_NOME")
            _lBloq   := .T.
            
            _aArea1 := GetArea()
            dbSelectArea("SZM")
            dbSetOrder(1)
            If dbSeek(xFilial("SZM")+SC1->C1_NUM)
                RecLock("SZM",.F.)
                SZM->ZM_APROV   := SC1->C1_APROV
                SZM->ZM_USRAPRO := SC1->C1_USRAPRO
                SZM->ZM_NOMEAPR := SC1->C1_NOMEAPR
                SZM->ZM_QUANTT  := _nQtdTotSC
                SZM->ZM_VALORT  := _nVlrTotSC
            Else
                RecLock("SZM",.T.)
                SZM->ZM_FILIAL  := SC1->C1_FILIAL
                SZM->ZM_NUM     := SC1->C1_NUM
                SZM->ZM_USRSOLI := RetCodUsr()
                SZM->ZM_SOLICIT := SC1->C1_SOLICIT          // UsrRetName(SZM->ZM_USRSOLI)
                SZM->ZM_CC      := GETADVFVAL("SAI","AI_CC",XFILIAL("SAI")+SZM->ZM_USRSOLI,2,SPACE(09))
                SZM->ZM_DESCCC  := GETADVFVAL("CTT","CTT_DESC01",XFILIAL("CTT")+SZM->ZM_CC,1,SPACE(40))
                SZM->ZM_EMISSAO := SC1->C1_EMISSAO
                SZM->ZM_UNIDREQ := SC1->C1_UNIDREQ
                SZM->ZM_CODCOMP := SC1->C1_CODCOMP
                SZM->ZM_FILENT  := SC1->C1_FILENT
                SZM->ZM_USRAPRO := SC1->C1_USRAPRO
                SZM->ZM_NOMEAPR := SC1->C1_NOMEAPR
                SZM->ZM_APROV   := SC1->C1_APROV
                SZM->ZM_QUANTT  := _nQtdTotSC
                SZM->ZM_VALORT  := _nVlrTotSC
            EndIf
            MsUnlock()

            dbSelectArea("SZN")
            dbSetOrder(1)
            If dbSeek(xFilial("SZN")+SC1->C1_NUM+SC1->C1_ITEM)
                RecLock("SZN",.F.)
                SZN->ZN_PRODUTO := SC1->C1_PRODUTO
                SZN->ZN_DESCRI  := SC1->C1_DESCRI
                SZN->ZN_UM      := SC1->C1_UM
                SZN->ZN_QUANT   := SC1->C1_QUANT
                SZN->ZN_NCVLUNI := SC1->C1_NCVLUNI
                SZN->ZN_VLTOTAL := Round(SC1->C1_QUANT * SC1->C1_NCVLUNI,2)
                SZN->ZN_SEGUM   := SC1->C1_SEGUM
                SZN->ZN_QTSEGUM := SC1->C1_QTSEGUM
                SZN->ZN_DATPRF  := SC1->C1_DATPRF 
                SZN->ZN_OBS     := SC1->C1_OBS
                SZN->ZN_PEDIDO  := SC1->C1_PEDIDO
                SZN->ZN_ITEMPED := SC1->C1_ITEMPED
                SZN->ZN_FORNECE := SC1->C1_FORNECE
                SZN->ZN_LOJA    := SC1->C1_LOJA
            Else
                RecLock("SZN",.T.)
                SZN->ZN_FILIAL  := SC1->C1_FILIAL
                SZN->ZN_NUM     := SC1->C1_NUM
                SZN->ZN_ITEM    := SC1->C1_ITEM
                SZN->ZN_PRODUTO := SC1->C1_PRODUTO
                SZN->ZN_DESCRI  := SC1->C1_DESCRI
                SZN->ZN_UM      := SC1->C1_UM
                SZN->ZN_QUANT   := SC1->C1_QUANT
                SZN->ZN_NCVLUNI := SC1->C1_NCVLUNI
                SZN->ZN_VLTOTAL := Round(SC1->C1_QUANT * SC1->C1_NCVLUNI,2)
                SZN->ZN_SEGUM   := SC1->C1_SEGUM
                SZN->ZN_QTSEGUM := SC1->C1_QTSEGUM
                SZN->ZN_DATPRF  := SC1->C1_DATPRF 
                SZN->ZN_OBS     := SC1->C1_OBS
                SZN->ZN_PEDIDO  := SC1->C1_PEDIDO
                SZN->ZN_ITEMPED := SC1->C1_ITEMPED
                SZN->ZN_FORNECE := SC1->C1_FORNECE
                SZN->ZN_LOJA    := SC1->C1_LOJA
            EndIf
            MsUnlock()
            RestArea(_aArea1)
        Else
	        IF _cImport <> "S" .Or. _cTipo == "MC"
	        	U_COMWF02d(SC1->C1_NUM)
	        ENDIF
	        
            RecLock("SC1",.F.)
			SC1->C1_APROV   := "L"
          	SC1->C1_USRAPRO := Space(06)
          	MsUnlock()

          	_aArea1 := GetArea()
            dbSelectArea("SZM")
            dbSetOrder(1)
            If dbSeek(xFilial("SZM")+SC1->C1_NUM)
                RecLock("SZM",.F.)
                SZM->ZM_APROV   := SC1->C1_APROV
                SZM->ZM_USRAPRO := SC1->C1_USRAPRO
                SZM->ZM_NOMEAPR := SC1->C1_NOMEAPR
            EndIf
            MsUnlock()
            RestArea(_aArea1)
        EndIf
        dbSkip()
    EndDo
    RestArea(_aAreaC1)
    
    If _lBloq
        Envia_EMail()
    EndIf
EndIf

RestArea(_aArea)
Return

//////////////////////////////////////////////////////////////////////////////////
// **************************************************************************** //
//////////////////////////////////////////////////////////////////////////////////
Static Function Envia_Email()
// Alterado para enviar o email pelo Workflow
/*
Local   _cMensagem := "O usuário     : "+_cNome+" incluiu a solicitacao de compra " + SC1->C1_NUM +" que necessitara de sua Aprovacao." ;
+CHR(13) + CHR(10)+CHR(13) + CHR(10)+"SC do Fornec. : "+ SC1->C1_FORNECE+" - " + SC1->C1_LOJA + " " +_cNomFor+ CHR(13) + CHR(10)+CHR(13);
+ CHR(10)+CHR(13) + CHR(10)+CHR(13) + CHR(10)+"Valor Total: "+ Transform(_nVlrTotSC ,"@E 999,999,999.99" );
+ CHR(10)+CHR(13) + CHR(10)+CHR(13) + CHR(10)+"Data          : "+ Dtoc(dDataBase)+;
" Horario "+Time()+"." + CHR(13) + CHR(10)+"____________________________________________________________________________________" + ;
CHR(13) + CHR(10)+CHR(13) + CHR(10)+"Por favor não responda esse e-mail. Mensagem enviada automaticamente"
Local   _aFiles     := {}
Private _cRecebe   := 'cnpuerta@globo.com;soliveira@ncgames.com.br;ebuttner@ncgames.com.br;' + _cMailLib
Private _cCC       := ' '
Private _cBCC      := ' '
Private _cAssunto  := "Solicitacao de Compra : "+ SC1->C1_NUM +" necessita de Aprovacao."

U_ENVIAEMAIL(_cRecebe,_cCC,_cBCC,_cAssunto,_cMensagem,_aFiles)
*/          
Private _cRecebe   := 'cnpuerta@globo.com;soliveira@ncgames.com.br;ebuttner@ncgames.com.br;' 

//U_COMWF001(_cRecebe,_cMailLib)
U_COMRD003(_cRecebe,"" /*_cMailLib*/)

Return
/*/
Local _aArea     := GetArea()
Local _cServer   := '192.168.0.209'                  // GETMV("MV_RELSERV")              // '192.168.0.209'
Local _cAccount  := 'nfe@ncgames.com.br'             // GETMV("MV_RELACNT")
Local _cEnvia    := 'nfe@ncgames.com.br'             // GETMV("MV_RELACNT")              // "protheus@ncgames.com.br"
Local _cPassword := 'games105'                       // GETMV("MV_RELAPSW")

Private _cCRLF     := Chr(13) + Chr(10)
Private _cMensagem := Space(01)
Private _cUser     := RetCodUsr()                            // Codigo do usuario Solicitante
Private _cNome     := UsrRetName(_cUser)                     // Nome do usuario Solicitante
Private _cMailUser := AllTrim(UsrRetMail(_cUser))            // EMail do usuario Solicitante
Private _cMailSoli := AllTrim(UsrRetMail(SC1->C1_USRAPRO))   // EMail do usuario que ira Aprovar a Solicitacao

Private _cNomFor   := GetAdvFVal("SA2","A2_NOME",xFilial("SC1")+SC1->C1_FORNECE+SC1->C1_LOJA,1,Space(40))

_cMensagem := _cMensagem + _cCRLF + _cCRLF +;
"O usuário     : "+_cNome+" incluiu a solicitacao de compra  " + SC1->C1_NUM +" que necessitara de sua Aprovacao." + _cCRLF + _cCRLF +;
"SC do Fornec. : "+ SC1->C1_FORNECE+" - " + SC1->C1_LOJA + " " + _cNomFor      + _cCRLF + _cCRLF + _cCRLF + _cCRLF +;
"Data          : "+ Dtoc(dDataBase)+" Horario "+Time()+"." + _cCRLF +;
"____________________________________________________________________________________" + _cCRLF+ _cCRLF +;
"Por favor não responda esse e-mail. Mensagem enviada automaticamente"


_cRecebe := 'cnpuerta@globo.com;' // + _cMailUser ///  + _cMailSoli

CONNECT SMTP SERVER _cServer ACCOUNT _cAccount PASSWORD _cPassword Result lConectou
MAILAUTH(_cAccount,_cPassword)

SEND MAIL FROM _cEnvia;
TO  _cRecebe;
SUBJECT "Solicitacao de Compra : "+ SC1->C1_NUM +" necessita de Aprovacao.";
BODY _cMensagem;
RESULT lEnviado

//BCC _cMailUser;

If !lEnviado
	_cMensagem := "Falha ao Enviar"
	GET MAIL ERROR _cMensagem
	Alert(_cMensagem)
EndIf

DISCONNECT SMTP SERVER Result lDisConectou

If !lDisConectou
	Alert("Falha ao Desconectar com servidor de E-Mail - " + _cServer)
EndIf

Return(.T.)
/*/