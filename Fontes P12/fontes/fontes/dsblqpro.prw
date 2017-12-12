#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
//
//   Carlos Nemesio Puerta - Jul/2011
//   Rotina para retirar bloqueio de inventario de todos os produtos.
//
User Function DSBLQPRO()
Private _aArea := GetArea()

@ 096,042 TO 323,505 DIALOG oDlg5 TITLE "Retira bloqueio de inventario de todos os produtos"
@ 008,010 TO 084,222
@ 091,168 BMPBUTTON TYPE 1 ACTION OkProc()
@ 091,196 BMPBUTTON TYPE 2 ACTION Close(oDlg5)
@ 023,014 SAY "Retira bloqueio de inventario de todos os produtos."
@ 033,014 SAY " "
@ 043,014 SAY "Este programa tem o objetivo de zerar as datas de Inicio e Fim de "
@ 053,014 SAY "bloqueio dos produtos para inventário."
  ACTIVATE DIALOG oDlg5
  Return

Static Function OkProc()
Close(oDlg5)
Processa( {|| RunProc() } )
Return

Static Function RunProc()
dbSelectArea("SB2")                    // Saldos Fisicos e Financeiros
dbSetOrder(1)
ProcRegua(LastRec())
dbGoTop()

Do While !Eof()

    IncProc("SB2 - "+SB2->B2_COD)

    RecLock("SB2",.F.)
    SB2->B2_DTINV   := CTOD("  /  /    ")
    SB2->B2_DINVFIM := CTOD("  /  /    ")
    MsUnlock()

    dbSelectArea("SB2")
    dbSkip()
EndDo

RestArea(_aArea)
Return