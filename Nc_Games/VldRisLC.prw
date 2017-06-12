#INCLUDE "PROTHEUS.CH"


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³VldRisLC  ºAutor  ³Microsiga           º Data ³  17/07/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Validação da permissão de usuário para alterar o campo	  º±±
±±º          ³limite de credito e risco do cliente                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ NC Games                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function VldRisLC(cCampo)

Local aArea 	:= GetArea()
Local lRet		:= .T.
Local cCodUser  := Alltrim(RetCodUsr())
Local cUserAut	:= U_MyNewSX6("NC_ALTRLC",;
"000189",;
"C",;
"Usuários autorizados a efetuar alteração do limite de crédito e\ou risco do cliente.",;
"Usuários autorizados a efetuar alteração do limite de crédito e\ou risco do cliente.",;
"Usuários autorizados a efetuar alteração do limite de crédito e\ou risco do cliente.",;
.F. )

Default cCampo:=__ReadVar

If !(Alltrim(cCodUser) $ Alltrim(cUserAut))
	If cCampo == "M->A1_LC" .And. M->A1_LC == 0
		lRet	:= .t.
	Else
		lRet	:= .F.
		If !IsBlind()
			Aviso("Permissão de usuário","Usuário sem permissão para alterar o campo, entre em contato com o Administrador. (NC_ALTRLC) ",{"Ok"},2)
		Else
			conout("Usuário sem permissão para alterar o campo, entre em contato com o Administrador. (NC_ALTRLC) ")
		EndIf
	EndIf
EndIf


RestArea(aArea)
Return lRet
