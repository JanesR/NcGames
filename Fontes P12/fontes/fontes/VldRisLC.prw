#INCLUDE "PROTHEUS.CH"


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �VldRisLC  �Autor  �Microsiga           � Data �  17/07/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �Valida��o da permiss�o de usu�rio para alterar o campo	  ���
���          �limite de credito e risco do cliente                        ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function VldRisLC(cCampo)

Local aArea 	:= GetArea()
Local lRet		:= .T.
Local cCodUser  := Alltrim(RetCodUsr())
Local cUserAut	:= U_MyNewSX6("NC_ALTRLC",;
"000189",;
"C",;
"Usu�rios autorizados a efetuar altera��o do limite de cr�dito e\ou risco do cliente.",;
"Usu�rios autorizados a efetuar altera��o do limite de cr�dito e\ou risco do cliente.",;
"Usu�rios autorizados a efetuar altera��o do limite de cr�dito e\ou risco do cliente.",;
.F. )

Default cCampo:=__ReadVar

If !(Alltrim(cCodUser) $ Alltrim(cUserAut))
	If cCampo == "M->A1_LC" .And. M->A1_LC == 0
		lRet	:= .t.
	Else
		lRet	:= .F.
		If !IsBlind()
			Aviso("Permiss�o de usu�rio","Usu�rio sem permiss�o para alterar o campo, entre em contato com o Administrador. (NC_ALTRLC) ",{"Ok"},2)
		Else
			conout("Usu�rio sem permiss�o para alterar o campo, entre em contato com o Administrador. (NC_ALTRLC) ")
		EndIf
	EndIf
EndIf


RestArea(aArea)
Return lRet
