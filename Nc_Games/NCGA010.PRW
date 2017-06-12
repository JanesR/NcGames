#INCLUDE "PROTHEUS.CH"
#include "rwmake.ch"
#INCLUDE "tbiconn.ch"

////////////////////////////////////////////////////////////////////////////////
// ************************************************************************** // 
////////////////////////////////////////////////////////////////////////////////
User Function NCGA010()
Private _aArea := GetArea()
Private _lRet  := .T.
Private oDlg1  := NIL
Private Inclui := .T.

@ 150,001 TO 350,450 DIALOG oDlg1 TITLE "Tipo de Tabela"
@ 010,005 Say "Qual o tipo de Tabela?"
@ 025,005 Say "1 - Tabela Base (Nova)"
@ 035,005 Say "2 - OverPrice"

@ 080,005 BUTTON "1 - Tab. Base"     SIZE 60,12 ACTION Ok1Proc()
@ 080,070 BUTTON "2 - OverPrice"     SIZE 60,12 ACTION Ok2Proc()
@ 080,135 BUTTON "Cancelar"          SIZE 60,12 ACTION Close(oDlg1)
activate dialog oDlg1 centered
Return

////////////////////////////////////////////////////////////////////////////////
// ************************************************************************** // 
////////////////////////////////////////////////////////////////////////////////
Static Function Ok1Proc()
Private oDlg2        := NIL
Private _cTabAtualiz := Space(03)
Private _cCodigo     := Space(03)
Private _cDescricao  := Space(30)
Private _dData01     := dDataBase          // CTOD("")
Private _dData02     := CTOD("")
Private _cHora01     := "00:00"            // Space(05)
Private _cHora02     := "23:59"            // Space(05)

Close(oDlg1)

Define msDialog oDlg2 Title "Dados para Nova Tabela Base" from 0,0 to 260,620 of oDlg2 Pixel

@ 006,006 to 055,300 title "Dados da Tabela" // of oDlg2 Pixel

@ 020,015 Say "Tab.Atualiz."    Size 045,010 Pixel of oDlg2
@ 035,015 Say "Codigo"          Size 045,010 Pixel of oDlg2
@ 035,130 Say "Descrição"       Size 045,010 Pixel of oDlg2

@ 065,015 Say "Data Inicial"    Size 045,010 Pixel of oDlg2
@ 065,130 Say "Hora Inicial"    Size 045,010 Pixel of oDlg2
@ 080,015 Say "Data Final"      Size 045,010 Pixel of oDlg2
@ 080,130 Say "Hora Final"      Size 045,010 Pixel of oDlg2

@ 055,006 to 100,300  of oDlg2 Pixel

@ 020,055 msGet _cTabAtualiz    Picture "@!"    Valid ExistCpo("SZU",_cTabAtualiz) F3 "SZU" Size 030,010 Pixel of oDlg2
@ 035,055 msGet _cTabAtualiz    When .F.        Size 030,010 Pixel of oDlg2
@ 035,160 msGet _cDescricao     Picture "@!"    Size 120,010 Pixel of oDlg2
@ 065,055 msGet _dData01                        Size 045,010 Pixel of oDlg2
@ 065,160 msGet _cHora01        Picture "99:99" Size 030,010 Pixel of oDlg2
@ 080,055 msGet _dData02                        Valid naovazio() .And. _fObgDt2()           Size 045,010 Pixel of oDlg2
@ 080,160 msGet _cHora02        Picture "99:99" Size 030,010 Pixel of oDlg2

@ 110,200 Button "&OK"                   Size 035,012 Pixel of oDlg2 Action Ok1GeraTB()
@ 110,250 Button "&Cancelar"             Size 035,012 Pixel of oDlg2 Action Close(oDlg2)
Activate msDialog oDlg2 Center
Return

////////////////////////////////////////////////////////////////////////////////
// ************************************************************************** // 
////////////////////////////////////////////////////////////////////////////////
Static Function _fObgDt2()
Private _lRet := .T.
If Empty(_dData02) .Or. _dData02 < dDataBase
    Alert("Data final não pode ser anterior a Hoje...")
    _lRet := .F.
EndIf
Return(_lRet)

////////////////////////////////////////////////////////////////////////////////
// ************************************************************************** // 
////////////////////////////////////////////////////////////////////////////////
Static Function Ok1GeraTB()
Close(oDlg2)

Private _nFator := GetAdvFVal("SZU","ZU_FATOR",xFilial("SZU")+_cTabAtualiz,1,0.00)

dbSelectArea("DA0")
dbSetOrder(1)
If !dbSeek(xFilial("DA0")+"XXX")
    Alert("Tabela Base XXX Não Encontrada... Processo abortado...")
    Return
