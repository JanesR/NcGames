#INCLUDE "PROTHEUS.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³SF1100I   ºAutor  ³ERICH BUTTNER       º Data ³  18/05/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ PONTO DE ENTRADA UTILIZADO NO OK DO DOCUMENTO DE ENTRADA   º±±
±±º			 ³                                                       	  º±±
±±º			 ³                                                      	  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
//
//  Incluido por Carlos Nemesio Puerta - Mai-Jun/2011
//
User Function SF1100I()

Private _aArea    := GetArea()

If SF1->F1_TIPO $ "C/I/P"        // Complemento de preço/Complemento de ICMS/Complemento de IPI
	Return
EndIf

//Para gravar motivos de devolução na digitação da NF de entrada de devolução de vendas
If SF1->F1_TIPO == "D"
	
	A_SF1100I()
	
EndIf

U_NCGINT001()

RestArea(_aArea)

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao³ A_SF1100I    ³ Por: Adalberto Moreno Batista       ³ Data ³          ³±±
±±ÀÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function A_SF1100I()

Local cCliente  := SF1->F1_FORNECE+" / "+SF1->F1_LOJA+" - "
Local cJustif	:= SF1->F1_JUSTIF
Local cMotivo	:= SF1->F1_MOTIVO
Local cRefat	:= SF1->F1_REFAT 
Local cMensagem := SF1->F1_X_MSG
Local cTpOrigem
Local aCombo 	:= {"1=Sim","2=Não"," "}
Local aArea100I := getarea()
Private oOC


if !SF1->F1_TIPO $ 'DB'
	cCliente  += GetAdvFVal("SA2","A2_NOME",xFilial("SA2")+SF1->F1_FORNECE+SF1->F1_LOJA,1)
	cTpOrigem := 'Fornecedor'
else
	cCliente  += GetAdvFVal("SA1","A1_NOME",xFilial("SA1")+SF1->F1_FORNECE+SF1->F1_LOJA,1)
	cTpOrigem := 'Cliente'
endif

@ 132,16 To 490,566 Dialog oOC Title OemToAnsi("Motivo e Justificativa")

@ 10,010 Say OemToAnsi("Nota Fiscal") Size 40,8
@ 10,120 Say OemToAnsi("Série") Size 16,8
@ 10,195 Say OemToAnsi("Emissão") Size 25,8
@ 25,010 Say OemToAnsi(cTpOrigem) Size 40,8
@ 45,010 Say OemToAnsi("Justificativa") Size 40,8
@ 66,010 Say OemToAnsi("Motivo") Size 40,8
@ 87,010 Say OemToAnsi("Refaturado") Size 40,8

@ 09,055 Get SF1->F1_DOC Size 40,10 when .F.
@ 09,140 Get SF1->F1_SERIE Size 25,10 when .F.
@ 09,225 Get SF1->F1_EMISSAO Size 35,10 when .F.
@ 24,055 Get cCliente Size 205,10 when .F.
//@ 44,055 Get cMensagem picture "@S100" Size 200,10
@ 44,050 GET cJUSTIF     PICTURE PesqPict("SF1","F1_JUSTIF")   SIZE 200,10 
@ 65,050 GET cMOTIVO     PICTURE PesqPict("SF1","F1_MOTIVO")   F3 CpoRetF3("F1_MOTIVO") SIZE 100,10 //VALID (vazio() .or. ExistCpo("SX5","Z5"+&cMOTIVO))
@ 86,050 COMBOBOX cREFAT Items aCombo SIZE 50,10

@ 150,182 BmpButton Type 1 Action GravaOC(cJUSTIF,cMOTIVO,cREFAT)
@ 150,227 BmpButton Type 2 Action (oOC:End())

Activate Dialog oOC Centered

RestArea(aArea100I)

Return()


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao³ GravaOC      ³ Por: Adalberto Moreno Batista       ³ Data ³          ³±±
±±ÀÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function GravaOC(cJUSTIF,cMOTIVO,cREFAT)
SF1->(RecLock("SF1",.F.))
SF1->F1_JUSTIF := cJustif
SF1->F1_MOTIVO := cMotivo
SF1->F1_REFAT  := cRefat
SF1->(MsUnlock())
Close(oOC)
Return()
