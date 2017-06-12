#INCLUDE "Protheus.ch"



/*/
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    � SF1100E � Autor �Microsiga			    � Data � 11/10/11 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � PE antes de exluir os itnes do documento de entrada	 	  ���
���			 �	  														  ���
���			 � 															  ���
�������������������������������������������������������������������������Ĵ��
���Sintaxe   � 							                                  ���
�������������������������������������������������������������������������Ĵ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function SD1100E()

Local aArea := GetArea()

//Chamada da rotina para atualizar os valores do CMG BR e CMG PP na exclus�o do documento de entrada
UpdCMGB2(SD1->D1_COD, SD1->D1_LOCAL, SD1->D1_YCUSGER, SD1->D1_YCMGBR)	


RestArea(aArea)
Return        



/*/
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    � UpdCMGB2 � Autor �Microsiga			    � Data � 11/10/11 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Atualiza o valor do CMG BR e CMG PP no saldo atual		  ���
�������������������������������������������������������������������������Ĵ��
���Sintaxe   � 							                                  ���
�������������������������������������������������������������������������Ĵ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/                                            
Static Function UpdCMGB2(cCod, cLocal, nCMG, nCMGBR)

Local aArea 	:= GetArea()
Local nTotCMGBR := 0
Local nTotCMG	:= 0

Default cCod	:= "" 
Default cLocal	:= "" 
Default nCMG	:= 0            
Default nCMGBR	:= 0 

DbSelectArea("SB2")
DbSetOrder(1)
If SB2->(DbSeek(xFilial("SB2") + PADR(cCod, TAMSX3("B2_COD")[1]) + PADR(cLocal, TAMSX3("B2_LOCAL")[1])   ))
	
    
	//Retira o valor do documento de entrada excluido
	nTotCMGBR 	:= SB2->B2_YTCMGBR - nCMGBR
	nTotCMG		:= SB2->B2_YTCMG - nCMG 
	
	//Atualiza o total do CMG BR e CMG PP
	RecLock("SB2",.F.)    
	If nTotCMGBR > 0
		SB2->B2_YCMGBR	:= nTotCMGBR / SB2->B2_QATU
	EndIf
	If nTotCMG > 0
		SB2->B2_YCMVG	:= nTotCMG / SB2->B2_QATU
	EndIf
	SB2->B2_YTCMGBR := nTotCMGBR
	SB2->B2_YTCMG	:= nTotCMG
			                                  	
	SB2->(MsUnLock())

EndIf


RestArea(aArea)
Return