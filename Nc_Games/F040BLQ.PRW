#INCLUDE "PROTHEUS.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ F040BLQ	³ Autor ³ Microsiga  			³ Data ³ 10/02/15 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Ponto de entrada utilizado para permitir ou nao o uso da   ³±±
±±³          ³ rotina de inclusão,alteração ou exclusão do contas a 	  ³±±
±±³          ³ receber													  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function F040BLQ()

Local aArea 	:= GetArea()
Local cCodUser  := Alltrim(RetCodUsr())
Local lRet		:= .T.
Local lJob		:= IsBlind()
Local cUserAut	:= U_MyNewSX6("NC_LIBIACR",;
									"",;
									"C",;
									"Código dos usuários autorizados a incluir/alterar contas a receber",;
									"Código dos usuários autorizados a incluir/alterar contas a receber",;
									"Código dos usuários autorizados a incluir/alterar contas a receber",;
									.F. )

//Verifica se o usuário está autorizado a incluir contas a receber
If (FunName() $ "FINA040|FINA740") .And.  INCLUI .And. !lJob
	If Alltrim(cCodUser) $ Alltrim(cUserAut)
		lRet := .T.
	Else 
		Aviso("Atenção", "Usuário não autorizado, bloqueio solicitado pelo Depto. Contábil.  (Parâmetro NC_LIBIACR)",{"Ok"},2)
		lRet := .F.
	EndIf
Endif


RestArea(aArea)
Return lRet