#Include "Protheus.Ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³F110FIL   ºAutor  ³Microsiga           º Data ³  01/20/05   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³FILTRO PARA A BAIXA AUTOMATICA DO CR. FILTRA POR BANCO DE ATE±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP8                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function F110FIL()    //IoDlg()

Local oDlg       := Nil
Local oFld       := Nil
Local cBancode   := Space(03)
Local cBancoate  := Space(03)

DEFINE MSDIALOG oDlg TITLE "Filtro po Banco" FROM 0,0 TO 200,300 OF oDlg PIXEL

@ 06,06 TO 095,143 LABEL "Filtro" OF oDlg PIXEL
@ 16, 10 SAY "Banco De   ?"            SIZE  65, 8 PIXEL OF oDlg
@ 16, 50 MSGET cBancode  F3 "SA6" PICTURE "@!" SIZE 40,10 PIXEL OF oDlg
@ 30, 10 SAY "Banco Ate  ?"            SIZE  65, 8 PIXEL OF oDlg
@ 30, 50 MSGET cBancoate F3 "SA6" PICTURE "@!" SIZE 40,10 PIXEL OF oDlg

@ 060,100 BUTTON "&Confirma"       SIZE 36,16 PIXEL ACTION oDlg:End()

ACTIVATE MSDIALOG oDlg CENTER         


_CTESTE := "SE1->E1_PORTADO >= '"+CBANCODE+"' .AND. SE1->E1_PORTADO <= '"+ CBANCOATE+"'"


Return _CTESTE
