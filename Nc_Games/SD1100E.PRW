#INCLUDE "Protheus.ch"



/*/
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
北谀哪哪哪哪穆哪哪哪哪哪履哪哪哪履哪哪哪哪哪哪哪哪哪哪哪履哪哪穆哪哪哪哪哪勘�
北矲un噮o    � SF1100E � Autor 矼icrosiga			    � Data � 11/10/11 潮�
北媚哪哪哪哪呐哪哪哪哪哪聊哪哪哪聊哪哪哪哪哪哪哪哪哪哪哪聊哪哪牧哪哪哪哪哪幢�
北矰escri噮o � PE antes de exluir os itnes do documento de entrada	 	  潮�
北�			 �	  														  潮�
北�			 � 															  潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砈intaxe   � 							                                  潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌�
/*/

User Function SD1100E()

Local aArea := GetArea()

//Chamada da rotina para atualizar os valores do CMG BR e CMG PP na exclus鉶 do documento de entrada
UpdCMGB2(SD1->D1_COD, SD1->D1_LOCAL, SD1->D1_YCUSGER, SD1->D1_YCMGBR)	


RestArea(aArea)
Return        



/*/
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
北谀哪哪哪哪穆哪哪哪哪哪履哪哪哪履哪哪哪哪哪哪哪哪哪哪哪履哪哪穆哪哪哪哪哪勘�
北矲un噮o    � UpdCMGB2 � Autor 矼icrosiga			    � Data � 11/10/11 潮�
北媚哪哪哪哪呐哪哪哪哪哪聊哪哪哪聊哪哪哪哪哪哪哪哪哪哪哪聊哪哪牧哪哪哪哪哪幢�
北矰escri噮o � Atualiza o valor do CMG BR e CMG PP no saldo atual		  潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砈intaxe   � 							                                  潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌�
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
