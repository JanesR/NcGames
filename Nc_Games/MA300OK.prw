
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �MA300OK   �Autor  �Microsiga           � Data �  05/15/15   ���
�������������������������������������������������������������������������͹��
���Desc.     � Valida se pode efetuar o recalculo dos Saldos					���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function MA300OK()
Local lRetorno:=.T.

If IsInCallStack("U_WML02Gravar")
	U_WML02Saldo()//Altera os parametros para calculcar somente o produto movimentado na Interface do WM.
EndIf

Return lRetorno