EndIf
If dbSeek(xFilial("DA0")+_cTabAtualiz)
    Alert("Tabela "+_cTabAtualiz+"  Já Inclusa no sistema...  Processo abortado...")
    Return
EndIf

RecLock("DA0",.T.)
DA0->DA0_CODTAB := _cTabAtualiz
DA0->DA0_DESCRI := _cDescricao
DA0->DA0_DATDE  := _dData01
DA0->DA0_HORADE := _cHora01
DA0->DA0_DATATE := _dData02
DA0->DA0_HORATE := _cHora02
DA0->DA0_CONDPG := Space(03)
DA0->DA0_TPHORA := "1"
DA0->DA0_ATIVO  := "1"
DA0->DA0_FILIAL := xFilial("DA0")
DA0->DA0_TABBAS := "XXX"

dbSelectArea("DA1")
dbSetOrder(3)                // DA1_FILIAL+DA1_CODTAB+DA1_ITEM
dbSeek(xFilial("DA1")+"XXX",.T.)

Do While !Eof() .And. DA1->DA1_CODTAB == "XXX"

    _cItem    := DA1->DA1_ITEM
    _cCodPro  := DA1->DA1_CODPRO
    _cGrupo   := DA1->DA1_GRUPO
    _nPrcVen  := DA1->DA1_PRCVEN
    _aAreaDA1 := GetArea()
    
    RecLock("DA1",.T.)
    DA1->DA1_FILIAL := xFilial("DA1")
    DA1->DA1_ITEM   := _cItem
    DA1->DA1_CODTAB := _cTabAtualiz
    DA1->DA1_CODPRO := _cCodPro
    DA1->DA1_GRUPO  := _cGrupo
    DA1->DA1_REFGRD := Space(14)
//  DA1->DA1_PRCBAS := SB1->B1_PRV1   // IF(!INCLUI,Posicione("SB1",1,xFilial("SB1")+DA1->DA1_CODPRO,"B1_PRV1"),"") - CAMPO VIRTUAL
    DA1->DA1_PRCVEN := (_nPrcVen / _nFator)
    DA1->DA1_ATIVO  := "1"
    DA1->DA1_TPOPER := "4"
    DA1->DA1_QTDLOT := 999999.99
    DA1->DA1_MOEDA  := 1
    MsUnlock()
    
    RestArea(_aAreaDA1)
    dbSkip()
EndDo
Alert("Fim de criação da tabela Base "+_cTabAtualiz)
    
RestArea(_aArea)
Return

////////////////////////////////////////////////////////////////////////////////
// ************************************************************************** // 
////////////////////////////////////////////////////////////////////////////////
Static Function Ok2Proc()
Private oDlg2        := NIL
Private _cTabAtualiz := Space(03)
Private _nIndAcresc  := 0.0000
Private _cCodigo     := Space(03)
Private _cDescricao  := Space(30)
Private _dData01     := dDataBase          // CTOD("")
Private _dData02     := CTOD("")
Private _cHora01     := "00:00"            // Space(05)
Private _cHora02     := "23:59"            // Space(05)

Close(oDlg1)

Define msDialog oDlg2 Title "Dados para Nova Tabela Base" from 0,0 to 260,620 of oDlg2 Pixel

@ 006,006 to 055,300 TITLE "Dados da Tabela" // of oDlg2 Pixel

@ 020,015 Say "Tabela Base"     Size 045,010 Pixel of oDlg2
@ 020,130 Say "Ind.Acrescimo"   Size 045,010 Pixel of oDlg2
@ 035,015 Say "Codigo"          Size 045,010 Pixel of oDlg2
@ 035,130 Say "Descrição"       Size 045,010 Pixel of oDlg2

@ 065,015 Say "Data Inicial"    Size 045,010 Pixel of oDlg2
@ 065,130 Say "Hora Inicial"    Size 045,010 Pixel of oDlg2
@ 080,015 Say "Data Final"      Size 045,010 Pixel of oDlg2
@ 080,130 Say "Hora Final"      Size 045,010 Pixel of oDlg2

@ 055,006 to 100,300  of oDlg2 Pixel

@ 020,055 msGet _cTabAtualiz    Picture "@!"   Valid ExistCpo("DA0",_cTabAtualiz) F3 "DA0"              Size 030,010  Pixel of oDlg2
@ 020,170 msGet _nIndAcresc     Picture "@E 9999.99999" Valid IIF(_nIndAcresc == 0.00000,.F.,.T.)       Size 045,010  Pixel of oDlg2
@ 035,055 msGet _cCodigo        Picture "@!"   Valid EXISTCHAV("DA0",_cCodigo)                          Size 030,010  Pixel of oDlg2
@ 035,170 msGet _cDescricao     Picture "@!"                                                            Size 120,010  Pixel of oDlg2
@ 065,055 msGet _dData01                                                                                Size 045,010  Pixel of oDlg2
@ 065,170 msGet _cHora01        Picture "99:99"                                                         Size 030,010  Pixel of oDlg2
@ 080,055 msGet _dData02                       Valid naovazio() .And. _fObgDt2()                        Size 045,010  Pixel of oDlg2
@ 080,170 msGet _cHora02        Picture "99:99"                                                         Size 030,010  Pixel of oDlg2

