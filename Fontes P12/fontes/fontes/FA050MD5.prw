
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �FA050MD5  �Autor  �Microsiga           � Data �  11/10/16   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function FA050MD5()

If IsInCallStack("FA050AXINC")  .And. Trim(SE5->E5_TIPO)=="PA" .And. Trim(SE5->E5_LA)=="S" .And. SE2->(E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA)==SE5->(E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA)
	SE5->(RecLOck("SE5",.F.))
	SE5->E5_LA:="N"
	SE5->(MsUnlock())	
EndIf



Return
