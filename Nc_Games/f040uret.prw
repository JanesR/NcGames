#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'TopConn.ch'

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �F040URET  �Autor  �Hermes Ferreira     � Data �  19/11/12   ���
�������������������������������������������������������������������������͹��
���Desc.     � P.E para inclus�o do novo status no browse de titulo a rece���
���          �ber para tratar titulos bloqueados do VPC que est�o aguardan���
���          �do aprova��o da al�ada                                      ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function F040URET()

	Local aRet := {}
	
//	ErrorBlock( { |oErro| U_MySndError(oErro) } )	
	
	If FunName()=="FINA040"	

		aAdd(aRet,{"E1_YBLQVPC == 'S' ","BR_LARANJA"})
	                       	
	Endif

Return aRet