@ 110,200 Button "&OK"                   Size 035,012 Pixel of oDlg2 Action Ok2GeraTB()
@ 110,250 Button "&Cancelar"             Size 035,012 Pixel of oDlg2 Action Close(oDlg2)
Activate msDialog oDlg2 Center
Return

////////////////////////////////////////////////////////////////////////////////
// ************************************************************************** // 
////////////////////////////////////////////////////////////////////////////////
Static Function Ok2GeraTB()
Close(oDlg2)

If _cTabAtualiz > "100"
    Alert("Codigo informado para tabela base não corresponde a uma Tabela Base...  Processo abortado...")
    Return
EndIf

If _cCodigo < "100"
    Alert("Codigo informado para nova tabela corresponde a codigo de Tabela Base...   Processo abortado...")
    Return
EndIf

dbSelectArea("DA0")
dbSetOrder(1)
If !dbSeek(xFilial("DA0")+_cTabAtualiz)
    Alert("Tabela Base"+_cTabAtualiz+" Não Encontrada... Processo abortado...")
    Return
EndIf
If dbSeek(xFilial("DA0")+_cCodigo)
    Alert("Tabela "+_cCodigo+"  Já Inclusa no sistema...  Processo abortado...")
    Return
EndIf

//INCLUIDO POR ROGERIO PARA GRAVAR TABELA CRIADA

DbSelectArea("SZK")
DbSetOrder(1)
cCod := NextNumero("SZK",1,"ZK_CODIGO",.T.)
If ( dbSeek( xFilial("SZK")+cCod ))
cCod := NextNumero("SZK",1,"ZK_CODIGO",.T.)+1
EndIf
RecLock("SZK",.T.)
SZK->ZK_CODIGO 	:=cCod
SZK->ZK_DESC		:=_cDescricao
SZK->ZK_TABAATU	:=_cCodigo
SZK->ZK_TABBASE	:=_cTabAtualiz
SZK->ZK_INDICE		:=_nIndAcresc

ConfirmSx8() 

RecLock("DA0",.T.)
DA0->DA0_CODTAB := _cCodigo
DA0->DA0_DESCRI := _cDescricao
DA0->DA0_DATDE  := _dData01
DA0->DA0_HORADE := _cHora01
DA0->DA0_DATATE := _dData02
DA0->DA0_HORATE := _cHora02
DA0->DA0_CONDPG := Space(03)
DA0->DA0_TPHORA := "1"
DA0->DA0_ATIVO  := "1"
DA0->DA0_FILIAL := xFilial("DA0")
DA0->DA0_TABBAS := _cTabAtualiz

dbSelectArea("DA1")
dbSetOrder(3)                // DA1_FILIAL+DA1_CODTAB+DA1_ITEM
dbSeek(xFilial("DA1")+_cTabAtualiz,.T.)

Do While !Eof() .And. DA1->DA1_CODTAB == _cTabAtualiz

    _cItem    := DA1->DA1_ITEM
    _cCodPro  := DA1->DA1_CODPRO
    _cGrupo   := DA1->DA1_GRUPO
    _nPrcVen  := DA1->DA1_PRCVEN
    _aAreaDA1 := GetArea()
    
    RecLock("DA1",.T.)
    DA1->DA1_FILIAL := xFilial("DA1")
    DA1->DA1_ITEM   := _cItem
    DA1->DA1_CODTAB := _cCodigo
    DA1->DA1_CODPRO := _cCodPro
    DA1->DA1_GRUPO  := _cGrupo
    DA1->DA1_REFGRD := Space(14)
//  DA1->DA1_PRCBAS := SB1->B1_PRV1   // IF(!INCLUI,Posicione("SB1",1,xFilial("SB1")+DA1->DA1_CODPRO,"B1_PRV1"),"")
    DA1->DA1_PRCVEN := _nPrcVen + (_nPrcVen * (_nIndAcresc / 100))
    DA1->DA1_ATIVO  := "1"
    DA1->DA1_TPOPER := "4"
    DA1->DA1_QTDLOT := 999999.99
    DA1->DA1_MOEDA  := 1
    MsUnlock()
    
    RestArea(_aAreaDA1)
    dbSkip()
EndDo
Alert("Fim de criação da tabela OverPrice "+_cCodigo)
    
RestArea(_aArea)
Return