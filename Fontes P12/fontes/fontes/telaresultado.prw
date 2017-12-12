#INCLUDE "PROTHEUS.CH"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³TelaResultado ³ Autor ³ Rafael Augusto    ³ Data ³31/05/2010³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Locacao   ³ Supertech - rafael@stch.com.br							  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ NC GAMES                                                   ³±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

User Function TelaResultado()

// Variaveis da Funcao de Controle e GertArea/RestArea
Local _aArea   		:= {}
Local _aAlias  		:= {}

// Variaveis Private da Funcao
Private oDlg				// Dialog Principal

CEPCLI := "  "
ESTCLI := "  "

dbselectarea("SA1")
dbSetOrder(1)
dbSeek(xFilial() + M->C5_CLIENTE + M->C5_LOJACLI)

CEPCLI := SA1->A1_CEP
ESTCLI := SA1->A1_EST

//DEFINE MSDIALOG oDlg TITLE "MODAL X FRETE" FROM C(128),C(131) TO C(498),C(667) PIXEL -> ORIGINAL.
DEFINE MSDIALOG oDlg TITLE "MODAL X FRETE" FROM C(128),C(131) TO C(350),C(370) PIXEL

@ C(005),C(005) Say "O Estado do Cliente é:" COLOR CLR_BLACK PIXEL OF oDlg
@ C(005),C(065) Say oGet4 Var ESTCLI COLOR CLR_BLACK PIXEL OF oDlg 

@ C(015),C(005) Say "O CEP do Cliente é:   " COLOR CLR_BLACK PIXEL OF oDlg
@ C(015),C(065) Say oGet4 Var CEPCLI COLOR CLR_BLACK PIXEL OF oDlg

@ C(025),C(005) Say "O Modal usado será:   " COLOR CLR_BLACK PIXEL OF oDlg

IF !Empty(_modalcarro)
	@ C(025),C(065) Say oGet4 Var ALLTRIM(_MODALCARRO) COLOR CLR_BLACK PIXEL OF oDlg
ElseIF !Empty(_modalsedex)
	@ C(025),C(065) Say oGet4 Var ALLTRIM(_MODALSEDEX) COLOR CLR_BLACK PIXEL OF oDlg
else
	@ C(025),C(065) Say oGet4 Var ALLTRIM(_MODALTRANS) COLOR CLR_BLACK PIXEL OF oDlg
endif

@ C(035),C(005) Say "A Somatoria do pedido é:  R$" COLOR CLR_BLACK PIXEL OF oDlg
@ C(035),C(065) Say oGet4 Var _cSomaTotal COLOR CLR_BLACK Picture "@E 9,999,999.99" PIXEL OF oDlg

@ C(045),C(005) Say "O Valor do Frete será:     R$" COLOR CLR_BLACK PIXEL OF oDlg
@ C(045),C(065) Say oGet5 Var M->C5_FRETEOR COLOR CLR_BLACK Picture "@E 9,999,999.99" PIXEL OF oDlg

@ C(055),C(005) Say "O Valor do Seguro será:   R$" COLOR CLR_BLACK PIXEL OF oDlg
@ C(055),C(065) Say oGet6 Var M->C5_SEGUROR COLOR CLR_BLACK Picture "@E 9,999,999.99" PIXEL OF oDlg

_ctotal :=  m->c5_seguroR + m->C5_freteOR

@ C(065),C(005) Say "O Valor do Seguro + Frte:  R$" COLOR CLR_BLACK PIXEL OF oDlg
@ C(065),C(065) Say oGet7 Var _ctotal COLOR CLR_BLACK Picture "@E 9,999,999.99" PIXEL OF oDlg
 
@ C(075),C(005) Say "O Tempo de Entrega e:" COLOR CLR_BLACK PIXEL OF oDlg
@ C(075),C(060) Say "D + " COLOR CLR_BLACK PIXEL OF oDlg
@ C(075),C(065) Say oGet7 Var _cDias COLOR CLR_BLACK Picture "@E 999" PIXEL OF oDlg
                                    
_cpercentual := (_ctotal / _cSomaTotal) * 100

@ C(083),C(005) Say "O Percentual do Frete e: " COLOR CLR_BLACK PIXEL OF oDlg
@ C(083),C(065) Say oGet6 Var _cpercentual COLOR CLR_BLACK Picture "@E 999.99" PIXEL OF oDlg
@ C(083),c(078) Say oGet8 Var "%" COLOR CLR_BLACK PIXEL OF oDlg

DEFINE SBUTTON FROM C(093),C(055) TYPE 1 ACTION oDlg:End() ENABLE OF oDlg

ACTIVATE MSDIALOG oDlg CENTERED

Return