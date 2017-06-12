#INCLUDE "PROTHEUS.CH"


/*
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
北谀哪哪哪哪穆哪哪哪哪哪履哪哪哪履哪哪哪哪哪哪哪哪哪哪哪履哪哪穆哪哪哪哪哪勘�
北矲un噮o    砇ProdSoft  � Autor 矱LTON SANTANA		    � Data � 02/09/13 潮�
北媚哪哪哪哪呐哪哪哪哪哪聊哪哪哪聊哪哪哪哪哪哪哪哪哪哪哪聊哪哪牧哪哪哪哪哪幢�
北矰escri噮o � Retorna os campos da tabela de acordo com o SX3		      潮�
北�			 � 												  			  潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北砈intaxe   � 							                                  潮�
北媚哪哪哪哪呐哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪哪幢�
北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北北�
哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌哌�
*/                         

User Function MT010EXC()
Local aArea 	:= GetArea()
Local cAliasZC3:=ZC3->( GetArea())
Local cMostSit	:= SB1->B1_XMOSTSI

U_PR121SB1(SB1->B1_COD,cMostSit) //Exclus鉶 do produto na tabela ZC3 - Itens que v鉶 para o Site

//Chama a rotina para excluir o produto software (Projeto Software e Midia)
MsgRun("Verificando se existe produto (Software) a ser exclu韉o... ","Aguarde..",{|| U_PEProdSoft(SB1->B1_COD, 5)  })


RestArea(cAliasZC3)
RestArea(aArea)
Return
