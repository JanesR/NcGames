#INCLUDE "PROTHEUS.CH"



/*
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �MTA010OK  � Autor �ELTON SANTANA		    � Data � 02/09/13 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � 		      ���
���			 � 												  			  ���
�������������������������������������������������������������������������Ĵ��
���Sintaxe   � 							                                  ���
�������������������������������������������������������������������������Ĵ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function MTA010OK()

Local aArea := GetArea()
Local aArea := GetArea()
Local lRet	:= .T.

//Verifica se o produto e do tipo software. Se for n�o poder� ser alterado
//Essa valida��o dever� ser efetuada na Altera��o e/ou Exclus�o
If !INCLUI
	lRet	:= U_VldSftw(SB1->B1_COD)
EndIf

RestArea(aArea)
Return lRet
