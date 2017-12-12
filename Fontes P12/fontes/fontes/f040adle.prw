#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'TopConn.ch'

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �F040ADLE  �Autor  �Hermes Ferreira     � Data �  19/11/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �P.E para inclus�o do novo status no legenda de titulo a rece���
���          �ber para tratar titulos bloqueados do VPC que est�o aguardan���
���          �do aprova��o da al�ada                                      ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function F040ADLE()

	Local aLegenda	:= {}
	
//	ErrorBlock( { |oErro| U_MySndError(oErro) } )	
	
	If FunName()=="FINA040"	
	
		Aadd(aLegenda,{"BR_LARANJA","T�tulo Bloqueado - VPC" })
	
    EndIf
Return aLegenda             





Return 