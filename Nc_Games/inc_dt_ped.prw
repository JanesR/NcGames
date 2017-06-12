#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³INCDTPED  ³ Autor ³ ERICH BUTTNER		    ³ Data ³23/03/2012³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function INCDTPED()


Private cPedido	 := Space(06)
Private cCliente := ''
Private cVendedor:= ''
Private dDtDisFat := CTOD("")
Private dDtPreEnt := CTOD("")
Private oEdit1
Private oEdit2
Private oEdit3
Private oEdit4
Private oEdit5
Private oEdit6
Private _oDlg
Private VISUAL := .F.
Private INCLUI := .F.
Private ALTERA := .F.
Private DELETA := .F.


DEFINE MSDIALOG _oDlg TITLE "INCLUSAO DATA" FROM C(148),C(151) TO C(415),C(483) PIXEL

// Cria Componentes Padroes do Sistema
@ C(006),C(030) Say "INFORME OS DADOS A SEGUIR: " Size C(110),C(008) COLOR CLR_BLUE PIXEL OF _oDlg
@ C(023),C(005) Say "Cliente: " + cCliente Size C(161),C(008) COLOR CLR_BLACK PIXEL OF _oDlg
@ C(043),C(005) Say "Vendedor: " + cVendedor Size C(161),C(008) COLOR CLR_BLACK PIXEL OF _oDlg
@ C(063),C(005) Say "Pedido(s):"           Size C(025),C(008) COLOR CLR_BLACK PIXEL OF _oDlg
@ C(062),C(050) MsGet oEdit1 Var cPedido   F3 "SC5" Size C(060),C(009) COLOR CLR_BLACK PIXEL OF _oDlg VALID NCPEDEST()
@ C(083),C(005) Say "Dt. Prev. Entrega: "   Size C(045),C(008) COLOR CLR_BLACK PIXEL OF _oDlg
@ C(082),C(050) MsGet oEdit1 Var dDtPreEnt Picture "D!"Size C(060),C(009) COLOR CLR_BLACK PIXEL OF _oDlg 
@ C(103),C(005) Say "Dt. Disp. Fat.:"   Size C(025),C(008) COLOR CLR_BLACK PIXEL OF _oDlg
@ C(102),C(050) MsGet oEdit1 Var dDtDisFat Size C(060),C(009) COLOR CLR_BLACK PIXEL OF _oDlg 
@ C(117),C(015) Button "&OK"   Size C(037),C(012) PIXEL OF _oDlg action (if(NCGRV(dDtPreEnt,dDtDisFat),lRet:= .T.,lRet:= .F.))
@ C(117),C(060) Button "&Sair" Size C(037),C(012) action _oDlg:end() Object oBtn
ACTIVATE MSDIALOG _oDlg CENTERED

Return(.T.)

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³   C()   ³ Autores ³ Norbert/Ernani/Mansano ³ Data ³10/05/2005³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Funcao responsavel por manter o Layout independente da       ³±±
±±³           ³ resolucao horizontal do Monitor do Usuario.                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function C(nTam)
Local nHRes	:=	oMainWnd:nClientWidth	// Resolucao horizontal do monitor
If nHRes == 640	// Resolucao 640x480 (soh o Ocean e o Classic aceitam 640)
	nTam *= 0.8
ElseIf (nHRes == 798).Or.(nHRes == 800)	// Resolucao 800x600
	nTam *= 1
Else	// Resolucao 1024x768 e acima
	nTam *= 1.28
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Tratamento para tema "Flat"³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If "MP8" $ oApp:cVersion
	If (Alltrim(GetTheme()) == "FLAT") .Or. SetMdiChild()
		nTam *= 0.90
	EndIf
EndIf
Return Int(nTam)

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³minhatela ³ Autor ³ Erich Buttner         ³ Data ³25/08/2010³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function NCPEDEST()

Local lRet   := .F.
Local cChave := ''

DBSelectArea("SC5")
SC5->(DBSETORDER(1))

if SC5->(DBSEEK(xFilial("SC5")+cPedido))
	cChaveSA3 := SC5->C5_VEND1
	cChaveSA1 := SC5->C5_CLIENTE+SC5->C5_LOJACLI
	
	DBSelectArea("SA1")
	SA1->(DBSETORDER(1))
	
	if SA1->(DBSEEK(xFilial("SA1")+cChaveSA1))
		cCliente := SA1->A1_NOME
	Endif
	
	DBSelectArea("SA3")
	SA3->(DBSETORDER(1))
	
	If SA3->(DBSEEK(XFILIAL("SA3")+cChaveSA3))
		cVendedor := SA3->A3_NOME
	EndIf
	
	lRet := .T.
	
	_oDlg:Refresh()
Else
	MsgInfo = "Pedido não Encontrado !"
Endif

dDtPreEnt := SC5->C5_DTAGEND
dDtDisFat := SC5->C5_DTDISNF

Return lRet

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³minhatela ³ Autor ³ ERICH BUTTNER		    ³ Data ³24/08/2010³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function NCGRV(dDtPreEnt,dDtDisFat)

Local lRet := .F.

If empty(cPedido)
	
	Msginfo("Preencha todos os dados !")
	
Else
	DBSelectArea("SC5")
	SC5->(DBSETORDER(1))
	
	IF SC5->(DBSEEK(xFilial("SC5")+cPedido))
		Reclock("SC5",.f.)
		SC5->C5_DTAGEND:= dDtPreEnt
		SC5->C5_DTDISNF:= dDtDisFat
		SC5->(MSUNLOCK())
	ENDIF
	ALERT("CONCLUIDO COM SUCESSO!")
ENDIF

Return lRet