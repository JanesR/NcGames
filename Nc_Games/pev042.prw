/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �PEV042    �Autor  Jo�o Cozer           � Data �  02/20/11   ���
�������������������������������������������������������������������������͹��
���Desc.     �Ponto de Entrada para apresenta��o resumida do pedido de    ���
���          �venda                                                       ���
�������������������������������������������������������������������������͹��
���Uso       � 			                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function PEV042()

Local aReturn := {}

	aAdd( aReturn, "ORDERID" ) 
	aAdd( aReturn, "CUSTOMERCODE" )
	aAdd( aReturn, "CUSTOMERUNIT" )
	aAdd( aReturn, "C5_NOMCLI" )
	aAdd( aReturn, "DELIVERYUNITCODE")
	AAdd( aReturn, "C5_MENSINT")
	AAdd( aReturn, "C5_PEDCLI" )
	aAdd( aReturn, "REGISTERDATE" )
	AAdd( aReturn, "C5_NOTA" )
	AAdd( aReturn, "C5_SERIE" )
	AAdd( aReturn, "C5_XSTAPED" )


Return aReturn