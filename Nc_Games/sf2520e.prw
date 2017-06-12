#INCLUDE "rwmake.ch"
#INCLUDE  "PROTHEUS.CH"
/*/
//ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
//±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
//±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
//±±ºPrograma  ³SF2520E   º Autor ³ ERICH BUTTNER      º Data ³  15-10-10   º±±
//±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
//±±ºDescricao ³ 							                                º±±
//±±º          ³                                                            º±±
//±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
//±±ºUso       ³ AP10 NC GAMES                                              º±±
//±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
//±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
//ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
              	
User Function SF2520E()

Local aArea520E	:= getarea()

//restaurando o conteúdo da variável MVNOTAFIS alterado pelo programa MS520VLD
If alltrim(MVNOTAFIS) == "CC"
	MVNOTAFIS	:= u_GetMS520() //padr("NF",tamsx3("E1_TIPO")[1])
EndIf

DBSELECTAREA("SD2")
DBSETORDER(3)
DBSEEK(XFILIAL("SD2")+SF2->F2_DOC+SF2->F2_SERIE)

CPEDIDO:= SD2->D2_PEDIDO


DBSELECTAREA("SC5")
DBSETORDER(1)
DBSEEK(XFILIAL("SC5")+CPEDIDO)
RECLOCK("SC5")
SC5->C5_REPICK := ""
SC5->C5_STAPICK := ""
SC5->C5_CODBL	:= ""
SC5->C5_DTLIB	:= CTOD("  /  /  ")
SC5->(MSUNLOCK())

DBSELECTAREA("SZ7")
SZ7->(DBSETORDER(1))
IF SZ7->(DBSEEK(XFILIAL("SZ7")+CPEDIDO+"000010"))
	WHILE SZ7->Z7_STAT == "000010"
		RECLOCK("SZ7")
		DBDELETE()
		SZ7->(MSUNLOCK())
		SZ7->(DBSKIP())
	ENDDO
ENDIF   

U_Z7Status(xFilial("SC6"),SC5->C5_NUM,"000015","CANCELAMENTO DE NOTA FISCAL",SC5->C5_CLIENTE, SC5->C5_LOJACLI)

SZ7->(DBGOTOP())
IF SZ7->(DBSEEK(XFILIAL("SZ7")+CPEDIDO+"000002"))
	RECLOCK("SZ7")
	DBDELETE()
	SZ7->(MSUNLOCK())
ENDIF
SZ7->(DBGOTOP())
IF SZ7->(DBSEEK(XFILIAL("SZ7")+CPEDIDO+"000013"))
	RECLOCK("SZ7")
	DBDELETE()
	SZ7->(MSUNLOCK())
ENDIF
SZ7->(DBGOTOP())
IF SZ7->(DBSEEK(XFILIAL("SZ7")+CPEDIDO+"000014"))
	RECLOCK("SZ7")
	DBDELETE()
	SZ7->(MSUNLOCK())
ENDIF
SZ7->(DBGOTOP())
IF SZ7->(DBSEEK(XFILIAL("SZ7")+CPEDIDO+"000015"))
	RECLOCK("SZ7")
	DBDELETE()
	SZ7->(MSUNLOCK())
ENDIF
SZ7->(DBGOTOP())
IF SZ7->(DBSEEK(XFILIAL("SZ7")+CPEDIDO+"000003"))
	RECLOCK("SZ7")
	DBDELETE()
	SZ7->(MSUNLOCK())
ENDIF
SZ7->(DBGOTOP())
IF SZ7->(DBSEEK(XFILIAL("SZ7")+CPEDIDO+"000004"))
	RECLOCK("SZ7")
	DBDELETE()
	SZ7->(MSUNLOCK())
ENDIF
SZ7->(DBGOTOP())
IF SZ7->(DBSEEK(XFILIAL("SZ7")+CPEDIDO+"000006"))
	RECLOCK("SZ7")
	DBDELETE()
	SZ7->(MSUNLOCK())
ENDIF
SZ7->(DBGOTOP())
IF SZ7->(DBSEEK(XFILIAL("SZ7")+CPEDIDO+"000008"))
	RECLOCK("SZ7")
	DBDELETE()
	SZ7->(MSUNLOCK())
ENDIF
SZ7->(DBGOTOP())
IF SZ7->(DBSEEK(XFILIAL("SZ7")+CPEDIDO+"000012"))
	WHILE SZ7->Z7_STAT == "000012"
      	RECLOCK("SZ7")
   		DBDELETE()
   		SZ7->(MSUNLOCK())
   		SZ7->(DBSKIP())
   	ENDDO
ENDIF
SZ7->(DBGOTOP())
IF SZ7->(DBSEEK(XFILIAL("SZ7")+CPEDIDO+"000011"))
	WHILE SZ7->Z7_STAT == "000011"
		RECLOCK("SZ7")
	    DBDELETE()
	    SZ7->(MSUNLOCK())
	    SZ7->(DBSKIP())
	ENDDO
ENDIF

DbSelectArea("SZ3")
DbSetOrder(1)
IF dbSeek(xFilial("SZ3")+SF2->F2_DOC+SF2->F2_SERIE)  
	While SZ3->(!EOF()) .AND. xFilial("SZ3")+SF2->F2_DOC+SF2->F2_SERIE == SZ3->(Z3_FILIAL+Z3_DOC+Z3_SERIE)
		Reclock("SZ3")
		DBDELETE()
		MsUnlock()	
		SZ3->(DbSkip())
	End
EndIf

DbSelectArea("SZ1")
DbSetOrder(1)
IF dbSeek(xFilial("SZ1")+SF2->F2_DOC+SF2->F2_SERIE)
	While SZ1->(!EOF()) .AND. xFilial("SZ1")+SF2->F2_DOC+SF2->F2_SERIE == SZ1->(Z1_FILIAL+Z1_DOC+Z1_SERIE)
		Reclock("SZ1")
		DBDELETE()
		MsUnlock()	
		SZ1->(DbSkip())
	End
EndIf

RestArea(aArea520E)

Return
