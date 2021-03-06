#INCLUDE "PROTHEUS.CH"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o	 � FA050UPD	� Autor � Microsiga				� Data � 10/02/15 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Ponto de entrada utilizado para permitir ou nao o uso da   ���
���          � rotina de inclus�o,altera��o ou exclus�o do contas a 	  ���
���          � pagar													  ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function FA050UPD()

Local aArea 	:= GetArea()
Local cCodUser  := Alltrim(RetCodUsr())
Local lRet		:= .T.
Local lJob		:= IsBlind()
Local cUserAut	:= U_MyNewSX6("NC_LIBIACP",;
									"",;
									"C",;
									"C�digo dos usu�rios autorizados a incluir/alterar contas a pagar",;
									"C�digo dos usu�rios autorizados a incluir/alterar contas a pagar",;
									"C�digo dos usu�rios autorizados a incluir/alterar contas a pagar",;
									.F. )

//Verifica se o usu�rio est� autorizado a incluir contas a receber
If (FunName() $ "FINA050|FINA750") .And.  INCLUI .And. !lJob
	If Alltrim(cCodUser) $ Alltrim(cUserAut)
		lRet := .T.
	Else 
		Aviso("Aten��o", "Usu�rio n�o autorizado, bloqueio solicitado pelo Depto. Cont�bil.  (Par�metro NC_LIBIACP)",{"Ok"},2)
		lRet := .F.
	EndIf
Endif


RestArea(aArea)
Return lRet