
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �FA060QRY  �Autor  �Microsiga           � Data �  06/10/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �Permite a inclus�o de uma condicao adicional para a Query   ���
���          �Esta condicao obrigatoriamente devera ser tratada em um AND ���
���          �para nao alterar as regras basicas da mesma.				  ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function FA060QRY
Local aDados:=ParamIxb  //{cAgen060,cConta060}
Local cQuery:=Nil   // Para o caso de n�o ter filtro

If IsIncallStack("U_M001BORDE")
	cQuery:="Exists ( Select 'X' From "+RetSqlName("SA1")+" SA1 Where SA1.A1_FILIAL='"+xFilial("SA1")+"' And SA1.A1_COD=E1_CLIENTE And SA1.A1_LOJA=E1_LOJA And SA1.A1_YNBANCA='S' And SA1.D_E_L_E_T_=' ')"
EndIf

Return cQuery 