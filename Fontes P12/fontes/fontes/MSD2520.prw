#INCLUDE "protheus.ch"
#INCLUDE "rwmake.ch"

Static aPedidos:={}
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �MSD2520   �Autor  � 				     � Data �  17/10/13   ���
�������������������������������������������������������������������������͹��
���Desc.     �Ponto de entrada na exclusao do item na nota de saida       ���
�������������������������������������������������������������������������͹��
���Uso       � NC Games                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function MSD2520()

If aScan(aPedidos,SD2->D2_PEDIDO)==0
	AAdd(aPedidos,SD2->D2_PEDIDO)
EndIf

Return        

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  ��MSD2520  �Autor  �Microsiga           � Data �  09/17/13   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function D2520GetPV()
Return aPedidos

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  ��MSD2520  �Autor  �Microsiga           � Data �  09/17/13   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function D2520IniPv()
aPedidos:={}
Return 
