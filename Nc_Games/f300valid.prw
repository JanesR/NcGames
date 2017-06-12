/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �F300VALID �Autor  �Hermes Ferreira     � Data �  19/11/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �Tratamento no P.E da rotina de Compensa��o para n�o permitir���
���          �a compensa��o de titulos que est�o com Bloqueio de VPC      ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function F300VALID()

Local lRet := .T.

If SE1->E1_YBLQVPC == 'S'
	
	lRet := .F.
	Aviso("F300VALID - 01","O t�tulo selecionado est� bloqueado pela Al�ada do VPC e n�o poder� ser compensado.",{"Ok"},3)
		
EndIf
	
Return lRet

